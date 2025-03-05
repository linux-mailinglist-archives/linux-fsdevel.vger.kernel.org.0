Return-Path: <linux-fsdevel+bounces-43201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2724A4F3C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 02:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C3C16F2B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 01:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E8F1428E7;
	Wed,  5 Mar 2025 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDNuYM77"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D191134AB;
	Wed,  5 Mar 2025 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138285; cv=none; b=qaKE1xKBPKZuZdz3KtpRn6BsWWf8GcDJSWX3uro6KliqX5Zkslx/2vKHyiDdhW3ivfq4nFBHQ21BlnciivJadobAamZ9VuQ0GDL6rDcoGhr80kcsm25k/wt/zUNXj4pWIYd7Zy0yuB/x+PpRSKWWXcKjk8FlNDcn40Pc2khv9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138285; c=relaxed/simple;
	bh=p0ABAbqB4/o0bF8qgaDuYEgFYqz3s8yYRf7Crl+XBb4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=dGrvwnGfyxencxldqbsdmfRpGFbo3xHQIJ0BrYAp3C9i9TTTjxc1pnV+78fREW38VIsvbeBcv7YrHc+shO5rwcWHa3Cb0RQBjgQz3FcbNM8zMvRZnhIHUHzj6NO6GqAfjL4mHu1bCmw6J6bbqovoKL6U65cS6B00DSlqWu/TEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDNuYM77; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223480ea43aso156091945ad.1;
        Tue, 04 Mar 2025 17:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741138283; x=1741743083; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXOQJfWyaYNHjBbufikvYjnejw5zV3kZJWVJ44kLHqo=;
        b=kDNuYM779bXzI0t4hvlgHg7OOp1HsP7NTsxQmgwH/pJ0IEQX+H3jalHKgCb4OM6k9n
         TOFNkec6v7ChZlzNFSQjOaNnHC1VKOn1uRJrqbXnJJXSe/24fxysTc6Kx0APvvC4o073
         hG/JHO79bX/5S4gzz6RE8+aP149MKtcvdtWeSCQkWK+E8N6OIDC3t53XoFFdK9KQ8coR
         MNlL6KYVdgEsgI8pVeVFw2Arx+hETUfCv/fmKYt9pSgg3yRUJyFS+/4f7Pij6VZOQxo7
         RtXM1W/7rHBgUujoVVza4lo12EmEaIO5LsDcmtQj8Bgc0d/wuD3hDeQr9ISAldC7eZKN
         vojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741138283; x=1741743083;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXOQJfWyaYNHjBbufikvYjnejw5zV3kZJWVJ44kLHqo=;
        b=kZv4zOARK9Gc0fY2RezzTLQqoyMq3PXKNIjLCroYnUtlNxaliPsIcjHTF+4TMRA55b
         IY3yZ55/7izp9soc+L/qYkFEKVfryjRipA8EHd4l7FxXCi7QhT/fB57Jioh/HpCuUa8U
         nw92JDeB4IZPr8TW0Cwe+TWXaSIQGYxdGD7PcNdSh3rI04FeGSc3IZpJhWoMLVBm06kZ
         M0o9hWxAJ/w2mWN1lvp88puln05QhJCQILQOcncT/DT9oGSL4wvb95iceFhQzGJo1eAz
         nwKLlhONvoabD0WrtPFT0qcjZMnY3uEYHrGcUPT2mg6kiG0zFizFuwjKk/u/TKkFEB1H
         YCmA==
X-Forwarded-Encrypted: i=1; AJvYcCUFf86n/z5GgHMTDc6EE0g+2BLn2AtOzogVLGNBR1qqakrOu4BUQwupASbhFeiFQ8LOZ2YutDOmS3P3dDls@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+YDH3E3id1Iz3Ce+VP6KxmdLt9Nb9pyxNRSZBj6WO9qPqj9X
	xRfn25n6q2PGACMpk/unEUxtlT3yPPpFrAcBrC2QIVC9seLtK0KVNGKw7g==
X-Gm-Gg: ASbGncu84KhXptiXds19AkNSl20xXA7pGf+8tgyJ7cOrCQv3Jq1VrdyDZgd9Bx4Y+lj
	TCtaCmlmCk8/lJiqj+npZISbThSpk24zZAN/tvrk3v7CU1JSGTgIaWmYO7r8DEMbLmxuAtkSXiM
	PTuiSLTM2uKkR/ofPREXgTaG/MVChshV3ARylemCRuogVxpX1vGADNeDfKO49jXmd0xVLsO77eB
	g9KmAqF69hG/bx7xKw8gqoVGD9DIiVMzk7Srqh7h0NoulEsZuQBUaBGKApI5ymj64VvSUrmNfHF
	yPEGJGWp9mc/ZzuZDSfOy+KdHbdRXPKhthc5jg==
X-Google-Smtp-Source: AGHT+IH3PuM5a/UmSePv/YcJoIm1LwTBnynbh1uVMiXcMYhMrYm0x3ura2DR0HjWyN/6FlAju7ZdWg==
X-Received: by 2002:a05:6a00:8d1:b0:736:55ec:ea94 with SMTP id d2e1a72fcca58-73682caa339mr2034238b3a.20.1741138283049;
        Tue, 04 Mar 2025 17:31:23 -0800 (PST)
Received: from dw-tp ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363f62117asm6671261b3a.57.2025.03.04.17.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 17:31:22 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 3/3] xfs_io: Add RWF_DONTCACHE support to preadv2
In-Reply-To: <20250304175359.GC2803749@frogsfrogsfrogs>
Date: Wed, 05 Mar 2025 07:00:18 +0530
Message-ID: <87h6486z85.fsf@gmail.com>
References: <cover.1741087191.git.ritesh.list@gmail.com> <19402a5e05c2d1c55e794119facffaec3204a48d.1741087191.git.ritesh.list@gmail.com> <20250304175359.GC2803749@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Tue, Mar 04, 2025 at 05:25:37PM +0530, Ritesh Harjani (IBM) wrote:
>> Add per-io RWF_DONTCACHE support flag to preadv2()
>> This enables xfs_io to perform buffered-io read which can drop the page
>> cache folios after reading.
>> 
>> 	e.g. xfs_io -c "pread -U -V 1 0 16K" /mnt/f1
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  io/pread.c        | 12 ++++++++++--
>>  man/man8/xfs_io.8 |  8 +++++++-
>>  2 files changed, 17 insertions(+), 3 deletions(-)
>> 
>> diff --git a/io/pread.c b/io/pread.c
>> index 782f2a36..64c28784 100644
>> --- a/io/pread.c
>> +++ b/io/pread.c
>> @@ -38,6 +38,9 @@ pread_help(void)
>>  " -Z N -- zeed the random number generator (used when reading randomly)\n"
>>  "         (heh, zorry, the -s/-S arguments were already in use in pwrite)\n"
>>  " -V N -- use vectored IO with N iovecs of blocksize each (preadv)\n"
>> +#ifdef HAVE_PWRITEV2
>
> HAVE_PREADV2?
>

Thanks for catching that. Will fix this in v2.

-ritesh

> --D
>
>> +" -U   -- Perform the preadv2() with Uncached/RWF_DONTCACHE\n"
>> +#endif
>>  "\n"
>>  " When in \"random\" mode, the number of read operations will equal the\n"
>>  " number required to do a complete forward/backward scan of the range.\n"
>> @@ -388,7 +391,7 @@ pread_f(
>>  	init_cvtnum(&fsblocksize, &fssectsize);
>>  	bsize = fsblocksize;
>>  
>> -	while ((c = getopt(argc, argv, "b:BCFRquvV:Z:")) != EOF) {
>> +	while ((c = getopt(argc, argv, "b:BCFRquUvV:Z:")) != EOF) {
>>  		switch (c) {
>>  		case 'b':
>>  			tmp = cvtnum(fsblocksize, fssectsize, optarg);
>> @@ -417,6 +420,11 @@ pread_f(
>>  		case 'u':
>>  			uflag = 1;
>>  			break;
>> +#ifdef HAVE_PREADV2
>> +		case 'U':
>> +			preadv2_flags |= RWF_DONTCACHE;
>> +			break;
>> +#endif
>>  		case 'v':
>>  			vflag = 1;
>>  			break;
>> @@ -514,7 +522,7 @@ pread_init(void)
>>  	pread_cmd.argmin = 2;
>>  	pread_cmd.argmax = -1;
>>  	pread_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
>> -	pread_cmd.args = _("[-b bs] [-qv] [-i N] [-FBR [-Z N]] off len");
>> +	pread_cmd.args = _("[-b bs] [-qUv] [-i N] [-FBR [-Z N]] off len");
>>  	pread_cmd.oneline = _("reads a number of bytes at a specified offset");
>>  	pread_cmd.help = pread_help;
>>  
>> diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
>> index 47af5232..df508054 100644
>> --- a/man/man8/xfs_io.8
>> +++ b/man/man8/xfs_io.8
>> @@ -200,7 +200,7 @@ option will set the file permissions to read-write (0644). This allows xfs_io to
>>  set up mismatches between the file permissions and the open file descriptor
>>  read/write mode to exercise permission checks inside various syscalls.
>>  .TP
>> -.BI "pread [ \-b " bsize " ] [ \-qv ] [ \-FBR [ \-Z " seed " ] ] [ \-V " vectors " ] " "offset length"
>> +.BI "pread [ \-b " bsize " ] [ \-qUv ] [ \-FBR [ \-Z " seed " ] ] [ \-V " vectors " ] " "offset length"
>>  Reads a range of bytes in a specified blocksize from the given
>>  .IR offset .
>>  .RS 1.0i
>> @@ -214,6 +214,12 @@ requests will be split. The default blocksize is 4096 bytes.
>>  .B \-q
>>  quiet mode, do not write anything to standard output.
>>  .TP
>> +.B \-U
>> +Perform the
>> +.BR preadv2 (2)
>> +call with
>> +.IR RWF_DONTCACHE .
>> +.TP
>>  .B \-v
>>  dump the contents of the buffer after reading,
>>  by default only the count of bytes actually read is dumped.
>> -- 
>> 2.48.1
>> 
>> 

