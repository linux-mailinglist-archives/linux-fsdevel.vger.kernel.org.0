Return-Path: <linux-fsdevel+bounces-50379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F704ACBAB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D293BE214
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 18:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF036228C92;
	Mon,  2 Jun 2025 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NHUO0B06"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88E223DD4
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887477; cv=none; b=lx1Mf/NDpiFNuL6D4TnoXs1W2TbTCdlyxmBUlUmRYL/XnYJJtX9DFvIiWomLicYRRfB3yV7HCQAZAOeDnIqsyMZxSN2zoOJn5g+vmxLfC83Cfm24x/bHCPZHU3fQ7dyP3cZrm4KsTqfT5IhvsvCI+FnPGX4WiwzDjGPYWv0bVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887477; c=relaxed/simple;
	bh=3CJjS80Cg63APHzqm3TcB3seDIDNnG48N+eGu9+Azyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjPdKwgi/KEESAdsH1tVQ/gMZFGeD4xsZfTlllLjmQm+11GgT+3ZzwrfDG0PQqHK4lyHlOwMRNmFsnkVGLqJ+UjW02D2AYVinN8MVLtQ+WDeBOvYiktTWFhVD6o+ls81pMYMwHReIz0RgrIO8DLi4y1zvPsly3eGWjJ2wawy9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NHUO0B06; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-872886ed65aso108619639f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748887474; x=1749492274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKwd89/t66lNmck+SxyQUCtkTRq8WXDQ7GkPW/MfPpo=;
        b=NHUO0B06QsHZrSTaWdqLCRWs5cVK9iohquTAQTiJsyCsOqwp6ZAmy0OlbVRzS0I3OG
         oQYL6KVBuDz5D4lC2HsbK0OL1zv4QEMOAzTq9MMNYYbD3NvlL/a10KiGpLS//WDYBaz4
         hrucwjs7MSFqNCW+li55iVF85WIl9GNHj3NLIICA9KWE8WnmjeZqjZsJDzKcKtbqlYJZ
         viyDlE1KM8tGjMrWlb/+Dd9NY/w0QMxhV4BcjSVhzClk1CUYmDrKgn88acKnO2DnW02J
         c8IZ2bnQXoSdJjHV0cGLKbiAYGYvk/NK+Fz+x1HmCfGq1P3XeL/Sf7+UqgXKSpABFhat
         LQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748887474; x=1749492274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKwd89/t66lNmck+SxyQUCtkTRq8WXDQ7GkPW/MfPpo=;
        b=nd1mR+h06AtvzrKhcKZ+8ow69LI3qPDDaIq2roAMZcMBD3FcvT7YtfhjjLfId97Z0t
         kdCRV3Zp0cby3f6wIw0GJj8VRfPjdPjCiOBqkzaCtTA1o2cySBWToupp7TFiYjlGq6es
         owr3kncKrtFduD1fVyUTcM/yJmeXSnTktMoVCY6jeAIPDfhh81lxc7Hvt3b7mOBU597N
         QZ8mIzr6tg5oSoEzTv45Qzn03MWWhp3h2EyQo9q3Y3Yas439EkHVDXVXRmNxWAklx1ki
         m2kaV99HLkHolEHmRYkYf67aQWgmhjC/SGeqY/A/BHDlyzmbwQKxqRrAUuSTmodGudjl
         R4JA==
X-Forwarded-Encrypted: i=1; AJvYcCV5v+PQ/XHWFU0kx6ypwi2hgexhJnXnSGXdftWmtm0Fl3UQOAJvSt5KRQzprKyh3LZbAKmplVs4Y7863u6o@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRRBO3v2POOm+piY0TF77P9KsdChe2WNIESwrDAjqr9uAK76E
	MT2mA1ozdKuQroVF9TeMnCoLWN5rRFIz0YhVriDBYyaEt3NwHyh4hW2gawNYwFtkSaA=
X-Gm-Gg: ASbGncu+OsJlMGNvdLeyywlr/EZWnwQssHl/O0SHzC0v0Bt9jVhuQNpBTd0aS9bSMbJ
	z9Vj7T45NDpOQa8TeP8nb62BDTTFtZBI7MqGcSLor9qtuoR0M7Hj/US/mr6Dfi6V1Pd7BBU1pBx
	y+CNGB2tRNfpZFwO0lGM6qso9nZcCiQv6A4mQg0qWHsIBzTvdUpIfDnVELhsJNIQ/l/HLti96+G
	iC6bP/+QwnU9xYX7e1xxNKY1yVzq/9oB9GVx1XhOPiYUlGpkly0uVSJ2WIeUQbITzeLZo5/r2ox
	ikmsVv3mhDAcHXmxZyRoKgHOS/IIb6lryVldzosS7QtWVRw=
X-Google-Smtp-Source: AGHT+IFYMSUOV856qCdDvEMTrOFAhOd5lpP/DWo7HiyRLMyNi9rGf9ChHOfczI6T5irgbZ2/Kfx/aw==
X-Received: by 2002:a05:6602:4a02:b0:86c:f893:99da with SMTP id ca18e2360f4ac-86cfffdd29cmr1771440539f.0.1748887474505;
        Mon, 02 Jun 2025 11:04:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86cf5e79524sm185274739f.13.2025.06.02.11.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:04:33 -0700 (PDT)
Message-ID: <1a2bea7a-71d0-44b4-a376-9f13c0e28381@kernel.dk>
Date: Mon, 2 Jun 2025 12:04:33 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: don't lose folio dropbehind state for overwrites
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
References: <a61432ad-fa05-4547-ab82-8d2f74d84038@kernel.dk>
 <878qma9guf.fsf@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <878qma9guf.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/25 11:46 AM, Ritesh Harjani (IBM) wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> DONTCACHE I/O must have the completion punted to a workqueue, just like
>> what is done for unwritten extents, as the completion needs task context
>> to perform the invalidation of the folio(s). However, if writeback is
>> started off filemap_fdatawrite_range() off generic_sync() and it's an
>> overwrite, then the DONTCACHE marking gets lost as iomap_add_to_ioend()
>> don't look at the folio being added and no further state is passed down
>> to help it know that this is a dropbehind/DONTCACHE write.
>>
>> Check if the folio being added is marked as dropbehind, and set
>> IOMAP_IOEND_DONTCACHE if that is the case. Then XFS can factor this into
>> the decision making of completion context in xfs_submit_ioend().
>> Additionally include this ioend flag in the NOMERGE flags, to avoid
>> mixing it with unrelated IO.
>>
>> This fixes extra page cache being instantiated when the write performed
>> is an overwrite, rather than newly instantiated blocks.
>>
>> Fixes: b2cd5ae693a3 ("iomap: make buffered writes work with RWF_DONTCACHE")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> Found this one while testing the unrelated issue of invalidation being a
>> bit broken before 6.15 release. We need this to ensure that overwrites
>> also prune correctly, just like unwritten extents currently do.
> 
> I guess I did report this to you a while ago when I was adding support
> for uncahed buffered-io to xfs_io. But I never heard back from you :( 
> 
> https://lore.kernel.org/all/87h649trof.fsf@gmail.com/
> 
> No worries, good that we finally have this fixed.

Sorry not sure how I missed that, to be fair there were a lot of emails
in various threads on this topic back at that time. Not trying to make
excuses... Yes, at least the "would otherwise have been !task context"
issue is resolved.

-- 
Jens Axboe


