Return-Path: <linux-fsdevel+bounces-58010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F51B280F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500DDAE84EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93CB303CB7;
	Fri, 15 Aug 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay1VIO4M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4F302CCC;
	Fri, 15 Aug 2025 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265975; cv=none; b=UBK5P2qdFbUTHty8421H2kFgPzZC5m99+hsmFd2mwNxNt+5evYV5qH8Bf/nhW31mthPdcbBNeHpNtfIlNuHoWjf9eB16PY+z8Qr1304+tC0JHoL31/uHvS9RvbuqgIkvHikE/uwEC6kG/9o5ISXhlr2L41TXbkNlMpjnqekuZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265975; c=relaxed/simple;
	bh=YyAwX9d0yrQxt1AtdEKMS1xfPyYGo9E0HQVrmo6HFio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZap3y4w+c8lM7HBMn7fjznP1B8hbg1sZuzNO2/JMK0xf/DCbPUqv6Kp85fQExXHCPi6/Dtwoq1Xnwp1gxkPgA0dY72z5nPrke2egGs6NuFfmXr5bccBlGJ6OjnQpATVR5Sr94B2GiGwdS3/IGBJ+o75uG1HUgAY98fzoRp7Pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay1VIO4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F1DC4CEEB;
	Fri, 15 Aug 2025 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755265974;
	bh=YyAwX9d0yrQxt1AtdEKMS1xfPyYGo9E0HQVrmo6HFio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay1VIO4MZKIssq2DXmkvb9Y5xzxbYbHSJCMx9Q+b7drYxS0RvJmoAhIX4KjmakUQD
	 QzyQueMvVtMnt4CD8QUWt1ncIY7GzX+bMM6KNhI3V+tcPnmJvtFwLtp46R9R3gxiZF
	 3xIe+KY2D47BPbZ50ZN0iAnaesGtehgttZhCq/iPJutrQcQvt9m83DGGPzu/OZTCrR
	 DZlc3Alk6BOGyuxr0/JijZf3WjBiZfjGF0RPKBZUjw+TxNH0tUFogTt9YLewsZJ8ll
	 kEZOkiaQqQTz6JEEKBs+xEe0l4CwHvOCfp+vLj4AXKkBdI/lKEVhCBfwoOR44gZC/E
	 dRwzDtGpoOXqw==
Date: Fri, 15 Aug 2025 15:52:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 06/10] mm: update coredump logic to correctly use bitmap
 mm flags
Message-ID: <20250815-neuzugang-gegessen-ff4c08a08ec0@brauner>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <2a5075f7e3c5b367d988178c79a3063d12ee53a9.1755012943.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a5075f7e3c5b367d988178c79a3063d12ee53a9.1755012943.git.lorenzo.stoakes@oracle.com>

On Tue, Aug 12, 2025 at 04:44:15PM +0100, Lorenzo Stoakes wrote:
> The coredump logic is slightly different from other users in that it both
> stores mm flags and additionally sets and gets using masks.
> 
> Since the MMF_DUMPABLE_* flags must remain as they are for uABI reasons,
> and of course these are within the first 32-bits of the flags, it is
> reasonable to provide access to these in the same fashion so this logic can
> all still keep working as it has been.
> 
> Therefore, introduce coredump-specific helpers __mm_flags_get_dumpable()
> and __mm_flags_set_mask_dumpable() for this purpose, and update all core

Why the double underscore here? Just looks a bit ugly so if we can avoid
it I would but if not:

Reviewed-by: Christian Brauner <brauner@kernel.org>

