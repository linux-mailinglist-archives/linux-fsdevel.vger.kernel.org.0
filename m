Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDE5B3406
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiIIJdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiIIJcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7B138E6A
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 02:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4927661F69
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 09:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15A9C433C1;
        Fri,  9 Sep 2022 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662715828;
        bh=gcfvieFJ4FbVMv/FIlf1ZgSJ0fh0S3aPODkU15adhVg=;
        h=From:To:Cc:Subject:Date:From;
        b=OmelVOW15ekRM4nIuOMxkux03nt9Z+fxc+jLntXfmvlqThBaop5JBaTdr5sOW6YxA
         GDz+WYLJ6cDM5dUSdTJSB2X++TJnxGSNz533sFrVjve2AWskIEUmdmUgrElDdtMOzY
         LQOGmJZmit/JCLPLZtvYbYgWPJ9EF+8S3s/F2U52b1T/NkEukV+XiIBCt+0uYkHcFT
         CIgu1//Y4vqE/WTAtm1oSFrpa5xolAiPuNtaaaqw3Eqo++cfkuw4jLtVD1RkfZSOxM
         exujYTmL3ePQoqRB0/FE3pQhJ6OmezhheFIDHfdseuxMX7yxT5rQO4AZ25n/bH0HyI
         JjdQiZR3fbFhQ==
From:   Christian Brauner <brauner@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fat: port to vfs{g,u}id_t and associated helpers
Date:   Fri,  9 Sep 2022 11:30:19 +0200
Message-Id: <20220909093019.936863-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=brauner@kernel.org; h=from:subject; bh=gcfvieFJ4FbVMv/FIlf1ZgSJ0fh0S3aPODkU15adhVg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRLs69Y/l5iyZUfYj+2MuccuLpu4YzLi+TfPqtZd8Xub09c wvWblzpKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmsiCI4Q93ooHn9bLPE/5KsdyU/b PH+0ih+MIQqfdbpq+ZcbIrf60oI8MymfS517OV10f/kl1a2705forLRL7g7of9Kkd4T7A/X88NAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A while ago we introduced a dedicated vfs{g,u}id_t type in commit
1e5267cd0895 ("mnt_idmapping: add vfs{g,u}id_t"). We already switched
over a good part of the VFS. Ultimately we will remove all legacy
idmapped mount helpers that operate only on k{g,u}id_t in favor of the
new type safe helpers that operate on vfs{g,u}id_t.

Cc: Seth Forshee (Digital Ocean) <sforshee@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/fat/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 3e4eb3467cb4..8a6b493b5b5f 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -461,8 +461,9 @@ static int fat_allow_set_time(struct user_namespace *mnt_userns,
 {
 	umode_t allow_utime = sbi->options.allow_utime;
 
-	if (!uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode))) {
-		if (in_group_p(i_gid_into_mnt(mnt_userns, inode)))
+	if (!vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode),
+			    current_fsuid())) {
+		if (vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)))
 			allow_utime >>= 3;
 		if (allow_utime & MAY_WRITE)
 			return 1;

base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
-- 
2.34.1

