Return-Path: <linux-fsdevel+bounces-21981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587791099E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3066D28262D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF33E1AF68B;
	Thu, 20 Jun 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3TMjM+Ft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C91AB91B
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896743; cv=none; b=kQMIj4mFmI6YZ4VF7dYPXVSVEbJECJFE1uGw+eRYwvjjxoxM4Zl+X3XWMMfqYhXfjTOIhZPlYhai0vVB74ZrpRC6m778UmLLAh04uYpcQfxkHM6t+6IpLKQig8LJAkETnh5gsYzNsP3eKJoc+ela0zxpTZZ90QSJovASmibGMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896743; c=relaxed/simple;
	bh=gKkWo0rcrIjAELXC3rvqdnuDWSiqfQHX4Q+aPrtxxc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsWunem+kf2ZF6Kfa+j9gFa5O/WHk4jGZRw0xLtK592bhjwwUSW0ZWtbAaFgFsjiGcKT3Xm0V+kUWBgbieTZszhxTL77nYsFBE9v6qkK2M7HyCfPtreRQJvVVGZKlO1uR9LDPBbi0SQSoLNT2YCBheYRGaaDwqjQUJWfLMPeGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3TMjM+Ft; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d1b6b6b2c5so39804b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718896740; x=1719501540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bg9dUhZOcOBUNZKG8Aq376MeF6BjTDCioQTFTxLs8Rs=;
        b=3TMjM+Fty95tqkl0uq/4UtBZEDu8m0LNe8XEnv04+wV5iogyZjxbUyDAsjr9//MJ7i
         IBDw59Tr3NxJVe4FgapP+nB3RyGf7GlYzcpkIjnoFnbdgwFNtoL33nz9715o8H+ZSQqD
         j4/lAmDnRVZf0rxfYnb66oq3xYU14Tmc207MZS8YcfzURE5fQRgcBrlLWmweXOzWeSTm
         ZmjZ/pzmSTAIe8/NZJ1p95R1aSH4Szk6latO54P948WhjYa3uFfWcybSja4ACVkdQ/eX
         mIsnyuqmvQUFXrBhZc3ghd8KvSUfj32xCr+/YIm2G6n+Q3RfupWGVWso3ld62NAlr+Z5
         r/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896740; x=1719501540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg9dUhZOcOBUNZKG8Aq376MeF6BjTDCioQTFTxLs8Rs=;
        b=k1p92hpyy+1f1JjsN5ZIXgtJ68VWJdxyiZ2+N40Hg0uGtajewHr5r+oHRxlGZM+nhE
         M1gVR0mbJhQAZQxYdwr5ZISDwFZSOqGWAH7fXQuVgT3hRx1iAPGiE+lwRH1qgCnpBrOL
         s0tHxnGrUNkqGlVRY76gmipEY4K15weiwq6G9qOz3Y7pDImYtl3iyU3P/vwH+0YkFj2w
         7I0QYljPYzWbuxGg3IsgBZ2eWOvy1bPaEffZfKy0y+JSToIPec4CxcnLA+vGUhxOFKCm
         Y4H4ah1elMCkeT9N4OUhuZUrHwSZR9VyHryD5ZGUUUZlnyrDowJZX5EqJwfP1iW5Zn8W
         NF9w==
X-Forwarded-Encrypted: i=1; AJvYcCUObc5fAv29cGCQ27YOuffl+J5nz21E9JDAD9VKsRDshlXQ0zaoalocU9jI404rXsIcyPrP24Egn+VGVLgXOh6U4uMidqvwWqBA75trBg==
X-Gm-Message-State: AOJu0YxrgIGT6/etcX8RAs/rrPWpQGfyQFE4CTS2p/hYvhPsCaawFlt/
	i7zyDIQpT1jJv/wRFMzfNE9M1b4BbKwMm/l5TZn1t/TSm5HLFcV7acIcTGb3DrA=
X-Google-Smtp-Source: AGHT+IFqdBnwgZVg8xIJS0ZdFswsi7ckSZACE4V7rQa8sePkDWpTwP1Yim6PqDI2SIlHvgaftjT1eg==
X-Received: by 2002:a05:6808:1a07:b0:3d2:1b8a:be58 with SMTP id 5614622812f47-3d51bb164eemr6083028b6e.3.1718896740525;
        Thu, 20 Jun 2024 08:19:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d247605f99sm2536749b6e.19.2024.06.20.08.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:19:00 -0700 (PDT)
Message-ID: <861a0926-40bf-4180-8092-c84a3749f1cf@kernel.dk>
Date: Thu, 20 Jun 2024 09:18:58 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bvec_iter.bi_sector -> loff_t?
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, hch@lst.de,
 Keith Busch <kbusch@kernel.org>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
 <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
 <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk>
 <ZnRHi3Cfh_w7ZQa1@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZnRHi3Cfh_w7ZQa1@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 9:15 AM, Matthew Wilcox wrote:
> On Thu, Jun 20, 2024 at 08:56:39AM -0600, Jens Axboe wrote:
>> On 6/20/24 8:49 AM, Matthew Wilcox wrote:
>>> On Thu, Jun 20, 2024 at 10:16:02AM -0400, Kent Overstreet wrote:
>>> I'm more sympathetic to "lets relax the alignment requirements", since
>>> most IO devices actually can do IO to arbitrary boundaries (or at least
>>> reasonable boundaries, eg cacheline alignment or 4-byte alignment).
>>> The 512 byte alignment doesn't seem particularly rooted in any hardware
>>> restrictions.
>>
>> We already did, based on real world use cases to avoid copies just
>> because the memory wasn't aligned on a sector size boundary. It's
>> perfectly valid now to do:
>>
>> struct queue_limits lim {
>> 	.dma_alignment = 3,
>> };
>>
>> disk = blk_mq_alloc_disk(&tag_set, &lim, NULL);
>>
>> and have O_DIRECT with a 32-bit memory alignment work just fine, where
>> before it would EINVAL. The sector size memory alignment thing has
>> always been odd and never rooted in anything other than "oh let's just
>> require the whole combination of size/disk offset/alignment to be sector
>> based".
> 
> Oh, cool!  https://man7.org/linux/man-pages/man2/open.2.html
> doesn't know about this yet; is anyone working on updating it?

Probably not... At least we do have STATX_DIOALIGN which can be used to
figure out what the alignment is, but I don't recall if any man date
updates got done. Keith may remember, CC'ed.

-- 
Jens Axboe


