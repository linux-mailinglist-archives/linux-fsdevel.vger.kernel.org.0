Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CB279424E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbjIFRyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbjIFRyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:54:10 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAADE59
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:54:02 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230906175400epoutp03757e9b7d5f32f00ea877075e5994b191~CYMxYFOQe1173811738epoutp03Q
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230906175400epoutp03757e9b7d5f32f00ea877075e5994b191~CYMxYFOQe1173811738epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022840;
        bh=zjiBUXeQQiPFBBeRfszNYw/NepMitAgdZE/zX6/emoY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DClk+EPHg9yS6PTv0VeUgtWrjpnrD8MdTjOXFO7I/HaakCo9fRkA7FiVNAM3DFI9g
         afoNbNKD6XR4wk6ef6icUENeZw2wDkgC+9VmLvWvy0p8MySYfFr6GeHwXYn/ixxqmz
         C0K//I2qjaRFzKmdOvb5dMOIYZt1xA3mQuGK23D4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230906175359epcas5p4f3cccee4106df2d613de561b0359a43b~CYMwU6gQe0423104231epcas5p4X;
        Wed,  6 Sep 2023 17:53:59 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RgqkG2rQ6z4x9Pp; Wed,  6 Sep
        2023 17:53:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.03.09949.6BCB8F46; Thu,  7 Sep 2023 02:53:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230906164238epcas5p4a511a029fb8ae8bbc36b750712ad64d5~CXOdeSUpf2734127341epcas5p4E;
        Wed,  6 Sep 2023 16:42:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230906164238epsmtrp2baf7a7892cf080a3beb50586f1bf1d21~CXOddE7A_0952809528epsmtrp2S;
        Wed,  6 Sep 2023 16:42:38 +0000 (GMT)
X-AuditID: b6c32a49-bd9f8700000026dd-cc-64f8bcb65223
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.0B.08742.EFBA8F46; Thu,  7 Sep 2023 01:42:38 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164235epsmtip2fa93525e39c7b0e767974ebb21f56a2c~CXOaxAF510210902109epsmtip2S;
        Wed,  6 Sep 2023 16:42:35 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 00/12] Implement copy offload support
Date:   Wed,  6 Sep 2023 22:08:25 +0530
Message-Id: <20230906163844.18754-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbZRTPd+/t5cJg3BVk31Aeqc5sEB7VUj4KTNxQLg7DwxgzJqnX9qYQ
        oG162+HQbBgeWiaPycy0iIxBNgbbYIAwHjUEAmzA3HQZCg4hCxgCWh5bYAsMpFym++/3+51z
        fuec70Hh4inSk0rTGjmDls2QkE5Ea+/+fQGtXY/VwXOPnVHDYD+O6sdLSDTXuwTQVPcXAFlt
        5SI02t2OoUv1fRj6umcEoOl7FgxZx/xRVUENgbqsNwl0t+N7ElVemHZAFwfWMfR76TRArauV
        OLo6N0+gG2MvottPB0RR7sztP68RzN1bJqapzkwyzTUnmc7RHJKpLi4TMUW5NpJZnB4jmPmf
        7pFMcUsdYB42eTNNU/9gCc7J6RGpHKvmDL6cVqVTp2k1kZLD7ykPKUPkwdIAaRgKlfhq2Uwu
        UhIdlxDwdlrG5poS32NshmlTSmB5XhJ0IMKgMxk531Qdb4yUcHp1hl6mD+TZTN6k1QRqOaNC
        Ghz8Wshm4kfpqRXtG0Bfl/TJbMctMgdcjCgEFAVpGTw1k10InCgx3Qlg5cIsIZAlAJsbzosE
        sgxgd9t9vBA4blUU/l1BCgErgE1tX2ICycfgeNeAg92XpP3h0AZl193pHBw2dlYDO8FpMwaH
        VodIu5UbHQbXhvMwOybovbBv5ivCjl1oBazN/RkXBgyCJRO7BHkXvPnd1FYKTvvA3B/Lcbsn
        pB9RcMU8TAjjRcOxBwukgN3g7ECLg4A94UObdVvPgpfO1JJCcR6Alt8sQAi8AfMHS7Ya4/R+
        2NARJMhe8JvBq5jQeCcsWp3CBN0FXv/hGX4ZXm44t+2/B46sfL6NGdicWy+yYzGdAtf+WCZK
        gY/luX0sz+1j+b/zOYDXgT2cns/UcHyIXqrlsv67WZUuswlsPXe/2OtgfHIhsAdgFOgBkMIl
        7i42n2W12EXNHs/mDDqlwZTB8T0gZPOMT+OeL6h0m/9Fa1RKZWHBMrlcLgt7XS6V7HaZy69Q
        i2kNa+TSOU7PGZ7VYZSjZw529uT8r+cvLywmWoOy/EImP/vQuaw6tgdknlgpKo4/mP2kwGir
        cf3Yu+DomnVpKFQjumAuuHLwJTfzPlUiWyM/HVEfuzMhoFadpEjuWsm6Fl8ae7xgxOdbZbuz
        Thx+YvHd+/4Of02nsOIzg27x75uHJoY3PCpi+voVMSncTE4SHxpPla5Whof/EnnkyR2vG46q
        6kc7LGWd/ZNHP51X5p06oDhm6n2wGFjuGqR8p8rD445rnLWlxf0wHNbF7YhCybKJVzvDvFVP
        6VPyxr0xomZ84wgl74+6UrmiqCrvXz+rKR/jh53Wbd6v+O/2J6NHTeYP3vL2Gl3tbUtt1Cdm
        v8mxsRKCT2WlfriBZ/8FE26oRHcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvO6/1T9SDF6vl7RYf+oYs8Xqu/1s
        Fq8Pf2K0eHKgndFi77vZrBY3D+xksli5+iiTxaRD1xgtnl6dxWSx95a2xcK2JSwWe/aeZLG4
        vGsOm8X8ZU/ZLZYf/8dkcWPCU0aLbb/nM1use/2exeLELWmL83+PszqIeJy/t5HF4/LZUo9N
        qzrZPDYvqffYfbOBzWNx32RWj97md2weH5/eYvF4v+8qm0ffllWMHp83yXlsevKWKYAnissm
        JTUnsyy1SN8ugStj7s7/jAWrgipe7TrL1sC43KaLkZNDQsBEouvNXLYuRi4OIYHdjBLfn21l
        g0hISiz7e4QZwhaWWPnvOTtEUTOTxPXLh1i6GDk42AS0JU7/5wCJiwh0MUt07nzHAuIwC0xm
        klh1fikLSLewgKXEnzMtTCA2i4CqxNEXPWBxXgEriRXN55hBBkkI6Ev03xeECAtKnJz5BGw+
        s4C6xPp5QiBhZgF5ieats5knMPLPQlI1C6FqFpKqBYzMqxglUwuKc9Nziw0LDPNSy/WKE3OL
        S/PS9ZLzczcxgmNSS3MH4/ZVH/QOMTJxMB5ilOBgVhLhfSf/LUWINyWxsiq1KD++qDQntfgQ
        ozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QD02KvTYkdLz0+3HLKc5b5bvn4HfPHa9q/
        vmw3Zy02ESlxSHaT/rhtGpejuf2zyVGiihL+Owy+GRctipDxC9Dok70c/fIM8+nWh7sZJD9M
        uXeuPueqRKfzssxvb8t7GhmCOJXC6rUvnb4XIrJoL+uaP8ef9S0T2Fu/rkh2l4I9r/Guu2mP
        3RaErC258+8hj/KzzisblLSZn6ueFNP8n3FT+0zAjMu/rjerTO/ruSC2z2Xp9t+Z52ROX0jX
        zW/iYJ5oYKbfEnhnilPXkj8NC3YGiJVcPqaUV5ob5FGWGO3PfKMubfqN+O6HPYURslNW703q
        STl2dnHYlqX6T/dzb4tMC5FpUrjX0Ch19MK+fQ0blViKMxINtZiLihMBZbTIFTgDAAA=
X-CMS-MailID: 20230906164238epcas5p4a511a029fb8ae8bbc36b750712ad64d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164238epcas5p4a511a029fb8ae8bbc36b750712ad64d5
References: <CGME20230906164238epcas5p4a511a029fb8ae8bbc36b750712ad64d5@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
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

This is next iteration of our previous patch set v14[1].
Copy offload is performed using two bio's -
1. Take a plug
2. The first bio containing source info is prepared and sent,
        a request is formed.
3. This is followed by preparing and sending the second bio containing the
        destination info.
4. This bio is merged with the request containing the source info.
5. The plug is released, and the request containing source and destination
        bio's is sent to the driver.

So copy offload works only for request based storage drivers.
For failures, partial completion, absence of copy offload capability,
we can fallback to copy emulation.

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
	[1] https://lore.kernel.org/lkml/20230811105300.15889-1-nj.shetty@samsung.com/T/#t
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v15
	[4] https://github.com/OpenMPDK/fio/tree/copyoffload-3.35-v14

Changes since v14:
=================
        - block: (Bart Van Assche)
            1. BLK_ prefix addition to COPY_MAX_BYES and COPY_MAX_SEGMENTS
            2. Improved function,patch,cover-letter description
            3. Simplified refcount updating.
        - null-blk, nvme:
            4. static warning fixes (kernel test robot)

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

Nitesh Shetty (11):
  block: Introduce queue limits and sysfs for copy-offload support
  Add infrastructure for copy offload in block and request layer.
  block: add copy offload support
  block: add emulation for copy
  fs, block: copy_file_range for def_blk_ops for direct block device
  nvme: add copy offload support
  nvmet: add copy command support for bdev and file ns
  dm: Add support for copy offload
  dm: Enable copy offload for dm-linear target
  null: Enable trace capability for null block
  null_blk: add support for copy offload

 Documentation/ABI/stable/sysfs-block |  23 ++
 Documentation/block/null_blk.rst     |   5 +
 block/blk-core.c                     |   7 +
 block/blk-lib.c                      | 425 +++++++++++++++++++++++++++
 block/blk-merge.c                    |  41 +++
 block/blk-settings.c                 |  24 ++
 block/blk-sysfs.c                    |  36 +++
 block/blk.h                          |  16 +
 block/elevator.h                     |   1 +
 block/fops.c                         |  25 ++
 drivers/block/null_blk/Makefile      |   2 -
 drivers/block/null_blk/main.c        | 100 ++++++-
 drivers/block/null_blk/null_blk.h    |   1 +
 drivers/block/null_blk/trace.h       |  25 ++
 drivers/block/null_blk/zoned.c       |   1 -
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  37 +++
 drivers/md/dm.c                      |   7 +
 drivers/nvme/host/constants.c        |   1 +
 drivers/nvme/host/core.c             |  79 +++++
 drivers/nvme/host/trace.c            |  19 ++
 drivers/nvme/target/admin-cmd.c      |   9 +-
 drivers/nvme/target/io-cmd-bdev.c    |  97 ++++++
 drivers/nvme/target/io-cmd-file.c    |  50 ++++
 drivers/nvme/target/nvmet.h          |   4 +
 drivers/nvme/target/trace.c          |  19 ++
 fs/read_write.c                      |   8 +-
 include/linux/bio.h                  |   6 +-
 include/linux/blk_types.h            |  10 +
 include/linux/blkdev.h               |  22 ++
 include/linux/device-mapper.h        |   3 +
 include/linux/nvme.h                 |  43 ++-
 32 files changed, 1128 insertions(+), 19 deletions(-)


base-commit: c50216cfa084d5eb67dc10e646a3283da1595bb6
-- 
2.35.1.500.gb896f729e2

