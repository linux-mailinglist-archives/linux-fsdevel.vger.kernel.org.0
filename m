Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD4142845D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 02:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhJKAvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Oct 2021 20:51:22 -0400
Received: from foss.arm.com ([217.140.110.172]:40442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhJKAvW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Oct 2021 20:51:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D92CA1063;
        Sun, 10 Oct 2021 17:49:22 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49BB93F66F;
        Sun, 10 Oct 2021 17:49:21 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia He <justin.he@arm.com>
Subject: [PATCH] d_path: Fix Kernel doc validator complaining
Date:   Mon, 11 Oct 2021 08:49:12 +0800
Message-Id: <20211011004912.25954-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kernel doc validator complains:
  Function parameter or member 'p' not described in 'prepend_name'
  Excess function parameter 'buffer' description in 'prepend_name'

Fixes: ad08ae586586e ("d_path: introduce struct prepend_buffer")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/d_path.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 23a53f7b5c71..4eb31f86ca88 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -33,9 +33,8 @@ static void prepend(struct prepend_buffer *p, const char *str, int namelen)
 
 /**
  * prepend_name - prepend a pathname in front of current buffer pointer
- * @buffer: buffer pointer
- * @buflen: allocated length of the buffer
- * @name:   name string and length qstr structure
+ * @p: prepend buffer which contains buffer pointer and allocated length
+ * @name: name string and length qstr structure
  *
  * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to
  * make sure that either the old or the new name pointer and length are
@@ -108,8 +107,7 @@ static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
  * prepend_path - Prepend path string to a buffer
  * @path: the dentry/vfsmount to report
  * @root: root vfsmnt/dentry
- * @buffer: pointer to the end of the buffer
- * @buflen: pointer to buffer length
+ * @p: prepend buffer which contains buffer pointer and allocated length
  *
  * The function will first try to write out the pathname without taking any
  * lock other than the RCU read lock to make sure that dentries won't go away.
-- 
2.17.1

