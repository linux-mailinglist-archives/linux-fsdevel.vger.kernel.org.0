Return-Path: <linux-fsdevel+bounces-59560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308E9B3AE1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D568A98857A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE02F3C01;
	Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gFCSJ4Zx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852372D0621
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422494; cv=none; b=fgoHIe9gzKYRFtiF7kBZhb9E+hp+uC8Bl8jeW+AUolfTM7ZJ2KHLlNlN7xoCYDbl0KFe66Ribw+p44I6BrXimlqwilyumHz62NINlZuM9coIltstg0bbif6ZCsJSkGyd8kLDplrayh77fLrMhC8T31SfSKoY+LsolZCWs+qHiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422494; c=relaxed/simple;
	bh=H4AIBUJWccNMfsNKYTD9xpUSUlBUzzyndF/mCFOTCps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7VgiXDE4Y4477jvjdhYPtCvXWcFv5jRP1roPp37ipyzKgBXqQFVRV00N+LdQVdipBPwubMS2EEN07XjxuRjFNUBFy+koZd6+6KQhdYNLcwX5NPFKJ07mzw9R2Hp8swSzOZT4SrXPWw4nDQdomfBPcGK+ksfo+SycyfrlohZdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gFCSJ4Zx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7aFzT3QTHRmIxTLhfqXahCEHYiv+uWzil6OTws3nH0g=; b=gFCSJ4Zxx/5PxhEWIkm0RG/Ddr
	vJBsQK/4a/+8qRTtCwZ0IWoZEFfl3Wb49d3t2e+lcs+eZx2CgIoV30L7XEcREVJyNdaeHj/Iiyd+G
	98+tn5ETKr+Rcfo/5DhJLEdeymt7Pfp0j2U22PMy0lluF/6pMqho+nZsDa3vuggYldqt5pZQikO3q
	UZtRBoGWL6+q3Yx2oykMiHNxxsTtHmDwYKKJL9lkJ5cMJMbZjfBcG2ePiSALe9OF0hLxqnbS+0uh0
	EPKiaUqmYRUVy75/TQMh/SNapCVcTXA9MhMNz4y9L5NqVL24sW5gQdGeGrrvQrhyQ9PIMF1mYAWIn
	0sWgBxiw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj1-0000000F25q-05rw;
	Thu, 28 Aug 2025 23:08:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 32/63] pivot_root(2): use old_mp.mp->m_dentry instead of old.dentry
Date: Fri, 29 Aug 2025 00:07:35 +0100
Message-ID: <20250828230806.3582485-32-viro@zeniv.linux.org.uk>
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

That kills the last place where callers of lock_mount(path, &mp)
used path->dentry.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 18d6ad0f4f76..02bc5294071a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4675,7 +4675,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	if (!mnt_has_parent(new_mnt))
 		return -EINVAL; /* absolute root */
 	/* make sure we can reach put_old from new_root */
-	if (!is_path_reachable(old_mnt, old.dentry, &new))
+	if (!is_path_reachable(old_mnt, old_mp.mp->m_dentry, &new))
 		return -EINVAL;
 	/* make certain new is below the root */
 	if (!is_path_reachable(new_mnt, new.dentry, &root))
-- 
2.47.2


