Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FDB6689E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 04:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjAMDDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 22:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbjAMDDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:03:34 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B84625DF;
        Thu, 12 Jan 2023 19:03:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jja084DOvHz/ysl6drtblRoGPkerac58FjSfr5QRwAVlwwuNY7Xncux5MZZJ55R/Ta9O+KqcHTwHev6Esd1fBn3uFF+okKLkBUK69kL42NI4vxfPMyJm/BT9Xne/l+hGfeiZnM92dMimAGluE7s5Y4G2ZFnPz/zs0r22DS1WWe3mI3rNc0MclDLWEsU5q4ryNZQSmHu+YnIi65CDJzHYml8fMM19GdurQFgbvQ77TU2KZFts7CaK4gHUpZxo+jySN5vXywAxpx6WT6h04qCxF6Kjo8c5ovsmGJOD8hC0iHvyA8d8DVdg688eNxFBKi5E8NwbDxpaEF93NeCBSdi/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vTBhXyIif/stiznOMHNZceBPP7AhXrVUJXFpMBI7nY=;
 b=nfRhn1h8szrl94IYJ3gNSWNQhcQXifiKHWzdfUpVYr8oBBR5XETVQH/dCJipGP3SeZXIVlpiJWD3HUFv5swVMUh3KV5vCA+/rxc2Z9c5X8qYjsYg1fYP1YfZeQvJJuK/e/LcybG3ZR7uQw7BOPtNm7/bsIZP4/Tmp6+8gWfNHkdzs5KbA1J1w7qHUABuMSdrBosBz2lPkfdISOgIHrL228sDpQKXJ2Yjzr2EaGei91pcbV+TiUeZcl2M6KnTCe3hYFh2GsX0F6zLlHW9QM6/gfJkIRw1C71nnnUN174HAzDaRN1Dyd2aK+dPKXSV5YEpmo2Nd1hbtooh4JiOhRqEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 MN0PR01MB7658.prod.exchangelabs.com (2603:10b6:208:379::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Fri, 13 Jan 2023 03:03:28 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d8d6:449f:967:ccb5]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d8d6:449f:967:ccb5%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 03:03:28 +0000
Message-ID: <c2b5b3b4-d5d0-bf35-d659-b2328689073a@talpey.com>
Date:   Thu, 12 Jan 2023 22:03:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 09/23] cifs: Convert wdata_alloc_and_fillpages() to use
 filemap_get_folios_tag()
To:     Vishal Moola <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, pc@cjr.nz
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org
References: <20230104211448.4804-1-vishal.moola@gmail.com>
 <20230104211448.4804-10-vishal.moola@gmail.com>
 <CAOzc2pw9WCgHyA2epbz5=HEWN4bFzD4C7zL2452J_egv7iSLrw@mail.gmail.com>
Content-Language: en-US
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <CAOzc2pw9WCgHyA2epbz5=HEWN4bFzD4C7zL2452J_egv7iSLrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|MN0PR01MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 6099c8fe-fcff-41dc-95df-08daf512bea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogdor07xuDclJYNPGsRbT/sz7DkjlBIprcyyJ5VDb/QP0ZSqEspkIsHjDr4O8uU89V2ODuYmhU/2S6+E/i4Be1KVoFyrrWobvpnuv2OBwE6qVoYJ64NxpC+rTQYqfIRGMR6xopiiAnahLSQdaE6pUnRBX4s6AYauPdOFzOkxhgHRoMUH/kLt5p0JFThAjFDRFA/FmI5d6RXRcyhwDB6gWCsBIIBAaSJ4d/yOP4b/DiSGzP5WUIMbAbI8qq+46oFGwfb2a7Vm89dNVkS3thQH/NGP/48HAtGgoYyRIHMUCcSq0fyPpcz7lYInM7Q1Jj9sJYMfPHUddCAU8LH6Gq1RjBkmqL8UwY0WLvW9KuwxcQoffX9x2X1EntdTCgmxOvAWik2xu8DQPM8j9qSicQxazWile3NeB9jB/sksQKGSnZ/gEUJTLgM7+svaFiV3/HvVmkd2wwzi+LUyMamL/g8NTRLKTjMEu7z8MnHtF80a/8EXO1YgWGlwHM+2Y5CUHsSk3PRHv3AxPorc/E638x5n9eLn63OfiRuLujKsV3J8VN3P2utiW1L0AlfBVHfM6wobEcj1iFjrl0S7LlRwQgUz7tIsR0vr89AirxRLIc7n0GH27q4ABpPW4P/CULFUiGKu3vdvWNJZwZqsJ6DBJNqjLH2Y6qSwlm8hHoHtqSNeJGBDNyvP6cj864OsxKPB/k1qukyWWuQsuzXKasMvdRcNMOeD6p2qMD6QMT+7Tzvm3C8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39830400003)(136003)(366004)(396003)(451199015)(41300700001)(66556008)(4326008)(66476007)(2616005)(316002)(36756003)(66946007)(8676002)(86362001)(31696002)(38350700002)(38100700002)(5660300002)(8936002)(83380400001)(7416002)(6506007)(53546011)(31686004)(6486002)(2906002)(52116002)(26005)(478600001)(186003)(6512007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzhCR3BscWI1QVRCc2thUzNHVmR2ckI4VTNGQnpoc2cwbTZKZUVCUS8zTGpD?=
 =?utf-8?B?ZG5vV2VoR0FlWWQ1dFhrN1RDakhVZ0dwaWJqY3NKNE9LSkZueDk2OTJSbnlW?=
 =?utf-8?B?UXQxYXlydnJOQnk5TU8wUzZBS0tMbEhzL0xOZWdOaEt2Y2l3d2Jwa3JqdXk5?=
 =?utf-8?B?a3lMeFFkYlNyclp4QUZ5YW9MMVFKNUs5bnRJdFlWamUvTFZ3YmxHZGdEUTdY?=
 =?utf-8?B?U3hBUEs5MDlhM1BDb2NKZWQwS2kyTHYyVTN1Tk9YMGtsVkZQbTBHbVhZdlR4?=
 =?utf-8?B?Wlp1amVGQk9CTklCa3lPMDdwelBGMjU3K2dRUjRxR1hQVkhDQ2VIeCtaUy9H?=
 =?utf-8?B?c1FhWFhYU28rU2gxRWFYSWN0K2VMOURxZWZYbmxnYnFReXlsVHN6UVMzNUgw?=
 =?utf-8?B?ckdHeXBrM3hoeDVxdnh2L3Y4NEdMbVNXMTN0dVJwaEtHR1FMUUJYTnQ3TnRC?=
 =?utf-8?B?ZGpudG1IdWFJRUdzVlRWR09UY0pGQjNvcFpUUjNoTFdxYTZWQ2ZNZmJVazlP?=
 =?utf-8?B?WU1sZGFJa3hpNHdKVi91d2pLb1ZEVE9qdERBNDBxL3lLTDZXNzV5aVlvR0lj?=
 =?utf-8?B?UkwwZjhhbUZGS1d1UkJaUVJZdlMvOEd4V0tOMEdmWDNBaTlSeVBibW1Yc3FU?=
 =?utf-8?B?aVp0blVqSWx3UnBIQTNBVEtIZm15QXRSWlpTMW1UMTBKczB6M29xVzVRKzFq?=
 =?utf-8?B?aDYzcXk1bE1PMis0SDhxZDlSdjIxVlFRTzYrSXdEKzM1WkhsN1IxNUxFUnkw?=
 =?utf-8?B?bzJ3aTUzMGVGcW12aGVlQ0VlSnFkMVhTOUZwb3JFY1pwUUJyY0VudlF1WERy?=
 =?utf-8?B?bjFoRnRTNHhleGVXMmJISldNQ2g1WkV0Q0pjZ3lnSEV2RnhObW1lYVZFQWFn?=
 =?utf-8?B?ZEZSaFJoQ0JSeFdNeVZyamhLNjNUNkVBaDJ1Z1Y5ZUdyOXJWOXF1VkxzOEQ0?=
 =?utf-8?B?S2k0T25jOEEzS2t1RUFNRCs4bHNWRGUyVk1mcE9SQmllc3hZL3lIWlhWQ1Bt?=
 =?utf-8?B?K0VQanVjSytmT2JTRFVINDVKdkUrdTE2UmIwUW4rSXRka3ZEQm1mNUxBK1Rm?=
 =?utf-8?B?Q1E0Wm1jRVJVOEYrdXdaOEYvK0N4T3p6NWVaSythNmRGQmhjSkllekJMUVZE?=
 =?utf-8?B?RWZFdlhWRHdBak5UMTliZFBvbVNQdzB3c2ZqZ2ZDcmkvbzNaWUE5S05PS0h3?=
 =?utf-8?B?WHFqK1lRZ1NVSHJlU0hmTGs4NjVqcm0xYWVIRjhkV1ZabytyeUFKN0dNOGVa?=
 =?utf-8?B?dE1XODNhUXFPZmFQSTBGbzZmNXFaZitkd0lIdS9QSXZ0ejZaN2xJdURCN3Ji?=
 =?utf-8?B?ZmtiOHFLaksyREVMdzVlNGpzZENvRDVuSTNPSVBoSE4vRHNMV3MxQVgzSVM5?=
 =?utf-8?B?RnFESG9LT1BhcFRCRVZMMVJCamQ1V29oaDdVQzNvRzR2eVRyNk85aTVSdDli?=
 =?utf-8?B?MU0xelREamI3WXBOTzNCUUthbTlpTWZuSUpCdzNLdDRWRGtZMm1WeVBuRksy?=
 =?utf-8?B?MzQyYWtjZmdJSTBTanJQTjYzVHlxb3dHOUN5UjJpK2pvM0VWQzNXVUJaYkU4?=
 =?utf-8?B?N0p0S2R0QXFSd1gxZU9ESlBSOTMrNEpsdmFjZTNZWWNZT3h0Wk9DQVhLekRn?=
 =?utf-8?B?VmptY3k0ZlpwWjcxcWpzUVF1dytXbkRyM2xuNlRkS2dBbkFHd0tCRkFwNjJ1?=
 =?utf-8?B?OW13bjBIdW5TSTcwOWtrd1BLNkVsanNSTkM2UktQZTR6cStrOEJkOWQzdGdr?=
 =?utf-8?B?d3l6ay9yM0o4TG9kRDdGa01ralpOREF6RXM3NWt1ejFhdHZxQzNCUzVoZXRm?=
 =?utf-8?B?RTZaekQ2MDlrN0h1bXptZWFvOS9EaGNJcEptNjNMRFVITEdxZ1lEb1ExQ2Zw?=
 =?utf-8?B?eVpVbUxscHFFeFJ4LzFtaTdnWEw5aGpNRHM0SWNVcGxOb0RucHlMSjJ2anAw?=
 =?utf-8?B?K0gveGUrV3BWZ2xtS0NlbVNFaHUvMDJ3RmhqK3cxekJsNEFqVEtwVjFFVHoy?=
 =?utf-8?B?STNJb2crSHpBK3pUUUhka1R5YW9odlJvdUhSdnludUw1L1d3REJ3VzFHMldZ?=
 =?utf-8?B?YjNwYzFoc0tKWUNBYWZLazVYbWtFUXFwK3NMaDdIaTErT04vZXlnQjNUbTJE?=
 =?utf-8?Q?VC8wdv4CgwH55vreVT4b906hn?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6099c8fe-fcff-41dc-95df-08daf512bea2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 03:03:28.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNK8TCcsfiAm8iJpU/mL5rmUpyOxGTchhz9GynVpwsSRFaDDa6D2It6URxWjAJxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7658
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This code would be a lot more readable if it had fewer goto's.
The goto out's are ok but the again and add_more are easily
eliminated.

Two possibilities...

On 1/12/2023 12:19 PM, Vishal Moola wrote:
> On Wed, Jan 4, 2023 at 1:15 PM Vishal Moola (Oracle)
> <vishal.moola@gmail.com> wrote:
>>
>> This is in preparation for the removal of find_get_pages_range_tag(). Now also
>> supports the use of large folios.
>>
>> Since tofind might be larger than the max number of folios in a
>> folio_batch (15), we loop through filling in wdata->pages pulling more
>> batches until we either reach tofind pages or run out of folios.
>>
>> This function may not return all pages in the last found folio before
>> tofind pages are reached.
>>
>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>> ---
>>   fs/cifs/file.c | 32 +++++++++++++++++++++++++++++---
>>   1 file changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
>> index 22dfc1f8b4f1..8cdd2f67af24 100644
>> --- a/fs/cifs/file.c
>> +++ b/fs/cifs/file.c
>> @@ -2527,14 +2527,40 @@ wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
>>                            unsigned int *found_pages)
>>   {
>>          struct cifs_writedata *wdata;
>> -
>> +       struct folio_batch fbatch;
>> +       unsigned int i, idx, p, nr;
>>          wdata = cifs_writedata_alloc((unsigned int)tofind,
>>                                       cifs_writev_complete);
>>          if (!wdata)
>>                  return NULL;
>>
>> -       *found_pages = find_get_pages_range_tag(mapping, index, end,
>> -                               PAGECACHE_TAG_DIRTY, tofind, wdata->pages);
>> +       folio_batch_init(&fbatch);
>> +       *found_pages = 0;
>> +


This is really just the top of a while loop:

   while (nr = filemap_get_folios_tag(...)) {

>> +again:
>> +       nr = filemap_get_folios_tag(mapping, index, end,
>> +                               PAGECACHE_TAG_DIRTY, &fbatch);
>> +       if (!nr)
>> +               goto out; /* No dirty pages left in the range */
>> +
>> +       for (i = 0; i < nr; i++) {
>> +               struct folio *folio = fbatch.folios[i];
>> +
>> +               idx = 0;
>> +               p = folio_nr_pages(folio);

And this is a "do {"

>> +add_more:
>> +               wdata->pages[*found_pages] = folio_page(folio, idx);
>> +               folio_get(folio);
>> +               if (++*found_pages == tofind) {
>> +                       folio_batch_release(&fbatch);
>> +                       goto out;
>> +               }
>> +               if (++idx < p)
>> +                       goto add_more;

To here "} while (++idx < p);"

>> +       }
>> +       folio_batch_release(&fbatch);
>> +       goto again;

End while "}"

>> +out:
>>          return wdata;
>>   }
>>
>> --
>> 2.38.1
>>
> 
> Could someone review this cifs patch, please? This is one of the
> 2 remaining patches that need to be looked at in the series.

It's otherwise ok.

Tom.
> 
