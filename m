Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E115153494
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 16:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgBEPte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 10:49:34 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45323 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbgBEPtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:49:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CA95B725;
        Wed,  5 Feb 2020 10:49:32 -0500 (EST)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Wed, 05 Feb 2020 10:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=QGZ6ZmUO0McPmxz1WCjKsoGfgGhXB
        tk/4d4PVbZjD3s=; b=xi1CE3nqMaoa9nVrT5cbNYqQGVym0HDOTDOc14aFH+yKe
        gPOD2a91tulOxaKqTaDN79Rq7P4A6s/80HURhFHE34+VqpGmPLVIvvL979F7xzCH
        BPRvtmnTgnS+LuF7LH3WXP3spplcTD3lUZF0yC0OqJbAolJB592SvaotZuMT/xHx
        eGS6JKN93cHADETsrd/yUDCpfUWQq7zUBwL02Qs1HnOli55YE9j9CLWf+1YPsu3p
        RD+Of943mmBgki82O0Sw6C5Kj92d4+7kglOGXD+GNiw+sp1npJYLnXezcAXM3J/0
        22cd3BFF/WD0J1h8Gc+1xT9VS4chE5UNXXuTnLgsw==
X-ME-Sender: <xms:DOQ6Xv7FsFscuaCLQ_s4gNodyUYHkiik7CGPUnJaJcDEznAKmD1iNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrhedugdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvufgtsehttdertderreejnecuhfhrohhmpedfveholhhinhcu
    hggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehv
    vghrsghumhdrohhrgh
X-ME-Proxy: <xmx:DOQ6XklDyS92-Ak7ndp0ZmMttwmPPfwOh2KW8Pu_nR9_txJv2hulZg>
    <xmx:DOQ6XiHC6eJ2AN5xS0vprUUNRvAZnbNvyZsL3aBUt8s0kMnM0H3Y9A>
    <xmx:DOQ6Xr-Rqy17kiIH0rF-q4oaFE496UGvbw6vjckLH9vKSrVKbN44mQ>
    <xmx:DOQ6Xk9qioJVbj75SuwSO8fIARsF4rdL4x-H8OOprf6OQdCsTNqvjA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 011AC660065; Wed,  5 Feb 2020 10:49:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-802-g7a41c81-fmstable-20200203v1
Mime-Version: 1.0
Message-Id: <f705c324-4cc6-477d-b3bb-308b25add4d4@www.fastmail.com>
Date:   Wed, 05 Feb 2020 10:49:10 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "David Howells" <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: =?UTF-8?Q?[PATCH]_vfs:_Remove_stray_debug_log,_add_func_name_to__fs=5Fva?=
 =?UTF-8?Q?lidate=5Fdescription?=
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From bf5d3636beeeafc84c4c40deb5a935a5b4554f55 Mon Sep 17 00:00:00 2001
From: Colin Walters <walters@verbum.org>
Date: Wed, 5 Feb 2020 15:19:11 +0000
Subject: [PATCH] vfs: Remove stray debug log, add func name to
 fs_validate_description

I was recently looking at the logs of a kernel bootup for an
unrelated reason and came across `*** VALIDATE bpf` and wondered
what it meant - was something loading a BPF module at boot?

A quick grep led me to this code, and I think this is just a
stray debugging message.  If we *do* want this message I think
it'd probably be better done in `register_filesystem()` or so?

Further, clean up the `pr_err` usage here to look like many other
places in the kernel which prefix with `__func__`.  The
capitalized `VALIDATE` is both "shouty" and more importantly too
generic to easily lead to the right place via an Internet search
engine.  `VALIDATE bpf` in particular could mean a lot of things,
but `fs_validate_description bpf` should lead directly to
the Linux kernel source here.

Signed-off-by: Colin Walters <walters@verbum.org>
---
 fs/fs_parser.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index d1930adce68d..a184e23f5f18 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -365,10 +365,8 @@ bool fs_validate_description(const struct fs_parameter_description *desc)
 	unsigned int nr_params = 0;
 	bool good = true, enums = false;
 
-	pr_notice("*** VALIDATE %s ***\n", name);
-
 	if (!name[0]) {
-		pr_err("VALIDATE Parser: No name\n");
+		pr_err("%s: no name\n", __func__);
 		name = "Unknown";
 		good = false;
 	}
@@ -380,8 +378,8 @@ bool fs_validate_description(const struct fs_parameter_description *desc)
 			/* Check that the type is in range */
 			if (t == __fs_param_wasnt_defined ||
 			    t >= nr__fs_parameter_type) {
-				pr_err("VALIDATE %s: PARAM[%s] Bad type %u\n",
-				       name, param->name, t);
+				pr_err("%s %s: PARAM[%s] Bad type %u\n",
+				       __func__, name, param->name, t);
 				good = false;
 			} else if (t == fs_param_is_enum) {
 				enums = true;
@@ -390,8 +388,8 @@ bool fs_validate_description(const struct fs_parameter_description *desc)
 			/* Check for duplicate parameter names */
 			for (p2 = desc->specs; p2 < param; p2++) {
 				if (strcmp(param->name, p2->name) == 0) {
-					pr_err("VALIDATE %s: PARAM[%s]: Duplicate\n",
-					       name, param->name);
+					pr_err("%s %s: PARAM[%s]: Duplicate\n",
+					       __func__, name, param->name);
 					good = false;
 				}
 			}
@@ -402,14 +400,14 @@ bool fs_validate_description(const struct fs_parameter_description *desc)
 
 	if (desc->enums) {
 		if (!nr_params) {
-			pr_err("VALIDATE %s: Enum table but no parameters\n",
-			       name);
+			pr_err("%s %s: Enum table but no parameters\n",
+			       __func__, name);
 			good = false;
 			goto no_enums;
 		}
 		if (!enums) {
-			pr_err("VALIDATE %s: Enum table but no enum-type values\n",
-			       name);
+			pr_err("%s %s: Enum table but no enum-type values\n",
+			       __func__, name);
 			good = false;
 			goto no_enums;
 		}
@@ -421,8 +419,9 @@ bool fs_validate_description(const struct fs_parameter_description *desc)
 			for (param = desc->specs; param->name; param++) {
 				if (param->opt == e->opt &&
 				    param->type != fs_param_is_enum) {
-					pr_err("VALIDATE %s: e[%tu] enum val for %s\n",
-					       name, e - desc->enums, param->name);
+					pr_err("%s %s: e[%tu] enum val for %s\n",
+					       __func__, name, e - desc->enums,
+						   param->name);
 					good = false;
 				}
 			}
@@ -438,15 +437,15 @@ bool fs_validate_description(const struct fs_parameter_description *desc)
 				if (e->opt == param->opt)
 					break;
 			if (!e->name[0]) {
-				pr_err("VALIDATE %s: PARAM[%s] enum with no values\n",
-				       name, param->name);
+				pr_err("%s %s: PARAM[%s] enum with no values\n",
+				       __func__, name, param->name);
 				good = false;
 			}
 		}
 	} else {
 		if (enums) {
-			pr_err("VALIDATE %s: enum-type values, but no enum table\n",
-			       name);
+			pr_err("%s %s: enum-type values, but no enum table\n",
+			       __func__, name);
 			good = false;
 			goto no_enums;
 		}
-- 
2.24.1

