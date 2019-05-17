Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153E721F95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfEQVZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:25:02 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34394 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfEQVZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:25:02 -0400
Received: by mail-pg1-f201.google.com with SMTP id e6so1121905pgl.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kDtuSdPuZMfh9jp8My/vbwyi1T6nRo1X8LH0Nx8sUW0=;
        b=ZXa+6PpEq25vw32Il9yKyuZ4OvWq+Nl2SyCgp80AC/1Us0wp+cyOb6GdmVF8xKeTg4
         Lumm9hPXPYfFoRK7nnxRZis/v0wLrsusWoSnyosHIE265vS8/ZwZZB2LU8A784J1kPTQ
         xWDs9BUC66IsAr+welIu2WpJ68pm338DTVdS48QiAubCa7CIzj2AhtaGU7epoqo/1k6e
         822Q7F6DfKBtxm6XB+P80mb0kia75mWWU+gCjuCKY7rPL6dBv6IOleUnSt/CNW0XcDYD
         5Yp8CiS1+tmqGiVizW5g6aqjKhqpeQy9NFSa27Z1zwfcTEjL0zgxLQ5fLqA/1gCTL4v/
         Ogng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kDtuSdPuZMfh9jp8My/vbwyi1T6nRo1X8LH0Nx8sUW0=;
        b=kE/MxMHJs2eMbZl8Svi75KAN408NtmWQRT2TUj/WYFSmJ8dWUHGIWfwio3Ge5OoWbu
         7r2ARKfyhpGlc09seJQWbWii/vECW8q2dfDDzB3R402xwrq+eE75fiYYGSZtwNqFw51s
         517fySPWnmHQ3sj0hVJP4C0e0N8ZAmmmbHLb083trqYTuBpA7WCgTaoA42Em6apEf+X/
         KrRBC89bPRIJfKZOYIY8zJahoug80RhVScFSkQAYHyBTWgYJNDocBGy9abYKEfS0Ttif
         hOFeMjBw6m/WY0t9botLCE68ZtJxnwaK/Pu5Pjk2ws8hq4pwYn8MZru7MS+S+iMl+wsZ
         1ZLQ==
X-Gm-Message-State: APjAAAXP35lvQ6tZxriOWkY3jveCBDD54k6FFvfnh78T1d5go/J38ma0
        aP7qJaAgBEVtkK+cC1KEkDU3X54oSPlgfn6h5j6Mpw==
X-Google-Smtp-Source: APXvYqwo+ESMkPLpKypeMK8H6U6nIhz+3gFIps9LOJCfyaXKPzWzK3MQNUHDHm+egVvEz8GLZIhZh5TWQspui96K8/OPLw==
X-Received: by 2002:a63:5cb:: with SMTP id 194mr59565142pgf.294.1558128301705;
 Fri, 17 May 2019 14:25:01 -0700 (PDT)
Date:   Fri, 17 May 2019 14:24:45 -0700
In-Reply-To: <20190517212448.14256-1-matthewgarrett@google.com>
Message-Id: <20190517212448.14256-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190517212448.14256-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V3 3/6] IMA: Allow rule matching on filesystem subtype
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IMA currently allows rules to match on the filesystem type. Certain
filesystem types permit subtypes (eg, fuse). Add support to IMA to allow
rules to match on subtypes as well as types.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Documentation/ABI/testing/ima_policy |  4 +++-
 security/integrity/ima/ima_policy.c  | 26 +++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 74c6702de74e..09a5def7e28a 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -21,7 +21,7 @@ Description:
 			audit | hash | dont_hash
 		condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
-				[euid=] [fowner=] [fsname=]]
+				[euid=] [fowner=] [fsname=] [subtype=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [permit_directio]
@@ -33,6 +33,8 @@ Description:
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
 			fsuuid:= file system UUID (e.g 8bcbe394-4f13-4144-be8e-5aa9ea2ce2f6)
+			fsname:= file system type (e.g fuse)
+			subtype:= file system subtype (e.g ntfs3g)
 			uid:= decimal value
 			euid:= decimal value
 			fowner:= decimal value
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..bb4e265823a7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -35,6 +35,7 @@
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
+#define IMA_SUBTYPE	0x0400
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -80,6 +81,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	char *subtype;
 };
 
 /*
@@ -306,6 +308,10 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	if ((rule->flags & IMA_FSNAME)
 	    && strcmp(rule->fsname, inode->i_sb->s_type->name))
 		return false;
+	if ((rule->flags & IMA_SUBTYPE)
+	    && (inode->i_sb->s_subtype == NULL ||
+		strcmp(rule->subtype, inode->i_sb->s_subtype)))
+		return false;
 	if ((rule->flags & IMA_FSUUID) &&
 	    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
 		return false;
@@ -670,7 +676,7 @@ enum {
 	Opt_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
-	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname,
+	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_subtype,
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
@@ -696,6 +702,7 @@ static const match_table_t policy_tokens = {
 	{Opt_mask, "mask=%s"},
 	{Opt_fsmagic, "fsmagic=%s"},
 	{Opt_fsname, "fsname=%s"},
+	{Opt_subtype, "subtype=%s"},
 	{Opt_fsuuid, "fsuuid=%s"},
 	{Opt_uid_eq, "uid=%s"},
 	{Opt_euid_eq, "euid=%s"},
@@ -921,6 +928,17 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			result = 0;
 			entry->flags |= IMA_FSNAME;
 			break;
+		case Opt_subtype:
+			ima_log_string(ab, "subtype", args[0].from);
+
+			entry->subtype = kstrdup(args[0].from, GFP_KERNEL);
+			if (!entry->subtype) {
+				result = -ENOMEM;
+				break;
+			}
+			result = 0;
+			entry->flags |= IMA_SUBTYPE;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1256,6 +1274,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_SUBTYPE) {
+		snprintf(tbuf, sizeof(tbuf), "%s", entry->subtype);
+		seq_printf(m, pt(Opt_subtype), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.21.0.1020.gf2820cf01a-goog

