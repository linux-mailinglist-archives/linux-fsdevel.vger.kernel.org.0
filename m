Return-Path: <linux-fsdevel+bounces-67236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F238C3885C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 01:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E412D1A21F68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38911D9663;
	Thu,  6 Nov 2025 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NAr8JS/3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LSaRr0kq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B633E7
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 00:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390421; cv=none; b=nqtQ1K1zf+AR2/6vCX1+8NYSMJzjr74lSZVISaebd8G4XfgJhVEMK5ikHF9vApEO/2BN732Q31zkiFIQqVX6i3AdSYZrr6AKfCSx/eATlHfK70PSJFfXsyxil/7uZy75knNCH4L+aDrzoEadGrWtfOmpbniMxBCHy63RA3XrkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390421; c=relaxed/simple;
	bh=TzrOJWRTbh7msYotwzy/SyrEreFMAa3VOyZxfcnWujU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=s9XeMa/CdM3ppHQ9ZzGLFZvbEdpBvQH8j3f4D6ElgbzJ++7GIsJ6YYevb18c+TPrOdWSOzab0JDXyB4f8OR8IxA2K+X5LE6+9w/rxtlxHpa0ZRLEB0474TCOFsQ+gfpNeMEruJWSpxoo9/Irt89sFe/n4d6Ly89moIb6gP+76RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NAr8JS/3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LSaRr0kq; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 9D30013005BF;
	Wed,  5 Nov 2025 19:53:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 19:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762390416; x=1762397616; bh=KaR5D0R2IqTiUpqIio9Ha+v4jRl+XG/S1Kt
	/8EZGKTY=; b=NAr8JS/3M+2IUJ3D+p7usRL4At+2mUcGbp8GRf7LO0VCv1h7vbx
	wStmrsUlM4Lql5V3ApSpllB6JzKByOEe0opp3oedLRIY0UmwNZwJCqTKUf+RsO/J
	AHWdkTXHQZzx2AsexBmTRPLLKHb5SQ8U3EZ2ng7Lr5NkJ5UqJCgtD2FCp8BMlmJN
	xXE9E74VKK8ZOyq5h/o5LAWwQxmwn/6/iEYETgXC+6okz/kJvy9YXhB7KVUVe28V
	WGpwlVBU+g0hYnUH/o8Ov/sknMWtud1cpKRWaEf25TGVPOYkxHoPOAP+cxJRW4ph
	B8AC/oX4F8Pb8niP3FF4ZXL+dgbcgm9+7Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762390416; x=
	1762397616; bh=KaR5D0R2IqTiUpqIio9Ha+v4jRl+XG/S1Kt/8EZGKTY=; b=L
	SaRr0kqpJF2YPTK/LzJGUT2N52Bkjt4Gcq2NKN+l+uyPbuSwlSJ3VbwJRzr52/hv
	WSYnFef3jPogb2K8CiM8sfdqVE26U3y0mER6E5HiyKRveI3LA68FSVqzg6IgiR/s
	7cm4furRaj1J4fmn/IX0AXNAyfnd99HUuaH1AYQaVPblrsLpe3DYA2oJ6jJouhA6
	FJVTmQ2+a5FP8KUIpnhO0NFq7NNxTjWc2zB3ICYTJIlp3/GuO5qSu/mOzN4o9NV3
	odU2VSlRA0AJNlkabcX5MAAHk3UXwZ6d2Pi4Nd6Iuz7/8KTD8viLBbR6a3jwtfDy
	enm3pTOrCBL4mfF/MRIdA==
X-ME-Sender: <xms:jfELadkNHXTjssrASPiJD75WnXJCpgF2V6_hoEN2kIlds9qZGIAqtw>
    <xme:jfELaU8muodkf1a0aKqMSbCdR7LDzmwIIAYcUQIJVTR4dKWGb86H2_TeSAo9mIIUG
    cReJ-f-V8oJBRWPEEMhho_GGJ09FR2T_pNpIAfuSicFAd5OPw>
X-ME-Received: <xmr:jfELac5l1pgGGuA_2dZTl2s6yp2UEtcwwA-RfIYg3WSlOxJXd53ePPw9olVmeLH7o075HatuDFzN2LbAwck-02an7ayuoJMyUcDDva39ESr1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epheehjedthfegiedufeefgeevkeffhfduveegteektefhhefggeduieehieekgffgnecu
    ffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhgihhthhhusgdrtghomhdpkhgvrhhnvg
    hlrdhorhhgpddtuddrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtth
    hopeefgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehthihhihgtkhhs
    rdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtth
    hopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdr
    tghomhdprhgtphhtthhopehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopeguhhhofigv
    lhhlshesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:jfELacrRi4SgsbizRE6AUTaXXftMlnCM-POU0yBQzCAR4ZtCP6A0UQ>
    <xmx:jfELaQDGu_Zo9JNMX7hV9V_a53rIl7FDsAen1DvAXsbwc3MpaMp0QA>
    <xmx:jfELadNCuR4RjpuVTK8umiuv_uM4nn8kRMGDGsSNVvhJ5OfcuiGbiw>
    <xmx:jfELaXmIOb0G1hyib2CfAFFBkesRVPIgwESw-xdlSFXE0L17LasaAg>
    <xmx:kPELaZ_1AUytM_IrMFErhME7e8Cb_3Om39m8SYINOJSdpjPX_6Yk5pBG>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:53:25 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Christian Brauner" <brauner@kernel.org>, oe-kbuild@lists.linux.dev,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, lkp@intel.com,
 oe-kbuild-all@lists.linux.dev, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chris Mason" <chris.mason@fusionio.com>,
 "David Sterba" <dsterba@suse.com>, "David Howells" <dhowells@redhat.com>,
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
 "Stefan Berger" <stefanb@linux.ibm.com>
Subject: Re: [PATCH v4 04/14] VFS/nfsd/cachefiles/ovl: add start_creating()
 and end_creating()
In-reply-to:
 <CAOQ4uxgaANjJXdhiQamgop8cicWXZ7Er2CWW3W7w-VgNMn9OVw@mail.gmail.com>
References: <20251029234353.1321957-5-neilb@ownmail.net>,
 <202511021406.Tv3dcpn5-lkp@intel.com>,
 <CAOQ4uxgaANjJXdhiQamgop8cicWXZ7Er2CWW3W7w-VgNMn9OVw@mail.gmail.com>
Date: Thu, 06 Nov 2025 11:53:21 +1100
Message-id: <176239040101.634289.7648391031383720166@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 02 Nov 2025, Amir Goldstein wrote:
> On Sun, Nov 2, 2025 at 10:08=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
> >
> > Hi NeilBrown,
> >
> > kernel test robot noticed the following build warnings:
> >
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/debugfs-=
rename-end_creating-to-debugfs_end_creating/20251030-075146
> > base:   driver-core/driver-core-testing
> > patch link:    https://lore.kernel.org/r/20251029234353.1321957-5-neilb%4=
0ownmail.net
> > patch subject: [PATCH v4 04/14] VFS/nfsd/cachefiles/ovl: add start_creati=
ng() and end_creating()
> > config: x86_64-randconfig-161-20251101 (https://download.01.org/0day-ci/a=
rchive/20251102/202511021406.Tv3dcpn5-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202511021406.Tv3dcpn5-lkp@intel.com/
> >
> > smatch warnings:
> > fs/overlayfs/dir.c:130 ovl_whiteout() error: uninitialized symbol 'whiteo=
ut'.
> > fs/overlayfs/dir.c:130 ovl_whiteout() warn: passing zero to 'PTR_ERR'
> >
> > vim +/whiteout +130 fs/overlayfs/dir.c
> >
> > c21c839b8448dd Chengguang Xu     2020-04-24   97  static struct dentry *o=
vl_whiteout(struct ovl_fs *ofs)
> > e9be9d5e76e348 Miklos Szeredi    2014-10-24   98  {
> > e9be9d5e76e348 Miklos Szeredi    2014-10-24   99        int err;
> > 807b78b0fffc23 NeilBrown         2025-10-30  100        struct dentry *wh=
iteout, *link;
> > c21c839b8448dd Chengguang Xu     2020-04-24  101        struct dentry *wo=
rkdir =3D ofs->workdir;
> > e9be9d5e76e348 Miklos Szeredi    2014-10-24  102        struct inode *wdi=
r =3D workdir->d_inode;
> > e9be9d5e76e348 Miklos Szeredi    2014-10-24  103
> > 8afa0a73671389 NeilBrown         2025-07-16  104        guard(mutex)(&ofs=
->whiteout_lock);
> > 8afa0a73671389 NeilBrown         2025-07-16  105
> > c21c839b8448dd Chengguang Xu     2020-04-24  106        if (!ofs->whiteou=
t) {
> > 807b78b0fffc23 NeilBrown         2025-10-30  107                whiteout =
=3D ovl_start_creating_temp(ofs, workdir);
> > 8afa0a73671389 NeilBrown         2025-07-16  108                if (IS_ER=
R(whiteout))
> > 8afa0a73671389 NeilBrown         2025-07-16  109                        r=
eturn whiteout;
> >
> > white out is not an error pointer.
> >
> > 807b78b0fffc23 NeilBrown         2025-10-30  110                err =3D o=
vl_do_whiteout(ofs, wdir, whiteout);
> > 807b78b0fffc23 NeilBrown         2025-10-30  111                if (!err)
> > 807b78b0fffc23 NeilBrown         2025-10-30  112                        o=
fs->whiteout =3D dget(whiteout);
> > 807b78b0fffc23 NeilBrown         2025-10-30  113                end_creat=
ing(whiteout, workdir);
> > 807b78b0fffc23 NeilBrown         2025-10-30  114                if (err)
> > 807b78b0fffc23 NeilBrown         2025-10-30  115                        r=
eturn ERR_PTR(err);
> > e9be9d5e76e348 Miklos Szeredi    2014-10-24  116        }
> >
> > whiteout not set on else path
> >
> > e9be9d5e76e348 Miklos Szeredi    2014-10-24  117
> > e4599d4b1aeff0 Amir Goldstein    2023-06-17  118        if (!ofs->no_shar=
ed_whiteout) {
> > 807b78b0fffc23 NeilBrown         2025-10-30  119                link =3D =
ovl_start_creating_temp(ofs, workdir);
> > 807b78b0fffc23 NeilBrown         2025-10-30  120                if (IS_ER=
R(link))
> > 807b78b0fffc23 NeilBrown         2025-10-30  121                        r=
eturn link;
> > 807b78b0fffc23 NeilBrown         2025-10-30  122                err =3D o=
vl_do_link(ofs, ofs->whiteout, wdir, link);
> > 807b78b0fffc23 NeilBrown         2025-10-30  123                if (!err)
> > 807b78b0fffc23 NeilBrown         2025-10-30  124                        w=
hiteout =3D dget(link);
> >
> > It's set here, but then returned on line 127.
> >
> > 807b78b0fffc23 NeilBrown         2025-10-30  125                end_creat=
ing(link, workdir);
> > 807b78b0fffc23 NeilBrown         2025-10-30  126                if (!err)
> > 807b78b0fffc23 NeilBrown         2025-10-30  127                        r=
eturn whiteout;;
> >
> > nit: double ;;
> >
> > 807b78b0fffc23 NeilBrown         2025-10-30  128
> > 807b78b0fffc23 NeilBrown         2025-10-30  129                if (err !=
=3D -EMLINK) {
> > 672820a070ea5e Antonio Quartulli 2025-07-21 @130                        p=
r_warn("Failed to link whiteout - disabling whiteout inode sharing(nlink=3D%u=
, err=3D%lu)\n",
> > 672820a070ea5e Antonio Quartulli 2025-07-21  131                         =
       ofs->whiteout->d_inode->i_nlink,
> > 672820a070ea5e Antonio Quartulli 2025-07-21  132                         =
       PTR_ERR(whiteout));
> >
> > whiteout is either valid or uninitialized.  For some reason
> > Smatch thinks whiteout can be NULL, I suspect because of
> > the NULL check in dget().
> >
>=20
> That looks like "rebase race" with the fix commit 672820a070ea5e
> ("ovl: properly print correct variable").
>=20
> The fix is no longer correct, but also no longer needed because of
> early return on lookup error in line 121.
>=20
> This implies that there is also a change of behavior in this patch
> causing that an error in lookup will not have a warning.
>=20
> I have no problem with this change, because the warning text
> indicated it was intended to refer to errors in linking.
>=20
> Long story short, patch needs to go back to using err here for
> printing the link error.

Thanks.  I've revised that patch to use 'err' and '%d'.

NeilBrown

