Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A96DD504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 10:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDKITA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDKIS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:18:58 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46679358E
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 01:18:55 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230411081852epoutp0446a41d7813236814a226de0d1f406f73~U04XaP5pB0087900879epoutp04P
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 08:18:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230411081852epoutp0446a41d7813236814a226de0d1f406f73~U04XaP5pB0087900879epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681201132;
        bh=lzlbEt5NUuJrajM7hxIoS1+C6M/6om5LOjHtQ7gXExA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MflhiCl5JI6smyx2AGy+IpNe+ffESCUt2fGGTZqqmCLG6LpNDVqf5BKQoE7dIRlV/
         deM5nOAIBQYX68nObt8O51Xo7pwEDagpLHWLi7f4xqzn64DJVsusq0gC0S4RBb4mrQ
         qA0T4o0JbKV7rzQzr3PM9mZKO7mMh70/k7agETPE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230411081851epcas5p20b5ce2e2d2f4891184e56b2c24553e70~U04WjkooC1969019690epcas5p2X;
        Tue, 11 Apr 2023 08:18:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Pwdyx5lWwz4x9Q9; Tue, 11 Apr
        2023 08:18:49 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.0F.09540.9E715346; Tue, 11 Apr 2023 17:18:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230411081134epcas5p317f673eea473cea463be97b41dbfb09c~U0x-nMR930552605526epcas5p30;
        Tue, 11 Apr 2023 08:11:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230411081134epsmtrp2cd5cd22d10473f43293c4b7aceddcbf4~U0x-l7r7f2456424564epsmtrp2Y;
        Tue, 11 Apr 2023 08:11:34 +0000 (GMT)
X-AuditID: b6c32a4a-4afff70000002544-ca-643517e9c7e9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.EE.08279.63615346; Tue, 11 Apr 2023 17:11:34 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230411081131epsmtip29e754e2ca2350d358d77a815aa6bf35f~U0x8ea1z12247222472epsmtip2y;
        Tue, 11 Apr 2023 08:11:31 +0000 (GMT)
From:   Anuj Gupta <anuj20.g@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        dlemoal@kernel.org, anuj20.g@samsung.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v9 0/9] Implement copy offload support
Date:   Tue, 11 Apr 2023 13:40:27 +0530
Message-Id: <20230411081041.5328-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TaVBTVxTHve8lj+BM7GNpvaVQMm+gCGVJIImXyma1nddSKyNip4ulGfKG
        MECS5gWx+AEwohVMA7TWITiyjK0jVG3ZymIshSKLA3ZAUHZwgh1lFZVKFWnggfrtd849/3uW
        e48Ad1wiXAQJaj2jUyuSKGIjr6bZ28fv7maZUmw46YsudVzF0eHcJRyVD5sINNk8D9CPc4s4
        GvsjHFlmCvmov7EOQ5dL8zF0vrwFQw0l9zHUsjxNoPymPoAmes0Ysgy8jS5b2nmop/40gYp+
        nrBDTd8bMFRrzQSo5kkRji5OzvJQ28Ab6PpSKz8C0j03ImnzaCdB15mH7ejrI7/x6J7OFLqi
        7DhBV55Npxv6MwjaaJgh6NkrvQT9XVUZoCuvHaIfVLxJV1insahNnyWGqBiFktGJGHWcRpmg
        jg+lIqNjd8TK5GKJnyQYbaVEakUyE0rt/CjK7/2EJNsEKNEBRVKKzRWlYFkqICxEp0nRMyKV
        htWHUoxWmaSVav1ZRTKboo73VzP6dyRicaDMFvhVoso0mK6t2X4wr29PBigWZwN7ASSl0Dy0
        RGSDjQJHsgHAqtFaO86YB7D7dj2PMxYArLj1mFiXZC82r0ksAF7IbMQ5w4DB+v8y+StRBOkF
        //onC6wcOJNHcXh/4vjqXTjZjcGnVbP4SpQTKYd3+46sKnikJxxuXeCtsJBEcOTfXptaYMsX
        AE2jDpzbAbYXWFdDcNIdGqoLca6kU/Ywd+pTjnfCtoU2PsdO8F5rlR3HLvDBjGWthXj4uGcC
        41gLDVevAI7DYVaHCV9Ji5Pe8FJ9AOd2gyc7LmJc2k3Q+MS6JhXC2jPrTMFj50+vMYSWrow1
        pqE1p2C1ZEdyP3y2WMfPBe7ml7oxv9SN+UXmYoCXgdcZLZscz7AybaCaSX3+rnGa5Aqwugc+
        H9aC8bE5/yaACUATgAKcchY+Wg5SOgqVim/SGJ0mVpeSxLBNQGabcB7u8mqcxrZIan2sRBos
        lsrlcmlwkFxCbRZ6hbbHOZLxCj2TyDBaRreuwwT2LhlY1USJq/Ops5+Q/d1B2w7gIjrV59f0
        rx8VexcGduvvuGUNdg8VK0s8u4zbJqei+jwebjm2odx5fNT/0I5Gr3cT3buKFh++t5h6zVjt
        Xk2MZBtuMh9Ydw12uJX4e+ZEOKuo/Gi4bExTlfDDIjvr9378Cp4w5eEQI0vPmn/qm+VqYgUN
        xAxVd7u0aHjr2K6/ZWm/bBFuyN/N2D53VPSck+zI9Bci0jqNt1VKmbDDMZ8nhNz0GiqdbY/9
        dtw3Y+yHFvf2P5vPFQYQd5IL2LFnza77Bxo9z7nmnSjYZ9yzPNmYl/Nl6fTvb4W+9tO+gex7
        tzwOhszcSBX7SgePbo8gLpyJ2b03nOKxKoXEB9exiv8BHgG6AZAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSvK6ZmGmKwffrOhbrTx1jtmia8JfZ
        YvXdfjaL14c/MVpM+/CT2eLBfnuLve9ms1rcPLCTyWLPoklMFitXH2Wy2L3wI5PF0f9v2Swm
        HbrGaPH06iwmi723tC327D3JYnF51xw2i/nLnrJbHJrczGSx40kjo8W23/OZLda9fs9iceKW
        tMX5v8dZHSQ8Ll/x9ph1/yybx85Zd9k9zt/byOJx+Wypx6ZVnWwem5fUe+y+2cDm0dv8js3j
        /b6rbB59W1Yxemw+Xe3xeZOcx6Ynb5kC+KK4bFJSczLLUov07RK4Mvpv1xdsc6yYeC2ogXGB
        QRcjJ4eEgIlE18/DbF2MXBxCArsZJR6fWMcGkZCQOPVyGSOELSyx8t9zdoiiRiaJp5seMoEk
        2ATUJY48b2UESYgITGCWuHS/AWwUs8ADJonzz7+wglQJC5hJvLzWAmazCKhK3D3+jQXE5hWw
        kLj3/SpQNwfQCn2J/vuCEGFBiZMzn7CAhJmBFqyfJwQSZhaQl2jeOpt5AiP/LCRVsxCqZiGp
        WsDIvIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIziOtTR3MG5f9UHvECMTB+MhRgkO
        ZiUR3q//jVOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRq
        YFKbWvLgz0d1h3N3WcJjOv03B3Q2ire+ky5kvzlVSFBBSc9SuOrCh759anUeMyQmXGxMPrLl
        X5JTkokS74m1twONumfuOXRDi/lE4wYrHjF7Q/Us0ffPHY1USlI+ZTTvyteacHBJS6kXg8Z2
        /bV22t0P22dvuqRhOaN65f5iTo/5ixbJJPH83s1e9UpSaS1rHMexWxU1nOeaZpa3Pyj/nLoq
        2q3j4T4/wek9Dsume96Wf+5cLmA2cYPUuesrWv++Y1il+rbhGPfiQ0wnf85vctjXoiYeb/wj
        4pDAG1VzWaPeRVtXOrU5l5UtufzsJotM3/V1MZ5tRqYxk4y1fc2Yzq7rrLrTXruhp3OZSUmY
        EktxRqKhFnNRcSIAJB4DQVIDAAA=
X-CMS-MailID: 20230411081134epcas5p317f673eea473cea463be97b41dbfb09c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230411081134epcas5p317f673eea473cea463be97b41dbfb09c
References: <CGME20230411081134epcas5p317f673eea473cea463be97b41dbfb09c@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

The patch series covers the points discussed in November 2021 virtual
call [LSF/MM/BFP TOPIC] Storage: Copy Offload [0].
We have covered the initial agreed requirements in this patchset and
further additional features suggested by community.
Patchset borrows Mikulas's token based approach for 2 bdev
implementation.

This is on top of our previous patchset v8[1].

Overall series supports:
========================
	1. Driver
		- NVMe Copy command (single NS, TP 4065), including support
		in nvme-target (for block and file backend).

	2. Block layer
		- Block-generic copy (REQ_COPY flag), with interface
		accommodating two block-devs
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
        c. Fabrics loopback.
	d. blktests[3] (tests block/032,033, nvme/046,047,048,049)

	Emulation can be tested on any device.

	fio[4].

Infra and plumbing:
===================
        We populate copy_file_range callback in def_blk_fops. 
        For devices that support copy-offload, use blkdev_copy_offload to
        achieve in-device copy.
        However for cases, where device doesn't support offload,
        fallback to generic_copy_file_range.
        For in-kernel users (like fabrics), we use blkdev_issue_copy
        which implements its own emulation, as fd is not available.
        Modify checks in generic_copy_file_range to support block-device.

Performance:
============
        The major benefit of this copy-offload/emulation framework is
        observed in fabrics setup, for copy workloads across the network.
        The host will send offload command over the network and actual copy
        can be achieved using emulation on the target.
        This results in better performance and network utilisation,
        as compared to read and write travelling across the network.
        With async-design of copy-offload/emulation we are able to see the
        following improvements as compared to userspace read + write on a
        NVMeOF TCP setup:

        Setup1: Network Speed: 1000Mb/s
        Host PC: Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz
        Target PC: AMD Ryzen 9 5900X 12-Core Processor
        block size 8k:
        710% improvement in IO BW (108 MiB/s to 876 MiB/s).
        Network utilisation drops from  97% to 15%.
        block-size 1M:
        2532% improvement in IO BW (101 MiB/s to 2659 MiB/s).
        Network utilisation drops from 89% to 0.62%.

        Setup2: Network Speed: 100Gb/s
        Server: Intel(R) Xeon(R) Gold 6240 CPU @ 2.60GHz, 72 cores
        (host and target have the same configuration)
        block-size 8k:
        17.5% improvement in IO BW (794 MiB/s to 933 MiB/s).
        Network utilisation drops from  6.75% to 0.16%.

Blktests[3]
======================
	tests/block/032,033: Runs copy offload and emulation on block device.
        tests/nvme/046,047,048,049 Create a loop backed fabrics device and
        run copy offload and emulation.

Future Work
===========
	- loopback device copy offload support
	- upstream fio to use copy offload

	These are to be taken up after we reach consensus on the
	plumbing of current elements that are part of this series.


Additional links:
=================
	[0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=zT14mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
	[1] https://lore.kernel.org/lkml/20230327084103.21601-1-anuj20.g@samsung.com/T/
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v7
	[4] https://github.com/vincentkfu/fio/commits/copyoffload-cfr-3.34-dev

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

Nitesh Shetty (9):
  block: Introduce queue limits for copy-offload support
  block: Add copy offload support infrastructure
  block: add emulation for copy
  fs, block: copy_file_range for def_blk_ops for direct block device
  nvme: add copy offload support
  nvmet: add copy command support for bdev and file ns
  dm: Add support for copy offload
  dm: Enable copy offload for dm-linear target
  null_blk: add support for copy offload

 Documentation/ABI/stable/sysfs-block |  33 +++
 block/blk-lib.c                      | 416 +++++++++++++++++++++++++++
 block/blk-map.c                      |   4 +-
 block/blk-settings.c                 |  24 ++
 block/blk-sysfs.c                    |  64 +++++
 block/blk.h                          |   2 +
 block/fops.c                         |  20 ++
 drivers/block/null_blk/main.c        | 101 +++++++
 drivers/block/null_blk/null_blk.h    |   8 +
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  41 +++
 drivers/md/dm.c                      |   7 +
 drivers/nvme/host/constants.c        |   1 +
 drivers/nvme/host/core.c             | 106 ++++++-
 drivers/nvme/host/fc.c               |   5 +
 drivers/nvme/host/nvme.h             |   7 +
 drivers/nvme/host/pci.c              |  27 +-
 drivers/nvme/host/rdma.c             |   7 +
 drivers/nvme/host/tcp.c              |  16 ++
 drivers/nvme/host/trace.c            |  19 ++
 drivers/nvme/target/admin-cmd.c      |   9 +-
 drivers/nvme/target/io-cmd-bdev.c    |  58 ++++
 drivers/nvme/target/io-cmd-file.c    |  52 ++++
 drivers/nvme/target/loop.c           |   6 +
 drivers/nvme/target/nvmet.h          |   1 +
 fs/read_write.c                      |  11 +-
 include/linux/blk_types.h            |  25 ++
 include/linux/blkdev.h               |  21 ++
 include/linux/device-mapper.h        |   5 +
 include/linux/nvme.h                 |  43 ++-
 include/uapi/linux/fs.h              |   3 +
 31 files changed, 1129 insertions(+), 14 deletions(-)


base-commit: e134c93f788fb93fd6a3ec3af9af850a2048c7e6
-- 
2.35.1.500.gb896f729e2

