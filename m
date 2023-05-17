Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5531707683
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 01:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjEQXjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 19:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEQXjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 19:39:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070A0115;
        Wed, 17 May 2023 16:39:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGwer024625;
        Wed, 17 May 2023 23:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=/N2LpwZMHf8t9rQO6kZ7l4/DJAl3DnwMVCbSh1H47sk=;
 b=ZLjwgRcy/SrYHTPJURS8adP2t23HWWd0m5UaEyqMXTh4GbwE0qpdFMXlGMmtjA9tlduj
 OZJTwI1ngCjgwKknzHbQxUwyooxwxJH5BhUZnpuqmvXLtDx6PsoM4bYbtydTn+vGSUAX
 q7jmmG7+rHrQh9njYZOkyxTZs70dsEPjAQxO1Eiqp++kIRx2Pee5aXVSFpBGvJUrqj/h
 HV5R/8M5zzlBe7yZBkDdbwC+jl7mzRzJdylzRJAkpAdWT1lvY4rnFuy3Ju+IDHUehjWU
 ZCX+oIFRRoSghJmiGaPZutPVrZAPjdBh9Ddko84QAKqXKl5lGxpJBTEtc9Tkq/a1PsyO Qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwphbyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 23:39:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HL3bPx032234;
        Wed, 17 May 2023 23:39:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10c3ukw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 23:39:12 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HNdABj015880;
        Wed, 17 May 2023 23:39:11 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10c3u5n-2;
        Wed, 17 May 2023 23:39:11 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/2] locks: allow support for write delegation
Date:   Wed, 17 May 2023 16:38:09 -0700
Message-Id: <1684366690-28029-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
References: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170194
X-Proofpoint-GUID: hwVoLBvuK7Xobr8yP2HYb17Olvo_auss
X-Proofpoint-ORIG-GUID: hwVoLBvuK7Xobr8yP2HYb17Olvo_auss
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

