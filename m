Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD677794D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjHJNMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHJNML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015E136;
        Thu, 10 Aug 2023 06:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97C163875;
        Thu, 10 Aug 2023 13:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B63FC433CB;
        Thu, 10 Aug 2023 13:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691673130;
        bh=qEGRHERJDD6pf6eauAwl2sw44g31DM2S00kWiYDSE2Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ELS5wT6wY+1eGzsgNKqf/4DSKbkla03pIoy7LZRuX5j4w8/GIYlOBj6R6TZ/KWwtK
         B+63AELT3JTE7kWOt2lU9yPFz0BB1poTvJ59gLKsCvgErxHeIqsM6UUJ5z6hNMI0Rh
         FsguVLk0a357UYL6e5t3x1NdDipaNphc1QcvmJT404O2wluM6XqFT/KdNBP2xyG7QU
         1c0Io68mN9zvJG5iEGEKMbh158l1rM71yNsBtP/c4hQBygKckWtJwdGwLe3OJXaWTY
         fvR+1YgVMBWaOvUjXhGu0wLPOpLJNfK5MVm7ovW6T+y0ejxiJ+pWSv5CV7MuG3LYRg
         yPOzgOiSK7cZw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 10 Aug 2023 09:12:04 -0400
Subject: [PATCH 1/2] fat: remove i_version handling from fat_update_time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-ctime-fat-v1-1-327598fd1de8@kernel.org>
References: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
In-Reply-To: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Frank Sorenson <sorenson@redhat.com>, Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qEGRHERJDD6pf6eauAwl2sw44g31DM2S00kWiYDSE2Q=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk1OIoQw6ZsmX4vC0yb2/1NWPLO8xdxhDhjM/hR
 ObdyBBrRiCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNTiKAAKCRAADmhBGVaC
 FWCUEAC9+CezU7ndFRliS/8zKwJjJGmx/HoOu8e65SKrTQrEWlRL/rzWHzn8jknlSv3xpq9dJjf
 UAhZm1b9rj7XCS3oNJJqLcTMaQKCNnJrPcECRILLMWmbG+gE+4sDxeIlWuqCAxGIIyGSY51OND5
 HN15h/Rd4Lu4jh5ZSyCfB59mEvFLtOyznbX2cEHtjESri9Qd3wNildNZrd+PZhRsUi85GbjXI/p
 kfFz6+ZuiniM6X9acRFTbmyAL99rFrJETEzdV+4R0RjGQEnTZPEEpDCb21Mv7u2uHrYzzVvjM0F
 D4NuPGPIh+wEK31J7TaWOOCa/K5PzxxpuFVq1TrqCHdlk5j3J+dhojiP/Ky9eeq3gHuamLQpFJU
 7g7PRJiQK7isiV5U2t0VOduguDMwd7vZlRGYoMA3b5ncMb4DHnuEVM0FxLkDH8PbchcADKuSpWC
 ilX41Vk4gq0Ph8v5NDbnmLoBcQapUC7byTrw4DQXqguCqGe+7VM/CE82h6hekKNb9K+ncp4EzYJ
 nZew5LtSXGTdrLWS0aBIi0l+sJznnIo+2E9UXJciBD+MB6fTREog9DdYJZFCILmR+9Ihx/XQqNe
 JU3cIgFYFeETO524mMmiS27yGaKUUdh0VcIMFWUBjFPoCGsqRe7xAMc+SjFXphbAARsx29yNdTn
 wL2kM2PcFIeJgKw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit 6bb885ecd746 (fat: add functions to update and truncate
timestamps appropriately") added an update_time routine for fat. That
patch added a section for handling the S_VERSION bit, even though FAT
doesn't enable SB_I_VERSION and the S_VERSION bit will never be set when
calling it.

Remove the section for handling S_VERSION since it's effectively dead
code, and will be problematic vs. future changes.

Cc: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fat/misc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index ab28173348fa..37f4afb346af 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -354,9 +354,6 @@ int fat_update_time(struct inode *inode, int flags)
 			dirty_flags |= I_DIRTY_SYNC;
 	}
 
-	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
-		dirty_flags |= I_DIRTY_SYNC;
-
 	__mark_inode_dirty(inode, dirty_flags);
 	return 0;
 }

-- 
2.41.0

