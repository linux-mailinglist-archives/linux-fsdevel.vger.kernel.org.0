Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA24A00FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 20:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344248AbiA1TkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 14:40:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29864 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241858AbiA1TkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:40:00 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SJ2i5p019366;
        Fri, 28 Jan 2022 19:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=Vi53N9K+no5Si4hDwTa3a+jRSwTqKUCqjS/7QKeHLJE=;
 b=av+/fDUa/pgm2fGQDd4UbMORF3kCFVFFcydQFWZhshfDb2/CY1Z7NiRsp/YZo57EOVvM
 6hRDchCLfHbIkfMdtWUQfaCdpjIBdAlTxdJMqoLua24qWsUcmXuqgwQ9AVjGDCKqs3Hy
 RKuRsGO4yvalYVvbUUh7MXGCRz7RVjVlyy1da2/ASDBzT9VIh0a5nWRfoU4pAlPoV5sQ
 JNL6UfFcBQ5zrCOe3BYRyMPPbdoy0QQ3icSVVHfsJ1FXeiuoWsXdZY3SuiwQakT4WjpW
 hoB5DHpmm8MySnF93vZQQTS8PVUtID644JYS7fcVYoaMzyVjsB3h0g4yrh8eqG0QJJNr uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duxnp3uc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 19:39:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SJR9Os192093;
        Fri, 28 Jan 2022 19:39:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dr726eqx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 19:39:56 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20SJdsjO038315;
        Fri, 28 Jan 2022 19:39:55 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by userp3030.oracle.com with ESMTP id 3dr726eqv5-3;
        Fri, 28 Jan 2022 19:39:55 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 2/3] fs/lock: only call lm_breaker_owns_lease if there is conflict.
Date:   Fri, 28 Jan 2022 11:39:32 -0800
Message-Id: <1643398773-29149-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: d9hHfsj75U2YCzCov2wt9gD9OmAWgIsW
X-Proofpoint-ORIG-GUID: d9hHfsj75U2YCzCov2wt9gD9OmAWgIsW
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modify leases_conflict to call lm_breaker_owns_lease only if
there is real conflict.  This is to allow the lock manager to
resolve the conflict if possible.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/locks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 052b42cc7f25..456717873cff 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1357,9 +1357,6 @@ static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
 {
 	bool rc;
 
-	if (lease->fl_lmops->lm_breaker_owns_lease
-			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
-		return false;
 	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT)) {
 		rc = false;
 		goto trace;
@@ -1370,6 +1367,9 @@ static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
 	}
 
 	rc = locks_conflict(breaker, lease);
+	if (rc && lease->fl_lmops->lm_breaker_owns_lease &&
+		lease->fl_lmops->lm_breaker_owns_lease(lease))
+		rc = false;
 trace:
 	trace_leases_conflict(rc, lease, breaker);
 	return rc;
-- 
2.9.5

