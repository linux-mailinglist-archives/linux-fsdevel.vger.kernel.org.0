Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792DF48B6E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350816AbiAKTRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346523AbiAKTQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B814C033241;
        Tue, 11 Jan 2022 11:16:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEB2FB81D0E;
        Tue, 11 Jan 2022 19:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C37C36AE3;
        Tue, 11 Jan 2022 19:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928583;
        bh=IsYv2vTlaDVTS8PfYnvPFJmT533ELZeYPJkGgZEwP6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjIS63duKYURKWpQq4I8rxdSyVakKTo9y0kMLro4Q15jkMHpG6GRaUj+tlT3V8e4Z
         hCUB2HrSJ87zg/NbSDmTzLPeg627RZIIa1fz7Jo9Y4kywuvIEEHpwy87rBHougQyUr
         +PJo6DXZ9T2do7xhyNksL7KhMnEDzxert/czaPzZflskLw6ej+FYfeIJ5uJbfa7MeB
         TbvNMUYQGDCqkC1WE1FeEfbEPBnkwg30uA5Ha05c8EEJ21af6R0V9gYLQRu8SdtfMH
         wzW5wic+e08nNOFfFVag3btnuBhquZXWBExw+YWVE2pU1WZSm1ToyyOlkOqttVG5fW
         iySFalQxwmKeg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 18/48] ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
Date:   Tue, 11 Jan 2022 14:15:38 -0500
Message-Id: <20220111191608.88762-19-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
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
index 4fa776d8fa53..7977484d0317 100644
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
2.34.1

