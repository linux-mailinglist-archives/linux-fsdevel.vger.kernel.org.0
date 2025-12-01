Return-Path: <linux-fsdevel+bounces-70376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B280AC991AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 21:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F883A594B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 20:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6A279DC3;
	Mon,  1 Dec 2025 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8J+xOSm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF6269CE7
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622668; cv=none; b=SYV5TuyhLs0LJAc5FNEo+S8Bme6V0XFMNf+XAGhQPJUGG6X03TymwWvOkzDNRC5UQaNrS/OYrzCPzBJ4DFszP9Rkb/hP/k0lojPB1FRUPLnXZEmmG3QQ+GGvABRBotRwGzdnBTQIsCRNKkcJU3LCLp7KqJhM2SCD5I87Dcl/zo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622668; c=relaxed/simple;
	bh=RR8IKPDdT/N+QTKF/hycBW2eHsDa/n0AE4zi6Yb+Tzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONGOvr0YNDvjYzZMLMLlfD8VJX/qk+E1WLD/SdcQ2qmTHpSRhGrqvobn+OlGMtJzDpgZSPlmordwruIBgHY3Pe6cUWi++eY5pTRAzUVFxFcv0rjrlCSynzuULGXazz39ZuAJXl66LHFg7fhG1u44kbYxoXXEJo7mt+rJ+gj+QW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8J+xOSm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6417ffeb80bso836389a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 12:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764622665; x=1765227465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OFedbJSpL58e0RTrVWPjou9i/940/3k3Vgwi2rinVU=;
        b=P8J+xOSmsQdumxApbL/bi2Qu1F/vxTcj3lRR7o8M0c0Inb38izVfhYG1TpJ96rPyl9
         z3M3HJC66bJvuSqbts4Fz9gW0JJCPopWlJET0LS8LFO3seG3VrAfKE6nogctfx+9UsI/
         ibKVSy6nfjPDS5yZQUXyuyFn/lCWcwoM41Qs6xetG4SJ+zPZGXq813HfJeqIZZnYkVIy
         gV0yDVk0Pwr2xMw3wDkXQpDx9dNMydCPvD1JCgOA/De9X0aBbMa3F1gZBdhwUOIa++oH
         nsnyENCCwnhtBZhCH/MZjY01d4S8yQtf6KVbeh+UJV+SDXy5tTsM8rSjaiEpiyjN1HS1
         cOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622665; x=1765227465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OFedbJSpL58e0RTrVWPjou9i/940/3k3Vgwi2rinVU=;
        b=FDYOQ61f75UFR+tMVlJzL+0vDupfhjC+1XITOjVL8YphVir3MAGlIUI79jRsL6VNlJ
         Ey6jx+VMMaRk/F5nkVF+p2CXI6Pwj0SMDP40wuwETAfdabHNujmECoH5NBlMPjh77Bpy
         fyuZ51TF89KHM+aTkmMuy4JcBRhmEXPkzU1A1EfcTGUcfyhyZHe/HP/n0T5HFW3Owf1q
         9UgZdbygRY5DTuoVXzsbkfgE8G/O6m+9qMMv4Y5UCoFYKDz8rqAFaSUVM2ufWNxNopbN
         VVIwvLdsT4u/flRfK918TKHMR2jIEcUVrjHrp9RIQAFMna0HCJiYWe04FmJ27mxNeSSo
         mL3w==
X-Forwarded-Encrypted: i=1; AJvYcCVXlgWbQzRzbQTyGogZ30BhNUo0YVDzLJTS8iNwlAdIGQG/GD5fWWEdTLzxMrw+jvtHd6FDVGBGRQCO9F3f@vger.kernel.org
X-Gm-Message-State: AOJu0YxGV1MWiQZT3tQs/0Fk69ob8hDn7hC/vcRAoBWeeYzMZq/zFHmR
	H8Q0lChuajvSyCp7/4BtJcPKR6csI7ht7teapHLQcHxImE4Iq/p4q+49
X-Gm-Gg: ASbGnct+R1ctPqBA624UFMIfJBP1PtVjG50/6yI1RP0yAwVSmwfBG8D9CDekf0d0f7o
	5HNKNfjiePms34izbM1/cjGGTkwjcPNeOuxYo7pn/N2i3rMDfxVh8e63FhBJjXS/3O1SYj/KkMY
	Der96ATvk0nW7ixgbXJBiuNkM+lT3zs9ubaZ87gnuXA4pstGh3KUGPNsPsbZAMdLfERAr7H2NYv
	HKA2tFoBjCIc9HLgjSptw8a4nJ6jEiAC+JgqLuC8fUZTLRhodR0jGFhfY5dFUPQXwUElv1IUhGJ
	fVnawsHTw7HekWgIz2QNlnmwEWmyvAq1pbOUK+1WhjgZIbVaoDtTTXcOux7tp5wpAohZgNnE3h1
	upZI27tbjtUd94hYgmugQVdYaRUSYFLBUjpm0Sv8xc9lg2yNOuTha8fR48JZa6JwSLsjBN53yRM
	U1PtYyNqwtX8Mt3aI9+sMD/rzkD6bxOw==
X-Google-Smtp-Source: AGHT+IGzeYN3NmcKEOIwCNxKJBu/knwzVFsKXz8xRU7G/BscC8ZK2mSahsI4czsqVHvOg1OjJoOqQg==
X-Received: by 2002:a05:6402:278a:b0:640:abd5:864f with SMTP id 4fb4d7f45d1cf-64559ffd9ebmr20972093a12.4.1764622665132;
        Mon, 01 Dec 2025 12:57:45 -0800 (PST)
Received: from [192.168.1.105] ([165.50.39.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51c8577sm1287946466b.30.2025.12.01.12.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 12:57:44 -0800 (PST)
Message-ID: <830d05e6-9117-424f-9a94-25c358d087c7@gmail.com>
Date: Mon, 1 Dec 2025 22:57:41 +0100
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
 "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
 <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
 <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
 <4bb136bae5c04bc07e75ddf108ada7e7480afacc.camel@ibm.com>
 <59b833d7-4a97-4703-86ef-c163d70b3836@gmail.com>
 <9061911554697106be2703189f02e5765f3df229.camel@ibm.com>
 <2795a339-dc82-4a1e-8c97-87dd131a631f@gmail.com>
 <707dd64fa75fbc922cf921be46e7cf023d8bac59.camel@ibm.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <707dd64fa75fbc922cf921be46e7cf023d8bac59.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 9:37 PM, Viacheslav Dubeyko wrote:
> On Mon, 2025-12-01 at 22:19 +0100, Mehdi Ben Hadj Khelifa wrote:
>> On 12/1/25 8:24 PM, Viacheslav Dubeyko wrote:
>>> On Sat, 2025-11-29 at 13:48 +0100, Mehdi Ben Hadj Khelifa wrote:
>>>> On 11/27/25 9:19 PM, Viacheslav Dubeyko wrote:
>>>>>
>>>
>>> <skipped>
>>>
>>>>>
>>>>> As far as I can see, the situation is improving with the patches. I can say that
>>>>> patches have been tested and I am ready to pick up the patches into HFS/HFS+
>>>>> tree.
>>>>>
>>>>> Mehdi, should I expect the formal patches from you? Or should I take the patches
>>>>> as it is?
>>>>>
>>>>
>>>> I can send them from my part. Should I add signed-off-by tag at the end
>>>> appended to them?
>>>>
>>>
>>> If you are OK with the current commit message, then I can simply add your
>>> signed-off-by tag on my side. If you would like to polish the commit message
>>> somehow, then I can wait the patches from you. So, what is your decision?
>>>
>> I would like to send patches from my part as a v3. Mainly so that it's
>> more clear in the mailing list what has happened and maybe add a cover
>> letter to suggest that other filesystems could be affected too. If that
>> is not preferred, It's okay if you just add my signed-off-by tag. Commit
>> message for me seems descriptive enough as it is.
>>
> 
> OK. Sounds good.
> 
>> Also I wanted to ask 2 questions here:
>>
>> 1. Is adding the cc for stable here recommended so that this fix get
>> backported into older stable kernel?
>>
> 
> I think it's good to have it.
> 
Okay I will add it to both patches

>> 2. Is it normal to have the Reported-by and Fixes tag for the hfsplus
>> patch even though the reported bug is for HFS? I guess it's under the
>> same of the discovered HFS bug so it references that?
> 
> So, we haven't syzbot report for the case of HFS+. However, you can consider me
> as reporter of the potential issue for HFS+ case. And I assume that Fixes tag
> should be different for the case of HFS+. Potentially, we could miss the Fixes
> tag for the case of HFS+ if you don't know what should be used as Fixes tag
> here.
> 
I will make sure to adjust the patches's descriptions as you have 
suggested and I will be sending them tonight or early next morning.
> Thanks,
> Slava.
> 
Best Regards,
Mehdi Ben Hadj Khelifa

>>>


