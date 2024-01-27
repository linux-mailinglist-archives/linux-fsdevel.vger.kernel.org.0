Return-Path: <linux-fsdevel+bounces-9201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5609C83ECC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 12:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABC4283CAC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 11:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7FF200C6;
	Sat, 27 Jan 2024 11:01:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ABB1F5F3;
	Sat, 27 Jan 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706353311; cv=none; b=leHmj0JlsLIvssn/Uir6ReB6AJry/yfYUvFXi8tUehTlNDJT+Hjr7PJ3OdwwI/Y0Qg4KtiTCzdN8jPudME9E9eGce/YBe3AjkiDuS5AC4ytVql3VoL2/e99kKPaA85XgXhbiqlkWkEvfJUjesCIOK//BWBQwQijb+xJUoEQzvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706353311; c=relaxed/simple;
	bh=nwJoZTMjRp6iFY9PYP+mBLktnn7ncOnrJvkM3yvzPYA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LmubbrbWnNBvgCAxrG2/Ow8GJ5ySd9wd6bZow+DutBI9FZbus/xMYA67K4FnkZT6OLQPedSvkU+2sD0+XeoZ2arZtF3mIURNXbrqECIwmAKLQ6Y/ieHifsODgVT4Of24p6zS7DXXuLHz8XiAK+UDyWLtclwVd+qMAScENKwSkvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40RB0ZbX048405;
	Sat, 27 Jan 2024 20:00:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sat, 27 Jan 2024 20:00:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40RB0Z1N048400
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Jan 2024 20:00:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0d820f39-2b9e-4294-801b-4fe30c71f497@I-love.SAKURA.ne.jp>
Date: Sat, 27 Jan 2024 20:00:35 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
        Kevin Locke <kevin@kevinlocke.name>,
        Josh Triplett <josh@joshtriplett.org>,
        Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook>
 <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
 <a9210754-2f94-4075-872f-8f6a18f4af07@I-love.SAKURA.ne.jp>
 <CAHk-=wjF=zwZ88vRZe-AvexnmP1OCpKZSp_2aCfTpGeH1vLMkA@mail.gmail.com>
 <b5a12ecd-468d-4b50-9f8c-17ae2a2560b4@I-love.SAKURA.ne.jp>
In-Reply-To: <b5a12ecd-468d-4b50-9f8c-17ae2a2560b4@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/27 16:04, Tetsuo Handa wrote:
> If we can accept revival of security_bprm_free(), we can "get rid of current->in_execve flag"
> and "stop saving things across two *independent* execve() calls".

Oops, I found a bug in TOMOYO (and possibly in AppArmor as well).
TOMOYO has to continue depending on current->in_execve flag even if
security_bprm_free() is revived.

v6.7 and current linux.git check the following permissions.

----------------------------------------
<kernel> /usr/lib/systemd/systemd /etc/mail/make /usr/bin/grep
    0: file getattr /etc/ld.so.cache
    1: file getattr /etc/mail/sendmail.cf
    2: file getattr /usr/lib/locale/locale-archive
    3: file getattr /usr/lib64/gconv/gconv-modules.cache
    4: file getattr /usr/lib64/libc-2.17.so
    5: file getattr /usr/lib64/libpcre.so.1.2.0
    6: file getattr /usr/lib64/libpthread-2.17.so
    7: file getattr pipe:[24810]
    8: file ioctl   /etc/mail/sendmail.cf 0x5401
    9: file ioctl   pipe:[24810] 0x5401
   10: file read    /etc/ld.so.cache
   11: file read    /etc/mail/sendmail.cf
   12: file read    /usr/lib/locale/locale-archive
   13: file read    /usr/lib64/gconv/gconv-modules.cache
   14: file read    /usr/lib64/libc-2.17.so
   15: file read    /usr/lib64/libpcre.so.1.2.0
   16: file read    /usr/lib64/libpthread-2.17.so
   17: misc env     LANG
   18: misc env     OLDPWD
   19: misc env     PATH
   20: misc env     PWD
   21: misc env     SENDMAIL_OPTS
   22: misc env     SHLVL
   23: misc env     _
   24: use_group    0
----------------------------------------

But due to "if (f->f_flags & __FMODE_EXEC)" test in current linux.git (or
"if (current->in_execve)" test until v6.7), currently permission for the ELF
loader file (i.e. /lib64/ld-linux-x86-64.so.2 shown below) is not checked.

$ ldd /usr/bin/grep
        linux-vdso.so.1 =>  (0x00007ffc079ac000)
        libpcre.so.1 => /lib64/libpcre.so.1 (0x00007fdcfb000000)
        libc.so.6 => /lib64/libc.so.6 (0x00007fdcfac00000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fdcfa800000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fdcfb400000)

If I make below change

----------------------------------------
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 04a92c3d65d4..34739e4ba5a4 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -329,8 +329,8 @@ static int tomoyo_file_open(struct file *f)
 {
        /* Don't check read permission here if called from execve(). */
        /* Illogically, FMODE_EXEC is in f_flags, not f_mode. */
-       if (f->f_flags & __FMODE_EXEC)
-               return 0;
+       //if (f->f_flags & __FMODE_EXEC)
+       //      return 0;
        return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path,
                                            f->f_flags);
 }
----------------------------------------

permission for the ELF loader file is checked, but causes the caller to
require read permission for /usr/bin/grep in addition to execute permission.

----------------------------------------
<kernel> /usr/lib/systemd/systemd /etc/mail/make /usr/bin/grep
    0: file getattr /etc/ld.so.cache
    1: file getattr /etc/mail/sendmail.cf
    2: file getattr /usr/lib/locale/locale-archive
    3: file getattr /usr/lib64/gconv/gconv-modules.cache
    4: file getattr /usr/lib64/libc-2.17.so
    5: file getattr /usr/lib64/libpcre.so.1.2.0
    6: file getattr /usr/lib64/libpthread-2.17.so
    7: file getattr pipe:[22370]
    8: file ioctl   /etc/mail/sendmail.cf 0x5401
    9: file ioctl   pipe:[22370] 0x5401
   10: file read    /etc/ld.so.cache
   11: file read    /etc/mail/sendmail.cf
   12: file read    /usr/lib/locale/locale-archive
   13: file read    /usr/lib64/gconv/gconv-modules.cache
   14: file read    /usr/lib64/ld-2.17.so
   15: file read    /usr/lib64/libc-2.17.so
   16: file read    /usr/lib64/libpcre.so.1.2.0
   17: file read    /usr/lib64/libpthread-2.17.so
   18: misc env     LANG
   19: misc env     OLDPWD
   20: misc env     PATH
   21: misc env     PWD
   22: misc env     SENDMAIL_OPTS
   23: misc env     SHLVL
   24: misc env     _
   25: use_group    0
----------------------------------------

To make it possible to check permission for the ELF loader file without requiring
the caller of execve() read permission of a program specified in execve() request,
I need to

----------------------------------------
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 04a92c3d65d4..942c08a36027 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -104,11 +104,6 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
                tomoyo_read_unlock(idx);
                return err;
        }
-       /*
-        * Read permission is checked against interpreters using next domain.
-        */
-       return tomoyo_check_open_permission(s->domain_info,
-                                           &bprm->file->f_path, O_RDONLY);
 }

 /**
@@ -327,9 +322,13 @@ static int tomoyo_file_fcntl(struct file *file, unsigned int cmd,
  */
 static int tomoyo_file_open(struct file *f)
 {
-       /* Don't check read permission here if called from execve(). */
-       /* Illogically, FMODE_EXEC is in f_flags, not f_mode. */
-       if (f->f_flags & __FMODE_EXEC)
+       /*
+        * Don't check read permission here if called from execve() for
+        * the first time of that execve() request, for execute permission
+        * will be checked at tomoyo_bprm_check_security() with argv/envp
+        * taken into account.
+        */
+       if (current->in_execve && !tomoyo_task(current)->old_domain_info)
                return 0;
        return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path,
                                            f->f_flags);
----------------------------------------

in addition to moving around in_execve and reviving security_bprm_free().



Apparmor uses similar approach, which is based on an assumption that
permission check is done by bprm hooks.

----------------------------------------
static int apparmor_file_open(struct file *file)
{
        struct aa_file_ctx *fctx = file_ctx(file);
        struct aa_label *label;
        int error = 0;

        if (!path_mediated_fs(file->f_path.dentry))
                return 0;

        /* If in exec, permission is handled by bprm hooks.
         * Cache permissions granted by the previous exec check, with
         * implicit read and executable mmap which are required to
         * actually execute the image.
         *
         * Illogically, FMODE_EXEC is in f_flags, not f_mode.
         */
        if (file->f_flags & __FMODE_EXEC) {
                fctx->allow = MAY_EXEC | MAY_READ | AA_EXEC_MMAP;
                return 0;
        }
---------------------------------------

https://lkml.kernel.org/r/4bb5dd09-9e09-477b-9ea8-d7b9d2fb4760@canonical.com :
> apparmor the hint should be to avoid doing permission work again that we
> are doing in exec. That it regressed anything more than performance here
> is a bug, that will get fixed.

But I can't find apparmor_bprm_check_security() callback.

AppArmor uses apparmor_bprm_creds_for_exec() callback, but
security_bprm_creds_for_exec() is called for only once for each execve() request.
That is, apparmor_bprm_creds_for_exec() is not suitable for checking permission
for interpreter or ELF loader, is it?

https://lkml.kernel.org/r/ff9a525e-8c39-4590-9ace-57f4426cbe74@canonical.com :
> that this even tripped a regression is a bug that I am going to
> have to chase down. The file check at this point should just be
> redundant. 

Then, how does AppArmor check permissions for files opened for interpreter or
ELF loader? AppArmor does not check permissions for files opened for interpreter
and ELF loader (i.e. accepting any malicious binary file being specified)?


