Return-Path: <linux-fsdevel+bounces-34487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0483B9C5E6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7771F21886
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604A020EA29;
	Tue, 12 Nov 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dPjPdfu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB221732F
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431210; cv=none; b=Y+2+XmdmlJeq8WuEpS9SdqK5Rts6ym/4BBwZcp1OFAbt5tsvKasvpm+ySTnS9m0hP65vl6Js5wyHl9xmUALlFzv9+dWrAOl/IzQXjSQNJkjU4sr2tzVlsUMIsMEex+e8q+hr/BBHF/e6s7wtVx3IBeCPFf8Ffu4Ttn4C88zlxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431210; c=relaxed/simple;
	bh=2JX9+Oec6re2y1a4xOhuxeNQc/xPxRA9BwsugQ7a94M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3k9hQedFdiFu/r0Odbs4XoNqFyQtezlv5/p9b1AcqOKvQKVHLIU/EK/Gp0Y2+DdyMZ3mHH+LLIIKLIZggFk3zFPpwcOxOlPAaPrJpDL0OhQf52x0rnjSI0YqrbEHcn9Gyg6UK2Qg1v4k16qor9mF+NpwRARfnQwuQZ+oLlWIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dPjPdfu1; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-718078c7f53so2784851a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731431207; x=1732036007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gBQdB8LfkLX5TUCZ/pNzgnlsSmd42L4jALhpOoe5nw=;
        b=dPjPdfu19geTWahmuINPChOSlT0d+4AlIMz5oGOhn3dOn1vfUJ6y7AZSVAjffAYIpI
         IDbrSEZWUFksZ0mLCzoYekpZ2YQ+fUlz6JvKWHAxyvx1TK+BK9Eu8uXIFJZzXj6DWiGX
         e942R0ao6+6I3rsSHyxvU1wzwokhFI5z0cpmDEu1987T9OjD4wPUxXpizcPkYksx24q2
         qAn110tEBls1yZBJYZyrS02wPFTLs8eAZBOZmlsugj2ksoKvx4ta8QckGTuKXCfIEjVN
         NcZ1JQMLtZYDV5WCbPTgMw8tNe4iaRl9BZ1Kf6MMecgoD+nscJD8YB9S58G6j+Eu/Qhh
         D4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431207; x=1732036007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gBQdB8LfkLX5TUCZ/pNzgnlsSmd42L4jALhpOoe5nw=;
        b=AJlr8c85znOt83KGTm85RoElSOXMsVIiXz7MO7VgrCD4X9IIiJalZokrVfSLUkoqqF
         bGuKx6VolQRvGwYpVrssE7XfOagcVshU202pBXxQ2tdzvacmyOjiCsMGAJlL2/ADxlbm
         RrjjrM1bkjqev93o0cMWicSLRSN5ykA+25RvMo1//B3x7DmA1TLPOgH87JWIxPNzrCMx
         tR70ayU2PmMpioABzYxBV0cN0Mvx77EauCHrR3K/YEroUPCCHnCWsaAYEFkuBG3NgUVM
         qPvWD29bnbpPT3FAnPSqb9utmhaZvrHKMAGr7Cya3YT7P4me4WucQvY1/ZzQyS0dTN6Y
         Xm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpOJW94MtbLBwtYj7IfE/poFnfmG6Ji3phWfNat9F4PKnAdLE3t+aM+3aO/2h8HvRcFmC2MWH8y4dY4NxR@vger.kernel.org
X-Gm-Message-State: AOJu0YyYakO2hLt8j6I+wLCB4w7OdxR4o5ijjSIHKlwW5AgcePp79cwl
	EMpNQGAUdABcMttttf8jfFnWn6ymJZktUWW90xXWeyz8DY5sk/b3K8Xh77p9neA=
X-Google-Smtp-Source: AGHT+IEFhmr73BlsFmSujeWjETDWW8vIMJ259KHsMl2qTFCMehDdIEol/c6/Y43aheLgyMPMHb+QxQ==
X-Received: by 2002:a05:6830:6b0b:b0:713:d359:317a with SMTP id 46e09a7af769-71a1b0c73demr12018118a34.15.1731431207695;
        Tue, 12 Nov 2024 09:06:47 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a107eb5c8sm2785031a34.13.2024.11.12.09.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:06:47 -0800 (PST)
Message-ID: <7a4ef71f-905e-4f2a-b3d2-8fd939c5a865@kernel.dk>
Date: Tue, 12 Nov 2024 10:06:45 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
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
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk> <ZzOEzX0RddGeMUPc@bfoster>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzOEzX0RddGeMUPc@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 9:39 AM, Brian Foster wrote:
> On Tue, Nov 12, 2024 at 08:14:28AM -0700, Jens Axboe wrote:
>> On 11/11/24 10:13 PM, Christoph Hellwig wrote:
>>> On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
>>>> Here's the slightly cleaned up version, this is the one I ran testing
>>>> with.
>>>
>>> Looks reasonable to me, but you probably get better reviews on the
>>> fstests lists.
>>
>> I'll send it out once this patchset is a bit closer to integration,
>> there's the usual chicken and egg situation with it. For now, it's quite
>> handy for my testing, found a few issues with this version. So thanks
>> for the suggestion, sure beats writing more of your own test cases :-)
>>
> 
> fsx support is probably a good idea as well. It's similar in idea to
> fsstress, but bashes the same file with mixed operations and includes
> data integrity validation checks as well. It's pretty useful for
> uncovering subtle corner case issues or bad interactions..

Indeed, I did that too. Re-running xfstests right now with that too.

-- 
Jens Axboe

