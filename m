Return-Path: <linux-fsdevel+bounces-73204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26269D119B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B8363016228
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A33277CBF;
	Mon, 12 Jan 2026 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kovjAz4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05F274B59;
	Mon, 12 Jan 2026 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211376; cv=none; b=MOTvxBI1YuyjQ6gvfX+4HVhe72CbP4yt4MYLF43g1zK/WDZng64na/lIgWu0mFuymgPzvUt7S67Ml5M7UpkgZB5lKBpxX8yif40N176YBrF9ZzFdqzZhsq/1awhIvyuD++KttDb8aT+8fYob3fMHrHrEsVAmU/hqyub/+BI6xtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211376; c=relaxed/simple;
	bh=m8zAICgnxs6xkW3AmfrwI3a0ispTdY6AQGss0vAXdME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3NGPeSk7a6CvIe4nVvFvvSnbK5NVJaYkh+JHB1QwFtdQCPgilSDFlMkOl6W2KzB/eGVQH7f3OmakECiQ7Q618apQJurEN+dJAbZkhpCEvsrOZoErmuj5UE8GOKObjGF+OnoSvzUZOexu3kkKoaEBN3gxKdvi8+UtRLI9qsGb6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kovjAz4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD38C116D0;
	Mon, 12 Jan 2026 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768211375;
	bh=m8zAICgnxs6xkW3AmfrwI3a0ispTdY6AQGss0vAXdME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kovjAz4KC5mAD7YrC6t2czYMjBWRcZIetUzNRdlwl4Z1rGgyp9glYOLbnOZypWAbx
	 YcmUJCp6E8w+KmTy2i5WzHpX9fHwe2RpJgFtTNA95cnxyqlkjOQ7JUeU62APvVqkZH
	 Y3/3WTlqh+tsw7Ls6NjRbDo/fUnqsYd/eTTthVLhPJ/V7Q9k3YIeMunOn+RktLYgES
	 ul3EQIBMmxhQ+r6sMjogrCPwB0I4vKTgz3PxtAbmBEyff/p4uJORPrLFe5LDSB0Hni
	 RZIrOX4UDngsOGqfziwhf24VBmArYe5xbo5TLnA7nB4zBdXfiNr6kFAgXt4Ej7biQ5
	 RxoAJIZnapRSw==
Date: Mon, 12 Jan 2026 10:49:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Christoph Hellwig <hch@infradead.org>, 
	Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Dave Kleikamp <shaggy@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, gfs2@lists.linux.dev, 
	linux-doc@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
Message-ID: <20260112-gemeldet-gelitten-7d48bae7ef3f@brauner>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
 <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>

On Fri, Jan 09, 2026 at 07:52:57PM +0100, Amir Goldstein wrote:
> On Thu, Jan 8, 2026 at 7:57 PM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Thu, 2026-01-08 at 18:40 +0100, Jan Kara wrote:
> > > On Thu 08-01-26 12:12:55, Jeff Layton wrote:
> > > > Yesterday, I sent patches to fix how directory delegation support is
> > > > handled on filesystems where the should be disabled [1]. That set is
> > > > appropriate for v6.19. For v7.0, I want to make lease support be more
> > > > opt-in, rather than opt-out:
> > > >
> > > > For historical reasons, when ->setlease() file_operation is set to NULL,
> > > > the default is to use the kernel-internal lease implementation. This
> > > > means that if you want to disable them, you need to explicitly set the
> > > > ->setlease() file_operation to simple_nosetlease() or the equivalent.
> > > >
> > > > This has caused a number of problems over the years as some filesystems
> > > > have inadvertantly allowed leases to be acquired simply by having left
> > > > it set to NULL. It would be better if filesystems had to opt-in to lease
> > > > support, particularly with the advent of directory delegations.
> > > >
> > > > This series has sets the ->setlease() operation in a pile of existing
> > > > local filesystems to generic_setlease() and then changes
> > > > kernel_setlease() to return -EINVAL when the setlease() operation is not
> > > > set.
> > > >
> > > > With this change, new filesystems will need to explicitly set the
> > > > ->setlease() operations in order to provide lease and delegation
> > > > support.
> > > >
> > > > I mainly focused on filesystems that are NFS exportable, since NFS and
> > > > SMB are the main users of file leases, and they tend to end up exporting
> > > > the same filesystem types. Let me know if I've missed any.
> > >
> > > So, what about kernfs and fuse? They seem to be exportable and don't have
> > > .setlease set...
> > >
> >
> > Yes, FUSE needs this too. I'll add a patch for that.
> >
> > As far as kernfs goes: AIUI, that's basically what sysfs and resctrl
> > are built on. Do we really expect people to set leases there?
> >
> > I guess it's technically a regression since you could set them on those
> > sorts of files earlier, but people don't usually export kernfs based
> > filesystems via NFS or SMB, and that seems like something that could be
> > used to make mischief.
> >
> > AFAICT, kernfs_export_ops is mostly to support open_by_handle_at(). See
> > commit aa8188253474 ("kernfs: add exportfs operations").
> >
> > One idea: we could add a wrapper around generic_setlease() for
> > filesystems like this that will do a WARN_ONCE() and then call
> > generic_setlease(). That would keep leases working on them but we might
> > get some reports that would tell us who's setting leases on these files
> > and why.
> 
> IMO, you are being too cautious, but whatever.
> 
> It is not accurate that kernfs filesystems are NFS exportable in general.
> Only cgroupfs has KERNFS_ROOT_SUPPORT_EXPORTOP.
> 
> If any application is using leases on cgroup files, it must be some
> very advanced runtime (i.e. systemd), so we should know about the
> regression sooner rather than later.
> 
> There are also the recently added nsfs and pidfs export_operations.
> 
> I have a recollection about wanting to be explicit about not allowing
> those to be exportable to NFS (nsfs specifically), but I can't see where
> and if that restriction was done.
> 
> Christian? Do you remember?

I don't think it does.

