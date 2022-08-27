Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4175A3A8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 01:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiH0X7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 19:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH0X7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 19:59:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D1254CB8;
        Sat, 27 Aug 2022 16:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdldrJSgd8Vpr4X3RnsvDeIdg8HN6/7coM+lZ2w6bf8TMsjXVaS4tHYAnQ3IAIM0XamW/2dfAq4AdprQ0UKgi48UT+gy/4W6ra04A+IBds0xnFC0wbcvjVLb7IJybf25gsAU+JLP4q0BIdZwHvB/Ln9h100jbaauJdT6b6x3+WdzKpzZAvtSh5BxE/TTHaMjNbSo8oCxRx2EX6eKKD+Ek/lW2eKXaPfplynxLbWwDCA7nDHv8xC5whwpSVICI6T/lxKiD2G1tz/5IIK4N0+7p0ewWyIxygBh5MUkAw6tSYHln+cDHLvfXnog7qEZL5QBAHtY2GbajI5NzOq0npgfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QPspq2ArHQV/9lrveaKexNqCdEseetHj7JM1CXsahQ=;
 b=EYqZhfllO6x2pt7sNEwPImShwQxQZ1ORXtAZb9HyUbuSroX5j/DrG4bHIdG2wrPvpC4GSS2q0qFN++/EHF29CYFvHesStTCMegAcjv2ae8g7rtTZji2H4LriPyvowB1z8jF1Xx6pRgVxwHbYNLju0/DMcHaGbdXvE3n7XtWhbx/wV4T+FeaHLJ+ZjfX+L4iVCjRDSt+52Ku2oqiwgy931TRUBRv2jWgyHPVhUnhwoI5yGEDLCodXo6zrfBudbvji+pVPMaesdHyQXU2Kp4DEUHXVAeXLcSXuoNKzjLoT49TWopM2UdbZsv2l6kq6YYznAg35HyuXD+kYZIGnIdEnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QPspq2ArHQV/9lrveaKexNqCdEseetHj7JM1CXsahQ=;
 b=W7grLz3It3EAOyv+TLFtQL6mCXw/NvS26Cb1Ejap41KlrMphUwMRcfWR6cnjc0KI9mCYQbM1b8yORLyuduy6SzUYKuIwaefz0NfIHXNIQmT4y9EvfwxNXAOK+NtHPF+gwl9/D+kfvlqmQWreCFG5y4gFAevqdaHU9VCqXSAypWavnmT9iaEPb5hyIFmB4EDvNF6oJYUlDvBqViLbGMZywtU5ir75NIVJlfTS/V9YULV0F5Tlfru3XK3Gdx/BxcaJuZayCcx/CtKrLibKlUyIRGxVyLSviAiwp9GlUZTPlY4EDTCPivRmR8dqFuoz5pw70Y1v5QaVyvJN7sw6XL5LwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM5PR1201MB2555.namprd12.prod.outlook.com (2603:10b6:3:ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Sat, 27 Aug
 2022 23:59:34 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Sat, 27 Aug 2022
 23:59:34 +0000
Message-ID: <4c6903d4-0612-5097-0005-4a9420890826@nvidia.com>
Date:   Sat, 27 Aug 2022 16:59:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From:   John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 2/6] block: add dio_w_*() wrappers for pin, unpin user
 pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
 <20220827083607.2345453-3-jhubbard@nvidia.com>
 <20220827152745.3dcd05e98b3a4383af650a72@linux-foundation.org>
Content-Language: en-US
In-Reply-To: <20220827152745.3dcd05e98b3a4383af650a72@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::13) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99e4d6c3-8851-401b-5eab-08da888830ce
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2555:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ul6IZOe3FBCameJHPSghGobX/rnksWwNbd0QOUUJOgvSIOubdy/YpJOFmQ+Ch/BEDJNkGp5bwufdapSyRSBHJHLJo1zUWifJzkQQodlyj/nFOP3aP4OA48L/r7tOQaPprnlqZ2PNeQ2vpaj75Xy7gJqJP0NQaKtWXVe9LAYuFkbJOELZ6Vux4AZjL0wd0GVySbJlh5dUt24Z1/sfCvoVoAil1ogMJRRX2BNs4EbHtn3oXkF1os7DxKBORBES2AkJo9a67dFfl/zlqp+VSdkr1gq4dj9HcNtvlz+gcLLMcwm1Mlv3jtOe1NYPmt5yWCICcCq+9kSjPNRnqEIoSmYMeB58x0Q8RGOawQNCuuHehamchdM5Muakqr+ATQQi2fKpR3J0Sh5925r7fZZE2bNAVjubIPudmxzlXHYOKcmOj+s+fFXXhv3tpWwlc0mc1FHdRRQx9mv2qp/jB7wIwkVX2B7yy1+q+Iv6n/VK4YORF88Yz8oZPKu+UkPhmes2HuNJcbvKNHMGEsTXU3rwiziO3LkpVW0wye/1ztMdfPLtvm6+xOf3YDQasUqAgoznp2pgLjntgzpqKleVe24f9Ly/mWbZUksAuRrM5v1lODV6AM+YApYw6U3MdhqJwGhjoFVt7C77XNaei+G6laVloyuXeBEAgrhpjAgTUTQVUfunIjGJd14bBx2TgBULOve0eaM2kubgVm9v1hV+I7b/32hxMw/DQkpigJdRVGvUopwsxXLkdX44Jdnc8PJVT8LB3tHiM9+2iJdj2+TPBIGWz9sBO2BIXzTYTqf07kkDIY/dMvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(6486002)(66476007)(66556008)(66946007)(316002)(54906003)(6916009)(8676002)(478600001)(38100700002)(86362001)(36756003)(31696002)(31686004)(8936002)(26005)(6506007)(41300700001)(186003)(5660300002)(4326008)(2616005)(6512007)(53546011)(83380400001)(2906002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3hwbmhZeXhlZGNhTGVuUU40RUFaempXdWRubTdsMndITU9wNElCNG54M1hB?=
 =?utf-8?B?eC8rUWU1TnRvUlRvZ25VU1ZXWTZSajE2U3RpeldVZG1oWUxDaXRCa09yMXY3?=
 =?utf-8?B?bVJhaEJxYk1hNkNpUEgxVTNVYVdjWTBzWnAyOXhKRE9mZE1GV0NnOWhJeGl6?=
 =?utf-8?B?dEY2QWFEZ081YnlmSjJjRWpGQ3VKZnlRQnJFMGFPODlUc09uY2loaU1iOWJs?=
 =?utf-8?B?NWFvVk84UkFERWx6T1pxZ3FGSmZ3Nk1GM1VhMm9ySkpIRSttRzRPbmN0ZkE2?=
 =?utf-8?B?eDdpU21VNEhuM0dOa1NnbGFTYnFmRjNsd2NwSVVLc3BKYzQ5VVYvdmxOSzlK?=
 =?utf-8?B?NVRKN2YvQjd5dHEwQ2JlR0RrUGFMMWdpQ0FhaEJRVU1UTHNzdDQ4M1c0YzN4?=
 =?utf-8?B?akRKOEJMSDVhUWhOV3N5Um1seVV6bEJRUndBdEl5MTExbDMyc0ZJdXVDYXM2?=
 =?utf-8?B?ZVRvWUoveWhDYTczSDJ4T2pSaEdaRHpQRTM2L3RNSFRCV2xYQ242MjNwWWFl?=
 =?utf-8?B?SjJSdXYyc2R2Mm01TGo1NGYrVnNtVStxZUxZOWsyeUJLNTU3M2trL2d1RENE?=
 =?utf-8?B?YS9RK0d5V21CUkpSeXdBUjk1MzE4UmF0ZWc3MkJGR2VMZTUyVlBEOEp6NnJ5?=
 =?utf-8?B?UTQvOS9FelZ5M0ZVZWFMb2VadEE3T2lUVTFvd2RvdC9NQjJENXFvWmthQzB4?=
 =?utf-8?B?MDBPMlJnWnR0YUJpUVdiOEluUTl5SVNMWmdxWlM5bFlpY0lXRkhDUUFZMC9o?=
 =?utf-8?B?RVZocU11MFNUU2o1OExiY2p0UnlzQ3p1S1p3M2lTWmd1VUpkcTZBRzBWMG5x?=
 =?utf-8?B?TWlaTTN4MVJzY3R4OUF2bWd1TTQ5TzMzNnFHdzdzR2dvM0xJREs2T0g5bDEx?=
 =?utf-8?B?aDFCTGtzcXJieDBTb05Gc2ZJcXRZVXpXeWxxUDFwdzYvaWwzM3poSVRyTUhS?=
 =?utf-8?B?bW0vMTZqRjlhZnZ3czB4VHhiOGQxNStUTkxoeVN1elRKU09IOW41aFRFYnpS?=
 =?utf-8?B?Mkh6WDgxOVllN2ZHOWNTUjNDNjdpamF5a3I4dy85a1FVWGh4QVFoeVRQcjZo?=
 =?utf-8?B?dFRBMVk2Vndud2ljRWtQOU1qQmg3ZnJNY1FuZW1NbDBIakswZTZyY3orbFdy?=
 =?utf-8?B?ZGx4MHBYdVBEVFhyczB0eEdJVDJaaXdPcHZENmsvb1RiTGwvTHFJZWRENGU5?=
 =?utf-8?B?ekpYbFE1YkhXVThQYnB1TUFQZWtjWlBvNEw0b1N3V21Peng4QzJvb2p0NDNw?=
 =?utf-8?B?WUxUSmZ1MVZFU1I3M051N0pUeFRmVGE5MXZQanFiR2wza1kveFNubWw5dVht?=
 =?utf-8?B?bDNaSnAwMnkrdVBLVG5tVDNaNVBVNG1xVk1uT04xUFRyREVlaWJycmcvOEtG?=
 =?utf-8?B?Z0IrZER6MjBYR21zSGx1RktoZnhMdk9LR2VmaWZDTXpBQStaSDMvdG9yaXph?=
 =?utf-8?B?bUdXODV4cmkyVjJFQ1d2SDFmNE8xdHRDeFZ2U1ExUUpnWnVVenVFWXgwVVBw?=
 =?utf-8?B?eDN0QzIxTzJnZmxDWjZtcnh2ZGVRUWpkbjNwVy9wVGJPSzBkd054NEhTYW0y?=
 =?utf-8?B?OTd4TkZSYVVLc1dUQ3ZoQlpsRnFVWjhUa2VpMVhHN0F2SWxpUmlINEQ1RHB5?=
 =?utf-8?B?STBrbGZmeG84ZG12WSt4RVcyc3lsSFl0cFl2N0pGOEFKbjVnMzE4d21tbDVn?=
 =?utf-8?B?THZJanR1VE5nSEhsNzRPVEM0RWRwTVRFUDg5RnZIRFF6Mmc4V2UyWW5YejEz?=
 =?utf-8?B?TDd3d3RtUk5qRHBZdGFPVnlHZVYzLzF4TXluR0ZxWEMyNDBjTmVCZzE3b2tX?=
 =?utf-8?B?V1lZVGpVVkhzTkNKM2VGMERzVjJKN0hLRGJwWkpHblZ2MTZpdE02dzV3L2VD?=
 =?utf-8?B?VEZiQTlTcDB6d2hGdUxuZFhvblB2cGU3YTAwOXJrN2NVaDkxZ2dPdG05VXVq?=
 =?utf-8?B?Q3JRQ2U3QUJmQ2x4VVJMd25RaGxaQ0YwRWpUS1FDNVZmMERkR01lZFhVTWdM?=
 =?utf-8?B?cWJHMnVmUVFqQURRYWFhMmNWOUZjTDdwY0dndC9DUEU2NVlmbFZkY0xFaHdO?=
 =?utf-8?B?NEpaN3pqT0JhOGFWVVVtNm15Z2tKQm1kVkkva21VeFIyK3kzYUYwNVZISDk4?=
 =?utf-8?Q?1FoHc+5J4aEnrQOMZYKb4pBog?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e4d6c3-8851-401b-5eab-08da888830ce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 23:59:34.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fwn33fXwRHRmgVJkCUseL4eQkZH13VKGAGwLOIs5jaRaxQD+sa6EKs5KkqkbP4qhS1FXMF10MFPhS8ELyJOvJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2555
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

On 8/27/22 15:27, Andrew Morton wrote:
>> +static inline void dio_w_unpin_user_pages(struct page **pages,
>> +					  unsigned long npages)
>> +{
>> +	unsigned long i;
>> +
>> +	for (i = 0; i < npages; i++)
>> +		put_page(pages[i]);
>> +}
> 
> release_pages()?  Might be faster if many of the pages are page_count()==1.

Sure. I was being perhaps too cautious about changing too many things
at once, earlier when I wrote this. 

> 
> (release_pages() was almost as simple as the above when I added it a
> million years ago.  But then progress happened).
> 

Actually, I'm tempted update the release_pages() API as well, because it
uses an int for npages, while other things (in gup.c, anyway) are moving
over to unsigned long.

Anyway, I'll change my patch locally for now, to this:

static inline void dio_w_unpin_user_pages(struct page **pages,
					  unsigned long npages)
{
	/* Careful, release_pages() uses a smaller integer type for npages: */
	if (WARN_ON_ONCE(npages > (unsigned long)INT_MAX))
		return;

	release_pages(pages, (int)npages);
}

...in hopes that I can somehow find a way to address Al Viro's other
comments, which have the potential to doom the whole series, heh.


thanks,

-- 
John Hubbard
NVIDIA
