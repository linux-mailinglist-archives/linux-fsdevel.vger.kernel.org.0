Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0E82DFD5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 16:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgLUPRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 10:17:20 -0500
Received: from casper.infradead.org ([90.155.50.34]:42962 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgLUPRU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 10:17:20 -0500
X-Greylist: delayed 1078 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2020 10:17:19 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BLzw6+zjh2rdSHdmNGpYDXRXsmUwYCvcQt9chPzOa7U=; b=t79vddqgv5Z/JEAuj+pP7dMB+z
        rFsHF/unk8uEwlNNGR6rOV/bmVbEQ3JaisuqyzR8cplsVbCj7+le3vcpa2EKrQ16CEiUqHCiH5rA9
        xMaue/iFO4x35e5Rq4MiHWFAWF4grGL83O94mgcB6iCv+di+S/mlmKgBaUXFqICXhZF6G5hDrU5H7
        o7tUTpF7K7dEbZIX3ut0PuNEpqzuqnXkDzIKW7xB3ph2xdfdSxIW6ha5FvFBM/1bZYtFPyCYQCkHq
        DBBGITOliGDA2SaTdAefd8iUY0s8VKP9kVDfLezJWbdoQ/K1AVgVXECaPD/pyl0CMi7d2ZasDQ+7Q
        VsAvXPJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krMdv-0002jS-RL; Mon, 21 Dec 2020 14:58:35 +0000
Date:   Mon, 21 Dec 2020 14:58:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: set_page_dirty vs truncate
Message-ID: <20201221145835.GB874@casper.infradead.org>
References: <20201218160531.GL15600@casper.infradead.org>
 <20201218220316.GO15600@casper.infradead.org>
 <20201221141257.GC13601@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221141257.GC13601@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 21, 2020 at 03:12:57PM +0100, Jan Kara wrote:
> But overall even with GUP woes fixed up, set_page_dirty() called by a PUP
> user could still see already truncated page. So it has to deal with it.

Thanks!  That was really helpful.  We have a number of currently-buggy
filesystems which assume they can do inode = page->mapping->host without
checking that page->mapping is not NULL.

Anyway, since I'm changing the set_page_dirty signature for folios,
this feels like the right time to pass in the page's mapping.
__set_page_dirty() rechecks the mapping under the i_pages lock, so we
won't do anything inappropriate if the page has been truncated.

You can find the whole thing at
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio

but the important bit is:

-       /* Set a page dirty.  Return true if this dirtied it */
-       int (*set_page_dirty)(struct page *page);
+       /* Set a folio dirty.  Return true if this dirtied it */
+       bool (*set_page_dirty)(struct address_space *, struct folio *);

I'm kind of tempted to rename it to ->dirty_folio(), but I'm also fine
with leaving it this way.

