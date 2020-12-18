Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF852DEB64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 23:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgLRWEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 17:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgLRWEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 17:04:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B422DC0617A7;
        Fri, 18 Dec 2020 14:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O+QbNrh78hA5KmtKOcePMsglVoWsNZMDc49TSSNQhA0=; b=GM6eqK/umypeWAIdgProuMV0lX
        bx6tgq7AmnkTFXtzv6lvOxgk7YKFSpaoH4KbzdtDGi47nkdQgmAeuejJ9FntvxQ5Fn+LfrvPtwsQN
        ezIcGAUJ883zs6DZl7lzbACcBCbDFJjArjNOTpgtFbHHQQA7JhqJh+GvQVB72ORRw86bMQeyKdk7l
        ISRIO+t01LORQGbL8SgxW65akl7fXEY9pylolzEAWcmNEmXEXpWH4Gy4Jnhmudz5BZsCYnH+pc17r
        bPDkIhF9G51IvIoj9Dbs9m+lwl8ieGp14B1NTfg/ZyXxe04Hf+cf+0a0Gs98gpNMJjLTm1M+Efhvf
        Wcg8Uq/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqNqG-00068q-5I; Fri, 18 Dec 2020 22:03:16 +0000
Date:   Fri, 18 Dec 2020 22:03:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: set_page_dirty vs truncate
Message-ID: <20201218220316.GO15600@casper.infradead.org>
References: <20201218160531.GL15600@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218160531.GL15600@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 18, 2020 at 04:05:31PM +0000, Matthew Wilcox wrote:
> A number of implementations of ->set_page_dirty check whether the page
> has been truncated (ie page->mapping has become NULL since entering
> set_page_dirty()).  Several other implementations assume that they can do
> page->mapping->host to get to the inode.  So either some implementations
> are doing unnecessary checks or others are vulnerable to a NULL pointer
> dereference if truncate() races with set_page_dirty().
> 
> I'm touching ->set_page_dirty() anyway as part of the page folio
> conversion.  I'm thinking about passing in the mapping so there's no
> need to look at page->mapping.
> 
> The comments on set_page_dirty() and set_page_dirty_lock() suggests
> there's no consistency in whether truncation is blocked or not; we're
> only guaranteed that the inode itself won't go away.  But maybe the
> comments are stale.

The comments are, I believe, not stale.  Here's some syzbot
reports which indicate that ext4 is seeing races between set_page_dirty()
and truncate():

 https://groups.google.com/g/syzkaller-lts-bugs/c/s9fHu162zhQ/m/Phnf6ucaAwAJ

The reproducer includes calls to ftruncate(), so that would suggest
that's what's going on.

I would suggest just deleting this line:

        WARN_ON_ONCE(!page_has_buffers(page));

I'm not sure what value the other WARN_ON_ONCE adds.  Maybe just replace
ext4_set_page_dirty with __set_page_dirty_buffers in the aops?  I'd defer
to an ext4 expert on this ...
