Return-Path: <linux-fsdevel+bounces-5573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBF980DBA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 21:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AA81C2154D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D3552F63;
	Mon, 11 Dec 2023 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VqezLvEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C6EEA;
	Mon, 11 Dec 2023 12:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww21aBPzmKOYELsQSd5+0RMbO+9F1dIC5KSx4rKPp7sO+sXO1lIkSyE7YDaCclEGwmseUIdu4NoNGfAY82Q3sR2ysqyY4vx21b7GVDJgdFjCCdHQoNk4Q1COedNMuvkiergFurNuuuHRovTNYjZ6MV3/XY7OXWKGXjiAhpz+rbSytbOfzSNDhUo22W1AyRCH9EN5cB5GHEZOdVUdhMN6GpLiF1cHPuG8EEzYSvt2f4wDjqEggBVH525T01ZKffwUdqhfQhYS+WMLgFRQgpRvlo9gdYWzdva3BziUWwFSAjIF18zmKyQpu7384sKAVIrjpscXgQbJMybcJv28KvjTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4KC4EQm9y3QoU2E+lOjq/O6p7PsmYfIlaxC0AV2oUE=;
 b=CWandQGhou4bN50+u1ST7gOm4qXsf5F/PoJ03qfHqtl9Lt8F2+SNUn0+DtLusbf2+kQ+4RAT4+yGEzRgZOQFUY73Or+qhngaw/ppC6zOBaa87by7aFy4NcItnkERBT33uFy0nVJzdoKNEixYgoIkUy+fvaU/S0S6w8i7kueeinm11Q8ZoDv0tFQOh1GKgaK1LB//uwv3n+z2z+3FYPEivnAJIEdArmMo8zUM3TSwswL1af/iJlR98BgBMM/3tPQ0nEQXSgJ6q8z/20l87JGPbR9NwRPNZDD+xLqIWLnR2onEtl8/hrlsFzTwTk70PpPyo8KiCN3HkRSARbbR0CFo4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4KC4EQm9y3QoU2E+lOjq/O6p7PsmYfIlaxC0AV2oUE=;
 b=VqezLvENKGd5mydA8wLfD8Zen9Yc2jvnS6EL4ONH6BaVMwcSQ41XJcWZv0Zwx1631+ld00cHVzAxTRs9F9M4pcrBo+QED5tfFU68KB4S64+CzUWaP7RgLKW0dA9oZobZmWZjgFWC2gOEvYxPqMT59uRXR3o+xtFkC/VjgaMmYbtnDGz4rQ9O3ENpNCKnZHouNuRXYPpkXWK1QSJXZKStIKT+qDxUZwDexF3Vi0sV7Hjcq3U78pe+/fa75YP6b6XMdaMN2m6XydXsOvtb9f2hl21Q/Aj5rea7PID1nzV8Kair03HKr9MIp/azL7sIawmAq8MB/MAQyDLXCorCz+rmaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 20:30:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 20:30:25 +0000
Message-ID: <e3048458-726e-4b98-b2bf-908ea9066959@nvidia.com>
Date: Mon, 11 Dec 2023 12:29:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
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
References: <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
 <3d22f342-280f-4a44-87f4-8cca291cfce7@sirena.org.uk>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <3d22f342-280f-4a44-87f4-8cca291cfce7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::45) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efc8827-5c6e-4964-2ca0-08dbfa880198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bs6mrnPvOlXpO0sOQpZMTjByTyptsGDqSWOvkynxHkIzbMSoxJkd6tAx9f+VnUuqzohbckZ61Vdt/LpdcEuk4ruSn7JO0SsFn1kZZQjVnRw0G2dqoryGRHPzP6A+0uGgCB3hoUCTm8QVALXaizSFECJ7baTD8drvRaSP3Ad+s1DpATLLERoXklzgUPND2e80Ze2jJ0huq8sGT9swvz7rymjATmVKexnILhYi5Wj3dtxvNnt1tqxuUJJAYgsOe2mX7LNj/ssD78NlWnSOJ3xZS3G2sofcLLrAzysDKKxzkebcth0Q6fOm5bCoxVEY+zpS25vXNmfCRktA5q+ymPfjzxwGLPojK9h7isNtk/Pr8OkOMrjkpMfD/bJcVXaGLV4UHGG61JjYNi8QjsVD67vK9Zb7CIlvdD/NLluqRrzUQFzmImqGR9106bHcqBYohzO+VJPkmx8UTZZgNSRXmejToGoIfiLmFTi273k6TWAHMYn+4qWbXNvjkZ9hHnZhUEc2q9E9iipz8CDw/LhleFOJi5Clmj/aZtqH4oh/qBmDUsj1mrPFeCfKXqJ4FKeUzAEJ1NREYXv1Eq0vwtHlnh1DYaSg040kxU6PL2VLMtlwWW5ThAwk5usfRuhGKLk73b//ia98pCBUFBHumCwC4LZ1DHWZ/CpZgsRgwzBjsRZdZLUC4CT3ig5xG/ruZA06UjRe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(53546011)(6486002)(6666004)(2616005)(6506007)(478600001)(6512007)(38100700002)(86362001)(31696002)(36756003)(54906003)(2906002)(5660300002)(66946007)(66556008)(66476007)(6916009)(41300700001)(83380400001)(7416002)(316002)(4326008)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlQrbEw3aTVudk5PNjRtUUwvNjU3ckJVV3ZPcHBZaTRrbXBDNDFxZUhMZ2NX?=
 =?utf-8?B?b0RicmNBdjFNS01wc3R2NldlRUlUZVJCc0lzcWI1dzVlcWQ3NmJ4N0pybHFy?=
 =?utf-8?B?V0dCT1Z0Q1FXNXJTZGdzMEVyS2JLYUlvWTg2QU9IRW42Zkp1Vkl1Ny9jNVBn?=
 =?utf-8?B?ekZQMURudFBReGlGU3ZENjRjVHVESC94VEFMSCtzMzlsMHNDMTVjcytIS3Fp?=
 =?utf-8?B?N3FlUVlCL21GMlV5TUU3UmI4YUhqL0Mvd09hWE5xdm52M2swTEk3MUVLVVBM?=
 =?utf-8?B?M1VKV0ZNYi9pZmlQcmVHRDBIMVZqL2dWWjRkWnhZd21mcEtXeXpNR0Q4Z0Q1?=
 =?utf-8?B?b1V2YWE1emU4RENydi9jWEpONUZma0U1SzBYL1UvREJYRWtMMFFLcitlbE1Y?=
 =?utf-8?B?S3FubE1kMTNyRHp1bU1PYVErTmhiU0ZOaTYxSXR3bGRWUTdpa2RkRmxNNmN2?=
 =?utf-8?B?d3ZrRDdOZ0FudTFwdFQvV0JBdGpXTTY3WEo1b21UMWVyYk9hY2FKSG1oL3JW?=
 =?utf-8?B?c21sS3JQU3RZaUFLVzd4bENGcnBySWRSRW9JcXFSSG5BRFZQZDBxQTJ0ejM1?=
 =?utf-8?B?L24ydVhubHhMdGI1YlVTOWhOL2V6cEcvbFRhMlhNRVRFbDNMcEUwa2pjaXo1?=
 =?utf-8?B?UjNWRDY1WHVsSjdNUHhVTkN0S2YzVUFzeEVXSXlUcStTM29uSTJXK1h2bmdp?=
 =?utf-8?B?YkdPUTZhZWJhYjNUcys3Wjl4ZWRNZ0pMZTRJNU5jQUY1UkRQN2JnU3RBbHl5?=
 =?utf-8?B?K2EveEpaamN5bFF3a1htbGZPWkd5NWkxd2tlWWJab1UzMWlyblZpU0QzOHp2?=
 =?utf-8?B?NGNIZmd4NXJURW8yREFOeTk0MTFTOFlrUTZLMTUxMVZuS3hpUS9UT2VXMnJ0?=
 =?utf-8?B?cU1SS0xsd3lEMVZIdFRMazhXby9mcEpwYUhUZThSZjBBTVk3ZFlGTURxR3BM?=
 =?utf-8?B?MUN6K3ZMOEhEejh4ZEJuSjdpYVJ0SUgvQlFjbWJ1b0NtSkk3RndCQWxNajZN?=
 =?utf-8?B?UHZMY1NZeWRua0lEeFNTdytGZ3lQVlNpeUxWUWkrLzRhbGE1dzVHYUhabnhM?=
 =?utf-8?B?aFRyTlhNOEt6dEZrb2NReGdFelVHbVhITU5MTkJJajBhUU5WNGhwekVvSmQr?=
 =?utf-8?B?b21BY3BhSFh0YURnMGkxMXdpcmhZLzRvcDJUeWJWU1RYdUR2eDlWZUVBbFhD?=
 =?utf-8?B?K0U2SHVjNmtXOUNhZ3RwNG9RS2cwc0JwMENHZDhBSXZ3bkhVQUFNTXdvUXhz?=
 =?utf-8?B?Si9tUVVSNitrVThmR2FXeUE1Mi9zTFRLUGZDM3RDWWFTd3JGaXdEUFN1emo1?=
 =?utf-8?B?NFg2d3FnUTlDOHNrak9yOEJuL3FvbjZYRmtzZXN1Y0VBdFJ4NmczSTk3VkJM?=
 =?utf-8?B?Y0oxVnZDRmptOWRrMjFrbDZpQnJXemlLc283d0tBN3M3ZEl6Ykh4VmdYRmZw?=
 =?utf-8?B?Z0V3ai9yWUQ4VGNyNStDVEVVOFF2aVZvMWlYb0dsZFBoQmlGbGdkanB2Q1Jz?=
 =?utf-8?B?T2VaU1VEREtXNlhEemovOURTUlRwUlFIT0p1ZzJEdEowVmduYUUrUi91NThv?=
 =?utf-8?B?dW9DMFFFZ0lQNkRKOU54aElzL2szSEVTZ0RQRFRXMFI5NHpVYVdDMXQzb3N0?=
 =?utf-8?B?Q1lGem9UUnpPamdhRnpvRngzMkhTNERNa1dLd0U2VTBQckpHWTlRNXcrWGVj?=
 =?utf-8?B?ZEZtdEhGZEFTVGVXWi9ObmpGZ2dIemF5N0JDWVVSdWFSOGVSWVBEL3d3dWtT?=
 =?utf-8?B?K3MwNWFqRm9NZnQwM0lkQVQ0UGFIMzhpZFpqeU0vZ1N3S01YZ2txRnBEUUxa?=
 =?utf-8?B?VkxncW5pTTRmZW43NzdPZTR6NVF3UTRXbmpUcnl2cU9abFNyQmd5VDlZN3ZC?=
 =?utf-8?B?ZWsyY1U5YWYzelBjWE5UaVBBMURZb2JIbEFKSllEVHFUYVE2bGtSYmNISlZJ?=
 =?utf-8?B?UEZDdWNRWXhhYVgwMStjMGQzK1V5bzQvRWZ2VVNMQ1k5ZTVmZmhGRGdBY0la?=
 =?utf-8?B?TTJxNEVJNHNBYms5emhjaExsV0g3ZEZpdGd4K3VWNUlxS2xibXU4MzByZXZT?=
 =?utf-8?B?K2lrdTNid0ZzK1ROc3BxNUowUnVaeE11MzVvVTZXUi9kRFdUcDNPbTFVWXBK?=
 =?utf-8?B?UkVRbFduNzlLRHV1RHcybFRQdkRobU8ya0hHK2pZQnREa2xEeTR0aHdNQXpk?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efc8827-5c6e-4964-2ca0-08dbfa880198
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 20:30:25.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+RZiC5esrU0nUb/uZwWQkzv4sPzh5ejjhyGIpE8jB8XPHHV74SQtieOZfa/krLhBLl5bcqz+l5hvVbTf0G+bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227

On 12/11/23 12:21, Mark Brown wrote:
> On Mon, Dec 11, 2023 at 10:46:23AM -0800, John Hubbard wrote:
> 
>> Or (4) Hack in little ifdef snippets, into the selftests, like we used
>> to do. Peter Zijlstra seems to be asking for this, if I understand his
>> (much) earlier comments about this.
> 
> I can't help but think that if we're having to manually copy bits of
> the uapi headers (which are already separated out in the source) into
> another part of the same source tree in order to use them then there's
> room for improvement somewhere.  TBH it also doesn't seem great to add

Yes, it feels that way to me, too.

> additional variables that depend on the user's build environment, we
> already have enough build issues.  It ought to be mostly tedious rather
> than hard but it's still a pain, especially given the issues we have
> getting kselftest fixes merged promptly.

What about David's option (3):

(3) Regularly archive the required headers in the selftest directory
     like external projects like QEMU do.

, combined with something in the build system to connect it up for
building the selftests?

Or maybe there is an innovative way to do all of this, that we have
yet to think of.


thanks,
-- 
John Hubbard
NVIDIA


