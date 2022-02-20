Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3D4BCCDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 07:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbiBTGCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 01:02:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbiBTGCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:02:20 -0500
X-Greylist: delayed 154954 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Feb 2022 22:01:58 PST
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA76F63
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 22:01:56 -0800 (PST)
X-QQ-mid: bizesmtp76t1645336893tmnmssis
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:01:27 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: HoyAXBWgsklMLx45Q65e9S1zIxrVT15UuJ2vKorwsFn98tS8WzQL3Ja3N5+YS
        uCEmB4z3YaBlyXfs4A1mikfBwd4xOHC+I7wNiSQtrEAvnG9MKqTP3NKRXIsoOaX1M4MQfzW
        CvP58Tlf4BfpiNkohfbUrnJMD8E1M/5aJRCWoTSIr1/QiPtivA/HtsXJxOlZPVrJ2/2g0gq
        ctA3erE5waMiZGa5L0gvdl2GFjZExQl0GKnzkqDD992KrR5pD0vYy//uzIiMcASfSlAjXNR
        uiGdDMgCdckwUm5d/hdmGlveNxGlZOomroS5Z8HpQwQOvlM/hmQocQ+4n0zolqJM12bscP8
        o/f2wU1j6Cy8WRV/UBI9VFWCpuKqI+BGFHv5DGA
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mike.kravetz@oracle.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 07/11] fs/hugetlbfs: move hugetlibfs sysctls to its own file
Date:   Sun, 20 Feb 2022 14:01:25 +0800
Message-Id: <20220220060125.13904-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we
just care about the core logic.

All filesystem syctls now get reviewed by fs folks. This commit
follows the commit of fs, move the hugetlbfs sysctls to its own file,
fs/hugetlbfs/inode.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 fs/hugetlbfs/inode.c    | 21 ++++++++++++++++++++-
 include/linux/hugetlb.h |  1 -
 kernel/sysctl.c         |  7 -------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a7c6c7498be0..3f386d9d8ad3 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -62,7 +62,26 @@ struct hugetlbfs_fs_context {
 	umode_t			mode;
 };
 
-int sysctl_hugetlb_shm_group;
+static int sysctl_hugetlb_shm_group;
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_SYSCTL)
+static struct ctl_table vm_hugetlbfs_table[] = {
+	{
+		.procname       = "hugetlb_shm_group",
+		.data           = &sysctl_hugetlb_shm_group,
+		.maxlen         = sizeof(gid_t),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{ }
+};
+
+static __init int vm_hugetlbfs_sysctls_init(void)
+{
+	register_sysctl_init("vm", vm_hugetlbfs_table);
+	return 0;
+}
+late_initcall(vm_hugetlbfs_sysctls_init);
+#endif
 
 enum hugetlb_param {
 	Opt_gid,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d1897a69c540..f307e1963851 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -181,7 +181,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
-extern int sysctl_hugetlb_shm_group;
 extern struct list_head huge_boot_pages;
 
 /* arch callbacks */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 31f2c6e21392..dc5e313c9e6b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2193,13 +2193,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler   = &hugetlb_mempolicy_sysctl_handler,
 	},
 #endif
-	 {
-		.procname	= "hugetlb_shm_group",
-		.data		= &sysctl_hugetlb_shm_group,
-		.maxlen		= sizeof(gid_t),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	 },
 	{
 		.procname	= "nr_overcommit_hugepages",
 		.data		= NULL,
-- 
2.20.1



