Return-Path: <linux-fsdevel+bounces-50859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030DBAD07AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 19:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8983AB5B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB31B28C02C;
	Fri,  6 Jun 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MO7HLgM9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDD28C2A8
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231907; cv=none; b=G85rgPX20NkJh37PyXNDTYpt3HEa+Lju7qGktmdxCREEIRTk1Zq2FgRq3lcM7/sEb4gb0B6Seww6BUdLpHqxIvTF3CCaVnCL+CH42kzbwUNPiirG/Y6ZaZuOD7j0ZflPRefErOSFyDUKvUt7zAYhFUzmTYZjRIOSwN7D2eisbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231907; c=relaxed/simple;
	bh=fapKq/5bPK8UUlfdfHIXFQKdbpo3Lal9djetGJwwKdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGba0lVzfvEoY7n63aX1jW8jfxbc0mjR/edaFGYppWhnzMI79ccMm7lP9THToUu76RJrB44Fz497YcLKC0fZpNWGqN9+h/06iE7uW9E2H5DTg5KTbyHV6gpoYxBi+ftbzlOjHzgOjrtBneBCTYiCf0GjdKpBBB0rezaNpAd8mrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MO7HLgM9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ozJPpRviabHgozIIafPKgdvWtirSV/J477/3LBP3Jkk=; b=MO7HLgM9BQKKY9LKtGxXHTejLq
	Hc776iVt+IYd/C3cyRawA78apgZDI+G0dgs7g0zyGqxioYWhBXKEb+OrFY2jMkoM845kuxPixPFFv
	fUtpHMlZPCgi6dm/m+xTwhL8A68X06f7sRiYG4h6pRvT8wq7FbWlrseEPbwBFa7IWisZa7ByLWeyo
	pkikP9ENLrp9jJts2PeBkp0ByrMMeqaIHT3dNqD89OtREfIvPVeP1uG2B0TAJ0yRhr9M6cihxVk2s
	wCyMIdLpilekyk57ikBjhLE/UOTSo17IFL+pz9QFhDL0MMrdvrjI09oRGbqAsgfIEGfciybxwWSIQ
	VaKp+Pyw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNb7m-00000000ofd-0KdL;
	Fri, 06 Jun 2025 17:45:02 +0000
Date: Fri, 6 Jun 2025 18:45:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>, Allison Karlitskaya <lis@redhat.com>
Subject: Re: [PATCH 1/2] mount: fix detached mount regression
Message-ID: <20250606174502.GY299672@ZenIV>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
 <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
 <20250606045441.GS299672@ZenIV>
 <20250606051428.GT299672@ZenIV>
 <20250606070127.GU299672@ZenIV>
 <20250606-neuformulierung-flohmarkt-42efdaa4bac5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-neuformulierung-flohmarkt-42efdaa4bac5@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 06, 2025 at 09:58:26AM +0200, Christian Brauner wrote:

> Fwiw, check_mnt() is a useless name for this function that's been
> bothering me forever.

Point, but let's keep the renaming (s/check_mnt/our_mount/, for
example) separate.

> > +	if (check_mnt(old)) {
> > +		/* should be detachable from parent */
> > +		if (!mnt_has_parent(old) || IS_MNT_LOCKED(old))
> > +			goto out;
> > +		/* target should be ours */
> > +		if (!check_mnt(p))
> > +			goto out;
> > +	} else {
> 
> This code has gotten more powerful with my recent changes to allow
> assembling private mount trees so I think we should be more liberal with
> comments to be kind to our future selves. Also I would really prefer if
> we could move the checks to separate lines:
> 
> /* Only allow moving anonymous mounts... */
> if (!is_anon_ns(ns))
> 	goto out;
> 
> /* ... that are the root of their anonymous mount namespace. */
> if (mnt_has_parent(old))
> 	goto out;

Maybe, but I wonder if we should add
static inline bool anon_ns_root(struct mount *m)
{
	struct namespace *ns = m->mnt_ns;

	return !IS_ERR_OR_NULL(ns) && is_anon_ns(ns) && m == ns->root;
}
for that kind of stuff...  And I'd prefer direct comparison with root
instead of going for "well, if it's mounted in a namespace, it either
is its root or mnt_has_parent() will return true" kind of logics.

We have checks for that predicate open-coded elsewhere...

<looks>

in addition to do_move_mount() we have clone_private_mount() where
                if (!is_mounted(&old_mnt->mnt) ||
                        !is_anon_ns(old_mnt->mnt_ns) ||
                        mnt_has_parent(old_mnt))
would be replacable with
		if (!anon_ns_root(old_mnt))
and in do_mount_setattr()
        if (!is_mounted(&mnt->mnt))
                goto out;
        if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
                goto out;
with
	if (!check_mnt(mnt) && !anon_ns_root(mnt))
		goto out;

and while we are at it, dissolve_on_fput() becomes
        scoped_guard(rcu) {
                if (!anon_ns_root(m))
                        return;
        }
        scoped_guard(namespace_lock, &namespace_sem) {
                ns = m->mnt_ns;
                if (!anon_ns_root(m))
                        return;
                lock_mount_hash();
                umount_tree(m, UMOUNT_CONNECTED);
                unlock_mount_hash();
	}
        free_mnt_ns(ns);
Incidentally, location of free_mnt_ns() is one aspect of that thing
that *does* need a comment - at the first glance it looks like it
would be better off under namespace_sem.  The reason why that must
not be moved there is well-buried - it's the call of notify_mnt_list()
in namespace_unlock(), where we have calls of mnt_notify(), which
looks at m->prev_ns->n_fsnotify_marks.  IMO that's way too subtle
to be left without an explanation - that, or having something like
bury_anon_ns(ns) called under namespace_sem and triggering
free_mnt_ns() from namespace_unlock(), after the notify_mnt_list()
call there.  do_move_mount() might also benefit from the same...
Anyway, that's a separate story.

