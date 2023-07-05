Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2423748D41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjGETIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjGETIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47A935A0;
        Wed,  5 Jul 2023 12:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94F0161702;
        Wed,  5 Jul 2023 19:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BBCC433C7;
        Wed,  5 Jul 2023 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583908;
        bh=9tqjc1yQ4vJk7vw2pYwnEX82rP1AT/1qIv5Ev61P7H8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjirD9pZlAnf1MI0AwOEUGXxPB0fcITLGV4nmQ929feHDnPUkOH/kDgNJBUdHftmv
         2WpIxPwzVF5fIyhxk+aTvKI6So+bTsbZMc4OBHHW4Fz4hc/xSM98X2iiENI22a1pTX
         esNxnQVRQO4GtTncPFG3G1ZYqxAcDwmh9I2FRpVyTB7FPENCVuYK3qAFzjDIRkTd6T
         If1+QyzOVOHdBaH+a2N7SYJsaxKxEk3ZHJV2WtkQ8A1lPahlPJ90aUo1XYo+dtPqhq
         o9qRs2BVkBLGleaCDLdsbCDldbvf8s4yeC4BSiby5ZqLbryjk6BCtymbojm3PYU3tv
         822o5CifLJM5w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 68/92] pstore: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:33 -0400
Message-ID: <20230705190309.579783-66-jlayton@kernel.org>
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

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/pstore/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index ffbadb8b3032..a756af980d0c 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -223,7 +223,7 @@ static struct inode *pstore_get_inode(struct super_block *sb)
 	struct inode *inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	}
 	return inode;
 }
@@ -390,7 +390,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	inode->i_private = private;
 
 	if (record->time.tv_sec)
-		inode->i_mtime = inode->i_ctime = record->time;
+		inode->i_mtime = inode_set_ctime_to_ts(inode, record->time);
 
 	d_add(dentry, inode);
 
-- 
2.41.0

