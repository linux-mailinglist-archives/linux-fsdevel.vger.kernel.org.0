Return-Path: <linux-fsdevel+bounces-53313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960C5AED7BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 10:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545C13A58B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6801CDFCE;
	Mon, 30 Jun 2025 08:48:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32B21CA14
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273333; cv=none; b=rMzcopmHyzK46bgu3VCCr0w5J8OcPzbpHA/yWj5bGtalB3i+z9EmivRc92N1J0v4nqSIdKC1aBXbVFEOgN91xMK5pSGZv8GGinwDrcWffQ2iw65rVOSlfMIukgUHvCfxbMmT0a6kfAwHQG953ZaVofwSRYeSC4EzThxpqXpRuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273333; c=relaxed/simple;
	bh=ZwpUkM8jtOdi7mmCwNwu9KFrhYE6jWG78u4/xYjnzRk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SGFmzqMxU6yjEFCh7z5qk/l/cSnzP8V36UMK3IrVOY2TPymd3QfVQICeLd08S99vAyNUraBZ0ur+MEcK11zPD5DhKgsm4L4U2oC3simVav30ySNTCzEB2bXqlSbCBvwGqU+ZsOS0DZDPik84U8BS7C9cmbrbM85+4l+buOYYEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uWABt-00EF0u-4q;
	Mon, 30 Jun 2025 08:48:41 +0000
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
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject:
 Re: [RFC][PATCH] fix proc_sys_compare() handling of in-lookup dentries
In-reply-to: <20250630072059.GY1880847@ZenIV>
References: <20250630072059.GY1880847@ZenIV>
Date: Mon, 30 Jun 2025 18:48:40 +1000
Message-id: <175127332010.565058.1144617640469023041@noble.neil.brown.name>

On Mon, 30 Jun 2025, Al Viro wrote:
> [In #fixes, I'll send a pull request in a few days unless anybody objects]
>=20
> There's one case where ->d_compare() can be called for an in-lookup
> dentry; usually that's nothing special from ->d_compare() point of
> view, but proc_sys_compare() is... unique.
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
>=20
> Fixes: d9171b934526 ("parallel lookups machinery, part 4 (and last)")
> Reported-by: NeilBrown <neilb@brown.name>
                           ^should be "neil" :-(
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: NeilBrown <neil@brown.name>

Checking the name first is definitely cleaner.  The fact that
d_in_lookup() allows the rest to be short-circuited is neat but
certainly deserves the comment.

NeilBrown


> ---
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index cc9d74a06ff0..b0ff2d21a3d9 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -918,16 +918,20 @@ static int proc_sys_compare(const struct dentry *dent=
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
>  	head =3D rcu_dereference(PROC_I(inode)->sysctl);
>  	return !head || !sysctl_is_seen(head);
>  }
>=20


