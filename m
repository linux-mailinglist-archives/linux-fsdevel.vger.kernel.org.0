Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522DC7A65E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjISN4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjISN4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:56:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF5194
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:55:56 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230919135554euoutp02df450aadcbb1b650f426e2a304ee88fa~GUVmPSKuz1585715857euoutp02P
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 13:55:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230919135554euoutp02df450aadcbb1b650f426e2a304ee88fa~GUVmPSKuz1585715857euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695131754;
        bh=qf0ZYfltBJHFQkocAMfpwOGkTFM18/mnXm/sqbTG1Hc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RdyrgSlxDQnZ8OoTspAB8yPA4ahyu5un4f+0ntoCmwiJDcdh42jompH23sIq8BVqW
         ed8f1O+Q8HVOUfEHREfoorxQqo4i608JK7GT+n2oHWziyh0TcWPrXrc2pUNg0wsJie
         1zSJwpiEYbsFnS+ZEdeLgKqZPJ2kcKgs6RKMQ9GQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230919135554eucas1p2c289f7b4360774a8577116bad4b22a34~GUVmEZqWP1832118321eucas1p2Q;
        Tue, 19 Sep 2023 13:55:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 44.72.37758.A68A9056; Tue, 19
        Sep 2023 14:55:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135554eucas1p1fefbe420a2381465f3b6b2b7f298433c~GUVli9uA70405804058eucas1p13;
        Tue, 19 Sep 2023 13:55:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230919135554eusmtrp145105151189bdca9c761ae4116051b63~GUVliU81s2584925849eusmtrp1S;
        Tue, 19 Sep 2023 13:55:54 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-ca-6509a86ab4f5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EE.C9.10549.968A9056; Tue, 19
        Sep 2023 14:55:54 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230919135553eusmtip1da98dd855cbc6c425b4b7b0a0fa939af~GUVlXP9Nk1382813828eusmtip1f;
        Tue, 19 Sep 2023 13:55:53 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 19 Sep 2023 14:55:53 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 19 Sep
        2023 14:55:53 +0100
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
Subject: [PATCH v2 5/6] shmem: add file length in shmem_get_folio path
Thread-Topic: [PATCH v2 5/6] shmem: add file length in shmem_get_folio path
Thread-Index: AQHZ6wEANquhpkBXk0KILtjKWHTHrQ==
Date:   Tue, 19 Sep 2023 13:55:52 +0000
Message-ID: <20230919135536.2165715-6-da.gomez@samsung.com>
In-Reply-To: <20230919135536.2165715-1-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87pZKzhTDV4vVbaYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUVw2Kak5mWWp
        Rfp2CVwZ7TdnsRdc1a14tUGjgXGHShcjJ4eEgIlEz4Yr7F2MXBxCAisYJWbPPcUC4XxhlPjy
        4BszhPOZUaK36QYbTMvG1QsYIRLLGSU+vF/FBlf16WU/O0iVkMAZRolT7dEQiZWMEjOO9DOD
        JNgENCX2ndwEtlFEYDarxOHFHYwgCWaBOok1z2YBbefgEBZwk5h2phwkLCLgLdH85yIzSFhE
        QE+i/aYJSJhFQFXi28xbLCA2r4C1xIp3E8GmcArYSNyY2wR2KaOArMSjlb/YIaaLS9x6Mp8J
        4gNBiUWz9zBD2GIS/3Y9hPpMR+Ls9SeMELaBxNal+1ggbCWJPx0Loa7Uk7gxdQobhK0tsWzh
        a2aIGwQlTs58Ag47CYE2LolXtw9BNbtIrLr4kB3CFpZ4dXwLlC0jcXpyD8sERu1ZSO6bhWTH
        LCQ7ZiHZsYCRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgYjv97/jXHYwrXn3UO8TI
        xMF4iFGCg1lJhHemIVuqEG9KYmVValF+fFFpTmrxIUZpDhYlcV5t25PJQgLpiSWp2ampBalF
        MFkmDk6pBqaSuBwH+ds1VpbLp097b7xwtsSnC5bmi3zsHsg9E4vOFpM0De7P8d2z68Az75Kg
        7kAftV81opEXXi6TszC8p/psgp1eUc4uo5wDMc9kLWWkpyz4tOm2amb/6t1XNxexmSrenWof
        vzRFrDrs0+5VtxV3BIgvyfZev8fqwo0Jm3l/NNTX/RRcvPCW6OUZ865GyiZli/tzMPTxnF21
        PkrddvfrV7JH8zYtU7rS7b/Hdcp8wbmq/EH959UOHY3ZOHuiyxS+xTfmzKqs5LpzeuGVkOgH
        drui+s6vWNsb95rXdfWmEjnJePW5QZ2bfLvtPx5tm3bSob2r3e+UgN/L7U+rq6Mm9mme3t0+
        f/bePlnh1M1KLMUZiYZazEXFiQDddZQy2wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsVy+t/xu7pZKzhTDRb+Z7SYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ7TdnsRdc1a14tUGj
        gXGHShcjJ4eEgInExtULGLsYuTiEBJYySty49YEJIiEjsfHLVVYIW1jiz7UuNoiij4wS0x7/
        hOo4wyjxonsxM4SzklHi69NDbCAtbAKaEvtObmIHSYgIzGaVOLy4gxEkwSxQJ7Hm2SyWLkYO
        DmEBN4lpZ8pBwiIC3hLNfy4yg4RFBPQk2m+agIRZBFQlvs28xQJi8wpYS6x4NxFsihCQ/Wrh
        arDrOAVsJG7MbQJbyyggK/Fo5S92iE3iEreezIf6RkBiyZ7zzBC2qMTLx/+gPtOROHv9CSOE
        bSCxdek+FghbSeJPx0Koi/UkbkydwgZha0ssW/iaGeIeQYmTM5+wTGCUnoVk3SwkLbOQtMxC
        0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYHLaduzn5h2M81591DvEyMTBeIhRgoNZ
        SYR3piFbqhBvSmJlVWpRfnxRaU5q8SFGU2AYTWSWEk3OB6bHvJJ4QzMDU0MTM0sDU0szYyVx
        Xs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpobjl9OXWAUyCq+pPcfb+bPlqcDuP+pPdd4c6hHq
        vj7txvJz795/tfncVTDtaKPU3Ne5Mxafme5pHeFT3/Bma/thc8fG8kP3by94GFlyYrnjj5cn
        xT7zRm64Jmfb/2H3FzujrheM604EdUs4H4+z+ffA9HgSb9z6qwv+/tv9TPvqkysTF/VfnaLQ
        rXnqn/rdmTVP2Z0j0g/t4+U0K13/udbY/fW8R/fWPdyyx0nbJlO+/TZblpr/jJSbQkmBKzdF
        MEcyx+au//hoX+tdrZk6vu8YHwh982NOleJ78qEyoz/LvSNFXspDZ3FCVO3PwqUxCcfXex5M
        T15oWOJy9JXOa18fmT2M5dJqW2TiHvd/+qHEUpyRaKjFXFScCAB3yF0I1wMAAA==
X-CMS-MailID: 20230919135554eucas1p1fefbe420a2381465f3b6b2b7f298433c
X-Msg-Generator: CA
X-RootMTR: 20230919135554eucas1p1fefbe420a2381465f3b6b2b7f298433c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230919135554eucas1p1fefbe420a2381465f3b6b2b7f298433c
References: <20230919135536.2165715-1-da.gomez@samsung.com>
        <CGME20230919135554eucas1p1fefbe420a2381465f3b6b2b7f298433c@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To be able to calculate folio order based on the file size when
allocation occurs on the write path. Use of length 0 for non write
paths and PAGE_SIZE for pagecache read and vm fault.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 include/linux/shmem_fs.h |  2 +-
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               | 32 ++++++++++++++++++--------------
 3 files changed, 20 insertions(+), 16 deletions(-)

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
index 66d94207b40c..38aafa0b0845 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -971,7 +971,7 @@ static struct folio *shmem_get_partial_folio(struct ino=
de *inode, pgoff_t index)
 	 * (although in some cases this is just a waste of time).
 	 */
 	folio =3D NULL;
-	shmem_get_folio(inode, index, &folio, SGP_READ);
+	shmem_get_folio(inode, index, &folio, SGP_READ, 0);
 	return folio;
 }
=20
@@ -1948,7 +1948,7 @@ static int shmem_swapin_folio(struct inode *inode, pg=
off_t index,
 static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
 		struct vm_area_struct *vma, struct vm_fault *vmf,
-		vm_fault_t *fault_type)
+		vm_fault_t *fault_type, size_t len)
 {
 	struct address_space *mapping =3D inode->i_mapping;
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
@@ -2162,10 +2162,11 @@ static int shmem_get_folio_gfp(struct inode *inode,=
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
@@ -2248,8 +2249,8 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 		spin_unlock(&inode->i_lock);
 	}
=20
-	err =3D shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
-				  gfp, vma, vmf, &ret);
+	err =3D shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE, gfp,
+				  vma, vmf, &ret, PAGE_SIZE);
 	if (err)
 		return vmf_error(err);
 	if (folio)
@@ -2700,6 +2701,9 @@ shmem_write_begin(struct file *file, struct address_s=
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
@@ -2709,7 +2713,7 @@ shmem_write_begin(struct file *file, struct address_s=
pace *mapping,
 			return -EPERM;
 	}
=20
-	ret =3D shmem_get_folio(inode, index, &folio, SGP_WRITE);
+	ret =3D shmem_get_folio(inode, index, &folio, SGP_WRITE, len);
=20
 	if (ret)
 		return ret;
@@ -2781,7 +2785,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *ioc=
b, struct iov_iter *to)
 				break;
 		}
=20
-		error =3D shmem_get_folio(inode, index, &folio, SGP_READ);
+		error =3D shmem_get_folio(inode, index, &folio, SGP_READ, 0);
 		if (error) {
 			if (error =3D=3D -EINVAL)
 				error =3D 0;
@@ -2958,7 +2962,7 @@ static ssize_t shmem_file_splice_read(struct file *in=
, loff_t *ppos,
 			break;
=20
 		error =3D shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio,
-					SGP_READ);
+					SGP_READ, 0);
 		if (error) {
 			if (error =3D=3D -EINVAL)
 				error =3D 0;
@@ -3145,7 +3149,7 @@ static long shmem_fallocate(struct file *file, int mo=
de, loff_t offset,
 			error =3D -ENOMEM;
 		else
 			error =3D shmem_get_folio(inode, index, &folio,
-						SGP_FALLOC);
+						SGP_FALLOC, 0);
 		if (error) {
 			info->fallocend =3D undo_fallocend;
 			/* Remove the !uptodate folios we added */
@@ -3500,7 +3504,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
 		inode->i_op =3D &shmem_short_symlink_operations;
 	} else {
 		inode_nohighmem(inode);
-		error =3D shmem_get_folio(inode, 0, &folio, SGP_WRITE);
+		error =3D shmem_get_folio(inode, 0, &folio, SGP_WRITE, 0);
 		if (error)
 			goto out_remove_offset;
 		inode->i_mapping->a_ops =3D &shmem_aops;
@@ -3548,7 +3552,7 @@ static const char *shmem_get_link(struct dentry *dent=
ry,
 			return ERR_PTR(-ECHILD);
 		}
 	} else {
-		error =3D shmem_get_folio(inode, 0, &folio, SGP_READ);
+		error =3D shmem_get_folio(inode, 0, &folio, SGP_READ, 0);
 		if (error)
 			return ERR_PTR(error);
 		if (!folio)
@@ -4916,8 +4920,8 @@ struct folio *shmem_read_folio_gfp(struct address_spa=
ce *mapping,
 	int error;
=20
 	BUG_ON(!shmem_mapping(mapping));
-	error =3D shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE,
-				  gfp, NULL, NULL, NULL);
+	error =3D shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE, gfp, NULL,
+				    NULL, NULL, PAGE_SIZE);
 	if (error)
 		return ERR_PTR(error);
=20
--=20
2.39.2
