Return-Path: <linux-fsdevel+bounces-69359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F303DC779B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id F30EC2BBEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740193328EC;
	Fri, 21 Nov 2025 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R2BU6Nop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3AC332907;
	Fri, 21 Nov 2025 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763707836; cv=none; b=CB2Tg6Y8fPPbg96gs5/g2x1TRDm/aQzELW5csiYdokFQJ4jHxDcn5L8ChS5Ccn7tVPOcwtFKXJK+ArBRg25tqhNHKTKW+zfoLFCdzU5Nu4EPlbpy5yliyPtIceHb4lfW2NOtvl7WZ5jc8pUGbt0ZSwlEblsrQf+iMg/dUAmbp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763707836; c=relaxed/simple;
	bh=Boh3AYZTWIm4evsvBtDYmxyijjhWa8vWA9Vc7bExy2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJVG5Igkppou2WA8XKOib5Axxkqfpa4bSUTt7M4EAt1ixzBbw0huy7MuFNC6vsGsYPCq61cyK3Vx+Lm1MxyvEnqqr8gu0i+u7F0PJ8Nc2JPtBl/ex8GQs+fR0+3RwKj02nz0FLklYdSrJ9sg6vahWz3FVROzq/gO3zFOvlFUR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R2BU6Nop; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vo2CYkxvIT2Wjjh88hsMNfehDmvCrW9LP6F7KKNOnOM=; b=R2BU6NopA+aJdjWX0pOQHAp99x
	KFL2tyCvJUebfU3KFAdDCgw/dfuwctywKfhlJhBccOKQ9/uuy28mzO8NUtzMR0H4sPH5HEV9SbnDY
	izyjpuxwmNYj2JnifkM2+Wh0I6wwXW9HQ8wXH2S8Nsbz2n8xO42lP5CAhvDnysJo+DCYAbsHr5+9D
	xqDgKZNV3+q2CjDickAQX/gbqJ2aGEImWMWVbXt/gSR45a9N2KzL3DKCs+T8CK69IOZHFWcqppOHc
	uwIMA/n5ubuPXy+p1ZD0uWLXqM6TuvjGKiU1z/cuBofNEhprXz2o5yYpBVbeZb5kuw+JmKJNP3mp7
	lKZEXKEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMKyS-00000007wM0-0d5O;
	Fri, 21 Nov 2025 06:50:28 +0000
Date: Thu, 20 Nov 2025 22:50:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] f2fs: add a way to change the desired readahead folio
 order
Message-ID: <aSALtF5Cty38G2UV@infradead.org>
References: <20251121014846.1971924-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121014846.1971924-1-jaegeuk@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 21, 2025 at 01:48:46AM +0000, Jaegeuk Kim wrote:
> This patch adds a sysfs entry to change the folio order for readahead.

You'll need to explain why this is useful.  And why this is f2fs
specific instead of generic.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c  | 1 +
>  fs/f2fs/f2fs.h  | 3 +++
>  fs/f2fs/super.c | 1 +
>  fs/f2fs/sysfs.c | 9 +++++++++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c80d7960b652..faf1faa27c41 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2764,6 +2764,7 @@ int f2fs_readahead_pages(struct file *file, loff_t offset, loff_t len)
>  	while (nrpages) {
>  		unsigned long this_chunk = min(nrpages, ra_pages);
>  
> +		ractl.ra->desired_order = F2FS_I_SB(inode)->ra_folio_order;
>  		ractl.ra->ra_pages = this_chunk;
>  
>  		page_cache_sync_ra(&ractl, this_chunk << 1);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 934287cc5624..0e61e253d861 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1921,6 +1921,9 @@ struct f2fs_sb_info {
>  	/* carve out reserved_blocks from total blocks */
>  	bool carve_out;
>  
> +	/* enable large folio. */
> +	unsigned int ra_folio_order;
> +
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	struct kmem_cache *page_array_slab;	/* page array entry */
>  	unsigned int page_array_slab_size;	/* default page array slab size */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d47ec718f3be..dabac6f288f0 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4287,6 +4287,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  			NAT_ENTRY_PER_BLOCK));
>  	sbi->allocate_section_hint = le32_to_cpu(raw_super->section_count);
>  	sbi->allocate_section_policy = ALLOCATE_FORWARD_NOHINT;
> +	sbi->ra_folio_order = 0;
>  	F2FS_ROOT_INO(sbi) = le32_to_cpu(raw_super->root_ino);
>  	F2FS_NODE_INO(sbi) = le32_to_cpu(raw_super->node_ino);
>  	F2FS_META_INO(sbi) = le32_to_cpu(raw_super->meta_ino);
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index c42f4f979d13..2537a25986a6 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -906,6 +906,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return count;
>  	}
>  
> +	if (!strcmp(a->attr.name, "ra_folio_order")) {
> +		if (t < 0 || t > MAX_PAGECACHE_ORDER)
> +			return -EINVAL;
> +		sbi->ra_folio_order = t;
> +		return count;
> +	}
> +
>  	*ui = (unsigned int)t;
>  
>  	return count;
> @@ -1180,6 +1187,7 @@ F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
>  F2FS_SBI_GENERAL_RW_ATTR(dir_level);
>  F2FS_SBI_GENERAL_RW_ATTR(allocate_section_hint);
>  F2FS_SBI_GENERAL_RW_ATTR(allocate_section_policy);
> +F2FS_SBI_GENERAL_RW_ATTR(ra_folio_order);
>  #ifdef CONFIG_F2FS_IOSTAT
>  F2FS_SBI_GENERAL_RW_ATTR(iostat_enable);
>  F2FS_SBI_GENERAL_RW_ATTR(iostat_period_ms);
> @@ -1422,6 +1430,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(reserved_pin_section),
>  	ATTR_LIST(allocate_section_hint),
>  	ATTR_LIST(allocate_section_policy),
> +	ATTR_LIST(ra_folio_order),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(f2fs);
> -- 
> 2.52.0.487.g5c8c507ade-goog
> 
> 
---end quoted text---

