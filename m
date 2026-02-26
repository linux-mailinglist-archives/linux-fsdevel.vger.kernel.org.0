Return-Path: <linux-fsdevel+bounces-78489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGxnOGFRoGnriAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:57:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D0B1A71BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B414316D44A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C8399009;
	Thu, 26 Feb 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6E09xV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB0396D2A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113822; cv=none; b=dheSxTDlwMmMOPj4YmxHdzje2eF61H/YPicWfiegoXjX2x14YU7e++bR1FuAtTo/SvXFPrV9fqQqtf4gsgpw4OJXhmbt9gG9DMdaCO3aWYWPBczTryK9I/ZQt75aNYwLXIXsR52d4JEKY1L5V6QNUhGKuZCnxP3cI15z2i3ZcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113822; c=relaxed/simple;
	bh=ZKUcTVAZ2rVvwHNuPHwblRUXojj7plRreIbXm7tr+Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W88ebVJOp+wCw+a4cksgGjjFcegtCN6Nk9Xog6hgvzWTlD+9dI174gZGIhfLvVtrJNT3ZsSUUcr+VxReFTAgfuK1kTPK9bCv+tVOn4v6NmNfuhaKa+rnEKRwvk5Q/dc+RR/sU2fSRBE1WAjWaDfy8irMpfttj7vn1/E6ufmghMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6E09xV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD12C19423;
	Thu, 26 Feb 2026 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113821;
	bh=ZKUcTVAZ2rVvwHNuPHwblRUXojj7plRreIbXm7tr+Vk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S6E09xV/kzV/RHZ01NQt0kOiXUhXXq95w1siFqsItOxRzEg+0j9jiTQy6PkTHClSp
	 jxOr6wV4YkBGJDXIKb0MyVgM5ipV8mhf/SvS2wGjQ4vTdj38jApK2wOoSKg2lDfvn6
	 u9P9te+AKeAHhm/M9L54LssCGrQ67upFW+LpDCE0wEvqO065yBS1yiv4iovwig9uXG
	 okzyH8CiJb0YxhXsS2n9J4y2VnjDL6/dBum5y30goXCRWNoUxe9UJCXchaFirte4wQ
	 1ZE3yAUJmXGzVTw2dK+KKfV3b9rt8o69RHJwGTgTw0aL9S853XCNvLjOtwZFTonp9m
	 iXUAyu6JbYO5w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 14:50:11 +0100
Subject: [PATCH 3/4] nstree: tighten permission checks for listing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-work-visibility-fixes-v1-3-d2c2853313bd@kernel.org>
References: <20260226-work-visibility-fixes-v1-0-d2c2853313bd@kernel.org>
In-Reply-To: <20260226-work-visibility-fixes-v1-0-d2c2853313bd@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZKUcTVAZ2rVvwHNuPHwblRUXojj7plRreIbXm7tr+Vk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8J/a/VTGsPvY1r8fjQO9lXz2Ok2YHsEn9MAimM2M1
 zOCNW9ORykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQsrjL895lw5PdLKefKBSce
 LUz+IvWptnj3xB/6xYKbmH4xHu5uO8nw381g1f4FG2dkSWfMNueI/l4sf/fdDPZ1CZsNBCU/z/j
 fwQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78489-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40D0B1A71BB
X-Rspamd-Action: no action

Even privileged services should not necessarily be able to see other
privileged service's namespaces so they can't leak information to each
other. Use may_see_all_namespaces() helper that centralizes this policy
until the nstree adapts.

Fixes: 76b6f5dfb3fd ("nstree: add listns()")
Cc: stable@kernel.org # v6.19+
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nstree.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index f36c59e6951d..6d12e5900ac0 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -515,32 +515,11 @@ static inline bool __must_check ns_requested(const struct klistns *kls,
 static inline bool __must_check may_list_ns(const struct klistns *kls,
 					    struct ns_common *ns)
 {
-	if (kls->user_ns) {
-		if (kls->userns_capable)
-			return true;
-	} else {
-		struct ns_common *owner;
-		struct user_namespace *user_ns;
-
-		owner = ns_owner(ns);
-		if (owner)
-			user_ns = to_user_ns(owner);
-		else
-			user_ns = &init_user_ns;
-		if (ns_capable_noaudit(user_ns, CAP_SYS_ADMIN))
-			return true;
-	}
-
-	if (is_current_namespace(ns))
+	if (kls->user_ns && kls->userns_capable)
 		return true;
-
-	if (ns->ns_type != CLONE_NEWUSER)
-		return false;
-
-	if (ns_capable_noaudit(to_user_ns(ns), CAP_SYS_ADMIN))
+	if (is_current_namespace(ns))
 		return true;
-
-	return false;
+	return may_see_all_namespaces();
 }
 
 static inline void ns_put(struct ns_common *ns)
@@ -600,7 +579,7 @@ static ssize_t do_listns_userns(struct klistns *kls)
 
 	ret = 0;
 	head = &to_ns_common(kls->user_ns)->ns_owner_root.ns_list_head;
-	kls->userns_capable = ns_capable_noaudit(kls->user_ns, CAP_SYS_ADMIN);
+	kls->userns_capable = may_see_all_namespaces();
 
 	rcu_read_lock();
 

-- 
2.47.3


