Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC3551EF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiFTOfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245099AbiFTOeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:34:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC81938B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 06:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8C45B80B95
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 13:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77435C341C0;
        Mon, 20 Jun 2022 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655733007;
        bh=WBo2KDi3tcjgyyBk/6HvvPlktRUrhHSQLUOeSEPBtWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckz2K/f7JAT/lwX6SPEOgVqv2oFS6FhN8YBfH4v93y/YJfQJKKUQ0l+jlXLqxqxLz
         Dx5IXF44GRF/rcHY8CdigWMwARMQHEz02TP2XZp3+LC37LwpQKuM7cfFTwqLpAalcp
         xDlbtYoo+hfaoKPQwsXwHI3PztVlA8n+A3HljS1p1B38ysLCBqliO4IPqqVeLR9PUy
         CPfQ5qxAz3WKFsjoisZaxtoCoWAyzLxIwSeJ1mju8U+wipk/ytnRdyZRTRU9+1B6F1
         AUEcyQ+TZZY3rUaj7splHajt9mOiZMfditzm4JkxAFk87aZSPyuxITdAB3x+c2huWO
         eFlfF6VE9Vk1A==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3/8] fs: use mount types in iattr
Date:   Mon, 20 Jun 2022 15:49:42 +0200
Message-Id: <20220620134947.2772863-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620134947.2772863-1-brauner@kernel.org>
References: <20220620134947.2772863-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3102; h=from:subject; bh=WBo2KDi3tcjgyyBk/6HvvPlktRUrhHSQLUOeSEPBtWc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtqHqT73fI/rnhXI9fXnvXM/dbHrM8p/1xsvtqn+VaaRfN eI5nd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk83OG/6GBF6406U98dPQa35Jg7v nqb8x2lFe4OGfoKGbz3+BVnMLw350x4xp/dfPBY6sOHrmdxbLPKmjG209sTl227VO2Pbs7gxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add ia_mnt{g,u}id members of type kmnt{g,u}id_t to struct iattr. We use
an anonymous union (similar to what we do in struct file) around
ia_{g,u}id and ia_mnt{g,u}id.

At the end of this series ia_{g,u}id and ia_mnt{g,u}id will always
contain the same value independent of whether struct iattr is
initialized from an idmapped mount. This is a change from how this is
done today.

Wrapping this in a anonymous unions has a few advantages. It allows us
to avoid needlessly increasing struct iattr. Since the types for
ia_{g,u}id and ia_mnt{g,u}id are structures with overlapping/identical
members they are covered by 6.5.2.3/6 of the C standard and it is safe
to initialize and access them.

Filesystems that raise FS_ALLOW_IDMAP and thus support idmapped mounts
will have to use ia_mnt{g,u}id and the associated helpers. And will be
ported at the end of this series. They will immediately benefit from the
type safe new helpers.

Filesystems that do not support FS_ALLOW_IDMAP can continue to use
ia_{g,u}id for now. The aim is to convert every filesystem to always use
ia_mnt{g,u}id and thus ultimately remove the ia_{g,u}id members.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 include/linux/fs.h            | 18 ++++++++++++++++--
 include/linux/mnt_idmapping.h |  5 +++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8724a31b95e5..0da6c0481dbd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -221,8 +221,22 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 struct iattr {
 	unsigned int	ia_valid;
 	umode_t		ia_mode;
-	kuid_t		ia_uid;
-	kgid_t		ia_gid;
+	/*
+	 * The two anonymous unions wrap structures with the same member.
+	 *
+	 * Filesystems raising FS_ALLOW_IDMAP need to use ia_mnt{g,u}id which
+	 * are a dedicated type requiring the filesystem to use the dedicated
+	 * helpers. Other filesystem can continue to use ia_{g,u}id until they
+	 * have been ported.
+	 */
+	union {
+		kuid_t		ia_uid;
+		kmntuid_t	ia_mntuid;
+	};
+	union {
+		kgid_t		ia_gid;
+		kmntgid_t	ia_mntgid;
+	};
 	loff_t		ia_size;
 	struct timespec64 ia_atime;
 	struct timespec64 ia_mtime;
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 8dbaef494e02..8f555c746cf4 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -21,6 +21,11 @@ typedef struct {
 	gid_t val;
 } kmntgid_t;
 
+static_assert(sizeof(kmntuid_t) == sizeof(kuid_t));
+static_assert(sizeof(kmntgid_t) == sizeof(kgid_t));
+static_assert(offsetof(kmntuid_t, val) == offsetof(kuid_t, val));
+static_assert(offsetof(kmntgid_t, val) == offsetof(kgid_t, val));
+
 #ifdef CONFIG_MULTIUSER
 static inline uid_t __kmntuid_val(kmntuid_t uid)
 {
-- 
2.34.1

