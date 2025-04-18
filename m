Return-Path: <linux-fsdevel+bounces-46649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7BAA92F3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 03:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C701F7A5FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 01:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E46DCE1;
	Fri, 18 Apr 2025 01:22:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F43FFD;
	Fri, 18 Apr 2025 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.200.0.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939344; cv=none; b=p+M//Z1Df/n+Qn/U5JXoa+21qVRDAWyPOq6HnvyWvOWYzlYUPGlYgLXhuep5ZNMMrtjmm4enmudbVM9xLme0YQ0MACgD9CqGdwdMIUJrdCsMNFi/h7+FSBtMUVXBpqWOBivmvwfJVZ7L4ua5amcFGS2w7LWrcA5Ov9QKpp5Dw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939344; c=relaxed/simple;
	bh=tqdjpujWh9eT1DPvIRtng0XSOuW2qpLpGXDKjSIuz8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCWxIk5Vh40CrHvmIqcT6s9T6YOOrTAXxj0M3B8JOhADt7HvjqJquBcZwAP7Pfjsws4vNY1bvpHDlgzGZIQsmaiND27GuhuieF2QqKOxJd5NpD/JMCgmDWxhvlj5Z/jpT4AayppFibELH+yESUzP4mwBIA0cksNIviUPWKZTEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=fail smtp.mailfrom=themaw.net; arc=none smtp.client-ip=121.200.0.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=themaw.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id CFDA71012A3;
	Fri, 18 Apr 2025 11:20:56 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FVhM7wj2tSqa; Fri, 18 Apr 2025 11:20:56 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id C0A7910129B; Fri, 18 Apr 2025 11:20:56 +1000 (AEST)
X-Spam-Level: 
Received: from [192.168.0.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id D167F101149;
	Fri, 18 Apr 2025 11:20:53 +1000 (AEST)
Message-ID: <125df195-5cac-4a65-b8bb-8b1146132667@themaw.net>
Date: Fri, 18 Apr 2025 09:20:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>,
 Aishwarya.TCV@arm.com
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
 <20250417-zappeln-angesagt-f172a71839d3@brauner>
 <20250417153126.QrVXSjt-@linutronix.de>
 <20250417-pyrotechnik-neigung-f4a727a5c76b@brauner>
 <39c36187-615e-4f83-b05e-419015d885e6@themaw.net>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <39c36187-615e-4f83-b05e-419015d885e6@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/4/25 09:13, Ian Kent wrote:
>
> On 18/4/25 00:28, Christian Brauner wrote:
>> On Thu, Apr 17, 2025 at 05:31:26PM +0200, Sebastian Andrzej Siewior 
>> wrote:
>>> On 2025-04-17 17:28:20 [+0200], Christian Brauner wrote:
>>>>>      So if there's some userspace process with a broken NFS server 
>>>>> and it
>>>>>      does umount(MNT_DETACH) it will end up hanging every other
>>>>>      umount(MNT_DETACH) on the system because the dealyed_mntput_work
>>>>>      workqueue (to my understanding) cannot make progress.
>>>> Ok, "to my understanding" has been updated after going back and 
>>>> reading
>>>> the delayed work code. Luckily it's not as bad as I thought it is
>>>> because it's queued on system_wq which is multi-threaded so it's at
>>>> least not causing everyone with MNT_DETACH to get stuck. I'm still
>>>> skeptical how safe this all is.
>>> I would (again) throw system_unbound_wq into the game because the 
>>> former
>>> will remain on the CPU on which has been enqueued (if speaking about
>>> multi threading).
>> Yes, good point.
>>
>> However, what about using polled grace periods?
>>
>> A first simple-minded thing to do would be to record the grace period
>> after umount_tree() has finished and the check it in namespace_unlock():
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index d9ca80dcc544..1e7ebcdd1ebc 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -77,6 +77,7 @@ static struct hlist_head *mount_hashtable 
>> __ro_after_init;
>>   static struct hlist_head *mountpoint_hashtable __ro_after_init;
>>   static struct kmem_cache *mnt_cache __ro_after_init;
>>   static DECLARE_RWSEM(namespace_sem);
>> +static unsigned long rcu_unmount_seq; /* protected by namespace_sem */
>>   static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
>>   static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>>   static DEFINE_SEQLOCK(mnt_ns_tree_lock);
>> @@ -1794,6 +1795,7 @@ static void namespace_unlock(void)
>>          struct hlist_head head;
>>          struct hlist_node *p;
>>          struct mount *m;
>> +       unsigned long unmount_seq = rcu_unmount_seq;
>>          LIST_HEAD(list);
>>
>>          hlist_move_list(&unmounted, &head);
>> @@ -1817,7 +1819,7 @@ static void namespace_unlock(void)
>>          if (likely(hlist_empty(&head)))
>>                  return;
>>
>> -       synchronize_rcu_expedited();
>> +       cond_synchronize_rcu_expedited(unmount_seq);
>>
>>          hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>>                  hlist_del(&m->mnt_umount);
>> @@ -1939,6 +1941,8 @@ static void umount_tree(struct mount *mnt, enum 
>> umount_tree_flags how)
>>                   */
>>                  mnt_notify_add(p);
>>          }
>> +
>> +       rcu_unmount_seq = get_state_synchronize_rcu();
>>   }
>>
>>   static void shrink_submounts(struct mount *mnt);
>>
>>
>> I'm not sure how much that would buy us. If it doesn't then it should be
>> possible to play with the following possibly strange idea:
>>
>> diff --git a/fs/mount.h b/fs/mount.h
>> index 7aecf2a60472..51b86300dc50 100644
>> --- a/fs/mount.h
>> +++ b/fs/mount.h
>> @@ -61,6 +61,7 @@ struct mount {
>>                  struct rb_node mnt_node; /* node in the ns->mounts 
>> rbtree */
>>                  struct rcu_head mnt_rcu;
>>                  struct llist_node mnt_llist;
>> +               unsigned long mnt_rcu_unmount_seq;
>>          };
>>   #ifdef CONFIG_SMP
>>          struct mnt_pcp __percpu *mnt_pcp;
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index d9ca80dcc544..aae9df75beed 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -1794,6 +1794,7 @@ static void namespace_unlock(void)
>>          struct hlist_head head;
>>          struct hlist_node *p;
>>          struct mount *m;
>> +       bool needs_synchronize_rcu = false;
>>          LIST_HEAD(list);
>>
>>          hlist_move_list(&unmounted, &head);
>> @@ -1817,7 +1818,16 @@ static void namespace_unlock(void)
>>          if (likely(hlist_empty(&head)))
>>                  return;
>>
>> -       synchronize_rcu_expedited();
>> +       hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>> +               if (!poll_state_synchronize_rcu(m->mnt_rcu_unmount_seq))
>> +                       continue;
>> +
>> +               needs_synchronize_rcu = true;
>> +               break;
>> +       }
>> +
>> +       if (needs_synchronize_rcu)
>> +               synchronize_rcu_expedited();
>>
>>          hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>>                  hlist_del(&m->mnt_umount);
>> @@ -1923,8 +1933,10 @@ static void umount_tree(struct mount *mnt, 
>> enum umount_tree_flags how)
>>                          }
>>                  }
>>                  change_mnt_propagation(p, MS_PRIVATE);
>> -               if (disconnect)
>> +               if (disconnect) {
>> +                       p->mnt_rcu_unmount_seq = 
>> get_state_synchronize_rcu();
>>                          hlist_add_head(&p->mnt_umount, &unmounted);
>> +               }
>>
>>                  /*
>>                   * At this point p->mnt_ns is NULL, notification 
>> will be queued
>>
>> This would allow to elide synchronize rcu calls if they elapsed in the
>> meantime since we moved that mount to the unmounted list.
>
> This last patch is a much better way to do this IMHO.
>
> The approach is so much more like many other places we have "rcu check 
> before use" type code.

If there are several thousand mounts in the discard list having two 
loops could end up a bit slow.

I wonder if we could combine the two loops into one ... I'll think about 
that.


>
> Ian
>
>

