Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA6528B35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbiEPQyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbiEPQy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:29 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E518C2EA2D
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:23 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165420euoutp022a15b077c28b02d0fff550b8d1a8fe6e~vpCNzFz9A2423524235euoutp02r
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220516165420euoutp022a15b077c28b02d0fff550b8d1a8fe6e~vpCNzFz9A2423524235euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720060;
        bh=hvZC2BExXfYJApY09yHYqy7WDj10FDq7x0UvuFFdwdU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=U1LzPtGs3MXnmBXbsXJF6e5PgO1Fty5NMpScBf608eizD0lXNyXnSWeDXCHoqhN5p
         ledze9emxBnKK5JAYMoOJ5C8tZjYV7urcoaacXlCc1aAQrEr4JLNOSU9qWLOPXy5AM
         /UqqTlXYZg8tWG4OsaiauUNw2P6wml7ZS9L89HBI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516165419eucas1p12a74e9d39f2f8e8829007e148ed4b4bd~vpCMg2vpI2562625626eucas1p1V;
        Mon, 16 May 2022 16:54:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A1.40.10009.AB182826; Mon, 16
        May 2022 17:54:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef~vpCMEParL2457724577eucas1p2V;
        Mon, 16 May 2022 16:54:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220516165418eusmtrp26de94af3837140fd9bf19b57930bdc3d~vpCMDYByc1030710307eusmtrp2o;
        Mon, 16 May 2022 16:54:18 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-3c-628281ba0d40
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6A.00.09404.AB182826; Mon, 16
        May 2022 17:54:18 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165418eusmtip1e0164c9f903476b3ff30c12c38f4c769~vpCLvJAf82383423834eusmtip1m;
        Mon, 16 May 2022 16:54:18 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH v4 00/13] support non power of 2 zoned devices
Date:   Mon, 16 May 2022 18:54:03 +0200
Message-Id: <20220516165416.171196-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87q7GpuSDFbNsbZYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbf4
        vLSF3WLNzacsDnwe/06sYfPYOesuu8fls6Uem5fUe+y+2QAUab3P6vF+31U2j74tqxg91m+5
        yuLxeZNcAFcUl01Kak5mWWqRvl0CV8asXQfYC2Y5V2ya3c/WwHjGtIuRk0NCwETi4epjrF2M
        XBxCAisYJW53bWGBcL4wSnya8Aoq85lRYueCD2wwLT8Or2ACsYUEljNKvGpLhCh6ziixbvFa
        5i5GDg42AS2Jxk52kBoRgSyJaSceMoLUMAv8ZpR4unU2C0hCWMBO4nbfYUaQehYBVYkN7dwg
        YV4BK4lZn3pZIHbJS8y89J0dIi4ocXLmE7A4M1C8eetsZpCZEgLtnBI/Tt+EOs5FYl7/PCYI
        W1ji1fEt7BC2jMT/nfOh4tUST2/8hmpuYZTo37meDeQICQFrib4zOSAms4CmxPpd+hDljhLt
        t/ayQ1TwSdx4KwhxAp/EpG3TmSHCvBIdbUIQ1UoSO38+gVoqIXG5aQ7UJx4SPates0FCLVai
        t+0q4wRGhVlIHpuF5LFZCDcsYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZjYTv87
        /mkH49xXH/UOMTJxMB5ilOBgVhLhNahoSBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOm5y5IVFI
        ID2xJDU7NbUgtQgmy8TBKdXA1Mm8MN5DpDLYQqV6UtZJhxXVEk6Xd7DJPXLY335k0y2ply/U
        zivd84x+t6PfelH/+rcaKYbt9ocuB03O1Ztx183C0bVPUXnKXOnQbzPsv2TESXpMOPk7wuRp
        t8upCwc+LlF75/lY6m52iGujasaDCVvOf3w55XB13IZV/I8fpDqvsxK/VHUot81YqVopmzHc
        WPBDzaQu++jZO3omzZbkaPeV2TwzIOqhQM3Rf2nl/Qe/ODPqrH/V3rJ8/iuHNRNv7rIp+ub1
        ZVO0zHz5tl3lAbara24uF2GWcCtZ1HGZed/2E26hKxUtvteV/nfNuaC8Tm2lTKzUTsUzm5Vd
        mo30ftzddOKvx2+BOwfvKM1OV2Ipzkg01GIuKk4EAHpD/dDbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7q7GpuSDF5+kLVYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbf4
        vLSF3WLNzacsDnwe/06sYfPYOesuu8fls6Uem5fUe+y+2QAUab3P6vF+31U2j74tqxg91m+5
        yuLxeZNcAFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqR
        vl2CXsasXQfYC2Y5V2ya3c/WwHjGtIuRk0NCwETix+EVTF2MXBxCAksZJabeusQCkZCQuL2w
        iRHCFpb4c62LDaLoKaPEhLaLQA4HB5uAlkRjJztIjYhAgcSc/i0sIDXMAq1MEhO2zgBLCAvY
        SdzuO8wIUs8ioCqxoZ0bJMwrYCUx61Mv1C55iZmXvrODlDALaEqs36UPUSIocXLmE7ASZqCS
        5q2zmScw8s9CqJqFpGoWkqoFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiNw27GfW3Yw
        rnz1Ue8QIxMH4yFGCQ5mJRFeg4qGJCHelMTKqtSi/Pii0pzU4kOMpkBHT2SWEk3OB6aAvJJ4
        QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpgV/XY/PvVXkUf/e6v60
        tI3TQ0PfOTz1eCN2sDR3zYWrE/JP9cke+/5DXOyh9zzjF8stnRf1JbJ69e395dH4fcUvL93A
        i9LPLn3bGXwg34tpZ/6E/55nZHXUpD9Fzyk8MmtWVvtjm57V6zZuSNtS8eWVyZ+Lp06fEXm4
        677gwjR+9Yd3Ds6XZ3x+X8LSTO77pqUsgcH/a+KKk2JnvUmYUrdsm0dFKYt9yoS6cH23n6qc
        S81Nbx8oVQ2ccPiD5kPmkIlsRv/1thw5VOfvkBCqKfld4UNZ66byFVv1D33/n/PW9u3s48Up
        6+5tntFzicPpn7j5V4/CjN7XXpwqWSrHtu78Jm4u2c3C8WhJ3qLQqKNKLMUZiYZazEXFiQD9
        dMzCSQMAAA==
X-CMS-MailID: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
- DM change return value and remove extra newline
- Optimize null blk zone index lookup with shift for po2 zone size

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

