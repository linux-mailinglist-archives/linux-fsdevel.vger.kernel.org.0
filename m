Return-Path: <linux-fsdevel+bounces-71553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0D5CC7444
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB4A30A421F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B27D33A010;
	Wed, 17 Dec 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfJL0izJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525329C321
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969278; cv=none; b=YtTuqfOGQ91OALP3NP0/pQQSYgEDd5F740Q5WV4s7Kq+8iEzVjXwtAWj7PxjOB5H5UQGmkJaIerLeG+aLyzuuSzuvl0FTO66Q7/effvjq0mlCldV1m4yYb3vHMYNbtiRf65UW9Zg6H3Jv/Sa2k/56scPSg5llSrpljTEAfAxCyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969278; c=relaxed/simple;
	bh=X3bYA0WrDEfWOzj5bMVf+TdTcSX6CVPnicK8sEKlTgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+ZWOSpQ75WNp/5bOJuoUr9yR6RQwUyh0ie5aDBQAnNr5UsptwAJjdbdk2Ng21IFwtcwKVcndJOn/aSgUFETXPy5cZRMJZ1dFYnK5U3VqfheXwJ+Zj2p2sRsqocfAEBkbxWIJX4Rt4VWDZXU9gp/q24QurYtwV5OsYhTwFEjFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfJL0izJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so88015066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 03:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765969275; x=1766574075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwVWde6ca06mMHyo9dvW0rPByW8h45B/CTH5c+8Srp0=;
        b=RfJL0izJ/hxlF2CORmmU8GvqX9YTmKMtaKCgiwuRkv8lm/EZ3w2g1+9lp4pyPId3X+
         s/MgkJt4SOgdjA9T4hq2hRjCXJMthyzQzZx49He9t6CRDKpDK22r7TLRSg8JkflS2Zqw
         sEb+/ZGsNLzHYMr4iVa+s4xl3OyUazFik4DbYFsmaOB8/lnHvt+kU5EpNzXAy0ji5pRX
         ppuWTTI0S0TZr7P2wzClrziRgSvgWZ/HQXxdcvHoT9i4TH5PZ6uVP3aoNr6Fi4PwqrNL
         CBjc38/LWXPef5WTIDmVIoRzI1GFhu3vDqE2dJrJGveKG/qTN0IE/PkEYWxpo89iCfcL
         1Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765969275; x=1766574075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwVWde6ca06mMHyo9dvW0rPByW8h45B/CTH5c+8Srp0=;
        b=eBy4JjEd+bzCyJUSsvkm2ICFMqGopq6TECUVnqMJnCilV0Rn0cspNcQUfbBnsat1ZB
         srjcruTkuVg5ZDOvcapaV4vr1O+DCvtpV9uqWwXn0eAnkIZIyz3v33wLI0KZiLHAJpnm
         sgClHQeS/ifPtwZt9UFwI2ll3KaAYqCM9uC3sQPGAfRbO6G6RUlBlSd0TlX3ryAYSe/u
         cxj5MoJ0EuxYnAvl3siSrLH6143/Z/mOs0VO9JBbJQu3s7NSTOl70FjnbrMBg3HgVOIJ
         Lc3WOOyeijEEws2HgxBjXl7ny4VTkhEUvhq0sndoWtgVpDjrcKqh9JwcEumIWSf/EmyG
         s2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUQGB9fHxuCME6nRYCJUzJSANeJH7kieTLy8ikTUkHBMUuTRtyyz33dV9ZMNfZ+qkS2qY4Fh/CtSPTENwEp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/bP5Fp5ajSEDlXCJ5UFZ/ldN5iQe1vQhg8vK5QJTWtZ67dsH
	DkiFBxofEPUwJ2pkHkPFH7TbwF2B0/PnO3WvOIZq6TlmuAddrpoNI68u
X-Gm-Gg: AY/fxX5klIiu1HpoUKpILLaxcEHYfABfnA/riqRDOZE8h6DIwG+G4GmGD6L4LDr9FUk
	v53I/Zq3dBy3dDlgh1y5xRMqqe0JrXvmqbRNOxY4DhMQp+dwCxb/9HjOzDtqT/wg/2M02jzPZAC
	rNg7++/aJcq+3rss8UfgHWR8Dagje4fCBD3X8KRMiP09zpLTwcBHzbTCP43XatjmOcgVlV5rBCo
	410AE4f358psVvCCkqjOrP+jt9BAF+OxML5FHT/My8vM+zUJT5mBlJ+zJQ5g3/2hZ7HId90MXcH
	VmObtMOdI/JWCQ9Pk6jbrwULuuyKqZvtCGLP74u88FZN14EdQR8lfyHQThWWVf6IFVToRdbXEoE
	0+FvkW6HWbSOI/PDn3PMa7kZl6ns/n2KQtouEl+4RjGAGzyQJDmRpg5MgwUQDSPdMxqTEvBXmDj
	/4b9HuAeJtN8dbXbHmO1a1P3zjZxBaRMoOj5PXd/eXlk1NCI62oFfcrU4Yn3P1xmDzZGD/Rh20
X-Google-Smtp-Source: AGHT+IF+182bbS72e3lghIBttelXo0y7zyfZsyZD6i4hXODhAKYAaX0bK9xstuu5/O7fqEeoBsceRg==
X-Received: by 2002:a17:907:d8e:b0:b7c:e4e9:b125 with SMTP id a640c23a62f3a-b7d235c847fmr1751922766b.1.1765969274813;
        Wed, 17 Dec 2025 03:01:14 -0800 (PST)
Received: from f.. (cst-prg-23-145.cust.vodafone.cz. [46.135.23.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f4f5a3csm2073412a12.12.2025.12.17.03.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:01:13 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	clm@meta.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH] fs: touch up symlink clean up in lookup
Date: Wed, 17 Dec 2025 12:01:05 +0100
Message-ID: <20251217110105.2337734-1-mjguzik@gmail.com>
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

The rather misleading drop_links() gets renamed to links_issue_delayed_calls(),
which spells out what it is actually doing.

Finally ->depth zeroing is moved to a place where symlinks are sorted out.

There are no changes in behavior, this however should be less
error-prone going forward.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

this assumes the LOOKUP_CACHED fixup is applied:
https://lore.kernel.org/linux-fsdevel/20251217104854.GU1712166@ZenIV/T/#mff14d1dd88729f40fa94ada8beaa64e0c41097ff

technically the 2 patches could be combined, but I did not want to do it
given the bug

this booted, so it must be fine(tm)

Chris, can you feed this thing into the magic llm? Better yet, is it
something I can use myself? I passed the known buggy patch to gcc
-fanalyze and clang --analyze and neither managed to point out any
issues.

 fs/namei.c | 54 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 69d0aa9ad2a8..af6d111d6ccb 100644
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
@@ -774,6 +774,35 @@ static void drop_links(struct nameidata *nd)
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
+
+	path_put(&nd->path);
+	for (int i = 0; i < nd->depth; i++)
+		path_put(&nd->stack[i].link);
+	if (nd->state & ND_ROOT_GRABBED) {
+		path_put(&nd->root);
+		nd->state &= ~ND_ROOT_GRABBED;
+	}
 	nd->depth = 0;
 }
 
@@ -786,20 +815,11 @@ static void leave_rcu(struct nameidata *nd)
 
 static void terminate_walk(struct nameidata *nd)
 {
-	int depth = nd->depth;
-	if (unlikely(depth))
-		drop_links(nd);
-	if (!(nd->flags & LOOKUP_RCU)) {
-		int i;
-		path_put(&nd->path);
-		for (i = 0; i < depth; i++)
-			path_put(&nd->stack[i].link);
-		if (nd->state & ND_ROOT_GRABBED) {
-			path_put(&nd->root);
-			nd->state &= ~ND_ROOT_GRABBED;
-		}
-	} else {
+	if (nd->flags & LOOKUP_RCU) {
+		links_cleanup_rcu(nd);
 		leave_rcu(nd);
+	} else {
+		links_cleanup_ref(nd);
 	}
 	VFS_BUG_ON(nd->depth);
 	nd->path.mnt = NULL;
@@ -838,7 +858,7 @@ static bool legitimize_links(struct nameidata *nd)
 	for (i = 0; i < nd->depth; i++) {
 		struct saved *last = nd->stack + i;
 		if (unlikely(!legitimize_path(nd, &last->link, last->seq))) {
-			drop_links(nd);
+			links_issue_delayed_calls(nd);
 			nd->depth = i + 1;
 			return false;
 		}
@@ -884,7 +904,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	if (unlikely(nd->flags & LOOKUP_CACHED)) {
-		drop_links(nd);
+		links_cleanup_rcu(nd);
 		goto out1;
 	}
 	if (unlikely(nd->depth && !legitimize_links(nd)))
@@ -923,7 +943,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	if (unlikely(nd->flags & LOOKUP_CACHED)) {
-		drop_links(nd);
+		links_cleanup_rcu(nd);
 		goto out2;
 	}
 	if (unlikely(nd->depth && !legitimize_links(nd)))
-- 
2.48.1


