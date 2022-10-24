Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05052609FFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 13:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJXLNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 07:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJXLNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADF956013
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 04:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26AB66122A
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 11:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8E2C433C1;
        Mon, 24 Oct 2022 11:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609994;
        bh=XKCyJoc6+++Wkfyq/ZIUl2pMpSYehiYkJy4eoF0+fdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Be7vdqq9GLaSlHK4brtYWrNQ5/SkoLg05nc4LkLVBJYgR/093eAPxrwV03i7xsQ8b
         nkNPp4+NPQWRYJB6aK88moaavnMvNm/Fr/9I2O0t5/lXmTu8dCSJ+1GMSPYYzZG+0j
         0b94AiSYmAGx0eF2Cafw22oZPJ/eloJNzlPipBX4xMxGwTECfZKrpx5LK1dJQnz8Gc
         9V7Hvs6/zlCNWm2eeXyHBQT09HF3EWjpgyrU8q5jH41VY4sRgoL3+7W1Jcss67L06W
         hRh0OgzZHj9B+uCySeYQV1lc+jRk2mNnjRFEg4oJW1kefzfSBbuuRqq/bnXoek4Ssq
         sS7yhocC8Vevg==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 8/8] fs: remove unused idmapping helpers
Date:   Mon, 24 Oct 2022 13:12:49 +0200
Message-Id: <20221024111249.477648-9-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024111249.477648-1-brauner@kernel.org>
References: <20221024111249.477648-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6092; i=brauner@kernel.org; h=from:subject; bh=XKCyJoc6+++Wkfyq/ZIUl2pMpSYehiYkJy4eoF0+fdY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSHFevpNH5oXB+iqyT58ufeii+X4m+8vevTstmw0ilks73i xpnbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiUsfwV5A/d8X5jeY/VYq1Gn/aMA kXJdacZ89bEurXedfs5fuTZxj+51xN3azfOu9ph1arQBd30JkzIp/Wc2z+b3r6y6eSG6aHeQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all places can deal with the new type safe helpers remove all
of the old helpers.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:

 include/linux/fs.h            | 34 ------------------
 include/linux/mnt_idmapping.h | 68 -----------------------------------
 2 files changed, 102 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b39c5efca180..0951283f2515 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1612,23 +1612,6 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 	inode->i_gid = make_kgid(i_user_ns(inode), gid);
 }
 
-/**
- * i_uid_into_mnt - map an inode's i_uid down into a mnt_userns
- * @mnt_userns: user namespace of the mount the inode was found from
- * @inode: inode to map
- *
- * Note, this will eventually be removed completely in favor of the type-safe
- * i_uid_into_vfsuid().
- *
- * Return: the inode's i_uid mapped down according to @mnt_userns.
- * If the inode's i_uid has no mapping INVALID_UID is returned.
- */
-static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
-				    const struct inode *inode)
-{
-	return AS_KUIDT(make_vfsuid(mnt_userns, i_user_ns(inode), inode->i_uid));
-}
-
 /**
  * i_uid_into_vfsuid - map an inode's i_uid down into a mnt_userns
  * @mnt_userns: user namespace of the mount the inode was found from
@@ -1681,23 +1664,6 @@ static inline void i_uid_update(struct user_namespace *mnt_userns,
 					   attr->ia_vfsuid);
 }
 
-/**
- * i_gid_into_mnt - map an inode's i_gid down into a mnt_userns
- * @mnt_userns: user namespace of the mount the inode was found from
- * @inode: inode to map
- *
- * Note, this will eventually be removed completely in favor of the type-safe
- * i_gid_into_vfsgid().
- *
- * Return: the inode's i_gid mapped down according to @mnt_userns.
- * If the inode's i_gid has no mapping INVALID_GID is returned.
- */
-static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
-				    const struct inode *inode)
-{
-	return AS_KGIDT(make_vfsgid(mnt_userns, i_user_ns(inode), inode->i_gid));
-}
-
 /**
  * i_gid_into_vfsgid - map an inode's i_gid down into a mnt_userns
  * @mnt_userns: user namespace of the mount the inode was found from
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index cd1950ddc6a9..c8002294a72d 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -228,13 +228,6 @@ static inline vfsuid_t make_vfsuid(struct user_namespace *mnt_userns,
 	return VFSUIDT_INIT(make_kuid(mnt_userns, uid));
 }
 
-static inline kuid_t mapped_kuid_fs(struct user_namespace *mnt_userns,
-				    struct user_namespace *fs_userns,
-				    kuid_t kuid)
-{
-	return AS_KUIDT(make_vfsuid(mnt_userns, fs_userns, kuid));
-}
-
 /**
  * make_vfsgid - map a filesystem kgid into a mnt_userns
  * @mnt_userns: the mount's idmapping
@@ -273,13 +266,6 @@ static inline vfsgid_t make_vfsgid(struct user_namespace *mnt_userns,
 	return VFSGIDT_INIT(make_kgid(mnt_userns, gid));
 }
 
-static inline kgid_t mapped_kgid_fs(struct user_namespace *mnt_userns,
-				    struct user_namespace *fs_userns,
-				    kgid_t kgid)
-{
-	return AS_KGIDT(make_vfsgid(mnt_userns, fs_userns, kgid));
-}
-
 /**
  * from_vfsuid - map a vfsuid into the filesystem idmapping
  * @mnt_userns: the mount's idmapping
@@ -307,33 +293,6 @@ static inline kuid_t from_vfsuid(struct user_namespace *mnt_userns,
 	return make_kuid(fs_userns, uid);
 }
 
-/**
- * mapped_kuid_user - map a user kuid into a mnt_userns
- * @mnt_userns: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @kuid : kuid to be mapped
- *
- * Use the idmapping of @mnt_userns to remap a @kuid into @fs_userns. Use this
- * function when preparing a @kuid to be written to disk or inode.
- *
- * If no_idmapping() determines that this is not an idmapped mount we can
- * simply return @kuid unchanged.
- * If initial_idmapping() tells us that the filesystem is not mounted with an
- * idmapping we know the value of @kuid won't change when calling
- * make_kuid() so we can simply retrieve the value via KUIDT_INIT()
- * directly.
- *
- * Return: @kuid mapped according to @mnt_userns.
- * If @kuid has no mapping in either @mnt_userns or @fs_userns INVALID_UID is
- * returned.
- */
-static inline kuid_t mapped_kuid_user(struct user_namespace *mnt_userns,
-				      struct user_namespace *fs_userns,
-				      kuid_t kuid)
-{
-	return from_vfsuid(mnt_userns, fs_userns, VFSUIDT_INIT(kuid));
-}
-
 /**
  * vfsuid_has_fsmapping - check whether a vfsuid maps into the filesystem
  * @mnt_userns: the mount's idmapping
@@ -399,33 +358,6 @@ static inline kgid_t from_vfsgid(struct user_namespace *mnt_userns,
 	return make_kgid(fs_userns, gid);
 }
 
-/**
- * mapped_kgid_user - map a user kgid into a mnt_userns
- * @mnt_userns: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @kgid : kgid to be mapped
- *
- * Use the idmapping of @mnt_userns to remap a @kgid into @fs_userns. Use this
- * function when preparing a @kgid to be written to disk or inode.
- *
- * If no_idmapping() determines that this is not an idmapped mount we can
- * simply return @kgid unchanged.
- * If initial_idmapping() tells us that the filesystem is not mounted with an
- * idmapping we know the value of @kgid won't change when calling
- * make_kgid() so we can simply retrieve the value via KGIDT_INIT()
- * directly.
- *
- * Return: @kgid mapped according to @mnt_userns.
- * If @kgid has no mapping in either @mnt_userns or @fs_userns INVALID_GID is
- * returned.
- */
-static inline kgid_t mapped_kgid_user(struct user_namespace *mnt_userns,
-				      struct user_namespace *fs_userns,
-				      kgid_t kgid)
-{
-	return from_vfsgid(mnt_userns, fs_userns, VFSGIDT_INIT(kgid));
-}
-
 /**
  * vfsgid_has_fsmapping - check whether a vfsgid maps into the filesystem
  * @mnt_userns: the mount's idmapping
-- 
2.34.1

