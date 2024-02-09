Return-Path: <linux-fsdevel+bounces-10963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEC584F747
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0178FB20F0A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC5769D0C;
	Fri,  9 Feb 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pb7wORK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AA69958
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488949; cv=none; b=G5j94gKnpTjoZh/7uvHtrqwekVa0LjkcxUcruCMjGbNoGRJt7NWYFCjEzFJWz0JQA9QiDwFCudWQT+IwVB3CRuuML9/qar9iOhkdbkdDxuSXk9tPf/3/nklEwzC5K1KbFHStzHS0W3hCOT0hRFKprWq6rGjM0ZZkXbyvK1MIwpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488949; c=relaxed/simple;
	bh=7bf71wmf0z3MtWLhHI9EN/ydOJJr2oHi6LZjYAv3la0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=Ur0t/qPBzStcsy8MDsB99+1Aqiwj+4+xm7eXSxVWzfmu9iES1gOIx9bvPUEA4jK0XH21m1BXsPNyncd+1eVE5jZwnXUpRz00ZARkqwFxmh/AzRYbVzYxowWlayY8FC0URseUEhHk3WV8Rga+wsK+/ZampGsX0FhG6htt6dQp7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Pb7wORK5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240209142905euoutp023e2bf636bda69becae74d2013da5caae~yOCYyIEBi2142421424euoutp02H
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240209142905euoutp023e2bf636bda69becae74d2013da5caae~yOCYyIEBi2142421424euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707488945;
	bh=CVr+BSsSvYqyUxoK+Z2ICaYEZFi6sZ1CmkC1b8DH1ws=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Pb7wORK50Qp+0MacIA0fkdKvzFt9bF4rsGSIhRPNRlT0NZm2ww6wtDMVP4Pd5chC7
	 I5mWfcqo2MrXuaJZKPqJG5CxmvzRturYToAAG4Q1z+8C9hwqNzrnL7oFcLbjPd0/fC
	 Y8ygeYk3rQ5RfOmWXecirDYjuqC317lWLAdiHFgA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209142905eucas1p2574b31587e71bdc31a2993449e51ba90~yOCYaW4Yr0060200602eucas1p26;
	Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id B9.F5.09814.0B636C56; Fri,  9
	Feb 2024 14:29:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240209142904eucas1p20a388be8e43b756b84b5a586d5a88f18~yOCX8K7xm2346823468eucas1p2R;
	Fri,  9 Feb 2024 14:29:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240209142904eusmtrp22b43289d14a97adda5bf8a1bb0345841~yOCX7eDvn2106521065eusmtrp2p;
	Fri,  9 Feb 2024 14:29:04 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-34-65c636b071cb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.6F.09146.0B636C56; Fri,  9
	Feb 2024 14:29:04 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240209142904eusmtip20cf00b0cf7880a505516226c14ba4db4~yOCXvA7qt0292502925eusmtip2c;
	Fri,  9 Feb 2024 14:29:04 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 9 Feb 2024 14:29:03 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 9 Feb
	2024 14:29:03 +0000
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
Subject: [RFC PATCH 2/9] shmem: add per-block uptodate tracking for
 hugepages
Thread-Topic: [RFC PATCH 2/9] shmem: add per-block uptodate tracking for
	hugepages
Thread-Index: AQHaW2RT4T3ZrPeWjkOR05yD13efEQ==
Date: Fri, 9 Feb 2024 14:29:02 +0000
Message-ID: <20240209142901.126894-3-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87obzI6lGjx/ZW4xZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGcVlk5Ka
	k1mWWqRvl8CV0br+N3vBB+eKC0/nMzUwbjfvYuTgkBAwkfjclNTFyMUhJLCCUaJv7VZ2COcL
	o8SLhtlQzmdGiZ+nrzLDdPStsYaIL2eU2HtuNyNc0ceXv5ghnNOMErs/vmHpYuSEGHzojgiI
	zSagKbHv5CawsSICzxklWnd/BHOYBW4zS8xpn8UIUiUs4C8xf8UlJhBbRCBEovP2eShbT2Lf
	z3XsIDaLgIrEgqX3mUFsXgEriedr74LZnALWEvMerWcDsRkFZCUerfwFVs8sIC5x68l8sDkS
	AoISi2bvYYawxST+7XrIBmHrSJy9/oQRwjaQ2Lp0HwuErSjRcewmG8QcPYkbU6dA2doSyxa+
	hrpBUOLkzCcsIM9ICPRxSVx7eowNEmAuEuc6OCDmCEu8Or6FHcKWkfi/cz7TBEbtWUjOm4Vk
	xSwkK2YhWbGAkWUVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYII7/e/4lx2My1991DvE
	yMTBeIhRgoNZSYQ3ZMmRVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWp
	RTBZJg5OqQamlZrvfb687S/omfZp+oWYROanaW4f3BVuP62cNpHzc9QjxV0qB+LepUo18JQE
	yS8Q3eziu+n30Q9l7tGSNhmisXZpqicXTl+zqSz0+UdGkR3cTvP2rsnbyJ8RprqtfnWEXzbr
	WxWF9ONHZvbPEVk0m2vP5I5L/RduC/xZXMrFyGX8Yft79tN+3/b/09p55GLj8ob4GU7rmbqO
	1X8WfNT2vfv8xW+v334J/l+xRuRrrtu291K9d5g+nFnBfP3/7RKXe+kRMUpqTFGt4Ztsshav
	rYt5dXpb7nm7w4uOrgx692p/zZb+sq4lLw4m2GfeuPvihHVddmtx6h271RUqb6QvfHblvpRS
	LbDDLEu8JOztGSWW4oxEQy3mouJEAL2AJszfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsVy+t/xe7obzI6lGmy+LmExZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGaVnU5Rf
	WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0br+N3vBB+eK
	C0/nMzUwbjfvYuTgkBAwkehbY93FyMkhJLCUUeLqfH4QW0JARmLjl6usELawxJ9rXWxdjFxA
	NR8ZJWZObWSEcE4zSpzecpkVwlnBKPF/9wRmkBY2AU2JfSc3sYMkRASeMkpM/32IBcRhFrjN
	LDGnfRYjSJWwgK/EtAn3wGwRgRCJ5TOvsELYehL7fq5jB7FZBFQkFiy9DzaVV8BK4vnau8wQ
	x1pJTNt+mg3E5hSwlpj3aD2YzSggK/Fo5S+wXmYBcYlbT+YzQTwhILFkz3lmCFtU4uXjf1DP
	6Uicvf6EEcI2kNi6dB8LhK0o0XHsJhvEHD2JG1OnQNnaEssWvoa6R1Di5MwnLBMYpWchWTcL
	ScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJEZimth37uXkH47xXH/UOMTJx
	MB5ilOBgVhLhDVlyJFWINyWxsiq1KD++qDQntfgQoykwjCYyS4km5wMTZV5JvKGZgamhiZml
	gamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA9PO7ucnjn7xaNVfPk3bZgd/r0FMobJT
	7+XuhjneZ1ZdUTZ4WvTtzaL0FTtE2i6eEFu2tEPxQlXulwWLPl19evPln+2RK+oCIkLlDK+x
	M64uSAj9V/7n4vyqaE5elaQik6u2Cjx7k+f5NkT9/Lbu0LH+2U0OXLcn/OBfxXzCptRTiTl9
	27ybP6K76wwtX6v13L1kKR4kdPqOyMHvct+8nl9caPH1rZfoYZ+KpeI8yQ8nJCxYeEhg0SXW
	jltWfVHhGf5LiyUst04WnrS2dqq8iNWh/A9Pnr2XO62jfcTUrs/UOZ/pwmnZmBszm07ZRTwJ
	dtOR49/2+mliieDyU5c9l0ZOeqym/8ndMv/S3Dzu1FtKLMUZiYZazEXFiQBXdoA03AMAAA==
X-CMS-MailID: 20240209142904eucas1p20a388be8e43b756b84b5a586d5a88f18
X-Msg-Generator: CA
X-RootMTR: 20240209142904eucas1p20a388be8e43b756b84b5a586d5a88f18
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209142904eucas1p20a388be8e43b756b84b5a586d5a88f18
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240209142904eucas1p20a388be8e43b756b84b5a586d5a88f18@eucas1p2.samsung.com>

Based on iomap per-block dirty and uptodate state track, add support
for shmem_folio_state struct to track the uptodate state per-block for
large folios (hugepages).

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 189 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d7c84ff62186..5980d7b94f65 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -131,6 +131,124 @@ struct shmem_options {
 #define SHMEM_SEEN_QUOTA 32
 };
=20
+/*
+ * Structure allocated for each folio to track per-block uptodate state.
+ *
+ * Like buffered-io iomap_folio_state struct but only for uptodate.
+ */
+struct shmem_folio_state {
+	spinlock_t state_lock;
+	unsigned long state[];
+};
+
+static inline bool sfs_is_fully_uptodate(struct folio *folio)
+{
+	struct inode *inode =3D folio->mapping->host;
+	struct shmem_folio_state *sfs =3D folio->private;
+
+	return bitmap_full(sfs->state, i_blocks_per_folio(inode, folio));
+}
+
+static inline bool sfs_is_block_uptodate(struct shmem_folio_state *sfs,
+					 unsigned int block)
+{
+	return test_bit(block, sfs->state);
+}
+
+/**
+ * sfs_get_last_block_uptodate - find the index of the last uptodate block
+ * within a specified range
+ * @folio: The folio
+ * @first: The starting block of the range to search
+ * @last: The ending block of the range to search
+ *
+ * Returns the index of the last uptodate block within the specified range=
. If
+ * a non uptodate block is found at the start, it returns UINT_MAX.
+ */
+static unsigned int sfs_get_last_block_uptodate(struct folio *folio,
+						unsigned int first,
+						unsigned int last)
+{
+	struct inode *inode =3D folio->mapping->host;
+	struct shmem_folio_state *sfs =3D folio->private;
+	unsigned int nr_blocks =3D i_blocks_per_folio(inode, folio);
+	unsigned int aux =3D find_next_zero_bit(sfs->state, nr_blocks, first);
+
+	/*
+	 * Exceed the range of possible last block and return UINT_MAX if a non
+	 * uptodate block is found at the beginning of the scan.
+	 */
+	if (aux =3D=3D first)
+		return UINT_MAX;
+
+	return min_t(unsigned int, aux - 1, last);
+}
+
+static void sfs_set_range_uptodate(struct folio *folio,
+				   struct shmem_folio_state *sfs, size_t off,
+				   size_t len)
+{
+	struct inode *inode =3D folio->mapping->host;
+	unsigned int first_blk =3D off >> inode->i_blkbits;
+	unsigned int last_blk =3D (off + len - 1) >> inode->i_blkbits;
+	unsigned int nr_blks =3D last_blk - first_blk + 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sfs->state_lock, flags);
+	bitmap_set(sfs->state, first_blk, nr_blks);
+	if (sfs_is_fully_uptodate(folio))
+		folio_mark_uptodate(folio);
+	spin_unlock_irqrestore(&sfs->state_lock, flags);
+}
+
+static struct shmem_folio_state *sfs_alloc(struct inode *inode,
+					   struct folio *folio)
+{
+	struct shmem_folio_state *sfs =3D folio->private;
+	unsigned int nr_blocks =3D i_blocks_per_folio(inode, folio);
+	gfp_t gfp =3D GFP_KERNEL;
+
+	if (sfs || nr_blocks <=3D 1)
+		return sfs;
+
+	/*
+	 * sfs->state tracks uptodate flag when the block size is smaller
+	 * than the folio size.
+	 */
+	sfs =3D kzalloc(struct_size(sfs, state, BITS_TO_LONGS(nr_blocks)), gfp);
+	if (!sfs)
+		return sfs;
+
+	spin_lock_init(&sfs->state_lock);
+	if (folio_test_uptodate(folio))
+		bitmap_set(sfs->state, 0, nr_blocks);
+	folio_attach_private(folio, sfs);
+
+	return sfs;
+}
+
+static void sfs_free(struct folio *folio, bool force)
+{
+	if (!folio_test_private(folio))
+		return;
+
+	if (!force)
+		WARN_ON_ONCE(sfs_is_fully_uptodate(folio) !=3D
+			     folio_test_uptodate(folio));
+
+	kfree(folio_detach_private(folio));
+}
+
+static void shmem_set_range_uptodate(struct folio *folio, size_t off,
+				     size_t len)
+{
+	struct shmem_folio_state *sfs =3D folio->private;
+
+	if (sfs)
+		sfs_set_range_uptodate(folio, sfs, off, len);
+	else
+		folio_mark_uptodate(folio);
+}
 #ifdef CONFIG_TMPFS
 static unsigned long shmem_default_max_blocks(void)
 {
@@ -1487,7 +1605,7 @@ static int shmem_writepage(struct page *page, struct =
writeback_control *wbc)
 		}
 		folio_zero_range(folio, 0, folio_size(folio));
 		flush_dcache_folio(folio);
-		folio_mark_uptodate(folio);
+		shmem_set_range_uptodate(folio, 0, folio_size(folio));
 	}
=20
 	swap =3D folio_alloc_swap(folio);
@@ -1769,13 +1887,16 @@ static int shmem_replace_folio(struct folio **folio=
p, gfp_t gfp,
 	if (!new)
 		return -ENOMEM;
=20
+	if (folio_get_private(old))
+		folio_attach_private(new, folio_detach_private(old));
+
 	folio_get(new);
 	folio_copy(new, old);
 	flush_dcache_folio(new);
=20
 	__folio_set_locked(new);
 	__folio_set_swapbacked(new);
-	folio_mark_uptodate(new);
+	shmem_set_range_uptodate(new, 0, folio_size(new));
 	new->swap =3D entry;
 	folio_set_swapcache(new);
=20
@@ -2060,6 +2181,12 @@ static int shmem_get_folio_gfp(struct inode *inode, =
pgoff_t index,
=20
 alloced:
 	alloced =3D true;
+
+	if (!sfs_alloc(inode, folio) && folio_test_large(folio)) {
+		error =3D -ENOMEM;
+		goto unlock;
+	}
+
 	if (folio_test_pmd_mappable(folio) &&
 	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
 					folio_next_index(folio) - 1) {
@@ -2101,7 +2228,7 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 		for (i =3D 0; i < n; i++)
 			clear_highpage(folio_page(folio, i));
 		flush_dcache_folio(folio);
-		folio_mark_uptodate(folio);
+		shmem_set_range_uptodate(folio, 0, folio_size(folio));
 	}
=20
 	/* Perhaps the file has been truncated since we checked */
@@ -2746,8 +2873,8 @@ shmem_write_end(struct file *file, struct address_spa=
ce *mapping,
 			folio_zero_segments(folio, 0, from,
 					from + copied, folio_size(folio));
 		}
-		folio_mark_uptodate(folio);
 	}
+	shmem_set_range_uptodate(folio, 0, folio_size(folio));
 	folio_mark_dirty(folio);
 	folio_unlock(folio);
 	folio_put(folio);
@@ -2755,6 +2882,59 @@ shmem_write_end(struct file *file, struct address_sp=
ace *mapping,
 	return copied;
 }
=20
+static void shmem_invalidate_folio(struct folio *folio, size_t offset,
+				   size_t len)
+{
+	/*
+	 * If we're invalidating the entire folio, clear the dirty state
+	 * from it and release it to avoid unnecessary buildup of the LRU.
+	 */
+	if (offset =3D=3D 0 && len =3D=3D folio_size(folio)) {
+		WARN_ON_ONCE(folio_test_writeback(folio));
+		folio_cancel_dirty(folio);
+		sfs_free(folio, true);
+	}
+}
+
+static bool shmem_release_folio(struct folio *folio, gfp_t gfp_flags)
+{
+	if (folio_test_dirty(folio) && !sfs_is_fully_uptodate(folio))
+		return false;
+
+	sfs_free(folio, false);
+	return true;
+}
+
+/*
+ * shmem_is_partially_uptodate checks whether blocks within a folio are
+ * uptodate or not.
+ *
+ * Returns true if all blocks which correspond to the specified part
+ * of the folio are uptodate.
+ */
+static bool shmem_is_partially_uptodate(struct folio *folio, size_t from,
+					size_t count)
+{
+	struct shmem_folio_state *sfs =3D folio->private;
+	struct inode *inode =3D folio->mapping->host;
+	unsigned int first, last;
+
+	if (!sfs)
+		return false;
+
+	/* Caller's range may extend past the end of this folio */
+	count =3D min(folio_size(folio) - from, count);
+
+	/* First and last blocks in range within folio */
+	first =3D from >> inode->i_blkbits;
+	last =3D (from + count - 1) >> inode->i_blkbits;
+
+	if (sfs_get_last_block_uptodate(folio, first, last) !=3D last)
+		return false;
+
+	return true;
+}
+
 static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *t=
o)
 {
 	struct file *file =3D iocb->ki_filp;
@@ -3506,7 +3686,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
 		inode->i_mapping->a_ops =3D &shmem_aops;
 		inode->i_op =3D &shmem_symlink_inode_operations;
 		memcpy(folio_address(folio), symname, len);
-		folio_mark_uptodate(folio);
+		shmem_set_range_uptodate(folio, 0, folio_size(folio));
 		folio_mark_dirty(folio);
 		folio_unlock(folio);
 		folio_put(folio);
@@ -4476,7 +4656,10 @@ const struct address_space_operations shmem_aops =3D=
 {
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	=3D migrate_folio,
 #endif
-	.error_remove_folio =3D shmem_error_remove_folio,
+	.error_remove_folio    =3D shmem_error_remove_folio,
+	.invalidate_folio      =3D shmem_invalidate_folio,
+	.release_folio         =3D shmem_release_folio,
+	.is_partially_uptodate =3D shmem_is_partially_uptodate,
 };
 EXPORT_SYMBOL(shmem_aops);
=20
--=20
2.43.0

