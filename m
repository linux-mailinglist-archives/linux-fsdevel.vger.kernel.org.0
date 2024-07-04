Return-Path: <linux-fsdevel+bounces-23083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D0926D13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 03:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CACC1F21E23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732F7DF51;
	Thu,  4 Jul 2024 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sz98+7TI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CAC8CE
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720056214; cv=none; b=oJULT1iLQLkIPDN44jUuC30JBFREZCaBdDw9OCUbIOlbqWQFZzXzQnfO7BNjNtpMRZoRFWzxounmbDUAwzqY0awoKTGfIM3ULqDsbM6wMKfD0xieL6iJJywTK/3BOoCUeS2RnFEW2FoBaRPYR5C7p18UBND53K1ED3X571dC+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720056214; c=relaxed/simple;
	bh=BJuD4oAjNQoCbhV7ixlJNa0Tqo9H+rGhCNfLXI3JiFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0lgQDokZuNWbYWincuztzUKbnaB+/TV18oZDin7gigtXSK6HJsp7X144nDcKGY1KALU/S55zmnf1zvuSn+iwfy8E5K+zHslQ+WPai8co0YGJWNdHpo4YyP3rk+KrzwV2GYu5YIgZNddeC8NLhqph7t5Mw7oiwRZj85QdqlhvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sz98+7TI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720056212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FRVKU5kn7p5hiRZbKq//TD3FV740MSwrSEc3Yw2owhc=;
	b=Sz98+7TIWa/puJo60HehjZ51xzLUJBf5r2mlXHSF6GBoBQRbg2fWnLVi/BjJk1gb4cK/sC
	4GNLwHK9YQ4+yzX5BzKwjjLEIO0x4Rl/ZI0TGYv6POR47P7p4wvLSuyE4Z6jq5bbU9QLWx
	hkffI/X6vOONWfGtqjKsZJMb3hQb3SA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-OI4rxpPIMM-622_3k8pt3A-1; Wed, 03 Jul 2024 21:23:30 -0400
X-MC-Unique: OI4rxpPIMM-622_3k8pt3A-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fb2e1dadedso723235ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 18:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720056209; x=1720661009;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRVKU5kn7p5hiRZbKq//TD3FV740MSwrSEc3Yw2owhc=;
        b=DLC1LWjNsmh19F8d4YMhXWYLNU/lRTR1qHpFTaQTFSkM31YAG1TDTYuwY3I6co0LO0
         RmWKE/3BNTpT6E8iPtOt/AVfihc+e6qUqSSVFdu56S91ncKmHGWkKmqwYJSIvegm/ulo
         q1jYT9LO9BGdkaRuPyOxRB3JF3hxkv+/8Jo1kOMKi09Ne4XmZ1JJv5wOrpUgyDe+P8IP
         YeOUfsk5ywBDZ/ez5c2cdJpqONWTS4p0dY5T3/5qnLUUxuSkfG3lARYfc7ZBdsBLnme3
         d5YZla/eyH2N7xh3f1HvIVV+0B5k+dHS507sb9IvrB65IDOx041ZdxgniDdLFKTp1CJZ
         c2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWHkcu8OmDCo2oj7UJT5ohPQD9Pmtzu6dgutUZc6zlGvjTa5HOKkl8JA9TwJdSGP+41vnJSvgu3SA50/0/EMFrDEEJsdqlZhhNBhQ6uZQ==
X-Gm-Message-State: AOJu0YzWXwqok8LAFoSi+L19lTQMvJmZAsDXiP7gEDDg7OXug3OCdgsn
	Ncx8LCpbJkwlHduFS+np7yu2Vpi/yTS6mYTyrqtuQd10BVHdTParvrO8PIGXSSeVGK6jgadAv0F
	PsuGUwXgzXmBUgzUqG7uaw54aEj9oJKd2dj3hMvEO0AL6+HghT2rWS8tAZReSJb4=
X-Received: by 2002:a17:903:249:b0:1fb:3107:ec4b with SMTP id d9443c01a7336-1fb33e1834fmr2829385ad.17.1720056209142;
        Wed, 03 Jul 2024 18:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFszBYXZNwZtza786wpYXfORflgdeux+IguQTTUJ9knX2GD8dRgjr1QGJ/LO6MayT4S1BpZig==
X-Received: by 2002:a17:903:249:b0:1fb:3107:ec4b with SMTP id d9443c01a7336-1fb33e1834fmr2829205ad.17.1720056208654;
        Wed, 03 Jul 2024 18:23:28 -0700 (PDT)
Received: from [192.168.1.229] (159-196-82-144.9fc452.per.static.aussiebb.net. [159.196.82.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fafc656e96sm38854365ad.65.2024.07.03.18.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 18:23:27 -0700 (PDT)
Message-ID: <9781c2a8-7ee5-44f4-8218-dcd59e4a172d@redhat.com>
Date: Thu, 4 Jul 2024 09:23:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>,
 Alexander Larsson <alexl@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk,
 raven@themaw.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Chanudet <echanude@redhat.com>
References: <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
 <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>
 <20240701-zauber-holst-1ad7cadb02f9@brauner>
 <CAL7ro1FOYPsN3Y18tgHwpg+VB=rU1XB8Xds9P89Mh4T9N98jyA@mail.gmail.com>
 <20240701-treue-irrtum-e695ee5efe83@brauner>
 <20240703-mahnung-bauland-ffcacea4101e@brauner>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <20240703-mahnung-bauland-ffcacea4101e@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/7/24 17:22, Christian Brauner wrote:
> On Mon, Jul 01, 2024 at 02:10:31PM GMT, Christian Brauner wrote:
>> On Mon, Jul 01, 2024 at 10:41:40AM GMT, Alexander Larsson wrote:
>>> On Mon, Jul 1, 2024 at 7:50 AM Christian Brauner <brauner@kernel.org> wrote:
>>>>> I always thought the rcu delay was to ensure concurrent path walks "see" the
>>>>>
>>>>> umount not to ensure correct operation of the following mntput()(s).
>>>>>
>>>>>
>>>>> Isn't the sequence of operations roughly, resolve path, lock, deatch,
>>>>> release
>>>>>
>>>>> lock, rcu wait, mntput() subordinate mounts, put path.
>>>> The crucial bit is really that synchronize_rcu_expedited() ensures that
>>>> the final mntput() won't happen until path walk leaves RCU mode.
>>>>
>>>> This allows caller's like legitimize_mnt() which are called with only
>>>> the RCU read-lock during lazy path walk to simple check for
>>>> MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
>>>> that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
>>>> be freed until an RCU grace period is up and so they know that they can
>>>> simply put the reference count they took _without having to actually
>>>> call mntput()_.
>>>>
>>>> Because if they did have to call mntput() they might end up shutting the
>>>> filesystem down instead of umount() and that will cause said EBUSY
>>>> errors I mentioned in my earlier mails.
>>> But such behaviour could be kept even without an expedited RCU sync.
>>> Such as in my alternative patch for this:
>>> https://www.spinics.net/lists/linux-fsdevel/msg270117.html
>>>
>>> I.e. we would still guarantee the final mput is called, but not block
>>> the return of the unmount call.
>> That's fine but the patch as sent doesn't work is my point. It'll cause
>> exactly the issues described earlier, no? So I'm confused why this
>> version simply ended up removing synchronize_rcu_expedited() when
>> the proposed soluton seems to have been to use queue_rcu_work().
>>
>> But anyway, my concern with this is still that this changes the way
>> MNT_DETACH behaves when you shut down a non-busy filesystem with
>> MNT_DETACH as outlined in my other mail.
>>
>> If you find a workable version I'm not entirely opposed to try this but
>> I wouldn't be surprised if this causes user visible issues for anyone
>> that uses MNT_DETACH on a non-used filesystem.
> Correction: I misremembered that umount_tree() is called with
> UMOUNT_SYNC only in the case that umount() isn't called with MNT_DETACH.
> I mentioned this yesterday in the thread but just in case you missed it
> I want to spell it out in detail as well.

Thanks Christian, I did see that, yep.

There's also the seqlock in there to alert the legitimize that it needs

to restart using ref-walk.


>
> This is relevant because UMOUNT_SYNC will raise MNT_SYNC_UMOUNT on all
> mounts it unmounts. And that ends up being checked in legitimize_mnt()
> to ensure that legitimize_mnt() doesn't call mntput() during path lookup
> and risking EBUSY for a umount(..., 0) + mount() sequence for the same
> filesystem.
>
> But for umount(.., MNT_DETACH) UMOUNT_SYNC isn't passed and so
> MNT_SYNC_UMOUNT isn't raised on the mount and so legitimize_mnt() may
> end up doing the last mntput() and cleaning up the filesystem.
>
> In other words, a umount(..., MNT_DETACH) caller needs to be prepared to
> deal with EBUSY for a umount(..., MNT_DETACH) + mount() sequence.
>
> So I think we can certainly try this as long as we make it via
> queue_rcu_work() to handle the other mntput_no_expire() grace period
> dependency we discussed upthread.
>
> Thanks for making take a closer look.

I'm still not sure I fully understand the subtleties of how this works, I

think I'll need to do a deep dive into the rcu code and then revisit the

umount code. At least I won't be idle, ;(


Nevertheless I have to thank both you and Honza for your efforts and 
tolerance.


Ian

Ian



