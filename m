Return-Path: <linux-fsdevel+bounces-34257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E062C9C41F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBD2B25256
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B52D1A725A;
	Mon, 11 Nov 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QdiEfuVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A771A7044
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339208; cv=none; b=filX2hiUvpCPhaZOwzL9SInUUdsLNjoxdfUKXbR5as38FhaccHKjoo/K5wNeG7RyWcb54/gUjXN+QjDEIUIjLT7gTUm1KXJLUTZVSS8EvbApFDQA/YydFhgBzvL/YJrjP54uoG79KstGghO2oZW5WKeD2RjKNoTdCW9uWQUaPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339208; c=relaxed/simple;
	bh=mnmWnMJ1p65+ROrZL1pP1XarnnoqZCK4RycEKhUHhV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3CS6IpykWfSKYYwiQ4Lkp4oxtSxRPblo3TEtGlhh1G0UGcd0WnHizcEcyUK0SL/44+Stlw6bVEMsAqkH1WQutW0UyMALedotVx9Dn5LjV8heUQFlz3+/SJ40+4Jlr3JhtzpfA0uTEMKLZ+4yCAP1gwztMd45bdn/NWVZrsUppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QdiEfuVK; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ebc0dbc566so2079854eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 07:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731339206; x=1731944006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSaM3wD2yHDEqpYEy+uQ9GLYH+06AGIhh2KoDFmh1b4=;
        b=QdiEfuVKGKxKpBXrJa5QHvIlZ7YCNHXZK0JnS3hKYUCd51QyxI47HOWZ3vO0Ez/Y4m
         l8jQj7Z+OEwDTz8aD8CGYfENuT5mC1GcUOUSmCbrz9vh/6aQhuIHvTpUsdWua9DQIjNO
         zk+JtoLlbZATgaGjKlaEEsPXd7KiNAxJT5HzeSkFCeTG2O8/ddx+MPf0A+XvXY51myKs
         pszXsN7+eAUcp3fESi8jW9WHrwnxJvNoL9+nFzOC4obs0mpfzeK3i4dA/pMuwo6J+muc
         K7QZZL31LQTbq/SiMKGAerLssvxOoqqk4wcS+djfYXuY12fgQ64LtNTjS1FyaO231L0O
         VsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731339206; x=1731944006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSaM3wD2yHDEqpYEy+uQ9GLYH+06AGIhh2KoDFmh1b4=;
        b=UQfENH80Rx6o+/F+tcsQDaKzgIzmwp/ne8d2ja4NAHvCpIdeHe11KTiGJp4p5LOtuV
         Z8iffUo9pHiTnoFicJV0pr2cU3oy65EE1TpA16P0s+J+voSXkV541P0K+Wwoue+gYdH1
         vCiaUfOdExPJw+2GCmNCeWEUSrhayId7wy+ADzvZIT0+oN6/k1DuYPxYtwRgmGVsrkpn
         rdKoZW4VBlTEDTkWRCQgN/xPb3ARX6KPl7Gqu3oaOY/yWmPmYZWbKVPt+9eAgigfVjjN
         h+zHP1jf2jK9WW8pNvWhsHUVnwoRoMvafwsslKxeQ/c61uj7BAbYf8G2+kHKJR0/5CgN
         HDiA==
X-Forwarded-Encrypted: i=1; AJvYcCUp9uW4A8tYIxu9GEjT433Vt06kmtZEf5bsyPjYDP6z4vmbTDuZM19ZWMrnmsl4lFSiBkO5vls4wDEufaOr@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3Mylxe8uVzqEPkptOPfN6Nb3/KLBuylCtUiaRMyt+TRnNx5j
	PSMSzhT9PFL0ch3GogHTV3Ik8yFvaryJHdG/IQpW1HriRwXbDiKC7N+boL6Kpyk=
X-Google-Smtp-Source: AGHT+IGI9EjfZdnRZtFdgai/ir9v+B+TPb4TBp4lHo4tksL4P6xYiI/klVnCx6NqSUT0kiU02IEfUg==
X-Received: by 2002:a05:6820:1b08:b0:5ee:a5b:d172 with SMTP id 006d021491bc7-5ee57c530cdmr8504966eaf.5.1731339205969;
        Mon, 11 Nov 2024 07:33:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee49527772sm1970810eaf.22.2024.11.11.07.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:33:25 -0800 (PST)
Message-ID: <eadbda9d-9e24-44c0-b157-02989403e048@kernel.dk>
Date: Mon, 11 Nov 2024 08:33:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] xfs: flag as supporting FOP_UNCACHED
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-16-axboe@kernel.dk> <ZzIidGR2FDChtCAu@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzIidGR2FDChtCAu@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 8:27 AM, Christoph Hellwig wrote:
> On Sun, Nov 10, 2024 at 08:28:07AM -0700, Jens Axboe wrote:
>> Read side was already fully supported, for the write side all that's
>> needed now is calling generic_uncached_write() when uncached writes
>> have been submitted. With that, enable the use of RWF_UNCACHED with XFS
>> by flagging support with FOP_UNCACHED.
> 
> It also might make sense to default to RWF_UNCACHED for the direct to
> buffered I/O fallback for sub-block size writes to reflink files.

It very well may make sense, but that's probably something the fs folks
should add after the fact.

> Also for the next round you probably want to add the xfs and ext4
> lists.

Oh for sure, I deliberately didn't do the ext4/xfs folks just yet as I
want to iron out the main bits first. And hopefully get those sorted and
acked first, then move on to a separate xfs and ext4 set of patches. I
also did btrfs in the most recent version, but that'll be a separate
thing too. Just kept it as one big series for now with more limited
scope, so folks can actually test this if they want to, without needing
multiple series of patches.

-- 
Jens Axboe

