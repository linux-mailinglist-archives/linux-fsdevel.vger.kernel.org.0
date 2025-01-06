Return-Path: <linux-fsdevel+bounces-38449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA48A02BAC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A833A5C1A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1935D16D9B8;
	Mon,  6 Jan 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kUt4cAgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2FA1422DD
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178275; cv=none; b=LTm+x0uN7pHe29KP5EPA4ISgn0At2/yYaLijjuROIUosdkOyK0C+Kyz9wqrSB5tVlALj/jcotyoj1hSnL2N8dA56+WBaBq+h0T17v9yxkZRaaBuRuy3dRspA2FZQxAuA4woynII08PGvFq9TtD7z/Wl4jLxMiEKSgQqU2SY94MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178275; c=relaxed/simple;
	bh=dEdXfZtGDIhEERcRg4SdlyOPDk21qvykP6K1tGF33Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mw11WJZ7OMawojzTftpzxESY1iC5tuHW1t1qW7tRQMAA5sNW3wNEWUWcIWdcAOHQvSCpudxevtQeoUV+h6xsrIUrnRaToUSjeKPFgQrMMUiizBju8MZr9HC1RFl7PwqQrFmKiWgq2nhFPLzsGST4H7hQhIV29FfuzTTzF6w9/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kUt4cAgu; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844c9993c56so1221412839f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736178268; x=1736783068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlSiOUU0BWGUrYw5zFn5x8RCblwpmS03HB7Ae3PdDoU=;
        b=kUt4cAgueJ3qXiuntbkW1NS1g4M+zvi0/AKxKRzZer7eH4+Om6bFqrVnIktPzbVdqh
         U6x1wjwjhHhS/FBWFbtAThoQK13lSzNzcu/wsCu7O9i9JqrGOC7tDKHRVq3fYauc3qjR
         p7PyKQcg8IN71FZCrbgBgSK1DaPA+RLsgrrB3I+ooaMb0vxQXeWrZPzNJBTZaqzcNFVr
         yJdTtAG8gHOOn97MVQLDUJJYdGaO94ckqshqfb8bL0sH82JyD2wyqAXdwcCYjAyvDe/l
         EOiaO5OqoaVb4eM/lSR1Slam/nLXmLBn2LuKupuef73hZ8SOQ+CK1b1Xh8z94+O+eyyf
         kfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736178268; x=1736783068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlSiOUU0BWGUrYw5zFn5x8RCblwpmS03HB7Ae3PdDoU=;
        b=FEYiyXXvMCt4E3ySvA5dBYUtSMGVZP3BOmqWiataY+QxY6M6AHTs0t2xFGhQ8PY8fC
         WAmh9rKZ34HqvwHYE0usyp1PSLa2Hyck8dEDMFuBxGbhljJgBQtTs4ns07vI2dQOVYT5
         bY02iFSWqnXnN6iqyQF+SsozY5g3rtfaRIPiEAzZ/XjAiWNN+XOXi5uiG1+jCayn1g/i
         kZJFiYFUJG+aXl8sNI2l9vPoIIL3sR6PMGMcdhkAms0+D17mPQanR3QswIW3rPSSBDVx
         rICx2WyBDLtxbOo5sIQbnIpYuppDPoLXgJGzhY8XzSBS9UDWhqYpJ2eg8de+LarKkIm6
         XrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPlLf/zCSCmmdbGgWmCWPPst5BXaPupyaonTGmjkCd75j9vAsB/ljtALcGHGuArU7Qvf+eiZtattKHY8WF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ObVcTCVdE+CGJ3LMk6OT2zGCUU6gpNduDAXDLFPSIBjyb3jS
	4/wuqGYkjb5g+HDWoybIfF14prL4rxTKS69MiVt8XpbHhgUk9lWWyX7XZjQZeVU=
X-Gm-Gg: ASbGncuHUACi7gKHUPFbfZbjSZNX5cW5/XnFfIrhB7BOjmQkLfjTAQrCGwCdweKI75p
	yXfza7Qy5DnySV92DBnBM7UQVJRVyMekxrYk0+Bdg3gbRYJdz4iCH/1ZaW4BRkKFL9Q1oRrRMhs
	eqEwuW4GLmq+0xQAF0ITdUdP62C/mKIfvgJQvPqdALAGnNzX/KICrYW5kKTko0BrEEOBe/CNUBs
	c6TOjDtWmUZeb+6uG1c//eLZj6uyORpR/mAwFXsBGZ1FvzWqX+u
X-Google-Smtp-Source: AGHT+IFcdehDP255DWRph+48knRanMbgh6ZLjrKK4+egd2E9177Col5P85NZctiCtC+wznRaBUf/NQ==
X-Received: by 2002:a05:6602:1689:b0:83a:9488:154c with SMTP id ca18e2360f4ac-8499e4996f0mr5639389339f.3.1736178267835;
        Mon, 06 Jan 2025 07:44:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c189372sm9415208173.102.2025.01.06.07.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:44:27 -0800 (PST)
Message-ID: <b9abacf0-35e8-49d9-9b25-05a40997a6b6@kernel.dk>
Date: Mon, 6 Jan 2025 08:44:26 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 07/12] fs: add RWF_DONTCACHE iocb and
 FOP_DONTCACHE file_operations flag
To: Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, kirill@shutemov.name, bfoster@redhat.com
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20241220154831.1086649-8-axboe@kernel.dk>
 <20250104-sonnabend-sogar-9621cd449aca@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250104-sonnabend-sogar-9621cd449aca@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/25 1:39 AM, Christian Brauner wrote:
> On Fri, 20 Dec 2024 08:47:45 -0700, Jens Axboe wrote:
>> If a file system supports uncached buffered IO, it may set FOP_DONTCACHE
>> and enable support for RWF_DONTCACHE. If RWF_DONTCACHE is attempted
>> without the file system supporting it, it'll get errored with -EOPNOTSUPP.
>>
>>
> 
> Jens, you can use this as a stable branch for the VFS changes.

Thanks, but not sure it's super useful for a patch in the middle. It
just adds a dependency, and I'd need to rebase. Providing an ack
or reviewed by would probably be more useful.

But given how slow the mm side is going, honestly not sure what the
target or plan is for inclusion at this point in time.

-- 
Jens Axboe


