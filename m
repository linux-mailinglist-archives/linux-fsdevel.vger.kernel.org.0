Return-Path: <linux-fsdevel+bounces-57773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224ABB24FC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59C5723EE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88374287259;
	Wed, 13 Aug 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NowuzJLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DA285053;
	Wed, 13 Aug 2025 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102287; cv=none; b=BT2zSSBRmMuHJk0IYcx55iT99Sanfzg788ljfC+vtTq+OTMyolekrwfMgjCv3N+TzxuBi97AjlBuRrZb7R0qsTjrXR6+x9Shk2h3m1/ByFXgWe913y7XGgCX9vGc+ClAkhLCnJxHyPd7Sy5RERAL+bct9CWoGDePjx9ouxxfMIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102287; c=relaxed/simple;
	bh=K1Qnz6FeiAMe891bHx38SnseQkGtn7jJpOFA1e7ci+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TtNIV5327wJHOdlMm1X42tiRJtmpG9VZcmdBhq5G1HocIebBSMha/Qk75hKuaedodYuOgHTxel+F5pO6OVrVYYVkmKmsl3J3rIWdgxAHG+btFJKt5ysW57qqKk34WVjjCoXwjTn1wkwtrKyEGeKe4Ng8ft57CLpuLHItjLaqaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NowuzJLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AF3C4CEEB;
	Wed, 13 Aug 2025 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755102287;
	bh=K1Qnz6FeiAMe891bHx38SnseQkGtn7jJpOFA1e7ci+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NowuzJLvoDcytU2mnlkUjH9a3VkVMtm7ue/1JeEievbLShowGrZYKS4ljQgIc4Tvt
	 3+vYZnNOWzD9UQ8pSH9fEmYwxPiiGspKJ3H0P32SvVzl8AqitUBhqFYwGCZ45kSKAJ
	 87/gu7vuZjna5FtZYWWUpp9S1G/8o7Ty64t0lObmjPlPr2MXYLPDtH4Sc4eAU6xND8
	 ThhzDQ4hSAh1VB48U+GqBbKfJNoQAGi7b1yhwF4mFVAalvl713Ll6uzzSrl8gdzvsB
	 qxd/OanAUdPmrliRUlwzqp8QiFiC+SAvfzE7ZdQVKX6a28IsBlnq34Yk6UcqsLFVxB
	 8m4KWJEM4NWXw==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
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
Date: Wed, 13 Aug 2025 09:24:45 -0700
Message-Id: <20250813162445.5456-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <af5492d4-f8dc-4270-a4c6-73d76f098942@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 05:18:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Tue, Aug 12, 2025 at 01:13:26PM -0700, SeongJae Park wrote:
> > On Tue, 12 Aug 2025 16:44:09 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
[...]
> > > In order to execute this change, we introduce a new opaque type -
> > > mm_flags_t - which wraps a bitmap.
> >
> > I have no strong opinion here, but I think coding-style.rst[1] has one?  To
> > quote,
> >
> >     Please don't use things like ``vps_t``.
> >     It's a **mistake** to use typedef for structures and pointers.
> 
> You stopped reading the relevant section in [1] :) Keep going and you see:
> 
> 	Lots of people think that typedefs help readability. Not so. They
> 	are useful only for: totally opaque objects (where the typedef is
> 	actively used to hide what the object is).  Example: pte_t
> 	etc. opaque objects that you can only access using the proper
> 	accessor functions.
> 
> So this is what this is.
> 
> The point is that it's opaque, that is you aren't supposed to know about or
> care about what's inside, you use the accessors.
> 
> This means we can extend the size of this thing as we like, and can enforce
> atomicity through the accessors.
> 
> We further highlight the opaqueness through the use of the __private.
> 
> >
> > checkpatch.pl also complains similarly.
> >
> > Again, I have no strong opinion, but I think adding a clarification about why
> > we use typedef despite of the documented recommendation here might be nice?
> 
> I already gave one, I clearly indicate it's opaque.

You're completely right and I agree all the points.  Thank you for kindly
enlightening me :)


Thanks,
SJ

[...]

