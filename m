Return-Path: <linux-fsdevel+bounces-26712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE4995B382
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A3D1C22D37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAC918308D;
	Thu, 22 Aug 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc6+fvKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1518C31
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325049; cv=none; b=YW91MBnO343f/0wqnhaLqx9jCWhJjVo35aTEzYWVewqU01sKdhaTdPQfwKa+VWD2n74cwR5h576RCAMWbKfN21o/fa4Hf5Et4J4DYZYew5CMyklCywxnyMyTEUiD2PhdKSZ3lk/FXi1pVbpCwCYDP0HA84AQgePw289A6RTSEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325049; c=relaxed/simple;
	bh=YjJHWudxNHFCAoRjx9l0alMNcNeozwjSQcVlndNu2Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYPZMaBXuQBDPI311Wf9mrIRLRbJRN5peQdoEDUis12LA+H9wDJ2a6EVcsz+b9Wk1kkBkRCf7yxbB9Hg1tn2VVZ5ukpJbmQAFoIFESkkXSXMvhaBmyQ7990Fdiii7WNFb4fZ5uzZnBNdPeJUrgjAXN63vvusk+nFIYz6INDoZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc6+fvKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F66C32782;
	Thu, 22 Aug 2024 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724325048;
	bh=YjJHWudxNHFCAoRjx9l0alMNcNeozwjSQcVlndNu2Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bc6+fvKac4hBMOqiSKP85t0SP8p4iLTWg5KX8RNr9mq6g0ihkzFexkNaF4eiO3gSl
	 Zd/2sWy9JH73VdRsob5W35WtLxvu1s76nHutej/Rt4N4RkgjpLuaZO/r6rnrq1Elvk
	 ENXoCcmDchi29M8QAUQPBzELgxI+jP+xMc9evh/e/INgj7cOOHnfqVt8wv5RaeaXGd
	 SgF1LK57MnlLSL7/8Oij374pCpA/0F+sRUL1I1Os3NzeGoT0dmxbTkmNwbikCmVAjT
	 JhWGYUKR2IpAzWdcZhUwag5Qb8OgGn69m5z5qWI+LU2DUg/DRpAg4v/QiZkjIdePTB
	 JxnONsPbwHAUg==
Date: Thu, 22 Aug 2024 13:10:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/6] inode: port __I_LRU_ISOLATING to var event
Message-ID: <20240822-nickt-pracht-3bfab23d1f57@brauner>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-5-67244769f102@kernel.org>
 <fcf964b8b46af36e31f9dda2a8f2180eb999f35c.camel@kernel.org>
 <20240822-wachdienst-mahnmal-b25d2f0fb350@brauner>
 <g2o4dwrlhgsu7wszchfqkpu6i6f2caqt3yj66ondmvzuyhvxys@b6mqm4rjzwwr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <g2o4dwrlhgsu7wszchfqkpu6i6f2caqt3yj66ondmvzuyhvxys@b6mqm4rjzwwr>

On Thu, Aug 22, 2024 at 11:48:45AM GMT, Mateusz Guzik wrote:
> On Thu, Aug 22, 2024 at 10:53:50AM +0200, Christian Brauner wrote:
> > On Wed, Aug 21, 2024 at 03:41:45PM GMT, Jeff Layton wrote:
> > > >  	if (inode->i_state & I_LRU_ISOLATING) {
> > > > -		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
> > > > -		wait_queue_head_t *wqh;
> > > > -
> > > > -		wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
> > > > -		spin_unlock(&inode->i_lock);
> > > > -		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
> > > > -		spin_lock(&inode->i_lock);
> > > > +		struct wait_bit_queue_entry wqe;
> > > > +		struct wait_queue_head *wq_head;
> > > > +
> > > > +		wq_head = inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
> > > > +		for (;;) {
> > > > +			prepare_to_wait_event(wq_head, &wqe.wq_entry,
> > > > +					      TASK_UNINTERRUPTIBLE);
> > > > +			if (inode->i_state & I_LRU_ISOLATING) {
> > > > +				spin_unlock(&inode->i_lock);
> > > > +				schedule();
> > > > +				spin_lock(&inode->i_lock);
> > > > +				continue;
> > > > +			}
> > > > +			break;
> > > > +		}
> > > 
> > > nit: personally, I'd prefer this, since you wouldn't need the brackets
> > > or the continue:
> > > 
> > > 			if (!(inode->i_state & LRU_ISOLATING))
> > > 				break;
> > > 			spin_unlock();
> > > 			schedule();
> > 
> > Yeah, that's nicer. I'll use that.
> 
> In that case may I suggest also short-circuiting the entire func?
> 
> 	if (!(inode->i_state & I_LRU_ISOLATING))
> 		return;

Afaict, if prepare_to_wait_event() has been called finish_wait() must be
called.

> 
> then the entire thing loses one indentation level
> 
> Same thing is applicable to the I_SYNC flag.
> 
> A non-cosmetic is as follows: is it legal for a wake up to happen
> spuriously?

So, I simply mimicked ___wait_var_event() and __wait_on_bit() - both
loop. I reasoned that ___wait_var_event() via @state and __wait_on_bit()
via @mode take the task state into account to wait in. And my conclusion
was that they don't loop on TASK_UNINTERRUPTIBLE but would loop on e.g.,
TASK_INTERRUPTIBLE. Iow, I assume that spurious wakeups shouldn't happen
with TASK_UNINTERRUPTIBLE.

But it's not something I'm able to assert with absolute confidence so I
erred on the side of caution.

