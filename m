Return-Path: <linux-fsdevel+bounces-22913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D34D91EFAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 09:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE931F23126
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846F12F5B8;
	Tue,  2 Jul 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkbSaiXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3D77119
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903728; cv=none; b=i3U2b+nETT70pOJYp1sTt1lopLHfIv0fCPzoK10+hmsE+ywx6x+oPDgBeTb5Mww9bQO44+qDSek302UTZ5IsXF1WYOw3EgBbjfMbnpO+OlXXBP20G5YLk4h16MkfUPrQIt/BPav/kEfa7ZRul931lYmH8E8WgdVzn3Xv0TS96gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903728; c=relaxed/simple;
	bh=kLOMf4M+kzP2Nz8LInv8BiHYwztbqZy8TEQYWFbTFK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDBep/+0kaumrIQ/LIguh6Mq93hzqRLv2czMZ2Lza8wda9aHdFEnyaenYpKy/3ZeQJ5/yPqMm9Huvo3CKPAatppevcCIIXqIPBlJynFEvD7WrP2enbhDzJcyUuwWaAyfSvf+e1BG1z0lhtT5I6ti2PqtL+gTDjGwGBR7pfVYTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkbSaiXG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719903724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lpj/jq7DA83TJSwYLzaPnGSJ7qsFxmTwS+I4ShrrMwc=;
	b=EkbSaiXGAqy6+t8aBvFuolCwKpN3AkbVfEN/XUtSqcC3faYcoQHcI8uaxyJQae9sqhT3AB
	k79VQCc4F2TCpg6q9K5QPPq/JXyZt4FZJZEB7hsk8/3s9/ief0gY0y/YHOMxQ7bg/WUm15
	qXHaT9W0pRzRhJF7VZNLhQGVpSiVwn4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-1MtQsKvgP7-tvsTMEiFhBA-1; Tue, 02 Jul 2024 03:02:03 -0400
X-MC-Unique: 1MtQsKvgP7-tvsTMEiFhBA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-707fb3c31c6so1606133b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 00:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903722; x=1720508522;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpj/jq7DA83TJSwYLzaPnGSJ7qsFxmTwS+I4ShrrMwc=;
        b=OvNLw5vD4cdek/QfrBUYWo7W+hBoeu0QrAUP9bsYtK4IGolaw/sWuXfjR+5OSWoy+X
         QjitY98uKOMG0jNWGNc24RyVASbx87bIw+0sBvo/n0MLkLhcnYI48uPTVCngwoyCw746
         hROk26/qXZTjgJN2CAyk6HP5B3DWyG9mV6ODpAPBv/SEWq9eN6ZpuBuJy9mTQouO5/VT
         O8ceHtw4LVHqZAQEUIvqgrDCA6QnIhZ5dsYHOi8qEOesN5HScrroceQtuebaFdaq/oLS
         uWsYkQzA6nFK83omllVi7tRj4xOtGWBkPXt+NVa672iTBVlKZvfUElTir6IF+aD4cXNb
         Rc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9pFzZDIO2csu1BRIfv502yYwVOXvllX0P9YYTW+ifrAHIBpD5SxNHyxNJavKR2ro2YV1mR1RJwg7vwFGQXa8AMej23ZpmmrXOkF1jyw==
X-Gm-Message-State: AOJu0YygjDIigdCDlvW3HvPVVApba5muWW0Uh14wYlsrUrOzmHhqz0LQ
	1mVRYIHjAr37IC36mDT7Qt2rgoCaovnbwVPxLv8KQW1DNDj7iQFBxEwLXVuP7lWGUR/g0YPYDrI
	xDsnII7fxsgzFU02ljnYNYW6AsuEg8cDcso1IZiftBpKMRWTo5jJTMdefCxnYXLg=
X-Received: by 2002:a05:6a00:244e:b0:706:683d:2999 with SMTP id d2e1a72fcca58-70aaaee3fb5mr7009421b3a.24.1719903721955;
        Tue, 02 Jul 2024 00:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFr6bxaIiPxFd2P802HsnJLq4x/rg6LaIBuNZttw7D30VytWtMlmDqtT/bl94lm9TE7r8ifA==
X-Received: by 2002:a05:6a00:244e:b0:706:683d:2999 with SMTP id d2e1a72fcca58-70aaaee3fb5mr7009395b3a.24.1719903721516;
        Tue, 02 Jul 2024 00:02:01 -0700 (PDT)
Received: from ?IPV6:2403:580f:7fe0:0:ae49:39b9:2ee8:2187? (2403-580f-7fe0-0-ae49-39b9-2ee8-2187.ip6.aussiebb.net. [2403:580f:7fe0:0:ae49:39b9:2ee8:2187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708045aac85sm7910670b3a.174.2024.07.02.00.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 00:02:00 -0700 (PDT)
Message-ID: <a9963f50-6349-4e76-8f12-c12c2ad4d2ab@redhat.com>
Date: Tue, 2 Jul 2024 15:01:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
 Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk,
 raven@themaw.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Larsson <alexl@redhat.com>,
 Eric Chanudet <echanude@redhat.com>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <cfda4682-34b4-462c-acf6-976b0d79ba06@redhat.com>
 <20240628111345.3bbcgie4gar6icyj@quack3>
 <20240702-sauna-tattoo-31b01a5f98f6@brauner>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <20240702-sauna-tattoo-31b01a5f98f6@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 12:58, Christian Brauner wrote:
> On Fri, Jun 28, 2024 at 01:13:45PM GMT, Jan Kara wrote:
>> On Fri 28-06-24 10:58:54, Ian Kent wrote:
>>> On 27/6/24 19:54, Jan Kara wrote:
>>>> On Thu 27-06-24 09:11:14, Ian Kent wrote:
>>>>> On 27/6/24 04:47, Matthew Wilcox wrote:
>>>>>> On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
>>>>>>> +++ b/fs/namespace.c
>>>>>>> @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
>>>>>>>     static DECLARE_RWSEM(namespace_sem);
>>>>>>>     static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>>>>>>>     static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>>>>>>> +static bool lazy_unlock = false; /* protected by namespace_sem */
>>>>>> That's a pretty ugly way of doing it.  How about this?
>>>>> Ha!
>>>>>
>>>>> That was my original thought but I also didn't much like changing all the
>>>>> callers.
>>>>>
>>>>> I don't really like the proliferation of these small helper functions either
>>>>> but if everyone
>>>>>
>>>>> is happy to do this I think it's a great idea.
>>>> So I know you've suggested removing synchronize_rcu_expedited() call in
>>>> your comment to v2. But I wonder why is it safe? I *thought*
>>>> synchronize_rcu_expedited() is there to synchronize the dropping of the
>>>> last mnt reference (and maybe something else) - see the comment at the
>>>> beginning of mntput_no_expire() - and this change would break that?
>>> Interesting, because of the definition of lazy umount I didn't look closely
>>> enough at that.
>>>
>>> But I wonder, how exactly would that race occur, is holding the rcu read
>>> lock sufficient since the rcu'd mount free won't be done until it's
>>> released (at least I think that's how rcu works).
>> I'm concerned about a race like:
>>
>> [path lookup]				[umount -l]
>> ...
>> path_put()
>>    mntput(mnt)
>>      mntput_no_expire(m)
>>        rcu_read_lock();
>>        if (likely(READ_ONCE(mnt->mnt_ns))) {
>> 					do_umount()
>> 					  umount_tree()
>> 					    ...
>> 					    mnt->mnt_ns = NULL;
>> 					    ...
>> 					  namespace_unlock()
>> 					    mntput(&m->mnt)
>> 					      mntput_no_expire(mnt)
>> 				              smp_mb();
>> 					      mnt_add_count(mnt, -1);
>> 					      count = mnt_get_count(mnt);
>> 					      if (count != 0) {
>> 						...
>> 						return;
>>          mnt_add_count(mnt, -1);
>>          rcu_read_unlock();
>>          return;
>> -> KABOOM, mnt->mnt_count dropped to 0 but nobody cleaned up the mount!
>>        }
> Yeah, I think that's a valid concern. mntput_no_expire() requires that
> the last reference is dropped after an rcu grace period and that can
> only be done by synchronize_rcu_*() (It could be reworked but that would
> be quite ugly.). See also mnt_make_shortterm() caller's for kernel
> initiated unmounts.

I've thought about this a couple of times now.


Isn't it the case here that the path lookup thread will have taken a 
reference

(because it's calling path_put()) and the umount will have taken a 
reference on

system call entry.


So for the mount being umounted the starting count will be at lest three 
then if

the umount mntput() is called from namespace_unlock() it will correctly see

count != 0 and the path lookup mntput() to release it's reference 
finally leaving

the mntput() of the path_put() from the top level system call function 
to release

the last reference.


Once again I find myself thinking this should be independent of the rcu 
wait because

only path walks done before the mount being detached can be happening 
and the lockless

walks are done holding the rcu read lock and how likely is it a ref-walk 
path lookup

(that should follow a failed rcu-walk in this case) has been able to 
grab a reference

anyway?


I think the only reason the wait could be significant is to prevent 
changes to the

structures concerned causing problems because they happen earlier than 
can be

tolerated. That I can understand.


Mmm ... I feel like I'm starting to sound like a broken record ... oops!

Ian


