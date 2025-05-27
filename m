Return-Path: <linux-fsdevel+bounces-49879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1205AC45C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 02:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4F81899F08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 00:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDFA35942;
	Tue, 27 May 2025 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0e9NIVNx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3101FDA
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748307531; cv=none; b=rY4qtxyACS5cYxTJsKVqS76sFZiH+jsuYyqiYNIcE5FBojmWshDnyLuAdLwb+bopI9uxNvlTxSmv9YpeU5NJWDkk+hZvRS9wIY4+6Umuer9sswkFmQaVuhld46EjD/fhuaJyaN+MjG7+R3w+L38180AfK3WBiGMvX9+RnePo2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748307531; c=relaxed/simple;
	bh=66UiS5OYgh8IFkWbgTHxBSc/S3KCZ3W+mF52qbKkK2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNswSHTPCZ5EExp/RaUvEMupamtVesQKtSZS1tVF6RmwgEJm8hWBoaxWfSnDtg/3oN9jO4/U+151cX13/wzcv1v4fRb/AE7GkHv04KSdnBKR1XGKrMwv1u9IZ9miPE7UR3OXuZ8Uc9VMlUY/1AS67xZLwRsZFC9HFKHcrwVpBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0e9NIVNx; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8644aa73dfcso52231939f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748307529; x=1748912329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gm07eJdxPzf1K7//mAsLjXwz0qaJqCkubYgceAMiovQ=;
        b=0e9NIVNxG9oSbEVI1RPhkSe9g/O32blhJGRa7pC6tbXXpyjw4QYsat9UJsim+NL6FI
         X+a78VTKjeewIvt6tjECrLp1+V8VmTb/YwoptlnlBdxGW6jDNX7W5zZeV9S3OHW8HI4U
         cqn2LIWGBV0jloHaI2u7JLWJw1Em9vuDRwr/cwD9jaj+ZkAnhc5S0X2E3iUhvN9pbXEU
         k4QPfRs1o66cF/tgMMjzD3nlqws6DGH6NJhDb1rxHncPTbatFFEReemI7eN2ArgI328s
         VjohQPxQE7bJb+oPBhn893q/5OsPNpnEv8ag1WWTNjAapKbolKL87J04aBWf19cnjC4D
         5E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748307529; x=1748912329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gm07eJdxPzf1K7//mAsLjXwz0qaJqCkubYgceAMiovQ=;
        b=TmDd4Dd23rzaUNHmpFQJ16t18gjE3et1gjY3cHW6CfZLc8ixqt76Q5STHW95NM5oA+
         Ig/UPUKMmdO5nMicKJO2wydJ4YD9A+VVhIZxsMHquzhaGSTlCEMIJEeBCOiHLwgGpdby
         lc3QbPJcMckNs5SXoNVZ8NArQG0vkwCvgksW94ZWT6dn6SKj0cC8DA0p7/klXvUVUKt2
         nUOdsEqVPtcYMxQW/LebwGqkIcDpunOTY2+7pud76CeyGIvymuOGDCR0g0I6HHz9ecWq
         A2MzN8qSCdosgZtHSfw7q1UQhp7b7typjxg7bnWPTOHxqr2DnIc+eckSu54HCaeT0n5e
         SPxA==
X-Forwarded-Encrypted: i=1; AJvYcCV6nDYHYoACDcUWGkHfArDd82FeUgkFOEIj+2LobVMhYphkO5q2ABmoTWUG6D1d1JBZCLrOS1m8TYSVp/lt@vger.kernel.org
X-Gm-Message-State: AOJu0YxrnkQJCCbB/8FFQU5v5sCTnvL1t05ofOV++H74dZQYVkzibjNW
	Rp27EU4wEPVTQLyIqc1zlVImyKZmzofZeDPHAHvBW6iPh1A3xRArSd3B+ZVmqmadGZQ=
X-Gm-Gg: ASbGncvHHeYHy0ioh9Yor4911FUccVD4AplFb+TBGdha4ZwCwETY2oXTlbYhESTe5JD
	/Ya0kUCfx6KJ+Oj56DqLQBkryH/Y1dozs7Y7Rs2rOZatpNzcr/Pa47gK0legjOT5Ui87yrQ19Ef
	8QfNdYHEbj92OHNwtzsiWn+P4kRsuzSr/kPlpW+Qu85zRnb4YBLB5SsPKcMioMkcQPUiztm+dPf
	JOcUrLnRzDyJ9M2meIkXnoQCsLirc3A2+P0wDX1iyQ3uW6NGScF4TmJLsGzGbBtupH222Kc5pfE
	KfQ5j3WkMeyAexaErfm7Vpm9e5uO5BgW2rTEywlOC2pfNux/
X-Google-Smtp-Source: AGHT+IH84nYxse7WyRqLio8jv/SgQ3IF2W7NfndvmuVrFEQwCdc63gAUNtlwc/XpEdCo9UT6NxwE3A==
X-Received: by 2002:a05:6602:4a0d:b0:85b:619e:4083 with SMTP id ca18e2360f4ac-86cbb88bc57mr1045096639f.10.1748307529541;
        Mon, 26 May 2025 17:58:49 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a2360ca28sm492852239f.25.2025.05.26.17.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 17:58:48 -0700 (PDT)
Message-ID: <5a66f3f5-7038-4807-b744-d07103ebaea2@kernel.dk>
Date: Mon, 26 May 2025 18:58:47 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 "Darrick J. Wong" <djwong@kernel.org>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20250525083209.GS2023217@ZenIV> <20250525180632.GU2023217@ZenIV>
 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
 <431cb497-b1ad-40a0-86b1-228b0b7490b9@kernel.dk>
 <6741c978-98b1-4d6f-af14-017b66d32574@kernel.dk>
 <3d123216-c412-4779-8461-b6691d7cafc7@kernel.dk>
 <20250526235600.GZ2023217@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250526235600.GZ2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 5:56 PM, Al Viro wrote:
> On Mon, May 26, 2025 at 11:38:53AM -0600, Jens Axboe wrote:
>>> I'll poke a bit more...
>>
>> I _think_ we're racing with the same folio being marked for writeback
>> again. Al, can you try the below?
> 
> It seems to survive on top of v6.15^^

Thanks for testing, Al! Assuming it goes without saying, but that's 6.15
with 478ad02d6844 reverted, right?

-- 
Jens Axboe

