Return-Path: <linux-fsdevel+bounces-60045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1656AB413BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63040188B5A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEAE2D5930;
	Wed,  3 Sep 2025 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NJa/jsRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8642D4814
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875342; cv=none; b=jnpD12cDm94CJjwvYi8WD07Wm6POmFxzQIBk9KS6AMB5pj+CjH+NKFw6B4HKzOuHINBnnjqQlPixG0EXNHAmFgaMH7HWr/F4h2RwAVcDyr9mvD9NpRYJ/TmwVBpmesNfcg6/0lixCZJM8ZquqGPd8NF7TQT1sLLFxmnJvqXGTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875342; c=relaxed/simple;
	bh=zcUNkirOaHYWSSu5uLsMwyyLx4ngx4/1oFjW2vzLYxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGHzZVq728hVJozwQAbq+oeH6n63bgifCycp3Ctx5iHPwhFjbHaHok5zvDyv6CultH7jwfxW5WDpCGRzyF5Ax0aSfwmqopNOmheWIwZjrfSgAcPePurAVJFZK04rTI9V5yeJQEXBEz0Z+jf0DpLv0sAtcZa7iv4h2gZxHnSjVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NJa/jsRA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CX49eUgAQ8rPV0h1nWZdmjbDba7uIuRC0juMV7T1GdQ=; b=NJa/jsRAEeae7xsyZ5owGJ1xpz
	5pkzCnXXDHNPHEK3fTQL4sRCDRa2Xbk0tONb8A2FZ7hscr1Sh66j/i8IUKvxPhRqNDN+fVigfP18I
	2G5x+IrLRWRmcYCaGDoWOCTI89Zz0tegyHIgBr929+qIT7Xu00yP9UGPM+OHklb48kpRd3pkkf83A
	Rc9dllg2JJMUkmHyU2abErl8FHYeNolKyh2Xk1HNH98ZHc2pI6zR2Ylb+IqzhQrmqXAUNwG/ld0mM
	MDcfaC6CHFq6Kcm9pXyhsDBG8VkLjdeilOUykXf8vjzY06D8CQJLnTYOheoIHnT5BcR+ET9vQkdZ5
	v3OYoliA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX0-0000000Ap5Z-3bj1;
	Wed, 03 Sep 2025 04:55:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 03/65] fs/namespace.c: allow to drop vfsmount references via __free(mntput)
Date: Wed,  3 Sep 2025 05:54:24 +0100
Message-ID: <20250903045537.2579614-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Note that just as path_put, it should never be done in scope of
namespace_sem, be it shared or exclusive.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index fcea65587ff9..767ab751ee2a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -88,6 +88,8 @@ DEFINE_LOCK_GUARD_0(namespace_excl, namespace_lock(), namespace_unlock())
 DEFINE_LOCK_GUARD_0(namespace_shared, down_read(&namespace_sem),
 				      up_read(&namespace_sem))
 
+DEFINE_FREE(mntput, struct vfsmount *, if (!IS_ERR(_T)) mntput(_T))
+
 #ifdef CONFIG_FSNOTIFY
 LIST_HEAD(notify_list); /* protected by namespace_sem */
 #endif
-- 
2.47.2


