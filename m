Return-Path: <linux-fsdevel+bounces-51956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8090DADDB1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E1E1942886
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AC427F016;
	Tue, 17 Jun 2025 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UEvTXiAV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE727EFF3;
	Tue, 17 Jun 2025 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750183240; cv=none; b=c6goqjvQWJiDO8yL/YIsuZzCg4ZK6I8/XCDXxXC2GRLcFzo1z9NFnDKiLYPfdEwgaoG21h+cT2vHsizdEjn38oT6fLEmuLMqwpcjNlBYT9yO8o1qnh3kkbr4kQfY1RqLneDblSYgIwP4bJx7dz5uHuCOGeI1DTEpya+Wen1YUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750183240; c=relaxed/simple;
	bh=pkZOwsH82D8u896EvU2FuOaGI/j15LZGRQ78QCy5HA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv5ppnPJ1k4BWexsTiLHR06n6jMQHbsnaI3lQV3NwnNVanYKx/aDgXM6S1pW1ascdkVwFvjPMxiWwqxxVTynbtIJpFCIywdYAkEZor0uKbreBDfO9qC0PwtssBRyblBFwWaeVQd7TJdXjut7cWr6lGVVZTL2hbkUMUyT7hGhj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UEvTXiAV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PpPXOSCDFfvOCX6jYgFEFRb0EH0bOjsYTT1mkenvM2Q=; b=UEvTXiAVnGCcwP9U0zCSYtNoOg
	C+YuH8rtvDDU3mFEvey5JQWriciZ2BASvA3Da8QpGZD/MxtLmFLxqItoIRVSFiHhurWiFunWaU+Sc
	WOOXg6EntegwyBMTSCvq5AEi9FhUS+Z/HhS7faukd8vq0W/iJHVp4kEL8zrycTmxT3ESWt73wCNh0
	98NMLJ3s50xcjIjBAwTG+crkwcZureCyvzcdqF9XfHg7HgQyb3wcw9KvoXi3fVyIT9n0BTLSjjX9J
	RQKaNDI7POcRFDnZP7ZLbRojcOvPB7JyRoP0lcZTvOW72eZfrhTfMa4Odcal4FGxgc9yTr5Vq4e2a
	n4syALuA==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRabh-00000003sCo-2zkw;
	Tue, 17 Jun 2025 18:00:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C710330BDAD; Tue, 17 Jun 2025 20:00:23 +0200 (CEST)
Date: Tue, 17 Jun 2025 20:00:23 +0200
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
Message-ID: <20250617180023.GC1613376@noisy.programming.kicks-ass.net>
References: <20250617133614.24e2ba7f@gandalf.local.home>
 <20250617174107.GB1613376@noisy.programming.kicks-ass.net>
 <3201A571-6F08-4E26-AC33-39E0D1925D27@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3201A571-6F08-4E26-AC33-39E0D1925D27@goodmis.org>

On Tue, Jun 17, 2025 at 01:54:46PM -0400, Steven Rostedt wrote:
> 
> 
> On June 17, 2025 1:41:07 PM EDT, Peter Zijlstra <peterz@infradead.org> wrote:
> >On Tue, Jun 17, 2025 at 01:36:14PM -0400, Steven Rostedt wrote:
> >> From: Steven Rostedt <rostedt@goodmis.org>
> >> 
> >> In January 2015, tracefs was created to allow access to the tracing
> >> infrastructure without needing to compile in debugfs. When tracefs is
> >> configured, the directory /sys/kernel/tracing will exist and tooling is
> >> expected to use that path to access the tracing infrastructure.
> >> 
> >> To allow backward compatibility, when debugfs is mounted, it would
> >> automount tracefs in its "tracing" directory so that tooling that had hard
> >> coded /sys/kernel/debug/tracing would still work.
> >> 
> >> It has been over 10 years since the new interface was introduced, and all
> >> tooling should now be using it. Start the process of deprecating the old
> >> path so that it doesn't need to be maintained anymore.
> >
> >I've always used /debug/tracing/ (because /debug is the right place to
> >mount debugfs). You're saying this is going away and will break all my
> >scripts?!
> 
> You could mount tracefs in /tracing too:
> 
>   # mount -t tracefs nodev /tracing 
> 
> And update you scripts with a simple sed script.

If I have to edit the mount table, I'll just keep it at /debug/tracing/.
Tracing is very much debug stuff anyway. While I knew there was tracefs,
I never knew there was another mount point.

Just annoying I now have to add two entries to every new machine.. Oh
well.

