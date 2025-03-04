Return-Path: <linux-fsdevel+bounces-43018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175ABA4D09D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B8E16F2E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62BE41AAC;
	Tue,  4 Mar 2025 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hvPWAg2E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1ENKiGvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C66522A;
	Tue,  4 Mar 2025 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051079; cv=none; b=MMnxPXpMxqTliY9rsCSEkEUoSilyMLQuy3+ABchnVPGDxyVHknEaP0063C0D7K/F2pOLZbuOPtLeHeuhFtdAlTVMbWuEVVfwOb9NGrEZog7JqZgtBuBihRBF7l5skoV0HeYd9Eo0bg+W7r5XtcTxus/1pHMg2hQScJYOLVSqj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051079; c=relaxed/simple;
	bh=Lr+waHw4jFVtcAE2pAZcNuRcSpdzE010dYUZh3GrhY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWi/wXs5Dsz+yXHFpNgeCCYNShAGnSRhCH0PU6NKQB8AVTZhDzPzIzhqNkBwDGd4W1kETFi4DE2WFLNY7Oc9Tt/4WAYzzKonFKaEASGP7sXxuBv7ridUYlTSIlyDpcszljaFUlGuYq/E98v9oa8HNchzd0o0s4G5p0l2/kbIOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hvPWAg2E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1ENKiGvD; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 61F611D4157C;
	Mon,  3 Mar 2025 20:17:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 03 Mar 2025 20:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741051075; x=
	1741054675; bh=COU+tXy4ri0RR8vWI/vuxbIIyUcrjBzStMi1pCBq06Q=; b=h
	vPWAg2EhUev+yRHcOtnx6b4yrCkripkmN413JHF/hbC9Kb6tPxKSgKv2fLrko6Sm
	Iyi9wifdnFuJpr7xjSAzODfwNsn28gLuKPQ8jcNSyfXLsHlWlrlDF+ysViwghc7x
	MgkbcsJrD3JGHWebik5JdNg/QvCI6e+2m0ba0bQzeK8+5yvqduomBUUFFvSNWUmj
	8Baag8QMr35wc/HKOZk16Rnchox/i7hFQe9HoKBfUrrI1PgCJ5jpOIm9ICcG6pDF
	1pbxOapq7DjFLdsff1evk6IsHaJ7SlFrj50+AZM2GO7fOWGm2O/sYtYpBarKMfV0
	Ck4467p8Yg2mwAmE90pNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741051075; x=1741054675; bh=C
	OU+tXy4ri0RR8vWI/vuxbIIyUcrjBzStMi1pCBq06Q=; b=1ENKiGvD9DOMwvK4e
	1xcfe1WgkIwas/t66E3+20uBXWjrGtsMw0nSC7cX8xvwo1+Mnr1IzgPjssIszGfU
	dIHN+Ctr3ENFeFXnCpEocHpy4MgfU3CGuhdjc2g0OdW0hvQBKlZMTPauJxEZ68CC
	BN3hppUa916ppafuPvaStYAQX98ieBYG/xVtHKA+3EbwLoRJp+aPnn7lBkwEusbr
	fJ3bY8bWO4eaxL59VD4ho+7UdxFYugf6GJryRHBtlLQioNypRAyLZJ27LYOctI2q
	kjOGLGIUxLmKWUCt3V6BadYOlzJ9Yn4vQSOxRzL+EaXWznyhhLoWiI5trYsT/PF6
	L9J+w==
X-ME-Sender: <xms:wlTGZ3ghlyl7t-hqrOzjAYKa6xUrvsTySewRKtmat6f7t6tmyvz6iQ>
    <xme:wlTGZ0AsAbATw7E8G9TpCZprbCGh6RLO7lVB-lgzEKjN5P9voQU9lsQ2cF90w-NEV
    EJ3CQnFzeP3dwWoAW4>
X-ME-Received: <xmr:wlTGZ3GvoUCEmppQK2aOUKpZ86211g1H4gQ2KD2elRgCJyf4cm2QHq6UyhOY-td1s-FT-PuPdA_E69nxJo5z6bPImjmo1VM2TqIKhxCtpqyHmErPnWb7Hro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeiteekudejheegkeekgfehueekuddtgfdtgedukeeufeev
    veffudfgffevvefghfenucffohhmrghinheplhgrhigvrhgplhgvvhgvlhdrnhgvthdprg
    gttggvshhspghmrghskhhsrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhope
    elpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhn
    vghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hjrggtkhesshhushgvrdgtiidprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprhgvphhnohhpsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthih
    tghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:wlTGZ0Slhsf-6luybuUVrqRlFS4ID9FJ0o54Ims5h_raTG_z3uJRRQ>
    <xmx:wlTGZ0w6w3th98FUagk-xWdDEUK_tMG4fp5Rb_M-FRh45f9ztnVWww>
    <xmx:wlTGZ662dj_TaAZoq9LM-SgazH3wwhPg4lSXr3dWNdYxj9NksEJ2jg>
    <xmx:wlTGZ5ytsWxKMxH25TLzoWnuiHV1CYhfjJ534mfZ77CcPtbVmODUHQ>
    <xmx:w1TGZ7nUb5N_inTdHdF3oyCsD9U-XxsfwuKTHMRnkETdibkGA1Ayj1uU>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 20:17:53 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC PATCH 2/9] Refactor per-layer information in rulesets and rules
Date: Tue,  4 Mar 2025 01:12:58 +0000
Message-ID: <6e8887f204c9fbe7470e61876bc597932a8f74d9.1741047969.git.m@maowtm.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741047969.git.m@maowtm.org>
References: <cover.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need a place to store the supervisor pointer for each layer in
a domain.  Currently, the domain has a trailing flexible array
for handled access masks of each layer.  This patch extends it by
creating a separate landlock_ruleset_layer structure that will
hold this access mask, and make the ruleset's flexible array use
this structure instead.

An alternative is to use landlock_hierarchy, but I have chosen to
extend the FAM as this is makes it more clear the supervisor
pointer is tied to layers, just like access masks.

This patch doesn't make any functional changes nor add any
supervise specific stuff.  It is purely to pave the way for
future patches.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/ruleset.c  | 29 +++++++++---------
 security/landlock/ruleset.h  | 59 ++++++++++++++++++++++--------------
 security/landlock/syscalls.c |  2 +-
 3 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 69742467a0cf..2cc6f7c5eb1b 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -31,9 +31,8 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 {
 	struct landlock_ruleset *new_ruleset;
 
-	new_ruleset =
-		kzalloc(struct_size(new_ruleset, access_masks, num_layers),
-			GFP_KERNEL_ACCOUNT);
+	new_ruleset = kzalloc(struct_size(new_ruleset, layer_stack, num_layers),
+			      GFP_KERNEL_ACCOUNT);
 	if (!new_ruleset)
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&new_ruleset->usage, 1);
@@ -104,8 +103,9 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
 
 static struct landlock_rule *
 create_rule(const struct landlock_id id,
-	    const struct landlock_layer (*const layers)[], const u32 num_layers,
-	    const struct landlock_layer *const new_layer)
+	    const struct landlock_rule_layer (*const layers)[],
+	    const u32 num_layers,
+	    const struct landlock_rule_layer *const new_layer)
 {
 	struct landlock_rule *new_rule;
 	u32 new_num_layers;
@@ -201,7 +201,7 @@ static void build_check_ruleset(void)
  */
 static int insert_rule(struct landlock_ruleset *const ruleset,
 		       const struct landlock_id id,
-		       const struct landlock_layer (*const layers)[],
+		       const struct landlock_rule_layer (*const layers)[],
 		       const size_t num_layers)
 {
 	struct rb_node **walker_node;
@@ -284,7 +284,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 
 static void build_check_layer(void)
 {
-	const struct landlock_layer layer = {
+	const struct landlock_rule_layer layer = {
 		.level = ~0,
 		.access = ~0,
 	};
@@ -299,7 +299,7 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
 			 const access_mask_t access)
 {
-	struct landlock_layer layers[] = { {
+	struct landlock_rule_layer layers[] = { {
 		.access = access,
 		/* When @level is zero, insert_rule() extends @ruleset. */
 		.level = 0,
@@ -344,7 +344,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
 	/* Merges the @src tree. */
 	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule, src_root,
 					     node) {
-		struct landlock_layer layers[] = { {
+		struct landlock_rule_layer layers[] = { {
 			.level = dst->num_layers,
 		} };
 		const struct landlock_id id = {
@@ -389,8 +389,9 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	dst->access_masks[dst->num_layers - 1] =
-		landlock_upgrade_handled_access_masks(src->access_masks[0]);
+	dst->layer_stack[dst->num_layers - 1].access_masks =
+		landlock_upgrade_handled_access_masks(
+			src->layer_stack[0].access_masks);
 
 	/* Merges the @src inode tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
@@ -472,8 +473,8 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 		goto out_unlock;
 	}
 	/* Copies the parent layer stack and leaves a space for the new layer. */
-	memcpy(child->access_masks, parent->access_masks,
-	       flex_array_size(parent, access_masks, parent->num_layers));
+	memcpy(child->layer_stack, parent->layer_stack,
+	       flex_array_size(parent, layer_stack, parent->num_layers));
 
 	if (WARN_ON_ONCE(!parent->hierarchy)) {
 		err = -EINVAL;
@@ -644,7 +645,7 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
 	 */
 	for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
-		const struct landlock_layer *const layer =
+		const struct landlock_rule_layer *const layer =
 			&rule->layers[layer_level];
 		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
 		const unsigned long access_req = access_request;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 52f4f0af6ab0..a2605959f733 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -21,9 +21,10 @@
 #include "object.h"
 
 /**
- * struct landlock_layer - Access rights for a given layer
+ * struct landlock_rule_layer - Stores the access rights for a
+ * given layer in a rule.
  */
-struct landlock_layer {
+struct landlock_rule_layer {
 	/**
 	 * @level: Position of this layer in the layer stack.
 	 */
@@ -102,10 +103,11 @@ struct landlock_rule {
 	 */
 	u32 num_layers;
 	/**
-	 * @layers: Stack of layers, from the latest to the newest, implemented
-	 * as a flexible array member (FAM).
+	 * @layers: Stack of layers, from the latest to the newest,
+	 * implemented as a flexible array member (FAM). Only
+	 * contains layers that has a rule for this object.
 	 */
-	struct landlock_layer layers[] __counted_by(num_layers);
+	struct landlock_rule_layer layers[] __counted_by(num_layers);
 };
 
 /**
@@ -124,6 +126,18 @@ struct landlock_hierarchy {
 	refcount_t usage;
 };
 
+/**
+ * struct landlock_ruleset_layer - Store per-layer information
+ * within a domain (or a non-merged ruleset)
+ */
+struct landlock_ruleset_layer {
+	/**
+	 * @access_masks: Contains the subset of filesystem and
+	 * network actions that are restricted by a layer.
+	 */
+	struct access_masks access_masks;
+};
+
 /**
  * struct landlock_ruleset - Landlock ruleset
  *
@@ -187,18 +201,17 @@ struct landlock_ruleset {
 			 */
 			u32 num_layers;
 			/**
-			 * @access_masks: Contains the subset of filesystem and
-			 * network actions that are restricted by a ruleset.
-			 * A domain saves all layers of merged rulesets in a
-			 * stack (FAM), starting from the first layer to the
-			 * last one.  These layers are used when merging
-			 * rulesets, for user space backward compatibility
-			 * (i.e. future-proof), and to properly handle merged
-			 * rulesets without overlapping access rights.  These
-			 * layers are set once and never changed for the
-			 * lifetime of the ruleset.
+			 * @layer_stack: A domain saves all layers of merged
+			 * rulesets in a stack (FAM), starting from the first
+			 * layer to the last one.  These layers are used when
+			 * merging rulesets, for user space backward
+			 * compatibility (i.e. future-proof), and to properly
+			 * handle merged rulesets without overlapping access
+			 * rights.  These layers are set once and never
+			 * changed for the lifetime of the ruleset.
 			 */
-			struct access_masks access_masks[];
+			struct landlock_ruleset_layer
+				layer_stack[] __counted_by(num_layers);
 		};
 	};
 };
@@ -248,7 +261,7 @@ landlock_union_access_masks(const struct landlock_ruleset *const domain)
 
 	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
 		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
+			.masks = domain->layer_stack[layer_level].access_masks,
 		};
 
 		matches.all |= layer.all;
@@ -296,7 +309,7 @@ landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(fs_access_mask != fs_mask);
-	ruleset->access_masks[layer_level].fs |= fs_mask;
+	ruleset->layer_stack[layer_level].access_masks.fs |= fs_mask;
 }
 
 static inline void
@@ -308,7 +321,7 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
 
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(net_access_mask != net_mask);
-	ruleset->access_masks[layer_level].net |= net_mask;
+	ruleset->layer_stack[layer_level].access_masks.net |= net_mask;
 }
 
 static inline void
@@ -319,7 +332,7 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
 
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(scope_mask != mask);
-	ruleset->access_masks[layer_level].scope |= mask;
+	ruleset->layer_stack[layer_level].access_masks.scope |= mask;
 }
 
 static inline access_mask_t
@@ -327,7 +340,7 @@ landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
 			    const u16 layer_level)
 {
 	/* Handles all initially denied by default access rights. */
-	return ruleset->access_masks[layer_level].fs |
+	return ruleset->layer_stack[layer_level].access_masks.fs |
 	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
@@ -335,14 +348,14 @@ static inline access_mask_t
 landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
 			     const u16 layer_level)
 {
-	return ruleset->access_masks[layer_level].net;
+	return ruleset->layer_stack[layer_level].access_masks.net;
 }
 
 static inline access_mask_t
 landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 			const u16 layer_level)
 {
-	return ruleset->access_masks[layer_level].scope;
+	return ruleset->layer_stack[layer_level].access_masks.scope;
 }
 
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index a9760d252fc2..ead9b68168ad 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -313,7 +313,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = ruleset->access_masks[0].fs;
+	mask = landlock_get_fs_access_mask(ruleset, 0);
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
-- 
2.39.5


