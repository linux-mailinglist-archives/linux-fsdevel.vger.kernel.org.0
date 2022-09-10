Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361BA5B4672
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 15:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIJNDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 09:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIJNDu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 09:03:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207C558CB
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 06:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LalaW3y47Aw/gNlDDFH5RZxYQUEKJctOzFzkJnkygXN84fo2oNAam/aSZYViF6HwlhLkFwNTDlUnYVeK4j1N0T7DMhRchcUJMEaEwJLHp3DLpdicaKrJfYNh9CJQ4gZCtXc1ChJdagcagTE+A/vyDkoGJVr0jHKWSleUZSG0bkShYPJh09li71Ez/i6aCAvZu7M1vHE/lBcRmHTnXUEzQxOW+HElRGuWPpxO7EBr3TR+ASZKnSiK/+JcfgK/X4JzYrXbKKoszUoL3BWWVl+fRio5qRogjIDisu2h/1KEox6jI62gvC0pKp8v1Wu3lowNmVcSYIXMDOF4Mlar0MJh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eh1pKeIxV03dcNuVirnOFD4gdrZOVgb7KepsPOc5SI=;
 b=b3SKuwTQANxRg20InQv/8kdsT9U9V2kUWRqrrudY7JAZcBM+4qU9fjcDlbr+X5HuNUSG1v694YbAgyR5uZ5zjVCyZe8hmZOuCq8/qgHarhbgdtfa6AqmBCKj2QMKSso0sixDDt/Ty1QZ9sghOCfrDLpzhrHkNPTV8THFVYoxs6AeHQyqfpgf3jVWpPOV5J7wVElXa2tprD7oMfWbEEp9dLVehnZ51/13lwHMgJbZuZCxI8TLdLXulDsoUIjH9tQmBojZQBADjdtzVLzXOZZnp3XrH4PfXMW9uCGDBmdNV/ALx0GpY7Z9petdl+EzPdNlMLp1CABCRPmneLDbdLQ5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eh1pKeIxV03dcNuVirnOFD4gdrZOVgb7KepsPOc5SI=;
 b=P1bJhAGJvVhrXTQDbGjpwGx3fqIP8camDV8AfJntKch2OpEwuE4YepbaaIrtyd4lAEHuiR06XKrkdhOxAf1/OPhFcv7/CdrkoVNVmQ5qqrihHRdlI6u+lhJ3IQBh8XDLKYbhRqoxXIrf0vPDGsdFlW/ZHPKl+GF5K+Ft1gqOyFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DM6PR19MB4183.namprd19.prod.outlook.com (2603:10b6:5:2bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Sat, 10 Sep
 2022 13:03:47 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::317e:e5b2:ce73:26c6]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::317e:e5b2:ce73:26c6%6]) with mapi id 15.20.5612.022; Sat, 10 Sep 2022
 13:03:46 +0000
Message-ID: <4a08f1e5-8a8e-b8bd-6c67-2579e07cab4a@ddn.com>
Date:   Sat, 10 Sep 2022 15:03:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for
 passthrough
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com>
 <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
Content-Language: de-CH
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0046.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::11) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1901MB2037:EE_|DM6PR19MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: e921f85c-efd7-4d98-9f2e-08da932ce57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MruQumJVvPZQLkek3WX/ZLvyxTuaHmIGQGNJpyVSLq4J8AwRxNCRpfrgOqttuuZUh/522vnXWv79ICZXrUW3kWnXu5RFkPanmT7+wF/p+XpLZSySFexlZohq6z59WziqnL5Rf5hGjkTjbRGI2WEjFpNYf1GgHxPVVyhCH4KXFbRuvPNUWEDCBNquDoH/n6HUDGy5RdQIML/kVPXmdNKtW1mKAUfLwdtPJl3cOI94PmF4OrBFvJIoiQU+qMdKAje5+3yJP2thaFqwo8H4dpUTwYM5RWygnv7OXa9B/gt8LzyMer9fJbQI95srFWCrh8HvJQ1u0Ae4ovFA9gZB5g2CHSTwwRwBBj96dCAqf3zX81CeIYmutGzRVwdLw2SFshQiWPUF8AtAl9EV1ClYtCELUx3G442bOds7wk76YZqe3QhqQkrOdj+IYbvdTEQJ86bcWTBdPr9kn0AyEzPLqxRU2cw43r3/V9HRS4w2IUN4qUiYFnxw7DRJd+BqO0XvVru2Xm/p1PKfC61NJfizrl8cWQ0+rZbPEGdY+ecHkkG3chWsNZk9mxINk0x5k2HEKm35ppSb5cYfIHqNJKSIn5yK6C1lJxhragW0rH4zY7DMQZWQ9aMJ9eioS7oxosNAogqx5Gg5wnuh8GwJYbegjy5qVcXmvaSp0zEgU4hBSts1J9ilRzfWGnLYzezOh4yLSh67PBtfpDO4vZrOlkceLFGQOq2lL4DJ+rAbk2dyX3gAIsSN97FLkmZH3vjLeaTuTtDE/IMiUPl++oCeKnvtv7el96zP6iG3/GPfkLCnvpI/7/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(86362001)(31696002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(6666004)(5660300002)(7416002)(41300700001)(8936002)(110136005)(54906003)(6486002)(478600001)(316002)(4744005)(6512007)(2906002)(6506007)(186003)(2616005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzZvVWJOd0NrQ0djSGNIZ1RPRVo5ZG41YWwyQmNQSTM1Y1YyWjNjNFlCNkRn?=
 =?utf-8?B?MVA5TXlBbDUyenYwUlJmVnZ4RnhXY1dCMnBzZzVSV2g2a1NwMkp5elpoZHll?=
 =?utf-8?B?M3RJRGJKS0JpMUlpQkYwT3ExemZEN2hUNEhrNjdaMVU1RkVDdjFuODhzSGNS?=
 =?utf-8?B?NURkYm9ZeHE1eUllNzMxdnpId1JNaUMvNkZoMlR2WkozdnpjdXozNkJYMlI2?=
 =?utf-8?B?OFVRaGRwTWtqNmNKcXFPaDBabndjUE1YVk04c091ZHJBYTF2YTBuMzgzN3F1?=
 =?utf-8?B?TkdMdkF6V1dCY29ka2ZkeTBQelZac2lZZnd6TnVuNkhpNEhHV3VFenpwU2k2?=
 =?utf-8?B?N1RCcU16c3huWUhoTllKQklXcjhNQXJid256VWw1eXlGbjlQVW55bUcxQXJq?=
 =?utf-8?B?L20waDhLYVc1dlVNSUFsNXk5cWdRcnMyTVlPaEhpYzhUdUg4dUNUQ1p4QVBM?=
 =?utf-8?B?L1lMQTBhanpaamNwblV0Syt1cGM1c1JBRDNObnVxU1JjcWlobmE1MHE4eDB1?=
 =?utf-8?B?MWZEVmF1WUpvVHhiQW9XMTFQeTVReEVNNk5BL2c0cUpyMnF1Z1pnQzR3SVpn?=
 =?utf-8?B?RmxPRW1HU1YxSTlpZnU2ODdmTmRwRjZUdXVCQVF4ZjhvdzhhVFFIbzhQK0pY?=
 =?utf-8?B?b1RCK2ZhZ0Y1TStKWEl4L2VvYlJwUVpweWRxQkF2dm01Unp3VTRhU3U5QjJp?=
 =?utf-8?B?Z2drT2lnbzB2aXFRYXNNS0toK0xyaXpSQzBOM1ZoSW9ueDROMm81TituQWtz?=
 =?utf-8?B?aDYvYzM4aUN1R2RlUVY4VURtc2NOMFZrSWo4VWdvUGtNZzdVZnE0VlZhaWdW?=
 =?utf-8?B?bEJrMzdDbDI3dlVkODFkTUxBY1pKWmJXUFRxS2Rxem4vcmhPblJPb3lSOXJ5?=
 =?utf-8?B?NjlNdFl2OEFyYmRtcDFibkE1Yy9qUHlmZ25heUZISEdsSkdocTc4YUdXdVBz?=
 =?utf-8?B?dVU1aytQUnJTa1Q1TFIyRmMxNFJ1N0plZDhHRHF4cUQwdGovSEtNKzVCSnFH?=
 =?utf-8?B?b3BKWHhCN3ZzSzhHN0pBNEk4VXFGNTd2UmsyWmtBNThzQVo0LzMrQnJZcWRV?=
 =?utf-8?B?NFpXdlRaVTJHUnpCbFB3dGlITEFiMnNXZVRoaU9TNlJ4aGtMaHg3bGFSU2s1?=
 =?utf-8?B?Y3NnQTYwa2pnQUdVMUN4QUJWaVpOVHN6N1RjbjhLMTNvMWh3U2h1Q0RwZ0l5?=
 =?utf-8?B?NU1ld0d0QmVWT3ZnTER4SGZ5UWV3VXNkRjhnVFd5VHgwMlB0YUtIS1FsQS9Z?=
 =?utf-8?B?VWVUL21EcDd6UkZHcS9LT1VGV2UzKytjTDkvMnVxeWtkTnBmTG5lbWppNlg4?=
 =?utf-8?B?VlFMQVQzbFVqdzFBMmZGYllvVzRmTnZBb2J4RWJwZEhZZVQ1ZW4vSU51RkJn?=
 =?utf-8?B?b1lEaWpycGx1ekR4QWJrSzNlZ0lGSlZzSkU2V3Zqb1V3eDdFSzdUaE82U29E?=
 =?utf-8?B?K1NDd1ZXUitnSFNPS2IxQTRzZUpVWE1RbTAyU1FrQmJ4M2EvWEU1L2tmZUtC?=
 =?utf-8?B?SFJUbnAvdngvTFZyRThnbnVoSkM0Z21kQkpyVDQ1eU9hREZOR0pOaitYV1RD?=
 =?utf-8?B?bW01WEFrUDVDM2wwcFc2TDJGRnpiMU44dWtJNTRoZmd3alVVb2NIR0xVVzd4?=
 =?utf-8?B?Zm4zcStvdURPMk12NWVhRzBEMkFRbXRhL2o3UDNBYytLbXAweFlUQ0kzalYw?=
 =?utf-8?B?aWNmTW1PQndQeFJRN1dkL3o5NmdRT2M2bmhVU25rWHh2R2ZES1p3cFBPb1dw?=
 =?utf-8?B?c3hqNjAwZjJhMDUwV1BwQSs5dW1CMTlZeFVGQmJlUkxPOG5hUmhleUJmS1J4?=
 =?utf-8?B?cHNraUE5MldOc3pQVXB3MFdDKzdnQnUydUx6S1JodWxweCt0S2FCUXRDMkJw?=
 =?utf-8?B?TGR1RnIyeFVEY0toVENHd3llUmJaT0dmRnc5ZFNlcW9BSDlhdDVZaXlJZXhX?=
 =?utf-8?B?KzN5M0EzWGtqQ3dHZnJXNTFsQ1pZUjRmV3dSR3ZIcjFtazlwbHZRTzVZT1VX?=
 =?utf-8?B?eFc5Q296OUphdTdCUWN0c3JRZ0JxYm9SMVVGa0hWYkFqYTFSVEdtZ3gwQ1Zv?=
 =?utf-8?B?TzExZ1RWVFJlb01ZZGJRVkFFamYvVEJnK0V4Ykt1UElnSzlmNUw4ai9MRERI?=
 =?utf-8?B?czE2NTNWb2RZZVlKZXFUK1JZN3Q2MFRXNE9id3l3YXMwUlJhMDUxTFpvRjQy?=
 =?utf-8?Q?ctwzHaEtdMrVfstiBWj/ihEjuS1DBTDjagYUVHLDTKLO?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e921f85c-efd7-4d98-9f2e-08da932ce57a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 13:03:46.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEtbhwhR7iJKkEng7iDw495RX5avjj/7KgqHAFJ4FS9dhzJTxsk0R3I8+YzIx+e4nYMfyEti5lqenUSpZ24MZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4183
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> 
> BTW, I see that the Android team is presenting eBPF-FUSE on LPC
> coming Tuesday [1].
> 
> There are affordable and free options to attend virtually [2].
> 
> I wonder when patches will be available ;)

Oh interesting. Btw, I'm currently working on uring communication, 
similar to what ublk is doing, I hope to have a very first version by 
next week.

Bernd
