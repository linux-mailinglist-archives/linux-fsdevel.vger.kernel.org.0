Return-Path: <linux-fsdevel+bounces-16445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855E989DC55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA941F262F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16483347B6;
	Tue,  9 Apr 2024 14:30:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF2101EC;
	Tue,  9 Apr 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673055; cv=none; b=gfARgFd+/s7KkoH74eiWA0Rk7u1/fRFhDcO01ZKqZJy54FPSFQIqZIcCa0vWn1jCTMDwveount5kvl/SRfjN6xjgp1l8L27E8dFUNq/TSlx4a3w/xZ7KisxHsfSQE9wYRYCfmuFQvn+WBVqHnBjxnmvKseHWRQ2MUGSqTaA5y0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673055; c=relaxed/simple;
	bh=Jc48hF8Bi2QJFLufyPe696cWZVDXbPnfhf6kpwJkW9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IL0rrqes6PwpjaLbJMHk6jcTT5txbXosW7qi4dHEHnO9LhtCoMEh4cX9N7FB8CE0+zxwIG1pL/OVJ7aAQA/rNvdEWlpG0y/nf+C2IhfR+RUWhCU2Lfwp3Kim/TtjM9dsGlETlZPWSWZowzm5yaz5tP/vJ+r82kCOzhU534cz3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54BCC433C7;
	Tue,  9 Apr 2024 14:30:53 +0000 (UTC)
Date: Tue, 9 Apr 2024 10:33:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Elver <elver@google.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
Message-ID: <20240409103327.7a9012fa@gandalf.local.home>
In-Reply-To: <20240408090205.3714934-1-elver@google.com>
References: <20240408090205.3714934-1-elver@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 11:01:54 +0200
Marco Elver <elver@google.com> wrote:

> Add "new_exec" tracepoint, which is run right after the point of no
> return but before the current task assumes its new exec identity.
> 
> Unlike the tracepoint "sched_process_exec", the "new_exec" tracepoint
> runs before flushing the old exec, i.e. while the task still has the
> original state (such as original MM), but when the new exec either
> succeeds or crashes (but never returns to the original exec).
> 
> Being able to trace this event can be helpful in a number of use cases:
> 
>   * allowing tracing eBPF programs access to the original MM on exec,
>     before current->mm is replaced;
>   * counting exec in the original task (via perf event);
>   * profiling flush time ("new_exec" to "sched_process_exec").
> 
> Example of tracing output ("new_exec" and "sched_process_exec"):

How common is this? And can't you just do the same with adding a kprobe?

-- Steve

