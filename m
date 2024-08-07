Return-Path: <linux-fsdevel+bounces-25253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983EC94A4D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09440B22238
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ACD1D175C;
	Wed,  7 Aug 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY+G/K8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0D1D174B
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024804; cv=none; b=FIVr/1tSPQipPwx7mJpEGDGfeqUm9vwqOGkJeJeY+t1Ysl3aIi6LSNMO0jheYSo4OeRtWV2vsvcJWEiERduL+H/hRYIx36p2raUwWDci7VFJABZZs+/BnvkPRQHWxioGsNx4I54wBZ7BIA1YvGsp/mJfm6KlroQHCB/v2GL+v2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024804; c=relaxed/simple;
	bh=/jsrA4Img+qlWahH6jlteyJlIduaQB/yPTgj4sCesNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWF5es5c8/q2KYjTnm7CAIYCPvsETgSZHQS539t9FjRnm5q5qV0u4W3yoLk7uVkMnconhhBCX09TwClhiZScm2RD8n58ZyZwh6uC6SvZe64z0NNtJNIaFmFr09x7eO31mAvfikMEfrE3+7GHfm2uGx1OSaIDUEI7uj1bFGrHgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RY+G/K8E; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso1920895a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723024801; x=1723629601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95MOr2Nqpzaj8+hgDHljrv8kJYESZgT7/x0j3jGO6bQ=;
        b=RY+G/K8E5DGQUC1ogAXCbz4dvqGmIIukSOMXByLkH+KtvhK437SCBkOVihT1Nfp7ra
         cbvm5l2IfgzIYNoMjfIM7EThuyZC4YZiJf96fIk7FsdhQIKEgL1E2OeelmTZZpnzhgK0
         mqHp1we/mmvnAvmr9osjsZK96LKxHhLuovp+ZEcbWIqNOIW8xfiloRUaqUibkH9EBf30
         xzaWRpRWRMt4Lt5LfEyMoSbonMeA4XPqmMSlJMb/p+V3yVxcJZtq4o7RakF9KyDVcus0
         GHPeQpznTzeB8T557dizB0eh8hM9rCWDk6spGOcMTq+AnPj0oVAOB7PEPOoouIxZXUdK
         UPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024801; x=1723629601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95MOr2Nqpzaj8+hgDHljrv8kJYESZgT7/x0j3jGO6bQ=;
        b=FDXmG35rvrXv/ucwpfQTsKUnzze6myddZYDYxrYNYFwm9kKGlrF+zuL6d1AUcni5uZ
         EPqHMkoCazerptyAuD9aQjhxRA8hO5CLZoBQnWx89CUS4hTxj2FXPJJz2sc5mqIhUqJu
         g6ggQhfCYKCb/IAOlRBGRpy19euNHgI6kJjFTjvyha24btc40gsxFrThlA6w3E3GtDln
         Omc7xWJE8GWa2PiBahI6vWbgpXUjbzGAcJv+y9TAgNVXsUiAjtfM+0s1oI9067sShcWZ
         pQ87WNBhtVoAazNdWlB60Hfl6T5+pZCDHSkfKmT8kUmoBiLjGu/hFquLvrzbTZBsJ4lI
         ohQg==
X-Forwarded-Encrypted: i=1; AJvYcCV+/F8N/DvX78UOls61lj1NJsUAvkChOUla/Xtyv2EGpJabVAZzldTykErP/CX1kMV/ygJckqN6csu8/kj8p+5Dp2eUjTweO/guGC2PeA==
X-Gm-Message-State: AOJu0Yw6nssX4a45rMNaE1oCVZ+jXTd4oH0dDJmRMet9dSlzGnRpUdBj
	GzqMvyUUmJGeU7uZgctbUEzNwlTgSb1hPXs2xa0WEt7dfmLw3/9+6ziBbg3DbXc=
X-Google-Smtp-Source: AGHT+IF+gip/DTvnEMfinas8Dy//yVlsojjlA4Pv9/lXs0zNoaaogYms61L9cR7FBQ8BvCrZVYEkbQ==
X-Received: by 2002:a17:907:934a:b0:a7a:a5ed:43d0 with SMTP id a640c23a62f3a-a7dc5071046mr1387925166b.47.1723024800697;
        Wed, 07 Aug 2024 03:00:00 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cbe6sm625039366b.71.2024.08.07.02.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:00:00 -0700 (PDT)
Message-ID: <79fb2439-db38-4aad-bf91-2d3b031309a8@linaro.org>
Date: Wed, 7 Aug 2024 10:59:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: don't block i_writecount during exec
To: Mark Brown <broonie@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, david@fromorbit.com, hch@lst.de,
 Linus Torvalds <torvalds@linux-foundation.org>, amir73il@gmail.com,
 Naresh Kamboju <naresh.kamboju@linaro.org>, ltp@lists.linux.it,
 "lee@kernel.org" <lee@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 William McVicker <willmcvicker@google.com>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
 <f8586f0c-f62c-4d92-8747-0ba20a03f681@arm.com>
 <9bfb5ebb-80f4-4f43-80af-e0d7d28234fc@sirena.org.uk>
 <20240606165318.GB2529118@perftesting>
 <1eaedeba-805b-455e-bb2f-ed70b359bfdc@sirena.org.uk>
 <550734af-e115-4048-8a8f-0fdaa199c956@sirena.org.uk>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <550734af-e115-4048-8a8f-0fdaa199c956@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/24 6:49 PM, Mark Brown wrote:
> On Thu, Jun 06, 2024 at 06:33:34PM +0100, Mark Brown wrote:
>> On Thu, Jun 06, 2024 at 12:53:18PM -0400, Josef Bacik wrote:
>>> On Thu, Jun 06, 2024 at 04:37:49PM +0100, Mark Brown wrote:
>>>> On Thu, Jun 06, 2024 at 01:45:05PM +0100, Aishwarya TCV wrote:
>>
>>>>> LTP test "execve04" is failing when run against
>>>>> next-master(next-20240606) kernel with Arm64 on JUNO in our CI.
>>
>>>> It's also causing the LTP creat07 test to fail with basically the same
>>>> bisection (I started from next/pending-fixes rather than the -rc so the
>>>> initial phases were different):
>>
>>>> tst_test.c:1690: TINFO: LTP version: 20230929
>>>> tst_test.c:1574: TINFO: Timeout per run is 0h 01m 30s
>>>> creat07.c:37: TFAIL: creat() succeeded unexpectedly
>>>> Test timeouted, sending SIGKILL!
>>>> tst_test.c:1622: TINFO: Killed the leftover descendant processes
>>>> tst_test.c:1628: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
>>>> tst_test.c:1630: TBROK: Test killed! (timeout?)
>>
>>>> The code in the testcase is below:
>>
>>> These tests will have to be updated, as this patch removes that behavior.
>>
>> Adding the LTP list - looking at execve04 it seems to be trying for a
>> similar thing to creat07, it's looking for an ETXTBUSY.
> 
> Or not since they reject signed mail :/

FYI, I encountered the same test failures. I opened a bug on the github
ltp project suggesting that the tests need to be updated. Here it is:
https://github.com/linux-test-project/ltp/issues/1184

Cheers,
ta

