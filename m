Return-Path: <linux-fsdevel+bounces-42811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BDCA48F70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EA73B91EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B7A1C3039;
	Fri, 28 Feb 2025 03:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YsXq1U5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EC71C1AB6;
	Fri, 28 Feb 2025 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713525; cv=fail; b=IAUHVs66fzgEdm0yvhw7qdRwhSA4l9U4Bo19ReWirQTRlA+WJByc5Nl+SY3hJgoA0sXG+4Yw6stxI8czXlGCv/2XqYFuDO4VPEccIBK3O3GHhorJsh9ww+Bain16wEm+fpib1eiKpwRnNOvcur/vNwbVr9MNT2SUByPqM3cW5wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713525; c=relaxed/simple;
	bh=Akwe3SZpoQA8WCNUULpZPVDip7D0DGzpCJLiMWImO60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PgG/2yAvP+9ukJdCXhcR/da+ZknCvmHzP5tp0EInyz0Z+q3cjshL1JahAD2wK68oG/9DqarOXy+nFC/srnoNE24W1HmU+E8GwiHM/I7HqNswNyJV3sgzTs+ppmOdWlYnzGxh3brYbsf30KoVFwgbU4dHOytgNETD8xnsj8m3d/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YsXq1U5i; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL78RxBMSB9HVR7UokHRj6ygos22S56LHj9bBxc7390JN9NVuUhYBE6d2vl7OVWIxjF+x36Kp/E3gCBuKlqXFQ2eKXRpPgbGpUjcRTuSVHbZeum6NcXf1tp5B1aecRRWI2PaQfVjx5uE2x0SkV5TlQwRkRyfBPrnkxmdtM+5k7mXAZuy4uAhn4R0hB9vr6v+2S2aEdbX96wwLceUQt08le+O2y5D/DH7jq8Jmxy9wYIs7qEE8ZX2lfhU8u13sGY/IkcnWY+hryMRqwn3kphDPgksmBoanx4G6zvI1TCz/sFj+ttEldmrJl/01u9Q9K9ZNXOAqVFh9xXd+sW5FmgXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6feSz4PxPdf/fn8934Sb6xeZDwz13w4MaVyMgVEG/Hg=;
 b=HHS2BVAn1p9I5N6UHuDpgHJYeFF5vquaCWQzYfxh2ZQeO0lt7IB5Xy9h1mIekCL1VYAwGsXa4eo8RCGWqWrcKkvc/norhc2tfU77QSpQ4TBMU8YLHhY8EwXZr77Dbl3raznz+8jfmQAsgDvBgBU5yOBtp4NCMspAAvWgLYjK322K73sXFsCAkdw7cWzm9wroQQD3BPo39tWBBeAEsMU0wBm/7a49FvtvNDRKNPD6Kv/5reSb+cCcmpvaEKSKi+Y/+7l+BGwIwHaPmdhkfbtJN4f58K/l5GKqyiE2F+6RFDHvR8dDJNOh4rcnuJ6t7Oq9coRx7hTPSK5Hpj92P1Wsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6feSz4PxPdf/fn8934Sb6xeZDwz13w4MaVyMgVEG/Hg=;
 b=YsXq1U5iSHuvAS89o7WFNsQTJPOrclXo10GtDQ//B8kvePEqxGKCowyYIVQ1lm1+S0NS/c94bCN34RUaL2hWHnsb86HiPpMU1sG080pqSTF0pcQz7bFgMg9XRJ5PdX8zC35PiXQnUHFCdxo7CdOrt012DrAp7ni6StfE0o+14D5Zvc0YuyEkbIplBqwAsWKnzkUPCeR4s/SMg4s318EnqPI6jOuaAWATPJEx+xO1tbVPjilv5IF80oX7Mgx0UNn+b/vxZcYBgDGwYljjKFiOBMbB+qgxr5PLVLkXKTW2GNhYQDZiut1PsifZannNdSe9mjXIz76VHXSYuM3IUn4mvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:00 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:00 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v9 08/20] fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping flag
Date: Fri, 28 Feb 2025 14:31:03 +1100
Message-ID: <c22f699202db0acee2f7039eb026e68261ce42d6.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0173.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::27) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 8715a1c5-45c1-4fd4-5a72-08dd57a875f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bzCXVS0hsyngQj0PnrM1m/gHFgrj4wNzuWfYN0Gkuf8SuBHFXPIxr7P8W5oI?=
 =?us-ascii?Q?dk+fLUI1U2419z0JYrRmQZ5qcJLJrMEQOey6HJeZZfaIxmzzyusww7BObDL7?=
 =?us-ascii?Q?cZGr422WpD/sHhzGhjYRv431PfkOkqWlD59c6l0PJ6aV/na7kdbpE75feRBW?=
 =?us-ascii?Q?jtWEOqpBRMNM0CKQXnrkdAGbyLLz6ZLjo01jKUV6GNtGmVjss8oOTM+jAbhs?=
 =?us-ascii?Q?SjJNqSfeTKwMTevlpS3a33N8zDhnpxtVNXXo04CVXwUtJ/kfyyQEFsIo/aEu?=
 =?us-ascii?Q?SDeHYWABfD7k/8VF3oQeKI2lI7rndS56dTx/lWZfO0dYxP7CizlraBzjgG8B?=
 =?us-ascii?Q?tI00OsR+gPG45PeDOxTLPbzt4RBSOpY4VVuTBOBL7G5ANyQX/Vx+aTf4Qs4N?=
 =?us-ascii?Q?Hs7y0Wxu9Jn0I0L44RsTnpJWLZ4UOnDHLePKw7xtBmZjqobD2yHYWKLcpAtK?=
 =?us-ascii?Q?Pq6jK0dhZXRxgor0WjEYfa4mTvoMtgtRNSfr6nOLqIjAb7S1HU6cc5uppLjr?=
 =?us-ascii?Q?U9zeXj4Tw/m9t8k+yZryUVtgKHKApu+/U9p5DAnjtk2tKehA/QNsquvU0t3o?=
 =?us-ascii?Q?00R2tlg9V/sl2/Vitq9IG+MHG/DzUavKt+i9rEyP5HwroUjyhWxNLzlm2vkX?=
 =?us-ascii?Q?aMpDzJ5RynoaUQhCNNJgmvRdI34hcnJXY49snmNf6wKIL4QzeLEQLrpBmV5G?=
 =?us-ascii?Q?8nOv0xEiXs8tXKYFAUOQyo+ya/UtCxWObfUP1hs0gEFHEXNj0crMRO1XQwOX?=
 =?us-ascii?Q?jdAiHdAQmI9bK9GGFr0d4HTbw+VpsCVTgQxAtltFbKiBxYs3/YMbzxKmMqAa?=
 =?us-ascii?Q?7OG6qKm0P9nyMZeSsgEomChnJ0A3pqFoIA+Tm1RlzF+VIhftqYegqfHEo4rl?=
 =?us-ascii?Q?LNGAghfT+xYJuzh9yAhR+tL6KzcOAzyv1TkRVF5fL34q9MbyIWRYU0+2Bwk1?=
 =?us-ascii?Q?PbaM/ti7sd3uyUVBlE2fVgbmKaAxNQATVHLJ+3iKPXqxvgb205RUQLnn4Vaw?=
 =?us-ascii?Q?eyvFGNm6EW3EqTO/j0xgd6gbAEzbZTPVjQTRUt0kv8gDelKEwqSdk81KD2TW?=
 =?us-ascii?Q?z4mhK5e6nsrCQKwEZ1xy8F4iQ7uaCnqsgyk5fDO83COTFNBjAee4X7DtQ8LC?=
 =?us-ascii?Q?JObSuymVfsafgPKH25Ohh4fI2JTiUNswrXkqX+dtYzKl/M6gE5blp+6oCZK1?=
 =?us-ascii?Q?g+/kZ7fL0YOwB19YCHP2tFZ1Yz+4GPzIidIl75QVNBjy3Kx6D4YjDPgxaRbz?=
 =?us-ascii?Q?Q/k/8Q14aQyEifM6fJfKGfT9uddJ6c/YF2Df+xaJsN5fgmVaKWkuAevWN7Vp?=
 =?us-ascii?Q?TgbSN6ywyu6cZpnKaVWYzSWc9pLScW+lwRAKpXpisr21clrTFI85jXJGbCZH?=
 =?us-ascii?Q?M4W6DwuabY2HQ8t32u0uyQpc2uIi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQ4aOFEzExeaPODi0/u5BPH1wRMeV1e1R4OSXYqc5r0+RNNDAUiEVQ9X/4xd?=
 =?us-ascii?Q?ZV/6gzIqOymfhQ8P0dnKMJjOR8yQJGJzu//Za4gr/c5/sMzHdp2bSXG/Jjee?=
 =?us-ascii?Q?DQ8ROUXm59W7DaGN38U86yaAIAbOLvkPJeKv41bAoyvbA1SB4+6iIXVTZcLY?=
 =?us-ascii?Q?OCAIBGHV2xKMGOweI9XIg603GpYOxG5C7OBBzxK6hkaFMa2/wWdRezlVO93n?=
 =?us-ascii?Q?FB3aUSCrlI7GLoNP2STJ7EufijAA2CSxjku85+isJMH7v9c0Ivo7kA6Yo1f7?=
 =?us-ascii?Q?U8J9rIMxewDgie4Vm/e75/8vWuJHj3/S4P14B47R7cxnhrpcviENktrW1eP3?=
 =?us-ascii?Q?yXESk1dDXd4dn5eLLtqNzF0iyQlPfd4jqyH38upSSxJVX4hbVmOwflwW/a80?=
 =?us-ascii?Q?ir3zDLAmKATD9fSFwZxMHGtIZGg5uVmIRUtkefLvl6tMyG8OroixSMfwBoso?=
 =?us-ascii?Q?+S8xL+b/cTOyn0F+LbHU4BFN2Xg/8j2bBpqM9EGiDDGeWN27rlAte98rnEBy?=
 =?us-ascii?Q?8i2PznoXTq/JPYvc8XU4hDq3wmPsQYFHD0qh38GHJ3sX4+hKJg2vyw6MbhbJ?=
 =?us-ascii?Q?it7NId/KB8qyiSWCucLyfyr7Md0a/rGP9e2j6S+lupJjR3Q32xrhjCaY0I5r?=
 =?us-ascii?Q?AnRXKh0Imt3eLTgPEtZAt9FgQUoGTf0Jk2CkYte1i9s1YxuN/DjCgVT86tEm?=
 =?us-ascii?Q?Zrj361mAbW6qktQJLX4eYZEqw2bTYowRt4ubjYMNAjNc6W3gM9NkttMYQw0+?=
 =?us-ascii?Q?zgr46ZwTlqrdpPQA7CSJwWpIllKucwjkWdcNS/+NwG01pFJC8ZDv5UnjgfhY?=
 =?us-ascii?Q?yf7noANzQA0T4UHQuhXbL1hbQhbGEUrvpRYAr5b6+1O4xKXYvY+z0RECTYAF?=
 =?us-ascii?Q?yy4fsJURFJIA+Z21b0Gsefi6ozvpgSVXUVM+0MuMwqsIteqjRstg166kXAOc?=
 =?us-ascii?Q?TAWnCTclKjr/AqPEZy8qAg0KbGIlVQJpJ0DFnmiSUGZf/Lp6VeRfrFBpyN3p?=
 =?us-ascii?Q?OqIc+45+LXR6QYgnW5cCkKeJXTqO+kNzvP5UPLSBl6azu1+UyxQJD8gdhQD5?=
 =?us-ascii?Q?Y1uxVbIQzMyqI+UqfbqImDSk4X02MNofvs1Gp4i0zO0UUdr8VhKF9MCZ5vh1?=
 =?us-ascii?Q?7lSKDZF5jpU0QB40te+aBxj2qCxzf5vyWjQpYKu6axuQHGVvkKnlkT1TkdqI?=
 =?us-ascii?Q?dYopZyV4XmfliIeS96NlEWKt3jCa6bOnVeeEJ9Z/a1qE8ybhxShRFS/MsCzj?=
 =?us-ascii?Q?X1ykIIgdY1P/ATuFWhPVPCGFj5t5Ek1eWGg8i8h36XHhzkLgOT8yTPWv/8R9?=
 =?us-ascii?Q?fGPbatb0ghbjyHH1uSftPf4DxR3qMYGbXnVmIM4DjoFVtR6WDjZdCpiw9dnx?=
 =?us-ascii?Q?svijZcbJZ9uLVQqqgaImgR4E5jiVRooS1TjSpAkeE6EC+tKiJtyJOTAMJIlN?=
 =?us-ascii?Q?yyeZctShpdW+jDqaqtk6s0UDVbAr6dFiOhNGyjQ3MXQSuIiaVg29HIe0ra08?=
 =?us-ascii?Q?Nne9C02D8E6Me/Kmu2CBHKcAcvdaC/yLwqH5MqOLuBLzWcFV2M461sx13DEJ?=
 =?us-ascii?Q?7pCRlpr9vIeubtvWeo8jF0Z/422L1W0eA0fIQ8tx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8715a1c5-45c1-4fd4-5a72-08dd57a875f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:00.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6aRYN0ndN8eprhNjHtU61ubW/m6kMQ5hinO6nlYCm8dbU04jsTQRd3XcNlQGqhgsrp5+XUtsRQn3a0uLFIzeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

The page ->mapping pointer can have magic values like
PAGE_MAPPING_DAX_SHARED and PAGE_MAPPING_ANON for page owner specific
usage. Currently PAGE_MAPPING_DAX_SHARED and PAGE_MAPPING_ANON alias to the
same value. This isn't a problem because FS DAX pages are never seen by the
anonymous mapping code and vice versa.

However a future change will make FS DAX pages more like normal pages, so
folio_test_anon() must not return true for a FS DAX page.

We could explicitly test for a FS DAX page in folio_test_anon(),
etc. however the PAGE_MAPPING_DAX_SHARED flag isn't actually
needed. Instead we can use the page->mapping field to implicitly track the
first mapping of a page. If page->mapping is non-NULL it implies the page
is associated with a single mapping at page->index. If the page is
associated with a second mapping clear page->mapping and set page->share to
1.

This is possible because a shared mapping implies the file-system
implements dax_holder_operations which makes the ->mapping and ->index,
which is a union with ->share, unused.

The page is considered shared when page->mapping == NULL and
page->share > 0 or page->mapping != NULL, implying it is present in at
least one address space. This also makes it easier for a future change to
detect when a page is first mapped into an address space which requires
special handling.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v8:

 - Rebased on mm-unstable which includes Matthew Wilcox's "dax: use
   folios more widely within DAX"

Changes for v7:

 - Fix for checking when creating a shared mapping in dax_associate_entry.
 - Remove dax_page_share_get().
 - Add dax_page_make_shared().
---
 fs/dax.c                   | 55 +++++++++++++++++++++++----------------
 include/linux/page-flags.h |  6 +----
 2 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index bc538ba..6674540 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -351,27 +351,40 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
+/*
+ * A DAX folio is considered shared if it has no mapping set and ->share (which
+ * shares the ->index field) is non-zero. Note this may return false even if the
+ * page is shared between multiple files but has not yet actually been mapped
+ * into multiple address spaces.
+ */
 static inline bool dax_folio_is_shared(struct folio *folio)
 {
-	return folio->mapping == PAGE_MAPPING_DAX_SHARED;
+	return !folio->mapping && folio->page.share;
 }
 
 /*
- * Set the folio->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
- * refcount.
+ * When it is called by dax_insert_entry(), the shared flag will indicate
+ * whether this entry is shared by multiple files. If the page has not
+ * previously been associated with any mappings the ->mapping and ->index
+ * fields will be set. If it has already been associated with a mapping
+ * the mapping will be cleared and the share count set. It's then up to
+ * reverse map users like memory_failure() to call back into the filesystem to
+ * recover ->mapping and ->index information. For example by implementing
+ * dax_holder_operations.
  */
-static inline void dax_folio_share_get(struct folio *folio)
+static void dax_folio_make_shared(struct folio *folio)
 {
-	if (folio->mapping != PAGE_MAPPING_DAX_SHARED) {
-		/*
-		 * Reset the index if the page was already mapped
-		 * regularly before.
-		 */
-		if (folio->mapping)
-			folio->page.share = 1;
-		folio->mapping = PAGE_MAPPING_DAX_SHARED;
-	}
-	folio->page.share++;
+	/*
+	 * folio is not currently shared so mark it as shared by clearing
+	 * folio->mapping.
+	 */
+	folio->mapping = NULL;
+
+	/*
+	 * folio has previously been mapped into one address space so set the
+	 * share count.
+	 */
+	folio->page.share = 1;
 }
 
 static inline unsigned long dax_folio_share_put(struct folio *folio)
@@ -379,12 +392,6 @@ static inline unsigned long dax_folio_share_put(struct folio *folio)
 	return --folio->page.share;
 }
 
-/*
- * When it is called in dax_insert_entry(), the shared flag will indicate
- * that whether this entry is shared by multiple files.  If so, set
- * the folio->mapping PAGE_MAPPING_DAX_SHARED, and use page->share
- * as refcount.
- */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
 		struct vm_area_struct *vma, unsigned long address, bool shared)
 {
@@ -398,8 +405,12 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct folio *folio = pfn_folio(pfn);
 
-		if (shared) {
-			dax_folio_share_get(folio);
+		if (shared && (folio->mapping || folio->page.share)) {
+			if (folio->mapping)
+				dax_folio_make_shared(folio);
+
+			WARN_ON_ONCE(!folio->page.share);
+			folio->page.share++;
 		} else {
 			WARN_ON_ONCE(folio->mapping);
 			folio->mapping = mapping;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 3f6a64f..30fe3eb 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -710,12 +710,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 
-/*
- * Different with flags above, this flag is used only for fsdax mode.  It
- * indicates that this page->mapping is now under reflink case.
- */
-#define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
-
 static __always_inline bool folio_mapping_flags(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
-- 
git-series 0.9.1

