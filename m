Return-Path: <linux-fsdevel+bounces-53108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E82AEA40C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 19:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4A97AC7DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650E2EE5E9;
	Thu, 26 Jun 2025 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="L4Tx1cpN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C0D2ECE8E;
	Thu, 26 Jun 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957820; cv=fail; b=Gz5Hu2DsdFMzHu6nlVRyTQg+EIbW62gbBcFHZ4IZ+4BqP0bn7jkoB8QZOk5ds0sb0yumFd04t+4GnE4Rod5G1aHlGxls6ZEAY+sVy+Acso7iKCgIquyd6gKmGsGFZ/FefrIJFWy2iS9alysctEA1j9IYOtUwe5n+YV2VjTQRE8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957820; c=relaxed/simple;
	bh=Ecftnyh1MLpscmOWodSTk4cq+9pHX4GEIlfqbuEtBAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MBZrYMh1WYs4oQx+gCdryyWBecDuucs1/DPdeAhHt4BB/fpqm2MhEHWkxxkalWbveM3dW1qKE+nHnweuogOUvASuTfZRcg0vldCFerQiT+CikmmQOqAvYKOGYlfnM4nJW/9k8m0uvZ74Ja7Z/W+SYpzlNthMyZrDpOeo3G7oKak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=L4Tx1cpN; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+HcSSyGZKgA1nbsDzVHgwP7MnagOo9gSqT8dC+pJzTLRWs5ayIc7DMcWTAHNvyik7njg7vjGemhiLq69suOh8OA1IuNbxk0eMAfnGSbX4b9RhbUWZ8czAkptffKLOXp15S/7GifakOCqNUfZEYFL9Dkyj/h0abtX35YjDmF7b6bHFvp4zkszpxsdjnkuhmipzirHE+TiA3xHy9CK641nexID4zYSRKU7zucQdTeeFkPTGKugYEbxv9A48NAqjYZ4x+tZxqB/VjNwUnmV8JRY27aag5oBzpuvXyA1HdcZUdv1PufHrfI0m3yqbhNb0wwS4Wi5WvFrCj6w7QgQcxsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhRwRsxneRG5Tmr1cDwh8fsprR2psQtekNQEDMRwxHI=;
 b=sE3X6rQ5Py9V+e1uH+nTgb4xWYgs1XKk6mocbPC+dyUfHZ2CxP26KSL1cHyOlAYy67NaOAroGLi1DI19nOxfaBJlButTDan2V55AuWLgpCrxeV3jp0HFYWvgkUSxX3L67qSQyrgF0PFvnbE7tbPrOQPqfSQDRIznsJuZj2yQdPJM75ONGGF0CCtUw5bsj2V+AA6fbcM4a1FNsjCeOoQk7OFIYApoHkrNn58UQBIZ24DYdoE3rLB9G/tLTFEDkZmZ/phzm+gpCZrBMI6luXepjxacjFtGiUtXraJ2EU0I9v7hc76u2G71W24woXXtqDPUgi5Y7jnl1mrD/URwjKHVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhRwRsxneRG5Tmr1cDwh8fsprR2psQtekNQEDMRwxHI=;
 b=L4Tx1cpNTZ4kgl0ma/UfnYK9hthKi412qv5FiPvEjWjZiZtmrsHUdmXCTH6eZnVAgWd0ijZin1F5TLZk3PRSKpMOzHY6sjxHKo/4JC2uUYBr8Dqukurbuki6DJH1jWjtTjja2NrzgvhAGGGbbAN+W6yhKVHHhKpauArcYrdb7TNJQt07LGo0gv/X9oOX35E7a9/qZF9CfCADmiWpgf/lAA8FdxF2Z2LxgR4aZX4Beo9d7Wo7p9sErhtF7495z3vpeDJ4P53pAxz9Y9cUPz4w8abLuXcUei0LY98nhglJeCKhTwaTTsEBdWBYrGQLgZuvBru61IzqGSei7P7Y1Cfv4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5610.apcprd06.prod.outlook.com (2603:1096:400:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Thu, 26 Jun
 2025 17:10:15 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 17:10:15 +0000
From: Yangtao Li <frank.li@vivo.com>
To: axboe@kernel.dk,
	aivazian.tigran@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	shaggy@kernel.org,
	konishi.ryusuke@gmail.com,
	almaz.alexandrovich@paragon-software.com,
	me@bobcopeland.com,
	willy@infradead.org,
	josef@toxicpanda.com,
	kovalev@altlinux.org,
	dave@stgolabs.net,
	mhocko@suse.com,
	chentaotao@didiglobal.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	bpf@vger.kernel.org
Subject: [PATCH 1/4] block: Add struct kiocb pointer to block_write_begin()
Date: Thu, 26 Jun 2025 11:30:20 -0600
Message-Id: <20250626173023.2702554-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626173023.2702554-1-frank.li@vivo.com>
References: <20250626173023.2702554-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ada354-3971-4233-eeba-08ddb4d45179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F541MZAS0F7DjZmZdVa0pMzi9HWhvyyAYuGeVPQPH6CqLdQKYKTwOl4evUE4?=
 =?us-ascii?Q?vE4TwwVzmjHaEBMdvz/hwsr9DVU2gABWNmkBNVnVxlN+LAoB7qGwnkEGnmdl?=
 =?us-ascii?Q?32jWmjtFI2tsj80qoCuyXV8ahB5/RPwq7Bqr9NrNxIpgoQOvAswXHL5NzOfJ?=
 =?us-ascii?Q?7Eh29vNfQEgnjIc66Hmo6mIauWB3x5mfoszfy4gIIoO6SF5HKhJrYlbxZrOE?=
 =?us-ascii?Q?CilUMa+LGgPvb4RicV+1iKPsR3QUsxwZIg6W591jQCRrasxFFGuhe9SCDGyy?=
 =?us-ascii?Q?kNE1TvVnBATJ1JeHI/xUFmBEEt2N3v22wddT5ipttT+fSA7/BYLH3TgEoCCg?=
 =?us-ascii?Q?yyCMUGGVDutfmLf8CRK8lA51xrBocEPGbAjNzpiNetyRsmNuF6+W0bzuqVn6?=
 =?us-ascii?Q?zNUFLFW/AoklpAUFyuXjrUZZcIGIR0kSFAW2yCZUqK3FuxBYd58P53yloC+n?=
 =?us-ascii?Q?UMVRbQKIgvI6F6oR+9Q9zMnQFEPvdeqf7elh2umR6AfY9AgAP03dFZCBLbfh?=
 =?us-ascii?Q?VL+ccu1dbI7CyOrwkalQnujJW5drcb55xmxVIWRRMH6sktuHVvXiI1+CcLfx?=
 =?us-ascii?Q?i4mibUZf7bciJkEOovDXzvCY/8eEj9t12tG5arjcgm3ozzRD0MqFYuqApVqR?=
 =?us-ascii?Q?KTBjpEf00QVReDOmmZGGNFWVL2Lkej4/0IiiePrDNtFxGmXuolOwqMkJRY3x?=
 =?us-ascii?Q?Nc+6GCiuYVldh50kuueOXNiRut5+/Wan5xyFTgTfJABzs7a12RKPorfwtiVv?=
 =?us-ascii?Q?Ks47Kndrgc7tbos794CVqnUn9OamfXbUFeeGjNj7k+IQLYa1gKmjkje+Zl9I?=
 =?us-ascii?Q?JthbIKay59eM0RE1eIYTN1qQrJ5WEgcqGwUZ2D9Yk/In+jKUBHrERwXJ+pr9?=
 =?us-ascii?Q?fVkqLEg1KHo0PTJydtfKGD7U3UGAKj/8cI5c4h+CpEXpXkRum79E4RoKc87c?=
 =?us-ascii?Q?Q7KmhodwmiPjCpltr1GldZnmAkGqhjGJug9Sp6/A9mpEC3V5LYIDrPB70Y+Q?=
 =?us-ascii?Q?lQfnZpnQk8h3vyft8tVcjHR4rqxr9oAsxRK7ymJQZNhDJwIrBTAnwALbRDpv?=
 =?us-ascii?Q?NJEav895JMQzDCc5VGiNgT0c+kyKWfcwlaqKKhVQ1MAlRsP+LihEQgBQajBq?=
 =?us-ascii?Q?PqUrP4td4WLDfYP+WKUpU2rgeSqXr6YG2jkfad6HMfAFffCNoXQPgFu84XhF?=
 =?us-ascii?Q?G5L20fhhmej/OgyilhiZx38Y0ZexABpOe23M6OhsvY23GCW1gtcGZazv5X/u?=
 =?us-ascii?Q?H1M1ZwEGZFOqMAfAfQ9znnGjAc4DDgXwj44UkzhrqhrMwPG15eKLfTd/51HY?=
 =?us-ascii?Q?7MywJonaugHISVdNJj83Sl3bDPDYq8q227eVKJKflr5W8lcqhmQzBwPvEAqE?=
 =?us-ascii?Q?9AsdgnDvEosvm+Qlx8FNp9bE5VlRbbs0yF8mK4XNDxV3BwkwYzOkCdFxcocx?=
 =?us-ascii?Q?ZE83kbsA2JJ0NvbIQkF9owQlztj9JEKt4GSq/eC2RwTerxA7utONPHgpL6if?=
 =?us-ascii?Q?ZJCgb5Zi/EreJk8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfRDdx+713q9ugl5i4oynrqjL03Y007wu/p5Gn031ab6MKPjQLzGzKxmCHfX?=
 =?us-ascii?Q?m4PLYC8piXxdNtzkG54P+P+06hifQ3mKjGvf4Zg1ghnJkZUoy+gHNXZxIrF8?=
 =?us-ascii?Q?Qrn91U2oBV14ODsG+6FHNWDWTDlyzJ5ByIKfWbkWw29AixIXoRFGYta4IfXU?=
 =?us-ascii?Q?YerMtvAGCoYm0Z6liUd3llsEdgFwWRbKJSQ7r5R4OpN9/k1lbHY4z4BOow/H?=
 =?us-ascii?Q?xdLna89DASx5LwPHlndEMcRm8jCNshZ5ftzwyDwWPCrtsYeJowWEoxmbMi8C?=
 =?us-ascii?Q?fu99LAv45ZELcatu7gV4Ax0AiWGA6ZkIAC95c29EJQngv9MWjvygT+xSu914?=
 =?us-ascii?Q?uQQgVhKNLA6eXU6l3La8Wt7T7uSba5E94cb0mzDjfdka3hH91K39S9og3WgH?=
 =?us-ascii?Q?dhD3ZEDy9+e8DHEK0ILlq8wohSJoZddvqNUL2TjpIhuJ3jmurEd4GtnGrr/O?=
 =?us-ascii?Q?BiGqSOTEZzryN6lMTIsI/49GMYhnWiCxKqr6SGbycuFoSK/n2Z4gdNWMlNhB?=
 =?us-ascii?Q?iSU4Y6DXDbLg1R7XC6f/1PZVpYn/RqyFmEHta/b+AsD5ZEXfx9A6w8cGC00S?=
 =?us-ascii?Q?3WYWWxgPQfgMQiZfUhKQrVweF5nPZI+DKAK4MqgJFU1a/1kYP8EFatPYOi0m?=
 =?us-ascii?Q?MfDxF3HvL5jgJ/rOj8uTfr8VX6HrBnXyUAk1pyl0sdKOP0mR/wCk0kJVjAVo?=
 =?us-ascii?Q?wpH66o5/rufBsyRxMX4DA/Rr4FxnjHVaCgpqBFktSeJ4MqscZnXFhyuhuNHQ?=
 =?us-ascii?Q?LnTIBLQCNokGXqAO2/wXpgdsnM8vrX0zWy/LaWsiJG1g3gfIgGA/38f7p270?=
 =?us-ascii?Q?Q5TBrsmziFF3czzULwTahwfTReBoOovGsQfvfzmRUFFbaqyP5HKLGl90yUvm?=
 =?us-ascii?Q?YGMQTXpiIW85/voIHc0uyDKY+ufO0ynzLajW9CDxe8Tg8O07o+l7VuBBUauh?=
 =?us-ascii?Q?4yWHAQk0+K1hSEa5ECycj9AY4+KytdqwyrbA9gXwkEX86i9uxRJaK4JrLHbG?=
 =?us-ascii?Q?NeAyom+ko3uHCKOnqyMCH4/8hHwVEJmIsVDffAE2qenV4I1q9R/fTHjlXIW2?=
 =?us-ascii?Q?CyTGaFMRFA9QZUuL7/rhA4OyJOSADesW/oANtxJ/2qi03xHAH2I+xBDNOyQh?=
 =?us-ascii?Q?RPbrUH7h/0JCG7FL1wv7bNUHPXGJzQ5IHVRO3QD70AQUiubc0L9QtxDTrkoD?=
 =?us-ascii?Q?inLNbUnJqzDUx74lu3q/GdvDdeUENC+pAIdlvO4qtKXFN0Hkc02NrmJnwPxd?=
 =?us-ascii?Q?Dlvp7EOeiAs0M0oLqFh31PpbubNPi6TdfFpknnuPy9d2SQkWFCilRKlxnbXn?=
 =?us-ascii?Q?hXoTUb/ivVG5H6lxyUYv/DtgVKvuFk2Tv1cWP+qeFC7NLOCEGBQfVV73eCGx?=
 =?us-ascii?Q?43S5u1P4PCp9zI0eh8uhjWi1xc30YBrlJfzTwxNaySgyR28Jk0VmkQdIgOm8?=
 =?us-ascii?Q?5YaOapQ4Pf9sbEic23VTiDC0qOveNlZkhd16ITtwfJDU6a1mY3ylqJ0sIXJH?=
 =?us-ascii?Q?kWltQ7FzVBt2M0MZA0hCbDF6QhAZBfCajIHhEVXosDfZ9Pr1Cyrv9A6jRk7a?=
 =?us-ascii?Q?pTJ/hU/xys+n9+CN0yEFDwlGBgreJdBKA4mgx2bI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ada354-3971-4233-eeba-08ddb4d45179
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 17:10:15.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6yA7lygkt1KYD92qRALbjQqthqkydExtOOtC/PTq7E2M2QNOPOxDWU9Trxu7G/ckryLiXknfeWSuUnlSk2SYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5610

Refactoring block_write_begin to use struct kiocb for passing write context and
flags.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 block/fops.c                | 2 +-
 fs/bfs/file.c               | 2 +-
 fs/buffer.c                 | 6 +++---
 fs/exfat/inode.c            | 3 +--
 fs/ext2/inode.c             | 2 +-
 fs/jfs/inode.c              | 2 +-
 fs/minix/inode.c            | 2 +-
 fs/nilfs2/inode.c           | 2 +-
 fs/nilfs2/recovery.c        | 2 +-
 fs/ntfs3/inode.c            | 2 +-
 fs/omfs/file.c              | 2 +-
 fs/udf/inode.c              | 2 +-
 fs/ufs/inode.c              | 2 +-
 include/linux/buffer_head.h | 4 ++--
 14 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 25ebee01e647..52ab6b5ba794 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -499,7 +499,7 @@ static void blkdev_readahead(struct readahead_control *rac)
 static int blkdev_write_begin(struct kiocb *iocb, struct address_space *mapping,
 		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
 {
-	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
+	return block_write_begin(iocb, mapping, pos, len, foliop, blkdev_get_block);
 }
 
 static int blkdev_write_end(struct kiocb *iocb, struct address_space *mapping,
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 0a8ae8c2346b..860613c876ef 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -176,7 +176,7 @@ static int bfs_write_begin(struct kiocb *iocb, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, foliop, bfs_get_block);
+	ret = block_write_begin(iocb, mapping, pos, len, foliop, bfs_get_block);
 	if (unlikely(ret))
 		bfs_write_failed(mapping, pos + len);
 
diff --git a/fs/buffer.c b/fs/buffer.c
index b42b502fad2f..f2b7b30a76ca 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2247,8 +2247,8 @@ EXPORT_SYMBOL(block_commit_write);
  *
  * The filesystem needs to handle block truncation upon failure.
  */
-int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
-		struct folio **foliop, get_block_t *get_block)
+int block_write_begin(struct kiocb *iocb, struct address_space *mapping, loff_t pos,
+		unsigned len, struct folio **foliop, get_block_t *get_block)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct folio *folio;
@@ -2598,7 +2598,7 @@ int cont_write_begin(struct kiocb *iocb, struct address_space *mapping,
 		(*bytes)++;
 	}
 
-	return block_write_begin(mapping, pos, len, foliop, get_block);
+	return block_write_begin(iocb, mapping, pos, len, foliop, get_block);
 }
 EXPORT_SYMBOL(cont_write_begin);
 
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 354edcccc5e3..3032bcc6c951 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -455,8 +455,7 @@ static int exfat_write_begin(struct kiocb *iocb, struct address_space *mapping,
 	if (unlikely(exfat_forced_shutdown(mapping->host->i_sb)))
 		return -EIO;
 
-	ret = block_write_begin(mapping, pos, len, foliop, exfat_get_block);
-
+	ret = block_write_begin(iocb, mapping, pos, len, foliop, exfat_get_block);
 	if (ret < 0)
 		exfat_write_failed(mapping, pos+len);
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 66106157c7f0..b6700042db5e 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -920,7 +920,7 @@ ext2_write_begin(struct kiocb *iocb, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, foliop, ext2_get_block);
+	ret = block_write_begin(iocb, mapping, pos, len, foliop, ext2_get_block);
 	if (ret < 0)
 		ext2_write_failed(mapping, pos + len);
 	return ret;
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index ac494186926b..6b90200bab46 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -296,7 +296,7 @@ static int jfs_write_begin(struct kiocb *iocb, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, foliop, jfs_get_block);
+	ret = block_write_begin(iocb, mapping, pos, len, foliop, jfs_get_block);
 	if (unlikely(ret))
 		jfs_write_failed(mapping, pos + len);
 
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 01011b5d045e..85fb73b37fe8 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -448,7 +448,7 @@ static int minix_write_begin(struct kiocb *iocb, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, foliop, minix_get_block);
+	ret = block_write_begin(iocb, mapping, pos, len, foliop, minix_get_block);
 	if (unlikely(ret))
 		minix_write_failed(mapping, pos + len);
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 0ee4dea7f364..95cc7e1130bc 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -229,7 +229,7 @@ static int nilfs_write_begin(struct kiocb *iocb, struct address_space *mapping,
 	if (unlikely(err))
 		return err;
 
-	err = block_write_begin(mapping, pos, len, foliop, nilfs_get_block);
+	err = block_write_begin(iocb, mapping, pos, len, foliop, nilfs_get_block);
 	if (unlikely(err)) {
 		nilfs_write_failed(mapping, pos + len);
 		nilfs_transaction_abort(inode->i_sb);
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 22aecf6e2344..6bea9f9f445d 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -541,7 +541,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 		}
 
 		pos = rb->blkoff << inode->i_blkbits;
-		err = block_write_begin(inode->i_mapping, pos, blocksize,
+		err = block_write_begin(iocb, inode->i_mapping, pos, blocksize,
 					&folio, nilfs_get_block);
 		if (unlikely(err)) {
 			loff_t isize = inode->i_size;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 82c09c2fcadb..36d1baf95b84 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -947,7 +947,7 @@ int ntfs_write_begin(struct kiocb *iocb, struct address_space *mapping,
 			goto out;
 	}
 
-	err = block_write_begin(mapping, pos, len, foliop,
+	err = block_write_begin(iocb, mapping, pos, len, foliop,
 				ntfs_get_block_write_begin);
 
 out:
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 3ae86bc2460a..3e687791da4e 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -316,7 +316,7 @@ static int omfs_write_begin(struct kiocb *iocb, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, foliop, omfs_get_block);
+	ret = block_write_begin(iocb, mapping, pos, len, foliop, omfs_get_block);
 	if (unlikely(ret))
 		omfs_write_failed(mapping, pos + len);
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 13ea9aaa30e2..2b4db08e4205 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -254,7 +254,7 @@ static int udf_write_begin(struct kiocb *iocb, struct address_space *mapping,
 	int ret;
 
 	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		ret = block_write_begin(mapping, pos, len, foliop,
+		ret = block_write_begin(iocb, mapping, pos, len, foliop,
 					udf_get_block);
 		if (unlikely(ret))
 			udf_write_failed(mapping, pos + len);
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 8b10833ff586..35aa1c97c1a7 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -480,7 +480,7 @@ static int ufs_write_begin(struct kiocb *iocb, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, foliop, ufs_getfrag_block);
+	ret = block_write_begin(iocb, mapping, pos, len, foliop, ufs_getfrag_block);
 	if (unlikely(ret))
 		ufs_write_failed(mapping, pos + len);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 56f7a65bd875..58d011cac9b9 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -258,8 +258,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		get_block_t *get_block, struct writeback_control *wbc);
 int block_read_full_folio(struct folio *, get_block_t *);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
-int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
-		struct folio **foliop, get_block_t *get_block);
+int block_write_begin(struct kiocb *iocb, struct address_space *mapping, loff_t pos,
+		unsigned len, struct folio **foliop, get_block_t *get_block);
 int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block);
 int block_write_end(struct file *, struct address_space *,
-- 
2.48.1


