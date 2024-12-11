Return-Path: <linux-fsdevel+bounces-37061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A8B9ECEBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 15:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CCB166045
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE68718732B;
	Wed, 11 Dec 2024 14:37:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6413C9C4;
	Wed, 11 Dec 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.126.240.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927820; cv=none; b=hYyC2H4+e/surDIysyfgx7O1bhr9Zqa2ANbqIFqlStYaMi7AC9xrjyPzpNZBWTjzIYlpYhWicuhShPQ1dgYBdqUHp/eKNLj+bF5TbXhKAIr0jWuRkiyKx//aDXBI9MJ/96T/fOv3/sJUHeNtSVwvO+L30qM59nKraTv+Hh/ITlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927820; c=relaxed/simple;
	bh=PzIBgLEeP+TLp+hVwr9WgqpdE3JYz+fxHjBNgeELBlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzyYBKsy6bLI4Anpvg1exxIp2C4eplQtABJbns6FXvvpDRnM64bEGE0VbEVChpIY4a4tboo6PTi24e6a1gES5aur7swo0NIZSdnoiTEHS0csDWtKdiSXBkE4ObXtk9/c2joH0o1L3lcgnjDU5lwFtQKKgOeoFZc2aPQRNzqWX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=codon.org.uk; arc=none smtp.client-ip=176.126.240.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codon.org.uk
Received: from fedora.. (unknown [62.172.215.13])
	by cavan.codon.org.uk (Postfix) with ESMTPSA id 9F2ED40A3D;
	Wed, 11 Dec 2024 14:29:35 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [RFC] Add a prctl to disable ".." traversal in path resolution
Date: Wed, 11 Dec 2024 14:29:29 +0000
Message-ID: <20241211142929.247692-1-mjg59@srcf.ucam.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Path traversal attacks remain a common security vulnerability
(https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=%22path+traversal%22)
and many are due to either failing to filter out ".." when validating a
path or incorrectly collapsing other sequences of "."s into ".." .
Evidence suggests that improving education isn't fixing the problem.

The majority of internet-facing applications are unlikely to require the
ability to handle ".." in a path after startup, and many are unlikely to
require it at all. This patch adds a prctl() to simply request that the
VFS path resolution code return -EPERM if it hits a ".." in the process.
Applications can either call this themselves, or a service manager can
do this on their behalf before execing them.

Note that this does break resolution of symlinks with ".." in them,
which means it breaks the common case of /etc/whatever/sites-available.d
containing site-specific configuration, with
/etc/whatever/sites-enabled.d containing a set of relative symlinks to
../sites-available.d/ entries. In this case either configuration would
need to be updated before deployment, or the process would call prctl()
itself after parsing configuration (and then disable and re-enable the
feature whenever re-reading configuration). Getting this right for all
scenarios involving symlinks seems awkward and I'm not sure it's worth
it, but also I don't even play a VFS expert on TV so if someone has
clever ideas here we can extend this to support that case.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
---
 fs/namei.c                 | 7 +++++++
 include/linux/sched.h      | 1 +
 include/uapi/linux/prctl.h | 3 +++
 kernel/sys.c               | 5 +++++
 4 files changed, 16 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 9d30c7aa9aa6..01d0fa415b64 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2431,6 +2431,13 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 
 		switch(lastword) {
 		case LAST_WORD_IS_DOTDOT:
+			/*
+			 * Deny .. in resolution if the process has indicated
+			 * it wants to protect against path traversal
+			 * vulnerabilities
+			 */
+			if (unlikely(current->deny_path_traversal))
+				return -EPERM;
 			nd->last_type = LAST_DOTDOT;
 			nd->state |= ND_JUMPED;
 			break;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d380bffee2ef..9fc7f4c11645 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1008,6 +1008,7 @@ struct task_struct {
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
 #endif
+	unsigned                        deny_path_traversal:1;
 #ifdef CONFIG_PREEMPT_RT
 	struct netdev_xmit		net_xmit;
 #endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 5c6080680cb2..d289acecef6c 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -353,4 +353,7 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      76
 
+/* Block resolution of "../" in paths, returning -EPERM instead */
+#define PR_SET_PATH_TRAVERSAL_BLOCK      77
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index c4c701c6f0b4..204ea88d5597 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2809,6 +2809,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_SET_PATH_TRAVERSAL_BLOCK:
+		if ((arg2 > 1) || arg3 || arg4 || arg5)
+			return -EINVAL;
+		current->deny_path_traversal = !!arg2;
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.47.0


