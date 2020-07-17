Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C322224696
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 01:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGQXKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 19:10:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51098 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGQXJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:09:51 -0400
Received: from dede-linux-virt.corp.microsoft.com (unknown [131.107.160.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0969520B490D;
        Fri, 17 Jul 2020 16:09:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0969520B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595027387;
        bh=yhKu7qb8yaYXydHqrqu+XydIIOld6ryiUt3jjE4zWRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkHWmIF1ZB51NrAwAodQ0CfYr7HVb8ffpCcXofxEpkrhZbPrAP2QXKaKbd5bkJahA
         0eUVGG2SXcX1EbgX7dwmI1DcFSFAabJLSMnfEQPZ2mGBuz/Qe93HnHrifx4IF0nPA1
         BELWqQ15PDlb6/uE6dV4eJy75tY9dHTm1cBhdLr0=
From:   Deven Bowers <deven.desai@linux.microsoft.com>
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, eparis@redhat.com,
        jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com
Cc:     tyhicks@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatshin@soleen.com
Subject: [RFC PATCH v4 03/12] security: add ipe lsm policy parser and policy loading
Date:   Fri, 17 Jul 2020 16:09:32 -0700
Message-Id: <20200717230941.1190744-4-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717230941.1190744-1-deven.desai@linux.microsoft.com>
References: <20200717230941.1190744-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds the policy parser and the policy loading to IPE, along with the
related sysfs, securityfs entries, and audit events.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 security/ipe/Kconfig             |    2 +
 security/ipe/Makefile            |    2 +
 security/ipe/ipe-audit.c         |   87 +-
 security/ipe/ipe-audit.h         |    8 +
 security/ipe/ipe-parse.c         |  890 ++++++++++++++++++++
 security/ipe/ipe-parse.h         |   17 +
 security/ipe/ipe-policy.c        |  148 ++++
 security/ipe/ipe-policy.h        |   13 +-
 security/ipe/ipe-prop-internal.h |   12 +
 security/ipe/ipe-property.h      |    1 +
 security/ipe/ipe-secfs.c         | 1308 ++++++++++++++++++++++++++++++
 security/ipe/ipe-secfs.h         |   16 +
 12 files changed, 2500 insertions(+), 4 deletions(-)
 create mode 100644 security/ipe/ipe-parse.c
 create mode 100644 security/ipe/ipe-parse.h
 create mode 100644 security/ipe/ipe-policy.c
 create mode 100644 security/ipe/ipe-secfs.c
 create mode 100644 security/ipe/ipe-secfs.h

diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index f9b8292a88ed..83cf0634043a 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -7,6 +7,8 @@ menuconfig SECURITY_IPE
 	bool "Integrity Policy Enforcement (IPE)"
 	depends on SECURITY && AUDIT
 	select SYSTEM_DATA_VERIFICATION
+	select SECURITYFS
+	select CRYPTO_SHA1
 	help
 	  This option enables the Integrity Policy Enforcement subsystem
 	  allowing systems to enforce integrity having no dependencies
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index 078acd026ba9..7d6da33dd0c4 100644
--- a/security/ipe/Makefile
+++ b/security/ipe/Makefile
@@ -19,6 +19,8 @@ obj-$(CONFIG_SECURITY_IPE) += \
 	ipe-audit.o \
 	ipe-bp.o \
 	ipe-engine.o \
+	ipe-parse.o \
+	ipe-policy.o \
 	ipe-property.o \
 	ipe-hooks.o \
 	ipe-secfs.o \
diff --git a/security/ipe/ipe-audit.c b/security/ipe/ipe-audit.c
index 230884e91d03..6b0b29c42f71 100644
--- a/security/ipe/ipe-audit.c
+++ b/security/ipe/ipe-audit.c
@@ -17,7 +17,8 @@
 #include <crypto/sha1_base.h>
 
 #define ACTION_STR(a) ((a) == ipe_action_allow ? "ALLOW" : "DENY")
-
+#define POLICY_LOAD_FSTR	"IPE policy_name=\"%s\" policy_version=%hu.%hu.%hu sha1="
+#define POLICY_ACTIVATE_STR	"IPE policy_name=\"%s\" policy_version=%hu.%hu.%hu"
 #define IPE_UNKNOWN		"UNKNOWN"
 
 /* Keep in sync with ipe_op in ipe-hooks.h */
@@ -229,3 +230,87 @@ void ipe_audit_match(const struct ipe_engine_ctx *ctx,
 
 	audit_log_end(ab);
 }
+
+/**
+ * ipe_audit_policy_load: Emit an audit event that an IPE policy has been
+ *			  loaded, with the name of the policy, the policy
+ *			  version triple, and a flat hash of the content.
+ * @pol: The parsed policy to derive the policy_name and policy_version
+ *	 triple.
+ * @raw: The raw content that was passed to the ipe.policy sysctl to derive
+ *	 the sha1 hash.
+ * @raw_size: the length of @raw.
+ * @tfm: shash structure allocated by the caller, used to fingerprint the
+ *	 policy being deployed
+ */
+void ipe_audit_policy_load(const struct ipe_policy *pol, const uint8_t *raw,
+			   size_t raw_size, struct crypto_shash *tfm)
+{
+	int rc = 0;
+	struct audit_buffer *ab;
+	u8 digest[SHA1_DIGEST_SIZE];
+	SHASH_DESC_ON_STACK(desc, tfm);
+
+	ab = audit_log_start(audit_context(), GFP_KERNEL,
+			     AUDIT_INTEGRITY_POLICY_LOAD);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, POLICY_LOAD_FSTR, pol->policy_name,
+			 pol->policy_version.major, pol->policy_version.minor,
+			 pol->policy_version.rev);
+
+	desc->tfm = tfm;
+
+	if (crypto_shash_init(desc) != 0)
+		goto err;
+
+	if (crypto_shash_update(desc, raw, raw_size) != 0)
+		goto err;
+
+	if (crypto_shash_final(desc, digest) != 0)
+		goto err;
+
+	audit_log_n_hex(ab, digest, crypto_shash_digestsize(tfm));
+
+err:
+	if (rc != 0)
+		audit_log_format(ab, "ERR(%d)", rc);
+
+	audit_log_end(ab);
+}
+
+/**
+ * ipe_audit_policy_activation: Emit an audit event that a specific policy
+ *				was activated as the active policy.
+ * @pol: policy that is being activated
+ */
+void ipe_audit_policy_activation(const struct ipe_policy *pol)
+{
+	struct audit_buffer *ab;
+
+	ab = audit_log_start(audit_context(), GFP_KERNEL,
+			     AUDIT_INTEGRITY_POLICY_ACTIVATE);
+
+	if (!ab)
+		return;
+
+	audit_log_format(ab, POLICY_ACTIVATE_STR, pol->policy_name,
+			 pol->policy_version.major, pol->policy_version.minor,
+			 pol->policy_version.rev);
+
+	audit_log_end(ab);
+}
+
+/**
+ * ipe_audit_unset_remap: Emit an warning indicating that the operation
+ *			  represented by @op is unset and will implicitly
+ *			  allow everything under that op.
+ * @op: the operation to emit an audit message for.
+ */
+void ipe_audit_unset_remap(enum ipe_op op)
+{
+	pr_warn("op=%s default was unset, remapping to \"DEFAULT op=%s action=ALLOW\" for compatibility",
+		audit_op_names[op],
+		audit_op_names[op]);
+}
diff --git a/security/ipe/ipe-audit.h b/security/ipe/ipe-audit.h
index c4fca5e2ab73..ca78a9578bf1 100644
--- a/security/ipe/ipe-audit.h
+++ b/security/ipe/ipe-audit.h
@@ -3,6 +3,7 @@
  * Copyright (C) Microsoft Corporation. All rights reserved.
  */
 
+#include "ipe-prop-internal.h"
 #include "ipe-engine.h"
 #include "ipe-policy.h"
 
@@ -15,4 +16,11 @@ void ipe_audit_match(const struct ipe_engine_ctx *ctx,
 		     enum ipe_match match_type, enum ipe_action action,
 		     const struct ipe_rule *rule);
 
+void ipe_audit_policy_load(const struct ipe_policy *pol, const uint8_t *raw,
+			   size_t raw_size, struct crypto_shash *tfm);
+
+void ipe_audit_policy_activation(const struct ipe_policy *pol);
+
+void ipe_audit_unset_remap(enum ipe_op op);
+
 #endif /* IPE_AUDIT_H */
diff --git a/security/ipe/ipe-parse.c b/security/ipe/ipe-parse.c
new file mode 100644
index 000000000000..ddcae6c7ada9
--- /dev/null
+++ b/security/ipe/ipe-parse.c
@@ -0,0 +1,890 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-prop-internal.h"
+#include "ipe-hooks.h"
+#include "ipe-parse.h"
+#include "ipe-property.h"
+#include "ipe-audit.h"
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/list_sort.h>
+#include <linux/slab.h>
+#include <linux/ctype.h>
+#include <linux/parser.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+
+#define ALLOW_ACTION	"ALLOW"
+#define DENY_ACTION	"DENY"
+#define COMMENT_CHAR	'#'
+#define VER_FSTR	"%hu.%hu.%hu"
+
+/* Internal Type Definitions */
+enum property_priority {
+	other = 0,
+	action = 1,
+	op = 2,
+	default_action = 3,
+	policy_ver = 4,
+	policy_name = 5,
+};
+
+struct token {
+	struct list_head	next_tok;
+	const char		*key;
+	enum property_priority	key_priority;
+	const char		*val;
+};
+
+/* Utility Functions */
+static inline bool is_quote(char c)
+{
+	return c == '"' || c == '\'';
+}
+
+static inline bool valid_token(char *s)
+{
+	return !s || !strpbrk(s, "\"\'");
+}
+
+static inline bool is_default(const struct token *t)
+{
+	return !t->val &&  t->key_priority == default_action;
+}
+
+static inline bool is_operation(const struct token *t)
+{
+	return t->val && t->key_priority == op;
+}
+
+static inline bool is_action(const struct token *t)
+{
+	return t->val && t->key_priority == action;
+}
+
+static inline bool is_name(const struct token *t)
+{
+	return t->val && t->key_priority == policy_name;
+}
+
+static inline bool is_ver(const struct token *t)
+{
+	return t->val && t->key_priority == policy_ver;
+}
+
+static int cmp_pri(void *priv, struct list_head *a, struct list_head *b)
+{
+	struct token *t_a = container_of(a, struct token, next_tok);
+	struct token *t_b = container_of(b, struct token, next_tok);
+
+	return t_b->key_priority - t_a->key_priority;
+}
+
+static char *trim_quotes(char *str)
+{
+	char s;
+	size_t len;
+
+	if (!str)
+		return str;
+
+	s = *str;
+
+	if (is_quote(s)) {
+		len = strlen(str) - 1;
+
+		if (str[len] != s)
+			return NULL;
+
+		str[len] = '\0';
+		++str;
+	}
+
+	return str;
+}
+
+/**
+ * ipe_set_action: Set an action with error checking.
+ * @src: Valid pointer to the source location to set wih the result
+ * @set: Value to apply to @src, if valid
+ *
+ * Return:
+ * 0 - OK
+ * -EBADMSG - Attempting to set something that is already set
+ */
+static int ipe_set_action(enum ipe_action *src, enum ipe_action set)
+{
+	if (*src != ipe_action_unset)
+		return -EBADMSG;
+
+	*src = set;
+
+	return 0;
+}
+
+/**
+ * ipe_insert_token: Allocate and append the key=value pair indicated by @val,
+ *		     to the list represented by @head.
+ * @val: Token to parse, of form "key=val".
+ * @head: Head of the list to insert the token structure into.
+ *
+ * If "=val" is omitted, this function will succeed, and the value set will be
+ * NULL.
+ *
+ * Return:
+ * 0 - OK
+ * -EBADMSG - Invalid policy syntax
+ * -ENOMEM - No Memory
+ */
+static int ipe_insert_token(char *val, struct list_head *head)
+{
+	char *key;
+	substring_t match[MAX_OPT_ARGS];
+	struct token *tok;
+	const match_table_t prop_priorities = {
+		{ policy_name,		IPE_HEADER_POLICY_NAME },
+		{ policy_ver,		IPE_HEADER_POLICY_VERSION},
+		{ op,			IPE_PROPERTY_OPERATION },
+		{ default_action,	IPE_PROPERTY_DEFAULT },
+		{ action,		IPE_PROPERTY_ACTION },
+		{ other, NULL },
+	};
+
+	key = strsep(&val, "=");
+	if (!key)
+		return -EBADMSG;
+
+	tok = kzalloc(sizeof(*tok), GFP_KERNEL);
+	if (!tok)
+		return -ENOMEM;
+
+	tok->key = key;
+	tok->val = trim_quotes(val);
+
+	/* remap empty string */
+	if (tok->val && !strlen(tok->val))
+		tok->val = NULL;
+
+	tok->key_priority = match_token(key, prop_priorities, match);
+	INIT_LIST_HEAD(&tok->next_tok);
+
+	list_add_tail(&tok->next_tok, head);
+
+	return 0;
+}
+
+/**
+ * ipe_tokenize_line: Parse a line of text into a list of token structures.
+ * @line: Line to parse.
+ * @list: Head of the list to insert the token structure into.
+ *
+ * The final result will be sorted in the priority order definted by
+ * enum property_priorities to enforce policy structure.
+ *
+ * Return:
+ * 0 - OK
+ * -EBADMSG - Invalid policy syntax
+ * -ENOMEM - No Memory
+ * -ENOENT - No tokens were parsed
+ */
+static int ipe_tokenize_line(char *line, struct list_head *list)
+{
+	int rc = 0;
+	size_t i = 0;
+	size_t len = 0;
+	char *tok = NULL;
+	char quote = '\0';
+
+	len = strlen(line);
+
+	for (i = 0; i < len; ++i) {
+		if (quote == '\0' && is_quote(line[i])) {
+			quote = line[i];
+			continue;
+		}
+
+		if (quote != '\0' && line[i] == quote) {
+			quote = '\0';
+			continue;
+		}
+
+		if (quote == '\0' && line[i] == COMMENT_CHAR) {
+			tok = NULL;
+			break;
+		}
+
+		if (isgraph(line[i]) && !tok)
+			tok = &line[i];
+
+		if (quote == '\0' && isspace(line[i])) {
+			line[i] = '\0';
+
+			if (!tok)
+				continue;
+
+			rc = ipe_insert_token(tok, list);
+			if (rc != 0)
+				return rc;
+
+			tok = NULL;
+		}
+	}
+
+	if (quote != '\0')
+		return -EBADMSG;
+
+	if (tok)
+		ipe_insert_token(tok, list);
+
+	if (list_empty(list))
+		return -ENOENT;
+
+	list_sort(NULL, list, cmp_pri);
+
+	return 0;
+}
+
+static inline int ipe_parse_version(const char *val, struct ipe_pol_ver *ver)
+{
+	if (sscanf(val, VER_FSTR, &ver->major, &ver->minor, &ver->rev) != 3)
+		return -EBADMSG;
+
+	return 0;
+}
+
+/**
+ * ipe_parse_action: Given a token, parse the value as if it were an 'action'
+ *		     token.
+ * @action: Token to parse to determine the action.
+ *
+ * Action tokens are of the form: action=(ALLOW|DENY) for more information
+ * about IPE policy, please see the documentation.
+ *
+ * Return:
+ * ipe_action_allow - OK
+ * ipe_action_deny - OK
+ * ipe_action_unset - ERR
+ */
+static enum ipe_action ipe_parse_action(struct token *action)
+{
+	if (!action->val)
+		return ipe_action_unset;
+	else if (!strcmp(action->val, ALLOW_ACTION))
+		return ipe_action_allow;
+	else if (!strcmp(action->val, DENY_ACTION))
+		return ipe_action_deny;
+
+	return ipe_action_unset;
+}
+
+/**
+ * ipe_parse_op: Given a token, parse the value as if it were an 'op' token.
+ * @op: Token to parse to determine the operation.
+ *
+ * "op" tokens are of the form: op=(EXECUTE|FIRMWARE|KEXEC_IMAGE|...)
+ * for more information about IPE policy, please see the documentation.
+ *
+ * Return:
+ * ipe_op_max - ERR
+ * otherwise - OK
+ */
+static enum ipe_op ipe_parse_op(struct token *op)
+{
+	substring_t match[MAX_OPT_ARGS];
+	const match_table_t ops = {
+		{ ipe_op_execute,		IPE_OP_EXECUTE },
+		{ ipe_op_firmware,		IPE_OP_FIRMWARE },
+		{ ipe_op_kexec_image,		IPE_OP_KEXEC_IMAGE },
+		{ ipe_op_kexec_initramfs,	IPE_OP_KEXEC_INITRAMFS },
+		{ ipe_op_x509,			IPE_OP_X509_CERTIFICATE },
+		{ ipe_op_policy,		IPE_OP_POLICY },
+		{ ipe_op_kmodule,		IPE_OP_KMODULE },
+		{ ipe_op_kernel_read,		IPE_OP_KERNEL_READ },
+		{ ipe_op_max,			NULL },
+	};
+
+	return match_token((char *)op->val, ops, match);
+}
+
+/**
+ * ipe_set_default: Set the default of the policy, at various scope levels
+ *		    depending on the value of op.
+ * @op: Operation that was parsed.
+ * @pol: Policy to modify with the newly-parsed default action.
+ * @a: Action token (see parse_action) to parse to determine
+ *     the default.
+ *
+ * Return:
+ * 0 - OK
+ * -EBADMSG - Invalid policy format
+ */
+static int ipe_set_default(enum ipe_op op, struct ipe_policy *pol,
+			   struct token *a)
+{
+	int rc = 0;
+	size_t i = 0;
+	enum ipe_action act = ipe_parse_action(a);
+
+	if (act == ipe_action_unset)
+		return -EBADMSG;
+
+	if (op == ipe_op_max)
+		return ipe_set_action(&pol->def, act);
+
+	if (op == ipe_op_kernel_read) {
+		for (i = ipe_op_firmware; i <= ipe_op_kmodule; ++i) {
+			rc = ipe_set_action(&pol->ops[i].def, act);
+			if (rc != 0)
+				return rc;
+		}
+		return 0;
+	}
+
+	return ipe_set_action(&pol->ops[op].def, act);
+}
+
+/**
+ * ipe_parse_default: Parse a default statement of an IPE policy modify @pol
+ *		      with the proper changes
+ * @tokens: List of tokens parsed from the line
+ * @pol: Policy to modify with the newly-parsed default action
+ *
+ *
+ * Return:
+ * 0 - OK
+ * -EBADMSG - Invalid policy format
+ * -ENOENT - Unknown policy structure
+ */
+static int ipe_parse_default(struct list_head *tokens,
+			     struct ipe_policy *pol)
+{
+	struct token *f = NULL;
+	struct token *s = NULL;
+	struct token *t = NULL;
+	enum ipe_op i = ipe_op_max;
+
+	f = list_first_entry(tokens, struct token, next_tok);
+	s = list_next_entry(f, next_tok);
+	if (is_action(s))
+		return ipe_set_default(ipe_op_max, pol, s);
+
+	i = ipe_parse_op(s);
+	if (i == ipe_op_max)
+		return -ENOENT;
+
+	t = list_next_entry(s, next_tok);
+	if (is_action(t)) {
+		t = list_next_entry(s, next_tok);
+		return ipe_set_default(i, pol, t);
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * ipe_free_token_list - Free a list of tokens, and then reinitialize @list
+ *			 dropping all tokens.
+ * @list: List to be freed.
+ */
+static void ipe_free_token_list(struct list_head *list)
+{
+	struct token *ptr, *next;
+
+	list_for_each_entry_safe(ptr, next, list, next_tok)
+		kfree(ptr);
+
+	INIT_LIST_HEAD(list);
+}
+
+/**
+ * ipe_free_prop - Deallocator for an ipe_prop_container structure.
+ * @cont: Object to free.
+ */
+static void ipe_free_prop(struct ipe_prop_container *cont)
+{
+	if (IS_ERR_OR_NULL(cont))
+		return;
+
+	if (cont->prop->free_val)
+		cont->prop->free_val(&cont->value);
+	kfree(cont);
+}
+
+/**
+ * ipe_alloc_prop: Allocator for a ipe_prop_container structure.
+ * @tok: Token structure representing the "key=value" pair of the property.
+ *
+ * Return:
+ * Pointer to ipe_rule - OK
+ * ERR_PTR(-ENOMEM) - Allocation failed
+ */
+static struct ipe_prop_container *ipe_alloc_prop(const struct token *tok)
+{
+	int rc = 0;
+	const struct ipe_property *prop = NULL;
+	struct ipe_prop_container *cont = NULL;
+
+	prop = ipe_lookup_prop(tok->key);
+	if (!prop) {
+		rc = -ENOENT;
+		goto err;
+	}
+
+	cont = kzalloc(sizeof(*cont), GFP_KERNEL);
+	if (!cont) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	INIT_LIST_HEAD(&cont->next);
+
+	rc = prop->parse(tok->val, &cont->value);
+	if (rc != 0)
+		goto err;
+
+	cont->prop = prop;
+
+	return cont;
+err:
+	ipe_free_prop(cont);
+	return ERR_PTR(rc);
+}
+
+/**
+ * ipe_free_rule: Deallocator for an ipe_rule structure.
+ * @rule: Object to free.
+ */
+static void ipe_free_rule(struct ipe_rule *rule)
+{
+	struct ipe_prop_container *ptr;
+	struct list_head *l_ptr, *l_next;
+
+	if (IS_ERR_OR_NULL(rule))
+		return;
+
+	list_for_each_safe(l_ptr, l_next, &rule->props) {
+		ptr = container_of(l_ptr, struct ipe_prop_container, next);
+		list_del(l_ptr);
+		ipe_free_prop(ptr);
+	}
+
+	kfree(rule);
+}
+
+/**
+ * ipe_alloc_rule: Allocate a ipe_rule structure, for operation @op, parsed
+ *		   from the first token in list @head.
+ * @op: Operation parsed from the first token in @head.
+ * @t: The first token in @head that was parsed.
+ * @head: List of remaining tokens to parse.
+ *
+ * Return:
+ * Valid ipe_rule pointer - OK
+ * ERR_PTR(-EBADMSG) - Invalid syntax
+ * ERR_PTR(-ENOMEM) - Out of memory
+ */
+static struct ipe_rule *ipe_alloc_rule(enum ipe_op op, struct token *t,
+				       struct list_head *head)
+{
+	int rc = 0;
+	struct token *ptr;
+	enum ipe_action act;
+	struct ipe_rule *rule = NULL;
+	struct ipe_prop_container *prop = NULL;
+
+	ptr = list_next_entry(t, next_tok);
+	if (!is_action(ptr)) {
+		rc = -EBADMSG;
+		goto err;
+	}
+
+	act = ipe_parse_action(ptr);
+	if (act == ipe_action_unset) {
+		rc = -EBADMSG;
+		goto err;
+	}
+
+	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
+	if (!rule) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	INIT_LIST_HEAD(&rule->props);
+	INIT_LIST_HEAD(&rule->next);
+	rule->action = act;
+	rule->op = op;
+
+	list_for_each_entry_continue(ptr, head, next_tok) {
+		prop = ipe_alloc_prop(ptr);
+
+		if (IS_ERR(prop)) {
+			rc = PTR_ERR(prop);
+			goto err;
+		}
+
+		list_add_tail(&prop->next, &rule->props);
+	}
+
+	return rule;
+err:
+	ipe_free_prop(prop);
+	ipe_free_rule(rule);
+	return ERR_PTR(rc);
+}
+
+/**
+ * ipe_dup_prop: Duplicate an ipe_prop_container structure
+ * @p: Container to duplicate.
+ *
+ * This function is used to duplicate individual properties within a rule.
+ * It should only be called in operations that actually map to one or more
+ * operations.
+ *
+ * Return:
+ * Valid ipe_prop_container - OK
+ * ERR_PTR(-ENOMEM) - Out of memory
+ * Other Errors - see various property duplicator functions
+ */
+static
+struct ipe_prop_container *ipe_dup_prop(const struct ipe_prop_container *p)
+{
+	int rc = 0;
+	struct ipe_prop_container *dup;
+
+	dup = kzalloc(sizeof(*dup), GFP_KERNEL);
+	if (!dup) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	dup->prop = p->prop;
+	INIT_LIST_HEAD(&dup->next);
+
+	rc = p->prop->dup(p->value, &dup->value);
+	if (rc != 0)
+		goto err;
+
+	return dup;
+err:
+	ipe_free_prop(dup);
+	return ERR_PTR(rc);
+}
+
+/**
+ * ipe_dup_rule: Duplicate a policy rule, used for pseudo hooks like
+ *		 KERNEL_READ to map a policy rule across all hooks.
+ * @r: Rule to duplicate.
+ *
+ * Return:
+ * valid ipe_rule - OK
+ * ERR_PTR(-ENOMEM) - Out of memory
+ * Other Errors - See ipe_dup_prop
+ */
+static struct ipe_rule *ipe_dup_rule(const struct ipe_rule *r)
+{
+	int rc = 0;
+	struct ipe_rule *dup;
+	struct ipe_prop_container *ptr;
+
+	dup = kzalloc(sizeof(*dup), GFP_KERNEL);
+	if (!dup) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	dup->op = r->op;
+	dup->action = r->action;
+	INIT_LIST_HEAD(&dup->props);
+	INIT_LIST_HEAD(&dup->next);
+
+	list_for_each_entry(ptr, &r->props, next) {
+		struct ipe_prop_container *prop2;
+
+		prop2 = ipe_dup_prop(ptr);
+		if (IS_ERR(prop2)) {
+			rc = PTR_ERR(prop2);
+			goto err;
+		}
+
+		list_add_tail(&prop2->next, &dup->props);
+	}
+
+	return dup;
+err:
+	ipe_free_rule(dup);
+	return ERR_PTR(rc);
+}
+
+/**
+ * ipe_free_policy: Deallocate an ipe_policy structure.
+ * @pol: Policy to free.
+ */
+void ipe_free_policy(struct ipe_policy *pol)
+{
+	size_t i;
+	struct ipe_rule *ptr;
+	struct ipe_rule_table *op;
+	struct list_head *l_ptr, *l_next;
+
+	if (IS_ERR_OR_NULL(pol))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(pol->ops); ++i) {
+		op = &pol->ops[i];
+
+		list_for_each_safe(l_ptr, l_next, &op->rules) {
+			ptr = list_entry(l_ptr, struct ipe_rule, next);
+			list_del(l_ptr);
+			ipe_free_rule(ptr);
+		}
+	}
+
+	kfree(pol->policy_name);
+	kfree(pol);
+}
+
+/**
+ * ipe_alloc_policy: Give a list of tokens representing the first line of the
+ *		     token, attempt to parse it as an IPE policy header, and
+ *		     allocate a policy structure based on those values.
+ * @tokens: List of tokens parsed from the first line of the policy
+ *
+ * Return:
+ * Valid ipe_policy pointer - OK
+ * ERR_PTR(-ENOMEM) - Out of memory
+ * ERR_PTR(-EBADMSG) - Invalid policy syntax
+ */
+static struct ipe_policy *ipe_alloc_policy(struct list_head *tokens)
+{
+	size_t i;
+	int rc = 0;
+	struct token *name = NULL;
+	struct token *ver = NULL;
+	struct ipe_policy *lp = NULL;
+
+	name = list_first_entry(tokens, struct token, next_tok);
+	if (!is_name(name)) {
+		rc = -EBADMSG;
+		goto err;
+	}
+
+	if (list_is_singular(tokens)) {
+		rc = -EBADMSG;
+		goto err;
+	}
+
+	ver = list_next_entry(name, next_tok);
+	if (!is_ver(ver)) {
+		rc = -EBADMSG;
+		goto err;
+	}
+
+	lp = kzalloc(sizeof(*lp), GFP_KERNEL);
+	if (!lp) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(lp->ops); ++i) {
+		lp->ops[i].def = ipe_action_unset;
+		INIT_LIST_HEAD(&lp->ops[i].rules);
+	}
+
+	lp->policy_name = kstrdup(name->val, GFP_KERNEL);
+	if (!lp->policy_name) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	rc = ipe_parse_version(ver->val, &lp->policy_version);
+	if (rc != 0)
+		goto err;
+
+	lp->def = ipe_action_unset;
+
+	return lp;
+err:
+	ipe_free_policy(lp);
+	return ERR_PTR(rc);
+}
+
+/**
+ * ipe_add_rule_for_range: Given a ipe_rule @r, duplicate @r and add the rule
+ *			   to @pol for the operation range @start to @end.
+ * @start: The starting point of the range to add the rule to.
+ * @end: The ending point of the range to add the rule to.
+ * @r: The rule to copy.
+ * @pol: Policy structure to modify with the result.
+ *
+ * This is @start to @end, inclusive. @r is still valid after this function,
+ * and should be freed if appropriate.
+ *
+ * Return:
+ * 0 - OK
+ * Other Errors - See ipe_dup_prop
+ */
+static int ipe_add_rule_for_range(enum ipe_op start, enum ipe_op end,
+				  struct ipe_rule *r, struct ipe_policy *pol)
+{
+	enum ipe_op i;
+	struct ipe_rule *cpy = NULL;
+
+	for (i = start; i <= end; ++i) {
+		cpy = ipe_dup_rule(r);
+		if (IS_ERR(cpy))
+			return PTR_ERR(cpy);
+
+		list_add_tail(&cpy->next, &pol->ops[i].rules);
+	}
+
+	return 0;
+}
+
+/**
+ * ipe_parse_line: Given a list of tokens, attempt to parse it into a rule
+ *		   structure, and add it to the passed-in ipe_policy structure.
+ * @tokens: List of tokens that were parsed.
+ * @pol: Policy structure to modify with the result.
+ *
+ * Return:
+ * 0 - OK
+ * -ENOENT - Unrecognized property
+ * -ENOMEM - Out of memory
+ * Other Errors - See ipe_dup_prop
+ */
+static int ipe_parse_line(struct list_head *tokens,
+			  struct ipe_policy *pol)
+{
+	int rc = 0;
+	struct token *f;
+	enum ipe_op i = ipe_op_max;
+	struct ipe_rule *rule = NULL;
+
+	f = list_first_entry(tokens, struct token, next_tok);
+
+	switch (f->key_priority) {
+	case default_action:
+		rc = ipe_parse_default(tokens, pol);
+		break;
+	case op:
+		i = ipe_parse_op(f);
+		if (i == ipe_op_max)
+			return -ENOENT;
+
+		if (list_is_singular(tokens))
+			return -EBADMSG;
+
+		rule = ipe_alloc_rule(i, f, tokens);
+		if (IS_ERR(rule)) {
+			rc = PTR_ERR(rule);
+			goto cleanup;
+		}
+
+		if (i == ipe_op_kernel_read) {
+			rc = ipe_add_rule_for_range(ipe_op_firmware,
+						    ipe_op_kmodule, rule, pol);
+			if (rc != 0)
+				goto cleanup;
+		} else {
+			list_add_tail(&rule->next, &pol->ops[i].rules);
+			rule = NULL;
+		}
+		break;
+	default:
+		return -ENOENT;
+	}
+
+cleanup:
+	ipe_free_rule(rule);
+	return rc;
+}
+
+/**
+ * ipe_check_policy_defaults: Ensure all defaults in policy are set
+ *	for every operation known to IPE.
+ *
+ * @p: Policy to check the defaults.
+ *
+ * Return:
+ * 0 - OK
+ * -EBADMSG - A default was left unset.
+ */
+static int ipe_check_policy_defaults(const struct ipe_policy *p)
+{
+	size_t i;
+
+	if (p->def == ipe_action_unset) {
+		for (i = 0; i < ARRAY_SIZE(p->ops); ++i) {
+			if (p->ops[i].def == ipe_action_unset) {
+				ipe_audit_unset_remap((enum ipe_op)i);
+				return -EBADMSG;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ipe_parse_policy: Given a string, parse the string into an IPE policy
+ *		     structure.
+ * @policy: NULL terminated string to parse.
+ *
+ * This function will modify @policy.
+ *
+ * Return:
+ * Valid ipe_policy structure - OK
+ * ERR_PTR(-EBADMSG) - Invalid Policy Syntax (Unrecoverable)
+ * ERR_PTR(-ENOMEM) - Out of Memory
+ */
+struct ipe_policy *ipe_parse_policy(char *policy)
+{
+	int rc = 0;
+	size_t i = 1;
+	char *p = NULL;
+	LIST_HEAD(t_list);
+	struct ipe_policy *local_p = NULL;
+
+	while ((p = strsep(&policy, "\n\0")) != NULL) {
+		rc = ipe_tokenize_line(p, &t_list);
+		if (rc == -ENOENT) {
+			++i;
+			continue;
+		}
+		if (rc != 0)
+			goto err;
+
+		if (!local_p) {
+			local_p = ipe_alloc_policy(&t_list);
+			if (IS_ERR(local_p)) {
+				rc = PTR_ERR(local_p);
+				goto err;
+			}
+		} else {
+			rc = ipe_parse_line(&t_list, local_p);
+			if (rc) {
+				pr_warn("failed to parse line %zu", i);
+				goto err;
+			}
+		}
+
+		ipe_free_token_list(&t_list);
+		++i;
+	}
+
+	rc = ipe_check_policy_defaults(local_p);
+	if (rc != 0)
+		goto err;
+
+	return local_p;
+err:
+	ipe_free_token_list(&t_list);
+	ipe_free_policy(local_p);
+	return ERR_PTR(rc);
+}
diff --git a/security/ipe/ipe-parse.h b/security/ipe/ipe-parse.h
new file mode 100644
index 000000000000..b1a9bbd97534
--- /dev/null
+++ b/security/ipe/ipe-parse.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe-policy.h"
+
+#include <linux/types.h>
+
+#ifndef IPE_PARSE_H
+#define IPE_PARSE_H
+
+struct ipe_policy *ipe_parse_policy(char *policy);
+
+void ipe_free_policy(struct ipe_policy *pol);
+
+#endif /* IPE_AUDIT_H */
diff --git a/security/ipe/ipe-policy.c b/security/ipe/ipe-policy.c
new file mode 100644
index 000000000000..8100a8aa3fa9
--- /dev/null
+++ b/security/ipe/ipe-policy.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-secfs.h"
+#include "ipe-policy.h"
+#include "ipe-parse.h"
+#include "ipe-audit.h"
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/lockdep.h>
+#include <linux/fs.h>
+#include <linux/security.h>
+#include <linux/rcupdate.h>
+
+#define VER_TO_UINT64(_major, _minor, _rev) \
+	((((((u64)(_major)) << 16) | ((u64)(_minor))) << 16) | ((u64)(_rev)))
+
+/**
+ * ipe_is_version_allowed: Determine if @new has a greater or equal
+ *			   policy version than @old.
+ * @old: The policy to compare against.
+ * @new: The policy staged to replace @old.
+ *
+ * Return:
+ * true - @new has a policy version >= than @old
+ * false - @new does not have a policy version >= than @old
+ */
+static bool ipe_is_version_allowed(const struct ipe_pol_ver *old,
+				   const struct ipe_pol_ver *new)
+{
+	u64 old_ver = VER_TO_UINT64(old->major, old->minor, old->rev);
+	u64 new_ver = VER_TO_UINT64(new->major, new->minor, new->rev);
+
+	return new_ver >= old_ver;
+}
+
+/**
+ * ipe_is_valid_policy: determine if @old is allowed to replace @new.
+ * @old: policy that the @new is supposed to replace. Can be NULL.
+ * @new: the policy that is supposed to replace @new.
+ *
+ * Return:
+ * true - @new can replace @old
+ * false - @new cannot replace @old
+ */
+bool ipe_is_valid_policy(const struct ipe_policy *old,
+			 const struct ipe_policy *new)
+{
+	if (old)
+		return ipe_is_version_allowed(&old->policy_version,
+					      &new->policy_version);
+	return true;
+}
+
+/**
+ * ipe_is_active_policy: Determine if @policy is the currently active policy.
+ * @policy: Policy to check if it's the active policy.
+ *
+ * Return:
+ * true - @policy is the active policy
+ * false - @policy is not the active policy
+ */
+bool ipe_is_active_policy(const struct ipe_policy *policy)
+{
+	return rcu_access_pointer(ipe_active_policy) == policy;
+}
+
+/**
+ * ipe_update_active_policy: Determine if @old is the active policy, and update
+ *			     the active policy if necessary.
+ * @old: The previous policy that the update is trying to replace.
+ * @new: The new policy attempting to replace @old.
+ *
+ * If @old is not the active policy, nothing will be done.
+ *
+ * Return:
+ * 0 - OK
+ * -EBADMSG - Invalid Policy
+ */
+int ipe_update_active_policy(const struct ipe_policy *old,
+			     const struct ipe_policy *new)
+{
+	const struct ipe_policy *curr = NULL;
+
+	lockdep_assert_held(&ipe_policy_lock);
+
+	/* no active policy, safe to update */
+	if (!rcu_access_pointer(ipe_active_policy))
+		return 0;
+
+	curr = rcu_dereference_protected(ipe_active_policy,
+					 lockdep_is_held(&ipe_policy_lock));
+
+	if (curr == old) {
+		if (!ipe_is_valid_policy(curr, new))
+			return -EINVAL;
+
+		ipe_audit_policy_activation(new);
+
+		(void)rcu_replace_pointer(ipe_active_policy, new,
+					  lockdep_is_held(&ipe_policy_lock));
+	}
+
+	return 0;
+}
+
+/**
+ * ipe_activate_policy: Set a specific policy as the active policy.
+ * @pol: The policy to set as the active policy.
+ *
+ * This is only called by the sysctl "ipe.active_policy".
+ *
+ * Return:
+ * 0 - OK
+ * -EINVAL - Policy that is being activated is lower in version than
+ *	     currently running policy.
+ */
+int ipe_activate_policy(const struct ipe_policy *pol)
+{
+	const struct ipe_policy *curr = NULL;
+
+	lockdep_assert_held(&ipe_policy_lock);
+
+	curr = rcu_dereference_protected(ipe_active_policy,
+					 lockdep_is_held(&ipe_policy_lock));
+
+	/*
+	 * User-set policies must be >= to current running policy.
+	 */
+	if (!ipe_is_valid_policy(curr, pol))
+		return -EINVAL;
+
+	ipe_audit_policy_activation(pol);
+
+	/* cleanup of this pointer is handled by the secfs removal */
+	(void)rcu_replace_pointer(ipe_active_policy, pol,
+				  lockdep_is_held(&ipe_policy_lock));
+
+	return 0;
+}
diff --git a/security/ipe/ipe-policy.h b/security/ipe/ipe-policy.h
index c0c9f2962c92..b3ef3d3d2e7f 100644
--- a/security/ipe/ipe-policy.h
+++ b/security/ipe/ipe-policy.h
@@ -14,9 +14,6 @@
 #ifndef IPE_POLICY_H
 #define IPE_POLICY_H
 
-#define IPE_HEADER_POLICY_NAME		"policy_name"
-#define IPE_HEADER_POLICY_VERSION	"policy_version"
-
 extern const char *const ipe_boot_policy;
 extern const struct ipe_policy *ipe_active_policy;
 
@@ -59,4 +56,14 @@ struct ipe_policy {
 	struct ipe_rule_table ops[ipe_op_max - 1];
 };
 
+bool ipe_is_valid_policy(const struct ipe_policy *old,
+			 const struct ipe_policy *new);
+
+bool ipe_is_active_policy(const struct ipe_policy *policy);
+
+int ipe_update_active_policy(const struct ipe_policy *old,
+			     const struct ipe_policy *new);
+
+int ipe_activate_policy(const struct ipe_policy *policy);
+
 #endif /* IPE_POLICY_H */
diff --git a/security/ipe/ipe-prop-internal.h b/security/ipe/ipe-prop-internal.h
index 95a2081e77ee..0d5cde61784c 100644
--- a/security/ipe/ipe-prop-internal.h
+++ b/security/ipe/ipe-prop-internal.h
@@ -10,10 +10,20 @@
 #ifndef IPE_PROPERTY_INTERNAL_H
 #define IPE_PROPERTY_INTERNAL_H
 
+/* built-in tokens */
+#define IPE_HEADER_POLICY_NAME		"policy_name"
+#define IPE_HEADER_POLICY_VERSION	"policy_version"
 #define IPE_PROPERTY_OPERATION	"op"
 #define IPE_PROPERTY_DEFAULT	"DEFAULT"
 #define IPE_PROPERTY_ACTION	"action"
 
+/* Version strings for built-in tokens */
+#define IPE_PROPERTY_OPERATION_VER	IPE_PROPERTY_OPERATION		"=1"
+#define IPE_PROPERTY_ACTION_VER		IPE_PROPERTY_ACTION		"=1"
+#define IPE_PROPERTY_DEFAULT_VER	IPE_PROPERTY_DEFAULT		"=1"
+#define IPE_HEADER_POLICY_NAME_VER	IPE_HEADER_POLICY_NAME		"=1"
+#define IPE_HEADER_POLICY_VERSION_VER	IPE_HEADER_POLICY_VERSION	"=1"
+
 #define IPE_OP_EXECUTE		"EXECUTE"
 #define IPE_OP_FIRMWARE		"FIRMWARE"
 #define IPE_OP_KEXEC_IMAGE	"KEXEC_IMAGE"
@@ -23,6 +33,8 @@
 #define IPE_OP_KMODULE		"KMODULE"
 #define IPE_OP_KERNEL_READ	"KERNEL_READ"
 
+#define IPE_UNKNOWN		"UNKNOWN"
+
 struct ipe_prop_reg {
 	struct rb_node node;
 	const struct ipe_property *prop;
diff --git a/security/ipe/ipe-property.h b/security/ipe/ipe-property.h
index cf570d52d0d2..8bb2e2c1619c 100644
--- a/security/ipe/ipe-property.h
+++ b/security/ipe/ipe-property.h
@@ -86,6 +86,7 @@ typedef void (*ipe_free_value)(void **value);
 
 struct ipe_property {
 	const char			*const property_name;
+	u16				version;
 	ipe_property_evaluator		eval;
 	ipe_property_audit		rule_audit;
 	ipe_ctx_audit			ctx_audit;
diff --git a/security/ipe/ipe-secfs.c b/security/ipe/ipe-secfs.c
new file mode 100644
index 000000000000..102444b8cc59
--- /dev/null
+++ b/security/ipe/ipe-secfs.c
@@ -0,0 +1,1308 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "ipe.h"
+#include "ipe-parse.h"
+#include "ipe-secfs.h"
+#include "ipe-policy.h"
+#include "ipe-audit.h"
+
+#include <linux/types.h>
+#include <linux/security.h>
+#include <linux/fs.h>
+#include <linux/rcupdate.h>
+#include <linux/mutex.h>
+#include <linux/init.h>
+#include <linux/dcache.h>
+#include <linux/namei.h>
+#include <linux/verification.h>
+#include <linux/capability.h>
+
+#define IPE_ROOT		"ipe"
+#define IPE_POLICIES		"policies"
+#define NEW_POLICY		"new_policy"
+#define IPE_PROPERTY_CFG	"property_config"
+#define IPE_SUCCESS_AUDIT	"success_audit"
+#define IPE_ENFORCE		"enforce"
+
+#define IPE_FULL_CONTENT	"raw"
+#define IPE_INNER_CONTENT	"content"
+#define IPE_ACTIVE_POLICY	"active"
+#define IPE_DELETE_POLICY	"delete"
+
+struct ipe_policy_node {
+	u8		*data;
+	size_t		data_len;
+	const u8	*content;
+	size_t		content_size;
+
+	struct ipe_policy *parsed;
+};
+
+/* root directory */
+static struct dentry *securityfs_root __ro_after_init;
+
+/* subdirectory containing policies */
+static struct dentry *policies_root __ro_after_init;
+
+/* boot policy */
+static struct dentry *boot_policy_node __ro_after_init;
+
+/* top-level IPE commands */
+static struct dentry *new_policy_node __ro_after_init;
+static struct dentry *property_cfg_node __ro_after_init;
+static struct dentry *enforce_node __ro_after_init;
+static struct dentry *success_audit_node __ro_after_init;
+
+/* lock for synchronizing writers across ipe policy */
+DEFINE_MUTEX(ipe_policy_lock);
+
+/**
+ * get_int_user - retrieve a single integer from a string located in userspace.
+ * @data: usespace address to parse for an integer
+ * @len: length of @data
+ * @offset: offset into @data. Unused.
+ * @value: pointer to a value to propagate with the result
+ *
+ * Return:
+ * 0 - OK
+ * -ENOMEM - allocation failed
+ * -EINVAL - more than 1 integer was present
+ * Other - see strnpy_from_user
+ */
+static int get_int_user(const char __user *data, size_t len, loff_t *offset,
+			int *value)
+{
+	int rc = 0;
+	char *buffer = NULL;
+
+	buffer = kzalloc(len + 1, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	rc = strncpy_from_user(buffer, data, len + 1);
+	if (rc < 0)
+		goto out;
+
+	rc = kstrtoint(buffer, 10, value);
+out:
+	kfree(buffer);
+	return rc;
+}
+
+/**
+ * ipe_get_audit_mode - retrieve the current value of the success_audit flag
+ *			as a string representation.
+ * @f: The file structure representing the securityfs entry. Unused.
+ * @data: userspace buffer to place the result
+ * @len: length of @data
+ * @offset: offset into @data
+ *
+ * This is the handler for the 'read' syscall on the securityfs node,
+ * ipe/success_audit
+ *
+ * Return:
+ * > 0 - OK
+ * < 0 - Error, see simple_read_from_buffer
+ */
+static ssize_t ipe_get_audit_mode(struct file *f, char __user *data, size_t len,
+				  loff_t *offset)
+{
+	char tmp[3] = { 0 };
+
+	snprintf(tmp, ARRAY_SIZE(tmp), "%c\n", (ipe_success_audit) ? '1' : '0');
+
+	return simple_read_from_buffer(data, len, offset, tmp,
+				       ARRAY_SIZE(tmp));
+}
+
+/**
+ * ipe_set_audit_mode - change the value of the ipe_success_audit flag.
+ * @f: The file structure representing the securityfs entry
+ * @data: userspace buffer containing value to be set. Should be "1" or "0".
+ * @len: length of @data
+ * @offset: offset into @data
+ *
+ * Return:
+ * > 0 - OK
+ * -EPERM - if MAC system available, missing CAP_MAC_ADMIN.
+ * -EINVAL - value written was not "1" or "0".
+ */
+static ssize_t ipe_set_audit_mode(struct file *f, const char __user *data, size_t len,
+				  loff_t *offset)
+{
+	int v = 0;
+	int rc = 0;
+
+	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
+		return -EPERM;
+
+	rc = get_int_user(data, len, offset, &v);
+	if (rc)
+		return rc;
+
+	if (v != 0 && v != 1)
+		return -EINVAL;
+
+	ipe_success_audit = v == 1;
+
+	return len;
+}
+
+static const struct file_operations audit_ops = {
+	.read = ipe_get_audit_mode,
+	.write = ipe_set_audit_mode
+};
+
+#ifdef CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH
+
+/**
+ * ipe_get_enforce - retrieve the current value of the ipe_enforce flag
+ *		     as a string representation.
+ * @f: The file structure representing the securityfs entry. Unused.
+ * @data: userspace buffer to place the result
+ * @len: length of @data
+ * @offset: offset into @data
+ *
+ * This is the handler for the 'read' syscall on the securityfs node,
+ * ipe/enforce
+ *
+ * Return:
+ * > 0 - OK
+ * < 0 - Error, see simple_read_from_buffer
+ */
+static ssize_t ipe_get_enforce(struct file *f, char __user *data, size_t len,
+			       loff_t *offset)
+{
+	char tmp[3] = { 0 };
+
+	snprintf(tmp, ARRAY_SIZE(tmp), "%c\n", (ipe_enforce) ? '1' : '0');
+
+	return simple_read_from_buffer(data, len, offset, tmp,
+				       ARRAY_SIZE(tmp));
+}
+
+/**
+ * ipe_set_enforce - change the value of the ipe_enforce flag.
+ * @f: The file structure representing the securityfs entry
+ * @data: userspace buffer containing value to be set. Should be "1" or "0".
+ * @len: length of @data
+ * @offset: offset into @data
+ *
+ * Return:
+ * > 0 - OK
+ * -EPERM - if MAC system available, missing CAP_MAC_ADMIN.
+ * -EINVAL - value written was not "1" or "0".
+ */
+static ssize_t ipe_set_enforce(struct file *f, const char __user *data, size_t len,
+			       loff_t *offset)
+{
+	int v = 0;
+	int rc = 0;
+	bool ret = 0;
+
+	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
+		return -EPERM;
+
+	rc = get_int_user(data, len, offset, &v);
+	if (rc)
+		return rc;
+
+	if (v != 0 && v != 1)
+		return -EINVAL;
+
+	ret = v == 1;
+
+	if (ret != ipe_enforce)
+		ipe_audit_mode();
+
+	ipe_enforce = ret;
+
+	return len;
+}
+
+static const struct file_operations enforce_ops = {
+	.read = ipe_get_enforce,
+	.write = ipe_set_enforce
+};
+
+/**
+ * ipe_init_enforce_node - Wrapper around securityfs_create_file for the
+ *			   ipe/enforce securityfs node.
+ * @root: securityfs node that is the parent of the new node to be created
+ *
+ * This allows this function to be no-op'd when the permissive switch is
+ * disabled.
+ *
+ * Return:
+ * See securityfs_create_file.
+ */
+static inline struct dentry *ipe_init_enforce_node(struct dentry *root)
+{
+	return securityfs_create_file(IPE_ENFORCE, 0644, root, NULL,
+				      &enforce_ops);
+}
+
+#else
+
+/**
+ * ipe_init_enforce_node - Wrapper around securityfs_create_file for the
+ *			   ipe/enforce securityfs node.
+ * @root: Unused
+ *
+ * This allows this function to be no-op'd when the permissive switch is
+ * disabled.
+ *
+ * Return:
+ * NULL.
+ */
+static inline struct dentry *ipe_init_enforce_node(struct dentry *root)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH */
+
+/**
+ * retrieve_backed_dentry: Retrieve a dentry with a backing inode, identified
+ *			   by @name, under @parent.
+ * @name: Name of the dentry under @parent.
+ * @parent: The parent dentry to search under for @name.
+ * @size: Length of @name.
+ *
+ * This takes a reference to the returned dentry. Caller needs to call dput
+ * to drop the reference.
+ *
+ * Return:
+ * valid dentry - OK
+ * ERR_PTR - Error, see lookup_one_len_unlocked
+ * NULL - No backing inode was found
+ */
+static struct dentry *retrieve_backed_dentry(const char *name,
+					     struct dentry *parent,
+					     size_t size)
+{
+	struct dentry *tmp = NULL;
+
+	tmp = lookup_one_len_unlocked(name, parent, size);
+	if (IS_ERR(tmp))
+		return tmp;
+
+	if (!d_really_is_positive(tmp))
+		return NULL;
+
+	return tmp;
+}
+
+/**
+ * alloc_size_cb: Callback for determining the allocation size of the grammar
+ *		  buffer
+ * @prop: ipe_property structure to determine allocation size
+ * @ctx: void* representing a size_t* to add the allocation size to.
+ *
+ * Return:
+ * 0 - Always
+ */
+static int alloc_size_cb(const struct ipe_property *prop, void *ctx)
+{
+	size_t *ref = ctx;
+	char tmp[6] = { 0 };
+
+	snprintf(tmp, ARRAY_SIZE(tmp), "%d", prop->version);
+
+	/* property_name=u16\n */
+	*ref += strlen(prop->property_name) + strlen(tmp) + 2;
+
+	return 0;
+}
+
+/**
+ * build_cfg_str: Callback to populate the previously-allocated string
+ *		  buffer for ipe's grammar version with the content.
+ * @prop: ipe_property structure to determine allocation size
+ * @ctx: void* representing a char* to append the population to.
+ *
+ * Return:
+ * 0 - Always
+ */
+static int build_cfg_str(const struct ipe_property *prop, void *ctx)
+{
+	char *ref = (char *)ctx;
+	char tmp[6] = { 0 };
+
+	snprintf(tmp, ARRAY_SIZE(tmp), "%d", prop->version);
+	strcat(ref, prop->property_name);
+	strcat(ref, "=");
+	strcat(ref, tmp);
+	strcat(ref, "\n");
+
+	return 0;
+}
+
+/**
+ * create_new_prop_cfg: create a new property configuration string for consumers
+ *			of IPE policy.
+ *
+ * This function will iterate over all currently registered properties, and
+ * return a string of form:
+ *
+ *	property1=version1\n
+ *	property2=version2\n
+ *	...
+ *	propertyN=versionN
+ *
+ * Where propertyX is the property_name and versionX is the version associated.
+ *
+ * Return:
+ * !ERR_PTR - Success
+ * ERR_PTR(-ENOMEM) - Allocation Failed
+ */
+static char *create_new_prop_cfg(void)
+{
+	size_t i;
+	ssize_t rc = 0;
+	size_t alloc = 0;
+	char *ret = NULL;
+	const char *const built_ins[] = {
+		IPE_PROPERTY_OPERATION_VER,
+		IPE_PROPERTY_ACTION_VER,
+		IPE_PROPERTY_DEFAULT_VER,
+		IPE_HEADER_POLICY_NAME_VER,
+		IPE_HEADER_POLICY_VERSION_VER
+	};
+
+	for (i = 0; i < ARRAY_SIZE(built_ins); ++i)
+		alloc += strlen(built_ins[i]) + 1; /* \n */
+
+	(void)ipe_for_each_prop(alloc_size_cb, (void *)&alloc);
+	++alloc; /* null for strcat */
+
+	ret = kzalloc(alloc, GFP_KERNEL);
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < ARRAY_SIZE(built_ins); ++i) {
+		strcat(ret, built_ins[i]);
+		strcat(ret,  "\n");
+	}
+
+	rc = ipe_for_each_prop(build_cfg_str, (void *)ret);
+	if (rc)
+		goto err;
+
+	return ret;
+err:
+	kfree(ret);
+	return ERR_PTR(rc);
+}
+
+/**
+ * ipe_get_prop_cfg: Get (or allocate if one does not exist) the property
+ *		     configuration string for IPE.
+ *
+ * @f: File representing the securityfs entry.
+ * @data: User mode buffer to place the configuration string.
+ * @len: Length of @data.
+ * @offset: Offset into @data.
+ *
+ * As this string can only change on a new kernel build, this string
+ * is cached in the i_private field of @f's inode for subsequent calls.
+ *
+ * Return:
+ * < 0 - Error
+ * > 0 - Success, bytes written to @data
+ */
+static ssize_t ipe_get_prop_cfg(struct file *f, char __user *data, size_t size,
+				loff_t *offset)
+{
+	ssize_t rc = 0;
+	const char *cfg = NULL;
+	struct inode *grammar = d_inode(property_cfg_node);
+
+	inode_lock(grammar);
+
+	/*
+	 * This can only change with a new kernel build,
+	 * so cache the result in i->private
+	 */
+	if (IS_ERR_OR_NULL(grammar->i_private)) {
+		grammar->i_private = create_new_prop_cfg();
+		if (IS_ERR(grammar->i_private)) {
+			rc = PTR_ERR(grammar->i_private);
+			goto out;
+		}
+	}
+	cfg = (const char *)grammar->i_private;
+
+	rc = simple_read_from_buffer(data, size, offset, cfg, strlen(cfg));
+
+out:
+	inode_unlock(grammar);
+	return rc;
+}
+
+static const struct file_operations prop_cfg_ops = {
+	.read = ipe_get_prop_cfg
+};
+
+/**
+ * ipe_free_policy_node: Free an ipe_policy_node structure allocated by
+ *			 ipe_alloc_policy_node.
+ * @n: ipe_policy_node to free
+ */
+static void ipe_free_policy_node(struct ipe_policy_node *n)
+{
+	if (IS_ERR_OR_NULL(n))
+		return;
+
+	ipe_free_policy(n->parsed);
+	kfree(n->data);
+
+	kfree(n);
+}
+
+/**
+ * alloc_callback: Callback given to verify_pkcs7_signature function to set
+ *		   the inner content reference and parse the policy.
+ * @ctx: "ipe_policy_node" to set inner content, size and parsed policy of.
+ * @data: Start of PKCS#7 inner content.
+ * @len: Length of @data.
+ * @asn1hdrlen: Unused.
+ *
+ * Return:
+ * 0 - OK
+ * ERR_PTR(-EBADMSG) - Invalid policy syntax
+ * ERR_PTR(-ENOMEM) - Out of memory
+ */
+static int alloc_callback(void *ctx, const void *data, size_t len,
+			  size_t asn1hdrlen)
+{
+	char *cpy = NULL;
+	struct ipe_policy *pol = NULL;
+	struct ipe_policy_node *n = (struct ipe_policy_node *)ctx;
+
+	n->content = (const u8 *)data;
+	n->content_size = len;
+
+	if (len == 0)
+		return -EBADMSG;
+
+	cpy = kzalloc(len + 1, GFP_KERNEL);
+	if (!cpy)
+		return -ENOMEM;
+
+	(void)memcpy(cpy, data, len);
+
+	pol = ipe_parse_policy(cpy);
+	if (IS_ERR(pol)) {
+		kfree(cpy);
+		return PTR_ERR(pol);
+	}
+
+	n->parsed = pol;
+	kfree(cpy);
+	return 0;
+}
+
+/**
+ * ipe_delete_policy_tree - delete the policy subtree under
+ *			    $securityfs/ipe/policies.
+ * @policy_root: the policy root directory, i.e.
+ *		 $securityfs/ipe/policies/$policy_name
+ *
+ * Return:
+ * 0 - OK
+ * -EPERM - Tree being deleted is the active policy
+ * -ENOENT - A subnode is missing under the tree.
+ * Other - see lookup_one_len_unlocked.
+ */
+static int ipe_delete_policy_tree(struct dentry *policy_root)
+{
+	int rc = 0;
+	struct dentry *raw = NULL;
+	struct dentry *active = NULL;
+	struct dentry *content = NULL;
+	struct dentry *delete = NULL;
+	const struct ipe_policy_node *target = NULL;
+
+	/* ensure the active policy cannot be changed */
+	lockdep_assert_held(&ipe_policy_lock);
+
+	/* fail if it's the active policy */
+	target = (const struct ipe_policy_node *)d_inode(policy_root)->i_private;
+	if (ipe_is_active_policy(target->parsed)) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	raw = retrieve_backed_dentry(IPE_FULL_CONTENT, policy_root,
+				     strlen(IPE_FULL_CONTENT));
+	if (IS_ERR_OR_NULL(raw)) {
+		rc = IS_ERR(raw) ? PTR_ERR(raw) : -ENOENT;
+		goto out;
+	}
+
+	content = retrieve_backed_dentry(IPE_INNER_CONTENT, policy_root,
+					 strlen(IPE_INNER_CONTENT));
+	if (IS_ERR_OR_NULL(content)) {
+		rc = IS_ERR(content) ? PTR_ERR(content) : -ENOENT;
+		goto out_free_raw;
+	}
+
+	active = retrieve_backed_dentry(IPE_ACTIVE_POLICY, policy_root,
+					strlen(IPE_ACTIVE_POLICY));
+	if (IS_ERR_OR_NULL(active)) {
+		rc = IS_ERR(active) ? PTR_ERR(active) : -ENOENT;
+		goto out_free_content;
+	}
+
+	delete = retrieve_backed_dentry(IPE_DELETE_POLICY, policy_root,
+					strlen(IPE_DELETE_POLICY));
+	if (IS_ERR_OR_NULL(active)) {
+		rc = IS_ERR(active) ? PTR_ERR(active) : -ENOENT;
+		goto out_free_active;
+	}
+
+	inode_lock(d_inode(policy_root));
+	ipe_free_policy_node(d_inode(policy_root)->i_private);
+	d_inode(policy_root)->i_private = NULL;
+	inode_unlock(d_inode(policy_root));
+
+	/* drop references from acquired in this function */
+	dput(raw);
+	dput(content);
+	dput(policy_root);
+	dput(active);
+	dput(delete);
+
+	/* drop securityfs' references */
+	securityfs_remove(raw);
+	securityfs_remove(content);
+	securityfs_remove(policy_root);
+	securityfs_remove(active);
+	securityfs_remove(delete);
+
+	return rc;
+
+out_free_active:
+	dput(active);
+out_free_content:
+	dput(content);
+out_free_raw:
+	dput(raw);
+out:
+	return rc;
+}
+
+/**
+ * ipe_delete_policy: Delete a policy, which is stored in this file's parent
+ *		      dentry's inode.
+ * @f: File representing the securityfs entry.
+ * @data: Buffer containing the value 1.
+ * @len: sizeof(u8).
+ * @offset: Offset into @data.
+ *
+ * Return:
+ * > 0 - OK
+ * -ENOMEM - Out of memory
+ * -EINVAL - Incorrect parameter
+ * -EPERM - Policy is active
+ * -ENOENT - A policy subnode does not exist
+ * -EPERM - if a MAC subsystem is enabled, missing CAP_MAC_ADMIN
+ * Other - See retrieve_backed_dentry
+ */
+static ssize_t ipe_delete_policy(struct file *f, const char __user *data,
+				 size_t len, loff_t *offset)
+{
+	int v = 0;
+	ssize_t rc = 0;
+	struct inode *policy_i = NULL;
+	struct dentry *policy_root = NULL;
+
+	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
+		return -EPERM;
+
+	rc = get_int_user(data, len, offset, &v);
+	if (rc)
+		return rc;
+
+	if (v != 1)
+		return -EINVAL;
+
+	policy_root = f->f_path.dentry->d_parent;
+	policy_i = d_inode(policy_root);
+
+	if (!policy_i->i_private)
+		return -ENOENT;
+
+	/* guarantee active policy cannot change */
+	mutex_lock(&ipe_policy_lock);
+
+	rc = ipe_delete_policy_tree(policy_root);
+	if (rc)
+		goto out_unlock;
+
+	mutex_unlock(&ipe_policy_lock);
+	synchronize_rcu();
+
+	return len;
+
+out_unlock:
+	mutex_unlock(&ipe_policy_lock);
+	return rc;
+}
+
+static const struct file_operations policy_delete_ops = {
+	.write = ipe_delete_policy
+};
+
+/**
+ * ipe_alloc_policy_node: Allocate a new ipe_policy_node structure.
+ * @data: Raw enveloped PKCS#7 data that represents the policy.
+ * @len: Length of @data.
+ *
+ * Return:
+ * valid ipe_policy_node - OK
+ * ERR_PTR(-EBADMSG) - Invalid policy syntax
+ * ERR_PTR(-ENOMEM) - Out of memory
+ */
+static struct ipe_policy_node *ipe_alloc_policy_node(const u8 *data,
+						     size_t len)
+{
+	int rc = 0;
+	struct ipe_policy_node *node = NULL;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	node->data_len = len;
+	node->data = kmemdup(data, len, GFP_KERNEL);
+	if (!node->data) {
+		rc = -ENOMEM;
+		goto out2;
+	}
+
+	rc = verify_pkcs7_signature(node->content, node->content_size,
+				    node->data, node->data_len, NULL,
+				    VERIFYING_UNSPECIFIED_SIGNATURE,
+				    alloc_callback, node);
+	if (rc != 0)
+		goto out2;
+
+	return node;
+out2:
+	ipe_free_policy_node(node);
+out:
+	return ERR_PTR(rc);
+}
+
+/**
+ * ipe_secfs_rd_policy: Read the raw content (full enveloped PKCS7) data of
+ *			the policy stored within the file's parent inode.
+ * @f: File representing the securityfs entry.
+ * @data: User mode buffer to place the raw pkcs7.
+ * @len: Length of @data.
+ * @offset: Offset into @data.
+ *
+ * Return:
+ * > 0 - OK
+ * -ENOMEM - Out of memory
+ */
+static ssize_t ipe_secfs_rd_policy(struct file *f, char __user *data,
+				   size_t size, loff_t *offset)
+{
+	ssize_t rc = 0;
+	size_t avail = 0;
+	struct inode *root = NULL;
+	const struct ipe_policy_node *node = NULL;
+
+	root = d_inode(f->f_path.dentry->d_parent);
+
+	inode_lock_shared(root);
+	node = (const struct ipe_policy_node *)root->i_private;
+
+	avail = node->data_len;
+	rc = simple_read_from_buffer(data, size, offset, node->data, avail);
+
+	inode_unlock_shared(root);
+	return rc;
+}
+
+/**
+ * ipe_secfs_ud_policy: Update a policy in place with a new PKCS7 policy.
+ * @f: File representing the securityfs entry.
+ * @data: Buffer user mode to place the raw pkcs7.
+ * @len: Length of @data.
+ * @offset: Offset into @data.
+ *
+ * Return:
+ * 0 - OK
+ * -EBADMSG - Invalid policy format
+ * -ENOMEM - Out of memory
+ * -EPERM - if a MAC subsystem is enabled, missing CAP_MAC_ADMIN
+ * -EINVAL - Incorrect policy name for this node, or version is < current
+ */
+static ssize_t ipe_secfs_ud_policy(struct file *f, const char __user *data,
+				   size_t len, loff_t *offset)
+{
+	ssize_t rc = 0;
+	u8 *cpy = NULL;
+	struct inode *root = NULL;
+	struct crypto_shash *tfm = NULL;
+	struct ipe_policy_node *new = NULL;
+	struct ipe_policy_node *old = NULL;
+
+	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
+		return -EPERM;
+
+	cpy = memdup_user(data, len);
+	if (IS_ERR(cpy))
+		return PTR_ERR(cpy);
+
+	new = ipe_alloc_policy_node(cpy, len);
+	if (IS_ERR(new)) {
+		rc = PTR_ERR(new);
+		goto out_free_cpy;
+	}
+
+	tfm = crypto_alloc_shash("sha1", 0, 0);
+	if (IS_ERR(tfm))
+		goto out_free_cpy;
+
+	root = d_inode(f->f_path.dentry->d_parent);
+	inode_lock(root);
+	mutex_lock(&ipe_policy_lock);
+
+	old = (struct ipe_policy_node *)root->i_private;
+
+	if (strcmp(old->parsed->policy_name, new->parsed->policy_name)) {
+		rc = -EINVAL;
+		goto out_unlock_inode;
+	}
+
+	if (!ipe_is_valid_policy(old->parsed, new->parsed)) {
+		rc = -EINVAL;
+		goto out_unlock_inode;
+	}
+
+	rc = ipe_update_active_policy(old->parsed, new->parsed);
+	if (rc != 0)
+		goto out_unlock_inode;
+
+	ipe_audit_policy_load(new->parsed, new->data, new->data_len, tfm);
+	swap(root->i_private, new);
+
+	mutex_unlock(&ipe_policy_lock);
+	synchronize_rcu();
+
+	inode_unlock(root);
+	kfree(cpy);
+	ipe_free_policy_node(new);
+	crypto_free_shash(tfm);
+
+	return len;
+
+out_unlock_inode:
+	mutex_unlock(&ipe_policy_lock);
+	inode_unlock(root);
+	ipe_free_policy_node(new);
+	crypto_free_shash(tfm);
+out_free_cpy:
+	kfree(cpy);
+	return rc;
+}
+
+static const struct file_operations policy_raw_ops = {
+	.read = ipe_secfs_rd_policy,
+	.write = ipe_secfs_ud_policy
+};
+
+/**
+ * ipe_secfs_rd_content: Read the inner content of the enveloped PKCS7 data,
+ *			 representing the IPE policy.
+ * @f: File representing the securityfs entry.
+ * @data: User mode buffer to place the inner content of the pkcs7 data.
+ * @len: Length of @data.
+ * @offset: Offset into @data.
+ *
+ * Return:
+ * > 0 - OK
+ * -ENOMEM - Out of memory
+ */
+static ssize_t ipe_secfs_rd_content(struct file *f, char __user *data,
+				    size_t size, loff_t *offset)
+{
+	ssize_t rc = 0;
+	size_t avail = 0;
+	struct inode *root = NULL;
+	const struct ipe_policy_node *node = NULL;
+
+	root = d_inode(f->f_path.dentry->d_parent);
+
+	inode_lock_shared(root);
+	node = (const struct ipe_policy_node *)root->i_private;
+
+	avail = node->content_size;
+	rc = simple_read_from_buffer(data, size, offset, node->content, avail);
+
+	inode_unlock_shared(root);
+	return rc;
+}
+
+static const struct file_operations policy_content_ops = {
+	.read = ipe_secfs_rd_content
+};
+
+/**
+ * ipe_get_active - return a string representation of whether a policy
+ *		    is active.
+ * @f: File struct representing the securityfs node. Unused.
+ * @data: buffer to place the result.
+ * @len: length of @data.
+ * @offset: offset into @data.
+ *
+ * This is the 'read' syscall handler for
+ * $securityfs/ipe/policies/$policy_name/active
+ *
+ * Return:
+ * > 0 - OK
+ * < 0 - see simple_read_from_buffer.
+ */
+static ssize_t ipe_get_active(struct file *f, char __user *data, size_t len,
+			      loff_t *offset)
+{
+	ssize_t rc = 0;
+	char tmp[3] = { 0 };
+	struct inode *root = NULL;
+	const struct ipe_policy_node *node = NULL;
+
+	root = d_inode(f->f_path.dentry->d_parent);
+	inode_lock_shared(root);
+
+	node = (const struct ipe_policy_node *)root->i_private;
+
+	snprintf(tmp, ARRAY_SIZE(tmp), "%c\n",
+		 ipe_is_active_policy(node->parsed) ? '1' : '0');
+
+	rc = simple_read_from_buffer(data, len, offset, tmp,
+				     ARRAY_SIZE(tmp));
+
+	inode_unlock_shared(root);
+
+	return rc;
+}
+
+/**
+ * ipe_set_active - mark a policy as active, causing IPE to start enforcing
+ *		    this policy.
+ * @f: File struct representing the securityfs node.
+ * @data: buffer containing data written to the securityfs node..
+ * @len: length of @data.
+ * @offset: offset into @data.
+ *
+ * This is the 'write' syscall handler for
+ * $securityfs/ipe/policies/$policy_name/active
+ *
+ * Return:
+ * > 0 - OK
+ * -EINVAL - Value written is not "1".
+ * -EPERM - if MAC system is enabled, missing CAP_MAC_ADMIN.
+ * Other - see ipe_activate_policy, get_int_user
+ */
+static ssize_t ipe_set_active(struct file *f, const char __user *data, size_t len,
+			      loff_t *offset)
+{
+	int v = 0;
+	ssize_t rc = 0;
+	struct inode *root = NULL;
+	const struct ipe_policy_node *node = NULL;
+
+	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
+		return -EPERM;
+
+	rc = get_int_user(data, len, offset, &v);
+	if (rc)
+		return rc;
+
+	if (v != 1)
+		return -EINVAL;
+
+	root = d_inode(f->f_path.dentry->d_parent);
+	mutex_lock(&ipe_policy_lock);
+	inode_lock_shared(root);
+
+	node = (const struct ipe_policy_node *)root->i_private;
+	rc = ipe_activate_policy(node->parsed);
+
+	inode_unlock_shared(root);
+	mutex_unlock(&ipe_policy_lock);
+	synchronize_rcu();
+
+	return len;
+}
+
+static const struct file_operations policy_active_ops = {
+	.read = ipe_get_active,
+	.write = ipe_set_active
+};
+
+/**
+ * ipe_alloc_policy_tree - allocate the proper subnodes for a policy under
+ *			   securityfs.
+ * @parent: The parent directory that these securityfs files should be created
+ *	    under.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - See securityfs_create_file
+ */
+static int ipe_alloc_policy_tree(struct dentry *parent)
+{
+	int rc = 0;
+	struct dentry *raw = NULL;
+	struct dentry *delete = NULL;
+	struct dentry *active = NULL;
+	struct dentry *content = NULL;
+
+	raw = securityfs_create_file(IPE_FULL_CONTENT, 0644, parent, NULL,
+				     &policy_raw_ops);
+	if (IS_ERR(raw))
+		return PTR_ERR(raw);
+
+	content = securityfs_create_file(IPE_INNER_CONTENT, 0444, parent,
+					 NULL, &policy_content_ops);
+	if (IS_ERR(raw)) {
+		rc = PTR_ERR(raw);
+		goto free_raw;
+	}
+
+	active = securityfs_create_file(IPE_ACTIVE_POLICY, 0644, parent, NULL,
+					&policy_active_ops);
+	if (IS_ERR(active)) {
+		rc = PTR_ERR(active);
+		goto free_content;
+	}
+
+	delete = securityfs_create_file(IPE_DELETE_POLICY, 0644, parent, NULL,
+					&policy_delete_ops);
+	if (IS_ERR(delete)) {
+		rc = PTR_ERR(delete);
+		goto free_active;
+	}
+
+	return rc;
+
+free_active:
+	securityfs_remove(active);
+free_content:
+	securityfs_remove(content);
+free_raw:
+	securityfs_remove(raw);
+
+	return rc;
+}
+
+/**
+ * ipe_build_policy_secfs_node: Build a new securityfs node for IPE policies.
+ * @data: Raw enveloped PKCS#7 data that represents the policy.
+ * @len: Length of @data.
+ *
+ * Return:
+ * 0 - OK
+ * -EEXIST - Policy already exists
+ * -EBADMSG - Invalid policy syntax
+ * -ENOMEM - Out of memory
+ */
+int ipe_build_policy_secfs_node(const u8 *data, size_t len)
+{
+	int rc = 0;
+	struct dentry *root = NULL;
+	struct inode *root_i = NULL;
+	struct crypto_shash *tfm = NULL;
+	struct ipe_policy_node *node = NULL;
+
+	tfm = crypto_alloc_shash("sha1", 0, 0);
+	if (IS_ERR(tfm)) {
+		rc = PTR_ERR(tfm);
+		goto out;
+	}
+
+	node = ipe_alloc_policy_node(data, len);
+	if (IS_ERR(node)) {
+		rc = PTR_ERR(node);
+		goto free_hash;
+	}
+
+	root = securityfs_create_dir(node->parsed->policy_name,
+				     policies_root);
+	if (IS_ERR(root)) {
+		rc = PTR_ERR(root);
+		goto free_private;
+	}
+
+	root_i = d_inode(root);
+
+	inode_lock(root_i);
+	root_i->i_private = node;
+	ipe_audit_policy_load(node->parsed, node->data, node->data_len, tfm);
+	inode_unlock(root_i);
+
+	rc = ipe_alloc_policy_tree(root);
+	if (rc)
+		goto free_secfs;
+
+	crypto_free_shash(tfm);
+	return rc;
+
+free_secfs:
+	securityfs_remove(root);
+free_private:
+	ipe_free_policy_node(node);
+free_hash:
+	crypto_free_shash(tfm);
+out:
+	return rc;
+}
+
+/**
+ * ipe_new_policy: Entry point of the securityfs node, "ipe/new_policy".
+ * @f: File representing the securityfs entry.
+ * @data: Raw enveloped PKCS#7 data that represents the policy.
+ * @len: Length of @data.
+ * @offset: Offset for @data.
+ *
+ * Return:
+ * > 0 - OK
+ * -EEXIST - Policy already exists
+ * -EBADMSG - Invalid policy syntax
+ * -ENOMEM - Out of memory
+ * -EPERM - if a MAC subsystem is enabled, missing CAP_MAC_ADMIN
+ */
+static ssize_t ipe_new_policy(struct file *f, const char __user *data,
+			      size_t len, loff_t *offset)
+{
+	ssize_t rc = 0;
+	u8 *cpy = NULL;
+
+	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
+		return -EPERM;
+
+	cpy = memdup_user(data, len);
+	if (IS_ERR(cpy))
+		return PTR_ERR(cpy);
+
+	rc = ipe_build_policy_secfs_node(cpy, len);
+
+	kfree(cpy);
+	return rc < 0 ? rc : len;
+}
+
+static const struct file_operations new_policy_ops = {
+	.write = ipe_new_policy
+};
+
+/**
+ * ipe_build_secfs_root: Build the root of securityfs for IPE.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - See securityfs_create_dir and securityfs_create_file
+ */
+int __init ipe_build_secfs_root(void)
+{
+	int rc = 0;
+	struct dentry *new = NULL;
+	struct dentry *cfg = NULL;
+	struct dentry *root = NULL;
+	struct dentry *audit = NULL;
+	struct dentry *enforce = NULL;
+	struct dentry *policies = NULL;
+
+	root = securityfs_create_dir(IPE_ROOT, NULL);
+	if (IS_ERR(root)) {
+		rc = PTR_ERR(root);
+		goto out;
+	}
+
+	new = securityfs_create_file(NEW_POLICY, 0644, root, NULL,
+				     &new_policy_ops);
+	if (IS_ERR(new)) {
+		rc = PTR_ERR(new);
+		goto out_free_root;
+	}
+
+	policies = securityfs_create_dir(IPE_POLICIES, root);
+	if (IS_ERR(policies)) {
+		rc = PTR_ERR(policies);
+		goto out_free_new;
+	}
+
+	cfg = securityfs_create_file(IPE_PROPERTY_CFG, 0444, root, NULL,
+				     &prop_cfg_ops);
+	if (IS_ERR(cfg)) {
+		rc = PTR_ERR(cfg);
+		goto out_free_policies;
+	}
+
+	audit = securityfs_create_file(IPE_SUCCESS_AUDIT, 0644, root, NULL,
+				       &audit_ops);
+	if (IS_ERR(cfg)) {
+		rc = PTR_ERR(audit);
+		goto out_free_cfg;
+	}
+
+	enforce = ipe_init_enforce_node(root);
+	if (IS_ERR(enforce)) {
+		rc = PTR_ERR(audit);
+		goto out_free_audit;
+	}
+
+	securityfs_root = root;
+	new_policy_node = new;
+	policies_root = policies;
+	property_cfg_node = cfg;
+	success_audit_node = audit;
+	enforce_node = enforce;
+
+	return rc;
+
+out_free_audit:
+	securityfs_remove(audit);
+out_free_cfg:
+	securityfs_remove(cfg);
+out_free_policies:
+	securityfs_remove(policies);
+out_free_new:
+	securityfs_remove(new);
+out_free_root:
+	securityfs_remove(root);
+out:
+	return rc;
+}
+
+/**
+ * ipe_build_secfs_boot_node: Build a policy node for IPE's boot policy.
+ *
+ * This differs from the normal policy nodes, as the IPE boot policy is
+ * read only.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - See securityfs_create_dir and securityfs_create_file
+ */
+static int __init ipe_build_secfs_boot_node(void)
+{
+	int rc = 0;
+	char *cpy = NULL;
+	struct inode *root_i = NULL;
+	struct dentry *root = NULL;
+	struct dentry *active = NULL;
+	struct dentry *content = NULL;
+	struct ipe_policy *parsed = NULL;
+	struct ipe_policy_node *node = NULL;
+
+	if (!ipe_boot_policy)
+		return 0;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	cpy = kstrdup(ipe_boot_policy, GFP_KERNEL);
+	if (!cpy) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	parsed = ipe_parse_policy(cpy);
+	if (IS_ERR(parsed)) {
+		rc = PTR_ERR(parsed);
+		goto out_free_policy;
+	}
+
+	node->content = ipe_boot_policy;
+	node->content_size = strlen(ipe_boot_policy);
+	node->parsed = parsed;
+
+	root = securityfs_create_dir(node->parsed->policy_name,
+				     policies_root);
+	if (IS_ERR(root)) {
+		rc = PTR_ERR(root);
+		goto out_free_policy;
+	}
+
+	content = securityfs_create_file(IPE_INNER_CONTENT, 0444, root, NULL,
+					 &policy_content_ops);
+	if (IS_ERR(content)) {
+		rc = PTR_ERR(content);
+		goto out_free_root;
+	}
+
+	active = securityfs_create_file(IPE_ACTIVE_POLICY, 0644, root, NULL,
+					&policy_active_ops);
+	if (IS_ERR(active)) {
+		rc = PTR_ERR(active);
+		goto out_free_content;
+	}
+
+	root_i = d_inode(root);
+
+	inode_lock(root_i);
+	root_i->i_private = node;
+	inode_unlock(root_i);
+
+	boot_policy_node = root;
+	mutex_lock(&ipe_policy_lock);
+	rc = ipe_activate_policy(node->parsed);
+	mutex_unlock(&ipe_policy_lock);
+	synchronize_rcu();
+
+	return rc;
+
+out_free_content:
+	securityfs_remove(active);
+out_free_root:
+	securityfs_remove(root);
+out_free_policy:
+	ipe_free_policy(parsed);
+out:
+	kfree(cpy);
+	kfree(node);
+	return rc;
+}
+
+/**
+ * ipe_securityfs_init: Initialize IPE's securityfs entries.
+ *
+ * This is called after the lsm initialization.
+ *
+ * Return:
+ * 0 - OK
+ * !0 - Error
+ */
+int __init ipe_securityfs_init(void)
+{
+	int rc = 0;
+
+	rc = ipe_build_secfs_root();
+	if (rc != 0)
+		goto err;
+
+	rc = ipe_build_secfs_boot_node();
+	if (rc != 0)
+		panic("IPE failed to initialize the boot policy: %d", rc);
+
+	return rc;
+err:
+	pr_err("failed to initialize secfs: %d", -rc);
+	return rc;
+}
+
+core_initcall(ipe_securityfs_init);
diff --git a/security/ipe/ipe-secfs.h b/security/ipe/ipe-secfs.h
new file mode 100644
index 000000000000..147f7801b5e6
--- /dev/null
+++ b/security/ipe/ipe-secfs.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+#include <linux/types.h>
+
+#include "ipe-policy.h"
+
+#ifndef IPE_SECFS_H
+#define IPE_SECFS_H
+
+extern struct mutex ipe_policy_lock;
+
+int ipe_set_active_policy(const char *id, size_t id_len);
+
+#endif /* IPE_SECFS_H */
-- 
2.27.0

