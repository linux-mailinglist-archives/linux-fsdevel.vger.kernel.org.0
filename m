Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F14778D4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbjHKLT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbjHKLT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:19:56 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A36E75
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:19:55 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230811111952epoutp01045c450e206b30802872170b63056482~6UDN8fW0L3025530255epoutp01Y
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:19:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230811111952epoutp01045c450e206b30802872170b63056482~6UDN8fW0L3025530255epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691752792;
        bh=41IvKjB7ObpkkH3NYijSy6MXGGyUeHBmOD8f30Qm08Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QGSpliyXUEtPGIX0MC35lPgbk3L8X3cEpNg4j7B1l/tIj1O1LQghTnXQVsa9v88i6
         +9iOwjqo8aUOSMSyAhO4pFvR74tDkwiXkHI3n6hoNl6QMQAbbZZYUlwP1GieQav4ny
         7ol7D2Iw2MbFLy4c1PxIIkwL+NPiAnaHxkuBIU7g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230811111951epcas5p38cb788aa62be90c0ec50fb384ee4da88~6UDNLo1WG0875108751epcas5p3r;
        Fri, 11 Aug 2023 11:19:51 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RMhCV0lPnz4x9Q2; Fri, 11 Aug
        2023 11:19:50 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.14.57354.55916D46; Fri, 11 Aug 2023 20:19:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230811105627epcas5p1aa1ef0e58bcd0fc05a072c8b40dcfb96~6TuyHqoMl0561805618epcas5p1k;
        Fri, 11 Aug 2023 10:56:27 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230811105627epsmtrp2c5c278f27b4947c70ec3bc65bd97da43~6TuyGnG362478224782epsmtrp29;
        Fri, 11 Aug 2023 10:56:27 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-bb-64d619550934
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.01.30535.BD316D46; Fri, 11 Aug 2023 19:56:27 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230811105623epsmtip28b74e7eda337ae274ac1e8f3adb2de6c~6TuubT0QE1205912059epsmtip2g;
        Fri, 11 Aug 2023 10:56:23 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 00/11] Implement copy offload support
Date:   Fri, 11 Aug 2023 16:22:43 +0530
Message-Id: <20230811105300.15889-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxTOe+9tucKYlyrbC5PJalwEB7QK5cXAlIlyIxviGHNz4aOhd0CA
        tukHIku0UxgfTtBNR1Y+6gJBAddKQQZ07QigIEYQDJWyqdvSTjNi2SSCCrK1XNz895znnOc8
        57wfJM5zcP3JHKmKUUjFeXyuJ9HZH7QpJMXPKhGUGaORYfgKjlpvV3HRdP9DgOy9pQD9+tN2
        ZHbWcJCttxtDza2XMfRVnxUgx4QWQ+apzei7LxoJ9KP5KoFu9tRyka7J4YHODS5haPKkA6DO
        BR2O9NMzBBqaeg2NPhvk7PClR++0EfTN62ra2FLOpdsbj9Amm4ZLN1R+zaFPHHNy6b8dUwQ9
        Y5ng0pUdLYCeNb5OG+0PsKSXDuRGZzNiCaMIZKSZMkmONCuGn5CcvjM9QiQQhgijUCQ/UCrO
        Z2L4ce8mhezOyXOtyg8sEOepXVSSWKnkh70drZCpVUxgtkypiuEzckmePFweqhTnK9XSrFAp
        o9omFAi2RLgKM3Kzyx6Zcbk+oVDzZB7TgNrICkCSkAqHI0N4BfAkeZQJwKUx80rwEMDLZh2H
        DeZcGesItwKsWlYslS4SbMIM4B/jbSuSEgyeHhvycPflUpvhtX9IN7+W0uDwoqkBuNU4pcOg
        2fmxu2YNFQU79Dw3TVAb4aOnFsyNvaltsGXCRrDjhcGquz4s7QOvfmsn2C7r4bFLNcu2kHpM
        wuk2K84OFwevPz1OsHgN/HOww4PF/nDWaV5Z4CBsPn2ey4qLAdTe0gI2sR2WDFfhbmOcCoKG
        njCWDoBnhvUYa/wyPLFgx1jeG3bVP8cb4AXD2ZX+ftA6//kKpuHj1iHgbsmjUqG1ZM9JsF77
        wjraF9bR/m98FuAtwI+RK/OzmMwIuVDKHPzvWjNl+Uaw/N6D47rApG4ptA9gJOgDkMT5a71j
        ksclPG+J+FARo5ClK9R5jLIPRLiO+BTu75spc30YqSpdGB4lCBeJROFRW0VC/qve0yV1Eh6V
        JVYxuQwjZxTPdRi5yl+DVafGi8jI/NimvUGmec+NV4y9TkFkl+PeWx/tOXKqzCujPYLzwCdF
        Dtp337pQEIDfuJNhXf/GjEds2obfyvGC0RtFOb1e+k9GL8YnZr5pq7o/c62zIG7EHL9r0ZRt
        mbPd/cvLsi/4XvIWImSGN2b1bkgPSNkbX9tZvi/t8G0UMJs4wBuOt4e8sunLYo3qnf22S5/p
        v2+rnKuvru+JHRceHvBdLfhlXbGX4v0wwY6t31SmPjtk6R9v+lCzLlHw84DatKvofNvqugSd
        qYbRN+1Uiro93/udU/jpGcs581F7KXRm1BUVxhgWD0w+MTRXf0Df/yF4csFQXdOdctTfmra/
        cpwUNvIJZbZYGIwrlOJ/Aa5MhSB4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvO5t4WspBj92q1qsP3WM2WL13X42
        i9eHPzFaPDnQzmjxYL+9xd53s1ktbh7YyWSxcvVRJotJh64xWjy9OovJYu8tbYuFbUtYLPbs
        PclicXnXHDaL+cueslssP/6PyeLGhKeMFtt+z2e2WPf6PYvFiVvSFuf/Hmd1EPU4f28ji8fl
        s6Uem1Z1snlsXlLvsftmA5vH4r7JrB69ze/YPD4+vcXi8X7fVTaPvi2rGD0+b5Lz2PTkLVMA
        TxSXTUpqTmZZapG+XQJXRsfXvcwF67wrGn5+Z2pgnGPexcjJISFgIvGv/Q9LFyMXh5DAbkaJ
        6d3HWCASkhLL/h5hhrCFJVb+e84OYgsJNDNJ/Hwq3MXIwcEmoC1x+j8HSK+IQBezROfOd2CD
        mAVWMknsPDyTEaRIWMBSYss6IZBeFgFVia+/9jGB2LwCVhKrrt5kASmRENCX6L8vCBEWlDg5
        8wlYmFlAXWL9PLBOZgF5ieats5knMPLPQlI1C6FqFpKqBYzMqxglUwuKc9Nziw0LjPJSy/WK
        E3OLS/PS9ZLzczcxguNSS2sH455VH/QOMTJxMB5ilOBgVhLhtQ2+lCLEm5JYWZValB9fVJqT
        WnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QDk03on9CPizq3F4X6cgR1c0Uned/3
        LD51Uv5WzbHoW/tOFC7Qmum99qB+f1Z83tZswbXTdwUf+ZvwYPanqfE8T/Nvfs9bcJkr10ag
        fGeBrqHgYleDMtdNUoeu3kywF/q3b3+0kKV92UPJwh1VF8XO73F/PuXgns5VlybNLEu+sOyT
        fpIPB8dErbNVetmaDQpLmu5pHb10qHXiBvFo+R326Qv11bs3VLxgTjiR5HRC9481z/86p9OT
        HpmW2TUrPD/zdo/IumQxsV02NrNYr55VlGZ1SUxtvH796K2Oy0k6zEsuyX38c/+JYrp/6oos
        6/+M16JXf5N/ILfoVXbv+4tH95lrL295srVOsuv+jAk9RUosxRmJhlrMRcWJADyY9Ao6AwAA
X-CMS-MailID: 20230811105627epcas5p1aa1ef0e58bcd0fc05a072c8b40dcfb96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105627epcas5p1aa1ef0e58bcd0fc05a072c8b40dcfb96
References: <CGME20230811105627epcas5p1aa1ef0e58bcd0fc05a072c8b40dcfb96@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch series covers the points discussed in past and most recently
in LSFMM'23[0].
We have covered the initial agreed requirements in this patch set and
further additional features suggested by community.

This is next iteration of our previous patch set v13[1].
We achieve copy offload by sending 2 bio's with source and destination
info and merge them to form a request. This request is sent to driver.
So this design works only for request based storage drivers.

Overall series supports:
========================
	1. Driver
		- NVMe Copy command (single NS, TP 4065), including support
		in nvme-target (for block and file back end).

	2. Block layer
		- Block-generic copy (REQ_OP_COPY_DST/SRC), operation with
                  interface accommodating two block-devs
                - Merging copy requests in request layer
		- Emulation, for in-kernel user when offload is natively 
                absent
		- dm-linear support (for cases not requiring split)

	3. User-interface
		- copy_file_range

Testing
=======
	Copy offload can be tested on:
	a. QEMU: NVME simple copy (TP 4065). By setting nvme-ns
		parameters mssrl,mcl, msrc. For more info [2].
	b. Null block device
        c. NVMe Fabrics loopback.
	d. blktests[3]

	Emulation can be tested on any device.

	fio[4].

Infra and plumbing:
===================
        We populate copy_file_range callback in def_blk_fops. 
        For devices that support copy-offload, use blkdev_copy_offload to
        achieve in-device copy.
        However for cases, where device doesn't support offload,
        fallback to generic_copy_file_range.
        For in-kernel users (like NVMe fabrics), use blkdev_copy_offload
        if device is copy offload capable or else fallback to emulation 
        using blkdev_copy_emulation.
        Modify checks in generic_copy_file_range to support block-device.

Blktests[3]
======================
	tests/block/035-040: Runs copy offload and emulation on null
                              block device.
	tests/block/050,055: Runs copy offload and emulation on test
                              nvme block device.
        tests/nvme/056-067: Create a loop backed fabrics device and
                              run copy offload and emulation.

Future Work
===========
	- loopback device copy offload support
	- upstream fio to use copy offload
	- upstream blktest to test copy offload
        - update man pages for copy_file_range
        - expand in-kernel users of copy offload

	These are to be taken up after this minimal series is agreed upon.

Additional links:
=================
	[0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=zT14mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
            https://lore.kernel.org/linux-nvme/f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com/
            https://lore.kernel.org/linux-nvme/20230113094648.15614-1-nj.shetty@samsung.com/
	[1] https://lore.kernel.org/linux-nvme/20230627183629.26571-1-nj.shetty@samsung.com/
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v14
	[4] https://github.com/OpenMPDK/fio/tree/copyoffload-3.35-v14

Changes since v13:
=================
        - block:
            1. Simplified copy offload and emulation helpers, now
                  caller needs to decide between offload/emulation fallback
            2. src,dst bio order change (Christoph Hellwig)
            3. refcount changes similar to dio (Christoph Hellwig)
            4. Single outstanding IO for copy emulation (Christoph Hellwig)
            5. use copy_max_sectors to identify copy offload
                  capability and other reviews (Damien, Christoph)
            6. Return status in endio handler (Christoph Hellwig)
        - nvme-fabrics: fallback to emulation in case of partial
          offload completion
        - in kernel user addition (Ming lei)
        - indentation, documentation, minor fixes, misc changes (Damien,
          Christoph)
        - blktests changes to test kernel changes

Changes since v12:
=================
        - block,nvme: Replaced token based approach with request based
          single namespace capable approach (Christoph Hellwig)

Changes since v11:
=================
        - Documentation: Improved documentation (Damien Le Moal)
        - block,nvme: ssize_t return values (Darrick J. Wong)
        - block: token is allocated to SECTOR_SIZE (Matthew Wilcox)
        - block: mem leak fix (Maurizio Lombardi)

Changes since v10:
=================
        - NVMeOF: optimization in NVMe fabrics (Chaitanya Kulkarni)
        - NVMeOF: sparse warnings (kernel test robot)

Changes since v9:
=================
        - null_blk, improved documentation, minor fixes(Chaitanya Kulkarni)
        - fio, expanded testing and minor fixes (Vincent Fu)

Changes since v8:
=================
        - null_blk, copy_max_bytes_hw is made config fs parameter
          (Damien Le Moal)
        - Negative error handling in copy_file_range (Christian Brauner)
        - minor fixes, better documentation (Damien Le Moal)
        - fio upgraded to 3.34 (Vincent Fu)

Changes since v7:
=================
        - null block copy offload support for testing (Damien Le Moal)
        - adding direct flag check for copy offload to block device,
	  as we are using generic_copy_file_range for cached cases.
        - Minor fixes

Changes since v6:
=================
        - copy_file_range instead of ioctl for direct block device
        - Remove support for multi range (vectored) copy
        - Remove ioctl interface for copy.
        - Remove offload support in dm kcopyd.

Changes since v5:
=================
	- Addition of blktests (Chaitanya Kulkarni)
        - Minor fix for fabrics file backed path
        - Remove buggy zonefs copy file range implementation.

Changes since v4:
=================
	- make the offload and emulation design asynchronous (Hannes
	  Reinecke)
	- fabrics loopback support
	- sysfs naming improvements (Damien Le Moal)
	- use kfree() instead of kvfree() in cio_await_completion
	  (Damien Le Moal)
	- use ranges instead of rlist to represent range_entry (Damien
	  Le Moal)
	- change argument ordering in blk_copy_offload suggested (Damien
	  Le Moal)
	- removed multiple copy limit and merged into only one limit
	  (Damien Le Moal)
	- wrap overly long lines (Damien Le Moal)
	- other naming improvements and cleanups (Damien Le Moal)
	- correctly format the code example in description (Damien Le
	  Moal)
	- mark blk_copy_offload as static (kernel test robot)
	
Changes since v3:
=================
	- added copy_file_range support for zonefs
	- added documentation about new sysfs entries
	- incorporated review comments on v3
	- minor fixes

Changes since v2:
=================
	- fixed possible race condition reported by Damien Le Moal
	- new sysfs controls as suggested by Damien Le Moal
	- fixed possible memory leak reported by Dan Carpenter, lkp
	- minor fixes

Changes since v1:
=================
	- sysfs documentation (Greg KH)
        - 2 bios for copy operation (Bart Van Assche, Mikulas Patocka,
          Martin K. Petersen, Douglas Gilbert)
        - better payload design (Darrick J. Wong)

Anuj Gupta (1):
  fs/read_write: Enable copy_file_range for block device.

Nitesh Shetty (10):
  block: Introduce queue limits and sysfs for copy-offload support
  Add infrastructure for copy offload in block and request layer.
  block: add copy offload support
  block: add emulation for copy
  fs, block: copy_file_range for def_blk_ops for direct block device
  nvme: add copy offload support
  nvmet: add copy command support for bdev and file ns
  dm: Add support for copy offload
  dm: Enable copy offload for dm-linear target
  null_blk: add support for copy offload

 Documentation/ABI/stable/sysfs-block |  23 ++
 Documentation/block/null_blk.rst     |   5 +
 block/blk-core.c                     |   7 +
 block/blk-lib.c                      | 419 +++++++++++++++++++++++++++
 block/blk-merge.c                    |  41 +++
 block/blk-settings.c                 |  24 ++
 block/blk-sysfs.c                    |  36 +++
 block/blk.h                          |  16 +
 block/elevator.h                     |   1 +
 block/fops.c                         |  25 ++
 drivers/block/null_blk/main.c        |  99 ++++++-
 drivers/block/null_blk/null_blk.h    |   1 +
 drivers/block/null_blk/trace.h       |  23 ++
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  37 +++
 drivers/md/dm.c                      |   7 +
 drivers/nvme/host/constants.c        |   1 +
 drivers/nvme/host/core.c             |  79 +++++
 drivers/nvme/host/trace.c            |  19 ++
 drivers/nvme/target/admin-cmd.c      |   9 +-
 drivers/nvme/target/io-cmd-bdev.c    |  97 +++++++
 drivers/nvme/target/io-cmd-file.c    |  50 ++++
 drivers/nvme/target/nvmet.h          |   4 +
 drivers/nvme/target/trace.c          |  19 ++
 fs/read_write.c                      |   8 +-
 include/linux/bio.h                  |   6 +-
 include/linux/blk_types.h            |  10 +
 include/linux/blkdev.h               |  22 ++
 include/linux/device-mapper.h        |   3 +
 include/linux/nvme.h                 |  43 ++-
 30 files changed, 1119 insertions(+), 16 deletions(-)


base-commit: f7dc24b3413851109c4047b22997bd0d95ed52a2
-- 
2.35.1.500.gb896f729e2

