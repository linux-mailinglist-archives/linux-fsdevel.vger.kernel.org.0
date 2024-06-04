Return-Path: <linux-fsdevel+bounces-20989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147E8FBC82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 21:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0643628406D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1C14A62B;
	Tue,  4 Jun 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p0VyzOC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506713D2AF
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529285; cv=none; b=enlOyw4FEyOLXM/lY1ECo5nvdac4hilcopPd7O9OcbkxAnjlbco9xNrMqkuxokKGPEtEKs3I/yTC2FyPcCvwzn/FFHjSQp3kJ72oaB3tc9Rnc8X5EpabRayKjlT9EFvuUNhN20XkWm8zDq13VHip1IGd8hZclFEp9CFDTyUADUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529285; c=relaxed/simple;
	bh=0JsQ5I3TUPLRmdgVEQReqvmGXYRbdqD3/h9bJU8flyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5KTQV2q9xGqcRhHhJ0vFNQu3LUS4N0rBiM/fijGFaAHrKVRDU+jsbmg6eICIBcduBCyiVPAQB45jbHn5y+EUH4GX8cuBqI4iwalwmg2cYINy4DBA/7jmif083+EYzJZhuESjfFIoIni5rMXkikgvLadKFUO6h/c3jD+utRAsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p0VyzOC0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pEmaYiLWKTByKFN/Lq/wIKk8L82NPkCU0Wc63JHsyaQ=; b=p0VyzOC0ScAMBVfu4OUdYbh6pe
	aKa5hqUJkZmk3Nl96l/mn1W2Kpsbbm9VQWyo/rQp1EH1PIWZt0eCI0IxRyvND/2OWDLvffYSIpbPd
	dcXBCZBATZw4LrvN5E8m+98tEx04e913/T0H8xJ/8yduyRyFzjt1bsdQZ0idPiBXBRMWoeJK/YYFW
	syXc4SL+k2Wnzz1ovaWoq8fXDLdqkLbO4OUkZlq3/chhscPtff+cvHmIowq1KpETop8hudPEQ50Gp
	NnbHen/kLaSiin07BRhDssTqa2aFQT2StVOmSNuwRNUPbssKbDs150EEjzr5lSfTBbnawK79YCNDP
	fCGh13yA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZp4-0000000FZjw-0Ug0;
	Tue, 04 Jun 2024 19:27:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B6D7B30068B; Tue,  4 Jun 2024 21:27:52 +0200 (CEST)
Date: Tue, 4 Jun 2024 21:27:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
	Ingo Molnar <mingo@redhat.com>, Andrei Vagin <avagin@google.com>
Subject: Re: [PATCH RFC v2 15/19] export __wake_on_current_cpu
Message-ID: <20240604192752.GQ40213@noisy.programming.kicks-ass.net>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-15-d149476b1d65@ddn.com>
 <20240530203729.GG2210558@perftesting>
 <20240604092635.GN26599@noisy.programming.kicks-ass.net>
 <f1989554-35f2-4f42-af98-69521f620143@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1989554-35f2-4f42-af98-69521f620143@ddn.com>

On Tue, Jun 04, 2024 at 09:36:08AM +0000, Bernd Schubert wrote:
> On 6/4/24 11:26, Peter Zijlstra wrote:
> > On Thu, May 30, 2024 at 04:37:29PM -0400, Josef Bacik wrote:
> >> On Wed, May 29, 2024 at 08:00:50PM +0200, Bernd Schubert wrote:
> >>> This is needed by fuse-over-io-uring to wake up the waiting
> >>> application thread on the core it was submitted from.
> >>> Avoiding core switching is actually a major factor for
> >>> fuse performance improvements of fuse-over-io-uring.
> >>>
> >>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >>> Cc: Ingo Molnar <mingo@redhat.com>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: Andrei Vagin <avagin@google.com>
> >>
> >> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> >>
> >> Probably best to submit this as a one-off so the sched guys can take it and it's
> >> not in the middle of a fuse patchset they may be ignoring.  Thanks,
> > 
> > On its own its going to not be applied. Never merge an EXPORT without a
> > user.
> > 
> > As is, I don't have enough of the series to even see the user, so yeah,
> > not happy :/
> > 
> > And as hch said, this very much needs to be a GPL export.
> 
> Sorry, accidentally done without the _GPL. What is the right way to get this merged? 
> First merge the entire fuse-io-uring series and then add on this? I already have these 
> optimization patches at the end of the series... The user for this is in the next patch

Yeah, but you didn't send me the next patch, did you? So I have no
clue.. :-)

Anyway, if you could add a wee comment to __wake_up_con_current_cpu()
along with the EXPORT_SYMBOL_GPL() that might be nice. I suppose you can
copy paste from __wake_up() and then edit a wee bit.

> [PATCH RFC v2 16/19] fuse: {uring} Wake requests on the the current cpu
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index c7fd3849a105..851c5fa99946 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -333,7 +333,10 @@ void fuse_request_end(struct fuse_req *req)
>                 spin_unlock(&fc->bg_lock);
>         } else {
>                 /* Wake up waiter sleeping in request_wait_answer() */
> -               wake_up(&req->waitq);
> +               if (fuse_per_core_queue(fc))
> +                       __wake_up_on_current_cpu(&req->waitq, TASK_NORMAL, NULL);
> +               else
> +                       wake_up(&req->waitq);
>         }
> 
>         if (test_bit(FR_ASYNC, &req->flags))

Fair enough, although do we want a helper like wake_up() -- something
like wake_up_on_current_cpu() ?



