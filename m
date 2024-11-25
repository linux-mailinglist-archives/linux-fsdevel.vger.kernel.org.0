Return-Path: <linux-fsdevel+bounces-35744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C39D79AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 02:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6DE161159
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 01:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05C7C8C7;
	Mon, 25 Nov 2024 01:06:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BCD10F9;
	Mon, 25 Nov 2024 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496763; cv=none; b=ukOSmSJYdLvCGfE+DD9AMF6qTqR7lUTzNjtR6IecnwgNIfokpQNv4iJhkMWMsS9hUzsw0O1mJ35kUwTwRKA8livafxsYQyFQ3jnyjwTizMYkNy8nYeYJHlUTpl27uRAY84EnBUAJ9gNSsqmbBihk6YYkadyE8a9RKHaAX2Rphe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496763; c=relaxed/simple;
	bh=a2FpWNrjnAnywCChizhNMKhReBpsf1ERMjw8kG0RmsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R94G2xhM6K2Dr0bo+pPOYXwAVBHAjKoaabMC8gpHqyfq+wRxoveOncKVQ3o7sW11Du+cXfV8h/quYJhOpg4JimEzsWE+dHEp6pRDTKOnhGx0bGlLxSzXwiIw7YsNKA7WERQaWOaN5ZzmFLba1HEiDgLTzSkZRW2yeOvtH0C3QPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-64-6743cd6c65e0
Date: Mon, 25 Nov 2024 10:05:43 +0900
From: Byungchul Park <byungchul@sk.com>
To: Yunseong Kim <yskelg@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, hdanton@sina.com, her0gyugyu@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH v14 2/28] dept: Implement Dept(Dependency Tracker)
Message-ID: <20241125010543.GA9137@system.software.com>
References: <20240508094726.35754-3-byungchul@sk.com>
 <489d941f-c4e8-4d1f-92ee-02074c713dd1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <489d941f-c4e8-4d1f-92ee-02074c713dd1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0xTVxjGPfee3ntpWnIpGo5g1NSpC4sKROeb6IiGBG/iTEy2zERNtBl3
	tFlB0gLKsk2glThQBBJklD+WgqWUKlhkc05IxYBWojJEQAWCjESRf8pst0rjbCFGvpz88rzn
	PL/3w+FoRTkTyWlS00VdqkqrZKRYOi2r2aS9l5Acc/H3bVB8JgY8b05jqGxyMNBzuRGB42oO
	BROde2DAO4Vg/t4DGspKexDUPBum4WrXCII2Wy4DD8dDoc8zy4C7tIABQ20TA39N+ikYOl9C
	QaNzH3QXWShw+Z5jKJtgoKLMQAWOFxT4rHYWrNnrYcxmYsH/LBbcI/0SaHvyGZRXDzFwo82N
	oevaGAUPr1cyMOL4XwLdXXcw9BSflcClGQsDk14rDVbPLAu9LjMFzcZAUd4/7yRw+6yLgry6
	KxT0Pf4TQfvpUQqcjn4GbnmmKGhxltLwtr4TwVjhNAunzvhYqMgpRFBw6jwG49A2mP8vYKx6
	Ews5F5rxrh2Co9qBhFtTs7RgbDkutHnNWLhrIcIfpmFWMLY/YQWzM0NosUULtTcmKKFmziMR
	nPZfGME5V8IK+dN9lDBz/z4r3Pl1Hu+POijdmSRqNZmibkv8Uam6y+XAaXVxJx4MZGSjpg35
	KIQj/FbivVBC5SNugcdfyoIx5teTR/XjKMgMv5EMDvroIC/n15GGVvsC0/wrKSl5/F2Qw/lE
	Mmu/iYM1cn47+dcYHYwVvJpU+Q0LNXI+jLjLx/Hi043EX91LB6/TfBSpf8ctxmuIobVioT2E
	/4L03W2WBHlFwOr67XZgSWlgyf4Q0lTbSi9uv5LctA3iIhRmWqIwLVGYPipMSxRmhO1IoUnN
	TFFptFs3q7NSNSc2f3ssxYkCH9b6k//QNTTX81UH4jmklMmLDiUkKySqTH1WSgciHK1cLg+N
	CETyJFXWD6Lu2BFdhlbUd6AoDisj5HHe40kKPlmVLn4vimmi7sOU4kIis9Gy3sPup+LBk3tj
	ataasyaHGn5uzO3exNErVsuiwxLo+Pi5fZdfDreHJ9jsfIfF0DqqHfzasmWVZ+D6VGzV3vSC
	1598mcasjBkdPWeIjGtekzeh/HsyVxdBds4kdtq2h2pt6mW7N3B10FB4KfHT+ulSX/GBzwt/
	dBvCq2Xf6Cvda5VYr1bFRtM6veo9bUSmFqwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH8zzvtdWSdx3qO9w06+bMICpMiSfRbUa2+WzL1OzDlmimNvpK
	G8utlUuNbrAWIjcHLMAsggVMYaUTLOLcFNaBVKoiTFDBUKaERBGUBSmKdG4txsiXk1/+55zf
	+XJ4SjnDhPHa+P2SPl6tU7FyWr55nWmFrjMmNtKbEwaFeZHgmzxMw7F6BwvdJ+sQOE5nYBhp
	3wQ3p8YQzHR2UVBa3I2g8o6XgtPuQQTNtd+z0DMcAr2+cRY8xbksmKrrWfhr1I9hoKQIQ53z
	C7hcUIXBNX2XhtIRFspKTThQ7mGYttk5sKUvg6FaCwf+O1HgGbzBQFu5h4HmWxFwtGKAhfPN
	HhrcZ4cw9Px+jIVBx38MXHZ30NBdmM/ALw+rWBidslFg841zcM1lxdBgDtiyHj1j4GK+C0PW
	iVMYevvPIWg5fBuD03GDhTbfGIZGZzEFT2vaEQwdecBBZt40B2UZRxDkZpbQYB6IhpkngYvl
	k1GQcbyB3rCeOCociLSNjVPE3JhKmqesNLlUJZLfLF6OmFtuccTqTCaNteGk+vwIJpUTPoY4
	7dkscU4UcSTnQS8mD69e5UjHTzP01te3ydfvkXTaFEm/6oNdco3b5aATT7yX1nUzOR3Vv5OD
	eF4U1ojD9+fnIBlPC8vE6zXDKMissFzs65umghwqvCX+3GSfZUr4Ry4W9e8N8qvCJ+K4/U86
	qFEIa8XH5vBgrBQ0YrnfNKtRCK+InqPD9PPV5aK/4hoVHKeExWLNM/55vFQ0NZXN2mXC+2Lv
	pQYmyAsCV11nLuICFGKZY7LMMVlemixzTFZE21GoNj4lTq3VRa807NMY47VpK3cnxDlR4CVt
	h/yFZ9Fkz6ZWJPBINV9RsD0mVsmoUwzGuFYk8pQqVBGyKBAp9qiNByR9wk59sk4ytKLFPK1a
	pPjsa2mXUohV75f2SVKipH/RxbwsLB3hPuOXO1jl6h/NlQWRh2xRuRv83o/0m7c+yvx0Xlp0
	xVdv56m8JCImf2L7uxsNtuye1G8+r7NJXVvCtmR6/CVNSzTeJOOv5h9kf7cs3Taq+df6XWJ1
	Ula/W3YqWy4lvHFw5/HXTqYKMbc70w8mXdDtcH18pfjMwvbHb35o//aPCxEpHe0q2qBRR4VT
	eoP6f9kzxoeOAwAA
X-CFilter-Loop: Reflected

On Sun, Nov 24, 2024 at 10:34:02PM +0900, Yunseong Kim wrote:
> Hi Byungchul,
> 
> Thank you for the great feature. Currently, DEPT has a bug in the
> 'dept_key_destroy()' function that must be fixed to ensure proper
> operation in the upstream Linux kernel.
> 
> On 5/8/24 6:46 오후, Byungchul Park wrote:
> > CURRENT STATUS
> > --------------
> > Lockdep tracks acquisition order of locks in order to detect deadlock,
> > and IRQ and IRQ enable/disable state as well to take accident
> > acquisitions into account.
> > 
> > Lockdep should be turned off once it detects and reports a deadlock
> > since the data structure and algorithm are not reusable after detection
> > because of the complex design.
> > 
> > PROBLEM
> > -------
> > *Waits* and their *events* that never reach eventually cause deadlock.
> > However, Lockdep is only interested in lock acquisition order, forcing
> > to emulate lock acqusition even for just waits and events that have
> > nothing to do with real lock.
> > 
> > Even worse, no one likes Lockdep's false positive detection because that
> > prevents further one that might be more valuable. That's why all the
> > kernel developers are sensitive to Lockdep's false positive.
> > 
> > Besides those, by tracking acquisition order, it cannot correctly deal
> > with read lock and cross-event e.g. wait_for_completion()/complete() for
> > deadlock detection. Lockdep is no longer a good tool for that purpose.
> > 
> > SOLUTION
> > --------
> > Again, *waits* and their *events* that never reach eventually cause
> > deadlock. The new solution, Dept(DEPendency Tracker), focuses on waits
> > and events themselves. Dept tracks waits and events and report it if
> > any event would be never reachable.
> > 
> > Dept does:
> >    . Works with read lock in the right way.
> >    . Works with any wait and event e.i. cross-event.
> >    . Continue to work even after reporting multiple times.
> >    . Provides simple and intuitive APIs.
> >    . Does exactly what dependency checker should do.
> > 
> > Q & A
> > -----
> > Q. Is this the first try ever to address the problem?
> > A. No. Cross-release feature (b09be676e0ff2 locking/lockdep: Implement
> >    the 'crossrelease' feature) addressed it 2 years ago that was a
> >    Lockdep extension and merged but reverted shortly because:
> > 
> >    Cross-release started to report valuable hidden problems but started
> >    to give report false positive reports as well. For sure, no one
> >    likes Lockdep's false positive reports since it makes Lockdep stop,
> >    preventing reporting further real problems.
> > 
> > Q. Why not Dept was developed as an extension of Lockdep?
> > A. Lockdep definitely includes all the efforts great developers have
> >    made for a long time so as to be quite stable enough. But I had to
> >    design and implement newly because of the following:
> > 
> >    1) Lockdep was designed to track lock acquisition order. The APIs and
> >       implementation do not fit on wait-event model.
> >    2) Lockdep is turned off on detection including false positive. Which
> >       is terrible and prevents developing any extension for stronger
> >       detection.
> > 
> > Q. Do you intend to totally replace Lockdep?
> > A. No. Lockdep also checks if lock usage is correct. Of course, the
> >    dependency check routine should be replaced but the other functions
> >    should be still there.
> > 
> > Q. Do you mean the dependency check routine should be replaced right
> >    away?
> > A. No. I admit Lockdep is stable enough thanks to great efforts kernel
> >    developers have made. Lockdep and Dept, both should be in the kernel
> >    until Dept gets considered stable.
> > 
> > Q. Stronger detection capability would give more false positive report.
> >    Which was a big problem when cross-release was introduced. Is it ok
> >    with Dept?
> > A. It's ok. Dept allows multiple reporting thanks to simple and quite
> >    generalized design. Of course, false positive reports should be fixed
> >    anyway but it's no longer as a critical problem as it was.
> > 
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> If a module previously checked for dependencies by DEPT is loaded and
> then would be unloaded, a kernel panic shall occur when the kernel

Hi,

Thank you for sharing the issue.  Yes.  I'm aware of what you are
mentioning.  I will fix it with high priority.

Thanks again.

	Byungchul

> reuses the corresponding memory area for other purposes. This issue must
> be addressed as a priority to enable the use of DEPT. Testing this patch
> on the Ubuntu kernel confirms the problem.
> 
> > +void dept_key_destroy(struct dept_key *k)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +	unsigned long flags;
> > +	int sub_id;
> > +
> > +	if (unlikely(!dept_working()))
> > +		return;
> > +
> > +	if (dt->recursive == 1 && dt->task_exit) {
> > +		/*
> > +		 * Need to allow to go ahead in this case where
> > +		 * ->recursive has been set to 1 by dept_off() in
> > +		 * dept_task_exit() and ->task_exit has been set to
> > +		 * true in dept_task_exit().
> > +		 */
> > +	} else if (dt->recursive) {
> > +		DEPT_STOP("Key destroying fails.\n");
> > +		return;
> > +	}
> > +
> > +	flags = dept_enter();
> > +
> > +	/*
> > +	 * dept_key_destroy() should not fail.
> > +	 *
> > +	 * FIXME: Should be fixed if dept_key_destroy() causes deadlock
> > +	 * with dept_lock().
> > +	 */
> > +	while (unlikely(!dept_lock()))
> > +		cpu_relax();
> > +
> > +	for (sub_id = 0; sub_id < DEPT_MAX_SUBCLASSES; sub_id++) {
> > +		struct dept_class *c;
> > +
> > +		c = lookup_class((unsigned long)k->base + sub_id);
> > +		if (!c)
> > +			continue;
> > +
> > +		hash_del_class(c);
> > +		disconnect_class(c);
> > +		list_del(&c->all_node);
> > +		invalidate_class(c);
> > +
> > +		/*
> > +		 * Actual deletion will happen on the rcu callback
> > +		 * that has been added in disconnect_class().
> > +		 */
> > +		del_class(c);
> > +	}
> > +
> > +	dept_unlock();
> > +	dept_exit(flags);
> > +
> > +	/*
> > +	 * Wait until even lockless hash_lookup_class() for the class
> > +	 * returns NULL.
> > +	 */
> > +	might_sleep();
> > +	synchronize_rcu();
> > +}
> > +EXPORT_SYMBOL_GPL(dept_key_destroy);
> 
> Best regards,
> Yunseong Kim

