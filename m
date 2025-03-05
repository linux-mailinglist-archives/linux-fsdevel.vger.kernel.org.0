Return-Path: <linux-fsdevel+bounces-43291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B361DA50B41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95D63A22E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252F253345;
	Wed,  5 Mar 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6t/mR7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16ED2517A6;
	Wed,  5 Mar 2025 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202102; cv=none; b=FvsTW868xWWC2WAnQxb/FZ9yz32vVDjl2t68Ia3oFT88yeSpRZtApe+jW7L7PzGOoH6o1CnLa3TZzlozCRCWmfCeSYWvpV7+nW2M483fteSyLmh5+r3GPnh7skzyzUkRW36yWByi9Phzk6VEwO2wWUWgVmTXbD/TpEWUkDoheIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202102; c=relaxed/simple;
	bh=/Ybie9q0/+8Co9zU/ifZ7yayDi2IrOob75QwQ2mQfjQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=L12KW/yBPKh/jofN23bC3cwA2R/f5VTD3Dc7tyv0uQz8Vhui0yormt+TfJewc7e26n355+3Hzo1neCE3knOYpg0o5HhWKhkMadFN0C9Yf74iXChw2bmQgd5sNPJXa3dOwzt1hkGP3nXBz2K0dOKLVTFLyPXAoPvB/5YVpbGAasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6t/mR7W; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so138395675ad.0;
        Wed, 05 Mar 2025 11:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741202100; x=1741806900; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DNJizq6ZrEKfgL1z3MAYGNlHdocBiAC0EOQiQWZ68AY=;
        b=O6t/mR7WqTv93ZmmMmoaj4tZesmu4pCYcvZMd5x1iHfDQf849aJ/76IL7wisAj8ZOF
         sgQf2U1hqX9U2UYp6EvYHN7LVaASlR7lKwm2D6CWf/uJEtpiQU7QWeXQf7q+5/gga2Yx
         O51NVBSDQ8+NXz4krw/H+ONpLfXLsxYux9MwX2mQH4SBVSrd7+G9Y0tiKgP+GjV9OCi8
         dkkbFEqErm5C4vn0tOSoC/JIrtRgi/B7qaACy36ZyxXYusxMJwBxNvTaiEKmOQW4D3me
         kHBC49HGF7E7MNTeAW1tBl9a3O5w5x3SwRy07IihaSi8MESx2RKrqIFcZuNMIzzJ7ajj
         yirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202100; x=1741806900;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNJizq6ZrEKfgL1z3MAYGNlHdocBiAC0EOQiQWZ68AY=;
        b=I8hxmfadro67zvuDI7TJjc9RM1/gzpbwt9wGr2QtW5hvcmlv/+45hfWapt4y4v+aps
         Ej1Abnen+TYVA7dyLTtyU9AtqfFV93dXZtz+2ZXgWr06cjSd9Hx8ig15wuKHrdEdxp3s
         8vowikGheg87Ujb0pIvH6HLGD0qsr82rwQJnyQv3/m+pxjDMjPAU1jdi4KNVJaF5dYJ/
         pAASFzWmE8rJKA7qFLnIjVVa0iI5BDFdJ57eMKYiJV/1n5SKW0WZ8XoaPo5iIrO1JTxL
         Mpuk/Yo+frHZ8eRMpIdvYF8KZIx9GznIqBaQdBHttb5i0VwLxQ1PuOAZVmoeT3p8ZJc7
         xz8g==
X-Forwarded-Encrypted: i=1; AJvYcCUPlv6d1UQJWAVdbM3GUf0DTVtrml57w/3N/1SJZb1/mHZkG4yy739nyTRPDRZXcGIgVO1VF7y7Er/O9pfn@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOVQ5dCmTN9unLVjirIkwSWmm2Icy9oXczxh9gwovXgfWZ5Id
	iAWORSFNXczgDJ7PXZOzoFO3qom1IVaqg+Y7qD7nb5UWWvJggcoQ
X-Gm-Gg: ASbGncvHolt3tPVPxeyd1efWZkeD2KuheOVomSLTGowp+fcrelxQxZXmoN55AKeyvuh
	ECvEayM8PTpVBDZY8eUrXX107sWikA4/8M4wALjN/aUWpaZOkD1Rga3lX7hDQ3aEErgD5OYNwyu
	fy9WaMVQxu4FPL+t2vSza84zSJO+/YRYSdYm8yC81dWDAnUfGAFEGUO+fedhKr9SA7TVH/M+ITl
	vUoYb4CJ/j4+B7pLCNgBoyTtADRrYVrNj3Ga8CqxjhuDyi0wiYKby6iuDHhj9hNO8nfJjJcUhKb
	SjCtTB8G/RH8ejEoShL5HII7DbPk6IH8JajYHQ==
X-Google-Smtp-Source: AGHT+IHyZUL8rTCCwnDAjHvHTFN6DBxt4tO7Fas929ChPlLNKFvJi/86w1EGfNBGe80vOUzZNTINuQ==
X-Received: by 2002:a17:902:c602:b0:223:4537:65ad with SMTP id d9443c01a7336-223f1c98c46mr52823345ad.30.1741202099879;
        Wed, 05 Mar 2025 11:14:59 -0800 (PST)
Received: from dw-tp ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223fb3a0095sm12540535ad.226.2025.03.05.11.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:14:59 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/3] xfs_io: Add RWF_DONTCACHE support to preadv2
In-Reply-To: <20250305181103.GH2803749@frogsfrogsfrogs>
Date: Thu, 06 Mar 2025 00:44:16 +0530
Message-ID: <878qpj70jb.fsf@gmail.com>
References: <cover.1741170031.git.ritesh.list@gmail.com> <e071c0bf9acdd826f9aa96a7c2617df8aa262f8e.1741170031.git.ritesh.list@gmail.com> <20250305181103.GH2803749@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Wed, Mar 05, 2025 at 03:57:48PM +0530, Ritesh Harjani (IBM) wrote:
>> Add per-io RWF_DONTCACHE support flag to preadv2().
>> This enables xfs_io to perform uncached buffered-io reads.
>> 
>> 	e.g. xfs_io -c "pread -U -V 1 0 16K" /mnt/f1
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  io/pread.c        | 17 +++++++++++++++--
>>  man/man8/xfs_io.8 |  8 +++++++-
>>  2 files changed, 22 insertions(+), 3 deletions(-)
>> 
>> diff --git a/io/pread.c b/io/pread.c
>> index b314fbc7..79e6570e 100644
>> --- a/io/pread.c
>> +++ b/io/pread.c
>> @@ -38,6 +38,9 @@ pread_help(void)
>>  " -Z N -- zeed the random number generator (used when reading randomly)\n"
>>  "         (heh, zorry, the -s/-S arguments were already in use in pwrite)\n"
>>  " -V N -- use vectored IO with N iovecs of blocksize each (preadv)\n"
>> +#ifdef HAVE_PREADV2
>> +" -U   -- Perform the preadv2() with Uncached/RWF_DONTCACHE\n"
>
> Same comment as the last patch, but otherwise this looks good;

Sure will do in v3.

> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks!
-ritesh

>
> --D
>
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
>> @@ -446,6 +454,11 @@ pread_f(
>>  		exitcode = 1;
>>  		return command_usage(&pread_cmd);
>>  	}
>> +	if (preadv2_flags != 0 && vectors == 0) {
>> +		printf(_("preadv2 flags require vectored I/O (-V)\n"));
>> +		exitcode = 1;
>> +		return command_usage(&pread_cmd);
>> +	}
>>  
>>  	offset = cvtnum(fsblocksize, fssectsize, argv[optind]);
>>  	if (offset < 0 && (direction & (IO_RANDOM|IO_BACKWARD))) {
>> @@ -514,7 +527,7 @@ pread_init(void)
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

