Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61682FD875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbhATSfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404560AbhATSam (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:30:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B36EF233FC;
        Wed, 20 Jan 2021 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167339;
        bh=ntuOc4aKlT0wMcHSt6IL/piAyoR1etQFX/8sCIThbNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=McA4hoXO6oXe0QENGNSK8o5aXrO5f7bCjz4i0O8xB8wMJl3wHyvkkmMbl+sL5V1F1
         gDZ/Unp/Yq37O2j+lfSF+1fVlSWWN1croCNvG9tNSuuH0T+bE1Zu1lBdF/0A99/xln
         NfZRiRoNyqTlvlvIDjLMtWfR9bHwYTAR34zY3tVIGJoSObcbXVOAk55kz103dr+HTo
         3ur2w5/AGkOL8mmD0pADMigxWspyAoSBvUwMLLw6GM+l3o3ZBrF3kC7mITKzQ+qaSv
         LDVmjdt31SUCgoCrsqmtIvHH1ehJBy8FnE8kEHYZTTiCY9d+lK9Dnc7Sh7qHQKr7FS
         FbL7zEqNhiM5g==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v4 15/17] ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
Date:   Wed, 20 Jan 2021 13:28:45 -0500
Message-Id: <20210120182847.644850-16-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120182847.644850-1-jlayton@kernel.org>
References: <20210120182847.644850-1-jlayton@kernel.org>
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
 fs/ceph/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 236c381ab6bd..cb7ff91a243a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1726,6 +1726,10 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
 	     dentry, inode, ceph_dentry(dentry)->offset);
 
+	valid = fscrypt_d_revalidate(dentry, flags);
+	if (valid <= 0)
+		return valid;
+
 	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
-- 
2.29.2

