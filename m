Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D2C7A1B55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjIOJyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjIOJyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:54:33 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4E3599
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 02:53:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230915095131euoutp02a2560e9aee221bb4a2260c62fd608d0d~FCbFSsw3l1204712047euoutp02W
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 09:51:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230915095131euoutp02a2560e9aee221bb4a2260c62fd608d0d~FCbFSsw3l1204712047euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694771492;
        bh=KBxqvbiqwxbpjqMz9Z69KDs2z1l+Vy83NL/rF/oYkIA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=JOehX4by5wtuX/tE/lkY/wGdcZiXjGvV+uvowvsHd2pzTMwEPs6jAg6SaKbGyeYcE
         iR1US6vyNvUMUR3ILaF+Pv2qAnqLxDu6BYFROC3ouKN35j27QhPrumNlIemiLqUGlG
         wMaSFWpsfDW+px6/1X9wAnkxvPWX6ewHOlmRMtkE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230915095131eucas1p25cc2b04fd359369a4fc473bf907da57c~FCbFAjAMZ1349613496eucas1p21;
        Fri, 15 Sep 2023 09:51:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2B.9A.42423.32924056; Fri, 15
        Sep 2023 10:51:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230915095131eucas1p1010e364cd1c351e5b7379954bd237a3d~FCbEmMxFv0060700607eucas1p1L;
        Fri, 15 Sep 2023 09:51:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230915095131eusmtrp24a417d7970c44623708b2e39cfebe5a0~FCbElcNAu1712217122eusmtrp27;
        Fri, 15 Sep 2023 09:51:31 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-1a-65042923bb09
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 09.3B.10549.22924056; Fri, 15
        Sep 2023 10:51:31 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230915095130eusmtip22dc6e7222c8a07a587bf7bef6f55c865~FCbES6n5V0935009350eusmtip2L;
        Fri, 15 Sep 2023 09:51:30 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Fri, 15 Sep 2023 10:51:30 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 15 Sep
        2023 10:51:30 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH 5/6] shmem: add file length in shmem_get_folio path
Thread-Topic: [PATCH 5/6] shmem: add file length in shmem_get_folio path
Thread-Index: AQHZ57ozxEpCdFcMBk645e2R7dVRyg==
Date:   Fri, 15 Sep 2023 09:51:29 +0000
Message-ID: <20230915095042.1320180-6-da.gomez@samsung.com>
In-Reply-To: <20230915095042.1320180-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVBMYRTG57179+7tjtW1Wr2EMduUsZul4Y+LUMNwfczEjDEYg2tdWX1g
        txX5KoNRI5K+7G6lsJS0WqXUrpJRtpSy+RhGwkY0JopY1abtLtN/v+c553nPOTMvzhNZ+ZNw
        ZVQ0q4piIiQYgd6pdTyZ6TsDZWdfbJ5G6Y2FGHXjzTmMstnHUh09Z1HK8kpGmS1WlLJV6DGq
        rXCIT1UMlAuol8kdgDL87BZQlcV5GNX/W48FC2ldXAtKXzJp6NvXpbStUUObChIw2tSTIqAf
        ZfajdK9p6hp8ExG0g41Q7mdVsxZtI3ZlJBXx9g7KDsTbT4A4cNw3EXjgkJwLu1vf8BIBgYvI
        6wDe7/uMceIHgI76QT4negF8m6Xn/4v0vuhyR64BaG06I/jf1Vic484/HhYJ39wiH8BPueWI
        K4+RM+A9q2kk4kXq+PDB5dPAVeCRR2HhRy3q4vHkEphScnY4jQ830bAqc7nL9iLlsKzAKHDZ
        KOkHDT9GnhSSC2BNqmPE9iCDYPfvGJcNyCnwff4fAfe4N3xlz0G4C8bBPJ2Zx/EE6Kx4h3Ec
        ABtf2AHHs2Hp1XsoxxI4cDrXvaQcvkxLxTiWQUNuF49bYRy0XrSjrqsgeZyAdzN/ucNLYV73
        MzePh1/qSgQcT4ZDd3OQZCDTjtpPO2qGdtQM7agZlwBaALxZjToyjFUHRrExcjUTqdZEhckV
        eyJNYPi3NTjrespB1pfv8hqA4KAGQJwn8RJiCxFWJNzBHIxlVXu2qjQRrLoG+OCoxFsoW2hV
        iMgwJpoNZ9m9rOpfFcE9JsUhK7dryC3ialyhxNsQRdPPYKd/h7aorME49CF0IHvIGP66euOy
        suaT0YPmMdrn55etXr8vcX5sYEXp4hXPsiMH0/vjfGKng6SHU32fWqib6g1X5lnSfedY/Xys
        CUR13fwLy8VMy1pxUTnSmXCmPS2pwH+sZ/FrhcwAvu9s77xhCVGKG4sJc58ouf55iH/rw8+O
        0KuGBkXKxPO3bYc/FB3p2yCa29r2GL922C94XWjnqSOborX2eU31WQH+PTG7zZudtWXiVf0+
        5xaFfxRImSCdSLx5fyWTd0i+0fZVmn+rUh9S5Yl8StNVEY4BY8m7Y/VrbkrbM7zi47OdhLxW
        SXhKUPUuJlDKU6mZv7LdiIfcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsVy+t/xe7rKmiypBlNPMFnMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M6b3rmAv+alc0Pmlh
        bGBsUu5i5OSQEDCR+Hz9NXMXIxeHkMBSRol1e3YwQiRkJDZ+ucoKYQtL/LnWxQZR9JFRovV1
        KwuEc4ZR4tDZZYwQzkpGiX/TPoC1swloSuw7uYkdJCEiMJtV4vDiDrAEs0CdxJpns1hAbGEB
        Z4lJW/qA5nIAFXlI7J/hDhIWEdCT2L5qPTtImEVAVWLZFyaQMK+AtcShKT/BwkJA9qzpXiAm
        p4CNxPsf5SAVjAKyEo9W/mKH2CMucevJfCaI+wUkluw5zwxhi0q8fPwP6i8dibPXn0D9ayCx
        dek+FghbSeJPx0Koe/UkbkydwgZha0ssW/iaGeIaQYmTM5+wTGCUnoVk3SwkLbOQtMxC0rKA
        kWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYGraduzn5h2M81591DvEyMTBeIhRgoNZSYSX
        zZYpVYg3JbGyKrUoP76oNCe1+BCjKTCAJjJLiSbnA5NjXkm8oZmBqaGJmaWBqaWZsZI4r2dB
        R6KQQHpiSWp2ampBahFMHxMHp1QD09psvsWhSvdN5prPPGOTsv76q4qHvxznfltUwXvXb7FG
        ve03ZmbPC5pPPAQPpe9umbpgbonXqegVcy7+51BJ5WSferX7nuSlPuaqfKZTzJ92VP7ddLyt
        uL779Azlw45v1pg+LitjuBTbz3Bx93TFld9ucff8f9h3oDM5MXjFScct3Kxlqicn6+1UujW7
        XFo2+nG+o8cCN5/T7hHHk62qcpmyL0w4XPy5bGGKfezyV3EaG55IObOFO0ZIrvKbvjzw2MTX
        8ydk/T5vtfjZYrXJWm8Tnl6JZD3GKXG5/FLRsrnzzk7Z+MRH0r3gV+i3mStjnO60TzyS21j4
        v3mJxP+vnMmT02c8sTp+3flzua/+XRUlluKMREMt5qLiRABLoVzZ1gMAAA==
X-CMS-MailID: 20230915095131eucas1p1010e364cd1c351e5b7379954bd237a3d
X-Msg-Generator: CA
X-RootMTR: 20230915095131eucas1p1010e364cd1c351e5b7379954bd237a3d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915095131eucas1p1010e364cd1c351e5b7379954bd237a3d
References: <20230915095042.1320180-1-da.gomez@samsung.com>
        <CGME20230915095131eucas1p1010e364cd1c351e5b7379954bd237a3d@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To be able to calculate folio order based on the file size when
allocation occurs on the write path. Use of length 0 for non write
paths.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 include/linux/shmem_fs.h |  2 +-
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               | 28 ++++++++++++++++------------
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6b0c626620f5..b3509e7f1054 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -133,7 +133,7 @@ enum sgp_type {
 };
=20
 int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **fol=
iop,
-		enum sgp_type sgp);
+		enum sgp_type sgp, size_t len);
 struct folio *shmem_read_folio_gfp(struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
=20
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 88433cc25d8a..e5d3feff6de6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1856,7 +1856,7 @@ static int collapse_file(struct mm_struct *mm, unsign=
ed long addr,
 				xas_unlock_irq(&xas);
 				/* swap in or instantiate fallocated page */
 				if (shmem_get_folio(mapping->host, index,
-						&folio, SGP_NOALLOC)) {
+						&folio, SGP_NOALLOC, 0)) {
 					result =3D SCAN_FAIL;
 					goto xa_unlocked;
 				}
diff --git a/mm/shmem.c b/mm/shmem.c
index ee297d8874d3..adff74751065 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -969,7 +969,7 @@ static struct folio *shmem_get_partial_folio(struct ino=
de *inode, pgoff_t index)
 	 * (although in some cases this is just a waste of time).
 	 */
 	folio =3D NULL;
-	shmem_get_folio(inode, index, &folio, SGP_READ);
+	shmem_get_folio(inode, index, &folio, SGP_READ, 0);
 	return folio;
 }
=20
@@ -1950,7 +1950,7 @@ static int shmem_swapin_folio(struct inode *inode, pg=
off_t index,
 static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
 		struct vm_area_struct *vma, struct vm_fault *vmf,
-		vm_fault_t *fault_type)
+		vm_fault_t *fault_type, size_t len)
 {
 	struct address_space *mapping =3D inode->i_mapping;
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
@@ -2164,10 +2164,11 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
 }
=20
 int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **fol=
iop,
-		enum sgp_type sgp)
+		enum sgp_type sgp, size_t len)
 {
 	return shmem_get_folio_gfp(inode, index, foliop, sgp,
-			mapping_gfp_mask(inode->i_mapping), NULL, NULL, NULL);
+			mapping_gfp_mask(inode->i_mapping),
+			NULL, NULL, NULL, len);
 }
=20
 /*
@@ -2251,7 +2252,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	}
=20
 	err =3D shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
-				  gfp, vma, vmf, &ret);
+				  gfp, vma, vmf, &ret, i_size_read(inode));
 	if (err)
 		return vmf_error(err);
 	if (folio)
@@ -2702,6 +2703,9 @@ shmem_write_begin(struct file *file, struct address_s=
pace *mapping,
 	struct folio *folio;
 	int ret =3D 0;
=20
+	if (!mapping_large_folio_support(mapping))
+		len =3D min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
+
 	/* i_rwsem is held by caller */
 	if (unlikely(info->seals & (F_SEAL_GROW |
 				   F_SEAL_WRITE | F_SEAL_FUTURE_WRITE))) {
@@ -2711,7 +2715,7 @@ shmem_write_begin(struct file *file, struct address_s=
pace *mapping,
 			return -EPERM;
 	}
=20
-	ret =3D shmem_get_folio(inode, index, &folio, SGP_WRITE);
+	ret =3D shmem_get_folio(inode, index, &folio, SGP_WRITE, len);
=20
 	if (ret)
 		return ret;
@@ -2783,7 +2787,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *ioc=
b, struct iov_iter *to)
 				break;
 		}
=20
-		error =3D shmem_get_folio(inode, index, &folio, SGP_READ);
+		error =3D shmem_get_folio(inode, index, &folio, SGP_READ, 0);
 		if (error) {
 			if (error =3D=3D -EINVAL)
 				error =3D 0;
@@ -2960,7 +2964,7 @@ static ssize_t shmem_file_splice_read(struct file *in=
, loff_t *ppos,
 			break;
=20
 		error =3D shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio,
-					SGP_READ);
+					SGP_READ, 0);
 		if (error) {
 			if (error =3D=3D -EINVAL)
 				error =3D 0;
@@ -3147,7 +3151,7 @@ static long shmem_fallocate(struct file *file, int mo=
de, loff_t offset,
 			error =3D -ENOMEM;
 		else
 			error =3D shmem_get_folio(inode, index, &folio,
-						SGP_FALLOC);
+						SGP_FALLOC, 0);
 		if (error) {
 			info->fallocend =3D undo_fallocend;
 			/* Remove the !uptodate folios we added */
@@ -3502,7 +3506,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
 		inode->i_op =3D &shmem_short_symlink_operations;
 	} else {
 		inode_nohighmem(inode);
-		error =3D shmem_get_folio(inode, 0, &folio, SGP_WRITE);
+		error =3D shmem_get_folio(inode, 0, &folio, SGP_WRITE, 0);
 		if (error)
 			goto out_remove_offset;
 		inode->i_mapping->a_ops =3D &shmem_aops;
@@ -3550,7 +3554,7 @@ static const char *shmem_get_link(struct dentry *dent=
ry,
 			return ERR_PTR(-ECHILD);
 		}
 	} else {
-		error =3D shmem_get_folio(inode, 0, &folio, SGP_READ);
+		error =3D shmem_get_folio(inode, 0, &folio, SGP_READ, 0);
 		if (error)
 			return ERR_PTR(error);
 		if (!folio)
@@ -4923,7 +4927,7 @@ struct folio *shmem_read_folio_gfp(struct address_spa=
ce *mapping,
=20
 	BUG_ON(!shmem_mapping(mapping));
 	error =3D shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE,
-				  gfp, NULL, NULL, NULL);
+				  gfp, NULL, NULL, NULL, i_size_read(inode));
 	if (error)
 		return ERR_PTR(error);
=20
--=20
2.39.2
