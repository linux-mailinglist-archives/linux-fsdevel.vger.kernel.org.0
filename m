Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD35664B485
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 12:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiLMLyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 06:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiLMLye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:54:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0490D56
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 03:54:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6229061419
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 11:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BB4C433D2;
        Tue, 13 Dec 2022 11:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670932472;
        bh=UZ1L5VNm3LuEl1iNxZll9H6Kep5xz5z7JhJMtn+8+HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGtDk8jBZFa5btpG4Iy49iXc6Aaih4eSLEEcJ9UYJI486Ny6XEoD9XovJeSfJpOqe
         DzayNeQjld8HPS4fn18wUVKgeWCsbu42p77Co2yfov4/fw2cRC4R6CLiKsS30CFOz7
         XuiYxFRuyHum60g/8i5cYryHzIXx1XibERercG24KLfMYsT3FvneAKm0ya3qEtqSNP
         n9jqhdV6e/HTqH6N3ZOMIgSC+sylm+sfe1CEqjPJJBl8RCrZZja/DWB+EH08ROORRM
         pmb8K7sIOXksVBAO3gfDz2dI3PSeM25m6IqOc6DnrdLpu20VdXZQvOXvNbtPg2c+bp
         6kQuFZHM79CVA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] mnt_idmapping: move ima-only helpers to ima
Date:   Tue, 13 Dec 2022 12:54:27 +0100
Message-Id: <20221213115427.286063-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com>
References: 
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2635; i=brauner@kernel.org; h=from:subject; bh=UZ1L5VNm3LuEl1iNxZll9H6Kep5xz5z7JhJMtn+8+HI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTPSH/IJ1R9ZsvFNZn5em9NZZyd+RMnexsfVZ//f5u+9ybT DyZcHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZ8oaRoT1D/JLFJbVPpwPecRe9/z K16F6Ey7+GdyI/jxq0GwooHGP4H5hmcTOs8DpbzdV3J2RSDjflTJtstfnvV5eJNfwvjpcnsAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The vfs{g,u}id_{gt,lt}_* helpers are currently not needed outside of
ima and we shouldn't incentivize people to use them by placing them into
the header. Let's just define them locally in the one file in ima where
they are used.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 include/linux/mnt_idmapping.h       | 20 --------------------
 security/integrity/ima/ima_policy.c | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 092c52aa6c2c..0ccca33a7a6d 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -96,26 +96,6 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, kgid_t kgid)
 	return vfsgid_valid(vfsgid) && __vfsgid_val(vfsgid) == __kgid_val(kgid);
 }
 
-static inline bool vfsuid_gt_kuid(vfsuid_t vfsuid, kuid_t kuid)
-{
-	return __vfsuid_val(vfsuid) > __kuid_val(kuid);
-}
-
-static inline bool vfsgid_gt_kgid(vfsgid_t vfsgid, kgid_t kgid)
-{
-	return __vfsgid_val(vfsgid) > __kgid_val(kgid);
-}
-
-static inline bool vfsuid_lt_kuid(vfsuid_t vfsuid, kuid_t kuid)
-{
-	return __vfsuid_val(vfsuid) < __kuid_val(kuid);
-}
-
-static inline bool vfsgid_lt_kgid(vfsgid_t vfsgid, kgid_t kgid)
-{
-	return __vfsgid_val(vfsgid) < __kgid_val(kgid);
-}
-
 /*
  * vfs{g,u}ids are created from k{g,u}ids.
  * We don't allow them to be created from regular {u,g}id.
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 54c475f98ce1..edd95ba02c11 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -71,6 +71,30 @@ struct ima_rule_opt_list {
 	char *items[];
 };
 
+/*
+ * These comparators are needed nowhere outside of ima so just define them here.
+ * This pattern should hopefully never be needed outside of ima.
+ */
+static inline bool vfsuid_gt_kuid(vfsuid_t vfsuid, kuid_t kuid)
+{
+	return __vfsuid_val(vfsuid) > __kuid_val(kuid);
+}
+
+static inline bool vfsgid_gt_kgid(vfsgid_t vfsgid, kgid_t kgid)
+{
+	return __vfsgid_val(vfsgid) > __kgid_val(kgid);
+}
+
+static inline bool vfsuid_lt_kuid(vfsuid_t vfsuid, kuid_t kuid)
+{
+	return __vfsuid_val(vfsuid) < __kuid_val(kuid);
+}
+
+static inline bool vfsgid_lt_kgid(vfsgid_t vfsgid, kgid_t kgid)
+{
+	return __vfsgid_val(vfsgid) < __kgid_val(kgid);
+}
+
 struct ima_rule_entry {
 	struct list_head list;
 	int action;

base-commit: 764822972d64e7f3e6792278ecc7a3b3c81087cd
-- 
2.34.1

