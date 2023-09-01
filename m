Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F987901E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 20:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350498AbjIASFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 14:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjIASFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:05:46 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A1AB
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Sep 2023 11:05:40 -0700 (PDT)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102]) by mx-outbound21-192.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 01 Sep 2023 18:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLRv/JEWXsUeWyfB/b7PMDb8eAGKXXwXdETzMz6ys3TA4u14Dg6dFHjaCHaAa1p3Ad0FO58BTQP7uAoopI4waR9gv+wtwKuQBIZiarUiF43TNd6BStWOV40bl+v5tCcvxdvuPpS9R4eZ1IbrvvnOH967R6pPbcAJI5C680hYX6iPakQCJTW8eH0ZopHSK9yquIUsJWA+Bn+oT4YbOzpfUQiPrxYD7RQYCF+yYkGDmBP3hGvhMBBgnSCYuDnqS+dKF+X5aHunns1+GbHGcKWp22g+lszw5s71LGO7x+37I2juMzK7LTbjLoZcIviXRmtzUDQjzdApWeE0YdYahLKJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHHcGgcRSztsLcKdVLA1/t+Wcf1p+fdmcFKF30w4FHw=;
 b=Ns9QFwbQSeUuFjJJS9kHS8N/cs+JRCejYMSreWMKDKG9ZrkKM5xKM/vYEb18jaXJqH+1iea5W35xfYNzqmCaJ7HNmd0nHVRcNohdA9Xq415ZyFMnOghTKVlrJSR3AqA+zYX6AfxRxVv2y3spKUzHlVYkfwjlZGqo6UzbJYAzUSThDYSTwO2r2ZWrbfjCOE858dVkjTGAnFaPwnautCmcCxiZtaskk8HQKeo1ZywX0YIYWYWJCIfRDly0Kxo/NCo5gpuF1vi0PM9OoQc+lxIzHgf9bFpluIqKeuOw6GwQycuwO4qiSxkNlLg8dE9kMd2xIvlvHta0DQvONZuCfbCYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHHcGgcRSztsLcKdVLA1/t+Wcf1p+fdmcFKF30w4FHw=;
 b=mfEUluZoPd1z4CkxZw9k9x9IeawepZ8fNtc/VOBLWU1jyC8lvHVukJET95/KUL5gsUIE7hMq3gPoe83wzCSSrzIzlRqxOp5WktDv3NizgL/qlipbOtnvkGxBQZrvoy3MFo9ZJmKFH/1DLx2cOnLrH7SPrm/5X+/FY/hSHjiusDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by IA1PR19MB6228.namprd19.prod.outlook.com (2603:10b6:208:3e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 18:05:27 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::9fa6:5516:a936:1705]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::9fa6:5516:a936:1705%7]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 18:05:27 +0000
Message-ID: <0ffc15ea-6803-acf3-d840-378a15c7c073@ddn.com>
Date:   Fri, 1 Sep 2023 20:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
Content-Language: en-US
To:     Lei Huang <lei.huang@linux.intel.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-kernel@vger.kernel.org
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
References: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
 <572dcce8-f70c-2d24-f844-a3e8abbd4bd8@fastmail.fm>
 <5eedd8a6-02d9-bc85-df43-6aa5f7497288@linux.intel.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <5eedd8a6-02d9-bc85-df43-6aa5f7497288@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0511.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::12) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1901MB2037:EE_|IA1PR19MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ae5991-7dbc-4ec7-8766-08dbab160537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: re1UmTJQ9IPtOlUgt7clyjksiQePbBWduqN3L/LuDJXhEeTwt2mQC4TGkMXtceaCfE/PJ12gOspJPzJg+vUALba/UN29/B49hTI+v4gln1S0OeHZK72QumSvgUZTyD+KeLjUN+XD0AhNCH0a5agKYOLCrJdnnD8E3RBsBMDj8bpiZwjrgMOqNNmdjWAJdfxJC+PZhbhwiwVh+WKDCMBD95ret86J3b9qc/uz5lmEEmzrHUA+/Dr8SmCRGg+MGO7YOSelv5q6lHqswcEiY9vBjOzJEDjzQA2tJEtQz3+q2kZQkXGtkuj7JJqFnQBTP36q5HYWreTBJWZ1dtbgqPL0W9/hJ+qMUyWATZDl6LcOVGWlFnW0LANGwmP6Spna1npWgkXVF1f5NdGpw4Uq0swKXKhg6rp6JbG4fqe6sK/gD/VF+tq13FrphPFzkCUKS54xa1ueH3+OttIRIhmBr4FDrJFlwFKJqbHcMhOl6sNQleSYSVY1dmOMRfKVx3WaCb/c6SNblJ/3IavsMEW1wHOAX2ZX69kfpVv10vIy3PPHYhivpdx8Rv3GvdxOhxysvcxXISI4xF5P3KLakMo/WiyLyXbqHALYGAE16BDplFLvFnmbLO3dhZsDZdWNqWn0JzRfl3GvDs8Qy+P2P+4cAybQlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(396003)(366004)(346002)(451199024)(1800799009)(186009)(31686004)(6666004)(6486002)(6512007)(66946007)(6506007)(36756003)(38100700002)(86362001)(31696002)(2906002)(2616005)(26005)(53546011)(966005)(478600001)(4326008)(8936002)(316002)(66556008)(8676002)(5660300002)(66476007)(41300700001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTc1MGNJVlVTTEY4UThRdmlvREhZcHhZd2ZLMHVlb3Z0RENqY21kbWdLSDFF?=
 =?utf-8?B?WlVwc0VpN2VFTk1SM2JwVkg1Z2lvd2d6S1lMVFEvdG0wYUVTQ2tBRzZqTGx3?=
 =?utf-8?B?MVp1ZWtiR2thSjFFY0UzUjRZanJmeWhQTURFZ0l1NUFSUklsTGJGVXlwcTZu?=
 =?utf-8?B?OGxvUG5aNC9FWFhybVg4NHdUL21wYzdtdnRJUDRwUUozVk0yRlJVZzc5ZjRB?=
 =?utf-8?B?WktRaXh0UlFOODhkNy9telYvVDJ3R1JhYW5ENStxOWhjcGpNWUc1Z2F1dEJL?=
 =?utf-8?B?Sm9jRFpQeTcrcXF5MDBOZTJpOWRKYVVEWXJxVkI3emI4UWxTQW5ZK2ZEeEw5?=
 =?utf-8?B?Um5xZExnd0tPdHhEOEdINkZTWVRzaGVaNFNVOEpNbGpncElnSGtuK0VObU5R?=
 =?utf-8?B?Wm11b3BLWW90NzJNUXFDVngvNG1lWjNqTHFickFSUTMvNmgxNm5jQUJKcm5w?=
 =?utf-8?B?WEd5TWM1YnVLcEVEeDd0R2cwQXUxR3hQZ2RMc1kvMHBPNk1tZlR5K1oxT1h5?=
 =?utf-8?B?TnpIRU80N2FLNzRiUWhSem84MnRkWWc2OHl2b0k3MEtsTmcvY0cwUk03S0tj?=
 =?utf-8?B?TXFJeWFyQ3FJY2kvL2xkUGdBaGJuOGV2NWZZMlRKZmZicE9PcWhpZDkxMC9S?=
 =?utf-8?B?YnZnc1d0d1Mza1RKcVlCbHkyMzgyV1B0ZFh3SmFNWnVsTnpLbTBjMnYzZlBj?=
 =?utf-8?B?RVpjQkJqeHVLU1JmNlRSSGZjOXVocm5nWit4UFArVFQ0MTcrbmNYN25PUW5w?=
 =?utf-8?B?Y1FOM2MzOEFYQWpOUDNPcmkzcEpEaiswc200MEZWZGdJbTdzamE3SktXTnor?=
 =?utf-8?B?VlpNTWh3U3hKdy93akd3U2FlNDA4dE1CUTI5bHlUK3lsRWZZK2U2bGxnYUZU?=
 =?utf-8?B?eGVMOW1jOG5xaDU4YXBzYTNHeFA1eGswdUNQcXJhRE1zdTlNZ2o4QTY1a0lx?=
 =?utf-8?B?eUg0L2hvU1lVVUUxc3lNa2FpVTdncEkrZHRadjBSSXVMLzg0d1ZwWW9McXlj?=
 =?utf-8?B?K2szUGZRVDFpaEFlRVoySGJySmVSdklIUVJrZlhoZlg2c29jMStYRFVKaDhr?=
 =?utf-8?B?aTIvNU9XR0QvZHM2ZFRRc0VPTWo0RWMzZklOZ21iampzQjBMcGduSEJiSGxI?=
 =?utf-8?B?REloa1NFc3hZemRwR01nYXNYSlBKOTVEYllpWXBaM0RmelhJRUNBVXNtMkhz?=
 =?utf-8?B?SXNxcFk3Q1dGTFpJTHVxdVNGNTFTbzFneFJZbWNQUkUzckNtLytnMFk5N3JL?=
 =?utf-8?B?dzRjSUR4aFA3eG5rbDNteXc1cjJGVzViUVBJY1dldkhmRGtUY0UrRFZMdyta?=
 =?utf-8?B?S0F1Y1BXNm9vMGVlKzYySHNFWnp0d0FjMlBTWjBnYXdkN1gwR05RL1p4WFpF?=
 =?utf-8?B?STZuUHhMdllvVzlmOGJaZk9SUllSTHhBRVpGYkVSWXdiNGdzVHpzUVpiaWVa?=
 =?utf-8?B?NmppYktKdXRtM1ZuaTU2YXczY2pEb0Z0VDZpbjZpWm9vbHhaSk1yckY3TWxO?=
 =?utf-8?B?RG4wMFM4OE9HdUkwTXpVQTRtbWROek10OXRjT3RJNkszNzJYenRLWXltazBi?=
 =?utf-8?B?QTdzSVA4SXl3MTM5aHcyc1oyTi8yMThWR2lUaVFNU0RFcXJ2UmZNYWdYOUpF?=
 =?utf-8?B?Qi9hNEhLQitrTDFGQVNiYVUwWlAwSHk3WUJqVllIbmEwRWNha1djMUFENGd2?=
 =?utf-8?B?eFQyT1BJMUd4TU90d1F3b2hiYnRESG9PRmhXL0hJTkg2ZXZoNkFZclp0RlBK?=
 =?utf-8?B?NWNYL1NLa3VjODNYR0FxaVZTdytTT2I4UmJZYWw0Q2JLYlAyMjdnUjlCMG5u?=
 =?utf-8?B?MlMwYWFRZWczblNCaXh3K0I0emlheHRXaSs0Z1p2eGEwcTRUSTF1aE85STZ0?=
 =?utf-8?B?dkZ4RWkzYW9nSzM0eEI4OTlHL2hOTU0xd0VCRkplSW5hSTR5aEIwVGNkTnRE?=
 =?utf-8?B?bFRVVFgwOEFPMFAzQVlXcUlyYWdqalF5bzRzRFBuSUhrMGRXREU4dHB3ckVv?=
 =?utf-8?B?L21oWXNyQkcvcC9CMC9mcCswbTFkb0hZK1AxeUN0UjJFb2pBRFJLRmNlaGZM?=
 =?utf-8?B?NU9VdU42UUszZTFiaGJNd0lZaHNYTVBLY3lENUxQcTY4ajE4MU00YXYxa3VC?=
 =?utf-8?Q?m/LE2yewQB7xNvZeXzx2fNGPx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m6BITsK5Iyau+Ebyq+jeXk3k4cJXgrP21MCKc2fnnPup6HBi6ehfeqfALTJsnBOuxGsoMTq7865Xvj2jdL/pLWZbO6lzIg5LaRgUvyYCk8bMjLo1FKK3y6e0xmnn8rPSL2abLuEJuJPy24g+ACf9HWyjd/wWPfR4I9kv6KEZfcucfSGLTauu7VCX9GScVNF0mRC9ZamVZ4Zq+AwhNypOoOXBDWosxkEBwNofIEmuiJQOG/ClCgSEKMe9DVUoGCnzv+cEc847681HBH8oHC8yDdw6E9bKN4w1XnSQC2R39WIbl0z+TdB7lFfeHl68M2xsfsdz3uBOLzzEtOF3OU9MoBHAsswNR5Sk8K/Qb7COvRYSVT6jo0FwjG+SBffA3wjgq/644RguwoCD92c4ENRrnBC6XbRue3+wv5m3+ixLVA8+XILVwS9PR0tF0og5fgG+OmhDDe3fO2ooMbn0DCp5MXfafofc+ObbLb1X7J4ME21f0wN7Ci6gFJF26S3TvGnJOOlXWDl4081CJtLqvZfmO1YQY9e9SgEjBu4qmma5YGt/cmVVBrwjdl7+QqPYPQlXbFUyD24OpoP1I4/jt2cjnwCVMfN0E7uVhyBhm41tM6cZS+JeVSW81/PMagJ5q+a3WiFThEFwBwOPZbWpah/dJa1hyQg5iYgATAVR3+n3QkigQXAn9YmghSTcUzwkmECNbkT2QfCDCSBvjfSInjbfhIZIR7FTzQ3NpIjqrqQR+3mJymkWWMDkBNXZJvC1T0VciP8wfJQ0FlsFSloNkD1cm+igvi2Wd4BA45VWC6ZC597byYmzwqhp3gHjUY5frF/CQK68szf8MFncLTkSOBACQnLLVGdCbCnXC7wnVdw+CvkpsU9gEV1i3oL6jMWfFxuN4GdYlXtUFYz6ou2y4So/k3cev3gl2Wg/63oFIr+Htwg=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ae5991-7dbc-4ec7-8766-08dbab160537
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:05:27.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hnVUBUrDy5rItF66zg8Kvo8FyDOZ2I0dEMhpfcXNYdPaERw59ChD9PJxBDoghaYTXJS0zholIg08WznbxNzYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6228
X-BESS-ID: 1693591533-105568-15624-20551-1
X-BESS-VER: 2019.1_20230831.1729
X-BESS-Apparent-Source-IP: 104.47.55.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWBgZAVgZQMM3CPMnS0tjUzM
        zcKDHVLM0o1TzNwsDYJCXFKDHRKMVAqTYWADubUrdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250540 [from 
        cloudscan13-52.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Lei,

On 8/30/23 03:03, Lei Huang wrote:
> Hi Bernd,
> 
> Thank you very much for your reply!
> 
>  > Hmm, iov_iter_extract_pages does not exists for a long time and the code
>  > in fuse_get_user_pages didn't change much. So if you are right, there
>  > would be a long term data corruption for page migrations? And a back
>  > port to old kernels would not be obvious?
> 
> Right. The issue has been reproduced under various versions of kernels, 
> ranging from 3.10.0 to 6.3.6 in my tests. It would be different to make 
> a patch under older kernels like 3.10.0. One way I tested, one can query
> the physical pages associated with read buffer after data is ready 
> (right before writing the data into read buffer). This seems resolving 
> the issue in my tests.
> 
> 
>  > What confuses me further is that
>  > commit 85dd2c8ff368 does not mention migration or corruption, although
>  > lists several other advantages for iov_iter_extract_pages. Other commits
>  > using iov_iter_extract_pages point to fork - i.e. would your data
>  > corruption be possibly related that?
> 
> As I mentioned above, the issue seems resolved if we query the physical 
> pages as late as right before writing data into read buffer. I think the 
> root cause is page migration.
> 

out of interest, what is your exact reproducer and how much time does i 
take? I'm just trying passthrough_hp(*) and ql-fstest (**) and don't get 
and issue after about 1h run time. I let it continue over the weekend. 
The system is an older dual socket xeon.

(*) with slight modification for passthrough_hp to disable O_DIRECT for 
the underlying file system. It is running on xfs on an nvme.

(**) https://github.com/bsbernd/ql-fstest


Pinning the pages is certainly a good idea, I would just like to 
understand how severe the issue is. And would like to test 
backports/different patch on older kernels.


Thanks,
Bernd


