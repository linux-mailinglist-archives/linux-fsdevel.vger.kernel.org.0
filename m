Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF970CF09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 02:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjEWAYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 20:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjEVX4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 19:56:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761692128;
        Mon, 22 May 2023 16:52:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNuIB019632;
        Mon, 22 May 2023 23:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=/N2LpwZMHf8t9rQO6kZ7l4/DJAl3DnwMVCbSh1H47sk=;
 b=1IEseT7IyF+uW70NfXFKjWbwz6zKuWfL4Iuc4iCrhD3thRwlP7CeN9PJChjcTwbMJ4xO
 x6HOgWtGymG7IHxwPprc3FBhzhyI3R14BFblqiBsV0co4pc0H4UHnjToA6vbb9MHV+Wt
 dJieTk81ELtH2JXypoq4irLKI58jMFhhNQp7t9HpRxo0W5D9UvagpjuklwLglDwQuekP
 sOIJIbv1LW4oEbwWn9CyBz7Q3iZ+g/RSHiIOHF4FZ14c/A4FjzEI7pzOH3Qb2QytG09g
 tpPJfkLfoJ3NShIDZkUENuiNcLTRoitq2jmxvmPj2iz/RLXU+TGMYcpzBi7STK2M0s/i hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cbxqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:52:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLagYP013996;
        Mon, 22 May 2023 23:52:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7e43wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:52:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MNqqh3018982;
        Mon, 22 May 2023 23:52:54 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qqk7e43vc-4;
        Mon, 22 May 2023 23:52:54 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 3/3] locks: allow support for write delegation
Date:   Mon, 22 May 2023 16:52:40 -0700
Message-Id: <1684799560-31663-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_17,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220201
X-Proofpoint-ORIG-GUID: bZUU06QhhgBAJ5HlQcp5qEoPkWi9On9u
X-Proofpoint-GUID: bZUU06QhhgBAJ5HlQcp5qEoPkWi9On9u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

