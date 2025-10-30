Return-Path: <linux-fsdevel+bounces-66422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E3C1E7CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 07:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC98405599
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B42405E7;
	Thu, 30 Oct 2025 06:00:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89722A4DA;
	Thu, 30 Oct 2025 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804014; cv=none; b=lqIUMVr5WP7ji9+FqGujQdq/kT6qHCVnFQ599Vx90VsZjKORoTnI4K5BD5pUj6NjtXkXcZG810puoGcZfSnlny04fd8diyy8tuBFgAqjoaslMz6ea2n9iouwK496LhmFQvPBx+S8DRZaKWt7y0LbuueoB6+ouaNd6BoQnB9Uc1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804014; c=relaxed/simple;
	bh=ctwx3+rb9rJkXVqtsBwKB1n07eInGCVhx5rO1pQs0W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQmWGPMpEGsnH43iDpI5ai1tfZlvHn+k33mARS5vf2L/iLwi1ag+aRnbQLFh8EUP0EY4sp3CvYr+AQGWoIZWmWvINeUmLg3YKGp0HYH1YyqxOqBoP1z9aq9Cy9+a8R7sOoDRT+/YYEaAkXCXzGrZKr3KyBDAbHuws7GUGNzA7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 31B91227AAA; Thu, 30 Oct 2025 07:00:09 +0100 (CET)
Date: Thu, 30 Oct 2025 07:00:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, miklos@szeredi.hu, brauner@kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20251030060008.GB12727@lst.de>
References: <176169809564.1424591.2699278742364464313.stgit@frogsfrogsfrogs> <176169809588.1424591.6275994842604794287.stgit@frogsfrogsfrogs> <20251029084048.GA32095@lst.de> <20251029143823.GL6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029143823.GL6174@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 29, 2025 at 07:38:23AM -0700, Darrick J. Wong wrote:
> > > However, in the future there could be fuse+iomap filesystems that are
> > > block device based but don't set s_bdev.  In this case, sis::bdev will
> > > be set to NULL when we enter iomap_swapfile_activate, and we can pick
> > > up a bdev from the first iomap mapping that the filesystem provides.
> > 
> > Could, or will be?  I find the way the swapfiles work right now
> > disgusting to start with, but extending that bypass to fuse seems
> > even worse.
> 
> Yes, "Could", in the sense that a subsequent fuse patch wires up sending
> FUSE_IOMAP_BEGIN to the fuse server to ask for layouts for swapfiles,
> and the fuse server can reply with a mapping or EOPNOTSUPP to abort the
> swapon.  (There's a separate FUSE_IOMAP_IOEND req at deactivation time).

Maybe spell that out.

> "Already does" in the sense that fuse already supports swapfiles(!) if
> your filesystem implements FUSE_BMAP and attaches via fuseblk (aka
> ntfs3g).

Yikes.  This is just such an amazingly bad idea.


