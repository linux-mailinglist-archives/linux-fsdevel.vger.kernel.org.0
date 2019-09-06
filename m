Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42FE5ABA01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393774AbfIFN4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 09:56:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388097AbfIFN4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:56:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x86DqYHq051512
        for <linux-fsdevel@vger.kernel.org>; Fri, 6 Sep 2019 09:56:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uuq9sbrwy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 09:56:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 6 Sep 2019 14:56:30 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Sep 2019 14:56:28 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x86DuOcU54591668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Sep 2019 13:56:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD75AA405E;
        Fri,  6 Sep 2019 13:56:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96A3CA405D;
        Fri,  6 Sep 2019 13:56:23 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.31.57])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Sep 2019 13:56:23 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jlayton@kernel.org, viro@zeniv.linux.org.uk
Cc:     hsiangkao@aol.com, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, wugyuan@cn.ibm.com,
        riteshh@linux.ibm.com
Subject: [PATCH 1/1] vfs: Really check for inode ptr in lookup_fast
Date:   Fri,  6 Sep 2019 19:26:21 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090613-4275-0000-0000-00000361FAD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090613-4276-0000-0000-0000387446C0
Message-Id: <20190906135621.16410-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909060148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

d_is_negative can race with d_instantiate_new()
-> __d_set_inode_and_type().
For e.g. in use cases where Thread-1 is creating
symlink (doing d_instantiate_new()) & Thread-2 is doing
cat of that symlink while doing lookup_fast (via REF-walk-
one such case is, when ->permission returns -ECHILD).

During this race if __d_set_and_inode_type() does out-of-order
execution and set the dentry->d_flags before setting
dentry->inode, then it can result into following kernel panic.

This change fixes the issue by directly checking for inode.

E.g. kernel panic, since inode was NULL.
trailing_symlink() -> may_follow_link() -> inode->i_uid.
Issue signature:-
  [NIP  : trailing_symlink+80]
  [LR   : trailing_symlink+1092]
  #4 [c00000198069bb70] trailing_symlink at c0000000004bae60  (unreliable)
  #5 [c00000198069bc00] path_openat at c0000000004bdd14
  #6 [c00000198069bc90] do_filp_open at c0000000004c0274
  #7 [c00000198069bdb0] do_sys_open at c00000000049b248
  #8 [c00000198069be30] system_call at c00000000000b388

Sequence of events:-
Thread-2(Comm: ln) 	       Thread-1(Comm: cat)

	                dentry = __d_lookup() //nonRCU

__d_set_and_inode_type() (Out-of-order execution)
    flags = READ_ONCE(dentry->d_flags);
    flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
    flags |= type_flags;
    WRITE_ONCE(dentry->d_flags, flags);

	                if (unlikely(d_is_negative()) // fails
	                       {}
	                // since d_flags is already updated in
	                // Thread-2 in parallel but inode
	                // not yet set.
	                // d_is_negative returns false

	                *inode = d_backing_inode(path->dentry);
	                // means inode is still NULL

    dentry->d_inode = inode;

	                trailing_symlink()
	                    may_follow_link()
	                        inode = nd->link_inode;
	                        // nd->link_inode = NULL
	                        //Then it crashes while
	                        //doing inode->i_uid

Reported-by: Guang Yuan Wu <wugyuan@cn.ibm.com>
Tested-by: Guang Yuan Wu <wugyuan@cn.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/namei.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 209c51a5226c..b5867fe988e0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1623,7 +1623,21 @@ static int lookup_fast(struct nameidata *nd,
 		dput(dentry);
 		return status;
 	}
-	if (unlikely(d_is_negative(dentry))) {
+
+	/*
+	 * Caution: d_is_negative() can race with
+	 * __d_set_inode_and_type().
+	 * For e.g. in use cases where Thread-1 is creating
+	 * symlink (doing d_instantiate_new()) & Thread-2 is doing
+	 * cat of that symlink and falling here (via Ref-walk) while
+	 * doing lookup_fast (one such case is when ->permission
+	 * returns -ECHILD).
+	 * Now if __d_set_inode_and_type() does out-of-order execution
+	 * i.e. it first sets the dentry->d_flags & then dentry->inode
+	 * then it can result into inode being NULL, causing panic later.
+	 * Hence directly check if inode is NULL here.
+	 */
+	if (unlikely(d_really_is_negative(dentry))) {
 		dput(dentry);
 		return -ENOENT;
 	}
-- 
2.21.0

