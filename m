Return-Path: <linux-fsdevel+bounces-66487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A03BC20BFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B12F634F751
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717A127F195;
	Thu, 30 Oct 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVAcSh2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C8280339;
	Thu, 30 Oct 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836043; cv=none; b=mkckmMYWwyDd2QSvncJDY7seGCn7zYCUtUxFW2swpIfj45h09AiPGiW7tidabqXiOTM9g7DSMx5JYNjl/rsirQe2k7FD5h8kc4v5OGOew11l1WbQ07W9y4BH1ALXJEvBfkLZNAUTR3+4dF3vWAQ6466Ch7+WG23r1vxppBH8lYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836043; c=relaxed/simple;
	bh=drLHSEC02D0yr/3ysfWgeMxuedIDEgF+UPiFBRUgmrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPReWK6KgMEBg/ePVMneEmwXvM7tUT+9TmfNtRiNa6D4znSLSg/onNO0PMxt6LDR7DCa8FIZDi4SCTQ/OGVGjJOm/X6h+rMwNyTVlgN9c9Zi8AARA7QyiiHDI5dokKZUIqC013Lm6hiTAAuppzdNjA3WCQ0EUIa4EuePiKI7+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVAcSh2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B00C4CEF1;
	Thu, 30 Oct 2025 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761836043;
	bh=drLHSEC02D0yr/3ysfWgeMxuedIDEgF+UPiFBRUgmrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVAcSh2C6GGrlksscgPR9IidFuWvYd1r0DRrykn0OrALJ+/CYv/gLtAVGTS9YdX54
	 gjy7b5Lvczlokukjj1kqL4VPLGbULtGNSt7iHThfwuHw0t9qbtopKOiLpDIgnrzmkl
	 nvLpF6JSeQ4caIEmnjKrQwnM/fZ63IX0prsjVdiHfRglzQ7BdE60ALsUQnX55m8Dx5
	 MGt1/8NquDsBpvuQY7NTv24YiEugaQXaXl2v4u5sQG+qC6wq09yfCMmAXWUF8tEN1/
	 kg1W3NY3W7mNBTNZJ/D7XlTzdOxmGPx1WKSn+SxCof2P8Xm2+UvAR5KkJv2vtqn+Uo
	 W+Fw8p0L6bA/Q==
Date: Thu, 30 Oct 2025 07:54:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: miklos@szeredi.hu, brauner@kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20251030145402.GV4015566@frogsfrogsfrogs>
References: <176169809564.1424591.2699278742364464313.stgit@frogsfrogsfrogs>
 <176169809588.1424591.6275994842604794287.stgit@frogsfrogsfrogs>
 <20251029084048.GA32095@lst.de>
 <20251029143823.GL6174@frogsfrogsfrogs>
 <20251030060008.GB12727@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030060008.GB12727@lst.de>

On Thu, Oct 30, 2025 at 07:00:08AM +0100, Christoph Hellwig wrote:
> On Wed, Oct 29, 2025 at 07:38:23AM -0700, Darrick J. Wong wrote:
> > > > However, in the future there could be fuse+iomap filesystems that are
> > > > block device based but don't set s_bdev.  In this case, sis::bdev will
> > > > be set to NULL when we enter iomap_swapfile_activate, and we can pick
> > > > up a bdev from the first iomap mapping that the filesystem provides.
> > > 
> > > Could, or will be?  I find the way the swapfiles work right now
> > > disgusting to start with, but extending that bypass to fuse seems
> > > even worse.
> > 
> > Yes, "Could", in the sense that a subsequent fuse patch wires up sending
> > FUSE_IOMAP_BEGIN to the fuse server to ask for layouts for swapfiles,
> > and the fuse server can reply with a mapping or EOPNOTSUPP to abort the
> > swapon.  (There's a separate FUSE_IOMAP_IOEND req at deactivation time).
> 
> Maybe spell that out.

Will do.

> > "Already does" in the sense that fuse already supports swapfiles(!) if
> > your filesystem implements FUSE_BMAP and attaches via fuseblk (aka
> > ntfs3g).
> 
> Yikes.  This is just such an amazingly bad idea.

Swapfiles in general (including doing it via iomap)?  Or just the magic
hooboo of "turn on this fugly bmapping call and bammo the kernel can
take over your file at any time!!" ?

--D

