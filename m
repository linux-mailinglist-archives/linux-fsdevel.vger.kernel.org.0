Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA25405D41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 21:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbhIITSO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 15:18:14 -0400
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:37473
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244705AbhIITSN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:18:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4nYj/7aTXuHixjt7Di4nrYmtr38gjYWIhBZcFXtqs2RsoImZgZF6YRq7oyUUEz2I8tFUv5fqOz7rrWFtRqrK5K7r6UPthfO9fEktq00pttjAEXBcy8GtHXz58qVQTPwuKd6nTOVCwfrtffnP8tLRDBTOGwCtaN3/10XDLgqmDesIWoZ/rc7Pd9eIuvIRP+a6mMBY48cbbt9xqR9JkjGPBENv6lbFRqHaE0fFBFb4Fj/Pl0Y06meUgxyORzbi58HdLTUqCt1I84Mt+jnOqLIXgyo6XDvr3pQ++Otw/ds7ajU9b2uTkgcUYQOsiBcylSxhq5IC+VZA2+ayl4uhhyiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TbCch8g7QSpnxDEW2O2Uv4KnCVyYe4gOJNFZsOnhyA8=;
 b=cfsnDMa/eTbIT6NCZFrELlYeQdrm4VK/q+q+NHU1LBTDXQx38cS5gI+6yronUlFD5Tj3qNiIYwfIQ9dwcG9OXsgrP6dJOKtBECtI8goXD2P7kBW7scwAUxOlDa4/I+NpNmM5UyxnbwwNHhFR4Fcn5/dA/aTiAQBmZUXf22pflgz8fwkA7ONKTE3NKnOK25zV8YIxmyLzWfwdZQNY5F8fjT+LCp0am9IGaVVEzh0NxLrzpeo28YuFiOQ/6Eh6nZoQ8KHdQs+SJPNw640rxxj+r+6079SQv5/iE+SSrpNP2B+8s784aTlejB9n0tvCpZVoYDM8vZAFzw01o3y3mP7VAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbCch8g7QSpnxDEW2O2Uv4KnCVyYe4gOJNFZsOnhyA8=;
 b=tacLhvYyikFX+EzV7hN93Zz42LFCAkl1XsN4lV7K/CtDpEdMtYOsq2xpc7hLGOQ8Qlq5MPItbdFEFxf/WvXh1yXYhd+B8GBqB5V0pWrIf2BFE3gub00ECPSXBK8Hze0SRDxdm2ebsgUSrpTXCGrtXWLKnXLw4jIKOEpet/upZckL/7ws4gNYZNWnPJHBgxYJ5Byi/2l2OZGPnSTIfOiZAg83tRi2VLCh/tA9tiXOhj9Q7FIvwk33toAVy2jinZag1rh3st7elvESbPg7InYmk20m8/DxrEXlaavzyCDUPumLGF9MA/QUBD/TKAL9ScTbwtPl0aNPdRAe+xr78TmGRg==
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3334.namprd12.prod.outlook.com (2603:10b6:a03:df::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Thu, 9 Sep
 2021 19:17:01 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%9]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 19:17:01 +0000
Message-ID: <969bf3e2-89be-c25b-938e-38430dc836d3@nvidia.com>
Date:   Thu, 9 Sep 2021 12:17:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [GIT PULL] Memory folios for v5.15
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YToBjZPEVN9Jmp38@infradead.org>
 <6b01d707-3ead-015b-eb36-7e3870248a22@suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <6b01d707-3ead-015b-eb36-7e3870248a22@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.91.202] (216.228.112.21) by BY3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:39a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 19:17:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf63bd7e-f07b-455e-dc51-08d973c666d0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3334:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33344F83FDDB2E2770AB1266A8D59@BYAPR12MB3334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5LdIsfhvzLLPtEoyeVe4uftOswBlOrcD6XlK4ZRI3RdHiXx1XlmJ3Ybam+hIteBaM8od9q0NhZ4Fh4LcxjM/RNSAYTpVYoWQqwAxNV0isw9RVV5OY1Bz2V/iQfv9tyC73dyr1M7q1pnTzW/doHM023F0GZkqOORuINc98vADDjBNoAjlAM8oEKkJUvmhQB8A3gJYBPY/i9lJ7Ttkbta7dE45zQjn9s8uc6H46QPQzZbdxu5rT9Uox2ampYJT8IXdHHWeK+xNSxtk+rkBCm79qQhP8ObdqGQ2Yom9Tn3i0V2kdfS8ZUcX38EWZtNqc/QVGEMZGspipQsa8hQFnnpU1TceMb2cpwi4ZVBP2YTJhCB05MGMbHxUdWk8/3OW+wngFe206Wk0CrZ9sUxX1s/p+C1D9DLeADdg9b7iwvgRnZN+I6kPGS7lU3Br8T5zvG+gOMLrptPoVrgjUFmrXSApdzQg/l2mufXDffObmK7efMdMUCLD7BDw33Lilh2eH+6o9st6K2F3Cgm72/Fs03gKlxre6OEcxfaLG0nATsTYIj3iy8vw12ekdlLSdnKNhIDrwjuk5DcZ+wi3GhJnNFuMTsoallKmgUahV3GN0Sfada14cK/eSUIRVOMnH3H2c+xk22JiWK+4r9aX+HKKnIptbhzHed/l+IEYns2wdFbiLZ031/RHX2y4hOgQ4cJzXczkqdu5BAPUTNWt0F+OU5DGo1KJb9kVLmRYUc4+//232Budoew6pc4zibtXoPMX6pL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(16576012)(6486002)(316002)(110136005)(4326008)(53546011)(66556008)(86362001)(54906003)(66476007)(31696002)(66946007)(26005)(186003)(83380400001)(8676002)(31686004)(8936002)(38100700002)(2616005)(5660300002)(956004)(508600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVVweDREb1pWaEtCeWpsakM4Ylh1cG15T1JsT1BySC9iWkViUkdOQ1E4NlVi?=
 =?utf-8?B?V0FvNXBmUmh5eWloL0ZGRy8zbnRaMFJ3YmJNaVNsaWU4NG85eGRkSytXV2JT?=
 =?utf-8?B?RFlvdHVKQWpCS3ErMVR5MGpYSFovTVQvMldjTE40OW5obG90cEtJeG02alV1?=
 =?utf-8?B?cHpSSjFHeW5NazZuaWZJU1kxY1lPNklnZUNwUVdoc016TjZBTnV2RG9FSlJP?=
 =?utf-8?B?VmNCTUh3M1lTUUh6a3ViZzZITTNDMU05M09VTjkwdXRZV1VncDRxS1ptQXV5?=
 =?utf-8?B?TEQ3MDlIVUFTeElrRGxDbTNPakViRnN2ZDY2cDJhQlZ3QitMZTB0QnVWYUtG?=
 =?utf-8?B?Qmcwd2pYamhWcjUrREY1TDF0TjFCUGU3cy90WFRBdjMwbzNiTTJ5SFlRaGg4?=
 =?utf-8?B?eS9qL0RFNkVobUhRbUd6U2hxWE12MisyTjYyRFR3MUwxMHRpUlo1Y1lOZVlV?=
 =?utf-8?B?amRJeDE1YWppVW5Xa0h3YlN0MGEwcCtvbzZmVktvd0ErQWc3RVBGbEZvMG9N?=
 =?utf-8?B?aHJiTXNRMzJxKzJ2bE44bVYyVFF4MG10dDU5Vmt1WGtxWEZnT2IvSGM5ZHNS?=
 =?utf-8?B?TXRZVzRSUmh2Q3ArUk5VU3lPTDBsQXRXUTZ2VHk1emNGYWhkTm8yeHFRNHRW?=
 =?utf-8?B?ZmZIZ1loU050aFhYOGxlREdOd0k4d3NlWEFLM2J5RSs2Q0NQclk1N01xMEti?=
 =?utf-8?B?NjFGVFE1VldXNm9zOTd2aUU5ZDJyV3VIOUlwNElGNm5UWTRCTDVpUXRDdTBB?=
 =?utf-8?B?Ulp0RTNicFVPTXh2NVA4YzFrN2lFaW1VdXFHWm52VUhTMlhLeFprblQ3bHV5?=
 =?utf-8?B?TFpXRHc1MXhuTEgzZWdtRzJRaWZUQ3ZKS3Zac3oydi9WemVNMEc0blRzVUds?=
 =?utf-8?B?N1U4ZUMvU3JxNXZlZTVmc010R3VXNmFHN1ZsQnE2Q1FaMDAzTDBxajloS3lB?=
 =?utf-8?B?bm9yZnAvQnRhTDVxYzc3REptanhWYXd4TlRrcWZkdDhwd0dIdmdrdEQvNzMw?=
 =?utf-8?B?TFY0YS9MdllQYzQ5SHVVTEU1VFBTSlNRckNYTWxnamJKQTROTGgxSUdiVmVq?=
 =?utf-8?B?OXErbHNUcnFlcCtLY0Z3Nk83KzlTdW1KRStTWEFha1grS1hYUnZiK0NZdVQx?=
 =?utf-8?B?elpYRHJJRE53SjB1VFREYlMyb2F1M0RxOWpHZ0JNcFdNNDM4QXFDMktCR0ZJ?=
 =?utf-8?B?aklKMUdYQUR1NkNNYjBVNFE4VFFpSW0yY2o1WXQ5QWhzekxkVlc3NnRsdFlu?=
 =?utf-8?B?ZlpPZ3JjZWYxVnJzbU12WDVXcU45NktyRFFvVVF0OERabmJwVkVBcXVSalNk?=
 =?utf-8?B?N1UzMk5OVHNLN1o1TnU1M3lUS1ZnTmtyalFNUkdHUjgvM09sWS9rbHZlR1JM?=
 =?utf-8?B?Z1RhV1RYaGNEVWhaa1JQdEF3RUxwS1hsZlAvc3BWQ1dzMCtKVWFtWmtmaWVV?=
 =?utf-8?B?Sm5OeHZMNVJIYloyMnZyZ284dGFLd2szaUh2ZFlMVDFjWVVkbkNSVEo2SSsz?=
 =?utf-8?B?RTVFRXc4RmlrRmd1dWlXdHorNDQwV0ppQ0taQ1ZJd3loKzdoM3NKWlFVQ0ky?=
 =?utf-8?B?TUFEUFc0S3ZzbXFkTWVsSUhwVG1xQi9WbDRvenV2bnJKS2NZcGNWMjlHclVU?=
 =?utf-8?B?RnFkR1NuUG84czlzNW03dlVNdFY1UVFvcEhSMEtxYmUxY3ZJUW55aGFCa2xD?=
 =?utf-8?B?K0EyVzFqaVQ0UHJ2Z24wUUlvWTdCVWFyV0JCRkN5bjFHTHd1YllaNmR2R1Nz?=
 =?utf-8?Q?rOQJYnc2mRD+kgEmeYXHqdjR9HCIa1iWB0XEecv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf63bd7e-f07b-455e-dc51-08d973c666d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 19:17:01.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkGfU/9a5lu+He+nY4MCiJaaMoZMOfKKqJefYrwhahfldbqu6Jrqw0ayAmqRzpRILn6yQgH/S6+mJXzgONhZAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3334
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 06:56, Vlastimil Babka wrote:
> On 9/9/21 14:43, Christoph Hellwig wrote:
>> So what is the result here?  Not having folios (with that or another
>> name) is really going to set back making progress on sane support for
>> huge pages.  Both in the pagecache but also for other places like direct
>> I/O.
> 
> Yeah, the silence doesn't seem actionable. If naming is the issue, I believe
> Matthew had also a branch where it was renamed to pageset. If it's the
> unclear future evolution wrt supporting subpages of large pages, should we
> just do nothing until somebody turns that hypothetical future into code and
> we see whether it works or not?
> 

When I saw Matthew's proposal to rename folio --> pageset, my reaction was,
"OK, this is a huge win!". Because:

* The new name addressed Linus' concerns about naming, which unblocks it
   there, and

* The new name seems to meet all of the criteria of the "folio" name,
   including even grep-ability, after a couple of tiny page_set and pageset
   cases are renamed--AND it also meets Linus' criteria for self-describing
   names.

So I didn't want to add noise to that thread, but now that there is still
some doubt about this, I'll pop up and suggest: do the huge
's/folio/pageset/g', and of course the associated renaming of the conflicting
existing pageset and page_set cases, and then maybe it goes in.


thanks,
-- 
John Hubbard
NVIDIA
