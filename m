Return-Path: <linux-fsdevel+bounces-66535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94550C22B85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 00:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535F91A23976
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AB733E368;
	Thu, 30 Oct 2025 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ox4MPwGj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hEN6xMm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5F30F95A;
	Thu, 30 Oct 2025 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867483; cv=none; b=gGNdEzgZSaSKv4ZIHfAUDFhERv77A1lokAqTaJfHkX2yCQC//yl59ttEMAl+BSGbtC7km1+z3WymlNw4Aiaql7o62x99XJnRcohk1xtkzQrJ2FJDKqhoLz9vdvBMfByZ8fcSz221v9G2q8bdDEBI5LdQvgxaQJ0eh23hRH7OBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867483; c=relaxed/simple;
	bh=1JFznHwJ9SmoMKBcNVs4nFsIbrQIPYx/MgpAl4L7FeE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=liWDuDSzQAW2jyLizSbx2d98u7gpcw0hjF/DTDenn6F2u/GfUAH7+WfAEjWRFlWD96IuYkdl4oeCMlFzW21QSpCl4F2BKoGWJBs74/nMCd+/W5BtnECBaCw3zQPOQ1HjqQFeH/TFnQTYsRPaRqzff51FUdfTYhprDq9pTFe9fls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ox4MPwGj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hEN6xMm3; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 661A61300302;
	Thu, 30 Oct 2025 19:37:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 19:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761867479; x=1761874679; bh=ARXwRWPRXeSKN/a2GX42QMZWqyYh6A4I7nh
	hSoUQkaA=; b=Ox4MPwGjPlU7Jlj9LlcQHN5imiEuc2ynryxgmpyWdO9AP2GCH+R
	Ph1E/ZCQWxDX+zS3gkmj968ICezZUL5iUXVYOa92K5R8JK9SxFuJajrw9BEus8vu
	aYC320qfxLOrmDrt69pRh6it4iX/g0+3kPqCNTfNu7eH/OVortH3sHVcfTOtiM2p
	dIYJwgZyMhDpA4zqryLJshkZz3stXt/gFhsbYTXtPUhCD4/dJeZqOfZ38X60aStf
	RjSQAfCKs3YwhBx4JrBfRPuIIDBk7hqgQxSxcj9zSZ+6fSh+evUr6KKlst0VwHXU
	yWVypFKp6izNluJDDVz5+9JgWBB+DpKPZxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761867479; x=
	1761874679; bh=ARXwRWPRXeSKN/a2GX42QMZWqyYh6A4I7nhhSoUQkaA=; b=h
	EN6xMm3YCBXxlazAcYuvL9ksO67U4EaE05UPUSkIDkxcR103gn6B4NW6RIbdke7d
	KRmJv65M7ixo5BCvipseLsEQveJUlN/h2yS6BtBKniOya/PdkvMEwXLyLrlkP552
	+3Jg7g8K/FKHwG00gXwelqzzir6QF79i2nFmly56TRaMq/J32k64kG5+oeNxvsz9
	mK10xF1caEsIRvleuQpTSRyPJ5p/QEzGcl9I/sZII+doXn4a1H0djy3LWtuDmvAr
	TDmYW3tqaw1hGK7hkngNP+rNbdUvLusHQH7mxOsye/cAhLNGCqLhzuPNbVILbLVT
	6L30TBF6xwUv5c5Uy2OaQ==
X-ME-Sender: <xms:1PYDaUL3uN_ZYS5DyOozVcOf0w2OrQqbxc-4QWbx1bN9L-wzAX5fCQ>
    <xme:1PYDaXD1SYvuISc6YaixLM10IEYXN2KIrCSQs1A1ClNyiRazCd19f093favA5c40M
    7-GoGTkXglLhNP2wygqo_IMPU_LnRCTLyHeWXPNtpEDtSq92Ik>
X-ME-Received: <xmr:1PYDaVjAswXVecq4gQBB7tBXRAXS9uKaQM3AJIJWpLFVLitLTqK0YV4vkp04YsFF7HY-Tyt-_42MD1WfmnTd_UutGUpms5WF5ukAHv0sREF3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:1fYDaTPLNL_ZEx6UpYyzZGqNns6xiAnXEaWnIZ-9kiMvQ5TwdxKZYg>
    <xmx:1fYDaZWJ-wE55i1JUYw1GO0K8brT1sqaUxavUZGGa6qqQxvthHQaxA>
    <xmx:1fYDaQB1efCWq9QdJbyUhsAVgatruja8Z9S4VftpC7YwW4emP6XvQQ>
    <xmx:1fYDaeMHBC1QLhzVp0K3e_aClaQU--eFsbH2gQSnpE7T81tLe4kikw>
    <xmx:1_YDaVuNHJi2PkRkaZXi_thHraFG9qYrLgP6Q09afVQ-wZchIw1OZNeh>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 19:37:46 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chris Mason" <clm@fb.com>, "David Sterba" <dsterba@suse.com>,
 "David Howells" <dhowells@redhat.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Stefan Berger" <stefanb@linux.ibm.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Subject: Re: [PATCH v4 11/14] Add start_renaming_two_dentries()
In-reply-to: <20251030062214.GW2441659@ZenIV>
References: <20251029234353.1321957-1-neilb@ownmail.net>,
 <20251029234353.1321957-12-neilb@ownmail.net>,
 <20251030062214.GW2441659@ZenIV>
Date: Fri, 31 Oct 2025 10:37:44 +1100
Message-id: <176186746483.1793333.1130347070516464496@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 30 Oct 2025, Al Viro wrote:
> On Thu, Oct 30, 2025 at 10:31:11AM +1100, NeilBrown wrote:
>=20
> > +++ b/fs/debugfs/inode.c
>=20
> Why does debugfs_change_name() need any of that horror?  Seriously, WTF?
> This is strictly a name change on a filesystem that never, ever moves
> anything from one directory to another.

"horror" is clearly in the eye of the beholder, and not a helpful
description...

Is there anything in this use of start_renaming_two_dentries() which is
harmful?  I agree that not all of the functionality is needed in this
case, but some of it is.

Would you prefer we also add
   start_renaming_two_dentries_with_same_parent()
or similar?

>=20
> IMO struct renamedata is a fucking eyesore, but that aside, this:
>=20
> > @@ -539,22 +540,30 @@ static int sel_make_policy_nodes(struct selinux_fs_=
info *fsi,
> >  	if (ret)
> >  		goto out;
> > =20
> > -	lock_rename(tmp_parent, fsi->sb->s_root);
> > +	rd.old_parent =3D tmp_parent;
> > +	rd.new_parent =3D fsi->sb->s_root;
> > =20
> >  	/* booleans */
> > -	d_exchange(tmp_bool_dir, fsi->bool_dir);
> > +	ret =3D start_renaming_two_dentries(&rd, tmp_bool_dir, fsi->bool_dir);
> > +	if (!ret) {
> > +		d_exchange(tmp_bool_dir, fsi->bool_dir);
> > =20
> > -	swap(fsi->bool_num, bool_num);
> > -	swap(fsi->bool_pending_names, bool_names);
> > -	swap(fsi->bool_pending_values, bool_values);
> > +		swap(fsi->bool_num, bool_num);
> > +		swap(fsi->bool_pending_names, bool_names);
> > +		swap(fsi->bool_pending_values, bool_values);
> > =20
> > -	fsi->bool_dir =3D tmp_bool_dir;
> > +		fsi->bool_dir =3D tmp_bool_dir;
> > +		end_renaming(&rd);
> > +	}
> > =20
> >  	/* classes */
> > -	d_exchange(tmp_class_dir, fsi->class_dir);
> > -	fsi->class_dir =3D tmp_class_dir;
> > +	ret =3D start_renaming_two_dentries(&rd, tmp_class_dir, fsi->class_dir);
> > +	if (ret =3D=3D 0) {
> > +		d_exchange(tmp_class_dir, fsi->class_dir);
> > +		fsi->class_dir =3D tmp_class_dir;
> > =20
> > -	unlock_rename(tmp_parent, fsi->sb->s_root);
> > +		end_renaming(&rd);
> > +	}
> > =20
> >  out:
> >  	sel_remove_old_bool_data(bool_num, bool_names, bool_values);
>=20
> is very interesting - suddenly you get two non-overlapping scopes instead o=
f one.
> Why is that OK?
>=20

From the perspective of code performing lookup of these names, two
consecutive lookups would not be locked so they could see
inconsistencies anyway.
From the perspective of code changing these names, that is protected by
selinux_state.policy_mutex which is held across the combined operation.
A readdir could possibly see the old inum for one name and the new inum
for the other name.  I don't imagine this would be a problem.

I have added a comment to the commit message to highlight this.

Thanks,
NeilBrown


