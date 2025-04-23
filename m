Return-Path: <linux-fsdevel+bounces-47086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D76A9896F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 14:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DB71B66B83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CE926FA5A;
	Wed, 23 Apr 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Y3NCPOKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013047.outbound.protection.outlook.com [52.101.127.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE4214813;
	Wed, 23 Apr 2025 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410486; cv=fail; b=mNUtiZnSVuhmeY1eFA784ehur6sN8IXseSfKbVOhQLbIQwtjQmPhYmLin2eIhPCRXtuMouv2p85CiOqbsfwcgIhbDLlo2y0I9lHccGpPVurVeXOB6MzGtfrZAXxmmTmdyqHX/LGbxu6QZLCLHhBuCFbaG1V5cTSOAY4LeRHIA2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410486; c=relaxed/simple;
	bh=jvUKdNk1VdEkasjHIUcE8/+LvWpIuCyHVeOMKeDtE68=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tR2ubSo5bWampsRRMXHqYgurMlQob2pa7kRLb70GQsyLborylnnvAu+9wgFsnd4pIcp7sogY+k+5QUjqCoofchdnN9zu2EQHfOQlEx/BcdTOHGn77/LUiyNxwSs1ceHOt85JFow8nMFcgKqEqvgLhA9wS8KPbN84C/ZSi/FjuHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Y3NCPOKa; arc=fail smtp.client-ip=52.101.127.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXhibnIGir8zRxo1GX1nzeAOrgI/OV8URtTc5oIkkDL5D5U2VG8qlnwvOdEoE41QIeTgm1e1yTbyUhexqDQx/4c+yBX+CGTm83/ezJKUdPSLMsYlEup2UeFIPGP1+6yK9VOMtpzznDAtHTfA31M3Jq/Y9suRBcFRpbrVCSyORPEHOAp/X2vA9TZdizP9Qm49zyZIRmq3UBR5E2YjI3eV9aJrvC1ybQG26CDed3+tOvh+9jKexzq5864tXi7h8GgjCj4cdMkvZ/y5EKG12EqSk7CHIg1kq120Y9ugnDsyIoVhWt6wnaMyB0Iy20Y7xQJD1077r01MZMUOET1FaJ6zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHT/dLBDjhH2+I3USSPCFiIKuyFyc0QhsJQ3p3WWSes=;
 b=dnrgqRIVljeTo3ZWqp8aZrzquwDs3bsTvjAG3bxgDEPBEpE3fr4eHpvMEW0El46fAMD5Emn91/onRf07f6SS62XfzRkB+zij6TRTMMg74QXuJuM3bijUBGuPN5ecb728r61nljZtxinaaEzvJe9CXYbc6ew2nv5Oeo5E0AI4wrBaIOTltHKcMyM5l04daDnrUWGEdVXb6i+evqL3vdhPWMkA03QbLXPkd8OhVHbTdlmPUTQ6tEp2fxSg8jAle6rDbFxxEU8EFxkH15993kx9NORbp1+5v3T7WXT83uQjKKTF8eZOkQK1KboKifr+nGysGkhkRc9/zqHmuFw9egL+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHT/dLBDjhH2+I3USSPCFiIKuyFyc0QhsJQ3p3WWSes=;
 b=Y3NCPOKaKwRSUPPb+oYzzL0uRRnD5SMoHfT9Ao9iLsahFs1BYAJcA3BesACgtDhQnulF3jOQrTzkrtGj9ZxGnvhgdh2uBOUJaiP1OrrCI3GXxnBs2vYe4yzH1wjOuSdMPOO/BVodv3NQbihR312dyaYWJEF8Rz10iZsaYGj+vRmVHUQdw2WKNlWgELT1PvQMlquOXn1tFmJpyu/bu1++MutDVG5tgsta96VcYvbqOpulYrxHlkfA2r/7urLgbFH8IH+gD6da/SLJuf8wtrhmlhMb04nCSnxAWfjmTLtfeHMw/ycbdOpbMNNw2OwBt93+0aR+opYNyClFByJwJuxhJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6257.apcprd06.prod.outlook.com (2603:1096:820:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 12:14:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 12:14:34 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	Slava.Dubeyko@ibm.com,
	glaubitz@physik.fu-berlin.de,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: dsterba@suse.cz,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	jack@suse.com,
	viro@zeniv.linux.org.uk,
	josef@toxicpanda.com,
	sandeen@redhat.com,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] MAINTAINERS: hfs/hfsplus: add myself as maintainer
Date: Wed, 23 Apr 2025 06:34:22 -0600
Message-Id: <20250423123423.2062619-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 2323aed2-0ec1-47b2-db23-08dd82606861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZjlgFu0v/t6FmBUen9fNWjR/XBivSBzx95KGja0hCQQ7OBbBZVQt2iAhOM8n?=
 =?us-ascii?Q?bBzrQkLMmExNDzrNOOTj7lJH2l88QuLjL0bSsdTiJoHtxY4+UKSg68vIB9lK?=
 =?us-ascii?Q?DoEsfzR66odHgwdJmIECjC97eQsUaB5w5OopBKQlTie8KquhPAHSlzmA2Wjs?=
 =?us-ascii?Q?IAsxOqjn8zkisFXaZoVYLfUgC9fLv6JytOZe4CLQG93I3vs6JF2qAALSSZgq?=
 =?us-ascii?Q?N/MLAyn8LB8BdeyiwpzKxT0CHJajT2If6gx0I0U7vLoMDQsqRi7LVUSSf7/m?=
 =?us-ascii?Q?WPmPCWGkO+MKHxjC+cKnOCRQJ2rWx3YElS9I/A2In7lVZXrjF/53FBGRdrvg?=
 =?us-ascii?Q?GLSKlefDDZSY1auQGqk01MLCaV5VpCASQkcBX8jrOK/GZDSAdFVxAiKo6VDQ?=
 =?us-ascii?Q?5lX6W0aEZz/wgOsTMsfNWqYZlcXBtxt1g9/JDGIrL5VBH5JaprPlbWoPiFL7?=
 =?us-ascii?Q?pfN8jKrWtF5PFPIsuuuSzwwmBagOpBYEcrxuu1DhKt0rNOZCQ5/L5XY6nSaD?=
 =?us-ascii?Q?uF2OcfVUA3LxE7MBvKFRorkcSzjDPoUOkaXzgbLq/0YDpdvTyoxgSIUulW0E?=
 =?us-ascii?Q?5QbWrtaVjWuETxSL15H3ExSfauvVjj1q13MWxZ+xWOUt4MYYzsQxf9In/xDm?=
 =?us-ascii?Q?Zebj91G+MSdHHgJ+YszalfdvD125YRNSzt4apXm49Q/4yW8vNZbBJ0OfJd0z?=
 =?us-ascii?Q?eLo1EYHLDMaFA9S0trcfgw4hPShLi9uSbN8YgCMR0X478TbHsMXRB0r289oA?=
 =?us-ascii?Q?w8JcwAwt9y/jQ3IZ4aj+QojvPH6ncrQKWV3pmx7CdUj3ZZPMgk438n8sn50s?=
 =?us-ascii?Q?00vJ1BMSfyfP+B+ATJk5W4Ea31tt3od7tvAdmZBoy42GO3vYe1KwxNF5hnpx?=
 =?us-ascii?Q?vThLu6wbTwi3ZnElzRgZEZYRYpg7Ant/v5D8Qj1WaTVWhg6p0kzfpAKFyeoH?=
 =?us-ascii?Q?dosny6Joopg6Cua2wlMSljn507K3lsv78Lq+jx/gNXCWrS06tC+FY2BhIA76?=
 =?us-ascii?Q?dLY/X+IbIpeTK+0EwE/ULjbXiBQuvuqYw3IOhuLECIXau0JL1ylPbjOVKrza?=
 =?us-ascii?Q?stAUTg+ti6YIVU/dN4t3Zs3Bom8BTOWvj6W3kGHGgpQQrEotkxQKbu7hkX6v?=
 =?us-ascii?Q?qzFfm2/tlxJ4LMhmXd22Lj4/JLxiLyRTWHRhfulQzfhTOgm+IXUW3wbA0JqD?=
 =?us-ascii?Q?JvxUTgd5lTXd7iYKJFBh+fbpTraVvaJqMjCqXaDnJtjGXvMnao+lF7hdN2U5?=
 =?us-ascii?Q?oJZ2Q01VYe0LFTN+qr/RHBJ+4hXkE6ziEN9FKHHwi+BCdTSJpDXN3/St6rH9?=
 =?us-ascii?Q?haCV/rwF2dR+RwHR0hvCb/LfFU2hetT3Zl4EBdbL+SMMJB4Tus4a5NRp4W/T?=
 =?us-ascii?Q?7JVpSJ3kr0BNAGVsHeEbD0WUO7HihtiAA/9p5SLdOh1JfWPnnYVzxnuHQwDo?=
 =?us-ascii?Q?8cFWtNz4O9UEwMuJ639pz5mchkWY27iShoiaSKQIQkcPjqE1EyXC0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7w3opZDj26cdzFfm6OKc6SxP3udIBZbOnoLq8Vem85FUFEm+kbN4/L7K+5uH?=
 =?us-ascii?Q?hNL9Fd1mI5apKYFa59wLCaAMjDF31qHLeOzrQK2RO8spoVdZcj7BgKXv2BgZ?=
 =?us-ascii?Q?gElhE5KFBIAGNCDzN+YPzybyucatNDwb0vpbvhUaZHwGNusXGJFNhWjprhvU?=
 =?us-ascii?Q?APx388XwDQMTTFKkrT9YBcH1TMGSSzjuRJXPoqHApE0U3zu4plxSabqffbh5?=
 =?us-ascii?Q?kIOXm0utwPsk8iRJSU6iruhzaSGGZMuNAvINnG7CTeWU8BWOMLh8A3VuOvZK?=
 =?us-ascii?Q?IqDETjkNlwUsJFbtVDC1ZeV92eSGeI9EBZpJLCml3OFihzXg2a4KUfHXGmC6?=
 =?us-ascii?Q?GSo+iK2svqi6m4OOT4tFFnoqGLME66BTUSBAYRmpi0Q6DInCl4GmR5IJ1TjR?=
 =?us-ascii?Q?nWgSZ+dptC+qYB+x+bXWQMv2pwBanGMIY64hEOJUFZZVWFJLClUnQVsNqljx?=
 =?us-ascii?Q?lkM/sF8yLHDH/Jmtvh3ChezIaKQl1iAv0cYzDMAzRCKNssVU5Y3k1hkKUu8X?=
 =?us-ascii?Q?Ri/DigxIPBrkElAbOP6zUFUr1Wc9clm6yheRl4Ug1Fvc/1faJssb/MZNkWQr?=
 =?us-ascii?Q?VYJQ9ugnCCG6uEUGJgNbo0+KENb8pfmivcgdfT5Z07yX0iMY24J4SMc1B51Z?=
 =?us-ascii?Q?R1133vIkp3wAWfv9h+lyw+Qk5VQ5Zu0YbAPMw3GNYAMEuDo4cgyodF5j83DS?=
 =?us-ascii?Q?vEqPJsThBhAZkALVcAPy1qzcheX3gJ7xYPni5rsgOwnV7zVfsp/XPGQAQcWA?=
 =?us-ascii?Q?Ob4CWgCjkKAZ7EnQsr9kLRvoH8vNHRVZ1jqqHw+Szj5xIA+Zacf0CsYhYSxI?=
 =?us-ascii?Q?P+hAJLRWPL3C4/LNo5rxIPLcK0kCvqrfWQw1INl5nxG5PO87wNlPwK55GgwH?=
 =?us-ascii?Q?ipTKgdAnuROJuFrs4q9POQ4+D0wbXTxXssZesj6qqnnbRNHiNH5q/gHFRdZz?=
 =?us-ascii?Q?BOY2xb5ZqHn48C5Y28C0tdIAgxuKBYyxRHW/4c0S8p3qLJELgpvyc5NHpwsj?=
 =?us-ascii?Q?8cprxP5UXO+h2HdlD8fDvkVzKDVCzyEWbsfEzSKe3MwhlB+B8u6KV7Bkn8MR?=
 =?us-ascii?Q?lrtKGCBsAB1l8ToCfJFYqGise956LPFk2YWjR8bJYRTrSprm8VgdbABERdR9?=
 =?us-ascii?Q?YsCdCHYpP4zF83BFKP3AcMq3YzNcumUcxQLBy24S67zZ22mbgaYrD0UTKT+5?=
 =?us-ascii?Q?0zEocTIGn64B4ca3F918AVUtvrOSLNctQU9nrsI2uGaCVlBoWs3/HO5fJXBY?=
 =?us-ascii?Q?DYImBm40BG0cYNpD6urNsfgLrHdbaMFC7eCBFSjOYw6GHfvHZwsr37FQm2c4?=
 =?us-ascii?Q?MmAxCh+RgurOOI5rXKPp39InV1vy98WpP9t8hCSrTIQLxrRn0tnuaTfY/kG3?=
 =?us-ascii?Q?BnBOtLYpp9yLny3vHrH684I8Myou4/EgwvaUhtmRC7cl7DPWAvY3wGFHgnmj?=
 =?us-ascii?Q?SHQm9uX9Z9J70eIEOfGg3NJnnJgo5/UCkX2wH5m06nLCEUVm7qHvObTGrECZ?=
 =?us-ascii?Q?UleRLn/mLXwJhHVtja8Tto2i8e8+FNNWPZvVJh+pTWRGTv0VPxKVcMjOSAks?=
 =?us-ascii?Q?PQA9RFh763jpnXJxDUUGGPYpIf35s2UZYxXixi0X?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2323aed2-0ec1-47b2-db23-08dd82606861
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:14:34.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOLS7SoD8j1OBSfneLfKFHN5vbWf3eg85zQTpVghwnBkiPEc9p8nEXVXaHvWxreZS4NPsM9u/5iKncOhmKddUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6257

I used to maintain Allwinner SoC cpufreq and thermal drivers and
have some work experience in the F2FS file system.

I volunteered to maintain the code together with Slava and Adrian.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b8d1e41c27f6..c3116274cec3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10459,6 +10459,7 @@ F:	drivers/infiniband/hw/hfi1
 HFS FILESYSTEM
 M:	Viacheslav Dubeyko <slava@dubeyko.com>
 M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
+M:	Yangtao Li <frank.li@vivo.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	Documentation/filesystems/hfs.rst
@@ -10467,6 +10468,7 @@ F:	fs/hfs/
 HFSPLUS FILESYSTEM
 M:	Viacheslav Dubeyko <slava@dubeyko.com>
 M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
+M:	Yangtao Li <frank.li@vivo.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	Documentation/filesystems/hfsplus.rst
-- 
2.39.0


