Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1881107
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 06:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfHEE0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 00:26:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:43414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbfHEE0S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 00:26:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "To"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E9DFACC1;
        Mon,  5 Aug 2019 04:26:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
To:     Sergei Turchanov <turchanov@farpost.com>
Date:   Mon, 05 Aug 2019 14:26:08 +1000
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] seq_file: fix problem when seeking mid-record.
In-Reply-To: <2d54ca59-9c22-0b75-3087-3718b30b8d11@farpost.com>
References: <3bd775ab-9e31-c6b3-374e-7a9982a9a8cd@farpost.com> <5c4c0648-2a96-4132-9d22-91c22e7c7d4d@huawei.com> <eab812ef-ba79-11d6-0a4e-232872f0fcc4@farpost.com> <877e7xl029.fsf@notabene.neil.brown.name> <2d54ca59-9c22-0b75-3087-3718b30b8d11@farpost.com>
Message-ID: <87mugojl0f.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


If you use lseek or similar (e.g. pread) to access
a location in a seq_file file that is within a record,
rather than at a record boundary, then the first read
will return the remainder of the record, and the second
read will return the whole of that same record (instead
of the next record).
Whnn seeking to a record boundary, the next record is
correctly returned.

This bug was introduced by a recent patch (identified below)
Before that patch, seq_read() would increment m->index when
the last of the buffer was returned (m->count =3D=3D 0).
After that patch, we rely on ->next to increment m->index
after filling the buffer - but there was one place where that
didn't happen.

Link: https://lkml.kernel.org/lkml/877e7xl029.fsf@notabene.neil.brown.name/
Reported-by-tested-by: Sergei Turchanov <turchanov@farpost.com>
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code
	and interface")
Cc: stable@vger.kernel.org (v4.19+)
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

Hi Andrew: as you applied the offending patch for me, maybe you could
queue up this fix too.
Thanks,
NeilBrown

 fs/seq_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 04f09689cd6d..1600034a929b 100644
=2D-- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -119,6 +119,7 @@ static int traverse(struct seq_file *m, loff_t offset)
 		}
 		if (seq_has_overflowed(m))
 			goto Eoverflow;
+		p =3D m->op->next(m, p, &m->index);
 		if (pos + m->count > offset) {
 			m->from =3D offset - pos;
 			m->count -=3D m->from;
@@ -126,7 +127,6 @@ static int traverse(struct seq_file *m, loff_t offset)
 		}
 		pos +=3D m->count;
 		m->count =3D 0;
=2D		p =3D m->op->next(m, p, &m->index);
 		if (pos =3D=3D offset)
 			break;
 	}
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1Hr+AACgkQOeye3VZi
gblFQw//WFFSPovVwp9N+BvIWmjw6cxpwTYE0X2mOrFVYjis4ijpXsu5aoN3qDWj
XNfyU5HHf0vM1estIAD+SBHBKnhHfWHZqCh0Xxqb5fTPcm1HjHWnUjdWlPDEmtfp
7ZbmyTV7RWb+BQ1SE/P9kyLv+A9oerJRwQEXz4UI9XydYfmzoFyCSjlo9MuM5AD3
cX3ScwAMlVNv3O5l/gFlOAU9snWp8nU9ngSfQ88GL5ML/ryFbdXW7UFPkFn3Wmiq
3spMA4tsJNEekbxTCU/TNxqnVHZc+s4yIhpwVc2c0u5oMLxIExSig9GU2AEO/4jH
4DhkW56z4jOSh2sK0tWNAJmHtRwYREbik+CEKJmfQgiSG5Qh5rvWuFk7U75TLi4x
wEWCgaoPwCUTFM7JD6UUtJNdJa1+C9HyWaNp2uvpNLWuYQ0wQtCIvgCgmm+XXlnq
KuvVtqcjmVDQ/ElsvrMP1gkvxTPjlVXqwc7dmazY/641rob8L4CR2hlXDpS9tM4M
NsyxN+pROTJYNcWXnJCnZjkb57ohEpfh3/SgwOv3EIi9h81S7kyIrs4Y3SpvIDww
+035RWcVoy9nnzRiAP+x4xgmM5MGaCNWN+Tw6dEYu/UZKpHdqLc3KiSnIfOqQPS3
kKGyopfrBZXk5Vl5lnM39zeBe48Io9rU+iDA2fBRUY2x8cDHDd8=
=JONQ
-----END PGP SIGNATURE-----
--=-=-=--
