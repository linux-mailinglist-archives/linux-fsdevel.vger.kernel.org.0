Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F37740D71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjF1Jrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:47:51 -0400
Received: from mail-sgaapc01on2132.outbound.protection.outlook.com ([40.107.215.132]:35171
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236050AbjF1Jh0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:37:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFY/DyUWFKoPNvuGVqPRx3QhH8TyAGEPU+TtbLQApOciLQNUYyf5TPVgWgAqtFL+oR05qn4yb+zsI70e5fTqjUc7CFdj4RuJ+areH98jxMZpINZ7KLISt6iEopTfxsDUOcj96vbFjISKhoGt0MeAVAdUMUeSnKymhkfwboCOqUcYlbFdJLMueZBM4vgqRCl9q19geYzBQ3vUYRs/Rcn6E5Fn3b1zTWRdmeqFyPFHEzrcWfzXmqjggpCZOfEg1M+oarlf5t7MqHRocA7tpK5/zBI4uSXfVILXSqRN2/IL08Lny8diKq4oXdtF/WcDFaYXz+O8JXAVdvxbDMBWEvlfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCINtTSOVFpd1YHsCw6PHLJKl9u3lVOMvIkmIKd3mSU=;
 b=jAkeBezINo3gkWi1Tl2F4nCbu7e+RGz7xJNdW4YfHrWWP0+g0ZzcNO6nkk+5U0PUWfIbha+riDlMXtCfR8qOYJ6AXUU08r4SXCxmCTpQQ5h/eGSLZblKq8rDjoLZAphl4vrwLYjwreWIL/bq18/bbTUpL2knxxfJThIFeyZEfa7vFqXlakYlCEPi2KoCt6/XqskdfQtWH7S+OMa7oE8Ul3TPdUkqAd7y2eMBg2ZAgoVZ9kMrYJXdsKl5o4WZG1ggZcJG2z3ZSmYZKzTeDCjt6BsL1+3naV+3lNCyvi+TzQ95lR4OddFLip6n/voa024CENsUYDAO6aUZibAErU+1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCINtTSOVFpd1YHsCw6PHLJKl9u3lVOMvIkmIKd3mSU=;
 b=YurJfh9Bc6OkHDngK88Kbn2HDzjodNcUVEYuBioTudzj1P4VY5jK3Qa7GWxOASIZcPNQaq7+BinuTyLcp8HeKZmBLHgBnTlL6Nvo0mg2BrIjasCUPGV6l3cUlebXzOhOndH9sQwNXDCQDNRl+tn7HWT+exc9iy2g7VEIfjSPYpRm5mQVt2wYaMeKdAvcTJFqeclqUFm4OW89vqTEeO9YriSuFrZyjhHhca5eKzGQEFo7mzjGBv17VJxluSy6Cq1fj+PRhVwtFryGZzQhO5ONZTnd2V2mj34CalrMOr1u81oEZvDWgP7lcSyVCyWTEs29BwBvctiHfFdQLnwnnDajVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6144.apcprd06.prod.outlook.com (2603:1096:400:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:35:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 09:35:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 6/7] xfs: Convert to bdev_logical_block_mask()
Date:   Wed, 28 Jun 2023 17:34:59 +0800
Message-Id: <20230628093500.68779-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230628093500.68779-1-frank.li@vivo.com>
References: <20230628093500.68779-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bfde6c-dd0f-4e8c-2665-08db77bb055f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lC+Ao4K7+hWytrCM7wxdVIbp2/xTWBRmZeVQ9ayCQCZbgs6YthtUKsK0AMbDwcNIsCa2qWMw1heNYVmN15t0+JgYQyPJ1szPCHqYl8jUVM0Fwj5j2YWhjvYqwlBm55zNOVzbu+d8m/TIWNLSKXy1XWRjscg0hpkigtbwcF5gPq8txl9niNRSu9hxAPThwFpz70mGT2tES6259xkVCOQtR/uBKBf0gu2Tka8O6+LNLWnmea9F3nH9ygR8pewXsHgEBxZNRQKN+U5eisOfnnMOUF0lLdxNXY+9mGSMJ4X0HczBd9e/mhmIsau3vO3KO8QEUU257LCU9j7oyLzSuMSM6sHf/WAva6dk5aoIp4wnk+Nudv+MUdRoaiHm/QbKlTTp901pdY+zLerradyTzQx0w+gibq+EL3qlgCp3p9K18qUqXhskLGmBGWkmxYiOJQ32UVSUmy/bXdtncf54Aw2Bn4GzDKeXaIKJUmls+fqU0xnN7W0AvDUTSnK5V0WTkKRA/q8B2z9Dy4HyeTzfGYGdGBO44dqg9WestRISNapYyBhSkpbhDNzZd5zvE0wz2TEivxBKScvzGPpl1d7D6yD9y4p7M5il5B7axuwia6WZVIGPtks6M6t5aLqIO8a02RKq7XP69eLGHy7rNHLlLHQaZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39850400004)(376002)(366004)(136003)(451199021)(1076003)(6506007)(7416002)(5660300002)(66556008)(316002)(66946007)(36756003)(478600001)(4326008)(66476007)(8676002)(8936002)(86362001)(4744005)(2906002)(6512007)(26005)(41300700001)(6666004)(6486002)(52116002)(186003)(107886003)(38350700002)(38100700002)(921005)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LW5bfHbnbo2XHJhvAxypkYSYiYGxEQg5zp8R6Uexm0pO41cjsZ31fijL6mUW?=
 =?us-ascii?Q?Ez6bE+ReJYn8HkGJzAHHTJEDLnNBCjw/o7y4RhM97/WzaHpLN+8mL0QuTuKX?=
 =?us-ascii?Q?7JJvtAJis9+6ZB0o+iq6906J3Yx6A5+Veg75aUEe7xtbqmW5Dawk+oapo1Sb?=
 =?us-ascii?Q?DatMwNQ4qwRVy8BUZtqq1Zma529xaLYIv6ssophOXLmjutFtmsr1p8iAM/9f?=
 =?us-ascii?Q?q1RY8YV/qt7VSsn5nKeLHnXKwwwwnfDmHXYQs7Ygs+cM1aaCgLidCEXWfQI6?=
 =?us-ascii?Q?JgSQdjmJnkgvishj3obKO0SYE3sNAzWBMNijK15Ub3l4Sint86TK6Vrifz32?=
 =?us-ascii?Q?+kXKZSEctpWSCzCMeyY9gjJ1SIjUCH3n6MW9co5mtWW5Fr92IeiAc8S4wCgK?=
 =?us-ascii?Q?F6SkKIryJNV5SjdB2/aSPSdZYP8k53u04Bk50aU1SvvX6d7f6Thp1k70nZtZ?=
 =?us-ascii?Q?TffTQ+XdNqpNCYXH+Ee2bNQ6ufD2lmQQV7LChxwrNbjE1AIZ6V3V4HwfubO5?=
 =?us-ascii?Q?DtgQ0sSHnI+dMg8KSM+T0DdlHVlRm7CfaCpB44VKVZ391XsGLS/IhD105UUQ?=
 =?us-ascii?Q?zx/YzCeJ12vvprauMg47rRVl7okuDbeLQN7PVXd4IoXssXaNIyX6T5980Jm0?=
 =?us-ascii?Q?X0hEtTiUQR9Xy8wCHq2jsrgq2IdlBVpZUS+MZmghFVYE2MPQWbpR9udLHhhs?=
 =?us-ascii?Q?g7FJomT++eDw+FnmsiLzqfZGIcRx353EPuKG61VQn0guZDLls6uhYJQo7Lq/?=
 =?us-ascii?Q?qupl/XQ0/2CQHC3DqhFGbdZv64Kr6hQ1mAQyZb5yaUweC4aVmE7t/vnkVCAm?=
 =?us-ascii?Q?K6J7pcaE/8PyBvfA2obrktsZO5QZFzLCsC4sb+PvpfnVa+oDPE+5+yyORtyj?=
 =?us-ascii?Q?8Dl1GZsRuedFLdJL7/TjvmfL0oJAzre8b6pU1dms7DTJSfMH09nXUElvNDrF?=
 =?us-ascii?Q?clFAB/SWG4e7m6r+2BPySk3HrGSsMd26dPwNXjDmjwvNZ8Dupmzpyyv1QOzD?=
 =?us-ascii?Q?CUNtq/I8fsU9jof5MeEmxDYtes3xWgQWijtTNPybDcNkAcpngSBYlpN6HpA6?=
 =?us-ascii?Q?v4/O5ehv/WFD/rvKYWUAIh8VXX1XLkKZT1BdmZZAykXMpLkt4gjS8Q7lXiXi?=
 =?us-ascii?Q?4VHBP0FIKJeKd0+FnaHD2rSSDN/qRTXwQY7SDKdGK7YjkffXMdTAOwrySL1d?=
 =?us-ascii?Q?mapW5AeIL41amymxrZ3SAk8a05G32SdB0oBVQq6nLk9qDlcfB9x+nrkJepH4?=
 =?us-ascii?Q?gF03TT1tnLspJe+qH9MzBz0KUhAXbpdFkJl3lnoEwKXQU6uXS7cVFBmZyPrE?=
 =?us-ascii?Q?ym3ud+DZMnnj2Cm4xCgkQYD9dhpdr8K4eRx+dMJ9YwBhKEKrzBPo+t7XLoko?=
 =?us-ascii?Q?oe3nGQFPmAuX4Puscj3loPj7zPqccdo0uA8ZgYLahcq3mlY7V/2Yxs1PLXK8?=
 =?us-ascii?Q?zX9ck3c5e3B45npRjSQXVlwCLP/pm7DQdP8MtZH3plPrQ7XrWfrICDpvhe2/?=
 =?us-ascii?Q?25gRFMZC7KjXjm1WTujLjQnAulsBHBrSSlDAPADbt/NuiLdDHPny9zjhtinZ?=
 =?us-ascii?Q?MIa2iLyYyMd19Km35vuZVWMYuimu/WfcdsYhxCGy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bfde6c-dd0f-4e8c-2665-08db77bb055f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:35:33.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPoWNxqHnJ7o4VCUKKHunYZzTs38GOzkpx9uGcKKHgiLw6LrzxaiUB0zo19wUPgadQ+z95mrAwCPo+Hmcz44hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6144
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bdev_logical_block_mask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/xfs/xfs_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 15d1e5a7c2d3..f784daa21219 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1968,7 +1968,7 @@ xfs_setsize_buftarg(
 
 	/* Set up device logical sector size mask */
 	btp->bt_logical_sectorsize = bdev_logical_block_size(btp->bt_bdev);
-	btp->bt_logical_sectormask = bdev_logical_block_size(btp->bt_bdev) - 1;
+	btp->bt_logical_sectormask = bdev_logical_block_mask(btp->bt_bdev);
 
 	return 0;
 }
-- 
2.39.0

