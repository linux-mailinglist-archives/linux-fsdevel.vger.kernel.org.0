Return-Path: <linux-fsdevel+bounces-73390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB25BD1769B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D22A9302A13F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9C3806D5;
	Tue, 13 Jan 2026 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMqw4jfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AB836C0DC;
	Tue, 13 Jan 2026 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294474; cv=none; b=J5MI8uersA/PGhlGUohFBRbhnLlhP3FGtFGyktALIwLnfSEacqEKWbWvgmWwH3nI/RPKF6ZKJ2CzlBhwKrBIcRWAdEsO47hT35hdBfDA8rmSkBsFLAjW7bWoVp7raZX8RbWyaUWqutybd8gXbZeQF2ix2RgdRgpo1VljdbLGqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294474; c=relaxed/simple;
	bh=8pJH5EMsw2Zf/vnxVI5TNW+Tn1VjYrvuVd/4u81hQjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z39OZBNSmXhLxNtEV5x9eH965/XmRauOANmEnv5rZalW23LMxpIn9JiVQc5hU+Nt7+LKhCH5bZIYngEy7zQ99G7Daq5KZeqrsbfsGNT0SrlFJNaWskVmHEYUsk62cmeueTF5vIPC940ysEcYmfQIKOXmq9aO8DGa+vj1NxNwOZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMqw4jfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A24BC116C6;
	Tue, 13 Jan 2026 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768294474;
	bh=8pJH5EMsw2Zf/vnxVI5TNW+Tn1VjYrvuVd/4u81hQjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMqw4jfOdED4XJIXekFPVJQafNNTl6ZiZA++QmJZRBiaMMpeaGnJz3p4o2lTbIKwN
	 ZGKZS5HpYR0+N1ii5xC8s/TyQQtV2NHGSS3n0xjeitfnyVlfkGYGF3WN3Zn7pEUn7y
	 amB5o/YtgvPlamLE3g3COpvYgjvxdfsKYBT2hFD400U3g9OGS1J+dMj0yVSbLkyPHq
	 +GkCBtTzjYLjVlnxILoQmVvBvvr3BKnDX0iaKwspCd8aN5JnS4IRKaSF02TomWn63P
	 ouok9TX1G4ku4VsaA4mPbFNSkRS1iOdM6roW82YC7GjR5YxocE6Li41axUo0cFM9rz
	 CEFrc/zUFpOyw==
Date: Tue, 13 Jan 2026 09:54:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
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
	Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
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
Message-ID: <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
 <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
 <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>

On Mon, Jan 12, 2026 at 09:50:20AM -0500, Jeff Layton wrote:
> On Mon, 2026-01-12 at 09:31 -0500, Chuck Lever wrote:
> > On 1/12/26 8:34 AM, Jeff Layton wrote:
> > > On Fri, 2026-01-09 at 19:52 +0100, Amir Goldstein wrote:
> > > > On Thu, Jan 8, 2026 at 7:57 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > 
> > > > > On Thu, 2026-01-08 at 18:40 +0100, Jan Kara wrote:
> > > > > > On Thu 08-01-26 12:12:55, Jeff Layton wrote:
> > > > > > > Yesterday, I sent patches to fix how directory delegation support is
> > > > > > > handled on filesystems where the should be disabled [1]. That set is
> > > > > > > appropriate for v6.19. For v7.0, I want to make lease support be more
> > > > > > > opt-in, rather than opt-out:
> > > > > > > 
> > > > > > > For historical reasons, when ->setlease() file_operation is set to NULL,
> > > > > > > the default is to use the kernel-internal lease implementation. This
> > > > > > > means that if you want to disable them, you need to explicitly set the
> > > > > > > ->setlease() file_operation to simple_nosetlease() or the equivalent.
> > > > > > > 
> > > > > > > This has caused a number of problems over the years as some filesystems
> > > > > > > have inadvertantly allowed leases to be acquired simply by having left
> > > > > > > it set to NULL. It would be better if filesystems had to opt-in to lease
> > > > > > > support, particularly with the advent of directory delegations.
> > > > > > > 
> > > > > > > This series has sets the ->setlease() operation in a pile of existing
> > > > > > > local filesystems to generic_setlease() and then changes
> > > > > > > kernel_setlease() to return -EINVAL when the setlease() operation is not
> > > > > > > set.
> > > > > > > 
> > > > > > > With this change, new filesystems will need to explicitly set the
> > > > > > > ->setlease() operations in order to provide lease and delegation
> > > > > > > support.
> > > > > > > 
> > > > > > > I mainly focused on filesystems that are NFS exportable, since NFS and
> > > > > > > SMB are the main users of file leases, and they tend to end up exporting
> > > > > > > the same filesystem types. Let me know if I've missed any.
> > > > > > 
> > > > > > So, what about kernfs and fuse? They seem to be exportable and don't have
> > > > > > .setlease set...
> > > > > > 
> > > > > 
> > > > > Yes, FUSE needs this too. I'll add a patch for that.
> > > > > 
> > > > > As far as kernfs goes: AIUI, that's basically what sysfs and resctrl
> > > > > are built on. Do we really expect people to set leases there?
> > > > > 
> > > > > I guess it's technically a regression since you could set them on those
> > > > > sorts of files earlier, but people don't usually export kernfs based
> > > > > filesystems via NFS or SMB, and that seems like something that could be
> > > > > used to make mischief.
> > > > > 
> > > > > AFAICT, kernfs_export_ops is mostly to support open_by_handle_at(). See
> > > > > commit aa8188253474 ("kernfs: add exportfs operations").
> > > > > 
> > > > > One idea: we could add a wrapper around generic_setlease() for
> > > > > filesystems like this that will do a WARN_ONCE() and then call
> > > > > generic_setlease(). That would keep leases working on them but we might
> > > > > get some reports that would tell us who's setting leases on these files
> > > > > and why.
> > > > 
> > > > IMO, you are being too cautious, but whatever.
> > > > 
> > > > It is not accurate that kernfs filesystems are NFS exportable in general.
> > > > Only cgroupfs has KERNFS_ROOT_SUPPORT_EXPORTOP.
> > > > 
> > > > If any application is using leases on cgroup files, it must be some
> > > > very advanced runtime (i.e. systemd), so we should know about the
> > > > regression sooner rather than later.
> > > > 
> > > 
> > > I think so too. For now, I think I'll not bother with the WARN_ONCE().
> > > Let's just leave kernfs out of the set until someone presents a real
> > > use-case.
> > > 
> > > > There are also the recently added nsfs and pidfs export_operations.
> > > > 
> > > > I have a recollection about wanting to be explicit about not allowing
> > > > those to be exportable to NFS (nsfs specifically), but I can't see where
> > > > and if that restriction was done.
> > > > 
> > > > Christian? Do you remember?
> > > > 
> > > 
> > > (cc'ing Chuck)
> > > 
> > > FWIW, you can currently export and mount /sys/fs/cgroup via NFS. The
> > > directory doesn't show up when you try to get to it via NFSv4, but you
> > > can mount it using v3 and READDIR works. The files are all empty when
> > > you try to read them. I didn't try to do any writes.
> > > 
> > > Should we add a mechanism to prevent exporting these sorts of
> > > filesystems?
> > > 
> > > Even better would be to make nfsd exporting explicitly opt-in. What if
> > > we were to add a EXPORT_OP_NFSD flag that explicitly allows filesystems
> > > to opt-in to NFS exporting, and check for that in __fh_verify()? We'd
> > > have to add it to a bunch of existing filesystems, but that's fairly
> > > simple to do with an LLM.
> > 
> > What's the active harm in exporting /sys/fs/cgroup ? It has to be done
> > explicitly via /etc/exports, so this is under the NFS server admin's
> > control. Is it an attack surface?
> > 
> 
> Potentially?
> 
> I don't see any active harm with exporting cgroupfs. It doesn't work
> right via nfsd, but it's not crashing the box or anything.
> 
> At one time, those were only defined by filesystems that wanted to
> allow NFS export. Now we've grown them on filesystems that just want to
> provide filehandles for open_by_handle_at() and the like. nfsd doesn't
> care though: if the fs has export operations, it'll happily use them.
> 
> Having an explicit "I want to allow nfsd" flag see ms like it might
> save us some headaches in the future when other filesystems add export
> ops for this sort of filehandle use.

So we are re-hashing a discussion we had a few months ago (Amir was
involved at least).

I don't think we want to expose cgroupfs via NFS that's super weird.
It's like remote partial resource management and it would be very
strange if a remote process suddenly would be able to move things around
in the cgroup tree. So I would prefer to not do this.

So my preference would be to really sever file handles from the export
mechanism so that we can allow stuff like pidfs and nsfs and cgroupfs to
use file handles via name_to_handle_at() and open_by_handle_at() without
making them exportable.

Somehow I thought that Amir had already done that work a while ago but
maybe it was really just about name_to_handle_at() and not also
open_by_handle_at()...

