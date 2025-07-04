Return-Path: <linux-fsdevel+bounces-53874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 720BAAF8544
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 03:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F9F1C47314
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 01:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C72D1A08BC;
	Fri,  4 Jul 2025 01:40:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEEA19E96A;
	Fri,  4 Jul 2025 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751593250; cv=none; b=c5reS+KovWI07nYOVmhLc35gYpMNdpe/N3cRsIhl8DT9TW0ZWGjzc2eu1G4Wb8lCCbuwaX7bnwNJzHEYvyWoBcgjjo4+E5xM3uawjhEjVG5VdhGtUQXV6FTXcsZeHZLe+Rq0K7kFlmQZpGO2Cl4y8nox64BzmYXu0ToIkqjJ9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751593250; c=relaxed/simple;
	bh=JWz/mBX63xnQsYfZ1Iwg9ZhN8hSHnPRNG2/p5+A6jps=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Q0IheWonyThSxO36mz6N6ZEYFwkoiAu+vSh5VVBWbcVSICd0gFUPN1hP1VgE1jLOM0yLrZgJZAEBDxH0P35GPbCjJaalh4idXlqCyl7HPicJ5cdy5R8NhA+wnao1FbIlMLvY73sGt5StwWyjt94R9H00r4fwWsh0vgOYylNIxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uXVPA-001Ker-Ov;
	Fri, 04 Jul 2025 01:39:56 +0000
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
Cc: "Kees Cook" <kees@kernel.org>, "Joel Granados" <joel.granados@kernel.org>,
 linux-fsdevel@vger.kernel.org, "LKML" <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v3?] proc_sysctl: remove rcu_dereference() for accessing ->sysctl
In-reply-to: <20250704010230.GA1868876@ZenIV>
References: <>, <20250704010230.GA1868876@ZenIV>
Date: Fri, 04 Jul 2025 11:39:52 +1000
Message-id: <175159319224.565058.14007562517229235836@noble.neil.brown.name>

On Fri, 04 Jul 2025, Al Viro wrote:
> On Fri, Jul 04, 2025 at 12:43:13AM +0100, Al Viro wrote:
>=20
> > I would rather *not* leave a dangling pointer there, and yes, it can
> > end up being dangling.  kfree_rcu() from inside the ->evict_inode()
> > may very well happen earlier than (also RCU-delayed) freeing of struct
> > inode itself.
> >=20
> > What we can do is WRITE_ONCE() to set it to NULL on the evict_inode
> > side and READ_ONCE() in the proc_sys_compare().
> >=20
> > The reason why the latter is memory-safe is that ->d_compare() for
> > non-in-lookup dentries is called either under rcu_read_lock() (in which
> > case observing non-NULL means that kfree_rcu() couldn't have gotten to
> > freeing the sucker) *or* under ->d_lock, in which case the inode can't
> > reach ->evict_inode() until we are done.
> >=20
> > So this predicate is very much relevant.  Have that fucker called with
> > neither rcu_read_lock() nor ->d_lock, and you might very well end up
> > with dereferencing an already freed ctl_table_header.
>=20
> IOW, I would prefer to do this:

Looks good - thanks,
NeilBrown

>=20
> [PATCH] fix proc_sys_compare() handling of in-lookup dentries
>=20
> There's one case where ->d_compare() can be called for an in-lookup
> dentry; usually that's nothing special from ->d_compare() point of
> view, but... proc_sys_compare() is weird.
>=20
> The thing is, /proc/sys subdirectories can look differently for
> different processes.  Up to and including having the same name
> resolve to different dentries - all of them hashed.
>=20
> The way it's done is ->d_compare() refusing to admit a match unless
> this dentry is supposed to be visible to this caller.  The information
> needed to discriminate between them is stored in inode; it is set
> during proc_sys_lookup() and until it's done d_splice_alias() we really
> can't tell who should that dentry be visible for.
>=20
> Normally there's no negative dentries in /proc/sys; we can run into
> a dying dentry in RCU dcache lookup, but those can be safely rejected.
>=20
> However, ->d_compare() is also called for in-lookup dentries, before
> they get positive - or hashed, for that matter.  In case of match
> we will wait until dentry leaves in-lookup state and repeat ->d_compare()
> afterwards.  In other words, the right behaviour is to treat the
> name match as sufficient for in-lookup dentries; if dentry is not
> for us, we'll see that when we recheck once proc_sys_lookup() is
> done with it.
>    =20
> While we are at it, fix the misspelled READ_ONCE and WRITE_ONCE there.
>=20
> Fixes: d9171b934526 ("parallel lookups machinery, part 4 (and last)")
> Reported-by: NeilBrown <neilb@brown.name>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index a3eb3b740f76..3604b616311c 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -42,7 +42,7 @@ static void proc_evict_inode(struct inode *inode)
> =20
>  	head =3D ei->sysctl;
>  	if (head) {
> -		RCU_INIT_POINTER(ei->sysctl, NULL);
> +		WRITE_ONCE(ei->sysctl, NULL);
>  		proc_sys_evict_inode(inode, head);
>  	}
>  }
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index cc9d74a06ff0..08b78150cdde 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -918,17 +918,21 @@ static int proc_sys_compare(const struct dentry *dent=
ry,
>  	struct ctl_table_header *head;
>  	struct inode *inode;
> =20
> -	/* Although proc doesn't have negative dentries, rcu-walk means
> -	 * that inode here can be NULL */
> -	/* AV: can it, indeed? */
> -	inode =3D d_inode_rcu(dentry);
> -	if (!inode)
> -		return 1;
>  	if (name->len !=3D len)
>  		return 1;
>  	if (memcmp(name->name, str, len))
>  		return 1;
> -	head =3D rcu_dereference(PROC_I(inode)->sysctl);
> +
> +	// false positive is fine here - we'll recheck anyway
> +	if (d_in_lookup(dentry))
> +		return 0;
> +
> +	inode =3D d_inode_rcu(dentry);
> +	// we just might have run into dentry in the middle of __dentry_kill()
> +	if (!inode)
> +		return 1;
> +
> +	head =3D READ_ONCE(PROC_I(inode)->sysctl);
>  	return !head || !sysctl_is_seen(head);
>  }
> =20
>=20


