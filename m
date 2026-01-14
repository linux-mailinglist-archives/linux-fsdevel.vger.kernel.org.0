Return-Path: <linux-fsdevel+bounces-73761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D829FD1FB67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00EE1306C568
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53F6399A6C;
	Wed, 14 Jan 2026 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqipJ8Fc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A9396B65;
	Wed, 14 Jan 2026 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404032; cv=none; b=jzwTq6t6VUXff8gUFr+SqJBEW9vqrL0KVyiw5wc1bD/HZiynoDPGGASiVY40eD9XkJ0IrMbLwQoy4IOY2sRHqqgo4f/qXk0BbIcMdo4D/fhSfA/yfSZcJZVNKG1Rlq0zuSG8K0gvp0Sg16OfEjSFfJUqSDuh1uFS/KavajgtVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404032; c=relaxed/simple;
	bh=95l5NkW0A/27kpGYcRaUumPREirLPSD0h/i7bikH9bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eviGL2viWqaNYDIxEq1kWrQs92MsJrCYKJaKBktkK9OEL/nqxakyPqC+fssxyWKk1KYHFhx6Hvz1Rb3SkUZelu2tXcZJPADduMxCbXyLD3eXc937TPIOD2P9x3EAnbUP3urZAV0stu4HY036CqzptZv5s/qsdM7P2wk83Ncm8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqipJ8Fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C66C4CEF7;
	Wed, 14 Jan 2026 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404032;
	bh=95l5NkW0A/27kpGYcRaUumPREirLPSD0h/i7bikH9bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqipJ8Fclg/c7qbEuyuUoO5LnexEwFkZgygpoboZW7ULcYAGY34jzrJax6uIrAgGb
	 FUepiZcAjlgA0R6fvdFVWwhV9jk0Bth6JPV5psDXj3fKzojOCwDT/rEZzcVE5OnNcB
	 fkG5ZlQLelxcsKpIOTgMpMe11bGcKCWvNYmxvgnzxn2ZC8L7s2dKJy1mrpvPNu7Z7A
	 UqZxpjIOgw/V7XPIA/1Y2FN9yOrK13WyoEdrmVdFpCQbw6zTva9Pkh2JqEgk58ngiJ
	 5S6BKkDUQrDweGrzgYJLMr/YFieOsQM7bFBSWWwVpgpU92+aZuVuBVHfvvOSCo18FZ
	 sKemGEnojFw5A==
Date: Wed, 14 Jan 2026 16:20:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
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
Message-ID: <20260114-klarstellen-blamieren-0b7d40182800@brauner>
References: <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
 <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
 <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
 <aWc3mwBNs8LNFN4W@infradead.org>
 <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
 <aWeUv2UUJ_NdgozS@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWeUv2UUJ_NdgozS@infradead.org>

On Wed, Jan 14, 2026 at 05:06:07AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 14, 2026 at 10:34:04AM +0100, Amir Goldstein wrote:
> > On Wed, Jan 14, 2026 at 7:28 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Tue, Jan 13, 2026 at 12:06:42PM -0500, Jeff Layton wrote:
> > > > Fair point, but it's not that hard to conceive of a situation where
> > > > someone inadvertantly exports cgroupfs or some similar filesystem:
> > >
> > > Sure.  But how is this worse than accidentally exporting private data
> > > or any other misconfiguration?
> > >
> > 
> > My POV is that it is less about security (as your question implies), and
> > more about correctness.
> 
> I was just replying to Jeff.
> 
> > The special thing about NFS export, as opposed to, say, ksmbd, is
> > open by file handle, IOW, the export_operations.
> > 
> > I perceive this as a very strange and undesired situation when NFS
> > file handles do not behave as persistent file handles.
> 
> That is not just very strange, but actually broken (discounting the
> obscure volatile file handles features not implemented in Linux NFS
> and NFSD).  And the export ops always worked under the assumption
> that these file handles are indeed persistent.  If they're not we
> do have a problem.
> 
> > 
> > cgroupfs, pidfs, nsfs, all gained open_by_handle_at() capability for
> > a known reason, which was NOT NFS export.
> > 
> > If the author of open_by_handle_at() support (i.e. brauner) does not
> > wish to imply that those fs should be exported to NFS, why object?
> 
> Because "want to export" is a stupid category.
> 
> OTOH "NFS exporting doesn't actually properly work because someone
> overloaded export_ops with different semantics" is a valid category.
> 
> > We could have the opt-in/out of NFS export fixes per EXPORT_OP_
> > flags and we could even think of allowing admin to make this decision
> > per vfsmount (e.g. for cgroupfs).
> > 
> > In any case, I fail to see how objecting to the possibility of NFS export
> > opt-out serves anyone.
> 
> You're still think of it the wrong way.  If we do have file systems
> that break the original exportfs semantics we need to fix that, and
> something like a "stable handles" flag will work well for that.  But
> a totally arbitrary "is exportable" flag is total nonsense.

File handles can legitimately be conceptualized independently of
exporting a filesystem. If we wanted to tear those concepts apart
implementation wise we could.

It is complete nonsense to expect the kernel to support exporting any
arbitrary internal filesystem or to not support file handles at all.

How that is achieved is completely irrelevant to that core part of the
argument. The point Jeff and Amir are making that it is sensible to
allow one without the other.

Whether or not some userspace crap allows you to achieve the same thing
is entirely irrelevant and does not at all imply we have to allow the
same crap in the kernel.

