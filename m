Return-Path: <linux-fsdevel+bounces-6324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B797F815C18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 23:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1479BB231CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0856D364CE;
	Sat, 16 Dec 2023 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vEKHWeXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6135880
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Dec 2023 17:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702765176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=brTYUs/NOOA2cXIf01U3PHFMHf98kftr0w2Cycsj+uo=;
	b=vEKHWeXleD4WG76lTBN6vMxsY5LAC2LZksyA1opiBllaOXNgKWHRj/yoxUcMFDgzdpy/m5
	AMRAv+eKh/6UaUYvqDoq3yGe118qWBy7PQgyUGViUxheEzToZ8rhcERaIRiU2YT5OoWA6e
	idNAoZ4PLJsZL2TC21+btD5ZV/gODIM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 12/50] prandom: Remove unused include
Message-ID: <20231216221931.n74zjwi7a5aiqngb@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-2-kent.overstreet@linux.dev>
 <28e353de-1ea8-418b-8d96-a315a9469794@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e353de-1ea8-418b-8d96-a315a9469794@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Dec 16, 2023 at 10:52:04AM -0800, Randy Dunlap wrote:
> 
> 
> On 12/15/23 19:26, Kent Overstreet wrote:
> > prandom.h doesn't use percpu.h - this fixes some circular header issues.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/prandom.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/include/linux/prandom.h b/include/linux/prandom.h
> > index f2ed5b72b3d6..f7f1e5251c67 100644
> > --- a/include/linux/prandom.h
> > +++ b/include/linux/prandom.h
> > @@ -10,7 +10,6 @@
> >  
> >  #include <linux/types.h>
> >  #include <linux/once.h>
> > -#include <linux/percpu.h>
> >  #include <linux/random.h>
> >  
> >  struct rnd_state {
> 
> In this header file:
> 
>     22	void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
> 
> so where does it get __percpu from?

That comes from compiler.h -> compiler_types.h... cscope :)

