Return-Path: <linux-fsdevel+bounces-49917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BACAC51B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 17:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A843A8E6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404C027990C;
	Tue, 27 May 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="mBbo0FC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875682CCC0
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358704; cv=fail; b=sfkUooMkGRFyRIu9ie0RFVNdCn3kxmqQyDkgNH+YxeK/OOkKTrZC6Xt12lMqtssaoHxVqDomoGCyoht3o0p5htYztr34PxXuFmVNfX1KNQXkycLu48eU8bmKZJoNrJXMZbqWbNf8lTqpYi7dS3pDV+udx+4VPd0x8y/MLApnsSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358704; c=relaxed/simple;
	bh=hNT+gLYAx1vTfc+i7HimzHWN824NPkWdFt8ONt+zOWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNe1waOih5apUtE275LiG3S19PUcR3s3rb1B37jSYCwH3z5mlRMSQHqHv/2PmZF1uifCcfWAuJM+du8fVXVbDeaX9OletK3E/KXABL1Le1q1/Aog8JFAZyHoNialptAyXgcJaXx+hfQFi9kCjyGZOiTO8vQRw1N/N7gneZaS1ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=mBbo0FC5; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sofd/VIL33d6JSBrNjRYCosPGhH5F+qn7anAOkhtzWmYnJjbXli0LdGuyVf04vMI3ZYRieJa8O7t0pGvYwNikzwwm7xmuyN7zgbDmvryRbisaAPeidb8DobTYjRjya3/ijS9GcsIWLaqV2SHqf5dDc+ZEdVDPIzMRPmYxY1hQxV9OeH8MEbeAYmm9i/OFa5Ni+RPzIY8LaP4Y97de39uSbzp8aSsS38sCuyfAWeqo7O8ZswGovM3XTTtZb//amDh6pozqiNYx3hRLfbBa9YNbEBka7Xnk9IE7ebFI+K/gi27SQgPlS9n54RBBqlHXKGgwt7GSiPbuCHs4BQt5kBQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JENrB9W/QYKOOVrYxxNh1D4duC16ZWRRqQrYKyg3qR4=;
 b=F4m9Eq++7Bamp1t+kDPLPOxvOMy5VaLGjhYbPZPlACS0EWHpn5P+30Ca5UdiJoeeU/umz+tOOhDkiKWvkiqwCcyqbf12B3bMBZfjxoFRYYJS8oV/ernGFwxNnsw3gFaHImTcJ/cA+E8+tRRUPz1ymmONmB5GFAfMCVLyXXJrq7qSGQ4RKo+LoZ7GSGTfLIb1tY3Lcgfbi012Je3/cODD+HMX3AQaZcwZaShY8TCAfRyCU/7d8K6kKVHg/0ShSAV+9UzqIoKe6JWxHWIDicn4kNaH3hBID32uOfp/BrTAJHDDVVhe6+UZ2BBiiHbv3xkSzrxfydp7iPZkbd9YaDs71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JENrB9W/QYKOOVrYxxNh1D4duC16ZWRRqQrYKyg3qR4=;
 b=mBbo0FC5uZFuRKGu67YdGUKtgmdGe+HY5qN5zpn0di87V4r5kosIA18WWaVzUjs+75wx0erWwHNoT9DyhoxYzEU0GRZQPFFTb4LillUxTTLQcO3ok6r/wTO/y6gUsuZEh0SV5Ly1NFd/7VGRb8oiCl0vpF6vKd1JQcIhKx/f6LEzW4KCkU1fjZWeMz7a5J3OhdlDxFaHvIF+PuYLx21lwzKVBqyP8+4s1X5mrJQkxpyWIh3chHi6HH2ar74qCmeDEOa1mm7uePe7iYhSHyEaN6lca1sCj2p1He+ac+T70D/ZYW04WDvS8MyVXvUL7L37SkHeS2xmNt7aLw+O1KAc+A==
Received: from MW4PR04CA0389.namprd04.prod.outlook.com (2603:10b6:303:81::34)
 by SJ2PR10MB7620.namprd10.prod.outlook.com (2603:10b6:a03:53f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.39; Tue, 27 May
 2025 15:11:39 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::3) by MW4PR04CA0389.outlook.office365.com
 (2603:10b6:303:81::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Tue,
 27 May 2025 15:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 15:11:38 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 May 2025 08:11:38 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Tue, 27 May 2025 08:11:38 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Tue, 27 May 2025 08:11:37 -0700
Received: from se-jocke-lx.infinera.com (se-jocke-lx.infinera.com [10.210.73.25])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 3267AF400AB;
	Tue, 27 May 2025 17:11:37 +0200 (CEST)
Received: by se-jocke-lx.infinera.com (Postfix, from userid 1001)
	id 2C659600595D; Tue, 27 May 2025 17:11:37 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <linux-fsdevel@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH v5] block: support mtd:<name> syntax for block devices
Date: Tue, 27 May 2025 17:10:11 +0200
Message-ID: <20250527151134.566571-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519150449.283536-1-joakim.tjernlund@infinera.com>
References: <20250519150449.283536-1-joakim.tjernlund@infinera.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 May 2025 15:11:38.0143 (UTC) FILETIME=[A4AC02F0:01DBCF19]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SJ2PR10MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b62a36-8136-4560-45a1-08dd9d30c777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NaAk1l7EyzFAjI42sAtcMw6vKHSc8pvoycCJbI5wd4LTc/HQJ1X8rjecYFLk?=
 =?us-ascii?Q?7xL9JjJctFFBZSMkPhZAkYQfsKimWz7IFrWJRxZ+7hgotv9RChzzoN+MUg30?=
 =?us-ascii?Q?ShP6s6/mDMLT9FE4RxnBJQm2lZYwybeEEt5NxdUiPY566mp84D0pomHnMkxY?=
 =?us-ascii?Q?g3Upv7hX6kvk5RTI0npUKwQzN6kcPjDyE88HsTwUPnL3WipIMJbUrMGWhDal?=
 =?us-ascii?Q?ibNdlsztaTukl6XqvO/SkmeSg3xVyktQENiH5CoQSqr+vC7ntmetjbOHEA3d?=
 =?us-ascii?Q?iiTrtpCFHANQFc/K8zDbiP20QKVGiokxLxIGJh33NhCT52eB6tMm4pFBl0w4?=
 =?us-ascii?Q?5yDW9D1hSDIi0U5ELwO2elkNO94/lZtgH92tWFhXyXlsFK6pgqrhA1//ELMt?=
 =?us-ascii?Q?FVXnct50a4uk3S56k6V8DR0lbUCQGXMdxYXBxgKkxyeJwjaiqsV8oO8dlpC+?=
 =?us-ascii?Q?WsbnIRQbnF2buS7QkRV0XIKHQXb+gPn+LYxwVVgFwc+aHMublAG7Q51EIWxM?=
 =?us-ascii?Q?RXJ+xFZ9eKX96wfJMUNMlJZDzI2sXin8+n9Xa5HM/ipHCZ5SJ23tB0dHPXGD?=
 =?us-ascii?Q?HxwyHAMKp+bKbK1x7f/7rG9lJo6C7OaerXgBw4nnZA/QJ0CeLaEcF862E959?=
 =?us-ascii?Q?cWwA04a95mIbXf/pO6bwB+UtaKQtA6JSMLjLRXWoUoM+7ebOigiG7ELy80Ec?=
 =?us-ascii?Q?OrYROUnknGIgMVTMuVCCKks2QYf9WOHptnKHlnfsBcmbH2j4Q/TGBL+mhvCX?=
 =?us-ascii?Q?+3L8Bm3eMy/Dzn9JO24DBqawgvn1irXgUmDeOKHLjdVJ3lbmlUmzgCnoqSwv?=
 =?us-ascii?Q?HLPd7WecUoSIDkwIjeVrDd3Oe8mEDhg9TVkKY52lq+w7J/QlQHmJZ6LA0Js8?=
 =?us-ascii?Q?3GoftpGjq38c+lx0G+U6AGeaNRqw7b8qUQM3axOC7I0lT9EX6cG93Re5Ksxp?=
 =?us-ascii?Q?QcarxVC8C7LNjJDmf8enN8RWPwFnlgeayfmQcOhsR7dJ0yUySQk94V45V3iU?=
 =?us-ascii?Q?QFHjGbVAqMVqRrIh22xMlOqu3h/Y6JMGVsphNfD91wGmQ7ifSUMRtFwre8at?=
 =?us-ascii?Q?+s9xtc62ucPWIchQbykQOuVRwT79+w1O2ydKZwEXg1RTcO5Ia5kldKaGpI/n?=
 =?us-ascii?Q?EkjWzqS8aTCCLErCFXiBq4wXG5Lyd145t3RbVxSq7C/s0dO4ZeOpdR+Rdcfp?=
 =?us-ascii?Q?nNeBe/6wRGZNBS1PJqkRIp4ZwIrIrER/W9/FZ4TOUSq6zNN397QeNDCa3U0Z?=
 =?us-ascii?Q?XfHML13+0B1+gKny2KzokpMkxviIgOSOUGhrm01GRwtOFjma5Wc87ezIGJou?=
 =?us-ascii?Q?aZz8LSm16dj4E8HtqAqy+P5HgcflZcY12dVVuAdxNYcdGRqtuKmfY3WIzydJ?=
 =?us-ascii?Q?U8BnIWLkP0QlnS5KgLfQP8u4ZBc8mA6ZfJbTu5FFuRnoBHcHYIyrga0qJaRL?=
 =?us-ascii?Q?vQcxYUu1nbqhotGvK3JMPYAFKEHpa7s/5lcwb21nr8udDPm0yPheqe3NOSMf?=
 =?us-ascii?Q?gzzPpFvWWwq5QvbiRXey+7SIgNyrZH/mrAzZ?=
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 15:11:38.6388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b62a36-8136-4560-45a1-08dd9d30c777
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7620

This enables mounting, like JFFS2, MTD devices by "label":
   mount -t squashfs mtd:appfs /tmp
and cmdline argument:
   root=mtd:rootfs

where mtd:appfs comes from:
 # >  cat /proc/mtd
dev:    size   erasesize  name
 ...
mtd22: 00750000 00010000 "appfs"

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 block/bdev.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 889ec6e002d7..f276b088eca8 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/blkpg.h>
 #include <linux/magic.h>
+#include <linux/mtd/mtd.h>
 #include <linux/buffer_head.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
@@ -1075,9 +1076,23 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 	dev_t dev;
 	int error;
 
-	error = lookup_bdev(path, &dev);
-	if (error)
-		return ERR_PTR(error);
+#ifdef CONFIG_MTD_BLOCK
+       if (!strncmp(path, "mtd:", 4)) {
+               struct mtd_info *mtd;
+
+               /* mount by MTD device name */
+               pr_debug("path name \"%s\"\n", path);
+               mtd = get_mtd_device_nm(path + 4);
+               if (IS_ERR(mtd))
+                       return ERR_PTR(-EINVAL);
+               dev = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
+       } else
+#endif
+       {
+	       error = lookup_bdev(path, &dev);
+	       if (error)
+		       return ERR_PTR(error);
+       }
 
 	file = bdev_file_open_by_dev(dev, mode, holder, hops);
 	if (!IS_ERR(file) && (mode & BLK_OPEN_WRITE)) {
-- 
2.49.0


