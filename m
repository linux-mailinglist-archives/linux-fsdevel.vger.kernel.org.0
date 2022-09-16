Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69365BB19C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 19:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIPRac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPRaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:30:30 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CF6A0248
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 10:30:27 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MTh0x4t6XzMpvb5;
        Fri, 16 Sep 2022 19:30:25 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MTh0w5gprz3j;
        Fri, 16 Sep 2022 19:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663349425;
        bh=c3cQ5OIpUdQA4LPM1JRC0JMRXf8FmbTv1tLsYfxYLC8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bilt7jZgBPz8hIBzuvh776xOvi2/R06WBHtNwyFUSGxpMl3uGJDKUzOSzpbofIDU1
         xWcqDJNYlysRopa5ZZzAVOf7L+axtZ+LsmqlWpa7ujih1Np6kQ/b8DCgQvYGdb0RBz
         3sbrYgF5gN3gSq/ZHPAA0pNf+6OeqFaEot7qAKS8=
Message-ID: <962b121b-b299-e024-bf3d-8cc6e12e01f7@digikod.net>
Date:   Fri, 16 Sep 2022 19:30:24 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 1/5] security: create file_truncate hook from
 path_truncate hook
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-security-module@vger.kernel.org
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-2-gnoack3000@gmail.com> <YxpQVTDrcJSig8X2@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <YxpQVTDrcJSig8X2@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We may indeed need to change fs/open.c:vfs_truncate() because of these 
different call sites. I'm not sure how these subsystems work though.


On 08/09/2022 22:28, Günther Noack wrote:
> Adding Namjae Jeon and David Howells as authors of the respective
> files in fs/ksmbd and fs/cachefiles -- do you happen to know whether
> these vfs_truncate() calls are using 'struct file's that are opened by
> normal userspace processes, where LSM policies may apply?
> 
> P.S. In this patch I have looked for all places where the
> security_path_truncate() hook was called, to see which of these should
> rather use security_file_truncate() (and I made sure that it does the
> same thing for all the LSMs that use it).
> 
> I'm confident that this does the right thing when truncate() or
> ftruncate() are called from userspace, but one of the places that
> still calls the path-based hook is vfs_truncate(), and this is called
> from more places in the kernel than just from userspace:
> 
> init/initramfs.c
> 387:				vfs_truncate(&wfile->f_path, body_len);
> 
> security/keys/big_key.c
> 172:		vfs_truncate(&payload->path, 0);
> 
> fs/cachefiles/interface.c
> 242:		ret = vfs_truncate(&file->f_path, dio_size);
> 
> fs/cachefiles/namei.c
> 497:			ret = vfs_truncate(&path, ni_size); >
> fs/ksmbd/smb2pdu.c
> 2350:	int rc = vfs_truncate(path, 0);
> 
> fs/ksmbd/vfs.c
> 874:	err = vfs_truncate(&filp->f_path, size);
> 
> I suspect that these are benign but am not familiar with all of these
> corners of the codebase. -- The question is: Some of these call
> vfs_truncate() on the f_path of an existing struct file -- should
> these rather be calling the security_file_truncate() than the
> security_path_truncate() hook to authorize the truncation?
> 
> Specifically, I think:
> 
> * initramfs happens at system startup and LSMs should not interfere at
>    this point yet
> * security/keys does not use an opened struct file, so calling the
>    path-based hook through vfs_truncate() is correct
> * fs/cachefiles and fs/ksmbd use the file system from the kernel to
>    expose it as another file system (in a cached form for cachefiles,
>    and over the network for ksmbd). I suspect that these file systems
>    are not handling 'struct file's which are opened in contexts where a
>    LSM applies? It that a reasonable assumption?

I think you're right but I have some doubts about the cachefiles subsystem.
I don't know how ksmb deals with these file descriptors but changing 
such call sites (where there is a struct file) could improve API 
consistency though.
Any though?


> 
> Thanks,
> Günther
> 
> On Thu, Sep 08, 2022 at 09:58:01PM +0200, Günther Noack wrote:
>> Like path_truncate, the file_truncate hook also restricts file
>> truncation, but is called in the cases where truncation is attempted
>> on an already-opened file.
>>
>> This is required in a subsequent commit to handle ftruncate()
>> operations differently to truncate() operations.
>>
>> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
>> ---
>>   fs/namei.c                    |  6 +++---
>>   fs/open.c                     |  4 ++--
>>   include/linux/lsm_hook_defs.h |  1 +
>>   include/linux/security.h      |  6 ++++++
>>   security/apparmor/lsm.c       |  6 ++++++
>>   security/security.c           |  5 +++++
>>   security/tomoyo/tomoyo.c      | 13 +++++++++++++
>>   7 files changed, 36 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 53b4bc094db2..52105873d1f8 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -53,8 +53,8 @@
>>    * The new code replaces the old recursive symlink resolution with
>>    * an iterative one (in case of non-nested symlink chains).  It does
>>    * this with calls to <fs>_follow_link().
>> - * As a side effect, dir_namei(), _namei() and follow_link() are now
>> - * replaced with a single function lookup_dentry() that can handle all
>> + * As a side effect, dir_namei(), _namei() and follow_link() are now
>> + * replaced with a single function lookup_dentry() that can handle all
>>    * the special cases of the former code.
>>    *
>>    * With the new dcache, the pathname is stored at each inode, at least as
>> @@ -3211,7 +3211,7 @@ static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
>>   	if (error)
>>   		return error;
>>
>> -	error = security_path_truncate(path);
>> +	error = security_file_truncate(filp);
>>   	if (!error) {
>>   		error = do_truncate(mnt_userns, path->dentry, 0,
>>   				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
>> diff --git a/fs/open.c b/fs/open.c
>> index 8a813fa5ca56..0831433e493a 100644
>> --- a/fs/open.c
>> +++ b/fs/open.c
>> @@ -188,7 +188,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
>>   	if (IS_APPEND(file_inode(f.file)))
>>   		goto out_putf;
>>   	sb_start_write(inode->i_sb);
>> -	error = security_path_truncate(&f.file->f_path);
>> +	error = security_file_truncate(f.file);
>>   	if (!error)
>>   		error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
>>   				    ATTR_MTIME | ATTR_CTIME, f.file);
>> @@ -1271,7 +1271,7 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
>>   {
>>   	struct filename *name = getname_kernel(filename);
>>   	struct file *file = ERR_CAST(name);
>> -
>> +
>>   	if (!IS_ERR(name)) {
>>   		file = file_open_name(name, flags, mode);
>>   		putname(name);
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 60fff133c0b1..dee35ab253ba 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -177,6 +177,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
>>   	 struct fown_struct *fown, int sig)
>>   LSM_HOOK(int, 0, file_receive, struct file *file)
>>   LSM_HOOK(int, 0, file_open, struct file *file)
>> +LSM_HOOK(int, 0, file_truncate, struct file *file)
>>   LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
>>   	 unsigned long clone_flags)
>>   LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 7bd0c490703d..f80b23382dd9 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -394,6 +394,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
>>   				 struct fown_struct *fown, int sig);
>>   int security_file_receive(struct file *file);
>>   int security_file_open(struct file *file);
>> +int security_file_truncate(struct file *file);
>>   int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
>>   void security_task_free(struct task_struct *task);
>>   int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
>> @@ -1011,6 +1012,11 @@ static inline int security_file_open(struct file *file)
>>   	return 0;
>>   }
>>
>> +static inline int security_file_truncate(struct file *file)
>> +{
>> +	return 0;
>> +}
>> +
>>   static inline int security_task_alloc(struct task_struct *task,
>>   				      unsigned long clone_flags)
>>   {
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index e29cade7b662..98ecb7f221b8 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -329,6 +329,11 @@ static int apparmor_path_truncate(const struct path *path)
>>   	return common_perm_cond(OP_TRUNC, path, MAY_WRITE | AA_MAY_SETATTR);
>>   }
>>
>> +static int apparmor_file_truncate(struct file *file)
>> +{
>> +	return apparmor_path_truncate(&file->f_path);
>> +}
>> +
>>   static int apparmor_path_symlink(const struct path *dir, struct dentry *dentry,
>>   				 const char *old_name)
>>   {
>> @@ -1232,6 +1237,7 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>>   	LSM_HOOK_INIT(mmap_file, apparmor_mmap_file),
>>   	LSM_HOOK_INIT(file_mprotect, apparmor_file_mprotect),
>>   	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
>> +	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
>>
>>   	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
>>   	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
>> diff --git a/security/security.c b/security/security.c
>> index 4b95de24bc8d..e491120c48ba 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1210,6 +1210,11 @@ int security_path_truncate(const struct path *path)
>>   	return call_int_hook(path_truncate, 0, path);
>>   }
>>
>> +int security_file_truncate(struct file *file)
>> +{
>> +	return call_int_hook(file_truncate, 0, file);
>> +}
>> +
>>   int security_path_chmod(const struct path *path, umode_t mode)
>>   {
>>   	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
>> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
>> index 71e82d855ebf..af04a7b7eb28 100644
>> --- a/security/tomoyo/tomoyo.c
>> +++ b/security/tomoyo/tomoyo.c
>> @@ -134,6 +134,18 @@ static int tomoyo_path_truncate(const struct path *path)
>>   	return tomoyo_path_perm(TOMOYO_TYPE_TRUNCATE, path, NULL);
>>   }
>>
>> +/**
>> + * tomoyo_file_truncate - Target for security_file_truncate().
>> + *
>> + * @file: Pointer to "struct file".
>> + *
>> + * Returns 0 on success, negative value otherwise.
>> + */
>> +static int tomoyo_file_truncate(struct file *file)
>> +{
>> +	return tomoyo_path_truncate(&file->f_path);
>> +}
>> +
>>   /**
>>    * tomoyo_path_unlink - Target for security_path_unlink().
>>    *
>> @@ -545,6 +557,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
>>   	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
>>   	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
>>   	LSM_HOOK_INIT(file_open, tomoyo_file_open),
>> +	LSM_HOOK_INIT(file_truncate, tomoyo_file_truncate),
>>   	LSM_HOOK_INIT(path_truncate, tomoyo_path_truncate),
>>   	LSM_HOOK_INIT(path_unlink, tomoyo_path_unlink),
>>   	LSM_HOOK_INIT(path_mkdir, tomoyo_path_mkdir),
>> --
>> 2.37.3
>>
> 
> --
