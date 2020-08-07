Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB4923F33C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHGTzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:55:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58296 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbgHGTzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jVrRK0HV/H9DR9b13ES1fWqQ8opHza6TOOOLCeQeRIY=;
        b=PGj7HzxMZb6AeVA0n87vwCy0Fr61hO5xqEmjxmSSCbP0EdNEKAoR1Q0FjBERtlEw19xUDG
        Egm+N5OEZgbUdN/bw/cXXrDZp9gJtyBjNYJ8507BN6HLo4GbJCkDT33kdJQNXMe7O9nS02
        YZmeaF+hBOPSr0LB/p3K+VNt5rQbsyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-yJh429eIOG2dN6qVa51MyQ-1; Fri, 07 Aug 2020 15:55:46 -0400
X-MC-Unique: yJh429eIOG2dN6qVa51MyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13BD5800688;
        Fri,  7 Aug 2020 19:55:45 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2260D10027A6;
        Fri,  7 Aug 2020 19:55:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9EA17222E3F; Fri,  7 Aug 2020 15:55:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v2 00/20] virtiofs: Add DAX support 
Date:   Fri,  7 Aug 2020 15:55:06 -0400
Message-Id: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

This is V2 of the patches. I had posted V1 here.

https://lore.kernel.org/linux-fsdevel/20200304165845.3081-1-vgoyal@redhat.com/

I have taken care of most of the comments from V1.

Amir had suggested that some of the code can be moved to a new file, may
be post series. I have left that item for the post series cleanup.

Miklos was concerned about KVM error handling when a mapped file on
host gets truncated and guest tries to access it. As of now guest
can spin in infinite loop. I have tried to address that with KVM
developers and there is no easy race free way to inject synchronous
exception which can indicate error in guest. For now, I have proposed
that atleast guest can exit to qemu with error when such scenario
happen and proposed a patch which has got two acks. But it has not
been merged yet.

https://lore.kernel.org/kvm/20200720211359.GF502563@redhat.com/

We don't support modifications in virtiofs files from host or
from other guests. And even if somebody modifies it, qemu will
exit gracefully without bringing down host. So I think this
probably is good enough for now to make progress on virtiofs DAX
patches.

Fixing kvm to inject errors is not easy and is a complicated design.
We will need to make sure that happens before we support DAX in
shared mode in virtiofs. But blocking behind this is proabably not
a good idea because DAX can be very useful in non-shared mode in
kata containers.

Performance numbers are more or less same as in V1 post. So I am
not providing any numbers again. In general, DAX can provide a good
performance boost and memory savings.

Any thoughts or feedback is welcome.

Description from previous post
------------------------------

This patch series adds DAX support to virtiofs filesystem. This allows
bypassing guest page cache and allows mapping host page cache directly
in guest address space.

When a page of file is needed, guest sends a request to map that page
(in host page cache) in qemu address space. Inside guest this is
a physical memory range controlled by virtiofs device. And guest
directly maps this physical address range using DAX and hence gets
access to file data on host.

This can speed up things considerably in many situations. Also this
can result in substantial memory savings as file data does not have
to be copied in guest and it is directly accessed from host page
cache.

Most of the changes are limited to fuse/virtiofs. There are couple
of changes needed in generic dax infrastructure and couple of changes
in virtio to be able to access shared memory region.
 
Thanks
Vivek

Sebastien Boeuf (3):
  virtio: Add get_shm_region method
  virtio: Implement get_shm_region for PCI transport
  virtio: Implement get_shm_region for MMIO transport

Stefan Hajnoczi (2):
  virtio_fs, dax: Set up virtio_fs dax_device
  fuse,dax: add DAX mmap support

Vivek Goyal (15):
  dax: Modify bdev_dax_pgoff() to handle NULL bdev
  dax: Create a range version of dax_layout_busy_page()
  virtiofs: Provide a helper function for virtqueue initialization
  fuse: Get rid of no_mount_options
  fuse,virtiofs: Add a mount option to enable dax
  fuse,virtiofs: Keep a list of free dax memory ranges
  fuse: implement FUSE_INIT map_alignment field
  fuse: Introduce setupmapping/removemapping commands
  fuse, dax: Implement dax read/write operations
  fuse, dax: Take ->i_mmap_sem lock during dax page fault
  fuse,virtiofs: Define dax address space operations
  fuse,virtiofs: Maintain a list of busy elements
  fuse: Release file in process context
  fuse: Take inode lock for dax inode truncation
  fuse,virtiofs: Add logic to free up a memory range

 drivers/dax/super.c                |    3 +-
 drivers/virtio/virtio_mmio.c       |   32 +
 drivers/virtio/virtio_pci_modern.c |   96 +++
 fs/dax.c                           |   66 +-
 fs/fuse/dir.c                      |    2 +
 fs/fuse/file.c                     | 1189 +++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h                   |  112 ++-
 fs/fuse/inode.c                    |  147 +++-
 fs/fuse/virtio_fs.c                |  279 ++++++-
 include/linux/dax.h                |    6 +
 include/linux/virtio_config.h      |   17 +
 include/uapi/linux/fuse.h          |   34 +-
 include/uapi/linux/virtio_fs.h     |    3 +
 include/uapi/linux/virtio_mmio.h   |   11 +
 include/uapi/linux/virtio_pci.h    |   11 +-
 15 files changed, 1927 insertions(+), 81 deletions(-)

-- 
2.25.4

