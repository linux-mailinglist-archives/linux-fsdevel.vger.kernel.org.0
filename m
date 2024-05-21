Return-Path: <linux-fsdevel+bounces-19862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340318CA71B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 05:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC512822BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 03:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1681B966;
	Tue, 21 May 2024 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hTjkG08T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980A134B1;
	Tue, 21 May 2024 03:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716262907; cv=fail; b=uGF+L9TKiHbSo0aOTlfcYeRtuIj78vI4JBWW0JDVWYHmy2Nfk7LEZ5vWuEgSBUbgmMSMS8fXzg2rUvLZYmzYk/4hFYfXyOSdobYVi+XshN7rB81Y/KgwceX/v/xnSkPvWox5VqyCS0FHpEzrM6qkI5LGTE7nwdc1PayULv1tjGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716262907; c=relaxed/simple;
	bh=qHWQxhaliVYLKKkvUo518Gf164gv80CSgF73d7w3+gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tir3UA4rNGJ+aqtpHRlQ7pW0CHpI3C+55e+Lzui4+LxDB9U86Hbod8OXDlpeWnER97p7vlC2xhlEeJyAQEhR2ibPQPumb9l8iZvEGOp5lcV6SwoMYjbjzGDJJjYSeYsVQN3lXZDWB7IMCoxcxmh6lKcGBCcEL/6NpP2rWSC5Fmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hTjkG08T; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdvauhSZ4qLgTnl32v9stb7pL+AJtxsSdHWpih2OpUzpSBNR1q9bKtRZoL0FgTuFurWdPdhu+0wQE2Ce83gw3TASMfPZCqzRLZ8H5wMfJKsupgys3OJwzorgrdQTw0gLlQaPDnglgqtc6gS/YG+ODPptVEb2IONrGrSZUOls4LfFGbqHmtQ+azWP/coOsNA8KzziI9BKuNrGOSwUgPhlpVhAyk0OL2phRcPHGcCMampZS8QRApRGL3OayYv4HA8ItqNwRBdyJjUkrgrE362sVtcEencTMdKMkHQ2qsxX9rG5UE38Dl/4zhCQ4sx6aZQm3Jir9Ap25bX08fIPLMM86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoD4U5KT5tLz3wUrOl0GKj4h7wjVLs02V9P6S9Sa7+4=;
 b=oaiV6SLZYhVumquoaFFAeyJKYTqkCT8vlMy1xpFv2wqcayxdFqYimdR7TmDdXauIfMHWdti4iboyu5Q529MiQXAxNGBpuBzKderFT6ZXMxc3h/MoCRyftWAlkgXrDvU1aGSjxCG08g0Y/a3arKvY0JQzWtVGUFx8hAaN3C0qMbXTXTKGwao6RYGuxcUET8FHyOl+BtgmQk8ONNIBLafoRkZfsV7mBITuJjbS7ukc4ipbUG7IU0jojihciRAdgasydggiQwFdl8qNIc7rxOKKqB1YBDh37dTs1pFz59ptyr7pVdgmmkQtn3RJxmBXhyr8919Xon2Wrse+LRPA7pABCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoD4U5KT5tLz3wUrOl0GKj4h7wjVLs02V9P6S9Sa7+4=;
 b=hTjkG08TVrbSsn2gORJ8zEs2nmsnuvj/6/GcvURCJj3ntTsU33WaYmAYY4TvvnVQpgwsSRXe/QY2tU+FXh4HNKSgJYMWgRdWJgcHhmeGA/cSPuqXJJciTDp2UNy8+dRvPjKPQHYwEeBvhJC5RRTWYkadKEhBRNp49QaYQC9rM98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8212.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 03:41:42 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 03:41:42 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	jun.li@nxp.com
Subject: [PATCH v5 1/2] filemap: add helper mapping_max_folio_size()
Date: Tue, 21 May 2024 19:49:38 +0800
Message-Id: <20240521114939.2541461-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM9PR04MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: ef153253-185b-4de2-7431-08dc7947ee16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?62iSDpyhjaKEEEaGGhgBQvd4WKW1jPkEyNFP4OZlw8ih6Gh4ntssEUrzer+T?=
 =?us-ascii?Q?iUBFCGUxhfwOWg/PDcApjIv5WY8uAwPZi3ZzMr41dDbbFzyWXuMBGQmQJ1fh?=
 =?us-ascii?Q?X55F5h2qS8cxlM6rs7bIEDXPAZPYdCougowmxYTgFW70N4XM4Iie9pu+RcAx?=
 =?us-ascii?Q?bw6N9JVE63RSJqBnWQG9rhAM5kDJgDUTp6jmmYMPyJ6Qp5KxHyVGFFphMtAF?=
 =?us-ascii?Q?7HbwouFz1Tr+8PTiDNcLcahq8FGcUDwwkuOfl30oJaLlQaG/uylcRFquim5X?=
 =?us-ascii?Q?wNsyIpIEEuWUB5HCtKsDEjtJXkeGhYzm4XZo8dtUvdRkKXXRcM+A2gBy6vAq?=
 =?us-ascii?Q?HZwAj8mUOZvUEvtouNbQxVbx+jldGH3MloSVnxedEeq1UTBHztIPUb9rzQGo?=
 =?us-ascii?Q?Adxkk8mwZmkXdGoe45i7dqS6WFOkbXOKMG4ZZ/f5PIVztUpfm1tziA9iTJWk?=
 =?us-ascii?Q?AmzNJQ7Aw6FSo9L2wxOmO/gm7eHX7nXZZOpGH3kc9IiHkcvp9Fej46Hlk+Mi?=
 =?us-ascii?Q?fEUllc5D82da0H/NrOsekCvMJgf03uvVtsWwHWN/aCXyZAD6vJ2Drlu1k2Hn?=
 =?us-ascii?Q?Su187MuKHyiRSYpv2TlYOQv1lWATo72PeEuAJ3ssXYwujxi7eqUaDta2YimT?=
 =?us-ascii?Q?91gzltGzl8L26zXBGSxiGfvvwqRQ6k3BkK5vbXdHVeVuCj/+IwhveHdywnEp?=
 =?us-ascii?Q?8vbLUvrIU5OqRgFvbE5+6XqqlysQa0muYLgaA4SCvWik7j9yjZ/3hf9Jbt0L?=
 =?us-ascii?Q?rdKQYZCLdqhIGnG1qmO0FOGpfaHibKNxMvK44AQskxBNhtFg+pH/BiYEw0kq?=
 =?us-ascii?Q?5LcOynTp11N4eyEj7A5VgctqECaxI7eB9KLrkV7TSsolaPMGxp10zxC/px3t?=
 =?us-ascii?Q?7mFa7EdhQtJf1PPclnR+lXZfh2Fh4xSz+hlYbStcbqWeJin8Q5/98OJMvhr8?=
 =?us-ascii?Q?bM6BlTYZzFYZBYjLFmD4u+cB7uD8UJ2bcyYnqS4G4cHJtcLzXDq9Ugw0V60j?=
 =?us-ascii?Q?pNv1KxHeRpo99djRUe8d0ZnenQADQQqKTAqrcSFuIunpFbso3yNlLi0xkhdW?=
 =?us-ascii?Q?j/jLeYZmX+qBtLjJNa4U27LGILI6PwZr9wyzCrhz2I+32LU9+pw+AozZKmZ1?=
 =?us-ascii?Q?BEqwnAv8bnt7tkORNxWH8Wf9HtAitkqcnSDKnzFqYW3HavDhAG+vuuLtZkam?=
 =?us-ascii?Q?U7Mtl5RLJ4LDPRhxc57NFhpwTATPPTTlOlh93pWaCeF1h82Y5UbRqRwOeWa+?=
 =?us-ascii?Q?U/azR7MZ48vs36B63DZXtzRxgx/y4JrgVpSwQMpwr8KfDsuKcT9sqLLkJq8x?=
 =?us-ascii?Q?zZZnRtkvDghTQ5Jk15eiFkIO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GC4fkTpFf8vjSdT+GNrHAFQ0yPBh83w7pKjQTrG9R5C+aX1fYHWrK3bBVkXQ?=
 =?us-ascii?Q?Dn3uHUoNFsuIWKr+o/fxd7pajkOk13csLIpWV3tr0mx+XEDR42nu1es6ZkGg?=
 =?us-ascii?Q?UjTkbjMaK+8dlFGJHVXoWVzzzTrArzJ8jIqPCrtqDhEtEzqiRq2xkeXASa3x?=
 =?us-ascii?Q?/v0Sf+5ATrj+TYA7kdVDDTr7nwJJNdQ3XRSMpxebTpYjQvPROJfHTfcZ3XC+?=
 =?us-ascii?Q?Cg8sX4XqiMHH3TocSv0ddVDAa/sJes6BVT/apPxETkWW1hzVCZfEJ4/zz7sA?=
 =?us-ascii?Q?yf9Fy0pXyus9YEdi7AOjAn8wbRJgYks/ArN59SV9RBgfSA4wekgYarIa67XE?=
 =?us-ascii?Q?osF2u9Fwxgn8V+XXhkn82U09bsHWC8C/BrYBoReU/aoN22gVvGzq94OIWFJM?=
 =?us-ascii?Q?RLfXFvTI7rNJEf3J2FL066aHayDwuHq0k/dlw+CZafT0YzGN6wNTNRxEsJ/k?=
 =?us-ascii?Q?G6vCyP4krGBO5n5ascPL+Jj3EhO6ArYZn1nFYyd+5JKDlmw9Lknr53tYDbzL?=
 =?us-ascii?Q?U1+T5QceDh7ifdUFFDDxuEPa7VNwDNqv0bOia149B9XNKoSIcbxrDuoTEaN+?=
 =?us-ascii?Q?6usexZkQ66xP2n+l5hPj6C64wRk7DpnOwYXVWyGGh4ryAca52MrGLKzte7S4?=
 =?us-ascii?Q?AfDEeLg0SUnTwkE/afc59sxUkxuKp4joON1D/6Qkj/QTWmr9gabJ0e/Jc2r9?=
 =?us-ascii?Q?U0MxxCf+GaEDl/KgHJeyPy2zryK2PgmhPiiWD1/pSLHNCktw49W44piu6kuO?=
 =?us-ascii?Q?2pe8xg8wQ7cFqtg77ueSUPCzRgOrw+4zQe3E8F1KRNh9V0d1aZeik8e6Xh1x?=
 =?us-ascii?Q?CMqlmDe/NhI4DpG5qKOlkpktbyz5ekVzEfMVMPhliANUgON379gyLVMOTkLv?=
 =?us-ascii?Q?Np72cyoExIJ7SjiP+0VmT5lbk1JOnbiMgDLUFCjd181jFdZ4ZLcqMWFvmpr4?=
 =?us-ascii?Q?7mACs3t0Ja2++t0+oWm1ypRu+OO4DLx+G8KGZhLBfNCKstHw7jGLOX+GJvOl?=
 =?us-ascii?Q?iFaSC0u6PaiGyBUNTXkYByEsjBtjzaD9uJ/2czI1JjkBYA+0F0Ni3iNuD/nz?=
 =?us-ascii?Q?MHS375jNAaXZrF5vnaHvPBGMogeW1eg1ipTT5Y4j2iUJj9SyjjniBWX1+/qw?=
 =?us-ascii?Q?YTJaEZTNhQWWz2g2ByVT+FMNzOY+kyhN+OjMJzCtjpAFKYe/mS4V8Yzjza4s?=
 =?us-ascii?Q?mGaGbUmKcQNWu3BwCO5tBUcGkiibWJOxWL5b8i9YeO5PFNxilJJ4cxI5mwab?=
 =?us-ascii?Q?1b6y7IRiWoI9jTWbJ4aWYqXNo3ks8HlXK/Rjl8gVaMTNzz4NH0v2AmUh3sWR?=
 =?us-ascii?Q?WnNT8t4QtyeaSZhPDB0f1MryC+h2WRksArmpltpcfsVfNJsCR1nnRdNvDneT?=
 =?us-ascii?Q?6yCUR7SHEe+zQjXXq/eR41q01bbptNlx+6gkEEMkKKPTCzpX2bF2WDtzpf93?=
 =?us-ascii?Q?M54lRDh7R7I1QWGE0OyFPO/H9eqB/qgxIbtQ6cuCt6+pKdjjBgzN50N5XoTB?=
 =?us-ascii?Q?pYJTz9kQRsHF6+gVcUWEPVCijjJzxP7ljUmjK/lP3BbN4SpYD5/wMe4h7bUu?=
 =?us-ascii?Q?diLD28vvFdeX/sAQoWYm8XdoSAardxpZSKIh/51q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef153253-185b-4de2-7431-08dc7947ee16
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 03:41:42.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xY7871XynTdTnSjQtcIG6GrB8YJHXe/SJwB6WsB1ITXO+8W7/7HvNeskIS9ULwLqnIoOphTCpwaLZ/cU8hrVEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8212

Add mapping_max_folio_size() to get the maximum folio size for this
pagecache mapping.

Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
Cc: stable@vger.kernel.org
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - split the mapping_max_folio_size() from v3
 - adjust mapping_max_folio_size() comment
 - add Rb tag
Changes in v5:
 - add fix tag and stable list
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


