Return-Path: <linux-fsdevel+bounces-13924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0086E87581A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C171C21BA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304D1384B7;
	Thu,  7 Mar 2024 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7vZfY88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65759138490;
	Thu,  7 Mar 2024 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842626; cv=fail; b=gPCErveNp7StJ2L4EuoV66lWCba+A53WzpVT1gpz8CN9014qsRTm2phC8zaM+Yr7+MPg9PTqOS4jsz0UmZgEAPxRvxVNxtR939BcBR98EzgwGkeBlIhBe90ZO9FxW5Az4GHBkmSjr4Qf6aXLKxevKnlW5Cg2hsusZWeeW0BDmms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842626; c=relaxed/simple;
	bh=N0dw2X7PtpUeknagnShwyUDnAERJ4C9WRLCokOKKXRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OknQGu3WVXJncQBpZNOfz31l8fFakeTxJ4d8nSR1/sW54bKAZRaWKRf08D8AfOPkuEX9dvIMDrc3K7jg2Fuq5oqwnbAAQmqkFvan7zyatYEbCUD0diddWeIppOjzyreZmFI9uEZRBNheSEYGgWxUSEOlTln/SEkUk9uORx1/bdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7vZfY88; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOlLTBwlMmZM4tvonNrG4XcUDT1W23QwizPhaTv2CY8wo5Oasq9VQEcpl/wt0zHlz7/wPG/+J4fDzs3cd+f7FX0aYlRgVa8iUrSWC3gtm0fU4aaf2Zg/VN5oRJocim9m6sE4U0M5cY4jLzwuyvgr3N1LgWwBxmzOGNVG7W2H2eGqi0GbtKsugx0tV1/qyTy3UjtaI4kRQf1es1yj5Mfo0KI9H6zLve+9zBsoOam3O7qGVTDUpXux8FWUda6kLOIfXxmfGooAFjkshE1G/kawmXia2QTy3KJaLMc1+pHebJZmhqyXYM5qd8xY9yGrFno/J4ghUxnsJHyHJJeaj1aaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7s4XicH8YeybJo/rrKc8QE6AxNj/Mk8kfuPkU5a3d4=;
 b=IKjhN5gFUR0DHlkjrgaH7yQgpWKqR92BeMLVMm0vu4Y9em7uEnDpj3XqIQPX6dQAiiFx5Nre0/oLKZLDksw3uzJ+MB5cHzCr82ZqGY6e4aA0dRJ1zGKsImjwDC9CAquI3qQl3Xm7eDRW0eQ+D3+LayJV8yTW3WooAFrIyO7C3p2+JtXQFdWpOY64E6cVuklc119gIJGew3CnXnNoO6iQzkRKg8fDhkGsv00UVDIHPkdljYyZZuAnPgLf29qW9N1Bt511u0aG8opjDTV/tyB91btIYnR8qVOJTCnwkj9IeY8LeunOZyCJqSLy8F/9aLQAG9eX0XiV7NouS56lAHjuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7s4XicH8YeybJo/rrKc8QE6AxNj/Mk8kfuPkU5a3d4=;
 b=T7vZfY88qG1ekaAHKYMl1ARmWm/WjwPhkWeH9sow4nrnHo87x0TY/1EQYIov9i24kMG8OLMsQJkZ5csT8e6/ERabWP2D+IJw1LPZ1J37Kh+Dfq07BWZ0iI5GKDQCpdbWKagiCCYi/Y2slVtBgOKOOCBHjxINkDKJHyluo2A8lgn1yVLCp03Fhhfd/2/2OFOaD68pNDFic+FSu8t2AeqWqM9X+/IrT9XnXAS1Z/kjYFtOVbCPHaJJeUfRvD172uiM2EQ0l12kXM4qGby8Juxp16c026mZi4xJdZK6DHrzuO3Kourh7geWlFX+1l+WkhbXsG2rOA6mc6XrJNizyouxjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 20:17:01 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::3889:abf7:8a5e:cbbf]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::3889:abf7:8a5e:cbbf%5]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 20:17:01 +0000
Message-ID: <72bbe76c-fcf9-47c2-b583-63d5ad77b3c3@nvidia.com>
Date: Thu, 7 Mar 2024 12:15:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 37/37] memprofiling: Documentation
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20240306182440.2003814-1-surenb@google.com>
 <20240306182440.2003814-38-surenb@google.com>
 <10a95079-86e4-41bf-8e82-e387936c437d@infradead.org>
 <hsyclfp3ketwzkebjjrucpb56gmalixdgl6uld3oym3rvssyar@fmjlbpdkrczv>
 <f12e83ef-5881-4df8-87ae-86f8ca5a6ab4@infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <f12e83ef-5881-4df8-87ae-86f8ca5a6ab4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:510:324::21) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c9a58d-89c8-40d6-9452-08dc3ee38c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X2EsV2IAe4FAnTQI+rB7lTLs7uoxGxby4zg3lV+Hh8RFantomVuzBAcyCRhg0rBaWddYxbEk/6WiwAw/V+6Lo7q0zdfSbYHrD5psu4u5J+szSWKwDZI2WwWPtm5FQcb81dEdOxg0XeqMmwDTrrOkg0jvSQfdrPGYnn6qrtWcZ9xv4dTy8X7VDnIKl0QUem4RzhettuoteOaOdtA+LFdCcF9aB3a12BULVDo1Rk7BRK46KDMtPEi2DpGm3RdfNhRZscZlpVqNr7Lh3Q4kqIHwhd3vC25BZ8Pme14RpXgnmF9VpujVjWK8xrZIrRwtwQ3MlUIKgveL6clVe6yNcr9uyByR2Oo1xQeqdpN8ztHaRe8SFg3wlp7es0QjHUKMylZeCjHPvKHWQ4kt51ddT25XIlAIitIxZIAj1PgU2RG3HKsJrbh/GPNu0vwc7r2VLmJaOlgoFHwGfHzzZ15Icija5pnClLOIYzmivK1vRYvhQncU4wfG18zg2jpVtAiUZXMeA6q54OPYDScfv7rSOMe3k7cfB7sbWV+JbxbmFdRNAezm2uXQoGceTVrgIZGslJQChI0krmJgWl3GQ02v3nDO/xaBcHbtljb++ww0UpSfG1qrgMMkwbWEC2xBQlj5TnXiN5fiA27s+atesxmbTFWaagY4PCp5zwx/lNh4qV1F+00=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVRNRUhqNnlSbjJZUTlHbk9QQmVVNFppazFXemszWURWRVc2RHNHKzJWOFl6?=
 =?utf-8?B?dThTQ1lVUUdReGNyM01tb3JnWGJJNWp3Z3haTklXdmdDV09jaVVjM1VKaU5N?=
 =?utf-8?B?WU8wdzRCUWhWeGxMQ2UwMUdZSkd3MTV1dndNa3NRT0NEWWRla0U0b2I0Qm9w?=
 =?utf-8?B?Rnd2UkxreVBieEpjQ2xmWkpkeGc0T0hPZlZZb3JJU2xVem9LU1J6TVkyYmlj?=
 =?utf-8?B?SzVxQjkxQ3UwYmp1d0hDaVRiQlVDS3I2WFVYeVlMaFE1NkZtdWJVaEhJQUhZ?=
 =?utf-8?B?cHI1VTdGREZWOUFLMU9xZkowdUVIZHNkNDdYcThORlc5LzFjcjBXSURXOG43?=
 =?utf-8?B?ZnJEdzI2QzJLbG4vMHRIN0U5dWx4RlRBbW1YVkV0eFVVQmJONmk4ajFZU3RT?=
 =?utf-8?B?V2graFhEd3l1ODdGTlZPQUFqeSsvWkpCOVdoTzJMOU0wSzhVYXVRYXBuMWIw?=
 =?utf-8?B?cDIya1NDR0JQVWdzTFk4TFo2c3ZEOEJnazMvWmtJZEhPbmpORncwR1NOVU1m?=
 =?utf-8?B?U1FpUDBpVTIwMER5dFZJOGFudkpnNjFBbExMYnlTMzVEejJFZk81KzQzbTZP?=
 =?utf-8?B?U1d6MXNaYVEybFJYOGcwU215S2tMRmZLSEh1L1d2bWtHdmppMVh6RHhJT1hP?=
 =?utf-8?B?eWY1dGlWakQ5Q0xMK1l1Qm5XRGhiY0lnaTh6clp0Qk5vWk5SZlh4MVRwSVdY?=
 =?utf-8?B?d3BMc0lKMFd3Tkc3N2pZK2FjRDcxSTFnLzBacEdRWkRqTlBZZjByVWNjL3V3?=
 =?utf-8?B?b1JaT0wyZ0V6R0xuNE54VGdVcnVsaFpHYzlSTzRZdE4yRVRxbGxuaW9ZNGo2?=
 =?utf-8?B?OUJKbk1HdmNJblo4Q0JlMGNGWFE5VnN5anA1Tm1tWVg3Z2tOOXQ2N0Jrdlhs?=
 =?utf-8?B?Ty85blJiN2FqZWhZS2FqK0VZd3pTMEV2TzdsVzErZ3pUSEk5YzVjdnQzWkFk?=
 =?utf-8?B?eGZrY3NsL0ZQMVZWaGtEcHAxNjNvKy9TTlVRNWtzNi8zMWw1N2o5aTZLOVJK?=
 =?utf-8?B?N0grd29ReDRLbGlZbmwrQmZEYkZ2Tjl3STNwNjNsazJ6Vm1tOTh4MThGUVJE?=
 =?utf-8?B?S3ViQm9OOG1TcnF1dUhiQ0VtTDRiVlMyUFZoNDg4UUhhdFRPUC9sdlIxSUhU?=
 =?utf-8?B?NUJ4MXF5clNBMmxudmxkeldNdUM5NUpVQ2xwcTVnMEpJK1phQS9WUzI3VnFC?=
 =?utf-8?B?ampxRmpkak9tRFZRMWJMcGp0b2pKamw4VFNvMGVHTDVRS29PVm5HOHd1dnFJ?=
 =?utf-8?B?YjYxcGt4bmw3NCswY1Bqd0YvdTludDdka0tVY1VkaVdWMUpWRmRlYk5Ia3NG?=
 =?utf-8?B?dDMxVDFxaEtmUk43ZXg3S0x6QXlodWNhNkdCOUkxeDdNOTBHUVZsRDN1QnZo?=
 =?utf-8?B?RE1BOXlSNG92NjlUUW5waXh5UXdRbzc1c0JzUk5hK1o4alBVL2NGL2pUWnlX?=
 =?utf-8?B?bENSNHNmVldSTGx3NjI5NmJvWDdGUzVZbm5mVFpwRFZ4MEpsS2hhKy9KNTNT?=
 =?utf-8?B?ZkYvVU4reXFIWDgvVnUrdURBRmRhSEl6T09UaTJ5YmV1eDl1dzBIc3ZYMjM4?=
 =?utf-8?B?UXBnVjVZUm9xdmVYREFwRC9OaXdzZktDNmZpdEJzNHJQdFhzY0RDYU5hVU54?=
 =?utf-8?B?aGcrNm1ia3ZvK0xRRTFXTTNIajZXSFN4QTVpZWNZYk1hMlZpNTVNVXRrL3Iv?=
 =?utf-8?B?eVVuUGZCenZaK21VQVV1TnU2LzFsY245VEFwVEllQnZ5ZzVXRTRUV3pCRGhx?=
 =?utf-8?B?R3BhVnBYNUdLS1A4TkhlNklpTmpQVS94TldQZ0crUEpnOC9KTlRueG53ZHp2?=
 =?utf-8?B?Z0E1SjduZ3VqZ0tyTmxKYzAwTjRudmw4VlBzamhhaVYyQlFVUnhJczhENW5T?=
 =?utf-8?B?Q3RIaTBoVXAxNkNoS2FqbHpLblQ3TlBsNmt6VmFoYXNNdm9Fd0NreUoyeE15?=
 =?utf-8?B?YVlCcFcxeHROUUdSL05TSWhmQjhnY1ROeVN0dHZzVytpc3ZRRTNabHJHUFVD?=
 =?utf-8?B?Y0ltem1NVTBFSXRSQVR5UXM5NTlCWlcwdXlDQzQ1US8vR3pieFlIRFAxbVNn?=
 =?utf-8?B?Vk8zaXNsR3p3Y0xKZkpRandOdGVDNzlwRXVTV2MrYTNjbURadzdWRVorSGNQ?=
 =?utf-8?B?QTNNSGcwejI3MlpVaXhLQll4TGZFU0J3NzZTeWN3am04M3YxOVhBdmwweW02?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c9a58d-89c8-40d6-9452-08dc3ee38c0c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 20:17:00.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aX9+cx62u2VWbPatFvmRIH0FEDGtvJ01V77+fNZobRLlIU/4l9yam0PDiX0zd2ehjS8vamskC4Is9iiR7oNtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609

On 3/7/24 12:03, Randy Dunlap wrote:
> On 3/7/24 10:17, Kent Overstreet wrote:
>> On Wed, Mar 06, 2024 at 07:18:57PM -0800, Randy Dunlap wrote:
...
>>>> +- i.e. iterating over them to print them in debugfs/procfs.
>>>
>>>    i.e., iterating
>>
>> i.e. latin id est, that is: grammatically my version is fine
>>
> 
> Some of my web search hits say that a comma is required after "i.e.".
> At least one of them says that it is optional.
> And one says that it is not required in British English.
> 
> But writing it with "that is":
> 
> 
> hence code tagging) and then finding and operating on them at runtime
> - that is iterating over them to print them in debugfs/procfs.
> 
> is not good IMO. But it's your document.
> 

Technical writing often benefits from a small amount redundancy. Short
sentences and repetition of terms are helpful to most readers. And this
also stays out of the more advanced grammatical constructs, as a side
effect.

So, for example, something *approximately* like this, see what you
think:

Memory allocation profiling is based upon code tagging. Code tagging is
a library for declaring static structs (typically by associating a file
and line number with a descriptive string), and then finding and
operating on those structs at runtime. Memory allocation profiling's
runtime operation is simply: print the structs via debugfs/procfs.




thanks,
-- 
John Hubbard
NVIDIA


