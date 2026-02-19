Return-Path: <linux-fsdevel+bounces-77670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF0YFBColmmTiQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:05:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E535015C4B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A93302A6E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCE52E6CCB;
	Thu, 19 Feb 2026 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZiyoyDH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A6238C16;
	Thu, 19 Feb 2026 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771481096; cv=none; b=m1Rnw7MzgZz7ZYoGN/O0kXtGx6GPFzJlsMoucDl1jim7+GQ+eITWqvCsOJGKrEz+6V0LtUQfz/0qwcPZKXN86iG7rjRql41sd5ODHYwtlXYYeGpeNBQHPjEMS/PzLw0U5VaGDj8g/WDSnS4zGc0psTFh2N/Y4RXjTIbmZ/3owxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771481096; c=relaxed/simple;
	bh=koMKSq6q7E0tfAmoL/HLcbbXbKGAz443vWDM9FNzEy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/SIK8rt1ONJtINtC82x0DXGgDQCKqomoVzyJi/TFxVFYTJyKIv2kBU4ofpmo2LMrhs1BeCW8SeZIpCYMQ/3qVxNpQwD0KBIfkXgSVgOLFzuLtGUJwrPRZvrbHFr+/Y/k2qzbOc6J7ywJYqYOWUn31pM0RDJO4bWEvIlguGvLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZiyoyDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E2FC4CEF7;
	Thu, 19 Feb 2026 06:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771481096;
	bh=koMKSq6q7E0tfAmoL/HLcbbXbKGAz443vWDM9FNzEy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZiyoyDHPGmWz54IpQsSUQsaZI6JVdIfUHmnTCwoEuhzSgLTqXyIgHeDPnSWT6ggZ
	 NYFasLiN0ZPGiIfhoMTmI1dOy0hVB4qD49atLoC1NA6JYqTAglZH8ooOSDYIP3x3dJ
	 apg2wErPKqnLtMVQQqjalTW0IwgbDfsdDBIuE0uwTudve7tITwYMoyIICSkj+6Bdpn
	 L4jZB/dvwtFEQJHqWEjj2mkHUkDyXhX57xDJu1UlNeyqFEQX0A3ZIWskwj/0YIen0r
	 AnpgoZEVn7YVQg1/kS75tLJKCVhPcpX15GRHn8sXF5KkCz/0W82q/FnlKl5dNNz7ub
	 szEZ6y6VANH0g==
Date: Wed, 18 Feb 2026 22:04:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Subject: Re: [PATCH v3 07/35] iomap: introduce IOMAP_F_FSVERITY
Message-ID: <20260219060455.GD6490@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-8-aalbersh@kernel.org>
 <20260218230348.GF6467@frogsfrogsfrogs>
 <20260219060024.GB3739@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219060024.GB3739@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77670-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E535015C4B6
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 07:00:24AM +0100, Christoph Hellwig wrote:
> On Wed, Feb 18, 2026 at 03:03:48PM -0800, Darrick J. Wong wrote:
> > >  		old_size = iter->inode->i_size;
> > > -		if (pos + written > old_size) {
> > > +		if (pos + written > old_size &&
> > > +		    !(iter->iomap.flags & IOMAP_F_FSVERITY)) {
> > 
> > I think this flag should be called IOMAP_F_POSTEOF since there's no
> > "fsverity" logic dependent on this flag; it merely allows read/write
> > access to folios beyond EOF without any of the usual clamping and
> > zeroing...
> 
> There are fsverity-specific semantics attached because of the
> magic hash handling for holes.

Ohhh never mind then.  Admittedly I haven't read all the way through
this patchset yet.

--D

