Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F369CB4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 13:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjBTMsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 07:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBTMsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:48:22 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899796195
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:48:08 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230220124805epoutp047c0dc228864b7be15428b1793305cb40~FiTJw05lg2212822128epoutp04T
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:48:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230220124805epoutp047c0dc228864b7be15428b1793305cb40~FiTJw05lg2212822128epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676897286;
        bh=TA1po4dmHSG0OpaQURXypV1AF1U5/IyYzRr146C8W2U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Ls4rzzoc9gdR5YV04k6RQhY4ZBkM0ULJmcPVLZVImXWeLEo6CbVQZ+8RMyO8x4Jd8
         MfstZW4ckXZ+0XMAt37kz0e8SbkIhrbXBkZAaJd04zj02eh9e8uIaBE+GboSM+F2Hu
         UPuMwnMLVCHs3YOGmNIXzz19Biwj72e844QyWUvs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230220124805epcas5p278212317737506b11d7ee38042f3743a~FiTJLjW0-3203132031epcas5p2v;
        Mon, 20 Feb 2023 12:48:05 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PL2Jg4XVgz4x9Pq; Mon, 20 Feb
        2023 12:48:03 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.39.06765.30C63F36; Mon, 20 Feb 2023 21:48:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230220105423epcas5p4618b6fa4fadde27086180841be87638b~Fgv3yLYns2275622756epcas5p4R;
        Mon, 20 Feb 2023 10:54:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230220105423epsmtrp165387f207e5da13ac0914dde680635aa~Fgv3w_xT62429224292epsmtrp1G;
        Mon, 20 Feb 2023 10:54:23 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-78-63f36c03165f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.F9.17995.F5153F36; Mon, 20 Feb 2023 19:54:23 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220105417epsmtip240792bb4071dc760fc5f37d77d2b4940~FgvyWnRW60747407474epsmtip2s;
        Mon, 20 Feb 2023 10:54:17 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 0/8] Implement copy offload support
Date:   Mon, 20 Feb 2023 16:23:23 +0530
Message-Id: <20230220105336.3810-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xbVRTH895rXwum861j2QXF1ZI5AYFWoNwKOM0IeQmbwx9oHJr6bJ/Q
        Udqmrx1FZgTKL2uwDGHLihtDFuZAQVjZKNCxVJEBYXVjsDBEyACTjYwfw7gRAthHme6/z/3e
        c873nnNz+JhwDQ/iq7VG2qClNGLcn3Ppl9C9EZhmWSl5fEoEWwZ+w2BhxRoGmyZsODyxuILB
        1SEPBl3zNVw4dtWJwu7vK1F4oakXhV11Syjs3XiAw0r3KAJnR+wodN0Jh92ufg4c7vwOh7UN
        szzo/taCwo6ZAgReWq3FYPPcAgdeu/Mc9Kz1cd/YRQ7fSiHtk0M46bRP8EjPn60ccnjIRLY1
        foWTF899SXaN5eNkuWXeG1A8ySUXrozg5DeORoS8OJhHLre9QLbNPEBTnz2clZBJUyraIKK1
        Sp1Krc1IFKe8q9iviJVJpBFSOYwTi7RUNp0oTjqQGpGs1nhHIBYdpTQmr5RKMYw46vUEg85k
        pEWZOsaYKKb1Ko0+Rh/JUNmMSZsRqaWNr0klkldjvYGfZGX2VDWhele82VHq5OQjC+FWxI8P
        iBgwfbwKY1lIdCFgbnC/FfH38kMEDCxN4L7DMgI6u25xrAh/M8N6TevTOxFQt8BmswcLCpZs
        D7lsEE6Eg8ENPls1gPgDBc7BEDYGI6ZQUFt4DmEvdhAyUFxewmWZQ+wBjX9/vakLCDlYu3wW
        95lFAdvkdp+8HfSfmuGwjBG7gaW9ZtMXEDV+wHrlJs/XThI4P+dCfbwD3O9zbOlB4J6tZItz
        wIWqH3BfchEC7LftiO9iHygesGGsMUaEgpbOKJ8cDKoHmlGf8TZQvjqzVV8AOs484RDwYwv7
        ZpYDweijgi0mQaWjaHNwQuJjUDZOVSC77U+1Y3+qHfv/xmcRrBEJpPVMdgbNxOqjtXTOf9+q
        1GW3IZt7EJbSgdydWox0IygfcSOAj4kDBBuCZaVQoKJyP6cNOoXBpKEZNxLrHfFxLGinUudd
        JK1RIY2RS2JkMlmMPFomFe8S7E3sVwqJDMpIZ9G0njY8yUP5fkH56Hh8dNDBWkfcWz0fToff
        bpLnmo9gA69wHR+NOtfV3dLZ7pKT2GeUXjEyL5jhSY+d6alo7eY1m0LSFsfn84v+qjj263pe
        WeUhUqm3h7551Fnvcb7nvmn2z27xmOvr0gMjpwtEDe0JK3iSzWoLlr9kKLZG5uzMnzgfkFQ4
        VP/PeNzduLHmnILaly1565749W19vJDWn3JTC1UfjFQ77gffe/7y4RtXh9RGVbjEsnhyz/in
        P8+XMlET+0aEfDPH9MXbZWlhUyeSewl1ysqR9vSM0+mS69XX17mPO0yPnlmZfD+5nf+75kaA
        Iq0iBT1gNpX2S19MSDQ2iJjJg5VlBWJX2ztiDpNJScMwA0P9C1NXm8OQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RbUxSYRTH99zner3RyCu9PeCWG9UqLXqdPa3SXK3ueln6oZf1xZjcqUuI
        QC2zkmLZohc1Wy5sWmQ0kV4kI0gloqzUkS3NpWXM0qyVYlGuVLSItfr2P7/zO2dnOzQUOEkR
        nabI4FQKabqY4pHWB+LIeUmJvuQF333h+EbjI4iPFPghruzMp/C5gZ8QD7ubIa7rLwnB7U47
        gWsNZwhcUVlP4JpLXwhcP9ZH4TOuNoB7XugJXNcRjWvrGkjccvcChcuMPaHYVaQlsK37MMDW
        4TKIr3/ykvhJRwRu9j8OWTWVbWndwOo9boq16ztD2eY3VSTb4s5kLabjFHurPJetaddQ7Clt
        /2/hqCeE9TpeUOzpahNgbzXlsD7LNNbS3UckhO3grZBx6WlZnGp+7E5e6r2zlYSybvm+6mN2
        UgO80TpA04hZgnRPFDrAowWMDaBjpXkhOjDuNxcio/8hDOaJqGK0NzQoHSbQJYuDCAxTTDRq
        GqMDfBLznkDuN29hoIBMP4FMXcY/myYyMejoqeBWkpmJTN9OgEDmM8uQ/85FKnjFfJTvCQ/i
        cNRwvpsMYMjMQjdKBQEMmUikvV0CC0CY/j9L/8/S/2ddBNAEhJxSLU+RqxcqFym4vRK1VK7O
        VKRIknfLLeDPk6OibKDWNCBxAYIGLoBoKJ7EH+P7kgV8mTR7P6fanaTKTOfULhBBk+Kp/Ge6
        hiQBkyLN4HZxnJJT/e0S9DiRhjA8tXzcFPNyfZzGJyzeVhM66hW+/Znp25oELb0D/XvrRwbd
        WeOTnY/eJ9zkxWvLRqy2Bk+rYeSso9lcrhqya0C7p2ib82OBY23c8FK3ZHNr+MnYVZ9TrorW
        GRrzKo1Da665qkbNqZGF71KVEWsEuQd8eRNyFz8XOYe67kw2Wz/PqZYt6xVtmf56RmLCFJmx
        rXh1zZzTPS/zOx8a4mcbiwYFVQ8K4ZerW8oL11WHya5n5bT/gF578aGB7U1a8GEwxpy9Y5Zw
        itDR13glrn78nq/+2OkyWnw/w5qd9ryjzXZTtWR0ZUHXV9HcV5KedPnc+Mu+gzm284Zv5o3c
        9n0lqzvEpDpVujAKqtTSX5YgUehTAwAA
X-CMS-MailID: 20230220105423epcas5p4618b6fa4fadde27086180841be87638b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220105423epcas5p4618b6fa4fadde27086180841be87638b
References: <CGME20230220105423epcas5p4618b6fa4fadde27086180841be87638b@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch series covers the points discussed in November 2021 virtual
call [LSF/MM/BFP TOPIC] Storage: Copy Offload [0].
We have covered the initial agreed requirements in this patchset and
further additional features suggested by community.
Patchset borrows Mikulas's token based approach for 2 bdev
implementation.

This is on top of our previous patchset v6[1].

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
	b. Fabrics loopback.
	c. blktests[3] (tests block/032,033, nvme/046,047,048,049)

	Emuation can be tested on any device.

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
        - nullblk: copy-offload emulation.
	- loopback device copy offload support
	- upstream fio to use copy offload

	These are to be taken up after we reach consensus on the
	plumbing of current elements that are part of this series.


Additional links:
=================
	[0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=zT14mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
	[1] https://lore.kernel.org/lkml/20230112115908.23662-1-nj.shetty@samsung.com/T/ 
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v7
	[4] https://github.com/vincentkfu/fio/tree/copyoffload-cfr-3.33-v7

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

Nitesh Shetty (8):
  block: Introduce queue limits for copy-offload support
  block: Add copy offload support infrastructure
  block: add emulation for copy
  fs, block: copy_file_range for def_blk_ops for direct block device.
  nvme: add copy offload support
  nvmet: add copy command support for bdev and file ns
  dm: Add support for copy offload.
  dm: Enable copy offload for dm-linear target

 Documentation/ABI/stable/sysfs-block |  36 +++
 block/blk-lib.c                      | 426 +++++++++++++++++++++++++++
 block/blk-map.c                      |   4 +-
 block/blk-settings.c                 |  24 ++
 block/blk-sysfs.c                    |  64 ++++
 block/blk.h                          |   2 +
 block/fops.c                         |  18 ++
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  42 +++
 drivers/md/dm.c                      |   7 +
 drivers/nvme/host/constants.c        |   1 +
 drivers/nvme/host/core.c             | 106 ++++++-
 drivers/nvme/host/fc.c               |   5 +
 drivers/nvme/host/nvme.h             |   7 +
 drivers/nvme/host/pci.c              |  27 +-
 drivers/nvme/host/rdma.c             |   7 +
 drivers/nvme/host/tcp.c              |  16 +
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
 29 files changed, 1032 insertions(+), 14 deletions(-)


base-commit: 3ac88fa4605ec98e545fb3ad0154f575fda2de5f
-- 
2.35.1.500.gb896f729e2

