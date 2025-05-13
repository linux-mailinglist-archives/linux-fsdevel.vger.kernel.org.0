Return-Path: <linux-fsdevel+bounces-48793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BBFAB496B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 04:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A994169CBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611421A23B6;
	Tue, 13 May 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFode5ES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AB1E485
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102787; cv=none; b=O3KcuMidtniA76nAZH4HbHhtfnERnmfCTT/M70x/9Rudm9Fcm5G5Q7/T0bkIN05pCoSd/naVTwJTVQPmQjwGeiTvkbQJun50xiz+51+xlUj7tvnyYbzf3A3oHESclttB8wXzYt1sqaF5eb8wDQa1xW0TSM6HkQIRgvHzRQT+BTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102787; c=relaxed/simple;
	bh=LGB3baewtKtCbtsPqatPJt7MdXUFUOo9ZPwlfIa/DJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTolQlMr1F3vYvyTloya3fb8CglhwHzC8yiAIAKc7JDr/UxUJkR1QaZMvTjZoPrsplIfinS7x+IxAKCufO/ABKndHqljWbYcdQo86FCT4aKX2lLiPyfD2OXeN2h6LpR8ZopdZ+vV2sdrBbCxUUqJvSX6nl/VjykwmjG2kzyGAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFode5ES; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747102784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXGmZpUQhQHospK+s/uw2hzAi4UtWT9eQTqWYOLnjEg=;
	b=iFode5ESz80+PlwBLqGUKEyJTFvFQFRglaMFWviUZk9Jya8FpBEGblVokkxK52/LeGkSkN
	6fcy1cKeFgvnS4ilflmhHAa8DR0YGKmlgxFIUdjfPB4DXQHM3SO8aVHCghkG9jJoHQf9JO
	GrAUpDTYGm5L33F2pjc3aZOpyHQE3kI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-mD1d2lZHNfihFOQaGOk67g-1; Mon, 12 May 2025 22:19:42 -0400
X-MC-Unique: mD1d2lZHNfihFOQaGOk67g-1
X-Mimecast-MFC-AGG-ID: mD1d2lZHNfihFOQaGOk67g_1747102782
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b5875e250so516029239f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 19:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747102782; x=1747707582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXGmZpUQhQHospK+s/uw2hzAi4UtWT9eQTqWYOLnjEg=;
        b=fr6Yf7mIfajAy6ch6uQzbLcZ83SGHITe4O0+dRxg/33w2Le6oPjTDGnl+nauYgzn9n
         7FmXnu7VjtZoDk/AyAe2b0+zJvNrxd6MyHsVRIQS0HiaXWFgkbJ8RwFYbHE/PBO/VYz5
         GNcDQigdEEzXIkXnyIBrAJr+1JQwMBrvCZ5AAW3xbHFr9/YhN3sDgtOe1LaaTsJ8aNXw
         eOUrP2ttJiQLPvXGCgvQrt7aFJQQsQH+WN9hQxNzATrxAOxNBTlVh38X1bhjVn8SHmPY
         nMBcvyZRN2x8yavzAQfw2cvYLHLkZ2cfcHjAHOpvChVmR/Qu3ZVrFG1zm9eQOqYjKSbo
         MqxA==
X-Forwarded-Encrypted: i=1; AJvYcCXJk7ykzLDAowzuRI/CniugVjREBC8tjliprUAsgXcBdo+dByMXmtkoyFEXpDWGl8gqEkGpN5ebSCMh1rC5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+cgs0fUobg2LstD49oTGgtc9UH6rDUrKKiWkQFlk3QyRbWSJ
	Te2++1EOItX9jVR62f9wIsK7kWFe996705RoHpsJdpUwbeMXJzZ1xeqhQSoVRPo4IoU86KTC8ay
	G+3tnvbKkFXSQniiUfnT13UfmM/Y9PKIwyfaU8olV4nnI3lGtLps7pwN0CeQY3Zg0hXIo3IA8kw
	==
X-Gm-Gg: ASbGncuSXSdNy2QYBirDbzThy5SRBPLiImLFDErDaa4gzKUTPh2S3XZI2xuLk2KrI1d
	S+RmpfOG6Vn4pfagKnXvI4PqwvolvooTEdCtLgjRBFoaKHUuo7A6dQmiLQNNG5CLigAItI9B6iU
	hqzFNu0+cPyU4x5FV3L7XdZFUIiBcUQDHUb2v4+MA2YOLogH3h2a8+6dve5zpBFmFyqZYkL+bXb
	U8zpE2g9fSoxewBecHN6dh8XS1Dxo/czQxK9t41LZGiV4kHobqoJq6BtqUma3WEaPkmYpjD4KTW
	sJ8AO63aDixUtgtHxtcB
X-Received: by 2002:a05:6602:6b8c:b0:85b:3763:9551 with SMTP id ca18e2360f4ac-867635af36amr1635756339f.7.1747102781988;
        Mon, 12 May 2025 19:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOhcalIREkiZVkrSscfcuGDC4czbYcy+koD4S+Yaopmch1H+xJBMcd1eUDEPUJlDM+wTm8Xw==
X-Received: by 2002:a05:6602:6b8c:b0:85b:3763:9551 with SMTP id ca18e2360f4ac-867635af36amr1635755139f.7.1747102781629;
        Mon, 12 May 2025 19:19:41 -0700 (PDT)
Received: from [10.0.0.82] ([75.168.230.114])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa2249ff80sm1899160173.16.2025.05.12.19.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 19:19:41 -0700 (PDT)
Message-ID: <3fe6be01-b9bf-4e26-b3f6-32dafe0a8162@redhat.com>
Date: Mon, 12 May 2025 21:19:40 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/7] f2fs: switch to the new mount api
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org, lihongbo22@huawei.com,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-8-sandeen@redhat.com>
 <b56964c2-ad30-4501-a7fd-1c0b41c407e9@kernel.org>
 <763bed71-1f44-4622-a9a0-d200f0418183@redhat.com>
 <74704f7c-135e-4614-b805-404da6195930@kernel.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <74704f7c-135e-4614-b805-404da6195930@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/25 10:43 PM, Chao Yu wrote:
> On 5/8/25 23:59, Eric Sandeen wrote:
>> On 5/8/25 4:19 AM, Chao Yu wrote:
>>>> @@ -2645,21 +2603,11 @@ static int f2fs_remount(struct
>>>> super_block *sb, int *flags, char *data)
>>>> 
>>>> default_options(sbi, true);
>>>> 
>>>> -	memset(&fc, 0, sizeof(fc)); -	memset(&ctx, 0, sizeof(ctx)); 
>>>> -	fc.fs_private = &ctx; -	fc.purpose =
>>>> FS_CONTEXT_FOR_RECONFIGURE; - -	/* parse mount options */ -
>>>> err = parse_options(&fc, data); -	if (err) -		goto
>>>> restore_opts;
>>> There is a retry flow during f2fs_fill_super(), I intenionally
>>> inject a fault into f2fs_fill_super() to trigger the retry flow,
>>> it turns out that mount option may be missed w/ below testcase:
>> 
>> I never did understand that retry logic (introduced in ed2e621a95d
>> long ago). What errors does it expect to be able to retry, with
>> success?
> 
> IIRC, it will retry mount if there is recovery failure due to
> inconsistent metadata.

Sure, I just wonder what would cause inconsistent metadata to become consistent
after 1 retry ...

>> 
>> Anyway ...
>> 
>> Can you show me (as a patch) exactly what you did to trigger the
>> retry, just so we are looking at the same thing?
> 
> You can try this?

Ok, thanks!
-Eric

> --- fs/f2fs/super.c | 6 ++++++ 1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c index
> 0ee783224953..10f0e66059f8 100644 --- a/fs/f2fs/super.c +++ b/fs/
> f2fs/super.c @@ -5066,6 +5066,12 @@ static int
> f2fs_fill_super(struct super_block *sb, struct fs_context *fc) goto
> reset_checkpoint; }
> 
> +	if (retry_cnt) { +		err = -EIO; +		skip_recovery = true; +		goto
> free_meta; +	} + /* recover fsynced data */ if (!test_opt(sbi,
> DISABLE_ROLL_FORWARD) && !test_opt(sbi, NORECOVERY)) {


