Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA537DD3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfHAOCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 10:02:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42505 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731468AbfHAOCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:02:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so23833794wrr.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2019 07:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJn6mUYEYLeEvyAEs0120wh2ye8ZXvWXPoyVrBnKS2s=;
        b=aLfNR/2Caqo2iMfQlNMs7XSRqYGL5aV3hWiaO5UHWpgQuwgFlZMpgQ/YHM1A47yxbI
         SrYH9vh73vOx8MNcm8Zkznd87leA09J/CzkbSFMEUOksM7Sa5tdglMmVlELDgzph1co3
         PihRcIs/nrLZDUHbBpa+1ZOopkyrv4uk6JEmJgHowTXUJyrC6P/+jYuvZgXXmU9Bjc/n
         H3P5Obd+ebAvi9T4tNQcrolUdoLs8/3DVRE+aDhsTTV95s9Gi3d8t/6jrhPRUHty4WLq
         l6sY6u9NXJGvmPIelJauvRA4MXYUXFLJMyopbr98LZGVq6sJNh6Emxh6gokRcqRM33J2
         pRAA==
X-Gm-Message-State: APjAAAXtqnKA9zaiUighXpkb05GXixGHnWQCwIOy3DoOTAqv2EAwK7dW
        7H5bfde7iMvK4mBvp7evAa+xAA==
X-Google-Smtp-Source: APXvYqycPbmdqDDFF167loGujYRAmgAcJOv7PBWaUQzfjx70b5H9CGMf56RqiPGlGFmHgztjQAPHUw==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr6646495wre.205.1564668169029;
        Thu, 01 Aug 2019 07:02:49 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z7sm69909162wrh.67.2019.08.01.07.02.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:02:48 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/4] dcache: introduce d_genocide_safe()
Date:   Thu,  1 Aug 2019 16:02:42 +0200
Message-Id: <20190801140243.24080-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801140243.24080-1-omosnace@redhat.com>
References: <20190801140243.24080-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds a slightly modified variant of d_genocide() that works
safely on live (ramfs-like) trees. This function is needed for a safe
implementation of sel_remove_entries() in selinuxfs.

This new function differs from the original d_genocide in the following:
1. It locks the parent inode when traversing the dentries.
2. It first unhashes the dentry using __d_drop() before dropping the
   refcount and marking the dentry.
3. It does its business in the leave callback so that each dentry is
   unhashed after its children -- otherwise some dentries might never
   get traversed when d_walk() is restarted internally.

The combination of (1.) and (2.) is needed to avoid racing with
dcache_readdir(), which relies on the assumption that any
simple_positive() child dentry will not turn negative without locking
the parent inode for writing.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/dcache.c            | 32 ++++++++++++++++++++++++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 70afcb6e6892..f6d667120c1e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3142,6 +3142,38 @@ void d_genocide(struct dentry *parent)
 
 EXPORT_SYMBOL(d_genocide);
 
+static enum d_walk_ret d_genocide_safe_enter(void *data, struct dentry *dentry)
+{
+	struct dentry *root = data;
+
+	if (dentry != root && !simple_positive(dentry))
+		return D_WALK_SKIP;
+
+	return D_WALK_CONTINUE;
+}
+
+static void d_genocide_safe_leave(void *data, struct dentry *dentry)
+{
+	struct dentry *root = data;
+
+	if (dentry != root) {
+		__d_drop(dentry);
+
+		if (!(dentry->d_flags & DCACHE_GENOCIDE)) {
+			dentry->d_flags |= DCACHE_GENOCIDE;
+			dentry->d_lockref.count--;
+		}
+	}
+}
+
+void d_genocide_safe(struct dentry *parent)
+{
+	d_walk(parent, true, parent, d_genocide_safe_enter,
+	       d_genocide_safe_leave);
+}
+
+EXPORT_SYMBOL(d_genocide_safe);
+
 void d_tmpfile(struct dentry *dentry, struct inode *inode)
 {
 	inode_dec_link_count(inode);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 9451011ac014..6d787c26e901 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -253,6 +253,7 @@ extern struct dentry * d_make_root(struct inode *);
 
 /* <clickety>-<click> the ramfs-type tree */
 extern void d_genocide(struct dentry *);
+extern void d_genocide_safe(struct dentry *parent);
 
 extern void d_tmpfile(struct dentry *, struct inode *);
 
-- 
2.21.0

