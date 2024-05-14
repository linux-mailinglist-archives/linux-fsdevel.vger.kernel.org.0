Return-Path: <linux-fsdevel+bounces-19468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91F68C5B88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 21:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6321F230A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 19:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D9181302;
	Tue, 14 May 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHv8Qsc5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3317EBA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713936; cv=none; b=iYGVG5N2BGr7rXYAWET79QhP1HVHQebXxUK4PjkyjZxTwS/MuzzC638zHmogmPEaJLkauKCe24eF1+yAhKfvcxlmsVEA2sz63gzoVtdCyc62xMwqiyyKHv+WKwUZLlz7oaawVdrwiHwkmdOrtEHuvQi5XbeUO4T8Howaigd5t5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713936; c=relaxed/simple;
	bh=GSAh8xbKfCp+tzPmbMgpT8DTFC4Dvnc72BWaMt/Plr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2utmGGRpOa8cAH0bmMwWK0mSGRkxl/nQbI1YPtR9pX+HN9EYL7Dxkb82BeBXhehGa2NUrwsJ6vhCgGeSJ9GY5i602xhpJxydfCRuNZ3yoJPXwB/uUAHR/s8dDttg0GV9p7M7fNtascjnPYlgWIxJSgoDqPWuCsGfEqJPyx0jMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHv8Qsc5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715713933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2iU2/EFLDYYzNrhgJhaZBZTvv5MXAraDW5xCto7BpQ=;
	b=FHv8Qsc5285O4a4EgJ/CUXNuDhcRsiB1nAXVppdHH1pgM/3P+QR/VyHIEnuP4XsuChaO6d
	PO9PwXTirG96Lng03urOLBclO8Bq2uIU1ixhOIAEC9F8f7boItmF41sFT1NIBVoLVJDo6E
	pRrUIvZLHhE9SNbA3ST4qXhEnXJf9PE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-3StEfRJWNReZ2nrYnrFi9g-1; Tue, 14 May 2024 15:12:12 -0400
X-MC-Unique: 3StEfRJWNReZ2nrYnrFi9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5EE31848630;
	Tue, 14 May 2024 19:12:11 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.71])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ABF24184CC0;
	Tue, 14 May 2024 19:12:11 +0000 (UTC)
Date: Tue, 14 May 2024 14:12:09 -0500
From: Bill O'Donnell <bodonnel@redhat.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-fsdevel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
Message-ID: <ZkO3iZFIKQsdIaEY@redhat.com>
References: <20240514152208.26935-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514152208.26935-1-jth@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Tue, May 14, 2024 at 05:22:08PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Move reading of the on-disk superblock from page to kmalloc()ed memory.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks fine.
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>


> ---
>  fs/zonefs/super.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index faf1eb87895d..ebea18da6759 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1111,28 +1111,28 @@ static int zonefs_read_super(struct super_block *sb)
>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  	struct zonefs_super *super;
>  	u32 crc, stored_crc;
> -	struct page *page;
>  	struct bio_vec bio_vec;
>  	struct bio bio;
> +	struct folio *folio;
>  	int ret;
>  
> -	page = alloc_page(GFP_KERNEL);
> -	if (!page)
> +	super = kzalloc(ZONEFS_SUPER_SIZE, GFP_KERNEL);
> +	if (!super)
>  		return -ENOMEM;
>  
> +	folio = virt_to_folio(super);
>  	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
>  	bio.bi_iter.bi_sector = 0;
> -	__bio_add_page(&bio, page, PAGE_SIZE, 0);
> +	bio_add_folio_nofail(&bio, folio, ZONEFS_SUPER_SIZE,
> +			     offset_in_folio(folio, super));
>  
>  	ret = submit_bio_wait(&bio);
>  	if (ret)
> -		goto free_page;
> -
> -	super = page_address(page);
> +		goto free_super;
>  
>  	ret = -EINVAL;
>  	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
> -		goto free_page;
> +		goto free_super;
>  
>  	stored_crc = le32_to_cpu(super->s_crc);
>  	super->s_crc = 0;
> @@ -1140,14 +1140,14 @@ static int zonefs_read_super(struct super_block *sb)
>  	if (crc != stored_crc) {
>  		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
>  			   crc, stored_crc);
> -		goto free_page;
> +		goto free_super;
>  	}
>  
>  	sbi->s_features = le64_to_cpu(super->s_features);
>  	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
>  		zonefs_err(sb, "Unknown features set 0x%llx\n",
>  			   sbi->s_features);
> -		goto free_page;
> +		goto free_super;
>  	}
>  
>  	if (sbi->s_features & ZONEFS_F_UID) {
> @@ -1155,7 +1155,7 @@ static int zonefs_read_super(struct super_block *sb)
>  				       le32_to_cpu(super->s_uid));
>  		if (!uid_valid(sbi->s_uid)) {
>  			zonefs_err(sb, "Invalid UID feature\n");
> -			goto free_page;
> +			goto free_super;
>  		}
>  	}
>  
> @@ -1164,7 +1164,7 @@ static int zonefs_read_super(struct super_block *sb)
>  				       le32_to_cpu(super->s_gid));
>  		if (!gid_valid(sbi->s_gid)) {
>  			zonefs_err(sb, "Invalid GID feature\n");
> -			goto free_page;
> +			goto free_super;
>  		}
>  	}
>  
> @@ -1173,14 +1173,14 @@ static int zonefs_read_super(struct super_block *sb)
>  
>  	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
>  		zonefs_err(sb, "Reserved area is being used\n");
> -		goto free_page;
> +		goto free_super;
>  	}
>  
>  	import_uuid(&sbi->s_uuid, super->s_uuid);
>  	ret = 0;
>  
> -free_page:
> -	__free_page(page);
> +free_super:
> +	kfree(super);
>  
>  	return ret;
>  }
> -- 
> 2.35.3
> 
> 


