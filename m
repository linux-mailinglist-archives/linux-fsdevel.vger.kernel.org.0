Return-Path: <linux-fsdevel+bounces-61858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C645B7C44F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4CD178379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 01:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877141E5705;
	Wed, 17 Sep 2025 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jETLQ7fv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B9B67A;
	Wed, 17 Sep 2025 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071792; cv=none; b=uX+i7lSP0Ftd84FEqq9GIyBGHoa1Hl2IM77ptuWWCLd8Mjx6t5jWfSFG65QPHjVEsrMEkytK3wyUpg1w/70o4J2h4j4ftzTccBEv1p+5YgoW/+I/K1DR1R0yLbsEV1a+ysxnXPGkcCSxKQTDRLxUV21wevzZYdevFzPNGikKHvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071792; c=relaxed/simple;
	bh=wMm3CU8JnvqVu+XBAyCsMnDcqq+lr/aas70UKFC9ags=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TiwzsTYT/hMWGilShy56NWMlJvYSIzGJMiztlDFDdVeDwmsjSclAlcSeuHBBQIXcckFVD951m7QxFHCa1Hz9j1k/B0zmEvMzq73KJgMRwQMpPBKcLw6caVNglJxsQAhECXRurlDRUPs9JA02tSNl88NFMigsyU5/F0FFqZgpqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jETLQ7fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DDFC4CEF9;
	Wed, 17 Sep 2025 01:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758071791;
	bh=wMm3CU8JnvqVu+XBAyCsMnDcqq+lr/aas70UKFC9ags=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jETLQ7fv1aaDH+T4cjF2zi7w8e/yIsJ/BiWWWJpQ/wXayVEQCqM/D3zjcfOQUfwhH
	 p49MzSnmyun7d2WxTOPqMulSgILGL/hz7Tun5oCUrTA4WrU0yrgd+msqH4bHsbTu1Y
	 86M3t/JpsPX2KUKJyQzPhzKNykBLXleqs1XAmRTg=
Date: Tue, 16 Sep 2025 18:16:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kalesh Singh <kaleshsingh@google.com>, minchan@kernel.org,
 lorenzo.stoakes@oracle.com, david@redhat.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, pfalcato@suse.de, kernel-team@android.com,
 android-mm@google.com, stable@vger.kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Kees Cook <kees@kernel.org>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Dave
 Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit
 checks
Message-Id: <20250916181629.f4527e6e90d1e620e8d84abc@linux-foundation.org>
In-Reply-To: <87v7lifpi9.fsf@trenco.lwn.net>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915163838.631445-2-kaleshsingh@google.com>
	<20250915153642.7f46974a536a3af635f49a89@linux-foundation.org>
	<87v7lifpi9.fsf@trenco.lwn.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 08:20:14 -0600 Jonathan Corbet <corbet@lwn.net> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Mon, 15 Sep 2025 09:36:32 -0700 Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >
> > lol.
> >
> > x1:/usr/src/25> grep "Fixes.*1da177e4c3f4" ../gitlog|wc -l
> > 661
> >
> > we really blew it that time!
> 
> A few years back I made a list of the most-fixed commits in the kernel
> history; unsurprisingly that one (I call it the "original sin") came out
> on top:
> 
>   https://lwn.net/Articles/914632/
> 
> Perhaps the time has come to update that analysis.
> 

Hah, thanks, that's a fun article.

It's a shame it's so recent.  I do recall back in maybe 2002 a fresh
young developer popped up with a massive rework of the IDE drivers.  I
promptly took this into my tree because I was having a hate on the IDE
drivers at the time.  omfg, what a disaster - this was the buggiest
bunch of junk conceivable and it went away after a few weeks.

I'm glad to say that the developer (email handle at the time was
"haveblue") has become better since then.

