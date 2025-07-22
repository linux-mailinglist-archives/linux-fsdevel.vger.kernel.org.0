Return-Path: <linux-fsdevel+bounces-55765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72B4B0E70C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 01:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4AAAA0074
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D63D28BAA1;
	Tue, 22 Jul 2025 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="VIlUuJOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A3427EFF1;
	Tue, 22 Jul 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226372; cv=none; b=XpicO0CXp4c9g2z84iBBWF75R4ESDzyl53NSeLU1G298xd1Flu6OtS7bkVt4J433aTMjmjByhLNO2RJMsYn/gSlQ+NPJ4y5FP99QDIhITVs/XhjmOIhNIpCnbwOsrBk/trf89mra867NNclhoi5rGLYpnK6bNBAVoTOd+pYAbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226372; c=relaxed/simple;
	bh=KixoyUtbGrLnA3MTF47jcmrfse0K1oiiVQANOqAk1hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=roQeDO1xoxhPsiseWZ02PZ6V3PCtJUTE1JtbwXWoEKR/Mnd4NvggY7DpdTN3IBUG9Wd5rWQToCzXq6/E9HZ53Q/wDrgoH5QvmOxlpd6/WM5JCDMPTcQObH+VkIoTRhrw/vdOYX/X9q8/sa6gqThou0yQ8r/xICIDC8DyydBw8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=VIlUuJOj; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bmtWg2w3Tz9tN7;
	Wed, 23 Jul 2025 01:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753226367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz5+/xzkeEXoj428r2lantinAr2RMkc/0PWdNpXULag=;
	b=VIlUuJOjz6NdY9eJiosw8RkEmNlLuFDgzd3kGMxTqeiupMQ/qvEDNWd1SHdBG2IhbKelIS
	zPTL6exjG43c6Ec+7ucddZr56JC565X0Xu2RFOJp2kUlZk1maRh2P+QazJaAeonb5nPDv4
	K5SdMvvlcJpyA3RfyY0HjvfSbKtEwbZynLZHVXTRrnFZoaJPsxv7f6+NpPO0G+yaU92EL8
	it0/yBZIS0wPtpnPMuYgmpEhz4k89FYMeRCnuTDVU3yEJBIluYhUjwdw25+mbgRMd2SeRK
	bAMYahWbdWjqq6cIyGqbjKGnJpyJufHXHrA5EAsyGUUJdcw6j6RcSmzFnargMQ==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 23 Jul 2025 09:18:51 +1000
Subject: [PATCH RFC v2 1/4] pidns: move is-ancestor logic to helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-procfs-pidns-api-v2-1-621e7edd8e40@cyphar.com>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
In-Reply-To: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2749; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=KixoyUtbGrLnA3MTF47jcmrfse0K1oiiVQANOqAk1hI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWQ0yOSv/6e3xqdpts1xBolul/kv5ps0i7+Rk96+SeTxX
 2b+U5a3OkpZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBENlcyMmw7KcJmUh+49qDN
 Nb7XE1ZskWP6GPnab/O/k7Ut74JSWTQYGY75e6cpT0uUXvPz3akzMikiutm7n3+YPGvfnN2Nsuy
 vUzkA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

This check will be needed in later patches, and there's no point
open-coding it each time.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/pid_namespace.h |  9 +++++++++
 kernel/pid_namespace.c        | 23 +++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

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
index 7098ed44e717..c2783c5fa90b 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -390,11 +390,24 @@ static void pidns_put(struct ns_common *ns)
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
+EXPORT_SYMBOL_GPL(pidns_is_ancestor);
+
 static int pidns_install(struct nsset *nsset, struct ns_common *ns)
 {
 	struct nsproxy *nsproxy = nsset->nsproxy;
 	struct pid_namespace *active = task_active_pid_ns(current);
-	struct pid_namespace *ancestor, *new = to_pid_ns(ns);
+	struct pid_namespace *new = to_pid_ns(ns);
 
 	if (!ns_capable(new->user_ns, CAP_SYS_ADMIN) ||
 	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
@@ -408,13 +421,7 @@ static int pidns_install(struct nsset *nsset, struct ns_common *ns)
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
2.50.0


