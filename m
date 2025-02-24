Return-Path: <linux-fsdevel+bounces-42537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC510A42F62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650EE17577C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123391E2838;
	Mon, 24 Feb 2025 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+JZu9U4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E1469D;
	Mon, 24 Feb 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433486; cv=fail; b=QQ0kfPeMP40tjWGwj+FNr+Pgvde1D8DRnzfgezobufIFGgw/WyeONysxUiazXNfTf36Qw/l/kwln2vtFUyfg2M6WRdo8XUqs3QzXQi/zkWJz+ACTmEuA0JVX+tShR3ed84lFbipTit/9o+HqnW4KNXRzfh6lshs5g4WMVz4yWfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433486; c=relaxed/simple;
	bh=DEdS4WaArcdT2GzNNxFjg2/Rq7QD/H9A97gHBVjoHf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dan8XOQjsxQL3pk9UMXxrgeas7+68F1DnQ6dhAvsVS4jRqyXYX/msBmiux48DtuAgvCfUFbYmL/iSi/EAM8W2dS1rQAsLHfFN3q5piMIaGZhswjzy0JgOrcJgiok2qEU1o781bmbljmmRa4PM6IR4/+Glr3oQMegQmddiR1NZYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+JZu9U4; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMISY73q9yvk2QQ/VhkRSdDQYN2IVxTlP1P0ljMV96sm59bUXVxILQsacpSxHd4+0AUuH7O4aZL2a30aTod1X+J+QI234iKkyozp36zFqVr7TFpHv4vlmkUG14qZRuwIBkQXNiW7zT/aPFYdSG6e5cWJ4JmJdL9ZsDAyIRXYyE5qkZ2VnfbsbcllJYhTbUZdGs2MSBii8AVovkT2ohzbSQ/w+ImV0WcfIysk8iHpW/ChtSngyoPcHAE2WLvaT6raj27Yx+fYb9yiGalC3JRh787luK3KlP+oyAuxEE3ySrvL4OyeGEG3qRCGazeWWTuByoNjCbhfKASwz6hXVfroGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mm3y4d8Mp5AIMdnquZd3ahrw2ZVUL1mCO0NfRdenZZU=;
 b=AejXnx+e8ncvlRWw5T2m8CGg/teWE8tSmcCYoANXlTuNI6n874Yg1eO+wHOpaJ6friDHDZ9kf824F+1+rckdKzYBjJY0B/xhvhAuM8Wo4Uzcdv4zEedKJydS8mOFBS54FLBd4doSlhEGTYIXoSA460+yjjqfgldCs9pIPy92pFr9OvtXNo5YHJuaozycHNRrlf/I9zoMxGrOwaaqDWHmUfvx5b+JzB6JLOoT1uwq6Oo7B49l443xzu1nj09qtCiPLy9yiX5mOHCcbRU+sWZeuzaFntcVs9LLkeDL4Itkd59xCGkr7i4EmEBzID6pFaJgR9imBfnB4NrpOOTS+cbSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm3y4d8Mp5AIMdnquZd3ahrw2ZVUL1mCO0NfRdenZZU=;
 b=r+JZu9U4EAFZIpSSVVCJ3SvUL2wjCzP8kYbguSZIIM+L0xNOjGxa10vHmLgFO0YxBslWnwnjzva7h0r9kqiT+qnzGx2C5Z8K+/nX+6bHpdtu+u35E1zSf9mEiECruykBzhg1UDlwdYUEPSTdxdZxn9oA1phBlgtv9Lu8YteumcczwOYuT8lGAGVf79zsy0xezNPFBWZlGMeO1LJuTwo6GRAT2mBVB/BhX5zwLwmODZN72eT7ZPofHrl/HxeVqmsmux4G91qAKmQ0n+mgFnuFotBIHrD7D+pClfMMDrrZs/QM0g6FGw21uFuB1XMlhtHkxhAwSIHILrDkJJdz0EAyAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Mon, 24 Feb 2025 21:44:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 21:44:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 16/20] fs/proc/page: remove per-page mapcount
 dependency for /proc/kpagecount (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon, 24 Feb 2025 16:44:32 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <1FAD9E31-3D11-4759-9363-4B76BE96002A@nvidia.com>
In-Reply-To: <3f6b7e66-3412-4af2-97d9-6d31d6373079@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-17-david@redhat.com>
 <D80YSXJPTL7M.2GZLUFXVP2ZCC@nvidia.com>
 <8a5e94a2-8cd7-45f5-a2be-525242c0cd16@redhat.com>
 <9010E213-9FC5-4900-B971-D032CB879F2E@nvidia.com>
 <567b02b0-3e39-4e3c-ba41-1bc59217a421@redhat.com>
 <30C2A030-7438-4298-87D8-287BED1EA473@nvidia.com>
 <3f6b7e66-3412-4af2-97d9-6d31d6373079@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: bc813404-7f0c-42e0-b30f-08dd551c6e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnrSqcn0f+zxCRwzf8dCMF1z63fsUuCD8mOqrmmsf/zyC75XtOdeoT4kAdof?=
 =?us-ascii?Q?7Lk2t0RNINwJs7Nz0hVmDxVDnjCZ9eUs7qsxiqPOUX9IUtYwiLjO9oNON9dD?=
 =?us-ascii?Q?oqsuhqtJAUyJtvcCsF4ge/NHOEyoiIk3P7oZhZqzqb2/Roc5V1Evgz8AY/u7?=
 =?us-ascii?Q?tJD9BrXvdZZMRgjUcqAokGeGWszAco83JYVrvjDHwrJjGxrx9GjMFqrKWHnC?=
 =?us-ascii?Q?VV4617m7JCxFQH95+ToaXGV+KxjFNwFDIFRAJXsRUa+VR6w+06/riNNrNYsT?=
 =?us-ascii?Q?NDNEgHIJhagtafhjh1j71ZPANBJviu2gPCGFwUiU56BzFpq5cH58wo4Nw76t?=
 =?us-ascii?Q?y2/XmR2MyVeMFYmGpw3pE/ZqblS30ygiU1uSzlk/yBBtGSw1cgGG2T210SAn?=
 =?us-ascii?Q?qtnv8+9++908ZEquEaebzINbk4wEWV02uytniH6hzqtj6bHZsepdy2zgbIvj?=
 =?us-ascii?Q?6n8QyaWVB5tSV9r9RFGEY2PlmCUd2leKn3YKvPbIrsJSTl4YnL5i0bz4cZ5k?=
 =?us-ascii?Q?fIlKCnSfqrK0j7OI46VHdMbOuL2w/txQt/vQAVQ3J2fzyyqI8fO2EL6/wOHq?=
 =?us-ascii?Q?t6EiKtLHSj0WcnFcL0pTD61RxWU+V0b7rL2UFYzpBEofQKN2GIjUVkwiBXR1?=
 =?us-ascii?Q?Ce8uDEID6bC39lUVbFPqoM5qotWXDIFIE2EH7Z8x2sCB+HMo1rpAQW6qWH1m?=
 =?us-ascii?Q?RR6Ks/jF0M4cheW6iK39JvOLq7a2/K1PqTOhzFKQluT5q5Aqo31P1y9OXIJu?=
 =?us-ascii?Q?xgWf0xLOkZK9F9Z1B4NKOwwXl4bqun7qTtOc2E/ktkrExkiCGsv91c/YQmV1?=
 =?us-ascii?Q?bbTHIdVGePN8Y9rFeKjWickjp1w3IprBdVYXpxoacfGGDsryIEwzsGsTzwP7?=
 =?us-ascii?Q?qz1nwv2I5cG1UOdhXaHT5KFfke/UkzY8IefOeMywSdVZnxmBPWhPyUmCqreQ?=
 =?us-ascii?Q?pQFGtrI7GjupS3wQMrxnItBK7oEiu1YgzePppxsPMquey9iwBPJcZfVgH7vI?=
 =?us-ascii?Q?4xGOnuKtMkF63oH9OVYrA/5Aaoj9luoEFIdUCqxuy0M5t7FC4iMw4a8GVc+k?=
 =?us-ascii?Q?xXWN+6b+6jhG8Z1/6dJM1qi1nKiNRtq01WI+HR+HYahMh+8YUXWYQCZg3GFb?=
 =?us-ascii?Q?dPg/Gx8o+F/rjJ0nzIf2CVLpkEl7vJWTPjak1xJV1UGN+OS76PjRzNCw8ZSk?=
 =?us-ascii?Q?UW2aRJzer0pCfqA2eDOVerU4qK3F0kBjvrDY752tQjNUcy8ti0EtSNTjg3YN?=
 =?us-ascii?Q?mJ3cLtyYnzQM69Nm2pe8YKIxyHkfj0rZQvMG/tVpeJrZsS4FcOt/W8vDwg/4?=
 =?us-ascii?Q?iOckvP4lEs9w7pj4sPYoxQ+a0oOeiHXPtTvd/YLp27SO2bJPXdv0kbeu2BXy?=
 =?us-ascii?Q?GL+CGRmmHvT9mWEokn+L+MRbJo5s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f/Jb0xzELtA0i0eT/4blo0MK1E+FNE6MCoRmTGRfUmULc8UNy0eM2R6DnxBq?=
 =?us-ascii?Q?5Zs2RCz3bLJoFGoXBwWgqxMILHXJUpk+P81jTx3mi9ITput2gxr+6XwooYgV?=
 =?us-ascii?Q?HpYx6rCuZSUjwM0UJSncX6ucFhOkhfnSBXQSIy9P+X6lhdTZcwOghfrBSjUL?=
 =?us-ascii?Q?RZwOJ84tWaELldfal0s+5yDHP2K6ZUNT4ZL5lf4ycB9+HAQSt5n0R65c4Ix7?=
 =?us-ascii?Q?+nqRKEidp8RFsxqfFl5BM80CvvXaINII9ZaLZXq2CLtqBx9EltC6EG+wn2pC?=
 =?us-ascii?Q?JHesP+xAoApAaaLky+nFQIrNhZG0H1cx4z395Zg9L5YMUaU20OAxNnNadZoP?=
 =?us-ascii?Q?9samS0SbdPXGgdjdgmTbVDSPMuytTqc/KHHOkF7PmlIC9ZdanazTEQyc4HGg?=
 =?us-ascii?Q?CwATXO9TgppZswirENmmlyOscEjyOSK7PkPAhwMRXxi94q0mB8cgqEX0CYCv?=
 =?us-ascii?Q?x9nNQFm7P9WzqhyYXdZPOUDNnnb0ooiSYj+JW3OGMqchugQPiw4ykTGxydZb?=
 =?us-ascii?Q?CENHN1E5KFCbZxwI53aNFqUMnQUzA9NO85f6XX5ZkBF8EEbb+shh1b9IGs9e?=
 =?us-ascii?Q?jWCmTYrncZ0KjapX5ge4RfbyVhfWcFMvXI6FOOmYT9zqGvNUlFCPMsDome+e?=
 =?us-ascii?Q?piybh2Q0oWnXyEtyZrIX15+Ta/M4SOrHjQWT/xkkNvJiGi2sM5bv1hj5BKmO?=
 =?us-ascii?Q?4ArkziyGCgycyuweKCCtciQ4M5oMf4ymLPl24hjU1ipxbozsL5wDdhFPJ3b/?=
 =?us-ascii?Q?T8EG1JKJ9FY0MVnDqWOhXs5LtT7vCI7tMnnpArSFdqv7uv81b0S8n7I6Ka0S?=
 =?us-ascii?Q?fT1e34wt6qPAAWgaGFXTeu10EloBxYBqGvhiL4hIscmfsgvAv13FID92QQ41?=
 =?us-ascii?Q?8P+ly55g3RF7T/XnXsJSMucOmSdydemMgqU000siBbrVyiZxrvrgwfvbjs8a?=
 =?us-ascii?Q?TjI2U0geBw1zs9sNM7Uyw95gIutOA50bFyQqNRhyZcz/4UpD9pFpuPN4gV1P?=
 =?us-ascii?Q?24FljJEL8FEsLOUuaDRq3u5MRBU00RNaWdL6QzLrPNPJsWWLvlWEi0YyOkij?=
 =?us-ascii?Q?OlDperGZcMhsDM9pNJpdGaUwHTgN80n9C+TxhvTy2LFO51XjDrS2t7Etjc/p?=
 =?us-ascii?Q?5F1JVVmWL6/81oN+IhSbA/Dm5+6myaUfGEk3rrZ8C0Bu3UKOUVvg1BlcRbJR?=
 =?us-ascii?Q?UsphQgbzrk082CZuOPXM3s+tqM45TYS6mFO624/e0R7KjRUty6YVCfYZD/3F?=
 =?us-ascii?Q?sWkn2fds970LS5qken0q2vy3yMv9MG090jACvLo6cFJqIQiMMnmKWxKC/B9q?=
 =?us-ascii?Q?HQHE0ojdSFoV1bAB3fW3GfeLgyBoXgFmqGiUr8RR1bF/ZXBWKTE/920VhtLE?=
 =?us-ascii?Q?hIGu/+QWJCbKUJXYhQZML9xBULoz3nhvMIfib/sb6YBPiHYrnj/B1V2v1lL4?=
 =?us-ascii?Q?26/Px998eny/9BqjpELyT3aA90gPbJyBXqYdJDexAETcSjQ46eDV9lbtg77S?=
 =?us-ascii?Q?J98S+AtNbUsPtCSmz5bQJDlNevRkT/3bSKBpsG/+IROaX+3bN5XT5t5OPe9B?=
 =?us-ascii?Q?vE/+f5FIc5+37KxVFtQkDA7RyFXIxl8q+GbNW2Ca?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc813404-7f0c-42e0-b30f-08dd551c6e4b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:44:35.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lvKp0cls2VqRfo+CSNx0Igq3yARIhS3Su0p4Y7MEmD4wuyIV+qipvW51TV4JHPo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952

On 24 Feb 2025, at 16:42, David Hildenbrand wrote:

> On 24.02.25 22:23, Zi Yan wrote:
>> On 24 Feb 2025, at 16:15, David Hildenbrand wrote:
>>
>>> On 24.02.25 22:10, Zi Yan wrote:
>>>> On 24 Feb 2025, at 16:02, David Hildenbrand wrote:
>>>>
>>>>> On 24.02.25 21:40, Zi Yan wrote:
>>>>>> On Mon Feb 24, 2025 at 11:55 AM EST, David Hildenbrand wrote:
>>>>>>> Let's implement an alternative when per-page mapcounts in large f=
olios
>>>>>>> are no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>>>>>>>
>>>>>>> For large folios, we'll return the per-page average mapcount with=
in the
>>>>>>> folio, except when the average is 0 but the folio is mapped: then=
 we
>>>>>>> return 1.
>>>>>>>
>>>>>>> For hugetlb folios and for large folios that are fully mapped
>>>>>>> into all address spaces, there is no change.
>>>>>>>
>>>>>>> As an alternative, we could simply return 0 for non-hugetlb large=
 folios,
>>>>>>> or disable this legacy interface with CONFIG_NO_PAGE_MAPCOUNT.
>>>>>>>
>>>>>>> But the information exposed by this interface can still be valuab=
le, and
>>>>>>> frequently we deal with fully-mapped large folios where the avera=
ge
>>>>>>> corresponds to the actual page mapcount. So we'll leave it like t=
his for
>>>>>>> now and document the new behavior.
>>>>>>>
>>>>>>> Note: this interface is likely not very relevant for performance.=
 If
>>>>>>> ever required, we could try doing a rather expensive rmap walk to=
 collect
>>>>>>> precisely how often this folio page is mapped.
>>>>>>>
>>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>> ---
>>>>>>>     Documentation/admin-guide/mm/pagemap.rst |  7 +++++-
>>>>>>>     fs/proc/internal.h                       | 31 +++++++++++++++=
+++++++++
>>>>>>>     fs/proc/page.c                           | 19 ++++++++++++---=

>>>>>>>     3 files changed, 53 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documenta=
tion/admin-guide/mm/pagemap.rst
>>>>>>> index caba0f52dd36c..49590306c61a0 100644
>>>>>>> --- a/Documentation/admin-guide/mm/pagemap.rst
>>>>>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>>>>>>> @@ -42,7 +42,12 @@ There are four components to pagemap:
>>>>>>>        skip over unmapped regions.
>>>>>>>       * ``/proc/kpagecount``.  This file contains a 64-bit count =
of the number of
>>>>>>> -   times each page is mapped, indexed by PFN.
>>>>>>> +   times each page is mapped, indexed by PFN. Some kernel config=
urations do
>>>>>>> +   not track the precise number of times a page part of a larger=
 allocation
>>>>>>> +   (e.g., THP) is mapped. In these configurations, the average n=
umber of
>>>>>>> +   mappings per page in this larger allocation is returned inste=
ad. However,
>>>>>>> +   if any page of the large allocation is mapped, the returned v=
alue will
>>>>>>> +   be at least 1.
>>>>>>>      The page-types tool in the tools/mm directory can be used to=
 query the
>>>>>>>     number of times a page is mapped.
>>>>>>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>>>>>>> index 1695509370b88..16aa1fd260771 100644
>>>>>>> --- a/fs/proc/internal.h
>>>>>>> +++ b/fs/proc/internal.h
>>>>>>> @@ -174,6 +174,37 @@ static inline int folio_precise_page_mapcoun=
t(struct folio *folio,
>>>>>>>     	return mapcount;
>>>>>>>     }
>>>>>>>    +/**
>>>>>>> + * folio_average_page_mapcount() - Average number of mappings pe=
r page in this
>>>>>>> + *				   folio
>>>>>>> + * @folio: The folio.
>>>>>>> + *
>>>>>>> + * The average number of present user page table entries that re=
ference each
>>>>>>> + * page in this folio as tracked via the RMAP: either referenced=
 directly
>>>>>>> + * (PTE) or as part of a larger area that covers this page (e.g.=
, PMD).
>>>>>>> + *
>>>>>>> + * Returns: The average number of mappings per page in this foli=
o. 0 for
>>>>>>> + * folios that are not mapped to user space or are not tracked v=
ia the RMAP
>>>>>>> + * (e.g., shared zeropage).
>>>>>>> + */
>>>>>>> +static inline int folio_average_page_mapcount(struct folio *foli=
o)
>>>>>>> +{
>>>>>>> +	int mapcount, entire_mapcount;
>>>>>>> +	unsigned int adjust;
>>>>>>> +
>>>>>>> +	if (!folio_test_large(folio))
>>>>>>> +		return atomic_read(&folio->_mapcount) + 1;
>>>>>>> +
>>>>>>> +	mapcount =3D folio_large_mapcount(folio);
>>>>>>> +	entire_mapcount =3D folio_entire_mapcount(folio);
>>>>>>> +	if (mapcount <=3D entire_mapcount)
>>>>>>> +		return entire_mapcount;
>>>>>>> +	mapcount -=3D entire_mapcount;
>>>>>>> +
>>>>>>> +	adjust =3D folio_large_nr_pages(folio) / 2;
>>>>>
>>>>> Thanks for the review!
>>>>>
>>>>>>
>>>>>> Is there any reason for choosing this adjust number? A comment mig=
ht be
>>>>>> helpful in case people want to change it later, either with some r=
easoning
>>>>>> or just saying it is chosen empirically.
>>>>>
>>>>> We're dividing by folio_large_nr_pages(folio) (shifting by folio_la=
rge_order(folio)), so this is not a magic number at all.
>>>>>
>>>>> So this should be "ordinary" rounding.
>>>>
>>>> I thought the rounding would be (mapcount + 511) / 512.
>>>
>>> Yes, that's "rounding up".
>>>
>>>> But
>>>> that means if one subpage is mapped, the average will be 1.
>>>> Your rounding means if at least half of the subpages is mapped,
>>>> the average will be 1. Others might think 1/3 is mapped,
>>>> the average will be 1. That is why I think adjust looks like
>>>> a magic number.
>>>
>>> I think all callers could tolerate (or benefit) from folio_average_pa=
ge_mapcount() returning at least 1 in case any page is mapped.
>>>
>>> There was a reason why I decided to round to the nearest integer inst=
ead.
>>>
>>> Let me think about this once more, I went back and forth a couple of =
times on this.
>>
>> Sure. Your current choice might be good enough for now. My intend of
>> adding a comment here is just to let people know the adjust can be
>> changed in the future. :)
>
> The following will make the callers easier to read, while keeping
> the rounding to the next integer for the other cases untouched.
>
> +/**
> + * folio_average_page_mapcount() - Average number of mappings per page=
 in this
> + *                                folio
> + * @folio: The folio.
> + *
> + * The average number of present user page table entries that referenc=
e each
> + * page in this folio as tracked via the RMAP: either referenced direc=
tly
> + * (PTE) or as part of a larger area that covers this page (e.g., PMD)=
=2E
> + *
> + * The average is calculated by rounding to the nearest integer; howev=
er,
> + * if at least a single page is mapped, the average will be at least 1=
=2E
> + *
> + * Returns: The average number of mappings per page in this folio.
> + */
> +static inline int folio_average_page_mapcount(struct folio *folio)
> +{
> +       int mapcount, entire_mapcount, avg;
> +
> +       if (!folio_test_large(folio))
> +               return atomic_read(&folio->_mapcount) + 1;
> +
> +       mapcount =3D folio_large_mapcount(folio);
> +       if (unlikely(mapcount <=3D 0))
> +               return 0;
> +       entire_mapcount =3D folio_entire_mapcount(folio);
> +       if (mapcount <=3D entire_mapcount)
> +               return entire_mapcount;
> +       mapcount -=3D entire_mapcount;
> +
> +       /* Round to closest integer ... */
> +       avg =3D (mapcount + folio_large_nr_pages(folio) / 2) >> folio_l=
arge_order(folio);
> +       avg +=3D entire_mapcount;
> +       /* ... but return at least 1. */
> +       return max_t(int, avg, 1);
> +}

LGTM. Thanks.


Best Regards,
Yan, Zi

