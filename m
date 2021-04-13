Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88FD35E561
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347374AbhDMRvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 13:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238484AbhDMRvO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:51:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D355E61176;
        Tue, 13 Apr 2021 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618336254;
        bh=A8Ma45wG5QAGaD9vkW/X6YWof3jHALAxoxiqod/wPyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPFMjTw3LatSmtZp5V8z54+S09pLUQkzbh4oaduo35BxGa0HnD5t54tRbB8Ep2BG8
         S4oEYBGNt5t/8zaS4NxdNnv+V93xgfxv0IsYV4t26Ew2DF/wP1lEfwXZRFN4aoEHm3
         GI1UVkFFuvkJ9lTdVXoR5ln9gcbJHN5Mvy+oSmR0woPwJNJuksUeVzyh1ovOzp1YUy
         qTKQ+tsh7YBfs1v+Gw15w0gGuUfyU3DxTmT/oq4t3ZBslbOpNyvoeSukrI1PlVYx4K
         XWxL4b2VkTyYNWYb9LyS80fZfz1EkNLsqTG2Vk4I6BNfl7AIkieP69lvMjSQO52Th8
         6cMhlT0gcCPvg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        lhenriques@suse.de, Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH v6 01/20] vfs: export new_inode_pseudo
Date:   Tue, 13 Apr 2021 13:50:33 -0400
Message-Id: <20210413175052.163865-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413175052.163865-1-jlayton@kernel.org>
References: <20210413175052.163865-1-jlayton@kernel.org>
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
index a047ab306f9a..0745dc5d0924 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -935,6 +935,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 	}
 	return inode;
 }
+EXPORT_SYMBOL(new_inode_pseudo);
 
 /**
  *	new_inode 	- obtain an inode
-- 
2.30.2

