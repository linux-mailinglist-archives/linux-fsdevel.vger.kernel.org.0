Return-Path: <linux-fsdevel+bounces-64405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A29BE6020
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 03:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5F51A65EBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 01:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7C01F584C;
	Fri, 17 Oct 2025 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMLdziGr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39609749C;
	Fri, 17 Oct 2025 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760663016; cv=fail; b=Hd+QMNFaiisutiuMifECWHMfhKbd5DT0RuaBlUOUfgfi32Hp1XcLn1RRBB1EfbPXF0Zvjfj/7d/IaW6Y3oPQAu3zzl3IHmvYjpMzyEVgPkqdDjwF/whUHQQTZW3qelomjnyVo27I/d+I+Fhpbrd4C6ofzxIHNLnjGOZEeWsEYrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760663016; c=relaxed/simple;
	bh=EuBLSdUyl8/0bB7JoIi/vuHDZwDD4SUNSsmtbJ6s0BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fctzBO3L/09+FkiBpm4NtHL6vfprqkoV9Ytpu0aLSxVWjuTGXBp5/YCyv+SGant9cSsBOJZapVbdavl75jY2z+/ytlXIAm2BJCe6Cl/2EmDDYtMTQft1Zf9+9JxQ3iZEUzumWgt4SdzS9MTTwGLE7X6ch/6OHw1CvxuCrKMohRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMLdziGr; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZNWAIphS3HaIVTrq8ata/Buv1m0BP23kAVNjHBgFsHLyvlbM2ITnOKRAwowCEKUG0ltljYaHOBlBp32HJqaZ6xlxQs86MKhjp4yGlOnEHPijxk7HCSZi8+8ekE1ZcDI0Nxj4L48t6taS/88XZVA9Za878gyMvSSOGQHCsZz0V3MvC4IhM7/zmzuR/0UrTZ9CZ55tyjwm7a+tkdy/tFC5AilV8+/TLzwJyUQKF3oXKFrb5C9jND1A4tpuESSqcEj1N3e0IcnR9XlZHDv39EnmB3hocPJQMzHpmePHPZRbIObyTAvz+WFDMBVJEckHrVc6BNdawymljpOOXNZuaN5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzhxdWanHRXoBAIZMknJ0G0ktLYH/1rCosAVZXAwFgY=;
 b=LVQw0YszbKmV/Ki0hlI5TxsBH3aWgwPktAWyYc+yxkBISRJmRStQrUllFTXFZ8DtvIEWEr2j/HB52Eb2gcbgsWZVvoA7ERWc1QKFZ9QnyYbxij/IIA/B6SOMfRsKjd432qw1kr9GA5NXgvp4OUJry4gwmvf3l1ZSO3fuqfwNrjAWZWeJxcXl86ww12da1DqDmP/PYP3F5Clh9DWM3io+jdsy0n7hfNghIpa2tr6Xb5QvfVKgoZyGrgzacUbVj3T7Bv15YntHmKFaAghmYI8bzI5r6phrO0q71EoCv+9Wk0Nlnq4VnwEoCBT6w8S3dqMYgPWiAqg1BJnqo+ikHGgtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzhxdWanHRXoBAIZMknJ0G0ktLYH/1rCosAVZXAwFgY=;
 b=RMLdziGrTv3SuAtyncqDhN4GZG9qJoV8z17B4pRVuj3TU49Z9H9LKjw8NM2/6Bzdyqmyk0V3eDV58nkywAeYsHS1MQDh+jRXFeiJOFnB4it6i8JwPhiUbseMxwXc3z/OfCkXuxe8p+DzHpDiv4pJQdM15bVVeRYf89iObXO/vAheQZTnLw9NEmcCwBVJM0AoKleOXwHflb1fSIDAjnn1h/ec4jjYC9SNdB0MIA1jvhynydVwXUi/DK+Ov8yUxsuM5oKGPC0w2e5vIBqXXV5IYT3EvH9P56G2u6RqdMvsw97oFrI9C0+RHem5U17Zp7b8bsCRbe3KFJG/ra6stfUIww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 01:03:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Fri, 17 Oct 2025
 01:03:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linmiaohe@huawei.com,
 david@redhat.com, jane.chu@oracle.com, kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Date: Thu, 16 Oct 2025 21:03:27 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <E88B5579-DE01-4F33-B666-CC29F32EEF70@nvidia.com>
In-Reply-To: <20251016135924.6390f12b04ead41d977102ec@linux-foundation.org>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-2-ziy@nvidia.com>
 <20251016073154.6vfydmo6lnvgyuzz@master>
 <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
 <20251016135924.6390f12b04ead41d977102ec@linux-foundation.org>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:408:141::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c2fcc9-5e7c-411a-45d3-08de0d18fcb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJ3ypjaSSzsoMFBUTNNew67VI94/NY3Uz/jwahvhKrXtN9cIPmX1pWlewrnw?=
 =?us-ascii?Q?EM0nXTsJaDwl4A7kA7Kq/UppC1W9YD4NhkwA5APaWucqQSdEiWXOUKLwALtd?=
 =?us-ascii?Q?CEJO5eixkURerhPLFmG5zgGwFGAF7epipJgwjqXnOLIVvZJe3Z0nebvp+m79?=
 =?us-ascii?Q?seFveIEP2gLNuytxSAZo9PKkdiI4UajrAhP/ZWPsK8UPS3bTi0NyY4QylrNY?=
 =?us-ascii?Q?2DsmnHO3PbjW/TMy4ra8psyENwKQDtV3wkGLFB5hwG4t8Hci9IZkCiUNu49Z?=
 =?us-ascii?Q?hTJoEq0cdymr7utGk8TYoRboe/gblGpNJg3lgjUxh9Jl50hXLYwHmw9MBlHl?=
 =?us-ascii?Q?aRUnZ3jvEtyEREHU7NM8Lwls2a1OQXbImBQBS94wc3e+/K0XoELE9B+Bl+Sn?=
 =?us-ascii?Q?tK6ln/p/A76g6JdB1lcAQedPsTqFgiJOcdXhflBaU1x5geJgePsgYA8gbw0t?=
 =?us-ascii?Q?sviJi1iMXv8zSYXz+q1jZH0TLgbVNU6csYeM3KNYYZanGXswhJoamxim2SZ2?=
 =?us-ascii?Q?HkOczstCspY4X/gY621a3SF/0WHoKaNXp5fLeR4JEURMNQJ9MCpbXEmiLgt/?=
 =?us-ascii?Q?8wwtwZR1JYgFroJnbvNQO3miROCvGleXI43EWjTHN6IJGyaHv0bcTV8pDJmG?=
 =?us-ascii?Q?jdVMITrxam5tPSDP6fabqOjmbXA1HKiTxsBdfAJ0ppXiYc5rRJbppIAX94A0?=
 =?us-ascii?Q?UgBCu/oy1tSRxA4qQkEEKokGl6CQAl0KH2YtbwZSTjtUAvdsBpVEEg49DBV9?=
 =?us-ascii?Q?NfJNi+69ecvddogdPoOg48qPAqchbS3JPIhkaxjKkgu6LZXWU2lmROVYstCs?=
 =?us-ascii?Q?xV4wKOP+wcGJ2H4oY/9xwfG3ltij355IvDqmh45hE24vAesq6pBVzWQJvxGA?=
 =?us-ascii?Q?PXgarEXxgTOdC++pydQVNA7qVtLk2cSXklxZDgjWXX16yy1wiXXYAr2pXEcW?=
 =?us-ascii?Q?VolFx8RkC+79i7PcBIkBcgg2x1wCEi4PQuL141JILTfz2xsrBX/U5I7kIrHe?=
 =?us-ascii?Q?8M6SEBQZ17/G7PIJQHPsvdDI8Gb0pLdhztX8xCyTTW1yQ5G2q3HBI+/Ck6Yu?=
 =?us-ascii?Q?nsfqg1x49CpTN+xnk+pXzzTvbheFyBfOklniPELACtyEPMAIMNOwlNe7VdDw?=
 =?us-ascii?Q?GaEeJr1bx6OFdCc59EZIDzAwAsUYhXOH/eh4E3Z6ToZZjWD51dKjJRwCR6w3?=
 =?us-ascii?Q?ym3TJjXQthG8IaTItM554es6PenApNw49PLkWTDTS2qsz09fIUhcsc+OGL16?=
 =?us-ascii?Q?LOFA6Vox9QUkW3/FPVRjB5aY/w3LpDLCriswmupgCTOFxHt4ZrVAgXrzkzti?=
 =?us-ascii?Q?W86dpyXGeXirox8yp7BmRLjY7KSG882S/IBre85e0in9VEmo59Etr2fm9BKA?=
 =?us-ascii?Q?Pndf6rAiOI/gCtioB8VEP0t0HreTVMk8C1VmuEqEdBlSR7EGQp5kYnfIkZoa?=
 =?us-ascii?Q?mNzI3qMItfOKWRPFULbUB+WiMg8oQoBG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uk5oq6LddaExBH6L9z4ICbQJ4Vw9i1p+e0xEees7wFaSMXqNQpebbLFF/92p?=
 =?us-ascii?Q?elku4acRCOfrhKHYhR+qbUMlaX1/1z4sk4DgHaIl/nmM3bbC8hEhH6OjVbnY?=
 =?us-ascii?Q?OgNWcfLr7gZL2/B8CLhVwLXDkFNKPufXtTV3cA7mQuRDib1xLWpKqdnk8A1X?=
 =?us-ascii?Q?lJ4RaJBopUkS/m9uQgv9lJUUz361Q4JMCuN/bKYoc9BTnoiqkopt5VpZDM38?=
 =?us-ascii?Q?7695aOVwjuaUw6IvwvWFSmlUPo1k2Ger5VoIhhX2nB2YsazuT/wzoEPZ4fQq?=
 =?us-ascii?Q?Ag2um4TMlDT/5eyqfo0siKGybpGgwTFgpuKxYPGNLxbQfMSCxGJsBFVptUtO?=
 =?us-ascii?Q?CCJ2qDsMmsRsrwRYPZ7ws4PSRCXtv/X6q4RKzmqEJLsxpptwQRqfA1ADz6oH?=
 =?us-ascii?Q?r+WD+HW/9SPTq7fG6G1gaXH97hJSc2tazJatvdejHxd53ODICvMOp81UiufS?=
 =?us-ascii?Q?7WwenYLDLnmcA9ZOsg7rfDPpG0d2WqIYSR7kzSNWBG+5ZczyPoQocQXAML/1?=
 =?us-ascii?Q?Hpf3ZWgFtkEaL1oYTQ0845u1QODiMafDOylgEsVmpyqT5Ct2sRMX9W5AwBxL?=
 =?us-ascii?Q?t1f81MRLusfym6fw3KwqfKkPAeyoyO6JGqoVM10gpz1jFhZQIgNW8FfZbfHM?=
 =?us-ascii?Q?uiB10FYfumAcu2mPswYS8ETfg5D2cq2NQvdS/xOw6q/cxju0K9z+GpAjzQI+?=
 =?us-ascii?Q?oLp1RHQM/gpOpgJeTgYZVIREmv0fsThrok2wV24n3lmSWx1/gxAJBBfKzJfG?=
 =?us-ascii?Q?Rs1THMScDJfQsaFvbxlxJ7TH/SaTs+nIV06k4eLAn5JICSiNbbxdck1wIJTz?=
 =?us-ascii?Q?MO1GhDP59bZlIwWjB4BRTmVEpEbLe0uf2Que1WMUMgYfLBzifDLHdrpN/DQF?=
 =?us-ascii?Q?nC9kWs5qkx3hvhIC4lux3EwJAB3ot/QWobyqgR4vLoZbIsy9Zu7Y1nZ6axC4?=
 =?us-ascii?Q?SlVKz6/LIw/Z9CNyegaqzT8LsCcB3rIxWW/EfP4Fx0hZUQ4KY+PWb38Dq3FA?=
 =?us-ascii?Q?suYz8bBK1o45SmLZ9hUcOJ44TTsKvIga1QQ+ljBZ39Ugh8sKQih/bVdRRHPs?=
 =?us-ascii?Q?cfBXsEVReuhOu+UV2k9K0A2XHw849FgSkm3l86lWEQ2yzx8YLdkRz4x2Fi0T?=
 =?us-ascii?Q?tRPUqU1Jyra3b5uPbkTsI4l/HtvnLUNv5j3x40SigPWQ7zHw0CqwO4zaE+Um?=
 =?us-ascii?Q?AtRkQEi6czSd3BAIr/mkFDS4qd5FANDHYWyi27wX54x9dgHBqNC3vZ2OB6W5?=
 =?us-ascii?Q?ZyK5uQxDvViZk1hR5TSAEIC5E3lH7BnisQCHI6bWLQbIly6UykAcacIjC4K7?=
 =?us-ascii?Q?mxM9UOctbvZ2WtU+YRYleJrj4PD+bgdPjRVPH1rOd71kIVffWfxhVAGbKAI+?=
 =?us-ascii?Q?ETDIcKkzOyNi/ySEh6HroliCP70ejGHALvoqsVQ2SOjBuOg3W/+lun3rq4Or?=
 =?us-ascii?Q?po6Va2RZCWQ2dLCX7hR0FLqcdatawtNPuV/Dd5lpxXd71dpsia6EMMd3yOCv?=
 =?us-ascii?Q?4XvOBPhvsohfqY9yQ23ruOnG0SRnbOs928Zy2dsSdbZF8yKVQh9s31wMIkmz?=
 =?us-ascii?Q?Gb74C0lDFT/eJVu8TCchMe2KzSYPc2AS7qD2BpiZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c2fcc9-5e7c-411a-45d3-08de0d18fcb6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 01:03:31.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ORmJng5stZeMiwlkFHzd6ZnoCWAGclN7/Uadzb2xlGKnl+AIHYBm6k5ungMdEXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723

On 16 Oct 2025, at 16:59, Andrew Morton wrote:

> On Thu, 16 Oct 2025 10:32:17 -0400 Zi Yan <ziy@nvidia.com> wrote:
>
>>> Do we want to cc stable?
>>
>> This only triggers a warning, so I am inclined not to.
>> But some config decides to crash on kernel warnings. If anyone thinks
>> it is worth ccing stable, please let me know.
>
> Yes please.  Kernel warnings are pretty serious and I do like to fix
> them in -stable when possible.
>
> That means this patch will have a different routing and priority than
> the other two so please split the warning fix out from the series.

OK. Let me send this one and cc stable.

Best Regards,
Yan, Zi

