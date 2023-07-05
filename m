Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A396748CE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjGETEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjGETDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4811FC8;
        Wed,  5 Jul 2023 12:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F03C616EC;
        Wed,  5 Jul 2023 19:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0B1C433CA;
        Wed,  5 Jul 2023 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583816;
        bh=WjJ73M/v99Nap+N3R5V2fA+OWUumYJWRrkRq37VlgiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrQEAsjnnUBKxYdCIlgLRKZoDoUovdo1xj0fUfa8IpK75tYuOjN/lU/OcHRfIEJOb
         ++7Q8xU3jNOMXViBUwsZ6GwojOf8MoGrGAHeKugS5rCTk27COn5WNUM2ILbX+lFmpA
         jM8q8Bjny1G1jEwSO1iFLx5gtrvNgb9Ay9qF//iZLnmRRHFxE8tdiVE9qZlbqFKfBB
         A37vQ3inBlQwdzVEq102+hkzk8fPOEzxAghG27IYnED6r9askVjn/u9Em481bJfhEi
         VoWjMFh/qigb1aMliEewnL8D7K8Lxv+0ebPocfAxlIGThWObZBtXQ88UMKq8uwh4bd
         zdk6syPNk4aDg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/92] ibm: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:44 -0400
Message-ID: <20230705190309.579783-17-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
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

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/misc/ibmasm/ibmasmfs.c | 2 +-
 drivers/misc/ibmvmc.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index 35fec1bf1b3d..5867af9f592c 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -139,7 +139,7 @@ static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode)
 	if (ret) {
 		ret->i_ino = get_next_ino();
 		ret->i_mode = mode;
-		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
+		ret->i_atime = ret->i_mtime = inode_set_ctime_current(ret);
 	}
 	return ret;
 }
diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index d7c7f0305257..2101eb12bcba 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -1124,7 +1124,7 @@ static ssize_t ibmvmc_write(struct file *file, const char *buffer,
 		goto out;
 
 	inode = file_inode(file);
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 
 	dev_dbg(adapter->dev, "write: file = 0x%lx, count = 0x%lx\n",
-- 
2.41.0

