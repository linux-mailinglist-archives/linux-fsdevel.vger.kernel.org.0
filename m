Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3DE37AE85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 20:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhEKSfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEKSfL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 14:35:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A520C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 11:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DWUlSGjVXF6mP4whsK7xlVkZsL4DrFQ4rpcqIlOtSl0=; b=P0WzZ3mTU5Tvqi/P4vKhQj+ux5
        MnArOdmc9EaW+k8LTNgJzW3uNwqXiTr2tcpuRtv6zv0WjPGBodaM6SIx4MyIGlzkOiOSOJ9YeLFHn
        cjFDdGfLJoZEJf8mOLStJ3D5rS/3lY2UBg/+yX0SAM9mzcgiXEez2DEONFZ6uLZu5PFKvvYYr1Qnu
        Vhf9g5/mYBEFKX9J+TTe1024JJdVwOm7vKyS17MwaO9fcMYzaUtepPLGGoGJKhYEAMXJEiIpnXieH
        v+1chvryTQEmaXx+fUXsbfCINrA+KQ+PpN/IR1bdgUmXTIxgnBfP0dqxiJ61jmaYgFb4/gkuxgrqN
        ki24/85A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgXCa-007YUa-RD; Tue, 11 May 2021 18:33:54 +0000
Date:   Tue, 11 May 2021 19:33:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] vfs/dedupe: Pass file pointer to read_mapping_page
Message-ID: <YJrOEAnWxOrEgNz+@casper.infradead.org>
References: <20210511145608.1759501-1-willy@infradead.org>
 <20210511154056.GA8543@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511154056.GA8543@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 08:40:56AM -0700, Darrick J. Wong wrote:
> > -static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > -					 struct inode *dest, loff_t destoff,
> > +static int vfs_dedupe_file_range_compare(struct file *src, loff_t srcoff,
> > +					 struct file *dst, loff_t destoff,
> 
> I kinda wish you'd maintained the name pairing here.  Why does destoff
> go with dst instead of dst/dstoff or dest/destoff?
> 
> FWIW I try to vary the name lengths for similar variables these days,
> because while my eyes are /fairly/ quick to distingiush 's' and 'd',
> they're even faster if the width of the entire word is different.
> 
> (And yes, I had to break myself of the 'columns-must-line-up' habit.)
> 
> Using this method I've caught a few stupid variable name mixups in the
> exchange-range code by doing a quick scan while ld takes an eternity to
> link vmlinux together.

OK, if that's a preference you have, I'll redo it.  I have a later patch
as part of the folio work which rename destfoo to dstfoo, but now I know
that's a preference you have, I'll go back to dest.

> That aside, passing file pointers in seems like a good idea to me.

Cheers.  v2 coming up.
