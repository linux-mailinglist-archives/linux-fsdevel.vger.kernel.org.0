Return-Path: <linux-fsdevel+bounces-47740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CACAA53B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 20:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1F318882C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 18:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CE7266B52;
	Wed, 30 Apr 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Ru9AMivk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020114.outbound.protection.outlook.com [52.101.196.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF31BE251;
	Wed, 30 Apr 2025 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746037890; cv=fail; b=UvDt/tyVHsRHhDlG/EdT0vWqjq9+cCoqrRHNXd9n2yS+6GYZNHp5oCtC3l1R9cxHDUZsOOS4YutXHzRgnn6bv41VBF1iCXJ/pGCaTBHWPhbIKx0ur1GLIZ72tZ49KSw8TS2jGQhrxBPT7paBAbGLW4u+OBDUY8IdWYV16ZQXpWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746037890; c=relaxed/simple;
	bh=ig//NbrhfvuC6P9eIgPMeuFQSIJq1uYCBJ49Vtt+OMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QrQZuz0B/FX2nP5EAGYHANlcvy2k30uHiwP5hw8QOipXQxloCWnDKrzj/+PoCNx7nCa7R5YlwJLB3S4tGfc7C5HsLC/VKNnB418/8ayLmzzDCJAKwGVmsbMuU0Y28uDoBGjRtaB4CYMAB9f39oN00Y1bxcxEAmBSYduHG59HNyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Ru9AMivk; arc=fail smtp.client-ip=52.101.196.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfAGssRGEARGJR3ujfTU0bGcXvu70At78hcpx5nj0xYYfPUxjTg9xV+p0qSI6uLpYfYvtjMCoGz0dUkn0v8B1teGyceQzv1T/NHkKBfJqg4SyJrLqdYmlEMWBsU1MlkE1bMFwnvujC4HCkjPc4pXaHmwxn46XrcMcAntKQWq34zxsL+97t40dlI29mxU8opf5hOlJTNlwcALw8hXzgKFtR042tM7fWEK/Ci9MbKPA8ZIbdDngt4ZKrGlDSS1nrSkaQu5c7PCPjvgTdmjcLPWx7fiK6VFsef5H7Yq73N/K6jDPvQybucFJ/3dX1dE73bFXimgRmEQQKQcsDEI89kMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N2bdWskdT0R26gCa/uT7r4PnXaUWyVTGVEAYSVGXyo=;
 b=jG6Vr30QD/uFx83b+0hqYUpMVJqmY1B6ZEOpdxVkLYkyWWSeybbxfrqWQkzM5Q82RyevLvg8JkkeKP9x+W7tYivmofYjncrsT4w/yFO3s2TcR/bRvDRc1njduY9EgT4Oc+IR2vLeziLBCcNCfzyreIkLhHNdH7Wqt7+GmuKTA+zagoFZTT043fUXkljmzgdXJn2cqTHV8AMNY5nrDkw+3iHO0HozgzOVUZEOP6RN1/9kFwDmJ2VnV+Lvb6BINbi4neMlpmaIKq1oPXS3gjptJdmUqPVD6YdS6sLA/Wl3l8IK6do9e8X5SaJWMruz/FTIUbX32WVElLasPJ2W1lZc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N2bdWskdT0R26gCa/uT7r4PnXaUWyVTGVEAYSVGXyo=;
 b=Ru9AMivkjUv3c9PqZK+2Cg81NPpGYRRen5TupU0aUOC7SjK4bGev7dcoPMMI/RlvOBrncWfu3c/rZ8Y+ZFrn1ITe1WNx+7VqI+GIS45usX2Z6EBHuXPNhprwm45NKoEbAMMC5jVRwxro1/KmSPDMgIIwu6bvbL3viopXYHracDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5704.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 18:31:19 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 18:31:19 +0000
Date: Wed, 30 Apr 2025 19:31:12 +0100
From: Gary Guo <gary@garyguo.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Matthew
 Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob
 Herring (Arm)" <robh@kernel.org>, =?UTF-8?B?TWHDrXJh?= Canal
 <mcanal@igalia.com>, Asahi Lina <lina@asahilina.net>,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v19 1/3] rust: types: add `ForeignOwnable::PointedTo`
Message-ID: <20250430193112.4faaff3d.gary@garyguo.net>
In-Reply-To: <20250423-rust-xarray-bindings-v19-1-83cdcf11c114@gmail.com>
References: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
	<20250423-rust-xarray-bindings-v19-1-83cdcf11c114@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 1907b4cb-75b9-4c77-865b-08dd881532d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owT7ISVu2ALLbGX705ebkAq/YjO4XNgCclAr38Ovn3W+4sIE8te4EWvV3iBL?=
 =?us-ascii?Q?6Dtl2TQgPyil4vkZmXXV/B5hMi8EEDH5vv62qNVR34cy5zxtW6usBM0+dYTS?=
 =?us-ascii?Q?SswarqihmyeQ7U79NbF7Ti1v0/c++NwXlglXp+ihMynlTb+s8O+LBt89UJCb?=
 =?us-ascii?Q?SxUl7Xm7vOVZFjvyNqkECe+8927PmNsDWlnQnyhI1hACDj6EwjoKoQ4jpm/3?=
 =?us-ascii?Q?9tZFkDDVFExjvoK2DMzeEOB+wOrehMevThUAkHuB82AmgB/BkYEpUDzlcGlR?=
 =?us-ascii?Q?xqsum1UVMEfrz6xGcSqDgGMPX1F5eOVNzPd370FFj2boNzoC2oELinz49x9f?=
 =?us-ascii?Q?6BZvm2DS7cnXVLFYKy0645eK8h3+o5OTHrXPJnN1mPIMhQ0iznbymdtJ5tyx?=
 =?us-ascii?Q?Sv15nv+LDiPRKxtiIdV2u24dNA9oCVdCkETH6UspKDJx6kV6sL3MrS25/0Tp?=
 =?us-ascii?Q?AAE8GkmkGWJogQhrrcoIBjvkt9rRarjTqHkhZuhFRmpUVtPlKqRD4fyB2Hd8?=
 =?us-ascii?Q?nBQAioWPeUDLzGirgDvdF4NGdzubOBsjEnxiaUEIToSI9kE+lfHDCqaS351C?=
 =?us-ascii?Q?mrDvgOa929HxDGyd8xX7FXdErT7NF1tB9QAKww9zehlxH1mb0mgMMoAVTeoR?=
 =?us-ascii?Q?ss4ZRGup5tcnn+6ZAs9yBkVUjxvOJSsIUge62HQ9pyohXF0idXFM50DC/L70?=
 =?us-ascii?Q?yBylQJuDuX3Rsir9fqBLx+sJGG6gAeAx2v5Cgqe9WbMGRr9IOm6favQqsvaF?=
 =?us-ascii?Q?DvqNyg4RVpxdcusA5Vu7JciXbQThSDyhcBaisFiUN1DTbUbCmDdaUxh9RhQ+?=
 =?us-ascii?Q?KTVeMrdsJFWe8mbRjK0RapPeev8Me5eBIIIJ/i1/4Q5+RXfFaI8pSzQAqwFH?=
 =?us-ascii?Q?G+34Z01r/8xVFZoh3L70ZQILKWbXiRaInQV3X+13W8lCQDIH1Jecmdz4Op7C?=
 =?us-ascii?Q?m03hze6v7ROYapuyzVzW4WeL8reSRmKo0sEUDc1W/o20S4anrIw/mrlb/5O7?=
 =?us-ascii?Q?YXynKcCritQYuLqT0T8pV6CY5edlU9Vxm26hNqilJXPsOiMntGmnxX9NV74E?=
 =?us-ascii?Q?iJLl53cx+yLzL4X0PD177T59M55N/shZyIGDnfqImG/bkAyQpySiNUkNnfrM?=
 =?us-ascii?Q?kMhfeNP2pZM5VbxWVCDuUsjODfpoXixt/ypAHG19j3mE25yoON2ACAMNeVGR?=
 =?us-ascii?Q?QvNlvtcLvJ8FjvzpxhB7AGqcg5/RNgW1XhN7BQ2lWl+z1IjWU/+kuXk/IHgO?=
 =?us-ascii?Q?EylUqGDK5Pc9mN3EB09Zk9/GpoBRmwOY5j9hrdbEzt0JyXczu0pGDDcgz0P+?=
 =?us-ascii?Q?H4xboFh/Jm2jggs72V9Nl/iBSPwiSp1TeIvik5RQSfLn0ffqEFUfr41UxrD3?=
 =?us-ascii?Q?Jg848hdmSWAKmAg/PraGd82T+kTmtWXKM4hr8x8aQmKaiSyx974eFWMr1wL/?=
 =?us-ascii?Q?bVkH3Bcz9Fo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yg9a/U/iRHiwSRgasDJTyqghAdGRaalX5465eLjPuSAmnrWtdUPRSAiFpMTm?=
 =?us-ascii?Q?ehLFectoisPiGKsylQ3UhMRMHBInC4lL7xuf1qLOVVl8Ii5M5kzNUH9kVZ0h?=
 =?us-ascii?Q?VQosNstDMz51y1LhtD/0KHsKMBwibx1SfXGs4vM5wHGVO4b25D4OqGzDtp+g?=
 =?us-ascii?Q?OWbKr91EgJCWo89cIyvW5xgbLr2/c09CJ8ePCZuGqJLritqm3lHaM8Xrd293?=
 =?us-ascii?Q?foZDGuICAbY9xIeOZtdD84fHdg7k7+oMx8/g2cXBHxgNjSipjmJmziLAEkhS?=
 =?us-ascii?Q?Pia3N46Gy9Qml2laEN7ipR1fgmW6vN0TGVLVMIwZQc0TqqiBi1ex6Vew5ipb?=
 =?us-ascii?Q?kVX3f9v2gJkVCCnS6qRClAHinTL6QhLcORO4JKVVreFuuY92DmhQcKEGxgrg?=
 =?us-ascii?Q?DGBzqdQTippXP/37Jz2qhtFpg5mikRgFWmCkPq5WoBsRwoph/9W1VNKc8svU?=
 =?us-ascii?Q?BnhQJxCgCDO2TZ8LhWdV5m68r6/vwoO/d0vEwG8tqvWPC/s4SKhb+Cf5HxgN?=
 =?us-ascii?Q?xwAG5snYlEG1203fS7oKevnhwHZhAlxlQU7XZaPlJbcUXfQaOnXpvC1cbf3v?=
 =?us-ascii?Q?eadci26u+Gvrr2u3RU7CJ0LUrtAxHzhudR6lKI9BBHZk7doUsFJyVNzSDCfG?=
 =?us-ascii?Q?0ca6taWXa0tuEZDEL3YwLvpWqG10/IMBpkbvEEbFoqySXKRwM/ULBVclIYSJ?=
 =?us-ascii?Q?LgiZSgOONIVR+uVWYV/2zZ9d6zmtsFb01rlAPbDiXpYCNUCN2J8cY9TUqb/G?=
 =?us-ascii?Q?csYcwCnD1LF9wHAkuEf9f1h6yTwf2iTRDu+FbhRtDyBaGeCqus/zfRdipjIn?=
 =?us-ascii?Q?JO5VZ2iOfUG+L50qfB91ilzC1pjG2muoaqMZzfzqOBAXzKJyIAhcX7pjFDgV?=
 =?us-ascii?Q?rjeFhTrqqCkqdVbvgOiZmxkoouMmjMthVIaWrxbIp7yD44rWhvM/6+V4gOVe?=
 =?us-ascii?Q?AMEK1s3ALW8Zp/SiPl+h4+QALlZWLbk7aufCd8YshGUp84SSlxRrdP+Yebeu?=
 =?us-ascii?Q?BuPFKbrjavaQXsZbgWQbnyU1ZNUmP0OlJc8DLZWqIOlz9/KSkkRTfTKHEMvo?=
 =?us-ascii?Q?v3ypnSAlCozfJFVMBJNRak5jPohl3RCIhcSRSBcSisL+VLbMwZV2PgWgaJ+u?=
 =?us-ascii?Q?ALpV/8a4WXCFLhPkJ65cjXWpyAnElhX+8QmC4yjVRNwpguPnxso9lZIbablm?=
 =?us-ascii?Q?fjYqERWeZfDlh8YvIv/NrSs/hBEs2266rsGFn3tf8IjV6vve68IPowdGI+Nv?=
 =?us-ascii?Q?MvOZbiFOC1fc/m7UgJ1omICuqAfI28PHXg5+qLUMm05idq/nxnZTeFKDLZ3d?=
 =?us-ascii?Q?dWLzS8/O8QC+SmggNUf0jV8SqxOuDyvMVUWMLHwEHMNxmsryOMqCcdjuLBUt?=
 =?us-ascii?Q?ujd2aA+aTAB/hfdM6wLzmaFScubIYudir69c3Ho2t21FNvHIvfQorqN7ZWN4?=
 =?us-ascii?Q?vPY0xkbMvZlqeawxNkVAhomkYAYol4BJaCTwzSYrg0V9dX0Jrq4Q1aSH4J8v?=
 =?us-ascii?Q?UwY4FPPSr/tPUWD+/xhPovp/b4V9ygLd87iJr3Pfj2CboLXIuIy2n8kjVRnt?=
 =?us-ascii?Q?s6fet5COKTyKZUG5hOTWfMncqhyVvZR8u2kMuaDuUxU1YzcYAgPzD2uOVrOL?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1907b4cb-75b9-4c77-865b-08dd881532d6
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 18:31:18.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhgrWeau3IhSvSs2gakFqSXyiiWmEfmGE/I6tCxC05gY9PaP6Q30URN9sDQqRNaHfSNmQgm4jCyyEhkFuJJFrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5704

On Wed, 23 Apr 2025 09:54:37 -0400
Tamir Duberstein <tamird@gmail.com> wrote:

> Allow implementors to specify the foreign pointer type; this exposes
> information about the pointed-to type such as its alignment.
> 
> This requires the trait to be `unsafe` since it is now possible for
> implementors to break soundness by returning a misaligned pointer.
> 
> Encoding the pointer type in the trait (and avoiding pointer casts)
> allows the compiler to check that implementors return the correct
> pointer type. This is preferable to directly encoding the alignment in
> the trait using a constant as the compiler would be unable to check it.
> 
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kbox.rs | 38 ++++++++++++++++++++------------------
>  rust/kernel/miscdevice.rs | 10 +++++-----
>  rust/kernel/pci.rs        |  2 +-
>  rust/kernel/platform.rs   |  2 +-
>  rust/kernel/sync/arc.rs   | 21 ++++++++++++---------
>  rust/kernel/types.rs      | 46 +++++++++++++++++++++++++++++++---------------
>  6 files changed, 70 insertions(+), 49 deletions(-)
> 
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index b77d32f3a58b..6aa88b01e84d 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -360,68 +360,70 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
>      }
>  }
>  
> -impl<T: 'static, A> ForeignOwnable for Box<T, A>
> +// SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
> +unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
>  where
>      A: Allocator,
>  {
> +    type PointedTo = T;

I don't think this is the correct solution for this. The returned
pointer is supposed to opaque, and exposing this type may encourage
this is to be wrongly used.

IIUC, the only reason for this to be exposed is for XArray to be able
to check alignment. However `align_of::<PointedTo>()` is not the
minimum guaranteed alignment.

For example, if the type is allocated via kernel allocator then it can
always guarantee to be at least usize-aligned. ZST can be arbitrarily
aligned so ForeignOwnable` implementation could return a
validly-aligned pointer for XArray. Actually, I think all current
ForeignOwnable implementation can be modified to always give 4-byte
aligned pointers.

Having a const associated item indicating the minimum guaranteed
alignment for *that specific container* is the correct way IMO, not to
reason about the pointee type!

Best,
Gary

>      type Borrowed<'a> = &'a T;
>      type BorrowedMut<'a> = &'a mut T;
>  
> -    fn into_foreign(self) -> *mut crate::ffi::c_void {
> -        Box::into_raw(self).cast()
> +    fn into_foreign(self) -> *mut Self::PointedTo {
> +        Box::into_raw(self)
>      }
>  
> -    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
> +    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
>          // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
>          // call to `Self::into_foreign`.
> -        unsafe { Box::from_raw(ptr.cast()) }
> +        unsafe { Box::from_raw(ptr) }
>      }
>  
> -    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> &'a T {
> +    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> &'a T {
>          // SAFETY: The safety requirements of this method ensure that the object remains alive and
>          // immutable for the duration of 'a.
> -        unsafe { &*ptr.cast() }
> +        unsafe { &*ptr }
>      }
>  
> -    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> &'a mut T {
> -        let ptr = ptr.cast();
> +    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> &'a mut T {
>          // SAFETY: The safety requirements of this method ensure that the pointer is valid and that
>          // nothing else will access the value for the duration of 'a.
>          unsafe { &mut *ptr }
>      }
>  }

