Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9F4A84EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 14:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350724AbiBCNOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 08:14:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55446 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350726AbiBCNOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:14:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFFB16181B
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 13:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F1DC340F0;
        Thu,  3 Feb 2022 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643894091;
        bh=GNplQJzg1tMapSIoXSa1/+OR/ErS/FSxWWQdn2CUOps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TqpPwQj965I+jzbOa4V3GJVO6MAR7kDfZ5FUkYlHHfMZSdea78SltVy0u8TOh5vLV
         J1T0vE5ge42nXW9V61Zyx1TTnnU4NRODLqYqaG37TdEoaFyC2gJd6Sp22jV76UalWL
         9dP45tuI0pAkZ365iC1yjoafw9XlOvCB2V8XJmH+FbbZDZBHLJOmhjLvB4AMPm/ysR
         4nTq1AXswqtztsnf2w2CxRjiPTsAlfa18FR/mmZNitHk9cpNpNJ4vGqabo3sBPU+yG
         tWhrOCNtGkR/kL4EJjnAjwyBnWh9tYQpEaC9dbVnURUZoOTc1ao8HnZzPqNr/0mLpY
         Hq8NXn5cXQ8xg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6/7] fs: don't open-code mnt_hold_writers()
Date:   Thu,  3 Feb 2022 14:14:10 +0100
Message-Id: <20220203131411.3093040-7-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203131411.3093040-1-brauner@kernel.org>
References: <20220203131411.3093040-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; h=from:subject; bh=GNplQJzg1tMapSIoXSa1/+OR/ErS/FSxWWQdn2CUOps=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST+vsrUv6fQ+8Uv9ZyvUaICnocmz73y0dTXcrPalN38xd/2 pqof7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI13+G/85Prxznz8jkrhWJdYxMb4 n50atmscMtdCf7+0dnEi0On2BkeHzt6u3NhlcfOb6YH3X/ktLNBcUxnHr5BoWH9tleeFY5kw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove sb_prepare_remount_readonly()'s open-coded mnt_hold_writers()
implementation with the real helper we introduced in commit fbdc2f6c40f6
("fs: split out functions to hold writers").

Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ddae5c08ea8c..00762f9a736a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -563,12 +563,9 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 	lock_mount_hash();
 	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
 		if (!(mnt->mnt.mnt_flags & MNT_READONLY)) {
-			mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
-			smp_mb();
-			if (mnt_get_writers(mnt) > 0) {
-				err = -EBUSY;
+			err = mnt_hold_writers(mnt);
+			if (err)
 				break;
-			}
 		}
 	}
 	if (!err && atomic_long_read(&sb->s_remove_count))
-- 
2.32.0

