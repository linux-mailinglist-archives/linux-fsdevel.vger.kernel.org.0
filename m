Return-Path: <linux-fsdevel+bounces-16507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685689E67B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 01:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BE7283CF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 23:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4A61591F4;
	Tue,  9 Apr 2024 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwojOdW2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DC158851;
	Tue,  9 Apr 2024 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706874; cv=none; b=UxfnAUfeVIS0i1dEM06AGUz3RUndetzFlEPrDGJtZdJxVfveNZ0mqDEldOpetpwCU2YJvnosWL/OUf3W7HU2WYE/x2TauW+0CLkKMtdoQ0jW3A1Xq0fczPTF8d4fS0uaZVSCbOi6U7YdIaL2yb2mail+CiwmgCKfHQIncFB8Pck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706874; c=relaxed/simple;
	bh=t1NhF4nrxdQhhoLefZQtEgoMWYKkMCdVLx8xtlo79Mw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mxTXIlVg2YKnKjxPh6neoT4PnQdX2iPlsIelqBXtAA2rn5iK7uNr1HAcj4ppYRkSkey7C5DPiX6LJrPV7ps7IZQij4SqqSz0MNgyGSX+3EBNBu/S3lV3Dz0mvqc8rHmNZ5U0rsX45/kzgReRFVEqtS7DPXQPEMkf4ERvgC9kxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwojOdW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1A9C433F1;
	Tue,  9 Apr 2024 23:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706873;
	bh=t1NhF4nrxdQhhoLefZQtEgoMWYKkMCdVLx8xtlo79Mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NwojOdW2AUtmiM4odkHOSUKtAmqdBkpXq4Sienw6hV91VcOgqBhaTkP76EaYBwmvm
	 MBkGDAY6vmhV262dis86jOzkdodmqdQOnR2F23XwGnbtXO3VsZgxs5qTAFAHqp04uA
	 zFyIk7eMTdtL4aGRMgDaBvjZzkourZhvpq0j8eSOAUwk9zdyMZZuhjkWzeC4TVyTMc
	 0YdNVxcu1YDvf3IxXdYZK9qX586ukiLZj9FwOM+I2YY8t/K9jUCK4bGIpvIEZ8P6zi
	 TlOjbfmbpw23dA7/cVNp44QysvPU+TUeiWYqFr2b73mrRqrfsBQwB6ZdKdueiIl/AM
	 4pezmDgjCkQNw==
Date: Wed, 10 Apr 2024 08:54:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
Message-Id: <20240410085428.53093333cf4d768d6b420a11@kernel.org>
In-Reply-To: <CANpmjNOv=8VBvbKBQbsBdg9y2pNsfdaA-46QB53NY-Ddmq3tmA@mail.gmail.com>
References: <20240408090205.3714934-1-elver@google.com>
	<20240409103327.7a9012fa@gandalf.local.home>
	<CANpmjNOv=8VBvbKBQbsBdg9y2pNsfdaA-46QB53NY-Ddmq3tmA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 16:45:47 +0200
Marco Elver <elver@google.com> wrote:

> On Tue, 9 Apr 2024 at 16:31, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Mon,  8 Apr 2024 11:01:54 +0200
> > Marco Elver <elver@google.com> wrote:
> >
> > > Add "new_exec" tracepoint, which is run right after the point of no
> > > return but before the current task assumes its new exec identity.
> > >
> > > Unlike the tracepoint "sched_process_exec", the "new_exec" tracepoint
> > > runs before flushing the old exec, i.e. while the task still has the
> > > original state (such as original MM), but when the new exec either
> > > succeeds or crashes (but never returns to the original exec).
> > >
> > > Being able to trace this event can be helpful in a number of use cases:
> > >
> > >   * allowing tracing eBPF programs access to the original MM on exec,
> > >     before current->mm is replaced;
> > >   * counting exec in the original task (via perf event);
> > >   * profiling flush time ("new_exec" to "sched_process_exec").
> > >
> > > Example of tracing output ("new_exec" and "sched_process_exec"):
> >
> > How common is this? And can't you just do the same with adding a kprobe?
> 
> Our main use case would be to use this in BPF programs to become
> exec-aware, where using the sched_process_exec hook is too late. This
> is particularly important where the BPF program must stop inspecting
> the user space's VM when the task does exec to become a new process.

Just out of curiousity, would you like to audit that the user-program
is not malformed? (security tracepoint?) I think that is an interesting
idea. What kind of information you need?

> 
> kprobe (or BPF's fentry) is brittle here, because begin_new_exec()'s
> permission check can still return an error which returns to the
> original task without crashing. Only at the point of no return are we
> guaranteed that the exec either succeeds, or the task is terminated on
> failure.

Just a note: That is BPF limitation, kprobe and kprobe events can put
a probe in the function body, but that is not supported on BPF (I guess
because it depends on kernel debuginfo.) You can add kprobe-event using
"perf probe" tool.

Thank you,

> 
> I don't know if "common" is the right question here, because it's a
> chicken-egg problem: no tracepoint, we give up; we have the
> tracepoint, it unlocks a range of new use cases (that require robust
> solution to make BPF programs exec-aware, and a tracepoint is the only
> option IMHO).
> 
> Thanks,
> -- Marco


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

