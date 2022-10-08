Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F9C5F8420
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 09:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJHHp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 03:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJHHpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:45:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D236097;
        Sat,  8 Oct 2022 00:45:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d26so8411909eje.10;
        Sat, 08 Oct 2022 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V4UuwDJlqj8sAG7taXDhyAmX/+O/Ziwjki9dOumSvs4=;
        b=CrcpWz+qDXr+A1L0p6pWwsFjMjk0LLM3hw1IOmD308ewXVpob85LldUXkyL7mgzFXm
         WZQq5UKLtEakOjslIJg4i6oCI5dyu/10wp6caIVSw7UzQ2DQu7sFfSxWVETjrdfUsHjX
         MhQMxdjCMKjmFZcpctuQaUMr1SAs+zGScGEHM29tgTU7OG7DyOrmBPYqrkGvZhWOdJt0
         gF2HCTWTjoRvbGTUPIKY8mQ+wQ2DVRklw71hceOvHAtvNdx8qUnO5T97tlXeqIj6sl+4
         bR6Sh+VSDWx5V4RshtVhxJuwUhYJwTZxXiZQCRhXkTAbBTZRZKjDS8RaU30C7D9kcBg3
         AW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4UuwDJlqj8sAG7taXDhyAmX/+O/Ziwjki9dOumSvs4=;
        b=wVY4zlXPbtmCTPZWqfQknug+Asycd7mR8kQ3z5wiCWsVlppjWHScDaxWaNahcco4+0
         8nqrBMKxuuLiBkQrGVyz5cldU7WAxvU30BtE4XWqTPQNFWzIepV3jjbcNlV7D/BCpPQt
         tDPIOwUJhQcFZT/rIjwK5XvutTHmACN1rvuY8Decd00Zxi7RrmoxTfnTJ55A+NozHq0F
         mCpdMknojLg4N/Q8/PEVW7nuO9jI48tfFkWcNhN+uhejRiEciOqMRjde2zfEnUPlJahR
         UIqT5MmD6TNZuSSd7miQT+Ipzc1MINWJ6I3OVq5RAfaDzLBbfVQbwsRZ7x1rUgXeoV9I
         3xZA==
X-Gm-Message-State: ACrzQf2E3cLPUnb5cuVoM4Zl5kQmbW046HcMx7Wxv1uDMKWPTN/uTwH5
        3k9MlT9IBarMUZMwEFJdCAwm7A7yOLo=
X-Google-Smtp-Source: AMsMyM4sxBQQBmyV3gU/EXjgSdlXgHGOL/fbOnpgN+QLHqow0/TmDS5P7IZFkjuQDK6MsEDYzFZ8ew==
X-Received: by 2002:a17:907:6288:b0:72f:90ba:f0b2 with SMTP id nd8-20020a170907628800b0072f90baf0b2mr6793442ejc.696.1665215117945;
        Sat, 08 Oct 2022 00:45:17 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b0073ddd36ba8csm2327029eju.145.2022.10.08.00.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:45:17 -0700 (PDT)
Date:   Sat, 8 Oct 2022 09:45:15 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH v8 1/9] security: Create file_truncate hook from
 path_truncate hook
Message-ID: <Y0Eqi8WSKtgTvOz+@nuc>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-2-gnoack3000@gmail.com>
 <f1f25fa2-565f-635c-1477-4036f64588e1@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1f25fa2-565f-635c-1477-4036f64588e1@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:53:35PM +0200, Mickaël Salaün wrote:
> Thanks for the doc.
> 
> On 01/10/2022 17:49, Günther Noack wrote:
> > Like path_truncate, the file_truncate hook also restricts file
> > truncation, but is called in the cases where truncation is attempted
> > on an already-opened file.
> > 
> > This is required in a subsequent commit to handle ftruncate()
> > operations differently to truncate() operations.
> > 
> > Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Acked-by: John Johansen <john.johansen@canonical.com>
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   fs/namei.c                    |  2 +-
> >   fs/open.c                     |  2 +-
> >   include/linux/lsm_hook_defs.h |  1 +
> >   include/linux/lsm_hooks.h     | 10 +++++++++-
> >   include/linux/security.h      |  6 ++++++
> >   security/apparmor/lsm.c       |  6 ++++++
> >   security/security.c           |  5 +++++
> >   security/tomoyo/tomoyo.c      | 13 +++++++++++++
> >   8 files changed, 42 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 53b4bc094db2..0e419bd30f8e 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3211,7 +3211,7 @@ static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
> >   	if (error)
> >   		return error;
> > -	error = security_path_truncate(path);
> > +	error = security_file_truncate(filp);
> >   	if (!error) {
> >   		error = do_truncate(mnt_userns, path->dentry, 0,
> >   				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> > diff --git a/fs/open.c b/fs/open.c
> > index cf7e5c350a54..0fa861873245 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -188,7 +188,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
> >   	if (IS_APPEND(file_inode(f.file)))
> >   		goto out_putf;
> >   	sb_start_write(inode->i_sb);
> > -	error = security_path_truncate(&f.file->f_path);
> > +	error = security_file_truncate(f.file);
> >   	if (!error)
> >   		error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
> >   				    ATTR_MTIME | ATTR_CTIME, f.file);
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 60fff133c0b1..dee35ab253ba 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -177,6 +177,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
> >   	 struct fown_struct *fown, int sig)
> >   LSM_HOOK(int, 0, file_receive, struct file *file)
> >   LSM_HOOK(int, 0, file_open, struct file *file)
> > +LSM_HOOK(int, 0, file_truncate, struct file *file)
> >   LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
> >   	 unsigned long clone_flags)
> >   LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 3aa6030302f5..4acc975f28d9 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -409,7 +409,9 @@
> >    *	@attr is the iattr structure containing the new file attributes.
> >    *	Return 0 if permission is granted.
> >    * @path_truncate:
> > - *	Check permission before truncating a file.
> > + *	Check permission before truncating the file indicated by path.
> > + *      Note that truncation permissions may also be checked based on
> > + *      already opened files, using the @file_truncate hook.
> 
> The documentation comments (mostly) use tabs, not spaces.

Oops, well spotted. Done.

> >    *	@path contains the path structure for the file.
> >    *	Return 0 if permission is granted.
> >    * @inode_getattr:
> > @@ -598,6 +600,12 @@
> >    *	to receive an open file descriptor via socket IPC.
> >    *	@file contains the file structure being received.
> >    *	Return 0 if permission is granted.
> > + * @file_truncate:
> > + *	Check permission before truncating a file, i.e. using ftruncate.
> > + *	Note that truncation permission may also be checked based on the path,
> > + *      using the @path_truncate hook.
> 
> Same here.

Done.

> > + *	@file contains the file structure for the file.
> > + *	Return 0 if permission is granted.
> >    * @file_open:
> >    *	Save open-time permission checking state for later use upon
> >    *	file_permission, and recheck access if anything has changed
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 7bd0c490703d..f80b23382dd9 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -394,6 +394,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
> >   				 struct fown_struct *fown, int sig);
> >   int security_file_receive(struct file *file);
> >   int security_file_open(struct file *file);
> > +int security_file_truncate(struct file *file);
> >   int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
> >   void security_task_free(struct task_struct *task);
> >   int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
> > @@ -1011,6 +1012,11 @@ static inline int security_file_open(struct file *file)
> >   	return 0;
> >   }
> > +static inline int security_file_truncate(struct file *file)
> > +{
> > +	return 0;
> > +}
> > +
> >   static inline int security_task_alloc(struct task_struct *task,
> >   				      unsigned long clone_flags)
> >   {
> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index e29cade7b662..98ecb7f221b8 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -329,6 +329,11 @@ static int apparmor_path_truncate(const struct path *path)
> >   	return common_perm_cond(OP_TRUNC, path, MAY_WRITE | AA_MAY_SETATTR);
> >   }
> > +static int apparmor_file_truncate(struct file *file)
> > +{
> > +	return apparmor_path_truncate(&file->f_path);
> > +}
> > +
> >   static int apparmor_path_symlink(const struct path *dir, struct dentry *dentry,
> >   				 const char *old_name)
> >   {
> > @@ -1232,6 +1237,7 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
> >   	LSM_HOOK_INIT(mmap_file, apparmor_mmap_file),
> >   	LSM_HOOK_INIT(file_mprotect, apparmor_file_mprotect),
> >   	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
> > +	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
> >   	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
> >   	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
> > diff --git a/security/security.c b/security/security.c
> > index 4b95de24bc8d..d73e423005c3 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1650,6 +1650,11 @@ int security_file_open(struct file *file)
> >   	return fsnotify_perm(file, MAY_OPEN);
> >   }
> > +int security_file_truncate(struct file *file)
> > +{
> > +	return call_int_hook(file_truncate, 0, file);
> > +}
> > +
> >   int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
> >   {
> >   	int rc = lsm_task_alloc(task);
> > diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> > index 71e82d855ebf..af04a7b7eb28 100644
> > --- a/security/tomoyo/tomoyo.c
> > +++ b/security/tomoyo/tomoyo.c
> > @@ -134,6 +134,18 @@ static int tomoyo_path_truncate(const struct path *path)
> >   	return tomoyo_path_perm(TOMOYO_TYPE_TRUNCATE, path, NULL);
> >   }
> > +/**
> > + * tomoyo_file_truncate - Target for security_file_truncate().
> > + *
> > + * @file: Pointer to "struct file".
> > + *
> > + * Returns 0 on success, negative value otherwise.
> > + */
> > +static int tomoyo_file_truncate(struct file *file)
> > +{
> > +	return tomoyo_path_truncate(&file->f_path);
> > +}
> > +
> >   /**
> >    * tomoyo_path_unlink - Target for security_path_unlink().
> >    *
> > @@ -545,6 +557,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
> >   	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
> >   	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
> >   	LSM_HOOK_INIT(file_open, tomoyo_file_open),
> > +	LSM_HOOK_INIT(file_truncate, tomoyo_file_truncate),
> >   	LSM_HOOK_INIT(path_truncate, tomoyo_path_truncate),
> >   	LSM_HOOK_INIT(path_unlink, tomoyo_path_unlink),
> >   	LSM_HOOK_INIT(path_mkdir, tomoyo_path_mkdir),

-- 
