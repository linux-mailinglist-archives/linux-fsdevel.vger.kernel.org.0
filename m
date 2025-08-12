Return-Path: <linux-fsdevel+bounces-57574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFB5B239D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CED3189370B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DADB1DFCB;
	Tue, 12 Aug 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZk5s4qd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E152F0673;
	Tue, 12 Aug 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029609; cv=none; b=f+t5OakJvHg2tdZdYK1Cb5Q33bj15u3NXbgdA2soajct3WCtpMlDYwMxX8Mz31g3gEYEMXpla4dPU14/wPPGHxIp7Bq+Da7SN6yalTKc4SSFG3DtfmYw3wnQqximghMPGlaQft2lPFBR3zT/XpboyPwLhw1+G98b851rs15WciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029609; c=relaxed/simple;
	bh=67thnts7t0DLgkZq/Ii6wBw0jrSFJtM5mUMWCYrbVS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpmu5EpKg06/gjEnOBvYRUSECSS0AJpSo/Jg3E7SPM8lTzATPALntaAnVPGdHWcgOzWNPc20gGgrlIszCa4t6mbqeg6AKSECBHM8/1zTkWeQfXOyivUjt+GsgkdQAZFYi9G019HsjrBqFBLJOhvpehSAn9VhdAx9tf/AMsODE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZk5s4qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD26C4CEF0;
	Tue, 12 Aug 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755029609;
	bh=67thnts7t0DLgkZq/Ii6wBw0jrSFJtM5mUMWCYrbVS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZk5s4qdbM6pcT8YroWmQOKRLwIIFGieYYi0v9aoNi2ICJDuc3wg8bhKf+s6pvQNd
	 c+i3MR/y/FAagcjMfROfPVLTOsoG3YlP79F/PpCEZGyFDsyuBtQtypuh96jit6toX0
	 v+aQUOZ71f1sVS4LLJKLKq+8hdeGPjE2mpVgs/FuY2KZSzhX/6T7dzeh6CvpLmMDoF
	 weuTiAVwv1mVOxNZA1KKoDpEA1hk0wwazemaioBJiDYkvkx74pTiTr9+YupNxQLK8F
	 rz5RHVzbW4bBYKxh5nyMODvXXmIYvJS3DB65gwqyMSJvM3wUZw/6uqpQTB/gIvOiXG
	 Gs3FPiwr7oo7A==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 00/10] mm: make mm->flags a bitmap and 64-bit on all arches
Date: Tue, 12 Aug 2025 13:13:26 -0700
Message-Id: <20250812201326.60843-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 16:44:09 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> We are currently in the bizarre situation where we are constrained on the
> number of flags we can set in an mm_struct based on whether this is a
> 32-bit or 64-bit kernel.
> 
> This is because mm->flags is an unsigned long field, which is 32-bits on a
> 32-bit system and 64-bits on a 64-bit system.
> 
> In order to keep things functional across both architectures, we do not
> permit mm flag bits to be set above flag 31 (i.e. the 32nd bit).
> 
> This is a silly situation, especially given how profligate we are in
> storing metadata in mm_struct, so let's convert mm->flags into a bitmap and
> allow ourselves as many bits as we like.

I like this conversion.

[...]
> 
> In order to execute this change, we introduce a new opaque type -
> mm_flags_t - which wraps a bitmap.

I have no strong opinion here, but I think coding-style.rst[1] has one?  To
quote,

    Please don't use things like ``vps_t``.
    It's a **mistake** to use typedef for structures and pointers. 

checkpatch.pl also complains similarly.

Again, I have no strong opinion, but I think adding a clarification about why
we use typedef despite of the documented recommendation here might be nice?

[...]
> For mm->flags initialisation on fork, we adjust the logic to ensure all
> bits are cleared correctly, and then adjust the existing intialisation

Nit.  s/intialisation/initialisation/ ?

[...]

[1] https://docs.kernel.org/process/coding-style.html#typedefs


Thanks,
SJ

