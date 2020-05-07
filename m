Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496941C7F22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgEGAp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49286 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbgEGApm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bf8n064546;
        Thu, 7 May 2020 00:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=oFT1yBFW8AHAZV3UNuKLHKSGogjlAC220NrwLhQ0UYw=;
 b=HgABZr+IuW0bizjZsOhBocfRcnf0KRefLf3gt3ntgcQxVC5z5midvGSiL3u5c+0IKq7G
 i+qh6CeUH01sNbh0H+SiqbbQHo5PUodu9RD4K1ErRgDicA6zKoxWLq/FzV/uk94KsDrG
 C5MsL+g0FI9qhmduZAhHk8ILBazNIMUO2KlXNvNtH+DxPveiamYpfTPrTvrHR/D5jFYe
 aIdLYMI/qzYHDhGnOAs5CwZbJSCYQhQAucJw58JnfFcRJH9yFZFFMhAjJh6HvnD2FuEU
 OGod21YuTTgQQddM/74eIduNCal5IlR81Ox8j3lxVdhgNkNw8Czy13yyzXW376U8IV+W rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09rdfcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470allu170700;
        Thu, 7 May 2020 00:44:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30us7p2pfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:43 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470ieAl024907;
        Thu, 7 May 2020 00:44:40 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:39 -0700
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
Subject: [RFC 35/43] shmem: introduce shmem_insert_pages()
Date:   Wed,  6 May 2020 17:42:01 -0700
Message-Id: <1588812129-8596-36-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
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

Calling shmem_insert_page() to insert one page at a time does
not scale well when multiple threads are inserting pages into
the same shmem segment.  This is primarily due to the locking needed
when adding to the pagecache and LRU but also due to contention
on the shmem_inode_info lock. To address the shmem_inode_info lock
and prepare for future optimizations, introduce shmem_insert_pages()
which allows a caller to pass an array of pages to be inserted into a
shmem segment.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/shmem_fs.h |   3 +-
 mm/shmem.c               | 114 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index f2ce9937a8f2..d308a6a154b6 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -105,7 +105,8 @@ extern int shmem_getpage(struct inode *inode, pgoff_t index,
 
 extern int shmem_insert_page(struct mm_struct *mm, struct inode *inode,
 		pgoff_t index, struct page *page);
-
+extern int shmem_insert_pages(struct mm_struct *mm, struct inode *inode,
+			      pgoff_t index, struct page *pages[], int npages);
 #ifdef CONFIG_PKRAM
 extern int shmem_parse_pkram(const char *str, struct shmem_pkram_info **pkram);
 extern void shmem_show_pkram(struct seq_file *seq, struct shmem_pkram_info *pkram,
diff --git a/mm/shmem.c b/mm/shmem.c
index 1f3b43b8fa34..ca5edf580f24 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -781,6 +781,120 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	return err;
 }
 
+int shmem_insert_pages(struct mm_struct *mm, struct inode *inode, pgoff_t index,
+		       struct page *pages[], int npages)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	gfp_t gfp = mapping_gfp_mask(mapping);
+	struct mem_cgroup *memcg;
+	int i, err;
+	int nr = 0;
+
+	for (i = 0; i < npages; i++)
+		nr += compound_nr(pages[i]);
+
+	if (index + nr - 1 > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
+		return -EFBIG;
+
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
+	for (i = 0; i < npages; i++) {
+		if (!PageLRU(pages[i])) {
+			__SetPageLocked(pages[i]);
+			__SetPageSwapBacked(pages[i]);
+		} else {
+			lock_page(pages[i]);
+		}
+
+		__SetPageReferenced(pages[i]);
+
+		if (pages[i]->mem_cgroup)
+			continue;
+
+		err = mem_cgroup_try_charge_delay(pages[i], mm, gfp,
+					&memcg, PageTransHuge(pages[i]));
+		if (err)
+			goto out_unlock;
+
+	}
+
+	for (i = 0; i < npages; i++) {
+		err = shmem_add_to_page_cache(pages[i], mapping, index,
+					NULL, gfp & GFP_RECLAIM_MASK);
+		if (err)
+			goto out_truncate;
+
+		if (PageTransHuge(pages[i]))
+			index += HPAGE_PMD_NR;
+		else
+			index++;
+	}
+
+	spin_lock(&info->lock);
+	info->alloced += nr;
+	inode->i_blocks += BLOCKS_PER_PAGE * nr;
+	shmem_recalc_inode(inode);
+	spin_unlock(&info->lock);
+
+	for (i = 0; i < npages; i++) {
+		if (!pages[i]->mem_cgroup) {
+			mem_cgroup_commit_charge(pages[i], memcg,
+				PageLRU(pages[i]), PageTransHuge(pages[i]));
+		}
+
+		if (!PageLRU(pages[i]))
+			lru_cache_add_anon(pages[i]);
+
+		flush_dcache_page(pages[i]);
+		SetPageUptodate(pages[i]);
+		set_page_dirty(pages[i]);
+
+		unlock_page(pages[i]);
+	}
+
+	return 0;
+
+out_truncate:
+	while (--i >= 0)
+		truncate_inode_page(mapping, pages[i]);
+	i = npages;
+out_unlock:
+	while (--i >= 0) {
+		if (!pages[i]->mem_cgroup) {
+			mem_cgroup_cancel_charge(pages[i], memcg,
+				PageTransHuge(pages[i]));
+		}
+
+		unlock_page(pages[i]);
+	}
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

