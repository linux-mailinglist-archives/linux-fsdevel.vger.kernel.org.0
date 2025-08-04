Return-Path: <linux-fsdevel+bounces-56681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069EAB1A8D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 20:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41033BC773
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 18:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2542737E4;
	Mon,  4 Aug 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ixEm4c5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900780B;
	Mon,  4 Aug 2025 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330666; cv=fail; b=CpOXZgjlJz1tFmu7m9uOrXdr/rba/HxgBDSpMrRD9jx63JBgodt+DZ23GrZ2x89MMXAdUqtNLVqaWnHJ2WyfpC+Dt018Sfu9MUMBG6NAUsWex7nP0uSMDEOTXCjZqZNUWzj0YOV3tI6pBBa8tzAwvZtrgWQVaDIegqHgcY5Afc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330666; c=relaxed/simple;
	bh=U+JIVHPU5qBuWNDS6AZhcgQXSOLOZKEI85mDzOq1PQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IkixUeiwHhEL7Wzu1nN/qTTOU1uR4fxjTKfdSDO6X97bGf8kOUGlsZ914rhj5DWthjq4hnUllzAVyUHt5D8tMgbYDKN5yFNY62nv7Sfnk9empDlaVdu2nhuAL62cycrjRVf4EP886auZ7frllOCtDdpsjcdpiIlbURgUta4kb5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ixEm4c5V; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYkUeIZaT16Wa9aosLdU/WzTITbY2QikpAR1EugahiDQajInbCGYGQmeit59hk/Y72Ae/1/hiFVTcqYFs5dq1aDra9GCSyWmysd+omyGI5H1kER3ONLUlGXNQD++/fmn8J0H/uKzJCBtNJ+GrJgfmq+PjPGBFcQOumodpdXorKmRlNC0oTB36X56zgFqcEAWX8PDhrjpWcxFF5crfu1fwGLti7tPDLc5obOZPdXeF/kJ6TmLP7BjdzovSR54/Gvj0lPQMKHJTgxxeAkcrRZ+H2j2ear+4tbCCQz6QyG7z/FSTMd12YmDx/S1oSKXzAbbDuy6uQiKM86kEUb/jc0SOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcIJi8xZxYqzUjEJ2eomhnNn4VqJ+NI9+JUhKpAvt5E=;
 b=IIX5AZLcE658sBzW7BY+DwNefCcVN+njhUTcVhHFCbzXRdKqj6gjf82U1/PESybISMQ+LYJ0Eh+kBYV+NMH/YdH1W9yvyVgbc5KBB/yFC0i9qV4uJJ4Ch4scerb2Q85M/2L2iv/zOPp6TUcSl0hPZ4YWegua5MJgW8RJMhcRqS28ACQyfeYMbVxITzPhbaicopQETGOypLKbYDDvVH4rd0xeXxwe2+xxmrAK3qbsz5Be09bmNfFUWSEL3vMQ8GOyQP5e1VqBkwabF4cvaqjGEmrYhQnkJxkfZK2Uwb7NA+W9lumWJU8CI0bHhTjg2xkuZ+jWZnqz81bCM17txpj+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcIJi8xZxYqzUjEJ2eomhnNn4VqJ+NI9+JUhKpAvt5E=;
 b=ixEm4c5Vy/CKwUWad6pf4DMJSTCb4x0LAAd9gkAoxvfmLY59eryz6kWIojXC6lEfpLeJQwhb5INCu1hKVQYODbafFjRzIEI1iIHFjucVAlE9UyaRkqjVFNMNdQdQ1NjkwihJ6WYqcXroQfYWAeeq9+GhCIejc3Nn55uKBOlfe7el5Fx/GkCogmt6nzvOFeyklTYaY5bCWQEq2RzSQVJke0rfelojwe0X7EPns4K8R5GlJzbpO+QHKScdPEOo1NZj5h/w/b1GwrgTKQro46Ae80WhsB6Opx0wxS99hVYpmYWsmVCsgFJdFC+AhtG0JH4Zsti4PCbfWj3o2EQJu5HNFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.21; Mon, 4 Aug 2025 18:04:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 18:04:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
 linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 2/5] mm: rename MMF_HUGE_ZERO_PAGE to MMF_HUGE_ZERO_FOLIO
Date: Mon, 04 Aug 2025 14:04:11 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <0F98E975-AE29-4355-B2F4-D1B299F7AD98@nvidia.com>
In-Reply-To: <20250804121356.572917-3-kernel@pankajraghav.com>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-3-kernel@pankajraghav.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:408:e4::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c4b75b-92d4-4d13-1a49-08ddd381568c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EqJMPmZS+WdcZQr8r5VPX4nIhft73DFG5avx9cvwWbfUG+TixP7jCZJLcASk?=
 =?us-ascii?Q?Mq/L4EiGFfllUMV/7U5wCH9L5mSI7PJXbAu5YBdzmj7au0+P1VhupWPnyrPW?=
 =?us-ascii?Q?FsC3E1+QhnxdeMXohg2WXJGP2cuW0FdlKD4kCIyGVL05ydnV0cP4NPWkc2P6?=
 =?us-ascii?Q?s5iKDwu7cfsIL8Oz7npL+sXP/MV7TM1J3dcIFFlpj5taTVxxT81CYfduF5Ju?=
 =?us-ascii?Q?/upnbV3zRDmK1aurLJbpbh+C1bakgsAh+ieXl/PhzNvtaPzmxQkGJ3LtT7HN?=
 =?us-ascii?Q?l9MEHQnuCC5jjeFhThCcNHHCxogRMH/FDTGObEzoOdJBIxLsN7t1do1Dx1zr?=
 =?us-ascii?Q?j1dL9bfcAdLni2szo5iYkKhw3stoxhydPXnF8HMYfBVkUOVChv9Qg5wWs9+c?=
 =?us-ascii?Q?XLvZh71EF+5BWteVDiX5Z0I0IGfRq/Z0jg43ocGyvo8Q2zAGozmp1Xfw5qJL?=
 =?us-ascii?Q?+g8YpWMhm0ME6LG5j1ZFQ828PpOlFySmYEdXv9MK3e7h8lIXNcgIiQbjO1s8?=
 =?us-ascii?Q?FVP+bUqMH0I60tjJlT1OcDZrjI1BqUiEv0ifXuscXDBC243HQ1mpZ3VHxL84?=
 =?us-ascii?Q?vm0ddv55P3lb50XS0EX3XN5nlfleaSNpaLhGGbFxDcuePPsBncmXR8XzpCLf?=
 =?us-ascii?Q?RXdhsB5lA6IJ/prQbn5O1oFzcw98SZsrsqdvY5/aETv2vPZwjnIwXqP3VeKq?=
 =?us-ascii?Q?V5EyhuK0G+VNMqMqRVONjFMQQ69q+8Z/aCxgfMaHxByy2yzRqyfFRSq3vr/P?=
 =?us-ascii?Q?qgn5xarKfd2zNHKgRmOFXyLD1mXoJTH7L+nffweaBbM3RLk8NcHfUvLI4wCG?=
 =?us-ascii?Q?VCoLSukB+a6V+03GP36m1FLneVMGkrgBm5ZRoFyc/atRu/ALTOtkYmOqNJxj?=
 =?us-ascii?Q?X6lDR8a7mjiwJ6ndh90x48NYbI83sC0eIbPwcvVS4L9pOwjA9d6uxVOI/9zn?=
 =?us-ascii?Q?3qH5xo46YtzZDsnyl9T4ZsM3QmOXl2Mg2ZdbdQfyv9SjWCRQe+2A3UoT5u2j?=
 =?us-ascii?Q?zYfzUKmhzfhtGjeRIr+CIzITbvPmmlPklyukuDx0mBq6P3pztEVlxIu7Y8tY?=
 =?us-ascii?Q?hI2ccPY268G/MYCbFyh1nXExM3B8j0tnmOR+1kZIbT9JDRcCVZcBiRzlOBUW?=
 =?us-ascii?Q?QmN94fuHNp7iSz1NsuCK4JgN/P8d0Hdl9HqfP0YoGjV2ZxmGqUAs14qTmJfe?=
 =?us-ascii?Q?7FWsX6b2/8FpqK39Sx0uvGU/O2EorBZbAfBRhk2UzRvnJa9u9mi97zQBhfk1?=
 =?us-ascii?Q?OwGJvxRmlwAE4pjm2YtNKaR5w75xndFYA9wAQNgNMnWiffwkmvhMWn/dxlRE?=
 =?us-ascii?Q?NJu6u1ARST0m7vPAYEORupEbZtGLAcSbKovSthRbqKZadjutMOdZKKCCs4dT?=
 =?us-ascii?Q?ZbhCbZWb8j6kQ007CMwQ9v/VPHvd3R16Ehtgqaljx4xxN2ygeb2Vu0xZBbke?=
 =?us-ascii?Q?t/5fdU/ktHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gPPXFpr+pgZZ6Sfh2XDuEXlUsqmdw1FitlJl+9Jwvc1qzVLB0pn5KXHj7ZjX?=
 =?us-ascii?Q?9OWeohpwdefRuR04/VXP1bqqRQ/DIp8AazCivm05kccq6eadCLtGJccXF9Ru?=
 =?us-ascii?Q?olPxwcb2pC8ZNWeqmao2eyAhgvf0O51v8UTLYIvfbLG66vNDD+FJPOOUVDR4?=
 =?us-ascii?Q?kWDfn+jy+z0hWaVbFvhA5gQa2NADW6+JunGJ3+dKqJ6B9t6d0iXCaOOnAJMg?=
 =?us-ascii?Q?lxt4ETmz/Rq3EeofVAzmE6Gz0As/Ynsu9kQKdMSg2DSdYXz/Ogi910iqOIzu?=
 =?us-ascii?Q?pwGA7Ux8HLF0wPRg54z4OZZ/EyhF8YMx3gg8E/nXT8Leoif+xaBSgm1Ffmgb?=
 =?us-ascii?Q?4ziQ4NiW4onjgzPW4q28t8xPu28vx38Fm5Nx+h3rgkIOq5lNQpQNHTNwHZXJ?=
 =?us-ascii?Q?WcIF5ookguXHcJJaHHSyJzrT/jL+6yVRbuwz2ldMJC+R0BNebvftPLivrkmI?=
 =?us-ascii?Q?zxVCODLqtbzP5K77mECLmCsSV+KLr5BaRc1nhxw4qkYUFxyfc21/ig0M+k4+?=
 =?us-ascii?Q?D8yWJbvgsL7i9AKARqJG/1RulieXnNhwWQXH25vL9FRVayIJHz20Cy0kLgZ9?=
 =?us-ascii?Q?IhdXr5pyXDI9TVQMY+qV92QF+EkiwvVK7Caw68cY43/pIZvfbqF0S9nfuDW5?=
 =?us-ascii?Q?URg+7P8ltFd6B3tTlFI/EyYaLh9JByq4pp+m0khQWV0ZgnWQdppN+jPCh+pP?=
 =?us-ascii?Q?8I/j9tvLQTDbAD5Opq5qbTNyEd9fLWt4Yn9dlsjCZqoRhr5UamGbyVIszTQJ?=
 =?us-ascii?Q?fd00fKp5g2CHeZfCiz8umyebtUrCbLTmAwi7cmTgi6W88TzOBlLxXZbxQfQf?=
 =?us-ascii?Q?aR1mbYSP4APQCTOK3EU4Gj39ARRUXKk8K1+M/F/U9/fzSP2BPdof1/8iKeQ6?=
 =?us-ascii?Q?+mBhXOpH1wC0YTlu7gp479Oiaozu9BVGsgwwFNSfXkgW4CvG6+T+hZFTdWC4?=
 =?us-ascii?Q?PzuZPmIXEXV3yg+r26t+MCH8IyWURHh0ZhtQq8FUqFhjMANG9OXstCByhNYE?=
 =?us-ascii?Q?p6LXr44V7CDgtkCVEfnBAS90omNG4Jx1RtJ21MG3GQkOkxGy03EkztKO44gC?=
 =?us-ascii?Q?11wGNn7k7vzOjTTFQRQTPXnSOdXIbwLC02kOfKpUi/tlIcqo0K8FbYW9QInW?=
 =?us-ascii?Q?6BbzUJAgUVa3ABNcfXi4t/CYByLgkbEBzK4+jqbYjU/4req+j02SBW1+oKhY?=
 =?us-ascii?Q?p9/C91m12ocaWSD/JfNJnvMtTwa6z/zShCEmHQegoBq/qYpoOF1pcf/mCd/V?=
 =?us-ascii?Q?dc5u2W2BjGZZH4iJ9b83yTlV7UTm1u0eHS4kaMVTpJ0uagyzr8NdEuXSDvUP?=
 =?us-ascii?Q?09SCkn1xWXWguXr8OqZQsedL4m00wsoecq/i2Nxs5JzNoWq2+mdE5Mhjp6SG?=
 =?us-ascii?Q?7iBbt/R8ykZ5dl30AAi0X97E7RyZuElcPchfvz7zgp86555IvMuIbP4jMX8Q?=
 =?us-ascii?Q?3Dp3WkxZk/1ZFv5oOt/ISS94112EAnuTbs4Kywm49/6F6f+kOiya1oK9wuOp?=
 =?us-ascii?Q?9+ll6YtDGrl7HZcpEsWU/HPfTSgc2ozl++vmS9owNoFrXvCJxdBySaov6c4i?=
 =?us-ascii?Q?miMwZNfcUwkKQw7jCZlcdesa0woFV/fXg9oxEQyJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c4b75b-92d4-4d13-1a49-08ddd381568c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 18:04:21.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VimqIc0GsFDocO46orm6Nq/Qh2xKf+zlYvQyVi4C7uUHpSJR5BlS8uGM5MWpIRyP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172

On 4 Aug 2025, at 8:13, Pankaj Raghav (Samsung) wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> As all the helper functions has been renamed from *_page to *_folio,
> rename the MM flag from MMF_HUGE_ZERO_PAGE to MMF_HUGE_ZERO_FOLIO.
>
> No functional changes.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/mm_types.h | 2 +-
>  mm/huge_memory.c         | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

