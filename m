Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFFC444F25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 07:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhKDGuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 02:50:09 -0400
Received: from mail-dm6nam08on2054.outbound.protection.outlook.com ([40.107.102.54]:25825
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230500AbhKDGtn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:49:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DApUpF8Zi+j46SKUv+EdlEUsvPfwwUkOLOHCSxL4KYLd/QYsF0nxFJWEpnZluOtAZFKqw1LqLbS5c4ZZqFZzWJFRCYryg3Z1elqG4wepHnKF/H2F9iH4cgWDlRdlcx6+QD8a9gOC+bjfOXQMCji3CSNYRatMoCabnugJTUkt1YBooHMfHHhNn/1hDNo+4V9eNyQJDFWcJobZAfRBjxNk7Qe85bwF+QGeNNnnUD4Xxj+DWYpyTKN0EtXfE5VfsRTwl4uRSrmvh0J6zgCFgFa4ppOtIbzKS18tPzDbbGZQu7cefQs7lNbKwdMDsKDNjerRVbiNbOtFvoelrYcanLVesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iEQ/rt67k9ECy13OX30OzlkR241cB6sh3ET7GgF/Vo=;
 b=jyyXRn8uJKTIUyspYv8GAutDpEM2oFzq84B31WQmPEKpt6BBzJQpYBPDAcxpWjFI/YWzNlqtWqmrFSBGlqQsUETWQCaxZEdKEMtda2bpudaH3IQJJP7Hc2FaA3vyQVGuKOYBD8sBQMv7UvAs4cgXCNVYQfIp6YHp9+BpCfwVgxZO3NnRqK+JP+XhjG5cn1+2CiIPiK518TuqIR20zAFSkkjAquJEaDkSrj0RQnKSNDne0ta0E8AX/5xCpS0JZAYlJ9U9ghtoDvx+iNcB3WwD/OlAOsj8SP16MxohNg2UYn3CcxYe6puzxvJ3h2aQJuyY2zodkycswkulgNb5UjooxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iEQ/rt67k9ECy13OX30OzlkR241cB6sh3ET7GgF/Vo=;
 b=RZ8hX2iWnuZEfwDOIbGTz+uxc2Nk80atCvyZgwYlyLRq737iOglq9bDshFcxwGOLs9NZaeDeRfYij5Imdk8ajvSGay0rKoyjxYcjiP75yJ0HYHwoutV9Qn79tzpGnc81tZb91vGwuHdK+NjK8E6AIaHheY3EIBRGkzs3ietUmSuTibdBGpHSaDKuQVUew+o6e6Xy/PdSKomlC4FJaNbiGlSilVcy+YyDXbqOXAVireuJ7bgT39XoD2wxoxI+vPkg5er57MxikrLQDicMxNA+QRWecgsGcrUCDM+76HlWVgNFKHxnEU92RzkNXBx2Gm73dWChCHLt16koyxeXUp/dcA==
Received: from MWHPR14CA0001.namprd14.prod.outlook.com (2603:10b6:300:ae::11)
 by DM4PR12MB5150.namprd12.prod.outlook.com (2603:10b6:5:391::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 06:47:02 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::72) by MWHPR14CA0001.outlook.office365.com
 (2603:10b6:300:ae::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 06:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 06:47:01 +0000
Received: from dev.nvidia.com (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 4 Nov
 2021 06:46:41 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <axboe@kernel.dk>, <agk@redhat.com>, <snitzer@redhat.com>,
        <song@kernel.org>, <djwong@kernel.org>, <kbusch@kernel.org>,
        <hch@lst.de>, <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <viro@zeniv.linux.org.uk>,
        <javier@javigon.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <dongli.zhang@oracle.com>,
        <ming.lei@redhat.com>, <osandov@fb.com>, <willy@infradead.org>,
        <jefflexu@linux.alibaba.com>, <josef@toxicpanda.com>, <clm@fb.com>,
        <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jlayton@kernel.org>,
        <idryomov@gmail.com>, <danil.kipnis@cloud.ionos.com>,
        <ebiggers@google.com>, <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Date:   Wed, 3 Nov 2021 23:46:26 -0700
Message-ID: <20211104064634.4481-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a20a2234-53eb-469a-7a97-08d99f5ee800
X-MS-TrafficTypeDiagnostic: DM4PR12MB5150:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51502EF0B776FDDACF4345CCA38D9@DM4PR12MB5150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdjtRpDCYty+J3NCtbnKeGwpxp5xPGdO02phQglohz0f35znGx/j4Do0S5uy8eP/QV0HbrNC0tt53ch53RlvD1SXMeTCWjWThFmrX2uD6q/jlAhZA24VeGqg2HEl235NfvfNye6S8ERw9adKLm1Mz826J80C7C95VAHbWh+0cNB3WBzD7OXqh0jdxMRjl9FX9pmKkfCHEJSWC8X57tUTd8g7s1SCAJww+G/AQ+4kOftZWzgySP7rhvY71IXfhJ+UwaqqdietzlAhUtcF+7Yfum0IGVEtsFA4IQEF05s1VWlqhr+8+38AAt4/jDenBR3V4cDL0RI5gguCOw+WGPovSz2NXnkBoH+O8qO9s0O9BAphxKECCJI5AWyono3yIKMq7vYiQO+C+G99ZshAbbn1mHyfF40KIFlxHWQgFcdC8B6m2QIsVQJazEnG9cWVbSOp7VwSNvg9smgELili1h2OyXYrg9l3GOZUU4IqrUb2XqZtM3qxBKzZ4L3xpIZcJvGppjAU/XqdPvbcmQDIItwfdPQNEKuS1Wt2ruqR5O32s1EDQUeQ4Yp9s9eqg1GUINXexIGxqxaop04/Dm7TRArS6/GZJUUm9lBBdLIImQsDDO4DeZKFuw6DpukQVlDazdzNNCoQs+gh6sE/h5ZV0ymlAnu1DcRy3bHprVqXYuoDYTSgBwC12G5Yz5eQcQ45Q+Zr3OhHsQv9ppsDgkoOeO792s+6ksqeKAMGtidO0mseZqZhkV789DJp41OhG4POPhikkFYgTm68PtTElH4ZvYdMyOmsEF2ZyfCzrcrmA/q62JA=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(508600001)(54906003)(7416002)(1076003)(26005)(82310400003)(47076005)(2906002)(316002)(7406005)(966005)(5660300002)(16526019)(8936002)(36756003)(426003)(30864003)(107886003)(186003)(8676002)(2616005)(83380400001)(70586007)(70206006)(4326008)(36860700001)(7636003)(356005)(110136005)(7696005)(86362001)(6666004)(2101003)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 06:47:01.6534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20a2234-53eb-469a-7a97-08d99f5ee800
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Hi,

One of the responsibilities of the Operating System, along with managing
resources, is to provide a unified interface to the user by creating
hardware abstractions. In the Linux Kernel storage stack that
abstraction is created by implementing the generic request operations
such as REQ_OP_READ/REQ_OP_WRITE or REQ_OP_DISCARD/REQ_OP_WRITE_ZEROES,
etc that are mapped to the specific low-level hardware protocol commands 
e.g. SCSI or NVMe.

With that in mind, this RFC patch-series implements a new block layer
operation to offload the data verification on to the controller if
supported or emulate the operation if not. The main advantage is to free
up the CPU and reduce the host link traffic since, for some devices,
their internal bandwidth is higher than the host link and offloading this
operation can improve the performance of the proactive error detection
applications such as file system level scrubbing. 

* Background *
-----------------------------------------------------------------------

NVMe Specification provides a controller level Verify command [1] which
is similar to the ATA Verify [2] command where the controller is
responsible for data verification without transferring the data to the
host. (Offloading LBAs verification). This is designed to proactively
discover any data corruption issues when the device is free so that
applications can protect sensitive data and take corrective action
instead of waiting for failure to occur.

The NVMe Verify command is added in order to provide low level media
scrubbing and possibly moving the data to the right place in case it has
correctable media degradation. Also, this provides a way to enhance
file-system level scrubbing/checksum verification and optinally offload
this task, which is CPU intensive, to the kernel (when emulated), over
the fabric, and to the controller (when supported).   

This is useful when the controller's internal bandwidth is higher than
the host's bandwith showing a sharp increase in the performance due to
_no host traffic or host CPU involvement_.

* Implementation *
-----------------------------------------------------------------------

Right now there is no generic interface which can be used by the
in-kernel components such as file-system or userspace application
(except passthru commands or some combination of write/read/compare) to 
issue verify command with the central block layer API. This can lead to
each userspace applications having protocol specific IOCTL which
defeates the purpose of having the OS provide a H/W abstraction.

This patch series introduces a new block layer payloadless request
operation REQ_OP_VERIFY that allows in-kernel components & userspace
applications to verify the range of the LBAs by offloading checksum
scrubbing/verification to the controller that is directly attached to
the host. For direct attached devices this leads to decrease in the host
DMA traffic and CPU usage and for the fabrics attached device over the
network that leads to a decrease in the network traffic and CPU usage
for both host & target.

* Scope *
-----------------------------------------------------------------------

Please note this only covers the operating system level overhead.
Analyzing controller verify command performance for common protocols
(SCSI/NVMe) is out of scope for REQ_OP_VERIFY.

* Micro Benchmarks *
-----------------------------------------------------------------------

When verifing 500GB of data on NVMeOF with nvme-loop and null_blk as a
target backend block device results show almost a 80% performance
increase :-

With Verify resulting in REQ_OP_VERIFY to null_blk :-

real	2m3.773s
user	0m0.000s
sys	0m59.553s

With Emulation resulting in REQ_OP_READ null_blk :-

real	12m18.964s
user	0m0.002s
sys	1m15.666s


A detailed test log is included at the end of the cover letter.
Each of the following was tested:

1. Direct Attached REQ_OP_VERIFY.
2. Fabrics Attached REQ_OP_VERIFY.
3. Multi-device (md) REQ_OP_VERIFY.

* The complete picture *
-----------------------------------------------------------------------

  For the completeness the whole kernel stack support is divided into
  two phases :-
 
  Phase I :-
 
   Add and stabilize the support for the Block layer & low level drivers
   such as SCSI, NVMe, MD, and NVMeOF, implement necessary emulations in
   the block layer if needed and provide block level tools such as 
   _blkverify_. Also, add appropriate testcases for code-coverage.

  Phase II :-
 
   Add and stabilize the support for upper layer kernel components such
   as file-systems and provide userspace tools such _fsverify_ to route
   the request from file systems to block layer to Low level device
   drivers.


Please note that the interfaces for blk-lib.c REQ_OP_VERIFY emulation
will change in future I put together for the scope of RFC.

Any comments are welcome.

-ck

References:-

[1] NVMe Verify :-

For pro-actively avoiding unrecoverable read errors, NVMe 1.4 adds
Verify and Get LBA Status commands. The Verify command is simple: it
does everything a normal read command does, except for returning the
data to the host system. If a read command would return an error, a
verify command will return the same error. If a read command would be
successful, a verify command will be as well. This makes it possible to
do a low-level scrub of the stored data without being bottlenecked by
the host interface bandwidth. Some SSDs will react to a fixable ECC
error by moving or re-writing degraded data, and a verify command
should trigger the same behavior. Overall, this should reduce the need
for filesystem-level checksum scrubbing/verification. Each Verify
command is tagged with a bit indicating whether the SSD should fail
fast or try hard to recover data, similar to but overriding the above
Read Recovery Level setting.

[2]

http://t13.org/Documents/UploadedDocuments/docs2017/di529r18-ATAATAPI_Command_Set_-_4.pdf


Chaitanya Kulkarni (8):
  block: add support for REQ_OP_VERIFY
  scsi: add REQ_OP_VERIFY support
  nvme: add support for the Verify command
  nvmet: add Verify command support for bdev-ns
  nvmet: add Verify emulation support for bdev-ns
  nvmet: add verify emulation support for file-ns
  null_blk: add REQ_OP_VERIFY support
  md: add support for REQ_OP_VERIFY

 Documentation/ABI/testing/sysfs-block |  14 ++
 block/blk-core.c                      |   5 +
 block/blk-lib.c                       | 192 ++++++++++++++++++++++++++
 block/blk-merge.c                     |  19 +++
 block/blk-settings.c                  |  17 +++
 block/blk-sysfs.c                     |   8 ++
 block/blk-zoned.c                     |   1 +
 block/bounce.c                        |   1 +
 block/ioctl.c                         |  35 +++++
 drivers/block/null_blk/main.c         |  25 +++-
 drivers/block/null_blk/null_blk.h     |   1 +
 drivers/md/dm-core.h                  |   1 +
 drivers/md/dm-io.c                    |   8 +-
 drivers/md/dm-linear.c                |  11 +-
 drivers/md/dm-mpath.c                 |   1 +
 drivers/md/dm-rq.c                    |   3 +
 drivers/md/dm-stripe.c                |   1 +
 drivers/md/dm-table.c                 |  36 +++++
 drivers/md/dm.c                       |  31 +++++
 drivers/md/md-linear.c                |  10 ++
 drivers/md/md-multipath.c             |   1 +
 drivers/md/md.h                       |   7 +
 drivers/md/raid10.c                   |   1 +
 drivers/md/raid5.c                    |   1 +
 drivers/nvme/host/core.c              |  39 ++++++
 drivers/nvme/target/admin-cmd.c       |   3 +-
 drivers/nvme/target/core.c            |  12 +-
 drivers/nvme/target/io-cmd-bdev.c     |  74 ++++++++++
 drivers/nvme/target/io-cmd-file.c     | 151 ++++++++++++++++++++
 drivers/nvme/target/nvmet.h           |   3 +
 drivers/scsi/sd.c                     |  52 +++++++
 drivers/scsi/sd.h                     |   1 +
 include/linux/bio.h                   |  10 +-
 include/linux/blk_types.h             |   2 +
 include/linux/blkdev.h                |  31 +++++
 include/linux/device-mapper.h         |   6 +
 include/linux/nvme.h                  |  19 +++
 include/uapi/linux/fs.h               |   1 +
 38 files changed, 824 insertions(+), 10 deletions(-)


----------------------------------------------------------------------------
1. NVMeOF Block device backend with null_blk verify=1 support :-
----------------------------------------------------------------------------
# ./bdev.sh 1
++ FILE=/dev/nullb0
++ modprobe -r null_blk
++ modprobe null_blk verify=1 gb=50
++ modprobe nvme
++ modprobe nvme-fabrics
++ modprobe nvmet
++ dmesg -c > /dev/null
++ sleep 3
++ tree /sys/kernel/config
/sys/kernel/config
├── nullb
│   └── features
└── nvmet
    ├── hosts
    ├── ports
    └── subsystems

5 directories, 1 file
++ mkdir /sys/kernel/config/nvmet/subsystems/fs
++ for i in 1
++ mkdir /sys/kernel/config/nvmet/subsystems/fs/namespaces/1
++ echo -n /dev/nullb0
++ cat /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/device_path
/dev/nullb0
++ echo 1
++ mkdir /sys/kernel/config/nvmet/ports/1/
++ echo -n loop
++ echo -n 1
++ ln -s /sys/kernel/config/nvmet/subsystems/fs /sys/kernel/config/nvmet/ports/1/subsystems/
++ sleep 1
++ echo transport=loop,nqn=fs
++ sleep 1
++ mount
++ column -t
++ grep nvme
++ dmesg -c
[12826.608855] nvmet: adding nsid 1 to subsystem fs
[12827.680593] nvmet: creating controller 1 for subsystem fs for NQN nqn.2014-08.org.nvmexpress:uuid:ec41afad-329f-4453-b10c-628ad87d6558.
[12827.682760] nvme nvme1: creating 12 I/O queues.
[12827.693358] nvme nvme1: new ctrl: "fs"
[12827.695610] nvme1n1: detected capacity change from 0 to 53687091200
# insmod host/test_verify.ko 
# dmesg -c 
[13104.730748] TEST:     REQ_OP_VERIFY sect     0 nr_sect  2048
[13104.730805] nvme:     REQ_OP_VERIFY sect     0 nr_sect  2041 insmod
[13104.731268] nvmet:    REQ_OP_VERIFY sect     0 nr_sect  2041 kworker/2:2
[13104.731384] null_blk: REQ_OP_VERIFY sect     0 nr_sect  2041 kworker/2:1H
[13104.731432] nvme:     REQ_OP_VERIFY sect  2041 nr_sect     7 kworker/2:1H
[13104.731443] nvmet:    REQ_OP_VERIFY sect  2041 nr_sect     7 kworker/2:2
[13104.731458] null_blk: REQ_OP_VERIFY sect  2041 nr_sect     7 kworker/2:1H
[13104.731524] ----------------------------------------------------------
[13104.731526] TEST:     REQ_OP_VERIFY sect  2048 nr_sect  2048
[13104.731542] nvme:     REQ_OP_VERIFY sect  2048 nr_sect  2041 insmod
[13104.731555] nvme:     REQ_OP_VERIFY sect  4089 nr_sect     7 kworker/2:1H
[13104.731564] nvmet:    REQ_OP_VERIFY sect  2048 nr_sect  2041 kworker/2:2
[13104.731577] nvmet:    REQ_OP_VERIFY sect  4089 nr_sect     7 kworker/2:2
[13104.731620] null_blk: REQ_OP_VERIFY sect  2048 nr_sect  2041 kworker/2:1H
[13104.731625] null_blk: REQ_OP_VERIFY sect  4089 nr_sect     7 kworker/2:1H
[13104.731675] ----------------------------------------------------------
[13104.731678] TEST:     REQ_OP_VERIFY sect  4096 nr_sect  2048
[13104.731694] nvme:     REQ_OP_VERIFY sect  4096 nr_sect  2041 insmod
[13104.731709] nvme:     REQ_OP_VERIFY sect  6137 nr_sect     7 kworker/2:1H
[13104.731716] nvmet:    REQ_OP_VERIFY sect  4096 nr_sect  2041 kworker/2:2
[13104.731750] nvmet:    REQ_OP_VERIFY sect  6137 nr_sect     7 kworker/2:2
[13104.731766] null_blk: REQ_OP_VERIFY sect  4096 nr_sect  2041 kworker/2:1H
[13104.731771] null_blk: REQ_OP_VERIFY sect  6137 nr_sect     7 kworker/2:1H
[13104.731816] ----------------------------------------------------------
[13104.731819] TEST:     REQ_OP_VERIFY sect  6144 nr_sect  2048
[13104.731833] nvme:     REQ_OP_VERIFY sect  6144 nr_sect  2041 insmod
[13104.731847] nvme:     REQ_OP_VERIFY sect  8185 nr_sect     7 kworker/2:1H
[13104.731856] nvmet:    REQ_OP_VERIFY sect  6144 nr_sect  2041 kworker/2:2
[13104.731867] nvmet:    REQ_OP_VERIFY sect  8185 nr_sect     7 kworker/2:2
[13104.731881] null_blk: REQ_OP_VERIFY sect  6144 nr_sect  2041 kworker/2:1H
[13104.731886] null_blk: REQ_OP_VERIFY sect  8185 nr_sect     7 kworker/2:1H
[13104.731934] ----------------------------------------------------------
[13104.731936] TEST:     REQ_OP_VERIFY sect  8192 nr_sect  2048
[13104.731951] nvme:     REQ_OP_VERIFY sect  8192 nr_sect  2041 insmod
[13104.731965] nvme:     REQ_OP_VERIFY sect 10233 nr_sect     7 kworker/2:1H
[13104.731972] nvmet:    REQ_OP_VERIFY sect  8192 nr_sect  2041 kworker/2:2
[13104.731984] nvmet:    REQ_OP_VERIFY sect 10233 nr_sect     7 kworker/2:2
[13104.732019] null_blk: REQ_OP_VERIFY sect  8192 nr_sect  2041 kworker/2:1H
[13104.732024] null_blk: REQ_OP_VERIFY sect 10233 nr_sect     7 kworker/2:1H
[13104.732069] ----------------------------------------------------------

----------------------------------------------------------------------------
2. NVMeOF Block device backend with null_blk verify=0 support :-
----------------------------------------------------------------------------
# ./bdev.sh 0 
++ FILE=/dev/nullb0
++ modprobe -r null_blk
++ modprobe null_blk verify=0 gb=50
++ modprobe nvme
++ modprobe nvme-fabrics
++ modprobe nvmet
++ dmesg -c > /dev/null
++ sleep 3
++ tree /sys/kernel/config
/sys/kernel/config
├── nullb
│   └── features
└── nvmet
    ├── hosts
    ├── ports
    └── subsystems

5 directories, 1 file
++ mkdir /sys/kernel/config/nvmet/subsystems/fs
++ for i in 1
++ mkdir /sys/kernel/config/nvmet/subsystems/fs/namespaces/1
++ echo -n /dev/nullb0
++ cat /sys/kernel/config/nvmet/subsystems/fs/namespaces/1/device_path
/dev/nullb0
++ echo 1
++ mkdir /sys/kernel/config/nvmet/ports/1/
++ echo -n loop
++ echo -n 1
++ ln -s /sys/kernel/config/nvmet/subsystems/fs /sys/kernel/config/nvmet/ports/1/subsystems/
++ sleep 1
++ echo transport=loop,nqn=fs
++ sleep 1
++ mount
++ column -t
++ grep nvme
++ dmesg -c
[12826.608855] nvmet: adding nsid 1 to subsystem fs
[12827.680593] nvmet: creating controller 1 for subsystem fs for NQN nqn.2014-08.org.nvmexpress:uuid:ec41afad-329f-4453-b10c-628ad87d6558.
[12827.682760] nvme nvme1: creating 12 I/O queues.
[12827.693358] nvme nvme1: new ctrl: "fs"
[12827.695610] nvme1n1: detected capacity change from 0 to 53687091200
# insmod host/test_verify.ko 
# dmesg -c 
[13981.069911] TEST:     REQ_OP_VERIFY sect     0 nr_sect  2048
[13981.069971] nvme:     REQ_OP_VERIFY sect     0 nr_sect  2041 insmod
[13981.070240] nvme:     REQ_OP_VERIFY sect  2041 nr_sect     7 kworker/9:1H
[13981.070350] nvmet:    REQ_OP_VERIFY sect     0 nr_sect  2041 kworker/9:2
[13981.070894] null_blk: REQ_OP_READ   sect     0 nr_sect   255 kworker/9:1H
[13981.070943] null_blk: REQ_OP_READ   sect   255 nr_sect   255 kworker/9:1H
[13981.070978] null_blk: REQ_OP_READ   sect   510 nr_sect   255 kworker/9:1H
[13981.071050] null_blk: REQ_OP_READ   sect   765 nr_sect   255 kworker/9:1H
[13981.071087] null_blk: REQ_OP_READ   sect  1020 nr_sect   255 kworker/9:1H
[13981.071120] null_blk: REQ_OP_READ   sect  1275 nr_sect   255 kworker/9:1H
[13981.071155] null_blk: REQ_OP_READ   sect  1530 nr_sect   255 kworker/9:1H
[13981.071244] null_blk: REQ_OP_READ   sect  1785 nr_sect   255 kworker/9:1H
[13981.071252] null_blk: REQ_OP_READ   sect  2040 nr_sect     1 kworker/9:1H
[13981.071907] nvmet:    REQ_OP_VERIFY sect  2041 nr_sect     7 kworker/9:2
[13981.071937] null_blk: REQ_OP_READ   sect  2041 nr_sect     7 kworker/9:1H
[13981.072264] ----------------------------------------------------------
[13981.072271] TEST:     REQ_OP_VERIFY sect  2048 nr_sect  2048
[13981.072327] nvme:     REQ_OP_VERIFY sect  2048 nr_sect  2041 insmod
[13981.072381] nvme:     REQ_OP_VERIFY sect  4089 nr_sect     7 kworker/2:1H
[13981.072547] nvmet:    REQ_OP_VERIFY sect  2048 nr_sect  2041 kworker/2:1
[13981.072632] null_blk: REQ_OP_READ   sect  2048 nr_sect   255 kworker/2:1H
[13981.072754] null_blk: REQ_OP_READ   sect  2303 nr_sect   255 kworker/2:1H
[13981.072858] null_blk: REQ_OP_READ   sect  2558 nr_sect   255 kworker/2:1H
[13981.072915] null_blk: REQ_OP_READ   sect  2813 nr_sect   255 kworker/2:1H
[13981.072961] null_blk: REQ_OP_READ   sect  3068 nr_sect   255 kworker/2:1H
[13981.073052] null_blk: REQ_OP_READ   sect  3323 nr_sect   255 kworker/2:1H
[13981.073102] null_blk: REQ_OP_READ   sect  3578 nr_sect   255 kworker/2:1H
[13981.073155] null_blk: REQ_OP_READ   sect  3833 nr_sect   255 kworker/2:1H
[13981.073164] null_blk: REQ_OP_READ   sect  4088 nr_sect     1 kworker/2:1H
[13981.073861] nvmet:    REQ_OP_VERIFY sect  4089 nr_sect     7 kworker/2:1
[13981.073924] null_blk: REQ_OP_READ   sect  4089 nr_sect     7 kworker/2:1H
[13981.074754] ----------------------------------------------------------
[13981.074766] TEST:     REQ_OP_VERIFY sect  4096 nr_sect  2048
[13981.074812] nvme:     REQ_OP_VERIFY sect  4096 nr_sect  2041 insmod
[13981.074859] nvme:     REQ_OP_VERIFY sect  6137 nr_sect     7 kworker/0:1H
[13981.075035] nvmet:    REQ_OP_VERIFY sect  4096 nr_sect  2041 kworker/0:2
[13981.075103] null_blk: REQ_OP_READ   sect  4096 nr_sect   255 kworker/0:1H
[13981.075141] null_blk: REQ_OP_READ   sect  4351 nr_sect   255 kworker/0:1H
[13981.075171] null_blk: REQ_OP_READ   sect  4606 nr_sect   255 kworker/0:1H
[13981.075201] null_blk: REQ_OP_READ   sect  4861 nr_sect   255 kworker/0:1H
[13981.075230] null_blk: REQ_OP_READ   sect  5116 nr_sect   255 kworker/0:1H
[13981.075259] null_blk: REQ_OP_READ   sect  5371 nr_sect   255 kworker/0:1H
[13981.075288] null_blk: REQ_OP_READ   sect  5626 nr_sect   255 kworker/0:1H
[13981.075324] null_blk: REQ_OP_READ   sect  5881 nr_sect   255 kworker/0:1H
[13981.075329] null_blk: REQ_OP_READ   sect  6136 nr_sect     1 kworker/0:1H
[13981.076247] nvmet:    REQ_OP_VERIFY sect  6137 nr_sect     7 kworker/0:2
[13981.076294] null_blk: REQ_OP_READ   sect  6137 nr_sect     7 kworker/0:1H
[13981.076640] ----------------------------------------------------------
[13981.076645] TEST:     REQ_OP_VERIFY sect  6144 nr_sect  2048
[13981.076677] nvme:     REQ_OP_VERIFY sect  6144 nr_sect  2041 insmod
[13981.076714] nvme:     REQ_OP_VERIFY sect  8185 nr_sect     7 kworker/0:1H
[13981.076823] nvmet:    REQ_OP_VERIFY sect  6144 nr_sect  2041 kworker/0:2
[13981.076883] null_blk: REQ_OP_READ   sect  6144 nr_sect   255 kworker/0:1H
[13981.076917] null_blk: REQ_OP_READ   sect  6399 nr_sect   255 kworker/0:1H
[13981.076944] null_blk: REQ_OP_READ   sect  6654 nr_sect   255 kworker/0:1H
[13981.076969] null_blk: REQ_OP_READ   sect  6909 nr_sect   255 kworker/0:1H
[13981.077025] null_blk: REQ_OP_READ   sect  7164 nr_sect   255 kworker/0:1H
[13981.077053] null_blk: REQ_OP_READ   sect  7419 nr_sect   255 kworker/0:1H
[13981.077085] null_blk: REQ_OP_READ   sect  7674 nr_sect   255 kworker/0:1H
[13981.077122] null_blk: REQ_OP_READ   sect  7929 nr_sect   255 kworker/0:1H
[13981.077127] null_blk: REQ_OP_READ   sect  8184 nr_sect     1 kworker/0:1H
[13981.077233] nvmet:    REQ_OP_VERIFY sect  8185 nr_sect     7 kworker/0:1
[13981.077293] null_blk: REQ_OP_READ   sect  8185 nr_sect     7 kworker/0:1H
[13981.078282] ----------------------------------------------------------
[13981.078286] TEST:     REQ_OP_VERIFY sect  8192 nr_sect  2048
[13981.078318] nvme:     REQ_OP_VERIFY sect  8192 nr_sect  2041 insmod
[13981.078376] nvme:     REQ_OP_VERIFY sect 10233 nr_sect     7 kworker/0:1H
[13981.078477] nvmet:    REQ_OP_VERIFY sect  8192 nr_sect  2041 kworker/0:2
[13981.078532] null_blk: REQ_OP_READ   sect  8192 nr_sect   255 kworker/0:1H
[13981.078564] null_blk: REQ_OP_READ   sect  8447 nr_sect   255 kworker/0:1H
[13981.078596] null_blk: REQ_OP_READ   sect  8702 nr_sect   255 kworker/0:1H
[13981.078622] null_blk: REQ_OP_READ   sect  8957 nr_sect   255 kworker/0:1H
[13981.078655] null_blk: REQ_OP_READ   sect  9212 nr_sect   255 kworker/0:1H
[13981.078682] null_blk: REQ_OP_READ   sect  9467 nr_sect   255 kworker/0:1H
[13981.078709] null_blk: REQ_OP_READ   sect  9722 nr_sect   255 kworker/0:1H
[13981.078741] null_blk: REQ_OP_READ   sect  9977 nr_sect   255 kworker/0:1H
[13981.078746] null_blk: REQ_OP_READ   sect 10232 nr_sect     1 kworker/0:1H
[13981.078903] nvmet:    REQ_OP_VERIFY sect 10233 nr_sect     7 kworker/0:1
[13981.078940] null_blk: REQ_OP_READ   sect 10233 nr_sect     7 kworker/0:1H
[13981.079561] ----------------------------------------------------------


----------------------------------------------------------------------------
3. NVMeOF with File Backend with Buffered IO :-
----------------------------------------------------------------------------
# ./file.sh 
++ FILE=/mnt/backend/nvme1n1
++ SS=fs
++ SSPATH=/sys/kernel/config/nvmet/subsystems/fs/
++ PORTS=/sys/kernel/config/nvmet/ports
++ main
++ load_modules
++ modprobe nvme
++ modprobe nvme-fabrics
++ modprobe nvmet
++ modprobe nvme-loop
++ sleep 3
++ mount_fs
++ make_nullb
++ local src=drivers/block/
+++ uname -r
++ local dest=/lib/modules/5.6.0-rc7lblk+/kernel/drivers/block
++ modprobe -r null_blk
++ makej M=drivers/block/
  MODPOST 11 modules
++ cp drivers/block//null_blk.ko /lib/modules/5.6.0-rc7lblk+/kernel/drivers/block/
++ modprobe null_blk nr_devices=0
++ sleep 1
++ mkdir config/nullb/nullb0
++ tree config/nullb/nullb0
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── mbps
├── memory_backed
├── power
├── queue_mode
├── size
├── submit_queues
├── use_per_node_hctx
├── verify
├── zoned
├── zone_nr_conv
└── zone_size

0 directories, 21 files
++ echo 1
++ echo 512
++ echo 20480
++ echo 1
++ sleep 2
+++ cat config/nullb/nullb0/index
++ IDX=0
++ lsblk
++ grep null0
++ sleep 1
++ mkfs.xfs -f /dev/nullb0
meta-data=/dev/nullb0            isize=512    agcount=4, agsize=1310720 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=5242880, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
++ mount /dev/nullb0 /mnt/backend/
++ sleep 1
++ mount
++ column -t
++ grep nvme
++ dd if=/dev/zero of=/mnt/backend/nvme1n1 count=2621440 bs=4096
2621440+0 records in
2621440+0 records out
10737418240 bytes (11 GB) copied, 33.6448 s, 319 MB/s
++ file /mnt/backend/nvme1n1
/mnt/backend/nvme1n1: data
++ make_target
++ tree /sys/kernel/config
/sys/kernel/config
├── nullb
│   ├── features
│   └── nullb0
│       ├── badblocks
│       ├── blocking
│       ├── blocksize
│       ├── cache_size
│       ├── completion_nsec
│       ├── discard
│       ├── home_node
│       ├── hw_queue_depth
│       ├── index
│       ├── irqmode
│       ├── mbps
│       ├── memory_backed
│       ├── power
│       ├── queue_mode
│       ├── size
│       ├── submit_queues
│       ├── use_per_node_hctx
│       ├── verify
│       ├── zoned
│       ├── zone_nr_conv
│       └── zone_size
└── nvmet
    ├── hosts
    ├── ports
    └── subsystems

6 directories, 22 files
++ mkdir /sys/kernel/config/nvmet/subsystems/fs/
++ for i in 1
++ mkdir /sys/kernel/config/nvmet/subsystems/fs//namespaces/1
++ echo -n /mnt/backend/nvme1n1
++ echo 1
++ cat /sys/kernel/config/nvmet/subsystems/fs//namespaces/1/device_path
/mnt/backend/nvme1n1
++ cat /sys/kernel/config/nvmet/subsystems/fs//namespaces/1/buffered_io
1
++ echo 1
++ mkdir /sys/kernel/config/nvmet/ports/1/
++ echo -n loop
++ echo -n 1
++ ln -s /sys/kernel/config/nvmet/subsystems/fs/ /sys/kernel/config/nvmet/ports/1/subsystems/
++ sleep 1
++ connect
++ echo transport=loop,nqn=fs
++ sleep 1
#
# insmod host/test_verify.ko 
# dmesg -c 
[13469.310678] TEST:     REQ_OP_VERIFY sect     0 nr_sect  2048
[13469.310777] nvme:     REQ_OP_VERIFY sect     0 nr_sect  2048 kworker/5:1H
[13469.310978] nvmet:    REQ_OP_VERIFY sect     0 nr_sect  2048 kworker/5:0
[13469.313189] ----------------------------------------------------------
[13469.313193] TEST:     REQ_OP_VERIFY sect  2048 nr_sect  2048
[13469.313230] nvme:     REQ_OP_VERIFY sect  2048 nr_sect  2048 kworker/5:1H
[13469.313272] nvmet:    REQ_OP_VERIFY sect  2048 nr_sect  2048 kworker/5:0
[13469.313916] ----------------------------------------------------------
[13469.313920] TEST:     REQ_OP_VERIFY sect  4096 nr_sect  2048
[13469.313950] nvme:     REQ_OP_VERIFY sect  4096 nr_sect  2048 kworker/5:1H
[13469.313986] nvmet:    REQ_OP_VERIFY sect  4096 nr_sect  2048 kworker/5:0
[13469.314708] ----------------------------------------------------------
[13469.314713] TEST:     REQ_OP_VERIFY sect  6144 nr_sect  2048
[13469.314746] nvme:     REQ_OP_VERIFY sect  6144 nr_sect  2048 kworker/5:1H
[13469.314784] nvmet:    REQ_OP_VERIFY sect  6144 nr_sect  2048 kworker/5:0
[13469.315425] ----------------------------------------------------------
[13469.315429] TEST:     REQ_OP_VERIFY sect  8192 nr_sect  2048
[13469.315457] nvme:     REQ_OP_VERIFY sect  8192 nr_sect  2048 kworker/5:1H
[13469.315490] nvmet:    REQ_OP_VERIFY sect  8192 nr_sect  2048 kworker/5:0
[13469.316005] ----------------------------------------------------------

XFS Trace for buffered_io() :-

     kworker/5:0-19863 [005] ...1 13469.350152: xfs_file_buffered_read: dev 252:0 ino 0x43 size 0x280000000 offset 0x0 count 0x100000
     kworker/5:0-19863 [005] ...1 13469.351960: xfs_file_buffered_read: dev 252:0 ino 0x43 size 0x280000000 offset 0x100000 count 0x100000
     kworker/5:0-19863 [005] ...1 13469.352705: xfs_file_buffered_read: dev 252:0 ino 0x43 size 0x280000000 offset 0x200000 count 0x100000
     kworker/5:0-19863 [005] ...1 13469.353472: xfs_file_buffered_read: dev 252:0 ino 0x43 size 0x280000000 offset 0x300000 count 0x100000
     kworker/5:0-19863 [005] ...1 13469.354177: xfs_file_buffered_read: dev 252:0 ino 0x43 size 0x280000000 offset 0x400000 count 0x100000

----------------------------------------------------------------------------
4. NVMeOF with File Backend with DIRECT IO :-
----------------------------------------------------------------------------
# ./file.sh 
++ FILE=/mnt/backend/nvme1n1
++ SS=fs
++ SSPATH=/sys/kernel/config/nvmet/subsystems/fs/
++ PORTS=/sys/kernel/config/nvmet/ports
++ main
++ load_modules
++ modprobe nvme
++ modprobe nvme-fabrics
++ modprobe nvmet
++ modprobe nvme-loop
++ sleep 3
++ mount_fs
++ make_nullb
++ local src=drivers/block/
+++ uname -r
++ local dest=/lib/modules/5.6.0-rc7lblk+/kernel/drivers/block
++ modprobe -r null_blk
++ makej M=drivers/block/
  MODPOST 11 modules
++ cp drivers/block//null_blk.ko /lib/modules/5.6.0-rc7lblk+/kernel/drivers/block/
++ modprobe null_blk nr_devices=0
++ sleep 1
++ mkdir config/nullb/nullb0
++ tree config/nullb/nullb0
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── mbps
├── memory_backed
├── power
├── queue_mode
├── size
├── submit_queues
├── use_per_node_hctx
├── verify
├── zoned
├── zone_nr_conv
└── zone_size

0 directories, 21 files
++ echo 1
++ echo 512
++ echo 20480
++ echo 1
++ sleep 2
+++ cat config/nullb/nullb0/index
++ IDX=0
++ lsblk
++ grep null0
++ sleep 1
++ mkfs.xfs -f /dev/nullb0
meta-data=/dev/nullb0            isize=512    agcount=4, agsize=1310720 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=5242880, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
++ mount /dev/nullb0 /mnt/backend/
++ sleep 1
++ mount
++ column -t
++ grep nvme
++ dd if=/dev/zero of=/mnt/backend/nvme1n1 count=2621440 bs=4096
2621440+0 records in
2621440+0 records out
10737418240 bytes (11 GB) copied, 33.7626 s, 318 MB/s
++ file /mnt/backend/nvme1n1
/mnt/backend/nvme1n1: data
++ make_target
++ tree /sys/kernel/config
/sys/kernel/config
├── nullb
│   ├── features
│   └── nullb0
│       ├── badblocks
│       ├── blocking
│       ├── blocksize
│       ├── cache_size
│       ├── completion_nsec
│       ├── discard
│       ├── home_node
│       ├── hw_queue_depth
│       ├── index
│       ├── irqmode
│       ├── mbps
│       ├── memory_backed
│       ├── power
│       ├── queue_mode
│       ├── size
│       ├── submit_queues
│       ├── use_per_node_hctx
│       ├── verify
│       ├── zoned
│       ├── zone_nr_conv
│       └── zone_size
└── nvmet
    ├── hosts
    ├── ports
    └── subsystems

6 directories, 22 files
++ mkdir /sys/kernel/config/nvmet/subsystems/fs/
++ for i in 1
++ mkdir /sys/kernel/config/nvmet/subsystems/fs//namespaces/1
++ echo -n /mnt/backend/nvme1n1
++ echo 0
++ cat /sys/kernel/config/nvmet/subsystems/fs//namespaces/1/device_path
/mnt/backend/nvme1n1
++ cat /sys/kernel/config/nvmet/subsystems/fs//namespaces/1/buffered_io
0
++ echo 1
++ mkdir /sys/kernel/config/nvmet/ports/1/
++ echo -n loop
++ echo -n 1
++ ln -s /sys/kernel/config/nvmet/subsystems/fs/ /sys/kernel/config/nvmet/ports/1/subsystems/
++ sleep 1
++ connect
++ echo transport=loop,nqn=fs
++ sleep 1
# 
# insmod host/test_verify.ko 
# dmesg  -c 
# Since XFS doesn't have the verify interface it will go as read operation
# to the null_blk device on which we have formatted xfs.
[13254.855110] TEST:     REQ_OP_VERIFY sect     0 nr_sect  2048
[13254.855183] nvme:     REQ_OP_VERIFY sect     0 nr_sect  2048 kworker/4:1H
[13254.855318] nvmet:    REQ_OP_VERIFY sect     0 nr_sect  2048 kworker/4:1
[13254.857858] null_blk: REQ_OP_READ   sect   128 nr_sect   255 kworker/4:1H
[13254.857901] null_blk: REQ_OP_READ   sect   383 nr_sect   255 kworker/4:1H
[13254.857965] null_blk: REQ_OP_READ   sect   638 nr_sect   255 kworker/4:1H
[13254.858031] null_blk: REQ_OP_READ   sect   893 nr_sect   255 kworker/4:1H
[13254.858069] null_blk: REQ_OP_READ   sect  1148 nr_sect   255 kworker/4:1H
[13254.858105] null_blk: REQ_OP_READ   sect  1403 nr_sect   255 kworker/4:1H
[13254.858132] null_blk: REQ_OP_READ   sect  1658 nr_sect   255 kworker/4:1H
[13254.858156] null_blk: REQ_OP_READ   sect  1913 nr_sect   255 kworker/4:1H
[13254.858194] null_blk: REQ_OP_READ   sect  2168 nr_sect     8 kworker/4:1H
[13254.859882] ----------------------------------------------------------
[13254.859885] TEST:     REQ_OP_VERIFY sect  2048 nr_sect  2048
[13254.859912] nvme:     REQ_OP_VERIFY sect  2048 nr_sect  2048 kworker/4:1H
[13254.859929] nvmet:    REQ_OP_VERIFY sect  2048 nr_sect  2048 kworker/4:1
[13254.862603] null_blk: REQ_OP_READ   sect  2176 nr_sect   255 kworker/4:1H
[13254.862647] null_blk: REQ_OP_READ   sect  2431 nr_sect   255 kworker/4:1H
[13254.862674] null_blk: REQ_OP_READ   sect  2686 nr_sect   255 kworker/4:1H
[13254.862699] null_blk: REQ_OP_READ   sect  2941 nr_sect   255 kworker/4:1H
[13254.862728] null_blk: REQ_OP_READ   sect  3196 nr_sect   255 kworker/4:1H
[13254.862754] null_blk: REQ_OP_READ   sect  3451 nr_sect   255 kworker/4:1H
[13254.862780] null_blk: REQ_OP_READ   sect  3706 nr_sect   255 kworker/4:1H
[13254.862813] null_blk: REQ_OP_READ   sect  3961 nr_sect   255 kworker/4:1H
[13254.862839] null_blk: REQ_OP_READ   sect  4216 nr_sect     8 kworker/4:1H
[13254.864087] ----------------------------------------------------------
[13254.864090] TEST:     REQ_OP_VERIFY sect  4096 nr_sect  2048
[13254.864115] nvme:     REQ_OP_VERIFY sect  4096 nr_sect  2048 kworker/4:1H
[13254.864131] nvmet:    REQ_OP_VERIFY sect  4096 nr_sect  2048 kworker/4:1
[13254.866647] null_blk: REQ_OP_READ   sect  4224 nr_sect   255 kworker/4:1H
[13254.866678] null_blk: REQ_OP_READ   sect  4479 nr_sect   255 kworker/4:1H
[13254.866703] null_blk: REQ_OP_READ   sect  4734 nr_sect   255 kworker/4:1H
[13254.866728] null_blk: REQ_OP_READ   sect  4989 nr_sect   255 kworker/4:1H
[13254.866754] null_blk: REQ_OP_READ   sect  5244 nr_sect   255 kworker/4:1H
[13254.866780] null_blk: REQ_OP_READ   sect  5499 nr_sect   255 kworker/4:1H
[13254.866806] null_blk: REQ_OP_READ   sect  5754 nr_sect   255 kworker/4:1H
[13254.866833] null_blk: REQ_OP_READ   sect  6009 nr_sect   255 kworker/4:1H
[13254.866861] null_blk: REQ_OP_READ   sect  6264 nr_sect     8 kworker/4:1H
[13254.868067] ----------------------------------------------------------
[13254.868071] TEST:     REQ_OP_VERIFY sect  6144 nr_sect  2048
[13254.868095] nvme:     REQ_OP_VERIFY sect  6144 nr_sect  2048 kworker/4:1H
[13254.868110] nvmet:    REQ_OP_VERIFY sect  6144 nr_sect  2048 kworker/4:1
[13254.870599] null_blk: REQ_OP_READ   sect  6272 nr_sect   255 kworker/4:1H
[13254.870631] null_blk: REQ_OP_READ   sect  6527 nr_sect   255 kworker/4:1H
[13254.870657] null_blk: REQ_OP_READ   sect  6782 nr_sect   255 kworker/4:1H
[13254.870681] null_blk: REQ_OP_READ   sect  7037 nr_sect   255 kworker/4:1H
[13254.870706] null_blk: REQ_OP_READ   sect  7292 nr_sect   255 kworker/4:1H
[13254.870732] null_blk: REQ_OP_READ   sect  7547 nr_sect   255 kworker/4:1H
[13254.870758] null_blk: REQ_OP_READ   sect  7802 nr_sect   255 kworker/4:1H
[13254.870782] null_blk: REQ_OP_READ   sect  8057 nr_sect   255 kworker/4:1H
[13254.870837] null_blk: REQ_OP_READ   sect  8312 nr_sect     8 kworker/4:1H
[13254.871956] ----------------------------------------------------------
[13254.871959] TEST:     REQ_OP_VERIFY sect  8192 nr_sect  2048
[13254.871982] nvme:     REQ_OP_VERIFY sect  8192 nr_sect  2048 kworker/4:1H
[13254.872045] nvmet:    REQ_OP_VERIFY sect  8192 nr_sect  2048 kworker/4:1
[13254.874532] null_blk: REQ_OP_READ   sect  8320 nr_sect   255 kworker/4:1H
[13254.874562] null_blk: REQ_OP_READ   sect  8575 nr_sect   255 kworker/4:1H
[13254.874588] null_blk: REQ_OP_READ   sect  8830 nr_sect   255 kworker/4:1H
[13254.874613] null_blk: REQ_OP_READ   sect  9085 nr_sect   255 kworker/4:1H
[13254.874638] null_blk: REQ_OP_READ   sect  9340 nr_sect   255 kworker/4:1H
[13254.874664] null_blk: REQ_OP_READ   sect  9595 nr_sect   255 kworker/4:1H
[13254.874689] null_blk: REQ_OP_READ   sect  9850 nr_sect   255 kworker/4:1H
[13254.874715] null_blk: REQ_OP_READ   sect 10105 nr_sect   255 kworker/4:1H
[13254.874741] null_blk: REQ_OP_READ   sect 10360 nr_sect     8 kworker/4:1H
[13254.875852] ----------------------------------------------------------

----------------------------------------------------------------------------
5. DM Linear testing:-
----------------------------------------------------------------------------
 # ./nullbtests-md.sh 
+ lvremove /dev/nullbvg/nullblv
  Volume group "nullbvg" not found
  Cannot process volume group nullbvg
+ vgremove nullbvg
  Volume group "nullbvg" not found
  Cannot process volume group nullbvg
+ pvremove /dev/nullb0p1 /dev/nullb1p1
  Device /dev/nullb0p1 not found.
  Device /dev/nullb1p1 not found.
+ rmdir config/nullb/nullb0
rmdir: failed to remove ‘config/nullb/nullb0’: No such file or directory
+ rmdir config/nullb/nullb1
rmdir: failed to remove ‘config/nullb/nullb1’: No such file or directory
+ modprobe -r null_blk
+ modprobe null_blk nr_devices=0 verify=1
+ declare -a arr
+ for i in 0 1
+ NULLB_DIR=config/nullb/nullb0
+ mkdir config/nullb/nullb0
+ tree config/nullb/nullb0
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── max_sectors
├── mbps
├── memory_backed
├── power
├── queue_mode
├── size
├── submit_queues
├── use_per_node_hctx
├── verify
├── zone_capacity
├── zoned
├── zone_max_active
├── zone_max_open
├── zone_nr_conv
└── zone_size

0 directories, 25 files
+ sleep 1
+ echo 1
+ echo 512
+ echo 10
+ echo 1
+ echo 1
++ cat config/nullb/nullb0/index
+ IDX=0
+ sleep 1
+ sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/'
+ fdisk /dev/nullb0
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0x2e1ae160.

Command (m for help): Building a new DOS disklabel with disk identifier 0x8e36dee5.

Command (m for help): Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): Partition number (1-4, default 1): First sector (2048-20479, default 2048): Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-20479, default 20479): Using default value 20479
Partition 1 of type Linux and of size 9 MiB is set

Command (m for help): Selected partition 1
Hex code (type L to list all codes): Changed type of partition 'Linux' to 'Linux LVM'

Command (m for help): 
Disk /dev/nullb0: 10 MB, 10485760 bytes, 20480 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x8e36dee5

       Device Boot      Start         End      Blocks   Id  System
/dev/nullb0p1            2048       20479        9216   8e  Linux LVM

Command (m for help): The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
+ sleep 1
+ partprobe
+ sleep 1
+ pvcreate /dev/nullb0p1
  Physical volume "/dev/nullb0p1" successfully created.
+ sleep 1
+ for i in 0 1
+ NULLB_DIR=config/nullb/nullb1
+ mkdir config/nullb/nullb1
+ tree config/nullb/nullb1
config/nullb/nullb1
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── max_sectors
├── mbps
├── memory_backed
├── power
├── queue_mode
├── size
├── submit_queues
├── use_per_node_hctx
├── verify
├── zone_capacity
├── zoned
├── zone_max_active
├── zone_max_open
├── zone_nr_conv
└── zone_size

0 directories, 25 files
+ sleep 1
+ echo 1
+ echo 512
+ echo 10
+ echo 1
+ echo 1
++ cat config/nullb/nullb1/index
+ IDX=1
+ sleep 1
+ sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/'
+ fdisk /dev/nullb1
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0x3bd84b2f.

Command (m for help): Building a new DOS disklabel with disk identifier 0x0a6925a3.

Command (m for help): Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): Partition number (1-4, default 1): First sector (2048-20479, default 2048): Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-20479, default 20479): Using default value 20479
Partition 1 of type Linux and of size 9 MiB is set

Command (m for help): Selected partition 1
Hex code (type L to list all codes): Changed type of partition 'Linux' to 'Linux LVM'

Command (m for help): 
Disk /dev/nullb1: 10 MB, 10485760 bytes, 20480 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x0a6925a3

       Device Boot      Start         End      Blocks   Id  System
/dev/nullb1p1            2048       20479        9216   8e  Linux LVM

Command (m for help): The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
+ sleep 1
+ partprobe
+ sleep 1
+ pvcreate /dev/nullb1p1
  Physical volume "/dev/nullb1p1" successfully created.
+ sleep 1
+ vgcreate nullbvg /dev/nullb0p1 /dev/nullb1p1
  Volume group "nullbvg" successfully created
+ lvcreate -l 4 -n nullblv nullbvg
  Logical volume "nullblv" created.
+ sleep 1
+ dmesg -c
[  120.577643] null_blk: module loaded
[  123.061186]  nullb0: p1
[  125.213856]  nullb0: p1
[  130.441883]  nullb1: p1
[  132.628551]  nullb1: p1
[  132.636132]  nullb0: p1
[  134.858680] REQ_OP_VERIFY configured success for linear id 1
[  134.858686] REQ_OP_VERIFY configured success for linear id 2
[  134.859300] dm-5: detected capacity change from 32768 to 0
[  134.859333] REQ_OP_VERIFY configured success for linear id 1
[  134.859335] REQ_OP_VERIFY configured success for linear id 2
# ll  /dev/dm-5 
brw-------. 1 root root 253, 5 Feb  4 20:58 /dev/dm-5
# lsblk 
NAME                MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
nvme0n1             259:0    0    1G  0 disk 
nullb1              252:1    0   10M  0 disk 
└─nullb1p1          259:2    0    9M  0 part 
  └─nullbvg-nullblv 253:5    0   16M  0 lvm  
nullb0              252:0    0   10M  0 disk 
└─nullb0p1          259:1    0    9M  0 part 
  └─nullbvg-nullblv 253:5    0   16M  0 lvm  
# ls /dev/mapper/nullbvg-nullblv 
/dev/mapper/nullbvg-nullblv
# dmsetup info  /dev/dm-5  
Name:              nullbvg-nullblv
State:             ACTIVE
Read Ahead:        8192
Tables present:    LIVE
Open count:        0
Event number:      0
Major, minor:      253, 5
Number of targets: 2
UUID: LVM-mLiPnf25we1YKmZ6MMH3ruL7lThYYuuZRzOOYup42smajuTyV3T1ZAMhHZ7x4e6G

# insmod host/test.ko nblk=16 dev_path="/dev/dm-5"
# dmesg -c 

[  132.965714] TEST: REQ_OP_VERIFY sector 0 nr_sect 2048
[  132.965740] is_abnormal_io 1512
[  132.965763] dmrg: REQ_OP_VERIFY sect  2048 nr_sect  2048 nullb0 insmod linear_map_bio
[  132.965831] null_blk: REQ_OP_VERIFY sect  4096 nr_sect  2048 kworker/61:1H
[  132.965936] ----------------------------------------------------------
[  132.965940] TEST: REQ_OP_VERIFY sector 2048 nr_sect 2048
[  132.965949] is_abnormal_io 1512
[  132.965957] dmrg: REQ_OP_VERIFY sect  4096 nr_sect  2048 nullb0 insmod linear_map_bio
[  132.965987] null_blk: REQ_OP_VERIFY sect  6144 nr_sect  2048 kworker/61:1H
[  132.966058] ----------------------------------------------------------
[  132.966062] TEST: REQ_OP_VERIFY sector 4096 nr_sect 2048
[  132.966070] is_abnormal_io 1512
[  132.966078] dmrg: REQ_OP_VERIFY sect  6144 nr_sect  2048 nullb0 insmod linear_map_bio
[  132.966107] null_blk: REQ_OP_VERIFY sect  8192 nr_sect  2048 kworker/61:1H
[  132.966176] ----------------------------------------------------------
[  132.966180] TEST: REQ_OP_VERIFY sector 6144 nr_sect 2048
[  132.966188] is_abnormal_io 1512
[  132.966196] dmrg: REQ_OP_VERIFY sect  8192 nr_sect  2048 nullb0 insmod linear_map_bio
[  132.966224] null_blk: REQ_OP_VERIFY sect 10240 nr_sect  2048 kworker/61:1H
[  132.966293] ----------------------------------------------------------
[  132.966297] TEST: REQ_OP_VERIFY sector 8192 nr_sect 2048
[  132.966305] is_abnormal_io 1512
[  132.966313] dmrg: REQ_OP_VERIFY sect 10240 nr_sect  2048 nullb0 insmod linear_map_bio
[  132.966340] null_blk: REQ_OP_VERIFY sect 12288 nr_sect  2048 kworker/61:1H
[  132.966408] ----------------------------------------------------------
[  132.966412] TEST: REQ_OP_VERIFY sector 10240 nr_sect 2048
[  132.966420] is_abnormal_io 1512
[  132.966428] dmrg: REQ_OP_VERIFY sect 12288 nr_sect  2048 nullb0 insmod linear_map_bio
[  132.966454] null_blk: REQ_OP_VERIFY sect 14336 nr_sect  2048 kworker/61:1H
[  132.966574] ----------------------------------------------------------
[  132.966578] TEST: REQ_OP_VERIFY sector 12288 nr_sect 2048
[  132.966587] is_abnormal_io 1512
[  132.966595] dmrg: REQ_OP_VERIFY sect 14336 nr_sect  2048 nullb0 insmod linear_map_bio
[  132.966625] null_blk: REQ_OP_VERIFY sect 16384 nr_sect  2048 kworker/61:1H
[  132.966697] ----------------------------------------------------------
[  132.966701] TEST: REQ_OP_VERIFY sector 14336 nr_sect 2048
[  132.966709] is_abnormal_io 1512
[  132.966717] dmrg: REQ_OP_VERIFY sect 16384 nr_sect  2048 nullb0 insmod linear_map_bio
[  132.966744] null_blk: REQ_OP_VERIFY sect 18432 nr_sect  2048 kworker/61:1H
[  132.966813] ----------------------------------------------------------
[  132.966817] TEST: REQ_OP_VERIFY sector 16384 nr_sect 2048
[  132.966825] is_abnormal_io 1512
[  132.966834] dmrg: REQ_OP_VERIFY sect  2048 nr_sect  2048 nullb1 insmod linear_map_bio
[  132.966869] null_blk: REQ_OP_VERIFY sect  4096 nr_sect  2048 kworker/61:1H
[  132.966938] ----------------------------------------------------------
[  132.966942] TEST: REQ_OP_VERIFY sector 18432 nr_sect 2048
[  132.966950] is_abnormal_io 1512
[  132.966958] dmrg: REQ_OP_VERIFY sect  4096 nr_sect  2048 nullb1 insmod linear_map_bio
[  132.966985] null_blk: REQ_OP_VERIFY sect  6144 nr_sect  2048 kworker/61:1H
[  132.967053] ----------------------------------------------------------
[  132.967057] TEST: REQ_OP_VERIFY sector 20480 nr_sect 2048
[  132.967065] is_abnormal_io 1512
[  132.967073] dmrg: REQ_OP_VERIFY sect  6144 nr_sect  2048 nullb1 insmod linear_map_bio
[  132.967100] null_blk: REQ_OP_VERIFY sect  8192 nr_sect  2048 kworker/61:1H
[  132.967169] ----------------------------------------------------------
[  132.967174] TEST: REQ_OP_VERIFY sector 22528 nr_sect 2048
[  132.967181] is_abnormal_io 1512
[  132.967188] dmrg: REQ_OP_VERIFY sect  8192 nr_sect  2048 nullb1 insmod linear_map_bio
[  132.967206] null_blk: REQ_OP_VERIFY sect 10240 nr_sect  2048 kworker/61:1H
[  132.967251] ----------------------------------------------------------
[  132.967254] TEST: REQ_OP_VERIFY sector 24576 nr_sect 2048
[  132.967259] is_abnormal_io 1512
[  132.967264] dmrg: REQ_OP_VERIFY sect 10240 nr_sect  2048 nullb1 insmod linear_map_bio
[  132.967281] null_blk: REQ_OP_VERIFY sect 12288 nr_sect  2048 kworker/61:1H
[  132.967326] ----------------------------------------------------------
[  132.967329] TEST: REQ_OP_VERIFY sector 26624 nr_sect 2048
[  132.967335] is_abnormal_io 1512
[  132.967340] dmrg: REQ_OP_VERIFY sect 12288 nr_sect  2048 nullb1 insmod linear_map_bio
[  132.967360] null_blk: REQ_OP_VERIFY sect 14336 nr_sect  2048 kworker/61:1H
[  132.967404] ----------------------------------------------------------
[  132.967409] TEST: REQ_OP_VERIFY sector 28672 nr_sect 2048
[  132.967413] is_abnormal_io 1512
[  132.967417] dmrg: REQ_OP_VERIFY sect 14336 nr_sect  2048 nullb1 insmod linear_map_bio
[  132.967431] null_blk: REQ_OP_VERIFY sect 16384 nr_sect  2048 kworker/61:1H
[  132.967468] ----------------------------------------------------------
[  132.967470] TEST: REQ_OP_VERIFY sector 30720 nr_sect 2048
[  132.967477] is_abnormal_io 1512
[  132.967482] dmrg: REQ_OP_VERIFY sect 16384 nr_sect  2048 nullb1 insmod linear_map_bio
[  132.967496] null_blk: REQ_OP_VERIFY sect 18432 nr_sect  2048 kworker/61:1H
[  132.967567] ----------------------------------------------------------
-- 
2.22.1


