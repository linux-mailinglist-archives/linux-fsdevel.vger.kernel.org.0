Return-Path: <linux-fsdevel+bounces-46145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49651A8358F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89E41B6314E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB0C171E43;
	Thu, 10 Apr 2025 01:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqKi3Wn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201959B71
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247855; cv=none; b=eA9TXUsaJATv81OvhV8Jv9/KqxcKmJ8ZK2UfqbsTPs0qXPL4YxjwTINPPsCCzGsyFXVoJ3QhyCTUdTdobZPER7BJPDt660NpRp40XPotFN6K+962hqjWYnC+hE8sE4sv6HZuh+0h1cQFcEprPk/iMDkeyIOKOJaFJAWccIxY6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247855; c=relaxed/simple;
	bh=M4iFrckRcXXL+edTeVe0caH6az2Ta8HC+CqJUEd80WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX/R44r+0x5Fr0Ci66fugnqNGK5RgJ4api608tZxDZULZv4L7Lcih5t6UmFoJ8a3eqU2QV7Lh99ctoSJV0BuYbO9RcnX0leP6QSyFcYAlwxsHY2Ur/lRyi2naZSaEJcpIrauy9xFi2+d9sffu0RV9PVAdEhBuO1e02RSivgHsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqKi3Wn/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744247851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7xzS7XLZY2qdrM4JSVF6iQPAbqPC6buSHi7Kkm+Ts/w=;
	b=HqKi3Wn//Y1Pouk/7vhjjCWz2oq7MM/KmzvSnZK1sHxHMLUDODSDSupgHT9srTvArRtxxI
	XUPoSHwiFdxGVM0AAbb8RxN2sDW91UBb8CcdIF5AJjWD7qU/UfKGX8zU3/fYBtOYAZLwqs
	oyM772Z0lnLkljVn5Gn6GLs72q+sVxc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-RJ1nTatXNxCf7RhfBkFLHw-1; Wed, 09 Apr 2025 21:17:30 -0400
X-MC-Unique: RJ1nTatXNxCf7RhfBkFLHw-1
X-Mimecast-MFC-AGG-ID: RJ1nTatXNxCf7RhfBkFLHw_1744247849
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-af53a6bc0b6so128347a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 18:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744247849; x=1744852649;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xzS7XLZY2qdrM4JSVF6iQPAbqPC6buSHi7Kkm+Ts/w=;
        b=kxfZ72EI6isy2DQBg7ZEa5BMmbGuSz11eeFxFkw9rGC1jSnY3SQBDGzbrHCgZrsp3W
         vgHX6Uu45QGb7mQtwTYwFTOVEmo0vlDMC8Vs1yMHPdXtBCUupRT/6/PIVRksfsR4XLSg
         JJsQ1b05FC47TGoGudviDJdD+qig4MhOlR2nCbaFpHjg1ZQVWN2+DTd4U5IXIRb/dx3h
         2lhACIzSXxhcRLRJbXuDZSjDuNBqROKdmC4EXqjF1BHfr8anz+yO70M18moP6sq8Drxb
         NEZTBlwHPX7vyNvGHs73n06HVeTf16LK39DPtDI9mcpXURaOW9fw8p4sy/ed2aWSIZen
         yCag==
X-Forwarded-Encrypted: i=1; AJvYcCV4FhIU/Ey0YkAC6xIzij35T2Y9pnE4vFohXjAmnwXP+sTvLS2Tc9EBFedb0uwtuZERxwJkvpTxy3rtch8c@vger.kernel.org
X-Gm-Message-State: AOJu0YzRBLJ33mE7hvtPP38V3Ob9B+PX8e8tZ6ANxyprdwgQzB7vfyZ0
	RErarChhsahE/QshfCkny5jnTpIjERcEIRsh0Ulnm13gsmpNsjbcB579jqi/poG8OP8t3krsvJi
	5G5pAEte7HAGVYIOt6kCxWmCH5aXpAIK/P6Tv380eqDX+4E7togFaqSyca9yIzd4=
X-Gm-Gg: ASbGncta8Imo5DvMq/ixSj04j6geSKD1nJsa5tsOVxc2vSvChZbG6gPbf3pFPkDk97D
	cd1EF2WZ9i1ITzAovxZyFno1PEZsPyEwnDQtbDrrCAG5h29dKJFTQbUsZFdf64m+Mi9em36lMen
	uqGT8GN5+YhD5zhFgZAIZyb0uYfy7pDMiJ/E8h6j8ev3walab4pEseQk7LuQKDajEtHxtxcaa0U
	qmKTKhDcv//QRjhCdBRlIXQGtifVdE4kMj7op3GKniywJ2FLLGOa01EOMhRPUDWYuND49AaL+tG
	m2nC3o/P9UrNRLWCsZfrXvZdtGj1HGK/RyT6RZMtV24DCDuLzxJQ5Q6f/XCdSujF
X-Received: by 2002:a17:902:ce0a:b0:224:1d1c:8837 with SMTP id d9443c01a7336-22b2edcf2a7mr14689765ad.19.1744247849308;
        Wed, 09 Apr 2025 18:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHbv/B25q/BG5rbos8mxYjUX40TLjvJ7m9oY6FlTJ/MEsfzB1q0qTMpChUkwgKeFWkzHCTyQ==
X-Received: by 2002:a17:902:ce0a:b0:224:1d1c:8837 with SMTP id d9443c01a7336-22b2edcf2a7mr14689475ad.19.1744247848844;
        Wed, 09 Apr 2025 18:17:28 -0700 (PDT)
Received: from [192.168.0.229] (159-196-82-144.9fc452.per.static.aussiebb.net. [159.196.82.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cafdaasm18861255ad.165.2025.04.09.18.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 18:17:28 -0700 (PDT)
Message-ID: <18e35aab-9cbc-4df0-b88f-34e390a21c8c@redhat.com>
Date: Thu, 10 Apr 2025 09:17:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>,
 Eric Chanudet <echanude@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Alexander Larsson <alexl@redhat.com>,
 Lucas Karpinski <lkarpins@redhat.com>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 xsFNBE6c/ycBEADdYbAI5BKjE+yw+dOE+xucCEYiGyRhOI9JiZLUBh+PDz8cDnNxcCspH44o
 E7oTH0XPn9f7Zh0TkXWA8G6BZVCNifG7mM9K8Ecp3NheQYCk488ucSV/dz6DJ8BqX4psd4TI
 gpcs2iDQlg5CmuXDhc5z1ztNubv8hElSlFX/4l/U18OfrdTbbcjF/fivBkzkVobtltiL+msN
 bDq5S0K2KOxRxuXGaDShvfbz6DnajoVLEkNgEnGpSLxQNlJXdQBTE509MA30Q2aGk6oqHBQv
 zxjVyOu+WLGPSj7hF8SdYOjizVKIARGJzDy8qT4v/TLdVqPa2d0rx7DFvBRzOqYQL13/Zvie
 kuGbj3XvFibVt2ecS87WCJ/nlQxCa0KjGy0eb3i4XObtcU23fnd0ieZsQs4uDhZgzYB8LNud
 WXx9/Q0qsWfvZw7hEdPdPRBmwRmt2O1fbfk5CQN1EtNgS372PbOjQHaIV6n+QQP2ELIa3X5Z
 RnyaXyzwaCt6ETUHTslEaR9nOG6N3sIohIwlIywGK6WQmRBPyz5X1oF2Ld9E0crlaZYFPMRH
 hQtFxdycIBpTlc59g7uIXzwRx65HJcyBflj72YoTzwchN6Wf2rKq9xmtkV2Eihwo8WH3XkL9
 cjVKjg8rKRmqIMSRCpqFBWJpT1FzecQ8EMV0fk18Q5MLj441yQARAQABzRtJYW4gS2VudCA8
 aWtlbnRAcmVkaGF0LmNvbT7CwXgEEwECACIFAk6eM44CGwMGCwkIBwMCBhUIAgkKCwQWAgMB
 Ah4BAheAAAoJEOdnc4D1T9ipMWwP/1FJJWjVYZekg0QOBixULBQ9Gx2TQewOp1DW/BViOMb7
 uYxrlsnvE7TDyqw5yQz6dfb8/b9dPn68qhDecW9bsu72e9i143Cd4shTlkZfORiZjX70196j
 r2LiI6L11uSoVhDGeikSdfRtNWyEwAx2iLstwi7FccslNE4cWIIH2v0dxDYSpcfMaLmT9a7f
 xdoMLW58nwIz0GxQs/2OMykn/VISt25wrepmBiacWu6oqQrpIYh3jyvMQYTBtdalUDDJqf+W
 aUO3+sNFRRysLGcCvEnNuWC3CeTTqU74XTUhf4cmAOyk+seA3MkPyzjVFufLipoYcCnjUavs
 MKBXQ8SCVdDxYxZwS8/FOhB8J2fN8w6gC5uK0ZKAzTj2WhJdxGe+hjf7zdyOcxMl5idbOOFu
 5gIm0Y5Q4mXz4q5vfjRlhQKvcqBc2HBTlI6xKAP/nxCAH4VzR5J9fhqxrWfcoREyUFHLMBuJ
 GCRWxN7ZQoTYYPl6uTRVbQMfr/tEck2IWsqsqPZsV63zhGLWVufBxg88RD+YHiGCduhcKica
 8UluTK4aYLt8YadkGKgy812X+zSubS6D7yZELNA+Ge1yesyJOZsbpojdFLAdwVkBa1xXkDhH
 BK0zUFE08obrnrEUeQDxAhIiN9pctG0nvqyBwTLGFoE5oRXJbtNXcHlEYcUxl8BizsFNBE6c
 /ycBEADZzcb88XlSiooYoEt3vuGkYoSkz7potX864MSNGekek1cwUrXeUdHUlw5zwPoC4H5J
 F7D8q7lYoelBYJ+Mf0vdLzJLbbEtN5+v+s2UEbkDlnUQS1yRo1LxyNhJiXsQVr7WVA/c8qcD
 WUYX7q/4Ckg77UO4l/eHCWNnHu7GkvKLVEgRjKPKroIEnjI0HMK3f6ABDReoc741RF5XX3qw
 mCgKZx0AkLjObXE3W769dtbNbWmW0lgFKe6dxlYrlZbq25Aubhcu2qTdQ/okx6uQ41+vQDxg
 YtocsT/CG1u0PpbtMeIm3mVQRXmjDFKjKAx9WOX/BHpk7VEtsNQUEp1lZo6hH7jeo5meCYFz
 gIbXdsMA9TjpzPpiWK9GetbD5KhnDId4ANMrWPNuGC/uPHDjtEJyf0cwknsRFLhL4/NJKvqA
 uiXQ57x6qxrkuuinBQ3S9RR3JY7R7c3rqpWyaTuNNGPkIrRNyePky/ZTgTMA5of8Wioyz06X
 Nhr6mG5xT+MHztKAQddV3xFy9f3Jrvtd6UvFbQPwG7Lv+/UztY5vPAzp7aJGz2pDbb0QBC9u
 1mrHICB4awPlja/ljn+uuIb8Ow3jSy+Sx58VFEK7ctIOULdmnHXMFEihnOZO3NlNa6q+XZOK
 7J00Ne6y0IBAaNTM+xMF+JRc7Gx6bChES9vxMyMbXwARAQABwsFfBBgBAgAJBQJOnP8nAhsM
 AAoJEOdnc4D1T9iphf4QAJuR1jVyLLSkBDOPCa3ejvEqp4H5QUogl1ASkEboMiWcQJQdLaH6
 zHNySMnsN6g/UVhuviANBxtW2DFfANPiydox85CdH71gLkcOE1J7J6Fnxgjpc1Dq5kxhimBS
 qa2hlsKUt3MLXbjEYL5OTSV2RtNP04KwlGS/xMfNwQf2O2aJoC4mSs4OeZwsHJFVF8rKXDvL
 /NzMCnysWCwjVIDhHBBIOC3mecYtXrasv9nl77LgffyyaAAQZz7yZcvn8puj9jH9h+mrL02W
 +gd+Sh6Grvo5Kk4ngzfT/FtscVGv9zFWxfyoQHRyuhk0SOsoTNYN8XIWhosp9GViyDtEFXmr
 hiazz7XHc32u+o9+WugpTBZktYpORxLVwf9h1PY7CPDNX4EaIO64oyy9O3/huhOTOGhanVvq
 lYHyEYCFY7pIfaSNhgZs2aV0oP13XV6PGb5xir5ah+NW9gQk/obnvY5TAVtgTjAte5tZ+coC
 SBkOU1xMiW5Td7QwkNmtXKHyEF6dxCAMK1KHIqxrBaZO27PEDSHaIPHePi7y4KKq9C9U8k5V
 5dFA0mqH/st9Sw6tFbqPkqjvvMLETDPVxOzinpU2VBGhce4wufSIoVLOjQnbIo1FIqWgDx24
 eHv235mnNuGHrG+EapIh7g/67K0uAzwp17eyUYlE5BMcwRlaHMuKTil6
In-Reply-To: <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/25 18:37, Christian Brauner wrote:
> On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
>> Defer releasing the detached file-system when calling namespace_unlock()
>> during a lazy umount to return faster.
>>
>> When requesting MNT_DETACH, the caller does not expect the file-system
>> to be shut down upon returning from the syscall. Calling
>> synchronize_rcu_expedited() has a significant cost on RT kernel that
>> defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
>> mount in a separate list and put it on a workqueue to run post RCU
>> grace-period.
>>
>> w/o patch, 6.15-rc1 PREEMPT_RT:
>> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>>      0.02455 +- 0.00107 seconds time elapsed  ( +-  4.36% )
>> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
>>      0.02555 +- 0.00114 seconds time elapsed  ( +-  4.46% )
>>
>> w/ patch, 6.15-rc1 PREEMPT_RT:
>> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>>      0.026311 +- 0.000869 seconds time elapsed  ( +-  3.30% )
>> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
>>      0.003194 +- 0.000160 seconds time elapsed  ( +-  5.01% )
>>
>> Signed-off-by: Alexander Larsson <alexl@redhat.com>
>> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
>> ---
>>
>> Attempt to re-spin this series based on the feedback received in v3 that
>> pointed out the need to wait the grace-period in namespace_unlock()
>> before calling the deferred mntput().
> I still hate this with a passion because it adds another special-sauce
> path into the unlock path. I've folded the following diff into it so it
> at least doesn't start passing that pointless boolean and doesn't
> introduce __namespace_unlock(). Just use a global variable and pick the
> value off of it just as we do with the lists. Testing this now:

Yeah, it's painful that's for sure.


I also agree with you about the parameter, changing the call signature

always rubbed me the wrong way but I didn't push back on it mostly because

we needed to find a way to do it sensibly and it sounds like that's still

the case.


AFAICT what's needed is a way to synchronize umount with the lockless path

walk. Now umount detaches the mounts concerned, calls the rcu synchronize

(essentially sleeps) to ensure that any lockless path walks see the umount

before completing. But that rcu sync. is, as we can see, really wasteful so

we do need to find a viable way to synchronize this.


Strictly speaking the synchronization problem exists for normal and detached

umounts but if we can find a sound solution for detached mounts perhaps 
we can

extend later (but now that seems like a stretch) ...


I'm not sure why, perhaps it's just me, I don't know, but with this we don't

seem to be working well together to find a solution, I hope we can 
change that

this time around.


I was thinking of using a completion for this synchronization but even that

would be messy because of possible multiple processes doing walks at the 
time

which doesn't lend cleanly to using a completion.


Do you have any ideas on how this could be done yourself?


Ian

>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e5b0b920dd97..25599428706c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -82,8 +82,9 @@ static struct hlist_head *mount_hashtable __ro_after_init;
>   static struct hlist_head *mountpoint_hashtable __ro_after_init;
>   static struct kmem_cache *mnt_cache __ro_after_init;
>   static DECLARE_RWSEM(namespace_sem);
> -static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
> -static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> +static bool unmounted_lazily;          /* protected by namespace_sem */
> +static HLIST_HEAD(unmounted);          /* protected by namespace_sem */
> +static LIST_HEAD(ex_mountpoints);      /* protected by namespace_sem */
>   static DEFINE_SEQLOCK(mnt_ns_tree_lock);
>
>   #ifdef CONFIG_FSNOTIFY
> @@ -1807,17 +1808,18 @@ static void free_mounts(struct hlist_head *mount_list)
>
>   static void defer_free_mounts(struct work_struct *work)
>   {
> -       struct deferred_free_mounts *d = container_of(
> -               to_rcu_work(work), struct deferred_free_mounts, rwork);
> +       struct deferred_free_mounts *d;
>
> +       d = container_of(to_rcu_work(work), struct deferred_free_mounts, rwork);
>          free_mounts(&d->release_list);
>          kfree(d);
>   }
>
> -static void __namespace_unlock(bool lazy)
> +static void namespace_unlock(void)
>   {
>          HLIST_HEAD(head);
>          LIST_HEAD(list);
> +       bool defer = unmounted_lazily;
>
>          hlist_move_list(&unmounted, &head);
>          list_splice_init(&ex_mountpoints, &list);
> @@ -1840,29 +1842,21 @@ static void __namespace_unlock(bool lazy)
>          if (likely(hlist_empty(&head)))
>                  return;
>
> -       if (lazy) {
> -               struct deferred_free_mounts *d =
> -                       kmalloc(sizeof(*d), GFP_KERNEL);
> +       if (defer) {
> +               struct deferred_free_mounts *d;
>
> -               if (unlikely(!d))
> -                       goto out;
> -
> -               hlist_move_list(&head, &d->release_list);
> -               INIT_RCU_WORK(&d->rwork, defer_free_mounts);
> -               queue_rcu_work(system_wq, &d->rwork);
> -               return;
> +               d = kmalloc(sizeof(struct deferred_free_mounts), GFP_KERNEL);
> +               if (d) {
> +                       hlist_move_list(&head, &d->release_list);
> +                       INIT_RCU_WORK(&d->rwork, defer_free_mounts);
> +                       queue_rcu_work(system_wq, &d->rwork);
> +                       return;
> +               }
>          }
> -
> -out:
>          synchronize_rcu_expedited();
>          free_mounts(&head);
>   }
>
> -static inline void namespace_unlock(void)
> -{
> -       __namespace_unlock(false);
> -}
> -
>   static inline void namespace_lock(void)
>   {
>          down_write(&namespace_sem);
> @@ -2094,7 +2088,7 @@ static int do_umount(struct mount *mnt, int flags)
>          }
>   out:
>          unlock_mount_hash();
> -       __namespace_unlock(flags & MNT_DETACH);
> +       namespace_unlock();
>          return retval;
>   }
>
>
>> v4:
>> - Use queue_rcu_work() to defer free_mounts() for lazy umounts
>> - Drop lazy_unlock global and refactor using a helper
>> v3: https://lore.kernel.org/all/20240626201129.272750-2-lkarpins@redhat.com/
>> - Removed unneeded code for lazy umount case.
>> - Don't block within interrupt context.
>> v2: https://lore.kernel.org/all/20240426195429.28547-1-lkarpins@redhat.com/
>> - Only defer releasing umount'ed filesystems for lazy umounts
>> v1: https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/
>>
>>   fs/namespace.c | 52 +++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 45 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index 14935a0500a2..e5b0b920dd97 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -45,6 +45,11 @@ static unsigned int m_hash_shift __ro_after_init;
>>   static unsigned int mp_hash_mask __ro_after_init;
>>   static unsigned int mp_hash_shift __ro_after_init;
>>   
>> +struct deferred_free_mounts {
>> +	struct rcu_work rwork;
>> +	struct hlist_head release_list;
>> +};
>> +
>>   static __initdata unsigned long mhash_entries;
>>   static int __init set_mhash_entries(char *str)
>>   {
>> @@ -1789,11 +1794,29 @@ static bool need_notify_mnt_list(void)
>>   }
>>   #endif
>>   
>> -static void namespace_unlock(void)
>> +static void free_mounts(struct hlist_head *mount_list)
>>   {
>> -	struct hlist_head head;
>>   	struct hlist_node *p;
>>   	struct mount *m;
>> +
>> +	hlist_for_each_entry_safe(m, p, mount_list, mnt_umount) {
>> +		hlist_del(&m->mnt_umount);
>> +		mntput(&m->mnt);
>> +	}
>> +}
>> +
>> +static void defer_free_mounts(struct work_struct *work)
>> +{
>> +	struct deferred_free_mounts *d = container_of(
>> +		to_rcu_work(work), struct deferred_free_mounts, rwork);
>> +
>> +	free_mounts(&d->release_list);
>> +	kfree(d);
>> +}
>> +
>> +static void __namespace_unlock(bool lazy)
>> +{
>> +	HLIST_HEAD(head);
>>   	LIST_HEAD(list);
>>   
>>   	hlist_move_list(&unmounted, &head);
>> @@ -1817,12 +1840,27 @@ static void namespace_unlock(void)
>>   	if (likely(hlist_empty(&head)))
>>   		return;
>>   
>> -	synchronize_rcu_expedited();
>> +	if (lazy) {
>> +		struct deferred_free_mounts *d =
>> +			kmalloc(sizeof(*d), GFP_KERNEL);
>>   
>> -	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>> -		hlist_del(&m->mnt_umount);
>> -		mntput(&m->mnt);
>> +		if (unlikely(!d))
>> +			goto out;
>> +
>> +		hlist_move_list(&head, &d->release_list);
>> +		INIT_RCU_WORK(&d->rwork, defer_free_mounts);
>> +		queue_rcu_work(system_wq, &d->rwork);
>> +		return;
>>   	}
>> +
>> +out:
>> +	synchronize_rcu_expedited();
>> +	free_mounts(&head);
>> +}
>> +
>> +static inline void namespace_unlock(void)
>> +{
>> +	__namespace_unlock(false);
>>   }
>>   
>>   static inline void namespace_lock(void)
>> @@ -2056,7 +2094,7 @@ static int do_umount(struct mount *mnt, int flags)
>>   	}
>>   out:
>>   	unlock_mount_hash();
>> -	namespace_unlock();
>> +	__namespace_unlock(flags & MNT_DETACH);
>>   	return retval;
>>   }
>>   
>> -- 
>> 2.49.0
>>


