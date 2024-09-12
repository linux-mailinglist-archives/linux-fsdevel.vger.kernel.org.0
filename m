Return-Path: <linux-fsdevel+bounces-29210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1418F977276
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79016B20F2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ACA1C243A;
	Thu, 12 Sep 2024 19:49:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2112.outbound.protection.outlook.com [40.107.102.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC331C1752;
	Thu, 12 Sep 2024 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726170558; cv=fail; b=jBN+dCUU27/DbPvxT/pypahx8cmAAyY5o+o5S3B/ugg/YHWVBtCNnER6eop6BJDfPE1iXmdJntw1jbKwkcojAH8vcz266pmxPpHWWk6wMaQ2JoDKq5PWrEHBRdjRr9ne9Azu9q5SwyTFMwWc7odZ8QBdfidtWtvEvPsQvpOGxFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726170558; c=relaxed/simple;
	bh=JljCZgdH7E4K2ExGHjwPUhDI7nUS5nxuxvpPTEUg4SA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IbzaUSdtVx7VczIEINlyIxUL2L0j1IuK/gD2orVaUpLP5oTvnupJ/1f9QscAsdkTl9k0kkB/djMLhsBqR/YpDKX4wl88qvIfVCK4s9lDc+xR2KcklvSQAG8IILXRllt7D1OKeL8bEkT4RNJ4qWi75pv81S/2VSXA+CTobOEnMkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.102.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1SopvfhBbd5hpXd5oRBAlDaaO73T0Ok2WWJ7Xfn436v2vOuwTVCuECSdBXs6QlyNaTGtPW3Fvf4U61BsIcdoBE/KrecJW0nhGNDZ1D4dMYiXqm6+NXBe5iKPdTMnXWbf11/weMKV8fdwiVEI4mU2xlsui0WyoTW+8J4in1H380csUvYZ36M5UROZmG69KnAduyvULFp3D90DOCLnASg+oufF6fyWvrl5OOqaLRymG8SHTogbSPHIa01V9JCuhBBhA11B3Ufm/pEGeuIZVO66k8NpMDETFw+nQwpcvdYiXz+nhqSjJN4BU4W4k7cC6w9D6NmXbml51n0UjJyQ4CI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PFZiBTiScOuMpx1+5BuIBNtEXizvZ806FihdD+/WxY=;
 b=Puz8xrPnCPs3gLtObtDGlrBDTgux1aLrPHD1sajlCJhTqY3tOs9bS+K38PGEO14Wjrkrs9lvb6s3ccecJKBPGZCDWKqWc+ybT/7tMv3///X8dfSOLZA8qVL8+30wiAdBjekbDh032MEb7Wr8B1yeMwUPO2bXJ2IKHTQ1DXLyY2yPzMJEdxYRKGasocGpK9cToJJ4HovOLlScOCGi1DK2f7ruMpoNFTBSUnkQG/RfVz8FTHgaSY2lJPUEmKqwxvQm1pEdq8K5f8rEiqIEFMf/kU1i93K+nC2E2gzHwtzNy3Vw6u5opExIPEPoONuRdVwbqAHfWAPrffFwE7tpRr7BUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4016.prod.exchangelabs.com (2603:10b6:805:aa::28) by
 CYYPR01MB8357.prod.exchangelabs.com (2603:10b6:930:cb::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.27; Thu, 12 Sep 2024 19:49:14 +0000
Received: from SN6PR01MB4016.prod.exchangelabs.com
 ([fe80::1fcb:ca70:b1b0:8ce5]) by SN6PR01MB4016.prod.exchangelabs.com
 ([fe80::1fcb:ca70:b1b0:8ce5%6]) with mapi id 15.20.7939.017; Thu, 12 Sep 2024
 19:49:14 +0000
Message-ID: <8369fc35-66e8-4853-98c0-de20edb3053a@talpey.com>
Date: Thu, 12 Sep 2024 15:49:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cifs: Fix signature miscalculation
To: Steve French <smfrench@gmail.com>, David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <nspmangalore@gmail.com>,
 Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton
 <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1197027.1726156728@warthog.procyon.org.uk>
 <CAH2r5ms+7qDhOkxf=ti4Lifh1Tm0k2ipy8_rXaHhL7ygEqXvsw@mail.gmail.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <CAH2r5ms+7qDhOkxf=ti4Lifh1Tm0k2ipy8_rXaHhL7ygEqXvsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0937.namprd03.prod.outlook.com
 (2603:10b6:408:108::12) To SN6PR01MB4016.prod.exchangelabs.com
 (2603:10b6:805:aa::28)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4016:EE_|CYYPR01MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: e329e438-3678-43b4-b5e2-08dcd363faa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aThuWGlWZ3pWU2REbUVYSG40R2xZYm5KVko2Vjh1YWV4UVYySEFVT0MrNTBG?=
 =?utf-8?B?cHc2TWRNU0xJZCt1dEYzSndwNlpLN3drV1hTaHlMaks3WFN1UmpMdkRWemRy?=
 =?utf-8?B?eXQwVWNOUEptdWsvZDZMTmFlaGFZanVjdGRYK2FkaGl3VzNjTW1sLzhzdFN2?=
 =?utf-8?B?SXpCWVhHNitKbTBNdnhtRTF5WiswRmxqVlZZY2RVZzZGYWxITGJ0L2Yxc0c0?=
 =?utf-8?B?MVhSMWxlbmdGa2w0aGszZUhOTTJadmlxZXUrZGQ5QVFqd1hUVjhXVDRXaWFy?=
 =?utf-8?B?UjZWaDk1Q1Q4WEtRN0VqMU85MmtTcU5VcFZuckREUm9yblpYMGJCWUVIckVN?=
 =?utf-8?B?b2haWVVsSVdVUUgwdXYwQk9VNEFVRGRoNnBObWFLSzRtMS9ISUhpdCtTMzQ1?=
 =?utf-8?B?OGdQSjE4TUcxUWpVVCtZNzh5REZqa2ExRDl6cnZmOUVwaXdWb1BRRTNuUEFX?=
 =?utf-8?B?RFNvbWN2TnBKMTMvU2dWTnkwRDhDOU5sZzB4THFhckJzYnk3Rlgwak5ISG9x?=
 =?utf-8?B?S1FNM0xycTkzYzRQNW5oNXNMQlZXUGh0VkY4L2FNaUFhWGcwQ0U2amR2MDc5?=
 =?utf-8?B?QjBkeW1rMlZkdmFYQ2ZwVnU5SVQzanVMUU1nMXh3V1VxeWg5bm9naXNDajd0?=
 =?utf-8?B?OWJNSFN6S3FwcVo3KzFZVkxqNVh1Y0NUYTkvdDJhc0JNdjZ3am9CMk56R1lJ?=
 =?utf-8?B?N0Fwc3JhKzV2M1A2WkcxTlpxNFFwUUdkNXQzd05GRlJEV21HbUJZOUkxaW9F?=
 =?utf-8?B?MGF3emlVa09vbnpOMGxrWWZ6Q1dGTUt5Z0JJbzcvM0VndU1uNUgraWdjcTFq?=
 =?utf-8?B?OWtKbXpSVngyNmhXQ2FaUkRXMWNhaDk5ZzZUTXZkRUlGaEloWGZnL0FCc3FY?=
 =?utf-8?B?K1ZMdW42bkNhaUVENSswaU9VM0R3T0pEUVdXbkYxVzJDV3oxVW8vRG9MakEx?=
 =?utf-8?B?ak9rYlk3Mm1SVkJLY29lOUZ3Zk5Pa0Y3RXZmbnl2TUJXT3ZVNGFyY0xYZEVB?=
 =?utf-8?B?aFgxWHR1YitMZFM3V0lmMnh6YjNqOVpOSEhMZG5qek5vQXM4Sjk5QmFiU0Z1?=
 =?utf-8?B?NTkxWWZxRkliUktPVFcvSEZOY3I3Qm42RFdTSlQycGxudVpiTjBUdHN3Q0NM?=
 =?utf-8?B?Qnh1bFgwa1VyUEJORDJzbDhhUG5NczBYQlYrNUdhd2VMR1Z6YUNYN0lBSzFL?=
 =?utf-8?B?TDR1SSsrZjE3NXV6amhNaDBmU2xSYVA1TmczS1lzZUdJQXZ0ZzdheDA3dnJC?=
 =?utf-8?B?SGRnaVo4NnFyRWJkOXd3Y3AxUGVIM0V1OGxBVS93VDhJbTFEUGJDcDFhc1VB?=
 =?utf-8?B?bWJmOWtxNjlpeHNQNGNVNUloWmlxbjlieXpVNU0zTVB1cEVWeER0UXlXbEJH?=
 =?utf-8?B?M1ZTSEViYWppYWt0bFhwTGNBK1c5d0Z0UHp1NU03dUp1eGJSOUJxaS9RM2pZ?=
 =?utf-8?B?SFBBUExVakFjbmdjeWluSjk3T3pmaVd0ZGZPdmNvR3Q0a1dvRVlYelNETlk4?=
 =?utf-8?B?dWpjcFZUakVJWlpaRE1iTklHckJNVHJIYnk2T1hrazduUUFsTEg0ZjlGRmFE?=
 =?utf-8?B?MFJCUjNJRVlwei9xMmZ6dG5JTFJNWStOOXJDSWtJUjJoditBWWpiUGFrYlhV?=
 =?utf-8?B?YXc4bHlNS1FrY0JFL3QxaHZMaXMxcjdra2F3L3NwMndYUTltNm54QyttMEZp?=
 =?utf-8?B?NmYycFBmcUxFZU1xWVk5SnRYcEdYUGFlbzlDdFVVWWQrQ0FSL2tyT3A1Y0tX?=
 =?utf-8?B?aWp0OEN1MitXRXVScWo3V0ZmRE1HTmRoM3loRDdpU1I2WGJrdldaS0tGbTNa?=
 =?utf-8?B?eFVuRnFpK2h0ZmVocDZsdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4016.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEhzVnZzbXhUNVFMVU9OK2NnZkRaanVGRGNuSkloRGJTcStaUE56U3pBa0gv?=
 =?utf-8?B?akwvZ3RQSERKVENQLy83OFdUa2dneHFaSXhwdXFSQXQ5ZEFHclptSGFScTFB?=
 =?utf-8?B?a3JIL054NnpNTTFEeC9kckFuVXJHcVMzYXRsZCthZ0dnNnFuUXU0OStHTkRm?=
 =?utf-8?B?YXNPUTFxdXBhT3l2VWVXRVBnKyt4bHFrWlZSbWJPZHhuMkx1YW1SN0cwcUx6?=
 =?utf-8?B?WVNEMnBvdmFzSlZ3Nkt6aU1aMDJLdHNJQVBxOTVpZ01nUk9mNXhwQnVPNXlQ?=
 =?utf-8?B?amJiQko3aVAvdkZUNUE2Rjgybm9yRGRPcis5QTF1T1RjNUxTWE9ZcjR0M1Bw?=
 =?utf-8?B?anpZMnNUbGxnUmx0RFo2Q3owZDBIbHFzNEZQUlBUdSt5a1doOW9Yb0FRUm0y?=
 =?utf-8?B?aDB4Ny9TSncyTkE3aXVIenlZVWl4bTdHdThwRGM3VUJuTUZmdlNFRnNEanR4?=
 =?utf-8?B?bGh0QXE0SWFrRUw1OUg3UkRySGJNT0JnTkhLNGI5L21ZNVVHeUlDMFpJOExC?=
 =?utf-8?B?amp1NG02S0ZlWFFDQ0RpZGRyR0N5NFZhajVuaURsZ1YwU0UzcTVOTm1RUmFG?=
 =?utf-8?B?SzU3UmxBdmNFRkZJR3hOaElZUnNCSmhqTlBWVFJCa3Q4UzNHV0JhQTc3TGx0?=
 =?utf-8?B?d2dWR1JiN2tPVTVzOVE3YkxwcnNFaDkxZjhIeGJYekEwZEhIWHNzYk9yWXMw?=
 =?utf-8?B?L3JvM1BrRGhHdElqZVJXQ3Vib2MrS29OQjhydWNFSW92WlZRcHc3eHhiaUMz?=
 =?utf-8?B?dGJsanJoTzJtWEJqajh2SFN5ODNVMmNydWdHVDNFWXRubEdDY29jV1BBRm1O?=
 =?utf-8?B?R1l1OG1lS3dwc2x3K05BQkx4ZFFBSEo3QmR1VGxKdkpLKys4M29Jd1BaSTFD?=
 =?utf-8?B?Q0l2VWhwR3FjTDArL0lSMXRudFNEblYrbUNzdFpCVkYwVVNGOThZUU0weUlh?=
 =?utf-8?B?dVpMT3cwYlpsN2NDczZmcUZ5NWpTem1ITGZPekFKazV0OHovQ0x1RmdrZnpy?=
 =?utf-8?B?MVBYaWt2M0FtQWVQZFF4Z2dkbEpoTWQ4NEdXMDBlY0E3M3B5RU1QVWtuY1g5?=
 =?utf-8?B?YjJxODRvWU5aSFFtU2grRG1jaGkveHdad0k2RzViWXZTc1NOc2ZSVU5wdk5I?=
 =?utf-8?B?M0x2TEVnTjhiL2ZOcFl5TkZHKzhHZmlWYkVFUTUzdnozSVhVQ1VaejBuNmNt?=
 =?utf-8?B?NHZualhPMDErQXZHWllucGNKVlY2RVhOTU82UVozNUwvcFJXYk5Ba0dvQlds?=
 =?utf-8?B?NnFCU2tjKzlxeUtRQ09HL0ZuL29oYnN5Y2tDdEVIcjcwV2JqenpRMGZoSnRw?=
 =?utf-8?B?TVEzV0RxTWpWK3JjWmEzenY4c3luakxwWnpIdC9NOXFlVFEyUmdZVVJCL05j?=
 =?utf-8?B?Z1ZObnR1MndDMnVIYWs4ZmR0cVYwQ0N4YjFUdmNoNkJ4QXNKVzhVWCtUTUgy?=
 =?utf-8?B?YkRHcVZaQnlldm1BS2YwSEVaaFpWM256aC9hQVB3SllIK1Z6N2tzME4yS3lP?=
 =?utf-8?B?bUdsb1JGclJTZGNPNEhxVDd4UFdMUE9xTFU1dFoxTUM0QUFoaXZkWGJuK0VR?=
 =?utf-8?B?MW1NYkFTZzZGWkJNZFJ2YXA0aGhJWkxIa2ozd1NONS92M08rODYzYkZNZVZ4?=
 =?utf-8?B?QUc0TmV1cWRrQWZwN2xFWW80OEF0Wmd6YzlDaEFhMnlNdjhNUkUyaTNqNUJi?=
 =?utf-8?B?OVlkZGt4bVRIczNha0J5NGZVMWdiM3JQKzZ3eFRHU1NHUGF4V0Q2ZkxpeU9G?=
 =?utf-8?B?SXU0aVc5VEh2UDlxSjNBWUFlMUtpNHdCRU9vaEo4NHdOS2tIUGhCRnZCeWRE?=
 =?utf-8?B?ZDdYV1dibGVCM3FOMWFZbEJXTnN0MUxLVkdaakJZd00zcTJDTnRFOXpEeVpz?=
 =?utf-8?B?SDZiQzlYQ1pQOWtEcGVYTTNxc2NZSjlrUkRsZDgxbDdxcEpxeEtJM0xJa1hu?=
 =?utf-8?B?Sjd6eklIM3BaUUcyaEZLVDltWjAxNXYrQ2JuZG5xL2xrdVVjc2JZNncwemxB?=
 =?utf-8?B?WFNKeC9SOFN6aDhIL2dvZkdaZTZ2TUhubmdKVWRJSTFKQTFlamU4cmZqZDhs?=
 =?utf-8?B?MWgvbTJKMVE2ZktjSm5tM1IwUDI2d015S2t5d0xoTHlTNXZuMXU0Q09peWts?=
 =?utf-8?Q?24es=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e329e438-3678-43b4-b5e2-08dcd363faa3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4016.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:49:14.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7GHirZA8c0Ejrq1caf2WLRdKNse2CjxTfQiALpOMd1X31Xlk9g3nhvbvQHxN+1e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8357

Ouch! Thanks for this, and just in time for next week's IOLab. :)

Reviewed-by: Tom Talpey <tom@talpey.com>

Tom.

On 9/12/2024 12:24 PM, Steve French wrote:
> looks like this fixes the problem - merged into cifs-2.6.git for-next
> 
> On Thu, Sep 12, 2024 at 10:59 AM David Howells <dhowells@redhat.com> wrote:
>>
>>
>> Fix the calculation of packet signatures by adding the offset into a page
>> in the read or write data payload when hashing the pages from it.
>>
>> Fixes: 39bc58203f04 ("cifs: Add a function to Hash the contents of an iterator")
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: Steve French <sfrench@samba.org>
>> cc: Paulo Alcantara <pc@manguebit.com>
>> cc: Shyam Prasad N <nspmangalore@gmail.com>
>> cc: Rohith Surabattula <rohiths.msft@gmail.com>
>> cc: Jeff Layton <jlayton@kernel.org>
>> cc: linux-cifs@vger.kernel.org
>> cc: linux-fsdevel@vger.kernel.org
>> ---
>>   fs/smb/client/cifsencrypt.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
>> index 6322f0f68a17..b0473c2567fe 100644
>> --- a/fs/smb/client/cifsencrypt.c
>> +++ b/fs/smb/client/cifsencrypt.c
>> @@ -129,7 +129,7 @@ static ssize_t cifs_shash_xarray(const struct iov_iter *iter, ssize_t maxsize,
>>                          for (j = foffset / PAGE_SIZE; j < npages; j++) {
>>                                  len = min_t(size_t, maxsize, PAGE_SIZE - offset);
>>                                  p = kmap_local_page(folio_page(folio, j));
>> -                               ret = crypto_shash_update(shash, p, len);
>> +                               ret = crypto_shash_update(shash, p + offset, len);
>>                                  kunmap_local(p);
>>                                  if (ret < 0)
>>                                          return ret;
>>
>>
> 
> 


