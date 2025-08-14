Return-Path: <linux-fsdevel+bounces-57909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650FCB26A78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3D9E20CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1A2202F9F;
	Thu, 14 Aug 2025 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKsWMHOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1455533D6;
	Thu, 14 Aug 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183567; cv=fail; b=GjJ/U/j2agZOY/Q0jRrk5Eoa5HFEj80iVQXlIZfZ9vZFl6z8lrYexPZqf5f8d9TkJKcktnmwnlQBecLTPhwSvu/s0GIhQpnF2K398V2lXIbFAfWWRx0a6fbKv9Qa04hj3Qi2nWQMqBWOs23iefdhsEu7QwG03NidlibJ3h2tDy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183567; c=relaxed/simple;
	bh=4ooYEGrw9S3Aru0421s7/KM2Nkh/1sIRIK9ZjZmYoGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHEJ/UxJfDop5T0MIOUkdUs/6dSYn0JbJ5tRQ1gDhvLIfrV0LiqPFvOr3IShi2FXfv6ErT/v2yG4vRtlAXmteRpE94ANo155Orj1nyFpW9mVaSkoeBC2cieyxw4ufJyOnbZELOO5QKj5n0IPHI4IBjK7qngtzkzhC6wXRyy2FM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nKsWMHOT; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mif9D/BwCkWPVX2CqV+azXJH4DIXjiWipZT48dpSau6z70R6J6k33mvbN3m9sMOFvlbw2H5vcmAfEHKbPubV8TgTpUxv4LrLtI2eJ0IkPOLlRKbM2Ko05dbM4wAGFDE6hohQIwbPG9wZ+7dxwv5rDMKRXRn/BcSgZeysmIQ9VXQ8jBXZ+mbB2wCm3p5h4RojurRBAbTH3kNzveIurXedJ28ZrqrCLAbXtU6j/v71wBr002QpbR387yGviM0NBZtxfXu0Jk+yUpaO9PgyK4OyYhIglte7sLWn3ScsEKdWHL8A3gxkR8KswQobhajBmmLZfebMxmX3c++cuIKv3zsHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxbUkK6cRgbLxAE9Jf4SEwrZF3cLlOTxcuGkUIz7ayU=;
 b=DF8iZzqkDulROvr9YU3AOZXjHwu9oc48CXL0sNfgPwA36D6VcBKMwpxq+n6RcSzjMyNU1ZqNlY91i6U0sm0X8Gj88dCYFcfPOgKpxufJ1awuOh6tn1FRVpKF91rv0PbSFOQfRFO44MCbtPTRbcOrypBuaEaVNeuBG7v6cSHBaS4W5JS8y5KUhtERCsV3Lt5uqF1ma/eYfnmX+WEcpg7Gpn+ogvkOldxhbfNxCnuoxG3b1jzQs6AFeeTepElR7VRwzW5agX69wa1bM0Vu7UsosSJg/DRDFXAbtVKezEyz6m0nzVkSAkgA6cJig1KvvG/wTIRHi3F5se+jFOZKEIdADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxbUkK6cRgbLxAE9Jf4SEwrZF3cLlOTxcuGkUIz7ayU=;
 b=nKsWMHOTQ8/j/ui3RTpp5r4Py2Zdrt6zLEA+6Bem/1pkaGMl50dTYt3llKwDVSgSD4H621T/xEFMHtLFjjz9FkidTiwonv+kheslKZRwacZYYjvP61/4cuRisYywKE/jHGCqZk4Cl1+z+hQEeY01VzPdfTzH61w/I4OC63pw9Edod6Dj+y2a5gPc3Fq5XjaeWIa+Ocs+t62hZ/yfoTG0H+Ef0TxjQ/4Wt1koHyiy860IEePESRfivnogOQQr3ZRBIs8acCE8DqX4HP2uqbzGABu42slDA7+K5UmzvNVGCb3Ew5Vxe/7VGGGVZpyk4E7h0Ib8OwyVpTCgzku06Rb2Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 14:59:22 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 14:59:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 2/7] mm/huge_memory: convert "tva_flags" to
 "enum tva_type"
Date: Thu, 14 Aug 2025 10:59:18 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <E2CC7BF8-A3F2-4F14-BBDE-94B635FA1795@nvidia.com>
In-Reply-To: <20250813135642.1986480-3-usamaarif642@gmail.com>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-3-usamaarif642@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0846.namprd03.prod.outlook.com
 (2603:10b6:408:13d::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: f080be6c-b9d2-48ed-15e8-08dddb43273f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2mzesMskJEdB9lAjy5JPDG3WXjcJfUjp+/rTfWK1Oj8sbvQUGjrUlLIwso0c?=
 =?us-ascii?Q?0woLK3qaBlom1irDaHtrrBCNtngLMqFD8bJ0UcABueww/bH3ANYCQ4PiPGK+?=
 =?us-ascii?Q?bmvOh+s072CVZcqIHX0S8uxc0iZgjT2uPdA4ghIF+1N2+EYDXtZDWDyWEuHS?=
 =?us-ascii?Q?/APDH98G3geRUapIFFNN6mXUdgyXkgsI0LJlDaYrKP6HjCZCxB0qlCnguN5h?=
 =?us-ascii?Q?Xmwezyx/znGdCakiF4hPgjqajBorRFbdl/ycDCEVhvNhaQ67UiYf1dC5PD0R?=
 =?us-ascii?Q?OpPw3d7WZ+V9EKxbwQwjSVThbTQI6YOTL23kv8sx0qxbs/DlMsx2lieAKzYY?=
 =?us-ascii?Q?tOXCLYORFVoCziRzsZCtxfsAH9HFmpvurYmNHvWmK8zmdjZiLbhX5krsfRyh?=
 =?us-ascii?Q?wofUQY2Dc3k9wReizCbbM6rHjELs4PGIxXNGJFZf56MT+RRiBGn12fHm+mb2?=
 =?us-ascii?Q?VkyhAERQsu7I6TpZ3SALKJq4SnZo4wSb6QTNEcl5L5sKD7vLcKNdBIdKNhtr?=
 =?us-ascii?Q?2vOgNXHl664fuvpr2BJD4lpoyQhhKGGsEzJAV0bqUBylXszobZFTv3nJSiX7?=
 =?us-ascii?Q?RdD3L6J/uPFpvn/bnqghT0k8kJwF21en6ZtSDHMGKP7y/jmSdI07RalmGQtM?=
 =?us-ascii?Q?4QMVhcy8jsHDNS+yYYZU3d46B/ljwqD1mB1p+FZgaYfz9jZhVjMyuqE1FwX5?=
 =?us-ascii?Q?67B/w3+FyUcWhuCIP0KKVOBKNBxE0Jr0xPqY9h/hRCXoBKsNv6h4k+ORHnby?=
 =?us-ascii?Q?09TUxJPJFyC9hii1a5hlnb20gFKvgweMvxOkb/z/PODY+8UXrRAoZ9zKrS4o?=
 =?us-ascii?Q?PUTqVd81q9pvDCqF2Jd3sL3mVKuUUt/TrxmhFRKLs4K4moqZl51VE68F/nH/?=
 =?us-ascii?Q?kmGURrFL2xcgKIoa01cmsngLMfesF8CtKDgDQhA2a6L1NvEGG/GSwDUG4QJ6?=
 =?us-ascii?Q?kNE+10Oi0eS3hy5bGhYXv28G73N8n4JrSVhxJ6ZehnJJGmaQF/q7R2/lu+af?=
 =?us-ascii?Q?b5zCasRP3JeeA8J7ORbufUdzPJln6beNdb368TAiTzJ8PbBTBmRZmo+h9XaV?=
 =?us-ascii?Q?Y1oSiPaOh3JfOuFhNVJCiduzTZZPWBerNuIYdVIy5uaSGpLtilhffPqb4rsK?=
 =?us-ascii?Q?16qzzXM/7T2aNS1op6CqgOaIGYAWFRb18Ldqr9KfIg682ac9PG/od2IDCF7p?=
 =?us-ascii?Q?ybiUaCizgLIsW6Rr67b2APSjvptRu7b1Jvdxi8UJo7vJJsaKoJMT+p1O4+eh?=
 =?us-ascii?Q?yXxHbRIrGNtOuGUmNg06nn6Lppdt1coUJi4AH6FJurr3D7Nu3ppVS2mx2Dvb?=
 =?us-ascii?Q?J8u3GhI9fiWd2jCaExYuq5pOqI5dXoqoQfaL8PVqZwoXYZCAtnCw2xpeLM1k?=
 =?us-ascii?Q?5kv1t96CD2imaJxLqySZlWQVJBYAgSN+NMhpWJh+D5XAhHXKiv7gZeiKeBG/?=
 =?us-ascii?Q?jx2PZXGm6OQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xpa1pLribUmPVWhRFkireiEiuH/Ld1bGEFcvpopPRJlGJac+Kjl1MvlwQwso?=
 =?us-ascii?Q?G6hyFyLO0exvJRVFD+LXuhkWxEx2YU5iIks6VG4YiOigfpJQRLnVoV47vNU7?=
 =?us-ascii?Q?FeE19luY2bhdLebasACNHrsiGLVjOSuSGiHYPn5a18A0cJQwWeJc4VX4UqA7?=
 =?us-ascii?Q?p0AizxC1HOzxJaFGI+nd+LLtWpl3zL11FGCCByhXt0CzVQSCwajUo6taoeg8?=
 =?us-ascii?Q?lz8P+RfGQwe4vwudcrLSonFW64flzSU7ClNI2StFBd5iKWK26FfH9zixkDbr?=
 =?us-ascii?Q?3sqJakM6CnUlJOFQb9lYUepSvMpepL6jg8Ynqg0kf983LHMaAvUKu3XrcT9o?=
 =?us-ascii?Q?Kg8X7h0Q6bm9UjGbEqpwla9sJ8zqIg1DzMwbQTCEe7Iygw/qwdszB6ImMxHn?=
 =?us-ascii?Q?onak4ZYZnQRMwgFw3nzy80ctwMY/+cntgq33rpfBsa2s1CkEu4WQdmSLSux2?=
 =?us-ascii?Q?W1I2fdKKXhzRizWCx2Mw+gh6z8EiPeSn99U4wZ/GnbyOXdnbsMTacxTskgRQ?=
 =?us-ascii?Q?9h+3YH+DKCNyP3uYCmHo+fyp8Hakqx5Vgph7thYSpId326dkI8cvW9vj5+ZL?=
 =?us-ascii?Q?GZyfdB3xo6yoFGohP7IUZ96g6CbmjVOpwYZ13IKEkcgTZYcPclz2s9dVNzKh?=
 =?us-ascii?Q?nkpspBVMrAULnoe0/WNmtmuiJYH9swBEZJ2KWtLd8pl8vMeMgEFzfY2ognS3?=
 =?us-ascii?Q?evsNKf8iwS5fnUWT5QZd9h5u9Hb3Z8aCSZ+xDIr+uZ/UjS4t16HKdx5A7pto?=
 =?us-ascii?Q?uUQZfoOGhQuucS+cwK7Tk+BlaVl5snw3I4mSwamnWLbSJEgpMYp1ituBI1fF?=
 =?us-ascii?Q?UeVcXeYcfbBRqymmBnC/g68AVQvu+M9f716AatkPE7+EUevGKTPyqy7qSB5c?=
 =?us-ascii?Q?WbdJwL2jUwaBGoSB26N/DrLSmqwidrJepOFjpWMv3q2nNB/uWWGv4IOptsNq?=
 =?us-ascii?Q?mzq+5vNdRh2ONysLhIRwxA4HAUEq/WbKNuFOcFp6TMY+uOyUvZuXhwV4TgPb?=
 =?us-ascii?Q?e5hbrpIYmCB6kphckCxHq1SiA+yzAZP2yzlI739xrOgAFo3G4D37IiFaJSyb?=
 =?us-ascii?Q?no4nH/Beh0Tv33Nhr/3axTjnzv4ydOBYFifKbXqLDCi7tPcrDKfoLlYQ6+jB?=
 =?us-ascii?Q?5DUQdjPnCSGSCR8I0ijB2TEhDbR7BLHxk1PI/LImts5BMwND97e20qVtL0Ss?=
 =?us-ascii?Q?h1MGUD4Xr2fAmSXz7Rwl+VyWlZ2hEZ5rIgNRdplhKVxJotDsMPKxKVUqCmr8?=
 =?us-ascii?Q?+gi86fgz8H7VA3Iu+MPfYuEY/Mj6T9FgSF+Q1M45UjfPCreST9rbvaumtku8?=
 =?us-ascii?Q?InsjsTJhHtC4IzNn76TIoP0JJ6npV6hBaJB6WF5dlZXHPkqiINdFAsfDIOCV?=
 =?us-ascii?Q?9+DY8RzyJqaQ4SnkHrAa8rEnNZuiLACuJhR//yua/rhDqDrJ2RMn8/++/cDE?=
 =?us-ascii?Q?UnQdgNiadnVMajh68Vd6bTvcGBhrIliThmviMkTTDs6im72beQOKlH4cgZmt?=
 =?us-ascii?Q?WR7l3NF16QOeM5rVx6masNwXZi8SXrouk4/23TgjhcTBsahBvklW6g//ta2W?=
 =?us-ascii?Q?7PTne4xUb+T+34nNBFqv0BJAvjKivdCRQFyvoNtZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f080be6c-b9d2-48ed-15e8-08dddb43273f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 14:59:22.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0f0RWLcRM504fUy6fzvSLtrkn8PpNF8wPIlcUaqgupx+ZWDAJThil9UNNvxB8joE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872

On 13 Aug 2025, at 9:55, Usama Arif wrote:

> From: David Hildenbrand <david@redhat.com>
>
> When determining which THP orders are eligible for a VMA mapping,
> we have previously specified tva_flags, however it turns out it is
> really not necessary to treat these as flags.
>
> Rather, we distinguish between distinct modes.
>
> The only case where we previously combined flags was with
> TVA_ENFORCE_SYSFS, but we can avoid this by observing that this
> is the default, except for MADV_COLLAPSE or an edge cases in
> collapse_pte_mapped_thp() and hugepage_vma_revalidate(), and
> adding a mode specifically for this case - TVA_FORCED_COLLAPSE.
>
> We have:
> * smaps handling for showing "THPeligible"
> * Pagefault handling
> * khugepaged handling
> * Forced collapse handling: primarily MADV_COLLAPSE, but also for
>   an edge case in collapse_pte_mapped_thp()
>
> Disregarding the edge cases, we only want to ignore sysfs settings only
> when we are forcing a collapse through MADV_COLLAPSE, otherwise we
> want to enforce it, hence this patch does the following flag to enum
> conversions:
>
> * TVA_SMAPS | TVA_ENFORCE_SYSFS -> TVA_SMAPS
> * TVA_IN_PF | TVA_ENFORCE_SYSFS -> TVA_PAGEFAULT
> * TVA_ENFORCE_SYSFS             -> TVA_KHUGEPAGED
> * 0                             -> TVA_FORCED_COLLAPSE
>
> With this change, we immediately know if we are in the forced collapse
> case, which will be valuable next.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/proc/task_mmu.c      |  4 ++--
>  include/linux/huge_mm.h | 30 ++++++++++++++++++------------
>  mm/huge_memory.c        |  8 ++++----
>  mm/khugepaged.c         | 17 ++++++++---------
>  mm/memory.c             | 14 ++++++--------
>  5 files changed, 38 insertions(+), 35 deletions(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

