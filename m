Return-Path: <linux-fsdevel+bounces-24192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E4F93AFBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 12:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761511C22452
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 10:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8B7155A4F;
	Wed, 24 Jul 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b="DHpLBeOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out.cvt.stuba.sk (smtp-out.cvt.stuba.sk [147.175.1.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17281C6A3;
	Wed, 24 Jul 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.175.1.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816443; cv=none; b=tvJY5B62ocNNEhShyfN5xql2606MGUD8YTvN4Znzz5zmSOXFVS9vMutRuZLIiGEpOnAuVG6EWS5fo8lG8DvzFQl6ynsTzeIVWxR1PT7VBlEXMqFyYK5gDFCaCVM5BV97j5srVtPbfkN4+j+ummCCwXmwUnnX+XSW+IOMkS1S7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816443; c=relaxed/simple;
	bh=lkDBFsgC5lwnola/Td4lgDn6VgBBhWZpBnQeuhlfAQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HT1MnEFi6Xf3iIEsmtm2w2J9/AKjBPEVIuyvkj5xobK4OpXKRqOc7xwbRujVh/IY2vUQkm8Ow9rvPvmVcLp7ylLibPJVn9xarb6/zp41XuU04uqQh4y3kk4R36OqpmMiUP0adNNOms8gNjWoHaYS3lrPebSd8ferhqZRrXjlGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk; spf=pass smtp.mailfrom=stuba.sk; dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b=DHpLBeOP; arc=none smtp.client-ip=147.175.1.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stuba.sk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=stuba.sk;
	s=20180406; h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
	MIME-Version:Date:Message-ID; bh=6VAusIOy61kU0Bw2Dv1hj/C7yoXl/PucLk1GoxmKv1U=
	; t=1721816438; x=1722248438; b=DHpLBeOPR2O8BsfTRwcJoSBywU2uTqfS5PpBFRHIjn/FI
	If7Xxo42lOY1E650eYnUMfWytC1+OdE2JlZRjpKAfMHtpoHZRODoqARDeIOfFpj0hDqnkRST2b/8B
	n+TBJ5BNgObpsw8jSPmQYiGrjpXAnvRiZtRw0dgBJZbV07ms0efT7SCExaprBQrXzXJ6NgrGqUPts
	tTzkE6P57akhljdRWjNlETsXASkfIZpspWFT3v4rZyctYiYYJgzWOlFV9Ainmy7It6vajiRuBbTQI
	ZUcOrgiuziTBTk37PMbIqHOkAB08R5+JhI+iQO+L1vEwuTOLQV/wGi4g7CNlFInzZQ==;
X-STU-Diag: f12344e1a5aa1070 (auth)
Received: from ellyah.uim.fei.stuba.sk ([147.175.106.89])
	by mx1.stuba.sk (Exim4) with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(envelope-from <matus.jokay@stuba.sk>)
	id 1sWZ6j-000000004Qd-3IDA;
	Wed, 24 Jul 2024 12:20:29 +0200
Message-ID: <0972f6a4-ab78-48ba-8a45-3d18fab7bff6@stuba.sk>
Date: Wed, 24 Jul 2024 12:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <20240710.peiDu2aiD1su@digikod.net>
 <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk>
 <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>
 <645268cd-bb8f-4661-bab8-faa827267682@stuba.sk>
 <CAHC9VhRnv0+4PZ9Qs-gFhMxmQc07_wr-_W41T45FztOkzD=__g@mail.gmail.com>
Content-Language: en-US
From: Matus Jokay <matus.jokay@stuba.sk>
In-Reply-To: <CAHC9VhRnv0+4PZ9Qs-gFhMxmQc07_wr-_W41T45FztOkzD=__g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23. 7. 2024 21:48, Paul Moore wrote:
> On Tue, Jul 23, 2024 at 5:27 AM Matus Jokay <matus.jokay@stuba.sk> wrote:
>> On 22. 7. 2024 21:46, Paul Moore wrote:
>>> On Mon, Jul 22, 2024 at 8:30 AM Matus Jokay <matus.jokay@stuba.sk> wrote:
>>>> On 10. 7. 2024 12:40, Mickaël Salaün wrote:
>>>>> On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
>>>>>> The LSM framework has an existing inode_free_security() hook which
>>>>>> is used by LSMs that manage state associated with an inode, but
>>>>>> due to the use of RCU to protect the inode, special care must be
>>>>>> taken to ensure that the LSMs do not fully release the inode state
>>>>>> until it is safe from a RCU perspective.
>>>>>>
>>>>>> This patch implements a new inode_free_security_rcu() implementation
>>>>>> hook which is called when it is safe to free the LSM's internal inode
>>>>>> state.  Unfortunately, this new hook does not have access to the inode
>>>>>> itself as it may already be released, so the existing
>>>>>> inode_free_security() hook is retained for those LSMs which require
>>>>>> access to the inode.
>>>>>>
>>>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>>>>
>>>>> I like this new hook.  It is definitely safer than the current approach.
>>>>>
>>>>> To make it more consistent, I think we should also rename
>>>>> security_inode_free() to security_inode_put() to highlight the fact that
>>>>> LSM implementations should not free potential pointers in this blob
>>>>> because they could still be dereferenced in a path walk.
>>>>>
>>>>>> ---
>>>>>>  include/linux/lsm_hook_defs.h     |  1 +
>>>>>>  security/integrity/ima/ima.h      |  2 +-
>>>>>>  security/integrity/ima/ima_iint.c | 20 ++++++++------------
>>>>>>  security/integrity/ima/ima_main.c |  2 +-
>>>>>>  security/landlock/fs.c            |  9 ++++++---
>>>>>>  security/security.c               | 26 +++++++++++++-------------
>>>>>>  6 files changed, 30 insertions(+), 30 deletions(-)
>>>
>>> ...
>>>
>>>> Sorry for the questions, but for several weeks I can't find answers to two things related to this RFC:
>>>>
>>>> 1) How does this patch close [1]?
>>>>    As Mickaël pointed in [2], "It looks like security_inode_free() is called two times on the same inode."
>>>>    Indeed, it does not seem from the backtrace that it is a case of race between destroy_inode and inode_permission,
>>>>    i.e. referencing the inode in a VFS path walk while destroying it...
>>>>    Please, can anyone tell me how this situation could have happened? Maybe folks from VFS... I added them to the copy.
>>>
>>> The VFS folks can likely provide a better, or perhaps a more correct
>>> answer, but my understanding is that during the path walk the inode is
>>> protected by a RCU lock which allows for multiple threads to access
>>> the inode simultaneously; this could result in some cases where one
>>> thread is destroying the inode while another is accessing it.
>>> Changing this would require changes to the VFS code, and I'm not sure
>>> why you would want to change it anyway, the performance win of using
>>> RCU here is likely significant.
>>>
>>>> 2) Is there a guarantee that inode_free_by_rcu and i_callback will be called within the same RCU grace period?
>>>
>>> I'm not an RCU expert, but I don't believe there are any guarantees
>>> that the inode_free_by_rcu() and the inode's own free routines are
>>> going to be called within the same RCU grace period (not really
>>> applicable as inode_free_by_rcu() isn't called *during* a grace
>>> period, but *after* the grace period of the associated
>>> security_inode_free() call).  However, this patch does not rely on
>>> synchronization between the inode and inode LSM free routine in
>>> inode_free_by_rcu(); the inode_free_by_rcu() function and the new
>>> inode_free_security_rcu() LSM callback does not have a pointer to the
>>> inode, only the inode's LSM blob.  I agree that it is a bit odd, but
>>> freeing the inode and inode's LSM blob independently of each other
>>> should not cause a problem so long as the inode is no longer in use
>>> (hence the RCU callbacks).
>>
>> Paul, many thanks for your answer.
>>
>> I will try to clarify the issue, because fsnotify was a bad example.
>> Here is the related code taken from v10.
>>
>> void security_inode_free(struct inode *inode)
>> {
>>         call_void_hook(inode_free_security, inode);
>>         /*
>>          * The inode may still be referenced in a path walk and
>>          * a call to security_inode_permission() can be made
>>          * after inode_free_security() is called. Ideally, the VFS
>>          * wouldn't do this, but fixing that is a much harder
>>          * job. For now, simply free the i_security via RCU, and
>>          * leave the current inode->i_security pointer intact.
>>          * The inode will be freed after the RCU grace period too.
>>          */
>>         if (inode->i_security)
>>                 call_rcu((struct rcu_head *)inode->i_security,
>>                          inode_free_by_rcu);
>> }
>>
>> void __destroy_inode(struct inode *inode)
>> {
>>         BUG_ON(inode_has_buffers(inode));
>>         inode_detach_wb(inode);
>>         security_inode_free(inode);
>>         fsnotify_inode_delete(inode);
>>         locks_free_lock_context(inode);
>>         if (!inode->i_nlink) {
>>                 WARN_ON(atomic_long_read(&inode->i_sb->s_remove_count) == 0);
>>                 atomic_long_dec(&inode->i_sb->s_remove_count);
>>         }
>>
>> #ifdef CONFIG_FS_POSIX_ACL
>>         if (inode->i_acl && !is_uncached_acl(inode->i_acl))
>>                 posix_acl_release(inode->i_acl);
>>         if (inode->i_default_acl && !is_uncached_acl(inode->i_default_acl))
>>                 posix_acl_release(inode->i_default_acl);
>> #endif
>>         this_cpu_dec(nr_inodes);
>> }
>>
>> static void destroy_inode(struct inode *inode)
>> {
>>         const struct super_operations *ops = inode->i_sb->s_op;
>>
>>         BUG_ON(!list_empty(&inode->i_lru));
>>         __destroy_inode(inode);
>>         if (ops->destroy_inode) {
>>                 ops->destroy_inode(inode);
>>                 if (!ops->free_inode)
>>                         return;
>>         }
>>         inode->free_inode = ops->free_inode;
>>         call_rcu(&inode->i_rcu, i_callback);
>> }
>>
>> Yes, inode_free_by_rcu() is being called after the grace period of the associated
>> security_inode_free(). i_callback() is also called after the grace period, but is it
>> always the same grace period as in the case of inode_free_by_rcu()? If not in general,
>> maybe it could be a problem. Explanation below.
>>
>> If there is a function call leading to the end of the grace period between
>> call_rcu(inode_free_by_rcu) and call_rcu(i_callback) (by reaching a CPU quiescent state
>> or another mechanism?), there will be a small time window, when the inode security
>> context is released, but the inode itself not, because call_rcu(i_callback) was not called
>> yet. So in that case each access to inode security blob leads to UAF.
> 
> While it should be possible for the inode's LSM blob to be free'd
> prior to the inode itself, the RCU callback mechanism provided by
> call_rcu() should ensure that both the LSM's free routine and the
> inode's free routine happen at a point in time after the current RCU
> critical sections have lapsed and the inode is no longer being
It is questionable whether the "current RCU CS" refers to both functions
together, see the diagram below.

> accessed.  The LSM's inode_free_rcu callback can run independent of
> the inode's callback as it doesn't access the inode and if it does
Agree, there are two independent calls as you described.

> happen to run before the inode's RCU callback that should also be okay
> as we are past the original RCU critical sections and the inode should
> no longer be in use.  If the inode is still in use by the time the
I think the inode can be still in use in may_lookup() after the security
RCU callback function, see below.

> LSM's RCU callback is triggered then there is a flaw in the inode
> RCU/locking/synchronization code.
I don't think it is a flaw. It may be the use of the RCU mechanism with
incorrect assumption, that both RCU callbacks belong to the common GP.
> 
> It is also worth mentioning that while this patch shuffles around some
> code at the LSM layer, the basic idea of the LSM using a RCU callback
> to free state associated with an inode is far from new.  While that
> doesn't mean there isn't a problem, we have a few years of experience
> across a large number of systems, that would indicate this isn't a
> problem.
I agree. But history only shows that it is very difficult to achieve this
race. And yes, I agree that we may address this issue when it turns out
to be relevant.

> 
>> For example, see invoking ops->destroy_inode() after call_rcu(inode_free_by_rcu) but
>> *before* call_rcu(i_callback). If destroy_inode() may sleep, can be reached end of the
>> grace period? destroy_inode() is *before* call_rcu(i_callback), therefore simultaneous
>> access to the inode during path lookup may be performed. Note: I use destroy_inode() as
>> *an example* of the idea. I'm not expert at all in fsnotify, posix ACL, VFS in general
>> and RCU, too.
>>
>> In the previous message I only mentioned fsnotify, but it was only as an example.
>> I think that destroy_inode() is a better example of the idea I wanted to express.
>>
>> I repeat that I'm aware that this RFC does not aim to solve this issue. But it can be
>> unpleasant to get another UAF in a production environment.
> 
> I'm open to there being another fix needed, or a change to this fix,
> but I don't believe the problems you are describing are possible.  Of
> course it's very possible that I'm wrong, so if you are aware of an
> issue I would appreciate a concrete example explaining the code path
> and timeline between tasks A and B that would trigger the flaw ... and
> yes, patches are always welcome ;)
> 
Oh patches... Even from the message from Dave it can be seen that the
cooperation of people from VFS and some very good idea of ​​a solution
are needed. Of course, provided that the scheme below was correct.
I would be very happy if someone could explain to me why this cannot be
so!

CPU related to
RCU callbacks            task A                                 task B
==================       =================================      =======================
                         ...
                         __destroy_inode()
                            ...
                            security_inode_free()
                               ...
                               call_rcu(inode_free_by_rcu)
                         ...
                         ops->destroy_inode() // *suppose* may sleep
// end of GP;
// inode *can* be used as
// i_callback does not
// belong to this GP
inode_free_by_rcu()
------------------------------------------------------------------------------------------------------
// start of another GP                                          ...
                         ...                                    rcu_read_lock()
                         call_rcu(i_callback)                   ...
                         ...                                    security_inode_permission() // <-- UAF
                                                                ...
                                                                rcu_read_unlock()
                                                                ...
// end of GP;
// right now inode is not in use anymore
i_callback()

Why is it difficult to achieve this race? The GP (grace period) between
two call_rcu() calls must come to an end. Again, I chose as an example
of this situation destroy_inode() function. But there can be others in
the code path, I really don't know.

I looked at the destroy_inode() functions (kernel v10) and from a quick
look I found overlayfs, which directly calls dput(), see [1].
If it is possible to force printk() to sleep, then it is possible to
consider afs [2] and, under certain circumstances, ext4 [3].
After a deeper analysis, maybe even more.

I think it is difficult to divide the GP exactly as this situation
requires. That's probably why this hasn't appeared yet. Or it is
impossible to achieve it. All the better. But that would require an audit
of the code between our two call_rcu()'s, whether at some point it cannot
come to the end of the GP.

And I agree with the opinion that as long as this type of error has not
yet occurred, we can just play possum. When it comes to the crunch, we
can deal with it more deeply.

[1] https://elixir.bootlin.com/linux/v6.10/source/fs/overlayfs/super.c#L181
[2] https://elixir.bootlin.com/linux/v6.10/source/fs/afs/super.c#L718
[3] https://elixir.bootlin.com/linux/v6.10/source/fs/ext4/super.c#L1448

