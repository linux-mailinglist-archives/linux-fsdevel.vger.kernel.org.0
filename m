Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0531934602D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 14:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhCWNwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 09:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhCWNwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:52:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B58C061574;
        Tue, 23 Mar 2021 06:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BH51iSUzyg9KZ7syxnXQS3KRs906Uf9wJkKS6a1BsxQ=; b=angZPyAg1GkZnw395mQ1H2hSyZ
        8FOuwPttbyu8A1w79GjNbJ2Ieum4ZYQv23Oe3ZuJALNa7bX50chua3/7bvzuk2g4H8GOUuRC6/PQM
        Hq5J51thoR+VeXDXKg67FA4Pp9G5lzX1rTN9EnLPIxEtzEC9ankHhUyPM0E8SxgpjkNXcMH1Yz4Tt
        DDw3C28/GiSWV2VPdA5FotyoAThZeYb6ZrknqHo9PTiqk61ys+mhrvVoFqtF28H8htXQUl2cco69T
        loCYl4Ngxp2H7mit+LkiOZ0FHezZ4vUaS/YRmBAzfLodBDRcJm+pu8DFMhBrYUhI5bzW/qIwD/IRL
        XBhU3HsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOhRE-00A7tp-Gh; Tue, 23 Mar 2021 13:51:19 +0000
Date:   Tue, 23 Mar 2021 13:51:16 +0000
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
Message-ID: <20210323135116.GF1719932@casper.infradead.org>
References: <1885296.1616410586@warthog.procyon.org.uk>
 <20210321105309.GG3420@casper.infradead.org>
 <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
 <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
 <2499407.1616505440@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2499407.1616505440@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 01:17:20PM +0000, David Howells wrote:
> +++ b/fs/afs/write.c
> @@ -846,7 +846,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
>  	 */
>  #ifdef CONFIG_AFS_FSCACHE
>  	if (PageFsCache(page) &&
> -	    wait_on_page_bit_killable(page, PG_fscache) < 0)
> +	    wait_on_page_fscache_killable(page) < 0)
>  		return VM_FAULT_RETRY;
>  #endif
>  
> @@ -861,7 +861,8 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
>  	 * details the portion of the page we need to write back and we might
>  	 * need to redirty the page if there's a problem.
>  	 */
> -	wait_on_page_writeback(page);
> +	if (wait_on_page_writeback_killable(page) < 0)
> +		return VM_FAULT_RETRY | VM_FAULT_LOCKED;

You forgot to unlock the page.  Also, if you're waiting killably here,
do you need to wait before you get the page lock?  Ditto for waiting on
fscache -- do you want to do that before or after you get the page lock?

Also, I never quite understood why you needed to wait for fscache
writes to finish before allowing the page to be dirtied.  Is this a
wait_for_stable_page() kind of situation, where the cache might be
calculating a checksum on it?  Because as far as I can tell, once the
page is dirty in RAM, the contents of the on-disk cache are irrelevant ...
unless they're part of a RAID 5 checksum kind of situation.

I didn't spot any other problems ...
