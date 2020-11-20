Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1B2BA712
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 11:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKTKIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 05:08:43 -0500
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:30844
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbgKTKIn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:08:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl9oWV23YZzq0nScfyr+YK6HRzrVONwocw9IMVYukN3eDaYeAkNVOffztgJxP3SvGEWUoPogp5P4+Gf3XNfFj9RQT5ql1saUum/YYKI7Qvaea95lEViGKSPqvzc2mTgoUcIPsouEmP1Sz8a96Sdml+OTVrMzgPCjaR33ZpyUWM80RX2UeP/dHMkCEOBVV2h8I/q/rHD22Z49OcHFoiPfXZ7UPkjs9zNj8GmFmQfuKXGt0hXTVjQbntRRWr6/30wkJtCv6/4zvpzVGb7qclV5KZjhfx+3yaUpZ03F0YOs+61RtqcUWVI3mznY9JQ+mMSe84s9EzVaECrPIGOEwhvy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC8laELQqjClPE6UmIObdWjdsjVvLQDxQ//rZ3Ylwo8=;
 b=mPCLMqq4JUyzkRwrwljmxst0pTrXwPOTo4rP9+tuUad2n3zkyfDu58ixp5LnHCekd31IZmIdNi8kbL+7ivj4CNXkGQs5b0OWbR/7rN3eayab3dHa7u/oQUjv5dNd9x/H8WDXH9Ohral7AHX9D/NY06Hf0G33yWuGUQhY60HSl33cjF/0xcVg7IavO6rsKKBllQ74XKTshqwco2KSy/iBVj+8rt+LrPevf4W0JyvRjDC9Jb1fhp31ll51rvVQZJvSB+6GBDTNbJpG595hVoqvKjYQMkUYYX6fLabqOPZFtOf+sqyruvviS5fDyo9tuP/7f8CnsfPLJ3X8dcsRkcyIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC8laELQqjClPE6UmIObdWjdsjVvLQDxQ//rZ3Ylwo8=;
 b=HS6y8KdHRJTP0DY3nYHDicoMWD6QK2bw92Q2KXGdyvutuL5Y+s8WWj/yyv2rWeXxgtyCsE0W7GWSMXXDFtFPa36kAJlWt9U9wbZYFhheaC0zBQvaU8XPW2smzUfWRbSpphv4vxjmDIOaUBPRWT13K3B5NSA1nqN55ivoEc8NRq8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 10:08:39 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 10:08:39 +0000
Subject: Re: [PATCH] drm/ttm: don't set page->mapping
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Huang Rui <ray.huang@amd.com>
References: <20201120095445.1195585-1-daniel.vetter@ffwll.ch>
 <20201120095445.1195585-5-daniel.vetter@ffwll.ch>
 <26a62dfb-02e4-1707-c833-a3c8d5cbe828@amd.com>
 <CAKMK7uHnYGiBsBLeyGA8sZXmAiaHaym9jnLKN_xY4VAtKJjG5A@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0b853a0e-b737-e02c-b885-0b0249449cb3@amd.com>
Date:   Fri, 20 Nov 2020 11:08:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAKMK7uHnYGiBsBLeyGA8sZXmAiaHaym9jnLKN_xY4VAtKJjG5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.11 via Frontend Transport; Fri, 20 Nov 2020 10:08:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eab2e8ee-c70c-476c-6175-08d88d3c4039
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4110A8C4C6281630D371132C83FF0@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8Th2MXkgVGZFs3rwha9R6nGyglcS58UgmLJl5Koq7EjMny7aLAJF8+g6y/kAa/JFmRWywtHtX7eo5/oqMC73k84AYSCEFNT/7bNhJuK88CPQgGnZ6NAI4etwgXEnwdxOqVLwEk7RrRsck5CnsRJXTOjtcwM5K+b6py/vSkZPCSrqWYlheyKscrKI5Nzujn9Zd30BaggWskQne6rrAyZ8bZ36TEd/J3xnJWnifT2UH1eawUvg94PsEkn1t9kp2TNbBPzxfvCxKvS8GHpGxq6YSmGeExoZ56SmxrYPpFUYt/kCHnz5Wx+2JoTEf+r0VgbSeKCCgQqSlAPwAgt2QI7at0rx/utrLDzuGHjZVblOOGLPs6eFPAzJpAVIksxR08v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(6666004)(2906002)(83380400001)(66574015)(86362001)(31686004)(36756003)(54906003)(2616005)(7416002)(52116002)(4326008)(316002)(31696002)(186003)(16526019)(53546011)(478600001)(8936002)(5660300002)(6916009)(8676002)(66946007)(66476007)(66556008)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aS9TY2ZNYjltK0plUmVvWlFiS0hNSWpRdUgvVFdaR2E3dFYxVEhEbHJ1V2Va?=
 =?utf-8?B?cXJ5N2puM2Y1Q0RmaURaV1grNHJpSG16aWY0V05EQjZlQUVDcy9LT3RkWUNz?=
 =?utf-8?B?eCswemJ0aG9LTEVSUmFCM2l3TFBLTEZqa2U5NlBSc1lrZGlUZnpJNEFldFcw?=
 =?utf-8?B?RzBSNkpVQktqR0h4cUQzaHNVek5lQUs3TUo3Mk0xWUpMM2Z0UjZieHhoMEhJ?=
 =?utf-8?B?NFdnS0RzK2s3OVd2a0c1c2xLSks1a2VDQStlNHN4VHcxaWhiS0EvcDVRVUdl?=
 =?utf-8?B?b1kvNmNjUlF1Z09pa0VqZGk3WEQ1bTZpV3ZHa3NmSklGWHYzTE1HL09tQnpx?=
 =?utf-8?B?STVsZjNSbnBBU3A0dVNLSyt5ZTV3bWFxVisyYTIzNGRIeWJjTjIvMC9Ca3FZ?=
 =?utf-8?B?N1BWYnU5MEhwSEdCSlJ0a2VIQXd2akxpcnlsYzBwY0lOV2ozNnZ2bGtCRkho?=
 =?utf-8?B?b3ZhcWc4N05hVkNhWGtpVng0YUtPZWxkdFN6ZXdjVjhnZ1RXSnEraGc0dG5a?=
 =?utf-8?B?Wmo3cHlqenptYXhCZmNWd2JsMzJTbnhhcWFHNkxkNFZ2WjVYU29Qc2dpeXFL?=
 =?utf-8?B?eUZBTnBjY3J0ZHVDeHhRVVlSczYvQXU2VnRDbGdNWUJRSFpOTjhzYUdqa2Fh?=
 =?utf-8?B?b2o1TUZPZ1owdFEwTVlOVjFtbHU3MnBWN2FIYm1ZS3VrQUNUcTlMZ1hwNVdN?=
 =?utf-8?B?MjgvWFZoemdHbkk5VjROREZRZk1WZTNjVUdUMG9MRHdialBBUTFZV1R5Ump3?=
 =?utf-8?B?RnFuaDFad21JMWhKLzhmVjRVN1FaUmQyaXFKQ1BMSEdIRjlDR1kwTVNrUUcv?=
 =?utf-8?B?SVhnMVYzeVZpNm04VGhGSTFyRFpiMEoxYnpEN0VLSi9ncVZydWIxU0NyVHh2?=
 =?utf-8?B?bVFXekRhWTc5NTFuNTA0dHZNeDFNSDN2SlBjdGZrdjBQWE9wYWRQcDVDMjJ2?=
 =?utf-8?B?RWdUMTN2bm96SEkxVXNYSFVFMjRjQXRrajdqbTBQaWZQUVNKMThWM0k2SllM?=
 =?utf-8?B?SU8zNnQ0d3JaQ1QzQVRINU8xblB2NHVWQVIxS3hnclp6N3IxUmgrZjZodmRo?=
 =?utf-8?B?eHdFalhhQVhzUVlTbngwbDJwWGc2c3E4SWhCaVhDbVMxekhQdTFiQ2R2V0Ex?=
 =?utf-8?B?ajNGY3BVZzcvejdhMkNiRE5TSEgxU1hGQ1pUSkpaNHJSaVVNcDFCR3RuRmla?=
 =?utf-8?B?a1kzZDB4ZURseGdpZzV4aUQ0NUpFeGRxMFJsTXI3Y2ZCaU01REI4L29oVU5N?=
 =?utf-8?B?anY2QUlXbFdCSXRzK0NmK0sxbzVoZUprRTJteURkZTBhYUNmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab2e8ee-c70c-476c-6175-08d88d3c4039
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 10:08:38.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5H4BoTYl1PvSvuvMzCEoal0X2VFbE87l0aP1PloQOhF5fAUNcgN+/z3tcbu6khb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 20.11.20 um 11:05 schrieb Daniel Vetter:
> On Fri, Nov 20, 2020 at 11:04 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 20.11.20 um 10:54 schrieb Daniel Vetter:
>>> Random observation while trying to review Christian's patch series to
>>> stop looking at struct page for dma-buf imports.
>>>
>>> This was originally added in
>>>
>>> commit 58aa6622d32af7d2c08d45085f44c54554a16ed7
>>> Author: Thomas Hellstrom <thellstrom@vmware.com>
>>> Date:   Fri Jan 3 11:47:23 2014 +0100
>>>
>>>       drm/ttm: Correctly set page mapping and -index members
>>>
>>>       Needed for some vm operations; most notably unmap_mapping_range() with
>>>       even_cows = 0.
>>>
>>>       Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>>>       Reviewed-by: Brian Paul <brianp@vmware.com>
>>>
>>> but we do not have a single caller of unmap_mapping_range with
>>> even_cows == 0. And all the gem drivers don't do this, so another
>>> small thing we could standardize between drm and ttm drivers.
>>>
>>> Plus I don't really see a need for unamp_mapping_range where we don't
>>> want to indiscriminately shoot down all ptes.
>>>
>>> Cc: Thomas Hellstrom <thellstrom@vmware.com>
>>> Cc: Brian Paul <brianp@vmware.com>
>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Cc: Huang Rui <ray.huang@amd.com>
>> This is still a NAK as long as we can't come up with a better way to
>> track TTMs page allocations.
>>
>> Additional to that page_mapping() is used quite extensively in the mm
>> code and I'm not sure if that isn't needed for other stuff as well.
> Apologies, I'm honestly not quite sure how this lone patch here ended
> up in this submission. I didn't want to send it out.

No problem.

But looking a bit deeper into the mm code that other drm drivers don't 
set this correctly and still use unmap_mapping_range() sounds like quite 
a bug to me.

Going to track down what exactly that is used for.

Christian.

> -Daniel
>
>> Regards,
>> Christian.
>>
>>> ---
>>>    drivers/gpu/drm/ttm/ttm_tt.c | 12 ------------
>>>    1 file changed, 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
>>> index da9eeffe0c6d..5b2eb6d58bb7 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_tt.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
>>> @@ -284,17 +284,6 @@ int ttm_tt_swapout(struct ttm_bo_device *bdev, struct ttm_tt *ttm)
>>>        return ret;
>>>    }
>>>
>>> -static void ttm_tt_add_mapping(struct ttm_bo_device *bdev, struct ttm_tt *ttm)
>>> -{
>>> -     pgoff_t i;
>>> -
>>> -     if (ttm->page_flags & TTM_PAGE_FLAG_SG)
>>> -             return;
>>> -
>>> -     for (i = 0; i < ttm->num_pages; ++i)
>>> -             ttm->pages[i]->mapping = bdev->dev_mapping;
>>> -}
>>> -
>>>    int ttm_tt_populate(struct ttm_bo_device *bdev,
>>>                    struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
>>>    {
>>> @@ -313,7 +302,6 @@ int ttm_tt_populate(struct ttm_bo_device *bdev,
>>>        if (ret)
>>>                return ret;
>>>
>>> -     ttm_tt_add_mapping(bdev, ttm);
>>>        ttm->page_flags |= TTM_PAGE_FLAG_PRIV_POPULATED;
>>>        if (unlikely(ttm->page_flags & TTM_PAGE_FLAG_SWAPPED)) {
>>>                ret = ttm_tt_swapin(ttm);
>

