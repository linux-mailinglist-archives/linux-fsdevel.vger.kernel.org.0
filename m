Return-Path: <linux-fsdevel+bounces-37810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E89F7EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75B51893279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F25227567;
	Thu, 19 Dec 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tpghmTwH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4381727
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623722; cv=fail; b=jyEwN3zShQaJ0UjPDYxGh1gpm6dnW0JD3G/ht3fANEVI+H7SgQDyeTwMqPH0tv4JEZMVt73QD96zZzEvdZoeUsQ5IaBsnSlYmFw7/+a1cxzfTNOKITREaYZNQgrmPB2YME8bEgGwx1NIfgiHvToFEpgJI6g6yEG31/UeNbNMtIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623722; c=relaxed/simple;
	bh=xz3qLXJ8F9LN2lQHWMJOPJdXeSXt2pL02wzBXETdDWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Al+q7sJUs5LRz5xqr5I0MY5+S8S7PBby5x6Gl7/sXUNNgnFoDjKxDFE5JWl9H8OFypd/SdheqegqARtUKEqSOr6Xe2oM1wh6p7Ijk+MDWQFRkTet4u7oyjfNIv00b1x2VVrreOk9mf5qcs9I4j+ps5+DMwrj83E2RIX5cFri8NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tpghmTwH; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocEwPclbwZo5P2JLaPv+9xi0a9iisv13cMwP7A4z4RNj1IURaEcSY2T1aqGuRG00/tFs+w8TwD1yN0VmN8oHfdJIai3+1FKS1wIuBDxMmbcjdpVbExw4uutz0iRcCd4mOESCr8Qm7ldcMlvbbumXGti6xlJE56qLHQePg3GhOnk4A9TExiXoYiKIfo9t6fM9oDptjEeuXaXfidwyWvK9SLY+W+9pInb2m88yVx/OOU918ruBksS93nM8l2RThQZBeYwgxS7KXkM10ig3Or2wx1vHrsP6SOfXFPTcaL+P8op0ZjUv3VPtwjtt3zXVnWgyEGHfr284sRUKyI9E1Ep+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+urcFYh+UromnQ097lPoow827oUkelYnYB5oOLW4Hvo=;
 b=BmnXD7+wpTc/YliFwlfFOU6e/ISFgo/HQrqGD0TNOG+43xRUfTBcQfWPQj3UxzYnTAt+WaCamEX3Fzs9zKIEIH62mby84L3GOjEXrCEcvlTQmTsKc/knu4fI3kbeL5Vdh/k3b/wweR6QcPB4NZWGPZMW5oo4VidwXSd0V3eSUXO3KbyzvkDDL5wCFV/Xd/X22eR0AIkGcFjOfPShGsG4nrTfUUCc7qNXE6zvFZk8wuGS8bXQPM6Lwn8nREg7Qh+6vs3E/8s4Gd+D2Lj4L9L2dCv+xB1/XAzhokdNDCzOta0idiCZx+RVAppSCwAU3wNOfum1v81v9uOU5VAb0lejJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+urcFYh+UromnQ097lPoow827oUkelYnYB5oOLW4Hvo=;
 b=tpghmTwHHsFf80qVCsopQ/RKudQttRjO1ivxnhPJemFlXctO+H75gsSNTBn9jxSA1ysBckEIXC7waRb240VC96nwfgAdGvr59hF3n0FciXxUv/AUuGGX1qgX71WZnL24ufv7KspFhEic4mEC2k18u0lg1g6hI/iBEstM6/pm2qJ4Dq4iooRBMDc16FrZW97jfJiSCEmdJgpkQgOPAoqVSiAnOYVGNJxQutMEPKyqmKzyHsik8yqXUYWsURXi/HPsJ+tma5zqnNAbrTGaR7yUgnUL+OmnsTCoQJwAY3zfK0jAKnGCJ4xm24+Piu8wBrwRLonGKXY6yjgqQwpAxalAWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 15:55:17 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 15:55:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>,
 Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Date: Thu, 19 Dec 2024 10:55:10 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
In-Reply-To: <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:208:238::29) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: d33dd7a9-a3c6-47a9-271a-08dd20458551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8BPEHK1NUtx6lF1Q9yjegqo/ieavvsquUsNw5e/gXVmpYyiDboOZi8Hea2VW?=
 =?us-ascii?Q?oWs/Ho8sky8hoEU1d+tDVUJ68ty62+aboeH7mz8Xzoe+brnxgEUGV6zxk+BQ?=
 =?us-ascii?Q?PsMavpVZE1tmslloXUTHd8VSypg0PwOnrD6x34+oLAM/ji9DRFxoafBf4Let?=
 =?us-ascii?Q?34aWavfjfgI17JJks2F16ALPnpq/osiglgv+GCT66ixg3RpIUXLSFNBv+Cyf?=
 =?us-ascii?Q?HrMwYZlLvHWGBq34B55InkKsganXyXn90Xdd1W8ltoEoVMmwfmrSXKNBYMT2?=
 =?us-ascii?Q?fzMe0n/TLTE8r9VaLdzc9oHr8cDKU4GCnwn8ZA4HwErf9yIyH380eg+bJMYC?=
 =?us-ascii?Q?q7zVgW74vIj809Lf28Q3BX+FTBuZUVMWBO7mbGbVD6h3EWEZImqMgJ5Fv/kZ?=
 =?us-ascii?Q?x72rekZQwF7fLyjprh/PhwjuUKhbHQQOcnLiDnpv6Id/u+ehO5biVx9aEEAO?=
 =?us-ascii?Q?yMgkLhYSLCAx4GTU+/Ndydp5korpXXZIO0TvhL3B3/bbvEq5f2SEuwys+zB7?=
 =?us-ascii?Q?Ikyvyr5s0Re7GiXqaSKgC7gDVnMjqz64wNb7bDylE9Y6BNihB2cqmxT4bM2X?=
 =?us-ascii?Q?oU1Yao8XDFm4JaglSjokWYWPeyqNHFOcUPl2eXcZ49ny42t9EasIfjZgvHLj?=
 =?us-ascii?Q?xXb8RsDqts1gtbossM5R1EhUzbM8GUDKxU89VS5nlgyksuFCZhUP5aSVrHas?=
 =?us-ascii?Q?wTEbvAZ4Dwdnc7hY1waw8gUEP20z5UUYSfOMpw/DpvoNDZUfvzBMFTSj60qs?=
 =?us-ascii?Q?fCVqDJBoNCFSL/THHLbfxUQcIs6zqrLF21ulGr7kZwMnotkPe3EdHBKt2xlm?=
 =?us-ascii?Q?vcsRgGWt1yl+CSuvrpQFAZG3zuHFnf+JFz4RfyGsxuZVFw6HzV7yhOpe7pBJ?=
 =?us-ascii?Q?OHr1Pzula92sX6kMhLrA488tobYnFGzwnO12aACZvyrzWt7MwfstVZR8xHQn?=
 =?us-ascii?Q?XVBUFeCWc7Ug7AIODlIvlddYlEmovc3k4iThDVEnVj8AHNrOqfTTzvDU9dq1?=
 =?us-ascii?Q?guLKxJh6NbpbpnJ+G59LuQd/EIB6oqnOZNHEdyRnOtixuZPMNHuFDLnCYb6S?=
 =?us-ascii?Q?lUi9xSY7KjdnIq5zY0zVFT3fc4egZXAk5BiItM54OBHmVNk/tyhOFNa1uCQM?=
 =?us-ascii?Q?Yr2WiTYSFTeFS+zX2azfJ9aLlsciY92rc2VtHXytPFT7kDD9qIRWR1UWKdw4?=
 =?us-ascii?Q?MT4BzuxEkCtwPTEryKB+WWo7wzr8UXj7c4OQCYqp4pDVLZsjRLv1vaUtXpcQ?=
 =?us-ascii?Q?AlhDn7T6iCdyHDfgEh8MaYUCQwS0ZwnKDuRZ2RUJuC1xnU0Rur2n8mPlgJxy?=
 =?us-ascii?Q?dLd2tDT+Rir8yn+4gy0Fnn5wG6Lpik0XUAmRyHJItE/akxm6b03IYEceE03X?=
 =?us-ascii?Q?7wWwLMVsr+6Ug6k3MWWApA6fC111?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hINoote1cM/ePXL0lyNnFAE6EADzQgoRmq1VbymKu94Npb9TpLoEf7ib1nRs?=
 =?us-ascii?Q?/LQpKVeRHM1RDxdSvT0fmWHk/IaSNmpG5ewoQbiumRk/6m7BYvmM/1dBrB+W?=
 =?us-ascii?Q?QrNoMXfilrZC6z6UEDvA5rSgAMKKxgOR4a28FZTHODX82Y396oA81qzHBlMS?=
 =?us-ascii?Q?GUYrCp9NGq9721tlYWqy5MPXzS13zZfcdaH64jRzZBlgcUzuj5BeodWXA7/c?=
 =?us-ascii?Q?HrfDDgjnDfDv21yCLF6DWO8Jv50Gtua6NAEFu6D2yyWS0UHfgyaPbnaiHyn3?=
 =?us-ascii?Q?xf6/IK5XuNE0dS95nuTquMlE955h6iiQRZbRBLVU4aOejANg1F/AxRXJ6VcB?=
 =?us-ascii?Q?/5wPOUT004GYTZi6lk5BB3pnTP+Ypv20xqFjTB6K0gFKlcwmgRHv/DB/4tBw?=
 =?us-ascii?Q?OJ+/hnQ2YYbAUGWfx4CRTX2ZkLsTS32zARVJD50zMpPF2Kpv+pP+v0FIm1Nv?=
 =?us-ascii?Q?75iOLZJdDQoPsuiryUcln12oTbmI7nyspjiaay0HlJMHvnNWI0JjBVZDCho9?=
 =?us-ascii?Q?GEjw3EAyjpsxA931Ci/PPyeqoq/nIgT3SBa9V7iKWNIadZPRtf5wGOO/MbNY?=
 =?us-ascii?Q?ZNyAUc8RpKBx+AbMDnc902toimHGfh6IXCd5evNNKIGmlLXylsKbBBxaZK4h?=
 =?us-ascii?Q?zYw+0mb4cikYUhUj9RA0gAEsk5WwmX5LpqEBOvFC8h4+QWhHgwItEZggfee7?=
 =?us-ascii?Q?hJ3SCvyX4IyW2pF7013ecFeS9T734YPFCPp8sfpsr7MCi2mKqA48cts2Vd23?=
 =?us-ascii?Q?NkXDH1Piqs1Di4Nwi3jsOy3oXPFAhgqN9DQgq/n20qdVLVD22iO6/CjciwTq?=
 =?us-ascii?Q?akjItxEdVOLiveXo1sIvHgjPBM2Xgx4z3Do/OYOICJnfrjOiRLJkhfMONHXg?=
 =?us-ascii?Q?RxiFVtH/w0aHFC6IUoNXFW60JRulKa9FMBSbamU09/V0iu8CU4hySMEOXiRG?=
 =?us-ascii?Q?b33f9712oqVhHqx7C89D8bXd7qzqsgPzloKKhVmCHfERDQLzgdFW5W5h8uGn?=
 =?us-ascii?Q?mPx7lIA56eqZGz4LTVqef+nzTBVWghPgOaseJqKnbCQR5VEYbWVZvpmlHd7u?=
 =?us-ascii?Q?NKjHJg7xdejsACGA1L+VAGBTEV2weM4xdmluHRY2EdrB6ZA5hTOSkjg2TXko?=
 =?us-ascii?Q?KasITrWtGCD/tQEpgN+2qDJ56sjll2VsGAQ0jnFfHbAT+uWev4DNeIFQT6Ux?=
 =?us-ascii?Q?JhmgRxIPfcURPorjaZnVdm3w5a1/TYlTQZ9ELrB1NGmXyqHN0oksheQUedAx?=
 =?us-ascii?Q?Msy8BmIRt/P4Vy44SuQHTNAS0KVJ6Cis1QIa25NMOajv4bcfHHG7AB6YNSjf?=
 =?us-ascii?Q?KM2MOIG168MGoAsl7Dxvd21iZqsqp0GPU6H28OZK0AAdRU4Y/fx6X9xjMgNg?=
 =?us-ascii?Q?YEprlUpJVTKOnR2FM01FRglsie23DxuR1ldTaNKx+Zq/Kdz7YtidqZMk17xr?=
 =?us-ascii?Q?L8OsL5HIRRcZQHcMiFAf67ozHeFDO2jzA3R+gW4R4ONhVIHWc+B/Urw0/UhY?=
 =?us-ascii?Q?+XaxrRFH/ZomMR6FHz2Rjw7P57z8rOFUqQPKnPfUMsHsbMAbKX2sNHh+Q3bv?=
 =?us-ascii?Q?MAxujcnRw+XzIn6mG6EuCs/ZHDJxu6fqrHUGdiRd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33dd7a9-a3c6-47a9-271a-08dd20458551
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:55:11.8794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sYkuMSoM3cj7YobWAibYMQRBUyPU5WPMeZpaWe3Xihg4+rRMoSYN8fl8QGmfbgL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410

On 19 Dec 2024, at 10:53, Shakeel Butt wrote:

> On Thu, Dec 19, 2024 at 04:47:18PM +0100, David Hildenbrand wrote:
>> On 19.12.24 16:43, Shakeel Butt wrote:
>>> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:
>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>>>> writeback may take an indeterminate amount of time to complete, and
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
>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>    		 */
>>>>>    		switch (mode) {
>>>>>    		case MIGRATE_SYNC:
>>>>> -			break;
>>>>> +			if (!src->mapping ||
>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>>> +				break;
>>>>> +			fallthrough;
>>>>>    		default:
>>>>>    			rc = -EBUSY;
>>>>>    			goto out;
>>>>
>>>> Ehm, doesn't this mean that any fuse user can essentially completely block
>>>> CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
>>>>
>>>> That sounds very bad.
>>>
>>> The page under writeback are already unmovable while they are under
>>> writeback. This patch is only making potentially unrelated tasks to
>>> synchronously wait on writeback completion for such pages which in worst
>>> case can be indefinite. This actually is solving an isolation issue on a
>>> multi-tenant machine.
>>>
>> Are you sure, because I read in the cover letter:
>>
>> "In the current FUSE writeback design (see commit 3be5a52b30aa ("fuse:
>> support writable mmap"))), a temp page is allocated for every dirty
>> page to be written back, the contents of the dirty page are copied over to
>> the temp page, and the temp page gets handed to the server to write back.
>> This is done so that writeback may be immediately cleared on the dirty
>> page,"
>>
>> Which to me means that they are immediately movable again?
>
> Oh sorry, my mistake, yes this will become an isolation issue with the
> removal of the temp page in-between which this series is doing. I think
> the tradeoff is between extra memory plus slow write performance versus
> temporary unmovable memory.

No, the tradeoff is slow FUSE performance vs whole system slowdown due to
memory fragmentation. AS_WRITEBACK_INDETERMINATE indicates it is not
temporary.

--
Best Regards,
Yan, Zi

