Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C99D748D80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjGETLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjGETKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D24203;
        Wed,  5 Jul 2023 12:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B1961705;
        Wed,  5 Jul 2023 19:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8D9C433C9;
        Wed,  5 Jul 2023 19:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583947;
        bh=XfqTBNQp2owuW7Y/glX6VYcpT/QJIApBnBVCG8ov/H8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btSVBxT54HuwxgjfGwTto13ThwkDsnlcJ2KYyL6Ygw70ybKyP3UsJIxgNNfzRacgb
         2v/nMZ1MVLNSbL+aHKPp/H8fDdgjhs3LEYCSiWK48EX0qtWJMV/zilm3ALvPK7//dk
         d7L3RGSTnVt5ZVfl23geIxLlgvKYpC2a53XZRma0zj9zPsw9z8DkOfpsx78FjKwaA9
         J2n1E4KXwUSJGyWp/9tUEtP4oAkaiT/5KDRhbo+AziERj5mdAg9/+HKFuO2Vpu2ouc
         b4qhW3vLHx2D/X9eVRdFKbNXBTPF8ZtFnd0m/6b15OUmnOnRkqQRmxDgaT8n50g5Pf
         3V5cQ6KW6x/Og==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 90/92] security: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:55 -0400
Message-ID: <20230705190309.579783-88-jlayton@kernel.org>
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

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..3aa75fffa8c9 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -145,7 +145,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
 		inode->i_op = &simple_dir_inode_operations;
-- 
2.41.0

