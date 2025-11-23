Return-Path: <linux-fsdevel+bounces-69573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F674C7E580
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 19:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E3C3A465E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 18:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338202D9EF3;
	Sun, 23 Nov 2025 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXvBT4u/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDD36D500
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763922775; cv=none; b=Ow1hf/NuSqb83A/kfxEQZDMTolDp1N2ToMCuafo/FnxjiwKf7I7du5dZnglG8soxQGESTAHF3UEvlUXRsv/NvCZSrnQyBybn4MSqMSSNH45V39S3I0oy6pW2sC6EfjFx+2tIMKCfxBb5UPgFvKgdgHmY0manvHHwaujJRaCdlr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763922775; c=relaxed/simple;
	bh=q0o3WkXxgcPcxa+rbl7GKvJDyOx0UbOChtTaJCarZFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onU8g2Zx3h1cm/jJa28mmL3P/5YUCPTDkc/QCkQR8VIjoS0URvkZr8C0BMCKoGc4QRaoTsHfhdYuTbmgdvJg3Kg3nnkpuapXoxKbo4B03FsMduINQksUUDhOtFI7uw68vj15xJJ2mdj42IUu5Odrkaf+yfA4zacMpvMm8OJO11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXvBT4u/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763922772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=36l7iu5Eghp8LjDFDIIU/eYWC2BgI9ey1UwqfIFE8Gg=;
	b=YXvBT4u/76Ppxrp6JAe0dsxLlVdSIXkmtB+GwQTmZmYKVt9Xa/eDeN0aU/RiktcnO+ADIU
	cz8jWEICN3AoTl7dkd9owcSSpUX9Ohr/XiKAQ3d28ySiea0cwHwBSNjumylWmUJdS7Fpj0
	eYX/J9ui+jK/S9f7CNNzLExWMJ1TaNc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-ZAFeV0m9P-uQ-1se1ue-Gg-1; Sun,
 23 Nov 2025 13:32:50 -0500
X-MC-Unique: ZAFeV0m9P-uQ-1se1ue-Gg-1
X-Mimecast-MFC-AGG-ID: ZAFeV0m9P-uQ-1se1ue-Gg_1763922765
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA33419560B5;
	Sun, 23 Nov 2025 18:32:42 +0000 (UTC)
Received: from fedora (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CB9B4180057F;
	Sun, 23 Nov 2025 18:32:22 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Nov 2025 19:32:42 +0100 (CET)
Date: Sun, 23 Nov 2025 19:32:21 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
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
	linux-security-module@vger.kernel.org,
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
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <aSNTNZxiQ0txISJx@redhat.com>
References: <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <20251105143210.GA25535@redhat.com>
 <20251111-ankreiden-augen-eadcf9bbdfaa@brauner>
 <GV2PPF74270EBEE4FE6E639B899D01D8870E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRs4zYDhddBQFiXZ@redhat.com>
 <GV2PPF74270EBEE6F59267B0E9F28F536D0E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PPF74270EBEE6F59267B0E9F28F536D0E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Bernd,

sorry for delay, I am on PTO, didn't read emails this week...

On 11/17, Bernd Edlinger wrote:
>
> On 11/17/25 16:01, Oleg Nesterov wrote:
> > On 11/17, Bernd Edlinger wrote:
> >>
> >> On 11/11/25 10:21, Christian Brauner wrote:
> >>> On Wed, Nov 05, 2025 at 03:32:10PM +0100, Oleg Nesterov wrote:
> >>
> >>>> But this is minor. Why do we need "bool unsafe_execve_in_progress" ?
> >>>> If this patch is correct, de_thread() can drop/reacquire cred_guard_mutex
> >>>> unconditionally.
> >>>>
> >>
> >> I would not like to drop the mutex when no absolutely necessary for performance reasons.
> >
> > OK, I won't insist... But I don't really understand how this can help to
> > improve the performance. If nothing else, this adds another for_other_threads()
> > loop.
> >
>
> If no dead-lock is possible it is better to complete the de_thread without
> releasing the mutex.  For the debugger it is also the better experience,
> no matter when the ptrace_attack happens it will succeed rather quickly either
> before the execve or after the execve.

I still disagree, I still don't understand the "performance reasons", but since I can't
convince you I won't really argue.

> >>>>> +	if (unlikely(unsafe_execve_in_progress)) {
> >>>>> +		spin_unlock_irq(lock);
> >>>>> +		sig->exec_bprm = bprm;
> >>>>> +		mutex_unlock(&sig->cred_guard_mutex);
> >>>>> +		spin_lock_irq(lock);
> >>>>
> >>>> I don't think spin_unlock_irq() + spin_lock_irq() makes any sense...
> >>>>
> >>
> >> Since the spin lock was acquired while holding the mutex, both should be
> >> unlocked in reverse sequence and the spin lock re-acquired after releasing
> >> the mutex.
> >
> > Why?
> >
>
> It is generally more safe when each thread acquires its mutexes in order and
> releases them in reverse order.
> Consider this:
> Thread A:
> holds spin_lock_irq(siglock);
> does mutes_unlock(cred_guard_mutex); with irq disabled.
> task switch happens to Thread B which has irq enabled.
> and is waiting for cred_guard_mutex.
> Thrad B:
> does mutex_lock(cred_guard_mutex);
> but is interrupted this point and the interrupt handler I executes
> now iterrupt handler I wants to take siglock and is blocked,
> because the system one single CPU core.

I don't follow. Do you mean PREEMPT_RT ?

If yes. In this case spin_lock_irq() is rt_spin_lock() which doesn't disable irqs,
it does rt_lock_lock() (takes rt_mutex) + migrate_disable().

I do think that spin/mutex/whatever_unlock() is always safe. In any order, and
regardless of RT.

> > And just in case... Lets look at this code
> >
> > 	+                               rcu_assign_pointer(task->real_cred, bprm->cred);
> > 	+                               task->mm = bprm->mm;
> > 	+                               retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> > 	+                               rcu_assign_pointer(task->real_cred, old_cred);
> > 	+                               task->mm = old_mm;
> >
> > again.
> >
> > This is mostly theoretical, but what if begin_new_exec() fails after de_thread()
> > and before exec_mmap() and/or commit_creds(bprm->cred) ? In this case the execing
> > thread will report SIGSEGV to debugger which can (say) read old_mm.
> >
> > No?
> >
>
> Yes, and that is the reason why the debugger has to prove the possession of access rights
> to the process before the execve which are necessary in case exeve fails, yes the debugger
> may inspect the result, and as well the debugger's access rights must be also sufficient
> to ptrace the process after execve succeeds, moreover the debugged process shall stop
> right at the first instruction where the new process starts.

Not sure I understand... OK, I see that you sent V18, and in this version ptrace_attach()
calls __ptrace_may_access() twice, so IIUC ptrace_attach() can only succeed if the debugger
has rights to trace the execing thread both before and after exec...

Oleg.


