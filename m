Return-Path: <linux-fsdevel+bounces-37871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9BD9F831E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CBA7A1858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04C91A38F9;
	Thu, 19 Dec 2024 18:19:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7A1A0BE1;
	Thu, 19 Dec 2024 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632387; cv=none; b=dUlt2Gn0GVJJ75Cyh6TAPWRchnxAeiZsSp9KZMrkTKfuAtrGkWYaaD8jcWnwc6iWmbo1W5xMuhryXaBDW1uHjCOTO8rEQDYoDMYpNoYHygxPGTPGLQrirJMdGiA8XOOrOse6UE5oi6Jcd3vnHzReUvSTzBR20XlVtN1r5YINt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632387; c=relaxed/simple;
	bh=ow+M+O1HwmvrWNa0hxfDZEDfSDdhwskq/NeOF7nX8Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKY3DkMZtDyMpyEh/4qOStkXoX+MYMCxLe2qQIf/jnhSCloktJJiE96EQEHiQs48jKuWPws1jHs0B/vAeFBp43qoChpXmHuUaB7X1i9rEIYev0JzonOwRboXJYXImKBIILGbhYNTuqszB3SpPRlUswJVQnArbkUdbNBCx0NqNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBBA768AA6; Thu, 19 Dec 2024 19:19:39 +0100 (CET)
Date: Thu, 19 Dec 2024 19:19:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/10] iomap: split bios to zone append limits in the
 submission handlers
Message-ID: <20241219181939.GA1086@lst.de>
References: <20241219173954.22546-1-hch@lst.de> <20241219173954.22546-5-hch@lst.de> <20241219181725.GD6156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219181725.GD6156@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 19, 2024 at 10:17:25AM -0800, Darrick J. Wong wrote:
> On Thu, Dec 19, 2024 at 05:39:09PM +0000, Christoph Hellwig wrote:
> > Provide helpers for file systems to split bios in the direct I/O and
> > writeback I/O submission handlers.
> > 
> > This Follows btrfs' lead and don't try to build bios to hardware limits
> > for zone append commands, but instead build them as normal unconstrained
> > bios and split them to the hardware limits in the I/O submission handler.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I wonder what iomap_split_ioend callsites look like now that the
> alloc_len outparam from the previous version is gone, but I guess I'll
> have to wait to see that.

The initial callsite in XFS looks like this now:

http://git.infradead.org/?p=users/hch/xfs.git;a=blob;f=fs/xfs/xfs_zone_alloc.c;h=00b4df1e628f5d65c7aba44326e5f62306ffbd98;hb=refs/heads/xfs-zoned-rebase#l790

