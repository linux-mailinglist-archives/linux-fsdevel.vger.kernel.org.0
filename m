Return-Path: <linux-fsdevel+bounces-77543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLX1KwN2lWlCRwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:19:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C75153F25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D806E302BE32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DA2318B81;
	Wed, 18 Feb 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWLxiREh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630D30C36D;
	Wed, 18 Feb 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402734; cv=none; b=EEHiNBM+CqfmoADExUb+OSEjcIf+y/8s+M9yaV9QaVInVepY54ordNUWniHlWuvFeYmBegr/EYpJIm6IPVyeugpt2iTuqEnMlKu/X0UXVO/z8PZZWMRmnTlCb84J6j2adzVzPQ60wqBasRM0OcF0BTitjE1HUuE3Dty9/PtvBrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402734; c=relaxed/simple;
	bh=apSyosdoNMECR7zRL2BMNJtkO2RflnKoi9T89I65T7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmpMAIzuMkXABSGtQ7JWN/iRiXmf3vkbwf2oiT6BRbtwkCyFFJ6dA5ErK11MLiYRl3qnlSD5CuBuMHnvV9BFAmQTdhr0BeejM4eugTZ1CC3X4DLwwPEJNsd6rat+RTKXrq1lPaFiZnvJfnbInxDIpP40qq/IuuA5npVNSiLVnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWLxiREh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3F4C19421;
	Wed, 18 Feb 2026 08:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771402734;
	bh=apSyosdoNMECR7zRL2BMNJtkO2RflnKoi9T89I65T7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWLxiREh7N9l1j5v47OnTJ/FajLzNSlp34q4V56hLnLwgisxC3zDXis1qI47WkVLs
	 YtSvX9E2sL4fNydJbg9nDcwMzb+Z8kp5qgjxxAyaTEnW5dSONrKevu7/7nbN+K9YZg
	 xzCVWrko3uxP9vDVHSuOPJO64rLjQPHINJbtc8nEeGQNVohyhJcn+Ax10IRB5zsDOL
	 No4bDM5EwLApGffYPmmgeHHvzIyKijYn5XstQnkuz5uSGwlSxatz6zrT814fs8GDjU
	 2i9VedGLBG2qp5Ndr9t2Jjg7cYwFN4sCTTyj5IFOpBaAuvbUZ+x2nvrH3mtq0RcZDJ
	 oTUjqWHkr+1IA==
Date: Wed, 18 Feb 2026 09:18:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Message-ID: <20260218-wonach-kampieren-adfca0940b45@brauner>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
 <CAHk-=wj80zwxy=5jp5SAi64cqCZgRjY1cRokVuDPd9_t3XMvUw@mail.gmail.com>
 <CAG48ez2YiL7RZ1fm9vwOCDGr9OsDrCHrCmkyRRoGRMWUZjyyBg@mail.gmail.com>
 <CAHk-=wiPJfnTVq6vUF8K8kF0FfrY2svAqSwsL8xLEV76pVyEkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPJfnTVq6vUF8K8kF0FfrY2svAqSwsL8xLEV76pVyEkg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77543-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 13C75153F25
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 03:44:52PM -0800, Linus Torvalds wrote:
> On Tue, 17 Feb 2026 at 15:38, Jann Horn <jannh@google.com> wrote:
> >
> > You can already send SIGHUP to such binaries through things like job
> > control, right?
> 
> But at least those can be blocked, and people can disassociate
> themselves from a tty if they care etc.
> 
> This seems like it can't be blocked any way, although I guess you can
> just do the double fork dance to distance yourself from your parent.
> 
> > Also, on a Linux system with systemd, I believe a normal user, when
> > running in the context of a user session (but not when running in the
> > context of a system service), can already SIGKILL anything they launch
> > by launching it in a systemd user service, then doing something [...]
> 
> Ugh. But at least it's not the kernel that does it, and we have rules
> for sending signals.
> 
> > I agree that this would be a change to the security model, but I'm not
> > sure if it would be that big a change.
> 
> I would expect most normal binaries to expect to be killed with ^C etc
> anyway, so in that sense this is indeed likely not a big deal. But at
> least those are well-known and traditional ways of getting signals
> that people kind of expecy.

I think you missed the message that I sent as a reply right away.

I'm very aware that as written this will allow users to kill setuid
binaries. I explictly wrote the first RFC so autokill isn't reset during
bprm->secureexec nor during commit_creds() - in contrast to pdeath
signal. I'm very aware of all of this and am calling it out in the
commit message as well.

The kill-on-close contract cannot be flaunted no matter what gets
executed very much in contrast to pdeath_signal which is annoying
because it magically gets unset and then userspace needs to know when it
got unset and then needs to reset it again.

My ideal model for kill-on-close is to just ruthlessly enforce that the
kernel murders anything once the file is released. I would value input
under what circumstances we could make this work without having the
kernel magically unset it under magical circumstances that are
completely opaque to userspace.

