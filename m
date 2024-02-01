Return-Path: <linux-fsdevel+bounces-9880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5B7845AA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329CA1F2B13C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C815F496;
	Thu,  1 Feb 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+D9e2B7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007035D473;
	Thu,  1 Feb 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799058; cv=none; b=lWcngNYWzzrQ0aDDLmICqGvClvBABgi6XKFA1W8exGj3iAzhoTt2qFEFFREwUwRPFIhngR2j2uUpltVOzL7KdlDWrTlAwuUa67EIig1iH/4BGhPHV8l8OGKvWmKUoDuK3IgvakVW9ZBfO/7qzQoKsa+wHrsfmg8c1+sbg4WY7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799058; c=relaxed/simple;
	bh=6ZP4ILSH3sHKouVfD5rz+cyjpyuhzY7rd08gcAXRg4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEK1Oeiw+JCRXYACT0Jrb3dqciATacjNL2n1hvDlfHu5ov6ImHtwzmb/txYBkyBZptbLb2LQ7Rm3NlQ84l1PKhyon4h3UIUnlrouTLDbfQ38xydyqJCXgt7A91zoRJ8dgAOml0oLYHiS+j75fy6uKZmfB9KIWkLBRjIWP91xhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+D9e2B7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0A9C433F1;
	Thu,  1 Feb 2024 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706799057;
	bh=6ZP4ILSH3sHKouVfD5rz+cyjpyuhzY7rd08gcAXRg4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+D9e2B7NrKoYRLkRGXCI1kztOJ2S75aCH07uKUqtnRSEzykV7MZBA0LXDXR9/V4v
	 4msRcXVDS0lTf9PN21svgQ8ePDjHId95ngbUHQINRUGcYc5Us/3L3Ibl2y6CwpWR8b
	 KGjzrY+PGZwjs3CytR5r3BGJNlHsc+v/MvFKxqk+zutLlelFsRTFfLapR5g1ByjNER
	 gSDAbA1s8znuxIAmHEJ0+gN81qLwRchbaA+nS7HCHsWGifQOCe2fj4TyNVhe31xN0A
	 9iUmwMDIOjwqjvIpRtlWXsmv6XLL4mqvebzgkEhWM/GwZfj6pStaOgo1ZwhmShzPol
	 d196VeczOgyiw==
Date: Thu, 1 Feb 2024 15:50:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 29/34] bdev: make struct bdev_handle private to the
 block layer
Message-ID: <20240201-exkurs-august-7c66264fb6aa@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
 <20240129162203.GI3416@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129162203.GI3416@lst.de>

On Mon, Jan 29, 2024 at 05:22:03PM +0100, Christoph Hellwig wrote:
> > +	ret = devcgroup_check_permission(
> > +		DEVCG_DEV_BLOCK, MAJOR(dev), MINOR(dev),
> > +		((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
> > +			((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));
> 
> Somewhat weird formatting here with DEVCG_DEV_BLOCK not on the
> same line as the opening brace and the extra indentation after
> the |.  I would have expected something like:
> 
> 	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
> 		MAJOR(dev), MINOR(dev),
> 		((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
> 		((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));

Fixed. (Fwiw, this is due to clang-format.)

