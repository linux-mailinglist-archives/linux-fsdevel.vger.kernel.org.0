Return-Path: <linux-fsdevel+bounces-78808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGoEIw9Aommq1AQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 02:08:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEFD1BFA09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 02:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A58A43092B9C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A552D7DE4;
	Sat, 28 Feb 2026 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKhf/9dt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012033.outbound.protection.outlook.com [40.107.200.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116028C84A;
	Sat, 28 Feb 2026 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240902; cv=fail; b=p8PnY1bM8BZektmgsqLX4l6UGQ4j8Dae6kT4xDlnAM7E9FT68obN/6SGZmza2+hc/9CEQtrVQnP7t/WG57uUsBgQu2gbQ/UyyaUHJ3yvhwqNpB92t0noPcmnbP87dwhMnWEEBhSwufP4z91iIX4e82MOX8g2bZ8Yq+rT2UqfOl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240902; c=relaxed/simple;
	bh=Mws/I4A2IVohXxcbPrg2ZKZZChaWxg1HrNcStFlkIL4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CYaVCuB5nmMEFTFTe5kClEBz2xKH5AYCvdjPVKqcx6A3tPaNVq54DIjreatTZf9WMzqK2DYLcikwGvM6F8Hcc+BfbQVwiQZ0INuyW89kKX56O7AgkCgzIJ9uUnH8mFkrRk8v2l69NZ9DwylPUvnaTql1zx09x4wviIrsLj4AY60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UKhf/9dt; arc=fail smtp.client-ip=40.107.200.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWNy8XEnBQ9ab31f5NSaeCRfiRwCGRAypTh72FuFw84jzIta/izSI1j5+jFjTLjLNCBDHMMFU/YPqeLb5BBGccWP4SQemS63tCLHb/mCjCNU7W4dpxW3HUb8JO64qlTC4mpKhKtNAWVIoUjUC3yiYXYm9hO/qqnKvR0Q+YfDeOB6yMsJPt0Qe6D3ZhMnTQ77jMRoPNVmCPhjc2d7hzzA/teXhO8W82a9gcOG5v35wJe5nj0Jg1faWU+ab1U7JcvEZD/PZIg6lW8wHx83SoUdc9r9PBjnjL6MT5x7SVkj7Dy9vmBtErOsNoFi0Rct7Bs/0eavt4sJm6Oz1slTQgfOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJTElIUfz4ezm7NxO6OphCmGbdnNbHLjBP6OPeWDOyw=;
 b=CsqCkepwNdWT/6jio8NlzHnJV49FqTmesnhvRF/MoqrNp8e9j0A3cc2uvmd3alhD+lk1PTPhkrPrjvAdG7198FhvitFedbqK+WoCXIY158ePuXzi65jDFTHT57x+Qlw0Z+jvOZVKwkMTCbZHVeWquVNBxdofnVNKf67virjeX9vZ0OVoFwb2JoRvp7MyDILFqhIOIN5ovVxPMX3VwqvBTdY9CmNjGbZZnjiDPgBcwfYVVs9/G+k161XH9IziQHVXhyJlWsAvFWLtAj7MdZCJeWMuJJjg7Iyu3xv1qOhGfUcRrHJxtpbfpdZZxb0RTulR3MTjmIXHwG2FG2cdMJfukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJTElIUfz4ezm7NxO6OphCmGbdnNbHLjBP6OPeWDOyw=;
 b=UKhf/9dtL5q7v5m26eZEOO9ArjCTc9vylrG1y9duOwYRnkJ+i3BHugz6V875t/j+pTxTqc/RBsf3S/tL/wOWDNKF/MiCjoPjawb+XQlaaHoCCTiB/S18rLKZG/rTDBpFOD1AzO0iRQV5VjIXs0ca8fBEa3PPUsh61WyGzrhAnWyTjygnQAuot+VN/TLAYahrYngnAk2onsFpa8gPe6wGji9GcdPV1fLe237iKjys97p8skXHy0AKpX4Dr38mtqyHQlXTKOXa9gs+7cObLi67+kH6QFNWefKfDix6Q86MX+xM2RztbVMUnVYJt1EPoU+uFhobcqiO87WIKP5EJNUiIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Sat, 28 Feb
 2026 01:08:15 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:08:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Bas van Dijk <bas@dfinity.org>,
	Eero Kelly <eero.kelly@dfinity.org>,
	Andrew Battat <andrew.battat@dfinity.org>,
	Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/huge_memory: fix a folio_split() race condition with folio_try_get()
Date: Fri, 27 Feb 2026 20:06:14 -0500
Message-ID: <20260228010614.2536430-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 367ab079-753f-44ea-1c35-08de7665d9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	VcicW8mpbs4JHHpU9YAXxo2/1DCLxg0WBR/mm5bLDEbKQEEQpz/F71UlTfc0dCTKA7/a4yk6o8VKJJQs6Zz5YDB2hK2oOsYRZKHRiJWz7roW9NXpoXTEvjAM/JwIrp9rhuO0TVE4d6fv/KFbFHjfW/qXL80xMx7RiVI4W+5Frn+VGQyjvcm+pa+fqt1HFQE5xyOe8+5KjzrmixJq6fpCPB/oUd/qP3uK26xbxGGrxD6C9eLzKZ56D/uJpA9Z/nMhktzY+oeYOLVt4E0azcr3PPvkizgZv2tBTsGX79VUEvsorOnZS+fLrjV8NeYBOqKrthqeNn+o3sIYAs+B901P/S+kCZ3dTU4J37fAgXPCbIcbIpfdSMJBb3qU7esfcQosAm6M2zf3kERkKkrr2prJvKMMJ2nh7yJrWZU4xanXTPGJL8Xojx1kUUr/4w9CxX9tVIjhkc6uJNX7tnvtzbQLy/vtEINowXl4uEsTkUrZvlGHqaPkSRHKfADvFgAZ77cZdE4mJGCrgThtYr2RPRTS4+vXQj8zeJjYdyaa35m4T1XqS2rud7GGdrDsYYvBShsD4wwFHNDjdn6D33cqQHNeDs4EQi5yYk7kmc/qF78CthXvMU+FbfPHsIQlfCxlm2DU2t6UZlocCnfC7V7Lh6mml65cP5GlsWkCSeBJJNS9zqyO5npaElXwhx/ImloZ7tyD9Dft6J5YAe5dqUYCaOc4EeCjUwbh8uHZHPpDhPyDKxU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TCpq8VnFuQSx8EiHROMCG1eIMXbMlrOHKt11mnx/YBvqdFf69zbH6JSeESo4?=
 =?us-ascii?Q?WuDZSIUXEGI5rNEXTXKufr2xnrszjOtMsehjkX3VOEF5oTInW5OwLYfGdPW3?=
 =?us-ascii?Q?wAW3KXWi669qaUnzuZKSD9L+ZlTiECL8mwEkxV1C1HW0+lzCxlprYqVtmM2H?=
 =?us-ascii?Q?X3YQmoQmmbn6+t9LnIoKt26xTB89kFYCOVw50k6OPf2rMmQ1jCTHjWNuBJFN?=
 =?us-ascii?Q?2EtDVxJyamJFbJ0ZiwIkBFtI37ZHNMt3xvpOhL4z2OaLGMgFm7MAriHgX+Lc?=
 =?us-ascii?Q?3NqepfZBQttiCVV4C8Ao4OIOkZo+4oLMHbQxeNtTQjFxdE74hCPq5alds4I+?=
 =?us-ascii?Q?QuY/w2pO42nwgc71F3iQz6H8yMUYdlQfYaL1Xp/xbSrZPE/06nlsm/9JFxqp?=
 =?us-ascii?Q?AGUWZfTndugTRKdTfCOPfdOQ9QGpWaj2LjmlKaZiHDnV3MobqDycPOtomPPV?=
 =?us-ascii?Q?3grhUpUjmXklYzHoHY0+6PnMU64LTlHAxqjcKyL4LCWPiZp6RW8yGBRlerfe?=
 =?us-ascii?Q?5x+uGCgjD0JB9SOnlObsZNYH5ccEIHx1YqMDA6bJBcGzKeYiii3Iai/oeCu8?=
 =?us-ascii?Q?2dLV4hoswpu8r0tANU7NYvu73HIlilQ/2juRoDg85MGSq5/xA7WM9EDtxU8y?=
 =?us-ascii?Q?OoWi/CpYtlxVCndv7PtKsdAnDVcxCBNLxeW+pVuABbCjyAmAuAYCI7dFiAB8?=
 =?us-ascii?Q?r36+H49wkqQlSPWtL/c1adxoHdqLNnvtKn1YeaJtegJgKua3hwTR2nvcr6NJ?=
 =?us-ascii?Q?ExbuQ1TgJe/7oYHA8Ic+Mz65DZrxOomKlqXUVEs/HMPB8LZ5u4nWTwOVaWQU?=
 =?us-ascii?Q?F9Ji8oYTgUPkr0K08dmRVuSWG3b2ycpmqBxrPlk8ecqV7zq6KDYsNoWhqAVj?=
 =?us-ascii?Q?sr1jLn2+QnAdqDwhTpBKOv35BoaaFQYWoK/rCtEkPv99hPXurFLSJAb9jyZS?=
 =?us-ascii?Q?tDVoEen/UX8blak3Qbidom9OwY5a6z2vAnCoRVTXSZzGLSLfUJXWvfVdVAUJ?=
 =?us-ascii?Q?+mNFtuNHhtjBRlD7IhgCBkttrmwns7UNs4JfPFgq7eoVCDrGjszdwEN7PEY9?=
 =?us-ascii?Q?GrpawDPQ4INV5bow2KtTg/SruBxeUTDJdSubR88UPXEyzIAZNxyZL+PUtrHa?=
 =?us-ascii?Q?znn6wEtyzDPPN3q37WdZdbM7b2r7JqTKO8l+dh7jOMAFL3wOlj0VyZyQ37MF?=
 =?us-ascii?Q?rNnua0uCg9Zv7GYQJcF5bLXI+bM+bN66RlNja7U5728KKVd0jpLsy6QDFG66?=
 =?us-ascii?Q?I0ZFCOQ8bPUXIh4J/+2w6XT5zUGaxo8Vw9Vjf+Ox3bXCGh6R+vm8bBlGgsc/?=
 =?us-ascii?Q?qGr0xKvFeGCSw3lN/FWKupv/O2VCn6nWR/ZeecPuY1tlqln6t9mtXUSGRdee?=
 =?us-ascii?Q?9XBLkNAkIu16d4U+9FT+6Dq1r7v4CWKB63t4m4z09qiqKyALmj8b2YgiVp1y?=
 =?us-ascii?Q?tw3Xm9Tp6gUQGYGbA9mzqtV8NKmcO3BZjVsGv7ijUf9YMHRr2tufQTvkzfRc?=
 =?us-ascii?Q?R38kdAESYgp1x2SubEvTymH4V9opHmzg1T3udcADcHg8ywJJDz3y4MU2oxTN?=
 =?us-ascii?Q?z0H4Uv0F/wY+hFFbW/oV5tRW9QxFvGdceflIgdo5vB/eRKTW9CkvE8qNfqQM?=
 =?us-ascii?Q?UOsM91sg3UtYUXX144D4u+wnfR0wpItLubYYEJZvkXHGpQhZoG/9XYvAZtzF?=
 =?us-ascii?Q?4gR3KCQxlNCQ9yQMZ5xQqeQffy5EuXQELoYtoNfUVsR261Kr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367ab079-753f-44ea-1c35-08de7665d9fc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:08:15.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0sn6FFadIaA1kZqCWS6D8rnCLQ2n5mP74jx4WKFjy3oN2RlzP8ypmpl94Xy23YO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-78808-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4CEFD1BFA09
X-Rspamd-Action: no action

During a pagecache folio split, the values in the related xarray should not
be changed from the original folio at xarray split time until all
after-split folios are well formed and stored in the xarray. Current use
of xas_try_split() in __split_unmapped_folio() lets some after-split folios
show up at wrong indices in the xarray. When these misplaced after-split
folios are unfrozen, before correct folios are stored via __xa_store(), and
grabbed by folio_try_get(), they are returned to userspace at wrong file
indices, causing data corruption.

Fix it by using the original folio in xas_try_split() calls, so that
folio_try_get() can get the right after-split folios after the original
folio is unfrozen.

Uniform split, split_huge_page*(), is not affected, since it uses
xas_split_alloc() and xas_split() only once and stores the original folio
in the xarray.

Fixes below points to the commit introduces the code, but folio_split() is
used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
truncate operation").

Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
Reported-by: Bas van Dijk <bas@dfinity.org>
Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
---
 mm/huge_memory.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 56db54fa48181..e4ed0404e8b55 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3647,6 +3647,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	const bool is_anon = folio_test_anon(folio);
 	int old_order = folio_order(folio);
 	int start_order = split_type == SPLIT_TYPE_UNIFORM ? new_order : old_order - 1;
+	struct folio *origin_folio = folio;
 	int split_order;
 
 	/*
@@ -3672,7 +3673,13 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 				xas_split(xas, folio, old_order);
 			else {
 				xas_set_order(xas, folio->index, split_order);
-				xas_try_split(xas, folio, old_order);
+				/*
+				 * use the original folio, so that a parallel
+				 * folio_try_get() waits on it until xarray is
+				 * updated with after-split folios and
+				 * the original one is unfrozen.
+				 */
+				xas_try_split(xas, origin_folio, old_order);
 				if (xas_error(xas))
 					return xas_error(xas);
 			}
-- 
2.51.0


