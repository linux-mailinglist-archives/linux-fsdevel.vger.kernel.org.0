Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC134320B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Mar 2021 11:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCUKy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCUKx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 06:53:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476BAC061574;
        Sun, 21 Mar 2021 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IPWTpmNlwvQD2iMEaDZM4gbTBQw2JCKTcw+XHs6sAEA=; b=MycDLrIcd3ic8F/80A6VFdemDq
        mP6wMKgaJ+5fZ8A/5UZohpMbjrn0frButsf5ebBykDEX/RU1WPXs8HsON7xXx/0rh1H8iKU1zW2Bo
        gQnxM6q4iczEUtjYAhChY4xbcUghuUJ8SxLKS+Scas5RUAPIY1QVsjBRYZNB4Td9A/GdUbK+pGXzm
        ZxqPcKHFmjWFBOpIOxuPGE2Ge3lH75MgJq4zOA4kCUIW8QztYln6orsFPBg70IOQjgwHxMTUkpQvT
        sP5/cIEzN7DAaOGyHDRzy6+/swS96oUDvvYZzfmO85Y4+6qJHHEg0lpaPO9kP30HPHtXl8+ynO5/A
        9oZufQ3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNvhl-007173-MX; Sun, 21 Mar 2021 10:53:12 +0000
Date:   Sun, 21 Mar 2021 10:53:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for
 PG_private_2/PG_fscache
Message-ID: <20210321105309.GG3420@casper.infradead.org>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
 <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:54:49PM +0000, David Howells wrote:
> Add a function, unlock_page_private_2(), to unlock PG_private_2 analogous
> to that of PG_lock.  Add a kerneldoc banner to that indicating the example
> usage case.

One of the things which confused me about this was ... where's the other
side?  Where's lock_page_private_2()?  Then I found this:

#ifdef CONFIG_AFS_FSCACHE
        if (PageFsCache(page) &&
            wait_on_page_bit_killable(page, PG_fscache) < 0)
                return VM_FAULT_RETRY;
#endif

Please respect the comment!

/*
 * This is exported only for wait_on_page_locked/wait_on_page_writeback, etc.,
 * and should not be used directly.
 */
extern void wait_on_page_bit(struct page *page, int bit_nr);
extern int wait_on_page_bit_killable(struct page *page, int bit_nr);

I think we need the exported API to be wait_on_page_private_2(), and
AFS needs to not tinker in the guts of filemap.  Otherwise you miss
out on bugfixes like c2407cf7d22d0c0d94cf20342b3b8f06f1d904e7 (see also
https://lore.kernel.org/linux-fsdevel/20210320054104.1300774-4-willy@infradead.org/T/#u
).

That also brings up that there is no set_page_private_2().  I think
that's OK -- you only set PageFsCache() immediately after reading the
page from the server.  But I feel this "unlock_page_private_2" is actually
"clear_page_private_2" -- ie it's equivalent to writeback, not to lock.

> +++ b/mm/filemap.c
> @@ -1432,6 +1432,26 @@ void unlock_page(struct page *page)
>  }
>  EXPORT_SYMBOL(unlock_page);
>  
> +/**
> + * unlock_page_private_2 - Unlock a page that's locked with PG_private_2
> + * @page: The page
> + *
> + * Unlocks a page that's locked with PG_private_2 and wakes up sleepers in
> + * wait_on_page_private_2().
> + *
> + * This is, for example, used when a netfs page is being written to a local
> + * disk cache, thereby allowing writes to the cache for the same page to be
> + * serialised.
> + */
> +void unlock_page_private_2(struct page *page)
> +{
> +	page = compound_head(page);
> +	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
> +	clear_bit_unlock(PG_private_2, &page->flags);
> +	wake_up_page_bit(page, PG_private_2);
> +}
> +EXPORT_SYMBOL(unlock_page_private_2);
> +
>  /**
