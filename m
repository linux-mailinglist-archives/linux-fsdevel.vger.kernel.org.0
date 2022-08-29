Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA235A4215
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 07:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiH2E76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 00:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiH2E7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:59:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6662F2;
        Sun, 28 Aug 2022 21:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBLmXDIt7jYFTFUv7VgeMNVqpdCLR+W1XljVczHrAn5CfDCHBOpjg5X6L4m1b0NKyyyATTIWAs1cKQqXf9ARFDNVdDz8ui3Ji40mHVsqLNIKyrLUuQxGG7xAqD3xzPMPhp12dy/lN8PAuEwLDMwArL+hIyiVTTuQloklfKq97l2MYd5Dfje2RwivaRr3+0RJuf1eG60FPeTAwybkmJzvr9vcgIKas5wr6eb41eVb1hUjjRQJphbZp+zikZ6xqFVpuawQOVDQdsyR2I1RL4PmqkImE6Yi92YLpMLvQQTyZjcNPyd8ku4Oq6A9FxOA8NZqfOsG82C8eJwtS45fBnuIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwEyybbqjFdfTBWlYtScAPHsVXuNrG80tWndDao7d1Y=;
 b=bI2PcGc3WZRnaRKmDP8mJbN3iosyC41F4C0ZFM/9lCCvYgeRSA4fSc5A5fx16huBTTIxE7WKmVapj2dY7oVlOS6lE/SOslQ8K37jhyeqoyttV5vNkG2Cc6AKBIwHYnF4ybpBsO0EN1femUDBKdojcCi34jkmnuTz84zkue3JRtuALHB6wx4WQdFpPrHWCBIgMzHq96pyowOOERZ6xXP9Ef66EWUbzTlZbuK/m9DiBadywnATJAOSd5ErnO/XMk3zB2wlsHUzx6W2hk0o3W52cArxiFHf/kQu5s6QsthBaqkuXwJ/IXVyRmsDIUcSJ9e+J4TB/Fw18J66C+0dj9UMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwEyybbqjFdfTBWlYtScAPHsVXuNrG80tWndDao7d1Y=;
 b=R0zseeKtS/YkFPb1u7P38xG2rh5dzJEAWjeK/Z7nNW3ntUeaoHAS2nW566cvXdJ/h+vdvJQvnpshD1rqMzGvxMh71pURMP/RLzQnjuFvHU4cWQlMbqCqANcv2DTQKqOfjEWrRsWt+aRC+rAUE1b7tCMtCQl09oSi4RFcusHrs9nwKAm8Fw7jX9FTsp57V5RRuvZo5DwZnvgRRy7c+nq9r8NjTbtgZEE5+14EVCOxuSN8wWKIPYlYTfqnCWRWdT7YGHKXIlXWvT565ELGwcF6KxNTgk5Bb/KTuUuylh3XRkfozK8QF2K6gPFS+ZUyjJC3Y5OPQXRZz7iP9aywWyTzTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 04:59:51 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 04:59:51 +0000
Message-ID: <217b4a17-1355-06c5-291e-7980c0d3cea6@nvidia.com>
Date:   Sun, 28 Aug 2022 21:59:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5/6] NFS: direct-io: convert to FOLL_PIN pages
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-6-jhubbard@nvidia.com> <YwqfWoAE2Awp4YvT@ZenIV>
 <353f18ac-0792-2cb7-6675-868d0bd41d3d@nvidia.com> <Ywq5ILRNxsbWvFQe@ZenIV>
 <Ywq5VrSrY341UVpL@ZenIV>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Ywq5VrSrY341UVpL@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bce0aeb-c394-4d9c-b6fb-08da897b4e1e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5289:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnCK/vZ637HJMv/dRF7b6HR/ReSLBfXCcKuXkz0aaHLnbd9zfx0aVTgdxitKgVj9px6qIElvK61k1P7WkKVqwEELBJ1sItPPFGIUmXlSwXGo6PV/10wgMztVeL5ndIQZtgx6qVfQ3/pND1EYHQRZ0QUdgz8iNw3E782zGWMJqVjpr9ZXzYdjJ/abaCD/+gPCPx6heEYyVBWuV7B2zjUX+c0VYreXXyqzFD4Cgqce3AHIM/2OgRS6gkVVp1c2IEy83sRNofi/Aoi3Mrej0+0WCp1G5T4B4kBcDZN2vELuJ0IkvroK55VBzRSzkihPPageErvBRGjsXcB8feval3yi6U/UQBMb1qDGncVstYRH7ihAzv27U0Nc2OIDQC/ODiA4OiguRGmoXsXagLM/U5nEYIqFvygOX5KAJBzBMOEXvbm+ofOMY+yZlQqLGKkHPXlKi77CGm7zzSlo/4B0kiKh1eG2H5n+8MTmn83BMEkUf0vlkuPragiurJuKeorezXf1iGLdJQgRODEt0KynKoibWPfw6iuMiydcweaLvaeON1OLDmJDd/FkahV/Ssb2hpIwC6tt3d8XcDn79/cB/A36neoBQiXt+IbbAtlMZ5EGXj/iCVR2xd0rG/1YKjWA4GWiIbCKHWn4W7fBYpvyZ2E1So57Ipm0whQWhLFMceKdSKoj5skT3w+jRn2pIz1Dk6w9f5z/3SCcUL5OPiG9XaA3m09SOByGvnTRdWrl54rUiNmpem2YNg2hf3JF3yJFYOeyHagn7aFMLYgxTGT2oSABNYETikwwqZqEt8payK0asZVP3D/AgXoHHIFzR/u1fWQvnPne7KF9mo+70l2JEuPG//T9oZj8UGteJMdJCf1vWZQhzSg4+JW25K5Be6nS3TH0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(8676002)(4326008)(966005)(6486002)(66946007)(5660300002)(66556008)(478600001)(6512007)(26005)(8936002)(66476007)(7416002)(83380400001)(2906002)(6506007)(53546011)(41300700001)(186003)(54906003)(31686004)(31696002)(86362001)(36756003)(316002)(2616005)(6916009)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9KQlNEejY5RzNySjdrUmJoU3piS3ZVNVhKR0IzZXJMbEFNSlkwalpBOHQw?=
 =?utf-8?B?OVVENDdrYk9mMllMblRtdXpWSlQzMjdnTU40SllrUVhzbHFQaEFzMkRDencr?=
 =?utf-8?B?U0Jzb0haQTZqY0RzVHN2TndsS1pVeEtwRDJoWkVQa2dYRlBoRWh0VnNrVHlk?=
 =?utf-8?B?T3pxREtCUzJaL1pLc2dwTHZLVW1zeGdxT2gxTCtPbkcraTY0cldwOWtxMndX?=
 =?utf-8?B?bnpNMldBNXpKUGZGS2JLNEx1YVpjRnBDYTBQUWQ2NlRrc3dzLzZzenhrcDFu?=
 =?utf-8?B?dUJtVmdOeFI2SW91L1h5Rm9TSWxPbkhQbnJPOVQ4ZUxjTG03TXpSOTU2UTRL?=
 =?utf-8?B?em5EVFk3NUhQaUZocjZ4TmcvajhXN0Y2U2xhNTBTVUJpN0FZS01KWFkrTmx2?=
 =?utf-8?B?NXlqcnltdUN3SzhxTjhPYUFOaVV6VnVOa0o0Ujd2M2d1Z1hqM0hkVkhvWnl4?=
 =?utf-8?B?VUY1Yjh6T2xkK0N3ZkZmYlhUTW5sc3dxWklaVUZaRng1R0gvcDNpVkFDQkdw?=
 =?utf-8?B?MzN0MUEvc2NYQS95ckticDczM2wyVk5GVEE5bjVaQXNpR1hvZjRMR1VqczJ4?=
 =?utf-8?B?Sm1tR0JBQ2hub2xIQzV3NUN3WTh6MFVDQVR1ME8yZHZST21jcXpqS01iSjA4?=
 =?utf-8?B?QU1rUFJpaGo1WlcvZ0hIOCtVUElKNVdCcGc4YTBvM1l0cWRqVkZwRmpCb2NZ?=
 =?utf-8?B?eWdHNWREWTVMWDd0SW0xbUkwRVlTL2p6RHN3OTJmRC9GLzM4bkp6dDc0eHFE?=
 =?utf-8?B?Vnh4azJzVG51TWdubC9JM1pCeG5wYWVIWFhLZTB0UVFOZThDamFCK2xMTVJX?=
 =?utf-8?B?MEZ2d3VZQ1JUY290Kzc0NzFBRWtMSG9kcUVoY3FMcDA3eGo3MG13cHZFNlJE?=
 =?utf-8?B?SmF4WTVYVEdXa2JjNjdLWCsxTjcxR3NBZ1laVjlpRnE2cHlwSnEybU5aOHpR?=
 =?utf-8?B?WTFDV2dSU3BJNVl6bWlBY3BqdjRjOGU0V253TUoxQ0tzZ0hLOFg4Y29RMUFk?=
 =?utf-8?B?bGNsS2lDOFdvY2lFbDFWUFBTTGsyQ0E5cCs5QkZuYlBBVkZuRXRRRmxTZ0Zn?=
 =?utf-8?B?VVdPSFFmSWRxZ0duQUtkSG56emxXZy8rcHBuRWhxc2txVHZ3dUNJRmJsSmRD?=
 =?utf-8?B?S2lkaWY0U0lUbjBpUlY5N0JQNG16L292ak1mRGEzK2x5TGM5ZkFWeEc4Vkpq?=
 =?utf-8?B?UkpXR2lvdkcvYXQ3a0dybXlkYjBVVlVVd21xVlRVWHBYMVk4WDgrdHV2MXRF?=
 =?utf-8?B?VEhIa1FLWkZiRGsvaGIyRXk1Rm5WZ2dZaTZsMnU0U3JZTTV1ZTZjUWRYWThs?=
 =?utf-8?B?S2lhaHVHWld5NVpqcXpTYTA1ajkzbi9yZ3V3dURkY0s2b1VxaHl3d1BjOUlw?=
 =?utf-8?B?alVvMWFjL0Evdit3SlM4Nmp5YWtTTXp0OGdCbVhtZzJmU29iUTJEVWw0NUJB?=
 =?utf-8?B?Qm1naTk5VXFlcmpXRjhvdklFS2gwcXhHQ3RmQkhKNFNBTlozYnZvek05eCt1?=
 =?utf-8?B?YWZqd2FFbzB0UTkyOTJoSjNGK2NOZXNMOHByTHBWdWdESWR0cGs5SFh4SXBX?=
 =?utf-8?B?MzI4eE9VQ2l0czV3M3lhQ2xsdWRya3dSR00wSWEvWlB4TkdyS2hJNjlyTklz?=
 =?utf-8?B?YnhreUt2djNsdVFHNGtyd2NtVi9PYlRqaEQrWmJzaHBCc1g1R0FmaitCbndK?=
 =?utf-8?B?WUdPc0hnclZQMzBTMFc3MHVXQW95M1lxdjN4OC9peUl5S0pRenloWTFuQnhi?=
 =?utf-8?B?aUNZL21zbjViS1A0RElmUmRJTHlKaU1ONXV2R1Jpb3Jpck9HNHhUeEdDTmpw?=
 =?utf-8?B?aG50bnB2cnVHQ0FqZ1NtRVp0a0JwMHBrSDBXYnVwVkdOK3JDYUQ5N1Z2OVpi?=
 =?utf-8?B?bDZKY0ZRdWc1b3N4SXcwMGNPbkY2dXFIVEo3NEVJQjVWQnA4cWxLTHgxQlll?=
 =?utf-8?B?MHNodi9TMklTTHlVMDY1Vk9FeUh1amc5Uk5QYWh0eks0YzJWU081Y1hxdm9B?=
 =?utf-8?B?VjBSNXN5cFgzSU9pK2NuTTNIRE9MMC9tTTZKRU8vQkUyTWtwYi9LVzBGWTFV?=
 =?utf-8?B?azdNaTMxZGVZM1paOXZ4N01NNjFvWW5NZnBiTlUzYlZsNmsyNkxUTUpZaXJs?=
 =?utf-8?Q?mXBMFVXU5AMCchdqR7et+yHJV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bce0aeb-c394-4d9c-b6fb-08da897b4e1e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 04:59:51.2191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnQy0gUtWEXMgZlNDJYSpibI3OTFEVZCQWPZFQ/UqzTOprTKekcobYuZIdurVnB5OlWgnvkm2pqhBtt+kE3VfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/27/22 17:39, Al Viro wrote:
> On Sun, Aug 28, 2022 at 01:38:57AM +0100, Al Viro wrote:
>> On Sat, Aug 27, 2022 at 04:55:18PM -0700, John Hubbard wrote:
>>> On 8/27/22 15:48, Al Viro wrote:
>>>> On Sat, Aug 27, 2022 at 01:36:06AM -0700, John Hubbard wrote:
>>>>> Convert the NFS Direct IO layer to use pin_user_pages_fast() and
>>>>> unpin_user_page(), instead of get_user_pages_fast() and put_page().
>>>>
>>>> Again, this stuff can be hit with ITER_BVEC iterators
>>>>
>>>>> -		result = iov_iter_get_pages_alloc2(iter, &pagevec,
>>>>> +		result = dio_w_iov_iter_pin_pages_alloc(iter, &pagevec,
>>>>>  						  rsize, &pgbase);
>>>>
>>>> and this will break on those.
>>>
>>> If anyone has an example handy, of a user space program that leads
>>> to this situation (O_DIRECT with ITER_BVEC), it would really help
>>> me reach enlightenment a lot quicker in this area. :)
>>
>> Er...  splice(2) to O_DIRECT-opened file on e.g. ext4?  Or
>> sendfile(2) to the same, for that matter...
> 
> s/ext4/nfs/ to hit this particular codepath, obviously.

OK, I have a solution to this that's pretty easy:

1) Get rid of the user_backed_iter(i) check in
dio_w_iov_iter_pin_pages() and dio_w_iov_iter_pin_pages_alloc(), and

2) At the call sites, match up the unpin calls appropriately.

...and apply a similar fix for the fuse conversion patch.

However, the core block/bio conversion in patch 4 still does depend upon
a key assumption, which I got from a 2019 email discussion with
Christoph Hellwig and others here [1], which says:

    "All pages released by bio_release_pages should come from
     get_get_user_pages...".

I really hope that still holds true. Otherwise this whole thing is in
trouble.



[1] https://lore.kernel.org/kvm/20190724053053.GA18330@infradead.org/

thanks,

-- 
John Hubbard
NVIDIA
