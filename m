Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE3222F5F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgG0RDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 13:03:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39514 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgG0RDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:03:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RH1m1l115287;
        Mon, 27 Jul 2020 17:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=TeNtDqDqIQ7vUEFJe8evTe6FYY6zKZvMIc3ENnPMQc0=;
 b=RYz1YCi4flsp2nsaalElHjr/hSEq9BFy53s+1DZ+5n+d1AvmCPHXu6sh5Y145WTuFAai
 HU0TACE1RDbQRpWN8Z8XTQB98axZVsYGs7DSYIoz/h7Klai8PAGqwKRTLDbKImfMts3S
 P+PsgiBo0fou1y6SAFN9Hpuk/GMdlLoiKrPK69KDT+4x6bJ2UE1bkWLpW+GLclUvh5Dw
 uGR1Dpzy+80qdnAlIFuEp6v4lk8LH6FusYE8y+/sTrhAFxKylcskhlPSMXWjNYe0nDFJ
 H5EbxXytrIkHX1d3qQwm16zuK82R9R5HiCQh7J2V0isgUvT+NIRyX4CtBbCtekUKREkg wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32hu1j2rah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RGgWKE055548;
        Mon, 27 Jul 2020 17:02:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 32hu5r9fa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:12 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06RGuWGh111604;
        Mon, 27 Jul 2020 17:02:12 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by userp3020.oracle.com with ESMTP id 32hu5r9f7r-3;
        Mon, 27 Jul 2020 17:02:12 +0000
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
Subject: [RFC PATCH 2/5] mm: do not assume only the stack vma exists in setup_arg_pages()
Date:   Mon, 27 Jul 2020 10:11:24 -0700
Message-Id: <1595869887-23307-3-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270117
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for allowing vmas to be preserved across exec do not
assume that there is no prev vma to pass to mprotect_fixup() in
setup_arg_pages().
Also, setup_arg_pages() expands the initial stack of a process by
128k or to the stack size limit, whichever is smaller.  expand_stack()
assumes there is no vma between the vma passed to it and the
address to expand to, so check before calling it.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 fs/exec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..262112e5f9f8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -720,7 +720,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
-	struct vm_area_struct *prev = NULL;
+	struct vm_area_struct *prev = vma->vm_prev;
 	unsigned long vm_flags;
 	unsigned long stack_base;
 	unsigned long stack_size;
@@ -819,6 +819,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	else
 		stack_base = vma->vm_start - stack_expand;
 #endif
+	if (vma != find_vma(mm, stack_base)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
 	current->mm->start_stack = bprm->p;
 	ret = expand_stack(vma, stack_base);
 	if (ret)
-- 
1.8.3.1

