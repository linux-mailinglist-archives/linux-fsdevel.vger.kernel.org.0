Return-Path: <linux-fsdevel+bounces-6467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFAC81803D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 04:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A201F24C19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 03:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853495689;
	Tue, 19 Dec 2023 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r4c8IvKO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC955235
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Dec 2023 22:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702957028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wkOW8CfWZ3CabOov8YAv399V5dwHVdkA0UCTpwkBZt0=;
	b=r4c8IvKOjrNbOWXKzy9Zr6SkRm44hEVmV4UlDwniRH/MtgjmLGfP/AD22iIFCGVP8IMadI
	GfbaDSPQGrFgn8BbfB8MI1FM8X0PtykHqXiamGvBmn4MPxknqzn4Z02Oh9QVATHTOLaPqB
	JG0WOaSZ4Cjn0+e1vIp/ZnHfBPWedFk=
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
Message-ID: <20231219033700.rsc7utoz3vkayyno@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-9-kent.overstreet@linux.dev>
 <7066c278-28e0-45eb-a046-eb684c4a659c@redhat.com>
 <20231219014617.dulwl3mdro6zyblt@moria.home.lan>
 <647f6ed8-c6d8-421e-b5a7-faa3c19b9bd6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647f6ed8-c6d8-421e-b5a7-faa3c19b9bd6@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 18, 2023 at 10:04:39PM -0500, Waiman Long wrote:
> 
> On 12/18/23 20:46, Kent Overstreet wrote:
> > On Mon, Dec 18, 2023 at 11:53:08AM -0500, Waiman Long wrote:
> > > On 12/15/23 22:26, Kent Overstreet wrote:
> > > > -#include <linux/rtmutex.h>
> > > Including rtmutex.h here means that mutex_types.h is no longer a simple
> > > header for types only. So unless you also break out a rtmutex_types.h, it is
> > > inconsistent.
> > good observation, I'll have to leave it for the next round of cleanups
> > though since the merge window is approaching and I'll have to redo all
> > the testing.
> > 
> > > Besides, the kernel/sched code does use mutex_lock/unlock calls quite
> > > frequently. With this patch, mutex.h will not be directly included. I
> > > suspect that it is indirectly included via other header files. This may be
> > > an issue with some configurations.
> > I've now put it through randconfig testing on every arch that debian
> > includes a compiler for (excluding sh and xtensa, which throw internal
> > compiler errors) and that one hasn't come up yet.
> > 
> > could still be included indirectly though - I haven't checked for that
> > one specifically yet.
> 
> If you are replacing mutex.h in include/linux/sched.h by mutex_types.h, I
> would suggest you add mutex.h to kernel/sched/sched.h to ensure this header
> file is included by the scheduler code.

It already does, via mutex_api.h...

