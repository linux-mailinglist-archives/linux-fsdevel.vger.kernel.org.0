Return-Path: <linux-fsdevel+bounces-5557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0004580D893
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7B7281899
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E27E51C2D;
	Mon, 11 Dec 2023 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MhaiGmEG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2213AAC;
	Mon, 11 Dec 2023 10:46:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfZzT+W6Lj86Eo5tP3aTq4GzKWQwlUlcZK/j+igImqqu2nHhvzi4FFokuGTs14nLUb/pmcSVRrzOzdtFKRehX81OH0/qpiNZX6YehOc/BKEhvgI5vRabFxZpOfl5emeg3VEKuPc0Y9YE7nhxw7DPKEvIuHfOHxE8MQMTC0pW80MudkJYrsTJFlOZLL+0yfwmmzQ5Z0vthEGsbl33EY7tDVXhpcgzKScqDHL9idprCFtowk3KUt5aU7JRypm6gFG9Ytu4ManFDnFUeL0G2BuHbVgWk/9yWilPSm0e2y213npwDFkhoI9KlXQ1nlSFG0lLupsNF823oNxPb9I+BUZbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPmNsxtfNiCmrwGhmTHLSNwxYQ0a7Kk4zqH5BkSZFd0=;
 b=h+CW1szev32HbtMLxtYj4hQvUEhuxpvsMA3/CWqvHGm/r54QOPaFQ541a1Nm9s04yFWaaND0YSweWCQulD3F+eiihabgS6JuURECIICumhOq6ExvC9wFcLKOBDw8cLmdATxg10MV9QAbHr4dKoFvAETSf99yqrSTl8pp0zXoUAPf12kLCdkQfTXx9GFbgowYApeIjRse33sp8U1b2J/pYhFuglwsyV1ENVR6G/ejJCpSsIhdgVsU58ssf0Yzk+XBrT6C3HpabBOMTmtFwrxJm4H0/zjBkST/26JNzrYt83nGHK+fr9J7vsGikM7L+4kMrOHpK/Pheuazom0Vvzs01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPmNsxtfNiCmrwGhmTHLSNwxYQ0a7Kk4zqH5BkSZFd0=;
 b=MhaiGmEGeFKg6DcQrciwZ6r9K/x0QZJDZIuxFsasoVhflFf01jwb0yZB/2i4/L/JKYVXnGXLu33GLPzQ63u7lKvD2zdJnoDb3W3wdYtxe2em0LGUh6bkvK9Pfruot3m8+DSZ4T5DTGy16yWYRvGJphAkNlrxwPOTyVHyjxn3Ncy5oqwCV88U4BQ/DmO/ggwl80qv9+TNYppjtGxbmFNTnYodM19oaY9PFj88ZV3HMwMFfkCRDeUWKRaF7ZKmZCH8s/bC8kn5qBlr4yzPxLWzAWU2gzd3e6DWcQ0kB75lLxdGkek/6bu6aQEAc6pD2gVaUA6/v64ZOjBhA09sIivvfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:46:50 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 18:46:50 +0000
Message-ID: <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
Date: Mon, 11 Dec 2023 10:46:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: David Hildenbrand <david@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>, Mark Brown <broonie@kernel.org>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
 peterx@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c79468-0dcc-495c-2a3a-08dbfa79891d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7u2Ajy3Q/bFwNST0HLmp5T5XCEUsvjy/6eawPQ5PiGaKRo3/VWHIq8isXPa7g+deJvCzG4zrFUKAD9acnNqHEMNK6ayxrrNNceooB6ASFSOlv7D19yrcaBtdblBSYUl9o6G1WCH/APht9amEKi4FCy6dJk+E3w24bmmIAVp2HOOW2UanUK7qP2VDfGZ5cvERTeTyykGKZDjZAz20vkKwB7ZQCItytFDKiQvMgWmbDxOArMFpgd0Th/E2HZ2KRmmtm4eREYcNvK1n5FOxgtXiXw6ZV/K/RmcF4wNuQnWKd4CSxgIqMdCqEZj+ppmGKhAf/nSHxHLvszMaZe766x2qcjNUq8bUjULiO8WoQS3Z7pdKCcUgpdWUArrjYm7R3/qMtlD3G2VnBHqIpihFz7IpRn+vNjz9xv2f35UDiMHK7LYO/c+HnMzUPr5PDd9qE7uN41x+91p7PZWvL0NRVCJuLaMhqQ1dV/msCxt8LwozNzXXQbD1xCfExdaMjOG2TIOJPhLrCFoYyJmK7yauJb2Ei2aNwn0Wfmd5FKJgv1bYK+G093qV3E0gy0NuapxwQizbhr51nKClECZl4I+Kj3uU/DQs6MEPeaF3eRGSoIbHeEGzhPjW+aWtVypuQeGYRItypGO1swMTRZ2OWHwIVXobyJIAcplU86S4s0rl99ADl2PXjmrAbeo05SOHFpdNNJ13
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66899024)(41300700001)(83380400001)(2616005)(86362001)(31696002)(36756003)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(7416002)(6512007)(6666004)(6506007)(53546011)(66476007)(66556008)(110136005)(66946007)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzBrTmJOOUNKYVRpamxhM2x0S1c2RSt1TFFoUnRGb1dDMzhEb2lLU1p1Z2px?=
 =?utf-8?B?cXl4VGRKTjZOeWxUS1g5VmFyNXhiejF6Tzl1MXY1Z1ZaUE5QNVRuZlorNlp0?=
 =?utf-8?B?ay9PWlBRWUpyNFBZUUorSDZsNFkvT1FhK3U4QW5rdjYzaS9tS3gybk1rQVIy?=
 =?utf-8?B?NjZlK0V4NjY0YlNRUzlINFJNOVE0RGpRM2RsZjkxUDF3c2lNVXczbzEvblJH?=
 =?utf-8?B?RFRtbDFXeUxta3MxZlRyVVhpclNzaTljbWM4M1F4OVhYSGxKOEFINzkrTmo4?=
 =?utf-8?B?MHYwWWxyblh3dDhORm81clcxZUV2VHVMcy90N3NOSDB3QzB1Rk1oOVAzVk5j?=
 =?utf-8?B?ZFUzZ0IzbVZibktldGtjUk4zWVNheEo5cUY1ZWs0b3ptWUJkWkZFemlQNDhF?=
 =?utf-8?B?LzE4WitCUTBwVDhyVEhKYUhYOGtvd0JBZVQwK0ExQmVwaXhKTmk5cTJMeWhq?=
 =?utf-8?B?YU5UOGhKOGVTY2JBWHJIMWhHVWxlbWd0blZ0akJ4dVZWZ3pJVTJaVlkzb2VF?=
 =?utf-8?B?aDV3Tk9yRmZKdHlhRzVadDhsUFFtdFJERXBUcjFoYUo4NDdyM0UwTURyS0ZZ?=
 =?utf-8?B?MGNQWVRlZHJTcERENnRCWW5rS3ZxQVVraVBmdjd0WStrbDN3SVpqR1E4dkZO?=
 =?utf-8?B?b0JLVU0zcmQ1cVhBbzZtaGgzUENhMExxK3JDazlFR2p3azJRc3Q5ekhEWGgx?=
 =?utf-8?B?RFkxQ09lQjQvZDBuQ3luc2xpOEEvdDByV2VKS0d1aFVFbE5QYllQbkNiQ3g1?=
 =?utf-8?B?RUlhRmp0QzhJOHdhQzR3eTlaTmhET2JBZmEyR21zZ0RQY0E0b2pTdzd1K2Y3?=
 =?utf-8?B?WnorWDdGR0JwdHBuYkNSN2JVTzNYU21rVkhxTnJub09oTnZ2TnFUUnNjV2tE?=
 =?utf-8?B?b3BNaUtOL1pEM0VUZXdkQlh6ekE5Uk90U04rdDNmc3lRSjViSE9CbEVTM3RV?=
 =?utf-8?B?dEdWeHNSbWtLKytPS25KYjdhTlN0NmlncGtjdVBqc3BWTGtKUjVndm1mYU5K?=
 =?utf-8?B?eUxnWGlqSGlSeDJQOVhjRWtWWjc5TEZhbDlobTNSb0JTd3hpUXJQZHRtWkI2?=
 =?utf-8?B?Ymxzdjh0RVh3eGxPWnhpZTRyTjFtQUFzNHYxUGcwRUwxcmpBa0lhT2w0b1Ny?=
 =?utf-8?B?WjEzT1JjNjVtL2ZxT0R5RnZuRHd6cHF6ekt6Wk5YRmdjSVErdWp0dTlhZXVs?=
 =?utf-8?B?aGxqOCtxMlcxdGFoUVNDYmN4UlkyazBKcDAweEllSjdzR3hlS0tMYmxzK2ZD?=
 =?utf-8?B?MVdoVEhMbk9udzNRZmJvNi9lcm5ndDRVQU5ZZXFFM0ZIV3JYSEJLOXN0SldX?=
 =?utf-8?B?TWowT1hZQlJWeElYWVh1bHVTSHpzK1dsOG8vajZMYTRSY2JyVG1YSnh2eitk?=
 =?utf-8?B?amxZd1krQ1ltM1Z2Qkt4NVVvN2t0ZDNaaDgyNDc2Wm5yNHBQVWUwT3NUY0FD?=
 =?utf-8?B?NmtZMmJRZ0JZOFlyc3BBUWIzeHhMZkEyV1p4WTFXTFRsZnFxQlE4QzQ0TUE5?=
 =?utf-8?B?a3FMSE5ET2RHSGJLQVlXWTl5RTlBV0hNNGYya25xWkQ0R0NjbjJ5bGpSVUZM?=
 =?utf-8?B?Vzh3NWFSUFZwWnhBcjROMEc3aHVjbFI1R1ZKcnpyOGY3UHR6QnpoUHZhRDc1?=
 =?utf-8?B?ZkFtcWl5UEl2Ti91Mm5GNG9kY0RDMEFINU5pTllXNjN6M09VNEM2MzNVYlVt?=
 =?utf-8?B?WHVrNkxOMUs1THozdUp2d1A1ckplMFFicmkvS0VFTWpyYUcvb3pla0Q5dmNL?=
 =?utf-8?B?WkROM1R1YnhTSHFpTlZldG1iZ1lrNTVaeEQ2Y2ppL1ZkWmx6VGE3ZTBLTmxH?=
 =?utf-8?B?NCtKR2wwd0M5K01lenYyaDI0ZXEvaFFaVUg1aWxKV29lU04rR0lRd3JsN25q?=
 =?utf-8?B?WmJSQXVwWjR1eENqWnQ3REZ2R3R1ckxJcFJXRW4xZXZ4eWhTUVVnbzlKMVBx?=
 =?utf-8?B?OStQc3RlZHFiMk1UQnY0alBtQnBLZ29hRzBhN0ZJL1ZrVlExcGdKeTJFa011?=
 =?utf-8?B?TGh5WVE0Zm1saWl4VHYrRCtyNk1NUGxBOUkvNlpLZ0x1YW5NMDlQeWFSamtE?=
 =?utf-8?B?QmIrczE3RXlFb1JvNmhZc1RpZkpUYkhZOGNwQ2hWb01FRjk1Q3JwbnJtMDVS?=
 =?utf-8?B?LzZHeVVnajQxZk1Hc1ZSVFNjMlZ0VjRaQUdQRmN6ZTdLQ1pJQ1ZRSFljNTNn?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c79468-0dcc-495c-2a3a-08dbfa79891d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:46:50.4545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZZ0Uy+2S9NthdYvytgxntAT2XS5oLlYWkf4p79ErvKtJB+8YFMcqJlPcyscWgRE0YTD6K/DUd224LgPmLZjGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

On 12/11/23 08:32, David Hildenbrand wrote:
...
> That's an open question: do we want to be able to build selftests 
> against any host headers, and not the in-tree headers that have to be 
> manually installed and dirty the git tree?
> 
> One obvious drawbacks is that we'll have to deal with all that using a 
> bunch of #ifdef, and the tests that will be built+run will depend on the 
> host headers.
> 
> Especially the letter is relevant I think: Our upstream testing won't be 
> able to build+run tests that rely on new upstream features. But that's 
> what some key benefit of these selftests, and being able to run them 
> automatically on a bunch of different combinations upstream.
> 
> Further, the tests are closely related to the given kernel version, they 
> are not some completely separate tests.
> 
> 
> Moving the the (MM?) selftests to a separate repository would make the 
> decision easier: just like in QEMU etc, we'd simply pull in a headers 
> update and only build against these archived headers.
> 
> So I see the options:
> 
> (1) Rely on installing the proper in-tree headers. Build will fail if
>      that is not happening.
> 
> (2) Make the tests build with any host headers.
> 
> (3) Regularly archive the required headers in the selftest directory
>      like external projects like QEMU do.

Or (4) Hack in little ifdef snippets, into the selftests, like we used
to do. Peter Zijlstra seems to be asking for this, if I understand his
(much) earlier comments about this.



thanks,
-- 
John Hubbard
NVIDIA


