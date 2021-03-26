Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C4934AD64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCZRck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhCZRce (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:32:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A827661A28;
        Fri, 26 Mar 2021 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616779950;
        bh=FyLX2ywQ9BCPysDxrhOZANICT7CBoNn+Ctf/AjpJVlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivBSs3wh68STq4fXnIwRuVr9mdfDMwzPGcGrNZVTE+KfJlnnl96LqV65h4f3dRDTI
         KUsE7RICXABkp6Pv6VcHh4X9vrT/z9Ed92Sp4BifPgqTEnSXJ/EuHLRBTJ0L7oJ2/e
         v+ybZh1y810UmzzmiP6kg7Xn5O8xjVhq/KJApUXTi3XFSwqwGyWKdfFpxoNLBvwXvi
         mEnCLs2DVyCNZsP1KBW+J209N0VPxlDaQ2ukXjcqPRYDWvFenpJZ/3HOcRlolQaqwz
         m0twMZ4IPqg3gt6DuF81ZblvXrZyZRGmn4USR06xzzcgHz3HM9hljxZ7WNGzbnoIxw
         7n56ieRBNW96Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH v5 01/19] vfs: export new_inode_pseudo
Date:   Fri, 26 Mar 2021 13:32:09 -0400
Message-Id: <20210326173227.96363-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
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
before I_NEW is cleared. To work around all of this, just use
new_inode_pseudo which doesn't add it to the list.

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

