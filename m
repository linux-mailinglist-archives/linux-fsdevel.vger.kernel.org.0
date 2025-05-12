Return-Path: <linux-fsdevel+bounces-48739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F96AB37FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 15:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8186D3B46E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F27292087;
	Mon, 12 May 2025 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y50SjU4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C85D20322;
	Mon, 12 May 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054850; cv=fail; b=TMrJPmNOp8uU1Z6o9KcL+uKpLc7+jlr9YcOnxE11INTSi8CmPnbh7KnsGmu3/0YuwS0ELF9IIHIjtHSm0Kj7uQHodk/W2nJJ0u1j9XZHOmroS4XBPzl//YFf46AU5XP+QtiA+wMopqQPFsTTU5rOEOhM/7JTArMbnXgrkdH8zUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054850; c=relaxed/simple;
	bh=rdK2qw985cCb3CvKPag08vE/HSLcO3z5k3HRzKq+TIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CV30QBY3PAVn2FxblEaY86xxAPGt6/eNW4aojE55yxdWpwyUh8yLlkY6abGz1yvFF8buMor01705FPMDoFzBWUDN7BOK2LRvHJ4n1aulK+qmY+9RFjoOxKh9Jq23hlXXpcP/FnIXPJP1zy83vIQKOj/eLi6Om0On+QH+dUm4Snc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y50SjU4E; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6IHNIEIVzJ5V3QW/YeSlncz0oTauVVf1EEgDDfkjdIDO+jBSuCzFLKhG8nVUF0pO5AuhaRCAIyVX5XU4Z4Zbb/NCVeFN1Lz0MbY+yxjdNIYpmkqKA7Q01rrPYIxVaUiaWTw4mXOmGKkaE7LsHiCRJNIGc3ne9cAi/N0zWt4R3kdQw8cQ0jCmfvoqUTNQ9ZwfrxNG+vBM19qveLe/aiFIlhczwD8ynyr76GiXpzFp/M7RStk/zyRtBAavbYrbnh9el2h6cwXcXLtMePfu+iaLmlRplCmH5hGjjLOikb2HytWbfTrQ4CW8LQw68lURtRQybRO0OFC7mmJ/wBbmP8ZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWy7i+ky1nysPlC2+xdmKw01pz38JmyRpSgcb5AGb7w=;
 b=TQya2ddmYKkFvKE72zfiB/mz3aZCh+FcKez1rVZ4M8lyY/0ARh83uGaWJAdpqNw88hP3thSLwheOnyiAOc/3/H3f2hsTqNQnC5yB4R8UP0vNPKBSRAq0oGqM+OOw9f+rWukpv+M6yccSksybT8YaFy16rovAuzAnNQKIf2nA3Okkn0Xd1NIjdF6yf+JjEXhKroGim0gEHbPJq9ux3Xr0SSXt5PdKA6NZm8OvxJRt0YYwSUP09OKjQj3/m95ZnWeUHdFuRQaDncnGWhqJJwVR5WiPwzpnLUxt3AVyj6FX8g81Al2th1oWObe4Ig14wkkpmnAI5Eo0eAwm85fgJtDf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWy7i+ky1nysPlC2+xdmKw01pz38JmyRpSgcb5AGb7w=;
 b=Y50SjU4EWQb/5YAYfHrB+jP1J06zkfiaGcGH7cRFpRvg8yHvibRNkFSn9kylUkwDJGMQbcFR5pOHWtKcZrX/L+oOSz9hTlcrAOlWjAJK7zScgV6SpidzpBDPASWFuyshUVRY0jIUSUU6MluV7JiYqSVfhjo346+OhdesPnPLfKwOifDSHOUbrEKZGUltr/9rtcpr+Pw4/bTxwl1qkeauUOxS4eWAswnn646DiZatr7C0EazMQgLNeyksqGp7uJqcMwFehArQqHnwCFsVxIqcboBEF+2AgFAf5WCImhdqDEZ0KdZ5nQEyzBxVPmvTImX9C0Y4OBnTEssrSyjQ+ZPqbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.27; Mon, 12 May 2025 13:00:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 13:00:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, akpm@linux-foundation.org,
 wangkefeng.wang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] mm/truncate: fix out-of-bounds when doing a right-aligned
 split
Date: Mon, 12 May 2025 09:00:42 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <D62F0A65-74B0-4607-B1B2-DE4AC61B1AD6@nvidia.com>
In-Reply-To: <20250512062825.3533342-1-yi.zhang@huaweicloud.com>
References: <20250512062825.3533342-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:408:fc::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b87cde7-6894-47f3-3b8a-08dd91550199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Qkhq3rPG/oYzThg0feHdRBw8JAS/enYwgqUOtbLj7x8AilCDXns1rNwvcdL?=
 =?us-ascii?Q?4CtOH0Pn9c4ICGtLfELJGGY1w+DfkANblKJBdDjYqA0Hfgg0bn2VMVcHsaMm?=
 =?us-ascii?Q?EYSVO2X4fBpBpQF44Ecm7LQyn4f7Q6WBPzbQ/HbXH+RVATpMXNUHNifySHHR?=
 =?us-ascii?Q?TBpm1QuSR51GoE33ZVAZKl5cCWeB1J954GU0vg7IbJiwAwpJy3HTFguTa5De?=
 =?us-ascii?Q?RcpLfMEYNxsRGa7ybL/bieUasAEsRJkCScDH+S8T6UsMBJ2qyebOzbRlirU0?=
 =?us-ascii?Q?OCk5t4EJ8rP/ldbqWptnk4xdDFsaJ6OTtDzQ2zMI5hGGle3FFdDzMl//458e?=
 =?us-ascii?Q?F77fvDXLT+Al+izfPeCePcCn1knaIm8ZfPbgMbAjRVSXPvck8M/8t7dYHznS?=
 =?us-ascii?Q?ur43sRrBQ8RM1fcBHLKCXIW9hgDK4xWJXOFq2eGTocw0iLZhAfPvCR7kQB/A?=
 =?us-ascii?Q?IRC/jqwnZF1+w1Vu+4pHvWa442nAaJdbXHSNrKxc9DptYIECMQzMyRB89cjw?=
 =?us-ascii?Q?ynipIYbSv/1nt2+oLEP0+08pTyi+aWiULteDMwnpSjR/aVx/S5zMf509jEsw?=
 =?us-ascii?Q?60dlPueFFbPIUbyp4U/URZjHv8MPOfjMA91pD/0FE7AbaSY2qGg1138etrqa?=
 =?us-ascii?Q?yMfPnwtiHxOo9hMJahQNVVu4JYjJPeGkH2qI03K5k+RKSWd5WMTXxIvIuxvB?=
 =?us-ascii?Q?Vl7GLoQ3ewkWA8Bb2YZm7MzlpsWvkIEatNCRlO91NlpJrx3vCEHeBbnXo4pr?=
 =?us-ascii?Q?+xSEic9OkZC25UsVC+2Qz0AmTY2ncWyiatMCyRF7TFbkm0lKLPpUCQo+SC5G?=
 =?us-ascii?Q?s+PKG84c1xwaFfbc8K4Vt7U+g1USjFqiOK9iCnuw6QM3bkKEFfKGQAvYpH3E?=
 =?us-ascii?Q?P4ilogP1BU1Os3aj5ibZvh6eLk0YG9s62x11wiVtZp4sJzCXy025VpGAT1Ba?=
 =?us-ascii?Q?YXOYLmZ2QhxmeUVCDLKDftW98MKpyHhzRavvcOCyn3Cwli4plolII7LhpgWN?=
 =?us-ascii?Q?WOsQG6kFTeEcgV7PXnWehryuq9nzPhisl3mtoubSxzQlHMcb3pGc00lFKv8U?=
 =?us-ascii?Q?Hsc24JaBqlWir7EaIIKVboR0S4iK/m2ENdGq2e6osYh5+3JpT5RrIll8EK+l?=
 =?us-ascii?Q?UvXkj1uoyePElpr8hob0aWOY5u8TWZVHdTJHAxdYPB2v07fL/CcK6awIRjNC?=
 =?us-ascii?Q?2Ifa0cENN79hM1bNNf8PC7iSkLx1McbslFc6WuL4KH1nM4I7IalGiLUs47C8?=
 =?us-ascii?Q?IlLLqLGfqXUS19IFURF1o+fytn5IHOGJhjX7ATpW49VeliGv0/41vSAQG3OK?=
 =?us-ascii?Q?YPQ4KkRM+QulRy00ZH09igVCzW+EVRmkY4WJvmoJALGwMjtoXLgnoIax8olh?=
 =?us-ascii?Q?DZopNShkP9FKV+W4DNwxfjZS83eUD2Ep6lRY2w4kP2WvNp5xM7a50g37TX+J?=
 =?us-ascii?Q?RV3fl+9+TEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pWIcFmQqE1pIiynIqHumpjD8kNtJaBJsxVuuig/YgOTRdOcN96P800vfelbc?=
 =?us-ascii?Q?ye8YXr73bKVRJxHv0oJVypr57Zq6FjzhUBjo21PI+LY2FnJNFRsFDCVtIh5g?=
 =?us-ascii?Q?/hKX3ypq98G18Ua68T7hwgJPydXOkaGDJPpBdgAPw0LgBdj01ZkMoJchzQkq?=
 =?us-ascii?Q?6sWLecnThMsXHOvuRxVVdj68EspkX2Bvv7jkqN75XrPnzMSxoesti/VrAB50?=
 =?us-ascii?Q?pAH6g44MHyYHWXb/9I9cdhzf5nvttW8L5qhGGeOTDruH6Om+sVUouMvAdGOo?=
 =?us-ascii?Q?nqQhb19yR8R85W6OgHtdoiOlwjRTUfqXEUMj0shw826UwLwdOA8fa4hXx5Fk?=
 =?us-ascii?Q?WdFw2JnV8YIQ3cuDiJc7JRSsTS5rPNFJJWed1EHJND3L6RoySwAE/2irpXKk?=
 =?us-ascii?Q?s3dFHYkoUAhJt92jdkFBtJyNYmrSQnXVgdngW9uKD07QB9M1SVcC32hKg+Gi?=
 =?us-ascii?Q?Sojt9yvfShFEjxtNiY/E44r2eHFRPv9lXZo0cLNsxaZGKDh1Hk51Pw4seaQF?=
 =?us-ascii?Q?8Ls3HKmhQkd/fPqsy/mBaZQbW6fjxCXJFV1yXNPtaelnOzVrIcxqBpn+l10s?=
 =?us-ascii?Q?DNm+8VzmEkV1UFHQNUr0IxwiUCiyT7kX8E3d6tRsYBmZHnsAZvkY3yApVYY0?=
 =?us-ascii?Q?JjMvwVQgYpPaiQaz2tIW6HjCf9sAq0fuC2vss785aK5aO6yQ0Y2VGylLSrgp?=
 =?us-ascii?Q?3zUf804tIpdIgVCJ3zp2zyDXiFEapFPZN/xAm/EdqnmqaJFvspWx0nLTQ/Yh?=
 =?us-ascii?Q?wBbvT1U7KoKfDaTKQrGhuIw/QQxdrImeAPyRyO97irJRVe4KFJKmAJ2TPDZB?=
 =?us-ascii?Q?RkA2Wxz9klL2MzZG570cjhDNtkZU4lsqqvYFQjJGCTmY4S5iQ8yi7zvHw20m?=
 =?us-ascii?Q?2eIan77HMZ9uEJuLI0E2cIdvA7wLC9vijuYo5on/SeQ38zPp0m2sUD+mndty?=
 =?us-ascii?Q?rBBTgy5PPFpnnLAe54Ck46iwefy8LMSA8oPstwJkU7znnuJdHfzX8y0lUJ6o?=
 =?us-ascii?Q?wN608EysD8hBsWyTMpw94r1vtDQEsAIF/JwruPVkD8RtIwJF0JohTDYwRMhX?=
 =?us-ascii?Q?xaR/Vv9WjPgWpCkdYXmfsD7n/Ao2RG9kDQ8lKdpIARdKyrzEvp+OJ6FwCkR5?=
 =?us-ascii?Q?C1o4ePqnjtwtapEIp0lLasK02XCioE3MDIpN2ddNcCojBvk1pwhDiVsnboGe?=
 =?us-ascii?Q?Mvx4l0h9EVC0m61RNnuq/QuL6wrPghXxYAaDMTnLz4BIeBRcZw1YXnZ4x+Mh?=
 =?us-ascii?Q?6MAul7Ivm3WluVc2LI0pVdQYxHovc+xVZKntmsyUrpNdvQ+i8QZVRsat+cyw?=
 =?us-ascii?Q?Lr4Sk0e6rTqntUBme+hcjHHn/ql+DU0ukVrHK5m0kU1q7j+00ZoteimDhjeL?=
 =?us-ascii?Q?hWngZ0SShpLDlIpTTCaUqtC8jgMEN9BxCwHLfiLMLAS97gPJi8c6VyanTyHv?=
 =?us-ascii?Q?ixy1xOVcGFNUon/U7g2CBr8DHVytbOcArcL0N3eJDhpSXF3Re9OYOPm2+8vc?=
 =?us-ascii?Q?XGvBmrYAQObwoH6gjIQD/YPBngKLgg19qx+OsdX/5mAZzdJ1WjDCdh9vYDXv?=
 =?us-ascii?Q?cROnPP8e1F/0PfUsxfzjT/vaKuTzHzqHLw9ZWQmg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b87cde7-6894-47f3-3b8a-08dd91550199
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 13:00:44.2571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4psUBKFTGFqTJ6Bdbdw2Y9VyzW4tK5pMoOWIeH4Jh2C9dz6nm+Xdwtqc1aazH97m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

On 12 May 2025, at 2:28, Zhang Yi wrote:

> From: Zhang Yi <yi.zhang@huawei.com>
>
> When performing a right split on a folio, the split_at2 may point to a
> not-present page if the offset + length equals the original folio size,
> which will trigger the following error:
>
>  BUG: unable to handle page fault for address: ffffea0006000008
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 143ffb9067 P4D 143ffb9067 PUD 143ffb8067 PMD 0
>  Oops: Oops: 0000 [#1] SMP PTI
>  CPU: 0 UID: 0 PID: 502640 Comm: fsx Not tainted 6.15.0-rc3-gc6156189fc6b #889 PR
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/4
>  RIP: 0010:truncate_inode_partial_folio+0x208/0x620
>  Code: ff 03 48 01 da e8 78 7e 13 00 48 83 05 10 b5 5a 0c 01 85 c0 0f 85 1c 02 001
>  RSP: 0018:ffffc90005bafab0 EFLAGS: 00010286
>  RAX: 0000000000000000 RBX: ffffea0005ffff00 RCX: 0000000000000002
>  RDX: 000000000000000c RSI: 0000000000013975 RDI: ffffc90005bafa30
>  RBP: ffffea0006000000 R08: 0000000000000000 R09: 00000000000009bf
>  R10: 00000000000007e0 R11: 0000000000000000 R12: 0000000000001633
>  R13: 0000000000000000 R14: ffffea0005ffff00 R15: fffffffffffffffe
>  FS:  00007f9f9a161740(0000) GS:ffff8894971fd000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffffea0006000008 CR3: 000000017c2ae000 CR4: 00000000000006f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   truncate_inode_pages_range+0x226/0x720
>   truncate_pagecache+0x57/0x90
>   ...
>
> Fix this issue by skipping the split if truncation aligns with the folio
> size, make sure the split page number lies within the folio.
>
> Fixes: 7460b470a131 ("mm/truncate: use folio_split() in truncate operation")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  mm/truncate.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
LGTM. Thank you for fixing it. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

