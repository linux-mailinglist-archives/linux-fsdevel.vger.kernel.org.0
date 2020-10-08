Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D527028772A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbgJHPai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 11:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730977AbgJHPai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602171037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBdS920Wg4eEWu1R0a6u/lkZLtobuePIsMDu1AdO+oY=;
        b=iUlKzuCcxJG+SC5ESmG6mvtsIj9fjUyGnUT9/B5hqK7TOfNBGU9AFwNT/fVTa91WHGNdB7
        ZkQ8mWleTKFnq2JR+RvmzBjD18csG/4TXqqm3x4O3Siu6HldUa4ip3QuVmbS8Kgm5D+DP4
        BsDtSpqslOBoX3kmV3AudbhPFRE/Ik4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-b1o9M-55P6aIsRoAtR6HtQ-1; Thu, 08 Oct 2020 11:30:33 -0400
X-MC-Unique: b1o9M-55P6aIsRoAtR6HtQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9520180402A;
        Thu,  8 Oct 2020 15:30:31 +0000 (UTC)
Received: from redhat.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96DA760BFA;
        Thu,  8 Oct 2020 15:30:30 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:30:28 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 00/14] Small step toward KSM for file back page.
Message-ID: <20201008153028.GA3508856@redhat.com>
References: <20201007010603.3452458-1-jglisse@redhat.com>
 <20201007032013.GS20115@casper.infradead.org>
 <20201007144835.GA3471400@redhat.com>
 <20201007170558.GU20115@casper.infradead.org>
 <20201007175419.GA3478056@redhat.com>
 <20201007220916.GX20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007220916.GX20115@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:09:16PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 07, 2020 at 01:54:19PM -0400, Jerome Glisse wrote:
> > > For other things (NUMA distribution), we can point to something which
> > > isn't a struct page and can be distiguished from a real struct page by a
> > > bit somewhere (I have ideas for at least three bits in struct page that
> > > could be used for this).  Then use a pointer in that data structure to
> > > point to the real page.  Or do NUMA distribution at the inode level.
> > > Have a way to get from (inode, node) to an address_space which contains
> > > just regular pages.
> > 
> > How do you find all the copies ? KSM maintains a list for a reasons.
> > Same would be needed here because if you want to break the write prot
> > you need to find all the copy first. If you intend to walk page table
> > then how do you synchronize to avoid more copy to spawn while you
> > walk reverse mapping, we could lock the struct page i guess. Also how
> > do you walk device page table which are completely hidden from core mm.
> 
> So ... why don't you put a PageKsm page in the page cache?  That way you
> can share code with the current KSM implementation.  You'd need
> something like this:

I do just that but there is no need to change anything in page cache.
So below code is not necessary. What you need is a way to find all
the copies so if you have a write fault (or any write access) then
from that fault you get the mapping and offset and you use that to
lookup the fs specific informations and de-duplicate the page with
new page and the fs specific informations. Hence the filesystem code
do not need to know anything it all happens in generic common code.

So flow is:

  Same as before:
    1 - write fault (address, vma)
    2 - regular write fault handler -> find page in page cache

  New to common page fault code:
    3 - ksm check in write fault common code (same as ksm today
        for anonymous page fault code path).
    4 - break ksm (address, vma) -> (file offset, mapping)
        4.a - use mapping and file offset to lookup the proper
              fs specific information that were save when the
              page was made ksm.
        4.b - allocate new page and initialize it with that
              information (and page content), update page cache
              and mappings ie all the pte who where pointing to
              the ksm for that mapping at that offset to now use
              the new page (like KSM for anonymous page today).

  Resume regular code path:
        mkwrite /|| set pte ...

Roughly the same for write ioctl (other cases goes through GUP
which itself goes through page fault code path). There is no
need to change page cache in anyway. Just common code path that
enable write to file back page.

The fs specific information is page->private, some of the flags
(page->flags) and page->indexi (file offset). Everytime a page
is deduplicated a copy of that information is save in an alias
struct which you can get to from the the share KSM page (page->
mapping is a pointer to ksm root struct which has a pointer to
list of all aliases).

> 
> +++ b/mm/filemap.c
> @@ -1622,6 +1622,9 @@ struct page *find_lock_entry(struct address_space *mapping
> , pgoff_t index)
>                 lock_page(page);
>                 /* Has the page been truncated? */
>                 if (unlikely(page->mapping != mapping)) {
> +                       if (PageKsm(page)) {
> +                               ...
> +                       }
>                         unlock_page(page);
>                         put_page(page);
>                         goto repeat;
> @@ -1655,6 +1658,7 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t index)
>   * * %FGP_WRITE - The page will be written
>   * * %FGP_NOFS - __GFP_FS will get cleared in gfp mask
>   * * %FGP_NOWAIT - Don't get blocked by page lock
> + * * %FGP_KSM - Return KSM pages
>   *
>   * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
>   * if the %GFP flags specified for %FGP_CREAT are atomic.
> @@ -1687,6 +1691,11 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
>  
>                 /* Has the page been truncated? */
>                 if (unlikely(page->mapping != mapping)) {
> +                       if (PageKsm(page) {
> +                               if (fgp_flags & FGP_KSM)
> +                                       return page;
> +                               ...
> +                       }
>                         unlock_page(page);
>                         put_page(page);
>                         goto repeat;
> 
> I don't know what you want to do when you find a KSM page, so I just left
> an ellipsis.
> 

