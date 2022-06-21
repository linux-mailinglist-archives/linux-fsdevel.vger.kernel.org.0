Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D62553449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351007AbiFUOPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351038AbiFUOPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:15:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06382183E
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 07:15:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65839B8181A
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 14:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E3EC341C4;
        Tue, 21 Jun 2022 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655820914;
        bh=TNO83y83A2cmP6y4RCPvS78efH8ML95wWt7doFraseY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mrewakTqq/CfSE4IU6yYa6gJHWffTMyIImRLNJ/ootZWgMJ2dA90jB+bRixc3aLxO
         o1iZS1qZgdkS5rS8a4WjRpDMKG5i2aGAatLYpMJgmYAkLrUnZBcdYYDW9gO+sFLggD
         K1XpcwxSuA3wK5j2EX1j9s+WxgRawrI+p5lvf4lON2LAePdtYjKZ0OlXJp4TI1m6py
         qTUlCW+VVLsn5veRLlR305bQRO4cMXsrlNN2p04cjqOeCz3oiMkV4ip0pT2q3LSHkN
         Q46Eqs5jjcJ9xFM9ZIMsTx9pYbULC9HrCCf4++BcjfRzLE20sPl6Lv0tlkqmlckOn0
         d2YiU+l9EfOJQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 3/8] fs: use mount types in iattr
Date:   Tue, 21 Jun 2022 16:14:49 +0200
Message-Id: <20220621141454.2914719-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621141454.2914719-1-brauner@kernel.org>
References: <20220621141454.2914719-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3201; h=from:subject; bh=TNO83y83A2cmP6y4RCPvS78efH8ML95wWt7doFraseY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtvBS+8qLlh/fSl896fJRsOyDtvawqsnEd38vU6omFN/uq VBVaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSWcXwV7R+aeSdu1N+3O2bI3/g2/ skfs5/0T6rts6vumckzDi/1p+RYek90xTjeysPlx9+a7d116YHG7KapatYDO6/Xm7+toRDhQMA
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

Add ia_vfs{g,u}id members of type vfs{g,u}id_t to struct iattr. We use
an anonymous union (similar to what we do in struct file) around
ia_{g,u}id and ia_vfs{g,u}id.

At the end of this series ia_{g,u}id and ia_vfs{g,u}id will always
contain the same value independent of whether struct iattr is
initialized from an idmapped mount. This is a change from how this is
done today.

Wrapping this in a anonymous unions has a few advantages. It allows us
to avoid needlessly increasing struct iattr. Since the types for
ia_{g,u}id and ia_vfs{g,u}id are structures with overlapping/identical
members they are covered by 6.5.2.3/6 of the C standard and it is safe
to initialize and access them.

Filesystems that raise FS_ALLOW_IDMAP and thus support idmapped mounts
will have to use ia_vfs{g,u}id and the associated helpers. And will be
ported at the end of this series. They will immediately benefit from the
type safe new helpers.

Filesystems that do not support FS_ALLOW_IDMAP can continue to use
ia_{g,u}id for now. The aim is to convert every filesystem to always use
ia_vfs{g,u}id and thus ultimately remove the ia_{g,u}id members.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
/* v2 */
- Linus Torvalds <torvalds@linux-foundation.org>:
  - Rename s/kmnt{g,u}id_t/vfs{g,u}id_t/g
---
 include/linux/fs.h            | 18 ++++++++++++++++--
 include/linux/mnt_idmapping.h |  5 +++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2c0e8d634bc4..642627b3fa53 100644
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
+	 * Filesystems raising FS_ALLOW_IDMAP need to use ia_vfs{g,u}id which
+	 * are a dedicated type requiring the filesystem to use the dedicated
+	 * helpers. Other filesystem can continue to use ia_{g,u}id until they
+	 * have been ported.
+	 */
+	union {
+		kuid_t		ia_uid;
+		vfsuid_t	ia_vfsuid;
+	};
+	union {
+		kgid_t		ia_gid;
+		vfsgid_t	ia_vfsgid;
+	};
 	loff_t		ia_size;
 	struct timespec64 ia_atime;
 	struct timespec64 ia_mtime;
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 241e94663930..4c08e8705763 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -21,6 +21,11 @@ typedef struct {
 	gid_t val;
 } vfsgid_t;
 
+static_assert(sizeof(vfsuid_t) == sizeof(kuid_t));
+static_assert(sizeof(vfsgid_t) == sizeof(kgid_t));
+static_assert(offsetof(vfsuid_t, val) == offsetof(kuid_t, val));
+static_assert(offsetof(vfsgid_t, val) == offsetof(kgid_t, val));
+
 #ifdef CONFIG_MULTIUSER
 static inline uid_t __vfsuid_val(vfsuid_t uid)
 {
-- 
2.34.1

