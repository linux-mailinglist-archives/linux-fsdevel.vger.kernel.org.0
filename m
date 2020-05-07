Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801571C7F47
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgEGAqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:46:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50194 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgEGAqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:46:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470dTvg076311;
        Thu, 7 May 2020 00:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=J/IiCj+3kST83E/VcM8iyZaL98ROPYAwK19raHrmTZw=;
 b=NaEwX/P0ZZI39WJCV8xbxOOGMpPaIk3KdKPqmf8xqw4W7aDYRJW8HFEbpNiMORAFOvdg
 Pw0JMz+eZIw1ILS1MUToUdL98fMRvPTPn5RInXZTH3CXNINmo4dd871gbwXTMtprIi5c
 OY/w/M9UUV003jvnhTMeGaLUnH/GW8q+W3Ps1wOZYgvxGqADYIXsF1ml9k2aP35nIE65
 AJqv83Hztpww5XQcAIl/iTQk4+71FS6FE5+fB/xoAxqaagg+rcsnPUwprV29UckCzZ3Z
 29bXAE5twy3CU1lwfYpHznoWgzK+Pd7y9lXfIJChI/rgDlTz1AoTZKiuLeSxgkiiZcSB Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09rdfcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bTQT098629;
        Thu, 7 May 2020 00:44:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30sjnma5t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:44:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470ibRQ026192;
        Thu, 7 May 2020 00:44:37 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:44:36 -0700
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
Subject: [RFC 34/43] shmem: PKRAM: multithread preserving and restoring shmem pages
Date:   Wed,  6 May 2020 17:42:00 -0700
Message-Id: <1588812129-8596-35-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Improve performance by multithreading the work to preserve and restore
shmem pages.

Add 'pkram_max_threads=' kernel option to specify the maximum number
of threads to use to preserve or restore the pages of a shmem file.
The default is 16.

When preserving pages each thread saves chunks of a file to a pkram_obj
until no more no more chunks are available.

When restoring pages each thread loads pages using a copy of a
pkram_stream initialized by pkram_prepare_load_obj(). Under the hood
each thread ends up fetching and operating on pkram_link pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   2 +
 mm/shmem_pkram.c      | 101 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index e71ccb91d6a6..bf2e138b044e 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -13,6 +13,8 @@ struct pkram_stream {
 	struct pkram_node *node;
 	struct pkram_obj *obj;
 
+	int error;
+
 	struct pkram_link *link;		/* current link */
 	unsigned int entry_idx;		/* next entry in link */
 
diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 2f4d0bdf3e05..4992b6c3e54e 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -126,6 +126,16 @@ static int save_file_content_range(struct address_space *mapping,
 	return err;
 }
 
+/* Completion tracking for do_save_file_content_thr() threads */
+static atomic_t pkram_save_n_undone;
+static DECLARE_COMPLETION(pkram_save_all_done_comp);
+
+static inline void pkram_save_report_one_done(void)
+{
+	if (atomic_dec_and_test(&pkram_save_n_undone))
+		complete(&pkram_save_all_done_comp);
+}
+
 static int do_save_file_content(struct pkram_stream *ps)
 {
 	int ret;
@@ -142,11 +152,55 @@ static int do_save_file_content(struct pkram_stream *ps)
 	return ret;
 }
 
+static int do_save_file_content_thr(void *data)
+{
+	struct pkram_stream *ps = data;
+	struct pkram_stream pslocal = *ps;
+	int ret;
+
+	ret = do_save_file_content(&pslocal);
+	if (ret && !ps->error)
+		ps->error = ret;
+
+	pkram_save_report_one_done();
+	return 0;
+}
+#define PKRAM_DEFAULT_MAX_THREADS	16
+
+static int pkram_max_threads = PKRAM_DEFAULT_MAX_THREADS;
+
+static int __init set_pkram_max_threads(char *str)
+{
+	unsigned int val;
+
+	if (kstrtouint(str, 0, &val))
+		return 1;
+
+	pkram_max_threads = val;
+
+	return 1;
+}
+__setup("pkram_max_threads=", set_pkram_max_threads);
+
 static int save_file_content(struct pkram_stream *ps)
 {
+	unsigned int thr, nr_threads;
+
+	nr_threads = num_online_cpus() - 1;
+	nr_threads = clamp_val(pkram_max_threads, 1, nr_threads);
+
 	ps->max_idx = DIV_ROUND_UP(i_size_read(ps->mapping->host), PAGE_SIZE);
 
-	return do_save_file_content(ps);
+	if (nr_threads == 1)
+		return do_save_file_content(ps);
+
+	atomic_set(&pkram_save_n_undone, nr_threads);
+	for (thr = 0; thr < nr_threads; thr++)
+		kthread_run(do_save_file_content_thr, ps, "pkram_save%d", thr);
+
+	wait_for_completion(&pkram_save_all_done_comp);
+
+	return ps->error;
 }
 
 static int save_file(struct dentry *dentry, struct pkram_stream *ps)
@@ -248,7 +302,17 @@ int shmem_save_pkram(struct super_block *sb)
 	return err;
 }
 
-static int load_file_content(struct pkram_stream *ps)
+/* Completion tracking for do_load_file_content_thr() threads */
+static atomic_t pkram_load_n_undone;
+static DECLARE_COMPLETION(pkram_load_all_done_comp);
+
+static inline void pkram_load_report_one_done(void)
+{
+	if (atomic_dec_and_test(&pkram_load_n_undone))
+		complete(&pkram_load_all_done_comp);
+}
+
+static int do_load_file_content(struct pkram_stream *ps)
 {
 	unsigned long index;
 	struct page *page;
@@ -266,6 +330,39 @@ static int load_file_content(struct pkram_stream *ps)
 	return err;
 }
 
+static int do_load_file_content_thr(void *data)
+{
+	struct pkram_stream *ps = data;
+	struct pkram_stream pslocal = *ps;
+	int ret;
+
+	ret = do_load_file_content(&pslocal);
+	if (ret && !ps->error)
+		ps->error = ret;
+
+	pkram_load_report_one_done();
+	return 0;
+}
+
+static int load_file_content(struct pkram_stream *ps)
+{
+	unsigned int thr, nr_threads;
+
+	nr_threads = num_online_cpus() - 1;
+	nr_threads = clamp_val(pkram_max_threads, 1, nr_threads);
+
+	if (nr_threads == 1)
+		return do_load_file_content(ps);
+
+	atomic_set(&pkram_load_n_undone, nr_threads);
+	for (thr = 0; thr < nr_threads; thr++)
+		kthread_run(do_load_file_content_thr, ps, "pkram_load%d", thr);
+
+	wait_for_completion(&pkram_load_all_done_comp);
+
+	return ps->error;
+}
+
 static int load_file(struct dentry *parent, struct pkram_stream *ps,
 		     char *buf, size_t bufsize)
 {
-- 
2.13.3

