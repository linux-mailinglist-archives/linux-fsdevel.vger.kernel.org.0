Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D459934FB2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 10:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhCaIHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 04:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbhCaIG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:06:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BD5C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 01:06:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso810123pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 01:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DrGe+wSNv+5GrL/VvyrIF4G5z2Kf+xg5gmEDQCgKf7s=;
        b=DqzZ8q+OkgiXiUnK9PFEYEY4GPyyJUNJwl9trmeo91/ckMTVGZku5qS+JYUp6zbltv
         7JvdkVX4/kn4rtl7cFCIfEfQP+rRDpBLK3lx/1fTetBxfqIxNrXCCGHQhn3Cs9UAAe8j
         dEfKQZNP/uRhRK/+NsTGf2ALmlqAwKGqnklVdGVTMTTpLvLxqs+ujglBcrnEeLW9F8st
         IYRilOFnC/ht3Qb86fq7BfeHYXVqAkQTbbVeDhg84tYsOWIxpLX+liISgJbcKto8LEu7
         bc1z4i3IgIPP24H5wRqaa2c6qh0L8tCPEDgWo7QOxQQdgBRuH6lxgUd+3n+ii0sHchYm
         WAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DrGe+wSNv+5GrL/VvyrIF4G5z2Kf+xg5gmEDQCgKf7s=;
        b=Ja53aCa7Oce3mBlRjpri5fyIBDzpfyg4QO5qHdhRxu6YzgydKJhftqHKQCB8r4AnOp
         DeufjDSDiDgpjqaE9vklRBcai7L4oq41RUUxQRSNfCCPUxwioxiinCvm9UhHhm7mgly0
         G7KgfCGFOxfH3ycCNukFmx75g02edh6OFS5ZYFvboCWM3XjEPGLzNVdHi+EzWo8HjI/t
         mKIPobuaXcZDV4sCbqchn66YcqBL2GHTRI3tOt5mTuFp9VRYIJtHDCPU0JG+RjUKVyVL
         bzhtP97eptyikROInQnRRrPs4uAEZvTUdm7flg2FYU+DYSCwSXxui8T4dV49TdmEiaBu
         9N+w==
X-Gm-Message-State: AOAM533I2Vx8Zz66YTb6vstvqgLT28BQvEtf1qv0t00kt3AzMCB3Fcab
        3AYUzvVOkc+VbxP8ur5lmrq6
X-Google-Smtp-Source: ABdhPJzUZ0iCW38qBzP+z9ejwSF3QR26iU/iND3BjH9uOIBsmROmq3cVYSj9jxodUlUSY5l5upx6Gg==
X-Received: by 2002:a17:90b:3551:: with SMTP id lt17mr2338546pjb.89.1617178016286;
        Wed, 31 Mar 2021 01:06:56 -0700 (PDT)
Received: from localhost ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id w79sm1324798pfc.87.2021.03.31.01.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 01:06:55 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 10/10] Documentation: Add documentation for VDUSE
Date:   Wed, 31 Mar 2021 16:05:19 +0800
Message-Id: <20210331080519.172-11-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331080519.172-1-xieyongji@bytedance.com>
References: <20210331080519.172-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VDUSE (vDPA Device in Userspace) is a framework to support
implementing software-emulated vDPA devices in userspace. This
document is intended to clarify the VDUSE design and usage.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 Documentation/userspace-api/index.rst |   1 +
 Documentation/userspace-api/vduse.rst | 212 ++++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)
 create mode 100644 Documentation/userspace-api/vduse.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index acd2cc2a538d..f63119130898 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -24,6 +24,7 @@ place where this information is gathered.
    ioctl/index
    iommu
    media/index
+   vduse
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
new file mode 100644
index 000000000000..8c4e2b2df8bb
--- /dev/null
+++ b/Documentation/userspace-api/vduse.rst
@@ -0,0 +1,212 @@
+==================================
+VDUSE - "vDPA Device in Userspace"
+==================================
+
+vDPA (virtio data path acceleration) device is a device that uses a
+datapath which complies with the virtio specifications with vendor
+specific control path. vDPA devices can be both physically located on
+the hardware or emulated by software. VDUSE is a framework that makes it
+possible to implement software-emulated vDPA devices in userspace.
+
+How VDUSE works
+------------
+Each userspace vDPA device is created by the VDUSE_CREATE_DEV ioctl on
+the character device (/dev/vduse/control). Then a device file with the
+specified name (/dev/vduse/$NAME) will appear, which can be used to
+implement the userspace vDPA device's control path and data path.
+
+To implement control path, a message-based communication protocol and some
+types of control messages are introduced in the VDUSE framework:
+
+- VDUSE_SET_VQ_ADDR: Set the vring address of virtqueue.
+
+- VDUSE_SET_VQ_NUM: Set the size of virtqueue
+
+- VDUSE_SET_VQ_READY: Set ready status of virtqueue
+
+- VDUSE_GET_VQ_READY: Get ready status of virtqueue
+
+- VDUSE_SET_VQ_STATE: Set the state for virtqueue
+
+- VDUSE_GET_VQ_STATE: Get the state for virtqueue
+
+- VDUSE_SET_FEATURES: Set virtio features supported by the driver
+
+- VDUSE_GET_FEATURES: Get virtio features supported by the device
+
+- VDUSE_SET_STATUS: Set the device status
+
+- VDUSE_GET_STATUS: Get the device status
+
+- VDUSE_SET_CONFIG: Write to device specific configuration space
+
+- VDUSE_GET_CONFIG: Read from device specific configuration space
+
+- VDUSE_UPDATE_IOTLB: Notify userspace to update the memory mapping in device IOTLB
+
+Those control messages are mostly based on the vdpa_config_ops in
+include/linux/vdpa.h which defines a unified interface to control
+different types of vdpa device. Userspace needs to read()/write()
+on the VDUSE device file to receive/reply those control messages
+from/to VDUSE kernel module as follows:
+
+.. code-block:: c
+
+	static int vduse_message_handler(int dev_fd)
+	{
+		int len;
+		struct vduse_dev_request req;
+		struct vduse_dev_response resp;
+
+		len = read(dev_fd, &req, sizeof(req));
+		if (len != sizeof(req))
+			return -1;
+
+		resp.request_id = req.request_id;
+
+		switch (req.type) {
+
+		/* handle different types of message */
+
+		}
+
+		len = write(dev_fd, &resp, sizeof(resp));
+		if (len != sizeof(resp))
+			return -1;
+
+		return 0;
+	}
+
+In the data path, vDPA device's iova regions will be mapped into userspace
+with the help of VDUSE_IOTLB_GET_FD ioctl on the VDUSE device file:
+
+- VDUSE_IOTLB_GET_FD: get the file descriptor to the first overlapped iova region.
+  Userspace can access this iova region by passing fd and corresponding size, offset,
+  perm to mmap(). For example:
+
+.. code-block:: c
+
+	static int perm_to_prot(uint8_t perm)
+	{
+		int prot = 0;
+
+		switch (perm) {
+		case VDUSE_ACCESS_WO:
+			prot |= PROT_WRITE;
+			break;
+		case VDUSE_ACCESS_RO:
+			prot |= PROT_READ;
+			break;
+		case VDUSE_ACCESS_RW:
+			prot |= PROT_READ | PROT_WRITE;
+			break;
+		}
+
+		return prot;
+	}
+
+	static void *iova_to_va(int dev_fd, uint64_t iova, uint64_t *len)
+	{
+		int fd;
+		void *addr;
+		size_t size;
+		struct vduse_iotlb_entry entry;
+
+		entry.start = iova;
+		entry.last = iova + 1;
+		fd = ioctl(dev_fd, VDUSE_IOTLB_GET_FD, &entry);
+		if (fd < 0)
+			return NULL;
+
+		size = entry.last - entry.start + 1;
+		*len = entry.last - iova + 1;
+		addr = mmap(0, size, perm_to_prot(entry.perm), MAP_SHARED,
+			    fd, entry.offset);
+		close(fd);
+		if (addr == MAP_FAILED)
+			return NULL;
+
+		/* do something to cache this iova region */
+
+		return addr + iova - entry.start;
+	}
+
+Besides, the following ioctls on the VDUSE device file are provided to support
+interrupt injection and setting up eventfd for virtqueue kicks:
+
+- VDUSE_VQ_SETUP_KICKFD: set the kickfd for virtqueue, this eventfd is used
+  by VDUSE kernel module to notify userspace to consume the vring.
+
+- VDUSE_INJECT_VQ_IRQ: inject an interrupt for specific virtqueue
+
+- VDUSE_INJECT_CONFIG_IRQ: inject a config interrupt
+
+Register VDUSE device on vDPA bus
+---------------------------------
+In order to make the VDUSE device work, administrator needs to use the management
+API (netlink) to register it on vDPA bus. Some sample codes are show below:
+
+.. code-block:: c
+
+	static int netlink_add_vduse(const char *name, int device_id)
+	{
+		struct nl_sock *nlsock;
+		struct nl_msg *msg;
+		int famid;
+
+		nlsock = nl_socket_alloc();
+		if (!nlsock)
+			return -ENOMEM;
+
+		if (genl_connect(nlsock))
+			goto free_sock;
+
+		famid = genl_ctrl_resolve(nlsock, VDPA_GENL_NAME);
+		if (famid < 0)
+			goto close_sock;
+
+		msg = nlmsg_alloc();
+		if (!msg)
+			goto close_sock;
+
+		if (!genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, famid, 0, 0,
+		    VDPA_CMD_DEV_NEW, 0))
+			goto nla_put_failure;
+
+		NLA_PUT_STRING(msg, VDPA_ATTR_DEV_NAME, name);
+		NLA_PUT_STRING(msg, VDPA_ATTR_MGMTDEV_DEV_NAME, "vduse");
+		NLA_PUT_U32(msg, VDPA_ATTR_DEV_ID, device_id);
+
+		if (nl_send_sync(nlsock, msg))
+			goto close_sock;
+
+		nl_close(nlsock);
+		nl_socket_free(nlsock);
+
+		return 0;
+	nla_put_failure:
+		nlmsg_free(msg);
+	close_sock:
+		nl_close(nlsock);
+	free_sock:
+		nl_socket_free(nlsock);
+		return -1;
+	}
+
+MMU-based IOMMU Driver
+----------------------
+VDUSE framework implements an MMU-based on-chip IOMMU driver to support
+mapping the kernel DMA buffer into the userspace iova region dynamically.
+This is mainly designed for virtio-vdpa case (kernel virtio drivers).
+
+The basic idea behind this driver is treating MMU (VA->PA) as IOMMU (IOVA->PA).
+The driver will set up MMU mapping instead of IOMMU mapping for the DMA transfer
+so that the userspace process is able to use its virtual address to access
+the DMA buffer in kernel.
+
+And to avoid security issue, a bounce-buffering mechanism is introduced to
+prevent userspace accessing the original buffer directly which may contain other
+kernel data. During the mapping, unmapping, the driver will copy the data from
+the original buffer to the bounce buffer and back, depending on the direction of
+the transfer. And the bounce-buffer addresses will be mapped into the user address
+space instead of the original one.
-- 
2.11.0

