Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFD3357CD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 08:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhDHG5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 02:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhDHG5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617865048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaYkgYQd1T50pHu2n8PHvDfrgbTCt/YHvOcBPz72Vac=;
        b=fpk0RrmNNFmmuZG0aTEYylQs6K1TKuFMPgnDg/g7a8DV89y8PQaZs0DyH3+nltzf18B9LS
        9PSNopcjcCTirN6wgAh5FquE1bx0L11SFwQpri0aoKWXWWHA1ZDrhBuZ9rvCW/tkD6eF04
        EnqgXf2GzCrEgxYgCEtH8B1+7SmrOSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-mhJgrrNGMtmhcLZDi_gVFw-1; Thu, 08 Apr 2021 02:57:26 -0400
X-MC-Unique: mhJgrrNGMtmhcLZDi_gVFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1009801814;
        Thu,  8 Apr 2021 06:57:23 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5457C7959D;
        Thu,  8 Apr 2021 06:57:08 +0000 (UTC)
Subject: Re: [PATCH v6 09/10] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-10-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c817178a-2ac8-bf93-1ed3-528579c657a3@redhat.com>
Date:   Thu, 8 Apr 2021 14:57:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331080519.172-10-xieyongji@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/3/31 下午4:05, Xie Yongji 写道:
> This VDUSE driver enables implementing vDPA devices in userspace.
> Both control path and data path of vDPA devices will be able to
> be handled in userspace.
>
> In the control path, the VDUSE driver will make use of message
> mechnism to forward the config operation from vdpa bus driver
> to userspace. Userspace can use read()/write() to receive/reply
> those control messages.
>
> In the data path, VDUSE_IOTLB_GET_FD ioctl will be used to get
> the file descriptors referring to vDPA device's iova regions. Then
> userspace can use mmap() to access those iova regions. Besides,
> userspace can use ioctl() to inject interrupt and use the eventfd
> mechanism to receive virtqueue kicks.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
>   drivers/vdpa/Kconfig                               |   10 +
>   drivers/vdpa/Makefile                              |    1 +
>   drivers/vdpa/vdpa_user/Makefile                    |    5 +
>   drivers/vdpa/vdpa_user/vduse_dev.c                 | 1362 ++++++++++++++++++++
>   include/uapi/linux/vduse.h                         |  175 +++
>   6 files changed, 1554 insertions(+)
>   create mode 100644 drivers/vdpa/vdpa_user/Makefile
>   create mode 100644 drivers/vdpa/vdpa_user/vduse_dev.c
>   create mode 100644 include/uapi/linux/vduse.h
>
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a4c75a28c839..71722e6f8f23 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -300,6 +300,7 @@ Code  Seq#    Include File                                           Comments
>   'z'   10-4F  drivers/s390/crypto/zcrypt_api.h                        conflict!
>   '|'   00-7F  linux/media.h
>   0x80  00-1F  linux/fb.h
> +0x81  00-1F  linux/vduse.h
>   0x89  00-06  arch/x86/include/asm/sockios.h
>   0x89  0B-DF  linux/sockios.h
>   0x89  E0-EF  linux/sockios.h                                         SIOCPROTOPRIVATE range
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index a245809c99d0..77a1da522c21 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -25,6 +25,16 @@ config VDPA_SIM_NET
>   	help
>   	  vDPA networking device simulator which loops TX traffic back to RX.
>   
> +config VDPA_USER
> +	tristate "VDUSE (vDPA Device in Userspace) support"
> +	depends on EVENTFD && MMU && HAS_DMA
> +	select DMA_OPS
> +	select VHOST_IOTLB
> +	select IOMMU_IOVA
> +	help
> +	  With VDUSE it is possible to emulate a vDPA Device
> +	  in a userspace program.
> +
>   config IFCVF
>   	tristate "Intel IFC VF vDPA driver"
>   	depends on PCI_MSI
> diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> index 67fe7f3d6943..f02ebed33f19 100644
> --- a/drivers/vdpa/Makefile
> +++ b/drivers/vdpa/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_VDPA) += vdpa.o
>   obj-$(CONFIG_VDPA_SIM) += vdpa_sim/
> +obj-$(CONFIG_VDPA_USER) += vdpa_user/
>   obj-$(CONFIG_IFCVF)    += ifcvf/
>   obj-$(CONFIG_MLX5_VDPA) += mlx5/
>   obj-$(CONFIG_VP_VDPA)    += virtio_pci/
> diff --git a/drivers/vdpa/vdpa_user/Makefile b/drivers/vdpa/vdpa_user/Makefile
> new file mode 100644
> index 000000000000..260e0b26af99
> --- /dev/null
> +++ b/drivers/vdpa/vdpa_user/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +vduse-y := vduse_dev.o iova_domain.o
> +
> +obj-$(CONFIG_VDPA_USER) += vduse.o
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> new file mode 100644
> index 000000000000..51ca73464d0d
> --- /dev/null
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -0,0 +1,1362 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * VDUSE: vDPA Device in Userspace
> + *
> + * Copyright (C) 2020-2021 Bytedance Inc. and/or its affiliates. All rights reserved.
> + *
> + * Author: Xie Yongji <xieyongji@bytedance.com>
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/eventfd.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/poll.h>
> +#include <linux/file.h>
> +#include <linux/uio.h>
> +#include <linux/vdpa.h>
> +#include <uapi/linux/vduse.h>
> +#include <uapi/linux/vdpa.h>
> +#include <uapi/linux/virtio_config.h>
> +#include <linux/mod_devicetable.h>
> +
> +#include "iova_domain.h"
> +
> +#define DRV_VERSION  "1.0"
> +#define DRV_AUTHOR   "Yongji Xie <xieyongji@bytedance.com>"
> +#define DRV_DESC     "vDPA Device in Userspace"
> +#define DRV_LICENSE  "GPL v2"
> +
> +#define VDUSE_DEV_MAX (1U << MINORBITS)
> +
> +struct vduse_virtqueue {
> +	u16 index;
> +	bool ready;
> +	spinlock_t kick_lock;
> +	spinlock_t irq_lock;
> +	struct eventfd_ctx *kickfd;
> +	struct vdpa_callback cb;
> +	struct work_struct inject;
> +};
> +
> +struct vduse_dev;
> +
> +struct vduse_vdpa {
> +	struct vdpa_device vdpa;
> +	struct vduse_dev *dev;
> +};
> +
> +struct vduse_dev {
> +	struct vduse_vdpa *vdev;
> +	struct device dev;
> +	struct cdev cdev;
> +	struct vduse_virtqueue *vqs;
> +	struct vduse_iova_domain *domain;
> +	struct mutex lock;
> +	spinlock_t msg_lock;
> +	atomic64_t msg_unique;
> +	wait_queue_head_t waitq;
> +	struct list_head send_list;
> +	struct list_head recv_list;
> +	struct list_head list;
> +	struct vdpa_callback config_cb;
> +	spinlock_t irq_lock;
> +	unsigned long api_version;
> +	bool connected;
> +	int minor;
> +	u16 vq_size_max;
> +	u16 vq_num;
> +	u32 vq_align;
> +	u32 device_id;
> +	u32 vendor_id;
> +};
> +
> +struct vduse_dev_msg {
> +	struct vduse_dev_request req;
> +	struct vduse_dev_response resp;
> +	struct list_head list;
> +	wait_queue_head_t waitq;
> +	bool completed;
> +};
> +
> +struct vduse_control {
> +	unsigned long api_version;
> +};
> +
> +static unsigned long max_bounce_size = (64 * 1024 * 1024);
> +module_param(max_bounce_size, ulong, 0444);
> +MODULE_PARM_DESC(max_bounce_size, "Maximum bounce buffer size. (default: 64M)");
> +
> +static unsigned long max_iova_size = (128 * 1024 * 1024);
> +module_param(max_iova_size, ulong, 0444);
> +MODULE_PARM_DESC(max_iova_size, "Maximum iova space size (default: 128M)");
> +
> +static DEFINE_MUTEX(vduse_lock);
> +static LIST_HEAD(vduse_devs);
> +static DEFINE_IDA(vduse_ida);
> +
> +static dev_t vduse_major;
> +static struct class *vduse_class;
> +static struct workqueue_struct *vduse_irq_wq;
> +
> +static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
> +{
> +	struct vduse_vdpa *vdev = container_of(vdpa, struct vduse_vdpa, vdpa);
> +
> +	return vdev->dev;
> +}
> +
> +static inline struct vduse_dev *dev_to_vduse(struct device *dev)
> +{
> +	struct vdpa_device *vdpa = dev_to_vdpa(dev);
> +
> +	return vdpa_to_vduse(vdpa);
> +}
> +
> +static struct vduse_dev_msg *vduse_find_msg(struct list_head *head,
> +					    uint32_t request_id)
> +{
> +	struct vduse_dev_msg *tmp, *msg = NULL;
> +
> +	list_for_each_entry(tmp, head, list) {
> +		if (tmp->req.request_id == request_id) {
> +			msg = tmp;
> +			list_del(&tmp->list);
> +			break;
> +		}
> +	}
> +
> +	return msg;
> +}
> +
> +static struct vduse_dev_msg *vduse_dequeue_msg(struct list_head *head)
> +{
> +	struct vduse_dev_msg *msg = NULL;
> +
> +	if (!list_empty(head)) {
> +		msg = list_first_entry(head, struct vduse_dev_msg, list);
> +		list_del(&msg->list);
> +	}
> +
> +	return msg;
> +}
> +
> +static void vduse_enqueue_msg(struct list_head *head,
> +			      struct vduse_dev_msg *msg)
> +{
> +	list_add_tail(&msg->list, head);
> +}
> +
> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
> +			      struct vduse_dev_msg *msg)
> +{
> +	init_waitqueue_head(&msg->waitq);
> +	spin_lock(&dev->msg_lock);
> +	vduse_enqueue_msg(&dev->send_list, msg);
> +	wake_up(&dev->waitq);
> +	spin_unlock(&dev->msg_lock);
> +	wait_event_interruptible(msg->waitq, msg->completed);
> +	spin_lock(&dev->msg_lock);
> +	if (!msg->completed)
> +		list_del(&msg->list);
> +	spin_unlock(&dev->msg_lock);
> +
> +	return (msg->resp.result == VDUSE_REQUEST_OK) ? 0 : -1;
> +}
> +
> +static u32 vduse_dev_get_request_id(struct vduse_dev *dev)
> +{
> +	return atomic64_fetch_inc(&dev->msg_unique);
> +}
> +
> +static u64 vduse_dev_get_features(struct vduse_dev *dev)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +
> +	msg.req.type = VDUSE_GET_FEATURES;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +
> +	return vduse_dev_msg_sync(dev, &msg) ? 0 : msg.resp.f.features;
> +}
> +
> +static int vduse_dev_set_features(struct vduse_dev *dev, u64 features)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +
> +	msg.req.type = VDUSE_SET_FEATURES;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +	msg.req.f.features = features;
> +
> +	return vduse_dev_msg_sync(dev, &msg);
> +}
> +
> +static u8 vduse_dev_get_status(struct vduse_dev *dev)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +
> +	msg.req.type = VDUSE_GET_STATUS;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +
> +	return vduse_dev_msg_sync(dev, &msg) ? 0 : msg.resp.s.status;
> +}
> +
> +static void vduse_dev_set_status(struct vduse_dev *dev, u8 status)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +
> +	msg.req.type = VDUSE_SET_STATUS;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +	msg.req.s.status = status;
> +
> +	vduse_dev_msg_sync(dev, &msg);
> +}
> +
> +static void vduse_dev_get_config(struct vduse_dev *dev, unsigned int offset,
> +				 void *buf, unsigned int len)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +	unsigned int sz;
> +
> +	while (len) {
> +		sz = min_t(unsigned int, len, sizeof(msg.req.config.data));
> +		msg.req.type = VDUSE_GET_CONFIG;
> +		msg.req.request_id = vduse_dev_get_request_id(dev);
> +		msg.req.config.offset = offset;
> +		msg.req.config.len = sz;
> +		vduse_dev_msg_sync(dev, &msg);
> +		memcpy(buf, msg.resp.config.data, sz);
> +		buf += sz;
> +		offset += sz;
> +		len -= sz;
> +	}
> +}
> +
> +static void vduse_dev_set_config(struct vduse_dev *dev, unsigned int offset,
> +				 const void *buf, unsigned int len)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +	unsigned int sz;
> +
> +	while (len) {
> +		sz = min_t(unsigned int, len, sizeof(msg.req.config.data));
> +		msg.req.type = VDUSE_SET_CONFIG;
> +		msg.req.request_id = vduse_dev_get_request_id(dev);
> +		msg.req.config.offset = offset;
> +		msg.req.config.len = sz;
> +		memcpy(msg.req.config.data, buf, sz);
> +		vduse_dev_msg_sync(dev, &msg);
> +		buf += sz;
> +		offset += sz;
> +		len -= sz;
> +	}
> +}
> +
> +static void vduse_dev_set_vq_num(struct vduse_dev *dev,
> +				 struct vduse_virtqueue *vq, u32 num)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +
> +	msg.req.type = VDUSE_SET_VQ_NUM;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +	msg.req.vq_num.index = vq->index;
> +	msg.req.vq_num.num = num;
> +
> +	vduse_dev_msg_sync(dev, &msg);
> +}
> +
> +static int vduse_dev_set_vq_addr(struct vduse_dev *dev,
> +				 struct vduse_virtqueue *vq, u64 desc_addr,
> +				 u64 driver_addr, u64 device_addr)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +
> +	msg.req.type = VDUSE_SET_VQ_ADDR;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +	msg.req.vq_addr.index = vq->index;
> +	msg.req.vq_addr.desc_addr = desc_addr;
> +	msg.req.vq_addr.driver_addr = driver_addr;
> +	msg.req.vq_addr.device_addr = device_addr;
> +
> +	return vduse_dev_msg_sync(dev, &msg);
> +}
> +
> +static void vduse_dev_set_vq_ready(struct vduse_dev *dev,
> +				struct vduse_virtqueue *vq, bool ready)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +
> +	msg.req.type = VDUSE_SET_VQ_READY;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +	msg.req.vq_ready.index = vq->index;
> +	msg.req.vq_ready.ready = ready;
> +
> +	vduse_dev_msg_sync(dev, &msg);
> +}
> +
> +static bool vduse_dev_get_vq_ready(struct vduse_dev *dev,
> +				   struct vduse_virtqueue *vq)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +
> +	msg.req.type = VDUSE_GET_VQ_READY;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +	msg.req.vq_ready.index = vq->index;
> +
> +	return vduse_dev_msg_sync(dev, &msg) ? false : msg.resp.vq_ready.ready;
> +}
> +
> +static int vduse_dev_get_vq_state(struct vduse_dev *dev,
> +				struct vduse_virtqueue *vq,
> +				struct vdpa_vq_state *state)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +	int ret;
> +
> +	msg.req.type = VDUSE_GET_VQ_STATE;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +	msg.req.vq_state.index = vq->index;
> +
> +	ret = vduse_dev_msg_sync(dev, &msg);
> +	if (!ret)
> +		state->avail_index = msg.resp.vq_state.avail_idx;
> +
> +	return ret;
> +}
> +
> +static int vduse_dev_set_vq_state(struct vduse_dev *dev,
> +				struct vduse_virtqueue *vq,
> +				const struct vdpa_vq_state *state)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +
> +	msg.req.type = VDUSE_SET_VQ_STATE;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +	msg.req.vq_state.index = vq->index;
> +	msg.req.vq_state.avail_idx = state->avail_index;
> +
> +	return vduse_dev_msg_sync(dev, &msg);
> +}
> +
> +static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> +				u64 start, u64 last)
> +{
> +	struct vduse_dev_msg msg = { 0 };
> +
> +	if (last < start)
> +		return -EINVAL;
> +
> +	msg.req.type = VDUSE_UPDATE_IOTLB;
> +	msg.req.request_id = vduse_dev_get_request_id(dev);
> +	msg.req.iova.start = start;
> +	msg.req.iova.last = last;
> +
> +	return vduse_dev_msg_sync(dev, &msg);
> +}
> +
> +static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct vduse_dev *dev = file->private_data;
> +	struct vduse_dev_msg *msg;
> +	int size = sizeof(struct vduse_dev_request);
> +	ssize_t ret = 0;
> +
> +	if (iov_iter_count(to) < size)
> +		return 0;
> +
> +	spin_lock(&dev->msg_lock);
> +	while (1) {
> +		msg = vduse_dequeue_msg(&dev->send_list);
> +		if (msg)
> +			break;
> +
> +		ret = -EAGAIN;
> +		if (file->f_flags & O_NONBLOCK)
> +			goto unlock;
> +
> +		spin_unlock(&dev->msg_lock);
> +		ret = wait_event_interruptible_exclusive(dev->waitq,
> +					!list_empty(&dev->send_list));
> +		if (ret)
> +			return ret;
> +
> +		spin_lock(&dev->msg_lock);
> +	}
> +	spin_unlock(&dev->msg_lock);
> +	ret = copy_to_iter(&msg->req, size, to);
> +	spin_lock(&dev->msg_lock);
> +	if (ret != size) {
> +		ret = -EFAULT;
> +		vduse_enqueue_msg(&dev->send_list, msg);
> +		goto unlock;
> +	}
> +	vduse_enqueue_msg(&dev->recv_list, msg);
> +	wake_up(&dev->waitq);
> +unlock:
> +	spin_unlock(&dev->msg_lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t vduse_dev_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct vduse_dev *dev = file->private_data;
> +	struct vduse_dev_response resp;
> +	struct vduse_dev_msg *msg;
> +	size_t ret;
> +
> +	ret = copy_from_iter(&resp, sizeof(resp), from);
> +	if (ret != sizeof(resp))
> +		return -EINVAL;
> +
> +	spin_lock(&dev->msg_lock);
> +	msg = vduse_find_msg(&dev->recv_list, resp.request_id);
> +	if (!msg) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	memcpy(&msg->resp, &resp, sizeof(resp));
> +	msg->completed = 1;
> +	wake_up(&msg->waitq);
> +unlock:
> +	spin_unlock(&dev->msg_lock);
> +
> +	return ret;
> +}
> +
> +static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
> +{
> +	struct vduse_dev *dev = file->private_data;
> +	__poll_t mask = 0;
> +
> +	poll_wait(file, &dev->waitq, wait);
> +
> +	if (!list_empty(&dev->send_list))
> +		mask |= EPOLLIN | EPOLLRDNORM;
> +	if (!list_empty(&dev->recv_list))
> +		mask |= EPOLLOUT;
> +
> +	return mask;
> +}
> +
> +static void vduse_dev_reset(struct vduse_dev *dev)
> +{
> +	int i;
> +
> +	/* The coherent mappings are handled in vduse_dev_free_coherent() */
> +	vduse_domain_reset_bounce_map(dev->domain);
> +	vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> +
> +	spin_lock(&dev->irq_lock);
> +	dev->config_cb.callback = NULL;
> +	dev->config_cb.private = NULL;
> +	spin_unlock(&dev->irq_lock);
> +
> +	for (i = 0; i < dev->vq_num; i++) {
> +		struct vduse_virtqueue *vq = &dev->vqs[i];
> +
> +		spin_lock(&vq->irq_lock);
> +		vq->ready = false;
> +		vq->cb.callback = NULL;
> +		vq->cb.private = NULL;
> +		spin_unlock(&vq->irq_lock);
> +	}
> +}
> +
> +static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
> +				u64 desc_area, u64 driver_area,
> +				u64 device_area)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	struct vduse_virtqueue *vq = &dev->vqs[idx];
> +
> +	return vduse_dev_set_vq_addr(dev, vq, desc_area,
> +					driver_area, device_area);
> +}
> +
> +static void vduse_vdpa_kick_vq(struct vdpa_device *vdpa, u16 idx)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	struct vduse_virtqueue *vq = &dev->vqs[idx];
> +
> +	spin_lock(&vq->kick_lock);
> +	if (vq->ready && vq->kickfd)
> +		eventfd_signal(vq->kickfd, 1);
> +	spin_unlock(&vq->kick_lock);
> +}
> +
> +static void vduse_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
> +			      struct vdpa_callback *cb)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	struct vduse_virtqueue *vq = &dev->vqs[idx];
> +
> +	spin_lock(&vq->irq_lock);
> +	vq->cb.callback = cb->callback;
> +	vq->cb.private = cb->private;
> +	spin_unlock(&vq->irq_lock);
> +}
> +
> +static void vduse_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 idx, u32 num)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	struct vduse_virtqueue *vq = &dev->vqs[idx];
> +
> +	vduse_dev_set_vq_num(dev, vq, num);
> +}
> +
> +static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
> +					u16 idx, bool ready)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	struct vduse_virtqueue *vq = &dev->vqs[idx];
> +
> +	vduse_dev_set_vq_ready(dev, vq, ready);
> +	vq->ready = ready;
> +}
> +
> +static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	struct vduse_virtqueue *vq = &dev->vqs[idx];
> +
> +	vq->ready = vduse_dev_get_vq_ready(dev, vq);
> +
> +	return vq->ready;
> +}
> +
> +static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
> +				const struct vdpa_vq_state *state)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	struct vduse_virtqueue *vq = &dev->vqs[idx];
> +
> +	return vduse_dev_set_vq_state(dev, vq, state);
> +}
> +
> +static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> +				struct vdpa_vq_state *state)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	struct vduse_virtqueue *vq = &dev->vqs[idx];
> +
> +	return vduse_dev_get_vq_state(dev, vq, state);
> +}
> +
> +static u32 vduse_vdpa_get_vq_align(struct vdpa_device *vdpa)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	return dev->vq_align;
> +}
> +
> +static u64 vduse_vdpa_get_features(struct vdpa_device *vdpa)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	return vduse_dev_get_features(dev);
> +}
> +
> +static int vduse_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
> +		return -EINVAL;
> +
> +	return vduse_dev_set_features(dev, features);
> +}
> +
> +static void vduse_vdpa_set_config_cb(struct vdpa_device *vdpa,
> +				  struct vdpa_callback *cb)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	spin_lock(&dev->irq_lock);
> +	dev->config_cb.callback = cb->callback;
> +	dev->config_cb.private = cb->private;
> +	spin_unlock(&dev->irq_lock);
> +}
> +
> +static u16 vduse_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	return dev->vq_size_max;
> +}
> +
> +static u32 vduse_vdpa_get_device_id(struct vdpa_device *vdpa)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	return dev->device_id;
> +}
> +
> +static u32 vduse_vdpa_get_vendor_id(struct vdpa_device *vdpa)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	return dev->vendor_id;
> +}
> +
> +static u8 vduse_vdpa_get_status(struct vdpa_device *vdpa)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	return vduse_dev_get_status(dev);
> +}
> +
> +static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	vduse_dev_set_status(dev, status);
> +
> +	if (status == 0)
> +		vduse_dev_reset(dev);
> +}
> +
> +static void vduse_vdpa_get_config(struct vdpa_device *vdpa, unsigned int offset,
> +			     void *buf, unsigned int len)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	vduse_dev_get_config(dev, offset, buf, len);
> +}
> +
> +static void vduse_vdpa_set_config(struct vdpa_device *vdpa, unsigned int offset,
> +			const void *buf, unsigned int len)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	vduse_dev_set_config(dev, offset, buf, len);
> +}
> +
> +static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
> +				struct vhost_iotlb *iotlb)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	int ret;
> +
> +	ret = vduse_domain_set_map(dev->domain, iotlb);
> +	vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> +
> +	return ret;
> +}
> +
> +static void vduse_vdpa_free(struct vdpa_device *vdpa)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	WARN_ON(!list_empty(&dev->send_list));
> +	WARN_ON(!list_empty(&dev->recv_list));
> +	dev->vdev = NULL;
> +}
> +
> +static const struct vdpa_config_ops vduse_vdpa_config_ops = {
> +	.set_vq_address		= vduse_vdpa_set_vq_address,
> +	.kick_vq		= vduse_vdpa_kick_vq,
> +	.set_vq_cb		= vduse_vdpa_set_vq_cb,
> +	.set_vq_num             = vduse_vdpa_set_vq_num,
> +	.set_vq_ready		= vduse_vdpa_set_vq_ready,
> +	.get_vq_ready		= vduse_vdpa_get_vq_ready,
> +	.set_vq_state		= vduse_vdpa_set_vq_state,
> +	.get_vq_state		= vduse_vdpa_get_vq_state,
> +	.get_vq_align		= vduse_vdpa_get_vq_align,
> +	.get_features		= vduse_vdpa_get_features,
> +	.set_features		= vduse_vdpa_set_features,
> +	.set_config_cb		= vduse_vdpa_set_config_cb,
> +	.get_vq_num_max		= vduse_vdpa_get_vq_num_max,
> +	.get_device_id		= vduse_vdpa_get_device_id,
> +	.get_vendor_id		= vduse_vdpa_get_vendor_id,
> +	.get_status		= vduse_vdpa_get_status,
> +	.set_status		= vduse_vdpa_set_status,
> +	.get_config		= vduse_vdpa_get_config,
> +	.set_config		= vduse_vdpa_set_config,
> +	.set_map		= vduse_vdpa_set_map,
> +	.free			= vduse_vdpa_free,
> +};
> +
> +static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *page,
> +				     unsigned long offset, size_t size,
> +				     enum dma_data_direction dir,
> +				     unsigned long attrs)
> +{
> +	struct vduse_dev *vdev = dev_to_vduse(dev);
> +	struct vduse_iova_domain *domain = vdev->domain;
> +
> +	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
> +}
> +
> +static void vduse_dev_unmap_page(struct device *dev, dma_addr_t dma_addr,
> +				size_t size, enum dma_data_direction dir,
> +				unsigned long attrs)
> +{
> +	struct vduse_dev *vdev = dev_to_vduse(dev);
> +	struct vduse_iova_domain *domain = vdev->domain;
> +
> +	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> +}
> +
> +static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
> +					dma_addr_t *dma_addr, gfp_t flag,
> +					unsigned long attrs)
> +{
> +	struct vduse_dev *vdev = dev_to_vduse(dev);
> +	struct vduse_iova_domain *domain = vdev->domain;
> +	unsigned long iova;
> +	void *addr;
> +
> +	*dma_addr = DMA_MAPPING_ERROR;
> +	addr = vduse_domain_alloc_coherent(domain, size,
> +				(dma_addr_t *)&iova, flag, attrs);
> +	if (!addr)
> +		return NULL;
> +
> +	*dma_addr = (dma_addr_t)iova;
> +	vduse_dev_update_iotlb(vdev, iova, iova + size - 1);
> +
> +	return addr;
> +}
> +
> +static void vduse_dev_free_coherent(struct device *dev, size_t size,
> +					void *vaddr, dma_addr_t dma_addr,
> +					unsigned long attrs)
> +{
> +	struct vduse_dev *vdev = dev_to_vduse(dev);
> +	struct vduse_iova_domain *domain = vdev->domain;
> +	unsigned long start = (unsigned long)dma_addr;
> +	unsigned long last = start + size - 1;
> +
> +	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
> +	vduse_dev_update_iotlb(vdev, start, last);
> +}
> +
> +static const struct dma_map_ops vduse_dev_dma_ops = {
> +	.map_page = vduse_dev_map_page,
> +	.unmap_page = vduse_dev_unmap_page,
> +	.alloc = vduse_dev_alloc_coherent,
> +	.free = vduse_dev_free_coherent,
> +};
> +
> +static unsigned int perm_to_file_flags(u8 perm)
> +{
> +	unsigned int flags = 0;
> +
> +	switch (perm) {
> +	case VDUSE_ACCESS_WO:
> +		flags |= O_WRONLY;
> +		break;
> +	case VDUSE_ACCESS_RO:
> +		flags |= O_RDONLY;
> +		break;
> +	case VDUSE_ACCESS_RW:
> +		flags |= O_RDWR;
> +		break;
> +	default:
> +		WARN(1, "invalidate vhost IOTLB permission\n");
> +		break;
> +	}
> +
> +	return flags;
> +}
> +
> +static int vduse_kickfd_setup(struct vduse_dev *dev,
> +			struct vduse_vq_eventfd *eventfd)
> +{
> +	struct eventfd_ctx *ctx = NULL;
> +	struct vduse_virtqueue *vq;
> +
> +	if (eventfd->index >= dev->vq_num)
> +		return -EINVAL;
> +
> +	vq = &dev->vqs[eventfd->index];
> +	if (eventfd->fd > 0) {
> +		ctx = eventfd_ctx_fdget(eventfd->fd);
> +		if (IS_ERR(ctx))
> +			return PTR_ERR(ctx);
> +	} else if (eventfd->fd != VDUSE_EVENTFD_DEASSIGN)
> +		return 0;


Do we allow the userspace to switch kickfd here? If yes, we need to deal 
with that.


> +
> +	spin_lock(&vq->kick_lock);
> +	if (vq->kickfd)
> +		eventfd_ctx_put(vq->kickfd);
> +	vq->kickfd = ctx;
> +	spin_unlock(&vq->kick_lock);
> +
> +	return 0;
> +}
> +
> +static void vduse_vq_irq_inject(struct work_struct *work)
> +{
> +	struct vduse_virtqueue *vq = container_of(work,
> +					struct vduse_virtqueue, inject);
> +
> +	spin_lock_irq(&vq->irq_lock);
> +	if (vq->ready && vq->cb.callback)
> +		vq->cb.callback(vq->cb.private);
> +	spin_unlock_irq(&vq->irq_lock);
> +}
> +
> +static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	struct vduse_dev *dev = file->private_data;
> +	void __user *argp = (void __user *)arg;
> +	int ret;
> +
> +	switch (cmd) {
> +	case VDUSE_IOTLB_GET_FD: {
> +		struct vduse_iotlb_entry entry;
> +		struct vhost_iotlb_map *map;
> +		struct vdpa_map_file *map_file;
> +		struct vduse_iova_domain *domain = dev->domain;
> +		struct file *f = NULL;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&entry, argp, sizeof(entry)))
> +			break;
> +
> +		ret = -EINVAL;
> +		if (entry.start > entry.last)
> +			break;
> +
> +		spin_lock(&domain->iotlb_lock);
> +		map = vhost_iotlb_itree_first(domain->iotlb,
> +					      entry.start, entry.last);
> +		if (map) {
> +			map_file = (struct vdpa_map_file *)map->opaque;
> +			f = get_file(map_file->file);
> +			entry.offset = map_file->offset;
> +			entry.start = map->start;
> +			entry.last = map->last;
> +			entry.perm = map->perm;
> +		}
> +		spin_unlock(&domain->iotlb_lock);
> +		ret = -EINVAL;
> +		if (!f)
> +			break;
> +
> +		ret = -EFAULT;
> +		if (copy_to_user(argp, &entry, sizeof(entry))) {
> +			fput(f);
> +			break;
> +		}
> +		ret = receive_fd(f, perm_to_file_flags(entry.perm));
> +		fput(f);


Any reason to drop the refcnt here?


> +		break;
> +	}
> +	case VDUSE_VQ_SETUP_KICKFD: {
> +		struct vduse_vq_eventfd eventfd;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&eventfd, argp, sizeof(eventfd)))
> +			break;
> +
> +		ret = vduse_kickfd_setup(dev, &eventfd);
> +		break;
> +	}
> +	case VDUSE_INJECT_VQ_IRQ:
> +		ret = -EINVAL;
> +		if (arg >= dev->vq_num)
> +			break;
> +
> +		ret = 0;
> +		queue_work(vduse_irq_wq, &dev->vqs[arg].inject);
> +		break;
> +	case VDUSE_INJECT_CONFIG_IRQ:
> +		ret = -EINVAL;
> +		spin_lock_irq(&dev->irq_lock);
> +		if (dev->config_cb.callback) {
> +			dev->config_cb.callback(dev->config_cb.private);
> +			ret = 0;
> +		}
> +		spin_unlock_irq(&dev->irq_lock);


For consistency, is it better to use vduse_irq_wq here?


> +		break;
> +	default:
> +		ret = -ENOIOCTLCMD;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int vduse_dev_release(struct inode *inode, struct file *file)
> +{
> +	struct vduse_dev *dev = file->private_data;
> +	struct vduse_dev_msg *msg;
> +	int i;
> +
> +	for (i = 0; i < dev->vq_num; i++) {
> +		struct vduse_virtqueue *vq = &dev->vqs[i];
> +
> +		spin_lock(&vq->kick_lock);
> +		if (vq->kickfd)
> +			eventfd_ctx_put(vq->kickfd);
> +		vq->kickfd = NULL;
> +		spin_unlock(&vq->kick_lock);
> +	}
> +
> +	spin_lock(&dev->msg_lock);
> +	/*  Make sure the inflight messages can processed */


This might be better:

/*  Make sure the inflight messages can processed after reconncection */

> +	while ((msg = vduse_dequeue_msg(&dev->recv_list)))
> +		vduse_enqueue_msg(&dev->send_list, msg);
> +	spin_unlock(&dev->msg_lock);
> +
> +	dev->connected = false;
> +
> +	return 0;
> +}
> +
> +static int vduse_dev_open(struct inode *inode, struct file *file)
> +{
> +	struct vduse_dev *dev = container_of(inode->i_cdev,
> +					struct vduse_dev, cdev);
> +	int ret = -EBUSY;
> +
> +	mutex_lock(&dev->lock);
> +	if (dev->connected)
> +		goto unlock;
> +
> +	ret = 0;
> +	dev->connected = true;
> +	file->private_data = dev;
> +unlock:
> +	mutex_unlock(&dev->lock);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations vduse_dev_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= vduse_dev_open,
> +	.release	= vduse_dev_release,
> +	.read_iter	= vduse_dev_read_iter,
> +	.write_iter	= vduse_dev_write_iter,
> +	.poll		= vduse_dev_poll,
> +	.unlocked_ioctl	= vduse_dev_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +static struct vduse_dev *vduse_dev_create(void)
> +{
> +	struct vduse_dev *dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +
> +	if (!dev)
> +		return NULL;
> +
> +	mutex_init(&dev->lock);
> +	spin_lock_init(&dev->msg_lock);
> +	INIT_LIST_HEAD(&dev->send_list);
> +	INIT_LIST_HEAD(&dev->recv_list);
> +	atomic64_set(&dev->msg_unique, 0);
> +	spin_lock_init(&dev->irq_lock);
> +
> +	init_waitqueue_head(&dev->waitq);
> +
> +	return dev;
> +}
> +
> +static void vduse_dev_destroy(struct vduse_dev *dev)
> +{
> +	kfree(dev);
> +}
> +
> +static struct vduse_dev *vduse_find_dev(const char *name)
> +{
> +	struct vduse_dev *tmp, *dev = NULL;
> +
> +	list_for_each_entry(tmp, &vduse_devs, list) {
> +		if (!strcmp(dev_name(&tmp->dev), name)) {
> +			dev = tmp;
> +			break;
> +		}
> +	}
> +	return dev;
> +}
> +
> +static int vduse_destroy_dev(char *name)
> +{
> +	struct vduse_dev *dev = vduse_find_dev(name);
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	mutex_lock(&dev->lock);
> +	if (dev->vdev || dev->connected) {
> +		mutex_unlock(&dev->lock);
> +		return -EBUSY;
> +	}
> +	dev->connected = true;
> +	mutex_unlock(&dev->lock);
> +
> +	list_del(&dev->list);
> +	cdev_device_del(&dev->cdev, &dev->dev);
> +	put_device(&dev->dev);
> +	module_put(THIS_MODULE);
> +
> +	return 0;
> +}
> +
> +static void vduse_release_dev(struct device *device)
> +{
> +	struct vduse_dev *dev =
> +		container_of(device, struct vduse_dev, dev);
> +
> +	ida_simple_remove(&vduse_ida, dev->minor);
> +	kfree(dev->vqs);
> +	vduse_domain_destroy(dev->domain);
> +	vduse_dev_destroy(dev);
> +}
> +
> +static int vduse_create_dev(struct vduse_dev_config *config,
> +			    unsigned long api_version)
> +{
> +	int i, ret = -ENOMEM;
> +	struct vduse_dev *dev;
> +
> +	if (config->bounce_size > max_bounce_size)
> +		return -EINVAL;
> +
> +	if (config->bounce_size > max_iova_size)
> +		return -EINVAL;
> +
> +	if (vduse_find_dev(config->name))
> +		return -EEXIST;
> +
> +	dev = vduse_dev_create();
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->api_version = api_version;
> +	dev->device_id = config->device_id;
> +	dev->vendor_id = config->vendor_id;
> +	dev->domain = vduse_domain_create(max_iova_size - 1,
> +					config->bounce_size);
> +	if (!dev->domain)
> +		goto err_domain;
> +
> +	dev->vq_align = config->vq_align;
> +	dev->vq_size_max = config->vq_size_max;
> +	dev->vq_num = config->vq_num;
> +	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
> +	if (!dev->vqs)
> +		goto err_vqs;
> +
> +	for (i = 0; i < dev->vq_num; i++) {
> +		dev->vqs[i].index = i;
> +		INIT_WORK(&dev->vqs[i].inject, vduse_vq_irq_inject);
> +		spin_lock_init(&dev->vqs[i].kick_lock);
> +		spin_lock_init(&dev->vqs[i].irq_lock);
> +	}
> +
> +	ret = ida_simple_get(&vduse_ida, 0, VDUSE_DEV_MAX, GFP_KERNEL);
> +	if (ret < 0)
> +		goto err_ida;
> +
> +	dev->minor = ret;
> +	device_initialize(&dev->dev);
> +	dev->dev.release = vduse_release_dev;
> +	dev->dev.class = vduse_class;
> +	dev->dev.devt = MKDEV(MAJOR(vduse_major), dev->minor);
> +	ret = dev_set_name(&dev->dev, "%s", config->name);
> +	if (ret) {
> +		put_device(&dev->dev);
> +		return ret;
> +	}
> +	cdev_init(&dev->cdev, &vduse_dev_fops);
> +	dev->cdev.owner = THIS_MODULE;
> +
> +	ret = cdev_device_add(&dev->cdev, &dev->dev);
> +	if (ret) {
> +		put_device(&dev->dev);
> +		return ret;


Let's introduce an error label for this.


> +	}
> +	list_add(&dev->list, &vduse_devs);
> +	__module_get(THIS_MODULE);
> +
> +	return 0;
> +err_ida:
> +	kfree(dev->vqs);
> +err_vqs:
> +	vduse_domain_destroy(dev->domain);
> +err_domain:
> +	vduse_dev_destroy(dev);
> +	return ret;
> +}
> +
> +static long vduse_ioctl(struct file *file, unsigned int cmd,
> +			unsigned long arg)
> +{
> +	int ret;
> +	void __user *argp = (void __user *)arg;
> +	struct vduse_control *control = file->private_data;
> +
> +	mutex_lock(&vduse_lock);
> +	switch (cmd) {
> +	case VDUSE_GET_API_VERSION:
> +		ret = control->api_version;
> +		break;
> +	case VDUSE_SET_API_VERSION:
> +		ret = -EINVAL;
> +		if (arg > VDUSE_API_VERSION)
> +			break;
> +
> +		ret = 0;
> +		control->api_version = arg;
> +		break;
> +	case VDUSE_CREATE_DEV: {
> +		struct vduse_dev_config config;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&config, argp, sizeof(config)))
> +			break;
> +
> +		ret = vduse_create_dev(&config, control->api_version);
> +		break;
> +	}
> +	case VDUSE_DESTROY_DEV: {
> +		char name[VDUSE_NAME_MAX];
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(name, argp, VDUSE_NAME_MAX))
> +			break;
> +
> +		ret = vduse_destroy_dev(name);
> +		break;
> +	}
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&vduse_lock);
> +
> +	return ret;
> +}
> +
> +static int vduse_release(struct inode *inode, struct file *file)
> +{
> +	struct vduse_control *control = file->private_data;
> +
> +	kfree(control);
> +	return 0;
> +}
> +
> +static int vduse_open(struct inode *inode, struct file *file)
> +{
> +	struct vduse_control *control;
> +
> +	control = kmalloc(sizeof(struct vduse_control), GFP_KERNEL);
> +	if (!control)
> +		return -ENOMEM;
> +
> +	control->api_version = VDUSE_API_VERSION;
> +	file->private_data = control;
> +
> +	return 0;
> +}
> +
> +static const struct file_operations vduse_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= vduse_open,
> +	.release	= vduse_release,
> +	.unlocked_ioctl	= vduse_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +static char *vduse_devnode(struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
> +}
> +
> +static struct miscdevice vduse_misc = {
> +	.fops = &vduse_fops,
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "vduse",
> +	.nodename = "vduse/control",
> +};
> +
> +static void vduse_mgmtdev_release(struct device *dev)
> +{
> +}
> +
> +static struct device vduse_mgmtdev = {
> +	.init_name = "vduse",
> +	.release = vduse_mgmtdev_release,
> +};
> +
> +static struct vdpa_mgmt_dev mgmt_dev;
> +
> +static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
> +{
> +	struct vduse_vdpa *vdev;
> +	int ret;
> +
> +	if (dev->vdev)
> +		return -EEXIST;
> +
> +	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, &dev->dev,
> +				 &vduse_vdpa_config_ops, name, true);
> +	if (!vdev)
> +		return -ENOMEM;
> +
> +	dev->vdev = vdev;
> +	vdev->dev = dev;
> +	vdev->vdpa.dev.dma_mask = &vdev->vdpa.dev.coherent_dma_mask;
> +	ret = dma_set_mask_and_coherent(&vdev->vdpa.dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		put_device(&vdev->vdpa.dev);
> +		return ret;
> +	}
> +	set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
> +	vdev->vdpa.dma_dev = &vdev->vdpa.dev;
> +	vdev->vdpa.mdev = &mgmt_dev;
> +
> +	return 0;
> +}
> +
> +static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
> +{
> +	struct vduse_dev *dev;
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&vduse_lock);
> +	dev = vduse_find_dev(name);
> +	if (!dev) {
> +		mutex_unlock(&vduse_lock);
> +		return -EINVAL;
> +	}
> +	ret = vduse_dev_init_vdpa(dev, name);
> +	mutex_unlock(&vduse_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
> +	if (ret) {
> +		put_device(&dev->vdev->vdpa.dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
> +{
> +	_vdpa_unregister_device(dev);
> +}
> +
> +static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtdev_ops = {
> +	.dev_add = vdpa_dev_add,
> +	.dev_del = vdpa_dev_del,
> +};
> +
> +static struct virtio_device_id id_table[] = {
> +	{ VIRTIO_DEV_ANY_ID, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static struct vdpa_mgmt_dev mgmt_dev = {
> +	.device = &vduse_mgmtdev,
> +	.id_table = id_table,
> +	.ops = &vdpa_dev_mgmtdev_ops,
> +};
> +
> +static int vduse_mgmtdev_init(void)
> +{
> +	int ret;
> +
> +	ret = device_register(&vduse_mgmtdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = vdpa_mgmtdev_register(&mgmt_dev);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	device_unregister(&vduse_mgmtdev);
> +	return ret;
> +}
> +
> +static void vduse_mgmtdev_exit(void)
> +{
> +	vdpa_mgmtdev_unregister(&mgmt_dev);
> +	device_unregister(&vduse_mgmtdev);
> +}
> +
> +static int vduse_init(void)
> +{
> +	int ret;
> +
> +	if (max_bounce_size >= max_iova_size)
> +		return -EINVAL;
> +
> +	ret = misc_register(&vduse_misc);
> +	if (ret)
> +		return ret;
> +
> +	vduse_class = class_create(THIS_MODULE, "vduse");
> +	if (IS_ERR(vduse_class)) {
> +		ret = PTR_ERR(vduse_class);
> +		goto err_class;
> +	}
> +	vduse_class->devnode = vduse_devnode;
> +
> +	ret = alloc_chrdev_region(&vduse_major, 0, VDUSE_DEV_MAX, "vduse");
> +	if (ret)
> +		goto err_chardev;
> +
> +	vduse_irq_wq = alloc_workqueue("vduse-irq",
> +				WQ_HIGHPRI | WQ_SYSFS | WQ_UNBOUND, 0);
> +	if (!vduse_irq_wq)
> +		goto err_wq;
> +
> +	ret = vduse_domain_init();
> +	if (ret)
> +		goto err_domain;
> +
> +	ret = vduse_mgmtdev_init();
> +	if (ret)
> +		goto err_mgmtdev;
> +
> +	return 0;
> +err_mgmtdev:
> +	vduse_domain_exit();
> +err_domain:
> +	destroy_workqueue(vduse_irq_wq);
> +err_wq:
> +	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
> +err_chardev:
> +	class_destroy(vduse_class);
> +err_class:
> +	misc_deregister(&vduse_misc);
> +	return ret;
> +}
> +module_init(vduse_init);
> +
> +static void vduse_exit(void)
> +{
> +	misc_deregister(&vduse_misc);
> +	class_destroy(vduse_class);
> +	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
> +	destroy_workqueue(vduse_irq_wq);
> +	vduse_domain_exit();
> +	vduse_mgmtdev_exit();
> +}
> +module_exit(vduse_exit);
> +
> +MODULE_VERSION(DRV_VERSION);
> +MODULE_LICENSE(DRV_LICENSE);
> +MODULE_AUTHOR(DRV_AUTHOR);
> +MODULE_DESCRIPTION(DRV_DESC);
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> new file mode 100644
> index 000000000000..66a6e5212226
> --- /dev/null
> +++ b/include/uapi/linux/vduse.h
> @@ -0,0 +1,175 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_VDUSE_H_
> +#define _UAPI_VDUSE_H_
> +
> +#include <linux/types.h>
> +
> +#define VDUSE_API_VERSION	0
> +
> +#define VDUSE_CONFIG_DATA_LEN	256
> +#define VDUSE_NAME_MAX	256
> +
> +/* the control messages definition for read/write */
> +
> +enum vduse_req_type {
> +	/* Set the vring address of virtqueue. */
> +	VDUSE_SET_VQ_NUM,
> +	/* Set the vring address of virtqueue. */
> +	VDUSE_SET_VQ_ADDR,
> +	/* Set ready status of virtqueue */
> +	VDUSE_SET_VQ_READY,
> +	/* Get ready status of virtqueue */
> +	VDUSE_GET_VQ_READY,
> +	/* Set the state for virtqueue */
> +	VDUSE_SET_VQ_STATE,
> +	/* Get the state for virtqueue */
> +	VDUSE_GET_VQ_STATE,
> +	/* Set virtio features supported by the driver */
> +	VDUSE_SET_FEATURES,
> +	/* Get virtio features supported by the device */
> +	VDUSE_GET_FEATURES,
> +	/* Set the device status */
> +	VDUSE_SET_STATUS,
> +	/* Get the device status */
> +	VDUSE_GET_STATUS,
> +	/* Write to device specific configuration space */
> +	VDUSE_SET_CONFIG,
> +	/* Read from device specific configuration space */
> +	VDUSE_GET_CONFIG,
> +	/* Notify userspace to update the memory mapping in device IOTLB */
> +	VDUSE_UPDATE_IOTLB,
> +};
> +
> +struct vduse_vq_num {
> +	__u32 index; /* virtqueue index */


I think it's better to have a consistent style of the doc/comment. If 
yes, let's move those comment above the field.


> +	__u32 num; /* the size of virtqueue */
> +};
> +
> +struct vduse_vq_addr {
> +	__u32 index; /* virtqueue index */
> +	__u64 desc_addr; /* address of desc area */
> +	__u64 driver_addr; /* address of driver area */
> +	__u64 device_addr; /* address of device area */
> +};
> +
> +struct vduse_vq_ready {
> +	__u32 index; /* virtqueue index */
> +	__u8 ready; /* ready status of virtqueue */
> +};
> +
> +struct vduse_vq_state {
> +	__u32 index; /* virtqueue index */
> +	__u16 avail_idx; /* virtqueue state (last_avail_idx) */


Let's use __u64 here to be consistent with get_vq_state(). The idea is 
to support packed virtqueue.


> +};
> +
> +struct vduse_dev_config_data {
> +	__u32 offset; /* offset from the beginning of config space */
> +	__u32 len; /* the length to read/write */
> +	__u8 data[VDUSE_CONFIG_DATA_LEN]; /* data buffer used to read/write */


Note that since VDUSE_CONFIG_DATA_LEN is part of uAPI it means we can 
not change it in the future.

So this might suffcient for future features or all type of virtio devices.


> +};
> +
> +struct vduse_iova_range {
> +	__u64 start; /* start of the IOVA range */
> +	__u64 last; /* end of the IOVA range */
> +};
> +
> +struct vduse_features {
> +	__u64 features; /* virtio features */
> +};
> +
> +struct vduse_status {
> +	__u8 status; /* device status */
> +};
> +
> +struct vduse_dev_request {
> +	__u32 type; /* request type */
> +	__u32 request_id; /* request id */
> +	__u32 reserved[2]; /* for future use */
> +	union {
> +		struct vduse_vq_num vq_num; /* virtqueue num */
> +		struct vduse_vq_addr vq_addr; /* virtqueue address */
> +		struct vduse_vq_ready vq_ready; /* virtqueue ready status */
> +		struct vduse_vq_state vq_state; /* virtqueue state */
> +		struct vduse_dev_config_data config; /* virtio device config space */
> +		struct vduse_iova_range iova; /* iova range for updating */
> +		struct vduse_features f; /* virtio features */
> +		struct vduse_status s; /* device status */
> +		__u32 padding[16]; /* padding */
> +	};
> +};
> +
> +struct vduse_dev_response {
> +	__u32 request_id; /* corresponding request id */
> +#define VDUSE_REQUEST_OK	0x00
> +#define VDUSE_REQUEST_FAILED	0x01
> +	__u32 result; /* the result of request */
> +	__u32 reserved[2]; /* for future use */
> +	union {
> +		struct vduse_vq_ready vq_ready; /* virtqueue ready status */
> +		struct vduse_vq_state vq_state; /* virtqueue state */
> +		struct vduse_dev_config_data config; /* virtio device config space */
> +		struct vduse_features f; /* virtio features */
> +		struct vduse_status s; /* device status */
> +		__u32 padding[16]; /* padding */


So it looks to me this padding doesn't work since vduse_dev_config_data 
is larger than it.


> +	};
> +};
> +
> +/* ioctls */
> +
> +struct vduse_dev_config {
> +	char name[VDUSE_NAME_MAX]; /* vduse device name */
> +	__u32 vendor_id; /* virtio vendor id */
> +	__u32 device_id; /* virtio device id */
> +	__u64 bounce_size; /* bounce buffer size for iommu */
> +	__u16 vq_num; /* the number of virtqueues */
> +	__u16 vq_size_max; /* the max size of virtqueue */
> +	__u32 vq_align; /* the allocation alignment of virtqueue's metadata */
> +	__u32 reserved[8]; /* for future use */


Is there a hole before reserved?


> +};
> +
> +struct vduse_iotlb_entry {
> +	__u64 offset; /* the mmap offset on fd */
> +	__u64 start; /* start of the IOVA range */
> +	__u64 last; /* last of the IOVA range */
> +#define VDUSE_ACCESS_RO 0x1
> +#define VDUSE_ACCESS_WO 0x2
> +#define VDUSE_ACCESS_RW 0x3
> +	__u8 perm; /* access permission of this range */
> +};
> +
> +struct vduse_vq_eventfd {
> +	__u32 index; /* virtqueue index */
> +#define VDUSE_EVENTFD_DEASSIGN -1
> +	int fd; /* eventfd, -1 means de-assigning the eventfd */
> +};
> +
> +#define VDUSE_BASE	0x81
> +
> +/* Get the version of VDUSE API. This is used for future extension */
> +#define VDUSE_GET_API_VERSION	_IO(VDUSE_BASE, 0x00)
> +
> +/* Set the version of VDUSE API. */
> +#define VDUSE_SET_API_VERSION	_IO(VDUSE_BASE, 0x01)
> +
> +/* Create a vduse device which is represented by a char device (/dev/vduse/<name>) */
> +#define VDUSE_CREATE_DEV	_IOW(VDUSE_BASE, 0x02, struct vduse_dev_config)
> +
> +/* Destroy a vduse device. Make sure there are no references to the char device */
> +#define VDUSE_DESTROY_DEV	_IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MAX])
> +
> +/*
> + * Get a file descriptor for the first overlapped iova region,
> + * -EINVAL means the iova region doesn't exist.
> + */
> +#define VDUSE_IOTLB_GET_FD	_IOWR(VDUSE_BASE, 0x04, struct vduse_iotlb_entry)
> +
> +/* Setup an eventfd to receive kick for virtqueue */
> +#define VDUSE_VQ_SETUP_KICKFD	_IOW(VDUSE_BASE, 0x05, struct vduse_vq_eventfd)
> +
> +/* Inject an interrupt for specific virtqueue */
> +#define VDUSE_INJECT_VQ_IRQ	_IO(VDUSE_BASE, 0x06)


Missing parameter?

Thanks


> +
> +/* Inject a config interrupt */
> +#define VDUSE_INJECT_CONFIG_IRQ	_IO(VDUSE_BASE, 0x07)
> +
> +#endif /* _UAPI_VDUSE_H_ */

