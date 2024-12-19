Return-Path: <linux-fsdevel+bounces-37806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0019F7E54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24E9165636
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A8D225768;
	Thu, 19 Dec 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ij4uqpf8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E893D3B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623236; cv=fail; b=atkHZxGraUpMj9fn8ZAaK23I1/Q9JGhdfaMHhBafL+MWOtUj55FbZ97ygePw4JRJlzyIUbXPG5Dd2bVPJTPWwzJQzNzspNq6P0ZA6QEJ1VeJQwy+LglVvE0DjXtN94Us1KLaRb2VxklAhhyBbo6jSL7F5uAeXYfXftGzbUogdR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623236; c=relaxed/simple;
	bh=ZpkvlLK9j1VW9ITN4wMImRPbf9EAQSTM52N2u879en4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mW3d0/BkmODA5FtcOjeOh4vCgJOPY/yLZjD4dfwb5Ne2GeNulfMJg448NE5AfK6yeEPJGE8yRuTRdYQkLLI4Y1E5U4Tnwh7O696Hr8eSQSCQ4ityDmafRrtBEMvvSJQg5yQ5fXwoK7zoSRFSucTpmjzop3KdAPsAtKI4TsvdjeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ij4uqpf8; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FscwzWq0b0CZxZbStM9rtDi8H1ZBro3tCVED2UcUpv8Cy/v2QDOD0k5SjAVbuLWiQMMoq7B7Yl4PTvBmSIut4CF8Aw7CQrbt03s/9HL8qfMyJ0lPKWRAAOhbewdLXwqdUCBiHrBzdgJ/KKWVwA00NPhPYZMuWXAF7O/I3UlOgmjnanc5OwjrO+aUn50k1C+Kx6aQRSZFCoyRHsdGZgX51WtkpvqgU4Xh3ztE7ncVIg7aw2GWZtIlDbDNzYq+ryjWJjaYVIB3ezlOEIUaZZJHsRVroqZSHj76CehEzjFrMLBj3Ju6hLHh8071I/749CHHDKvJ5vTC5pRL0kDh7lPvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIY4b9lLoRU3/r0xnqwBz6xN2g+fFWls8TFAz+E9YD8=;
 b=wAX3O6MSiewrOOwacYKbkeBmGEiw5TOJcq5URS0LpSVjKhBH2UTqDFgs5D3aaQlF7QZ1WKGRKr6Z3sf7/st6nB4HCTMA5tRVvdgiFe7VYOkxksbFzNDqp6fg63Us4JRIjvQVvZPxQA2IeUrczZMPNlKIw71rL3ZmpYl5x1PqFe7zubvy2dFuMVy3fu3pHC6DFIGzdOcRpqaCfjsXwmcLpF68C8tbkW5B5OyO1qAruXtLhF+5PVgNJTF/NJSlzuDqyWSwpulGXO45rtYTDIMNzm+tXyx38eLF+A9138Z+uGG5Ik9TKCaKA2yY7BD6k3x9wwo86Unck/P6f/mNA/48+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIY4b9lLoRU3/r0xnqwBz6xN2g+fFWls8TFAz+E9YD8=;
 b=Ij4uqpf8H8PZuGUJpcUMKY6qHGyOh7GIajKl0ZLFlp1alstSl1wGd/0SwI1KGxytUrxrURDkPbuXg4mMiXN646Y/HHExiJfgSXnMWDkqZrwSdUrftsJP6qdcM7BjULgaKX/YhfB1Wyfbc29nDdL4WAxRVnfrxET5XGzbiBQQkq2H7fV+1NUerozVJ3ermPXf6XyOcqCYafYnx3CG+cF4kJvKMK2eG15qNmYAi4mgoBPzQ1gz7BR/Paa05tLwATqKXO0X+74dNQYIPUTCf2pyIJJMKMufp9+wuS+9eGJpwrUr6VnBONw/tenGpEQQvx/LgNe4bpv6idq1LsxkRwUejQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 15:47:11 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 15:47:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, bernd.schubert@fastmail.fm,
 linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Date: Thu, 19 Dec 2024 10:47:09 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <96EA65A5-EA67-4245-95DA-D0DAD7BE2E47@nvidia.com>
In-Reply-To: <b3df8b0a-fa19-425a-b703-cbe70b6abeda@redhat.com>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <485BC133-98F3-4E57-B459-A5C424428C0F@nvidia.com>
 <90C41581-179F-40B6-9801-9C9DBBEB1AF4@nvidia.com>
 <b3df8b0a-fa19-425a-b703-cbe70b6abeda@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0969.namprd03.prod.outlook.com
 (2603:10b6:408:109::14) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9a78b6-000d-415d-a0ba-08dd204466df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r5HjX/0n3IFH3k4HW8VmcJVdhrue2bpcmQe8PJ8kij1HNILzHsXebCXBbLY2?=
 =?us-ascii?Q?ET3Tpq2LtxI6G2yaKl+8q+mlla0eQQi9fS9sAqI6Oh3w0rUCBR9nKPqgwBmr?=
 =?us-ascii?Q?yvZxeJBWeug89/QlN4E6rry5qOGqUPjeGPFy5yeDzBQ4N8ejlXsmx7RZFGQ/?=
 =?us-ascii?Q?b0p6vsGj/JmMFjdeGiHSIc0LBGLuGr3qxR8rtbV1lOhEWc69XAjR3owxTWuz?=
 =?us-ascii?Q?oUCrq83eLn8yaMHS5J4rEDl3J0NB9ZeDHhlJi1p4da3f5JB/nZypYlkkJ6WY?=
 =?us-ascii?Q?TRbWhlf94mJakb0QQiCVBeuD6pXjRrH25KwW4jH9Zv8ZA/4IJ1z4KXhFA5wX?=
 =?us-ascii?Q?H35/WwfMJljQwVGFrWsE9aixalDnv/rR/BUk7Ay3/c2Wt/4fEkOiPmKlIPbP?=
 =?us-ascii?Q?Zxs9LUP+1s+pPMJ7ZQVBc5Nd//7G737DMflaY9KYotPqzvfErudQs381YXOQ?=
 =?us-ascii?Q?kgHdPrex39PmIfqVJ+mlXeKURxoIFR0NK6+YZoWi2HIT/p4z/+P6fRFGDSD3?=
 =?us-ascii?Q?BREJH8apr1K2qd3WTaLrNa0duFYXcgVVevRAU8oXIj5YaYtpistdgGQANeWC?=
 =?us-ascii?Q?Y7qXay2Kncy0ZIalWYmgRfbpBhYzL+C2olbfDA6hZmorc/xsVfGSEWRTNU0j?=
 =?us-ascii?Q?ldVzsbnaUngCPivdQwGiv9rl1nGfpVP+6ODdRZyaSEq9bBe8p/ZmFsiGwEN6?=
 =?us-ascii?Q?FIKfQB3C+tWIRglG1hsJ35SO7eOuZ679wWdJ+9D/46hdla18qSEC4mAhPOLt?=
 =?us-ascii?Q?+zMXnLh/PpezTAbXuwthi4FbvloPRfnvObluHQQ48r4uDdD1pX7NfxbMzCt9?=
 =?us-ascii?Q?rFhm0EDgnQe1DkFbQdjc4u6mHaKEJAA8y4A1R3OWSdQ5a0SPRtryGuHUtzxM?=
 =?us-ascii?Q?HSR7fC+VAt3vN2YcuIlW9jr4X2byRRdHTj/xfExRFT+lTNpwTnWVJ6AvuHu2?=
 =?us-ascii?Q?sTg6sgiFHLuK6svGV+lH9BByOP6T7Bb+P9xkrgAE7LmASHqY/e/HXQL7tU2i?=
 =?us-ascii?Q?H4X12QHXijBov16TKVT80083DusX1ON4OmwgSHUtxIn68BdMGxUPhxjjFsY+?=
 =?us-ascii?Q?pGqspz7CuK3H9KYMSu3A2b76/vf5ufFuJZVsXiP0xbHgbLndrjBoBmuwgLup?=
 =?us-ascii?Q?yxbdDjZnR/aEB6DYRfMLLbhWhhe5DZ3aG5r8UVLUpyDcWLvgkilZda3Ga9x9?=
 =?us-ascii?Q?S+KxJfAVzpCO/4JtMhw0Nesgb//05vAkDTIVj9xD68aeeIATUH+b++tGhFJN?=
 =?us-ascii?Q?GHbROWSrVzcPT/1zJ30uOIL0b3B/lEu9F19CDIopfGTR9rkkvMuRfUfCJJkN?=
 =?us-ascii?Q?L9xhqZV63Rhh90wUrFI5atGbhfYWUQYghieWaiGbFxAKk7gDF39gKEMf17iz?=
 =?us-ascii?Q?Zh4VM/7MBjPN2g2gVJLR1hm/cg5c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a/tT+6btYHRZdwtiCYfJFsO59OIfQPtxjuqL1fsh4hiumFZ4f5C9NaRkAVjB?=
 =?us-ascii?Q?AHcUvEvhUSkFk0E5NXNrpwuLWxJBmg/26LQ5HzLFC8v5iSzQMNWgC2Q7/Uli?=
 =?us-ascii?Q?+M70in3ou+kQnqOCwDEPGtaPsA25aSglc/OcF0hoPchMB+7FL8ISV00k8Nh/?=
 =?us-ascii?Q?DPskyAsxeXwton+exEmFHaK7Lb8HHjqTX6Bnb3n9g8TVL4fvj9BpQCia0EF6?=
 =?us-ascii?Q?KyBol6YBZaViQ1pTqdzlzBkS7IoOLXVr2PSSsrX1q0AkR9UTHp4e7aJkR5rU?=
 =?us-ascii?Q?r/retW9vl3gxusVvD7/m95q+PTBPLJmfFwQ7HS3z250z0hKJaUsA5ndU7pkY?=
 =?us-ascii?Q?t2MWgSiVPWgkQh/orLOgaedY/6fBEBt5SE/l26wTg16+1K5EJJiqLeBhJkn5?=
 =?us-ascii?Q?usT2c+R+XARqX1eMj36w3X80r1o6b2Y1VR3Cc2c6va3jBNJpKHD9+yR+vg8V?=
 =?us-ascii?Q?XLJyWbjxTVE9FRYKsGhCQJE4Gg7R2jw0/SS2n9bEyq8GhKu8Hx3YXJx0P6Ao?=
 =?us-ascii?Q?kkaMVLo6d1HChwjSE77VASe1gtqNLnthrtYTeb7rcNLC6TDRBzNbZVkoZ3F0?=
 =?us-ascii?Q?XpkEPJ0KeOS8lxOJ9jnydJkKvTI6tP8+bShLBNKbYKnfGmFJJbk4sX//tNWE?=
 =?us-ascii?Q?bEiKLPJqbkdAoqZbD/B8H70uzvH4Nbc6IB0jiu7uy2tsSFjYnzyC5xH4TmH1?=
 =?us-ascii?Q?/pgO2AsfOWZFQ/hDXyu39vb7Hf4ey9uMtNVRCNKF41SYQBuFabqvKntNSFft?=
 =?us-ascii?Q?g8z+9TIRkh52RX+RFXKwqy/RO3Yn4ttKsiVDpyVU1j6u/76tdhD+O+RRW7X5?=
 =?us-ascii?Q?xQ0FJe+4fLrW3r6L//1GyZZNkj5mRiKpwTnUsnvjXSrSYEIkfT/bAF2AFymQ?=
 =?us-ascii?Q?3hPLY2wyXbnXF37ioKyYF3Ai4Bf5LSRC448CnK1QZPy61E8Vo1Ygrw9FpeES?=
 =?us-ascii?Q?yXwFrcgqm2bP8S8WqjUlIoFRrxDIwD3BY/S5aUlAllgvzWJAsgkKIkdufm5K?=
 =?us-ascii?Q?fplyuVHgXadQ6i8iDtCyoeNimHCtquJxYZps7A9pJdndZoIpCvr17R/cC6Ag?=
 =?us-ascii?Q?eMXABTY4o7Hg5LqsXsBlTUM+BAzC6m9MEA9nQ+Sz3uTACvGumzhLNkyRQLYo?=
 =?us-ascii?Q?vU8ATNllz1ng+G09+mf5IOvK3E1STWTV0oThKCfg44RaJ1woAB6P8+jrTF80?=
 =?us-ascii?Q?b0LW8y7HAgpbDefWFyFtPUQvMr72BkbGkiD1Wl7JcX6D9AjT8lWvYa8+O0qc?=
 =?us-ascii?Q?93faxqoE1MQYlBIWGWjADNEzZnxqBODgM8rcNcyXcLVC3r+ZUB3nRdVTrF+X?=
 =?us-ascii?Q?sFxUKISoX708wV8EU4392Gd7rQozpGlDpscMr1k7NE1SWWUu16wqxRw3DHSa?=
 =?us-ascii?Q?E+jEx/CByqNqmlGAyjK+9UQQwN4MviOr5d83QyOjU59BjQoMl5BvZAfzGSqQ?=
 =?us-ascii?Q?IntqxteF6Y6Pq2ZEvd8hZQNvuoMn9hC/GEnKh5kPKVRcId8PWh9bzme4Sah+?=
 =?us-ascii?Q?xzXEuCxlDayBhMwPSN4cCSJVZwwNUai6GxwhjCJRdeVDEcLQjzUc7G+/p00i?=
 =?us-ascii?Q?mXYNPlDqENFe199kmAYFIYEocE9gcFmruV3roeod?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9a78b6-000d-415d-a0ba-08dd204466df
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:47:11.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5D6i498X6nds8bXBkSv4DStB1ZZz0Yn/eYufQRSi/YVFy2TeSQ8nW1Rl7VJtzJN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569

On 19 Dec 2024, at 10:39, David Hildenbrand wrote:

> On 19.12.24 16:08, Zi Yan wrote:
>> On 19 Dec 2024, at 9:19, Zi Yan wrote:
>>
>>> On 19 Dec 2024, at 8:05, David Hildenbrand wrote:
>>>
>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the foli=
o if
>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag s=
et on its
>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mappi=
ng, the
>>>>> writeback may take an indeterminate amount of time to complete, and=

>>>>> waits may get stuck.
>>>>>
>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>> ---
>>>>>    mm/migrate.c | 5 ++++-
>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>> index df91248755e4..fe73284e5246 100644
>>>>> --- a/mm/migrate.c
>>>>> +++ b/mm/migrate.c
>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t g=
et_new_folio,
>>>>>    		 */
>>>>>    		switch (mode) {
>>>>>    		case MIGRATE_SYNC:
>>>>> -			break;
>>>>> +			if (!src->mapping ||
>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>>> +				break;
>>>>> +			fallthrough;
>>>>>    		default:
>>>>>    			rc =3D -EBUSY;
>>>>>    			goto out;
>>>>
>>>> Ehm, doesn't this mean that any fuse user can essentially completely=
 block CMA allocations, memory compaction, memory hotunplug, memory poiso=
ning... ?!
>>>>
>>>> That sounds very bad.
>>>
>>> Yeah, these writeback folios become unmovable. It makes memory fragme=
ntation
>>> unrecoverable. I do not know why AS_WRITEBACK_INDETERMINATE is allowe=
d, since
>>> it is essentially a forever pin to writeback folios. Why not introduc=
e a
>>> retry and timeout mechanism instead of waiting for the writeback fore=
ver?
>>
>> If there is no way around such indeterminate writebacks, to avoid frag=
ment memory,
>> these to-be-written-back folios should be migrated to a physically con=
tiguous region. Either you have a preallocated region or get free pages f=
rom MIGRATE_UNMOVABLE.
>
> But at what point?

Before each writeback. And there should be a limit on the amount of unmov=
able
pages they can allocate.

>
> We surely don't want to make fuse consume only effectively-unmovable me=
mory.

Yes, that is undesirable, but the folio under writeback cannot be migrate=
d,
since migration needs to wait until its finish. Of course, the right way
is to make writeback interruptible, so that migration can continue, but
that routine might take a lot of effort I suppose. I admit my proposal is=
 more
like a bandaid to minimize the memory fragmentation issue.

--
Best Regards,
Yan, Zi

