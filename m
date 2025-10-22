Return-Path: <linux-fsdevel+bounces-65024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E597BF9D81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4100C3AA158
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 03:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E742D24A1;
	Wed, 22 Oct 2025 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZs6cdev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3B2D12EF;
	Wed, 22 Oct 2025 03:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104215; cv=fail; b=hm9O1F8tubJRbTOHLHGJU5/cDAYs2nT8CVVw6KmLyh39ktFS98bj5yifh+X5vGrNqaP2dSRW25t3jv9fBEUTZCmr72PLAU6Y+8+0yqgIuwFHUqZYeJJNTxxllJeWNw/8zBQ253I9lBPcAvrssYiVdWiMsxU0uomrybxIqTozKeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104215; c=relaxed/simple;
	bh=Sabq2INy/MOMyItWwhHu4XLNYWjuSLUPreGnTw8u3OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZVd86ahL9CeopkeG3yFOivdc2DpvlNERT+qC2qvE8vi/Z8iEirwDYIm81/YeNTGnOcVyzwcViQCIBXRzN19srwZTiS50ZPFZL2gcujIwUlMeanlFIMkvEoCdAOaApCh3rVADY3ZURD61wRC4mP85Ge/W2YjGk35wSa4dRJ7eZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZs6cdev; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UU0oWbRBcM6Ye9rgCAs0zwQ38QfIe1hp8EjQMpKG4lc/1BK+f53A2tyzUFv+bPKAOs85XaIvcvq/kEM3TdMJAEQhEg5dD/FSHCAPkqyr4Cw1dRtTak3rtpm0qm4/AIXE8vrTXUTjUutM/KPpjVimscUqS6llxv/r+npAMa3uF03T2Hpg5L6RdCGa6hl+BDiXq2nebe/7s9Viqyc6ujiM3/cufeDiDH0KwJWxjkU+dwyp/UIfovLSff5pkM9ecUO2gomfSJsfkvuRFxZaRmvHlD6pL07imw/xlcQ/83xWRBafI+X+UbZ5A2DDEHgtWlNEpHoVMFrrT72Q5QJs7g8ZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNWpJDD8I94LJ2Ocy7mlNJTkesGvDb/m3LvR8DBD1WU=;
 b=Pjgxj3RTKLl3B4yp7bk+6Pj0dO/PHBhRmSDKVOxdRMusMDCs+sXCTT/T3SNgqmBbGQ9YLbnXcsf+705GXvvUgXNiBnYANQ5M+IZlgFilTVYX6+5NfBbnM8Z+/BTnFoKUTx8aEXw3FFZHcD2q2LLZYzVIT2pTGT4WsX8UY7E25ThpwbRWP0HBI7BS5W0BIznV5TxLaSvDmkOVLwN6M3pKEbiQp+lw/TbsrHtegSUWDHRwa4zBb73kJXASxdfe6xSeNqspdzWE+O8vE1W5dTXdKslSbuGBl34012wJ8JsTu1yJOQODqqIXXaqxvZOKJBDt8LrUFnqt/1g34YeDEQ3s6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNWpJDD8I94LJ2Ocy7mlNJTkesGvDb/m3LvR8DBD1WU=;
 b=JZs6cdevuWWk/qmZjxZ8ap4W6eDYwEH7csIPdNakO/WmRMLjD/CmmSqUiyo4vPQguY74Qm7ibNnUZxs5vi5rKFCTnnFTWYeRWu69i51q4H0Zd8+6YoaXJNQO30C5CH9EhvTrtmu1O2vmKtfQ7yr29X47GGyBJMPgFZg7UTrfc7A+Kbd0NC1/SvcYa6aKFIXUiQZUltc6eKz9X3LI8i49RqZpTfGZkQv1RtJ4RwTqNH/Z7OPCiWkOHijrIuI3Q1FDkJWxePncUhnYH2fjwA2YCm7xx2D/NjUdgyDKKbw6Q7wRirWi96lFmboKYXS/4omLCrGVLwrYa9CRpgCHlpKKYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 03:36:47 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 03:36:47 +0000
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
Subject: [PATCH v3 1/4] mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split to >0 order
Date: Tue, 21 Oct 2025 23:35:27 -0400
Message-ID: <20251022033531.389351-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022033531.389351-1-ziy@nvidia.com>
References: <20251022033531.389351-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:c0::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 779f291d-08a1-413b-286d-08de111c3a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/RsHpjAAdfaQuIIcHNV96jmFRMELSZz0QA2D+v0I75gJAF4R/O+/fSZgcR8?=
 =?us-ascii?Q?EyE3eNqZbe32PAge47elPH4UA+UpQHsFZyOjOLD0HmIdy/ZHixR33NryPYZN?=
 =?us-ascii?Q?LSdwINH3UrYH/PbZXANojprHZZlU51OQmMlfCFJPVBdMyZ4XhDEFGdkDB2PY?=
 =?us-ascii?Q?/EnbcEi1+iOlFp4S7tnuPLqoOBWIWyJClkY76bPjUZ8eipt10db0/aWta+67?=
 =?us-ascii?Q?zhsbDA6cn97CpK5KoPx0O/KtehOXRb7wuwF2KDiHOk/Z0Q937tmwN52M+FHF?=
 =?us-ascii?Q?WeHIOK1kYqbT0lLfRcYKfM+q9hCAv2TApZr86m+YQ4dJCdKBvb8vcbwIjGbH?=
 =?us-ascii?Q?VXep5WmrD7R93V4Zmi5r4YIiAHBZgs7kqlyxYlsEF0t3F8mhDllEDkxlFpV2?=
 =?us-ascii?Q?JOx13JLqozszGWKr25szJ+knP8PD1IpSfUCf0+lPmFh6msgeXGVym4ptmCAa?=
 =?us-ascii?Q?IDsjtip3cwJFBYq5r11UImjF3QWRxyXSdbQ3dR/2xFWVcTQ1HbWRAZk68TMN?=
 =?us-ascii?Q?McFphk31GtpIjhtAHzbm4aELNm0d/i1r8c3eckmnFkcZZfW/jINfgETINx0X?=
 =?us-ascii?Q?dly3FRHtn3N+TuLRiXZlLEagc9Bs8AbZKzoYk5kSSJgcWvbG2B66RRmRpWxO?=
 =?us-ascii?Q?ly3sS+ngWmQrIHMTAffDZ0zNrRpFCe98R4KCDD1HFx4t0iql/AUyIMnWhMFp?=
 =?us-ascii?Q?GOyBtf2bySAyTfFZBJMOFLZOnUGaWcfpYDRgakZOmlwv67e4uuFgPVuGawB3?=
 =?us-ascii?Q?tLUhlLFifdoXQRQiXR5Etd9ZCY6FEhVAnfom8HBsScOyhjWRLCw28h6n32xB?=
 =?us-ascii?Q?SErrljbvncZmQ8e/UfqxTCahgY9mGMM492RAvHk+IoA856RnlA8NSNGCD08u?=
 =?us-ascii?Q?39gQ43n40Sg+zhEHqxebxX0R9aRVUdicf+6PBZ6EQWI+8jHnvk2HOCY9ixZq?=
 =?us-ascii?Q?6Z1kX0sensWH77A76DSliCtNhv/+L3Lt9fslmwSaKZTeM0wN8sbuHHY5eGtL?=
 =?us-ascii?Q?A7qNz8yKZ8h+V9JIEwjCVXiQXYdg+7G8eYtJeb26PjGxE29fjrbk2P61G07Q?=
 =?us-ascii?Q?2IyEIOyHJvzEAoiYNdvBuKhGZxSe+2J/bTtMo6wcJPUugAi/3+e81NiXVWm+?=
 =?us-ascii?Q?FCgrjd/Xt45Pc5HSF8UbpdeICdHy7AXgckaYQ2NjxM4Zsj5TXsnT++L9i+1h?=
 =?us-ascii?Q?FnnCImgBgiMByL8LHPWnQJ7wrYAjfuV0bgVZLRRJK9DvtGG34LbkUCX3Se0h?=
 =?us-ascii?Q?sb/1VaZ3bBMBjH3XybHv+QQhi10R/vC63hASdPW09hPk21GTmI7P5xDA+hqr?=
 =?us-ascii?Q?5ZrGishr2b5Xobz6woD4NDM8ieXTmHl+rLMq7GPju8wV6BmszCKKa30GT9/i?=
 =?us-ascii?Q?MIqTNPEsB/XWQYBH4y+NCv4AxodhSpdd6TzhdwETsVQaeQqT+JSzFWTpffzb?=
 =?us-ascii?Q?12uj5TXlavqsgh+ivFr4ZAWWouU6uvy64xQJ4O4xxJBypueIgDJ5sA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZC5e3qP57iKK0ufLS3LlyD6J1Xw2BV5sHDt500XQRW9qPFCfqdv3+DShCAzL?=
 =?us-ascii?Q?QGydNwu+1QAP0DI145I27iAvcqzdToXYlol3JNtR7sEOpPwBh17XxSzcfGTo?=
 =?us-ascii?Q?+xugLUAnZqrPQsIGvjvXy/8GnYd/jHpDHATaf4KkUTkB3hvI/q9SdVZqFMCx?=
 =?us-ascii?Q?mckTCTXX5gxo5I8o7hCjgZSc1SMeEuabK5DpRk/nhHCbOAdUEGld7nrlhh36?=
 =?us-ascii?Q?Vz4gK/CYDWeNukEbCG3LEtfiad819qO3vBQxSU+2/VS7v+7rsivxZoYGvf7k?=
 =?us-ascii?Q?5Opt8pMbrUQZ5mp8T9yo8eDFtS9Y0WPVMkaXANkFSdeYoLpaM3QBHamziAau?=
 =?us-ascii?Q?dWXvB/eZVRNO9kPCuuAwuTOdeBCZkvmwRJlZaYKMsBYRNmY78R0uDoT7s679?=
 =?us-ascii?Q?A4fMX1hOqqlu7wT4/dNrQmwxYfKoJiUeN9KIHs5//Zt0JnIacML9d39OzNjo?=
 =?us-ascii?Q?RtkZa8BDW9paFriRZcT8G7g95rANyQbQEBonL56uuxcXE0UgygfLvGiRtMHw?=
 =?us-ascii?Q?gK6y+ZdyZ+h3wj+au4by9mNIbuyZvPFS52Dt/WFclly59IrjKJo8NPGiBBFD?=
 =?us-ascii?Q?Dv70H3IlC2cvbrx27fz+FFOHhQckn0zliMV+Hd17MuOxZgZ0Hz1M5CAsGFqP?=
 =?us-ascii?Q?PbshRRHDVnpNic6fqK11/22CfmdlRIAcoRcsr6ZgLuGv+7OG3sRLug8/LvjU?=
 =?us-ascii?Q?NW5k8Qf80lMGu1O2Y+JPrZTY69NL1MyXDsT6FYkkPfCMck3wEeciK/yTo8ie?=
 =?us-ascii?Q?tPqiVxlLjgCvJeI7NqgUfhiEOBPBZY9sy6IRl2mJdnpVjmt/5DtlNSanRA7h?=
 =?us-ascii?Q?Fp9bKamIibqAja7SSyn5rpr2sEqMEB+BD/lrNEQRXahM9u5zq+anzl1q08PP?=
 =?us-ascii?Q?QcpPxGHsxcfLYLhGTY2xwioIoesBVZabiQ3c3H5Xh5hZonUM5akHiK/bqJIv?=
 =?us-ascii?Q?+t9Iu01s3VPjE5/KPPvZvm5YEJjM/vd4lgn9lsdfGGYGhIl1b0hcwOyMOjWl?=
 =?us-ascii?Q?SfhLUtfISgBXtjzqMGSYK6r5FSOo7n2XlPSWaIXcoP348HQB0vsvb9n3Vdki?=
 =?us-ascii?Q?JOEctzQB3H1x42OE7S/J6ZWqrsqEhvYiWKwUmE3xd8C882LDKMikjKgHVFDr?=
 =?us-ascii?Q?+AjOcvTHF3ku8W4qxCuuz1OTSh/1kzoQFRIOM7STR/G0mQiTTyDye0ghOKVJ?=
 =?us-ascii?Q?tg6HSvYSy5X9s5UqkIFpJG7R9iHE8CI1hsECmNeZ7aQ0TVyg5n/BZ1TutnfM?=
 =?us-ascii?Q?Qb4GoG75OeNULVauMopwyM0HvnFESttUXo6JTG+CbXYUUNKXHOv1b9c2JYNW?=
 =?us-ascii?Q?ZWwHOsZAjTOHfwe7A0sTPXOSxHHzRY9NGWWD4dn3H3RcO3Hex3T9ht3kEboN?=
 =?us-ascii?Q?MmYvTOw0eswB71ca9mOblpcgeECsvUhj8U0X9gzxNplp9KzAcX0eLPLtf3Lq?=
 =?us-ascii?Q?X0Wdem86c+EwqARmj+wx90+Z7oRwhntcaiFZ4j7oYpfXEoSH7add6i2zfhlW?=
 =?us-ascii?Q?b0iqpJkuwqa7iZosCn3buA52Lj4zAveZctmsOcYOB6HSpVvvX0pcr8qaMyww?=
 =?us-ascii?Q?Nom826HkwEM6DPDa+M7V+DaA3tWWmFWlSMV5WV/r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779f291d-08a1-413b-286d-08de111c3a95
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 03:36:47.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eEseUVzi6AIhABGX8V4FQekYcO/IyQKLzOuAQFk+L6X6FA9NV0nH3Db45TSuyeg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268

folio split clears PG_has_hwpoisoned, but the flag should be preserved in
after-split folios containing pages with PG_hwpoisoned flag if the folio is
split to >0 order folios. Scan all pages in a to-be-split folio to
determine which after-split folios need the flag.

An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
avoid the scan and set it on all after-split folios, but resulting false
positive has undesirable negative impact. To remove false positive, caller
of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() needs to
do the scan. That might be causing a hassle for current and future callers
and more costly than doing the scan in the split code. More details are
discussed in [1].

It is OK that current implementation does not do this, because memory
failure code always tries to split to order-0 folios and if a folio cannot
be split to order-0, memory failure code either gives warnings or the split
is not performed.

Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com/ [1]
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fc65ec3393d2..f3896c1f130f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3455,6 +3455,17 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 					caller_pins;
 }
 
+static bool page_range_has_hwpoisoned(struct page *first_page, long nr_pages)
+{
+	long i;
+
+	for (i = 0; i < nr_pages; i++)
+		if (PageHWPoison(first_page + i))
+			return true;
+
+	return false;
+}
+
 /*
  * It splits @folio into @new_order folios and copies the @folio metadata to
  * all the resulting folios.
@@ -3462,22 +3473,32 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 static void __split_folio_to_order(struct folio *folio, int old_order,
 		int new_order)
 {
+	/* Scan poisoned pages when split a poisoned folio to large folios */
+	bool check_poisoned_pages = folio_test_has_hwpoisoned(folio) &&
+				    new_order != 0;
 	long new_nr_pages = 1 << new_order;
 	long nr_pages = 1 << old_order;
 	long i;
 
+	folio_clear_has_hwpoisoned(folio);
+
+	/* Check first new_nr_pages since the loop below skips them */
+	if (check_poisoned_pages &&
+	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages))
+		folio_set_has_hwpoisoned(folio);
 	/*
 	 * Skip the first new_nr_pages, since the new folio from them have all
 	 * the flags from the original folio.
 	 */
 	for (i = new_nr_pages; i < nr_pages; i += new_nr_pages) {
 		struct page *new_head = &folio->page + i;
-
 		/*
 		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
 		 * Don't pass it around before clear_compound_head().
 		 */
 		struct folio *new_folio = (struct folio *)new_head;
+		bool poisoned_new_folio = check_poisoned_pages &&
+			page_range_has_hwpoisoned(new_head, new_nr_pages);
 
 		VM_BUG_ON_PAGE(atomic_read(&new_folio->_mapcount) != -1, new_head);
 
@@ -3514,6 +3535,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 				 (1L << PG_dirty) |
 				 LRU_GEN_MASK | LRU_REFS_MASK));
 
+		if (poisoned_new_folio)
+			folio_set_has_hwpoisoned(new_folio);
+
 		new_folio->mapping = folio->mapping;
 		new_folio->index = folio->index + i;
 
@@ -3600,8 +3624,6 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	int start_order = uniform_split ? new_order : old_order - 1;
 	int split_order;
 
-	folio_clear_has_hwpoisoned(folio);
-
 	/*
 	 * split to new_order one order at a time. For uniform split,
 	 * folio is split to new_order directly.
-- 
2.51.0


