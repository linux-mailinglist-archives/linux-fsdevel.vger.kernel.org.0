Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB41E4AB25E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 22:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbiBFVb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 16:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiBFVbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:31:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEF0C061348;
        Sun,  6 Feb 2022 13:31:24 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216HQTLa003452;
        Sun, 6 Feb 2022 21:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=Vi53N9K+no5Si4hDwTa3a+jRSwTqKUCqjS/7QKeHLJE=;
 b=hN94232bW0wOb8S62MSBrrAd25NeiCRtzpZyoZo+r/lc18ZxN4gZqjV/VHMnPMgq87Kd
 fbi01GbGtp5h31EoB0IbsGtbvxSwaQCx4tJQbFqctIbBJ7YBam9e16jop1dv2eS2CqBW
 0khJLTg9kttnOlXHKXa4CDiezPo4d9662SXgES17IHWkljKZuPfCdZVOLPyBFHsl+Y70
 9SMmaONSSfrkf7Ypw9j/mbj2iVtMS7tf1ls6HwCpc3buc5R5tMk7OLGQeAC3ptbJhcNN
 qwBxX3ewSuI4yPbuRsEKjJ4r1DwjVb0Ef01XUwcE2Fkk86fjivuGZy1tPzB7/UTqH3uT zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13m5gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 21:31:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 216LFxoR076359;
        Sun, 6 Feb 2022 21:31:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3e1f9ch3yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 21:31:21 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 216LVJOm103536;
        Sun, 6 Feb 2022 21:31:21 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3e1f9ch3xt-3;
        Sun, 06 Feb 2022 21:31:21 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v11 2/3] fs/lock: only call lm_breaker_owns_lease if there is conflict.
Date:   Sun,  6 Feb 2022 13:31:16 -0800
Message-Id: <1644183077-2663-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1644183077-2663-1-git-send-email-dai.ngo@oracle.com>
References: <1644183077-2663-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: DUI0FOKByjw3HFcgR02L_LRO7axUvuP2
X-Proofpoint-ORIG-GUID: DUI0FOKByjw3HFcgR02L_LRO7axUvuP2
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

