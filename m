Return-Path: <linux-fsdevel+bounces-60085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC43B413EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260511BA1278
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE32D2D978C;
	Wed,  3 Sep 2025 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mNp38J/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9C2D8367
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875349; cv=none; b=OxL6sQXhQVLJyi2PeBHjveSFLiIOYjWO4M5NLZB9rwhsktnNFkgK3y/ShoUkwD65I8iW9EWYbX5W6dc7YuPT5SvkhmrXgCVwUZd4QRvCfLcerPzTxiY+SXG5/9zE6Ma7fvPSdwBg821rfBlNNtXTnv2cVvoc7MSzgwPV4FY1VJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875349; c=relaxed/simple;
	bh=pjrBjtGLTkZYTuRCB1qxZiPK+TL0ApQxoBmR0jKky2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSHYOZk3hyFhjhAkx56O+5/yQMzEk9MnLfD57Ka7OSDNjfhS04mHSHko3GTJatPRe+Zw3H65reW+oq6WrZhZdS/8fGmwTg3mJjGIC4gs1S+mP+avXMe5Z9nGMePYhCovMbulLv+3ob5MWMwpGYl1XVhkTzVyK172xhYSdUeJjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mNp38J/X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=x6vDKKLC76TR+ipAgtoaYxMcOWAXekAiRxF7mC+sGkA=; b=mNp38J/X6x9R1U/cKuW2mplkff
	bW2sG39MTDO9NaGO8rGcVsTD5HuFFz4/jZQtDmWomGc9CJwoOl+oRfG9lUbAcW09za2CxeGqTA0wc
	7MomG6YNvPOtI2wzJqfEW0jcSmvnnSEozmqJpyk/prS8UBp2rMIBWjiFtfXeBxtp0bsiZSpQSnZih
	BvfZE5+sej+JdJ8ptedsw6Fx6Rn2Z31NHZxxBxnTBznhavj0XDo7+zGeUxQHxEB0nh7zvCWHh1iAV
	CTCs3c/4IhSwPhjy+o+N3eyAjSsxt5hbk7t4p2wB2+6WibxmQPbRRjlbFvQvTYRMx8XrDIQSXGZ/e
	5vkApwcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX7-0000000ApD5-2juL;
	Wed, 03 Sep 2025 04:55:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 42/65] mnt_warn_timestamp_expiry(): constify struct path argument
Date: Wed,  3 Sep 2025 05:55:04 +0100
Message-ID: <20250903045537.2579614-43-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index dcaf50e920af..be3aecc5a9c0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3230,7 +3230,8 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 	touch_mnt_namespace(mnt->mnt_ns);
 }
 
-static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
+static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
+				      struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
 
-- 
2.47.2


