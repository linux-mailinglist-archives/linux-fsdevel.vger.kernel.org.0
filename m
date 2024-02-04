Return-Path: <linux-fsdevel+bounces-10209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8B848A9B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2371F24787
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9CD10A35;
	Sun,  4 Feb 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F/db2XFg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5D79C1;
	Sun,  4 Feb 2024 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013065; cv=none; b=Vwy8ZQeN1QY14/mF2ln1O8QkCnThr/dIpuSg/bbTTXf9aFnUhxIJ2Wccvl/HoqS73dkJOgtfHG3s2fOQLGfQjRy+eXsgworGdl1ZpfkT0ab0cbQR2XXmfpAb0L83Ta8AqtoPAWDTzOO52o+4zKBBXB3UL0w62SZP8geZzPsK4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013065; c=relaxed/simple;
	bh=y54nHQkPOl359AVYAtuuO+KK5TXGw8vABwwc1x2IPbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQ7u+0tChuGfKcMt0a1YLRZXkQd2YGRj+MVNiV6iJXLiKWdi8nzMbnKSU9lXqS68M6qYbuvl0BQGQ5vCggkvUs2YjvjDZd8+YWIFWlHk+SkA6QiZyWnU29qNmr287ySGizaG2nt6LrbxAwWvVZmRzFitxB1kMquZTs4gqjz3Qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F/db2XFg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cuFhGgNbk5LHRay7zOGcHPlnB60egP7ycJDnEl7eO64=; b=F/db2XFgUPBdiv/ecH+HGw4r7+
	jHgTBCznaicUuHEoLs0TjVoyi0YO4LRxQjgMlEcDleaiOCi/JbMKLglgJ8fC96Hh3AVrcOUKLPVoW
	x3pBPoK+WdflalrUN5AgC7OkMjQqEZmNkZfe21v0PH06RNlJ0LJFtNEtPYp1VnbMplhdRvZlVQEiW
	D0gkE9Tsc7Whe7xRXjuEDKgjhsZubJCyjOhHUpllu0uF8IV7J/5cSEFa1ia2K5HyjOlDBg4E5KWv7
	dVP0/l1+1X1J/XHhT5P2a2p1t4CjzcyMsIrf3fUGxjRhTw8LlhGtnA/t45qG2L6BhyN4KKLvd35Kw
	gbmINdHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4j-004rDo-3C;
	Sun, 04 Feb 2024 02:17:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 13/13] ext4_get_link(): fix breakage in RCU mode
Date: Sun,  4 Feb 2024 02:17:39 +0000
Message-Id: <20240204021739.1157830-13-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

1) errors from ext4_getblk() should not be propagated to caller
unless we are really sure that we would've gotten the same error
in non-RCU pathwalk.
2) we leak buffer_heads if ext4_getblk() is successful, but bh is
not uptodate.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext4/symlink.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 75bf1f88843c..645240cc0229 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -92,10 +92,12 @@ static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
 
 	if (!dentry) {
 		bh = ext4_getblk(NULL, inode, 0, EXT4_GET_BLOCKS_CACHED_NOWAIT);
-		if (IS_ERR(bh))
-			return ERR_CAST(bh);
-		if (!bh || !ext4_buffer_uptodate(bh))
+		if (IS_ERR(bh) || !bh)
 			return ERR_PTR(-ECHILD);
+		if (!ext4_buffer_uptodate(bh)) {
+			brelse(bh);
+			return ERR_PTR(-ECHILD);
+		}
 	} else {
 		bh = ext4_bread(NULL, inode, 0, 0);
 		if (IS_ERR(bh))
-- 
2.39.2


