Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26B348B699
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbiAKTQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36056 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346070AbiAKTQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F6361781;
        Tue, 11 Jan 2022 19:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E636C36AE9;
        Tue, 11 Jan 2022 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928571;
        bh=wBtusvHU44/C2xK9J4VYRbtE2GczF4MQEKrZ50T4/0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvOa2qK0PzPzayct3oE0c16ZYZLFh+dWq1rT6zZkoeX0vmbDZMJ9pJReB4disBHEO
         a9fGoySgwkfEH96VICtHXhB+LfHrJcvWraAwCBIbgclAM1LQe/zH93cCB7xyNQ1QPS
         O8ntBaaVQ1QRgXCS5RQ1Jrvq9kWJlLbQP2c3aAv0boMCodOB6yI2DuOyBS1TGZXaha
         L+oLSdjKSertLgcGIR0MRQrUBaWpempnKigHJu4gg2FwQb8FB1f5s+fneIAP2WmeUL
         stE39XbaRtDU1E9Iwb9hW7F0VruMyzGeh7NdwdOOGhsbmpsR6KEc3fHGEB9rtKoZt2
         yJ2IDhmiIwgcQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH v10 01/48] vfs: export new_inode_pseudo
Date:   Tue, 11 Jan 2022 14:15:21 -0500
Message-Id: <20220111191608.88762-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph needs to be able to allocate inodes ahead of a create that might
involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
but it puts the inode on the sb->s_inodes list and when we go to hash
it, that might be done again.

We could work around that by setting I_CREATING on the new inode, but
that causes ilookup5 to return -ESTALE if something tries to find it
before I_NEW is cleared. This is desirable behavior for most
filesystems, but doesn't work for ceph.

To work around all of this, just use new_inode_pseudo which doesn't add
it to the sb->s_inodes list.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index 6b80a51129d5..7fd85501bb32 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -951,6 +951,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 	}
 	return inode;
 }
+EXPORT_SYMBOL(new_inode_pseudo);
 
 /**
  *	new_inode 	- obtain an inode
-- 
2.34.1

