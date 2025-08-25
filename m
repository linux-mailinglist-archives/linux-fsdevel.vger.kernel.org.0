Return-Path: <linux-fsdevel+bounces-58912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C8B33574
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97A417BC67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F5D27E077;
	Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L21LcCgG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1C267B90
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097040; cv=none; b=Sr2xtxbcIpbRtODVbg4xAoAQx6b5CzjG2JwxZSkfOe6epiX2YVWhcrWaxJKHkDDBO1p4/akCYO7/upXgMBLWuL12F32ckhtq/he1sUZZRt2ZgHq8xdCjRHDhR7aZ4JOaQp8v3wZtbKC/vO4qHVyHUDuKzY1AjMes6I13uTv/fto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097040; c=relaxed/simple;
	bh=mxOGBOBuUVOpCKPcq38nMKpBNIGuL7wDlbdb5baDTPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+IDgE7dIx3cBQ6FQtHke4IqzoVYrevXqhy30rRJ85boJ9yZRJsJziDBKw7UNDEGhifwAueWB93e0uc6YVw5Qa8uKPXQHCRI8Qtz8CV/fet4NA/+mL3/eA536m43zB7H/quJsO1SwJhU3zTSeTgivKOMbUm5cyRbkCKpktCRil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=L21LcCgG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VJ2v79Xm/eY/P9kRaIoUayWkTGTjhtFTscGGlAGXc7M=; b=L21LcCgGTo+34yN3BKe2oEXxT/
	dcxo58D5Uxc5Uaj2cuP8/XEv3N1WaNGC8Eaxv7R6sy5lMEIS4F6F4Q0PZ9UCSxapCRr73LgKyvjFR
	eCtqmJByi/SBZ+wQxMD8pMnttz6jZz1qccEEL1Ybp8wLeEn70hF2mkE0N2KE8SKOqgbhFDuySYXGZ
	Onswp2q6WxpVCX8GWAZ7VjWn9IFAzREO3jVfTwxCkFcTsZTN4ziuaju75xAmp8s4KcvXDvSXw8PJI
	fQt+QDJjZVmVegWObxtvRdU3ArzBxUIyAN8H2HC48xOavJnJPAVoDHqEqnQMI4T4Dj7qHbSDTwZzM
	+I+SeFTg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3l-00000006T9y-0exS;
	Mon, 25 Aug 2025 04:43:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 13/52] has_locked_children(): use guards
Date: Mon, 25 Aug 2025 05:43:16 +0100
Message-ID: <20250825044355.1541941-13-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and document the locking requirements of __has_locked_children()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 59948cbf9c47..eabb0d996c6a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2373,6 +2373,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
 	}
 }
 
+/* locks: namespace_shared && pinned(mnt) || mount_locked_reader */
 static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
 	struct mount *child;
@@ -2389,12 +2390,8 @@ static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 
 bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
-	bool res;
-
-	read_seqlock_excl(&mount_lock);
-	res = __has_locked_children(mnt, dentry);
-	read_sequnlock_excl(&mount_lock);
-	return res;
+	scoped_guard(mount_locked_reader)
+		return __has_locked_children(mnt, dentry);
 }
 
 /*
-- 
2.47.2


