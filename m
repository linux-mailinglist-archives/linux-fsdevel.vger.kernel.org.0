Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736A024A925
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 00:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHSWV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 18:21:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21320 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726640AbgHSWVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RVpkWZgoV/McsG5/jmbAEgGEb94GIerA/7gyN/jgusE=;
        b=Ok3m4DbPMyO6K3BWckFr4t7Qzr+0Tr/TPtlAmDj7Gc1EnaD5+hZGYx9TI+AhsynAnM/xpp
        DKKMvH6sF8/+GzlwIcLcKdh1YuhUc+jjICdnOL6bqlXqlB6lDx2IjIcedhv7m69XDk62+d
        uFi+azI5sMJ2mB7+SaggDKVnAaEyUTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-Vhl7GqQLPZ6PGB3isPPanQ-1; Wed, 19 Aug 2020 18:21:02 -0400
X-MC-Unique: Vhl7GqQLPZ6PGB3isPPanQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3A88807332;
        Wed, 19 Aug 2020 22:21:00 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C85E5C893;
        Wed, 19 Aug 2020 22:20:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BC4D3223C69; Wed, 19 Aug 2020 18:20:53 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, dan.j.williams@intel.com,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Subject: [PATCH v3 00/18] virtiofs: Add DAX support
Date:   Wed, 19 Aug 2020 18:19:38 -0400
Message-Id: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

This is V3 of patches. I had posted version v2 version here.

https://lore.kernel.org/linux-fsdevel/20200807195526.426056-1-vgoyal@redhat.com/

I have taken care of comments from V2. Changes from V2 are.

- Rebased patches on top of 5.9-rc1

- Renamed couple of functions to get rid of iomap prefix. (Dave Chinner)

- Modified truncate/punch_hole paths to serialize with dax fault
  path. For now did this only for dax paths. May be non-dax path
  can benefit from this too. But that is an option for a different
  day. (Dave Chinner).

- Took care of comments by Jan Kara in dax_layout_busy_page_range()
  implementation patch.

- Dropped one of the patches which forced sync release in
  fuse_file_put() path for DAX files. It was redundant now as virtiofs
  already sets fs_context->destroy which forces sync release. (Miklos)

- Took care of some of the errors flagged by checkpatch.pl.

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

Vivek Goyal (13):
  dax: Modify bdev_dax_pgoff() to handle NULL bdev
  dax: Create a range version of dax_layout_busy_page()
  virtiofs: Provide a helper function for virtqueue initialization
  fuse: Get rid of no_mount_options
  fuse,virtiofs: Add a mount option to enable dax
  fuse,virtiofs: Keep a list of free dax memory ranges
  fuse: implement FUSE_INIT map_alignment field
  fuse: Introduce setupmapping/removemapping commands
  fuse, dax: Implement dax read/write operations
  fuse,virtiofs: Define dax address space operations
  fuse, dax: Serialize truncate/punch_hole and dax fault path
  fuse,virtiofs: Maintain a list of busy elements
  fuse,virtiofs: Add logic to free up a memory range

 drivers/dax/super.c                |    3 +-
 drivers/virtio/virtio_mmio.c       |   31 +
 drivers/virtio/virtio_pci_modern.c |   95 +++
 fs/dax.c                           |   29 +-
 fs/fuse/dir.c                      |   32 +-
 fs/fuse/file.c                     | 1198 +++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h                   |  114 ++-
 fs/fuse/inode.c                    |  146 +++-
 fs/fuse/virtio_fs.c                |  279 ++++++-
 include/linux/dax.h                |    6 +
 include/linux/virtio_config.h      |   17 +
 include/uapi/linux/fuse.h          |   34 +-
 include/uapi/linux/virtio_fs.h     |    3 +
 include/uapi/linux/virtio_mmio.h   |   11 +
 include/uapi/linux/virtio_pci.h    |   11 +-
 15 files changed, 1933 insertions(+), 76 deletions(-)

Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vishal L Verma <vishal.l.verma@intel.com>
-- 
2.25.4

