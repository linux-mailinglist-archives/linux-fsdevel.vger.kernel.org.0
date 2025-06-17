Return-Path: <linux-fsdevel+bounces-51964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F16ADDBA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739461747F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1232E7176;
	Tue, 17 Jun 2025 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4vyDUn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66FA28504C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186149; cv=none; b=B3q4cywpdWa7Xxd9ydpUdjolbvsjqBgEeOvBaTkEeU9V02BqcsdUfLFxca7oUxpyPAsD6+JFE3E+02DTQ7/4CU3c0TQ18zGs0oq/05sfpfaVzM3DZvO/c7GcVK+pzmyV711bZ3meuCSmNTEjOYcUawbSj3kMH4e7FU79LNP3aPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186149; c=relaxed/simple;
	bh=KwqSD/mvRel9xI3T5LRWWp1qv/dt+bofRF5gsGxGzwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ixm9eYnjS3HACfWCGARhP344qhn9LZIrS/ao6u9LmifO96aRDQFL3xu43/EBdhPXNz2ygnBP9GYFF2WLHo/kNoV+3PTTUrTV48XhYTSYXwjR+XTNVHBiSMhSZVZbjQNjrKRot9vba9Fy/r6euBMPeTt+Se2D6NCDxDsxDDpHKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4vyDUn/; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3de210e6076so19025ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750186147; x=1750790947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8EJ5NTBcmp1K+DlZlLHbsBISbfgOHA/1xl7u6O9rkw=;
        b=Y4vyDUn/WDsPTuUnxBSM9qdYXy5w18OKHDjxgvpcFP0B2veSRcvPZ1aJ5k+6jpWQ34
         ayMssVNN9tLeQNiXEGIx6MRuWQkT2l8HZRjTn1Glgegm3cjNtPtxe58+OG+JXioZWS+F
         qPI1ALFKc/KJxzkC5/JWJpf6l/C82L3/OsGNG5h9/CMqQ92QRKFT/5yCfhjwivSRjEel
         zEFRSxDtJxP8yyJwSvBHgv9Y1k3H1YN7d/pqWiyiGB2aXFfWZctss4oYy6lN48lTs3RS
         8qEaZFxoClgG74O6Ku6kByHu6T+AjRRsTUA22qCu7qFix4jAmtQLgIL4B/b+4NTz96z6
         jYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750186147; x=1750790947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8EJ5NTBcmp1K+DlZlLHbsBISbfgOHA/1xl7u6O9rkw=;
        b=vHjUJooQdRkJOc+KFAdJjVCo9KP/BswwavHBg0QQp7paIXlFSl2fohRhg2CRTJi9tt
         3Eb9Yst/+uWd/PGJD0oPJMWAgpVz2i8DgI2BXMpohavq4vvJVfQleuo4bWaCSBCNQ6Hm
         6NsvaGWU6UMh2SKTw3Msr7i72nsx4HIXOQt0s9JqnTeuuCZZQj0uxNf65GlvMk3Dajdl
         3SvrToQW6SEqbf6HBKN+3M2seujZO67M3OQb39ea+lEETlXaiF+4t/uhTegkY4nixMTi
         bHc7vvAivl6UDma41LI8eBvZJ0m4gjoFaEHg37DO1BIZDoEnY78CFc6xjgGH1Dt0017C
         SZTA==
X-Forwarded-Encrypted: i=1; AJvYcCUBh4zQkWAvANF5mAozuk7qjcJG1v+6SPU3CDOnjE3HNvsQdae5l6tkL34s0Iyk35Qz5fjYHwh6xrKKVtWZ@vger.kernel.org
X-Gm-Message-State: AOJu0YybpF+gQbsyT1kQTk7+R+qDa+CdGieo27pHhdKPyhUfx0T9euTg
	+6o2+csW6fGP0onZR9HLRJvbXG4z98WlX89pxH+J27roe/GBM9IIpAas1ltJNvqZjTHMgePO1t1
	MAsMaVZT4LvV8U89OqvAc7x+rfvHoAM5XiAuCLd0B
X-Gm-Gg: ASbGncu7oiZtBIScllXn8iCVc9m81sLj/eTCVFKlwJ1BC9IXdDj566WG3N6eBQpcX4Q
	Rq6f2DXUQoZUigNfHVMJbl7/2+JW0FkaR7RLDGJGps0z2cyw/flmQdoufxAxDBWUSx6cwHWYdFe
	3bEuC8XXZ77/BbpB4e4KutYSQDqFCfNUZKC3AzyWxBL1LN6ecH65zJsOZuxaDrK+nDp7JHFGLs
X-Google-Smtp-Source: AGHT+IFzrUwC9gszj0tD9vuBEBQF9n3D4Q3WJTaRCUVhXGHHOddGa1pIqtmbyT4XwSHM/7FECm5kvyzNP+0l4d7kUpg=
X-Received: by 2002:a92:ca47:0:b0:3dc:8596:b15 with SMTP id
 e9e14a558f8ab-3de08e309cemr12018435ab.20.1750186146706; Tue, 17 Jun 2025
 11:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617133614.24e2ba7f@gandalf.local.home> <20250617174107.GB1613376@noisy.programming.kicks-ass.net>
 <3201A571-6F08-4E26-AC33-39E0D1925D27@goodmis.org> <20250617180023.GC1613376@noisy.programming.kicks-ass.net>
In-Reply-To: <20250617180023.GC1613376@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Jun 2025 11:48:53 -0700
X-Gm-Features: AX0GCFv1wtGvcgVGSD1sgzvmQHC0HhNLOA8sTZ3tUy13Qbfl9q8mNJDIZ58ROyM
Message-ID: <CAP-5=fVH1HfdXT7HLZhav9k6m7t7Ji-=y2Gw13h1qMtgW8cRQA@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing: Deprecate auto-mounting tracefs in debugfs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	"linux-trace-users@vger.kernel.org" <linux-trace-users@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 11:00=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Jun 17, 2025 at 01:54:46PM -0400, Steven Rostedt wrote:
> >
> >
> > On June 17, 2025 1:41:07 PM EDT, Peter Zijlstra <peterz@infradead.org> =
wrote:
> > >On Tue, Jun 17, 2025 at 01:36:14PM -0400, Steven Rostedt wrote:
> > >> From: Steven Rostedt <rostedt@goodmis.org>
> > >>
> > >> In January 2015, tracefs was created to allow access to the tracing
> > >> infrastructure without needing to compile in debugfs. When tracefs i=
s
> > >> configured, the directory /sys/kernel/tracing will exist and tooling=
 is
> > >> expected to use that path to access the tracing infrastructure.
> > >>
> > >> To allow backward compatibility, when debugfs is mounted, it would
> > >> automount tracefs in its "tracing" directory so that tooling that ha=
d hard
> > >> coded /sys/kernel/debug/tracing would still work.
> > >>
> > >> It has been over 10 years since the new interface was introduced, an=
d all
> > >> tooling should now be using it. Start the process of deprecating the=
 old
> > >> path so that it doesn't need to be maintained anymore.
> > >
> > >I've always used /debug/tracing/ (because /debug is the right place to
> > >mount debugfs). You're saying this is going away and will break all my
> > >scripts?!
> >
> > You could mount tracefs in /tracing too:
> >
> >   # mount -t tracefs nodev /tracing
> >
> > And update you scripts with a simple sed script.
>
> If I have to edit the mount table, I'll just keep it at /debug/tracing/.
> Tracing is very much debug stuff anyway. While I knew there was tracefs,
> I never knew there was another mount point.
>
> Just annoying I now have to add two entries to every new machine.. Oh
> well.

It seems cleaning this up is a good thing wrt permission issues. On my
local debian derived machine:
```
$ ls  /sys/kernel/debug/tracing/events
ls: cannot access '/sys/kernel/debug/tracing/events': Permission denied
$ ls  /sys/kernel/tracing/events
alarmtimer        fib             irq            nmi             sunrpc
...
```
I see a number of references to debug/tracing in places like perf testing:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/common/init.sh?h=3Dperf-tools-next#n122
are you planning patches for these?

Thanks,
Ian

