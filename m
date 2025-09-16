Return-Path: <linux-fsdevel+bounces-61812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E9CB59FF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8711C053D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A75A28033C;
	Tue, 16 Sep 2025 18:02:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD51D63C2;
	Tue, 16 Sep 2025 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045721; cv=none; b=sLpY+/AeQSgedodHqc8cYeiQrS0qkvfRIjWfGGae/E/Nt/NwT4k1lTyEg+TqB15L/xa+up5zsiP6WVQlQe7v/ppJJlfKEJbRdvOZ0AutsZA24Q/3LvewEH2V8lly6V0sF4ONptt9qWc4kFkFsjFI/T2N46MAS13tNs+dvGJ9X/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045721; c=relaxed/simple;
	bh=W3zRP66UKxIttZreRkOKTmeXdVrAoeAh+kfGmkq9lt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFsT2y084/ScgJHJ5p1tHGaFtwzMHkpdJX3TtJCit6sL2mhgy+KhdlmU/cjrK63liLj7KCcdMxAw0w3mWPi4iYxpRCl0TivLCiNNcxE7HHIx1z0GhBObuNnRWYN0fL391vQB0IDWN0x55pJrGStnHvN5/lBOMo7POS54iReJOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 77450B7BA8;
	Tue, 16 Sep 2025 18:01:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id EC8C420029;
	Tue, 16 Sep 2025 18:01:41 +0000 (UTC)
Date: Tue, 16 Sep 2025 14:02:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org,
 lorenzo.stoakes@oracle.com, david@redhat.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, pfalcato@suse.de, kernel-team@android.com,
 android-mm@google.com, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook
 <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded
 trace event
Message-ID: <20250916140245.5894a2aa@gandalf.local.home>
In-Reply-To: <CAC_TJvc6aqjBRZ05wyGb49AU+-aKpSph=ZSk3fdV2xraXi-_nQ@mail.gmail.com>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915163838.631445-8-kaleshsingh@google.com>
	<20250915194158.472edea5@gandalf.local.home>
	<CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
	<20250916115220.4a90c745@batman.local.home>
	<CAC_TJvdkVPcw+aKEjUOmTjwYfe8BevR51X_JPOo69hWSQ1MGcw@mail.gmail.com>
	<20250916134833.281e7f8b@gandalf.local.home>
	<CAC_TJvc6aqjBRZ05wyGb49AU+-aKpSph=ZSk3fdV2xraXi-_nQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4yy1ho51ztqg59ud61rx83stqc83cezr
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: EC8C420029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX184S1CbixJjC2KL8Es6WaYGgHiZiwcrjEA=
X-HE-Tag: 1758045701-643605
X-HE-Meta: U2FsdGVkX194keMitKg7LUzLINew+H+ggwXI6UErbwL6DJC2Qc2N1u3vgQ6avirBipCv6qql8jJjFsRfYkRIEbGPP674VZJia+m4eEbg7FJ624UkaVK5tzhZordOgOczqBPCfS0AXimy2A/yGYmbbnYJBhgU3nWQucBtOsdUTFbUChUCEWLS21Pfype9kVW+AQ9/CP5Su535QGVZ00t3MwljzxP3T1AA5ITpWCW3CFuH4r/URZFVWzcHBK/T/t5UC1HP5bnZpuY82GhJmo9UOU3kx5i+3jfQ9aBItntQkRzuP2RrvFX+rzjj6lFl5SNdG3z0vPMEkXif/fLH5zExUgEoegrEiISD1MfnclaRhga73QBG4Kqr2cTxcUX6PeICSWQ4Rehj8Ew=

On Tue, 16 Sep 2025 10:57:43 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> > BTW, why the hash of the mm pointer and not the pointer itself? We save
> > pointers in lots of places, and if it is the pointer, you could use an
> > eprobe to attache to the trace event to dereference its fields.  
> 
> In Android we try to avoid exposing raw kernel pointers to userspace
> for security reasons: raising /proc/sys/kernel/kptr_restrict to 2
> immediately after symbols are resolved for necessary telemetry tooling
> during early boot. I believe this is also why rss_stat uses the hash
> and not the raw pointer.

When it comes to tracing, you already lost. If it goes into the ring buffer
it's a raw pointer. BPF doesn't use the output of the trace event, so you
are exposing nothing from that. It uses the proto directly.

Heck, if you enable function tracing, you are exposing every function
address it traces via the raw data output.

-- Steve

