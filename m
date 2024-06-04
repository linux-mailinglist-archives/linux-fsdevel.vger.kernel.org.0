Return-Path: <linux-fsdevel+bounces-20971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F21EC8FB934
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 18:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725FDB25B6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21B381721;
	Tue,  4 Jun 2024 16:37:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F6146D6E;
	Tue,  4 Jun 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519072; cv=none; b=oOit6kJffjqGa0lIaxJhK4we4VkYsRMbyRAOcjvPBkmRsLUorXwYt/lohY5hM1TdnQTwSkZCVSCGiOsddzr22KLMLuGdvhQVwvF/M8pe6X5MFwDBhrNTMCCo5TpYAaAGkhz+RrCnCRX9lXTEltVapEMNwW72u0AXeRKsoNd1H4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519072; c=relaxed/simple;
	bh=2pMUa3S1nxXDlCina66BMlGQj99L1msaowQ166Kxu9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVU5M2bwTJ2EmbxOt2KvEiH0q8izJCcHl94KjtYH3BUKu0qUqb7VC73nxJ4DIC6M747jQXJjZAN22yOnpu39XKvrxJOUTjHv7fzP46P5ntwRBgmb+hmVXDK8/uST1/MVFuQ/l0VVKB/OJfZ4WhUPECbLhyG+XnHU4j0fv2bL0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335BFC2BBFC;
	Tue,  4 Jun 2024 16:37:47 +0000 (UTC)
Date: Tue, 4 Jun 2024 12:37:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe
 <axboe@kernel.dk>, Metin Kaya <metin.kaya@arm.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, Phil Auld
 <pauld@redhat.com>
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240604123745.71921f39@gandalf.local.home>
In-Reply-To: <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
References: <20240604144228.1356121-1-qyousef@layalina.io>
	<20240604144228.1356121-2-qyousef@layalina.io>
	<b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 17:57:46 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 6/4/24 16:42, Qais Yousef wrote:
> > -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
> > +	    (wakeup_rt && !realtime_task(p)) ||  
> 
> I do not like bikeshedding, and no hard feelings...
> 
> But rt is a shortened version of realtime, and so it is making *it less*
> clear that we also have DL here.
> 
> I know we can always read the comments, but we can do without changes
> as well...
> 
> I would suggest finding the plural version for realtime_task()... so
> we know it is not about the "rt" scheduler, but rt and dl schedulers.

priority_task() ?

Or should we go with royal purple and call it "royalty_task()" ? ;-)

-- Steve



