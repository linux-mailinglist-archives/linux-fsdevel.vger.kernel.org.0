Return-Path: <linux-fsdevel+bounces-38239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078119FDED5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 13:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B924216149B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0656C15697B;
	Sun, 29 Dec 2024 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b="Y5sep/Kk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61362259482
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735476083; cv=none; b=IzWgIxZnDvqAcx3AKL764gFUeHuT9CpGgn4ZxDuRm1XEImX9WLf8LUJKMOW6WMD3EwOOzuRk2fFjcfm/hrKvQjG+TUDhBgGovY/1wi/9M5R1lJl25F8oDiK0YkOCsn4iC7+ZDL/Zjw/WIHuV/8pZV07qsYdzr7lK2vQ5z+yxmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735476083; c=relaxed/simple;
	bh=J008uRuxTsGiy0lr0FzeapnwTyisendOaENS8IHfagE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9aUiffvDPTuXwpJzIhj/a9dcl6k7xFcO0azhlUeW0aqS2mNQ+q+TcGxp5Pam8MKq4UxRHBLXjGAiUocneFN7v9c05w7F+FNHMJDlro4Y/hqLXq1KA+flN69oE0h7X4DpkcrQ8XH6eCHb7osrzKTWqBWLywWBRpQ3As6CQyKhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com; spf=pass smtp.mailfrom=colorfullife.com; dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b=Y5sep/Kk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorfullife.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa662795ca3so1773289266b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 04:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20230601.gappssmtp.com; s=20230601; t=1735476079; x=1736080879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gUIxBYTNdKmO7h8yq3Oe9LTVRomBNQ7bx60VPAPgIs=;
        b=Y5sep/KkzeOYtgvbDXzgcp/lOEhVxN+IjHU7QA7l2LCAvOv491NDWtPXUPaIJtAVnU
         uGq0d7uZOcelE78AvkgxWIV5TtMykavYSd8rVKpEGl3RG8deFYUDf8ZP4eWbkBFbyeiC
         94jQqO3EYnOUXWwrKu4VwExV0Dis4tK8eDjb5HsiUT9uASo4W4n+flt70SUuVbLIey+2
         3qWHRa25vHOJk4vZ9bJW+s3DRlmtUfCVwkM/pbN/0F4NULcbZ0q8avhjy9QO8HTn7OAf
         /ua1TZZjVE6OqjS80RReey524WU7/vdjMGT+hvxXqCE/q+hnQUOKpeEtc2WIp0XukvgW
         c6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735476079; x=1736080879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gUIxBYTNdKmO7h8yq3Oe9LTVRomBNQ7bx60VPAPgIs=;
        b=vJLfLpu3r/Uf16oq1/v4dF6vxmZQ1gzFM51zUDkHrxDWEPlcTGoRIzYOPUTpMp/BQK
         T+oILSF4+1znjuSmZ1j+d6VGs9DQpalisXmKXV4aKiew8RW3W+325EXGjxeRSIpnYp4A
         A0OsmD9qKAbWW18/uldsnX+C1xxX2QX5CFZsuGOweAsMBWw4Cyjm4NAXOLOHYleqjbwJ
         T2geqtCcIPlIWvg/Z7wj3VkMA5i8Nkn2b2WK/TT2Yegz8k+595AHi0g0PzkO+jCmFI05
         YgrTRGHLEN6lBWyXrLXBtDtrtQzy6LI4EHUpGq/pcGy4WmwSGJMYf9vjmRv3CZftqHiq
         7Qbg==
X-Forwarded-Encrypted: i=1; AJvYcCUU9xAukU/CivI1zfnd/KHq23bXpysDTbAl1H55WVKswcP1PpnsU1Bz4NbKSkMARsJDXjqFiXLMsvy2jHCp@vger.kernel.org
X-Gm-Message-State: AOJu0YwaeZij4tZwD3bUuiPrEspJD2B+hWlV9aoslAh7VzHjXxPM7x1h
	2xfFeHLj46AGts5LQ84OpBrwHDBHyxbiP8uOzHR5XMYOKek4H3JwzMm+CsIm2Q==
X-Gm-Gg: ASbGncsU413bZXqOI+kDZd7ADCT9M6fYC2yeK8zPtSCD1/JhuUqNPixjjatp0V/nhZz
	Wwy66RDWmKihgZSI6kP2qFwg7BMLRdfvoyEaqNljPqYundAqfN9kfCuTb5u5LKhtuuElJ0/NU61
	mgk+phXGsRJm+7JtO1UJH3aQGgtII48BykLY2O01kKavv4QmK+zNiQTcEduX+msaSJzInuqEPKp
	iDKULpVuXOB/f6L+rFwew744RSwFjFLCqqblHlpk7av6skHsoa16JzVEb6HIO7iIZxm+7jPGRy3
	pFGtAvQ89i5Ryhiq1xBYZEhaH+EJ9g5uHVQti7TMRIgaYRsfd5+jGNvCW2xoU+o7d67FT1wOeFQ
	QmRj8m/9/b+ZhC2C+Sbo=
X-Google-Smtp-Source: AGHT+IFrgzmND0VLnK/1oCJAEzgqKhjQYXe6YlvxqrouxHnxtTU9bEmPo3dg6bFBGDgP7AwQlAG8Dw==
X-Received: by 2002:a17:906:6a21:b0:aab:edc2:ccef with SMTP id a640c23a62f3a-aac080fe36dmr2975938266b.2.1735476078594;
        Sun, 29 Dec 2024 04:41:18 -0800 (PST)
Received: from ?IPV6:2003:d9:9728:db00:a504:9f53:5dd9:23c7? (p200300d99728db00a5049f535dd923c7.dip0.t-ipconnect.de. [2003:d9:9728:db00:a504:9f53:5dd9:23c7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f00ea44sm1353800066b.135.2024.12.29.04.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2024 04:41:17 -0800 (PST)
Message-ID: <ee120531-5857-4bfc-908c-8a6f1f3e7385@colorfullife.com>
Date: Sun, 29 Dec 2024 13:41:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 WangYuli <wangyuli@uniontech.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
 <20241228143248.GB5302@redhat.com> <20241228152229.GC5302@redhat.com>
 <addb53ac-2f46-45db-83ce-c6b28e40d831@colorfullife.com>
 <20241229115741.GB27491@redhat.com>
Content-Language: en-US
From: Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20241229115741.GB27491@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oleg,

On 12/29/24 12:57 PM, Oleg Nesterov wrote:
> On 12/28, Manfred Spraul wrote:
>> On 12/28/24 4:22 PM, Oleg Nesterov wrote:
>>> Now suppose that another CPU executes wake() between LOAD(CONDITION)
>>> and list_add(entry, head). With your patch wait() will miss the event.
>>> The same for __pollwait(), I think...
> ...
>
>> It could still work for prepare_to_wait and thus fs/pipe, since then the
>> smb_mb() in set_current_state prevents earlier execution.

 From now, I'll try to follow standard patterns:

every memory barrier must be paired. And adding barriers to common 
functions for potentially rare situations is now allowed.

(unless it is a bugfix).

And then enumerate all codepaths:

For the wait_event users: We have a smp_mb() in prepare_to_wait(), it 
could pair with the barrier in wq_has_sleepers().

> Not sure, please see the note about __pollwait() above.
>
> I think that your patch (and the original patch from WangYuli) has the same
> proble with pipe_poll()->poll_wait()->__pollwait().

What is the memory barrier for pipe_poll()?

There is poll_wait()->__pollwait()->add_wait_queue()->spin_unlock(). 
thus only store_release.

And then READ_ONCE(), i.e. no memory barrier.

Thus the CPU would be free to load pipe->head and pipe->tail before 
adding the entry to the poll table.

Correct?

--

     Manfred


