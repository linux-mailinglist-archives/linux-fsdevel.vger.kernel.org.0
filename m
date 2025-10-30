Return-Path: <linux-fsdevel+bounces-66405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C43BDC1E0A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 02:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29CA189AAB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 01:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9091429AB1A;
	Thu, 30 Oct 2025 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JH8jdwRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B20028C037;
	Thu, 30 Oct 2025 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761788431; cv=fail; b=l6uBU/yeXdMRub71rFyCelwg0q/QiaCdHEhwdEyQnW2CSeovQWCFd/hCDELeMOIW7MjHKz+A6BsgKkpAJdpmCUMlg/eQDniu9wkmI1QHXhhDTU2pQ45kYVhpXWLgTQaIHAR/6N0qs4/wrCDaQBumAFWW2tboHSxUj3PWQOr9EOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761788431; c=relaxed/simple;
	bh=uZ9/s7+u+gPr4i358NOEaC4uRN0sPHqO6QRhTF60giw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3C1lSttbuf0WDvD8ClH6RUaBahUReK6zNsdgQRbL7f3467FZc1zwAiHQsmcLXz251/Esn5t/r8cu9LP5zlt3MFcaeYSieWRMa/82jAOZKsoEca8yEiefNT4Mmw72DopMpGHsrxEAupwOgkSWn3m2XdQA2qtNQZb+ngdT4qQ7jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JH8jdwRQ; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tm+H2/ysyWGMyqcReXbWlFUtvdZ9Y8PLhVuBMwnNEEpM8YlsuylEFCqvh8vkUJWqXTSDWUPmEaL0bMNvM4q7Wd9oBMBgu2B2sn14vetvNuznt7GbLb4A4a+AzcZgov8p8IqTluZxBBYcg9F1yVYGpnR2gGxphlXyQtsr0dGLk1X2k9OZShMa4RSo6/+wsW6yaxCxJswcRFXW5LAcvjtt0YhhTefQcjujs4gwVeH/QqDSMHyaeND/VDO9xYmbLWLAnYurtPJnwEpIRHzCEtVAG/D1afnthFoFxrmTTIqd23vVom+bIUSZGZ38VxjC/vkOFWSdeIadyE8awUIvlpSx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHs547Lkw68SiyeSf5nG95ZBNiYnAISj2g9JDdYhONI=;
 b=Yg3NPBbx4e8ZM8Wp3btZRBrn6nyyOXJVFrXM2yQT0LDEi5MWGK/jPVxOuAfeRftxwqRoC/WpuR2RJOHQmRo6a2ns5NC4vGIeZn+9fgM0OEO7bag/+Kaadf2Mx7UxsRmhYIkUI8VpvIWjZKQGY3cMmmuTRs9FpW/Q7eqI8MTyKwYSxFIdwfhNsElvh1laXiTaJXQKmL8eZSvzvYDUTfd0d/l6vwU3KfIkvofzYwm19aGqb33gHzJv4QMO+elMJ/zZ3ZSV0DDcaNxPZcA/l0muEifqmpM2ygF858fLi9wqrMKjKhwTGOH4KsSkpdThcmp160KSVPTnOU+CWHcHwl/OVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHs547Lkw68SiyeSf5nG95ZBNiYnAISj2g9JDdYhONI=;
 b=JH8jdwRQfL0sQFPTuMNhVrvULHnOCrM4AQykQO+v8xOA5JqM6RBLjh17554/Lbo10NyJCT2JjW8ElspJ7UamWe64xgQBoOEvxF8KLomU2nuUDXgoKO5R14NXzNw4zg+A8mg2aR42m9bJpptW8dEUmNgMx7jBFj21ua+RLzyscOjFBUM8zoi80sfiCCftrtykjvPTXPulepSH6Z1LrQ3rt/Pcq0EOYjt+CBhg9UPh+wmD5gNpFci6h1U87uteGBPsRvE8KR1ke5S/fXnuA/SpK2TSISlBdi5m+/c2QhUqg8G3STdWPDWS/VcdkvevtLcyiLvzFPjC2kW7Ar2ZlrNSTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Thu, 30 Oct 2025 01:40:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 01:40:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com
Cc: kernel@pankajraghav.com,
	ziy@nvidia.com,
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
	Yang Shi <shy828301@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 1/3] mm/huge_memory: add split_huge_page_to_order()
Date: Wed, 29 Oct 2025 21:40:18 -0400
Message-ID: <20251030014020.475659-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030014020.475659-1-ziy@nvidia.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 5207cbca-b746-4bf6-94dc-08de17554b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hV9FMD+VBeL6Z2lxKfY+2eYb3FB+i3uD64dhp3Yw+y0+WRCnprR3xVnrvUef?=
 =?us-ascii?Q?OpxEv3wOqZ1CaR+6WBrGoUhLXajcAtUQG9DWfWPZR81CBkmRi9lJVeWkBsFI?=
 =?us-ascii?Q?McaSym7yC1u/VeufWL7ZbivR7ranee5jMJy9T2S5zZjtXhpMes42zoWQ/GYq?=
 =?us-ascii?Q?I9vDb+3iqoD/+5rVphoMfy1NXZz6dUQJC9/ntAhawX245MjizD+hG0A0kjWu?=
 =?us-ascii?Q?aye2D4d5yJeAYFUCb1rY2us0viDQoRk1lxQL6gtjuCzDL1o9x8rnaLM7Atk6?=
 =?us-ascii?Q?GRNqn7iRfuqocTrlHAWu8grkaSmh5Ail6QqbisTQiTLEdorcATXxukJpfQuz?=
 =?us-ascii?Q?CZzP6CQpz0BUgeZCLAGeqSPMuzitv68sZCCOtDvF51/v8/88pghnWAaoRI8w?=
 =?us-ascii?Q?9iyor+lBWXvPoAaKamVW1PXrEXoz94l66fcGVesbpmLVFGqjfs3jooZzN7ED?=
 =?us-ascii?Q?Nj9D0XLfy277guj9vhWGhkhkIri8Khj5IoD43iGtyHqp9R4J//zpDpX51Yt9?=
 =?us-ascii?Q?JtkJFkIbIJGk4qr2UY6pW6a5CzdSJbJ3u+LR1e8fDBtO/fY1x2Mowu7in07V?=
 =?us-ascii?Q?1gRvdSBSwpflbLJt1TTdbZDMTbQrqxvF8H457y8q4oVP4i0uuh5XoKglYtWf?=
 =?us-ascii?Q?i7Uqf9YZx2IlsuDQUkh+Y0wIRTzZPJ6u/FUCtn7xEuYcqd9yMxxByDKDW+We?=
 =?us-ascii?Q?Hst6/9CXQ92qqCMk2iEDoNVZ02bn3zRJQmhgKea3rL9TQLq6Zi72aHhMwEDf?=
 =?us-ascii?Q?MRwFiKll9ekNutIOkx+OBmyAiPW+56XT2Uhx7D398mX2YFirmdFcjbnUbo5v?=
 =?us-ascii?Q?rryA/srC5dqCoWB2LXfmuEZtPDHKyrYew19qI2p9o9vea9i+b9G2W1BxUgMe?=
 =?us-ascii?Q?nPwGV0A7Gaxn70fPo2w1YO3oW9Y05nf8VSwlUAO6I5HXmrtuL4Pm1BdOTiNk?=
 =?us-ascii?Q?3VTmmwuyCkqD8a6p7DG8tHBX1mvLkAB3Z0a9Ata2ZVdwzR3erxtkvCBa06Wx?=
 =?us-ascii?Q?jZA68Tf+uZVRZy8HrPzOxNu3HT1gehzfS4Zn6u+PIOmV7RgLsYEltSiBpuJO?=
 =?us-ascii?Q?wlNxRBjHX4igGNPuW+H1POVbINQNMdHiCNpj7YD5pdJQnV1qf60LG6F6+IN6?=
 =?us-ascii?Q?ftSnczVHXBwOUYF8kn46rm/Zhl5/doC8Q21uqIXfhVcquDtSvhCFBcUwTXsw?=
 =?us-ascii?Q?kP3vY9+hPKqdP4vUIcDpyLf2MZuM3BqoZkcKmTQaW2Uvj6I5Hu55x5FwoeC/?=
 =?us-ascii?Q?tEOkx9XBidRXH3EfpJMjZrDpnd0wWYo4ej5B9sRKQ+W1+8ZUVfNG5r+/vAvi?=
 =?us-ascii?Q?eqlfu5EpvA3kBc9ySvrDagdA1uikZX9+vVG/a3Nexja7TT3/62xIqWHouUm0?=
 =?us-ascii?Q?K9vG8R1pRVwkS63CAs5RdfcMoSe+XVNWdK0LhM91xRA0VMuaT2t9cYzEhcnB?=
 =?us-ascii?Q?n/NkIqS1/jnaIEcTxcgjjm19bCmABz4R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wHDXNQ4JGw+bYuy1VpZgWuh4oim9HLU7NR+4CqHcyj4zxZUt8dod6st21K1B?=
 =?us-ascii?Q?TKPJvKVNaQwtztBjs2ntdhiYRWRFl+fB7v0I5JJT9xQSFeyL6RpCd5dkbGIb?=
 =?us-ascii?Q?Ggq9YTw/78k6z7oVLRGhlQzsXALHVNVQIF+9VaxrYqgzG6eVWaSABCvWcyGZ?=
 =?us-ascii?Q?HVESF4s7x3CU/3VpSpSIMD2XfaT7q0itl0kRkzShX8wailKLxgBYYtO7HvI2?=
 =?us-ascii?Q?6KBRowUdNT8PU9lWrYUBDoevTw56QDAJiAf0z7J0KfZWdXASgQiWd8csn6eI?=
 =?us-ascii?Q?zZhYd40Y50Cxzvsx+rR47vhQ/T370mg13XpNGmh2oLmZTkhzLTBmY1xGZ0jJ?=
 =?us-ascii?Q?OHax6sDek3WzS8S/gBql9EMS+mqP9W6E1rUxX+pOJDvHFGPhHCdZNDzj7qkT?=
 =?us-ascii?Q?Jr+FJVwj2N0aNFxWrGf6EiZfOmDkCv93YgYPUP2ABo/xMQunXImgAN03c8KB?=
 =?us-ascii?Q?Vj9wj4IgrNzcpclihbMOz7U5+Tw7kLNgItSvLn0EpfPU3EBj0PtTAJGmLuSx?=
 =?us-ascii?Q?xYoLY93rslxKuJpDyZG8thfC7A8MABEuqtbEclEj9lNWBxu24MOyl5fzQxNs?=
 =?us-ascii?Q?NupEWz7RA3JCo1XNKWJGavil0b1sjq9b7l3H5MQO9C5xQYrXrcaq+oAUhlSm?=
 =?us-ascii?Q?TLjPy6z8J2M1VGFNMqT2OwqJ+MFr0cI3E2u63L0qTZfnXT80gY/Xvhi+Il5C?=
 =?us-ascii?Q?bDOWpyySbcV7cKWH+AnBsG3Uaa2fNqGTXjsb9tMybHB5d4hcnImt9nNhNGOg?=
 =?us-ascii?Q?zUJ5+dhDN+hf1/mjpT5XWN5htv/UnBUxNE6KNQ/zVvRb1nuVTSX3GGZQD/61?=
 =?us-ascii?Q?0lLdlUDpJQm7xE6quCwc/7AnIgvBOCcbtDy7EswPNfLhARnSeUKOMq9PZJn/?=
 =?us-ascii?Q?txlh16AcpzAShonEYhG9Ro7kBn60fFhEWIBN1egHEXwCekeM4Sdyok28NBXG?=
 =?us-ascii?Q?5T9RR9WOUP6QbZUoySQ3PnONCBXlfrx9P5CC49f8G74ptfKZVLOOEQ1EZNsD?=
 =?us-ascii?Q?fiVt4c88dbd0iax5ZTe7y2ivEUfWi51cy6Iw/BgwPT1jAgP/CslpV6lrLhYm?=
 =?us-ascii?Q?Ppbskoq605NuqG+oChzq9Flcm7ywBQmY6QyC/rIy5h4xsdUEnTyAUs0Za+Jl?=
 =?us-ascii?Q?doQ0APC3LHTYhCUKdWrrS0gKrJvbdQPl5bxTtUaMeGL0zTCaPt5LncuO3hSo?=
 =?us-ascii?Q?I69o8zwtO+UIOCKTBaxaoWFf0bDk37UAmtE+riyuO+QdTYRjoqSoGDQW1r0r?=
 =?us-ascii?Q?0KBbRfQ+PktaS4foqpa+5na+y5eqMcnIm91LbQ2qNSKAAQWbfGAJ8k9lWZCi?=
 =?us-ascii?Q?2lv+ZVDT6yY8SPkaNBOxIInlsxtiegaBCBa4xOTnkrB26tUVMVPQrrLuVrUl?=
 =?us-ascii?Q?Bq3z9hhvUJZ7h/9Q2kma1AXeFIiB73EMO1k2y8UmU8aSNA1AcPEOTV8OUyV/?=
 =?us-ascii?Q?kdri0lT/ldKk2iZNCXwrsWjVBDWTelFxclg6D+3hQM4CcULXKmiWLRujrWvz?=
 =?us-ascii?Q?rRIE+D9Ojv65RRLuJpCAw0ZVtYs4vCzy5XFfnBFXccmegTua5IoAMYLFg9pi?=
 =?us-ascii?Q?mx+U6lxreLtA/hhX8obq+DAr3EP/nsqGupXgjwxX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5207cbca-b746-4bf6-94dc-08de17554b92
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 01:40:24.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YhhPlM6xDTBnj1JRkiV97ApF1/ViFsizx/FHHKBEUtcjAnHBfPlisRWujrStyn6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261

When caller does not supply a list to split_huge_page_to_list_to_order(),
use split_huge_page_to_order() instead.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/huge_mm.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7698b3542c4f..34f8d8453bf3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -381,6 +381,10 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
 {
 	return __split_huge_page_to_list_to_order(page, list, new_order, false);
 }
+static inline int split_huge_page_to_order(struct page *page, unsigned int new_order)
+{
+	return split_huge_page_to_list_to_order(page, NULL, new_order);
+}
 
 /*
  * try_folio_split_to_order - try to split a @folio at @page to @new_order using
@@ -400,8 +404,7 @@ static inline int try_folio_split_to_order(struct folio *folio,
 		struct page *page, unsigned int new_order)
 {
 	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
-		return split_huge_page_to_list_to_order(&folio->page, NULL,
-				new_order);
+		return split_huge_page_to_order(&folio->page, new_order);
 	return folio_split(folio, new_order, page, NULL);
 }
 static inline int split_huge_page(struct page *page)
@@ -590,6 +593,11 @@ split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	VM_WARN_ON_ONCE_PAGE(1, page);
 	return -EINVAL;
 }
+static inline int split_huge_page_to_order(struct page *page, unsigned int new_order)
+{
+	VM_WARN_ON_ONCE_PAGE(1, page);
+	return -EINVAL;
+}
 static inline int split_huge_page(struct page *page)
 {
 	VM_WARN_ON_ONCE_PAGE(1, page);
-- 
2.43.0


