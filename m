Return-Path: <linux-fsdevel+bounces-55630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A682B0CE5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 01:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B3C1AA3202
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 23:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2877242D66;
	Mon, 21 Jul 2025 23:48:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823812E7F;
	Mon, 21 Jul 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141705; cv=none; b=DIGIN+o/BZHkacP48fOmodoIPkR8AjZ5eAnhEjv0plj84EphxEOu2zHb49NEQ+DcPQvh4mDSIjViFVjTdWhJH2Zhhcr54ry+m6+Tx30dojDBoOgKU+5w51WgrOUo3MjWGcVG+HAorGQL5WsjTwYqxp0vWvbzDdi1ZuV1+MbBpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141705; c=relaxed/simple;
	bh=bLkisddWz2MdV99qRBHcQ8LvMB5+/8ZBftwoAJTqlMM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=eq9wdNy3ZRE+bHTCVIWIWsGb0uUGppZwXx67LxOwAWFbGvuHnFzzs/dHzF3wFVuuxN5QiUFsiDFKLvB1NuJHvraDadmK6VXb752znawgu4pdKy76NMV8X9rzLYGjDhrzchrmB3PNunIG5XQdnqT7/6skZSHi4svlAuU/ivbOS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ue0F1-002unJ-5B;
	Mon, 21 Jul 2025 23:48:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7 RFC] New APIs for name lookup and lock for directory
 operations
In-reply-to:
 <CAOQ4uxgd=POQATEhPdwqyX-hCQAHCTcxJsvyOS6=2yojMh399Q@mail.gmail.com>
References: <20250721084412.370258-1-neil@brown.name>,
 <CAOQ4uxgd=POQATEhPdwqyX-hCQAHCTcxJsvyOS6=2yojMh399Q@mail.gmail.com>
Date: Tue, 22 Jul 2025 09:48:20 +1000
Message-id: <175314170043.2234665.2076268504915475261@noble.neil.brown.name>

On Mon, 21 Jul 2025, Amir Goldstein wrote:
> On Mon, Jul 21, 2025 at 10:46=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > Hi,
> >
> >  these patches (against vfs.all) primarily introduce new APIs for
> >  preparing dentries for create, remove, rename.  The goal is to
> >  centralise knowledge of how we do locking (currently by locking the
> >  directory) so that we can eventually change the mechanism (e.g.  to
> >  locking just the dentry).
> >
> >  Naming is difficult and I've changed my mind several times. :-)
>=20
> Indeed it is.
> I generally like the done_ approach that you took.
> Few minor naming comments follow.
>=20
> >
> >  The basic approach is to return a dentry which can be passed to
> >  vfs_create(), vfs_unlink() etc, and subsequently to release that
> >  dentry.  The closest analogue to this in the VFS is kern_path_create()
> >  which is paired with done_path_create(), though there is also
> >  kern_path_locked() which is paired with explicit inode_unlock() and
> >  dput().  So my current approach uses "done_" for finishing up.
> >
> >  I have:
> >    dentry_lookup() dentry_lookup_noperm() dentry_lookup_hashed()
>=20
> As I wrote on the patch that introduces them I find dentry_lookup_hashed()
> confusing because the dentry is not hashed (only the hash is calculated).
>=20
> Looking at another precedent of _noperm() vfs API we have:
>=20
> vfs_setxattr()
>   __vfs_setxattr_locked()
>     __vfs_setxattr_noperm()
>       __vfs_setxattr()
>=20
> Do I'd say for lack of better naming __dentry_lookup() could makes sense
> for the bare lock&dget and it could also be introduced earlier along with
> introducing done_dentry_lookup()
>=20
> >    dentry_lookup_killable()
> >  paired with
> >    done_dentry_lookup()
> >
> >  and also
> >    rename_lookup() rename_lookup_noperm() rename_lookup_hashed()
> >  paired with
> >    done_rename_lookup()
> >  (these take a "struct renamedata *" to which some qstrs are added.
> >
> >  There is also "dentry_lock_in()" which is used instead of
> >  dentry_lookup() when you already have the dentry and want to lock it.
> >  So you "lock" it "in" a given parent.  I'm not very proud of this name,
> >  but I don't want to use "dentry_lock" as I want to save that for
> >  low-level locking primitives.
>=20
> Very strange name :)

I wanted to encourage people to comment !!

>=20
> What's wrong with dentry_lock_parent()?

That sounds like we are locking the parent, but we are conceptually locking
the dentry (Though at first we do that by locking the whole directory).

>=20
> Although I think that using the verb _lock_ for locking and dget is
> actively confusing, so something along the lines of
> resume_dentry_lookup()/dentry_lookup_reacquire() might serve the
> readers of the code better.

Hmmm....  there is certainly potential there.  dentry_lookup_continue()
???

>=20
> >
> >  There is also done_dentry_lookup_return() which doesn't dput() the
> >  dentry but returns it instread.  In about 1/6 of places where I need
> >  done_dentry_lookup() the code makes use of the dentry afterwards.  Only
> >  in half the places where done_dentry_lookup_return() is used is the
> >  returned value immediately returned by the calling function.  I could
> >  do a dget() before done_dentry_lookup(), but that looks awkward and I
> >  think having the _return version is justified.  I'm happy to hear other
> >  opinions.
>=20
> The name is not very descriptive IMO, but I do not have a better suggestion.
> Unless you can describe it for the purpose that it is used for, e.g.
> yeild_dentry_lookup() that can be followed with resume_dentry_lookup(),
> but I do not know if those are your intentions for the return API.

The intention is that a few places (maybe a dozen) need to keep a
reference to the dentry after the operation completes.  Typically this
is a mkdir or a create.  The caller might then want to create another
file in the directory so it holds on to the dentry.
A fairly common case is that virtual filesystems hold an extra reference
to everything they create so the dcache becomes the primary store.

I suspect that in the latter case it is better to have an explicit
dget() with a comment saying "preserve in cache until explicitly
removed" or similar.
For the former case it might be better to introduce a new dentry
variable.

 dentry =3D dentry_lookup(....);
 dentry =3D vfs_mkdir(dir, dentry);
 if (!IS_ERR(dentry))
        returnval =3D dget(dentry);
 done_dentry_lookup(dentry)

 return returnval;

Maybe I should enhance dget() to pass through errors as well as NULL.

Maybe the above would look even better as

 struct dentry *dentry __free(lookup) =3D dentry_lookup(.....);
 /* handle error */
 dentry =3D vfs_mkdir(dir, dentry);
 return dget(dentry);

So I'll try dropping the _return version, enhancing dget, and adding a
DEFINE_FREE.

Thanks,
NeilBrown



>=20
> Thanks,
> Amir.
>=20
> >
> >  In order for this dentry-focussed API to work we need to have the
> >  dentry to unlock.  vfs_rmdir() currently consumes the dentry on
> >  failure, so we don't have it unless we clumsily keep a copy.  So an
> >  early patch changes vfs_rmdir() to both consume the dentry and drop the
> >  lock on failure.
> >
> >  After these new APIs are refined, agreed, and applied I will have a
> >  collection of patches to roll them out throughout the kernel.  Then we
> >  can start/continue discussing a new approach to locking which allows
> >  directory operations to proceed in parallel.
> >
> >  If you want a sneak peek at some of this future work - for context
> >  mostly - my current devel code is at https://github.com/neilbrown/linux.=
git
> >  in a branch "pdirops".  Be warned that a lot of the later code is under
> >  development, is known to be wrong, and doesn't even compile.  Not today
> >  anyway.  The rolling out of the new APIs is fairly mature though.
> >
> >  Please review and suggest better names, or tell me that my choices are a=
dequate.
> >  And find the bugs in the code too :-)
> >
> >  I haven't cc:ed the maintains of the non-VFS code that the patches
> >  touch.  I can do that once the approach and names have been approved.
> >
> > Thanks,
> > NeilBrown
> >
> >
> >  [PATCH 1/7] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
> >  [PATCH 2/7] VFS: introduce done_dentry_lookup()
> >  [PATCH 3/7] VFS: Change vfs_mkdir() to unlock on failure.
> >  [PATCH 4/7] VFS: introduce dentry_lookup() and friends
> >  [PATCH 5/7] VFS: add dentry_lookup_killable()
> >  [PATCH 6/7] VFS: add rename_lookup()
> >  [PATCH 7/7] VFS: introduce dentry_lock_in()
> >
>=20


