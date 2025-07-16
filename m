Return-Path: <linux-fsdevel+bounces-55136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F925B07230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 11:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74889580C2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67112F1FF7;
	Wed, 16 Jul 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWO5aqVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A1275860
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659456; cv=none; b=soB4hcKAks2nTj4fD9dRHJqpOa60Vy34T1DOP4nsd+cFnStneJkxSyfdAxvkT+FqNmDK13+blX660IbFGR3IXkH3OvAF3K7LVFLLiJt5a6ksYqUX0oDEn/yUO2e/g6b10kca5IecR7MH9kE0CGo4ZWnztWmPk3gO2RIjoqhybmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659456; c=relaxed/simple;
	bh=iww99ld8Nie3T5twZ4OICKVu4AxK/dMostlaCnjqH30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMwgx0DesKBrNjqzlOKqSR9eSMSZIaIrSQAkGkTNw9Y5uVkzCbWBCTVhOLB27U6tXxWZaqP8jseui1mTh/Qw7u2rb+i0iNWZGh6BANPtRbXVVXVQ9+lnPafj5DDIaDwA4hZ58LvzEGhBCrUivykCD235xvtrwinLse4pAG+lZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWO5aqVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD22C4CEF0;
	Wed, 16 Jul 2025 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752659455;
	bh=iww99ld8Nie3T5twZ4OICKVu4AxK/dMostlaCnjqH30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWO5aqVbksAmuCuOOQxZHKlkGRvgvh3LvPqPnxcWr9GbCAV8ecLLdKkkdhXKbjn9Y
	 rCCewcmfMlKM1SvaPa9OzvFyXRpmGmKgXieThHdk3NfORldR4SWWtu4E8gEjazb22w
	 uO1WC4Ie3g8iqejeHbvPlOM8NQ6Z5T5IQrZVtdnYbgRnvbTGXF+Ksa1wxOLwfKOVPA
	 appk45HlZPHwnb5Tau5CHaqoCI3s6TVVV+XOk6qvkH47m5b0hQYek2WOeKmgIKVIZn
	 31dcLzZPbaoqf5lX1EhQAztJ7ItpRx8k74r32/f4bEEivOZcLZPpYYXjAygFChUUjo
	 Ut9rJT/j3ldHw==
Date: Wed, 16 Jul 2025 11:50:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250716-effizient-reglementieren-16aff1739580@brauner>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <xophldxjmxls6qrxv6chooo2s4pvrbzmu2iinds3jdpkccvrwg@d5efwc4ivaor>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xophldxjmxls6qrxv6chooo2s4pvrbzmu2iinds3jdpkccvrwg@d5efwc4ivaor>

On Wed, Jul 16, 2025 at 11:15:48AM +0200, Jan Kara wrote:
> On Tue 15-07-25 16:35:24, Christian Brauner wrote:
> > struct inode is bloated as everyone is aware and we should try and
> > shrink it as that's potentially a lot of memory savings. I've already
> > freed up around 8 bytes but we can probably do better.
> > 
> > There's a bunch of stuff that got shoved into struct inode that I don't
> > think deserves a spot in there. There are two members I'm currently
> > particularly interested in:
> > 
> > (1) #ifdef CONFIG_FS_ENCRYPTION
> >             struct fscrypt_inode_info *i_crypt_info;
> >     #endif
> > 
> >     ceph, ext4, f2fs, ubifs
> > 
> > (2) #ifdef CONFIG_FS_VERITY
> >             struct fsverity_info *i_verity_info;
> >     #endif
> > 
> >     btrfs, ext4, f2fs
> > 
> > So we have 4 users for fscrypt and 3 users for fsverity with both
> > features having been around for a decent amount of time.
> > 
> > For all other filesystems the 16 bytes are just wasted bloating inodes
> > for every pseudo filesystem and most other regular filesystems.
> > 
> > We should be able to move both of these out of struct inode by adding
> > inode operations and making it the filesystem's responsibility to
> > accommodate the information in their respective inodes.
> > 
> > Unless there are severe performance penalties for the extra pointer
> > dereferences getting our hands on 16 bytes is a good reason to at least
> > consider doing this.
> > 
> > I've drafted one way of doing this using ext4 as my victim^wexample. I'd
> > like to hear some early feedback whether this is something we would want
> > to pursue.
> > 
> > Build failures very much expected!
> > 
> > Not-Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> I like the concept. I went that way with quota info attached to the inode
> as well. Just for quota info I've put the .get_dquots hook into
> super_operations because in practice all inodes in a superblock have to
> have a common memory layout anyway. OTOH inode_operations are one deference
> closer so maybe they are a better fit? Anyway, all I wanted to say is that

Imho, move it to inode operations. I think that's the better fit for
quotas. It's easier to see what types of actual meaningful filesystem
operations inodes actually support. I'm not to worried about having a
lot of methods on i_op (yet). Thoughts?

