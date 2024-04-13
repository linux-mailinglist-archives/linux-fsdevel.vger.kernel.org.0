Return-Path: <linux-fsdevel+bounces-16871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605B68A3E5B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 22:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434621C20AB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 20:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EC854FB5;
	Sat, 13 Apr 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ccn8w4ht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8976B548E6;
	Sat, 13 Apr 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713039155; cv=fail; b=pNI607GHOgMBkA+yH5z7zSXquCNKr/P8JhPe/gRjYNJS7MelXcZt6o1TwdE56gwr7SbxsQigtzXczNNMmmKb6jp8aJE/YR1wXHX7e0rvVXMKE5X7zSMX3n8CbAAVBtwG41AT+ks0XTKXV2vkD/h5I5xQC2Jol/le9HhjNcdS7vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713039155; c=relaxed/simple;
	bh=VUOES4TS/NFTFhKly25Qx2YekhUp/wBZqIgUIb4dJ+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GuhoZqU38Ds2h4Q/05PITBcv+dtp0PYJyVx0qrzB2m8uTTDMwc67XMgYTtYwLlrhYDB6Hj0TKPmYzz5EK/ggxtDIdH5/uuB3+yaFOs2OHc7TjU6tGgXywUjzo4b8KN9MOoEAS9y0zzfvJfAa0rtxJBqqSBgUs3nl4QhV9pf2zNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ccn8w4ht; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUEVyDVbrG8K+tLel9BNv4Z5t63FwSTOmz+g+XXdF8mjM/zzhgrwCmTsqhQdDqif/zfjsZT6o58CD3M0jyJ5fM25mIXbWV06EhBpaLpcKhxMpdGu2m19xAK5KqQmxY1hRo1f6V+mi6q+17JdrrSf9y7ayMN4l0OWVM4A31QRtSWv4Q/15PYcQrURtMGw2OnxfBcZKqyD1HvdcjPhxUtofn6K7Wi4HrjXO5nsGpUn4RNnhyEFjM+0fe+eGnotL3X9KHrgFVuxouMfv8ncM6JyDV+mPoBdF/mAqxQR6U/3vBdn5Vsg8LYsk1CwBW4jF6bbXlSyp/zpXJV9MZBtLF52KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1dU1IB96tlkruBZtXgTUb+RzON86jsl2WlPUA31/EM=;
 b=Bn0zXH4tziyPmaKbZkrgs9omZ8WiZVlS1tKnS88lGIQ5OhIYNtLuXGEJ+DSY7MsAOprAj4XY1VY0gla24gPXQ0IlgwJHBJFCUfi4Wrfbiw+ADsCICmuJPlMaIbzpZsPGdHiPz0wWfF90syl0NuD4YC2id8Bg1ZvpXwH2kX8Duao8nSHorLGOk+NikIvavOxG9P5XTYDtfu0mfL1+gG754/Hs0nLsdb5L72HcesEDsny82syyTbaxhWiyIs4F3LvRx+z38zFadI6nUehkvOOSt2nkNZ0tQr1RYs+oYKeJ2OKcm3Das3hKGZqYKRJ9/l7XjxSktmIZx1X3xqpyi0G78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1dU1IB96tlkruBZtXgTUb+RzON86jsl2WlPUA31/EM=;
 b=ccn8w4hthDc8Um+YTEHRtzpYLIj2iYVXP551udB3zmidxNG36Q42KWV0ppUerXx+rDn2G5rGN09ubudDFuDajew1LJTFsuW7+/vHh6fqxLyPP0QyRludIEQ1znk7sLxSYCEIai2q6U02AyP1qthy6vBGE2i7npR3Eqj390J/lD7/03mVJEb9w6E1+cdxBOofpW34x4G3Fdxzz9RneVnwF+YNNzHDh0swIhpevHLIFaXn/K5yv7+I9mjSKtuuYD8pER+miLlCOi6KVDtRx1H9G3PybhAd1IaoQiGmAXxA1vfrZTi8U1NvmVfTqgS7oiKJPo8hyRT8hfwOFftD1ltlRA==
Received: from CH2PR02CA0030.namprd02.prod.outlook.com (2603:10b6:610:4e::40)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 13 Apr
 2024 20:12:28 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::6a) by CH2PR02CA0030.outlook.office365.com
 (2603:10b6:610:4e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Sat, 13 Apr 2024 20:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 20:12:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 13 Apr
 2024 13:12:14 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sat, 13 Apr
 2024 13:12:13 -0700
Message-ID: <d495cdde-71e9-4476-acbb-5afe05229ca1@nvidia.com>
Date: Sat, 13 Apr 2024 13:12:13 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] mm: use "GUP-fast" instead "fast GUP" in remaining
 comments
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Mike
 Rapoport" <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Peter Xu
	<peterx@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>
References: <20240402125516.223131-1-david@redhat.com>
 <20240402125516.223131-4-david@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240402125516.223131-4-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: a0aaa0a6-70c6-472c-e044-08dc5bf60abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MjNVtL4LM6YK6isq4wiC8G4q8ELWNqm50rFIV6H+AkQtPk+GNTw1bypC5EjFciw0xtsNof2pxnozwmce5kJhp/UKNGsBchZdVd57/QS3woqC9fpotDv8P+94mug9Qf8sZK8laLf1JDgSbzCi5zTiKMN/k4+uqV+wEkI9OEsegekIJXERp4onv3JmvZGJwEh1NVivpGH6lTzllKAnK/xnEacIOgtAODTrv0AdzAzyF9ds0wG/RndBT+dJI1xQzJ0E9+NhOyM/jJAzNKmRzKchsEE3dTMroOA7el2vmvBvx2JB6qy21uRQeNNivbmCVZH7jkr6HvyI1JjiEYb9XfLnc023Q0V1r6qQkxB7J2q7vAi9V57pNTfjqwVnguB5TlqwZ+hE4p7q7aqolWpHtjZEOLDyGmPAuavVXib7XqXKjG3Xh6DFUOxLSIvVNJ0Zev4v17HsRH0/UlyMIh/X1djxTtymLetHYnTv50FYvUWayq4Y0S3mwe9J6WE17YBbZCklEmiTKgcvuZ1Gc33DjkjdSrdMT30eG0/T6p4YtcWU3n/WZUNnsRiwuFxHicp8MsLNN9aXbMOa2CUM0/1G+nloeyJ44xMZB0/FBVOaCyAxZeMn8o2vOmMT4DUOcPykhKwQyJ81uQq3WBLkfVr+6HWpsuJhKqSLfPCpBLTNC24e0gnSvqPkm387Me51zAyx+uC0oeFRFtx4kqrgAiWY0zDLntM4WVVzD2Yw/grQJCLhM+s1mY8b6mRGtqVG6+U8buR9
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 20:12:27.8478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aaa0a6-70c6-472c-e044-08dc5bf60abf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918

On 4/2/24 5:55 AM, David Hildenbrand wrote:
> Let's fixup the remaining comments to consistently call that thing
> "GUP-fast". With this change, we consistently call it "GUP-fast".
> 
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/filemap.c    | 2 +-
>   mm/khugepaged.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Yes, everything is changed over now, confirmed.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA


