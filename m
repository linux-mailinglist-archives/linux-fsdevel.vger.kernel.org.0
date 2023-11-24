Return-Path: <linux-fsdevel+bounces-3605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF07F6BF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D201F20F54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D735A94F;
	Fri, 24 Nov 2023 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t84e8Fxe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC55B10C8;
	Thu, 23 Nov 2023 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OhCzST4Viql9jwYwDDeDZI5/cnICIyfnJcJBswRqBMo=; b=t84e8FxetnlLzWy6Ty94DCvdp+
	V+lOFj3AjZZCzxAAB+FbLC5E7PoA1tyT2Himsg0ubdZrmaued/gFs8XQ7m90MyynxiIifH8ism8yU
	eeqc0tw2fyWrC3fa+/3a8wVXuqm929QwW99VDKHNj2DgawwS503lweZLdhrQrgADV0QZRvdanKhvm
	6YpA7633x3LGyEB/j4VWDX87FJR7uTJtGN3yM0rUR8yiKg0AwLTBTBLdGe3fBlIf5QUvXQHDFoMrI
	IvkDn3KWOrqm0Ix3rsp4AwY8FASYrTTYfWeWC+ayNe9q2V8ij3ELqc/Y1u1wR+jR+rt2fHW2q8ct+
	hWI6DAtA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PId-002PuB-1w;
	Fri, 24 Nov 2023 06:04:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/21] fast_dput(): new rules for refcount
Date: Fri, 24 Nov 2023 06:04:09 +0000
Message-Id: <20231124060422.576198-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

By now there is only one place in entire fast_dput() where we return
false; that happens after refcount had been decremented and found (under
->d_lock) to be zero.  In that case, just prior to returning false to
caller, fast_dput() forcibly changes the refcount from 0 to 1.

Lift that resetting refcount to 1 into the callers; later in the series
it will be massaged out of existence.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9edabc7e2e64..a00e9ba22480 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -847,13 +847,6 @@ static inline bool fast_dput(struct dentry *dentry)
 		spin_unlock(&dentry->d_lock);
 		return true;
 	}
-
-	/*
-	 * Re-get the reference we optimistically dropped. We hold the
-	 * lock, and we just tested that it was zero, so we can just
-	 * set it to 1.
-	 */
-	dentry->d_lockref.count = 1;
 	return false;
 }
 
@@ -896,6 +889,7 @@ void dput(struct dentry *dentry)
 		}
 
 		/* Slow case: now with the dentry lock held */
+		dentry->d_lockref.count = 1;
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
@@ -930,6 +924,7 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 		return;
 	}
 	rcu_read_unlock();
+	dentry->d_lockref.count = 1;
 	if (!retain_dentry(dentry))
 		__dput_to_list(dentry, list);
 	spin_unlock(&dentry->d_lock);
-- 
2.39.2


