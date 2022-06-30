Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4288B5615EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiF3JOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiF3JOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:14:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29E8240BD;
        Thu, 30 Jun 2022 02:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O78+PXr+/vRNNfMOz4Yb2KznlTwvP67uZxl5Ojqy8HKxYLG6/N4NJDn9smRnrauVi/qZJWY2HxK41iYJtzhBVHAnt5KzYZ7L825KNuTg8wPpSDwhEBCKPCFBq0OXvN9Ud2SZ5FrMHHh8+CU0RVmcSrOPCOZWgpThGaDXpQ7ZT+yP+F3OuBIkMquw4gPe1i+eTqpTmiHY73V4S1DhheyBPuyURC68tE6Yr/eSoZF12OXqkKQKIwxn8bQ7DjvTP8g/x3vsUwcpbU2W5oGy3P1sr7mSJrNK4/lwRD3JxGQaMPSPdUT2FjwXptIeQs/AJdvn/+UEHDYrn79FVg6Vr8EFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIKYgSi8FEB/8bYaiu7+YXsjGTNBlPiCSGf24gXOvP0=;
 b=c1yFad5iqED7PWvjrvExCjG8RVw6h+d1GN0mvgpucgHR/19Ir7LyYKLXkKzh48ZOvzRISRTDWAI00ZYuX9/vl/5zv7H3vPoF2i+SjLkJUzBdOAhos3BOM3APIN2LHPqSyBEGzViGcIy6DGY/DaJqCbFYNU2JkPNYDcBvZisX77GUYxsGI/kDhopDMNuMGvQgd/2NhGCWjnEnNMf8/a0VI5v+VQoOzyLv446obUzAHOpTwz7AucmxOvQNNBUibupSKwEb7sM+k0liT3+0CVI4JetUy276UGMWuf1Ea70JdgnWrHFfH19SD4WaJONm2YGDZYgPFoLl+JKh3j5vghPFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIKYgSi8FEB/8bYaiu7+YXsjGTNBlPiCSGf24gXOvP0=;
 b=XT4AqCgKnjZhOq7UysnjA48CUcBpJktVwwptG1hE0Aj4Z5sgdSyJjm02HPzIeeqY4T2qRT+FYARF7mUJGsT00KBfQrre9CWO8uJLg4yUoRmLaZjW6G32VXsZApRghisKFRUmQIuORj+YFCCkfuUCnT+2cLpysEPYgcjzV/GrvqxYzJ1n6Inj5wTWMKFYyBWiKi8If85ryLm3Z+JAD71NfqAqPij8fuP5oqCRHtEWRaGTbIpwfrc2A39pzLnqobhhq6yn7AYKMHonRIhmh03cYFDDxQEebVz/ApBCCSiTqjP/Wh3bNqL9ss+aRcfij8iI+jcV/ug852zgVV9hqkekHQ==
Received: from MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::13)
 by DM5PR1201MB0153.namprd12.prod.outlook.com (2603:10b6:4:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 09:14:17 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::c6) by MW4P221CA0008.outlook.office365.com
 (2603:10b6:303:8b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 09:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 09:14:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 30 Jun
 2022 09:14:17 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 30 Jun
 2022 02:14:15 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <agk@redhat.com>, <song@kernel.org>,
        <djwong@kernel.org>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <viro@zeniv.linux.org.uk>,
        <javier@javigon.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <dongli.zhang@oracle.com>,
        <ming.lei@redhat.com>, <willy@infradead.org>,
        <jefflexu@linux.alibaba.com>, <josef@toxicpanda.com>, <clm@fb.com>,
        <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jlayton@kernel.org>,
        <idryomov@gmail.com>, <danil.kipnis@cloud.ionos.com>,
        <ebiggers@google.com>, <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Date:   Thu, 30 Jun 2022 02:14:00 -0700
Message-ID: <20220630091406.19624-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 628ae762-7407-4cae-de06-08da5a78e8d6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0153:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6/CSXdVuDm4VgZZ7KnSaQw8/9wahZ/W4fqekKNVqoE7rR3EvjUreUjly9M0k?=
 =?us-ascii?Q?x8w55tIIulIQgcLfIiyKLcQOkB8PZmwuhGxJIVb1r/FSntQ2/goUb3uLu7Up?=
 =?us-ascii?Q?/4bPebu4yZGb68Hv2ZGpBav1bbrAcEWW7mC8l4u2gy4iQr9soB4IZ7gkAsec?=
 =?us-ascii?Q?ew7NmekiujRNUo0SMF8ymzpXpfO3lH1NSkGTGkDSu4u07lrwkfvcpDrrvVRb?=
 =?us-ascii?Q?FKp+vmPW9adHOknDpYSxXuqE4JByBYZfJrnZ0WHiViiMY514rO6T2Yc3IGOS?=
 =?us-ascii?Q?Hg6iKP59W5jddhHn2+Y/XBiljqYpn+iEA5uwcNu4KIb9laGPARLNH5BeER+c?=
 =?us-ascii?Q?Lk2MpkGR0bAg0tGyOGMe/CvnoDzbd50X7U0MV/vY6hSVEJICNbA2KErMl21k?=
 =?us-ascii?Q?LQQH5/fE8rCgkFZltS99Z5ZrOom87ATkymfZnbjXtA8IeMX6TK5neGMbC4xH?=
 =?us-ascii?Q?mfeemEfw7irMF+PPwA1ysf9w24O/BQH1j09KI8YAuESicU3fIvlbxORhH9d1?=
 =?us-ascii?Q?Nh0w94DWnAJbS/sCFs1C3hgik2ZmnxrOr3I8/qu8RVtOgTdgnWvcbriAXQzf?=
 =?us-ascii?Q?P3ZwlIj6AvQYFFb9pAtxUW+KdpDTaxLGPihv6+iPx46Gy4s85LmRXnrAV6T6?=
 =?us-ascii?Q?uzL+j77f1sYPv3hIClq8ZdAZ9NG6FtEbicHZaBO/e5auPm6504nuV8+xwW+2?=
 =?us-ascii?Q?2WH41naOf59uRnIpVNEuDOgriK5HWocvJSVkw64Qoskvgx/PSTVebced+QUt?=
 =?us-ascii?Q?iYq1zq/krZHzJKF55Kk+wXMC73C7ILOK9rxfLC8w97/4hCaTFtTN/NLFYVUv?=
 =?us-ascii?Q?FA4O2tBirONHWMfjhd0iAd8Z7Q4LG03qbOhE8O6Vy8BPkCfNOekyvGp9HgEL?=
 =?us-ascii?Q?0uc9cim3ILJMChqapq9O7s8jCufpNR+1B8Y/0pq42adM1HrqGYGWUmcwb4D0?=
 =?us-ascii?Q?V5ZRsmR5ddN61ZSXNSBKjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(40470700004)(36840700001)(47076005)(82310400005)(356005)(83380400001)(30864003)(107886003)(8936002)(2906002)(36756003)(5660300002)(16526019)(7406005)(186003)(1076003)(110136005)(2616005)(426003)(336012)(54906003)(316002)(81166007)(7416002)(966005)(36860700001)(8676002)(70206006)(4326008)(70586007)(7696005)(40480700001)(40460700003)(6666004)(82740400003)(478600001)(26005)(41300700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:14:17.3911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628ae762-7407-4cae-de06-08da5a78e8d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0153
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This adds support for the REQ_OP_VERIFY. In this version we add
support for block layer. NVMe host side, NVMeOF Block device backend,
and NVMeOF File device backend and null_blk driver.

In this version we also add a new blkverify userspace tool along with
the testcases patch for the util-linux, this patch will be followed
by the this series.

Below is the summary of testlog :-

1. NVMeOF bdev-ns null_blk verify=0 (triggering bdev emulation code) :-
-----------------------------------------------------------------------

linux-block (for-next) # blkverify -o 0 -l 40960 /dev/nvme1n1 
linux-block (for-next) # dmesg -c 
[ 1171.171536] nvmet: nvmet_bdev_emulate_verify_work 467
linux-block (for-next) # nvme verify -s 0 -c 1024 /dev/nvme1n1  
NVME Verify Success
linux-block (for-next) # dmesg -c 
[ 1199.322161] nvmet: nvmet_bdev_emulate_verify_work 467

2. NVMeOF bdev-ns null_blk verify=1.
-----------------------------------------------------------------------

linux-block (for-next) # blkverify -o 0 -l 40960 /dev/nvme1n1 
linux-block (for-next) # dmesg -c 
[ 1257.661548] nvmet: nvmet_bdev_execute_verify 506
[ 1257.661558] null_blk: null_process_cmd 1406
linux-block (for-next) # nvme verify -s 0 -c 1024 /dev/nvme1n1  
NVME Verify Success
linux-block (for-next) # dmesg -c 
[ 1269.613415] nvmet: nvmet_bdev_execute_verify 506
[ 1269.613425] null_blk: null_process_cmd 1406

3. NVMeOF file-ns :-
-----------------------------------------------------------------------

linux-block (for-next) # blkverify -o 0 -l 40960 /dev/nvme1n1 
linux-block (for-next) # dmesg -c 
[ 3452.675959] nvme_setup_verify 844
[ 3452.675969] nvmet: nvmet_file_execute_verify 525
[ 3452.675971] nvmet: nvmet_file_emulate_verify_work 502
[ 3452.675972] nvmet: do_direct_io_emulate_verify 431
linux-block (for-next) # nvme verify -s 0 -c 1024 /dev/nvme1n1
NVME Verify Success
linux-block (for-next) # dmesg  -c 
[ 3459.794385] nvmet: nvmet_file_execute_verify 525
[ 3459.794389] nvmet: nvmet_file_emulate_verify_work 502
[ 3459.794391] nvmet: do_direct_io_emulate_verify 431

4. NVMe PCIe device.
-----------------------------------------------------------------------

linux-block (for-next) # modprobe nvme
linux-block (for-next) # blkverify -o 0 -l 40960 /dev/nvme0n1
linux-block (for-next) # dmesg  -c
[ 2763.432194] nvme nvme0: pci function 0000:00:04.0
[ 2763.473827] nvme nvme0: 48/0/0 default/read/poll queues
[ 2763.478868] nvme nvme0: Ignoring bogus Namespace Identifiers
[ 2766.583923] nvme_setup_verify 844

Here is a link for the complete cover-letter for the background to save
reviewer's time :-
https://patchwork.kernel.org/project/dm-devel/cover/20211104064634.4481-1-chaitanyak@nvidia.com/

-ck

Chaitanya Kulkarni (6):
  block: add support for REQ_OP_VERIFY
  nvme: add support for the Verify command
  nvmet: add Verify command support for bdev-ns
  nvmet: add Verify emulation support for bdev-ns
  nvmet: add verify emulation support for file-ns
  null_blk: add REQ_OP_VERIFY support

 Documentation/ABI/stable/sysfs-block |  12 +++
 block/blk-core.c                     |   5 +
 block/blk-lib.c                      | 155 +++++++++++++++++++++++++++
 block/blk-merge.c                    |  18 ++++
 block/blk-settings.c                 |  17 +++
 block/blk-sysfs.c                    |   8 ++
 block/blk.h                          |   4 +
 block/ioctl.c                        |  35 ++++++
 drivers/block/null_blk/main.c        |  20 +++-
 drivers/block/null_blk/null_blk.h    |   1 +
 drivers/nvme/host/core.c             |  33 ++++++
 drivers/nvme/target/admin-cmd.c      |   3 +-
 drivers/nvme/target/core.c           |  14 ++-
 drivers/nvme/target/io-cmd-bdev.c    |  75 +++++++++++++
 drivers/nvme/target/io-cmd-file.c    | 152 ++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h          |   4 +-
 include/linux/bio.h                  |   9 +-
 include/linux/blk_types.h            |   2 +
 include/linux/blkdev.h               |  22 ++++
 include/linux/nvme.h                 |  19 ++++
 include/uapi/linux/fs.h              |   1 +
 21 files changed, 601 insertions(+), 8 deletions(-)

-- 
2.29.0

######################## NVMeOF bdev-ns null_blk verify=0 ######################

0 directories, 0 files
linux-block (for-next) # ./bdev.sh 1
++ FILE=/dev/nvme0n1
++ NN=1
++ NQN=testnqn
++ let NR_DEVICES=NN+1
++ modprobe -r null_blk
++ modprobe null_blk nr_devices=0 verify=0
++ modprobe nvme
++ modprobe nvme-fabrics
++ modprobe nvmet
++ modprobe nvme-loop
++ dmesg -c
++ sleep 2
++ tree /sys/kernel/config
/sys/kernel/config
├── nullb
│   └── features
└── nvmet
    ├── hosts
    ├── ports
    └── subsystems

5 directories, 1 file
++ mkdir /sys/kernel/config/nvmet/subsystems/testnqn
++ mkdir /sys/kernel/config/nvmet/ports/1/
++ echo -n loop
++ echo -n 1
++ ln -s /sys/kernel/config/nvmet/subsystems/testnqn /sys/kernel/config/nvmet/ports/1/subsystems/
++ sleep 1
++ echo transport=loop,nqn=testnqn
+++ shuf -i 1-1 -n 1
++ for i in `shuf -i  1-$NN -n $NN`
++ mkdir config/nullb/nullb1
++ echo 4096
++ echo 20971520
++ echo 1
+++ cat config/nullb/nullb1/index
++ IDX=0
++ mkdir /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1
++ let IDX=IDX+1
++ echo ' ####### /dev/nullb1'
 ####### /dev/nullb1
++ echo -n /dev/nullb1
++ cat /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1/device_path
/dev/nullb1
++ echo 1
++ dmesg -c
[ 1150.985720] nvmet: creating nvm controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:7f5b83f1-b258-4300-9a55-cd1902bea8c2.
[ 1150.985882] nvme nvme1: creating 48 I/O queues.
[ 1150.990654] nvme nvme1: new ctrl: "testnqn"
[ 1150.995681] null_blk: disk nullb1 created
[ 1150.998886] nvmet: adding nsid 1 to subsystem testnqn
[ 1151.000716] nvme nvme1: rescanning namespaces.
++ sleep 1
++ mount
++ column -t
++ grep nvme
++ '[' 1 ']'
+++ wc -l
+++ ls -l /dev/nvme1 /dev/nvme1n1
++ cnt=2
++ echo 2
2
++ '[' 2 -gt 1 ']'
++ break
++ dmesg -c
linux-block (for-next) # blkverify -o 0 -l 40960 /dev/nvme1n1 
linux-block (for-next) # dmesg -c 
[ 1171.171536] nvmet: nvmet_bdev_emulate_verify_work 467
linux-block (for-next) # nvme verify -s 0 -c 1024 /dev/nvme1n1  
NVME Verify Success
linux-block (for-next) # dmesg -c 
[ 1199.322161] nvmet: nvmet_bdev_emulate_verify_work 467
linux-block (for-next) # ./delete.sh 1
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 1 controller(s)

real	0m0.343s
user	0m0.002s
sys	0m0.003s
++ shuf -i 1-1 -n 1
+ for i in `shuf -i  1-$NN -n $NN`
+ echo 0
+ rmdir /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1
+ rmdir config/nullb/nullb1
+ sleep 2
+ rm -fr /sys/kernel/config/nvmet/ports/1/subsystems/testnqn
+ sleep 1
+ rmdir /sys/kernel/config/nvmet/ports/1
+ rmdir /sys/kernel/config/nvmet/subsystems/testnqn
+ sleep 1
+ modprobe -r nvme_loop
+ modprobe -r nvme_fabrics
+ modprobe -r nvmet
+ modprobe -r nvme
+ modprobe -r null_blk
+ umount /mnt/nvme0n1
umount: /mnt/nvme0n1: no mount point specified.
+ umount /mnt/backend
umount: /mnt/backend: not mounted.
+ tree /sys/kernel/config
/sys/kernel/config

0 directories, 0 files

######################## NVMeOF bdev-ns null_blk verify=1 #####################

linux-block (for-next) # ./bdev.sh 1
++ FILE=/dev/nvme0n1
++ NN=1
++ NQN=testnqn
++ let NR_DEVICES=NN+1
++ modprobe -r null_blk
++ modprobe null_blk nr_devices=0 verify=1
++ modprobe nvme
++ modprobe nvme-fabrics
++ modprobe nvmet
++ modprobe nvme-loop
++ dmesg -c
++ sleep 2
++ tree /sys/kernel/config
/sys/kernel/config
├── nullb
│   └── features
└── nvmet
    ├── hosts
    ├── ports
    └── subsystems

5 directories, 1 file
++ mkdir /sys/kernel/config/nvmet/subsystems/testnqn
++ mkdir /sys/kernel/config/nvmet/ports/1/
++ echo -n loop
++ echo -n 1
++ ln -s /sys/kernel/config/nvmet/subsystems/testnqn /sys/kernel/config/nvmet/ports/1/subsystems/
++ sleep 1
++ echo transport=loop,nqn=testnqn
+++ shuf -i 1-1 -n 1
++ for i in `shuf -i  1-$NN -n $NN`
++ mkdir config/nullb/nullb1
++ echo 4096
++ echo 20971520
++ echo 1
+++ cat config/nullb/nullb1/index
++ IDX=0
++ mkdir /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1
++ let IDX=IDX+1
++ echo ' ####### /dev/nullb1'
 ####### /dev/nullb1
++ echo -n /dev/nullb1
++ cat /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1/device_path
/dev/nullb1
++ echo 1
++ dmesg -c
[ 1250.311632] nvmet: creating nvm controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:328bb18d-3662-48eb-8bc2-ca7d4ad73799.
[ 1250.311853] nvme nvme1: creating 48 I/O queues.
[ 1250.316251] nvme nvme1: new ctrl: "testnqn"
[ 1250.321710] null_blk: disk nullb1 created
[ 1250.324678] nvmet: adding nsid 1 to subsystem testnqn
[ 1250.326546] nvme nvme1: rescanning namespaces.
++ sleep 1
++ mount
++ column -t
++ grep nvme
++ '[' 1 ']'
+++ wc -l
+++ ls -l /dev/nvme1 /dev/nvme1n1
++ cnt=2
++ echo 2
2
++ '[' 2 -gt 1 ']'
++ break
++ dmesg -c
linux-block (for-next) # blkverify -o 0 -l 40960 /dev/nvme1n1 
linux-block (for-next) # dmesg -c 
[ 1257.661548] nvmet: nvmet_bdev_execute_verify 506
[ 1257.661558] null_blk: null_process_cmd 1406
linux-block (for-next) # nvme verify -s 0 -c 1024 /dev/nvme1n1  
NVME Verify Success
linux-block (for-next) # dmesg -c 
[ 1269.613415] nvmet: nvmet_bdev_execute_verify 506
[ 1269.613425] null_blk: null_process_cmd 1406
linux-block (for-next) # 
linux-block (for-next) # ./delete.sh 1
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 1 controller(s)

real	0m0.339s
user	0m0.002s
sys	0m0.003s
++ shuf -i 1-1 -n 1
+ for i in `shuf -i  1-$NN -n $NN`
+ echo 0
+ rmdir /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1
+ rmdir config/nullb/nullb1
+ sleep 2
+ rm -fr /sys/kernel/config/nvmet/ports/1/subsystems/testnqn
+ sleep 1
+ rmdir /sys/kernel/config/nvmet/ports/1
+ rmdir /sys/kernel/config/nvmet/subsystems/testnqn
+ sleep 1
+ modprobe -r nvme_loop
+ modprobe -r nvme_fabrics
+ modprobe -r nvmet
+ modprobe -r nvme
+ modprobe -r null_blk
+ umount /mnt/nvme0n1
umount: /mnt/nvme0n1: no mount point specified.
+ umount /mnt/backend
umount: /mnt/backend: not mounted.
+ tree /sys/kernel/config
/sys/kernel/config

0 directories, 0 files

################################### NVMeOF file-ns #############################

linux-block (for-next) # 
linux-block (for-next) # ./file.sh 1
++ FILE=/mnt/backend/nvme1n1
++ SS=testnqn
++ SSPATH=/sys/kernel/config/nvmet/subsystems/testnqn/
++ PORTS=/sys/kernel/config/nvmet/ports
++ main
++ load_modules
++ dmesg -c
++ modprobe nvme
++ modprobe nvme-fabrics
++ modprobe nvmet
++ modprobe nvme-loop
++ sleep 3
++ mount_fs
++ make_nullb
++ ./compile_nullb.sh
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ dmesg -c
+ modprobe -r null_blk
+ lsmod
+ grep null_blk
++ nproc
+ make -j 48 M=drivers/block modules
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/5.18.0blk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/5.18.0blk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/5.18.0blk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.1M Jun 29 17:06 /lib/modules/5.18.0blk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
++ ./compile_nullb.sh
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ dmesg -c
+ modprobe -r null_blk
+ lsmod
+ grep null_blk
++ nproc
+ make -j 48 M=drivers/block modules
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/5.18.0blk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/5.18.0blk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/5.18.0blk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.1M Jun 29 17:06 /lib/modules/5.18.0blk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
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
├── max_sectors
├── mbps
├── memory_backed
├── poll_queues
├── power
├── queue_mode
├── size
├── submit_queues
├── use_per_node_hctx
├── verify
├── virt_boundary
├── zone_capacity
├── zoned
├── zone_max_active
├── zone_max_open
├── zone_nr_conv
└── zone_size

0 directories, 27 files
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
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0
data     =                       bsize=4096   blocks=5242880, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
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
10737418240 bytes (11 GB, 10 GiB) copied, 5.01608 s, 2.1 GB/s
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
│       ├── max_sectors
│       ├── mbps
│       ├── memory_backed
│       ├── poll_queues
│       ├── power
│       ├── queue_mode
│       ├── size
│       ├── submit_queues
│       ├── use_per_node_hctx
│       ├── verify
│       ├── virt_boundary
│       ├── zone_capacity
│       ├── zoned
│       ├── zone_max_active
│       ├── zone_max_open
│       ├── zone_nr_conv
│       └── zone_size
└── nvmet
    ├── hosts
    ├── ports
    └── subsystems

6 directories, 28 files
++ mkdir /sys/kernel/config/nvmet/subsystems/testnqn/
++ for i in 1
++ mkdir /sys/kernel/config/nvmet/subsystems/testnqn//namespaces/1
++ echo -n /mnt/backend/nvme1n1
++ cat /sys/kernel/config/nvmet/subsystems/testnqn//namespaces/1/device_path
/mnt/backend/nvme1n1
++ cat /sys/kernel/config/nvmet/subsystems/testnqn//namespaces/1/buffered_io
0
++ echo 1
++ mkdir /sys/kernel/config/nvmet/ports/1/
++ echo -n loop
++ echo -n 1
++ ln -s /sys/kernel/config/nvmet/subsystems/testnqn/ /sys/kernel/config/nvmet/ports/1/subsystems/
++ sleep 1
++ connect
++ echo transport=loop,nqn=testnqn
++ sleep 1
++ dmesg -c
[ 3436.671070] null_blk: module loaded
[ 3437.678812] null_blk: disk nullb0 created
[ 3440.700250] XFS (nullb0): Mounting V5 Filesystem
[ 3440.701686] XFS (nullb0): Ending clean mount
[ 3440.701772] xfs filesystem being mounted at /mnt/backend supports timestamps until 2038 (0x7fffffff)
[ 3446.742777] nvmet: adding nsid 1 to subsystem testnqn
[ 3447.752282] nvmet: creating nvm controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:55bf9c5a-2992-4ffc-ac53-18003029a0b9.
[ 3447.752423] nvme nvme1: creating 48 I/O queues.
[ 3447.758869] nvme nvme1: new ctrl: "testnqn"
linux-block (for-next) # blkverify -o 0 -l 40960 /dev/nvme1n1 
linux-block (for-next) # dmesg -c 
[ 3452.675959] nvme_setup_verify 844
[ 3452.675969] nvmet: nvmet_file_execute_verify 525
[ 3452.675971] nvmet: nvmet_file_emulate_verify_work 502
[ 3452.675972] nvmet: do_direct_io_emulate_verify 431
linux-block (for-next) # nvme verify -s 0 -c 1024 /dev/nvme1n1
NVME Verify Success
linux-block (for-next) # dmesg  -c 
[ 3459.794385] nvmet: nvmet_file_execute_verify 525
[ 3459.794389] nvmet: nvmet_file_emulate_verify_work 502
[ 3459.794391] nvmet: do_direct_io_emulate_verify 431
linux-block (for-next) #  
linux-block (for-next) # 
linux-block (for-next) # ./delete.sh 1
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 1 controller(s)

real	0m0.338s
user	0m0.001s
sys	0m0.004s
++ shuf -i 1-1 -n 1
+ for i in `shuf -i  1-$NN -n $NN`
+ echo 0
+ rmdir /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1
+ rmdir config/nullb/nullb0
+ sleep 2
+ rm -fr /sys/kernel/config/nvmet/ports/1/subsystems/testnqn
+ sleep 1
+ rmdir /sys/kernel/config/nvmet/ports/1
+ rmdir /sys/kernel/config/nvmet/subsystems/testnqn
+ sleep 1
+ modprobe -r nvme_loop
+ modprobe -r nvme_fabrics
+ modprobe -r nvmet
+ modprobe -r nvme
+ umount /mnt/nvme0n1
umount: /mnt/nvme0n1: no mount point specified.
+ umount /mnt/backend
+ modprobe -r null_blk
+ tree /sys/kernel/config
/sys/kernel/config

0 directories, 0 files

################################# NVMe PCIe device  ###########################
linux-block (for-next) #
linux-block (for-next) #
linux-block (for-next) # modprobe nvme
linux-block (for-next) # blkverify -o 0 -l 40960 /dev/nvme0n1
linux-block (for-next) # dmesg  -c
[ 2763.432194] nvme nvme0: pci function 0000:00:04.0
[ 2763.473827] nvme nvme0: 48/0/0 default/read/poll queues
[ 2763.478868] nvme nvme0: Ignoring bogus Namespace Identifiers
[ 2766.583923] nvme_setup_verify 844
