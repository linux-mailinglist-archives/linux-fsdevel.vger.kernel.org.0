Return-Path: <linux-fsdevel+bounces-60089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2195B413F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C760560EFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650842D9EE4;
	Wed,  3 Sep 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X6XL7bM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EAD2D876B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875349; cv=none; b=Uctjv4+MDzk6aGoRlVXVWaaCZ1hL+VNte1tCTktEXr1gHywYirCRNO/mMkBTVJseBgC8wtQOe7QfB6dw8sCu7pKu7JARDU5eBWkvAen2zcbBZzIQslvpZhSMDDG/OZ6ICl5iDN1aRFO8mt7BLhSQM99sShaRigtWB6IIphWXgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875349; c=relaxed/simple;
	bh=t5BIqfq4FxWTsx98hb7CpNXnFqKhXsriTbCdQLJQOO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgIrnav2M8hk4pcahk9WNrvjUyLlb1eN893mdwen6r7Vt5HFJnFbPwbQqnb/eam/vSVdi1GTLQlGvIOazyuk5o1kTFsL86/4gFSMXTn8TBOg6agKC1enVwgs1qw9/xaBuCtKOrCuTfNVU6KRqWtigvxDeJjjLTJldWXGHiG12K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X6XL7bM6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8mwyOx4na8Bsg3WPAt1z0RiP2cEEQkTd81HUkkfxdL4=; b=X6XL7bM6YDDvNlkOLjcj72peDf
	73cknbmuSALa310iq3jWghTHkPeGdiBa4qXUminjn4zW0Y9I1TSB+lqScXfGrOx3suL76bvRTrH2J
	YWK3N0uvXL7pS4IIMZZgOHSp0iLbCjyhEwtvvu8U+QKXiTrgP9Q4rJSOn4e9V8vUuLC1eVFX9auxQ
	JySYKqanm7I+BT+g+eeXBiy5Zpj2nbzDyvTl1hwxdVl2Z+jDIaU6rZ/Swdey79qTy/9ZnVABrgAdM
	KwCR6ryCNdSiT3u4cV3vKUh9XBbMBpxOymuWo3+cisJgBEupTsYWOng88MyIPttqEKaAANyc16lej
	gYrrWfXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX8-0000000ApE8-2MW3;
	Wed, 03 Sep 2025 04:55:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 47/65] path_umount(): constify struct path argument
Date: Wed,  3 Sep 2025 05:55:09 +0100
Message-ID: <20250903045537.2579614-48-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h  | 2 +-
 fs/namespace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index fe88563b4822..549e6bd453b0 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -86,7 +86,7 @@ extern bool may_mount(void);
 
 int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
-int path_umount(struct path *path, int flags);
+int path_umount(const struct path *path, int flags);
 
 int show_path(struct seq_file *m, struct dentry *root);
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 4ed3d16534bb..20c409852f6d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2084,7 +2084,7 @@ static int can_umount(const struct path *path, int flags)
 }
 
 // caller is responsible for flags being sane
-int path_umount(struct path *path, int flags)
+int path_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
 	int ret;
-- 
2.47.2


