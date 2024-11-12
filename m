Return-Path: <linux-fsdevel+bounces-34546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6F9C627E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C141F23D0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2503B219E2F;
	Tue, 12 Nov 2024 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iN1b+heL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25859219CA4
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443124; cv=none; b=aS2tl9KRCtskJNZvQDIuNOPaSiBraKdB5oq0kjesZcb35oL3LWlJ4vaahHOtx6RjzmMEHaAFsBxuhdgDuY5nKq9bY3hWS4xxKWCOLSMsDr/2zKHBXBMv5eUuxYR+Rnr7LD7KpUwGyS+K8dB+L5mYcTZgltix9EVTrsDu7WO6L4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443124; c=relaxed/simple;
	bh=DrmEULLLvryYO37XyExAFHdvw7bwGt+Vss5EyAjMLAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PT4Wc5wO6SZoa3H/gBDQVpXU2HWi/b8PFenEFRInyFBgCuH66ZCqUbXg4m6+I7if6DKwZaVvLrcMFOxaCMic+aAKq+1Idy0LaMW9EQ16iJhg/NnnobZ3GDFkIo/duT4Ko14Cr5/mFD6UBVCbgurkG7XcBHtkD40CG4ZSu3Qz+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iN1b+heL; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5eba976beecso25245eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 12:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731443121; x=1732047921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hB2QlSBwrWFDwqVXDHa/THM7aE7F0VK+KszTLMd81TQ=;
        b=iN1b+heLkzKxAM+Uij1FyZnJSm+mbAlimT9AOi2QHUM7OhvJ5ukkpxcZaSMPVzvR4q
         IU9bSesPTcQW/o1pQnAXXOom/xmLaH2+Vj0slAddm1VdQv4TslZMnphI08dRYI+3kngH
         /fTb94jYTiZeJHwkfX6oXztgNjjVY7QKMZ+mxCTGvxfb2cDtyCNvW0fe8xGRLHtcq+++
         Y4ap81yczIHiUmdlc9d3owYdZ05+adbrX/YV+tY65pXa8Ej1U5LFUPNFsFy25+fUGxMy
         RtvutgtfMsm88zsLPmjh8wBOydoQj+YcL9ARugRQWZzYfCihMwFdcTkSCtvW8wCb9Xdn
         zg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731443121; x=1732047921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hB2QlSBwrWFDwqVXDHa/THM7aE7F0VK+KszTLMd81TQ=;
        b=cSBgU4C8areLPu0rMKwNPMRrKqujRJrIsryuvX4wRRHjNgbiDTXGOF//FehNSGXfFY
         tJtPCmlPYN+xe+Z/UEOM0Nu2lsoIqvR5UmUicN0dcBiRHtig8F2au1gLg41fDUifgN3U
         ECdjJcMacponVO62yqENF1JFB17DSDduU8OKi4uMSt4mLCWA+qrKez6C5pFeXqRt0Ce4
         2R9JFDp/eUcUPrXEIV0fB6sCqKR3Wr9KuRjtFtgtVoPqWz1gkJr/oWa8Ukl1Vbn6fX6Y
         rd9gIRNwndgXmRMcRz+6jatOfbqkhxyV0RZMZCdloHUE7c61wKcR+BJFH/Pkzg/WTvNN
         KM8g==
X-Forwarded-Encrypted: i=1; AJvYcCVsw/91S0OkuGocoqrIwWIQbG11JpbfXHHu/OpveKX65RbmY6Mb6r2ZOGKAfFZSahexaav8+qII8RHUux8t@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ce6wXVgpiGYkzlqb7QzSzi0V2Jz2OaRyaLPfmPdHuQlqGfjA
	V8OE2AOHRXDY6Q8neInlZ/DNuaxQ7aZCsYERgaYXUnzUug2o63f+9V5HF2koYds=
X-Google-Smtp-Source: AGHT+IEuZmXrNMzXnaSIyvwnu5XySW0EU45lBCXEnhVNfIAejF5Sview9KFYlc/wJH7COo9qbBQ3fg==
X-Received: by 2002:a05:6870:2301:b0:278:8fb:b132 with SMTP id 586e51a60fabf-29560351064mr8845504fac.1.1731443121041;
        Tue, 12 Nov 2024 12:25:21 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e8f5620dsm66801fac.12.2024.11.12.12.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 12:25:20 -0800 (PST)
Message-ID: <d74ea306-29d6-4829-9b3f-d76dfac0b912@kernel.dk>
Date: Tue, 12 Nov 2024 13:25:19 -0700
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
References: <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk> <ZzOEzX0RddGeMUPc@bfoster>
 <7a4ef71f-905e-4f2a-b3d2-8fd939c5a865@kernel.dk>
 <3f378e51-87e7-499e-a9fb-4810ca760d2b@kernel.dk> <ZzOiC5-tCNiJylSx@bfoster>
 <b1dcd133-471f-40da-ab75-d78ea9a8fa4c@kernel.dk> <ZzOu9G3whgonO8Ae@bfoster>
 <f26d1d04-3dfb-40d3-b878-9c731459650d@kernel.dk> <ZzO4wUTNQk-Hh-sT@bfoster>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzO4wUTNQk-Hh-sT@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 1:21 PM, Brian Foster wrote:
> On Tue, Nov 12, 2024 at 12:45:58PM -0700, Jens Axboe wrote:
>> On 11/12/24 12:39 PM, Brian Foster wrote:
>>> On Tue, Nov 12, 2024 at 12:08:45PM -0700, Jens Axboe wrote:
>>>> On 11/12/24 11:44 AM, Brian Foster wrote:
>>>>> On Tue, Nov 12, 2024 at 10:19:02AM -0700, Jens Axboe wrote:
>>>>>> On 11/12/24 10:06 AM, Jens Axboe wrote:
>>>>>>> On 11/12/24 9:39 AM, Brian Foster wrote:
>>>>>>>> On Tue, Nov 12, 2024 at 08:14:28AM -0700, Jens Axboe wrote:
>>>>>>>>> On 11/11/24 10:13 PM, Christoph Hellwig wrote:
>>>>>>>>>> On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
>>>>>>>>>>> Here's the slightly cleaned up version, this is the one I ran testing
>>>>>>>>>>> with.
>>>>>>>>>>
>>>>>>>>>> Looks reasonable to me, but you probably get better reviews on the
>>>>>>>>>> fstests lists.
>>>>>>>>>
>>>>>>>>> I'll send it out once this patchset is a bit closer to integration,
>>>>>>>>> there's the usual chicken and egg situation with it. For now, it's quite
>>>>>>>>> handy for my testing, found a few issues with this version. So thanks
>>>>>>>>> for the suggestion, sure beats writing more of your own test cases :-)
>>>>>>>>>
>>>>>>>>
>>>>>>>> fsx support is probably a good idea as well. It's similar in idea to
>>>>>>>> fsstress, but bashes the same file with mixed operations and includes
>>>>>>>> data integrity validation checks as well. It's pretty useful for
>>>>>>>> uncovering subtle corner case issues or bad interactions..
>>>>>>>
>>>>>>> Indeed, I did that too. Re-running xfstests right now with that too.
>>>>>>
>>>>>> Here's what I'm running right now, fwiw. It adds RWF_UNCACHED support
>>>>>> for both the sync read/write and io_uring paths.
>>>>>>
>>>>>
>>>>> Nice, thanks. Looks reasonable to me at first glance. A few randomish
>>>>> comments inlined below.
>>>>>
>>>>> BTW, I should have also mentioned that fsx is also useful for longer
>>>>> soak testing. I.e., fstests will provide a decent amount of coverage as
>>>>> is via the various preexisting tests, but I'll occasionally run fsx
>>>>> directly and let it run overnight or something to get the op count at
>>>>> least up in the 100 millions or so to have a little more confidence
>>>>> there isn't some rare/subtle bug lurking. That might be helpful with
>>>>> something like this. JFYI.
>>>>
>>>> Good suggestion, I can leave it running overnight here as well. Since
>>>> I'm not super familiar with it, what would be a good set of parameters
>>>> to run it with?
>>>>
>>>
>>> Most things are on by default, so I'd probably just go with that. -p is
>>> useful to get occasional status output on how many operations have
>>> completed and you could consider increasing the max file size with -l,
>>> but usually I don't use more than a few MB or so if I increase it at
>>> all.
>>
>> When you say default, I'd run it without arguments. And then it does
>> nothing :-)
>>
>> Not an fs guy, I never run fsx. I run xfstests if I make changes that
>> may impact the page cache, writeback, or file systems.
>>
>> IOW, consider this a "I'm asking my mom to run fsx, I need to be pretty
>> specific" ;-)
>>
> 
> Heh. In that case I'd just run something like this:
> 
> 	fsx -p 100000 <file>
> 
> ... and see how long it survives. It may not necessarily be an uncached
> I/O problem if it fails, but depending on how reproducible a failure is,
> that's where a cli knob comes in handy.

OK good, will give that a spin.

>>> Random other thought: I also wonder if uncached I/O should be an
>>> exclusive mode more similar to like how O_DIRECT or AIO is implemented.
>>> But I dunno, maybe it doesn't matter that much (or maybe others will
>>> have opinions on the fstests list).
>>
>> Should probably exclude it with DIO, as it should not do anything there
>> anyway. Eg if you ask for DIO, it gets turned off. For some of the other
>> exclusions, they seem kind of wonky to me. Why can you use libaio and
>> io_uring at the same time, for example?
>>
> 
> To your earlier point, if I had to guess it's probably just because it's
> grotty test code with sharp edges.

Yeah makes sense, unloved.

-- 
Jens Axboe

