Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3289B35A338
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhDIQ0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhDIQ0S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:26:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34B576103E;
        Fri,  9 Apr 2021 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985565;
        bh=/Hl5eHU8L4xr6JaOlwwlyG6clIdkW90gmNVCkqKbsJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnBOIp04pVcL4je5JxqNo+Q5HD23QWJ0wqjtE9noWMDU3YFNk4yfI87IYaFinoiuO
         ybiFqXHjtT6VM350vRtJmE7/HXin3vFCa+Tf7d+ZDWzHDOcBJaxc12nj8qQ1KUTgOI
         Z2RAPV3e4feiaJ81tPsus8CNtAULeP3Ytz5a1ROfTR4OyDnBiMz0ghL9ZG/FzcbBYA
         W4ihsHmPH1Vu0m1BA/sdfqEVLZlLlGfkl/9PMIIvd5uSKg3jUmlZNVyqhMMFNbI8/9
         RyKnlSMT6KW1NZ7y/kVYc816UT+iT4EK9HaeKpg5N91S6sO4Zww3DcjUnuekN7yxyP
         /H4FYI+ZeJ7Qw==
From:   Christian Brauner <brauner@kernel.org>
To:     Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/3] ecryptfs: extend ro check to private mount
Date:   Fri,  9 Apr 2021 18:24:22 +0200
Message-Id: <20210409162422.1326565-4-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210409162422.1326565-1-brauner@kernel.org>
References: <20210409162422.1326565-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=TJq3ADscBRuq3vVMRrZQ25nFLYThkfCmWR4OfInmRrw=; m=1ciTf4lEciTeOTFMYE8Ti/zNFh88dj9ns8fWVydD8Es=; p=lH6ypLy7nBSAU1Y8+OlROQnduiSVhzKO3zb3sUcPmzw=; g=0d107768135058226d796803890d0dee0a0e7ec6
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHB/qwAKCRCRxhvAZXjcoqPRAQDNdrN i3wEqHRmR7SJY4F0Q5iNfmpejbX7iJwoaooOKIQD+ONXL9uXlqTTTfpuw2HNXE7y9BIaV0nX4TY+o Bx2U+ww=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

So far ecryptfs only verified that the superblock wasn't read-only but
didn't check whether the mount was. This made sense when we did not use
a private mount because the read-only state could change at any point.

Now that we have a private mount and mount properties can't change
behind our back extend the read-only check to include the vfsmount.

The __mnt_is_readonly() helper will check both the mount and the
superblock.  Note that before we checked root->d_sb and now we check
mnt->mnt_sb but since we have a matching <vfsmount, dentry> pair here
this is only syntactical change, not a semantic one.

Overlayfs and cachefiles have been changed to check this as well.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/ecryptfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 9dcf9a0dd37b..cdf37d856c62 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -569,7 +569,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 	 *   1) The lower mount is ro
 	 *   2) The ecryptfs_encrypted_view mount option is specified
 	 */
-	if (sb_rdonly(path.dentry->d_sb) || mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)
+	if (__mnt_is_readonly(mnt) || mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)
 		s->s_flags |= SB_RDONLY;
 
 	s->s_maxbytes = path.dentry->d_sb->s_maxbytes;
-- 
2.27.0

