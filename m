Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84FF1B193B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 00:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDTWO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 18:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgDTWO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:14:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661DEC061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=4cy2nicD54RdFxFlkOql6PT20Lca8D8SAOxtSFRsuWU=; b=DRtpcfWV24V2l/APTj0VQmLKkx
        DYEpNTg2Jmy8X/ZmCPSkGUff1t44SHRhnNXYoZZFPA96xEYXvmc0AKtSZzE0UrcCqDDWGb4Vlrcd8
        NIYtcLupVyqk0QS1YIMlIobjFtZz2jIo4L4R2UHV4KUORKo1bekZH2bbvw2cdE9dI3dlih2lEHRnb
        XW1Lu2SkJyTm9Ybng/sOufduQxKAlL9tEl/9Lmi7EbL876jwSGrT6vq8/cdHeJIpgaxVvF51Yirym
        3lWiKwXut1Efr2eBXF4+0bO76tGRvLWUZ2QX7/e2ohQ5TGkyLGO9lRo9pzEK913GXyyO6TApUDN+Y
        JXfbh0FA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQegK-0007dq-Kr; Mon, 20 Apr 2020 22:14:24 +0000
Date:   Mon, 20 Apr 2020 15:14:24 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] export __clear_page_buffers to cleanup code
Message-ID: <20200420221424.GH5820@bombadil.infradead.org>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200419031443.GT5820@bombadil.infradead.org>
 <20200419232046.GC9765@dread.disaster.area>
 <20200420003025.GZ5820@bombadil.infradead.org>
 <e889cb45-486b-118c-d087-90fed5353460@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e889cb45-486b-118c-d087-90fed5353460@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:14:35PM +0200, Guoqing Jiang wrote:
> On 20.04.20 02:30, Matthew Wilcox wrote:
> > On Mon, Apr 20, 2020 at 09:20:46AM +1000, Dave Chinner wrote:
> > > Anyone expecting to use set/clear_page_private as a matched pair (as
> > > the names suggest they are) is in for a horrible surprise...
> 
> Dave, thanks for the valuable suggestion!
> 
> > Oh, blast.  I hadn't noticed that.  And we're horribly inconsistent
> > with how we use set_page_private() too -- rb_alloc_aux_page() doesn't
> > increment the page's refcount, for example.
> > 
> > So, new (pair of) names:
> > 
> > set_fs_page_private()
> > clear_fs_page_private()
> 
> Hmm, maybe it is better to keep the original name (set/clear_page_private).

No.  Changing the semantics of set_page_private() without changing the
function signature is bad because it makes patches silently break when
applied to trees on either side of the change.  So we need a new name.

> 1. it would be weird for other subsystems (not belong to fs scope) to call
> the
> function which is supposed to be used in fs, though we can add a wrapper
> for other users out of fs.
> 
> 2. no function in mm.h is named like *fs*.

perhaps it should be in pagemap.h since it's for pagecache pages.

> > since it really seems like it's only page cache pages which need to
> > follow the rules about setting PagePrivate and incrementing the refcount.
> > Also, I think I'd like to see them take/return a void *:
> > 
> > void *set_fs_page_private(struct page *page, void *data)
> > {
> > 	get_page(page);
> > 	set_page_private(page, (unsigned long)data);
> > 	SetPagePrivate(page);
> > 	return data;
> > }
> 
> Seems  some functions could probably use the above helper, such as
> iomap_page_create, iomap_migrate_page, get_page_bootmem and
>  f2fs_set_page_private etc.

Yes.

> Really appreciate for your input though the thing is a little beyond my
> original intention ;-), will try to send a new version after reading more
> fs code.

That's kind of the way things go ... you start pulling on one thread
and all of a sudden, you're weaving a new coat ;-)
