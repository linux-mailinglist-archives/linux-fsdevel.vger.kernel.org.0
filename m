Return-Path: <linux-fsdevel+bounces-58877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9CEB32790
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 10:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0335E6B9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 08:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DEF23183C;
	Sat, 23 Aug 2025 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGahfWHP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30222A4FC;
	Sat, 23 Aug 2025 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755936522; cv=none; b=f8iZV3CbxNIbF1Wm45LsySGqwqauA8Xkctg8VFEmAxBTi02D7EmKID0ee7VCMYFPJH2s2zONqssLkd5JtRADVbmk+Db+dxii4bb33/AAbpYvpEW4cF878jb6FRGUfHGhHM8UoPQpYNU8T/uOAMO1Hdw37rdLZbhyLoK67rdxrkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755936522; c=relaxed/simple;
	bh=tTD11JbHTfHg6i9CjRyH2Hm1rKrlshvNqqVRx9VgPPg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=R3R1SKiO69NyIvyJIECVxrGHUT2fCNVVMHZch74W62U3Su4h/4xmTZyneM/Q9bJj+X9wwX8V8q3M6mKYBoJHjycAprts9v90+dvx+7wyfYUC2rRq52QlYLDcY++mCwizzkaEAjkSVyCnOICHcSSgcsbVgU8tn/r0PQ54JVavS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGahfWHP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c68c6a3f0bso153808f8f.0;
        Sat, 23 Aug 2025 01:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755936519; x=1756541319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5D7eeNdQSiGOasqKX/gQg+YtICOsftnZGJhgOnqSco=;
        b=iGahfWHPySfW9IXlRPArClRuzh25L6q7GEwgHj20nN5ofbGbhJ+5itCHAil6ECQupT
         a0Af/SFf7dhjME/xqW+XUkq3TvIevs4x6UK2INwRngaBaq9EnBrrbprvKFj2mJysr92h
         sENc245T1uS1eDS84JJQY7g+72ayGwN8bALQWJ8rL6PruhZCkGR5hOvzCtpZsL0xK8K5
         yNJodsx/p9aIPWrTF4iUKCTG4JNz5L5Kt6Yq0jXiHkVDoNkELfWbrWh9Sxw2BXOHuqk0
         /YyPE1ArYL3n8Op1QIUJmh/MFbCpbfBtzMlryNjF00GWwsr9IaaBx70U/Ombo+iEXYdw
         y8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755936519; x=1756541319;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5D7eeNdQSiGOasqKX/gQg+YtICOsftnZGJhgOnqSco=;
        b=NTnR7g/nmrbJd91B9/2ZMWiECVV0l4LgND0PrtMOc49oU6NT5IIWMGd8Mttfms6MBp
         Fkpty04NNw/RXuUsTEJk9rntQ1CG6u11J04kqQK4eBUXJpa+dqDhZTAUXxhcd0j7l2Cq
         vmw7PpGf2Mroj95jgXIHBAMEWNoduNNpPc6HN+uCWosn0Y3Eh1Do74MdTBOv2mFo9Vrh
         kYzzDWWmBkWIlQdrGMAFmWP8woys5NvXqhRYCjIk8IJK0RbRjW0a6VRMyEtudt8jsg9w
         hMjV6ruGFH6PsUtTvhSSrDU0gOnLYQM1WwZtBKLFHTpU/DFOiqYGxbsZmGJq94EVQi2m
         +O/g==
X-Forwarded-Encrypted: i=1; AJvYcCWB6bRHE6PW76FBdZgVPyxRcLzskCgfBJBDWOTMjh6tLscXnPvXTQI7qtahT7Gio/TdlMUmevpa+xdOu40TbA==@vger.kernel.org, AJvYcCWZo+HT+IiDOzijr1zdXxamVzqxAKj/eqRbHFqKUKJP0S+6a5WiApjYHqoQMTUaEvWyZaEUscsk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9lsCzjQOgwlencw4bgN0vR8a4d08aFXOTlaJ1wNwWdr1Gg/qQ
	wW/EA+S55ahwOVt3kfbhqiZKgY1k0H/Y8LJI0nKHGeBVoyZ3eRnbsyBW
X-Gm-Gg: ASbGnctnqHFQdh4ppESrYf9FSXNb/kShzS5JUX6aIFEB+Z0YaklJo+CZEVMb9L3z5m9
	ZKtVOqJ9tPymoJzAURbii1Lpaa5J7gZWhEDcoG3PSQprfGPDKDGWlsg0iqzZKSTwM6WafdMjpNO
	2EnJFYoEClCMEhmd/uW9DCvFYQ01fUBWZwMG9w6D6/VmkrYnrpJcGYdH7oBI+w4dkLWkf8ZMJM8
	dOnVIhK4zOw//HJNY97jtWlqwX5QUh860x6H9ll6uqmpHuDQ+UaccfWg8wwEMrAxXc1wvTHhoQi
	ccpcSLObG7Yx/WXsAGwzI4t2whWObP13quHZpbNiY9mKgz7iakxacpw5no66gmeEHGYNnMcV7yb
	oshI1WB6iy0YpMdsE1qA3YDi8+HWYdNeSlX4LO+kibvnF8AeKhOWT
X-Google-Smtp-Source: AGHT+IEv8VRJb23jt4k+0hi/sSmMwmxJXBH4vxmaxMRWzlSs87Du3ko2O/AtvHKpOGNtNV9nguhH2Q==
X-Received: by 2002:a05:600c:45c6:b0:456:2137:5662 with SMTP id 5b1f17b1804b1-45b517df7c3mr25336325e9.7.1755936518408;
        Sat, 23 Aug 2025 01:08:38 -0700 (PDT)
Received: from [192.168.100.6] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5977sm2616715f8f.51.2025.08.23.01.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 01:08:38 -0700 (PDT)
Message-ID: <76a95839-00b1-43b8-af78-af4da8a2941c@gmail.com>
Date: Sat, 23 Aug 2025 12:08:33 +0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sunjunchao@bytedance.com
Cc: axboe@kernel.dk, brauner@kernel.org, cgroups@vger.kernel.org,
 hannes@cmpxchg.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, tj@kernel.org,
 viro@zeniv.linux.org.uk
References: <CAHSKhtebXWE5m0RcesWe_w2z1Gpqt1n5X0wuE9oD1tX6VxztUg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <CAHSKhtebXWE5m0RcesWe_w2z1Gpqt1n5X0wuE9oD1tX6VxztUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi there. Can we fix this by allowing callers to set work->done = NULL 
when no completion is desired?
The already-existing "if (done)" check in finish_writeback_work() 
already provides the necessary protection, so the change is purely 
mechanical.



On 8/23/2025 10:18 AM, Julian Sun wrote:
> Hi,
> 
> On Sat, Aug 23, 2025 at 1:56 AM Tejun Heo <tj@kernel.org> wrote:
>> > Hello, > > On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun 
> wrote: > > +struct wb_wait_queue_head { > > + wait_queue_head_t waitq; > 
>  > + wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > > wait_queue_head_t 
> itself already allows overriding the wakeup function. > Please look for 
> init_wait_func() usages in the tree. Hopefully, that should > contain 
> the changes within memcg.
> Well... Yes, I checked this function before, but it can't do the same
> thing as in the previous email. There are some differences—please
> check the code in the last email.
> 
> First, let's clarify: the key point here is that if we want to remove
> wb_wait_for_completion() and avoid self-freeing, we must not access
> "done" in finish_writeback_work(), otherwise it will cause a UAF.
> However, init_wait_func() can't achieve this. Of course, I also admit
> that the method in the previous email seems a bit odd.
> 
> To summarize again, the root causes of the problem here are:
> 1. When memcg is released, it calls wb_wait_for_completion() to
> prevent UAF, which is completely unnecessary—cgwb_frn only needs to
> issue wb work and no need to wait writeback finished.
> 2. The current finish_writeback_work() will definitely dereference
> "done", which may lead to UAF.
> 
> Essentially, cgwb_frn introduces a new scenario where no wake-up is
> needed. Therefore, we just need to make finish_writeback_work() not
> dereference "done" and not wake up the waiting thread. However, this
> cannot keep the modifications within memcg...
> 
> Please correct me if my understanding is incorrect.
>> > Thanks. > > -- > tejun
> 
> Thanks,
> -- 
> Julian Sun <sunjunchao@bytedance.com>
> 


> Hi,
> 
> On Sat, Aug 23, 2025 at 1:56 AM Tejun Heo <tj@kernel.org> wrote:
>> > Hello, > > On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun 
> wrote: > > +struct wb_wait_queue_head { > > + wait_queue_head_t waitq; > 
>  > + wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > > wait_queue_head_t 
> itself already allows overriding the wakeup function. > Please look for 
> init_wait_func() usages in the tree. Hopefully, that should > contain 
> the changes within memcg.
> Well... Yes, I checked this function before, but it can't do the same
> thing as in the previous email. There are some differences—please
> check the code in the last email.
> 
> First, let's clarify: the key point here is that if we want to remove
> wb_wait_for_completion() and avoid self-freeing, we must not access
> "done" in finish_writeback_work(), otherwise it will cause a UAF.
> However, init_wait_func() can't achieve this. Of course, I also admit
> that the method in the previous email seems a bit odd.
> 
> To summarize again, the root causes of the problem here are:
> 1. When memcg is released, it calls wb_wait_for_completion() to
> prevent UAF, which is completely unnecessary—cgwb_frn only needs to
> issue wb work and no need to wait writeback finished.
> 2. The current finish_writeback_work() will definitely dereference
> "done", which may lead to UAF.
> 
> Essentially, cgwb_frn introduces a new scenario where no wake-up is
> needed. Therefore, we just need to make finish_writeback_work() not
> dereference "done" and not wake up the waiting thread. However, this
> cannot keep the modifications within memcg...
> 
> Please correct me if my understanding is incorrect.
>> > Thanks. > > -- > tejun
> 
> Thanks,
> -- 
> Julian Sun <sunjunchao@bytedance.com>
> 



