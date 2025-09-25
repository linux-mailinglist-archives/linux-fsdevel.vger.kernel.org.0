Return-Path: <linux-fsdevel+bounces-62803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F4FBA124A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 21:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15A304E2D0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA313635E;
	Thu, 25 Sep 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck+3DGWu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2022367D2;
	Thu, 25 Sep 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758827853; cv=none; b=FwOBtri4CSfa7CrAoBCKavDXucC0d0OFbngOYDsYagSKyZrr4fejC3LviXH1X0b1BgK6DodW2GdkE1AldGvxgV9zOU5ZGxjNwkuk4VxE010aZaF3BQbaX1IpEcQuiPqvFzqpzYB7OFkZbanIvqNkTaVx7nwEiKqeitaQYy7DfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758827853; c=relaxed/simple;
	bh=qYmTRlf2w+gXgULOx0tRCwzsF7coFT9V078i5CXXgpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBNR35142ybor7gkHPQFyd+N4g1hONJrWpX4959l4uE2oQaKHlzjKEBtllg73awAnc+7iLIlJbRqnaLfbMatXe8trwJzGPNGCZ82hjSkiASaQyy45XcHmTFjiuIx6kVTK2YPyDpGdhrd51M873k+SMudXfDqJnZUriSUUuJ4gN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck+3DGWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7E8C4CEF0;
	Thu, 25 Sep 2025 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758827852;
	bh=qYmTRlf2w+gXgULOx0tRCwzsF7coFT9V078i5CXXgpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ck+3DGWu/o6kz0M3FW3fduAkwUs1EZLytBadi6UqqQuFbVQ/6xUOLPulIst2Ow5z6
	 z1Aj9vM3ewN0VFDXCsPHPaJA28UGH1gXoFOiCjI98md1pmuxzUfPTwgdDT65huZPI8
	 CXT9BEmbqDzVsVnUvrzIqKBpP0BsCMhAJ+U39cezfbJ3PlagxkXqQje+P9Vu35+zfA
	 KXc5zAlng8R6Wb61bcEp9vILFmv8sFEZsHU96WwXQIJxQTu3yQwXHkcED3DavHNOpA
	 uWPymHlMCSIL0jsQYHZW8Ahx5FdTB3VuDXqyOylZjduZXxyMGFDnlsL114AHmyPK7k
	 VTnVPqVadFmcg==
Date: Thu, 25 Sep 2025 12:17:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com,
	linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev
Subject: Re: [PATCH 4/8] fuse: signal that a fuse filesystem should exhibit
 local fs behaviors
Message-ID: <20250925191732.GY8096@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150113.381990.4002893785000461185.stgit@frogsfrogsfrogs>
 <CAJnrk1YWtEJ2O90Z0+YH346c3FigVJz4e=H6qwRYv7xLdVg1PA@mail.gmail.com>
 <20250918165227.GX8117@frogsfrogsfrogs>
 <CAJfpegt6YzTSKBWSO8Va6bvf2-BA_9+Yo8g-X=fncZfZEbBZWw@mail.gmail.com>
 <20250919175011.GG8117@frogsfrogsfrogs>
 <CAJfpegu3+rDDxEtre-5cFc2n=eQOYbO8sTi1+7UyTYhhyJJ4Zw@mail.gmail.com>
 <20250923205143.GH1587915@frogsfrogsfrogs>
 <CAJfpeguq-kyMVoc2-zxHhwbxAB0g84CbOKM-MX3geukp3YeYuQ@mail.gmail.com>
 <20250924173136.GN8117@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924173136.GN8117@frogsfrogsfrogs>

On Wed, Sep 24, 2025 at 10:31:36AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 24, 2025 at 03:55:48PM +0200, Miklos Szeredi wrote:
> > On Tue, 23 Sept 2025 at 22:51, Darrick J. Wong <djwong@kernel.org> wrote:
> > 
> > > Oh, ok.  I can do that.  Just to be clear about what I need to do for
> > > v6:
> > >
> > > * fuse_conn::is_local goes away
> > > * FUSE_I_* gains a new FUSE_I_EXCLUSIVE flag
> > > * "local" operations check for FUSE_I_EXCLUSIVE instead of local_fs
> > > * fuseblk filesystems always set FUSE_I_EXCLUSIVE
> > 
> > Not sure if we want to touch fuseblk, as that carries a risk of regressions.
> 
> Hrm.  As it stands today, setting FUSE_I_EXCLUSIVE in fuseblk mode
> solves various mode/acl failures in fstests.
> 
> On the other hand, mounting with fuseblk requires fsname to point to a
> block device that the mount()ing process can open, and if you're working
> with a local filesystem on a block device, why wouldn't you use iomap
> mode?
> 
> Add to that Ted's reluctance to merge the fuseblk support patches into
> fuse2fs, and perhaps I should take that as a sign to abandon fuseblk
> work entirely.  It'd get rid of an entire test configuration, since I'd
> only have to check fuse4fs-iomap on a bdev; and classic fuse4fs on a
> regular file.  Even in that second case, fuse4fs could losetup to take
> advantage of iomap mode.
> 
> Yeah ok I've persuaded myself to drop the fuseblk stuff entirely.  If
> anyone /really/ wants me to keep it, holler in the next couple of hours.

Ted agrees with this, so I'm dropping fuseblk support for fuse[24]fs.

--D

> > > * iomap filesystems (when they arrive) always set FUSE_I_EXCLUSIVE
> > 
> > Yes.
> 
> Ok, thanks for the quick responses! :)
> 
> --D
> 
> > Thanks,
> > Miklos
> 

