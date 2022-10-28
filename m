Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7581F611D9F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJ1Wru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 18:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJ1Wrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44C1D5577;
        Fri, 28 Oct 2022 15:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A2DC62AC6;
        Fri, 28 Oct 2022 22:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7725FC433D7;
        Fri, 28 Oct 2022 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666997266;
        bh=dww3jMfExZYI3+AnfNuHM0Y6uGBj2gMQ2ravFPSVqjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvQn1NDObN19qBWP3mpa0+u7/7HbCKclZoicti51G4EhI/VjutqKu+W47r8aGnNDw
         VDqucnU2mmifjxOuLM2wv0ULHhvgSlms4ObUrd8vh3Jjm35sjjAAHNkB2r3C3qCbtE
         G2xzbnmMENq7BBcIoRGVMt63yKk17oVh2qjg3WdCmDOL/0LZdiA60vOgIwW0+6aFXf
         orx4F00eJOfjTvxThWGV8s3AHFP9LWU+fb/8nSFNqvQBSOnAQC19XhOcpZu1DWR2nG
         1H3hFoyxW4yU2rZ3nt1ydZeVw0hxS5sBLTBF21BGyc028/DvyfyxFYtRXh68HF2kFX
         yvnJXTm2z2zwA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] f2fs: simplify f2fs_readpage_limit()
Date:   Fri, 28 Oct 2022 15:45:37 -0700
Message-Id: <20221028224539.171818-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221028224539.171818-1-ebiggers@kernel.org>
References: <20221028224539.171818-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that the implementation of FS_IOC_ENABLE_VERITY has changed to not
involve reading back Merkle tree blocks that were previously written,
there is no need for f2fs_readpage_limit() to allow for this case.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b72c893b5374f..1b507fa183957 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2043,8 +2043,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 static inline loff_t f2fs_readpage_limit(struct inode *inode)
 {
-	if (IS_ENABLED(CONFIG_FS_VERITY) &&
-	    (IS_VERITY(inode) || f2fs_verity_in_progress(inode)))
+	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
 		return inode->i_sb->s_maxbytes;
 
 	return i_size_read(inode);
-- 
2.38.0

