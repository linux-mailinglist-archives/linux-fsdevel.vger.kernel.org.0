Return-Path: <linux-fsdevel+bounces-11178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459F5851D3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 136C4B28B0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694AC4CB3D;
	Mon, 12 Feb 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FkEPwwjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291D4CB2B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763651; cv=none; b=Gi9+u8+Jl8U6qUvWSVcOBQRvBVvuKZmFyfX4dR50E1KUHdd2JCRh8DAaClcWBYFPlmzlbRkX8LTC8ZjJhlpOYXs6sW0+ALjHI+Qd5x/8XOlAYIHVANAVP98b+rMu6YnBKMSm19nBukGygqgXeqtaJKreWnN5ibolcknEwEz6VH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763651; c=relaxed/simple;
	bh=dJMxpJ3tn6RY2cKc4xGC0HIg3XSjjHz+oCeUpFHrRP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpM4KN91QjIImVCx+BghKttrOSZl6YFdl/pyyRwEC9c0ig/AeQByLO6a/Mn5O2OipNc8UlUkDK0rotlTpq9gmgYdxKncfzrxFj2WGQIV/DZkFfkvSXvM4w59sem8fpyJbeQOcz04XjMhZKe3LIbxyOrcIA2lCLbhdmCbz9c9s7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FkEPwwjl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e0cc8d740cso1085423b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707763650; x=1708368450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TavsUQdQnVBEpCaVSPmCRFcvfOSMCZQXkkrP6j8QWF8=;
        b=FkEPwwjlaUolywI/Www1G3YmCwk3FdTXdRBiBhy2xnBdFtGbfElAfHhvbKqTjnkbjX
         Zr+oZLmxB9QFPCNkX5c+q4YXUPz0F3n4YwXgTxWpbrupbt8LDJdivjB26Ksi1yxBDDuM
         M6/duedcrEmW5TrhMf/dyk3TIxZJY8mwyKesQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763650; x=1708368450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TavsUQdQnVBEpCaVSPmCRFcvfOSMCZQXkkrP6j8QWF8=;
        b=es2rw3PfcbV0GMlqF4LRi1ZqysLLAshO2+N/u1GXx/HPQtta0hHgYLPcHJH1WzeHsz
         LIxeKo9Kc2CgXZbhxyYxD9LgECifW5Ntc9NUKRou9ya93CCTw6RcpodzI95dJ+ql+dFq
         yL/XVR1YWwel0xZWmuU5oYi0sKAtq14M2cN0QgPUdWiccnSEEOrVxjujqgyBvLzD/gHX
         Rit95DcGXK+kG/pv9tn9PJkLOknDaYYAQ9SEgXC4mrVn/xb0NayutBQSW1CE5FdaGPNt
         YSI6Kls2dkJg4p3qxJ0EUqNO4irt7uF2+pWSVOWk2L3QM11vS1cT4uOQBYH2LEFELPCu
         J5ug==
X-Gm-Message-State: AOJu0YxR/1tbqTjAw4zZMzibqhD03DtMGR5mBm0DtD506pLQI5ZaOclF
	FQnANobZpFY+ylYyNrSkcz5XEShR3aPEmbkpzygUqIVqrJ+GMPqubs33S4ejDersDJENIPCcKN4
	=
X-Google-Smtp-Source: AGHT+IHIgz/ySRHYCWSmNpZLNlyiIelMKM44tyDuVLFNY8IGX66Ps5xRLSo9HCCGG8eBdYoG+k43vQ==
X-Received: by 2002:a05:6a00:3c93:b0:6e0:3b67:3531 with SMTP id lm19-20020a056a003c9300b006e03b673531mr7902857pfb.33.1707763649822;
        Mon, 12 Feb 2024 10:47:29 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r18-20020a62e412000000b006e0503f467bsm5879801pfh.39.2024.02.12.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:47:29 -0800 (PST)
Date: Mon, 12 Feb 2024 10:47:28 -0800
From: Kees Cook <keescook@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] quota: Detect loops in quota tree
Message-ID: <202402121046.42785619B@keescook>
References: <20240209112250.10894-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112250.10894-1-jack@suse.cz>

On Fri, Feb 09, 2024 at 12:22:50PM +0100, Jan Kara wrote:
> [...]
> @@ -613,15 +658,17 @@ static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
>  
>  /* Find entry for given id in the tree */
>  static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
> -				struct dquot *dquot, uint blk, int depth)
> +				struct dquot *dquot, uint *blks, int depth)
>  {
>  	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
>  	loff_t ret = 0;
>  	__le32 *ref = (__le32 *)buf;
> +	uint blk;
> +	int i;
>  
>  	if (!buf)
>  		return -ENOMEM;
> -	ret = read_blk(info, blk, buf);
> +	ret = read_blk(info, blks[depth], buf);
>  	if (ret < 0) {
>  		quota_error(dquot->dq_sb, "Can't read quota tree block %u",
>  			    blk);
                            ^^^
Coverity noticed this is used uninitialized. It should be "blks[depth]"
now, I think.

-Kees

-- 
Kees Cook

