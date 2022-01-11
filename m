Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6948B6CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350449AbiAKTQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350487AbiAKTQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53CAC034005;
        Tue, 11 Jan 2022 11:16:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86FBE61781;
        Tue, 11 Jan 2022 19:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B99C36AF3;
        Tue, 11 Jan 2022 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928583;
        bh=B0g0h3dcEw/uSuzRdZVXw0fmTbGqaV9mFGXOkKeGyhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LuJLwVFAZ2UylR67jVrGrAnpPLpm2jLhCs0BJWQGn5OewR1eAKVVrF21g6J0mOYpU
         MwTKZH7VCe0ArmMX7RBO7OLoNXgXaEJ+vKgoE180qNXplPljnaESfTBwJ56Wi0I+UD
         tlXtXr32cIFQ9K2cnjIrBBdzFvVhPYidVBnN8cZPIfMJfd62RTs3jnhVp4iAEN84Z6
         8tfZD17JK7SRjh0hGLpohusGsjodTv5HrNY/fvavDpdHxFsfJzjPp5TaTmJ3uHB+D4
         zND1DGHihSmlro/QHNhmNlq1Z/+HDr7A4b88CN37FDAM5oy3jWfYXW3rEllYy+4kL4
         Q+C/5OCQOjxgQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 17/48] ceph: properly set DCACHE_NOKEY_NAME flag in lookup
Date:   Tue, 11 Jan 2022 14:15:37 -0500
Message-Id: <20220111191608.88762-18-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is required so that we know to invalidate these dentries when the
directory is unlocked.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 288f6f0b4b74..4fa776d8fa53 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -751,6 +751,17 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	if (IS_ENCRYPTED(dir)) {
+		err = __fscrypt_prepare_readdir(dir);
+		if (err)
+			return ERR_PTR(err);
+		if (!fscrypt_has_encryption_key(dir)) {
+			spin_lock(&dentry->d_lock);
+			dentry->d_flags |= DCACHE_NOKEY_NAME;
+			spin_unlock(&dentry->d_lock);
+		}
+	}
+
 	/* can we conclude ENOENT locally? */
 	if (d_really_is_negative(dentry)) {
 		struct ceph_inode_info *ci = ceph_inode(dir);
-- 
2.34.1

