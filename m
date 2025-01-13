Return-Path: <linux-fsdevel+bounces-39056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD24A0BC21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E06188283F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3DC1C5D59;
	Mon, 13 Jan 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PUDsrASC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48B29D19
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782463; cv=none; b=tgv0H8/ecUTYWi2cawa6RQ0aUf4o5IkxzbUMZPXdTxWbdTVIbgpwkQWPr+f0d62/52KJm+CKLJT9pcgR2a3JmxQM2Jjm6oH6TVMvlKzC/QUjg9Ik4Xa1GwQ6P11wjbBIpcqO3I/Md7BkFmculEIJ5D/7qBeKJXQBsxErf5DAbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782463; c=relaxed/simple;
	bh=KFif0h9Z2iyeT/cC7vr7cdcNUZTAlVeVHVCZorx1GJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=by2i9+odEEjDTb0nYomit4kB3uztN4VlAewGMR3zi7TJY5v6C/p3B2tj5fb43N7CccxmVmtxUWW5ZBY8ewWaVKOX3DUdW65wxXA0ixx4yxqSarxGwn/4pyzxRGrP2Led9iG9bzQqSMijYps6/fkPau0UhM/M9AHcVso1PV7l6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PUDsrASC; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so160070139f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 07:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736782461; x=1737387261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEjZgb0EizZw0bzYqKOhvOuaHAC4ZwLKvUf+U47cO60=;
        b=PUDsrASCAXF4/opvCwzoBNdJmXDcqTgtezP+giX6TVAPO9c826OrN1nDmv3FSGKtQW
         n4juRws8ebHW8ULy4rvykOL6vfuwypxCmZXE3JrBxk2XKv7gbQBAXgm1bpj/w2/0isSQ
         wgNqtHtSIrbsCLi10Tw712nsAsQfh6bfesST1nHv6Juq8Eg1fW6lpKSfdfDJ8Se4d7l8
         uUqlVrLvksfWXguDP+Zp1Hk01giZOHNUZLDhlUoTaeC305vgWvOSf22oAFTgsG0b0hJJ
         deVrkjc2uacDAXFpE2g7XutkhZRtX7Edx1+Z35uG8iciUfrZ0zQEzIXIahh34gZxQaWN
         UeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782461; x=1737387261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEjZgb0EizZw0bzYqKOhvOuaHAC4ZwLKvUf+U47cO60=;
        b=YLt0fOfelKSULq4WJ3B49c4wvZRlEfWO7w+76XJ/wmW5icySNkBUu0pxkcusKBtKvq
         NSfjv7C1SeXCCanV2bnPMSo1otj5QUHanBc3qix4phjUBr97G77QZBo9VwkFBzvPVYTG
         2RP4qpSTQkpQfP1umOnhkJHNJyKnYYz+cr6SHeDZSqccqMBii0QzAc3V0xW3gGZBTgkl
         0FcDyieC0ztte5PGK7cYVj7xQBMIacVDjT8u/bZ6wUJZeLkv3MKnKNF+umyw5Y+k/592
         i8u9UDy/jFZjdnhxN7xHgBz8rWsAGS+KqqyUFJBa7hp1z+1w/ds/CJuKsLoOems7xTDY
         tP9g==
X-Forwarded-Encrypted: i=1; AJvYcCXkW0eG65Fj/s3JqBBRWRZO5pJtHnQvaRkBTl0V+oSVNkD+8XKJpt3taUS8OcEKrMk8tKlo6nWIuWmWRdbv@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ54BNSt6Il8W3e6n9cM3as/eejElntXGzTQuV2XQRe6VY0MAX
	UN39umi94CJ2MGRWFZNX3bqK101F+UpCk3cEh2BitOh9Gbk8Mk7r3hGB44k0OWoAL6MLwMadS85
	r
X-Gm-Gg: ASbGncvEhh32pOFOOHZH35dlJ/qBwGVmVPPnoUiRQ9hu6KQH7sj1m6Nisj5xEHxfxs9
	PVbmYf/Fehedw99TazNB6/SyogeyL82jYKkA1Mx5Sbt/Uv8KvdJekbepLfCBO5jxXaIg21mh2zb
	csCqVeFTwmQX7oVJ0D53YLNrcsMz7AtsA2iYRUBj6hbMaXjn3lHhttc6PWY4wy6XVv07nFQp//F
	J1Rsx1Ma4uiUWzBWIT1VNbthQGdYNLkipTOQfb17nJOf7b1GqZG
X-Google-Smtp-Source: AGHT+IHeWU+1/sgyx4t7fFAnRIeJMvyo+nWNiMDWMOBaX1uADlQszp0S1Zd+4roi1BcUC+HGm8i57w==
X-Received: by 2002:a05:6e02:2206:b0:3ce:6aa8:6c56 with SMTP id e9e14a558f8ab-3ce6aa86d30mr53055385ab.8.1736782460911;
        Mon, 13 Jan 2025 07:34:20 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce4adee7bfsm27398815ab.44.2025.01.13.07.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 07:34:19 -0800 (PST)
Message-ID: <3cba2c9e-4136-4199-84a6-ddd6ad302875@kernel.dk>
Date: Mon, 13 Jan 2025 08:34:18 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v8 0/12] Uncached buffered IO
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20250107193532.f8518eb71a469b023b6a9220@linux-foundation.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250107193532.f8518eb71a469b023b6a9220@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(sorry missed this reply!)

On 1/7/25 8:35 PM, Andrew Morton wrote:
> On Fri, 20 Dec 2024 08:47:38 -0700 Jens Axboe <axboe@kernel.dk> wrote:
> 
>> So here's a new approach to the same concent, but using the page cache
>> as synchronization. Due to excessive bike shedding on the naming, this
>> is now named RWF_DONTCACHE, and is less special in that it's just page
>> cache IO, except it prunes the ranges once IO is completed.
>>
>> Why do this, you may ask? The tldr is that device speeds are only
>> getting faster, while reclaim is not. Doing normal buffered IO can be
>> very unpredictable, and suck up a lot of resources on the reclaim side.
>> This leads people to use O_DIRECT as a work-around, which has its own
>> set of restrictions in terms of size, offset, and length of IO. It's
>> also inherently synchronous, and now you need async IO as well. While
>> the latter isn't necessarily a big problem as we have good options
>> available there, it also should not be a requirement when all you want
>> to do is read or write some data without caching.
> 
> Of course, we're doing something here which userspace could itself do:
> drop the pagecache after reading it (with appropriate chunk sizing) and
> for writes, sync the written area then invalidate it.  Possible
> added benefits from using separate threads for this.
> 
> I suggest that diligence requires that we at least justify an in-kernel
> approach at this time, please.

Conceptually yes. But you'd end up doing extra work to do it. Some of
that not so expensive, like system calls, and others more so, like LRU
manipulation. Outside of that, I do think it makes sense to expose as a
generic thing, rather than require applications needing to kick
writeback manually, reclaim manually, etc.

> And there's a possible middle-ground implementation where the kernel
> itself kicks off threads to do the drop-behind just before the read or
> write syscall returns, which will probably be simpler.  Can we please
> describe why this also isn't acceptable?

That's more of an implementation detail. I didn't test anything like
that, though we surely could. If it's better, there's no reason why it
can't just be changed to do that. My gut tells me you want the task/CPU
that just did the page cache additions to do the pruning to, that should
be more efficient than having a kworker or similar do it.

> Also, it seems wrong for a read(RWF_DONTCACHE) to drop cache if it was
> already present.  Because it was presumably present for a reason.  Does
> this implementation already take care of this?  To make an application
> which does read(/etc/passwd, RWF_DONTCACHE) less annoying?

The implementation doesn't drop pages that were already present, only
pages that got created/added to the page cache for the operation. So
that part should already work as you expect.

> Also, consuming a new page flag isn't a minor thing.  It would be nice
> to see some justification around this, and some decription of how many
> we have left.

For sure, though various discussions on this already occurred and Kirill
posted patches for unifying some of this already. It's not something I
wanted to tackle, as I think that should be left to people more familiar
with the page/folio flags and they (sometimes odd) interactions.

-- 
Jens Axboe

