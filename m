Return-Path: <linux-fsdevel+bounces-10420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D79884ADD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 06:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5791C22735
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 05:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841487CF16;
	Tue,  6 Feb 2024 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VdauWuR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515BF7C091;
	Tue,  6 Feb 2024 05:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196405; cv=none; b=H6alSxbP+LbhxZbPAk9M8W8DgvYOhXYJikyUxm9C+DQXFDnoYVP4sicykTbUOTA4lcrGDDSDNx9zTiBcqGdGTiEcPo/tOSIT611Qz1j+8KJfe2SeqH0A4noKDcg+ZvxI1O/+vMevbGh8ra8/cJ9yP/QYXt+85jGHpsmGzc1nNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196405; c=relaxed/simple;
	bh=Dx6Og2qKBOC9/kdVvY6Nv9dhBbtczwNYqoJh2KK9vQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVnFCRGl5bgAGBvHETQuV3wFRDuiuCCeNXToZwzyFilfRgY2udM9IbmQBUIaGWAt50QyIYXnbMZf6CNP4a/CZAqOgJB6hmz0MG3U5eIB7kATosDXc7b8RyUtzte97UnkB5GRQslTy0ad579CE6w3+MvX9TD+9X005dPUAWVV9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VdauWuR6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 Feb 2024 00:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707196401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M67dP06bznKXKLynj8t19rv2NZMnEI3pdWkIiizmI8g=;
	b=VdauWuR6rRX/kTjcpWCglj6tRGZomg4I15P8WkjLZyMJhYTFbHhQlv4QODRcKc/vLbyBII
	AbG/gam9CRZVaM2TvvJ6WrOAJxgTSVHdKSjLFgzT9Qe1fQV7C9O5a0ecXElwHBsLtbp2UI
	LDFouBB4MGbZuYM/hLSKuGP8rbON4aE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, dsterba@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 4/6] fs: FS_IOC_GETSYSFSNAME
Message-ID: <bhxmfqyqjkpjtxhyj2w2pnzbx2whnc2qurg2fcjpphuli2lyzc@bea4fzncsnhc>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-5-kent.overstreet@linux.dev>
 <20240205222732.GO616564@frogsfrogsfrogs>
 <7si54ajkdqbauf2w64xnzfdglkokifgsjptmkxwdhgymxpk353@zf6nfn53manb>
 <20240206013931.GK355@twin.jikos.cz>
 <ca885dd8-4ac1-43a9-9b0c-79b63cae0620@infradead.org>
 <xutnab3bbeeyp7gq2wwy36lus275d5tapdclmcg5sl7bfngo6a@ek5u4ja56gut>
 <20240206050853.GQ616564@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206050853.GQ616564@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 05, 2024 at 09:08:53PM -0800, Darrick J. Wong wrote:
> On Mon, Feb 05, 2024 at 11:33:11PM -0500, Kent Overstreet wrote:
> > On Mon, Feb 05, 2024 at 08:20:10PM -0800, Randy Dunlap wrote:
> > > 
> > > 
> > > On 2/5/24 17:39, David Sterba wrote:
> > > > On Mon, Feb 05, 2024 at 05:43:37PM -0500, Kent Overstreet wrote:
> > > >> On Mon, Feb 05, 2024 at 02:27:32PM -0800, Darrick J. Wong wrote:
> > > >>> On Mon, Feb 05, 2024 at 03:05:15PM -0500, Kent Overstreet wrote:
> > > >>>> @@ -231,6 +235,7 @@ struct fsxattr {
> > > >>>>  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> > > >>>>  #define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
> > > >>>>  #define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
> > > >>>> +#define FS_IOC_GETFSSYSFSNAME		_IOR(0x94, 53, struct fssysfsname)
> > > >>>
> > > >>> 0x94 is btrfs, don't add things to their "name" space.
> > > >>
> > > >> Can we please document this somewhere!?
> > > >>
> > > >> What, dare I ask, is the "namespace" I should be using?
> > > > 
> > > > Grep for _IOCTL_MAGIC in include/uapi:
> > > > 
> > > > uapi/linux/aspeed-lpc-ctrl.h:#define __ASPEED_LPC_CTRL_IOCTL_MAGIC 0xb2
> > > > uapi/linux/aspeed-p2a-ctrl.h:#define __ASPEED_P2A_CTRL_IOCTL_MAGIC 0xb3
> > > > uapi/linux/bt-bmc.h:#define __BT_BMC_IOCTL_MAGIC        0xb1
> > > > uapi/linux/btrfs.h:#define BTRFS_IOCTL_MAGIC 0x94
> > > > uapi/linux/f2fs.h:#define F2FS_IOCTL_MAGIC              0xf5
> > > > uapi/linux/ipmi_bmc.h:#define __IPMI_BMC_IOCTL_MAGIC        0xB1
> > > > uapi/linux/pfrut.h:#define PFRUT_IOCTL_MAGIC 0xEE
> > > > uapi/rdma/rdma_user_ioctl.h:#define IB_IOCTL_MAGIC RDMA_IOCTL_MAGIC
> > > > uapi/rdma/rdma_user_ioctl_cmds.h:#define RDMA_IOCTL_MAGIC       0x1b
> > > > 
> > > > The label ioctls inherited the 0x94 namespace for backward
> > > > compatibility but as already said, it's the private namespace of btrfs.
> > > > 
> > > 
> > > or more generally, see Documentation/userspace-api/ioctl/ioctl-number.rst.
> > > 
> > > For 0x94, it says:
> > > 
> > > 0x94  all    fs/btrfs/ioctl.h                                        Btrfs filesystem
> > >              and linux/fs.h                                          some lifted to vfs/generic
> > 
> > You guys keep giving the same info over and over again, instead of
> > anything that would be actually helpful...
> > 
> > Does anyone know what the proper "namespace" is for new VFS level
> > ioctls?
> > 
> > ...Anyone?
> 
> I propose you use 0x15 (NAK) and add it to the Documentation/ as the
> official VFS ioctl namespace. ;)

Done!

