Return-Path: <linux-fsdevel+bounces-42022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C849A3ACE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 00:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032287A4465
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 23:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712DC1DE4D9;
	Tue, 18 Feb 2025 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CELEFCGS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1531D86CE;
	Tue, 18 Feb 2025 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922897; cv=fail; b=uWTs+eSYzQvFTHv9ylQrz+c5MmfUl8SU+NYpcfQoUlD3Ff/cmpZOhEOo2HcTrhBzpKT2QhlQwwM8thqVgPI2rfu9RZIs9ZU+DHC1YrBmGreEdbc2fBR6f3d6u9tXVoLOC8dJR9SeJlNs4RFzQMTvTeBUeQ1JCJ8YkRSNKZeO5q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922897; c=relaxed/simple;
	bh=gb6oAPWikrhiEl0tkdvCnw+lCENhLtMeTjS58jAXZUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qnBAWKtvQGb4CKu4BsvUIEc37T8nTetnSIVPXfZ9wBf/C58hwCcmnrRTwniLr4GTzC1Vr0/zen3qoosXILIQi9EqbVTKn6m1RjM450i6jriIv212hzGbKxU9rWsDzdXJ8lph7p4z0mBRuUj4AH8N6F/pE+qF/172ZbqhrYyNtsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CELEFCGS; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSxK2K3HAA2cXtJ8wcGRoyHu3k45C6cJa7DZ5Kt70P8RdPDKWIagydtjKFUn4hqAxqkcrA1XYuMk0wFOrkCShIyW4NkiCrGsdhWu7b5pyo5yHwUAgJPwLRy3rGk/nV9v+/lL2PCfA8IanVjoMLE+bT7+kcPdzNBP5NAisNA4djF4JTLquxRAPHUNaXSlXw8kGCmoePR4gQ9yfox/u/V4inTXBwnvjzV/kEdpVD1l0B5nTOLW9Mck+Yo5724KIsYQOP+T4JI7sLzwGFTvWFIw4Qj1rTJT3jkE2jGkeM0ApU4o/snl6yULK0zsWesOQRs38RzMrIg5qCoA4IrvxSY4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QuCbMHib6zbVMGyf2zEu2fYzLX/UadW3QhlKETvqro=;
 b=FlYzRR4iAFvrA4LOsic7VAddFnqug11Cw98z6HFjaNEPhAXrFnSGEIUSczfR+zmTS451EiCuQvYjXN1aTZMvBqPATaSd+Bi46TV3bL0HPyNewrJXZGigCI1feAV2GNv+Q3KIQzKeOjht0dokeEMelUbTD3wu/i6+y+C2lUWEDgR2TWYhPVeoiAhNNucOIkF1Krp6gHD3PtrJ3utD9SNMxwgPL1wX9CdpODQn7+r7i9cI5oR6soOPOCQ+o5//YvKAsFCbPbUYOeo8Z9MQUlF67NTfdtPwg2PYZyn6tAbA/PqdTCz4L2JQCzwIC1KenJ/ixkErPz7SrHyTLzd6zQQ4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QuCbMHib6zbVMGyf2zEu2fYzLX/UadW3QhlKETvqro=;
 b=CELEFCGSaH42frk3O1qLdSmpR46U42A3BR1mWs6Bev5Mje8Xepz0FkwpUNNWoVLdb/xJhj5/NN7MSyEcDPiMpl21xYKqC9IkRJVtGoiM7IObHGK8Nrl9t1FaYGy5572ZMS2/PVdnA0Q3+hvBD4Owhzm0iaDJXIRmQNHUIUNWyE/mESZE2ED1QOAatPlsVhu7ttP6uneOBO8fALabz//dZUIUuGRY03yXvbEy4QG+WizMQPRvL7tJsFnlrXTeewSeay4+pAbAIcxiWyR0lXKgF6ProoHhBjSbHRzEOX+/4PspVHlBeFAwXKRXlhAP59wyejfYHHH6biGDDGbLYRkZ7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:54:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:54:50 +0000
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
Subject: [PATCH v2 1/2] mm/filemap: use xas_try_split() in __filemap_add_folio()
Date: Tue, 18 Feb 2025 18:54:43 -0500
Message-ID: <20250218235444.1543173-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218235444.1543173-1-ziy@nvidia.com>
References: <20250218235444.1543173-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afa03cb-0c92-493a-9f75-08dd5077a1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vlx7hFIuVZHAmaqDDHO0s3WxK7QBCF3DMmN+ZsxvSb4ZwBEVVUVJJ8h31weR?=
 =?us-ascii?Q?WvADxvPTwl/54Exk+jVQW1whevX1ebaYJoaF3Df+vi9YCNRX3SJIaSYUitSO?=
 =?us-ascii?Q?eDnkkioWjUKYZrgpbcKlDdLX4HllBdiB+3OvfQFz+TPJm4pyPDXLfvlH/ZBb?=
 =?us-ascii?Q?ZfdeoFS3dYhjaNzwL0d8XgDRfuUk1SIj/M/NdYA2/FkjXzEL6jCP5qdGzMCp?=
 =?us-ascii?Q?1vVu4ELLYeuGTjXl913CSpy2B9dc0NW6cvdVW3p+35mcBEjpY/Ra4AFghM9f?=
 =?us-ascii?Q?qhEMeikIcm4GXFZSgNCUR27Lsw+kEo4D/hdnfvoO6ERVZ6ATuw92S/H9qB7M?=
 =?us-ascii?Q?ibKEhGbm+iFZQN0miKW3oyCHk+LQ28FYZsBsk1EAm2LvKvAyBh6lkRz9/O2M?=
 =?us-ascii?Q?CyfQzap5qM37EIdUWQgytyHAvQ1vI5XOCwq4ulCVQ12GS4uGhS4FpHVSE/ta?=
 =?us-ascii?Q?1MDdCHIVBKleTnxpMb8zV3eoaySwEEnlJANillIbpszxm6drwall9L7g+DUO?=
 =?us-ascii?Q?HcNbvmYsvKdbsUkE3NmS4VFwtr3MECpXVCzxkO9b5H1es8LNCoQWrKdM5ZfB?=
 =?us-ascii?Q?3rxbQGE+3CS5+PeadYyxiuYyOua8K8OO8XlEEKh1SmWesMnLiJPYPFKuPTjx?=
 =?us-ascii?Q?tRYduVqe7kT3srUDsNLtgex4ZgphGVbpuAea+AZDElFeGKqw12it1xFbBqg5?=
 =?us-ascii?Q?+j9d1rqf16OxKsjkvt9qifrjroY+jlgnRb3SgIf9Pf8LLlrg0+UGl8U8RmGt?=
 =?us-ascii?Q?s55mkCR1m6wwLmy0sV+swqbr5chqnbSExSsV+ugeWih50wgT2ZxSSObi9ltp?=
 =?us-ascii?Q?58o8AO0uDbHGXulCVCn+kkZpl52W4KZu81sOs69Ya1lT4ljpYroDwmq27+mK?=
 =?us-ascii?Q?X0giwj1oRk1m2hx1Qd/EoepefKK5WKRP7FQXg62/Zd3SysL+jpUYEKPSnHFK?=
 =?us-ascii?Q?2yTlCxP/Mnq/zpKBXHkqGTyeCJ6EAeJuZVtotj6i12RQSUs8mnRCMAmx97+8?=
 =?us-ascii?Q?eEnlNk2dSGefrUKFOWe1f18sqBFSozG4sgZZrF0dYSiub5WL98W9wVdYT+cZ?=
 =?us-ascii?Q?0zMp7PFV1O5LDNwy8pq6mOy7ZWe7DssW+EkRH5OCKVdI4IsiD10KPbprAOGO?=
 =?us-ascii?Q?92vlK8PUs8FJXQFFqNF0bX32uslhhIGKEj6SvnUXTlPJiGo3l7swx+f36Oen?=
 =?us-ascii?Q?L+B07k6yNIchV8jVR4IaTedCTkiXrYqzWOg8UFF+0EZLy26zBUwJJzEgokdK?=
 =?us-ascii?Q?n+VXKI9mWPR/EBcj/xRhdoxEeIXGoeo3b9EaAG79Y3wXLQAUC8Ldg4FI2G/l?=
 =?us-ascii?Q?dcuzrvU1Do2MIATXZ+H9f48yiYkLYlaEs0mEjJRK6EwwFPGh3IJkB2dFFrcn?=
 =?us-ascii?Q?kiYMU8F8TPaCzSkDDDKa6yTUXYhe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lfn8KFSqV11jr+GcImt3il76RzJRSXwerw4dbEDbOZ117DbKwv3yGUrXoYGR?=
 =?us-ascii?Q?R5/WlMnU48S5xDuLnnSUKMGXSoweNGnX7xeqAr118EbOXErORmJmHA94XMhD?=
 =?us-ascii?Q?GT2ZJjTPM9VRaYWq+PGQoFsO4CK5Fnl2Fy4gO/54P00Qa0lW+axO7iWa/hL9?=
 =?us-ascii?Q?HGa7sVFCUwSm/yDHmsim+og0hOyXHo0PXmowJdkWOAJ9TxLX+VXl9GFYBZVW?=
 =?us-ascii?Q?sUgrFTg2b0zlB0n8oRgyjl1mA9HTS9F90iCByafoPLm7OWZBOCPufGJsp/2G?=
 =?us-ascii?Q?peIv9tRrYyKG/THnUsmgQnwot9KI43ox3UTqIHM8F3z9iQC5htma6vGWnNzn?=
 =?us-ascii?Q?aToRZOPw8d9CxQT2TPEGnTUMnsGNJTtRKZ9KcZ1e6oISfKamoTZSnv/F781m?=
 =?us-ascii?Q?hoPoe9v57S9VLvQjut9hd09WCtPnSw2eKIAYney1F6ty7+4uamEYlSILH69R?=
 =?us-ascii?Q?SSw20UwTs0TN320XNqsuvdam7omKCMqpS28qmtaxr5XF+tVPH0hBJ+6Wdifa?=
 =?us-ascii?Q?3dPc8c0ow7TNqlDxiaiGcSFaTeGPYDVPsUMi7Z/F6pz4hWeuUAEUfxQ4azvH?=
 =?us-ascii?Q?+R/3UO+22pBKytN6PAcLKlihJxc8rVYv07/snzXCEY8H7o6els1DZ1wH9tvB?=
 =?us-ascii?Q?LIcxF0NrfLD+ArM0msicLfSYNV8aiNTxnVzZekyeHQWAxJ8LNgt1ZGUV5grj?=
 =?us-ascii?Q?OICevZQK8o7f8QOJ1Z4s2uuxPxudhKMkRgRS7KxB2uEdyAWo1DPWOqXp+/MP?=
 =?us-ascii?Q?xzoP4KsF2YnjmkLLw3efRVReBKLXemSljrGnsRHNj/wd7j+kjHsJr/iwlsIo?=
 =?us-ascii?Q?nu2EW33bdOUyYsdQ8KDNbUazgT5w8+v3WeRkDS3B3OgSk0jYz8WMQRd2R6XV?=
 =?us-ascii?Q?IKSbP6fZl/vbY/M1tdXYOU8KcKrUuEsLCrYEaqXIyt5nCio+AlhbcgU0tPdE?=
 =?us-ascii?Q?qmDDceOeNxHjJHXrGuRgCjtIxlUwEMJS31Tf84wohHkPNGwu+aVzhyUeILap?=
 =?us-ascii?Q?zZG3BePFCOxsGbZTHVS3D8rrlRHA7H25dos0F3u3gtbQubHQRWr+Wi9wnpa9?=
 =?us-ascii?Q?+xSryNqQn31i2lsDXyK6HCUyg26LOLzEOtZJGvL1QQLmPe2pdCVCXIQr+8b1?=
 =?us-ascii?Q?X6+Xgh12Sz3Izu3vuNSIoq2CaQP2e+kmhllw6Nh+ZiRXRjRi1qmJM7zlRiG0?=
 =?us-ascii?Q?C0yaX0BJW53+cbj5wSZQ19m5jhZxLDUkl5MlrCtheIINW5r6JKfjl+JZ6EVy?=
 =?us-ascii?Q?DMs2zY1YSQG2B5WR8n5VqlV+af3GrkuAt0mR6L39qgvMpvgW3hceTvWPPkFG?=
 =?us-ascii?Q?X5QlYRY8pZILD7d6NLYhHmp0k9SSS/wAsi7atlAhLBouW0x4Ucw7Pb9CSBEO?=
 =?us-ascii?Q?25FGPmwTB0j+1Uo61uU3gTACiRWnquW7YLvA+XSgo1Ag8vjcmoeClK6uMk66?=
 =?us-ascii?Q?8tjrlofa5R2kO1cmRE7wf8FYQjQrYbwZnw5y1wWxxCym9rj8d7AUJt4SDqMV?=
 =?us-ascii?Q?5as8mmJXWq8hRhntSG4Y6cT95BmTfqohxPFdVh21J2Rg8AHbPQd9unePlXjJ?=
 =?us-ascii?Q?8m5KSFiQnkurGKOPkhJj2HySAPhSBBPRnI258/lX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afa03cb-0c92-493a-9f75-08dd5077a1f5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:54:50.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3TY6gyEslgopXXqtiaz5V/b3pnb3GIN2DU0SijRwcIXCOXy1ftCZ75ghZvo7Pc7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

During __filemap_add_folio(), a shadow entry is covering n slots and a
folio covers m slots with m < n is to be added.  Instead of splitting all
n slots, only the m slots covered by the folio need to be split and the
remaining n-m shadow entries can be retained with orders ranging from m to
n-1.  This method only requires

	(n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT)

new xa_nodes instead of
	(n % XA_CHUNK_SHIFT) * ((n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT))

new xa_nodes, compared to the original xas_split_alloc() + xas_split()
one.  For example, to insert an order-0 folio when an order-9 shadow entry
is present (assuming XA_CHUNK_SHIFT is 6), 1 xa_node is needed instead of
8.

xas_try_split_min_order() is introduced to reduce the number of calls to
xas_try_split() during split.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickens <hughd@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Mattew Wilcox <willy@infradead.org>
---
 include/linux/xarray.h |  7 +++++++
 lib/xarray.c           | 25 +++++++++++++++++++++++
 mm/filemap.c           | 46 +++++++++++++++++-------------------------
 3 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 9eb8c7425090..6ef3d682b189 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1557,6 +1557,7 @@ void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
 void xas_try_split(struct xa_state *xas, void *entry, unsigned int order,
 		gfp_t gfp);
+unsigned int xas_try_split_min_order(unsigned int order);
 #else
 static inline int xa_get_order(struct xarray *xa, unsigned long index)
 {
@@ -1583,6 +1584,12 @@ static inline void xas_try_split(struct xa_state *xas, void *entry,
 		unsigned int order, gfp_t gfp)
 {
 }
+
+static inline unsigned int xas_try_split_min_order(unsigned int order)
+{
+	return 0;
+}
+
 #endif
 
 /**
diff --git a/lib/xarray.c b/lib/xarray.c
index b9a63d7fbd58..e8dd80aa15db 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1133,6 +1133,28 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(xas_split);
 
+/**
+ * xas_try_split_min_order() - Minimal split order xas_try_split() can accept
+ * @order: Current entry order.
+ *
+ * xas_try_split() can split a multi-index entry to smaller than @order - 1 if
+ * no new xa_node is needed. This function provides the minimal order
+ * xas_try_split() supports.
+ *
+ * Return: the minimal order xas_try_split() supports
+ *
+ * Context: Any context.
+ *
+ */
+unsigned int xas_try_split_min_order(unsigned int order)
+{
+	if (order % XA_CHUNK_SHIFT == 0)
+		return order == 0 ? 0 : order - 1;
+
+	return order - (order % XA_CHUNK_SHIFT);
+}
+EXPORT_SYMBOL_GPL(xas_try_split_min_order);
+
 /**
  * xas_try_split() - Try to split a multi-index entry.
  * @xas: XArray operation state.
@@ -1145,6 +1167,9 @@ EXPORT_SYMBOL_GPL(xas_split);
  * be allocated, the function will use @gfp to get one. If more xa_node are
  * needed, the function gives EINVAL error.
  *
+ * NOTE: use xas_try_split_min_order() to get next split order instead of
+ * @order - 1 if you want to minmize xas_try_split() calls.
+ *
  * Context: Any context.  The caller should hold the xa_lock.
  */
 void xas_try_split(struct xa_state *xas, void *entry, unsigned int order,
diff --git a/mm/filemap.c b/mm/filemap.c
index 2b860b59a521..c6650de837d0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -857,11 +857,10 @@ EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
-	XA_STATE(xas, &mapping->i_pages, index);
-	void *alloced_shadow = NULL;
-	int alloced_order = 0;
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	bool huge;
 	long nr;
+	unsigned int forder = folio_order(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
@@ -870,7 +869,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	mapping_set_update(&xas, mapping);
 
 	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
-	xas_set_order(&xas, index, folio_order(folio));
 	huge = folio_test_hugetlb(folio);
 	nr = folio_nr_pages(folio);
 
@@ -880,7 +878,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->index = xas.xa_index;
 
 	for (;;) {
-		int order = -1, split_order = 0;
+		int order = -1;
 		void *entry, *old = NULL;
 
 		xas_lock_irq(&xas);
@@ -898,21 +896,26 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 				order = xas_get_order(&xas);
 		}
 
-		/* entry may have changed before we re-acquire the lock */
-		if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
-			xas_destroy(&xas);
-			alloced_order = 0;
-		}
-
 		if (old) {
-			if (order > 0 && order > folio_order(folio)) {
+			if (order > 0 && order > forder) {
+				unsigned int split_order = max(forder,
+						xas_try_split_min_order(order));
+
 				/* How to handle large swap entries? */
 				BUG_ON(shmem_mapping(mapping));
-				if (!alloced_order) {
-					split_order = order;
-					goto unlock;
+
+				while (order > forder) {
+					xas_set_order(&xas, index, split_order);
+					xas_try_split(&xas, old, order,
+						      GFP_NOWAIT);
+					if (xas_error(&xas))
+						goto unlock;
+					order = split_order;
+					split_order =
+						max(xas_try_split_min_order(
+							    split_order),
+						    forder);
 				}
-				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
 			if (shadowp)
@@ -936,17 +939,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
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
-- 
2.47.2


