Return-Path: <linux-fsdevel+bounces-33020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9F89B1B80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 02:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF11B1C203B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 00:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86C1367;
	Sun, 27 Oct 2024 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f708o2Nu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEFD1362
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2024 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729988520; cv=none; b=KJ1h2swA+VYSWy+094pkAXJeUqgN5WNsyHrw/osv9W/jGNnEjumSTIMR8dMpXmSTA+b8a8nJYMiBi4xKKoFlRC9zsjBPMgbOsgjReUJcuiBh3wDChw/0D1tIVu8AHpa3BdXX2tFl9YT3UWbqHI6z/s+T8mBfgDcFfs3zV313nC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729988520; c=relaxed/simple;
	bh=t8dX82U9cPs+9T3asew1xbFQNPZRnIXsevD+EoDBlE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEWXttTheB9X/qLuHFNZ20bsW4Y/0wKZUbaEY0fsfnyvsAe+X2bNuAskYre7FdDpcd+0KpO3ePTqAKlTicyzT5e1jDA8GPAj52MdCXmVkQO2nckSjkoXYPyJpJgcULUotayDt8tHj3Pyq/KSqroMCAXptjQmd+VW9rfDkuV1Exo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f708o2Nu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b15467f383so232618985a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Oct 2024 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729988517; x=1730593317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7j4FNV95378DUAv0aYV4P+N+y6PbmVTLk3giCbV25E=;
        b=f708o2Nueodczn1bzE5t5T5BPqcgUJAgx0gQP1+cSkoERlpnTP+ocXvn8oU6JYbQlE
         qJsCd5dveLZPYAutJCeXRkusMtOKEZpJRk9VoMnMRzrslmpi1eMZdBVbt5lv3qCjSG77
         HdIaw2ciNyGhHwMmsAIz87fg7Ekg7X5QAOlRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729988517; x=1730593317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7j4FNV95378DUAv0aYV4P+N+y6PbmVTLk3giCbV25E=;
        b=RK5EIDXFihPwh5aL+JkJETz36aODQkG4tSIZVQ3rr+iBdIIoevoZIHzLvYc5Qo76S0
         KE7fodJ3muY/ZixHz8UcSomtzgVd7R4p4BI7EwUagzhtWgl+7NdhOQ2ueJJ7Fxgob0q8
         hxR44LUoY50XMMDBWo0aWpsLLU1+qWpyygpmMyFjWOx6ODkr4pXFJT3s0LYfGGeFzHhq
         THFwBzasx0XYQLc4hm92vvuZ3GEPRFcmjck8vv4VGl3q3UnkAwJNswpzxgI9is6Qzpdo
         q9R1qbU2mVnyNYuwhlE2yBzxFAKVSzKqA87CHQQZX7v4wVk+/bchpNxHg2GeHkYHHE4r
         1bZg==
X-Gm-Message-State: AOJu0YxqzNEJaEGVGPH0rKqdNmI1wPRL74FiaWShvVJYE6xFIgTFeo2Y
	VO2EhJ7wEJB+i/Z5TcOw6ZTxfGhUdgKrCYUNFGQ+2hD/v8ydrU3MyARvTTs7Brg=
X-Google-Smtp-Source: AGHT+IH4ih+zoFcvyA0nzJ0+mHZTbxAhnb2QWdXil4a3idBcvVSG0Y0NAMhmh9poRPTm9oecTcb8dA==
X-Received: by 2002:a05:6214:4a93:b0:6cb:d1ae:27a6 with SMTP id 6a1803df08f44-6d1856b4ee5mr61667976d6.24.1729988516543;
        Sat, 26 Oct 2024 17:21:56 -0700 (PDT)
Received: from [172.19.248.149] ([205.220.129.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613228efd9sm20866281cf.51.2024.10.26.17.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 17:21:55 -0700 (PDT)
Message-ID: <f8dbd839-9072-4159-970d-bb87fe2ebf04@linuxfoundation.org>
Date: Sat, 26 Oct 2024 18:21:23 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mount_setattr: fix idmap_mount_tree_invalid
 failed to run
To: zhouyuhang <zhouyuhang1010@163.com>, brauner@kernel.org,
 sforshee@kernel.org, shuah@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhouyuhang <zhouyuhang@kylinos.cn>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241024095013.1213852-1-zhouyuhang1010@163.com>
 <1c8674a0-d220-4349-88ea-780f0fed8545@linuxfoundation.org>
 <afe66b04-3990-457c-ad43-9b5370a815d6@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <afe66b04-3990-457c-ad43-9b5370a815d6@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/25/24 02:08, zhouyuhang wrote:
> 
> 
> 在 2024/10/24 22:26, Shuah Khan 写道:
>> On 10/24/24 03:50, zhouyuhang wrote:
>>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>>
>>> Test case idmap_mount_tree_invalid failed to run on the newer kernel
>>> with the following output:
>>>
>>>   #  RUN mount_setattr_idmapped.idmap_mount_tree_invalid ...
>>>   # mount_setattr_test.c:1428:idmap_mount_tree_invalid:Expected sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)) (0) ! = 0 (0)
>>>   # idmap_mount_tree_invalid: Test terminated by assertion
>>>
>>> This is because tmpfs is mounted at "/mnt/A", and tmpfs already
>>> contains the flag FS_ALLOW_IDMAP after the commit 7a80e5b8c6fa ("shmem:
>>> support idmapped mounts for tmpfs"). So calling sys_mount_setattr here
>>> returns 0 instead of -EINVAL as expected.
>>>
>>> Ramfs is mounted at "/mnt/B" and does not support idmap mounts.
>>> So we can use "/mnt/B" instead of "/mnt/A" to make the test run
>>> successfully with the following output:
>>>
>>>   # Starting 1 tests from 1 test cases.
>>>   #  RUN mount_setattr_idmapped.idmap_mount_tree_invalid ...
>>>   #            OK mount_setattr_idmapped.idmap_mount_tree_invalid
>>>   ok 1 mount_setattr_idmapped.idmap_mount_tree_invalid
>>>   # PASSED: 1 / 1 tests passed.
>>>
>>
>> Sounds like this code is testing this very condition passing
>> in invalid mount to see what happens. If that is the intent
>> this patch is incorrect.
>>
> 
> I think I probably understand what you mean, what you're saying is that the output of this line of errors is the condition,
> and the main purpose of the test case is to see what happens when it invalid mount. But it's valid now, isn't it?
> So we need to fix it. I don't think that constructing this error with ramfs will have any impact on the code that follows.
> If you feel that using "/mnt/B" is unreliable, I think we can temporarily mount ramfs to "/mnt/A" here and continue using "/mnt/A".
> Do you think this is feasible? Looking forward to your reply, thank you.
> 

What I am saying is if this test is intended to test invalid mounts, passing
"/mnt/A" makes perfect sense.

>>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>>> ---
>>>   tools/testing/selftests/mount_setattr/mount_setattr_test.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
>>> index c6a8c732b802..54552c19bc24 100644
>>> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
>>> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
>>> @@ -1414,7 +1414,7 @@ TEST_F(mount_setattr_idmapped, idmap_mount_tree_invalid)
>>>       ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/b", 0, 0, 0), 0);
>>>       ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/BB/b", 0, 0, 0), 0);
>>>   -    open_tree_fd = sys_open_tree(-EBADF, "/mnt/A",
>>> +    open_tree_fd = sys_open_tree(-EBADF, "/mnt/B",
>>>                        AT_RECURSIVE |
>>>                        AT_EMPTY_PATH |
>>>                        AT_NO_AUTOMOUNT |
>>
>> thanks,
>> -- Shuah
> 

thanks,
-- Shuah

