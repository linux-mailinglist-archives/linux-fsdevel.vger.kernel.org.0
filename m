Return-Path: <linux-fsdevel+bounces-52023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F7AADE671
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353E3174222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 09:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A24F280334;
	Wed, 18 Jun 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1aPEHow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66738460;
	Wed, 18 Jun 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238344; cv=none; b=UMFFUZn52QITuW7xq9XRY8WOvOkARi7NZCuZ6vpyXIoTC9SmPcl1awh2xsdzvkNRy8Otv08RqCQMWJMohLHS20KCVEn0zXSgAtVua4W1Y5hXO6C1D+8Ecvj58gK6b8NJb4zpcqhvNQ+nZGMD6VA5b9BNnHvdeJHZXwDq4PF6k40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238344; c=relaxed/simple;
	bh=BwpR+rZP2lNE2niMFjFRZlfZHHIA4fXPSo6ot9gp2Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5EKAL/7HYcEQab4AQo+mvWrqWMzwBIr1FwD2oiGUSKjMQwEarEEsFrys45Z5ai8pYro/bl0DnbXv6sDYM+D28UQEeLe+LCVojJXTCk0HJBb1ZjASLAr9c+vT19W22wGOAybQuYRCl5O/CmaPcAjaEXLhSZYw5H6E/YfS7PV/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1aPEHow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC15C4CEE7;
	Wed, 18 Jun 2025 09:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750238344;
	bh=BwpR+rZP2lNE2niMFjFRZlfZHHIA4fXPSo6ot9gp2Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1aPEHowVEVLqNprW+Ed+JhzYf8gWk9EB2lrmt+1PpfENC79sa2a4a+8myRptb1hC
	 eki2V1dXvK80pXfdvfDoUhfv4ZXNpLYBJBG7SuecnV6VaHAwot4TvQLS+eEqyDoN2o
	 g6R5F/a5I8td1aJYrVRrPRhtJMW7D5PWQ/A1G1fn6s9nC9JPXQeEALW1Z6kzR5N3rG
	 HAth2Sr4AiG/rSOhc62rCxMydv+6ed60sMwmeiflNIKyEXsCCPXA2YSn7WkNBOI0W0
	 N0BsDVdh/W9pWBqbzvZweXrFpqwhMaMIDTHyGXMk8mmsL6w2OcUJwslcKrVmDYJt9O
	 2cH36GaBa3zuw==
Date: Wed, 18 Jun 2025 11:18:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	"linux-trace-users@vger.kernel.org" <linux-trace-users@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Subject: Re: [RFC][PATCH] tracing: Deprecate auto-mounting tracefs in debugfs
Message-ID: <20250618-freischaffend-gefunden-139c8c064797@brauner>
References: <20250617133614.24e2ba7f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250617133614.24e2ba7f@gandalf.local.home>

On Tue, Jun 17, 2025 at 01:36:14PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In January 2015, tracefs was created to allow access to the tracing
> infrastructure without needing to compile in debugfs. When tracefs is
> configured, the directory /sys/kernel/tracing will exist and tooling is
> expected to use that path to access the tracing infrastructure.
> 
> To allow backward compatibility, when debugfs is mounted, it would
> automount tracefs in its "tracing" directory so that tooling that had hard
> coded /sys/kernel/debug/tracing would still work.
> 
> It has been over 10 years since the new interface was introduced, and all
> tooling should now be using it. Start the process of deprecating the old
> path so that it doesn't need to be maintained anymore.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Sounds reasonable.

