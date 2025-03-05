Return-Path: <linux-fsdevel+bounces-43290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D813EA50B3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12325173BE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ED6253326;
	Wed,  5 Mar 2025 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meM2Ukti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F5250C1D;
	Wed,  5 Mar 2025 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202056; cv=none; b=qxDGEHjEvzcmEp00X57zyPYxSzd7DzDqA8xNzADqfIkssHIvxsnl1pSGNhTgTACXo8tT99PN/Nxa8UQxOkFbA2uYaU05ATvg2gUpsiiNMZTGSJkm8bYdLfj0petavxwH5j/jBNHkeMUQnYryXFhN5ZKmcPGPZbd4WzcIUlGGyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202056; c=relaxed/simple;
	bh=+/2av5maNcdxOaar+HN6ObA9Wc5QuLntzzBn04AtrYg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NchPSZQNAsNeSwENdQ8C7dLGpeKmNafiAKa1fGWbSglOrR1ct7FVrLfcnzhhB31OlZ+jA+BVUHl33C4pMlcaOUk3YFsNZN1ySU6afF0xmjZ71j7hAT57xBtN5K0VQ8wzJspUTW1zrhrPg9/3pE0gmclLsAAJXQdnKveMUkkXBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meM2Ukti; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22403cbb47fso13931445ad.0;
        Wed, 05 Mar 2025 11:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741202054; x=1741806854; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HRxYHTA5xZf/eGWnp7I3k1hzmIvppLKZ/dPsbul3QoE=;
        b=meM2UktiyDxAeqIK88J0NICrEbvDBsF/hNa7R2H4n7zxTZH2Y/wF1e0iiOsg0XokRl
         hFkOtTgXzXREGBmwlachyCtqg/RUY4BPvikWTSOcyt7bGaAwY5IFEgha/S07OWX/sofv
         pzRAsbJuuKy+hD2LmEXdb4Q6FA549Ia3EMtedrQzM00JGbPlGXFfyBKUZhgJqPzplA9o
         B0MqR4zvjvnWmaO7BzKDLpKIWw+rGsq3DKdpbZ2Lzqf2SRlFn/nnlQQzPLEv7Bwl9riO
         sr+2h+1NTDe+bpg90MPLQ56YHWoHbXpM/sh13LY9Z2neEce9y5HlyTYJO4/6uiy3a3t6
         voqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202054; x=1741806854;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRxYHTA5xZf/eGWnp7I3k1hzmIvppLKZ/dPsbul3QoE=;
        b=tW13JGxn5H3zR+uLWJCWaLtWZnJu146Gniq7A8P1+JgImTE57tAEgR4mRZpD9cB2CU
         qSkI3ZHQqH9/9ooqxVtNnD3CV6OBnokNp/KL/fgK6BUdJIb/Yy6Jq1ASd1ahnUKL3BQU
         5tFnDtummnxqnDm7CSByrDAtUz8nxlGfs0r6IDfIa+P7aF9sfIi649HsjvOKcuAzOQsd
         vt8t0y067r/uHeIdqO3Mow9XCk0xtxsyVsZVjn8CCH9WayoynXrGRd4v36Dwi3gwuEH5
         9A4bYzzq062o9zQrinR02o/LsIjucgqgi/Lg5chO0YGTtECx8cdm5p/g9TbVFCXJ68Kz
         TTxw==
X-Forwarded-Encrypted: i=1; AJvYcCW515ZwRH4tjrTuDBeuV8hdLFcVUVCd2QlRaJWAMjwHPeXrfBfv/e9erRpokJZogbSdDwsc16aKgOgmIXfI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywii65lGT771V3up7K1eugp/8KNeUNc4mUzNov6a2uyRqU+k/b4
	FCGlOJ+Ae2G08ThdKRhlm/9b3chkM6x2zvLEZLkgqURdDhnNVkQ8O3WdYA==
X-Gm-Gg: ASbGncubqdqsVkONwLDXNv6wQnS9YqMY4NTosek+c6q2j/i2vUpKd8OXPGiq9h7bAiv
	PwnqMsZuanXEOnXmofF9slM4HDQDTpLB78KfTllSDiGvCUqjHJBs8Mxwr37XbQThqV92tXfGr1b
	28oDtXFgL+zykIPpIWr/FdgKjC/Ep1fJRL2bzUhEtXXDaykiB/ubVNjYVPDfjaUBQU4+1FKKdKW
	hwNHBIVXQVraOGPnN05dSb3cEkyklILwYWe9joHQ+e6qdvoyEj+bkl4eJJAY1swo4ntrKo2L0UE
	TpezL25zIc4ENStcEUdtFJ8nNsWsIbOUINFTkw==
X-Google-Smtp-Source: AGHT+IEe7aCxTy8XpNBGHXw6dloUanW4RBWxq0F8PQRTzri57T1jxT/EBpiCeucgZc//RByEY58opg==
X-Received: by 2002:a17:902:ec83:b0:223:669f:ca2d with SMTP id d9443c01a7336-223f1cf1fc5mr73296785ad.35.1741202052518;
        Wed, 05 Mar 2025 11:14:12 -0800 (PST)
Received: from dw-tp ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fbdecsm116956005ad.101.2025.03.05.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:14:11 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/3] xfs_io: Add RWF_DONTCACHE support to pwritev2
In-Reply-To: <20250305181031.GG2803749@frogsfrogsfrogs>
Date: Thu, 06 Mar 2025 00:41:54 +0530
Message-ID: <87a59z70n9.fsf@gmail.com>
References: <cover.1741170031.git.ritesh.list@gmail.com> <57bd6d327ac8ed2f8e9859f1e42775622a8b9d09.1741170031.git.ritesh.list@gmail.com> <20250305181031.GG2803749@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Wed, Mar 05, 2025 at 03:57:47PM +0530, Ritesh Harjani (IBM) wrote:
>> Add per-io RWF_DONTCACHE support flag to pwritev2().
>> This enables xfs_io to perform uncached buffered-io writes.
>> 
>> e.g. xfs_io -fc "pwrite -U -V 1 0 16K" /mnt/f1
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  include/linux.h   |  5 +++++
>>  io/pwrite.c       | 14 ++++++++++++--
>>  man/man8/xfs_io.8 |  8 +++++++-
>>  3 files changed, 24 insertions(+), 3 deletions(-)
>> 
>> diff --git a/include/linux.h b/include/linux.h
>> index b3516d54..6e83e073 100644
>> --- a/include/linux.h
>> +++ b/include/linux.h
>> @@ -237,6 +237,11 @@ struct fsxattr {
>>  #define RWF_ATOMIC	((__kernel_rwf_t)0x00000040)
>>  #endif
>>  
>> +/* buffered IO that drops the cache after reading or writing data */
>> +#ifndef RWF_DONTCACHE
>> +#define RWF_DONTCACHE	((__kernel_rwf_t)0x00000080)
>> +#endif
>> +
>>  /*
>>   * Reminder: anything added to this file will be compiled into downstream
>>   * userspace projects!
>> diff --git a/io/pwrite.c b/io/pwrite.c
>> index fab59be4..5fb0253f 100644
>> --- a/io/pwrite.c
>> +++ b/io/pwrite.c
>> @@ -45,6 +45,7 @@ pwrite_help(void)
>>  " -N   -- Perform the pwritev2() with RWF_NOWAIT\n"
>>  " -D   -- Perform the pwritev2() with RWF_DSYNC\n"
>>  " -A   -- Perform the pwritev2() with RWF_ATOMIC\n"
>> +" -U   -- Perform the pwritev2() with Uncached/RWF_DONTCACHE\n"
>
> I would have just said "...with RWF_DONTCACHE" because that's a lot more
> precise.
>

Yes, probably I was just overthinking and trying to give a reason here of
choosing -U (Uncached). 

> With that shortened, this looks pretty straightforward.

Sure will fix in v3.

> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks!

-ritesh

>
> --D
>
>>  #endif
>>  "\n"));
>>  }
>> @@ -285,7 +286,7 @@ pwrite_f(
>>  	init_cvtnum(&fsblocksize, &fssectsize);
>>  	bsize = fsblocksize;
>>  
>> -	while ((c = getopt(argc, argv, "Ab:BCdDf:Fi:NqRs:OS:uV:wWZ:")) != EOF) {
>> +	while ((c = getopt(argc, argv, "Ab:BCdDf:Fi:NqRs:OS:uUV:wWZ:")) != EOF) {
>>  		switch (c) {
>>  		case 'b':
>>  			tmp = cvtnum(fsblocksize, fssectsize, optarg);
>> @@ -328,6 +329,9 @@ pwrite_f(
>>  		case 'A':
>>  			pwritev2_flags |= RWF_ATOMIC;
>>  			break;
>> +		case 'U':
>> +			pwritev2_flags |= RWF_DONTCACHE;
>> +			break;
>>  #endif
>>  		case 's':
>>  			skip = cvtnum(fsblocksize, fssectsize, optarg);
>> @@ -392,6 +396,12 @@ pwrite_f(
>>  		exitcode = 1;
>>  		return command_usage(&pwrite_cmd);
>>  	}
>> +	if (pwritev2_flags != 0 && vectors == 0) {
>> +		printf(_("pwritev2 flags require vectored I/O (-V)\n"));
>> +		exitcode = 1;
>> +		return command_usage(&pwrite_cmd);
>> +	}
>> +
>>  	offset = cvtnum(fsblocksize, fssectsize, argv[optind]);
>>  	if (offset < 0) {
>>  		printf(_("non-numeric offset argument -- %s\n"), argv[optind]);
>> @@ -480,7 +490,7 @@ pwrite_init(void)
>>  	pwrite_cmd.argmax = -1;
>>  	pwrite_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
>>  	pwrite_cmd.args =
>> -_("[-i infile [-qAdDwNOW] [-s skip]] [-b bs] [-S seed] [-FBR [-Z N]] [-V N] off len");
>> +_("[-i infile [-qAdDwNOUW] [-s skip]] [-b bs] [-S seed] [-FBR [-Z N]] [-V N] off len");
>>  	pwrite_cmd.oneline =
>>  		_("writes a number of bytes at a specified offset");
>>  	pwrite_cmd.help = pwrite_help;
>> diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
>> index 59d5ddc5..47af5232 100644
>> --- a/man/man8/xfs_io.8
>> +++ b/man/man8/xfs_io.8
>> @@ -244,7 +244,7 @@ See the
>>  .B pread
>>  command.
>>  .TP
>> -.BI "pwrite [ \-i " file " ] [ \-qAdDwNOW ] [ \-s " skip " ] [ \-b " size " ] [ \-S " seed " ] [ \-FBR [ \-Z " zeed " ] ] [ \-V " vectors " ] " "offset length"
>> +.BI "pwrite [ \-i " file " ] [ \-qAdDwNOUW ] [ \-s " skip " ] [ \-b " size " ] [ \-S " seed " ] [ \-FBR [ \-Z " zeed " ] ] [ \-V " vectors " ] " "offset length"
>>  Writes a range of bytes in a specified blocksize from the given
>>  .IR offset .
>>  The bytes written can be either a set pattern or read in from another
>> @@ -287,6 +287,12 @@ Perform the
>>  call with
>>  .IR RWF_ATOMIC .
>>  .TP
>> +.B \-U
>> +Perform the
>> +.BR pwritev2 (2)
>> +call with
>> +.IR RWF_DONTCACHE .
>> +.TP
>>  .B \-O
>>  perform pwrite once and return the (maybe partial) bytes written.
>>  .TP
>> -- 
>> 2.48.1
>> 
>> 

