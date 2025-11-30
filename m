Return-Path: <linux-fsdevel+bounces-70268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B2C94986
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 01:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1143A6406
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 00:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24411C5D7D;
	Sun, 30 Nov 2025 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="P0lI00AM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6D18FDDB;
	Sun, 30 Nov 2025 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764461961; cv=none; b=s5fcQmbNb6WvjOpnmNj6SB8SfSlfeQL3K0t48l1wjsVmXXfxKQMKV1zxrhj+DhG8vIJhX7IuRkxklyJyLmLaOrvugkFKoPyW4Bfdf0XA9WIZpLA1BUKSmA6R5WXM/vvhcFwuDJWGsCjMpRVXW+O2i7chgTzD6FZMRui8L/jxcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764461961; c=relaxed/simple;
	bh=HFGaExAsqMAWO5sUzUnvqPSfrdycmZcM33Wu9Kesduw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPrDELIEkD6ArhiPm02HBkqAE17SLcV8YOdra5ZlgTg7aJ2++rOiJ74rWMctKHOfNC9U9Lg42jqupQnm+fDQmoFObBra3NS4yd6UYYzr7ZVLUqsbEAt9OIup7jECajtxkaKZtaI4g/pFgibONVoRk3ldUo4MmZqW0emL1YGfXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=P0lI00AM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/QciF8G+P9yAIBwI/Xv/gYc2UTZnSkqo4skR1MpMD7w=; b=P0lI00AMxhFts2RFB74Z0P96Sh
	E8woe6RG9A+6J5H20ey0imQtCJMcy5U1TWTK7Iu1T2P7EuNyuA7oTrbFVjxkqfviAnpZeISCqG7U4
	ZcYBq1rW6Xg4/XpVHZAI+OGOmKpBc2nwqfLCACY0TWVOoLR2+2suf458IULSa7HTAvPGyQFApiC+u
	c22Uhl84dnaPOo+ZMjL2AfJHrHbHY9RgSC8ELZXYIGm/SvU5zD7wC2K3d3ASdk0vxK9inq/WokTWB
	IvBl34Sx+XRhxeumVN/fwUK8HaXStoRMX9DU6QKNZadt4O1WJtGTCI+NxgS2dVYQLr7PO3FK6v76S
	fLoFcoLw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPV9q-000000097kZ-20ez;
	Sun, 30 Nov 2025 00:19:18 +0000
Date: Sun, 30 Nov 2025 00:19:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Val Packett <val@packett.cool>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 06/15] VFS: introduce start_creating_noperm() and
 start_removing_noperm()
Message-ID: <20251130001918.GM3538@ZenIV>
References: <20251113002050.676694-1-neilb@ownmail.net>
 <20251113002050.676694-7-neilb@ownmail.net>
 <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 29, 2025 at 09:01:05PM -0300, Val Packett wrote:

> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 316922d5dd13..a0d5b302bcc2 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1397,27 +1397,25 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
> >   	if (!parent)
> >   		return -ENOENT;
> > -	inode_lock_nested(parent, I_MUTEX_PARENT);
> >   	if (!S_ISDIR(parent->i_mode))
> > -		goto unlock;
> > +		goto put_parent;
> >   	err = -ENOENT;
> >   	dir = d_find_alias(parent);
> >   	if (!dir)
> > -		goto unlock;
> > +		goto put_parent;
> > -	name->hash = full_name_hash(dir, name->name, name->len);
> > -	entry = d_lookup(dir, name);
> > +	entry = start_removing_noperm(dir, name);
> >   	dput(dir);
> > -	if (!entry)
> > -		goto unlock;
> > +	if (IS_ERR(entry))
> > +		goto put_parent;
> 
> This broke xdg-document-portal (and potentially other FUSE filesystems) by
> introducing a massive deadlock.

ACK.  That chunk needs to be reverted - this is *not* "remove an object by
parent and name", it's "invalidate stuff under that parent with this
first name component" and I would like to understand what FUSE_EXPIRE_ONLY
thing is about.

Miklos, could you give some details on that thing?  This chunk definitely
needs to go, the question is what that code is trying to do other than
d_invalidate()...

