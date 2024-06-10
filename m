Return-Path: <linux-fsdevel+bounces-21358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470839029ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 22:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B871F24905
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8230481B4;
	Mon, 10 Jun 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFiMzK6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CB3E47E;
	Mon, 10 Jun 2024 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051193; cv=none; b=VZ6EwmltB6kqO2yCSzOqvaoQ5bFUKeXS3QEAA/il2wK64zoaQ37d5ZHRVzdOImBHDxy62WFYsUNq6dakpfMLbVEZi5R/baJ8sUnlCKM3ZLeB5RHgtRm7my2JiCUsbr1WYjRCr7Sfen8/p3VNrvw+FwnAzxOOwM9WLQabjZ2Gy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051193; c=relaxed/simple;
	bh=eJJNSK7gg98XBwHB8BD+dbA2UaQ/zT2zFikjypkU7Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSvlOhX0qTguwrejvdUpomvEXnA5MaHIv7u3C2ckqYiy/E22FAG+hRupCAcMC5WE7qOPiAnmh4pAA1le5iuN3xLjGHFAgJTpDx9GAT2mF0hZ+g3hKd26uoW8SzXB6T93H1oHb7sWM/ra7d42hRkBE/uIqxnqcpfYb428+hxkH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFiMzK6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84253C2BBFC;
	Mon, 10 Jun 2024 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718051192;
	bh=eJJNSK7gg98XBwHB8BD+dbA2UaQ/zT2zFikjypkU7Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFiMzK6CcGZPYc3CmHrVx79zWom1T3BV/HoHg8TpxAkMJiWYG4VuMrMkOSZd/t2AF
	 wp+80U+mtAptttVinfMGJqABtCs2caVk9579JbUdEp5qdvJlJ70hy0yIHPL2ZnU/k8
	 F4nqdXKB22d6D+BdY28fhQeRoiukmMdsbvT6WSrYs9POaBzxO1d4nnWc9w/lO86UfP
	 nhjzTfbwSWJNkLCSm6loI4zVlpikPItJRdPNHOoOCsZmljge8lhUIUGGi4H/FFj0T2
	 BrrYlaEbm2y9cU2av8pQuhfbB7Zo5bIMg5pRhckNnJSgku/9E93Vj6YQ+k5yEmCYb7
	 8xqddoybUIPTQ==
Date: Mon, 10 Jun 2024 13:26:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: Re: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240610202631.GE52973@frogsfrogsfrogs>
References: <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs>
 <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs>
 <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
 <ZmEemh4++vMEwLNg@dread.disaster.area>
 <tnj5nqca7ewg5igfvhwhmjigpg3nxeic4pdqecac3azjsvcdev@plebr5ozlvmb>
 <CAOQ4uxg6qihDRS1c11KUrrANrxJ2XvFUtC2gHY0Bf3TQjS0y4A@mail.gmail.com>
 <kh5z3o4wj2mxx45cx3v2p6osbgn5bd2sdexksmwio5ad5biiru@wglky7rxvj6l>
 <CAOQ4uxgLbXHYxhgtLByDyMcEwFGfg548AmJj7A99kwFkS_qTmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgLbXHYxhgtLByDyMcEwFGfg548AmJj7A99kwFkS_qTmw@mail.gmail.com>

On Mon, Jun 10, 2024 at 04:21:39PM +0300, Amir Goldstein wrote:
> On Mon, Jun 10, 2024 at 2:50 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> >
> > On 2024-06-10 12:19:50, Amir Goldstein wrote:
> > > On Mon, Jun 10, 2024 at 11:17 AM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> > > >
> > > > On 2024-06-06 12:27:38, Dave Chinner wrote:
> > > ...
> > > > >
> > > > > The only reason XFS returns -EXDEV to rename across project IDs is
> > > > > because nobody wanted to spend the time to work out how to do the
> > > > > quota accounting of the metadata changed in the rename operation
> > > > > accurately. So for that rare case (not something that would happen
> > > > > on the NAS product) we returned -EXDEV to trigger the mv command to
> > > > > copy the file to the destination and then unlink the source instead,
> > > > > thereby handling all the quota accounting correctly.
> > > > >
> > > > > IOWs, this whole "-EXDEV on rename across parent project quota
> > > > > boundaries" is an implementation detail and nothing more.
> > > > > Filesystems that implement project quotas and the directory tree
> > > > > sub-variant don't need to behave like this if they can accurately
> > > > > account for the quota ID changes during an atomic rename operation.
> > > > > If that's too hard, then the fallback is to return -EXDEV and let
> > > > > userspace do it the slow way which will always acocunt the resource
> > > > > usage correctly to the individual projects.
> > > > >
> > > > > Hence I think we should just fix the XFS kernel behaviour to do the
> > > > > right thing in this special file case rather than return -EXDEV and
> > > > > then forget about the rest of it.
> > > >
> > > > I see, I will look into that, this should solve the original issue.
> > >
> > > I see that you already got Darrick's RVB on the original patch:
> > > https://lore.kernel.org/linux-xfs/20240315024826.GA1927156@frogsfrogsfrogs/
> > >
> > > What is missing then?
> > > A similar patch for rename() that allows rename of zero projid special
> > > file as long as (target_dp->i_projid == src_dp->i_projid)?
> > >
> > > In theory, it would have been nice to fix the zero projid during the
> > > above link() and rename() operations, but it would be more challenging
> > > and I see no reason to do that if all the other files remain with zero
> > > projid after initial project setup (i.e. if not implementing the syscalls).
> >
> > I think Dave suggests to get rid of this if-guard and allow
> > link()/rename() for special files but with correct quota calculation.
> >
> > >
> > > >
> > > > But those special file's inodes still will not be accounted by the
> > > > quota during initial project setup (xfs_quota will skip them), would
> > > > it worth it adding new syscalls anyway?
> > > >
> > >
> > > Is it worth it to you?
> > >
> > > Adding those new syscalls means adding tests and documentation
> > > and handle all the bugs later.
> > >
> > > If nobody cared about accounting of special files inodes so far,
> > > there is no proof that anyone will care that you put in all this work.
> >
> > I already have patch and some simple man-pages prepared, I'm
> > wondering if this would be useful for any other usecases
> 
> Yes, I personally find it useful.
> I have applications that query the fsx_xflags and would rather
> be able to use O_PATH to query/set those flags, since
> internally in vfs, fileattr_[gs]et() do not really need an open file.
> 
> > which would
> > require setting extended attributes on spec indodes.
> 
> Please do not use the terminology "extended attributes" in the man page
> to describe struct fsxattr.

"XFS file attributes" perhaps?

Though that's anachronistic since ext4 supports /some/ of them now.

--D

> Better follow the "additional attributes" terminology of xfs ioctl man page [1],
> even though it is already confusing enough w.r.t "extended attributes" IMO.
> 
> Thanks,
> Amir.
> 
> [1] https://man7.org/linux/man-pages/man2/ioctl_xfs_fsgetxattr.2.html
> 

