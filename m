Return-Path: <linux-fsdevel+bounces-42035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E091CA3B095
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9AF1648A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DA01B0F33;
	Wed, 19 Feb 2025 05:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BFvuKOti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1283C1BBBF4;
	Wed, 19 Feb 2025 05:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941532; cv=fail; b=aLgpdCiH49zp8Pvk9KXd4PQvDW5Fjf/nIPMfPi5kC1ZEhI+QboRfGzLfIlpeJ3rl1oPr4AMv1kdICVRnYSgAWYV6iJhr52HdOgDGUXxuRVEvsz4AVZNl1w4Uej1g3tZslRUNolPY1FS/gEkZhWmthRFDq6eSHIxnJWoa66W9i6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941532; c=relaxed/simple;
	bh=608QT2evZ5AKdkwoQrasWrD+oJVsedcSR5PqTkqVv8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lG3BSzBMIxJZF02t+Ta3ulmUnnmiT3V3K/2ipYpEvBSanrFsYiRQYFt+FcsRcnS2mZA53fXaChvHrr4wIjxBAbn3bsMfI1/4oKA3MBiswIRhean4V5cM7DnlqvPR4NKo+5fiH/imXVqPAkaqbi65F5Nr47WjFC3dwNclOT6Eb1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BFvuKOti; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qbat78+7kqns4XvkYIPJ7G0N5D4vW6OTuhPrD1HGkAwSxx7d2My0zWuM9N0rqg00yaOCU4Sok3xBeCJnSNnjvJRm3s3VVHKc7GfZ7dSdW9MUR89q0bcBs1L+rfH1ZzsbV8p3h6OmSXInIf7es4gscRRjKZkNq1MBxjxRuXHTygA5+pLooI6bfOLEnMBuSCRLyzkvh0glL7zbWL5yOVxRaePTAWMVa5m84yQwxqJZ9yPzC8gH+iiCTWh2MhKO3htKR2xY6Y7B42YSTh724bFL2gqKBj1TKhwVZ93jDVmsB6z8NNRJyZ9QkjyDtDd+afUq3WPMWXOuGWFSlctLlq2KCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewy3qHMejZflwjpE5dVdFIabDHqLfFEDCxChc8JRT4s=;
 b=utE3yar35iTJwL2vCZmIhT5ByTYvnz34wDJw+9KDb+9akmI4UrTBxT1KhOpW6rY0iPofNfERXdDTZ4eVq2SwTMq94C800elmNSwZ3iPMBnLH9rBUf4DnPsOTDK6lwGwrTTKfc+ZFatgmpzqxhl/YRXbiw0YUUgQCk/2p8G8f6fEhr9Jc+hlXUV7ebHIdxV6J+TB3Dl4+X45qQRrgK3sG2xtaBITYR5nLlninqOaRMZraf5sfxMhgxqnpYk/h3/NQ8Ayhg2RLiRr5OTPHWW8Nykp+Q5+6M2ORMybpY0teFB2fJLpTfjXzluB2oEVJkpKROEpbWaeTurV62/Hw+AmHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewy3qHMejZflwjpE5dVdFIabDHqLfFEDCxChc8JRT4s=;
 b=BFvuKOti7kTA8hzkCBhTo7wT88dncrTo1gssc0HrFbzG/BtMDYm4liFxJjBoXnGbFOJZOqAuDM2k/7DX5Wa3p8ZtI54RQFwCmUmf6T+mV7u3vCvV74ztHmCoo6xzD0sGWyYxxRuTb4TVeYEKTQPVRV2ssHsT8i8ATMc0L0w/FnuqsLCYZn5vf4Td9Iyk9UJmEnUIZt+baETABYfGvI3s6+p64GSleCEmf3JI+ibhnwBLQuOLCjICUP3XPZRQzMkVCKzHfxLocl67ga0vFK/IJZMcMCzMIHgJWti9+p0pRLpFK9FJQ24dRNh76bpQZFwasWxTaZJMauPG3d8UnQYoYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 19 Feb
 2025 05:05:28 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:05:28 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com
Subject: [PATCH RFC v2 03/12] mm/pagewalk: Skip dax pages in pagewalk
Date: Wed, 19 Feb 2025 16:04:47 +1100
Message-ID: <c9da3d2ef9fbff693fdfae0114fcff39378b8c03.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
References: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0108.ausprd01.prod.outlook.com
 (2603:10c6:10:1::24) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: f808073b-e029-4f84-44a0-08dd50a30705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eogx4Wun2ayRUYnmbM/qUgUJz6OLcy6a1Wo/UF7e8a3yxw1E9Izv5kUdcz9w?=
 =?us-ascii?Q?bRVbh+BmHV24HYzkiK1v7W0/B3Paxk3cdWEahKv06aM6rPZ4BqBl7c0A8rP9?=
 =?us-ascii?Q?KIx3q0UWeLLwzgpq86eEMpvR/I0QcquXGOULi+hnVOzNVceE51hTUlvNMsyn?=
 =?us-ascii?Q?sQ9Jmbxll5Ci+fZRwMNLwFKnfzkszg6dZALMS5oSSz2uHTMIijDVWpQVWOHw?=
 =?us-ascii?Q?fxLvLP+srk0ldGVo8edKe6712zDO9OjYhVAkzOsUBgviuy/RJHpR7DyoOQ+D?=
 =?us-ascii?Q?IlTBCYORtq9ht25BuXdbMPsYJKAKlbPOE/f4pHcDzeapQDL4hgelNU06CN44?=
 =?us-ascii?Q?QDv4EyjsS8LO80BV5Vsr4vew2ORnG7KF/sAMq9LcBOoIvhAXgi+knptzO4Lv?=
 =?us-ascii?Q?7k5Yhk8aKiOUBUcKVTYIZ5qskxnoU94gt8c5XekHJKxEh1eTdpMv9cngBp9v?=
 =?us-ascii?Q?Pd3e5w29+f7gJLN4X4FjsvpngmrTZSA8QWbhLILEMkv4D60sUonGvm3UtT7n?=
 =?us-ascii?Q?Wc8IkjcPkKm6sN7oIWs1ZN5CZiZ3SuovLE5CvZrwQnYlLrt92cVDwe6h09SY?=
 =?us-ascii?Q?S+xfZB+teDgjUDldoWJF1O6WFcRmhj67AlFLlY4t7Lu1dMCwy4cAjJfck6ZF?=
 =?us-ascii?Q?yQgvQF8f+iVEc5Rpk18zrxcWqn2nPkU/IMNfOcZxh1KSi9yCAO0Nlac8Ky5r?=
 =?us-ascii?Q?jjBAGNGJYX4tg3qeCRZyIMlD3tLnNm0lMsMbWBUraRqiF0L30iL6Cuqyw4R1?=
 =?us-ascii?Q?IDDiPO9d+Tnh2t+U3qPdzJ05XOv9FXA+WEWoW5pIxj0Fm0K1vLyUZMEnne4w?=
 =?us-ascii?Q?z8IxIlbJQOonthNfJ+cIU7J5o+BfhLNiJZj/RJ+m4s9npE1YoznGQ9aIuCIR?=
 =?us-ascii?Q?aK8cz/IECPA9TJtqKmFsakDfU2sXgWkWmh3BeVMKCE5SnfJgHVivteFUz2XF?=
 =?us-ascii?Q?qS2570VI+q3iIfPKkWGXoxBcaW4mI0Y1XLu2pKTqrBxly9JLmQKXh0719G3X?=
 =?us-ascii?Q?gWRoa4OtT8urVs80G4ZeMLaj4ZtGxLGNY+i/npX4RiE0+FREbCXdvsZu5a+g?=
 =?us-ascii?Q?YRhGOJC0GCYtnoWtDx/+el0nkdjurO70BI/ZcM09ITIIpN1u5IUYvE4nR/76?=
 =?us-ascii?Q?f6/xbwB3z7uWlMO+8iih+e57bBoOYWKEql2gb5x/y+bEMy+sbdSeaaGCg1Rk?=
 =?us-ascii?Q?iQqKPV4JH6HVuuHYJBiCoUUVcpILKHox/BsHx5PUffpG9KHY7cjI39GOXftW?=
 =?us-ascii?Q?6n2KSVwgr+Fv3LGw9wRTAOS7XEi19bDniAQJQUe4/SD5vlNzfgki7emAmhmY?=
 =?us-ascii?Q?cYGcBaZGsnZYZDge0sPOszSblgp0iSaLOeDYUESe4vp9vj5yh+FM0uxyYvWS?=
 =?us-ascii?Q?I4LscA+uwF4CtOQDoyXwAazhccOM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LH0ykDo6rjwWml5ndidyhW5I8iiYzYbR5cXrrXq0BkJF/TaAla7OzloREGkQ?=
 =?us-ascii?Q?7nejJ2I4gijQS3ofo+jJngd0YzcB96NySN7ECM/fxf9GRn2wjgzI5d0EuCmv?=
 =?us-ascii?Q?QBzMTHYJ475Bw0CjA3x6iT15nJTk9W5NBvBULkDEUeuQGg+bt9DslyFkkUkI?=
 =?us-ascii?Q?hfD87Jzey4WbpJ43nbzhBCcCQeY9Hh4IfmmGWUkr64VzRrh6QEkvaEpUAmI0?=
 =?us-ascii?Q?5xw8bofnURV1NQR86o9k55aoMgcRG/yc4bbktLHpTY1xb79Pqm6STTOoevnq?=
 =?us-ascii?Q?gJ8AzJb9AVsUu2bJs6GXA4Ikkv6/Ih/YBy/b+GeExNskgdRbjtY5m7avhIkH?=
 =?us-ascii?Q?R3AM9ddOaQD21P4QnOK53aYtFxyT7gBBPTF0BfdozlcgJm6BZDBRTIGhRr/1?=
 =?us-ascii?Q?Z7IedKMMhKWwEz6vyQ9PC0ChLdJrIkk1bYsXQyYgJf2bTf5rOD3CqhQWguqN?=
 =?us-ascii?Q?Ar16w3UF1SDPQDvCrts4o76kg0YGq29Nqvl/aoLxHdEkj1jwFVfC2M2US3EM?=
 =?us-ascii?Q?BO3515BlVfL//VwkwXK63JeC3H+pBHh0I2T0LS2kb57Sg+5osyXF9wdIX4O9?=
 =?us-ascii?Q?XhAnyP9hyFgepfXobpx++VOvlG0bje8eYeKVxmdDsr7KqQkzlUa6pgzejsz0?=
 =?us-ascii?Q?/xtH3li+vQZZHSiWANrtQaAIEx5G3HNz3PAK/dhmnCfb5wbNRmpoMDk59Jt9?=
 =?us-ascii?Q?z4Ca0w8BumKK5HJV78H82LtvLTCnHn9/YWK8Zvq9k0PieH8yzgFwnr0CU544?=
 =?us-ascii?Q?f+DobEqJUiYjsDpergb0CFj56rHadrEcMN79zlgdgb+QKqoQ7wK5H+AK58Pl?=
 =?us-ascii?Q?5bEHO7IrfBrpbKzj4stR/0XLqX/wcKKavcRjIb5fxhK+p0uTienGpiHcL9IG?=
 =?us-ascii?Q?keeunoVB30kfEXc18nqXPyOxxkflIVq6jRENIfBjp/la6TnMlVoy90JftQrY?=
 =?us-ascii?Q?+H3ctmIP/m7U/cJAU/uRC6SdegH7Y+N3PSMTVD0H/8rF0fCd3DZaGMAaaXTx?=
 =?us-ascii?Q?ud1Tq55evldjegky3W0a4Qy46lSotSYKTPrAC/nhUWKsHTx3sjK6WX9DyzXu?=
 =?us-ascii?Q?DF8CwhswGa8npXB6uvXhdRkcwVq8OqDW2TbA7xNsRJSYXTxEfvuzusk/LlTW?=
 =?us-ascii?Q?iQoW1ZBTRNe9bwCSBPnAUoe9fnRlpuA8wfG40ga0MQY6hU8hJ0usK2YPjaSh?=
 =?us-ascii?Q?3Ru+RCIuP5tBCj0CSrEBV3qi8J4+n/iVIH+hRYYAkm+Ke11HXhKEqSfbUbnA?=
 =?us-ascii?Q?YEDRQB17CIkRz3AxbqNzDpaajQ3wSZ8UBwpFrVyuKwtX4DB26KbkPTxkJ3Vi?=
 =?us-ascii?Q?sBAoYhUqBcEalFNQvxe3ewrHRqtU8rhuorzOQBbguiB3HloA/kR2lpoW3mVG?=
 =?us-ascii?Q?sgb+qcaJpeOXuTgtKmssCrhv1P7/ieX2iGTAUDwk0aCiByDybE3egPrqLctH?=
 =?us-ascii?Q?0SN9JEdFnrSum59BaTf39RAntg9RzJn6NFMbZMl8Et+IGDdWxvGTZ/S54K3w?=
 =?us-ascii?Q?EYG8PeJdS9Nd4wKtP8mzcDbitMj4vo5RllKhPXoY4ZBnkcYyh5KqKDuMEqdH?=
 =?us-ascii?Q?mWuncLEycUbWUy7PNGGEzaXqueb7gN28wbeQczlr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f808073b-e029-4f84-44a0-08dd50a30705
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:05:28.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRK6fRsvibXOn8sZEYZK9936LZgaRF9ll86ltORcEEn9mSZ9PCuyUGk6VSxhCB1pOZCnLbQyfAfRNsGAcd6BDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

Previously dax pages were skipped by the pagewalk code as pud_special() or
vm_normal_page{_pmd}() would be false for DAX pages. Now that dax pages are
refcounted normally that is no longer the case, so add explicit checks to
skip them.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/memremap.h | 11 +++++++++++
 mm/pagewalk.c            | 12 ++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 4aa1519..54e8b57 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -198,6 +198,17 @@ static inline bool folio_is_fsdax(const struct folio *folio)
 	return is_fsdax_page(&folio->page);
 }
 
+static inline bool is_devdax_page(const struct page *page)
+{
+	return is_zone_device_page(page) &&
+		page_pgmap(page)->type == MEMORY_DEVICE_GENERIC;
+}
+
+static inline bool folio_is_devdax(const struct folio *folio)
+{
+	return is_devdax_page(&folio->page);
+}
+
 #ifdef CONFIG_ZONE_DEVICE
 void zone_device_page_init(struct page *page);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e478777..0dfb9c2 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -884,6 +884,12 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
 		 */
 		page = pud_page(pud);
+
+		if (is_devdax_page(page)) {
+			spin_unlock(ptl);
+			goto not_found;
+		}
+
 		goto found;
 	}
 
@@ -911,7 +917,8 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 			goto pte_table;
 		} else if (pmd_present(pmd)) {
 			page = vm_normal_page_pmd(vma, addr, pmd);
-			if (page) {
+			if (page && !is_devdax_page(page) &&
+			    !is_fsdax_page(page)) {
 				goto found;
 			} else if ((flags & FW_ZEROPAGE) &&
 				    is_huge_zero_pmd(pmd)) {
@@ -945,7 +952,8 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 
 	if (pte_present(pte)) {
 		page = vm_normal_page(vma, addr, pte);
-		if (page)
+		if (page && !is_devdax_page(page) &&
+		    !is_fsdax_page(page))
 			goto found;
 		if ((flags & FW_ZEROPAGE) &&
 		    is_zero_pfn(pte_pfn(pte))) {
-- 
git-series 0.9.1

