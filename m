Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB643B71A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhJZQ1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 12:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237382AbhJZQ1Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:27:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B1FA603E9;
        Tue, 26 Oct 2021 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635265491;
        bh=4grgM8bgYCxXbzH/TXpocp14Y8X0eHTROfsAj7+b4N0=;
        h=From:To:Cc:Subject:Date:From;
        b=WE5w0qRfqMz7e354YtJvjXI9U6HzP2XulVtvN8g+xZ6IO5KEG4gdBbDP8hw6K5d7j
         gqPzEa7IR49Ks53UnME1S8R8FRYrNT/9JTySRGvq6uw9iCd5XcrGtOUfJj7BGD2Rnt
         dxxBy3AssDa7oCO5HoOsmZqcIXUCj6Mnje1x/5ryoZbSNK5bYauR/GQOyrMkFRyBOL
         0lMsrlTYQ2i9DRD5RH1iSVKiofjwWBaGT8R+nT58okpOIA/yXyAZO/eR2TDFB9Ztjp
         4nCh/ZK76gf7stqZYNcPxm9njOxwNzQmbWUkGSv8tQ1L2PA9jnk1kFioQ4Zjtl9Vs9
         Ai5ZbC8lljNsQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: remove leftover comments from mandatory locking removal
Date:   Tue, 26 Oct 2021 12:24:49 -0400
Message-Id: <20211026162449.60283-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stragglers from commit f7e33bdbd6d1 ("fs: remove mandatory file locking
support").

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c      | 4 +---
 fs/read_write.c | 4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

Al, I'll plan to merge this along with my locking changes for v5.16. Let
me know if you'd prefer it to go in via your vfs tree.

Thanks,
Jeff

diff --git a/fs/namei.c b/fs/namei.c
index 95a881e0552b..b05e6840df74 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3074,9 +3074,7 @@ static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
 	int error = get_write_access(inode);
 	if (error)
 		return error;
-	/*
-	 * Refuse to truncate files with mandatory locks held on them.
-	 */
+
 	error = security_path_truncate(path);
 	if (!error) {
 		error = do_truncate(mnt_userns, path->dentry, 0,
diff --git a/fs/read_write.c b/fs/read_write.c
index af057c57bdc6..0074afa7ecb3 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -368,10 +368,6 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 	if (unlikely((ssize_t) count < 0))
 		return -EINVAL;
 
-	/*
-	 * ranged mandatory locking does not apply to streams - it makes sense
-	 * only for files where position has a meaning.
-	 */
 	if (ppos) {
 		loff_t pos = *ppos;
 
-- 
2.31.1

