Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790D635202C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 21:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhDATym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 15:54:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34996 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhDATym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:54:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131Ja0DF117344;
        Thu, 1 Apr 2021 19:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Bu04mF2Iams8WUOFDmdgFzU6CR1qrKFZ75icqH6dpDU=;
 b=HKjwp2+aiNZ73xOPttL84CqEZhhtiuw3830Nb2m/Cm8wp9bJG//7dQHeaG+cPA8mS+pc
 aBwdhLkNpc5XBy2CWZO8whUsleWARAP8FeUmJlcc3f/RiRGj93BC56qV8Nbq5F5KG4Lh
 9Mxy30uYMJKuQEnF+t70/wk4m28DskW9odvLO6ChuYmoevd5/pnB9kdGSOeoMNfC5yZw
 MJyuN3JOmqTtFfMT2nZSlD64RiTTAXVsV+R7md2tITVLIU77e+jVl2MiClE5IwkQl8cA
 dUjmyI0xl52/jr7rrdBgJxTU8idly7gZ8DUDXeMJ0CX8E1rXhy9Qaeyui+v4S6lTZVMv vQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37n30say7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 19:54:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131JZwla038925;
        Thu, 1 Apr 2021 19:54:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 37n2asq9bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 19:54:21 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 131JsGU1030268;
        Thu, 1 Apr 2021 19:54:16 GMT
Received: from [10.175.199.243] (/10.175.199.243)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 12:54:15 -0700
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
From:   Joao Martins <joao.m.martins@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
 <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
 <CAPcyv4jidaz=33oWFMB_aBPtYDLe-AA_NP-k_pfGADVt=w5Vng@mail.gmail.com>
 <1c87dc74-335e-c9e2-2ae8-1ec7e0cb44c4@oracle.com>
Message-ID: <a8c41028-c7f5-9b93-4721-b8ddcf2427da@oracle.com>
Date:   Thu, 1 Apr 2021 20:54:10 +0100
MIME-Version: 1.0
In-Reply-To: <1c87dc74-335e-c9e2-2ae8-1ec7e0cb44c4@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010126
X-Proofpoint-GUID: bonOZ_DlGrElDbPILWMqcREQYzPYK6VB
X-Proofpoint-ORIG-GUID: bonOZ_DlGrElDbPILWMqcREQYzPYK6VB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/24/21 7:00 PM, Joao Martins wrote:
> On 3/24/21 5:45 PM, Dan Williams wrote:
>> On Thu, Mar 18, 2021 at 3:02 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>> On 3/18/21 4:08 AM, Dan Williams wrote:
>>>> Now that device-dax and filesystem-dax are guaranteed to unmap all user
>>>> mappings of devmap / DAX pages before tearing down the 'struct page'
>>>> array, get_user_pages_fast() can rely on its traditional synchronization
>>>> method "validate_pte(); get_page(); revalidate_pte()" to catch races with
>>>> device shutdown. Specifically the unmap guarantee ensures that gup-fast
>>>> either succeeds in taking a page reference (lock-less), or it detects a
>>>> need to fall back to the slow path where the device presence can be
>>>> revalidated with locks held.
>>>
>>> [...]
>>>
>>> So for allowing FOLL_LONGTERM[0] would it be OK if we used page->pgmap after
>>> try_grab_page() for checking pgmap type to see if we are in a device-dax
>>> longterm pin?
>>
>> So, there is an effort to add a new pte bit p{m,u}d_special to disable
>> gup-fast for huge pages [1]. I'd like to investigate whether we could
>> use devmap + special as an encoding for "no longterm" and never
>> consult the pgmap in the gup-fast path.
>>
>> [1]: https://lore.kernel.org/linux-mm/a1fa7fa2-914b-366d-9902-e5b784e8428c@shipmail.org/
>>
> 
> Oh, nice! That would be ideal indeed, as we would skip the pgmap lookup enterily.
> 
> I suppose device-dax would use pfn_t PFN_MAP while fs-dax memory device would set PFN_MAP
> | PFN_DEV (provided vmf_insert_pfn_{pmd,pud} calls mkspecial on PFN_DEV).
> 
> I haven't been following that thread, but for PMD/PUD special in vmf_* these might be useful:
> 
> https://lore.kernel.org/linux-mm/20200110190313.17144-2-joao.m.martins@oracle.com/
> https://lore.kernel.org/linux-mm/20200110190313.17144-4-joao.m.martins@oracle.com/
> 

On a second thought, maybe it doesn't need to be that complicated for {fs,dev}dax if the
added special bit is just a subcase of devmap pte/pmd/puds. See below scsissors mark as a
rough estimation on the changes (nothing formal/proper as it isn't properly splitted).
Running gup_test with devdax/fsdax FOLL_LONGTERM and without does the intended. (gup_test
-m 16384 -r 10 -a -S -n 512 -w -f <file> [-F 0x10000]).

Unless this is about using special PMD/PUD bits without page structs (thus without devmap
bits) as in the previous two links.

-- >8 --

Subject: mm/gup, nvdimm: allow FOLL_LONGTERM for device-dax gup-fast

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 47027796c2f9..8b5d68d89cde 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -439,11 +439,16 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)

 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
+#define pmd_special(pmd)	pte_special(pmd_pte(pmd))
 #endif
 static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 {
 	return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_DEVMAP)));
 }
+static inline pmd_t pmd_mkspecial(pmd_t pmd)
+{
+	return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_SPECIAL)));
+}

 #define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
 #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b1099f2d9800..45449ee86d4f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -259,13 +259,13 @@ static inline int pmd_large(pmd_t pte)
 /* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_large */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP|_PAGE_SPECIAL)) == _PAGE_PSE;
 }

 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline int pud_trans_huge(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP|_PAGE_SPECIAL)) == _PAGE_PSE;
 }
 #endif

@@ -297,6 +297,19 @@ static inline int pgd_devmap(pgd_t pgd)
 {
 	return 0;
 }
+
+static inline bool pmd_special(pmd_t pmd)
+{
+	return !!(pmd_flags(pmd) & _PAGE_SPECIAL);
+}
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static inline bool pud_special(pud_t pud)
+{
+	return !!(pud_flags(pud) & _PAGE_SPECIAL);
+}
+#endif
+
 #endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */

@@ -452,6 +465,11 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_DEVMAP);
 }

+static inline pmd_t pmd_mkspecial(pmd_t pmd)
+{
+	return pmd_set_flags(pmd, _PAGE_SPECIAL);
+}
+
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_PSE);
@@ -511,6 +529,11 @@ static inline pud_t pud_mkhuge(pud_t pud)
 	return pud_set_flags(pud, _PAGE_PSE);
 }

+static inline pud_t pud_mkspecial(pud_t pud)
+{
+	return pud_set_flags(pud, _PAGE_SPECIAL);
+}
+
 static inline pud_t pud_mkyoung(pud_t pud)
 {
 	return pud_set_flags(pud, _PAGE_ACCESSED);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 16760b237229..156ceae33164 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -435,7 +435,7 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
 		pmem->pfn_pad = resource_size(res) -
 			range_len(&pmem->pgmap.range);
-		pmem->pfn_flags |= PFN_MAP;
+		pmem->pfn_flags |= PFN_MAP | PFN_SPECIAL;
 		bb_range = pmem->pgmap.range;
 		bb_range.start += pmem->data_offset;
 	} else if (pmem_should_map_pages(dev)) {
@@ -445,7 +445,7 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
-		pmem->pfn_flags |= PFN_MAP;
+		pmem->pfn_flags |= PFN_MAP | PFN_SPECIAL;
 		bb_range = pmem->pgmap.range;
 	} else {
 		if (devm_add_action_or_reset(dev, pmem_release_queue,
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4ee6f734ba83..873c8e53c85d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -748,7 +748,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev,
pgoff_t pgoff,
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
 		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
-					PFN_DEV | PFN_MAP);
+					PFN_DEV | PFN_MAP | PFN_SPECIAL);
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 7364e5a70228..ad7078e38ef2 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1189,6 +1189,18 @@ static inline int pgd_devmap(pgd_t pgd)
 }
 #endif

+#if !defined(CONFIG_ARCH_HAS_PTE_SPECIAL) || !defined(CONFIG_TRANSPARENT_HUGEPAGE)
+static inline bool pmd_special(pmd_t pmd)
+{
+	return false;
+}
+
+static inline pmd_t pmd_mkspecial(pmd_t pmd)
+{
+	return pmd;
+}
+#endif
+
 #if !defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
 	(defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
 	 !defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
@@ -1196,6 +1208,14 @@ static inline int pud_trans_huge(pud_t pud)
 {
 	return 0;
 }
+static inline bool pud_special(pud_t pud)
+{
+	return false;
+}
+static inline pud_t pud_mkspecial(pud_t pud)
+{
+	return pud;
+}
 #endif

 /* See pmd_none_or_trans_huge_or_clear_bad for discussion. */
diff --git a/mm/gup.c b/mm/gup.c
index b3e647c8b7ee..87aa229a9347 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2086,7 +2086,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned
long end,
 			goto pte_unmap;

 		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
+			if (unlikely(flags & FOLL_LONGTERM) && pte_special(pte))
 				goto pte_unmap;

 			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
@@ -2338,7 +2338,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		return 0;

 	if (pmd_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
+		if (unlikely(flags & FOLL_LONGTERM) && pmd_special(orig))
 			return 0;
 		return __gup_device_huge_pmd(orig, pmdp, addr, end, flags,
 					     pages, nr);
@@ -2372,7 +2372,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		return 0;

 	if (pud_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
+		if (unlikely(flags & FOLL_LONGTERM) && pud_special(orig))
 			return 0;
 		return __gup_device_huge_pud(orig, pudp, addr, end, flags,
 					     pages, nr);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f6f70632fc29..9d5117711919 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -796,8 +796,11 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long
addr,
 	}

 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
-	if (pfn_t_devmap(pfn))
+	if (pfn_t_devmap(pfn)) {
 		entry = pmd_mkdevmap(entry);
+		if (pfn_t_special(pfn))
+			entry = pmd_mkspecial(entry);
+	}
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
 		entry = maybe_pmd_mkwrite(entry, vma);
@@ -896,8 +899,11 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long
addr,
 	}

 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
-	if (pfn_t_devmap(pfn))
+	if (pfn_t_devmap(pfn)) {
 		entry = pud_mkdevmap(entry);
+		if (pfn_t_special(pfn))
+			entry = pud_mkspecial(entry);
+	}
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
