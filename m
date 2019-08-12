Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E68B8A3A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfHLQn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:43:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36325 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfHLQn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:43:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so172980wme.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJXb13v4i5mVaPeD5oagVaercElbJiuEhB1n5p+wfNY=;
        b=QVlun8dpZ9r2wEdjTLlrN1Wz2bC+RP3a7/pU9gD6HNjRg6O5ClqVmeZ0WVbOhmcEP1
         VN/5MCl6nAxZxLMrwCJf4yDhY3mJp5DECmhcadqH5Z1XlPMga5H65HvxHx2Pw7RFGVQU
         P2a+iLQGIs0NBQrmtFmmvD8qLadzk72yWPRk3Oi8Z98PuDWoSAxjL8VwFtjGdPGSyXcf
         MIR7UZHpkM5xkdfT4v4qYPVIODyjBAcJoS4anJ2+fZTJMQ9PLYySKWAtgdilJ4bajCWw
         wtSBA5z5ydy9Kj42R32rhzw/uCXScudfiV20QntmuMooHTMb86dV/aVxSYMbrfQTwhld
         TGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJXb13v4i5mVaPeD5oagVaercElbJiuEhB1n5p+wfNY=;
        b=YEqa9jZ/zxhiSTE0iocHlx0rPLXY2ZJkZFPVMqAsb8R4vgIheyHpn1UrrMoAsIUxdW
         xoXQSwuZnA6KjevPChkOux1qcDGCQ+3Guy5TNRcX4kt0HvMVUvTTOiOd20DDVVTZH0zv
         7ozzVoWJfu5VxtjtSECenqs11OjkzRVMKX08VNt+FF7a2p0W0ksDeNxr8W6XLU5Wkn4Q
         Hpt6x2Gqa41MYAEJIPYKrbB+G4ta7SuJovhmPlWy7OnimdCa2jUMVeJ48hrfNpcFPEuZ
         /I+SwjxEqs1iPEBAVKbI6Zh3VukoHmmAB2GvydqR3lk5VmI26TPLH+TzqRYyvvcTQpWl
         j+eA==
X-Gm-Message-State: APjAAAUCQ9Bo+6MnaLM3l3EyJyE2yZ0DtNdfAAC0LvP9x8hQi5CrrNgu
        eAAnYYq5RKzeDFQfD5XhZx5GlCtfpp4=
X-Google-Smtp-Source: APXvYqzoawHN/5w1rkAtm+tYYz8H0AfzAwXwTF0CGyXQEWDCOXo1sQ8kBHo6rA0ok4gop2v/6E3LVA==
X-Received: by 2002:a1c:45:: with SMTP id 66mr229101wma.40.1565628204017;
        Mon, 12 Aug 2019 09:43:24 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id c15sm53432266wrb.80.2019.08.12.09.43.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:43:23 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     Boaz Harrosh <boaz@plexistor.com>,
        Boaz Harrosh <ooo@electrozaur.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Boaz Harrosh <boazh@netapp.com>
Subject: [PATCH 16/16] zuf: Support for dynamic-debug of zusFSs
Date:   Mon, 12 Aug 2019 19:42:44 +0300
Message-Id: <20190812164244.15580-17-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164244.15580-1-boazh@netapp.com>
References: <20190812164244.15580-1-boazh@netapp.com>
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

