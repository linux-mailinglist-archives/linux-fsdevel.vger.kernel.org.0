Return-Path: <linux-fsdevel+bounces-56720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC6FB1ADA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 07:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB567A7CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6AD2192F2;
	Tue,  5 Aug 2025 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="aJUalihm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6F2C190;
	Tue,  5 Aug 2025 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754372740; cv=none; b=MHUUNwJTnoiNuaX2wJUfyU6FZar02A6aPbaJQg/u/ZyqZRQ6KW+WK2JOeEJ9HcfsR+7zlKOTm1st0H6qmoJV+OTMN8eFNRuMzxAN9keBAtZi6qD8aPZZo9D/EioqpN6XIeNQ+agU4L+wDbaYjg2hfDiT5hyQSk6EGZPcl5jfg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754372740; c=relaxed/simple;
	bh=p0CI35ogoHgUlRWLHKPkYHs040kuapK3lWwQMhtdaMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VyhTC11x7C+LVSA1JjrVEVPhukfhAlQka5uKSRQe9k1ZHHvJX5OEn1IcbyqusEpxn8EWug0QkdkDzmeIOB4zjYYRCXvHPC9uxT7VMWVQE3Av6v9CKjdNrjMhjB9Sx7Vxgc2ldcftk6swAgWWZQQjWleuOPrb+OffvWIE/Ol0ORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=aJUalihm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bx2TC06ZSz9t3b;
	Tue,  5 Aug 2025 07:45:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754372735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYYuPVtguJfcotsXuI5EAsnUJxvEUQg+kC38k/XfePw=;
	b=aJUalihmBKwkqsdQ+VG5ModXOvpMiIxLgIKL+TgcwkZ4901IFJFQbKKgpywbwE1KZQnnjg
	PGu/ySxFLHhDMuIYEud02KdpxApj1Eh+17IEO9gPVOQ+ooMNvTn+ly/tZSStpYwPHxyggJ
	bo7ILnBHZcSb3sHAs91AqYFkZp8O+t0UNqoIO7pVCJu7jym1y1tOrRwjFXCy4IIf+WF+JX
	p6uDEcdB4gZsZz3SatMimGxDoGV/bdHHmNa/KNHw/79JzfuRnnD+NOBI+MwXPmwRGgeFdT
	AkPqsm4IG9cpSeGn6b+LvwJuLRMKW3a+TLhDIQggP5irJWhQeJR8tcdyp0k9SQ==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Tue, 05 Aug 2025 15:45:08 +1000
Subject: [PATCH v4 1/4] pidns: move is-ancestor logic to helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-procfs-pidns-api-v4-1-705f984940e7@cyphar.com>
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
In-Reply-To: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2708; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=p0CI35ogoHgUlRWLHKPkYHs040kuapK3lWwQMhtdaMU=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMnJWnvnOpV8KXhUuWsZ3U2yTemfjtiN4P58UvRY9Iy
 e2MiQ9Y2VHKwiDGxSArpsiyzc8zdNP8xVeSP61kg5nDygQyhIGLUwAmklbAyLDSPL3equ7lo6Wa
 3Qcf1Dj5+aTd/yaTPFVhu7DDd6UF3HsYGT5PYk7jcNjzI2jJSnmLvX8zD/2zX5X45UGkyHt+lWP
 rk9kB
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

This check will be needed in later patches, and there's no point
open-coding it each time.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/pid_namespace.h |  9 +++++++++
 kernel/pid_namespace.c        | 22 ++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 7c67a5811199..17fdc059f8da 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -84,6 +84,9 @@ extern void zap_pid_ns_processes(struct pid_namespace *pid_ns);
 extern int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd);
 extern void put_pid_ns(struct pid_namespace *ns);
 
+extern bool pidns_is_ancestor(struct pid_namespace *child,
+			      struct pid_namespace *ancestor);
+
 #else /* !CONFIG_PID_NS */
 #include <linux/err.h>
 
@@ -118,6 +121,12 @@ static inline int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 {
 	return 0;
 }
+
+static inline bool pidns_is_ancestor(struct pid_namespace *child,
+				     struct pid_namespace *ancestor)
+{
+	return false;
+}
 #endif /* CONFIG_PID_NS */
 
 extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7098ed44e717..b7b45c2597ec 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -390,11 +390,23 @@ static void pidns_put(struct ns_common *ns)
 	put_pid_ns(to_pid_ns(ns));
 }
 
+bool pidns_is_ancestor(struct pid_namespace *child,
+		       struct pid_namespace *ancestor)
+{
+	struct pid_namespace *ns;
+
+	if (child->level < ancestor->level)
+		return false;
+	for (ns = child; ns->level > ancestor->level; ns = ns->parent)
+		;
+	return ns == ancestor;
+}
+
 static int pidns_install(struct nsset *nsset, struct ns_common *ns)
 {
 	struct nsproxy *nsproxy = nsset->nsproxy;
 	struct pid_namespace *active = task_active_pid_ns(current);
-	struct pid_namespace *ancestor, *new = to_pid_ns(ns);
+	struct pid_namespace *new = to_pid_ns(ns);
 
 	if (!ns_capable(new->user_ns, CAP_SYS_ADMIN) ||
 	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
@@ -408,13 +420,7 @@ static int pidns_install(struct nsset *nsset, struct ns_common *ns)
 	 * this maintains the property that processes and their
 	 * children can not escape their current pid namespace.
 	 */
-	if (new->level < active->level)
-		return -EINVAL;
-
-	ancestor = new;
-	while (ancestor->level > active->level)
-		ancestor = ancestor->parent;
-	if (ancestor != active)
+	if (!pidns_is_ancestor(new, active))
 		return -EINVAL;
 
 	put_pid_ns(nsproxy->pid_ns_for_children);

-- 
2.50.1


