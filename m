Return-Path: <linux-fsdevel+bounces-15879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727FB8955B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FB31F221FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9B182893;
	Tue,  2 Apr 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V70YIryX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E180BEE
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065486; cv=none; b=RPu729CjkGw5artdcZfZs8hoeDqgc+XjCPHlvKzUMxcnEW+zpuTh9cslMKE8Er6nYEm65tZ9ghMYMjfdzwk1IHZ6KVzdI31kmDEH263tNgNVj3sSO4xtzCBSuS+QuTHaRex0F/4KJd9NmGakimvwbTn35IcWm5Vd5Uaru7f8/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065486; c=relaxed/simple;
	bh=SIArLVUDiFNY3hVGncu+PytHFdeKvFE0fJK76TNQAjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHfQLUlCZ6y4CvLvBKPdcc4/wT1g3ju17bqylxt9Ump/W04z7vN0RLrpvV2dEvWeuBf9PCwKohg5CE+rL73beEyGvhU59y2DMIFoVpCbvHY+cpGr7kAHBBoIjaRKkh9Elr/eB/5MNYLyiYU87CEqNy74+pPYKxN+jU2ZR7V/YvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V70YIryX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712065484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZCJuoqC4xW+HEtvtzls9a4rpC5/GEvrSeKVyrktLa4=;
	b=V70YIryXrrnDNBqU9WcoIPxsiS+kgjxFFe1+B+yxm8i3mPkhJ4rZxSxZvTZ0aLb/2yU549
	T5p1CNtnh3W7vsSX9877gj1INxjmT70OKV0fazl49aMPE1ELPoxWTOfC0G9PUFVw3+Pd1K
	x+aXTFEA92FYG61a9VuIkUIKXMtwHto=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-aCrvwARCPRWHyS4dqod3Lg-1; Tue, 02 Apr 2024 09:44:42 -0400
X-MC-Unique: aCrvwARCPRWHyS4dqod3Lg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5684345c0ebso7117210a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 06:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065481; x=1712670281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZCJuoqC4xW+HEtvtzls9a4rpC5/GEvrSeKVyrktLa4=;
        b=kDJNSYoX0MpFFN4gZ+wIbWTLruPDESRNUxYJjEEaR6AqbVoEjd3Bz16vDvr6+5xYvy
         FZYs+ZSwAFeKH7B1uhGFk3Yr7yOub2BnU+PQ6tg36VvE5WMJ/6tcPMG9aOKwzdfrdT71
         KJgSlBXBKQBxMdR3hZ7O8ya0nHpyrveNcrdtP/BpOgdANXcuBKE+sZJ+rUss4A9dtMaS
         STuY9e0vuaCsZEiQVlLBPZ0cBEW0gNU6BmwIkJEn80IjRs0XcbynvCkktk8jDqidLU4P
         +i0YP8Kpjb1lcn9E6xLbHIgrO/Ta2C/DBnl2G4ToXFm30u5rRc7jf5TYojyj5pnGp+De
         tYNw==
X-Forwarded-Encrypted: i=1; AJvYcCVpfu7ubYSoEWuxOVoihY4fPgR4A+qvID8kwF8lXNJRqdIJy2WqO+drzKLnzGWopymuNP3Jpml181FeKc5gdfxuJlXZyqdrWDbuXg1M1g==
X-Gm-Message-State: AOJu0Yxy6+azuBjhcRDOaa2t+RvLae1ofJMuMiv81h71W/ZmwpLhMCPu
	oGRwjNIoq90x2bgF4kyU729R9LXTKC2g3hZP0K5DQm6s3AzA66w4YA33Ba5pajO7aD6DL5ORlEK
	2Yjl66Q4Q15KCI+rimaB75WOWCldOuVwNMHY80X5K/agy5ozpQOEhxvnadv6mDg==
X-Received: by 2002:a50:d743:0:b0:568:9f77:9c0 with SMTP id i3-20020a50d743000000b005689f7709c0mr14627296edj.4.1712065481518;
        Tue, 02 Apr 2024 06:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7nguyZhip49uwET9ebOdtBS4qLmp/cHqlkRdW9k815nTIg/HnVbpEo6nETLV8jkZ0smQWzg==
X-Received: by 2002:a50:d743:0:b0:568:9f77:9c0 with SMTP id i3-20020a50d743000000b005689f7709c0mr14627276edj.4.1712065480941;
        Tue, 02 Apr 2024 06:44:40 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id da8-20020a056402176800b0056c18b79cd3sm6720654edb.22.2024.04.02.06.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:44:40 -0700 (PDT)
Date: Tue, 2 Apr 2024 15:44:39 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 22/29] xfs: advertise fs-verity being available on
 filesystem
Message-ID: <mfjbt655lndrhd5pswiximwoehpo4lpxoquhd73ohdk5ur7tdh@qgdxyzoh5zw6>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868924.1988170.14529689278344464510.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868924.1988170.14529689278344464510.stgit@frogsfrogsfrogs>

On 2024-03-29 17:41:48, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Advertise that this filesystem supports fsverity.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_fs.h |    1 +
>  fs/xfs/libxfs/xfs_sb.c |    2 ++
>  2 files changed, 3 insertions(+)
> 
> 
> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> index 6ede243fbecf7..af45a246eb1c1 100644
> --- a/fs/xfs/libxfs/xfs_fs.h
> +++ b/fs/xfs/libxfs/xfs_fs.h
> @@ -247,6 +247,7 @@ typedef struct xfs_fsop_resblks {
>  /* file range exchange available to userspace */
>  #define XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE	(1 << 24)
>  
> +#define XFS_FSOP_GEOM_FLAGS_VERITY	(1U << 28) /* fs-verity */
>  #define XFS_FSOP_GEOM_FLAGS_METADIR	(1U << 29) /* metadata directories */
>  #define XFS_FSOP_GEOM_FLAGS_PARENT	(1U << 30) /* parent pointers */
>  
> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
> index 39b5083745d0e..24e22a2dea51c 100644
> --- a/fs/xfs/libxfs/xfs_sb.c
> +++ b/fs/xfs/libxfs/xfs_sb.c
> @@ -1427,6 +1427,8 @@ xfs_fs_geometry(
>  		geo->flags |= XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE;
>  	if (xfs_has_metadir(mp))
>  		geo->flags |= XFS_FSOP_GEOM_FLAGS_METADIR;
> +	if (xfs_has_verity(mp))
> +		geo->flags |= XFS_FSOP_GEOM_FLAGS_VERITY;
>  	geo->rtsectsize = sbp->sb_blocksize;
>  	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
>  
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


