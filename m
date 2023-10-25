Return-Path: <linux-fsdevel+bounces-1208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BCF7D75F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 22:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2ED281D2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA21D6A8;
	Wed, 25 Oct 2023 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/hg1NBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B9883B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 20:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6863DC433C7;
	Wed, 25 Oct 2023 20:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698266793;
	bh=o702EcOFL0DAfS7XE8JGuacE5VsTaHhEKgHL1MQiy4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/hg1NBH2ShtcRDxZr/yWoVFf4sAKBHbv/wuOs84xuFdjpGUvYi79LX0g3bd7a12z
	 F79yZhzApQi4HrQfHxH/VVNJoBygTbI94Jb3UAN9Y3x9uR8252+w951E72CETS/Y6+
	 ANPu5h0y6ShCyVbGHoDZdclI4GqInFLXk7XFAZ2tIK4NySk716JC/bnynU3cHUbInF
	 nlfg4VLiRcFXtvnh7Zx5IuqowhvzyJenSxDWv+l9Pf5Ihv0d64EMR1vC+0bN9TRRRz
	 ZWe4NeYdSdgJFCRsvxf2Vmcj8QKSxKo/6HYWuxYRA3TU5jVW3n04wndqGtA41frjih
	 NCqaqLWKMzLlw==
Date: Wed, 25 Oct 2023 22:46:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] fs,block: yield devices
Message-ID: <20231025-ersuchen-restbetrag-05047ba130b5@brauner>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
 <20231025172057.kl5ajjkdo3qtr2st@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025172057.kl5ajjkdo3qtr2st@quack3>

On Wed, Oct 25, 2023 at 07:20:57PM +0200, Jan Kara wrote:
> Hello!
> 
> On Tue 24-10-23 16:53:38, Christian Brauner wrote:
> > This is a mechanism that allows the holder of a block device to yield
> > device access before actually closing the block device.
> > 
> > If a someone yields a device then any concurrent opener claiming the
> > device exclusively with the same blk_holder_ops as the current owner can
> > wait for the device to be given up. Filesystems by default use
> > fs_holder_ps and so can wait on each other.
> > 
> > This mechanism allows us to simplify superblock handling quite a bit at
> > the expense of requiring filesystems to yield devices. A filesytems must
> > yield devices under s_umount. This allows costly work to be done outside
> > of s_umount.
> > 
> > There's nothing wrong with the way we currently do things but this does
> > allow us to simplify things and kills a whole class of theoretical UAF
> > when walking the superblock list.
> 
> I'm not sure why is it better to create new ->yield callback called under
> sb->s_umount rather than just move blkdev_put() calls back into
> ->put_super? Or at least yielding could be done in ->put_super instead of

The main reason was to not call potentially expensive
blkdev_put()/bdev_release() under s_umount. If we don't care about this
though then this shouldn't be a problem. And yes, then we need to move
blkdev_put()/bdev_release() under s_umount including the main block
device. IOW, we need to ensure that all bdev calls are done under
s_umount before we remove the superblock from the instance list. I think
that should be fine but I wanted to propose an alternative to that as
well: cheap mark-for-release under s_umount and heavy-duty without
s_umount. But I guess it doesn't matter because most filesystems did use
to close devices under s_umount before anyway. Let me know what you
think makes the most sense.

