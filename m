Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17853454E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 22:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiEYUuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 16:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343899AbiEYUt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 16:49:59 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB3B90CC8;
        Wed, 25 May 2022 13:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN3PpvSZPD857c3fuHy6zB+XkmdKFknyQxc3v7QwmEyMx5LjQWzj+CVP3FFddzpsusFbE3nAoSV/tCLYRuyyisTd4sN1zuftWUNSkk+gIjuf8u/vY/woDmxbpQwlwSzFV2FsvKX4FG1j5vCOyt96j375w6x/jJ+AkoZR9HYOS2KDJR6V8VP/Js0/4V6ypb3Pvda8AzH/Sg+AFRZsDmfgi7cOZLGAPgDQurzpgRkrMeuk72XfG/BA/aBndB0y9vm8g5g6UYma2HYmUBHocgx0hIZpxQQRzbjJkPi+5+AX6nWnwa3xefjwsV2SgeM/2InMkY2jtYv/xrpEivRsLiyKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FluFshegae3Q3hjB1tu1AWzLt2MXwFZRsa5O+9YGdLc=;
 b=fk0oGVWoG58PUIlW8Kcdj1TG9nQsbGocmiQ1lzhFR3hdHZ5ADdsA9KvogwXBLvj+YaprF+uw6hH4mJLvEt2oC78pi0BxaOMpWDPak7JK7PZDe7A+oFwxkGt4ymY4aQ02j5f0tpUONVUEiy4kfhwjKkPcIMogo9SNl9flPgoEIkJDpbyvq4pCkGAA7vsXHTUmf6ADlgmWm64tzwxr3pot9A8WlKQ+rtThsOISVXm5wtpdTt4vkEEkfGWzXxylt86I05H+M00PP2Ayl+C3xFKR6q9F01iBzB+Nb8SYsK+Avv02OoFb/grOxEBOz0MKIUsq3P1OIU2iOlCPhNkJrKLb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FluFshegae3Q3hjB1tu1AWzLt2MXwFZRsa5O+9YGdLc=;
 b=ngKI3W1Xrj+lBz8ifgenyQD+7JngN13fsoFSHZM+P2o46TkmH9PokyU1Xu+V7hal1IHZ/r50tfbMtcMmdpmLny02Fcd8UP8y55nHQFKAFYxrhvHqJ+UL+jC/t6KTB+jBrWrA4O9kN/J9tHBwNoRGHH85jA9UJ0EHTdOODhSVoYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by BN8PR19MB2721.namprd19.prod.outlook.com (2603:10b6:408:85::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 20:49:55 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a%7]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 20:49:55 +0000
Message-ID: <3350e4e2-bad5-7f2f-2b09-c1807815a29c@ddn.com>
Date:   Wed, 25 May 2022 22:49:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/1] FUSE: Allow non-extending parallel direct writes
 on the same file.
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dharmendra Singh <dsingh@ddn.com>
References: <20220520043443.17439-1-dharamhans87@gmail.com>
 <20220520043443.17439-2-dharamhans87@gmail.com> <Yo6SBoEgGgnNQv8W@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <Yo6SBoEgGgnNQv8W@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0211.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237::9) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 709819db-3994-402f-7344-08da3e901f82
X-MS-TrafficTypeDiagnostic: BN8PR19MB2721:EE_
X-Microsoft-Antispam-PRVS: <BN8PR19MB2721D308BCD3822228987F71B5D69@BN8PR19MB2721.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPcAWTGuvP7hLCEoDI0Mdp9PAR50bcpoiR9xshvwgvOCU66gxgtTwjzhpQpGV4BOcNuQyUszne/Mr2bqk3olvSlYZebYRBo13+dYa6H6IAur2GAy5X3FuCtmYyyFpR/GkBDzCJi/uVuIs48eVCOB1hnpCrvyGuMq6H/eQ5hfHKnlGI8AnXaOCVk2JHXEkHnN03iTfdfDRsshPh74cbm5VTfY+58bbmphAhiyDcQ2gi786UtoL+OMOuMv689hLI3mXmxQi0kQMdQTWYguRY5TTyVP74lB7EraywF4GifuMS928POqjH+0CyQ5BfrmYPfwDqG9PkNHo6nwSxSF30aIZclRZLYhVvCq7YJER3NyOrot2v5LCM0MYq+MZAiYPNQDrtJqZdnchyery4LNab9/9FKiEUBHCdisXI/+PGilOWMXzZ5htn+jJjSJy///VRHDqoLJJEbvP+VQTioGKQqzGkdua73+C06Lm2GZscEGsl1+R3DKQV8GAmOXv0VDmrn7T9lQPMlt02lJobXx7n5dNW5mtf/aBhlw3DY96jUMsyKi2h2nsv+bDSjKl7nr8FQPISytyBkBo4piBqT5JCSJP8hqVR6r0aC9CUAyxTZcdcw9krKL2MmFm50O7VufEjJ36Sn9IPWjvUogIkROHarehuTYWbzxIRjAnQtI0kfrCb9OA7EsK5e24ca46eVGhbY4o/NV/Bkfz8urmPuSOAfCuj2psq59a9rr+tCB5J8GqOi1a1Hk1YMx6agtJDNfkoZP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(86362001)(2906002)(186003)(36756003)(31696002)(110136005)(31686004)(2616005)(83380400001)(38100700002)(8936002)(53546011)(6512007)(66946007)(66556008)(5660300002)(4326008)(8676002)(66476007)(6506007)(316002)(6486002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VCZGwrdU9IM1FqTjRKcWgwWW54VExWcm1LWEF1bTZwdWRzQXdWRzhvM3ZN?=
 =?utf-8?B?OVR6RnRMRjNlUU90a0NZRE14N2tjR3ZNVEE2K2pFdXJYTHhPanZUdVg0WXM4?=
 =?utf-8?B?eWt0TXRrN012VnZHcVdTL1I2TDVvT1N6eXZ0MGhaR1Z2SGZHb212KzRrV3JF?=
 =?utf-8?B?dG5NdHhLU2cwL2tzZFloclhHQ3VkWXRqdy92TW5PTE1YQXNVSnhOY3lJY0M0?=
 =?utf-8?B?bXlOOUdNMDVRcGVZTlFHQmFhbU1HaXNkSkpxcEV0Vnh3QXZnczh0TEdYSEZK?=
 =?utf-8?B?WXMyS0JXeUlYSEdMUGdBUW5uV0I4WVlxOVNjK3NNZDBDb2xETll6blVnUGt2?=
 =?utf-8?B?ZlRaUG8ybXJ0Q2x2c0FocXFrSmxUSWJJN1FVdUFVN1BhRFlLZVhGekVvQVc5?=
 =?utf-8?B?TzNmNU1CT21YK0Z6TUdTQ3lGZUtGOWU2VWZ1TUN2QXJsSnpDTzJmazBlaWRy?=
 =?utf-8?B?S3MrRmhYb0xQV1AzMCtIbEN3SG12cVFsRENGOVdiZDA3OFJNcC96cnFPakJq?=
 =?utf-8?B?OUtGVDg3Qll1cWlYZEFWRHc1bHJSUUo5ZkpTYTY5UTZQc2VySE1JR3F3TDZ4?=
 =?utf-8?B?ZS9aazRxcE1UZFVsNmhCcjZMdzdIeWtGQnJOV1BkOWdJTDVkUnZtaXU3bjJF?=
 =?utf-8?B?dUFkNk9ic0pqekpDYis3NUtRYUpsYjlEcG92L0ZJYzZjWmNPb0ZjTnZDcXpZ?=
 =?utf-8?B?cFE2K0xweCtnNnl6MUJUVitXMUdmelMxei90ZzBQeTZYaDNqcWtNWDRCc0M0?=
 =?utf-8?B?U0hqdUU1aFhGekhWQmpSM2RVazZVOHhOUUo5TVgzQVdaRlg1NHNnVmRGeFBX?=
 =?utf-8?B?ZWVLMFArU0hBVzNiMjF5cVV6anlNeWVaQ0xpQUNuSWdWRmdmVmVWL3RnZ3Zn?=
 =?utf-8?B?Zk4xa21oeDVEemQ4ckhOSkFtZlhMRnNoeHoxNFdxY3J3WktWaGh1RDZKYm1r?=
 =?utf-8?B?elE2VUIwWEliSW10L04rODhkemYvMjdUVnZYOUEwZGNvQkdKc2FyYTZMTldo?=
 =?utf-8?B?V29rMUtHRUVMYmUreSt3NDZBUGY1M0xnWmFCSTZGSDZ3RFFFaHFFb0JDOVpr?=
 =?utf-8?B?UWV2ZmdmUVpBeGI5YlVjTi9Dc2M0M0dRWjZHSDl5a2RvalNjUXZJcjVZVHc4?=
 =?utf-8?B?VzJvT0VlODl4T0hueXBlWGpTMFJiMzYrVHBNYWhLODZtZzAzL0NVU2Z3dm5w?=
 =?utf-8?B?N2dnTG0yYWhMUCt6TU9qQzlDYllqY2RKcmw2Zkh0SStBenU5U2htcHozek1h?=
 =?utf-8?B?M1YwclJja2R6N1QyM1pORmlRTmozdnVNOXhVY2VTSlZSYVdtQnhGTVRQRG95?=
 =?utf-8?B?QXhDNTI3YnpYcjVkVGhnVXQzbUFaek9YeEszTG1UaE9MYVBMNUV2cnNwZHM4?=
 =?utf-8?B?V3dmNklkWmt2ZmYzd0pOT25MR3NDeVNWZWhVUkx0Nng4UnZ6TjlCWE50alhE?=
 =?utf-8?B?S0k1eHdkMXBDVEVDVzlscys4MnB2bjU3QWQxZFJGV2tOdEJUU0Rvb3cxMGdL?=
 =?utf-8?B?VXlUQW1Wa2J6MG91RXpsY1phZ0JRTUVyWng3YWZvWEZwTVBhMnY1WkNoMFpJ?=
 =?utf-8?B?TlFEd1hVcEovekJ0WkxOQnpHdjA5SVdTcXNhdTI0SlVkd29UOWhpR3BJVmp6?=
 =?utf-8?B?UHV5Q2dNZEZRS21sdEMwL1M2cjh0UHhObHg5dHBESEJZSDFkamt6WTJIVjYz?=
 =?utf-8?B?bXBWQmkzaHkzWnpmTUF6U08ySzl1YlRBZU05ZHdiSjJKUXdOWk9FaGlQRlpL?=
 =?utf-8?B?ZGVuMzl6RlllbGJjcmNYNDcwQmVxaTE1R0g4UWkzTmNOWFVQWnUzaHdVS1N5?=
 =?utf-8?B?QmlrZnpnQ0NuZVM5eHhLQmlZRWc3ODk5WFNPZWIwMTV3aFBJYTRzdVE3OFgz?=
 =?utf-8?B?c0ppS25JejRUd3kwV0VscnVTL1lCcmY0MERIQ1h1SjdGRGNZanZka01ZcWx2?=
 =?utf-8?B?eld6dk16YnMwRHRqZHJMU2dsMjlUSndFMTl5RnI5M2gyTWtDaGh2UXdtUTEy?=
 =?utf-8?B?ejZlQzVWZWRvaHFSK2xQZ25JZUVjUHJMU1RIVFF4SkpETVQ5aTY2RVNublF4?=
 =?utf-8?B?U3Rmd010V0hURndzT3hzdGNOZXVaVDlBV2V5SlJULzB6QTByWnZMYTVKVGdP?=
 =?utf-8?B?SEs3MXhJMUNWWjY3ZWMwL3RGNWtNRTVMczFDenVpZU11UkZZVWNveTdlcXBF?=
 =?utf-8?B?L0VYdnRRVXlaTkVhcVRxUE1ybmo1NXJBN2FaTXB2aTBjTVJaUXQ2WWRNeHU0?=
 =?utf-8?B?VzRwVk42UDJialVvOWJ6dXVHbjQvWDN4elMzV2VWSXA5b1d6U09NU0ROTHV3?=
 =?utf-8?B?WG9GVmxoTkllU0dWdHlxNjZkQXljQ0lYanE5M1IvME1KcE11RitBbUd5UTY1?=
 =?utf-8?Q?DIWtZbrQooO6bEV9cKQ8PqNEube6qL6Oy7yIw6xdHONPJ?=
X-MS-Exchange-AntiSpam-MessageData-1: 6nBzinqPcMPE5w==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709819db-3994-402f-7344-08da3e901f82
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 20:49:55.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbsjcQ2D6nEOLNi5oySbS4YjXH8vdbX/ZIXP3zJ2wKjcNlGyKGBsZKjgip+JTHHT9kZ/6ttsLPFMNMVwPmiNnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR19MB2721
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/25/22 22:31, Vivek Goyal wrote:
> On Fri, May 20, 2022 at 10:04:43AM +0530, Dharmendra Singh wrote:
>> From: Dharmendra Singh <dsingh@ddn.com>
>>
>> In general, as of now, in FUSE, direct writes on the same file are
>> serialized over inode lock i.e we hold inode lock for the full duration
>> of the write request. I could not found in fuse code a comment which
>> clearly explains why this exclusive lock is taken for direct writes.
>> Our guess is some USER space fuse implementations might be relying
>> on this lock for seralization and also it protects for the issues
>> arising due to file size assumption or write failures.  This patch
>> relaxes this exclusive lock in some cases of direct writes.
> 
> I have this question as well. My understanding was that in general,
> reads can do shared lock while writes have to take exclusive lock.
> And I assumed that extends to both buffered as well as direct
> writes.
> 
> I would also like to understand what's the fundamental restriction
> and why O_DIRECT is special that this restriction does not apply.
> 
> Is any other file system doing this as well?
> 
> If fuse server dir is shared with other fuse clients, it is possible
> that i_size in this client is stale. Will that be a problem. I guess
> if that's the problem then, even a single write will be a problem
> because two fuse clients might be trying to write.
> 
> Just trying to make sure that it is safe to allow parallel direct
> writes.

I think missing in this series is to add a comment when this lock is 
needed at all. Our network file system is log structured - any parallel 
writes to the same file from different remote clients are handled 
through addition of fragments on the network server side - lockless safe 
due to byte level accuracy. With the exception of conflicting writes - 
last client wins - application is then doing 'silly' things - locking 
would not help either. And random parallel writes from the same 
(network) client are even an ideal case for us, as that is handled 
through shared blocks for different fragments (file offset + len). So 
for us shared writes are totally safe.

When Dharmendra and I discussed about the lock we came up with a few 
write error handling cases where that lock might be needed - I guess 
that should be added as comment.
