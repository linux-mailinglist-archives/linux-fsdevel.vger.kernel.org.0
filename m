Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EEC748D2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjGETHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjGETGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD81FC6;
        Wed,  5 Jul 2023 12:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89BCA616F4;
        Wed,  5 Jul 2023 19:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2349FC433C7;
        Wed,  5 Jul 2023 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583873;
        bh=Q07agmN+3+t14XXRG6FKQDnwU5RN+rMKtJn4NHdEWos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkIfF+SdhLDlA6hyjj0ReVT8TuhVzupOEUrHVW1NoCL0TKXJ6VhiTU4HAAY9HUPxI
         EIlpEW655H87oQuluOyUe84GuJS3XSH1DmOCPy0l2+r1UCkn2c0Ys6DBxzdeZxF/CE
         4zI97zX8fF44I5BUOzZfc7IxAf4k1wTpTy0CfO7rFSdvWIQ+tFpDRxtE57mD0ZPsbM
         SFRhL8QogFgK4DkrTPfL+fjPJN0squ60mBnqmQ1OspfOoKhnxEdanEUc5C2dgTmX7i
         yvOMmEzu6ZSg88WKi/2glAMJh/J51GGR3EeFgBaohUXR2oTe0PRe8IfW9NBTioLufs
         THtBLd8+7Xeqg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: [PATCH v2 50/92] hostfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:15 -0400
Message-ID: <20230705190309.579783-48-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 46387090eb76..182af84a9c12 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -517,8 +517,7 @@ static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
 		(struct timespec64){ st->atime.tv_sec, st->atime.tv_nsec };
 	ino->i_mtime =
 		(struct timespec64){ st->mtime.tv_sec, st->mtime.tv_nsec };
-	ino->i_ctime =
-		(struct timespec64){ st->ctime.tv_sec, st->ctime.tv_nsec };
+	inode_set_ctime_to_ts(ino, &st->ctime);
 	ino->i_size = st->size;
 	ino->i_blocks = st->blocks;
 	return 0;
-- 
2.41.0

