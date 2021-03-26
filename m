Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E219B34AD86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCZRcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhCZRci (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:32:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0DDC61A13;
        Fri, 26 Mar 2021 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616779958;
        bh=ud3VlsFzXj31hbkoI2f92qpjTf5SVeZ0QpXGNvnnVyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qzj1JsXhb9ri8o4eXPZvKCj/x8j+jxRKov2rjVPuFaMnZ6jt/leldHr7CCh7WHKOP
         UnNeDhfPgKcZi2WbFH1KbUB7Qth2sXAdb8OHc3CMSnU7TqCMQDduSpMq45eNQhLmtT
         fCL93kE+blbfvXi1KVJolJaEJ1pZQ8X7VY07U1sWobTVXbfyficBfvIr7mjcrx9qcu
         IgPy3TfMpfg5g94seIhiKm9g00V3aZ788Q6aMFvz54wQ/50F7LnswkH+T3Ny/JB1Lv
         anaDV2RCwcI6nnnYjGc2BKNPXSVGA72yw4yz9IwSzL9hj2HjZvhExWGizfieN//xc6
         hmCypBeqRaiDQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v5 13/19] ceph: properly set DCACHE_NOKEY_NAME flag in lookup
Date:   Fri, 26 Mar 2021 13:32:21 -0400
Message-Id: <20210326173227.96363-14-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 496d24b003dd..72728850e96c 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -755,6 +755,17 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
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
2.30.2

