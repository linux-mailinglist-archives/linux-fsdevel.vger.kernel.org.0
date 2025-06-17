Return-Path: <linux-fsdevel+bounces-51970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95CAADDC47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 21:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5840119409C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D422EAB83;
	Tue, 17 Jun 2025 19:29:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA223B619;
	Tue, 17 Jun 2025 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188551; cv=none; b=nWafyWoTSeIxta6vLZ1KNo0LT1ctigUO6zI2oQGLB+Fb9Ff6wacZG/f1Apvfxg4kArakBLRdXzHNYnC2XnHrcdCNPouiGHcR5rpB2rXCCo21r/qIot3NZDCb1rFordHGnIdZDAYl4B2x/M30MceDZa1Mf83vpp9XKWzYZrHyQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188551; c=relaxed/simple;
	bh=VsJd6ttGqQBN9ks01AazNLFJJg+8RLiWgRSo8ETRZ+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ob99+OENUtBF7r6pM2Tu1TsKBMiNUNdAVwXJEAZvAoT3xEmvbyDHjGiRXuEb0Zpr61GUGmA7/n+oE1sNjN9nfXLa+d0yQmZfQaJUDu829W5t8nOdGlpPHRVac092xcfwJGXlM6LuTn3Qfvksi5oKPnV9fnwFAR6G8PoFno3T8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 486231D703F;
	Tue, 17 Jun 2025 19:29:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id C4D4680009;
	Tue, 17 Jun 2025 19:29:00 +0000 (UTC)
Date: Tue, 17 Jun 2025 15:29:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, "linux-trace-users@vger.kernel.org"
 <linux-trace-users@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Namhyung Kim <namhyung@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro
 <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Arnaldo Carvalho de Melo <acme@kernel.org>, Frederic
 Weisbecker <fweisbec@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [RFC][PATCH] tracing: Deprecate auto-mounting tracefs in
 debugfs
Message-ID: <20250617152906.2d7ddb9f@gandalf.local.home>
In-Reply-To: <20250617133614.24e2ba7f@gandalf.local.home>
References: <20250617133614.24e2ba7f@gandalf.local.home>
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
X-Rspamd-Queue-Id: C4D4680009
X-Stat-Signature: gk36ycgwzjowosfq1zwebfrsrymmoweq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/St4ra8YZaC4Iaqkr8XbkNC0YnPvl2HGA=
X-HE-Tag: 1750188540-576187
X-HE-Meta: U2FsdGVkX1+oC862ZBHjgTGSv07AHA0bEYpWkkCsfjwbQziAB8BonoefGszagsZgbN60zd6cAGeNpnndw/cJmgMKIjNM4uKV2oXZxC+pr0p08j0vczLpKHps5zoXkqz3iZIWKzDVRnb/F6RjrtDaOOpgaYeifM4H8X14udsNskE9AUJ7tk+SvQFImafG/m9sA3eq1B9seOW/+dHcAQdqWyI2ZD5okP+pDLsFJFM3B2IYfVhhmJRmT9/wOyKsQgsTkloksRO/UArhej+Yo9q6pnKR5brC3KEqdWt00n2RjvO3npY4uaGZ0pbmav7tRkq84Ku/qKK/VESgSeCEmOefZnCSIdMKhPz2nwrZ91azQIv/ZgMgn6ixBJEQBudL3aQ/

On Tue, 17 Jun 2025 13:36:14 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -10311,6 +10313,8 @@ int tracing_init_dentry(void)
>  	if (WARN_ON(!tracefs_initialized()))
>  		return -ENODEV;
>  
> +#ifdef CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
> +	pr_warning("NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2027\n");

I tested this with the config off but not on.

The above errors with pr_warning() undefined, "do you mean pr_warn?" :-p

-- Steve

>  	/*
>  	 * As there may still be users that expect the tracing
>  	 * files to exist in debugfs/tracing, we must automount
> @@ -10319,6 +10323,7 @@ int tracing_init_dentry(void)
>  	 */
>  	tr->dir = debugfs_create_automount("tracing", NULL,
>  					   trace_automount, NULL);
> +#endif
>  
>  	return 0;
>  }
> -- 

