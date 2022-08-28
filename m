Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76795A3AC3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 03:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiH1BH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 21:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH1BHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 21:07:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F04D81F;
        Sat, 27 Aug 2022 18:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RarSH45MZT6jfFcdNdewAu5lGJfJnsreF8Vx/4RiYC7rIHxGEg6MbZa3mG8whJy4zzpCTiAXi9QdO0HwLajtc1E8wHgKE4RwMRUEnlM0RwFWOAH4W6sVIOfp2gLgTcVFUIuKNz21Z5QUFO0VVQHKGg1/G03dxm5ggjT4ZN8hqceUrjn4zesqhuoqRE8QF4JHxcF9VJxEumlnjEHjOvdnDua98Ni7y4WNXvHNmhzptb728xfBdJKIVYiBmrj1jqYOT0OYp+nVg70R0zgL5xiimVq/TwIJORZZaC3JVahQ6Z4h38Tc/mtMIkoqX82r9QNsCqTE6FZzk8b5DjnaivqO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qgFoj4aoFtoa7ImsVC3+YHUj8ufhx8X74LkpWSUDRQ=;
 b=WQlVbzdQD6Tsc4ez7L3UdmpEMntcB1viI9/kH4HlqFku+wKfc3BX/Ktl+K/iRKXdcpUEeNmDM7Yv7VuygeyuQyuuCBB1zfRlIBZ0rFe2FOZJMeGFxOeMT3Myx1YeaIOwhvjcuYp+e7pdna6Ybmq2Cyz6wX1uwc8CG5VDlTA9LBxujoAubeGFGuXMGC+b4A+stn9ErkYlh3nwP+rw/IgxUG8zUYJ0pAZJ2eosKSB2uHfsNopGYqxAqOxv8iMwaSwRBgzUOsjAPU6gYOZ4TCuEyZfWHax9CccKNcWfb5p3J7uywPhT/eNizzUf8h3lQl5eA4RZ9fsIacGvFz97hKnKlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qgFoj4aoFtoa7ImsVC3+YHUj8ufhx8X74LkpWSUDRQ=;
 b=clQxFgS58D46dgU8cpSQ/adv5LP0eZset33/lyKPvm8hs5mEs4VkFP6B5EenYC6ibjZJJ5/CNB4Yf+sF9S84l6p2Wa9GTx+lTkIEWNkFE+S9Rzry6+Dyq1BXgoKIX85iXUhGw9jZY7MozUfFCWcNchA+SVDPpyKBnQzdY+MZKM/pDP+KbZNAHbqBhyBmJ/N1L9FlTBFZqaPGwst7jTHeHn0IHJ5um2fQCJjljohrDq3Fhulo4QfixVDyFguGWlcBHyOi9gbLJy8a3KaH1q+odt9sopaAqP+IsiOigkZSWhHtz60oGrQaod/N2A/O9fZQ0KZzMAdfpa0wZD1YRQIyNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB4779.namprd12.prod.outlook.com (2603:10b6:5:172::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sun, 28 Aug
 2022 01:07:51 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Sun, 28 Aug 2022
 01:07:51 +0000
Message-ID: <345f3293-51fd-1f2c-9d6a-7e6e8950102d@nvidia.com>
Date:   Sat, 27 Aug 2022 18:07:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/6] block: add dio_w_*() wrappers for pin, unpin user
 pages
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
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
 <4c6903d4-0612-5097-0005-4a9420890826@nvidia.com>
 <20220827171220.fa2f21f6b22c6d3047857381@linux-foundation.org>
 <d89943aa-5528-a424-099f-4b1a2151b893@nvidia.com>
In-Reply-To: <d89943aa-5528-a424-099f-4b1a2151b893@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1507fa3d-c5fc-49ff-41e0-08da8891bada
X-MS-TrafficTypeDiagnostic: DM6PR12MB4779:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lck6Pbx24zNPshqLbrNG/SYQIjqneeiiaRT7AHdrYNYcBVRFY3JK5zAoA3nRKk7hjeTMo04YKXhrIOruqlnSZ5Gng7S7iRR8F8uorXPkW25rMjhACeDNplaYWVlfGDMvUkEPhP1GHqYTTcepIPfi5lT3OjcbsZ9PbvkM6Ifivc6AVP4V9FzuWqJeEqn1hXOyXdxE0cPst4r1Qhi2zI7OY9h44vKbS0i7hjefDaA4y/vWJ6yqlDDVZGA6QehxvDxG4x5cElWD5JAElsF12RY2LgB+zqdiBXx/Eul+AX/QCeJFhr0YRzi7BmVCPTPhNKGB3WdlnbE7AVvzocoecBr6+F/zJoGRpB3E3IkrIUI1eJEhTG8rUm/kqJ66Agd/VodVn7SwPxvd/5x3i55yl6so62H0FHAgJs1EDCgrcqKSnT8ZbkwoNnA/HDVxz1DzjzigblVdmBWwLJ1bUvHj3GyPUuystZtjIn9qLEJiVix1FEtlDg/Y6khoq/bGN2bAc+ZepUtk7jRcUP2i/E8aaRptCvR5Z1mdYTUeNH2OTTNnxBkpEFNv4ofRO/OMGbajfkttknBMqz2Ii/up/ynFp7zHrICenvcUgMxXnRo7CBbwb7uSL0JSgUMfVY6y/DG5S+4I4uZkFCPawoTpXqkMKiihBwcmPRk9BaUXSnx00INlSiz0Xaj47+2WuGqm55iTultUFpHCDpjP2OSVxUcouO9DtI6DSmIZofYnnlC7ulX8sRdV2A06pnyaozhtYx3qp4RJTlQKqZ+DldAhQk4G6JCP4TvTeuobTKetFz6ApAPYZcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(41300700001)(6486002)(6506007)(53546011)(26005)(6666004)(6512007)(316002)(54906003)(6916009)(86362001)(31696002)(478600001)(38100700002)(186003)(2616005)(4744005)(31686004)(7416002)(8936002)(2906002)(5660300002)(36756003)(8676002)(66476007)(66946007)(4326008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjBHQmpSb1ExWkx0VkdRRENabG9VekZnVVlodnhyc0pxem16cXAwdXRoNjMw?=
 =?utf-8?B?L090aVI3MWdGQ2JtaDFPOEtRVXcxejZlb2hhRXJpVEp1ZEFvanpIRklSeVIv?=
 =?utf-8?B?bDVsc3EwS1ZyaXRRaW93dFhSVlQycWZ3NjdUa2VLUEZrWVR1UXl3RmY3Zkg0?=
 =?utf-8?B?ZmkwQUFYbHE2OVVlc3ltUXBRdllSYkRRNDR4bnArNmN5R0dDekNiWDJhY1Qx?=
 =?utf-8?B?SE15SlZaUmxwWjVzRFZIVGNmTUptY0E1a21SU05iMFFreHErelJXRzlHM0xp?=
 =?utf-8?B?VVRuV3haM0tEZk9UOWkzRFB1TEFMRmo5aVA0OHc5cmtvcDJESFNhT0ZOdnNj?=
 =?utf-8?B?NDF1SXJDbHVmMi9EVlVXbG02Wm5sQnBGQXJkbzIxQkVjR0JQRWJMYldXRGJO?=
 =?utf-8?B?cnRVaFROUWRoSk1vTnNacmM0MTk2d2tQWXRwQzNmNlVKNVFXWFRQTTBmcWsy?=
 =?utf-8?B?YU96d0hvT3NEdFJSOTV2SUdoWTRKNHJ5ckFrWmhtYUJPS0N3OWFKTVVlTUZZ?=
 =?utf-8?B?MlpvekdCS3BlMVR0MS9oUmp1V01IMm9FTnVWa2xwWkVsQm1Kd012aVhycHFI?=
 =?utf-8?B?VTVhczdqK0d0a3hTZ0hNNU1jVUZSME9paElmYllCRkZCWEhEOFVVVTJNOWFl?=
 =?utf-8?B?M0xsRURsMkVsRUR0S3Y5WFEzcU1vV29tY0liOWRBeTFiK1B0TzZ2dnREbW9J?=
 =?utf-8?B?a0grM2VOVnlaTU9EeEN1RmxmZ0VhS2lRUUhMTExreURjRjBqL2x5d2Q0aUhD?=
 =?utf-8?B?OE44d3RXTUx3dGZmbU4wWVliZkFiY255VktsRTE0dTk0UWxqRHQxVEN1Y0U2?=
 =?utf-8?B?UkJSTXR3eHpPYXZuYm9qZ3ZVTjZxZlloYmNJVmExWU1pdmZySGxmQk5wZW9W?=
 =?utf-8?B?cEZaTE4wQkRqZjJFSnZramNPd0lsWVJvcWJOSUJYdEZZR0xablFhOXE4S3JD?=
 =?utf-8?B?eVR5a3I4aldROTVCeXZBRTZnZjFaUzIyYVhwVTNoRGdXUC95eDVGWWgwYi9V?=
 =?utf-8?B?ZmZCN0c0MTE3bzNaVVMxYWM3NlJ5QU9TSDM2VlgwQ1c1YkRPUm54d0F1dUd4?=
 =?utf-8?B?MGlMNURnMjJVU0FMMEMxeTFkT3BCZmhpT0x0empnZTdhRFZRa3VKUW53MXZn?=
 =?utf-8?B?cmU5M1J3c09OUW5PWnQxYWxERGRWZWJtUkpGbUNUR0ZRbXA2T2VuUXRVUTBL?=
 =?utf-8?B?WUJUVUZnUkhqZDdTa2ppNFErT0FPUGs1aDhsYjdNMW5uRDM1c0l0enhKM21k?=
 =?utf-8?B?VzRBS1Q3c2QwMkk4cUtMKzgvY0lhQ2o3RE5RUHYvaHNCMFNadDhPalVmYk1J?=
 =?utf-8?B?WWRoNnlCQkpGZzV2RC9HU015RGxPTXpEZFJWQ0ZDY1JKSVQ3ZEZYeEtGK1I5?=
 =?utf-8?B?aXRSZ0hWOFdQTUUvUUpuSjZ3REk5Qmpic1VNZzkvZWRkVHMyWUovaFNoOVds?=
 =?utf-8?B?V1BNdGdRZHRpbEQvOGx1OGQ4Rk9YUWhmaW1ZZ3JWcUdjcTNWbUlHTE1wQzZ6?=
 =?utf-8?B?SS9nUmZrN04vOFZtaW5TdEpwWTJCZDI3VFB0WnM0L0ljSTBCWHo4MzdMVEJF?=
 =?utf-8?B?N3VlN2lDQzcwc3R3Uk1jM01paGtEN25lVXFmTFh6cWl2U3dvbE5ua0hpZGNj?=
 =?utf-8?B?SmkvNjFud1p5eHNTR0pqQnpSYVRNbFh2cDF2dTJjNnZNTzdrU0g4cWNnbDhN?=
 =?utf-8?B?MkRxOERVdzRrUVViRGZzMVlSaWJqdStTd3dGYmxHUVlIRkt0TmNvN0ltZ09G?=
 =?utf-8?B?MXhEUzBJMlhBbTcyYVZrRTFhcnh2S0tLOGtDMnNHZVF2R2VRUXRWMmVmT0xk?=
 =?utf-8?B?eDVxVWhPYnZKeGx3QW1PTTdsVVorMDFWVnFRNDFPeWRZMERCYkhOUmw2L0ZL?=
 =?utf-8?B?eWx3K2F5c0tHblJXU0NibGVCeDZLb25QamhPM3k5UC8xU25zdDkydU5vbXNv?=
 =?utf-8?B?cGxxalZRbnVQLzYwMWlKTlhFZ3BxcUtZWnR2aGgvazExbWZGb3JpYlZuaFFj?=
 =?utf-8?B?OUhxT05sTFlPK2NRTHN0RG5mc0V1bmlKc3N5a1daUlRCdWZyeEZQTTk0VTN0?=
 =?utf-8?B?UHdsNWdCeFZneUlpaElMa0w5SnN4amRPeVNuTzFUUWlrTkhNTC90ZUdiRUw2?=
 =?utf-8?Q?uv3zBsq5sDOtAuKRzkXpU5BuA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1507fa3d-c5fc-49ff-41e0-08da8891bada
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 01:07:51.4097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pSUopkVYVUGWDefwj8jBPnQR7aQaL0ZsnQpAiwL5O7IhITgUHPipP8vBjnPg+vZ1WldfJ3KHWKglDrfjK+O/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4779
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

On 8/27/22 17:31, John Hubbard wrote:
> On 8/27/22 17:12, Andrew Morton wrote:
>> On Sat, 27 Aug 2022 16:59:32 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
>>
>>> Anyway, I'll change my patch locally for now, to this:
>>>
>>> static inline void dio_w_unpin_user_pages(struct page **pages,
>>> 					  unsigned long npages)
>>> {
>>> 	/* Careful, release_pages() uses a smaller integer type for npages: */
>>> 	if (WARN_ON_ONCE(npages > (unsigned long)INT_MAX))
>>> 		return;
>>>
>>> 	release_pages(pages, (int)npages);
>>> }
>>
>> Well, it might be slower.  release_pages() has a ton of fluff.
>>
>> As mentioned, the above might be faster if the pages tend
>> to have page_count()==1??
>>
> 
> I don't think we can know the answer to that. This code is called

To clarify: I mean, I don't think we can know whether or not these pages 
usually have page_count()==1.


thanks,

-- 
John Hubbard
NVIDIA
