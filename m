Return-Path: <linux-fsdevel+bounces-73604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D2CD1C98C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DED030CE21C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 05:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17F36B076;
	Wed, 14 Jan 2026 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzCxjfCo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414433F38C;
	Wed, 14 Jan 2026 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768369224; cv=none; b=tkMfnSfkW5NhPdFf3tblotDPRUbhuDCCMUD73lKZMszSN/1bSJkWdT8g4Q57C9vDYyDTXqP9Xan6TCk0E7GZIf72icUlheOxNqjvHJg2+BXrPPbvPQbwOQXoxnkLqAoOPSsaeBAGxKa0+EB2RQc1UusDj7lS2NZBGYKtrxqy94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768369224; c=relaxed/simple;
	bh=9vLvCSTWKCZ5vGof7ihP7jdqhcsELpmSAiSLQXvIb8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke3gfOJ4IWXxcn2reOsP+PUxeBxLxvF1Loo4SvANGsmRXa17ZCd8UJnFf8Mw821Vn1c9DlpMgK2wZ9myTG72BvSMhf2yzOw0DrZEzlMCifpjvUbI1HyAZi0oRksoV3U7TLgPJ9Eg82jmdg8jIlfreXSYjdX2UWtDHwh2yO3JV/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzCxjfCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0950C4CEF7;
	Wed, 14 Jan 2026 05:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768369222;
	bh=9vLvCSTWKCZ5vGof7ihP7jdqhcsELpmSAiSLQXvIb8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzCxjfCoq6WKmkStJwPnGYJYoHj/W3a+myxk7BP+TN0lDcucBaD5wutCsrx1Xu5TP
	 kGAZ9FuUpZUiZMlYCD7Jk/9sxXpWI55dHLrLvDAO+XKjkGWvnPAPMpCwHtTtvYHoXa
	 glKZb1W3D5vDa8oU2wJ5Wr1XxBANfbpIz2lv6nc8p4nzAxMspwJpNt+SW79p7qDtmQ
	 Ab9TrNsMwMqtolXUlp7RrvWk4j2QY0eqeR1cXZ2aovIQxCmMG+fjI+noHOuTz8lwtT
	 AaWRwd2DUMpB/iSl4jGn9tXfY/xO4frF5syflaz6YT4Q+sFq0qDx3FmrkbqnpZDyxJ
	 CHkyYxFcS9XGw==
Date: Tue, 13 Jan 2026 21:40:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/11] xfs: add media verification ioctl
Message-ID: <20260114054021.GE15551@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
 <176826412941.3493441.8359506127711497025.stgit@frogsfrogsfrogs>
 <20260113155701.GA3489@lst.de>
 <20260113232113.GD15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113232113.GD15551@frogsfrogsfrogs>

On Tue, Jan 13, 2026 at 03:21:13PM -0800, Darrick J. Wong wrote:
> On Tue, Jan 13, 2026 at 04:57:01PM +0100, Christoph Hellwig wrote:
> > On Mon, Jan 12, 2026 at 04:35:25PM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Add a new privileged ioctl so that xfs_scrub can ask the kernel to
> > > verify the media of the devices backing an xfs filesystem, and have any
> > > resulting media errors reported to fsnotify and xfs_healer.
> > 
> > Hmm, the description is a bit sparse?
> > 
> > > +/* Verify the media of the underlying devices */
> > > +struct xfs_verify_media {
> > > +	__u32	dev;		/* I: XFS_VERIFY_*DEV */
> > 
> > This should probably use the enum xfs_device values?
> 
> Yes, that's a good point.

FYI, today's draft of this ioctl can be read here:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=health-monitoring_2026-01-13&id=e3fee7d7ead8b3e630845304b9030b5c7c5f27da

It contains all the alterations I talked about earlier today.

(I might be coming down with a cold, so I thought it best to git push
now and find out if I'm at all coherent tomorrow.)

--D

