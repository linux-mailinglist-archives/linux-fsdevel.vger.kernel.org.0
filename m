Return-Path: <linux-fsdevel+bounces-34488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1069C9C62D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9649BC4F8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6170208222;
	Tue, 12 Nov 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2hn4gktA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2F2003B3
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431598; cv=none; b=iVsjt57KK7ECK+Nng5o0vFm9Re5fjmXt+Gv+DGBrQPldhnjyQR664UXtpcUePbWb3h64A8lf7cSyFxgUzas5rmMABENzgWf7QdaD+/UX/LaBBwH42Wcp8Su+GkTcDT7q95OJO28GxuKRxn29EtkUoBwKkZZkZPxnOr+/0ffabfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431598; c=relaxed/simple;
	bh=OaIUNL4wDulYBWCeL52yflc/neDWNsACf3HqYi4lxlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQsy/bm4NxrgYNjMy53GJbpFv/+xjlxG5wY4AOHtVw19bFRO6OmJBuPcx1+WsXmAD9Sy6Sw3ingIbYvd/mul3Ib5FL7vWl+bYadhyGw8nHFXvDMBzTVhw32/y//zet7ZCOyItTtLMjaWbCMI2bSAyONoZTYNeJK8JQU/w6h97pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2hn4gktA; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e602a73ba1so3522263b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731431595; x=1732036395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhFc34QUIUtRmxEJib4/H+5a4T4gZgtNawOMUenBu5s=;
        b=2hn4gktAu2bXg6QIK5HzUibtinBzYRFPoxDow1f3UmHelR9UGv5coMHakweqRMRIym
         kp3Ga015gohmr3A+IxrgVH8dnCo2csTaFvWUMf81Ti2IrCbc/yMHzg5YN6HLaaj5a1X8
         uznE2I9ayKEqXMbOkk4WKO+VkjGNDtd/OMJO64X6kiWttBuYwnCbBZ9F8g9YJRdr8Nz3
         5yEy6F+lSNbK591sinNhYy6uUXmevNJLAvuMtADMuYMdCLGyeQBNsEua/OiHiT8VjBI0
         BPdne/u4wIOZgLshPcZj9bHOYCn0Oj5an4xIpV3/yo0Yjz5h63XMyTXfGrRHxR5wUuaS
         QIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431595; x=1732036395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhFc34QUIUtRmxEJib4/H+5a4T4gZgtNawOMUenBu5s=;
        b=qPyH3DiDEks//18gb1W5TSN0/8BvRwQ+JACNki/B84KsLbKLIw5SK/MMGjDUBZ+GY0
         lBKQXZYv5j7DgWRB9TcqfaOLI8x+953JmAm9gkAp96PCMR7Da5G4Rf/qH8B3ACGeAp9l
         ARXoo03y2OV+Z+jYRYf/7inAS/zlVEqheZK1SzhQKtn+w7GwC2wnM3MO2yVBTt9l/yxC
         0cNDG7Lt82XNu98yK+Qt6jWRvjSx5qed5QUuGql6PMwAe3kbyFrTiGI5yKUBEMqSpxGD
         FKpHufuzy85g485yN7CbuzKCz4eLQ0eEz0z9bHcPMagSs0QgAb/qUE6MGRCQD5f6k/UU
         iK4g==
X-Forwarded-Encrypted: i=1; AJvYcCW0R/BBp2IQF4C2oIIf92cdtp/V8V7DN2P9lyKZCx7D1OcUeAuMW5v5tzdd908W9T4iUlIFbnLImCf7UWKf@vger.kernel.org
X-Gm-Message-State: AOJu0YykVAAYxL4HGRHt/Ui0l1lVta8dtnEWDQImuS1nCzkSvWJlSpOT
	NdEaklSrLdeIKLen1ggvZ0nhbn45/rd1DDqB6gN1ntq2sU9yArP4hGUJoKI9PJA=
X-Google-Smtp-Source: AGHT+IH644V99dOVg147q96OR3GJtIRC7XpOTmFUI9LGtr4TxaaFP6x3xC1BuVau04Ao7iJOTmXH6w==
X-Received: by 2002:a05:6808:10c9:b0:3e6:60dc:5aee with SMTP id 5614622812f47-3e794654540mr13513708b6e.3.1731431594747;
        Tue, 12 Nov 2024 09:13:14 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cca37c9sm2630818b6e.21.2024.11.12.09.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:13:14 -0800 (PST)
Message-ID: <df2b9a81-3ebd-48fe-a205-2d4007fe73d1@kernel.dk>
Date: Tue, 12 Nov 2024 10:13:12 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] ext4: add RWF_UNCACHED write support
To: Brian Foster <bfoster@redhat.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-13-axboe@kernel.dk> <ZzOD_qV5tpv9nbw7@bfoster>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzOD_qV5tpv9nbw7@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 9:36 AM, Brian Foster wrote:
> On Mon, Nov 11, 2024 at 04:37:39PM -0700, Jens Axboe wrote:
>> IOCB_UNCACHED IO needs to prune writeback regions on IO completion,
>> and hence need the worker punt that ext4 also does for unwritten
>> extents. Add an io_end flag to manage that.
>>
>> If foliop is set to foliop_uncached in ext4_write_begin(), then set
>> FGP_UNCACHED so that __filemap_get_folio() will mark newly created
>> folios as uncached. That in turn will make writeback completion drop
>> these ranges from the page cache.
>>
>> Now that ext4 supports both uncached reads and writes, add the fop_flag
>> FOP_UNCACHED to enable it.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/ext4/ext4.h    |  1 +
>>  fs/ext4/file.c    |  2 +-
>>  fs/ext4/inline.c  |  7 ++++++-
>>  fs/ext4/inode.c   | 18 ++++++++++++++++--
>>  fs/ext4/page-io.c | 28 ++++++++++++++++------------
>>  5 files changed, 40 insertions(+), 16 deletions(-)
>>
> ...
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 54bdd4884fe6..afae3ab64c9e 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1138,6 +1138,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>  	int ret, needed_blocks;
>>  	handle_t *handle;
>>  	int retries = 0;
>> +	fgf_t fgp_flags;
>>  	struct folio *folio;
>>  	pgoff_t index;
>>  	unsigned from, to;
>> @@ -1164,6 +1165,15 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>  			return 0;
>>  	}
>>  
>> +	/*
>> +	 * Set FGP_WRITEBEGIN, and FGP_UNCACHED if foliop contains
>> +	 * foliop_uncached. That's how generic_perform_write() informs us
>> +	 * that this is an uncached write.
>> +	 */
>> +	fgp_flags = FGP_WRITEBEGIN;
>> +	if (*foliop == foliop_uncached)
>> +		fgp_flags |= FGP_UNCACHED;
>> +
>>  	/*
>>  	 * __filemap_get_folio() can take a long time if the
>>  	 * system is thrashing due to memory pressure, or if the folio
>> @@ -1172,7 +1182,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>  	 * the folio (if needed) without using GFP_NOFS.
>>  	 */
>>  retry_grab:
>> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
>> +	folio = __filemap_get_folio(mapping, index, fgp_flags,
>>  					mapping_gfp_mask(mapping));
>>  	if (IS_ERR(folio))
>>  		return PTR_ERR(folio);
> 
> JFYI, I notice that ext4 cycles the folio lock here in this path and
> thus follows up with a couple checks presumably to accommodate that. One
> is whether i_mapping has changed, which I assume means uncached state
> would have been handled/cleared externally somewhere..? I.e., if an
> uncached folio is somehow truncated/freed without ever having been
> written back?
> 
> The next is a folio_wait_stable() call "in case writeback began ..."
> It's not immediately clear to me if that is possible here, but taking
> that at face value, is it an issue if we were to create an uncached
> folio, drop the folio lock, then have some other task dirty and
> writeback the folio (due to a sync write or something), then have
> writeback completion invalidate the folio before we relock it here?

I don't either of those are an issue. The UNCACHED flag will only be set
on a newly created folio, it does not get inherited for folios that
already exist.

-- 
Jens Axboe

