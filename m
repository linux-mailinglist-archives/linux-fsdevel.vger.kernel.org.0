Return-Path: <linux-fsdevel+bounces-26701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24C095B249
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5A4284C6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420BC183CCF;
	Thu, 22 Aug 2024 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9orjSN+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002413C9CB
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320139; cv=none; b=ty+HGKYhEM4dlMjZLM/PW9e5zkmtiCeOfbwlUi4Bx0HTIv/9hB2MB5Q/P4+RF/w0T1+mK0Z7Qpu0o9vQxYGf4T2kUwWHoLc1VGwEBRL0pDWoxZhuNtzYU04x24v/5zUTqWn+FNK/tZiQeQcPURgDg191IJmxrsCxWBuqH4n4+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320139; c=relaxed/simple;
	bh=ri+nLxgQsIR4ep9MSku7+v0ibgiE0UBwxFbp0SLW4yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1UNCkS/ME38FmoPOxQ9nomarimKKXSWhE8GA2q0p9FkVM5fKVt3P0ZebNJ4yBoZVngBAc3q9EqHN9fnxtYEEe+j+LjjxLid7sshCRwLBpfHO5BlFmokHCUYeDNN++50v3MoQIlVuhWcLK5S5mi0zMoY1dq2kn3PqYJ9jGjuWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9orjSN+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bec7d380caso785189a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724320136; x=1724924936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f13GeSPsUMcmBHQgCPpJotoAj1fLS756kyCf88gD8Ic=;
        b=F9orjSN+vDezyFJWSgc0aSUKhUhnpgQ0CPWJhzLTPSP5SercsAC7jalyD2QRIbQWwc
         44kk+N81ulVjHw/JSheq+QniIEAz+C2tfr0KEY+nmDqIUBdVXhPpFlnXKnEf6oEV64FT
         yN2Hu+5U3kbzJiUthEIcWklrnf9ToX42rVpaFhyyhl6Wh64bCc2PyfZHA+/qU5/tSxkU
         B/3mzyXJLGejUzFu0FDxPNvhLTA1r5DPJya4YIvj6hAxR89+NpVRuC7Qs0BvNcqldcLy
         6wEnNHl+5SjnvOPfe8PwMj7ntJwAdcU9jt2B/6u1BUj7XMwMYYd+XFFRwBSmvb8xYd2C
         ZG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320136; x=1724924936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f13GeSPsUMcmBHQgCPpJotoAj1fLS756kyCf88gD8Ic=;
        b=OsSyx1OSc8cxOiVeR0Cn2tQ7wg/fV8J7Sxse1PBtMnCkgPkAZ/6f+50QzfzofS+uTs
         bv6pSiblhQYXm0EXB4JN8vR+ZW7R2nSrQ3ToniXPS9CrMdhIcm0rXtE0zDwYSfKGiM1y
         e045kg6v3BGzs/1pc+Lx3pEcvHWpVLMSxAoGpdurdVMLSf/oBC/k5P6EeB47eMUCCBlU
         OBGCrkDO+mkwKaJYPmqD37Wf0xnZGjwf+MjKusdZ4fNyUICP6kCfECjea22wQaOW70Wi
         Tc860PuNtCAb046AvBrkUQD8I1RmS9cg6gDPLlm7ZJNsKHHsm5yrRLBWujkwfRJ7w6og
         ooHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhkYaRH7iifkwt54KiBnaqFCzUqwvK0xIYzMAFX1J0A2uIX3GWFUJTflY4cPJjDXZvxylzIoOzmG2qk2En@vger.kernel.org
X-Gm-Message-State: AOJu0YxZO/eDWRAmbc+/CSzOylLXmI8e9fbjtm4Njq4GIyIU0Usv84mm
	P+pepAlSMYUUf8kwMB1fVXNGfM9PKqk54yGz93aled+YrEciCvXdrRWHAg==
X-Google-Smtp-Source: AGHT+IGsA35FZVOFL+bRYB8qcyWyVThr7hODJoprB1K+UY7rvJk7cI0vZRFJamH9hgcGoBjT4YxUjQ==
X-Received: by 2002:a05:6402:2085:b0:5be:ecaa:bd82 with SMTP id 4fb4d7f45d1cf-5bf1f0dcf56mr3643408a12.16.1724320135867;
        Thu, 22 Aug 2024 02:48:55 -0700 (PDT)
Received: from f (cst-prg-86-203.cust.vodafone.cz. [46.135.86.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c72a7sm688356a12.65.2024.08.22.02.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:48:54 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:48:45 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/6] inode: port __I_LRU_ISOLATING to var event
Message-ID: <g2o4dwrlhgsu7wszchfqkpu6i6f2caqt3yj66ondmvzuyhvxys@b6mqm4rjzwwr>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-5-67244769f102@kernel.org>
 <fcf964b8b46af36e31f9dda2a8f2180eb999f35c.camel@kernel.org>
 <20240822-wachdienst-mahnmal-b25d2f0fb350@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822-wachdienst-mahnmal-b25d2f0fb350@brauner>

On Thu, Aug 22, 2024 at 10:53:50AM +0200, Christian Brauner wrote:
> On Wed, Aug 21, 2024 at 03:41:45PM GMT, Jeff Layton wrote:
> > >  	if (inode->i_state & I_LRU_ISOLATING) {
> > > -		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
> > > -		wait_queue_head_t *wqh;
> > > -
> > > -		wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
> > > -		spin_unlock(&inode->i_lock);
> > > -		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
> > > -		spin_lock(&inode->i_lock);
> > > +		struct wait_bit_queue_entry wqe;
> > > +		struct wait_queue_head *wq_head;
> > > +
> > > +		wq_head = inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
> > > +		for (;;) {
> > > +			prepare_to_wait_event(wq_head, &wqe.wq_entry,
> > > +					      TASK_UNINTERRUPTIBLE);
> > > +			if (inode->i_state & I_LRU_ISOLATING) {
> > > +				spin_unlock(&inode->i_lock);
> > > +				schedule();
> > > +				spin_lock(&inode->i_lock);
> > > +				continue;
> > > +			}
> > > +			break;
> > > +		}
> > 
> > nit: personally, I'd prefer this, since you wouldn't need the brackets
> > or the continue:
> > 
> > 			if (!(inode->i_state & LRU_ISOLATING))
> > 				break;
> > 			spin_unlock();
> > 			schedule();
> 
> Yeah, that's nicer. I'll use that.

In that case may I suggest also short-circuiting the entire func?

	if (!(inode->i_state & I_LRU_ISOLATING))
		return;

then the entire thing loses one indentation level

Same thing is applicable to the I_SYNC flag.

A non-cosmetic is as follows: is it legal for a wake up to happen
spuriously?

For legal waiters on the flag I_FREEING is set which prevents
I_LRU_ISOLATING from showing up afterwards. Thus it should be sufficient
to wait for the flag to clear once. This is moot if spurious wakeups do
happen.

If looping is needed, then this warn:
	WARN_ON(inode->i_state & I_LRU_ISOLATING);


fails to test for anything since the loop is on that very condition (iow
it needs to be whacked)

The writeback code needs to loop because there are callers outside of
evict().

