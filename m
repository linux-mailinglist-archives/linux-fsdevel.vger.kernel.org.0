Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4DE5A4C79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiH2MxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiH2Mwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:52:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1D51A3A4
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FE97611FE
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 12:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3E2C433C1;
        Mon, 29 Aug 2022 12:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661776906;
        bh=9372B5E7tKt8qHWY70n1a+Q48LPguh5c4b+PfePwQsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bseX7HKIcFt4u+teEtu1wBq0oz8C9m6BLs0amG+U9h4vmVsdf2UFR2hcZgGlifyma
         0w//25lJ6nKeirld/Jj36v+4WhA7snj9baLxLPCde8/TcRgw1vY11Pr8vTpjN/VbPb
         /1TH/lS4rhGWAaK/pkokWhDwzPO0XASIqvg+ATimbS7gWuJTlcJshoLp4Kq+uP76g3
         crUBpuk29xDoPAGz2jBR2eN5m3M5LszTATaIyMrq9xjOjeQ/ZBH0wLmKXvOzI3oUeU
         qjlCb6o2YXMB54utzuclKNC9epoSwfqfJS//9WaRAhTmt5S49iTtEP4rLmrF2hezHZ
         HJ0brgP4MDv2w==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Date:   Mon, 29 Aug 2022 14:38:42 +0200
Message-Id: <20220829123843.1146874-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829123843.1146874-1-brauner@kernel.org>
References: <20220829123843.1146874-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16314; i=brauner@kernel.org; h=from:subject; bh=9372B5E7tKt8qHWY70n1a+Q48LPguh5c4b+PfePwQsg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTzbPo9/9zmQ+dT+CKPBKbd3qndvX7el+V/rIsjlrMbpW08 7nv/QkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEZpYyMhxluNXXaHTitDufmIzniS vW3A/2JoZ8Wjj50Yz57o8/mnczMvwIsd8gphxs9WGnplbiu6uJubMvvbGKmjfzpb3wSXcvPwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Various filesystems store POSIX ACLs on the backing store in their uapi
format. Such filesystems need to translate from the uapi POSIX ACL
format into the VFS format during i_op->get_acl(). The VFS provides the
posix_acl_from_xattr() helper for this task.

But the usage of posix_acl_from_xattr() is currently ambiguous. It is
intended to transform from a uapi POSIX ACL  to the VFS represenation.
For example, when retrieving POSIX ACLs for permission checking during
lookup or when calling getxattr() to retrieve system.posix_acl_{access,default}.

Calling posix_acl_from_xattr() during i_op->get_acl() will map the raw
{g,u}id values stored as ACL_{GROUP,USER} entries in the uapi POSIX ACL
format into k{g,u}id_t in the filesystem's idmapping and return a struct
posix_acl ready to be returned to the VFS for caching and to perform
permission checks on.

However, posix_acl_from_xattr() is also called during setxattr() for all
filesystems that rely on VFS provides posix_acl_{access,default}_xattr_handler.
The posix_acl_xattr_set() handler which is used for the ->set() method
of posix_acl_{access,default}_xattr_handler uses posix_acl_from_xattr()
to translate from the uapi POSIX ACL format to the VFS format so that it
can be passed to the i_op->set_acl() handler of the filesystem or for
direct caching in case no i_op->set_acl() handler is defined.

During setxattr() the {g,u}id values stored as ACL_{GROUP,USER} entries
in the uapi POSIX ACL format aren't raw {g,u}id values that need to be
mapped according to the filesystem's idmapping. Instead they are {g,u}id
values in the caller's idmapping which have been generated during
posix_acl_fix_xattr_from_user(). In other words, they are k{g,u}id_t
which are passed as raw {g,u}id values abusing the uapi POSIX ACL format
(Please note that this type safety violation has existed since the
introduction of k{g,u}id_t. Please see [1] for more details.).

So when posix_acl_from_xattr() is called in posix_acl_xattr_set() the
filesystem idmapping is completely irrelevant. Instead, we abuse the
initial idmapping to recover the k{g,u}id_t base on the value stored in
raw {g,u}id as ACL_{GROUP,USER} in the uapi POSIX ACL format.

We need to clearly distinguish betweeen these two operations as it is
really easy to confuse for filesystems as can be seen in ntfs3.

In order to do this we factor out make_posix_acl() which takes callbacks
allowing callers to pass dedicated methods to generate the correct
k{g,u}id_t. This is just an internal static helper which is not exposed
to any filesystems but it neatly encapsulates the basic logic of walking
through a uapi POSIX ACL and returning an allocated VFS POSIX ACL with
the correct k{g,u}id_t values.

The posix_acl_from_xattr() helper can then be implemented as a simple
call to make_posix_acl() with callbacks that generate the correct
k{g,u}id_t from the raw {g,u}id values in ACL_{GROUP,USER} entries in
the uapi POSIX ACL format as read from the backing store.

For setxattr() we add a new helper vfs_set_acl_prepare() which has
callbacks to map the POSIX ACLs from the uapi format with the k{g,u}id_t
values stored in raw {g,u}id format in ACL_{GROUP,USER} entries into the
correct k{g,u}id_t values in the filesystem idmapping. In contrast to
posix_acl_from_xattr() the vfs_set_acl_prepare() helper needs to take
the mount idmapping into account. The differences are explained in more
detail in the kernel doc for the new functions.

In follow up patches we will remove all abuses of posix_acl_from_xattr()
for setxattr() operations and replace it with calls to vfs_set_acl_prepare().

The new vfs_set_acl_prepare() helper allows us to deal with the
ambiguity in how the POSI ACL uapi struct stores {g,u}id values
depending on whether this is a getxattr() or setxattr() operation.

This also allows us to remove the posix_acl_setxattr_idmapped_mnt()
helper reducing the abuse of the POSIX ACL uapi format to pass values
that should be distinct types in {g,u}id values stored as
ACL_{GROUP,USER} entries.

The removal of posix_acl_setxattr_idmapped_mnt() in turn allows us to
re-constify the value parameter of vfs_setxattr() which in turn allows
us to avoid the nasty cast from a const void pointer to a non-const void
pointer on ovl_do_setxattr().

Ultimately, the plan is to get rid of the type violations completely and
never pass the values from k{g,u}id_t as raw {g,u}id in ACL_{GROUP,USER}
entries in uapi POSIX ACL format. But that's a longer way to go and this
is a preparatory step.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Co-Developed-by: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/posix_acl.c                  | 213 ++++++++++++++++++++++++++++++--
 include/linux/posix_acl_xattr.h |   3 +
 2 files changed, 205 insertions(+), 11 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index abe387700ba9..31eac28e6582 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -857,12 +857,32 @@ void posix_acl_fix_xattr_to_user(void *value, size_t size)
 	posix_acl_fix_xattr_userns(user_ns, &init_user_ns, value, size);
 }
 
-/*
- * Convert from extended attribute to in-memory representation.
+/**
+ * make_posix_acl - convert POSIX ACLs from uapi to VFS format using the
+ *                  provided callbacks to map ACL_{GROUP,USER} entries into the
+ *                  appropriate format
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @value: the uapi representation of POSIX ACLs
+ * @size: the size of @void
+ * @uid_cb: callback to use for mapping the uid stored in ACL_USER entries
+ * @gid_cb: callback to use for mapping the gid stored in ACL_GROUP entries
+ *
+ * The make_posix_acl() helper is an abstraction to translate from uapi format
+ * into the VFS format allowing the caller to specific callbacks to map
+ * ACL_{GROUP,USER} entries into the expected format. This is used in
+ * posix_acl_from_xattr() and vfs_set_acl_prepare() and avoids pointless code
+ * duplication.
+ *
+ * Return: Allocated struct posix_acl on success, NULL for a valid header but
+ *         without actual POSIX ACL entries, or ERR_PTR() encoded error code.
  */
-struct posix_acl *
-posix_acl_from_xattr(struct user_namespace *user_ns,
-		     const void *value, size_t size)
+static struct posix_acl *make_posix_acl(struct user_namespace *mnt_userns,
+	struct user_namespace *fs_userns, const void *value, size_t size,
+	kuid_t (*uid_cb)(struct user_namespace *, struct user_namespace *,
+			 const struct posix_acl_xattr_entry *),
+	kgid_t (*gid_cb)(struct user_namespace *, struct user_namespace *,
+			 const struct posix_acl_xattr_entry *))
 {
 	const struct posix_acl_xattr_header *header = value;
 	const struct posix_acl_xattr_entry *entry = (const void *)(header + 1), *end;
@@ -893,16 +913,12 @@ posix_acl_from_xattr(struct user_namespace *user_ns,
 				break;
 
 			case ACL_USER:
-				acl_e->e_uid =
-					make_kuid(user_ns,
-						  le32_to_cpu(entry->e_id));
+				acl_e->e_uid = uid_cb(mnt_userns, fs_userns, entry);
 				if (!uid_valid(acl_e->e_uid))
 					goto fail;
 				break;
 			case ACL_GROUP:
-				acl_e->e_gid =
-					make_kgid(user_ns,
-						  le32_to_cpu(entry->e_id));
+				acl_e->e_gid = gid_cb(mnt_userns, fs_userns, entry);
 				if (!gid_valid(acl_e->e_gid))
 					goto fail;
 				break;
@@ -917,6 +933,181 @@ posix_acl_from_xattr(struct user_namespace *user_ns,
 	posix_acl_release(acl);
 	return ERR_PTR(-EINVAL);
 }
+
+/**
+ * vfs_set_acl_prepare_kuid - map ACL_USER uid according to mount- and
+ *                            filesystem idmapping
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @e: a ACL_USER entry in POSIX ACL uapi format
+ *
+ * The uid stored as ACL_USER entry in @e is a kuid_t stored as a raw {g,u}id
+ * value. The vfs_set_acl_prepare_kuid() will recover the kuid_t through
+ * KUIDT_INIT() and then map it according to the idmapped mount. The resulting
+ * kuid_t is the value which the filesystem can map up into a raw backing store
+ * id in the filesystem's idmapping.
+ *
+ * This is used in vfs_set_acl_prepare() to generate the proper VFS
+ * representation of POSIX ACLs with ACL_USER entries during setxattr().
+ *
+ * Return: A kuid in @fs_userns for the uid stored in @e.
+ */
+static inline kuid_t
+vfs_set_acl_prepare_kuid(struct user_namespace *mnt_userns,
+			 struct user_namespace *fs_userns,
+			 const struct posix_acl_xattr_entry *e)
+{
+	kuid_t kuid = KUIDT_INIT(le32_to_cpu(e->e_id));
+	return from_vfsuid(mnt_userns, fs_userns, VFSUIDT_INIT(kuid));
+}
+
+/**
+ * vfs_set_acl_prepare_kgid - map ACL_GROUP gid according to mount- and
+ *                            filesystem idmapping
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @e: a ACL_GROUP entry in POSIX ACL uapi format
+ *
+ * The gid stored as ACL_GROUP entry in @e is a kgid_t stored as a raw {g,u}id
+ * value. The vfs_set_acl_prepare_kgid() will recover the kgid_t through
+ * KGIDT_INIT() and then map it according to the idmapped mount. The resulting
+ * kgid_t is the value which the filesystem can map up into a raw backing store
+ * id in the filesystem's idmapping.
+ *
+ * This is used in vfs_set_acl_prepare() to generate the proper VFS
+ * representation of POSIX ACLs with ACL_GROUP entries during setxattr().
+ *
+ * Return: A kgid in @fs_userns for the gid stored in @e.
+ */
+static inline kgid_t
+vfs_set_acl_prepare_kgid(struct user_namespace *mnt_userns,
+			 struct user_namespace *fs_userns,
+			 const struct posix_acl_xattr_entry *e)
+{
+	kgid_t kgid = KGIDT_INIT(le32_to_cpu(e->e_id));
+	return from_vfsgid(mnt_userns, fs_userns, VFSGIDT_INIT(kgid));
+}
+
+/**
+ * vfs_set_acl_prepare - convert POSIX ACLs from uapi to VFS format taking
+ *                       mount and filesystem idmappings into account
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @value: the uapi representation of POSIX ACLs
+ * @size: the size of @void
+ *
+ * When setting POSIX ACLs with ACL_{GROUP,USER} entries they need to be
+ * mapped according to the relevant mount- and filesystem idmapping. It is
+ * important that the ACL_{GROUP,USER} entries in struct posix_acl will be
+ * mapped into k{g,u}id_t that are supposed to be mapped up in the filesystem
+ * idmapping. This is crucial since the resulting struct posix_acl might be
+ * cached filesystem wide. The vfs_set_acl_prepare() function will take care to
+ * perform all necessary idmappings.
+ *
+ * Note, that since basically forever the {g,u}id values encoded as
+ * ACL_{GROUP,USER} entries in the uapi POSIX ACLs passed via @value contain
+ * values that have been mapped according to the caller's idmapping. In other
+ * words, POSIX ACLs passed in uapi format as @value during setxattr() contain
+ * {g,u}id values in their ACL_{GROUP,USER} entries that should actually have
+ * been stored as k{g,u}id_t.
+ *
+ * This means, vfs_set_acl_prepare() needs to first recover the k{g,u}id_t by
+ * calling K{G,U}IDT_INIT(). Afterwards they can be interpreted as vfs{g,u}id_t
+ * through from_vfs{g,u}id() to account for any idmapped mounts. The
+ * vfs_set_acl_prepare_k{g,u}id() helpers will take care to generate the
+ * correct k{g,u}id_t.
+ *
+ * The filesystem will then receive the POSIX ACLs ready to be cached
+ * filesystem wide and ready to be written to the backing store taking the
+ * filesystem's idmapping into account.
+ *
+ * Return: Allocated struct posix_acl on success, NULL for a valid header but
+ *         without actual POSIX ACL entries, or ERR_PTR() encoded error code.
+ */
+struct posix_acl *vfs_set_acl_prepare(struct user_namespace *mnt_userns,
+				      struct user_namespace *fs_userns,
+				      const void *value, size_t size)
+{
+	return make_posix_acl(mnt_userns, fs_userns, value, size,
+			      vfs_set_acl_prepare_kuid,
+			      vfs_set_acl_prepare_kgid);
+}
+EXPORT_SYMBOL(vfs_set_acl_prepare);
+
+/**
+ * posix_acl_from_xattr_kuid - map ACL_USER uid into filesystem idmapping
+ * @mnt_userns: unused
+ * @fs_userns: the filesystem's idmapping
+ * @e: a ACL_USER entry in POSIX ACL uapi format
+ *
+ * Map the uid stored as ACL_USER entry in @e into the filesystem's idmapping.
+ * This is used in posix_acl_from_xattr() to generate the proper VFS
+ * representation of POSIX ACLs with ACL_USER entries.
+ *
+ * Return: A kuid in @fs_userns for the uid stored in @e.
+ */
+static inline kuid_t
+posix_acl_from_xattr_kuid(struct user_namespace *mnt_userns,
+			  struct user_namespace *fs_userns,
+			  const struct posix_acl_xattr_entry *e)
+{
+	return make_kuid(fs_userns, le32_to_cpu(e->e_id));
+}
+
+/**
+ * posix_acl_from_xattr_kgid - map ACL_GROUP gid into filesystem idmapping
+ * @mnt_userns: unused
+ * @fs_userns: the filesystem's idmapping
+ * @e: a ACL_GROUP entry in POSIX ACL uapi format
+ *
+ * Map the gid stored as ACL_GROUP entry in @e into the filesystem's idmapping.
+ * This is used in posix_acl_from_xattr() to generate the proper VFS
+ * representation of POSIX ACLs with ACL_GROUP entries.
+ *
+ * Return: A kgid in @fs_userns for the gid stored in @e.
+ */
+static inline kgid_t
+posix_acl_from_xattr_kgid(struct user_namespace *mnt_userns,
+			  struct user_namespace *fs_userns,
+			  const struct posix_acl_xattr_entry *e)
+{
+	return make_kgid(fs_userns, le32_to_cpu(e->e_id));
+}
+
+/**
+ * posix_acl_from_xattr - convert POSIX ACLs from backing store to VFS format
+ * @fs_userns: the filesystem's idmapping
+ * @value: the uapi representation of POSIX ACLs
+ * @size: the size of @void
+ *
+ * Filesystems that store POSIX ACLs in the unaltered uapi format should use
+ * posix_acl_from_xattr() when reading them from the backing store and
+ * converting them into the struct posix_acl VFS format. The helper is
+ * specifically intended to be called from the ->get_acl() inode operation.
+ *
+ * The posix_acl_from_xattr() function will map the raw {g,u}id values stored
+ * in ACL_{GROUP,USER} entries into the filesystem idmapping in @fs_userns. The
+ * posix_acl_from_xattr_k{g,u}id() helpers will take care to generate the
+ * correct k{g,u}id_t. The returned struct posix_acl can be cached.
+ *
+ * Note that posix_acl_from_xattr() does not take idmapped mounts into account.
+ * If it did it calling is from the ->get_acl() inode operation would return
+ * POSIX ACLs mapped according to an idmapped mount which would mean that the
+ * value couldn't be cached for the filesystem. Idmapped mounts are taken into
+ * account on the fly during permission checking or right at the VFS -
+ * userspace boundary before reporting them to the user.
+ *
+ * Return: Allocated struct posix_acl on success, NULL for a valid header but
+ *         without actual POSIX ACL entries, or ERR_PTR() encoded error code.
+ */
+struct posix_acl *
+posix_acl_from_xattr(struct user_namespace *fs_userns,
+		     const void *value, size_t size)
+{
+	return make_posix_acl(&init_user_ns, fs_userns, value, size,
+			      posix_acl_from_xattr_kuid,
+			      posix_acl_from_xattr_kgid);
+}
 EXPORT_SYMBOL (posix_acl_from_xattr);
 
 /*
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index b6bd3eac2bcc..47eca15fd842 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -66,6 +66,9 @@ struct posix_acl *posix_acl_from_xattr(struct user_namespace *user_ns,
 				       const void *value, size_t size);
 int posix_acl_to_xattr(struct user_namespace *user_ns,
 		       const struct posix_acl *acl, void *buffer, size_t size);
+struct posix_acl *vfs_set_acl_prepare(struct user_namespace *mnt_userns,
+				      struct user_namespace *fs_userns,
+				      const void *value, size_t size);
 
 extern const struct xattr_handler posix_acl_access_xattr_handler;
 extern const struct xattr_handler posix_acl_default_xattr_handler;
-- 
2.34.1

