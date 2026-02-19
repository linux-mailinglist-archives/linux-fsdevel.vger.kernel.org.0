Return-Path: <linux-fsdevel+bounces-77667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCMTH8CmlmmTiQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:59:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB8A15C41D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C68363008889
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 05:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95172D781E;
	Thu, 19 Feb 2026 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD4SMzVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896C1862A;
	Thu, 19 Feb 2026 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480765; cv=none; b=Xon9Fa53rrKU1fCcP4f5/5NeZ1FGllyCAWqQjeOev5CABLrcCOqz8PUWP0LdnNfdE6FNOh9yr0C2zeekQnxuHi9CZZw8FarWf95PB2I67VU0Que4KCTTEBbY0OfOHVS0VTFLDqK6N4pKgpZeMrOgHntjzEyLywgOKT10potdbUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480765; c=relaxed/simple;
	bh=AkMaBIChxtNBBgRRHZRn50h5LK/KFCLy8qvaqBDIMVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJElakKIdDuv5U7tYM1XIt79oSyuuu4AiZsL2F0U6Y9uhkhM3jJCITL+9L48hvQrYvGUvj0EMNjDofbhKfq3w8ZXWB6wsozos4oPaUU3D4ys+xhJU5MsOTCDPcx8SEwru5i/1egfGVdlhX0wDtRABOlERE5JBlDpgWd4h05EzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD4SMzVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB205C4CEF7;
	Thu, 19 Feb 2026 05:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771480765;
	bh=AkMaBIChxtNBBgRRHZRn50h5LK/KFCLy8qvaqBDIMVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HD4SMzVt/7+K4wBUOlN9KUkJ+hpk/HTHHGJ0Volwkn1euvFpo2kcDwFG6X9+IBm3n
	 SBi/E2PtLyCOGuud1Bjz3Mr4wEytw0Bw0wBNS5ga3pfAvJGOxE04sBMaNomJk8+yBA
	 l5qDmwFhfO/9RWWA1tkcFCQEfM8ppUAijlLyqYdLTKXwZJCJobnU+5TXVlHI9ts3+6
	 o7BZJHju78XUw2JUEwfJLljsJwbiDK338miydhqp+bOND/AAxZx1eMhkc9pgVz+NS/
	 Ev3+J7IX3yUaF8x2aj+4vsO79n3dwtJlhnY3VEChmc2V1odcSUnBz9HnHXPj2In4G6
	 4XN54Uednve/A==
Date: Wed, 18 Feb 2026 21:59:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <dgc@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: inconsistent lock state in the new fserror code
Message-ID: <20260219055924.GC6490@frogsfrogsfrogs>
References: <aY7BndIgQg3ci_6s@infradead.org>
 <20260213160041.GT1535390@frogsfrogsfrogs>
 <20260213190757.GJ7693@frogsfrogsfrogs>
 <aY-n4leNi4NCzri1@dread>
 <aZQBAYCc5ouSoVXe@infradead.org>
 <20260218190039.GA6503@frogsfrogsfrogs>
 <aZalP0kfWO1rHf4_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZalP0kfWO1rHf4_@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77667-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAB8A15C41D
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 09:53:03PM -0800, Christoph Hellwig wrote:
> On Wed, Feb 18, 2026 at 11:00:39AM -0800, Darrick J. Wong wrote:
> > > but that won't help other users like the block device code, zonefs and
> > > gfs2.  Maybe we'll need an opt-in for the fserror reporting now to
> > > exclude them?
> > 
> > <shrug> Assuming that file IO errors aren't a frequent occurrence, it's
> > easy enough to attach them to a global list and schedule_worker to
> > process the list when an error comes in.
> 
> I'd rather not created random forests of workqueues if we can.
> Let file systems opt into features when they provide the infrastructure,
> and left common enough infrastructure into common code as we usually do.

That /is/ a weird part about the fserror calls in iomap -- the
filesystem doesn't have to provide any infrastructure to get the
functionality.

I guess we could do something weird like add a flags field to iomap_ops
so that a filesystem could say that it wants fserror reporting; or plumb
a bunch more stuff through iomap.

<shrug> I think I'd rather just send my accumulated 7.0 fixes and we can
argue about the correct solution(s) with some real code. :)

--D

> > > On something related, if we require a user context for fserror_report
> > > anyway, there is no need for the workqueue bouncing in it.
> > 
> > Bouncing the fserror_event to an async kworker is useful for laundering
> > the inode locking context -- fsnotify and ->report_error know they're
> > running in process context without any filesystem locks held.
> > 
> > I tried getting rid of the wq bouncing and immediately ran into the same
> > lockdep complaint but on xfs_inode::i_flags_lock.
> 
> Ok.
> 
> 

