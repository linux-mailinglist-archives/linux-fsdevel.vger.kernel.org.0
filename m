Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5BE31F496
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 06:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBSFKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 00:10:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhBSFKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 00:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613711354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XELPbrSVVRXSQJlygNes1MWCtjXaYPzMTU1cNnIrP7Q=;
        b=cK3RhlvBf1ViGeox58ri6uy+2NwJXc/ZNr69HbLF5/kG7v1lRe2biNJkPc2OzMLYX2NRds
        qnMwucHx/b0usTChyBYkMOVj7oePQ3sti2UJ876T58MTsFYzznziZ1JaNn7bF+HzwnuX5q
        P63/zFQjr/Werr6q2MlJ6XzJX7f/qaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-EDp9afNuMfKQJrNh8oq7ug-1; Fri, 19 Feb 2021 00:09:12 -0500
X-MC-Unique: EDp9afNuMfKQJrNh8oq7ug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C35780196C;
        Fri, 19 Feb 2021 05:09:11 +0000 (UTC)
Received: from [10.72.12.190] (ovpn-12-190.pek2.redhat.com [10.72.12.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E3092D035;
        Fri, 19 Feb 2021 05:09:04 +0000 (UTC)
Subject: Re: [PATCH v2 1/6] ceph: disable old fscache readpage handling
To:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <20210217125845.10319-1-jlayton@kernel.org>
 <20210217125845.10319-2-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <d6fcd45c-21eb-d00e-db8a-f2e9441d7f85@redhat.com>
Date:   Fri, 19 Feb 2021 13:09:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210217125845.10319-2-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/2/17 20:58, Jeff Layton wrote:
> With the new netfs read helper functions, we won't need a lot of this
> infrastructure as it handles the pagecache pages itself. Rip out the
> read handling for now, and much of the old infrastructure that deals in
> individual pages.
>
> The cookie handling is mostly unchanged, however.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Cc: ceph-devel@vger.kernel.org
> Cc: linux-cachefs@redhat.com
> Cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/ceph/addr.c  |  31 +-----------
>   fs/ceph/cache.c | 125 ------------------------------------------------
>   fs/ceph/cache.h |  91 +----------------------------------
>   fs/ceph/caps.c  |   9 ----
>   4 files changed, 3 insertions(+), 253 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 950552944436..2b17bb36e548 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -155,8 +155,6 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
>   		return;
>   	}
>   
> -	ceph_invalidate_fscache_page(inode, page);
> -
>   	WARN_ON(!PageLocked(page));
>   	if (!PagePrivate(page))
>   		return;
> @@ -175,10 +173,6 @@ static int ceph_releasepage(struct page *page, gfp_t g)
>   	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
>   	     page, page->index, PageDirty(page) ? "" : "not ");
>   
> -	/* Can we release the page from the cache? */
> -	if (!ceph_release_fscache_page(page, g))
> -		return 0;
> -
>   	return !PagePrivate(page);
>   }
>   
> @@ -213,10 +207,6 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
>   		return 0;
>   	}
>   
> -	err = ceph_readpage_from_fscache(inode, page);
> -	if (err == 0)
> -		return -EINPROGRESS;
> -
>   	dout("readpage ino %llx.%llx file %p off %llu len %llu page %p index %lu\n",
>   	     vino.ino, vino.snap, filp, off, len, page, page->index);
>   	req = ceph_osdc_new_request(osdc, &ci->i_layout, vino, off, &len, 0, 1,
> @@ -241,7 +231,6 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
>   	if (err == -ENOENT)
>   		err = 0;
>   	if (err < 0) {
> -		ceph_fscache_readpage_cancel(inode, page);
>   		if (err == -EBLOCKLISTED)
>   			fsc->blocklisted = true;
>   		goto out;
> @@ -253,8 +242,6 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
>   		flush_dcache_page(page);
>   
>   	SetPageUptodate(page);
> -	ceph_readpage_to_fscache(inode, page);
> -
>   out:
>   	return err < 0 ? err : 0;
>   }
> @@ -294,10 +281,8 @@ static void finish_read(struct ceph_osd_request *req)
>   	for (i = 0; i < num_pages; i++) {
>   		struct page *page = osd_data->pages[i];
>   
> -		if (rc < 0 && rc != -ENOENT) {
> -			ceph_fscache_readpage_cancel(inode, page);
> +		if (rc < 0 && rc != -ENOENT)
>   			goto unlock;
> -		}
>   		if (bytes < (int)PAGE_SIZE) {
>   			/* zero (remainder of) page */
>   			int s = bytes < 0 ? 0 : bytes;
> @@ -307,7 +292,6 @@ static void finish_read(struct ceph_osd_request *req)
>   		     page->index);
>   		flush_dcache_page(page);
>   		SetPageUptodate(page);
> -		ceph_readpage_to_fscache(inode, page);
>   unlock:
>   		unlock_page(page);
>   		put_page(page);
> @@ -408,7 +392,6 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
>   		     page->index);
>   		if (add_to_page_cache_lru(page, &inode->i_data, page->index,
>   					  GFP_KERNEL)) {
> -			ceph_fscache_uncache_page(inode, page);
>   			put_page(page);
>   			dout("start_read %p add_to_page_cache failed %p\n",
>   			     inode, page);
> @@ -440,10 +423,8 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
>   	return nr_pages;
>   
>   out_pages:
> -	for (i = 0; i < nr_pages; ++i) {
> -		ceph_fscache_readpage_cancel(inode, pages[i]);
> +	for (i = 0; i < nr_pages; ++i)
>   		unlock_page(pages[i]);
> -	}
>   	ceph_put_page_vector(pages, nr_pages, false);
>   out_put:
>   	ceph_osdc_put_request(req);
> @@ -471,12 +452,6 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
>   	if (ceph_inode(inode)->i_inline_version != CEPH_INLINE_NONE)
>   		return -EINVAL;
>   
> -	rc = ceph_readpages_from_fscache(mapping->host, mapping, page_list,
> -					 &nr_pages);
> -
> -	if (rc == 0)
> -		goto out;
> -
>   	rw_ctx = ceph_find_rw_context(fi);
>   	max = fsc->mount_options->rsize >> PAGE_SHIFT;
>   	dout("readpages %p file %p ctx %p nr_pages %d max %d\n",
> @@ -487,8 +462,6 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
>   			goto out;
>   	}
>   out:
> -	ceph_fscache_readpages_cancel(inode, page_list);
> -
>   	dout("readpages %p file %p ret %d\n", inode, file, rc);
>   	return rc;
>   }
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 2f5cb6bc78e1..9cfadbb86568 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -173,7 +173,6 @@ void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci)
>   
>   	ci->fscache = NULL;
>   
> -	fscache_uncache_all_inode_pages(cookie, &ci->vfs_inode);
>   	fscache_relinquish_cookie(cookie, &ci->i_vino, false);
>   }
>   
> @@ -194,7 +193,6 @@ void ceph_fscache_file_set_cookie(struct inode *inode, struct file *filp)
>   		dout("fscache_file_set_cookie %p %p disabling cache\n",
>   		     inode, filp);
>   		fscache_disable_cookie(ci->fscache, &ci->i_vino, false);
> -		fscache_uncache_all_inode_pages(ci->fscache, inode);
>   	} else {
>   		fscache_enable_cookie(ci->fscache, &ci->i_vino, i_size_read(inode),
>   				      ceph_fscache_can_enable, inode);
> @@ -205,108 +203,6 @@ void ceph_fscache_file_set_cookie(struct inode *inode, struct file *filp)
>   	}
>   }
>   
> -static void ceph_readpage_from_fscache_complete(struct page *page, void *data, int error)
> -{
> -	if (!error)
> -		SetPageUptodate(page);
> -
> -	unlock_page(page);
> -}
> -
> -static inline bool cache_valid(struct ceph_inode_info *ci)
> -{
> -	return ci->i_fscache_gen == ci->i_rdcache_gen;
> -}
> -

Hi Jeff,

Please delete the "i_fscache_gen" member from the struct ceph_inode_info 
if we are not using it any more.

Thanks

Xiubo


