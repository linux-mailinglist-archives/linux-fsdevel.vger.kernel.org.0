Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2C7B8BCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbjJDSzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbjJDSyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3278C19BA;
        Wed,  4 Oct 2023 11:53:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD2AC433CA;
        Wed,  4 Oct 2023 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445633;
        bh=ypj7rmODurA3z/UzEOTAbR4NZeN+HrhD93EAgqGeHr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWftD498o2QH9qj3mfNM61PvQPNOOCFsL6yLDsryUp3K8244fiVHlVbOF/xkvFm9g
         b9uWjpnYCNxtS3X5PjqDGFnyintMnbA89RUvnMe7/l8hgNxa6lrDc9nijkGxLEEwv0
         +dBp0TdN2kt9evt6TrV+4tJyhBr0AvQbWdkREVCxZCLI0zkTxQKbOQoZeivSDjsLBa
         ljJK5bJCciHhvU4U+1JvRqlfCBZmWflhbPHvxXY0NploZBhHVC21mSCcPhKguuPdsB
         zmU4gyTR1Xk6U8h7kS6vq+DFfieAQtr8xJBx6+UySBTOtqT2z4nss7PFeQk2uS0Avl
         o6YHz/j62ybdA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 06/89] char: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:51 -0400
Message-ID: <20231004185347.80880-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/char/sonypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 9211531689b2..22d249333f53 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -920,7 +920,7 @@ static ssize_t sonypi_misc_read(struct file *file, char __user *buf,
 
 	if (ret > 0) {
 		struct inode *inode = file_inode(file);
-		inode->i_atime = current_time(inode);
+		inode_set_atime_to_ts(inode, current_time(inode));
 	}
 
 	return ret;
-- 
2.41.0

