Return-Path: <linux-fsdevel+bounces-8064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B06682F166
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA488B21F08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B5D1BF5C;
	Tue, 16 Jan 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRNiqkiA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139291BF43
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705418619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=95o70husdyrbHX9ZG97EzcVPleiqbXjcOXKaS79W3CE=;
	b=aRNiqkiA+4W3dmq2Z07xl+ilfUTn4pwcWRs9uKe/xVpID6fWOZ/NfhejtcW7tdie3fSQWp
	msPn+PSWmDQexW9qZs15LeyYSMo0vxMpmzlwMTt743vs++GybWUuEgxKmbxIyrsY+YKJNc
	Cr/RSTZxLl++RsxmFubCoRQX5m57Ze0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-k8Dnsa1DNG-rwjU6HiPbdA-1; Tue,
 16 Jan 2024 10:23:37 -0500
X-MC-Unique: k8Dnsa1DNG-rwjU6HiPbdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B08983C29A72;
	Tue, 16 Jan 2024 15:23:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.96])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0014F2026D6F;
	Tue, 16 Jan 2024 15:23:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 16 Jan 2024 16:22:20 +0100 (CET)
Date: Tue, 16 Jan 2024 16:22:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Adrian Reber <areber@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	tiozhang <tiozhang@didiglobal.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>,
	xu xin <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>
Subject: Re: [PATCH v14] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <20240116152210.GA12342@redhat.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

I'll try to recall this problem and actually read the patch tommorrow...

Hmm. but it doesn't apply to Linus's tree, you need to rebase it.
In particular, please note the recent commit 5431fdd2c181dd2eac2
("ptrace: Convert ptrace_attach() to use lock guards")

On 01/15, Bernd Edlinger wrote:
>
> The problem happens when a tracer tries to ptrace_attach
> to a multi-threaded process, that does an execve in one of
> the threads at the same time, without doing that in a forked
> sub-process.  That means: There is a race condition, when one
> or more of the threads are already ptraced, but the thread
> that invoked the execve is not yet traced.  Now in this
> case the execve locks the cred_guard_mutex and waits for
> de_thread to complete.  But that waits for the traced
> sibling threads to exit, and those have to wait for the
> tracer to receive the exit signal, but the tracer cannot
> call wait right now, because it is waiting for the ptrace
> call to complete, and this never does not happen.
> The traced process and the tracer are now in a deadlock
> situation, and can only be killed by a fatal signal.

This looks very confusing to me. And even misleading.

So IIRC the problem is "simple".

de_thread() sleeps with cred_guard_mutex waiting for other threads to
exit and pass release_task/__exit_signal.

If one of the sub-threads is traced, debugger should do ptrace_detach()
or wait() to release this tracee, the killed tracee won't autoreap.

Now. If debugger tries to take the same cred_guard_mutex before
detach/wait we have a deadlock. This is not specific to ptrace_attach(),
proc_pid_attr_write() takes this lock too.

Right? Or are there other issues?

> -static int de_thread(struct task_struct *tsk)
> +static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
>  {
>  	struct signal_struct *sig = tsk->signal;
>  	struct sighand_struct *oldsighand = tsk->sighand;
>  	spinlock_t *lock = &oldsighand->siglock;
> +	struct task_struct *t = tsk;
> +	bool unsafe_execve_in_progress = false;
>
>  	if (thread_group_empty(tsk))
>  		goto no_thread_group;
> @@ -1066,6 +1068,19 @@ static int de_thread(struct task_struct *tsk)
>  	if (!thread_group_leader(tsk))
>  		sig->notify_count--;
>
> +	while_each_thread(tsk, t) {

for_other_threads()

> +		if (unlikely(t->ptrace)
> +		    && (t != tsk->group_leader || !t->exit_state))
> +			unsafe_execve_in_progress = true;

The !t->exit_state is not right... This sub-thread can already be a zombie
with ->exit_state != 0 but see above, it won't be reaped until the debugger
does wait().

> +	if (unlikely(unsafe_execve_in_progress)) {
> +		spin_unlock_irq(lock);
> +		sig->exec_bprm = bprm;
> +		mutex_unlock(&sig->cred_guard_mutex);
> +		spin_lock_irq(lock);

I don't understand why do we need to unlock and lock siglock here...

But my main question is why do we need the unsafe_execve_in_progress boolean.
If this patch is correct and de_thread() can drop and re-acquire cread_guard_mutex
when one of the threads is traced, then why can't we do this unconditionally ?

Oleg.


