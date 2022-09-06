Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6665AE0C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbiIFHQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbiIFHQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:16:19 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3528A6E2C3;
        Tue,  6 Sep 2022 00:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jgp+C7TlWkPQW4N2/GXwrAjfyshLmPgFHouqJXtWz5zcfr5vmNXwsjNokJAgcOB8T7w+bix4EbLseW/KgjkLUxb4ZG3FY1FxNahVD6BD18Dk8MOMLOEyuAP7uL4VfQkMASA8+vaJ+QnvnwfYqvvopnXjIqUrr+uaTmJUjrFLkZkw2DYEYXsupLcn02dtFYdAp+5VHnVENQiVEbn4FSuK2FSGF482opE0O1cZ6oC9Zxc09xGCHM/gYgqFSRaY9aDdBY/O4h371b+VsOCsyQiHTSNZXEMh7FCl7qahBwZd1hicIzr6hCJ0XKemU47EmeDBnjrIogLVUNY4JQKo+PKggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65anH7Z2viighy9tuY4N1YBzgpaX57Iz5EcL43ci60Q=;
 b=XbhqyozhrvccjDQMr+Mleo3Fjl4Jc86nlAmv69ka7p9yEwL2rn8OduDlAA+Ds6/ZcTqreknVu/Ohg9OVpAh7D/rI2Tum9s7ZF3i/wGhG58w0PS5mO35MOzmY9Xd7wN1hd3g5Oq/6zq14KejWEu/4hykHY81Kfy5G6atc2cZBTBBDuY/ROA9cJYcuQoHV8KaVRyQrnMNZI4Wzki2WmcnNBqyQWq4jYFyWoaYcc269A2rhS8o20A7WGIM7ByYNcIGXNooBMkaZrziyFONWrVialuGIHBGqpVblhCFjCPBLFcrmD22k3aUGO1wHIzDzZqGTVR9VdjxHx1VGiOLLt1GAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65anH7Z2viighy9tuY4N1YBzgpaX57Iz5EcL43ci60Q=;
 b=ZaFsqm5B20FYM/e3i76IpNHCEgtiSIv1mpIU7ArcEGnyxJGJeI8jeZqZ7lvrhJRi5ghSTDNuZelf2lKw6hj3vqDYvV/s91rqiZ5LHzXRWm2N9eHkKQLC+0dYsXtVcAxC6sWXF5E39n9hwndBkkCkh0Y0VR8r2Ktl3Zx/j2qTwyYllLthHvrqpnJ8CdQkmyt2YCBAnTxBJzMNldfpwJb2A/zICm8ZPXtzxaDB77QtYJaNUolfsiteh/PAXjYuJf+H4rSHdomk5D8rW7tPO5Bzi1GGq0ut0tm7nn0fpOwYUv0IzrT9Vgg3oUnjFUeIims/VYIkzYp+hBPHJux5rBkKSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 6 Sep
 2022 07:16:16 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 07:16:15 +0000
Message-ID: <37817ef0-88d6-e12d-3576-50e79ef02883@nvidia.com>
Date:   Tue, 6 Sep 2022 00:16:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 6/7] NFS: direct-io: convert to FOLL_PIN pages
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-7-jhubbard@nvidia.com>
 <YxbtjijmfGaKIbIV@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YxbtjijmfGaKIbIV@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:180::17) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 790397bf-479d-4a10-9ea6-08da8fd7af7b
X-MS-TrafficTypeDiagnostic: CY8PR12MB7586:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rg9CkLndOLL0IQTzORCD+MP+IDhoMLJXh/wSTCodLeRCzV4egWosHdBUlJ8YczuApT41//y72W9OPs8Z/GvRE2v/LXUrrd6th8WDtYz6GOC7h+S3G37RYTJzTPQ4TQkWu1ZD6qA1eThtpxV/j66s851gIY0tcuWkAcJJuXzprKPZu6syCb1wfH9GYBQM7TlAj771LRmua+o2f2Kp1ePmdxd/tNKPfAdusq7JTUtQM2DjdNuM34EkrsRvyWJt/xN4WAlLcOYrDYyk0nmOmmdRFO4gyqnFV8mg+dnHkoMerDXpZdhfZ7IQfd04QjkpuRVcn8C8qmAcOs8BB5uKhyEtdjP8SMp7hx7b/D70GVDGkSPnsyShb2x6GiZSxqBqK3Ds48hVu9MEtb0XCrednYfsF/jRpUjzOej6GOG8duI5SKcF/2TIaPJaRAQTsAruKGD8uw+qGdp3O6WdKTPOcDJhqyQhWne+F8i6urpjFAd2fOOoVU4kbrG12Sz9HbxKs5cciaKSYfLMQfSp8lHZPuef2QHunJZu1PTNYbsg4W6aWBjenhVc3jAP1QwpZP56G2JOcK+Pm5BtS7D7vRMVpxoVe2xYNdph6UqJYR+24SwdQJXGDEm9sTUnJbcU9xBQ9uUV95Ze/cj8J/6Xdtk4Nk/8Ml841a4NEf5KFTv4W+v3K2yT7szCjRJt8jEhHDQpvgxArC7WyQMcAA6pLF/ycqKgH0VwrFVQ0hVFFg3JxF5/L1HvtLtUIiaJAQ3yMsv98uorcvHPhsekiO3rAPaI5lozjldUQh6hb9Q2Yy7jAmgt3OA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(6512007)(36756003)(8936002)(5660300002)(6506007)(53546011)(186003)(2616005)(26005)(7416002)(4744005)(31696002)(86362001)(478600001)(6666004)(6486002)(41300700001)(31686004)(38100700002)(2906002)(66476007)(54906003)(66556008)(66946007)(8676002)(6916009)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amE0aXBTWDd5K2NrZ1BlelpMZm5VbG83WFB4YWp4YzJtK001dDN6NDJMbXNw?=
 =?utf-8?B?MUlRYm93aWJwWXl2anFhTk96VWxTMTRZY1ZzbnJYT01hNy9NWTVUeHgyeVFJ?=
 =?utf-8?B?ZEc2Wko5NHdWdVBqYVFuWGtMVzlyZHg0WkNVYkRiME1CMkdyaTBtS3U0UGx6?=
 =?utf-8?B?N1p2NWo4WWJZQlVSSWtzanhBelhTTlQvaFRYa3lWQVpTaG1OcGFpMUxjaGxh?=
 =?utf-8?B?aEdza1VnTHpxUUJVbmZwT0h0R3Vla2xzVWlteDNIeEtmYW1CS0plcHpGY2RO?=
 =?utf-8?B?Nk9ackowdDU3V0ZkNUJHYW1kVlBYTHY0NDNwcEhDMmtYa0J6NTB4WTZLYUVH?=
 =?utf-8?B?OTdyMm4xdG16VTBKSlVoSFdrZkZiRVhmcmlraEZBQ05lZUtrVHJCUlFDamR5?=
 =?utf-8?B?TlJpR3pzeXZOMGQrRTBGbFU4SDN3cnBJcGFKRVFWWG1vbnNjcmQrTXQ3a01q?=
 =?utf-8?B?T2d5Qm1rMW9kQnh6ZFlyK3F0WjAySS85TWEwZnFYOUlPeVgvdy9zS0RmSXBp?=
 =?utf-8?B?N1lXSnYxTmJ3MjdlODFhVE4rRXo2NktjOGZ6NVdIVW9XWHB5S1NUSmd4L0xI?=
 =?utf-8?B?NzVPc0NpSHNmNXlrb3lVdnlrU1RhUVZvVjFkNHAvMkN5YTNuaUJEeHZuTnox?=
 =?utf-8?B?ejhRVmhSYjVWcktnNHJRRFozY2ZHdGxBdklXQTFzaUNNQzM0YnlCU0Nra2RV?=
 =?utf-8?B?Z1p3QkV0U3ZHWjV0Rk5LcmFjdzcyQTJJcEw5NGY1aWJvMDVIZ1RpeG1rNmZ5?=
 =?utf-8?B?TlhTdUQ4M3JLZDJIOHhuT3U5Y1EwYlU5T3ZpeFF0NnEzL1IyaWoyRDM0Mmxt?=
 =?utf-8?B?Vm9RRzI2bHZsMjR0T2FTWE5lZ2ZSbjYvYnFXcEdUdm50TUVneDNacVpINUVJ?=
 =?utf-8?B?dEtKVDNkd0hsamZmT3VJbVZ4UjZ4MS9zeTk2ck9USTZqamtRNERpdDBvemtM?=
 =?utf-8?B?U1ZhMEt0UjhDM09RcjRkMDl6aUtUMTdobzZIWDhweVArbGxMb0ZVc1RYbGxL?=
 =?utf-8?B?aVI5NEJrbmh0UWJYWVVNK0hDV1dQM1lSaE1BL25Xb0h2cmVYaW1kSDNVYzR3?=
 =?utf-8?B?aEVHLzRTLzlGMjdrbCt0bWlZd1N0aUowUC9DMmhkeUpVUlVtTnd5Tm1mTlZO?=
 =?utf-8?B?dmhMZjByeWpkakdhOTU1TEVzZENIUGx3OUdiY0dlRDNhUDgzRTJTQUsyWE9G?=
 =?utf-8?B?UW40K1RVWnJXbXB1aUhaN1ZGRktXQWZIZHVKdUJlSmNtR1RqRE42VjNhemFx?=
 =?utf-8?B?NzFVc3J0cnpHeUp3VFdqU2ZzQ1ZaejFoVnM1eTlOU0ZNaXBGdDk0YU1kUysv?=
 =?utf-8?B?Y3YrQmN2aFRrbTBIdkV3UXlMcnVqczV4SW5IcytxSUVKc25MTWNwejZRQ3h4?=
 =?utf-8?B?dGdZV1NrNmt1N1dJdFYwWkpEVkFHOHgvaWFTc2ViZm1USzRFUWo3THh0N2Nu?=
 =?utf-8?B?aEtXYjRVa2x5dStsNXVrUXhUMGp4MGdOcDVqZ3oyaUFZaHlsRjRzL2tTcXpS?=
 =?utf-8?B?amF6b1V1UWV5TGtrK0VsdkcxYVk1aUpTblFJalJNUE5Rd2hnOXlNNmR6bzFO?=
 =?utf-8?B?cHlMbXRrNUFPS21YcHZJSVgvU1pNUnZpMk9tYWV2cVFvT0FzT0ZBTjhtcFlD?=
 =?utf-8?B?b08xRE9ENEdGQzlHRVRvWjlJdzAyVVIvelEvVHIyOUxSUVh3cDZSU1NkUWpm?=
 =?utf-8?B?d0JNbzh1c2FoWHhVS2ZQR0VqL0UvaDNiQSszMG1NbXQzYzZSaDRkMFpIa1o1?=
 =?utf-8?B?ZWVSWE9ySytjTjd2UGREN0JqSy82TVhHNTFTOExWRDd2R1NOOHgyU3dIbU9h?=
 =?utf-8?B?b2RZNVFXUWxJRjVXVWJ1cFlFN1VuNTcxMVlrVXBJQUlTUGlCWUF2cEUybDBq?=
 =?utf-8?B?R2RFR0lhWGhTOHNaa0s2UGE5eTBRMUttcjFOSjFCOFVZQ1luNjlGUTVXUTJz?=
 =?utf-8?B?anVyTHAvQTNKZHJpTWRVQnJFbll6WjlCVXVJYTVsMHNFMjZWcm9MTEIzQ1F6?=
 =?utf-8?B?dkV1V3BrU3JkNk1jOGM3YTJiTEdVakFZMkQ4YTEyL0ZvTUFvak5RWGtGQnVj?=
 =?utf-8?B?Q0llVlBxak1ER2wvdGdKbTMzcDZQdWFBQ04rcXVYcjBya1FYMVhpYm5VK0xM?=
 =?utf-8?B?OElndEpRUGdXalRyVjlhR3NMWGVFbDFVQmNPZUQyb1dOc21nVDhQWE9FL001?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790397bf-479d-4a10-9ea6-08da8fd7af7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 07:16:15.2451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wORoeISWte76ZYIP/aU3V8WDQMBkDDd/kxtwXWlozJxS69bgW/Qkh56R4siXvs8+hlIyjBoOPs4pzFam/CZk3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/5/22 23:49, Christoph Hellwig wrote:
> On Tue, Aug 30, 2022 at 09:18:42PM -0700, John Hubbard wrote:
> static void nfs_direct_release_pages(struct iov_iter *iter, struct page **pages,
> 				     unsigned int npages)
>>  {
>> -	unsigned int i;
>> -	for (i = 0; i < npages; i++)
>> -		put_page(pages[i]);
>> +	if (user_backed_iter(iter) || iov_iter_is_bvec(iter))
>> +		dio_w_unpin_user_pages(pages, npages);
>> +	else
>> +		release_pages(pages, npages);
> 
> Instead of having this magic in all kinds of places, we need a helper
> that takes the page array, npages and iter->type and does the right
> thing.

Yes, Miklos asked for much the same thing, too. :)

thanks,

-- 
John Hubbard
NVIDIA

