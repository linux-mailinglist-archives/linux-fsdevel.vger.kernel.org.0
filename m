Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA06B2266
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 12:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCILPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 06:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjCILOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:14:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BFB5CEDF;
        Thu,  9 Mar 2023 03:09:51 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3297eaCY029057;
        Thu, 9 Mar 2023 11:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=rz8j261A9Wi0V/X/gjXk1TIqRxkLG+PIYby2YrHDAwk=;
 b=A1kd8vcZKA98SyiXXMhbYgbcWley/+IlVK08p9w2F1mpCQPRbHWK4D3Pap3wYikNUoDr
 DbCfvL0MHVxvKUHDKCdJPiVOLM1iabibCNJWqF0017hpQuvtMKHkj50yLfu+YkNffGsq
 iMp4J0RnuIUxGEJ/yHcRikeizYEwK8vwdb2Y2OBCc3afasXDesYKmeOm2UMPz2sRedg5
 eaiTDB8tbn8V65S8SBUp/O+NfXXCpWJW1DH2MXCWZw6TcNYiYS98GReRlU7mYPx2Ue3O
 MsfFkp3HVEzpU0gqk6yycpRZ2O2qx2CWHaWzI2IHKEdd9SicGKBHkXaEWUzih/A0+LYz Uw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wte22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 11:09:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 329A8fAF020892;
        Thu, 9 Mar 2023 11:09:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fu9b751-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 11:09:38 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329B70tI021817;
        Thu, 9 Mar 2023 11:09:37 GMT
Received: from localhost.localdomain (dhcp-10-191-129-247.vpn.oracle.com [10.191.129.247])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6fu9b73f-1;
        Thu, 09 Mar 2023 11:09:37 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joe.jin@oracle.com
Subject: [PATCH v2 0/3] kernfs: Introduce separate rwsem to protect inode
Date:   Thu,  9 Mar 2023 22:09:29 +1100
Message-Id: <20230309110932.2889010-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_06,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=945 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090088
X-Proofpoint-GUID: ZY2tDRDO6Gu-9pcDu8YRtDbpwfoyj2IJ
X-Proofpoint-ORIG-GUID: ZY2tDRDO6Gu-9pcDu8YRtDbpwfoyj2IJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since v1:
 - Remove kernfs_rwsem from kernfs_notify_workfn
 - Include Matthew's "Reviewed-by" tag for Patch-3
-------------------------------------------------------------------
Original cover letter

This change set is consolidating the changes discussed and/or mentioned
in [1] and [2]. I have not received any feedback about any of the
patches included in this change set, so I am rebasing them on current
linux-next tip and bringing them all in one place.

As mentioned in [1], since changing per-fs kernfs_rwsem into a hashed
rwsem is not working for all scenarios, PATCH-1 here tries to address
the same issue with the help of another newly introduced per-fs rwsem.
PATCH-2 and PATCH-3 are basically resend of PATCH-1 and PATCH-2
respectively in [2].

It would be really helpful if I could get some feedback about this
changeset so that we can reduce the kernfs_rwsem contention and make
sysfs access more scalable for large-scale systems.

The patches in this change set are as follows:

PATCH-1: kernfs: Introduce separate rwsem to protect inode attributes.

PATCH-2: kernfs: Use a per-fs rwsem to protect per-fs list of
kernfs_super_info.

PATCH-3: kernfs: change kernfs_rename_lock into a read-write lock.

Imran Khan (3):
  kernfs: Introduce separate rwsem to protect inode attributes.
  Use a per-fs rwsem to protect per-fs list of kernfs_super_info.
  kernfs: change kernfs_rename_lock into a read-write lock.

 fs/kernfs/dir.c             | 26 +++++++++++++++++---------
 fs/kernfs/file.c            |  2 ++
 fs/kernfs/inode.c           | 16 ++++++++--------
 fs/kernfs/kernfs-internal.h |  2 ++
 fs/kernfs/mount.c           |  8 ++++----
 5 files changed, 33 insertions(+), 21 deletions(-)


base-commit: 7f7a8831520f12a3cf894b0627641fad33971221

[1]:https://lore.kernel.org/all/74969b22-e0b6-30bd-a1f0-132f4b8485cf@oracle.com/
[2]:https://lore.kernel.org/all/20220810111017.2267160-1-imran.f.khan@oracle.com/
-------------------------------------------------------------------

Imran Khan (3):
  kernfs: Introduce separate rwsem to protect inode attributes.
  kernfs: Use a per-fs rwsem to protect per-fs list of
    kernfs_super_info.
  kernfs: change kernfs_rename_lock into a read-write lock.

 fs/kernfs/dir.c             | 26 +++++++++++++++++---------
 fs/kernfs/file.c            |  4 ++--
 fs/kernfs/inode.c           | 16 ++++++++--------
 fs/kernfs/kernfs-internal.h |  2 ++
 fs/kernfs/mount.c           |  8 ++++----
 5 files changed, 33 insertions(+), 23 deletions(-)

-- 
2.34.1

