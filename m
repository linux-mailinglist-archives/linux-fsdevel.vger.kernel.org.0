Return-Path: <linux-fsdevel+bounces-7246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE482343E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B311F25041
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 18:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E4C1C6A6;
	Wed,  3 Jan 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mNYekl/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF831CA81;
	Wed,  3 Jan 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FmcnlJXDQ98odN/WIJ37kgFC20dlWMFiiPEysBR0RLo=; b=mNYekl/cRuUCgREXI6BMiAqoL/
	WKPwXmHicaLj/SoyAyhEl4lwc1JY9ho99XeqYCADJfovFEgcmKtKxbzHtZ23d0x+GrjTXAp/nAXYg
	6m55AvIuQOxvVhpkh70jRdbDVoJuollTmjQmR5eqGNyq6/mm5fwDk6fn4LwBqgrBstcXYATXDKTwf
	P6+NOcN82q5Xp9FeAKjKuLv52WprkRqG/XUtFj8Pm35WDZ3lKo1SrK/w7C5LJRZCNiokxNKao0itW
	ILPXteBeUi1q+KqxjWo30XinMlvhI0WgyRJGkhNj/qbivwdDJuv/kTYK34e+83w4UBYTiiG03sIGY
	1lnCH5JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rL5od-00DHx5-Kt; Wed, 03 Jan 2024 18:18:07 +0000
Date: Wed, 3 Jan 2024 18:18:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Hillf Danton <hdanton@sina.com>, kernel@quicinc.com,
	quic_pkondeti@quicinc.com, keescook@chromium.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, oleg@redhat.com,
	dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Message-ID: <ZZWk368hZpOc25X0@casper.infradead.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
 <ZXnaNSrtaWbS2ivU@casper.infradead.org>
 <87o7eu7ybq.fsf@email.froward.int.ebiederm.org>
 <ZY30k7OCtxrdR9oP@casper.infradead.org>
 <cd0f6613-9aa9-4698-bebe-0f61286d7552@quicinc.com>
 <ZZPT8hMiuT1pCBP7@casper.infradead.org>
 <99c44790-5f1b-4535-9858-c5e9c752159c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c44790-5f1b-4535-9858-c5e9c752159c@quicinc.com>

On Wed, Jan 03, 2024 at 10:58:33AM +0800, Aiqun Yu (Maria) wrote:
> On 1/2/2024 5:14 PM, Matthew Wilcox wrote:
> > > > -void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
> > > > +void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock, bool irq)
> > > >    {
> > > >    	int cnts;
> > > > @@ -82,7 +83,11 @@ void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
> > > Also a new state showed up after the current design:
> > > 1. locked flag with _QW_WAITING, while irq enabled.
> > > 2. And this state will be only in interrupt context.
> > > 3. lock->wait_lock is hold by the write waiter.
> > > So per my understanding, a different behavior also needed to be done in
> > > queued_write_lock_slowpath:
> > >    when (unlikely(in_interrupt())) , get the lock directly.
> > 
> > I don't think so.  Remember that write_lock_irq() can only be called in
> > process context, and when interrupts are enabled.
> In current kernel drivers, I can see same lock called with write_lock_irq
> and write_lock_irqsave in different drivers.
> 
> And this is the scenario I am talking about:
> 1. cpu0 have task run and called write_lock_irq.(Not in interrupt context)
> 2. cpu0 hold the lock->wait_lock and re-enabled the interrupt.

Oh, I missed that it was holding the wait_lock.  Yes, we also need to
release the wait_lock before spinning with interrupts disabled.

> I was thinking to support both write_lock_irq and write_lock_irqsave with
> interrupt enabled together in queued_write_lock_slowpath.
> 
> That's why I am suggesting in write_lock_irqsave when (in_interrupt()),
> instead spin for the lock->wait_lock, spin to get the lock->cnts directly.

Mmm, but the interrupt could come in on a different CPU and that would
lead to it stealing the wait_lock from the CPU which is merely waiting
for the readers to go away.


