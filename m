Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C333C787F5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 07:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbjHYFie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 01:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjHYFiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:38:03 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F71BC2;
        Thu, 24 Aug 2023 22:38:00 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P4ffNE008796;
        Thu, 24 Aug 2023 22:37:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PPS06212021; bh=W0kBRV+hwLL8nmN1CEnpsNCRXsICS7stE9OWDLrPCRU=; b=
        UMlCtlKzF/EgFobXYXcjexr4g3Kg9Qr/b7XC1UoNXzSJ2yEz8aVbazqEW1q9dNLr
        FChA3jOSg45LcZqcsT2kC5zltsV9SzYhuIS7BM5QlbkkUvyFxQbaQilncMPpcgQ/
        Qu7Zl1/yM+GpAuRlB4gm28FTl/9IH+RE1KsV+J4sb4jap0S7rNQk61iniy/KBPgC
        CUXvp03lY7fYNlgofl0ivRT1JF/Ym36gUGJkuAVsbPVUIJnRKWomXz0tbEJlEsKL
        dxVth7vSm4VQqlPcJyVvBf/kD4Z7IeTHx3GPnk/I0acNMKc2K00gqoaa2hFloLkf
        yFsjQ1hZta/1CAF5oaok8A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sn20djumm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Aug 2023 22:37:35 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 22:37:34 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 22:37:32 -0700
From:   Lizhi Xu <lizhi.xu@windriver.com>
To:     <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>
CC:     <chao@kernel.org>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] f2fs: fix deadlock in f2f2_add_dentry
Date:   Fri, 25 Aug 2023 13:37:32 +0800
Message-ID: <20230825053732.3098387-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0000000000000f188605ffdd9cf8@google.com>
References: <0000000000000f188605ffdd9cf8@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: y5N4ZYVp_oaQ2GeQlb1tYlS30VuFONJi
X-Proofpoint-GUID: y5N4ZYVp_oaQ2GeQlb1tYlS30VuFONJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_04,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 mlxlogscore=411 priorityscore=1501 spamscore=0 impostorscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2308250047
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two paths:
1. f2fs_add_dentry->f2fs_down_read->f2fs_add_inline_entry->down_write->
   up_write->f2fs_up_read
2. f2fs_add_dentry->f2fs_add_regular_entry->down_write->
   f2fs_init_inode_metadata->f2fs_down_read->f2fs_up_read->up_write

Force order lock to read->write.

Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Reported-and-tested-by: syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com
---
 fs/f2fs/dir.c    | 4 +---
 fs/f2fs/inline.c | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d635c58cf5a3..022dc02c1390 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -736,12 +736,12 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
 	f2fs_wait_on_page_writeback(dentry_page, DATA, true, true);
 
 	if (inode) {
-		f2fs_down_write(&F2FS_I(inode)->i_sem);
 		page = f2fs_init_inode_metadata(inode, dir, fname, NULL);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			goto fail;
 		}
+		f2fs_down_write(&F2FS_I(inode)->i_sem);
 	}
 
 	make_dentry_ptr_block(NULL, &d, dentry_blk);
@@ -780,9 +780,7 @@ int f2fs_add_dentry(struct inode *dir, const struct f2fs_filename *fname,
 		 * Should get i_xattr_sem to keep the lock order:
 		 * i_xattr_sem -> inode_page lock used by f2fs_setxattr.
 		 */
-		f2fs_down_read(&F2FS_I(dir)->i_xattr_sem);
 		err = f2fs_add_inline_entry(dir, fname, inode, ino, mode);
-		f2fs_up_read(&F2FS_I(dir)->i_xattr_sem);
 	}
 	if (err == -EAGAIN)
 		err = f2fs_add_regular_entry(dir, fname, inode, ino, mode);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4638fee16a91..7618b383c2b7 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -628,10 +628,12 @@ int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
+	f2fs_down_read(&F2FS_I(dir)->i_xattr_sem);
 	inline_dentry = inline_data_addr(dir, ipage);
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
 
 	bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
+	f2fs_up_read(&F2FS_I(dir)->i_xattr_sem);
 	if (bit_pos >= d.max) {
 		err = do_convert_inline_dir(dir, ipage, inline_dentry);
 		if (err)
-- 
2.25.1

