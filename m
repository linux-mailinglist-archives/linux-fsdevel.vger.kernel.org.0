Return-Path: <linux-fsdevel+bounces-40844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFB7A27EDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D011884839
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FB6225A3C;
	Tue,  4 Feb 2025 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jm6YW8nr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F0322578F;
	Tue,  4 Feb 2025 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709388; cv=fail; b=fUeh9TnI4zg1F+hXn9ZnA5m9kvW2TQfCwi3XcW1spWbIBt36QrZsJN3itY87t2vs4HrB4S/ZEGr4KBgWjppRltXhavkRHAR6QyjHgC35IOVaI6uPzV9SRMfaewEBF50sYi1pGCBHJ16z7lM60uA9AYd0P583YJ2DHu2SPMHfUm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709388; c=relaxed/simple;
	bh=E1YQBdprs85XGO0RVBKzFweRGhzw3F43QPzzMBtDbPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qr+eZAt0LnHAWvJqyGtIPIhO828UAfR144FUvmr4r/S54XiKDRhXstiK3JCoslGpiyRUMQxK5lTmKox+j2hDk5xMoDhbyopSUb7SkJfXRmcW6AOw+bPnKtwEaW9B8w+AHqTxWKjzhIemgpKsxluv4pC+Huhvbp5ja1CVUJi8NBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jm6YW8nr; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+w0NoJ7VoEXB0/Ehmqoaqhv/F9vNDWn7DUrKaLabLAnlmYw15mN/ueZyPc3MVv/EPDVqmDSLDXHfmA5fWf2yQVCEkdUsvTd8QiN428UbdoJ/OZExUpzfS8m4F58B+wnGAtEU3wEPW0njCRCgktxcuEEDjHSvVVr6L0CsQa48Ul/FbpPwRkbtj3eT6JEbKJOl9W/xEuK4eSAOjkGX4jTfHi3XT+DO2o1NeabCe6gkjHon1wdsSQ8buTSxG5IfOzpvItcwGx2uDgYIiHVeGeKf/wZaDmEtI4lnr3IIJU+1XMhR1rrlshtb5crirQwQqRtypPnkEgHHp+KxoyZG7nxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEal2QhpcZUA8+Sw0W5QaF/SstEg/0aZ/xHzs8977TU=;
 b=QOjU1cX2iNMbbSCEn3pBLvjp1vhCpypcNLotFMM3VouOKhfNV+CLz4yfSFFNkVYwVuzAk9CCtOCIzx9cy48j0wb5u2lrwPpnKEt7NfXHjZJngx+GZXHJvwkGTKaUjEFr75GptUyOjs2CreAUtAY4CSeJPJPz9ScA0ni2RLUun6brw/3+69X6jiwVQ3if5KVP3FhYtjHtMCl8/tw3oXzTRd4rIgQeXsNoTrhMlrmd1vRrbUmbEPfRGIgBO2sHGI1fzcPFyZziVaicfWF9eI51Deh9Vw1/HzoXbROlA7MQRfz9ZtuM9nBPOTsV3dnC+RCA0WEnZwBAeHGKALOeKBVT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEal2QhpcZUA8+Sw0W5QaF/SstEg/0aZ/xHzs8977TU=;
 b=jm6YW8nrByAlhiY9KbQkqhvyXbeh80OQV6YHTKBwgfMnUvRIyA+pON/nxmE2zf/S7P8ZXIKZ0gsg71sZlTORtA3reiCiD+kiWQ7vc0w69FyqSIZg3cXCDBHBkAKB2jWrZCPZ3gF/fSJCDNH0AQdktgaBgYJ2NWHoocoS6XrZfEQa+nzz8ZjcEE04tRRZrxotUfRuaHKKOpOP3J2Twe765tn0X9Xzds3u+j/sKeHpuZXAIN+EcRKPookKipMgggEDYn6CdE3CMDmfe4BvWpCLFS1PXfIdpzXARa9r1OkEO2E5Okq+xBnRG2GUTGyFCHha1kgV0Yo429+jG/PLh8skzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 22:49:42 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:42 +0000
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
Subject: [PATCH v7 14/20] rmap: Add support for PUD sized mappings to rmap
Date: Wed,  5 Feb 2025 09:48:11 +1100
Message-ID: <1518b89f5659d2595bf9878da4a76221ffcfef60.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0072.ausprd01.prod.outlook.com
 (2603:10c6:10:2::36) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a772c6-989a-40ef-19f9-08dd456e3698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Th8rjr8KI/+j3VeJzyU2bNT9ZjokjiB14uPlD4o5N1nVcO71wq5inoxCnopd?=
 =?us-ascii?Q?J2cf/Aw13ZU18VIIl12AOTyLWkw1CiDxdgTbsOMpZQrtSnP1FLJ0lAthf9bQ?=
 =?us-ascii?Q?vrNoAscl8jXtsI089OJFC0hmwe780zsoA9aUEDcRHHQpIJRzaL7lF9qgXkVm?=
 =?us-ascii?Q?jsTY1Pxnz79UqTelqA/3s7Cjnr9QP8kmFtrFHFyGcJdIikQwfsf+4E9L1q60?=
 =?us-ascii?Q?hBsPYya0WFan1g5WcUX4zJl6wLe2m89/N22tyjqrs+Ax3a4D7851rCnQ9NmB?=
 =?us-ascii?Q?bEg4rbVqp2dDz0HUnFI72HYX/RXb13FJ6FjXYxPW1XTwixxEt6A0sD4hDZ0g?=
 =?us-ascii?Q?uPyq5hBFTlNkFRqvpDzNrGp6Rn5n37WPF3BLB3TJ0gT6JEFRmFK50VDvJ+5K?=
 =?us-ascii?Q?OxvPAiYr6VbdLLsLeLIjnR0igOUiv21IZea0qSPDvzy+eUwtumwZdwyweHP9?=
 =?us-ascii?Q?tvUCnd5NLoMiWu96TFLHSTQDtm4P5+ybUOdVXGOXfYnzNihwh1S8KWWM4zqF?=
 =?us-ascii?Q?+QpYA2i6Y1+znxifki0UzRImm9gO+4C44uFzhZZmkWfFGB/fJj9STBAsb0HS?=
 =?us-ascii?Q?wJInF1N8vddUjblmAk2oSDywiW8LdaJexsbyeBfyR1zm9uk/8SIAX/Y4jibO?=
 =?us-ascii?Q?dskOG9ublZNO9hqD0zuwTUPWfYPgxf3h2gdOz0Brz3Js68WIo+b+fKpZ4tn6?=
 =?us-ascii?Q?NAvs1rzY2/qxFAcymLXSGbCRsuFNFZmapUx2dyiDFbNCow7Su2Nq/aQBczMF?=
 =?us-ascii?Q?oy42wu9uyIwemwVYASRSDB/Sp3g7A6fl2ShMtI4bsUovVDiRFObai9VmMFvi?=
 =?us-ascii?Q?8t79XW9mdVLc0jdIsnmyXxzhQDzgveGbOwL8dLgQGwds9ekmaGG1TspdANmL?=
 =?us-ascii?Q?sPCQEo7XOLFaSR643MGxulM8rk/Dr9H0pIE1C9AzV1n78KlRU9mNLw59wi+C?=
 =?us-ascii?Q?L31pzUuCkrE6wzCKXw2iDz/nc8ulQyDj2usmDA7RggIbyj7/IXhqMfAOP8+Q?=
 =?us-ascii?Q?B/+3AtvPqWLcoyelnHETAOAqtWZn8BlAgiegAqrRUoQEVeM3miFWhSx7vB80?=
 =?us-ascii?Q?V7AeviPWlaSNjq7DX291INp/00BwE4SAkJQlttf7exa2UxqqiDQ33tDoeh/l?=
 =?us-ascii?Q?oz8WW1fLUDQmLcnY8AVqNlZTGC+09PEEyTG7TtTuN0JfTUm3t1B2qZ1SPIbb?=
 =?us-ascii?Q?SEr+kjcSuG87nTGR2JMAmA1U8Tuo9/r2C00GT+eTu+SzTUhnU26rp/QH3N3h?=
 =?us-ascii?Q?8JjBBCgE/ZDMzh6PRo9M2d0qyw3fpwlvv0JpjW7P0z7sd32dM2s9CgDbPt3f?=
 =?us-ascii?Q?/joRQfY687hXQ4c7UOztjwVGCyxA2zjIeZ2H43t2/slWVb37+5HdFFSdhWZR?=
 =?us-ascii?Q?MfiYSCSe8lCFtUo8N/VnKi2C7XSk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E34Wt4+tZEPtsyjgwV2/+cOUzIMg/flPWowKiI04gwXhmqK3j1+NZzbhvK8q?=
 =?us-ascii?Q?zxyNWdDyz+rzo5uKXhJPHdRAi272G/aLMnmBVHOmvhDkO6sI5HHiPPZFubCc?=
 =?us-ascii?Q?mPLtT0Q8A878+wCkoRKk/4zq+l05yJiI0XanEJAUBMDz5CGVYOh2hJGbBH36?=
 =?us-ascii?Q?tcX68ksKttrW3jMjUYsDnScDydYlnwyqOLsh5Ri65BvTKNhJqnjFhcjmNryv?=
 =?us-ascii?Q?1+6NPz2N3jyuVQC1pw1c3zjuyM9p/yNIjdK/Vx1SMDG3tQykr52aX+NLzOnQ?=
 =?us-ascii?Q?OFRsHV5eiTT8ANKWJGnOYOhVKnekR1Wd8ENHWpjlULyguRHdLBvCHrC6ZjQC?=
 =?us-ascii?Q?3B5euFm/Q9kNjbzdf0ZER+xAwaHlJtXMumKePOmjfxPfwqfqXoJ6sXJre4F4?=
 =?us-ascii?Q?U+VCpIB3KcuyZE5KEXYFlRSuw02exbfwZ69ug6B5wRYojskFBvi5RbSDNAzO?=
 =?us-ascii?Q?460HEMlXveHI3OhXqm4Hic9pkcWAwWB0l5xRjseRUeGBCWCCrnTE4+IOcaFf?=
 =?us-ascii?Q?sJ0/+cXPWOiPLfpUo4822UBFLKBrhNPxu5eRHL+cKr5Yx1/Bsp6yn3fOGuib?=
 =?us-ascii?Q?qyGWFyaiNZmIvo/T0B4/BtLIDYISbzVdbgtNixGpsJ0i4zkDZ8qWcx3Cs9UW?=
 =?us-ascii?Q?KL3AMVQhoz5QdtBAbkHLAbw919qSjDnMVaAi6S2/2tuyb5qZOUC7bWQ1w2Jm?=
 =?us-ascii?Q?8karyH89yZN/htLGLNQI14VtX96JmVP1Qpyl/pWbS3OTnddrywBN8mVLqXkM?=
 =?us-ascii?Q?UUCStmbp+Av2XkzPzZCoMXKAgQcx3ftefN1eVHfnQLkeFc77gAHS28E+HBc7?=
 =?us-ascii?Q?Y5HO+Qbu5N003WOfuid3RAYg6oW+2bFqFgoM71EhhRb27TdCM6hJznE8Ssyc?=
 =?us-ascii?Q?duWWsRO2aUDePG1j4BbX+wU4o+lvvojAwnnyEisIEkVs1sATL5MRziyw8fM4?=
 =?us-ascii?Q?4nVvZq7mF4f30M/OwcjO1REqtLvNF3bfMYKkflzyXWR2bjSRyjx5wtUKTCUs?=
 =?us-ascii?Q?UZwGDzN7CkceyJiik8W9Y6R/gMj+FryBWnM0AJKbfATLiwSkgV9beAE8wlAu?=
 =?us-ascii?Q?c2tLKcniNjRwlINqzHkPN28VdNSp49xazgSFuUmecW2ejmDa5NJDcueqBut1?=
 =?us-ascii?Q?kyxmLnkCb7RFEHPwRMNua5/0QRs9+pcr0aUMgbK1/hFD2tBc0M/J7olhkvY7?=
 =?us-ascii?Q?obr9ZiUcGz7FPOB/oG3rjT6il0zqXs5F2CZfIcPBT/IGEpa/iEWlUc9CTozI?=
 =?us-ascii?Q?mJgHs8lay4nMw2jdev0W69Uy+kFw9Dg8EUo01FIdY9ashyLZAIUcKyiRAtCo?=
 =?us-ascii?Q?VxIWcjrAv6w/AMLBlyKlXC0zuaP/bPfMA2Qq9lhFumoywra9TAAEOHVA0gyC?=
 =?us-ascii?Q?SgwQC8lUH22nOe6ERld8FMJ9z3Rfi+Rw66C8ssHqbrvmdnTPvbxG1HCgNcYJ?=
 =?us-ascii?Q?PDyw74cX/HKT3bqcEFvdcApsKkSTYX+SRvDcfNKNFkbs3guMQ6t0dIMNr0J2?=
 =?us-ascii?Q?0AEPeN14PZi0BKUAOfnCJo+sgbU+CqUN6Nomu/uYykXtJVGlJ+Y82/WzVF4s?=
 =?us-ascii?Q?FGYCBHhuM1pDUVak6RDyQdJiFfusH6Ud2dKfQEzJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a772c6-989a-40ef-19f9-08dd456e3698
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:42.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyIuAARsG8hSHyZdyBWDKVgnNtpu3oon6iXFCOXW38pbb4hEvxjSG4sA9PCFjITv4vRYe77DtIdzDDhxezX1bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

The rmap doesn't currently support adding a PUD mapping of a
folio. This patch adds support for entire PUD mappings of folios,
primarily to allow for more standard refcounting of device DAX
folios. Currently DAX is the only user of this and it doesn't require
support for partially mapped PUD-sized folios so we don't support for
that for now.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v6:

 - Minor comment formatting fix
 - Add an additional check for CONFIG_TRANSPARENT_HUGEPAGE to fix a
   build breakage when CONFIG_PGTABLE_HAS_HUGE_LEAVES is not defined.

Changes for v5:

 - Fixed accounting as suggested by David.

Changes for v4:

 - New for v4, split out rmap changes as suggested by David.
---
 include/linux/rmap.h | 15 ++++++++++-
 mm/rmap.c            | 67 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 683a040..4509a43 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
 enum rmap_level {
 	RMAP_LEVEL_PTE = 0,
 	RMAP_LEVEL_PMD,
+	RMAP_LEVEL_PUD,
 };
 
 static inline void __folio_rmap_sanity_checks(const struct folio *folio,
@@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
 		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
 		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
 		break;
+	case RMAP_LEVEL_PUD:
+		/*
+		 * Assume that we are creating a single "entire" mapping of the
+		 * folio.
+		 */
+		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
+		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
+		break;
 	default:
 		VM_WARN_ON_ONCE(true);
 	}
@@ -251,12 +260,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_add_file_rmap_ptes(folio, page, 1, vma)
 void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_add_file_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_remove_rmap_pte(folio, page, vma) \
 	folio_remove_rmap_ptes(folio, page, 1, vma)
 void folio_remove_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_remove_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
@@ -341,6 +354,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
 		atomic_inc(&folio->_large_mapcount);
 		break;
@@ -437,6 +451,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		if (PageAnonExclusive(page)) {
 			if (unlikely(maybe_pinned))
 				return -EBUSY;
diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4e..fbcb58d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1187,12 +1187,19 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
-				*nr_pmdmapped = folio_nr_pages(folio);
-				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				nr_pages = folio_nr_pages(folio);
+				/*
+				 * We only track PMD mappings of PMD-sized
+				 * folios separately.
+				 */
+				if (level == RMAP_LEVEL_PMD)
+					*nr_pmdmapped = nr_pages;
+				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of a remove and another add? */
 				if (unlikely(nr < 0))
 					nr = 0;
@@ -1338,6 +1345,13 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		case RMAP_LEVEL_PMD:
 			SetPageAnonExclusive(page);
 			break;
+		case RMAP_LEVEL_PUD:
+			/*
+			 * Keep the compiler happy, we don't support anonymous
+			 * PUD mappings.
+			 */
+			WARN_ON_ONCE(1);
+			break;
 		}
 	}
 	for (i = 0; i < nr_pages; i++) {
@@ -1531,6 +1545,27 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_add_file_rmap_pud - add a PUD mapping to a page range of a folio
+ * @folio:	The folio to add the mapping to
+ * @page:	The first page to add
+ * @vma:	The vm area in which the mapping is added
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
@@ -1560,13 +1595,16 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		partially_mapped = nr && atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_dec(&folio->_large_mapcount);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED)) {
-				nr_pmdmapped = folio_nr_pages(folio);
-				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				nr_pages = folio_nr_pages(folio);
+				if (level == RMAP_LEVEL_PMD)
+					nr_pmdmapped = nr_pages;
+				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of another remove and an add? */
 				if (unlikely(nr < 0))
 					nr = 0;
@@ -1640,6 +1678,27 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_remove_rmap_pud - remove a PUD mapping from a page range of a folio
+ * @folio:	The folio to remove the mapping from
+ * @page:	The first page to remove
+ * @vma:	The vm area from which the mapping is removed
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_remove_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+	__folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
-- 
git-series 0.9.1

