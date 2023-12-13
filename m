Return-Path: <linux-fsdevel+bounces-5807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8A48109A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 06:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD95B20D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 05:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862CDD295;
	Wed, 13 Dec 2023 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KMWi8rN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5CC8E;
	Tue, 12 Dec 2023 21:52:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDJj0YMFlNCiitMHrO5hklnEjI0MoHTXJBLcV7Gr9krZT2NPbUzq6VH2elVd+fXZn4UUMJZ48UutDb5Xw4JVhbeUiDhKqjaDgiEAsWFbwYsRRyyaNZ90S8Mt98SZTLXlQMe6sHeB3IYUrzY8greSvtzI73MCimcgVSW+8hWZ0LhrgFjM8oxRfD5zAAeQNRZwt92VKgEsJnKo7UfWTwqIDjp8bsRa7PD5utFHdpv1q+USkxASd1yCXjoQN1q9rbLqjmKX005wAIPy+qP/8ocIdjjni5fTb2+j3n288qPIucF6I8DreeIwEUT+/xEsgIxwb7ay/OPpLaC7A/ZyOJ4cgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh1J8sD45eecJoqT/b0n+CR3FXyf9Yjm6J5BXmRNi2Y=;
 b=X5Ra7We4ZwiQJImFXb/Yg/aG5yVtrN4KSIIvJAT7hQyaliMTIt3CgIfkBYuX/GSOfQa8S+Lr2Zo1gBllsxWeKwrxZnfLY15gtBNzeq0dcLwNOP47LH7J9Fh58PPyu+FsSHHBAgNICTgbDDHBki8iFtFMPK9NXV6fTVNUQQqAFBTsyLCrGTE2ZNGznaSSZ0QEfNE/r5WCKbwiEOcaPuJIb9vOBjnUh27a0bKdt7VmZJn4XvPxF4IOE2/n8Nb0EQDL5+w+wa13VgsiOuebS0Xz9BgezDA+YqHbHfr5qhNcH4WfpjfGySQNVTVW18cW9v0AhoLSNPQ466W+SkQ4m4YAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh1J8sD45eecJoqT/b0n+CR3FXyf9Yjm6J5BXmRNi2Y=;
 b=KMWi8rN3nspS8GTBD8lolQHKSkQr7MoweqVeZpw28zWcle4ttG1og/HjOq/9KPt6/6MlDuol5S234wRK6zMi1MIGQACj06DZ0Nsi8+zxDiMOv3B9eR34YSBme9rUJcoGnAA/2bHCEZtj7/NpxGP8kRDHJg4+7LiBhgnNTRKXfxGBL72M13wmrjQ6sB5beoDzLHRpHX8a8Gl9m179+qyn25M8AhoYxFSO+gb0mSdUFTDiFecChhqOHvEJNZOl+l+z6SRDUzacm0nrCK+Kdk4S2F81TCrXEUQHDoxwTdRr33thYhNozTg4V76SDCxEBW3J/aFNdGKf0J9+LV97ddTJww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 05:52:48 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 05:52:47 +0000
Message-ID: <0d68fe7f-2a96-467d-87b0-52db36704e1d@nvidia.com>
Date: Tue, 12 Dec 2023 21:52:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Mark Brown <broonie@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
 aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
 ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>
References: <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
 <3d22f342-280f-4a44-87f4-8cca291cfce7@sirena.org.uk>
 <e3048458-726e-4b98-b2bf-908ea9066959@nvidia.com>
 <0f97db9c-5b86-4f56-8463-2520fe79f709@sirena.org.uk>
 <f1b0b80a-1cc6-48c4-8a53-0222b3e59c7f@nvidia.com>
 <2e4a719b-f2b3-48db-99db-d96040d78b12@collabora.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <2e4a719b-f2b3-48db-99db-d96040d78b12@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:a03:60::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH2PR12MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: a47fbe38-a1f1-4ef4-1bf5-08dbfb9fbb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m4WsRd4UFl1Ki5NSdXXKpChQgRktA6QPC5Pa22yF+Awyz1M0M7TA5X0FgXazMgNiw/PPGNxfLLxS5sRabgVlywCeARfE3x1e/tlRS0jSY5lnr/y+cyYQ1Ri8dDiV5LaA4juDXMtCvElpqG67zOJRyTh6Bu5SApVHuvESp1b3ZJsoutmkOf1MZyccCAZnuSWfyr3cXx5rhypRxrTfhB2Bx6ntwpSGJt51hYy2NZnvkLTabyHMWxvtToi9scD1L1FKVvHAdf+OvB4E5WHbv77iAAv2/5+kr4Zqcoz535ZCKWBTYHjQdhXiqTuYYIwUU3OxD/nJ07dsNcgcuat0zQXOnF02dxceGECeTdrzGTNDtWJ4WhMnpjxLcXZ9oQIYdJdla0vp9s8+BUPAwwIY7ufApgpHsDQ29/a2l4MRvuVEpEexV3hRpjEsNVdKdsptU2FWgtflSRvNW3tpcMVblL+GQaj0UwsJI4zcvGxIrewXJkZfgSwGfjEQUBCUVkUD8zShV24zMAIb/cfYonUDIBZgyofpZseML0WuN9QiozGBC/vO6+HUQNhxwAFcBg8m0MuEsJ/addUP/2wmfDhlBM7s/BQtb/022r5UD2TgHQchZincr78YqUHM0u8mDaGnBdr7tZKbT/+Wj5vCQ+Lsha28oA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(66476007)(66556008)(54906003)(86362001)(36756003)(66946007)(6506007)(31696002)(2616005)(6512007)(53546011)(8676002)(2906002)(38100700002)(110136005)(6666004)(316002)(6486002)(478600001)(5660300002)(41300700001)(8936002)(7416002)(7406005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODZsK00rM3FxNUdnWnZLdDdLQmhSVHBIQmtiUDhnL2lYR1BJU3gyVU13VlhG?=
 =?utf-8?B?OVh0YlYxSUZnMnRDRXZBOHJhc1MwTWRKNTJXTzJqbVo5bnp6R1ZDcXZlYVc4?=
 =?utf-8?B?eW5wMEVFNWtmZ2dxZk50cXBqL29MU3VqU1hPYnViMWpEMXp4SU9xemtGMllu?=
 =?utf-8?B?bHBRenJrM1FjUkl1MVdmL3g1aXc2ZFZlNHV0NG5tSlZsaGo3TEY0TDFwT0pr?=
 =?utf-8?B?dGtrcnFyUTB0RmY4dlhCNWdpTXdNT0laU2dXUUdnOVFBMTJQSUEybG83d2dO?=
 =?utf-8?B?SFlqOEx4eVAwcDJWVjZDWnNzK3pTenhhMHNzUHc4MXVkczV0enpRWXpUeE02?=
 =?utf-8?B?VERtUE92TUVGQXVIaTJDRW1nWi9BbjY5MHFsN1Z1ME81OGY0UkJZY2FjUXRv?=
 =?utf-8?B?bGQ5aXBGODZDbTQ1Q3dmaVJRblc5eUNTYWR2YXZZUk0rSzFtQWxTZ002S2RY?=
 =?utf-8?B?NVBRLy9CczBkQUs4MVZRMFFEbTU1VDdTcVJVcW1Ud0dxYU5oaENobUFWTldm?=
 =?utf-8?B?VFpBbWxRZVZpSlA3NEljMlFaSDlEUFhoaXJvbm9NRGozdEtIU2FhWkc1WVEv?=
 =?utf-8?B?TXZ5bHRpQTdFSmQ1NHNxY3cxb2V0VmdJYmpmWHVFdDJwV0k2NDFaQ1VqSits?=
 =?utf-8?B?VnRGb0h3WGd1MnZadUVQNUw1RFA3TE5qMVk4MWc2WWFvVlVydksyeVVsczlK?=
 =?utf-8?B?cUVJV2t0YlVSZTUzY2Q0OHJBdUZidDh4OHloOU01MU5TOU8vc2RsVTlFbkZ5?=
 =?utf-8?B?a3FvZzcxRXNPRnBqeGo4Rmt5TzV6NFFrUzh5WUpEbEZzRE5aTjRCWjdCaytm?=
 =?utf-8?B?cUJOWGdUN2dYWnJsMWZCaFVnT3JPWk0vS2F2aWZZczlob3pWdzNaa0VKOTVP?=
 =?utf-8?B?TG92UHQvV2xUNWxDNGxBbVowZkRGbU9obXZrMDlKS3J4bS9sVjBRZ2F6TUNv?=
 =?utf-8?B?cTZMODZHUEFmdy80UkEzbjZISE1uZk1iQ3kyYnJYSzdBck15WEtnOUNhbW1k?=
 =?utf-8?B?MldOdWpSQ2xtZmlMYzkzU1J5TUtnMExENm14UDVGcm0wSm9FS2FmU0hOdHM0?=
 =?utf-8?B?bkFyL2oyZWlqT0pLM2FQUmVhYkRJL2JKOEd2TGtQVkM1Q2Z2NTNLa2FPWi80?=
 =?utf-8?B?ZVMrdHozSXlHUHVJYTZBNGtjcFg1MVE0M1ZiZDVWTkxYV1ozNGdHQktUTzkz?=
 =?utf-8?B?NG5LQWlEV3B4dHo2R095VXNlOEQyN0ZidURuSkdFa2NueUR3R0tFVW92b0VV?=
 =?utf-8?B?dkhhK3FXREtXenBnTEdpQm5XODlPMU14K0x1Y2w4NW5QKzlEb1JJSjVleHdQ?=
 =?utf-8?B?eSs0SlZ0cm5JQitmSEp2aTlRZnpsLzZWK2dJR0RKTEk0a3NvUTY2Mnp2Q0dt?=
 =?utf-8?B?dThocXg1d3FmQ2VzbXliUXlUaHhLd0tXRHVtOU9vdno2akNIUDdjMTlpSVJ4?=
 =?utf-8?B?amp0TzN2aEFRWTJkWE9zc0t1ZFB1bDNsRHBzNTA4dlBkc2JzdFVjNW41V2RF?=
 =?utf-8?B?Z3FmSjdSQURtRmFtTWhPVGkvUFdtVFdURUVlY21YN251V0F0MHBEVWM0UXBm?=
 =?utf-8?B?MUNoOS8rWld3VWlTaS9GTi8vaG5SSld4WE4wZThDbzhwcTRPeXBoSlkvSzZT?=
 =?utf-8?B?R1EycTNJYmtZYzVaUTdDdVVGYXpEYkJWZ2NmNlR3VGtSSkhqV0ROTHdkVUJW?=
 =?utf-8?B?cGtTRXdlUWszakRtRVVuQlVETUxxNk9HZDdXdXN3b1BBUjBxWGErM0Yra1ZP?=
 =?utf-8?B?TEdyajBVZzNpMmVkRW5LL1VLTjVSZjFmTjNZQzVZRVp1YnZZdXI1VHZpU2RQ?=
 =?utf-8?B?MGw3dmpoTkUvV1FRU2Z3R21pRkxpVUhvK3lXMytrYnNOS1pDTURGZzBmR2JS?=
 =?utf-8?B?TTJZNTBhYTRwN0k0T3RldlZHWkZwVU5lWkw1UXZYUGFsSjVzSXZJVitKak5I?=
 =?utf-8?B?QmN3TTJLa0NKVGkxTS9PQTdUTTEyVU1RNEdsekdSMnZGQ2Rnc1VCYWlQTnZ2?=
 =?utf-8?B?Y1VycFB2M1BxanhvSWF1OWFYeU9jUUMvUGNPdFhLUHI5ZWd2RXgwa2NKQTFY?=
 =?utf-8?B?c2tIRWd1bVZwME1zTzNCaEIrZFh1NmhqU3ZucE5DaWE3Vm9BYUFvR2JxRm5Z?=
 =?utf-8?B?dU5XUHFBWlFHMzAweVFIbzhLVGNlY2VpTEROQ3RTVWJOOGRYalhLS29NQ1ln?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47fbe38-a1f1-4ef4-1bf5-08dbfb9fbb5b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 05:52:46.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6QtjXjGuc+8XO5TSJUrWFe8HMD3MU37i/5uFeF59BD4Mx7atZ/95uTBbFVupNFHOSmlXhqFbHAJNhcmAqtuhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4858

On 12/12/23 19:58, Muhammad Usama Anjum wrote:
>> ...
>> Oh, this sounds like it would work nicely. No more "make headers"
>> required (hooray!). Instead, the new approach would be "selftests are
>> allowed to include from tools/include", and then we can just start
>> copying the files that we need to that location, and gradually fix up
>> all the selftests.
> No, this wouldn't work.
> * The selftests are applications which include default header files. The
> application don't care from where the header files are picked up at compile
> time. We should be able to build the application on normal system with
> latest headers installed without any changes.
> * The header files cannot be included directly as they need to be processed
> first which is done by `make headers`. Here is a diff between kernel fs.h
> and processed header file to be used by applications:

Well, that's not the proposal. The idea is to snapshot various uapi/ headers
into tools/include, just like what is already being done:

$ diff ./include/uapi/linux/fs.h ./tools/include/uapi/linux/fs.h
$


thanks,
-- 
John Hubbard
NVIDIA


