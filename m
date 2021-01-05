Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56E2EA1DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 01:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbhAEA43 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 19:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbhAEA42 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:56:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28656225A9;
        Tue,  5 Jan 2021 00:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808109;
        bh=Ad7xLAZQk7GaC9BkYrLopltjaA0micO7CKVPyWiuAIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9pN6k7eZWDzKxMNTAL16e24puJANBJqgUATkSeVAFTD1NZ47idpUHJlSPEqpBGkK
         UqoR0jDQJOR+ODkJotclMYzN9qCk1aAU0iTIOL/17YsRFdJzHij3FPqqu6srKMpgnK
         lcEM7vhAEfE+jrUnJyv5rdeTitXFHJKs6xmCvuKB/adz9aAiENsqhnSa3YyytLjVem
         nXDWtC3fxXJqwb4wXSh5nX2URUIYWMazymEm3+pfyQZcF2nmpB+fVPZM5uZW2d7Sz/
         igWIQnJAFW8cLT0v2qBsM+KXzZWW25sbQYF2d1mkJqke9RyEBq3TuiZ0lSbTFEMlUi
         Zk5ZRbFXOQr8g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/13] ext4: simplify i_state checks in __ext4_update_other_inode_time()
Date:   Mon,  4 Jan 2021 16:54:47 -0800
Message-Id: <20210105005452.92521-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105005452.92521-1-ebiggers@kernel.org>
References: <20210105005452.92521-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since I_DIRTY_TIME and I_DIRTY_INODE are mutually exclusive in i_state,
there's no need to check for I_DIRTY_TIME && !I_DIRTY_INODE.  Just check
for I_DIRTY_TIME.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4cc6c7834312f..9e34541715968 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4962,14 +4962,12 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 		return;
 
 	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
-			       I_DIRTY_INODE)) ||
-	    ((inode->i_state & I_DIRTY_TIME) == 0))
+			       I_DIRTY_TIME)) != I_DIRTY_TIME)
 		return;
 
 	spin_lock(&inode->i_lock);
-	if (((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
-				I_DIRTY_INODE)) == 0) &&
-	    (inode->i_state & I_DIRTY_TIME)) {
+	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
+			       I_DIRTY_TIME)) != I_DIRTY_TIME) {
 		struct ext4_inode_info	*ei = EXT4_I(inode);
 
 		inode->i_state &= ~I_DIRTY_TIME;
-- 
2.30.0

