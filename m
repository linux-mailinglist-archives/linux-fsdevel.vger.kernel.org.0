Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1054AB1FD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 21:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbiBFUS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 15:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiBFUS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 15:18:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86AFC06173B;
        Sun,  6 Feb 2022 12:18:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216EWTJ4011738;
        Sun, 6 Feb 2022 19:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=Vi53N9K+no5Si4hDwTa3a+jRSwTqKUCqjS/7QKeHLJE=;
 b=eTkkVC4JWGsUL6DvgccvruoNZ8Cvaq0gT69FFnkIg+SgdMmD3OXUp0rem/GfC9mM4Hu8
 orh/iWjD2wTLLY0wkYXChJ3Qh/fMaRnezVewjA0F8/tbvGqLSWRtGt0oO6TSPxaO6gz5
 ZnIecuWPG2qtnFz7297vG5NM25Ty1Cxod7D939ZjSmgv3qMDOG5DkrqX0GlU+L66H/li
 IEzCv+R8GWWUuj+1Sl05BtAOt7WuNSLUd6T+dO0Blm6PiFkSnxP5AnXcNKaiBB0WEI84
 iR9FDT9d6FN1BIATfLh7J7XD+Jpxz9kiSQfZAWY/FuuVodghpTNTyAlvDYoPg7zUwmDD 7A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1hsu3vfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 19:04:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 216J1wBC035783;
        Sun, 6 Feb 2022 19:04:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3e1f9cedux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 19:04:41 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 216J4dFV044049;
        Sun, 6 Feb 2022 19:04:41 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3e1f9cedtx-3;
        Sun, 06 Feb 2022 19:04:41 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 2/3] fs/lock: only call lm_breaker_owns_lease if there is conflict.
Date:   Sun,  6 Feb 2022 11:04:29 -0800
Message-Id: <1644174270-20681-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1644174270-20681-1-git-send-email-dai.ngo@oracle.com>
References: <1644174270-20681-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: RpswC5Uj8DQ6lAYCp4dUufCPqKbCmxCH
X-Proofpoint-GUID: RpswC5Uj8DQ6lAYCp4dUufCPqKbCmxCH
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

