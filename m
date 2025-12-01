Return-Path: <linux-fsdevel+bounces-70373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D4C98FDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 21:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2174D4E23F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 20:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8925EFBB;
	Mon,  1 Dec 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBQxwwe7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F38A937
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620409; cv=none; b=Kiom9TwGbFNkflLWsNz2IYJGu4MrHiAlmxn2EHEMjn41x4GF7HVKep15FP6NaIacpWwRRi18l+Gjr3lzfNYMBB4jd3K/xukIYsWm0KpzEC3BXFgD+81DclUR2dIaWU+g87rotb7tXbFkmI1W3YDq8jw30aQSZyokulRlIRXmAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620409; c=relaxed/simple;
	bh=PRa8xOIamTzNHpbPH630DV3HxeBrPukZASLt2qOiZYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hrd0a/Yi9LKOIxHT2b0XdVc15njS1StJOBVkO0pU/3O3YReMRmsRsAz7CYANTf8oK57Mbl+J+LODHKRwmumaMVkKAX/DWda9dH5i8fwbVZI7E4F4g8zvTeBLqmEdJK07UO8GvopUOZanHZZ7QYSBDNA9wtDr8iNUdc6EvUO+BIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBQxwwe7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a5a3f6bc2so5307441fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764620405; x=1765225205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7gDd4anQkoBfhiiCVrvGxkPHRjrXJfUkA8sU3Wlt60=;
        b=GBQxwwe7UO1HEXKmUygkJ+K8m0OA21J4h507z5W/B0AlXLeiqMN/WQpqSwrV37ebrN
         iNGN42ir0f8ZdZPuSCl6i9kroAlMCGyQrxGr0MHEjJKpkVN1ipiB+Q91cQSqxff0wuif
         zLaLms07CAjqqtrQ9wicCUe2LNeLcx1HvxfpKbaPwp6Uy8FnapE9Q1D3QRNPTT5c7KqK
         59VPNx8vazHM1wtUWvc4weKLrCkCVf43EHs6aUvnfc+1CNAEv94Rgnc4o2EXrEFSFCkW
         dlJqdTVtltT/Lx5sHfi86gFHNKLj8CNPuDDlls53hwkaa53HtAO5sNvwCCLql5kntCKZ
         jl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764620405; x=1765225205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7gDd4anQkoBfhiiCVrvGxkPHRjrXJfUkA8sU3Wlt60=;
        b=DaAW7R8WHDfoOOatb5s+Phc5b8wxJpNdjkGwPwsEXUE5oeN/P50eMI4/Gm+ZDrCm9z
         yEFVC3xMwZ6zIfN2AzB/73TiRkNDvq/4tBSGJ+YmX6aRu44DzxRlGbmH9aLMtF71kqTZ
         QAKBV4I8HrER5b4WJv+enyUR2+vW8GLmMkYFPO9+Iy3Glceh4o5HJvl87co7+OO+RHe4
         IHJHmJcnhsa69LAWrEuETLKIkFiRVByiszFD9zzx6O8u9eG8TaDnadwxirt2DAMDgxxW
         NlpUyKkN+spmQ1G5rsvUCjoR3AS5NYekf5mZJCwGOVa/jmjVDoHIM7xf9yd/350MPZ5p
         tg+A==
X-Forwarded-Encrypted: i=1; AJvYcCXdMyf1BtN6V1H3vLou7X/sFBLKhAHnCkzchahOOZpxW2Mr4N5+Wrb87cJ8J69TrRG4WZMcRssYU2ng8Oz6@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/c4f/VqNANLYDmdxm5WaPvJ4Kqj9edYQ5wm+X+eiBFQkeWVt
	mrLcnNNng2LVA+9rLc6WiyBrr7aGUvj9bN/TnpJq1k53dmaPeMYMMvjCDo++sg==
X-Gm-Gg: ASbGnctOn9OXSkcoMQqoc/7EtgGpGtF9+RtFuso5joOoNCPsjCB+nPxLnf3CScN/0ji
	7ksxxmHZt0DgzKakYUzE/BLGM5CtRCl+qnOu4+puDRaF2XQKwIKAA6pW7KHxAh6wyFbq0vb+USi
	JRfhDqeKzPlwg/uA8LEOqQr6i0DLiKeBb9eHXEgtFO+C+8NFH6Ai77+oY3RtuSNhrI9/wFioz8O
	c02sCDUGAvacCvmzcaN/p3uJVfQ+JRgc2OjyMoLpKN9kXm7wLbcwEprPMbXiXLOwB7BdHQm1oWY
	1wPHJNP+cwW6GqnnpD4vFLdngBf6dsW584hl2Yr9VOeI+tnbxBBWezzM88wG0xhUQRnLbORU7Zt
	+dRlW7IQsxjyEnnEHMttebsJD4iUnKyd/js9JHw+z95Id2sozYag1gd7rNOy+o+Cud7VAdvcYHG
	3s/f6Bkegmzl/3gGFY9sBIEfZtWqYSZA==
X-Google-Smtp-Source: AGHT+IGwThqm95w486AYWsPySskZwV9201UP4PC6YOAvGfNVr7lYqFBtxOShdiiOWC//XsnIcrTJPg==
X-Received: by 2002:a05:6512:e9a:b0:594:2a0f:917e with SMTP id 2adb3069b0e04-596a3ed45f2mr7386124e87.6.1764620404865;
        Mon, 01 Dec 2025 12:20:04 -0800 (PST)
Received: from [192.168.1.105] ([165.50.39.229])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bf8b730esm3899389e87.44.2025.12.01.12.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 12:20:03 -0800 (PST)
Message-ID: <2795a339-dc82-4a1e-8c97-87dd131a631f@gmail.com>
Date: Mon, 1 Dec 2025 22:19:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "brauner@kernel.org" <brauner@kernel.org>
Cc: "jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
 <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
 <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
 <4bb136bae5c04bc07e75ddf108ada7e7480afacc.camel@ibm.com>
 <59b833d7-4a97-4703-86ef-c163d70b3836@gmail.com>
 <9061911554697106be2703189f02e5765f3df229.camel@ibm.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <9061911554697106be2703189f02e5765f3df229.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 8:24 PM, Viacheslav Dubeyko wrote:
> On Sat, 2025-11-29 at 13:48 +0100, Mehdi Ben Hadj Khelifa wrote:
>> On 11/27/25 9:19 PM, Viacheslav Dubeyko wrote:
>>>
> 
> <skipped>
> 
>>>
>>> As far as I can see, the situation is improving with the patches. I can say that
>>> patches have been tested and I am ready to pick up the patches into HFS/HFS+
>>> tree.
>>>
>>> Mehdi, should I expect the formal patches from you? Or should I take the patches
>>> as it is?
>>>
>>
>> I can send them from my part. Should I add signed-off-by tag at the end
>> appended to them?
>>
> 
> If you are OK with the current commit message, then I can simply add your
> signed-off-by tag on my side. If you would like to polish the commit message
> somehow, then I can wait the patches from you. So, what is your decision?
> 
I would like to send patches from my part as a v3. Mainly so that it's 
more clear in the mailing list what has happened and maybe add a cover 
letter to suggest that other filesystems could be affected too. If that 
is not preferred, It's okay if you just add my signed-off-by tag. Commit 
message for me seems descriptive enough as it is.

Also I wanted to ask 2 questions here:

1. Is adding the cc for stable here recommended so that this fix get 
backported into older stable kernel?

2. Is it normal to have the Reported-by and Fixes tag for the hfsplus 
patch even though the reported bug is for HFS? I guess it's under the 
same of the discovered HFS bug so it references that?
>>
>> Also, I want to give an apologies for the delayed/none reply about the
>> crash of xfstests on my part. I went back testing them 3 days earlier
>> and they started showing different results again and then I have broken
>> my finger....Which caused me to have much slower progress.I'm still
>> working on getting the same crashes as I did before where I get them
>> when running any test.Because I ran quick tests and they didn't crash.
>> only with auto around the 631 test for desktop and around 642 on my
>> laptop for both not patched and patched kernels.I'm going to update you
>> on that matter when I can have predictable behavior and cause of the
>> crash/call stack.But expect slow progress from my part here for the
>> reason I mentionned before.
>>
> 
> No problem. Take your time.
> 
Thanks !
> Thanks,
> Slava.
> 
Best Regards,
Mehdi Ben Hadj khelifa

>>


