Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED5E4C4EFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 20:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbiBYThQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 14:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiBYThP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:37:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E382C21045A;
        Fri, 25 Feb 2022 11:36:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpSlAtaVCOg0+JhwzK6BABoRSjB5naiS6x7O+ylBLA5ms2Z6eM9Cu+HuHosi5eRwYAAzBU2fnbpTVSmtry0B9LHy7pZnBm9jBoVGTtShP3LqcVma9OWlnapi4pf+/JgNa5vhKRjm7S4bkDPyuP7K8tRlhZ+1JJl7nq7uoUVaBv9Nn0M2wsFpBG4MjgMmnP5dzUA9bOrq8XAbVxzyJOLQOgQEXWApP8OoVCXEZwQ/7RR5EoZFZVa73rt50zbTgM1xcEVj0QlJl7brHn6VVpS6srF9GaSORophGJIy90xspcxdm3QYeb8RsAjdqZkJrf4cXjR9d1xFyLZSyp7phbbE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osW+fiMpQ5DGQWhRXc1YTy0UyLuUOsCuwvkcq5IIJ74=;
 b=Smqze66T2nViPUR0fTHrqRkNENwFgN+7fbvBWeHOjwGCpY2BZNjx/rvXarz1VhEFMlbpsC+o/DGMZVBtCwOWOoriO+6L3Fg7ZEVrpsoDJElIarIAKekJWeoZIB+l9gXUAs/JC1GCVs/XEXpiz/z11fRDgqYtonuaGGgZeu865JdCBic4+uZje4QY7XolPv46OMdi3vmDFvu6+GsBItLfSHPvkD7ED7r1qeUDWFoOUPTEeED5VW5RCcOU3tli06LIm64vSwpdbOxX9nsQaVmQJtPIwYA5KmrrvJxrBUTYCYTnUC/24UInwy7FPHWizoWLXBcwrxPwgMa8P8g9UoTSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osW+fiMpQ5DGQWhRXc1YTy0UyLuUOsCuwvkcq5IIJ74=;
 b=qt2mKr4x3xdSMPEeApJxQyvMTzV2KAfrRdUUp4uELPMyO+pOVrfnHvZa2jSITZxff1I2ymh0XmuMzey7JiqwyzYg3MGHEaVN/dq+7AOuvYk0ZMYPeswgqsJL+KLC30bLT4tm3pDECM8q68LXrSkad7kbWJMaUOxldBSha9w8LTNBrRMOHw1ELHIkEOvykrGCcBbh+IG7ylaHNk2OsyMPKDRymUSrnwepkJF6HgFEKYoe1eu9KE5v7VkRh2QP/hHS63QpOIxJkbPX/6T2d4mBfsDG7Etd4Wd9QvFkrnsIN5gjIN7A89fXelAf/3JFb1vD8JTXogTVQr3NiFTrk4wodg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM5PR12MB1723.namprd12.prod.outlook.com (2603:10b6:3:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 19:36:34 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 19:36:34 +0000
Message-ID: <d2b87357-baf9-ef1f-6e6a-18aab8e6d2fd@nvidia.com>
Date:   Fri, 25 Feb 2022 11:36:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/7] block, fs: convert Direct IO to FOLL_PIN
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
 <20220225120522.6qctxigvowpnehxl@quack3.lan>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220225120522.6qctxigvowpnehxl@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a7ccdf0-d6b8-447e-18cc-08d9f89621ac
X-MS-TrafficTypeDiagnostic: DM5PR12MB1723:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1723D4B07E6228285A453214A83E9@DM5PR12MB1723.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUqFwK/SmjgcOKlCGhs+NYYuylwjusaaX6psdoePeNGhOTSbbMjyVFpyuk2RQuWu09Bh6tVpeVlLGTA6IcR9hfxJrbmY1xjApLaEB1zHH3RM3hbXQd5OeyAsObxNPHbaiFsQw2v9szGKDv8kHZ8k2oH6xv3diaLXjl08OiQo8XdaKgeqW0UtKydEpTxi9Z46b0DHTA0Sp8dtGVidJUfDHYuMIp3yhfR6Y+0Ie9ggzCtSeVtqUYtQGWXVLTD3DEbLDRvERE3S6r0HlIK0Q7LYpDnJfXdwnna4uEPt47R864jV0S8jP4W1dxArycAeI9BhjPYmtjzK3ysCXaJZY3DNoOj0FUc3jIP1ytNG82mdOBAopC6fXIRjE8OMIdN5i5SVss/9zpjSSNxyoCl9HhZY1DqE9ybfBQtBFWMfY87qxri7BtW1UkyGU5JSeTfU1oWRuZE0ugQGQ6bmYN65C4QUyEg/QWyf1jJUAIbtt51By2qXoW0KW09ycaoQH6Vlx2XNmH6wlYFh48wGA+w69RyBVhQpZmia24zYtFvlBIWJsMMlUXhmRma2umz3sXvd9p9AIPuD5ogUAAJQVhtvhwn+XPuqkSwOxT7lvwjkoeTN4QmnN6pOj5SntGwd3VhDOZhygyIZMjw+5lFfkvE8aGlmnQaaMafcE+uT4kGlUU3WOoh0DgR/0mPaYNN+f1gAy94+UWSD8FT9DwkKij4N2yvjfq+SwI6d++2oEqJizX4FJS0YhLTwitPi7EGAd09DmJxI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(26005)(186003)(2616005)(38100700002)(6486002)(508600001)(7416002)(5660300002)(6512007)(8936002)(53546011)(6666004)(6506007)(86362001)(66556008)(31686004)(66476007)(66946007)(316002)(2906002)(83380400001)(31696002)(8676002)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWowak54dHZiWFU0YlgvL0xtQkdRcEdRK0pieS9pajVqc1pVbDlGeGx0ZlB1?=
 =?utf-8?B?TEdTWDkvanJYMHVQNzNJRkJKaEJ6QlRkbmlWekZVNnlDRDU2WDZid3orWkpI?=
 =?utf-8?B?Ui9TYmVpUTdzalBUak1oU0lvUnUvQjZQT3NXR296c05DdzM5S0NrZUJaaEUx?=
 =?utf-8?B?MHRLUENKSnVGbVVnOGl2VXhGMkpzVDZQQ2FsckQzZzZObHhhSDFRZDlMUll5?=
 =?utf-8?B?eFhZUUNsc3ptWGkrRWloV2Q3ZkdmYVFZSUVxWmdWV0ZjZEtrN3RFYjh1eDEr?=
 =?utf-8?B?eWlMcjZUSUhTdklwZ1c2eEc0NnZoTDFzVjlrQVpLNzBXdzNFMUwwVnNycXpv?=
 =?utf-8?B?eVZFY3hWc3p1TU9DSnI3TThtdS82dmZTb0h1Y1ZldEdnbGV0SWpLNzdINmNH?=
 =?utf-8?B?am5MbHRnSHEvKzJBSFJxdmN2WFJqZHMrVWNRUUt5QlNHdFhiNEVpU3lLWkFa?=
 =?utf-8?B?UlNhWW1KeUxnajh5c05uRURRNi9RcVZSNEMxNGRqSDB0bWgrdWpxUWRlc2pW?=
 =?utf-8?B?Tm9MZ1dUQjFMemFYdHY0czA4WUpmWUlBWnZUMVhtYWs1ZkVKUUxQN05DZ1lQ?=
 =?utf-8?B?WFlwd3dpWmg2dnd1ZWVueHlPcU1xNUpWaXRuUElaYVFIa1U5NndacGNmQXJp?=
 =?utf-8?B?QTFodXpDS2FFSS9XNEdCSHkxNFBXTWNXU3ZTVXcyT1RNZXZVeWVuK1VFaU50?=
 =?utf-8?B?U0VQcEZ4WFlqUU5JK2hxNWptVXRKWEpDQ2RGN1VESG10TDY3eXlYVnBEUkMr?=
 =?utf-8?B?b0JmNGI1UEdyK2lGZXBMVkw4aXVkU2lYdkxVeW1ReTQwcEtUNmgvcnJsVjF1?=
 =?utf-8?B?YXpMR1M0cW5rVlAvMDlJQnZkcUpKOHZrZUoxWXhtdVhRZmpPc0x3OE84SFBI?=
 =?utf-8?B?dkNPckozeVlYZHhCZkFVNCtwNmt5b0gyd2xRMk1TZGdOcWF0ZHc5b0FYMnh2?=
 =?utf-8?B?cUFGZDNIU210Y1dEdlgxcU1pRmlKaG1tY1FjTm41RlVQWW4yYlBwWHllVURP?=
 =?utf-8?B?SEhLbzN3NVl5UG0wZGlZNkJXUFhoM0pBbXpZdk8xbVlJNWpJc2VER1ZTSzhk?=
 =?utf-8?B?SHBxb3VCd0JZM1Zienl5cHloUXo3SjVGMWdUV2RDQjhuazZPTTlqZVNyRWtU?=
 =?utf-8?B?KzRsL2ZmZGgrK3pRdm9Qd2Q2UVh3NGxWaEV0S2dTRy96aUtVeUV1U1FpK0Y0?=
 =?utf-8?B?NDBOcTBYQU5NUVBYWWR2c0FEd2tCVlJIcXNDejlGUzF2dW9EZWFpQmhpZzEz?=
 =?utf-8?B?Rkh1Z1grVUFKb2RQdFkwQUlHOWxzVVJtZFhmZ3pjTERNejhNdVdlQnZDMllo?=
 =?utf-8?B?R3BXNG9NVkM2eEUxZWtnNzYyblA1b21KUnFwRFJJMlp1WDAwSmpMaEJIWnZk?=
 =?utf-8?B?YUc3SG9VYVBPSURuWWFPY1hJdlB6ZlhtRWxPUVZiQzZZR3lCWWVVRzcrN0M1?=
 =?utf-8?B?N3JJQkhPbDNNK3I5TWxIaDdCeHJWUUVicHluZHh4QlJVaStTRUlOU1ZHSHlw?=
 =?utf-8?B?Tit5QVRhY3RvSCsrWW4wMklhWUtiTmdjRURhMzBQL3VhQnF3RWRKMy9FN245?=
 =?utf-8?B?bUN5RGQ5djhPb2FEeC9lZVd6T0Q3YjNzTlNxZmZQc3VSSkV1TWVmMzBSYkNh?=
 =?utf-8?B?NkJUdk9kdkZyU1B5Vzh6UERObERyQktUNUV1cGpuVnJVVXNwMjhkTmRwTVpW?=
 =?utf-8?B?amJ4M3FVcWtaRmdiUDIxUHlheW4yNjQ0Yk1pVTlIbUVURkVqZjZZSEZrbUJy?=
 =?utf-8?B?WWlQRGVkYllMcDhUODJySTVmclErcUkxQ0d4OCtHTEZsR09HODU4WUxVU3A3?=
 =?utf-8?B?VVJXc1JsME5oQUFDRG9Qb290UHZUUVZuWTlId0RXUVB5dTV3SGpJK2xBM0t1?=
 =?utf-8?B?c09Fd0g3RGt2cUtMV045ZWljN2tiTytQSURrWW9FVk40VFQyUWVFV3JvSEpi?=
 =?utf-8?B?RytQRkJ6VXlGY0Y1TXVhcWp6T0NvcENMMlphVVVPd1ZwRjQxUDErWUxoamhu?=
 =?utf-8?B?UXZ5ZlZ3ckRBZ21PNnp1dWRCNzlWYlM5OGRxZUZaRCtSNVZ1M2ZwekNDZFdD?=
 =?utf-8?B?UjVtU3g0YlZHQ0NObmptbjhvSWVtOS9vYjVwdlNMRi9mK3d6RThWZDZXTDk4?=
 =?utf-8?B?TU4zWnJzR1pFSXJvYXEyTzNyZkxrMDVwTC9jeEZ0S296cHNzcFFGVEhBSXRt?=
 =?utf-8?Q?rBKlTbqIMFZdgvdMJqzybw0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7ccdf0-d6b8-447e-18cc-08d9f89621ac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 19:36:34.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPQqNe+0pdrielX3Em4BzfxO2HioTHPFjoulEAll7Gpm95WeyxGW0YEFQoyqv82+9DK70OnWTj/EfkJz3xhF2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1723
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

On 2/25/22 04:05, Jan Kara wrote:
...
>> After quite some time exploring and consulting with people as well, it
>> is clear that this cannot be done in just one patchset. That's because,
>> not only is this large and time-consuming (for example, Chaitanya
>> Kulkarni's first reaction, after looking into the details, was, "convert
>> the remaining filesystems to use iomap, *then* convert to FOLL_PIN..."),
>> but it is also spread across many filesystems.
> 
> With having modified fs/direct-io.c and fs/iomap/direct-io.c which
> filesystems do you know are missing conversion? Or is it that you just want
> to make sure with audit everything is fine? The only fs I could find
> unconverted by your changes is ceph. Am I missing something?
> 
> 								Honza

There are a few more filesystems that call iov_iter_get_pages() or
iov_iter_get_pages_alloc(), plus networking things as well, plus some
others that are hard to categorize, such as vhost. So we have:

* ceph
* rds
* cifs
* p9
* net: __zerocopy_sg_from_iter(), tls_setup_from_iter(),
* crypto: af_alg_make_sg() (maybe N/A)
* vmsplice() (as David Hildenbrand mentioned)
* vhost: vhost_scsi_map_to_sgl()

In addition to that, I was also worried that maybe the
blockdev_direct_IO() or iomap filesystems might be breaking encapsulation
occasionally, by calling put_page() on the direct IO user page buffer.
Perhaps in error paths.

Are you pretty sure that that last concern is not valid? That would be a
welcome bit of news.



thanks,
-- 
John Hubbard
NVIDIA
