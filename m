Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4A553446
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 16:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350645AbiFUOPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350641AbiFUOPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B220F62
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 07:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C2E161653
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 14:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE5AC3411D;
        Tue, 21 Jun 2022 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655820909;
        bh=j05YIAOTtkdZXSTCb8EuTK0aGvCWiywPlzGy++qdZKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSogg6CbVAIqtPTXE1dQX8MTkcpiv/Mj8OabcGblPtH6cFUAWdyjQktDt1BCx5V9m
         121PfMZQfpWZkK3hF9VkAdK2O/oy97rOkYK21h3IX0AorwIt70EG2Axl0wNCYI1QKw
         r9xlc6idpgUfuz+2FcTIZeffadmtZmMSpamNmPkNdTFpo3ZbTw3ZsDXhw9QiaOJqRn
         I3foR9DoH04taXRCgaZt+47zgWS4WWIY2aENqtYtqcPmF3XcJFMdOebqVw9MZ8esUB
         Pa++rxHx3NWCUsUyXnFEBoqFoYE2YcT+X3VtPvxQOkaqBKY8AZCh2UjyF99TQ3gY/N
         9Z9oCQuM37/aw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 1/8] mnt_idmapping: add vfs{g,u}id_t
Date:   Tue, 21 Jun 2022 16:14:47 +0200
Message-Id: <20220621141454.2914719-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621141454.2914719-1-brauner@kernel.org>
References: <20220621141454.2914719-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8589; h=from:subject; bh=j05YIAOTtkdZXSTCb8EuTK0aGvCWiywPlzGy++qdZKk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtvBS2iv2TwxWeSVye/xQ2lLU4WVrcm8Jy7AqHieZ0k1zX +95PO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay4BLD/zTTHinBN+d1bl3bIdH1ag mj6Le5vRxT3yyI/nz19NFJ6rsZ/me90uM+dXoVd8JzB31uexsXp3f5ay5vylyn07T6xLf52bwA
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

Introduces new vfs{g,u}id_t types. Similar to k{g,u}id_t the new types
are just simple wrapper structs around regular {g,u}id_t types.

They allows to establish a type safety boundary between {g,u}ids on
idmapped mounts and {g,u}ids as they are represented in filesystems
themselves.

A vfs{g,u}id_t is always created from a k{g,u}id_t, never directly from
a {g,u}id_t as idmapped mounts remap a given {g,u}id according to the
mount's idmapping. This is expressed in the VFS{G,U}IDT_INIT() macros.

A vfs{g,u}id_t may be used as a k{g,u}id_t via AS_K{G,U}IDT(). This
often happens when we need to check whether a {g,u}id mapped according
to an idmapped mount is identical to a given k{g,u}id_t. For an example,
see vfsgid_in_group_p() which determines whether the value of vfsgid_t
matches the value of any of the caller's groups. Similar logic is
expressed in the k{g,u}id_eq_vfs{g,u}id().

The vfs{g,u}id_to_k{g,u}id() helpers map a given vfs{g,u}id_t from the
mount's idmapping into the filesystem idmapping. They make it possible
to update a filesystem object such as inode->i_{g,u}id with the correct
value.

This makes it harder to accidently write a wrong {g,u}id anwywhere. The
vfs{g,u}id_has_mapping() helpers check whether a given vfs{g,u}id_t can
be represented in the filesystem idmapping.

All new helpers are nops on non-idmapped mounts.

I've done work on this roughly 7 months ago but dropped it to focus on
the testsuite. Linus brought this up independently just last week and
it's time to move this along (see [1]).

[1]: https://lore.kernel.org/lkml/CAHk-=win6+ahs1EwLkcq8apqLi_1wXFWbrPf340zYEhObpz4jA@mail.gmail.com
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
 include/linux/mnt_idmapping.h | 190 ++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index ee5a217de2a8..241e94663930 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -13,6 +13,122 @@ struct user_namespace;
  */
 extern struct user_namespace init_user_ns;
 
+typedef struct {
+	uid_t val;
+} vfsuid_t;
+
+typedef struct {
+	gid_t val;
+} vfsgid_t;
+
+#ifdef CONFIG_MULTIUSER
+static inline uid_t __vfsuid_val(vfsuid_t uid)
+{
+	return uid.val;
+}
+
+static inline gid_t __vfsgid_val(vfsgid_t gid)
+{
+	return gid.val;
+}
+#else
+static inline uid_t __vfsuid_val(vfsuid_t uid)
+{
+	return 0;
+}
+
+static inline gid_t __vfsgid_val(vfsgid_t gid)
+{
+	return 0;
+}
+#endif
+
+static inline bool vfsuid_valid(vfsuid_t uid)
+{
+	return __vfsuid_val(uid) != (uid_t)-1;
+}
+
+static inline bool vfsgid_valid(vfsgid_t gid)
+{
+	return __vfsgid_val(gid) != (gid_t)-1;
+}
+
+/**
+ * kuid_eq_vfsuid - check whether kuid and vfsuid have the same value
+ * @kuid: the kuid to compare
+ * @vfsuid: the vfsuid to compare
+ *
+ * Check whether @kuid and @vfsuid have the same values.
+ *
+ * Return: true if @kuid and @vfsuid have the same value, false if not.
+ */
+static inline bool kuid_eq_vfsuid(kuid_t kuid, vfsuid_t vfsuid)
+{
+	return __vfsuid_val(vfsuid) == __kuid_val(kuid);
+}
+
+/**
+ * kgid_eq_vfsgid - check whether kgid and vfsgid have the same value
+ * @kgid: the kgid to compare
+ * @vfsgid: the vfsgid to compare
+ *
+ * Check whether @kgid and @vfsgid have the same values.
+ *
+ * Return: true if @kgid and @vfsgid have the same value, false if not.
+ */
+static inline bool kgid_eq_vfsgid(kgid_t kgid, vfsgid_t vfsgid)
+{
+	return __vfsgid_val(vfsgid) == __kgid_val(kgid);
+}
+
+static inline bool vfsuid_eq(vfsuid_t left, vfsuid_t right)
+{
+	return __vfsuid_val(left) == __vfsuid_val(right);
+}
+
+static inline bool vfsgid_eq(vfsgid_t left, vfsgid_t right)
+{
+	return __vfsgid_val(left) == __vfsgid_val(right);
+}
+
+/*
+ * vfs{g,u}ids are created from k{g,u}ids.
+ * We don't allow them to be created from regular {u,g}id.
+ */
+#define VFSUIDT_INIT(val) (vfsuid_t){ __kuid_val(val) }
+#define VFSGIDT_INIT(val) (vfsgid_t){ __kgid_val(val) }
+
+#define INVALID_VFSUID VFSUIDT_INIT(INVALID_UID)
+#define INVALID_VFSGID VFSGIDT_INIT(INVALID_GID)
+
+/*
+ * Allow a vfs{g,u}id to be used as a k{g,u}id where we want to compare
+ * whether the mapped value is identical to value of a k{g,u}id.
+ */
+#define AS_KUIDT(val) (kuid_t){ __vfsuid_val(val) }
+#define AS_KGIDT(val) (kgid_t){ __vfsgid_val(val) }
+
+#ifdef CONFIG_MULTIUSER
+/**
+ * vfsgid_in_group_p() - check whether a vfsuid matches the caller's groups
+ * @vfsgid: the mnt gid to match
+ *
+ * This function can be used to determine whether @vfsuid matches any of the
+ * caller's groups.
+ *
+ * Return: 1 if vfsuid matches caller's groups, 0 if not.
+ */
+static inline int vfsgid_in_group_p(vfsgid_t vfsgid)
+{
+	return in_group_p(AS_KGIDT(vfsgid));
+}
+#else
+static inline int vfsgid_in_group_p(vfsgid_t vfsgid)
+{
+	return 1;
+}
+#endif
+
 /**
  * initial_idmapping - check whether this is the initial mapping
  * @ns: idmapping to check
@@ -157,6 +273,43 @@ static inline kuid_t mapped_kuid_user(struct user_namespace *mnt_userns,
 	return make_kuid(fs_userns, uid);
 }
 
+/**
+ * vfsuid_to_kuid - map a vfsuid into the filesystem idmapping
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @vfsuid : vfsuid to be mapped
+ *
+ * Map @vfsuid into the filesystem idmapping. This function has to be used in
+ * order to e.g. write @vfsuid to inode->i_uid.
+ *
+ * Return: @vfsuid mapped into the filesystem idmapping
+ */
+static inline kuid_t vfsuid_to_kuid(struct user_namespace *mnt_userns,
+				    struct user_namespace *fs_userns,
+				    vfsuid_t vfsuid)
+{
+	return mapped_kuid_user(mnt_userns, fs_userns, AS_KUIDT(vfsuid));
+}
+
+/**
+ * vfsuid_has_mapping - check whether a vfsuid maps into the filesystem
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @vfsuid: vfsuid to be mapped
+ *
+ * Check whether @vfsuid has a mapping in the filesystem idmapping. Use this
+ * function to check whether the filesystem idmapping has a mapping for
+ * @vfsuid.
+ *
+ * Return: true if @vfsuid has a mapping in the filesystem, false if not.
+ */
+static inline bool vfsuid_has_mapping(struct user_namespace *mnt_userns,
+				      struct user_namespace *fs_userns,
+				      vfsuid_t vfsuid)
+{
+	return uid_valid(vfsuid_to_kuid(mnt_userns, fs_userns, vfsuid));
+}
+
 /**
  * mapped_kgid_user - map a user kgid into a mnt_userns
  * @mnt_userns: the mount's idmapping
@@ -193,6 +346,43 @@ static inline kgid_t mapped_kgid_user(struct user_namespace *mnt_userns,
 	return make_kgid(fs_userns, gid);
 }
 
+/**
+ * vfsgid_to_kgid - map a vfsgid into the filesystem idmapping
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @vfsgid : vfsgid to be mapped
+ *
+ * Map @vfsgid into the filesystem idmapping. This function has to be used in
+ * order to e.g. write @vfsgid to inode->i_gid.
+ *
+ * Return: @vfsgid mapped into the filesystem idmapping
+ */
+static inline kgid_t vfsgid_to_kgid(struct user_namespace *mnt_userns,
+				    struct user_namespace *fs_userns,
+				    vfsgid_t vfsgid)
+{
+	return mapped_kgid_user(mnt_userns, fs_userns, AS_KGIDT(vfsgid));
+}
+
+/**
+ * vfsgid_has_mapping - check whether a vfsgid maps into the filesystem
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @vfsgid: vfsgid to be mapped
+ *
+ * Check whether @vfsgid has a mapping in the filesystem idmapping. Use this
+ * function to check whether the filesystem idmapping has a mapping for
+ * @vfsgid.
+ *
+ * Return: true if @vfsgid has a mapping in the filesystem, false if not.
+ */
+static inline bool vfsgid_has_mapping(struct user_namespace *mnt_userns,
+				      struct user_namespace *fs_userns,
+				      vfsgid_t vfsgid)
+{
+	return gid_valid(vfsgid_to_kgid(mnt_userns, fs_userns, vfsgid));
+}
+
 /**
  * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
  * @mnt_userns: the mount's idmapping
-- 
2.34.1

