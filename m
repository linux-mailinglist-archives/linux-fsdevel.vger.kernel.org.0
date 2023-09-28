Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8C27B19FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjI1LIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjI1LGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:06:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A32510C6;
        Thu, 28 Sep 2023 04:05:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F15C433CC;
        Thu, 28 Sep 2023 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899106;
        bh=jyTlbEqdJh2wB+IlPAIFORUE7JGCL8t/h9lCWdSm0d0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UmaYDdyKFky7AbFnDrBvPRtpuLXmR6/0ne5F6HJX53ShWjgLL4j+fcSnoLviuweSE
         VEnqF+nDQ379HtLpub5tJfg0gKtgCgLAQhhdZYj6yaULpma+dEf/JYuBprQ9tFnNCv
         R4IvCRSDPNc+IKFNM3I/gZc/UYaTa3esk7Anw/w89i4puGUDMt6yODzUWtAFgnNBI7
         jtoX4TQrRx2hSBHu1vqKI8s2/d5DINsnaw8wiKwI9ljkkSRHOA1huVeZAx4h1qazc/
         wrz1nexVR2R4hJYQHQ9T55uq+u/bcjkBuY1ehu8vFuXEX+3SHZmStqr1G4c0GY8lai
         rhHj9Guqh0uQg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 45/87] fs/isofs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:54 -0400
Message-ID: <20230928110413.33032-44-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/isofs/inode.c |  4 ++--
 fs/isofs/rock.c  | 18 ++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 2ee21286ac8f..3e4d53e26f94 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1422,8 +1422,8 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 			inode->i_ino, de->flags[-high_sierra]);
 	}
 #endif
-	inode->i_mtime = inode->i_atime =
-		inode_set_ctime(inode, iso_date(de->date, high_sierra), 0);
+	inode_set_mtime_to_ts(inode,
+			      inode_set_atime_to_ts(inode, inode_set_ctime(inode, iso_date(de->date, high_sierra), 0)));
 
 	ei->i_first_extent = (isonum_733(de->extent) +
 			isonum_711(de->ext_attr_length));
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 348783a70f57..d6c17ad69dee 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -426,16 +426,14 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 						0);
 			}
 			if (rr->u.TF.flags & TF_MODIFY) {
-				inode->i_mtime.tv_sec =
-				    iso_date(rr->u.TF.times[cnt++].time,
-					     0);
-				inode->i_mtime.tv_nsec = 0;
+				inode_set_mtime(inode,
+						iso_date(rr->u.TF.times[cnt++].time, 0),
+						0);
 			}
 			if (rr->u.TF.flags & TF_ACCESS) {
-				inode->i_atime.tv_sec =
-				    iso_date(rr->u.TF.times[cnt++].time,
-					     0);
-				inode->i_atime.tv_nsec = 0;
+				inode_set_atime(inode,
+						iso_date(rr->u.TF.times[cnt++].time, 0),
+						0);
 			}
 			if (rr->u.TF.flags & TF_ATTRIBUTES) {
 				inode_set_ctime(inode,
@@ -531,9 +529,9 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 			inode->i_rdev = reloc->i_rdev;
 			inode->i_size = reloc->i_size;
 			inode->i_blocks = reloc->i_blocks;
-			inode->i_atime = reloc->i_atime;
+			inode_set_atime_to_ts(inode, inode_get_atime(reloc));
 			inode_set_ctime_to_ts(inode, inode_get_ctime(reloc));
-			inode->i_mtime = reloc->i_mtime;
+			inode_set_mtime_to_ts(inode, inode_get_mtime(reloc));
 			iput(reloc);
 			break;
 #ifdef CONFIG_ZISOFS
-- 
2.41.0

