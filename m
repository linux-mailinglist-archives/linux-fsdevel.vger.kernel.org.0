Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77AD732E91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 12:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbjFPKdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjFPKcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDE05580;
        Fri, 16 Jun 2023 03:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 575C763668;
        Fri, 16 Jun 2023 10:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1B0C433BA;
        Fri, 16 Jun 2023 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911286;
        bh=ysH0w+yjQDRPLtKZX9bh/XZ4Xy98xQo5GJZKqKgbEG0=;
        h=From:Date:Subject:To:Cc:From;
        b=TlF1NfudiD9U2D9fVOXP5GzwLPkZfoWPBSY8WxyP50aUhB1VoalAOxC58YxWSstE3
         y+97iQAUh2a+dOoKAEfF+4rZQkzZJgmlXfsvxYxvr36A7CsViMxYHv9jQhbIAiUJdN
         2zBYypHSxQQqgpWaaG5sCazcV+x3w3TmG5PJ6Y3Cx6XS8Ex3XobUDFE72a2m8yDSsA
         GGKNk/zxaFwAly8yucH06/RYEl+97gHAgJtLBJJsjXIiPjiVz/p2R7+3k5cdrncPNt
         PEBdXNv1rbM1jtPgX9SLhE8fR1CRm2PugHW5c7zBfBCQgBJ0HdzrDPfiDoLblihMAJ
         gxdslAm8sCeBA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 16 Jun 2023 12:27:57 +0200
Subject: [PATCH FOLD] ovl: fix mount api conversion braino
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-fs-overlayfs-mount_api-fix-v1-1-b6710ba366ea@kernel.org>
X-B4-Tracking: v=1; b=H4sIACw5jGQC/22OwQrCMBBEf6Xs2cWmShF/RUQ2ycYuaFJ2a1FK/
 93Us7d5MPOYBYxV2ODcLKA8i0nJFdyugTBQvjNKrAxd2x3a3vWYDMvM+qBPTc/yytONRsEkb/Q
 uEMdE6cQRqsCTMXqlHIZN4Y/7/+OtOypXxe/I5bquXzyIytGYAAAA
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=1598; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ysH0w+yjQDRPLtKZX9bh/XZ4Xy98xQo5GJZKqKgbEG0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT0WJrO6N8k2vFLPCnSPlpp9bSKHcsvCck1c37+KSC7IufS
 mck8HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPxCWdkeO25ZBOz3izP45Wbn9razJ
 mhofWbX1tIfbPLmkbzl+ULmBgZHi6pdDH5vy9jk2LM+ZM3iyeUiOpp7251eP3vj/xE9YeNjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cleanup sb->s_fs_info when ovl_fill_super() fails before setting
sb->s_root. The logic is a bit convoluted but tl;dr: If sget_fc() has
succeeded fc->s_fs_info will have been transferred to sb->s_fs_info. So
by the time ->fill_super()/ovl_fill_super() is called fc->s_fs_info is
NULL consequently fs_context->free() won't call ovl_free_fs(). If we
fail before sb->s_root() is set then ->put_super() won't be called which
would call ovl_free_fs(). IOW, if we fail in ->fill_super() before
sb->s_root we have to clean it up.

Amir reported an issue when running xfstests overlay/037 which made me
investigate and detect this.

Fixes: fc0dc3a9b73b ("ovl: port to new mount api")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---

---
I would just fold this into ("ovl: port to new mount api"). The patch
here is mostly so we have a track record of the issue.

Passes both

sudo ./check -overlay overlay/*
sudo ./check -overlay -g overlay/union

I somehow must've missed the earlier failure of overlay/037.
---
 fs/overlayfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b73b14c52961..9eaff5433dc2 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1949,6 +1949,8 @@ static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 out_free_oe:
 	ovl_free_entry(oe);
 out_err:
+	ovl_free_fs(ofs);
+	sb->s_fs_info = NULL;
 	return err;
 }
 

---
base-commit: 2543e5b405156bf506d22db5fc2b04eb7cf236da
change-id: 20230616-fs-overlayfs-mount_api-fix-b1caedfaf8ed

