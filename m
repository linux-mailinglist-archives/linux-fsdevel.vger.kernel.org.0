Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC04B4436
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 09:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbiBNIfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 03:35:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbiBNIfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:35:01 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9B25C73;
        Mon, 14 Feb 2022 00:34:51 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220214083446epoutp0388b33d8e6892ec8968523c7a595b84a6~TmhDp91Xk0636606366epoutp03P;
        Mon, 14 Feb 2022 08:34:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220214083446epoutp0388b33d8e6892ec8968523c7a595b84a6~TmhDp91Xk0636606366epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644827686;
        bh=vZTrgiOW+QssDF+eNNkQ/NKShN3mOUrphbtmnHAZuqM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gxj96gjSd5agoUpSAP33yMFQNMCy0QwkPtkt3yi1RYIM0eTbWyvVd0CqNuzEL4fBn
         u9xcozJqWNugbYweZ9EBT9wQEZ3sX2pxIbC0bDvvXyywVBSA5kPycPmKz1EPVx06Ec
         RrKA3NuGPpayCU/IrpJX/sWUMHQi1+gbBqzlvImM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220214083445epcas5p26fa92a4f5144c6e20ec809149f325a3f~TmhDQfoV-1890418904epcas5p2n;
        Mon, 14 Feb 2022 08:34:45 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JxyFX1yMqz4x9Q3; Mon, 14 Feb
        2022 08:34:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.F5.05590.E141A026; Mon, 14 Feb 2022 17:34:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220214080551epcas5p201d4d85e9d66077f97585bb3c64517c0~TmH0DlolQ0641206412epcas5p2k;
        Mon, 14 Feb 2022 08:05:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220214080551epsmtrp1e7b9ac42b2a39510a8cb2b24652a1017~TmH0B0nE20045600456epsmtrp1G;
        Mon, 14 Feb 2022 08:05:51 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-5b-620a141e7676
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.84.08738.F5D0A026; Mon, 14 Feb 2022 17:05:51 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220214080546epsmtip2b0944a037ec35c960299faf315798fe6~TmHvuft_Q2320123201epsmtip2K;
        Mon, 14 Feb 2022 08:05:46 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] Add Copy offload support
Date:   Mon, 14 Feb 2022 13:29:50 +0530
Message-Id: <20220214080002.18381-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeUxUVxTGc99782YgBZ+IeCVR6dg2AYMybF6NtBYIfdFKaUhaNFU6MK8z
        CAzTWajSpAIj1gGUpa2FgSgoSwVFREV2CgSHYZFNpMhWdIhr2SlQtjI8aP3vOye/757l5vBw
        i3KuNS9IqmTkUmEInzQliutsbe23W5oGOGSPOaFbjQ9wVNEzyUH5/QkkujQ2h6PRmmcclJyQ
        wkWdBnNUOZLGQW2zURh6VrSMoYqryRi6nl+Poee51wAqzxzHkKapDUMLQwJUv/wXiZJrHwM0
        3KXFUOWTXaiiUk+gzrJ0El3JGeaiuO4SElW9rsRRrm4JQw+1CyQqMUQBVDx/BUd1A10EKng9
        SqBzt6cBiomf46LWRR3nIJ/ufHSY1g62kHSSeoRLl2r7uXTrwG2CVmf0EXRni4ouytOQ9J2s
        M/RPf+QCurwnkqSjm+txOmViiqQvqEdIenz4CUGPVnWRPlbHgg9IGKGIkdsw0sAwUZBU7MY/
        7Ovv4e/i6iCwF+xDe/k2UmEo48b3/NTH3isoZGV/fJtwYYhqJeUjVCj4ez48IA9TKRkbSZhC
        6cZnZKIQmbNst0IYqlBJxbuljHK/wMHB0WUF/DpY0pM0x5FlWZ2qup6JRYIMKhaY8CDlDIfj
        9ZxYYMqzoMoB7G3vxdhgAsCSFzMcI2VBTQLYPSZZd8yWvgAsVAZg1NX0NUcMBt/ETqwEPB5J
        7YJNyzyjwZIi4PWZGcLI4NQkCRtuzK8ymyhHWPL7diNDUO/D3LkGYNRm1H6ob4vG2WI7YeZQ
        DYfNb4T6VANh1Di1A6rvpa0xEyawv/4bVnvCV4bzHFZvgq90d7mstoYvE85xjT1AKg7A2eZB
        jA1SAFQnqkmW+gi2VyyuNodTtvBW2R42vQ3+0liAsYXN4YV5A8bmzWDJ5XW9E964lbH2zFb4
        eCaKND4DKRpOa75il3gc3sgvIBPBDu1b42jfGkf7f+EMgOeBrYxMESpmFC4yJynz3X//GhgW
        WgRWr8jucAl4+ufY7lqA8UAtgDycb2l2osUkwMJMJDwdwcjD/OWqEEZRC1xWdpyEW28ODFs5
        Q6nSX+C8z8HZ1dXVeZ+Tq4C/xaxRXCi0oMRCJRPMMDJGvu7DeCbWkdh+apsi70v38N5uq5dO
        rZn3vXVt4fZpnjOp19x+fVVHnLH0/WL6eU7G/aY39z7Jj3HnfoAHSWu/1XtEdEZ0+P1crbTV
        7II/+nofWuqZ6lX9fbvvaPLEC02foUZ/LPEI12t52C9bZHe0uXpk2TPWJUijK2y6VHp+KPvy
        UPbUxyDwYkqvVXrDuKj4iNjjQWHqQ4Hh++MFg+/84PbZzbvtvdGFczFpEkHRwELceyf1S05e
        5dvO+oX/FuBulRp/86xb0SVxyqjuZEbH6aqxU/bBtuaSY953Tuw9OlW1YUuopqih+l3NU57K
        /tGGrEXXJZth0WbHBeZgR86A7z+6sty8RZ7S6+LGz0/xCYVEKLDD5Qrhvy5gmLzOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxiG955zenroVnYsBg5gbChfBgcb1Zhnyowk+/EmGuPiotnSjR7H
        CYK0Nq246WYG1M8qQyCZWvwA7GgKCyjGrkjbKIjS0c6Gihs6cQYaNwkUQQYNX6Zjy/x35b6v
        5/71MKRsjkpgCrX7BL2WL1bQEsrepZBn5kklu95rmF8BrT/fIcE5MCmC5seVNHw/HiYhdGtI
        BNWVZ8UQGI4G11itCPwzZQQMtS0S4GyoJsDW3E3AM+tlBB31Lwg40esnYO5pNnQvjtJQ3fkA
        QbDfTIDr4WpwujwUBG6cp+FSY1AMJ3910OAecZFgvbtAwC/mORocw2UI7LOXSOga7KegZSRE
        wdGrUwiOnAqL4d78XdEmBQ7c34zNT3w0rjKOiXG7+bEY3xu8SmFj3e8UDvhKcFvTCRpfs3yL
        a36zItwxUErjcm83ic9OvKRxhXGMxi+CDykccvfT22I/leTkC8WF+wX9uxvVkt0DVWGRzhL7
        ldtWT5SiOtaEohiOXcvNtP+JTEjCyFgH4o4FJomlIp5rnL9NLnEMZ1t4Jo6wjDUSnKkaTIhh
        aHY117vIROLlLMXZpqepyA7JXhBz3hGvOOLEsErOcXNlxKHYVM4a7kERlrLrOY+//N/5ZK7+
        6S3RUr6M85wbpiKnJJvOtV6URWKSlXPG67XkafS2+TXL/L9lfs2qQ2QTihd0Bk2BxpCtU2qF
        L7MMvMZQoi3I+mKvpg398yAZGQ7kbBrP6kQEgzoRx5CK5dLPfVG7ZNJ8/sBBQb83T19SLBg6
        USJDKeKkfpMnT8YW8PuEPYKgE/T/tQQTlVBK6NeNv/yor0jaYkbrD68b/CNns/oTlEI8yqzs
        jnqAYqJPJVw4MvrBQvpb9o+3gdvSt2bWrzaUUWkVRa0H+OTLq0q2Jqkd23u/Lsr6LjW5pcb6
        5M7kcQ0y2lFwKjR8MEXXqptRvX/Tp1fuuOFsvNZXnpSmuqKLOQyno909Pc2ZtccKt3vl5dOf
        nVw2dL9qNPRTWgK/gVA+90wNBi8+r1gh3+KLC6vUHkluYqFqZ0MqeT1xPFzTonwH74nLMa1t
        /sbrLMpNvz2xNdeVN7Ap9ihd4XnzwysWGyVfdcier5WPTKSc+XFL8uwh1RuK9r/5H+J37rA0
        HSe6pnSPkno7ziz8paAMu/nsDFJv4F8B1ZQ2/48DAAA=
X-CMS-MailID: 20220214080551epcas5p201d4d85e9d66077f97585bb3c64517c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080551epcas5p201d4d85e9d66077f97585bb3c64517c0
References: <CGME20220214080551epcas5p201d4d85e9d66077f97585bb3c64517c0@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch series covers the points discussed in November 2021 virtual call
[LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
We have covered the Initial agreed requirements in this patchset.
Patchset borrows Mikulas's token based approach for 2 bdev
implementation.

Overall series supports –

1. Driver
- NVMe Copy command (single NS), including support in nvme-target (for
	block and file backend)

2. Block layer
- Block-generic copy (REQ_COPY flag), with interface accommodating
	two block-devs, and multi-source/destination interface
- Emulation, when offload is natively absent
- dm-linear support (for cases not requiring split)

3. User-interface
- new ioctl

4. In-kernel user
- dm-kcopyd

[0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=zT14mmPGMiVCzUgB33C60tbQ@mail.gmail.com/

Changes in v3:
- fixed possible race condition reported by Damien Le Moal
- new sysfs controls as suggested by Damien Le Moal
- fixed possible memory leak reported by Dan Carpenter, lkp
- minor fixes


Arnav Dawn (1):
  nvmet: add copy command support for bdev and file ns

Nitesh Shetty (6):
  block: Introduce queue limits for copy-offload support
  block: Add copy offload support infrastructure
  block: Introduce a new ioctl for copy
  block: add emulation for copy
  dm: Add support for copy offload.
  dm: Enable copy offload for dm-linear target

SelvaKumar S (3):
  block: make bio_map_kern() non static
  nvme: add copy offload support
  dm kcopyd: use copy offload support

 block/blk-lib.c                   | 346 ++++++++++++++++++++++++++++++
 block/blk-map.c                   |   2 +-
 block/blk-settings.c              |  59 +++++
 block/blk-sysfs.c                 | 138 ++++++++++++
 block/blk.h                       |   2 +
 block/ioctl.c                     |  32 +++
 drivers/md/dm-kcopyd.c            |  55 ++++-
 drivers/md/dm-linear.c            |   1 +
 drivers/md/dm-table.c             |  45 ++++
 drivers/md/dm.c                   |   6 +
 drivers/nvme/host/core.c          | 119 +++++++++-
 drivers/nvme/host/fc.c            |   4 +
 drivers/nvme/host/nvme.h          |   7 +
 drivers/nvme/host/pci.c           |   9 +
 drivers/nvme/host/rdma.c          |   6 +
 drivers/nvme/host/tcp.c           |   8 +
 drivers/nvme/host/trace.c         |  19 ++
 drivers/nvme/target/admin-cmd.c   |   8 +-
 drivers/nvme/target/io-cmd-bdev.c |  65 ++++++
 drivers/nvme/target/io-cmd-file.c |  48 +++++
 include/linux/blk_types.h         |  21 ++
 include/linux/blkdev.h            |  17 ++
 include/linux/device-mapper.h     |   5 +
 include/linux/nvme.h              |  43 +++-
 include/uapi/linux/fs.h           |  23 ++
 25 files changed, 1074 insertions(+), 14 deletions(-)


base-commit: 23a3fe5e6bb58304e662c604b86bc1264453e888
-- 
2.30.0-rc0

