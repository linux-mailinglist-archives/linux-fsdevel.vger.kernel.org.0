Return-Path: <linux-fsdevel+bounces-57500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EA5B223DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546805080FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C115A2EACED;
	Tue, 12 Aug 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KGYlETj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013034.outbound.protection.outlook.com [40.107.44.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5432EA72F;
	Tue, 12 Aug 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992684; cv=fail; b=tRCvpEO+HrRICNSnHW76g+aNAInG+VfZbBPPSV1cKuFWH66dXIfF51RQKwyBkrz98Bk9MMfjDJl6sKryvEt9+XaLYr4wGdpQfcM+n6FhQhEkABwaEqg/Au4ggYfuWyJSO2kslnvwxxtobY+ie3L7F0R72Z4imZ7YXG4u3yYxs5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992684; c=relaxed/simple;
	bh=sqCSvUStPiY0yQ0nh/UXU6WdW+6gy2uSvu+5veqyNCY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FGEnnGBBngTnTrCq5aJqX7wZ7GHwAAv1RCSiud2GuD7cjgubSvpG05jvUtb+NXntH31Xy5I9XFOWYporlKQgsZDbFf3nCb3WMyjvckY+DKrW08/vIAZ6FbUh3LEZ9K5XL9CzsKbZJ6LTj+C/N4ucJIHwOqakgSr9XErtUim1AoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KGYlETj8; arc=fail smtp.client-ip=40.107.44.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grala9j6k9i/v9BB7gK4M5P55rAMf/D7/1yDVKvDO9TsQllWHHcBLE10xaUrn7Gfh6yqGsPOcyWoAHxtPRQgyZI06RfIke6SNkscZ4I1+GrpReGxXeZDfpbmkzSGqiGsAJ09TJssLziKssDHOO9IoHowG53YT1PQHmBqac0tA+HRMuHLB8wE5zhq89LKn25O8Su1mgt/w/ApoHEYhs+36PnB1XUFm7wdsqWbgtFEYisuA/oWnfLEVND1d8h/uXvZG47BnDZi2ctPqPqkRo5TW8tqpd4/wQVkYLUNR5GvXryyO5KuDg+Fz75YgffXmeEscBCXLlwIc3+fyLYQjUWi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnxlrR0z4XAd5tFOWo8lCoD3mKz7FF3gc+Zx8eVwGfE=;
 b=nvkPNrMLFfYXEpACDOMY/gKoBucC3PckqAKabhRvcPnhXFy1Z2pnQ2xHCJD24C1qkpebQSZXWUVud4EUGvMTd4H5qge46tv5VEyGuw7vJ98DpOx1u76Bwd1NDNK5WftbmAvKGXgjU0BdTdbUbYqvkZ2bnW0coLInyRzbpObWJBb0UK0Avy3AnzJ89F5G/P8HTykmJa8AvEYQHAjocYaEDbeEbim9Zr3589UFeGWO24EuXsiwjbU4L2th7yiUoxQ8ZcygzOgBuqCRo1MjrbWn2UfOHDzO0a1xXUHBiyk4s1F9fauJiVz/eT6yOd9PWmteQgAE19iyTh5dxaqx31ektw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnxlrR0z4XAd5tFOWo8lCoD3mKz7FF3gc+Zx8eVwGfE=;
 b=KGYlETj87AfmvqrPxdq7Om3JWCpCu7a4rarOB6uc2lxaF0vaMjVEohWzQmbCpvKkLO/Sy4BwXxFscJPRZAd63xm0p0/3SBuFLHxRb1X1CUXpdGho+fhFRzbCBDckW04Jl2hw0FLn+g/R8aQyEzjRji80rceidqLHFR781t93LR5YHSAhu5Gyb0I3pT2y2NKcCCCKpF1bNPkRJTEPCxuoGeSP2UPfOWGJKguIgJ/YxmTkMuLzyki24bc7QQp02SZuzs14rT9jCqtR3eWtE8TPTIcwL6OTzaCMNIMViMlxjVMW0ja2FGwdPF3Gl8UY5egWqu0RtkdoOwm6OUUiYV+m3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5370.apcprd06.prod.outlook.com (2603:1096:400:1f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 09:57:58 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 09:57:57 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] mm: remove redundant __GFP_NOWARN
Date: Tue, 12 Aug 2025 17:57:46 +0800
Message-Id: <20250812095747.121135-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a7b570-2dbf-47fb-dcb5-08ddd986b6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VkR8Xd1vSgVjwtr8sRRoS6ZHVEjTZxSQCiqg4XkngReb3IwPFzRU4wrpvB7B?=
 =?us-ascii?Q?K/pbTC24bNUDdA2aglO9aDTsXr0cuZkxu1Zs0LKZ5/bvegXrcpqCtDMvnDvh?=
 =?us-ascii?Q?8ojC9PR9/96mNM8QEAjclkWAzCv7MCtFcLdbQNDzo9oijsO4MdTzHiIKWTuf?=
 =?us-ascii?Q?tYPBSNYs4YuwULg61rYwkpbBj+qSicSDUxwsGehLpI0jVGl3NSa3JS26vgop?=
 =?us-ascii?Q?eJm3JGwL7pxicdTeX5kuWie9nkiCh6sP4mG2mLMy5m7h/zO38Cd6ql2xF2/U?=
 =?us-ascii?Q?Quxf4Fa1TuBPmMXeExStmdYqVb0XNGbdIMiKrZvqWwl03GFrAJUv84erbz+9?=
 =?us-ascii?Q?D5Ah2QAYo7xQXkzz0BQ4xn81KjoDs36f1rFd9LD14J9tZ7BWt90UJ1TVqvWz?=
 =?us-ascii?Q?Mbni28M65C15o9X4hEPwwrVMIvBMj6glgYLH9FjL2Vupr9wN4tbWUpehdpgs?=
 =?us-ascii?Q?q4wceAfCGa9kIhPidLpsvFIwKMV8jgVTdaGRBpmQixkWSEBQHktTfwY9JRAr?=
 =?us-ascii?Q?J73VEmvh5jK32JT7jrTB6WeX1Pdj5M377nOyPen2vd4gISxq63tlRmqRU7A6?=
 =?us-ascii?Q?QHqIG9bvvc7mikhiVXvh5QjI36iYGIDq4LMOEFueyw5H+FGUGzj4jP77sGTj?=
 =?us-ascii?Q?KL6RtKV20cOfw+r3MOhgPAZn1dynydGqXcqvK4CXoNw5ggfXttKWp4GVjwOv?=
 =?us-ascii?Q?hqa5HDdOarZIOsUZb3L4Mq9P6teE2mjNOEEnGEWyjCcbd8T1vnjOQzBQzlED?=
 =?us-ascii?Q?e0wt64A39yyk1BRuzxfwwfoSW33FaS+hxsFYJO5w7tHV8bLdblmX8bVKHgG7?=
 =?us-ascii?Q?kz0/DHvGq1yi46HcjwAtWe1fVEIB85laREBCeObieFyLqAq6HkT/j18rqHbv?=
 =?us-ascii?Q?Z5cDMgdLPdajc2H5tB/PsAOc+Y9U8BDOPxtZQw/v0h6jxZsWW1Sld9cpyFAH?=
 =?us-ascii?Q?aeZLlebQjGcyVipJImVBikCqE5FqypvmOuwT7KpXsJ74IKmMuJMfYxJEpgx/?=
 =?us-ascii?Q?uCfFs4tzQbr7Y76AXZr/Ru4EQhQVhO+PHX5JtaG2cviod+FYxzN4co/CciV7?=
 =?us-ascii?Q?bcOPtNlhulqXZ7YIRf+BH8ZcSR2IEkEvwpCVZkzLI+ctW5OePZbutZklzwZ7?=
 =?us-ascii?Q?VK1/QqLQHTpxP5Zy/onCERwzucZrulDSV57XPB7mgG5NwP9zBsX0GmjCoywn?=
 =?us-ascii?Q?S11Jerv98yBddrD+uFqx6F4sr24ZyeCOJrmGR916brSBaAM+r6jvAisxB58I?=
 =?us-ascii?Q?jxnzNT9+IwPQm20uQJrZQYW6y6ZTL6Qr/qQeX1k3LAvktMWs+1lekLguOQ/+?=
 =?us-ascii?Q?9p2P0VrSWNkWKu9XVST5465ecB5aaP93ENvMQhxIA/+taOki1FRwlm4iFRqD?=
 =?us-ascii?Q?bveaoay1Q93KOFsM0BHCn6YVHc29Qfts6AbDvCDDC7LKLc5shU1HqoCBY9SD?=
 =?us-ascii?Q?XdXGTF/PV/oiDS0Limd+sjPke5t7pIuuVNDDmTt2OKC94K2sfoZ4UrLBOdTh?=
 =?us-ascii?Q?EAGLKvYEO1z+whE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uKP7SqqLYFJs1aDgkly+qD+zUdQhTqccAlGKCMe5c5OXG4NQdCc+D4bJJFyL?=
 =?us-ascii?Q?xatcW6WIKYIKw4AWsLP97VDskem0mf2ApVd4k31H1bAsfxI65LcBpqevAOps?=
 =?us-ascii?Q?MsLT7Rit1Qglk7skQ3lO0jwsSOXgjYOaBKJGyvPUOTiQ/nAQvwGUIyJxuWv9?=
 =?us-ascii?Q?6ef+NgNfVcLa7n8yOxYQteOyocAocU3i/79CAd3iyehC/wI7XfpkqYDY46UB?=
 =?us-ascii?Q?mCHX1SbiBxc2DkP4NrNQNrJQnr0SXBh27D5iW2+xydGEr2H/sBvghZJFHouv?=
 =?us-ascii?Q?5loIjzTnUT0W0fkeh0xwL2TvmEqEHZCSUrDfws9VSNu9fSmYNxkl4KicRaP0?=
 =?us-ascii?Q?boOCZpb4j5aVSf4s3wQ7gYFoXFWRLCl1D6bzpdDggwHGkGzfxqbYlEZtTvHp?=
 =?us-ascii?Q?oU7k8Der9xa9agMTu88EOiTJrFoexXxTfmKVKpsBbGSCKJ+QMgxRjbXku+0b?=
 =?us-ascii?Q?txWm4RzeN1MJELgE2kjWqZxvFPD39iHx5x4XDfqdODOz/61c5c/UzHSETsJ4?=
 =?us-ascii?Q?dj0ZYjww3Up/svOa1QSuyB+3XBoIexiO+4PMDM3VSeXM5lOqua6ZS+yTrn3Y?=
 =?us-ascii?Q?oXMJ1i84S5uAgv8XwYWsuFJO1nXB+yWhN4cP+PrZG5saP+mPdIyu1hBn/UMf?=
 =?us-ascii?Q?aOsArta6/Wif1Q1ogMWqbMm7618o2b+NQPVQi/n4vWhm/FZN1au9JZweqYk9?=
 =?us-ascii?Q?gz+y6ehdHBmOo99EzvgrdME2VKle0TId29P5BATm6dz6mHksACWPRrBtZTXY?=
 =?us-ascii?Q?a0ldKQYUXHMwv3/hsZ01ww6pHJ80c5Jg8QyhXflUb0UgMOW0rwa6H1Y9M7kV?=
 =?us-ascii?Q?cI/Xea9w471sdTMud3kV//HGwzsjQi87tEgxF8x+vP+T+w2DgHKyhCU71/mh?=
 =?us-ascii?Q?FgQ9ysexdmB4YLGFCZKhvifrFUwom3NYPlG9QJ3Y4lbHbRtqZmpHkI+loZBB?=
 =?us-ascii?Q?HzfO9bWTuK6HqFJZhL59GF3gHP6uNkZeYDTjnag+zUuHK5wsObbgOjnjr+EW?=
 =?us-ascii?Q?Wim3+BPYTPQyAmXo+h5h0i6OIJrOw8TV7K50CBBCAYALzwPQSr/4+MugKzDb?=
 =?us-ascii?Q?SLxmkPEWyxwD4iMmm2K3uwIO83XMonYvx15HvfAZqK6Rn+2z8051isdcknc2?=
 =?us-ascii?Q?QJH0+Lci7N1PtmD9vQ+Qcf/m7//kY5PhFp5tDgToRp8O7CQwMMBXv79UJlyA?=
 =?us-ascii?Q?gnvE7qlire8pxc0os14WjqNgEqs3/OEOvNWQR7AMETa+bVEphzfiD8nP3tbp?=
 =?us-ascii?Q?jnY4iJX5/piP3NaFHUCjO2rwpP+uZLeGRo0P9qRynC8oTAbLVl3kGLX5Imp7?=
 =?us-ascii?Q?E1IoqrBsT5mLzU8dE0FDwoHGHGPLIBHa+1I5572lDa0hviOO5u6K1DcvJO5v?=
 =?us-ascii?Q?4YDreRrtrLvwzxbTDvj4wwoZVY90EV6C/m3v4JLL1ge+RBjWRd8BAqqULmJn?=
 =?us-ascii?Q?YJU02k+9gLHEzTektgwHL3kGxVUxWOrocEvf6apC0G7dwTz/E5Ei8SmuxrFY?=
 =?us-ascii?Q?ujxJEgu9o1QIHxyMbdyl8fuWoOOjwMTH5eBISivPn3fA74zCPCG4MmvNtMo8?=
 =?us-ascii?Q?dvEKTo/ZAEA/k/Opn0IIgl6gsst+MawOR+V/WFQZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a7b570-2dbf-47fb-dcb5-08ddd986b6ea
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:57:57.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zucIVttpSTuGaGsNd8prVfhNFDOVSRdCPy1yRj1Q7zmqe7k+ZSsU2/yeMPfAIMpZ0wAvOO4vPuZWJFcAeztI0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5370

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
`GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 mm/filemap.c    | 2 +-
 mm/mmu_gather.c | 4 ++--
 mm/rmap.c       | 2 +-
 mm/vmalloc.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4e5c9544fee4..c21e98657e0b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1961,7 +1961,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp &= ~__GFP_FS;
 		if (fgp_flags & FGP_NOWAIT) {
 			gfp &= ~GFP_KERNEL;
-			gfp |= GFP_NOWAIT | __GFP_NOWARN;
+			gfp |= GFP_NOWAIT;
 		}
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
 			fgp_flags |= FGP_LOCK;
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index b49cc6385f1f..374aa6f021c6 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -32,7 +32,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
 		return false;
 
-	batch = (void *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+	batch = (void *)__get_free_page(GFP_NOWAIT);
 	if (!batch)
 		return false;
 
@@ -364,7 +364,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
 	struct mmu_table_batch **batch = &tlb->batch;
 
 	if (*batch == NULL) {
-		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT);
 		if (*batch == NULL) {
 			tlb_table_invalidate(tlb);
 			tlb_remove_table_one(table);
diff --git a/mm/rmap.c b/mm/rmap.c
index 568198e9efc2..7baa7385e1ce 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -285,7 +285,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma;
 
-		avc = anon_vma_chain_alloc(GFP_NOWAIT | __GFP_NOWARN);
+		avc = anon_vma_chain_alloc(GFP_NOWAIT);
 		if (unlikely(!avc)) {
 			unlock_anon_vma_root(root);
 			root = NULL;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6dbcdceecae1..90c3de1a0417 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -5177,7 +5177,7 @@ static void vmap_init_nodes(void)
 	int n = clamp_t(unsigned int, num_possible_cpus(), 1, 128);
 
 	if (n > 1) {
-		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT | __GFP_NOWARN);
+		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT);
 		if (vn) {
 			/* Node partition is 16 pages. */
 			vmap_zone_size = (1 << 4) * PAGE_SIZE;
-- 
2.34.1


