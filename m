Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5359F11C770
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 09:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfLLITd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 03:19:33 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8662 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfLLITc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:19:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df1f8020004>; Thu, 12 Dec 2019 00:19:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 12 Dec 2019 00:19:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 12 Dec 2019 00:19:22 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Dec
 2019 08:19:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 12 Dec 2019 08:19:20 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df1f8070008>; Thu, 12 Dec 2019 00:19:19 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Paul Mackerras" <paulus@samba.org>, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <bpf@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <kvm@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Subject: [PATCH v10 12/25] IB/{core,hw,umem}: set FOLL_PIN via pin_user_pages*(), fix up ODP
Date:   Thu, 12 Dec 2019 00:19:04 -0800
Message-ID: <20191212081917.1264184-13-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212081917.1264184-1-jhubbard@nvidia.com>
References: <20191212081917.1264184-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576138755; bh=aCmqlvTLwMPCbPaoupMZ4E36vMkyUX1WUItANkWAgkQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=D6AhFX1NsUzhJjRdbM4TZX37KPrvKP3l/EUl9vYvYSWmQyuhQa0boGxSMbUGCdk+u
         W8NuK0wGPI3aG7LJvhM3/tyqnbc5W5HqrePpm6xIIw1MPTMTExCaj9dC/fitugis/S
         /GA8Axa8kCagFYb8v56FgFhAxprW1AMo1YcqztCgNIVkQoyKCyB3NvLVhWEUrYQi3I
         CHJpNvw7uiFFxQtkXlEKFdFw4epGGW9WuZ8DxFaWBE4xKSPk5mQ8d2o2uFYDumcim8
         rrKgzBhBn+aI9AplAjsnMAqLNSEYicQ+96D8d7j15fQ8O/tzH6w9pma3WnD1WEiGRR
         XLwvIdLtUeTgQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert infiniband to use the new pin_user_pages*() calls.

Also, revert earlier changes to Infiniband ODP that had it using
put_user_page(). ODP is "Case 3" in
Documentation/core-api/pin_user_pages.rst, which is to say, normal
get_user_pages() and put_page() is the API to use there.

The new pin_user_pages*() calls replace corresponding get_user_pages*()
calls, and set the FOLL_PIN flag. The FOLL_PIN flag requires that the
caller must return the pages via put_user_page*() calls, but infiniband
was already doing that as part of an earlier commit.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/infiniband/core/umem.c              |  2 +-
 drivers/infiniband/core/umem_odp.c          | 13 ++++++-------
 drivers/infiniband/hw/hfi1/user_pages.c     |  2 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c |  2 +-
 drivers/infiniband/hw/qib/qib_user_pages.c  |  2 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c   |  2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c    |  2 +-
 drivers/infiniband/sw/siw/siw_mem.c         |  2 +-
 8 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 214e87aa609d..55daefaa9b88 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -266,7 +266,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, uns=
igned long addr,
 	sg =3D umem->sg_head.sgl;
=20
 	while (npages) {
-		ret =3D get_user_pages_fast(cur_base,
+		ret =3D pin_user_pages_fast(cur_base,
 					  min_t(unsigned long, npages,
 						PAGE_SIZE /
 						sizeof(struct page *)),
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/u=
mem_odp.c
index e42d44e501fd..abc3bb6578cc 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -308,9 +308,8 @@ EXPORT_SYMBOL(ib_umem_odp_release);
  * The function returns -EFAULT if the DMA mapping operation fails. It ret=
urns
  * -EAGAIN if a concurrent invalidation prevents us from updating the page=
.
  *
- * The page is released via put_user_page even if the operation failed. Fo=
r
- * on-demand pinning, the page is released whenever it isn't stored in the
- * umem.
+ * The page is released via put_page even if the operation failed. For on-=
demand
+ * pinning, the page is released whenever it isn't stored in the umem.
  */
 static int ib_umem_odp_map_dma_single_page(
 		struct ib_umem_odp *umem_odp,
@@ -363,7 +362,7 @@ static int ib_umem_odp_map_dma_single_page(
 	}
=20
 out:
-	put_user_page(page);
+	put_page(page);
 	return ret;
 }
=20
@@ -473,7 +472,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_=
odp, u64 user_virt,
 					ret =3D -EFAULT;
 					break;
 				}
-				put_user_page(local_page_list[j]);
+				put_page(local_page_list[j]);
 				continue;
 			}
=20
@@ -500,8 +499,8 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_=
odp, u64 user_virt,
 			 * ib_umem_odp_map_dma_single_page().
 			 */
 			if (npages - (j + 1) > 0)
-				put_user_pages(&local_page_list[j+1],
-					       npages - (j + 1));
+				release_pages(&local_page_list[j+1],
+					      npages - (j + 1));
 			break;
 		}
 	}
diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/h=
w/hfi1/user_pages.c
index 469acb961fbd..9a94761765c0 100644
--- a/drivers/infiniband/hw/hfi1/user_pages.c
+++ b/drivers/infiniband/hw/hfi1/user_pages.c
@@ -106,7 +106,7 @@ int hfi1_acquire_user_pages(struct mm_struct *mm, unsig=
ned long vaddr, size_t np
 	int ret;
 	unsigned int gup_flags =3D FOLL_LONGTERM | (writable ? FOLL_WRITE : 0);
=20
-	ret =3D get_user_pages_fast(vaddr, npages, gup_flags, pages);
+	ret =3D pin_user_pages_fast(vaddr, npages, gup_flags, pages);
 	if (ret < 0)
 		return ret;
=20
diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniba=
nd/hw/mthca/mthca_memfree.c
index edccfd6e178f..8269ab040c21 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -472,7 +472,7 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mth=
ca_uar *uar,
 		goto out;
 	}
=20
-	ret =3D get_user_pages_fast(uaddr & PAGE_MASK, 1,
+	ret =3D pin_user_pages_fast(uaddr & PAGE_MASK, 1,
 				  FOLL_WRITE | FOLL_LONGTERM, pages);
 	if (ret < 0)
 		goto out;
diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniban=
d/hw/qib/qib_user_pages.c
index 6bf764e41891..7fc4b5f81fcd 100644
--- a/drivers/infiniband/hw/qib/qib_user_pages.c
+++ b/drivers/infiniband/hw/qib/qib_user_pages.c
@@ -108,7 +108,7 @@ int qib_get_user_pages(unsigned long start_page, size_t=
 num_pages,
=20
 	down_read(&current->mm->mmap_sem);
 	for (got =3D 0; got < num_pages; got +=3D ret) {
-		ret =3D get_user_pages(start_page + got * PAGE_SIZE,
+		ret =3D pin_user_pages(start_page + got * PAGE_SIZE,
 				     num_pages - got,
 				     FOLL_LONGTERM | FOLL_WRITE | FOLL_FORCE,
 				     p + got, NULL);
diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband=
/hw/qib/qib_user_sdma.c
index 05190edc2611..1a3cc2957e3a 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -670,7 +670,7 @@ static int qib_user_sdma_pin_pages(const struct qib_dev=
data *dd,
 		else
 			j =3D npages;
=20
-		ret =3D get_user_pages_fast(addr, j, FOLL_LONGTERM, pages);
+		ret =3D pin_user_pages_fast(addr, j, FOLL_LONGTERM, pages);
 		if (ret !=3D j) {
 			i =3D 0;
 			j =3D ret;
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/=
hw/usnic/usnic_uiom.c
index 62e6ffa9ad78..600896727d34 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -141,7 +141,7 @@ static int usnic_uiom_get_pages(unsigned long addr, siz=
e_t size, int writable,
 	ret =3D 0;
=20
 	while (npages) {
-		ret =3D get_user_pages(cur_base,
+		ret =3D pin_user_pages(cur_base,
 				     min_t(unsigned long, npages,
 				     PAGE_SIZE / sizeof(struct page *)),
 				     gup_flags | FOLL_LONGTERM,
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/si=
w/siw_mem.c
index e99983f07663..e53b07dcfed5 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -426,7 +426,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool =
writable)
 		while (nents) {
 			struct page **plist =3D &umem->page_chunk[i].plist[got];
=20
-			rv =3D get_user_pages(first_page_va, nents,
+			rv =3D pin_user_pages(first_page_va, nents,
 					    foll_flags | FOLL_LONGTERM,
 					    plist, NULL);
 			if (rv < 0)
--=20
2.24.0

