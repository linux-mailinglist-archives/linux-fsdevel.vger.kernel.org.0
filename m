Return-Path: <linux-fsdevel+bounces-12258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E16785D709
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 12:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106C3284721
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B7145BF9;
	Wed, 21 Feb 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SwDKR5W6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADE41202
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515130; cv=none; b=MQFOFGdVsam/84EjP3bDAnvLt3L8jgjwmdSyp9g5dbr0mfEPcuOX48lQ4PKY2yXmMUxXHjFnZOg/T84t0PNYq1QpDsOBlQghaFg6o51P7Vs53TBss5xjcqozir/CU3ne4fVZXRB8BUdykV8lnP53Szy9tDW4iUNSvNbsRH9fHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515130; c=relaxed/simple;
	bh=oAaruXt9/L2edQoj9oPD9o+AABk50Qz8WT4nx4OGXS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlJO/Xujjc8FVYaCqdKNYlbw45601V+iL+ny2Uatbu9PiAyrhNVCDerS/f7b4z8slAl5ob25rmhmYGdw1IWt9pdLQEIQoryKP1Kn6FpoxWanBnu0S3cheMP8344rWh1BWEFCJxcuuG/nuM5LG4pEIblMCKbhFfezsNqMclVy3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SwDKR5W6; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id B368A62BE8
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 14:24:02 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:291a:0:640:791e:0])
	by forward101c.mail.yandex.net (Yandex) with ESMTPS id A72BD60B23;
	Wed, 21 Feb 2024 14:23:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rNQqDK0oH4Y0-0zdDuOL6;
	Wed, 21 Feb 2024 14:23:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1708514634; bh=BOwv8+xbZuZsqevA//KsZuBEgz+mAYKmPvHp725XwLg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=SwDKR5W6m8LbMF5vQ1U6fwLx3TkPp5lsHnDbUOG5AYdxs+wG4lQIDvo/p4/fdkhVY
	 wdltPY8vHXSpYLvOGv+RjbtwshViXJ+XsnIhURtxxJCqFwWonwp0CyvbWeUIL156+M
	 ijjQrVy4yPWTFYBkIXDVr3iDivBA/XWdMnGPHo/A=
Authentication-Results: mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] dcache: prefer kfree()/kfree_rcu() in dentry_free()
Date: Wed, 21 Feb 2024 14:22:04 +0300
Message-ID: <20240221112205.48389-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'dentry_free()', prefer plain 'kfree()' and 'kfree_rcu()' over
'call_rcu()' with dummy '__d_free()' callback. This follows commit
878c391f74d6 ("fs: prefer kfree_rcu() in fasync_remove_entry()")
and should not be backported to stable as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/dcache.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b813528fb147..18770fe4ac10 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -290,13 +290,6 @@ static inline struct external_name *external_name(struct dentry *dentry)
 	return container_of(dentry->d_name.name, struct external_name, name[0]);
 }
 
-static void __d_free(struct rcu_head *head)
-{
-	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
-
-	kmem_cache_free(dentry_cache, dentry); 
-}
-
 static void __d_free_external(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
@@ -371,9 +364,9 @@ static void dentry_free(struct dentry *dentry)
 	}
 	/* if dentry was never visible to RCU, immediate free is OK */
 	if (dentry->d_flags & DCACHE_NORCU)
-		__d_free(&dentry->d_u.d_rcu);
+		kfree(dentry);
 	else
-		call_rcu(&dentry->d_u.d_rcu, __d_free);
+		kfree_rcu(dentry, d_u.d_rcu);
 }
 
 /*
-- 
2.43.2


