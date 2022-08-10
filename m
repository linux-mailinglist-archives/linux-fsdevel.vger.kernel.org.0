Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B632558E6A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 07:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiHJFO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 01:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiHJFOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:14:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2135.outbound.protection.outlook.com [40.107.20.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E683F1F;
        Tue,  9 Aug 2022 22:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdvffwoB5bKeKf/CqujEQBofXRXZCR2O/EsECqddIAkYf13RbVHly1xmLdFoJsLcHk+7eSYlXnoNvHxQHRykBP1qFZ2C0AoOtJBjOpWRd9Ikx4YuMVAlUkVi4dhGKgSdjnZyveKWCG8orIkNfXtIGBj98nyMDW9mrk9s+1amnLbXtPbtBLEIkpHCE5zAJRPx77fkFiWiHIFfPWzP8RusFYBM+6yVaIZl9EDEr5acga9JLTJkuhNt3MeXAIz2epwMGpDID34GFMp5I/SRNTNxBmj7TD6Zcc7JdKkMRzuMszYF9zXBLT8jPAvUhMbSPQmzY2/O0U3Of/vbPuj0d7QUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQMGEkiW/U7Slt824lop1o211KnP0rSRk2I62lroTZ0=;
 b=HgfQinSknePCQ8kj49QklpaaT5pbBTe6jwI4Qhr35MIGYNyVxsQCnt0T6qaSpa0pqSS4QhkzXAh76yvoyavcEG5PUeFV+l4q0wI0qgx9vfH5c2TW7S/HpG/V6QcLmArvRnWjyOouik9UETGKEmwAol7Te6GWikA7DsQOn7jr3aqOh6fIiGpvwEZaTE9/G1TvYxtmSJH7aoS/iD2sWJV7fIuqLXlthEsSe0DKDPIMx/9cffRS65RbX4Up1UV0HD8HhGnD6I9PVcOG/owCJa7J8h84G39XdmunV5p5qyTJpalzZrTQytegXiFrrOpgXGBBxvq4bHcTBv60MtJ89t1a2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQMGEkiW/U7Slt824lop1o211KnP0rSRk2I62lroTZ0=;
 b=pBD9vaTc3UuWjXgQqEZiEQFYy69DSRGOr0tHBRnTmK3G9YMJVcJ6O6B3k5OZd0HJ54K4B6aUp6AIiTA5KD6DQC0jGJOu7iHJXFU+Xl7yzDVTuGjiU2oNziEOJNtfU+tx8VbNDRIY26pJ/emdW6qoVXazzwAY4qd5uWCirsb2aR5yMq16gaCpWB1AKoyIOXs7KlNi+eGL6yOLBD2rDBE3WchTMclrt/Vp369Q/8GHGM67kI00Ebp8+FJOB3a8DqShCB8WyGkJ0/TUoip+cpv2i0GOC90HSNdkfOYn/WsbCwn8WdfMTzSNi/UXOxI5jeW1Ueg/l+wwAhMlOj9rygO/iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by GV1PR08MB7897.eurprd08.prod.outlook.com (2603:10a6:150:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Wed, 10 Aug
 2022 05:14:12 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::cce4:bfef:99c9:9841%5]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 05:14:12 +0000
Message-ID: <9653d74f-ffff-6a25-8c99-5565bcab4d5c@virtuozzo.com>
Date:   Wed, 10 Aug 2022 08:14:06 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.1
Subject: Re: [PATCH v1 1/2] Enable balloon drivers to report inflated memory
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
References: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
 <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
 <5EFFFB23-9F73-4F07-B6FF-3BD05976D427@linux.dev>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <5EFFFB23-9F73-4F07-B6FF-3BD05976D427@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0055.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::6) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3243a91-71d2-420c-b062-08da7a8f2958
X-MS-TrafficTypeDiagnostic: GV1PR08MB7897:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEUuywiZLf3OXqPrbPLaVHNM16YN8pnQ3ct3YajiOE63n6Lz7a4FSU/BizwNLMhd4sbVJOU54T9dJgPhoA+BrxGzH2cRPT5Iyif7rFW+Q0SPGRYDeCuz+DhpbiZY8j/CJBlP23M7IEsEE3Vy6SbAzlR/2Ie7k2OVvljR36oap1JkRtI+4r0CRCuH9E3rd/w/2GnR4Vd2ywcitd/zuaSz70pdYW56QJMZPQI/ZDHXaPPWe0mE7p9i98ynJFQ9I+5YvbpH4x1ba8K1lCoLbRPzpFt2N1yuj31gA9Be2OfNgcRwH+1+Jib85imBMZRYj7FHpXSKDw5+wAGs9aof8pPJSa8v/DryRnsUeArfUhFammleOMBesZuq3ERh5lFAMzl/bqtb8VobFZSYheeVjvjw+svfqcehmIESXt+Juzf6Lp9h18rca0tqNmr5oy5EigPIwy1A/T/S8DOZwZ5a/epFmv7Cg++11Q1zkTUXG6E/YHbl0LKAmuvwCRWqH2FcKGOM5iIvGmJsW1BX6itHxrQuu0WAskSqmnDTETNJozURW3Kk8DclS3Obxbnc062JyBY6Acb8G91/69z5jRkSk+jpJUgUB3LkDDaguQAO6BOSGW50LNPZasPU+TKFj4Ojar71GyiSi8TQDw1lOl0AFGaG0OYcevkmTV5JW4Q4CvbA0MsBoJZGSQIlfoi6HtFiBAWLEBU87H6h4oduk+n/ceZEc7n3ODD3jXWaObG+re47oQJStxC4X/G4mLw9VZxDHZUBcs0am7DSnhYtdDUW7zRVzfVJkZ8SoP3tBBtO1UuXUJqvDv4Tz8laMDCL6OSEfxNYEk/6ZOvC74ZOEQsQRkL/iNkM09SFMEBtdYPZNeKwCO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(376002)(136003)(39850400004)(478600001)(6486002)(54906003)(41300700001)(26005)(36756003)(31696002)(86362001)(52116002)(53546011)(2616005)(83380400001)(6506007)(6666004)(31686004)(6512007)(186003)(4744005)(8676002)(6916009)(66946007)(66476007)(66556008)(316002)(5660300002)(4326008)(8936002)(38350700002)(44832011)(2906002)(38100700002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJqV1pYOG1ub0g5cXFQdWxqRTBqc2MwNExnZ1BiTXJTL3RNREZzb0FBSWpM?=
 =?utf-8?B?VkcxODVWWkt6U2MxNnhtaXVMQ1crcWhKVjJ5aDdaTTI0UFd6YUxMOWJsMGtN?=
 =?utf-8?B?b0JiVnloVnNZNEdROXZsUFhKMnVnb0p5VFB2b0RtRnA4Q1B1eXdUMFBYQjN2?=
 =?utf-8?B?dFJMTXJQWGFWY0Vyd0JBMVJBV1lZZ2srVmJkNlEya1NVbTJqcEFzSlNoTnFL?=
 =?utf-8?B?c1ZpQ08xbkFUeWg5czUrVlJCMVJLMlRTck43Rzh6KzF5dTA0MzN4MW1KL3I3?=
 =?utf-8?B?dENwdmtTQm1RWXRoUXloZEJxRHVlYU1GZGtTNEVXcDhrSm5MZjJrMWlBQUl4?=
 =?utf-8?B?MFhZVmk5QXVtOHA3MW5CUUhhMWNOMGNPS0NWR1NrUlpaVmNVeWFBM0VWRWpR?=
 =?utf-8?B?Rkd0aUo5S21qb083aGdRSUpmV3g3Z0NYMTZWeFlXZjJhK2RZNmdtOGFiWWM3?=
 =?utf-8?B?QngwZytaUXI2L3huN1UydldrOERwMmJOajZ2Zm15YnVrSUNRWVdZd0h5aGM5?=
 =?utf-8?B?andjTkNuaklaelcyUHVLOTNMaEtGNjNBZ05iRGVvaGZwdXJQbUVUZTVWSzh6?=
 =?utf-8?B?dmljeUJMRVdTTElTUk8yRlZvK3ZXaHBDT0w1b0t3UDl0TVAwSVV6L2FVSGdY?=
 =?utf-8?B?Z1cwbFI5Ni9rNUJRRDdBMVlvamx2NDZSOGZFb3hJVVJXN2hYdENRZ24rVzZ6?=
 =?utf-8?B?LzRvL2lLZG85L0tCZGgwb2hRUGVFZmtacUhjcWpwVW1VcnJGSjNLc1RKOXRx?=
 =?utf-8?B?Z0I2WW5GNnpkZTY1WkVuaEhYeUdUb2JoTGdVcjFsUG5QcHFYWnJNZU15NFpj?=
 =?utf-8?B?bi8rYVNpY0tEMDJBTzcwNVpxRWZjcXcwdzRlTVQxWXZmaFZFOW5GR3o4TGFs?=
 =?utf-8?B?V3RuWjVza2Q2R1U1cFF4RkU0cG1Xd1FyNmNXcDFFQ0llNTFhSUNPYk5SR0M4?=
 =?utf-8?B?VEswQjVtWTh1OFRWVGx2Qm1yajRyYUlJcnZ2WjJsMnAwbmtHN3FNNG03MGda?=
 =?utf-8?B?bWZRb0tkR0NBOWNURVhOR3NRMC8yV0c4RDlvRTFldXJFeVB5c0dzcXBxNkly?=
 =?utf-8?B?a1pKUTlucHRyZmxqNVIwVnhOWTgvSU53eW14UjhoRlBIQWNJVkIrbTNKbmY0?=
 =?utf-8?B?R3E2bUduVTVNMlBvRk1Vd2JNMFFTbE1zaVJjSmpDdkEzMnBneFArZ3VLY2hK?=
 =?utf-8?B?ZEVGUDh4VHJPWnZpSXFFb1ErTGtBNG1RSEM0Nm1KSmlaUE0rMlF5OCt0ZnZi?=
 =?utf-8?B?c2FiRS9iMDdIdFZEdGozbUNyUVNEeS83YmNoMnNjT21qTTFaZ0dobjh6U3J5?=
 =?utf-8?B?QzNBUzZ2dzRsTW05S2JjekZqWmlQa0xsVVhaZnRSQUg5Vk1aeEtaVVcvbFBC?=
 =?utf-8?B?eWtmNjI2QUQzZHFkQ09BNnhwVEk5YmQ2MmxUMXROcytIZzltdkJDZ3poSUFO?=
 =?utf-8?B?YlBxR2RsYy9HSnprRFo3U0h1WUJETXJ4ZGVvWjhMQm1nbWY2L3llTU40OUZl?=
 =?utf-8?B?RFVydE5CZU1XSzBUVmc4R091cGZYQ2FPNUd5OCtIeXZZdTZBN0hKbHloM0li?=
 =?utf-8?B?SjNyR0VJZUloT00zQjNIb3dDNk9kMEJRcEpJL1A3LzVnSis0TWZuUlVINEUv?=
 =?utf-8?B?M1BteUxtNGQrUjlBUXJ5MVRvNVpTaHA1OWFRdGdNVklVM01HR0k1MDRVQTF6?=
 =?utf-8?B?NnAvZFlYcnM5clRQejAvQnA3bEt6WS9pWCtMOEdEK0RxWmRkdThkNnFMVXJV?=
 =?utf-8?B?MW1PbUdnc3FwbVpLckNzZElneUcraU04dmQ4Sm9mSndTenFIVVBjYWpsc3R1?=
 =?utf-8?B?c2JlY1RWNDBQei90d1NZcUordGJRaWZ6dVZMSG95cDdrcU1EMHV6d0NmWlhq?=
 =?utf-8?B?YVA3Umxkckl1RXVyYUhyeTFKc3dGZHpyRysyTWlHeXZZSUJRVkJlSU4vMFBO?=
 =?utf-8?B?OG1CWURkaE9MWUhuQ2o5STlFUnBmSDVRTnc2ZHBKNkdKYS9mbEhuU0lHKzNx?=
 =?utf-8?B?N29kdVA5UWZYay9sbEduT3NKdlN3NGt3QW5JNnIvWkZCcmwrblI3SmgrV09i?=
 =?utf-8?B?Z09LTUhYTXdaWGs5RWJXOXNGUWRXMTB0eFVSQ0cwdWgxdVFrclBIRmF6emd6?=
 =?utf-8?B?bk5ZWlU0Q3A2RDlDcVZmN0tEVng0dEhNek9QdFZwZTBDVWhrcVFtR0tib2Ro?=
 =?utf-8?Q?swVvevqkR/Ksv5rVTF4mLH0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3243a91-71d2-420c-b062-08da7a8f2958
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 05:14:12.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph6BU8a645m8XvQy6gAS81WgkK+WG3QQk1W09vfmkZ14tkXYGeeG694ahylP/DF2GL8Ks/A0kLHDBHgamTNrLsdXzoE/hiTkCbasOK7qHm5KSYOcKIgqL8Fcb3uWiDx4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7897
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On 10.08.22 6:05, Muchun Song wrote:
> 
> 
>> On Aug 9, 2022, at 17:49, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:
>>
>> Display reported in /proc/meminfo as:
> 
> Hi,
> 
> I am not sure if this is a right place (meminfo) to put this statistic in since
> it is the accounting from a specific driver. IIUC, this driver is only installed
> in a VM, then this accounting will always be zero if this driver is not installed.
> Is this possible to put it in a driver-specific sysfs file (maybe it is better)?
> Just some thoughts from me.

Yes, it is only used if run under hypervisor but it is under a config 
option for that reason.

There are several balloon drivers that will use it, not only one driver 
- virtio, VMWare, HyperV, XEN and possibly others. I made one as an 
example. Initially i worked on a patches for debugfs but discussion lead 
to put it into a centralized place.

-- 
Regards,
Alexander Atanasov

