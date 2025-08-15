Return-Path: <linux-fsdevel+bounces-58059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 108D8B288D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 01:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191AB1CE0B26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 23:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A9E2836B4;
	Fri, 15 Aug 2025 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X0dJv/Sy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43250165F16
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300928; cv=none; b=R4psd7NnFme2vhcuLEtjuVk0oKkDKzS3eMeb5UCHr+DeJHw6n7WVE3pE1F4AgdGJsw/5RjJEqQogFy4GYUZH32L7RI5L5jC8ZcZSmDZArGTz+4ppSTRFowBjwq8QyUwTT/qaKdvZux2GYWCe5vpNLaa8y/86yc8oL1o1P2wEZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300928; c=relaxed/simple;
	bh=WdVIWeIdmT0hO8KTqsc+wuUnoGnkybV38KfBrqrMcW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev6D/6ciV6XXGQGx6VWyXoYiE57/6BGilTZfZnnLLANEGD1rpZBYNcVk3K++Qq5891iXaSFleZ0iSJuChWgcibB7/VXTZ0aA5W7MptTlS+WIjCthlYHmNGSR7wB6qwEvUC6zdF7fBDzl9a7EZT6myR0WSNYgcmF6n+9V/OOkdxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X0dJv/Sy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OGHNBlO/jtH81W6uf2LLopddEg31CLM4tg/wfhFL8WI=; b=X0dJv/SyM/mYROMFQ7R32x/u2r
	lZ1B1Ntjraw+fu8x4nqr8yIK3gXxOvY9Ur0szXPunl8puLZybiZjzUdZDhQajJ5raxg1K+apq/y0n
	7jIC7jLaZOAaWTMPq7G6V+JxQA7Z89zr/xwHqquyz4XapIrSe2BYgc1+e2hcrsWKedrN+tUXEq6J5
	rtrZpjrklWfqPw+bKOZR9F/2eukXc8OSHogBiId3oIJ2RgJa2Z+Mdsg1sP8JAGDhogZmNt1zax8o3
	fEuSueRHNbQKp78ucQwuCe3iS4UqCbtKqDIdWh5Gg4/RCz/MQUh49rXmyUgas7Al4VE8Mj2OFnMNn
	J71ZR3YA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un3xE-00000008u2A-1z6b;
	Fri, 15 Aug 2025 23:35:24 +0000
Date: Sat, 16 Aug 2025 00:35:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@google.com>,
	Pavel Tikhomirov <snorcht@gmail.com>
Subject: [PATCH 3/4] use uniform permission checks for all mount propagation
 changes
Message-ID: <20250815233524.GC2117906@ZenIV>
References: <20250815233316.GS222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815233316.GS222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

do_change_type() and do_set_group() are operating on different
aspects of the same thing - propagation graph.  The latter
asks for mounts involved to be mounted in namespace(s) the caller
has CAP_SYS_ADMIN for.  The former is a mess - originally it
didn't even check that mount *is* mounted.  That got fixed,
but the resulting check turns out to be too strict for userland -
in effect, we check that mount is in our namespace, having already
checked that we have CAP_SYS_ADMIN there.

What we really need (in both cases) is
	* we only touch mounts that are mounted.  Hard requirement,
data corruption if that's get violated.
	* we don't allow to mess with a namespace unless you already
have enough permissions to do so (i.e. CAP_SYS_ADMIN in its userns).

That's an equivalent of what do_set_group() does; let's extract that
into a helper (may_change_propagation()) and use it in both
do_set_group() and do_change_type().

Fixes: 12f147ddd6de "do_change_type(): refuse to operate on unmounted/not ours mounts"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1c97f93d1865..88db58061919 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2859,6 +2859,19 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	return attach_recursive_mnt(mnt, p, mp);
 }
 
+static int may_change_propagation(const struct mount *m)
+{
+        struct mnt_namespace *ns = m->mnt_ns;
+
+	 // it must be mounted in some namespace
+	 if (IS_ERR_OR_NULL(ns))         // is_mounted()
+		 return -EINVAL;
+	 // and the caller must be admin in userns of that namespace
+	 if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		 return -EPERM;
+	 return 0;
+}
+
 /*
  * Sanity check the flags to change_mnt_propagation.
  */
@@ -2895,10 +2908,10 @@ static int do_change_type(struct path *path, int ms_flags)
 		return -EINVAL;
 
 	namespace_lock();
-	if (!check_mnt(mnt)) {
-		err = -EINVAL;
+	err = may_change_propagation(mnt);
+	if (err)
 		goto out_unlock;
-	}
+
 	if (type == MS_SHARED) {
 		err = invent_group_ids(mnt, recurse);
 		if (err)
@@ -3344,18 +3357,11 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 
 	namespace_lock();
 
-	err = -EINVAL;
-	/* To and From must be mounted */
-	if (!is_mounted(&from->mnt))
-		goto out;
-	if (!is_mounted(&to->mnt))
-		goto out;
-
-	err = -EPERM;
-	/* We should be allowed to modify mount namespaces of both mounts */
-	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	err = may_change_propagation(from);
+	if (err)
 		goto out;
-	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	err = may_change_propagation(to);
+	if (err)
 		goto out;
 
 	err = -EINVAL;
-- 
2.47.2


