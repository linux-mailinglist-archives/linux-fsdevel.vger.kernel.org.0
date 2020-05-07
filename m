Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14C31C7EFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgEGAot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:44:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48358 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgEGAos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:44:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bsET064662;
        Thu, 7 May 2020 00:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=PxSg4xD+zcpl2hcOtqdCGahscRkc3d/OAEkiyXkPX8s=;
 b=NJFNT1MSypCVx6F/PClttNU9H/aOwnOLeqJWQY9uRHct0XD45kZmJFX2rQCZrmRyn/ZN
 0l6IksA7KAJ5rDMtuWRYVQ0irqh1iPsWn6oha+TugwePRcf6RGAiaYeF8BIflxNBq2RL
 nUwBQoIU7YswUqraFlqZEjLbpKdvVCnfp3stFfCe2fVhMhGCnkveEebVZt5BIktbeAsP
 LCxDKX6eF5mh4JqyClC1/lVkPSmBnKEZdn4envNXms7t5192Bmd4P9cLIVgM00SbBen2
 cikYZHLnfFO9ogq+Vw4wRthjrp2TSpJX2Nx+yKaRcHZBwyZxfVhQyZ5mE1Md1HmL9v6J Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09rdfaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bmHF131733;
        Thu, 7 May 2020 00:43:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30t1r95at8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:54 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470hqGB020317;
        Thu, 7 May 2020 00:43:52 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:43:52 -0700
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@linux.ibm.com, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, masahiroy@kernel.org, ardb@kernel.org,
        ndesaulniers@google.com, dima@golovin.in, daniel.kiper@oracle.com,
        nivedita@alum.mit.edu, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, zhenzhong.duan@oracle.com,
        jroedel@suse.de, bhe@redhat.com, guro@fb.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, hannes@cmpxchg.org, minchan@kernel.org,
        mhocko@kernel.org, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, gustavo@embeddedor.com,
        ziqian.lzq@antfin.com, vdavydov.dev@gmail.com,
        jason.zeng@intel.com, kevin.tian@intel.com, zhiyuan.lv@intel.com,
        lei.l.li@intel.com, paul.c.lai@intel.com, ashok.raj@intel.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [RFC 22/43] mm: shmem: introduce shmem_insert_page
Date:   Wed,  6 May 2020 17:41:48 -0700
Message-Id: <1588812129-8596-23-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=2
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function inserts a page into a shmem file at a specified offset.
The page can be a regular PAGE_SIZE page or a transparent huge page.
If there is something at the offset (page or swap), the function fails.

The function will be used by the next patch.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/shmem_fs.h |  3 ++
 mm/shmem.c               | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 7a35a6901221..688b92cd4ec7 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -96,6 +96,9 @@ enum sgp_type {
 extern int shmem_getpage(struct inode *inode, pgoff_t index,
 		struct page **pagep, enum sgp_type sgp);
 
+extern int shmem_insert_page(struct mm_struct *mm, struct inode *inode,
+		pgoff_t index, struct page *page);
+
 static inline struct page *shmem_read_mapping_page(
 				struct address_space *mapping, pgoff_t index)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index bd8840082c94..0a9a2166e51f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -677,6 +677,101 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
+		      struct page *page)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	gfp_t gfp = mapping_gfp_mask(mapping);
+	int err;
+	int nr = 1;
+	struct mem_cgroup *memcg;
+	pgoff_t hindex = index;
+	bool on_lru = PageLRU(page);
+
+	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
+		return -EFBIG;
+
+	if (PageTransHuge(page))
+		nr = HPAGE_PMD_NR;
+	else
+		nr = 1;
+retry:
+	err = 0;
+	if (!shmem_inode_acct_block(inode, nr))
+		err = -ENOSPC;
+	if (err) {
+		int retry = 5;
+
+		/*
+		 * Try to reclaim some space by splitting a huge page
+		 * beyond i_size on the filesystem.
+		 */
+		while (retry--) {
+			int ret;
+
+			ret = shmem_unused_huge_shrink(sbinfo, NULL, 1);
+			if (ret == SHRINK_STOP)
+				break;
+			if (ret)
+				goto retry;
+		}
+		goto failed;
+	}
+
+	if (!on_lru) {
+		__SetPageLocked(page);
+		__SetPageSwapBacked(page);
+	} else {
+		lock_page(page);
+	}
+
+	if (PageTransHuge(page))
+		hindex = round_down(index, HPAGE_PMD_NR);
+	else
+		hindex = index;
+
+	__SetPageReferenced(page);
+
+	err = mem_cgroup_try_charge_delay(page, mm, gfp, &memcg,
+					PageTransHuge(page));
+	if (err)
+		goto out_unlock;
+
+	err = shmem_add_to_page_cache(page, mapping, hindex,
+					NULL, gfp & GFP_RECLAIM_MASK);
+	if (err) {
+		mem_cgroup_cancel_charge(page, memcg,
+			PageTransHuge(page));
+		goto out_unlock;
+	}
+	mem_cgroup_commit_charge(page, memcg, on_lru,
+			PageTransHuge(page));
+
+	if (!on_lru)
+		lru_cache_add_anon(page);
+
+	spin_lock(&info->lock);
+	info->alloced += compound_nr(page);
+	inode->i_blocks += BLOCKS_PER_PAGE << compound_order(page);
+	shmem_recalc_inode(inode);
+	spin_unlock(&info->lock);
+
+	flush_dcache_page(page);
+	SetPageUptodate(page);
+	set_page_dirty(page);
+
+	unlock_page(page);
+	return 0;
+
+out_unlock:
+	unlock_page(page);
+	shmem_inode_unacct_blocks(inode, nr);
+failed:
+	return err;
+}
+
 /*
  * Remove swap entry from page cache, free the swap and its page cache.
  */
-- 
2.13.3

