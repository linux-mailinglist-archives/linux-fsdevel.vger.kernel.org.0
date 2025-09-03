Return-Path: <linux-fsdevel+bounces-60073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37959B413E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A238868163B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24162D8398;
	Wed,  3 Sep 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YPQB1RIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DF12D6E6C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875346; cv=none; b=MXINeRmtKs4wQ2/P/+lJDDjb1cd/FdzOiN4dVeBbfUiggqbVJBlIPx1i4ltqpK5/+on2Y8YKGf7Fg42KNaxjIDW3HvA8SpYN+PQnq8YnZSoCaWZ8W4zbhRKlB9fMZXlPjP6lpjInt5R6P3e9lBLtjS4xgE3njprfM9ER3X2hG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875346; c=relaxed/simple;
	bh=H4AIBUJWccNMfsNKYTD9xpUSUlBUzzyndF/mCFOTCps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1HzQ4m1Uw+alN/yrLUaD00aE1+iir+nxDzQPT9+UHtNr6Zfss7CNJDeUgvSJs0oE8hAEdutd0arWqxNA5sB1nhUfAUAHuGSaHo7dIJNJP5RxSF4ePQ2llD+QvaDIhCT86oq+XZsXL51TPcGfVGTjeZmhJtqidhI3zpNJfzzgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YPQB1RIv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7aFzT3QTHRmIxTLhfqXahCEHYiv+uWzil6OTws3nH0g=; b=YPQB1RIv3FOZoHDyjwBM/BPYXN
	3HjqXOLupye1EFrtITfgh3TLFFz7vWp49vZBG/YMFe3JBYGXasX+DzLwfrwy+ZBKMfM+zM0/vwT5q
	QzZetkYdGJPZ56jmeuXtbDTagRTL9dYUEq3pbuPf2pyY6mXg+LsgecLkB3VAyylA+b5ko6CvYA35s
	TBnV3R/tdPZOMii/TZomBzVEm/xD1I77JOVn0SSdseAhrS5aHSAUYb5fePriUKNo4ORGVQoe3mHim
	3KCKgTrTq2Xt+G7HdxyD7E9K5GlRA8N9zMd2WU8GBNUVikQmgkKC8o5p6uRa8ubA8OUx+oD67Oa+A
	trvM5qQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX5-0000000ApAs-25mP;
	Wed, 03 Sep 2025 04:55:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 32/65] pivot_root(2): use old_mp.mp->m_dentry instead of old.dentry
Date: Wed,  3 Sep 2025 05:54:54 +0100
Message-ID: <20250903045537.2579614-33-viro@zeniv.linux.org.uk>
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


