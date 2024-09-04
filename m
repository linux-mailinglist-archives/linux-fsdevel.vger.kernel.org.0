Return-Path: <linux-fsdevel+bounces-28621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CEB96C6F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9211C23831
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2AF1E4101;
	Wed,  4 Sep 2024 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1Mzz9bCX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8C1E1A32
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476351; cv=none; b=s7qYYkwQZ3XXk/HBWGPkf7CQTMAZA/HxJf6og9wvqK4AG9DOeVJ9l+at7iyedtBOOTaga/SdEQpHHIlozQCv/+9bHE0Yx8zjBGksegO1AUl3754WgBd81g287b8/vzRZqyGzHL/m0prQ8dMY7wOk+53Xeg1R++QCMOkjartdG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476351; c=relaxed/simple;
	bh=Kr4wnJWAVLiOQ+87uD8Ult0dwg3eo90OJJGevl8kV+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxsvKpTzITVllj24/s1c988yDDRomYTtx1ybLTTGeaFNE1g40d/mgjA8i0ZcuIq2x8vD+Uh3rHV9VL8L0ALcj6oj3QEIrTYCL2TpGU/DDdFe8Ey5aDB9gS7uu6O8Hnrx56p0fQGHjgu7t79z/ehv3scfa9YfTIzAwO50G3fb6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1Mzz9bCX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2da55ea8163so1932853a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725476348; x=1726081148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8LsCKVZwV5lQ3jWhAlg4mSx2NCcOVeDvZznPs+OiwI=;
        b=1Mzz9bCXApQcIpuWTQ5BZUYPHNJS8dbtQQYtc9pe/QkvvyrEDi3QZqMlut0SdwW2HB
         nNH5qGyANnOAdMFnJYAJAwmkjH4lnA6/eOeNgUUKrNVWY5IyFF4llABSPuzGUF1aDG9D
         54ZIJUjeUptk5CspCdYetWtJUTj25KHgl/xQgzDkRXp38SI0XYIB6LJrxdLaSWCeEESg
         FIV7MIazHYlr9qGk5UPd/5YniB1F1aGJ9W1Y8IN7W5q4j6UmQ771GlU49PSrkFxDHtpd
         IGT7fGxD+LVT/0GQZZBFMSlzgNs+IG4fWen72KpPFrQSbAtyQea9hcvAsaQ8CfHs6irr
         Kgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725476348; x=1726081148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8LsCKVZwV5lQ3jWhAlg4mSx2NCcOVeDvZznPs+OiwI=;
        b=uXvSSk07vGFDUVelr5404BCCKPrwUavjvknwweZYOtpx/WdCj7MlHESSLDVzmKBy/w
         7c2yYZS0Xivb3D+HknMYNuoXqGhB7x73H6y/ej0ke98p23ZDSvdRtxFD19n2pESMMJdp
         8rUGZSZK3yopadH2DjGBjjlKiB804NBdnFDHa61m/lB/M8+TwDdB505kTDSUFe6Drs7Z
         EsF06QTvuZeV4cz5gs0e81Maet6Y1yHU5N3nnL6JLb2wUvrNe1C1UZ0p8atS0obVphAf
         6wBGFZ3krZYdxmDLu2dX2CEzyUjJP05q6fE9+Og4R2RfelB1Oly6wcSkM7Sy2mUQil9z
         fLWw==
X-Gm-Message-State: AOJu0YwglgXhUHhpQNQUCXqqtzzh2WcLJDyOLL4SvMmGOE07VfY0bh9j
	FhcE4ZukL1tKnW3qpUy0ezmtX5vAe4VKmjJab0uh/OMGrIAhwZpqmK4oY2wzFlo=
X-Google-Smtp-Source: AGHT+IEczGwYE1W6qKTTzXwAPYEQh+2rAiwq81FMnvGCUVLI1W5fddQWW+CUvwy+U8JB2KVDKRXq8g==
X-Received: by 2002:a17:90a:dc13:b0:2da:936c:e5ad with SMTP id 98e67ed59e1d1-2da936cef76mr2879780a91.33.1725476347815;
        Wed, 04 Sep 2024 11:59:07 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21cf::1030? ([2620:10d:c090:400::5:fa1a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8cc28ac9asm7592934a91.28.2024.09.04.11.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:59:07 -0700 (PDT)
Message-ID: <364a2201-34cb-4888-9e27-9a34999d5a79@kernel.dk>
Date: Wed, 4 Sep 2024 12:59:05 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 17/17] fuse: {uring} Pin the user buffer
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Pavel Begunkov <asml.silence@gmail.com>, bernd@fastmail.fm
Cc: linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Amir Goldstein <amir73il@gmail.com>
References: <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-0-9207f7391444@ddn.com>
 <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-17-9207f7391444@ddn.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-17-9207f7391444@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/24 7:37 AM, Bernd Schubert wrote:
> @@ -465,53 +486,41 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
>  
>  static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  				     struct fuse_req *req,
> -				     struct fuse_ring_ent *ent)
> +				     struct fuse_ring_ent *ent,
> +				     struct fuse_ring_req *rreq)
>  {
> -	struct fuse_ring_req __user *rreq = ent->rreq;
>  	struct fuse_copy_state cs;
>  	struct fuse_args *args = req->args;
>  	struct iov_iter iter;
> -	int err;
> -	int res_arg_len;
> +	int res_arg_len, err;
>  
> -	err = copy_from_user(&res_arg_len, &rreq->in_out_arg_len,
> -			     sizeof(res_arg_len));
> -	if (err)
> -		return err;
> -
> -	err = import_ubuf(ITER_SOURCE, (void __user *)&rreq->in_out_arg,
> -			  ent->max_arg_len, &iter);
> -	if (err)
> -		return err;
> +	res_arg_len = rreq->in_out_arg_len;
>  
>  	fuse_copy_init(&cs, 0, &iter);
>  	cs.is_uring = 1;
> +	cs.ring.pages = &ent->user_pages[FUSE_RING_PAYLOAD_PG];
>  	cs.req = req;
>  
> -	return fuse_copy_out_args(&cs, args, res_arg_len);
> +	err = fuse_copy_out_args(&cs, args, res_arg_len);
> +
> +	return err;
>  }

This last assignment, and 'err' in general, can go away after this
patch.

-- 
Jens Axboe


