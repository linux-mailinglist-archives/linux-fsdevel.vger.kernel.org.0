Return-Path: <linux-fsdevel+bounces-61469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A96B588D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9353189D996
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F8A14F70;
	Tue, 16 Sep 2025 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iczv0H88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65FBA3D;
	Tue, 16 Sep 2025 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981153; cv=none; b=MYZrfy2rFu2u3U39rAIoEYTtu3em6ObfNOAAGx6NZX6q77mjkeowQDnYGfdkYnogGi5MDc1VY7PIvuko2nAY6SwISqD9gYHRbPVFINmCMZ56eKnFtF+yF8iCMkA+VkRo8AsM7jjN7pIOJEFP+tlwM/sRp/R1vWH/jbdq3aQBQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981153; c=relaxed/simple;
	bh=OrGMt8ZJZs6DqpGv5H4cRS8nHNx4Zw/bJfWF3GfNAOE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J2R68bL5g+bUQc7paVyLj2GeF9ljQfziEb/Ne39DQA4yk6Z4Q40DBQynDZ74k+aWoKRmexc5Xc2EXD7wKxUUzng0I4kXAiomN79ykaWEHEQXvsiucYn2zTJJaV1eAesGTRfW/BaG0bj+XNOplnfEPKrffqtI6XcqpUK2fsfO+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Iczv0H88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B8CC4CEF1;
	Tue, 16 Sep 2025 00:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757981152;
	bh=OrGMt8ZJZs6DqpGv5H4cRS8nHNx4Zw/bJfWF3GfNAOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iczv0H888igvWGUByqVbrWfrf6G3GY2J4VQsxfEn4SpHTrABJNatZiX460FGXwyu9
	 UThpMkOFY+oL8O5ygbc6eeVd02t4JQWS8lvFzQaSNEkWe9gYW7FfidDfrUFqbvKe/R
	 9CSRdsVBjB/BpTMY+Ju4lnmK9fKSoI3p38HtCCeg=
Date: Mon, 15 Sep 2025 17:05:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
 kernel-team@android.com, android-mm@google.com, Alexander Viro
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
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
Message-Id: <20250915170550.f24bfb96514835154e8d1633@linux-foundation.org>
In-Reply-To: <CAC_TJvd=zwhRZcXTvDPfuzdjYV7j_jvZKZ--eKDRTsE+LBmASA@mail.gmail.com>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
	<CAC_TJvd=zwhRZcXTvDPfuzdjYV7j_jvZKZ--eKDRTsE+LBmASA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 16:10:55 -0700 Kalesh Singh <kaleshsingh@google.com> wrote:

> > fwiw, there's nothing in the above which is usable in a [0/N] overview.
> >
> > While useful, the "what changed since the previous version" info isn't
> > a suitable thing to carry in the permanent kernel record - it's
> > short-term treansient stuff, not helpful to someone who is looking at
> > the patchset in 2029.
> >
> > Similarly, the "how it was tested" material is also useful, but it
> > becomes irrelevant as soon as the code hits linux-next and mainline.
> 
> Hi Andrew,
> 
> Thanks for the feedback. Do you mean the cover letter was not needed
> in this case or that it lacked enough context?

The latter.  As I've split up the series, please put together some
words to describe the remaining 6 patches if/when resending.

Thanks.

