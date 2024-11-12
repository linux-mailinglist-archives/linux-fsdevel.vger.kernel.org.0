Return-Path: <linux-fsdevel+bounces-34470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA65C9C5B9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F180283200
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A906156F5E;
	Tue, 12 Nov 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m8CVMls3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA41FBCB4
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424474; cv=none; b=h7brXQhk2K7nqjhQzAZ5eAeXCfoyy+3wMEYF7K8XmyzIo6hbCVG1EbdwajpFmgm5E9C33efx34EpQxzRH+MhdoOQg8YNJbZbzr4vGv87jhXQVJbEH13uSdPNr6XNqzuLQRYzdzN3y/VP5F1AfohLbwWptMTytUT8/cqWAShDRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424474; c=relaxed/simple;
	bh=b2KM3R1Q5tQG+JKB9eoj1tjOdl35CzW7T7sGig8ZyQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJK2UGZ5LAoA4S+RAic0o+F8XFpdwGlutmDcB5hLKsK8hHaii6ZxxsmL+M5L5+48TdDcWmhzVFroZBUTLaQFgktG12exIfq5N1zemx28qfqjvPGH5fQ1Vd3N1DoXp86XUQ55yYrYn7M7KFsSASPFfoan1/XJhPxUl5zezcogCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m8CVMls3; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-28c7f207806so2435856fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 07:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731424470; x=1732029270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMz623KukwCRCwVdjpn5ENIcLZ5bWxNUSBajZwamIfs=;
        b=m8CVMls3qPXS5X0gxPKc+sUz0i93RXeB/trkUqPNNMIkZ/X7cEqqC3gnwVQCMf/9zP
         9iTngcAMrrETBwE5+JB5uzrz/VeSXcG8ckHh6qZ8lgRYBir3xNIhBHqFnBd/cL0i+p0g
         3kUvqoedmF7z1NuS8vxnVXycECFlwhJYJE/RcA/vU9nnViv1gpdS0n5JvpF9PK2jFvpJ
         Cj4wTTFpov3HnXtNz5ZFJ3QJLaDpyS9X2y7HrWaoienTTgkHSl4pMbLART6xBLRi8tDO
         q3SU61Hf5cqv0WNfutU8ZW9FhrhAEggvkLvMdLCrA3bziIQdfOzNgTWu1r8ZXqlrvsSs
         I81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731424470; x=1732029270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMz623KukwCRCwVdjpn5ENIcLZ5bWxNUSBajZwamIfs=;
        b=Yq9dYumqADPpSvEgUJW4Oruh4OAY8fW5N+fMUmRBYs9Vb5LQRx+yVqTfzBOtdbg5ug
         4r65At68IBpkN7Qq6hPK7tlzyFh3MmH2IYrTSZuo3SyFxBCwaSQGlDNQ6q84NCtoF0xE
         KgQX9RcjSdbLZ1sb2U3IX7pDG2NPOMmecoU9pQNsNtE2SXNXaMDOQ9OPnqfvMiUwtIp7
         dJhGcbGSocPBUezgr9nr4ZtcVojhVG4ChJuaxNMTOuXr1MTMzNU468lXiBE8QxVXbKaq
         jWds5XmBJ/MmcOzBtcQnQWiwmidOewsseTdatoOXZmcnT9JGuf3zCB3iUyOHz/Wxwhsf
         ZMvw==
X-Forwarded-Encrypted: i=1; AJvYcCUObQ1jNFc8BEXBYLeaJLn2WtiHQBlg5kKU5p01VzANpWXm8mvAj3vK5dkvIDdTv6Req81Q66ZBWoSDyxPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxM95GiK01tqcz5tfWy7LgDhDFvUGix5seqT9yiRM1fxU+5cbct
	wkYMwvNlwqKr7X8MXDzA0hqWKHyPnmB3Bx2SUpmWIbBLRWBepmJ0p3SsXIP2GUA=
X-Google-Smtp-Source: AGHT+IHT/p345mEZBMk5iEPlL4UdfBp49t0367lnxgs3ykjFrEFDJjYG+ulQ12gnvLQ/q/yMlk8/Ag==
X-Received: by 2002:a05:6870:1d1:b0:278:3de:c8de with SMTP id 586e51a60fabf-295cd08c5cdmr3167596fac.24.1731424470364;
        Tue, 12 Nov 2024 07:14:30 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546ed7ab3sm3542727fac.42.2024.11.12.07.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 07:14:29 -0800 (PST)
Message-ID: <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk>
Date: Tue, 12 Nov 2024 08:14:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
To: Christoph Hellwig <hch@infradead.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <ZzIfwmGkbHwaSMIn@infradead.org>
 <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
 <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
 <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzLkF-oW2epzSEbP@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 10:13 PM, Christoph Hellwig wrote:
> On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
>> Here's the slightly cleaned up version, this is the one I ran testing
>> with.
> 
> Looks reasonable to me, but you probably get better reviews on the
> fstests lists.

I'll send it out once this patchset is a bit closer to integration,
there's the usual chicken and egg situation with it. For now, it's quite
handy for my testing, found a few issues with this version. So thanks
for the suggestion, sure beats writing more of your own test cases :-)

-- 
Jens Axboe

