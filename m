Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA3D3B183
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 11:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388604AbfFJJIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 05:08:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388190AbfFJJIW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:08:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7368330984D1;
        Mon, 10 Jun 2019 09:08:07 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-103.sin2.redhat.com [10.67.116.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9D5060BF1;
        Mon, 10 Jun 2019 09:07:36 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     dm-devel@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
        yuval.shaia@oracle.com, kilobyte@angband.pl, jstaron@google.com,
        rdunlap@infradead.org, snitzer@redhat.com, pagupta@redhat.com
Subject: [PATCH v11 0/7] virtio pmem driver 
Date:   Mon, 10 Jun 2019 14:37:23 +0530
Message-Id: <20190610090730.8589-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 10 Jun 2019 09:08:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 This patch series is ready to be merged via nvdimm tree
 as discussed with Dan. We have ack/review on XFS, EXT4 &
 VIRTIO patches. Need an ack on device mapper change in
 patch 4.

 Mike, Can you please review and ack patch4.

 This version does not has any additonal code change from v10 
 and is only rebase of v10 on Linux 5.2-rc4 which is required 
 for patch4. Keeping all the existing r-o-bs. Jakob CCed also
 tested the patch series and confirmed the working of v9.
 ---

 This patch series has implementation for "virtio pmem". 
 "virtio pmem" is fake persistent memory(nvdimm) in guest 
 which allows to bypass the guest page cache. This also
 implements a VIRTIO based asynchronous flush mechanism.  
 
 Sharing guest kernel driver in this patchset with the 
 changes suggested in v4. Tested with Qemu side device 
 emulation [5] for virtio-pmem. Documented the impact of
 possible page cache side channel attacks with suggested
 countermeasures.

 Details of project idea for 'virtio pmem' flushing interface 
 is shared [3] & [4].

 Implementation is divided into two parts:
 New virtio pmem guest driver and qemu code changes for new 
 virtio pmem paravirtualized device.

1. Guest virtio-pmem kernel driver
---------------------------------
   - Reads persistent memory range from paravirt device and 
     registers with 'nvdimm_bus'.  
   - 'nvdimm/pmem' driver uses this information to allocate 
     persistent memory region and setup filesystem operations 
     to the allocated memory. 
   - virtio pmem driver implements asynchronous flushing 
     interface to flush from guest to host.

2. Qemu virtio-pmem device
---------------------------------
   - Creates virtio pmem device and exposes a memory range to 
     KVM guest. 
   - At host side this is file backed memory which acts as 
     persistent memory. 
   - Qemu side flush uses aio thread pool API's and virtio 
     for asynchronous guest multi request handling. 

 Virtio-pmem security implications and countermeasures:
 -----------------------------------------------------

 In previous posting of kernel driver, there was discussion [7]
 on possible implications of page cache side channel attacks with 
 virtio pmem. After thorough analysis of details of known side 
 channel attacks, below are the suggestions:

 - Depends entirely on how host backing image file is mapped 
   into guest address space. 

 - virtio-pmem device emulation, by default shared mapping is used
   to map host backing file. It is recommended to use separate
   backing file at host side for every guest. This will prevent
   any possibility of executing common code from multiple guests
   and any chance of inferring guest local data based based on 
   execution time.

 - If backing file is required to be shared among multiple guests 
   it is recommended to don't support host page cache eviction 
   commands from the guest driver. This will avoid any possibility
   of inferring guest local data or host data from another guest. 

 - Proposed device specification [6] for virtio-pmem device with 
   details of possible security implications and suggested 
   countermeasures for device emulation.

 Virtio-pmem errors handling:
 ----------------------------------------
  Checked behaviour of virtio-pmem for below types of errors
  Need suggestions on expected behaviour for handling these errors?

  - Hardware Errors: Uncorrectable recoverable Errors: 
  a] virtio-pmem: 
    - As per current logic if error page belongs to Qemu process, 
      host MCE handler isolates(hwpoison) that page and send SIGBUS. 
      Qemu SIGBUS handler injects exception to KVM guest. 
    - KVM guest then isolates the page and send SIGBUS to guest 
      userspace process which has mapped the page. 
  
  b] Existing implementation for ACPI pmem driver: 
    - Handles such errors with MCE notifier and creates a list 
      of bad blocks. Read/direct access DAX operation return EIO 
      if accessed memory page fall in bad block list.
    - It also starts backgound scrubbing.  
    - Similar functionality can be reused in virtio-pmem with MCE 
      notifier but without scrubbing(no ACPI/ARS)? Need inputs to 
      confirm if this behaviour is ok or needs any change?

Changes from PATCH v10: [1] 
 - Rebased on Linux-5.2-rc4

Changes from PATCH v9: [2] 
 - Kconfig help text add two spaces - Randy
 - Fixed libnvdimm 'bio' include warning - Dan
 - virtio-pmem, separate request/resp struct and 
   move to uapi file with updated license - DavidH
 - Use virtio32* type for req/resp endianess - DavidH
 - Added tested-by & ack-by of Jakob
 - Rebased to 5.2-rc1

Changes from PATCH v8:
 - Set device mapper synchronous if all target devices support - Dan
 - Move virtio_pmem.h to nvdimm directory  - Dan
 - Style, indentation & better error messages in patch 2 - DavidH
 - Added MST's ack in patch 2.

Changes from PATCH v7:
 - Corrected pending request queue logic (patch 2) - Jakub Staroń
 - Used unsigned long flags for passing DAXDEV_F_SYNC (patch 3) - Dan
 - Fixed typo =>  vma 'flag' to 'vm_flag' (patch 4)
 - Added rob in patch 6 & patch 2

Changes from PATCH v6: 
 - Corrected comment format in patch 5 & patch 6. [Dave]
 - Changed variable declaration indentation in patch 6 [Darrick]
 - Add Reviewed-by tag by 'Jan Kara' in patch 4 & patch 5

Changes from PATCH v5: 
  Changes suggested in by - [Cornelia, Yuval]
- Remove assignment chaining in virtio driver
- Better error message and remove not required free
- Check nd_region before use

  Changes suggested by - [Jan Kara]
- dax_synchronous() for !CONFIG_DAX
- Correct 'daxdev_mapping_supported' comment and non-dax implementation

  Changes suggested by - [Dan Williams]
- Pass meaningful flag 'DAXDEV_F_SYNC' to alloc_dax
- Gate nvdimm_flush instead of additional async parameter
- Move block chaining logic to flush callback than common nvdimm_flush
- Use NULL flush callback for generic flush for better readability [Dan, Jan]

- Use virtio device id 27 from 25(already used) - [MST]

Changes from PATCH v4:
- Factor out MAP_SYNC supported functionality to a common helper
				[Dave, Darrick, Jan]
- Comment, indentation and virtqueue_kick failure handle - Yuval Shaia

Changes from PATCH v3: 
- Use generic dax_synchronous() helper to check for DAXDEV_SYNC 
  flag - [Dan, Darrick, Jan]
- Add 'is_nvdimm_async' function
- Document page cache side channel attacks implications & 
  countermeasures - [Dave Chinner, Michael]

Changes from PATCH v2: 
- Disable MAP_SYNC for ext4 & XFS filesystems - [Dan] 
- Use name 'virtio pmem' in place of 'fake dax' 

Changes from PATCH v1: 
- 0-day build test for build dependency on libnvdimm 

 Changes suggested by - [Dan Williams]
- Split the driver into two parts virtio & pmem  
- Move queuing of async block request to block layer
- Add "sync" parameter in nvdimm_flush function
- Use indirect call for nvdimm_flush
- Don’t move declarations to common global header e.g nd.h
- nvdimm_flush() return 0 or -EIO if it fails
- Teach nsio_rw_bytes() that the flush can fail
- Rename nvdimm_flush() to generic_nvdimm_flush()
- Use 'nd_region->provider_data' for long dereferencing
- Remove virtio_pmem_freeze/restore functions
- Remove BSD license text with SPDX license text

- Add might_sleep() in virtio_pmem_flush - [Luiz]
- Make spin_lock_irqsave() narrow

Pankaj Gupta (7):
   libnvdimm: nd_region flush callback support
   virtio-pmem: Add virtio-pmem guest driver
   libnvdimm: add nd_region buffered dax_dev flag
   dax: check synchronous mapping is supported
   dm: dm: Enable synchronous dax
   ext4: disable map_sync for virtio pmem
   xfs: disable map_sync for virtio pmem

[1] https://lkml.org/lkml/2019/5/21/569
[2] https://lkml.org/lkml/2019/5/14/465
[3] https://www.spinics.net/lists/kvm/msg149761.html
[4] https://www.spinics.net/lists/kvm/msg153095.html  
[5] https://marc.info/?l=qemu-devel&m=155860751202202&w=2
[6] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
[7] https://lkml.org/lkml/2019/1/9/1191

 drivers/acpi/nfit/core.c         |    4 -
 drivers/dax/bus.c                |    2 
 drivers/dax/super.c              |   19 +++++
 drivers/md/dm-table.c            |   14 ++++
 drivers/md/dm.c                  |    3 
 drivers/nvdimm/Makefile          |    1 
 drivers/nvdimm/claim.c           |    6 +
 drivers/nvdimm/nd.h              |    1 
 drivers/nvdimm/nd_virtio.c       |  124 +++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/pmem.c            |   18 +++--
 drivers/nvdimm/region_devs.c     |   33 +++++++++-
 drivers/nvdimm/virtio_pmem.c     |  122 ++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/virtio_pmem.h     |   55 +++++++++++++++++
 drivers/virtio/Kconfig           |   11 +++
 fs/ext4/file.c                   |   10 +--
 fs/xfs/xfs_file.c                |    9 +-
 include/linux/dax.h              |   26 +++++++-
 include/linux/libnvdimm.h        |   10 ++-
 include/uapi/linux/virtio_ids.h  |    1 
 include/uapi/linux/virtio_pmem.h |   35 +++++++++++
 20 files changed, 479 insertions(+), 25 deletions(-)

