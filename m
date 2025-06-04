Return-Path: <linux-fsdevel+bounces-50612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D47DACDF76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 15:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCDC3A6DE1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98824290093;
	Wed,  4 Jun 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aV/l9+4H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214B1C5D62;
	Wed,  4 Jun 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044455; cv=fail; b=FMDp2cslCBB3cvmvrKj9kBif2tr3dN4ki1bm5cfjHAvFILvz+CUkhyXVoMh2UhEfB2cQ9JtpFOSdCSAu/oanT3P3eba5LWxyl/zYhE7x5tWHLnHg5YeOgQhvn3l0V1ssHPDfkd8F3YnDt67B+6E8VDYEGo/rSHJAvjB0/5vC5QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044455; c=relaxed/simple;
	bh=CSSatPtAUWF6WbFictTr6qNOo39dPwGBoplkztWGRNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PDlQvgTaT6eGGfJUciRImMt2iNSBBOVk/NRD4iVTEZtO2MqDmuaZ0pNwqvZMXmyMG7KH5JsQl7cWOopMj6sEUQSN6e2zQIpkdGWMqHoUdTrrNCKJ1lXvEk590PvH+3C2uO7yC2OXHDZClfFthL6UTVHmbz6NwBa/9BHGp7OLDTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aV/l9+4H; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcyvLKQ8P6xSf2LKWGqLcuyz/KyhgruZSrffH9kei13MhJuJFrEY9EBSvwmB0iv3VOjLaV1aVu9HaJ7lC3UvK+WDoBx0g7oQdU5bj8tv3Jc/yKPihSXnS8rfpqVWP6tPDAlNF1iRoUTttKkVwRaxNbZmX2AO//tEUMfVOnz3eJE+tdbKJZeG9X4zxda0YI+e9Oggw2g5jAOHUB0qM88B4R1hwoynS5opUDu0DwGfgo5c1QBUJac5sNO+WzwBxxaFwZO+JM09+FBB16Rhg04HRbfMFrNWynA2zOSp8VqsCri4bXCVDKM6FWs4FJQsGSdsA3SrAZpBLWrOJb/GMfCnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc1HW1jVZKspUuFqIMWi9LdsQ4Boe4Gb9laAUy1wwgo=;
 b=LYwSNTwfbCqUtosgZJ5XczPwSRNAU4eDyCbgVPu0UJmyE75W/z0MLlXwcaMEJQFRBl/cq1EP7tLAC9jqwddlv3wzpNdxz9yCkl17kdicQmKfEIMy65ULP94B7xCwVAJpxZOTQ14GXD0tFh1iYWqvdz2JG7LCmGZ+75W4e9V1Yluk5j7+2P1Sg9K6WyxgseFHokUxP6xgyb7iQTVj3apXRGD2VD6s62rv3Yba55flUiqwl00diaovSQSEAkwpsdWUtJjLapAVovY72u9sIvVI6XschBkEbtoyw89xUufV74ho7b77MNynOxgRXlEdCt3+vRZ0BjVh6xxjdfzZbEaL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc1HW1jVZKspUuFqIMWi9LdsQ4Boe4Gb9laAUy1wwgo=;
 b=aV/l9+4HffD2BYrbvTNkuZe1rCx4uCjJHEhJCXFW3rAOLoLK/Z1TfJbWjDZINGjeRbiPmokUk73GTXHrWS6axiVr7/gGwmRgBLxVdljyjiV2FsMOw4rX5+I7sFsYzNJ3AppRDy8wmCFYI7nfmI0Bl6+5ygK72J1D3CssLShfwdgmUXIeBQD2YtMKrZnelEQiyVt9PD+Xuljzn3nGeW87KzVkadVGhQ2E++6YLd2/EIhLjHx4TFn7H7p+9VMP7k8uQx6nvIEfYhtr3T4LUktyBj23zi8qbgnFO9LXE2QMYxGQhQ2wrURLUuVPFeJxBZaE+O9fuxRFAKKSXEjKbhLuYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 13:40:51 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 13:40:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@redhat.com, anshuman.khandual@arm.com,
 ryan.roberts@arm.com, aneesh.kumar@kernel.org
Subject: Re: [PATCH v2] xarray: Add a BUG_ON() to ensure caller is not sibling
Date: Wed, 04 Jun 2025 09:40:49 -0400
X-Mailer: MailMate (2.0r6257)
Message-ID: <3D370CEA-9F26-4E6E-B93E-D26F2A4A222B@nvidia.com>
In-Reply-To: <20250604041533.91198-1-dev.jain@arm.com>
References: <20250604041533.91198-1-dev.jain@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0498.namprd03.prod.outlook.com
 (2603:10b6:408:130::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: cb69d350-b85a-4719-a9dd-08dda36d6bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J9/eikDILAFtMoX0He8Ey23AmPe38z80jlY9vR7NxiVkpwLfe+yANaI3HhE0?=
 =?us-ascii?Q?pJ8RR6+chfcPA85951YUaofQZGHKmyCe0ZsKccQijECmm7JfXRWIfsHhYgYu?=
 =?us-ascii?Q?vRnzdvQg0/y6JigcTFuTfZhn4WtQI8ux2gg8KPhYLPuxu0iKn25sZVfKaZBi?=
 =?us-ascii?Q?nNQJaEK4AK/l1beRuDIyApp2IAIJ09hE/wBAfGuE8thGyuUGxZu8w8fZ1mBW?=
 =?us-ascii?Q?k4YCfvrBmT3GkoXPC4VCfNyHZTfNsG0Az4sph69lHWeaqU9e9sBPrVwXWQNB?=
 =?us-ascii?Q?bWmm5S/JjyQA+s5loVOtggMQwgRBGyfC3/Vj3668DO8U4O3WSji4OCGWlnMn?=
 =?us-ascii?Q?qO6eV4/Kz0Z2Sv2EXQTSItMM4JS24Ss/8sZ5q0EO9eM0/DJoimWkjHoPcFK8?=
 =?us-ascii?Q?jz6pfwGtvLZ8dS4EAAa/ankJfGiYvHMfzz9KQoELhiBIoPMJugLJYJVWJwmC?=
 =?us-ascii?Q?1xfCS/CUeBC+88AMYl9NQei3PjkispgjDIhjlEpFxAHaoqcDCWctNcQNbjyT?=
 =?us-ascii?Q?UgN4Vy3P4efCArPTnSO7Tex1oiGgbqoNSTu8TLs4BvwngfeZlzOSwxV99Ukm?=
 =?us-ascii?Q?wJkkncRRYn5KGcgvRwCuw+yOPYxc2EaVSnR6C5jP1VtJVLi3u7qGgR4STU8E?=
 =?us-ascii?Q?6IITxw7+vyx36va36xZsujDy/bqxSzfOUyVkLF0Km1BvVr2LK4BZqneXn2ag?=
 =?us-ascii?Q?r3VBnT4UD0sLZwiORV4bttkgy+rQKFkwWjprsXwAdN02Iaj4maxSK9GtEEeV?=
 =?us-ascii?Q?ypMzUG6LKn1RSGMcliljhSVHmASiKO1wJrwy+DXaQYwrUX0hGZo33GmPdGNf?=
 =?us-ascii?Q?4T36/wto++DmcFyg6ApHAT3651OzihMFfe/lsgk9XQOzEB+thOshsD4aiIHC?=
 =?us-ascii?Q?YKh2kXIHm6C8+O3bfV+tpaXG7p0h/jIwWlfGjHAju4kriRuTRelWG3gi13Fz?=
 =?us-ascii?Q?7fChxLsVUAfEn9w/qg+WVMrCsWVHIMTUlEOx4w19KWyD5b3vNfmyYsZ/UB52?=
 =?us-ascii?Q?cNrhy7WS+sj72uZ4GyM2wUTPgrSI47civpwhn10/84+iVFK7g4TkPTUFt3wz?=
 =?us-ascii?Q?S2iFZe7+UU8ZzjFbFsNoW3H53YgTdvO08AWfptS01WlfD67KxOOJADlyf4hx?=
 =?us-ascii?Q?gc7iyz6g+2kuesKS+qXgabXQL+Kn7X9r/cs7EybctR8F/yj8u7zBU4LbkJPc?=
 =?us-ascii?Q?DHsjfZy71P5/u1EGEoy3YevKAp1FsmzjUCWLf9QgYoTKTOYFJtvkFzoImJso?=
 =?us-ascii?Q?4uzt18z7EzL6YyJT8nL8cqf6AYdc3skoVtM489QcqNoxvMjDS0LSKLIn3nyZ?=
 =?us-ascii?Q?TancQxno82eAZWU4ecTBksP3pt7VLy9vIGiK3L2ZroeXfz2MdP7CjWATFdQw?=
 =?us-ascii?Q?SuNsNZd2dY0PzLeoUGkJUTRtZQxPMfDMujMpDkWxLzcwcgsIdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hDtL+GCa1s/5SyFZb+mMx2QQzXBYJ5YceNI5cOEMwCFdraeUXCVdeE5d60by?=
 =?us-ascii?Q?tzbo/TYDYknMmPh78nB2iTtDmznWt5ZwNKV2tujN++Xsvu1XfeJPsP+avByZ?=
 =?us-ascii?Q?byyHbFF3G7hY/mYOA2j0d/vWK97GCig+68bMOIaRPDOvH/uaGgLq0L9wOCeU?=
 =?us-ascii?Q?pEx8SnmksC61ILc6a9mmIOrA723uyJ9Kq8/CM1k0UIUQ7sBOaqtcrwsfvDjq?=
 =?us-ascii?Q?jKQ6Y4yMJqT0lgNHyblXUaz9X2GGurEhRCZ8HeUFzxWtW7frsE4biEgY3qAH?=
 =?us-ascii?Q?DfsQ6QmTduh/hqcgCHnvBP5xvrMpylSvm9/UO2pWN6ispAj1BlEuWAJhbPIq?=
 =?us-ascii?Q?Im/hhbnyWTLcpZD8L1tHCQWTv8VnyqDuwLH5U740FqrpoyXHSBxLVICFLva7?=
 =?us-ascii?Q?tBPNOTnjoXIlz5iQ56kH+gGkjeznK0FKxZVLnur0YUx79AN4dr4VIRAK1KUU?=
 =?us-ascii?Q?7wRvSBN618vpRB1fpYCG8oLiTipWmQk9DUHu4hqyja12cS83y5yNrfgmUDxT?=
 =?us-ascii?Q?rwnGCeVWPwIELvPWcXRwoUW1+znTYL//SnzUi3nGINfitGzMgaKSq1qlOMBz?=
 =?us-ascii?Q?KUTw+pWt99fPUVPlq5vUv3xq6LyKdIiO3d0ZFIYRN7HklG2598UtHFpdL7E+?=
 =?us-ascii?Q?scuocTV+14NEuQprLe+B+/61WqI7ztwaz+1pN/HYVAmqj27DpK9711LZyLQG?=
 =?us-ascii?Q?tVysVYrJ6Y+rZCxm9p5bw/EnyZ5epF5/KKmTwyeo6JOq6XcTJDOrMQa5Scqw?=
 =?us-ascii?Q?3JrekUNIihNxMZa6g8s+yb1MSfOGCXZEGSo6bdH7kTMzzkO4bzJuCt5ieD0/?=
 =?us-ascii?Q?Uqm8u6bZzrdPfMmF4n75YC2XqXLZN+LS5mCHYmiHuSsMnfqij2HPnnUVU+r6?=
 =?us-ascii?Q?TOYvSA+VVpLocf8mHrPYrf8qkT1KIbZ7VmEQUO1SRMoLK5luqxu07XxbqSux?=
 =?us-ascii?Q?eKlt3LbYI7k8Sp0Yd1ORzfxMukgNqQU6wXa/HhyinHlW915grpsk4aDpFfDW?=
 =?us-ascii?Q?3PjKN9YzKxL8ugC8oI0dSI/IHtgiKIVQD+0f3Ma6y4KkuYpE1cSzx/Fxs30+?=
 =?us-ascii?Q?YGAPpXZdVWmdp4Q1DCdNz/5h18o3d0Q4Pv45UiFqehz2JzYMr4dwoJpurX9F?=
 =?us-ascii?Q?XyXplglWgPaMHf2E/csBZ1w7buMGBe+7Om3a+HBUCj9VZsgvXG2JBVTEaJCZ?=
 =?us-ascii?Q?T0CPuHHx2PNM+mfXiA/Mvb6oatoA8puy192T3tVxw6bQLTjltrXYDb32KcV6?=
 =?us-ascii?Q?bwkBv0MF6uwPEDPtWvbjeI4cQqddzF4FIbbDk2fPEXxBRC7qeRNzv+vZL9ou?=
 =?us-ascii?Q?MNELGKZlRSGcfLKIuGlbl9nZ4cC7fNl35QNMca8UtiQwcqMG/eYUhfUzDyVm?=
 =?us-ascii?Q?O6tIAi78F4V0E92ohxFAnFzxbicVWDs/t2cLwRJld0mKBqU/h6LB7g+QMTK5?=
 =?us-ascii?Q?PxXFF/I9UgjqdduwwpcgCFoKGBMVeX8FBr49iJZkyL+NVwgYSyogA7Af4qPr?=
 =?us-ascii?Q?UgpUETbB+bMouA/sVFG7XMD3WlJmIHa5i+9qZIcsT26khzb+Q+QgCAD1wuYs?=
 =?us-ascii?Q?PcRk+Fo27fdbYL4zHYFBzMeii03AypB8DlFO2Qtb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb69d350-b85a-4719-a9dd-08dda36d6bc7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 13:40:51.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yWc7F7fw86EtMZUR/WDCtPubm5P8yxKhyC7Y39wwhW7xE94QMBXqJKC66g7IrjD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941

On 4 Jun 2025, at 0:15, Dev Jain wrote:

> Suppose xas is pointing somewhere near the end of the multi-entry batch.
> Then it may happen that the computed slot already falls beyond the batch,
> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
> order. For example, suppose we have a shift-6 node having an order-9
> entry => 8 - 1 = 7 siblings, so assume the slots are at offset 0 till 7 in
> this node. If xas->xa_offset is 6, then the code will compute order as
> 1 + xas->xa_node->shift = 7. Therefore, the order computation must start
> from the beginning of the multi-slot entries, that is, the non-sibling
> entry. Thus ensure that the caller is aware of this by triggering a BUG
> when the entry is a sibling entry. Note that this BUG_ON() is only
> active while running selftests, so there is no overhead in a running
> kernel.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> v1->v2:
>  - Expand changelog, add comment
>
> Based on Torvalds' master branch.
>
>  lib/xarray.c | 3 +++
>  1 file changed, 3 insertions(+)
>

The added comment is also clarifying the function requirement. Thanks.

Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

