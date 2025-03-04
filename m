Return-Path: <linux-fsdevel+bounces-43019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758DFA4D09F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBCB3AA44E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F041AAC;
	Tue,  4 Mar 2025 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hlqbxyIW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w9qZSNFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF533D8;
	Tue,  4 Mar 2025 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051124; cv=none; b=qYbu/rhUO4KiHGCTJg2uAbeKT4UcFIR191NORoHHwCpl9frtdzxHLQvBoQnkgfJVy2y9wINJBpumWvKrf6PfxwmSkNmpdRIzXmOyjcShzivbp8ZSPI6esFnydHgP49KA/oK03nHz3OWfVQtrlzMX3pAEAqRoukt7TqpZ3C9AS7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051124; c=relaxed/simple;
	bh=dSH9kUOUWHaJDnK5KJYcUvCKQpT16cRy0YmC870m9I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwvdyiSoBYj2opgVsrvUTFKVHBMIDsYrsl0t/CxJfdeuWwSpR+oCMJvcoyGb6hHovI+Wcom3Rc6AY7+o+nZBL3YlumSfO6BFskPi0Hb7WA4osMmu5sXLKw5skFkriUP2I9HBlf+DiB4Jny2oq2gCC0aoFSVII68zyvW7LeLOwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hlqbxyIW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w9qZSNFN; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id A1D851D415B6;
	Mon,  3 Mar 2025 20:18:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 20:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741051120; x=
	1741054720; bh=WgrkeV/hKLUg1ORoyHWD4+MCv5x+yzOiUtNRUl1NE8E=; b=h
	lqbxyIW35l0xK+lI/A3cEX2k946K3/grHC2EEUzyKi16ia32TFBbPpqOMMbJg5H6
	gNrjZ5FLrYhWpB6fGG6Q9MIs5u01pBOsWtpq840Cuo4BFzycIR5F3zSdyZCBj/rK
	cgh4XdWX58BgWZdE+qhbXjDvhcIiDJH0vcEUVsAmW8a9TVvunO2YWhrb8XDcp6db
	Bz838WSItHCJgVNoyqtpljR8AoBXlh0SB8OMWwouK5GkBjUHPnBSUTpqFUwY9L26
	Z1iT5322eSdg6i4dPvGX/pH+wYQur2WVAJLtG9Z2IzsFKGBGzIP6Byi/z701SzLe
	qOH9DQbT7MhrxeNNq/nag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741051120; x=1741054720; bh=W
	grkeV/hKLUg1ORoyHWD4+MCv5x+yzOiUtNRUl1NE8E=; b=w9qZSNFN2aUVybO86
	jhmHDZzInGb7OI3A5wnfyyDHXmp0u1OO9jxDidjCiFiNuizn11PZlDIzVSFXPLP7
	caW1GVng3+sFZ2x1zurZAxsmxzfytydFitE8aFt8PvM5MGxbQNUzg/G89iQyMKOR
	LDSghUrU91LrV5q0A15JGqy2wkF34cOkbBYwRJlQY/8A5fzpBNBuhfC7Q+yVlJYF
	NuvK8R0Cv8YVucIMuff3eiINKX+e6p0/gFbOoGSsgGlpcpa4JWCWOx6rjQvlEqO1
	INnpg5ZpTRF5Tpz3uA28OmlVTDoME0JR6mxvBitkl6jw9W/K1W5FIUNG2FnK3xyj
	JBovQ==
X-ME-Sender: <xms:71TGZ6tGmCY57tStkIXj46-iAm9owrfnTVEPYE5xIV3ruYkAKHu8eQ>
    <xme:71TGZ_fU7fXXRAcjeykJ7H_l7eWbfaWnmfDIoJSlNy976hrdtxc_Nk3TmZokY6b1O
    n5kctDgOra3qFmrPjY>
X-ME-Received: <xmr:71TGZ1zvreCts1knaaHsqshlgFrJk_zUc3xQ2SnYjaEPB71ZOvq6rN2phu1Gh-x24eH9mxoGGmnz-kCQXMyug_EEk5mYf26eHdDeJAneawg8OJAIQJH8h3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtph
    htthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehs
    uhhsvgdrtgiipdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhope
    hrvghpnhhophesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthigthhhosehthi
    gthhhordhpihiiiigr
X-ME-Proxy: <xmx:71TGZ1P-zqRUeUNlckULdr0wj-DKi7fFv29D2IPOl9q4IKTwrv7OQA>
    <xmx:8FTGZ6-faM_HKFwDSSzaxNThlhg3GjASLLmV0rxG3kpwmmTujNi2rg>
    <xmx:8FTGZ9XTPceDxScLahQtdm2eJIgA-FcO8roTh-kZT8TfbJByd2KpuQ>
    <xmx:8FTGZzchntKLgKz5fGWUOCTEJ94TijmvKIgIuHttYmjHjkzLCCBlkg>
    <xmx:8FTGZ6ysIM4b5DjAuD1A0hWaDKfgRbfsIuM7y5Sr_HVMyAElN6EjQG6R>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 20:18:38 -0500 (EST)
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
Subject: [RFC PATCH 3/9] Adds a supervisor reference in the per-layer information
Date: Tue,  4 Mar 2025 01:12:59 +0000
Message-ID: <2b212f28b30675836e75d0ac70868fe48c0773e0.1741047969.git.m@maowtm.org>
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

Following from the previous patch, we now use the new per-layer struct to
store a reference to any supervisor attached to a layer (merged in a
domain or unmerged).

The supervisor is refcounted, and so we need to correctly get/put it when
inheriting a domain or when merging a layer.  This means looping through
all the layers and getting each supervisor that exists, as the domain
effectively stores a copy of all the inherited layers.

TODO: because we are now referencing the supervisor in the layer, the
event deny and cleanup code in landlock_put_supervisor won't work as
intended.  I didn't realize this until after finishing this set of
patches, so this will be addressed in a future series.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/ruleset.c   | 26 +++++++++++++++++++++++---
 security/landlock/ruleset.h   |  7 +++++++
 security/landlock/supervise.h |  6 ++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 2cc6f7c5eb1b..2e93b8105cc9 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -26,6 +26,7 @@
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
+#include "supervise.h"
 
 static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 {
@@ -389,9 +390,14 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	dst->layer_stack[dst->num_layers - 1].access_masks =
-		landlock_upgrade_handled_access_masks(
-			src->layer_stack[0].access_masks);
+	dst->layer_stack[dst->num_layers - 1] = (struct landlock_ruleset_layer){
+		.access_masks = landlock_upgrade_handled_access_masks(
+			src->layer_stack[0].access_masks),
+		.supervisor = src->layer_stack[0].supervisor,
+	};
+	if (dst->layer_stack[dst->num_layers - 1].supervisor)
+		landlock_get_supervisor(
+			dst->layer_stack[dst->num_layers - 1].supervisor);
 
 	/* Merges the @src inode tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
@@ -447,6 +453,7 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 			   struct landlock_ruleset *const child)
 {
 	int err = 0;
+	int layer;
 
 	might_sleep();
 	if (!parent)
@@ -475,6 +482,12 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 	/* Copies the parent layer stack and leaves a space for the new layer. */
 	memcpy(child->layer_stack, parent->layer_stack,
 	       flex_array_size(parent, layer_stack, parent->num_layers));
+	/* Get the refcount of any supervisor copied over */
+	for (layer = 0; layer < child->num_layers; layer++) {
+		if (child->layer_stack[layer].supervisor)
+			landlock_get_supervisor(
+				child->layer_stack[layer].supervisor);
+	}
 
 	if (WARN_ON_ONCE(!parent->hierarchy)) {
 		err = -EINVAL;
@@ -492,6 +505,7 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 static void free_ruleset(struct landlock_ruleset *const ruleset)
 {
 	struct landlock_rule *freeme, *next;
+	int layer;
 
 	might_sleep();
 	rbtree_postorder_for_each_entry_safe(freeme, next, &ruleset->root_inode,
@@ -505,6 +519,12 @@ static void free_ruleset(struct landlock_ruleset *const ruleset)
 #endif /* IS_ENABLED(CONFIG_INET) */
 
 	put_hierarchy(ruleset->hierarchy);
+	for (layer = 0; layer < ruleset->num_layers; layer++) {
+		struct landlock_supervisor *const supervisor =
+			ruleset->layer_stack[layer].supervisor;
+		if (supervisor)
+			landlock_put_supervisor(supervisor);
+	}
 	kfree(ruleset);
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index a2605959f733..ed530643ea68 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -136,6 +136,13 @@ struct landlock_ruleset_layer {
 	 * network actions that are restricted by a layer.
 	 */
 	struct access_masks access_masks;
+	/**
+	 * @supervisor: If not null, this layer is operating in
+	 * supervisor mode.  Access denied by only supervised layers
+	 * are forwarded to the supervisor(s), who can then make a
+	 * decision whether to actually deny the access, or allow it.
+	 */
+	struct landlock_supervisor *supervisor;
 };
 
 /**
diff --git a/security/landlock/supervise.h b/security/landlock/supervise.h
index 1fc3460335af..febe26a11578 100644
--- a/security/landlock/supervise.h
+++ b/security/landlock/supervise.h
@@ -16,6 +16,12 @@
 #include "access.h"
 #include "ruleset.h"
 
+/**
+ * Each supervisor is associated with one active layer in a
+ * domain (or associated with a not-yet-active layer in a struct
+ * landlock_ruleset).  User-space interact with the event queue
+ * through a landlock_supervise_fd.
+ */
 struct landlock_supervisor {
 	refcount_t usage;
 	spinlock_t lock;
-- 
2.39.5


