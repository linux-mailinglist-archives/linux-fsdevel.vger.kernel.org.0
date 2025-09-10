Return-Path: <linux-fsdevel+bounces-60762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 446CBB515B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 13:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF09D4E2F4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32B327F01D;
	Wed, 10 Sep 2025 11:30:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00967262FD4;
	Wed, 10 Sep 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503836; cv=none; b=iR6hsJFPJkjYw8rLp+7SaAo+zwG4C6L5KliHv9zoq7OUU5/uPiF/8+M+eDND3lGkpQVppqnnvHNRkoV4CnM6BjklC8uClZlPaq9TN79ckENjEDjrDLfdrXVJQk6IDSMKCfp7EyuKL+toDU1d7BBa65OSCr9AhCDRbx/X/gUCFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503836; c=relaxed/simple;
	bh=RTrGj6ABLt6DHxX3XWUHh+ePbMgtGzsB4NRIpo/UWFc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bbp2OyWr387Mad/UvxHMHzlku9WXyP1wwk0kMqyFJBBFQhGsAA/XTzH1TtK1GlEBQ2Is7upWUhzLXwNk2O25q5VeSn0J4VrDeg/WOja4jUr5ICIcJMpeymgx0erVP4PQzu3vZ4rurVWcLinGlAz6IeIZnaQ8oQvofaxdtvnRZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uwJ1w-008wSj-Ri;
	Wed, 10 Sep 2025 11:30:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Use simple_start_creating() in various places.
In-reply-to: <f402ec5ce57c872f436d1b6a5e9c3633ba237a26.camel@kernel.org>
References: <>, <f402ec5ce57c872f436d1b6a5e9c3633ba237a26.camel@kernel.org>
Date: Wed, 10 Sep 2025 21:30:29 +1000
Message-id: <175750382935.2850467.264144428541875879@noble.neil.brown.name>

On Wed, 10 Sep 2025, Jeff Layton wrote:
> On Wed, 2025-09-10 at 08:37 +0100, Al Viro wrote:
> > > ... and see viro/vfs.git#work.persistency for the part of the queue that
> > > had order already settled down (I'm reshuffling the tail at the moment;
> > > hypfs commit is still in the leftovers pile - the whole thing used to
> > > have a really messy topology, with most of the prep work that used to
> > > be the cause of that topology already in mainline - e.g. rpc_pipefs
> > > series, securityfs one, etc.)
> >=20
> > Speaking of which, nfsctl series contains the following and I'd like to
> > make sure that behaviour being fixed there *is* just an accident...
> > Could nfsd folks comment?
> >=20
> > [PATCH] nfsctl: don't bump st_nlink of directory when creating a symlink =
in it
> > =C2=A0=C2=A0=C2=A0=C2=A0
> >=20
> > apparently blindly copied from mkdir...
> > =C2=A0=C2=A0=C2=A0=C2=A0
> >=20
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index bc6b776fc657..282b961d8788 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1181,7 +1181,6 @@ static int __nfsd_symlink(struct inode *dir, struct=
 dentry *dentry,
> > =C2=A0	inode->i_size =3D strlen(content);
> > =C2=A0
> >=20
> > =C2=A0	d_add(dentry, inode);
> > -	inc_nlink(dir);
> > =C2=A0	fsnotify_create(dir, dentry);
> > =C2=A0	return 0;
> > =C2=A0}
>=20
> That is increasing the link count on the parent because it's adding a
> dentry to "dir". The link count on a dir doesn't have much meaning, but
> why do we need to remove it here, but keep the one in __nfsd_mkdir?

The link count in an inode is the number of links *to* the inode.
A symlink (or file etc) in a directory doesn't imply a link to that
directory (they are links "from" the directory, but those aren't counted).
A directory in a directory, on the other hand, does imply a link to the
(parent) directory due to the ".." entry.

In fact the link count on a directory should always be 2 plus the number
of subdirectories (one for the name in the parent, one for "." in the
directory itself, and one for ".." in each subdirectory).  Some "find"
style programs depend on that to a degree, though mostly as an
optimisation.

NeilBrown

