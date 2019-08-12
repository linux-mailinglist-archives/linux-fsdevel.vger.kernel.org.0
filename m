Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E498A3C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfHLQs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:48:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46986 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHLQsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:48:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so105172620wru.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJXb13v4i5mVaPeD5oagVaercElbJiuEhB1n5p+wfNY=;
        b=WrkX9TviCoqLty6cNVhsRZgR6y4SyDgPmHLUcdIuKiHI+DlrGpzYLDt2eB2YpRqAZD
         +a/BzPhrf4F5pD23U4D3Gdi6BsN+7V0QqSvvTHRsVATh+AKvMCgN4uPUDHDWSWyv8JEP
         9np/L6zLxkELfuuvAN1HGCwi+PNMPPxg3e0Bp0/vB0ahiWUhM8GMKU+uVERhSOAeMJMM
         oUtfGEdF9HxZ72lVV5koGT6mHE56uiXyHBLnfAGrBN5nJmPZsmdWHEAbQJDczGwtB+xb
         5Bv12PrXlLibgRzn0mRZp5bfCWVGvpd65ZpynzAr7cIBHbzOni2NgV6dI8FAZzjqBeO+
         OsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJXb13v4i5mVaPeD5oagVaercElbJiuEhB1n5p+wfNY=;
        b=e88/mHVQWvs1gxzFShG1uz6MHpPpqXqA5xXManoZO5DsGG9qkoT7465sVES14cYeQe
         FZMGuZkkEB7Cit7MdkOFXHtZtQ6tWGOWg1lQIYuVcsChIXqATGUqC2J/lVHsiGiwWsv8
         dFXC3dMSnXeAuxEte6MYoS2JPrNP/CoD5fO/OJz9lYsytMycnQs5gvXvKHq7nteMs9Gj
         C2cyP7pkDbnrXFMGs2d4X7R2QtCBWNtqid2g5kK+A0YMDRxTVGiZsxP44+XvsBEDAIen
         bf6a82oprbp/magGvjD0Wl+zdSN+Ry7sZ22ocUW1wiBObmXno5WQr2l09+7LqY78SBw2
         rK6Q==
X-Gm-Message-State: APjAAAWkmgHrlSgWK3+rwFx8eHX09fGwrWJb/1fJPs565sBheGjy7gtn
        3oETeN4CJ2d8Ph5mnjPV3r4ICbvfeCc=
X-Google-Smtp-Source: APXvYqzSq1YiwP5VumnI/QWjJxciqpWt2TC450K4RtLv+OxRw0RC6qS3B7BhdUrTqzzMkWChYBv6uw==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr41817855wrn.168.1565628533616;
        Mon, 12 Aug 2019 09:48:53 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id b136sm202825wme.18.2019.08.12.09.48.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:48:53 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Amit Golander <Amit.Golander@netapp.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 16/16] zuf: Support for dynamic-debug of zusFSs
Date:   Mon, 12 Aug 2019 19:48:06 +0300
Message-Id: <20190812164806.15852-17-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164806.15852-1-boazh@netapp.com>
References: <20190812164806.15852-1-boazh@netapp.com>
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
index 6ede8e509b9f..883f1465752b 100644
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
index 1f5f886997f7..620a4e03777e 100644
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
@@ -335,6 +410,7 @@ static int zufr_fill_super(struct super_block *sb, void *data, int silent)
 	static struct tree_descr zufr_files[] = {
 		[2] = {"state", &_state_ops, S_IFREG | 0400},
 		[3] = {"registered_fs", &_registered_fs_ops, S_IFREG | 0400},
+		[4] = {"ddbg", &_zus_ddbg_ops, S_IFREG | 0600},
 		{""},
 	};
 	struct zuf_root_info *zri;
-- 
2.20.1

