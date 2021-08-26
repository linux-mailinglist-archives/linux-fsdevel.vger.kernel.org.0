Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C923F8BB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbhHZQVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243060AbhHZQVF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CACC3610A7;
        Thu, 26 Aug 2021 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994817;
        bh=yCNNKLVqbExFzsrwpKfzckRntYEGnKYJ3zcgAvD6uYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVDAUiw3Ipr3uUNLJIoyCbiUwQBapcUQVAGEJRP9zOkNp1NcOAvEqKY39GWUo/0Tn
         JnhPcSJF4UduI2AhRgaQVM5RF5C1xINsrEfl9NQMeOGt250EfS/ZOSggORR4BYL7gG
         a1JIrCS/Hpe6yoOCR/y4f7UIfj8Z5nvsYIdOHd8T+coksVzAl6No6U73yCS+4waVT6
         p/fGjCuElR0OcGINiymTUR+PrJ06KAvWJf6UqD2rnyKSkHoVtHuoPr5CuLvU6A/Dv2
         hNwSCMMWeU1BDLd0/Af7FnhHhDzeE7T3VWalB4W4m4AxKRTaEpAOxH4o+K8FGpVn3v
         wsTjOHnmS1FVw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH v8 01/24] vfs: export new_inode_pseudo
Date:   Thu, 26 Aug 2021 12:19:51 -0400
Message-Id: <20210826162014.73464-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826162014.73464-1-jlayton@kernel.org>
References: <20210826162014.73464-1-jlayton@kernel.org>
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

