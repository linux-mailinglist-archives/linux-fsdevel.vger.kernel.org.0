Return-Path: <linux-fsdevel+bounces-62052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D8B82507
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E40624C94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D16329510;
	Wed, 17 Sep 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oT0iDBy6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FB32B490;
	Wed, 17 Sep 2025 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758152441; cv=none; b=ft3mNkiYV0CFOquif9QdmlNTSu8mXzXCvs6m9KJ13C+CD0g/y6p3YY7/DiesH8n8ifGMAQwWi2UaLq8YMnbQqsan8zDKgXi9GMuwZ4H7cMw5AyxcAZsY8FotMU2qMqbf/k7MRvgAtZ8bfJ5WHC88eTqFam5Kx1k3R2OCFBckZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758152441; c=relaxed/simple;
	bh=Qc2UYbWx7EeejKtW1EO2f6MFaxFiWH2vxkYJ9Q39XB0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hChhV8gDUQEG3qgIPZwz2SdZU6N0PhgbYHbZMJEB1lwJnQC+2uXqee7MEiMJoVlDxhRL+7sXpjxqv5xn66ujGl0TB2EHy4RbSDAyAySLhJeYc/S4zQz7BA+5KhWtfQvjDP2TH2ZORNSlCu9QDZtXhM1MTJ29d0PIuBH1wUh2aGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oT0iDBy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10344C4CEE7;
	Wed, 17 Sep 2025 23:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758152440;
	bh=Qc2UYbWx7EeejKtW1EO2f6MFaxFiWH2vxkYJ9Q39XB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oT0iDBy6r5P/R1iNfHqc4gbQ24AicRfxW687can2dx00oXBYiW32GIfMyrCUjS4sY
	 AhPIs0yj8xztgdayC01mhko3n5q1C/gqdo+1hq2uWauxo0aMOYkPi/725vvn3Y7koE
	 ZjPTSlKSinGcrnTHT9eQkwDMaaHzzw66RsnTWviw=
Date: Wed, 17 Sep 2025 16:40:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Kees Cook <kees@kernel.org>, David Hildenbrand
 <david@redhat.com>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou
 <chengming.zhou@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, David Rientjes <rientjes@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, Mateusz Guzik
 <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
Message-Id: <20250917164037.21c669dfcbd7b0b49067a49a@linux-foundation.org>
In-Reply-To: <3b7f0faf-4dbc-4d67-8a71-752fbcdf0906@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
	<1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
	<3b7f0faf-4dbc-4d67-8a71-752fbcdf0906@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 06:16:37 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Hi Andrew,
> 
> Please apply the below fixpatch to account for an accidentally inverted check.
> 
> Thanks, Lorenzo

The fixee is now in mm-stable so I turned this into a standalone thing.

(hate having to do it this way!  A place where git requirements simply
don't match the workflow)


From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: mm/oom_kill.c: fix inverted check
Date: Wed, 17 Sep 2025 06:16:37 +0100

Fix an incorrect logic conversion in process_mrelease().

Link: https://lkml.kernel.org/r/3b7f0faf-4dbc-4d67-8a71-752fbcdf0906@lucifer.local
Fixes: 12e423ba4eae ("mm: convert core mm to mm_flags_*() accessors")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Chris Mason <clm@meta.com>
  Closes: https://lkml.kernel.org/r/c2e28e27-d84b-4671-8784-de5fe0d14f41@lucifer.local
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/oom_kill.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/oom_kill.c~mm-oom_killc-fix-inverted-check
+++ a/mm/oom_kill.c
@@ -1257,7 +1257,7 @@ SYSCALL_DEFINE2(process_mrelease, int, p
 	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
 	 * possible change in exit_mmap is seen
 	 */
-	if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
+	if (!mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
 		ret = -EAGAIN;
 	mmap_read_unlock(mm);
 
_



