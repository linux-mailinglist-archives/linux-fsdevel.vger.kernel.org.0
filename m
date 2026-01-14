Return-Path: <linux-fsdevel+bounces-73707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A679D1F1AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 710F93035CC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F739C65A;
	Wed, 14 Jan 2026 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRavfhGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E6237F8AF;
	Wed, 14 Jan 2026 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398085; cv=none; b=aEEknM4A0LvcHPIX7MMQ3PFixUTS/iWi2ZuUVDkfEV9Xskc1eGo+7CBGkeLMlXJ53Rx4ZTMf9d0eKQxwEIUEI4k7jc+0Km1ODCfD5bd6C3xbgHOz+DBYThTYdzta8kEU/K5ApfDzmyslXusp/Kus371y2seGA7T1/LqiOeAo/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398085; c=relaxed/simple;
	bh=AGOrlXkH2rrh8Ly7+xo5okbbNUBbGX1tnuFn0Fw+zJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ON8v8RJWZP6zpRQNZUQunkz0fAANYlaI/I6givof0nLDSzi4iWGtAeMAFh3o9uz+y2rjNUCgd+ZUJUsjFXzkELTPB7L9XYCHN/QrBmdl9Xq9K9ILYb/2R/c3tXaqsfABxSa50dRk1h+DveJ3nEL6/n/vStJ0uiJ4+x7DuU/7O2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRavfhGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E74C16AAE;
	Wed, 14 Jan 2026 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768398084;
	bh=AGOrlXkH2rrh8Ly7+xo5okbbNUBbGX1tnuFn0Fw+zJc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VRavfhGBsUHT0huV319uIV5IfpnGTXwdGAg8d0nh5I59VNWHFgvajS7LYMGIQWwRL
	 /lt/rL/kVbONCKdog2BmNgHejDSb0f5Sm6i9FqGCjGfRF0eQsZX/aQqGCBihT54l4s
	 a3wmHzuHw/Wxz3nQJNLeoYsExywfUvM483GvMm8/osr1i7GKF4Y+x7pJObfQkCxBOC
	 +esINeJ/3U+/XfhB8OUE+S+3oetsGA7A5Hzb7+p/5KszwsTcoNYa5jkiRmEfELQOdw
	 +8hwsdMAA4Im5mCWn/LRAj2LcpxCduyypZsjvymbYs1yGPltlU17N2q/6Wq1OoKBjM
	 RR1Usgwu5rJIw==
Message-ID: <c40862cd65a059ad45fa88f5473722ea5c5f70a5.camel@kernel.org>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Amir Goldstein
 <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>,  Jan Kara <jack@suse.cz>, Luis de Bethencourt
 <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>,  Nicolas Pitre
 <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  David Sterba <dsterba@suse.com>, Chris Mason
 <clm@fb.com>, Gao Xiang <xiang@kernel.org>, Chao Yu	 <chao@kernel.org>, Yue
 Hu <zbestahu@gmail.com>, Jeffle Xu	 <jefflexu@linux.alibaba.com>, Sandeep
 Dhavale <dhavale@google.com>, Hongbo Li	 <lihongbo22@huawei.com>, Chunhai
 Guo <guochunhai@vivo.com>, Jan Kara	 <jack@suse.com>, Theodore Ts'o
 <tytso@mit.edu>, Andreas Dilger	 <adilger.kernel@dilger.ca>, Jaegeuk Kim
 <jaegeuk@kernel.org>, OGAWA Hirofumi	 <hirofumi@mail.parknet.co.jp>, David
 Woodhouse <dwmw2@infradead.org>,  Richard Weinberger	 <richard@nod.at>,
 Dave Kleikamp <shaggy@kernel.org>, Ryusuke Konishi	
 <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh
 <mark@fasheh.com>, Joel Becker	 <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Mike Marshall	 <hubcap@omnibond.com>, Martin
 Brandenburg <martin@omnibond.com>, Miklos Szeredi	 <miklos@szeredi.hu>,
 Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino	
 <cem@kernel.org>, Hugh Dickins <hughd@google.com>, Baolin Wang	
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
  Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Yuezhang Mo	 <yuezhang.mo@sony.com>, Alexander
 Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)"	
 <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar
 Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck	 <linux_oss@crudebyte.com>, Xiubo Li
 <xiubli@redhat.com>, Ilya Dryomov	 <idryomov@gmail.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker	 <anna@kernel.org>, Steve French
 <sfrench@samba.org>, Paulo Alcantara	 <pc@manguebit.org>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>, Shyam Prasad N	 <sprasad@microsoft.com>, Tom
 Talpey <tom@talpey.com>, Bharath SM	 <bharathsm@microsoft.com>, Hans de
 Goede <hansg@kernel.org>, 	linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, 	linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, 	linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, 	linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, 	linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, gfs2@lists.linux.dev, 
	linux-doc@vger.kernel.org, v9fs@lists.linux.dev,
 ceph-devel@vger.kernel.org, 	linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, 	samba-technical@lists.samba.org
Date: Wed, 14 Jan 2026 08:41:16 -0500
In-Reply-To: <aWeUv2UUJ_NdgozS@infradead.org>
References: <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
	 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
	 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
	 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
	 <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
	 <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
	 <aWZcoyQLvbJKUxDU@infradead.org>
	 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
	 <aWc3mwBNs8LNFN4W@infradead.org>
	 <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
	 <aWeUv2UUJ_NdgozS@infradead.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 05:06 -0800, Christoph Hellwig wrote:
> On Wed, Jan 14, 2026 at 10:34:04AM +0100, Amir Goldstein wrote:
> > On Wed, Jan 14, 2026 at 7:28=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > >=20
> > > On Tue, Jan 13, 2026 at 12:06:42PM -0500, Jeff Layton wrote:
> > > > Fair point, but it's not that hard to conceive of a situation where
> > > > someone inadvertantly exports cgroupfs or some similar filesystem:
> > >=20
> > > Sure.  But how is this worse than accidentally exporting private data
> > > or any other misconfiguration?
> > >=20
> >=20
> > My POV is that it is less about security (as your question implies), an=
d
> > more about correctness.
>=20
> I was just replying to Jeff.
>=20
> > The special thing about NFS export, as opposed to, say, ksmbd, is
> > open by file handle, IOW, the export_operations.
> >=20
> > I perceive this as a very strange and undesired situation when NFS
> > file handles do not behave as persistent file handles.
>=20
> That is not just very strange, but actually broken (discounting the
> obscure volatile file handles features not implemented in Linux NFS
> and NFSD).  And the export ops always worked under the assumption
> that these file handles are indeed persistent.  If they're not we
> do have a problem.
>=20
> >=20
> > cgroupfs, pidfs, nsfs, all gained open_by_handle_at() capability for
> > a known reason, which was NOT NFS export.
> >=20
> > If the author of open_by_handle_at() support (i.e. brauner) does not
> > wish to imply that those fs should be exported to NFS, why object?
>=20
> Because "want to export" is a stupid category.
>=20
> OTOH "NFS exporting doesn't actually properly work because someone
> overloaded export_ops with different semantics" is a valid category.
>=20

cgroupfs definitely doesn't behave as expected when exported via NFS.
The files aren't readable, at least. I'd also be surprised if the
filehandles were stable across a reboot, which is sort of necessary for
proper operation. I didn't test writing, but who knows whether that
might also just not work, crash the box, or do something else entirely.

I imagine this is the case for all sorts of filesystems like /proc,
/sys, etc. Those aren't exportable today (to my knowledge), but we're
growing export_operations across a wide range of fs's these days.

I'd prefer that we require someone to take the deliberate step to say
"yes, allow nfsd to access this type of filesystem".

> > We could have the opt-in/out of NFS export fixes per EXPORT_OP_
> > flags and we could even think of allowing admin to make this decision
> > per vfsmount (e.g. for cgroupfs).
> >=20
> > In any case, I fail to see how objecting to the possibility of NFS expo=
rt
> > opt-out serves anyone.
>=20
> You're still think of it the wrong way.  If we do have file systems
> that break the original exportfs semantics we need to fix that, and
> something like a "stable handles" flag will work well for that.  But
> a totally arbitrary "is exportable" flag is total nonsense.

The problem there is that we very much do want to keep tmpfs
exportable, but it doesn't have stable handles (per-se).
--=20
Jeff Layton <jlayton@kernel.org>

