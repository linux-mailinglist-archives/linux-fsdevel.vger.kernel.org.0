Return-Path: <linux-fsdevel+bounces-19860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF38CA707
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 05:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB751F217CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 03:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95671865C;
	Tue, 21 May 2024 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MQr3FTER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B111D51E;
	Tue, 21 May 2024 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716262104; cv=fail; b=ROWdj6mjyHlB5ESt6CXC59XMROJH0CDcDDD/aEAu8dSPRwi6YtrCrgmEonnONcCpikkkUcvYRTvedeFJLSIC1EHMnq8nOpGmDQtquJxMh8wiIArZAx6CV1o3inx7uegzzVpHrmottL5u6CIQsgBwlmjiS/rkEea3t2JPlGBujYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716262104; c=relaxed/simple;
	bh=e2dBL+mQOixdKHxHSTgIw8VwGHTAYPq9mze9v2FwmXU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aNdv/XmHaDnGcnuBos9tuuAPJWyePRFvU+RhB3y7pYelUXl1b3R0bUQ9UAz6LsAanGx7/Sks57/4B4IxE7Fh5oaAjGl1CVNGEQLYiuHjM9+nY9LQgCQjvYylMMd7rYsqoBXoE7/lsqewY+DAjHqaFPAef5zPlozSbtsB+6QgbTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MQr3FTER; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nijPkSngFQNVgoKCip/wvwaImX8FBtfm2lSk+q5XpBeDBBg/nJtT0ExFe4UhuWBqOndn25/ItB/gjapKYvK8GBn3l9ZGwy/Gql7vMX6WwUrxaoNLXIzAwbBzUFcR8odIArvnf+nT946AYoebKdf5v/vevjiO1ucvj0oC6xkc/3HrAuT7GSTeLOvEZRfrxNC5WaKmBIVJOLxlx6EDzp6T2Ng41l7seKqL1L+v7Q+tyQMrvvOkCf/+iG2T2q0t0gD2rxeezwuYgPoW0wQLwJpdPbL7JS5xgtsQb4hgp1W42Pd0O+XnS6D7TnwBSxPBCGJyTPG+A31aPtt4/tJAyE0u0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpBy7C2LF/T+5wMu59RClHeVqnf8zCo0un+Q8AuCxaU=;
 b=WtYJMm25M4CuGDYhVz9C0y7pqexxoMWLOhWV0xqgpXYgX6FCKeCV6VJQkXKIWV+/22oFFcdoGJV82hjivqc5VqR5Vvf5nTdLBTEHeYte7haUfAv2iuoUfzwwO2pjgPTrf7aDc5c9OHKeV4hv239gxXcH4gP0Jb11HseXEP6cVw4ZufMGYmCi9YvONC0Dfr/yt7fNDE+AOrunU/VNGjNU0iZ9INuxqMmCpSlRNeu7nfLnXAZ+zWo8n8kKUBNq2chKmBFLWyNTjqNtC+9AT9wqfnpMfqU0FJ+KpPHBrLkzjc7/Gn5+UjR1nxzNLl5Dc5XK1yXtjhQoERaTuX3oD/G3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpBy7C2LF/T+5wMu59RClHeVqnf8zCo0un+Q8AuCxaU=;
 b=MQr3FTERt+hhmosTGCOlrnF1jQDhIrAVj7j+4wSoDCz+QBcxrIHTokvuoMHuSsHSql6g5Xhnnkd18nqGn5c86pKaHnJGsh+/iEQ+xqkfIMbEolwGQUymzWsJkhIuwV9DlJT2oR0C3iSAIfGcCGPvrUyjC1d5fbkMI3hNdRSjzIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 03:28:18 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 03:28:18 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	willy@infradead.org,
	kpm@linux-foundation.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	jun.li@nxp.com
Subject: [PATCH v4 1/2] filemap: add helper mapping_max_folio_size()
Date: Tue, 21 May 2024 19:36:23 +0800
Message-Id: <20240521113624.2538951-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fb49b4-2882-485c-6407-08dc79460ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CQ5jYG8iMWR9o+4uQbMBHbj4FBT4c3ibyQKDewZ9xekaHrkbeorVBubKPt+x?=
 =?us-ascii?Q?g7bZO8Rzu7A5O0398eSba1NpJkpzsju63Tee+I7bIQhSwzqJUn7S4mamrDPI?=
 =?us-ascii?Q?8GIOD6lU+H6HqW7Dv0ZkHfUxxadhm0K8EyAw1ADmDpixIh/gd7CiUJm5GUBJ?=
 =?us-ascii?Q?1+Xq3w5KBQRFk9IDC6EiHAfzKzx8KtiZ51Oewq0Q6otdsRjxTU9nr6o7tzOK?=
 =?us-ascii?Q?aPt1mpehr4Uzqua+/Kijo+u7KntFMb5H0/Rus1fzmw1Dj+XbOOFHtk6C5Aya?=
 =?us-ascii?Q?qCj72eNuHj5ZD+MMR1NEzl0nf5W/6BoNwcclqTBg2I7R2VsQjqPn0r9NzMtT?=
 =?us-ascii?Q?mV+XSU/SHw6QQjA5dqCypq6eK97rnDdICwDDAE1u5/+Mt9Bq3Y+eN0Aq88Re?=
 =?us-ascii?Q?RKshxHmI9jTcOBzYFiD4dJvf7503DT5sjlaL2DLSFtDPGto2E3hZM7PuViOP?=
 =?us-ascii?Q?PTe8haFOH2wv8udo1a+9y2Y8A7a4cdkhpBRu2pIMcMVx8GZtdMsGHys3H3H+?=
 =?us-ascii?Q?QzjEdv656mtFDQkko1xZvpENLAi0fKQiv4u8PEp9/a82C+5YuRqkV0EzPsnn?=
 =?us-ascii?Q?eYI6ZKELlyBF7LE5ZaDJqN/UUi0MLGXWlptIuJPkVie/W9pmAPbmXq72HYzD?=
 =?us-ascii?Q?TsqEM4Mh1r9ZRzt4GMCN7FOwtZPpJu7MTKDRLzQfWNJeoMhf+N7bXPHUgr7X?=
 =?us-ascii?Q?JpOGuUW7WDmdJuiaCS9TGifDhWEQXwulChAnEsSsU94zvpKJcqwE4CeyRq2J?=
 =?us-ascii?Q?l0f5dgBtXLUDv4oEVmG/KC7HplDib5fJN2zsjWen4FlXgRAEf/EAlcLSzwlz?=
 =?us-ascii?Q?7jt/gC5p7gYSw4d2e/u4T25i8heJY2FPvlteIZ4HeGboo/YKM7FgJklJbkMA?=
 =?us-ascii?Q?prGmNFjYwZkp9M4H98BLg+GifXQMi6VCFAONN8Q8e+t1gEDZw3MsVUVW+b+0?=
 =?us-ascii?Q?L5aC0j/01lfSB5ll7kjtRl+7+WB9bLlbvuCkGoxKJlkNtSfez7SR7cDuiBt6?=
 =?us-ascii?Q?UGActt88V/PeEQgKZp1NdjHId1t3c+OhyZaa/sIg4LuRDDg0KIh5QWz9Dhe2?=
 =?us-ascii?Q?UKrcrmCsgLAKrhcTCohjbqvHBoZPG8/h58GCRx9KlwZ8kRoWloFh1h0xzmyo?=
 =?us-ascii?Q?Rla4sYx+lOxTPCvdTDjLq0QM/NUJSL0VDgOCbj0CTlCLm10Elj0Nm2rTn6l2?=
 =?us-ascii?Q?AmMweHJ7lDXZyiGm9/iL+BVqwlc2eBosVxyGzNMu8ynybYEiEjSkMGFatLoa?=
 =?us-ascii?Q?QB52/AEwERSpBNui6JjmS1TE11szSTWrxZJ8Gh3KT1n2hyyIouF2hah66dPt?=
 =?us-ascii?Q?Uq3iTd51V3FUwjdbsi+DD1Czmgd7+qpyMcKcdU26Xf+9FQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ILXP/AiSf49y27eq0OFLsww+ISEGzfXx5abrXvUEVdQ+WPmf7LjMEQlqN6yL?=
 =?us-ascii?Q?74SrxDUU8oIVpSFrV0KNVFqvm4h6RW3Np5E3i+inclCQYtq2EC5rZ+VKrOiz?=
 =?us-ascii?Q?HluuUGzMyTNrT25J/u6aZhc9jqKacCdsL701z2NGfJYwzO1m/MdC01R1wcf2?=
 =?us-ascii?Q?j8A3iW8/Lpy55rlsU8e3ZE56y09f8e3Q0QHQAUPNm61Z0r4LzAp5YH7u4QmC?=
 =?us-ascii?Q?nplWgU3EFs5ZfaUv/XvpLdyxPmRiiMXDnmKbJ+ah4pfA4Zaj2upQN9Ha3oxF?=
 =?us-ascii?Q?64dlOA4KgiGLtNyyi6Xul5M1sQoiIrTRXeBesVLoROqrjRBac+3u6qHFPEhD?=
 =?us-ascii?Q?9OYmB47CmMgOWotRPC4+Tdc4e+4ElnSRhaO6agyuuhiOhOKXM37fiotpwGCP?=
 =?us-ascii?Q?ur7J4OHJNcGoZCpZGLeTJTHzhib7oxFKuVLVPW02/NNu1kQ3h48LKDTPn9et?=
 =?us-ascii?Q?31kQMt7Yt9ybKGBUXH+rJnkGrg19oCxU35/XMAUHzrMwgDrxUIF1ygi+ti20?=
 =?us-ascii?Q?eNYY7mm9y6RX8KLcr0s/rVEaxgSatQjiYlxyeb8p4BYD1R71ziXjDMD5fbTm?=
 =?us-ascii?Q?M6JPVEDLDKOp1PXP+KcxAogMgOjP2XTflEbgdytBCARHwaQ4He1eWk5Vg5TQ?=
 =?us-ascii?Q?NHe99mYcX6kpdUUzRnqKI1r8YaJdlUHDLUJ+CAuKc0twNEAkGjp5njk0h+IP?=
 =?us-ascii?Q?Z97rjYQuckABQ94Piz8/1m5OpmGI0lILzleb6k9hAqKG8PtxQO9zTMuTO8Y6?=
 =?us-ascii?Q?KgrCyohFKUukeW5rllIQYVaPT2EcSu9OokXbJx7LEl/67BzToD0GHJoHk9Dr?=
 =?us-ascii?Q?hIUqtVsoxFQv9dgtj7mS0B4GzXcSKkaAyxQEnOX98IFwDWXJ5zaoDemmKX3k?=
 =?us-ascii?Q?pNgW0GQL/Hp7kmX2gzdKFgSZfnB0rDR7C+pIwpN12JjFK0ohXHJayV12MdOg?=
 =?us-ascii?Q?zcUpLP2d01o9LegEprg8ACkicah3CmIfGX/PMxs7pTxlvPxs8Mal3/hjvpIZ?=
 =?us-ascii?Q?sPd3v6FtjL2+nG36UBQOpseg0oECm+6ugBOemTGu2FbGrJsoILa+lRnqiPhV?=
 =?us-ascii?Q?S6lJ7RjD8CU0Yd/0lcWK3pd60w61SRjZ3fP42xXsl9/d31B2nw/dDNYxezJ+?=
 =?us-ascii?Q?gFOD1+q+Ys34yUkdCaBgzX/zSBW/FKJ1+XgG1QwPkbScPLAQ1qcLmggl+aiB?=
 =?us-ascii?Q?IPGgBTKlz0VHWL2Lx6gOK8rTJHwfcXdLknn4RrX1ewauW9S+sXVt42Dy6z7P?=
 =?us-ascii?Q?t3N+B2Lf6lb3ryj5QSG76Oz5gJFRG6mJ7InU4oxWjgHFmK7uvGJ3qxftzp2R?=
 =?us-ascii?Q?ljcI/arrh7NmCReVAkk7Rl2CNikx+IYGF0euRh1l2w/JqtI72dk7+t06cedP?=
 =?us-ascii?Q?GXJPxZBPW6/XWN9XHTYvqireoBv71m+pE4F3AW6//RqUm6FaLVtuDDucbNu3?=
 =?us-ascii?Q?GqXJXABIvymVPlSajVFta5jh+UtRe3rSx9Gjag7LL8AWWjXyULD76KPMNvpm?=
 =?us-ascii?Q?xzyy2CjW/Kx0pqmx9fYheu+oQjJgG2TJORPmDRjuMohJ9dPeO2VGTlGxU5g6?=
 =?us-ascii?Q?tu24sa5y/3K6RecSkWDZXtJvajIubAqpSVNDOnHp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fb49b4-2882-485c-6407-08dc79460ea8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 03:28:18.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc/eXfTkVaPo3+QDNkP7voklK9LySVId3XEXlowdszw7Fc3PWuM3TtKSF5aVScUC0nMttd2nHCYTvwskAIQ3Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

Add mapping_max_folio_size() to get the maximum folio size for this
pagecache mapping.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - split the mapping_max_folio_size() from v3
 - adjust mapping_max_folio_size() comment
 - add Rb tag
---
 include/linux/pagemap.h | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c5e33e2ca48a..d43cf36bb68b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -346,6 +346,19 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+/*
+ * There are some parts of the kernel which assume that PMD entries
+ * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
+ * limit the maximum allocation order to PMD size.  I'm not aware of any
+ * assumptions about maximum order if THP are disabled, but 8 seems like
+ * a good order (that's 1MB if you're using 4kB pages)
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
+#else
+#define MAX_PAGECACHE_ORDER	8
+#endif
+
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
  * @mapping: The file.
@@ -372,6 +385,14 @@ static inline bool mapping_large_folio_support(struct address_space *mapping)
 		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
+/* Return the maximum folio size for this pagecache mapping, in bytes. */
+static inline size_t mapping_max_folio_size(struct address_space *mapping)
+{
+	if (mapping_large_folio_support(mapping))
+		return PAGE_SIZE << MAX_PAGECACHE_ORDER;
+	return PAGE_SIZE;
+}
+
 static inline int filemap_nr_thps(struct address_space *mapping)
 {
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
@@ -530,19 +551,6 @@ static inline void *detach_page_private(struct page *page)
 	return folio_detach_private(page_folio(page));
 }
 
-/*
- * There are some parts of the kernel which assume that PMD entries
- * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
- * limit the maximum allocation order to PMD size.  I'm not aware of any
- * assumptions about maximum order if THP are disabled, but 8 seems like
- * a good order (that's 1MB if you're using 4kB pages)
- */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
-#else
-#define MAX_PAGECACHE_ORDER	8
-#endif
-
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
 #else
-- 
2.34.1


