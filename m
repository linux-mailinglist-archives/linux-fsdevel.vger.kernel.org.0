Return-Path: <linux-fsdevel+bounces-64336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D4BBE15E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 05:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E6AC4E7940
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 03:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BADF21C176;
	Thu, 16 Oct 2025 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YoyhGokO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0D215F42;
	Thu, 16 Oct 2025 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585706; cv=fail; b=IOY5Y0ShUz40Wk/MsNkBOTfRmIuwmK83efaf7zkmU5G5t7S6+S7pwA5jL2YXUF1S3HdSIZ429Hic9Geaak+kFwljo70XVMidqtU67hPbzLDSj73YkZswd5S+TlzLqULrgBEWh6CnbOz9ghklwFGsKosO8x+QxB71DdlnSLvhMgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585706; c=relaxed/simple;
	bh=K7wP3hqg53Lu7asgN/aKEbyn95MUCyeZgtf6SUkhfhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ca1PO77PRa/NnKOELruUpZ7wfwOUmA6fFxnCOybKv8b2b44A9TvPZn3jyafO0XC3gWauOq909I6rTecWsQsGpGkwf0Rxqi11xfD2FKyPI3H4PUrhnq3XHihySdSrqNZlQCz7enDmJq2ClK6RQ7ZBw59lT2549baShGz4PBhp/AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YoyhGokO; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tug7OKfOnpYuSaUbrmds0GxwyoYhJ1x+zdFX2koh9IiVZSTHHZTWFu9U3v4Nq5c5jVF/vEV/7DJlOfGM9MH3DDOM26A11v1jTPwuyxxLASP+xH7KIddfBHRgBFac9u5UbQ875UYj3spTheRTX9YZqrf9LeNUjedMQI7DWdGxT098CbjciywzMqrF0VeqS30ZQBYvsm3GTPOLEJoSI0N358tLsES/ZZ77Qf0SJckHnI4bBpNeqAY4oRxYDDcUi01G4BTqyouAUfUabUzIALsKweR6kGZdkm7YqgFvP43VLND2lCxVLeDTKS3ccykp7S3ZydzSTTj6a0fLAbDIePyEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wkNbrVegPi2iMFRfsodM4xnKuKE0jrSZ7enz0y+528=;
 b=NjM0Og/VyIPY4DXSfXlKQP6g4XVABsTbtt5Geb0S9Qr3NUWTkxNPowv/A6X71qPZ2DwemqGzQefytfBQ3Qc4QY4CXOyH6JIRZGbDsZma/KURX3+8ps3a5URpDWIf7YDTTfRne7uW4/d/j/aXLp17lB2WWXoGsreL24jrnrO8nCSN11D4r6GyPY9jk9zGqPYfHhDWhTGu2vesy2cFxOaFksCuz21+4NgpjLRXUnnJls9lkCng3OUEwiUp+EUAVGA3fDHeQQOWJ0cXG/wzIMUkQMhue+yDqVpPy93ky/qz5z4K9PFtNzhuV1n7ts2qQoqLB95RCm/BgnePhCChiVCnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wkNbrVegPi2iMFRfsodM4xnKuKE0jrSZ7enz0y+528=;
 b=YoyhGokONs/q4F1IbpPsKU2M2kz71JDcpfzqja/3YTX7tW4FnAEQr9mjCxQ8iqiozWtiY1FfaDQX4iHJiN2RQQu+QOXq12q3rHiZQ+NsBcPPWfBtVU5df8jKzpOe+jW9VIvf96dKNHVlkGANstClBa9fctllIs3Zl1gdyX1bOLBOa6Wj5RJXEx2qHN1YTfMAb+HqPbWL7wdqOy+h1o2xXKywLwiPLJWStR6bCMh7OipSGwtBLnx+rMmBRbhruydLA7L9SEnaGp5STN/j3RhS5eA6OoLE5K3ozkn0eZDrbyP37i8ZKBjVIBpu4YwTYSuBmQeJuGiCh0PrHTZEiEwVbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Thu, 16 Oct 2025 03:34:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Thu, 16 Oct 2025
 03:34:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com,
	kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Cc: ziy@nvidia.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/3] mm/memory-failure: improve large block size folio handling.
Date: Wed, 15 Oct 2025 23:34:51 -0400
Message-ID: <20251016033452.125479-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016033452.125479-1-ziy@nvidia.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:408:e5::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: b179d0dc-6792-4d9c-6ca4-08de0c64fb6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2xjazz5BzoAMEPKT9DKv54yxT1qRNANwU/663euXDiS9zoSbo3wsPOK2QMyW?=
 =?us-ascii?Q?ATVszNTrhTR+su4Imqda8agUm3Xf5oUnbSKK5Pn5UIpuEH7yWWS9BS5PRhxf?=
 =?us-ascii?Q?uM86r21v/ACOM/wXw8JWfW3HWH9O5EV2XDEgEWS5sHHInYGileEZDoCpXUdy?=
 =?us-ascii?Q?9kBRAyiE5Fc3Lbw3Fh0A3XScZ5q3Z9d28OAUSCCBYffdHp10S88qMlOjFvEp?=
 =?us-ascii?Q?p+W1kjwYgT7Wyj001+dRIm/Ps4GaupTEAQabQ7Y5/5Qj3erTYXRsJdUPR1kc?=
 =?us-ascii?Q?hhKbeiNs3jXw+vA1DWyNF4Het042dnS0jfoLrX4mYi6vKgHP0Q7Rg4khkZ2B?=
 =?us-ascii?Q?bbGtAm4pqd0cuTo0c3vdgDNgh2tBkeI2tpoNuTMp27Kq8M1kSpP6r5iiBC8n?=
 =?us-ascii?Q?eQve5V3y+hHLGRTsWGzeCRFmhw+qr6Fh261Edfw7awNqZzJQyskBrOWRfZVv?=
 =?us-ascii?Q?pLozmuxYOLnDZ5bGIApXO7nOijbDnOP+sApt1SJuIiIqcIAbf5xnraMzgqyk?=
 =?us-ascii?Q?uJVV2ey/ffbaMfNSXdVjYHcG3lUm+9BS5VYyMiesgGxuM5JPQN6oDnUaJ7kf?=
 =?us-ascii?Q?wlICNxBXXzs3EhHXxhk2saVPf4X69cW5TfwEoCk7m3Bz8LBNf+usoIUTodyh?=
 =?us-ascii?Q?/3v05L8WcWiJAPgmGr2RQV80Ys7RIJ4o1GZ7i9J2d2Nlaez0iYhGOxScduJs?=
 =?us-ascii?Q?Kjq3nYWv4iCLI0JJH7wSGgRnXoj/Dh7bN9dlAyxl9EYXKNieyXFPBzX7GbHl?=
 =?us-ascii?Q?4lpAcskIfXc4iiiVXAg2PFnKYoUd3xytjQ6mq1R9Z9EXFrFm78kdEzWgH5V+?=
 =?us-ascii?Q?Mhu6SxCIECH6FoZLRd8omQzUE3IuJzJMI8/M/cZ5DloSkHmnn1l9tadri6QW?=
 =?us-ascii?Q?hGZdskq2asys32B9fomYzPZ3BntL0lENxNdqa3uIB1KICEsxxURdDhvp7Gec?=
 =?us-ascii?Q?MKqrDDRlMJeu/8yH78M13ojBHnETdoUM46hbFrPWQlGh5/WanwjtXHJcBLS+?=
 =?us-ascii?Q?as71Ga/62trtyBSSQQGQkWC0aHzzQncRoenKUiLlu63PjgQND6XERAjlkoFd?=
 =?us-ascii?Q?vvQy8oGeggWGVrsYpYRurWaNwFEdNUFw9wEy9+XEpey4kYhOauvwu/IeXNnA?=
 =?us-ascii?Q?FqDrNzmERZIOik/vB++4eRIY/sCqDEA/RMzmP1hiY2ouWJxtIvwn41WvmODm?=
 =?us-ascii?Q?LHHfZL3fWcXib719fbDOJKt0rz5R7CNRmLbjZrgOmvIZYMdBMeUauik07n41?=
 =?us-ascii?Q?fAvamjGPiYVcShn0m2tuk3Ud7VIlYGiHWlsVRRrMqbGUiv6qb6k1Yi9Yu1Bi?=
 =?us-ascii?Q?YlBdUrWA5wXk48hKay6nbHCCz1QDXqEUYrIQ2m+kCyxL0as8PPKplHYquzdX?=
 =?us-ascii?Q?706zw9HFOy/I+BiNg2YtVenAEj1Oopp5u8bSTcJruZMjqjO9vd7FmpdjlZDm?=
 =?us-ascii?Q?HJUUZO1mL/hStcysTMjTDp9k2ODSQ8b8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vqxd52OPpLoYfphWhQ/oBVPupqei2uiqMTn3vF98jjAQluMS+JOsofrx0qFm?=
 =?us-ascii?Q?Zj2g9S65pRUQ5zCaG5B73WlfAg4s066Yadf0Y+AYJv13GW9Q19hAvyg8jD4D?=
 =?us-ascii?Q?fxeioq1HoTW5dM2UmBBUQnn29rDp2o+fk1wcOFV519HqZX2nESov943N+oLb?=
 =?us-ascii?Q?G1QU8WDjpwQM1N8/i3lG7wxA9EV/GUhxLRSCmgfQKdk063X4ocEEZP/Mpmtk?=
 =?us-ascii?Q?hrXkMKZbDgbhFdPY2ORwUzyviMvxpEg96jt8UaAsmmM+VyJQ2KLSq+7zotNR?=
 =?us-ascii?Q?OoZKufMXLLrhgeS2IxADLnJOr6m0vcqe2ZAmz0d8yEZF8TfL1s0pR6iLmWNy?=
 =?us-ascii?Q?vjzgQURAkLNGVEI5UBnL+GKnaDyHPitQse3qMpJgUrOPbsj7LI+4SpfhIj/a?=
 =?us-ascii?Q?T//UwR5iq87qQwakj1lr8oi6oxQI7lHOlME+xml6ghKKe8PYP0VKwHGjdSTa?=
 =?us-ascii?Q?MeO+DyUyyQnUN1ovo8EW6RCe6B13f2vmMlVA74pScpYdt6GSLttWJuxKsbNw?=
 =?us-ascii?Q?gb8CU3OebXGFWpRrFb8F0l0dTcrDOGpDs3mwPl8zoFfU1JOrZ9MdeASAr9vs?=
 =?us-ascii?Q?0XCNuiifqUbgHGDVl26faFq+dmgayq46CrfpvHzNc0jH2fwZT+uQvd73OtXI?=
 =?us-ascii?Q?v5iT+6UeDIRsvv/0Dz6/7J+pc5wFrdaKKgiz6/gz52JEED43vDDy2sVDWRpH?=
 =?us-ascii?Q?kLMhAKD7hvWJVajhrjuqsZk6QkQplyZ4YvswZP8I691fS1irCcI+spzQGhkB?=
 =?us-ascii?Q?5QKGHVo/ESQlSnLTZPZ4iLXfTgJrl+Knv2G8+L4wPsv+rVMwast/XcXZGCP3?=
 =?us-ascii?Q?1YaZWv20/AR0NAkC7QYOrWJKpxrc0Txl1IPhQMH73k0Af4yRkGTGlIwuDj5s?=
 =?us-ascii?Q?0SrmOYQCx91sumYEEcII6HSn/gMDVS17O+n6RoukSlkJFRafKY/s8qnHNuRC?=
 =?us-ascii?Q?u9gmser4a9OZ5F8xt1gzteuJ+fHQcB8tl0zRHmzZHsPfA9rp8Ox07vz2LT/F?=
 =?us-ascii?Q?s5CorVo/1KTAniVfLaWMssuQ46NvY7weXlLEtLTeSSYUo/jgfiGk0N96fDiQ?=
 =?us-ascii?Q?2FkEK6mu+lPET26a7x8z6IgW9RVz8Bz24VUbcG8Fjplkj6QFip7dh1gTrOby?=
 =?us-ascii?Q?DiDtGd946E8a2sqpS2JjJkelmtwf0zqvdi/qu3JNhOkIHsksA7fP0RSpITvI?=
 =?us-ascii?Q?9/Ft1OutGXqUokurteB5AEQdl6FtQ61zqtSYZetOjOxkNnvHETVrhKLHXh9m?=
 =?us-ascii?Q?1NoeylTQgKOw2rNg+lwkSKeHu+ZzW8TcF2ALA9R60ywM95lmIfsgBz8E3rfD?=
 =?us-ascii?Q?3bg1CthgnNNvjuEsQkM6N6Ugf2aG+HIA0WLmC9CZj/LQr14ql9RR6cbTRVvH?=
 =?us-ascii?Q?qIJyetrRjAUwuJHRYPbrmsoarAb5zUVRVo9B9108q4P+epbS73+C46njN+aK?=
 =?us-ascii?Q?zX6Jg5WURugBJDIojNjELR026kUyEJnO2eQAarpTxEfomRYmDE56airRi5jp?=
 =?us-ascii?Q?nDPSos51WqjAMZ9beDSS7jYeLMsUldtzWcAiP+WVp9kYYogJ/oG7UiGsqTMe?=
 =?us-ascii?Q?Nt0s1OaJPTD+cV2AFCxReXu6zFLttRJVBV14UCnH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b179d0dc-6792-4d9c-6ca4-08de0c64fb6e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 03:34:58.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKA9N9E5Q1dZTSaM9qVhJnTTRe8SN81jlD5GZnc53YuPwKJzJSTX4XQ2b9dZ2H2F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493

Large block size (LBS) folios cannot be split to order-0 folios but
min_order_for_folio(). Current split fails directly, but that is not
optimal. Split the folio to min_order_for_folio(), so that, after split,
only the folio containing the poisoned page becomes unusable instead.

For soft offline, do not split the large folio if it cannot be split to
order-0. Since the folio is still accessible from userspace and premature
split might lead to potential performance loss.

Suggested-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/memory-failure.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f698df156bf8..443df9581c24 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long pfn, struct page *p,
  * there is still more to do, hence the page refcount we took earlier
  * is still needed.
  */
-static int try_to_split_thp_page(struct page *page, bool release)
+static int try_to_split_thp_page(struct page *page, unsigned int new_order,
+		bool release)
 {
 	int ret;
 
 	lock_page(page);
-	ret = split_huge_page(page);
+	ret = split_huge_page_to_list_to_order(page, NULL, new_order);
 	unlock_page(page);
 
 	if (ret && release)
@@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int flags)
 	folio_unlock(folio);
 
 	if (folio_test_large(folio)) {
+		int new_order = min_order_for_split(folio);
 		/*
 		 * The flag must be set after the refcount is bumped
 		 * otherwise it may race with THP split.
@@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int flags)
 		 * page is a valid handlable page.
 		 */
 		folio_set_has_hwpoisoned(folio);
-		if (try_to_split_thp_page(p, false) < 0) {
+		/*
+		 * If the folio cannot be split to order-0, kill the process,
+		 * but split the folio anyway to minimize the amount of unusable
+		 * pages.
+		 */
+		if (try_to_split_thp_page(p, new_order, false) || new_order) {
+			/* get folio again in case the original one is split */
+			folio = page_folio(p);
 			res = -EHWPOISON;
 			kill_procs_now(p, pfn, flags, folio);
 			put_page(p);
@@ -2621,7 +2630,15 @@ static int soft_offline_in_use_page(struct page *page)
 	};
 
 	if (!huge && folio_test_large(folio)) {
-		if (try_to_split_thp_page(page, true)) {
+		int new_order = min_order_for_split(folio);
+
+		/*
+		 * If the folio cannot be split to order-0, do not split it at
+		 * all to retain the still accessible large folio.
+		 * NOTE: if getting free memory is perferred, split it like it
+		 * is done in memory_failure().
+		 */
+		if (new_order || try_to_split_thp_page(page, new_order, true)) {
 			pr_info("%#lx: thp split failed\n", pfn);
 			return -EBUSY;
 		}
-- 
2.51.0


