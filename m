Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53191748D4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjGETJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjGETHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C729C2D68;
        Wed,  5 Jul 2023 12:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F3FC61659;
        Wed,  5 Jul 2023 19:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4590DC433C9;
        Wed,  5 Jul 2023 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583877;
        bh=ofpnt9iWvlkIrsKtA3+qgnbIz58dJxWLWNpVQKqe8PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p6GfcEdLHYJY5whbHXDiSGJqn+cA/VhCeZ6v4zmqCx+qe73OBtCW36mnIWI5ok6v/
         B6YCts2KOeq1M3DTDLt5IF9yHYbo38caOQ97+DVNmDsB+NfqvzqW+K1sOJWHNuSzhm
         50oJ+3ZTHt8+u6n6LxYf0XmIcn64NW1rTgBjLKNfOgEvrqwB8g5Stf6CwBXfvTF+jO
         hX5P4qRNSbzbvTbmj2lnP2wt4B+cM6n/DZDK8ab+C8SZi/H53X5iDB4em8/FHVi6EC
         6Mejz+qv9jgI0neEr19yMJXzHnygMqbz+EoF++Bmb/Ijq+UGt13Ih72I9F0ppcizEf
         czEgy1uJwXkvA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 53/92] isofs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:18 -0400
Message-ID: <20230705190309.579783-51-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/isofs/inode.c |  8 ++++----
 fs/isofs/rock.c  | 16 +++++++---------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index df9d70588b60..98a78200cff1 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1424,11 +1424,11 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 #endif
 
 	inode->i_mtime.tv_sec =
-	inode->i_atime.tv_sec =
-	inode->i_ctime.tv_sec = iso_date(de->date, high_sierra);
+	inode->i_atime.tv_sec = inode_set_ctime(inode,
+						iso_date(de->date, high_sierra),
+						0).tv_sec;
 	inode->i_mtime.tv_nsec =
-	inode->i_atime.tv_nsec =
-	inode->i_ctime.tv_nsec = 0;
+	inode->i_atime.tv_nsec = 0;
 
 	ei->i_first_extent = (isonum_733(de->extent) +
 			isonum_711(de->ext_attr_length));
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 48f58c6c9e69..348783a70f57 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -421,10 +421,9 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 			/* Rock ridge never appears on a High Sierra disk */
 			cnt = 0;
 			if (rr->u.TF.flags & TF_CREATE) {
-				inode->i_ctime.tv_sec =
-				    iso_date(rr->u.TF.times[cnt++].time,
-					     0);
-				inode->i_ctime.tv_nsec = 0;
+				inode_set_ctime(inode,
+						iso_date(rr->u.TF.times[cnt++].time, 0),
+						0);
 			}
 			if (rr->u.TF.flags & TF_MODIFY) {
 				inode->i_mtime.tv_sec =
@@ -439,10 +438,9 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 				inode->i_atime.tv_nsec = 0;
 			}
 			if (rr->u.TF.flags & TF_ATTRIBUTES) {
-				inode->i_ctime.tv_sec =
-				    iso_date(rr->u.TF.times[cnt++].time,
-					     0);
-				inode->i_ctime.tv_nsec = 0;
+				inode_set_ctime(inode,
+						iso_date(rr->u.TF.times[cnt++].time, 0),
+						0);
 			}
 			break;
 		case SIG('S', 'L'):
@@ -534,7 +532,7 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 			inode->i_size = reloc->i_size;
 			inode->i_blocks = reloc->i_blocks;
 			inode->i_atime = reloc->i_atime;
-			inode->i_ctime = reloc->i_ctime;
+			inode_set_ctime_to_ts(inode, inode_get_ctime(reloc));
 			inode->i_mtime = reloc->i_mtime;
 			iput(reloc);
 			break;
-- 
2.41.0

