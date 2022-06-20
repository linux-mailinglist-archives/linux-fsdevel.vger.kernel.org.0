Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5E551EEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbiFTOfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243941AbiFTOeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E512198
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 06:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B756151E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 13:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE74C341C0;
        Mon, 20 Jun 2022 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655733002;
        bh=6lHaS7Ssw1uBZGvE24SoVBgMEHretTpFa3mKEeRz1Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCUAStUlmLqbzOcEu3wWrTvWefe9gknlI//x2P+3ji64jrE1i08K7+1DWgNdjGvLv
         3/bQxdlXvnQlTas6sohZ1WsYyRb/TadxHctoBytJ8f+Q2erlKAMRToPa64aq4BY8XE
         E2fViFRMK6Lp0UD98o0YQIykWNfDIb5aINriVCaNv75U2SH4KRoVmup37np+NVkj6O
         sev3gUNQ9Jcu4z2ZrSBd6hB0rnfrXC9fmGtA3D6QteKpJYDkl8YRGQOKh3y6hcXMWJ
         T12gZiKweqtBISit9sfm+/Gycp1jTxtU66LmJEZqmGWIYbA4x8U50YPvNKbX3kxIMe
         AFtI6fHJfpo+g==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/8] mnt_idmapping: add kmnt{g,u}id_t
Date:   Mon, 20 Jun 2022 15:49:40 +0200
Message-Id: <20220620134947.2772863-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620134947.2772863-1-brauner@kernel.org>
References: <20220620134947.2772863-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8619; h=from:subject; bh=6lHaS7Ssw1uBZGvE24SoVBgMEHretTpFa3mKEeRz1Wo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtqHpdc7FjocbmxmZDu2bZdpty+9zfUmV/z845cN10t8z3 Yu3UjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImwlTL84dDfdeKln8/mo6c4heIT8z 6oKmy/3Oh+O/ZW9vQpF6fsFWZkeMujeqH7sz2PCHPJhV3lIqK3GR++84np+Zwv0Mqd4baZHQA=
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

Introduces new kmnt{g,u}id_t types. Similar to k{g,u}id_t the new types
are just simple wrapper structs around regular {g,u}id_t types.

They allows to establish a type safety boundary between {g,u}ids on
idmapped mounts and {g,u}ids as they are represented in filesystems
themselves.

A kmnt{g,u}id_t is always created from a k{g,u}id_t, never directly from
a {g,u}id_t as idmapped mounts remap a given {g,u}id according to the
mount's idmapping. This is expressed in the KMNT{G,U}IDT_INIT() macros.

A kmnt{g,u}id_t may be used as a k{g,u}id_t via AS_K{G,U}IDT(). This
often happens when we need to check whether a {g,u}id mapped according
to an idmapped mount is identical to a given k{g,u}id_t. For an example,
see kmntgid_in_group_p() which determines whether the value of kmntgid_t
matches the value of any of the caller's groups. Similar logic is
expressed in the k{g,u}id_eq_kmnt{g,u}id().

The kmnt{g,u}id_to_k{g,u}id() helpers map a given kmnt{g,u}id_t from the
mount's idmapping into the filesystem idmapping. They make it possible
to update a filesystem object such as inode->i_{g,u}id with the correct
value.

This makes it harder to accidently write a wrong {g,u}id anwywhere.
The kmnt{g,u}id_has_mapping() helpers check whether a given
kmnt{g,u}id_t can be represented in the filesystem idmapping.

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
 include/linux/mnt_idmapping.h | 190 ++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index ee5a217de2a8..8dbaef494e02 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -13,6 +13,122 @@ struct user_namespace;
  */
 extern struct user_namespace init_user_ns;
 
+typedef struct {
+	uid_t val;
+} kmntuid_t;
+
+typedef struct {
+	gid_t val;
+} kmntgid_t;
+
+#ifdef CONFIG_MULTIUSER
+static inline uid_t __kmntuid_val(kmntuid_t uid)
+{
+	return uid.val;
+}
+
+static inline gid_t __kmntgid_val(kmntgid_t gid)
+{
+	return gid.val;
+}
+#else
+static inline uid_t __kmntuid_val(kmntuid_t uid)
+{
+	return 0;
+}
+
+static inline gid_t __kmntgid_val(kmntgid_t gid)
+{
+	return 0;
+}
+#endif
+
+static inline bool kmntuid_valid(kmntuid_t uid)
+{
+	return __kmntuid_val(uid) != (uid_t) -1;
+}
+
+static inline bool kmntgid_valid(kmntgid_t gid)
+{
+	return __kmntgid_val(gid) != (gid_t) -1;
+}
+
+/**
+ * kuid_eq_kmntuid - check whether kuid and kmntuid have the same value
+ * @kuid: the kuid to compare
+ * @kmntuid: the kmntuid to compare
+ *
+ * Check whether @kuid and @kmntuid have the same values.
+ *
+ * Return: true if @kuid and @kmntuid have the same value, false if not.
+ */
+static inline bool kuid_eq_kmntuid(kuid_t kuid, kmntuid_t kmntuid)
+{
+	return __kmntuid_val(kmntuid) == __kuid_val(kuid);
+}
+
+/**
+ * kgid_eq_kmntgid - check whether kgid and kmntgid have the same value
+ * @kgid: the kgid to compare
+ * @kmntgid: the kmntgid to compare
+ *
+ * Check whether @kgid and @kmntgid have the same values.
+ *
+ * Return: true if @kgid and @kmntgid have the same value, false if not.
+ */
+static inline bool kgid_eq_kmntgid(kgid_t kgid, kmntgid_t kmntgid)
+{
+	return __kmntgid_val(kmntgid) == __kgid_val(kgid);
+}
+
+static inline bool kmntuid_eq(kmntuid_t left, kmntuid_t right)
+{
+	return __kmntuid_val(left) == __kmntuid_val(right);
+}
+
+static inline bool kmntgid_eq(kmntgid_t left, kmntgid_t right)
+{
+	return __kmntgid_val(left) == __kmntgid_val(right);
+}
+
+/*
+ * kmnt{g,u}ids are created from k{g,u}ids.
+ * We don't allow them to be created from regular {u,g}id.
+ */
+#define KMNTUIDT_INIT(val) (kmntuid_t){ __kuid_val(val) }
+#define KMNTGIDT_INIT(val) (kmntgid_t){ __kgid_val(val) }
+
+#define INVALID_KMNTUID KMNTUIDT_INIT(INVALID_UID)
+#define INVALID_KMNTGID KMNTGIDT_INIT(INVALID_GID)
+
+/*
+ * Allow a kmnt{g,u}id to be used as a k{g,u}id where we want to compare
+ * whether the mapped value is identical to value of a k{g,u}id.
+ */
+#define AS_KUIDT(val) (kuid_t){ __kmntuid_val(val) }
+#define AS_KGIDT(val) (kgid_t){ __kmntgid_val(val) }
+
+#ifdef CONFIG_MULTIUSER
+/**
+ * kmntgid_in_group_p() - check whether a kmntuid matches the caller's groups
+ * @kmntgid: the mnt gid to match
+ *
+ * This function can be used to determine whether @kmntuid matches any of the
+ * caller's groups.
+ *
+ * Return: 1 if kmntuid matches caller's groups, 0 if not.
+ */
+static inline int kmntgid_in_group_p(kmntgid_t kmntgid)
+{
+	return in_group_p(AS_KGIDT(kmntgid));
+}
+#else
+static inline int kmntgid_in_group_p(kmntgid_t kmntgid)
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
+ * kmntuid_to_kuid - map a kmntuid into the filesystem idmapping
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kmntuid : kmntuid to be mapped
+ *
+ * Map @kmntuid into the filesystem idmapping. This function has to be used in
+ * order to e.g. write @kmntuid to inode->i_uid.
+ *
+ * Return: @kmntuid mapped into the filesystem idmapping
+ */
+static inline kuid_t kmntuid_to_kuid(struct user_namespace *mnt_userns,
+				     struct user_namespace *fs_userns,
+				     kmntuid_t kmntuid)
+{
+	return mapped_kuid_user(mnt_userns, fs_userns, AS_KUIDT(kmntuid));
+}
+
+/**
+ * kmntuid_has_mapping - check whether a kmntuid maps into the filesystem
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kmntuid: kmntuid to be mapped
+ *
+ * Check whether @kmntuid has a mapping in the filesystem idmapping. Use this
+ * function to check whether the filesystem idmapping has a mapping for
+ * @kmntuid.
+ *
+ * Return: true if @kmntuid has a mapping in the filesystem, false if not.
+ */
+static inline bool kmntuid_has_mapping(struct user_namespace *mnt_userns,
+				       struct user_namespace *fs_userns,
+				       kmntuid_t kmntuid)
+{
+	return uid_valid(kmntuid_to_kuid(mnt_userns, fs_userns, kmntuid));
+}
+
 /**
  * mapped_kgid_user - map a user kgid into a mnt_userns
  * @mnt_userns: the mount's idmapping
@@ -193,6 +346,43 @@ static inline kgid_t mapped_kgid_user(struct user_namespace *mnt_userns,
 	return make_kgid(fs_userns, gid);
 }
 
+/**
+ * kmntgid_to_kgid - map a kmntgid into the filesystem idmapping
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kmntgid : kmntgid to be mapped
+ *
+ * Map @kmntgid into the filesystem idmapping. This function has to be used in
+ * order to e.g. write @kmntgid to inode->i_gid.
+ *
+ * Return: @kmntgid mapped into the filesystem idmapping
+ */
+static inline kgid_t kmntgid_to_kgid(struct user_namespace *mnt_userns,
+				     struct user_namespace *fs_userns,
+				     kmntgid_t kmntgid)
+{
+	return mapped_kgid_user(mnt_userns, fs_userns, AS_KGIDT(kmntgid));
+}
+
+/**
+ * kmntgid_has_mapping - check whether a kmntgid maps into the filesystem
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kmntgid: kmntgid to be mapped
+ *
+ * Check whether @kmntgid has a mapping in the filesystem idmapping. Use this
+ * function to check whether the filesystem idmapping has a mapping for
+ * @kmntgid.
+ *
+ * Return: true if @kmntgid has a mapping in the filesystem, false if not.
+ */
+static inline bool kmntgid_has_mapping(struct user_namespace *mnt_userns,
+				       struct user_namespace *fs_userns,
+				       kmntgid_t kmntgid)
+{
+	return gid_valid(kmntgid_to_kgid(mnt_userns, fs_userns, kmntgid));
+}
+
 /**
  * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
  * @mnt_userns: the mount's idmapping
-- 
2.34.1

