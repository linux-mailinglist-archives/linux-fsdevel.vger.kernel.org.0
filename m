Return-Path: <linux-fsdevel+bounces-2647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A31D17E73B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337A9B21237
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD3638DD9;
	Thu,  9 Nov 2023 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vZlLtyqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260038DF0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:38:21 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2103C3D;
	Thu,  9 Nov 2023 13:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FsLOXpYyzFGJvMDs+SWO8R+4g522I7OBFFoDx/3n4iY=;
	t=1699565901; x=1700775501; b=vZlLtyqIDj5duKA94ALT7y+Ns0paq19XWTcyqOijEAu8W2S
	y+JXON4phpgqgTruwZ8whIlgRs2i4eV7DzPlG1l68I9b2OYmAvnvXCLDY/4WVP4NpPAeLr0nhNea/
	WSEKR/eia4v3U83RCinmH4q+zYeS8GQ7xgWxLakuPIG1eTSTpmjl1EBLQY35Szzeqz5EtbnIpsg/1
	a4w4YSJybxmFRnoExexriqXMM3YeS6snGYQpWbxwT6jqeTOB4VMb3lfWX5fYb3DufVDsLRwGLbRn5
	uXRr8PpuYI9jwLa3HMT0LD5E2BwrF38reACT+DGbzv6fqtkTlpF/2KjxZTf7tWwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1CjC-00000001znF-0g58;
	Thu, 09 Nov 2023 22:38:18 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolai Stange <nicstange@gmail.com>,
	Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 2/6] debugfs: annotate debugfs handlers vs. removal with lockdep
Date: Thu,  9 Nov 2023 22:22:54 +0100
Message-ID: <20231109222251.a62811ebde9b.Ia70a49792c448867fd61b0234e1da507b0f75086@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109212251.213873-7-johannes@sipsolutions.net>
References: <20231109212251.213873-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When you take a lock in a debugfs handler but also try
to remove the debugfs file under that lock, things can
deadlock since the removal has to wait for all users
to finish.

Add lockdep annotations in debugfs_file_get()/_put()
to catch such issues.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/file.c     | 10 ++++++++++
 fs/debugfs/inode.c    | 12 ++++++++++++
 fs/debugfs/internal.h |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 23bdfc126b5e..e499d38b1077 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -103,6 +103,12 @@ int debugfs_file_get(struct dentry *dentry)
 			kfree(fsd);
 			fsd = READ_ONCE(dentry->d_fsdata);
 		}
+#ifdef CONFIG_LOCKDEP
+		fsd->lock_name = kasprintf(GFP_KERNEL, "debugfs:%pd", dentry);
+		lockdep_register_key(&fsd->key);
+		lockdep_init_map(&fsd->lockdep_map, fsd->lock_name ?: "debugfs",
+				 &fsd->key, 0);
+#endif
 	}
 
 	/*
@@ -119,6 +125,8 @@ int debugfs_file_get(struct dentry *dentry)
 	if (!refcount_inc_not_zero(&fsd->active_users))
 		return -EIO;
 
+	lock_map_acquire_read(&fsd->lockdep_map);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(debugfs_file_get);
@@ -136,6 +144,8 @@ void debugfs_file_put(struct dentry *dentry)
 {
 	struct debugfs_fsdata *fsd = READ_ONCE(dentry->d_fsdata);
 
+	lock_map_release(&fsd->lockdep_map);
+
 	if (refcount_dec_and_test(&fsd->active_users))
 		complete(&fsd->active_users_drained);
 }
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 269bad87d552..a4c77aafb77b 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -241,6 +241,14 @@ static void debugfs_release_dentry(struct dentry *dentry)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
 
+	/* check it wasn't an automount or dir */
+	if (fsd && fsd->real_fops) {
+#ifdef CONFIG_LOCKDEP
+		lockdep_unregister_key(&fsd->key);
+		kfree(fsd->lock_name);
+#endif
+	}
+
 	kfree(fsd);
 }
 
@@ -742,6 +750,10 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	fsd = READ_ONCE(dentry->d_fsdata);
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
+
+	lock_map_acquire(&fsd->lockdep_map);
+	lock_map_release(&fsd->lockdep_map);
+
 	if (!refcount_dec_and_test(&fsd->active_users))
 		wait_for_completion(&fsd->active_users_drained);
 }
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index f7c489b5a368..c7d61cfc97d2 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -7,6 +7,7 @@
 
 #ifndef _DEBUGFS_INTERNAL_H_
 #define _DEBUGFS_INTERNAL_H_
+#include <linux/lockdep.h>
 
 struct file_operations;
 
@@ -23,6 +24,11 @@ struct debugfs_fsdata {
 		struct {
 			refcount_t active_users;
 			struct completion active_users_drained;
+#ifdef CONFIG_LOCKDEP
+			struct lockdep_map lockdep_map;
+			struct lock_class_key key;
+			char *lock_name;
+#endif
 		};
 	};
 };
-- 
2.41.0


