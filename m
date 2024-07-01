Return-Path: <linux-fsdevel+bounces-22828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7E591D593
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 02:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF782281189
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 00:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE93D62;
	Mon,  1 Jul 2024 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDeqMbgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E623A0
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719795538; cv=none; b=GCJov3jc3lp2bFfQCJ1aNC+BFHQhKZk8lDC5FK8oGX45iLy6o7wO+t7/E/S37tbL9ICPxLiNpstaTQCWo+TYBCto8TVxriAjtspJooP3PytenSrCRe4gBPvxd6HBQPJmYveRvGRJD80TOhgFAtKzxrXL/V5TFHwIqwtWiHRaPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719795538; c=relaxed/simple;
	bh=OKpXOH1V5ofWjz9SCSARcVWRpXkVg3TzlreV5hyDM6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLC2D/hL8O2WgsAeQA+YKjMvY5WSakWjgceFp8Tc9feD/UYUpxTl/PYTTjy2bSOPOML2g4H0IWKagjrWn9EJdSv9G/cWVPzXksR07ZyI3D9Ai/hBjk0PALLHEikmsudRC+bHhnA0eRaR0Avr8pduFY7SUqoU8oHxEIi+BdvqUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDeqMbgU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719795535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lbwIoUp2FOGyNX6DAXGXc5hN/7DBWodm6MffMzZS5L4=;
	b=iDeqMbgUBawUJJhRO1xOpQfwt4Fl3PROoJPLTQSudx2uhi5J9WsKOxT+VSaHf2O15x3IPE
	+TzyOc74JxHlfHd04JuZoLuNRaUxr52DE875HWAO15n+ZMCwcATIP6Ghcpx6YE94TaQbM1
	/Ll7tenDnMUz6q2aoNQAcvexOumvVcg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-86r2i8GZPJaHjkoJmt4fkg-1; Sun, 30 Jun 2024 20:58:52 -0400
X-MC-Unique: 86r2i8GZPJaHjkoJmt4fkg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f9cd1889f6so12887505ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jun 2024 17:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719795532; x=1720400332;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbwIoUp2FOGyNX6DAXGXc5hN/7DBWodm6MffMzZS5L4=;
        b=tJHMv2PorJ8zRbmKKbysZdTwVt/KypWBaUyUraENcEvhC7gpim2ofPPYV14b9MeX4R
         Xo1JAv//xkqTSYR3LI1k/X2niX6rGEJl4Nc9cDLp1yvV8nA1o4Bo+8jmJ3Jh8PCnO1y2
         Pk+xnOdeMmLMyudf+iGMVr0i30Tb1T9atNC4q0Rt9dDnqiBM4a8En4W70yQFLWgSkFtr
         3Eua37nrQYw5bLH6fkc+l9c7zNyEOcUyuShhmF+gFgtfDhQmEDkaBgcnjUralqjQvA5P
         VTxwj6Si8g2FLTbw/0+Wwy7gW00Ab9fJ4MUIB1aTfhHt1GInp5lF8qn6hGYZPQ5vX/xn
         vzYw==
X-Forwarded-Encrypted: i=1; AJvYcCXxK+MH4qqghcZn4ZJUHc/oM0+WnQSvWXJeV/pK97n9U1MNT+1MZST1cjW6Klw1dkQt3OmpFmB2qFP3zN6lS8qHSpLA2FtFJ/vK3MRs8Q==
X-Gm-Message-State: AOJu0YzURIw5rDvNhgP337ku/Ra8wVAMBwnYbKi6p5yjYDhASQQVN2uH
	5FNml+sJPFsj6D3TS9wt5fH4ePw+umsoo8m4Y6INRdoAX6EiPB10NlpDBmEy36+QRoF0y3N2NNn
	ImK7YbL/f5KTHwrSZgWq9y3eJTg/zPVBKoZlDRkOcOOaeGpUn44cwIFnc9sx+8PM=
X-Received: by 2002:a17:902:e54a:b0:1f8:6971:c35d with SMTP id d9443c01a7336-1fadbd22960mr19865035ad.68.1719795531708;
        Sun, 30 Jun 2024 17:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH1D6k87aSBfdAB4BMMzDpgHS9GmZA2JImdO7EGg8XRxG9PyfFNbFmvOeCu9ImvTXD51+0xg==
X-Received: by 2002:a17:902:e54a:b0:1f8:6971:c35d with SMTP id d9443c01a7336-1fadbd22960mr19864885ad.68.1719795531225;
        Sun, 30 Jun 2024 17:58:51 -0700 (PDT)
Received: from ?IPV6:2403:580f:7fe0:0:ae49:39b9:2ee8:2187? (2403-580f-7fe0-0-ae49-39b9-2ee8-2187.ip6.aussiebb.net. [2403:580f:7fe0:0:ae49:39b9:2ee8:2187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569f83sm51668325ad.204.2024.06.30.17.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 17:58:50 -0700 (PDT)
Message-ID: <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>
Date: Mon, 1 Jul 2024 08:58:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk,
 raven@themaw.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Chanudet <echanude@redhat.com>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
 <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/6/24 23:13, Alexander Larsson wrote:
> On Fri, Jun 28, 2024 at 2:54 PM Christian Brauner <brauner@kernel.org> wrote:
>> On Fri, Jun 28, 2024 at 11:17:43AM GMT, Ian Kent wrote:
>>> On 27/6/24 23:16, Christian Brauner wrote:
>>>> On Thu, Jun 27, 2024 at 01:54:18PM GMT, Jan Kara wrote:
>>>>> On Thu 27-06-24 09:11:14, Ian Kent wrote:
>>>>>> On 27/6/24 04:47, Matthew Wilcox wrote:
>>>>>>> On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
>>>>>>>> +++ b/fs/namespace.c
>>>>>>>> @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
>>>>>>>>     static DECLARE_RWSEM(namespace_sem);
>>>>>>>>     static HLIST_HEAD(unmounted);    /* protected by namespace_sem */
>>>>>>>>     static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>>>>>>>> +static bool lazy_unlock = false; /* protected by namespace_sem */
>>>>>>> That's a pretty ugly way of doing it.  How about this?
>>>>>> Ha!
>>>>>>
>>>>>> That was my original thought but I also didn't much like changing all the
>>>>>> callers.
>>>>>>
>>>>>> I don't really like the proliferation of these small helper functions either
>>>>>> but if everyone
>>>>>>
>>>>>> is happy to do this I think it's a great idea.
>>>>> So I know you've suggested removing synchronize_rcu_expedited() call in
>>>>> your comment to v2. But I wonder why is it safe? I *thought*
>>>>> synchronize_rcu_expedited() is there to synchronize the dropping of the
>>>>> last mnt reference (and maybe something else) - see the comment at the
>>>>> beginning of mntput_no_expire() - and this change would break that?
>>>> Yes. During umount mnt->mnt_ns will be set to NULL with namespace_sem
>>>> and the mount seqlock held. mntput() doesn't acquire namespace_sem as
>>>> that would get rather problematic during path lookup. It also elides
>>>> lock_mount_hash() by looking at mnt->mnt_ns because that's set to NULL
>>>> when a mount is actually unmounted.
>>>>
>>>> So iirc synchronize_rcu_expedited() will ensure that it is actually the
>>>> system call that shuts down all the mounts it put on the umounted list
>>>> and not some other task that also called mntput() as that would cause
>>>> pretty blatant EBUSY issues.
>>>>
>>>> So callers that come before mnt->mnt_ns = NULL simply return of course
>>>> but callers that come after mnt->mnt_ns = NULL will acquire
>>>> lock_mount_hash() _under_ rcu_read_lock(). These callers see an elevated
>>>> reference count and thus simply return while namespace_lock()'s
>>>> synchronize_rcu_expedited() prevents the system call from making
>>>> progress.
>>>>
>>>> But I also don't see it working without risk even with MNT_DETACH. It
>>>> still has potential to cause issues in userspace. Any program that
>>>> always passes MNT_DETACH simply to ensure that even in the very rare
>>>> case that a mount might still be busy is unmounted might now end up
>>>> seeing increased EBUSY failures for mounts that didn't actually need to
>>>> be unmounted with MNT_DETACH. In other words, this is only inocuous if
>>>> userspace only uses MNT_DETACH for stuff they actually know is busy when
>>>> they're trying to unmount. And I don't think that's the case.
>>>>
>>> I'm sorry but how does an MNT_DETACH umount system call return EBUSY, I
>>> can't
>>>
>>> see how that can happen?
>> Not the umount() call is the problem. Say you have the following
>> sequence:
>>
>> (1) mount(ext4-device, /mnt)
>>      umount(/mnt, 0)
>>      mount(ext4-device, /mnt)
>>
>> If that ext4 filesystem isn't in use anymore then umount() will succeed.
>> The same task can immediately issue a second mount() call on the same
>> device and it must succeed.
>>
>> Today the behavior for this is the same whether or no the caller uses
>> MNT_DETACH. So:
>>
>> (2) mount(ext4-device, /mnt)
>>      umount(/mnt, MNT_DETACH)
>>      mount(ext4-device, /mnt)
>>
>> All that MNT_DETACH does is to skip the check for busy mounts otherwise
>> it's identical to a regular umount. So (1) and (2) will behave the same
>> as long as the filesystem isn't used anymore.
>>
>> But afaict with your changes this wouldn't be true anymore. If someone
>> uses (2) on a filesystem that isn't busy then they might end up getting
>> EBUSY on the second mount. And if I'm right then that's potentially a
>> rather visible change.

I'm not sure this change affects the the likelyhood of an EBUSY return 
in the

described case, in fact it looks like it does the opposite.


I always thought the rcu delay was to ensure concurrent path walks "see" the

umount not to ensure correct operation of the following mntput()(s).


Isn't the sequence of operations roughly, resolve path, lock, deatch, 
release

lock, rcu wait, mntput() subordinate mounts, put path.


So the mount gets detached in the critical section, then we wait followed by

the mntput()(s). The catch is that not waiting might increase the likelyhood

that concurrent path walks don't see the umount (so that possibly the umount

goes away before the walks see the umount) but I'm not certain. What 
looks to

be as much of a problem is mntput() racing with a concurrent mount 
beacase while

the detach is done in the critical section the super block instance list 
deletion

is not and the wait will make the race possibility more likely. What's more

mntput() delegates the mount cleanup (which deletes the list instance) to a

workqueue job so this can also occur serially in a following mount command.


In fact I might have seen exactly this behavior in a recent xfs-tests 
run where I

was puzzled to see occasional EBUSY return on mounting of mounts that 
should not

have been in use following their umount.


So I think there are problems here but I don't think the removal of the 
wait for

lazy umount is the worst of it.


The question then becomes, to start with, how do we resolve this 
unjustified EBUSY

return. Perhaps a completion (used between the umount and mount system 
calls) would

work well here?


> This is rather unfortunate, as the synchronize_rcu call is quite
> expensive. In particular on a real-time kernel where there are no
> expedited RCUs. This is causing container startup to be slow, as there
> are several umount(MNT_DETACH) happening during container setup (after
> the pivot_root, etc).
>
> Maybe we can add a umount flag for users that don't need the current
> behaviour wrt EBUSY? In the container usecase the important part is
> that the old mounts are disconnected from the child namespace and not
> really what the mount busy state is (typically it is still mounted in
> the parent namespace anyway).
>
I think it's a little too soon to try and work out what to do about the

speed of umount, lazy or not.


Umount has taken progressively longer over the years and is in fact quite

slow now. I'm really not sure what to do about that having looked at it a

number of times without joy. Nevertheless, I believe we need to find a way

to do this or something like it to reduce the delays involved in umount.


Ian


