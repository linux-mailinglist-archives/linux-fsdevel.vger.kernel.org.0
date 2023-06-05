Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB60B7225AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjFEM3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjFEM3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:29:34 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F5C7
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 05:29:29 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230605122926epoutp0462b64e11fac1530d3900083451bea6e4~lwx1dOyY01858418584epoutp04Z
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 12:29:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230605122926epoutp0462b64e11fac1530d3900083451bea6e4~lwx1dOyY01858418584epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685968166;
        bh=DoUEAqe1yQ36nUN40RVM794Z0eUVw76yl9n5nHXcc/s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ox1lzTSkJz2i+4eqf8ygM+iI13GOhg9szjqLdBadEomKvRdFNa1wiwdKIMHvIgCUE
         FaH3L87g295BXrTSDVk60alvIk2bNnzyoBnItxKZ5TKEv+rCYarQio9Fd4iQJoNIvX
         a7v+bhBGuI6V5i/PEfQ7rl1QhWhm9ORo0nPDzBws=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230605122924epcas5p4e0706c5693c0428bba8fe46ad5d3ca07~lwxziZGZ10962809628epcas5p4L;
        Mon,  5 Jun 2023 12:29:24 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QZXwg1FLjz4x9Pt; Mon,  5 Jun
        2023 12:29:23 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.39.04567.225DD746; Mon,  5 Jun 2023 21:29:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230605122104epcas5p4ef1775cd4a218faa7b2459d58f63c275~lwqiBvTQO0129301293epcas5p4J;
        Mon,  5 Jun 2023 12:21:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230605122104epsmtrp252e8901f56c30f032f62022cc55327fd~lwqh-pRnh0879508795epsmtrp2m;
        Mon,  5 Jun 2023 12:21:04 +0000 (GMT)
X-AuditID: b6c32a49-db3fe700000011d7-41-647dd5221551
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.A5.28392.033DD746; Mon,  5 Jun 2023 21:21:04 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122053epsmtip2de69ac47f6ed3893c374220d0bc0a308~lwqYGS53D2526625266epsmtip2T;
        Mon,  5 Jun 2023 12:20:52 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 0/9] Implement copy offload support
Date:   Mon,  5 Jun 2023 17:47:16 +0530
Message-Id: <20230605121732.28468-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH/d3b3hal5rbI/FFlYAnZwPDoVsoPAlMnkKuAYZsxm9OxSu+A
        UErXB0zJEMYYAaWAL2YhKo/Ia5HJ+yEP242nhAUsBBamg6LbdDwkG2I3N8rFzf++53PO+X1z
        zi+Hiwu+5gi58UotrVbKFCJiM6vZ5OHp5Wb+XO7b9xigusFeHNVO5xPokekJQJcWV3Fk6ckG
        aMyyFd3v3oM654vZaLKnDUO3ys5hqLr2ewx1lC5h6JxxHKA5swFDnVO7UelXFSx0q3OAhcba
        Swh09focB52ZaCVQZd9zDBnPZ2Ko1ZIBULP1Ko5uPFpgof6pHWjk7z42sj4tIfbupMbuhlOG
        e8ME1WaY5lAjP91kUQ1VntTYsI6qr8khqIaK01THZDpBlevPs6m8zHmCWpqbYlELXWaC0jfW
        AKphKJVarn81in80ISiOlslptSutjEmSxytjg0Xh70Xvj/aT+oq9xAHIX+SqlCXSwaKQiCiv
        sHjF2nZErskyhW4NRck0GpHPW0HqJJ2Wdo1L0miDRbRKrlBJVN4aWaJGp4z1VtLaQLGv7xt+
        a4UfJ8TNVloIlfngZ99+F5AOZqS5wI4LSQlsHtJzcsFmroDsADC3r5BtSwjIJwAuVToziWUA
        /5isI3IBd72jqyGS4e0Alv5lZjNBFgYLS60cWxFB7oZD/3BtfBtZhcOMlTssW4CTFTisfry4
        buFA+sPVhzPA1sAi3WFO9gc2zCMDYd9gE4cx84H59/gM5sOByxaWTeOkC8xsKsZtT0LSZAeH
        L6WzmXFCYLHpOsFoB/hbXyOH0UK4PN+5wVNg9YUqgmn+EkDDhAEwiT0wazAftxnjpAesa/dh
        sDO8OHgDY4y3wjyrBWM4D7ZeeaHd4Dd11zbed4LjKxkbmoIm4wWC2ehxqL8yRRQAF8NL8xhe
        msfwv/M1gNcAJ1qlSYylNX4qsZJO+e9bY5IS68H6iXgeaAXT9xe9jQDjAiOAXFy0jdd+MFUu
        4MllJ0/R6qRotU5Ba4zAb23FhbjQMSZp7caU2mixJMBXIpVKJQFvSsWi7bzXggdiBGSsTEsn
        0LSKVr/ow7h2wnQsfJe0dSm6Vx/hrjo+k9LzrMTSuyhUn/Vv/qEn4vVl1/Aif+lsd7ni5HPH
        s/ItSqch502j4/mCoJaWtLyJMacc+ukpv37deERmb53BQgV6jgpzrZSMn53JfjebPR95UZ8S
        un9LdXoTryxs6UNpyG37I2mrOnLuxOHYxmeVIx6T3fWR/GOCm2lfSLYPJz8MO/R7fOg+n4Kf
        /9xxOfmByORQK977406FdWnTr5/kxO1r/uXIg7Ku04cCglvoGmvFnFOPe/FK1tFh5R2fhdCA
        d1o7Gj5yLv+0eEoiDRw90BYJ3ALzHI/ZuzgWpd4tD337/dkivn3/oMkc9srh5QLixG2QWqXc
        JWJp4mRiT1ytkf0LW7rOTKsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCSvK7B5doUg20dghbrTx1jtlh9t5/N
        4vXhT4wW0z78ZLZ4cqCd0eLyEz6LB/vtLfa+m81qcfPATiaLPYsmMVmsXH2UyWL3wo9MFpMO
        XWO0eHp1FpPF3lvaFgvblrBY7Nl7ksXi8q45bBbzlz1lt+i+voPNYvnxf0wWhyY3M1nseNLI
        aLHt93xmi3Wv37NYnLglbXH+73FWi98/5rA5yHhcvuLtMev+WTaPnbPusnucv7eRxWPzCi2P
        y2dLPTat6mTz2Lyk3mP3zQY2j8V9k1k9epvfsXl8fHqLxeP9vqtsHn1bVjF6bD5d7fF5k1yA
        YBSXTUpqTmZZapG+XQJXxuPlT9gKrnpVbDhi2cD4yKyLkYNDQsBEYt9m3y5GTg4hgR2MEu/O
        RIDYEgKSEsv+HmGGsIUlVv57zt7FyAVU08wksePmXCaQXjYBbYnT/zlA4iICW5glzv6azAri
        MAtsY5b48OELO0i3sIC5xM/njxhBGlgEVCU62yNBwrwCVhLHT21lh7hBX6L/viBEWFDi5Mwn
        LCBhZgF1ifXzhEDCzALyEs1bZzNPYOSfhaRqFkLVLCRVCxiZVzFKphYU56bnFhsWGOWllusV
        J+YWl+al6yXn525iBEe+ltYOxj2rPugdYmTiYDzEKMHBrCTCu8urOkWINyWxsiq1KD++qDQn
        tfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpvguiZK4GbO0Gg6u/buu8nSiZEND
        82S1iXuiVk/gyHzdWWLvmb/z2PYmfcM9Lq5mkw/fW6F5riVy4tGWw1nT3/ocm3220pDvvtMD
        m786tQceTnv2KrZHJqGE8Z/sW9Hs/4f3+X+1vh73KKZEn936Q2YvK9/hlRF6erM60t+pehae
        nrVFIznzjvsazfXznF2O/1r+6z4H5wm5bfLRQkbHnvzUO+I1bYLn+5+/bL2ZdnxJ6matymE/
        ONXUc9bEsq07H61oOebrcZSJJ+qsWsv7D5PlJ25fa++dyTJB/ZSomXXYgXftP1w/lvOlCMtJ
        PJgu7fLbSMksZ8c1V6YV7k9Ul8QYMCw1yv/x54V4mPWeMiWW4oxEQy3mouJEAPt5DixrAwAA
X-CMS-MailID: 20230605122104epcas5p4ef1775cd4a218faa7b2459d58f63c275
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605122104epcas5p4ef1775cd4a218faa7b2459d58f63c275
References: <CGME20230605122104epcas5p4ef1775cd4a218faa7b2459d58f63c275@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch series covers the points discussed in past and most recently
in LSFMM'23[0].
We have covered the initial agreed requirements in this patchset and
further additional features suggested by community.
Patchset borrows Mikulas's token based approach for 2 bdev implementation.

This is next iteration of our previous patchset v11[1].

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
        c. NVMe Fabrics loopback.
	d. blktests[3] (tests block/034-037, nvme/050-053)

	Emulation can be tested on any device.

	fio[4].

Infra and plumbing:
===================
        We populate copy_file_range callback in def_blk_fops. 
        For devices that support copy-offload, use blkdev_copy_offload to
        achieve in-device copy.
        However for cases, where device doesn't support offload,
        fallback to generic_copy_file_range.
        For in-kernel users (like NVMe fabrics), we use blkdev_issue_copy
        which implements its own emulation, as fd is not available.
        Modify checks in generic_copy_file_range to support block-device.

Performance:
============
        The major benefit of this copy-offload/emulation framework is
        observed in fabrics setup, for copy workloads across the network.
        The host will send offload command over the network and actual copy
        can be achieved using emulation on the target.
        This results in higher performance and lower network consumption,
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
	tests/block/034,035: Runs copy offload and emulation on block
                              device.
	tests/block/035,036: Runs copy offload and emulation on null
                              block device.
        tests/nvme/050-053: Create a loop backed fabrics device and
                              run copy offload and emulation.

Future Work
===========
	- loopback device copy offload support
	- upstream fio to use copy offload
	- upstream blktest to test copy offload

	These are to be taken up after this minimal series is agreed upon.

Additional links:
=================
	[0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=zT14mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
            https://lore.kernel.org/linux-nvme/f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com/
            https://lore.kernel.org/linux-nvme/20230113094648.15614-1-nj.shetty@samsung.com/
	[1] https://lore.kernel.org/all/20230522104146.2856-1-nj.shetty@samsung.com/
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v12
	[4] https://github.com/vincentkfu/fio/tree/copyoffload-3.35-v12

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

 Documentation/ABI/stable/sysfs-block |  33 ++
 Documentation/block/null_blk.rst     |   5 +
 block/blk-lib.c                      | 445 +++++++++++++++++++++++++++
 block/blk-map.c                      |   4 +-
 block/blk-settings.c                 |  24 ++
 block/blk-sysfs.c                    |  63 ++++
 block/blk.h                          |   2 +
 block/fops.c                         |  20 ++
 drivers/block/null_blk/main.c        | 108 ++++++-
 drivers/block/null_blk/null_blk.h    |   8 +
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  41 +++
 drivers/md/dm.c                      |   7 +
 drivers/nvme/host/constants.c        |   1 +
 drivers/nvme/host/core.c             | 103 ++++++-
 drivers/nvme/host/fc.c               |   5 +
 drivers/nvme/host/nvme.h             |   7 +
 drivers/nvme/host/pci.c              |  27 +-
 drivers/nvme/host/rdma.c             |   7 +
 drivers/nvme/host/tcp.c              |  16 +
 drivers/nvme/host/trace.c            |  19 ++
 drivers/nvme/target/admin-cmd.c      |   9 +-
 drivers/nvme/target/io-cmd-bdev.c    |  62 ++++
 drivers/nvme/target/io-cmd-file.c    |  52 ++++
 drivers/nvme/target/loop.c           |   6 +
 drivers/nvme/target/nvmet.h          |   1 +
 fs/read_write.c                      |   7 +-
 include/linux/blk_types.h            |  25 ++
 include/linux/blkdev.h               |  23 ++
 include/linux/device-mapper.h        |   5 +
 include/linux/nvme.h                 |  43 ++-
 include/uapi/linux/fs.h              |   6 +
 32 files changed, 1166 insertions(+), 19 deletions(-)


base-commit: 9ca10bfb8aa8fbf19ee22e702c8cf9b66ea73a54
-- 
2.35.1.500.gb896f729e2

