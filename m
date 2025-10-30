Return-Path: <linux-fsdevel+bounces-66537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9BAC22BBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 00:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9223C4E47FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 23:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E855340286;
	Thu, 30 Oct 2025 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Pc73YfLW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KWbkt+uk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F142C11CB;
	Thu, 30 Oct 2025 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867696; cv=none; b=VkriFrzvPO8LC3mJ3OQZWev3XTaK3dV8ifqaWrD3Zrn3s2GtGro79qBmw8lPMgI/mJ3BG/2eqmL4fxp2uAzx5DOb2bahuJz8J47t1lZ8TdMb8snbpHsVgoVhC75EkjP2KdfWc82DsrGAFzBPipqdEqZybtFVL/hobtQ52IDccos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867696; c=relaxed/simple;
	bh=s8qJUitOPA47j/+WNL0JxWMSGHgP2Ys3toCWUcFEg8w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jBGzbEnyx7JcwPkR/GnWVNVO/fFiDaiarDmS0GMkYa+nTLOjTRbG6+AmFwpUpthQnXw2pYTzFTJblHCpXcd6E1pdoYgLGigno57+kxXso8FhUX3MsGDp1NJZq534Djh01hDHKlR4Asdwq0R32cO7BDmO0cJmfhGdpKYiTt//YuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Pc73YfLW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KWbkt+uk; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 5577013000CC;
	Thu, 30 Oct 2025 19:41:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 19:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761867693; x=1761874893; bh=YJ19THsgVSpeJzD7ckpZErclcEybeF1XkFe
	eDx68jLs=; b=Pc73YfLWNJ3JZUpAFftBu85kxypozmP3ZD5/OjTIW4+78wVgHrd
	APjipNv1sLLaH83N9CHHyy0YUsn+ICUZ8366jLzMiaCndf/ZhTomsa5n1s9d6Sx2
	lYsvb7wfgqbkIVJuAe1dBNKfCb5GOJ67VWz2SLmSPeKDyfdXFu+FqA3YKI1/DesJ
	Z6JFLw0AL8cUm4vpkhv/9eKmgu5/NPfq1a1t/7uQOJ+9taGLDFExAZxNvYM0Pu/p
	nEM0vIT2wO5ddSYbSoswgRyAp9USqLc1l03EAeQ5kAo7VStg502Gz9bAKsLaWFEy
	XR9a+RjpomdVL30ntbZj9FLNztubWKwwDNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761867693; x=
	1761874893; bh=YJ19THsgVSpeJzD7ckpZErclcEybeF1XkFeeDx68jLs=; b=K
	Wbkt+ukMftFT8/uCW0USbi5pG4WHh6mJfTHeCqce3pv0oFhjHpCPue1rZ7m6jpGK
	kDIQc87wInw1uQS67C9fn6tSIfa9dvZS0lf1ZUuvTRQC3fMrWiUZTSTB/gaoiNYp
	eMXdNg/C3Gs1SGhHB91KSi53z6Bt9umyjijt0poClQlNoQFep71J8UB5U0pUPgZk
	l9/crQcz5MBp95fjC4FaOHBqvqxU2qe+uS5um8Wcbem+YxI5OKo3xoZMxKyD9tz3
	0ccbyuRHaKP9IPF4ReakWchgno7XrttHF2+6FA1RiM6e2LmHEnzzb7kWTkAe6DQ4
	exJ6EyGKjlKNkD4sY+H2Q==
X-ME-Sender: <xms:rPcDaZ8fz2PV7rMm0ZSYArsKSJ75ceExcgCJ6QGyjQRKO5KBTq8nPQ>
    <xme:rPcDaQmzuIyO28wxwNQwfudDj_CV47r-uovIjzlv4bUJkjMusrInjlEArZ7k-UwLI
    HAc48WwcRI1vfCPp3MElGN-CErojabz0OZDD46_wQzL8799Zw>
X-ME-Received: <xmr:rPcDaX3wPZf_7EgJjGns4r24abu2VRs0WJIogDD88n5dRmdBmesekvHkBU1FVszWCB6vmtuXogZ7a40oqlM_9oHkO0wg6GQDgpt5pOJAwPuz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejleeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:rPcDafSIaFYl-RgHoqcs0t7YrKDZ2gioLPgi-mlU48SQlKTTMBJOIA>
    <xmx:rPcDacK6aitOy-K4GZOFYzD9IizJlaKR_2q4A8eMNjCKjpMIUTwCHA>
    <xmx:rPcDaSnTe9Z_0l91HNTze7DZRYuxwKs7F3DOvRPNBgkt8xRriYRBIQ>
    <xmx:rPcDaVj1apibW2cs8riW6YdfSEBfeA_ytKnNM-17ym5kitOJlMeFcg>
    <xmx:rfcDaZmZWSefDAP2LqnLmEPokPLWMSLY_fExqU3FZVX4WsNL0DMUw6Zo>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 19:41:22 -0400 (EDT)
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
Subject:
 Re: [PATCH v4 12/14] ecryptfs: use new start_creating/start_removing APIs
In-reply-to: <20251030062420.GX2441659@ZenIV>
References: <20251029234353.1321957-1-neilb@ownmail.net>,
 <20251029234353.1321957-13-neilb@ownmail.net>,
 <20251030062420.GX2441659@ZenIV>
Date: Fri, 31 Oct 2025 10:41:20 +1100
Message-id: <176186768028.1793333.3200874180667501034@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 30 Oct 2025, Al Viro wrote:
> On Thu, Oct 30, 2025 at 10:31:12AM +1100, NeilBrown wrote:
>=20
> > +static struct dentry *ecryptfs_start_creating_dentry(struct dentry *dent=
ry)
> >  {
> > -	struct dentry *lower_dir_dentry;
> > +	struct dentry *parent =3D dget_parent(dentry->d_parent);
>=20
> "Grab the reference to grandparent"?
>=20

That's somewhat embarrassing :-(

Fixed as below.
Thanks a lot!

NeilBrown

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index b3702105d236..6a5bca89e752 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -26,7 +26,7 @@
=20
 static struct dentry *ecryptfs_start_creating_dentry(struct dentry *dentry)
 {
-	struct dentry *parent =3D dget_parent(dentry->d_parent);
+	struct dentry *parent =3D dget_parent(dentry);
 	struct dentry *ret;
=20
 	ret =3D start_creating_dentry(ecryptfs_dentry_to_lower(parent),
@@ -37,7 +37,7 @@ static struct dentry *ecryptfs_start_creating_dentry(struct=
 dentry *dentry)
=20
 static struct dentry *ecryptfs_start_removing_dentry(struct dentry *dentry)
 {
-	struct dentry *parent =3D dget_parent(dentry->d_parent);
+	struct dentry *parent =3D dget_parent(dentry);
 	struct dentry *ret;
=20
 	ret =3D start_removing_dentry(ecryptfs_dentry_to_lower(parent),



