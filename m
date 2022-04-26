Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB6050FC9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 14:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349818AbiDZMRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 08:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbiDZMRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:17:49 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECD3793A1;
        Tue, 26 Apr 2022 05:14:41 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220426121439epoutp0401d40543c66c374dc583ec79daa1fc7c~pcUTtjBsm2403224032epoutp04h;
        Tue, 26 Apr 2022 12:14:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220426121439epoutp0401d40543c66c374dc583ec79daa1fc7c~pcUTtjBsm2403224032epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650975279;
        bh=0O69LIhroj7wI37uoYLFc4k8EiKu/Hjr+CxXLXQiZDI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fCZIlxoC8abjvZgiOGBavTj55jQpOhHYC8gCtXq0YsPcVG55P2lXs3l45QlfIJD8F
         EHhA3QgY0IGuc+VP+1AL5IJzRzIraI95AlEZnnsHTG+EmIlAL+MkPP/li7ggEGSfl2
         qZW2QMYR02b8JeiNuG7LVd7939XbzvguWuzyQtBA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220426121438epcas5p10d323e4e6161275933c063e854a206a8~pcUTVHmsQ2178321783epcas5p1J;
        Tue, 26 Apr 2022 12:14:38 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KngmV03q9z4x9Q0; Tue, 26 Apr
        2022 12:14:34 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.F0.09762.922E7626; Tue, 26 Apr 2022 21:14:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15~paug6xF5B1971219712epcas5p4f;
        Tue, 26 Apr 2022 10:18:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220426101804epsmtrp279588e73b7154a836e04af3ef14dd860~paug5evnb1306613066epsmtrp2l;
        Tue, 26 Apr 2022 10:18:04 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-67-6267e229546a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.39.08853.BD6C7626; Tue, 26 Apr 2022 19:18:03 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220426101757epsmtip1dbba971682fc11ea2415d9083f2b846b~pauasWk1T0320603206epsmtip1X;
        Tue, 26 Apr 2022 10:17:57 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/10] Add Copy offload support
Date:   Tue, 26 Apr 2022 15:42:28 +0530
Message-Id: <20220426101241.30100-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBbVRT2LXkJHcFXlumFDsKE6ShUlpSlF4Rildbn4AIuM1ot8IDXgECS
        ScCKVGURKhRKQcsSoGBhZFgkyJ6SIFCRkkJBKVDQAmVprVE2KUjDIukD7b/vfOd89zvn3Dk8
        zPgHrgUvXBTNSEV0JJ/YgzddtX3W3nZKGOxUUOoMFZqfMFh1O5OAOQtrGJzvmObA7Mw8LtT1
        9WNwcMYIqucKOHDgnwQUTtdtoXC0XYlC1eVsFFZUdaHwXnkpAlu/WUTh+h0BvLM8hsPszmEE
        zg7JUageOwhV6h4cDl4pJGDxt7NceG6khYBtWjUGy7s3UXhDvk7ArO56DmyZSUBgk64Yg1fH
        h3BYo53H4bWx/TA5fY0L+ze6OS/YUIM3fSn5RB9BZSXNcSml/DaX6h//HqcG+2KouspUgqov
        +5z66lY5QrWOxhNUYm8XRuUtLRNURtIcQSmTJzjU4uwYTs23DRF++05EeIYxdCgjtWZEIeLQ
        cJHQi+/7VuBLga5uTgJ7gTs8zLcW0VGMF9/nVT/74+GR2zvkW39ER8ZsU360TMZ3POIpFcdE
        M9ZhYlm0F5+RhEZKXCQOMjpKFiMSOoiYaA+Bk9Mh1+3CoIgwuTJK8qPFx5O3zhPxyJZxGmLA
        A6QLuDGZgKYhe3jGZCsCUn4ZIdhgCQH5RW0YG6wg4EJHKXdX0jqdhLAJNQIGBuI5bJCMgqz2
        8W0Jj0eQB8H1LZ5eYErioGJ1FdfXYGQPFyQpH6L6hAl5CFSMKQh9PU4eAEuV1nrakPQAv69m
        IHoakI4gc2IvS+8FPfkzuB5jpBVIaix41BwgHxoA7aVehG3OByi1nRiLTcAf3Q07TVuAv+fU
        BItPg+aUEpQVf4GANI0GZxPe4GfVBqo3xkhboLjiyNKW4KKmBmWNjUCGbgZleUPQcmkX24Bq
        RcnO++ZgeDVhB1NAuVjB0WNj8iRo6NBiFxAr+WPzyB+bR/6/cwmCVSLmjEQWJWRkrhJnEXP6
        v38NEUfVIY8uyc63BZmaXHDoRFAe0okAHsY3Nbx44FSwsWEoHfsJIxUHSmMiGVkn4rq94izM
        wixEvH2KouhAgYu7k4ubm5uLu7ObgL/PUCOspY1JIR3NRDCMhJHu6lCegUU8qvUu6lUd3nht
        rMenFj8W8GfTZgDH6eiH4vuvf/CX0VHH+lw81zk9N09VdeqBwr8o84GlMOd4aihT44BXv7Ls
        YXYXm3knvfjE5KdP+AesVDhYda3fv97jXzJanFa7FiAeyX66y3tVncWD880L6wEnl0v7dVUc
        TVz+2Zw3vp4K2q9qHhbcfbIi9hk7Ok1Q9qalJmGurfB8QrBVorN5y2rx87rIeY+zeT2N724M
        x+P+v8aZKoYilgOPlUNVtuI53Zlz1fzfaCUn8b0X45ovvyzzDto0sSm8KU7h3mt4e3DmjOOR
        2Kek3w2UVa1Utdt467SC4c9yG/1Sbcy+bH+f3vS2S7/W50nycVkYLbDDpDL6X4jE5znSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA03SbUxTZxQH8Dz33t5eicVL0fBY3JydbApZWZlZzvAlRjd9DMMtS5zLcEo7
        7ypKobQwt2kirOPDKozRTaOVl1EXCKASi7ytQBQoHeNVawXqtCNAXNRRUbQStF0KWea3k///
        l5Pz4XC0NMjIuLSMbEGfoUqXs2FMY6f85TdudmvUb568mwh1f3TTUHuriIWTD2Zp8F0ZF4G5
        6JQY5voHaXBNhEPb1BkRDD3No2DcFqRg9HILBa1WMwXVtQ4K7lSdRWCvmKbg2ZgSxmY8DJg7
        biCYdFsoaPPEQWtbDwOu30pYKK+cFMPx4WYW2u+10VDlDFAwYHnGQrGzXgTNE3kIGufKaei8
        7Wbgwj0fA797oiG/YFYMg8+dos2vEtf1JGLx9rOk2DglJi2WW2IyePsiQ1z9OcRW8z1L6n89
        Rn4aqULEPprLkm/7HDQ59XCGJYXGKZa05HtFZHrSwxBfu5v9MOrTsA37hfS0LwV9/KbUsAOW
        Fq2uS/bVXyM/sLkoKDWhRRzm12H7uBGZUBgn5e0IewdKRAvFclz5vItemCNxdeCOeAEZKXzO
        2siaEMexfBzuDXIhs5RncLXfz4QMzU+LcWn70/lFkXwCrvbUzXuGj8EPa14JxRI+Ef/tL0Sh
        GPPxuMgbsRBH4J7TE0wopvnXcV3Z/Jk0vxIbG87QP6IllheU5X9leUH9gugatFzQGbQarUGp
        U2YIhxUGldaQk6FRfJ6ptaH5H4ld24yaah4oOhDFoQ6EOVq+VHIi5gu1VLJf9fU3gj5znz4n
        XTB0oGiOkUdJhkw9+6S8RpUtHBIEnaD/r6W4RbJcqu6fI9sv7ESyR6vFK4ZzolfJK84nLZPO
        eI/0yZNHHXueFG4NWBFeG+uKcynbe49/Eqlbs8kvsj72SqJiGhKElJUkGPBELt71wbLws7LP
        tP6xt3vGfEuSzaZAuQYau7fsCC8g7Ezr0cLod3aXRmUy+TslB2s3Fq1wzOpSFe9nDx9Wr5cf
        u5l4t2T04LtbDFaV+v62uFpb6ebHI+vuBy69dXFvU/KGufwrQ3lma6+m4NCq76xJV9/b6qwY
        yMrao2jte1QaTNuV+5o75ePMvohreSnOLO1pW+Vum/rPsm0/v1R2yZ5AmTtT6wem4n3Fs5zL
        0d21xp/WMNRZ5V5d8tH1JpIsZwwHVMpYWm9Q/QtVFxLzkgMAAA==
X-CMS-MailID: 20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
- copy_file_range for zonefs

4. In-kernel user
- dm-kcopyd
- copy_file_range in zonefs

For zonefs copy_file_range - Seems we cannot levearge fstest here. Limited
testing is done at this point using a custom application for unit testing.

Appreciate the inputs on plumbing and how to test this further?
Perhaps some of it can be discussed during LSF/MM too.

[0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=zT14mmPGMiVCzUgB33C60tbQ@mail.gmail.com/

Changes in v4:
- added copy_file_range support for zonefs
- added documentaion about new sysfs entries
- incorporated review comments on v3
- minor fixes


Arnav Dawn (2):
  nvmet: add copy command support for bdev and file ns
  fs: add support for copy file range in zonefs

Nitesh Shetty (7):
  block: Introduce queue limits for copy-offload support
  block: Add copy offload support infrastructure
  block: Introduce a new ioctl for copy
  block: add emulation for copy
  nvme: add copy offload support
  dm: Add support for copy offload.
  dm: Enable copy offload for dm-linear target

SelvaKumar S (1):
  dm kcopyd: use copy offload support

 Documentation/ABI/stable/sysfs-block |  83 +++++++
 block/blk-lib.c                      | 358 +++++++++++++++++++++++++++
 block/blk-map.c                      |   2 +-
 block/blk-settings.c                 |  59 +++++
 block/blk-sysfs.c                    | 138 +++++++++++
 block/blk.h                          |   2 +
 block/ioctl.c                        |  32 +++
 drivers/md/dm-kcopyd.c               |  55 +++-
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  45 ++++
 drivers/md/dm.c                      |   6 +
 drivers/nvme/host/core.c             | 116 ++++++++-
 drivers/nvme/host/fc.c               |   4 +
 drivers/nvme/host/nvme.h             |   7 +
 drivers/nvme/host/pci.c              |  25 ++
 drivers/nvme/host/rdma.c             |   6 +
 drivers/nvme/host/tcp.c              |  14 ++
 drivers/nvme/host/trace.c            |  19 ++
 drivers/nvme/target/admin-cmd.c      |   8 +-
 drivers/nvme/target/io-cmd-bdev.c    |  65 +++++
 drivers/nvme/target/io-cmd-file.c    |  49 ++++
 fs/zonefs/super.c                    | 178 ++++++++++++-
 fs/zonefs/zonefs.h                   |   1 +
 include/linux/blk_types.h            |  21 ++
 include/linux/blkdev.h               |  17 ++
 include/linux/device-mapper.h        |   5 +
 include/linux/nvme.h                 |  43 +++-
 include/uapi/linux/fs.h              |  23 ++
 28 files changed, 1367 insertions(+), 15 deletions(-)


base-commit: e7d6987e09a328d4a949701db40ef63fbb970670
-- 
2.35.1.500.gb896f729e2

