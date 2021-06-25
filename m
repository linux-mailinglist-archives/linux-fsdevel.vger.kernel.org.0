Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68B13B44ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFYOA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 10:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhFYOA5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:00:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC2DF61956;
        Fri, 25 Jun 2021 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624629516;
        bh=yCNNKLVqbExFzsrwpKfzckRntYEGnKYJ3zcgAvD6uYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHf9n+EByZ1REM/3HkUiwFf0CCLnLs+lX2mvC5VPvPCFvSSJ9RSokFPaI0dIrW64W
         est1bUAqT/hAEwg3W7v2i7nSl4iWpGl+CR4scrhzfHoJNSccn2XOZBAUfO5sWrkgb0
         kHdXNGjfVnWhiQWedjPMoF42RJ5YIQXXxEStrazKG69V1WGr1dYwBGevO99hoS3hWN
         WFkRdM0j/YGQkenEe5tPi/4+nSUw5/nkehMIg91czvAN38q+LjVvj225z4saX6lvia
         DUAhtdSZmtwRulASbf9SSvM0ajGuHdd2ZJGbIHXGntYqb3pJWA+u+u37XcKCjtzODL
         z50azdah/CIdQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH v7 01/24] vfs: export new_inode_pseudo
Date:   Fri, 25 Jun 2021 09:58:11 -0400
Message-Id: <20210625135834.12934-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625135834.12934-1-jlayton@kernel.org>
References: <20210625135834.12934-1-jlayton@kernel.org>
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
index c93500d84264..cf9ea4b260b0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -941,6 +941,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 	}
 	return inode;
 }
+EXPORT_SYMBOL(new_inode_pseudo);
 
 /**
  *	new_inode 	- obtain an inode
-- 
2.31.1

