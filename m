Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05AE5E6997
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 19:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIVRZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 13:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiIVRZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA3C6CF45;
        Thu, 22 Sep 2022 10:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FEE8636C7;
        Thu, 22 Sep 2022 17:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F27AC433D6;
        Thu, 22 Sep 2022 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663867527;
        bh=e0X1iUxMxiCA6glS9Z2DZTekN0HHTHz2fCHosTaQnOg=;
        h=From:To:Cc:Subject:Date:From;
        b=PdKGODP918YS/u/6hcye4iTXDK+Xygt1ox0HTrh1C2RRJ/dGaY6mNI6T49VcB0Y3u
         DCGJgXPLTfy7jvw1/iUOL0FJ+4xEI4lNHWsIjNpNFrnQtXzKEBGPaF7dxfJbPWUCJa
         sdJkFg6W+Ur+wpZErO7e23Gy5ti5JTuVXRIjgK4qZCm3kGq0KUgv3wdwaaOCL7ljie
         cvxpMEjtLdgEBPwAU4mcZ+mtMeaR1DRHFK0uLhCcy3lHXHUw4+BIXlDk01skQcdWoz
         C9x6WwIhEbSrkvN1rI1SOQjryDUzmryAaCS6WMvksXPpvFVZrDsKc8jwQ7Ku+682gb
         MTnwtB4+8zxAA==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: drop useless condition from inode_needs_update_time
Date:   Thu, 22 Sep 2022 13:25:25 -0400
Message-Id: <20220922172525.114489-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ba1de23c13c1..6d23ca5dc788 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2072,9 +2072,6 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
 		sync_it |= S_VERSION;
 
-	if (!sync_it)
-		return 0;
-
 	return sync_it;
 }
 
-- 
2.37.3

