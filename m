Return-Path: <linux-fsdevel+bounces-19739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748838C9807
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 04:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A56128134B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 02:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D1BBE71;
	Mon, 20 May 2024 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W4G49SvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050779DC;
	Mon, 20 May 2024 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716173279; cv=fail; b=qn4uM/WkVx0HZQ0X5ouah6VcZiXQEZ4tQa4fLJi3Aj87xJGtpdb5e7yqcwFLEcH1seL9/CTAEkJEMUrUL/qHea7s5vv8hVFqatHnASc8+A30t3rKfR9IbGmkBL9xTnAi9l4T8cr2mrZ6KizTuhF8VJt3lBNL1h7vBjLSuHGl0+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716173279; c=relaxed/simple;
	bh=s+21p3CM0tqxLP6iis/KmaMWWGiGqM2u2N8iVnwS1Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LL/qGWKTg+Qo7QSxHHjVHQCZbJS6VQbkphtpLHd+Xxsmfw5AjSz8EXVF4DB3zjJ8obKgXqUbWTfuXPMiCUFKSHV7tqSy45Gw88eNVrrehI7k8BC6YgEZz0cX6v5CIxCKmq7cqkZDOloZXm+nRjnM78tjoBMN+P1AMd2tmDWVKi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W4G49SvD; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB1oFnaDN5n4+xROG4BcBhtvqvd7eK4a3pOQ2h+2hxJum02QvFavF/K9G9tL+RLbo0mV24WW/qbZ9z4PJE+KONnj8EVN4Y8ozZ4tVWyCarAgOb7GT2HMrjhIS6BUbbBPDkoBpC3IN+lr71Cf7Mx/Q4Ue2h27BQVnlmdO2aZXxqMUmuJyjP0ij2VWBKOKWCPmEifgYykOXbuxdvJo0/Gm07QxZkCe8E+kxd4oPNNs0Pdbqap1HAfIRQdWp/vPzPgRrVwucfCdMSlLwq+AFyM4Y57KyUDtciD4LoDlxS1Dt6RQe35UFUKsasy3uxjArmcZyFDT5PH5d2fdSqCVu3h4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1CeLY9i2Lvi1+WiZZn9ICMCi0fPSRe+y07fEevzw/g=;
 b=lWTGFWMr2zvaAL763ttB7xU7S/tTpFyvw4+HVoKgp1JVtaOkSlsT1MyK2TBSzmFQUbVwXQRH3IyYqd9RH82pye1eDT9tY0uBwCZM/7xZIt2IsBvCXuoWIIAz/dQgleugqNbMKZ76na6ZX9Zu5LWyADFXJvBoLPb9j1AkrHgPzKWQQLGuJJLz8eRlTwxFzTGYuUH2jLf/9ynIEY4tTcJ3gjV52qZow36IlZtzwaKsJv2jkvU3wjD2dGmkHvoQ12VjtLg27672KaTZ5mdV2uAzhjcw4EAhvjoyHNu+eQGFg8ZHLRJY2ZdpCco8wjWAl/Oswq1uAVRT5QbrNOIgNFgZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1CeLY9i2Lvi1+WiZZn9ICMCi0fPSRe+y07fEevzw/g=;
 b=W4G49SvDnFrv4lb+572JUKZ5GlOVqD9S/bx4YO9lAQFxff4lEIwRHKpWaVaIJU7ygBnGA3at+GE5sjGC6H7h9dje+uA2vgrDi3fhB+UsKHAqBkCzHK3q26XQFccqR2s3mhRov0EfqH0xtooeSJP+h7NIY6yCIGUdTDyj9XRf1fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 02:47:54 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 02:47:54 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	willy@infradead.org,
	hch@lst.de
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jun.li@nxp.com
Subject: [PATCH v3] iomap: avoid redundant fault_in_iov_iter_readable() judgement when use larger chunks
Date: Mon, 20 May 2024 18:55:25 +0800
Message-Id: <20240520105525.2176322-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA4PR04MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f42c3a-38c9-4ddf-c870-08dc78773f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VUplPeIuPGa0LlcofUFqFG2KaR7VtU/ZWT8yH+rZ7ZNTarFBzOcfBrX9i1O6?=
 =?us-ascii?Q?DaPbNSG2/C1mRb5CCytQzvbDfPYVWMI2eLTZsWAtU+oj2l+Rvo97O3QDqlxE?=
 =?us-ascii?Q?gsAYBHLhLDboDEdxfhJ85nZ8FHyffaluKdwmXCUePf0SRE++ietEfikM6Fj3?=
 =?us-ascii?Q?6hcmXrx+W+AbwpUEzOii4HGu2gI8rl5NekkeVHnJdzJoGKOxBkqels3InrFe?=
 =?us-ascii?Q?gbSNjsrjBka1nSx/t2y+LqB58C5eDHEWeAJ/cXeRuczgGnrc9qY/cAsVnA9V?=
 =?us-ascii?Q?H4/TYwR5MS3fLNLgFpYVQ27PiKmTxS3XPyv2j032vcN3hx2JforbMhgJYcAI?=
 =?us-ascii?Q?s4mZNRiZ32B8EhU3ORzM2nxfuxTLMkG7i6uaz+T+KIAA3dIlOE7ZVfDlqdDM?=
 =?us-ascii?Q?wn1W7wQimBJbWKS3mOkZmt410Rl3l0RcZozDeMLEp/h4LEH1HOWmxIEgfL7w?=
 =?us-ascii?Q?WJbbcdpBA6WexPnbOH1H48pMrjmGePMCdIConLu3Ay+X5avdZkRFSd2XnUcf?=
 =?us-ascii?Q?3t586LQr3CjRl7mEsfEMDETs0KMZX43rNVfBvPcC4Vraop3WVF6y0TFkybYN?=
 =?us-ascii?Q?jqqoa90CCFsev90Z+856DEM5nQuaruqG9rlYmz4rzyVjnKjLP7mFBlmReYHz?=
 =?us-ascii?Q?Pn3KnBOovreG8b7nHBdP5dDJXGASCoz58FrK5BwWbUXZiFcaPLWrhm94BrLS?=
 =?us-ascii?Q?5/oQpWAr2OfAEO4JhQkN/HFxBOG8NxfqgQZsSuJgAfTQ+GMXX6/4Rddu6SnD?=
 =?us-ascii?Q?hryTmkgmcubmW/80H2gG2RrbpcQJxjpKBJxjFPqj6jq68MPHrywp3QtAtBPF?=
 =?us-ascii?Q?HBOFy02+Ngi1QO5HO6g6fwiUHzglwomTMilwR1MQbM42vmpa8Vu3p8GiM0mY?=
 =?us-ascii?Q?QTNuHoYf5zBBEl0MAd1/feC5ag/KRZ0cLqxkc6Xvady7dxBG8qfCqV8rNJe1?=
 =?us-ascii?Q?1xOAVcGeTrRMVkfJoCDKulUern7ORLKcF5Yok/Z8qyeVU+5akZ+vm3hTpqWB?=
 =?us-ascii?Q?HUHbCvGFglUwar6PwgVuRS23wV0I/i8BF9UBrcg39Fi1BOTPI/j6lEm/nIA6?=
 =?us-ascii?Q?qUako13Jj8Uv3fu+wApLRinjD3VGTIwSplirrWCN/j+sLv9p5V5El1tV8uaE?=
 =?us-ascii?Q?aAOes887Jh/dAzdcCFQf4fNGew82ubyM34V/upeACY1h6BY4cQWdS+/MgQsI?=
 =?us-ascii?Q?ZwfRcv1ilahQ06w7LjgGHlkpD1FNANeE5QWbOGTW/hJ3PXSDGsZOfAUNl793?=
 =?us-ascii?Q?o5ZjQk/YkBkw6ouaiU8aDLhYJkh5DCRKNb9NJ4VWXll52nLRLswKiGucL3zp?=
 =?us-ascii?Q?i4CWppFFlvma/EDyXl5spi1tFdf6vyKc7srbnzAJJslOEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99TjGUx3FOlcPW8pv5AkR62kgncnhfsIhE7PUk7e+D8+yNruGa45CHTFXaMn?=
 =?us-ascii?Q?a0umHATmitFrUdoMnwnZIWZLvKAdBhfutE/aZdlOb/XetjaKpZj9xdbyWvl1?=
 =?us-ascii?Q?LnDm0S/7qVOSZKgEwwReSYoTspmzHYRPDnp3XhXAbnNd8XrOjHengm9LIcnf?=
 =?us-ascii?Q?seabO4orPId0C/sTCg2lB7b7bjlzan8a+eU5KCDkK7m1mlmWFEaPEZaHTYbG?=
 =?us-ascii?Q?osj8CrkfwtJW3z4NZ/3WfeHTLMLUWenqnzYeD66W3X+JzIcMOx72Nj6599Wn?=
 =?us-ascii?Q?oVg47ONRhphbFE1lppM8OzKdVmFK4QJ0cb9GGNbKh+CcldYN59j6V9CJXcHS?=
 =?us-ascii?Q?doP1Y9lmdClSzQc2o6pq1YOOml7t+UwBwFFwbDs0XOfokYFTbZKtSYyrcvfT?=
 =?us-ascii?Q?o5h1NJxGjxLINDj0PIDbhUFZLahrtSO2Q9e0YbHxYeLNUC80+6FqQMqOAABm?=
 =?us-ascii?Q?LVoJUDqByS125zCsVoP0g5NbNbNefa9FSeFmNAMM5ZivnlYJQTcM04TwMTje?=
 =?us-ascii?Q?L+7/Y5pvQx/RF9qrMJ/EfkkuPBfZ/GM/dBuMQ/8yPsj4SUkTrGk+td5aR/Wt?=
 =?us-ascii?Q?4jp562US4hpalk40oWS+MfThzL8JONQLKcoNete5/SYqyQxkRNdLU2fz+Yb2?=
 =?us-ascii?Q?EqbGAxCEnWFtjSTX0FIgjTi15rwMh5M0oUqNbtp9P5v58CHX/5cGGWqW/VXm?=
 =?us-ascii?Q?yV2mSM/xSjtYLIx0QgAP+I/4/5NrjvA/YUNB1EXbkK3Cvf/krP2BhCxQ97rX?=
 =?us-ascii?Q?+mPevyonUGxw+X4Cel3f0tBLySPnYH+DRkSxa1Jj8fa9ADK4eS+ToVZQDfNe?=
 =?us-ascii?Q?2ky6wsstLcKuBMfULhcJA34h+MSJYYVR8PlVvcnMwX8BmoWN1wh9d6e7cFjL?=
 =?us-ascii?Q?6oApgLx6OPPRSR/i2bCqp9946vZ7ceeiENylTyS6aEGxLwoz7htE2x3D0Sow?=
 =?us-ascii?Q?aJb+msT0YQq5ptNI82p0LF2Zq3WPEmJqwt7SNqFgruGDz2h1PIzS/z9MfDx8?=
 =?us-ascii?Q?aUweR02pj2GzWdjmsJYWhZ7qk72wqviF4xPiMo/ig75Ioi/8yPj3Gvz2nd4f?=
 =?us-ascii?Q?3JzW7ziDhBgCg5y6WUhOn9bKowA9ZSd82KSYd+BjkoNCs4VhDDcuX+E2IeGt?=
 =?us-ascii?Q?jsYZH1cV6fpzl8ScpwJWBchZif766LXduTxNTUyM9d0T3T7u2Nv0l7tLGAzY?=
 =?us-ascii?Q?Ps60g3LdR8vMEefeMV17p2XOEZj0Nus0uEsq8XTAst6GBq0BjmWKhZRHHYL2?=
 =?us-ascii?Q?WJjMh44GY/yCkpgzZagL/8RfWJAIDTTvaUjV+HWFr9IudPHlU773Pt656wec?=
 =?us-ascii?Q?BDv2BbnHm7RxjwLSs+vco5UQE/MGW89MtPMrHQmfV8VILMZJdL/FHCnSicNl?=
 =?us-ascii?Q?dYLUv4PqLqk7gzSyhBiMv4Y9iwNCuzm8BsqEo9OY99MbbRtRkktyKKYvHzgj?=
 =?us-ascii?Q?dacB6EOxYLswOLNpysEz1oMG1BxByndyZQ7Pdyd4VX2WH3F70NKUbYPEKVEz?=
 =?us-ascii?Q?bqr2Ci4e/5o1e6iRVPNb2qJO7xIMXtofWFwXvQCH3upvlwRehWPcQy/KBIzM?=
 =?us-ascii?Q?Pw4iaBBsRVaerxHXAE0V5wUGi/DcknA3j2VBG/+G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f42c3a-38c9-4ddf-c870-08dc78773f64
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 02:47:54.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxDOzQPpNSqfyS/fZaamI9BXCI3tae7T7SS5/aUGGj25V6cLj56FX/TSQMch3ibWTOxzFE20NgBwSSYAtxc+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

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
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix address space description in message
Changes in v3:
 - adjust 'chunk' and add mapping_max_folio_size() in header file
   as suggested by Matthew
 - add write performance results in commit message
---
 fs/iomap/buffered-io.c  |  2 +-
 include/linux/pagemap.h | 37 ++++++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 14 deletions(-)

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
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c5e33e2ca48a..6be8e22360f1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -346,6 +346,19 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+/*
+ * There are some parts of the kernel which assume that PMD entries
+ * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
+ * limit the maximum allocation order to PMD size.  I'm not aware of any
+ * assumptions about maximum order if THP are disabled, but 8 seems like
+ * a good order (that's 1MB if you're using 4kB pages)
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
+#else
+#define MAX_PAGECACHE_ORDER	8
+#endif
+
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
  * @mapping: The file.
@@ -372,6 +385,17 @@ static inline bool mapping_large_folio_support(struct address_space *mapping)
 		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
+/*
+ * Get max folio size in case of supporting large folio, otherwise return
+ * PAGE_SIZE.
+ */
+static inline size_t mapping_max_folio_size(struct address_space *mapping)
+{
+	if (mapping_large_folio_support(mapping))
+		return PAGE_SIZE << MAX_PAGECACHE_ORDER;
+	return PAGE_SIZE;
+}
+
 static inline int filemap_nr_thps(struct address_space *mapping)
 {
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
@@ -530,19 +554,6 @@ static inline void *detach_page_private(struct page *page)
 	return folio_detach_private(page_folio(page));
 }
 
-/*
- * There are some parts of the kernel which assume that PMD entries
- * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
- * limit the maximum allocation order to PMD size.  I'm not aware of any
- * assumptions about maximum order if THP are disabled, but 8 seems like
- * a good order (that's 1MB if you're using 4kB pages)
- */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
-#else
-#define MAX_PAGECACHE_ORDER	8
-#endif
-
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
 #else
-- 
2.34.1


