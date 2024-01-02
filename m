Return-Path: <linux-fsdevel+bounces-7073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0128B8218CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D37728384B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE3D28F;
	Tue,  2 Jan 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qbjbK+L5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B2CA69;
	Tue,  2 Jan 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tlEfMQFt5gK7xTvm4OYyFW6oyrGcWRnYRgh3+dnfWXQ=; b=qbjbK+L5aYe/lDZscjtenI5cjW
	dZL/n71TVQj2zphfxq3RZ+cNggYEWOSaYIL6eYvVx5t5XbeQtXC5MfvkPEbeyWhD7ffyRT3M3U/Vd
	VVSFZvNRo70tslTpjdD38Sg+/jUCGJ+dlQkKzla59Tw98eiFplHqpLYGh8x1cESshIjA8i2C7Sn5M
	muL2EGVBlVq2u1U2wLBjpcL4+E4cCtxzD6oY/ijyD7c2z9wI6Hy3ySQPY+FZTT4GhfgPtObTsn+Mf
	4GMgFwlfji7YX5rkT/+U0nnZrO6GArNuSqp3UnB6eP/3Dq/eakRRSpeSc0fIN9D8KevfYWMzxiVW4
	BH4OtoIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rKaqw-009pns-In; Tue, 02 Jan 2024 09:14:26 +0000
Date: Tue, 2 Jan 2024 09:14:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Hillf Danton <hdanton@sina.com>, kernel@quicinc.com,
	quic_pkondeti@quicinc.com, keescook@chromium.or,
	viro@zeniv.linux.org.uk, brauner@kernel.org, oleg@redhat.com,
	dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Message-ID: <ZZPT8hMiuT1pCBP7@casper.infradead.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
 <ZXnaNSrtaWbS2ivU@casper.infradead.org>
 <87o7eu7ybq.fsf@email.froward.int.ebiederm.org>
 <ZY30k7OCtxrdR9oP@casper.infradead.org>
 <cd0f6613-9aa9-4698-bebe-0f61286d7552@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd0f6613-9aa9-4698-bebe-0f61286d7552@quicinc.com>

On Tue, Jan 02, 2024 at 10:19:47AM +0800, Aiqun Yu (Maria) wrote:
> On 12/29/2023 6:20 AM, Matthew Wilcox wrote:
> > On Wed, Dec 13, 2023 at 12:27:05PM -0600, Eric W. Biederman wrote:
> > > Matthew Wilcox <willy@infradead.org> writes:
> > > > I think the right way to fix this is to pass a boolean flag to
> > > > queued_write_lock_slowpath() to let it know whether it can re-enable
> > > > interrupts while checking whether _QW_WAITING is set.
> > > 
> > > Yes.  It seems to make sense to distinguish between write_lock_irq and
> > > write_lock_irqsave and fix this for all of write_lock_irq.
> > 
> > I wasn't planning on doing anything here, but Hillf kind of pushed me into
> > it.  I think it needs to be something like this.  Compile tested only.
> > If it ends up getting used,
> Happy new year!

Thank you!  I know your new year is a few weeks away still ;-)

> > -void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
> > +void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock, bool irq)
> >   {
> >   	int cnts;
> > @@ -82,7 +83,11 @@ void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
> Also a new state showed up after the current design:
> 1. locked flag with _QW_WAITING, while irq enabled.
> 2. And this state will be only in interrupt context.
> 3. lock->wait_lock is hold by the write waiter.
> So per my understanding, a different behavior also needed to be done in
> queued_write_lock_slowpath:
>   when (unlikely(in_interrupt())) , get the lock directly.

I don't think so.  Remember that write_lock_irq() can only be called in
process context, and when interrupts are enabled.

> So needed to be done in release path. This is to address Hillf's concern on
> possibility of deadlock.

Hillf's concern is invalid.

> >   	/* When no more readers or writers, set the locked flag */
> >   	do {
> > +		if (irq)
> > +			local_irq_enable();
> I think write_lock_irqsave also needs to be take account. So
> loal_irq_save(flags) should be take into account here.

If we did want to support the same kind of spinning with interrupts
enabled for write_lock_irqsave(), we'd want to pass the flags in
and do local_irq_restore(), but I don't know how we'd support
write_lock_irq() if we did that -- can we rely on passing in 0 for flags
meaning "reenable" on all architectures?  And ~0 meaning "don't
reenable" on all architectures?

That all seems complicated, so I didn't do that.


