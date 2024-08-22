Return-Path: <linux-fsdevel+bounces-26661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0EC95AC72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 06:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE60D283C2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 04:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6D637143;
	Thu, 22 Aug 2024 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DmpP91GQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35841CD3F
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724299933; cv=none; b=W72zzMbm1mM2VCI+VsSwDlLETYWdITSqRT3JVvl5n2i+40TcDHB4PZK8uemFKeqlM40GtHhZcSYLkMF1Jy0mxgM2xK6ej4yagNn/jxdjj1aDABFwHThH8EHazA3ABrAKSyMr/g/92FaW86yulSdE0IO5juw8whEzjc6HYoomVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724299933; c=relaxed/simple;
	bh=xOPhVQYrdJ4/PDoSa4p+l+ZPMJkFYrTiJbXWbEjW7AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxEMx2fdQ3rpIVpbxiQLRq4e8u6wCrAH1KPpsZS5ZspFWiNNhFecaNwry9nr13TQH1Bni73F1YUs0/JgsxJIP6Ls9zmUXJIZR66ABLdTxlnmIblRTT4GC1r3IrJzFmnwSrq7b04q9qxdgnn9Tw7CjxMf1KsPLieEdTlkitAbqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DmpP91GQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2021c08b95cso11757225ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 21:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724299931; x=1724904731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZ+7VFwj048rHa5sI0hRAyf82MkJTEX7rTgiunMl8Iw=;
        b=DmpP91GQsP+RQ7DzoaCVdtjc9DsI+nW3T5F+JT4NBrkpKj5zpbUQaS2IQ1Q9Zdhc5i
         M08sSDPzBv00ygJahtW+Xumsh8Qv7WvpZpLC5jg5LoW7OPEVEFmQXqVvKAgvUDJNIRx+
         BaFPH60lzfKJwBzntWz578Sf12rNojboXOrVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724299931; x=1724904731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ+7VFwj048rHa5sI0hRAyf82MkJTEX7rTgiunMl8Iw=;
        b=dauu+eS5gOXDEZnWDaars9amk9zU3QBh5JBLMen+BlItq1ZrQ2aWgriImRhPVfQqCx
         BGjGbaLGzTpB0gSFnVRLcsX1g+LlITx4JpuliMNBzi1ikVDeOI1ZCAYZv2rPuT7jqCee
         GywNqYxu/OOH8oZ664GhnnYqTkK8iXDzhsnRMXINTkGWGNYLKi4w0Dp8LVmJKN0f8P55
         aveMf5o06dSAz9XV8PYazQvtXW84Xhz0hapqqaCi+aGBXKzauWgHI39Duk/ngeJ1KsRL
         B6wOgghW5OS2Pa1kKLVqY/03cSNaeHfeMvo9d6jD4NlF/38sfN0yiJbkBnsNA2ngywke
         LK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1X1BIgA3g4wGgFB2T/ZtNzgFy9HTC3aH5vL9LvJcT9IztMhB8BuILM1NMr+0ctPBase+2YazQCB39SiRD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Mz0p08oidnoJaCvFWDpYbOeUmvN9ciBZhhXsI60xXletaJr3
	AYfI78WpjGWItetaJ3sPU3f9TNJ88WwfQzDAGQA8Tb4+88a/uyz4H1mX/P5B25k=
X-Google-Smtp-Source: AGHT+IGRqwd1qSXYME52HuFQ3VHz4GMr/UyGfyWGAuVueXYnT+iXnDJM2JUqBHJcdEIp3PdVneU4RQ==
X-Received: by 2002:a17:903:230e:b0:202:2e81:27cd with SMTP id d9443c01a7336-2037fe175c4mr29988075ad.26.1724299931002;
        Wed, 21 Aug 2024 21:12:11 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dd2ccsm3553645ad.156.2024.08.21.21.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 21:12:10 -0700 (PDT)
Message-ID: <5633b2e3-d673-4431-90b2-6c2f6b9acd47@linuxfoundation.org>
Date: Wed, 21 Aug 2024 22:12:07 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [viro-vfs:work.fdtable 13/13] kernel/fork.c:3242 unshare_fd()
 warn: passing a valid pointer to 'PTR_ERR'
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <020d5bd0-2fae-481f-bc82-88e71de1137c@stanley.mountain>
 <20240813181600.GK13701@ZenIV> <20240814010321.GL13701@ZenIV>
 <7bf93dfd-1536-438c-9ffd-f7dcfce0b3f5@linuxfoundation.org>
 <20240822001536.GL504335@ZenIV>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240822001536.GL504335@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 18:15, Al Viro wrote:
> On Wed, Aug 21, 2024 at 12:38:48AM -0600, Shuah Khan wrote:
>> On 8/13/24 19:03, Al Viro wrote:
>>> On Tue, Aug 13, 2024 at 07:16:00PM +0100, Al Viro wrote:
>>>> On Tue, Aug 13, 2024 at 11:00:04AM +0300, Dan Carpenter wrote:
>>>>> 3f4b0acefd818e Al Viro           2024-08-06  3240  		if (IS_ERR(*new_fdp)) {
>>>>> 3f4b0acefd818e Al Viro           2024-08-06  3241  			*new_fdp = NULL;
>>>>> 3f4b0acefd818e Al Viro           2024-08-06 @3242  			return PTR_ERR(new_fdp);
>>>>>                                                                                  ^^^^^^^^^^^^^^^^
>>>>> 	err = PTR_ERR(*new_fdp);
>>>>> 	*new_fdp = NULL;
>>>>> 	return err;
>>>>
>>>> Argh...  Obvious braino, but what it shows is that failures of that
>>>> thing are not covered by anything in e.g. LTP.  Or in-kernel
>>>> self-tests, for that matter...
>>>
>>> FWIW, this does exercise that codepath, but I would really like to
>>> have kselftest folks to comment on the damn thing - I'm pretty sure
>>> that it's _not_ a good style for those.
>>
>> Looks good to me. Would you be able to send a patch for this new test?
> 
> Umm...  Send as in "mail somewhere specific", or as "push into vfs.git",
> or...?

If you can send the patch to kselftest mailing test, I can take this through
my tree.

thanks,
-- Shuah

