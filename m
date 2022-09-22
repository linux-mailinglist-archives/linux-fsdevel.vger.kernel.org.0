Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAAC5E5B1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 08:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIVGJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 02:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIVGJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:09:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF5DB4EB1;
        Wed, 21 Sep 2022 23:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/TS2H437IXg4jpgY8ZGwvyGlWjeUxr9Ff7i+T43cYTx1QMnrkE3OtA8kLj0MaXZ91L3W2wWs4zCU6EnH1ywOnttt2YbZsb1WOWCxArRmOfsStsKG9TO8h9HGljG0YN6gEdHFqSTfEjQ88JsRPQHFdQ+dQDg1A4Am8v9+DLmJbHKaXrYJ4v4yeFy9BG3w5IQALJ8fbIbTjnC5fGirnfhxF0gXhPOzOe5q3Hy1rpejhzlbAfPzhb38QrFqD9h4ftrewbD98Y+ylXAH/M1al4NVnkZhv6Tj2VCl33NzJkTvgYN4LWvGbP3ea+9aM5SqWZaC7OIHbvsqz7OMXKGFDtZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Syx9XNSx5IZOTQlvixjpf666Pd0Nnt3/8QVAiUddVPw=;
 b=GJiQh4/RdtVDVHipD0a7W2WZzUgZYTAVd8Aq2CVGo4eL6FIk2KcJZNpxrCrFdkFuHKWDscoS/C19pYk0XpbGrXDSQNw2aZAIplAs4gPwxQY73Np2dIzt9l6YAgSW0HcokCVxYPtftQubZM3suHpCF7fLpHqR/eDYIZeWR9cbOYXR1YUppCO1G3OMm2HceathIImGDpjPkO57PmqDqqrt1Ubj0y9Dxol37veRwcU9HO5JdlAV2uUWRgNbnd7tSRdw/Q6BSou5zf4mJWEGUGIcomnaecMDAjc8hWPcG+Tu1DBR5r646CT6Tr2vObBRWQfQMtcLTOW1+1iDeCxsO4V9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Syx9XNSx5IZOTQlvixjpf666Pd0Nnt3/8QVAiUddVPw=;
 b=Y0/jTnQzVEIossXMQ8irzt0MMEOwcLwy5O18qqz+8F4PCW5H1kOtk34GWjsQa9rEFsKNbA04gjsjeh4x1r5vMDX+CnTo5FV3cGLVm2BRV5Y9Ke32mSFGsCTKwhAX0hVjppixCTqZcQ5c+MedZEAIZSHWmjSPDHjBdnHsm+QFnjCXHH5j172OP151uVdtAv3Id/XVL2UbhXGOWNmtX7dA5C3D6UxV48VUPLyW5IENiolMLosGTUQPeREbVXsJ9ghrhsospfBC5UYuQaL0voUJiqZw0voqvq5YjbFc9BSbyO1mSTfNJxTbqkqiv++iV4/g5RHI4kZWL1Vvl7V0Pkd3Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 06:09:10 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6405:bafc:2fd6:2d55]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6405:bafc:2fd6:2d55%7]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 06:09:09 +0000
Message-ID: <a6f95605-c2d5-6ec5-b85c-d1f3f8664646@nvidia.com>
Date:   Wed, 21 Sep 2022 23:09:06 -0700
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
References: <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org> <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org> <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3> <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3> <YyvG+Oih2A37Grcf@ZenIV>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YyvG+Oih2A37Grcf@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH0PR12MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: e35a734a-d30b-4125-44af-08da9c60f689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtCItrIoDfzA1l4bz6lRev4ASeZ8CWyyZVS8jKfP6MiPv+51gdQjX+UJW664qQlZ3OlKkFTJCbuoooYMbruJTibljhkMB2fcBhhAKjOH6MaJppmIRwB0AEPUmpa1gfzbp4eR9B3IOkHzV9FzfTBouu5NPDu7rubWKBInt8Ix32+Wg6FxuOTotOPPQ8J1GxqqfetUrZfuCMXqtoGABLGuU3EPXxyuvxGyLj0shRpiJcPWXAhy6fKhadabUP6hXIBCdpdcDcw+nqFr6kwY9YQrZ8VIWXm8Ie1pzI/tdi5j2W+17Yvl3jMa/5fwHK6fCmNxXy2ssXdDBymomyAJ6/6xc/QUe1OjO0+NfJmFpZCJ8gMIqU4VF5UWoplx64BEfXMfJgNNju+4AyaZtTbS/cfSf8OMC3kKxUJWMc+7XbQCdaE+1DAeWQ/NHuEKT7l65U/q8+aJGy+LA9DiuDKV8TxRf5atYCQhFs5H/dELiaqrcxRIp45lLpjBfH1Jgol7IW2g0UrB5cheA1m1yMZUDazXqA0BeFfblwaKybVuy7BLPjlKDsbHJwDxMGIYYgxsCtWmpo6+10dimmEdLeXU44JMnXRaNslN708QYxtEH75oZm/oVggYJnhUgptOZmL5jclCWe+ldxNb09pLilhqRMC1usBTkBIqcIaekNwTvwuRI6P9BzwogHnhIb45gE8UR1sAFQxMQjMI6eWkiJuttgyDzYsbjFtcUyAQkVSrp4KqU0K4p2DU+wcJkjcISrDuOGj32fgkyx4KTx7tZK9llqkxFV9C4dQLTpHijPCKeX0ZSkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(66556008)(66476007)(66946007)(66899012)(31686004)(4326008)(53546011)(6506007)(8936002)(26005)(6512007)(41300700001)(6486002)(8676002)(54906003)(5660300002)(478600001)(6666004)(36756003)(316002)(110136005)(2616005)(7416002)(38100700002)(86362001)(31696002)(186003)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHRwWTB2cU5hc1oxYU5VRllvZm9wM29yc0U5c0luUnh2NnNOOE0vcnl4Y0E4?=
 =?utf-8?B?MldVY3NYSjEvWmMyajNmZXRBK2doOER2Qk9uUlA5MUQwSU0yTDVVNGJhQnJP?=
 =?utf-8?B?emMrQitzam9vdkFveFZ0cytSYjdoU1dZUlZPR0ZqNUJwdEp4U20yUm1KR1hY?=
 =?utf-8?B?N3R1a0NnWEljZ1RyTTNBc1NxWmlCcUhRZ1dJZDlKcTJJRGhwV2tRYTJJbSs3?=
 =?utf-8?B?RVowWkdpRlNRdEM3MWJ0RXc2bE90Y2xNUzlGMWhPM3c1aVpDK3lSUWxYcUJs?=
 =?utf-8?B?KzlkcjdZb3gwTnlOdzRZSHczVUdGTkNPcWlsWXI5dkRlZ2pUWFZZckN4dFp0?=
 =?utf-8?B?Rnk0WnVuOUtkODErUXhMZVNFbXdBZTRiU04zSUFaUXVKQ2FoSkxOUzhKU2pi?=
 =?utf-8?B?eWtTZHZuQUEwbHhWSmN3UkgzYlBlMkFGbWt1UjFxK3lWdUlzeTdjWlBYaHVZ?=
 =?utf-8?B?U0EyL1dVUGt6NlBOK2RHcngxUkx5cURRN3pPdXZVQ1BPYmVGMlJOeDFlTTAx?=
 =?utf-8?B?dzhST3JHbWxLWGp0NTFzWkNlVGNBUTUzdnhibHlIUzdpMTl4UjRFZWw2L1JQ?=
 =?utf-8?B?QWFlVE93emtsU2VWenBmR01ZazJ3N0RST0xUN3doQkt1eDhqVFFUcE1xcmMz?=
 =?utf-8?B?eHhzcjBJRVFLWEhDdUpvU0RtNXNseXlMcFRMK1g2azVNMGV4enZyaUNOUDh4?=
 =?utf-8?B?M2lWdjE1UGd0MVBpWEl0bWpia21nZzVXMVdTWWR3M2kxV0ZpbHpDd0Z1cHFY?=
 =?utf-8?B?THF4VlpBSm5RSkpZWWZsNG1KZmNFVFQ3SWlNUXN1ckRiaGt0VHhBU2FaY1Zq?=
 =?utf-8?B?NE5WUTZLd1hUZ3NSV0ZTN25LZDlzeVd3UHVOTThTZ1VNTVFrWW0xNzllWUFX?=
 =?utf-8?B?MzI3NWhnZDZkaEszdHAwRERLSHZ3NE5zT2RFVGljb0xrMlk1K0h3Z01TMjAz?=
 =?utf-8?B?amZLUTlUS1BvME1xUTVMcVgrY0dUWWV1RndraTRqMWNYM1pYT1pia3Y5QW9V?=
 =?utf-8?B?bGpTTS84N3VNYTNLSmpVOG5pRFd5b3M5OFNnVk1MSGpiZ1BaNm1WNkNDZnNn?=
 =?utf-8?B?ZStKbEJxMHRKbTNHY1lNaTkzTVoxTk1nSHphWHphL2pqbGtsRW5OaHY2dlFV?=
 =?utf-8?B?NkZtcFVHakZaWWZ1b2w0bkl2UFpuRnVjdHRhbythdzk2OTJvcDd6RWhWcXdH?=
 =?utf-8?B?YWUxdk1POEc5Z3VySmJiQ01sRkNCRGduT0MyVk5OY2RhbEJtOGJCVDlTRFlQ?=
 =?utf-8?B?VGcxMFdPTmNkK0FjeHd1ejVHUFlRYVRTSmQvZnR5U2srelNQQ2NqWWdESHZ6?=
 =?utf-8?B?amhhWHZvUjdzSkpxV2JHMEM3NThzTjR4M0owczJwRWFDRUJhcDNUeUFKcmxa?=
 =?utf-8?B?anFJTllzL0grZmtXeTlnUVZ4NHlwSTlSTVV6MkhtT2pkNnJoKzdOdCsydDl2?=
 =?utf-8?B?NytaVnZMWWd1blZqelVsK1loTnZGMThGR1cwMEhFVWx3Q0N1NGo3NEliMmVH?=
 =?utf-8?B?WGdhaDFpaU9KR2E1enA0N2VDQ1pBR0hMZk1WWDN2akFWL2FNQ2tkNFJZTDdG?=
 =?utf-8?B?dHhQR1AvdkFvVVBXMFRIZFRUa0FqQlVCT3FqWGVzOVRXbzdiTGZiQ2o4T2VZ?=
 =?utf-8?B?MUFQdnUwYnUrTnJSUHBBamVHZDduWVAvMjNmdkNaVlk5d3VzT2t1dHA4Y1Ez?=
 =?utf-8?B?V2Z2bGd6a2IwTXQ3SzlWV1pJSExNNjQwbnczVDBJdWJDTXIycnV5VFRIajcv?=
 =?utf-8?B?cUtBQzVHYU55TEVpN2FJU1hsbEV3Y2VlVXplWjIvMHFucVhIQWNjY0pkZm83?=
 =?utf-8?B?WklwbzdnWWdpUk56dTdkcStmVS9WdW1nMThCUisvcWIvUk0vNUVYVjYzVXNK?=
 =?utf-8?B?Qml5MkJDSkRBVWptcE51Z3hTZkNQdkh3VlhmUCsvK3pLU0U0NzRvSUlWd05V?=
 =?utf-8?B?Nk5Sc2htSXFabUVHRWFUVCtZcVdqcWFBMEVjem13bGtYSFFTNjNnSDFwTUVC?=
 =?utf-8?B?dmVxU0RiNzA3WHZXNUZteWN6Nm9JWXBUbTh1Q0ZLdUdBK0hsOXkzRFZnT2dx?=
 =?utf-8?B?QTFjWWFOMVRsQTZ1MC9JWlpQRk02K0ZTbWFueVZBVG13SkJxRmtvRHpabllP?=
 =?utf-8?Q?Dv/ZZq7jS01uI6hL3xiPmDhlc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35a734a-d30b-4125-44af-08da9c60f689
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 06:09:09.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQ9jVxKft28ZMbBC6bl5fXHR/Wvj8Sh8tOnJRodwC/z26/4p0OiR5apJgddFToa+BYUTssibL9BBQtxPIlwAZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5123
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/22 19:22, Al Viro wrote:
> On Thu, Sep 15, 2022 at 10:16:25AM +0200, Jan Kara wrote:
> 
>>> How would that work?  What protects the area where you want to avoid running
>>> into pinned pages from previously acceptable page getting pinned?  If "they
>>> must have been successfully unmapped" is a part of what you are planning, we
>>> really do have a problem...
>>
>> But this is a very good question. So far the idea was that we lock the
>> page, unmap (or writeprotect) the page, and then check pincount == 0 and
>> that is a reliable method for making sure page data is stable (until we
>> unlock the page & release other locks blocking page faults and writes). But
>> once suddently ordinary page references can be used to create pins this
>> does not work anymore. Hrm.
>>
>> Just brainstorming ideas now: So we'd either need to obtain the pins early
>> when we still have the virtual address (but I guess that is often not
>> practical but should work e.g. for normal direct IO path) or we need some
>> way to "simulate" the page fault when pinning the page, just don't map it
>> into page tables in the end. This simulated page fault could be perhaps
>> avoided if rmap walk shows that the page is already mapped somewhere with
>> suitable permissions.
> 
> OK.  As far as I can see, the rules are along the lines of
> 	* creator of ITER_BVEC/ITER_XARRAY is responsible for pages being safe.
> 	  That includes
> 		* page known to be locked by caller
> 		* page being privately allocated and not visible to anyone else
> 		* iterator being data source
> 		* page coming from pin_user_pages(), possibly as the result of
> 		  iov_iter_pin_pages() on ITER_IOVEC/ITER_UBUF.
> 	* ITER_PIPE pages are always safe
> 	* pages found in ITER_BVEC/ITER_XARRAY are safe, since the iterator
> 	  had been created with such.
> My preference would be to have iov_iter_get_pages() and friends pin if and
> only if we have data-destination iov_iter that is user-backed.  For
> data-source user-backed we only need FOLL_GET, and for all other flavours
> (ITER_BVEC, etc.) we only do get_page(), if we need to grab any references
> at all.

This rule would mostly work, as long as we can relax it in some cases, to
allow pinning of both source and dest pages, instead of just destination
pages, in some cases. In particular, bio_release_pages() has lost all
context about whether it was a read or a write request, as far as I can
tell. And bio_release_pages() is the primary place to unpin pages for
direct IO.

> 
> What I'd like to have is the understanding of the places where we drop
> the references acquired by iov_iter_get_pages().  How do we decide
> whether to unpin?  E.g. pipe_buffer carries a reference to page and no
> way to tell whether it's a pinned one; results of iov_iter_get_pages()
> on ITER_IOVEC *can* end up there, but thankfully only from data-source
> (== WRITE, aka.  ITER_SOURCE) iov_iter.  So for those we don't care.
> Then there's nfs_request; AFAICS, we do need to pin the references in
> those if they are coming from nfs_direct_read_schedule_iovec(), but
> not if they come from readpage_async_filler().  How do we deal with
> coalescence, etc.?  It's been a long time since I really looked at
> that code...  Christoph, could you give any comments on that one?
> 
> Note, BTW, that nfs_request coming from readpage_async_filler() have
> pages locked by caller; the ones from nfs_direct_read_schedule_iovec()
> do not, and that's where we want them pinned.  Resulting page references
> end up (after quite a trip through data structures) stuffed into struct
> rpc_rqst ->rc_recv_buf.pages[] and when a response arrives from server,
> they get picked by xs_read_bvec() and fed to iov_iter_bvec().  In one
> case it's safe since the pages are locked; in another - since they would
> come from pin_user_pages().  The call chain at the time they are used
> has nothing to do with the originator - sunrpc is looking at the arrived
> response to READ that matches an rpc_rqst that had been created by sender
> of that request and safety is the sender's responsibility.

For NFS Direct, is there any reason it can't be as simple as this
(conceptually, that is--the implementation of iov_iter_pin_pages_alloc()
is not shown here)? Here:


diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1707f46b1335..7dbc705bab83 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -142,13 +142,6 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 	return 0;
 }
 
-static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
-{
-	unsigned int i;
-	for (i = 0; i < npages; i++)
-		put_page(pages[i]);
-}
-
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
 			      struct nfs_direct_req *dreq)
 {
@@ -332,7 +325,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 		size_t pgbase;
 		unsigned npages, i;
 
-		result = iov_iter_get_pages_alloc2(iter, &pagevec,
+		result = iov_iter_pin_pages_alloc(iter, &pagevec,
 						  rsize, &pgbase);
 		if (result < 0)
 			break;
@@ -362,7 +355,16 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			pos += req_len;
 			dreq->bytes_left -= req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+
+		/*
+		 * iov_iter_pin_pages_alloc() calls pin_user_pages_fast() for
+		 * the user_backed_iter() case (only).
+		 */
+		if (user_backed_iter(iter))
+			unpin_user_pages(pagevec, npages);
+		else
+			release_pages(pagevec, npages);
+
 		kvfree(pagevec);
 		if (result < 0)
 			break;
@@ -829,7 +831,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			pos += req_len;
 			dreq->bytes_left -= req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		release_pages(pagevec, npages);
 		kvfree(pagevec);
 		if (result < 0)
 			break;

thanks,

-- 
John Hubbard
NVIDIA

