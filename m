Return-Path: <linux-fsdevel+bounces-51214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC66BAD477E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 02:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106057A8C79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 00:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D871EA6F;
	Wed, 11 Jun 2025 00:34:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0518E20
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749602061; cv=none; b=LVYJidsi318XwlTq8IAFJ9L9QEwpoO74UNMbor94GN3e+PXEVyona8pjW3YKGo3CZIoP/x9XrCzzvqCUerGgSOKDM3pioBCqPWUby8UAyNERlNpSEmSl4EVtmqFt9QTojVihgTDSC9P8KA6dJFg53YcJliXKwhQEd+IS4rzthSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749602061; c=relaxed/simple;
	bh=2bn897icXRKyRR1OgVfwQ3AkvodErX46h8OGVXgxHe8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=K2vndhs4QzO7B0spYAfK7dwHIYsj9HHu/Bxohqd4zX99MJO1zekY0MrBegJQHxFBvq201zGqEgtddkgQCIAX5tdvGcvop3QEKx3y2J0pTDuEhzVMZfaN0E+iFgpJ3Jr9fFHZYF+rdM741PWSeK13rtCDq7OSJN1kAD9iEv1wtfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uP9Pz-007uRl-70;
	Wed, 11 Jun 2025 00:34:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/8] VFS: use new dentry locking for create/remove/rename
In-reply-to: <20250610203631.GF299672@ZenIV>
References: <>, <20250610203631.GF299672@ZenIV>
Date: Wed, 11 Jun 2025 10:34:14 +1000
Message-id: <174960205445.608730.15769320969247147200@noble.neil.brown.name>

On Wed, 11 Jun 2025, Al Viro wrote:
> On Mon, Jun 09, 2025 at 05:34:12PM +1000, NeilBrown wrote:
> > After taking the directory lock (or locks) we now lock the target
> > dentries.  This is pointless at present but will allow us to remove the
> > taking of the directory lock in a future patch.
> >=20
> > MORE WORDS
>=20
> Such as "why doesn't it deadlock?", presumably, seeing that you have
>=20
> > @@ -2003,7 +2003,14 @@ struct dentry *lookup_and_lock_hashed(struct qstr =
*last,
> > =20
> >  	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
> > =20
> > +retry:
> >  	dentry =3D lookup_one_qstr(last, base, lookup_flags);
> > +	if (!IS_ERR(dentry) &&
> > +	    !dentry_lock(dentry, base, last, TASK_UNINTERRUPTIBLE)) {
>=20
> ... take dentry lock inside ->i_rwsem on parent and
>=20
> >  bool lock_and_check_dentry(struct dentry *child, struct dentry *parent)
> >  {
> > -	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> > -	if (child->d_parent =3D=3D parent) {
> > -		/* get the child to balance with dentry_unlock which puts it. */
> > -		dget(child);
> > -		return true;
> > +	if (!dentry_lock(child, NULL, NULL, TASK_UNINTERRUPTIBLE))
> > +		return false;
> > +	if (child->d_parent !=3D parent) {
> > +		__dentry_unlock(child);
> > +		return false;
> >  	}
> > -	inode_unlock(d_inode(parent));
> > -	return false;
> > +	/* get the child to balance with dentry_unlock() which puts it. */
> > +	dget(child);
> > +	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
>=20
> ... do the same in opposite order?
>=20
> How could that possibly work?
>=20

Clearly it can't - thanks for finding that.
A previous iteration has the parent locking after the dentry locking,
but I found that couldn't work.  So I move the parent locking back to
the start, but must have missed this function.

That part of the patch now reads:

@@ -2143,8 +2198,8 @@ EXPORT_SYMBOL(lookup_and_lock_killable);
 bool lock_and_check_dentry(struct dentry *child, struct dentry *parent)
 {
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	if (child->d_parent =3D=3D parent) {
-		/* get the child to balance with dentry_unlock which puts it. */
+	if (!dentry_lock(child, parent, NULL, TASK_UNINTERRUPTIBLE)) {
+		/* get the child to balance with dentry_unlock() which puts it. */
 		dget(child);
 		return true;
 	}

Thanks,
NeilBrown


