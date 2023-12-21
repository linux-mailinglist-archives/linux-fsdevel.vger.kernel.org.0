Return-Path: <linux-fsdevel+bounces-6623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDD081ACFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 04:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24787B21666
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 03:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81881A28F;
	Thu, 21 Dec 2023 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="QZmoX77V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF97465;
	Thu, 21 Dec 2023 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703128153;
	bh=Th4fa7MCjmNnRPOCcYkriGTTe1mzhXYl0tas+sW0PFs=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=QZmoX77VwzQxQHIG1I56OoFEDolsC6mQnhbznWXo6F2+hmH01F3MkkiwHN9SXcwzJ
	 g0QW/nQrIqn41sTciSQNp7k1k2PfnQ99LjtiwdJSr/g6T31J/41WDWbRaOQc9fUCrX
	 U3SOYC7eBBoXhVWDZPomuDCJU8gtlUwOnfDTgBvFcTC5dSOLfepH/1EdkurAwN7DqW
	 HY1ui1CQ/r2/R8oX3lE2APrABJuAvFGhimZHGma1oxyaePZP8+80wxo7peqNlLXJ5l
	 pEV43tDp8/0XgbfVtoJyAFCaWSk2k/2meqF0FfbFhjcFEYbu9Wf5qkF9fuIjw25XeS
	 n00zYlXNJ/HNA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 44BF813DB4;
	Thu, 21 Dec 2023 04:09:13 +0100 (CET)
Date: Thu, 21 Dec 2023 04:09:13 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH v2 09/11] fuse: file: limit splice_read to virtiofs
Message-ID: <9b5cd13bc9e9c570978ec25b25ba5e4081b3d56b.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qp36uiiyfau5l6kb"
Content-Disposition: inline
In-Reply-To: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--qp36uiiyfau5l6kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Potentially-blocking splice_reads are allowed for normal filesystems
like NFS because they're blessed by root.

FUSE is commonly used suid-root, and allows anyone to trivially create
a file that, when spliced from, will just sleep forever with the pipe
lock held.

The only way IPC to the fusing process could be avoided is if
!(ff->open_flags & FOPEN_DIRECT_IO) and the range was already cached
and we weren't past the end. Just refuse it.

virtiofs behaves like a normal filesystem and can only be mounted
by root, it's unaffected by use of a new "trusted" connection flag.
This may be extended to include real FUSE mounts by processes which
aren't suid, to match the semantics for normal filesystems.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/fuse/file.c      | 17 ++++++++++++++++-
 fs/fuse/fuse_i.h    |  3 +++
 fs/fuse/virtio_fs.c |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a660f1f21540..20bb16ddfcc9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3200,6 +3200,21 @@ static ssize_t fuse_copy_file_range(struct file *src=
_file, loff_t src_off,
 	return ret;
 }
=20
+static long fuse_splice_read(struct file *in, loff_t *ppos,
+			     struct pipe_inode_info *pipe, size_t len,
+			     unsigned int flags)
+{
+	struct inode *inode =3D file_inode(in);
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (get_fuse_conn(inode)->trusted)
+		return filemap_splice_read(in, ppos, pipe, len, flags);
+
+	return -EINVAL;
+}
+
 static const struct file_operations fuse_file_operations =3D {
 	.llseek		=3D fuse_file_llseek,
 	.read_iter	=3D fuse_file_read_iter,
@@ -3212,7 +3227,7 @@ static const struct file_operations fuse_file_operati=
ons =3D {
 	.lock		=3D fuse_file_lock,
 	.get_unmapped_area =3D thp_get_unmapped_area,
 	.flock		=3D fuse_file_flock,
-	.splice_read	=3D filemap_splice_read,
+	.splice_read	=3D fuse_splice_read,
 	.splice_write	=3D iter_file_splice_write,
 	.unlocked_ioctl	=3D fuse_file_ioctl,
 	.compat_ioctl	=3D fuse_file_compat_ioctl,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda92..463c5d4ad8b4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -818,6 +818,9 @@ struct fuse_conn {
 	/* Is statx not implemented by fs? */
 	unsigned int no_statx:1;
=20
+	/* Do we trust this connection to always respond? */
+	bool trusted:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
=20
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..fce0fe24899a 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1448,6 +1448,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	fc->delete_stale =3D true;
 	fc->auto_submounts =3D true;
 	fc->sync_fs =3D true;
+	fc->trusted =3D true;
=20
 	/* Tell FUSE to split requests that exceed the virtqueue's size */
 	fc->max_pages_limit =3D min_t(unsigned int, fc->max_pages_limit,
--=20
2.39.2

--qp36uiiyfau5l6kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWDrFgACgkQvP0LAY0m
WPE6bBAArSzFLci7I06LCeYhlu5UXyY+B2cQcDtpihX9SkF7Jy5KxZDikGWZLFgl
bDzsYbSxr7ya3KLjC4/XUG18ZV5NWOE36PkTM/54kRGaKiL3BrkoWptISfAeYiPy
EVuo3CzWkEy5ZgqI7f8yUES+UE05NvPyw5AkA7j6xLow2Dqtcun8L0wS4kj/UdGt
VATtgv0202LWj2sC73W50T5K8KLLpkCHPljDM6cMHwXbMPCwp62As9sAXzKwMqAj
aOm7/2qeRscObS3t4xi8Itxw0Vf/91jv7UMBTZesov5bxpF9HGJUqyd/I/17/nkn
pPJb2PznxC85sQBOPfl2fdySOGiI36ViowF4HIjadR2efnc2kguR0xj5G3garPhq
gv7B/LFjIS61cNHW7KgGuQ7gBs+axR6cm0sKy6k9BYZSewuYWPAT3uCiYKO84j+m
Yx/cm7WFzzk1HPQyKRJhGEoyb6ne+2j6xmMwDszHkGlKx6hyT6g5KJ5E5Ot1xgSI
STf1mvLA6M4op071/rh9ziNaJUNV48ar8pqeqOJBnHTtd7lFzoM5MRzcDqjHT2Fr
khzXnBP/oShH2Zqyuh2lIv5IZx5Hmg/rP325AZjMJzoT76LNZV9zbcvT99dAYjaE
rnX7WVmcHO8BRC+0zv56YlvfXfbIYc7DHo8IZ8RW4bgqii4hToM=
=bHn5
-----END PGP SIGNATURE-----

--qp36uiiyfau5l6kb--

