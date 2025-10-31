Return-Path: <linux-fsdevel+bounces-66605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B5572C2612C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42225351DB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B92E8B73;
	Fri, 31 Oct 2025 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KKR+NiRw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3128BA95;
	Fri, 31 Oct 2025 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927579; cv=fail; b=fnKdWHGPweCNlGDeqxTbEJBCjKp4yv7J2n4Fj8jcy0E8vgYOeQjqBtbaenp6vJGeIUkUujmbGCWWH8x+Fg2+4/L8YoY0eKBpQw2eRpd4UOfkGh4yutprsds9BE9g8vKQAXrGQts4jO8Gqliqw3PiiorceZkCqHpRMjvsFvUX/fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927579; c=relaxed/simple;
	bh=a8KIvLs39RNIpTyaLeq5e2BJ2nVPYSBglCAt1SeOMwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXq5JQZDHBCBx+nPcUqpG7YNY/krFfteGKGjCWujn2nk/tCrF3T8/f9WtQPlBO+vwoFrU71rXY4npterTt8nFqIUh4OUpG40rliE2XUGULTz8XwMj9OlJN4jF/Vj8Hbdsf0AzwDqvEa8+K5VzlhX+Wh+Qbf6qQ9K1tYYp4AzS4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KKR+NiRw; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1D7OKf7jkfwjIsJ/4jmhu4P/Mn59LRkMjppCzA0cx38Yd5OO8t3Vo18B5HWEQnKLI0W+bTQWWYJHBRI/dKLJQlUB62J4XsPP8HiO7UiyiKWmRZQRsMSgdg6UhtlsOXs4fNQwxWxKO8dkgKmkACjJkWxLfuE4EjP27XEnnGl/uT+dQXzPOtGQ8bkNizcW7mpDdtyqMQpZBtf7JyKIda/X4m06BFAN1aFvroggyU/xsJxL1U5m65FYmA9/1GJIvftcyiTtWkxEdQGTKE+rLc8zOGRjmHFAsy0NlXwQA2dfxIzVB4I18fHDJvoNIqloSjpsGDGEewhFzQ+NrP3NtbwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woUQ2I/9XcC1vghGkqpfCz6pOodMmRVLrjGXgx9B9WM=;
 b=r78ZBX5Mq37kMU3vY33r9D1qCRo2LSdD1V/HE1ROvkv8dJ4q3AZXDdMqs1uLrrGU4MrZXz+cLwEgyQEWjits+ukMf9GQi/nMi5Cm1uX8AJyM9+/Ejg9DWXzB5TaPRfQK3qSwo6uznME5VYAUndnjSAijL5BP/Xd6jUxF6VFQ/3GKv9n/AlUIJ2xgtIWXKteeyjhmhU7sZDJQM7kWhxKpTGsOiAy4sxl7w92bO3m4JZs/a+KvJvobmDMl910bBDOU+HvitY32MdNdqIKTsp4osNBbEsdUypUHpyQpnn6Dxj9ue7aGYLEtLKMN2vOYgTEkKEfQ5XC+OCQXmWx2VKRNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woUQ2I/9XcC1vghGkqpfCz6pOodMmRVLrjGXgx9B9WM=;
 b=KKR+NiRwZ4BrGFW3MncmTSbNwiJFNgttS7y3twVSGkoVLVOjIrpcKJVKZt08b3i3rkNd0TivYs8JKPSaQg1OvkU9IAn7CYonUyMXUiVr4LVGcTWcCp9pIOt5i+78LyVbryHdhWLs+wxIQCUbjcgKXzBqxHANm1moHrDe97q7Yz+sO2SovMJMZ34ziCEbBjAKHfpdyDmlOIe2jV8Gx2bOZv1JD1v5uZ/oXJQEgMp6A5u5ERwU6hyb9/rnEGEbr5VsjNHJDAL1ilgg/9p4GqJnp6oqIlKQ0p/mHQoJ4WIroeB9lxJBRhmz6F8/amZ4PxyViug6K+Jff0kJBb0F3TQ+Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 16:19:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 16:19:33 +0000
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
Subject: [PATCH v5 2/3] mm/memory-failure: improve large block size folio handling.
Date: Fri, 31 Oct 2025 12:20:00 -0400
Message-ID: <20251031162001.670503-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031162001.670503-1-ziy@nvidia.com>
References: <20251031162001.670503-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0326.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7d8914-c1eb-4aa1-d137-08de189946b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LCcZAImG/i5uXQhovgr40dwZoketxbzEl44A5SWcdzW50WHylLPV1xRhi7Xt?=
 =?us-ascii?Q?SEWkKqanMO9HhE6+rVmk22CEI4AVXhvZyyoVaUXAubx/MVfSXUoQPvByF3RR?=
 =?us-ascii?Q?1p2Q796UqbAOpKZtEsX6z0HNvQ3wAl6UVJnBWRmG4h3YzVBtenjFPaSjPMzX?=
 =?us-ascii?Q?/5LCXpsqldOZTon/DP0cWw8pq4sAjN8V2V7+LLC6JrSVRzdqOxNs1ZvGf+Ek?=
 =?us-ascii?Q?zvbakiK3zqroWjKqAQLl/jjEcgCRPlMVUJrMPyHDCbJ7UREGpEViAKeS6GP2?=
 =?us-ascii?Q?t99qxI0cBGYV2Z/wBPQPaS7L9+8E1tt5vgDeaCmuLWQQvX+7r4QSlla1W8bl?=
 =?us-ascii?Q?diRwz2Q9Db23jCpBN2FmLC8qZJB2Q90OSliytJjFG3brAsBCHi8JZ+3UoXDu?=
 =?us-ascii?Q?vpVkcdXEEiht/ZIAQDdiJuazHQZDt+umqeHqcM7ivIq4nIxiD86d4GRifGlt?=
 =?us-ascii?Q?rnNy38tt1nhPftj8J7Hw0jSrPngAtfZqYKaMyr0l9agz0za1I51Mm83mbPvW?=
 =?us-ascii?Q?NPSQmNEXag9ofSkyjSumkTcydbthy27P3bG9dFGOit+Av0SGFJnsae+EDg8D?=
 =?us-ascii?Q?+9fVAxmVpzm9sINgj205w/LOth2/+sZ1DqeM4SsWOL+1GXbnW6W3gD8nIM99?=
 =?us-ascii?Q?GTb5LIuB2xRTDdW28E1LSIdxhSnRZOImIT1OPyN3fSvyc6aiBra/tA/N4HuO?=
 =?us-ascii?Q?sJmAtMhVMzKTEAQ/K8A1r20AuDlHhwAQIoTzNf8/RphT+zFB4YpLKveQ0J4X?=
 =?us-ascii?Q?n2b/FY6A6HExvDDiWNLTPTA40J3Tm+aUAxr++I8t0PFH44J5aOQUOw0+kTmX?=
 =?us-ascii?Q?jD1uNM+OvZOCTHcub9xlau2uM2AXcDsQcph3w5I3wsXIDbOmiArc53uyIvD9?=
 =?us-ascii?Q?pyK036+KMa4AcccIIIiK45551SAFtrzMBvZ7AoHOieC6NHrGn1gLLs0R+q7o?=
 =?us-ascii?Q?EdwEd/GJPwWbSgH6SSPZb6ND1wXzmWPa2q3fVbouc5y7gLBEIzUdEXTTgaZB?=
 =?us-ascii?Q?Od6kgQW/BZNbKJETMVxZ45JlkLI25rosekD/pFOPJs5DlyyZJL3uwtlRoWeF?=
 =?us-ascii?Q?vV6dCibwZaByX32YJipz4vlUcDc77e2mr9zDZ3qwtzxhQ9NNGjYAymP0KbQ4?=
 =?us-ascii?Q?K6M8oX/4v3RAk6S0dQ51NXBuV3LVP0wfGOyu9eMPixEI+HvgfcOBRemG67dc?=
 =?us-ascii?Q?coBrJB5Kc3weVAo1CizuFJoHuxnK91LIhkaVkmVbnnAewh04gp1dc4g/4knu?=
 =?us-ascii?Q?2+SQJezBiJQjXVLzaxFzOt/wGBfrvWV4teQdx8EZM33EXmYKztERMIlYYesP?=
 =?us-ascii?Q?6XunqFHOi+P83Jy2gfQJqxQSHCrDJwn9Mx+gXCyKuALD+tIswLwbu3xEDaUX?=
 =?us-ascii?Q?+Z1c6GspRwWCJQ8u7gBKdXxN3MpgKaVA0ZOGm5OkF+EAoiBF011mK4XQN3J9?=
 =?us-ascii?Q?JEZDXTNI8Lg0PdmKltYokE9PYrYRqety?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VlUM1r8w/mi/0f5VVPZNIJxrSAsVPAjrmD1YE0f55y0Y1QSFWooPy5ZaqZ3i?=
 =?us-ascii?Q?Y57gMzRK84SL7ZM2JgBHXpWRCu5UzF73jB0mt3CQVFgjbFO6EYllYG4At0Wm?=
 =?us-ascii?Q?LdmXYvNANK7rOleGfI9Q75vWuT5Hs6FXsuH+7I5z+KRv0gzkeYsX14Hzr56i?=
 =?us-ascii?Q?bvOFhsWQZWk1iN0atxWx1f3S+2+fcr8wnbqyGlj7VYCI13O+fYowCUdx3Zxb?=
 =?us-ascii?Q?HZnaSeKZjyGwR/w9mKD+lJW5hJRFfCKi3JpzO4X9sd2D4EZbfyR+KhKTvEbe?=
 =?us-ascii?Q?cFBn1fnzPIAOtPcClguYjcQ+1KJzWF2fS2AP6pqBUpOWpcCrFBk5P4WgtacT?=
 =?us-ascii?Q?4sGp25cSORmGIlZgFaE1JFkSELbbf4WPvwohui+JEZjc54LK8QJQEKCBLrIs?=
 =?us-ascii?Q?xT9Cd/JrQ9S1wd2e1w06t+7p4Giyiyc6CiJVn5qPV905/l+jNFp+xH4MpT6r?=
 =?us-ascii?Q?lGFP9H0+aMHPOnROuEU4zJcjPsfbsEm/1O7V41BPhuWg+CotKfevA1/GVhYQ?=
 =?us-ascii?Q?rtBGU/0yLMNLUcAIQinmJgpsr4QSCNj5AsSlwwp9M6P/+QbYem0nOTyfgFSC?=
 =?us-ascii?Q?yCkhRpcNUhwoEx2SI2XmRH3ey9xQlyEGf++9Pa/kkuRR5fqj3Kvk5V7fAHhG?=
 =?us-ascii?Q?jvDHE7IwGK/+KFrc7k/a8OAt0sE504pVeeMgv1qYv6Lwlwb5K6x5qj8oiJHT?=
 =?us-ascii?Q?QBkwSPCBZxohjVasqZawKFDSrUWVDSIoWZ4FQPQgf/eUXpW2T4QkbXfjWPS7?=
 =?us-ascii?Q?7jrKPIGrKhwnXdQlpycmq6q0Uny4z/j0298wFI2CNJqAbEN9KBOw4HL+RacM?=
 =?us-ascii?Q?mjG78VrMajL4ffmDlPR4jMKCasgQPqk1gGUVVJNvMBMR9QT24JgYBrLhSpg3?=
 =?us-ascii?Q?orIW+577S+3XhHcG6lgksjk9FUypxwORqXgyH3NfxlON5ab6itSqf6mmdvCE?=
 =?us-ascii?Q?FprAuwGkLUVQEseigY9eybsqGFDgf+UYNgwiDEisJ/u9/iTEbq/lZqbirl3r?=
 =?us-ascii?Q?ouFUzxDMJKBXl3y/7TQeDVwEmjiJbIFxPjjxNnoMDkEMAFdAMPvUHWNXpADR?=
 =?us-ascii?Q?B81hQTs9elk96Qbe/yBOorstGuKEfT1EZ0c3zShRboPQridNED9s3KcX7rZe?=
 =?us-ascii?Q?pPaj/0p+XjGZdzNmtL7foZ1NjbqNQhlBV2JNFDFZtitWbyOXIn3795KobeZD?=
 =?us-ascii?Q?1SKvYvWKVZfe9k+xTQEMPyh9reGEJY8FVnhlHvlIPV4PYYjs9XWAn1OCK3Cs?=
 =?us-ascii?Q?fGXYGGr9bR5lEjZYluzfvzUZ0ZXq+orwmrXP1kvxIPwOwmJIxyydKv++JXDd?=
 =?us-ascii?Q?ZAxEOUnYCAq+psXQZG+qOAGAbMSvKi9t7MeCTcILNlDWH4jTLfDZGJHb/BQA?=
 =?us-ascii?Q?COBTS/sZ9ZKcyPkoDxwtoQc4DxJHWXRL36ZLA4QujSw0AZ16Tip+jWTh1ges?=
 =?us-ascii?Q?n/dTPrih4WJij+O8+pBAICtJ2xwUv3ZKRFouIiqalMQclz4tJyIMtL9mgiwj?=
 =?us-ascii?Q?qVnjZV9TPpiIAnp9PMQ8faz4QuWt7K2DUv8QARaSbq2YjM5VuVy7PiOw7ubL?=
 =?us-ascii?Q?6zqman87AR0dqOAZ2+MOG+5Grv1thcOYO3pVrJ0d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7d8914-c1eb-4aa1-d137-08de189946b7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:19:32.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxlOK7ZfGDSOr1rShT3oANPUq4e/Tb45kXW8mawdlUWJZ1bSWvsbOYgU5C46keD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

Large block size (LBS) folios cannot be split to order-0 folios but
min_order_for_folio(). Current split fails directly, but that is not
optimal. Split the folio to min_order_for_folio(), so that, after split,
only the folio containing the poisoned page becomes unusable instead.

For soft offline, do not split the large folio if its min_order_for_folio()
is not 0. Since the folio is still accessible from userspace and premature
split might lead to potential performance loss.

Suggested-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/memory-failure.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f698df156bf8..acc35c881547 100644
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
+	ret = split_huge_page_to_order(page, new_order);
 	unlock_page(page);
 
 	if (ret && release)
@@ -2280,6 +2281,9 @@ int memory_failure(unsigned long pfn, int flags)
 	folio_unlock(folio);
 
 	if (folio_test_large(folio)) {
+		const int new_order = min_order_for_split(folio);
+		int err;
+
 		/*
 		 * The flag must be set after the refcount is bumped
 		 * otherwise it may race with THP split.
@@ -2294,7 +2298,16 @@ int memory_failure(unsigned long pfn, int flags)
 		 * page is a valid handlable page.
 		 */
 		folio_set_has_hwpoisoned(folio);
-		if (try_to_split_thp_page(p, false) < 0) {
+		err = try_to_split_thp_page(p, new_order, /* release= */ false);
+		/*
+		 * If splitting a folio to order-0 fails, kill the process.
+		 * Split the folio regardless to minimize unusable pages.
+		 * Because the memory failure code cannot handle large
+		 * folios, this split is always treated as if it failed.
+		 */
+		if (err || new_order) {
+			/* get folio again in case the original one is split */
+			folio = page_folio(p);
 			res = -EHWPOISON;
 			kill_procs_now(p, pfn, flags, folio);
 			put_page(p);
@@ -2621,7 +2634,17 @@ static int soft_offline_in_use_page(struct page *page)
 	};
 
 	if (!huge && folio_test_large(folio)) {
-		if (try_to_split_thp_page(page, true)) {
+		const int new_order = min_order_for_split(folio);
+
+		/*
+		 * If new_order (target split order) is not 0, do not split the
+		 * folio at all to retain the still accessible large folio.
+		 * NOTE: if minimizing the number of soft offline pages is
+		 * preferred, split it to non-zero new_order like it is done in
+		 * memory_failure().
+		 */
+		if (new_order || try_to_split_thp_page(page, /* new_order= */ 0,
+						       /* release= */ true)) {
 			pr_info("%#lx: thp split failed\n", pfn);
 			return -EBUSY;
 		}
-- 
2.51.0


