Return-Path: <linux-fsdevel+bounces-43408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A074A5609A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 07:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F88518957E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 06:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3491990C3;
	Fri,  7 Mar 2025 06:08:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AA190482
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327731; cv=none; b=BVglbaOd+l6OtUY00OnQ7A8siVHXt5twNw2OiJaHyd6Xa0usack8CqIiGaHwIoaogq3sCK7PrAcs+OlQD48OT0P0XOd8hhvhYeB3wN8wfeiLiVFOh1F9aE7kot+XhwKJqQDntFHlHkWtDDihJpNGZxqIsdFS9PyBR14dqKloGWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327731; c=relaxed/simple;
	bh=T2QkG4EZej3NuePHZ+cAjBoD70+eX/KlMVHwBiryygw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uky4EQfXKXLkJWZSflppKw2IqGPkX7MTcyXtwBXpiKTQLRXbz+f58gnEXu/Olgh0aA5UPzumK0bExNIn/XRsknl0T+iF3PccR0n0AklZKXOFVy7pL2x+mQ5km6AwnPN/yP3b1DyBJTHgmevcpvN8pvS1ZMN6WqmtmtsSpdpJrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.28])
	by sina.com (10.185.250.23) with ESMTP
	id 67CA8D64000021D4; Fri, 7 Mar 2025 14:08:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4079398913364
X-SMAIL-UIID: D44F113D61CE430ABCB960723B7B6BCE-20250307-140838-1
From: Hillf Danton <hdanton@sina.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Fri,  7 Mar 2025 14:08:26 +0800
Message-ID: <20250307060827.3083-1-hdanton@sina.com>
In-Reply-To: <20250306093021.GA19868@redhat.com>
References: <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com> <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com> <20250304050644.2983-1-hdanton@sina.com> <20250304102934.2999-1-hdanton@sina.com> <20250304233501.3019-1-hdanton@sina.com> <20250305045617.3038-1-hdanton@sina.com> <20250305224648.3058-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 6 Mar 2025 10:30:21 +0100 Oleg Nesterov <oleg@redhat.com>
> On 03/06, Hillf Danton wrote:
> > On Wed, 5 Mar 2025 12:44:34 +0100 Oleg Nesterov <oleg@redhat.com>
> > > On 03/05, Hillf Danton wrote:
> > > > See the loop in  ___wait_event(),
> > > >
> > > > 	for (;;) {
> > > > 		prepare_to_wait_event();
> > > >
> > > > 		// flip
> > > > 		if (condition)
> > > > 			break;
> > > >
> > > > 		schedule();
> > > > 	}
> > > >
> > > > After wakeup, waiter will sleep again if condition flips false on the waker
> > > > side before waiter checks condition, even if condition is atomic, no?
> > >
> > > Yes, but in this case pipe_full() == true is correct, this writer can
> > > safely sleep.
> > >
> > No, because no reader is woken up before sleep to make pipe not full.
> 
> Why the reader should be woken before this writer sleeps? Why the reader
> should be woken at all in this case (when pipe is full again) ?
> 
"to make pipe not full" failed to prevent you asking questions like this one.

> We certainly can't understand each other.
> 
> Could your picture the exact scenario/sequence which can hang?
> 
If you think the scenario in commit 3d252160b818 [1] is correct, check
the following one.

step-00
	pipe->head = 36
	pipe->tail = 36
	after 3d252160b818

step-01
	task-118762 writer
	pipe->head++;
	wakes up task-118740 and task-118768

step-02
	task-118768 writer
	makes pipe full;
	sleeps without waking up any reader as
	pipe was not empty after step-01

step-03
	task-118766 new reader
	makes pipe empty
	sleeps

step-04
	task-118740 reader
	sleeps as pipe is empty

[ Tasks 118740 and 118768 can then indefinitely wait on each other. ]


[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/pipe.c?id=3d252160b818045f3a152b13756f6f37ca34639d

