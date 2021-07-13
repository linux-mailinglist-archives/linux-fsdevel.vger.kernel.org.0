Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5853C6F59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhGMLTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235722AbhGMLT3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E95461164;
        Tue, 13 Jul 2021 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174999;
        bh=Ypx8lR5RjOf76of34VRfY1iBSYOZtZAOJSsDLHWgBTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eX6U5Qb0PphrvtG1cLRfUbprM3JggVAI93mo39RtxtVng7P5F5cGhqbJ9n/gbfG0O
         6Q8xS3Y5yTcgEbBbNjsHuQ8pNA1ysdhEmolwlTdokkcKeUajG5hnWfZLZS4hbLMc99
         2eXOjdFocNKbJroZjM10nL8gzcITMna6S3ZzvrK1dge2E0WvD//5oj2qSDkvpCIJHt
         W0YhqxaBU0kIadKUQgPARsmipKDmrgByZvs999/D7nu4OxgRo0+Kb4mamWPL7wKSiA
         OqOUTzKxTN0+/n5W9zEYeb9wNPMmEpgZHt7LV2QrXqd/QVYyfFkkNFLVpxw+5VKDTP
         NU1+Mx3cBF1Lw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 14/24] btrfs/inode: allow idmapped permission iop
Date:   Tue, 13 Jul 2021 13:13:34 +0200
Message-Id: <20210713111344.1149376-15-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; h=from:subject; bh=HOMgk9xSp2+unZe8XN3SFO5+XS+rZFI85aLkGhjJ16E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY1+O2/1Rom3ot6pzxXnWwStem+tUVZy55JwgozKfr8z 1/7pdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkyxJGhvmfJ6ixLDz9+v35Pxr7nn ffn9De4TPnkOVptpnqLGd2JrEw/C9Manmffbfx0N9ZuRmsObLchQplS785m/Vu37BrUue0JG4A
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_permission() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8a80ef810703..3b537d90172e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10185,7 +10185,7 @@ static int btrfs_permission(struct user_namespace *mnt_userns,
 		if (BTRFS_I(inode)->flags & BTRFS_INODE_READONLY)
 			return -EACCES;
 	}
-	return generic_permission(&init_user_ns, inode, mask);
+	return generic_permission(mnt_userns, inode, mask);
 }
 
 static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-- 
2.30.2

