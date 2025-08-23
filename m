Return-Path: <linux-fsdevel+bounces-58884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B816B32900
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 16:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF1C7B6D20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94DD2566E2;
	Sat, 23 Aug 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHhMGH3K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0161953BB;
	Sat, 23 Aug 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958143; cv=none; b=cIElWwZxjxqg+fscMvIPZoxRn4URQT/kcae9ukORubkDwnkNENzmI/6WeRDQXG7LrFzBy+yJR4KUYboK0igySXLVD7NtZNHgKxQcG/+DXL22ZwRs6I6OdQteAJOtSDek1VaLvnLrokUnbkXbcMSKDfoSTSFJKS5B9HcwndREh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958143; c=relaxed/simple;
	bh=V0QZSuF9P8ZljFjhnFqcBqt2KiRHL9HZwOxndNGuOck=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uHS4Hzy8IT3ii3TuKWYOttFPx/Sm13CU6hjWgkzNNGrk9YnZcpaZo6f4e3VqsxG6msflvVUJjZFuH93v56jS8ouiyHVjzW3Dwrc5MtcL91jbEZCYZ7meurQd6z1rBHbRq8wjw1cyX6L2ne+MGcmlcNGrjAWRy+DluSSQScpcSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHhMGH3K; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b05a59dso3082015e9.1;
        Sat, 23 Aug 2025 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755958139; x=1756562939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6N4AN/Y/D7dp0HndfnRPdy0zt4T/cxocCywAgoacTDU=;
        b=jHhMGH3KomOHtELNtEkZWbEKAxINAWb/48Pq4/BFXb03xRdKz+E1w2qxS8Sxq/P/e0
         /xmsONSVNAoTNi2LPdyhz6AEzqlv31ehx+jOMWFy/pIoOS+a0s/kbgylEKXTPPy+paPS
         Ywm7TbAKQZkx0vn3mUkWxeoougina247Ngbxgz0rf6IAld6t52Cts02za1TlFOQoFGyO
         jX9X1YfmZBmfTbg8IAmiamgPpIcYZ53cRMXWhTC4+8+rBF1OG1eFgEdAgcfvGXsTScGV
         7dcjfPgol2cRcfgUNkRse4xIWmIJmcvEDHZ9Y5gJQplO+pcEun7VAsp9+jJPcBDVzEKe
         Q01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755958139; x=1756562939;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6N4AN/Y/D7dp0HndfnRPdy0zt4T/cxocCywAgoacTDU=;
        b=Zp6q4CHjARljxGn7S/CrjG8KhQGrwM0Y1dCmLsTuKlZ9ESgpXQuYC8QKeQjpPRG1VD
         seSAVdb8RWwvPV6nQ7wZF54SNuXmoy7vkle8ajREao+vczc2uaebpctDhwIozlMJmizE
         CJhM578GBa2sa6CynbPituuPxNHKchDDalSKteIr0wzg58DADMLPYf/tyXfK+XrLKJYN
         1w0h4Z0vqOihebKuqGwoO0Du9amgUaUp2RrxGSn/F4GC14ozIhETNz901bFGjTIfjcjS
         FbUru77Id+6mwRHUoUJSREjj00zWuG8x2rOiknpUibHyTLPgODmaAwmYtW+iSGdS/FJA
         6EBw==
X-Forwarded-Encrypted: i=1; AJvYcCUgk49ws8tUU3hxpiJLE5u4xITRnOG/9lv/XQDihvPYR3qhxrd71I5b/S6dro7AmJ5lm3u3D1WAgmuJHLX+Tw==@vger.kernel.org, AJvYcCWxwEqEKvhg8psSWUITVaB5xp9fMxjdpgOxi+Ecp2fstMFrfiDED2YNkAYvv24ILNtjBiqVkLC2@vger.kernel.org
X-Gm-Message-State: AOJu0YwXgNBWQzBeTz5SYGQr2wpL7ASmPTbLqVHZ3ysUAdK/yOMXZXIk
	isbk8Sx2CDsDuKWk+pGf4jzcWInsqYwlsG8G+1GaF7eVUloE9Cbe/HIN
X-Gm-Gg: ASbGncsW/9OAxZoRsTDZu/6MlH6935Pr+fe1WVrBwacKcDodxNHsJasLe/MaasYKJYd
	o3RAHPlGKKYRl8djDVzhzhQe8XuCjPopqPoirSJflj+46iAhC4v8DAi+KlriNQQ7lX1JXc4d1qA
	WGZVxNa2cykjlQ+Rm6fXywJ8sFJKRNSmfAKbAaGhKcyyIpkMDpqeEqfFbDxmkvc+xa18B56yAWf
	kdWEr3KFhzbKoWOc2JpLxuv/aabWZ0XdnNTsLbvaILoM2oVzlKLB1ONWkcHhmeOeTGE8nxbBDol
	BnINxzNwWPqwohZXpTsqNhu1GdLA18X56krtue6mN0HcQdlwI9N+ZsrJ6le16q6J98+JrnBJbjB
	8UPmGZLu/iRWadAShZb7pr9n/0+DWwiFnHXhcmJvr+4SfIzAcEXHm
X-Google-Smtp-Source: AGHT+IGWtS/Lb299m9NjusG8Fgziqg/tOUQirr+93j1uqVHL7+y5z/IekZWvnr7oe5w+c2JneXBqFw==
X-Received: by 2002:a05:600c:1ca4:b0:458:b6b9:6df5 with SMTP id 5b1f17b1804b1-45b552ead7emr22894025e9.1.1755958139123;
        Sat, 23 Aug 2025 07:08:59 -0700 (PDT)
Received: from [192.168.100.6] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753503esm36496645e9.1.2025.08.23.07.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 07:08:58 -0700 (PDT)
Message-ID: <a3f9e0fd-28fd-41ea-9c78-e3c971e7445c@gmail.com>
Date: Sat, 23 Aug 2025 18:08:56 +0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sunjunchao@bytedance.com
Cc: axboe@kernel.dk, brauner@kernel.org, cgroups@vger.kernel.org,
 giorgitchankvetadze1997@gmail.com, hannes@cmpxchg.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 tj@kernel.org, viro@zeniv.linux.org.uk
References: <CAHSKhtd_oM8yXBwgm1-6FGhDEaDGCWunohMnb4AtV8Y-__z-zg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <CAHSKhtd_oM8yXBwgm1-6FGhDEaDGCWunohMnb4AtV8Y-__z-zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Makes sense, yeah. What about using a shared, long-lived completion 
object (done_acc) inside cgwb_frn. All writeback jobs point to this same 
object via work->done = &frn->done_acc.

On 8/23/2025 12:23 PM, Julian Sun wrote:
> Hi,
> 
> On Sat, Aug 23, 2025 at 4:08 PM Giorgi Tchankvetadze
> <giorgitchankvetadze1997@gmail.com> wrote:
>> > Hi there. Can we fix this by allowing callers to set work->done = 
> NULL > when no completion is desired?
> No, we can't do that. Because cgwb_frn needs to track the state of wb
> work by work->done.cnt, if we set work->done = Null, then we can not
> know whether the wb work finished or not. See
> mem_cgroup_track_foreign_dirty_slowpath() and
> mem_cgroup_flush_foreign() for details.
> 
>> The already-existing "if (done)" check in finish_writeback_work() > already provides the necessary protection, so the change is purely > 
> mechanical. > > > > On 8/23/2025 10:18 AM, Julian Sun wrote: > > Hi, > > 
>  > > On Sat, Aug 23, 2025 at 1:56 AM Tejun Heo <tj@kernel.org> wrote: > 
>  >> > Hello, > > On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun > 
>  > wrote: > > +struct wb_wait_queue_head { > > + wait_queue_head_t 
> waitq; > > > > + wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > > 
> wait_queue_head_t > > itself already allows overriding the wakeup 
> function. > Please look for > > init_wait_func() usages in the tree. 
> Hopefully, that should > contain > > the changes within memcg. > > 
> Well... Yes, I checked this function before, but it can't do the same > 
>  > thing as in the previous email. There are some differences—please > > 
> check the code in the last email. > > > > First, let's clarify: the key 
> point here is that if we want to remove > > wb_wait_for_completion() and 
> avoid self-freeing, we must not access > > "done" in 
> finish_writeback_work(), otherwise it will cause a UAF. > > However, 
> init_wait_func() can't achieve this. Of course, I also admit > > that 
> the method in the previous email seems a bit odd. > > > > To summarize 
> again, the root causes of the problem here are: > > 1. When memcg is 
> released, it calls wb_wait_for_completion() to > > prevent UAF, which is 
> completely unnecessary—cgwb_frn only needs to > > issue wb work and no 
> need to wait writeback finished. > > 2. The current 
> finish_writeback_work() will definitely dereference > > "done", which 
> may lead to UAF. > > > > Essentially, cgwb_frn introduces a new scenario 
> where no wake-up is > > needed. Therefore, we just need to make 
> finish_writeback_work() not > > dereference "done" and not wake up the 
> waiting thread. However, this > > cannot keep the modifications within 
> memcg... > > > > Please correct me if my understanding is incorrect. > 
>  >> > Thanks. > > -- > tejun > > > > Thanks, > > -- > > Julian Sun 
> <sunjunchao@bytedance.com> > > > > > > Hi, > > > > On Sat, Aug 23, 2025 
> at 1:56 AM Tejun Heo <tj@kernel.org> wrote: > >> > Hello, > > On Fri, 
> Aug 22, 2025 at 04:22:09PM +0800, Julian Sun > > wrote: > > +struct 
> wb_wait_queue_head { > > + wait_queue_head_t waitq; > > > > + 
> wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > > wait_queue_head_t > > 
> itself already allows overriding the wakeup function. > Please look for 
>  > > init_wait_func() usages in the tree. Hopefully, that should > 
> contain > > the changes within memcg. > > Well... Yes, I checked this 
> function before, but it can't do the same > > thing as in the previous 
> email. There are some differences—please > > check the code in the last 
> email. > > > > First, let's clarify: the key point here is that if we 
> want to remove > > wb_wait_for_completion() and avoid self-freeing, we 
> must not access > > "done" in finish_writeback_work(), otherwise it will 
> cause a UAF. > > However, init_wait_func() can't achieve this. Of 
> course, I also admit > > that the method in the previous email seems a 
> bit odd. > > > > To summarize again, the root causes of the problem here 
> are: > > 1. When memcg is released, it calls wb_wait_for_completion() to 
>  > > prevent UAF, which is completely unnecessary—cgwb_frn only needs to 
>  > > issue wb work and no need to wait writeback finished. > > 2. The 
> current finish_writeback_work() will definitely dereference > > "done", 
> which may lead to UAF. > > > > Essentially, cgwb_frn introduces a new 
> scenario where no wake-up is > > needed. Therefore, we just need to make 
> finish_writeback_work() not > > dereference "done" and not wake up the 
> waiting thread. However, this > > cannot keep the modifications within 
> memcg... > > > > Please correct me if my understanding is incorrect. > 
>  >> > Thanks. > > -- > tejun > > > > Thanks, > > -- > > Julian Sun 
> <sunjunchao@bytedance.com> > > > >
> Thanks,
> -- 
> Julian Sun <sunjunchao@bytedance.com>
> 


