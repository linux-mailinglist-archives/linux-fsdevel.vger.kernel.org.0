Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A996134AD88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhCZRc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhCZRcj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:32:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7159361999;
        Fri, 26 Mar 2021 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616779958;
        bh=txA1YUye09KqfbmVs0VBQwSMiAzyb4sJGcW6VErNpVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Czf42N8K79+5yxRALW8S1lhTrxKdhtpxJ9l+tenDLa8Sl4Z1Xf+yRthp9Tttvbyi2
         w7gdM6BB/2JZ7TAsyuXqSOXvPncbLvUWPncLR1j0HSzBZl/Klx9bzSFSeZRK16OVof
         KFuv9bwkl1ghIXHc3EZmqTSbQ2BsiEGNz6ihHLAPnytZPPoF0VFmXsueDX9Aj6os8r
         rBsOuEvZbXP4cj8qrzDfagxxUia1JbvyWED6HkMJwCqfWp9ZnUv/tREuJAtLoDbsyu
         w57zt1IOi+mR7V3mj4aPgJJd2UNgIeTFxB7NBqc3SYUCGrTNCXfX3bbMG0+zdaz7X2
         /YnJTsno2CDDw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v5 14/19] ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
Date:   Fri, 26 Mar 2021 13:32:22 -0400
Message-Id: <20210326173227.96363-15-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we have a dentry which represents a no-key name, then we need to test
whether the parent directory's encryption key has since been added.  Do
that before we test anything else about the dentry.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 72728850e96c..867e396f44f1 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1697,6 +1697,10 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	struct inode *dir, *inode;
 	struct ceph_mds_client *mdsc;
 
+	valid = fscrypt_d_revalidate(dentry, flags);
+	if (valid <= 0)
+		return valid;
+
 	if (flags & LOOKUP_RCU) {
 		parent = READ_ONCE(dentry->d_parent);
 		dir = d_inode_rcu(parent);
@@ -1709,8 +1713,8 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 		inode = d_inode(dentry);
 	}
 
-	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
-	     dentry, inode, ceph_dentry(dentry)->offset);
+	dout("d_revalidate %p '%pd' inode %p offset 0x%llx nokey %d\n", dentry,
+	     dentry, inode, ceph_dentry(dentry)->offset, !!(dentry->d_flags & DCACHE_NOKEY_NAME));
 
 	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
 
-- 
2.30.2

