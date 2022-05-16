Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB152858A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbiEPNjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242165AbiEPNjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 09:39:35 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B422ED60
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 06:39:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220516133924euoutp01b13ffb1810273c9a50c2310452f07fc6~vmYAvvkZ81466714667euoutp01C
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 13:39:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220516133924euoutp01b13ffb1810273c9a50c2310452f07fc6~vmYAvvkZ81466714667euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652708364;
        bh=VMoLmvVkIfoNCEerRGqLBFtJ8f5iYdPVCJbBishHFAc=;
        h=From:To:CC:Subject:Date:References:From;
        b=SdJgp0vgMCzRmv1an2EVPIRTH89HDULq8nHo7HObcL/rBS69LVZ56LUiR8c4pmZkE
         dUhgt/jF9yehQvWqQEBT+KdeswDN5aUfppqS35If0lmE2DxsooCORSrrGsLWSgpT/R
         EgFLNNmVKwVKEMuqo31KI956T02YQF2KzV67lu1g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516133923eucas1p1e6ad1287605fcdf3b4acd055c7453b14~vmYAM7ZnU0242102421eucas1p1e;
        Mon, 16 May 2022 13:39:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 89.63.10009.B0452826; Mon, 16
        May 2022 14:39:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516133922eucas1p1c891cd1d82539b4e792acb5d1aa74444~vmX-tYuPk1348813488eucas1p1T;
        Mon, 16 May 2022 13:39:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220516133922eusmtrp216e1fc6a08dca76cb8962e05fee8aecd~vmX-r5sSm2486924869eusmtrp2R;
        Mon, 16 May 2022 13:39:22 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-cd-6282540b846a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7B.F8.09404.A0452826; Mon, 16
        May 2022 14:39:22 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220516133922eusmtip2166a95c27dd930a16ecf812a24156c40~vmX-ep-Cb2359623596eusmtip2B;
        Mon, 16 May 2022 13:39:22 +0000 (GMT)
Received: from localhost (106.110.32.130) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 16 May 2022 14:39:22 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <axboe@kernel.dk>, <naohiro.aota@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <Johannes.Thumshirn@wdc.com>,
        <snitzer@kernel.org>, <dsterba@suse.com>, <jaegeuk@kernel.org>,
        <hch@lst.de>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jonathan.derrick@linux.dev>, <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>, <gost.dev@samsung.com>,
        <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        <linux-block@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>,
        <matias.bjorling@wdc.com>, Jens Axboe <axboe@fb.com>,
        "Sagi Grimberg" <sagi@grimberg.me>, <dm-devel@redhat.com>,
        <jiangbo.365@bytedance.com>, Chaitanya Kulkarni <kch@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v4 00/13] support non power of 2 zoned devices
Date:   Mon, 16 May 2022 15:39:08 +0200
Message-ID: <20220516133921.126925-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTdRzuu/fdu5fFuNfh4detEufVHWAoHdoXK8zK7tXdedn5o+uPbMLb
        gGDYxojInRsozoEwCTMHJnBLUckFA44fIr+ObQQCMfAAExxILg1EB9lSJMZL5X/P8/k8z+ee
        53tfEhMWEyIyXpHCKBWyRAnBx2ts3u5Xn9+VsX+951YQsvxsw9D8FRuBLt3MI9C3014M5ed9
        x0OPr/VgqHGqkIt6/9Jx0IVL7Rx022LCUE7zNI7mDCMLs8MuDD1xRSDXzDCO8luvAzQxYOKg
        xuEw1DdexkNXGjtw5KwvItDZcxM8ZMyaxdAJu5WLLt+7jyPHsPhtEe3sl9JPHeUEfSJzikf3
        jFTgtPOamq68eIygS7QnMdpqPkQ3DGkJ+njmFEHXHRnl0vevDhC0pWoAp43WCi7tqXyJPtqc
        zfmA+pj/ZiyTGJ/KKNdFf8qPm7l+HhyofTetqNfM04LxDQbgR0IqEjp6jgAD4JNCqgzA5oZf
        MJbMADja/j2XJR4AJ42PCAMgFy32kyp2fh7A478Xg/9Ef48cJVhSBWBPjhP4HAQVCnXHeL75
        cqoFQG9vGcdHMCqDC2fGnvB8SQKpaHgjtw34ME69DEtNetyHBdQm+KuuCbBpV8HTfY94vqMY
        FQIt9etYyTLYcfr2ohxbkGRWF2JsUgksdIazTg380da1mAFSF/hwzPsQYxfvwTndD0s4EN61
        V/FY/AKcrzvLYfHXcGLwMcaaDwOYV2dZeoo3YG5XIgu3QHOflIUBcHByGZsmAObXnFpKI4D6
        LCF78BVYm1ENjGCN6f8qpmeqmJ6pUgywi2AFo1YlyRlVhIL5MlwlS1KpFfLwmOSkSrDwiTuf
        2h/WgjN3H4S3Ag4JWgEkMclywfo07X6hIFb2VTqjTN6nVCcyqlYgJnHJCkFM/E8yISWXpTCf
        M8wBRvnvlkP6ibQcsRBfKzWZdxhl9Lmw4aH0+qBPbnl2+Pe3lXR65zaurbhTvHrT+ze6u+JL
        5KmKLOdOl8j54pbNqaX6Pcxud0+FY1JacLMp0tqU4PgozVXjyRXvRNm2yN64t0hirJtoG3+Q
        wtsokbg35FjdmhpvurBlVvNaWPaq2aDnRlcejKq2hQy1t5QXqT98x7NL1l7KrL6c8Nn2KMPo
        68VfECODmvnYAXetf8y0sXTbNwHbrbPxp4LdtkPjzijvH2Yy2q97z1VpliVkb7o9lFDpAzq1
        7om9IU1JwZYEh78hvMNacE8mX7mvIOtPQqQLVukTNFsPiocmd2/rL/+Nu7ku+U5DYaAEV8XJ
        IkIxpUr2D9T6f30zBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsVy+t/xe7pcIU1JBusnmVisP3WM2eL/nmNs
        Fqvv9rNZTPvwk9liUv8MdovfZ88zW+x9N5vV4sKPRiaLlauPMlk8WT+L2aLnwAcWi79d94Bi
        LQ+ZLf48NLR4+OUWi8WkQ9cYLZ5encVksfeWtsWlxyvYLfbsPclicXnXHDaL+cuesltMaPvK
        bDHx+GZWi3Wv37NYnLgl7SDlcfmKt8e/E2vYPCY2v2P3OH9vI4vH5bOlHptWdbJ5LGyYyuyx
        eUm9x+6bDWwevc3v2Dx2tt5n9Xi/7yqbx/otV1k8JmzeyOrxeZOcR/uBbqYAgSg9m6L80pJU
        hYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jC/XljMW7HCumHNh
        CXsD42PTLkYODgkBE4njU4u7GLk4hASWMkq0HT/O2MXICRSXkfh05SM7hC0s8edaFxuILSTw
        kVHiydYciIYtjBIPH21kAxnEJqAl0djJDhIXETjIKPHzwgomEIdZoIlV4vibDrBuYQE7idt9
        h8E2sAioSiya1cECYvMKWEncadwPtVleYual7+wgQ5kFNCXW79KHKBGUODnzCVg5M1BJ89bZ
        zBAPKEnMvqwH0Vkr8er+bsYJjEKzEJpnIWmehaR5ASPzKkaR1NLi3PTcYiO94sTc4tK8dL3k
        /NxNjMC0s+3Yzy07GFe++qh3iJGJg/EQowQHs5IIr0FFQ5IQb0piZVVqUX58UWlOavEhRlOg
        ZyYyS4km5wMTX15JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5Pf
        Sq0cTz3faXu570XmOPQuMzr12GH2jQrTWL3q/bqZMRxH/t38d+jLMd+zO1Smv6g9VqzMbjRZ
        MS7C1u1eIVMDm4Xu0ajDMSzf+9McL81wKvvOHaH48iB/ezhndPiGnrXH31xIZFMOnLPl64af
        HBEcC8zbLC3XvGRmMU89N4lf7VFOlbrxnegTKvZ3fyatrF/Xcr3qO5MVT9pSr9+yp++pnrjq
        7GLrLvep0XRB6p/NMoeTM59pshqtuLB/rZNQgtoFKdHPquum3NrxP33hcpGbgorvFfaf49nP
        3qRyQemIjkauWoOo0yalb9GH5vD0dHIXlzqzxpyZxnP1yPlHpfM3xAZqnP98uuyH/OsGZyWW
        4oxEQy3mouJEAJGsXffEAwAA
X-CMS-MailID: 20220516133922eucas1p1c891cd1d82539b4e792acb5d1aa74444
X-Msg-Generator: CA
X-RootMTR: 20220516133922eucas1p1c891cd1d82539b4e792acb5d1aa74444
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516133922eucas1p1c891cd1d82539b4e792acb5d1aa74444
References: <CGME20220516133922eucas1p1c891cd1d82539b4e792acb5d1aa74444@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Background and Motivation:

The zone storage implementation in Linux, introduced since v4.10, first
targetted SMR drives which have a power of 2 (po2) zone size alignment
requirement. The po2 zone size was further imposed implicitly by the
block layer's blk_queue_chunk_sectors(), used to prevent IO merging
across chunks beyond the specified size, since v3.16 through commit
762380ad9322 ("block: add notion of a chunk size for request merging").
But this same general block layer po2 requirement for blk_queue_chunk_sectors()
was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
to be non-power-of-2").

NAND, which is the media used in newer zoned storage devices, does not
naturally align to po2. In these devices, zone cap is not the same as the
po2 zone size. When the zone cap != zone size, then unmapped LBAs are
introduced to cover the space between the zone cap and zone size. po2
requirement does not make sense for these type of zone storage devices.
This patch series aims to remove these unmapped LBAs for zoned devices when
zone cap is npo2. This is done by relaxing the po2 zone size constraint
in the kernel and allowing zoned device with npo2 zone sizes if zone cap
== zone size.

Removing the po2 requirement from zone storage should be possible
now provided that no userspace regression and no performance regressions are
introduced. Stop-gap patches have been already merged into f2fs-tools to
proactively not allow npo2 zone sizes until proper support is added [0].
Additional kernel stop-gap patches are provided in this series for dm-zoned.
Support for npo2 zonefs and btrfs support is addressed in this series.

There was an effort previously [1] to add support to non po2 devices via
device level emulation but that was rejected with a final conclusion
to add support for non po2 zoned device in the complete stack[2].

- Patchset description:
This patchset aims at adding support to non power of 2 zoned devices in
the block layer, nvme layer, null blk and adds support to btrfs and
zonefs.

This round of patches **will not** support DM layer for non
power of 2 zoned devices. More about this in the future work section.

Patches 1-2 deals with removing the po2 constraint from the
block layer.

Patches 3-4 deals with removing the constraint from nvme zns.

Patches 5-9 adds support to btrfs for non po2 zoned devices.

Patch 10 removes the po2 constraint in ZoneFS

Patch 11-12 removes the po2 contraint in null blk

Patches 13 adds conditions to not allow non power of 2 devices in
DM.

The patch series is based on linux-next tag: next-20220502

- Performance:
PO2 zone sizes utilizes log and shifts instead of division when
determing alignment, zone number, etc. The same math cannot be used when
using a zoned device with non po2 zone size. Hence, to avoid any performance
regression on zoned devices with po2 zone sizes, the optimized math in the
hot paths has been retained with branching.

The performance was measured using null blk for regression
and the results have been posted in the appropriate commit log. No
performance regression was noticed.

- Testing
With respect to testing we need to tackle two things: one for regression
on po2 zoned device and progression on non po2 zoned devices.

kdevops (https://github.com/mcgrof/kdevops) was extensively used to
automate the testing for blktests and (x)fstests for btrfs changes. The
known failures were excluded during the test based on the baseline
v5.17.0-rc7

-- regression
Emulated zoned device with zone size =128M , nr_zones = 10000

Block and nvme zns:
blktests were run with no new failures

Btrfs:
Changes were tested with the following profile in QEMU:
[btrfs_simple_zns]
TEST_DIR=<dir>
SCRATCH_MNT=<mnt>
FSTYP=btrfs
MKFS_OPTIONS="-f -d single -m single"
TEST_DEV=<dev>
SCRATCH_DEV_POOL=<dev-pool>

No new failures were observed in btrfs, generic and shared test suite

ZoneFS:
zonefs-tests-nullblk.sh and zonefs-tests.sh from zonefs-tools were run
with no failures.

nullblk:
t/zbd/run-tests-against-nullb from fio was run with no failures.

DM:
It was verified if dm-zoned successfully mounts without any
error.

-- progression
Emulated zoned device with zone size = 96M , nr_zones = 10000

Block and nvme zns:
blktests were run with no new failures

Btrfs:
Same profile as po2 zone size was used.

Many tests in xfstests for btrfs included dm-flakey and some tests
required dm-linear. As they are not supported at the moment for non
po2 devices, those **tests were excluded for non po2 devices**.

No new failures were observed in btrfs, generic and shared test suite

ZoneFS:
zonefs-tests.sh from zonefs-tools were run with no failures.

nullblk:
A new section was added to cover non po2 devices:

section14()
{
       conv_pcnt=10
       zone_size=3
       zone_capacity=3
       max_open=${set_max_open}
       zbd_test_opts+=("-o ${max_open}")
}
t/zbd/run-tests-against-nullb from fio was run with no failures.

DM:
It was verified that dm-zoned does not mount.

- Tools:
Some tools had to be updated to support non po2 devices. Once these
patches are accepted in the kernel, these tool updates will also be
upstreamed.
* btrfs-prog: https://github.com/Panky-codes/btrfs-progs/tree/remove-po2-btrfs
* blkzone: https://github.com/Panky-codes/util-linux/tree/remove-po2
* zonefs-tools: https://github.com/Panky-codes/zonefs-tools/tree/remove-po2

- Future work
To reduce the amount of changes and testing, support for DM was
excluded in this round of patches. The plan is to add support to F2FS
and DM in the forthcoming future.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=6afcf6493578e77528abe65ab8b12f3e1c16749f
[1] https://lore.kernel.org/all/20220310094725.GA28499@lst.de/T/
[2] https://lore.kernel.org/all/20220315135245.eqf4tqngxxb7ymqa@unifi/

Changes since v1:
- Put the function declaration and its usage in the same commit (Bart)
- Remove bdev_zone_aligned function (Bart)
- Change the name from blk_queue_zone_aligned to blk_queue_is_zone_start
  (Damien)
- q is never null in from bdev_get_queue (Damien)
- Add condition during bringup and check for zsze == zcap for npo2
  drives (Damien)
- Rounddown operation should be made generic to work in 32 bits arch
  (bart)
- Add comments where generic calculation is directly used instead having
  special handling for po2 zone sizes (Hannes)
- Make the minimum zone size alignment requirement for btrfs to be 1M
  instead of BTRFS_STRIPE_LEN(David)

Changes since v2:
- Minor formatting changes

Changes since v3:
- Make superblock mirror align with the existing superblock log offsets
  (David)
- DM change return value and remove extra newline (Damien and Mike)
- Optimize null blk zone index lookup with shift for po2 zone size
  (Damien)

Luis Chamberlain (1):
  dm-zoned: ensure only power of 2 zone sizes are allowed

Pankaj Raghav (12):
  block: make blkdev_nr_zones and blk_queue_zone_no generic for npo2
    zsze
  block: allow blk-zoned devices to have non-power-of-2 zone size
  nvme: zns: Allow ZNS drives that have non-power_of_2 zone size
  nvmet: Allow ZNS target to support non-power_of_2 zone sizes
  btrfs: zoned: Cache superblock location in btrfs_zoned_device_info
  btrfs: zoned: Make sb_zone_number function non power of 2 compatible
  btrfs: zoned: use generic btrfs zone helpers to support npo2 zoned
    devices
  btrfs:zoned: make sb for npo2 zone devices align with sb log offsets
  btrfs: zoned: relax the alignment constraint for zoned devices
  zonefs: allow non power of 2 zoned devices
  null_blk: allow non power of 2 zoned devices
  null_blk: use zone_size_sects_shift for power of 2 zoned devices

 block/blk-core.c                  |   3 +-
 block/blk-zoned.c                 |  40 +++++--
 drivers/block/null_blk/main.c     |   5 +-
 drivers/block/null_blk/null_blk.h |   6 +
 drivers/block/null_blk/zoned.c    |  20 ++--
 drivers/md/dm-zone.c              |  12 ++
 drivers/nvme/host/zns.c           |  24 ++--
 drivers/nvme/target/zns.c         |   2 +-
 fs/btrfs/volumes.c                |  24 ++--
 fs/btrfs/zoned.c                  | 191 +++++++++++++++++++++---------
 fs/btrfs/zoned.h                  |  44 ++++++-
 fs/zonefs/super.c                 |   6 +-
 fs/zonefs/zonefs.h                |   1 -
 include/linux/blkdev.h            |  37 +++++-
 14 files changed, 303 insertions(+), 112 deletions(-)

-- 
2.25.1

