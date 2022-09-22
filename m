Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823CB5E5708
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 02:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIVANj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 20:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiIVANf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:13:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C24A8CF9;
        Wed, 21 Sep 2022 17:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWcpOijaAdF2fL6/OJLZQkFstaCUP/0R2zvodOSSucaznz4r8UhGaGDy6SmOZkZabqTEg3uznQbpRGojgyF8nEiXvyu572j/Znl3X+B2LQK2MBkYv67fGOoP9O2ygM9wE4aAd0xFZAYMiURYISe0at8ec2wCdy+IBKOpFgMmlvFfp7tBNP3074fGjcxUXcGuh72YkBjkUPHcuqpzxv7Iax8dxse4FSb8pRU5HgUAIEbvnvqGAYgQDkJuAfwjKldwI9iO7YtqAlznYlJ5f/5I7E+VRW89VNcQy7QxgIK6j/tHIIsIVjKdwOu+Kjv4qIJfwnqjsZ5g2oWDRDRZcpaRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxbMxmBqT400/z6J+blGHftWBemfIngls5C5GglWG7U=;
 b=lCA2AtffO94uP38zMh1q43cYjHZaTJ34cUYZtx9ToiyLmXDgV6Iyp2cIdM16u7BscbggxCtYz3dbJXFKoHFJeVRFHpHI0I7orIttPSolFxjEPEVd+RREgK+3mI92Go4qVknG3MDRE9ZdlMKPKZd+FImrqw/pSqBpFajgbJT8aMNrFBDi4gYhjYTmeEu8Ax6gbnKRNFUl92/0CqKEA1cZVhJ8CdfaMUXDs6ypZN8zdd0YziLf4j7SghTKwcX9Q/fx9ri1R9+nzDHHZ3RUkKMiLGTaVlb3qg+wgQNE7Lo+LWSYB3P6nkZpNRxgW6zFITMsFSMG49z1MpWBtNOZKNaEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxbMxmBqT400/z6J+blGHftWBemfIngls5C5GglWG7U=;
 b=Ec1FCAhxx97aYg5bBBJC0010/y/DByCXLYIOCPRfwtyHUCo5clJaqmJvEKKKGEX69AgG32jvp7/n4dihj4nil8Pe/tB6TEcO1M4FZKOge1q/eimEhFAIK9gaGrvaQQUEkZrSAiZalDdIlyE3pYlqA8QjDUaQsawwJOkFGk+GWYM93lZcr+HeWJVzw/EwqVSzyMVZY5IU8PD+R5SiTEugHi84YuZmON04obaq8b2PWQiSdSsbbz6+oEu4y6HdoowunVQNNEjT5p9jmIFA61pLy9/9sIZ29VEr4oHCY1uepFN/yrrAbCCFIfchOJHhq8EQFpdmnCzZdLv2qaVJt8AOTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 00:13:33 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb%3]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 00:13:32 +0000
Message-ID: <f562bd43-d9bb-af27-0d44-af7902ee15df@nvidia.com>
Date:   Wed, 21 Sep 2022 17:13:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 16/18] mm/memremap_pages: Support initializing pages to
 a zero reference count
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
 <YyssywF6HmZrfqhD@nvidia.com>
 <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::12) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|DM8PR12MB5462:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d8de5c-b5dd-4675-9986-08da9c2f48e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CW6D6Ro5IdXs+opNfqNVsuJ6v5gWV8TWAHOaVHVSIFBUxaXFQ64h928a6Vr7CGZuz4dUiOVwRU0s3glvQJipuJoN3bU0N+w3wnooP/+dO4uUXVjeHkhwKSeuRIzxRMHWv5jL6ejjEXwjwjJthq73AahCE5IgiAyCPnOXL1fS5N4piZpk7ewY8xoY8RNkP8WGBSN3MlKm4mHRDYfpCLcokpoWmyAbZDu1gXcBok1CovgbJsOhjXOTYOiU7co6z1KS1j/e1+uZSYz9HekzuJ9HmAbRc5HrRDzNcKIh8s48apk4x4LWcEvB0a51P4exkMYkmZRV06alXSE2/Z1WKEygQlqNVnn+pdzkGr6X7RK+EmZV1w0N7MeGsidaZ2gtGgM4HalKlveHizfOVK7hTvfLmvBvhGPaSqg7i/lXjmVqDdjwFZF5lI74keZ/oSvMVA49+4BJKM+GQWD86mVePf3QxLd+JEwFzSZ6eG+h7CcvYsQlfez6CQaLv2WnSW3u4fSyLkYNGQIxoPN4z9zdR6XGgn9LwWG2Rp5r4We9BKLUg1uHnlOwOISwOcOt2B2QUWJLV7AfqXfrr75QF45y14yxWNlP4MVq6kpBrUiqZfPEdP5HprQ847HjQmDNYLaYemZQVwv4mGkOfu9AryUQvA+lMWYK+mpuGojHhNCbVQ/k7f2tk5E6IvkbK2sDhRoNaSC0ZB8twWQtHWy01B4rit7Y2lO7WrK7ze1QG8Ec10cctU/nwzIvtdAclPkHxmzqtiZVSU8UHFhqr/7++MXeoYCse9w0udDKBVjHpspwsP0xEIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(6636002)(6486002)(478600001)(186003)(36756003)(8936002)(83380400001)(2906002)(66946007)(66476007)(66556008)(4326008)(38100700002)(7416002)(5660300002)(41300700001)(110136005)(54906003)(8676002)(86362001)(31696002)(6512007)(26005)(31686004)(6666004)(316002)(53546011)(2616005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnBpKzVWeCt1TWJ5N2RseVZjWnkxcTljSnJocU5zSXVUQllvMmY5c25iTjRJ?=
 =?utf-8?B?SG1HR3lLcEk5NUE0ZTk3ZCtvcHR4ZEVvdllvRkZMMU5vN3hpRVJ5dDdqMURu?=
 =?utf-8?B?SzB0MitqUlRnZE1WZFcwNnprc0U4d3p5TnNnTlN2YlE1enZUekxpL2VKTENi?=
 =?utf-8?B?bnZJdG1mcW9PMkFkM2svN0ZLQjUweWYvRW9PQVFOM3VmSDNZTXdJd21JakpD?=
 =?utf-8?B?NlNVUUNEZWJNa0NlaytoY3BIR1EwMFp0Y0RFbWpTV2c2Q0RDNndHSnhySGZC?=
 =?utf-8?B?VEsreGRMSlE0SEg5RU1hOWRYT2NQd05NYWhZSWh6cHdyQWE3WUZ0dWx1alAr?=
 =?utf-8?B?QXZBZTIwVzIxMVBPMlBNS0RMek1rRnZOb0NHUVZOQVVDOVFxL0dlemdiQ0JI?=
 =?utf-8?B?eUNnKzRROUpRMUpWWVdkNVR4azQ3OGRoSFVtMXZsUGVrS0Y3Qk9WSDk4UEZz?=
 =?utf-8?B?YWI2b1JRVEJZSy82Q3VEVjh6TU9VbVQ5djZWYmREeFdFRVUzVnE3WlhGcnZq?=
 =?utf-8?B?VDl5TEwxWEowMU94c2lsRWZDV1dHS1ZLWCtkQkQ5RGlnOUdxQkRiQi9mbmVa?=
 =?utf-8?B?d1k0K3p5YStEOVdHcjNCVllteEJ0dHJWV3JPVkN4TGFUc2twZ3dCZ0RMQndL?=
 =?utf-8?B?Rm5FZXIxQVErK0F3WWpyR1Nqa3dpM0hyTWdRTXhSeVhialA3NVlySlVBR2hP?=
 =?utf-8?B?YjFYSGJGV2l0OE40WEdoWHM1VmlhdTd4MVBhR0luRHh6MXBKVzR6NHlYYzBE?=
 =?utf-8?B?aDhNTGVtN0MveEJyOC91NEowUkRnMHJIemovdFdKbUo2Mys1RUx5TzV0QTcw?=
 =?utf-8?B?eG8vWit5bHpPQzdueUhRdTdFQ2F0OUd6QTdEVW5qWkVXa1kyMkRMU0dtcFI3?=
 =?utf-8?B?OUFqZGFKTml5NlUvSVhpR3lzWWFsc3ZKaENkOEFOOGtUaTRiZWRUWGdIalFm?=
 =?utf-8?B?b2o5YkY3dm1UaW5ncWRxUjkyUWRpZm9FMGE1VlE5amM4SUdVa3A4U3pZWml1?=
 =?utf-8?B?UTBWNm5yYjhFUnppTzhhQ2kwTWRHRU40aVhVZVozV2ozRndoOWltbjVZY3Za?=
 =?utf-8?B?NzFkK1RERUN2T29CbWdTU3FKeW04amFaV2J0UVVxUjdYTCtYS0gxVURkclFD?=
 =?utf-8?B?dG9zS2hTZ0l3VXdSa1NiaC9CN3liY0JQL1IzM0xmUXFsTi9PSk1ZQjFHRU5i?=
 =?utf-8?B?dkNWeHgvVnVPd2FUVktMb2xTVDNMMTdaWEo3NFdFYVJlTks0dkkvR2RQY0lC?=
 =?utf-8?B?bVBYOVFqd0VoWXE3eXVoRlhZQjJteFEvSmQydUVrSnp4MW1vR1BOdEUwSG10?=
 =?utf-8?B?QjlmK2dSaXNDcE13ZzlEUkV2YyszMFlNa2lqR0R3cjN0YVA3QWg5Z0pqSm9R?=
 =?utf-8?B?MktObHFYZzR3WWo4OWlIOU1PNHJzYU5IQkpIKzZYZThlbXV2cjFlWnoyMmIw?=
 =?utf-8?B?Y2x0Myt6MnFJUkwxRzZUZkdnTnAwSW9jT3NtY2t0QmlZeHltYkNYV2NyMXli?=
 =?utf-8?B?SExIQUFoYzZwMUtBL3ZZb3RJSDlmZ3NVQUErWE94L1h5a3hDeW1rR3o2eGZK?=
 =?utf-8?B?NDMreFh1cFRXeTBlVCtheGJVekl3TWlSdUVCZXVtV0xESXlmMXVWU0crS082?=
 =?utf-8?B?NUxrYjZoNm9yN2x0MVREQ011bmNQdFhYMVl6QmlkU25VVVAxNXR5ekpPdzJu?=
 =?utf-8?B?bldCTGlxSG5hbmNrQ25LTXBwb21XT2xUanNMbVJxcmNpR1JLQVpGVFM2RFFK?=
 =?utf-8?B?NnB4RUpIV0Z3VXh3VmVPK3lzYUExK0tObkJSWTU4eEFaTE1sWlZ1MFAzazVa?=
 =?utf-8?B?ZHlKS1dWOURpejZ3OCtTYzRKbGx2cEZZZkJJemh4S1lwdzZpWGlidEtLd2NJ?=
 =?utf-8?B?VnUwV3JPQytERmc2YXp2RUwxOEVMbUx0aXhiQlV1V1pNazIwUlE1NkZvQ2tB?=
 =?utf-8?B?dytFRnc0dG1Ba21QcUJDUDhtL0VvNFBNRCtoRnNXY0RuaWNGaWYzN21jRmdl?=
 =?utf-8?B?c1JuNjJxakFxT3h1VDBYc1IzR29ZekFKeG5qcERmNFFpWGRsTG1hbXNZQUZz?=
 =?utf-8?B?U3RRLzdQckFVSGJjcy9SVTdjcG1JeElMR3FYM1ZUeUNNSkpwdlZmNTdXakpK?=
 =?utf-8?Q?UUtGB3jTvSkNDnakLyP/eXceT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d8de5c-b5dd-4675-9986-08da9c2f48e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:13:32.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvrExU30K/fzYImpq2aDEg/5i6YGbVzTX2fnUaOLpyKYVnN7DVEh2slX+YvgBuiOjrsNj4IzdYr3SYT36dVgWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/22 16:45, Dan Williams wrote:
>> I'm shocked to read this - how does it make any sense?
> 
> I think what happened is that since memremap_pages() historically
> produced pages with an elevated reference count that GPU drivers skipped
> taking a reference on first allocation and just passed along an elevated
> reference count page to the first user.
> 
> So either we keep that assumption or update all users to be prepared for
> idle pages coming out of memremap_pages().
> 
> This is all in reaction to the "set_page_count(page, 1);" in
> free_zone_device_page(). Which I am happy to get rid of but need from
> help from MEMORY_DEVICE_{PRIVATE,COHERENT} folks to react to
> memremap_pages() starting all pages at reference count 0.
> 

Just one tiny thing to contribute to this difficult story: I think that
we can make this slightly clearer by saying things like this:

"The device driver is the allocator for device pages. And allocators
keep pages at a refcount == 0, until they hand out the pages in response
to allocation requests."

To me at least, this makes it easier to see why pages are 0 or > 0 
refcounts. In case that helps at all.


thanks,

-- 
John Hubbard
NVIDIA

