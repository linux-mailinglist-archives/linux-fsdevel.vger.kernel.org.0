Return-Path: <linux-fsdevel+bounces-75227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENsQIlIic2mUsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:25:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C571AE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4405303983D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23103382DB;
	Fri, 23 Jan 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjf32HfL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66E326957;
	Fri, 23 Jan 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152887; cv=none; b=htIIqYbuiLHeWKx0uftnohsqbeVXcGQVXVFcn8wEAClrq760qWNaxoZt03o74aPI5k0UGKWgxheYkHC00gUg2kvtK7XcR6rUXZWiRzy+MjYg3V5qG5pte6YM2K4tT3DdrOG5V/7fspgyDnHH+SbdrVyOw1oCKCeQ3yOHB35iFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152887; c=relaxed/simple;
	bh=DDl7zLtPOeFQjxt7Ggqx1S5g+R14kCM8cAEsVyBajUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoFg07EwIPmyPlBsHMMfkw95B/y1td9Phu/J0IhLQ04Oc+0y3DW4M7ufIE8wS393uXETKIVYRxAHBk2eeulNKFKLswsx/BOP8ZS7GPGpTA93dSg+QCJfnMVW4AmunsNCUKW3DvCXM8HIIqISif0poqhpwjNKknmRnix4KnGB1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjf32HfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4732C4CEF1;
	Fri, 23 Jan 2026 07:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769152886;
	bh=DDl7zLtPOeFQjxt7Ggqx1S5g+R14kCM8cAEsVyBajUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjf32HfLTAL5btPTzgGS8ktQroaXji6bHYgaSmpcssFw3bYEFppa2b7196Vj+gtgS
	 JB0yV8ItjC1KgxNyb/JKDbBP8cXLE/pw2Kuy+OtsxXLqA1XK+chfrwJBkykTwrhFK+
	 1Ka6FntfNJTrfxu4YP1rgQa3TZOMvQFSumTxGU4FoYgY9Mp639my/tPFeo7oPAa1hc
	 OonltoZHFkObImhv59hVSuAb0qvhJWNUuBxfUyQ78eEiiDKAxomx7RpXtP8ADa7Goz
	 oGkN27oAQ2xkdbEeSQ4tDvOB1P3S8wE4ASZXhMsZTsSzg3OnbiUHWNs9mDSIhrOi41
	 4u3ZPsn2LC7Xw==
Date: Thu, 22 Jan 2026 23:21:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: t@magnolia.djwong.org, Eric Biggers <ebiggers@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 04/11] fsverity: start consolidating pagecache code
Message-ID: <20260123072126.GJ5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-5-hch@lst.de>
 <20260122212700.GD5910@frogsfrogsfrogs>
 <20260123051216.GA24123@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123051216.GA24123@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75227-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B5C571AE8
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 06:12:16AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 01:27:00PM -0800, Darrick J. Wong wrote:
> > Nice hoist, though I wonder -- as an exported fs function, should we be
> > checking that the returned folio doesn't cover EOF?  Not that any of the
> > users actually check that returned merkle tree folios fit that
> > criterion.
> 
> As in past i_size because this is verity metadata?  I think per the
> last discussion that's only guranteed to be true, not the folio.  It
> might be useful to assert this, but it might be better for combine
> this with the work to use different on-disk vs in-memory offset
> and to consolidate all the offset magic.  Which is worthwhile,
> but І don't really want to add that in this series.

<nod> You're probably right that adding such a check would be better off
in whatever series formally defines the post-eof pagecache offset and
whatnot.

--D

