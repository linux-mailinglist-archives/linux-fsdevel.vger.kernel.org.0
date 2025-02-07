Return-Path: <linux-fsdevel+bounces-41143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588B9A2B85E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 02:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BEA3A463D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DD2130A7D;
	Fri,  7 Feb 2025 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="laV0WsM7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0jd/mmOe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="laV0WsM7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0jd/mmOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11D2417E9;
	Fri,  7 Feb 2025 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738892780; cv=none; b=r5Uynbup0qsuzLppF94RJn1tYn3YWHxwD3JF5rG5PBTWXrBk2OYfWSydRZ1+Km2B+oMl3pHfZwq0cvSqtgA9MOqPjOsHlyq40nyR0P0vvVNBpflF9IBiTsFvQ2H8sPvgNheijL1S3RvJ5TA5x5A5s2R7KjO9X2GqG55ixgiCxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738892780; c=relaxed/simple;
	bh=vyN6wip6nRIJlBebL11txQIz9eMZV3O17tBpyh4CJMc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=K2QzGWlLurMosF6IoWlFJ5X640hXEYBqj76B4lhT9DQcAo4Fy5SPRyvSvuuOrrlnlAmHCWJL36b2aQ5TdOhYUh0+D4RaYAERauG2pDxN5pR26vYrSiooAHk2bGAMAuSWIPXv0Qxb2rYGKMnEKFqPIYk44x0WQbHxCmzf2QaNx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=laV0WsM7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0jd/mmOe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=laV0WsM7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0jd/mmOe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3AD671F38D;
	Fri,  7 Feb 2025 01:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738892774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6GvrIXCkvZhFMNZhMpwRWCpmsJvrlaPBg3GUv/AKQ8=;
	b=laV0WsM7pVKFRvpFE6yLnNSPNTtLMGtwRoLVSpJIeQwYdqu8vV51zcD3ri3Dwecn9g/VTg
	2+KSz6LF8lyhHrTMGgujKuEZUWWEnlwALIHnmnRNheL6F+Qqq9oFTIwGBVFU9LMWYTSD8v
	cgDXRx1Jozs67kLzW3yOQX8HTPGYxeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738892774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6GvrIXCkvZhFMNZhMpwRWCpmsJvrlaPBg3GUv/AKQ8=;
	b=0jd/mmOeRgAZe0X6lQtbhuHqJIjMGKg8OcEuK10vOTSGUXvHBn0aj7p0QbdtlU+1mqVByh
	HNzmAckKD9X8MyCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=laV0WsM7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="0jd/mmOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738892774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6GvrIXCkvZhFMNZhMpwRWCpmsJvrlaPBg3GUv/AKQ8=;
	b=laV0WsM7pVKFRvpFE6yLnNSPNTtLMGtwRoLVSpJIeQwYdqu8vV51zcD3ri3Dwecn9g/VTg
	2+KSz6LF8lyhHrTMGgujKuEZUWWEnlwALIHnmnRNheL6F+Qqq9oFTIwGBVFU9LMWYTSD8v
	cgDXRx1Jozs67kLzW3yOQX8HTPGYxeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738892774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6GvrIXCkvZhFMNZhMpwRWCpmsJvrlaPBg3GUv/AKQ8=;
	b=0jd/mmOeRgAZe0X6lQtbhuHqJIjMGKg8OcEuK10vOTSGUXvHBn0aj7p0QbdtlU+1mqVByh
	HNzmAckKD9X8MyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3059413694;
	Fri,  7 Feb 2025 01:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uOxiNeJlpWfCYQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 01:46:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/19] VFS: add _async versions of the various directory
 modifying inode_operations
In-reply-to: <20250206-bestochen-zulauf-34ce94cc4cbc@brauner>
References: <>, <20250206-bestochen-zulauf-34ce94cc4cbc@brauner>
Date: Fri, 07 Feb 2025 12:46:04 +1100
Message-id: <173889276405.22054.14269968343821905377@noble.neil.brown.name>
X-Rspamd-Queue-Id: 3AD671F38D
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 07 Feb 2025, Christian Brauner wrote:
> On Thu, Feb 06, 2025 at 04:42:46PM +1100, NeilBrown wrote:
> > These "_async" versions of various inode operations are only guaranteed
> > a shared lock on the directory but if the directory isn't exclusively
> > locked then they are guaranteed an exclusive lock on the dentry within
> > the directory (which will be implemented in a later patch).
> >=20
> > This will allow a graceful transition from exclusive to shared locking
> > for directory updates, and even to async updates which can complete with
> > no lock on the directory - only on the dentry.
> >=20
> > mkdir_async is a bit different as it optionally returns a new dentry
> > for cases when the filesystem is not able to use the original dentry.
> > This allows vfs_mkdir_return() to avoid the need for an extra lookup.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  Documentation/filesystems/locking.rst |  51 ++++++++-
> >  Documentation/filesystems/porting.rst |  10 ++
> >  Documentation/filesystems/vfs.rst     |  24 +++++
> >  fs/namei.c                            | 142 +++++++++++++++++++++-----
> >  include/linux/fs.h                    |  24 +++++
> >  5 files changed, 223 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesy=
stems/locking.rst
> > index d20a32b77b60..adeead366332 100644
> > --- a/Documentation/filesystems/locking.rst
> > +++ b/Documentation/filesystems/locking.rst
> > @@ -62,15 +62,24 @@ inode_operations
> >  prototypes::
> > =20
> >  	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,umode=
_t, bool);
> > +	int (*create_async) (struct mnt_idmap *, struct inode *,struct dentry *=
,umode_t, bool, struct dirop_ret *);
>=20
> If we end up doing this then imho the correct thing to do would be to
> extend the existing operations. Yes, that's more work I know as I've
> done that multiple times myself and it's a bit more annoying churn but
> we shouldn't just keep adding new methods without a good reason.
>=20
> I assume that you've done that mostly so that you wouldn't be held up by
> menial work for the prototype. That's obviously fine. But for the final
> thing we should just fixup everyone.

I did it this way because it follows a pattern I've seen before.
 readdir -> iterate -> iterate_shared
 ioctl -> unlocked_ioctl

There are three changes happening here:

1/ add "struct dirop_ret *ret" to the end of each function.  That could
  certainly be done across all filesystems in one patch
2/ change mkdir to return a dentry.  The might be doable in a single
  patch if NFS is the only filesystem affected.  The change is
  sufficiently intrusive that maintainers would want to review it
  carefully and might want to land it through their own tree.  But I
  suspect there are other filesystems that would be affected and I think
  it would be prohibitive to try to land this sort of change to multiple
  filesystems in a single patch.
3/ change these functions to work with only a shared lock on the
   directory.  I could try to do something a bit like what Linus
   did in
     Commit 3e3271549670 ("vfs: get rid of old '->iterate' directory operatio=
n")
   but the circumstances are quite different and the excuses he used
   there don't apply.  Also I would need to add an i_rwsem to every
   inode which is unlikely to go down well with the maintainers.  I'm
   sure the active ones would want to manage that change themselves.

So while I hope we get to the point of discarding all the non-async
operations in a little less than the 7 years that it took to get rid of
->iterate, I don't see how to make the change without introducing new
inode_operations.


>=20
> >  	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int=
);
> >  	int (*link) (struct dentry *,struct inode *,struct dentry *);
> > +	int (*link_async) (struct dentry *,struct inode *,struct dentry *, stru=
ct dirop_ret *);
> >  	int (*unlink) (struct inode *,struct dentry *);
> > +	int (*unlink_async) (struct inode *,struct dentry *, struct dirop_ret *=
);
> >  	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,cons=
t char *);
> > +	int (*symlink_async) (struct mnt_idmap *, struct inode *,struct dentry =
*,const char *m , struct dirop_ret *);
> >  	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_=
t);
> > +	struct dentry * (*mkdir_async) (struct mnt_idmap *, struct inode *,stru=
ct dentry *,umode_t, struct dirop_ret *);
> >  	int (*rmdir) (struct inode *,struct dentry *);
> > +	int (*rmdir_async) (struct inode *,struct dentry *, struct dirop_ret *);
> >  	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_=
t,dev_t);
> > +	int (*mknod_async) (struct mnt_idmap *, struct inode *,struct dentry *,=
umode_t,dev_t, struct dirop_ret *);
> >  	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
> >  			struct inode *, struct dentry *, unsigned int);
> > +	int (*rename_async) (struct mnt_idmap *, struct inode *, struct dentry =
*,
> > +			struct inode *, struct dentry *, unsigned int, struct dirop_ret *);
> >  	int (*readlink) (struct dentry *, char __user *,int);
> >  	const char *(*get_link) (struct dentry *, struct inode *, struct delaye=
d_call *);
> >  	void (*truncate) (struct inode *);
> > @@ -84,6 +93,9 @@ prototypes::
> >  	int (*atomic_open)(struct inode *, struct dentry *,
> >  				struct file *, unsigned open_flag,
> >  				umode_t create_mode);
> > +	int (*atomic_open_async)(struct inode *, struct dentry *,
> > +				struct file *, unsigned open_flag,
> > +				umode_t create_mode, struct dirop_ret *);
> >  	int (*tmpfile) (struct mnt_idmap *, struct inode *,
> >  			struct file *, umode_t);
> >  	int (*fileattr_set)(struct mnt_idmap *idmap,
> > @@ -95,18 +107,33 @@ prototypes::
> >  locking rules:
> >  	all may block
> > =20
> > +All directory-modifying operations are called with an exclusive lock on
> > +the target dentry or dentries using DCACHE_PAR_LOOKUP.  This allows the
> > +shared lock on i_rwsem for the _async ops to be safe.  The lock on
> > +i_rwsem may be dropped as soon as the op returns, though if it returns
> > +-EINPROGRESS the lock using DCACHE_PAR_UPDATE will not be dropped until
> > +the callback is called.
> > +
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  ops		i_rwsem(inode)
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  lookup:		shared
> >  create:		exclusive
> > +create_async:	shared
> >  link:		exclusive (both)
> > +link_async:	exclusive on source, shared on target
> >  mknod:		exclusive
> > +mknod_async:	shared
> >  symlink:	exclusive
> > +symlink_async:	shared
> >  mkdir:		exclusive
> > +mkdir_async:	shared
> >  unlink:		exclusive (both)
> > +unlink_async:	exclusive on object, shared on directory/name
> >  rmdir:		exclusive (both)(see below)
> > +rmdir_async:	exclusive on object, shared on directory/name (see below)
> >  rename:		exclusive (both parents, some children)	(see below)
> > +rename_async:	shared (both parents) exclusive (some children)	(see below)
> >  readlink:	no
> >  get_link:	no
> >  setattr:	exclusive
> > @@ -118,6 +145,7 @@ listxattr:	no
> >  fiemap:		no
> >  update_time:	no
> >  atomic_open:	shared (exclusive if O_CREAT is set in open flags)
> > +atomic_open_async:	shared (if O_CREAT is not set, then may not have excl=
usive lock on name)
> >  tmpfile:	no
> >  fileattr_get:	no or exclusive
> >  fileattr_set:	exclusive
> > @@ -125,8 +153,10 @@ get_offset_ctx  no
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > =20
> > -	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_rwsem
> > -	exclusive on victim.
> > +	Additionally, ->rmdir(), ->unlink() and ->rename(), as well as _async
> > +	versions, have ->i_rwsem exclusive on victim.  This exclusive lock
> > +        may be dropped when the op completes even if the async operation=
 is
> > +        continuing.
> >  	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
> >  	->unlink() and ->rename() have ->i_rwsem exclusive on all non-directori=
es
> >  	involved.
> > @@ -135,6 +165,23 @@ get_offset_ctx  no
> >  See Documentation/filesystems/directory-locking.rst for more detailed di=
scussion
> >  of the locking scheme for directory operations.
> > =20
> > +The _async operations will be passed a (non-NULL) struct dirop_ret point=
er::
> > +
> > +	struct dirop_ret {
> > +		union {
> > +			int err;
> > +			struct dentry *dentry;
> > +		};
> > +		void (*done_cb)(struct dirop_ret*);
> > +	};
> > +
> > +They may return -EINPROGRESS (or ERR_PTR(-EINPROGRESS)) in which case
> > +the op will continue asynchronously.  When it completes the result,
> > +which must NOT be -EINPROGRESS, is stored in err or dentry (as
> > +appropriate) and the done_cb() function is called.  Callers can only
> > +make use of the asynchrony when they determine that no lock need be held
> > +on i_rwsem.
> > +
> >  xattr_handler operations
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> > index 1639e78e3146..a736c9f30d9d 100644
> > --- a/Documentation/filesystems/porting.rst
> > +++ b/Documentation/filesystems/porting.rst
> > @@ -1157,3 +1157,13 @@ in normal case it points into the pathname being l=
ooked up.
> >  NOTE: if you need something like full path from the root of filesystem,
> >  you are still on your own - this assists with simple cases, but it's not
> >  magic.
> > +
> > +---
> > +
> > +**recommended**
> > +
> > +create_async, link_async, unlink_async, rmdir_async, mknod_async,
> > +rename_async, atomic_open_async can be provided instead of the
> > +corresponding inode_operations with the "_async" suffix.  Multiple
> > +_async operations can be performed in a given directory concurrently,
> > +but never on the same name.
> > diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystem=
s/vfs.rst
> > index 31eea688609a..e18655054e6c 100644
> > --- a/Documentation/filesystems/vfs.rst
> > +++ b/Documentation/filesystems/vfs.rst
> > @@ -491,15 +491,24 @@ As of kernel 2.6.22, the following members are defi=
ned:
> > =20
> >  	struct inode_operations {
> >  		int (*create) (struct mnt_idmap *, struct inode *,struct dentry *, umo=
de_t, bool);
> > +		int (*create_async) (struct mnt_idmap *, struct inode *,struct dentry =
*, umode_t, bool, struct dirop_ret *);
> >  		struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned in=
t);
> >  		int (*link) (struct dentry *,struct inode *,struct dentry *);
> > +		int (*link_async) (struct dentry *,struct inode *,struct dentry *, str=
uct dirop_ret *);
> >  		int (*unlink) (struct inode *,struct dentry *);
> > +		int (*unlink_async) (struct inode *,struct dentry *, struct dirop_ret =
*);
> >  		int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,con=
st char *);
> > +		int (*symlink_async) (struct mnt_idmap *, struct inode *,struct dentry=
 *,const char *, struct dirop_ret *);
> >  		int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode=
_t);
> > +		struct dentry * (*mkdir_async) (struct mnt_idmap *, struct inode *,str=
uct dentry *,umode_t, struct dirop_ret *);
> >  		int (*rmdir) (struct inode *,struct dentry *);
> > +		int (*rmdir_async) (struct inode *,struct dentry *, struct dirop_ret *=
);
> >  		int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode=
_t,dev_t);
> > +		int (*mknod_async) (struct mnt_idmap *, struct inode *,struct dentry *=
,umode_t,dev_t, struct dirop_ret *);
> >  		int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
> >  			       struct inode *, struct dentry *, unsigned int);
> > +		int (*rename_async) (struct mnt_idmap *, struct inode *, struct dentry=
 *,
> > +			       struct inode *, struct dentry *, unsigned int, struct dirop_re=
t *);
> >  		int (*readlink) (struct dentry *, char __user *,int);
> >  		const char *(*get_link) (struct dentry *, struct inode *,
> >  					 struct delayed_call *);
> > @@ -511,6 +520,8 @@ As of kernel 2.6.22, the following members are define=
d:
> >  		void (*update_time)(struct inode *, struct timespec *, int);
> >  		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
> >  				   unsigned open_flag, umode_t create_mode);
> > +		int (*atomic_open_async)(struct inode *, struct dentry *, struct file =
*,
> > +				   unsigned open_flag, umode_t create_mode, struct dirop_ret *);
> >  		int (*tmpfile) (struct mnt_idmap *, struct inode *, struct file *, umo=
de_t);
> >  		struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int=
);
> >  	        int (*set_acl)(struct mnt_idmap *, struct dentry *, struct posi=
x_acl *, int);
> > @@ -524,6 +535,7 @@ Again, all methods are called without any locks being=
 held, unless
> >  otherwise noted.
> > =20
> >  ``create``
> > +``create_async``
> >  	called by the open(2) and creat(2) system calls.  Only required
> >  	if you want to support regular files.  The dentry you get should
> >  	not have an inode (i.e. it should be a negative dentry).  Here
> > @@ -546,29 +558,39 @@ otherwise noted.
> >  	directory inode semaphore held
> > =20
> >  ``link``
> > +``link_async``
> >  	called by the link(2) system call.  Only required if you want to
> >  	support hard links.  You will probably need to call
> >  	d_instantiate() just as you would in the create() method
> > =20
> >  ``unlink``
> > +``unlink_async``
> >  	called by the unlink(2) system call.  Only required if you want
> >  	to support deleting inodes
> > =20
> >  ``symlink``
> > +``symlink_async``
> >  	called by the symlink(2) system call.  Only required if you want
> >  	to support symlinks.  You will probably need to call
> >  	d_instantiate() just as you would in the create() method
> > =20
> >  ``mkdir``
> > +``mkdir_async``
> >  	called by the mkdir(2) system call.  Only required if you want
> >  	to support creating subdirectories.  You will probably need to
> >  	call d_instantiate() just as you would in the create() method
> > =20
> > +	mkdir_async can return an alternate dentry, much like lookup.
> > +	In this case the original dentry will still be negative and will
> > +	be unhashed.
> > +
> >  ``rmdir``
> > +``rmdir_async``
> >  	called by the rmdir(2) system call.  Only required if you want
> >  	to support deleting subdirectories
> > =20
> >  ``mknod``
> > +``mknod_async``
> >  	called by the mknod(2) system call to create a device (char,
> >  	block) inode or a named pipe (FIFO) or socket.  Only required if
> >  	you want to support creating these types of inodes.  You will
> > @@ -576,6 +598,7 @@ otherwise noted.
> >  	create() method
> > =20
> >  ``rename``
> > +``rename_async``
> >  	called by the rename(2) system call to rename the object to have
> >  	the parent and name given by the second inode and dentry.
> > =20
> > @@ -647,6 +670,7 @@ otherwise noted.
> >  	itself and call mark_inode_dirty_sync.
> > =20
> >  ``atomic_open``
> > +``atomic_open_async``
> >  	called on the last component of an open.  Using this optional
> >  	method the filesystem can look up, possibly create and open the
> >  	file in one atomic operation.  If it wants to leave actual
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 3c0feca081a2..eadde9de73bf 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -123,6 +123,41 @@
> >   * PATH_MAX includes the nul terminator --RR.
> >   */
> > =20
> > +static void dirop_done_cb(struct dirop_ret *dret)
> > +{
> > +	wake_up_var(dret);
> > +}
> > +
> > +#define DO_DIROP(dir, op, ...)						\
> > +	({								\
> > +		 struct dirop_ret dret;					\
> > +		 int ret;						\
> > +		 dret.err =3D -EINPROGRESS;				\
> > +		 dret.done_cb =3D dirop_done_cb;				\
> > +		 ret =3D (dir)->i_op->op(__VA_ARGS__, &dret);		\
> > +		 if (ret =3D=3D -EINPROGRESS) {				\
> > +			 wait_var_event(&dret,				\
> > +					dret.err !=3D -EINPROGRESS);	\
> > +			 ret =3D dret.err;				\
> > +		 }							\
> > +		 ret;							\
> > +	})
> > +
> > +#define DO_DE_DIROP(dir, op, ...)					\
> > +	({								\
> > +		 struct dirop_ret dret;					\
> > +		 struct dentry *ret;					\
> > +		 dret.dentry =3D ERR_PTR(-EINPROGRESS);			\
> > +		 dret.done_cb =3D dirop_done_cb;				\
> > +		 ret =3D (dir)->i_op->op(__VA_ARGS__, &dret);		\
> > +		 if (ret =3D=3D ERR_PTR(-EINPROGRESS)) {			\
> > +			 wait_var_event(&dret,				\
> > +					dret.dentry !=3D ERR_PTR(-EINPROGRESS));	\
> > +			 ret =3D dret.dentry;				\
> > +		 }							\
> > +		 ret;							\
> > +	})
>=20
> We should also try to avoid these ugly wrappers. That'll be easier if we
> don't have multiple methods as well.

I don't think that the multiple methods make a whole lot of difference
here.  The same code would be in the function, it is just indented one
more level when there are multiple functions.  But if you would prefer
all the duplication of boiler-plate I can do it that way.

Thanks,
NeilBrown

