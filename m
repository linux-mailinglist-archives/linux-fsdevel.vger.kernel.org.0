Return-Path: <linux-fsdevel+bounces-78952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JMPBQ3ZpWmuHQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 19:38:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC21DE6F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 19:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C8373058494
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641D342523;
	Mon,  2 Mar 2026 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fuc0ubkR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1D33B951
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476668; cv=none; b=blvhuuHeesEPunCZCqVdmKRYLSsaXTWH5/wlzylyudYTK+FueNTly/yhWofECspMuoxogedEHMEhPdNArxWsrV9ylPJ/50iHhpaAg4zssljK/2uR0BGyrPLe8kof1R7R5sCl2cTq774X7zB9RAFG6cXbxwn7HJ59XwgERCgnJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476668; c=relaxed/simple;
	bh=wbz/HdxoylFuRnJT4EgtSyb60RNpal6IC9L6z6SsHNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXjiRd9GSD1wG10wm0t3OUWRTPiafkwhgRXS2PbVCirzRgk+zooe7DThO4aX+hXqGdWBeOcu14C4VbfAnJ7g9qGEFzgZ7JhAJ+Vcfg83VQhS8hvxLjYmS8R8zbCW1CRWGl7I6a46dVIKzTFDZqDI0xXrwzgKPw20YlR+mgWWSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fuc0ubkR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9359c0ec47so508503366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 10:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772476665; x=1773081465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMLmBv1qwJ9gOQZNRA9F/Pvc5TW4NfX7mRKWqfChxSk=;
        b=Fuc0ubkRGCBpI5J/oS1O+I7TqYl+bUptFk6wl3fQ/Iiw6PCoFsiHKp5z/bAyU13+yb
         ttgEw/bus7m0B7KAOXoyVoWpjthNBLMbh9VQQ1OTJOEt+jETB+tBHmtTk7k1eZxSP+AP
         5VaH1PEkwrUy354zs0XhSU5DJdzAttzfe72HrwHXYeyc7KRryWKCxpVjWJV43Q2JPFTy
         OtZH9kOC21eJhVjY3WuDi/tE5zX9jIMniRRcoSFdnVNb1YM01MUeiUQTEaGtsqvo+Atb
         V77pydoOw9Za97eCMLS0sZ8SqiR+GTfUl2qAwW1/Wfm/pTNKf5NdXgT5LwKAU1sNaWrN
         7npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772476665; x=1773081465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WMLmBv1qwJ9gOQZNRA9F/Pvc5TW4NfX7mRKWqfChxSk=;
        b=T7mRPH+qpUHzoRiZFHGQ6SFPdbPum1gMiWZKmknyHXznAVL9pSc19SE+fpCO9vtcQ6
         /zIopnAMXWEwWc36DxW/Lshgin5RPTQqtRD/ghPEfY7SX5oMK9usS/83+7DrKY7FQi1h
         iTCqnCgMsvWwTYGjbbBBwgTy7qBNYV/nNHoTio3xsMFTRYea+sSMIoGXgVnRkAdaPKrZ
         +DHiDNxX4Om5qHn9BWIvQ+m8fEfkIB+hr5AJ8Mo2nCb5v6XByN2LAH3RYhZVPVDkunts
         gFwTX5reRu89iJxtOk7p9+dTWp0FKpztwlqvdgGRUMonWRxki+CzeHqXCZ0v/1XuJMun
         b4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWuq8W0nWcVySvep+CNbAIJqvBGd08xT053cBzSsWzTmvn24hbA4wRtFUk8490cX6o/EALglJCK/XpZImq1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0w6M0yjdAxOZPkm6iSkmdUBviKXRy7pYyg8I/QimwcbEfXoah
	qrNhWNi4JoiMdnCQ6ktc7iNUsjhFQl2IBPryKswAKWAnk6AkOQ4+TO3D
X-Gm-Gg: ATEYQzwYvi5XdMXYOP3ZdZYCO3QWhci+318e8aKu7aXln1nZs1SpcQ+nomMZo8csBK/
	AAno2gL0kmY/W2TaqckWZP+22s7r5g9QEXJAWmVeUeGZGkqTqhmobUtcDnzg6zYWe/yqrnXT+ms
	gl2DrjTQw9ol79sw3z9uboGRCYauBbujsXO8K40D752TnpyTn3vIyac4/Av2W9rgEoj8eLFUjGr
	tTl1i3TJogqcXHaVhT8NtZZEqGSi0+GAfAnkNWPZBo/Nn84zVvk8JVCvm2gP22MNMWvW/rYRiUL
	6NjER1PFDj3Egm64pOUsvSOu06oB5xJY4Lbd1Y/A/K/9E1RD1KSQLylq86JTAcks8KtzBRxZ2hU
	HfG5photo+bg8Jt2rrgMeluZCefuJDa5zgularRH2Fca/evW24+LaTUVeZHlKxPL2DBF4iN8vKo
	jtgfc+Qra/jL+5Guomn3ST4HawQj8TrqWMwQJUi7M8LqEjMQkSL0417e+ll86uWYyovXz0tEmJl
	UrkV6wKY2mqu4R4dxdbRPdS650=
X-Received: by 2002:a17:906:d8e:b0:b93:5612:a57 with SMTP id a640c23a62f3a-b93765584b0mr549095066b.52.1772476665007;
        Mon, 02 Mar 2026 10:37:45 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-11a2-6710-0774-33c0.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:11a2:6710:774:33c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac66feesm500469366b.21.2026.03.02.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 10:37:44 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fs: use simple_end_creating helper to consolidate fsnotify hooks
Date: Mon,  2 Mar 2026 19:37:41 +0100
Message-ID: <20260302183741.1308767-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302183741.1308767-1-amir73il@gmail.com>
References: <20260302183741.1308767-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CAC21DE6F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-78952-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add simple_end_creating() helper which combines fsnotify_create/mkdir()
hook and simple_done_creating().

Use the new helper to consolidate this pattern in several pseudo fs
which had open coded fsnotify_create/mkdir() hooks:
binderfs, debugfs, nfsctl, tracefs, rpc_pipefs.

For those filesystems, the paired fsnotify_delete() hook is already
inside the library helper simple_recursive_removal().

Note that in debugfs_create_symlink(), the fsnotify hook was missing,
so the missing hook is fixed by this change.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 drivers/android/binder/rust_binderfs.c | 11 +++--------
 drivers/android/binderfs.c             | 10 +++-------
 fs/debugfs/inode.c                     |  5 +----
 fs/libfs.c                             | 14 ++++++++++++++
 fs/nfsd/nfsctl.c                       | 11 +++--------
 fs/tracefs/event_inode.c               |  2 --
 fs/tracefs/inode.c                     |  5 +----
 include/linux/fs.h                     |  1 +
 net/sunrpc/rpc_pipe.c                  | 10 +++-------
 9 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/android/binder/rust_binderfs.c b/drivers/android/binder/rust_binderfs.c
index ade1c4d924992..d69490c6b9e09 100644
--- a/drivers/android/binder/rust_binderfs.c
+++ b/drivers/android/binder/rust_binderfs.c
@@ -3,7 +3,6 @@
 #include <linux/compiler_types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
-#include <linux/fsnotify.h>
 #include <linux/gfp.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -186,9 +185,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 
 	inode->i_private = device;
 	d_make_persistent(dentry, inode);
-
-	fsnotify_create(root->d_inode, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 
 	return 0;
 
@@ -481,8 +478,7 @@ static struct dentry *rust_binderfs_create_file(struct dentry *parent, const cha
 	}
 
 	d_make_persistent(dentry, new_inode);
-	fsnotify_create(parent->d_inode, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 	return dentry;
 }
 
@@ -522,8 +518,7 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
 	inc_nlink(parent->d_inode);
 	set_nlink(new_inode, 2);
 	d_make_persistent(dentry, new_inode);
-	fsnotify_mkdir(parent->d_inode, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 	return dentry;
 }
 
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 361d69f756f50..60277f0bb679f 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -3,7 +3,6 @@
 #include <linux/compiler_types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
-#include <linux/fsnotify.h>
 #include <linux/gfp.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -190,8 +189,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	}
 	inode->i_private = device;
 	d_make_persistent(dentry, inode);
-	fsnotify_create(root->d_inode, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 
 	binder_add_device(device);
 
@@ -490,8 +488,7 @@ struct dentry *binderfs_create_file(struct dentry *parent, const char *name,
 	new_inode->i_fop = fops;
 	new_inode->i_private = data;
 	d_make_persistent(dentry, new_inode);
-	fsnotify_create(parent_inode, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 	return dentry; // borrowed
 }
 
@@ -521,8 +518,7 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
 	set_nlink(new_inode, 2);
 	d_make_persistent(dentry, new_inode);
 	inc_nlink(parent_inode);
-	fsnotify_mkdir(parent_inode, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 	return dentry;
 }
 
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 4598142355b97..f51b008d42cbf 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -409,7 +409,7 @@ static struct dentry *debugfs_failed_creating(struct dentry *dentry)
 
 static struct dentry *debugfs_end_creating(struct dentry *dentry)
 {
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 	return dentry; // borrowed
 }
 
@@ -448,7 +448,6 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	DEBUGFS_I(inode)->aux = (void *)aux;
 
 	d_make_persistent(dentry, inode);
-	fsnotify_create(d_inode(dentry->d_parent), dentry);
 	return debugfs_end_creating(dentry);
 }
 
@@ -590,7 +589,6 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	inc_nlink(inode);
 	d_make_persistent(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
-	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
 	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_dir);
@@ -632,7 +630,6 @@ struct dentry *debugfs_create_automount(const char *name,
 	inc_nlink(inode);
 	d_make_persistent(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
-	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
 	return debugfs_end_creating(dentry);
 }
 EXPORT_SYMBOL(debugfs_create_automount);
diff --git a/fs/libfs.c b/fs/libfs.c
index 74134ba2e8d1e..2f6dcae40ce7f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2322,3 +2322,17 @@ void simple_done_creating(struct dentry *child)
 	dput(child);
 }
 EXPORT_SYMBOL(simple_done_creating);
+
+/*
+ * Like simple_done_creating(), but also fires fsnotify_create() for the
+ * new dentry.  Call on the success path after d_make_persistent().
+ * Use simple_done_creating() on the failure path where the child dentry is
+ * still negative.
+ */
+void simple_end_creating(struct dentry *child)
+{
+	fsnotify_create(child->d_parent->d_inode, child);
+	inode_unlock(child->d_parent->d_inode);
+	dput(child);
+}
+EXPORT_SYMBOL(simple_end_creating);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e9acd2cd602cb..6e600d52b66d0 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -17,7 +17,6 @@
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/module.h>
-#include <linux/fsnotify.h>
 #include <linux/nfslocalio.h>
 
 #include "idmap.h"
@@ -1146,8 +1145,7 @@ static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *nc
 	}
 	d_make_persistent(dentry, inode);
 	inc_nlink(dir);
-	fsnotify_mkdir(dir, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 	return dentry;	// borrowed
 }
 
@@ -1178,8 +1176,7 @@ static void _nfsd_symlink(struct dentry *parent, const char *name,
 	inode->i_size = strlen(content);
 
 	d_make_persistent(dentry, inode);
-	fsnotify_create(dir, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 }
 #else
 static inline void _nfsd_symlink(struct dentry *parent, const char *name,
@@ -1219,7 +1216,6 @@ static int nfsdfs_create_files(struct dentry *root,
 				struct nfsdfs_client *ncl,
 				struct dentry **fdentries)
 {
-	struct inode *dir = d_inode(root);
 	struct dentry *dentry;
 
 	for (int i = 0; files->name && files->name[0]; i++, files++) {
@@ -1236,10 +1232,9 @@ static int nfsdfs_create_files(struct dentry *root,
 		inode->i_fop = files->ops;
 		inode->i_private = ncl;
 		d_make_persistent(dentry, inode);
-		fsnotify_create(dir, dentry);
 		if (fdentries)
 			fdentries[i] = dentry; // borrowed
-		simple_done_creating(dentry);
+		simple_end_creating(dentry);
 	}
 	return 0;
 }
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8e5ac464b3284..059ea7560b9b4 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -14,7 +14,6 @@
  *  inodes/dentries in a just-in-time (JIT) manner. The eventfs will clean up
  *  and delete the inodes/dentries when they are no longer referenced.
  */
-#include <linux/fsnotify.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/workqueue.h>
@@ -826,7 +825,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	d_make_persistent(dentry, inode);
 	/* The dentry of the "events" parent does keep track though */
 	inc_nlink(dentry->d_parent->d_inode);
-	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	tracefs_end_creating(dentry);
 
 	return ei;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 51c00c8fa1755..90a15c064e309 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -16,7 +16,6 @@
 #include <linux/kobject.h>
 #include <linux/namei.h>
 #include <linux/tracefs.h>
-#include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/magic.h>
@@ -578,7 +577,7 @@ struct dentry *tracefs_failed_creating(struct dentry *dentry)
 
 struct dentry *tracefs_end_creating(struct dentry *dentry)
 {
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 	return dentry;	// borrowed
 }
 
@@ -661,7 +660,6 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
 	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
 	d_make_persistent(dentry, inode);
-	fsnotify_create(d_inode(dentry->d_parent), dentry);
 	return tracefs_end_creating(dentry);
 }
 
@@ -693,7 +691,6 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	inc_nlink(inode);
 	d_make_persistent(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
-	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
 	return tracefs_end_creating(dentry);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25ec..8e5080be34308 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3271,6 +3271,7 @@ extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int
 extern void simple_release_fs(struct vfsmount **mount, int *count);
 struct dentry *simple_start_creating(struct dentry *, const char *);
 void simple_done_creating(struct dentry *);
+void simple_end_creating(struct dentry *);
 
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 9d349cfbc4831..84d0ba37d9d6f 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -16,7 +16,6 @@
 #include <linux/mount.h>
 #include <linux/fs_context.h>
 #include <linux/namei.h>
-#include <linux/fsnotify.h>
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
 #include <linux/utsname.h>
@@ -544,8 +543,7 @@ static int rpc_new_file(struct dentry *parent,
 		inode->i_fop = i_fop;
 	rpc_inode_setowner(inode, private);
 	d_make_persistent(dentry, inode);
-	fsnotify_create(dir, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 	return 0;
 }
 
@@ -569,8 +567,7 @@ static struct dentry *rpc_new_dir(struct dentry *parent,
 	inode->i_ino = iunique(dir->i_sb, 100);
 	inc_nlink(dir);
 	d_make_persistent(dentry, inode);
-	fsnotify_mkdir(dir, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 
 	return dentry; // borrowed
 }
@@ -667,8 +664,7 @@ int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 	rpc_inode_setowner(inode, private);
 	pipe->dentry = dentry; // borrowed
 	d_make_persistent(dentry, inode);
-	fsnotify_create(dir, dentry);
-	simple_done_creating(dentry);
+	simple_end_creating(dentry);
 	return 0;
 
 failed:
-- 
2.53.0


