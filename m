Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B297B8BB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbjJDSzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244899AbjJDSzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A247C1AC;
        Wed,  4 Oct 2023 11:54:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6951C433C7;
        Wed,  4 Oct 2023 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445680;
        bh=k4ZUpa6J1BuoVYWAGoQizbF/tb9dzfYDbjoaj3H865A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QF+ZtPgJltvkZ4wRlkydlrJjExkxPnb8w2VS8k2wz7RTDqIUo3j0UfEKsNWAjMFjw
         thFbyy6TvHMMJGOu02xNjKYxXFg+DXpGKuCTVou4Zr1OKeiwwEHg40N4Jp+/37ohon
         gRy7sFEP/UmyWoxws7W3m9gVQxYPpIf9f9R360tW1jLjR0RoCHmHke3E6RadBIUsWJ
         ogb8CCIR1Nvyb/EwlTwyTxN4a4EzP+CsC/m59vk8Bq3Kk4svptI/RhrQpNJ0sTqJ28
         pq70nbhxdWY9OFp667eFyJVYtxtZWcYyayR82+gwo7IjUPZ0NNC4o8msKiMzozNwFb
         Bc41YRa6vHtPw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 46/89] isofs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:31 -0400
Message-ID: <20231004185347.80880-44-jlayton@kernel.org>
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

