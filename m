Return-Path: <linux-fsdevel+bounces-77346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ/wDHMolGk9AQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:36:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E7914A01C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F7DD300D340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D742D46CE;
	Tue, 17 Feb 2026 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5iUiDsX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC9212F98
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317359; cv=none; b=EgjPg+deAJ730jNWmQ9BCIUElG2dzQmmGUBjQcJ9IWZWbCvD/Q0oj6VotyPSn4D9HTfn0AFzbpTEO9ozLa2T7511BD6e5zV4+8MHYFxLWaCusBWULIWtB0gqES9SfcyJBK4OeSRdaqXTPIrtCCOm4oFXlFhK2sWIc0R6zfF1pO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317359; c=relaxed/simple;
	bh=vLN0gx58fYxfWWJPzpkRKWffJIKB5JnebBTVPC6S2IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwiVLsYCXL8Nir7eA+3QAfR0U7Li18b4nPMa8E3OUZ2cWF8pgzfYb+yUR0u/0tNDPZ8i6RDd1uFPtu8BesEfRmhFsOXKvd9RtntTAwu9c/eVqdF7vav73zuGd9JU1n3m02kM/16hgmM6diGX2RHKz6zPXGo0HkKahVexiDhPiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5iUiDsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8D7C19424;
	Tue, 17 Feb 2026 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771317359;
	bh=vLN0gx58fYxfWWJPzpkRKWffJIKB5JnebBTVPC6S2IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5iUiDsXts6VakdPtOxFLN1MaDkno/XI9IDwr+QYVzxPo9FcfEc/N52aN3tSp35I3
	 Pw4pNDFenb391HIV1arzABk9X66hw7DFKK2965txEm6s1gM/4P8W4789qvKgU3S77Q
	 AaBTZ/vGvdx42fbUZH1a5PIPl9AHp0Y+oBIYa2ZbItXHWXhGz6Jf3kaWnKy6lw1IFb
	 eU+dgGmsIFTwM89dJGCiQngFD/PZbLE4p1XByyGISB2/2nxCuag99mArsHxMLPtsXT
	 luhAWtjny2jAnFAwB1VvJYHQsBW2YuLDx2JJtW3ROJUvtF/biJVcxS1GaHOINd73Co
	 IGPwb1UiFSn0w==
Date: Tue, 17 Feb 2026 09:35:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Askar Safin <safinaskar@gmail.com>, christian@brauner.io, cyphar@cyphar.com, hpa@zytor.com, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260217-bauleistung-trott-c3e8d45e518a@brauner>
References: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
 <20260213182732.196792-1-safinaskar@gmail.com>
 <CAHk-=wiB7BN2BnBjk5y2Zim_vveYg7GAZA_N+XjrptY59Qnzzw@mail.gmail.com>
 <20260214-duzen-inschrift-9382ae6a5c2b@brauner>
 <CAHk-=wiG5uhN1F7fxyEiEQdMtK_j8TCd7FoStbCFpNbn8qx7iQ@mail.gmail.com>
 <20260214174030.GT3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260214174030.GT3183987@ZenIV>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77346-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,brauner.io,cyphar.com,zytor.com,suse.cz,vger.kernel.org,almesberger.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6E7914A01C
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 05:40:30PM +0000, Al Viro wrote:
> On Sat, Feb 14, 2026 at 08:18:55AM -0800, Linus Torvalds wrote:
> > On Sat, 14 Feb 2026 at 04:15, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > But my point has been: we don't need it anymore.
> > 
> > I don't think that makes much of a difference. We'd still need to have
> > pivot_root() around for the legacy case, and I do think we want to
> > make sure it can't be used as an attack vector (perhaps not directly,
> > but by possibly confusing other people).
> > 
> > Not that you should use containers as security boundaries anyway, but
> > I do think the current behavior needs to be limited. Because it's
> > dangerous.
> > 
> > Maybe just limiting it by namespace is ok.
> > 
> > Because even if the "white hat" users stop using pivot_root, we'd keep
> > it around for legacy - and we want to limit the damage.
> 
> Indeed.  Let's backtrack a bit:
> 1) pivot_root() screwing around with root/pwd is unfortunate, but it's not
> going away and neither is pivot_root() itself - not for several years,
> at the very least.
> 2) having the set of affected threads limited shouldn't be a problem, as
> long as we don't get too enthisiastic about that (relying upon the
> assumptions about kernel threads getting picked along with init is
> a bad idea, IMO).
> 3) walking into a container and expecting that mount tree won't get fucked
> under you is a Bloody Bad Idea(tm) even without pivot_root() in the mix.
> Sure, having pwd changed under you is still nice to avoid, but that's far
> from the only thing to be cautious about.  That doesn't affect the
> desirability of (2).

It's also not how people do it anyway.

> 4) as long as we change pwd and root of _any_ threads that are not aware of
> pivot_root() being done, we ought to have that change atomic wrt fork();
> if child gets spawned by any such thread, the resulting state should not
> depend upon the timinig of fork() vs. pivot_root().  The same goes for
> unshare(2) (and while we are at it, in absense of pivot_root(2) and other
> mount-related activity a caller of unshare(2) that gets ENOMEM can reasonably
> expect their mount tree to remain unchanged).
> 
> Does anybody have objections to the above?

Sounds good to me.

