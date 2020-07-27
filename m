Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE6622F62E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgG0RH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 13:07:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59392 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgG0RH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:07:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RGgkN5077073;
        Mon, 27 Jul 2020 17:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=EH2bcmGiKig5NQUr25P5VYLKdWqRTYRE1Orwb4KgXik=;
 b=l1LOF0dmlbi1ncVDq7RWlEvNJYr2LbPMPmGo3aXniYWPZhLlMSHR0iWNp/2cDgmG6dbR
 RsmBzBxwcJM3BxRVkITqX1WvldXoqwBEQ03KjtD+yDZgD1mbk32LJV5cwSQ381iZh3Y9
 BCtLvGVqEyXedSXoHlknOTfyCHrbE6mWURmbGcIEEHGXvrGUEJ5/qtMwH8azy5BTtzxL
 krFCtP1n2bTqG81bcnd5Xz1b8ajPJlHCouPTuK7bHtdIFfZN519587R0e4/RkkwN7uww
 /QNbyjqx8Ocr6uD0+RLlm6G5JCez12sO4h0aSAWN1OV1n+iLEpHqky6Wc6yI5u2WSKKf jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32hu1j2rvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RGgViM055487;
        Mon, 27 Jul 2020 17:02:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 32hu5r9fda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:16 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06RGuWGn111604;
        Mon, 27 Jul 2020 17:02:15 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by userp3020.oracle.com with ESMTP id 32hu5r9f7r-6;
        Mon, 27 Jul 2020 17:02:15 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com,
        steven.sistare@oracle.com
Subject: [RFC PATCH 5/5] mm: introduce MADV_DOEXEC
Date:   Mon, 27 Jul 2020 10:11:27 -0700
Message-Id: <1595869887-23307-6-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

madvise MADV_DOEXEC preserves a memory range across exec.  Initially
only supported for non-executable, non-stack, anonymous memory.
MADV_DONTEXEC reverts the effect of a previous MADV_DOXEXEC call and
undoes the preservation of the range.  After a successful exec call,
the behavior of all ranges reverts to MADV_DONTEXEC.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/uapi/asm-generic/mman-common.h |  3 +++
 mm/madvise.c                           | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index f94f65d429be..7c5f616b28f7 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -72,6 +72,9 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_DOEXEC	22		/* do inherit across exec */
+#define MADV_DONTEXEC	23		/* don't inherit across exec */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index dd1d43cf026d..b447fa748649 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -103,6 +103,26 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	case MADV_KEEPONFORK:
 		new_flags &= ~VM_WIPEONFORK;
 		break;
+	case MADV_DOEXEC:
+		/*
+		 * MADV_DOEXEC is only supported on private, non-executable,
+		 * non-stack anonymous memory and if the VM_EXEC_KEEP flag
+		 * is available.
+		 */
+		if (!VM_EXEC_KEEP || vma->vm_file || vma->vm_flags & (VM_EXEC|VM_SHARED|VM_STACK)) {
+			error = -EINVAL;
+			goto out;
+		}
+		new_flags |= (new_flags & ~VM_MAYEXEC) | VM_EXEC_KEEP;
+		break;
+	case MADV_DONTEXEC:
+		if (!VM_EXEC_KEEP) {
+			error = -EINVAL;
+			goto out;
+		}
+		if (new_flags & VM_EXEC_KEEP)
+			new_flags |= (new_flags & ~VM_EXEC_KEEP) | VM_MAYEXEC;
+		break;
 	case MADV_DONTDUMP:
 		new_flags |= VM_DONTDUMP;
 		break;
@@ -983,6 +1003,8 @@ static int madvise_inject_error(int behavior,
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
 #endif
+	case MADV_DOEXEC:
+	case MADV_DONTEXEC:
 		return true;
 
 	default:
@@ -1037,6 +1059,9 @@ static int madvise_inject_error(int behavior,
  *  MADV_DONTDUMP - the application wants to prevent pages in the given range
  *		from being included in its core dump.
  *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
+ *  MADV_DOEXEC - On exec, preserve and duplicate this area in the new process
+ *		  if the new process allows it.
+ *  MADV_DONTEXEC - Undo the effect of MADV_DOEXEC.
  *
  * return values:
  *  zero    - success
-- 
1.8.3.1

