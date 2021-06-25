Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EC23B451A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhFYOB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 10:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231910AbhFYOBJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:01:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A36261983;
        Fri, 25 Jun 2021 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624629529;
        bh=uX3ne2cypS522y5/rW71ET0LOe7I9WQS6dyKA9+UizQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEmycPc9KB9L+xj0dD/4jMi2HZzbjvjV3qEHu/qrXZF9ozad0s5MZyeXNB5El6DYm
         UKVALLDSqhIBsvNLkliJJaH26ocWJH0lun15e5vIj5sLCpBxdFOwoEA6e+CiaLpHRJ
         ucPnusdFtjun1e0O6nTpYTLXvYvk2uXJg90VqdeBWwYW6s43N2QKtofpRgInEbxkDb
         7Ic1gjQefU9YbQsgkeYtkTOsLF7uHzbonF9dNzKFWxYyAayJyO32ERwyUgJ3qLFc06
         vV/ZcB8l5G0gkCYQIUv5MFyKNQMXIPPOpPvd9FLL9VFZdgmXJ7hycD/BwZL21r4Knu
         Y6MspIiedLCuw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: [RFC PATCH v7 17/24] ceph: properly set DCACHE_NOKEY_NAME flag in lookup
Date:   Fri, 25 Jun 2021 09:58:27 -0400
Message-Id: <20210625135834.12934-18-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625135834.12934-1-jlayton@kernel.org>
References: <20210625135834.12934-1-jlayton@kernel.org>
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
index 8b6a1c960afa..7d6ad4ea535c 100644
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
2.31.1

