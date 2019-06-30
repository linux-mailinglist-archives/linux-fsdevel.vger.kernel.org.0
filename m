Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34735AFF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF3Nyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:54:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45535 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3Nyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:54:53 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so22673554ioc.12;
        Sun, 30 Jun 2019 06:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qWQdsQR+7rjgziXb19Yd7ETzEvhj2LLwzCpYlEhL88=;
        b=unq5B88jyRdDX0t7FJKkHaLiQFOWhxWZEVj5qwdv6Xll/9omD6UW7Lhrx/wBQ18hej
         PCmnQ/1IPtJBPrNt8cu14xG/5f/9xdXHcToJVBeJeanpySYRM1JJCPxEDHxEjCW/W3vD
         4NbZeCdnmJ5HzLPxSpqf63EqBhPrvd4AFqH8n2T+CMG+S6B+xKUSVCxQQuNejzIZ8+Pd
         GLnFJ77TaM0rvPWzYxhGQ5z2QUdCWp0X3gCumamvF8KUcdqUu1ErvirraVabToGHpE3f
         TFoPRzdcj7M+2Napj2aSYtJJcmnmvf0kidjeo+q9ujDjwX+ahVSoEoFoCA15yPOy2l2r
         CTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qWQdsQR+7rjgziXb19Yd7ETzEvhj2LLwzCpYlEhL88=;
        b=Ai3C/AdE1MutI4MRZESyuCPR0sghLKVdP7bscY2DP/4rp3eFQ6TrMUXG2C8mVocdeA
         3wWlVNTXOGPi0eH+zDFmRHFQndi6qdVzHb54Bn59E6EchThFgtKReZz4vYLDBOwAB8XN
         6PqscTLbzkLoYX2CL9DtS68bIhVS9nyTH7+Z2EQAciCQ8CzCvxnQ4v8CiNJ+vP3rSDel
         XIJcPoWqPFmB84uv8Lv/J0qvyUuQavjQnvX5H8Xkhlr0GW9cDzZ3ssMoN3RWzeGAOSko
         SMDz2x7mXiDgGmC3qrMz8Qk+sScdEJUw45mBqcjtN1AuueqdUiFgWvCURjcGKZeRwTS/
         0etg==
X-Gm-Message-State: APjAAAUM8r6GSeup/GlpuC/bHdJrnYKMeuUlwSOdpZnvS3LDWawGWHw5
        udhXffo94c/fXzVSQBX8TA==
X-Google-Smtp-Source: APXvYqxW9iumLRivSw8i5O0RAZrNs9FNfj+iAmW/boOwm7Pr/IlbSvI/fLeuaYXnqy5b+zCM8ZnHPA==
X-Received: by 2002:a5e:c605:: with SMTP id f5mr22426335iok.78.1561902892236;
        Sun, 30 Jun 2019 06:54:52 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.54.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:54:51 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/16] locks: create a new notifier chain for lease attempts
Date:   Sun, 30 Jun 2019 09:52:26 -0400
Message-Id: <20190630135240.7490-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-2-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

With the new file caching infrastructure in nfsd, we can end up holding
files open for an indefinite period of time, even when they are still
idle. This may prevent the kernel from handing out leases on the file,
which is something we don't want to block.

Fix this by running a SRCU notifier call chain whenever on any
lease attempt. nfsd can then purge the cache for that inode before
returning.

Since SRCU is only conditionally compiled in, we must only define the
new chain if it's enabled, and users of the chain must ensure that
SRCU is enabled.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/locks.c         | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  5 ++++
 2 files changed, 67 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index ec1e4a5df629..33ae1a7f3031 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -212,6 +212,7 @@ struct file_lock_list_struct {
 static DEFINE_PER_CPU(struct file_lock_list_struct, file_lock_list);
 DEFINE_STATIC_PERCPU_RWSEM(file_rwsem);
 
+
 /*
  * The blocked_hash is used to find POSIX lock loops for deadlock detection.
  * It is protected by blocked_lock_lock.
@@ -1973,6 +1974,64 @@ int generic_setlease(struct file *filp, long arg, struct file_lock **flp,
 }
 EXPORT_SYMBOL(generic_setlease);
 
+#if IS_ENABLED(CONFIG_SRCU)
+/*
+ * Kernel subsystems can register to be notified on any attempt to set
+ * a new lease with the lease_notifier_chain. This is used by (e.g.) nfsd
+ * to close files that it may have cached when there is an attempt to set a
+ * conflicting lease.
+ */
+static struct srcu_notifier_head lease_notifier_chain;
+
+static inline void
+lease_notifier_chain_init(void)
+{
+	srcu_init_notifier_head(&lease_notifier_chain);
+}
+
+static inline void
+setlease_notifier(long arg, struct file_lock *lease)
+{
+	if (arg != F_UNLCK)
+		srcu_notifier_call_chain(&lease_notifier_chain, arg, lease);
+}
+
+int lease_register_notifier(struct notifier_block *nb)
+{
+	return srcu_notifier_chain_register(&lease_notifier_chain, nb);
+}
+EXPORT_SYMBOL_GPL(lease_register_notifier);
+
+void lease_unregister_notifier(struct notifier_block *nb)
+{
+	srcu_notifier_chain_unregister(&lease_notifier_chain, nb);
+}
+EXPORT_SYMBOL_GPL(lease_unregister_notifier);
+
+#else /* !IS_ENABLED(CONFIG_SRCU) */
+static inline void
+lease_notifier_chain_init(void)
+{
+}
+
+static inline void
+setlease_notifier(long arg, struct file_lock *lease)
+{
+}
+
+int lease_register_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lease_register_notifier);
+
+void lease_unregister_notifier(struct notifier_block *nb)
+{
+}
+EXPORT_SYMBOL_GPL(lease_unregister_notifier);
+
+#endif /* IS_ENABLED(CONFIG_SRCU) */
+
 /**
  * vfs_setlease        -       sets a lease on an open file
  * @filp:	file pointer
@@ -1993,6 +2052,8 @@ EXPORT_SYMBOL(generic_setlease);
 int
 vfs_setlease(struct file *filp, long arg, struct file_lock **lease, void **priv)
 {
+	if (lease)
+		setlease_notifier(arg, *lease);
 	if (filp->f_op->setlease)
 		return filp->f_op->setlease(filp, arg, lease, priv);
 	else
@@ -2906,6 +2967,7 @@ static int __init filelock_init(void)
 		INIT_HLIST_HEAD(&fll->hlist);
 	}
 
+	lease_notifier_chain_init();
 	return 0;
 }
 core_initcall(filelock_init);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..066dfc3963b5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1157,6 +1157,11 @@ extern void lease_get_mtime(struct inode *, struct timespec64 *time);
 extern int generic_setlease(struct file *, long, struct file_lock **, void **priv);
 extern int vfs_setlease(struct file *, long, struct file_lock **, void **);
 extern int lease_modify(struct file_lock *, int, struct list_head *);
+
+struct notifier_block;
+extern int lease_register_notifier(struct notifier_block *);
+extern void lease_unregister_notifier(struct notifier_block *);
+
 struct files_struct;
 extern void show_fd_locks(struct seq_file *f,
 			 struct file *filp, struct files_struct *files);
-- 
2.21.0

