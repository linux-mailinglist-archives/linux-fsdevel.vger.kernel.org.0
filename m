Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50483C6C45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhGMIuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhGMIuN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:50:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6853DC0613DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d12so20981393pgd.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rv8gj4jA0FtBvDj5QpcpkmbVeDKmo9ccDDVHnkHtgCU=;
        b=A63bmGGBwau1O/rJ5EaGwoi11K18AQBZ6fD+MFwM6tHXeZjN+FZ2OloX2zjeF+Yur2
         YlL7cD1GiyAsrwaaLCRBQGkVmTtI1sJ8Bwz6kP2U5a5uJS/qtD9buN8U7JZiQN1tj1Ov
         kDXOVOHJAnkqoVvgwnaKCF/mhH3XS0FixLRUnnJ4Q1CuTDfvB/1b3ZmRdxvlNu41wD6O
         zJ+q4uZJY3zRzjzD9JxM4R/yCAk0js/y2qbMFBqaIjnLupR5k68SfAf7DqX4njeJFrPy
         JRxWFbyH6ZTbTcALO9/1s4wk6TtDnWs3QoMMj3ag/UxotJ+tA0gCvPnFzLQD3F8IKbQX
         w+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rv8gj4jA0FtBvDj5QpcpkmbVeDKmo9ccDDVHnkHtgCU=;
        b=SbjstnGFUp2BIxrz/7wYdWZImixe/QFJ+F0x5CixFw+PMUKWyTkD4CIwdfWP3nTgWe
         9qyTXbovTbniTsbFp10/P0pwxc702TbP5p654MrVt6lYsXl+dre+sTr+qpJi2lGcY7f5
         8dV5rMfGEeb01HVdQAZHvIB8KZbvdbD42c4ru3Xxf64xu/NZGaUtsAUWoqyLzeY8uxIn
         ocS2GPa57lROSzos3mBDP+jPBGLv3n8Kxr7+04DLZmTxy8EbDeXfGfnvYXvea/P0odsi
         zLS0a/szSTKnmwMQoSBfYlSNxNFjRQkwsMAotC5hEv5l4h8EfwiwLY3ghQSk4Yij67XC
         +37w==
X-Gm-Message-State: AOAM530wegKbTpbw+WGPL3J7iL5spYeNLERP8QeKKhCp9rsQvjTeQQec
        n0URumr07mGuwNS7dRlVm9sR
X-Google-Smtp-Source: ABdhPJwipbRjQjDJxXSpT9538xRpYXTXyx/lH7SJR6xJlqh0VT8xfyfUqL+l+USs2N1YZyaloRL3Fg==
X-Received: by 2002:a62:8f4a:0:b029:327:6616:410f with SMTP id n71-20020a628f4a0000b02903276616410fmr3412310pfd.68.1626166042922;
        Tue, 13 Jul 2021 01:47:22 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id t17sm20462768pgl.93.2021.07.13.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:47:22 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 00/17] Introduce VDUSE - vDPA Device in Userspace
Date:   Tue, 13 Jul 2021 16:46:39 +0800
Message-Id: <20210713084656.232-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series introduces a framework that makes it possible to implement
software-emulated vDPA devices in userspace. And to make the device
emulation more secure, the emulated vDPA device's control path is handled
in the kernel and only the data path is implemented in the userspace.

Since the emuldated vDPA device's control path is handled in the kernel,
a message mechnism is introduced to make userspace be aware of the data
path related changes. Userspace can use read()/write() to receive/reply
the control messages.

In the data path, the core is mapping dma buffer into VDUSE daemon's
address space, which can be implemented in different ways depending on
the vdpa bus to which the vDPA device is attached.

In virtio-vdpa case, we implements a MMU-based on-chip IOMMU driver with
bounce-buffering mechanism to achieve that. And in vhost-vdpa case, the dma
buffer is reside in a userspace memory region which can be shared to the
VDUSE userspace processs via transferring the shmfd.

The details and our user case is shown below:

------------------------    -------------------------   ----------------------------------------------
|            Container |    |              QEMU(VM) |   |                               VDUSE daemon |
|       ---------      |    |  -------------------  |   | ------------------------- ---------------- |
|       |dev/vdx|      |    |  |/dev/vhost-vdpa-x|  |   | | vDPA device emulation | | block driver | |
------------+-----------     -----------+------------   -------------+----------------------+---------
            |                           |                            |                      |
            |                           |                            |                      |
------------+---------------------------+----------------------------+----------------------+---------
|    | block device |           |  vhost device |            | vduse driver |          | TCP/IP |    |
|    -------+--------           --------+--------            -------+--------          -----+----    |
|           |                           |                           |                       |        |
| ----------+----------       ----------+-----------         -------+-------                |        |
| | virtio-blk driver |       |  vhost-vdpa driver |         | vdpa device |                |        |
| ----------+----------       ----------+-----------         -------+-------                |        |
|           |      virtio bus           |                           |                       |        |
|   --------+----+-----------           |                           |                       |        |
|                |                      |                           |                       |        |
|      ----------+----------            |                           |                       |        |
|      | virtio-blk device |            |                           |                       |        |
|      ----------+----------            |                           |                       |        |
|                |                      |                           |                       |        |
|     -----------+-----------           |                           |                       |        |
|     |  virtio-vdpa driver |           |                           |                       |        |
|     -----------+-----------           |                           |                       |        |
|                |                      |                           |    vdpa bus           |        |
|     -----------+----------------------+---------------------------+------------           |        |
|                                                                                        ---+---     |
-----------------------------------------------------------------------------------------| NIC |------
                                                                                         ---+---
                                                                                            |
                                                                                   ---------+---------
                                                                                   | Remote Storages |
                                                                                   -------------------

We make use of it to implement a block device connecting to
our distributed storage, which can be used both in containers and
VMs. Thus, we can have an unified technology stack in this two cases.

To test it with null-blk:

  $ qemu-storage-daemon \
      --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server,nowait \
      --monitor chardev=charmonitor \
      --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0 \
      --export type=vduse-blk,id=test,node-name=disk0,writable=on,name=vduse-null,num-queues=16,queue-size=128

The qemu-storage-daemon can be found at https://github.com/bytedance/qemu/tree/vduse

To make the userspace VDUSE processes such as qemu-storage-daemon able
to be run by an unprivileged user. We limit the supported device type
to virtio block device currently. The support for other device types
can be added after the security issue of corresponding device driver
is clarified or fixed in the future.

This series is now based on:

https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/
https://lore.kernel.org/lkml/20210705071910.31965-1-jasowang@redhat.com/
https://lore.kernel.org/lkml/20210602021536.39525-1-jasowang@redhat.com/

Future work:
  - Improve performance
  - Userspace library (find a way to reuse device emulation code in qemu/rust-vmm)
  - Support more device types

V8 to V9:
- Add VDUSE_SET_STATUS message to replace VDUSE_START/STOP_DATAPLANE messages
- Support packed virtqueue state
- Handle the reset failure in both virtio-vdpa and vhost-vdpa cases
- Add more details in documentation
- Remove VDUSE_REQ_FLAGS_NO_REPLY flag
- Add VDUSE_VQ_SETUP ioctl to support per-vq configuration
- Separate config interrupt injecting out of config update
- Flush kworker for interrupt inject during resetting
- Validate the config_size in .get_config()

V7 to V8:
- Rebased to newest kernel tree
- Rework VDUSE driver to handle the device's control path in kernel
- Limit the supported device type to virtio block device
- Export free_iova_fast()
- Remove the virtio-blk and virtio-scsi patches (will send them alone)
- Remove all module parameters
- Use the same MAJOR for both control device and VDUSE devices
- Avoid eventfd cleanup in vduse_dev_release()

V6 to V7:
- Export alloc_iova_fast()
- Add get_config_size() callback
- Add some patches to avoid trusting virtio devices
- Add limited device emulation
- Add some documents
- Use workqueue to inject config irq
- Add parameter on vq irq injecting
- Rename vduse_domain_get_mapping_page() to vduse_domain_get_coherent_page()
- Add WARN_ON() to catch message failure
- Add some padding/reserved fields to uAPI structure
- Fix some bugs
- Rebase to vhost.git

V5 to V6:
- Export receive_fd() instead of __receive_fd()
- Factor out the unmapping logic of pa and va separatedly
- Remove the logic of bounce page allocation in page fault handler
- Use PAGE_SIZE as IOVA allocation granule
- Add EPOLLOUT support
- Enable setting API version in userspace
- Fix some bugs

V4 to V5:
- Remove the patch for irq binding
- Use a single IOTLB for all types of mapping
- Factor out vhost_vdpa_pa_map()
- Add some sample codes in document
- Use receice_fd_user() to pass file descriptor
- Fix some bugs

V3 to V4:
- Rebase to vhost.git
- Split some patches
- Add some documents
- Use ioctl to inject interrupt rather than eventfd
- Enable config interrupt support
- Support binding irq to the specified cpu
- Add two module parameter to limit bounce/iova size
- Create char device rather than anon inode per vduse
- Reuse vhost IOTLB for iova domain
- Rework the message mechnism in control path

V2 to V3:
- Rework the MMU-based IOMMU driver
- Use the iova domain as iova allocator instead of genpool
- Support transferring vma->vm_file in vhost-vdpa
- Add SVA support in vhost-vdpa
- Remove the patches on bounce pages reclaim

V1 to V2:
- Add vhost-vdpa support
- Add some documents
- Based on the vdpa management tool
- Introduce a workqueue for irq injection
- Replace interval tree with array map to store the iova_mapu

Xie Yongji (17):
  iova: Export alloc_iova_fast() and free_iova_fast()
  file: Export receive_fd() to modules
  vdpa: Fix code indentation
  vdpa: Fail the vdpa_reset() if fail to set device status to zero
  vhost-vdpa: Fail the vhost_vdpa_set_status() on reset failure
  vhost-vdpa: Handle the failure of vdpa_reset()
  virtio: Don't set FAILED status bit on device index allocation failure
  virtio_config: Add a return value to reset function
  virtio-vdpa: Handle the failure of vdpa_reset()
  virtio: Handle device reset failure in register_virtio_device()
  vhost-iotlb: Add an opaque pointer for vhost IOTLB
  vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
  vdpa: factor out vhost_vdpa_pa_map() and vhost_vdpa_pa_unmap()
  vdpa: Support transferring virtual addressing during DMA mapping
  vduse: Implement an MMU-based IOMMU driver
  vduse: Introduce VDUSE - vDPA Device in Userspace
  Documentation: Add documentation for VDUSE

 Documentation/userspace-api/index.rst              |    1 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 Documentation/userspace-api/vduse.rst              |  248 ++++
 arch/um/drivers/virtio_uml.c                       |    4 +-
 drivers/iommu/iova.c                               |    2 +
 drivers/platform/mellanox/mlxbf-tmfifo.c           |    4 +-
 drivers/remoteproc/remoteproc_virtio.c             |    4 +-
 drivers/s390/virtio/virtio_ccw.c                   |    6 +-
 drivers/vdpa/Kconfig                               |   10 +
 drivers/vdpa/Makefile                              |    1 +
 drivers/vdpa/ifcvf/ifcvf_main.c                    |    2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |    2 +-
 drivers/vdpa/vdpa.c                                |    9 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |    8 +-
 drivers/vdpa/vdpa_user/Makefile                    |    5 +
 drivers/vdpa/vdpa_user/iova_domain.c               |  545 +++++++
 drivers/vdpa/vdpa_user/iova_domain.h               |   73 +
 drivers/vdpa/vdpa_user/vduse_dev.c                 | 1502 ++++++++++++++++++++
 drivers/vdpa/virtio_pci/vp_vdpa.c                  |    2 +-
 drivers/vhost/iotlb.c                              |   20 +-
 drivers/vhost/vdpa.c                               |  168 ++-
 drivers/virtio/virtio.c                            |   17 +-
 drivers/virtio/virtio_pci_legacy.c                 |    4 +-
 drivers/virtio/virtio_pci_modern.c                 |    4 +-
 drivers/virtio/virtio_vdpa.c                       |    4 +-
 fs/file.c                                          |    6 +
 include/linux/file.h                               |    7 +-
 include/linux/vdpa.h                               |   46 +-
 include/linux/vhost_iotlb.h                        |    3 +
 include/linux/virtio_config.h                      |    3 +-
 include/uapi/linux/vduse.h                         |  221 +++
 31 files changed, 2858 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/userspace-api/vduse.rst
 create mode 100644 drivers/vdpa/vdpa_user/Makefile
 create mode 100644 drivers/vdpa/vdpa_user/iova_domain.c
 create mode 100644 drivers/vdpa/vdpa_user/iova_domain.h
 create mode 100644 drivers/vdpa/vdpa_user/vduse_dev.c
 create mode 100644 include/uapi/linux/vduse.h

-- 
2.11.0

