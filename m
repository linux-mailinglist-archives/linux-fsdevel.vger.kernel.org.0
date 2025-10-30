Return-Path: <linux-fsdevel+bounces-66533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87342C22B3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 00:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 319DF4EDB6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A6A33C50A;
	Thu, 30 Oct 2025 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TCq7ftdg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lByC82tf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF32F6577;
	Thu, 30 Oct 2025 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761866583; cv=none; b=BcIzOL+JJo+h9SJO8dPwLfG2M6RMG3PQtth7fzXsHEFwpHtjB6rSsHVgcNxhUUHJGK6T2+msGqG6SLcQsB/SxHc9bzgMHovSJyG8/jdsLFdhCAmwhO43mcG570xNCmHZZ9Tew/9vPUhDKjGERQTXHygCDplET+QGNul0i9fyoSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761866583; c=relaxed/simple;
	bh=S7s7dokVdFKGKrrKiqnoayVZMt1AiI9aemANRN265QY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CiT1y33w5LvKNHMqk9WpxbHm+JeUgRZm9Iv6wVVaoQUc0uySQ6ZDd3FMwxwND+KvBomoKLM3FSj8O40j5HI9GMD5kzkNin4CUQRzuN+NXiHIC20XzegAQjIGi7gTxIJ2yhTbUYQZH0NJcXl3iu76RHpFdz0yLYOg+Ce6SNKYY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TCq7ftdg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lByC82tf; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id BC65313000CB;
	Thu, 30 Oct 2025 19:22:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 30 Oct 2025 19:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761866579; x=1761873779; bh=hvbbxiEqeKOPLV15+amtC5BVkJM9zfXU4+P
	k3GSk48w=; b=TCq7ftdgwGivoKj2hAIF9AvUFPJGc0vADUYKumDOEz/qIezJWGl
	gnzbZnPiifNw3COiR8GxTl91Gf8Rbq+FrAGOQufTMrm8C8m+9hlYqRrZrTwJ+g8K
	20VD6M+2yrAl7K6LoIIQDoqcD1sGEeCXEsAtpDM1j3tE0Yd0AZtC92b4/hyJ6qTq
	C/EQdlj8PQQur6U25As8epdpAKaeil7QOz00GappXprYPbYnL96Zhe5btlbRiSTY
	zsb5M5miarjxUMxhQy2PY/oLyPXGdkEzci8MfaAjKN8WnMtOZwZb12JU7GAECu8c
	hOmldHjWyNT/WtipJr4NtA3//jnMWP2XeNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761866579; x=
	1761873779; bh=hvbbxiEqeKOPLV15+amtC5BVkJM9zfXU4+Pk3GSk48w=; b=l
	ByC82tfl/EMQQRfkYqkDz3IJ7sRI/WQXG2mcBDyJW2v2hXqVKSNQlqoQzEem5Eym
	dR9MImcEWJmOIF1xR5FKhIPik83yNa6QT/fk9TqIqdIVAFoSoeHLMcBvDrzEDD8D
	XjdMAiA35425YFXSxF5x+0qNcY2W/MVxg/TcY0YIKXL3xKuTvuoDJIasxC0Qxxmi
	iTm5aTaKG9pIhv6A+jNXcFgENGr5j/ldMZv5wV8XUdvkg+7O5aFtxXorlGOjXT5b
	tLjd+kxVdbT3deiBaC6grJvvbfJjS+2jpuAjxSkr5PY4R0j1Nku+VxyFrvYfpEWe
	/cWGsReam2wLzO1MMOROw==
X-ME-Sender: <xms:UPMDaRhUVZd0x7_m2K17HihcRjCDpVNYHFuEuX0MMgm20e897e5KkA>
    <xme:UPMDaY7AjV2fQCLr_snCqH1fQeOzq1khXo6h6YlzncD-hrTaP3jvkupkkSppCGbEK
    3_FJ-R2P97AhdeuJVUfknkc1NHRstlmMB11PTJieu4Jgrp6>
X-ME-Received: <xmr:UPMDaR4wtri-pKxjBpYPkO67BfCd6oydbgfEbdFMML-UxKIpAqf7uEQcrmb8ircyBRb3gkh38Y-CFv6PS5eeA8faA1-9rnol0Gt6iFnCvxLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:UPMDaYFGMua7g80kGbfcUaz9Di8tafwlq4iKeb9hO4aVvX2qo_uERw>
    <xmx:UPMDacsdmaie4UXKmXFZ3mEfrheGemagwqaZFEvxWGs9YShlaMG9lQ>
    <xmx:UPMDaf4TguqIroQ6tzSgxweML37Y98bapEIbob097jWZZJuu0xphMA>
    <xmx:UPMDaQnurzcpOOav6s9l9JXVYIdItJKKsSEy0NTn122915Snsl7u-w>
    <xmx:U_MDaaJxwd0jRvItfq6nxG-85nWt4d2jCvckXynlPHJGLvIfrzldVxtX>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 19:22:46 -0400 (EDT)
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
Subject: Re: [PATCH v4 07/14] VFS: introduce start_removing_dentry()
In-reply-to: <20251030061159.GV2441659@ZenIV>
References: <20251029234353.1321957-1-neilb@ownmail.net>,
 <20251029234353.1321957-8-neilb@ownmail.net>,
 <20251030061159.GV2441659@ZenIV>
Date: Fri, 31 Oct 2025 10:22:43 +1100
Message-id: <176186656376.1793333.1075264554692169239@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 30 Oct 2025, Al Viro wrote:
> On Thu, Oct 30, 2025 at 10:31:07AM +1100, NeilBrown wrote:
>=20
> > @@ -428,11 +429,14 @@ static bool cachefiles_invalidate_cookie(struct fsc=
ache_cookie *cookie)
> >  		if (!old_tmpfile) {
> >  			struct cachefiles_volume *volume =3D object->volume;
> >  			struct dentry *fan =3D volume->fanout[(u8)cookie->key_hash];
> > -
> > -			inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
> > -			cachefiles_bury_object(volume->cache, object, fan,
> > -					       old_file->f_path.dentry,
> > -					       FSCACHE_OBJECT_INVALIDATED);
> > +			struct dentry *obj;
> > +
> > +			obj =3D start_removing_dentry(fan, old_file->f_path.dentry);
> > +			if (!IS_ERR(obj))
> > +				cachefiles_bury_object(volume->cache, object,
> > +						       fan, obj,
> > +						       FSCACHE_OBJECT_INVALIDATED);
> > +			end_removing(obj);
>=20
> Huh?  Where did you change cachefiles_bury_object to *not* unlock the paren=
t?
> Not in this commit, AFAICS, and that means at least a bisection hazard arou=
nd
> here...
>=20
> Confused...
>=20

Thanks for the review and for catching that error.
This incremental patch should fix it.

Thanks,
NeilBrown

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 3f8a6f1a8fc3..a08250d244ea 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -436,7 +436,6 @@ static bool cachefiles_invalidate_cookie(struct fscache_c=
ookie *cookie)
 				cachefiles_bury_object(volume->cache, object,
 						       fan, obj,
 						       FSCACHE_OBJECT_INVALIDATED);
-			end_removing(obj);
 		}
 		fput(old_file);
 	}
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index b97a40917a32..0104ac00485d 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -261,6 +261,7 @@ static int cachefiles_unlink(struct cachefiles_cache *cac=
he,
  * - Directory backed objects are stuffed into the graveyard for userspace to
  *   delete
  * On entry dir must be locked.  It will be unlocked on exit.
+ * On entry there must be at least 2 refs on rep, one will be dropped on exi=
t.
  */
 int cachefiles_bury_object(struct cachefiles_cache *cache,
 			   struct cachefiles_object *object,
@@ -275,12 +276,6 @@ int cachefiles_bury_object(struct cachefiles_cache *cach=
e,
=20
 	_enter(",'%pd','%pd'", dir, rep);
=20
-	/* end_removing() will dput() @rep but we need to keep
-	 * a ref, so take one now.  This also stops the dentry
-	 * being negated when unlinked which we need.
-	 */
-	dget(rep);
-
 	if (rep->d_parent !=3D dir) {
 		end_removing(rep);
 		_leave(" =3D -ESTALE");
@@ -650,7 +645,6 @@ bool cachefiles_look_up_object(struct cachefiles_object *=
object)
 			ret =3D cachefiles_bury_object(volume->cache, object,
 						     fan, de,
 						     FSCACHE_OBJECT_IS_WEIRD);
-		end_removing(de);
 		dput(dentry);
 		if (ret < 0)
 			return false;
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
index ddf95ff5daf0..90ba926f488e 100644
--- a/fs/cachefiles/volume.c
+++ b/fs/cachefiles/volume.c
@@ -64,7 +64,6 @@ void cachefiles_acquire_volume(struct fscache_volume *vcook=
ie)
 				cachefiles_bury_object(cache, NULL, cache->store,
 						       vdentry,
 						       FSCACHE_VOLUME_IS_WEIRD);
-			end_removing(vdentry);
 			cachefiles_put_directory(volume->dentry);
 			cond_resched();
 			goto retry;


