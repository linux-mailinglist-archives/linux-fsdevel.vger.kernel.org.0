Return-Path: <linux-fsdevel+bounces-20963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E2A8FB70F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977F51C22EB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2285C1448DE;
	Tue,  4 Jun 2024 15:28:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4B143C7A;
	Tue,  4 Jun 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514882; cv=none; b=SMzwzBJxqgEluhcMUIhx7o7Xmj3NqLfpVuK9qvGvWue2Enr6phJkJgG7ccdxvL0t2p+ZNwvE1uJOHBhSuplRLG6DSaq5pMKZNEmWxMyq9Vo1vBetBkfeT976DGPFRMU/9g/PgEG5bOEDjJbk50n0szS/US257UacI8jupNI0cT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514882; c=relaxed/simple;
	bh=N7rt7381fj96UTAPC9MEjjfA0I4AkNKWgkWWPbMyq44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Egk1CRfM0QvaEWx9Dlr5mhzRvAQ7p0dTYNd/2qURYYdciJNhXIS2SkV4fhSR5wDqWs2An+sQcGOsWc9usOsrjaTMWO5Husc4uWRvEN6rH/c7JvZ2BRyiMgio9+0CGcfiKEjB4wdlRNhr1FiNlg8uuT1SUuGjkaqhIMF87Welf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30859C4AF07;
	Tue,  4 Jun 2024 15:28:00 +0000 (UTC)
Date: Tue, 4 Jun 2024 11:27:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Metin Kaya <metin.kaya@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 2/2] sched/rt, dl: Convert functions to return bool
Message-ID: <20240604112759.56b9394c@gandalf.local.home>
In-Reply-To: <417b39d1-8de8-4234-92dc-f1ef5fd95da7@arm.com>
References: <20240601213309.1262206-1-qyousef@layalina.io>
	<20240601213309.1262206-3-qyousef@layalina.io>
	<417b39d1-8de8-4234-92dc-f1ef5fd95da7@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 08:33:53 +0100
Metin Kaya <metin.kaya@arm.com> wrote:

> On 01/06/2024 10:33 pm, Qais Yousef wrote:
> > {rt, realtime, dl}_{task, prio}() functions return value is actually
> > a bool.  Convert their return type to reflect that.
> > 
> > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >   include/linux/sched/deadline.h |  8 ++++----
> >   include/linux/sched/rt.h       | 16 ++++++++--------
> >   2 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> > index 5cb88b748ad6..f2053f46f1d5 100644
> > --- a/include/linux/sched/deadline.h
> > +++ b/include/linux/sched/deadline.h
> > @@ -10,18 +10,18 @@
> >   
> >   #include <linux/sched.h>
> >   
> > -static inline int dl_prio(int prio)
> > +static inline bool dl_prio(int prio)
> >   {
> >   	if (unlikely(prio < MAX_DL_PRIO))
> > -		return 1;
> > -	return 0;
> > +		return true;
> > +	return false;  
> 
> Nit: `return unlikely(prio < MAX_DL_PRIO)` would be simpler.
> The same can be applied to rt_prio() and realtime_prio(). This would 
> make {dl, rt, realtime}_task() single-liner. Maybe further 
> simplification can be done.

Agreed.

-- Steve

