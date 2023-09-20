Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08FD7A7680
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjITI6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjITI6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:58:20 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AC6D3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:58:11 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230920085808epoutp03929e132a099a1e5893bedf8f009fcf37~Gj646XHc51591815918epoutp03f
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:58:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230920085808epoutp03929e132a099a1e5893bedf8f009fcf37~Gj646XHc51591815918epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695200288;
        bh=zOw7cNVQPoF57xL1h1f7qIyzEirWEeFnrZJRaD5dNG8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jQfb2lGABaeSSo76nbCCVZNcDgQi6GQNvQ0ukbyFAGxRAX6VOtbZHOGSUctm8Up8r
         gxRoJ5FmnJrNwV8dEUTp9DMmVPY6FMpJtrb0taihv6QyYLeJkCrwaXf0rXwMuWLd8u
         tuhZQf2kb3xlo6/RWgW8fRleao2dR5Tj0k5kg8r0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230920085807epcas5p2cc51faad2611cefa3f3586d6ecf6a2bb~Gj64TuBxK0111201112epcas5p2z;
        Wed, 20 Sep 2023 08:58:07 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RrC9V1gP0z4x9Ps; Wed, 20 Sep
        2023 08:58:06 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.C1.19094.E14BA056; Wed, 20 Sep 2023 17:58:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081415epcas5p120fe03e79259894896a6bd04cf0845df~GjUk3JQ-52615926159epcas5p1m;
        Wed, 20 Sep 2023 08:14:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230920081415epsmtrp21601f7aba5d51186ff58199449498353~GjUk1VICZ0161101611epsmtrp2w;
        Wed, 20 Sep 2023 08:14:15 +0000 (GMT)
X-AuditID: b6c32a50-64fff70000004a96-68-650ab41e86c2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.8E.08788.7D9AA056; Wed, 20 Sep 2023 17:14:15 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081412epsmtip1a0e8e2facb022519471a1a8faf937c44~GjUhyZpoZ2850828508epsmtip1B;
        Wed, 20 Sep 2023 08:14:11 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v16 00/12] Implement copy offload support
Date:   Wed, 20 Sep 2023 13:37:37 +0530
Message-Id: <20230920080756.11919-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVRTZRzuvXfcDTrDK+jhjQrXUgMV2ArWC4FWcuCi1dnBo3UqwQH3DNrn
        2YZYIWJ8pCAC8mFuGshnQMFYiICsCCIENc/BgwaGnIRBAYGAqbGQNi6U/z3P8/t4fr/3PT8O
        7rJAuHPilTpao5TI+YQTq6nTy9Pbo9GJFhirCFTf+xOOZv+yslDtUA6BJjvnABpt/xwg87TB
        AQ20t2CourYLQ6c6bgJk6ddjyDy4FZ3PKGehNnMPC91oPUug4koLG2XdaiZQVfdjDP2SawGo
        efQoQE3WYhzVTc6w0OXBZ9H1xW6H192oFv0Qm7p+p4FF3biWQJlqjhPUt+VHqEsDKQRVdjLf
        gcpOnSaoWcsgi5r5rp+gTjbWAGre5EGZRv/ExNz3ZUFxtCSW1vBoZYwqNl4pDebv3hO1M8pf
        JBB6CwPQq3yeUqKgg/khb4m9Q+PlttX5vIMSeYJNEku0Wr7v9iCNKkFH8+JUWl0wn1bHytV+
        ah+tRKFNUEp9lLQuUCgQvOxvSzwgi/ujbIJQP9576Ju5eYcUMLE9EzhyIOkHM+qKsUzgxHEh
        2wAsbDjFZsgcgNbaqRXyAECTtchhteSe0YIzATOAfz/qIRiSjsGF41M2wuEQ5FZ4ZYlj19eR
        KTg0XioDdoKTAxi89n0TZm/lSgbAc31py5hFboJj6ZksO+aSgXC49CLb3giSvjBneC0jr4U9
        Z0aXU3ByA0y9YFieApKnHeGg3sBixguBBRPDBINd4UR3I5vB7nB+2ryiJ8Lqgq8IpjgNQP0t
        PWACO2B6bw5uN8ZJL1jf6svIz8PC3jqMMXaG2dZRjNG5sPnLVfwi/Lq+ZKX/M/Dmw6MrmIK/
        WX9fns2F3A9H8orZuWCD/ol99E/so//fuQTgNcCdVmsVUjrGXy30VtKJ//1tjEphAstHsEXc
        DGqNiz4dAOOADgA5OH8dV7HZiXbhxko+/oTWqKI0CXJa2wH8bY+ch7uvj1HZrkipixL6BQj8
        RCKRX8ArIiHfjTuZfi7WhZRKdLSMptW0ZrUO4zi6p2CbqeGZwPzoNR6LuQc33Y9UdLm9d36p
        //RtMiI0eTw/vW3jRjy6pOcFr7DUpAjB9F5e5z8VB9I+uOjcYEj2f5O3PvfXO8HRcuk+w/ix
        MOOnsrAfPszTdgmy5u69Hbm/fMG6cCTJ9elG5zeqKyrPBr17eOpqaMpdacZnVU6txqI1AxGW
        L8KHhswtjSd6DpdoPHeLssYTPRIPhXvK9FfEAeE1WduCPXmZY65lO696PmoH3kTB3aciFYUh
        O7xUs6WRuxJPoAdTSTI+PbLPtG2xT9KnK31u8iXB/RZDjLy86owR0IrK6eToj7RVFWNLr8Xv
        Gnnn4azSN3c+Luryj9lFe6Yu/Cymb/NZ2jiJcAuu0Ur+Bb15UAuNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnO71lVypBqeb2CzWnzrGbPHx628W
        i9V3+9ksXh/+xGjx5EA7o8Xed7NZLW4e2MlksXL1USaLSYeuMVo8vTqLyWLvLW2LhW1LWCz2
        7D3JYnF51xw2i/nLnrJbdF/fwWax/Pg/JosbE54yWux40shose33fGaLda/fs1icuCVtcf7v
        cVYHcY+ds+6ye5y/t5HF4/LZUo9NqzrZPDYvqffYfbOBzWNx32RWj97md2weH5/eYvF4v+8q
        m0ffllWMHp83yXlsevKWKYA3issmJTUnsyy1SN8ugSvj5eJXbAX/QivWfvrM2sD4yq6LkZND
        QsBE4sOGp8xdjFwcQgK7GSV+3b/OCpGQlFj29wgzhC0ssfLfc3aIomYmiStTmpi6GDk42AS0
        JU7/5wCJiwh0MUt07nzHAuIwCzxlkvj48xsjSLewgKXE3EstTCA2i4CqxLPWLhYQm1fASuL+
        ou3sIIMkBPQl+u8LQoQFJU7OfMICEmYWUJdYP08IJMwsIC/RvHU28wRG/llIqmYhVM1CUrWA
        kXkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw7Gpp7WDcs+qD3iFGJg7GQ4wSHMxK
        Iry5alypQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTAV
        BFziWK10sWyr4rF/F3m7L943qX9rcjLhiIm1kNw6jrpPi1M9PjX6W/PMmHxub/wXYyWtuTK/
        NtYuDDyeskvTjdHhRsjCScJbbNiVHxgLN4cI7tkzd8b1Fr9XFos+z5pYdiPPRWa/pdZ9z7R8
        blfPzl1Mkd+es5ev++8dvOfiWT8r604pRtH7IRWJKSph7Uv4v4uvOTfN6Y+CVbjZZtHHyQIC
        ZpOMD0m6HmLLPH1waZFTZJ34PONa5jbPTOElS8sl7t0/acTl6z/D7+/d2B9/OlV3de77bVSf
        8LD/ovm8XQZfH/XOfXrFfqEuB9+i0I27piaE7IhqejK7qetHDT+/2BXtV7dlH186dLVz6lUl
        luKMREMt5qLiRAAZJLQpTAMAAA==
X-CMS-MailID: 20230920081415epcas5p120fe03e79259894896a6bd04cf0845df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081415epcas5p120fe03e79259894896a6bd04cf0845df
References: <CGME20230920081415epcas5p120fe03e79259894896a6bd04cf0845df@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch series covers the points discussed in past and most recently
in LSFMM'23[0].
We have covered the initial agreed requirements in this patch set and
further additional features suggested by community.

This is next iteration of our previous patch set v15[1].
Copy offload is performed using two bio's -
1. Take a plug
2. The first bio containing source info is prepared and sent,
        a request is formed.
3. This is followed by preparing and sending the second bio containing the
        destination info.
4. This bio is merged with the request containing the source info.
5. The plug is released, and the request containing source and destination
        bio's is sent to the driver.
This design helps to avoid putting payload (token) in the request,
as sending payload that is not data to the device is considered a bad
approach.

So copy offload works only for request based storage drivers.
We can make use of copy emulation in case copy offload capability is
absent.

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
        use generic_copy_file_range.
        For in-kernel users (like NVMe fabrics), use blkdev_copy_offload
        if device is copy offload capable or else use emulation 
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
	[1] https://lore.kernel.org/all/20230906163844.18754-1-nj.shetty@samsung.com/
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v15
	[4] https://github.com/OpenMPDK/fio/tree/copyoffload-3.35-v14

Thanks for review!

Changes since v15:
=================
        - fs, nvmet: don't fallback to copy emulation for copy offload IO
                    failure, user can still use emulation by disabling
                    device offload (Hannes)
        - block: patch,function description changes (Hannes)
        - added Reviewed-by from Hannes and Luis.

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
 block/blk-lib.c                      | 424 +++++++++++++++++++++++++++
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
 drivers/nvme/target/io-cmd-bdev.c    |  71 +++++
 drivers/nvme/target/io-cmd-file.c    |  50 ++++
 drivers/nvme/target/nvmet.h          |   1 +
 drivers/nvme/target/trace.c          |  19 ++
 fs/read_write.c                      |   8 +-
 include/linux/bio.h                  |   6 +-
 include/linux/blk_types.h            |  10 +
 include/linux/blkdev.h               |  22 ++
 include/linux/device-mapper.h        |   3 +
 include/linux/nvme.h                 |  43 ++-
 32 files changed, 1098 insertions(+), 19 deletions(-)


base-commit: 7fc7222d9680366edeecc219c21ca96310bdbc10
-- 
2.35.1.500.gb896f729e2

