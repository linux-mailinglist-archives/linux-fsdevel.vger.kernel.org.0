Return-Path: <linux-fsdevel+bounces-38824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68150A087BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB34188C257
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30E520CCFB;
	Fri, 10 Jan 2025 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJGw/EBE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FA207E0A;
	Fri, 10 Jan 2025 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488978; cv=fail; b=AK4vbd9Rbw7DEBg9b0eOig0C4wqicPU0qwxBc7vNzuFxb4vG3a9laMxv2oPjjNLbndWJuCbHQFFJTJFWZftCLIoDTDD8cNIlgd2BO6TOuGP6cwXd4LXnrKF3v2Ezc+ommIZKXo/moCFLS9t+tpcRzTyfdCOVr9AKyf/XF2ShUSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488978; c=relaxed/simple;
	bh=dWaJOYn4wnllJH54JaYu53qYtX3ofzwwSx1ZUb1uUCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fdU2lyXwYH++0S0rA9GQ2fN6DAr5OM8Qti4bhpOdJfHsy3/5QEUNgD1IOyVA0IDE8MsELz8qlEJUBolpDMJwqQqFKofnn5PiOimSykSZEqogAaiy7gf3AhKZNtEFgX5hPfl5wyOZglfKcFnIt6KTerxi68jPQmD+l04DCpQD5rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJGw/EBE; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtAsPJnp+HCXR679ZPBUBHPv/N3PJsre/UJUdRFdQzWpM6ysrKfPJhHw4jno1fI8Pwjfz9Xa4hc1W0aJRzHF9Uj9a2p1/mSDRLaTZoYuyUSPDPZlaL0s6TNceiGnQ7qTkXnivtJc1heF9KZdl5wBJj93ZP4AgGKSK9IRqZtxTtrWIDL+PsLjdXQCVwSF8r1aN4fFjmEZOA6Mrv7xLR8WuGHe8dP0lgwrzjK5KpWjETnLl6BqwH4EvfqSa64atGE2N77pMk5Y98g4VVmfGxcZlsf8jie+Jrzmf4UhftDImY69afWnEfT3YsY21N/IAVAk/CeWl2iOojruRxVwD89jtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck5XiCzxtWS0Ep/kZkIuKJrjA1hdch3Ab631Ko01rm8=;
 b=xOtChpO03iXrsXoob8PNMb3w4KlWQModaSS5StJ/CSE1EFL7tqWtMWGZgdvVFqj1esod0L7BbiteO5daGrnNAknRpnGTj9j8xqprpoJTRQk71qI23Kz5CnG2wh5kt3x9GDlVgdB4KimB7oeK2JFJfwujU7g8SSrrXVGbN+1gAbY3GaesB8Mhb3Zb86pxjQlkZRRsM7coPSYpvG3Nvzxd2P5EChcSx8Obrhdwn1pFcchA1Ofiki3FCVJfueMjgXpERh8l/OEMP57sgfCea5EpPJVOYnb68BbN/lwytNefve86lHCAGKhgubGU+M2qHKTtsiwcEb9RIoEbS5zmb1ZVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck5XiCzxtWS0Ep/kZkIuKJrjA1hdch3Ab631Ko01rm8=;
 b=SJGw/EBEOcZYMprz1iSTrsEhjKG8FoA9FT54gEjoU0Alrzq7pCaTGZz/xbzD6kRowI2LVCa9dvQvXPhLJmGWoVuhqFR0+jeiOgeTpP9Taa+efHq5b6d4Xdp2EyLtY/xVre2n2JAL23zsAzS6BQJFmh/M1yqGbaB61Trbii+TcYg76rKM7GykQTXjghsGLKOXqpjin3KH1lTfvkDJ5upyCEjxraJg5LI8YVwokvHURwVIDrMKsbr6TZuOiu/zs5WJKeFqJr9WsLK/Q7BOHwREqMZ+S050gSTL4yFRWeDsObKqAAAkfRhEphdK3TRMyQFvgfRMT709+HiTx07P6GFyZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 06:02:54 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:02:54 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
Subject: [PATCH v6 18/26] mm/gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
Date: Fri, 10 Jan 2025 17:00:46 +1100
Message-ID: <b2af3f542813d357a08f07e396df2793822035e4.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0211.ausprd01.prod.outlook.com
 (2603:10c6:10:16::31) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: dd00cf1d-6e88-421c-eb57-08dd313c6c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BDsuwkPzSFJKaLfze6iKtoCJVN7RVzmGBxGy/5eDiJHwEsdD9R4tI7N2qGzP?=
 =?us-ascii?Q?554J0/hpx7E5afbvKln6WTMSM6+30bST5A4yHFLBQI1R/xmSBOhs9xYKFANV?=
 =?us-ascii?Q?/97wsc+xX4AZKsgNO0vqNvCDYR0gGEx5m18AgA+KJ3DiFSYPk2yq8rEVaOSq?=
 =?us-ascii?Q?HWzUZwNKP8pfNfE3pabgXvFp4+O9h5lDrFhcsvB3OyNY1bVPk4xx1qbXgaQ3?=
 =?us-ascii?Q?5KIQILi1YoeYExoq8TlBGU94frXFj9R0Ien2Oej53JHrevtKKIQQg3akGdQS?=
 =?us-ascii?Q?T1KtZekwlwJlOQaO5mEDA1tGyRY447dc4Xvx7fUqJYEp5VkVZFNhwd9KxMm4?=
 =?us-ascii?Q?FZlpw8w0O3apU5y5e9p0lBJpKpRLMH46aTb8rmx4Y6GpFZBvp3pVJti6byAs?=
 =?us-ascii?Q?G5TlMRdmBmT1WQD5WY5p6UyYBUUv/Wk2qls1Dlidhw2IaTGgiBK2ZxcYGMf5?=
 =?us-ascii?Q?qEqjuhW0B1lwu+S9a6+ZLr5PkYcwLnk0rLFi/Kn85pomxWG4nTkxBY8wzOnL?=
 =?us-ascii?Q?NjOF9EcXZ98JgBDBo/O66tfnGvs8TMrOX7vq+o4n6pWPz84/lYy4g4x49VyH?=
 =?us-ascii?Q?wceGXlwi630hrgkwUpuVBK5BumNF7nYm61TfdV4z2Wo4HvfJIyyXFynNNyDB?=
 =?us-ascii?Q?mrZ2/gn5/w5PdKh/u7WpxJ4ITNpP1nuyvp1brxbZBip/DbzU2aNXS4Ff9LA2?=
 =?us-ascii?Q?uDXodfTuWnu56EccWyKd+31eyqlqxr5cQAoWxHL+rZirrGVWoSEov9iXc8Tu?=
 =?us-ascii?Q?psAPJ2K2IwLN73AsQLD1HaWH3Dq8PLMIo9iKn4QHCr5usqjEaRaNHLE45akC?=
 =?us-ascii?Q?KLJrK5hzZm5wONOzIZ3VmNBYIB1Ven1m8TbDlKTOm+2U8X/fgyLTwXJsgvuS?=
 =?us-ascii?Q?DUZw5VFo608RM4HWKgoj5+LZTPdPJC79hFGCpgSKyZ+/TJWMNbSgYH95nIS8?=
 =?us-ascii?Q?9QNdP6djSoNBOe5GPQJ5QdM3QKbpPJ6Z1IKDCwnKu44t06ifaipDkkXS5Mnx?=
 =?us-ascii?Q?+3xmEZ7hi6STyq7dx/wTRviLJxVlg+G/7eyZHfO+G43pEiFeYv8nimSDGDX6?=
 =?us-ascii?Q?ocNoiwA2npwMc0va7JPbfsMd9dhB5cZsVI+36rg0CNOha+EmHyl0jv/+lH7W?=
 =?us-ascii?Q?5FjXZzDAYEeiE5vxbe4SMT4nwNlwflgFHpThsibRsbcf7F2H3dDmmDgep/4i?=
 =?us-ascii?Q?3KRXRztp1SPMcf7icshRFIiuYBOxTRwVlKJ12AyYXcgq95kYCSBfWukyNQHS?=
 =?us-ascii?Q?CbFcmvEgvWO2DhGUei8Q6CQQxQtlKQDFaB9YQ9OYZ3Y6vwyJjMT3R1n6kHAU?=
 =?us-ascii?Q?Y0E/4Q1eWQwpRNeus5C8hAH6YAXL8F5joMWEA6dU9HEasM7OyW7cVCHGmFIT?=
 =?us-ascii?Q?fsgl4MB2LSZD3iC2OWkT/SWLc501?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oHEggWRc5RlMpeIzlu3ApBC0vdfeWQWYc6F+CCPS9q200xcMzqHKVwabeXjT?=
 =?us-ascii?Q?8z13w0evTJeqd+wIqPB7927/HcD8LXpJHvMBeud26oZ9/Ws+jrPNVrzM6XSx?=
 =?us-ascii?Q?ZWWzYg3KPXBuuckdWBJ7Ro9W9M/9jEGeW4eP0Y4kAOFQ72ComFDrP3n1a7PK?=
 =?us-ascii?Q?qx+7kU10QaBDcvL/0xTCdRLFiFCIpDk4EuNqgQfbuaHlvJNhRkWaFZldjCgN?=
 =?us-ascii?Q?2/s9XTJfh2lZ3eL8D/FYB8Wb3LclQPuGsNL9n0RQjlM6pBBHOG+cVU4SPzGv?=
 =?us-ascii?Q?dweoV9Y/PiWN7rU/TuDnNbhb0uGd81wfMJXzNiPwUTx5n5afxBJir94SLRne?=
 =?us-ascii?Q?iprZ4ORoliKgN9fZaLjSBx21XmhU+66EzGaKQz8GfjeLmaz1ocoLRnlyxHvT?=
 =?us-ascii?Q?6Xp1HLw2PF3XQyQ1HZRIEF4rOfINvNc0M4FuTysrdesFew66UBx3wuaOFIoX?=
 =?us-ascii?Q?OX1qmJEVU0p6LIaCV8/prUHeglsvwUtviaFbVATCzSvXlrHbNF+ANtZsf0XA?=
 =?us-ascii?Q?/yFEVSCHl9L50KsqXaBjG7bvJb2VL0xNeVVFLYCQQXdNitHC/zWfcGEHwtXN?=
 =?us-ascii?Q?7zn8bVxN8ih2RwpPbSkokixtOJ/QK4PODXnjAqheZQTyWvP/xT+u1QxKo5mD?=
 =?us-ascii?Q?2NUyU6xPSrUdQreBx7HR6wCk5koMX1XyPuwFm/n9ntwMi/EAAP8QLnVKs1jw?=
 =?us-ascii?Q?ElKkc6+iMXlUvlKkxj9O/n8RohWnczD4BveBoexo5zTDdZAyU5eB+wIrHgB5?=
 =?us-ascii?Q?4liJCx/bfhJw3mORWjuVzZY01Ffq7o0anqCT/ANE5qQhth31eqjJSN6TgKgi?=
 =?us-ascii?Q?EzEm83LZcKeuKzD5MMQvVdmDGVcaPQ/GJPkHasQvg505VLXG6kFQcin0VXFT?=
 =?us-ascii?Q?hSM2EmorhsFM9A1dgPT8f9LAVjVFe94zNvHJ0YElER+ih1ujIRPnL2AeccDd?=
 =?us-ascii?Q?GqMKNfkBVg1jGbtFBJmUta4nSUKdN8DnjX/OfyHVCdm5lApz1XnYqmx9SslN?=
 =?us-ascii?Q?rJTjjBtZLxn1LfpgMp1LGV4/ZfLf+WeWI3cQhwfmsoKn7YvqFDGZuyqQF2XW?=
 =?us-ascii?Q?xzn30J74RJgrqSgZUaSmSYXSFNRAe433O+nTTe4GDX6UKF2GHAeWO018I9n4?=
 =?us-ascii?Q?Ngj8zJr2sP2qJsBGEFqHIbaqO+V3d80dv7NAzQgmUMHuge6r2GV5mo6Ifvk0?=
 =?us-ascii?Q?sLt1MVc8Olr02WGtPOFD8DyV0d38gyLxD53OeUHOSioIA/94LWeqMgQrL3oI?=
 =?us-ascii?Q?04e4RX5/ct+d9TW1egzGioQuwVJ3iIOeBSPfXABSC0FlCRwjQy9/X9Ct3H0+?=
 =?us-ascii?Q?GRNyRIxavnLXHBd+oW5rsr1d/QpTzeaX2hxFvd4oqAevZLfOGGqKF9xvjrQP?=
 =?us-ascii?Q?gfBGyJJbELT7cReZJtKGyE9XkK3R39RV4h2zg33aXhONSDZbDmIljGvvrLzj?=
 =?us-ascii?Q?DSqfndtvEYzLdTSsRQ5jcTbaXX10edkhOuyG33lxJkwlm/fTWyGXax3fw3FC?=
 =?us-ascii?Q?HBE2pcrQwvV0DjiSeqYIbDjLzLVS4PhJpqcZD6T9UwSJoeOpUTD5CRhQ962E?=
 =?us-ascii?Q?KdUdkUVAYai4h+cdUkC0HQC9V2gpskKG6c0D5oCz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd00cf1d-6e88-421c-eb57-08dd313c6c4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:02:54.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0hMsAucFkEFhYHPfA4mA+U01Tw+0VgCfuw5vRg8JTrsoAkhmPbUgeCYVx06XinAOhnBJtrgb1AXNh4FC0mhrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

Longterm pinning of FS DAX pages should already be disallowed by
various pXX_devmap checks. However a future change will cause these
checks to be invalid for FS DAX pages so make
folio_is_longterm_pinnable() return false for FS DAX pages.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f267b06..01edca9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2078,6 +2078,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 	if (folio_is_device_coherent(folio))
 		return false;
 
+	/* DAX must also always allow eviction. */
+	if (folio_is_fsdax(folio))
+		return false;
+
 	/* Otherwise, non-movable zone folios can be pinned. */
 	return !folio_is_zone_movable(folio);
 
-- 
git-series 0.9.1

