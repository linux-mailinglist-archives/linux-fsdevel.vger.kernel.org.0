Return-Path: <linux-fsdevel+bounces-22573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A297B919C68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F0EB20D46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA104D58A;
	Thu, 27 Jun 2024 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bMoKliPN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0084C9A;
	Thu, 27 Jun 2024 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449736; cv=fail; b=igBzfBT9Qr4PKvTpvKaWrWzf+zDJMTP9v6EOAnslwfoz1jCHwXVCjnP5Gf5b30ndp1KmL5D2fpPvYOfnU0f1m3XdQKNv9hWp01Yvc10JOsKocAwBE7BB5YBNmroH+KoOkwk/CO7LG10/6OKLPP4t9TrCqzPnNqUahiWESWR49oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449736; c=relaxed/simple;
	bh=sTdfbR/WZAEtJsxC1hW17UI1uGQ+BxN8YO3xC7d8Gro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jy6HlJ9Dy1DsK0ljciTzZIRXOxx6PiDwROE0S2FPnqrPNQi/yWrY9U3K50hN9tKCbk3IU5tITK/HpVQKJGpIj4LQBrDvQOeVpFzxSh8l+OJLgiPaM2CHYQ0MNjkB0SBMIg0U1cNHE/eF3e8amCZQPJDx6Omo44cofdWufLNlM70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bMoKliPN; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keJBOwRGFG/pJQwSNpKUkjNyRSWJeCklVuQhgx3s212I/NQaLQ6ABgwbLn9eAwIL75r3q41mtIV/zaBjdSY8TrY2oadbDxnsBWaqhf40nhYY6DTue8AlLgx4eF1U3mXqg+6NYlRtv2/OWkVt2HzIe2hsPNFzzimd8a4Uwef6fU0vxljPcQvbgFx/0I4XJokQdY7U5XAnGTJjASUjVzcIjZ+uim0urPZn7LxdL884z0sAbIw6XYSuypCcyu8+A7EJeOZv7b9h9TBEELc8wtEIGsCyoD0Gr7/wWYqaDMR+JrhWiNfLL6arJKQLTldrwu4AJ96tSSa2N0Wi2Ao3/N/LqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsYaUBCkuUfLI8QjlhZUT1HmKGLGEWzFA52wvG9NRck=;
 b=WLWlQpP2t9e9LqsHkkyTGP1RTFsQp3YpGkDq1zC2IPgwbAvsThu+3j5NxbjUCPtVU6RE40Ho8Zl536a4iayqIEIXItK8UG4dZzGv5vn2aU8znXd4Y/m/WiuPxqH8oIL7HZY2A5v+pKTE75kOAwvDv3AXWnVaw7+mQ+gx/bcUtRzN8whVYWWTkHliwkcYgDTo1TgSyBZNP/4LOnfBThgJlugkPJ+HxWHJbwSaFSDeyBldF7EhYdo1hegEfaRt94Oob6gAZlqLQAoIHp0OSCCyBflvq+wUsYZ3p/WivZ2IVhHTohhWgYILrVmSOXT/+6SEx7IweyjGqSaavfTckRFUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsYaUBCkuUfLI8QjlhZUT1HmKGLGEWzFA52wvG9NRck=;
 b=bMoKliPNLkTD5NJQHjSbpo0q0aR9jxToaqUxxewo4j9lJc8GQGmIsQNHbHRh0bxH2qJcsJpDbcMrrJPFSEmzmH6k5qi5np2FW+zWrHNP7oeujCmXkPxSfF0Jdzer+fwkGbwQunlTYTtmNVWszPjfYsYz5Q6gMIpJhmJd+pWgAbMaYuUGJOW3t8VWrIF4EN/w+woXy6Zh5Zjoz9ILqSqrDIq1T3Y4e+382UtTFJklNqeEPz5saf4YKUXJJ2eNv4wYRRcaecd0AOj777JYcmIjqZDAt3cJFSsec3+PasomRsKs2ByoW8okS9O113D4MAYHSXaal++dJWVJp8UVRrtE6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 00:55:30 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 00:55:30 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca
Cc: catalin.marinas@arm.com,
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
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 11/13] huge_memory: Remove dead vmf_insert_pXd code
Date: Thu, 27 Jun 2024 10:54:26 +1000
Message-ID: <400a4584f6f628998a7093aee49d9f86c592754b.1719386613.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0090.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b039b55-0ef5-4bc4-9156-08dc9643d799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HhNt7wNo5Ywpna3dyfeB5cgUjaDxpxa3A173EDtjSYH+3Jx6l+UFNG1xvKpU?=
 =?us-ascii?Q?PRAX3k+LD7tp2sojxyt3inm20AE4JyK1wjqPK9GLL3KBwsK6daRuFWdtD+mV?=
 =?us-ascii?Q?p75O6qTFkP2SufskWm9Oq6tThJQq4HQBrTLR+gQfFuPNIcUq3X9rwrEef2lM?=
 =?us-ascii?Q?ZRu4fFoIGZkmqkUI9WXl7q2NbJWHVO2UHtXKL1m9hBYX+1uUGajsvE3bUBUj?=
 =?us-ascii?Q?kCARV2IRwcYKp8BqCWnJNHFyfuQ75tF1wxOS3NRibxdkBLlpGD2VVnrDkAau?=
 =?us-ascii?Q?K5Mf2v9uDUSC6+RvJdM1rtl1MhYsVPsdEeopT+6AiniXPDtpD5nYSd1U9JVz?=
 =?us-ascii?Q?9L/P2MgSwjL0cQQ4DX4CAnbOJjWIfTuQSAELGITkok3UFGauUk9+lnGSGf9e?=
 =?us-ascii?Q?q+gCRmvR+ZytEzrJebl2lYoqq3Xu5qgWpBl6z/X9qlt6YWlC5vUAiDwlgcUI?=
 =?us-ascii?Q?8RM2NY60FVfTuJhl3jU2iMi+JFHtaUZRr77ootRYzlbHsXBf/qWesvehfUbm?=
 =?us-ascii?Q?Hatv8TZMPbIMBpbexGHUURc8Wwjql0VEhdq2IKo2dDLKV9jNjlQtT8X5e1hz?=
 =?us-ascii?Q?VbloE07sIObgBXmTxtUv1Vdj/ErgRxtm8/RRwy2ZwoJaMFJ6MoS/oRBdeILX?=
 =?us-ascii?Q?F08c4qX8YE8w1emk8IviHfB9c0O461PU3YoYUOjZY2SuRtCwjFRijOrLGSjw?=
 =?us-ascii?Q?3SeR3V+qkxspxOuxA4i4uWczU1VOqIvXRKlwQ8v2LCNawLwkAP5SdcdJ6giY?=
 =?us-ascii?Q?ajacCa92Sop9DKrAinYD68XUPebXT+0pvfAWzQ4rK9MtbasDSZSqfo9m5pqb?=
 =?us-ascii?Q?E56u7B4Y1JLszV+TBkBngM9pSB1Z2EV2bz+26FJdzsPVQRNOo+q8Tkp1fFcO?=
 =?us-ascii?Q?INeDqSdgkcybEhBwdHal0FWoayhbyyE25zFg7MRcyTV8kqpeVYTAlPIf7+Bj?=
 =?us-ascii?Q?sUp9QwL6tWxtP/pCIKYCafvhdyPr3J+pZY+KcXMtShAx4oWRqg2505K/RoOh?=
 =?us-ascii?Q?eVp9lMz0S756Pepc83SjYMy/k5xnXMVnpsswyWjTLnvhOFV/zxT8x+Cltt7z?=
 =?us-ascii?Q?JFGWuUv72YFezm9hI8+aRmxULmInO9GL8XDHzUiMx09X8zts6J5fbgWCdKN/?=
 =?us-ascii?Q?pC5HPubvG5MSiREcXJHzX3w2T7g5Cvm+01DIwkaK88ZnZ3fE+0ClkZs8DDbl?=
 =?us-ascii?Q?AQbtH19925BrCEoEBqhnagoPwjeJtMcdvBzV15c6nR6mU/hdciFH8V8b7Fku?=
 =?us-ascii?Q?Njg59yk8UFtfF6KS5B8KKsjCCISjSUdjjy3l5+BW3vXx1T+lYeioEleM+Qlh?=
 =?us-ascii?Q?Rm8zrVZakUHCcnQmbh/6WnnUcrImJ2B/Jyb79a3CBay1SA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q6vqjrh+WHB//ZsVEZXnUAayTkj9GiPFJL+U6P349cRtU/SyfNB8b1R5gHI2?=
 =?us-ascii?Q?Wzyexm+4Gv+jyxECEvduJX6Fqpuu8HOV672p3Nb9AnPtJm34s7oNFZqv3xGu?=
 =?us-ascii?Q?3uV79KwNvJ0W1KHLyBA0gLQvPtbZ3KbwSso3nERKV8KdQkD7spUCY8xb3rZZ?=
 =?us-ascii?Q?5jiwJiZlv2fFCdjqxnE1pNzx61TdpBpLcbNt4b2vAQVKWxcYLYR4MZ2d403w?=
 =?us-ascii?Q?zkpg6XLmgHwNBDCEpnzqmagaQBNNrCQjwUTj/EYpTNIUcRZpNth1PyHhk0a4?=
 =?us-ascii?Q?lyse1ez78/iLhivuuar7E6AhBDSKxJ/aTyIBdrtFb4ap6TQSrIS7RKvo8RXi?=
 =?us-ascii?Q?F6yySRvCdLO4mDql49REpxw0JzaYmHIvqMsEf+YJ3saG/ehG1rkRhoit20jz?=
 =?us-ascii?Q?jlrSWJrdFApm6Xbmfbb3QWlHiRLRne3lvOPYvSJj/Kht7htxExLKBZVtTAlk?=
 =?us-ascii?Q?MQpY+hUSbiuLPJTEX6XXWfWrMvYt9V6zNK5qPfHrKGqazLUsb4GBEsHh2S61?=
 =?us-ascii?Q?taOMdnNQSC7XLmb1f3IK7k1rmtYBZeO3nbbmopcEQv1dAwlXs4l2jyn6Mq8q?=
 =?us-ascii?Q?ZPe704B9ku1kyocfrGoQrJYmKbYn9mWy1UhoihsUljTfaDpWlNX+m5LFNGbD?=
 =?us-ascii?Q?sZPumCyAN02Ar9RljSG1BEDL+RUKnwWX5iEX/negiLj3Mab+pQZcnMznIrG1?=
 =?us-ascii?Q?UxCdkpESJVQBzrt5d3IKipHVPWZt2+c58f3IOowrbMdUFzyzk54VRj5mqn4B?=
 =?us-ascii?Q?SE1ZeicpyCaWXRh3R9jGn/vF5MLUUpSMhCIhbJ4NzuL48u7TA3FUBoAXO07W?=
 =?us-ascii?Q?DbyXAr6C8tHFNURNOc7wFxAvU/xKzLoEogPUibfF4jXzGZ1M+yQQ2Y27AbSJ?=
 =?us-ascii?Q?Hp/A20KjeTBq/5kC3DnVMEpItVPMR7JWWnwEVbrQh6/WQU7Uy2B742HPHefm?=
 =?us-ascii?Q?VMYQpERfp27K1Lqa7wqw9+AytNOtowkUCROg14Ubzcd8bGGecRRrWw8+Ky7c?=
 =?us-ascii?Q?KtgstShmTZTt4s913aogIMmHLSmDpLw1PZzPzXianu8ilZr7FaaYbc2a/7rn?=
 =?us-ascii?Q?XAAop2qU4B6/Zur8Ie14wFVc5OXPOTkDwKeLRRaR/sUNdKdBWTJquHKqRE4/?=
 =?us-ascii?Q?NYMI1LzqLRehXmmzKpp5+mm0nR+5gmsZMcWyrSktsZ9CeIbBNu7nKmb5KEXS?=
 =?us-ascii?Q?STGsobO9rJEHTHBKfjW821pjGegizkstB2maF10J0Pe2rpbbOJ5KjwGLMsEQ?=
 =?us-ascii?Q?e7HiTCdA8ljpbaNWWBjLCizoZlikkAUVVeeMJYysBdCe7RvLoUJAeF5ys+wk?=
 =?us-ascii?Q?yAC9PWTXOaRcA6kVlNhZ/DepvwXhk+WXbDJ16XscCp19y7efUDzS7/UbbEsC?=
 =?us-ascii?Q?7+txEYIUsFrq6QVAX+4+VhmzLxcdj97MhUmX7msZAwQ2uvzN3Pe4Z2HLTS4L?=
 =?us-ascii?Q?blqAVDZ2LpWBS5isGnyyIA24nMiY9S77msX9K1wkAp95h2gZ5xg2mUZkWo/T?=
 =?us-ascii?Q?zO3mo0eQA1DOHRydWTCT+DaG8CO0Ql3Ph7tFwscEc3L34lS7LObnPa8Sr7Kn?=
 =?us-ascii?Q?5Ux3dknXb2KCH0fi2HazQtl/rxbaX2ajSdQRQN7R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b039b55-0ef5-4bc4-9156-08dc9643d799
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:55:30.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuWJDxp6+7nYY5svXEl2hLOznerYxZwhAA4zUAMkMysQR00FTjk9Tc97SgBPurJYsZlPoV5tjwp6kiUwjYi3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183

Now that DAX is managing page reference counts the same as normal
pages there are no callers for vmf_insert_pXd functions so remove
them.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/huge_mm.h |   2 +-
 mm/huge_memory.c        | 165 +-----------------------------------------
 2 files changed, 167 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9207d8e..0fb6bff 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -37,8 +37,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags);
 
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5191f91..de39af4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1111,97 +1111,6 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
 }
 
-static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
-		pgtable_t pgtable)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	pmd_t entry;
-	spinlock_t *ptl;
-
-	ptl = pmd_lock(mm, pmd);
-	if (!pmd_none(*pmd)) {
-		if (write) {
-			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
-				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
-				goto out_unlock;
-			}
-			entry = pmd_mkyoung(*pmd);
-			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
-				update_mmu_cache_pmd(vma, addr, pmd);
-		}
-
-		goto out_unlock;
-	}
-
-	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pmd_mkdevmap(entry);
-	if (write) {
-		entry = pmd_mkyoung(pmd_mkdirty(entry));
-		entry = maybe_pmd_mkwrite(entry, vma);
-	}
-
-	if (pgtable) {
-		pgtable_trans_huge_deposit(mm, pmd, pgtable);
-		mm_inc_nr_ptes(mm);
-		pgtable = NULL;
-	}
-
-	set_pmd_at(mm, addr, pmd, entry);
-	update_mmu_cache_pmd(vma, addr, pmd);
-
-out_unlock:
-	spin_unlock(ptl);
-	if (pgtable)
-		pte_free(mm, pgtable);
-}
-
-/**
- * vmf_insert_pfn_pmd - insert a pmd size pfn
- * @vmf: Structure describing the fault
- * @pfn: pfn to insert
- * @write: whether it's a write fault
- *
- * Insert a pmd size pfn. See vmf_insert_pfn() for additional info.
- *
- * Return: vm_fault_t value.
- */
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
-{
-	unsigned long addr = vmf->address & PMD_MASK;
-	struct vm_area_struct *vma = vmf->vma;
-	pgprot_t pgprot = vma->vm_page_prot;
-	pgtable_t pgtable = NULL;
-
-	/*
-	 * If we had pmd_special, we could avoid all these restrictions,
-	 * but we need to be consistent with PTEs and architectures that
-	 * can't support a 'special' bit.
-	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
-	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
-						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
-
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
-
-	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
-			return VM_FAULT_OOM;
-	}
-
-	track_pfn_insert(vma, &pgprot, pfn);
-
-	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
-	return VM_FAULT_NOPAGE;
-}
-EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
-
 vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -1280,80 +1189,6 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 	return pud;
 }
 
-static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, pfn_t pfn, bool write)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	pgprot_t prot = vma->vm_page_prot;
-	pud_t entry;
-	spinlock_t *ptl;
-
-	ptl = pud_lock(mm, pud);
-	if (!pud_none(*pud)) {
-		if (write) {
-			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
-				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
-				goto out_unlock;
-			}
-			entry = pud_mkyoung(*pud);
-			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
-			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
-				update_mmu_cache_pud(vma, addr, pud);
-		}
-		goto out_unlock;
-	}
-
-	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pud_mkdevmap(entry);
-	if (write) {
-		entry = pud_mkyoung(pud_mkdirty(entry));
-		entry = maybe_pud_mkwrite(entry, vma);
-	}
-	set_pud_at(mm, addr, pud, entry);
-	update_mmu_cache_pud(vma, addr, pud);
-
-out_unlock:
-	spin_unlock(ptl);
-}
-
-/**
- * vmf_insert_pfn_pud - insert a pud size pfn
- * @vmf: Structure describing the fault
- * @pfn: pfn to insert
- * @write: whether it's a write fault
- *
- * Insert a pud size pfn. See vmf_insert_pfn() for additional info.
- *
- * Return: vm_fault_t value.
- */
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
-{
-	unsigned long addr = vmf->address & PUD_MASK;
-	struct vm_area_struct *vma = vmf->vma;
-	pgprot_t pgprot = vma->vm_page_prot;
-
-	/*
-	 * If we had pud_special, we could avoid all these restrictions,
-	 * but we need to be consistent with PTEs and architectures that
-	 * can't support a 'special' bit.
-	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
-	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
-						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
-
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
-
-	track_pfn_insert(vma, &pgprot, pfn);
-
-	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
-	return VM_FAULT_NOPAGE;
-}
-EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
-
 /**
  * dax_insert_pfn_pud - insert a pud size pfn backed by a normal page
  * @vmf: Structure describing the fault
-- 
git-series 0.9.1

