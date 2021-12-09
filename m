Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE6E46EBA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhLIPkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhLIPkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AA5C0617A2;
        Thu,  9 Dec 2021 07:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7A93B82511;
        Thu,  9 Dec 2021 15:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6D1C341C7;
        Thu,  9 Dec 2021 15:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064222;
        bh=gKS6fs1idM3r8FcKrhO3rMe5mQ/IS9zDL2VKZ7paegA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvMqHPTPeutxmPW/5YnrW8urvGIhAsAwDgQKmLu/l6qGAty1RFnDTBrzqoFFSoQSA
         LZ5A4AXbJuVJeBOut1t0oitdyPMado+XRtYhX1/Vf9O0V9bIFPhNg2SurvMr+x1yTu
         nOs8l++MRUnVaGLIIK4W1FhEMaMhDb7TsWmLNmVSCOStdAacc/0V+osCrf40NW91jW
         2fgjrZPM5/B/2kJKs+sypWlslLl/3hrpUSN9aHWhnBpY5w9HeVrhaQRndrYiND9vOa
         OhFSXuqAUdI2sox6TIEkaMHnSp0xqedf+Es1E0ae/RLjRQcPJ6m6diTs5E5ixmacb8
         ePPrXSnhFnhNA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/36] ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
Date:   Thu,  9 Dec 2021 10:36:30 -0500
Message-Id: <20211209153647.58953-20-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
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
2.33.1

