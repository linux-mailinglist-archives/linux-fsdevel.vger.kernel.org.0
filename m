Return-Path: <linux-fsdevel+bounces-7997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513E582E0C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0949B21699
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F053218C21;
	Mon, 15 Jan 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GknGwOR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDA18B06;
	Mon, 15 Jan 2024 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VZxWDVpCvSyMMfu91KFYLQxRYf92goXw309/GJka1jA=; b=GknGwOR3WJOANvxNIoJBsht0dF
	XYsbU6l237FY/y32zn2rCALaUsCZlCV/doukPROyDgBih0N5A4poaUezz78fJAKRRw4spk15ec5Vb
	wt2fW49Tf5hUy1Hhnn443PL5X7S9d7/gXo4XQwx3EUazTRQxz+Shm5v9T9MI7Iht32IIsAs0U1+5m
	qZsX/gGVMtWr+31/fvBSc0u6UiYa6uL+Zu+yPn0SAL9/S+oSphBGk8TFTU9cdTmhlCtPPQICjWSBx
	bQaKlCH6vSEgmCAmZ/tYp4bqLoAYu/ZJOK5RB/ww1iUiq2qK0Pp9RvifgWHu88AeS/d5XVWIE4CNl
	YlL/2RBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPSmJ-00Ad0l-L5; Mon, 15 Jan 2024 19:37:47 +0000
Date: Mon, 15 Jan 2024 19:37:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>,
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
	Hans Liljestrand <ishkamiel@gmail.com>
Subject: Re: [PATCH v14] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <ZaWJi/N2Dtye3aVs@casper.infradead.org>
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

On Mon, Jan 15, 2024 at 08:22:19PM +0100, Bernd Edlinger wrote:
> This introduces signal->exec_bprm, which is used to
> fix the case when at least one of the sibling threads
> is traced, and therefore the trace process may dead-lock
> in ptrace_attach, but de_thread will need to wait for the
> tracer to continue execution.

Not entirely sure why I've been added to the cc; this doesn't seem
like it's even remotely within my realm of expertise.

> +++ b/include/linux/cred.h
> @@ -153,6 +153,7 @@ extern const struct cred *get_task_cred(struct task_struct *);
>  extern struct cred *cred_alloc_blank(void);
>  extern struct cred *prepare_creds(void);
>  extern struct cred *prepare_exec_creds(void);
> +extern bool is_dumpability_changed(const struct cred *, const struct cred *);

Using 'extern' for function declarations is deprecated.  More
importantly, you have two arguments of the same type, and how do I know
which one is which if you don't name them?

> +++ b/kernel/cred.c
> @@ -375,6 +375,28 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
>  	return false;
>  }
>  
> +/**
> + * is_dumpability_changed - Will changing creds from old to new
> + * affect the dumpability in commit_creds?
> + *
> + * Return: false - dumpability will not be changed in commit_creds.
> + *         true  - dumpability will be changed to non-dumpable.
> + *
> + * @old: The old credentials
> + * @new: The new credentials
> + */

Does kernel-doc really parse this correctly?  Normal style would be:

/**
 * is_dumpability_changed - Will changing creds affect dumpability?
 * @old: The old credentials.
 * @new: The new credentials.
 *
 * If the @new credentials have no elevated privileges compared to the
 * @old credentials, the task may remain dumpable.  Otherwise we have
 * to mark the task as undumpable to avoid information leaks from higher
 * to lower privilege domains.
 *
 * Return: True if the task will become undumpable.
 */

> @@ -508,6 +531,14 @@ static int ptrace_traceme(void)
>  {
>  	int ret = -EPERM;
>  
> +	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
> +		return -ERESTARTNOINTR;

Do you really want this to be interruptible by a timer signal or a
window resize event?


