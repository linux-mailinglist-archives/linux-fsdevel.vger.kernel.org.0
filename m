Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2E5AE13D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbiIFHhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiIFHhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:37:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F6A13DDE;
        Tue,  6 Sep 2022 00:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFXD7YtK4k9GSNTIrGtCt5dwLjfNfyTjMol15DxfpAOvxibHMnUx4Ll1OQ6kKAcVfYal7GKQAr1JSxwpRESlga+c5UHMnVd8i2JiKBJP57kU0ihVeSrMAp8GdrIFUxcWnpkZ3WXs0n7RUPpvVL3zx2gk3yjLGAPgTrLYBXeIkntDq2AUZLIvlRZLbRtGgZy72KprK02OZK4LPxbPkR18h0sv2e2HFiuDd8sFZeGIIe9t5oc2+uxBLNxsisqEP2UA15OrqTjhlE7Cx1pZMvSmgKkYKND9cDAGsKb6djS1rFaPs3kbc5tZkGOMGsA7S9MJ+PziSSgvN4H/jRNjSw+spA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LEGvpK0ZL/eY/Q4OL7VLZrqeKVgWSCorY+0K5iaJ4Y=;
 b=giTGmYak0QmFvVTmh21hZUKyyuEJH6UtZswimYVHOdW6DLqfatCiXFjBjl8ulQ0HbshLTjIV0eSGOTPTwjqBWvnt1iYMs5SrrWcPjPvkLIHKo3wjk8k8GDl6HHZrcZQpwA2bOVYEANrMIrpDpPu0/gpE9j7B8djO2NkyrOEuDwoUYCHttXcNDQUgdgy3w+7U64biyNBMoXJnYWX/spG/BoXzZnAgJaRXIXqc1p1mEoLd9Inx1KoXiK/exqsQ6G9T9xemU8dZtEk7K9ucppUK5tQQLeCuIVlh5Wf3CgaWH48HtQJk0leymUQT4QkiLUBekDWrPdygNWN/gcFdUa0y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LEGvpK0ZL/eY/Q4OL7VLZrqeKVgWSCorY+0K5iaJ4Y=;
 b=Yie4tFZN24LzEd7JgMarDdaG8BNl4RUZqDPznKEZHVLoOB1DTRS/hhhxHDM5rLiivaKlPnBsTBT5+rCJHEUCFMrYEAC6evZluy6MSwDIOXS5qzw3WjNbyLAPzrjLkqJy3+Ddr3fUFycHweXXNylbA6ciO/Q1TnZXokAlMvbaR3NRP98VNbcEphqtrcKKKpigtcRjIybmZVZWQwM4THsxUAWm0r7Bb2YhcEFC17fQ29KwGQbuEyePNgmGvic5tWO0PWScilm5FV4V6iBmqHLrVctfBXlddsgkSrCFTGbEaP4tiLzeQvyc+/FYfuI8nQ21zWCq7i2FdmvjwftH/cZ4sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Tue, 6 Sep
 2022 07:37:03 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 07:37:03 +0000
Message-ID: <ebdbc31d-68a3-e168-7344-6b1e3aa86e28@nvidia.com>
Date:   Tue, 6 Sep 2022 00:37:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 0/7] convert most filesystems to pin_user_pages_fast()
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
 <YxbqUvDJ/rJsLMPZ@infradead.org>
 <50d1d649-cb41-3031-c459-bbd38295c619@nvidia.com>
 <Yxb1GKaiVkz7Bn2K@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yxb1GKaiVkz7Bn2K@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4cfde54-9b18-4fc6-3dbc-08da8fda97ac
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kf1olUJDmsWeast3hnaIFbuiM9blQDSBdq2G09hfYr14MEyfef6cxBUj7A7FRVQdm3V3AR6XI2Qu/JUQQCgvFfrarUmD/2KNaX0QiYzVg6HNmAwJ8AK2/+HmcHUsoJxO7KdxXkj80UfdMsjexuc9lFDkKCX2yf9lKrcb2gPTKk8sH5KckkRYBxXClXw1fM31Eaz9PJS+KesmsT5virOkyB+kUofaRcRN7VZK6wsrSDUj6DN7DXN5MxhJSVRjWQnJSsTJu4aPGJoBxXNJe/rSA6YntHT4ppgwNcJlea3WdT4GdlRQxpw5ikP+XAeb7HKv2MOXxdweG2wmUaOMsq2HApfW6Ni4ivxEWLMLAv2Dsofzs7Jn6Fe7sPkiKg/4V9yrevjPSLU3ks8ne90cnjggvp8EkHKJhxr+PfmPXzKXOYfDEy8TX5wPQPVUbVAZPlRtk8t6Hx3te9YgecepeVtpWpQ6KLhixWrOoFlJg9ISDJUXTmcvpjPB1tIfK7KCsiqXw+QeKlZtWcys4ZOiAB0heGjRCU6qI4pF8SsB1LG3A2Jme+82e1e6M93EAs3JTaeTpB7PiZ7jjDbj/JNVDdlN+M0ciG4VqmfaKnzyVkVC08LFYnRoKC0s6fUhV0OTEeCTMQNNfw71A2XWzmgt611EJMOuyEwwyLOPnMEi0x+AG4bL85Gd3Xo2Yuy58u00OrOmQRFSr81JE6Aw1qzHKdhHcQPagEFJxIvKEIKtuO2Colx2ASVyo5l7WQv+EtwQL2SjM43e0vzo5irASD81zGiXfENz9nnhiqmB0KDMDAcXAuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(31686004)(86362001)(66556008)(4326008)(8676002)(66476007)(66946007)(36756003)(38100700002)(31696002)(6486002)(26005)(53546011)(478600001)(6506007)(41300700001)(83380400001)(316002)(54906003)(6916009)(6512007)(2906002)(186003)(2616005)(5660300002)(8936002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0Z6TlVPVkdvYllJbVZGa0JKaHlBYitsZlVwclZEYm5NTmhZR0QxMEYrRm5W?=
 =?utf-8?B?YkczVkVMSzlaV3BCVmdudFFCWVg5c3Byb0JnTzRkaFd3a041NWNPRG44Nm42?=
 =?utf-8?B?RDE1Yzg0d2hDNWFKdjUwY1RwUDFQcHhzWmZNVjU0c1p1L0N2d1ZRdklncUZv?=
 =?utf-8?B?NUVQUTlNa3NGRDBETWdsYlNpdkxPRUd3RDdmOGUzUE1zaE9YekpGS0E3RzVY?=
 =?utf-8?B?TEg1aTVsa1NydmExZTd2NEp2b0lEa3NXVlR0RUx3Zk1CbG9FOUJuZE1XU0Vl?=
 =?utf-8?B?TzRoR2x3U3FTVFlaR1dWeURZaG1iOXl0ZXJ1RFZyb2xWa0FIdWJQWXp2SzY2?=
 =?utf-8?B?RENnWGlyNGpwd0ZzNFZiN3hJbE9pSjJ2TWlJUUJlb0QwblgwbFVLbnVGU0hM?=
 =?utf-8?B?T0h4TmJONGs5S1hBQnlOQXRINERzRkZ5bUw5OTcvb0JQRDg5d2E2SHN0blhi?=
 =?utf-8?B?WVlkWDh2YmZTZGQyNHY2S29ycFBWNVZNNEpBc3NuY3pvUGJxY3Rxekx5STFq?=
 =?utf-8?B?RTczSGs4enNpc0l2bFk2UlJGUlRBdWZ0Z09uUFllTVA3NWZXSHR5MjA5Snlh?=
 =?utf-8?B?ZzZkRWQ1QW1GWlVySmtkYTJMcHJmanVsN2NNUmR1bGRUT0IrdzdHN3AvUElu?=
 =?utf-8?B?dXJzSVd2cTY1MUxRU2psVnBjZ0kveXdhSHJJZWlvdjEybnliQm1qc0NLTHNn?=
 =?utf-8?B?YTYrcmJPcHZnek1vTXNad25NZWlyS0FmRjRxaG80aDVoOGt4R3h3UGZEck03?=
 =?utf-8?B?d2psWUJPdU5ZelMxVnpzdlJjTW54ZTludmthaHZxRHhlZWQycHdSRlJobXJZ?=
 =?utf-8?B?bUZOSHh2MUtaSzZPTXc3c3pjOUF5RkkzaHNDY1V1VWpWOCs4RTNvNkZVcWVp?=
 =?utf-8?B?TkxmQ09DaVBGNkF5N1NadExOTnJJTkVEQ3NrNStsVGptVDk5Z3lqY1lGa2FJ?=
 =?utf-8?B?WXgwYmRtQnBaRW5WY2J0SUxOUkRvSDZOWlYwQXV1bStxNkM4dXpnNWZqNWlh?=
 =?utf-8?B?WStJVVFBMjRhZVFQM0tMRXIyWU1zVWpyTkJPY0lQc2JQSVJzS3NXRkZZRzJD?=
 =?utf-8?B?UFZzNVRyLzRQQ3NvUzBlb2lteHVsNVNiRlYyanh0eVpUM210MHRyVlc4U1Fa?=
 =?utf-8?B?UkxkWGNUUEhYeUtINHhRYVVGYjJQRnJtRFFYbWx1ZlZCS1BaazhDYjRlNW1v?=
 =?utf-8?B?amF0ZHBySU1EMlFCc3lObFZHUCtKZWx2b3pzdUNMcHY2eGpqR0JIUjlWd2U3?=
 =?utf-8?B?NGJIWmZwNmh0bU1tTG9aWXRwSE42YTdRWjBiZmQzMzFMR0cxM0FPdzRGNksw?=
 =?utf-8?B?L2x3VVR1YkpZdXR2TXNyL1IzWS9XNGZJeStEdTBtSUN6RUh1UzJKd3NLbXJR?=
 =?utf-8?B?TTExQkF0cjlVYjA4cWZIZFM1Y3BmSUNQWnJ2ZVl3aTh2WW1tczJUbzA2cnl5?=
 =?utf-8?B?TStqTnNIUm5IUXFiMmMrbUdqVkVnaXdPcTZrMnFrcUplY0EycWdiaDZycm1J?=
 =?utf-8?B?U0lYOGMzQXJKSXkya3h0RXlzN1B6K3MxTGxUYkVNcTNQRzByREZZam5TaHBp?=
 =?utf-8?B?VHBHc3hvSzVjclAzdVgweW5DRDZhSHp4UE1HaDJkZ1Jtc2J0YXJHTldBUC9s?=
 =?utf-8?B?WkRMSDVmWVdTSUVKUzZQaFRWazZMd05HZHhsMFpLeTFUVUFiM01GUGppeVN1?=
 =?utf-8?B?aWdqUkhHaEswNUtVUzRmYzQwQ3BOS25UdThkdVdnY2dENUFBZHV6RElKRnFi?=
 =?utf-8?B?MTRzemwrSEY3dlpVaGdXYzJ5MnhnTTFRdE1IbnkvR3kwSDl3SXNIMHFEWXNn?=
 =?utf-8?B?U0x5bStodHJSVHF0dDV3QjBsVk4rc09FN3BQamdiQ1NpcTVTY0ZFMHB4cXo5?=
 =?utf-8?B?dFdQWW1ncUREa0NlRVBqK29VUVNSRXdYYkoxeEcrUmFhbnorWmIyT0s1aHpR?=
 =?utf-8?B?T3RrNGV5TEVaNytVRVZyaGZRdlI4bUxZRGFNaWdSbEVGWjFSUnNraFBIekg0?=
 =?utf-8?B?Sy9jLzk2TlZlSG1LV2pvcmlQK0tGc0l1RnFENm1YamVvM1BQTzVwM1NHTmZD?=
 =?utf-8?B?aG84Z3NKVjg0UmJNazFQaHExT2pPdXI1bzdiOVEyVjA3VFp5b00yWjZ5TmtG?=
 =?utf-8?Q?Sh+uuVbSrIjZuCyYz3aqJNxKd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cfde54-9b18-4fc6-3dbc-08da8fda97ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 07:37:03.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qi9QjPN6NZsEzMSsdY/k335XkAEXnmeJ02G7Cmr7fBq/GMWXHMOsh6zXsv93KtTOXp8KDxuC2yUirQjCzDFzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/22 00:22, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 12:10:54AM -0700, John Hubbard wrote:
>> I would be delighted if that were somehow possible. Every time I think
>> it's possible, it has fallen apart. The fact that bio_release_pages()
>> will need to switch over from put_page() to unpin_user_page(), combined
>> with the fact that there are a lot of callers that submit bios, has
>> led me to the current approach.
> 
> We can (temporarily) pass the gup flag to bio_release_pages or even
> better add a new bio_unpin_pages helper that undoes the pin side.
> That is: don't try to reuse the old APIs, but ad new ones, just like
> we do on the lower layers.

OK...so, to confirm: the idea is to convert these callsites (below) to
call a new bio_unpin_pages() routine that does unpin_user_page().

$ git grep -nw bio_release_pages
block/bio.c:1474:               bio_release_pages(bio, true);
block/bio.c:1490:       bio_release_pages(bio, false);
block/blk-map.c:308:    bio_release_pages(bio, false);
block/blk-map.c:610:                    bio_release_pages(bio, bio_data_dir(bio) == READ);
block/fops.c:99:        bio_release_pages(&bio, should_dirty);
block/fops.c:165:               bio_release_pages(bio, false);
block/fops.c:289:               bio_release_pages(bio, false);
fs/direct-io.c:510:             bio_release_pages(bio, should_dirty);
fs/iomap/direct-io.c:185:               bio_release_pages(bio, false);
fs/zonefs/super.c:793:  bio_release_pages(bio, false);


And these can probably be done in groups, not as one big patch--your
other email also asked to break them up into block, iomap, and legacy.

That would be nice, I really hate the ugly dio_w*() wrappers, thanks
for this help. :)

thanks,

-- 
John Hubbard
NVIDIA

