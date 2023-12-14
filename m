Return-Path: <linux-fsdevel+bounces-6054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47C8812F8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 12:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605BE283142
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0168F4121E;
	Thu, 14 Dec 2023 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvqSNF9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F863126;
	Thu, 14 Dec 2023 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702555109; x=1734091109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cV5kj31cFE9+FQFlEfWw+Csb+q1VhY9EQYtyWEoQyM8=;
  b=DvqSNF9ZV+DA3WB8sFcwY2O2wlZsdMYYnrUrMEMTIxyvZhG59Jgx14y8
   kVcdsYdCmOpy3W49qLH9WAJBAhSiS9QyKgM/L8wZQEow3Bhp9DPTGvQcz
   6x1V0H6V9nFSiZBORhhmUNERxqNzaNM2AxVlGHyAgAiX/3eTWe5aI2nmc
   v6abeO0JAIRd6LLVDQnigvrcU/tvOvkhH15/69qbLAOcE6Fq2qqXnRkW7
   2QkLmKn5PCkWUxd2YLdyDOW7k1iWAnsfHdz9dpbNdSMadTcmKY5YXsfB3
   hf80uFjasUPA6MQS/LDCCoGNAAflOuyUhoNvEDOkWP5lTTf4HPhXYVj6o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="461573436"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="461573436"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:58:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="17715249"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.7.207])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:58:27 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] minixfs: change the signature of dir_get_page()
Date: Thu, 14 Dec 2023 12:58:24 +0100
Message-ID: <4222956.ElGaqSPkdT@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20231213000849.2748576-2-viro@zeniv.linux.org.uk>
References:
 <20231213000656.GI1674809@ZenIV>
 <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
 <20231213000849.2748576-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 13 December 2023 01:08:47 CET Al Viro wrote:
> Change the signature of dir_get_page() in order to prepare this function
> to the conversion to the use of kmap_local_page(). Change also those call
> sites which are required to adjust to the new signature.
> 
> Essentially a copy of the corresponding fs/sysv commit by
> Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/minix/dir.c | 46 ++++++++++++++++++++--------------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)

Reviewed-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

> diff --git a/fs/minix/dir.c b/fs/minix/dir.c
> index 34a5d17f0796..4e5483adea40 100644
> --- a/fs/minix/dir.c
> +++ b/fs/minix/dir.c
> @@ -70,13 +70,15 @@ static int minix_handle_dirsync(struct inode *dir)
>  	return err;
>  }
> 
> -static struct page * dir_get_page(struct inode *dir, unsigned long n)
> +static void *dir_get_page(struct inode *dir, unsigned long n, struct page
> **p) {
>  	struct address_space *mapping = dir->i_mapping;
>  	struct page *page = read_mapping_page(mapping, n, NULL);
> -	if (!IS_ERR(page))
> -		kmap(page);
> -	return page;
> +	if (IS_ERR(page))
> +		return ERR_CAST(page);
> +	kmap(page);
> +	*p = page;
> +	return page_address(page);
>  }
> 
>  static inline void *minix_next_entry(void *de, struct minix_sb_info *sbi)
> @@ -104,11 +106,11 @@ static int minix_readdir(struct file *file, struct
> dir_context *ctx)
> 
>  	for ( ; n < npages; n++, offset = 0) {
>  		char *p, *kaddr, *limit;
> -		struct page *page = dir_get_page(inode, n);
> +		struct page *page;
> 
> -		if (IS_ERR(page))
> +		kaddr = dir_get_page(inode, n, &page);
> +		if (IS_ERR(kaddr))
>  			continue;
> -		kaddr = (char *)page_address(page);
>  		p = kaddr+offset;
>  		limit = kaddr + minix_last_byte(inode, n) - chunk_size;
>  		for ( ; p <= limit; p = minix_next_entry(p, sbi)) {
> @@ -173,11 +175,10 @@ minix_dirent *minix_find_entry(struct dentry *dentry,
> struct page **res_page) for (n = 0; n < npages; n++) {
>  		char *kaddr, *limit;
> 
> -		page = dir_get_page(dir, n);
> -		if (IS_ERR(page))
> +		kaddr = dir_get_page(dir, n, &page);
> +		if (IS_ERR(kaddr))
>  			continue;
> 
> -		kaddr = (char*)page_address(page);
>  		limit = kaddr + minix_last_byte(dir, n) - sbi->s_dirsize;
>  		for (p = kaddr; p <= limit; p = minix_next_entry(p, sbi)) {
>  			if (sbi->s_version == MINIX_V3) {
> @@ -229,12 +230,10 @@ int minix_add_link(struct dentry *dentry, struct inode
> *inode) for (n = 0; n <= npages; n++) {
>  		char *limit, *dir_end;
> 
> -		page = dir_get_page(dir, n);
> -		err = PTR_ERR(page);
> -		if (IS_ERR(page))
> -			goto out;
> +		kaddr = dir_get_page(dir, n, &page);
> +		if (IS_ERR(kaddr))
> +			return PTR_ERR(kaddr);
>  		lock_page(page);
> -		kaddr = (char*)page_address(page);
>  		dir_end = kaddr + minix_last_byte(dir, n);
>  		limit = kaddr + PAGE_SIZE - sbi->s_dirsize;
>  		for (p = kaddr; p <= limit; p = minix_next_entry(p, sbi)) {
> @@ -286,7 +285,6 @@ int minix_add_link(struct dentry *dentry, struct inode
> *inode) err = minix_handle_dirsync(dir);
>  out_put:
>  	dir_put_page(page);
> -out:
>  	return err;
>  out_unlock:
>  	unlock_page(page);
> @@ -375,11 +373,10 @@ int minix_empty_dir(struct inode * inode)
>  	for (i = 0; i < npages; i++) {
>  		char *p, *kaddr, *limit;
> 
> -		page = dir_get_page(inode, i);
> -		if (IS_ERR(page))
> +		kaddr = dir_get_page(inode, i, &page);
> +		if (IS_ERR(kaddr))
>  			continue;
> 
> -		kaddr = (char *)page_address(page);
>  		limit = kaddr + minix_last_byte(inode, i) - sbi->s_dirsize;
>  		for (p = kaddr; p <= limit; p = minix_next_entry(p, sbi)) {
>  			if (sbi->s_version == MINIX_V3) {
> @@ -441,15 +438,12 @@ int minix_set_link(struct minix_dir_entry *de, struct
> page *page,
> 
>  struct minix_dir_entry * minix_dotdot (struct inode *dir, struct page **p)
>  {
> -	struct page *page = dir_get_page(dir, 0);
>  	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
> -	struct minix_dir_entry *de = NULL;
> +	struct minix_dir_entry *de = dir_get_page(dir, 0, p);
> 
> -	if (!IS_ERR(page)) {
> -		de = minix_next_entry(page_address(page), sbi);
> -		*p = page;
> -	}
> -	return de;
> +	if (!IS_ERR(de))
> +		return minix_next_entry(de, sbi);
> +	return NULL;
>  }
> 
>  ino_t minix_inode_by_name(struct dentry *dentry)





