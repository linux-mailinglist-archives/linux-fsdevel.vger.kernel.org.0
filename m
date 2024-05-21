Return-Path: <linux-fsdevel+bounces-19863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB558CA71D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 05:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7451282356
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 03:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF59E1C68C;
	Tue, 21 May 2024 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hb18RWC4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E91182DB;
	Tue, 21 May 2024 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716262909; cv=fail; b=YU02kUzeJkZxnl80lUhwWRtaHFLTxfOX3zWxL9rl2ToT2spitre6C9sTTOxqa9MNVrNPl2RMc34/BQqUUQlaQ2ov1kiDGdH1O+vQ7GLp95SrpeFATOU81VstMIA48mS+Jt/Pq0CNP3K/pS1iqudl6Aj1Up1VerGvWSopCSRyXwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716262909; c=relaxed/simple;
	bh=3Br7GrShTYuvp0ga2yOM9alAgyEW/s7Msw9n8DatPDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PsjnyHciebykaJDiMDR/6ZQJYYk9UO+fzO3b7PpI3dc5KE8eySFdYYEcFY82Mqvm0hqptETCtoVfx2D6Oinud83cxplHSHqfleuttZZVmfs2gABxzL1REzLkymk1NH4U9BZ0tYsuX2G2dXkqnjFCP2B9pth0JzFyOmtbdcNX9/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hb18RWC4; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCh0okGYE2JdN1hWfAlWLxs/n4jI1nhYPUQBbu/PXxMRRoT84pZH3diz4VSLiTX5QlzH/V/zIgcSesTp9GcYmMfdtXvSjI7t+ygIPmqVGxf2j7hpLS51z65QQ1QKMCVAxw4nRXJOGrhQiNMwkbIQtp0z6hONlbGRHWoaNDecPA/eLDdyP/SuktX3w+FwfMFM+RBGhjKFx6CVpi7XXlNC08lRSg8LsrelwQI4YMjMBuG2cio+cDYj5T6YTgsyklCqWT+eEA6X1BRS7HNeTdsqyxRVVZuJRDxa3O1TB2tMSnqj9aYx8wrpUTzXAPwr1hsAnIjJHliY7ZtGs/njCNXcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VioMiY8TvLlw52PeygM9+PK61Y19grDV3m6pKMV7lao=;
 b=bPDSibbNuxAMmrIBeLcd45KF5yII4OhIDGad7qQBYAhaG0L4/9WgSJLGmeT8HPPZP8MxPSsGhwcwGp8LjBGAaRdPmT4kDsRVCj7c0kt+Px3mfjYEJyM7Rn4PfAfRzkOmgOnCk0B66J4fUevJ/qT2KHviqNh6NE1q+Rx31i+0lERr3R14y6Swxg2kdYLjjuV/zauC/gjxfpcP3GhCa/E5vYUaESNPLbqIk06VBJVBe3WreHrWa/4Fn1pHLrvjgHcH4RyukigrEtfrURSEmq4XkHm5ZF9ut76V6NE2ikOud3ykxRS5+u0CD7Jzqk6fASTuu4zayOY4SfR0dR0grGFUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VioMiY8TvLlw52PeygM9+PK61Y19grDV3m6pKMV7lao=;
 b=hb18RWC4UFbylLc5RXDDoBR3mYgNsAeIkBfmGSrRVL9PugNGB57PO9UkHr4NTEu+zqejO5rHwC5YseIYm1QA3Z2K+FLALOwkRcHxpEZXJmhvV9+7RHF8/CjeXQIFXFxGYrTiRCGIua2Xih0DE9Oo7siug13IkumcNHA6Rj+KACE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8212.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 03:41:45 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 03:41:45 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	jun.li@nxp.com
Subject: [PATCH v5 2/2] iomap: fault in smaller chunks for non-large folio mappings
Date: Tue, 21 May 2024 19:49:39 +0800
Message-Id: <20240521114939.2541461-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521114939.2541461-1-xu.yang_2@nxp.com>
References: <20240521114939.2541461-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM9PR04MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bacdb00-c3e4-43a9-3d71-08dc7947eff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W06iFkFeU7S0NA0F7Qe06bfN70lvi/6IepHznwpGI8lkL2dbJ7jaXLdfp73b?=
 =?us-ascii?Q?Bka4BLwJbZSOTrMVl3mo6sFVwtOmrHYWPI/4VhDcndDzdqjA4dY+m2TwQIdC?=
 =?us-ascii?Q?2KMwVeqUQDlAfLcBSB3/Lbe2gLBLETB9lCnS74HGAtLRgpdS0IJ/eYz+XMYy?=
 =?us-ascii?Q?m3/YYkBlnUg6w9zRZ+e7luoa9qSJykS/WBBcahIumf6FaQrLxykUVWf9FVbh?=
 =?us-ascii?Q?FpxpdddVkJYWSO/j4kefQ8XSPoaj6rgzkxfXG99XJ9uQdzw5hUkZMhwr9Wp0?=
 =?us-ascii?Q?IAkwXDtVgD0Lw8g4nv0Hnusqar9g6mp+flsZJgVd00HrX5Kb9cD2x0S4+oMN?=
 =?us-ascii?Q?vkmiqHNHj/fP/UNFqQpckSxTGBUPI/KnM+RMX2CKMrDoRlkM3B+cUR6Pt5vI?=
 =?us-ascii?Q?rN6aJLGYDtDHCPSOvs7YngWg7kHAjk8LzTbJVft5u+FkmrfLJkvPbJL4e7rn?=
 =?us-ascii?Q?N6e3uSw2kWoI+kASbQuOVZPvSfterfZOSM5uHjI9UkGz9RxhtSbWidIiHbdT?=
 =?us-ascii?Q?PB3uYaxrL7pqbUV/dtFYrSuUZClMP+LxBHQrJNiYlIchLe2749E78azmwL+a?=
 =?us-ascii?Q?5IJQ/O81DrpEk2uZvi7Q8R2/Ja430DeUlJSLtdw4NOvgjUkwJ5Ik8nL0EQ+8?=
 =?us-ascii?Q?vSSVcZNqGFfL+zWfqrQR+6ENBzzm3it780sePD6quWLgz5xpWX9Yh1DW3wjJ?=
 =?us-ascii?Q?XH+UB0yAjKCIeCLqmHiwFhp+OKUcq4fMQEbVfoujgijUeIy6dKrbUGK5c7i5?=
 =?us-ascii?Q?RW3tBqcHHIw1COkmHd7n284ejvmH8+XJz4L8CCSK71kADjmG+iI+KM3/QoXY?=
 =?us-ascii?Q?PrYPdCAhyoTSJnMvTRjEFFaqPtaMJQ+VdnhPieWgleboT0Vzzit8HKi5J8xE?=
 =?us-ascii?Q?PJS9hsg3G+Byx44+AuG9Iw17KC3l92IhkzFHUzM+/c6jPwyYjldqFjMvnqF7?=
 =?us-ascii?Q?xrVp8Kr0gf713kWooHjRYo60jWOconZT6ZSSXyoSORUBVQLt28iNb/q8UtmF?=
 =?us-ascii?Q?RCHvN+46J7nRdhYDKWdAkHSR0Yu7L+kvlMGrydFlM5K/BX3nAINew74wDfXz?=
 =?us-ascii?Q?DwMgDuY0dKA5ykokYzcKFOKq13V8Vu2EVZg98lXz/ALsdN5wnW14tYUzUjGR?=
 =?us-ascii?Q?XjXR0g+imEY3ECHfcg/Rh+p/Z/+nIa3tiUTMA8pp5FYkK5xwBIkOwLrOe85k?=
 =?us-ascii?Q?VPSB2+rXIs4vt4xuaAcCtoNLfOBjnaP+PAE6hAnl8Kvv9hu5YUUmvg6VsHCb?=
 =?us-ascii?Q?cCyBZ1IfcpK64PYBYdQRcYS+l3lgqx3o2/muFL6MiHVix8pwhlvuqwJXkBAp?=
 =?us-ascii?Q?PQxX4tAMV/hEkUSHyquXUItEwuumY6h8HzpNCfJaPThakg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pthm84TnfcrQZK15VfVY56LsnkeeXb9llGHKZyxcfs0yRnNYyr0cnu93bgGt?=
 =?us-ascii?Q?myx8HqUMHawHlTRUNyZk0hHej0CyZTyYCGn+z9UbhpFtFxVd8tPFYWkkNg8P?=
 =?us-ascii?Q?rjaOT72yuVUrM8oEMNjyOKx0WeUQ8G0QpmRwdX7TBPK2I0kBEZjjV8gJ65vE?=
 =?us-ascii?Q?m2V4JuqXhsd/fDv6kRMkcd0vbue9kXprphFeQcTyrQVNJy3Z+5a/4U4mNeKe?=
 =?us-ascii?Q?NQPi8kLX6EDIpVmcjrOqFudMQ51WKrUc/Dav+f05U4cmz5xRcZ3zfaDgiDQX?=
 =?us-ascii?Q?lcSBtStZEkOMLTc/92hP/4BuGPy49ZpN2Tf7/Yp2FSfDfFUGm4u/8oCP2NPO?=
 =?us-ascii?Q?yMhiOiqwGzmFx9Kb91jjC2oaBwsVSmntGbmBAnGCz5MDmInFad9Bp1Of9+rX?=
 =?us-ascii?Q?gusEoFV6EiA7Y5E6fLl+BC2ZBSEzHXnxc7tFq8peDUD0+NGmQEgpYuwNIGgN?=
 =?us-ascii?Q?LnnPJgyCWiPjdIljre7wOmEd4AVVYCgArjeX0Iz2H2TxE+q7aMvNjmX+uMoW?=
 =?us-ascii?Q?dNMLL8aeyabAAK2aZ7sJwdmwj0EflPTBMO7Py+xbERpOxTOSRCk1ScOyqpv3?=
 =?us-ascii?Q?Y74RFZMiZKuLYQXKpwikj2szADUbcYroJdvhSw9jcPt/d/sqRmbxkBVhN9du?=
 =?us-ascii?Q?1qtIaX6BsjTHbx2SEfdbXDsYLG4tpYYJVElePhjCLXDBIq9IKqOsig+Qp+e9?=
 =?us-ascii?Q?8QLCtND5lwTN5xtC5PWOwNjYw8f6xvN3oDZtWqWuDEbt155YWgv5UHXQTlXc?=
 =?us-ascii?Q?qvlMHZU3FdtJ+3jYh4UnXKo6p+xdHOk2Pz2gtM1GVRA60xf5q5d66OrzrgCR?=
 =?us-ascii?Q?m55kZixnEiAUKYpRbfZf2XG4riXj/R5V49OKIAhwdKW2Zogyr54XLTlOd4ML?=
 =?us-ascii?Q?kzPmFUQRBIWuXV6y+9dRVkbfphziiGAEhn+VhcLvXNAuO5E/363Cobi/TVeG?=
 =?us-ascii?Q?YTiUjlLKZBw4k3JuPEf0tkrmO2BoyPCEd3uASUzc+c+SdKqLOrBSJjEeHkym?=
 =?us-ascii?Q?RJnYNoCycQ/gexvZPHLg3L2I9Ckq5Rfs4cqEnbGlCTzZjsJ0EMQZK+pkCLDf?=
 =?us-ascii?Q?0AAbgN7ShlpcBPnrP70wFOOcr5FrV+DiiLd3z+cwtaBDE5x15eD/+Kp26qtl?=
 =?us-ascii?Q?V8pRIWCsE4inNaecASFsScSqG+kvgSv0wVEwU8xTmAM6qyPJh6KMrODLzAP7?=
 =?us-ascii?Q?lMVtBnEl4SBYlXNPqYZxotZIYt2sJos14USVQrvW0tA8YtJb2+GLSpBy9FQ7?=
 =?us-ascii?Q?nIXtXddi6sMR2H08NSQRATXUs0LYKVkdhjMiqC6sl+eu3KzggxV72gplrAqE?=
 =?us-ascii?Q?NVDpSIvEKYE2qpCmljd2zZwb0J89JCIk0HNQsoN5argYHAbs2ZZ6rRriJmik?=
 =?us-ascii?Q?a0RiErk4/UoYD7ZE48ruBt55wCLE+BmG7IESnmdzyfghPmkn4W8n9Ijjovvw?=
 =?us-ascii?Q?tB6gGdtiKkarauo4LJyuzyei0JnTBp/N34GH1OrB8/uN8q2+X8J+0Y6fLbF1?=
 =?us-ascii?Q?N8uQSFKi5IiQ3U4z1gyM7o+7AL7BazHPXhVtL+RyZ10fcnRUjToaNqOZ3YPv?=
 =?us-ascii?Q?lnTOX6WEallMW+3iGY6LRZVMs7aLjTWk7JJnK1sU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bacdb00-c3e4-43a9-3d71-08dc7947eff9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 03:41:45.7338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zv5pJ8QQYxYa6V2URaGW5vDeU5PtKctylJ+GiyKO+RARCzOCOO9yxdAs01jx5ZnjPMidQmosoVCnQMTRBitttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8212

Since commit (5d8edfb900d5 "iomap: Copy larger chunks from userspace"),
iomap will try to copy in larger chunks than PAGE_SIZE. However, if the
mapping doesn't support large folio, only one page of maximum 4KB will
be created and 4KB data will be writen to pagecache each time. Then,
next 4KB will be handled in next iteration. This will cause potential
write performance problem.

If chunk is 2MB, total 512 pages need to be handled finally. During this
period, fault_in_iov_iter_readable() is called to check iov_iter readable
validity. Since only 4KB will be handled each time, below address space
will be checked over and over again:

start         	end
-
buf,    	buf+2MB
buf+4KB, 	buf+2MB
buf+8KB, 	buf+2MB
...
buf+2044KB 	buf+2MB

Obviously the checking size is wrong since only 4KB will be handled each
time. So this will get a correct chunk to let iomap work well in non-large
folio case.

With this change, the write speed will be stable. Tested on ARM64 device.

Before:

 - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (334 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (278 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (204 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (170 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (150 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (139 MB/s)

After:

 - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (339 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (330 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (332 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (333 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (333 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (333 MB/s)

Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
Cc: stable@vger.kernel.org
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix address space description in message
Changes in v3:
 - adjust 'chunk' and add mapping_max_folio_size() in header file
   as suggested by Matthew
 - add write performance results in commit message
Changes in v4:
 - split mapping_max_folio_size() into a single patch 1/2
 - adjust subject
 - add Rb tag
Changes in v5:
 - no change
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 41c8f0c68ef5..c5802a459334 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -898,11 +898,11 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 {
 	loff_t length = iomap_length(iter);
-	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	loff_t pos = iter->pos;
 	ssize_t total_written = 0;
 	long status = 0;
 	struct address_space *mapping = iter->inode->i_mapping;
+	size_t chunk = mapping_max_folio_size(mapping);
 	unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
 
 	do {
-- 
2.34.1


