Return-Path: <linux-fsdevel+bounces-21917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AC090E813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 12:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F241C21D7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C42182D9F;
	Wed, 19 Jun 2024 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0abrkew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09282495;
	Wed, 19 Jun 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792080; cv=none; b=G+RKz9jD8HxIJCNsiy//4KH+PvoJ7VC1+smMQ55URutp2oDCWNEjgWkAo7T5AACwa+0yuyNBqeX4RznCArYOKdzy0ZkVfsczdW1XtGYaJFVA4BgNbGLDf0Ow+PN6/bUPmuReWlzzYOiD5TtfGJ8nBK6IDc0nOFO0NwhcfPBCIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792080; c=relaxed/simple;
	bh=/5lsOClEjTTiqIX0EKnwOr/nLlBBkUQDOTvZJquLTe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbHoeZT/QBSWXUtiJReU3B/R4Oa0VU9SsJB5avP2XYqF3G0D/4LKaZaCgKOqZ/3Yr5dEyTUgvRqAVl1QOb9Y6Q7qYxL9gsAQxtdigwbShaBeGXocHtTnnrAfoBilF8KbenlWX/fYns17r0TmyvdMT42TH4RnAjz+QBZwY1oZRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0abrkew; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217a96de38so46407505e9.1;
        Wed, 19 Jun 2024 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718792077; x=1719396877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWj4qqqcVIxCNyRZ2DfdgkNb1wGK6bSkCctArSODDZg=;
        b=i0abrkew2IHTI9Qk06UxvswNafj0EDe0n2oAP+tqiADtS4wd5/UEGh6ttH1oaLstsb
         Uj/feb08gfVDbnJ+5jjhOuPwDMWx5vGgEBCPDVlACEQsw/q4fRQ+OPD4eIrfxQfi6qbF
         xWMLDcxrTJzp0D/m4bixlj7HFGZjKJ06SIWbwKmt1Of/YpCF2vhSsDIttd5yEqX9FzXc
         mMPdJDReAdtJdCVaM1M03lz32q064RJM2v9/vbev+MdLPRf2VRVYSubsejy70CAkoDTu
         /sHu1O1evKVn/0Xc8sqZyouHwGkd05Y7IPiWZfvFVsZpGc+iESeXZkpkr6tL1yY8SgzZ
         dZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718792077; x=1719396877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWj4qqqcVIxCNyRZ2DfdgkNb1wGK6bSkCctArSODDZg=;
        b=IXO1x2nxUXy/drjWWuOzpNz7cXfHot16L55OjqxL3S5PlD/05z7KM6Rm3iL9qSTdZZ
         6Xle67Hzf49yYVCREcSWqbKYB1BTV8gI+LG6Ehk1JXjdLTEbgu3b+LoPlTDFBTr88Nse
         8LVoj9MMEyKxGm7OCgNlmbSKXrkgK/Z9UVPexW6rf1LOhm8Y4RPZg0Q0CKad/WkOp7Sg
         0obexOWlgAbS2BDtxnUZXUoV/yExfLqLoeQBLU6B69w/M/UOVHxXPgclW01xrRhqTdax
         kB1Yepwfr9DlRaXpFCJ0YkIHLKMqyTO7NlkWeYi89GRb1Qz1ZoWiCFGr++8W/eag2XGt
         9OUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPxcReMoYo+uSEYLi+TqeakamMzGMuCXRSwn1ilMCgTbe1VW7v4mnv5kUv2/OKQuLNXc1rXLxA1z1bSkhIHI7wmQhrEnJEA0Crftm9KKnINqJxEh9Q534HIfmVeOymXPGJ
X-Gm-Message-State: AOJu0YyUExtK2wj1Ui/aVESWFAg2vK3SuEUStfRZI8AzAIAGk5l2B6M9
	u3vPQVkbzLG/eZggR4uFICwfrp3yp9EkKDKdyxkhJ/P+ak+C1MY=
X-Google-Smtp-Source: AGHT+IGUS7OckNuAZosynBKA8uInq63efrk9sBC2i2lWzzzmjRF94hBF+hTm9Du2LZrcQOQBPKM6Vw==
X-Received: by 2002:a05:600c:4213:b0:421:aace:7a94 with SMTP id 5b1f17b1804b1-4247529c841mr11626615e9.40.1718792076991;
        Wed, 19 Jun 2024 03:14:36 -0700 (PDT)
Received: from p183 ([46.53.254.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3641788cf4fsm235849f8f.90.2024.06.19.03.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:14:36 -0700 (PDT)
Date: Wed, 19 Jun 2024 13:14:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-mm@kvack.org,
	liam.howlett@oracle.com, surenb@google.com, rppt@kernel.org
Subject: Re: [PATCH v5 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY
 API
Message-ID: <984d7898-d86a-4cea-9cdf-262b9ec4bc84@p183>
References: <20240618224527.3685213-1-andrii@kernel.org>
 <20240618224527.3685213-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618224527.3685213-4-andrii@kernel.org>

On Tue, Jun 18, 2024 at 03:45:22PM -0700, Andrii Nakryiko wrote:
> The need to get ELF build ID reliably is an important aspect when
> dealing with profiling and stack trace symbolization, and
> /proc/<pid>/maps textual representation doesn't help with this.

> @@ -539,6 +543,21 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  		}
>  	}
>  
> +	if (karg.build_id_size) {
> +		__u32 build_id_sz;
> +
> +		err = build_id_parse(vma, build_id_buf, &build_id_sz);

This is not your bug but build_id_parse() assumes program headers
immediately follow ELF header which is not guaranteed.

> +	 * If this field is set to non-zero value, build_id_addr should point
> +	 * to valid user space memory buffer of at least build_id_size bytes.
> +	 * If set to zero, build_id_addr should be set to zero as well
> +	 */
> +	__u32 build_id_size;		/* in/out */
>  	/*
>  	 * User-supplied address of a buffer of at least vma_name_size bytes
>  	 * for kernel to fill with matched VMA's name (see vma_name_size field
> @@ -519,6 +539,14 @@ struct procmap_query {
>  	 * Should be set to zero if VMA name should not be returned.
>  	 */
>  	__u64 vma_name_addr;		/* in */
> +	/*
> +	 * User-supplied address of a buffer of at least build_id_size bytes
> +	 * for kernel to fill with matched VMA's ELF build ID, if available
> +	 * (see build_id_size field description above for details).
> +	 *
> +	 * Should be set to zero if build ID should not be returned.
> +	 */
> +	__u64 build_id_addr;		/* in */

Can this be simplified to 512-bit buffer in ioctl structure?
BUILD_ID_SIZE_MAX is 20 which is sha1.

