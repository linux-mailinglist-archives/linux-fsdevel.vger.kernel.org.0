Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5095A4C7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiH2MxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiH2Mwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0478E
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479866113E
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 12:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6717AC433C1;
        Mon, 29 Aug 2022 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661776914;
        bh=G+savi+fCveGrrmP6NOBOTHZiY4pI9EhvCI4t8gR6KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PN3hTlorVtjS3a4t7rE5yiqdhCnrk7VEsX8px0BCi6hCW6yEP73YigqbnPIVwFGha
         l6sJRBV8XGVSbNiZyba+d4l+oVl/FtYpj+Dm8qvmfnnlGEnVfyyyKq94sRw2Xz5Q6E
         7dHjZdXyFKlax/D9+vvHLZeg9+vht8SwjZCf8rCK/cGjpiYdI+1XcK5TOw51sLI7JU
         LXB3ILrIhAd2QdafECeJ27Wi3E/glnz3kvF3Qpq5ferQSMNU/mgaEG9wevlh3JxS1L
         gPD49OUBXC6pjjC1wsPIgjSf05fLyL3GzCrp+yud0nkrJ5DuusdzVtJvzWK+M6mN17
         fWTtJKO8znDqg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: [PATCH 5/6] ovl: use vfs_set_acl_prepare()
Date:   Mon, 29 Aug 2022 14:38:44 +0200
Message-Id: <20220829123843.1146874-6-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829123843.1146874-1-brauner@kernel.org>
References: <20220829123843.1146874-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=brauner@kernel.org; h=from:subject; bh=G+savi+fCveGrrmP6NOBOTHZiY4pI9EhvCI4t8gR6KU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTzbPojzju55UHrrFxPjkKvptJpJt/mb6jQcF+mc3XWTh1r W0/vjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInohjEyPFavuPrzjeSWnLrZx1z+7e 3t9plZwb/0dsUJRc/g4zc/zmNk2LVXL/HPmgc/pQ+J7Xq37Kv5vlzDFCue3yelDW6EOq0wZwMA
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

The posix_acl_from_xattr() helper should mainly be used in
i_op->get_acl() handlers. It translates from the uapi struct into the
kernel internal POSIX ACL representation and doesn't care about mount
idmappings.

Use the vfs_set_acl_prepare() helper to generate a kernel internal POSIX
ACL representation in struct posix_acl format taking care to map from
the mount idmapping into the filesystem's idmapping.

The returned struct posix_acl is in the correct format to be cached by
the VFS or passed to the filesystem's i_op->set_acl() method to write to
the backing store.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/overlayfs/super.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ec746d447f1b..5da771b218d1 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1022,7 +1022,20 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 
 	/* Check that everything is OK before copy-up */
 	if (value) {
-		acl = posix_acl_from_xattr(&init_user_ns, value, size);
+		/* The above comment can be understood in two ways:
+		 *
+		 * 1. We just want to check whether the basic POSIX ACL format
+		 *    is ok. For example, if the header is correct and the size
+		 *    is sane.
+		 * 2. We want to know whether the ACL_{GROUP,USER} entries can
+		 *    be mapped according to the underlying filesystem.
+		 *
+		 * Currently, we only check 1. If we wanted to check 2. we
+		 * would need to pass the mnt_userns and the fs_userns of the
+		 * underlying filesystem. But frankly, I think checking 1. is
+		 * enough to start the copy-up.
+		 */
+		acl = vfs_set_acl_prepare(&init_user_ns, &init_user_ns, value, size);
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 	}
-- 
2.34.1

