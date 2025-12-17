Return-Path: <linux-fsdevel+bounces-71556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EA8CC7812
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92FA1304A298
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257333F377;
	Wed, 17 Dec 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcnUUdtp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A8328269
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970636; cv=none; b=jwv0NxYipFNDsnMq9ebf0h2KwxuD0MszuQDz50W5umuCnUdZZUG4cAnHgyuhMjPuNEPo1PNWy2Jf7LhC+ezpAUDxK/vP9PYWVpom30u7u2kpeK0qAzE0qVtZnkRNGirzJs/vXRMm5bjazVJcu2l6j3cXIL0SFnTroGJsz3H+Dhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970636; c=relaxed/simple;
	bh=W9mB/s+6NpiP851KsOTKDnLe5z0a+USXsqtxkt1hnAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSX7vdkbt5aM7qSZhdLyjgxvZF79B0HpQQPjjaVaZD2H6aDCfhC529gPtiONhWCdGTKzLtTwIoTnof0aWr1Q1bJDXgvZZYlxsLyHy+Ec3DIPafjPfwkterOMtXhuNMan912MbBe+kCCXXLZTZsQ88AmcdqueKz4yEkTIKhBgFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcnUUdtp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b75c7cb722aso1036453166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 03:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765970630; x=1766575430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utptP+nB5b+dBv566krvogAvKAOstaX508wcNusI1uA=;
        b=CcnUUdtp0nh5Y67f7VUIJyE8KeeY8TEy14wsNxJ27olcwNuYS7g+Obj3oVsVL/wY22
         HJLaBOg9IdB6zFGCzeJxlUXzXQr+AMcxuBSms0IUfYpKN6PiCtw2oia9s16CQLRwLJhE
         xueeHwnBDn+ClLd4y+5aVQ3ztEB5Q+vnOk3S6YOQ4eB92FyZYlHF14QJIjv0jD9QvtQC
         S7A7Mt359UHBIQ7uczCOG2WpwCoF7mNQMlPO5InQD8C7uxe2tByXamgXSHcP2mtdbHxc
         sM3ra/fOpG90f/3Nji+S35Hui7k/NYWXjPMzzkOknVeWRSE62L8Y7CaXQxGj4JRC5Ido
         sV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970630; x=1766575430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utptP+nB5b+dBv566krvogAvKAOstaX508wcNusI1uA=;
        b=mnXxe3T9wGGH9zCNiCYtNSq9Ml0L1d4fWu3QHbPy8ahlGIu4enMw2K3/Y2dgISj+N4
         mGoWbHe+VtYoTokBe6h36kzsmMqTEYX9LuFBQsmrNvtW6fiB7V16siOJ/d+s/ntZbbvw
         W9SU+SSIxlED/LJTxsrf4g26K9YKt6vMoGsTle64iduv5cZZxsyLxtCso+1H2aI+KhAC
         mE7I7C4EehZs+UyfCVV6zEagszHAMS8Dgg0LuRITo+JWI0UT9+5OZEhnj4yh38xn9Z9b
         rZtLc2Iib/34CORn+2pvoTn57/WUFvQrQ+GTO3FBkCsaLg/uhmrFk3sMwF1ju6P2rewI
         lpyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/E7YQU8fGjdKaBi9GiMqlUezCSvvBmbcsv7JBrD6mM6hFnOuhwUns2el6uaYLstC6XTDho3rQvhjZHLSt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw64rKIy3LgBqa0eDR/NB8pKfRBJqlegT3oHPxzrG5B7WMz3FAP
	6wrycoX2+wHVWx2Yhjn5y+l8bdy79/IRD80BnIDhBaeWrhi+EDZCyWR9
X-Gm-Gg: AY/fxX4CJUIRSV9D2Z4i1mBqLabJnAlsrypvQ7bTsWeBSuOgW1JkC1TqSZ28Kb2bSUe
	6bJocw9ZvNwHUX2Jn8kn0athVPNdDqP14cakb6P3hXzWEwgt8UiET9B2f4RsM9CCHbya10sfnFX
	P1QzKK/SE3RBBdaHW2cWMXCsYf90WFNe9Ya3Y8W3arBp3nA/qG5rvcd5cOgcWDKmngLxs72d6qP
	ObI5COlQlULWnP+gV3+X718vu60rrLI4DrwF24PSU/Nfl2YChM1bp/9qJSgyDI8c8wVfveN+qDV
	J5vP9TtYNLT9naqOZ3KaEP90/o187SyUWjyhGhazPe4uFJokDaLibqoRVC7y2DtD9nurc2JlR0h
	pG32ssj07LTw4HBIdJ0Jkd4mU5mU1DQNqjJqlIHNbXNS9kjLgBl2Oeal7jfT7px+lfClkzpWFsl
	9J5SL6OzyBw4W8Pbl3Imuu46g/qgStcaGcLw4Lx1rnQw4T4TVMA4/lU/2M6Bt+JQ==
X-Google-Smtp-Source: AGHT+IEK/dX3imql40aGZgBA3X1I+yNatI6j4BO51p9hUZLKDwuwMpSqIl0o0lZdCtvRl3TzHVicMw==
X-Received: by 2002:a17:907:b022:b0:b7f:f862:df26 with SMTP id a640c23a62f3a-b7ff862e2f0mr335190366b.14.1765970629916;
        Wed, 17 Dec 2025 03:23:49 -0800 (PST)
Received: from f.. (cst-prg-23-145.cust.vodafone.cz. [46.135.23.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29f51esm1944829766b.14.2025.12.17.03.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:23:49 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	clm@meta.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH v2] fs: touch up symlink clean up in lookup
Date: Wed, 17 Dec 2025 12:23:45 +0100
Message-ID: <20251217112345.2340007-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide links_cleanup_rcu() and links_cleanup_ref() for rcu- and ref-
walks respectively.

The somewhat misleading drop_links() gets renamed to links_issue_delayed_calls(),
which spells out what it is actually doing.

There are no changes in behavior, this however should be less
error-prone going forward.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

v2:
- remove the mindless copy-paste in links_cleanup_ref, instead only move
  path_puts on the symlinks

this performs path_put on nd->path later, which should not be a material
difference.

this assumes the LOOKUP_CACHED fixup is applied:
https://lore.kernel.org/linux-fsdevel/20251217104854.GU1712166@ZenIV/T/#mff14d1dd88729f40fa94ada8beaa64e0c41097ff

technically the 2 patches could be combined, but I did not want to do it
given the bug

Chris, can you feed this thing into the magic llm? Better yet, is it
something I can use myself? I passed the known buggy patch to gcc
-fanalyze and clang --analyze and neither managed to point out any
issues.

diff --git a/fs/namei.c b/fs/namei.c
index 69d0aa9ad2a8..7d1722cebe99 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -766,7 +766,7 @@ static bool path_connected(struct vfsmount *mnt, struct dentry *dentry)
 	return is_subdir(dentry, mnt->mnt_root);
 }
 
-static void drop_links(struct nameidata *nd)
+static void links_issue_delayed_calls(struct nameidata *nd)
 {
 	int i = nd->depth;
 	while (i--) {
@@ -774,6 +774,29 @@ static void drop_links(struct nameidata *nd)
 		do_delayed_call(&last->done);
 		clear_delayed_call(&last->done);
 	}
+}
+
+static void links_cleanup_rcu(struct nameidata *nd)
+{
+	VFS_BUG_ON(!(nd->flags & LOOKUP_RCU));
+
+	if (likely(!nd->depth))
+		return;
+
+	links_issue_delayed_calls(nd);
+	nd->depth = 0;
+}
+
+static void links_cleanup_ref(struct nameidata *nd)
+{
+	VFS_BUG_ON(nd->flags & LOOKUP_RCU);
+
+	if (likely(!nd->depth))
+		return;
+
+	links_issue_delayed_calls(nd);
+	for (int i = 0; i < nd->depth; i++)
+		path_put(&nd->stack[i].link);
 	nd->depth = 0;
 }
 
@@ -786,20 +809,16 @@ static void leave_rcu(struct nameidata *nd)
 
 static void terminate_walk(struct nameidata *nd)
 {
-	int depth = nd->depth;
-	if (unlikely(depth))
-		drop_links(nd);
-	if (!(nd->flags & LOOKUP_RCU)) {
-		int i;
+	if (nd->flags & LOOKUP_RCU) {
+		links_cleanup_rcu(nd);
+		leave_rcu(nd);
+	} else {
+		links_cleanup_ref(nd);
 		path_put(&nd->path);
-		for (i = 0; i < depth; i++)
-			path_put(&nd->stack[i].link);
 		if (nd->state & ND_ROOT_GRABBED) {
 			path_put(&nd->root);
 			nd->state &= ~ND_ROOT_GRABBED;
 		}
-	} else {
-		leave_rcu(nd);
 	}
 	VFS_BUG_ON(nd->depth);
 	nd->path.mnt = NULL;
@@ -838,7 +857,7 @@ static bool legitimize_links(struct nameidata *nd)
 	for (i = 0; i < nd->depth; i++) {
 		struct saved *last = nd->stack + i;
 		if (unlikely(!legitimize_path(nd, &last->link, last->seq))) {
-			drop_links(nd);
+			links_issue_delayed_calls(nd);
 			nd->depth = i + 1;
 			return false;
 		}
@@ -884,7 +903,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	if (unlikely(nd->flags & LOOKUP_CACHED)) {
-		drop_links(nd);
+		links_cleanup_rcu(nd);
 		goto out1;
 	}
 	if (unlikely(nd->depth && !legitimize_links(nd)))
@@ -923,7 +942,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	if (unlikely(nd->flags & LOOKUP_CACHED)) {
-		drop_links(nd);
+		links_cleanup_rcu(nd);
 		goto out2;
 	}
 	if (unlikely(nd->depth && !legitimize_links(nd)))
-- 
2.48.1


