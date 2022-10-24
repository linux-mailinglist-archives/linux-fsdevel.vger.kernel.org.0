Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09608609FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJXLNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 07:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJXLNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481715A8BE;
        Mon, 24 Oct 2022 04:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE6B16122A;
        Mon, 24 Oct 2022 11:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B205DC433D7;
        Mon, 24 Oct 2022 11:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609988;
        bh=jqttWPFHaJShUcbmiDfjKA0n0OpH419rBjOkAuSzsI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3KbCWR8ouENTSAhp6GR/MOYd8si2brfQXDg6fG3QV/uk7Rxw+13D7L5pcdU+4ycm
         iqBICa0Huk3amTyBFtAk+YOTPmrLnPtNnJU0zma9WHw88ueFkztoAASEHvQ6vF+zqh
         Z3ITo4CemqnDf0PCrss6PpxEfcleWW1V41N0SDY8qoysxTn+zhzckYgGE0RdLvJQt9
         g8naGZBvWk5VsoG2kmxkNpMfQ/L3W+NA/ibdQvzIYS+1ceiN2+lwZr9Mm5gmmafEMI
         /xN4Ki8rASFitJvHO7DCYiaTrqwp+KqTsjpA9RZBqKuxaykG8/fQJomVySdtPrfVmP
         HXO/Tkb3+7Veg==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 5/8] ima: use type safe idmapping helpers
Date:   Mon, 24 Oct 2022 13:12:46 +0200
Message-Id: <20221024111249.477648-6-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024111249.477648-1-brauner@kernel.org>
References: <20221024111249.477648-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4942; i=brauner@kernel.org; h=from:subject; bh=jqttWPFHaJShUcbmiDfjKA0n0OpH419rBjOkAuSzsI8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSHFetuNbwsxXroZrfRonMqFyvvvdp7YJ+tI9sbxduO//KF FCZ6dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEXISRYclRvWc1Cp82RL3WF52j6z GH9cG1sMSMZWLeC3LUVyfw1jAyrHXefCTz7t8PD00kst7fmySWmitnOt+iuZ1rPacqt8QcLgA=
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

We already ported most parts and filesystems over for v6.0 to the new
vfs{g,u}id_t type and associated helpers for v6.0. Convert the remaining
places so we can remove all the old helpers.
This is a non-functional change.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:

 security/integrity/ima/ima_policy.c | 34 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a8802b8da946..54c475f98ce1 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -85,8 +85,8 @@ struct ima_rule_entry {
 	kgid_t fgroup;
 	bool (*uid_op)(kuid_t cred_uid, kuid_t rule_uid);    /* Handlers for operators       */
 	bool (*gid_op)(kgid_t cred_gid, kgid_t rule_gid);
-	bool (*fowner_op)(kuid_t cred_uid, kuid_t rule_uid); /* uid_eq(), uid_gt(), uid_lt() */
-	bool (*fgroup_op)(kgid_t cred_gid, kgid_t rule_gid); /* gid_eq(), gid_gt(), gid_lt() */
+	bool (*fowner_op)(vfsuid_t vfsuid, kuid_t rule_uid); /* vfsuid_eq_kuid(), vfsuid_gt_kuid(), vfsuid_lt_kuid() */
+	bool (*fgroup_op)(vfsgid_t vfsgid, kgid_t rule_gid); /* vfsgid_eq_kgid(), vfsgid_gt_kgid(), vfsgid_lt_kgid() */
 	int pcr;
 	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
 	struct {
@@ -186,11 +186,11 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 #endif
 #ifndef CONFIG_IMA_APPRAISE_SIGNED_INIT
-	{.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .fowner_op = &uid_eq,
+	{.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .fowner_op = &vfsuid_eq_kuid,
 	 .flags = IMA_FOWNER},
 #else
 	/* force signature */
-	{.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .fowner_op = &uid_eq,
+	{.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .fowner_op = &vfsuid_eq_kuid,
 	 .flags = IMA_FOWNER | IMA_DIGSIG_REQUIRED},
 #endif
 };
@@ -601,10 +601,12 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			return false;
 	}
 	if ((rule->flags & IMA_FOWNER) &&
-	    !rule->fowner_op(i_uid_into_mnt(mnt_userns, inode), rule->fowner))
+	    !rule->fowner_op(i_uid_into_vfsuid(mnt_userns, inode),
+			     rule->fowner))
 		return false;
 	if ((rule->flags & IMA_FGROUP) &&
-	    !rule->fgroup_op(i_gid_into_mnt(mnt_userns, inode), rule->fgroup))
+	    !rule->fgroup_op(i_gid_into_vfsgid(mnt_userns, inode),
+			     rule->fgroup))
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
@@ -1371,8 +1373,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	entry->fgroup = INVALID_GID;
 	entry->uid_op = &uid_eq;
 	entry->gid_op = &gid_eq;
-	entry->fowner_op = &uid_eq;
-	entry->fgroup_op = &gid_eq;
+	entry->fowner_op = &vfsuid_eq_kuid;
+	entry->fgroup_op = &vfsgid_eq_kgid;
 	entry->action = UNKNOWN;
 	while ((p = strsep(&rule, " \t")) != NULL) {
 		substring_t args[MAX_OPT_ARGS];
@@ -1650,11 +1652,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			}
 			break;
 		case Opt_fowner_gt:
-			entry->fowner_op = &uid_gt;
+			entry->fowner_op = &vfsuid_gt_kuid;
 			fallthrough;
 		case Opt_fowner_lt:
 			if (token == Opt_fowner_lt)
-				entry->fowner_op = &uid_lt;
+				entry->fowner_op = &vfsuid_lt_kuid;
 			fallthrough;
 		case Opt_fowner_eq:
 			ima_log_string_op(ab, "fowner", args[0].from, token);
@@ -1676,11 +1678,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			}
 			break;
 		case Opt_fgroup_gt:
-			entry->fgroup_op = &gid_gt;
+			entry->fgroup_op = &vfsgid_gt_kgid;
 			fallthrough;
 		case Opt_fgroup_lt:
 			if (token == Opt_fgroup_lt)
-				entry->fgroup_op = &gid_lt;
+				entry->fgroup_op = &vfsgid_lt_kgid;
 			fallthrough;
 		case Opt_fgroup_eq:
 			ima_log_string_op(ab, "fgroup", args[0].from, token);
@@ -2151,9 +2153,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 
 	if (entry->flags & IMA_FOWNER) {
 		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
-		if (entry->fowner_op == &uid_gt)
+		if (entry->fowner_op == &vfsuid_gt_kuid)
 			seq_printf(m, pt(Opt_fowner_gt), tbuf);
-		else if (entry->fowner_op == &uid_lt)
+		else if (entry->fowner_op == &vfsuid_lt_kuid)
 			seq_printf(m, pt(Opt_fowner_lt), tbuf);
 		else
 			seq_printf(m, pt(Opt_fowner_eq), tbuf);
@@ -2162,9 +2164,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 
 	if (entry->flags & IMA_FGROUP) {
 		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->fgroup));
-		if (entry->fgroup_op == &gid_gt)
+		if (entry->fgroup_op == &vfsgid_gt_kgid)
 			seq_printf(m, pt(Opt_fgroup_gt), tbuf);
-		else if (entry->fgroup_op == &gid_lt)
+		else if (entry->fgroup_op == &vfsgid_lt_kgid)
 			seq_printf(m, pt(Opt_fgroup_lt), tbuf);
 		else
 			seq_printf(m, pt(Opt_fgroup_eq), tbuf);
-- 
2.34.1

