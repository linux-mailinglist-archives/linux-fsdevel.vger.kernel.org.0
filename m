Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACC05EAD8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIZRFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 13:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiIZRFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:05:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95CDFCF;
        Mon, 26 Sep 2022 09:07:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so15143165ejn.3;
        Mon, 26 Sep 2022 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=OZtKIYpqdftDbCLqBzEndP5heachSKCS26i3XUNEddk=;
        b=DR1i/HQm0G19jrQ3m+I7qBego0FMbaIkL4vVuC3OnxUj3Ars6Fu3oMNwSlNNqv++UU
         TpqzS7xahvUHguGYNtlkT02mx7Vw4wvQE7eGLMGuWb72YT/VRkBB/5oTT1yXWoWVx6mE
         JtUiFNNZaYwS0XzPVNFDBzwOM8AtDkjUUmQKCaMwulfGKNZJzyf4xzNcT4naXzvAxeBn
         yedVOZxvlCX0UyktkZShwpfinFMzPpFrlR1Xo4z5wfRI5e7QeTIvNVlsPAPYG2R2Aty5
         sQJDdByb6sVXdswRMgkPfNuN7dNzy3tszs3/JFN6urFY0wN+QUD5wZuTmHzkST2y4cz5
         Wsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OZtKIYpqdftDbCLqBzEndP5heachSKCS26i3XUNEddk=;
        b=Hw+YFes2aTgl2SFxduGV77ER2QVhherCbATTcHqHV0wX7+Tnkizi8C4MXBTT20Xx4L
         Qm15oIuN0czIorv9f6X+8s3+AXh+GYTFi+PgRMa3JeJn4uNrjwVfIPDC3EUrzH0csRzm
         QRgyrvTEjccEyptlcVc1MHkcupwrGsTMhNwtHr2kADhohRZ66uA/BPScCVcQ+Pj5buw7
         ocFG1ZkXhJC0Cjn6Q0eJtdA1T21GoWdl4XfdgqltGlj2adgbpKUj7CP611qxoCknZ5yq
         tdFcqoc0gEQKgDjTqNo88iIHu6JR3oLl5xhsbY00j7JS3Dj2vVlIb1tYNAw/yq1zVADE
         hNmw==
X-Gm-Message-State: ACrzQf1wrvwst+6MQFwxWNt0xixh2XEqthESyMhq2/XXvLhM4peqpsej
        cRWDgD+4O2COboTlHhi1qF8=
X-Google-Smtp-Source: AMsMyM4voTKPQWQ4bfXX/XILHzaGcS+sSn5+zy+AqWwPPbkNiuz7/dxC0osyNHMHop5IZH9UR+4FqA==
X-Received: by 2002:a17:907:6e17:b0:783:7839:ff3f with SMTP id sd23-20020a1709076e1700b007837839ff3fmr5504874ejc.300.1664208470816;
        Mon, 26 Sep 2022 09:07:50 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d12-20020aa7ce0c000000b004570ed2da1bsm4803120edv.38.2022.09.26.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 09:07:50 -0700 (PDT)
Date:   Mon, 26 Sep 2022 18:07:48 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 1/5] security: create file_truncate hook from
 path_truncate hook
Message-ID: <YzHOVIUX0oxTcV0B@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-2-gnoack3000@gmail.com>
 <YxpQVTDrcJSig8X2@nuc>
 <962b121b-b299-e024-bf3d-8cc6e12e01f7@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <962b121b-b299-e024-bf3d-8cc6e12e01f7@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 07:30:24PM +0200, Mickaël Salaün wrote:
> We may indeed need to change fs/open.c:vfs_truncate() because of these
> different call sites. I'm not sure how these subsystems work though.

I thought about this some more, and I'm coming around to the
conclusion that we should not block the truncate patch set on changes
in ksmbd and cachefiles.

The reasoning is:

* Landlock does already work for ksmbd and cachefiles. vfs_truncate
  does call the security_path_truncate() hook in the background.

* ksmbd and cachefiles using vfs_truncate() in kernel space is roughly
  equivalent to a user space program using truncate(2) in a place
  where ftruncate(2) is possible. It might not be the most elegant
  approach, but it's legitimate to do.

* Like with any userspace program that is supposed to run under
  Landlock, ksmbd and cachefiles both may need to be adapted slightly
  to work well with Landlock enforcement. It is up to the person
  adding the Landlock enforcement to double check that the program
  works correctly under the enforced ruleset. This is true for both
  programs running in user space and kernel space.

So yes, to run ksmbd and cachefiles under Landlock, we may need to
extract a fs/open.c:vfs_ftruncate() in addition to vfs_truncate(), but
I don't think it should be part of this patch set.

So my proposal would be to:

* not do the ksmbd and cachefiles changes now,

* but leave them for later when someone actually tries to run ksmbd or
  cachefiles under Landlock.

If these components never get executed in a Landlocked context, all
the better - we can spare ourselves a more complicated refactoring in
a core part of the kernel.

FWIW, I've played around with it yesterday and found that the change
to extract a new "vfs_ftruncate()" next to vfs_truncate() is
reasonably self-contained. But I'm not a file system expert either,
it's well possible that I'm overlooking something.

Let me know what you think!

> On 08/09/2022 22:28, Günther Noack wrote:
> > Adding Namjae Jeon and David Howells as authors of the respective
> > files in fs/ksmbd and fs/cachefiles -- do you happen to know whether
> > these vfs_truncate() calls are using 'struct file's that are opened by
> > normal userspace processes, where LSM policies may apply?
> > 
> > P.S. In this patch I have looked for all places where the
> > security_path_truncate() hook was called, to see which of these should
> > rather use security_file_truncate() (and I made sure that it does the
> > same thing for all the LSMs that use it).
> > 
> > I'm confident that this does the right thing when truncate() or
> > ftruncate() are called from userspace, but one of the places that
> > still calls the path-based hook is vfs_truncate(), and this is called
> > from more places in the kernel than just from userspace:
> > 
> > init/initramfs.c
> > 387:				vfs_truncate(&wfile->f_path, body_len);
> > 
> > security/keys/big_key.c
> > 172:		vfs_truncate(&payload->path, 0);
> > 
> > fs/cachefiles/interface.c
> > 242:		ret = vfs_truncate(&file->f_path, dio_size);
> > 
> > fs/cachefiles/namei.c
> > 497:			ret = vfs_truncate(&path, ni_size); >
> > fs/ksmbd/smb2pdu.c
> > 2350:	int rc = vfs_truncate(path, 0);
> > 
> > fs/ksmbd/vfs.c
> > 874:	err = vfs_truncate(&filp->f_path, size);
> > 
> > I suspect that these are benign but am not familiar with all of these
> > corners of the codebase. -- The question is: Some of these call
> > vfs_truncate() on the f_path of an existing struct file -- should
> > these rather be calling the security_file_truncate() than the
> > security_path_truncate() hook to authorize the truncation?
> > 
> > Specifically, I think:
> > 
> > * initramfs happens at system startup and LSMs should not interfere at
> >    this point yet
> > * security/keys does not use an opened struct file, so calling the
> >    path-based hook through vfs_truncate() is correct
> > * fs/cachefiles and fs/ksmbd use the file system from the kernel to
> >    expose it as another file system (in a cached form for cachefiles,
> >    and over the network for ksmbd). I suspect that these file systems
> >    are not handling 'struct file's which are opened in contexts where a
> >    LSM applies? It that a reasonable assumption?
> 
> I think you're right but I have some doubts about the cachefiles subsystem.
> I don't know how ksmb deals with these file descriptors but changing such
> call sites (where there is a struct file) could improve API consistency
> though.
> Any though?

My conclusion is already summarized above, and I've tried to abstract
away from the concrete use cases. For completeness, I've also looked
into ksmbd and cachefiles specifically though so see whether
security_path_truncate and security_file_truncate would make a
difference.

For ksmbd, I strongly suspect it does not make a difference (90%
confidence) -- the files are getting opened by the same request
handler context which is also truncating the files later on behalf of
a truncation operation in the SMB protocol. It's anyway unclear to me
whether the kernel tasks executing this can be put under Landlock
enforcement at all..?

fs/cachefiles is a more layered system and uses some
cachefiles-independent caching structures with void* pointers, whose
values I found difficult to trace. I'm less certain about this one as
well, but as discussed above, it does not make a difference as long as
none of the cachefiles code executes in a Landlock context. I'm still
in favor of decoupling potential ksmbd and cachefiles changes from
this patch set.

—Günther

> 
> 
> > 
> > Thanks,
> > Günther
> > 
> > On Thu, Sep 08, 2022 at 09:58:01PM +0200, Günther Noack wrote:
> > > Like path_truncate, the file_truncate hook also restricts file
> > > truncation, but is called in the cases where truncation is attempted
> > > on an already-opened file.
> > > 
> > > This is required in a subsequent commit to handle ftruncate()
> > > operations differently to truncate() operations.
> > > 
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > ---
> > >   fs/namei.c                    |  6 +++---
> > >   fs/open.c                     |  4 ++--
> > >   include/linux/lsm_hook_defs.h |  1 +
> > >   include/linux/security.h      |  6 ++++++
> > >   security/apparmor/lsm.c       |  6 ++++++
> > >   security/security.c           |  5 +++++
> > >   security/tomoyo/tomoyo.c      | 13 +++++++++++++
> > >   7 files changed, 36 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 53b4bc094db2..52105873d1f8 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -53,8 +53,8 @@
> > >    * The new code replaces the old recursive symlink resolution with
> > >    * an iterative one (in case of non-nested symlink chains).  It does
> > >    * this with calls to <fs>_follow_link().
> > > - * As a side effect, dir_namei(), _namei() and follow_link() are now
> > > - * replaced with a single function lookup_dentry() that can handle all
> > > + * As a side effect, dir_namei(), _namei() and follow_link() are now
> > > + * replaced with a single function lookup_dentry() that can handle all
> > >    * the special cases of the former code.
> > >    *
> > >    * With the new dcache, the pathname is stored at each inode, at least as
> > > @@ -3211,7 +3211,7 @@ static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
> > >   	if (error)
> > >   		return error;
> > > 
> > > -	error = security_path_truncate(path);
> > > +	error = security_file_truncate(filp);
> > >   	if (!error) {
> > >   		error = do_truncate(mnt_userns, path->dentry, 0,
> > >   				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> > > diff --git a/fs/open.c b/fs/open.c
> > > index 8a813fa5ca56..0831433e493a 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -188,7 +188,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
> > >   	if (IS_APPEND(file_inode(f.file)))
> > >   		goto out_putf;
> > >   	sb_start_write(inode->i_sb);
> > > -	error = security_path_truncate(&f.file->f_path);
> > > +	error = security_file_truncate(f.file);
> > >   	if (!error)
> > >   		error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
> > >   				    ATTR_MTIME | ATTR_CTIME, f.file);
> > > @@ -1271,7 +1271,7 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
> > >   {
> > >   	struct filename *name = getname_kernel(filename);
> > >   	struct file *file = ERR_CAST(name);
> > > -
> > > +
> > >   	if (!IS_ERR(name)) {
> > >   		file = file_open_name(name, flags, mode);
> > >   		putname(name);
> > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > > index 60fff133c0b1..dee35ab253ba 100644
> > > --- a/include/linux/lsm_hook_defs.h
> > > +++ b/include/linux/lsm_hook_defs.h
> > > @@ -177,6 +177,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
> > >   	 struct fown_struct *fown, int sig)
> > >   LSM_HOOK(int, 0, file_receive, struct file *file)
> > >   LSM_HOOK(int, 0, file_open, struct file *file)
> > > +LSM_HOOK(int, 0, file_truncate, struct file *file)
> > >   LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
> > >   	 unsigned long clone_flags)
> > >   LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
> > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > index 7bd0c490703d..f80b23382dd9 100644
> > > --- a/include/linux/security.h
> > > +++ b/include/linux/security.h
> > > @@ -394,6 +394,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
> > >   				 struct fown_struct *fown, int sig);
> > >   int security_file_receive(struct file *file);
> > >   int security_file_open(struct file *file);
> > > +int security_file_truncate(struct file *file);
> > >   int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
> > >   void security_task_free(struct task_struct *task);
> > >   int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
> > > @@ -1011,6 +1012,11 @@ static inline int security_file_open(struct file *file)
> > >   	return 0;
> > >   }
> > > 
> > > +static inline int security_file_truncate(struct file *file)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > >   static inline int security_task_alloc(struct task_struct *task,
> > >   				      unsigned long clone_flags)
> > >   {
> > > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > > index e29cade7b662..98ecb7f221b8 100644
> > > --- a/security/apparmor/lsm.c
> > > +++ b/security/apparmor/lsm.c
> > > @@ -329,6 +329,11 @@ static int apparmor_path_truncate(const struct path *path)
> > >   	return common_perm_cond(OP_TRUNC, path, MAY_WRITE | AA_MAY_SETATTR);
> > >   }
> > > 
> > > +static int apparmor_file_truncate(struct file *file)
> > > +{
> > > +	return apparmor_path_truncate(&file->f_path);
> > > +}
> > > +
> > >   static int apparmor_path_symlink(const struct path *dir, struct dentry *dentry,
> > >   				 const char *old_name)
> > >   {
> > > @@ -1232,6 +1237,7 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
> > >   	LSM_HOOK_INIT(mmap_file, apparmor_mmap_file),
> > >   	LSM_HOOK_INIT(file_mprotect, apparmor_file_mprotect),
> > >   	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
> > > +	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
> > > 
> > >   	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
> > >   	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
> > > diff --git a/security/security.c b/security/security.c
> > > index 4b95de24bc8d..e491120c48ba 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -1210,6 +1210,11 @@ int security_path_truncate(const struct path *path)
> > >   	return call_int_hook(path_truncate, 0, path);
> > >   }
> > > 
> > > +int security_file_truncate(struct file *file)
> > > +{
> > > +	return call_int_hook(file_truncate, 0, file);
> > > +}
> > > +
> > >   int security_path_chmod(const struct path *path, umode_t mode)
> > >   {
> > >   	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
> > > diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> > > index 71e82d855ebf..af04a7b7eb28 100644
> > > --- a/security/tomoyo/tomoyo.c
> > > +++ b/security/tomoyo/tomoyo.c
> > > @@ -134,6 +134,18 @@ static int tomoyo_path_truncate(const struct path *path)
> > >   	return tomoyo_path_perm(TOMOYO_TYPE_TRUNCATE, path, NULL);
> > >   }
> > > 
> > > +/**
> > > + * tomoyo_file_truncate - Target for security_file_truncate().
> > > + *
> > > + * @file: Pointer to "struct file".
> > > + *
> > > + * Returns 0 on success, negative value otherwise.
> > > + */
> > > +static int tomoyo_file_truncate(struct file *file)
> > > +{
> > > +	return tomoyo_path_truncate(&file->f_path);
> > > +}
> > > +
> > >   /**
> > >    * tomoyo_path_unlink - Target for security_path_unlink().
> > >    *
> > > @@ -545,6 +557,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
> > >   	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
> > >   	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
> > >   	LSM_HOOK_INIT(file_open, tomoyo_file_open),
> > > +	LSM_HOOK_INIT(file_truncate, tomoyo_file_truncate),
> > >   	LSM_HOOK_INIT(path_truncate, tomoyo_path_truncate),
> > >   	LSM_HOOK_INIT(path_unlink, tomoyo_path_unlink),
> > >   	LSM_HOOK_INIT(path_mkdir, tomoyo_path_mkdir),
> > > --
> > > 2.37.3
> > > 
> > 
> > --

-- 
