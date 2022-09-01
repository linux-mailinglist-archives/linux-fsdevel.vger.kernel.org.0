Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469C95A8B09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 03:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiIABtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 21:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIABtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:49:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB5DCEB1E;
        Wed, 31 Aug 2022 18:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cW48c757nYH0d5And8jQAKJhQXcCTHxyf9ZyqAMI9SbgxqNiv1rAHgDAE/fsX1N3W73oQqnHXlRdwvTdPXN8L1m+KESjw42jKaEEUhyfvxpc+HqTLE4FQYHjugPl7MSJf2kgz2xsTv1GJc83e1smh71/u/k8zqnK6beQBM4HkXBFtowBc6KUKiEZMvPbGcCTYkLk6/zBFvHJfn6P94x1xKsymbOddbpEGAvjoNiBOAnrzhKiXdY4swjKk6BSgpParVdmHEp4Pt8A4RUrS4wbzSIsoznorRDCic8f/jNnVShQU/6gAsf17/7KHXOGA2QqAj9YtzzyyVBjHLweXOjkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAPEjw4E2kr+rhKSctp6w6armi53GxXlht8iXGRLkqc=;
 b=AMUqP0HU9H26Krv+C5UA6sNMCTf/jjbeicUsjtd30bVYC+RLSCcJqT16m+VW/KuQCQEcpRZ2Th8djteKyS8IYmUciXZ4wRo/UHCSsWAAag69612n6G0Q/Ty3EKWPuyvY8tq+0iow3OfZUzHvo6suMNZv4k/kF3uiQ2XfogDwBO6MMIRPvunWwC8rwoFk+fkHtuLoaF9we37gw4lm5+eP9Xhi/xeEEwndx4PVY1OFLNBBuw8awKOJPblh6qJYh4utKgstb+fAsfJRiLrIQvo3ECqf4M4p8wBfRqCq9LlqOOsTDDf8pmTust2VJJdP6YyTqKx8xe8fuQ9o1xEMovDwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAPEjw4E2kr+rhKSctp6w6armi53GxXlht8iXGRLkqc=;
 b=FJ8jUUqgNqT+fwMdclxg7+tlfm+DZ8PNymJhJQA8brNDrj+VMZpbZfFwvyLeIIzfubUTvNhvwdk6lnKxt9CN0MqrS6OeT/aOIFUBexGGQcwpNbyf8B+I18rbb3wd50maDFSZcyqwufOa9wsMgPoVQN7FehFyyoMVhfSHjxHP9LOO8CEmvvdI1MwnTD417zE/aKG8BoYZ3ad8WMiQdrtNeo+g82ubdFckyuETr1ka2Lk+KW/RN8DFirbutpUcGW0B2pmKGqtb6UMXtf4s2Kt2xvJ+wEUMxxijwlAd6vFBLb8HiYAseXQOmvqV2Pf90G/OxDKeh+9lW73zpzplBpng3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 01:49:01 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 01:49:01 +0000
Message-ID: <85a8a0e1-72dd-e37c-85c5-77fab21acde4@nvidia.com>
Date:   Wed, 31 Aug 2022 18:48:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com> <YxAABm0BljO0aP2h@ZenIV>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YxAABm0BljO0aP2h@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:217::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c7fd94-afc1-4672-e5bf-08da8bbc247f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4376:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuYh9Ai2IuQVMQ9fJj5OJz+6Dzapl6i74DcvZQTUCJpEWkR4TMKbJH0QL9z5VT+BaJg5MIeugDwbXkZlUQKok7N8BUe70MbDwJ/ZB367IdwvBsdg39ndN2zyFVeC6ZFRjhErNsCEaVEd6ceNTQwSz/bFG41ZNWV0XwGPNncDwAV93pWZHYbgBV/aRQZgjLWdwmPXJ1e40pWCdeYvrf9C5+1J9tdOQhilwjWtK2hxxfLBEH4i4CTR18qskY9dC5qZD6NFQm9UmDaYpyAi9XgZAurLJxb3zPrsjgiRvUQaIGDl/sSi2HuLfbDlnlZDMJzqulf0/fmVRYkKMnyKBXthr04G906kr1+HC7bdwrV5+uM2NTPAurmhBPEJcBy3AkbDpcNr1aoyllr96pK1r1U17k6GxeENWvlg6y286OzJLmTelmyuW5AgWyC+atvcuFbWKIb6bQJxQbpnoR7M/OWpa3DjbGmTYBpZl2s/6yDyGEcSf08qGhLHu/ZTY/Kwn7tWdRBAAeRyIWOuWg5DuZFaQGP2zqq1OhKme/ZriyFlHguGEEek7eQkqX8GhItVh9MQrq22tliZsX32CAClUz40f1HIMmp1ieDT40tch61zFLpcGNMN9I5ZJdCQNdJ3bUPKpDvAQHS5kWub1lWW9jj0ECj/qXdAqVA04siUONVi3bVls9bQIewdA1/s410/SA1KWZVxCBXfDUieWWTk51RIWcui8zlPBAS/OitT/19uLhX+BPZqc68VFtbZ5/54ankrSeCJb3WO5q2ZEsyOlAVzs2om+zzF9Bbn3jH2SH8NJBWIxGayHlNcfbtE2IhVUndPtoDUtfYOzRayQ/q3YN/yAaYUU5r/KSA171j28gnokTJEk8UyEm5uYowegXjkyDd3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(2616005)(53546011)(66476007)(66946007)(66556008)(6506007)(966005)(316002)(6512007)(6486002)(26005)(6916009)(86362001)(31696002)(41300700001)(38100700002)(54906003)(2906002)(8676002)(4326008)(186003)(478600001)(5660300002)(83380400001)(7416002)(31686004)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZOekZ0dXczOFcrWVdLdlFqVmdlbjYrNjRuRzFPK2dSK0RPUWdDS1RzSXBM?=
 =?utf-8?B?MHh6bUNFZmFHUFdYOHF2UkJXek5GOWgycEx1K214S2ZYM0JkbWUzekYwSWtK?=
 =?utf-8?B?a2JaaERUbXJ5TkJSQzBwL0xHcmlYbjVlV09jZldaakI4RkUrR3ZVZElOTWxm?=
 =?utf-8?B?SGZqTFZmcVpDTzcrL1FXWmVuM29VOHg1NmJzem9XTGcvNzZQYmM0MmdjcVB5?=
 =?utf-8?B?S1ladjVyYjR0Y25pR2RKVFVObzBIdlBFVVpSUEpObGkzeU5leTJYbkNWbmw2?=
 =?utf-8?B?SVpsc2liUnlsZ3EvbjhzNGxCUjdqVWhxWk1xRkxVL0tYL3JqTHRrTUVvMnlt?=
 =?utf-8?B?ek5PUXVoNmdqUmxRenIzWndOdGtjbVAzKzVtU1dZWHpYWmxxd2lKZ3d6VVoy?=
 =?utf-8?B?V1NsMkNYQjhHbytISElEOEh3REV5NGRVNVNIUU01bkpRdTVCcTdTRitFZ3Np?=
 =?utf-8?B?cmg2T0NTNzNFSmlxRndlQWxXSVd2M0JTVlhnRWdROXVjK3A5bGtoOC9iUmNy?=
 =?utf-8?B?UlM1VGJ6QWpIRFJOZlExZllMK1pTeEVxSVo4ZWFpYUZBR0p4TXNDZkoxS1M2?=
 =?utf-8?B?d1JaMjI0cTY2QmJHeWtzN2IzL1pXTU5IOCsxSFdvSXBxdVhob2lXUTF0VnRK?=
 =?utf-8?B?WEhlSEU3NW1iQVNTcTNibXFIUnhnMHRNQU1JaHhwV2wrSUkzcGZZOTljdDZX?=
 =?utf-8?B?OXRPV0QwRWp1dENPZjdwem1VMjRZWnpQOGoyRlpkVW9qMWhyNFhZTm0xeUxM?=
 =?utf-8?B?bHRVZVpQUkxCaXluczFkRmp4OFFVNmxLaVczMkE3MFhlU1F5UXdVaFh5TXoy?=
 =?utf-8?B?Q00vOTJHeDZSZFpIYzFua2pCZC9FZWhmOUUrSHBTbjMzajNaY2dGK3ViQVdh?=
 =?utf-8?B?SXNtNTdZWlVCMmVJNHlKTUpnZmNXMk56OExsMGg1N2xzOGhtdklpaXZZT1BH?=
 =?utf-8?B?OHhkWFk4ZTg1RUdOWjZtTW40eEZvY3B4OVdlY3c3K3hhaGVsdUtkK3dWVmkz?=
 =?utf-8?B?Yk5ReVE3eXVyVytlQVJ4Y0VDNGlxQkVlc3FERE9ha0xYckZZcWQ4ejNWY015?=
 =?utf-8?B?NjRSeERBSmNQYzliS0dQeTRYNVg1R2RMSjZ4NlltbS9PQUJZMSsrTU9iVGxU?=
 =?utf-8?B?NWhDVGw0VE9IWHR3QjU5dFZjSjNzZzNRYWJMSzFKZGZVNXFXemZNV0ZDdzdG?=
 =?utf-8?B?ZjBmVzh2Q01JcGN6QXowai9sSDhuanlTdG9oZTRsYmpuK1IvODB4NFNJR1F3?=
 =?utf-8?B?MW5tdG5Ua0VvcjcrUHJKRExRYWIwMmR4QTR4VEhZcHVEQ2hGWVF0bDd1OGI5?=
 =?utf-8?B?SmZVSndRbm51UnhRVXppTThGUG5LWFZYZm9JK2Q0d2dFN0x4RllPK3FodTBP?=
 =?utf-8?B?MTF6ZXU2NEdWVVVXdEl1bXNvSXF5UmZhbzJIdnQvQ1lKM3RaMlp1aXk5NWZn?=
 =?utf-8?B?MjF5Vi96Z0c1Y292S2ZNNFBwM2thUG5YL3E4eE5qbUFHYXRqTndCZGJnU2hI?=
 =?utf-8?B?RVFpeVpsR2hiRXU2a3Bma1YzQzNMeVlhbDM4Nk1hR3ZTQ3YzQXU2bUlPQ1li?=
 =?utf-8?B?VjVrRWpoOFZSNHluSkhROG8yODhjNHR3bEkrNkdxbjVscklPMC9Pdkd5Y0FB?=
 =?utf-8?B?RTk3WmsrOGg0cDhOanVEUFJ6UUhyMU9YelBibTU4MVBhY0N1UTk2ZkkyNlBS?=
 =?utf-8?B?eVBCYnJZelVqMm1ZTXl6ZDc2bGlTRTVkdlluaTFPSEdYUG1sN28xUnA2SzhQ?=
 =?utf-8?B?YXZ5WVhwRnlSVE1JZEt2RjlpYkZ2QzBOeUtURTlXRkg5b3RreGFuWXVQaE5y?=
 =?utf-8?B?R0o4NDBXWUN6TmFSeXgyVkJpVERTdEpFNElFOHFybTZqOXZqc3psMzBTOEVz?=
 =?utf-8?B?My9jNndpaTZPV2dvdXlNY2Y1VW1tbWtuZklFalBHVWtuOUhpbm9YdElXUGxh?=
 =?utf-8?B?aDNBRkVKWnhIWWp6dVV1eTFEQWdjTkhCSGhtSlRZbG1yMjFTQ2ZqR21jWGJC?=
 =?utf-8?B?aHZIYnVlTDByaGdyUjJycmFOQnAva29MNzhYL0VBS0VNMlc0bnVnM0ZCWk9P?=
 =?utf-8?B?L29DMGxXY01VS1djL1hlQjZhbnpTMGZqOHN0YjNESEJ3OFIvWFdaVXhUaEVv?=
 =?utf-8?Q?GXvn4gCO7GGPo/t9MsjhEcO+c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c7fd94-afc1-4672-e5bf-08da8bbc247f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 01:49:00.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgKRqKy0uFpHxP461Q/qDdhM/DcNYhnPaHk5s93j89I/G5UW47vkbNWV/RlDehWyL+88NXFZ6Ec3VRSoBTiDsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/22 17:42, Al Viro wrote:
> On Tue, Aug 30, 2022 at 09:18:40PM -0700, John Hubbard wrote:
>> Provide two new wrapper routines that are intended for user space pages
>> only:
>>
>>     iov_iter_pin_pages()
>>     iov_iter_pin_pages_alloc()
>>
>> Internally, these routines call pin_user_pages_fast(), instead of
>> get_user_pages_fast(), for user_backed_iter(i) and iov_iter_bvec(i)
>> cases.
>>
>> As always, callers must use unpin_user_pages() or a suitable FOLL_PIN
>> variant, to release the pages, if they actually were acquired via
>> pin_user_pages_fast().
>>
>> This is a prerequisite to converting bio/block layers over to use
>> pin_user_pages_fast().
> 
> What of ITER_PIPE (splice from O_DIRECT fd to a to pipe, for filesystem
> that uses generic_file_splice_read())?

Yes. And it turns out that I sent this v2 just a little too early: it
does not include Jan Kara's latest idea [1] of including ITER_PIPE and
ITER_XARRAY. That should fix this up.


[1] https://lore.kernel.org/r/20220831094349.boln4jjajkdtykx3@quack3

thanks,

-- 
John Hubbard
NVIDIA
