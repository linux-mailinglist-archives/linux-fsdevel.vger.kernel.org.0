Return-Path: <linux-fsdevel+bounces-25681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A0E94EDC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 15:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DB6B220DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013AF17BB3C;
	Mon, 12 Aug 2024 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jy8mZvhJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01359172BAE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468192; cv=none; b=Hne+MEDXiPyJUVsi4gR3WMUz1RtHdVVwh8MqIfUlMMHqAxTYB1/CpbKkIh2gjduOCCc0VgSmN8PWLXPcBxxsdRafcRWD51UoXslMIgF32458Ot8uolhNJpsNpfpJBNJSOZ6R53Z/WUGt9GPs2UcyoDeCjCkKBCAsV+u/xoVEi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468192; c=relaxed/simple;
	bh=XuSOayIH70o7IVhRaPmRuIBaK0yehYX0NvvYSDsICQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFE74hRWCqQ/yoe+PHmXdhgmRblgGSw5eyUPpu18pzSBroM9kF9fuGxCj2dlcFRAuWF5cUPj6ZRSSBUHg7jUIOknoF7m2x+rVNyPt9juHV83Ocnhx/2uPMZ766722j2pvH4RG76N/LV48O1+ikW3u3jpNJZgPIUqLm9UMO+6eR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jy8mZvhJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so12181a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723468187; x=1724072987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls1EQum4EqEz/9DOCbL3uNQIUCvLdyOyGXLo6Ssqbkw=;
        b=jy8mZvhJO7clulRD8kEup/o1bq7QpUc5N004tCbSR5Exoy5eHvyxVo6CJCZq4mC1BU
         QBXMxlEgYx9s0vSxotoyIFFz/9CmM1KZJL8HokXGdVMuq8vEm0ksQ5Spm2G1kS8Dv+Rg
         b6FrIXSA9jlNELNmLGl2P4BpePN4hEdXnnISJBiNT8SpYiXeqWKKmaX4qOoiEOcBTZ/o
         IZoysJMRO3jMMKE9H3OsnwevmKKm07e1oZTR4bkTMs1bR/EwO0nG8JyB8ekjVCTLwIv5
         VvMm/u8iOo0SFYtzVOXXF2VAd35RH4Ty52+KmOVVJSfZ3GcUR4UPAssjfP9+jth3D0vj
         FMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723468187; x=1724072987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls1EQum4EqEz/9DOCbL3uNQIUCvLdyOyGXLo6Ssqbkw=;
        b=FLIwC9OUyUxDIwM2X4/pDHuP6svJP5N4aPcIGLAhzlilTp0YAs/lRQONzFA5P8fF8O
         ESf3RFQhVHthtcmZX5Kx+mM6pF1KfqsUwD2OiyfT9G9YhQfkgYigqCimz+SNGPl3PtlO
         4WXispsKiq9xjuSjhToboY3l2MThommPaK22BlRbbAC/oyFRWyxHJzIodIIz+WHc3vE6
         A9zePD/rbaq9/xMWt6s09t6xp6NZjEcCGI2Whyf7+A8N6TneaRGYZ1nfipXCJ6C9vFOt
         6kzHbx1rNBP9j2UXsP6aKbEXweuWb6Un9UC5WRO4VqNP4Jb5VlIxeNImSUgrM+RFq6iR
         SBWA==
X-Forwarded-Encrypted: i=1; AJvYcCVJpGczQ8VEVEQif5DsccaJsQLRXrsf5Ae6Nn5QsHNIcoZR5Uo4V3Zl9B6i2NtNcAJhVqUSpv1oUY0Syl4PkXoo2yzT7EiQZB7eT3icDA==
X-Gm-Message-State: AOJu0YwYr0zXtJdx0XZUoXdTIT49VNzaNFtJC8HHDP00ngjWZOqRbOsF
	7tfzs8nR5MxSeEYDZ/2aZdW9UNrL5sZtQPaEhYT0T70CQXo53UNMlKnOskvZNAxVdUxhaOUkgAr
	In55hr8/XgGdmHMvpPhdmtSCzZjFz/yHT15x7
X-Google-Smtp-Source: AGHT+IF4O9MWp/TaJmKD/SC7ej+tWIMifYSlqDVKCENSkDWUvlwhjGdHM4/J9PaotRqXm/Y4AhC2MpoGk6Y/5sVHXaI=
X-Received: by 2002:a05:6402:50cd:b0:5a0:d4ce:59a6 with SMTP id
 4fb4d7f45d1cf-5bd14b96b81mr249635a12.2.1723468186566; Mon, 12 Aug 2024
 06:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net> <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net> <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net> <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net> <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
 <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
In-Reply-To: <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 12 Aug 2024 15:09:08 +0200
Message-ID: <CAG48ez1fVS=Hg0szXxQym9Yfw4Pgs1THeviXO7wLXbC2-YrLEg@mail.gmail.com>
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:04=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, Aug 9, 2024 at 10:01=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > On Fri, Aug 9, 2024 at 3:18=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > Talking about f_modown() and security_file_set_fowner(), it looks lik=
e
> > > there are some issues:
> > >
> > > On Fri, Aug 09, 2024 at 02:44:06PM +0200, Jann Horn wrote:
> > > > On Fri, Aug 9, 2024 at 12:59=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > >
> > > [...]
> > >
> > > > > BTW, I don't understand why neither SELinux nor Smack use (explic=
it)
> > > > > atomic operations nor lock.
> > > >
> > > > Yeah, I think they're sloppy and kinda wrong - but it sorta works i=
n
> > > > practice mostly because they don't have to do any refcounting aroun=
d
> > > > this?
> > > >
> > > > > And it looks weird that
> > > > > security_file_set_fowner() isn't called by f_modown() with the sa=
me
> > > > > locking to avoid races.
> > > >
> > > > True. I imagine maybe the thought behind this design could have bee=
n
> > > > that LSMs should have their own locking, and that calling an LSM ho=
ok
> > > > with IRQs off is a little weird? But the way the LSMs actually use =
the
> > > > hook now, it might make sense to call the LSM with the lock held an=
d
> > > > IRQs off...
> > > >
> > >
> > > Would it be OK (for VFS, SELinux, and Smack maintainers) to move the
> > > security_file_set_fowner() call into f_modown(), especially where
> > > UID/EUID are populated.  That would only call security_file_set_fowne=
r()
> > > when the fown is actually set, which I think could also fix a bug for
> > > SELinux and Smack.
> > >
> > > Could we replace the uid and euid fields with a pointer to the curren=
t
> > > credentials?  This would enables LSMs to not copy the same kind of
> > > credential informations and save some memory, simplify credential
> > > management, and improve consistency.
> >
> > To clarify: These two paragraphs are supposed to be two alternative
> > options, right? One option is to call security_file_set_fowner() with
> > the lock held, the other option is to completely rip out the
> > security_file_set_fowner() hook and instead let the VFS provide LSMs
> > with the creds they need for the file_send_sigiotask hook?
>
> I'm not entirely clear on what is being proposed either.  Some quick
> pseudo code might do wonders here to help clarify things.
>
> From a LSM perspective I suspect we are always going to need some sort
> of hook in the F_SETOWN code path as the LSM needs to potentially
> capture state/attributes/something-LSM-specific at that
> context/point-in-time.

The only thing LSMs currently do there is capture state from
current->cred. So if the VFS takes care of capturing current->cred
there, we should be able to rip out all the file_set_fowner stuff.
Something like this (totally untested):

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 300e5d9ad913..17f159bf625f 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -98,8 +98,9 @@ static void f_modown(struct file *filp, struct pid
*pid, enum pid_type type,

                 if (pid) {
                         const struct cred *cred =3D current_cred();
-                        filp->f_owner.uid =3D cred->uid;
-                        filp->f_owner.euid =3D cred->euid;
+                        if (filp->f_owner.owner_cred)
+                                put_cred(filp->f_owner.owner_cred);
+                        filp->f_owner.owner_cred =3D get_current_cred();
                 }
         }
         write_unlock_irq(&filp->f_owner.lock);
@@ -108,7 +109,6 @@ static void f_modown(struct file *filp, struct pid
*pid, enum pid_type type,
 void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
                 int force)
 {
-        security_file_set_fowner(filp);
         f_modown(filp, pid, type, force);
 }
 EXPORT_SYMBOL(__f_setown);
diff --git a/fs/file_table.c b/fs/file_table.c
index ca7843dde56d..440796fc8e91 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -426,6 +426,8 @@ static void __fput(struct file *file)
         }
         fops_put(file->f_op);
         put_pid(file->f_owner.pid);
+        if (file->f_owner.owner_cred)
+                put_cred(file->f_owner.owner_cred);
         put_file_access(file);
         dput(dentry);
         if (unlikely(mode & FMODE_NEED_UNMOUNT))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..43bfad373bf9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -950,7 +950,7 @@ struct fown_struct {
         rwlock_t lock;          /* protects pid, uid, euid fields */
         struct pid *pid;        /* pid or -pgrp where SIGIO should be sent=
 */
         enum pid_type pid_type;        /* Kind of process group SIGIO
should be sent to */
-        kuid_t uid, euid;        /* uid/euid of process setting the owner =
*/
+        const struct cred __rcu *owner_cred;
         int signum;                /* posix.1b rt signal to be
delivered on IO */
 };

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 855db460e08b..2c0935dd079e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -197,7 +197,6 @@ LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *=
vma,
 LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
 LSM_HOOK(int, 0, file_fcntl, struct file *file, unsigned int cmd,
          unsigned long arg)
-LSM_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)
 LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
          struct fown_struct *fown, int sig)
 LSM_HOOK(int, 0, file_receive, struct file *file)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1390f1efb4f0..3343db05fa2e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1079,11 +1079,6 @@ static inline int security_file_fcntl(struct
file *file, unsigned int cmd,
         return 0;
 }

-static inline void security_file_set_fowner(struct file *file)
-{
-        return;
-}
-
 static inline int security_file_send_sigiotask(struct task_struct *tsk,
                                                struct fown_struct *fown,
                                                int sig)
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..a53d8d7fe815 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2924,20 +2924,6 @@ int security_file_fcntl(struct file *file,
unsigned int cmd, unsigned long arg)
         return call_int_hook(file_fcntl, file, cmd, arg);
 }

-/**
- * security_file_set_fowner() - Set the file owner info in the LSM blob
- * @file: the file
- *
- * Save owner security information (typically from current->security) in
- * file->f_security for later use by the send_sigiotask hook.
- *
- * Return: Returns 0 on success.
- */
-void security_file_set_fowner(struct file *file)
-{
-        call_void_hook(file_set_fowner, file);
-}
-
 /**
  * security_file_send_sigiotask() - Check if sending SIGIO/SIGURG is allow=
ed
  * @tsk: target task
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 55c78c318ccd..37675d280837 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3649,7 +3649,6 @@ static int selinux_file_alloc_security(struct file *f=
ile)
         u32 sid =3D current_sid();

         fsec->sid =3D sid;
-        fsec->fown_sid =3D sid;

         return 0;
 }
@@ -3923,24 +3922,16 @@ static int selinux_file_fcntl(struct file
*file, unsigned int cmd,
         return err;
 }

-static void selinux_file_set_fowner(struct file *file)
-{
-        struct file_security_struct *fsec;
-
-        fsec =3D selinux_file(file);
-        fsec->fown_sid =3D current_sid();
-}
-
 static int selinux_file_send_sigiotask(struct task_struct *tsk,
                                        struct fown_struct *fown, int signu=
m)
 {
-        struct file *file;
+        /* struct fown_struct is never outside the context of a struct fil=
e */
+        struct file *file =3D container_of(fown, struct file, f_owner);
         u32 sid =3D task_sid_obj(tsk);
         u32 perm;
         struct file_security_struct *fsec;
-
-        /* struct fown_struct is never outside the context of a struct fil=
e */
-        file =3D container_of(fown, struct file, f_owner);
+        struct cred_struct *fown_cred =3D rcu_dereference(fown->owner_cred=
);
+        u32 fown_sid =3D cred_sid(fown_cred ?: file->f_cred);

         fsec =3D selinux_file(file);

@@ -3949,7 +3940,7 @@ static int selinux_file_send_sigiotask(struct
task_struct *tsk,
         else
                 perm =3D signal_to_av(signum);

-        return avc_has_perm(fsec->fown_sid, sid,
+        return avc_has_perm(fown_sid, sid,
                             SECCLASS_PROCESS, perm, NULL);
 }

diff --git a/security/selinux/include/objsec.h
b/security/selinux/include/objsec.h
index dea1d6f3ed2d..d55b7f8d3a3d 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -56,7 +56,6 @@ struct inode_security_struct {

 struct file_security_struct {
         u32 sid; /* SID of open file description */
-        u32 fown_sid; /* SID of file owner (for SIGIO) */
         u32 isid; /* SID of inode at the time of file open */
         u32 pseqno; /* Policy seqno at the time of file open */
 };
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 041688e5a77a..06bac00cc796 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -328,12 +328,6 @@ static inline struct task_smack *smack_cred(const
struct cred *cred)
         return cred->security + smack_blob_sizes.lbs_cred;
 }

-static inline struct smack_known **smack_file(const struct file *file)
-{
-        return (struct smack_known **)(file->f_security +
-                                       smack_blob_sizes.lbs_file);
-}
-
 static inline struct inode_smack *smack_inode(const struct inode *inode)
 {
         return inode->i_security + smack_blob_sizes.lbs_inode;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4164699cd4f6..02caa8b9d456 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1675,26 +1675,6 @@ static void smack_inode_getsecid(struct inode
*inode, u32 *secid)
  * label changing that SELinux does.
  */

-/**
- * smack_file_alloc_security - assign a file security blob
- * @file: the object
- *
- * The security blob for a file is a pointer to the master
- * label list, so no allocation is done.
- *
- * f_security is the owner security information. It
- * isn't used on file access checks, it's for send_sigio.
- *
- * Returns 0
- */
-static int smack_file_alloc_security(struct file *file)
-{
-        struct smack_known **blob =3D smack_file(file);
-
-        *blob =3D smk_of_current();
-        return 0;
-}
-
 /**
  * smack_file_ioctl - Smack check on ioctls
  * @file: the object
@@ -1913,18 +1893,6 @@ static int smack_mmap_file(struct file *file,
         return rc;
 }

-/**
- * smack_file_set_fowner - set the file security blob value
- * @file: object in question
- *
- */
-static void smack_file_set_fowner(struct file *file)
-{
-        struct smack_known **blob =3D smack_file(file);
-
-        *blob =3D smk_of_current();
-}
-
 /**
  * smack_file_send_sigiotask - Smack on sigio
  * @tsk: The target task
@@ -1946,6 +1914,7 @@ static int smack_file_send_sigiotask(struct
task_struct *tsk,
         struct file *file;
         int rc;
         struct smk_audit_info ad;
+        struct cred_struct *fown_cred =3D rcu_dereference(fown->owner_cred=
);

         /*
          * struct fown_struct is never outside the context of a struct fil=
e
@@ -1953,8 +1922,7 @@ static int smack_file_send_sigiotask(struct
task_struct *tsk,
         file =3D container_of(fown, struct file, f_owner);

         /* we don't log here as rc can be overriden */
-        blob =3D smack_file(file);
-        skp =3D *blob;
+        skp =3D smk_of_task(fown_cred ?: file->f_cred);
         rc =3D smk_access(skp, tkp, MAY_DELIVER, NULL);
         rc =3D smk_bu_note("sigiotask", skp, tkp, MAY_DELIVER, rc);

@@ -5045,7 +5013,6 @@ static int smack_uring_cmd(struct io_uring_cmd *ioucm=
d)

 struct lsm_blob_sizes smack_blob_sizes __ro_after_init =3D {
         .lbs_cred =3D sizeof(struct task_smack),
-        .lbs_file =3D sizeof(struct smack_known *),
         .lbs_inode =3D sizeof(struct inode_smack),
         .lbs_ipc =3D sizeof(struct smack_known *),
         .lbs_msg_msg =3D sizeof(struct smack_known *),
@@ -5104,7 +5071,6 @@ static struct security_hook_list smack_hooks[]
__ro_after_init =3D {
         LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
         LSM_HOOK_INIT(mmap_file, smack_mmap_file),
         LSM_HOOK_INIT(mmap_addr, cap_mmap_addr),
-        LSM_HOOK_INIT(file_set_fowner, smack_file_set_fowner),
         LSM_HOOK_INIT(file_send_sigiotask, smack_file_send_sigiotask),
         LSM_HOOK_INIT(file_receive, smack_file_receive),


> While I think it is okay if we want to
> consider relocating the security_file_set_fowner() within the F_SETOWN
> call path, I don't think we can remove it, even if we add additional
> LSM security blobs.

