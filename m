Return-Path: <linux-fsdevel+bounces-34520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C5A9C60BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A251F232CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F68217F35;
	Tue, 12 Nov 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="caSx4oKt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81547208990
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437284; cv=none; b=shStOv1qzNffKNc5JJUVsovhDB3i6swvH2YskeUvKBXX9J4xfE3yc+JcOlItd48pCkn2DhHFQC1uDM9V6dLvG3+NjqfzrdKNusBBwZvCewT62fG6zLBDStL1UQ0O4/sg8C7HNlsA/tBRGV+n8JKBnAICXtn9b1A6u6ONka7Z1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437284; c=relaxed/simple;
	bh=AYu6tM5ynIawKqMjM+E4hN+OaSd/oaQv1ZLr8hqDLcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7aH1S2OREbXa2DdXCAnQhIe/ZgYGweNmONc619GM4WE90pb532wF4rCiWr/E3tRhdZLr8/OkzzgN6LeDzqnESEeOfqhikQv7oWrQp+/MVh80hLjFzBqV/jE3C6q2Ei6uHH5vU1mvauUir5yglLkI7f7lrJQFN4PdIqJlWB/+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=caSx4oKt; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e619057165so3457140b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 10:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731437279; x=1732042079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEKWtbV5azCN1LS/TrOFInpSTESMK9RCRhSvphgR+zE=;
        b=caSx4oKtmrQnPiyw17x0o0KCIcSdXPDLG5uPL1f0G2zGbUKsz71wdhVPXAf+DwOG/4
         AVfqb6MtbcIxM3YRR/u2DvQ+fbR+FgOLuOh2h9ZibBLeB8r8couIsGtWpqE67aTJrWZ0
         cuwuKPW/Ks+iiSNBp9P82kI10kVc8uVYTfKLPck84BBte2nT+Yq6L5I6mF8zraChgP/N
         HiZnHX/bp3rqReJBJg16vs+0XDEiKjoYIIBo0g1gaqO9UW1a8YkIZZhbg8Td+fq9+cHA
         WhkyNBYK0UyxntaaQ+feaGPvIXlX1zDLuU6AFPh1aXkbt7lwQdUL4YzNhhqPkwDQYu9X
         vhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437279; x=1732042079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEKWtbV5azCN1LS/TrOFInpSTESMK9RCRhSvphgR+zE=;
        b=Wc+tt9umrK580nmaOxEoY2FDOik32ZV1JEqArKWS3/6sEjjF+wpPFUVCQknq2/1VkY
         qZ3Irktuvw84vavpLgf9K8BSk32a5Nu8RnUB0C1DCEW3bD/AOiFLs8It5LEDhRacZj+F
         RHTdbpm8QyJWDJk9tmzT8fUVytH8/2T7xXBHOECVZELBj8/RLHDdqiVVufhPjxmRR9Ie
         FTIkhhS2X97M8J4V8Sp4hgeHLPo3abHAX7HjAEdrujw9yoFQgIPnMuRgZ0u7sU8L7du2
         RBp61K78P2BhriYs3jdwFAxDyf0Vd4A47NLfBgcmixOwfdisjnUFk2XHM8xhWSAX5LY9
         hljA==
X-Forwarded-Encrypted: i=1; AJvYcCV+R5VD0BZPhnn8R3Yes1tJjcMsqPBRaXaEv0FF7KB5dov/bqmZWsJ5YgsOPWzdjk3zaZvC3AQuMCgzcvxx@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsE1O7xB6zJTMjCMf6SFt5KjfxU5N90fEsRRTzjOmRCRK/Pi3
	Mu7t8dzzNs6sMBgpAfNwS9uxreVlQEIAeYkyAx0hJgzu+a3m21Ebws6NZyM+4T4=
X-Google-Smtp-Source: AGHT+IEbUQIAv8rwvNy1b5k48spMrO6qHPjvfMhK8WTkm9KlJBHwjMMwhaZ9S+HNwCgrodi6AerXxg==
X-Received: by 2002:a05:6870:20a:b0:25a:eca3:6b5e with SMTP id 586e51a60fabf-2956004793fmr13932152fac.9.1731437279605;
        Tue, 12 Nov 2024 10:47:59 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e8eb8c53sm14182fac.8.2024.11.12.10.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 10:47:59 -0800 (PST)
Message-ID: <58ebc5a8-941b-4c3d-a3b2-3985d7eeea30@kernel.dk>
Date: Tue, 12 Nov 2024 11:47:57 -0700
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
 <df2b9a81-3ebd-48fe-a205-2d4007fe73d1@kernel.dk> <ZzOaaInUHOmlAL-o@bfoster>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzOaaInUHOmlAL-o@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 11:11 AM, Brian Foster wrote:
> On Tue, Nov 12, 2024 at 10:13:12AM -0700, Jens Axboe wrote:
>> On 11/12/24 9:36 AM, Brian Foster wrote:
>>> On Mon, Nov 11, 2024 at 04:37:39PM -0700, Jens Axboe wrote:
>>>> IOCB_UNCACHED IO needs to prune writeback regions on IO completion,
>>>> and hence need the worker punt that ext4 also does for unwritten
>>>> extents. Add an io_end flag to manage that.
>>>>
>>>> If foliop is set to foliop_uncached in ext4_write_begin(), then set
>>>> FGP_UNCACHED so that __filemap_get_folio() will mark newly created
>>>> folios as uncached. That in turn will make writeback completion drop
>>>> these ranges from the page cache.
>>>>
>>>> Now that ext4 supports both uncached reads and writes, add the fop_flag
>>>> FOP_UNCACHED to enable it.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>  fs/ext4/ext4.h    |  1 +
>>>>  fs/ext4/file.c    |  2 +-
>>>>  fs/ext4/inline.c  |  7 ++++++-
>>>>  fs/ext4/inode.c   | 18 ++++++++++++++++--
>>>>  fs/ext4/page-io.c | 28 ++++++++++++++++------------
>>>>  5 files changed, 40 insertions(+), 16 deletions(-)
>>>>
>>> ...
>>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>>> index 54bdd4884fe6..afae3ab64c9e 100644
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -1138,6 +1138,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>>>  	int ret, needed_blocks;
>>>>  	handle_t *handle;
>>>>  	int retries = 0;
>>>> +	fgf_t fgp_flags;
>>>>  	struct folio *folio;
>>>>  	pgoff_t index;
>>>>  	unsigned from, to;
>>>> @@ -1164,6 +1165,15 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>>>  			return 0;
>>>>  	}
>>>>  
>>>> +	/*
>>>> +	 * Set FGP_WRITEBEGIN, and FGP_UNCACHED if foliop contains
>>>> +	 * foliop_uncached. That's how generic_perform_write() informs us
>>>> +	 * that this is an uncached write.
>>>> +	 */
>>>> +	fgp_flags = FGP_WRITEBEGIN;
>>>> +	if (*foliop == foliop_uncached)
>>>> +		fgp_flags |= FGP_UNCACHED;
>>>> +
>>>>  	/*
>>>>  	 * __filemap_get_folio() can take a long time if the
>>>>  	 * system is thrashing due to memory pressure, or if the folio
>>>> @@ -1172,7 +1182,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>>>  	 * the folio (if needed) without using GFP_NOFS.
>>>>  	 */
>>>>  retry_grab:
>>>> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
>>>> +	folio = __filemap_get_folio(mapping, index, fgp_flags,
>>>>  					mapping_gfp_mask(mapping));
>>>>  	if (IS_ERR(folio))
>>>>  		return PTR_ERR(folio);
>>>
>>> JFYI, I notice that ext4 cycles the folio lock here in this path and
>>> thus follows up with a couple checks presumably to accommodate that. One
>>> is whether i_mapping has changed, which I assume means uncached state
>>> would have been handled/cleared externally somewhere..? I.e., if an
>>> uncached folio is somehow truncated/freed without ever having been
>>> written back?
>>>
>>> The next is a folio_wait_stable() call "in case writeback began ..."
>>> It's not immediately clear to me if that is possible here, but taking
>>> that at face value, is it an issue if we were to create an uncached
>>> folio, drop the folio lock, then have some other task dirty and
>>> writeback the folio (due to a sync write or something), then have
>>> writeback completion invalidate the folio before we relock it here?
>>
>> I don't either of those are an issue. The UNCACHED flag will only be set
>> on a newly created folio, it does not get inherited for folios that
>> already exist.
>>
> 
> Right.. but what I was wondering for that latter case is if the folio is
> created here by ext4, so uncached is set before it is unlocked.
> 
> On second look I guess the uncached completion invalidation should clear
> mapping and thus trigger the retry logic here. That seems reasonable
> enough, but is it still possible to race with writeback?
> 
> Maybe this is a better way to ask.. what happens if a write completes to
> an uncached folio that is already under writeback? For example, uncached
> write 1 completes, submits for writeback and returns to userspace. Then
> write 2 begins and redirties the same folio before the uncached
> writeback completes.
> 
> If I follow correctly, if write 2 is also uncached, it eventually blocks
> in writeback submission (folio_prepare_writeback() ->
> folio_wait_writeback()). It looks like folio lock is held there, so
> presumably that would bypass the completion time invalidation in
> folio_end_uncached(). But what if write 2 was not uncached or perhaps
> writeback completion won the race for folio lock vs. the write side
> (between locking the folio for dirtying and later for writeback
> submission)? Does anything prevent invalidation of the folio before the
> second write is submitted for writeback?
> 
> IOW, I'm wondering if the uncached completion time invalidation also
> needs a folio dirty check..?

Ah ok, I see what you mean. If the folio is dirty, the unmapping will
fail. But I guess with the recent change, we'll actually unmap it first.
I'll add the folio dirty check, thanks!

-- 
Jens Axboe

