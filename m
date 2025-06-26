Return-Path: <linux-fsdevel+bounces-53045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE54DAE9395
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 03:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F60B4A4EFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D619ADA2;
	Thu, 26 Jun 2025 01:05:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726492F1FF1;
	Thu, 26 Jun 2025 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750899933; cv=none; b=aIM/KV0i9ubzeRjRWqTyJa9nCY/JBSyT0whHj+bCz6KiPbZJAey3hI0Z2Ld4cXXzZ8ZFOfO8yPr6BTl0w/Tmgt8Xf7iHAq3VyUUuL44prI9cQyy/OxSAymlE5JJn9K0559MDWDlYWnGWR4zsDbtnahNMlaCKCdwNSDZ5jWHP0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750899933; c=relaxed/simple;
	bh=Jz1iF/Qoa3fauHETpavSK7hWEM30fCiMy4HqpZj2emY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SCwk0ZZKUjN1NbYwlM5Pd9oKHRfimWW05VHU6fs8FwzElqRsMn1EGstDMH9nMxcTlMyqKXD99g5Fe0AduRn/JBda4qe6AK9DS9jPRA5UMSFFxDd+jUTQGloNWX6SiEl+Brpfisp6nHa8VWvTELwSW/6yE8Z1g2pRI4N1v364TEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUb3M-00512l-B9;
	Thu, 26 Jun 2025 01:05:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Tingmao Wang" <m@maowtm.org>
Cc: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Song Liu" <song@kernel.org>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, brauner@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
 =?utf-8?q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
In-reply-to: <4577db64-64f2-4102-b00e-2e7921638a7c@maowtm.org>
References: <>, <4577db64-64f2-4102-b00e-2e7921638a7c@maowtm.org>
Date: Thu, 26 Jun 2025 11:05:23 +1000
Message-id: <175089992300.2280845.10831299451925894203@noble.neil.brown.name>

On Thu, 26 Jun 2025, Tingmao Wang wrote:
> On 6/26/25 00:04, NeilBrown wrote:
> > On Wed, 25 Jun 2025, Micka=C3=ABl Sala=C3=BCn wrote:
> >> On Wed, Jun 25, 2025 at 07:38:53AM +1000, NeilBrown wrote:
> >>>
> >>> Can you spell out the minimum that you need?
> >>
> >> Sure.  We'd like to call this new helper in a RCU
> >> read-side critical section and leverage this capability to speed up path
> >> walk when there is no concurrent hierarchy modification.  This use case
> >> is similar to handle_dots() with LOOKUP_RCU calling follow_dotdot_rcu().
> >>
> >> The main issue with this approach is to keep some state of the path walk
> >> to know if the next call to "path_walk_parent_rcu()" would be valid
> >> (i.e. something like a very light version of nameidata, mainly sequence
> >> integers), and to get back to the non-RCU version otherwise.
> >>
> >>>
> >>> My vague impression is that you want to search up from a given strut pa=
th,
> >>> no further then some other given path, looking for a dentry that matches
> >>> some rule.  Is that correct?
> >>
> >> Yes
> >>
> >>>
> >>> In general, the original dentry could be moved away from under the
> >>> dentry you find moments after the match is reported.  What mechanisms do
> >>> you have in place to ensure this doesn't happen, or that it doesn't
> >>> matter?
> >>
> >> In the case of Landlock, by default, a set of access rights are denied
> >> and can only be allowed by an element in the file hierarchy.  The goal
> >> is to only allow access to files under a specific directory (or directly
> >> a specific file).  That's why we only care of the file hierarchy at the
> >> time of access check.  It's not an issue if the file/directory was
> >> moved or is being moved as long as we can walk its "current" hierarchy.
> >> Furthermore, a sandboxed process is restricted from doing arbitrary
> >> mounts (and renames/links are controlled with the
> >> LANDLOCK_ACCESS_FS_REFER right).
> >>
> >> However, we need to get a valid "snapshot" of the set of dentries that
> >> (could) lead to the evaluated file/directory.
> >=20
> > A "snapshot" is an interesting idea - though looking at the landlock
> > code you one need inodes, not dentries.
> > I imagine an interface where you give it a starting path, a root, and
> > and array of inode pointers, and it fills in the pointers with the path
> > - all under rcu so no references are needed.
> > But you would need some fallback if the array isn't big enough, so maybe
> > that isn't a good idea.
> >=20
> > Based on the comments by Al and Christian, I think the only viable
> > approach is to pass a callback to some vfs function that does the
> > walking.
> >=20
> >    vfs_walk_ancestors(struct path *path, struct path *root,
> > 		      int (*walk_cb)(struct path *ancestor, void *data),
> > 		      void *data)
> >=20
> > where walk_cb() returns a negative number if it wants to abort, and is
> > given a NULL ancestor if vfs_walk_ancestors() needed to restart.
> >=20
> > vfs_walk_ancestors() would initialise a "struct nameidata" and
> > effectively call handle_dots(&nd, LAST_DOTDOT) repeatedly, calling
> >     walk_cb(&nd.path, data)
> > each time.
>=20
> handle_dots semantically does more than dget_parent + choose_mountpoint
> tho (which is what Landlock currently does, and is also what Song's
> iterator will do).  There is the step_into which will step into
> mountpoints (there is also code to handle symlinks, although I'm not sure
> if that's relevant for following ".."), and it will also return ENOENT if
> the path is disconnected.

Is any of this a problem for you?

>=20
> Also I guess we might not need to have an entire nameidata?  In theory it
> only needs to do what follow_dotdot_rcu does without the path_connected
> check.  So it seems like given we have path and root as function argument,
> it would only need nd->{seq,m_seq}.

Those are implementation details internal to namei.c.  Certainly this
function wouldn't use all of the fields in nameidata, but it doesn't
hurt to have a few fields in a struct on the stack which don't get used.
Keeping the code simple and uniform is much more important.  Using
nameidata would help achieve that.

>=20
> I might be wrong tho, but certainly the behaviour is different.

Here we get back to the question of "precisely what behaviour do you
need?".
"The same as what a previous patch did" is not a reasonable answer.

If, from userspace, you repeatedly did chdir("..") and then examined the
current directory you would get exactly the sequence of directories
provided by repeatedly calling handle_dots(..., LAST_DOTDOT).  If there
is some circumstance where that would be not acceptable for your use
case, you need to explain (and we need to document) what differences you
need and why use need it.

>=20
> >=20
> > How would you feel about that sort of interface?
>=20
> I can't speak for Micka=C3=ABl, but a callback-based interface is less flex=
ible
> (and _maybe_ less performant?).  Also, probably we will want to fallback
> to a reference-taking walk if the walk fails (rather than, say, retry
> infinitely), and this should probably use Song's proposed iterator.  I'm
> not sure if Song would be keen to rewrite this iterator patch series in
> callback style (to be clear, it doesn't necessarily seem like a good idea
> to me, and I'm not asking him to), which means that we will end up with
> the reference walk API being a "call this function repeatedly", and the
> rcu walk API taking a callback.  I think it is still workable (after all,
> if Landlock wants to reuse the code in the callback it can just call the
> callback function itself when doing the reference walk), but it seems a
> bit "ugly" to me.

call-back can have a performance impact (less opportunity for compiler
optimisation and CPU speculation), though less than taking spinlock and
references.  However Al and Christian have drawn a hard line against
making seq numbers visible outside VFS code so I think it is the
approach most likely to be accepted.

Certainly vfs_walk_ancestors() would fallback to ref-walk if rcu-walk
resulted in -ECHILD - just like all other path walking code in namei.c.
This would be largely transparent to the caller - the caller would only
see that the callback received a NULL path indicating a restart.  It
wouldn't need to know why.

NeilBrown

