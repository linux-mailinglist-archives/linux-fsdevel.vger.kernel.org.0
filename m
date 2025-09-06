Return-Path: <linux-fsdevel+bounces-60420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3015BB46A89
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E929916C9E5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FDF29BDA1;
	Sat,  6 Sep 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KoG6R3FI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DF19DF62
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149901; cv=none; b=t/wEIorGzo6YAAF422zYVanFShHrV8N63VCrpkcaTFXq7iGygjMSrYpUtSvAcmyCVsuU/fpupk5MJCdrClxgwvKA6a3l0bZNMDaC9EAN8bhILHlPu4V6YJmfMy00SZ2mEfDjuAKsRJUi+AdIhzJ9KQ431OyHfJVN/M5A/+ObKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149901; c=relaxed/simple;
	bh=MFU0SoFNf2XFWhz6KchMsDTVaWQzTklKVZ3yKtvuP54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSvgizE6LwhYzUQ/Rx/DFXnTxAzYgXZX0r+ZzmcbHquZ0WdKZv+NGiXl0HqiaqxAVA7JM3Vb4/s2oquYfvOb/hpHPIHNQEpTWwFIYHqnA+MnPeyEDXIO1Wdb/d7eJltZ3wtwoAHS1ZZqdFQbAhOSntYCi8vUuQ5UixPmhdd64MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KoG6R3FI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sMdr6gJck23zexw/EzRpOFLwYzSNvZC4w4fTsTah2KE=; b=KoG6R3FIbuEqRTzJz7W1mVigmk
	tqlj8tVCS5znzbMIvQUKh1KxWm88z1emJxJy9/nsybJkrK3FbL1Iu1a7Uf/PCD+u6RtzI/u9biOzz
	uXxG7D/6U7Cf2JG8sVsNaW5HwaXHRx4oo8lCsWFIYJwWLLUDdcIKfCbnbOtCDw8SPu84Me1eWMq6j
	Gp14/H9btuLqR61jOVrTrK1sRGfckv4eWAlf3r2g2ZEuK7L3SlHHL1P5yOq5VwuWYuhLoJYQEp0cG
	u4y0vmz+VQgfL6AxKv5+fgFTRtG7Jz74kU7Kp605aVdaK9qO8+A3XX0cEQkPbkOjH4mvWOxnb7ibu
	Hub/MjSA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxO-00000000Ora-1J90;
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
Subject: [PATCH 03/21] filename_lookup(): constify root argument
Date: Sat,  6 Sep 2025 10:11:19 +0100
Message-ID: <20250906091137.95554-3-viro@zeniv.linux.org.uk>
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
 fs/internal.h | 2 +-
 fs/namei.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 38e8aab27bbd..d7c86d9d94b9 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -53,7 +53,7 @@ extern int finish_clean_context(struct fs_context *fc);
  * namei.c
  */
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
-			   struct path *path, struct path *root);
+			   struct path *path, const struct path *root);
 int do_rmdir(int dfd, struct filename *name);
 int do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct mnt_idmap *idmap, const struct path *link);
diff --git a/fs/namei.c b/fs/namei.c
index cd43ff89fbaa..869976213b0c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2673,7 +2673,7 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 }
 
 int filename_lookup(int dfd, struct filename *name, unsigned flags,
-		    struct path *path, struct path *root)
+		    struct path *path, const struct path *root)
 {
 	int retval;
 	struct nameidata nd;
-- 
2.47.2


