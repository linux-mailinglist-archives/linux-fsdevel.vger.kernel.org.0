Return-Path: <linux-fsdevel+bounces-79430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIRrO2FmqGl3uQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 18:05:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1AF204D49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0134830F7FE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1113783DB;
	Wed,  4 Mar 2026 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXD9BpWg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378F373C0B;
	Wed,  4 Mar 2026 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643582; cv=none; b=OuvtUVEsc5xfevolAorypMvoi86DzEVsg4UDWgjqBtaavTYbdqPAD41NNqf4TksOd9xmpMcvonMQum58rLlqXCH1QpSXZPe29YeZi0QXFxAUihEeHzeif36tRGbA0sQmCvc+HPEvil9SD8c4ZUrz3FAZDoFrf/KM6VBEbi9cEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643582; c=relaxed/simple;
	bh=Vco3uqMM+GGwamDaSgMVwORJh+OF+HTrP0JVrfOVsPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3lvhq1uqQiiwFuAOncMEEBXM7YxCKbK2/oeWscxEqJkYJGwmXaH+f7IOv4YAZJYulXb7ytAMfkuIg3+Csgk72ippOsm54RwLJkGnRSoNNMWjwUGU+e/6zO8yCEpTZrNa0S4Yxc55/RQh4plKnSA3jqQiqf4t0XPczAHIXQhOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXD9BpWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FBAC2BCB0;
	Wed,  4 Mar 2026 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772643582;
	bh=Vco3uqMM+GGwamDaSgMVwORJh+OF+HTrP0JVrfOVsPw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CXD9BpWgkkINK6gZqwyX5n7YT6eyFHASQ0Cf19QSMh58zX8rxOu5w8xcN+ALcpoiN
	 zbse2DEyA7vWamOUkFLS5cEPnwTisG+hpK4j3y8lhaSnEuoTtnggjrzLnvkaqpuG4Q
	 /pLrkelh2wFBDJe2W+0q8sB/i9CBZKq+1QKdbV2czTHnDvJNKeh8dlDWRQIN1f4Oly
	 wkxfWt/ojpUzF7aYV96/GCDXWlUslEu8HeL4mAwxYbk0tPCb3+ItQ1ysWx6N4nShGq
	 zvEPbwgzgHkxslhDUcJzRX0BNjNVvspwFLrzcRh1590XHX+B39SAGRYWotYwfZVTOL
	 Sc+WO/HYq9qBg==
Message-ID: <e07e9b893ca04ce6ead4790e72c7f285a7159070.camel@kernel.org>
Subject: Re: [PATCH 24/24] fs: remove simple_nosetlease()
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, Salah Triki
 <salah.triki@gmail.com>,  Nicolas Pitre <nico@fluxnic.net>, Christoph
 Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Anders Larsen	
 <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner	 <brauner@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason
 <clm@fb.com>,  Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue
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
 Amir Goldstein <amir73il@gmail.com>, Phillip Lougher	
 <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, Hugh Dickins	
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew
 Morton	 <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>,
 Sungjong Seo	 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 Chuck Lever	 <chuck.lever@oracle.com>, Alexander Aring
 <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)"	 <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian
 Schoenebeck	 <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, Ilya
 Dryomov	 <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker	 <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo
 Alcantara	 <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N	 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM	 <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, 	devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, 	linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, gfs2@lists.linux.dev, 	linux-doc@vger.kernel.org,
 v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org
Date: Wed, 04 Mar 2026 11:59:32 -0500
In-Reply-To: <aZ84VRrRVyGEzSJn@kernel.org>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
	 <20260108-setlease-6-20-v1-24-ea4dec9b67fa@kernel.org>
	 <aZ84VRrRVyGEzSJn@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5C1AF204D49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fluxnic.net,infradead.org,suse.cz,alarsen.net,zeniv.linux.org.uk,suse.com,fb.com,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,mail.parknet.co.jp,nod.at,dubeyko.com,paragon-software.com,fasheh.com,evilplan.org,omnibond.com,szeredi.hu,squashfs.org.uk,linux-foundation.org,samsung.com,sony.com,oracle.com,redhat.com,lwn.net,ionkov.net,codewreck.org,crudebyte.com,samba.org,manguebit.org,microsoft.com,talpey.com,vger.kernel.org,lists.ozlabs.org,lists.sourceforge.net,lists.infradead.org,lists.linux.dev,lists.orangefs.org,kvack.org,lists.samba.org];
	TAGGED_FROM(0.00)[bounces-79430-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 12:58 -0500, Mike Snitzer wrote:
> On Thu, Jan 08, 2026 at 12:13:19PM -0500, Jeff Layton wrote:
> > Setting ->setlease() to a NULL pointer now has the same effect as
> > setting it to simple_nosetlease(). Remove all of the setlease
> > file_operations that are set to simple_nosetlease, and the function
> > itself.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/9p/vfs_dir.c        |  2 --
> >  fs/9p/vfs_file.c       |  2 --
> >  fs/ceph/dir.c          |  2 --
> >  fs/ceph/file.c         |  1 -
> >  fs/fuse/dir.c          |  1 -
> >  fs/gfs2/file.c         |  2 --
> >  fs/libfs.c             | 18 ------------------
> >  fs/nfs/dir.c           |  1 -
> >  fs/nfs/file.c          |  1 -
> >  fs/smb/client/cifsfs.c |  1 -
> >  fs/vboxsf/dir.c        |  1 -
> >  fs/vboxsf/file.c       |  1 -
> >  include/linux/fs.h     |  1 -
> >  13 files changed, 34 deletions(-)
> >=20
>=20
> <snip>
>=20
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index 697c6d5fc12786c036f0086886297fb5cd52ae00..f1860dff86f2703266beecf=
31e9d2667af7a9684 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> > @@ -1699,24 +1699,6 @@ struct inode *alloc_anon_inode(struct super_bloc=
k *s)
> >  }
> >  EXPORT_SYMBOL(alloc_anon_inode);
> > =20
> > -/**
> > - * simple_nosetlease - generic helper for prohibiting leases
> > - * @filp: file pointer
> > - * @arg: type of lease to obtain
> > - * @flp: new lease supplied for insertion
> > - * @priv: private data for lm_setup operation
> > - *
> > - * Generic helper for filesystems that do not wish to allow leases to =
be set.
> > - * All arguments are ignored and it just returns -EINVAL.
> > - */
> > -int
> > -simple_nosetlease(struct file *filp, int arg, struct file_lease **flp,
> > -		  void **priv)
> > -{
> > -	return -EINVAL;
> > -}
> > -EXPORT_SYMBOL(simple_nosetlease);
> > -
> >  /**
> >   * simple_get_link - generic helper to get the target of "fast" symlin=
ks
> >   * @dentry: not used here
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index 71df279febf797880ded19e45528c3df4cea2dde..23a78a742b619dea8b76ddf=
28f4f59a1c8a015e2 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -66,7 +66,6 @@ const struct file_operations nfs_dir_operations =3D {
> >  	.open		=3D nfs_opendir,
> >  	.release	=3D nfs_closedir,
> >  	.fsync		=3D nfs_fsync_dir,
> > -	.setlease	=3D simple_nosetlease,
> >  };
> > =20
> >  const struct address_space_operations nfs_dir_aops =3D {
> > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > index d020aab40c64ebda30d130b6acee1b9194621457..9d269561961825f88529551=
b0f0287920960ac62 100644
> > --- a/fs/nfs/file.c
> > +++ b/fs/nfs/file.c
> > @@ -962,7 +962,6 @@ const struct file_operations nfs_file_operations =
=3D {
> >  	.splice_read	=3D nfs_file_splice_read,
> >  	.splice_write	=3D iter_file_splice_write,
> >  	.check_flags	=3D nfs_check_flags,
> > -	.setlease	=3D simple_nosetlease,
> >  	.fop_flags	=3D FOP_DONTCACHE,
> >  };
> >  EXPORT_SYMBOL_GPL(nfs_file_operations);
>=20
> Hey Jeff,
>=20
> I've noticed an NFS reexport regression in v6.19 and now v7.0-rc1
> (similar but different due to your series that requires opt-in via
> .setlease).
>=20
> Bisect first pointed out this commit:
> 10dcd5110678 nfs: properly disallow delegation requests on directories
>=20
> And now with v7.0-rc1 its the fact that NFS doesn't provide .setlease
> so lstat() on parent dir (of file that I touch) gets -EINVAL.
>=20
> So its a confluence of NFS's dir delegations and your setlease changes.
>=20
> If I reexport NFSv4.2 filesystem in terms of NFSv4.1, the regression
> is seen by doing (lstat reproducer that gemini spit out for me is
> attached):
>=20
> $ touch /mnt/share41/test
> $ strace ./lstat /mnt/share41
> ...
> lstat("/mnt/share41", 0x7ffec0d79920)   =3D -1 EINVAL (Invalid argument)
>=20
> If I immediately re-run it works:
> ...
> lstat("/mnt/share41", {st_mode=3DS_IFDIR|0777, st_size=3D4096, ...}) =3D =
0
>=20
> I'm not sure what the proper fix is yet, but I feel like you've missed
> that NFS itself can be (re)exported?
>=20
>=20

My apologies. I missed seeing this last week.

That's a very simple reproducer! That's very strange behavior,
especially since NFS4 does provide a setlease operation:

const struct file_operations nfs4_file_operations =3D {
	[...]
	.setlease       =3D nfs4_setlease,
	[...]
};

I'm not sure why this would cause lstat() to return -EINVAL. What's
happening on the wire when this occurs?

I'll plan to take a look here soon either way.
--=20
Jeff Layton <jlayton@kernel.org>

