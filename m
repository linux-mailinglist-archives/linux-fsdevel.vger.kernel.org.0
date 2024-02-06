Return-Path: <linux-fsdevel+bounces-10419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CBE84ADC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 06:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C231F2430A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 05:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9C79DB8;
	Tue,  6 Feb 2024 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5MVO7jo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729912C198;
	Tue,  6 Feb 2024 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196134; cv=none; b=q6s2bAb82ZuxfafzlIlLm+mGkDovd6+a3f6o9K7V3jc7vj01+Nq2Ga7PGAPZVfSOZKHf9DgRzmUxK1i5NtTXKulJ1wI0LfZJNeTdNx8nGaZVJqsx9HGR1Cjcc5eYZYuRzTYn/+b88sIjeU3Dly7se0UGv63oE6Q3AFlzhEvYNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196134; c=relaxed/simple;
	bh=ZkVEvsocOXUNRQIbNjEb427Cp+yaS5VqUefYcCYe230=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKNOQDgFSeVccDdjE89yPE3fohKIwZyvG6slDgrqTUZOpp3rOjLl1wNpVQYV7zSF2ONlhilSkFf51qL3z+ny20xo6n+EvyyoWsoTAFHyVYypYQSpkLOyVevQE1VoNWOETzKwLJeN7UUO4yu/CT8NRSt7wuTD581id5Yx2LX/P5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5MVO7jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8F6C433F1;
	Tue,  6 Feb 2024 05:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707196133;
	bh=ZkVEvsocOXUNRQIbNjEb427Cp+yaS5VqUefYcCYe230=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5MVO7joC+5Gc7rfvwnRUU3GJ2aa66Q41iB4kiddKY0U+qEJ2Yvqs8g1P7iDSJ4pr
	 eKz7uHemm0wajqLRP89RDLyLwm+4FHa1sWgtFliWOA7DihocGjTjIHvNJkO38P4+RG
	 5taFwbz+uuzz61iAEGDiqU5wtpuTn4S/632achsSHuZU8guWP7WTceVoY0JL6E2RYu
	 P4IyWrqCriEPjATzxS5i+FgSfsVHEkIbwnEeRc4Jbq/nwS0cItbWJmtwElbEZ5IF1c
	 awIkL701K9EO5QbCmnyJEQ86DhGeNIAOdi/J4yLPXVdSCANgFJnZIfoc3zmCIThvaD
	 tz5aYqdUOEToA==
Date: Mon, 5 Feb 2024 21:08:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, dsterba@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 4/6] fs: FS_IOC_GETSYSFSNAME
Message-ID: <20240206050853.GQ616564@frogsfrogsfrogs>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-5-kent.overstreet@linux.dev>
 <20240205222732.GO616564@frogsfrogsfrogs>
 <7si54ajkdqbauf2w64xnzfdglkokifgsjptmkxwdhgymxpk353@zf6nfn53manb>
 <20240206013931.GK355@twin.jikos.cz>
 <ca885dd8-4ac1-43a9-9b0c-79b63cae0620@infradead.org>
 <xutnab3bbeeyp7gq2wwy36lus275d5tapdclmcg5sl7bfngo6a@ek5u4ja56gut>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xutnab3bbeeyp7gq2wwy36lus275d5tapdclmcg5sl7bfngo6a@ek5u4ja56gut>

On Mon, Feb 05, 2024 at 11:33:11PM -0500, Kent Overstreet wrote:
> On Mon, Feb 05, 2024 at 08:20:10PM -0800, Randy Dunlap wrote:
> > 
> > 
> > On 2/5/24 17:39, David Sterba wrote:
> > > On Mon, Feb 05, 2024 at 05:43:37PM -0500, Kent Overstreet wrote:
> > >> On Mon, Feb 05, 2024 at 02:27:32PM -0800, Darrick J. Wong wrote:
> > >>> On Mon, Feb 05, 2024 at 03:05:15PM -0500, Kent Overstreet wrote:
> > >>>> @@ -231,6 +235,7 @@ struct fsxattr {
> > >>>>  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> > >>>>  #define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
> > >>>>  #define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
> > >>>> +#define FS_IOC_GETFSSYSFSNAME		_IOR(0x94, 53, struct fssysfsname)
> > >>>
> > >>> 0x94 is btrfs, don't add things to their "name" space.
> > >>
> > >> Can we please document this somewhere!?
> > >>
> > >> What, dare I ask, is the "namespace" I should be using?
> > > 
> > > Grep for _IOCTL_MAGIC in include/uapi:
> > > 
> > > uapi/linux/aspeed-lpc-ctrl.h:#define __ASPEED_LPC_CTRL_IOCTL_MAGIC 0xb2
> > > uapi/linux/aspeed-p2a-ctrl.h:#define __ASPEED_P2A_CTRL_IOCTL_MAGIC 0xb3
> > > uapi/linux/bt-bmc.h:#define __BT_BMC_IOCTL_MAGIC        0xb1
> > > uapi/linux/btrfs.h:#define BTRFS_IOCTL_MAGIC 0x94
> > > uapi/linux/f2fs.h:#define F2FS_IOCTL_MAGIC              0xf5
> > > uapi/linux/ipmi_bmc.h:#define __IPMI_BMC_IOCTL_MAGIC        0xB1
> > > uapi/linux/pfrut.h:#define PFRUT_IOCTL_MAGIC 0xEE
> > > uapi/rdma/rdma_user_ioctl.h:#define IB_IOCTL_MAGIC RDMA_IOCTL_MAGIC
> > > uapi/rdma/rdma_user_ioctl_cmds.h:#define RDMA_IOCTL_MAGIC       0x1b
> > > 
> > > The label ioctls inherited the 0x94 namespace for backward
> > > compatibility but as already said, it's the private namespace of btrfs.
> > > 
> > 
> > or more generally, see Documentation/userspace-api/ioctl/ioctl-number.rst.
> > 
> > For 0x94, it says:
> > 
> > 0x94  all    fs/btrfs/ioctl.h                                        Btrfs filesystem
> >              and linux/fs.h                                          some lifted to vfs/generic
> 
> You guys keep giving the same info over and over again, instead of
> anything that would be actually helpful...
> 
> Does anyone know what the proper "namespace" is for new VFS level
> ioctls?
> 
> ...Anyone?

I propose you use 0x15 (NAK) and add it to the Documentation/ as the
official VFS ioctl namespace. ;)

--D

