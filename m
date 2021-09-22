Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E4E414029
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 05:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhIVDsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 23:48:46 -0400
Received: from mail-eopbgr1300049.outbound.protection.outlook.com ([40.107.130.49]:47115
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230054AbhIVDsk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 23:48:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUaoG8Hea6CBkMkTSX6GphI3va0Doz508du1zJGDQyM+jDkVruCT1Ug2qrdTeenU4Wa9RzsmFCSrQ74BQHHE0X8JNR0I/Ir/j9JDkt/CMSXEIGE1uium3rk84S7ppZqagboWmRn8Q0mrd1mGnK+jCe7Nri+sI9waGEN/N+j03Rh8J1fsUrrH8BMXutmLkd2CeOfB9oEIKg4wB23i7g1ZLtCOwC97NSr84sq8no4sit8k4wtNjDZ3G7hRNZ70ChSM9HA/dGa9nrfJgDLMIXPuooGHuyqPVx9f4PnNJrbxM0WCjSsvoF6bz+iE/GMCA/gLpQbqzDUd+ZYBzQWWSJtrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GIcLCkXvyIaoPuUx0+Wz1u+EGyqsRSlkWNfhUEyprxk=;
 b=W0oVHV8knJOClbu9sqKgxxRi6FnYVKclcngq/NZrcHrAUkjxG+pAXr0/exlNXTbANm4hFRH/oGjGWrADCQpkkPOWMznP1mQV1+fApk2uBCqHjgsVW+9R3F0JS4iRIHe2WuZix6K1R1R1XcRBUPtXFFL0KdtOxoD2HvQ5/mgfb/NtVDDmc/CM0IcPMHAl8mEuOsnxkveRkUl3QpKeJMsL04FiS884HA0qJUNRQf8zaojuMuG5j464vsPke7wrvp9PATH5927zrLhZLJYFmIpnIaSKKI82myUWcykGvaYDsZHN4oRY7q5IClFXnp5SUrAZ6qcOAyIhQwtosaqYfsXuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIcLCkXvyIaoPuUx0+Wz1u+EGyqsRSlkWNfhUEyprxk=;
 b=PEMMMXdWOcp0IC9J4azPN8JoI9L/O+zPAHwo/croxPoCwp7DQ/FidJnwXOg9hyHTkP/uTRYRN+yx8WHCNo4Qcf7JyPMwS9URYlE6aa3zhX1Zjv5TIcPvnGZuw5Fwong7XVS53YnEmYi7/zZX+eKle3Z1jBzkYmTNLHVUxT/9lUo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4460.apcprd02.prod.outlook.com (2603:1096:0:e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Wed, 22 Sep 2021 03:47:08 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 03:47:08 +0000
From:   Huang Jianan <huangjianan@oppo.com>
To:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     huangjianan@oppo.com, guoweichao@oppo.com, yh@oppo.com,
        zhangshiming@oppo.com, guanyuwei@oppo.com, jnhuang95@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] ovl: fix null pointer when filesystem doesn't support direct IO
Date:   Wed, 22 Sep 2021 11:47:00 +0800
Message-Id: <20210922034700.15666-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210918121346.12084-1-huangjianan@oppo.com>
References: <20210918121346.12084-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.252.5.73) by HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Wed, 22 Sep 2021 03:47:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd31b02f-8f00-4746-0223-08d97d7ba6f0
X-MS-TrafficTypeDiagnostic: SG2PR02MB4460:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB44605163D987DA0A0521BD54C3A29@SG2PR02MB4460.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DQxltW13XODKP7qgWxcPbmLbaIoQQtDwuci0xpV/rIiw3BEhXX4FJt8ChqrEQUBRA8654JAjxP7jPrUsMYVMiGi+MM3HGzpqdAJ4dS8BX1toSS++1T9YK9tvXDiReLmkx5rtINYT0ftC0WNubHuPEYfj+X0TdSrfUXxcxh/HtSBTEwkgpRyUbKj3dShze3UZN9/tsPTAQ9nkoKA5wFQe9tQOnPwfN6CZIg8yM71yix06EuzLqXHtRKLAPhOPOI3BgCvq0DTc+CMNA5uQi9OEAzOP0UldpCg1i4yXVYGk+IbUbkA3XmzbXgrllYCXWVB7vhSgTof335A0dfoExgCtElAXT4IgU07ZFiz37/eiSz4bvhgGP7orQBjJgiwkW+4NokxK9e96Ss26s4jgAujoxwFY+ixKfImiI0k1Ugmip780nHor6MBlGg1lXZHyu2dLfc8aZJOPy3g6GTwjeWJ111u3J7qZ8DN9GJ41SuwVwcluQLMuHYii4M2W4YivDnQPbHVmQTZ4hWIVFuBgAVrvmvRUtjUatqOMuNCSn3qqpZbQKjUDiUFMT6jt72GymgobY/rWQROvPxtUflf2nQLRIftUKWyk9zENEn+T4k9PL6vhtisIewAd5RextoPXxcQy0bhfKRnWDzKLbcMh46EEoTCZLV0yqBgLgRMe7wZ3NZuwznAO3X/8+wz6n8QXhhLsXX5JvXjZ5H10kMTsGxvP+ad7uA7HuxqTPokBgHsq1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(5660300002)(1076003)(2616005)(8676002)(8936002)(956004)(2906002)(4326008)(316002)(83380400001)(6512007)(508600001)(6486002)(26005)(38350700002)(6506007)(38100700002)(186003)(86362001)(6666004)(52116002)(66946007)(66556008)(66476007)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kZV5haAifoTA+l1fasOAeY7zSmd5+/hxuab5J01qxAjYoyipQcGUtRDg5Xat?=
 =?us-ascii?Q?knnhKtlty8k5nSMAiKIe3a9WeH9hMfpWRhYrGePuvcuH9UC3OkEKlZW4dxFq?=
 =?us-ascii?Q?h+mkUTsH1q/n9ExUGtCgCfFvusveG7GiY76FFB8k+aSeBIYRwBYX8jxK4Zxo?=
 =?us-ascii?Q?41VNx9CrkNaUnIXPRD40+PTLHuB8XlNK3dcY1ckWQf3jkpkRmXssPjqgbPiB?=
 =?us-ascii?Q?fVukjHfUAl3P4OV0AdMR7FfROD8fHsi08fC7zR2pEJTP4LbkZJI/4jAKFtUi?=
 =?us-ascii?Q?aqshRs2qAXqce5bfKr29ThuqcFUYXgfG9uQ6V8+U4QUbstMrV7w9ghvFv0lT?=
 =?us-ascii?Q?Ea35tPj6PoFMdxP4LcRlOjw3xYQKhinDjU2h9/Gf3FqDpk77QvUK+ejg1P4+?=
 =?us-ascii?Q?WmobMCoNM6zxByBotHpeVCaiQH+nu10tPN5yrirj/gByhTSc8S1kB3vA8lFG?=
 =?us-ascii?Q?tVWDdCj626ZHQzhTIEM5jdJyNLA0GsMLRUuQ6WCHL1N6FBlZawxS0+N1ibNj?=
 =?us-ascii?Q?Zpz8KZ500Iwit8MN1YGhS8c93ZAeE3T0M//HyDa+wd2+Ab+KdmD1qXWWYKTz?=
 =?us-ascii?Q?raG6BoPvIxonnBtDYeBz0qevfrAo9khEmSg2HsNeBKodXOyotCDIYsqQo6n2?=
 =?us-ascii?Q?H6uxJV7JLBSE/B/0FUBccyKDNt5pgekjEUBUBC+mtrnqx+3tSrvnAJAD91ZL?=
 =?us-ascii?Q?/vA9JxSvYgOBXKVuOFY2Y6Sdvzg3NxbRDSUwdOT97rTeIOYrifeNMcwJn5em?=
 =?us-ascii?Q?7+k8Z/7X16C36E/eUNK8SRxcy3FG7nm7l1lA8t4O9JvezyLJoZfmykEmbhGC?=
 =?us-ascii?Q?GydTjmPhN8z40mSl6XZo4WBIbEeNVXR+PZS+qwH5GFUTeQC5YjNMR3T7hCg9?=
 =?us-ascii?Q?Z/2xCd1vZ34tlQ1psRC/uevAOuWP6Wmiet1PbIks6RPbuB3GMx4vXo4Sg25p?=
 =?us-ascii?Q?7SJMbWDn+YV18B0hleRE3M6oNNhCzLJx5XXTDaFsFeUgXzXoBB6qWUMEHjZM?=
 =?us-ascii?Q?5a979es8Zg2zh+D43AjBoKBfiqG2EHxVDb92euqRcK1EyE3XV0/Znvy+Bw4m?=
 =?us-ascii?Q?MSKVXxTDAkI0OrYAM3Euk6eJHug7Qbh1DNF3yisfF1wRO16U3fkCF5htmvCC?=
 =?us-ascii?Q?2VGlHCIIdEMSeoCAI4XWbmHb2VpizqaCM/0ttSptIWekR/CgAsGJzr4nJPco?=
 =?us-ascii?Q?eZux3BH55qeq7cuQsrLGM3exeyg6Z7BeG5HtAYgwzb+V2+UjvPrf/UCy0gTR?=
 =?us-ascii?Q?ZVtIC6JW+7IAb9ZAV19slS1j+TsB8ZByFcOZ6dtYKqRtqlrmtrTXB/Fu7pK1?=
 =?us-ascii?Q?1ObVS8fSL4hcFa29LEo+INCp?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd31b02f-8f00-4746-0223-08d97d7ba6f0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 03:47:08.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvgmgnnAUkfuHleGFSpOaSFa7SJAS4Fh623E4Zmy62pPLESgqOlgUp5MUnLYMxSEp+rh7ClaznYS2eDW4bcXXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4460
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
example, erofs supports direct_IO for uncompressed files. So reset
f_mapping->a_ops to NULL when the file doesn't support direct_IO to
fix this problem.

Fixes: 5b910bd615ba ("ovl: fix GPF in swapfile_activate of file from overlayfs over xfs")
Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
Change since v1:
 - Return error to user rather than fall back to buffered io. (Chengguang Xu)

 fs/overlayfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index d081faa55e83..38118d3b46f8 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -157,6 +157,10 @@ static int ovl_open(struct inode *inode, struct file *file)
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
+	if ((f->f_flags & O_DIRECT) && (!realfile->f_mapping->a_ops ||
+		!realfile->f_mapping->a_ops->direct_IO))
+		file->f_mapping->a_ops = NULL;
+
 	file->private_data = realfile;
 
 	return 0;
-- 
2.25.1

