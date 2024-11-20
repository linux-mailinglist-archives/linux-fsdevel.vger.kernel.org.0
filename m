Return-Path: <linux-fsdevel+bounces-35363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D629D439B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 22:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FA1281AF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E951C9B68;
	Wed, 20 Nov 2024 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MeYWmTVv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D191BC086
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138627; cv=none; b=FreVn75JKR3w4+dfVNjn16AvmgjFWMr8RSbwdga8bjKShmnyRvspNeGeL91Ye5EKkmPa8gSFYkOGx839KOnjpLwUrCuEVWowFtNZ/AvbfMxJCYUDiCRd8XdLQNvDPNY4WO1iHBkhRhVMZYdHBqPHaMCxHtTjzdvPzXPGEfZAMMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138627; c=relaxed/simple;
	bh=Dw2Ll9Gwn+k29p70ZTUleOytZnVqCugzlphszcxxfzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGOV7a7mJ8gGnSYmKbX+U/NtRYpnqGjZmN0v80u21Esrt6luDKctmq5IUFkKepI/FjcFiXAU3eNuV0ASC/TeQFapGIHf/wRtsfJMBzU2yCInQQO9diSvz7Cp1i7Ns7qmULBH+p1UDxZtv1ZQOAV7AHDY/8OBY6yDfjW25opyWgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MeYWmTVv; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a789d422bcso631905ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 13:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732138624; x=1732743424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkDriyklSYIXnRtBbV/2oL8EGau2YNOpOVYM/WBqiNo=;
        b=MeYWmTVvSDsR6iANgUGHvQn/6MZxKmEo4dphCE5chM4IPMvdMx27mW5SqlwWQKAZ0d
         QtXCZ0SC4QKElBXdw4ILi2j6YNFJ5vJAq2l5T8JQwNcKMVTqo7TNLDwuJTeTMxtabLuL
         YBfayVNZz9u8Z60nwxHpcmek5V4g/CzvcXXPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138624; x=1732743424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkDriyklSYIXnRtBbV/2oL8EGau2YNOpOVYM/WBqiNo=;
        b=HWCuXDm12iQfjSvaO7cPkctxdCHja/zuoRe9goa9Yoay0hBUVc2FoR9yiW5PLlMuJU
         gqRwZo8Jt2HlqOAX7Vgp3esdAlasOFgyBezOjkfOcIkjPXlu3eW8ih4XYWZ8t+qlH8at
         7zlvqGZKYa8UWIjTxVDxFH4vj7bixHY5pjsXhlqBFhI8Z0tiaV7owlQzbuMpn7Q8fpy8
         mIOH+vyYVsZXZjjKCp9qgbxxDyJRhaCHHVHr4nioAN2AgbI0ok0ztI9m+bPWkrjpomqv
         T54/lshImy9qngTY2DaDGpxJwDtmtcRNRYe3Hetj4ia1Nnu/QP0/hLBrOaFFXbHp2jS2
         Qk3g==
X-Forwarded-Encrypted: i=1; AJvYcCVtmYrsQpb/tkhUGhhWAnLEEmwtWYy5KBQo3dhdljGN1C35ZYQVAljqNFdNh+HFs3exy1JLEhmzVGUaV80g@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnK4wBHuC1vzTIBhFECvyBaSkeXN4b4B5IoCZnyFpZFwdUwxf
	/PA2qV5e5ZjkXaaWLauRCQ1flYLVzi9JO6uxkX3mhfZZ9+e5V2WSK3LC0cHPpWo=
X-Google-Smtp-Source: AGHT+IECDJJRPWSU30iT3pOjIWZv3KkPrL5TAkua1V1Lwdovo5LeRY+OV/MaHoVfavwoEcCxEyIAnQ==
X-Received: by 2002:a05:6e02:184c:b0:3a7:8320:a6e with SMTP id e9e14a558f8ab-3a7864767f4mr42657715ab.11.1732138624083;
        Wed, 20 Nov 2024 13:37:04 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e0756b08e6sm3448117173.86.2024.11.20.13.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 13:37:03 -0800 (PST)
Message-ID: <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
Date: Wed, 20 Nov 2024 14:37:02 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>
References: <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 14:20, Kent Overstreet wrote:
> On Wed, Nov 20, 2024 at 02:12:12PM -0700, Shuah Khan wrote:
>> On 11/20/24 13:34, Kent Overstreet wrote:
>>> On Wed, Sep 04, 2024 at 12:01:50PM -0600, Shuah Khan wrote:
>>>> On 9/2/24 03:51, Kent Overstreet wrote:
>>>>> On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
>>>>>> On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
>>>>>>> On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
>>>>>>>> On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
>>>>>>>> [...]
>>>>>>>>> But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
>>>>>>>>> in the case of bugs, because that's going to be an improvement w.r.t.
>>>>>>>>> system robustness, in exactly the same way we don't use BUG_ON() if it's
>>>>>>>>> something that we can't guarantee won't happen in the wild - we WARN()
>>>>>>>>> and try to handle the error as best we can.
>>>>>>>>
>>>>>>>> We have discussed that in a different email thread. And I have to say
>>>>>>>> that I am not convinced that returning NULL makes a broken code much
>>>>>>>> better. Why? Because we can expect that broken NOFAIL users will not have a
>>>>>>>> error checking path. Even valid NOFAIL users will not have one because
>>>>>>>> they _know_ they do not have a different than retry for ever recovery
>>>>>>>> path.
>>>>>>>
>>>>>>> You mean where I asked you for a link to the discussion and rationale
>>>>>>> you claimed had happened? Still waiting on that
>>>>>>
>>>>>> I am not your assistent to be tasked and search through lore archives.
>>>>>> Find one if you need that.
>>>>>>
>>>>>> Anyway, if you read the email and even tried to understand what is
>>>>>> written there rather than immediately started shouting a response then
>>>>>> you would have noticed I have put actual arguments here. You are free to
>>>>>> disagree with them and lay down your arguments. You have decided to
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> Yeah, enough of this insanity.
>>>>>>
>>>>>> so I do not think you are able to do that. Again...
>>>>>
>>>>> Michal, if you think crashing processes is an acceptable alternative to
>>>>> error handling _you have no business writing kernel code_.
>>>>>
>>>>> You have been stridently arguing for one bad idea after another, and
>>>>> it's an insult to those of us who do give a shit about writing reliable
>>>>> software.
>>>>>
>>>>> You're arguing against basic precepts of kernel programming.
>>>>>
>>>>> Get your head examined. And get the fuck out of here with this shit.
>>>>>
>>>>
>>>> Kent,
>>>>
>>>> Using language like this is clearly unacceptable and violates the
>>>> Code of Conduct. This type of language doesn't promote respectful
>>>> and productive discussions and is detrimental to the health of the
>>>> community.
>>>>
>>>> You should be well aware that this type of language and personal
>>>> attack is a clear violation of the Linux kernel Contributor Covenant
>>>> Code of Conduct as outlined in the following:
>>>>
>>>> https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
>>>>
>>>> Refer to the Code of Conduct and refrain from violating the Code of
>>>> Conduct in the future.
>>>
>>> I believe Michal and I have more or less worked this out privately (and
>>> you guys have been copied on that as well).
>>
>> Thank you for updating us on the behind the scenes work between you
>> and Michal.
>>
>> I will make one correction to your statement, "you guys have been copied on
>> that as well" - which is inaccurate. You have shared your email exchanges
>> with Michal with us to let us know that the issue has been sorted out.
> 
> That seems to be what I just said.
> 
>> You might have your reasons and concerns about the direction of the code
>> and design that pertains to the discussion in this email thread. You might
>> have your reasons for expressing your frustration. However, those need to be
>> worked out as separate from this Code of Conduct violation.
>>
>> In the case of unacceptable behaviors as defined in the Code of Conduct
>> document, the process is to work towards restoring productive and
>> respectful discussions. It is reasonable to ask for an apology to help
>> us get to the goal as soon as possible.
>>
>> I urge you once again to apologize for using language that negatively impacts
>> productive discussions.
> 
> Shuah, I'd be happy to give you that after the discussion I suggested.
> Failing that, I urge you to stick to what we agreed to last night.

You have the right to the discussion and debate and engage the community
in the discussion. Discuss and debate away.

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

