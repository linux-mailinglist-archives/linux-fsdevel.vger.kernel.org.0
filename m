Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846DD4B36FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Feb 2022 19:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiBLSNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Feb 2022 13:13:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBLSNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:13:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3EC50B2B;
        Sat, 12 Feb 2022 10:13:03 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21C9iZCH018836;
        Sat, 12 Feb 2022 18:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=tThgcaiGmTbULAPxqZRjZiOlO/ux403+Gpgm9lIu16c=;
 b=itEzUN7TD8VlMLrvSGe6RbUBUyUUnRueT/y+NsHatBkAeIai1Aog2Z8ny3OSQgx+++p/
 qHgxcK/hzulKXZXTjMZqEea1rDAPYfdFsHjxli16V38iNkkBS5oNriQnmpe5rB6+7p5/
 lZwZXSV4hDYPvQ9mLii3K83uXhupr3RLfI8Py49zouLcet7jFV4yQjjsURjLNSt8EwlT
 1VfmjepkRWL6dN1neWFG45EgSjGGUuwbPwkAsM6OSmJHXjkRfPN4GW+8bEyXBq+17+Qc
 8T+vl+JaGPpE2Qw99tQg+Bpn5E8AJjxaxmayNY6Ye2pnjC6lSU7Lq09CNx+7yvf2LJ9f fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e65eu8vqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Feb 2022 18:13:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21CIBqLP120392;
        Sat, 12 Feb 2022 18:12:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e66bj2f5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Feb 2022 18:12:59 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21CICvs1121470;
        Sat, 12 Feb 2022 18:12:58 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by userp3020.oracle.com with ESMTP id 3e66bj2f4u-4;
        Sat, 12 Feb 2022 18:12:58 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v13 3/4] fs/lock: only call lm_breaker_owns_lease if there is conflict.
Date:   Sat, 12 Feb 2022 10:12:54 -0800
Message-Id: <1644689575-1235-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
References: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: oxTmIk42g6HG4TsWlsTd0fEM3NKkMGdU
X-Proofpoint-GUID: oxTmIk42g6HG4TsWlsTd0fEM3NKkMGdU
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
index 52ede42651df..050acf8b5110 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1387,9 +1387,6 @@ static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
 {
 	bool rc;
 
-	if (lease->fl_lmops->lm_breaker_owns_lease
-			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
-		return false;
 	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT)) {
 		rc = false;
 		goto trace;
@@ -1400,6 +1397,9 @@ static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
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

