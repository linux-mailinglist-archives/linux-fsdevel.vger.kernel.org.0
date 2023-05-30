Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B844071536F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 04:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjE3CIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 22:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjE3CIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 22:08:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0574E5;
        Mon, 29 May 2023 19:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685412486; x=1716948486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=reNeQez1F7r8ZGoYnYWNc9HF8+Nb54iuzqiK4gjVInk=;
  b=RvI0vc8nvPDXh9OLIdtAIF7/GgaoafLv076/HcdN4WE/vzhr6dz1oA3m
   PhDlBq35suDKVciCo75k6z7s+c/+UaKtluCJIEORY1e96+tkWN9AW5e4A
   C2VD8SwJ3Zn+pmM/gWBMhvYfVS0BE29hO4WwgIia5chBqRlENtWeVUj+E
   fg1bocAL2cVIDs/GTin1saCL9sPw3E+rb6ycPBSZM01sAmH9IKViLE+at
   FmhJqxKHTFfR+JuWFwgNhRUkjhC6a5kG5A0zasbHRMm5ELMHaiwAcvJ96
   IDIzNF1PzytQvEd86UrQ+yCZXhr3Aa/qxr7haxWXFVUWIxSVb32ePMhnM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="354812291"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="354812291"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 19:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="952923391"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="952923391"
Received: from crt-e302.sh.intel.com (HELO localhost.localdomain) ([10.239.45.181])
  by fmsmga006.fm.intel.com with ESMTP; 29 May 2023 19:06:53 -0700
From:   chenzhiyin <zhiyin.chen@intel.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nanhai.zou@intel.com, zhiyin.chen@intel.com
Subject: [PATCH] fs.h: Optimize file struct to prevent false sharing
Date:   Mon, 29 May 2023 22:06:26 -0400
Message-Id: <20230530020626.186192-1-zhiyin.chen@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the syscall test of UnixBench, performance regression occurred
due to false sharing.

The lock and atomic members, including file::f_lock, file::f_count
and file::f_pos_lock are highly contended and frequently updated
in the high-concurrency test scenarios. perf c2c indentified one
affected read access, file::f_op.
To prevent false sharing, the layout of file struct is changed as
following
(A) f_lock, f_count and f_pos_lock are put together to share the
same cache line.
(B) The read mostly members, including f_path, f_inode, f_op are
put into a separate cache line.
(C) f_mode is put together with f_count, since they are used
frequently at the same time.

The optimization has been validated in the syscall test of
UnixBench. performance gain is 30~50%, when the number of parallel
jobs is 16.

Signed-off-by: chenzhiyin <zhiyin.chen@intel.com>
---
 include/linux/fs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..01c55e3a1b96 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -962,23 +962,23 @@ struct file {
 		struct rcu_head 	f_rcuhead;
 		unsigned int 		f_iocb_flags;
 	};
-	struct path		f_path;
-	struct inode		*f_inode;	/* cached value */
-	const struct file_operations	*f_op;
 
 	/*
 	 * Protects f_ep, f_flags.
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
-	atomic_long_t		f_count;
-	unsigned int 		f_flags;
 	fmode_t			f_mode;
+	atomic_long_t		f_count;
 	struct mutex		f_pos_lock;
+	unsigned int		f_flags;
 	loff_t			f_pos;
 	struct fown_struct	f_owner;
 	const struct cred	*f_cred;
 	struct file_ra_state	f_ra;
+	struct path		f_path;
+	struct inode		*f_inode;	/* cached value */
+	const struct file_operations	*f_op;
 
 	u64			f_version;
 #ifdef CONFIG_SECURITY
-- 
2.39.1

