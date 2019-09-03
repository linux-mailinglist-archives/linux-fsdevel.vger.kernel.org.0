Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB97A67AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfICLmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:42:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbfICLmV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:21 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE3F08665D
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:20 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id c188so2720966wmd.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akpJ8ladLbh6nyZQKgfWxGWEd1gl2JfEWYKZ8pgAAJE=;
        b=k473PF9Dzgr/zcsPZ85NQiakYZkvnpAYRyb3z5HnUzE56ApcymGJB1/iWCnhUEX7D3
         XmLMzZ8KfRjgFW876+qzuzm0lX3C9eKpDbFooIHFBWMG/jTiP54ZA4Dfk1pWvEVTMoXU
         m5vOz0BYz6iNYDJmc2pp7Mlg16N90nXTXUFlO3sPX8qDFuDpC21ljyDTrvFhTZWXaTpv
         OHDnesuRrf+WLE4wGE+vxcjpCFuUHBl+qRsY/qCj9Ljuv0jujrpRIg3nDRyOzXY+D1X2
         PfnCk+l+uns9PbDZyuVjpWdei0LyYT/LdDPtLgVeuOFT7BD8WdrGWArb3hbjpjGQ05wG
         BHmw==
X-Gm-Message-State: APjAAAUaMdG2ihCmO4vYYf1561xddJVvCWgjQIf5jphad5K08hNkVMU6
        7xxnyLsUZ7gi1Osn+4iKufJUK9/lv68RXDJDQPSfu1Xu2CzCvIEc6gslXgYlJ9I098i6h2/HZKy
        xUbsHm1J4HGv84oQd8QYvIaWfGA==
X-Received: by 2002:a5d:54cd:: with SMTP id x13mr28427145wrv.12.1567510939126;
        Tue, 03 Sep 2019 04:42:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUAwDwiCjcQMBez9grcCZjxnOXg+38CXJbSti4glU6fdJjWMulQC1U93nN9LomwRoAvNSBBA==
X-Received: by 2002:a5d:54cd:: with SMTP id x13mr28427058wrv.12.1567510938365;
        Tue, 03 Sep 2019 04:42:18 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:17 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 15/16] virtio-fs: add virtiofs filesystem
Date:   Tue,  3 Sep 2019 13:42:02 +0200
Message-Id: <20190903114203.8278-10-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Add a basic file system module for virtio-fs.  This does not yet contain
shared data support between host and guest or metadata coherency speedups.
However it is already significantly faster than virtio-9p.

Design Overview
===============

With the goal of designing something with better performance and local file
system semantics, a bunch of ideas were proposed.

 - Use fuse protocol (instead of 9p) for communication between guest and
   host.  Guest kernel will be fuse client and a fuse server will run on
   host to serve the requests.

 - For data access inside guest, mmap portion of file in QEMU address space
   and guest accesses this memory using dax.  That way guest page cache is
   bypassed and there is only one copy of data (on host).  This will also
   enable mmap(MAP_SHARED) between guests.

 - For metadata coherency, there is a shared memory region which contains
   version number associated with metadata and any guest changing metadata
   updates version number and other guests refresh metadata on next access.
   This is yet to be implemented.

How virtio-fs differs from existing approaches
==============================================

The unique idea behind virtio-fs is to take advantage of the co-location of
the virtual machine and hypervisor to avoid communication (vmexits).

DAX allows file contents to be accessed without communication with the
hypervisor.  The shared memory region for metadata avoids communication in
the common case where metadata is unchanged.

By replacing expensive communication with cheaper shared memory accesses,
we expect to achieve better performance than approaches based on network
file system protocols.  In addition, this also makes it easier to achieve
local file system semantics (coherency).

These techniques are not applicable to network file system protocols since
the communications channel is bypassed by taking advantage of shared memory
on a local machine.  This is why we decided to build virtio-fs rather than
focus on 9P or NFS.

Caching Modes
=============

Like virtio-9p, different caching modes are supported which determine the
coherency level as well.  The “cache=FOO” and “writeback” options control
the level of coherence between the guest and host filesystems.

 - cache=none
   metadata, data and pathname lookup are not cached in guest.  They are
   always fetched from host and any changes are immediately pushed to host.

 - cache=always
   metadata, data and pathname lookup are cached in guest and never expire.

 - cache=auto
   metadata and pathname lookup cache expires after a configured amount of
   time (default is 1 second).  Data is cached while the file is open
   (close to open consistency).

 - writeback/no_writeback
   These options control the writeback strategy.  If writeback is disabled,
   then normal writes will immediately be synchronized with the host fs.
   If writeback is enabled, then writes may be cached in the guest until
   the file is closed or an fsync(2) performed.  This option has no effect
   on mmap-ed writes or writes going through the DAX mechanism.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/Kconfig                 |   11 +
 fs/fuse/Makefile                |    1 +
 fs/fuse/fuse_i.h                |    5 +
 fs/fuse/virtio_fs.c             | 1072 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_fs.h  |   19 +
 include/uapi/linux/virtio_ids.h |    1 +
 6 files changed, 1109 insertions(+)
 create mode 100644 fs/fuse/virtio_fs.c
 create mode 100644 include/uapi/linux/virtio_fs.h

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 24fc5a5c1b97..0635cba19971 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -27,3 +27,14 @@ config CUSE
 
 	  If you want to develop or use a userspace character device
 	  based on CUSE, answer Y or M.
+
+config VIRTIO_FS
+	tristate "Virtio Filesystem"
+	depends on FUSE_FS
+	select VIRTIO
+	help
+	  The Virtio Filesystem allows guests to mount file systems from the
+          host.
+
+	  If you want to share files between guests or with the host, answer Y
+          or M.
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 9485019c2a14..6419a2b3510d 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -5,5 +5,6 @@
 
 obj-$(CONFIG_FUSE_FS) += fuse.o
 obj-$(CONFIG_CUSE) += cuse.o
+obj-$(CONFIG_VIRTIO_FS) += virtio_fs.o
 
 fuse-objs := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index dbf73e5d5b38..85e2dcad68c1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -444,6 +444,11 @@ struct fuse_req {
 
 	/** Request is stolen from fuse_file->reserved_req */
 	struct file *stolen_file;
+
+#if IS_ENABLED(CONFIG_VIRTIO_FS)
+	/** virtio-fs's physically contiguous buffer for in and out args */
+	void *argbuf;
+#endif
 };
 
 struct fuse_iqueue;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
new file mode 100644
index 000000000000..197e79e536f9
--- /dev/null
+++ b/fs/fuse/virtio_fs.c
@@ -0,0 +1,1072 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * virtio-fs: Virtio Filesystem
+ * Copyright (C) 2018 Red Hat, Inc.
+ */
+
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/virtio.h>
+#include <linux/virtio_fs.h>
+#include <linux/delay.h>
+#include <linux/fs_context.h>
+#include <linux/highmem.h>
+#include "fuse_i.h"
+
+/* List of virtio-fs device instances and a lock for the list */
+static DEFINE_MUTEX(virtio_fs_mutex);
+static LIST_HEAD(virtio_fs_instances);
+
+enum {
+	VQ_HIPRIO,
+	VQ_REQUEST
+};
+
+/* Per-virtqueue state */
+struct virtio_fs_vq {
+	spinlock_t lock;
+	struct virtqueue *vq;     /* protected by ->lock */
+	struct work_struct done_work;
+	struct list_head queued_reqs;
+	struct delayed_work dispatch_work;
+	struct fuse_dev *fud;
+	bool connected;
+	long in_flight;
+	char name[24];
+} ____cacheline_aligned_in_smp;
+
+/* A virtio-fs device instance */
+struct virtio_fs {
+	struct list_head list;    /* on virtio_fs_instances */
+	char *tag;
+	struct virtio_fs_vq *vqs;
+	unsigned int nvqs;            /* number of virtqueues */
+	unsigned int num_queues;      /* number of request queues */
+};
+
+struct virtio_fs_forget {
+	struct fuse_in_header ih;
+	struct fuse_forget_in arg;
+	/* This request can be temporarily queued on virt queue */
+	struct list_head list;
+};
+
+static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
+{
+	struct virtio_fs *fs = vq->vdev->priv;
+
+	return &fs->vqs[vq->index];
+}
+
+static inline struct fuse_pqueue *vq_to_fpq(struct virtqueue *vq)
+{
+	return &vq_to_fsvq(vq)->fud->pq;
+}
+
+/* Add a new instance to the list or return -EEXIST if tag name exists*/
+static int virtio_fs_add_instance(struct virtio_fs *fs)
+{
+	struct virtio_fs *fs2;
+	bool duplicate = false;
+
+	mutex_lock(&virtio_fs_mutex);
+
+	list_for_each_entry(fs2, &virtio_fs_instances, list) {
+		if (strcmp(fs->tag, fs2->tag) == 0)
+			duplicate = true;
+	}
+
+	if (!duplicate)
+		list_add_tail(&fs->list, &virtio_fs_instances);
+
+	mutex_unlock(&virtio_fs_mutex);
+
+	if (duplicate)
+		return -EEXIST;
+	return 0;
+}
+
+/* Return the virtio_fs with a given tag, or NULL */
+static struct virtio_fs *virtio_fs_find_instance(const char *tag)
+{
+	struct virtio_fs *fs;
+
+	mutex_lock(&virtio_fs_mutex);
+
+	list_for_each_entry(fs, &virtio_fs_instances, list) {
+		if (strcmp(fs->tag, tag) == 0)
+			goto found;
+	}
+
+	fs = NULL; /* not found */
+
+found:
+	mutex_unlock(&virtio_fs_mutex);
+
+	return fs;
+}
+
+static void virtio_fs_free_devs(struct virtio_fs *fs)
+{
+	unsigned int i;
+
+	/* TODO lock */
+
+	for (i = 0; i < fs->nvqs; i++) {
+		struct virtio_fs_vq *fsvq = &fs->vqs[i];
+
+		if (!fsvq->fud)
+			continue;
+
+		flush_work(&fsvq->done_work);
+		flush_delayed_work(&fsvq->dispatch_work);
+
+		/* TODO need to quiesce/end_requests/decrement dev_count */
+		fuse_dev_free(fsvq->fud);
+		fsvq->fud = NULL;
+	}
+}
+
+/* Read filesystem name from virtio config into fs->tag (must kfree()). */
+static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
+{
+	char tag_buf[sizeof_field(struct virtio_fs_config, tag)];
+	char *end;
+	size_t len;
+
+	virtio_cread_bytes(vdev, offsetof(struct virtio_fs_config, tag),
+			   &tag_buf, sizeof(tag_buf));
+	end = memchr(tag_buf, '\0', sizeof(tag_buf));
+	if (end == tag_buf)
+		return -EINVAL; /* empty tag */
+	if (!end)
+		end = &tag_buf[sizeof(tag_buf)];
+
+	len = end - tag_buf;
+	fs->tag = devm_kmalloc(&vdev->dev, len + 1, GFP_KERNEL);
+	if (!fs->tag)
+		return -ENOMEM;
+	memcpy(fs->tag, tag_buf, len);
+	fs->tag[len] = '\0';
+	return 0;
+}
+
+/* Work function for hiprio completion */
+static void virtio_fs_hiprio_done_work(struct work_struct *work)
+{
+	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
+						 done_work);
+	struct virtqueue *vq = fsvq->vq;
+
+	/* Free completed FUSE_FORGET requests */
+	spin_lock(&fsvq->lock);
+	do {
+		unsigned int len;
+		void *req;
+
+		virtqueue_disable_cb(vq);
+
+		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
+			kfree(req);
+			fsvq->in_flight--;
+		}
+	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
+	spin_unlock(&fsvq->lock);
+}
+
+static void virtio_fs_dummy_dispatch_work(struct work_struct *work)
+{
+}
+
+static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
+{
+	struct virtio_fs_forget *forget;
+	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
+						 dispatch_work.work);
+	struct virtqueue *vq = fsvq->vq;
+	struct scatterlist sg;
+	struct scatterlist *sgs[] = {&sg};
+	bool notify;
+	int ret;
+
+	pr_debug("virtio-fs: worker %s called.\n", __func__);
+	while (1) {
+		spin_lock(&fsvq->lock);
+		forget = list_first_entry_or_null(&fsvq->queued_reqs,
+					struct virtio_fs_forget, list);
+		if (!forget) {
+			spin_unlock(&fsvq->lock);
+			return;
+		}
+
+		list_del(&forget->list);
+		if (!fsvq->connected) {
+			spin_unlock(&fsvq->lock);
+			kfree(forget);
+			continue;
+		}
+
+		sg_init_one(&sg, forget, sizeof(*forget));
+
+		/* Enqueue the request */
+		dev_dbg(&vq->vdev->dev, "%s\n", __func__);
+		ret = virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
+		if (ret < 0) {
+			if (ret == -ENOMEM || ret == -ENOSPC) {
+				pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
+					 ret);
+				list_add_tail(&forget->list,
+						&fsvq->queued_reqs);
+				schedule_delayed_work(&fsvq->dispatch_work,
+						msecs_to_jiffies(1));
+			} else {
+				pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
+					 ret);
+				kfree(forget);
+			}
+			spin_unlock(&fsvq->lock);
+			return;
+		}
+
+		fsvq->in_flight++;
+		notify = virtqueue_kick_prepare(vq);
+		spin_unlock(&fsvq->lock);
+
+		if (notify)
+			virtqueue_notify(vq);
+		pr_debug("virtio-fs: worker %s dispatched one forget request.\n",
+			 __func__);
+	}
+}
+
+/* Allocate and copy args into req->argbuf */
+static int copy_args_to_argbuf(struct fuse_req *req)
+{
+	unsigned int offset = 0;
+	unsigned int num_in;
+	unsigned int num_out;
+	unsigned int len;
+	unsigned int i;
+
+	num_in = req->in.numargs - req->in.argpages;
+	num_out = req->out.numargs - req->out.argpages;
+	len = fuse_len_args(num_in, (struct fuse_arg *)req->in.args) +
+	      fuse_len_args(num_out, req->out.args);
+
+	req->argbuf = kmalloc(len, GFP_ATOMIC);
+	if (!req->argbuf)
+		return -ENOMEM;
+
+	for (i = 0; i < num_in; i++) {
+		memcpy(req->argbuf + offset,
+		       req->in.args[i].value,
+		       req->in.args[i].size);
+		offset += req->in.args[i].size;
+	}
+
+	return 0;
+}
+
+/* Copy args out of and free req->argbuf */
+static void copy_args_from_argbuf(struct fuse_req *req)
+{
+	unsigned int remaining;
+	unsigned int offset;
+	unsigned int num_in;
+	unsigned int num_out;
+	unsigned int i;
+
+	remaining = req->out.h.len - sizeof(req->out.h);
+	num_in = req->in.numargs - req->in.argpages;
+	num_out = req->out.numargs - req->out.argpages;
+	offset = fuse_len_args(num_in, (struct fuse_arg *)req->in.args);
+
+	for (i = 0; i < num_out; i++) {
+		unsigned int argsize = req->out.args[i].size;
+
+		if (req->out.argvar &&
+		    i == req->out.numargs - 1 &&
+		    argsize > remaining) {
+			argsize = remaining;
+		}
+
+		memcpy(req->out.args[i].value, req->argbuf + offset, argsize);
+		offset += argsize;
+
+		if (i != req->out.numargs - 1)
+			remaining -= argsize;
+	}
+
+	/* Store the actual size of the variable-length arg */
+	if (req->out.argvar)
+		req->out.args[req->out.numargs - 1].size = remaining;
+
+	kfree(req->argbuf);
+	req->argbuf = NULL;
+}
+
+/* Work function for request completion */
+static void virtio_fs_requests_done_work(struct work_struct *work)
+{
+	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
+						 done_work);
+	struct fuse_pqueue *fpq = &fsvq->fud->pq;
+	struct fuse_conn *fc = fsvq->fud->fc;
+	struct virtqueue *vq = fsvq->vq;
+	struct fuse_req *req;
+	struct fuse_req *next;
+	unsigned int len, i, thislen;
+	struct page *page;
+	LIST_HEAD(reqs);
+
+	/* Collect completed requests off the virtqueue */
+	spin_lock(&fsvq->lock);
+	do {
+		virtqueue_disable_cb(vq);
+
+		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
+			spin_lock(&fpq->lock);
+			list_move_tail(&req->list, &reqs);
+			spin_unlock(&fpq->lock);
+		}
+	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
+	spin_unlock(&fsvq->lock);
+
+	/* End requests */
+	list_for_each_entry_safe(req, next, &reqs, list) {
+		/* TODO check unique */
+		/* TODO fuse_len_args(out) against oh.len */
+
+		copy_args_from_argbuf(req);
+
+		if (req->out.argpages && req->out.page_zeroing) {
+			len = req->out.args[req->out.numargs - 1].size;
+			for (i = 0; i < req->num_pages; i++) {
+				thislen = req->page_descs[i].length;
+				if (len < thislen) {
+					WARN_ON(req->page_descs[i].offset);
+					page = req->pages[i];
+					zero_user_segment(page, len, thislen);
+					len = 0;
+				} else {
+					len -= thislen;
+				}
+			}
+		}
+
+		spin_lock(&fpq->lock);
+		clear_bit(FR_SENT, &req->flags);
+		list_del_init(&req->list);
+		spin_unlock(&fpq->lock);
+
+		fuse_request_end(fc, req);
+	}
+}
+
+/* Virtqueue interrupt handler */
+static void virtio_fs_vq_done(struct virtqueue *vq)
+{
+	struct virtio_fs_vq *fsvq = vq_to_fsvq(vq);
+
+	dev_dbg(&vq->vdev->dev, "%s %s\n", __func__, fsvq->name);
+
+	schedule_work(&fsvq->done_work);
+}
+
+/* Initialize virtqueues */
+static int virtio_fs_setup_vqs(struct virtio_device *vdev,
+			       struct virtio_fs *fs)
+{
+	struct virtqueue **vqs;
+	vq_callback_t **callbacks;
+	const char **names;
+	unsigned int i;
+	int ret;
+
+	virtio_cread(vdev, struct virtio_fs_config, num_queues,
+		     &fs->num_queues);
+	if (fs->num_queues == 0)
+		return -EINVAL;
+
+	fs->nvqs = 1 + fs->num_queues;
+
+	fs->vqs = devm_kcalloc(&vdev->dev, fs->nvqs,
+				sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
+	if (!fs->vqs)
+		return -ENOMEM;
+
+	vqs = kmalloc_array(fs->nvqs, sizeof(vqs[VQ_HIPRIO]), GFP_KERNEL);
+	callbacks = kmalloc_array(fs->nvqs, sizeof(callbacks[VQ_HIPRIO]),
+					GFP_KERNEL);
+	names = kmalloc_array(fs->nvqs, sizeof(names[VQ_HIPRIO]), GFP_KERNEL);
+	if (!vqs || !callbacks || !names) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	callbacks[VQ_HIPRIO] = virtio_fs_vq_done;
+	snprintf(fs->vqs[VQ_HIPRIO].name, sizeof(fs->vqs[VQ_HIPRIO].name),
+			"hiprio");
+	names[VQ_HIPRIO] = fs->vqs[VQ_HIPRIO].name;
+	INIT_WORK(&fs->vqs[VQ_HIPRIO].done_work, virtio_fs_hiprio_done_work);
+	INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].queued_reqs);
+	INIT_DELAYED_WORK(&fs->vqs[VQ_HIPRIO].dispatch_work,
+			virtio_fs_hiprio_dispatch_work);
+	spin_lock_init(&fs->vqs[VQ_HIPRIO].lock);
+
+	/* Initialize the requests virtqueues */
+	for (i = VQ_REQUEST; i < fs->nvqs; i++) {
+		spin_lock_init(&fs->vqs[i].lock);
+		INIT_WORK(&fs->vqs[i].done_work, virtio_fs_requests_done_work);
+		INIT_DELAYED_WORK(&fs->vqs[i].dispatch_work,
+					virtio_fs_dummy_dispatch_work);
+		INIT_LIST_HEAD(&fs->vqs[i].queued_reqs);
+		snprintf(fs->vqs[i].name, sizeof(fs->vqs[i].name),
+			 "requests.%u", i - VQ_REQUEST);
+		callbacks[i] = virtio_fs_vq_done;
+		names[i] = fs->vqs[i].name;
+	}
+
+	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, NULL);
+	if (ret < 0)
+		goto out;
+
+	for (i = 0; i < fs->nvqs; i++) {
+		fs->vqs[i].vq = vqs[i];
+		fs->vqs[i].connected = true;
+	}
+out:
+	kfree(names);
+	kfree(callbacks);
+	kfree(vqs);
+	return ret;
+}
+
+/* Free virtqueues (device must already be reset) */
+static void virtio_fs_cleanup_vqs(struct virtio_device *vdev,
+				  struct virtio_fs *fs)
+{
+	vdev->config->del_vqs(vdev);
+}
+
+static int virtio_fs_probe(struct virtio_device *vdev)
+{
+	struct virtio_fs *fs;
+	int ret;
+
+	fs = devm_kzalloc(&vdev->dev, sizeof(*fs), GFP_KERNEL);
+	if (!fs)
+		return -ENOMEM;
+	vdev->priv = fs;
+
+	ret = virtio_fs_read_tag(vdev, fs);
+	if (ret < 0)
+		goto out;
+
+	ret = virtio_fs_setup_vqs(vdev, fs);
+	if (ret < 0)
+		goto out;
+
+	/* TODO vq affinity */
+	/* TODO populate notifications vq */
+
+	/* Bring the device online in case the filesystem is mounted and
+	 * requests need to be sent before we return.
+	 */
+	virtio_device_ready(vdev);
+
+	ret = virtio_fs_add_instance(fs);
+	if (ret < 0)
+		goto out_vqs;
+
+	return 0;
+
+out_vqs:
+	vdev->config->reset(vdev);
+	virtio_fs_cleanup_vqs(vdev, fs);
+
+out:
+	vdev->priv = NULL;
+	return ret;
+}
+
+static void virtio_fs_remove(struct virtio_device *vdev)
+{
+	struct virtio_fs *fs = vdev->priv;
+
+	virtio_fs_free_devs(fs);
+
+	vdev->config->reset(vdev);
+	virtio_fs_cleanup_vqs(vdev, fs);
+
+	mutex_lock(&virtio_fs_mutex);
+	list_del(&fs->list);
+	mutex_unlock(&virtio_fs_mutex);
+
+	vdev->priv = NULL;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int virtio_fs_freeze(struct virtio_device *vdev)
+{
+	return 0; /* TODO */
+}
+
+static int virtio_fs_restore(struct virtio_device *vdev)
+{
+	return 0; /* TODO */
+}
+#endif /* CONFIG_PM_SLEEP */
+
+const static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_FS, VIRTIO_DEV_ANY_ID },
+	{},
+};
+
+const static unsigned int feature_table[] = {};
+
+static struct virtio_driver virtio_fs_driver = {
+	.driver.name		= KBUILD_MODNAME,
+	.driver.owner		= THIS_MODULE,
+	.id_table		= id_table,
+	.feature_table		= feature_table,
+	.feature_table_size	= ARRAY_SIZE(feature_table),
+	/* TODO validate config_get != NULL */
+	.probe			= virtio_fs_probe,
+	.remove			= virtio_fs_remove,
+#ifdef CONFIG_PM_SLEEP
+	.freeze			= virtio_fs_freeze,
+	.restore		= virtio_fs_restore,
+#endif
+};
+
+static void virtio_fs_wake_forget_and_unlock(struct fuse_iqueue *fiq)
+__releases(fiq->waitq.lock)
+{
+	struct fuse_forget_link *link;
+	struct virtio_fs_forget *forget;
+	struct scatterlist sg;
+	struct scatterlist *sgs[] = {&sg};
+	struct virtio_fs *fs;
+	struct virtqueue *vq;
+	struct virtio_fs_vq *fsvq;
+	bool notify;
+	u64 unique;
+	int ret;
+
+	link = fuse_dequeue_forget(fiq, 1, NULL);
+	unique = fuse_get_unique(fiq);
+
+	fs = fiq->priv;
+	fsvq = &fs->vqs[VQ_HIPRIO];
+	spin_unlock(&fiq->waitq.lock);
+
+	/* Allocate a buffer for the request */
+	forget = kmalloc(sizeof(*forget), GFP_NOFS | __GFP_NOFAIL);
+
+	forget->ih = (struct fuse_in_header){
+		.opcode = FUSE_FORGET,
+		.nodeid = link->forget_one.nodeid,
+		.unique = unique,
+		.len = sizeof(*forget),
+	};
+	forget->arg = (struct fuse_forget_in){
+		.nlookup = link->forget_one.nlookup,
+	};
+
+	sg_init_one(&sg, forget, sizeof(*forget));
+
+	/* Enqueue the request */
+	vq = fsvq->vq;
+	dev_dbg(&vq->vdev->dev, "%s\n", __func__);
+	spin_lock(&fsvq->lock);
+
+	ret = virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
+	if (ret < 0) {
+		if (ret == -ENOMEM || ret == -ENOSPC) {
+			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later.\n",
+				 ret);
+			list_add_tail(&forget->list, &fsvq->queued_reqs);
+			schedule_delayed_work(&fsvq->dispatch_work,
+					msecs_to_jiffies(1));
+		} else {
+			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
+				 ret);
+			kfree(forget);
+		}
+		spin_unlock(&fsvq->lock);
+		goto out;
+	}
+
+	fsvq->in_flight++;
+	notify = virtqueue_kick_prepare(vq);
+
+	spin_unlock(&fsvq->lock);
+
+	if (notify)
+		virtqueue_notify(vq);
+out:
+	kfree(link);
+}
+
+static void virtio_fs_wake_interrupt_and_unlock(struct fuse_iqueue *fiq)
+__releases(fiq->waitq.lock)
+{
+	/* TODO */
+	spin_unlock(&fiq->waitq.lock);
+}
+
+/* Return the number of scatter-gather list elements required */
+static unsigned int sg_count_fuse_req(struct fuse_req *req)
+{
+	unsigned int total_sgs = 1 /* fuse_in_header */;
+
+	if (req->in.numargs - req->in.argpages)
+		total_sgs += 1;
+
+	if (req->in.argpages)
+		total_sgs += req->num_pages;
+
+	if (!test_bit(FR_ISREPLY, &req->flags))
+		return total_sgs;
+
+	total_sgs += 1 /* fuse_out_header */;
+
+	if (req->out.numargs - req->out.argpages)
+		total_sgs += 1;
+
+	if (req->out.argpages)
+		total_sgs += req->num_pages;
+
+	return total_sgs;
+}
+
+/* Add pages to scatter-gather list and return number of elements used */
+static unsigned int sg_init_fuse_pages(struct scatterlist *sg,
+				       struct page **pages,
+				       struct fuse_page_desc *page_descs,
+				       unsigned int num_pages,
+				       unsigned int total_len)
+{
+	unsigned int i;
+	unsigned int this_len;
+
+	for (i = 0; i < num_pages && total_len; i++) {
+		sg_init_table(&sg[i], 1);
+		this_len =  min(page_descs[i].length, total_len);
+		sg_set_page(&sg[i], pages[i], this_len, page_descs[i].offset);
+		total_len -= this_len;
+	}
+
+	return i;
+}
+
+/* Add args to scatter-gather list and return number of elements used */
+static unsigned int sg_init_fuse_args(struct scatterlist *sg,
+				      struct fuse_req *req,
+				      struct fuse_arg *args,
+				      unsigned int numargs,
+				      bool argpages,
+				      void *argbuf,
+				      unsigned int *len_used)
+{
+	unsigned int total_sgs = 0;
+	unsigned int len;
+
+	len = fuse_len_args(numargs - argpages, args);
+	if (len)
+		sg_init_one(&sg[total_sgs++], argbuf, len);
+
+	if (argpages)
+		total_sgs += sg_init_fuse_pages(&sg[total_sgs],
+						req->pages,
+						req->page_descs,
+						req->num_pages,
+						args[numargs - 1].size);
+
+	if (len_used)
+		*len_used = len;
+
+	return total_sgs;
+}
+
+/* Add a request to a virtqueue and kick the device */
+static int virtio_fs_enqueue_req(struct virtqueue *vq, struct fuse_req *req)
+{
+	/* requests need at least 4 elements */
+	struct scatterlist *stack_sgs[6];
+	struct scatterlist stack_sg[ARRAY_SIZE(stack_sgs)];
+	struct scatterlist **sgs = stack_sgs;
+	struct scatterlist *sg = stack_sg;
+	struct virtio_fs_vq *fsvq;
+	unsigned int argbuf_used = 0;
+	unsigned int out_sgs = 0;
+	unsigned int in_sgs = 0;
+	unsigned int total_sgs;
+	unsigned int i;
+	int ret;
+	bool notify;
+
+	/* Does the sglist fit on the stack? */
+	total_sgs = sg_count_fuse_req(req);
+	if (total_sgs > ARRAY_SIZE(stack_sgs)) {
+		sgs = kmalloc_array(total_sgs, sizeof(sgs[0]), GFP_ATOMIC);
+		sg = kmalloc_array(total_sgs, sizeof(sg[0]), GFP_ATOMIC);
+		if (!sgs || !sg) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	/* Use a bounce buffer since stack args cannot be mapped */
+	ret = copy_args_to_argbuf(req);
+	if (ret < 0)
+		goto out;
+
+	/* Request elements */
+	sg_init_one(&sg[out_sgs++], &req->in.h, sizeof(req->in.h));
+	out_sgs += sg_init_fuse_args(&sg[out_sgs], req,
+				     (struct fuse_arg *)req->in.args,
+				     req->in.numargs, req->in.argpages,
+				     req->argbuf, &argbuf_used);
+
+	/* Reply elements */
+	if (test_bit(FR_ISREPLY, &req->flags)) {
+		sg_init_one(&sg[out_sgs + in_sgs++],
+			    &req->out.h, sizeof(req->out.h));
+		in_sgs += sg_init_fuse_args(&sg[out_sgs + in_sgs], req,
+					    req->out.args, req->out.numargs,
+					    req->out.argpages,
+					    req->argbuf + argbuf_used, NULL);
+	}
+
+	WARN_ON(out_sgs + in_sgs != total_sgs);
+
+	for (i = 0; i < total_sgs; i++)
+		sgs[i] = &sg[i];
+
+	fsvq = vq_to_fsvq(vq);
+	spin_lock(&fsvq->lock);
+
+	ret = virtqueue_add_sgs(vq, sgs, out_sgs, in_sgs, req, GFP_ATOMIC);
+	if (ret < 0) {
+		/* TODO handle full virtqueue */
+		spin_unlock(&fsvq->lock);
+		goto out;
+	}
+
+	notify = virtqueue_kick_prepare(vq);
+
+	spin_unlock(&fsvq->lock);
+
+	if (notify)
+		virtqueue_notify(vq);
+
+out:
+	if (ret < 0 && req->argbuf) {
+		kfree(req->argbuf);
+		req->argbuf = NULL;
+	}
+	if (sgs != stack_sgs) {
+		kfree(sgs);
+		kfree(sg);
+	}
+
+	return ret;
+}
+
+static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
+__releases(fiq->waitq.lock)
+{
+	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
+	struct virtio_fs *fs;
+	struct fuse_conn *fc;
+	struct fuse_req *req;
+	struct fuse_pqueue *fpq;
+	int ret;
+
+	WARN_ON(list_empty(&fiq->pending));
+	req = list_last_entry(&fiq->pending, struct fuse_req, list);
+	clear_bit(FR_PENDING, &req->flags);
+	list_del_init(&req->list);
+	WARN_ON(!list_empty(&fiq->pending));
+	spin_unlock(&fiq->waitq.lock);
+
+	fs = fiq->priv;
+	fc = fs->vqs[queue_id].fud->fc;
+
+	dev_dbg(&fs->vqs[queue_id].vq->vdev->dev,
+		"%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
+		__func__, req->in.h.opcode, req->in.h.unique, req->in.h.nodeid,
+		req->in.h.len, fuse_len_args(req->out.numargs, req->out.args));
+
+	fpq = &fs->vqs[queue_id].fud->pq;
+	spin_lock(&fpq->lock);
+	if (!fpq->connected) {
+		spin_unlock(&fpq->lock);
+		req->out.h.error = -ENODEV;
+		pr_err("virtio-fs: %s disconnected\n", __func__);
+		fuse_request_end(fc, req);
+		return;
+	}
+	list_add_tail(&req->list, fpq->processing);
+	spin_unlock(&fpq->lock);
+	set_bit(FR_SENT, &req->flags);
+	/* matches barrier in request_wait_answer() */
+	smp_mb__after_atomic();
+	/* TODO check for FR_INTERRUPTED? */
+
+retry:
+	ret = virtio_fs_enqueue_req(fs->vqs[queue_id].vq, req);
+	if (ret < 0) {
+		if (ret == -ENOMEM || ret == -ENOSPC) {
+			/* Virtqueue full. Retry submission */
+			usleep_range(20, 30);
+			goto retry;
+		}
+		req->out.h.error = ret;
+		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
+		fuse_request_end(fc, req);
+		return;
+	}
+}
+
+static void virtio_fs_flush_hiprio_queue(struct virtio_fs_vq *fsvq)
+{
+	struct virtio_fs_forget *forget;
+
+	WARN_ON(fsvq->in_flight < 0);
+
+	/* Go through pending forget requests and free them */
+	spin_lock(&fsvq->lock);
+	while (1) {
+		forget = list_first_entry_or_null(&fsvq->queued_reqs,
+					struct virtio_fs_forget, list);
+		if (!forget)
+			break;
+		list_del(&forget->list);
+		kfree(forget);
+	}
+
+	spin_unlock(&fsvq->lock);
+
+	/* Wait for in flight requests to finish.*/
+	while (1) {
+		spin_lock(&fsvq->lock);
+		if (!fsvq->in_flight) {
+			spin_unlock(&fsvq->lock);
+			break;
+		}
+		spin_unlock(&fsvq->lock);
+		usleep_range(1000, 2000);
+	}
+}
+
+const static struct fuse_iqueue_ops virtio_fs_fiq_ops = {
+	.wake_forget_and_unlock		= virtio_fs_wake_forget_and_unlock,
+	.wake_interrupt_and_unlock	= virtio_fs_wake_interrupt_and_unlock,
+	.wake_pending_and_unlock	= virtio_fs_wake_pending_and_unlock,
+};
+
+static int virtio_fs_fill_super(struct super_block *sb)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct virtio_fs *fs = fc->iq.priv;
+	unsigned int i;
+	int err;
+	struct fuse_req *init_req;
+	struct fuse_fs_context ctx = {
+		.rootmode = S_IFDIR,
+		.default_permissions = 1,
+		.allow_other = 1,
+		.max_read = UINT_MAX,
+		.blksize = 512,
+		.destroy = true,
+		.no_control = true,
+		.no_force_umount = true,
+	};
+
+	/* TODO lock */
+	if (fs->vqs[VQ_REQUEST].fud) {
+		pr_err("virtio-fs: device already in use\n");
+		err = -EBUSY;
+		goto err;
+	}
+
+	err = -ENOMEM;
+	/* Allocate fuse_dev for hiprio and notification queues */
+	for (i = 0; i < VQ_REQUEST; i++) {
+		struct virtio_fs_vq *fsvq = &fs->vqs[i];
+
+		fsvq->fud = fuse_dev_alloc();
+		if (!fsvq->fud)
+			goto err_free_fuse_devs;
+	}
+
+	init_req = fuse_request_alloc(0);
+	if (!init_req)
+		goto err_free_fuse_devs;
+	__set_bit(FR_BACKGROUND, &init_req->flags);
+
+	ctx.fudptr = (void **)&fs->vqs[VQ_REQUEST].fud;
+	err = fuse_fill_super_common(sb, &ctx);
+	if (err < 0)
+		goto err_free_init_req;
+
+	fc = fs->vqs[VQ_REQUEST].fud->fc;
+
+	/* TODO take fuse_mutex around this loop? */
+	for (i = 0; i < fs->nvqs; i++) {
+		struct virtio_fs_vq *fsvq = &fs->vqs[i];
+
+		if (i == VQ_REQUEST)
+			continue; /* already initialized */
+		fuse_dev_install(fsvq->fud, fc);
+		atomic_inc(&fc->dev_count);
+	}
+
+	fuse_send_init(fc, init_req);
+	return 0;
+
+err_free_init_req:
+	fuse_request_free(init_req);
+err_free_fuse_devs:
+	for (i = 0; i < fs->nvqs; i++)
+		fuse_dev_free(fs->vqs[i].fud);
+err:
+	return err;
+}
+
+static void virtio_kill_sb(struct super_block *sb)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct virtio_fs *vfs;
+	struct virtio_fs_vq *fsvq;
+
+	/* If mount failed, we can still be called without any fc */
+	if (!fc)
+		return fuse_kill_sb_anon(sb);
+
+	vfs = fc->iq.priv;
+	fsvq = &vfs->vqs[VQ_HIPRIO];
+
+	/* Stop forget queue. Soon destroy will be sent */
+	spin_lock(&fsvq->lock);
+	fsvq->connected = false;
+	spin_unlock(&fsvq->lock);
+	virtio_fs_flush_hiprio_queue(fsvq);
+
+	fuse_kill_sb_anon(sb);
+	virtio_fs_free_devs(vfs);
+}
+
+static int virtio_fs_test_super(struct super_block *sb,
+				struct fs_context *fsc)
+{
+	struct fuse_conn *fc = fsc->s_fs_info;
+
+	return fc->iq.priv == get_fuse_conn_super(sb)->iq.priv;
+}
+
+static int virtio_fs_set_super(struct super_block *sb,
+			       struct fs_context *fsc)
+{
+	int err;
+
+	err = get_anon_bdev(&sb->s_dev);
+	if (!err)
+		fuse_conn_get(fsc->s_fs_info);
+
+	return err;
+}
+
+static int virtio_fs_get_tree(struct fs_context *fsc)
+{
+	struct virtio_fs *fs;
+	struct super_block *sb;
+	struct fuse_conn *fc;
+	int err;
+
+	fs = virtio_fs_find_instance(fsc->source);
+	if (!fs) {
+		pr_info("virtio-fs: tag <%s> not found\n", fsc->source);
+		return -EINVAL;
+	}
+
+	fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
+	if (!fc)
+		return -ENOMEM;
+
+	fuse_conn_init(fc, get_user_ns(current_user_ns()), &virtio_fs_fiq_ops,
+		       fs);
+	fc->release = fuse_free_conn;
+	fc->delete_stale = true;
+
+	fsc->s_fs_info = fc;
+	sb = sget_fc(fsc, virtio_fs_test_super, virtio_fs_set_super);
+	fuse_conn_put(fc);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	if (!sb->s_root) {
+		err = virtio_fs_fill_super(sb);
+		if (err) {
+			deactivate_locked_super(sb);
+			return err;
+		}
+
+		sb->s_flags |= SB_ACTIVE;
+	}
+
+	WARN_ON(fsc->root);
+	fsc->root = dget(sb->s_root);
+	return 0;
+}
+
+static const struct fs_context_operations virtio_fs_context_ops = {
+	.get_tree	= virtio_fs_get_tree,
+};
+
+static int virtio_fs_init_fs_context(struct fs_context *fsc)
+{
+	fsc->ops = &virtio_fs_context_ops;
+	return 0;
+}
+
+static struct file_system_type virtio_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "virtiofs",
+	.init_fs_context = virtio_fs_init_fs_context,
+	.kill_sb	= virtio_kill_sb,
+};
+
+static int __init virtio_fs_init(void)
+{
+	int ret;
+
+	ret = register_virtio_driver(&virtio_fs_driver);
+	if (ret < 0)
+		return ret;
+
+	ret = register_filesystem(&virtio_fs_type);
+	if (ret < 0) {
+		unregister_virtio_driver(&virtio_fs_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(virtio_fs_init);
+
+static void __exit virtio_fs_exit(void)
+{
+	unregister_filesystem(&virtio_fs_type);
+	unregister_virtio_driver(&virtio_fs_driver);
+}
+module_exit(virtio_fs_exit);
+
+MODULE_AUTHOR("Stefan Hajnoczi <stefanha@redhat.com>");
+MODULE_DESCRIPTION("Virtio Filesystem");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_FS(KBUILD_MODNAME);
+MODULE_DEVICE_TABLE(virtio, id_table);
diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
new file mode 100644
index 000000000000..b5e99c217c86
--- /dev/null
+++ b/include/uapi/linux/virtio_fs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UAPI_LINUX_VIRTIO_FS_H
+#define _UAPI_LINUX_VIRTIO_FS_H
+
+#include <linux/types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_types.h>
+
+struct virtio_fs_config {
+	/* Filesystem name (UTF-8, not NUL-terminated, padded with NULs) */
+	__u8 tag[36];
+
+	/* Number of request queues */
+	__u32 num_queues;
+} __attribute__((packed));
+
+#endif /* _UAPI_LINUX_VIRTIO_FS_H */
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 348fd0176f75..585e07b27333 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -44,6 +44,7 @@
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
 #define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
+#define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.21.0

