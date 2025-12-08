Return-Path: <linux-fsdevel+bounces-70983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D89EDCAE513
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 23:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC6930640EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909F02E8E1F;
	Mon,  8 Dec 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="aqFQfSeu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174022A7E4;
	Mon,  8 Dec 2025 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765232430; cv=none; b=Ew9k34hsB5H5v9hYuLhri3JgQuIXF/tiAbJ0sAy5JQQk9CZp3HjvJgAonDBTehGRpsenGEPRiaBMjqHPOVapGZCcXVClW9jeiXbtggZ3snxCDyCcB050V4YDht6y/76JoKqJd8C3dcPRUiIfdmOn54yg8kw4/FdPviA/lWvj/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765232430; c=relaxed/simple;
	bh=9p6wlGm8hM2GxaqyatBdV+R4t489utEAgE9fEsfKe/s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QS7o8MHDAkiZcWPOM/ArgOa9iBDFRfU3HzXtPEs4Rj7MwjRO7FFDrAfX/08IWhpfN4dSHxT5omTGKvyzgMTVYEtJx80vE5XarNoUt5nVYFHZKfBGs0/NehOR06EHIgh4YY42xxRja34CkK4QVShbThGs4xelJU2+DBgrdOmqwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=aqFQfSeu; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1765232424;
	bh=9p6wlGm8hM2GxaqyatBdV+R4t489utEAgE9fEsfKe/s=;
	h=Date:From:To:Subject:From;
	b=aqFQfSeuqwDdiVHSDyt7zRvNYoCXsXw0HBA+pwvFtB6LZsnB0ypAhENpSUKBdx/yU
	 jX7Bat2Bfnxkbjpf/iUP6CzWQ+S/cfRH1IGaYNQ1x00SryXDhrtnhlo+pbGYrqoOzC
	 ZDZN6j0WlY0lZbAmBXGqi4qD6IbZStBv4wG/U4iQbfm29ZjBH4bUv0rXgxSOq0Ivim
	 n/KOdTMKCOTx1xSFZSwQjnHLuLw+MprI+/35AO+Wxfc+eq84pV+ilr5hB9z6OK7PZb
	 UJka7ARkNRUSlo0IoYw/lhqzmUKJnMHfYs3XEyDaW48zCDN9LrZ+VfR+8UejBn7wdp
	 jqz0qwCk2Dxjw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 930E2EFC6;
	Mon,  8 Dec 2025 23:20:24 +0100 (CET)
Date: Mon, 8 Dec 2025 23:20:24 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: send fsnotify_xattr()/IN_ATTRIB from
 vfs_fileattr_set()/chattr(1)
Message-ID: <iyvn6qjotpu6cei5jdtsoibfcp6l6rgvn47cwgaucgtucpfy2s@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="apr664clce33v46y"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--apr664clce33v46y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently it seems impossible to observe these changes to the file's
attributes. It's useful to be able to do this to see when the file
becomes immutable, for example, so emit IN_ATTRIB via fsnotify_xattr(),
like when changing other inode attributes.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Given:
	#include <sys/inotify.h>
	#include <unistd.h>
	#include <stdio.h>
	#include <limits.h>
	int main() {
		int fd =3D inotify_init();
		inotify_add_watch(fd, ".", IN_ATTRIB);
		char buf[sizeof(struct inotify_event) + NAME_MAX + 1];
		for (;;) {
			ssize_t rd =3D read(fd, buf, sizeof(buf));
			struct inotify_event *ev =3D buf, *end =3D buf + rd;
			while (ev < end) {
				printf("%x\t%s\n", ev->mask, ev->name);
				ev =3D (char *)(ev + 1) + ev->len;
			}
		}
	}

Before:
	sh-5.2# ./test &
	[1] 255
	sh-5.2# chmod -x test
	4       test
	sh-5.2# setfattr -n user.name -v value test
	4       test
	sh-5.2# chattr -i test
	sh-5.2#

After:
	sh-5.2# ./test &
	[1] 280
	sh-5.2# chmod -x test
	4       test
	sh-5.2# setfattr -n user.name -v value test
	4       test
	sh-5.2# chattr -i test
	4       test
	sh-5.2#

 fs/file_attr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 4c4916632f11..13cdb31a3e94 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -2,6 +2,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/fscrypt.h>
+#include <linux/fsnotify.h>
 #include <linux/fileattr.h>
 #include <linux/export.h>
 #include <linux/syscalls.h>
@@ -298,6 +299,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct de=
ntry *dentry,
 		err =3D inode->i_op->fileattr_set(idmap, dentry, fa);
 		if (err)
 			goto out;
+		fsnotify_xattr(dentry);
 	}
=20
 out:
--=20
2.39.5

--apr664clce33v46y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmk3TygACgkQvP0LAY0m
WPFrZw/+MCsACKsWjC4mr9aVyQvhr4QZ4UzFRDREeQDMEVIweCJBfYKmwJtD+JXF
b1GGY4YtC3h6l8FSAcewY502e66zV21LdEmjxFBmIEJBU456+jiX0wukFdu4fkxi
bnIAiEmKnKpwu53M6lEsMEhXSFosefye/cVk5/npvzSMerdqSRaGmxhDZO05E5bE
VeOLj2FXiIqkeetHb09qYUT3ITH28ZpHRH6gFXltYqD+z9dNzq82kDkyVQGj/X1D
1Yl2JN5/uHIvg7ngsp4jHQtWUsULo4sNR2iypVBCEely4q3mjUTPaqy7TAjnGC+B
pDkxWwUKUhcAV241B8p80uqPfPkqibLN+aV7ZOQFtFoESH+KSpEgXTA91wJ+8h2C
75w3PXcM8Yb5gylUKefhCxlHunZGn2j2Szy64I3kEoozXj4yCo87VSflZbw7Z/kk
wPEV3DVgbnUI1lpo9RP3Li8Z+v4z2M3xwF211m6HfCiBY1yC8iRW2plBWRSMA7+0
f6F4M5RSpQfvrWUZpQrWGTjunDmaTvuV6LlVtucWA5BLHiAzbRbJk/qJyoinR41k
OnxypyrbucIqlBwGlnpzRdaGWiCl/NhE++V6SjgBmQ3WIppjd2asTVVQKqd1l86o
4FIqYGXcJ7ShQeOnRtfJMWFyWn5Vyu53k7qlT1ej0UjiH6GRcQA=
=kOjb
-----END PGP SIGNATURE-----

--apr664clce33v46y--

