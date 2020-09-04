Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E242625DEF9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgIDQFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgIDQFm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:42 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 589A920796;
        Fri,  4 Sep 2020 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235541;
        bh=sobu7xDFkZQz7KqnZh/wH8XJsv7HJQlIH+zyiccpZxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EivLGo3n5tIfxDfgklPGFg6ULETyqygWKwRKt/SAk228b+awKR6ZufBV5NyPoQz/r
         h5tEjzb7NoSOsxyhJb4VnqKAZNQkiRGdWQCCQU06Kg+1mBRJHWHq4JDOzxt3qcFoRO
         1oq7PXvx6puRZPPfdauOkRcYtvDIHKdHBs5hrhNc=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 01/18] vfs: export new_inode_pseudo
Date:   Fri,  4 Sep 2020 12:05:20 -0400
Message-Id: <20200904160537.76663-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph needs to be able to allocate inodes ahead of a create that might
involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
but it puts the inode on the sb->s_inodes list, and we don't want to
do that until we're ready to insert it into the hash.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..61554c2477ab 100644
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
2.26.2

