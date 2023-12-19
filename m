Return-Path: <linux-fsdevel+bounces-6460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36586817F8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 03:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6ADB23C15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 02:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E934402;
	Tue, 19 Dec 2023 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aX8pVtcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B71FDD
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Dec 2023 21:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702951569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R4ZNMb7/jqAplkG+DzZrazJbBaTJxRG9mCYNQGQEEo8=;
	b=aX8pVtcrce0Fe5hKWFw6wj2302wK8JYE2zDEyCVPWYqNH1aiFpO1CGRfW0WoqJdUQwQFS+
	m/+JeAeq2fIlhH31dT/CG7ynpRUyPdbJ8jEgmMeijFGh01ycIWgOFW1jn3YlBXRgVUVNe6
	h6njiVE+gTySe1IZ2OK4ex200Q2TvMI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 03/50] x86/lib/cache-smp.c: fix missing include
Message-ID: <20231219020605.edmlnz2hgjb4h4im@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216024834.3510073-4-kent.overstreet@linux.dev>
 <76af02dd-1f16-41ad-86c7-3202146d0085@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76af02dd-1f16-41ad-86c7-3202146d0085@intel.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 18, 2023 at 04:18:29PM +0530, Sohil Mehta wrote:
> > diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
> > index 7c48ff4ae8d1..7af743bd3b13 100644
> > --- a/arch/x86/lib/cache-smp.c
> > +++ b/arch/x86/lib/cache-smp.c
> > @@ -1,4 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#include <asm/paravirt.h>
> >  #include <linux/smp.h>
> >  #include <linux/export.h>
> >  
> 
> I believe the norm is to have the linux/ includes first, followed by the
> the asm/ ones. Shouldn't this case be the same?

I haven't seen that? I generally do the reverse, simpler includes first,
not that I have any reason for that...

