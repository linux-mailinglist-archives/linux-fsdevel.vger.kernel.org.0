Return-Path: <linux-fsdevel+bounces-37816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EB29F7EB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E137A10C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBEB226896;
	Thu, 19 Dec 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VbKbpCgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23527226554
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624037; cv=fail; b=KtJggBDDxs0TCCWAgoIr+hsfbmCpJ5m7W7gl5cT+c7dstke4150I5B6N2MSV8Z7XAb7eWq+z/xZb/S58CSCR+G5rF7v3nAZUXDSLLyhyzPYiEDLDK2NB08fixTUJN55l4yXVsB4+2EzPK8wNukZ95MdQS0HYmZ4sLZ5tflypyIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624037; c=relaxed/simple;
	bh=XO0wNihup93Tbr6FWyDtQjSeZUXC28Qa1oea7zqcVRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ov00JcbxElHNcDwPBTk+MUkck/OdZ7D3XI46ejihBiGJ006tjIhBX+eGfa9TyxW5t2/Cdm2BN5eFNhqaeW2cIwxrRLhw72ZV1HlP/fvtrDlMt5TS21rS2N3vmEOzHve4CjTyGKRcE6MzTT83KsMdeyWIOHU3kDB98I5UviSlYqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VbKbpCgO; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbe+iu+R+2wiTWhCwXJDn0WFe7k5N4LGeoccAVgLrcuh+jAa7km3U5tmSEflFFMGHc5OCrFvVNEBHp4xsqYcPvztlgVG9g9pEfQRZsZv0RXeEszPWKuLcTHEalDTR1pIHYPIYp7AfgU8BUdKoHXuHIfOTy9GAYpRDlQUz28K6EqMl6SZONaUEnqp7thlOMkQDbU7k8sQJuneIFaSEblgt2EhOAxzvVr2KLzFOzy4dy3FWjei8f7X44WPlZgT8vWFVkzUlvmoVQmO/yhaPJzJabcF/WYNMF4/Gx5352O65a4qJ7+rXLf5k2YURX0EKgT4CgD4jNCoe1gQCZl+aapgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqNce4BBACBkeonVCRM2EGUAHpQDTxluFsILnetzutg=;
 b=ud39Y6DAIM/jJPq1aDCaAFxhDBowKz2kaCNAdqlh33+gdvd70F237R8vER8/1CYaqn7JA14mNuu8PQZKehCGl6+1r8Haq/kCHdo28bEg4S3hB2pXeOKJFD4U2pqzaf4u9PUOChA/fRG4x+XFtgUzWgf77Tp3qNpNsAPnfFbid6N/+RrsyH05PO3BA2VbFawDxuYZ4GfrvG/m1gvncG7Wvn8fnTAk/droddp8Pl+pp+//OgbHYjVwByNqPhYQ5mrP/ZAizUIW1M3/BHZA4hYvZtKvJyPy/5hB4OwE6/qkchHH4xFfObugvXXjPaj/xXxHkVlTjZFb760Kr8da/Joalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqNce4BBACBkeonVCRM2EGUAHpQDTxluFsILnetzutg=;
 b=VbKbpCgO72pOd6iAUR1MtOGlvHo6Y/BKYX6vWvluXQ+KIvZUfwVdd//75S8VLCsoWAdSe4PUpKVXd4qH+Oy6YIaDyyvz8GPKX/lI8y0BU2ZWEuxVriqsDOaq6sLRzm1Jnx7MItvcAXhgh/aFpwSz55fziY7ChEUyfjGT1IwZCoXxUTkzen43XB9iSoTuTDtQxYboKETw3QovIhgzLptmkv6bXGbHAWI+q6yyRiKIXn+/vklB31ObFR5pv+kXvp/3V3Ibyx3dwFxvMMKdYHRUKoSPv+SLn8GddZN8bBi89PMH/vp4VI0Q1wNiHaCms/+wKrbBd3wNvKf+oA7k5Grsuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 16:00:33 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 16:00:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 David Hildenbrand <david@redhat.com>, Joanne Koong <joannelkoong@gmail.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Date: Thu, 19 Dec 2024 11:00:32 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <0CF889CE-09ED-4398-88AC-920118D837A1@nvidia.com>
In-Reply-To: <ec27cb90-326a-40b8-98ac-c9d5f1661809@fastmail.fm>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <ec27cb90-326a-40b8-98ac-c9d5f1661809@fastmail.fm>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:208:329::24) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e3c1a7-2436-45b8-ac9a-08dd204644e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mG6plFAqueLRsZzKzZIxVpQjsauiCmrCckq1rCWrV2xH2ejtyTzrJymiUFpw?=
 =?us-ascii?Q?6Yb91ax9pubWLZrPv/a6mlpLIzFuKxQhYG3TgVlrf89ku66cMJq3nBOMo2Sf?=
 =?us-ascii?Q?ngmC0vr9yiJRv1bindQMY9AuHqbgqUFBolasrhNwXtNPjqwEHR3c/rYnm0Tw?=
 =?us-ascii?Q?TyYknKegY5p5fBuK9B7ZDT9OM3ry0xYwYlYV9ALUD5uFTADTTiL3gpkDREiN?=
 =?us-ascii?Q?zKfEWy8p0cVPKfis7KyscPX7zRpQp68DqWhyA2T03rfMxdQzCKZBJWm2KY8s?=
 =?us-ascii?Q?+1GQtmqfuXY/MsgLXOcYllXyKZN4e1cjP+z4fh3K1eLd2ixu9REy5z8qlaE+?=
 =?us-ascii?Q?jq0raiPcV8EBLV6g7O2bbaRs2RwppvwdSAlHOQjyuiWyTetEYrEenxI4Glcb?=
 =?us-ascii?Q?7gy9mQWJ83WtoyVkPBg06jf9T5U4utQ7URMV5keOMpypDAG4FJ5tQCK6Pl4r?=
 =?us-ascii?Q?w5d8gauYK6c0d3ImaTsu4J671+KCnjDVhLH4N/NShsymGPfRwHQy/HUzD0l6?=
 =?us-ascii?Q?F5Ec0Q5MxW7ouE0OO7ZLF6boAw5tarTa+vituIaJoJA/QRFbVb+x6HYXIpY2?=
 =?us-ascii?Q?HfSySyUV8OOBHrD6WhdqGq6fE2ROJnrD0X8UNqmojtj1YiSpQSKlejQw4flD?=
 =?us-ascii?Q?+ZGiHHlIVswQiyeZF7FgA1EiZsInurFmp0pRal1hXVuqSxR8RzkuEy30rK63?=
 =?us-ascii?Q?18VrgB5LdGtbAHZrCdZGBNr/gwPSz5eUdUfq0jT7SOw6SVHbIf4YEHcq//T8?=
 =?us-ascii?Q?GmzU9bqDU2fuG0nOyaKwiczcQVuwEL0ifRgG5sV6u1WimEI24hWM08Hswa+E?=
 =?us-ascii?Q?svBfdjlFrZRoBHmfCA9qsRIAtxvvL8q3OxNt+7VWK0Z2phW04MDox+Tmpr3E?=
 =?us-ascii?Q?ztNHXon9xEVlua0+aciE029tr+HeN1Gu6tII9AQmz6Img4rBsL0mh9HJBXq6?=
 =?us-ascii?Q?K01URHDJFZFjuuGxLRsLi8tHUuNVS/soHpFfYgW/D+49azFmBJG/Mg63H7gB?=
 =?us-ascii?Q?l2ADhMI9yagMlWIrxW345/IT98CA9/dOenwvLGQMwB8MJ0VS5IlZJLYeOEfA?=
 =?us-ascii?Q?u/TZVXd15wfUaU7WU7bUukw1Njboid/Kw35rNNdDjuS0LYgUu63ZHSFcn/rI?=
 =?us-ascii?Q?E/W9CvakPQW8d0/1lU49lXPUkqWRAlb02DxTdbAFJDcvMXFCwtglpe3i2Igt?=
 =?us-ascii?Q?yrXzT5rHT4j4eF6c/KkOEaKKRLTEA9JQYN+OGpTKM6gQuFa66XGJpXPAWzHX?=
 =?us-ascii?Q?AK2HMMPs+wGcsKY9+rz+IcC0TkDZBEelR0sg5cHAlNeDAsP6F8QI+aPPVNKy?=
 =?us-ascii?Q?vLNeoIbJtsR9FYoSRbNPc/pFhZ56TupDU32XiihG0LEQygEK+czIROFlkMyt?=
 =?us-ascii?Q?KuBgZhJ6LHcvfkdNnGjPh6Mknlxg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SvpqbwvpFUfHafuOO1APLpPYbAzEzlfP2NGXi/eJrE84UXX6mQuZUvSDUwM2?=
 =?us-ascii?Q?leBVpgglTv4rEqyMla5G/LndMimc1rZt2x1gy4hfqZdL86RnUu6mtBXPWLRo?=
 =?us-ascii?Q?uJOry5KclQxByZ7MLpJLpRiEZJz0bURNDmXfKQ9zqtXuoswcnvD2bX679Ivg?=
 =?us-ascii?Q?OROAUVifOaqScqzFSi5w7Kjt2S/HWaoJpecGYOnYRBGVx3SHyWNtWoEkvNlW?=
 =?us-ascii?Q?TItx3aUtL7AcXWW2lVK/chFuT9gpODqasX976nqepvGpgS9yOSiGsw40uHNx?=
 =?us-ascii?Q?gtUvtDxmijtT/zswqeD+BRrLpGGb5nLjuetafp77clBlzZPLhpJ47hMfUuik?=
 =?us-ascii?Q?3y0xtkm4630zb7kzC9EaIBsdoKrxL1fn3KXSf6DkF0g0Ja6txTpD9ORgGVem?=
 =?us-ascii?Q?bjumNn3om0bcAwSAivsHSM0hM6+BBiWmX1GUmtzUmP4JZGDoGQIjYOhctytl?=
 =?us-ascii?Q?E3WfqXOl9aUy+am8kjxY2+vnFrMfSLeox8DJDIymSuKPxkMFm2tYAv2gPptr?=
 =?us-ascii?Q?cJDnv+tpyLCN1malJ0yrqz8lsFLjLGOq9046uHFwSHd62OIXMypmamBKf1Cg?=
 =?us-ascii?Q?eKwfXvguLFlBq8g3Oj1+9N+3wCZEbrwM217U2eK3Dq+XB9E5O1pV5qJKJWyp?=
 =?us-ascii?Q?KAJvYzaqWPXbixRB4YxM3MhufwxKW4s7H7MkYbv0m1666tStNLIj6jf2h5At?=
 =?us-ascii?Q?UjWsGM2vYMyrVe07FXmeybmtsb43YJi4lBaby6feKewanXYwyydGA3G93Toa?=
 =?us-ascii?Q?UQAiBub9BlY6nIwRA2mFbMnck1txSADzXvu9sZa5LPFtmnfReDKZPiuRSX8l?=
 =?us-ascii?Q?Pflm8F5RmRX5PrkxhEUxraa/FdwxbURjmefin1ovJRnVyd1Gjgrfx3VgIN2Q?=
 =?us-ascii?Q?wuQ/CtMipVeaEtpyuGNI7u6KyE28uzH/cqLwgdWNgvwSV6T+2EYlO/XXVFcs?=
 =?us-ascii?Q?YuWp3JsA9hyt4C9wXNiZdIMeY1G5lurE6i1edGuxqDcHp2VdYnXeFabZBugB?=
 =?us-ascii?Q?lAA0JGBJWO1u4wQomsYKMWyA9vNsuQXyq+ZKUc9WfBZbDe01gbfi0LfOj6sB?=
 =?us-ascii?Q?G0hEWOAEKX4S3i5dRr/Sy3H1BOwKhQ816BGv/bdN+RLaVpTc2xvJDlcxmQrz?=
 =?us-ascii?Q?ocfQIDdGWrBKfPrXiXe7gTktuO/3hQAazbNHwfkdHfddw5iasS8PmTqM1ulK?=
 =?us-ascii?Q?mYbF73prZgNTQHb1VcYo4rM3PugwQOudRq5k++IyFpHJbw+2oD3R6w9J5xX3?=
 =?us-ascii?Q?osdNlriqBLOrNVXc8s1T3tQcbf8yz/0yppWx7o8Rbfo69v+IDkQZOduSz/8e?=
 =?us-ascii?Q?K4qU6V53Cs9alxay4wtcu98jycNFeaCLB1eMKIb0nXrtWJ1zUtMUPfE3hnaW?=
 =?us-ascii?Q?8XkaieMap6fLZ86LrNsNy5lSV2IyBYbtpEUEKZgrlYuRI5U9YYi4dz+/VoqQ?=
 =?us-ascii?Q?KSCibkio8tsjF+/Y7zVGwL6SY3Q4oIwi5nrC/66iya6LoBh1Ed0kwf21a0Bu?=
 =?us-ascii?Q?Ae4KuYOkCpSY1NNCNc4ZkwiioXrPH4rU5DHYRvvguRxEQaowr0eCWhdAw2mr?=
 =?us-ascii?Q?SL7sggEkoJAGX4UdDtmeumzRF82GYH9aPSs3k2WH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e3c1a7-2436-45b8-ac9a-08dd204644e0
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 16:00:33.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2czCCTaFbMFGyh9A7e6XVfdQQc6wXpr6UfRdaghnrzIm9QhqDTHwCOT/nvjE+z/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996



--
Best Regards,
Yan, Zi

On 19 Dec 2024, at 10:56, Bernd Schubert wrote:

> On 12/19/24 16:55, Zi Yan wrote:
>> On 19 Dec 2024, at 10:53, Shakeel Butt wrote:
>>
>>> On Thu, Dec 19, 2024 at 04:47:18PM +0100, David Hildenbrand wrote:
>>>> On 19.12.24 16:43, Shakeel Butt wrote:
>>>>> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:
>>>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the fo=
lio if
>>>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag=
 set on its
>>>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the map=
ping, the
>>>>>>> writeback may take an indeterminate amount of time to complete, a=
nd
>>>>>>> waits may get stuck.
>>>>>>>
>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>>> ---
>>>>>>>    mm/migrate.c | 5 ++++-
>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>> index df91248755e4..fe73284e5246 100644
>>>>>>> --- a/mm/migrate.c
>>>>>>> +++ b/mm/migrate.c
>>>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t=
 get_new_folio,
>>>>>>>    		 */
>>>>>>>    		switch (mode) {
>>>>>>>    		case MIGRATE_SYNC:
>>>>>>> -			break;
>>>>>>> +			if (!src->mapping ||
>>>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>>>>> +				break;
>>>>>>> +			fallthrough;
>>>>>>>    		default:
>>>>>>>    			rc =3D -EBUSY;
>>>>>>>    			goto out;
>>>>>>
>>>>>> Ehm, doesn't this mean that any fuse user can essentially complete=
ly block
>>>>>> CMA allocations, memory compaction, memory hotunplug, memory poiso=
ning... ?!
>>>>>>
>>>>>> That sounds very bad.
>>>>>
>>>>> The page under writeback are already unmovable while they are under=

>>>>> writeback. This patch is only making potentially unrelated tasks to=

>>>>> synchronously wait on writeback completion for such pages which in =
worst
>>>>> case can be indefinite. This actually is solving an isolation issue=
 on a
>>>>> multi-tenant machine.
>>>>>
>>>> Are you sure, because I read in the cover letter:
>>>>
>>>> "In the current FUSE writeback design (see commit 3be5a52b30aa ("fus=
e:
>>>> support writable mmap"))), a temp page is allocated for every dirty
>>>> page to be written back, the contents of the dirty page are copied o=
ver to
>>>> the temp page, and the temp page gets handed to the server to write =
back.
>>>> This is done so that writeback may be immediately cleared on the dir=
ty
>>>> page,"
>>>>
>>>> Which to me means that they are immediately movable again?
>>>
>>> Oh sorry, my mistake, yes this will become an isolation issue with th=
e
>>> removal of the temp page in-between which this series is doing. I thi=
nk
>>> the tradeoff is between extra memory plus slow write performance vers=
us
>>> temporary unmovable memory.
>>
>> No, the tradeoff is slow FUSE performance vs whole system slowdown due=
 to
>> memory fragmentation. AS_WRITEBACK_INDETERMINATE indicates it is not
>> temporary.
>
> Is there is a difference between FUSE TMP page being unmovable and
> AS_WRITEBACK_INDETERMINATE folios/pages being unmovable?

Both are unmovable, but you can control where FUSE TMP page
can come from to avoid spread across the entire memory space. For example=
,
allocate a contiguous region as a TMP page pool.

