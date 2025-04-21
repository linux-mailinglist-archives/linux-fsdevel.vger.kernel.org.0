Return-Path: <linux-fsdevel+bounces-46740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6998FA94A09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 02:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6AC16FB50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 00:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E88A933;
	Mon, 21 Apr 2025 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aU34iML0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241A4C8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745194359; cv=none; b=riTl2gngm974cvUOwrnhi+qLd0m4E6PsLY6W4VAB8iuEobTyFcB8bag2YSAnMBw8l3qZOVTnymUmDMPbVtcFQ6qr/VCmZwJG6JXvC3wZnIK1FIOFTOdk2/wBRqo8+gNW3gYTMZzJOAG4SB2SvUunEh/9AWguKxmOp565ab2AIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745194359; c=relaxed/simple;
	bh=5BmW6C0AA8YBlma21zW+oRK2V1ZkuXT2V6dxTFNhh9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgQSiF4DeDDaenvyFENMt6foyXaburVsIDJdkWt5nmzL2FHVnqt8A9vHa8lMRao6CeH5PsnXZy5w+QtJQjHQMwBZ98JACTP8bBgdMLaNT1MsJAhplk43M+jtGmopLQNP6JrFqeZ5riWLX5XrooMkcKhy0E6iwYwR211h5iQSAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aU34iML0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745194355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cDRWt0N8Jojs7xR99g6PjwmQu89MnT4dx6MNdQxu5Z8=;
	b=aU34iML0FHe47W2x1FrvCaoddImarBy4MH/gqqHzSFpN+Ov+r/HjQYrFn+wDcq3I35aMkL
	Wyfzy6ct1r1v7W+53YPeJqj19tEdQ+YpNdBuFZR5ZEUH5eIiKqc2cHHEAGokbJx1YrfmhK
	1jfZEzTK5QPdfHFCjF0d80w3Q3/mkaM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-Xm7gsXIZMSyvJr2lMn0uDw-1; Sun, 20 Apr 2025 20:12:34 -0400
X-MC-Unique: Xm7gsXIZMSyvJr2lMn0uDw-1
X-Mimecast-MFC-AGG-ID: Xm7gsXIZMSyvJr2lMn0uDw_1745194353
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af547d725e8so1332687a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Apr 2025 17:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745194353; x=1745799153;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDRWt0N8Jojs7xR99g6PjwmQu89MnT4dx6MNdQxu5Z8=;
        b=ifxll4zy6gsU+dUkeE+3q9V4tyhu6W7XdG0osUWJEpqlXOPy5yAXCG5Dh2lbogmeG+
         F2jeVeY/Ih/tXY7rAUHmvrNsJOPJAQa5ICiRzmIUkCL+GEon6ojo+2O/QQMi7zqTBXrj
         qPgaZePgwPCmLmfN23fhlGgAFZLO0SNzbLFDuExNK1gJn8IFXKw+VxJOggXh7SiQ2v2E
         cVSwOMT2rProD5h3dEYZ80qLytH1GTkOC2F0sv8ehrA6WbNfzgibjh63DtlGuKMJSUoP
         mGJH4uzdzOqVQP/8Ihyf44yn5+HfP+5SDfC7lwg65xfeO/IOXTeUxGaVjeQNq+qnR3co
         ettA==
X-Forwarded-Encrypted: i=1; AJvYcCXHo8aOb7aooo2ronI5svY5454ksW5Da7QGIE4p07TwYjieZUZS8nIRbsDixVM3omIO+/iAAuUhi+d0ERS8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3Caq45RSxJ8zMjwIXK29WB6BwGUDaUUBHoL+SfNihXj5/QQk
	1/FBfBgsX+zXoTDfGXmb6hxCYMow6I3q/GIXO/1H2/UZazTQAqL68ud7mjzT7TMrzELTSZnbw9B
	nmJJ35KkGI19SB7OwIIltZdL5R5xCyvu/0EFAAp20IY/XK5uh+mO3cGqhLKOnVOQ=
X-Gm-Gg: ASbGncsUQ7QiCUzJh9l5UOrMGuiwnyFaxiDClCCi1pInwXbPCUptFu3CAxEUg3wlIy2
	qKJvYB/WfWvhZIPABEGsig/qSjhMY4dUVhWFhjN0dd5ffbkZX0lG7hc/LTgdzcXmRCRAZRMEatk
	+tokYA4gPxmYmG+W2IKM+XF4x4pXgYTEg7swvdJ6FPW40QMt8dg3OM2P8a6dSJNBnXjF9jj67C6
	EDXBvKkzxHFt0D2EpD3sQIhrUMk+4tMO6mX0sVhZ5XTP1Awn4qFxUIljRZ8vXGjgRanMM8f0NN4
	QGEo26YOnFp+SvqcNu7UNvO2qc7sYQHlZy8wstKeTwvpgbXbZlBlw3ZjFsXPPk7T
X-Received: by 2002:a05:6a20:c91c:b0:201:4061:bd94 with SMTP id adf61e73a8af0-203cbc72b32mr13711667637.19.1745194353189;
        Sun, 20 Apr 2025 17:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiroN1mpv51Y2MDk73IrnEgosSCJ0vBsIuPX736CaF9Tk6VWd3chpBRHhtGbrKkDYHbYg4bg==
X-Received: by 2002:a05:6a20:c91c:b0:201:4061:bd94 with SMTP id adf61e73a8af0-203cbc72b32mr13711653637.19.1745194352768;
        Sun, 20 Apr 2025 17:12:32 -0700 (PDT)
Received: from [192.168.0.229] (159-196-82-144.9fc452.per.static.aussiebb.net. [159.196.82.144])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db157c739sm4583967a12.74.2025.04.20.17.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Apr 2025 17:12:32 -0700 (PDT)
Message-ID: <95fc6b43-4e33-4e3f-932f-254ec3734f8c@redhat.com>
Date: Mon, 21 Apr 2025 08:12:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Alexander Larsson <alexl@redhat.com>,
 Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
References: <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
 <20250417-zappeln-angesagt-f172a71839d3@brauner>
 <20250417153126.QrVXSjt-@linutronix.de>
 <20250417-pyrotechnik-neigung-f4a727a5c76b@brauner>
 <39c36187-615e-4f83-b05e-419015d885e6@themaw.net>
 <125df195-5cac-4a65-b8bb-8b1146132667@themaw.net>
 <20250418-razzia-fixkosten-0569cf9f7b9d@brauner>
 <834853f4-10ca-4585-84b2-425c4e9f7d2b@themaw.net>
 <20250419-auftrag-knipsen-6e56b0ccd267@brauner>
 <20250419-floskel-aufmachen-26e327d7334e@brauner>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <20250419-floskel-aufmachen-26e327d7334e@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/4/25 21:26, Christian Brauner wrote:
> On Sat, Apr 19, 2025 at 12:44:18PM +0200, Christian Brauner wrote:
>> On Sat, Apr 19, 2025 at 09:24:31AM +0800, Ian Kent wrote:
>>> On 18/4/25 16:47, Christian Brauner wrote:
>>>> On Fri, Apr 18, 2025 at 09:20:52AM +0800, Ian Kent wrote:
>>>>> On 18/4/25 09:13, Ian Kent wrote:
>>>>>> On 18/4/25 00:28, Christian Brauner wrote:
>>>>>>> On Thu, Apr 17, 2025 at 05:31:26PM +0200, Sebastian Andrzej Siewior
>>>>>>> wrote:
>>>>>>>> On 2025-04-17 17:28:20 [+0200], Christian Brauner wrote:
>>>>>>>>>>        So if there's some userspace process with a broken
>>>>>>>>>> NFS server and it
>>>>>>>>>>        does umount(MNT_DETACH) it will end up hanging every other
>>>>>>>>>>        umount(MNT_DETACH) on the system because the dealyed_mntput_work
>>>>>>>>>>        workqueue (to my understanding) cannot make progress.
>>>>>>>>> Ok, "to my understanding" has been updated after going back
>>>>>>>>> and reading
>>>>>>>>> the delayed work code. Luckily it's not as bad as I thought it is
>>>>>>>>> because it's queued on system_wq which is multi-threaded so it's at
>>>>>>>>> least not causing everyone with MNT_DETACH to get stuck. I'm still
>>>>>>>>> skeptical how safe this all is.
>>>>>>>> I would (again) throw system_unbound_wq into the game because
>>>>>>>> the former
>>>>>>>> will remain on the CPU on which has been enqueued (if speaking about
>>>>>>>> multi threading).
>>>>>>> Yes, good point.
>>>>>>>
>>>>>>> However, what about using polled grace periods?
>>>>>>>
>>>>>>> A first simple-minded thing to do would be to record the grace period
>>>>>>> after umount_tree() has finished and the check it in namespace_unlock():
>>>>>>>
>>>>>>> diff --git a/fs/namespace.c b/fs/namespace.c
>>>>>>> index d9ca80dcc544..1e7ebcdd1ebc 100644
>>>>>>> --- a/fs/namespace.c
>>>>>>> +++ b/fs/namespace.c
>>>>>>> @@ -77,6 +77,7 @@ static struct hlist_head *mount_hashtable
>>>>>>> __ro_after_init;
>>>>>>>     static struct hlist_head *mountpoint_hashtable __ro_after_init;
>>>>>>>     static struct kmem_cache *mnt_cache __ro_after_init;
>>>>>>>     static DECLARE_RWSEM(namespace_sem);
>>>>>>> +static unsigned long rcu_unmount_seq; /* protected by namespace_sem */
>>>>>>>     static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
>>>>>>>     static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>>>>>>>     static DEFINE_SEQLOCK(mnt_ns_tree_lock);
>>>>>>> @@ -1794,6 +1795,7 @@ static void namespace_unlock(void)
>>>>>>>            struct hlist_head head;
>>>>>>>            struct hlist_node *p;
>>>>>>>            struct mount *m;
>>>>>>> +       unsigned long unmount_seq = rcu_unmount_seq;
>>>>>>>            LIST_HEAD(list);
>>>>>>>
>>>>>>>            hlist_move_list(&unmounted, &head);
>>>>>>> @@ -1817,7 +1819,7 @@ static void namespace_unlock(void)
>>>>>>>            if (likely(hlist_empty(&head)))
>>>>>>>                    return;
>>>>>>>
>>>>>>> -       synchronize_rcu_expedited();
>>>>>>> +       cond_synchronize_rcu_expedited(unmount_seq);
>>>>>>>
>>>>>>>            hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>>>>>>>                    hlist_del(&m->mnt_umount);
>>>>>>> @@ -1939,6 +1941,8 @@ static void umount_tree(struct mount *mnt,
>>>>>>> enum umount_tree_flags how)
>>>>>>>                     */
>>>>>>>                    mnt_notify_add(p);
>>>>>>>            }
>>>>>>> +
>>>>>>> +       rcu_unmount_seq = get_state_synchronize_rcu();
>>>>>>>     }
>>>>>>>
>>>>>>>     static void shrink_submounts(struct mount *mnt);
>>>>>>>
>>>>>>>
>>>>>>> I'm not sure how much that would buy us. If it doesn't then it should be
>>>>>>> possible to play with the following possibly strange idea:
>>>>>>>
>>>>>>> diff --git a/fs/mount.h b/fs/mount.h
>>>>>>> index 7aecf2a60472..51b86300dc50 100644
>>>>>>> --- a/fs/mount.h
>>>>>>> +++ b/fs/mount.h
>>>>>>> @@ -61,6 +61,7 @@ struct mount {
>>>>>>>                    struct rb_node mnt_node; /* node in the ns->mounts
>>>>>>> rbtree */
>>>>>>>                    struct rcu_head mnt_rcu;
>>>>>>>                    struct llist_node mnt_llist;
>>>>>>> +               unsigned long mnt_rcu_unmount_seq;
>>>>>>>            };
>>>>>>>     #ifdef CONFIG_SMP
>>>>>>>            struct mnt_pcp __percpu *mnt_pcp;
>>>>>>> diff --git a/fs/namespace.c b/fs/namespace.c
>>>>>>> index d9ca80dcc544..aae9df75beed 100644
>>>>>>> --- a/fs/namespace.c
>>>>>>> +++ b/fs/namespace.c
>>>>>>> @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
>>>>>>>            struct hlist_head head;
>>>>>>>            struct hlist_node *p;
>>>>>>>            struct mount *m;
>>>>>>> +       bool needs_synchronize_rcu = false;
>>>>>>>            LIST_HEAD(list);
>>>>>>>
>>>>>>>            hlist_move_list(&unmounted, &head);
>>>>>>> @@ -1817,7 +1818,16 @@ static void namespace_unlock(void)
>>>>>>>            if (likely(hlist_empty(&head)))
>>>>>>>                    return;
>>>>>>>
>>>>>>> -       synchronize_rcu_expedited();
>>>>>>> +       hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>>>>>>> +               if (!poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
>>>>>>> +                       continue;
>>>> This has a bug. This needs to be:
>>>>
>>>> 	/* A grace period has already elapsed. */
>>>> 	if (poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
>>>> 		continue;
>>>>
>>>> 	/* Oh oh, we have to pay up. */
>>>> 	needs_synchronize_rcu = true;
>>>> 	break;
>>>>
>>>> which I'm pretty sure will eradicate most of the performance gain you've
>>>> seen because fundamentally the two version shouldn't be different (Note,
>>>> I drafted this while on my way out the door. r.
>>>>
>>>> I would test the following version where we pay the cost of the
>>>> smb_mb() from poll_state_synchronize_rcu() exactly one time:
>>>>
>>>> diff --git a/fs/mount.h b/fs/mount.h
>>>> index 7aecf2a60472..51b86300dc50 100644
>>>> --- a/fs/mount.h
>>>> +++ b/fs/mount.h
>>>> @@ -61,6 +61,7 @@ struct mount {
>>>>                   struct rb_node mnt_node; /* node in the ns->mounts rbtree */
>>>>                   struct rcu_head mnt_rcu;
>>>>                   struct llist_node mnt_llist;
>>>> +               unsigned long mnt_rcu_unmount_seq;
>>>>           };
>>>>    #ifdef CONFIG_SMP
>>>>           struct mnt_pcp __percpu *mnt_pcp;
>>>> diff --git a/fs/namespace.c b/fs/namespace.c
>>>> index d9ca80dcc544..dd367c54bc29 100644
>>>> --- a/fs/namespace.c
>>>> +++ b/fs/namespace.c
>>>> @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
>>>>           struct hlist_head head;
>>>>           struct hlist_node *p;
>>>>           struct mount *m;
>>>> +       unsigned long mnt_rcu_unmount_seq = 0;
>>>>           LIST_HEAD(list);
>>>>
>>>>           hlist_move_list(&unmounted, &head);
>>>> @@ -1817,7 +1818,10 @@ static void namespace_unlock(void)
>>>>           if (likely(hlist_empty(&head)))
>>>>                   return;
>>>>
>>>> -       synchronize_rcu_expedited();
>>>> +       hlist_for_each_entry_safe(m, p, &head, mnt_umount)
>>>> +               mnt_rcu_unmount_seq = max(m->mnt_rcu_unmount_seq, mnt_rcu_unmount_seq);
>>>> +
>>>> +       cond_synchronize_rcu_expedited(mnt_rcu_unmount_seq);
>>>>
>>>>           hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>>>>                   hlist_del(&m->mnt_umount);
>>>> @@ -1923,8 +1927,10 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>>>>                           }
>>>>                   }
>>>>                   change_mnt_propagation(p, MS_PRIVATE);
>>>> -               if (disconnect)
>>>> +               if (disconnect) {
>>>> +                       p->mnt_rcu_unmount_seq = get_state_synchronize_rcu();
>>>>                           hlist_add_head(&p->mnt_umount, &unmounted);
>>>> +               }
>>>>
>>>>                   /*
>>>>                    * At this point p->mnt_ns is NULL, notification will be queued
>>>>
>>>> If this doesn't help I had considered recording the rcu sequence number
>>>> during __legitimize_mnt() in the mounts. But we likely can't do that
>>>> because get_state_synchronize_rcu() is expensive because it inserts a
>>>> smb_mb() and that would likely be noticable during path lookup. This
>>>> would also hinge on the notion that the last store of the rcu sequence
>>>> number is guaranteed to be seen when we check them in namespace_unlock().
>>>>
>>>> Another possibly insane idea (haven't fully thought it out but throwing
>>>> it out there to test): allocate a percpu counter for each mount and
>>>> increment it each time we enter __legitimize_mnt() and decrement it when
>>>> we leave __legitimize_mnt(). During umount_tree() check the percpu sum
>>>> for each mount after it's been added to the @unmounted list.
>>> I had been thinking that a completion in the mount with a counter (say
>>>
>>> walker_cnt) could be used. Because the mounts are unhashed there won't
>>>
>>> be new walks so if/once the count is 0 the walker could call complete()
>>>
>>> and wait_for_completion() replaces the rcu sync completely. The catch is
>>>
>>> managing walker_cnt correctly could be racy or expensive.
>>>
>>>
>>> I thought this would not be received to well dew to the additional fields
>> Path walking absolutely has to be as fast as possible, unmounting
>> doesn't. Anything that writes to a shared field from e.g.,
>> __legitimize_mnt() will cause cacheline pingpong and will very likely be
>> noticable. And people care about even slight decreases in performances
>> there. That's why we have the percpu counter and why I didn't even
>> consider something like the completion stuff.
> My wider problem with this whole patchset is that I didn't appreciate
> that we incur this complexity for the benefit of RT mostly which makes
> me somewhat resistant to this change. Especially anything that has
> noticable costs for path lookup.
>
> I drafted my insane idea using percpu legitimize counts so we don't have
> to do that ugly queue_rcu_work() stuff. I did it and then I realized how
> terrible it is. It's going to be horrible managing the additional logic
> correctly because we add another synchronization mechanism to elide the
> rcu grace period via mnt->mnt_pcp->mnt_legitimizers.
>
> One issue is of course that we need to guarantee that someone will
> always put the last reference.
>
> Another is that the any scheme that elides the grace period in
> namespace_unlock() will also mess up the fastpath in mntput_no_expire()
> such that we either have to take lock_mount_hash() on each
> mntput_no_expire() which is definitely a no-no or we have to come up
> with an elaborate scheme where we do a read_seqbegin() and
> read_seqcount_retry() dance based on mount_lock. Then we still need to
> fallback on lock_mount_hash() if the sequence count has changed. It's
> ugly and it will likely be noticable during RCU lookup.

But the mounts are unhashed before we get to the scu sync, doesn't that

buy us an opportunity for the seqlock dance to be simpler?


Ian

>
> So queue_rcu_work() is still the ugly but likeliest option so far.
>


