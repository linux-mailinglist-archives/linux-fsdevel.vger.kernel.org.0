Return-Path: <linux-fsdevel+bounces-69779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADDFC84D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0FF3A8AB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B607E31770F;
	Tue, 25 Nov 2025 11:55:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1E314A89;
	Tue, 25 Nov 2025 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071747; cv=none; b=UL/TjKvo8YqtmwxGMhllfECXUyNzUbnoG/5Yrrfy9CKIgzj1cATqwqeJjz6C40nwK5jbMjbXDC8+AqbvMi7BQ0beTCAOZTJECI0GdneVSFKzndCbr/TZ4IrpjUJoZuxXhseGk3C5xx6MsUZF3HFfFcCVs4jIQCaKKCsFLEN/xag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071747; c=relaxed/simple;
	bh=JN5/TSC4HKNk2xP7gRxVojAV3TGAU8ooYnBuZP4ZVlA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwkpT380AqsK+8oHX6ShYMoShoXcEac6AMjn3OucK7BlDremlPkS5LPnEegMIyQHI1a1Qo2BYE7ow/3bv8YjSj8ZXmyQCSeIwAXnfVqdLJeCB8RmZLWEEH943hhOGb+BqBLdMQjiltWzHeI+ARfYuCK+x1ECXmP+YfX91DLeJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dG1Lx59ZJzvWjk;
	Tue, 25 Nov 2025 19:54:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C0A8A140133;
	Tue, 25 Nov 2025 19:55:33 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnsokYmSVpKucMAQ--.9S2;
	Tue, 25 Nov 2025 12:55:32 +0100 (CET)
Message-ID: <6dc556a0a93c18fffec71322bf97441c74b3134e.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] exec: Move cred computation under exec_update_lock
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Bernd Edlinger
	 <bernd.edlinger@hotmail.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Dobriyan
 <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Kees Cook
 <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
 <wad@chromium.org>, Christian Brauner <brauner@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Serge Hallyn
 <serge@hallyn.com>, James Morris <jamorris@linux.microsoft.com>, Randy
 Dunlap <rdunlap@infradead.org>, Suren Baghdasaryan <surenb@google.com>,
 Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>, Adrian
 Reber <areber@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Jens Axboe
 <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>, 
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, tiozhang <tiozhang@didiglobal.com>,
 Luis Chamberlain <mcgrof@kernel.org>, "Paulo Alcantara (SUSE)"
 <pc@manguebit.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Frederic
 Weisbecker <frederic@kernel.org>, YueHaibing <yuehaibing@huawei.com>, Paul
 Moore <paul@paul-moore.com>,  Aleksa Sarai <cyphar@cyphar.com>, Stefan
 Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>, xu xin
 <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>, Jan Kara
 <jack@suse.cz>,  David Hildenbrand <david@redhat.com>, Dave Chinner
 <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>, Elena Reshetova
 <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>, Mateusz
 Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, "Joel
 Fernandes (Google)" <joel@joelfernandes.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Hans Liljestrand <ishkamiel@gmail.com>, Penglei
 Jiang <superman.xpt@gmail.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>,  Adrian Ratiu <adrian.ratiu@collabora.com>,
 Ingo Molnar <mingo@kernel.org>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Cyrill Gorcunov <gorcunov@gmail.com>, Eric Dumazet
 <edumazet@google.com>, zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Date: Tue, 25 Nov 2025 12:55:00 +0100
In-Reply-To: <87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
References: 
	<AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
	 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
	 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	 <GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	 <87tsyozqdu.fsf@email.froward.int.ebiederm.org>
	 <87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
	 <87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAnsokYmSVpKucMAQ--.9S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Cw45WFWrCrWUArWxAF1xuFg_yoW8AryrXo
	Wagw4rCw18Jw18Ga4UArn7AFWUZFWDG3y8Jr4YqrnruFs5Zws0934UX3y3WFyIqFWUKasr
	C348J34j9Fs5tF1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY47kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_
	Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0EksDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGklETIErQAFsF

On Thu, 2025-11-20 at 14:57 -0600, Eric W. Biederman wrote:
> Instead of computing the new cred before we pass the point of no
> return compute the new cred just before we use it.
>=20
> This allows the removal of fs_struct->in_exec and cred_guard_mutex.
>=20
> I am not certain why we wanted to compute the cred for the new
> executable so early.  Perhaps I missed something but I did not see any
> common errors being signaled.   So I don't think we loose anything by
> computing the new cred later.
>=20
> We gain a lot.
>=20
> We stop holding the cred_guard_mutex over places where the code sleeps
> and waits for userspace.  These places include the waiting for the
> tracer in PTRACE_EVENT_EXIT, "put_user(0, tsk->clear_child_tid)" in
> mm_release, and "get_user(futex_offset, ...") in exit_robust_mutex.
>=20
> We can remove fs_struct->in_exec.  The case where it was used simply
> never comes up, when we compute the cred after de_thread completes.
>=20
> We remove the possibility of a hang between a tracer calling
> PTRACE_ATTACH/PTRACE_SIEZE and the kernel waiting for the tracer
> in PTRACE_EVENT_EXIT.
>=20
> ---
> Oleg, Kees, Bernd, Can you see anything I am missing?

+ Mimi, linux-integrity (would be nice if we are in CC when linux-
security-module is in CC).

Apologies for not answering earlier, it seems I don't receive the
emails from the linux-security-module mailing list (thanks Serge for
letting me know!).

I tested your patch but there are a few warnings like this:

[    2.702374] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    2.702854] WARNING: bad unlock balance detected!
[    2.703350] 6.18.0-rc6+ #409 Not tainted
[    2.703755] -------------------------------------
[    2.704241] init/1 is trying to release lock (init_fs.seq) at:
[    2.704829] [<ffffffff81836100>] begin_new_exec+0xfe0/0x1710
[    2.705421] but there are no more locks to release!
[    2.705931]=20
[    2.705931] other info that might help us debug this:
[    2.706610] 1 lock held by init/1:
[    2.706958]  #0: ffff88810083e538 (&sig->exec_update_lock){+.+.}-{4:4}, =
at: begin_new_exec+0x769/0x1710

and then the system hangs.

I see two main effects of this patch. First, the bprm_check_security
hook implementations will not see bprm->cred populated. That was a
problem before we made this patch:

https://patchew.org/linux/20251008113503.2433343-1-roberto.sassu@huaweiclou=
d.com/

to work around the problem of not calculating the final DAC credentials
early enough (well, we actually had to change our CREDS_CHECK hook
behavior).

The second, I could not check. If I remember well, unlike the
capability LSM, SELinux/Apparmor/SMACK calculate the final credentials
based on the first file being executed (thus the script, not the
interpreter). Is this patch keeping the same behavior despite preparing
the credentials when the final binary is found?

Thanks

Roberto

> The code compiles but I haven't test it yet.
>=20
> I thought I was going to move commit_creds before de_thread, but that
> would have taken commit_cred out of exec_update_lock (which introduces
> races).
>=20
> However I can't see any drawbacks of going the other direction.
>=20
>=20
>  fs/exec.c                    | 88 ++++++++++++++----------------------
>  fs/fs_struct.c               |  1 -
>  fs/proc/base.c               |  4 +-
>  include/linux/fs_struct.h    |  1 -
>  include/linux/sched/signal.h |  6 ---
>  init/init_task.c             |  1 -
>  kernel/cred.c                |  2 +-
>  kernel/fork.c                |  8 +---
>  kernel/ptrace.c              |  4 +-
>  kernel/seccomp.c             | 12 ++---
>  10 files changed, 45 insertions(+), 82 deletions(-)
>=20
> diff --git a/fs/exec.c b/fs/exec.c
> index 4298e7e08d5d..5ae96584dab0 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1090,6 +1090,9 @@ void __set_task_comm(struct task_struct *tsk, const=
 char *buf, bool exec)
>  	perf_event_comm(tsk, exec);
>  }
> =20
> +static int prepare_bprm_creds(struct linux_binprm *bprm);
> +static void check_unsafe_exec(struct linux_binprm *bprm);
> +
>  /*
>   * Calling this is the point of no return. None of the failures will be
>   * seen by userspace since either the process is already taking a fatal
> @@ -1101,10 +1104,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	struct task_struct *me =3D current;
>  	int retval;
> =20
> -	/* Once we are committed compute the creds */
> -	retval =3D bprm_creds_from_file(bprm);
> -	if (retval)
> -		return retval;
> =20
>  	/*
>  	 * This tracepoint marks the point before flushing the old exec where
> @@ -1123,8 +1122,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	retval =3D de_thread(me);
>  	if (retval)
>  		goto out;
> -	/* see the comment in check_unsafe_exec() */
> -	current->fs->in_exec =3D 0;
>  	/*
>  	 * Cancel any io_uring activity across execve
>  	 */
> @@ -1251,6 +1248,25 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
>  	flush_signal_handlers(me, 0);
> =20
> +	retval =3D prepare_bprm_creds(bprm);
> +	if (retval)
> +		goto out_unlock;
> +
> +	/*
> +	 * Check for unsafe execution states before exec_binprm(), which
> +	 * will call back into begin_new_exec(), into bprm_creds_from_file(),
> +	 * where setuid-ness is evaluated.
> +	 */
> +	check_unsafe_exec(bprm);
> +
> +	/* Set the unchanging part of bprm->cred */
> +	retval =3D security_bprm_creds_for_exec(bprm);
> +
> +	/* Once we are committed compute the creds */
> +	retval =3D bprm_creds_from_file(bprm);
> +	if (retval)
> +		goto out_unlock;
> +
>  	retval =3D set_cred_ucounts(bprm->cred);
>  	if (retval < 0)
>  		goto out_unlock;
> @@ -1272,9 +1288,9 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (get_dumpable(me->mm) !=3D SUID_DUMP_USER)
>  		perf_event_exit_task(me);
>  	/*
> -	 * cred_guard_mutex must be held at least to this point to prevent
> +	 * exec_update_lock must be held at least to this point to prevent
>  	 * ptrace_attach() from altering our determination of the task's
> -	 * credentials; any time after this it may be unlocked.
> +	 * credentials.
>  	 */
>  	security_bprm_committed_creds(bprm);
> =20
> @@ -1291,8 +1307,6 @@ int begin_new_exec(struct linux_binprm * bprm)
> =20
>  out_unlock:
>  	up_write(&me->signal->exec_update_lock);
> -	if (!bprm->cred)
> -		mutex_unlock(&me->signal->cred_guard_mutex);
> =20
>  out:
>  	return retval;
> @@ -1336,7 +1350,6 @@ void setup_new_exec(struct linux_binprm * bprm)
>  	 */
>  	me->mm->task_size =3D TASK_SIZE;
>  	up_write(&me->signal->exec_update_lock);
> -	mutex_unlock(&me->signal->cred_guard_mutex);
>  }
>  EXPORT_SYMBOL(setup_new_exec);
> =20
> @@ -1351,21 +1364,15 @@ void finalize_exec(struct linux_binprm *bprm)
>  EXPORT_SYMBOL(finalize_exec);
> =20
>  /*
> - * Prepare credentials and lock ->cred_guard_mutex.
> - * setup_new_exec() commits the new creds and drops the lock.
> - * Or, if exec fails before, free_bprm() should release ->cred
> - * and unlock.
> + * Prepare credentials.  begin_new_exec() commits the new creds.
> + * Or, if exec fails before, free_bprm() should release ->cred.
>   */
>  static int prepare_bprm_creds(struct linux_binprm *bprm)
>  {
> -	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
> -		return -ERESTARTNOINTR;
> -
>  	bprm->cred =3D prepare_exec_creds();
>  	if (likely(bprm->cred))
>  		return 0;
> =20
> -	mutex_unlock(&current->signal->cred_guard_mutex);
>  	return -ENOMEM;
>  }
> =20
> @@ -1386,9 +1393,7 @@ static void free_bprm(struct linux_binprm *bprm)
>  	}
>  	free_arg_pages(bprm);
>  	if (bprm->cred) {
> -		/* in case exec fails before de_thread() succeeds */
> -		current->fs->in_exec =3D 0;
> -		mutex_unlock(&current->signal->cred_guard_mutex);
> +		/* in case exec fails before commit_creds succeeds */
>  		abort_creds(bprm->cred);
>  	}
>  	do_close_execat(bprm->file);
> @@ -1486,13 +1491,12 @@ EXPORT_SYMBOL(bprm_change_interp);
> =20
>  /*
>   * determine how safe it is to execute the proposed program
> - * - the caller must hold ->cred_guard_mutex to protect against
> + * - the caller must hold ->exec_update_lock to protect against
>   *   PTRACE_ATTACH or seccomp thread-sync
>   */
>  static void check_unsafe_exec(struct linux_binprm *bprm)
>  {
> -	struct task_struct *p =3D current, *t;
> -	unsigned n_fs;
> +	struct task_struct *p =3D current;
> =20
>  	if (p->ptrace)
>  		bprm->unsafe |=3D LSM_UNSAFE_PTRACE;
> @@ -1509,25 +1513,9 @@ static void check_unsafe_exec(struct linux_binprm =
*bprm)
>  	 * suid exec because the differently privileged task
>  	 * will be able to manipulate the current directory, etc.
>  	 * It would be nice to force an unshare instead...
> -	 *
> -	 * Otherwise we set fs->in_exec =3D 1 to deny clone(CLONE_FS)
> -	 * from another sub-thread until de_thread() succeeds, this
> -	 * state is protected by cred_guard_mutex we hold.
>  	 */
> -	n_fs =3D 1;
> -	read_seqlock_excl(&p->fs->seq);
> -	rcu_read_lock();
> -	for_other_threads(p, t) {
> -		if (t->fs =3D=3D p->fs)
> -			n_fs++;
> -	}
> -	rcu_read_unlock();
> -
> -	/* "users" and "in_exec" locked for copy_fs() */
> -	if (p->fs->users > n_fs)
> +	if (p->fs->users > 1)
>  		bprm->unsafe |=3D LSM_UNSAFE_SHARE;
> -	else
> -		p->fs->in_exec =3D 1;
>  	read_sequnlock_excl(&p->fs->seq);
>  }
> =20
> @@ -1731,25 +1719,15 @@ static int bprm_execve(struct linux_binprm *bprm)
>  {
>  	int retval;
> =20
> -	retval =3D prepare_bprm_creds(bprm);
> -	if (retval)
> -		return retval;
> +	if (bprm->is_check)
> +		return 0;
> =20
> -	/*
> -	 * Check for unsafe execution states before exec_binprm(), which
> -	 * will call back into begin_new_exec(), into bprm_creds_from_file(),
> -	 * where setuid-ness is evaluated.
> -	 */
> -	check_unsafe_exec(bprm);
>  	current->in_execve =3D 1;
>  	sched_mm_cid_before_execve(current);
> =20
>  	sched_exec();
> =20
> -	/* Set the unchanging part of bprm->cred */
> -	retval =3D security_bprm_creds_for_exec(bprm);
> -	if (retval || bprm->is_check)
> -		goto out;
> +
> =20
>  	retval =3D exec_binprm(bprm);
>  	if (retval < 0)
> diff --git a/fs/fs_struct.c b/fs/fs_struct.c
> index 28be762ac1c6..945bc0916f65 100644
> --- a/fs/fs_struct.c
> +++ b/fs/fs_struct.c
> @@ -109,7 +109,6 @@ struct fs_struct *copy_fs_struct(struct fs_struct *ol=
d)
>  	/* We don't need to lock fs - think why ;-) */
>  	if (fs) {
>  		fs->users =3D 1;
> -		fs->in_exec =3D 0;
>  		seqlock_init(&fs->seq);
>  		fs->umask =3D old->umask;
> =20
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6299878e3d97..7041fb4d1689 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2834,14 +2834,14 @@ static ssize_t proc_pid_attr_write(struct file * =
file, const char __user * buf,
>  	}
> =20
>  	/* Guard against adverse ptrace interaction */
> -	rv =3D mutex_lock_interruptible(&current->signal->cred_guard_mutex);
> +	rv =3D down_write_killable(&current->signal->exec_update_lock);
>  	if (rv < 0)
>  		goto out_free;
> =20
>  	rv =3D security_setprocattr(PROC_I(inode)->op.lsmid,
>  				  file->f_path.dentry->d_name.name, page,
>  				  count);
> -	mutex_unlock(&current->signal->cred_guard_mutex);
> +	up_write(&current->signal->exec_update_lock);
>  out_free:
>  	kfree(page);
>  out:
> diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
> index baf200ab5c77..29d0f7d57743 100644
> --- a/include/linux/fs_struct.h
> +++ b/include/linux/fs_struct.h
> @@ -10,7 +10,6 @@ struct fs_struct {
>  	int users;
>  	seqlock_t seq;
>  	int umask;
> -	int in_exec;
>  	struct path root, pwd;
>  } __randomize_layout;
> =20
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 7d6449982822..7e9259c8fb2b 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -241,12 +241,6 @@ struct signal_struct {
>  	struct mm_struct *oom_mm;	/* recorded mm when the thread group got
>  					 * killed by the oom killer */
> =20
> -	struct mutex cred_guard_mutex;	/* guard against foreign influences on
> -					 * credential calculations
> -					 * (notably. ptrace)
> -					 * Deprecated do not use in new code.
> -					 * Use exec_update_lock instead.
> -					 */
>  	struct rw_semaphore exec_update_lock;	/* Held while task_struct is
>  						 * being updated during exec,
>  						 * and may have inconsistent
> diff --git a/init/init_task.c b/init/init_task.c
> index a55e2189206f..4813bffe217e 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -30,7 +30,6 @@ static struct signal_struct init_signals =3D {
>  #ifdef CONFIG_CGROUPS
>  	.cgroup_threadgroup_rwsem	=3D __RWSEM_INITIALIZER(init_signals.cgroup_t=
hreadgroup_rwsem),
>  #endif
> -	.cred_guard_mutex =3D __MUTEX_INITIALIZER(init_signals.cred_guard_mutex=
),
>  	.exec_update_lock =3D __RWSEM_INITIALIZER(init_signals.exec_update_lock=
),
>  #ifdef CONFIG_POSIX_TIMERS
>  	.posix_timers		=3D HLIST_HEAD_INIT,
> diff --git a/kernel/cred.c b/kernel/cred.c
> index dbf6b687dc5c..80e376ce005f 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -252,7 +252,7 @@ EXPORT_SYMBOL(prepare_creds);
> =20
>  /*
>   * Prepare credentials for current to perform an execve()
> - * - The caller must hold ->cred_guard_mutex
> + * - The caller must hold ->exec_update_lock
>   */
>  struct cred *prepare_exec_creds(void)
>  {
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3da0f08615a9..996c649b9a4c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1555,11 +1555,6 @@ static int copy_fs(u64 clone_flags, struct task_st=
ruct *tsk)
>  	if (clone_flags & CLONE_FS) {
>  		/* tsk->fs is already what we want */
>  		read_seqlock_excl(&fs->seq);
> -		/* "users" and "in_exec" locked for check_unsafe_exec() */
> -		if (fs->in_exec) {
> -			read_sequnlock_excl(&fs->seq);
> -			return -EAGAIN;
> -		}
>  		fs->users++;
>  		read_sequnlock_excl(&fs->seq);
>  		return 0;
> @@ -1699,7 +1694,6 @@ static int copy_signal(u64 clone_flags, struct task=
_struct *tsk)
>  	sig->oom_score_adj =3D current->signal->oom_score_adj;
>  	sig->oom_score_adj_min =3D current->signal->oom_score_adj_min;
> =20
> -	mutex_init(&sig->cred_guard_mutex);
>  	init_rwsem(&sig->exec_update_lock);
> =20
>  	return 0;
> @@ -1710,7 +1704,7 @@ static void copy_seccomp(struct task_struct *p)
>  #ifdef CONFIG_SECCOMP
>  	/*
>  	 * Must be called with sighand->lock held, which is common to
> -	 * all threads in the group. Holding cred_guard_mutex is not
> +	 * all threads in the group. Holding exec_update_lock is not
>  	 * needed because this new task is not yet running and cannot
>  	 * be racing exec.
>  	 */
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 75a84efad40f..8140d4bfc279 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -444,8 +444,8 @@ static int ptrace_attach(struct task_struct *task, lo=
ng request,
>  	 * SUID, SGID and LSM creds get determined differently
>  	 * under ptrace.
>  	 */
> -	scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
> -			   &task->signal->cred_guard_mutex) {
> +	scoped_cond_guard (rwsem_read_intr, return -ERESTARTNOINTR,
> +			   &task->signal->exec_update_lock) {
> =20
>  		scoped_guard (task_lock, task) {
>  			retval =3D __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 25f62867a16d..87de8d47d876 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -479,7 +479,7 @@ static int is_ancestor(struct seccomp_filter *parent,
>  /**
>   * seccomp_can_sync_threads: checks if all threads can be synchronized
>   *
> - * Expects sighand and cred_guard_mutex locks to be held.
> + * Expects sighand and exec_update_lock locks to be held.
>   *
>   * Returns 0 on success, -ve on error, or the pid of a thread which was
>   * either not in the correct seccomp mode or did not have an ancestral
> @@ -489,7 +489,7 @@ static inline pid_t seccomp_can_sync_threads(void)
>  {
>  	struct task_struct *thread, *caller;
> =20
> -	BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
> +	BUG_ON(!rwsem_is_locked(&current->signal->exec_update_lock));
>  	assert_spin_locked(&current->sighand->siglock);
> =20
>  	/* Validate all threads being eligible for synchronization. */
> @@ -590,7 +590,7 @@ void seccomp_filter_release(struct task_struct *tsk)
>   *
>   * @flags: SECCOMP_FILTER_FLAG_* flags to set during sync.
>   *
> - * Expects sighand and cred_guard_mutex locks to be held, and for
> + * Expects sighand and exec_update_lock locks to be held, and for
>   * seccomp_can_sync_threads() to have returned success already
>   * without dropping the locks.
>   *
> @@ -599,7 +599,7 @@ static inline void seccomp_sync_threads(unsigned long=
 flags)
>  {
>  	struct task_struct *thread, *caller;
> =20
> -	BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
> +	BUG_ON(!rwsem_is_locked(&current->signal->exec_update_lock));
>  	assert_spin_locked(&current->sighand->siglock);
> =20
>  	/*
> @@ -2011,7 +2011,7 @@ static long seccomp_set_mode_filter(unsigned int fl=
ags,
>  	 * while another thread is in the middle of calling exec.
>  	 */
>  	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
> -	    mutex_lock_killable(&current->signal->cred_guard_mutex))
> +	    down_read_killable(&current->signal->exec_update_lock))
>  		goto out_put_fd;
> =20
>  	spin_lock_irq(&current->sighand->siglock);
> @@ -2034,7 +2034,7 @@ static long seccomp_set_mode_filter(unsigned int fl=
ags,
>  out:
>  	spin_unlock_irq(&current->sighand->siglock);
>  	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
> -		mutex_unlock(&current->signal->cred_guard_mutex);
> +		up_read(&current->signal->exec_update_lock);
>  out_put_fd:
>  	if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
>  		if (ret) {


