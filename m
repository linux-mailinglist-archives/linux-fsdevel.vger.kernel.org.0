Return-Path: <linux-fsdevel+bounces-60022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9138AB40EEE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 22:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2851A1B644F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 20:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F62E7F20;
	Tue,  2 Sep 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3ycrJTg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD69645C0B
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846657; cv=none; b=vD0JGboCgUuvK3mq73bSWkvtEoadzUabavSF0xZi94546pGAokJQmVnzwO5+8WqCrt66eCGwCxIV6AqLE0Go0N0qW/ypBoMA//pbIKrY2YEK/K0tu2mr8jtLvsB0ZYv1mObxrp9xYyRDfMX798K8JV4Mmosm9OMdL00+mqyE3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846657; c=relaxed/simple;
	bh=peXqS4hyuTtYDPErd9rQ5om7XoXXlrY6I8pVRPFFO3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k33qDD+6cbQLVligWkRjxSkdwDXgp9lRRVFL8TQUpFVT7aNvE9775XYg7QM8L5XKmejkPRLcLlAFEhl6MBmbkpP0UowiMEfgpCIXCiKGCgVg840lzh/Y0VV9mggfzbYR/S28Gqh5+IWf8qFGXClWiXAS925NBwqEXW00GhGJibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3ycrJTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3770FC4CEED;
	Tue,  2 Sep 2025 20:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756846657;
	bh=peXqS4hyuTtYDPErd9rQ5om7XoXXlrY6I8pVRPFFO3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J3ycrJTgmJ/bq/SeBMB4jV1EGSsYNsK3Q31rAKqENAH5jJIXatUm7G9PQbFHVWFzB
	 ctAPg5tZTUt0bJbHOGtt2C17/Po2TPxElFCgrHy8OtUaLZ9x0k95bcZegO24jTNmZZ
	 mKBDfApZcB6fiwBg19LIQE3VW0uE44pfd6tbw5ZfvxX1Nv50fZZ5PPt6bRwbE/Mhl+
	 seVs50GclUdBSuM/4vJIIPmDtlHBZq7ryms7frMJDN7idtUBdi2qxOsB5CcBV8rJ2N
	 n23OlfBdgk1tYUD4rlek3R5IAIY0fim1YkdeNgNxRLlBIedPzC7EbCsex/qJ2fsqcS
	 jvGIyr80gb3+w==
Date: Tue, 2 Sep 2025 13:57:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250902205736.GB1587915@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
 <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com>
 <20250829153938.GA8088@frogsfrogsfrogs>
 <CAJfpegs=2==Tx3kcFHoD-0Y98tm6USdX_NTNpmoCpAJSMZvDtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs=2==Tx3kcFHoD-0Y98tm6USdX_NTNpmoCpAJSMZvDtw@mail.gmail.com>

On Tue, Sep 02, 2025 at 11:41:45AM +0200, Miklos Szeredi wrote:
> On Fri, 29 Aug 2025 at 17:39, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > IMMUTABLE | APPEND seem to be captured in KSTAT_ATTR_VFS_FLAGS, so maybe
> > that just needs to include the last three, and then we can use it to
> > clear those bits from the fuse server's reply.
> 
> Hmm. Fuse kernel module passes IMMUTABLE,  APPEND and DAX through the
> fileattr interfaces.  I.e. it doesn't query the respective VFS flags
> not does it try to set them.
> 
> For IMMUTABLE and APPEND I can imagine the server being able to handle
> these mostly (i.e. reject ops should be rejected).  It would be nice
> if the VFS was also aware.   I wonder if we can fix this at this
> point.

You can, kind of -- either send the server FS_IOC_FSGETXATTR or
FS_IOC_GETFLAGS right after igetting an inode and set the VFS
immutable/append flags from that; or we could add a couple of flag bits
to fuse_attr::flags to avoid the extra upcall.  You'd also have to
update the S_IMMUTABLE/S_APPEND flags based on the results of
FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS.

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=djwong-wtf&id=16584b3fcdaaeb789f22847e9f82964957493a18

(I didn't enable any of that for non-iomap files to avoid changing
expected behaviors)

> As for DAX, I don't see how the current behavior makes any sense, but
> again not seeing clearly what the best solution is.  Currently fuse
> doesn't support DAX in the traditional sense, but does have DAX
> functionality in virtiofs and in will in famfs.  Is this flag useful
> in that case?

At this point, STATX_ATTR_DAX means that S_DAX is set on the VFS inode,
and no other code is allowed to set that statx file attribute bit, per
dax.rst:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/dax.rst

The flag is very much needed for virtiofs/famfs (and any future
fuse+iomap+fsdax combination), because that's how application programs
are supposed to detect that they can use load/store to mmap file regions
without needing fsync/msync.

> I also fell that all unknown flags should also be masked off, but
> maybe that's too paranoid.

That isn't a terrible idea.

--D

> Thanks,
> Miklos
> 

