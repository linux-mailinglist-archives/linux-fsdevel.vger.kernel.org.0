Return-Path: <linux-fsdevel+bounces-51968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BAAADDC16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 21:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD51940632
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2672EAB67;
	Tue, 17 Jun 2025 19:14:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5828C5A7;
	Tue, 17 Jun 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187697; cv=none; b=nXsHOJ/Gl+X136WKUFWGPhE/NQzIsUELe/22MHk1QGdFf5rbkffmufETD5vcJXvm1BA7xyanC5lpOpL0ZqL4E/2CU0NIatEN3O0aIOrLWQdDL4qN5E/owNrTx0Su+NPLUjZ/PMfp2SV50gBtjPMqIieunFX+ePL1RN6l2zHOW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187697; c=relaxed/simple;
	bh=Mlkho68yaCGW3nRvI32GhkwoRa6uQRsxczAa9nMl0+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foeyRa/rCVDjPoKdO1k5xeVbLuY/+iSKy3KziWS3x872XjZrHl80yOsCM8hyPz+7sdz8aG3LQqwnvzKrlXHTiVu7uJiGCn/5hKXDkV7vtnGy5jwW4alga6TIhw6s0RpX5ool4xEmmwf1DcWI/ylTwL4igYfy9W5qAi66vtzV16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 4B4C41D6EE1;
	Tue, 17 Jun 2025 19:14:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id EC94A20028;
	Tue, 17 Jun 2025 19:14:41 +0000 (UTC)
Date: Tue, 17 Jun 2025 15:14:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Rogers <irogers@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, "linux-trace-users@vger.kernel.org"
 <linux-trace-users@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Namhyung Kim
 <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Jiri Olsa
 <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] tracing: Deprecate auto-mounting tracefs in
 debugfs
Message-ID: <20250617151447.36010066@gandalf.local.home>
In-Reply-To: <CAP-5=fVH1HfdXT7HLZhav9k6m7t7Ji-=y2Gw13h1qMtgW8cRQA@mail.gmail.com>
References: <20250617133614.24e2ba7f@gandalf.local.home>
	<20250617174107.GB1613376@noisy.programming.kicks-ass.net>
	<3201A571-6F08-4E26-AC33-39E0D1925D27@goodmis.org>
	<20250617180023.GC1613376@noisy.programming.kicks-ass.net>
	<CAP-5=fVH1HfdXT7HLZhav9k6m7t7Ji-=y2Gw13h1qMtgW8cRQA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: EC94A20028
X-Stat-Signature: rn1a6rfx7qsz1q6ymr5d84f68rizcbce
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/dhm5moVN0TZwyG1ih33zPj0n4p6dC8go=
X-HE-Tag: 1750187681-68726
X-HE-Meta: U2FsdGVkX1/vQSCTT1fgthW4COBAcZErxaQy6RATzgHQe6CSzIxQCRH/WLygwcFDl5NWqeIdfI6GvciRJn004lzSRNJ50NXScP8uf7k7/JmGwexbOdJDjz80fUFF7dw1l552uOcZuZtcBPXLWNNzKjWcK6+mKil0daZd5wQSdeJ167rbhSDd3wSt4oNsA2gMJ0J6bVzBIa6i373F0gwbnJxFV/3vWpgOBFsuz87dCt0YmTSx92syuf2bG207AHqqoh3Hcul6gTqPAzFSZkHMgequzIqWqcoqTOUlOQwgOstuTHTOOjzDpzQ2hbENTh2dP0QCAhcK2dbWuIniDMJa3W3L8BUwIFGLShAUQMNMmjzxf7c7JMCUfw==

On Tue, 17 Jun 2025 11:48:53 -0700
Ian Rogers <irogers@google.com> wrote:

> I see a number of references to debug/tracing in places like perf testing:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/common/init.sh?h=perf-tools-next#n122
> are you planning patches for these?

Thanks for pointing that out.

Yes, I plan on sending patches to remove all references to debug/tracing.

One reason I put the removal date to Jan 2027. To give a year and a half.

-- Steve

