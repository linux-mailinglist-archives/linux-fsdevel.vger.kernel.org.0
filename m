Return-Path: <linux-fsdevel+bounces-21445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00426903F9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 17:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E301C245BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBA454FB5;
	Tue, 11 Jun 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f2YWHNa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A23A1DC
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118270; cv=none; b=OtN8vzd4i4Xd4SIsDdz6lnBy1ghdmU8zc+10IKP49/c3hD2/y+XaoRKO71U5auz1H9zvNsiExZ9CdKl9ws5ekiVZxl7jswuN5d5nUNdrnyw3rzJhleYfifI1l8h/LKV5US6jkaQnKc+2K4ad0QrKOyGOeHrjo67tPlRA5bs8T9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118270; c=relaxed/simple;
	bh=AkUd3nITwa1Nsrx5FGIDh+oFc9gDF9r3YGUNfEDGOdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktH/zHvPAI0Tpg9BXDSMLVNOwbtBgSmJ1jZ6G9nvmytpaQPgSYjM1fhT6e9kKsS6v8GxVH/2eelYVpGkQL1oyMwCbPIRZci/PSig2zRJU2eR+UvMlgaFMvt5twdAjOgqjmRYJx4bbzuIr0M6qiz1vbdaHQrkGQHFKorwFweqmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f2YWHNa+; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d22b2a6261so151703b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718118266; x=1718723066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1vw+2ACNqWtSlz7WiuesM2J8QxhMf27utzH+YpcgUU=;
        b=f2YWHNa+NzKq6p06NcHmTrhmFPxBNtf57gmsdOhfH8ZMkjt7WXez7KiFFABFba2guQ
         E7R9Hk3EWcEqvvov7f37ydSrEy0UyhahCv+hphrtrbf/ghRwesyD9P3jOjFUKYTuFWkb
         5VyPBtCQk4a45pX81xHF894pzb9xnol4pxoRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718118266; x=1718723066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1vw+2ACNqWtSlz7WiuesM2J8QxhMf27utzH+YpcgUU=;
        b=FDiIxXpAfGcqAIaOs09RTiL7fvMpYpULpLRWMd5s6uZPhwYrMKTBx0qFaCdNJKdrrJ
         7jbBysC2T/E6sChAdLk1SPhhhBRMoVtICM7E3vanuzHqNf4yCnTrjFWrsL1fmFgbm6SR
         qjb4IEfewpN96It3sLuFRD8/lkGtNJxhZQnHOMOioetATQFfWooM29jTy0p9oSbNrUB4
         vdubYaMFFxPtFZ60a0pDd9sa+XUF0HIATM4RWIr9LeFe6gVLi1101f4JfLpMt0U18YfB
         TYME3Af4E0EkFs0cZ/PoOtKeudcIax4BcD8bpebyKrtt9iCbuX9/FsC2NC9NYNhkEPIU
         KAdA==
X-Forwarded-Encrypted: i=1; AJvYcCU6I8DScfYPX53RPezlVNMrPqJ1y/jhvVVT33XLHfM58ko+9Byue9mt0XRhk6KurFzhnl6n/4mgLfcXke/X8pTfjWhUMYSH606eOxvGcg==
X-Gm-Message-State: AOJu0Yyxk+vwxfPJAGcx9yogloh/xPhq58j7dm+5yxMSbG8AqY72QIRx
	KxBBK5SDFonnTyv5cGpkf66m+xUCfo2uWs7wPZTrr9bMyaI6u764DlbJPpNPmGs=
X-Google-Smtp-Source: AGHT+IGlfmuk878CG8En5W5lnHLDlQmd3V99IlMUJd8rH48VkCqYhG6rTzSfb4MZ//slpZJu5TCXQw==
X-Received: by 2002:a05:6808:1b08:b0:3d2:2356:d271 with SMTP id 5614622812f47-3d22356d368mr9188713b6e.1.1718118266435;
        Tue, 11 Jun 2024 08:04:26 -0700 (PDT)
Received: from ?IPV6:2607:fb91:213b:a129:544a:cc06:ea0:4045? ([2607:fb91:213b:a129:544a:cc06:ea0:4045])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccacadc00sm20643537b3.1.2024.06.11.08.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 08:04:26 -0700 (PDT)
Message-ID: <0556ee55-6bdf-4392-8933-03539768f671@linuxfoundation.org>
Date: Tue, 11 Jun 2024 09:04:24 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: proc: remove unreached code and fix build
 warning
To: Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Amer Al Shanawany <amer.shanawany@gmail.com>,
 Shuah Khan <shuah@kernel.org>,
 Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 kernel test robot <lkp@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <202404010211.ygidvMwa-lkp@intel.com>
 <20240603124220.33778-1-amer.shanawany@gmail.com>
 <14f55053-2ff8-4086-8aac-b8ee2d50a427@p183>
 <20240604202531.5d559ec4daed484a7a23592c@linux-foundation.org>
 <eb9b2d6e-91eb-4fdc-b352-b3d0c290da2f@p183>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <eb9b2d6e-91eb-4fdc-b352-b3d0c290da2f@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/7/24 09:25, Alexey Dobriyan wrote:
> On Tue, Jun 04, 2024 at 08:25:31PM -0700, Andrew Morton wrote:
>> On Mon, 3 Jun 2024 17:24:47 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
>>
>>> On Mon, Jun 03, 2024 at 02:42:20PM +0200, Amer Al Shanawany wrote:
>>>> fix the following warning:
>>>> proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’
>>>
>>>> --- a/tools/testing/selftests/proc/proc-empty-vm.c
>>>> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
>>>> @@ -381,9 +381,6 @@ static int test_proc_pid_statm(pid_t pid)
>>>
>>>> -	if (0) {
>>>> -		write(1, buf, rv);
>>>> -	}
>>>
>>> no thanks
>>
>> Why not?
>>
>> Why does that code exist anyway?  It at least needs a comment.
> 
> OK, whatever.
> 
> If test fails, it better record buggy output somewhere (to coredump or to terminal).

+1 on reporting results - the best way to do this is to add a meaningful message
for users to understand what went wrong.

Please suggest how you would like this warning addressed and report the error.

thanks,
-- Shuah

