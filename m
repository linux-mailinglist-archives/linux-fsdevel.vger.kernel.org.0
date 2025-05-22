Return-Path: <linux-fsdevel+bounces-49690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA05BAC11E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 19:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C34B3B669C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEEB187876;
	Thu, 22 May 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgA+57qz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B081754B;
	Thu, 22 May 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933918; cv=none; b=X55WKXRbkEdoOrfZg1SDpNW4/b0/pbLHgSqH/0qG69s21q6EEB5O1ATO4zflJkOFZ/X3aIhmnl4mMreW+7CDvRwEi/np44KeQijYYlZ7AcTnwE/YSsOGvbCD0wLvD/AWn4MCZBE3ZURKkrOEoJXwYVLEtn7LFI2MOJIbt1zc6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933918; c=relaxed/simple;
	bh=jGYIfNVGbFzKODRChUtAuUMDzI3h+YZn1w7YkGo2W14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEWMxhijRPFWQHHR/cyKPaxo3sQw6pPkknJ+drUGSxQ18y5MAVbOTR/r0swCVCpKKQHW0ZYqnzMFSUi8rhlQteSTWMi+r/0t/+Mw97uBE3DIVoa8hxthiscE6MVBleLkEWOdim3BtYWVnTXSP8GMo/y7JWnhRm7ef9czF6nbAlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgA+57qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC78C4CEE4;
	Thu, 22 May 2025 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747933917;
	bh=jGYIfNVGbFzKODRChUtAuUMDzI3h+YZn1w7YkGo2W14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgA+57qz5NxaIMgCStA55rr0GxsGIcCNy/6s2uJJ64FvOxp3Ob6SOd58/DuDZnzcA
	 gLwsxTJSlsy/0tE19LFxtmmGfXXL0sls3KV4ZOQWopzpRdfECe9Eax50AotWJdlhiE
	 MGy6k4cYZBm3DsgZgv4FTo2HXhN1Y7yYjo7ftulgcb5X+N9i1PoqNP0SK99UJHRgqM
	 7cgA0cq09YxfWZ1NhvXVjaWVqFaXBsEF8vZd1RwMl8+ur3U9VBRI7mCPmIxbn52HnP
	 B6VrF+ZmnjNjVhCikdmYd49vkETxgcy9ZJfQfc8diAB2chpodU7OSEeYXO7VLHqujg
	 eisXyTjv7I1Ww==
Date: Thu, 22 May 2025 10:11:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
	joannelkoong@gmail.com, linux-xfs@vger.kernel.org,
	bernd@bsbernd.com, John@groves.net
Subject: Re: [PATCH 04/11] fuse: add a notification to add new iomap devices
Message-ID: <20250522171156.GI9730@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
 <174787195651.1483178.3420885441625089259.stgit@frogsfrogsfrogs>
 <CAOQ4uxiZTTEOs4HYD0vGi3XtihyDiQbDFXBCuGKoJyFPQv_+Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiZTTEOs4HYD0vGi3XtihyDiQbDFXBCuGKoJyFPQv_+Lw@mail.gmail.com>

On Thu, May 22, 2025 at 06:46:14PM +0200, Amir Goldstein wrote:
> On Thu, May 22, 2025 at 2:03 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Add a new notification so that fuse servers can add extra block devices
> > to use with iomap.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

<snip>

> > +int fuse_iomap_add_device(struct fuse_conn *fc,
> > +                         const struct fuse_iomap_add_device_out *outarg)
> > +{
> > +       struct file *file;
> > +       int ret;
> > +
> > +       if (!fc->iomap)
> > +               return -EINVAL;
> > +
> > +       if (outarg->reserved)
> > +               return -EINVAL;
> > +
> > +       CLASS(fd, somefd)(outarg->fd);
> > +       if (fd_empty(somefd))
> > +               return -EBADF;
> > +       file = fd_file(somefd);
> > +
> > +       if (!S_ISBLK(file_inode(file)->i_mode))
> > +               return -ENODEV;
> > +
> > +       down_read(&fc->killsb);
> > +       ret = __fuse_iomap_add_device(fc, file);
> > +       up_read(&fc->killsb);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return put_user(ret, outarg->map_dev);
> > +}
> 
> This very much reminds of FUSE_DEV_IOC_BACKING_OPEN
> that gives kernel an fd to remember for later file operations.
> 
> FUSE_DEV_IOC_BACKING_OPEN was implemented as an ioctl
> because of security concerns of passing an fd to the kernel via write().
> 
> Speaking of security concerns, we need to consider if this requires some
> privileges to allow setting up direct access to blockdev.

Yeah, I was assuming that if the fuse server can open the bdev, then
that's enough.  But I suppose I at least need to check that it's opened
in write mode too.

> But also, apart from the fact that those are block device fds,
> what does iomap_conn.files[] differ from fc->backing_files_map?

Oh, so that's what that does!  Yes, I'd rather pile on to that than
introduce more ABI. :)

> Miklos had envisioned this (backing blockdev) use case as one of the
> private cases of fuse passthrough.
> 
> Instead of identity mapping to backing file created at open time
> it's extent mapping to backing blockdev created at data access time.
> 
> I am not saying that you need to reuse anything from fuse passthrough
> code, because the use cases probably do not overlap, but hopefully,
> you can avoid falling into the same pits that we have already managed to avoid.

<nod> The one downside is that fsiomap requires the file to point at
either a block device or (in theory) a dax device, so we'd have to check
that on every access.  But aside from that I think I could reuse this
piece.  Thanks for bringing that to my attention! :)

--D

> Thanks,
> Amir.

