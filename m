Return-Path: <linux-fsdevel+bounces-29048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCCA974296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 20:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340501C25F7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B021A4F1A;
	Tue, 10 Sep 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kUDQAkkP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B61A2C0E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994096; cv=none; b=REGUBiZlXlF4KYJzR89+28WIq8yIdIPm41emNpy7WbQmUPSxEchFX1HSRxwHkYa+fjwOZDnOR77V+TuNKIPoqNcJLjWEZmcece7KMHPh4bT+4Le5PpCe9S4oew3rSAvR1lgsrA+2gdlCLJ8ROvl8GbRHlmj2pFKr89dEpbLPdCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994096; c=relaxed/simple;
	bh=exfRCSbeGc10MpECC/7e0V7yMgHOMWsZWQLKlDrqrcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spbAoReDCLHVkvNYjeHMWRHw2tBWcEa3vJEIoBt/PWND0906Zs4GIo5B2TGH5zAETFvNjHlWePrZ7O/7lTTJxyTdycAFte+ohRbZC7Sx49EolFJPN+CB0O1vGiaJ9tcS20cdS5gjKgs0Bmeqag6x7NVZYMEqriNgRlUgibTunwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kUDQAkkP; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a0436958d9so17131955ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725994094; x=1726598894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=;
        b=kUDQAkkP9s45KUpgoGEAQfA3JED/wygrDeLXG765VwPj/PmD8mVn5kq+8hxFJo1Dmi
         CbNKYNt87K3HhhRzDO3pTSMMGRb6+1pQxi/sLPkfABYefVaT3kHpR0SpnGEuk6/GzK0x
         oNQ4pPlaEbLj5senKZ8qPsne0dQBqWvun9nkBzBSWnpvPHzu0u/ptXhE+VxfOI+lH7qh
         VX1yMOdpgYP8TBEVk4XmBq99STKwDQ5a+JT21NcFMqmpg3CsDbh6KdcbaXJpAIQi0C1y
         VyZ1cNYCLpUjM5uNhk2y9CYQv+saNLrKoGinYUEzp/wfH8zqp/cTQApAMTn9VFQv+4Uo
         Dv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994094; x=1726598894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=;
        b=kLSpnx8Xt2rt7hIFysWK99DOXMONUY5doMuECWCGe7xtiRZOgXyKGPJFCdcPxaRacF
         nJyH7RSTtCX32yZPRCCUk52ZxJdkWYohedYacCpVzGYCAd46XhW32NoSYKgDlbjXSA7c
         fCeegirq/RqehPxkuDNeo9DWnJpjhzhtkb0QryzBJBVQFWtPAM3WjUGIdm7mFs/Nt4SM
         0bOgJZo33Mm0u9XhQCY+CUjDe1M9H0FOkK6OsQKeXQOTDHQBPyKrNAngxyUVsZDa3WIw
         2hAeD1Ie6Fp5Cb/qI6SznR62WuvEJ3BrjFaI78mqCaGD7+9EiCVnwBih23x9b15tibhP
         7Bdg==
X-Forwarded-Encrypted: i=1; AJvYcCXaAyMboWPEM5MzDQ8bJabOT1JCtzL7VPlER9G7hcPJRd2O+rSOomUiLPkQL3K9ulHXyQiKoPgN/Tjr3Jqw@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPCXpLkF8/d5nCSmFtcc/NBCGkIZKxC4U6zn6GFHg2OtPD8WP
	vzlitEUa476BbV6c+kaTFFaRrwuIumnpI6OdFp2WbafC+XdQDBstueWWRAQv+ig=
X-Google-Smtp-Source: AGHT+IEbci4bFKk4qyfG7I+1DUOrdPWBQtYa+ssZc5w3NRdfD9WSHDse9oCgXPz7cY+ZMf7HVvKJ8w==
X-Received: by 2002:a05:6e02:16cf:b0:39f:5d13:9491 with SMTP id e9e14a558f8ab-3a05745eb8fmr106220205ab.7.1725994094344;
        Tue, 10 Sep 2024 11:48:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fd5c85sm21473895ab.23.2024.09.10.11.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:48:13 -0700 (PDT)
Message-ID: <e6792bd5-1bd0-4a28-b0c9-7e49f74505f2@kernel.dk>
Date: Tue, 10 Sep 2024 12:48:12 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
 jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>
References: <20240910150200.6589-1-joshi.k@samsung.com>
 <CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>
 <20240910150200.6589-4-joshi.k@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910150200.6589-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 9:01 AM, Kanchan Joshi wrote:
> +static inline bool rw_placement_hint_valid(u64 val)
> +{
> +	if (val <= MAX_PLACEMENT_HINT_VAL)
> +		return true;
> +
> +	return false;
> +}

Nit, why not just:

static inline bool rw_placement_hint_valid(u64 val)
{
	return val <= MAX_PLACEMENT_HINT_VAL;
}

> +static long fcntl_set_rw_hint_ex(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	struct rw_hint_ex __user *rw_hint_ex_p = (void __user *)arg;
> +	struct rw_hint_ex rwh;
> +	struct inode *inode = file_inode(file);
> +	u64 hint;
> +	int i;
> +
> +	if (copy_from_user(&rwh, rw_hint_ex_p, sizeof(rwh)))
> +		return -EFAULT;
> +	for (i = 0; i < ARRAY_SIZE(rwh.pad); i++)
> +		if (rwh.pad[i])
> +			return -EINVAL;

	if (memchr_inv(rwh.pad, 0, sizeof(rwh.pad)))
		return -EINVAL;

-- 
Jens Axboe

