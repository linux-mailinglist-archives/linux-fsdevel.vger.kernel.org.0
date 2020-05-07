Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4701C7F34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgEGAqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:46:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38982 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgEGAqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:46:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470ep5K098400;
        Thu, 7 May 2020 00:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=GHyTm1dF4tuIvRr/Sme8g0LfjNUADURL5kv1ja2d5gg=;
 b=B2ieybBw6yGUeCUHVlAsRBnlc2/4Xd/KOmp96lhPgAt8aY+OY0nx5m0HV49zY4rmmwNJ
 C2s+DocZP+0TkwaFub5pxJI6VLiZDTcntuJuwRiK6BhA4pqOyBsR5hSUgs8TBMEtVRwq
 OElN/qCU2uFHMkJBBKXftNAEdERNSddgfIfiOzBTs8P4ylt3KV1I3R+rr5nplsc4zmhK
 ndh51F39UD6VOjw/FzRcndPUY74810gTKBZWOztHuZiGWlEMz8N9DZFuEnfShhYFDYJm
 6QwLRCsTOBx7pn2Mq4SU4ShEr7RZ2iKufkGsu48ZeUFaikGwL8cPgZL4TT7Ejf7MNy1O 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30usgq4h41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:45:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bUBT098659;
        Thu, 7 May 2020 00:45:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30sjnma71q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:45:11 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0470j8I8025069;
        Thu, 7 May 2020 00:45:08 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:45:08 -0700
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
Subject: [RFC 43/43] PKRAM: improve index alignment of pkram_link entries
Date:   Wed,  6 May 2020 17:42:09 -0700
Message-Id: <1588812129-8596-44-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To take advantage of optimizations when adding pages to the page cache
via shmem_insert_pages(), improve the likelihood that the pages array
passed to shmem_insert_pages() starts on an aligned index.  Do this
when preserving pages by starting a new pkram_link page when the current
page is aligned and the next aligned page will not fit on the pkram_link
page.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index ef092aa5ce7a..416c3ca4411b 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -913,11 +913,21 @@ static int __pkram_save_page(struct pkram_stream *ps,
 {
 	struct pkram_link *link = ps->link;
 	struct pkram_obj *obj = ps->obj;
+	int order, align, align_cnt;
 	pkram_entry_t p;
-	int order;
+
+	if (PageTransHuge(page)) {
+		align = 1 << (HPAGE_PMD_ORDER + XA_CHUNK_SHIFT - (HPAGE_PMD_ORDER % XA_CHUNK_SHIFT));
+		align_cnt = align >> HPAGE_PMD_ORDER;
+	} else {
+		align = XA_CHUNK_SIZE;
+		align_cnt = XA_CHUNK_SIZE;
+	}
 
 	if (!link || ps->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
-	    index != ps->next_index) {
+	    index != ps->next_index ||
+	    (IS_ALIGNED(index, align) &&
+	    (ps->entry_idx + align_cnt > PKRAM_LINK_ENTRIES_MAX))) {
 		struct page *link_page;
 
 		link_page = pkram_alloc_page((ps->gfp_mask & GFP_RECLAIM_MASK) |
-- 
2.13.3

