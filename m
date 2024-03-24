Return-Path: <linux-fsdevel+bounces-15175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E995887D9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 17:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029A81F212E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1431219474;
	Sun, 24 Mar 2024 16:50:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03756171D1;
	Sun, 24 Mar 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299037; cv=none; b=s3ATE9PF+1J875MCaAxsL/K4heWSn06ZYsztn3M+ouSnA7JYZKLFXbaKbEgY9zTH9qts4dzTZJVv1ASeLQLjbkXJ8Jx6bT/q0Nr+CmPCQDrrorMwfwcIVHa555x55GsHz6Y85rfE457MkALwno3BcMlMWct1mf3c8ocHYvC2Yro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299037; c=relaxed/simple;
	bh=XTqqWBJYofix9/upqo66g0+ko3ZgqhuOv6+PQmT0aqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RXwBpy6A2kStUAxAEXCUpGiakRjrMWzWoB/2rh3S0e39NEfuRNwLhM+tYz73qZR1FNLId5LPVTP2N5mdpoWwcvRoXeaqdi2Q19ZDO9Teu4z5BF0MiCHO6bEszltnfb3cwd0VjaGsGwpc0M7bbIqPEwKijgMf+lXRYER8dkfuy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V2hlZ1fj7z6K7JS;
	Mon, 25 Mar 2024 00:46:02 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 401151400DB;
	Mon, 25 Mar 2024 00:50:25 +0800 (CST)
Received: from frapeml500005.china.huawei.com (7.182.85.13) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 24 Mar 2024 17:50:24 +0100
Received: from frapeml500005.china.huawei.com ([7.182.85.13]) by
 frapeml500005.china.huawei.com ([7.182.85.13]) with mapi id 15.01.2507.035;
 Sun, 24 Mar 2024 17:50:24 +0100
From: Roberto Sassu <roberto.sassu@huawei.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel
	<linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, "Paulo
 Alcantara" <pc@manguebit.com>, Christian Brauner <christian@brauner.io>,
	"Mimi Zohar" <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: RE: kernel crash in mknod
Thread-Topic: kernel crash in mknod
Thread-Index: AQHafag2XY/u/k17xEe65QyoT7TnEbFGUTAAgADHHcA=
Date: Sun, 24 Mar 2024 16:50:24 +0000
Message-ID: <3441a4a1140944f5b418b70f557bca72@huawei.com>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
In-Reply-To: <20240324054636.GT538574@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> From: Al Viro [mailto:viro@ftp.linux.org.uk] On Behalf Of Al Viro
> Sent: Sunday, March 24, 2024 6:47 AM
> On Sun, Mar 24, 2024 at 12:00:15AM -0500, Steve French wrote:
> > Anyone else seeing this kernel crash in do_mknodat (I see it with a
> > simple "mkfifo" on smb3 mount).  I started seeing this in 6.9-rc (did
> > not see it in 6.8).   I did not see it with the 3/12/23 mainline
> > (early in the 6.9-rc merge Window) but I do see it in the 3/22 build
> > so it looks like the regression was introduced by:
>=20
> 	FWIW, successful ->mknod() is allowed to return 0 and unhash
> dentry, rather than bothering with lookups.  So commit in question
> is bogus - lack of error does *NOT* mean that you have struct inode
> existing, let alone attached to dentry.  That kind of behaviour
> used to be common for network filesystems more than just for ->mknod(),
> the theory being "if somebody wants to look at it, they can bloody
> well pay the cost of lookup after dcache miss".
>=20
> Said that, the language in D/f/vfs.rst is vague as hell and is very easy
> to misread in direction of "you must instantiate".
>=20
> Thankfully, there's no counterpart with mkdir - *there* it's not just
> possible, it's inevitable in some cases for e.g. nfs.
>=20
> What the hell is that hook doing in non-S_IFREG cases, anyway?  Move it
> up and be done with it...

Hi Al

thanks for the patch. Indeed, it was like that before, when instead of
an LSM hook there was an IMA call.

However, I thought, since we were promoting it as an LSM hook,
we should be as generic possible, and support more usages than
what was needed for IMA.

> diff --git a/fs/namei.c b/fs/namei.c
> index ceb9ddf8dfdd..821fe0e3f171 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4050,6 +4050,8 @@ static int do_mknodat(int dfd, struct filename *nam=
e, umode_t mode,
>  		case 0: case S_IFREG:
>  			error =3D vfs_create(idmap, path.dentry->d_inode,
>  					   dentry, mode, true);
> +			if (!error)
> +				error =3D security_path_post_mknod(idmap, dentry);

Minor issue, security_path_post_mknod() does not return an error.

Also, please update the description of security_path_post_mknod() to say
that it is not going to be called for non-regular files.

Hopefully, Paul also agrees with this change.

Other than that, please add my:

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

>  			break;
>  		case S_IFCHR: case S_IFBLK:
>  			error =3D vfs_mknod(idmap, path.dentry->d_inode,
> @@ -4061,10 +4063,6 @@ static int do_mknodat(int dfd, struct filename *na=
me, umode_t mode,
>  			break;
>  	}
>=20
> -	if (error)
> -		goto out2;
> -
> -	security_path_post_mknod(idmap, dentry);
>  out2:
>  	done_path_create(&path, dentry);
>  	if (retry_estale(error, lookup_flags)) {

