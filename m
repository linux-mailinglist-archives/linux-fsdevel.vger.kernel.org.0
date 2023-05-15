Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D967020C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjEOAVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 20:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbjEOAVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 20:21:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997DF10F0;
        Sun, 14 May 2023 17:21:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ELwcHp012739;
        Mon, 15 May 2023 00:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=/N2LpwZMHf8t9rQO6kZ7l4/DJAl3DnwMVCbSh1H47sk=;
 b=UHln5BzSAXuwi4MkfRK6yZG4pqFpyqGj3hCv9UKm0aG2q6H3v9HUgL7ZWujNzCjpZr2A
 K+4V/OHfmWJRYssTwHE8j5hSa2YOV7r2w6HV38bCQ94+1Jh9vJ/GSJVyQ0SpIKjTUN8W
 k/nR7EfyDy2LIdFe78tEq5IhwyBcmjtvmv+pAzASF8E2YGiKeuhm9YKfVOFsrIrZwqlF
 9Pi1DpCJ5aQKGw2yGKHF3LjaqJ/kQKMSPB1Pp7J7Z8UbpQ4fbuQxGJbcTx/+s7kZb0qS
 etEOX96XB5JgWzwQKIgjX/IoJ2RODIeX6WEhdOXJ+OA3TqEiZzjrQHYMWT+Kazzn4O2E dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1b3p8ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 00:20:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ELIpBW033085;
        Mon, 15 May 2023 00:20:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107ymss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 00:20:52 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34F0KoeM004448;
        Mon, 15 May 2023 00:20:51 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj107yms7-2;
        Mon, 15 May 2023 00:20:51 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/4] locks: allow support for write delegation
Date:   Sun, 14 May 2023 17:20:35 -0700
Message-Id: <1684110038-11266-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150000
X-Proofpoint-GUID: wyBB5CgSwg5YueCHbljKNXvldyrNtGze
X-Proofpoint-ORIG-GUID: wyBB5CgSwg5YueCHbljKNXvldyrNtGze
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

First consumer is NFSD.

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

