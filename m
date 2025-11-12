Return-Path: <linux-fsdevel+bounces-68119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BA6C54D22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B4A54E0355
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 23:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF6F2F28F1;
	Wed, 12 Nov 2025 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Y2oNhTot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VIbWB84H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2B35CBC1;
	Wed, 12 Nov 2025 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762990670; cv=none; b=bHRW1+HKBDsbgBLHXflZYi/qfAQpnErh8H28c2q8B4l0TieCtiKZ4MaFxzVioiethKBL1mObQjVS9SBeU/fKa9zoHiWES99nJ2raG+ExuhzTXKzR9uwnf6brX7vVXaL5bHl326bIHX2WTIcpdluimbfNb02CYSYCve8boehLWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762990670; c=relaxed/simple;
	bh=JpEf+exjOBHgSs5IO/gAGxeVrStTfxrfOm/1McIoiLY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=sVc/9VBxincOPlNffh2Hythl/7q8dppyEmT+fOF0u8+rQJyMua+2aztMxz0nqwMPI/P8fxRsW/T3kytt+ojTov1+6YkKLliCFBf5vOYiU7CFsbhIQEBSBoVWxUomT7EijsxexoqXanO32i7NOl8bq4dRfMfWMU/hPJIF8sWVepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Y2oNhTot; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VIbWB84H; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 4EA21138069B;
	Wed, 12 Nov 2025 18:37:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 12 Nov 2025 18:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762990667; x=1762997867; bh=WK2Wj5Mp0wewghCJ5AnjHrm6rGTjnEVSJpb
	MoAThh5s=; b=Y2oNhTot0heRMsrBn/PBZVfhS4TkpJjv+vtzFjFVjb8NYiidpgG
	mq0lhUKteuFPaxDpQ+zPIKjlUf3G1OCJVHayfU+kMlUIpiAbFVT1T74cmT9RKHpz
	/QpxhVbtaOppciLX0P7KZZ919TmHC38hKkQWZFYBu8xf05o8vu/iDMWrbg0ETk52
	US+uJj5UkTpEUm7IZkcf7+Yqi9rTgku4jdivO/SixJJZqEyYwr8Ye7ALH0pQJF63
	F2Vjy7Kz2a+GQ9GUJ5IBcuV2IsOiOAPhMdTZzfJT2zOY4U+4LwdHZI2Lxn6Srvuq
	H5jFYN/AgDeayZ8UgAZWml08h3+CruF7IZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762990667; x=
	1762997867; bh=WK2Wj5Mp0wewghCJ5AnjHrm6rGTjnEVSJpbMoAThh5s=; b=V
	IbWB84HPHuTafAq0LvTXmjtthqiE+itamaoLGjS+vq2VLeYFjQGZw4G1wSUDM7F/
	QlavM+T1CeaBsPM6SBSP/gT9yKxAT3gZkyxCNiXAc8/mDZQ+ZwevSn/EhC9/cbqX
	h5LIGeY5PZ3xdKSZnaQVqCHbhojzQ7CcR69yWIm00TvPLpcFIzVxDpgLUaBs2oQJ
	Gt6mPHzAcpXQEq2PoUjTEZ5A+wTwP6S9mERCS7BovECpJa3nZ1K8fL/XrA9G1n/t
	hwPJ8y5Q3ZOD7qN0aA34oPAp52mcRDFyPTKtwL2GaiCVPSYWreTIDEU1VCFOtVCS
	pSj0Wcn8RMvBacPDWJv/g==
X-ME-Sender: <xms:SRoVab0kmDiHdxeTTqGp-6bYOWuNIeJph5Xwg3yf1Qj44aGhiqRtkg>
    <xme:SRoVafJAB3sGMYtQboHEFSJtS42M9_N6TlayXiN5uarV47NyLwEvIrdz6ObmyLOxW
    Q3JZP11xpbEXtfhBLnRpXBF4lhoLbpWjd_cw4c6yRnUeHtANQ>
X-ME-Received: <xmr:SRoVaY5Yroz-rbq6snb9qpgZNP4K1w1AyY98dk2Hw6Ba-2NlKHbdwqgWUUVl5NcvpiXvw7BYTWO0IhJnz8dCLuPk7chOjgmEqceKKIZQR7Yi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
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
X-ME-Proxy: <xmx:SRoVaejp4cU-nQ_UnAGLy1mkYjWsSd3wn2m_dGEFmzrBOgcT6hkc6w>
    <xmx:SRoVafmex8a1E73qT1F-vwQqWB-PAnvuL2Ooh8a9BJcVzwdIidUtDw>
    <xmx:SRoVaXR0O8tpBIvwTaYU_g7CKeWAmnqtfmQ5y4W0dnFF_rY5Ngci1A>
    <xmx:SRoVaQ_iGcLU2WfZuLz3HWJVcRFy9ZrYfyVdlh88kNOhdrpzClpqhg>
    <xmx:SxoVaaPFBJ41IuAjGY-rzqHTxQrOTVRzInvMfRj2BPnEmLbhVFJjzvti>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 18:37:35 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Stephen Smalley" <stephen.smalley.work@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
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
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Stefan Berger" <stefanb@linux.ibm.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v5 11/14] Add start_renaming_two_dentries()
In-reply-to:
 <CAEjxPJ528Ou4dvRwHo+kXjWreGicda8BOXkQRvq3vMED6JQKOQ@mail.gmail.com>
References: <20251106005333.956321-1-neilb@ownmail.net>,
 <20251106005333.956321-12-neilb@ownmail.net>,
 <CAEjxPJ528Ou4dvRwHo+kXjWreGicda8BOXkQRvq3vMED6JQKOQ@mail.gmail.com>
Date: Thu, 13 Nov 2025 10:37:28 +1100
Message-id: <176299064896.634289.12651549381030888718@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 11 Nov 2025, Stephen Smalley wrote:
> On Wed, Nov 5, 2025 at 7:56=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > A few callers want to lock for a rename and already have both dentries.
> > Also debugfs does want to perform a lookup but doesn't want permission
> > checking, so start_renaming_dentry() cannot be used.
> >
> > This patch introduces start_renaming_two_dentries() which is given both
> > dentries.  debugfs performs one lookup itself.  As it will only continue
> > with a negative dentry and as those cannot be renamed or unlinked, it is
> > safe to do the lookup before getting the rename locks.
> >
> > overlayfs uses start_renaming_two_dentries() in three places and  selinux
> > uses it twice in sel_make_policy_nodes().
> >
> > In sel_make_policy_nodes() we now lock for rename twice instead of just
> > once so the combined operation is no longer atomic w.r.t the parent
> > directory locks.  As selinux_state.policy_mutex is held across the whole
> > operation this does open up any interesting races.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: NeilBrown <neil@brown.name>
> >
> > ---
> > changes since v3:
> >  added missing assignment to rd.mnt_idmap in ovl_cleanup_and_whiteout
> > ---
>=20
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index 232e087bce3e..a224ef9bb831 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -539,22 +540,30 @@ static int sel_make_policy_nodes(struct selinux_fs_=
info *fsi,
> >         if (ret)
> >                 goto out;
> >
> > -       lock_rename(tmp_parent, fsi->sb->s_root);
> > +       rd.old_parent =3D tmp_parent;
> > +       rd.new_parent =3D fsi->sb->s_root;
> >
> >         /* booleans */
> > -       d_exchange(tmp_bool_dir, fsi->bool_dir);
> > +       ret =3D start_renaming_two_dentries(&rd, tmp_bool_dir, fsi->bool_=
dir);
> > +       if (!ret) {
> > +               d_exchange(tmp_bool_dir, fsi->bool_dir);
>=20
> I would recommend an immediate goto out if ret !=3D 0; we don't want to
> silently fall through and possibly reset ret on the next
> start_renaming_two_dentries() call, thereby ultimately returning 0 to
> the caller and acting as if nothing bad happened.

Yes, that is much cleaner - thanks!

and I've added the missing "NOT" in the commit message.

Thanks,
NeilBrown

