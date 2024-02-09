Return-Path: <linux-fsdevel+bounces-10968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC5F84F750
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78671F228A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FB86BB27;
	Fri,  9 Feb 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tjFYJKAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B569DE7
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488953; cv=none; b=ZLjPxf2nuwSgh+j5vIr/TG08Z7o3CvXrSnG2MA2l23ny/yViSVlI4iyN6OquqlnhVShO9+N5FYbtQLl7m/AzgBiwPS5eUMIuOFaBschqCEG/rMxseo05IV3NI8Ot7CvC8itEcfDfr9AZVWJCEq0RLd7xlYJz8HSQlsXZFzZg4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488953; c=relaxed/simple;
	bh=8CpVZl2bJx8NP6Riuz2Y+yedCiDF5mfz2vl6gbJDV5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=EBe7BGpfHX13qAhW2CiWd4vqco8dKA2m0c0kYoEVFyB+2n7rWBNWGq2VWpxvgSUfUMGpzExMbk2wZRjs7R+buovM6Mg9O1XaxzzQNgdAAHEwSk9JyJbvtqPqp9K7BBSuAxQY+XeBK+OP/IY8F+BW1G6H/0VN7CsY60w4jPkdqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tjFYJKAe; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240209142908euoutp0236351abeb7cdfa6a49df5fae45273ab8~yOCbng7A52144921449euoutp02Z
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240209142908euoutp0236351abeb7cdfa6a49df5fae45273ab8~yOCbng7A52144921449euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707488948;
	bh=a88W1Bbg0jxB2ngLMkFDtFwflxkCFGav4/gOzgelMLM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=tjFYJKAebkiJIwpM50vhlXOLbPn0zREBKWRH/LD5cD5jan0ZiYFAg0HXrgf2WLmT+
	 4J0RCX0UfX9sCyYkie2JirnYLxF74XihbO/qQ6de9Qxb5XZ4yxE+zw+c0hn6j4HAxs
	 ASETTTjD5AfGyHF8E0CxWzVIEW020EKZorD5gM1E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240209142908eucas1p16a6b31632e8d9865f952e959c973c8e5~yOCbPMlkz0281802818eucas1p1s;
	Fri,  9 Feb 2024 14:29:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B6.0E.09539.3B636C56; Fri,  9
	Feb 2024 14:29:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240209142907eucas1p2c61ae37b2a1ca2caeccc48b2169226f2~yOCatdJaJ2253522535eucas1p2p;
	Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240209142907eusmtrp11d733555d1468f5959c30cb5a5a11e05~yOCasoSCp0528405284eusmtrp1H;
	Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-1c-65c636b3da7b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.B3.10702.3B636C56; Fri,  9
	Feb 2024 14:29:07 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142907eusmtip1170d8fecd9e85f89a441b27f26df0489~yOCaisoha0140701407eusmtip1F;
	Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 9 Feb 2024 14:29:06 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 9 Feb
	2024 14:29:06 +0000
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
	Daniel Gomez <da.gomez@samsung.com>
Subject: [RFC PATCH 8/9] shmem: clear uptodate blocks after PUNCH_HOLE
Thread-Topic: [RFC PATCH 8/9] shmem: clear uptodate blocks after PUNCH_HOLE
Thread-Index: AQHaW2RVqhumUoqlFUi8PRO0fiHHFQ==
Date: Fri, 9 Feb 2024 14:29:04 +0000
Message-ID: <20240209142901.126894-9-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7qbzY6lGnhYzFm/hs3i9eFPjBZn
	+36zWZyesIjJ4umnPhaL2dObmSz27D3JYnF51xw2i3tr/rNa3JjwlNHi/N/jrBa/f8xhc+Dx
	2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2jxMzfrN4nFlwhN3j8yY5j01P3jIFcEZx2aSk5mSW
	pRbp2yVwZZz/spat4Kh6RcOu1cwNjB/kuxg5OSQETCS+Ld3NAmILCaxglLjXkdrFyAVkf2GU
	uHp7LROE85lRYs/XJrYuRg6wjt+3MiAaljNKfPuTDlezousYI4RzmlFi2eaNjHBjd01VB7HZ
	BDQl9p3cxA5SJCLwnFGidfdHMIdZ4CazxLWr59lAqoQF3CQ+vt4AdpSIgLfEgcN/oWw9ibtb
	3jKB2CwCKhJrdpxgBDmJV8BK4vkkP5Awp4C1xLxH68HGMArISjxa+YsdxGYWEJe49WQ+E8TP
	ghKLZu9hhrDFJP7tesgGYetInL3+hBHCNpDYunQfC4StKNFx7CYbxBw9iRtTp0DZ2hLLFr4G
	m8MLNPPkzCcsIL9ICDRxSTyf1c0O0ewisbN3ItQyYYlXx7dAxWUkTk/uYZnAqD0LyX2zkOyY
	hWTHLCQ7FjCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMbaf/Hf+0g3Huq496hxiZ
	OBgPMUpwMCuJ8IYsOZIqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1OzW1ILUI
	JsvEwSnVwFTMosD6fcXKB0qMJq97jYyXtCwWZ0iznmP0Qu/bH+3IPXGqqx2kdzQUzNB98UZE
	6R7vhUX/5nE0O7rvN/ovr9msH7NsRkrzDVmDth9d7/9e4VeR7pDvlfd++TRIddPBGfN9sjK5
	XgpY/yt4/KFJcbfJA9VO9y3X/V8vt522Wjj2OZ9qY5bLtHbGE2uVwvznH3wYwfnLOY+3ZFfN
	hpV7GfcEfqn/2hHNr9w/T+f4ok/3da1PTbwS3fI76fKV5PBtxw071ay/P4p+7eYh837ere8P
	Fqn/Vrr6uXGFhGbb44vXC+edWNrw+umB5R088RW3j3x2b2qZ/mKOyjzdZeYn2Dy33ObO2ntS
	Qv7jrsOP2DmUWIozEg21mIuKEwFdoFWY3AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsVy+t/xu7qbzY6lGtyfJ2UxZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGaVnU5Rf
	WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcf7LWraCo+oV
	DbtWMzcwfpDvYuTgkBAwkfh9K6OLkYtDSGApo8TJ+X/Yuhg5geIyEhu/XGWFsIUl/lzrAosL
	CXxklHj6owTCPs0o8WRuEETzCkaJYx+6wYrYBDQl9p3cxA6SEBF4yigx/fchFpAEs8BNZokv
	b8RAbGEBN4mPrzeAxUUEvCUOHP4LZetJ3N3ylgnEZhFQkViz4wQjyKW8AlYSzyf5QSy2kpi2
	/TTYLk4Ba4l5j9aD2YwCshKPVv5ih1glLnHryXwmiAcEJJbsOc8MYYtKvHz8D+oxHYmz158w
	QtgGEluX7mOBsBUlOo7dZIOYoydxY+oUKFtbYtnC12BzeAUEJU7OfMIygVF6FpJ1s5C0zELS
	MgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBCWrbsZ9bdjCufPVR7xAjEwfjIUYJ
	DmYlEd6QJUdShXhTEiurUovy44tKc1KLDzGaAoNoIrOUaHI+MEXmlcQbmhmYGpqYWRqYWpoZ
	K4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwaQVlVb6a+1XoycnNbsv8ipIy9Kwc/F2+Xuuv
	2PbTb46RUtKNvelfIuf9P2mbYep98O66x1wVb+42sGg0380ueqExp/L/dR42+xNaz48p7inV
	rjU0MLt1Y/lXo54k01bdrNOTPVn5d7vULH2iueFYvY3kpllct1bnGc5Yy3/Pr/J+a0q0UmZN
	mVlup7lcl+bDGX6Mu51lGPmWzwyNjSirMAwJCbnx0bQkqnfFhojaG1m6713P9mlG+zd4/NXg
	/6N2041D88lc9zundxQ+D/WztCxycZp0foKrkvoNTocNx7fWHliclC0pk2rrKpyeISS57mXR
	iX0xRy7dUrsq0Cq02mSuejtbv6tLf++laUosxRmJhlrMRcWJABo8BnvZAwAA
X-CMS-MailID: 20240209142907eucas1p2c61ae37b2a1ca2caeccc48b2169226f2
X-Msg-Generator: CA
X-RootMTR: 20240209142907eucas1p2c61ae37b2a1ca2caeccc48b2169226f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209142907eucas1p2c61ae37b2a1ca2caeccc48b2169226f2
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240209142907eucas1p2c61ae37b2a1ca2caeccc48b2169226f2@eucas1p2.samsung.com>

In the fallocate path with PUNCH_HOLE mode flag enabled, clear the
uptodate flag for those blocks covered by the punch. Skip all partial
blocks as they may still contain data.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2d2eeb40f19b..2157a87b2e4b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -209,6 +209,28 @@ static void sfs_set_range_uptodate(struct folio *folio=
,
 	spin_unlock_irqrestore(&sfs->state_lock, flags);
 }
=20
+static void sfs_clear_range_uptodate(struct folio *folio,
+				     struct shmem_folio_state *sfs, size_t off,
+				     size_t len)
+{
+	struct inode *inode =3D folio->mapping->host;
+	unsigned int first_blk, last_blk;
+	unsigned long flags;
+
+	first_blk =3D DIV_ROUND_UP_ULL(off, 1 << inode->i_blkbits);
+	last_blk =3D DIV_ROUND_DOWN_ULL(off + len, 1 << inode->i_blkbits) - 1;
+	if (last_blk =3D=3D UINT_MAX)
+		return;
+
+	if (first_blk > last_blk)
+		return;
+
+	spin_lock_irqsave(&sfs->state_lock, flags);
+	bitmap_clear(sfs->state, first_blk, last_blk - first_blk + 1);
+	folio_clear_uptodate(folio);
+	spin_unlock_irqrestore(&sfs->state_lock, flags);
+}
+
 static struct shmem_folio_state *sfs_alloc(struct inode *inode,
 					   struct folio *folio)
 {
@@ -276,6 +298,19 @@ static void shmem_set_range_uptodate(struct folio *fol=
io, size_t off,
 	else
 		folio_mark_uptodate(folio);
 }
+
+static void shmem_clear_range_uptodate(struct folio *folio, size_t off,
+				     size_t len)
+{
+	struct shmem_folio_state *sfs =3D folio->private;
+
+	if (sfs)
+		sfs_clear_range_uptodate(folio, sfs, off, len);
+	else
+		folio_clear_uptodate(folio);
+
+}
+
 #ifdef CONFIG_TMPFS
 static unsigned long shmem_default_max_blocks(void)
 {
@@ -1103,12 +1138,33 @@ static struct folio *shmem_get_partial_folio(struct=
 inode *inode, pgoff_t index)
 	return folio;
 }
=20
+static void shmem_clear(struct folio *folio, loff_t start, loff_t end, int=
 mode)
+{
+	loff_t pos =3D folio_pos(folio);
+	unsigned int offset, length;
+
+	if (!(mode & FALLOC_FL_PUNCH_HOLE) || !(folio_test_large(folio)))
+		return;
+
+	if (pos < start)
+		offset =3D start - pos;
+	else
+		offset =3D 0;
+	length =3D folio_size(folio);
+	if (pos + length <=3D (u64)end)
+		length =3D length - offset;
+	else
+		length =3D end + 1 - pos - offset;
+
+	shmem_clear_range_uptodate(folio, offset, length);
+}
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocat=
e.
  */
 static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t le=
nd,
-								 bool unfalloc)
+			     bool unfalloc, int mode)
 {
 	struct address_space *mapping =3D inode->i_mapping;
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
@@ -1166,6 +1222,7 @@ static void shmem_undo_range(struct inode *inode, lof=
f_t lstart, loff_t lend,
 	if (folio) {
 		same_folio =3D lend < folio_pos(folio) + folio_size(folio);
 		folio_mark_dirty(folio);
+		shmem_clear(folio, lstart, lend, mode);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
 			start =3D folio_next_index(folio);
 			if (same_folio)
@@ -1255,9 +1312,17 @@ static void shmem_undo_range(struct inode *inode, lo=
ff_t lstart, loff_t lend,
 	shmem_recalc_inode(inode, 0, -nr_swaps_freed);
 }
=20
+static void shmem_truncate_range_mode(struct inode *inode, loff_t lstart,
+				      loff_t lend, int mode)
+{
+	shmem_undo_range(inode, lstart, lend, false, mode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	inode_inc_iversion(inode);
+}
+
 void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 {
-	shmem_undo_range(inode, lstart, lend, false);
+	shmem_undo_range(inode, lstart, lend, false, 0);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	inode_inc_iversion(inode);
 }
@@ -3315,7 +3380,7 @@ static long shmem_fallocate(struct file *file, int mo=
de, loff_t offset,
 		if ((u64)unmap_end > (u64)unmap_start)
 			unmap_mapping_range(mapping, unmap_start,
 					    1 + unmap_end - unmap_start, 0);
-		shmem_truncate_range(inode, offset, offset + len - 1);
+		shmem_truncate_range_mode(inode, offset, offset + len - 1, mode);
 		/* No need to unmap again: hole-punching leaves COWed pages */
=20
 		spin_lock(&inode->i_lock);
@@ -3381,9 +3446,10 @@ static long shmem_fallocate(struct file *file, int m=
ode, loff_t offset,
 			info->fallocend =3D undo_fallocend;
 			/* Remove the !uptodate folios we added */
 			if (index > start) {
-				shmem_undo_range(inode,
-				    (loff_t)start << PAGE_SHIFT,
-				    ((loff_t)index << PAGE_SHIFT) - 1, true);
+				shmem_undo_range(
+					inode, (loff_t)start << PAGE_SHIFT,
+					((loff_t)index << PAGE_SHIFT) - 1, true,
+					0);
 			}
 			goto undone;
 		}
--=20
2.43.0

