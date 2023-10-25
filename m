Return-Path: <linux-fsdevel+bounces-1201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CC37D7254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 19:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D37D281DC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9119B30D1C;
	Wed, 25 Oct 2023 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="14FcZImO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CkKs0Vb+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE841C683;
	Wed, 25 Oct 2023 17:33:04 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B0137;
	Wed, 25 Oct 2023 10:33:02 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698255180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMbPag9QwdHG5LCrp7GKbj7qfyS+r03W9FBPD7TqsHo=;
	b=14FcZImOVqXnRGEgxC2fRYaOTc69tai0XEWUoJ22hwViznUFzBoB1yp4EfjRRXklGhk0vY
	VY+qLSqNaldvNjfkG2HuDGgUa7KXoLZb39sqNcOvcVJjbBFdcaPsuHBt6R/0WVaLxrnEIT
	ELIHCrsUNw+RHO4RBly469N52ATYKF31+pr6e5uIEQsPideOY2UXtwttP9wf3ZuvtvO6lZ
	06GbiCdBa1BpBaX+kZXO0P7MaVTTRWS161jpimL+HSNmXys20HCJ8TIl/m4BNKKVL8hYIq
	Cl4MX3efr5UtCjQnahFz+UZr5KT6Xe0BwxFwDpHJ61CHTlzzA7XXub+9heSNyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698255180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMbPag9QwdHG5LCrp7GKbj7qfyS+r03W9FBPD7TqsHo=;
	b=CkKs0Vb+ro20//s4rfHvlMYS2gqcydz362NMET/yMGWJ3AMSbglFuv0sWWmZqc9s5Sjr2E
	3MSg04jBjUShd8DQ==
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 corbet@lwn.net, void@manifault.com, peterz@infradead.org,
 juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 28/39] timekeeping: Fix a circular include dependency
In-Reply-To: <20231024134637.3120277-29-surenb@google.com>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-29-surenb@google.com>
Date: Wed, 25 Oct 2023 19:33:00 +0200
Message-ID: <87h6me620j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 24 2023 at 06:46, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> This avoids a circular header dependency in an upcoming patch by only
> making hrtimer.h depend on percpu-defs.h

What's the actual dependency problem?


