Return-Path: <linux-fsdevel+bounces-20871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 745238FA5E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 00:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326ED1F24ED3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F151C13D29C;
	Mon,  3 Jun 2024 22:39:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C32136994;
	Mon,  3 Jun 2024 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454347; cv=none; b=ZUhS1b8rmxDNPR6eXgROxD630qbRzSoEdfvnZC4d+DHq6Pj87zow7kJZQge6zzWn+RwfPhCcvc1kSw+/7ZWZ5SsLT6X2B774uRBm2HdVbOcO1kve5xdrKQpL2PeMePK1VlXYEQKI1dFh+hfbEwTKfhxsxAIJSOn3GSQxTNc7CtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454347; c=relaxed/simple;
	bh=dM5djux4B7U2WW16KMjOhhGaxS9EJBjSC0Y78XYzP7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vF47Bg1sEtNw1VHFQD4klB5VrKZPqzgVQXAVUMVem+tM3xvMZyzJfbzBHHlpNktx3fFbSeF9F/6gu7X8lazZ3mPsdqO0VWCGpVX7LeJ9gHqTHvW+9qOamj05HCXkRxvocoGoSU2qtZlYMhjAlECwwpCFXZ0Grr6lqPTWA+A9uWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A673C2BD10;
	Mon,  3 Jun 2024 22:39:05 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:40:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 audit@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
Message-ID: <20240603184016.3374559f@gandalf.local.home>
In-Reply-To: <20240603183742.17b34bc3@gandalf.local.home>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
	<20240602023754.25443-3-laoar.shao@gmail.com>
	<20240603172008.19ba98ff@gandalf.local.home>
	<CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
	<20240603181943.09a539aa@gandalf.local.home>
	<CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
	<20240603183742.17b34bc3@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 18:37:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Note, I've been wanting to get rid of the hard coded TASK_COMM_LEN from the
> events for a while. As I mentioned before, the only reason the memcpy exists
> is because it was added before the __string() logic was. Then it became
> somewhat of a habit to do that for everything that referenced task->comm. :-/

My point is that if we are going to be changing the way we record
task->comm in the events, might as well do the change I've been wanting to
do for years. I'd hold off on the sched_switch event, as that's the one
event (and perhaps sched_waking events) that user space may be have
hardcoded how to read it.

I would be interested in changing it, just to see what breaks, so I would
know where to go fix things. But keep it a separate patch so that it could
be easily reverted.

-- Steve

