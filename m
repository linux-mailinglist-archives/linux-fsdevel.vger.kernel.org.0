Return-Path: <linux-fsdevel+bounces-59015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA6B33EF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2843B6138
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AEB2ED87C;
	Mon, 25 Aug 2025 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QOEKwkyi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DDA2EBDFD
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123704; cv=none; b=LuYPAXot7s9AywtQP2uP4N4xkc07wus1XEm1n9reWeLjtRhi5deoj2GWZYjGC4wXWeb1WqdsxiKN+5TTawJ7dPjizAwpNAQ48kEHFw6e0gp2PHz7VpPAT66Lof3HCNQsMcq+fMAtC9GGT6X7X8RUSu1796n5kelyAsFZSJ08JkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123704; c=relaxed/simple;
	bh=oqdMoulvP9e05vx9QhuzvhSgTlS+Q/yL2qsM123y7iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpCNGoAMFRtvHSL7msQ9nFi58gvguxP1UBSchg0frzcZfrSSPcQCDzOHOF+4ROeE8Y2ZceD+rsTD4n7nYVzh8WuWU0JziMODYj7p7UhLhXsQKHM7ZCdA27viX+wOwxcyItKNBMCaXuQeE3HgOI1MaN+/nfuLorjeen5MDz/w8tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QOEKwkyi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3699825b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756123702; x=1756728502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djLIMBABOQ5QMilKv8RGXgyY8Eozctcb9yd8r0Ea10E=;
        b=QOEKwkyivFaoLEnmSKCzs+hY2bN8tb+JAzdfm5m57PmUHpYK0e/MQ7gizWwLPvAgR3
         4AId3rz31efvOV2kjwumElbbn3yFwwzCJwP1aiC2uYRYIjSA9DJ75Gz6bJBtaWh9zPwC
         X5yFoi9XZ/hgRGcqr0M6vv2qnNx4ZoVpoz4+AhCTZ8AwWGKHztlVe/oIxxrYn4IBnqV8
         QW6zg+qnj+SozVL1TYSrySwGDjzGvIBigviE9gBiH6icMBu/BdxagvnZIpVMKJ8FV//6
         Lv1RWeMFnJx21bGQ2owiXj0tIUzjjfqFhBnVryJMtABq2PlBXMHWJBFd5mz9M0dPFVLJ
         +4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756123702; x=1756728502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=djLIMBABOQ5QMilKv8RGXgyY8Eozctcb9yd8r0Ea10E=;
        b=ApJcY+r3t7m5lCKvyIcNj/R3F/GBpHW9VGXZJTUgbx7fGm9N8Sv/7S9KXDQUkyJ7/h
         YACxyeLhIlaDqCNXJfvXUhffYSF5ulBsMfWigQDQEUBddMxqopnT88701HYtLUJRJoNi
         tge91f3YjOgs3ps1jcYN1Nw+3bw4TxuB81dDDAC912D7PFTADYknAX9ySSLKJA3ONGkZ
         9Wa54t5rKQzWHWFwC1g7Ct845rfCc9vL9nt+3uCAAm0ccwsr6EhlRSJqvvgjCGdFCvCJ
         YptWnhKjiGtvDy5Dvu3Zyev1IUIXyDGGAJmdMmqhQqL/j0XdteUh9EfWRzut5DbLes7q
         KcOw==
X-Forwarded-Encrypted: i=1; AJvYcCVp0dEHGiUxNx1Le5K71kOMpkpY2Q1gIUe9c6EpIVofZ91d3NN3OuQHC95FLrBvULj7aaeQi8LekV5cyjZ4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+Aq6CbPgqNmpO2C8++sQUSBWQuk/kSpjK8SIb8lMDL+EYUNS
	gNg46AC07uV2Bvn+BdiaSDpPF+WYJE+dlUhcaZg3norvGuasw53e5a7HhxQOnolKPDU=
X-Gm-Gg: ASbGnctyz7SYDRz1/vgCrAwZZElleZXEkfKbdVFUAHxlPtsS4srtEPKtUtRMUMZmr8e
	Y8NtZHMnrXdSUzR+FUDTNu8KkJtGbplGsG/90I9t/7x4hhUW0VCH1iVVx63Tg7WpnENqPXJIQd7
	HsOfL5jx/VWmrBvwVAu3CvGGn022BxzjpaoZkjNKZsYH5MvzlR/gEgavBiie0gOs/8xaLGdYlvY
	mdt29WjUeCt7xsHJeQCX9DkbWQrFrRxpWv5TE60bV32JDezM215wwxL1x1d1c8O+gmo0x4R7fXq
	4fOGy4weOEAL56kmAYy4snxW6mO+6Ft4FMPuNun3onhl8QVI6LPB5I36LpIyGERGI7w6emCHenn
	l3HVrIX55gE7oL8ryH9KmD7GwIcbob/dO+aC0QTWMuXx0P7Oql7/jaYy14L5/xawy1v0hmGU=
X-Google-Smtp-Source: AGHT+IEANcNrkMuJ1PjBmSdPjmdk9y77EAYoFZYgAnfWDeZy+q3lUhQjHBWmnTqj+0/HSjBZ/qdDeQ==
X-Received: by 2002:a05:6a20:5493:b0:240:10d2:adf5 with SMTP id adf61e73a8af0-24340b57600mr17869147637.2.1756123701840;
        Mon, 25 Aug 2025 05:08:21 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f3818abfsm6684739a91.0.2025.08.25.05.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:08:21 -0700 (PDT)
Message-ID: <6d54e933-5ff4-4711-abb9-96d39a5dd62e@bytedance.com>
Date: Mon, 25 Aug 2025 20:08:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: Don't wait writeback completion when release
 memcg.
To: Jan Kara <jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 axboe@kernel.dk
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com>
 <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <lvycz43vcro2cwjun4tswjv67tz5sg4tans3hragwils3gvnbh@hxbjk6x6v5zk>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <lvycz43vcro2cwjun4tswjv67tz5sg4tans3hragwils3gvnbh@hxbjk6x6v5zk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/8/25 18:13, Jan Kara 写道:

Hi, Jan

Thanks for your review and comments.

> On Thu 21-08-25 10:30:30, Julian Sun wrote:
>> On Thu, Aug 21, 2025 at 4:58 AM Tejun Heo <tj@kernel.org> wrote:
>>>
>>> On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
>>>> @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>>>>        int __maybe_unused i;
>>>>
>>>>   #ifdef CONFIG_CGROUP_WRITEBACK
>>>> -     for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
>>>> -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
>>>> +     for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
>>>> +             struct wb_completion *done = memcg->cgwb_frn[i].done;
>>>> +
>>>> +             if (atomic_dec_and_test(&done->cnt))
>>>> +                     kfree(done);
>>>> +     }
>>>>   #endif
>>>
>>> Can't you just remove done? I don't think it's doing anything after your
>>> changes anyway.
>>
>> Thanks for your review.
>>
>> AFAICT done is also used to track free slots in
>> mem_cgroup_track_foreign_dirty_slowpath() and
>> mem_cgroup_flush_foreign(), otherwise we have no method to know which
>> one is free and might flush more than what MEMCG_CGWB_FRN_CNT allow.
>>
>> Am I missing something?
> 
> True, but is that mechanism really needed? Given the approximate nature of
> foreign flushing, couldn't we just always replace the oldest foreign entry
> regardless of whether the writeback is running or not? I didn't give too
> deep thought to this but from a quick look this should work just fine...


AFAICT the mechanism is used to make the max number of wb works that we 
issue concurrently less than MEMCG_CGWB_FRN_CNT(4). If we replace the 
oldest and flush wb work whether the writeback is running or not, it 
seems that we are likely to flush more than MEMCG_CGWB_FRN_CNT wb works 
concurrently, I'm not sure how much influence this will have...
> 
> 								Honza

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

