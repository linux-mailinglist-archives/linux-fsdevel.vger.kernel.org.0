Return-Path: <linux-fsdevel+bounces-22359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0EC9169C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373DC1F2740B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEFE16F0F6;
	Tue, 25 Jun 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDOUYB3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348EA16F0ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324051; cv=none; b=A+G/MWXwAJSXWPntxGghGWSd/+c+lB8zEC931ss2qR83sBF2Tw+awkeVs2IZvbyClCplwYeGVPuXakBu6Ap5PBbxtZM7E3FS4QgFb4Z9P2PPfRJ9krJ75vxmxbySD7mEZGI99Op00FWYuAnxJwNLGaWaPKQA3OCCIdDNmxCCxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324051; c=relaxed/simple;
	bh=Xg912rQOY4Oe5cp1iKfbQihVPppy84gY//03zXOQSRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJjJ/OXklggOu0mWrHrpcLzR2s38oXLlu/kOGQXyfvS5SFpXeKgAVLE7Nq4ewx/eMMJegJVCJ/h98mdlM0W3nQFINqwgMJWJuPSC9cYjSYeGPoW+XT/v/oCb9PqrOCZrOhuMIAjoXj0I4hU8+NRT8e3CngfTWPBADFBvVHVGKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDOUYB3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75305C32786;
	Tue, 25 Jun 2024 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719324050;
	bh=Xg912rQOY4Oe5cp1iKfbQihVPppy84gY//03zXOQSRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDOUYB3UPTv8jy/DY+Lvl6dMzjcx3bBuRxQNqsPmRbna9ocXaLkKi3nw+cXSz2azf
	 LpE4Sse2c0DbJDF37nGM49cwfS0tGgfmz1jL4lfYu9+r/kHtydMAU9g3pvu9kkIFuA
	 OWtfOrpXICktYc60I8GRgChWVmzEGxilZCw5BGTD2jhb/9zukHZowee7u8H7oEtcre
	 UAV3s2+Q0CxmqAmbqm2CTZ4ahKunX0i5DXhF1lPAOefVbBXvhXDBVYOOEGhekMh2Cx
	 odistk/dtC8ZbvvzNdVBvhlUX/3vptGZmg2G12xLKysVvy+8Aj8LEVgbT/we/XKsfF
	 y2Vcs7JSTXKeQ==
Date: Tue, 25 Jun 2024 16:00:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Subject: Re: [PATCH 0/8] Support foreign mount namespace with
 statmount/listmount
Message-ID: <20240625-affront-lockvogel-402517828b05@brauner>
References: <cover.1719243756.git.josef@toxicpanda.com>
 <c524f7f9546407c912d053e2fe516877fb41aec7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c524f7f9546407c912d053e2fe516877fb41aec7.camel@kernel.org>

On Tue, Jun 25, 2024 at 09:37:14AM GMT, Jeff Layton wrote:
> On Mon, 2024-06-24 at 11:49 -0400, Josef Bacik wrote:
> > Hello,
> > 
> > Currently the only way to iterate over mount entries in mount namespaces that
> > aren't your own is to trawl through /proc in order to find /proc/$PID/mountinfo
> > for the mount namespace that you want.  This is hugely inefficient, so extend
> > both statmount() and listmount() to allow specifying a mount namespace id in
> > order to get to mounts in other mount namespaces.
> > 
> > There are a few components to this
> > 
> > 1. Having a global index of the mount namespace based on the ->seq value in the
> >    mount namespace.  This gives us a unique identifier that isn't re-used.
> > 2. Support looking up mount namespaces based on that unique identifier, and
> >    validating the user has permission to access the given mount namespace.
> > 3. Provide a new ioctl() on nsfs in order to extract the unique identifier we
> >    can use for statmount() and listmount().
> > 
> > The code is relatively straightforward, and there is a selftest provided to
> > validate everything works properly.
> > 
> > This is based on vfs.all as of last week, so must be applied onto a tree that
> > has Christians error handling rework in this area.  If you wish you can pull the
> > tree directly here
> > 
> > https://github.com/josefbacik/linux/tree/listmount.combined
> > 
> > Christian and I collaborated on this series, which is why there's patches from
> > both of us in this series.
> > 
> > Josef
> > 
> > Christian Brauner (4):
> >   fs: relax permissions for listmount()
> >   fs: relax permissions for statmount()
> >   fs: Allow listmount() in foreign mount namespace
> >   fs: Allow statmount() in foreign mount namespace
> > 
> > Josef Bacik (4):
> >   fs: keep an index of current mount namespaces
> >   fs: export the mount ns id via statmount
> >   fs: add an ioctl to get the mnt ns id from nsfs
> >   selftests: add a test for the foreign mnt ns extensions
> > 
> >  fs/mount.h                                    |   2 +
> >  fs/namespace.c                                | 240 ++++++++++--
> >  fs/nsfs.c                                     |  14 +
> >  include/uapi/linux/mount.h                    |   6 +-
> >  include/uapi/linux/nsfs.h                     |   2 +
> >  .../selftests/filesystems/statmount/Makefile  |   2 +-
> >  .../filesystems/statmount/statmount.h         |  46 +++
> >  .../filesystems/statmount/statmount_test.c    |  53 +--
> >  .../filesystems/statmount/statmount_test_ns.c | 360 ++++++++++++++++++
> >  9 files changed, 659 insertions(+), 66 deletions(-)
> >  create mode 100644 tools/testing/selftests/filesystems/statmount/statmount.h
> >  create mode 100644 tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> > 
> 
> 
> Nice work! I had a minor question about the locking, but this all looks
> pretty straightfoward.
> 
> As a side question. Is there any progress on adding proper glibc
> bindings for the new syscalls? We'll want to make sure they incorporate
> this change, if that's being done.

Not that I'm aware of but it's probably less urgent than the libmount
support that's being added right now.

> 
> Extending listmount() and statmount() via struct mnt_id_req turns out
> to be pretty painless. Kudos to whoever designed that part of the
> original interfaces!

I'm glad you like it. I do really enjoy the extensible struct design we
came up with a couple of years ago.

