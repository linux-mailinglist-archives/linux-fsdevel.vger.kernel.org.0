Return-Path: <linux-fsdevel+bounces-46708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2899AA940D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 03:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527B28A5722
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 01:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79B156677;
	Sat, 19 Apr 2025 01:24:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E41448F2;
	Sat, 19 Apr 2025 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.200.0.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745025882; cv=none; b=D3OggGmHx2o+EvpGaatJaROTNrvn/XLEYso54avbsgiKB696E1NnhMJQDC/T89A4SNzXNdDyp+6gZdJ/xRVUfKrmeJWeEFofwe47+akEf9bGU4J67H798h/D4YjJc11RQhTmfJAKIWlngUQeDm+QbWGgUXOLnFqfq/LATkQtPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745025882; c=relaxed/simple;
	bh=v9SMrehymawYp0ubOq9iqBH0rzCv62uomeBcGhwrVQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhfHtBHq//CSGRbz6Q3uPdBo/tfMSEXngpYd+IvAm1tFtvj3mInG7HbuUKZs/UywlcsG/9HkPSjaaRcq8vin0SCqtyMwUDBbf7ri44u5kMWW+U3NP0dDNWq9Z1zDwXYl8f3TvRrJHsLA3TPqT8Vz3jsw3SmbaBJQAfD6qM2D7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=fail smtp.mailfrom=themaw.net; arc=none smtp.client-ip=121.200.0.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=themaw.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 65687100767;
	Sat, 19 Apr 2025 11:24:37 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sEONb8hvuJih; Sat, 19 Apr 2025 11:24:37 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 60CEE10070C; Sat, 19 Apr 2025 11:24:35 +1000 (AEST)
X-Spam-Level: 
Received: from [192.168.0.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id B4B3B10070C;
	Sat, 19 Apr 2025 11:24:32 +1000 (AEST)
Message-ID: <834853f4-10ca-4585-84b2-425c4e9f7d2b@themaw.net>
Date: Sat, 19 Apr 2025 09:24:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>,
 Aishwarya.TCV@arm.com
References: <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
 <20250417-zappeln-angesagt-f172a71839d3@brauner>
 <20250417153126.QrVXSjt-@linutronix.de>
 <20250417-pyrotechnik-neigung-f4a727a5c76b@brauner>
 <39c36187-615e-4f83-b05e-419015d885e6@themaw.net>
 <125df195-5cac-4a65-b8bb-8b1146132667@themaw.net>
 <20250418-razzia-fixkosten-0569cf9f7b9d@brauner>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <20250418-razzia-fixkosten-0569cf9f7b9d@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18/4/25 16:47, Christian Brauner wrote:
> On Fri, Apr 18, 2025 at 09:20:52AM +0800, Ian Kent wrote:
>> On 18/4/25 09:13, Ian Kent wrote:
>>> On 18/4/25 00:28, Christian Brauner wrote:
>>>> On Thu, Apr 17, 2025 at 05:31:26PM +0200, Sebastian Andrzej Siewior
>>>> wrote:
>>>>> On 2025-04-17 17:28:20 [+0200], Christian Brauner wrote:
>>>>>>>       So if there's some userspace process with a broken
>>>>>>> NFS server and it
>>>>>>>       does umount(MNT_DETACH) it will end up hanging every other
>>>>>>>       umount(MNT_DETACH) on the system because the dealyed_mntput_work
>>>>>>>       workqueue (to my understanding) cannot make progress.
>>>>>> Ok, "to my understanding" has been updated after going back
>>>>>> and reading
>>>>>> the delayed work code. Luckily it's not as bad as I thought it is
>>>>>> because it's queued on system_wq which is multi-threaded so it's at
>>>>>> least not causing everyone with MNT_DETACH to get stuck. I'm still
>>>>>> skeptical how safe this all is.
>>>>> I would (again) throw system_unbound_wq into the game because
>>>>> the former
>>>>> will remain on the CPU on which has been enqueued (if speaking about
>>>>> multi threading).
>>>> Yes, good point.
>>>>
>>>> However, what about using polled grace periods?
>>>>
>>>> A first simple-minded thing to do would be to record the grace period
>>>> after umount_tree() has finished and the check it in namespace_unlock():
>>>>
>>>> diff --git a/fs/namespace.c b/fs/namespace.c
>>>> index d9ca80dcc544..1e7ebcdd1ebc 100644
>>>> --- a/fs/namespace.c
>>>> +++ b/fs/namespace.c
>>>> @@ -77,6 +77,7 @@ static struct hlist_head *mount_hashtable
>>>> __ro_after_init;
>>>>    static struct hlist_head *mountpoint_hashtable __ro_after_init;
>>>>    static struct kmem_cache *mnt_cache __ro_after_init;
>>>>    static DECLARE_RWSEM(namespace_sem);
>>>> +static unsigned long rcu_unmount_seq; /* protected by namespace_sem */
>>>>    static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
>>>>    static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>>>>    static DEFINE_SEQLOCK(mnt_ns_tree_lock);
>>>> @@ -1794,6 +1795,7 @@ static void namespace_unlock(void)
>>>>           struct hlist_head head;
>>>>           struct hlist_node *p;
>>>>           struct mount *m;
>>>> +       unsigned long unmount_seq = rcu_unmount_seq;
>>>>           LIST_HEAD(list);
>>>>
>>>>           hlist_move_list(&unmounted, &head);
>>>> @@ -1817,7 +1819,7 @@ static void namespace_unlock(void)
>>>>           if (likely(hlist_empty(&head)))
>>>>                   return;
>>>>
>>>> -       synchronize_rcu_expedited();
>>>> +       cond_synchronize_rcu_expedited(unmount_seq);
>>>>
>>>>           hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>>>>                   hlist_del(&m->mnt_umount);
>>>> @@ -1939,6 +1941,8 @@ static void umount_tree(struct mount *mnt,
>>>> enum umount_tree_flags how)
>>>>                    */
>>>>                   mnt_notify_add(p);
>>>>           }
>>>> +
>>>> +       rcu_unmount_seq = get_state_synchronize_rcu();
>>>>    }
>>>>
>>>>    static void shrink_submounts(struct mount *mnt);
>>>>
>>>>
>>>> I'm not sure how much that would buy us. If it doesn't then it should be
>>>> possible to play with the following possibly strange idea:
>>>>
>>>> diff --git a/fs/mount.h b/fs/mount.h
>>>> index 7aecf2a60472..51b86300dc50 100644
>>>> --- a/fs/mount.h
>>>> +++ b/fs/mount.h
>>>> @@ -61,6 +61,7 @@ struct mount {
>>>>                   struct rb_node mnt_node; /* node in the ns->mounts
>>>> rbtree */
>>>>                   struct rcu_head mnt_rcu;
>>>>                   struct llist_node mnt_llist;
>>>> +               unsigned long mnt_rcu_unmount_seq;
>>>>           };
>>>>    #ifdef CONFIG_SMP
>>>>           struct mnt_pcp __percpu *mnt_pcp;
>>>> diff --git a/fs/namespace.c b/fs/namespace.c
>>>> index d9ca80dcc544..aae9df75beed 100644
>>>> --- a/fs/namespace.c
>>>> +++ b/fs/namespace.c
>>>> @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
>>>>           struct hlist_head head;
>>>>           struct hlist_node *p;
>>>>           struct mount *m;
>>>> +       bool needs_synchronize_rcu = false;
>>>>           LIST_HEAD(list);
>>>>
>>>>           hlist_move_list(&unmounted, &head);
>>>> @@ -1817,7 +1818,16 @@ static void namespace_unlock(void)
>>>>           if (likely(hlist_empty(&head)))
>>>>                   return;
>>>>
>>>> -       synchronize_rcu_expedited();
>>>> +       hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>>>> +               if (!poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
>>>> +                       continue;
> This has a bug. This needs to be:
>
> 	/* A grace period has already elapsed. */
> 	if (poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
> 		continue;
>
> 	/* Oh oh, we have to pay up. */
> 	needs_synchronize_rcu = true;
> 	break;
>
> which I'm pretty sure will eradicate most of the performance gain you've
> seen because fundamentally the two version shouldn't be different (Note,
> I drafted this while on my way out the door. r.
>
> I would test the following version where we pay the cost of the
> smb_mb() from poll_state_synchronize_rcu() exactly one time:
>
> diff --git a/fs/mount.h b/fs/mount.h
> index 7aecf2a60472..51b86300dc50 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -61,6 +61,7 @@ struct mount {
>                  struct rb_node mnt_node; /* node in the ns->mounts rbtree */
>                  struct rcu_head mnt_rcu;
>                  struct llist_node mnt_llist;
> +               unsigned long mnt_rcu_unmount_seq;
>          };
>   #ifdef CONFIG_SMP
>          struct mnt_pcp __percpu *mnt_pcp;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d9ca80dcc544..dd367c54bc29 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
>          struct hlist_head head;
>          struct hlist_node *p;
>          struct mount *m;
> +       unsigned long mnt_rcu_unmount_seq = 0;
>          LIST_HEAD(list);
>
>          hlist_move_list(&unmounted, &head);
> @@ -1817,7 +1818,10 @@ static void namespace_unlock(void)
>          if (likely(hlist_empty(&head)))
>                  return;
>
> -       synchronize_rcu_expedited();
> +       hlist_for_each_entry_safe(m, p, &head, mnt_umount)
> +               mnt_rcu_unmount_seq = max(m->mnt_rcu_unmount_seq, mnt_rcu_unmount_seq);
> +
> +       cond_synchronize_rcu_expedited(mnt_rcu_unmount_seq);
>
>          hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>                  hlist_del(&m->mnt_umount);
> @@ -1923,8 +1927,10 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>                          }
>                  }
>                  change_mnt_propagation(p, MS_PRIVATE);
> -               if (disconnect)
> +               if (disconnect) {
> +                       p->mnt_rcu_unmount_seq = get_state_synchronize_rcu();
>                          hlist_add_head(&p->mnt_umount, &unmounted);
> +               }
>
>                  /*
>                   * At this point p->mnt_ns is NULL, notification will be queued
>
> If this doesn't help I had considered recording the rcu sequence number
> during __legitimize_mnt() in the mounts. But we likely can't do that
> because get_state_synchronize_rcu() is expensive because it inserts a
> smb_mb() and that would likely be noticable during path lookup. This
> would also hinge on the notion that the last store of the rcu sequence
> number is guaranteed to be seen when we check them in namespace_unlock().
>
> Another possibly insane idea (haven't fully thought it out but throwing
> it out there to test): allocate a percpu counter for each mount and
> increment it each time we enter __legitimize_mnt() and decrement it when
> we leave __legitimize_mnt(). During umount_tree() check the percpu sum
> for each mount after it's been added to the @unmounted list.

I had been thinking that a completion in the mount with a counter (say

walker_cnt) could be used. Because the mounts are unhashed there won't

be new walks so if/once the count is 0 the walker could call complete()

and wait_for_completion() replaces the rcu sync completely. The catch is

managing walker_cnt correctly could be racy or expensive.


I thought this would not be received to well dew to the additional fields

and it could be a little messy but the suggestion above is a bit similar.


Ian

>
> If we see any mount that has a non-zero count we set a global
> @needs_synchronize_rcu to true and stop counting for the other mounts
> (saving percpu summing cycles). Then call or elide
> synchronize_rcu_expedited() based on the @needs_synchronize_rcu boolean
> in namespace_unlock().
>
> The percpu might make this cheap enough for __legitimize_mnt() to be
> workable (ignoring any other pitfalls I've currently not had time to
> warp my head around).

