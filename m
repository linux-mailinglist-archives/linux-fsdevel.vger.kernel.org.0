Return-Path: <linux-fsdevel+bounces-70938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE125CAA5F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 13:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A470530133EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 12:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9752F39B0;
	Sat,  6 Dec 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="TiOYYR44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64B7640E;
	Sat,  6 Dec 2025 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765022628; cv=none; b=o7s0W2aEOhzsdsd4f3/efT040LVWMMBhA8CqTl5hum7qFYvzPb9iB6zyDfOtQIesc02qmyTyFyZzr/4zaOjmg/THkXOhxo0egaqjQMxMQNwze5K+1TJndy+z9r/kTfwFxP2IXlhx14t0hocddAbm+j8Mc3hIExPEl6uy16WxoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765022628; c=relaxed/simple;
	bh=lOLBjT1FhIQMNdS5V7F5ONlL7N51IXCMEKC6ONpFAww=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lhjcHXDHCaZEfXxCBw+JqUjcBL0UV8vpfj6HyRJ2IP6BatfNWQG8YBJu5227LK6vbxbT6rKtxSbThzR3OUNS74rimMG586YniWSuPTXbT0+kDCpQhZ+vcKJjRJ2dNz+xrYIkURHIKGbO/JIU4Kq4pI2wfiDdo2xLFfFhOZkc2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=TiOYYR44; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1765022616;
	bh=lOLBjT1FhIQMNdS5V7F5ONlL7N51IXCMEKC6ONpFAww=;
	h=Date:From:To:Subject:From;
	b=TiOYYR44wI5xIrclsohvgNwsQncXwoWRlLwldFtgG2KBbS+JTVL1jfneLLqAyTNor
	 0I6EkMasJxa6Kj+2y0fvlaHQOc+CiacTwUHxqDMtDGqbhiI9Z/0R5DIiAeuY4AyOGP
	 9GzPaML6fgMcDYBrI2o9g7T94R6dhE7WaoPJyy1MFI5rbvFpJGqQwGMlW/oY0RvCqc
	 5xJaZ2oCQPPjMAWA4cCud+so5n6K7JtqcuZySRFoGX1HSAlFnzJlZBBbVi/vPE4ZH3
	 hQSxbzXgTiP+GUNVsvHU1v9QM7eenkKDuALIWSDeyXwx6Kz+aLcGRzYLOFhPEMQPEO
	 lk0ebJtN1MR/g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0749FE3F4;
	Sat,  6 Dec 2025 13:03:36 +0100 (CET)
Date: Sat, 6 Dec 2025 13:03:35 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs: enforce the immutable flag on open files
Message-ID: <znhu3eyffewvvhleewehuvod2wrf4tz6vxrouoakiarjtxt5uy@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iyozfdnhfasyy5ay"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--iyozfdnhfasyy5ay
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This useful behaviour is implemented for most filesystems,
and wants to be implemented for every filesystem, quoth ref:
  There is general agreement that we should standardize all file systems
  to prevent modifications even for files that were opened at the time
  the immutable flag is set.  Eventually, a change to enforce this at
  the VFS layer should be landing in mainline.

References: commit 02b016ca7f99 ("ext4: enforce the immutable flag on
 open files")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
/ext4# uname -a
Linux tarta 6.18.0-10912-g416f99c3b16f-dirty #1 SMP PREEMPT_DYNAMIC Sat Dec=
  6 12:14:41 CET 2025 x86_64 GNU/Linux
/ext4# while sleep 1; do echo $$; done > file &
[1] 262
/ext4# chattr +i file
/ext4# sh: line 25: echo: write error: Operation not permitted
sh: line 25: echo: write error: Operation not permitted
sh: line 25: echo: write error: Operation not permitted
sh: line 25: echo: write error: Operation not permitted
fg
while sleep 1; do
    echo $$;
done > file
^C
/ext4# mount -t tmpfs tmpfs /tmp
/ext4# cd /tmp
/tmp# while sleep 1; do echo $$; done > file &
[1] 284
/tmp# chattr +i file
/tmp# sh: line 35: echo: write error: Operation not permitted
sh: line 35: echo: write error: Operation not permitted
sh: line 35: echo: write error: Operation not permitted

 mm/filemap.c | 10 ++++++++--
 mm/shmem.c   | 12 ++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a..0b0d5cfbcd44 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3945,12 +3945,18 @@ EXPORT_SYMBOL(filemap_map_pages);
=20
 vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 {
-	struct address_space *mapping =3D vmf->vma->vm_file->f_mapping;
+	struct file *file =3D vmf->vma->vm_file;
+	struct address_space *mapping =3D file->f_mapping;
 	struct folio *folio =3D page_folio(vmf->page);
 	vm_fault_t ret =3D VM_FAULT_LOCKED;
=20
+	if (unlikely(IS_IMMUTABLE(file_inode(file)))) {
+		ret =3D VM_FAULT_SIGBUS;
+		goto out;
+	}
+
 	sb_start_pagefault(mapping->host->i_sb);
-	file_update_time(vmf->vma->vm_file);
+	file_update_time(file);
 	folio_lock(folio);
 	if (folio->mapping !=3D mapping) {
 		folio_unlock(folio);
diff --git a/mm/shmem.c b/mm/shmem.c
index d578d8e765d7..5d3fbf4efb3d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1294,6 +1294,14 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 	bool update_mtime =3D false;
 	bool update_ctime =3D true;
=20
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return -EPERM;
+
+	if (unlikely(IS_APPEND(inode) &&
+		     (attr->ia_valid & (ATTR_MODE | ATTR_UID |
+					ATTR_GID | ATTR_TIMES_SET))))
+		return -EPERM;
+
 	error =3D setattr_prepare(idmap, dentry, attr);
 	if (error)
 		return error;
@@ -3475,6 +3483,10 @@ static ssize_t shmem_file_write_iter(struct kiocb *i=
ocb, struct iov_iter *from)
 	ret =3D generic_write_checks(iocb, from);
 	if (ret <=3D 0)
 		goto unlock;
+	if (unlikely(IS_IMMUTABLE(inode))) {
+		ret =3D -EPERM;
+		goto unlock;
+	}
 	ret =3D file_remove_privs(file);
 	if (ret)
 		goto unlock;
--=20
2.39.5

--iyozfdnhfasyy5ay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmk0G5cACgkQvP0LAY0m
WPFvIBAAk19V5uv/iePKa0AKLG5tkWQK6HUqaR/8OfHJ7jzQLHX65huV5VexvAwJ
BAu0GmaA97FjfnVlMjDfNGvrQYCr3qQz1WQqsjMMb87VkcO7I0qwAfkhzzhX9RXv
cxgzUbyBzM+yGmI7P4GU+LjV1dO10p0+5rd1gFIfzJkwyhN2wf5jgSziFu5phiYl
QBboDk9cgz7js6nefDMOUUf8nbdWPwdUueWmKfTHTim14FplslAwlX3X19UDU5Mi
KdA96wd9XTA1kVcduDchwFX1VflYdibzEGmtPMKMenYVnGskDDM+qAlJalno4/wK
D3LZsw0Q6bT0CE+md3NGaaaH7p+6nYyBTXvt+MkaF5cjesXUZg3175L5LYsO+T2L
Ub0yAEXgJpIFl9UIPoTAASRqlYXCv3HUKL8mAAOQH21okpgkAzgqvwXEOaDagA2R
n7U2zSIl6gr2TJgL4HVsUdwEVkKy+lmxKy2oc78ny0RXFrFDCJMAcnQuIL/7poz/
q9qErl3EtfPEvHj/r+T6CFK3YOwMa/SePinBcnvh4o2eD+5Lo0W2DJcKnL/gEPXQ
uoXSzjexYmpI0MOZR+rKWiYgmTM3Ll6Wp2CwPsC9hD1ChMsTlEQsoeKwVpzZCnVP
rt+HO4oIjacRf4EyHnyARf8q5jUEWMXDsJmrUf9hZLCL81GuB64=
=ybT3
-----END PGP SIGNATURE-----

--iyozfdnhfasyy5ay--

