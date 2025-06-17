Return-Path: <linux-fsdevel+bounces-51953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D376ADDACF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81693188729D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903B2ED143;
	Tue, 17 Jun 2025 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ssf4hRqc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE422ECD2F;
	Tue, 17 Jun 2025 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182078; cv=none; b=n1AjGDOF+HgSD+fYlgTZ4vDyycT26JEYLXTOwWSt6d78Es94bVFR7PaTuisrQ6UZ0bKAERvwKUleHa9bvX22oK2Pqm8I3tkwNmiFeUxAq4Ph1eqfPno+RWb9qn9mdYcKfQ0kovgjHUYQx/d8kzZYNFPjalWg9XEIhYE6KSTDmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182078; c=relaxed/simple;
	bh=kEsOiW97Bcf2UFTEnRGArnnuf8pV7ZZSm5QvPKYynxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6lM0LOxX/LSLkR+VHhgo7GZ3EsOjZc3GNdZ38S6mRYe31iiqBEJcirSYDI5YbnebYjC7PmhYQLehibRBY1Q2ypHtBJ9NEQhr5lFcAiga04ByU3JTtTWM7ImdkOaH7qJ0Doo+cZvh8BFoKjkAu60Bvkmz54pebmPmCJD+i63mCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ssf4hRqc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FwLjmwxkqnQKLWrMNKO4jM1CMEAni4isTNQFnM7Aajc=; b=ssf4hRqczVYaT1rWFwdz1oT2kD
	j1Ye7rkHGWFqeD7QDRoCI8DVgOPtXmapqMa4nCQOL+lw0qWT/auluc2swjCAbtaNMSeeuSHDIbWaw
	T5zk1um5eMdmyUB8xfI+8o8TPXGKdAzZu7jbbrqJH4jOdUd5c7eN3HVJ176eQgdKvASvQr3h7VIYN
	4YpbLyNgc0qN7lyDPPjhjffnGC5Fg1HWGvJpyof3IAq+ArAX2uwSINHCq7yeJ47MXUCE28Qj+Yzdw
	qLv3etanu+1cEbuX9HmPfYMCzuUWyP2aZSXwWDvW0BEyNII66xutwBCmprxpc3I10YZDYnvrzNqUH
	y0qJTUiw==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRaJ1-0000000HS4R-3Kvt;
	Tue, 17 Jun 2025 17:41:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5AE2E30BDAD; Tue, 17 Jun 2025 19:41:07 +0200 (CEST)
Date: Tue, 17 Jun 2025 19:41:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	"linux-trace-users@vger.kernel.org" <linux-trace-users@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Subject: Re: [RFC][PATCH] tracing: Deprecate auto-mounting tracefs in debugfs
Message-ID: <20250617174107.GB1613376@noisy.programming.kicks-ass.net>
References: <20250617133614.24e2ba7f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I've always used /debug/tracing/ (because /debug is the right place to
mount debugfs). You're saying this is going away and will break all my
scripts?!

