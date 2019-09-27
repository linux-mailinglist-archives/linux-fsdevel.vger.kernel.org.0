Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B899BFE3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 06:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfI0Em5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 00:42:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfI0Emy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 00:42:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8R4gEXi101849
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2019 00:42:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9b6a8n1a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2019 00:42:53 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 27 Sep 2019 05:42:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Sep 2019 05:42:49 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8R4gl7740501280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 04:42:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4C075204E;
        Fri, 27 Sep 2019 04:42:47 +0000 (GMT)
Received: from dhcp-9-199-159-6.in.ibm.com (unknown [9.199.159.6])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6663352051;
        Fri, 27 Sep 2019 04:42:46 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        riteshh@linux.ibm.com
Subject: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
Date:   Fri, 27 Sep 2019 10:12:43 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092704-0012-0000-0000-000003512DB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092704-0013-0000-0000-0000218BC787
Message-Id: <20190927044243.18856-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=763 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270045
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
Acked-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/namei.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..7c5337cddebd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1617,7 +1617,21 @@ static int lookup_fast(struct nameidata *nd,
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

