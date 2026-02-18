Return-Path: <linux-fsdevel+bounces-77607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BPLhG10MlmlZZQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:00:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB1D158D86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B0CA300406B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2E2345CD8;
	Wed, 18 Feb 2026 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMxYjZjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569252FE56A;
	Wed, 18 Feb 2026 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441240; cv=none; b=XUHpg+mzmmkrlXiAnW++1HYX+ObGfCYO8MtmqZC+4rAhdLVvGigFTeWO4QdTLvhhWgcRle4WSvqzuEFR0oSFNYO2xu49tq2HfvLxaSawhidDnywMtV++6Kzji32BchxqFIItLj3bStfIInRXPwB4ofkWR1OFk1+r0oOEEhOEJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441240; c=relaxed/simple;
	bh=5XCcVudrYiZDaVmNcc3qQJfyMbi+XHIbWD/I6moPDhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPvQ12u7sOozoezbvlitd91122A8Kd6j9SLqlZdqfYhuH5N4SFP2dV9Bd2lHtZxoMRdTmwGX2lI42g8bqSGtyqP+I+jkMCEAho+WqGKRaaBeN8ZHHA/OyBRGL6scH9Nf1VsImWkGuguu36HmCgphYecOCOE/UQvxYV+yMRZV2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMxYjZjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DC7C116D0;
	Wed, 18 Feb 2026 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771441239;
	bh=5XCcVudrYiZDaVmNcc3qQJfyMbi+XHIbWD/I6moPDhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMxYjZjMjKjqw9Z+KxD7GQ9QAODsOpcHIcAYCUCp0x4vKcPW5MscLsIgHDmeJWvPz
	 EhpHHmU71mdxMNQonhSUMZpRmHIOJZZf9vUHS7/LDnEz7XU414e6Khnw6Dxlcjwo39
	 z2h8cUvlt9O5XfZvl7FsHE9WVN0s8yjLySt3Zcn7FPsMZyg+zQRFykUBMyJ3e5YiT8
	 aQabzAAQl/rw5qxpR2sKb2NVYm2D9IDzSNy1J24GxCEo74f0UqA3cmv+lbAW3hPx7p
	 4jcmfcDIiKTumE+fxxamlf8f/AH/kYqbaPx3XUNsXfpHsR2TR7NsrHyUX23c36YUlQ
	 ZMTQ7JVt8ClPw==
Date: Wed, 18 Feb 2026 11:00:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <dgc@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: inconsistent lock state in the new fserror code
Message-ID: <20260218190039.GA6503@frogsfrogsfrogs>
References: <aY7BndIgQg3ci_6s@infradead.org>
 <20260213160041.GT1535390@frogsfrogsfrogs>
 <20260213190757.GJ7693@frogsfrogsfrogs>
 <aY-n4leNi4NCzri1@dread>
 <aZQBAYCc5ouSoVXe@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZQBAYCc5ouSoVXe@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77607-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEB1D158D86
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 09:47:45PM -0800, Christoph Hellwig wrote:
> On Sat, Feb 14, 2026 at 09:38:26AM +1100, Dave Chinner wrote:
> > Yeah, that seems like a bug that needs fixing in the
> > ioend_writeback_end_bio() function - if there's an IO error, it
> > needs to punt the processing of the ioend to a workqueue...
> 
> The iomap code doesn't have a workqueue currently.  The way we split
> the code, we left the workqueue handling in XFS, because it is anchored
> in the inode.  I've been wanting to have it generic, as it would help
> with various other things, though.
> 
> For XFS we might be able to just always hook into our I/O completion
> handler and shortcut the workqueue for pure overwrites without errors,
> but that won't help other users like the block device code, zonefs and
> gfs2.  Maybe we'll need an opt-in for the fserror reporting now to
> exclude them?

<shrug> Assuming that file IO errors aren't a frequent occurrence, it's
easy enough to attach them to a global list and schedule_worker to
process the list when an error comes in.

> On something related, if we require a user context for fserror_report
> anyway, there is no need for the workqueue bouncing in it.

Bouncing the fserror_event to an async kworker is useful for laundering
the inode locking context -- fsnotify and ->report_error know they're
running in process context without any filesystem locks held.

I tried getting rid of the wq bouncing and immediately ran into the same
lockdep complaint but on xfs_inode::i_flags_lock.

--D

