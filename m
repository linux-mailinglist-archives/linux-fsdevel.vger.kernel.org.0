Return-Path: <linux-fsdevel+bounces-70173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DABC92CA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C6A64E4B65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8432ED2D;
	Fri, 28 Nov 2025 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZjY8lCW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64C2627EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350547; cv=none; b=r1Kf2WfHjXuykR00DQTTJ1CgFMLpCJC0s1HuplXusAmkwGeNH+ZpPsBUAxuGFMkZT81B50xYg0raiHFZR4FqL5PDF7QXCiL36FiDlQcOUkhJ96c1DCRan9OdGxg1pU7jj++RsPrwLfvejta8Cqf4yAY1yexyvyaisF88imXQZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350547; c=relaxed/simple;
	bh=xGRWzfi6OomS4A0NUW4uy2x1s9MRKsRQMvAUKeXLLPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bcm+WZzOZF+UOBtn58f6wHLgt1k2g9g+lLs2osoQnis2VHmbaKgXIusYFyEVSMIepfAHUMdusudp1NZeBXbavs08rzzOlxmerWBLdl1tetXFHKm4SExUkAnL/hQqWzB/en5e69MUQf1b1tR9Vgr96AAxBVjSJqK21QtN1OmQ8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZjY8lCW4; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dJ0V108xxzgNQ;
	Fri, 28 Nov 2025 18:22:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1764350536;
	bh=AQzYQXVKZ1Xwn32sFO4q9nNhRSWpJGJEZVMQRyxyORo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjY8lCW4OZvBXVNLqPiPEavnmq8FPeOmnXYG+FWXwBGAsIxX2UVvyiohIH/5WUEb3
	 q50Uvwd84gz+LLD7blL0MMBOsiGH1b9YMvs6hDDrZ2xztIM9tYGTeJqsMgSp15dbZn
	 FHLIVFj6iR6Y7+Xk6Ky6bvR/8A6cqubM1a4wTM5I=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dJ0V02W2Cz1S3;
	Fri, 28 Nov 2025 18:22:16 +0100 (CET)
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
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	NeilBrown <neil@brown.name>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Paul Moore <paul@paul-moore.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 2/4] landlock: Improve variable scope
Date: Fri, 28 Nov 2025 18:21:57 +0100
Message-ID: <20251128172200.760753-3-mic@digikod.net>
In-Reply-To: <20251128172200.760753-1-mic@digikod.net>
References: <20251128172200.760753-1-mic@digikod.net>
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
index a2ed0e76938a..8998fa4ca5f0 100644
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


