Return-Path: <linux-fsdevel+bounces-60421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F0BB46A8A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37902A62216
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F452BE04F;
	Sat,  6 Sep 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aJHoe+qU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B241B87E8
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149902; cv=none; b=kWSp/6XADe6eDAiMlQeJ1MFtIkqMXeGijI0DVvE89wA5GZMHYbwVTxHZYt/4bhTiOdwOZ0+LQdrndGHq4tNO8npx2e5G0na3YdmKikbrFAjZbbbusyDqokYFhh0auzAWiuvv9+TgM/SU96kxgqSVK01SmjlQqV7R0CgBiinRiuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149902; c=relaxed/simple;
	bh=Cr55plnApq1eek16FubntkXrwr1BaK2Y02+Jx5dkTWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajE8hVDRUNYxeRPXVmQaeXb+pdCH37UzfjTvz5m/7VGI68J9vbC//qzH6rQaShXmAOSdrvwsY4EUEMPQj90E24+qXRcyh8JRRXbvq+CpVAXWFh2q59IHUqYQdD4wp7CtbqxKXiRolpDjzn7dvpeZWQfv/VtMBdVPIztx0e7aPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aJHoe+qU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2lIet6biJrfdVf0zMFSAyd8UJEvIL7oFFkl5uqvpC54=; b=aJHoe+qUm7LSOPPOOKOavF+lF/
	SHCUPhKqZq1cAZtmxXRIXl7OMsAlflf4CGIZDat09N6QyU5Y7d/d2TmknqT7RZMRGZYWTyEE+TmBc
	ULXwojyPUkKxqzsX+NYbsI1OR53/GXyZB02x6owy23y8ER/mcQcI0sBKco2CY9emVVzkVU9JQDs2L
	DyLcbu8vVyXpmJD7woZl3xKfwvusGSWiiLsv57j3NapZ+Wek80Wl9hoK98kBB+IjT1R34B3C9LV0h
	/QjVUgwHTQb+rbythgA4OSai9yvgq2hX4J54NP/FWl/dSh4iAOd0Q3tPGzGLImSZRB2x26CH2/54n
	yu5u6o9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxO-00000000Orh-1zgc;
	Sat, 06 Sep 2025 09:11:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 04/21] done_path_create(): constify path argument
Date: Sat,  6 Sep 2025 10:11:20 +0100
Message-ID: <20250906091137.95554-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c            | 2 +-
 include/linux/namei.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 869976213b0c..3eb0408e3400 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4170,7 +4170,7 @@ struct dentry *kern_path_create(int dfd, const char *pathname,
 }
 EXPORT_SYMBOL(kern_path_create);
 
-void done_path_create(struct path *path, struct dentry *dentry)
+void done_path_create(const struct path *path, struct dentry *dentry)
 {
 	if (!IS_ERR(dentry))
 		dput(dentry);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..75c0b665fbd4 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -60,7 +60,7 @@ extern int kern_path(const char *, unsigned, struct path *);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
-extern void done_path_create(struct path *, struct dentry *);
+extern void done_path_create(const struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
 extern struct dentry *kern_path_locked_negative(const char *, struct path *);
 extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
-- 
2.47.2


