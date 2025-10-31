Return-Path: <linux-fsdevel+bounces-66607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7281C261DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D5654FC7F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBAA2F25E7;
	Fri, 31 Oct 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CinG43IF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C92D0C9F;
	Fri, 31 Oct 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927583; cv=fail; b=AJcobfBfdoakrnvADa5ypWJRN3LTd3kfdDnkxAG2cx32mC9MbAHrA3r3mjapClvDXA3vCqG/1MubvPs/YDh8V+G/rGarfvHvB1+5/1vHgBwAxcC3WNcVQIqnsp9jFIm7+9zD42AyLinVVD1khYW1TeG+Vt8pD9YfkIF5cGVqYWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927583; c=relaxed/simple;
	bh=9c1AHAQwpuoF4KQUxi6rh13uYgLQEnLamGToA2dy6HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pJu0G0359T+/Uy7f5WvULLXeRQkTaQhLZzJo18luMcxy+E+bSh1JX388/on0agdyQmjc78jBD/QkniJVrqxippduKNdk8Ha6EsEk+vSvrWklPtuZm3R6NCRuJYZMHFnB5Uw7LyZjsD8Y0+X8JaZEufd7q5iSKLZq/rC3ok8SCDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CinG43IF; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVHut/TmPv0fmgCGw77Mq2cRy2EHTxHN6ErOJCuU1Npiq2iqFBSO8Ka1J3wwtnPvRogFdvlfhzFmMMPvpgjfkKF3sXwe8rNAb66Tn3zqjUGs88vNlgeqjpcFgiJuhc/FU9xGvcIfmLckTIZcr1T14EenljW57Bz9fXe/PHms+/c9/8DNvuR0Hd8vIaOZd5dBK+IwYF7MPDk93AI6Ha8jCJl69tRlFwICdHAQZ2h1OjYHPmWMu0/PX57b36vYeu/oPrF3TjQC+GE2tXI+CnpCI70evfnV5EuNRuPmJz6kNsvTOXqhdAmrpGdUfCXa4slHZYGe9dmrvxUJrXU+BzF/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsUR21Xqs74blq2/3WGbZWlcVKGl5jWJSVnTg/6gvBI=;
 b=mNdJO6Q/ZO2hZrNS81CBeaXmsznQUiADQJtc6GGJqM+zTSOBalSIRPq0DWTOWmkYOH+PR2jo1f703RlEVWyHs/ytdmBCaqU0utSTiquEVLboit7pDFV7sx1WIBjPC3g4k8yfzB1xfvRs7QGaSWNRLWa0NCpCQbQaKFWA4gKXNj8Hy2de6wvmO7I4hSZ3RT2YJyzHfy8t6lAOgs53MhYpz35jHGhnwST7irPmGXJsRsfvW446mlwA6Nj1UNionyrFtvZ+Q4vpLfZOD3cLugoFO1ZpXoilFEqmw2JuW4A7Y4Uu4gyP+OveCW9bvF0GFdMoHREu9cNsbwGWp4pQVNGgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsUR21Xqs74blq2/3WGbZWlcVKGl5jWJSVnTg/6gvBI=;
 b=CinG43IF+a2AcskyCsb/wODxfOfeyA5zNtAcxNj66OShGHiGkGDrconQLHAYMWacbEOG5NsxXTqw1tcAdqitcqj4TqZvQGgnLCeTTix7ku/8HPP9pIrrTCdQ4gEoDUPACWNlK6Pt5/wM0xvupOoWF05421J8aBTjPTxrsZ6uakL/hv3++vblw21bEzBAspljr26+pm7tYiq2pfhZMywGuj+OUBmW6FcPAuXzTfBU6UoCZTCRhT/zkDtMSXyx8pSvMbW/U7woVZMqcaemDjoCFxYJWPnJFa0uttxmZc3CF+0JQMP3rox+r4USkcjq2M7ZtM/VXkv2CWh6cTp7bl9dVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 16:19:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 16:19:34 +0000
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
Subject: [PATCH v5 3/3] mm/huge_memory: fix kernel-doc comments for folio_split() and related.
Date: Fri, 31 Oct 2025 12:20:01 -0400
Message-ID: <20251031162001.670503-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031162001.670503-1-ziy@nvidia.com>
References: <20251031162001.670503-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0309.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: c99a125c-e436-4178-a10c-08de18994788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M2uGGxLCo+OJwWwpRoyl9k6WMIzBSwsWRtCT4rUuMPOxNgriIa6j92jWMxz/?=
 =?us-ascii?Q?Uv4mHt6++Gobf8+ulEeHd21CzdmQaJQ9mymXmEPcrvvfzBPbJs6r+OS2QwQL?=
 =?us-ascii?Q?vGgmPprBvtjsigsz3ZGoms+qfX6WWfBszIi5epacw2nSUbNDUX735IbNGEcj?=
 =?us-ascii?Q?nEWpbFpj43UY3Qhb0qLzGwoWtz53uGbliApH79ZDT7Hi4Zl5ID/inNuTu7qh?=
 =?us-ascii?Q?UxgxhJ5x54/w8GmPiOblFNhuI+AJGTLsM3m3m3V9aRMfbEe6hWRsx0QBPZpz?=
 =?us-ascii?Q?unBnokCm8L7MWuVk6Fq7wE12Jhgn6ihwgks+rYSDFfv9ifwanlPrJy/0l46f?=
 =?us-ascii?Q?fp+P+YPNEdEj71QI3AaTidfCsZvTGKLf73r2y2VPcgoKmGVdt1BFaU1XJYLC?=
 =?us-ascii?Q?0vj6DTzjsr9DvAgG8GQx+ZLW7A5bWFDH3KemzTYZTzxsGy542WTIdKt99O5X?=
 =?us-ascii?Q?Jw4WAwgLltDxDX1rMgJNOJl1dz9ZdYjibKbtS0s4yLz54nt+ViAVkojoY9W+?=
 =?us-ascii?Q?DZW3CUFDR/cczEzflhMguHlHZzcSTBUdpO8625PHQ50UruIg93mMMEBbgT8c?=
 =?us-ascii?Q?CJu/yA40qagSEL7luX3SwTkEKUPrHdTa/UOk1NxWA49jSWRMS9NccKNBJQ1y?=
 =?us-ascii?Q?bB0MXTMShYkKeOpdD296csrm8x3maLDXgWNcLADCzX3EMmOs13P3btFlmr4+?=
 =?us-ascii?Q?2nxfqacHyTrO8nNer1x/r7s+YwAg6kFs9gTLaiWnLETf4borj52UPoLzEZmA?=
 =?us-ascii?Q?JS+uJDESAjN8sz5cwAcZRumFgkhcj2yx4W5zYO+PV8VwUcIYI4aM3GMpkQBz?=
 =?us-ascii?Q?94c8nNkGLyUvBm0fqs74qQor8C3Amu5RU75Q8vEagEpXPpZSwSuUDzxeeniz?=
 =?us-ascii?Q?QRpGH5kXj14bzyIc4L3PuF6BvA9z/Xc2MikS128Qr5rdzf+i3ZaOOaHvjD/a?=
 =?us-ascii?Q?iQGygRe+VRVOF5lOWFpho8nnliZBoXYYu3WmnBXt+iRwL+0Wqt6JbIdRjx9N?=
 =?us-ascii?Q?9dof55yqOXqRI98ibNApO/t0JuTxXRN6tyQvQ0lfDpIeDoVtxrhlGmSpV+un?=
 =?us-ascii?Q?TV7W3boHtkc2SIduh993UoZUBmlbyDqU3aCwiuYUJ/zE/2+NQKKGqcgrNpxC?=
 =?us-ascii?Q?wzWWNF2EI0DZuJVmzc1XVQfcV1+JA2rTyc5qgNOaR5GmLZi422qnnqe8Sv2l?=
 =?us-ascii?Q?xhNlaVtrMpY2mGk4vLHU6k3VM/jfQkxRExhTquAYAlljhMQdKVViwVhxyLd/?=
 =?us-ascii?Q?YUMP5rlwK6mDSScmslil1diVx9WmL/W9QfkYCRsw03VoP7luqHUS65IONgjP?=
 =?us-ascii?Q?tIlRrnXdj7K/ZPcoXPCOO28SV5fvjVPlVpVPjBKydAvuQuB7BIvPTIyJDoeF?=
 =?us-ascii?Q?WlYPoGIXWZZ2vh79tUtfK7s5EMZ5p3JsntrNwx7SJuikyMXz9Gnx1UB+Ys5x?=
 =?us-ascii?Q?AvltcH8t1xTjm1A17f6C5sGUOBx/VcIl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ANipog207TZMHJRlogoRdbv/A41RxoC/B+ZGNZAxoZIzcujGFrJ/QZpwpDpE?=
 =?us-ascii?Q?ZmquAN5GcrSp15q6O2UtoWsYDI+BCK/i5j5fd4OZNxnjV33cdl9PnpczsArI?=
 =?us-ascii?Q?ykkGY87ocrGlD3qY4L4g0oaTaawwulTgE/NoR0rNdv/NyRbe/tYLqMXJTsKN?=
 =?us-ascii?Q?pqfjaD+O2U3ujOHFSv6qvTUqLBgIvZk9rIU1H9/FHQ51lfR69r0wsYxTU/vu?=
 =?us-ascii?Q?FKKTOZ6nGiZ1v7qwHcLHxEcyKgGBHzxeHCWA+poDi34se65jE0GXUMgHJFho?=
 =?us-ascii?Q?+HThu7FIUtZAA1mlXPQwWcP0U/MumF9rLsNywyzse/ry3zYMxoK+cqQbHMgC?=
 =?us-ascii?Q?VZPnR/cArR+KedPp7AGNq7NfE6OZsiHwsgqIhyPQKwvg6GU9WHZi+hENdLXu?=
 =?us-ascii?Q?Ke58k8lz4VsQiu1AagL3L6eU3weke3qyfyL0g01vTlGPrN2zYufwq7NX/9Vz?=
 =?us-ascii?Q?rD3PpQHGk5T1icTmZ5JE/Ru0F8eipx2mtoNwQ03n2VKypevXe2AV+PmKVKpn?=
 =?us-ascii?Q?PbantEq3Lj/shXTmRItHn1jgFc/GC8Df764McvN7GSxeaUi00A/dS8noaqah?=
 =?us-ascii?Q?k1dABfnvG6zqWObo0mZxtmnd4fA7D+lpM5o+vVPsn6vXZ32Yet/T54Bn1L9F?=
 =?us-ascii?Q?lRv7/YZdfzv8Ozczdx671LyO0pyPNYg8o7rLhATd2wVc4Ii9p75wjScNjT8t?=
 =?us-ascii?Q?atZMwVIHFgAgoWSZPGr2FC+U+apPuKs/vx3Ov1U20ib4fEOUegSXgoulLjiu?=
 =?us-ascii?Q?t/qxxFAsEp45wkD/N1pNHCg2E8dBREAtqGmblGpANNlbPwN6zKguWbdRX2at?=
 =?us-ascii?Q?4wlDCUVgMF11IT3eOJYy4KXc3SSt1RhI98TJj3YBt8vAUmEpfyH5tAwqQszu?=
 =?us-ascii?Q?rlG05GiAtGsxp40PKVYSJWy9RhHXXIhri3alv4897+EBAehaB+Wi1De7xY32?=
 =?us-ascii?Q?GDb3VrBTuW85j6okJsk58m2TrEfg+vEnO5xEXLQJYGpaTaxOCs77araxjNTK?=
 =?us-ascii?Q?6UDIhaofYh7IR0K9P/HpM9x562ROvjZ3A5fPz3wRFlo+4ITKeU19W1WSjaBR?=
 =?us-ascii?Q?1fZgWIlG8DgTavclgiWbI3TGOShwK+YRiTa/K9ChvHBM6nVtAUJCB6Hwwyo0?=
 =?us-ascii?Q?b1SBt0BRZ3F536/zf6L905pyv6C3z+t/SXxc8BRDK/wTV2qQuNfZDo+4kXda?=
 =?us-ascii?Q?Jj3X7tvm8wJElmdgR4RZKQv53R3/zREeoHsEEeQPtezPbAAqVDz/u3ddo2sI?=
 =?us-ascii?Q?2Daa6aCZRDDstNiPPOPhnEoqwTaUNWaI1eD9VFvkI32wODS86rbKPg9Jw4BL?=
 =?us-ascii?Q?0Vlz4Ae3SQysaFMRL9UrUkoEb1uzv1BKpY2RJWPJS89QjBsR45lDw3M9WRZX?=
 =?us-ascii?Q?1jhYUe0gQZt7vudEnpDJcL4zuF9cIer2mHigQo8iGCbUR3ATOLmLiB3Au1sI?=
 =?us-ascii?Q?czLSHXVAsR92yBy/MFhIl+42K4fwMr7RQetM7ndIrCr9VTH4FivpijkKIMEr?=
 =?us-ascii?Q?Gx+IozzEbI+of4lTi8Yqsaj7Txc8PQKvxc9oedQJfXcwjWFCwtYAUWS5ERJO?=
 =?us-ascii?Q?GVzwFE+2I9OmVoAkzvQiYUR00PaQ9KYip62HgfI2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99a125c-e436-4178-a10c-08de18994788
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:19:34.4365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scApAZGjNUz4ZfoSkZo8SAejlAfXjgvr1/0CQ3z9Z49+QaOBhQwlrVNm/izOkChZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

try_folio_split_to_order(), folio_split, __folio_split(), and
__split_unmapped_folio() do not have correct kernel-doc comment format.
Fix them.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 10 +++++----
 mm/huge_memory.c        | 45 ++++++++++++++++++++++-------------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 34f8d8453bf3..cbb2243f8e56 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -386,9 +386,9 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
 	return split_huge_page_to_list_to_order(page, NULL, new_order);
 }
 
-/*
- * try_folio_split_to_order - try to split a @folio at @page to @new_order using
- * non uniform split.
+/**
+ * try_folio_split_to_order() - try to split a @folio at @page to @new_order
+ * using non uniform split.
  * @folio: folio to be split
  * @page: split to @new_order at the given page
  * @new_order: the target split order
@@ -398,7 +398,7 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
  * folios are put back to LRU list. Use min_order_for_split() to get the lower
  * bound of @new_order.
  *
- * Return: 0: split is successful, otherwise split failed.
+ * Return: 0 - split is successful, otherwise split failed.
  */
 static inline int try_folio_split_to_order(struct folio *folio,
 		struct page *page, unsigned int new_order)
@@ -486,6 +486,8 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 /**
  * folio_test_pmd_mappable - Can we map this folio with a PMD?
  * @folio: The folio to test
+ *
+ * Return: true - @folio can be mapped, false - @folio cannot be mapped.
  */
 static inline bool folio_test_pmd_mappable(struct folio *folio)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0e24bb7e90d0..ad2fc52651a6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3567,8 +3567,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		ClearPageCompound(&folio->page);
 }
 
-/*
- * It splits an unmapped @folio to lower order smaller folios in two ways.
+/**
+ * __split_unmapped_folio() - splits an unmapped @folio to lower order folios in
+ * two ways: uniform split or non-uniform split.
  * @folio: the to-be-split folio
  * @new_order: the smallest order of the after split folios (since buddy
  *             allocator like split generates folios with orders from @folio's
@@ -3589,22 +3590,22 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
  *    uniform_split is false.
  *
  * The high level flow for these two methods are:
- * 1. uniform split: a single __split_folio_to_order() is called to split the
- *    @folio into @new_order, then we traverse all the resulting folios one by
- *    one in PFN ascending order and perform stats, unfreeze, adding to list,
- *    and file mapping index operations.
- * 2. non-uniform split: in general, folio_order - @new_order calls to
- *    __split_folio_to_order() are made in a for loop to split the @folio
- *    to one lower order at a time. The resulting small folios are processed
- *    like what is done during the traversal in 1, except the one containing
- *    @page, which is split in next for loop.
+ * 1. uniform split: @xas is split with no expectation of failure and a single
+ *    __split_folio_to_order() is called to split the @folio into @new_order
+ *    along with stats update.
+ * 2. non-uniform split: folio_order - @new_order calls to
+ *    __split_folio_to_order() are expected to be made in a for loop to split
+ *    the @folio to one lower order at a time. The folio containing @page is
+ *    split in each iteration. @xas is split into half in each iteration and
+ *    can fail. A failed @xas split leaves split folios as is without merging
+ *    them back.
  *
  * After splitting, the caller's folio reference will be transferred to the
  * folio containing @page. The caller needs to unlock and/or free after-split
  * folios if necessary.
  *
- * For !uniform_split, when -ENOMEM is returned, the original folio might be
- * split. The caller needs to check the input folio.
+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
  */
 static int __split_unmapped_folio(struct folio *folio, int new_order,
 		struct page *split_at, struct xa_state *xas,
@@ -3722,8 +3723,8 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
 	return true;
 }
 
-/*
- * __folio_split: split a folio at @split_at to a @new_order folio
+/**
+ * __folio_split() - split a folio at @split_at to a @new_order folio
  * @folio: folio to split
  * @new_order: the order of the new folio
  * @split_at: a page within the new folio
@@ -3741,7 +3742,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
  * 1. for uniform split, @lock_at points to one of @folio's subpages;
  * 2. for buddy allocator like (non-uniform) split, @lock_at points to @folio.
  *
- * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
  * split but not to @new_order, the caller needs to check)
  */
 static int __folio_split(struct folio *folio, unsigned int new_order,
@@ -4130,14 +4131,13 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
 				unmapped);
 }
 
-/*
- * folio_split: split a folio at @split_at to a @new_order folio
+/**
+ * folio_split() - split a folio at @split_at to a @new_order folio
  * @folio: folio to split
  * @new_order: the order of the new folio
  * @split_at: a page within the new folio
- *
- * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
- * split but not to @new_order, the caller needs to check)
+ * @list: after-split folios are added to @list if not null, otherwise to LRU
+ *        list
  *
  * It has the same prerequisites and returns as
  * split_huge_page_to_list_to_order().
@@ -4151,6 +4151,9 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
  * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
  *
  * After split, folio is left locked for caller.
+ *
+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
  */
 int folio_split(struct folio *folio, unsigned int new_order,
 		struct page *split_at, struct list_head *list)
-- 
2.51.0


