Return-Path: <linux-fsdevel+bounces-8183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8B830B53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B7729188F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC17224DA;
	Wed, 17 Jan 2024 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGFKwe42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773B219F6
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509582; cv=none; b=JA1i6LDuH+Dm6GsQrqHttQ446sNmLbOmqlsJq3+CVbz9hlFYOrePDvxVXf9tEi8V1nTKSlYFZVtyuD440HNdbjQn7YH/gf3qbNjQKlcZwVxWC4t0NhisnNYKhaqqBRG4E6cknweWb0TDT9wFjn+RuXamvCS67RGlpCS6pGeio2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509582; c=relaxed/simple;
	bh=M3t4lykNqYhmCjQO4zKq31KhD0/95qJoM+feR8YYTMs=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Scanned-By; b=oELd3LkmcX+ClTTN3+WAEvc/nPWvPAl1b0XoQ0Kk5VT1z0n2jhOQ9zgoG+OaaYoVcAvM6STApQ2dQiRLbzHbCWMzyHeqz3mTF4LX8vj3IverhUujl8H1ekUrvPoh6MAzEy0QDBUJUi0NfmUupBFe4jXqNEJ50hOnhogiIzLbHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGFKwe42; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9MEKaPLuC4dWjyeAAjRSNgqo7o077s9TgRJfiIfemoI=;
	b=VGFKwe42QNwnGnzj+O/ircVuwgvQkkmWBPnYGP1SZKwTLXyv01xcb5EZCMWHI8+q9aStbH
	eBBWkO+enNpv+9Grta4HmSmPYqrI9ho5IEffJv3BCOBjmZF32m1fBHrRX+Mpj+q2DU4dRs
	VH0k1wagxBuqx1i1PocrEIqK/T7bAC4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-a8vvGCybN5WY-ilt55kkNA-1; Wed,
 17 Jan 2024 11:39:36 -0500
X-MC-Unique: a8vvGCybN5WY-ilt55kkNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 921CE1C29EC6;
	Wed, 17 Jan 2024 16:39:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.121])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8BF4E3C25;
	Wed, 17 Jan 2024 16:39:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 17 Jan 2024 17:38:18 +0100 (CET)
Date: Wed, 17 Jan 2024 17:38:09 +0100
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
Message-ID: <20240117163739.GA32526@redhat.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <20240116152210.GA12342@redhat.com>
 <AS8P193MB128538BC3833E654F56DA801E4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB128538BC3833E654F56DA801E4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 01/17, Bernd Edlinger wrote:
>
> >>
> >> The problem happens when a tracer tries to ptrace_attach
> >> to a multi-threaded process, that does an execve in one of
> >> the threads at the same time, without doing that in a forked
> >> sub-process.  That means: There is a race condition, when one
> >> or more of the threads are already ptraced, but the thread
> >> that invoked the execve is not yet traced.  Now in this
> >> case the execve locks the cred_guard_mutex and waits for
> >> de_thread to complete.  But that waits for the traced
> >> sibling threads to exit, and those have to wait for the
> >> tracer to receive the exit signal, but the tracer cannot
> >> call wait right now, because it is waiting for the ptrace
> >> call to complete, and this never does not happen.
> >> The traced process and the tracer are now in a deadlock
> >> situation, and can only be killed by a fatal signal.
> >
> > This looks very confusing to me. And even misleading.
> >
> > So IIRC the problem is "simple".
> >
> > de_thread() sleeps with cred_guard_mutex waiting for other threads to
> > exit and pass release_task/__exit_signal.
> >
> > If one of the sub-threads is traced, debugger should do ptrace_detach()
> > or wait() to release this tracee, the killed tracee won't autoreap.
> >
>
> Yes. but the tracer has to do its job, and that is ptrace_attach the
> remaining treads, it does not know that it would avoid a dead-lock
> when it calls wait(), instead of ptrace_attach.  It does not know
> that the tracee has just called execve in one of the not yet traced
> threads.

Hmm. I don't understand you.

I agree we have a problem which should be fixed. Just the changelog
looks confusing to me, imo it doesn't explain the race/problem clearly.

> > Now. If debugger tries to take the same cred_guard_mutex before
> > detach/wait we have a deadlock. This is not specific to ptrace_attach(),
> > proc_pid_attr_write() takes this lock too.
> >
> > Right? Or are there other issues?
> >
>
> No, proc_pid_attr_write has no problem if it waits for cred_guard_mutex,
> because it is only called from one of the sibling threads,

OK, thanks, I was wrong. I forgot about "A task may only write its own attributes".
So yes, ptrace_attach() is the only source of problematic mutex_lock() today.
There were more in the past.

> >> +		if (unlikely(t->ptrace)
> >> +		    && (t != tsk->group_leader || !t->exit_state))
> >> +			unsafe_execve_in_progress = true;
> >
> > The !t->exit_state is not right... This sub-thread can already be a zombie
> > with ->exit_state != 0 but see above, it won't be reaped until the debugger
> > does wait().
> >
>
> I dont think so.
> de_thread() handles the group_leader different than normal threads.

I don't follow...

I didn't say that t is a group leader. I said it can be a zombie sub-thread
with ->exit_state != 0.

> That means normal threads have to wait for being released from the zombie
> state by the tracer:
> sig->notify_count > 0, and de_thread is woken up by __exit_signal

That is what I said before. Debugger should release a zombie sub-thread,
it won't do __exit_signal() on its own.

> >> +	if (unlikely(unsafe_execve_in_progress)) {
> >> +		spin_unlock_irq(lock);
> >> +		sig->exec_bprm = bprm;
> >> +		mutex_unlock(&sig->cred_guard_mutex);
> >> +		spin_lock_irq(lock);
> >
> > I don't understand why do we need to unlock and lock siglock here...
>
> That is just a precaution because I did want to release the
> mutexes exactly in the reverse order as they were acquired.

To me this adds the unnecessary complication.

> > But my main question is why do we need the unsafe_execve_in_progress boolean.
> > If this patch is correct and de_thread() can drop and re-acquire cread_guard_mutex
> > when one of the threads is traced, then why can't we do this unconditionally ?
> >
>
> I just wanted to keep the impact of the change as small as possible,

But the unsafe_execve_in_progress logic increases the impact and complicates
the patch.

I think the fix should be as simple as possible. (to be honest, right now
I don't think this is a right approach).

> including
> possible performance degradation due to double checking of credentials.

Not sure I understand, but you can add the performance improvements later.
Not to mention that this should be justified, and the for_other_threads()
loop added by this patch into de_thread() is not nice performance-wise.

Oleg.


