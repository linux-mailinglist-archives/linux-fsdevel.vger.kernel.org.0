Return-Path: <linux-fsdevel+bounces-19574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D248C73B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 11:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C9C283645
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBF2143C60;
	Thu, 16 May 2024 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="UA73pc/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jMQGshpO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6F14388C;
	Thu, 16 May 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851296; cv=none; b=HkmfgW5eOxPxQ0kR0DQzM36WyNKKVQUJx0iLLA+nKUuA2cc0/Yd2xrPk08OHh6p6o3we+6mLO0jOXzAj1zODnRTYZScB9hrY+6GSsSVZfmWul0PEtDYRSkqM3KWLRH5IeIyRap0t/zXOceQWko2GX8xfnFbXK9yKZuObsxEFMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851296; c=relaxed/simple;
	bh=6O1ofNJUy0gHxkhdD5Q09AwNTpUXElwnupKCEglOSCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTuMJpZDdiNnhRHI7IalyEH+szOO6nLu7otpmTh9Yt27EbBe7LLliSduLWkj1ZFzJh/6Zirq/UVLYu1wGz/bp5sXNbdu5PcTNiyjWYz1JySVRjHuZHaFaFrNqecCWkXjLNzYnzkxxj7bMTUbzpOQ7BCIhjNBXXPjosJkjYTlDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=UA73pc/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jMQGshpO; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id 836752005AF;
	Thu, 16 May 2024 05:21:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 16 May 2024 05:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1715851293;
	 x=1715854893; bh=HAPFKHfyGQbSeGmKfPdaAPtnhg6SRuYQe6Dc6y43qhQ=; b=
	UA73pc/OZj0YmV+zhOjcamXvQzJJ5N4fuyV89JobU6APEbh3YxSpSZ9SZmzmS94G
	rMh36GIb308syuhVcPjzaefRcxakmw+Hju6JVck7oXFoE/hbwWnZ5OJk6ZhC/UOe
	s3bU+U5i7eb3MOT9xFPu4a9FVA8Q7HCqJ44eYDSYNn8GvtHNMWK0MjN9FL0gHkVs
	sBGyDG36b2NmJwtsBkRqJ7sswWf4c4wJjf65YaEOWAxpRfVAajhHmiZLFm54AxZN
	nQxYnr4PMZ+PSk4uXC9gOAxaDcEv3YaXx1LxKtt/9WFN9uOn0vZ6feamqDAJ2DDs
	g0kJO06+fxzabNaaiWQLRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i76614979.fm3; t=
	1715851293; x=1715854893; bh=HAPFKHfyGQbSeGmKfPdaAPtnhg6SRuYQe6D
	c6y43qhQ=; b=jMQGshpO5p6HAlkOptaqnbv/v3o1Fgscrcpf48aYl4AVGKxR4L6
	8zEPNQlL6ri9lnVlANsBBv8D+FJnFi6i425cf32wSc4EyT877h8IxsYo2r5sL168
	96HpaVCq6DHVjOHBF/VmjEEAAM5tbwHM8cz+xMkkilU+eZN81M1kuPhiX7O1gkHe
	7JoQ3gSX9hklFZq4Zjvzdbfd6nUDF1EOVRl8sVX1mbJjFgmhBFsBBKnJYJUH/38d
	xUXZmazej721K9huD6abFj4IS5SaX2SyHmqHSP9ONtb7gf3fRg1Oi5IL18ZrmfUj
	p+MtIswlKMhDIWfaWJn+T/B5ZcZTq9mHAdg==
X-ME-Sender: <xms:HdBFZqyvuyRdmB1CW91K-6PnHVo0loFztRKW8V8KaFawvvicRU36NQ>
    <xme:HdBFZmRwRKYmAGtOJjH7u1_Fy_zYIYXGIlmkJTiIiVV1sq0J7INrHcyvy3eZxNbHQ
    R6MzTqdSGZTzhEtQ5Y>
X-ME-Received: <xmr:HdBFZsUKrpO4yUT7QmrO4SDVB5wGml7jtEg5tHshIXOn5wCPxCx7GIVEsRe6Ok6eTicpscMnWM25bsArw3DOaxSDBa8hkHn3FRoS0w1C_NbbSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhn
    rghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeeiueeukeeitddvheeiveeiiedvhfeljeeiteeggedtteeiueet
    iefhudfgvddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:HdBFZggAR0eUt8H-DocPRkHJsgUH2KuvqrsXeCaZfpDDsXFsVbDCKw>
    <xmx:HdBFZsD35VbCqb4BtgWhj1Q3p6KNkKFeRIa3P0_Xs4zwTAe3TrH-9Q>
    <xmx:HdBFZhKZZwLugSFzgrvtShHWcV_TOxdBapDdIw0tbHKn9SmtQikaUg>
    <xmx:HdBFZjDq10R7dgQBIUrmJDRz7r6dzgKtuH2AI9O9uz4mUfZsEMcY8w>
    <xmx:HdBFZgxqEhFm4GKewHns_lpm7LjbShMHuZDefVV8aPz1EjMXs0W3tY4x>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 05:21:31 -0400 (EDT)
From: Jonathan Calmels <jcalmels@3xx0.net>
To: brauner@kernel.org,
	ebiederm@xmission.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: containers@lists.linux.dev,
	Jonathan Calmels <jcalmels@3xx0.net>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [PATCH 2/3] capabilities: add securebit for strict userns caps
Date: Thu, 16 May 2024 02:22:04 -0700
Message-ID: <20240516092213.6799-3-jcalmels@3xx0.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240516092213.6799-1-jcalmels@3xx0.net>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds a new capability security bit designed to constrain a
task’s userns capability set to its bounding set. The reason for this is
twofold:

- This serves as a quick and easy way to lock down a set of capabilities
  for a task, thus ensuring that any namespace it creates will never be
  more privileged than itself is.
- This helps userspace transition to more secure defaults by not requiring
  specific logic for the userns capability set, or libcap support.

Example:

    # capsh --secbits=$((1 << 8)) --drop=cap_sys_rawio -- \
            -c 'unshare -r grep Cap /proc/self/status'
    CapInh: 0000000000000000
    CapPrm: 000001fffffdffff
    CapEff: 000001fffffdffff
    CapBnd: 000001fffffdffff
    CapAmb: 0000000000000000
    CapUNs: 000001fffffdffff

Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
---
 include/linux/securebits.h      |  1 +
 include/uapi/linux/securebits.h | 11 ++++++++++-
 kernel/user_namespace.c         |  5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/securebits.h b/include/linux/securebits.h
index 656528673983..5f9d85cd69c3 100644
--- a/include/linux/securebits.h
+++ b/include/linux/securebits.h
@@ -5,4 +5,5 @@
 #include <uapi/linux/securebits.h>
 
 #define issecure(X)		(issecure_mask(X) & current_cred_xxx(securebits))
+#define iscredsecure(cred, X)	(issecure_mask(X) & cred->securebits)
 #endif /* !_LINUX_SECUREBITS_H */
diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/securebits.h
index d6d98877ff1a..2da3f4be4531 100644
--- a/include/uapi/linux/securebits.h
+++ b/include/uapi/linux/securebits.h
@@ -52,10 +52,19 @@
 #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
 			(issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED))
 
+/* When set, user namespace capabilities are restricted to their parent's bounding set. */
+#define SECURE_USERNS_STRICT_CAPS			8
+#define SECURE_USERNS_STRICT_CAPS_LOCKED		9  /* make bit-8 immutable */
+
+#define SECBIT_USERNS_STRICT_CAPS (issecure_mask(SECURE_USERNS_STRICT_CAPS))
+#define SECBIT_USERNS_STRICT_CAPS_LOCKED \
+			(issecure_mask(SECURE_USERNS_STRICT_CAPS_LOCKED))
+
 #define SECURE_ALL_BITS		(issecure_mask(SECURE_NOROOT) | \
 				 issecure_mask(SECURE_NO_SETUID_FIXUP) | \
 				 issecure_mask(SECURE_KEEP_CAPS) | \
-				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE))
+				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE) | \
+				 issecure_mask(SECURE_USERNS_STRICT_CAPS))
 #define SECURE_ALL_LOCKS	(SECURE_ALL_BITS << 1)
 
 #endif /* _UAPI_LINUX_SECUREBITS_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 7e624607330b..53848e2b68cd 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -10,6 +10,7 @@
 #include <linux/cred.h>
 #include <linux/securebits.h>
 #include <linux/security.h>
+#include <linux/capability.h>
 #include <linux/keyctl.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
@@ -42,6 +43,10 @@ static void dec_user_namespaces(struct ucounts *ucounts)
 
 static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
 {
+	/* Limit userns capabilities to our parent's bounding set. */
+	if (iscredsecure(cred, SECURE_USERNS_STRICT_CAPS))
+		cred->cap_userns = cap_intersect(cred->cap_userns, cred->cap_bset);
+
 	/* Start with the capabilities defined in the userns set. */
 	cred->cap_bset = cred->cap_userns;
 	cred->cap_permitted = cred->cap_userns;
-- 
2.45.0


