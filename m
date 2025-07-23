Return-Path: <linux-fsdevel+bounces-55909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059DDB0FD2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 01:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EC8540080
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A49258CE2;
	Wed, 23 Jul 2025 23:04:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE3D1FE44B;
	Wed, 23 Jul 2025 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753311843; cv=none; b=FcYz8OQCDCu/IZzvUwIRBnUjwmK8+WsUnfoxfMymv4WGtixJOvIJaXiJwa9XiG8d9KStv8INGlerGIHniKrkORvEzgPAuwREFbBErzmCR8xOZwA//9gpHF+ZrWsYDl9U8CpFq1/oPPO/jjQF2VJ05tX42HsMG50HgoxSHVnY4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753311843; c=relaxed/simple;
	bh=OsyTVejZrBw4RrdCyeMm63DNMM1jWK4/3z661wCLRRE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=p/JKdIU0HTt6NAWqaSe3J6lOge7lGp1DFl9umTgssNLwu1/6+c3KZUrFsDn7chyx3HdCdoRyWttkDofHfBpyPGLkfj5ygtHU8v7lFPnIE/N9b7LvQsesQdUYppOqCfLy8pjfUgT/tIa7U1dbbdtRiQSsz7rPsujuuIFLlqBQM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ueiV6-003BD1-Dk;
	Wed, 23 Jul 2025 23:03:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Stefan Metzmacher" <metze@samba.org>
Cc: "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Tom Talpey" <tom@talpey.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] smb/server: add ksmbd_vfs_kern_path()
In-reply-to: <8ae2444f-e33e-4d78-9349-429b32f129d5@samba.org>
References: <>, <8ae2444f-e33e-4d78-9349-429b32f129d5@samba.org>
Date: Thu, 24 Jul 2025 09:03:53 +1000
Message-id: <175331183374.2234665.16356100340389738205@noble.neil.brown.name>

On Thu, 24 Jul 2025, Stefan Metzmacher wrote:
> Hi Neil,
>=20
> for me this reliable generates the following problem, just doing a simple:
> mount -t cifs -ousername=3Droot,password=3Dtest,noperm,vers=3D3.1.1,mfsymli=
nks,actimeo=3D0 //172.31.9.167/test /mnt/test/
>=20
> [ 2213.234061] [   T1972] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 2213.234607] [   T1972] BUG: KASAN: slab-use-after-free in lookup_noperm_=
common+0x237/0x2b0

Hi,
 thanks for testing and reporting.  Sorry about this obvious bug...

I called putname() too early.  The following should fix it.  Please test
and support.
Namjae: it would be good to squash this into the offending patch before
submitting upstream.  Can you do that?  Do you want me to resend the
whole patch?

Thanks,
NeilBrown

--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -53,7 +53,7 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_config =
*share_conf,
 				 struct path *path, bool do_lock)
 {
 	struct qstr last;
-	struct filename *filename;
+	struct filename *filename __free(putname) =3D NULL;
 	struct path *root_share_path =3D &share_conf->vfs_path;
 	int err, type;
 	struct dentry *d;
@@ -72,7 +72,6 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_config =
*share_conf,
 	err =3D vfs_path_parent_lookup(filename, flags,
 				     path, &last, &type,
 				     root_share_path);
-	putname(filename);
 	if (err)
 		return err;
=20

