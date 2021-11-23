Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E6845A1C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhKWLqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236409AbhKWLqB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:46:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD45561027;
        Tue, 23 Nov 2021 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637667773;
        bh=3HVKuOoJpQQVgeGCOA77s6WuBmYiiIXMZ2nXvsHh1VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHl26BhWYlBb5JX+OL8HYxgzM/t5wxwB5IRf7vjkgY5w7sM3fQBXrxJvjAXCkZ9u4
         G/N4kVwoleu/ldUZdSaoV7gyD4kHwYFJNggnw70ckqG+Df9wUx1pUNajGvNVRVU4y8
         1SUaNG0B7eu4ZRwYKrBFmtPHbMHGO7xksaBkLMrwHnWcxvCR+YBy0EYl8ZnpV+Enao
         hTZBK+CIq/Y+4NmnsWz7c8HbLTbk1MebgQyhoWVw8wb9d14B4IydCs5juo2ChJcSDR
         KWHz9buhGHw6Ne++2Utr00QUCtez5PFlIoALoulWijXdqF3v4M8HB9Lx/Tasyfzvn0
         VVGeNZ9U1iBcA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 03/10] fs: tweak fsuidgid_has_mapping()
Date:   Tue, 23 Nov 2021 12:42:20 +0100
Message-Id: <20211123114227.3124056-4-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123114227.3124056-1-brauner@kernel.org>
References: <20211123114227.3124056-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; h=from:subject; bh=BiM/wSu7WnhoUMqf8ScJVSixomvTuvNa162ansl70Wk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOuVxys+22a/XZWXNP2z/y1Foz6/Rm6ymFjr/505y/3rpq velcckcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE8v8w/LNns633MJ+pcfSGbkXjmd QlV33t/oSsbOYNqAhdl7CsVYKR4Z7W3W93Y+4IeDT3rV5e8/jNR/aza5NEDvz/mObXeIblJxsA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

If the caller's fs{g,u}id aren't mapped in the mount's idmapping we can
return early and skip the check whether the mapped fs{g,u}id also have a
mapping in the filesystem's idmapping. If the fs{g,u}id aren't mapped in
the mount's idmapping they consequently can't be mapped in the
filesystem's idmapping. So there's no point in checking that.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/fs.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index eb69e8b035fa..161b5936094e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1695,10 +1695,18 @@ static inline void inode_fsgid_set(struct inode *inode,
 static inline bool fsuidgid_has_mapping(struct super_block *sb,
 					struct user_namespace *mnt_userns)
 {
-	struct user_namespace *s_user_ns = sb->s_user_ns;
+	struct user_namespace *fs_userns = sb->s_user_ns;
+	kuid_t kuid;
+	kgid_t kgid;
 
-	return kuid_has_mapping(s_user_ns, mapped_fsuid(mnt_userns)) &&
-	       kgid_has_mapping(s_user_ns, mapped_fsgid(mnt_userns));
+	kuid = mapped_fsuid(mnt_userns);
+	if (!uid_valid(kuid))
+		return false;
+	kgid = mapped_fsgid(mnt_userns);
+	if (!gid_valid(kgid))
+		return false;
+	return kuid_has_mapping(fs_userns, kuid) &&
+	       kgid_has_mapping(fs_userns, kgid);
 }
 
 extern struct timespec64 current_time(struct inode *inode);
-- 
2.30.2

