Return-Path: <linux-fsdevel+bounces-34360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D89C4A41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F69282D83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 00:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C61CB329;
	Mon, 11 Nov 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NlbZuJ5O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8C1CB31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369269; cv=none; b=GW6KgLOhZH1guVLp10eRruMpEY4fBsPI8sDs95dxjMcY0mbDFck5T5+gTqgAJy65LBSiZCqrMX5EBv7Xwhv359PhvTtEaoCdBK+yISaIynRSRnnj7xj+vjuoiRypHx70mqx6tDmGpIMmM/eFbWKMc4NPIj1byJUCeRe3EHwJePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369269; c=relaxed/simple;
	bh=oc2i14cbHlPjUptML9llrR9GZXQV67FXBAhNSclAL5U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CwUbSElYYN8HeGfbhD1bzjUyCOVETIll++RgE3thCWtnsCkaiYxxkXr7xZApehk230IjUWU/04sBkG6mWRruH66kXz4Ps3cDLWJSaNSm+091EQTINqSWwdpgIIsR1zqVp9rZOKrGMXSLbJLJe6aVUays+4QyL8CmJdFZI/yaeKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NlbZuJ5O; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720e94d36c8so5158992b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731369267; x=1731974067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bLMZyOFHlxekHdlP1p7zVoropnof1NcDjaHS2jWrWec=;
        b=NlbZuJ5OSLyKTPc2ZfjUik465S0k7RcWGR/rzAFEV7krbYJPe688iiFc8AHM5tl8UX
         B8KSaDUyv8oT2p1OO6KZLpjhqoT+UiNVOoygs0dHAbdcpvG2EzjHCaPszARrpIplhA7l
         ydpA9zSrDg2+WhKOyiSCrCxMQDL0YN8GoMtkK6zTQDXObp5q9wYSSeeRAUJCt2C2kd0E
         NTX+6Fg/LwggTJVoI+5NCN8KegILhaUYvxNxT++q78Ww2QooqQniqFisDdRE8KwOgkf+
         0GRXIkQtVBl1sXxNkJ+zwV8WgV06aUXezrtaSwN5h4hHBITNPWx7HZFRjSvropTkfF8j
         iDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731369267; x=1731974067;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLMZyOFHlxekHdlP1p7zVoropnof1NcDjaHS2jWrWec=;
        b=F7UpysnHRwd24JponpEBvjs6rvtresh+ozzYeJ9KKgbxXm5Ma5Ul0m7AzE827ABix0
         Haykn+MuQ3mjhAM/AZt4ho90uacA2SEjDHG2A+4mGPfkZhwamU32WiDQKJSC3SYBJkWy
         3HIXrngM0ghKUfJdqnuDq3Tadb0T53l/0IagI03eOsG/aw2WO9RPTW/DcIfzfUGJZOoD
         /nCN8tO3efkKkyZYngXCvdWim9LZRadM7VAfUwZZ7W+Ju5rnWnDzvEyb1kLftL/7QKuO
         IqBIJ+5bgUKmu2Py1j6Gd3kNbRfuz3iGHVWEyAwIzcGcPBDXzJMWR03CSWbGYYm63+Sh
         ztsw==
X-Forwarded-Encrypted: i=1; AJvYcCXpfBZjDQdQQvZnlFxg0h1yRPkYkJPa5Qt95FQHvJx3zZhHFct7FuZImnToURf0qiglEd72/O8V+wnRqPTa@vger.kernel.org
X-Gm-Message-State: AOJu0YyLskmyp7VsyI7wYpNSskDjKpu5LqzhqTeZMI13nbhKwKGY32ur
	qdye4CLCwtAjldxsC+BuM+snC42n9ptHtualSj5ZlaD0y1wocal6mD/ss1u74og=
X-Google-Smtp-Source: AGHT+IGSnKMa6ka5pGSYL/mBuk3Wz5Gb7lASbW1uGNq3aUIUquaCO5kb+R042BsY8/svwsYky7FbCA==
X-Received: by 2002:a05:6a20:7491:b0:1d9:dc8:b80d with SMTP id adf61e73a8af0-1dc234fd966mr23052302637.20.1731369267319;
        Mon, 11 Nov 2024 15:54:27 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa8fasm9775141b3a.97.2024.11.11.15.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 15:54:26 -0800 (PST)
Message-ID: <f7a48046-30b9-4656-812a-f0579234eb5c@kernel.dk>
Date: Mon, 11 Nov 2024 16:54:25 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v4] Uncached buffered IO
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Metzmacher <metze@samba.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <63af3bba-c824-4b2c-a670-6329eeb232aa@samba.org>
 <00c51f80-7033-44a0-b007-ca36842e35a5@kernel.dk>
 <76edefe6-fb20-4169-8cbe-d8b864b04c7a@kernel.dk>
Content-Language: en-US
In-Reply-To: <76edefe6-fb20-4169-8cbe-d8b864b04c7a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 8:05 AM, Jens Axboe wrote:
> On 11/11/24 7:08 AM, Jens Axboe wrote:
>> On 11/11/24 5:55 AM, Stefan Metzmacher wrote:
>>> Hi Jens,
>>>
>>> I'm wondering about the impact on memory mapped files.
>>>
>>> Let's say one (or more) process(es) called mmap on a file in order to
>>> use the content of the file as persistent shared memory.
>>> As far as I understand pages from the page cache are used for this.
>>>
>>> Now another process uses RWF_UNCACHED for a read of the same file.
>>> What happens if the pages are removed from the page cache?
>>> Or is the removal deferred based on some refcount?
>>
>> For mmap, if a given page isn't in page cache, it'll get faulted in.
>> Should be fine to have mmap and uncached IO co-exist. If an uncached
>> read IO instantiates a page, it'll get reaped when the data has been
>> copied. If an uncached IO hits an already existing page (eg mmap faulted
>> it in), then it won't get touched. Same thing happens with mixing
>> buffered and uncached IO. The latter will only reap parts it
>> instantiated to satisfy the operation. That doesn't matter in terms of
>> data integrity, only in terms of the policy of uncached leaving things
>> alone it didn't create to satisfy the operation.
>>
>> This is really no different than say using mmap and evicting pages, they
>> will just get faulted in if needed.
> 
> Turns out that was nonsense, as per Kiril's comments on the other thread.
> For pages that are actually mapped, we'll have to skip the invalidation
> as it's not safe to do so.

...and now v3 (just posted) actually does work like I described, it'll
co-exist with mmap.

-- 
Jens Axboe

