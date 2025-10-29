Return-Path: <linux-fsdevel+bounces-66200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBED9C193A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8699C3BEA75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B45B3203AF;
	Wed, 29 Oct 2025 08:40:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550E31813F;
	Wed, 29 Oct 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727256; cv=none; b=D3Vy5GQLWE8f1tuagbZa3Uu9YdH7mgUG9DXu33cxjt3+s3Nci0jj9QZ5iWt9cWUKUWuEgTeKOs0kLGXtwH/F5cqJf/7nf+Gi6WNfmNBr4Dhj9uGBrVnxf30DU6XrWSeAiI8qYcbQYRgJ1A50KEwLXTSGWPkKHHGNXs8VnMvZYoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727256; c=relaxed/simple;
	bh=cJ6lGh0X/sfsTenSXdTKo7lZOHBpLhQNyryFxqwBznY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPMCI9uiGRn1q4aL+XbQt9XoEvb/55cr7TQJoo+Ir8sfZ4O76r1V5DHnvEWiNUq9UIrVt5wVqvQnEPgqou0EGuTuLbNVET9mjGQm8zi8yMK2ucmlaN1t1D3+trceL507gCuprkqUM/2nyDO/JXCYrzW8C8oWU3ACafRAupyT4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13ECA227A88; Wed, 29 Oct 2025 09:40:49 +0100 (CET)
Date: Wed, 29 Oct 2025 09:40:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, brauner@kernel.org, linux-ext4@vger.kernel.org,
	hch@lst.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20251029084048.GA32095@lst.de>
References: <176169809564.1424591.2699278742364464313.stgit@frogsfrogsfrogs> <176169809588.1424591.6275994842604794287.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176169809588.1424591.6275994842604794287.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 28, 2025 at 05:44:26PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> All current users of the iomap swapfile activation mechanism are block
> device filesystems.  This means that claim_swapfile will set
> swap_info_struct::bdev to inode->i_sb->s_bdev of the swap file.
> 
> However, in the future there could be fuse+iomap filesystems that are
> block device based but don't set s_bdev.  In this case, sis::bdev will
> be set to NULL when we enter iomap_swapfile_activate, and we can pick
> up a bdev from the first iomap mapping that the filesystem provides.

Could, or will be?  I find the way the swapfiles work right now
disgusting to start with, but extending that bypass to fuse seems
even worse.


