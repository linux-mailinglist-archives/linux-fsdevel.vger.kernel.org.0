Return-Path: <linux-fsdevel+bounces-37185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCDF9EEDE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEFD286450
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CF022145E;
	Thu, 12 Dec 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z13txCqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEC4F218
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018681; cv=none; b=TngfGLmuYaA8M1H0I4kMdYV9WO099lqI61XtSwsP2/4V+ltamv9wRaAc6VCIyaSKkgVfk03cTjxfXNYBJbd5uesDm5LdY9Drscl779UW4b93qI/Tfc92mpXBfSqfM5foNsA3aWOa0vL350f8sF5zdCjW/sZERfQxDrhQM7Jxt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018681; c=relaxed/simple;
	bh=9J8jgbGZLhDCNXQIcS/IOQVlyOG+dfCc22YlvHx/Cmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSBhAaCFfPaI9OWATfZyIophyFniQ0CeA30+UaIshGEdtMXU9w1FN0T1VPD02jROc3yVOEtPrOXtsJsoL7H8YELk93vm0g5H6PZ+YsSWt646hJQR6s/3iNQuBVypNBB8KX4+UtcCPZYVoXIIzOsJwwh+jvada7x15YI+TWl5fPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z13txCqD; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844c165bb04so26949139f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 07:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734018679; x=1734623479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvdjuc+ov0Ox3XKRZz9jrd61LllD+9QFwqPFhdFIKF0=;
        b=z13txCqD/dsUWtKVnp9uSCwCfn5RDFufQTCYpZftcNldL+O+JKcoeX0HswelpBcS35
         1h2KJtyV5SqH9nV9N7WX7Cr9uh6A9iAveeOMvlj7Niuxk8CZRJDxSik3yivx4iXTMBEI
         tsfxblcl614/znEPPyFTvUlNT1D/EOrSgN9PObq02Y0vFc3CAmnp/vUGdTerc/65hPry
         W2Erp8kCZeenyIcKUDGbIoLCxGfErpqFKHYaYrkSj+5VBsPdU3TVdeON9JuUnR+Dq+kM
         JbUNrYWK4hfuxEimpBTN3T54BuwYW++N7SFclhAcW+Czf5SI5uOKKs0EpJPem6CFGZ9M
         DL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018679; x=1734623479;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvdjuc+ov0Ox3XKRZz9jrd61LllD+9QFwqPFhdFIKF0=;
        b=bhJ1Zj5QYyKnzc0XKyEnFTLuTBIdXza4n5D2LUrpl7v+LMc+h2U14f9kUxRO7haGhn
         krYNcqvrjW7DgMhem/GMsbkf5Bpuk0CyerKRx83nLO+9XsZHYJ1lz++4rG86lhb7cT+0
         xWENYbHKCXIq+3T82CbAVwQsxJAecyv0K/xUf+mDuj0AWg8qqtyoU1mKztODd6vkHS7R
         4Oy1N+u6kTS8ckciesTnfmLtAga7zR4YI7gpJO7KBJBZzUbZ6XVsb1QStPSE+HHxahL1
         ucgSeJkPHmudOkPrOkeL6f9xL3YynHU/VQySMdCCjm/YrJ1mNQA1S4T9dZO+akCIizKO
         PKeA==
X-Forwarded-Encrypted: i=1; AJvYcCVXnWdRCW+fG2q9pTju7sDQFr8k79GWe6nxX10Vbt4Oklhy9Pp3MbOAbGD6W7ZxsXzIwuMISDA1jDNsBR+9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1armcWtuO6ZSu6qeRad5WzgNDVoBhKrM57AF1/epl6QI0JUB6
	zuUC3WPmevejR5UJzV4nFnZAMNujDXa2ltZwdap0qoMi3ey5NJfNQ4XVrCtNr70=
X-Gm-Gg: ASbGncuO5QDVWHZ1asxBDJJRJUfA04pBdtUubFShwY5vpTY7fYtO+o4B74hgwb1NGWF
	R4n0VGXbtqPA3Tjux1CYcSYiW4eESjm3YMA3ylxR2npfWxqszsYA6JQS1AQhO9/otXdC5FOt8MB
	lfLWRPyhCBXjJOyVKXVjKCKl5ay0/k4mxV8xiT/DZRB42H7oxcuy8k1BCCI+0RnA3QVDGBXFVST
	eYxO8MdswT8X2qiL9rTrfyeFx/rXN7YFHpRaVgrpeD9Pluvm1jI
X-Google-Smtp-Source: AGHT+IGuinfFR09bO8lUOpxQ1zSi+sA0KfqYwuqKm9s7gPVryn5wyMJJDgrJmONT7vL8CQbH+cZ8kQ==
X-Received: by 2002:a05:6602:6d0c:b0:843:e008:95b7 with SMTP id ca18e2360f4ac-844e552b920mr79385139f.0.1734018679383;
        Thu, 12 Dec 2024 07:51:19 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e286222d9dsm3865412173.148.2024.12.12.07.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:51:18 -0800 (PST)
Message-ID: <e492e934-c162-430a-94b6-32d1ec29a782@kernel.dk>
Date: Thu, 12 Dec 2024 08:51:18 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] mm/filemap: make buffered writes work with
 RWF_UNCACHED
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, kirill@shutemov.name,
 bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-13-axboe@kernel.dk>
 <20241206171740.GD7820@frogsfrogsfrogs>
 <39033717-2f6b-47ca-8288-3e9375d957cb@kernel.dk>
 <Z1gmk_X9RrG7O0Fi@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <Z1gmk_X9RrG7O0Fi@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 4:31 AM, Christoph Hellwig wrote:
> On Fri, Dec 06, 2024 at 11:22:55AM -0700, Jens Axboe wrote:
>>> Honestly, I'm not a fan of foliop_uncached or foliop_is_uncached.
>>
>> It definitely is what I would elegantly refer to as somewhat of a
>> hack... But it's not _that_ bad imho.
> 
> It's pretty horrible actually.

Tell us how you really feel :-)

>>> I think these two macros are only used for ext4 (or really, !iomap)
>>> support, right?  And that's only to avoid messing with ->write_begin?
>>
>> Indeed, ideally we'd change ->write_begin() instead. And that probably
>> should still be done, I just did not want to deal with that nightmare in
>> terms of managing the patchset. And honestly I think it'd be OK to defer
>> that part until ->write_begin() needs to be changed for other reasons,
>> it's a lot of churn just for this particular thing and dealing with the
>> magic pointer value (at least to me) is liveable.
> 
> ->write_begin() really should just go away, it is a horrible interface.
> Note that in that past it actually had a flags argument, but that got
> killed a while ago.
> 
>>> What if you dropped ext4 support instead? :D
>>
>> Hah, yes obviously that'd be a solution, then I'd need to drop btrfs as
>> well. And I would kind of prefer not doing that ;-)
> 
> Btrfs doesn't need it.  In fact the code would be cleaner and do less
> work with out, see the patch below.  And for ext4 there already is an
> iomap conversion patch series on the list that just needs more review,
> so skipping it here and growing the uncached support through that sounds
> sensible.

I can certainly defer the ext4 series if the below sorts out btrfs, if
that iomap conversion series is making progress. Don't have an issue
slotting behind that.

I'll check and test your btrfs tweak, thanks!

-- 
Jens Axboe

