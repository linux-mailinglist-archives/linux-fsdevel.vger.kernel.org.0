Return-Path: <linux-fsdevel+bounces-5241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 919D78095CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BC91F21270
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8FA57311
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdAxYA+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F57B3CB;
	Thu,  7 Dec 2023 21:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15240C433CC;
	Thu,  7 Dec 2023 21:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701984315;
	bh=YaZTLucbXUWiTUu4ZO//do5mro1EpRuUKJNhwZYZyPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdAxYA+EeNyu7dUv+IRTk8zJHh9KLM672+XJ7jpuEtThS6zfCTI3ANCa3/dWlAyad
	 LUFegPgGXaSaGie9FCRbKhkTRG0O8jkxlJ/INEAwB6RH1wXjf1rYbDbjEvfyI46TvY
	 H2mChOR+2VWzt6u8hVb9eEhU8KM0kVhU0m0iv06jCCul2W5q8IZJi8z4osKMyynxoN
	 G5I02OijBORh6p1rFOjgnaGjyZWdin5pPaH0ehw2ORdAN4bl2pva8cMV0cA7xS1l89
	 b4HfU3IB3Rvodibolr3RCSjicIDtQi+roEsAcCcoOK2QRO1cKESYSK+/pj0nkM6KlB
	 +wrdrhd5q1UbQ==
Date: Thu, 7 Dec 2023 22:25:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>, Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <20231207-avancieren-unbezahlbar-9258f45ec3ec@brauner>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <20231130173938.GA21808@redhat.com>
 <ZWjM6trZ6uw6yBza@tycho.pizza>
 <ZWoKbHJ0152tiGeD@tycho.pizza>
 <20231207-weither-autopilot-8daee206e6c5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207-weither-autopilot-8daee206e6c5@brauner>

> If these concerns are correct

So, ok. I misremebered this. The scenario I had been thinking of is
basically the following.

We have a thread-group with thread-group leader 1234 and a thread with
4567 in that thread-group. Assume current thread-group leader is tsk1
and the non-thread-group leader is tsk2. tsk1 uses struct pid *tg_pid
and tsk2 uses struct pid *t_pid. The struct pids look like this after
creation of both thread-group leader tsk1 and thread tsk2:

	TGID 1234				TID 4567 
	tg_pid[PIDTYPE_PID]  = tsk1		t_pid[PIDTYPE_PID]  = tsk2
	tg_pid[PIDTYPE_TGID] = tsk1		t_pid[PIDTYPE_TGID] = NULL

IOW, tsk2's struct pid has never been used as a thread-group leader and
thus PIDTYPE_TGID is NULL. Now assume someone does create pidfds for
tsk1 and for tsk2:
	
	tg_pidfd = pidfd_open(tsk1)		t_pidfd = pidfd_open(tsk2)
	-> tg_pidfd->private_data = tg_pid	-> t_pidfd->private_data = t_pid

So we stash away struct pid *tg_pid for a pidfd_open() on tsk1 and we
stash away struct pid *t_pid for a pidfd_open() on tsk2.

If we wait on that task via P_PIDFD we get:

				/* waiting through pidfd */
	waitid(P_PIDFD, tg_pidfd)		waitid(P_PIDFD, t_pidfd)
	tg_pid[PIDTYPE_TGID] == tsk1		t_pid[PIDTYPE_TGID] == NULL
	=> succeeds				=> fails

Because struct pid *tg_pid is used a thread-group leader struct pid we
can wait on that tsk1. But we can't via the non-thread-group leader
pidfd because the struct pid *t_pid has never been used as a
thread-group leader.

Now assume, t_pid exec's and the struct pids are transfered. IIRC, we
get:

	tg_pid[PIDTYPE_PID]   = tsk2		t_pid[PIDTYPE_PID]   = tsk1
	tg_pid[PIDTYPE_TGID]  = tsk2		t_pid[PIDTYPE_TGID]  = NULL

If we wait on that task via P_PIDFD we get:
	
				/* waiting through pidfd */
	waitid(P_PIDFD, tg_pidfd)		waitid(P_PIDFD, t_pid)
	tg_pid[PIDTYPE_TGID] == tsk2		t_pid[PIDTYPE_TGID] == NULL
	=> succeeds				=> fails

Which is what we want. So effectively this should all work and I
misremembered the struct pid linkage. So afaict we don't even have a
problem here which is great.

