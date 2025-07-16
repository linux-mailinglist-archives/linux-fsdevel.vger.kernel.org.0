Return-Path: <linux-fsdevel+bounces-55162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF438B07687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 15:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEE6188AD4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1555D2F2708;
	Wed, 16 Jul 2025 13:02:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7428C2CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670927; cv=none; b=s7ZGed8xfd5wO+834XtM5+INcWALtrytvr1MbplvoB5z4ARUvSgv5j8FGpVUwHY4Ma5n3sHnFzx0vQ1WW9BV4cyOBluhTfZTBTDCp1tGYiBFfYjFRHCEJr8aqQzf0Q03jWF5CKCRNejiBlZOM7clEW7914GBLGPlWKFTJfZYnVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670927; c=relaxed/simple;
	bh=WiQnItvsT8OTJGmLvdpqXqWwA1h+bVhFMNV/PV91XrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0Sd1Y1m+6KyloXUU2WE/djwW0zGdSFhq1vphxyed1WsH3+sP5FBCwl0zrJEOaisUBL7wey9bKyez72mt3CfP5n2jV+sv3pYPcQBzbys0bKiX2FNVto4hnREjmtXsZxWS9wre+tv49GV1t6XmTV9iysrhbmb5kcXJGAoKkfiWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E828668BEB; Wed, 16 Jul 2025 15:02:00 +0200 (CEST)
Date: Wed, 16 Jul 2025 15:02:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250716130200.GA5553@lst.de>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org> <aHZ9H_3FPnPzPZrg@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHZ9H_3FPnPzPZrg@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 15, 2025 at 05:09:03PM +0100, Matthew Wilcox wrote:
> will be harder, we have to get to 604 bytes.  Although for my system if
> we could get xfs_inode down from 1024 bytes to 992, that'd save me much
> more memory ;-)

There's some relatively low hanging fruit there.

One would be to make the VFS inode i_ino a u64 finally so that XFS
and other modern files systems an stop having their own duplicate of
it (which would also remove tons of code in various file systems).

i_mount could be replaced by going to the VFS inode i_sb, and from
that to the xfs mount.  That would be nicer if the sb was embeeded
into the fs structure to reduce the pointer chasing, though.

і_pincount could move into the xfs_inode_log_item, as it is only
needed for inodes that got logged.

i_ioend_lock and i_ioend_list (24 bytes) could be replaced with
a llist_node (8 bytes).  All the i_ioend fields are only used for
inodes that are written to.  We could move them into the inode
log item, which would then also be allocated for inodes that are
only purely overwritten and not actually logged.

