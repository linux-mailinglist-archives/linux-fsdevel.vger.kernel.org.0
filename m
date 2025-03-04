Return-Path: <linux-fsdevel+bounces-43189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C5A4F18D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 00:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A4F3AB1E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 23:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1B24DFE1;
	Tue,  4 Mar 2025 23:35:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9D1FECB8
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131327; cv=none; b=CjjUeAF6V8hkjHfYdziiAesbiHnlm6Ldy5CHhF8WgK5b0IGhrEwgpH2HrzyirdLPQF7NlAyskSpx/ON5h7RpTz7nArqdNnV/peI1f72AuMgu1UvFskQS2VT85tQl40mSuwX0lnQsqemkOouHnn1a3VgmP5bspo/HVReSeLZC7Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131327; c=relaxed/simple;
	bh=d/7vgs/C5rwes4Txtu4q0m9uILsnhLNub4HC3E8ykmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1CgXPsy/q77TsOvD/UZtmDyZTVMqZ43UXkCQ1M6RL9pwFSp1zhNWJUA9SCm39EuhZMquKDuT7mWYp1KeRiXtfKEoBYcLllwi4vF2mC0azh+62437kj8muYaAWafxsiA7q1pPE3uNHm2NiFQrvNxEKwRD20BUDcPx29uZBofPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.118])
	by sina.com (10.185.250.23) with ESMTP
	id 67C78E2E00002C0E; Tue, 5 Mar 2025 07:35:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2523278913411
X-SMAIL-UIID: A9E38C04C32D46F99DE422E1BD7AAFB2-20250305-073513-1
From: Hillf Danton <hdanton@sina.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Wed,  5 Mar 2025 07:35:00 +0800
Message-ID: <20250304233501.3019-1-hdanton@sina.com>
In-Reply-To: <20250304123457.GA25281@redhat.com>
References: <e813814e-7094-4673-bc69-731af065a0eb@amd.com> <20250224142329.GA19016@redhat.com> <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt> <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com> <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com> <20250304050644.2983-1-hdanton@sina.com> <20250304102934.2999-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 4 Mar 2025 13:34:57 +0100 Oleg Nesterov <oleg@redhat.com>
> On 03/04, Hillf Danton wrote:
> > On Tue, 4 Mar 2025 11:05:57 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
> > >> @@ -573,11 +573,13 @@ pipe_write(struct kiocb *iocb, struct io
> > >>   		 * after waiting we need to re-check whether the pipe
> > >>   		 * become empty while we dropped the lock.
> > >>   		 */
> > >> +		tail = pipe->tail;
> > >>   		mutex_unlock(&pipe->mutex);
> > >>   		if (was_empty)
> > >>   			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> > >>   		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> > >> -		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
> > >> +		wait_event_interruptible_exclusive(pipe->wr_wait,
> > >> +				!READ_ONCE(pipe->readers) || tail != READ_ONCE(pipe->tail));
> > >
> > >That could work too for the case highlighted but in case the head too
> > >has moved by the time the writer wakes up, it'll lead to an extra
> > >wakeup.
> > >
> > Note wakeup can occur even if pipe is full,
> 
> Perhaps I misunderstood you, but I don't think pipe_read() can ever do
> wake_up(pipe->wr_wait) if pipe is full...
> 
> > 		 * So we still need to wake up any pending writers in the
> > 		 * _very_ unlikely case that the pipe was full, but we got
> > 		 * no data.
> > 		 */
> 
> Only if wake_writer is true,
> 
> 		if (unlikely(wake_writer))
> 			wake_up_interruptible_sync_poll(...);
> 
> and in this case the pipe is no longer full. A zero-sized buffer was
> removed.
> 
> Of course this pipe can be full again when the woken writer checks the
> condition, but this is another story. And in this case, with your
> proposed change, the woken writer will take pipe->mutex for no reason.
> 
See the following sequence,

	1) waker makes full false
	2) waker makes full true
	3) waiter checks full
	4) waker makes full false

waiter has no real idea of full without lock held, perhaps regardless
the code cut below.

> Note also that the comment and code above was already removed by
> https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/
> 
> Oleg.

