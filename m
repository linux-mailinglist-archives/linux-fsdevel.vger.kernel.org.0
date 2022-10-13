Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA75FE1FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 20:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJMStu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiJMStB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:49:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E0402C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3xoNf+0i0Wwsex2WyHm3zgg3CN/Zg96KMahGgMkyboE=; b=UGJNPLPmxS1dbY0QmJ05uteqfw
        rd10IMN7vhO3bbxo/OKqrQvKEgYio+mh247BCGktfZXmODyQsmi6VAwkDHOIAQuSPu9xkJkFdmkBh
        98IxXIFqH1Nst6lmFaFiiQtMOwyrp4cMEHpCtO5C5RUUBC17nULbIkdtQSP35e/wSCis01f4Z51ip
        m7tS5Jp/OYU9I6WT2AokON3/ZCwUowXPeXQ4EkALajbGTZMLKWBp01oUzrua4/0cB7m+DBTp+SSQj
        KMryCBpcu09HJrkVBxct04f2yZShS5APLXKyTOPR84UTjEACmJRhySppAeszZA8s/w2iDKAWQINMh
        d3ey3y0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oj3Cg-006wOy-4n; Thu, 13 Oct 2022 18:45:10 +0000
Date:   Thu, 13 Oct 2022 19:45:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Frank Sorenson <fsorenso@redhat.com>
Subject: Re: [PATCH] fuse: fix readdir cache race
Message-ID: <Y0hctitwD+Nn6AL9@casper.infradead.org>
References: <20221013081657.3508759-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013081657.3508759-1-mszeredi@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 13, 2022 at 10:16:57AM +0200, Miklos Szeredi wrote:
> Willy,
> 
> delete_from_page_cache() exporting was just removed, and seems like it's
> deprecated in favor of the folio functions.  Should this code use the folio
> one and export that?  Is the code even correct to begin with?

In general, all filesystem code should be converted from pages to folios.
Whether you want to support multi-page folios is up to you; a little
more complexity but a performance win.

I'm not thrilled about exporting filemap_remove_folio() or
delete_from_page_cache().  At the very least, please make it _GPL.
What's the harm in leaving an extra page in the page cache, as long
as it's initialised?

> Thanks,
> Miklos
> 
> fs/fuse/readdir.c | 18 ++++++++++--------
>  mm/folio-compat.c |  1 +
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index b4e565711045..4284e28be2e8 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -65,25 +65,27 @@ static void fuse_add_dirent_to_cache(struct file *file,
>  		page = find_lock_page(file->f_mapping, index);
>  	} else {
>  		page = find_or_create_page(file->f_mapping, index,
> -					   mapping_gfp_mask(file->f_mapping));
> +				mapping_gfp_mask(file->f_mapping) | __GFP_ZERO);
>  	}
>  	if (!page)
>  		return;
>  
>  	spin_lock(&fi->rdc.lock);
> +	addr = kmap_local_page(page);
>  	/* Raced with another readdir */
>  	if (fi->rdc.version != version || fi->rdc.size != size ||
> -	    WARN_ON(fi->rdc.pos != pos))
> -		goto unlock;
> +	    WARN_ON(fi->rdc.pos != pos)) {
> +		/* Was this page just created? */
> +		if (!offset && !((struct fuse_dirent *) addr)->namelen)
> +			delete_from_page_cache(page);
> +		goto unmap;
> +	}
>  
> -	addr = kmap_local_page(page);
> -	if (!offset)
> -		clear_page(addr);
>  	memcpy(addr + offset, dirent, reclen);
> -	kunmap_local(addr);
>  	fi->rdc.size = (index << PAGE_SHIFT) + offset + reclen;
>  	fi->rdc.pos = dirent->off;
> -unlock:
> +unmap:
> +	kunmap_local(addr);
>  	spin_unlock(&fi->rdc.lock);
>  	unlock_page(page);
>  	put_page(page);
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index e1e23b4947d7..83aaffa6d701 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -128,6 +128,7 @@ void delete_from_page_cache(struct page *page)
>  {
>  	return filemap_remove_folio(page_folio(page));
>  }
> +EXPORT_SYMBOL(delete_from_page_cache);
>  
>  int try_to_release_page(struct page *page, gfp_t gfp)
>  {
> -- 
> 2.37.3
> 
