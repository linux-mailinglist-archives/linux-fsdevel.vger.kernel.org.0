Return-Path: <linux-fsdevel+bounces-23486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6721192D3E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9781C2272F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ED61946B6;
	Wed, 10 Jul 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OI0LJb9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F818FDDE;
	Wed, 10 Jul 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620633; cv=fail; b=V8qLhZi3q1GIhnfZOE2NlFHfu7fBNcAWpivVQ2bJ42SCFqyEuCe+GPzLjqgDxbbmLVzDBLwoHD5oAk5825Qe/bMT/I07dbHR+4AYyC3qlvPA6Lck3q/GLrj5du9HL4dAbpQM8s0Ia/LGHTRkafT6y6cLLGiugAmr+eR6xr4MU60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620633; c=relaxed/simple;
	bh=bpqZQqWArto52MlpnYTcQzBWDpyKiEsiUB9l4DY86dU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hjj7Fw4NbF7G85vnXj5WA+ipPT9weeoaCVCRlSCAqGTcSA6SFMLdCSDlDYr3+cJksjF73Yc2R6pV+eT1Y+qhJlLx64+aRx7vK0aCelW5qpLlCbc5dZFUklcWQtTw793OKrD3yQEzQw4pVcXzFPnA4dnq2HyAfrVdEar2x022nTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OI0LJb9l; arc=fail smtp.client-ip=40.107.255.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsjEARze45uaZglGPZ62dXp6H0KFYTxveYHIjdqpba9E2w0J44qPe1mCloOoy5NnNdWvBbHLZ8dpQYGQLiTDdIK6IcCaQEZK9x1HC9yICM/MTMW5kfOS2aLd9yO1ExB3SwkKObdS2A2SkgJaO9TsprS8PTq2SeLSENK2VB2edml2AJbeZS4+PYXtweRwkVKFGfz5uD2edqZ8qfmicP3yVshfKelKuNw9Wgqm8Pe/ClFu0qYkSvaYQ9E6iQQUvRn0LioYALZZs8ivZPfD0MKX/0sMzcdFHyrGdR2nAJl78xUPs58KLmln/5/PwyhBciMYr4LeBNE2JJclOJ/k3aeYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0NvuY57QNH1vlcV06mPoVs4bwYYR229k9KLABjB1jo=;
 b=E8tB4W1EK5saeUfBYhr6nMTx310WcwccEOE0qTtarOkloja7v9slmNOOoU6fQYuscy+SKSo4akMU3FdWwFiYK7f5ehtgtycUoXLPXSTbrStFgesxvFOIoNlMtcBgz/BI3bmOLgYz7eJe/mTRM5JwuQ7EXTIKAswkF7hTfwaOXkhfDAAXjP4TSMfQLjzEmdYT3mHYMYFIi5oqtIRWoY0vGPjLu6HCUdcoFOvDZQ162yQfLdoBkXXzd/4Mblhd9qOSMGmQzQrXIKK1WqR/NZHBpo5XgHiE4mel5oP9PO+4WlqOhK968F8RI+OiRBLHsjprhxa0tPLFX4RL0jmC0tRL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0NvuY57QNH1vlcV06mPoVs4bwYYR229k9KLABjB1jo=;
 b=OI0LJb9lTJiGzXx3GkPDsLW35Zaa+Iwn2oQljB8fk4jk1zXNvKEMg9edxPGrANEscAjpyLR+G3LBHkouhB1XuwKCQOHsjvIC3eEh4oDOzwmJIkiLRpwA92NZJWK7LLwoNJNVgUtQemqayOcNH7ZQ4guS/BsaL40cHHjz22ZmRp2H/E1K/YgeuBAO0Ao58B9V130Bqa32pUpPZ1tsJ4mWo1m+iTD2jkkFkiFFULNIiwhhhCS41QnoTGCg5ZUYIEqNdfROgUQ1auJZRZYSLYlCALb2fQFhD0kDAkgiO0jA/mG9NFrt0NMo5mlgmtKKTO9Ig8dqRoTU/CJKXqwvL0gvyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB5479.apcprd06.prod.outlook.com (2603:1096:101:a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 14:10:24 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 14:10:24 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Peter Xu <peterx@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH 2/2] mm: dmabuf_direct_io: Fix memory statistics error for dmabuf allocated memory with direct_io support
Date: Wed, 10 Jul 2024 22:09:44 +0800
Message-Id: <20240710140948.25870-3-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710140948.25870-1-liulei.rjpt@vivo.com>
References: <20240710140948.25870-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB5479:EE_
X-MS-Office365-Filtering-Correlation-Id: 9def1156-fa98-4d64-daef-08dca0ea0ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NYDex2UkDosOX/q4TRhyEtvXtzYkCcCCKvA0chv3N3S6pmpJuTgI6uiuvuoT?=
 =?us-ascii?Q?h6dQ0Pu/xYF96s0NZ++5f6yrvRET661N5JcitNSbtiQ869DXR0zU8Ry9e9BX?=
 =?us-ascii?Q?ZmeBeN4+8g+8HGZuyp/T9GviuxHdcTjzP1vCTt4p+GhmFQhl59D14PteKj2h?=
 =?us-ascii?Q?28/SVwqF3CeVQsuOe1lTLtc0VYa5cT/uJMAJt5QX/C6sG7eqS1bTUhmwoa8N?=
 =?us-ascii?Q?OwsoX0H/fpAm36zUyAAyY6SFbUa6KHnQgAzqgmTyP07oUMyxQDne+leZou6I?=
 =?us-ascii?Q?z2i9XF3/PZIJwOEPABgWxOJU13xg++pTAfnnS93o/eUe1bHnVtUcxIkOr7D2?=
 =?us-ascii?Q?6VUFX7R18gCnOd1U3uXB+7bebL/23kr1jQx4WZ4l6HhoKrFO3TJM/jmVr8d5?=
 =?us-ascii?Q?kw+/NNtfsfLFbwSmF+90spoQnlIWNxgehGEwu2ZejaLFc4TrKj5iYwg6e0Jh?=
 =?us-ascii?Q?pcgwNlsEhCg18t/6ov4vawm+bBcQdAcJo+n2OJSVEn0N/SPiVm6fz1KsJSLJ?=
 =?us-ascii?Q?LMBr/5LCFWey7NWU0dWO3p01kcsYdCFPCYXppbaE+8LWhWJfn/6J8NTFgP8a?=
 =?us-ascii?Q?bL56CBRgZYW/Iiq3iyQXYUXD8mSSObTifH5aqqBLtYsIAHXvW+Q9w4Te19bc?=
 =?us-ascii?Q?e3IHVgQ/cscwDlC9QhOhuhR0kMuvI9PtUtO7oRjxzfgd6z9WwmT0iwMV4HmB?=
 =?us-ascii?Q?i30aiQEmeYeFeYKBn8OaiV+7DTjTjXz07Uz84PfPv7SrggU2T9Auq/Hjcp3+?=
 =?us-ascii?Q?fRb/ZBXy8bUcHHStFRpenYTJvlizCwwlR3qPUDYOorDcxFhSktOjA5oJ+UB/?=
 =?us-ascii?Q?tpC0wGBahZeic08Sx6pPrqWWHGN+iDSgDolqnwQXGi5S46rsDBSP17gK2b5g?=
 =?us-ascii?Q?pZNkWP58N1QRj3zZNGdx8VoPUa2UAPb96eVeVKKz1RWzjaj5QbiOHvPi49nr?=
 =?us-ascii?Q?yEbDDBcFeyg3DooxoqV94jeLqGtDrbW4jSPPHHG1i6e8IQRb0sz9W++iimZi?=
 =?us-ascii?Q?oSfcuNoe5hw1YUeRN0NATgPm2ZzkPZD+joMyQxiURde8eO3qHAP+9y5seF+T?=
 =?us-ascii?Q?7FtbOv73av1QIAO8A/QMszYWj2cQvDTQP8c76udVmrJiIPXVoQ/KRUFXabAT?=
 =?us-ascii?Q?TgJjfrV/gxxhMIL/WDvgDqwz+Y6lWQMpagWUF2n/HeL1yox+m1Mzg5Zm9okj?=
 =?us-ascii?Q?kTS0JdqyuYzhcLly2WuLkNWUBM5dd0B+NyXy2OEoijgBKugwJGp/RS0CRglo?=
 =?us-ascii?Q?p1GQ3bzRl1ai+VCOwDg2e6haNsX8ogZX1L2xdmtqN+bGNUBW5jvn3RsYQ48C?=
 =?us-ascii?Q?XDOU672VeNDNUhbtdZVCVPTX/7otx3Byo2XGbVy772HpheN553ralQ2Y40yC?=
 =?us-ascii?Q?PH3PLp25tmhP6zlA2D0O75xU++JTp1L3Hill5EKEYLN5pZ+dEvqmcbo1yQ8N?=
 =?us-ascii?Q?THih4jwLGrI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zybxAaViPyR7DjW0mIpdI2J1a3L2IPRhANjnVWKF3jPFB7ZlSoWfxUri36f1?=
 =?us-ascii?Q?S1O0F6jJsibvYz0dDp6bmUZCV7iNtj9aIj1xNvHPmMYS+0jCuDJG2JoI1wZ9?=
 =?us-ascii?Q?hYsuZEdoLXFlr8Gk3PJMj27xsS5sm5fAtDybdsaZNGdc/xlHLM9veJTbdjij?=
 =?us-ascii?Q?8JuLsnTV43VcU7J078Y6dDaSLNdeJ0eZuoCg7YbYulWY91gXCRb3bFK1UIjn?=
 =?us-ascii?Q?HXotnjOj7p2zxLPgvP5jhi4QXJt59Z2JIcZTZu+jYTlwdwTnATp7wcMNiJRw?=
 =?us-ascii?Q?hJAfofhIxBt1TihYeiCym/p+Q9UUr0hOuUHFJOU6ionYhKUi1SjTPG2cjwBB?=
 =?us-ascii?Q?A5lkHrWSLyPk5vGOY6y5yZfF+CqvRVfLRONifndttCdHDz5qkdhC5WmrtSOm?=
 =?us-ascii?Q?GE6I4tIEF5c3OIMe6dsai21KMIXt9Ccs77fjwlfcYvivpBAtecosNclmXIvE?=
 =?us-ascii?Q?txVgiyk/GYbCV8ZHl1Gu9oR/tVXXibBOQAGC0mv4wVCoJkKDxVpAN+FOogXb?=
 =?us-ascii?Q?Yl4TBgXgCiTVqdEGwHNYyDzQMEi1m4vzxKwwiUhm6Z1exy10/ndVISaaIOyV?=
 =?us-ascii?Q?2K2mtGTl8p+Y9aWdfwbG4SVDDtnmEdWP7h9N1GOFoQqdexa6tMi21nuqwiqY?=
 =?us-ascii?Q?hIbYzSl9bk/onne4DBJvgBsjAK8G/TIRwXAzB/A71sXGpniKUt/q+BQbQs/A?=
 =?us-ascii?Q?7f8oRwbJJmneWSdVMOaM9lgkjGicLlK5mMnszUgS4pI5JZBvr49niLmzOEjN?=
 =?us-ascii?Q?M0FepmC1Q/vmG0GKJZbw/4ukmWUH3cvZS6KzLe/ZbVcqrONPdgdnofJ6M/Yi?=
 =?us-ascii?Q?yJC386IVFSXDIX96VhWPEAOaVbaqlQEdglstNJEQirq8v/ed3WGNgwy3PDDn?=
 =?us-ascii?Q?SYKyGhEhght0o4I78ZsdtAqsPDoBqV4v5QABvwlfEte9BoPqhevaMmklcXJL?=
 =?us-ascii?Q?A7ZxqM+tLNf1Dbi/+NCfQ2tAmxlB0TwGW8rWwjHmdV1o5Km9vA+4AHjkH3/O?=
 =?us-ascii?Q?LjpFIrsfrrceH3OdQ1BNztCC6D0TCQCrIRDv+a76xKRnVcfLiHUj7f49n/ae?=
 =?us-ascii?Q?KIcxNQra5n4RAW+KKgG9BDWSrMMqVIBQb3/SYVjWTJUwazIvq1H+4627KOH5?=
 =?us-ascii?Q?Fg1kLZ2/m1YyqD5Zo+DZ4iaB+Z7mMktaieNDLnXeKWc4ITH1dsKx1bLSW9Uk?=
 =?us-ascii?Q?KPgpWHFMzkpWTTxRj+ytL/CATAjT1c/yW0FUipC0owSjC6DAXimAlwe1+AKr?=
 =?us-ascii?Q?t4vJOm29hCcFcjqqF3RQJ/ONfvfEp28z+BM/tsQWWmnqNJtghz/lEkiiqbLe?=
 =?us-ascii?Q?OM1bUPwydreTKeQsI/aze6GCfUJ2ET7qCid5DNXA9X+fLpHUjbwIrdkD6rTF?=
 =?us-ascii?Q?q0OCIzh31IccWswrjuYU3h7WYflYbzDkeiXGhbL6lSu5sXCbOtFdv3xuIwX0?=
 =?us-ascii?Q?ebPpWKTy2HQ4QfHltDXQ53tzmZ6ZkhJj17lFB4vSOeqZ1bIIAm8wFq06UZz8?=
 =?us-ascii?Q?rK8an7nsGrqf11R9IukX9/XOTLvxnYmMBh0BkWjpPJj8Nzo/v4f0IbNaTp2H?=
 =?us-ascii?Q?eo9WD8JKzpitdvsmtgVIrElRsYfX2Oz1BvJEG/JE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9def1156-fa98-4d64-daef-08dca0ea0ad5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:10:24.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYWVdod289ZC+lvKOI31ZQWidBybFPFT6YnVSdHgBfpjd0EoNvm3DGt8cYYBosD0UmXP6Fj7NWxfO/Dsw4Zfpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5479

The method of establishing mmap mapping for memory allocated by dmabuf
through vm_insert_page causes changes in the way dmabuf memory is
accounted for, primarily in the following three aspects:

(1) The memory usage of dmabuf is accounted for in mm->rss.

(2) /proc/self/smaps will account for the memory usage of dmabuf.

(3) Memory usage of dmabuf after mmap will be counted in Mapped in
/proc/meminfo.

By adding a VM_DMABUF_DIO_MAP flag, we address the memory accounting
issues in the three aspects mentioned above, ensuring that the memory
allocated by dmabuf with direct_io support does not undergo changes in
its memory accounting method.

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/dma-buf/heaps/system_heap.c |  2 ++
 fs/proc/task_mmu.c                  |  8 +++++++-
 include/linux/mm.h                  |  1 +
 mm/memory.c                         | 15 ++++++++++-----
 mm/rmap.c                           |  9 +++++----
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 87547791f9e1..1d6f08b1dc5b 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -200,6 +200,8 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	struct sg_page_iter piter;
 	int ret;
 
+	vm_flags_set(vma, VM_DMABUF_DIO);
+
 	for_each_sgtable_page(table, &piter, vma->vm_pgoff) {
 		struct page *page = sg_page_iter_page(&piter);
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 71e5039d940d..8070fdd4ac7b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -784,7 +784,13 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 	/* Invalid start */
 	if (start >= vma->vm_end)
 		return;
-
+	/*
+	 * The memory of DMABUF needs to be mmaped using vm_insert_page in order to
+	 * support direct_io. It will not with VM_PFNMAP flag, but it does have the
+	 * VM_DMABUF_DIO flag memory will be counted in the process's RSS.
+	 */
+	if (vma->vm_flags & VM_DMABUF_DIO)
+		return;
 	if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
 		/*
 		 * For shared or readonly shmem mappings we know that all
diff --git a/include/linux/mm.h b/include/linux/mm.h
index eb7c96d24ac0..86d23f1a9717 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -283,6 +283,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_UFFD_MISSING	0
 #endif /* CONFIG_MMU */
 #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
+#define VM_DMABUF_DIO	0x00000800	/* Memory accounting for dmabuf support direct_io */
 #define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
 
 #define VM_LOCKED	0x00002000
diff --git a/mm/memory.c b/mm/memory.c
index d10e616d7389..8b126ce0f788 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1003,7 +1003,8 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 			VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
 		} else {
 			folio_dup_file_rmap_ptes(folio, page, nr);
-			rss[mm_counter_file(folio)] += nr;
+			if (likely(!(src_vma->vm_flags & VM_DMABUF_DIO)))
+				rss[mm_counter_file(folio)] += nr;
 		}
 		if (any_writable)
 			pte = pte_mkwrite(pte, src_vma);
@@ -1031,7 +1032,8 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 		VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
 	} else {
 		folio_dup_file_rmap_pte(folio, page);
-		rss[mm_counter_file(folio)]++;
+		if (likely(!(src_vma->vm_flags & VM_DMABUF_DIO)))
+			rss[mm_counter_file(folio)]++;
 	}
 
 copy_pte:
@@ -1488,7 +1490,8 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 		}
 		if (pte_young(ptent) && likely(vma_has_recency(vma)))
 			folio_mark_accessed(folio);
-		rss[mm_counter(folio)] -= nr;
+		if (likely(!(vma->vm_flags & VM_DMABUF_DIO)))
+			rss[mm_counter(folio)] -= nr;
 	} else {
 		/* We don't need up-to-date accessed/dirty bits. */
 		clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
@@ -1997,7 +2000,8 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
 	folio_get(folio);
-	inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
+	if (likely(!(vma->vm_flags & VM_DMABUF_DIO)))
+		inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 	folio_add_file_rmap_pte(folio, page, vma);
 	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
 	return 0;
@@ -4641,7 +4645,8 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (write)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
-	add_mm_counter(vma->vm_mm, mm_counter_file(folio), HPAGE_PMD_NR);
+	if (likely(!(vma->vm_flags & VM_DMABUF_DIO)))
+		add_mm_counter(vma->vm_mm, mm_counter_file(folio), HPAGE_PMD_NR);
 	folio_add_file_rmap_pmd(folio, page, vma);
 
 	/*
diff --git a/mm/rmap.c b/mm/rmap.c
index e8fc5ecb59b2..17cab358acc1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1441,10 +1441,10 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
 	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
-	if (nr_pmdmapped)
+	if (nr_pmdmapped && !(vma->vm_flags & VM_DMABUF_DIO))
 		__mod_node_page_state(pgdat, folio_test_swapbacked(folio) ?
 			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
-	if (nr)
+	if (nr && !(vma->vm_flags & VM_DMABUF_DIO))
 		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
 
 	/* See comments in folio_add_anon_rmap_*() */
@@ -1545,7 +1545,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		/* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg */
 		if (folio_test_anon(folio))
 			__lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_pmdmapped);
-		else
+		else if (likely(!(vma->vm_flags & VM_DMABUF_DIO)))
 			__mod_node_page_state(pgdat,
 					folio_test_swapbacked(folio) ?
 					NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED,
@@ -1553,7 +1553,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	}
 	if (nr) {
 		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
-		__lruvec_stat_mod_folio(folio, idx, -nr);
+		if (likely(!(vma->vm_flags & VM_DMABUF_DIO)))
+			__lruvec_stat_mod_folio(folio, idx, -nr);
 
 		/*
 		 * Queue anon large folio for deferred split if at least one
-- 
2.34.1


