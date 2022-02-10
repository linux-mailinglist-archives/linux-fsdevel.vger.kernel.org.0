Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2F4B04A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 05:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiBJEwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 23:52:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiBJEwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:52:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E948E1B2;
        Wed,  9 Feb 2022 20:52:18 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21A4BUuo008865;
        Thu, 10 Feb 2022 04:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=Vi53N9K+no5Si4hDwTa3a+jRSwTqKUCqjS/7QKeHLJE=;
 b=YBNk5P1w/AzesyHWzMu97QMUIgre2bZTD3g48vhNqieqjpyf14X2UoPC5DJwcCBT8cgU
 LTX/1juay5l0RxRTWe5bqFrqnf00InX+0lv27Nnuu6Y3z9ZnxaiSR+0ZF/8G3pmUk864
 zkCrnDqmb5yd27LqEoCFxrkhLK6D8oULxOU20GNLSKNWb7icLC2oCOn7mqAPS0SftOZ1
 2AMB8Mj5U9yncNO/34AmJWtMxa99qpkorv+FhkpiOMyNr27DYTUeiAm7hvJwxQz0hF28
 RBgYCx2NBbWMw4sERlH0/fdM13dLOr7mqyA0fqYx6NlqKu/og1u31Un9WBS2TP64o5Np 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgpxvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 04:52:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21A4oCX3015373;
        Thu, 10 Feb 2022 04:52:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3e1f9jk20t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 04:52:14 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21A4qC5Q020851;
        Thu, 10 Feb 2022 04:52:14 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3e1f9jk1y6-3;
        Thu, 10 Feb 2022 04:52:14 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v12 2/3] fs/lock: only call lm_breaker_owns_lease if there is conflict.
Date:   Wed,  9 Feb 2022 20:52:08 -0800
Message-Id: <1644468729-30383-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: WUEzyr6ZTW3pjHD-xp-eUkj5LdDJqtYw
X-Proofpoint-ORIG-GUID: WUEzyr6ZTW3pjHD-xp-eUkj5LdDJqtYw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
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

