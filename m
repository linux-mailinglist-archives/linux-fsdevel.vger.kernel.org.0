Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506305E72A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 06:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiIWEFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 00:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiIWEFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:05:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B07F1057C;
        Thu, 22 Sep 2022 21:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0Lh83xYhYzdA8S/LuHT/tldPuc89NWBF8N5gEie/DZLci4g/2193omOm96q2Ci66bHCG0WeH9LfI5mGcQlidvySYBPridWLZhr09v2DRLUE3IWDrf7M+7LrcyAnyLpkdRLytydJwcw8tCb2bF5Sea8LcFDSCyyrGSiVz7YUY/vsoXLAkGGi11ji6Bc1mvi8eoGvwBanjqJh07haHgi49W26kk+ZEWSaPhE5zsSLs1Qq/qCf/P4UFhiexw1SLMZVcKrsKqNMhxbNsRUgE5NRhS3qQ6DATzsQh9HMMXcJdN8C7RwJkyeIsN6euDdVA96w8Fp9aotbcanKjzKuPUj/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGyY51c23Bhhpq9SIHKmLtRyBINyLqTb3fbifXSPreY=;
 b=iTfIpGXBrLrfP96CsDt/FgbnTpbwyQysBM6BIU7uSrzo4lxp758vGfjcTpgFNRqpeJcVm7BNFK6FPuCgKRI8K7wl6XD557ehUdwla2mXcKF8isbsE4fI2njPJ9EGRW7+5FLX9cncisi7VclfKNO4d2AOMmJd7bACBxRKwkfMGOdbeAO7Dzux+Zv3udF1zwiW4EquqHkaPhx317AaxTY+8q+or3wC4qLUr4F4aQSRBAZbdwO2eRyTmJs1mZjvZE0Uc8q/wmXXzfwWQdtKSmwtnfR+2gR6qBuOYMneh1mVXtt5Z2DyWi/UQnugmn8HiZrmnleUAg9HwfNPRXgqbPRf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGyY51c23Bhhpq9SIHKmLtRyBINyLqTb3fbifXSPreY=;
 b=VPFSY4fR3jHWkM+cDsy9XabPTXv9msxpLVAgda+qfYCgk+bmglpo3p8SfS0WYSoCPDFdG+DP9crDXNPIECujEyZgdCrOA5UK3I0lo72alfiw4rXyhi/5pJXtZGO8wdnwEbkyO3KKDaj4ZHDUxTOHSGw6ZUZ5u6LGHZojkiea9TQHCaK/5dZH55lUzAIudwkYshW6RmOjxaktNjRqT56ANz88/IIbai2Fwdznv2q+E64hJgVTqgU78m+wLT7jHxRc5qNJr3ikV48dzPrBs1RgmqHssG6wkOJ8x9VNxnbpChM8jtSp7qxptk0Y6UXayCCgx0f856urvoEZ/hzQmKo+nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Fri, 23 Sep
 2022 04:05:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6405:bafc:2fd6:2d55]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6405:bafc:2fd6:2d55%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 04:05:19 +0000
Message-ID: <7e652ba4-8b03-59e0-a9ef-1118c4bbd492@nvidia.com>
Date:   Thu, 22 Sep 2022 21:05:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3> <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV> <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV> <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV> <a6f95605-c2d5-6ec5-b85c-d1f3f8664646@nvidia.com>
 <20220922112935.pep45vfqfw5766gq@quack3> <Yy0lztxfwfGXFme4@ZenIV>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yy0lztxfwfGXFme4@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 21378dbe-5789-4067-f07c-08da9d18d421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oejTcm6/onJSV6NBUedyD0L/zV/e1FMV1QOepijJw7z7Ot53A0j0QiKKeaED06+ZgQXT19SS6HGfcmoxJX5B1wJl6tmERv/UXHbqibSKHDtpfZL3iiC0Y9GMDcTFKacfldShmxdlzsGLtqzSMkYT++Stord3AqH3BQEUKIcq41m5RlxFxzqv+KMfQ22qyw2VvAsILlLJ352PKRS0ZyYsYx8DR64IOAjVtvp0tCaOF5G9mjsiUVe6+wFw/uYirOsDU/Vt7j9HFfgixZKbCT8dTDmmJ0di6O/Q/IRJApPYsi7RsVVk4aWJrHvbrePmyp/Gklx2FyY4FJpDVhqeG+SbfMqs5/vbfsr4dwQSPtvch/npw2waMXh2nrgcNcougHsorO8wIQjC3m0G5nczP6o1AXq2tlsdIm6TAhWYp4sFeN6VbaogiJvMul+bBgTDg8L0z0HAsCcJjseVrWftanYVbGkCWrCPrtk6Vjd5ZqSv+spa5uB04WI8y51VEB6MGrEEf5pCNDytTuPt349bkPX21l7YhihhNAfE6lxqLjP4F2P8IcOqPFn+Kl8LAob5e29mJu/lbx6fGygsocxAblbSZxUZ+yMBuklaCx1XKnX5Dr6MKSXlZL6b+l6loaiCtRSTnUokcjnSJSXpFpP+2O8MDdCZydBhfzjJ4azEdXF6lp/IqDMEBiuwJIY62bco4Kv3KPLsGaHSzvCVw5tcKfbyDIDQizi0ncvIwq0bahg5B2D9Ybs4lPVWi1FGvpmicIhKKeSPP+VfP34hwCMfaapc60EmsWrQwTVyE9HUCWxjlYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(31686004)(6512007)(6486002)(478600001)(36756003)(26005)(8936002)(86362001)(316002)(54906003)(110136005)(31696002)(66946007)(41300700001)(66556008)(8676002)(6666004)(4326008)(66476007)(53546011)(2616005)(6506007)(83380400001)(186003)(2906002)(38100700002)(5660300002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ovcTdnRFZ6RVE4NXQvOXdFa3JVNy9STG5heWw4TXNsaU9tcDUxRmk2UGZE?=
 =?utf-8?B?NHlxT2U3M085RVFBU3lkb2VWWjR3OWFnZzRZaHY3VEUrbDREQmdDR0tsWnBp?=
 =?utf-8?B?MVg2bWpVMlFPUmNMTDltanlQcStvbHlwdEpUMFFPRW1Ha3cvUEp3K0NnTUdS?=
 =?utf-8?B?eENYa2JtbjZPZTFWU04rcjhSK1IvNmRMTUdOWlVPVU92SENoSTlUVVl2RDlk?=
 =?utf-8?B?TUxOSDcxMVFCUEFVWDBmN2pqTEFxTW16a3dOZFY2eEVPMjM2SGZOZWlzTEhU?=
 =?utf-8?B?Q1FMQXpUb1hZZmFHUEttTjVhQ01HQTJlUGlxZDhQdGZaWmN1c0lpelI1VzBV?=
 =?utf-8?B?dHlwTWJENndvcEFsSjUrdW1neVdDdDd4T2hpTUpITVIvalhGQTlMOFRXQ1pI?=
 =?utf-8?B?c3dFaWowYjVCMUZSNTI3b0JRRS83b3ZMSzhCeTVaOW5kOFRpL29ldmhacVdp?=
 =?utf-8?B?Q21aYncvc3hLTGhYWDVwdTJhRGlhbzFna2M2aUtadUR6MnoyVkd3Qnh3Mm5j?=
 =?utf-8?B?d1VhSHdMSjA4dVFnbWdkU3Z5aEpteGJYV2RlVWF0d1BuS2NHNkhFaG1xd1Vr?=
 =?utf-8?B?UUYvOXpoU0ZvVkxzVFZUMXBGQXcrOUlPU2VRd1RGOGQwTUkwZ0Z6WGg2UkFQ?=
 =?utf-8?B?em00TVZQVVZLRnlkYmx4MTZtbW0rNmxUU0ozbGdCR1V2Q2xlWkEyNGhLTTR3?=
 =?utf-8?B?eHNyM011dFhCdlNkTjl4bnpxMi90YlVXSExNZXMrRXkzRE45MmY4MmRZU2lE?=
 =?utf-8?B?cjV3WWVEc0ZsUk5OMVo4NlA2NjByNFF3Q1cvWWkxNW9lVFVrQnh4cCtVRS8w?=
 =?utf-8?B?NkRNNWZpNjM3NXNPUnREaURaOWQzWFpBQXBuKzZNWjRBRjZTWkozTXYwb3Jl?=
 =?utf-8?B?aXZkRVpSRUE3d0xaQ0NTMnd2aEJXcTVuZ2NLcEduMEt1YllLN1IrbjBCekw3?=
 =?utf-8?B?VnE1b1BpalRsd3JOclJ6OU03M2MzRVlXdzZaeEJYWURETEkwTWZwdHFRNzhz?=
 =?utf-8?B?UUYyR3VMYXE0T0Uyak9nSzd4N3kyQndNSDdmbUNoQk9jUkVjWE1CREo4MUpJ?=
 =?utf-8?B?cnNHaDBPdmtsS1ZkcWVMRkkvVjlLeEpkUGdpVjNMYUFQV2pVVWlWVWVUSGhJ?=
 =?utf-8?B?bEtseXdRQzBLUjRJVFN1ZThlOFIzcUJ0UEhuaGpMM3B4S21rc3R3RUEyb1M5?=
 =?utf-8?B?TTZWQmh1QTlsejgwdXNvVDdUZ3lIY1JaWkN3bEFxeFJUcGtrMkpsZUNRaW1z?=
 =?utf-8?B?TkdIRVY2U09wMGlHdUU4dGNoNWpIVUp5WEMwM1BZbmdRUEtJNzhrR2F6VDRq?=
 =?utf-8?B?U0Zoc3BEcUNZbzBIdkVzT0cvR3VTelZGa1cxRnArdXBhMHY4WkwyVDFUTUk5?=
 =?utf-8?B?YnA0SVdpK0oxMnlETVhZRHFaa1hKR0liZmZ3N25iSzdHcTV1dlUxMTl5aG1Z?=
 =?utf-8?B?RWVMd0ZBVzErRytTVm9KWTZlbGt0alhITmp3b3FQNUNab25GMi93bjNXekZz?=
 =?utf-8?B?NWd0YitQeGYxRzV4ZzVrSnMzZEM0N1RVbXNNSnF1SEZnbWtub0ZueXp0VStU?=
 =?utf-8?B?NjhscnFDUnVsVnJjTFFwWUhaSHV4UnFMbnFiRWVYVUhTMm1PWFdGRk1ZR0dY?=
 =?utf-8?B?OXlKRmdDYWNaVllYb1NKeXdYNWxVTVNLZ2JDbVBneHplS2Job3QybE1ySjMw?=
 =?utf-8?B?QTFFSUJEM2tUWUZUbitJL1BkUVZKdmpkUEhqdkZGSHhGUFpzd0JIc2VmU0Yr?=
 =?utf-8?B?c3BqMFlxeXAwMGZ2NFdTKzNZL0JBTVpSbTRCTy81eWcyQmEwVC95NGMyRnBu?=
 =?utf-8?B?OWZ1ZEdQdzdYd1JEQk5Fa0dFWUhET3NpZlFkdVZwNjlLZThpc0d6M256UEJD?=
 =?utf-8?B?UC9XL3BsWlRacm5HbEJzMkg3aEJOQ1NJN3pEd3ZsWUUxQ2xvZUtoUDNsRlN3?=
 =?utf-8?B?YnJwSUF0cXFOclI5aDh0aGg0NFpxYXhBcE1JVzdCbzc0aTJkTC9CTlNyZEYv?=
 =?utf-8?B?UTlTYUdpSzg4UDFRK1YrallEVXdOY0FwYUd2azI0NWp6U0htaFdyQnlzanRE?=
 =?utf-8?B?dzZzcWo0ajBQRUpaSWVHU1ZkZmhqS0c4eGZsMGFUUW96TDBTM3JsR1FjZktW?=
 =?utf-8?B?bUJxSmdJWEFtUDJwdDBSQjcvSzZWNW1kYm5wVDVPTXE1WlAveUlOT3BiRFVJ?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21378dbe-5789-4067-f07c-08da9d18d421
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 04:05:19.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVAsP3fwjDYca+xMXXkrC2aGNFbdKiPaGxK+vsBT00TmQ9YRMO53Q8FcUsC1rSJ0y9SGUJbbzJ2SluYK+KvUtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/22/22 20:19, Al Viro wrote:
> On Thu, Sep 22, 2022 at 01:29:35PM +0200, Jan Kara wrote:
> 
>>> This rule would mostly work, as long as we can relax it in some cases, to
>>> allow pinning of both source and dest pages, instead of just destination
>>> pages, in some cases. In particular, bio_release_pages() has lost all
>>> context about whether it was a read or a write request, as far as I can
>>> tell. And bio_release_pages() is the primary place to unpin pages for
>>> direct IO.
>>
>> Well, we already do have BIO_NO_PAGE_REF bio flag that gets checked in
>> bio_release_pages(). I think we can easily spare another bio flag to tell
>> whether we need to unpin or not. So as long as all the pages in the created
>> bio need the same treatment, the situation should be simple.
> 
> Yes.  Incidentally, the same condition is already checked by the creators
> of those bio - see the assorted should_dirty logics.

Beautiful!

> 
> While we are at it - how much of the rationale around bio_check_pages_dirty()
> doing dirtying is still applicable with pinning pages before we stick them
> into bio?  We do dirty them before submitting bio, then on completion
> bio_check_pages_dirty() checks if something has marked them clean while
> we'd been doing IO; if all of them are still dirty we just drop the pages
> (well, unpin and drop), otherwise we arrange for dirty + unpin + drop
> done in process context (via schedule_work()).  Can they be marked clean by
> anyone while they are pinned?  After all, pinning is done to prevent
> writeback getting done on them while we are modifying the suckers...

I certainly hope not. And in fact, we should really just say that that's
a rule: the whole time the page is pinned, it simply must remain dirty
and writable, at least with the way things are right now.

This reminds me that I'm not exactly sure what the rules for
FOLL_LONGTERM callers should be, with respect to dirtying. At the
moment, most, if not all of the code that does "set_page_dirty_lock();
unpin_user_page()" is wrong.

To fix those cases, IIUC, the answer is: you must make the page dirty
properly, with page_mkwrite(), not just with set_page_dirty_lock(). And
that has to be done probably a lot earlier, for reasons that I'm still
vague on. But perhaps right after pinning the page. (Assuming that we
hold off writeback while the page is pinned.)

Just wanted to see if that sounds right, while we're on the topic.

thanks,

-- 
John Hubbard
NVIDIA

