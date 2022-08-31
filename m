Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31755A7236
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 02:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiHaAGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 20:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaAG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:06:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3C261122;
        Tue, 30 Aug 2022 17:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwdMNYvQPHNIhGOEXKqftMuWWrIZ5mjjbRktX2GCLD0nNlJaZTDSSpI6pXFiGX71F6RTln5Y/oxRCNYXYw8wNBePm6bvjSu6+xSqlKqEKhghViXQtFPaKG/gp+qnJPp2o/KBpwvWFA1ype8sFpXd/K8Jhs5r5ctDlfNLqWrYZWYGGCTB0jaLIezNzCyPd+Gfz8oynW293pENV7s3yA5LPUNbPwnE9A75Dsc1nwGYhJalqUA56WORRsf9/Rc5XhTkXT7fMCIa5H3NlGBm0DE5MCis9WI9Fcc73jwgvtIkqyBzMgJYgKdcLDhCAwqps31RrLhjfQqj9uuBrPnXJ1ENsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZM9qkQWLPwKpz3U6oXuN+PEq3S5IVnnSz8KSRlJiKQ=;
 b=GfY2RG+wU/haTqxG/1cgOZ6mCO9gD4L9MVbkbM5Tsjfxf9ctAaP+fSE0kNaslWNVKDt801w28ftdGVdJ16myQmYulhuvUJdOISe6I/qqT3Fhb5dkcqm/6jo7MPaMs5r8vbSbOX4uo9uBDnr6THlzrE0cGTE1tDifkN3eUSWGBkedsaj0nzMM6WTjunUuDe/84BYlsjtDk9udGbmjjnBKLnd1Dc94q9SiTuPtBxRwPppi6I1gFWzuKmXHtpHP4IBMvf3UGHuyyZ3nVrf098TVFmuA+GTbziRwqe5KQoLPMSs/dv93C1CvTstZ1vJqXVBfI63C4cKP2QWzdT47x2DhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZM9qkQWLPwKpz3U6oXuN+PEq3S5IVnnSz8KSRlJiKQ=;
 b=ts/ZTL2ZehbE6mzmB12Mdt9YtrDXd24JrnPIJL8geJUHJFKXStbpjuGctY3bn3qdNX8ga4uEb4ayVfIxMvEBE0y5g5V3fqivmz77ksAwI15Z2cJCPT8sH1rVLf+VQIzeqd7bl3DqzJZvAbPGYXDs9VV/a3P70TfAfGH9KgUvXvoCYKcIElMco6/+IG99Va4vsk8Q/mn5sPWhPbQJUh/qbuyiCiU/f/J2oilqgWWnomWybKhzJQYgs3gkf1Gd3+jcaa4wYac/gzJmXL59eI2zr/W43qMvuj07YHy8cAuYD5Q1qiNXiLxOI+z59bQEGphqJlVMFEdWEnpnM2/Sn8sSbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 31 Aug
 2022 00:06:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 00:06:27 +0000
Message-ID: <b28ba728-f879-7c11-c232-80908bd42853@nvidia.com>
Date:   Tue, 30 Aug 2022 17:06:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/6] mm/gup: introduce pin_user_page()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
 <20220827083607.2345453-2-jhubbard@nvidia.com>
 <10a9d33a-58a3-10b3-690b-53100d4e5440@redhat.com>
 <a47eef63-0f29-2185-f044-854ffaefae9c@nvidia.com>
 <5aa08b4f-251e-a63d-c36c-324a04ba24f4@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <5aa08b4f-251e-a63d-c36c-324a04ba24f4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 824ffa63-14aa-4c32-cb95-08da8ae4a609
X-MS-TrafficTypeDiagnostic: MW5PR12MB5623:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HA5ba7WFcGXzDKal92g76behUy7qAye/2GbMHxPVwLSpO8Aw2MYuvaB825ZZqBXyhQ5eWXtidS/Z2N9NE6KijBx4/ZmqG5CdS47p0iZ8Rwf2nsaMhQJS73GeBMGhIjMK/dxrS6e46TTROhNP7fIcRwkzHl4ya6YzPdb0Ht6l6wyu+uh4uL+aY1vNJBPK9Qaw6XtKOElE9fOdQ6Kloj0m4wWzzJdwCPtcX2kZxkYNpzuEb179b+v0gRGp4WXmds+8Qfy3inrr3n3uWQv6+OASXl2iq8oK3Nab7Ox74e/Q+tT5GlbabGXUgPZ4BRQjivoRwbxGint7RFG5lKBZYIaqrj4JaYZY/gF0erKYFt72alK3iO/xfmL5bykVa4/QuMv/BDVQ08GXWEMwJi5x9Pa+gv24ePTbg4lY9AZ/dFVKO9HCg61GMpWoo+Ey3xTHQ5CGhV7LmgCMVp580uEqRRzWHlU+8TWHKNoDvRY+tzHX5ctG5JSilpFrUckpUjyknriOSjLSsW/3O2Qvc58gUE6CcQGxREd6UnP8vrVIRUY1DSVUlLd5GVx+dPa/Y1SuryYwODeLmoSxAVda6IKkRnQPFst3To0p+GnDM/qQ+pGoXVUDTfagXrmKleBu2XjIPOLgFIXBA5s6rcMeCXk/CKLEabkR2NaJrGjGRzAi9kqrqS6JjOSUzd/WNvoYx+RbOe0NO3b27HJ3KSQsiuuQ8ZBrz7f9kkwWrZAVl5IoMstdueAtNQ5KjI45bm7g2cpdBryvL1lIjeKD2JsSd8B3PIdK64THwFj0KWcTng/qvr7IEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(31696002)(6512007)(26005)(4744005)(6486002)(2906002)(478600001)(53546011)(6506007)(86362001)(41300700001)(6666004)(54906003)(8936002)(186003)(38100700002)(2616005)(31686004)(66946007)(5660300002)(66556008)(8676002)(110136005)(66476007)(4326008)(36756003)(7416002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk9JdDVGLzQraGMrYmZDUHEvdnhMRW0rWlJlT28wVE1KaWRjcFFuUS9kKzJV?=
 =?utf-8?B?c3oyVTZFOERFT3lUcTBtK3JVVUtHbGIzQUhDZk01U3NLQmVRbDNjTVBCbVBk?=
 =?utf-8?B?N282cUk3c0tWVjdWak9SVkJPN3Z2bWNXMkhrYXM1d3hlamVDQ2J5Ni9hRkxD?=
 =?utf-8?B?R2FlNTB1Z0NLbTdYcmVIVnpZK1kvNGxISU1mK0lyeEdseXZHYVpIcTJjajhU?=
 =?utf-8?B?cTMzRlp5ZHV6TlIrMkpRWUNEb210ZGc4Mks3czBtczArWEpab1IvNExJM2NU?=
 =?utf-8?B?a3Vva2ZxRzB3UVA3b0ordllROWQrVjNCOCtHb2JSM3QyckhMSVp3OUNDZmVE?=
 =?utf-8?B?QVIxNC90NE4vY25pWElZUmdUczIrWFFldkRRMHlSNDJyZVU4UkZsdGVlazJO?=
 =?utf-8?B?a2JWRUViWUVqY1FBLy9oVkw2dGpwRzFhVHdLbkc2MDZneXVCYUdMR25Mc3Yr?=
 =?utf-8?B?U1gwZVp3TkU4YlJTMkJOT3FiUHpGNlQ5Wkg0MExzQ3pkVXZJS1grQzJLak9Z?=
 =?utf-8?B?Z1ZtaGRLS3lKTXhZRUdPVDIvYjBnM0I1ZGt3R2VZbFpWcExPSmM4L1hyNEt6?=
 =?utf-8?B?WHdBZlZ0anNSSlMrQ2d5Q0FDSTNaNDlGY2JmQmNZVE1KZFJEWXB2WXozRWE4?=
 =?utf-8?B?U2JLSVl5alp5NnJqZXIvUk5xOTVzOEF4RFpJOVNQYkkrTXlYM0dwWkZXY1VU?=
 =?utf-8?B?V21FVzljZldPVUpoVHR2ZE5TTjYram8wb1MrV3ltbXpiSWF4VTVYRUY5bUJI?=
 =?utf-8?B?bnFyRDFMcFNSVDYzcmVFY0tSdFNCcmp0QWlyNnp2dmQ4R001S2FQYnk5V1hI?=
 =?utf-8?B?WjBpUXRXSUtjcFgyT2ltRDBsQzF0UGFlV3M1bnk0d0dJeEQrQkRFeXNuVVpi?=
 =?utf-8?B?Y2FHdDVDZjZsLzN6SDlsOWlCOG5NYUtibjlOMWJJTlRVbHRFZnFOS3hLZ1l0?=
 =?utf-8?B?WEJYSE42aEcwRDlBYUdQaXlXVmIvTmFrNy9ERnQycmZOU1M1Q21NWXBJS0JH?=
 =?utf-8?B?SFlUb1hWK3NXQ3ZaZDJrREF6OFQ1Y0ViZ2hOWHQxUUxMQ3BxNThYaml3OHp4?=
 =?utf-8?B?NEhodnVocVM2cDZPSTI0U3RvUlZHUnBpeTdoRUN1Q0dUWldpbkpZUnRVcHlP?=
 =?utf-8?B?MG11dUxveTdjMm9OeFBjaEVuYkp3SXlpV0pRSVdxTmFZYlBRaFpmU3Y0anNQ?=
 =?utf-8?B?Z0ZIWnRGdzZOb1ZiMk9wWGFJUzlVL1dMY29EUUs1UXh6NktPL1EyZjF3bG1D?=
 =?utf-8?B?YUVWWDVxOVVVdE5QRjZpbEpDSU9uRk1pdlYxeGZlSjVnWWV1aVFUSkhKUjY0?=
 =?utf-8?B?a1VXYmhrU3M2Yy9KMkY3dlArM1hHOEZHYTNmRUgvYStyU2pHTTlMQjBYTHJX?=
 =?utf-8?B?Mk0zVHlrQ2w4d0UvVWt1SzlUdWxzZHRUdTRRakgrMmVYSGpOZEpVMXNkOXRq?=
 =?utf-8?B?SkR6ZnZMcmRuSm9paGVKdnBOVG8yeGNHUXRxaFUwS2o3Vkp6V25OQ25NalNh?=
 =?utf-8?B?cTZEQ1hQK1RDSVAzR0k0YXZLSFZ0YUZyOGZPN1FLNlBkSU9uU2JGeXViS1VH?=
 =?utf-8?B?dnVxYnFGOWhpVk1EUW9zbTBoOXJweGg2UERhWnRiT2ZYUkxXZVJERXgzcm9N?=
 =?utf-8?B?ZERScXBSNzBUZDVtNnFtdWxKV1FyNkwrdnRLOEtpTXB5QUxKbE53Wmp5ZlRD?=
 =?utf-8?B?eEhLdzM4WlhpTms4dUZ2b1h0UHFPb3J2UG40NVdFaEF5Q0ZNaHJ2N2RFdHZU?=
 =?utf-8?B?N0NQZTRhaHZBTjZwMlhDd3ZseUhGN2YyQkJ3RWh3c2RkNWtGNlpsbXhXY1h1?=
 =?utf-8?B?dlRrRlRXbVZTdWd1YzVMY0h6c3ZpbHovQ2E4UkpJZDQxSXhiOUxITlhSdDNm?=
 =?utf-8?B?clNNbERBNU8yNnFXZm1ROW9KVGlWQ0Q5Nnh1T2xTclNYSjRxSU0xZW5mc09G?=
 =?utf-8?B?Zk5jZHgvdytSalVpNUdQMmphbGVIdGlyUjh6UzhjTTFZdk1jSzd3RWhsaHhD?=
 =?utf-8?B?WXVFZlArK09xYzZDNHhqZW5MNUt5alA3TFREWGpRWThTMitOdGc2N3hRWlBO?=
 =?utf-8?B?RDY4VkdQcGxTdkUrTHYrb1NQVGtqTEo2TGhtMXJiY0x6NjhIUWpZaVgrVHVo?=
 =?utf-8?B?U29weHRjcmdmdU9kVkhnUGpvb3RodUxlUDUyYW03cDMvN1o0cXB4UEs1VVJI?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824ffa63-14aa-4c32-cb95-08da8ae4a609
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 00:06:27.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2x6lm+o9bjpTZMmU45zziuIENfSBqOgVywUvSsGSahz0+oTmtcYnlR5Hf080PW1LZ1t4zjXoU1boUzX7LJVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
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

On 8/30/22 05:17, David Hildenbrand wrote:
> (side note: after recent VM_BUG_ON discussions we might want to convert
> the VM_BUG_ON_PAGE in sanity_check_pinned_pages())

Just realized I skipped over this point in my other response.

So, there are 28 "BUG_ON" calls in mm/gup.c, only 3 of which are 
BUILD_BUG_ON().

Maybe a single patch that covers all 25 at once is the way to go, I'm
thinking. And of course, any patch that touches any of those lines
should convert to a WARN* variant--whichever lands first.


thanks,

-- 
John Hubbard
NVIDIA
