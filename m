Return-Path: <linux-fsdevel+bounces-38168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF29FD703
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 19:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C970B7A20FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 18:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF91F8AD2;
	Fri, 27 Dec 2024 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b="Tf6MACRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE641F869A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735324759; cv=none; b=jMg2KolrBi0pVbuDKlE5RKrMPyH49Hh+ymt/+VFVT37jT3hPuRj9PbykaIEk1WI3qNogGHCd5xrwmI6VBRUepVXRE5Ou0cD2nmmWxNv5WygWfiYYPwn46XOJmW/y073n7gJdkpx9zMdTKfcV0Pb4OYENj7DBpmAywkevYtLJoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735324759; c=relaxed/simple;
	bh=AAOOqgKUifCh8wKBJnpxycIwdVuSmvZhiWOzsN4i72I=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=pdRzz4eNggbCwTrNwIAzSTc2A67oVZtdA9ZC4C7cMIxPv8ch8cN/f4gV7+Y7zKFeiFcRvykhgLepSV8dmyw6QjmzffDr5dv/l54dvw+RRAEynz6aD+yFFvx5Wg8fPjBAm2b0A70JmJLzHpsNZ6hAu5OtGc6lDp4FKpR8vCYxoI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com; spf=pass smtp.mailfrom=colorfullife.com; dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b=Tf6MACRt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorfullife.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so6601620a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 10:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20230601.gappssmtp.com; s=20230601; t=1735324754; x=1735929554; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGKKrHnmj7bXfY6CNkPl3lP9RlKbMnPdw0Vb1t1L4Ao=;
        b=Tf6MACRtbYTuhP1foJMd+8YVIwN2bsRn03XheJ6sV3/0Bn90IS1cYSSGBrCvCFeqiC
         oytTZKu7qWoGjrRNBupFgIffIOMQSdXdZ67/SHI22RdRBMOYQkclVG7vce/jFGP3C7MK
         j3tzcKMRY3hiP67KukaUMO/iLaF5eetxUEsM/1zapkqalO3AyWpETqRJYyZKW4w+zo9m
         spP4dsHX1Rsp73wUMhqAjqMuNZ1HOe0RuGp869kZPpy9aObQtvooQd2sKJffW8z6GOgU
         xJuIM9n5bC+iZZ71t8ZQzd6elv0LUmtEMq9sG90db/AXkzu3JXakx+5CaTs3TRGXBg1Y
         yNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735324754; x=1735929554;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pGKKrHnmj7bXfY6CNkPl3lP9RlKbMnPdw0Vb1t1L4Ao=;
        b=gmsQ0dzZfh5hKS9hw1YFlyTJ0inzskeCqN6IA6ZMJdleMUtCMCuwopqF/VnvqIchlL
         TTVoxsBj0UEkNX+ixfP3PFzGrI6bn627Juycmks2MCpeMZRVS9ck+auyflNps23kQLKc
         O44eIm+4joOaIyertIf4U8VQypUCgKffmaC+HcCt1SmPjjJS8+8iId1DMvF8UGerPk/Z
         CcUzr5vf2Ya0QiBO3Q8eDZD/D5QIzEKpfHyfkmYzsv1zDeaNJydZnzC6nz+V6u6zya+J
         bB81a7LZL2UN8A10Iv3P2On3D5b29qkBzM7zx34ZAp7Fw8Ws5NdCnbOUwEMURsjvNFg1
         2hLg==
X-Forwarded-Encrypted: i=1; AJvYcCUeXaNQy53ksSCol4v4N0wLoStD/GbJuxuRmtuAIjn45LRnWtsRRYLnyvMFOyivNZPLE9u1xw3tnfqVt1u9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NSLzgwidGcl5/rWpbViBNyaKGj3Co2AywPVnDkTYqFI+wdnm
	7kL/POnJVGGWM4d0cW0Yb71hiTuCDLVQihgV9N84qZpBUgr0zqWrekH7MZjjAg==
X-Gm-Gg: ASbGnct5wX/i4zvNFtr3KcRN0A2EY9CpWMkuwi9uuiW751gDMfH+O05SyW+NajCRs3k
	b6ZRdKHz094w9hEE2i7z6CI4UXco8jltHELFPDcClzj4m3EH7hGxRl+LUfV7nTuZolzl8U8g/MU
	Ne/0MvBrcEkeVulFFNcuqn4wQeHdO1gxIukwNBmNKPgmcilBzq3lRE05gda6DkcV6EH4QzoQAig
	aylM2tg5nQ4Ck9eLXM9e6fa5yrz/M+ons/2zD1cMh32ipxKPwWFn3wb1LFarCMz5voxbUOqMiw/
	+PAPjrpnl/LIGdhswEyGAyykusX7q8U1FsvWe3i0FxKQfsL0oLhvMStfa4xl1wvZBiiz+anoVJL
	xLZkrdr/0b2/3KgjwbgU=
X-Google-Smtp-Source: AGHT+IGyX30uylQ7Lp173xYrAkBVWCh1ayiu28QyGEoUIErdtNdG0cTwfWOeI0uTvF3QasRnPY4l+w==
X-Received: by 2002:a05:6402:4405:b0:5d8:16ea:cfb4 with SMTP id 4fb4d7f45d1cf-5d81dd7d02cmr26130197a12.8.1735324752643;
        Fri, 27 Dec 2024 10:39:12 -0800 (PST)
Received: from ?IPV6:2003:d9:9746:3700:7102:4533:6be1:ffef? (p200300d997463700710245336be1ffef.dip0.t-ipconnect.de. [2003:d9:9746:3700:7102:4533:6be1:ffef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm11056568a12.88.2024.12.27.10.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 10:39:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------QFF0zz3sc1ADSPJlE0hpJV6N"
Message-ID: <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
Date: Fri, 27 Dec 2024 19:39:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: Oleg Nesterov <oleg@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 oliver.sang@intel.com, ebiederm@xmission.com, colin.king@canonical.com,
 josh@joshtriplett.org, penberg@cs.helsinki.fi, mingo@elte.hu, jes@sgi.com,
 hch@lst.de, aia21@cantab.net, arjan@infradead.org, jgarzik@pobox.com,
 neukum@fachschaft.cup.uni-muenchen.de, oliver@neukum.name,
 dada1@cosmosbay.com, axboe@kernel.dk, axboe@suse.de,
 nickpiggin@yahoo.com.au, dhowells@redhat.com, nathans@sgi.com,
 rolandd@cisco.com, tytso@mit.edu, bunk@stusta.de, pbadari@us.ibm.com,
 ak@linux.intel.com, ak@suse.de, davem@davemloft.net, jsipek@cs.sunysb.edu,
 jens.axboe@oracle.com, ramsdell@mitre.org, hch@infradead.org,
 akpm@linux-foundation.org, randy.dunlap@oracle.com, efault@gmx.de,
 rdunlap@infradead.org, haveblue@us.ibm.com, drepper@redhat.com,
 dm.n9107@gmail.com, jblunck@suse.de, davidel@xmailserver.org,
 mtk.manpages@googlemail.com, linux-arch@vger.kernel.org,
 vda.linux@googlemail.com, jmorris@namei.org, serue@us.ibm.com,
 hca@linux.ibm.com, rth@twiddle.net, lethal@linux-sh.org,
 tony.luck@intel.com, heiko.carstens@de.ibm.com, andi@firstfloor.org,
 corbet@lwn.net, crquan@gmail.com, mszeredi@suse.cz, miklos@szeredi.hu,
 peterz@infradead.org, a.p.zijlstra@chello.nl, earl_chew@agilent.com,
 npiggin@gmail.com, npiggin@suse.de, julia@diku.dk, jaxboe@fusionio.com,
 nikai@nikai.net, dchinner@redhat.com, davej@redhat.com, npiggin@kernel.dk,
 eric.dumazet@gmail.com, tim.c.chen@linux.intel.com, xemul@parallels.com,
 tj@kernel.org, serge.hallyn@canonical.com, gorcunov@openvz.org,
 bcrl@kvack.org, alan@lxorguk.ukuu.org.uk, will.deacon@arm.com,
 will@kernel.org, zab@redhat.com, balbi@ti.com, gregkh@linuxfoundation.org,
 rusty@rustcorp.com.au, socketpair@gmail.com,
 penguin-kernel@i-love.sakura.ne.jp, mhocko@kernel.org, axboe@fb.com,
 tglx@linutronix.de, mcgrof@kernel.org, linux@dominikbrodowski.net,
 willy@infradead.org, paulmck@kernel.org, kernel@tuxforce.de,
 linux-morello@op-lists.linaro.org
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
Content-Language: en-US
In-Reply-To: <20241226201158.GB11118@redhat.com>

This is a multi-part message in MIME format.
--------------QFF0zz3sc1ADSPJlE0hpJV6N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,
(I had to remove many cc, my mail server rejected to send)

On 12/26/24 9:11 PM, Oleg Nesterov wrote:
> I mostly agree, see my reply to this patch, but...
>
> On 12/26, Linus Torvalds wrote:
>> If the optimization is correct, there is no point to having a config option.
>>
>> If the optimization is incorrect, there is no point to having the code.
>>
>> Either way, there's no way we'd ever have a config option for this.
> Agreed,
>
>>> +       if (was_full && pipe_check_wq_has_sleeper(&pipe->wr_wait))
>>>                  wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
>> End result: you need to explain why the race cannot exist.
> Agreed,
>
>> And I think your patch is simply buggy
> Agreed again, but probably my reasoning was wrong,
>
>> But now waiters use "wait_event_interruptible_exclusive()" explicitly
>> outside the pipe mutex, so the waiters and wakers aren't actually
>> serialized.
> This is what I don't understand... Could you spell ?
> I _think_ that
>
> 	wait_event_whatever(WQ, CONDITION);
> vs
>
> 	CONDITION = 1;
> 	if (wq_has_sleeper(WQ))
> 		wake_up_xxx(WQ, ...);
> 	
> is fine.

This pattern is documented in wait.h:

https://elixir.bootlin.com/linux/v6.12.6/source/include/linux/wait.h#L96

Thus if there an issue, then the documentation should be updated.

> Both wq_has_sleeper() and wait_event_whatever()->prepare_to_wait_event()
> have the necessary barriers to serialize the waiters and wakers.
>
> Damn I am sure I missed something ;)

Actually:

Does this work universally? I.e. can we add the optimization into 
__wake_up()?


But I do not understand this comment (from 2.6.0)

https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/kernel/fork.c?h=v2.6.0&id=e220fdf7a39b54a758f4102bdd9d0d5706aa32a7

> /* * Note: we use "set_current_state()" _after_ the wait-queue add, * 
> because we need a memory barrier there on SMP, so that any * 
> wake-function that tests for the wait-queue being active * will be 
> guaranteed to see waitqueue addition _or_ subsequent * tests in this 
> thread will see the wakeup having taken place. * * The spin_unlock() 
> itself is semi-permeable and only protects * one way (it only protects 
> stuff inside the critical region and * stops them from bleeding out - 
> it would still allow subsequent * loads to move into the the critical 
> region). */ voidprepare_to_wait 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/prepare_to_wait>(wait_queue_head_t 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/wait_queue_head_t>*q,wait_queue_t 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/wait_queue_t>*wait 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/wait>,intstate) { 
> unsignedlongflags; wait 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/wait>->flags&=~WQ_FLAG_EXCLUSIVE 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/WQ_FLAG_EXCLUSIVE>; 
> spin_lock_irqsave 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/spin_lock_irqsave>(&q->lock,flags); 
> if(list_empty 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/list_empty>(&wait 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/wait>->task_list 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/task_list>)) 
> __add_wait_queue 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/__add_wait_queue>(q,wait 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/wait>); 
> set_current_state 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/set_current_state>(state); 
> spin_unlock_irqrestore 
> <https://elixir.bootlin.com/linux/v2.6.0/C/ident/spin_unlock_irqrestore>(&q->lock,flags); 
> }
set_current_state() now uses smp_store_mb(), which is a memory barrier 
_after_ the store. Thus I do not see what enforces that the store 
happens before the store for the __add_wait_queue().

--

     Manfred

--------------QFF0zz3sc1ADSPJlE0hpJV6N
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-__wake_up_common_lock-Optimize-for-empty-wake-queues.patch"
Content-Disposition: attachment;
 filename*0="0001-__wake_up_common_lock-Optimize-for-empty-wake-queues.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3Y2I4ZjA2YWIwMjJlN2ZjMzZiYWNiZTY1ZjY1NDgyMjE0N2VjMWFhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYW5mcmVkIFNwcmF1bCA8bWFuZnJlZEBjb2xvcmZ1
bGxpZmUuY29tPgpEYXRlOiBGcmksIDI3IERlYyAyMDI0IDE4OjIxOjQxICswMTAwClN1Ympl
Y3Q6IFtQQVRDSF0gX193YWtlX3VwX2NvbW1vbl9sb2NrOiBPcHRpbWl6ZSBmb3IgZW1wdHkg
d2FrZSBxdWV1ZXMKCndha2VfdXAoKSBtdXN0IHdha2UgdXAgZXZlcnkgdGFzayB0aGF0IGlz
IGluIHRoZSB3YWl0IHF1ZXVlLgpCdXQ6IElmIHRoZXJlIGlzIGNvbmN1cnJlbmN5IGJldHdl
ZW4gd2FrZV91cCgpIGFuZCBhZGRfd2FpdF9xdWV1ZSgpLAp0aGVuIChhcyBsb25nIGFzIHdl
IGFyZSBub3QgdmlvbGF0aW5nIHRoZSBtZW1vcnkgb3JkZXJpbmcgcnVsZXMpIHdlCmNhbiBq
dXN0IGNsYWltIHRoYXQgd2FrZV91cCgpIGhhcHBlbmVkICJmaXJzdCIgYW5kIGFkZF93YWl0
X3F1ZXVlKCkKaGFwcGVuZWQgYWZ0ZXJ3YXJkcy4KRnJvbSBtZW1vcnkgb3JkZXJpbmcgcGVy
c3BlY3RpdmU6Ci0gSWYgdGhlIHdhaXRfcXVldWUoKSBpcyBlbXB0eSwgdGhlbiB3YWtlX3Vw
KCkganVzdCBkb2VzCiAgc3Bpbl9sb2NrKCk7CiAgbGlzdF9lbXB0eSgpCiAgc3Bpbl91bmxv
Y2soKTsKLSBhZGRfd2FpdF9xdWV1ZSgpL3ByZXBhcmVfdG9fd2FpdCgpIGRvIGFsbCBraW5k
IG9mIG9wZXJhdGlvbnMsCiAgYnV0IHRoZXkgbWF5IGJlY29tZSB2aXNpYmxlIG9ubHkgd2hl
biB0aGUgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgpCiAgaXMgZG9uZS4KVGh1cywgaW5zdGVh
ZCBvZiBwYWlyaW5nIHRoZSBtZW1vcnkgYmFycmllciB0byB0aGUgc3BpbmxvY2ssIGFuZAp0
aHVzIHdyaXRpbmcgdG8gYSBwb3RlbnRpYWxseSBzaGFyZWQgY2FjaGVsaW5lLCB3ZSBsb2Fk
LWFjcXVpcmUKdGhlIG5leHQgcG9pbnRlciBmcm9tIHRoZSBsaXN0LgoKUmlza3MgYW5kIHNp
ZGUgZWZmZWN0czoKLSBUaGUgZ3VhcmFudGVlZCBtZW1vcnkgYmFycmllciBvZiB3YWtlX3Vw
KCkgaXMgcmVkdWNlZCB0byBsb2FkX2FjcXVpcmUuCiAgUHJldmlvdXNseSwgdGhlcmUgd2Fz
IGFsd2F5cyBhIHNwaW5fbG9jaygpL3NwaW5fdW5sb2NrKCkgcGFpci4KLSBwcmVwYXJlX3Rv
X3dhaXQoKSBhY3R1YWxseSBkb2VzIHR3byBvcGVyYXRpb25zIHVuZGVyIHNwaW5sb2NrOgog
IEl0IGFkZHMgY3VycmVudCB0byB0aGUgd2FpdCBxdWV1ZSwgYW5kIGl0IGNhbGxzIHNldF9j
dXJyZW50X3N0YXRlKCkuCiAgVGhlIGNvbW1lbnQgYWJvdmUgcHJlcGFyZV90b193YWl0KCkg
aXMgbm90IGNsZWFyIHRvIG1lLCB0aHVzIHRoZXJlCiAgbWlnaHQgYmUgZnVydGhlciBzaWRl
IGVmZmVjdHMuCgpPbmx5IGxpZ2h0bHkgdGVzdGVkLgpObyBiZW5jaG1hcmsgdGVzdCBkb25l
LgotLS0KIGtlcm5lbC9zY2hlZC93YWl0LmMgfCAxNyArKysrKysrKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9rZXJuZWwvc2No
ZWQvd2FpdC5jIGIva2VybmVsL3NjaGVkL3dhaXQuYwppbmRleCA1MWUzOGY1ZjQ3MDEuLjEw
ZDAyZjY1MmFiOCAxMDA2NDQKLS0tIGEva2VybmVsL3NjaGVkL3dhaXQuYworKysgYi9rZXJu
ZWwvc2NoZWQvd2FpdC5jCkBAIC0xMjQsNiArMTI0LDIzIEBAIHN0YXRpYyBpbnQgX193YWtl
X3VwX2NvbW1vbl9sb2NrKHN0cnVjdCB3YWl0X3F1ZXVlX2hlYWQgKndxX2hlYWQsIHVuc2ln
bmVkIGludCBtCiBpbnQgX193YWtlX3VwKHN0cnVjdCB3YWl0X3F1ZXVlX2hlYWQgKndxX2hl
YWQsIHVuc2lnbmVkIGludCBtb2RlLAogCSAgICAgIGludCBucl9leGNsdXNpdmUsIHZvaWQg
KmtleSkKIHsKKwlpZiAobGlzdF9lbXB0eSgmd3FfaGVhZC0+aGVhZCkpIHsKKwkJc3RydWN0
IGxpc3RfaGVhZCAqcG47CisKKwkJLyoKKwkJICogcGFpcnMgd2l0aCBzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZ3cV9oZWFkLT5sb2NrKTsKKwkJICogV2UgYWN0dWFsbHkgZG8gbm90IG5l
ZWQgdG8gYWNxdWlyZSB3cV9oZWFkLT5sb2NrLCB3ZSBqdXN0CisJCSAqIG5lZWQgdG8gYmUg
c3VyZSB0aGF0IHRoZXJlIGlzIG5vIHByZXBhcmVfdG9fd2FpdCgpIHRoYXQKKwkJICogY29t
cGxldGVkIG9uIGFueSBDUFUgYmVmb3JlIF9fd2FrZV91cCB3YXMgY2FsbGVkLgorCQkgKiBU
aHVzIGluc3RlYWQgb2YgbG9hZF9hY3F1aXJpbmcgdGhlIHNwaW5sb2NrIGFuZCBkcm9wcGlu
ZworCQkgKiBpdCBhZ2Fpbiwgd2UgbG9hZF9hY3F1aXJlIHRoZSBuZXh0IGxpc3QgZW50cnkg
YW5kIGNoZWNrCisJCSAqIHRoYXQgdGhlIGxpc3QgaXMgbm90IGVtcHR5LgorCQkgKi8KKwkJ
cG4gPSBzbXBfbG9hZF9hY3F1aXJlKCZ3cV9oZWFkLT5oZWFkLm5leHQpOworCisJCWlmKHBu
ID09ICZ3cV9oZWFkLT5oZWFkKQorCQkJcmV0dXJuIDA7CisJfQogCXJldHVybiBfX3dha2Vf
dXBfY29tbW9uX2xvY2sod3FfaGVhZCwgbW9kZSwgbnJfZXhjbHVzaXZlLCAwLCBrZXkpOwog
fQogRVhQT1JUX1NZTUJPTChfX3dha2VfdXApOwotLSAKMi40Ny4xCgo=

--------------QFF0zz3sc1ADSPJlE0hpJV6N--

