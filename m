Return-Path: <linux-fsdevel+bounces-25688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E02A94F0E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255B42802B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08151836E2;
	Mon, 12 Aug 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1dEqBg7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78717995B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474538; cv=none; b=uUyDVvseY0FVUCQa3aRKNBDXFr68IJLmOpnbp+R0wJ5fLE8kodiDehUaGgzzuIBPlG929wghAP8uToHdPLp4qX7F77i4ts6rN6R6RLKoZRhEjVelTCbs8fh6tGwY/vKnmWPoCiRoNizy/cIOFY+5eIEk15Ae8+rHNHkq4Ofz2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474538; c=relaxed/simple;
	bh=cnDpdrm13dHtO9Gg61AUiFS8DfCZudSa8Aw9uflY/MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWfc9V6HId0p6F57cZKTC4wZiq1mkLnzl3i8ltgzrTPNoPRhjw0RR3YaSlpL8xaBFt0UbOyPctOZJIFW/XXSFxzkDcVeceq3D2OZCNPlB8etBk0aTnn3TENLyfl9Zg2KtG6gh3zQ+u4ouMfBDGsl7EopO8ss75a4mTisZyGouyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1dEqBg7E; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WjHcs5ZFXz6gY;
	Mon, 12 Aug 2024 16:55:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723474525;
	bh=+pagtIEzEkDnaFraRqloWEhcaDpOaeWNtHprP7Coe0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1dEqBg7EqDV5+VXYHsY74WwH+vX/MnClkmUSQiT9pYxngCnuaXMZdkzzrrQ3lcn2U
	 EFGf4eIif1GA083s/dp9ne2JfTdk4YAvg+JYsp6+0yzncBwQoGFgLEk6nGL80oXqE0
	 c/9+OBNbsyOh3q8dMPERIf2Lh2c6VKqM5oSqQkAI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WjHcs0MPmz5NT;
	Mon, 12 Aug 2024 16:55:25 +0200 (CEST)
Date: Mon, 12 Aug 2024 16:55:19 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
Message-ID: <20240812.reij9aiNg5Nu@digikod.net>
References: <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net>
 <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net>
 <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net>
 <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
 <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
 <CAG48ez1fVS=Hg0szXxQym9Yfw4Pgs1THeviXO7wLXbC2-YrLEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1fVS=Hg0szXxQym9Yfw4Pgs1THeviXO7wLXbC2-YrLEg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 12, 2024 at 03:09:08PM +0200, Jann Horn wrote:
> On Mon, Aug 12, 2024 at 12:04 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Fri, Aug 9, 2024 at 10:01 AM Jann Horn <jannh@google.com> wrote:
> > > On Fri, Aug 9, 2024 at 3:18 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > Talking about f_modown() and security_file_set_fowner(), it looks like
> > > > there are some issues:
> > > >
> > > > On Fri, Aug 09, 2024 at 02:44:06PM +0200, Jann Horn wrote:
> > > > > On Fri, Aug 9, 2024 at 12:59 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > [...]
> > > >
> > > > > > BTW, I don't understand why neither SELinux nor Smack use (explicit)
> > > > > > atomic operations nor lock.
> > > > >
> > > > > Yeah, I think they're sloppy and kinda wrong - but it sorta works in
> > > > > practice mostly because they don't have to do any refcounting around
> > > > > this?
> > > > >
> > > > > > And it looks weird that
> > > > > > security_file_set_fowner() isn't called by f_modown() with the same
> > > > > > locking to avoid races.
> > > > >
> > > > > True. I imagine maybe the thought behind this design could have been
> > > > > that LSMs should have their own locking, and that calling an LSM hook
> > > > > with IRQs off is a little weird? But the way the LSMs actually use the
> > > > > hook now, it might make sense to call the LSM with the lock held and
> > > > > IRQs off...
> > > > >
> > > >
> > > > Would it be OK (for VFS, SELinux, and Smack maintainers) to move the
> > > > security_file_set_fowner() call into f_modown(), especially where
> > > > UID/EUID are populated.  That would only call security_file_set_fowner()
> > > > when the fown is actually set, which I think could also fix a bug for
> > > > SELinux and Smack.
> > > >
> > > > Could we replace the uid and euid fields with a pointer to the current
> > > > credentials?  This would enables LSMs to not copy the same kind of
> > > > credential informations and save some memory, simplify credential
> > > > management, and improve consistency.
> > >
> > > To clarify: These two paragraphs are supposed to be two alternative
> > > options, right? One option is to call security_file_set_fowner() with
> > > the lock held, the other option is to completely rip out the
> > > security_file_set_fowner() hook and instead let the VFS provide LSMs
> > > with the creds they need for the file_send_sigiotask hook?
> >
> > I'm not entirely clear on what is being proposed either.  Some quick
> > pseudo code might do wonders here to help clarify things.
> >
> > From a LSM perspective I suspect we are always going to need some sort
> > of hook in the F_SETOWN code path as the LSM needs to potentially
> > capture state/attributes/something-LSM-specific at that
> > context/point-in-time.
> 
> The only thing LSMs currently do there is capture state from
> current->cred. So if the VFS takes care of capturing current->cred
> there, we should be able to rip out all the file_set_fowner stuff.
> Something like this (totally untested):

I just sent a quite similar patch just before syncing my emails...  The
main difference seems to be related to the initialization of the
f_owner's credentials.

> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 300e5d9ad913..17f159bf625f 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -98,8 +98,9 @@ static void f_modown(struct file *filp, struct pid
> *pid, enum pid_type type,
> 
>                  if (pid) {
>                          const struct cred *cred = current_cred();
> -                        filp->f_owner.uid = cred->uid;
> -                        filp->f_owner.euid = cred->euid;
> +                        if (filp->f_owner.owner_cred)
> +                                put_cred(filp->f_owner.owner_cred);
> +                        filp->f_owner.owner_cred = get_current_cred();
>                  }
>          }
>          write_unlock_irq(&filp->f_owner.lock);
> @@ -108,7 +109,6 @@ static void f_modown(struct file *filp, struct pid
> *pid, enum pid_type type,
>  void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
>                  int force)
>  {
> -        security_file_set_fowner(filp);
>          f_modown(filp, pid, type, force);
>  }
>  EXPORT_SYMBOL(__f_setown);
> diff --git a/fs/file_table.c b/fs/file_table.c
> index ca7843dde56d..440796fc8e91 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -426,6 +426,8 @@ static void __fput(struct file *file)
>          }
>          fops_put(file->f_op);
>          put_pid(file->f_owner.pid);
> +        if (file->f_owner.owner_cred)
> +                put_cred(file->f_owner.owner_cred);
>          put_file_access(file);
>          dput(dentry);
>          if (unlikely(mode & FMODE_NEED_UNMOUNT))
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..43bfad373bf9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -950,7 +950,7 @@ struct fown_struct {
>          rwlock_t lock;          /* protects pid, uid, euid fields */
>          struct pid *pid;        /* pid or -pgrp where SIGIO should be sent */
>          enum pid_type pid_type;        /* Kind of process group SIGIO
> should be sent to */
> -        kuid_t uid, euid;        /* uid/euid of process setting the owner */
> +        const struct cred __rcu *owner_cred;
>          int signum;                /* posix.1b rt signal to be
> delivered on IO */
>  };
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 855db460e08b..2c0935dd079e 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -197,7 +197,6 @@ LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
>  LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
>  LSM_HOOK(int, 0, file_fcntl, struct file *file, unsigned int cmd,
>           unsigned long arg)
> -LSM_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)
>  LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
>           struct fown_struct *fown, int sig)
>  LSM_HOOK(int, 0, file_receive, struct file *file)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1390f1efb4f0..3343db05fa2e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1079,11 +1079,6 @@ static inline int security_file_fcntl(struct
> file *file, unsigned int cmd,
>          return 0;
>  }
> 
> -static inline void security_file_set_fowner(struct file *file)
> -{
> -        return;
> -}
> -
>  static inline int security_file_send_sigiotask(struct task_struct *tsk,
>                                                 struct fown_struct *fown,
>                                                 int sig)
> diff --git a/security/security.c b/security/security.c
> index 8cee5b6c6e6d..a53d8d7fe815 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2924,20 +2924,6 @@ int security_file_fcntl(struct file *file,
> unsigned int cmd, unsigned long arg)
>          return call_int_hook(file_fcntl, file, cmd, arg);
>  }
> 
> -/**
> - * security_file_set_fowner() - Set the file owner info in the LSM blob
> - * @file: the file
> - *
> - * Save owner security information (typically from current->security) in
> - * file->f_security for later use by the send_sigiotask hook.
> - *
> - * Return: Returns 0 on success.
> - */
> -void security_file_set_fowner(struct file *file)
> -{
> -        call_void_hook(file_set_fowner, file);
> -}
> -
>  /**
>   * security_file_send_sigiotask() - Check if sending SIGIO/SIGURG is allowed
>   * @tsk: target task
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 55c78c318ccd..37675d280837 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3649,7 +3649,6 @@ static int selinux_file_alloc_security(struct file *file)
>          u32 sid = current_sid();
> 
>          fsec->sid = sid;
> -        fsec->fown_sid = sid;
> 
>          return 0;
>  }
> @@ -3923,24 +3922,16 @@ static int selinux_file_fcntl(struct file
> *file, unsigned int cmd,
>          return err;
>  }
> 
> -static void selinux_file_set_fowner(struct file *file)
> -{
> -        struct file_security_struct *fsec;
> -
> -        fsec = selinux_file(file);
> -        fsec->fown_sid = current_sid();
> -}
> -
>  static int selinux_file_send_sigiotask(struct task_struct *tsk,
>                                         struct fown_struct *fown, int signum)
>  {
> -        struct file *file;
> +        /* struct fown_struct is never outside the context of a struct file */
> +        struct file *file = container_of(fown, struct file, f_owner);
>          u32 sid = task_sid_obj(tsk);
>          u32 perm;
>          struct file_security_struct *fsec;
> -
> -        /* struct fown_struct is never outside the context of a struct file */
> -        file = container_of(fown, struct file, f_owner);
> +        struct cred_struct *fown_cred = rcu_dereference(fown->owner_cred);
> +        u32 fown_sid = cred_sid(fown_cred ?: file->f_cred);
> 
>          fsec = selinux_file(file);
> 
> @@ -3949,7 +3940,7 @@ static int selinux_file_send_sigiotask(struct
> task_struct *tsk,
>          else
>                  perm = signal_to_av(signum);
> 
> -        return avc_has_perm(fsec->fown_sid, sid,
> +        return avc_has_perm(fown_sid, sid,
>                              SECCLASS_PROCESS, perm, NULL);
>  }
> 
> diff --git a/security/selinux/include/objsec.h
> b/security/selinux/include/objsec.h
> index dea1d6f3ed2d..d55b7f8d3a3d 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -56,7 +56,6 @@ struct inode_security_struct {
> 
>  struct file_security_struct {
>          u32 sid; /* SID of open file description */
> -        u32 fown_sid; /* SID of file owner (for SIGIO) */
>          u32 isid; /* SID of inode at the time of file open */
>          u32 pseqno; /* Policy seqno at the time of file open */
>  };
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 041688e5a77a..06bac00cc796 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -328,12 +328,6 @@ static inline struct task_smack *smack_cred(const
> struct cred *cred)
>          return cred->security + smack_blob_sizes.lbs_cred;
>  }
> 
> -static inline struct smack_known **smack_file(const struct file *file)
> -{
> -        return (struct smack_known **)(file->f_security +
> -                                       smack_blob_sizes.lbs_file);
> -}
> -
>  static inline struct inode_smack *smack_inode(const struct inode *inode)
>  {
>          return inode->i_security + smack_blob_sizes.lbs_inode;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 4164699cd4f6..02caa8b9d456 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1675,26 +1675,6 @@ static void smack_inode_getsecid(struct inode
> *inode, u32 *secid)
>   * label changing that SELinux does.
>   */
> 
> -/**
> - * smack_file_alloc_security - assign a file security blob
> - * @file: the object
> - *
> - * The security blob for a file is a pointer to the master
> - * label list, so no allocation is done.
> - *
> - * f_security is the owner security information. It
> - * isn't used on file access checks, it's for send_sigio.
> - *
> - * Returns 0
> - */
> -static int smack_file_alloc_security(struct file *file)
> -{
> -        struct smack_known **blob = smack_file(file);
> -
> -        *blob = smk_of_current();
> -        return 0;
> -}
> -
>  /**
>   * smack_file_ioctl - Smack check on ioctls
>   * @file: the object
> @@ -1913,18 +1893,6 @@ static int smack_mmap_file(struct file *file,
>          return rc;
>  }
> 
> -/**
> - * smack_file_set_fowner - set the file security blob value
> - * @file: object in question
> - *
> - */
> -static void smack_file_set_fowner(struct file *file)
> -{
> -        struct smack_known **blob = smack_file(file);
> -
> -        *blob = smk_of_current();
> -}
> -
>  /**
>   * smack_file_send_sigiotask - Smack on sigio
>   * @tsk: The target task
> @@ -1946,6 +1914,7 @@ static int smack_file_send_sigiotask(struct
> task_struct *tsk,
>          struct file *file;
>          int rc;
>          struct smk_audit_info ad;
> +        struct cred_struct *fown_cred = rcu_dereference(fown->owner_cred);
> 
>          /*
>           * struct fown_struct is never outside the context of a struct file
> @@ -1953,8 +1922,7 @@ static int smack_file_send_sigiotask(struct
> task_struct *tsk,
>          file = container_of(fown, struct file, f_owner);
> 
>          /* we don't log here as rc can be overriden */
> -        blob = smack_file(file);
> -        skp = *blob;
> +        skp = smk_of_task(fown_cred ?: file->f_cred);
>          rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
>          rc = smk_bu_note("sigiotask", skp, tkp, MAY_DELIVER, rc);
> 
> @@ -5045,7 +5013,6 @@ static int smack_uring_cmd(struct io_uring_cmd *ioucmd)
> 
>  struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
>          .lbs_cred = sizeof(struct task_smack),
> -        .lbs_file = sizeof(struct smack_known *),
>          .lbs_inode = sizeof(struct inode_smack),
>          .lbs_ipc = sizeof(struct smack_known *),
>          .lbs_msg_msg = sizeof(struct smack_known *),
> @@ -5104,7 +5071,6 @@ static struct security_hook_list smack_hooks[]
> __ro_after_init = {
>          LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
>          LSM_HOOK_INIT(mmap_file, smack_mmap_file),
>          LSM_HOOK_INIT(mmap_addr, cap_mmap_addr),
> -        LSM_HOOK_INIT(file_set_fowner, smack_file_set_fowner),
>          LSM_HOOK_INIT(file_send_sigiotask, smack_file_send_sigiotask),
>          LSM_HOOK_INIT(file_receive, smack_file_receive),
> 
> 
> > While I think it is okay if we want to
> > consider relocating the security_file_set_fowner() within the F_SETOWN
> > call path, I don't think we can remove it, even if we add additional
> > LSM security blobs.

> 

