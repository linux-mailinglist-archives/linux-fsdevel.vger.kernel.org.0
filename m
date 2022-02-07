Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C44AC20A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 15:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381803AbiBGOxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 09:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392414AbiBGOab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:30:31 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55389C0401C6
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 06:30:28 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220207142245epoutp01060775043837707a30078eebda2bedc8~Rhv5B71ca2867628676epoutp01o
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 14:22:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220207142245epoutp01060775043837707a30078eebda2bedc8~Rhv5B71ca2867628676epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644243765;
        bh=5QYzt4tRkBvcWsVz03kfAFVzKeqCoxXt7vtpSOslY8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKcOYllGI2msbjFqFXwb+BX8tjaAyU/sA2LYi7LEKeNVDe9loChBLPtbHxgU0gO+V
         NaMKuGmiovhpnuiS6/pugk6kYqS6myQ1tQg/7+hOOXP6d1lsmHW9OaHAVgV8CQsgNv
         m1xTROQFvFaH2YHc3cWBeohy0y93FRkzDAqktPCc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220207142244epcas5p29a7306d5c7f8e54ea7a493ffcb0fa016~Rhv3nwPUf2954829548epcas5p2e;
        Mon,  7 Feb 2022 14:22:44 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JspJG57mjz4x9Pq; Mon,  7 Feb
        2022 14:22:38 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.1E.46822.28A21026; Mon,  7 Feb 2022 23:19:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141901epcas5p162ec2387815be7a1fd67ce0ab7082119~Rhsn75jdi1498914989epcas5p16;
        Mon,  7 Feb 2022 14:19:01 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220207141901epsmtrp1f9eeb35e5f80b47703f826b47335f7a2~Rhsn6oK7q0764707647epsmtrp1r;
        Mon,  7 Feb 2022 14:19:01 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-28-62012a82045c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.33.08738.45A21026; Mon,  7 Feb 2022 23:19:00 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141856epsmtip1abc84e3ece99ad466b43b11b462c0490~RhskKuvSp0284102841epsmtip1j;
        Mon,  7 Feb 2022 14:18:56 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     mpatocka@redhat.com
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nj.shetty@samsung.com
Subject: [PATCH v2 00/10] Add Copy offload support
Date:   Mon,  7 Feb 2022 19:43:38 +0530
Message-Id: <20220207141348.4235-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH97u3vS3LileG4QeRjBQ18lzLKP46hpgIy3VjBiJmQpxY4AqE
        0ta2uEk0wCp78JDCECtsg20MFJi48pBBYVBSAQuIIpThNuW1ORhsPNxAcLWloPvvcx7fc37n
        /HLYuMMVlgs7SaKk5RKRmEtsZzR1eXj6HPcEsbxu4w6ku7HERDW38glU/HAVRw86J5moMF/D
        QkNT9qhtvpSJBlcyMTSpNWNId7EQQ9/UGDB0t+oSQKeNgxhaH+cjg3mOQIX6EYDaxryQrq2X
        gcoqp1kox9RMoPbZNhxVdT/BUMGpYQwNlKwTqGmtDEddt4cZqGYdoazcVRaauf7ea67U0K8H
        qQLVPItSld9kUEP9qZS2+jRB1VekU2dGqwDVeiODoI73GXBKs7hMUKa+7zEqTzVPUAvTYwyq
        aTyPRT1oHyaozxuqQbhjdPK+RFoUT8vdaEmcND5JkhDEPfhWzOsxggAe34cvRK9w3SSiFDqI
        GxIW7rM/SWxZEtftI5E41eIKFykU3N2v7pNLU5W0W6JUoQzi0rJ4scxf5qsQpShSJQm+Elq5
        l8/j+Qksie8nJ/aXLzJlasdjxdPPZIAp+2xgx4akP/xtZQxY2YFsBbBHH5cNtlt4EcCq3C+B
        zVgCsOjOKLalGKhpZNoCLQB295gIm5GFwdK6a6xswGYTpBc0mtlWgSPpBNcHmzYq4eQSA46Y
        SljWwE7SD/7dcW2jKoN8EdYabjGsWg4phI0jobZm7vDCeCfTynZkBDT3nsWtzCGfhb1fTTGs
        jJO7oKqxFLfWh+QdO3jf1MqwiUPgOdVPm7wTznQ3sGzsAu/ln2DZBDkArvT9jtkMDYAqtYqw
        ZQXDn3X/YNYX4aQHrGvZbXO7wi9+/BazdbaHeWtTm2vhwObzW+wOa+vKN8s4w5HHmZtMwZb6
        JsK27AoAF/RH1MCt5KmBSp4aqOT/zuUArwbOtEyRkkArBDI/CX30v0+Ok6ZowcbdeB5oBuN/
        PPTVA4wN9ACyca4j5/kcs8iBEy/6OI2WS2PkqWJaoQcCy8ILcJfn4qSWw5MoY/j+Qp5/QECA
        v3BPAJ/rxDEmfCdyIBNESjqZpmW0fEuHse1cMrCs+nc1s7HbPkihL0c8OiTUpWuKfT6bULfx
        Tt6c2VHuvd/Q7vnGJ2V1rgNeqooJgyv1UuQ7y38tDIah63O1ukCH5q5WY9Wcit/aEP0oInDy
        annvgOP5ZoM62j8oKpRzjBIHV/odXuOFrom5wihzWthyiuBNXnHtnkuKl+/FuRxF5suclV8O
        Tc6FCmZ7i4LVL5jPZg6fK9UuO/WduRJzPzI//c/FH+ojT7n2dybG7l0iGavTpo67zidM3le1
        B3SHjScXnnBCJorc0wvql6Wj/etvezCT3bwrojxK4+UdF2szc46gcC+i54LsU+3jXdsk657c
        QHr8w9t+aXFOXw/E51ZqYrkMRaKI74nLFaJ/AZLhC3bABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7bCSnG6IFmOSwetT5hZ7bn5mtVh9t5/N
        YtqHn8wW7w8+ZrWY1D+D3eLyEz6Lve9ms1pc+NHIZPF4038miz2LJjFZrFx9lMni+fLFjBad
        py8wWfx5aGhx9P9bNotJh64xWuy9pW2xZ+9JFov5y56yW3Rf38Fmse/1XmaL5cf/MVlM7LjK
        ZHFu1h82i22/5zNbHL53lcVi9R8Li9aen+wWr/bHOch6XL7i7TGx+R27R/OCOywel8+Wemxa
        1cnmsXlJvcfkG8sZPXbfbGDzaDpzlNljxqcvbB7Xz2xn8uhtfsfm8fHpLRaPbQ972T3e77vK
        5tG3ZRVjgEgUl01Kak5mWWqRvl0CV8bZBZ9YCyaIVEx7yt/A+ISvi5GTQ0LAROLc6q2sILaQ
        wA5Gie1fFCDikhLL/h5hhrCFJVb+e87excgFVNPMJDFz+nGgBg4ONgFtidP/OUBqRATEJf5c
        2MYIUsMsMJ1VouHUZSaQhLCAkcSvAzvBbBYBVYk1R++ygPTyClhKbL3mCjFfWWLhw4NgN3AK
        BEr8PzmHGeKeAIk/3x6xg9i8AoISJ2c+AWtlFlCXWD9PCCTMLCAv0bx1NvMERsFZSKpmIVTN
        QlK1gJF5FaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcOLQ0trBuGfVB71DjEwcjIcY
        JTiYlUR4Zbr/JwrxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TB
        KdXANCNoZuKXv03rd85RCvdddpDruUAuz8It5hJubhPTFmqnpWnELnFi/hlsduKkgJ6ka3xB
        d97lt0wOJ5qleDQllZZ/vb9L+KCcfMHhcvelBs33hbfMMl1c+1dJLVw49FFVytWQ1AeiP51P
        Jh5ece3bd6b0wtDzPlXJBZkyxznbH3JcjvfqCAnfqrZtR45BtFRv3M1j1veX5hdlBjwvMXHt
        ZOhZ/cugIrhUq6vl++n1PKvuNPF9XHO3PcpxY1IY/1f5Vx8ta18G1U3sEgx6f2Vm5JUTi0xL
        L7Vev3S089H2/tADPpNcN0uzuMgofOgOaw8/vJhzvXjDqq1Vp/5v1xZw53i+Ic+abb1Iyp9a
        uXYlluKMREMt5qLiRACU4PdziwMAAA==
X-CMS-MailID: 20220207141901epcas5p162ec2387815be7a1fd67ce0ab7082119
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141901epcas5p162ec2387815be7a1fd67ce0ab7082119
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <CGME20220207141901epcas5p162ec2387815be7a1fd67ce0ab7082119@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch series covers the points discussed in November 2021 virtual call
[LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
We have covered the Initial agreed requirements in this patchset.
Patchset borrows Mikulas's token based approach for 2 bdev
implementation.


This is on top of our previous patchset v1[1].
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
[1] https://lore.kernel.org/linux-block/20210817101423.12367-1-selvakuma.s1@samsung.com/

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
  nvme: add copy support
  dm kcopyd: use copy offload support

 block/blk-lib.c                   | 335 ++++++++++++++++++++++++++++++
 block/blk-map.c                   |   2 +-
 block/blk-settings.c              |   6 +
 block/blk-sysfs.c                 |  51 +++++
 block/blk.h                       |   2 +
 block/ioctl.c                     |  37 ++++
 drivers/md/dm-kcopyd.c            |  57 ++++-
 drivers/md/dm-linear.c            |   1 +
 drivers/md/dm-table.c             |  43 ++++
 drivers/md/dm.c                   |   6 +
 drivers/nvme/host/core.c          | 121 ++++++++++-
 drivers/nvme/host/nvme.h          |   7 +
 drivers/nvme/host/pci.c           |   9 +
 drivers/nvme/host/trace.c         |  19 ++
 drivers/nvme/target/admin-cmd.c   |   8 +-
 drivers/nvme/target/io-cmd-bdev.c |  66 ++++++
 drivers/nvme/target/io-cmd-file.c |  48 +++++
 include/linux/blk_types.h         |  20 ++
 include/linux/blkdev.h            |  17 ++
 include/linux/device-mapper.h     |   5 +
 include/linux/nvme.h              |  43 +++-
 include/uapi/linux/fs.h           |  23 ++
 22 files changed, 912 insertions(+), 14 deletions(-)

-- 
2.30.0-rc0

