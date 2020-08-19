Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485B7249848
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 10:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHSIdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 04:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgHSIdJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:33:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE4B20772;
        Wed, 19 Aug 2020 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597825988;
        bh=KU8VLF79bhQTCzQXXN9H8OZHwlDn6KKht6tavPyIl3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=PcqTf5VHcbuId2XaVZ1YeNooY9oBdbdwwMc2tvuZYo8e6DOi++Qr9pU9lbIIKpT08
         5oGW5GXYAVZ3useuKbpdGnKr67wTxO0/INvrZmut4t7Cox6abcceg7/OnzoQD4Jb8i
         yJHjHZXrEDfE49XG3sNV7hk+nNrzIkvvLG6cvP44=
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Add function declaration of simple_dname
Date:   Wed, 19 Aug 2020 11:32:59 +0300
Message-Id: <20200819083259.919838-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The simple_dname() is declared in internal header file as extern
and this generates the following GCC warning.

fs/d_path.c:311:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
  311 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
      |       ^~~~~~~~~~~~

Instead of that extern, reuse the fact that internal.h file is internal to fs/* and
declare simple_dname() like any other function.

Fixes: 7e5f7bb08b8c ("unexport simple_dname()")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 fs/d_path.c   | 2 ++
 fs/internal.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 0f1fc1743302..4b89448cc78e 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -8,6 +8,8 @@
 #include <linux/prefetch.h>
 #include "mount.h"

+#include "internal.h"
+
 static int prepend(char **buffer, int *buflen, const char *str, int namelen)
 {
 	*buflen -= namelen;
diff --git a/fs/internal.h b/fs/internal.h
index 10517ece4516..2def264272f4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -164,7 +164,7 @@ extern int d_set_mounted(struct dentry *dentry);
 extern long prune_dcache_sb(struct super_block *sb, struct shrink_control *sc);
 extern struct dentry *d_alloc_cursor(struct dentry *);
 extern struct dentry * d_alloc_pseudo(struct super_block *, const struct qstr *);
-extern char *simple_dname(struct dentry *, char *, int);
+char *simple_dname(struct dentry *d, char *buf, int len);
 extern void dput_to_list(struct dentry *, struct list_head *);
 extern void shrink_dentry_list(struct list_head *);

--
2.26.2

