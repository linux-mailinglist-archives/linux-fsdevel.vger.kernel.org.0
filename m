Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128E01C7F13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgEGApi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49182 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgEGApg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bgk7064570;
        Thu, 7 May 2020 00:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=St3JE32B8DDqwlwkgwkk0bfEnH6+lOQGeM29niLEd0A=;
 b=yXBvQi9HTMMMU1huyex4wrc1y7Z1DfDKRz/ZcxKXikIq7nPKFWfaw5uEmk/o/LH5PrWe
 MVh3hXvABR/ob5om6dPne2Ky4euGj/96rbDwepjk12StUklMh99Ia5xQXIhli7yquWVQ
 P39NA/tI15qHc7DzL1B2hPEXLFUo9ElstoXA47WOI1/juGLon4+gubwDga7chJcNu7fR
 LXSPQmDngLKwSkiIHHO/0M5D9sNFUqEjD+6NhXn026uKfb0WnOgSw+zbKmaOgZW8ulFE
 uoxdZ+J512LEpmrb5916loU5Ajdub6qACvGh4J+vfg7cgjuov/sgoNmfM7vJib7Qmn7K mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30s09rdfc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470aoW0136163;
        Thu, 7 May 2020 00:44:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdwrsn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:34 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470iUY9026137;
        Thu, 7 May 2020 00:44:31 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:30 -0700
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
Subject: [RFC 32/43] shmem: PKRAM: preserve shmem files a chunk at a time
Date:   Wed,  6 May 2020 17:41:58 -0700
Message-Id: <1588812129-8596-33-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
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

To prepare for multithreading the work done to a preserve a file,
divide the work into subranges of the total index range of the file.
The chunk size is a rather arbitrary 256k indices.

A new API call, pkram_prepare_save_chunk(), is added.  It is called
after calling pkram_prepare_save_obj(), and it initializes pkram_stream
with the index range of the next available range of pages to save.
find_get_pages_range() can then be used to get the pages in the range.
When no more index ranges are available, pkram_prepare_save_chunk()
returns -ENODATA.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  6 +++++
 mm/pkram.c            | 26 +++++++++++++++++++++
 mm/shmem_pkram.c      | 63 +++++++++++++++++++++++++++++++++++----------------
 3 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index cbb79d2803c0..e71ccb91d6a6 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -20,6 +20,11 @@ struct pkram_stream {
 	struct address_space *mapping;
 	struct mm_struct *mm;
 
+	unsigned long start_idx;	/* first index in range to save */
+	unsigned long end_idx;		/* last index in range to save */
+	unsigned long max_idx;		/* maximum index to save */
+	atomic64_t *next_idx;		/* first index of next range to save */
+
 	/* byte data */
 	struct page *data_page;
 	unsigned int data_offset;
@@ -46,6 +51,7 @@ void pkram_free_pgt_walk_pgd(pgd_t *pgd);
 int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 		       gfp_t gfp_mask);
 int pkram_prepare_save_obj(struct pkram_stream *ps);
+int pkram_prepare_save_chunk(struct pkram_stream *ps);
 void pkram_finish_save(struct pkram_stream *ps);
 void pkram_finish_save_obj(struct pkram_stream *ps);
 void pkram_discard_save(struct pkram_stream *ps);
diff --git a/mm/pkram.c b/mm/pkram.c
index b83d31740619..5f4e4d12865f 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -638,6 +638,25 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
 	return 0;
 }
 
+unsigned long max_pages_per_chunk = 512 * 512;
+
+/*
+ * Initialize the stream @ps for the next index range to save.
+ *
+ * Returns 0 on success, -ENODATA if no index range is available
+ *
+ */
+int pkram_prepare_save_chunk(struct pkram_stream *ps)
+{
+	ps->start_idx = atomic64_fetch_add(max_pages_per_chunk, ps->next_idx);
+	if (ps->start_idx >= ps->max_idx)
+		return -ENODATA;
+
+	ps->end_idx = ps->start_idx + max_pages_per_chunk - 1;
+
+	return 0;
+}
+
 /**
  * Create a preserved memory object and initialize stream @ps for saving data
  * to it.
@@ -667,6 +686,11 @@ int pkram_prepare_save_obj(struct pkram_stream *ps)
 		obj->obj_pfn = node->obj_pfn;
 	node->obj_pfn = page_to_pfn(page);
 
+	ps->next_idx = kmalloc(sizeof(atomic64_t), GFP_KERNEL);
+	if (!ps->next_idx)
+		return -ENOMEM;
+	atomic64_set(ps->next_idx, 0);
+
 	pkram_stream_init_obj(ps, obj);
 	return 0;
 }
@@ -679,6 +703,8 @@ void pkram_finish_save_obj(struct pkram_stream *ps)
 	struct pkram_node *node = ps->node;
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	kfree(ps->next_idx);
 }
 
 /**
diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index c97d64393822..2f4d0bdf3e05 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -74,58 +74,81 @@ static int save_page(struct page *page, struct pkram_stream *ps)
 	return err;
 }
 
-static int save_file_content(struct pkram_stream *ps)
+static int save_file_content_range(struct address_space *mapping,
+				   struct pkram_stream *ps)
 {
+	unsigned long index, end;
 	struct pagevec pvec;
-	pgoff_t indices[PAGEVEC_SIZE];
-	pgoff_t index = 0;
 	struct page *page;
-	int i, err = 0;
+	int err = 0;
+	int i;
+
+	index = ps->start_idx;
+	end = ps->end_idx;
 
 	pagevec_init(&pvec);
 	for ( ; ; ) {
-		pvec.nr = find_get_entries(ps->mapping, index, PAGEVEC_SIZE,
-				pvec.pages, indices);
+		pvec.nr = find_get_pages_range(mapping, &index, end,
+				PAGEVEC_SIZE, pvec.pages);
 		if (!pvec.nr)
 			break;
-		for (i = 0; i < pagevec_count(&pvec); i++) {
+		for (i = 0; i < pagevec_count(&pvec); ) {
 			page = pvec.pages[i];
-			index = indices[i];
-
-			if (WARN_ON_ONCE(xa_is_value(page))) {
-				err = -EINVAL;
-				break;
-			}
-
 			lock_page(page);
 
 			if (PageTransTail(page)) {
 				WARN_ONCE(1, "PageTransTail returned true\n");
 				unlock_page(page);
+				i++;
 				continue;
 			}
 
-			BUG_ON(page->mapping != ps->mapping);
+			BUG_ON(page->mapping != mapping);
 			err = save_page(page, ps);
 
-			i += compound_nr(page) - 1;
-			index += compound_nr(page) - 1;
+			if (PageCompound(page)) {
+				index = page->index + compound_nr(page);
+				i += compound_nr(page);
+			} else {
+				i++;
+			}
 
 			unlock_page(page);
 			if (err)
 				break;
 		}
-		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
-		if (err)
+		if (err || (index > end))
 			break;
 		cond_resched();
-		index++;
 	}
 
 	return err;
 }
 
+static int do_save_file_content(struct pkram_stream *ps)
+{
+	int ret;
+
+	do {
+		ret = pkram_prepare_save_chunk(ps);
+		if (!ret)
+			ret = save_file_content_range(ps->mapping, ps);
+	} while (!ret);
+
+	if (ret == -ENODATA)
+		ret = 0;
+
+	return ret;
+}
+
+static int save_file_content(struct pkram_stream *ps)
+{
+	ps->max_idx = DIV_ROUND_UP(i_size_read(ps->mapping->host), PAGE_SIZE);
+
+	return do_save_file_content(ps);
+}
+
 static int save_file(struct dentry *dentry, struct pkram_stream *ps)
 {
 	struct inode *inode = dentry->d_inode;
-- 
2.13.3

