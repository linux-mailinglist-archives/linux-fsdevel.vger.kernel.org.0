Return-Path: <linux-fsdevel+bounces-5808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787038109AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 06:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DC41C20AE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 05:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B7D29C;
	Wed, 13 Dec 2023 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bDE61xb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A482FDC;
	Tue, 12 Dec 2023 21:55:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXg3qK6qMk1F84N4d9mvuQP/iV2/kJ6wqgGE2t1Kp2kwb9KSKCKaRmW8F0JxqPBXjtyS4byuSxGTHVkZp77tTcsAzwnRexfmGIwg4zXD7zbt1MsSrZXL1lqnfixaohGUjXDJs1NULX+07Rj+ka+jEZfzlHD9Uwa9p2piTGDYNEWOt/y8ssVW4MSONyTsy+nOQfV12e6Z/iQX3lvzOGqRY4AR0ubPWK4pqmzaca5BGC2ydbHIu8TyuE/49DCP8EepfzxAcRIikgMTNaHNkkkGPtPevBvyePqvSjZQLuyg5BW1bR2HywJLj0gNzHjYiPaD0biuRIvYc/NJunec/pPOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3YqCGNujtJrGDcaR1VTe9VtdX2UnVi/TUXSQTHw2GQ=;
 b=gkkOVQa9WrZkAQ735XA6VtnXYJcDPactALer0CHSNBV19QIsSuhLyta74qoZRXqvz6+UjcniYWFrI0fFPB4XzmM1RVPOgaa6ySaKLmOL7zj7UWtI4IO8GWdABKIBdYlxl47YUWIJLyEQXTZGdYkVIkDSVRo1MlNF16G/iiNivHxYoFIL8xVB1iDOfeRN2gplDfqp/F3lgG5VikY2orCKva+NgIYOPG8oJwtRkCTuMFzzlFerFK4mEVvywCR5rUVI/qajEul0t72/XVCkF+O2IJ+f4EJnzX0+p0evQdNpGMPdG9v63CMLcpxe1+B0axOiGyiGTxRAxJXnW4haQP5t4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3YqCGNujtJrGDcaR1VTe9VtdX2UnVi/TUXSQTHw2GQ=;
 b=bDE61xb39UbR5rXeZj5hQFwTM11uAAFoFg3vabqFkCI6bcVRHJZnE0GjFEAJEu4zrGd5Hp5W0eDqYI1AMtmN3254r0HF6yF82TnKB5C9q89ZLchOlyRoavhCN0b3+jSQwFPihVHBOtO55tEarCeEOnkHtE7aqz6tgljWLgRIKwTwBJsy3kBEJmHp2wDbaOU7HSxAALoIKwKjnsFHEuL1Vm0f3PEw9IzXbbB5RqGjzhc79NlpM9pcDG8TNWCZVfQy+UZ0EDoijkkj1it9+frrCAQ5liRZzbq2Ffo9YrkG8w6FpJvcG1RXd9KBHSiyq4N7shH5vO/7yiNGz720Pg2zwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 05:55:41 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 05:55:41 +0000
Message-ID: <926b42f9-3689-480f-8dd5-78fc0ee6088d@nvidia.com>
Date: Tue, 12 Dec 2023 21:55:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
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
 <0d68fe7f-2a96-467d-87b0-52db36704e1d@nvidia.com>
In-Reply-To: <0d68fe7f-2a96-467d-87b0-52db36704e1d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH2PR12MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c42cf1-3bf5-457d-4d31-08dbfba0236c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Alaug7SUHcEKj7PuQqsDBo3eJswc8i7mmkaFzMfvCQkXNXjQ3zfpQQbwaCN/tOCCZ04ceTtMrQR40lEhbsd9CtXAbiiLnsbXqI+MGyX5lPFRfNewKm5JmdszcFdAW3xmq7OJQ2cf7CBH6rH40gWTyHrRY0iN9MYjm/JvlQkTe5qVNZ5B22BHpXWgLovPCwy5/JYdYzgitFj3/BZOwfcTZIuA8UAO5x3ZxFajHxR0gkpK/fvk3YYtjL2xRPLkErliQUce6teduioJyMc6k9mmaf8wBlIyvzqbKO7Ou9xsai+gHUPoOxwpq8ycQG16G7DDTJM/SfTDpNZW2P4PXjDEzvUJ/kQeahiCc6udVb/l2dzzgH5Lnrct3EtJL741Fd5Rhpm+6vjVhNEw8oYMleR5kNenlkka06XpSmAwFUTEuJAg5J7urFsT9Zfvd9sRyhh9MiLAKTmtxx5JhqawD7aw/ArzYHslf0f7vblk67SeaOzwMw0QiAig5BqMFLRKjW9yqFKK8qQsuKXiVyt008hTZQL9fUU6qCpiFpLEhqHN6ylcswqDsxWK6k2Uuc1Oe+Lnlg0MssudjwF7WPWYPC81+HzT27D35ZQpZqmeYbJDHZBZHdD4V3CgTN0UCFs8pqnUt6dtzUQKJa6SxG3QY1lKsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(66476007)(66556008)(54906003)(86362001)(36756003)(66946007)(6506007)(31696002)(2616005)(6512007)(53546011)(8676002)(2906002)(38100700002)(110136005)(6666004)(316002)(6486002)(478600001)(5660300002)(41300700001)(8936002)(7416002)(7406005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1JrWUkybzltR1lsTnJSSVFFT2paK3kwNjA4di9ZUWtraGJQV3VMQjRKQm5y?=
 =?utf-8?B?bnFjc3N2bENka0RFL0RCNXgrOFFRSGllMm04VVkxMUJadXFwbXNlZ0NST0c0?=
 =?utf-8?B?K3QwVzE4dS83N0c1WklrWEl3bU1oUHRRWnFPNE9nRlJLNUR4eHhZOVBONm0y?=
 =?utf-8?B?bE1JTWVFVUM4d0pDVm8xVzZ4V24xWWlaeGdLMW5OTEE2aEw3T2ZpL2pMOUxx?=
 =?utf-8?B?djZ0cXpQZHNIbmJUK01wZm9LMkgxMFlYV2thQVZ6R202SVZHaGZ6OThOVHVy?=
 =?utf-8?B?VjhlVzMxZ0t3enFzbklDNnExNzRzdGtoZHp0WHZ5dGJWNGROTnlZZE1vSGFv?=
 =?utf-8?B?YXBHS00rMDdhckJwNWlvNkpwYzd2cjg1RlNSSm9XM0M4Zmh3ekNLTU9xTUFu?=
 =?utf-8?B?UlpVem1mbUNsa2tPcHVtMjBkNlpORTIxQUxLOFNsR3VQS3pXcnY3U2psL2R5?=
 =?utf-8?B?WS8xVUQ0cTAwRFNWN1hRNFBIOXdLbGpEZnVvN0IvcHNndDE0dCsrdXE3a3Ex?=
 =?utf-8?B?aHFVaVd4YStpL3hSaHQ2R2Jnc2ZwOGdHNEJaTEY4VkhjR2hMemVlajNtdzJQ?=
 =?utf-8?B?K3A4MG1lS0ZKcktEZlNlMkl4WWVaalNhTHlrZFhEc1ZYdUNsZGI5dGdvcVRW?=
 =?utf-8?B?SFdVa3k3bFhlalBndmpKRFBTVGdJd0ltNytoYTAzZ1hSbFY3QjV2NUV3aFdU?=
 =?utf-8?B?UUV0UlVlVXJ2YVpuRHJpRVVpaENFSHBvYVg0RUl1UUFXVnFKQkxGT1N0Ritm?=
 =?utf-8?B?UG00QnhFcFV2cDBkbW1XcmFnakMva1NPTTVMaWRCV3BMc08zRlhGZmhUOURT?=
 =?utf-8?B?WmFjQjNBcCtEMWdMbk13aE9sbnBCY21FbzVqejJGK1NmZHprWFdKQ3Q3dlRl?=
 =?utf-8?B?am5zVUsreVIzbGxZWHAyZG9LRW42c1ppa01QVlRSKzN6QzNLWEhCVndZL3k5?=
 =?utf-8?B?bmF2VUtUUW1LYnptUUVxZVNvckVkNVhzVDdFRDlKbi9yd3hLVlhmbnJDaXpH?=
 =?utf-8?B?ZjZNREtjbE94UWwvQllIZlVqK1pkNjhnNGJtT0pKT1RlbThoME5YekRpOFFs?=
 =?utf-8?B?R1pEeXRWd1hFQjA5QWU0bDBST2tQRUw2Q3NJS3BKZkdOcnAvckV1dmZoa1NT?=
 =?utf-8?B?d0p1UWdUclkrSk56SUdCY2ZONm5rNG1VUGg1MFF0K3p2VmtNTjA1Tlo4RktB?=
 =?utf-8?B?a2JQdUoxWHdTcExZWDRKcXdKUkhJTHo4REVnRDJBNHZpTW9vMElnK3VFSGYy?=
 =?utf-8?B?RWRmdFNncjlJcVg5cGttdFdScWF2NEt6dm80ZWc3NXF6b3ZYWGZja3Ezc2di?=
 =?utf-8?B?RkFuVHZ2cmU2LzJ4d1NxUmFGK0l1K1M4RnlLOU1leThqWlgzOU45M1JDellY?=
 =?utf-8?B?QWZmTVY2UTlraHdTM2s2Z0g5Q3VncGV3QzNRSUFXeXBwWmU0YUNyZzMxYTlp?=
 =?utf-8?B?aEdWNU5WREZSdW40UGpJNzRuMGh2b2hQTkFPOXBOTTNKK0pKYWNBL1hQT2dz?=
 =?utf-8?B?VnFCNmFQQ2I2L3ZxRkV2a29iL2NuN1dNV1pIQVNLbFdtZzhuMGRzNW1mRnlu?=
 =?utf-8?B?N1F4WE13aDBtQmlZL2Y3K1FTcFBWdlNKS3lVWmNRSzNHc3ZGWWs4emFYbmlP?=
 =?utf-8?B?bktyNUNvaXE5cmthTDUrcFpGdCt3aS9iU1NQd2pmL3FyZXoydHpjWVV6WDY5?=
 =?utf-8?B?QW5CekF3bUZ2ZEppNXgxY1grSUZ4RDh6SlpvUlhLNDVSWG96c0F0azhzaGd5?=
 =?utf-8?B?RUkvbnJOSE5qYTRBekYyMEFHMlp4elg2eW9xM0JpSi85RzN6VXlZS3docmhS?=
 =?utf-8?B?dCt6YkpQcExJQUZLamFjVUhtK25NT0src1pYZTdicEFHQzhIRVpaWENadHFC?=
 =?utf-8?B?TUU4SGFKM1RDY05ES01LcngyVC8zT01uRnk5dTd1cHNIOTN1czVNZXRFdHpX?=
 =?utf-8?B?REFYOUlWdlk1bVZxTnlnNGdMamlybXVKRGRNOXRBN08yc3FnUHNlRXpGNkpa?=
 =?utf-8?B?aHo0c0RDT3NZSDc3RGlWb1FQc2hveVZXSE5PbUxXZ20vQ3FjS2REMGtlSE1T?=
 =?utf-8?B?eCtxMW55ZGVTOWVDQjRPSTBqM0Z3ZGRpeklIWlVUalo0T3ZmcnRHQmhIRmkr?=
 =?utf-8?B?YTFtUEFHZnNCMmVxSDBrY3lpYWkrVytuV1BGdFNTVmI1RFJ6c3JXZ1ZYdnFE?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c42cf1-3bf5-457d-4d31-08dbfba0236c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 05:55:41.1999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjH+6G+ve704jq0ENH7R3L4qIyCitzf/PTH+B5YSbAwfzXv15kgUe00FYALC5ustwhW/RvyeztsW3i8E1wb3DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4858

On 12/12/23 21:52, John Hubbard wrote:
> On 12/12/23 19:58, Muhammad Usama Anjum wrote:
>>> ...
>>> Oh, this sounds like it would work nicely. No more "make headers"
>>> required (hooray!). Instead, the new approach would be "selftests are
>>> allowed to include from tools/include", and then we can just start
>>> copying the files that we need to that location, and gradually fix up
>>> all the selftests.
>> No, this wouldn't work.
>> * The selftests are applications which include default header files. The
>> application don't care from where the header files are picked up at 
>> compile
>> time. We should be able to build the application on normal system with
>> latest headers installed without any changes.
>> * The header files cannot be included directly as they need to be 
>> processed
>> first which is done by `make headers`. Here is a diff between kernel fs.h
>> and processed header file to be used by applications:
> 
> Well, that's not the proposal. The idea is to snapshot various uapi/ 
> headers
> into tools/include, just like what is already being done:
> 
> $ diff ./include/uapi/linux/fs.h ./tools/include/uapi/linux/fs.h
> $

Oh sorry, that's exactly what you were saying you don't want. ahem. :)

Another variation though, would be to run "make headers", and snapshot
some of those files into tools/include.


thanks,
-- 
John Hubbard
NVIDIA


