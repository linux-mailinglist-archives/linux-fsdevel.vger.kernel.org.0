Return-Path: <linux-fsdevel+bounces-6458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C0817F6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 02:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22911C23067
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D99F1FDD;
	Tue, 19 Dec 2023 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QRLUDXo8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA85137C
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Dec 2023 20:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702950382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5dSq+xskUzFPW1/3n5Hbgu39SffXVNAv8XTfz69lcCQ=;
	b=QRLUDXo8kJiL1Gog5CeF8oYKcr9jV1OIVFaza6OHEb8UDxa+NyQ7dG1QZp7b2WB14ckqUd
	Y+vw8yTRiTstd53R1q/L+kprd/itBhNn4KDap2f2sfcMc/+YQkVzv1YebOVJI/o5+FISLh
	/T4mHhnyxlPABPRwqqawGvlqFXWyaG0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 19/50] locking/mutex: split out mutex_types.h
Message-ID: <20231219014617.dulwl3mdro6zyblt@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-9-kent.overstreet@linux.dev>
 <7066c278-28e0-45eb-a046-eb684c4a659c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7066c278-28e0-45eb-a046-eb684c4a659c@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 18, 2023 at 11:53:08AM -0500, Waiman Long wrote:
> On 12/15/23 22:26, Kent Overstreet wrote:
> > -#include <linux/rtmutex.h>
> 
> Including rtmutex.h here means that mutex_types.h is no longer a simple
> header for types only. So unless you also break out a rtmutex_types.h, it is
> inconsistent.

good observation, I'll have to leave it for the next round of cleanups
though since the merge window is approaching and I'll have to redo all
the testing.

> Besides, the kernel/sched code does use mutex_lock/unlock calls quite
> frequently. With this patch, mutex.h will not be directly included. I
> suspect that it is indirectly included via other header files. This may be
> an issue with some configurations.

I've now put it through randconfig testing on every arch that debian
includes a compiler for (excluding sh and xtensa, which throw internal
compiler errors) and that one hasn't come up yet.

could still be included indirectly though - I haven't checked for that
one specifically yet.

