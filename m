Return-Path: <linux-fsdevel+bounces-44156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4097A63B07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 03:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA3516CD3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 02:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7897149E17;
	Mon, 17 Mar 2025 02:07:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70D79D2;
	Mon, 17 Mar 2025 02:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742177232; cv=none; b=nLR+Gcn3SJ/lxU+WlmZZO7zpu0ST7AzckaYb9T8xkp04vUR2kzIisQD/mvCqCXWSCj7aJ1vSUvDvXAkLTpvb/5wtG66M9gxVn6TA0WybbuPhmtqjhWZGxI6gtixaV3MrbdVR7KZsrG9iJqlHGoZ8iMtDyqnHIlSjc+g+azBAfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742177232; c=relaxed/simple;
	bh=jeEByFFPgdnLDeam8TpTWXZ7GYpK8mHWzg/d9BDeTTE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rywXZFPktCGIib8Sl7Vu8ByGb+vPiwd1JJ/AVTfAp+qkZAN8yQq29dAMe9SXp5MZMs00+V+mw+ePlw7jen6D6SSPB/BXZbBL8UNFMchIsWuF90wcTS2ABXXyZv2i3YP17OIMn1UKARyc3CpROia6/+cl15MvL7zOAD+ZDT13Aqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ttzsX-00Ex48-GZ;
	Mon, 17 Mar 2025 02:06:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/8 RFC] tidy up various VFS lookup functions
In-reply-to: <20250314-geprobt-akademie-cae577d90899@brauner>
References: <20250314045655.603377-1-neil@brown.name>,
 <20250314-geprobt-akademie-cae577d90899@brauner>
Date: Mon, 17 Mar 2025 13:06:57 +1100
Message-id: <174217721714.9342.9504907056839144338@noble.neil.brown.name>

On Fri, 14 Mar 2025, Christian Brauner wrote:
> On Fri, Mar 14, 2025 at 11:34:06AM +1100, NeilBrown wrote:
> > VFS has some functions with names containing "lookup_one_len" and others
> > without the "_len".  This difference has nothing to do with "len".
> >=20
> > The functions without "_len" take a "mnt_idmap" pointer.  This is found
>=20
> When we added idmapped mounts there were all these *_len() helpers and I
> orignally had just ported them to pass mnt_idmap. But we decided to not
> do this. The argument might have been that most callers don't need to be
> switched (I'm not actually sure if that's still true now that we have
> quite a few filesystems that do support idmapped mounts.).
>=20
> So then we added new helper and then we decided to use better naming
> then that *_len() stuff. That's about it.
>=20
> > in the "vfsmount" and that is an important question when choosing which
> > to use: do you have a vfsmount, or are you "inside" the filesystem.  A
> > related question is "is permission checking relevant here?".
> >=20
> > nfsd and cachefiles *do* have a vfsmount but *don't* use the non-_len
> > functions.  They pass nop_mnt_idmap which is not correct if the vfsmount
> > is actually idmaped.  For cachefiles it probably (?) doesn't matter as
> > the accesses to the backing filesystem are always does with elevated priv=
ileged (?).
>=20
> Cachefiles explicitly refuse being mounted on top of an idmapped mount
> and they require that the mount is attached (check_mnt()) and an
> attached mount can never be idmapped as it has already been exposed in
> the filesystem hierarchy.
>=20
> >=20
> > For nfsd it would matter if anyone exported an idmapped filesystem.  I
> > wonder if anyone has tried...
>=20
> nfsd doesn't support exporting idmapped mounts. See check_export() where
> that's explicitly checked.
>=20
> If there are ways to circumvent this I'd be good to know.

I should have checked that they rejected idmapped mounts
(is_idmapped_mnt()).  But I think that just changes my justification for
the change, not my desire to make the change.

There are two contexts in which lookup is done.  One is the common
context when there is a vfsmount present and permission checking is
expected.  nfsd and cachefiles both fit this context.

The other is when there is no vfsmount and/or permission checking is not
relevant.  This happens after lookup_parentat when the permission check
has already been performed, and in various virtual filesystems when the
filesystem itself is adding/removing files or in normal filesystems
where dedicated names like "lost+found" and "quota" are being accessed.

I would like to make a clear distinction between these, and for that to
be done nfsd and cachefiles need to be changed to clearly fit the first
context.  Whether they should allow idmapped mounts or not is to some
extent a separate question.  They do want to do permission checking
(certainly nfsd does) so they should use the same API as other
permission-checking code.

>=20
> >=20
> > These patches change the "lookup_one" functions to take a vfsmount
> > instead of a mnt_idmap because I think that makes the intention clearer.
>=20
> Please don't!
>=20
> These internal lookup helpers intentionally do not take a vfsmount.
> First, because they can be called in places where access to a vfsmount
> isn't possible and we don't want to pass vfsmounts down to filesystems
> ever!

There are two sorts of internal lookup helpers.
Those that currently don't even take a mnt_idmap and are called, as you
say, in places where a vfsmount isn't available.
And those that are currently called with a mnt_idmap and called (after a
few cleanup) in places where a vfsmount is readily available.


>=20
> Second, the mnt_idmap pointer is - with few safe exceptions - is
> retrieved once in the VFS and then passed down so that e.g., permission
> checking and file creation are guaranteed to use the same mnt_idmap
> pointer.

In every case that I changed a call to pass a vfsmount instead of a
mnt_idmap, the mnt_idmap had recently been fetched from the vfsmount,
often by mnt_idmap() in the first argument to lookup_one().  Sometimes
by file_mnt_idmap() or similar.  So the patch never changed the safety
of the idmap.

One purpose of this change is to force callers to either acknowledge
that not permission checking is needed (by using a _noperm interface),
or to provide the correct idmap (not nop_mnt_idmap).

I understand that for object creation interfaces (vfs_mkdir etc) this
wouldn't work.  For these the idmap isn't needed only for permission
checking, but also for assigning an initial uid so the simple "vfsmount
or noperm" distinction doesn't work.  But for lookup I think it does.

>=20
> A caller may start out with a non-idmapped detached mount (e.g., via
> fsmount() or OPEN_TREE_CLONE) (nop_mnt_idmap) and call
> inode_permission(). Now someone idmaps that mount. Now further down the
> callchain someone calls lookup_one() which now retrieves the idmapping
> again and now it's an idmapped mount. Now permission checking is out of
> sync. That's an unlikely scenario but it's possible so lookup_one() is
> not supposed to retrieve the idmapping again. Please keep passing it
> explicitly. I've also written that down in the Documenation somewhere.
>=20

I couldn't easily find such documentation but I didn't look *very* hard.
fsmount and OPEN_TREE_CLONE only seem to be used in selftests though I
guess they could get used elsewhere.  However current callers of
lookup_one() always get the idmap from the vfsmount shortly before
calling lookup_one.

>=20
> >=20
> > It also renames the "_one" functions to be "_noperm" and removes the
> > permission checking completely.  In all cases where they are (correctly)
> > used permission checking is irrelevant.
>=20
> Ok, that sounds fine. Though I haven't taken the time to check the
> callers yet. I'll try to do that during the weekend.
>=20
> >=20
> > I haven't included changes to afs because there are patches in vfs.all
> > which make a lot of changes to lookup in afs.  I think (if they are seen
> > as a good idea) these patches should aim to land after the afs patches
> > and any further fixup in afs can happen then.
> >=20
> > The nfsd and cachefiles patches probably should be separate.  Maybe I
> > should submit those to relevant maintainers first, and one afs,
> > cachefiles, and nfsd changes have landed I can submit this series with
> > appropriate modifications.
> >=20
> > May main question for review is : have I understood mnt_idmap correctly?
>=20
> I mean, you didn't ask semantic questions so much as syntactic, I think.
> I hope I explained the reasoning sufficiently.
>=20

You have helped me see some aspects of idmapping which I hadn't seen as
clearly before - thanks.

NeilBrown

