Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419DC1C7F0F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgEGApf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:45:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38406 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgEGApc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:45:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470dPdL097637;
        Thu, 7 May 2020 00:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=1Bmtu9b1EQ6RlXRXyCYx+5Wul/Cgv66PAY+KBFTTzmA=;
 b=q0YZFZs5h7XIW8HJYTzZsL5L3nYa8h3YEneyLm7sBPO8PNakw7I55XIpiJbhfov8LQyS
 s0IPhqXHyetzu/uiDcvdAf7KB81CmiyZPnlGfB3fzqvXlbC0YzFyEhZ5WI7VMjs/Jq/V
 6DFD8tHUn3dNCVwx8P4IzgdDb3MZfbHkhgOjByJRcZIZjn5laIk4/S7z/jCdxiIprwlc
 Ax2XInFVGmSzckUrDSqfFnTdC634xgx0X9EnssZX8Ss0FUzXcKM6+9zZI/AWXces2T7A
 k/O5iUDBMFwqDtChOZ3byOot3qpmPDtn455qqvcgVjvlIiZWPpg4XOL61Gfrh2EKaH+T oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30usgq4h1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470biu3098934;
        Thu, 7 May 2020 00:42:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30sjnma0nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:42:31 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470gTGx029257;
        Thu, 7 May 2020 00:42:29 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:42:29 -0700
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
Subject: [RFC 03/43] mm: PKRAM: implement object load and save functions
Date:   Wed,  6 May 2020 17:41:29 -0700
Message-Id: <1588812129-8596-4-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PKRAM nodes are further divided into a list of objects. After a save
operation has been initiated for a node, a save operation for an object
associated with the node is initiated by calling pkram_prepare_save_obj().
A new object is created and linked to the node.  The save operation for
the object is committed by calling pkram_finish_save_obj().  After a load
operation has been initiated, pkram_prepare_load_obj() is called to
delete the next object from the node and prepare the corresponding
stream for loading data from it.  After the load of object has been
finished, pkram_finish_load_obj() is called to free the object.  Objects
are also deleted when a save operation is discarded.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  1 +
 mm/pkram.c            | 77 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 83a0579e4c1c..fabde2cd8203 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -11,6 +11,7 @@ struct pkram_node;
 struct pkram_stream {
 	gfp_t gfp_mask;
 	struct pkram_node *node;
+	struct pkram_obj *obj;
 };
 
 #define PKRAM_NAME_MAX		256	/* including nul */
diff --git a/mm/pkram.c b/mm/pkram.c
index 5c57126353ff..4934ffd8b019 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -6,9 +6,14 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pkram.h>
+#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
+struct pkram_obj {
+	__u64   obj_pfn;	/* points to the next object in the list */
+};
+
 /*
  * Preserved memory is divided into nodes that can be saved or loaded
  * independently of each other. The nodes are identified by unique name
@@ -18,6 +23,7 @@
  */
 struct pkram_node {
 	__u32	flags;
+	__u64	obj_pfn;	/* points to the first obj of the node */
 
 	__u8	name[PKRAM_NAME_MAX];
 };
@@ -62,6 +68,21 @@ static struct pkram_node *pkram_find_node(const char *name)
 	return NULL;
 }
 
+static void pkram_truncate_node(struct pkram_node *node)
+{
+	unsigned long obj_pfn;
+	struct pkram_obj *obj;
+
+	obj_pfn = node->obj_pfn;
+	while (obj_pfn) {
+		obj = pfn_to_kaddr(obj_pfn);
+		obj_pfn = obj->obj_pfn;
+		pkram_free_page(obj);
+		cond_resched();
+	}
+	node->obj_pfn = 0;
+}
+
 static void pkram_stream_init(struct pkram_stream *ps,
 			     struct pkram_node *node, gfp_t gfp_mask)
 {
@@ -70,6 +91,11 @@ static void pkram_stream_init(struct pkram_stream *ps,
 	ps->node = node;
 }
 
+static void pkram_stream_init_obj(struct pkram_stream *ps, struct pkram_obj *obj)
+{
+	ps->obj = obj;
+}
+
 /**
  * Create a preserved memory node with name @name and initialize stream @ps
  * for saving data to it.
@@ -124,12 +150,31 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENOMEM: insufficient memory available
+ *
  * After the save has finished, pkram_finish_save_obj() (or pkram_discard_save()
  * in case of failure) is to be called.
  */
 int pkram_prepare_save_obj(struct pkram_stream *ps)
 {
-	return -ENOSYS;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj;
+	struct page *page;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+	obj = page_address(page);
+
+	if (node->obj_pfn)
+		obj->obj_pfn = node->obj_pfn;
+	node->obj_pfn = page_to_pfn(page);
+
+	pkram_stream_init_obj(ps, obj);
+	return 0;
 }
 
 /**
@@ -137,7 +182,9 @@ int pkram_prepare_save_obj(struct pkram_stream *ps)
  */
 void pkram_finish_save_obj(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 }
 
 /**
@@ -169,6 +216,7 @@ void pkram_discard_save(struct pkram_stream *ps)
 	pkram_delete_node(node);
 	mutex_unlock(&pkram_mutex);
 
+	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
 
@@ -216,11 +264,26 @@ int pkram_prepare_load(struct pkram_stream *ps, const char *name)
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENODATA: Stream @ps has no preserved memory objects
+ *
  * After the load has finished, pkram_finish_load_obj() is to be called.
  */
 int pkram_prepare_load_obj(struct pkram_stream *ps)
 {
-	return -ENOSYS;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	if (!node->obj_pfn)
+		return -ENODATA;
+
+	obj = pfn_to_kaddr(node->obj_pfn);
+	node->obj_pfn = obj->obj_pfn;
+
+	pkram_stream_init_obj(ps, obj);
+	return 0;
 }
 
 /**
@@ -230,7 +293,12 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
  */
 void pkram_finish_load_obj(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj = ps->obj;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	pkram_free_page(obj);
 }
 
 /**
@@ -244,6 +312,7 @@ void pkram_finish_load(struct pkram_stream *ps)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
 
+	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
 
-- 
2.13.3

