Return-Path: <linux-fsdevel+bounces-2480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9C07E63BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C432B1F213CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D0A107A4;
	Thu,  9 Nov 2023 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cNjrZxV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CFDDDE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:02 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A326B8
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3cl5MKfhULG7RS/Qf2JbkQO/cYoFke0EzEUpfuhtBiA=; b=cNjrZxV/eogdD/5GTYIlgm0P5N
	hpbsw/GtF7hXrkfN9GGEFanFEoF9+5UbATnN54K+J0jCFBU5b9W56eK5pnzoQzkGx+6CsKOPMJ/ya
	jleOTu9KrI/RIl6kZPjX+yPj9JnMRjrKS++jcz5KE+KmehsntGCxky7RpZ2WLPGa2wXehXZRmbMY2
	1jSseMePwhEizDsfAPGOFzBFdfv7wGXAYu4dVYP7ZoXoT+QyCi6YeRnRJQ6iWC9M1NymxF4P9lnAo
	IehEHlOYTUP3uSt8t/5HvMqQKrzyiWzaTzeWifip0Ugs1M5dsxzY4CGDttdlohyuUHZsheyWS4e+n
	rtzfJF3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPR-00DLjo-2O;
	Thu, 09 Nov 2023 06:20:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 10/22] fast_dput(): new rules for refcount
Date: Thu,  9 Nov 2023 06:20:44 +0000
Message-Id: <20231109062056.3181775-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently the "need caller to do more work" path in fast_dput()
has refcount decremented, then, with ->d_lock held and
refcount verified to have reached 0 fast_dput() forcibly resets
the refcount to 1.

Move that resetting refcount to 1 into the callers; later in
the series it will be massaged out of existence.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e02b3c81bc02..9a3eeee02500 100644
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


