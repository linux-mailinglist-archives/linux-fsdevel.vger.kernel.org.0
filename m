Return-Path: <linux-fsdevel+bounces-21440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2633B903E8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99CB1F2219D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0117D379;
	Tue, 11 Jun 2024 14:20:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87690AD2C;
	Tue, 11 Jun 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115613; cv=none; b=C9oWgTpZmwvWVeL/V57KlZ95YmguLHnL30bQ+MhO+xthLm/X6eyZDbJWtcX8nDDcLq+gQR7vE6HoCHdrM4VA/NQq7HAxY+1EsBnQOHRyDgBAbeQy5cZ8R5ZY7qE+iRdCUnbzLWhs68Hdo8pef52oQ5ZlbTe0oq4bBXSSmrerAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115613; c=relaxed/simple;
	bh=VIwnoCS4IaBoGX5EiRkAQ9RQUl2lu3NbQQfnw5doDjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0qinAmChcGrEFNddkc1yOnJnPIt3fhAAFzjE5ualSE3qAYf+pjGGT0RDhRW6M7EpzXEDd3yudeQsCAStvYDyPxsHI069MbT7ci8OUxitCXcUCKC9Vzx9Tc2+6yt/oxQCW+SmYaSRFG8Jgg/IJ+0aSHddH+cZQhqaDvnkbRjbNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9A1C2BD10;
	Tue, 11 Jun 2024 14:20:11 +0000 (UTC)
Date: Tue, 11 Jun 2024 10:20:26 -0400
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
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 3/3] sched/rt: Rename realtime_{prio, task}() to
 rt_or_dl_{prio, task}()
Message-ID: <20240611102026.1be1155f@gandalf.local.home>
In-Reply-To: <b5f84790-8036-44cf-bfd9-0a43269a26d9@redhat.com>
References: <20240610192018.1567075-1-qyousef@layalina.io>
	<20240610192018.1567075-4-qyousef@layalina.io>
	<b5f84790-8036-44cf-bfd9-0a43269a26d9@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 11:03:25 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 6/10/24 21:20, Qais Yousef wrote:
> > -	if (realtime_prio(p->prio)) /* includes deadline */
> > +	if (rt_or_dl_prio(p->prio))  
> 
> that is it... no thinking, no recall, no comment, no confusion...

How about "not_normal_prio(p->prio)" ?

/me runs!

-- Steve

