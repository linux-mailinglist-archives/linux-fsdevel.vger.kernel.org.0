Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207EC53ADF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiFAUsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 16:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiFAUsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:48:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372C27F8B2;
        Wed,  1 Jun 2022 13:45:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E34211F4398A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654116303;
        bh=EYpe7jq8IZWr8tink05axuBf87GgQR+c3mze25uRf3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gu2U+x1xr9c68jrHWXNn9eK1h9sFH7RfO+WWdoaw+vkefkr38W4doINXmEvoPn1hF
         HJfJBJPf9iSbKwIETQtwBHyaJieDSdQi1hcifoJVebxIlltN3BT5yN/ftwK3zBajJV
         m37KAbWpRVzhxtbWir2I1V70xgAx5OVPomi6LYsh3/w/1c257PBAeWSORU0JSj6kPm
         Vwo31RfttlP7sa2Y1fPWWM7wOX9JNlEHiUdsQPn3SiyRQAYU1f7NtG7ZqN5wIaD1X4
         S4yvqr7NkQy7u1+NwemQVm0aWqY2s0QthVcsV6y8UeMPCk/sT/DyB6bcrq+CzuIJy5
         SOei/Uj4PJ/4A==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org
Cc:     ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 6/7] ext4: Enable negative dentries on case-insensitive lookup
Date:   Wed,  1 Jun 2022 16:44:36 -0400
Message-Id: <20220601204437.676872-7-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601204437.676872-1-krisman@collabora.com>
References: <20220601204437.676872-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of invalidating negative dentries during case-insensitive
lookups, mark them as such and let them be added to the dcache.
d_ci_revalidate is able to properly filter them out if necessary based
on the dentry casefold flag.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/namei.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 767b4bfe39c3..783ba0b186c1 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1800,16 +1800,9 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		}
 	}
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
-		/* Eventually we want to call d_add_ci(dentry, NULL)
-		 * for negative dentries in the encoding case as
-		 * well.  For now, prevent the negative dentry
-		 * from being cached.
-		 */
-		return NULL;
-	}
-#endif
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+		d_set_casefold_lookup(dentry);
+
 	return d_splice_alias(inode, dentry);
 }
 
@@ -3126,17 +3119,6 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	ext4_fc_track_unlink(handle, dentry);
 	retval = ext4_mark_inode_dirty(handle, dir);
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	/* VFS negative dentries are incompatible with Encoding and
-	 * Case-insensitiveness. Eventually we'll want avoid
-	 * invalidating the dentries here, alongside with returning the
-	 * negative dentries at ext4_lookup(), when it is better
-	 * supported by the VFS for the CI case.
-	 */
-	if (IS_CASEFOLDED(dir))
-		d_invalidate(dentry);
-#endif
-
 end_rmdir:
 	brelse(bh);
 	if (handle)
@@ -3231,16 +3213,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	retval = __ext4_unlink(handle, dir, &dentry->d_name, d_inode(dentry));
 	if (!retval)
 		ext4_fc_track_unlink(handle, dentry);
-#if IS_ENABLED(CONFIG_UNICODE)
-	/* VFS negative dentries are incompatible with Encoding and
-	 * Case-insensitiveness. Eventually we'll want avoid
-	 * invalidating the dentries here, alongside with returning the
-	 * negative dentries at ext4_lookup(), when it is  better
-	 * supported by the VFS for the CI case.
-	 */
-	if (IS_CASEFOLDED(dir))
-		d_invalidate(dentry);
-#endif
+
 	if (handle)
 		ext4_journal_stop(handle);
 
-- 
2.36.1

