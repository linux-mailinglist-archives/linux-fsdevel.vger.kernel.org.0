Return-Path: <linux-fsdevel+bounces-52025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A87CADE6ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E39D189E022
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE56C2857D2;
	Wed, 18 Jun 2025 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YWX9IMvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955D1F4191;
	Wed, 18 Jun 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238860; cv=none; b=Zchs6uHnwr53ZloLzrPCrRms7GbHzZfsvZvBtjDhoFKxCJquFrFl035QjdNjuIaO5eDTAuoRBNOBC90A0cvh35d7kmd2sso0vTkeV2pXsElGsZFHRDYzp8yDQUrrkd8uKUdIkGYfPpqo5aYbfRC6lIrCxCm41p0R7R61lnDUNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238860; c=relaxed/simple;
	bh=9hozI163u2f82HHc3jXhzCXVCkRVx1ctJhVQOE/MT/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePW9fYv0FQTYJ4ijL4xgJbVZDlGCGlcM+uHwSkN/DeP/azuVo+QTq4cX9TNXTGz+zGQy/3dQL5HJmXOSmBvJWqcogbAbW50OuNCv6jRWTc39ZPGwjRFfZ8tW9XYJyjQSOMqN0Ydxay4ziGQ55xhwHVWpaGW4dV/7bQ6lm6liDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YWX9IMvN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=14CLd2utreHeC5HTSpw3bBPTjKNLFfN1oL1hjjz73BE=; b=YWX9IMvNaqQ0XlpYJ5dIVWeioL
	/UxiraohaeqnUgyhiVbK9UlvYPX1M1l+1A0wBapD4jGThPBBCTJ1LAVCVvqFxhUHksi4/CTS+6i1U
	DAaf3hgDzbkmDAOI20bhWBnGxhghqd6EdIdim6mSBenDU5kMwQjIKkkLT6A3UgV4N73r2MlI4JHTB
	i5VX0F0HTLhILBySvA9YoUnxpcs2/d+Plfno0AnbHsiRzzTd/wVpgGtvTptiq/pstVYY1eUINv3lV
	i9G4wdOptpFscsn09QUqZQFvhiXZuYabXRCNdi3Z+UYPauxH/C8RDKpNtSGO0QgEdoR1I6IrKMjiH
	BOC1FpBA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRp4q-00000002YmE-2dlP;
	Wed, 18 Jun 2025 09:27:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 391C3307D9B; Wed, 18 Jun 2025 11:27:28 +0200 (CEST)
Date: Wed, 18 Jun 2025 11:27:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	"linux-trace-users@vger.kernel.org" <linux-trace-users@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20250618092728.GG1613376@noisy.programming.kicks-ass.net>
References: <20250617133614.24e2ba7f@gandalf.local.home>
 <20250617174107.GB1613376@noisy.programming.kicks-ass.net>
 <3201A571-6F08-4E26-AC33-39E0D1925D27@goodmis.org>
 <20250617180023.GC1613376@noisy.programming.kicks-ass.net>
 <20250618072102.1fnuVt8d@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618072102.1fnuVt8d@linutronix.de>

On Wed, Jun 18, 2025 at 09:21:02AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-17 20:00:23 [+0200], Peter Zijlstra wrote:
> > If I have to edit the mount table, I'll just keep it at /debug/tracing/.
> > Tracing is very much debug stuff anyway. While I knew there was tracefs,
> > I never knew there was another mount point.
> > 
> > Just annoying I now have to add two entries to every new machine.. Oh
> > well.
> 
> I don't know what you run but since Debian 11/ Bullseye (v5.10) this happens
> more or less on its own. systemd has the proper mount units:
> | # mount | grep trace
> | tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
> | # ls -lh /sys/kernel/debug/tracing/ > /dev/null
> | # mount | grep trace
> | tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
> | tracefs on /sys/kernel/debug/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
> 
> This of course doesn't work if you manually mount it to /debug. While a
> symlink would work, you still have to touch the boxes.

Mostly debian/testing. I prefer a mount from /etc/fstab, I tried a
symlink once but that is weird with tab completion for some reason.

