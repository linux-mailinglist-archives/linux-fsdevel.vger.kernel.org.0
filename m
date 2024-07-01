Return-Path: <linux-fsdevel+bounces-22829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E76A691D59E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 03:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF851F211E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 01:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCEE6FD5;
	Mon,  1 Jul 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRC+rYdn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6B1C32
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796099; cv=none; b=TJhiJtzFuI5iDY2H4e3hGVC8o8mhfv/5oit8t6cBz5RM7UWm+UI79b0ivMENG9uRyCfx5m8LQmQZ7Vt/pfDWTza5wLog8DLZ6IbvGtUcfB7t99IveCcEBsQdliUdoCSYhAdXxMo5dr43dSHHlPeX8KaN9LMzK/k/SLGDUgkpQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796099; c=relaxed/simple;
	bh=QV7oB0MzBepH3Gfv/sfxZY2kIPARX64YeKWtqGVi7fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3i/aN7Vqipe/5IP8E6o7lpswrqIWpz6STpaee2mXn61yIKierrMgsgCRIuE4gRjdFIBMCgmo+5QbcT4why6RO+2yG2f0UETHcKoQ9a4kfyAWF+QgJzxrhxChSPFWTrx3Ksne8+UHje3oCo4rDg0J1Eo/MLLJr5/XQVVgFIX2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRC+rYdn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719796096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V5j0C14UkFNEgU8QNuYTSpJEUKhs7EJnYTgNEqeZvhM=;
	b=BRC+rYdn3PIFV4osZ4fTu1iVQ4dCb8Vyo0imsJVDMCC+KgaOMXAcohab9oeTJGx5FV+iRl
	/ibKBWHnQucyQP6lWbqx1MylwUOLxpungVfcgHCnvvKdexk24iQxsyv/3eQL9NZALIYeae
	+fFbdx54ssIZSuwO9Hm+DuZL+lCWSOs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-hBLjvjnjN8eNvILmymK1iw-1; Sun, 30 Jun 2024 21:08:13 -0400
X-MC-Unique: hBLjvjnjN8eNvILmymK1iw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-721d20a0807so2267347a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jun 2024 18:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719796092; x=1720400892;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5j0C14UkFNEgU8QNuYTSpJEUKhs7EJnYTgNEqeZvhM=;
        b=AoYqoubcxpKI/Fc95I8McDoPjAteway79U23YHPRNjwzR+RtqfwzUnfFaKkM8YFgMu
         nI77F3aV7nGcSku1lxv60CJGaiV/ohxxVekshuFArD17/DUKS3l76iV9NKiUaSF0nH5a
         BiIwdlXY6Yq4ju5tpukgJnDJI6Olz2HolEOhiZ3dCENbIMUr1OIbBGxvbfPZWdS8Keu8
         JaedBV74W0B4BYpy49Iw2wFKEdBvYuzzgH/GjRPdMeqbDLDvDdAD26RB67h5pqnZu95+
         /iXGP9jzBKWnDBiVVGKBXZuDM8TdZvZuZlxZBBkaGgQLpB8/WOZ1V70oE6Im/EmVLq7W
         qQig==
X-Forwarded-Encrypted: i=1; AJvYcCUPTWokp+UWk5yhm5CEX/zrZZQDedUj17gi1cutnEijgky+rhFMMRvdp2BJWcMFAWrcg14INev4c5dX3ruisqQpysHfTOWqG4oycB8gog==
X-Gm-Message-State: AOJu0Yz+COuzFIsrgede2uED9Zzw+aesdLsxZqLelJBM0TclPv4+0NQl
	cDL0WA3lvsMLUYvLhk9hcqinonYJXbT4OAFKN4ZCq4tQwxchDI7+4ZM4SzLA/zN9q9+yrji5fYv
	5/tC1SElRslROBSJqkyjqLRuwrhUc3QsWZLDNAn+0ija6pbRyjRwYZcvopf83vmE=
X-Received: by 2002:a05:6a20:ba99:b0:1bd:1d15:f089 with SMTP id adf61e73a8af0-1bef6242eeamr5462298637.54.1719796092213;
        Sun, 30 Jun 2024 18:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg7qtY/QXMS6S2ii2fOZIzTOLQPr0GDKRhgQHXTfkEFEcWlAztbrnL5mL3j61qvOuCKC962Q==
X-Received: by 2002:a05:6a20:ba99:b0:1bd:1d15:f089 with SMTP id adf61e73a8af0-1bef6242eeamr5462288637.54.1719796091815;
        Sun, 30 Jun 2024 18:08:11 -0700 (PDT)
Received: from ?IPV6:2403:580f:7fe0:0:ae49:39b9:2ee8:2187? (2403-580f-7fe0-0-ae49-39b9-2ee8-2187.ip6.aussiebb.net. [2403:580f:7fe0:0:ae49:39b9:2ee8:2187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2239sm52143735ad.67.2024.06.30.18.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 18:08:11 -0700 (PDT)
Message-ID: <b3bd4181-daf1-457e-807d-b252673d5042@redhat.com>
Date: Mon, 1 Jul 2024 09:08:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
 Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, raven@themaw.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Larsson <alexl@redhat.com>,
 Eric Chanudet <echanude@redhat.com>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <cfda4682-34b4-462c-acf6-976b0d79ba06@redhat.com>
 <20240628111345.3bbcgie4gar6icyj@quack3>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <20240628111345.3bbcgie4gar6icyj@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/6/24 19:13, Jan Kara wrote:
> On Fri 28-06-24 10:58:54, Ian Kent wrote:
>> On 27/6/24 19:54, Jan Kara wrote:
>>> On Thu 27-06-24 09:11:14, Ian Kent wrote:
>>>> On 27/6/24 04:47, Matthew Wilcox wrote:
>>>>> On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
>>>>>> +++ b/fs/namespace.c
>>>>>> @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
>>>>>>     static DECLARE_RWSEM(namespace_sem);
>>>>>>     static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>>>>>>     static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>>>>>> +static bool lazy_unlock = false; /* protected by namespace_sem */
>>>>> That's a pretty ugly way of doing it.  How about this?
>>>> Ha!
>>>>
>>>> That was my original thought but I also didn't much like changing all the
>>>> callers.
>>>>
>>>> I don't really like the proliferation of these small helper functions either
>>>> but if everyone
>>>>
>>>> is happy to do this I think it's a great idea.
>>> So I know you've suggested removing synchronize_rcu_expedited() call in
>>> your comment to v2. But I wonder why is it safe? I *thought*
>>> synchronize_rcu_expedited() is there to synchronize the dropping of the
>>> last mnt reference (and maybe something else) - see the comment at the
>>> beginning of mntput_no_expire() - and this change would break that?
>> Interesting, because of the definition of lazy umount I didn't look closely
>> enough at that.
>>
>> But I wonder, how exactly would that race occur, is holding the rcu read
>> lock sufficient since the rcu'd mount free won't be done until it's
>> released (at least I think that's how rcu works).
> I'm concerned about a race like:
>
> [path lookup]				[umount -l]
> ...
> path_put()
>    mntput(mnt)
>      mntput_no_expire(m)
>        rcu_read_lock();
>        if (likely(READ_ONCE(mnt->mnt_ns))) {
> 					do_umount()
> 					  umount_tree()
> 					    ...
> 					    mnt->mnt_ns = NULL;
> 					    ...
> 					  namespace_unlock()
> 					    mntput(&m->mnt)
> 					      mntput_no_expire(mnt)
> 				              smp_mb();
> 					      mnt_add_count(mnt, -1);
> 					      count = mnt_get_count(mnt);
> 					      if (count != 0) {
> 						...
> 						return;
>          mnt_add_count(mnt, -1);
>          rcu_read_unlock();
>          return;
> -> KABOOM, mnt->mnt_count dropped to 0 but nobody cleaned up the mount!
>        }
>
> And this scenario is exactly prevented by synchronize_rcu() in
> namespace_unlock().

I just wanted to say that I don't have a reply to this yet, having been 
distracted

looking at the concern that Christian raised, in fact this looks like it 
will be hard

to grok ...


Ian


