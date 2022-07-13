Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF49572EFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 09:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiGMHV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 03:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiGMHVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:21:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D54DBD6A4;
        Wed, 13 Jul 2022 00:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJXBMFV7W77J5pKkNcLkgwRtSmYVEy5VwhTFyqQw1MnjDvCuauwXvCxAbV9QhkK9Xhsj1hsoEG4b+jCCkl0r9Hj476nUta9qdvYK4+GGadamKs+EcghHNIDtgg2ZEylHfD1d6PJ8MuViRacWyZji8uiDcBGotBajsZWG0ouplWTXbKAaKeHNGQWs847jpt28DzHtKDl9SG3zGjra+Z+Ga4pMfD3ZGR6UlV63MxXPhLMGo1m+u6dtZodjgTZrdc41HGXK34rgNqrGFl5XJTm1uxBtstuGs19i85HqoOzu2wXdzg0PLQazn0V+5QKXQN4+06yfbFXBwvmfbxSw6ayQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30wO3uwCbH1dNbT1ErY4RtXTihb6khWDZ0CyQZeNbTM=;
 b=gCg+XBumRlQaO3uP/pLG8UBsQPUUJVdsPej+5SPcYCo87Iiu6QCAsLfaRtXk9vwAA7VJOypfzUIdUFs2yap4FAw3UPwfPzbRhonwLR6QX3erwgvh1ym/J+7VouKcwLjBnAo/707IMbvpXwON/teAY+qO5wSa1HtMjNy3EZ8drpy6tg/ha6976mjxieIqFuHfbF1XOYfgwuPDqqBpLjYt77WSAveH98aeS58PnWMawVONN49dVuxhq0DUqUrfC4S0qVeiZbJ+SuMv0O37bPoSO7XJVhc2qT6SzSWZ+eJCtclGnDI7b5L+Zga6H+oqnXkVBQZ2DDeNEpZCUQtz1NkGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30wO3uwCbH1dNbT1ErY4RtXTihb6khWDZ0CyQZeNbTM=;
 b=Gwp5af7ppBSFjlEOLDpGdbcb2eb8C3HHv6gQevwcoqskFqIqQ4I63a3vbWNH3JNnn+qIsiU2xLruhGAVliTiLU0XUwLP0+Ub6DQFfL80dnkJb5pvx8QKlvCLyAKM46e03DMwpwW+ifM1hjZPcFLXVDrs655p/+jF1EX7Aar7WkeT1T17iicEI2LwYCWQv0mABVcWuLiJdBNkTAfT2IRsKO0uQELU8dPeX5EVhwycuPWAVxyI2BTv7WB2m/U43XaJzvHwG4DAUL60iF4Vks5ULZrnU5f8sYIAJ/aqMNa/9WWMLnWGOSYqwhbhmQTXFV+5uMsnMOLoqum6BX1hKhUcog==
Received: from MW4PR04CA0298.namprd04.prod.outlook.com (2603:10b6:303:89::33)
 by BYAPR12MB3493.namprd12.prod.outlook.com (2603:10b6:a03:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 07:21:19 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::ca) by MW4PR04CA0298.outlook.office365.com
 (2603:10b6:303:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 13 Jul 2022 07:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 07:21:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 07:21:08 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 00:21:06 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
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
Subject: [PATCH V2 0/6] block: add support for REQ_OP_VERIFY 
Date:   Wed, 13 Jul 2022 00:20:13 -0700
Message-ID: <20220713072019.5885-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e8c86c0-d7b3-4581-05f3-08da64a04835
X-MS-TrafficTypeDiagnostic: BYAPR12MB3493:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QaLkpPTpOzcZUNAXUnYirdrF8k1lz0lyez1k1t5BzAhxPGHMgF09QWHtyP7yf10wrSBNLFDDnqNuwIeVgSt0jsXx7EH3DrUQOHFLDqw/H7wAAneMWjXyIWSTqPdNR2GLaHNz51SHHmscLQWLW6+MOnGX/iAhN9sp1roYQ93QIKyHTyLdRWAAECBER1NRzziBH3sXm9/4sXaCJjgngGbbLQkQXWwUekUgcTBkFH5AfeugFwHEc5lepjvY4VIPbxpKjDID23ArXplSNJNei0rpRodU0E+eHNPT+OsDxDkdW/TSj88HLDEOPJcaC8O8+/TUN7Z9A97SFCdpkfZyVh6p1zI0U0+4YFMubZV0t+bybIAgMYI3b7sCpnz0tHxGzMOgZqxaklRH8nXcInwB1LwZ4iT6jaa7zBcGFhVElLWihcKd2+DFfsMgoMkuTCGHEiTQ12Hd8nwCNgY287uDPBaVkgXcezJLeFKaF9qniJUpwXol8gNMMJTlJaoDov70IgfCz/PUb3adjXj5RUU3ROboDtsUSKnk9sNIRg4lpYfGFSMEyXYTL6mxwWWA0OUl+AQsJ7je0KRBPzP9nP7dAajOJLQ9GFJeyjcQYfel0q37ZxSHzTa8aUtbp7zzrN3zbu69ijmh/TKGo7vJm8Eh4NqJ42anEFHXPNVyL7juNOIdl+A1ylTpdjzOeBA0+YjGKPTtn4+A8Oc1fugyxb831bbMr7Y0UkyFtiogaRSL6HeFC+jHu3z4tTpG8B1vgcYgprU93TJ3llSz8z1zmQlbJls4G+CqmJYpyRQ7mWOG5RNowlZWeHdc1rT7qM7rL1EHhDtj98C5KsOdnVGd8yYjKLqieNwfDROP/kCzcGfVdCL1gKb/7gjZJVPj701kJ3rXGKMM2M7FhKfH4VL3CtN1eW255VsK7P9KUbt8GB3sh8HlnglOCjYVEGVi+tmC7LT4FBd
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(40470700004)(40460700003)(7406005)(5660300002)(316002)(30864003)(40480700001)(36860700001)(83380400001)(81166007)(36756003)(7416002)(8936002)(186003)(8676002)(47076005)(4743002)(336012)(4326008)(356005)(70586007)(16526019)(1076003)(70206006)(7696005)(6666004)(82740400003)(54906003)(426003)(2616005)(82310400005)(107886003)(26005)(110136005)(478600001)(966005)(41300700001)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:21:19.3919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8c86c0-d7b3-4581-05f3-08da64a04835
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3493
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

One of the responsibilities of the Operating System, along with managing
resources, is to provide a unified interface to the user by creating
hardware abstractions. In the Linux Kernel storage stack that
abstraction is created by implementing the generic request operations
such as REQ_OP_READ/REQ_OP_WRITE or REQ_OP_DISCARD/REQ_OP_WRITE_ZEROES,
etc that are mapped to the specific low-level hardware protocol commands 
e.g. SCSI or NVMe.

With that in mind, this patch-series implements a new block layer
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

Any comments are welcome.

Below is the summary of testlog :-

1. blkverify command on nvme-pcie :-
------------------------------------
[   22.802798] nvme nvme0: pci function 0000:00:04.0
[   22.846145] nvme nvme0: 48/0/0 default/read/poll queues
[   22.857822] blkdev_issue_verify 490
*[   22.857827] __blkdev_issue_verify 419*
*[   22.857828] __blkdev_issue_verify 452*
*[   22.857911] __blkdev_issue_verify 466*
[   22.857922] nvme_setup_verify 844
[   22.858287] blkdev_issue_verify 502
modprobe: FATAL: Module nvme is in use.

2. blkverify command on null_blk verify=0 :-
--------------------------------------------
Observed the emulation from block layer :-

[   24.696254] blkdev_issue_verify 490
[   24.696259] __blkdev_issue_verify 419
[   24.696263] __blkdev_issue_verify 429
*[   24.696264] __blkdev_emulate_verify 366*
*[   24.696265] __blkdev_emulate_verify 368*
[   24.696334] blkdev_issue_verify 502

3. blkverify command on null_blk verify=0 :-
--------------------------------------------
Observed the REQ_OP_VERIFY from block layer :-
[   26.396652] blkdev_issue_verify 490
*[   26.396659] __blkdev_issue_verify 419*
*[   26.396662] __blkdev_issue_verify 452*
*[   26.396669] __blkdev_issue_verify 466*
[   26.396702] null_blk: null_process_cmd 1406 kworker/0:1H
[   26.396740] blkdev_issue_verify 502

4. blkverify command on NVMeOF block device backend null_blk verify=0 :-
Observed REQ_OP_VERIFY on host side as target support NVMe verify.
Observed the emulation from block layer on target :-
[   31.520548] blkdev_issue_verify 490
*[   31.520553] __blkdev_issue_verify 419*
*[   31.520554] __blkdev_issue_verify 452*
*[   31.520885] __blkdev_issue_verify 466*
[   31.520976] nvme_setup_verify 844
[   31.520982] nvmet: nvmet_bdev_submit_emulate_verify 469
[   31.520984] blkdev_issue_verify 490
[   31.520985] __blkdev_issue_verify 419
[   31.520989] __blkdev_issue_verify 429
*[   31.520990] __blkdev_emulate_verify 36*
*[   31.520990] __blkdev_emulate_verify 368*
*[   31.521088] blkdev_issue_verify 502*
*[   31.521097] blkdev_issue_verify 502*
[   31.534798] nvme nvme1: Removing ctrl: NQN "testnqn"

3. blkverify command on NVMeOF block device backend null_blk verify=1 :-
Observed the REQ_OP_VERIFY from host and target block layer :-
[   54.399880] blkdev_issue_verify 490
[   54.399885] __blkdev_issue_verify 419
[   54.399887] __blkdev_issue_verify 452
[   54.399962] __blkdev_issue_verify 466
[   54.400038] nvme_setup_verify 844
[   54.400044] nvmet: nvmet_bdev_execute_verify 497
*[   54.400045] __blkdev_issue_verify 419*
*[   54.400046] __blkdev_issue_verify 452*
*[   54.400048] __blkdev_issue_verify 466*
[   54.400053] null_blk: null_process_cmd 1406 kworker/20:1
[   54.400062] blkdev_issue_verify 502
[   54.405139] nvme nvme1: Removing ctrl: NQN "testnqn"

6. blkverify command on scsi debug drive :-
Observed REQ_OP_VERIFY mapped onto SCSI Verify (16) :-
[   61.727782] sd 2:0:0:0: Attached scsi generic sg3 type 0
[   61.727853] sd 2:0:0:0: Power-on or device reset occurred
[   61.729965] sd 2:0:0:0: [sdc] 8388608 512-byte logical blocks: (4.29 GB/4.00 GiB)
[   61.730992] sd 2:0:0:0: [sdc] Write Protect is off
[   61.730996] sd 2:0:0:0: [sdc] Mode Sense: 73 00 10 08
[   61.733141] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   61.737303] sd 2:0:0:0: [sdc] VERIFY16 supported
[   61.737307] sd 2:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[   61.737309] sd 2:0:0:0: [sdc] Optimal transfer size 524288 bytes
[   61.755811] sd 2:0:0:0: [sdc] VERIFY16 supported
[   61.757983] sd 2:0:0:0: [sdc] Attached SCSI disk
[   61.759689] blkdev_issue_verify 490
*[   61.759693] __blkdev_issue_verify 419*
*[   61.759695] __blkdev_issue_verify 452*
*[   61.759770] __blkdev_issue_verify 466*
[   61.759784] sd_setup_verify_cmnd 1101
[   61.759785] sd_setup_verify16_cmnd 1063
[   61.760800] blkdev_issue_verify 502

-ck

Changes from V1:-

1. Don't use kzalloc for buffer allocation. (Darrik)
2. Use NVMe controllers VSL (Verify Size Limit) to set the verify max
   sectors limit for the block layer queue. (Keith, Christoph)
3. Remove the word "we" from commit messages and point to the right
   kernel subsystem. (Christoph).
4. Add complete original cover-letter.
5. Add SCSI REQ_OP_VERIFY patch with Damien's comments addressed.
6. Remove the patch for the NVMeOF file-ns.

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

http://t13.org/Documents/UploadedDocuments/docs2017/di529...

Chaitanya Kulkarni (6):
  block: add support for REQ_OP_VERIFY
  nvme: add support for the Verify command
  nvmet: add Verify command support for bdev-ns
  nvmet: add Verify emulation support for bdev-ns
  null_blk: add REQ_OP_VERIFY support
  scsi: sd: add support for REQ_OP_VERIFY

 Documentation/ABI/stable/sysfs-block |  12 +++
 block/blk-core.c                     |   5 +
 block/blk-lib.c                      | 155 +++++++++++++++++++++++++++
 block/blk-merge.c                    |  18 ++++
 block/blk-settings.c                 |  17 +++
 block/blk-sysfs.c                    |   8 ++
 block/blk.h                          |   7 ++
 block/ioctl.c                        |  35 ++++++
 drivers/block/null_blk/main.c        |  20 +++-
 drivers/block/null_blk/null_blk.h    |   1 +
 drivers/nvme/host/core.c             |  31 ++++++
 drivers/nvme/host/nvme.h             |   1 +
 drivers/nvme/target/admin-cmd.c      |   3 +-
 drivers/nvme/target/io-cmd-bdev.c    |  66 ++++++++++++
 drivers/scsi/sd.c                    | 124 +++++++++++++++++++++
 drivers/scsi/sd.h                    |   5 +
 include/linux/bio.h                  |   9 +-
 include/linux/blk_types.h            |   2 +
 include/linux/blkdev.h               |  19 ++++
 include/linux/nvme.h                 |  19 ++++
 include/uapi/linux/fs.h              |   1 +
 21 files changed, 553 insertions(+), 5 deletions(-)

linux-block (for-next) # 
linux-block (for-next) # sh verify-test.sh 
nvme-pcie
[   22.802798] nvme nvme0: pci function 0000:00:04.0
[   22.846145] nvme nvme0: 48/0/0 default/read/poll queues
[   22.849666] nvme nvme0: Ignoring bogus Namespace Identifiers
[   22.857822] blkdev_issue_verify 490
[   22.857827] __blkdev_issue_verify 419
[   22.857828] __blkdev_issue_verify 452
[   22.857911] __blkdev_issue_verify 466
[   22.857922] nvme_setup_verify 844
[   22.858287] blkdev_issue_verify 502
modprobe: FATAL: Module nvme is in use.

null_blk verify=0
[   24.696254] blkdev_issue_verify 490
[   24.696259] __blkdev_issue_verify 419
[   24.696263] __blkdev_issue_verify 429
[   24.696264] __blkdev_emulate_verify 366
[   24.696265] __blkdev_emulate_verify 368
[   24.696334] blkdev_issue_verify 502

null_blk verify=1
[   26.396652] blkdev_issue_verify 490
[   26.396659] __blkdev_issue_verify 419
[   26.396662] __blkdev_issue_verify 452
[   26.396669] __blkdev_issue_verify 466
[   26.396702] null_blk: null_process_cmd 1406 kworker/0:1H
[   26.396740] blkdev_issue_verify 502

bdev-ns null_blk verify=0
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
++ echo 512000
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
[   30.489780] nvmet: creating nvm controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:2ee37606-f9d7-4925-8a61-784320913d7b.
[   30.489918] nvme nvme1: creating 48 I/O queues.
[   30.495425] nvme nvme1: new ctrl: "testnqn"
[   30.500883] null_blk: disk nullb1 created
[   30.503497] nvmet: adding nsid 1 to subsystem testnqn
[   30.505313] nvme nvme1: rescanning namespaces.
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
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 1 controller(s)

real	0m0.362s
user	0m0.000s
sys	0m0.009s
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
+ umount /mnt/nvme0n1
umount: /mnt/nvme0n1: no mount point specified.
+ umount /mnt/backend
umount: /mnt/backend: not mounted.
+ modprobe -r null_blk
+ tree /sys/kernel/config
/sys/kernel/config

0 directories, 0 files
[   31.520548] blkdev_issue_verify 490
[   31.520553] __blkdev_issue_verify 419
[   31.520554] __blkdev_issue_verify 452
[   31.520885] __blkdev_issue_verify 466
[   31.520976] nvme_setup_verify 844
[   31.520982] nvmet: nvmet_bdev_submit_emulate_verify 469
[   31.520984] blkdev_issue_verify 490
[   31.520985] __blkdev_issue_verify 419
[   31.520989] __blkdev_issue_verify 429
[   31.520990] __blkdev_emulate_verify 366
[   31.520990] __blkdev_emulate_verify 368
[   31.521088] blkdev_issue_verify 502
[   31.521097] blkdev_issue_verify 502
[   31.534798] nvme nvme1: Removing ctrl: NQN "testnqn"

bdev-ns null_blk verify=1
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
++ echo 512000
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
[   53.372782] nvmet: creating nvm controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:0c78049e-e88f-4f9f-a8ff-bf6287235660.
[   53.373088] nvme nvme1: creating 48 I/O queues.
[   53.377729] nvme nvme1: new ctrl: "testnqn"
[   53.382877] null_blk: disk nullb1 created
[   53.385343] nvmet: adding nsid 1 to subsystem testnqn
[   53.387320] nvme nvme1: rescanning namespaces.
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
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 1 controller(s)

real	0m0.364s
user	0m0.000s
sys	0m0.007s
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
+ umount /mnt/nvme0n1
umount: /mnt/nvme0n1: no mount point specified.
+ umount /mnt/backend
umount: /mnt/backend: not mounted.
+ modprobe -r null_blk
+ tree /sys/kernel/config
/sys/kernel/config

0 directories, 0 files
[   54.399880] blkdev_issue_verify 490
[   54.399885] __blkdev_issue_verify 419
[   54.399887] __blkdev_issue_verify 452
[   54.399962] __blkdev_issue_verify 466
[   54.400038] nvme_setup_verify 844
[   54.400044] nvmet: nvmet_bdev_execute_verify 497
[   54.400045] __blkdev_issue_verify 419
[   54.400046] __blkdev_issue_verify 452
[   54.400048] __blkdev_issue_verify 466
[   54.400053] null_blk: null_process_cmd 1406 kworker/20:1
[   54.400062] blkdev_issue_verify 502
[   54.405139] nvme nvme1: Removing ctrl: NQN "testnqn"

scsi debug
modprobe: FATAL: Module scsi_debug is in use.
[   61.392949] scsi_debug: module verification failed: signature and/or required key missing - tainting kernel
[   61.727201] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
[   61.727208] scsi host2: scsi_debug: version 0191 [20210520]
                 dev_size_mb=4096, opts=0x0, submit_queues=1, statistics=0
[   61.727369] scsi 2:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
[   61.727782] sd 2:0:0:0: Attached scsi generic sg3 type 0
[   61.727853] sd 2:0:0:0: Power-on or device reset occurred
[   61.729965] sd 2:0:0:0: [sdc] 8388608 512-byte logical blocks: (4.29 GB/4.00 GiB)
[   61.730992] sd 2:0:0:0: [sdc] Write Protect is off
[   61.730996] sd 2:0:0:0: [sdc] Mode Sense: 73 00 10 08
[   61.733141] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   61.737303] sd 2:0:0:0: [sdc] VERIFY16 supported
[   61.737307] sd 2:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[   61.737309] sd 2:0:0:0: [sdc] Optimal transfer size 524288 bytes
[   61.755811] sd 2:0:0:0: [sdc] VERIFY16 supported
[   61.757983] sd 2:0:0:0: [sdc] Attached SCSI disk
[   61.759689] blkdev_issue_verify 490
[   61.759693] __blkdev_issue_verify 419
[   61.759695] __blkdev_issue_verify 452
[   61.759770] __blkdev_issue_verify 466
[   61.759784] sd_setup_verify_cmnd 1101
[   61.759785] sd_setup_verify16_cmnd 1063
[   61.760800] blkdev_issue_verify 502

-- 
2.29.0

