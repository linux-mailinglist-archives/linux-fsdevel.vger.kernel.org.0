Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555A752DB82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242943AbiESRmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 13:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiESRmJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 13:42:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE230633BD;
        Thu, 19 May 2022 10:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx/tgRpFGITOct1z4RmyfW6uJmbySTqbe+DwqpalAAw5KywF5HldubeJD+0ybhxRbtzQi0L1FIr9/VCctPvSGMqPcAg3osc9erqgu8Zotd9Ub7kZZJQfS2W9b9QPgFmfBe3o+IyGLDhCcvxntqKoqsd0d3L9rcZaOytkbBkLjtq0w3DRVdf5+RbOFB6CJVnJr3qfIU9Z6hI4goyeVwy3NjXwcfwZpOi4TZZHuG0FdwrIzj10BvzL0Th1PfGphFh8g7ertnNxz2wwVjjYT9WVSIMWjlHq+z3jMZsBHKWSMWdwojHnX/UNU+Lq/R2xTFGryTEd80sXRHsMhhky64KFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSTGh1PXB9gDI93lnePFZrsbfQTxKtto7q8nRU918ls=;
 b=gVg9Oc+1tH7sLJfG95bMU0cBhNXWiy/Pjqh8mm5gXAXsxhy5X5+rlDVwnLJFv4bUSTBUUqIWMArmTdXFjmVrz1ntXS7ePm44MoORszYVITMGIqtHr5Dypxy9Usccc34v72bTPmPr7SSoEkDI7VFKfyA86rT2m4kZ24aS7oUGpq/Mi1HGkcGXgwqB2kuq1D6bnzYGfPrU3BryJCkDbjT+wQwRJJNpwn0+7UXRkiBda40MnksSwIqgpM+0RH7JwIpA3JVGvNtQEhmZlC2h9BePsyl1Tz/vsxxLXOdm7GpijWQVmhJ108kjDKN2SgPqbtXaNAgVqwOehaZUyCTcC6oQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSTGh1PXB9gDI93lnePFZrsbfQTxKtto7q8nRU918ls=;
 b=a1//eFmjHvO8hTL1QbU3L3rTMabkkc6/zOSE4w/py9szvNXSi0OKAVyrbawEzRtawnxvlWPa34nS3spL4STL4LP/DejH1hRMNaTOVQ/l9esAqLm6BQN89cDyRVNNDDZ7A3xMcHwJyziIPRYGsImhPRkr4r++Ez0DUz6/hclzMP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DM5PR19MB1275.namprd19.prod.outlook.com (2603:10b6:3:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 17:42:05 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a%7]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 17:42:04 +0000
Message-ID: <f3555e3c-06d9-4d19-d3a2-9a2779937e83@ddn.com>
Date:   Thu, 19 May 2022 19:41:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dharamhans87@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::22) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0363e51-57c9-4311-80b6-08da39bee320
X-MS-TrafficTypeDiagnostic: DM5PR19MB1275:EE_
X-Microsoft-Antispam-PRVS: <DM5PR19MB1275A79B8AEE958C7EC43E8EB5D09@DM5PR19MB1275.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpNVFy7VkGRd/fKVNwVLGqMg5MUEQgr35sJ91027NAu2WjiuawJ4EaZ+FGtSvobs48bb3TLrjfQlTUhT+yJ0sm+iIqui6hBeLNyujPjVjg2wkK9iFsXHMipsDirL9/5gKZZ7ib1cUXyk9JkpacH/uBW1rtiQjeZvKW/3CF5NSpg5FewrrD+N0FovlbO+Je4iXB6RXgkEXP0YtDvS51/fghaFP6RNRAEaCjr7UMl6+qGkOEeAcwFyo7BNlvFqfb1Pe+lMdBZvvSb9H7RUcMQ1hKfjr8BfxKjF9izGAgqfGED31Ss0XehTW1BObiZckxnxxT7NI3ZVb0aLLnWI6Y35Rm9ybiGkrj5lJ6tKHT4oUVKvh+BkvQxN2qy22CikxOq5+AAii5N5miN1/wvVFARRGeogTjzf75uSicZsdzLR6tK2DM+iXh0eZXFqsLPWV7k1cbLmTIbOLI/g1r+zSDPrel4XoLASLz6vd1OXhT6I03DKP+uilW3OXRZeuPROYzX7XubK89C1R8hOHh6V8NFzuJdkL5l+356GOXSndZxmISECQcKIHh4SIKmR2+B+HPQvyacVFNNhAie7Rd7IAIwxSDjcnF455yk35Owo98hDy8wq4MisYH6x09W8s6NCgcmhHN7cJIX5ZCWfeCTXLsWsmDaqJ1d5IGjj9ABb/yBzMDUJtRMbcNrbmnEFm7vCWx+qjVGtrWNTdbn9blF9VrsHYfTOV//szInNd+E9cdLjPk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(84040400005)(86362001)(31696002)(38100700002)(36756003)(186003)(2616005)(83380400001)(31686004)(6666004)(5660300002)(508600001)(2906002)(316002)(6486002)(4326008)(66476007)(54906003)(8676002)(66946007)(26005)(6512007)(6506007)(8936002)(110136005)(53546011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2lBbWt4T0I3SmtIMVdDcm5SRlQwdXI4OUVKemlqMS8rNVBNc1dRNDlpNTZE?=
 =?utf-8?B?Vno5MEErZzQvU2Z0VWFVV0ljVDEvVE03akpRVDkySVYrb0RVUkhGeXp0T0NC?=
 =?utf-8?B?UkV6RVFNaDFmRWhtU0JCWDcweUFZQkY3czR5WTNzd1g1STFHaTM2M1dMc3Zq?=
 =?utf-8?B?MFBPWjd3UmdiUGpTK3ZCWUtheS9STzN2UlptS0E1SmNHbjl0NWFyTGpCcW1N?=
 =?utf-8?B?ZUtjdmMvdy8vY0ZlWjZYUHpmaUVEdkw3WnViaHlaamxYNXdUcld1V0VTZGxE?=
 =?utf-8?B?Uy9DcldseFk4SXl0NzFLWFVjd0xNNEFEcVo0WWpiY2VjOXFNenRlejV2UllL?=
 =?utf-8?B?R2RvRTBXN3E3S3hZUjk0bTBoZmFmTEI3RFA2TnJlRkdQWHVQUjhxNDF0TVFQ?=
 =?utf-8?B?clk3b1VjOHRGWkk0bUxuSjhBUmhBc1JhY2xNTnBtZFoxVkkxdEFab3NZUTR4?=
 =?utf-8?B?emVCeE1qOHJrOXZWM2thQjhlekZpMkhjdWQ0Z3liR1lhazNFcjRsa2lydHVF?=
 =?utf-8?B?WlJPbHNPTXlDQ0plaDhzdXoxalZSQm9hMVNHQ21zSkpmN05rcUd6WnRGR3Zm?=
 =?utf-8?B?dm1HVWMxc1o1Z2FNbDZRRmJROVVsRzdVNEFmc1J1WGc1c2JudnRiMUoxYi9S?=
 =?utf-8?B?NGFSTis2RXdJSEV4bzQxL1RWMHZKVitsdVAxZVgzOFhoa1loYkI5ZTdtMzl6?=
 =?utf-8?B?bGpDaVNtdktSemNXSis2K2pIOHJ5bWJuWGk4d25lbnRURnlRUUdRL2F5aVY3?=
 =?utf-8?B?WDd1TU5PNnJuc0s2KzRwYnVpQ3FTbG8yOWh2QkdmQUxUVW56THQ1d2d5NzB1?=
 =?utf-8?B?SjB4eHI5QmNrb0RvWHlQelZGVUhGcGFyZm5peUl5c21SbE5Qd3lzU1JaM3ls?=
 =?utf-8?B?UEZIRUpxS0FhTTExYnlIQS93cW9jTjJzeHpUdlBEOEYxWWpsZEZ4cXkvdUcx?=
 =?utf-8?B?RncwUTZWbkpQSk9menJPMGxkZ2JxUEdEbmJFYWRTMmNaNCtzUUt2TkIybXUr?=
 =?utf-8?B?UGxtbVJoUHJTYUpjVXJHd2NXa1VCRzVMK1BIZVUvTHgxaDUyMkg4SGdHckRw?=
 =?utf-8?B?RnNlS0Rlb3RqM1RCUTl1N1VQbXdDVVUxUDBKT1F0dWt4OWdQcjNya1ZwaEg4?=
 =?utf-8?B?WTR6aXFDL3ZwK05iUVZENG4rdnpRbTRUL0owcmMzWHJXK1ZVY2QvUGZ2amZ1?=
 =?utf-8?B?UGZDVTl4S3RjQ0dDbmZBK200eXIrOFhBNU9NMDVpZ2lhdkxuSm9IbVJnTitV?=
 =?utf-8?B?S05kNGk3NXFaZzl0WDBMM3JZQ2xUQWhuL0VsdlpZWkVmT0prK0hNN0Y0VkhJ?=
 =?utf-8?B?UkZoVVlLMHltZit2LzRpUDFvSXVaR1BUVDlKSktSemZrNjQ0SEtDVzlJOVZa?=
 =?utf-8?B?ZlM4YVo2Q0hBZ3pjRUgydktVdlR0MlIwR2Z4TERYZS9SQm9aTXhlWWJZaU81?=
 =?utf-8?B?a2g1ZlpINS9BYUNpejlQL3daV3p2T1hwRWpKbDNubWpCWHo5eXR4SFZTNDJD?=
 =?utf-8?B?TXlPK29LQWVFdUpyS1JpTGMvVGNsUzNvZENMWm5BUFQxZ1JrWkRUR0kvQUt0?=
 =?utf-8?B?N1FJSjZRVjJTalZSR1FVQWV1OFFlMER6TXF6aTRxbGh1bmdIaFlsZE5UMUd1?=
 =?utf-8?B?cEdlU2c2WCtTZ3BzR0VSNXBPbEgrdVlDVXRCVzNidWZab0V2cWdtbXFYZEJC?=
 =?utf-8?B?UVBNSVlnT3NaY1BLbS9QY3U1SVRuSCs3SGN3VDlZa09zaVlZTUNYOEZabHlV?=
 =?utf-8?B?THhtTTVnaDdNTlcxRVI0OVhsNWlkQTVJT1BJSkp1Qmo5M0R1TDJyTkVlMXVa?=
 =?utf-8?B?NVRVNVRFL1B3Q0lzckxoSXlOYVFYRldwckVZQS9nbGlldVNiRkVJLzhEVHVV?=
 =?utf-8?B?NWxKaTdyemY4bzA4Z0VGbVZWWG9KZzVEOGk1QXptUzRDcksyN2dtVlkxRHVo?=
 =?utf-8?B?Tld6cVM0K3lsQzhtZXBWVTlXS3cyL1lzYjdBODhlWmhUNitRaWlmQ01RRW5X?=
 =?utf-8?B?SXZRdjk0NGR6MnhJa3JCRk8wTFBkMkxqdThMZS82ZzFubkphMWVGTG9oVkFu?=
 =?utf-8?B?SUpJcTlJNXZick5yNTRISXZNRlJ5aUFQSnhpRi9kN3hrOWdLZW5EbFlWVGla?=
 =?utf-8?B?bW5qOHp6eXJXdVJ3MzUxajI3YTB0blh3NUpYRmQ4Q2gyampTVDlKUlliL2Q1?=
 =?utf-8?B?ZlVOaHYzNVFnaTRCSklYejRKVlJtNTFCUVJzcUJ5bmd2RHFlRzc0NEFTSXNV?=
 =?utf-8?B?WStRMXBLMjJ5K0xnU3pFNy9IbERBaWh5dEZQV2pxN21uMjBuYXBuNmt3bFBB?=
 =?utf-8?B?dklpRE56ZVRpSnFxNi9vQm5lY0dvM3VxZjYwek9ITVBHZlR3ZFc1UT09?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0363e51-57c9-4311-80b6-08da39bee320
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 17:42:04.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUSb+Eigsyb1ebUf+H4NqLrcthdA8EMb49GM8pJe7hU5xTFxRgQEapSy6GXyx5F4Ii68a/sadoo8VgKHJ81P3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1275
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/19/22 11:39, Miklos Szeredi wrote:
> On Tue, 17 May 2022 at 12:08, Dharmendra Singh <dharamhans87@gmail.com> wrote:
>>
>> In FUSE, as of now, uncached lookups are expensive over the wire.
>> E.g additional latencies and stressing (meta data) servers from
>> thousands of clients. These lookup calls possibly can be avoided
>> in some cases. Incoming three patches address this issue.
>>
>>
>> Fist patch handles the case where we are creating a file with O_CREAT.
>> Before we go for file creation, we do a lookup on the file which is most
>> likely non-existent. After this lookup is done, we again go into libfuse
>> to create file. Such lookups where file is most likely non-existent, can
>> be avoided.
> 
> I'd really like to see a bit wider picture...
> 
> We have several cases, first of all let's look at plain O_CREAT
> without O_EXCL (assume that there were no changes since the last
> lookup for simplicity):
> 
> [not cached, negative]
>     ->atomic_open()
>        LOOKUP
>        CREATE
> 
> [not cached, positive]
>     ->atomic_open()
>        LOOKUP
>     ->open()
>        OPEN
> 
> [cached, negative, validity timeout not expired]
>     ->d_revalidate()
>        return 1
>     ->atomic_open()
>        CREATE
> 
> [cached, negative, validity timeout expired]
>     ->d_revalidate()
>        return 0
>     ->atomic_open()
>        LOOKUP
>        CREATE
> 
> [cached, positive, validity timeout not expired]
>     ->d_revalidate()
>        return 1
>     ->open()
>        OPEN
> 
> [cached, positive, validity timeout expired]
>     ->d_revalidate()
>        LOOKUP
>        return 1
>     ->open()
>        OPEN
> 
> (Caveat emptor: I'm just looking at the code and haven't actually
> tested what happens.)
> 
> Apparently in all of these cases we are doing at least one request, so
> it would make sense to make them uniform:
> 
> [not cached]
>     ->atomic_open()
>        CREATE_EXT
> 
> [cached]
>     ->d_revalidate()
>        return 0
>     ->atomic_open()
>        CREATE_EXT
> 
> Similarly we can look at the current O_CREAT | O_EXCL cases:
> 
> [not cached, negative]
>     ->atomic_open()
>        LOOKUP
>        CREATE
> 
> [not cached, positive]
>     ->atomic_open()
>        LOOKUP
>     return -EEXIST
> 
> [cached, negative]
>     ->d_revalidate()
>        return 0 (see LOOKUP_EXCL check)
>     ->atomic_open()
>        LOOKUP
>        CREATE
> 
> [cached, positive]
>     ->d_revalidate()
>        LOOKUP
>        return 1
>     return -EEXIST
> 
> Again we are doing at least one request, so we can unconditionally
> replace them with CREATE_EXT like the non-O_EXCL case.
> 
> 
>>
>> Second patch handles the case where we open first time a file/dir
>> but do a lookup first on it. After lookup is performed we make another
>> call into libfuse to open the file. Now these two separate calls into
>> libfuse can be combined and performed as a single call into libfuse.
> 
> And here's my analysis:
> 
> [not cached, negative]
>     ->lookup()
>        LOOKUP
>     return -ENOENT
> 
> [not cached, positive]
>     ->lookup()
>        LOOKUP
>     ->open()
>        OPEN
> 
> [cached, negative, validity timeout not expired]
>      ->d_revalidate()
>         return 1
>      return -ENOENT
> 
> [cached, negative, validity timeout expired]
>     ->d_revalidate()
>        return 0
>     ->atomic_open()
>        LOOKUP
>     return -ENOENT
> 
> [cached, positive, validity timeout not expired]
>     ->d_revalidate()
>        return 1
>     ->open()
>        OPEN
> 
> [cached, positive, validity timeout expired]
>     ->d_revalidate()
>        LOOKUP
>        return 1
>     ->open()
>        OPEN
> 
> There's one case were no request is sent:  a valid cached negative
> dentry.   Possibly we can also make this uniform, e.g.:
> 
> [not cached]
>     ->atomic_open()
>         OPEN_ATOMIC
> 
> [cached, negative, validity timeout not expired]
>      ->d_revalidate()
>         return 1
>      return -ENOENT
> 
> [cached, negative, validity timeout expired]
>     ->d_revalidate()
>        return 0
>     ->atomic_open()
>        OPEN_ATOMIC
> 
> [cached, positive]
>     ->d_revalidate()
>        return 0
>     ->atomic_open()
>        OPEN_ATOMIC
> 
> It may even make the code simpler to clearly separate the cases where
> the atomic variants are supported and when not.  I'd also consider
> merging CREATE_EXT into OPEN_ATOMIC, since a filesystem implementing
> one will highly likely want to implement the other as well.


Can you help me a bit to understand what we should change? I had also 
already thought to merge CREATE_EXT and OPEN_ATOMIC - so agreed.
Shall we make the other cases more visible?

Also thanks a lot for you revalidate patch.


Thanks,
Bernd

Thanks,
Bernd
