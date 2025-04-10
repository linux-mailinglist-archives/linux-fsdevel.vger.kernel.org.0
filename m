Return-Path: <linux-fsdevel+bounces-46203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E014A8447B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465DB4E24E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700552857E3;
	Thu, 10 Apr 2025 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8K9YRJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A7528A3F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290660; cv=none; b=mn5i4e8quW0wsKqZsQMbLd3VZnvXYY47x/09PBJUwMG0Qi2q1OaRrmHNiG2itqKrwkvdZN67JYhglQQzrZrxLj9PoH2+jRw2H9+ygGRFg8TEQI04ssJwbJa/mR9hZk3vSsf4+sVuYKHqcOuPLCnFdcAZSlfepW1IIWVgtCjGkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290660; c=relaxed/simple;
	bh=8rU9DPY5jhcNoVSZ4KXashjSIT2CntjHbzeh8vcOQP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbBlPB+XwIWwFkscUk+Ua4d+3V2zwETtEUxgZy1djgt7TGVn3DOQ33WCZmsoi/XzowR6ozgcAdxBXgQQ1OVfFbjvhOSybGjTocza8XpFVJ1FbiCumZoZUKcOeCD43yvHZ0PYaVOsV8DojGdwv1UnTi3sD4P5yxowGSsdtBERF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8K9YRJl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744290657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABA2PhWP8M0Fi1ZJgXN0xWZdkHEUmH4kzeL6fYLfoOU=;
	b=X8K9YRJlRi9gCd/bJLMef81mQpEzp1qkDu2SEZuiOb7cjlBk4s5XGglxd/voHxwaoJcMa/
	Z/VgneBMzNV88NknHp5hwHCeci2dKqUcMQX5nS+8bEMhcUswxk5zzVsiY5k3DEYvgmEx6V
	VaJS/OAdlbLPuBlW+iIxpSityhF7GLg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-gOdnlTUuNkCU2g29Aj_LqA-1; Thu,
 10 Apr 2025 09:10:53 -0400
X-MC-Unique: gOdnlTUuNkCU2g29Aj_LqA-1
X-Mimecast-MFC-AGG-ID: gOdnlTUuNkCU2g29Aj_LqA_1744290652
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE92C19030B5;
	Thu, 10 Apr 2025 13:10:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.54])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8B84E1954B04;
	Thu, 10 Apr 2025 13:10:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 10 Apr 2025 15:10:13 +0200 (CEST)
Date: Thu, 10 Apr 2025 15:10:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org,
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250410131008.GB15280@redhat.com>
References: <20250409-sesshaft-absurd-35d97607142c@brauner>
 <20250409-rohstoff-ungnade-d1afa571f32c@brauner>
 <20250409184040.GF32748@redhat.com>
 <20250410101801.GA15280@redhat.com>
 <20250410-barhocker-weinhandel-8ed2f619899b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-barhocker-weinhandel-8ed2f619899b@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 04/10, Christian Brauner wrote:
>
> On Thu, Apr 10, 2025 at 12:18:01PM +0200, Oleg Nesterov wrote:
> > On 04/09, Oleg Nesterov wrote:
> > >
> > > On 04/09, Christian Brauner wrote:
> > > >
> > > > The seqcounter might be
> > > > useful independent of pidfs.
> > >
> > > Are you sure? ;) to me the new pid->pid_seq needs more justification...
>
> Yeah, pretty much. I'd make use of this in other cases where we need to
> detect concurrent changes to struct pid without having to take any
> locks. Multi-threaded exec in de_exec() comes to mind as well.

Perhaps you are right, but so far I am still not sure it makes sense.
And we can always add it later if we have another (more convincing)
use-case.

> > To remind, detach_pid(pid, PIDTYPE_PID) does wake_up_all(&pid->wait_pidfd) and
> > takes pid->wait_pidfd->lock.
> >
> > So if pid_has_task(PIDTYPE_PID) succeeds, __unhash_process() -> detach_pid(TGID)
> > is not possible until we drop pid->wait_pidfd->lock.
> >
> > If detach_pid(PIDTYPE_PID) was already called and have passed wake_up_all(),
> > pid_has_task(PIDTYPE_PID) can't succeed.
>
> I know. I was trying to avoid having to take the lock and just make this
> lockless. But if you think we should use this lock here instead I'm
> willing to do this. I just find the sequence counter more elegant than
> the spin_lock_irq().

This is subjective, and quite possibly I am wrong. But yes, I'd prefer
to (ab)use pid->wait_pidfd->lock in pidfd_prepare() for now and not
penalize __unhash_process(). Simply because this is simpler.

If you really dislike taking wait_pidfd->lock, we can add mb() into
__unhash_process() or even smp_mb__after_spinlock() into __change_pid(),
but this will need a lengthy comment...



As for your patch... it doesn't apply on top of 3/4, but I guess it
is clear what does it do, and (unfortunately ;) it looks correct, so
I won't insist too much. See a couple of nits below.

> this imho and it would give pidfds a reliable way to detect relevant
> concurrent changes locklessly without penalizing other critical paths
> (e.g., under tasklist_lock) in the kernel.

Can't resist... Note that raw_seqcount_begin() in pidfd_prepare() will
take/drop tasklist_lock if it races with __unhash_process() on PREEMPT_RT.
Yes, this is unlikely case, but still...

Now. Unless I misread your patch, pidfd_prepare() does "err = 0" only
once before the main loop. And this is correct. But this means that
we do not need the do/while loop.

If read_seqcount_retry() returns true, we can safely return -ESRCH. So
we can do

	seq = raw_seqcount_begin(&pid->pid_seq);

	if (!PIDFD_THREAD && !pid_has_task(PIDTYPE_TGID))
		err = -ENOENT;

	if (!pid_has_task(PIDTYPE_PID))
		err = -ESRCH;

	if (read_seqcount_retry(pid->pid_seq, seq))
		err = -ESRCH;

In fact we don't even need raw_seqcount_begin(), we could use
raw_seqcount_try_begin().

And why seqcount_rwlock_t? A plain seqcount_t can equally work.


And, if we use seqcount_rwlock_t,

	lockdep_assert_held_write(&tasklist_lock);
	...
	raw_write_seqcount_begin(pid->pid_seq);

in __unhash_process() looks a bit strange. I'd suggest to use
write_seqcount_begin() which does seqprop_assert() and kill
lockdep_assert_held_write().

Oleg.


