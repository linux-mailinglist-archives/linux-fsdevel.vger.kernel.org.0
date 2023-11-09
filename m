Return-Path: <linux-fsdevel+bounces-2470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8B57E63B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE4D1C208A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEE9D524;
	Thu,  9 Nov 2023 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Pl4QJn/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72741D2EE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:20:58 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A435C26A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RgKgcB8S6q4z3Pp7qf5GZxR2llbqiOZZmoonjHjc9sA=; b=Pl4QJn/jAg2qPqN5o7dgMUkGB/
	eT8UWSefsHp799UcKZGDL0tyZEKcthIIlYNTRlxcLdPBeLyRmo86g/tubQhLA3Db4CHVaUBDIEeao
	5WbpiYy+9MB30By6Gw4R/yR6obUD4YXOfIyHaIml72YXUTTyrRvJdE0KEKX7O/ilaqTiadZmPRyD1
	ADYrItL8+ZTxwUnP4SAJhz9K/fErwYKbeCL8bFU1qr4chVL1vo3BNZ0KMmr7wgrWRz0gp/gQNz4iF
	XTYvl8hbKt3J8OAHNPg5clCPNhatnnHl7BDEMkUVXidgct6vr6IU3a6MNh4vAf+2BxQ+tsGzK/XAr
	d02gBa1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPQ-00DLj4-0E;
	Thu, 09 Nov 2023 06:20:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 01/22] struct dentry: get rid of randomize_layout idiocy
Date: Thu,  9 Nov 2023 06:20:35 +0000
Message-Id: <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231109061932.GA3181489@ZenIV>
References: <20231109061932.GA3181489@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

This is beyond ridiculous.  There is a reason why that thing is
cacheline-aligned...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/dcache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..8b4ad3c3bba0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -111,7 +111,7 @@ struct dentry {
 		struct hlist_bl_node d_in_lookup_hash;	/* only for in-lookup ones */
 	 	struct rcu_head d_rcu;
 	} d_u;
-} __randomize_layout;
+};
 
 /*
  * dentry->d_lock spinlock nesting subclasses:
-- 
2.39.2


