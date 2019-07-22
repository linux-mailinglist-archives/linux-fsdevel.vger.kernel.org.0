Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E086FF4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 14:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfGVMLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 08:11:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:23024 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfGVMLO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:11:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 05:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,295,1559545200"; 
   d="scan'208";a="180378524"
Received: from khuang2-desk.gar.corp.intel.com ([10.254.182.119])
  by orsmga002.jf.intel.com with ESMTP; 22 Jul 2019 05:11:12 -0700
From:   Kai Huang <kai.huang@linux.intel.com>
To:     viro@ZenIV.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@linux.intel.com>
Subject: [PATCH] anon_inodes: remove redundant file->f_mapping initialization
Date:   Tue, 23 Jul 2019 00:09:58 +1200
Message-Id: <20190722120958.9179-1-kai.huang@linux.intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In anon_inode_getfile(), file->f_mapping is redundantly initialized to
anon_inode_inode->i_mapping, since it has already been initialized in
alloc_file_pseudo() -> alloc_file(), so remove the initialization in
anon_inode_getfile().

Signed-off-by: Kai Huang <kai.huang@linux.intel.com>
---
 fs/anon_inodes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 89714308c25b..b8b77066a1b9 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -93,8 +93,6 @@ struct file *anon_inode_getfile(const char *name,
 	if (IS_ERR(file))
 		goto err;
 
-	file->f_mapping = anon_inode_inode->i_mapping;
-
 	file->private_data = priv;
 
 	return file;
-- 
2.13.6

