Return-Path: <linux-fsdevel+bounces-21337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1178090227F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 15:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077101C210C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B878C93;
	Mon, 10 Jun 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dc/fUZg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05D4501B
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025353; cv=none; b=LJDEBc8JuVzeg0Gl44P8y4AqAqbA864Fvl9pQaKSRBR1coAgyTGCInGg9AH/Iz2LsndGlA375+E32TIXDS680xpghdDdbbJcfYN/RKvciWiwrABTjVdErOSj2Q9danpi1UAVtnX0rOj+/eMgZUzJVI8fDBo9gOmUEipsGR0Df4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025353; c=relaxed/simple;
	bh=5Kt40zvfRtAwCDh4zkftZ4VU81udv4hwmEKh2xGXY4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOwXVFAUrflJLPahNH1aovPgkBTzR0S7WrHTcNdIXfLpVttGeMCS57KXfDKhKmY4UBHuQhHJYOem2Y9RPMiy4UxBtgUDFazDdbnlJJ7rNdfXl1KR8QHgtYEYvGUK9Yv7AcjUD0xxuR9ILRMgZi3wfxrhncvvTqYzqd7nSUEo8C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dc/fUZg0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718025350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cKuaoO0guRqh8XWo7y8MffDruo71KjsxXQ1SxS+xRg=;
	b=dc/fUZg0lCs1KSjKlx5SkIE4PYo16VO8uCwfQXwvVXb5I9lGSdOVC7PFwTf5l0TR8Ovd3W
	whEIZFR8rHfaZJ0Jf2ebwn4RiaraoOKuVVfPCFo5m487//ncd88+0zcfjVaW66IyDjoAYx
	7gWKTfAJ8eJOZGkl+Vmi/WeP9i6WoSU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-kl_nKA_8MReOEFYsdc_jLw-1; Mon,
 10 Jun 2024 09:15:45 -0400
X-MC-Unique: kl_nKA_8MReOEFYsdc_jLw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7F2A19560AA;
	Mon, 10 Jun 2024 13:15:43 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B00321955E80;
	Mon, 10 Jun 2024 13:15:40 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: A fs-next branch
Date: Mon, 10 Jun 2024 15:15:38 +0200
Message-ID: <20240610131539.685670-1-agruenba@redhat.com>
In-Reply-To: <20240529143558.4e1fc740@canb.auug.org.au>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org> <20240520132326.52392f8d@canb.auug.org.au> <ZkvCyB1-WpxH7512@casper.infradead.org> <20240528091629.3b8de7e0@canb.auug.org.au> <20240529143558.4e1fc740@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Stephen,

On Wed, 29 May 2024 14:35:58 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
> 
> On Tue, 28 May 2024 09:16:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Mon, 20 May 2024 22:38:16 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > As I understand the structure of linux-next right now, you merge one
> > > tree after another in some order which isn't relevant to me, so I have no
> > > idea what it is.  What we're asking for is that we end up with a branch
> > > in your tree called fs-next that is:
> > > 
> > >  - Linus's tree as of that day
> > >  - plus the vfs trees
> > >  - plus xfs, btrfs, ext4, nfs, cifs, ...
> > > 
> > > but not, eg, graphics, i2c, tip, networking, etc
> > > 
> > > How we get that branch is really up to you; if you want to start by
> > > merging all the filesystem trees, tag that, then continue merging all the
> > > other trees, that would work.  If you want to merge all the filesystem
> > > trees to fs-next, then merge the fs-next tree at some point in your list
> > > of trees, that would work too.
> > > 
> > > Also, I don't think we care if it's a branch or a tag.  Just something
> > > we can call fs-next to all test against and submit patches against.
> > > The important thing is that we get your resolution of any conflicts.
> > > 
> > > There was debate about whether we wanted to include mm-stable in this
> > > tree, and I think that debate will continue, but I don't think it'll be
> > > a big difference to you whether we ask you to include it or not?  
> > 
> > OK, I can see how to do that.  I will start on it tomorrow.  The plan
> > is that you will end up with a branch (fs-next) in the linux-next tree
> > that will be a merge of the above trees each day and I will merge it
> > into the -next tree as well.
> 
> OK, this is what I have done today:
> 
> I have created 2 new branches local to linux-next - fs-current and fs-next.
> 
> fs-current is based on Linus' tree of the day and contains the
> following trees (name, contacts, URL, branch):
> 
> fscrypt-current	Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>	git://git.kernel.org/pub/scm/fs/fscrypt/linux.git	for-current
> fsverity-current	Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>	git://git.kernel.org/pub/scm/fs/fsverity/linux.git	for-current
> btrfs-fixes	David Sterba <dsterba@suse.cz>	git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git	next-fixes
> vfs-fixes	Al Viro <viro@ZenIV.linux.org.uk>	git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git	fixes
> erofs-fixes	Gao Xiang <xiang@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git	fixes
> nfsd-fixes	Chuck Lever <chuck.lever@oracle.com>	git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux	nfsd-fixes
> v9fs-fixes	Eric Van Hensbergen <ericvh@gmail.com>	git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git	fixes/next
> overlayfs-fixes	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>	git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git	ovl-fixes
> 
> 
> The fs-next tree is based on fs-current and contains these trees:
> 
> bcachefs	Kent Overstreet <kent.overstreet@linux.dev>	https://evilpiepirate.org/git/bcachefs.git	for-next
> pidfd	Christian Brauner <brauner@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git	for-next
> fscrypt	Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>	git://git.kernel.org/pub/scm/fs/fscrypt/linux.git	for-next
> afs	David Howells <dhowells@redhat.com>	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git	afs-next
> btrfs	David Sterba <dsterba@suse.cz>	git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git	for-next
> ceph	Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>	git://github.com/ceph/ceph-client.git	master
> cifs	Steve French <smfrench@gmail.com>, CIFS <linux-cifs@vger.kernel.org>	git://git.samba.org/sfrench/cifs-2.6.git	for-next
> configfs	Christoph Hellwig <hch@lst.de>	git://git.infradead.org/users/hch/configfs.git	for-next
> erofs	Gao Xiang <xiang@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git	dev
> exfat	Namjae Jeon <linkinjeon@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git	dev
> exportfs	Chuck Lever <chuck.lever@oracle.com>	git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux	exportfs-next
> ext3	Jan Kara <jack@suse.cz>	git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git	for_next
> ext4	Theodore Ts'o <tytso@mit.edu>	git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git	dev
> f2fs	Jaegeuk Kim <jaegeuk@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git	dev
> fsverity	Eric Biggers <ebiggers@kernel.org>, Theodore Y. Ts'o <tytso@mit.edu>	git://git.kernel.org/pub/scm/fs/fsverity/linux.git	for-next
> fuse	Miklos Szeredi <miklos@szeredi.hu>	git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git	for-next
> gfs2	Steven Whitehouse <swhiteho@redhat.com>, Bob Peterson <rpeterso@redhat.com>	git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git	for-next
> jfs	Dave Kleikamp <dave.kleikamp@oracle.com>	git://github.com/kleikamp/linux-shaggy.git	jfs-next
> ksmbd	Steve French <smfrench@gmail.com>	https://github.com/smfrench/smb3-kernel.git	ksmbd-for-next
> nfs	Trond Myklebust <trondmy@gmail.com>	git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git	linux-next
> nfs-anna	Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>, NFS Mailing List <linux-nfs@vger.kernel.org>	git://git.linux-nfs.org/projects/anna/linux-nfs.git	linux-next
> nfsd	Chuck Lever <chuck.lever@oracle.com>	git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux	nfsd-next
> ntfs3	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>	https://github.com/Paragon-Software-Group/linux-ntfs3.git	master
> orangefs	Mike Marshall <hubcap@omnibond.com>	git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux	for-next
> overlayfs	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>	git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git	overlayfs-next
> ubifs	Richard Weinberger <richard@nod.at>	git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git	next
> v9fs	Dominique Martinet <asmadeus@codewreck.org>	git://github.com/martinetd/linux	9p-next
> v9fs-ericvh	Eric Van Hensbergen <ericvh@gmail.com>	git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git	ericvh/for-next
> xfs	Darrick J. Wong <djwong@kernel.org>, David Chinner <david@fromorbit.com>, <linux-xfs@vger.kernel.org>	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git	for-next
> zonefs	Damien Le Moal <Damien.LeMoal@wdc.com>	git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git	for-next
> iomap	Darrick J. Wong <djwong@kernel.org>	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git	iomap-for-next
> djw-vfs	Darrick J. Wong <djwong@kernel.org>	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git	vfs-for-next
> file-locks	Jeff Layton <jlayton@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git	locks-next
> iversion	Jeff Layton <jlayton@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git	iversion-next
> vfs-brauner	Christian Brauner <brauner@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git	vfs.all
> vfs	Al Viro <viro@ZenIV.linux.org.uk>	git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git	for-next
> 
> Please let me know if you want them reordered or some removed/added.
> 
> Both these branches will be exported with the linux-next tree each day.

I don't know if it's relevant, but gfs2 is closely related to dlm, and dlm
isn't included here.  Would it make sense to either move dlm into fs-next, or
move gfs2 out of it, to where dlm is merged?

Thanks,
Andreas


