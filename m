Return-Path: <linux-fsdevel+bounces-5571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B9980DB4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 21:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF124281EBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 20:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5146853E09;
	Mon, 11 Dec 2023 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0/6mGAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68F7DC;
	Mon, 11 Dec 2023 12:11:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I637vPIFatLTVGRtfymt8N2qWl3bSUzQPdfacQ/O2cUEWJyn6J3Sp0uyo/O6ufD239vOhRA9nfhPZ1XtfnIg6HiwM5nAScrzVB5+bOgbdkKxM40ngCdOqY3jjqrvHSUwQGkzH6cFVxLvfUk0D+VszI3dyrU1ZJ7f39X77VGd3VXv8ReRza7MqN7BNNq/G+u6MOko1a4r7KfySuhr04iFH+ZUHh3WAKYQZhU2LP/9e+c4079umyeXS7z3n93fHrdU+abeJXnBZW9li8yizfynhTZnTrPo1JLlxIY+tT+q5fDKa7avISn2lOWN3ueGUvVwWFDnKgVZicDyiTmeHgSyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpGjzwErDYDDHSmb3HYVc5W/Eq3I+CIyovrZBZQdfTY=;
 b=Al7mjlxRRXt/pdWjlSdqNp7XATPK8dN23+wJ6+Qp4/p4VBFWzcjPOs3CG0O86ppwcKDt4wiHRoI0CqLVdqh9fvbPGQK/izwP2vZ7rK5tLQBp3seDkvPbKcLLouP/GuYuzHulloxJbEa1qXhdvs6a9fJUO+0qTGA3pJqxhFs8Aj5YAGqLVDYdibOnbasZuByXhgqKgEvlHr2ohwD56kZvr1FynoP6aSSskt562BzT6lIszMNDBh/n8BjhtEJLXG3vtS4l59zwmJ4UcrXeEvFbZVWcvfPMxEc3OI6yfBKNAaL9LvReI1D9QE2GbuDgL5Sh5f9WU1hBUyRrMiLdNUuOwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpGjzwErDYDDHSmb3HYVc5W/Eq3I+CIyovrZBZQdfTY=;
 b=j0/6mGAyVPO9ybFJToHZ1z1IKBefF3EYEHdUFzKTls1IavXW6OxvKh6ZochXTyMu0WKYU9E9t1k+yK68aGNKWyFhrLUNtaA1q0dPmQzi8rqKerFI3lPE0lkkQVsWLUz5chyMRm2r1N18piHa7LUmPbjJ5NGj1k58zGNkQ+nzC22hWGXd2zBbhiLg1oQWov0+Ang9T8nI2RU0+lBjEReU89pDDT9TJdrVQ5Fp3/xvh4VbXR9LgjDeCluw56RtVIZTMCAysTmurLHskAUigeT+IAtFNPT7GvXo0NAPVQiFybNL5DdU7OTyk69+bOETQ4vF7Jz5mxFVaInBt6MxNWeGnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 20:11:50 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 20:11:50 +0000
Message-ID: <f3081d52-8bbc-4bc7-96d4-b086ca91975a@nvidia.com>
Date: Mon, 11 Dec 2023 12:11:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: Mark Brown <broonie@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
 aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
 ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>
References: <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <1368c558-c58c-4574-907e-36b07dee31bb@sirena.org.uk>
 <6ee5d68a-fa54-4ed6-bc41-2bff0d9eb12f@redhat.com>
 <052dc756-cc05-4aa8-9724-14d42853089c@sirena.org.uk>
 <8a2ce635-58f4-44e1-a646-6527936c5836@redhat.com>
 <400c0342-bb28-4dd2-b132-9927c7babec4@sirena.org.uk>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <400c0342-bb28-4dd2-b132-9927c7babec4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 32464a3f-057c-4a72-788c-08dbfa8568d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Us/8+bnk1l57PsBASFiaQR2eNDHVhkaqFqLkJKavZmy6+wHxXrZSUqUVwNGjz9Aa4D6aOlYfV5S5uo2GHcoO5HAoQbLqLWAWKAP1el2ilyn+6VqJUmBdDsyB16jS+htNJrGPgty4Qhbw6qIebIIdIf0/hf5XrFllSt45xQ1/gwiiJ3JDWDiPSp1zKHhIt6HUHAZlsjFJ3QLh0IBDCw8WCe18jq+a1s6hS+BSB0qYJdij47WXNkPUXBZ1io4lBegDnfr8QMSPMDW4NrqYK5VPxzbb1dAunA/jWGyWDGSXblriwMZN3VnhHPHf/RQ8MTFv5FjFX+LWTRaWBLyUQS3VmH2uaFUD4LhoOnEzIXNHu8M1Z966Dq1/q+CpAIoCFcrPQFWOKuvVuxQAfY8VzbcnVAXNxTd/mU1jpgEqViVqTjMi2FdnvgMhFH/68rTJ8KQu4lEqKiGJHtYSSUBYkmBERkOYud4BIkPQZz+SyV/b7BuWvrrywXqCQmuwahtaLO0q8YWLRVJuZHk3CjVGHQygyoHtng2BlpQA08Im7j2QN9cnzrj7w+faM3Le9ryKH8MgXx9etYRgpx03m5NQNo4G0Ao4ypK0d5iuMVXoad+yHZ+m/k6uBMHGlj8nedBPcrHgjvlZEV90k6+O+z4rc+KOqnmSWbkoMg4aDBkiGouaRQp5bbDu4Tumk1WrFE2q0sDescRu2/vWIV3jltUw1kMkJi5cBuel6YikgbY4WAbLeIQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(53546011)(6506007)(5660300002)(2616005)(36756003)(7416002)(66946007)(6486002)(66476007)(66556008)(54906003)(966005)(2906002)(83380400001)(31686004)(41300700001)(478600001)(86362001)(8936002)(8676002)(4326008)(31696002)(110136005)(316002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0FpMFl6UG9vR3VhVS82UjJIVkgvSk05ZTBXcTlwbGt1R01Ia0YxN05sUzJU?=
 =?utf-8?B?YStZczM5bzZMUERyU3JuUWloclQ4aU11NjNzK0VqbC9vV3hacnBiMVN6NFBM?=
 =?utf-8?B?dzBHN3BHeVhtQ0N3U1h2aTZ5YnpJckpTZlNMWUpJU1NXVkRjc0RIOFBaMUhE?=
 =?utf-8?B?bmR3d2JIb3dRZTBJWkFBazJXbnp3MExTdjFEQWRlUTNodWlOMVBhc1ZSais5?=
 =?utf-8?B?UXR4TGV0SnJmVzdleFpCTjl1TGljRlhXdEk1MG1ZTEJtMUpLbXRTTGV1bW05?=
 =?utf-8?B?OHJEck1tbXJRSitxaUpNUWNYcXRtZFRoejZvcUNEOG5WenpPVTFIS3drMVZ5?=
 =?utf-8?B?TG9ONGUzclQwZkZlQ0lZWTZWOEpsV2kyRWlYcXVPYktyWWRtMGg4akdRUWhl?=
 =?utf-8?B?QVd0Z21ZNm9LaEdZU25SQXlrbWRqTDA3YzhLZ2kraTVGT2R6MUN5M093eWxk?=
 =?utf-8?B?bS9ob0ROL2FITmZzU3JhVE1MSDdWKzk1MGoxSmtSMGhxTzB0S2N6Vm9Fd1hY?=
 =?utf-8?B?bG0rTmw0ZlhyUlBzZmQ1SjEwL1NuWTI0NWp2NTQzYXR6WDVvSTJlUGVTeW83?=
 =?utf-8?B?WG1acVRxb2I4dENTUUFGbUhOUU9kNzdJeDZHM2FaYlRjVVlmOXNSOXRWTDE5?=
 =?utf-8?B?Y0VIVHZvM1hDeTl3eitzSzJtNmRwNTU1RGY3Y1JjNktkMUZKNjlPc1cySEVS?=
 =?utf-8?B?dHVYTTk4d09xTThwK3FxTFBFRWpYZWZ6d29Ka0FsNHNUci96eGcyOW5vRWlK?=
 =?utf-8?B?MG9abG5rYWE2K2NZei94eTVzaG9kL0E2K2NCeS9HWm0vZEhtTk1oTG5jVzVh?=
 =?utf-8?B?bk1xMnN5TmQ1SVhDd3lPb3ZXcTFLRG5Xc0UyZjBxcUxOdE9pY1BJTkdodlhl?=
 =?utf-8?B?SWNHYS9DUnpMUVFtODdtQWR4Q3A1RHR0OXpZV0dFMG5nbE5PLzdlRkxqNndI?=
 =?utf-8?B?RytFeHJKTGpvVCtGSlNnaG1IV2ljWWl1MWdsN2hmeTZ1MW9tbEZlYUQ5WU9G?=
 =?utf-8?B?TEdaZTRudWNCUkVzU1pmbUZSWGQ2TVJad1J2OUw3d0RPSVNaVWZHNmEvMmdY?=
 =?utf-8?B?NnQvajM1SVI2TXlQa2NXVHZOU3FRRFNoNU54S3N2ZktBb1loTkVqU3J0REZs?=
 =?utf-8?B?eENveXNlSmpBUzRqM2U2RlY4d1E1NHNhTFNJNkVFRVorU3BMWk9iWENTOU4z?=
 =?utf-8?B?ajRLanhsTVY2bnI2SllMYm8yYytlZTFwcDZ5SGVvR2YxWTVjWVVuSXVxekxH?=
 =?utf-8?B?WGpTdU1ZZW9QRWZTa0R3ZE9Sc2k2dmR2M1RPYmdLNkFScXZKTjFyVVl5eDVB?=
 =?utf-8?B?NGdMQTV0VG85MHVjUm1tZWljTC9SMUxyR0l2OWhYUjZDdVhrdzRWT3lYbk1y?=
 =?utf-8?B?SXR1YkRicmJ6Q0ZVNXEyTVdvamlnNEZlN3I1Z0hrcDBZUlNlb0UxU1pGbDEx?=
 =?utf-8?B?dXNFbjFpN1NHaFY2OWpCNFo5TTNGZDFXQUlxNUlnTFFQRnNlcE4vc2FOMmRJ?=
 =?utf-8?B?bFk0WHJ5SENNSW5mUzYyM1UxT25ZQjh1dStQSFh2dkx0MGFFZ0gzR2svWERt?=
 =?utf-8?B?Vm5wMTBrdHhvd0hEb2hHRmdJdG9vVEpQZnMxa2lCck1ta0FXU3ltTlhwYTlV?=
 =?utf-8?B?eENvZWpvSWU3WE0vN1lrbnovRnhkS2JLeEcxcE1mMnJaclo3Z3IySE9obGVQ?=
 =?utf-8?B?MTU3S1F4TU5OU3pRQVFySkV4WDR6OVZyQlpXc1RZMkZ3RFN4VEROem4wNVpM?=
 =?utf-8?B?TU9LdUFDNWs5VUpGRUVNRUhOTGFtZW9QU1oxWHpqdTYycCt1ck13RVBDeUZh?=
 =?utf-8?B?QWZnUnRoMjN5ZVFsQURTaWNGVEdpT3RoUE1wTjFFcDFTd2R6bzhpTjI5U3NR?=
 =?utf-8?B?K2JnbytTOWZiLzRnYmo2Wnl6cmloZTNNNzY1WXZKeWQ1ZXIrOVNTYmZ5b1RP?=
 =?utf-8?B?Vll2QjdSaVZNZTlMZlhRNUs0ZzVBcFBFK2IzRVV0Qk5SbWVkcjQvNGxHSStk?=
 =?utf-8?B?L25GVFRBM2N2d3dObTQ1aTBZZFpRMTBqTFU0QWJKNDBQVVFuSkVWVFIrUGFM?=
 =?utf-8?B?ZS95RWJHV2FMRFNOQ3dDZmlYc1BIY0FjWEFFSFF6cllabVJHTTgvZ21NRlV2?=
 =?utf-8?B?NGtkdjYxcDR5V3pmRDExMjdyeGtQdVZwVmxuOW9FOW44NFd5bXltR3BMdmcr?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32464a3f-057c-4a72-788c-08dbfa8568d5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 20:11:50.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ac6AP5QxsrS9jrSBWKT+66ViA1GwsujHOF838ANaO9vx77LOejzN7n4u6K4BwBtYq6Pzz25gfMcEHlOvL1rysg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231

On 12/11/23 12:01, Mark Brown wrote:
> On Mon, Dec 11, 2023 at 07:00:32PM +0100, David Hildenbrand wrote:
>> On 11.12.23 18:32, Mark Brown wrote:
>>> On Mon, Dec 11, 2023 at 05:53:59PM +0100, David Hildenbrand wrote:
> 
>>>> https://lkml.kernel.org/r/20231209020144.244759-1-jhubbard@nvidia.com
> 
>>> I mean, I guess people who don't want to install the headers are just
>>> not going to be able to build a bunch of tests?  There definitely are a
>>> bunch of tests where it's not needed so I can see why people would not
>>> like being forced to do the headers step if they're only interested in
>>> those tests.
> 
>> Yes. And before that, people mostly had no clue that headers had to be
>> installed in order to compile successfully.
> 
>> So maybe a warning to give at least some hint might be reasonable.
> 
> That sounds sensible, especially if we could arrange to flag when the
> specific tests being built need it.


But the end result is messy: not everything builds in some cases. If
instead we went back to the little ifdef snippets, such as this (from
v5.1):

hugepage-shm.c:

     #ifndef SHM_HUGETLB
     #define SHM_HUGETLB 04000
     #endif

...then with a bit of one-time, manual effort, we could get everything
to work at all times. And that seems better, doesn't it?


thanks,
-- 
John Hubbard
NVIDIA


