Return-Path: <linux-fsdevel+bounces-70348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DDCC97FC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C803F3A3B51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EDE31B829;
	Mon,  1 Dec 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKRvRYGJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AC244663
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602032; cv=none; b=nyWvMCRkdh0Sl7IhGgor945AeBKj9TjWhBU05qjkgQUh9z1M4YJ2k2yTgAIkXINOuYq1zAnsxt4FeDUKHqQBw+ZxXfXMs2uQaW/bvoDigUSVMV0/uEvdBMGnJkexUpKefTWQu10IpGY0e9IYHGy9MuVIwrnxs8LDPoXwsuzqwvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602032; c=relaxed/simple;
	bh=VJPmfJ+OuSFtUO2JO+y5K63j1ImkklCStE4dlXCI8Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/Ajxsvv5JqdMug+RKlVIdjxNjBjd3lSnK9oEeSGquRmwT5He3r4bfmmMTVjSGVMRdrUxeq1Gpeq7OrCFQjx2ag0mxXYkouQPEuHTZZqGqnRSMFjBe1BVe0OjsbY/EK0vNKaan5JAahee8kr4TcjVFgE2VrpAMU5nq00pNMKlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKRvRYGJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764602029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/tlyVzi6SvS7uRQ6J4iLF5XFx5rEXURTZnzpIQU4oM=;
	b=FKRvRYGJaPcklnMoUfnCJllRqfeSFIJZOFtKIqxl7bmaO12Jdt0XKPt0v6TiXJYziAOLl0
	/ymX76dVTcpslPOBAABRIIqv7d2lBevH99Ofei/53c8uzTVapgUjdKcsvJmg/wMWPcwk/O
	A80H2aF5dLWwISlJxQI59WRsCAxdik4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-MtAWk9dRM6CenYT9ryiugA-1; Mon,
 01 Dec 2025 10:13:46 -0500
X-MC-Unique: MtAWk9dRM6CenYT9ryiugA-1
X-Mimecast-MFC-AGG-ID: MtAWk9dRM6CenYT9ryiugA_1764602020
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A590F1956050;
	Mon,  1 Dec 2025 15:13:39 +0000 (UTC)
Received: from fedora (unknown [10.45.224.36])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CE22B195608E;
	Mon,  1 Dec 2025 15:13:20 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  1 Dec 2025 16:13:39 +0100 (CET)
Date: Mon, 1 Dec 2025 16:13:19 +0100
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
Message-ID: <aS2wj3j5qfoWDt2p@redhat.com>
References: <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <20251105143210.GA25535@redhat.com>
 <20251111-ankreiden-augen-eadcf9bbdfaa@brauner>
 <GV2PPF74270EBEE4FE6E639B899D01D8870E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRs4zYDhddBQFiXZ@redhat.com>
 <GV2PPF74270EBEE6F59267B0E9F28F536D0E4C9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aSNTNZxiQ0txISJx@redhat.com>
 <GV2PPF74270EBEEDD43083BE45C6E26F674E4DDA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PPF74270EBEEDD43083BE45C6E26F674E4DDA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/29, Bernd Edlinger wrote:
>
> On 11/23/25 19:32, Oleg Nesterov wrote:
> > I don't follow. Do you mean PREEMPT_RT ?
> >
> > If yes. In this case spin_lock_irq() is rt_spin_lock() which doesn't disable irqs,
> > it does rt_lock_lock() (takes rt_mutex) + migrate_disable().
> >
> > I do think that spin/mutex/whatever_unlock() is always safe. In any order, and
> > regardless of RT.
> >
>
> It is hard to follow how linux implements that spin_lock_irq exactly,

Yes ;)

> but
> to me it looks like it is done this way:
>
> include/linux/spinlock_api_smp.h:static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
> include/linux/spinlock_api_smp.h-{
> include/linux/spinlock_api_smp.h-       local_irq_disable();
> include/linux/spinlock_api_smp.h-       preempt_disable();
> include/linux/spinlock_api_smp.h-       spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> include/linux/spinlock_api_smp.h-       LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
> include/linux/spinlock_api_smp.h-}

Again, I will assume you mean RT.

In this case spinlock_t and raw_spinlock_t are not the same thing.

include/linux/spinlock_types.h:

	typedef struct spinlock {
		struct rt_mutex_base	lock;
	#ifdef CONFIG_DEBUG_LOCK_ALLOC
		struct lockdep_map	dep_map;
	#endif
	} spinlock_t;

include/linux/spinlock_rt.h:

	static __always_inline void spin_lock_irq(spinlock_t *lock)
	{
		rt_spin_lock(lock);
	}

rt_spin_lock() doesn't disable irqs, it takes "rt_mutex_base lock" and
disables migration.


> so an explicit task switch while locka_irq_disable looks
> very dangerous to me.

raw_spin_lock_irq() disables irqs/preemption regardless of RT, task switch
is not possible.

> Do you know other places where such
> a code pattern is used?

For example, double_lock_irq(). See task_numa_group(),

	double_lock_irq(&my_grp->lock, &grp->lock);

	....

	spin_unlock(&my_grp->lock);
	spin_unlock_irq(&grp->lock);

this can unlock the locks in reverse order.

I am sure there are more examples.

> I do just ask, because a close look at those might reveal
> some serious bugs, WDYT?

See above, I don't understand your concerns...

Oleg.


