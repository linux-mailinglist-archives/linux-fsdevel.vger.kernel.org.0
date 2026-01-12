Return-Path: <linux-fsdevel+bounces-73308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6586DD14CD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 19:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D11E301B64F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4D3876D3;
	Mon, 12 Jan 2026 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHcElaPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34938737D;
	Mon, 12 Jan 2026 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243843; cv=none; b=o7ANhWOe7P29iyqGexKlTYC2L1glKPMlOGDGKK3THvdasKoFLCdlJBTB8DJ6WgG7Zv5ji3/ZB1NQopbWxgSi2HtCQ1N2VZAUpCyVU6AwMI4jDvU157IrO7U9TJ2CCtI2p0gzpKQ4eji5GrbdntHTglwjaLF8kInvnYDiNgH4oRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243843; c=relaxed/simple;
	bh=A7jTj7iL7JrK5vPwuvrnRcI/83rwuTL/QPso5DSsYXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeAcO8VLO0mhZ8AKssu4f4IjdufLZAfwAG0MqXJJR3AvqKD2oAC4k/i5PLxktgj41J60Wo9x8S/nPhnDaTtRLiBc3JspEGIaWq0ZUCVX6yLiNiZ79WHveJRlVs8IPIVJEin4Ilin39x7WlH/lobroD6Dlq+Kb+b/g3GceS3Ic6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHcElaPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486BFC116D0;
	Mon, 12 Jan 2026 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768243843;
	bh=A7jTj7iL7JrK5vPwuvrnRcI/83rwuTL/QPso5DSsYXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHcElaPS6kR5q/Ecx65o3DEgbuiXvBAPHWR+XNGBOJxy+OD4ATJFxze/rXZhPEunm
	 kXl2jHukwyxVBEqBGmGnV6FNygPOkoqt29JdIRMIGoLDjTUOyNP/KwxvK63hF65f9N
	 L0gKM5wTJwsibgMJaWc+sGLEUdeMlWfSCCQ1Cm7ANtq4pxyMvgAjIGAFWMfNbRja3z
	 AhP0g6ZqGTs1b5QK9/c2sMUr9A/FXSrePFEStBpz0E3itHjayTiCakJHMREc8kmwh+
	 M+ToeQ6HR3W5G9pQGlMcEw7m7y/ppJjX4TsJuNcF4jrTqBFXup/9MezHWb3gPXw5Sm
	 CdMQuk0YePaDg==
Date: Mon, 12 Jan 2026 10:50:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
	jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gabriel@krisman.be,
	amir73il@gmail.com
Subject: Re: [PATCH 2/6] fs: report filesystem and file I/O errors to fsnotify
Message-ID: <20260112185042.GB15532@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332171.686273.14690243193639006055.stgit@frogsfrogsfrogs>
 <aUOPcNNR1oAxa1hC@infradead.org>
 <20251218184429.GX7725@frogsfrogsfrogs>
 <20251224-nippen-ganoven-fc2db4d34d9f@brauner>
 <20260106164230.GH191501@frogsfrogsfrogs>
 <20260112-anpassen-konglomerat-fce55d3de81b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-anpassen-konglomerat-fce55d3de81b@brauner>

On Mon, Jan 12, 2026 at 02:17:14PM +0100, Christian Brauner wrote:
> On Tue, Jan 06, 2026 at 08:42:30AM -0800, Darrick J. Wong wrote:
> > On Wed, Dec 24, 2025 at 01:29:21PM +0100, Christian Brauner wrote:
> > > > Nope.  Fixed.
> > > 
> > > I've pulled this from the provided branch which already contains the
> > > mentioned fixes. It now lives in vfs-7.0.fserror. As an aside, the
> > > numbering for this patch series was very odd which tripped b4 so I
> > > applied it with manual massaging. Let me know if there are any issues. 
> > 
> > Thank you!  But, uh... do you want me to fix the things that hch and jan
> > mentioned?  Or have you already fixed them?  I don't see a
> > vfs-7.0.fserror branch on the vfs tree[1]...
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/refs/heads
> 
> Before Christmas and the new year I didn't push anything out so we don't
> end up in a situation where -next is broken but half the people are
> still on vacation or are busy catching up.
> 
> I'm back now. Please just send a version with the fixes now.

Ok, thanks for the update.  I'll send the latest version to -fsdevel.

--D

