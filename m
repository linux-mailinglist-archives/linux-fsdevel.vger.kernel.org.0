Return-Path: <linux-fsdevel+bounces-24069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83D938F16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 14:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A90C281BC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 12:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAD216D4E1;
	Mon, 22 Jul 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b="XKxAPoVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out.cvt.stuba.sk (smtp-out.cvt.stuba.sk [147.175.1.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28A16CD3B;
	Mon, 22 Jul 2024 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.175.1.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721651413; cv=none; b=ryVY81EvmMTB6ZGE/cwxV9cxx6/CoyiTwEGnxyiyl8r7y9jxGjj+CxhjWOpC4pLXW7hc5ZnK2jZ7ITOE9qQQBrXrbDdBpl7Q4GunWA2ym2fHOINukL+WO1n9HJ8fWuJPMvKLJgJPlEEO4inCavhyDsTcn/ufgAJYGrIawGkQODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721651413; c=relaxed/simple;
	bh=QYJjUayfOW3Iu2s5KLRYoX87P3zgT4ST0jGaZfWa8yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZudMdEuQlf83FMFL0E8JahwFpqCBu/9qh2lV0YGHzpyMg8g9/8+o+tlOmIml5AtxmM4p/ox92YtjkNm9CZYzkSYCt8ErDIOsSAkM2kY3aZ4EZnX4wpIiqTVRUHPvjZzUdsFtwhnewBGQXLVDE8DJ01kH+nzGypSjvxdCrOV40X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk; spf=pass smtp.mailfrom=stuba.sk; dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b=XKxAPoVb; arc=none smtp.client-ip=147.175.1.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stuba.sk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=stuba.sk;
	s=20180406; h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
	MIME-Version:Date:Message-ID; bh=ni3yT5OSY7+kdIVa0o7ghGWYq7yTvaPSFDN9orW/Jl0=
	; t=1721651409; x=1722083409; b=XKxAPoVbr3yufkHeNjrtDiYXHSh8xywtlsFabL0Ya/wP1
	Xm29GvjYRVaivzBcUq7qOPfWMwbPIeaCUTpL6j98mUVRxz7/IMtIqJOVeUyIHHaPCjtpOmFmlkxe3
	DMdRc4aVpbcWOYj0GTIrbsRgBfTfPZlLEzul6FBrZQq6PxQb5G9CLgFGa5G8KDKiaDirm3viIyJLp
	+u1Oo9hTPvhvHbeq57RQZtgPZb5T2eixoqTlGxvaBtKZduubOAX3TfnInnKEp9dBWdTf9lNz0bkyq
	ZAQUBG9hoIXfg9U7JAcsnfG7fwIzTUydi1TLdjhtNzTXQwMfVWAeiBmPJrJBbWRyYA==;
X-STU-Diag: 0788c6148bbb52df (auth)
Received: from ellyah.uim.fei.stuba.sk ([147.175.106.89])
	by mx1.stuba.sk (Exim4) with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(envelope-from <matus.jokay@stuba.sk>)
	id 1sVsAx-000000005PY-2X0t;
	Mon, 22 Jul 2024 14:29:59 +0200
Message-ID: <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk>
Date: Mon, 22 Jul 2024 14:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <20240710.peiDu2aiD1su@digikod.net>
Content-Language: en-US
From: Matus Jokay <matus.jokay@stuba.sk>
In-Reply-To: <20240710.peiDu2aiD1su@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10. 7. 2024 12:40, Mickaël Salaün wrote:
> On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
>> The LSM framework has an existing inode_free_security() hook which
>> is used by LSMs that manage state associated with an inode, but
>> due to the use of RCU to protect the inode, special care must be
>> taken to ensure that the LSMs do not fully release the inode state
>> until it is safe from a RCU perspective.
>>
>> This patch implements a new inode_free_security_rcu() implementation
>> hook which is called when it is safe to free the LSM's internal inode
>> state.  Unfortunately, this new hook does not have access to the inode
>> itself as it may already be released, so the existing
>> inode_free_security() hook is retained for those LSMs which require
>> access to the inode.
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> 
> I like this new hook.  It is definitely safer than the current approach.
> 
> To make it more consistent, I think we should also rename
> security_inode_free() to security_inode_put() to highlight the fact that
> LSM implementations should not free potential pointers in this blob
> because they could still be dereferenced in a path walk.
> 
>> ---
>>  include/linux/lsm_hook_defs.h     |  1 +
>>  security/integrity/ima/ima.h      |  2 +-
>>  security/integrity/ima/ima_iint.c | 20 ++++++++------------
>>  security/integrity/ima/ima_main.c |  2 +-
>>  security/landlock/fs.c            |  9 ++++++---
>>  security/security.c               | 26 +++++++++++++-------------
>>  6 files changed, 30 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 8fd87f823d3a..abe6b0ef892a 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -114,6 +114,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
>>  	 unsigned int obj_type)
>>  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
>> +LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *)
>>  LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
>>  	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
>>  	 int *xattr_count)
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 3e568126cd48..e2a2e4c7eab6 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -223,7 +223,7 @@ static inline void ima_inode_set_iint(const struct inode *inode,
>>  
>>  struct ima_iint_cache *ima_iint_find(struct inode *inode);
>>  struct ima_iint_cache *ima_inode_get(struct inode *inode);
>> -void ima_inode_free(struct inode *inode);
>> +void ima_inode_free_rcu(void *inode_sec);
>>  void __init ima_iintcache_init(void);
>>  
>>  extern const int read_idmap[];
>> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
>> index e23412a2c56b..54480df90bdc 100644
>> --- a/security/integrity/ima/ima_iint.c
>> +++ b/security/integrity/ima/ima_iint.c
>> @@ -109,22 +109,18 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
>>  }
>>  
>>  /**
>> - * ima_inode_free - Called on inode free
>> - * @inode: Pointer to the inode
>> + * ima_inode_free_rcu - Called to free an inode via a RCU callback
>> + * @inode_sec: The inode::i_security pointer
>>   *
>> - * Free the iint associated with an inode.
>> + * Free the IMA data associated with an inode.
>>   */
>> -void ima_inode_free(struct inode *inode)
>> +void ima_inode_free_rcu(void *inode_sec)
>>  {
>> -	struct ima_iint_cache *iint;
>> +	struct ima_iint_cache **iint_p = inode_sec + ima_blob_sizes.lbs_inode;
>>  
>> -	if (!IS_IMA(inode))
>> -		return;
>> -
>> -	iint = ima_iint_find(inode);
>> -	ima_inode_set_iint(inode, NULL);
>> -
>> -	ima_iint_free(iint);
>> +	/* *iint_p should be NULL if !IS_IMA(inode) */
>> +	if (*iint_p)
>> +		ima_iint_free(*iint_p);
>>  }
>>  
>>  static void ima_iint_init_once(void *foo)
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index f04f43af651c..5b3394864b21 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -1193,7 +1193,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
>>  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
>>  	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
>>  #endif
>> -	LSM_HOOK_INIT(inode_free_security, ima_inode_free),
>> +	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
>>  };
>>  
>>  static const struct lsm_id ima_lsmid = {
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index 22d8b7c28074..f583f8cec345 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -1198,13 +1198,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>>  
>>  /* Inode hooks */
>>  
>> -static void hook_inode_free_security(struct inode *const inode)
>> +static void hook_inode_free_security_rcu(void *inode_sec)
>>  {
>> +	struct landlock_inode_security *lisec;
> 
> Please rename "lisec" to "inode_sec" for consistency with
> get_inode_object()'s variables.
> 
>> +
>>  	/*
>>  	 * All inodes must already have been untied from their object by
>>  	 * release_inode() or hook_sb_delete().
>>  	 */
>> -	WARN_ON_ONCE(landlock_inode(inode)->object);
>> +	lisec = inode_sec + landlock_blob_sizes.lbs_inode;
>> +	WARN_ON_ONCE(lisec->object);
>>  }
> 
> This looks good to me.
> 
> We can add these footers:
> Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/00000000000076ba3b0617f65cc8@google.com
Sorry for the questions, but for several weeks I can't find answers to two things related to this RFC:

1) How does this patch close [1]?
   As Mickaël pointed in [2], "It looks like security_inode_free() is called two times on the same inode."
   Indeed, it does not seem from the backtrace that it is a case of race between destroy_inode and inode_permission,
   i.e. referencing the inode in a VFS path walk while destroying it...
   Please, can anyone tell me how this situation could have happened? Maybe folks from VFS... I added them to the copy.

2) Is there a guarantee that inode_free_by_rcu and i_callback will be called within the same RCU grace period?
   If not, can the security context be released earlier than the inode itself? If yes, can be executed
   inode_permission concurrently, leading to UAF of inode security context in security_inode_permission?
   Can fsnotify affect this (leading to different RCU grace periods)? (Again probably a question for VFS people.)
   I know, this RFC doesn't address exactly that question, but I'd like to know the answer.

Many thanks for the helpful answers and your time,
mY

[1] https://lore.kernel.org/r/00000000000076ba3b0617f65cc8@google.com
[2] https://lore.kernel.org/linux-security-module/CAHC9VhQUqJkWxhe5KukPOVQMnOhcOH5E+BJ4_b3Qn6edsL5YJQ@mail.gmail.com/T/#m6e6b01b196eac15a7ad99cf366614bbe60b8d9a2

> 
> However, I'm wondering if we could backport this patch down to v5.15 .
> I guess not, so I'll need to remove this hook implementation for
> Landlock, backport it to v5.15, and then you'll need to re-add this
> check with this patch.  At least it has been useful to spot this inode
> issue, but it could still be useful to spot potential memory leaks with
> a negligible performance impact.
> 
> 
>>  
>>  /* Super-block hooks */
>> @@ -1628,7 +1631,7 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
>>  }
>>  
>>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>> -	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>> +	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
>>  
>>  	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
>>  	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
>> diff --git a/security/security.c b/security/security.c
>> index b52e81ac5526..bc6805f7332e 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1596,9 +1596,8 @@ int security_inode_alloc(struct inode *inode)
>>  
>>  static void inode_free_by_rcu(struct rcu_head *head)
>>  {
>> -	/*
>> -	 * The rcu head is at the start of the inode blob
>> -	 */
>> +	/* The rcu head is at the start of the inode blob */
>> +	call_void_hook(inode_free_security_rcu, head);
> 
> For this to work, we need to extend the inode blob size (lbs_inode) with
> sizeof(struct rcu_head).  The current implementation override the
> content of the blob with a new rcu_head.
> 
>>  	kmem_cache_free(lsm_inode_cache, head);
>>  }
>>  
>> @@ -1606,20 +1605,21 @@ static void inode_free_by_rcu(struct rcu_head *head)
>>   * security_inode_free() - Free an inode's LSM blob
>>   * @inode: the inode
>>   *
>> - * Deallocate the inode security structure and set @inode->i_security to NULL.
>> + * Release any LSM resources associated with @inode, although due to the
>> + * inode's RCU protections it is possible that the resources will not be
>> + * fully released until after the current RCU grace period has elapsed.
>> + *
>> + * It is important for LSMs to note that despite being present in a call to
>> + * security_inode_free(), @inode may still be referenced in a VFS path walk
>> + * and calls to security_inode_permission() may be made during, or after,
>> + * a call to security_inode_free().  For this reason the inode->i_security
>> + * field is released via a call_rcu() callback and any LSMs which need to
>> + * retain inode state for use in security_inode_permission() should only
>> + * release that state in the inode_free_security_rcu() LSM hook callback.
>>   */
>>  void security_inode_free(struct inode *inode)
>>  {
>>  	call_void_hook(inode_free_security, inode);
>> -	/*
>> -	 * The inode may still be referenced in a path walk and
>> -	 * a call to security_inode_permission() can be made
>> -	 * after inode_free_security() is called. Ideally, the VFS
>> -	 * wouldn't do this, but fixing that is a much harder
>> -	 * job. For now, simply free the i_security via RCU, and
>> -	 * leave the current inode->i_security pointer intact.
>> -	 * The inode will be freed after the RCU grace period too.
>> -	 */
>>  	if (inode->i_security)
>>  		call_rcu((struct rcu_head *)inode->i_security,
>>  			 inode_free_by_rcu);
> 
> We should have something like:
> call_rcu(inode->i_security.rcu, inode_free_by_rcu);
> 
>> -- 
>> 2.45.2
>>
>>
> 


