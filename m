Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC6A4C86AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 09:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiCAIle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 03:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiCAIld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:41:33 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7DC47AF5;
        Tue,  1 Mar 2022 00:40:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxEZnZ7nYj2jJaOAUXYn5ULbEN6IWZgoFATI4HS0FlBh9Gt82epf9rVOCMsPZD0lOeFqrgCGO7+7Zu7WPEh/01n2HAg1KnUqxMhmYjs33zjJWfPDpy5SVjvC15gqasR7qZO2SXpQwKQ80TwTjUtf5qXfOQaDGuKjKahVS2lksEDS0lUdMU7NJJIN5SCHl2Pj9XSRqDUqSoL9mPl4DKOGvjKbLq3uYchbymRDaL9zH/+dt8cQivhObi4g7wXgdokHLmeY2aYbsmHXInLiq8LRsJDnMWkcSEzeBeppiDxIJ6VugqMXxEITOWmfW80caoS/M4OTpIdxWgBKiqDlSiuYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64zghugOA/qYCu8y7Y/yruUlVCZFQKytIJSO4mRmiWw=;
 b=ClLjMx1xJ5nPRUKcT09Q7P06Ew5zI8UqVvEiMuJ61PcYDhns/3Sfd4XiNgoiFu1bOeZEUZgwoNF3+F2fd+l5O4plQVt0RGJxftJZpQWXMzIwXnHZZ4DFAWDHiEfTImSi7lBtvL3MX/QfMxM9PEjL6xSyk64kP+nRdVAi4LeMZ72pX0ZGCV5VGbttxH/Jgx8AT514zXRfZYQzRdRvlQLjn/3FtojtLekgi2IDOf7MEMofSwy4bntwX0HN6IHyw9SztkyM3+D2IdRRdpjAxiokUiDgmjGvdUs/ffO/6sY6YWl5CKa8sdgvwOZS/x1MvFZEy242DOrRQQgGwlDD4guUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64zghugOA/qYCu8y7Y/yruUlVCZFQKytIJSO4mRmiWw=;
 b=dVCYqXfcmKpiEUJNgxFHyuNQ6rnIPevxAGG7pISNF1T1erJ8+5mueE2xmEgWVKNQk5E9OInhynLy9o4E1GRKgXplMX1w0jUL8uBR7vzgHGmqdoghBcySX/PmSPgm7MUHmeTxhxfJ5bDxwaafaCcN0f40jqWGIoOxMSkk5PXc9gPfG5/tFrTfqcwVacTxaOOO+ekisOhoLJ/LWsn1w4dXjrPNDbAMchIuFowE2QlghoZAM7tDXQNMsgyPAAGqgT/6AqdcsxAs2Ux0Y06pQcbmKPH8nEvrBpyVO1/1kOOqjm2nw8ZHA6zPPzqC5syRDHtSSap6l85SCSx9O99yzOt9NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 1 Mar
 2022 08:40:49 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::d998:f58:66df:a70e]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::d998:f58:66df:a70e%4]) with mapi id 15.20.5038.014; Tue, 1 Mar 2022
 08:40:49 +0000
Message-ID: <f531a5be-9698-eb08-f10d-75adc2028483@nvidia.com>
Date:   Tue, 1 Mar 2022 00:40:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 1/7] mm/gup: introduce pin_user_page()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
 <20220225085025.3052894-2-jhubbard@nvidia.com>
 <6ba088ae-4f84-6cd9-cbcc-bbc6b9547f04@redhat.com>
 <36300717-48b2-79ec-a97b-386e36bbd2a6@nvidia.com>
 <d3973adb-9403-5b64-23ec-d6800d67e538@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <d3973adb-9403-5b64-23ec-d6800d67e538@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f19913b-4a5f-4dda-1d38-08d9fb5f2fe6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4315:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4315BA495DC92D834D354A61A8029@DM6PR12MB4315.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcRNOWa62B6JfCiueHL5HQ4KY6kfBzVqecrwBTmvuWivcx43A/PudW71f7pw+lwAMRCTAOWFIqD+ZcX5hjK4iAmJmrcqC3wwJqB83sUqy8Z5ziDRa1PPhoe7VYZY78wBOWyWr+NcwXzegNDxOg6tiReBAPMYYzcIHnxkmtxc/fQ7Mi1KRPfPJaf4Z9cgffd90O7yejeoHQ4rGuHXoOi2fPnBzdfkEcpRtQVq8X1EK2ewSBf/XftGbR+CLixJhOiDHgrKfBu8ziHBrutJ0Yt7gWeW9LxbpDNkTDza2ZBJWXXUGHeTYPe7tSyt5t8Msh24S2SuI+ufTCsZnbHbdEmku9deUUVllxJL2wZe/qo07ybQs6NldArVzSGoW0GKISxli2gcobz+O34k80fN1/eNDHG0JodvuqPhJNnaZjbcq4sOVym0jWX+idNB6gYgExEQ4vAyU9p7ErYqSAdBNnCo3WwDkHOIRjrhvfCwKx+ms3igNu9XV3YgJXhCwGpOTMYMGhZoTOZJT1nFbiqipr0CMEiklrpi9v+eyXCrRfjlQic1KdAoAFVWLYaM+QQukWF/lIL7mO/P5vToK+d3oxO5ybHoXVhC2sG0aUEu7P7eEEaApDSx2lvtnKmPEUSWGCy75qujJKffE8HRTFFQDM0+foY6OMuLOPI92muoGTgNfPPCLTOW5Yk8YKdI6zWAwhk24xe5MF8acKuDORKjfh9cpzxOmhypDzMGFPuthbnAb+Fh5K17cwQ8bCxTRUvjgSCP2hmH4bkak7NUVCiXpWoCTWCUz4LwnWbn+QBmt3cA7n2BSVmjDfVIWwGUpejjp+9AxLAunX+Zoc+IfD2ER5VidjI4Xh9MpYKjbq6Ei1bsqjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(38100700002)(6512007)(6506007)(53546011)(2906002)(83380400001)(2616005)(186003)(26005)(6486002)(966005)(31686004)(36756003)(508600001)(4326008)(110136005)(6636002)(31696002)(316002)(86362001)(8936002)(8676002)(66946007)(66556008)(66476007)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDg2dk0wVGU2eXRVU1cvQmYzOW9YWi9rY05HbGF6bm9tZEJQOGU0eE4rcm5S?=
 =?utf-8?B?alJOblZwQkl6dDQrQ20wVUtMSXp5TXdVc0c3bHN2WXpNV3pudUdmK3dWNWVX?=
 =?utf-8?B?UTFmcnFkcTZZbWxzdlpFRTZnSmw0Y3A4cFJJdzlSVHkyT09EVnJtUGVXd2RD?=
 =?utf-8?B?Rys5c1BmQU9vY2RzZTdwM1o5TjJiVzFwaUp2d1ZZL1VLR1hZdVh3c2hId3do?=
 =?utf-8?B?bUhOMzRNZ2c2NGM2cXNrSzM0ZEZPM1J4cVE4MnB3K1hZa3F4MytkcjR4NXZm?=
 =?utf-8?B?dUJNNmFBS2RCQzdOVi9oSDVJUFY4b203OGZzajc2QUN0cnpmTStpZWRtZCtE?=
 =?utf-8?B?ODA4VjRoZkpCeWt0ZHBCbS8xOU9FVlBIanlqeHpMMS9FN016Ujg4aVFDbkJz?=
 =?utf-8?B?VjlwSTg1R0JwVnIyKy9pQ0FWQkFwTXBFRVp3L0J4NHBhL1k5OUFYbEpLTEtT?=
 =?utf-8?B?OVdDSXgvWnBOODgySk1FRmFzaGhqMlBKZU9JU3pSSzgrR3dmTy9NU05uLzhN?=
 =?utf-8?B?dUtWc1RBWVpINVZEVjdvTWp0ZTM4TVRJekFYRDlYOHhFK1F2U0t6SmVlQndw?=
 =?utf-8?B?L29LcXlmbW5Ia2pMUGxKelVqdzlHNW5QeXZlUHpJMGszenRnNURDQUtMQ0Uy?=
 =?utf-8?B?cjA0OEw3Wkdad013MjFTWHZYZzdLWXpyTXhBUFA2L1FMdlBCeUpBU1JFR1o4?=
 =?utf-8?B?K0V4NVFJTWdzQjlxU3RqQW1KWlBZcjc2NExLcnZGQVVmQnZMV0dLV2t1c0Ra?=
 =?utf-8?B?aHhmeFNhckdKODFieVA3SDZWdzRBN2V3Y3JCazFOR0E1ckN0Nit5VmNxb3RZ?=
 =?utf-8?B?ZnpRMGswbzBvMlVJT1M4QnpwcTJaeVJXVzNJNExTNEFYM2dJemgzU3lMcm5S?=
 =?utf-8?B?UzR3WnpmK05vZ013Q1I3bjY1SWtpeXdFWXpEcnN1OFllcEYrc2VMck1qQkNw?=
 =?utf-8?B?a2VpYlczM05ubFFhQi9uaDN0WjZhalpTUkpFNTZFTjNqaXlKUmkreDdKQTRq?=
 =?utf-8?B?WGR2Qm5ERE1pZHpPcjJzVTQxblVJVkdtK1p0d1JHMnE1MEJaVDVMdGl4ZE5N?=
 =?utf-8?B?WmJ0WjNXbS9WdEl1b0dINXZVZUE2NURPcGttTnRLRG9IQ0NQSmRLSnRaQ09o?=
 =?utf-8?B?ditHUUtMR2kyK004YmJNUWVhbUFzY0pITlUrZE1nMmErTHEzN29VZE5oR1lW?=
 =?utf-8?B?TE9XeGs4QnFETnE2V2ZMeUVGRzB2UW1IU3NqaUJkaHQ5em9GS0poN01wM0Y4?=
 =?utf-8?B?WDZkUHA5eVYrKytHQkdQYlUyVHc1SEVCZys3USsxT0JWR1BmaG40MW1reFJn?=
 =?utf-8?B?ZlBFZHpVUnpJQUluajJkeS93VUdRTVl2d1NyeUVOODV0S1M4S3dpZSs1WHJI?=
 =?utf-8?B?UWtrVDJKY2Y3MUZsQkRmZnBjY0J0bnA1SzRwbEFMZTdUSW5INmZlbk5DY2tD?=
 =?utf-8?B?MmNNUGpJbU1FcTRFVmdrREVySndTMzdoUXFjbFlVUXBMNk9yeWJ1M1JhWDN2?=
 =?utf-8?B?RTRNZ0lZTU5hTHBDdnpzckladURyc1pOUnhOcCtCSm9ncDVoNXVRRGpOQkRF?=
 =?utf-8?B?WHdKSTF2YjM2YlhOWC9XUWFzcDhacmlvbjVjZUN0ZXNzSGRiZTAxdnVoU1JY?=
 =?utf-8?B?SW5nQ1JSSkR2VGJNc1VzdlpYZHJqaFhxakJYWkdBTmtSTTdnTkNQeVU5VVJq?=
 =?utf-8?B?d00wSkdnc3NUd3NnV1NwWjBUamJUZ3hhU1J4L09jVXdzTE5kVUNkbDloRitM?=
 =?utf-8?B?T3dKTkgrN3pMd2ZobUZKaHFJSDhtVEZUejEvaUI1V3VuSXFaeUdTV1pMOUtK?=
 =?utf-8?B?UWJ1U1pxTEk1NThSNndhQjhpSmU2UytCM0FyTGJTWGovaW0rbEM2SVZsRC84?=
 =?utf-8?B?SVloT2h3SEV4SHZFWEZpMXhBNDFPMHdBUEd2NE1TYzZ4THozK0lBLzlCL0pX?=
 =?utf-8?B?bjdIL1ErRGdPRmRPYy9LeisyQ2FNQTNIT1J0eDVHeXVrbmVCNlJoRTZjSHBy?=
 =?utf-8?B?SGEvRzFlRGZxTWI2ZDF3RkVRRk5vZEFTL0hGWDlwUmplUEFFbGRkMFoxeEZp?=
 =?utf-8?B?TittNUZJSFl5MGc5eWNmWGJNTElyQkpGbU43SlN2dndzekFzRXloVitVUndt?=
 =?utf-8?B?SWhXUFh1TnRsK3U3KzRES0NCQ1BCQ3JGZUZSaXpmQk1RVHplOHgwcGVpZDBK?=
 =?utf-8?Q?5XPun32JGmAm2kbYdiezPYo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f19913b-4a5f-4dda-1d38-08d9fb5f2fe6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:40:49.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkuNcIk+DYJZho5qKFvg49mQ9fZ/ll3iuNBQT76O/BghNqYCoiJuwVgjeym0o3c0LHCGKASJ7id/rVVt1zGp7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/1/22 00:11, David Hildenbrand wrote:
>> ...
>>>> +EXPORT_SYMBOL(pin_user_page);
>>>> +
>>>>    /*
>>>>     * pin_user_pages_unlocked() is the FOLL_PIN variant of
>>>>     * get_user_pages_unlocked(). Behavior is the same, except that this one sets
>>>
>>> I assume that function will only get called on a page that has been
>>> obtained by a previous pin_user_pages_fast(), correct?
>>>
>>
>> Well, no. This is meant to be used in place of get_page(), for code that
>> knows that the pages will be released via unpin_user_page(). So there is
>> no special prerequisite there.
> 
> That might be problematic and possibly the wrong approach, depending on
> *what* we're actually pinning and what we're intending to do with that.
> 
> My assumption would have been that this interface is to duplicate a pin

I see that I need to put more documentation here, so people don't have
to assume things... :)

> on a page, which would be perfectly fine, because the page actually saw
> a FOLL_PIN previously.
> 
> We're taking a pin on a page that we haven't obtained via FOLL_PIN if I
> understand correctly. Which raises the questions, how do we end up with
> the pages here, and what are we doing to do with them (use them like we
> obtained them via FOLL_PIN?)?
> 
> 
> If it's converting FOLL_GET -> FOLL_PIN manually, then we're bypassing
> FOLL_PIN special handling in GUP code:
> 
> page = get_user_pages(FOLL_GET)
> pin_user_page(page)
> put_page(page)

No, that's not where this is going at all. The idea, which  I now see
needs better documentation, is to handle file-backed pages. Only.

We're not converting from one type to another, nor are we doubling up.
We're just keeping the pin type consistent so that the vast block-
processing machinery can take pages in and handle them, then release
them at the end with bio_release_pages(), which will call
unpin_user_pages().

> 
> 
> For anonymous pages, we'll bail out for example once we have
> 
> https://lkml.kernel.org/r/20220224122614.94921-14-david@redhat.com
> 
> Because the conditions for pinned anonymous pages might no longer hold.
> 
> If we won't call pin_user_page() on anonymous pages, it would be fine.

We won't, and in fact, I should add WARN_ON_ONCE(PageAnon(page)) to
this function.

> But then, I still wonder how we come up the "struct page" here.
> 

 From the file system. For example, the NFS-direct and fuse conversions
in the last patches show how that works.

Thanks for this feedback, this is very helpful.

thanks,
-- 
John Hubbard
NVIDIA
