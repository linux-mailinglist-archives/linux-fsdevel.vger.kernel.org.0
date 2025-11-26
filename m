Return-Path: <linux-fsdevel+bounces-69914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D9C8B8BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F62335B6CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411B7314A82;
	Wed, 26 Nov 2025 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="i5WPRww7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AEF1D5170
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764184655; cv=none; b=NJ4NY4ORkd3tyJAD/vbWMsxpAeBUUYCciamdJ5wuFfb/1vg7PbbpLZKD1EjZxKiaB+ikGr7ZdrRiRg0EO8FxkHZ+MX4UGOihE3wRKeLu3KLksNAVMeaGufBjWiVMWnSCaP5RdQ/FXEBnsNOdf/AiZp/GFKM2c1gzjPbHSd5R/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764184655; c=relaxed/simple;
	bh=kEosmMHPCD5lhTv1eR2E+OOD6sWFunYUpGLFsv37ics=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaC5XMu92sNa24KL5tT9d9gahVsxrUWMJwwuHucVKM58/B6/HwkCTSmdfvtwGbKMCYUO90Z1kfHpd2gjyQtG62wTjDxAe0kqbuUHa2d9fc9/1gJ5J4O1KQLbzh6R2LLuVB6gATY3RfqSse+LzbqC1Mb687kxKsgTUwuo5Yf1WP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=i5WPRww7; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dGq1f07NJzJ5j;
	Wed, 26 Nov 2025 20:12:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1764184325;
	bh=ueIO+4dm8tI/FD4qKaIisBdzaOP4AclNwA9F9lhXSnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5WPRww7Xdq49xFqRkROcHOJBCA0iTXKxSl9IOy6smEWCRHZuqYdym5ol+qGuZrhW
	 P46DVSmu8lC/S4N8OpaBbq8u/ZMiWwLmu6GdC0g1BNZdlbufGLFoU9T0J3zVy8zpcI
	 1wBUGkCgrVQ9uaTCc4YX9nwFvWg+cWnZmuaPfQcE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dGq1d3Bxnzskv;
	Wed, 26 Nov 2025 20:12:05 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ben Scarlato <akhna@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Paul Moore <paul@paul-moore.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 2/4] landlock: Improve variable scope
Date: Wed, 26 Nov 2025 20:11:55 +0100
Message-ID: <20251126191159.3530363-3-mic@digikod.net>
In-Reply-To: <20251126191159.3530363-1-mic@digikod.net>
References: <20251126191159.3530363-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This is now possible thanks to the disconnected directory fix.

Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v3:
- New patch extracted from the previous one.
---
 security/landlock/fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 26d5c274a4c9..ee2fa7382a9b 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -837,7 +837,6 @@ static bool is_access_to_paths_allowed(
 	 * restriction.
 	 */
 	while (true) {
-		struct dentry *parent_dentry;
 		const struct landlock_rule *rule;
 
 		/*
@@ -930,7 +929,9 @@ static bool is_access_to_paths_allowed(
 			walker_path.dentry = walker_path.mnt->mnt_root;
 			dget(walker_path.dentry);
 		} else {
-			parent_dentry = dget_parent(walker_path.dentry);
+			struct dentry *const parent_dentry =
+				dget_parent(walker_path.dentry);
+
 			dput(walker_path.dentry);
 			walker_path.dentry = parent_dentry;
 		}
-- 
2.51.0


