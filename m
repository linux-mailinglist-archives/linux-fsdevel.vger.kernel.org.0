Return-Path: <linux-fsdevel+bounces-79436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFeACbuNqGmbvgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 20:53:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB5720739A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 20:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAB243032DD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36ED390223;
	Wed,  4 Mar 2026 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pX3IkKnI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32359288514;
	Wed,  4 Mar 2026 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653904; cv=none; b=PqDTXQT3Rp5gSV1tE5Sbd2eitTIIhINlDYUEVofziy51WjoZ36ikgRLgGRICWyQZPdSdFUWw15a0nXIFQMC9qKIHPrfmepb0baU0SSCyA6QiAH6fwVw2iY+l4v/GdaSzBfyDmjo8ORh6HUryYo45r2Ic2HUC4NDL9PrO0uNMtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653904; c=relaxed/simple;
	bh=rFmGkgUVzMPgco4e0S5JV2te/mCdrmp4u2/QNzOWFLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc1V5ySnqmXa74FNfEVFj2NZVyDSipvyJvYkC756wMhwFSlfhQ7zrVCqC1I5aLzMfuu9LlXOrHMx0Q1/CXs9WeUAQ1KUhOzmrDpbN1zQrN1DdaT2ARywPGsqxTmA0J5NhduUjKsVDGzuSkW+7dMxfv+JmLaKMxZ5tAqh4PTDlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pX3IkKnI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=08NDQAJVBDz3lIIuOFusP0LgtmohkQzXTukv2/ZPiuU=; b=pX3IkKnIC6cLxQzOMp1keovyop
	TS2FsJXeNEXcXPyHii0WzqT16tB7+HKWNEYn4gfnSiwdF56V6oURJkrFM4H1S5cw0aP1xs7Gzn/Hh
	a4cIHjyoh+MT6RaBjHJsLGoh27Nh0+VUzrrzx5A0gwtaawFXofRqt5t/zRwpYmNCWAX9grnCmg2Rd
	yqKXD6BNK7nHMWAq6F8xna0er6PulXNsXMl3odNU49mICLB55Z06AuLFO+c7wY8gdE+uiMGCGWRSz
	zf1GVo8kheJkJPGtaKJ8/Fi7j4+20XbJtolnazCwkngNRLLRaRSJxsTCzEBbxC+tJDID+V05ajLBi
	DbLr8P+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxsFu-0000000Doa8-1hV2;
	Wed, 04 Mar 2026 19:51:38 +0000
Date: Wed, 4 Mar 2026 19:51:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/1] rwsem: Shrink rwsem by one pointer
Message-ID: <aaiNSqx5by3J5Cij@casper.infradead.org>
References: <20260217190835.1151964-1-willy@infradead.org>
 <20260217190835.1151964-2-willy@infradead.org>
 <CAHk-=wjkyw-sap1dNkW7v8at8MvF3j5wshC1Gw3XEpHBbBw6BQ@mail.gmail.com>
 <aZYoXsUtbzs-nRZH@casper.infradead.org>
 <CAHk-=wiXCcnp5VuAZO7D7Gs75p+O4k-__ep+-2zapQ4Bqkd=rQ@mail.gmail.com>
 <CAHk-=wggNowW32UcNWHQ4Ak5J-0mZT_EO+PAEw2DLe7tr8-Dtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggNowW32UcNWHQ4Ak5J-0mZT_EO+PAEw2DLe7tr8-Dtg@mail.gmail.com>
X-Rspamd-Queue-Id: 9CB5720739A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-79436-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,linux-foundation.org:email]
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 02:52:29PM -0800, Linus Torvalds wrote:
> On Wed, 18 Feb 2026 at 14:45, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Anyway, this is all from just looking at the patch, so maybe I missed
> > something, but it does look very wrong.
> 
> Bah. And immediately after sending, I went "maybe I should look at the
> code" more closely.
> 
> I think my suggestion to just remove the check was right, but the
> return value of rwsem_del_waiter() needs to be fixed to be the "I used
> to be the first waiter, but there are other waiters and I updated the
> first waiter pointer".

I tried to make this work, but it's a bit ugly.  rwsem_del_waiter()
needs to know whether there are remaining waiters, and
rwsem_del_wake_waiter() needs to know whether we deleted the first
waiter _and_ there are remaining ones.  So we end up returning a
tristate from __rwsem_del_waiter() and I find it less clear.

 static inline
-bool __rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+int __rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 {
+       int ret = 1;
+
        if (list_empty(&waiter->list)) {
                sem->first_waiter = NULL;
-               return true;
+               return 0;
        }

-       if (sem->first_waiter == waiter)
+       if (sem->first_waiter == waiter) {
                sem->first_waiter = list_first_entry(&waiter->list,
                                struct rwsem_waiter, list);
+               ret = 2;
+       }
        list_del(&waiter->list);

-       return false;
+       return ret;
 }
[...]
-static inline bool
-rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+static inline
+bool rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 {
+       int del_case;
+
        lockdep_assert_held(&sem->wait_lock);
-       if (__rwsem_del_waiter(sem, waiter))
-               return true;
-       atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS, &sem->count);
-       return false;
+       del_case = __rwsem_del_waiter(sem, waiter);
+       if (del_case > 0)
+               atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS,
+                               &sem->count);
+       return del_case == 2;
 }
[...]
 {
-       bool first = sem->first_waiter == waiter;
-
        wake_q_init(wake_q);

        /*
-        * If the wait_list isn't empty and the waiter to be deleted is
-        * the first waiter, we wake up the remaining waiters as they may
-        * be eligible to acquire or spin on the lock.
+        * If the deleted waiter was the first one and there are other
+        * waiters, we wake them up as they may be eligible to acquire
+        * or spin on the lock.
         */
-       if (rwsem_del_waiter(sem, waiter) && first)
+       if (rwsem_del_waiter(sem, waiter))
                rwsem_mark_wake(sem, RWSEM_WAKE_ANY, wake_q);


Even if we use a nice enum instead of 0/1/2 for the return value, I
don't think this is an improvement.  I played around with a couple of
other ways to refactor this and didn't come up with anything pretty.

