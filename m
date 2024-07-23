Return-Path: <linux-fsdevel+bounces-24116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA2E939DCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 11:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495871C21ABD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248FF14F132;
	Tue, 23 Jul 2024 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b="sh3uSmK+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out.cvt.stuba.sk (smtp-out.cvt.stuba.sk [147.175.1.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3804B14E2CC;
	Tue, 23 Jul 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.175.1.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726854; cv=none; b=kFpYd3INnUaUJu2hcRs2GFHRmh/Pm1YVTcBFSAnR0GgRW82fhGZmb5SoKw+yavB0mPfxbUehHQa0OjJCkO0Y/x9C3VVg38A1DtUK0NzOFHT5UQZ7O+xTVqYhNPn3oEIgl1SW5JbfxbJQAz23gH+uWwCYbh94Nugf4TGqE7wudcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726854; c=relaxed/simple;
	bh=dTPOyAwNtVSLz78wrRsPEA3bx+Ml/ub1vghT8wtZXLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bocAu4GN3FGs701WV/2jFb0RFVi4C7sTgnTnZUwccTl40qkjck9Tt80mScZzMTtue0naEEKl2AcBZRlc18rYy5/wZwIv477cIIqDNS+SfXewJqthO+niMCE2UoXO8rFkSEAcrhfu6SCSegon0G1Ko8WonpF2KZAtJpFbHoyscYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk; spf=pass smtp.mailfrom=stuba.sk; dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b=sh3uSmK+; arc=none smtp.client-ip=147.175.1.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stuba.sk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=stuba.sk;
	s=20180406; h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
	MIME-Version:Date:Message-ID; bh=9RpNSy45+X40vq0zxQ5onfv5IhjYZaqj+D9N17xn5u0=
	; t=1721726850; x=1722158850; b=sh3uSmK+OqHY2vf4AJVxOAypo9ZSPOs+IGmR9nwSU/UcQ
	Kp5UrJdQs9DPqYQZSqkFHJ/06ojwzM2sG23GxFiz6P9gFFu0UImSTTYBr9Khk9sMsj7YhDLgyblY2
	zPZVPIRtqZRXp27R5Yq39ScCgmvXt8NzBbrBY/Gg4/EC3SjjpHXW9ybNKdny7NF4tRZVzjY21WQiA
	oeTos/Ef7P98+IVxkSRTIH1ao3Ax5NiGJIbc3YYq1sGmvqCAz52tI03Khb9eeg938xVsjUflMRJn0
	GpzOyErUrQQgM4TABxaLvbWWLQaH3Lr4nkLHhb0Jnm2Np8LJxCCQ4CBT+uvrbcgVxw==;
X-STU-Diag: 182cb9893f02c253 (auth)
Received: from ellyah.uim.fei.stuba.sk ([147.175.106.89])
	by mx1.stuba.sk (Exim4) with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(envelope-from <matus.jokay@stuba.sk>)
	id 1sWBnq-000000005oX-18Z2;
	Tue, 23 Jul 2024 11:27:26 +0200
Message-ID: <645268cd-bb8f-4661-bab8-faa827267682@stuba.sk>
Date: Tue, 23 Jul 2024 11:27:26 +0200
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
Content-Language: en-US
From: Matus Jokay <matus.jokay@stuba.sk>
In-Reply-To: <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22. 7. 2024 21:46, Paul Moore wrote:
> On Mon, Jul 22, 2024 at 8:30 AM Matus Jokay <matus.jokay@stuba.sk> wrote:
>> On 10. 7. 2024 12:40, Mickaël Salaün wrote:
>>> On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
>>>> The LSM framework has an existing inode_free_security() hook which
>>>> is used by LSMs that manage state associated with an inode, but
>>>> due to the use of RCU to protect the inode, special care must be
>>>> taken to ensure that the LSMs do not fully release the inode state
>>>> until it is safe from a RCU perspective.
>>>>
>>>> This patch implements a new inode_free_security_rcu() implementation
>>>> hook which is called when it is safe to free the LSM's internal inode
>>>> state.  Unfortunately, this new hook does not have access to the inode
>>>> itself as it may already be released, so the existing
>>>> inode_free_security() hook is retained for those LSMs which require
>>>> access to the inode.
>>>>
>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>>
>>> I like this new hook.  It is definitely safer than the current approach.
>>>
>>> To make it more consistent, I think we should also rename
>>> security_inode_free() to security_inode_put() to highlight the fact that
>>> LSM implementations should not free potential pointers in this blob
>>> because they could still be dereferenced in a path walk.
>>>
>>>> ---
>>>>  include/linux/lsm_hook_defs.h     |  1 +
>>>>  security/integrity/ima/ima.h      |  2 +-
>>>>  security/integrity/ima/ima_iint.c | 20 ++++++++------------
>>>>  security/integrity/ima/ima_main.c |  2 +-
>>>>  security/landlock/fs.c            |  9 ++++++---
>>>>  security/security.c               | 26 +++++++++++++-------------
>>>>  6 files changed, 30 insertions(+), 30 deletions(-)
> 
> ...
> 
>> Sorry for the questions, but for several weeks I can't find answers to two things related to this RFC:
>>
>> 1) How does this patch close [1]?
>>    As Mickaël pointed in [2], "It looks like security_inode_free() is called two times on the same inode."
>>    Indeed, it does not seem from the backtrace that it is a case of race between destroy_inode and inode_permission,
>>    i.e. referencing the inode in a VFS path walk while destroying it...
>>    Please, can anyone tell me how this situation could have happened? Maybe folks from VFS... I added them to the copy.
> 
> The VFS folks can likely provide a better, or perhaps a more correct
> answer, but my understanding is that during the path walk the inode is
> protected by a RCU lock which allows for multiple threads to access
> the inode simultaneously; this could result in some cases where one
> thread is destroying the inode while another is accessing it.
> Changing this would require changes to the VFS code, and I'm not sure
> why you would want to change it anyway, the performance win of using
> RCU here is likely significant.
> 
>> 2) Is there a guarantee that inode_free_by_rcu and i_callback will be called within the same RCU grace period?
> 
> I'm not an RCU expert, but I don't believe there are any guarantees
> that the inode_free_by_rcu() and the inode's own free routines are
> going to be called within the same RCU grace period (not really
> applicable as inode_free_by_rcu() isn't called *during* a grace
> period, but *after* the grace period of the associated
> security_inode_free() call).  However, this patch does not rely on
> synchronization between the inode and inode LSM free routine in
> inode_free_by_rcu(); the inode_free_by_rcu() function and the new
> inode_free_security_rcu() LSM callback does not have a pointer to the
> inode, only the inode's LSM blob.  I agree that it is a bit odd, but
> freeing the inode and inode's LSM blob independently of each other
> should not cause a problem so long as the inode is no longer in use
> (hence the RCU callbacks).

Paul, many thanks for your answer.

I will try to clarify the issue, because fsnotify was a bad example.
Here is the related code taken from v10.

void security_inode_free(struct inode *inode)
{
	call_void_hook(inode_free_security, inode);
	/*
	 * The inode may still be referenced in a path walk and
	 * a call to security_inode_permission() can be made
	 * after inode_free_security() is called. Ideally, the VFS
	 * wouldn't do this, but fixing that is a much harder
	 * job. For now, simply free the i_security via RCU, and
	 * leave the current inode->i_security pointer intact.
	 * The inode will be freed after the RCU grace period too.
	 */
	if (inode->i_security)
		call_rcu((struct rcu_head *)inode->i_security,
			 inode_free_by_rcu);
}

void __destroy_inode(struct inode *inode)
{
	BUG_ON(inode_has_buffers(inode));
	inode_detach_wb(inode);
	security_inode_free(inode);
	fsnotify_inode_delete(inode);
	locks_free_lock_context(inode);
	if (!inode->i_nlink) {
		WARN_ON(atomic_long_read(&inode->i_sb->s_remove_count) == 0);
		atomic_long_dec(&inode->i_sb->s_remove_count);
	}

#ifdef CONFIG_FS_POSIX_ACL
	if (inode->i_acl && !is_uncached_acl(inode->i_acl))
		posix_acl_release(inode->i_acl);
	if (inode->i_default_acl && !is_uncached_acl(inode->i_default_acl))
		posix_acl_release(inode->i_default_acl);
#endif
	this_cpu_dec(nr_inodes);
}

static void destroy_inode(struct inode *inode)
{
	const struct super_operations *ops = inode->i_sb->s_op;

	BUG_ON(!list_empty(&inode->i_lru));
	__destroy_inode(inode);
	if (ops->destroy_inode) {
		ops->destroy_inode(inode);
		if (!ops->free_inode)
			return;
	}
	inode->free_inode = ops->free_inode;
	call_rcu(&inode->i_rcu, i_callback);
}

Yes, inode_free_by_rcu() is being called after the grace period of the associated
security_inode_free(). i_callback() is also called after the grace period, but is it
always the same grace period as in the case of inode_free_by_rcu()? If not in general,
maybe it could be a problem. Explanation below.

If there is a function call leading to the end of the grace period between
call_rcu(inode_free_by_rcu) and call_rcu(i_callback) (by reaching a CPU quiescent state
or another mechanism?), there will be a small time window, when the inode security
context is released, but the inode itself not, because call_rcu(i_callback) was not called
yet. So in that case each access to inode security blob leads to UAF.

For example, see invoking ops->destroy_inode() after call_rcu(inode_free_by_rcu) but
*before* call_rcu(i_callback). If destroy_inode() may sleep, can be reached end of the
grace period? destroy_inode() is *before* call_rcu(i_callback), therefore simultaneous
access to the inode during path lookup may be performed. Note: I use destroy_inode() as
*an example* of the idea. I'm not expert at all in fsnotify, posix ACL, VFS in general
and RCU, too.

In the previous message I only mentioned fsnotify, but it was only as an example.
I think that destroy_inode() is a better example of the idea I wanted to express.

I repeat that I'm aware that this RFC does not aim to solve this issue. But it can be
unpleasant to get another UAF in a production environment.

And regarding the UAF in [1], it seems very strange to me. The object managed by
Landlock was *not* dereferenced. There was access to the inode security blob itself.

static void hook_inode_free_security(struct inode *const inode)
{
	/*
	 * All inodes must already have been untied from their object by
	 * release_inode() or hook_sb_delete().
	 */
	WARN_ON_ONCE(landlock_inode(inode)->object);
}

But security blob is released at the end of the grace period related to
security_inode_free(): call_rcu(inode_free_by_rcu) is *after* invoking all registered
inode_free_security hooks.

The only place of releasing inode security blob I see in inode_free_by_rcu(). Thus,
I think, there was another call of __destroy_inode(). Or general protection fault was
not caused by UAF. Any ideas? Can someone explain it? I don't understand what and *how*
happened.

If Landlock had dereferenced the object it manages, this RFC could be the right one (if
it were a dereference from a fast path lookup, of course).

[1] https://lore.kernel.org/all/00000000000076ba3b0617f65cc8@google.com/


> 
>>    If not, can the security context be released earlier than the inode itself?
> 
> Possibly, but it should only happen after the inode is no longer in
> use (the call_rcu () callback should ensure that we are past all of
> the currently executing RCU critical sections).
> 
>> If yes, can be executed
>>    inode_permission concurrently, leading to UAF of inode security context in security_inode_permission?
> 
> I do not believe so, see the discussion above, but I welcome any corrections.
> 
>>    Can fsnotify affect this (leading to different RCU grace periods)? (Again probably a question for VFS people.)
> 
> If fsnotify is affecting this negatively then I suspect that is a
> reason for much larger concern as I believe that would indicate a
> problem with fsnotify and the inode locking scheme.
> 


