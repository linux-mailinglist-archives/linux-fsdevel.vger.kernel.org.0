Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C056161705A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 23:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiKBWI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 18:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiKBWIG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:08:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6B10555;
        Wed,  2 Nov 2022 15:07:45 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2LkqVQ032549;
        Wed, 2 Nov 2022 15:07:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=8xBnxrIG4n94ZhZvyVBWaF5njSRgX9ysEsJXll6mV74=;
 b=gwvDfyPlScrHie1S5dVg93TG5RGWwLBNLE6rjPFDpqSFtdaG4gvlQlwAK02nf3Si+Wj8
 fXOyLhGs3QeqZLRz081gi4485qGLxi23bjr/sRO9KQfn30KiX0xoI1tJjAHmZuqr4+U5
 2xyKJhv9lfiV1vQU2BFxxazdYPX2LAY9RF54FwOF4ctXWGRzP5cPQpQX7dzTwppWioIF
 DwiOXnQ/Jfhx8O7Qc7ARB9LIKaaMFIPocfdvfEp/B4zWrezwhY2LBGC6U/Ud2GuScMj6
 RYsd4CNXco+7QafFBE0Odp04hJcEZrw73VyVYN1IOdp5+Zkvp+39jfX2HXA3+5OUoYmp CQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kkhkvqxu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 15:07:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axHMY3ervQ1Dirh3XkcyzNWgrBkz/55FENZmsvnGXolStxyK0hI67p0UKUT2KjQOgLUQyyooKoCEwxlvIm0v6nOXviJGBDX/R5VmYsZlZNHkAMgO0ciQF1feOw0W79KC3zhL0Si7luY983JzNp1nGBNfMLDopGn3vNCwykgKY+wufrTJVdLrYS+QPCEkcCjS5J/radsPGTZgF2ocub38KvCn3iOi4O6RmvOYxxEOBs/IjMZcPtMotyGesyP9yCUC6PAhhQLra9wcJKHDXGQunSj2kWYp/LEhCf+x1EC5gXbWUzCj0UGfS00q1pq7URiwMJgN7JQhODjeTO3tCDC6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xBnxrIG4n94ZhZvyVBWaF5njSRgX9ysEsJXll6mV74=;
 b=C4IwAiLt056WWWbq9Z3zXJMbLjV3BRzcZouH+u1p/+sLZ9a/I5MKVVpBF9vCuw4D4203UjwScTIcT5dX1Gb5ypVpwnZYJluzXotcZE+mVINwGjYL+wGjCVrL8XiyAtyYg6Av1upfRx4ls6TTSgYAjXiOm+XpoREMTHGE01gtHTNEbONifJri8UYJPOXVgj2Pce20R9up5NUH8vaatS9EDd9yU9BO19XxLtPINdQVZZfTad3ZZPXXS32zZ7SOzg/smL1OTH5AnJrd9a1wpaTLlMFt07YOGqsVKBWbWsym28BIHiIP2/Hq5maQtTGfsBkxU+I1/QFZUu0EjnX46KRD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by DM5PR15MB1481.namprd15.prod.outlook.com (2603:10b6:3:ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 22:07:30 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::6328:6d95:ed96:b553]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::6328:6d95:ed96:b553%6]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 22:07:30 +0000
Message-ID: <5f742ea1-b1c2-5a61-53a7-5f144ca169f7@meta.com>
Date:   Wed, 2 Nov 2022 18:07:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Content-Language: en-US
To:     Andreas Dilger <adilger@dilger.ca>, Christoph Hellwig <hch@lst.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Sterba <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
 <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
 <20221026074145.2be5ca09@gandalf.local.home>
 <20221031121912.GY5824@twin.jikos.cz>
 <20221102000022.36df0cc1@rorschach.local.home> <20221102062907.GA8619@lst.de>
 <8AAF3B43-BCD3-43B4-BC78-2E9E8E702792@dilger.ca>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <8AAF3B43-BCD3-43B4-BC78-2E9E8E702792@dilger.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0283.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::18) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|DM5PR15MB1481:EE_
X-MS-Office365-Filtering-Correlation-Id: d2560ad4-389e-4db5-a50f-08dabd1ea2a9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEBj7Wa34QbsnTagg9m4l2z7UdNU9d9F51TsDg5nDOxuSGvSVENv1b9B5ZPUe1A17G4tMz/3OXSBAw2nYvu3OEQy+TEhyjUbXAIeq5OrhzW9gRaNmDuXcHkMVO8MscOnGrh+nuclQwLKhcGXJCrJxpnjQGpcGyLdDi8qSdgQOVrwDNcFjZpIUN5IIuwedgofjVn5GEyxXZoZ3zhBZdS06BHSXLNGLnhkFqme3xdfZ/9VqgchWqwnHhJoHr7r4545kfZOopJdY177FUJpddWEYxl5WfFz2X5mAWGiep5/myV8P3QewQH0p2R2QNAc7P6Mt+LJCUS+BFkW66mVAYBGbnlNGNK5KVNeuyxOz8nxWVKe5MWNK6pRT/4waGu5HYlvrLjF7l2AQeIAlt/Cw4FYV6Zlgz6Xsqoa78PgkjYlrCeutwDLmtNEaYSFbsdbn42aQB/RZdYCOPVkjO28yZgN+cs9UrghzEDj4OBHK19gPYpRJNrNclHku2V3ThOXHT5313ZBu42FN+UjmVH4TBXwNnTpxJCBob/5AFDYgeI5/z22QgriQ3SoZtkt4xA4c82ZvNhmSjDRZFzrjqfrmNwh+p+VLyeC0ADKXawR+t7gtJGRq0CwFANIZSQs0TBxw41DHSyPcojm4IJ2vAwEoXRuYTrCJwb3gnOOsfPSRxFXrHT8H97tfY+T8lQ7zvaLljrHL574wYsM/WheLQW013G5s1duojmlNhS/Tz/zWT66gkQTMZj7+u8tzvn/f4CQeYVYuYsf+xCJiluKIVuUE/tmcvXJPzA9B5Jlm1MfjaQSgAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(66946007)(5660300002)(6666004)(316002)(110136005)(54906003)(36756003)(66556008)(2906002)(53546011)(186003)(83380400001)(8676002)(6512007)(41300700001)(31696002)(8936002)(2616005)(4326008)(6506007)(38100700002)(86362001)(66476007)(7416002)(31686004)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkdJdDhDT0tNY2JHUHZJWTRzQ29USzR6UkMvR2Z1U1M3ZVZSbkpTL2ZEa0tE?=
 =?utf-8?B?STUvL09FSFd2RHI3eUVGU0JuUUJnMlJPUEY4RXN0QU0wQmJQdmYxZ1hEdEMw?=
 =?utf-8?B?NURGakQwY2JHWTVMcFkxMyt5MFVtc1lPTWp4RUlvRHZmU2IzL2lsbU5NZXNJ?=
 =?utf-8?B?YXlvYkxITTd0OUhhNGRUU3g0RHphZHBmV2c5ZE1rT0dGNkNUdm0yS0xXYjRX?=
 =?utf-8?B?b2U4TnJkRXQ1aVRoSWpCbWJ3RFRVRjhtTjBXazlkdjQ1N3pGNDZMUFpsNUtE?=
 =?utf-8?B?aDUyR2R6WnVtZzRtb254NFROVUYydDNrOGZFYmQ3OEppSERIYWxYNkpwNzhR?=
 =?utf-8?B?TVNiTFRrTk04YXk5bmRQUVhXZXU0SWlxcXdoT1ppZGlCalhsUTJ2UGJsQUNp?=
 =?utf-8?B?ZzkzRDFvc3Q2VEgydzcvOUJZenBRL01HVTJLMWFaZnRXOHZTbXNycWQ3Tmtx?=
 =?utf-8?B?dzlsU3EwOTdVYlAyamVtMjJUeTRPcUpUQkFyVW15MHdYNUppMTFicTNMdjNU?=
 =?utf-8?B?c1NPa3R4SFc4T1F2R2VaL0EvRjR2VUZzcW1TRTJaTTg5ZlduZ3pvYStOUnA5?=
 =?utf-8?B?L2F3Ykl6MjQ2N2FkUjdrSEdXV2p6Q0NQRm5tVmR2STZYL3B2MWdmUDhISy90?=
 =?utf-8?B?N0xSUXVvd2VKODBVdUg4Tkk5amVoYTU4eDNFMGtSOHUxdktKMGhLaUdaOE9u?=
 =?utf-8?B?cG1Rc0xFRStZZHZVS0hndnFNTXNoOE1LOEFxcjc0RUx6ZXlGOHVDaVkxWWhE?=
 =?utf-8?B?WlNoTS9VdnQxVWVlb3lNYWJQYUFIc1I2bmtWR0xKa3JBcFl0RHZEUUlIRWZ2?=
 =?utf-8?B?RkpISWhEVUZwdmI3c1Jwc29kNnNTa0FpTFltdTR6TTJTMFRGanRLOWRRRmNO?=
 =?utf-8?B?MUZMYUpmZG13bjNMZTVROVE4VUFnR05RR3JwS1RTSVFRKzMwZHMxbm1rRjc3?=
 =?utf-8?B?VFpsTkxDY3ZXK0xEV0d5MEdZbnl4Szh4R290a3dSVXp2WkxLN2tyL1pvUE9x?=
 =?utf-8?B?WjdQc005ZHdDYW0vOWRSb1ZjenEwbjI3QUNISTdQMG96elZwNDdJbHJjczNK?=
 =?utf-8?B?TE52ZlAyaDZadHpyallsVnh3bGVqY3JIaEVSUVRFNmt1UFA0cllJQ2xDN1FG?=
 =?utf-8?B?OXU5V3h5LzZxSUFZc3U5czd0TzdIcUNKM21OV2Q2MCtuWlRCQ24vVExicFpY?=
 =?utf-8?B?N2pUL01ZY1dUczRMNy84ZGJIdW9rWW9ibm5naWlVS1JsenU4WUQ2cHVEOEdL?=
 =?utf-8?B?cGVMNzVaZmUxeTAxQUN5M2tPNGlvQTZhQUhZcDJYbExlaVdzMHI1VGU2d2pC?=
 =?utf-8?B?ekx4czRUM1dJSE9oWnFnV2RiQks2TzhxNDNnUFN0SjMvR2d3TFZDanRSQ0Q0?=
 =?utf-8?B?alF2TG5EbjFJSVRsL21GeVZ1QnI1QjBENm4yVmFERnpOTHA4Ymd3ajgzeVZG?=
 =?utf-8?B?bm56dkUzaG9welY4U0hZYzZvcVNiakRXU1JYNWh2SEtsS0hoYk1KR1cvVlhE?=
 =?utf-8?B?RU11ejdiTmd4OWFxUjJveHcvUFBvU3BVYzh2ZmhzQ2tSNWttNXg1V0pKckUw?=
 =?utf-8?B?ZUtjNFdvMkdURFZBajU3Y2R2TzlVQUk1cHNUQ3Uzbjh4bkE2bWpVT3k2YWhU?=
 =?utf-8?B?Q1oyaWd1VnNkaU9wK25tbjZlVVhCbnBKL0FKZVZRejM0ZWQ1WVNCSlRYWmNz?=
 =?utf-8?B?UkdBS1I5ZW0zY3NjM09WK2RyWEs2bkZvdy9Xc1NOWWlpU2JBc091dHpVbGU0?=
 =?utf-8?B?bGpKOGtROGVibFUrd0twQm5Rc3ZLQzE5dERRTjYrOGg3OXBVRGw5bzRCMm1o?=
 =?utf-8?B?bndpSnI2MXZFSWZCcG51VXZVM2FqYXF0eFQzOCt3dldwd3hTVytRZVRRU21T?=
 =?utf-8?B?QS90YW5CWEVxT1gxT1pFTWswajNuUUVEOFFHaUlJR1c5T3NlWE81TFFhdWRh?=
 =?utf-8?B?S2ZweCtEQldUaGJZbGpkQnBGeHJYaWtrZldkNDZSRzN6bVFTOGNHRmF1YVJa?=
 =?utf-8?B?S0JhK1VmSzdEdFdJOE9nRFhwdUsyKzZDN1F1em1IMHduSmVrZXhSUWVRaVVh?=
 =?utf-8?B?dHV0SDRZTU1jUWVSd0ZKeHlOd3p2eFltNzlDdnA2Ri83Q2ZTV1Y5U0dUU21m?=
 =?utf-8?Q?9UuX/4woBa/Vq1swYU2625bZ0?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2560ad4-389e-4db5-a50f-08dabd1ea2a9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 22:07:30.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jemcXlFoGs1nwl7euTcEk/WDWotqqCt28R07IQeZV+t7G7KQGX4TI21UoowMRGNp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1481
X-Proofpoint-GUID: ARu8jMeIM97zCrpHO4Pvl4MpL2y3JOZK
X-Proofpoint-ORIG-GUID: ARu8jMeIM97zCrpHO4Pvl4MpL2y3JOZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/2/22 4:20 PM, Andreas Dilger wrote:
> On Nov 2, 2022, at 12:29 AM, Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Wed, Nov 02, 2022 at 12:00:22AM -0400, Steven Rostedt wrote:
>>> It really comes down to how badly do you want Christoph's code?
>>
>> Well, Dave has made it clear implicily that he doesn't seem to care about
>> it at all through all this.  The painful part is that I need to come up
>> with a series to revert all the code that he refused to add the notice
>> for, which is quite involved and includes various bug fixes.
> 
> This may be an unpopular opinion for some, but since all of these previous
> contributions to the kernel are under GPL, there is no "taking back the
> older commits" from the btrfs code.  There is also no basis to prevent the
> use/merge/rework or other modifications to GPL code, whether it is part of
> btrfs or anywhere else in the kernel.  That is one of the strengths of the
> GPL, is that you can't "take it back" after code has been released.  I don't
> think anything David has done has violated the terms of the GPL itself.
> 
> David, as btrfs maintainer, doesn't even *have* to accept the patches to
> revert changes to the btrfs code branch.  The only real option for Christoph
> would be to chose not to contribute new fixes to btrfs in the future.
> 

This is all true, but it's definitely not the direction Sterba or any
of the other btrfs maintainers are going.  If it happened that way, I
wouldn't even blame someone for avoiding us in the future.

We'll never get that far because we've known each other a long time and
I know both Sterba and Christoph are working with good intent here.

> 
> That said, it doesn't make sense to get into a pissing fight about this.
> The best solution here is for Christoph and David to come to an amicable
> agreement on what copyright notices that David might accept into the btrfs
> code.

We talked about this at the btrfs meeting today and I'm sure it'll get
resolved soon.

-chris
