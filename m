Return-Path: <linux-fsdevel+bounces-42023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66730A3ACE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 00:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44A816D192
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 23:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5102B1DE891;
	Tue, 18 Feb 2025 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n8Ohi2yH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037AF1DE4C5;
	Tue, 18 Feb 2025 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922899; cv=fail; b=JTTIIDV5fMBphX2S8R7PMjnrwwTjtw/nq894FA2CyMezxpS2m6Z1eLcU7i43IEl7Xsj27u92gmejiDtXdzWQqbpXmAL+nCJbuoAfx8J5/2t5g7SOyc/NRIzsvDGev4kamDgcbR8RIZ9mVPHcXI53VXjFaxg5hia8xJtwwitd/OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922899; c=relaxed/simple;
	bh=llx6smOQycPyExD0SM1kgd8qffR8Sjf/PboG+UsJBek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nkpxOkrxa9rWME/EMfK+p/VrP7SbzX0S4LjcAh90iuwqkXgeLpmxg76aLcDWoHLBz8/0eozzNAx11z6NmFf+shUFb2Q5ILJsjclxzZ58kBXjAwXVnDLG9suxDg27iExyIpm/VYeYmBbhj/o99/KgJ7yXgnuE3RgTGNdPgDPEPo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n8Ohi2yH; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGJbAquKXAXrfmZB96EkqIvizLllw06rl3yeuK3wQhxvFViC0bhadlpRpg0Fx5QZmKhwyfnj7+/IedYuyZFw0gUF6L2kIbIjpIMgk+oCz46Xpz/tGQVVD6tTuucF+whfR6WpeF1nvGS971KafixODZW7ozSIyaSJpEqrhELV+LWfYs14KePI8QIv2oDI0LQFeQFbMO8jajZg/XpPAICzpz0b+daypFFrA23f2Jhsg9aDmo63t7HZrhmRxBk+znXSJ9+jSOKKNHX0ghhhZhXWCN7rVDU1NddZlHIo982plyK7FM6bZR4EnzrrJYm4NFsgzurIT6/bHlMprGwoJaKCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSaLygK6n05T2AmjCflis9+gvKk+KoVwHlKgr40r1Tg=;
 b=B+diu3VzNhxVGLqz3mKGAdhRpQTysdTZgcVycz0PzkkoJ6nrZC5YM1NeHm9beHkbVKSFEzGjmtJJsNnrb9y2GUVRi8Rw5cDwUlg8R5EmrulvkpObcH94MGy1Qa7PF15mMH/YZCHwhfn0HHA7rcXQ6+5UL9WLYvYlVsC7CBAyFo3ickP6Dmz9wbsaI3uWfqXmRUlYVXXj0+iVudZjOpbKZwV5n7V/VpG/UFHxe9xESJfsyFHUseE2V7R8MVGV2Qr04T+Sdr4aTDNzuqTaEQepSSKqy6GjiMMpdtVIyHJEdZ/VPzEYmaDuS/vYiflZwsu/m0PH8ZOhRjgfydM8HtxQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSaLygK6n05T2AmjCflis9+gvKk+KoVwHlKgr40r1Tg=;
 b=n8Ohi2yH+oFRM0E8dicRBcy7uk2ED9cSJedn4iWYwaQlyRq1jdv8pXCWiQt8iAwWu27ndntg5UwiHkZ4S6tVSXbqi6yFoQv6fUnS7cZ8jd/4QX03Ma7n6/LyL07XLpa6Rx3PNNEhuIuq30oRPqhu0kP1aubYX0AxwClAB/FLnLsaBz2vCqe7729VGaSyX4GxYbRIVzq7yJ0V8mGNTNtC8PB6ptft7RpJqBpQ3RUtC/tlri9Omv8a0+rl0hNwq0WGpBrQoD/BV0Un5U3ozEK/eHkWsmzQYBMKFQPxH5X5FAgk3e4rHu3jzbrHA9feNpvg1ZhQxc8fAXiblIEDWhcogA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:54:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:54:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kairui Song <kasong@tencent.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 2/2] mm/shmem: use xas_try_split() in shmem_split_large_entry()
Date: Tue, 18 Feb 2025 18:54:44 -0500
Message-ID: <20250218235444.1543173-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218235444.1543173-1-ziy@nvidia.com>
References: <20250218235444.1543173-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0031.namprd12.prod.outlook.com
 (2603:10b6:208:a8::44) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cf3213-d0da-4b4e-01cc-08dd5077a2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7JPTErAzy8PqEVfv4RpUldDRVhzXz1+m7YFvOvRH5ABqwE4W0M0oC1qp+/RU?=
 =?us-ascii?Q?w6h4FGwyyZkPj1s9+Y0Z0cqMTd2/PuL+QKDaoE6HFtKRtoRWh8nhK11h6Nob?=
 =?us-ascii?Q?2mN7vT7rYXEyGiDBm50kV/dn3OLGVzjubznKS53WlufFGYjBp1BEjZNCsUap?=
 =?us-ascii?Q?Huddy8LE69IJ36ODA7hInQ05WYLjDvgg7EFU2zApl6jl0cOsjJQ3QdZgIqEn?=
 =?us-ascii?Q?6EkAlg2aMo9cGCQholZlJr6A9nwPMl8jIVvQ2bd6FopJE6m9mKxZmIrseK3W?=
 =?us-ascii?Q?IjAuBkbkUePPkE+g9UW2dmW1BuQtbLoVeDlAAnYufQEguaD8uUle+gISyd9+?=
 =?us-ascii?Q?LXpR+by1TL4vxH4LsJh4PYDD2o8ux5UQPOIjtXJCQRhzEPjr8tZw6HCkPCYS?=
 =?us-ascii?Q?ztp4hEBgti3AzDaH48GBe7U7LyZ1W7T8oQxNi9yPK+AZbbqDDYwPmRkoOeVx?=
 =?us-ascii?Q?jYjCHE1y5EGsnQWaGsXCQWixBGQIl7QdeXfYDolvlaFiiRsdFkr4Ydhw4NpX?=
 =?us-ascii?Q?kAJs28zsBGSvBebOvvSa6yxZlgG57hY3zqhu4WS+h+QGb2rVaBChlMIDk5g8?=
 =?us-ascii?Q?yIJA9ujJq0277XHqTWdVLYDiCHIwEfDWrAshPknjfwYiewP+NY2hFfHLu11n?=
 =?us-ascii?Q?L7qLCNjvfa/o4jTLcaNa9vRc2Z7EejiJcS5k59DOrwU2c/5xwUCjXXxcRfvi?=
 =?us-ascii?Q?L99HsCcZPWrCD3qvCAXFIwbPdTBK2cW3yBoSx8I+zvKxONRQH+TmS9He1KmT?=
 =?us-ascii?Q?nwZ8R85BoXqwFD0LobJgicdWjrNPRhfIFueeZ7N7E7OR7e2uTjpKzGXtFZoN?=
 =?us-ascii?Q?MDjbjTdnSd6gLUIafkaJ9nOyMeW6l+s7zMeo3vEUWEjv9nZErAmddU4v9uSx?=
 =?us-ascii?Q?V5Yj2YPjP3IcOBD6n432tJ8/eUhqPkHzXKjCW5O98JUXR/pNFgGwVqRViPPa?=
 =?us-ascii?Q?6aYa/LLY6BNCHhboZNxTFRD/MVuVRp72yNHOefV1W72UkQ9pzPIBwbC1v4we?=
 =?us-ascii?Q?3IAtCnu8bvMngDz90Qz9sRxTGXbOuIburLdzdmNBt/k59laLQJ7fpgcQ5NHw?=
 =?us-ascii?Q?9v1qBVOT5Rl/c6VnOZ4v2oXeLAptCwsrroGeIE2N3kLzE6YNYBCfQ5Td2HKG?=
 =?us-ascii?Q?QEhmElORc/vD1AK8Swp8D+fakO48pH8rRxLZou1iuAxYV8kbxTJKfQrDmQ1h?=
 =?us-ascii?Q?2eUms6XVwu3hqPeWmtcY9YZ+fYt5wVPo9Baa7AWSra+qDVN34htyQgYl9lak?=
 =?us-ascii?Q?w5XkJKyVUCJcIOrs0xqVhpPwxjQez3TduRqKhSGbB4PPSE/lNC9XIbqH7Fs4?=
 =?us-ascii?Q?iV3fzod9J2ORxhMXJn2uHlYbittuWM10+LCYjdIzbZN/R5kq05KNd+btMSa6?=
 =?us-ascii?Q?FHy546xJxA8JRoJkuAIFJWo7Ks6o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eTq+8wuZlUSauLfhVdZhboND1Jtk9tNKvvogaZ46u2HV9LEv2QVzWLkU9cFk?=
 =?us-ascii?Q?T/ehR1R2eb6byeClzp7DT9SFncwltONV3pfp9lLoxTCETH1V9zdJlIRz6uMh?=
 =?us-ascii?Q?W7bfvAvL448fx6cDVfN4eQP2H8kvOVct1gEr59yf2Rfin38u08lP6MUS4LvD?=
 =?us-ascii?Q?WbSFKLmw6tXJbcd/hWWYHwqqkc0D3p3oK+xz1hSZkATJ+6MerpRivpkADN4j?=
 =?us-ascii?Q?Td6FjA59Z1t8/uVLrmk54dQr7rG860/vMirIwTTZeH6W4He/f991ST1coC53?=
 =?us-ascii?Q?JcjLkBnd7Atv48IsrnjckWBzccV7RUFpaozmtQndyyG3E2a7GoXbTbJRP40h?=
 =?us-ascii?Q?dZOQgDvCnNVGWBXu7rLelReOHB3C6xotsKeUa+MIUQyQSmNe1yVVxA+yWdH/?=
 =?us-ascii?Q?nLGPs4pHJ4jERYxwXEo2YEy+pRGy1x4a2kaEAKb/3/nikuFqJND1P8kPIh+B?=
 =?us-ascii?Q?T6yq1Jgt5pGjJn+Xqo85OVxsAW26xeEQlhSUDrXZCx+2YPXgeMnr9XrovNb8?=
 =?us-ascii?Q?wXmvZWctjj+WPpZFgQutI2lz5DLzPBuBR+B64JZ9l+hvHCYMRkh1/3D6hEZ5?=
 =?us-ascii?Q?eg07O29Yf4qA9V1UI767nDWOxDw/ONG6qNx6m9c4fX8gLUwkcNR12N0nz8gC?=
 =?us-ascii?Q?/U7D0bc+Of+85hejBCKVrsak3RwwQGR2AmquzjOF6J4nlHO88H3B9rIytH0C?=
 =?us-ascii?Q?7oSVHVITBcdUGpljg4Qt5QUjzOOjYFttNSkt9DmjOPYSJfEuw5p9F031Ohh1?=
 =?us-ascii?Q?VYT2+yuQxF5LRWbLQBDtKNT2y01MtqCzWyfqj/L2ho6ldKVuxQ9c5AaYcsRq?=
 =?us-ascii?Q?S0xp4BnhxXZ+zugmyvVIOWQXLQCoav9VBWAWC5MUtjgv7ykBiKBWuShmo3t/?=
 =?us-ascii?Q?sSdQesjb/PXidNOhL44I1Bymbq48M286drCbBT9XYiPozDKc6px3Y0EBHyrT?=
 =?us-ascii?Q?Vl0yJ/lIbWWJ4SUjvqJs3FrfoNayMx7qZB7yegquvkNLQyNTVoMWCa7ek5iU?=
 =?us-ascii?Q?ynLTHh4gj9WlGmRBySAJ4I6TKMhiR512/X/2zC13apff/u55M1EHKThrPJzQ?=
 =?us-ascii?Q?RbTqeYNIbpzrQjTBS90cChbY7ztww9QUT4PbS/AnsiP7xTaNjWpF0ogNnxwu?=
 =?us-ascii?Q?jwDB5S8zRPJ6nuPdsqdZZ5FtJ+y3pALsVHlnN9O7DviVUEDX/W48t/ztnUOq?=
 =?us-ascii?Q?hUJvd7a4rmNS4bG8oYDJCMQOIBLSYfgnN9hkgYVKdMZlkmhE9QEo5r+fhHlq?=
 =?us-ascii?Q?qREYSdKuBobTog589gXgmeJqV+X8A5sqSFrN4BwoiQSpckbg4AI6Heac1Cis?=
 =?us-ascii?Q?O798G5dKKI833b5ksfU1uMWylOB+6PNt64wMnKOgukZW3liu3bx30meN1QiH?=
 =?us-ascii?Q?GbB+zSV609caho2XycUTALn6Pn21Op3ISKa32BCllJzYTInXX9JnnDng4eRu?=
 =?us-ascii?Q?Blc6HZ5LsuS+t+vguczv8hE6Vb7WzR96NiTSDpzDi6rgLL2AINH6XH1jSV+C?=
 =?us-ascii?Q?fzDFakRVEpTpqYozbQEPVkJeTsByIazoATZKpTrr9Z1/JQSJNvgHqJzFGjN7?=
 =?us-ascii?Q?vF2ILV3sZdUjye2PnV9Rc6DnyXuADuRcy+HMrTmZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cf3213-d0da-4b4e-01cc-08dd5077a2af
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:54:51.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vo6omoQZ4/8lg8PF28XCXQGOwFiPCH7MQCkNceB0BfkPBO9cy2P1AqbKIgXRpj06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

During shmem_split_large_entry(), large swap entries are covering n slots
and an order-0 folio needs to be inserted.

Instead of splitting all n slots, only the 1 slot covered by the folio
need to be split and the remaining n-1 shadow entries can be retained with
orders ranging from 0 to n-1.  This method only requires
(n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
(n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
xas_split_alloc() + xas_split() one.

For example, to split an order-9 large swap entry (assuming XA_CHUNK_SHIFT
is 6), 1 xa_node is needed instead of 8.

xas_try_split_min_order() is used to reduce the number of calls to
xas_try_split() during split.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickens <hughd@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Mattew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/shmem.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 671f63063fd4..b35ba250c53d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2162,14 +2162,14 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
-	void *alloced_shadow = NULL;
-	int alloced_order = 0, i;
+	int split_order = 0;
+	int i;
 
 	/* Convert user data gfp flags to xarray node gfp flags */
 	gfp &= GFP_RECLAIM_MASK;
 
 	for (;;) {
-		int order = -1, split_order = 0;
+		int order = -1;
 		void *old = NULL;
 
 		xas_lock_irq(&xas);
@@ -2181,20 +2181,21 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 
 		order = xas_get_order(&xas);
 
-		/* Swap entry may have changed before we re-acquire the lock */
-		if (alloced_order &&
-		    (old != alloced_shadow || order != alloced_order)) {
-			xas_destroy(&xas);
-			alloced_order = 0;
-		}
-
 		/* Try to split large swap entry in pagecache */
 		if (order > 0) {
-			if (!alloced_order) {
-				split_order = order;
-				goto unlock;
+			int cur_order = order;
+
+			split_order = xas_try_split_min_order(cur_order);
+
+			while (cur_order > 0) {
+				xas_set_order(&xas, index, split_order);
+				xas_try_split(&xas, old, cur_order, GFP_NOWAIT);
+				if (xas_error(&xas))
+					goto unlock;
+				cur_order = split_order;
+				split_order =
+					xas_try_split_min_order(split_order);
 			}
-			xas_split(&xas, old, order);
 
 			/*
 			 * Re-set the swap entry after splitting, and the swap
@@ -2213,26 +2214,14 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 unlock:
 		xas_unlock_irq(&xas);
 
-		/* split needed, alloc here and retry. */
-		if (split_order) {
-			xas_split_alloc(&xas, old, split_order, gfp);
-			if (xas_error(&xas))
-				goto error;
-			alloced_shadow = old;
-			alloced_order = split_order;
-			xas_reset(&xas);
-			continue;
-		}
-
 		if (!xas_nomem(&xas, gfp))
 			break;
 	}
 
-error:
 	if (xas_error(&xas))
 		return xas_error(&xas);
 
-	return alloced_order;
+	return split_order;
 }
 
 /*
-- 
2.47.2


