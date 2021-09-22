Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61440414294
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 09:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhIVHZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 03:25:11 -0400
Received: from mail-eopbgr1300048.outbound.protection.outlook.com ([40.107.130.48]:43328
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229697AbhIVHZK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:25:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwFfBU5M2B4dmgNAdrDq7BQ1CtM2AA9mHSORJzQxyX1wRRwKmxdbkMhJOdTiLYT9WycxJ0M88va8/jaxt1mo+sNEK/7o/sNohZjRXFPt1P2rlydAMa0s5R8UHX8ljwnCw6fRBcaRd8R/GSybR9fnBLhO0cq54jcC9iaDJqKyuQVS1wgK4+S9lS6NvgULbPR+5ZMpN/QvYlaRZMY/gEZF1jtC35HzwRKHPaqycRro0evC3P9FXRQF+Bjjl/EEKn8HbhM59brZs3uqp+1+JNqMtMjpRezau8sIjVxr8I38yrI0e5XEbOoCjhys6OBkgDJ2gXYQGNz4r8rx2r0qdSx+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/RjoVQIL/KHm77pyZUI65vI7YhUBjaVIs6yN5QWlL28=;
 b=O2E09gknUtdv/dNIEsroOPQ4U0BNy0Jg0cJ2U+Fqu5PI27La3SGZwAucv7FBuJsqJAzcqRkVT5FzW3KYMgLSBbEFc2Jo6Hgv6W0yDB7dWksozG0YG+l4w5/+Op2JKml7dRp7fkqQHHTpZJ3Gygm3JGuRejx5vvFb1RMil2uIf9FBsua/cNi5fkp1YGg+7kMoyFPKWKWMTIJMRr/O1vI5VRLVUog5FJLyIq+NR45/Et1/XoIcmp1EekVWKigwnQKu5sqD0s25n/iiGN2E6jiGtMQqHGIPNP80Bir2GGWUFZp+fcBCcdGDwwXbubunwHl2t3Pzay40zRolBov5y0xn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RjoVQIL/KHm77pyZUI65vI7YhUBjaVIs6yN5QWlL28=;
 b=CIoTqJJX7kNRmVG7+fnRqK+AhQ73q9lZe5F7pVPABtDjdLj4ip2iVF2RVD5s/zZeqWHAFyDmHJfFofQcwfqvMfUD/3oASFjcjPKaTkZAXoKtmWO8DVK6F/9zCZexlWX8vodcgfFm9Hqm0obyrx8cohR/9T0uTFozNjiEVY1mWvQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2557.apcprd02.prod.outlook.com (2603:1096:3:26::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.15; Wed, 22 Sep 2021 07:23:37 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:23:37 +0000
From:   Huang Jianan <huangjianan@oppo.com>
To:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     huangjianan@oppo.com, guoweichao@oppo.com, yh@oppo.com,
        zhangshiming@oppo.com, guanyuwei@oppo.com, jnhuang95@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] ovl: fix null pointer when filesystem doesn't support direct IO
Date:   Wed, 22 Sep 2021 15:23:26 +0800
Message-Id: <20210922072326.3538-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
References: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.252.5.73) by HK2PR02CA0146.apcprd02.prod.outlook.com (2603:1096:202:16::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 07:23:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d439daf3-7223-4f2c-a145-08d97d99e4a3
X-MS-TrafficTypeDiagnostic: SG2PR02MB2557:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB2557170B3FDC677A042A90E9C3A29@SG2PR02MB2557.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCcwEIfX4pbkTQZnHncNL64tMUnvJPzmSjedZsLcGxt63ojRlbYP3edaPAdcyTbCsp8rOlgK5Jy0s9red3xqRQAw7fDIMqGwjO2hwWLSTmJgLS1rr8TSVpSEpSWnNCPbhwBqPE9NkvrvdinrQJ7+W1uRFkT9ji7JZyS/+cBYjJWoBktb4OYxR7H+TLgZKVjtn7xbOAnj9fqSHaNoN/U2enI9Ux8DEu969caiYUAmGdqN6w8qpWfab3twxTdypbKB/U0kUmBWHOvaPYL0L7pgZ0i4glChqGOXO5jUyn59UzAXGYAplz7fgRtL28Qr2DZeXRyM2EFmgZcdH8kHggNtSeQxrCd6N5j97Mo0u96fSxCohXZWxqirZ2kDAoyFoHiXw8EmmsdySrSB8L0PjPDZX6KiP3mTpoiAwoxrMzLNFiCr6H9Vd0M53bXFYdtXJg965sDdDa2k2EbiVLohH1u91lESYcODtwlIdE4nLXyiD5Sy8qDqOnkLvQFIML/jO0WsF+BY10YxNowFv0qLmHwvU+UOvLSv5uWWpyxXeQyuizzGSStgAnDls2SW5p9H5YOSL8jksZfGscu0jvaigcDuGtTqH5NGDC8rxTKVg3+chclbsV3c71JQ1ZsM/C7E4g5uRmu0lgxs6G/8a9Ubc3/oKuZxmfwzgQjRk5Xl8YcsyJqMA7++hyJBk6BVyHr1oZWD5P0uxIXWWvYNYUGS155XMHvJ2hsKnpBa5hbYOhYHZ48=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(6666004)(1076003)(956004)(36756003)(66946007)(2616005)(66556008)(66476007)(5660300002)(186003)(26005)(83380400001)(316002)(52116002)(38350700002)(508600001)(38100700002)(6506007)(4326008)(2906002)(8936002)(8676002)(86362001)(6512007)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iXQ4bFTYkjCwI+dXVstAsmHh72l+dYfvzV3mZqhsAee/yz1tLe9M9HsHikAj?=
 =?us-ascii?Q?ISF0GMCuNUXeEXav/S4ksBV74hk6JmnhrWx/Z0uraM8vIsCQD1O1XMn4KRrm?=
 =?us-ascii?Q?QyEqDvlALLh4pFZj4+eQzfkaYSTlNlYB6mtKJvvsiFOMl2s1pmbjZwogExkP?=
 =?us-ascii?Q?2I85NAaI58oMl4SfX7i2rZTDMUVRr2cYm/fQBeVTZku+hwI8kaQVTlZTUTlS?=
 =?us-ascii?Q?Ip0fWdS7wVeMq9EvYaEQyOCFFHkUNVS/BtfEG737AzfeZCRnJVC6dKPB/D/w?=
 =?us-ascii?Q?Zam7C+qprCo4otgLHqPDHuznLYbpvFKjM1Iqn61dF+QhQkYyl27WKTmHOYh9?=
 =?us-ascii?Q?8/4Zl69G2W8d7lQjMmNh7ynbcjb4b1Vjpst4VaEv8sYH7DRNn8vsxKi4wfXB?=
 =?us-ascii?Q?CBfVPSLbY7d11w+I4zYxJs7bwVm8/76fzC7ptb/r2zdL3d/IlL41OcTeTT7M?=
 =?us-ascii?Q?a6T6Z4YA+jmo0FtTQHD698mGvYou4gu5YRyjxm0JvitAOJZjUiVrzeTwfMDU?=
 =?us-ascii?Q?/HyXG7RPZSl6YP1UGXA/BrvZoisY+Y9e8fPGk+0BFG45D/zJyIz8d8tvk2ZD?=
 =?us-ascii?Q?07ZVO9thvS9/pPaFj4cnoI9qJLkOR4GBPncp4YerPdfZdRoYyDEL4tyxE6Hj?=
 =?us-ascii?Q?8m/kklwwh17aWllQjmjFIPVFXoqOlUNiMQfVCNdo2dNx/fqC4t3HHBXeX3X9?=
 =?us-ascii?Q?5AOKiwL/2FyeRzzcjV5Nh26hdNSQZT1WDSnoV+ClQEKxsu5fBXWhSOpvr1iH?=
 =?us-ascii?Q?kAaAiak4YsAkI9gU46IWLVTHIzAGMOHD23B7YQwokQnJhFHsgh7QcTnytf5R?=
 =?us-ascii?Q?esy6M2HyOAA44ZTxEhg4nXl/F9HHrqsL5WUkWs8xxp2huOgyog/2Wjxz3cvw?=
 =?us-ascii?Q?3illzdTwQlepu2+WI3ePL4UhA8K402g6sSjbiFIof3rsThpuhu7tPUrfbah1?=
 =?us-ascii?Q?EiRQT7vx9mSbF3nf49K4FyZ7aJEC2SbVanfvvk3RZPw2Jtcoosr7IhoFIQrf?=
 =?us-ascii?Q?SdecGq8seQaywyZb+zoDmY/JDL5N2CqAJwHs/egEKyusbzrBUs2cMQiTAiYu?=
 =?us-ascii?Q?gEUW+v9Jjwt/mCAtWo+/En7Wx32jCmOe3b94xX3HnQb+iadSwaApm/xIEAqk?=
 =?us-ascii?Q?DW+09UyOxM4Sv+1J0LbFa8HuX4a6oF4KaAFrZIPYc+Y+NJ5t7o8mU90VwJ85?=
 =?us-ascii?Q?VZAwYCs+D4Ga/QbnZr2AhTaV4jtJOSUm0pBHb3NLeWoHuGcbr7wauXxCfSey?=
 =?us-ascii?Q?960FPqoSfad4zPGPjf+qXLB77DGwHzNwd5PsPZAon0UiIqvdAxQkAPRo5W3D?=
 =?us-ascii?Q?A834S4j/8VzWWbnVVBUxstQS?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d439daf3-7223-4f2c-a145-08d97d99e4a3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:23:37.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwXT1CwxAoqvCARp3mJEd2X7omgo1g5UU9NwAB1kH4jknjSu3at8z68oty9NwzLAlzz4EQ4bkTqyomAiyENUhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2557
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Huang Jianan <huangjianan@oppo.com>

At present, overlayfs provides overlayfs inode to users. Overlayfs
inode provides ovl_aops with noop_direct_IO to avoid open failure
with O_DIRECT. But some compressed filesystems, such as erofs and
squashfs, don't support direct_IO.

Users who use f_mapping->a_ops->direct_IO to check O_DIRECT support,
will read file through this way. This will cause overlayfs to access
a non-existent direct_IO function and cause panic due to null pointer:

Kernel panic - not syncing: CFI failure (target: 0x0)
CPU: 6 PID: 247 Comm: loop0
Call Trace:
 panic+0x188/0x45c
 __cfi_slowpath+0x0/0x254
 __cfi_slowpath+0x200/0x254
 generic_file_read_iter+0x14c/0x150
 vfs_iocb_iter_read+0xac/0x164
 ovl_read_iter+0x13c/0x2fc
 lo_rw_aio+0x2bc/0x458
 loop_queue_work+0x4a4/0xbc0
 kthread_worker_fn+0xf8/0x1d0
 loop_kthread_worker_fn+0x24/0x38
 kthread+0x29c/0x310
 ret_from_fork+0x10/0x30

The filesystem may only support direct_IO for some file types. For
example, erofs supports direct_IO for uncompressed files. So return
-EINVAL when the file doesn't support direct_IO to fix this problem.

Fixes: 5b910bd615ba ("ovl: fix GPF in swapfile_activate of file from overlayfs over xfs")
Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
change since v2:
 - Return error in ovl_open directly. (Chengguang Xu)

Change since v1:
 - Return error to user rather than fall back to buffered io. (Chengguang Xu)

 fs/overlayfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index d081faa55e83..a0c99ea35daf 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -157,6 +157,10 @@ static int ovl_open(struct inode *inode, struct file *file)
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
+	if ((f->f_flags & O_DIRECT) && (!realfile->f_mapping->a_ops ||
+		!realfile->f_mapping->a_ops->direct_IO))
+		return -EINVAL;
+
 	file->private_data = realfile;
 
 	return 0;
-- 
2.25.1

