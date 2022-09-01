Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0FB5A8ACC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 03:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiIABeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiIABdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:33:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D50155D7E;
        Wed, 31 Aug 2022 18:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5VyuSwFR+wOQBx+cOz5TqUNRlPu0dHU0tyq+PA/pOQwX7hlY85tsDLVNI+Nzyefi7T6D6rv93TmzKbnzKUUBdGTedhvCdT2S8vpCXUaYOJz8xd8kmQjVrcvu8+oFQehpGeXEeqMFnw0jfn3pM9lXyPwQLoDwrtRQF3Kcm5QTZk99sv7/lt9wcEo83MuwfJL31hk0LttUVUU19vw7IRt+26wSILC1r2s/+OnT8Y3B8KJdxZOBloCtfhv+3rX4xYwGCETlGuL2/13TuYVYkrwn7ydh4KwsDrajfgivr4T/+T02fxwCT9+PwLwVYxG9w+Is4gqpSCfq1UXVHtfPI/QGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6qOEojSYDmibJdsNFsejax4jww5xD+CQiyq5aAKg7U=;
 b=YLRD8yqrfaq/pmEbW/sZjrfLucHV5Iq3xRNwqbTHpSzjOmt+MzHqZ4iJiieLE1h47MOW3pZ0OOUZ0Tz7LXtkmTMVUXe3YYWmQ3HTt5fx856xyiLjcgTpLEdNItUNFtz0ou9hE7GKMhkOeH7wHGC2s6kmAe7thcbll7o93IJZ4ZBP5EN5b3avdkItqr0dUYFyW64O0FNtbamW2h52dWr8vYdZcRvzlX0u43+xTyDOUx+mT8lBAIqnUFUw1zE1j8l9tpB0jLHwt5vWGV7jmipE6Dmb2quwjmrpO1fkA8DlBo4K6LAIXBmBfwsyWSM13DX9p0a7KBcNbr2s8d3GTIH0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6qOEojSYDmibJdsNFsejax4jww5xD+CQiyq5aAKg7U=;
 b=aX0atnJ7fWz4VSZJeQMZeyCr/ctZCZ1y8r5rBT2CeX+9V6Cdd2sCggnMdPDPI8pZJ0PAZDl4FAtYeKdxZNYIAR1oeCGGFdIPNCtmWQFRLlHQS+iVNfg1dA3B/8FIcgkA/By/1NyLuLN9toqsm7J6df5jpukNNWP+8vMDXWDD3pBhLeI4QUJrFy+ud+otxN1bHYcxUIN1gML79xY8hvRrFp7fNCYQeFGFcpt2epacBUf+vqdM/7mnKq56q7bij76xUxS3XlPxr9KsD/L+TWuVkZuGZLx3Iw7J8AQnPumWCgoQqyXtaLNhCDU59sAMqonD6to9JijbWWBNAoxcqIrgfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 1 Sep
 2022 01:33:33 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 01:33:33 +0000
Message-ID: <06d2caf4-eff1-f537-aa33-c4f0220a9f80@nvidia.com>
Date:   Wed, 31 Aug 2022 18:33:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 7/7] fuse: convert direct IO paths to use FOLL_PIN
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-8-jhubbard@nvidia.com>
 <CAJfpegvdTqdk9rs-yaEp1aqav4=t9qSpQri7gW8zzb+t7+_88A@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJfpegvdTqdk9rs-yaEp1aqav4=t9qSpQri7gW8zzb+t7+_88A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd08146e-3409-4a53-8bdc-08da8bb9fbaa
X-MS-TrafficTypeDiagnostic: DM4PR12MB6182:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHYM1SCfGd+ySSVfJnBg6KYIufj99Dm1pUSd/L9++cB5GXXT8KcMi3IoPIp4UETHgm7RhL5Wrn8nSuva67JELxoB8TOk9pU94bU0QQwjzhfqa+IfxaWFrnTGi6NCKJNbsWs5iNbkjLJzt3IwBs3WmhOgtyPI7dtdFMK1gbiTosungR+zwfHLs4+faD//69NVtTf18Axh2F6zYbOZq2KOZbltW77atqxWy7rfsyjBBl1ccIMOtUkKKMigNzkJ7BwQjHz4xwNZJsH6PGUnYwRLcDISbKqAsNzO43bm9XLPysgcfsY+IicsLIyyPe409WYkHx+4uiqV9NJAuVF5CDvR6bFHZSE0+G5sIxkBmMO/9iD7yOhJlv/YrUxHwhxSMsC9mMTFMj8zw8ByBlxeu4edFcxWBALGhSl6TPmY8TPUUj/y00vPhcl/Bd+BKbb+fM1ybiJSjZ3m13M0REa8hJnMPSH58Z8JxEhB1zd25x5R4ChA09mX4fn7pixTjLqlq1xxLqDpaHNfW1VINLnH53N+DeZRFcOHi3BnW1mqgWFPSDgnHm3+jXYm+TIg4GsNr7qSn/wYAJhQJY8aSBZlc5wVJtyp1hiWHrKD6rHq6gCbydNfAVeKxn3CGDzS7VwP4nHA9FsikylesBGMyFfcyPbqtAqRSJx1sNzlaK01ag+riC3kZxA0IrqgHQgy9ql/peYh13NcuBAN8OAwPk9qkCKULZDrWG3B+VQldwl2QBMQ6h6O7Km5E7K76tUlziWiRwHOwRu3bBViVO2Xpz9nmfK1Db6gv0hqMcwM6mohzDmWIhN6n9t/ACX6y86G0LbnBGpxnisx7QBTHB1Vvb4GTMkE2Le9vuMk0MwjO4o4x8sUrZ5KdOgqY5ODRcwoRn3q4V/K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(6512007)(53546011)(478600001)(2616005)(966005)(26005)(6506007)(41300700001)(186003)(6486002)(83380400001)(5660300002)(8936002)(7416002)(54906003)(6916009)(316002)(2906002)(66946007)(66556008)(8676002)(4326008)(66476007)(38100700002)(31696002)(86362001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZLczJnaHBUaHVDc0xyb2tuVWhrcVJUWDNvZWx5RW1UL1poZjR0UW5HcDM0?=
 =?utf-8?B?R0M0Ukk5ZHpieWhhVU84cVd6OGRNeFdSKzRKUWl3OWZ3NVZJT01TUzBnL2Z6?=
 =?utf-8?B?M0FUWmN5dHpvNDBoUDRMSWlBbENaMVRSUW1BcHFnUDBrRFo5dTd5dmJRa2U3?=
 =?utf-8?B?aDgrbklOWTdBVUxJQ3psYzNYdkhwTGVHYXkxQ2dKcXlPWmZpVFBpR0E1VEdE?=
 =?utf-8?B?K1JKdWowOFI3UlljOXJCNWt2KysvL2pETko4RFRHWk85WTVaMVNnZWxTanRs?=
 =?utf-8?B?eTU4b256anM1T3ZJWjVpU1cvcVZuK3pJZXNkWk5lTjRFY0F6US9kMFNaaDZw?=
 =?utf-8?B?aGZDU1ZhaVl6S2FXeERJd3dDTzBrYVg3TWo1R0JQaDdLUXRBMi90dy9LbUE5?=
 =?utf-8?B?ZDBVb2RITjZlMjAwUXh3eVdNYW1oQXlvTXF5djFvOS80UDVZQ0hxbWV6YndH?=
 =?utf-8?B?Z2RqVlNSUUMrZUZ6WWRONlgxSDZIN0RLbGo0UkVuendoYkFnRS8rL2syUm1W?=
 =?utf-8?B?ODZIeEFzZ0xKbkFDV1J4TitZQVp6Ni8zVzBwQUVCbThxS1Frd3RYVUZJcVpC?=
 =?utf-8?B?NytBbXE1aWVEL2JrVjN5cFYyRGNEbmlCV3BPVkhCcm1lT3hjSTFST3kzYzho?=
 =?utf-8?B?K0haWW1rZmFOU2djbmV1cERSaE9vM3pjVWJZMVltZXVwRFBUTVNZa3NWc1JB?=
 =?utf-8?B?NVBoc2Jkc2YvZ0szUWJGYXBsa1dxNk56am01RjEyMzdRYUE1REZzK0ZLNlZn?=
 =?utf-8?B?bGh3Q2lURVhkeVlReGMxeW5Mc05OQ3BKTGhaQ09RMHVuSkhzWVoxazJ2VEgv?=
 =?utf-8?B?OUtlZ1dvL0JrODZoZTc4anA1T3BjVW9weGQxd1Z4MWNEbG93OHIzSHFNZ2E5?=
 =?utf-8?B?QWJRYi9tOEE1eFpnM3RSc0ZqN1p1QWtUS3NDYnhOQWZsSFlKdDhxMk9ndWFL?=
 =?utf-8?B?Qjh3L29PYnMwYnEvNlhBZlpacG1uNFlSYmxYeVI4clFoSWxvQ3JDUjZVSHhT?=
 =?utf-8?B?ZEh2a2FVVkVpbCtVUjZpdlorQ3h1UlZpcHhWZkxsU3MvemJDM1BRZHQ4d1ZO?=
 =?utf-8?B?MVduRUxXSW4xWDlRWDQvV20vS2l0eEdacG9UbDNGeWx4ODMrc0ZWOURKZ2NO?=
 =?utf-8?B?dlpMMGVwWVhUS2ljY1BBeXh6S3J5aFVBVFJwSUlMbUMvR1N1c0toK1JmZS84?=
 =?utf-8?B?OGZiSnBjUGZ3SnpnREtTUzFPZDdsRmNrWjhEWWRTbEl5ZnJoMzM0dGN4Mzll?=
 =?utf-8?B?aHlaNzVpRDJxQ2Y3cFV5SFZXWVZrQTBSb3hyNG80MXFsYXhOd1BkejB5WWw0?=
 =?utf-8?B?emx2NUZEMDJwa1lpU0VFcUtnYkRYbWlCTkN3bHN2U3ZBQmhwVDlBTkhMTThC?=
 =?utf-8?B?QlVtdEcyR3JOeUpTRW9SdXV5dGJUZlFGV0lxM0x0VE5ZTjJ1S1NqVFJYOUVO?=
 =?utf-8?B?dVIwb2cwS3RrenNaaGZ5QWpTK2IxTEcrY2NjTHJOWHZwMlJtYUN2UElYejNs?=
 =?utf-8?B?ME1hdGNmS2czL2V6VXdDOFNnRGdaWWF5MCtWVTNJd2NwMTRXVHpTVExFMHNi?=
 =?utf-8?B?cXZQYm5BeVk3dEF2QXEvbitrNGdHUGs3cnB2UGJwMDF4Wnd1Z1Z4akk5a1RU?=
 =?utf-8?B?cWcxZVorWWliZmx6Rzh4UnROTWFXWDlmOFBFU2traWgyb1ZrUUJheW9zZnJD?=
 =?utf-8?B?alNNakYzV09sWkpsMkRNZlVlQlEvOU9YeSs4V1Y3U3hCUXczcDFsaUZIVm5K?=
 =?utf-8?B?TzF6N25kTlF2Z2RQamNSd09Ob0RiWkxseWU2cDZOdW1tcExESTM0NVZVQnBR?=
 =?utf-8?B?ZmFXUUU1YjJxNXRCaU1URlA5R3p6clNvK0l3WmFwMHE5L2JSUkJhWHY1b0Mw?=
 =?utf-8?B?SlRjK2pERFZpbHZwVXp6bzFkcFV3N0FwTjRjQnlPYnZQZjA0dmF1MVZtNzl6?=
 =?utf-8?B?RXVOUGxKZ1BLdllPZlFJQTdMRzFFRXZMaDZDNTRKcUpIbVFGNjRaNGVuZmZr?=
 =?utf-8?B?R3FJU0JBcnlQWnZIc2duTzJ3UHZqbjRwd2ZCaFd3OWp3SDF2YkhJckdiRSsw?=
 =?utf-8?B?OVN1NDcyS1REQXJqcjhaRmN0VVhVOWViQi9XRllNWlRTMlBBUnNjaDhZWEV5?=
 =?utf-8?Q?1kZ2fDTH2pYsDFvoUFFrNQoLK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd08146e-3409-4a53-8bdc-08da8bb9fbaa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 01:33:33.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40ziBdwV/tMJbALFAfGMORSQGmCCEjKv5oW5D/Nre+5zW/xS50yY+atgOHSxV8/JzVuZboRLK3OenWYEdSCvtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

On 8/31/22 03:37, Miklos Szeredi wrote:

Hi Miklos,

Thanks for looking at this, I'll accept all of these suggestions.

> On Wed, 31 Aug 2022 at 06:19, John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> Convert the fuse filesystem to use pin_user_pages_fast() and
>> unpin_user_page(), instead of get_user_pages_fast() and put_page().
>>
>> The user of pin_user_pages_fast() depends upon:
>>
>> 1) CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO, and
>>
>> 2) User-space-backed pages or ITER_BVEC pages.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  fs/fuse/dev.c    | 11 +++++++++--
>>  fs/fuse/file.c   | 32 +++++++++++++++++++++-----------
>>  fs/fuse/fuse_i.h |  1 +
>>  3 files changed, 31 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 51897427a534..5de98a7a45b1 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -675,7 +675,12 @@ static void fuse_copy_finish(struct fuse_copy_state *cs)
>>                         flush_dcache_page(cs->pg);
>>                         set_page_dirty_lock(cs->pg);
>>                 }
>> -               put_page(cs->pg);
>> +               if (!cs->pipebufs &&
>> +                   (user_backed_iter(cs->iter) || iov_iter_is_bvec(cs->iter)))
>> +                       dio_w_unpin_user_page(cs->pg);
>> +
>> +               else
>> +                       put_page(cs->pg);
> 
> Why not move the logic into a helper and pass a "bool pinned" argument?

OK, will do. 

It's not yet clear from the discussion in the other thread with Jan and Al [1],
if I'll end up keeping this check:

    user_backed_iter(cs->iter) || iov_iter_is_bvec(cs->iter)

...but if it stays, then the helper is a good idea.

> 
>>         }
>>         cs->pg = NULL;
>>  }
>> @@ -730,7 +735,9 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>>                 }
>>         } else {
>>                 size_t off;
>> -               err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
>> +
>> +               err = dio_w_iov_iter_pin_pages(cs->iter, &page, PAGE_SIZE, 1,
>> +                                              &off);
>>                 if (err < 0)
>>                         return err;
>>                 BUG_ON(!err);
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 1a3afd469e3a..01da38928d0b 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -625,14 +625,19 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
>>  }
>>
>>  static void fuse_release_user_pages(struct fuse_args_pages *ap,
>> -                                   bool should_dirty)
>> +                                   bool should_dirty, bool is_user_or_bvec)
>>  {
>>         unsigned int i;
>>
>> -       for (i = 0; i < ap->num_pages; i++) {
>> -               if (should_dirty)
>> -                       set_page_dirty_lock(ap->pages[i]);
>> -               put_page(ap->pages[i]);
>> +       if (is_user_or_bvec) {
>> +               dio_w_unpin_user_pages_dirty_lock(ap->pages, ap->num_pages,
>> +                                                 should_dirty);
>> +       } else {
>> +               for (i = 0; i < ap->num_pages; i++) {
>> +                       if (should_dirty)
>> +                               set_page_dirty_lock(ap->pages[i]);
>> +                       put_page(ap->pages[i]);
>> +               }
> 
> Same here.

Yes. Definitely belongs in a helper function. I was thinking, "don't
go that far, because the code will eventually get deleted anyway", but
you are right. :)

> 
>>         }
>>  }
>>
>> @@ -733,7 +738,7 @@ static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
>>         struct fuse_io_priv *io = ia->io;
>>         ssize_t pos = -1;
>>
>> -       fuse_release_user_pages(&ia->ap, io->should_dirty);
>> +       fuse_release_user_pages(&ia->ap, io->should_dirty, io->is_user_or_bvec);
>>
>>         if (err) {
>>                 /* Nothing */
>> @@ -1414,10 +1419,10 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>>         while (nbytes < *nbytesp && ap->num_pages < max_pages) {
>>                 unsigned npages;
>>                 size_t start;
>> -               ret = iov_iter_get_pages2(ii, &ap->pages[ap->num_pages],
>> -                                       *nbytesp - nbytes,
>> -                                       max_pages - ap->num_pages,
>> -                                       &start);
>> +               ret = dio_w_iov_iter_pin_pages(ii, &ap->pages[ap->num_pages],
>> +                                              *nbytesp - nbytes,
>> +                                              max_pages - ap->num_pages,
>> +                                              &start);
>>                 if (ret < 0)
>>                         break;
>>
>> @@ -1483,6 +1488,10 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>>                 fl_owner_t owner = current->files;
>>                 size_t nbytes = min(count, nmax);
>>
>> +               /* For use in fuse_release_user_pages(): */
>> +               io->is_user_or_bvec = user_backed_iter(iter) ||
>> +                                     iov_iter_is_bvec(iter);
>> +
> 
> How about io->is_pinned?  And a iov_iter_is_pinned() helper?

Agreed, is_pinned is a better name, and the helper (if we end up needing
that logic) also sounds good.


[1] https://lore.kernel.org/r/20220831094349.boln4jjajkdtykx3@quack3

thanks,

-- 
John Hubbard
NVIDIA
