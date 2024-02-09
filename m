Return-Path: <linux-fsdevel+bounces-10964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A3584F748
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31441F221F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEA669D1E;
	Fri,  9 Feb 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iNLm28Q5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D586995D
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488949; cv=none; b=kwyzW1KDFYhwYCnEHcHLx2mL1U98O75V0dQvhSbb4FgkP9pxfbb5AVZ+rd1tOIlAxEHF1Zs/oOFu0JaXATpv1dg8Iz1cSi40168uQMgewj89BqmPSZmGlZAXHsma59098ZoZX3qbG4DTT2r8IhqAQ7qtuoxNEwYDHElOMUbyzmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488949; c=relaxed/simple;
	bh=upFi55BRB2EZorGwFdgX6LBZWv46QR8JKnPuxrtnafY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=IrzPDep6G4Gy/ijiVODQ36SjwmSpH/3SEAovR3mgCwrn8qii5C7D0+mBgVmrKVeY7bf6hipd8LQgy9NWiztjESAPx+YvEJBPPDX0aUMuEL2sGbSI9vDOAMUaYLi9/YmFgEnG9lyvgyvDcK5JGkWBWPhcEhu0P2rP6hitpNReRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iNLm28Q5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240209142906euoutp023a27e8c04dca0b767779ff9d95dbacc5~yOCZW1pRg2144221442euoutp02b
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240209142906euoutp023a27e8c04dca0b767779ff9d95dbacc5~yOCZW1pRg2144221442euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707488946;
	bh=5EX9mww1Yf0rOpRLklIYKmjmJtYHS5jxFy+jU2z9Pew=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=iNLm28Q52eLnCOfv8G9K1mU0dX3bnVJ7nTJpdf1iOu6zrWSahXzu798GPGN2uutw3
	 dH9S2x4Fe0vbb3SYya8z7xMMwS4Tf9T4HQ5lzJx9Z0blo8q3MI7YDC/s9JKhNpAGMI
	 ea1TZ65+ON5c7yQwpys2kl8OdcvYvuKc4Kq8T3Io=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209142905eucas1p2901cf7d34b6c0b8739cc8cd9c806d0b4~yOCY8xfYl2314723147eucas1p2o;
	Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DA.F5.09814.1B636C56; Fri,  9
	Feb 2024 14:29:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240209142905eucas1p2df56a08287a84a5fa004142100926bb4~yOCYgKpDC0208802088eucas1p2M;
	Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240209142905eusmtrp2d681160c1113aac64263cd808d288845~yOCYfYvDM2110121101eusmtrp2a;
	Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-39-65c636b16a2a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 48.6F.09146.0B636C56; Fri,  9
	Feb 2024 14:29:05 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240209142904eusmtip2518107333d642b9a564504242782a9dc~yOCYU-zq50196001960eusmtip2M;
	Fri,  9 Feb 2024 14:29:04 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 9 Feb 2024 14:29:04 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 9 Feb
	2024 14:29:04 +0000
From: Daniel Gomez <da.gomez@samsung.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
	"hughd@google.com" <hughd@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "dagmcr@gmail.com" <dagmcr@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"willy@infradead.org" <willy@infradead.org>, "hch@infradead.org"
	<hch@infradead.org>, "mcgrof@kernel.org" <mcgrof@kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, "gost.dev@samsung.com" <gost.dev@samsung.com>,
	"Daniel Gomez" <da.gomez@samsung.com>
Subject: [RFC PATCH 3/9] shmem: move folio zero operation to write_begin()
Thread-Topic: [RFC PATCH 3/9] shmem: move folio zero operation to
	write_begin()
Thread-Index: AQHaW2RUQo5uE9Fs4EG+AkzmtoGKGQ==
Date: Fri, 9 Feb 2024 14:29:02 +0000
Message-ID: <20240209142901.126894-4-da.gomez@samsung.com>
In-Reply-To: <20240209142901.126894-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djP87obzY6lGly5o2gxZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGcVlk5Ka
	k1mWWqRvl8CVsfSyVcFzwYrPJ76yNDDe5+ti5OSQEDCRePJ1I3MXIxeHkMAKRomZP5YzQjhf
	GCWadt5jhXA+M0q8PzSRGaalZ9UzFojEckaJjmV7meGqlt/5CJU5zSgxbfFDhMlHF/5lB+ln
	E9CU2HdyEztIQkTgOaNE6+6PYA6zwG1miTntsxhBqoQFvCROfp4BZosIBEq877vAAmHrSXT8
	/cYGYrMIqEgsWHof7CpeASuJ5t5VYDangLXEvEfrwWoYBWQlHq38BbaZWUBc4taT+UwQXwhK
	LJq9B+ojMYl/ux6yQdg6EmevP2GEsA0kti7dxwJhK0p0HLvJBjFHT+LG1ClQtrbEsoWvoW4Q
	lDg58wnY/xICTVwSexZPYIVodpHoPL4eapmwxKvjW9ghbBmJ/zvnM01g1J6F5L5ZSHbMQrJj
	FpIdCxhZVjGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgSmudP/jn/Zwbj81Ue9Q4xMHIyH
	GCU4mJVEeEOWHEkV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi
	4JRqYIrKZW6esourctYD9YZejp5G53R3z3zPX2FTL81h6CsKz9T6kudiZjSh/++pFyZLNoYf
	32dVnnNVhe3JmsdTXqcZbjFZK/Jt6UQhVeaM+LNtElO2yp6+4Lkv2F//9V8Ok1pb3yVXZ6yW
	dEvS/lwa0bJ9uY74ovViIhev7f2wo89zj4rp/3DOvOLPSq76X+r3m2R1f/lvN2/uo3UHW6xO
	yTQLZbLzH3Mr6+LOc0l98e5/eOL+s3b7XiwW6PI/os1aEjyrt3Da8dV/buT/zumTFw5Q5A75
	teTT1llRNrez5BXvBggIVuXscjHp1smekVJ+a9+0Wu7X94xOxkiET5gjGLAnvbUkU5rl5P/n
	aR7PlViKMxINtZiLihMB4wymQOIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsVy+t/xe7obzY6lGtxZzWgxZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGaVnU5Rf
	WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsfSyVcFzwYrP
	J76yNDDe5+ti5OSQEDCR6Fn1jKWLkYtDSGApo0Rb92pGiISMxMYvV1khbGGJP9e62CCKPjJK
	/P11D6rjNKPEwTktUJkVjBJdi1YygbSwCWhK7Du5iR0kISLwlFFi+u9DYC3MAreZJea0zwJb
	IizgJXHy8wwwW0QgUOLP979sELaeRMffb2A2i4CKxIKl95lBbF4BK4nm3lVgthCQPW37abAa
	TgFriXmP1oPZjAKyEo9W/mIHsZkFxCVuPZnPBPGEgMSSPeeZIWxRiZeP/0E9pyNx9voTqKcN
	JLYu3ccCYStKdBy7yQYxR0/ixtQpULa2xLKFr6HuEZQ4OfMJywRG6VlI1s1C0jILScssJC0L
	GFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBCaqbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4
	Q5YcSRXiTUmsrEotyo8vKs1JLT7EaAoMo4nMUqLJ+cBUmVcSb2hmYGpoYmZpYGppZqwkzutZ
	0JEoJJCeWJKanZpakFoE08fEwSnVwJTw4+6k1eH5h6bWmDgtytWcdWPGlTNdFq7ak/4w/v5R
	+23y9H7OtMbX/6Kezgn56JGQmeRn1Gj57EfHe+UVDpv5xe5sPdQ68YboZDmXq5PyxF7kF+5+
	/+fqpaTwG0Y/Ny299Ub7Plfy80Y/Zl+lL7lSMZU3lTZfiXpSWTj/4vqZTZNSbhRw3F3Vmcee
	GbjgKbfrYdZvy6bH7pXI+dXRnLH+3a41jno/Hc8unLdda/JJjeajDBJb1KoZU7c3P5mic6vw
	QsfERTZNvkc2fbD859j6IfpNoOC/MJNgl09lr/8XV2y3mmYWUMyuWPO7WjRZ+lKmkDdr3ptd
	l49Ou5zYVuUrF2IvyJ9QJNp/4F95iroSS3FGoqEWc1FxIgDA8rDp3QMAAA==
X-CMS-MailID: 20240209142905eucas1p2df56a08287a84a5fa004142100926bb4
X-Msg-Generator: CA
X-RootMTR: 20240209142905eucas1p2df56a08287a84a5fa004142100926bb4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209142905eucas1p2df56a08287a84a5fa004142100926bb4
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240209142905eucas1p2df56a08287a84a5fa004142100926bb4@eucas1p2.samsung.com>

Simplify zero out operation by moving it from write_end() to the
write_begin(). If a large folio does not have any block uptodate when we
first get it, zero it out entirely.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5980d7b94f65..3bddf7a89c18 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -149,6 +149,14 @@ static inline bool sfs_is_fully_uptodate(struct folio =
*folio)
 	return bitmap_full(sfs->state, i_blocks_per_folio(inode, folio));
 }
=20
+static inline bool sfs_is_any_uptodate(struct folio *folio)
+{
+	struct inode *inode =3D folio->mapping->host;
+	struct shmem_folio_state *sfs =3D folio->private;
+
+	return !bitmap_empty(sfs->state, i_blocks_per_folio(inode, folio));
+}
+
 static inline bool sfs_is_block_uptodate(struct shmem_folio_state *sfs,
 					 unsigned int block)
 {
@@ -239,6 +247,15 @@ static void sfs_free(struct folio *folio, bool force)
 	kfree(folio_detach_private(folio));
 }
=20
+static inline bool shmem_is_any_uptodate(struct folio *folio)
+{
+	struct shmem_folio_state *sfs =3D folio->private;
+
+	if (folio_test_large(folio) && sfs)
+		return sfs_is_any_uptodate(folio);
+	return folio_test_uptodate(folio);
+}
+
 static void shmem_set_range_uptodate(struct folio *folio, size_t off,
 				     size_t len)
 {
@@ -2845,6 +2862,9 @@ shmem_write_begin(struct file *file, struct address_s=
pace *mapping,
 	if (ret)
 		return ret;
=20
+	if (!shmem_is_any_uptodate(folio))
+		folio_zero_range(folio, 0, folio_size(folio));
+
 	*pagep =3D folio_file_page(folio, index);
 	if (PageHWPoison(*pagep)) {
 		folio_unlock(folio);
@@ -2867,13 +2887,6 @@ shmem_write_end(struct file *file, struct address_sp=
ace *mapping,
 	if (pos + copied > inode->i_size)
 		i_size_write(inode, pos + copied);
=20
-	if (!folio_test_uptodate(folio)) {
-		if (copied < folio_size(folio)) {
-			size_t from =3D offset_in_folio(folio, pos);
-			folio_zero_segments(folio, 0, from,
-					from + copied, folio_size(folio));
-		}
-	}
 	shmem_set_range_uptodate(folio, 0, folio_size(folio));
 	folio_mark_dirty(folio);
 	folio_unlock(folio);
--=20
2.43.0

