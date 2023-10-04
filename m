Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7797B8BFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbjJDSyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244613AbjJDSyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5733AB;
        Wed,  4 Oct 2023 11:53:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9F8C433CB;
        Wed,  4 Oct 2023 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445635;
        bh=+m4vHtTCSivPH1utLD9McAoOUgvVr+qXDjYigg31yRk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dL5McEqj3tHHiMI8N2HDvNPgIJHqCPclzoyprEQR5qnv0qpXaCUctb1Qq/by+GVUx
         b/eSnKYruYk53EzBHW+JP3A5h1DftIXq50aZulipUXp6twy0QctjUykGM7soucI/Fl
         rNHNbtuB+8i62Tb6oUJ5cIARp3tpVPpIn7EAHEqTdOuhbPTmHywDOJyEYg3a9tB9uH
         fS5AWKfhSDiD0CrO0JuoPt8Rhv2DERMu5yStid74AoENr8nunmrx7fyQgWkt3Rtw6C
         mf6Uk9SFpQZmh40MkVeJkwIQF5w15Di2PEZ5kShqFMTGOTHL31EovK40LunOPixtGg
         /WbLSO31sI6fw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/89] ibmasm: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:53 -0400
Message-ID: <20231004185347.80880-6-jlayton@kernel.org>
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
 drivers/misc/ibmasm/ibmasmfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index 5867af9f592c..c44de892a61e 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -139,7 +139,7 @@ static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode)
 	if (ret) {
 		ret->i_ino = get_next_ino();
 		ret->i_mode = mode;
-		ret->i_atime = ret->i_mtime = inode_set_ctime_current(ret);
+		simple_inode_init_ts(ret);
 	}
 	return ret;
 }
-- 
2.41.0

