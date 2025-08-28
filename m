Return-Path: <linux-fsdevel+bounces-59538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904DB3AE00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947801C27E68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618A12DE71B;
	Thu, 28 Aug 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rcP76LsF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823282C2368
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422491; cv=none; b=Y0G1DMq5MzZerijXFYWyWj0wDPAmZpnPpco5r+r9W0unyhvG9rovngCquTHTXeAEJ+7hqeMygM9wljtthSW9e30mvKZwGvsb2sX7xVvK6sBms8MBD7VmqetAHMS2NML/0EVZNhlvDfhx4jcu3g1pZz7weiymh7Lc7yD+FDa6RdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422491; c=relaxed/simple;
	bh=zcUNkirOaHYWSSu5uLsMwyyLx4ngx4/1oFjW2vzLYxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7lbDVnIr3HWrBDWYqQyr23Ywc3xaj8DtzUDuMexY4fgmge+uv0IlYa3q1XajULg24I9xRCGS59mjhdk7zq/koTlfsJnWI6TinW+zOtls0lGWhXEXn2WIIE27H0BVQrC1EjN6OF+VYZthE8CGrjtbyDLiqRa+TYXRBgCaVMcU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rcP76LsF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CX49eUgAQ8rPV0h1nWZdmjbDba7uIuRC0juMV7T1GdQ=; b=rcP76LsF1EpgsakenSIOATvqWm
	X9uHJKmoMgYWCXuLdrknKfefrXkxfEBX4/G3G10CfAhDfduoGayEK3G7rQslxaC3vzG/i/V44swVS
	XfwTXmLS3s+kzlN/xljiK6Xx2mnOHhqLfi9Le0f+kl79juLyWdZt3mbuWvBq7EdZbFUaLAH6VA9aV
	hSr4695h6rTPfhKQ/CywS6XSD/PJiP1Q7te4Tr67u7gYZ7tHrKk2Ue5iSDq7imoR3CgHj6EfIf7wc
	RZ98aGwPRLSyeeFbAPLd05obqqKUXxTb2e8Qa8vYs/OyiPTIPDLau3vrXkwxO5jR32xMUmZl5sqc+
	y8e6pfVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlix-0000000F20r-0Ok8;
	Thu, 28 Aug 2025 23:08:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 03/63] fs/namespace.c: allow to drop vfsmount references via __free(mntput)
Date: Fri, 29 Aug 2025 00:07:06 +0100
Message-ID: <20250828230806.3582485-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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


