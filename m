Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33455750BB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjGLPDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGLPC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:02:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C66BB;
        Wed, 12 Jul 2023 08:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C049B61830;
        Wed, 12 Jul 2023 15:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FD7C433C9;
        Wed, 12 Jul 2023 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174174;
        bh=S1pegj1qL8CVQOEK2cfiVJMp8lPq/SPQs4CNL9BiRFA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZUnYHTDJSUDnL5/k82eolh32DV9zKzMvnsTlBrXPu+hQeX6CHzCz+cSvhJimVipd/
         FqCUvMZ7t4FjCm5M+i90mDYMzSyPXCfOPhpsu42G1Jjhy48Ou6f/ra7czYpMgvJXtC
         1RjGbP19OiULk8twbfGC7tQlISlAjnQyQsDczsPFoTmCHoSjJDZu3+EWfAX8gAywxV
         iX6ysP8WteLer5B4u6ONjtmLfNAKMjtPoftDrlrkBzJql2XyCp5yoMEf0ONbSF+et9
         w0W9XFikfyhfI5fTXKAaTSqIOuFH27WdDS7BkqGNdc5qUOufjkja7p7/dVKe9Z0p6E
         lGyPtK2LjX/4Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     brauner@kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: fix decoding of raw_inode timestamps
Date:   Wed, 12 Jul 2023 11:02:49 -0400
Message-ID: <20230712150251.163790-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
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

When we covert a timestamp from raw disk format, we need to consider it
to be signed, as the value may represent a date earlier than 1970. This
fixes generic/258 on ext4.

Cc: Jan Kara <jack@suse.cz>
Fixes: f2ddb05870fb ("ext4: convert to ctime accessor functions")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/ext4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

It might be best to just squash this fix in with the ext4 conversion in
the vfs tree.

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d63543187359..2af347669db7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -877,7 +877,7 @@ static inline __le32 ext4_encode_extra_time(struct timespec64 ts)
 static inline struct timespec64 ext4_decode_extra_time(__le32 base,
 						       __le32 extra)
 {
-	struct timespec64 ts = { .tv_sec = le32_to_cpu(base) };
+	struct timespec64 ts = { .tv_sec = (signed)le32_to_cpu(base) };
 
 	if (unlikely(extra & cpu_to_le32(EXT4_EPOCH_MASK)))
 		ts.tv_sec += (u64)(le32_to_cpu(extra) & EXT4_EPOCH_MASK) << 32;
-- 
2.41.0

