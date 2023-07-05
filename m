Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EF748CC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjGETDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjGETDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815A119BF;
        Wed,  5 Jul 2023 12:03:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F6F8616FB;
        Wed,  5 Jul 2023 19:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D32C433C8;
        Wed,  5 Jul 2023 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583803;
        bh=L6EzW1gN0+SRZxIErz0sW6Tb73or6lNTvn+UvQ+UhLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJB7XRGZ9/2aNYHQfjzBlRCDmmvV+Ti6HLP+oIQ9g5KZrdjQjm0y+Jhl8rdVoiCqG
         yNAQ8W/mgqYsGvz9nBNxe8BJ21A3QMuv0zJQYxL9guo6asboijEkgDeRQSrBfSig/p
         y3um6RHGyvKy2DmOpaWHlvqNe+TYIVNtPu4I/5h85aojGvgO6+zM0Ewv62AZ5sItYJ
         BGFhUukmOesc8UyqgAF96u85MDN4IqtfnbWGFTIJ63/U+8my5inkcImSFEKNDrDBdG
         voaAhfGJLsCJB7IlrDCNOmZcmkHZs+5FZ8A/Dag+FPXM+vt3V1xLIcdts0ws7Ae+oa
         roSY/5/VnBDgw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 11/92] shmem: convert to simple_rename_timestamp
Date:   Wed,  5 Jul 2023 15:00:36 -0400
Message-ID: <20230705190309.579783-9-jlayton@kernel.org>
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

A rename potentially involves updating 4 different inode timestamps.
Convert to the new simple_rename_timestamp helper function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0f45e72a5ca7..1693134959c5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3306,9 +3306,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 
 	old_dir->i_size -= BOGO_DIRENT_SIZE;
 	new_dir->i_size += BOGO_DIRENT_SIZE;
-	old_dir->i_ctime = old_dir->i_mtime =
-	new_dir->i_ctime = new_dir->i_mtime =
-	inode->i_ctime = current_time(old_dir);
+	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 	inode_inc_iversion(old_dir);
 	inode_inc_iversion(new_dir);
 	return 0;
-- 
2.41.0

