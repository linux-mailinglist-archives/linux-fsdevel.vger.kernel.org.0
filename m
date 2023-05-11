Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AFD6FFC07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 23:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbjEKVnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 17:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbjEKVnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 17:43:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE62E5;
        Thu, 11 May 2023 14:43:38 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BKwFMP002761;
        Thu, 11 May 2023 21:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=jINMRZDZBJHoWR5YQtm/18BICozjjpvY2luFdSWSeHc=;
 b=iyGHstWbRgfbxLPXFNTOZi+1MM4Ljwk1kg73Vq1vGCNr4ojEX9+VBHKzf/PD1AhAI8Zv
 qqt/tsKjNMJnaeJM3ORBR+YpDRvPTfLxQIn9ml+b9Y0JhDUtYPgP7TC2xi3+VgZCBnq4
 054wJ6gR5yQhzbXiMuafnPT08pQyG4JkXmJrlBz3A0r0Hk4mwc2XOUqGUHS8eVAQbLzR
 yWRw8LU+bPWeIEn3pG6cOae096niE/vVh5WwYXdvRI0E01uJmI2Y7Z7a5LMmGL22bENo
 U85+bfZyB4gSMLvqzblS44epAACX3GD5SukB4WuRN0TBFc2oj2Rt9uMsJfl8l4jJW2Gh 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7758c01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 21:43:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BLdwCf018427;
        Thu, 11 May 2023 21:43:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77kcm7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 21:43:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34BLhX1Y028893;
        Thu, 11 May 2023 21:43:34 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qf77kcm6r-2;
        Thu, 11 May 2023 21:43:34 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] locks: allow support for write delegation
Date:   Thu, 11 May 2023 14:43:00 -0700
Message-Id: <1683841383-21372-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1683841383-21372-1-git-send-email-dai.ngo@oracle.com>
References: <1683841383-21372-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110184
X-Proofpoint-GUID: 0kng8U48dyIyJffs4Uuq_GApE9yGRBSu
X-Proofpoint-ORIG-GUID: 0kng8U48dyIyJffs4Uuq_GApE9yGRBSu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the check for F_WRLCK in generic_add_lease to allow file_lock
to be used for write delegation.

NFSD is the first consumer.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/locks.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index df8b26a42524..08fb0b4fd4f8 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1729,13 +1729,6 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
 	if (is_deleg && !inode_trylock(inode))
 		return -EAGAIN;
 
-	if (is_deleg && arg == F_WRLCK) {
-		/* Write delegations are not currently supported: */
-		inode_unlock(inode);
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
-
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	time_out_leases(inode, &dispose);
-- 
2.9.5

