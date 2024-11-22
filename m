Return-Path: <linux-fsdevel+bounces-35526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E49D5798
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4C22831FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF01F1DE2D3;
	Fri, 22 Nov 2024 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mqusUnHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01B1DDC29;
	Fri, 22 Nov 2024 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239755; cv=fail; b=fsgAS3wHuYDvdHePJ0IV78y98gPOWVoZE8K1JPBWRF5L2vgQ3QrtgMVIqcc7KgqDRZw3YYF5SeERQL61wDxp1tmfBAfXtkhXqV12vBnANMHRN4uzNH5qu8MbuGbZg+JiSOt54Nl9snWz1PVTxX9V7hXPezVzt6dvTpyRXxIWX1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239755; c=relaxed/simple;
	bh=LZd/w+ZZLlPe1nQqUZL3cc1GD/vmP/L5HkOHDxl8r/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gdvWNsTCQgoVhTj+ybf73oYpSNuf0Sv4UP2FCCvz/DfehVvj5cnhFPf1lO2tvcIZ3pmVALqrIP4Gf6naq8Rl+z68M30NdkX0YABe9Gco2BMzu3i7opmVNbguD4pDFoLi0G4P5aYuphYVNxUMUAU8GUGJ5S3WLCwqbixSwgKGRXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mqusUnHU; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqGpEBBNz7q9eF/x2uKixzWcehAC6bSozS9CtJFIo1Qs2QsZ3f3dfTzbrGNOZqxMI927qMSt04DCG57+t1Gue5MWTtFhHVOR2vovgvmWXVCVmzaCN/OXBwh7lmMZb+eaeAByy54gpukvEAKfv50/GDSSKDwhh1Doj4pvMUH9ZrXSga37Am+W9Uyrc711nWvNkCptPogfhXew394dNPy+28RBkYUsaOMdoffnIH0rX+bYaYteAsWKuIxqMcZ5MruyIKscwnuLf5X0ccMJ/WHPRVC2ia7IQZp3X106vC2A0bOJMuZIbymv0KoQZNZRAnwTR/U0r3RkMO0EGKc8E9M1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WcInd05whaB7j/u3Gvg0cn/MBRX2CW8kXh3eIdb7as=;
 b=YEIeGpXuTuLdwBH7G0ZBJMe/dhZo1HStBxIxlFhCKxft08cyshpl/euKBFx8Vasbs0zZVWLl3z+zngMy6Yg0JLnQh9BhwaObvfOWjPqFPVFm0k7wfpy8rJZuwzI1PxAZ3B1nJZBYKlM/E3ZaEfk7/BRyak+ON9/U+Hav3zTeXsgJkBPGRmhHFxeiKv93QP7IB9D3qoC/a8hMlFJPwZS2lTH7Slgv5h30iJeeUubMOQKoqtIb8IHWfnXbufIEvdsAoH9BJmHqzW1hXuGKmjSsmLpYrT+Jpu4TgAE2uhmUWkFiXNpC+8ImWk73qHNJ4b9r+lai4PUcK5sBkeXPkG80xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WcInd05whaB7j/u3Gvg0cn/MBRX2CW8kXh3eIdb7as=;
 b=mqusUnHUYGkkuyhdApUH+MTdm7J4R04BmgUg+BXCbv4k4gzB2+9l7L28umRauYp687qJqBnMmuE1G2rsGPhRC+coEDlI+6YoBcsqONK+DE6/tmKA8Z3cuoo2vtOjorFitPRgcJ0ZynDz4AGRzbhCPF39fqoytvJMGS6N3r3sckvkqrGGNJs2zndLru7WWWw8fzNVQXdPNYN/cL07lBUIyTwFVIOUWLLWrR0bUqdZyIFrVwPcFvQVuSfijlLQZwjaztTCVhJWW2hleQxqq2+5EzM7UrzXibYMHV/L20NaPQYImUSme6GUJlOqBZoZ5DLZhJJArXmXZPWdFJI6evlRbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:42:31 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:42:31 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
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
Subject: [PATCH v3 17/25] gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
Date: Fri, 22 Nov 2024 12:40:38 +1100
Message-ID: <cf9cd76a2e376030d8b68e5a6c7025f3c82b20ca.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0122.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::15) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: cc17be02-1dd4-4da6-a896-08dd0a96edca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mFLRxNvwuo0pgMsmliqufkXlW1h5OqnwZCwpd+K/lp4zXlCwh7u9h1ROBYKy?=
 =?us-ascii?Q?FkVPF+NkzvHYDU+3TsWm9emr0jo40J7F6M590QKjm6PYVrjUlv97cVQfh0ED?=
 =?us-ascii?Q?AQSQ57Zergp6UxY/GDLow77E0dQWptq6tFnILn+PKwbfpMry/fBODxLSyY7V?=
 =?us-ascii?Q?rpp8smcdCEb7K1fnZDW4w0OytoAW7zC4rdF/cvu+AWEorHJXbej1WioIqIC7?=
 =?us-ascii?Q?drmyZ6z0pj1/z2b1BawkRp8lIX651gXIDsDfI/ppNGTAe+OxuMOn7ZliRbpm?=
 =?us-ascii?Q?MAnhwGu/3Xv45rN6FbP63dTuwVD0EyvVy8XivJBuNbk/p5iB11aqa0pT+wjX?=
 =?us-ascii?Q?Tie7yS1qGrdneUhje+SxYdfaq5KWUf7VOTQ6cLsCIppMUXrIJDPwPDRCoETf?=
 =?us-ascii?Q?KWbKGvS/Zi10zANXll6L3RCimAqd9qDJjpLI5NFIvQcL2NksSy0qt/2q8e3a?=
 =?us-ascii?Q?pZjeyo1akbSpoNwCMt/XJH+zdzEUQsomdXg7HlJzkO4LTSyG5DM1ci2aAdD7?=
 =?us-ascii?Q?xXu7c9p01XiLyth1NW8277PVYoQPMP6vQchCWdWHOE+08Bvdf7FvAEKSrr5v?=
 =?us-ascii?Q?RUEBNc9gNUc9SylH/tKzeBPMjh758mheqOx/krC6u8X6fuHlwW78bOGljv+v?=
 =?us-ascii?Q?PX7Y/uC2FiZeRyRw907Zbw/0fcsNzoJtz9weq6KpnXD8AvdR888YYC/kw6Ts?=
 =?us-ascii?Q?yYjIPDp5WWBEmUR5YCWeDwWyONvkVfy0+avy7dupAHnj5PGslIYTxjXelaD4?=
 =?us-ascii?Q?Vd+t4lmEXO92+itJ3IRe+/eknF56OxS2dwLEK+UEDiaWAx1YnJIrpKEtvu2Z?=
 =?us-ascii?Q?y7KBLSvBRCqfbjuj9OZuvJLyfH4ek4F97IryuyWe9161RLp5+UrDglCk6oOC?=
 =?us-ascii?Q?bCD+ILqR0ip6u+0OxvH+Qy9rH9SSjKGr+A7zJrn/lE1HDn7UESQh4ei3cA9f?=
 =?us-ascii?Q?t/ZBeMnLIgi6Qn6mGIGuVQxpyONOG6545xCFlpXZv5CQ/twHNsje6voqeNiI?=
 =?us-ascii?Q?JJQ1egVK7JtNHGnguuxehWNHh1yKk/IHDg3rsWSFuOEy5a2//DU7gVIWDTtr?=
 =?us-ascii?Q?O6wQz0mn/KC3IXwL9j3XUmKiqFeK27CrtMnHhBu4J8f282uSDfsxapzFhBuj?=
 =?us-ascii?Q?pPZ8z3y4BtxHqROGFPusL2UYEobNWShv/UwjFbM0iVrmRXvdiFi857nPPduU?=
 =?us-ascii?Q?+mud7nDK9QTqBwqSEr5RPMgLKfRfj2IQK57aR7lTpLV/FxU4sKE2uNVKKdHB?=
 =?us-ascii?Q?BGzNLJDwLuFNspP42VK14cQ+4YGFw3yZvxua/3QmCv5D6GkhjaFNuAUJ5qgG?=
 =?us-ascii?Q?2mk6onSBeW69rFmZHsN6NaPu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DyK+4gvhpgN2sHdB6lKNlA/Kv0W9SFgKuWxEy/a/h/svGlJbU1LQL9+t9wNT?=
 =?us-ascii?Q?4PtHM0Jrk318k5yBzGx2B2kZvFQFxCTQs4vQfYHJCfVynVMv48gwMm7sHhmE?=
 =?us-ascii?Q?Uayw8Ygu0yXYlbTrBEr/p+s8WNkyBzHSZIAJ1e9R3q9uJofMAeyYi4T7gH+i?=
 =?us-ascii?Q?P3MNgcIQ6Cx6t4X6qMe+gTTBatD1j6FK8jV7bQw/aWfO0+S8HTFfKBrhv8nR?=
 =?us-ascii?Q?hVRco8o65O/1jyeX5hXI+kSdKGFLheMkDeBXN8JXQ57sLHrajrYzKQRmOH5Y?=
 =?us-ascii?Q?NDVH5dhRiz93ryEJLI8mNMwMjPO9uh0QolLxY9YRs1rsNVE+pMWo89Eup7GE?=
 =?us-ascii?Q?962kCgTcQoL4hlWR9puvy2QyQZ4oN3uZmsNkADpk7eqtx+jVUUkEpR1bK9a6?=
 =?us-ascii?Q?KYPf/s/3Y5dcLPH/olU2KioU58TYwGzt/WZGBqUUNmak1wPQVqolly13x9zX?=
 =?us-ascii?Q?akBTEd1SE35M4p3YLnPRomxXYPPM9/5LChxdKTwckGbg+aL1Og6N+Tisuas5?=
 =?us-ascii?Q?mqjHTZEzly1OUgZeYxvYfGRjYjJMdweJc3pyPaYG/dhX95iqyKZrMsC5yKG/?=
 =?us-ascii?Q?0QP08ZN8CJGYPgEEP0rkCl5qq9nW5c6XZ5cAoYQR9jr/8F2AInEaqsg0MRf5?=
 =?us-ascii?Q?Q3bK+hDZC0ds2IvDsvhd0jXZq0IwujD2BKtej4Ez5X1nxyLP/7f4H6kmjMgn?=
 =?us-ascii?Q?CPlm1CGdPAQzdtC4Uv/wAQDEgEJmBJuxpivLfpoaZxV+T1eG9rI5W+rULxqD?=
 =?us-ascii?Q?KC6u+WzatNfQZ5RsEfQZnN/UYsnFOaONDpN7+5fOGj6SaOrscy/7Jfs43C5o?=
 =?us-ascii?Q?cEvRyr9TPoeazPrlJSTn3AfgiugoPgpXCd+9WmPM19tFxZYgwwUqgOyWBBhs?=
 =?us-ascii?Q?LM415sU7B145LFn+Ii2+5DjEe/mLMcEiPgZFd6i3GrMneVRUEdBBB3pHtIv4?=
 =?us-ascii?Q?o/MlYoBqZ8PLoSpYhRjsNGb+7GPR9df6FJogCaslocWYbbXHmS6byois7Kd7?=
 =?us-ascii?Q?S3v3ehXmgaGz69UE3rpFS4oXmANi8qTsJ1rXYFNH9STDKowSwo2Mthj8fuuc?=
 =?us-ascii?Q?m5e+Ffqpx0F8Ut83HsIuuW5GIpGsFgj68C4HX0NdNRe76Cox4Dp8KXODWf5O?=
 =?us-ascii?Q?TonuvS6h3en9ESS8Nthi/aN4Rea9Lc1/MX5qHZX27TJD1TQOB3FA/MXnqsFk?=
 =?us-ascii?Q?Fsh0XCCEtIbq1mBtUk2LKbnQzEtMG+XkLO2V/Yko1VfT+aFXdAivEhKo+JF2?=
 =?us-ascii?Q?SUy9AYqf8CczHfwwlISDVrr0cseaibfghz4Y3Hg4CcYAJZJnoa+UmqQ1NcUN?=
 =?us-ascii?Q?dsJJVBSEkSe9LL400mtsBFSPqtuFYP5kwG9z1QGk7quvU6vVGKuStxRTmIuJ?=
 =?us-ascii?Q?gDfjM2RLk4oEAtSVVDsY94K97EhcFK1hJ5Z8fev8pX6Dbro9a9lQm+OmnufV?=
 =?us-ascii?Q?ffJkK6nOoHLqSVXKu9xHyFSTykdkk9DonN1zoRMf6CqtbZ3DrhbcLr3Te+Ut?=
 =?us-ascii?Q?bA1asfhNYj6n5IJhJ9te7tJ8s7l2/CsPYggByzkifkLbt1WIlp5qR6KEB+UX?=
 =?us-ascii?Q?vvvBKk0YwQbMZW4C5nMJ6tMeI77RlLH0GTvcthVt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc17be02-1dd4-4da6-a896-08dd0a96edca
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:31.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kg2MinCJzjQ58xxqEuYTq8pUDXDRlXqAyYiqErPqyEsELqH1H9L2sSVe1oEApLc1lQAy29mhHE867SS48raGqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

Longterm pinning of FS DAX pages should already be disallowed by
various pXX_devmap checks. However a future change will cause these
checks to be invalid for FS DAX pages so make
folio_is_longterm_pinnable() return false for FS DAX pages.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 22c651b..4f9ae37 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2004,6 +2004,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
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

