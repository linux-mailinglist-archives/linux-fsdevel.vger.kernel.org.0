Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929B37387DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjFUOwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjFUOup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F182296F;
        Wed, 21 Jun 2023 07:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD281615AA;
        Wed, 21 Jun 2023 14:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96814C433C0;
        Wed, 21 Jun 2023 14:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358924;
        bh=GOlvR7zQkP7YHCqLCSL4MnqspCPui1thTIrZ1lMD+xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wsb3/uGFyYqh0KgV+TN+qB/TlZ2sZd6ovf4WfWNqA8JQnuDvnSzMOUdqU0zoBDbEf
         dUR/HCHZjRG9dNvEVI1c+lOhVQXDyIEvXlY3KT7lqWcLF0k8A2rMJ4oRQgbOeqDxlD
         5jDAkLbRIM7IQ8p3Up+GGS4QqcfdwshnDnmCGOjgxT5Uqskcm/eBTyO4pGNpY8cd9s
         er2KDyHUPq9eA7XFuZ2awoe6+6SH6BoJlPDxdxyT0iIq94m7puHa0Q8kL+ayaEpg5V
         mtYdjXz2jYR55HIrd+XbwOYfEcddFITlwR6hye7VUTFKnhSSHD0LqyRUEfU2eld15q
         jN2SKRYjLQQNg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 40/79] isofs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:53 -0400
Message-ID: <20230621144735.55953-39-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/isofs/inode.c |  4 ++--
 fs/isofs/rock.c  | 16 +++++++---------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index df9d70588b60..035fa0271d6e 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1425,10 +1425,10 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 
 	inode->i_mtime.tv_sec =
 	inode->i_atime.tv_sec =
-	inode->i_ctime.tv_sec = iso_date(de->date, high_sierra);
+	inode_ctime_set_sec(inode, iso_date(de->date, high_sierra));
 	inode->i_mtime.tv_nsec =
 	inode->i_atime.tv_nsec =
-	inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_nsec(inode, 0);
 
 	ei->i_first_extent = (isonum_733(de->extent) +
 			isonum_711(de->ext_attr_length));
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 48f58c6c9e69..6b7f2a62124d 100644
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
+				inode_ctime_set_sec(inode,
+						    iso_date(rr->u.TF.times[cnt++].time, 0));
+				inode_ctime_set_nsec(inode, 0);
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
+				inode_ctime_set_sec(inode,
+						    iso_date(rr->u.TF.times[cnt++].time, 0));
+				inode_ctime_set_nsec(inode, 0);
 			}
 			break;
 		case SIG('S', 'L'):
@@ -534,7 +532,7 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 			inode->i_size = reloc->i_size;
 			inode->i_blocks = reloc->i_blocks;
 			inode->i_atime = reloc->i_atime;
-			inode->i_ctime = reloc->i_ctime;
+			inode_ctime_set(inode, inode_ctime_peek(reloc));
 			inode->i_mtime = reloc->i_mtime;
 			iput(reloc);
 			break;
-- 
2.41.0

