Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1F3B451D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhFYOBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 10:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231926AbhFYOBK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:01:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 551CB61988;
        Fri, 25 Jun 2021 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624629529;
        bh=JU4DQ7j7wrJ8iMCOP/TiRnqcZf1DzonMo6IsxnCfnlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ev87Zpa6DQP8tccz4vkwQ+bYxOvJ+g16fICXFXKUbkV0a0kZO8MvTlsp7aZetDias
         Otw0woYjGvTz9iNVGqGMCO67r484DL+OVYTYYKVHJst8Gl4jnlIENi1WjR2u068iuU
         ySS5NxO2a8dx1myBOPyccYzbY0PCsWTPJaQ97JSb3B3pnDJHZ2xLjFUchOMIz8TYgb
         oqYrIS7fL+VYxnmaeqetPwO9b0SvegtS1TtcOGxU2mGSaBeKiPVcnJqSXHcyy5z54U
         AOEUjtYCOKd8kslIOa7sI01dpj6G6UA9TPKVISEdJaL3b04w3ZOXPFQEmrlSCuoZdg
         RW38OUyINiFkQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: [RFC PATCH v7 18/24] ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
Date:   Fri, 25 Jun 2021 09:58:28 -0400
Message-Id: <20210625135834.12934-19-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625135834.12934-1-jlayton@kernel.org>
References: <20210625135834.12934-1-jlayton@kernel.org>
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
index 7d6ad4ea535c..7a795e409007 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1700,6 +1700,10 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	struct inode *dir, *inode;
 	struct ceph_mds_client *mdsc;
 
+	valid = fscrypt_d_revalidate(dentry, flags);
+	if (valid <= 0)
+		return valid;
+
 	if (flags & LOOKUP_RCU) {
 		parent = READ_ONCE(dentry->d_parent);
 		dir = d_inode_rcu(parent);
@@ -1712,8 +1716,8 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 		inode = d_inode(dentry);
 	}
 
-	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
-	     dentry, inode, ceph_dentry(dentry)->offset);
+	dout("d_revalidate %p '%pd' inode %p offset 0x%llx nokey %d\n", dentry,
+	     dentry, inode, ceph_dentry(dentry)->offset, !!(dentry->d_flags & DCACHE_NOKEY_NAME));
 
 	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
 
-- 
2.31.1

