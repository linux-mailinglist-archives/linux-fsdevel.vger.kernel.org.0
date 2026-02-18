Return-Path: <linux-fsdevel+bounces-77574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN4tKT+/lWkfUgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:31:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D2F156AF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDA213016D10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457D931282E;
	Wed, 18 Feb 2026 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uryp0667"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260C3271E0;
	Wed, 18 Feb 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421427; cv=none; b=gbRKkehAkfFNUdfGSYG5R6nxlTmrPEVjocNwr+ns5o7D7sdVawCtULphdbp3bjfaQ24ePtXLPKzdA6nrvLDAk+hkF5pnYLoJXNUIyVyYJOI8869uOTgJbcq346U7vhxLWtgpgF/obq8T3P3EBJUZdLgQ96UWEaVJJfGR0ZYVe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421427; c=relaxed/simple;
	bh=2fLB0i2yglOtWFsO52/y6Bp31O0fZSkROhOjV//ILHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT4PQOSQX2pBASUbbvF6MsAjws9EakXVu5FxbHYmsF6aCm/QWgaogusImjSgXottglU1l/aLFg3Xh+LE5F9heLW3/JZRFP1zWOCzU73PC6QV1nBYkBWMzm/hw8oQG9MZjVqv5UIxUztPpeDEJSr59BzWUDG1saYzLgWb4Us5FVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uryp0667; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA7AC19421;
	Wed, 18 Feb 2026 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771421427;
	bh=2fLB0i2yglOtWFsO52/y6Bp31O0fZSkROhOjV//ILHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uryp0667Za5vj7bVl0n+jFgJE2yZ1LSq/OfX2vUNDNIhJYmWCmGwT9mQp9e3s6CLT
	 UwTGgCR/zksknGFu79PkscNA6yaSojCK9xCDOkbooYplWCkJP6X84yWrl203QZP5aX
	 YZb6v6pxZL9dsXBFokkwlo//RqobrXFf1jRo0P7MWB4qvtWzMV07TmjboTO0GWO7gR
	 grHUONJFrcoLUMzUPay2Yt0iW+ZzKuEKXI6lqnZvHht5cf1aNZkdn+0Io40IY6j4aK
	 MKcXUPHNDAAkLrMmJKHzZDVzcgS2IBWB8qVpqqIfDP5rU32Z2KXPZtSKxLUFsu5/es
	 z5oDyx35tP9Xw==
Date: Wed, 18 Feb 2026 14:30:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/4] clone: add CLONE_AUTOREAP
Message-ID: <20260218-fracht-geburt-2ba7db094f95@brauner>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-1-33a403c20111@kernel.org>
 <aZWhpo7-1a0ChJMN@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZWhpo7-1a0ChJMN@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77574-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44D2F156AF2
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:25:26PM +0100, Oleg Nesterov wrote:
> On 02/17, Christian Brauner wrote:
> >
> > CLONE_AUTOREAP can be combined with CLONE_PIDFD to allow the parent to
> > monitor the child's exit via poll() and retrieve exit status via
> > PIDFD_GET_INFO. Without CLONE_PIDFD it provides a fire-and-forget
> > pattern where the parent simply doesn't care about the child's exit
> > status. No exit signal is delivered so exit_signal must be zero.
>                                          ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Well, it has no effect if signal->autoreap is true. Probably makes
> sense to enforce this rule anyway... but see below.
> 
> > @@ -2028,6 +2028,13 @@ __latent_entropy struct task_struct *copy_process(
> >  			return ERR_PTR(-EINVAL);
> >  	}
> >
> > +	if (clone_flags & CLONE_AUTOREAP) {
> > +		if (clone_flags & CLONE_THREAD)
> > +			return ERR_PTR(-EINVAL);
> > +		if (args->exit_signal)
> > +			return ERR_PTR(-EINVAL);
> > +	}
> > +
> >  	/*
> >  	 * Force any signals received before this point to be delivered
> >  	 * before the fork happens.  Collect up signals sent to multiple
> > @@ -2374,6 +2381,8 @@ __latent_entropy struct task_struct *copy_process(
> >  		p->parent_exec_id = current->parent_exec_id;
> >  		if (clone_flags & CLONE_THREAD)
> >  			p->exit_signal = -1;
> > +		else if (clone_flags & CLONE_AUTOREAP)
> > +			p->exit_signal = 0;
> 
> So this is only needed for the CLONE_PARENT|CLONE_AUTOREAP case. Do we
> really need to support this case? Not that I see anything wrong, but let
> me ask anyway.
> 
> OTOH, what if a CLONE_AUTOREAP'ed child does clone(CLONE_PARENT) ?
> in this case args->exit_signal is ignored, so the new child will run
> with exit_signal == 0 but without signal->autoreap. This means it will
> become a zombie without sending a signal. Again, I see nothing really
> wrong, just this looks a bit confusing to me.

Good point, I think makes sense to not allow CLONE_PARENT with this.

