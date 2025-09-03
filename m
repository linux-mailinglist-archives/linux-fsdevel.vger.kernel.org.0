Return-Path: <linux-fsdevel+bounces-60053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698CBB413D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AADA68130E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230872D7385;
	Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kOf3DZlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5A2D4B73
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875343; cv=none; b=o3vX8ZYjag8UjnYPZb7RF30Siwb+HXJ35KoUQEXN1y3xAARggLs3zNImUTko0Zp1NIVk2euYR+Ga1A0Rw5jnY1gMc6n9J5IjSN1wPh18yPaTvbhnBpL6D7AD5FicX+jeEl4ePH2CzwAwWJLlbIFM9sw96OBrO8/gGAoGpiTftR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875343; c=relaxed/simple;
	bh=2loXYegU2u96gTRiIsgrQA+nW17AII9VuUJ7dp9aAJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjhPFnt677O+dtsC5ItlDcRTSh3pC4naPqeHLH0JJIbYC57pHweLaQ1hpsKkyAjxnOoKZFpZzGZAShP5qVnVS5DJGinx6xQ6Oz7Dz80OLq4XPLdxrn+yguLYW761mfk24mM55gc468jbdOlEgczkd8oJrB8HTi4csim4erTnHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kOf3DZlR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ezq+XaAJGAmhgSNAz20IZtNNgA0qqI4IoUCbSaIoPAk=; b=kOf3DZlRahAZqFyy4HdWCS19aL
	xw2Pcby4heQy95AGykGsb1d4lmuDRl6W35ro/QheoEuYk0mlRTWL8D9UiDcGaUg0fZEB11u9xIkrl
	lUZie1tdaJZYvrPXZSt9NERWULsu7Ayg7S4cUSY3Y5oJet7bJBlbs3a0VLzrrPTXpdit47HJfKpHk
	65fM6+/5uwM0LPcgdg46SrXBvoyjgONxJ7BYY/hfBJ6GC8CAGzFU7B0Z6FmvgUKquHx3zBL7vMX3z
	YA3I9aianKAe85TD0G5/GddrIwXJqcy53SHE/yxGOHvbQb1EP0uRPA4I++25foaUItcP5ZjINtW9P
	87d6sRsA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX2-0000000Ap7V-2DFO;
	Wed, 03 Sep 2025 04:55:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 14/65] mnt_set_expiry(): use guards
Date: Wed,  3 Sep 2025 05:54:35 +0100
Message-ID: <20250903045537.2579614-14-viro@zeniv.linux.org.uk>
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

The reason why it needs only mount_locked_reader is that there's no lockless
accesses of expiry lists.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2cb3cb8307ca..db25c81d7f68 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3858,9 +3858,8 @@ int finish_automount(struct vfsmount *m, const struct path *path)
  */
 void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list)
 {
-	read_seqlock_excl(&mount_lock);
+	guard(mount_locked_reader)();
 	list_add_tail(&real_mount(mnt)->mnt_expire, expiry_list);
-	read_sequnlock_excl(&mount_lock);
 }
 EXPORT_SYMBOL(mnt_set_expiry);
 
-- 
2.47.2


