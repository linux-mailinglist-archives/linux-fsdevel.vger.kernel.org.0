Return-Path: <linux-fsdevel+bounces-37582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D19F4238
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04CE16319F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBA31DC745;
	Tue, 17 Dec 2024 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iu6rqgx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1860159209;
	Tue, 17 Dec 2024 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412462; cv=fail; b=l7WBEKBxagDKSo5iWzFi3XGdLrkWGvUm3rOKW72lIXiyjwBP2i/CIoaMtQopVvd70U5E5Cqzp/a2g30MGSCA7pprlvLp0aapQZsjzEfdUYKth7bAEVf4gdF//yhvnHZNEwiweGeR525JnTQyTmUGlNnpjHqEfJEp5SfiWO/TJDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412462; c=relaxed/simple;
	bh=gOr+LtZ2BWl97cf/723vrNY2Bc5lZNdEix/RTY98ThY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RiE/3MUf+96RC/2KoSRCG6Xlm+Q/JTA/8VBR1KnT0WsJ5K458J5VD8axgeuTFlQio/swJKGfce432QO9cSipDF+xYSA4sdigtyYp+74cj9OByCszwhYn/K8XvMO7IOt22VdFz2Sf5rslTvhg2656MJQ2sTSGnxiKnaNKpkyMRBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iu6rqgx0; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvQ75chR9Rs6DnDcP5+YmUI+aoYwZCgFXUYdjL+2iNV8F8vjUchkjwia1nmFWKkYbCAgHEkqvnS1uTl4aOtD2C9qIW1TkMYP6Y8mioyhxvWajNq/ErjlvG99/okH1t4pTFEYx9xd5OzH2HOtqiCV0VkE1nLPY1uJYSOi5GTLTIDdG9vFqDo3orIi3B7/R1WzLYUnm3YxDJiPisQyiq95kdGs9wla6wq48mXbSiLGhBOWkSmLCaagcq29FoQXfzjC7jeR5MMm55ZtK0CG9Bo3i7UQdJbJ51C60Yk3/M5179maVlQu4TR0HRCKuQm1P8gSQveRkmjeCWOtTmtQaEFkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOElRdwa5q60T2DYAegK6z/BML32Imghect7PnnZP/4=;
 b=j5xqqOHgG6FHt6yLElfPrqJ5w8s7ZeUEF82FIMHYVoDKVSeFo8NfQaetENkjkYqydLJ+d6Y7WOKNZkbcnCm8rsKrx0Ac9/KZsdR0DCzGAYlLFVtiWlho+eI+uS0k576POO+3jTM//cR5LJjpyBPgGR3pQNIxV8vkp8hNXPtQfNXg22uzLQP1aiWvhXZRttqlRtAz4ktcoSFtCtalwLik3Njbjx8f5qqhX1XbkNmK+EZE8093R0xxFLBp5RNUZzmxeg0s8E5pY0XBrUCNznnDgCrbWTwjndf58Sde7VIevyTL0+4Laj97chmw9FdFZnsz88y79cVhOteVZoNHx5tLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOElRdwa5q60T2DYAegK6z/BML32Imghect7PnnZP/4=;
 b=iu6rqgx0gtCMuSehxVPgZmkYXrwM9N8WPsGAKU2zfe90nxAvzvTFyUtYqhvZKIuSMJ9i9+lRcHzWtMJeQin8y9FKzMQ61jMay/FPCdum0yd0xQqc/Pe59z9VU71mAwbKJnYJSEzBDjcXBskeNVcIuJaGYNePP+TSfyokTm8BUdRGF82IA91Dmh1Tu68mCTE8nsY15Kx0YlgWM+GVsJbDJ19kBhjJeqbScW1ccm/3RJEhhUzMJh803pkEwD1Mer1S4h1eytoPaHvptu4tmr19nGY6LhY5AQ5kBEJR1AvoRs0xUrppYOVk6EGxU//r8Htox74RXJCeazAGMpCQWuWCJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:14:16 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:14:16 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	david@fromorbit.com
Subject: [PATCH v4 08/25] fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping flag
Date: Tue, 17 Dec 2024 16:12:51 +1100
Message-ID: <0aabbc2d9fe4d136d5a7458c4fa55e4b139a0b5e.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0019.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 04de6dc2-e910-4119-7f7f-08dd1e59a75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5yu4rWVKZhoBQm9DHXKG9uR4mYRWXvVeO0qKBKrbHBjUPxjWbNGB3cOM1iTe?=
 =?us-ascii?Q?DXsPZ9Te6W/oI5jutK+jeUnmYvBp2xF/MpsjFfkjqeVsVAnWPW3MtHenR/h9?=
 =?us-ascii?Q?S6w9Fu6toUDHd4Ck178YnaU/HZERAvQ0rVqjNpq4F68DUY9gsZ/XbrHt7KY4?=
 =?us-ascii?Q?lS2FDgWa2/r/gDSYbnmubPl/x8q//ykAYQXcO8arZtwirlzC4hsLL5pIkKqo?=
 =?us-ascii?Q?1jLIkjLmZ1oy0ZTKRWqUbiGXQ6fSQwKgR7Ct8zeyPwT0rVqDxy6y+IKFZwM1?=
 =?us-ascii?Q?2fd12N0U+paqkLJ9PuJJ5Ko2b15g7Kl7omiFiRAzksRU6Offz/Vvgn/xalFy?=
 =?us-ascii?Q?5sx7TNSgL4ckRO6Nh8/4PuMJCQShrsoAqpuyLxWWB8mfkSVp7bgY6cS/1ZJ0?=
 =?us-ascii?Q?3iWmGy7D/X7278Xevy0jR+w4eIONPdQVeS7lcWHNyzzQgGd/bHQ9TE66MHlQ?=
 =?us-ascii?Q?SWVkr0ufg53Ec63teQbDRArxU/mXrQ+wTEPmp54RxN5m12gu9p5HyiMyBzwv?=
 =?us-ascii?Q?ryXTtSYiLlTNpzhjHH7lHbCin192x1vNZWvlFcPyOhh/flo2f8GvesT17j2S?=
 =?us-ascii?Q?A42qu+pzJGWEjMfAGyd36OZ5vXsurun5STW2XV8g9phn69sKb2X6Hrjn1QAC?=
 =?us-ascii?Q?KsXqub4jloIAr/K2yT7it0IwGCdZGXlOfryZQmeGMCeZB6SJCgWNpEXLVLy/?=
 =?us-ascii?Q?Y4xE4K2cIlHT2sJ0C2w3ocmEdg6UOihUieDm1h+xMSA/6BObVBb4fqQ6I2m5?=
 =?us-ascii?Q?ruxgo9U79QcczsRxYRM9qw5kql9nys9dSgzcyWf/zgDbulgXyt8zbwl3Au5P?=
 =?us-ascii?Q?gfH43qJAZ7yUJUPHrzB0oZgpbQqwEy+z61b2hUS1i3rKOGzYnD/4qeV9BQ3l?=
 =?us-ascii?Q?jvVtooyBiaHVo8I3R8mqPY1RJy5KudjKDnZ103nxKP/qz+JAILW8o+hVLfQX?=
 =?us-ascii?Q?gMQPeo5iJF57ZQevAkWcm8GHcPrMWXwPFay5ShD+9NC7sz3tmKXd7apc3Xt9?=
 =?us-ascii?Q?5FnU8dEVNzdmXAtrQI38PEhRO0cra711FI438Jbp7UtPC/Bp/mAgA7laZ78k?=
 =?us-ascii?Q?9pzGfVaW8f2xaSNJ/7ujNJ17EzWjeFjN/X8sFKLkjzKKWBtgzE4e7kKYK4YX?=
 =?us-ascii?Q?8KyLWjxs7hn9sTuWczCob5bOK/YFg0sLbgGkbZtaWb0dRoiNIYEfPqkTAX/u?=
 =?us-ascii?Q?zJpGWuMUrOjurrkDUFP0oHyGuyhec6u1dN6RDkAx/Rv02rWPqXCkwOyByQZ8?=
 =?us-ascii?Q?zttldatFmsH5n3uC1NSy/yYIZ5JXvHMLDUU5dH00cowgqEvj1WR2dEUW8eCy?=
 =?us-ascii?Q?dVRQ5A8oYNKajWVnpLizH/EHOO00nucEr3M8wSNQh95WGvo1ygJy7YNoLZJr?=
 =?us-ascii?Q?MPgTygtKwIktyGGZ5TogX2DrI0RT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ovB069yZ1yX7XZxqJLwWSAKK7KqjDf5q61p56robh59VKk1U3mULgyU0eUiv?=
 =?us-ascii?Q?yZ3LieZ2IOIXIi1D511r2t5PLJCkOH4RsjmpkkMiVoPrQPYc3tCtyzU3LIcQ?=
 =?us-ascii?Q?hzpKPYkmhnHWnUDhAgFaoAfMfJqwc2zfn15C1k4h1gcVmqDa1O4ZUnugKVDP?=
 =?us-ascii?Q?8OJvDjebCoDmiM/Nzi9u4bETWR845hdYLfbri9zpL4lrt4VAqJD438zqMj/T?=
 =?us-ascii?Q?+MxQKvUPbXGhbgK4haYPseuq9reeT6fO8c5mhAjigVl4Fo6x6lds4u/b+IQz?=
 =?us-ascii?Q?fGrNtVkVTaPeokB9xs/x1Le8o+3aVB+dI/7RMW1lMiokwYVCpGsan0PGDOR1?=
 =?us-ascii?Q?sMeEgMkzbtmDkNjpXaL/NiSNrMkTO880cIFopcbMdL1jbfTvy8I7/FHoIfig?=
 =?us-ascii?Q?9273/AFAOCsPCQuGZopjJMDIYniql61uSUSUJLrit5LOPc/5OMkVybH1PjLY?=
 =?us-ascii?Q?RVJZrdNHgK30WNWOq57LEtuj9z2ECSCEyy/849WFFYv1zUkkTzbZR8WF+IUN?=
 =?us-ascii?Q?bwVzB0OrfmdvaaaYbHxdwHAZxFkIg5PBXkBWRhL7j8rWXidPa91UdZFyIxiS?=
 =?us-ascii?Q?6yD5Am1yAXRi+XDQvAar29Q/7m3rReKCVn4u55Mir50toPelDMYK3Su+G4xP?=
 =?us-ascii?Q?+kT1Y6Hf7n4rKxx/q3RnfS3BTmYt/5JrDqOGq+3aDe/O7Iee2tb73Eq//0Q6?=
 =?us-ascii?Q?cgfUC4wbPIqsMIoGtv86r15XNG04GKqRnFF0VsyzNeZi6vlW80Zmw77vxTwL?=
 =?us-ascii?Q?KaApga//9BDrwp9pad1oB3b9dOz0lfFbi5IjmUnA/5Ny5wR78y8MQu2uBgol?=
 =?us-ascii?Q?QmaKAlkYrGGLL58KlyGr4GQ+pHlaWxlAt/pu/rjzKlRgHr1XnNlcoH2YCri6?=
 =?us-ascii?Q?4zhZU9Vb3oYo6XnAljazcYVyjjCX6/+xH2C3pu6nDeNwxN1W1oYPtTqP1pqK?=
 =?us-ascii?Q?L8JNxkijqZGBtJHoyoqGPYy85NDil6p0DOlkMDCZd98L4zC4BZKNQrOZz9VT?=
 =?us-ascii?Q?aSYbBQXJZCUGfiAtqcCyrp9B4QJ5RfTm2faIexwU4yJY7tQBf04kkuZDWZ9s?=
 =?us-ascii?Q?PhNoArc/ihjXEdy0TW+Z5ef6Ibs/Ybtrl5y88ztDbJIO3SvICfaZoHgXWtML?=
 =?us-ascii?Q?Y79VlUrkziItpBJHImg95X+cWf/4PKc/oHOogs9OZvrk1MgxHWpDYZIpj0+y?=
 =?us-ascii?Q?Vw0lvi6SmuoVH5kcZyBM7uE9b3WJc5oflkBWWTDTXCTAmckZNTeAKX60eEKN?=
 =?us-ascii?Q?HUNe0VTX2uN7R3mnE7hLyJ4e2/VeBni9swxFlsvYCvdgzppzrVLN7VZuystJ?=
 =?us-ascii?Q?uaciQmPN7BOvu9EaV09BBRAyV/6ytulGxqIT4OHStCRn8jyiR4fLKWQaNsXN?=
 =?us-ascii?Q?1ekrfsCkAGfUPi6lkd57uddJ8FciOf7vOm8JMHK6m7t/KCNcAtny+H/rx/Ha?=
 =?us-ascii?Q?VpZUCvq+BhQJ4jGU01OHE0cP5BK0bqH39VsptvO/Wah0HXjNczL7bz0u+nYx?=
 =?us-ascii?Q?k9YSLpWCqq1ps4AsJjqtr2Lx7yyrEaAWWKKp1n/rSKCgQ2IQbPxFVZRWcWKE?=
 =?us-ascii?Q?XqaE3oQNHDrYrAE1vZUxM6ZHp33K3SfuSxOsEulK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04de6dc2-e910-4119-7f7f-08dd1e59a75b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:14:16.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMrtWozpPjwXs4Ov536S6P9hvdpxDPzlUzlm6Zg/XcCdPFIW5xCr4ShEgG0urVfMxQ9iqBG4yqx6lBR6HLWPZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

PAGE_MAPPING_DAX_SHARED is the same as PAGE_MAPPING_ANON. This isn't
currently a problem because FS DAX pages are treated
specially. However a future change will make FS DAX pages more like
normal pages, so folio_test_anon() must not return true for a FS DAX
page.

We could explicitly test for a FS DAX page in folio_test_anon(),
etc. however the PAGE_MAPPING_DAX_SHARED flag isn't actually
needed. Instead we can use the page->mapping field to implicitly track
the first mapping of a page. If page->mapping is non-NULL it implies
the page is associated with a single mapping at page->index. If the
page is associated with a second mapping clear page->mapping and set
page->share to 1.

This is possible because a shared mapping implies the file-system
implements dax_holder_operations which makes the ->mapping and
->index, which is a union with ->share, unused.

The page is considered shared when page->mapping == NULL and
page->share > 0 or page->mapping != NULL, implying it is present in at
least one address space. This also makes it easier for a future change
to detect when a page is first mapped into an address space which
requires special handling.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/dax.c                   | 45 +++++++++++++++++++++++++--------------
 include/linux/page-flags.h |  6 +-----
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 34a7690..6f2d1de 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -351,38 +351,41 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
+/*
+ * A DAX page is considered shared if it has no mapping set and ->share (which
+ * shares the ->index field) is non-zero. Note this may return false even if the
+ * page if shared between multiple files but has not yet actually been mapped
+ * into multiple address spaces.
+ */
 static inline bool dax_page_is_shared(struct page *page)
 {
-	return page->mapping == PAGE_MAPPING_DAX_SHARED;
+	return !page->mapping && page->share;
 }
 
 /*
- * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
- * refcount.
+ * Increase the page share refcount, warning if the page is not marked as shared.
  */
 static inline void dax_page_share_get(struct page *page)
 {
-	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
-		/*
-		 * Reset the index if the page was already mapped
-		 * regularly before.
-		 */
-		if (page->mapping)
-			page->share = 1;
-		page->mapping = PAGE_MAPPING_DAX_SHARED;
-	}
+	WARN_ON_ONCE(!page->share);
+	WARN_ON_ONCE(page->mapping);
 	page->share++;
 }
 
 static inline unsigned long dax_page_share_put(struct page *page)
 {
+	WARN_ON_ONCE(!page->share);
 	return --page->share;
 }
 
 /*
- * When it is called in dax_insert_entry(), the shared flag will indicate that
- * whether this entry is shared by multiple files.  If so, set the page->mapping
- * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
+ * When it is called in dax_insert_entry(), the shared flag will indicate
+ * whether this entry is shared by multiple files. If the page has not
+ * previously been associated with any mappings the ->mapping and ->index
+ * fields will be set. If it has already been associated with a mapping
+ * the mapping will be cleared and the share count set. It's then up the
+ * file-system to track which mappings contain which pages, ie. by implementing
+ * dax_holder_operations.
  */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
 		struct vm_area_struct *vma, unsigned long address, bool shared)
@@ -397,7 +400,17 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (shared) {
+		if (shared && page->mapping && page->share) {
+			if (page->mapping) {
+				page->mapping = NULL;
+
+				/*
+				 * Page has already been mapped into one address
+				 * space so set the share count.
+				 */
+				page->share = 1;
+			}
+
 			dax_page_share_get(page);
 		} else {
 			WARN_ON_ONCE(page->mapping);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 691506b..598334e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -668,12 +668,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
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

