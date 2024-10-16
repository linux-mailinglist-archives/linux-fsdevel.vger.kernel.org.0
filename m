Return-Path: <linux-fsdevel+bounces-32138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E2B9A1300
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 21:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9162282E47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BC6215F5B;
	Wed, 16 Oct 2024 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BNupI532"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4842144D3
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108703; cv=none; b=aEli42zY1oHTXQd3WhtW227R7qB6a9RPBfGdVDsev2isPkcG+g4Jjh1Q2poeEGW8uQm+vvHuoo28sUQukg18NcWwnyxntV7r47488RtKsfQa1d2oLIuvCAM8Hnou+21k+Noe+SII264JWSBMXQEs51cNMlCe5P083+W8tBjI1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108703; c=relaxed/simple;
	bh=YvEGdaCkCTEUSquWxdJYTcmhz//eexPD9R0baRR64gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOB5LUJEek/NsVm5PG5FWFf/O3I6gSfVCtHyO8HRFtG728m6mHTAaA22Kop5dNix7eSBgYvBj56Q2w+tpruig8Zhq/tYI4lSZPdhoI7v8LW2PnJ24FP6gX5ShuWfTcR0g/8ihEi8ONFDOqadsBDFOBygD6a3INFEvFVVIE0lgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BNupI532; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-837ec133784so7308139f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729108701; x=1729713501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oykqBF27Cg1WsEM8oIdtzCYaI3LOXySa66d+3hjTzRI=;
        b=BNupI532FxyFbFyFTZUQpwHvkTtGqlB91p/nVbk11hh9kV1Eqhh8j4z/cNmLNNE39j
         y1lNoPp3NHW8zDfMlVvwsVbuL2V4JVBekyuZ+URABr56mGC+M1l1rn1PbVi12aQDb3G4
         OHO4wjC8Uos00+57XF6o/GCl8scLkvV192rP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729108701; x=1729713501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oykqBF27Cg1WsEM8oIdtzCYaI3LOXySa66d+3hjTzRI=;
        b=lZlqbCeeXliykR2IDLgD4/QabLKz/3mmnTpQzrGu+6ln+l91i43I9BpUjBBvuaQFfU
         d5yT+S6uvCLDL53XwFY0DjYaMAYMNUvho4BL1O6YWDnOteZZbZUEIxolf0QijvGbFluD
         DlgP8+GTz+3ai0VGQi/apIf63H7e5uyPmA++/bFjP9KiIyKt1itRzFOQBogpeS1v97rn
         xXyYnSg2Bvi8Jg6MafZpf7ZNl00+dswDradjaG6XtpeGnjv+xpoRW4yRoV16lrttAxTM
         3C608+3C+VUw90iQExxZ3P3vChROiUOf9OjjL0P8ljq4UAsNZnqwvpgn8xGaTTyYXneL
         sVJw==
X-Forwarded-Encrypted: i=1; AJvYcCWtEvZ6XEtoXXsB0n93/jm2B7YRn4Ziizlir7uWm7XBInoG5wIvH2z+j2zrjRucTI0aETpBVByOHiQyOGik@vger.kernel.org
X-Gm-Message-State: AOJu0YxFv8QBSlSnDfeyvu49++U0xYRrjmxAv8Ez/1KB5Vg0tadBskxr
	AaZ7WnsQFthp1RgOC63dU92cF1SehqSnAj2g5khALtWNyfaleTcanvw8lrlplTM=
X-Google-Smtp-Source: AGHT+IEG26gug8dxXfFJbY1LkWfuk3I0y+Nj1NQSbSr3D53poIG/+n2Fi6ldVX/RxyOyB2qrKiHZTw==
X-Received: by 2002:a05:6602:2dd3:b0:82a:23b4:4c90 with SMTP id ca18e2360f4ac-83792703cd8mr2282797339f.1.1729108700563;
        Wed, 16 Oct 2024 12:58:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecb3993esm976476173.94.2024.10.16.12.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 12:58:19 -0700 (PDT)
Message-ID: <fd01038a-0057-4e29-bed7-03846885b089@linuxfoundation.org>
Date: Wed, 16 Oct 2024 13:58:18 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1728578231.git.lorenzo.stoakes@oracle.com>
 <8917d809e1509c4e0bce02436a493db29e2115b3.1728578231.git.lorenzo.stoakes@oracle.com>
 <1d1190be-f74f-45ab-ac6c-2251d0bec1bc@linuxfoundation.org>
 <71221c84-7721-42b7-add4-269a1f25c478@lucifer.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <71221c84-7721-42b7-add4-269a1f25c478@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 02:20, Lorenzo Stoakes wrote:
> On Thu, Oct 10, 2024 at 05:16:22PM -0600, Shuah Khan wrote:
>> On 10/10/24 12:15, Lorenzo Stoakes wrote:
>>> Add tests to assert that PIDFD_SELF_* correctly refers to the current
>>> thread and process.
>>>
>>> This is only practically meaningful to pidfd_send_signal() and
>>> pidfd_getfd(), but also explicitly test that we disallow this feature for
>>> setns() where it would make no sense.
>>>
>>> We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
>>> theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.
>>>
>>> We defer testing of mm-specific functionality which uses pidfd, namely
>>> process_madvise() and process_mrelease() to mm testing (though note the
>>> latter can not be sensibly tested as it would require the testing process
>>> to be dying).
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>    tools/testing/selftests/pidfd/pidfd.h         |   8 ++
>>>    .../selftests/pidfd/pidfd_getfd_test.c        | 136 ++++++++++++++++++
>>>    .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
>>>    tools/testing/selftests/pidfd/pidfd_test.c    |  67 +++++++--
>>>    4 files changed, 213 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
>>> index 88d6830ee004..1640b711889b 100644
>>> --- a/tools/testing/selftests/pidfd/pidfd.h
>>> +++ b/tools/testing/selftests/pidfd/pidfd.h
>>> @@ -50,6 +50,14 @@
>>>    #define PIDFD_NONBLOCK O_NONBLOCK
>>>    #endif
>>> +/* System header file may not have this available. */
>>> +#ifndef PIDFD_SELF_THREAD
>>> +#define PIDFD_SELF_THREAD -100
>>> +#endif
>>> +#ifndef PIDFD_SELF_THREAD_GROUP
>>> +#define PIDFD_SELF_THREAD_GROUP -200
>>> +#endif
>>> +
>>
>> Can't we pick these up from linux/pidfd.h - patch 2/3 adds
>> them.
> 
> We're running this file in userland and it's not obvious we can correctly
> import this header, it'd be some "../../" thing out of the testing root
> directory and might not interact well with all scenarios in which this file
> is built.
> 
> Also the existing tests do not seem to try to import that header, so it
> seemed the safest way of doing this.
> 

kselftest has dependency on "make headers" and tests include
headers from linux/ directory

These local make it difficult to maintain these tests in the
longer term. Somebody has to go clean these up later.

The import will be fine and you can control that with -I flag in
the makefile. Remove these and try to get including linux/pidfd.h
working.

I see your v2 and v3. Please revise this patch to include the
header file and remove these local defines.

thanks,
-- Shuah

