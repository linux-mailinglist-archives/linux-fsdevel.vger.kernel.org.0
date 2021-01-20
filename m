Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436572FD885
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404681AbhATSeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:34:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404398AbhATS3s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:29:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98B8623428;
        Wed, 20 Jan 2021 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167330;
        bh=nxrqkv0I2sZZsQo01IdmPZIrTKUuNiZQRQhrd5eb6vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJ2OJyWhSq+3kcEY/SYz4J3LsQUcHv9XwzhSPvLi5OFPNtlDepdOLEDk+LNhkcmsU
         2ybNO+gy8HwUE/NS+Nf1CYDk/Mk84MiXGcK93C8o4A50iToiPAeU0bJhPGfOI8DWzV
         mAeqi5jLAuu9yzKh29ZUoc3l89pOoxeMoECbI6Q+jaBtfPfcKuNrNb9tlegYdGSS8r
         I310o3z3POQqow3lLpbTxThc/CAvhft2nd1EviGneNLFiSj8WDGKYhwYqcw3+1Qub8
         4ieyt0H/mMfnoXPse+YHxMTd/Lj6SQ265Pazyx383fPNhTZW27jow0/vBFfaSArGNu
         yfjMSQGBk51yA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v4 01/17] vfs: export new_inode_pseudo
Date:   Wed, 20 Jan 2021 13:28:31 -0500
Message-Id: <20210120182847.644850-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120182847.644850-1-jlayton@kernel.org>
References: <20210120182847.644850-1-jlayton@kernel.org>
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
index 6442d97d9a4a..50edc88c9fe2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -934,6 +934,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 	}
 	return inode;
 }
+EXPORT_SYMBOL(new_inode_pseudo);
 
 /**
  *	new_inode 	- obtain an inode
-- 
2.29.2

