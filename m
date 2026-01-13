Return-Path: <linux-fsdevel+bounces-73382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF781D1743D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3B313041A62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A137FF5E;
	Tue, 13 Jan 2026 08:22:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5F37FF5B;
	Tue, 13 Jan 2026 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292522; cv=none; b=hSojpmpQKnBetsLDOblIl3EcdjO0w7bt5gXnMm/dD1KtX3sAMei0HP9QXNSIbB5ufNUP29Ul+baXHu93XkS486ITOKb+aUHl2GAAk0b9cosEVx/v1kZ2yqLuMpM3h33BPVaZB5SyOdBe6S5wiqg2JJxQtn3j7tNXNp5y2UZmEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292522; c=relaxed/simple;
	bh=Ez7Gw/b9KBWZuEzjd8U20ewpCJDt+YPo4r5oAnRP66Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX02DR2ub+ZpVfvCOTdAolH5qnUbiw5WZfkNyHotNXJLxYAjKxTi07SW+F9G36wZcJbinvQNhxtbzh1ojATGG1JrU+UafhcvCsx8QD/8gMSIWRNMjArYxtH3apQFtt0tABT4gH96wr/yztHgppKVpP+91HvlI/mhoUP+5WiHPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9594B227AA8; Tue, 13 Jan 2026 09:21:58 +0100 (CET)
Date: Tue, 13 Jan 2026 09:21:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 11/22] xfs: add verity info pointer to xfs inode
Message-ID: <20260113082158.GF30809@lst.de>
References: <cover.1768229271.patch-series@thinky> <7s5yzeey3dmnqwz4wkdjp4dwz2bi33c75aiqjjglfdpeh6o656@i32x5x3xfilp> <20260112223938.GM15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112223938.GM15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 02:39:38PM -0800, Darrick J. Wong wrote:
> On Mon, Jan 12, 2026 at 03:51:10PM +0100, Andrey Albershteyn wrote:
> > Add the fsverity_info pointer into the filesystem-specific part of the
> > inode by adding the field xfs_inode->i_verity_info and configuring
> > fsverity_operations::inode_info_offs accordingly.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> 
> I kinda don't like adding another pointer to struct xfs_inode

Me neither.

> but I can't see a better solution.

Well, I suggested just making the fsverity_info a standalone object,
and looking it up using a rhastable based on the ino.  Eric didn't
seem overly existed about that, but I think it would be really helpful
to not bloat all the common inodes for fsverity.


