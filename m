Return-Path: <linux-fsdevel+bounces-41981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04ADA39955
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 11:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A487B1742EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD4234973;
	Tue, 18 Feb 2025 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W4Y/EKVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B61A83E6;
	Tue, 18 Feb 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874928; cv=none; b=DITk07AbNjqeW2m3KdS7Uq0D5T2/6NXjAAlvl7kF+oB86gEN38HhyjaupEvfiNXqYGe84voTYzuPBH0AzMZjSfJEAi5al3QIkvGvwA6TtFjthlFDJk5eL37BIkNwk4Cq4JAcFUIYlKfoUCOJhvUfHGuwjnfAuT6pgEPfv536doo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874928; c=relaxed/simple;
	bh=79AO6bTHkKJw32dqRF2AF+8XNyX9+vCi3Y0PvNk8y84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmE99f2X3kqt+DwQ7BwVPeyYWoxRucPT31tv2+u6meqgymYXxDhdfLqM2RPDBVKCzXp9RD6VMA/Dyhcc1S3ooshuBOJ+2pxOF7aXyZOxbljs7/D3gQzwRwCQsfNMR72ZpGt1lpaifSx1htuQbeaU3aVAHgSlJTDrP9wypw3tAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W4Y/EKVP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q4C/73vH91GCh7UHpZKzP24a0BJc42bSJY2IG/ewQfU=; b=W4Y/EKVPAAtPrMxbuTzp0xSsld
	bxgXL8V+H54wLt1Tybtjaz5pMBhebgjBl1td2Wkzu4RVhDEja9QxKDHHdLwPeibT11EH+JRMlu1VJ
	hbjU1v7zAl0+SRTglWnX5DX9C85FRyM+Kfrs5aVQY7L5uSiDbZtoGBiIVwpAauElZiIZAB5v4oYeP
	/dvRiq5iL7OV0jAVUAzTL+MBAZTP2NBJSG/JQuLCVyWEsSZiWlPtpM6avqld/oS7uAaIBxfUAJzvK
	4HJ9jcrlxnCD8WDNqUIbg4XW0QDY43U1A2nHbQyp9C0cRpjvZE0HNb6O2pNdEhvYKScVMty3Fq4ub
	kMocr2hQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkKwW-00000001yxF-0ipX;
	Tue, 18 Feb 2025 10:35:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3740030066A; Tue, 18 Feb 2025 11:35:07 +0100 (CET)
Date: Tue, 18 Feb 2025 11:35:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 5/8] events: Move perf_event sysctls into kernel/events
Message-ID: <20250218103507.GC40464@noisy.programming.kicks-ass.net>
References: <20250218-jag-mv_ctltables-v1-0-cd3698ab8d29@kernel.org>
 <20250218-jag-mv_ctltables-v1-5-cd3698ab8d29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-jag-mv_ctltables-v1-5-cd3698ab8d29@kernel.org>

On Tue, Feb 18, 2025 at 10:56:21AM +0100, Joel Granados wrote:
> Move ctl tables to two files:
> * perf_event_{paranoid,mlock_kb,max_sample_rate} and
>   perf_cpu_time_max_percent into kernel/events/core.c
> * perf_event_max_{stack,context_per_stack} into
>   kernel/events/callchain.c
> 
> Make static variables and functions that are fully contained in core.c
> and callchain.cand remove them from include/linux/perf_event.h.
> Additionally six_hundred_forty_kb is moved to callchain.c.
> 
> Two new sysctl tables are added ({callchain,events_core}_sysctl_table)
> with their respective sysctl registration functions.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kerenel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

