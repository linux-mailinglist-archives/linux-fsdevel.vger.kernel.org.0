Return-Path: <linux-fsdevel+bounces-51955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA95FADDAEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C3319416E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27323B627;
	Tue, 17 Jun 2025 17:54:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E221D3F6;
	Tue, 17 Jun 2025 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182898; cv=none; b=toKvBTj2UmbOE/jYfeCTcMMspCLNqrEr6td6hQe7Fwv5ameQW8HZRFAF4q/BDTJyW7eKHNfHLR0oSDWOzTwPksssJgz0Vx7TMH0MLWoF5IWQmv5E9qradeK6OorAxTgnUPCZ5m7+TBOiB8N4mtrVHxkLTfO9avPotKP9OAylNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182898; c=relaxed/simple;
	bh=RVpfQEoWFtqmUgVNWYBf3ejxqgIOT6Laep66Opn3Y+I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oYgCWXvTeBK2jEh8JBjyezgrzGuiKwNFUKhWpCmxCQHOYuGT1qL4mSctNgngWwcm0quKlJjoua/bEvn7nlZ9VJW6OpWnZrVW5IMLNSnOGGCJXsIc/hJET4jmrYBGSvejAAFkGf08oUVServV4GSoCgN2TvOEWX+HFynAoodDdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DE7528095A;
	Tue, 17 Jun 2025 17:54:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id CBFB860010;
	Tue, 17 Jun 2025 17:54:48 +0000 (UTC)
Date: Tue, 17 Jun 2025 13:54:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 "linux-trace-users@vger.kernel.org" <linux-trace-users@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Namhyung Kim <namhyung@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>
Subject: Re: [RFC][PATCH] tracing: Deprecate auto-mounting tracefs in debugfs
User-Agent: K-9 Mail for Android
In-Reply-To: <20250617174107.GB1613376@noisy.programming.kicks-ass.net>
References: <20250617133614.24e2ba7f@gandalf.local.home> <20250617174107.GB1613376@noisy.programming.kicks-ass.net>
Message-ID: <3201A571-6F08-4E26-AC33-39E0D1925D27@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: CBFB860010
X-Stat-Signature: eekb5ry4xftqy54dzrsbryoqxt1gew6r
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+oc7Fb04Xp5KZr7WCMGgafhDeoX6xxhcQ=
X-HE-Tag: 1750182888-218116
X-HE-Meta: U2FsdGVkX19UCVicBY+d8bC3JKFlzafrPgRYAyNQcnQkwD3+Sjtfmsag20KciS3OXVAquTfTcex6rDQk0ExTyuOBr++dQOcB7f45RuAszva0Wov/fvO6CeJk7riZ9OQL+C0Cv4iq/zqWbA8Lb78wVUKXHdUacVGBszokX5/7sL/WgGyhzZLIvgQwVfrh0aweozxfZJNISPFzamkJoTHjB0MlTZ8+C3sr0zb4saHuF6MSLgzMiZaTEw+3gz8debzuj/ZgjdMiqFvXY3UFHxgLjaaqHmgwL2J0GW94lLUTTWtXFsXzwdcEzjQcaz1jP3f+vuKORSFBF0nzZjR+E9Lgv6Zxa+yYV4q9DrH13Vwj2hmZseiCZYsvFc9cAo8FLqrJNCnADYqf+z7TLDuJ340FZhJ+F5XSq9QAnfIDE6H2yOQgmLQrzA3lp7APmD0TMHI+nMGAOHe1XZwqjGWBazHEtg==



On June 17, 2025 1:41:07 PM EDT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>On Tue, Jun 17, 2025 at 01:36:14PM -0400, Steven Rostedt wrote:
>> From: Steven Rostedt <rostedt@goodmis=2Eorg>
>>=20
>> In January 2015, tracefs was created to allow access to the tracing
>> infrastructure without needing to compile in debugfs=2E When tracefs is
>> configured, the directory /sys/kernel/tracing will exist and tooling is
>> expected to use that path to access the tracing infrastructure=2E
>>=20
>> To allow backward compatibility, when debugfs is mounted, it would
>> automount tracefs in its "tracing" directory so that tooling that had h=
ard
>> coded /sys/kernel/debug/tracing would still work=2E
>>=20
>> It has been over 10 years since the new interface was introduced, and a=
ll
>> tooling should now be using it=2E Start the process of deprecating the =
old
>> path so that it doesn't need to be maintained anymore=2E
>
>I've always used /debug/tracing/ (because /debug is the right place to
>mount debugfs)=2E You're saying this is going away and will break all my
>scripts?!

You could mount tracefs in /tracing too:

  # mount -t tracefs nodev /tracing=20

And update you scripts with a simple sed script=2E

-- Steve=20


