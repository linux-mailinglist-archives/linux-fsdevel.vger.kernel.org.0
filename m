Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1CDBEA82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbfIZCPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 22:15:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38760 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZCPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:15:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so100529wro.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNcyUb+waA/wFzR42SB8pRb0N5bkuNbBy1Xitzh8Ovg=;
        b=jBo2ob8+5Ft+x9lzcYiLQu2C1wQZbwtKJQ/szD0s1B2IQcSHwY4UUxOWjDTnKDznWL
         THYCHLlBbkwwTbG5fg+iFOzHIzuWTWME/6o61dEMPT2u93mpMRr+KrTl8K9CDS/3R5FO
         IKiKFqK+D3FB0I9iTk8n1WH8uwMMPf+2foKWaOm+8Ua5im7mAXKkAK+Ohd/van+zAtDN
         X2GdKifchI63tQeTt21mIYdBnJUjmnrOkFZuUHnZWpFL359xRr967ISkFhQzGHTDGH05
         DhLov0YfCnL3fEtB3zajFEA2GGv3NaM6QHaz6VdMvDBo7pryBRepkOWwAJDs++JtvtHB
         YygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNcyUb+waA/wFzR42SB8pRb0N5bkuNbBy1Xitzh8Ovg=;
        b=PQNl91661e1SbHhq+9l7MHlFgeKyBtaNrmJVxBWuJtfUgviRahdWMpuNGnxWMOzvS3
         CKRj6/0tEmIZ2ZfAhxpOWXEXVJiJZqx1SdFU+1nD5cQv0LUEzmu3yUKQn5XwKrikKZqy
         A7YW4bYfPz7B+GI240neNHyNxX7GFVPWjoGEPcEKsqWu8Yd/98aMlnD6EwTuGmFfnZYQ
         wpQxpdOYkKX7XRjZfmcjaPiKnZZkrB8/8nJXcLVTfuUFYR/p04ftGVlpgoO3TyDmWQrc
         sX20sZfbkwy+Vqg5rjvyxUz5yfbtrzwtSgttzQLlEAOWse/1ZkFkNDxLCwETenXUthaG
         u60Q==
X-Gm-Message-State: APjAAAWvjTuqfJmLIJWKngeGIJzoY2yJgDFgkts3fj0VDjQLjLqBk6o3
        IvGvn6b7z3aX9aNj3zGE/kGWeWmLZwg=
X-Google-Smtp-Source: APXvYqxEaK4Mel+GChxNW/TWvLBM0vMHj8xPlM0nqONiEoz4+d6X35RCvg0PrlPX6zWWH5c2fU4dYA==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr915146wrq.301.1569464116322;
        Wed, 25 Sep 2019 19:15:16 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id o19sm968751wro.50.2019.09.25.19.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 19:15:15 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 16/16] zuf: Support for dynamic-debug of zusFSs
Date:   Thu, 26 Sep 2019 05:07:25 +0300
Message-Id: <20190926020725.19601-17-boazh@netapp.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926020725.19601-1-boazh@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 [THIS PATCH will be changed or dropped before final submission]

In zus we support dynamic-debug prints. ie user can
turn on and off the prints at run time by writing
to some special files.

The API is exactly the same as the Kernel's dynamic-prints
only the special file that we perform read/write on is:
	/sys/fs/zuf/ddbg

But otherwise it is identical to Kernel.

The Kernel code is a thin wrapper to dispatch to/from
the read/write of /sys/fs/zuf/ddbg file to the zus
server.
The heavy lifting is done by the zus project build system
and core code. See zus project how this is done

This facility is dispatched on the mount-thread and not
the regular ZTs. Because it is available globally before
any mounts.

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/_extern.h  |  3 ++
 fs/zuf/zuf-root.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index d0d83eae75c1..40cc228e4c99 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -29,6 +29,9 @@ int zufc_release(struct inode *inode, struct file *file);
 int zufc_mmap(struct file *file, struct vm_area_struct *vma);
 const char *zuf_op_name(enum e_zufs_operation op);
 
+int __zufc_dispatch_mount(struct zuf_root_info *zri,
+			  enum e_mount_operation op,
+			  struct zufs_ioc_mount *zim);
 int zufc_dispatch_mount(struct zuf_root_info *zri, struct zus_fs_info *zus_zfi,
 			enum e_mount_operation operation,
 			struct zufs_ioc_mount *zim);
diff --git a/fs/zuf/zuf-root.c b/fs/zuf/zuf-root.c
index ecf240bd3e3f..3c3126d676a6 100644
--- a/fs/zuf/zuf-root.c
+++ b/fs/zuf/zuf-root.c
@@ -70,6 +70,81 @@ static void _fs_type_free(struct zuf_fs_type *zft)
 }
 #endif /*CONFIG_LOCKDEP*/
 
+#define DDBG_MAX_BUF_SIZE	(8 * PAGE_SIZE)
+/* We use ppos as a cookie for the dynamic debug ID we want to read from */
+static ssize_t _zus_ddbg_read(struct file *file, char __user *buf, size_t len,
+			      loff_t *ppos)
+{
+	struct zufs_ioc_mount *zim;
+	size_t buf_size = (DDBG_MAX_BUF_SIZE <= len) ? DDBG_MAX_BUF_SIZE : len;
+	size_t zim_size =  sizeof(zim->hdr) + sizeof(zim->zdi);
+	ssize_t err;
+
+	zim = vzalloc(zim_size + buf_size);
+	if (unlikely(!zim))
+		return -ENOMEM;
+
+	/* null terminate the 1st character in the buffer, hence the '+ 1' */
+	zim->hdr.in_len = zim_size + 1;
+	zim->hdr.out_len = zim_size + buf_size;
+	zim->zdi.len = buf_size;
+	zim->zdi.id = *ppos;
+	*ppos = 0;
+
+	err = __zufc_dispatch_mount(ZRI(file->f_inode->i_sb), ZUFS_M_DDBG_RD,
+				    zim);
+	if (unlikely(err)) {
+		zuf_err("error dispatching contorl message => %ld\n", err);
+		goto out;
+	}
+
+	err = simple_read_from_buffer(buf, zim->zdi.len, ppos, zim->zdi.msg,
+				      buf_size);
+	if (unlikely(err <= 0))
+		goto out;
+
+	*ppos = zim->zdi.id;
+out:
+	vfree(zim);
+	return err;
+}
+
+static ssize_t _zus_ddbg_write(struct file *file, const char __user *buf,
+			       size_t len, loff_t *ofst)
+{
+	struct _ddbg_info {
+		struct zufs_ioc_mount zim;
+		char buf[512];
+	} ddi = {};
+	ssize_t err;
+
+	if (unlikely(512 < len)) {
+		zuf_err("ddbg control message to long\n");
+		return -EINVAL;
+	}
+
+	memset(&ddi, 0, sizeof(ddi));
+	if (copy_from_user(ddi.zim.zdi.msg, buf, len))
+		return -EFAULT;
+
+	ddi.zim.hdr.in_len = sizeof(ddi);
+	ddi.zim.hdr.out_len = sizeof(ddi.zim);
+	err = __zufc_dispatch_mount(ZRI(file->f_inode->i_sb), ZUFS_M_DDBG_WR,
+				    &ddi.zim);
+	if (unlikely(err)) {
+		zuf_err("error dispatching contorl message => %ld\n", err);
+		return err;
+	}
+
+	return len;
+}
+
+static const struct file_operations _zus_ddbg_ops = {
+	.open = nonseekable_open,
+	.read = _zus_ddbg_read,
+	.write = _zus_ddbg_write,
+	.llseek = no_llseek,
+};
 
 static ssize_t _state_read(struct file *file, char __user *buf, size_t len,
 			   loff_t *ppos)
@@ -338,6 +413,7 @@ static int zufr_fill_super(struct super_block *sb, void *data, int silent)
 	static struct tree_descr zufr_files[] = {
 		[2] = {"state", &_state_ops, S_IFREG | 0400},
 		[3] = {"registered_fs", &_registered_fs_ops, S_IFREG | 0400},
+		[4] = {"ddbg", &_zus_ddbg_ops, S_IFREG | 0600},
 		{""},
 	};
 	struct zuf_root_info *zri;
-- 
2.21.0

