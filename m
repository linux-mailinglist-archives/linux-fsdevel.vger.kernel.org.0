Return-Path: <linux-fsdevel+bounces-26720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA6495B560
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2181281C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEA31C9EBB;
	Thu, 22 Aug 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS8sJFcq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BDB1C9DFF
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330775; cv=none; b=swbyLGuAgePvUOyLgwtE85cMUfVxcwU4O4Uk9rmoxPtgC0dzUn5Jy3T2h4JUgbU9hNnXk0OKMbWTKjz9Pfx13NlIhvFWlPq3it3AY2Ehq7snTEVEoFLBHHvOhY6iDQX/otLznE1fH7r0UptPasYmp47TcgS5ywme+ytQlyiLi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330775; c=relaxed/simple;
	bh=BLGuQeYjfNjxW4AiFMVUyV5TiDD/Ae4P5IawTtIa2I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDL/doEUQ+3PLem1Jfhyz1os7focgEPFxXxZt2WSkVHbpyjNOqpaneF8U9+ot+IYdMBNWS7ZCGNL6zqZHfwheW61kxC5n/9XW8FGft9CvYvvH407BrjSSQvMCdPQO/N7zTTfV2Ks8+bSjCwOO3uzhJEj0oB0Azpb1nxva8yigiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS8sJFcq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-533462b9428so1284113e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724330772; x=1724935572; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uprrD70h3OowqfWa2sFRLtt5SgTjupdi1OigxudsX9g=;
        b=FS8sJFcqAN0RgQzWnOMJkJVxCyy8QSnOwi0Sh+4mmRvQAS0uRFNjH4HBtgVC/tZDlb
         3SgfTLqWhQPCnXZmCivbD+KSr3DBU0yOA6AX7jj+G7TCsfsYP5TOM3NktkjemnLjbPQE
         7MIjccX5Wb/bdd5tNEPOdscJLV0/ZsWImiQhMjsig7Exjb1BexUUM0Ex3uY9razsuJKK
         sH+pndTzvmrrgEKWGWBQ2mm+x0p5wAxAFywBGYNrTwFaehq0r+cb18+v/NLGgF4JaDck
         //gJk2NMx6xPCcSFMujzsC6i6ZdwXHV01YxIEuLE3hretrDho50fzBsLUTLXzBIEfCzf
         YALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330772; x=1724935572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uprrD70h3OowqfWa2sFRLtt5SgTjupdi1OigxudsX9g=;
        b=HjYieL93BSRypQfqYag60UMoJeB4RpzPvpjChAYgSSq7KpQuhn1p4DPtKwtvbVzLt9
         my5Ix+2ukuAlEufx85fcUGuMr0dpisw1yheb4yppZ0bxiWxu9skkfNug0ZX9G/cNbeGS
         fZItJmuBkL4uURc3plq1EpeI7oG6RCVmXZHa0Wf3YhuvGHFLHu3ISDMJS0P5SePb49JB
         R+tIPRsfpEzstbMJcel3zNcoO5JoBMDR5ECE+HkEcWunBev0LFh4Zvs77DOg8CBg0y6P
         OXsyTcIZXLIesCgrNwsWzcKz3+/LhAdyb7oIeJnQVwQHRREl/oyvZxbO1RpLqEpDdS4N
         oJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCWQpKu4Up7XH3Xi+CY3oC108lO+mdJngHyxi3nGdr+8Sm8HPyF+s2RrCxKThaqVRANlyN00SgkRMXZxB/Ng@vger.kernel.org
X-Gm-Message-State: AOJu0YxE5x1oPCFMyniSPxc96MN2u8euWpq2uq0QSmqO8XWAkhVgGxpd
	Tzu1mOQa+SY3pLVmj2/RKy39x8SHwb7YiAJFs+/Gvu9Z53bHtG2r
X-Google-Smtp-Source: AGHT+IFYWWwITxiMyg8hEiB3KKoq747lRshqNA4wiVlZRp80JAzUwJbfop//EyXInGW7nlEUIbKg/g==
X-Received: by 2002:a05:6512:4022:b0:533:e5f:2678 with SMTP id 2adb3069b0e04-5334fd64296mr1609413e87.53.1724330771935;
        Thu, 22 Aug 2024 05:46:11 -0700 (PDT)
Received: from f (cst-prg-86-203.cust.vodafone.cz. [46.135.86.203])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48aac4sm113659766b.185.2024.08.22.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:46:11 -0700 (PDT)
Date: Thu, 22 Aug 2024 14:46:03 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/6] inode: port __I_LRU_ISOLATING to var event
Message-ID: <jq5ohr7wvogodzogiyc7klddqy4tsfheqexdxyz3jlnhprlkui@sjpwhrinhugo>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-5-67244769f102@kernel.org>
 <fcf964b8b46af36e31f9dda2a8f2180eb999f35c.camel@kernel.org>
 <20240822-wachdienst-mahnmal-b25d2f0fb350@brauner>
 <g2o4dwrlhgsu7wszchfqkpu6i6f2caqt3yj66ondmvzuyhvxys@b6mqm4rjzwwr>
 <20240822-nickt-pracht-3bfab23d1f57@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822-nickt-pracht-3bfab23d1f57@brauner>

On Thu, Aug 22, 2024 at 01:10:43PM +0200, Christian Brauner wrote:
> On Thu, Aug 22, 2024 at 11:48:45AM GMT, Mateusz Guzik wrote:
> > On Thu, Aug 22, 2024 at 10:53:50AM +0200, Christian Brauner wrote:
> > > On Wed, Aug 21, 2024 at 03:41:45PM GMT, Jeff Layton wrote:
> > > > >  	if (inode->i_state & I_LRU_ISOLATING) {
> > > > > -		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
> > > > > -		wait_queue_head_t *wqh;
> > > > > -
> > > > > -		wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
> > > > > -		spin_unlock(&inode->i_lock);
> > > > > -		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
> > > > > -		spin_lock(&inode->i_lock);
> > > > > +		struct wait_bit_queue_entry wqe;
> > > > > +		struct wait_queue_head *wq_head;
> > > > > +
> > > > > +		wq_head = inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
> > > > > +		for (;;) {
> > > > > +			prepare_to_wait_event(wq_head, &wqe.wq_entry,
> > > > > +					      TASK_UNINTERRUPTIBLE);
> > > > > +			if (inode->i_state & I_LRU_ISOLATING) {
> > > > > +				spin_unlock(&inode->i_lock);
> > > > > +				schedule();
> > > > > +				spin_lock(&inode->i_lock);
> > > > > +				continue;
> > > > > +			}
> > > > > +			break;
> > > > > +		}
> > > > 
> > > > nit: personally, I'd prefer this, since you wouldn't need the brackets
> > > > or the continue:
> > > > 
> > > > 			if (!(inode->i_state & LRU_ISOLATING))
> > > > 				break;
> > > > 			spin_unlock();
> > > > 			schedule();
> > > 
> > > Yeah, that's nicer. I'll use that.
> > 
> > In that case may I suggest also short-circuiting the entire func?
> > 
> > 	if (!(inode->i_state & I_LRU_ISOLATING))
> > 		return;
> 
> Afaict, if prepare_to_wait_event() has been called finish_wait() must be
> called.
> 

I mean the upfront check, before any other work:

static void inode_wait_for_lru_isolating(struct inode *inode)
{
        lockdep_assert_held(&inode->i_lock);
	if (!(inode->i_state & I_LRU_ISOLATING))
		return;

	/* for loop goes here, losing an indentation level but otherwise
	 * identical. same remark for the writeback thing */
	
}

> > 
> > then the entire thing loses one indentation level
> > 
> > Same thing is applicable to the I_SYNC flag.
> > 
> > A non-cosmetic is as follows: is it legal for a wake up to happen
> > spuriously?
> 
> So, I simply mimicked ___wait_var_event() and __wait_on_bit() - both
> loop. I reasoned that ___wait_var_event() via @state and __wait_on_bit()
> via @mode take the task state into account to wait in. And my conclusion
> was that they don't loop on TASK_UNINTERRUPTIBLE but would loop on e.g.,
> TASK_INTERRUPTIBLE. Iow, I assume that spurious wakeups shouldn't happen
> with TASK_UNINTERRUPTIBLE.
> 
> But it's not something I'm able to assert with absolute confidence so I
> erred on the side of caution.

This definitely should be sorted out that callers don't need to loop if
the condition is a one off in the worst case, but I concede getting
there is not *needed* at the moment, just a fixme.

