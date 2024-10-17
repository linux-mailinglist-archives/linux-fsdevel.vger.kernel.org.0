Return-Path: <linux-fsdevel+bounces-32237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B199A297A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 18:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44902828E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7551DF99C;
	Thu, 17 Oct 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zidf+BmP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EAB1DF73C;
	Thu, 17 Oct 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183670; cv=fail; b=PM2OOq4pIhg1OkG++5t62QbbJHdiqlwY/JJXRkhquk9fTa1Q5J/WaPVD2VVdH4MbzakWpPcJZVfikq+DpYojL+lbC6jCe65RmH+F7fEKT3KH0NxLlHDohucdEWiJhRuHC0uvxdrKv28YmwtWnjxa2/zg8reCA1L3A2Ae1VAKA+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183670; c=relaxed/simple;
	bh=TGc/WEOdz4YHQ5ULaxqhvx/a7MRBBR34Tjb08iCyOAY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MHUgOgNcaGZK1Ve71NQLd4zzUm+VVWxQqO1jVV9cAGro4Kvsf/qdWzT5VBHc9fyT/RI7oQuXINRCEsqV/t/T6AqxvdWoRt3HcZjzjN44nU2GcjH/6xYeuanD0kr4dNWj/yiSRQ0tWNnBHsWrsH0QVogzSMLRodjY89E6nD+B93g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zidf+BmP; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkeBDR5ssK0Gtg8Be47YiMWO//E3GV//K1XkLTYpqRxzPDLw5KtCjsEuixif19mxKFu828JBlmR0WO5DuSC6srsbZdD+U28Nl31YRymF0FmVZ4t+lEuMMfJikZb4CFNhit/Nf9471h+N4BwLDQNzENFmfYNOITBeHsX+F3YOMnlfkkTIsueZlsOPxsAwkbP4220a+p9Wyt3oqTOGjM4f6R/NEFL64leZTWGQ/YAHWqq48vBRcitMKsJ4H3DBUH3a5r1ClHQB0tw+lGmE4ocyAM39H1TApQ3lGbWYhtzBr+eLMz9IDrWXunH05PTnAUpw8FQzrB4Ekf+F0CmPM/LbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loDIlDmWCVkHN0vQiWojz56uuqXBYvx0ToikvMeCXx8=;
 b=L7RXXN7xphYk/LHpXPaiA+4aiugpNEHUe93+XeBVyDfSwZ2mmmmyws2pySSzac1f/7liIql/W8+HLlVz9epXC++ViBHITAlQLIn7cVmGWMsx3Id0BbeJAhZ5BesTfdpOdWH37O0a1d5PcJIFbYJL8xAZxaP2hDkrDSbbgAsc5SY5rWszXs96jrYs2zzhdOhv6Sgjz5TdSMEU2Edv086RODaFvA4xX/fXCgWeve9Bx8sRaOMYR9AX5EUj1661tIKxPdFanuqFbJRXOBAyAI9S+g1hi3jEQZE6nukmxOyrwFUawi3zNeebN9uBmzRKjilgOZpb3jYUireLxD6cUK306w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loDIlDmWCVkHN0vQiWojz56uuqXBYvx0ToikvMeCXx8=;
 b=Zidf+BmPD1FzORHGNbmvlihKz9DtiHvPD87nZZlXpe6AvL4Rz2/duSpoMBmPW4X7GK4AV9P+PHo5z63cDt8MrX5pWuAlF2Fep8gPoJOBqfrtcEm+/Jtt8qmWHnnnnmsyLHJKibmJ5dsDZqGbK01IEY8b216uDwAxeFAM/RXMC0rt8BFPYSirMLu8ZvQbfwIe7xT6cLVqXcSwgQjVzthTT7xX/Jvph2U9897JZZkAp4hTBB82hRU5lnjLCBJDNtdJzrvnjc+NO9WGKIiCmxagOKJOZzntfOtNsISuTKNru5JXeAcy+/CYhPBxqKPpJuATI8Stlz+GF8JjoVj7nZdyHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 16:47:45 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 16:47:45 +0000
Message-ID: <3687348f-7ee0-4fe1-a953-d5a2edd02ce8@nvidia.com>
Date: Thu, 17 Oct 2024 09:47:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: The "make headers" requirement, revisited: [PATCH v3 3/3]
 selftests: pidfd: add tests for PIDFD_SELF_*
To: Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Christian Brauner <christian@brauner.io>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <6dd57f0e-34b4-4456-854b-a8abdba9163b@nvidia.com>
 <e0b9d4ad-0d47-499a-9ec8-7307b67cae5c@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <e0b9d4ad-0d47-499a-9ec8-7307b67cae5c@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:a03:54::37) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e26a471-770c-468a-44ea-08dceecb6c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjRLdE44Qm9hcHBmbXpDNEh5ZGF0Mi90ZG5MRmxTcmJBY1lpRHVzdUFIaVMw?=
 =?utf-8?B?T1lpWFovazNvYWJVaXBlU0ZGT0N4d3Z3MmJOK0EzaXRqZXRHb0NIVUg1WTlS?=
 =?utf-8?B?RmEyeTVkbkh4RVAyT2VzS2d2R2gwSHpISWdkRWNNL1hpUUZqR1BweUtpWjZn?=
 =?utf-8?B?TW9kZmFFRmVaVGhUcUhFU08rQWZIUmxLMU4zWjlId2p3T2J3WTMwYWNrWGtu?=
 =?utf-8?B?STZnZDJUcVIrdS9LRElUZ0ZDNzJSdXcvM2YyS1puR1UxS05PaUtid2taZ1RB?=
 =?utf-8?B?djk0eldwSXZoalJreTROUFpsZUkxZDNvOE5BWlRjK3Y0RWtUQVdQaGZPR0l5?=
 =?utf-8?B?V0VtNVROaTBRZUZqTkpuUVBUVWlncXk4UVN2cW1MRWt5NzQzUG16ZUJFOVMy?=
 =?utf-8?B?S0lMMW13K3pRU3NjWnlwVTZIS1FYUTJHM1dudTNlYVA3c3lqWGhDUzBvVVd1?=
 =?utf-8?B?Smo0YW56c1RMbVBvaEVmQ0IyZW1zdmZFNW9LaDJVWUhpdHVuakxBZEwxTVgx?=
 =?utf-8?B?MTFYTThMc0lQQUdhMks4SllBcGovNVl6TzdpNStJSWtWMDNLdEhKZmtkWEMz?=
 =?utf-8?B?Tjd4RlNwSS9HaEt6bEpxaExPZ2RURnl5ZCtKZUttN2JyR3h1OGxnUGU4UUhw?=
 =?utf-8?B?bXIyUnJFekNXZk5KSTNZUnE0OUlSQ0s3OExFQ0wzTHBreGNhaitDdjlIalVp?=
 =?utf-8?B?WFprZ3RwZGlLMzdER0RJU0tiOHUwblBxT2VsMjM3cGROWkwreFRRWVVGZktz?=
 =?utf-8?B?aTNKcE9yenpuK3lIaDRIYUNLUlpiVjc5N3QzUjg1aGtwRmNqMWsvOEIvMHQ0?=
 =?utf-8?B?UmJjMmRXK0Mwc0UwRTR0a0tVMUw2bjJOTEM5c01uTTg1amJHNUdNZnhhZE43?=
 =?utf-8?B?YlpyT2hRa1pwdmJUbjRKVWtEdTh0MjYwVHh1U0dNazBrTG5vVWtlWVF1Wjg4?=
 =?utf-8?B?ZWpnemFQVGlqczRpN2pBbE8rRGhGWHV5ZitFOGtvTmhodHp5ejdzSWlXemFx?=
 =?utf-8?B?ODE3RGx4R1BlKzFDWURLRm84UFRzejRVZDYwMXdhZTFuUlY0T2dDRUU0K0My?=
 =?utf-8?B?bk91MkRpRGd0eFUyL043WGlvNTBZUktRd0JyYnppRkVjNnRId2hkQjVBb0k1?=
 =?utf-8?B?L2VyT25lTHh6c3p0Um94MlFmMDF4Y2JUd1dicnhITVBNRjNKL1lhU3pZOXJP?=
 =?utf-8?B?Zlg4TXg4djJnNnB4bnRXQWxtZXVCOW11dGl5WVczQUhNQ2R2VFJKWjdubGtw?=
 =?utf-8?B?ajZYSDRsQXdYTitCZ3lSZFBZK1l2OFlFeWJYSklISWlkZ1Z0cFlvNmhyL1Js?=
 =?utf-8?B?ZlhwTXhkV0VYTGFSaGpBeGlISDFkK1ZQenVBdU5XVndJN1JJK0k5NFlKT0h3?=
 =?utf-8?B?d0w5dDNDdzkxZlRSeDlnU1VoekxxREdlcVdsRnI2NU9zT1ZUS284WFVTQUtN?=
 =?utf-8?B?QndoQUl5UFRTS1ExZDZMeDVZTVJuSnJUdndKQXNxc2VRUURwc0krdFo5U2FR?=
 =?utf-8?B?NWRvMFAwR3U2MWd0eUFzZUNseDFtT0VWMEJIUVZCTzAzUStzcFRvTjB0Y09Z?=
 =?utf-8?B?U1dSa2J1aHBaaU81ckNKNE9BcU14RzlmbVU2L1ZQcWpwTElkN3VBQ09UVFdp?=
 =?utf-8?B?bkl0SXdIZmNSVS9ZVk12a3BDUEJJb3RXQW1RMTNQM2RRM0I3UVFaaER5MjRj?=
 =?utf-8?B?K2N2dXdJTzl0TGFMWU9HOHBTOVZER093R2pKNGVuWlBVd2pqL3ZuV0h0UXlN?=
 =?utf-8?Q?PIGgkqP6PsnvK/4qz/EEkRX55wTqlKJto8yV2pl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZktMTDJlbE04aGViaEY3MDFVV1QrRTFoMW1ITkdPRUFBdEFhd1orUXZWTDhu?=
 =?utf-8?B?M3lqamEwMkhCd0grbW1xdkFLN09zZklmdjNEV3BWU0hwRkJQemprdCs1ZDF1?=
 =?utf-8?B?ZjlGRnFiWWhqM3dHcWhtZnRwb3h3MWcyelp2UVJPRGp0VkEvNURmc0NudHFJ?=
 =?utf-8?B?dkEraTdFQlJLNi9hV29RT3RhT2RmQmh0bUQ3SnkrTk51UDZpcm9qQ0NieXNZ?=
 =?utf-8?B?ZC9nN1FmY0tXdXhOWUZUV3Zzdmx0M0d4cW1WaWh1VXdVeEZ1RmthME1NOHdD?=
 =?utf-8?B?dXFTQUoxRjc2MUE2eHFsTjFCb3VVM2k2a1hQYUJFOE9Kb2FwSERCL29SQ2lY?=
 =?utf-8?B?SFVuV2IzN05XMjUxVUNTNm1oaExRL25iQzJFUlN0UStpTkIySGRlaTQxOFI5?=
 =?utf-8?B?MG8wWFFJVTNiVUMxZGRBTis1Ylg1TVo2S0ZJUjNkQnFydmpMNHNOaDFZZ2FL?=
 =?utf-8?B?T1pFc1IvLzBwUkpYdjdZUkFTd3Q1UzhaTlJ4NElkZ1RaUzdXVUZaSUxOdEhX?=
 =?utf-8?B?ckl3cUdMaGhUSWk3YllsMFc2OWRYRTVTQUVFQ2djT2k2NWlWaWVXSUVodXZt?=
 =?utf-8?B?ZUdabXBNYWpoV2FNcHFOR3liRGRwUlN2T1BhTWcvdjh2Mkh4L3BQbWN2K08r?=
 =?utf-8?B?VjAwM05RS3NYZnB4WkhNSHp6WGJrc2JrbkpXVjZlVnBsaEdJRTdoUGlBczFQ?=
 =?utf-8?B?cEVObnBKWWNja2ZOZG9zZEJKV3NKVHdhMlg3U3hqODc2bmszT1FqVnJFRzhu?=
 =?utf-8?B?Q2pVMVBSaGpjRy9hYi9YN0NVT0o1UGxKT0xoMXpTc1I0SzRDVE9RQ0psUFIv?=
 =?utf-8?B?VFZCaTJ1ZWNUeGxUVTNJdW4yMHRhY2tqeGFXOEp4cWZDNi95ajJiTzNpZTRy?=
 =?utf-8?B?T3cvY3ZGZWd2Tmh0MG5NdnYyZTJHbWNZRS9hdUxHOG9QM0FPY1E3WmRubi9a?=
 =?utf-8?B?bUpYVk9odDc3MEwxbVpROWM3Tml2ckZOL0psMkNBZjdadjgxOGljZ09vNGd1?=
 =?utf-8?B?WDRpVDFkMmkyWHNoUzlBMmR0R2pwOUhLMW9BKyt6SXJnUGMvdURGQXBtaUMr?=
 =?utf-8?B?U1gzTlM0L3Z1OHZUY005cFoyUVBuYTRSQ01UYXBGcnQwQ1hVcDhSRW9FQjRq?=
 =?utf-8?B?emVZb1c2dHNQOE1aQ21iZktsMTNtaEpiVU1qcUJLZHpCd2kxZGdLOUVIUlJV?=
 =?utf-8?B?eE9rMzRhK2ZmaklLV2R4ckZnL1hPdzZWZTh4Z3EydFMvblZkaVprY1dXS2wx?=
 =?utf-8?B?dkZHYkpqdWdsYUNxZFptSjVQZWdaU25wRGtrUDR1bnFleHJZYkxGZ1BUSGxq?=
 =?utf-8?B?a1NaalFyNUkxdDdJSVg4aXhMTkhQVWh6OStqUFU4QmhZREowbWRqNVVXam9u?=
 =?utf-8?B?d2JYblI1UFhLS0E1aGhRSTFYRUc4eW9RbU5xNE10YjlDWGQ2T2UyMUV5QTFC?=
 =?utf-8?B?Y1h2WGxpQWoxUWtGZzcxeTIxYU9ZalJTRC9Ra3dLUUVRVXJiYVg0WlB5UTZL?=
 =?utf-8?B?WTQ1aVM0c0JUWnIxYm9VN245eHFtRW1VRGJ4dXQwYzM2WVdtaDRMeDh2SHBB?=
 =?utf-8?B?Q1poQndKS1ZKdzd5QnAxSnBPOFYrRGs2WExTWFRvem5uUUZQTTRScmd6dmE4?=
 =?utf-8?B?T3JQbUdOcVlMT0l2amVhUHBaaW5ka24xM2lmSURSejJRWE9yVmUyMUdZSmJ5?=
 =?utf-8?B?S2s0S1JIL2FKN1dCQnZPMkVaSDFEMjZiakJpQTI4b3FJZzVaVGhMTm9oVzJF?=
 =?utf-8?B?dDVRQXF3TDZUSkZGeGZkR0dXaXI2WWZQM2xJVS84b1JKTzFBekxvTVMyR1dz?=
 =?utf-8?B?ZUJRYUlVbXorbk9YYWZQNGgybjNXVHFOYWVSMTZJZHkvUk9qSGd6dHM5YWQv?=
 =?utf-8?B?ajJnRkxJVXJseW9ER1doYWsyUUcySnRjOWlic0FhVHg4R2NzMmc2azczT0lW?=
 =?utf-8?B?eW9JR0FVbkN1MGhRbGlSUFBtbVZmYjJsbWJjUGJ4ZGJMR1JqNnhnL3hNaEw4?=
 =?utf-8?B?UWpRV3IxRzFlOEpFVlRjRzNHOEplRk9WcXFJZGd6YUZ6RVFvdE1PZmFrc1BZ?=
 =?utf-8?B?OThXUjZSZW12Rm5sYm91VnVTbHFYcG1Va1o5Z3N0VFh3REZLem9TeHdPMVBs?=
 =?utf-8?B?VmZGOGpVV2s3endFUnRsZWxhQTRhRlp0ZmZSQzRPVkZLTU1DZjFDMStTSkUw?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e26a471-770c-468a-44ea-08dceecb6c99
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:47:44.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hei4cCsGZogZR92uaK+58Y9oli6rNSkKQGuiPTSPS+cXtwTIwgsG/0WHSYkik3pMIX0Tf+pmjgw6tSwu3/5UKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351

On 10/17/24 9:33 AM, Shuah Khan wrote:
> On 10/16/24 20:01, John Hubbard wrote:
>> On 10/16/24 1:00 PM, Shuah Khan wrote:
>>> On 10/16/24 04:20, Lorenzo Stoakes wrote:
...
>> The requirement to do "make headers" is not a keeper. Really.
> 
> The reason we added the requirement to avoid duplicate defines
> such as this one added to kselftest source files. These are
> error prone and hard to resolve.
> 
> In some cases, these don't become uapi and don't make it into
> system headers. selftests are in a category of depending on
> kernel headers to be able to test some features.
> 
> Getting rid of this dependency mean, tests will be full of local
> defines such as this one which will become unmanageable overtime.

Not if we do it correctly...Please do look at the reference I provided
for how that works. Here is is again: [1].

The basic idea, which has been discussed and reviewed, is to take
very occasional snapshots and drop them into a static location where
they are available for kselftests, without disurbing other things:
$(top_srcdir)/tools/include/uapi

This has worked well so far.

> 
> The discussion should be: "How do we get rid of the dependency without
> introducing local defines?" not just "Let's get rid of the dependency"
> 

Yes. Good. We are apparently in violent agreement, because a few lines 
above,
I wrote:

     The requirement to do "make headers" is not a keeper.

The "make headers" is the problem, not the fact that we need to depend
on various includes. And so the solution stops requiring "make headers".
It gets the includes from a less volatile location.

Yes?


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e076eaca5906

thanks,
-- 
John Hubbard


