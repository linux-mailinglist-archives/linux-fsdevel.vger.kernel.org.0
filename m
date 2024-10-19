Return-Path: <linux-fsdevel+bounces-32437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45D9A51A4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 00:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9609AB233E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B7193074;
	Sat, 19 Oct 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J9T4q1FM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023AC1922CC
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378231; cv=none; b=Aw347AqPZdmI3CRDS3EVlyo2MDf9pUFFfX3E3aPNwl/eVTyzSFZytNtE6Qjw8DjBiMvm8xrC1qOg47ulMezrjL7QX3EfCc4KCQkbVMEblXZ0+J/7GjIWq39EseNbgOHyl0OA1ZfVBdzqgAX7JDIrs3xjZQiL4jlDBpnxIu5hLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378231; c=relaxed/simple;
	bh=GWtLMRsLZGe4E3r+R/+P8YYa7gW3X+2YsqwO7F/RACA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f2laulG2EamtWLgDh5r4JmmnvRKwjnEU7nMRL389oEXIGa4CwH4ZrlXgDrQSuTJ3P7bZQdih/W1fEqPrtLeAR6zWST2hnrKH5+CcGT7rv2aT3Nj3PTScm5a5h+ig4foc6g4aod5bwreFYp8oiC+Vd+8p3B6jtmpk5H2P9Bk0CeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J9T4q1FM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso31464595ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729378228; x=1729983028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=26D6YfFHB6mhMnWiMc1xtXuTg1J0SpdP4FmHa6OeheQ=;
        b=J9T4q1FMkkeUOuyS4kqh3Zv2OOSboClfGFSpC6jAIixz2f9KNR6kl723zJvhjkydQZ
         /Vt3pk8rIoSF3SuWdjR4UjYoKop0DZInd5jHJuuY+Jc4ykJOqJDW5bdzyBxKAE/1XkNf
         CafyFSCH7K/7qoSXE0Pmm5r4E8Qb3Jq305TiRaZEmQv+xnp1TWmihq06CfFT7W8o64AJ
         q69TmcSb4QoTzdqMF3S/nkRnViCJf8GOKqyOmef019Y39RnDBaiMaG37hPmiPKIHas0n
         VoujHkQ5HxToaoAMLEaqcVgkCkCQBkFO0L+S/JT9t5o5040DGf2pll2nsScOTIKIgfJl
         jmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729378228; x=1729983028;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26D6YfFHB6mhMnWiMc1xtXuTg1J0SpdP4FmHa6OeheQ=;
        b=qtrdeRMLr0SCEadvftt4pgRUoCbnzLaj65rTN+XBDZV4cLKJZMmkn+e5EMflOnwVJ9
         kFdr3wjq7cXMWaTzPSqFtucpZgJ8jZsMD+y4EPczy9DeNUizNX1t75k2rCGKfytNiCLg
         ez6b7/k6iJRlazi+9D+0izroqpQ4JCQOPynTpb7CZN+rrcj+qqGa7sYXJfZPtffSaTrw
         4lWfuLMo0hbzb6Ac7E2It93+/tBs9xqfygQVqCkK3X8RWlfrkDumAQsNhbjpSJkfZ7s0
         elmsfVoQyZ4zbbMfs3uD/MtWDii2jZuI/a1TmC8OtsvaVFvYfF5ftXTDcXqHeEHHDv5w
         vWnA==
X-Forwarded-Encrypted: i=1; AJvYcCUTggCGJkCMBH1YdtH6I2u2UsmcgHoJuUdf3n28fLZrJ/gvNu9bn7xIzd8xreMs7HshIB6s50R2paNpSl4a@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnIJgsG8jpznjD+jynvr3a20IRihJaBvL/CSj5Y0TtIJ/S/3n
	SR4nqRA535gRhXnKhMvlhlH13+DaCJO2Ssj4I+5Kky9ZAV6Wd60gWpt5rVfw+Qc=
X-Google-Smtp-Source: AGHT+IG/SdolPDBlJgQXRSOz40RufwW0B9RRmCWWNyO7f6sAWOxABQs5hjD2LfcfSRzPBkj3obJ9KQ==
X-Received: by 2002:a17:903:2301:b0:20c:9eb3:c1ff with SMTP id d9443c01a7336-20e5a94b609mr89438595ad.59.1729378228212;
        Sat, 19 Oct 2024 15:50:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd4bbsm2095375ad.155.2024.10.19.15.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 15:50:27 -0700 (PDT)
Message-ID: <d6d920c6-9a8c-49b7-8d4a-fbeacd6906f0@kernel.dk>
Date: Sat, 19 Oct 2024 16:50:26 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v10 0/8] block atomic writes for xfs
From: Jens Axboe <axboe@kernel.dk>
To: brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
 John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
 martin.petersen@oracle.com, catherine.hoang@oracle.com, mcgrof@kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241019125113.369994-1-john.g.garry@oracle.com>
 <172937817079.551422.12024377336706116119.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <172937817079.551422.12024377336706116119.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/24 4:49 PM, Jens Axboe wrote:
> 
> On Sat, 19 Oct 2024 12:51:05 +0000, John Garry wrote:
>> This series expands atomic write support to filesystems, specifically
>> XFS.
>>
>> Initially we will only support writing exactly 1x FS block atomically.
>>
>> Since we can now have FS block size > PAGE_SIZE for XFS, we can write
>> atomically 4K+ blocks on x86.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/8] block/fs: Pass an iocb to generic_atomic_write_valid()
>       commit: 9a8dbdadae509e5717ff6e5aa572ca0974d2101d
> [2/8] fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
>       commit: c3be7ebbbce5201e151f17e28a6c807602f369c9
> [3/8] block: Add bdev atomic write limits helpers
>       commit: 1eadb157947163ca72ba8963b915fdc099ce6cca

These are now sitting in:

git://git.kernel.dk/linux for-6.13/block-atomic

and can be pulled in by the fs/xfs people.

-- 
Jens Axboe


