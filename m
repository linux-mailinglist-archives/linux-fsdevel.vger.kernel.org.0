Return-Path: <linux-fsdevel+bounces-63683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F36BCA9ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 20:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F488189B9C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553D254864;
	Thu,  9 Oct 2025 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6E3TPBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221621A95D;
	Thu,  9 Oct 2025 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036191; cv=none; b=HieTFwbHYRfJa0N/210yCzrYXwY5XvA/sawGkBRbBl8WI8dGzabXFKsbOc0EzZCYIovJVGZ9wR1byzWRwL6GOS54CgD04cTXx4DWRWeD/BkmZy6FE9Ss7UrtgsSxxdKm6ZTw/QsFQ+0QMHfUWTh7FkhYVwnfM9zY19wp4xAjPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036191; c=relaxed/simple;
	bh=tpYBuiymNxih3LRJAdymo81PTOI7Ef7VSRBNYl1wcQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/4NCI2z7bKDlgebveUzJ5//IewTaQBsYdS4clOnI1nuwzexOW4QSm6FTbuNze8BOMGT9WUnQ1a9XlE/l4xPhwbBREnn6EiBwfRvcE1aMg7mSHTn1HY5dhvEmvUBsID75JKdC/Wf/sa9VtgFWt4NHLb6LEcPN3Rq2Sxhxeu2zQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6E3TPBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7702C4CEE7;
	Thu,  9 Oct 2025 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760036190;
	bh=tpYBuiymNxih3LRJAdymo81PTOI7Ef7VSRBNYl1wcQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6E3TPBI/oSAz61tR2w6D3UBYWoqBtLbve7bh5mmBzp4iSdXTTeK6quhChwfLFZHX
	 wOh6R3QmXlSczMJVUqQG3I7o3CcUJzl/SW/VBmAWMVi8pSUgZG8yl/IVkLv4N3tJZv
	 JnO39abitniyL19eLxxXeru1UADKc0MYC/UUp5svIaZO7cbZd2z4xwCmcTnwdoswmm
	 NYN91XzDn4J9O86laJODj+F7X37t8u3Y+N1jgluSooHGvmAgU+u87sbPKsjVboWlGm
	 AZgBXExDcO+XvMUWS5Vnl8SnsG2pVu/Odu9qfIEBcEN6b82cTUzCtHS8wzlLokJcOV
	 a2DMZV1lL9Gvg==
Date: Thu, 9 Oct 2025 11:56:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v4 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <20251009185630.GA6178@frogsfrogsfrogs>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
 <20251003-xattrat-syscall-v4-1-1cfe6411c05f@kernel.org>
 <20251005103656.5qu3lmjvlcjkwjx4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <7mytyiatnhgwplgda3cmiqq3hb7z6ulwgvwbkueb5dm2sdxwlg@ijti4d7vgrck>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7mytyiatnhgwplgda3cmiqq3hb7z6ulwgvwbkueb5dm2sdxwlg@ijti4d7vgrck>

On Mon, Oct 06, 2025 at 11:37:53AM +0200, Andrey Albershteyn wrote:
> On 2025-10-05 18:36:56, Zorro Lang wrote:
> > On Fri, Oct 03, 2025 at 11:32:44AM +0200, Andrey Albershteyn wrote:
> > > This programs uses newly introduced file_getattr and file_setattr
> > > syscalls. This program is partially a test of invalid options. This will
> > > be used further in the test.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > 
> > [snap]
> > 
> > > +	if (!path1 && optind < argc)
> > > +		path1 = argv[optind++];
> > > +	if (!path2 && optind < argc)
> > > +		path2 = argv[optind++];
> > > +
> > > +	if (at_fdcwd) {
> > > +		fd = AT_FDCWD;
> > > +		path = path1;
> > > +	} else if (!path2) {
> > > +		error = stat(path1, &status);
> > > +		if (error) {
> > > +			fprintf(stderr,
> > > +"Can not get file status of %s: %s\n", path1, strerror(errno));
> > > +			return error;
> > > +		}
> > > +
> > > +		if (SPECIAL_FILE(status.st_mode)) {
> > > +			fprintf(stderr,
> > > +"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
> > > +			return errno;
> > > +		}
> > > +
> > > +		fd = open(path1, O_RDONLY);
> > > +		if (fd == -1) {
> > > +			fprintf(stderr, "Can not open %s: %s\n", path1,
> > > +					strerror(errno));
> > > +			return errno;
> > > +		}
> > > +	} else {
> > > +		fd = open(path1, O_RDONLY);
> > > +		if (fd == -1) {
> > > +			fprintf(stderr, "Can not open %s: %s\n", path1,
> > > +					strerror(errno));
> > > +			return errno;
> > > +		}
> > > +		path = path2;
> > > +	}
> > > +
> > > +	if (!path)
> > > +		at_flags |= AT_EMPTY_PATH;
> > > +
> > > +	error = file_getattr(fd, path, &fsx, fa_size,
> > > +			at_flags);
> > > +	if (error) {
> > > +		fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
> > > +				strerror(errno));
> > > +		return error;
> > > +	}
> > 
> > We should have a _require_* helper to _notrun your generic and xfs test cases,
> > when system doesn't support the file_getattr/setattr feature. Or we always hit
> > something test errors like below on old system:
> > 
> >   +Can not get fsxattr on ./fifo: Operation not supported
> > 
> > Maybe check if the errno is "Operation not supported", or any better idea?
> 
> There's build system check for file_getattr/setattr syscalls, so if
> they aren't in the kernel file_attr will not compile.
> 
> Then there's _require_test_program "file_attr" in the tests, so
> these will not run if kernel doesn't have these syscalls.
> 
> However, for XFS for example, there's [1] and [2] which are
> necessary for these tests to pass. 
> 
> So, there a few v6.17 kernels which would still run these tests but
> fail for XFS (and still fails as these commits are in for-next now).
> 
> For other filesystems generic/ will also fail on newer kernels as it
> requires similar modifications as in XFS to support changing file
> attributes on special files.
> 
> I suppose it make sense for this test to fail for other fs which
> don't implement changing file attributes on special files.
> Otherwise, this test could be split into generic/ (file_get/setattr
> on regular files) and xfs/ (file_get/setattr on special files).
> 
> What do you think?

generic/772 (and xfs/648) probably each ought to be split into two
pieces -- one for testing file_[gs]etattr on regular/directory files;
and a second one for the special files.  All four of them ought to
_notrun if the kernel doesn't support the intended target.

Right now I have injected into both:

mkfifo $projectdir/fifo

$here/src/file_attr --get $projectdir ./fifo &>/dev/null || \
	_notrun "file_getattr not supported on $FSTYP"

to make the failures go away on 6.17.

--D

> [1]: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=8a221004fe5288b66503699a329a6b623be13f91
> [2]: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=0239bd9fa445a21def88f7e76fe6e0414b2a4da0
> 
> > 
> > 
> > Thanks,
> > Zorro
> > 
> > > +	if (action) {
> > > +		fsx.fa_xflags |= (fa_xflags | unknwon_fa_flag);
> > > +
> > > +		error = file_setattr(fd, path, &fsx, fa_size,
> > > +				at_flags);
> > > +		if (error) {
> > > +			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
> > > +					strerror(errno));
> > > +			return error;
> > > +		}
> > > +	} else {
> > > +		if (path2)
> > > +			print_xflags(fsx.fa_xflags, 0, 1, path, 0, 1);
> > > +		else
> > > +			print_xflags(fsx.fa_xflags, 0, 1, path1, 0, 1);
> > > +	}
> > > +
> > > +	return error;
> > > +
> > > +usage:
> > > +	printf("Usage: %s [options]\n", argv[0]);
> > > +	printf("Options:\n");
> > > +	printf("\t--get, -g\t\tget filesystem inode attributes\n");
> > > +	printf("\t--set, -s\t\tset filesystem inode attributes\n");
> > > +	printf("\t--at-cwd, -a\t\topen file at current working directory\n");
> > > +	printf("\t--no-follow, -n\t\tdon't follow symlinks\n");
> > > +	printf("\t--set-nodump, -d\t\tset FS_XFLAG_NODUMP on an inode\n");
> > > +	printf("\t--invalid-at, -i\t\tUse invalid AT_* flag\n");
> > > +	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
> > > +	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
> > > +	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
> > > +
> > > +	return 1;
> > > +}
> > > 
> > > -- 
> > > 2.50.1
> > > 
> > 
> 
> -- 
> - Andrey
> 
> 

