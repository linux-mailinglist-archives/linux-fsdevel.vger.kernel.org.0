Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EE3679183
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 08:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjAXHD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 02:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjAXHDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:03:25 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D1F6A5D;
        Mon, 23 Jan 2023 23:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXPw8sHAcLUzE2Y87WiiFRAUSoPGdQTyfJRKGMZI+7sDe/6wlJore/ZWsWGJfyj+YIqMhbjXgBEtJhAMLJ8AaIsWXM8ik3EJFNPGTXNfNKcxhVHsGJqnEQYwADsWynALE+5sikJFJJNWcmmCR06INwYXAOs2X+JnZZeGMgUF2yj8uI2TFpkXy/xjN0/spjIWoWWzJ+EomcNKI2fDQww0b0lA3dQJ45JDHWu7nn6uYmksxyk9vvh/hhL0TCiSBe1ckz4dJm5yvEpdNDUeTh+XnzOnHZEjgM+H3/SIyK+3HJ6OEXWFs7fO6w5El4EQM4GU+rP00zbqSfxTaukZLmzTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgw/2xD3fYp3lJKof6egbcJZ3mppftq/lFdh98nAVNQ=;
 b=W/nZxFfdRYL4XifpNewknnyiniOe+JbaNCcseBfF898oIv0BOPz0eiuNHblPakLmB3uoEzAwFLxD/51C4+VVh+Em8B3feHhVS0LZfCEmno1KVkAzTU0PVez3Kd7PryBAxmkdp/Bk31giEtEpbzS1yuSTigipmWWhdW4KleJVWsAKGmqyYs8gldPYgtEg5YD4x+0sDO9/l7ahYHB1xwAo8U/osQsujBOdulizORT8309VW1qkWbXiPXxz3a/l20JxnUFN+bX7lYPp9mUYmsykZACNDpkME1BXyLmz/0vk2LUV8MuSRQgucKFqtzPxcPXwRL6qzppJcBjAYRo3PE/hGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgw/2xD3fYp3lJKof6egbcJZ3mppftq/lFdh98nAVNQ=;
 b=YQw8wjJP0U82m3m1uevFF++pLXZ6dYpQ1wNmetlfusoKtgwvFK56uaz3zEakGTYTqHGKEKHMiRAsUqPqo4ktaASGu7jycWPxb8jFwgfON1eOBgq9ZZJ7wDOII1pUcXCtxLK67VALsfBDASgBfTQaCbXBwBids6N+QbiXlnDK0iBoFWpbMX6rmxnqS5SBhhCWAFSSzkXrm4YmxtP+bS5pKwBWLHgiSIVu/Ai4Fsd5c1+DA2XpEozKYTSw3dbVbPOg8oMB5eoHLC4y2ihRPBy+a8wCWLADjmU6pl5TmXNBkRSSIE+qLBXJ7RdZ4dY8gJ3psKSAkR3D/bNFoOhQTJd51w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 07:03:22 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::7895:c4d1:27d2:5b0a]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::7895:c4d1:27d2:5b0a%9]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 07:03:22 +0000
Message-ID: <f2a2ec3a-d4ef-985c-2324-736fb863575a@nvidia.com>
Date:   Mon, 23 Jan 2023 23:03:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 04/10] iomap: don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-5-dhowells@redhat.com>
 <eb1f8849-f0d8-9d3d-d80d-7fe8487a15f4@nvidia.com>
 <Y89zypNE5z7rgdtX@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y89zypNE5z7rgdtX@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::36) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4f1a7e-af44-4bc7-5666-08dafdd91494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65kiD5qnrruIbY1bMBdyJUmMrKUPfLjZqBtHgaYxnjgO29FvWszdw0kFWSZH1FiAhsU4Z+g+iWa9F9Q4YIg1a2ix3iJGDvIX9f23tpm9JvN8YL+PxxDMXI5+Jbov1/fx7RnPVaPXzXlg2734RugOGZZ8TYbhvDXKChXUhSGggi5BjA48w21YW7jhJalTZCvvVcV42TG/Y2xbwqpBUfKvlQfuDfVSrYOW/yoAwVgOxgZT4X1tnTHlaJ4epxlJlltaGVJOTyglwc3uCV4+EN+cAoZgU5VrWxRRDwIBbtjWiw8UAgqVZLm+lOt7ce510WiaJGu0jXyv1dWsDO/66wuQGbih5zQx5kcfZeVRuDWT/Kzmn8nsdwCZkRtmfrFQTgqU7PL1B8tfc1Loz3p9so/3LYwZIZa9+AOvMujEH+R4u1c9Edu2XJMV68QeiTEtGLIg7kwXm31YPdUdstF8tBvGWm2aT0c7raiVqWXLuFBzR6OM9g2fk6N/A0/QxTaYDRqBKvcV6SBqoeQgpIpbIXVK7DwBPDFy4gbFucKadKDEHTyeKcODLx8KIwIK/QjN77Cs+Brm6PLJooGBzOYYvIThlnkYFGloSK8TG1Nbg7fVQoKI65OB67NIbv21wNjr0Xu4m0GOvTrIJJuo/5V8ZbsUOiUlIY4wBH5vpf9Klaex9CPqYNp/3lRy3zgNxELuPxxZOQzgHZpEtjm5nPJ8vhQfJqKzmmpEjnSVP0PAWrxBGVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199015)(38100700002)(36756003)(31696002)(86362001)(316002)(478600001)(54906003)(66946007)(66556008)(8676002)(6916009)(4326008)(66476007)(6486002)(2616005)(31686004)(2906002)(6506007)(53546011)(8936002)(186003)(26005)(41300700001)(4744005)(7416002)(6512007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJXS1Jnd0I1MFNBOXljSngwKzZHby9nR2hRNDlhQUxLVG9GWG5OLzRKaEJq?=
 =?utf-8?B?WS83dUNlYzI1bFlKWDNrbTVCMDZiWE9BOU5ubVJOZVUxUTdYVzBXblF2TkRj?=
 =?utf-8?B?L3d1a1l2NC9kNVk5YnUxVmwzZmNhOWdaZ0w5OUpVcjNPMGthNUpGdDNFbFVW?=
 =?utf-8?B?dy84Q29YdWppTVRxemozTEp6VkloaEhYV2ZDY3FPNlFuNUI0bFU3MnF3U291?=
 =?utf-8?B?RnRjeWNpS0c3YzJ1ZERUYjN0NFRrNmhYY2NONWIxZUxkTS8wNzBWWnQyeU1C?=
 =?utf-8?B?L081NnJ6MzBVQVJVTFBHS2ZjZGVHNlJmakRoOGZXU25NZDJScGxWQzJJVlV5?=
 =?utf-8?B?NW15b0I3RGpZU3RVMURPOVhYTGhGa1hVV3lFaDZLOURRV3ZnRVJyWU1vb09U?=
 =?utf-8?B?NG9zUVY3T1ZjL3hVaFdpeGU4T014aEpjR0I5RWxub2taSmRTTmlHSVZpeVg3?=
 =?utf-8?B?S1JZOUY4THF6U1ArNmNZajBNa25xSDlQQm52KzNKbkhpbmNGeDNmMHhkaGZP?=
 =?utf-8?B?dTAvWUJUTjZIU09lMmZnM2lWaFpZamhtMkpIMXdlUkJGc0wwRlFZREpvcEpp?=
 =?utf-8?B?QUs2ajdoc1hLQkh3cUdkTTllVEJabXZMQ0RFb2FiR2U2QWE5VG50MWloQ1M4?=
 =?utf-8?B?eWRLTkE4UU5mcnZwbGhHRjZvWjZLRXVPZGtEUzB5MUk0VTVBL28zaWQ4M1Jj?=
 =?utf-8?B?eThTczk1clJqeXJjR3JnWHo5S3dTNTZXMURJYUZESlRDSVhjcFpRcTA4cTF2?=
 =?utf-8?B?a1BoMURnZU9JaTNPTTgwTktRT1NpWnMycStPQmhvNmdxUWtpbVFuM0dHQmpq?=
 =?utf-8?B?OVNnS1F5ekFJZlQ4WHVkTmZxM0VvZUdmZWVMK0xGTnZ3N3liN0VwVGtTV2Jl?=
 =?utf-8?B?eVA3Z0E4bW1DUjZ0S2lzdjlCaytaQzJCSEF2OUlwUXJDV3ptWUFoeGc1MkhU?=
 =?utf-8?B?ODdHd2htVFJkd0ZUUDRnMmFtVllKeEY2R1QvM3d6RjhNcXErWFRxS2NoL2lT?=
 =?utf-8?B?enVRbUZESStCY0RxR1dEeWFJdEpQRTk0aWdKd2FFMWZkaTkvUmZYd0d6RDNW?=
 =?utf-8?B?aXdtOERES3JnVGFQek5GMEZzVFdSY0NRREtNUHY4OFFNVVpYSnBVbk9lTFBL?=
 =?utf-8?B?SkErMXBNczVIaU5KWW1XT3FoNk4rWDR5MGpTWXkzVDlBTE1XckMzMVNnOVlE?=
 =?utf-8?B?Rk0vaXhXcFdmNmRySXYxd21MZ0F2QkNBMFhaeklWSnJnaStsZU9ndnovbVFB?=
 =?utf-8?B?UjdOMFcxRURBODA2eDc4ZjU0aEp0K3RVZ3NzT3QwakpRYWJQK3lxTWlUS0hU?=
 =?utf-8?B?UE5jakMrZG5PYnhJSGZMTyt1QmJQbTZqcTBwc2xqV29KcUZ2M0JpSW1WZGxj?=
 =?utf-8?B?ME5QTVdabUhqVjV0OHRvWXoreUpTczR0QU5wOEc0TURNVWdsc0JKd05tMjNN?=
 =?utf-8?B?MVJOMGU3Z0FSV0l5cjVpMXFQUDk0ZXhvWHB6dUoxOExUQytVWTZ2TDZpZkVk?=
 =?utf-8?B?TExaZktiZjB6c01ia1Q1aFBDZDBjSnZmNVkyTlNKUUhrSzBia1pENWZiSmRO?=
 =?utf-8?B?OEw3R0MybFE1Z0U3ZlQxY3ptaVdhbGJWakxTSjNDbmZmd2VaYmZWV090V1BR?=
 =?utf-8?B?d0JGTzU0aURVVEpjUGFUSTh1UlZyU0NDWFVwY2pTQVNKS3hXWm4rcUl6QnQ1?=
 =?utf-8?B?b3VSdCtoTU5YUllWcDF6WUh4d1RnUHRQeDd0eUFjcVJJcVpvV25oREJBd0VZ?=
 =?utf-8?B?dlM2ckYvdVNIQ0VIRlgzd1dpcGp3VzNsa3hPTmxGNTMzcktxRFlFNFJNMnAy?=
 =?utf-8?B?ZDZjRUhveFU1VGI1R214YWRjeHdQOXBXUjBhaGU5K29IOWE3R09OZ3dRZEIw?=
 =?utf-8?B?a094NjNraFZqanNVRGMrWmhuLzd3Qlh5QnhSYWk2aFFpWjNLamhoRGR5aUhy?=
 =?utf-8?B?ZFg0UC9MMXpSSGN6UmFmRGZ0SGxORW5YZitSMlRnQjlTR0I5ZUpFOUpTK0NT?=
 =?utf-8?B?SkpZT0tGc1NmS1dObEJjdWVwRVd0bGErVkRCdE5EcGkrV0JiWEh2dlN2OE51?=
 =?utf-8?B?MytnUHUzbDFITEc4Y3A3enBiYUNvQWFHRUhTbkswMWZXbjdXWVpMMk5YTzBB?=
 =?utf-8?Q?e2w62qaysd85Kxndr2u2DJvcH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4f1a7e-af44-4bc7-5666-08dafdd91494
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 07:03:22.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2rYu9qzk3mpNZOKXFAat5ijSjhTWqZK1HjW/SfKtWoFluAM64sE7Hvy4YGK+stsAyHh1g/wZxetv9Kw6sp/Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 21:59, Christoph Hellwig wrote:
> On Mon, Jan 23, 2023 at 06:42:28PM -0800, John Hubbard wrote:
>>> @@ -202,7 +202,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>>>   	bio->bi_private = dio;
>>>   	bio->bi_end_io = iomap_dio_bio_end_io;
>>> -	get_page(page);
>>> +	bio_set_flag(bio, BIO_NO_PAGE_REF);
>>
>> ...is it accurate to assume that the entire bio is pointing to the zero
>> page? I recall working through this area earlier last year, and ended up
>> just letting the zero page get pinned, and then unpinning upon release,
>> which is harmless.
> 
> Yes, the bio is built 4 lines above what is quoted here, and submitted
> right after it.  It only contains the ZERO_PAGE.

OK, yes. All good, then.

thanks,
-- 
John Hubbard
NVIDIA

