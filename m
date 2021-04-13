Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E2335E587
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 19:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347367AbhDMRve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 13:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347416AbhDMRvX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:51:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB165613BB;
        Tue, 13 Apr 2021 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618336263;
        bh=txA1YUye09KqfbmVs0VBQwSMiAzyb4sJGcW6VErNpVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCvzch7qXWsUNDVEuif6a2U00exZsecflOcUXSo+q8IU7tR8yLi2g3mbTOKPfas0i
         F6xTVGt4l4vB1eDWXurMdsyG6wHCzPnCU4Up2tZkZiYIY12X2UBPcb13nlbAFRj/n6
         yxxM7ihp+JtnBnZOiS4IvrCidHKaB4J1imSCaiqAEvaNnS6cy9GQ5AE3QihOmuSCdW
         0bkFW3NO3wP8fy4wM7ja4/DpPbNS9jK3MIGs3NokoZ7yNpv8ibU7/hsfUIolHepDhX
         wnxsMAwmnKNr4jEqmpk6cICOPfVUmE2tkyso34E2be4+jTOMChAE/7B2d7oRVqDwCB
         9ytYNgTG9Jp+A==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v6 14/20] ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
Date:   Tue, 13 Apr 2021 13:50:46 -0400
Message-Id: <20210413175052.163865-15-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413175052.163865-1-jlayton@kernel.org>
References: <20210413175052.163865-1-jlayton@kernel.org>
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

