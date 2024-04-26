Return-Path: <linux-fsdevel+bounces-17889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C88B36C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A85AAB2202B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A74314535A;
	Fri, 26 Apr 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcDuYQwB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D213CF99;
	Fri, 26 Apr 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132528; cv=none; b=DBvg7C5MzPvnv/0DcCTG0HbGO88YMlOq4lVYmlt/j0elgWd2rvIxUE5uoOftsIoIVQQsmTnC8nO2KAtqmKIOI+8H333N3kk/3iTMwDInhC9zVkC92XOA2buoX2iCf0JOOZ7P/4B+LhXTP1d/GCop5iTiUXu95zgi5zuFwteXWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132528; c=relaxed/simple;
	bh=r8Yt3anXN1vUUKfLUBfHTd3DWwQ6mszASIVqJfELd2Y=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=YfRbYLbnTiHvLiwAC71MQRcFN31sITbBwPwlcLeVxPcqtCXvv5EnTSsqOwQARS5jAekInLyJkvhP3/wVLyhZbaF0Jq0UpI0giM5vD13LptV/YssMBOdKsNvbs97+vR23uY+fD/baNcziQTmxuLs3J5EZ/P7sBCy+y8T+sgU6Y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcDuYQwB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so17381615ad.1;
        Fri, 26 Apr 2024 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714132526; x=1714737326; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5JEso13ULMuURfYi/Pq/VHWb8qnGq4WPHzsbPJPnYSY=;
        b=IcDuYQwB5F5NMx1cHgDv88uIZq4xBIeY8860qz8czb6L3OGCk0AzBGDpMtUvhzWJ5g
         oy2QK6YeEQE1R7QmnZSh0jriVpzKMyvnpfwdrnywt+3DHeJe9inNpPS2VFJ1IRymDhoq
         wH7I5zsnsLFveZLhQcVLl6zSAP0lcsJEj/d9QEXLj+LfcghfkrZ3n0ogoQTegThOXzaa
         jJNQWw0Lvf8p3+MTmzwpYJDSs78RGMZzWPDJ6HB02HLXaiwIcaZrCxDdxZvjdnTllfmk
         DtAoh7S5WfQL7Kk2709d3BXYaqVFcyxMsYZEha7jowd+/+fSvXMqsxbJafi5TS7WkxN9
         tR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714132526; x=1714737326;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JEso13ULMuURfYi/Pq/VHWb8qnGq4WPHzsbPJPnYSY=;
        b=JCzX/YeX4sQ/fPRWIHSSgE32bdeyhuDEK+IbB/ebW0JdqTuL1RNfrdofto7cVRTtRw
         iobs2gzF0PA0MycjiNl9aN2yjb2BL9LDCymlPwqq5y4fpIGUVPTeOstMFT7im+tDDAmH
         sNzVOlCGkDtLupLLEAlCG+WNr4WYnFT7NauTsSAgmr1IkH2QOxgHaYXucuu8IAvDaDAl
         fgvEDttnfY7G2gBCYvXetvZUVYH+h0qaKpqCfXLTOAqBw0ExzyJvfM0+KFqNak+50VsN
         F9pUYtApQAx5JkfOE7yI5/91IFNUykbY/gpTMxhTE0swmXh1mJT3efFJ+JWs1QzONolb
         UMjg==
X-Forwarded-Encrypted: i=1; AJvYcCXcX3T8FwFcANOb0K+Dpuz3C4dfjcho34J6Iy6/WMR6NExTc72dsWixZ5C1auN0cO0HnSf35+bHFoSLguUMYm9ZMdzVqqIU64oaq51Tdy3JbeOAfLa7XOBzVdyQ+SZCT9lE1PBgT9LyJw==
X-Gm-Message-State: AOJu0YxDDDyNKyjDG+0d38hmnI/4MP0qaBMnt3rcol7XPxPjLTHXlkLc
	Fd93GxeEk0S6PnYFq0Z6On9iV0KYfbpk2AnqUHZ908ED45SAmxLk
X-Google-Smtp-Source: AGHT+IFtJ+Gpm3oDitTkbUHH52GvIU+9HkHSBaiQPMMFJTKHjouSTLIyggXLWnO2qxHj1zJvDnv66w==
X-Received: by 2002:a17:902:f68d:b0:1e8:418b:7640 with SMTP id l13-20020a170902f68d00b001e8418b7640mr2415097plg.48.1714132525737;
        Fri, 26 Apr 2024 04:55:25 -0700 (PDT)
Received: from dw-tp ([171.76.87.172])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b001e9685ad053sm10214490plh.248.2024.04.26.04.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 04:55:24 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:25:09 +0530
Message-Id: <87il04nxsy.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com, willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com, yi.zhang@huaweicloud.com, chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 01/34] ext4: factor out a common helper to query extent map
In-Reply-To: <20240410142948.2817554-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Zhang Yi <yi.zhang@huaweicloud.com> writes:

> From: Zhang Yi <yi.zhang@huawei.com>
>
> Factor out a new common helper ext4_map_query_blocks() from the
> ext4_da_map_blocks(), it query and return the extent map status on the
> inode's extent path, no logic changes.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 57 +++++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 25 deletions(-)

Looks good to me. Straight forward refactoring.
Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 537803250ca9..6a41172c06e1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -453,6 +453,35 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
>  }
>  #endif /* ES_AGGRESSIVE_TEST */
>  
> +static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
> +				 struct ext4_map_blocks *map)
> +{
> +	unsigned int status;
> +	int retval;
> +
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		retval = ext4_ext_map_blocks(handle, inode, map, 0);
> +	else
> +		retval = ext4_ind_map_blocks(handle, inode, map, 0);
> +
> +	if (retval <= 0)
> +		return retval;
> +
> +	if (unlikely(retval != map->m_len)) {
> +		ext4_warning(inode->i_sb,
> +			     "ES len assertion failed for inode "
> +			     "%lu: retval %d != map->m_len %d",
> +			     inode->i_ino, retval, map->m_len);
> +		WARN_ON(1);
> +	}
> +
> +	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
> +			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> +	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> +			      map->m_pblk, status);
> +	return retval;
> +}
> +
>  /*
>   * The ext4_map_blocks() function tries to look up the requested blocks,
>   * and returns if the blocks are already mapped.
> @@ -1744,33 +1773,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  	down_read(&EXT4_I(inode)->i_data_sem);
>  	if (ext4_has_inline_data(inode))
>  		retval = 0;
> -	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
>  	else
> -		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
> -	if (retval < 0) {
> -		up_read(&EXT4_I(inode)->i_data_sem);
> -		return retval;
> -	}
> -	if (retval > 0) {
> -		unsigned int status;
> -
> -		if (unlikely(retval != map->m_len)) {
> -			ext4_warning(inode->i_sb,
> -				     "ES len assertion failed for inode "
> -				     "%lu: retval %d != map->m_len %d",
> -				     inode->i_ino, retval, map->m_len);
> -			WARN_ON(1);
> -		}
> -
> -		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
> -				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> -		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> -				      map->m_pblk, status);
> -		up_read(&EXT4_I(inode)->i_data_sem);
> -		return retval;
> -	}
> +		retval = ext4_map_query_blocks(NULL, inode, map);
>  	up_read(&EXT4_I(inode)->i_data_sem);
> +	if (retval)
> +		return retval;
>  
>  add_delayed:
>  	down_write(&EXT4_I(inode)->i_data_sem);
> -- 
> 2.39.2

