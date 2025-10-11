Return-Path: <linux-fsdevel+bounces-63839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 071DDBCF2F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C867D4E652A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0EC23E342;
	Sat, 11 Oct 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCsOBX5n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BA29A2
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760174718; cv=none; b=GBzvOS5u5/hfPr4Tn1FVoM2QGvO/MZKtWUEr34d8ms36j7IvwDAaKHPL32iGDtRL55ziJZ+gIFMmrmt6LVoaQTdaxcxR2HNg8lvo8ngqr1urzfHtPreN7jNJD3RPUKFf93EjWP4XYpPEu/j6nA/TmDVgutmb/Puu5LzyyilHx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760174718; c=relaxed/simple;
	bh=9dy0aKoKhvYgFFwabOjADieVvERVExSxvcq1TvjbQsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL/KU4aDULvvHSuxb2oC+63Ah7eKjikx2y4A6Lr6Nrd+oOzu7LmuESz0CfA/t33Rlx+2tK7g6nOylsrZUT4vxAxYmPFU2DxPG+WozHLtUIIz40PXn4flzK7r0p+S6yDCNaSdh55boGT0tSEoYagWNzkPujO1A3GOyo9Zfff/9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCsOBX5n; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b2e0513433bso463721766b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760174709; x=1760779509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXEinQfxlrEaW5mbNRPwohsHPfbi3M1Bsd5Di42aJ94=;
        b=VCsOBX5nDjHoRnTFD0WyNfaQ6iZ5ZgAjal0gdkK+t6iuqFlyA7haQBZ63lt849XcfG
         Zv9hKVeHWoi1pWBgNYC4/pmXcaPyUQQVM7otuqveymREnCv5KBNod4kjqltbIfRmew1l
         Af00Ab+4hphyu8Tf8G/hCwCZfr2EWl2zkJ8RGssp7GUf3oSiqDVAUymNRIiV/8dDTZo0
         Vi9nhcn+LOO7B9EPTQUIL3AFDbKIaco7I5d3wrztCztvdtYGYuZvZsv7iaEsVqfyPLH5
         6IJYhCY8MtDyN9IZlKFUJl4EKI/4ghqJS8mD7OQouDIbSHeQQ3aElD/W4/0gaRyq5oDS
         tulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760174709; x=1760779509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXEinQfxlrEaW5mbNRPwohsHPfbi3M1Bsd5Di42aJ94=;
        b=vJUgIru1G0Izdr3BFI1Yb2dwGf84DEhdTN6z28pIGYRNAwCsADHxO8qkr77+tkUU2Y
         WZCUaQF6mYYLIb5+H/SsH4uVy/60s27J6Nv4gLWw02XppC/81n8/K1GRmd/7s/tNjMdc
         vjwV5M9ZLJ98XqSN+Sn2OQHnZ0MrCxTLOTGrYg0Dx7d+NoCjWyEC3nqSi26tkXwdxgww
         5HBiNsMhhouKI+DuGuqXZnIbzJvUFPDE5vKhttImoS+EcTWQ3TgAMzAhVlv8w21038IG
         fZtYfRTZpQXrHtiKK1wiauBhsdeu52rx/PmHs+AZE4TalrgD70Nn8bwWhWRNu7ra0ujZ
         62sg==
X-Forwarded-Encrypted: i=1; AJvYcCXnNhqbRJ98/UW/HeKb08Z1MQFco0zseta5+RusOwgQmnjdiu6gnIVd2NfGk1DwJA0GoqCNNh+C+rqbXUR0@vger.kernel.org
X-Gm-Message-State: AOJu0YyKra0R1JPbZE5kRcYHZsAvxrgy3XR5FqIWgTA3CZM6NF4vSCcX
	kPqtDoi5Wuex+h/g3zFO9p2zzm8JbE6dg36+pBOQaPV33dunK2LSWWPB
X-Gm-Gg: ASbGncv23ZRwqTT15Uu6MvVImQrtdCYBhzR8ghtYOfGqZfsAstn8nCHvjj6RQzQK6jI
	HTOk6366s2r3wwzfIiTrRBS+Vzr6tqLUAs+7WAaHCqkTQNl1TKNZEOP9mrYMpdPRkXw5oYx0Daj
	cZfcWiQsltjSNTVx/PAYH7pOWXSTz7BDSx+FLck/P0wPrUCg4IxqIewPN2aBaEGwETZ+5gLT9Pa
	W5th9VnQUIVzjg2VOGrCz5dMbHF6DkXm4hzXEt23lCIA4CRNOO0pMIJ2V7MNY8J1lqs2FUVMxNc
	1okwsM4OcjfhXeyBPNft60/Cd4SUud5pzRAModJdKTBZUGOATSpl/NzMjfNG0arif27qq91awhk
	QqHOWEeK8fRK7pJOa1r8j3+odgqCHu8+vR21aDMgctncLubjIrou/OdMpuo3gN/AZqGa03DkLUs
	lvPRRSKg7M+kfVKg3ZOOkNT6OT
X-Google-Smtp-Source: AGHT+IHPAZam1m8sYvQuHxTUeN/bLBz2BLvjFi8GzcdgbNZYPTup6tJOTtIwpqZFsVSwm5nBOTuk5A==
X-Received: by 2002:a17:907:3d91:b0:b3f:f43d:f81e with SMTP id a640c23a62f3a-b50ac0cc027mr1653121266b.40.1760174709221;
        Sat, 11 Oct 2025 02:25:09 -0700 (PDT)
Received: from f (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9a4054fsm438937866b.89.2025.10.11.02.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 02:25:08 -0700 (PDT)
Date: Sat, 11 Oct 2025 11:24:53 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pidfs: fix ERR_PTR dereference in pidfd_info()
Message-ID: <5asnajyk3d4c66fnpmodybc7rrprhvw4jy2chrihnlcgylu5uf@hfcw24zm2w7k>
References: <20251011072927.342302-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251011072927.342302-1-zhen.ni@easystack.cn>

On Sat, Oct 11, 2025 at 03:29:27PM +0800, Zhen Ni wrote:
> pidfd_pid() may return an ERR_PTR() when the file does not refer to a
> valid pidfs file. Currently pidfd_info() calls pid_in_current_pidns()
> directly on the returned value, which risks dereferencing an ERR_PTR.
> 
> Fix it by explicitly checking IS_ERR(pid) and returning PTR_ERR(pid)
> before further use.
> 
> Fixes: 7477d7dce48a ("pidfs: allow to retrieve exit information")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>  fs/pidfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 0ef5b47d796a..16670648bb09 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -314,6 +314,9 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>  	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
>  		return -EFAULT;
>  
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
> +

Is that something you ran into or perhaps you are going off of reading
the code?

The only way that I see to get here requires a file with
pidfs_file_operations, so AFAICS this shouuld never trigger.

In the worst case perhaps this can WARN_ON?

