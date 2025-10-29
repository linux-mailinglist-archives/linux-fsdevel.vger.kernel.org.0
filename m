Return-Path: <linux-fsdevel+bounces-66310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BE5C1B705
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0455A5E1909
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB2435029D;
	Wed, 29 Oct 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJStSTi6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0110350282;
	Wed, 29 Oct 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748704; cv=none; b=FCN51AMCdoZoZjp57gDKOMs7J0zlimADDmmMX1eU4nTl4hayYTzdDJA3zMio3bpG8SM/+dufZ+olgar/op9/xkJaGgAV6FBxEFp7sy4f84dtIRrVQiFIxmLLFh73Cg07Npfyzi5vOk4CWF7xfhFKDHz2zGiB84eYeX+QeA7D6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748704; c=relaxed/simple;
	bh=pvvQ67Oku+WXFWQ1kVL3e9s2qZVASwQUfVzM1Fn4dmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3DrpiIUl4VQrvrKD5juiqDu25QbyYirgz3xw/r8d2cRyiGK2YGfHlzyTSINpoJTNzVVTThpXpKzJtZ9k25gRLe0KUh6hXscs91XSopLZAQMON6f1yHXmJtB+WXHF9j40FtoIctdCOvpag4CK6RMYDZ7GxirzTzpGMlQW6tYQJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJStSTi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190B2C116D0;
	Wed, 29 Oct 2025 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748704;
	bh=pvvQ67Oku+WXFWQ1kVL3e9s2qZVASwQUfVzM1Fn4dmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJStSTi6y4aKZwvSZsu1QTObKgy025wHAd/lMtL7mQ7wLqcRuwa/f60fk840Xqbqd
	 6/aMB66V81VgkLG2DcuAOgBnX3iWYOcmKNM20ptG0VPwDeYPf4Wr1blDTetDTJRJg6
	 FGKFXTHdiFJVHymYRv4BI8l+cctA8UwRUHUVodrF4ERLwnTpuRRkV7PFwfkJckfE8+
	 7hcO9VNxpHSUJHsRmz5fdDmH1ONEBJD2GR72VAdo80bTKKbMNvxs3Bhtqfo6jXTQs7
	 rsBb18RMrpJtP4V1p7EN683rSI0JoHLszcvZTtwmZZxaeGD4azcYGINL9+M50EHaKa
	 WI9ebhuXF4dpA==
Date: Wed, 29 Oct 2025 07:38:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: miklos@szeredi.hu, brauner@kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20251029143823.GL6174@frogsfrogsfrogs>
References: <176169809564.1424591.2699278742364464313.stgit@frogsfrogsfrogs>
 <176169809588.1424591.6275994842604794287.stgit@frogsfrogsfrogs>
 <20251029084048.GA32095@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029084048.GA32095@lst.de>

On Wed, Oct 29, 2025 at 09:40:48AM +0100, Christoph Hellwig wrote:
> On Tue, Oct 28, 2025 at 05:44:26PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > All current users of the iomap swapfile activation mechanism are block
> > device filesystems.  This means that claim_swapfile will set
> > swap_info_struct::bdev to inode->i_sb->s_bdev of the swap file.
> > 
> > However, in the future there could be fuse+iomap filesystems that are
> > block device based but don't set s_bdev.  In this case, sis::bdev will
> > be set to NULL when we enter iomap_swapfile_activate, and we can pick
> > up a bdev from the first iomap mapping that the filesystem provides.
> 
> Could, or will be?  I find the way the swapfiles work right now
> disgusting to start with, but extending that bypass to fuse seems
> even worse.

Yes, "Could", in the sense that a subsequent fuse patch wires up sending
FUSE_IOMAP_BEGIN to the fuse server to ask for layouts for swapfiles,
and the fuse server can reply with a mapping or EOPNOTSUPP to abort the
swapon.  (There's a separate FUSE_IOMAP_IOEND req at deactivation time).

"Already does" in the sense that fuse already supports swapfiles(!) if
your filesystem implements FUSE_BMAP and attaches via fuseblk (aka
ntfs3g).

--D

