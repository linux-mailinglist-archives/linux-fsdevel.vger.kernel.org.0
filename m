Return-Path: <linux-fsdevel+bounces-66606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD6CC2612F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B644B351E8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8B2EE611;
	Fri, 31 Oct 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z5wqdC7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182A2D9EFF;
	Fri, 31 Oct 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927581; cv=fail; b=iJ6wmlCkOM68yWZtBfMI5PHTDwtSlatXyyMtabu5UczSIEJ/IT0X7PnV7F/E98ou15/V6maXNaQmna6NpsyVECIJw0ZC2gsjxvsmtXnf783g5Q8tT5a1DXLWskybfPW5qAlNn0RV+tmn2JkPJCz37WQihICX5ujWDmZrf6UwhD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927581; c=relaxed/simple;
	bh=6640sZsE55oUX0e5pXWISSxObe8PiStYMcGk8tBSaok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ONq9FhV6h2NxEqsAQjs8c63+x+5YhtHzlGu90jhtZKShU58+z0XVGw2g9yWluTIhAk/WFfHuqkyhayD1HbsgO4qmXStxiJXPzp4wlhYoOdmDBlf9lVaeWX4gNKc+OzMeffCW87xyqk0Kp/f1wwaAEAF1aLYvC4O+oLNzuh3HVoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z5wqdC7L; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYEk8mOrJzDpLAjXfnyw1wYL1qs2k10zZgwbh7nkK1oYTHp1oXh0LEfOh4AgoxosgxTnb7Ke940FBzV0DBWkCVzzHvjpeasX3P2aqE0rgYjE7HM2xLcdbFaaW9tER1IqgZd1BrS3ijYYTIfkgQ4ryN/96wAEPlxkkHYgA+TIpFvPgLWFz6Ll8f09WAXP6e3X/tJdAQn9Qct68ajN7xIL3ERQGq6r4DppmObh/p/uD0R1yhRpJivvcoV/OXGCP7KECqXZbgQvMkeJYSUgi5PwXACJg+hFkAc3X72+B+H6qFW7aU1WoOAJBe+I+4D74Vmd3Vbral84aWWzbEB5dDO36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEziPsmbFReoVEYcuS1prmy0gSsXz2mCmZJbs1RkcaU=;
 b=IfXcXKgS3DHEr/RkLjmPjTK3xq+GGNvLJwynsGEfD+jfYa2B4IJVRrRlGq7nIBJ5XaRbftWq9pWjWMTi3DEq1v7I3GE6byEVZSxlY5xoKukYG07v6x45e7VliEflz6/P2je7bUmtRIH36o0OmptyOn0Ua4oaYYE0DGKf0wPRgCDM4/MrcSpY379WsrTcAGySkLmaTYsXvt9SqqcBYiXI4kcjGr8IEsvUyplZMTtIohuHVt+R+/A5BLGypaWgh4WPrC1L4/cRY5eWmaLXUrrxSXx/VLR60jjC9ZypNbMXhs+zdY7zvE5WnujdkQgp0dAwnxQpYeXx/VpOfMEQUogtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEziPsmbFReoVEYcuS1prmy0gSsXz2mCmZJbs1RkcaU=;
 b=Z5wqdC7LTGvs9tHZzav/BSbipx4CJ8SKmWtHgyDIiRxSoolAN3SDCkgfzpGzpcFtDaYxS9/9Y2IShQ1ymiPq8mczpAD0F0mhnSAhpw696Ijpx6wga8TTSVNC/AtgYqO74vKPGR/DWzLE1AnVmj4nUw+KDyX0hhW7zr+fLvKT/fllv9w4YGXYGfwYc/3D/XVsgiB2XCS21ufzm1Y7/AQXciPyo1HjSMVmZPVz5uyrl9Jo/SGEDEAbucOoVHxiJ3RwerinJbdLZe944aFLTH3s9r63mC/a8gatNWoDk+x6bHe9vvPvhl/bArklkbPwg9uMy9/5a2hCvixF9i1M650/rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 16:19:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 16:19:31 +0000
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
Subject: [PATCH v5 1/3] mm/huge_memory: add split_huge_page_to_order()
Date: Fri, 31 Oct 2025 12:19:59 -0400
Message-ID: <20251031162001.670503-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031162001.670503-1-ziy@nvidia.com>
References: <20251031162001.670503-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0302.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e68f3b0-63e1-466b-9441-08de189945fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EnEBibC+ZNpaFMVOo5/+C8m6bS1YpRJyvK6Xwd10LB6vgFeO5QkQ8jf9yekK?=
 =?us-ascii?Q?fTZ+pEZMPNlw1jmA9EhLedRTgmIrSiJbtmrRwQ7CAO4tOjSsaV+/sTWbP0Un?=
 =?us-ascii?Q?CnqxTuLQUncriIJNjlwVFvDm3/2u+kfnHOD39+sf1YcZjWy19xkaRoRRWSnt?=
 =?us-ascii?Q?6agR20wEXmFPLjwsVfdBNemDf6mnZZwm7Zt4s7UqtdFW6KIsaXZj8w1gHbEl?=
 =?us-ascii?Q?r8MoNkZNt097zutfFB3SMW7UmyPKz+IJMPGQi+/IUZd/hpqb5Jtd0NT8s09D?=
 =?us-ascii?Q?Ce5cpSgIoT0CNbCXMLaR2s0Yn64AlDQR7afqIvLrHP9DWN5m18wB6r6eOXgK?=
 =?us-ascii?Q?c7fsYG1T7knkxl7ukHlrnw2qg0scFrg7tnP41S0q2LQv40xWHi18Fknb1ESz?=
 =?us-ascii?Q?6juHO8rXRtkzcEYzsymkI2nKLul5Bqbfyhwtd0AW6FZ6CTh1NR/Ox52ioUc2?=
 =?us-ascii?Q?3T26h4t9jZ2bWmfAPPIgpVbbarfs2fQeuEXZAM7JBfJItKjcTON8pGnsO8o/?=
 =?us-ascii?Q?hsPOoOVioLmdmHaCSeSsGqPgkIkrhfxaq39HBFc+q+r57jzOleZL8qc6pufS?=
 =?us-ascii?Q?Vv68yRdECBs4JP4WLddNe4kPmtiGn7gLyKQ7+tHckkWIrT7AulPal0LMvP0j?=
 =?us-ascii?Q?TN/3lT8glvI3m0qTimytkMe3dBZtZtvXlLI7eVSAInTSINZpLT93EqwRnTxv?=
 =?us-ascii?Q?V8QdS4cc8pW06DoK6LfXboBTQfbaX7kTQwjtS8AxhGKtVaygyIdC0GKPapR1?=
 =?us-ascii?Q?VDYax8Jy/NCNSI0km6MRZOSpwcXPBCzIPQ2/aHIObiuO//EQy9WRwQhQbj81?=
 =?us-ascii?Q?BbRhtfZEW96OiZIo629DRyLsIY9CQpCPf8MPhrfP7UlZvL3v3gcjegNRqwI2?=
 =?us-ascii?Q?1r0IQ2t05TuDb2LD4zYL2EVHOmXG4vWeLaZoY6iw+1ehS8cy+o82x8fzckaZ?=
 =?us-ascii?Q?DbKRYCLnGcWi7BZ1SxboIFFBBA0qIa8lT9KKx5s7vGVP3T9wgubixGRXb7mV?=
 =?us-ascii?Q?ZYKZrrPc2VZe6Vv7VL5t//gBbKB0yugVReIomyVWVxi02e6OLFRNz2rLBS3A?=
 =?us-ascii?Q?w9Nt2s8fvfRAMYRiAcUJzewJcC7HX3vvlU5Sya0MlvAjn3KPm5T0/evyjcwp?=
 =?us-ascii?Q?XUnsmqj25lWMdcXtGZveyvpTXZvfyKyuwwfujRDGbgtM09c/GC6xi7igVcbW?=
 =?us-ascii?Q?QosyvsDp+k3I1clJPDpUJjpof/1jl62eMZ3c0WmCcIlNxNRraYAK9TJ9bBxq?=
 =?us-ascii?Q?Xrkq69KxGema+jM2ozsNDpQV3f7K8UWNScsaHLNlGqf72eDb6vLF6tXKv6Gp?=
 =?us-ascii?Q?OtaFcclQNPncYdNRGx011AEhzUvlQOf9kc/q2QmkbTW64Na5zQZrrwk8gf9f?=
 =?us-ascii?Q?oR4TCdzabolAjlRo82/wf01uHoIZgdetQT5nuwR41xTnU1FRNX7GDejxBwYg?=
 =?us-ascii?Q?1qo6fPJawoJamlmZLnRqpssXUD5EZ5+J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zXl4crG1hRS0UYmyzeY781SbtYcEaVXcwtX1RO51Cb3Q8CVZiz8sUV0h++0K?=
 =?us-ascii?Q?NfcvOZOV2KO5aAWSLKjXGFfBTHb3ZzVUtetn2yKCPRia8XCrwOmJ3VWDvPh9?=
 =?us-ascii?Q?ZOPulqllbgXmFiGgUQoRRperKjRqb+i+QGFSynA06xlCKftTFFdNin6O3rR9?=
 =?us-ascii?Q?KKA2UVcBnbBPc0ZSxL0oO3hOkR7lyue3FxMC/trH9kRgrFTbWI3QxkdHlOn+?=
 =?us-ascii?Q?mCk2wEns123Sk12uH0vK9oTAUempp9Wgl17NhpfhPlHzKIFWAohVxL4w59Q9?=
 =?us-ascii?Q?3G/n2O42Ygg1fNgPUnGSCGNkj/sHrmJNfCnNY34E0jQPnx3hsLNTvy2Rjf1t?=
 =?us-ascii?Q?n7EmN0aDCgLtAcFIWsJrM4mvej4IqR5dyshPnCEO0aHkarJ+qaotbwtnHSZB?=
 =?us-ascii?Q?RTmZopQsLZarg05iGR+0lcwxX5/V3dJIYs70J7FrtfZJNiP3okw0ui5Ncma9?=
 =?us-ascii?Q?jv+66eq0lBpNEyiMK1/pZguSWdGAwL+eyKfoIwLRxh4IDJSlfPGKJeCAwi8Q?=
 =?us-ascii?Q?to79TrhE32VKauW/EvDq5bKi4xijbVlok0rY6HN8mVhfyc3D00Otd5IcBGf9?=
 =?us-ascii?Q?yqbgUAmthzsPAxC+YDIwempEihygvb/xkkjTzyQ4OAiGiydMrHUGbhEOvqOI?=
 =?us-ascii?Q?G0MkxywW697qAMxlSFH1i0zdysCtg95XCw6kClUaYelEhPMtnKJjAXrWjFxf?=
 =?us-ascii?Q?l9DYyECgFjOujSM+EAtuvB2gfl2/jmN32E23P8DQxrQIrER6mmBykLlqwPWt?=
 =?us-ascii?Q?/RIF3bTRL4+Ik7oafDeScD7zx24On790AZBkURu7FriJf8TI5OWfB3nUa3pw?=
 =?us-ascii?Q?XLhHSQLn0uPvjhUHSZ8Nr/Jf0kf39hoYc1bow13Zyb/py+dHqZTvf3pQL7fi?=
 =?us-ascii?Q?OPjuY+kaeCfIwOX7cFY3U9qgq+mZyCFHKKPyTjqGdJZdtk428ZrgMa9f6mFx?=
 =?us-ascii?Q?htO7WPLZ+3ZtWh23XKtyXWdH0Pr2Djf1PYCU6Wf4NAeiLGjsH/wlKa12xCQF?=
 =?us-ascii?Q?C/XW2vxrWN+wAzsvHH164sex+cFiZZaDIOQ91LNdxVeGBuj5nTg97aHDnCx6?=
 =?us-ascii?Q?m9WDfHVDOmEC5spIpsKPW6bjABUte+3eO6yTHZyRfOrty+x0SmbZNx3/9HLi?=
 =?us-ascii?Q?AkJg2xp265yHzkDZOb0qny7E//f4NmiFhrkV6otfzQs5YarhANpFuZ7BpXDH?=
 =?us-ascii?Q?X3K2tFHasncthWsX5qpn98Uz/3atJm7Oklu9pc4qZVAJvIfiaAz98s1o7OHt?=
 =?us-ascii?Q?QIBan5AEw2mABuutEqAgvr6+LkFUPywUC82vhgFAVbRpJltXEtFbZArOKZ50?=
 =?us-ascii?Q?YjSkOfkEkVL0e+wPIl7ifwbOpNE8H6aGZD0ABFof6H5SIRHWi0Mh5d5Nmz/s?=
 =?us-ascii?Q?jliQPa/uD/7rjXpCLZqhm/aRaPtDR+eAc/ooaVzex7ho/y4yxjO2U9a5QIs/?=
 =?us-ascii?Q?x1jgZI/BLB15ozp5TjzeWCTuGx74M90dJkOlcyq7Y5B6nEJelTzKiLw62F5E?=
 =?us-ascii?Q?KYWPNkSgLiRAnZNX/yhwJzmN0mByeqb9RdBKOjpRINKI/LFzS1/MG4n1xipv?=
 =?us-ascii?Q?ga72lOfrwivl3p6b/t+1IZtujwUHrxmO4fujWNe1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e68f3b0-63e1-466b-9441-08de189945fa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:19:31.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gRsBBuoFUbS8rZAPi15XAOPbtRZx0oNORAJq3rmsA4SuEIjJJJj8PVppvvoeIKq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

When caller does not supply a list to split_huge_page_to_list_to_order(),
use split_huge_page_to_order() instead.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Zi Yan <ziy@nvidia.com>
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
2.51.0


