Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25225477EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jun 2022 01:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiFKXeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 19:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiFKXeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 19:34:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B8C55369;
        Sat, 11 Jun 2022 16:34:15 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25BLltlh010725;
        Sat, 11 Jun 2022 16:34:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jUdKWo4huJShRkXY45YuYh7ct7qm7v/bA8CWcYOslRk=;
 b=U4uChqBaTi5qJcWEho8FM4/kjm8ihwmqk9RrjhVpmAbrwhW53o3RTo3glgs8uFeAosKN
 AlcrMHAT482sWWD72mIhWWPXUuNAdb3GYmtlzBPmRPoz1SZOa0MfvmG3anU9Q8HFLs9N
 otFFkJGCV5hLEUWEPTXwfxGs0J/Xt7CGvKw= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmrrn2355-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Jun 2022 16:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw09aPJG86OBeXc5oI3Rsos54zJyF8alATX7HDdGKkHVRW7N9HOYz5Ao5gN1VfrFN7Fb6SswWDqG4RY8pFEdq53Ln8GsDcz3IsFFgbasAliJNr9cCjhi6TO8h9TEfuizK1zsCfZe6gIr5lXpJLKRH3zU60gXQ2WBzL0MgbqsABPjJzQygsU3h94AM6AqyLuFHJvnE5U7ppcu273ZdHM9M0YBJk30/efhCKtsGb+PISItF2/J+8rE9bFAfzszX4Uj8GowpvDjmD9RjF38NEcrZvabf+Lh/AtotkhdzCGBYqjXhE2kTRjPftcwb1F33OvEb6kDXCe4E6gb/vz6Wxxt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUdKWo4huJShRkXY45YuYh7ct7qm7v/bA8CWcYOslRk=;
 b=dG/jHM0db63ItfVCEUaSL6lJZJyS1Hi7hRzsLgdPMbF8rkbpOEXx9Zxll0OqJFQ2eL/+CB9A0JgjVhGErQkZ91+17vmlnRQUwU8ee5auWe9zC/mO/rzGHY8Yd5mJ+pVkzt/92nCE4iHCaE34tlECyyg2A2ayDNVXMqIgse+gBk5YeeoyRaMbOycePN3bx+J3SI4xXfgHftHfNE06vna8EsbtI+PDnoBr0gjFfQD+jjIyrf/2FJAaymXn2trUmDQiw59oXiIWbuS72o5e2TLNzpoVUdAJ36JwdYfcGtPH1X1qaTwrrAl9BiM45H2o0LISmb/gAyWn1x9fXINQje3UAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by PH0PR15MB4784.namprd15.prod.outlook.com (2603:10b6:510:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Sat, 11 Jun
 2022 23:34:04 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995%7]) with mapi id 15.20.5332.017; Sat, 11 Jun 2022
 23:34:03 +0000
Message-ID: <fb72ebb9-df11-7689-0113-5d98783039fd@fb.com>
Date:   Sat, 11 Jun 2022 19:34:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2] iomap: skip pages past eof in iomap_do_writepage()
Content-Language: en-US
From:   Chris Mason <clm@fb.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     djwong@kernel.org, hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org
References: <20220608004228.3658429-1-clm@fb.com>
 <20220609005313.GX227878@dread.disaster.area>
 <8f4177bd-80ad-5e22-293e-5d1e944e1921@fb.com>
In-Reply-To: <8f4177bd-80ad-5e22-293e-5d1e944e1921@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:2d::39) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48b93799-535b-4fbf-5bce-08da4c02de45
X-MS-TrafficTypeDiagnostic: PH0PR15MB4784:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB4784DB3A6CAEA306565F8B12D3A99@PH0PR15MB4784.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRYhb7KpTtfRUlRFMYUTYJdYZteVyAhwOlJesPni1NGZbfGqHWX5+lSMsXSe1zB/x90l7ATeaZpd8AKqDsCD0i+1LdlvNUzOqnHqK3KKDycS5WQgBupVlGFT85TMtDWse0bF7RygpTJMv4hktWuGf0jrMbTCLqOWRh3lKCpjsCgdQQLqsUdLo4OKARyjTRYF9KwBtKcBnvtFOZuzKAzah0pJQT23h650auQi5sagCaPZ2HhHbby9kKCkwZTPUFFQwzDGUN9OeinnaZfJI5G/2qiTm6Xg+w1eX/iwJpPUPyaF9lT/gSvPHfrir0weXjIxMA2bE9dRxxDQr92E8c2neXjqdBmX1++FDg8kpyMAbXXBeTyDd+UtwJ4QR1tlxpjE9doROIsONcx1MfI5mjW+V+y+k727vATCK6GDysxVkp1jKYrBJOyVvtu46kTePUN5mZQneSRE+36MNXN+AfYoWFg9VbcmDY15TGcVIjEISibvRclVZYo+jC0A+mL8O9Drq//H/w8mVlwzTDmd0qGAzIsPCnBuoBhaWQGcCZk5daf9Jqw0OIJkUJunjGrLnuMwGEa8ww76anMuboG4lC/5QnMjIU5hSIUdWbZ9EQJlxpELXfcIUkGwTBaegJ5Ms70JDwBL7hBmLtldonWIz5eu81SVpyPNhG7EFE0n0Oza0FGBmv65+/mU9xt249nE4rMszVtF7ICRxV+4t9Z9Eva49QKCodQMD0STuAA3dm2Y9XI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66476007)(66556008)(86362001)(4326008)(8676002)(31696002)(6916009)(66946007)(508600001)(316002)(6486002)(186003)(83380400001)(6512007)(6506007)(53546011)(2616005)(38100700002)(8936002)(36756003)(31686004)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXUxd2syTDB3QmtpVEgwdHo1VWszazB2QUovcTdMeU56ZjByblM5eVhOWGlL?=
 =?utf-8?B?a2FudXUyOU5QRHVUMmdqeEcwNEtLZSt6UzdWUlFlUkhzdUl5UFozU3VpeDJn?=
 =?utf-8?B?djFuM0hwMnRQN2J0amV6Q3VQeFZSdjBzUXQrRDlNTjZlMWZIbXZveEgxMWkv?=
 =?utf-8?B?ZGU0b2U5RWUrenQxd2NhZnkyMXQyeTRQT08xcnZUaVlhaGQxRnN5Tk1VbVNH?=
 =?utf-8?B?SWJUeFc5b2k2dkUrZHdRMXlsTVFaaUVQcTU2VlBwa2RQMWJvZzJUT2gySTJQ?=
 =?utf-8?B?bzRJUXZUQVJGRFVkaVZUQ3lQTEJoUWhHQTl0U2UyUXNWaThXalNtNHFFeFBL?=
 =?utf-8?B?ZUpEb2RIdUJXOFFwRXhuMjJEWlFmdnFJUzIzbjByS01GclNYN3Q1QUlPSWYv?=
 =?utf-8?B?UVZ4blVRUDZZWnhmN2syanpsOHBxOHEzRER4dnIxcURUbmFXUE94ZjNLRGJW?=
 =?utf-8?B?WEVzNjM2dFdFNzlFUDVWYXNSWkQyMEkrZ1N5eTVlYUFuN3RsUXhXaW50Nkg4?=
 =?utf-8?B?cWhrbDliT1M0cVM1djVPMVplQkNrMVEyQUpQcmJ4cTUwTG5GSmR5NWI1YWlR?=
 =?utf-8?B?OTAxTVNDMVAybzBiTllKQWxRQnIzUDRuWU5yY1pkVkl1dGhsT1dMOElkVmZU?=
 =?utf-8?B?eTVsMGJUeDk0b0hYSmowbXAxTGpYbElxVnRraHB3b1F4THpnc1RMcTFneGJv?=
 =?utf-8?B?YVZpcm1mQXV1MUNXYkwzclQweEJuKzVZM3BmZER1T2NjRDlMMTlRTngxSTRZ?=
 =?utf-8?B?RTdyTDdsSUlvdW5vMjd2cnRJT3lZSEhGODlQVkY5U0pYVTBDc2dTdVR2cEhH?=
 =?utf-8?B?L1dXL1UycGh4TFB0MFdEZVBxZDdoN0pnRTF5NmpuQVd1R2E3VnY4TSt2MmY4?=
 =?utf-8?B?Uko1T2xwYi9ycmVLQmh0WW9HTzZDbWRnYUdHZ0tINmFuTVR0RjhjUHpidHpJ?=
 =?utf-8?B?bHphZExzOExGdldkd0RPYmxsUThQSnNNMlVWK0s2Rnp2S0lKbkdzN1BMQzhr?=
 =?utf-8?B?OGtlUWFmTSt2NnJvdXgrK3d4UXEyb3RWOG03TUJiZTVvOWRMY05aYnM2RjBX?=
 =?utf-8?B?MGRhZzh5T1pJb0lmaTRIcXRSb1dCTktUdkI3NWlpSFFLbWtCbmx4WVNSdDJN?=
 =?utf-8?B?aTlzL2lBdERIa04ram5tQWMrTVFlcGttVGdFeHJSa3Z6L1RvMjRFWHlOL1N6?=
 =?utf-8?B?bksvcGx6Z1hDaHJuVGxiYmNPaE83WXRZUlNwMjcvOW9oZDhvS3RzbVhQUVdo?=
 =?utf-8?B?dk5sMzViZUdOTkRreVhBM3ZQNmFJaWk1b2JLRGFaTTVpcGt5WjQzS3lrYzVk?=
 =?utf-8?B?UXRrd01Ocjd5Y0gzdkRHck5mUDg4b2hrNVJpZzdpaFlLRzVEVERFd3FBZExQ?=
 =?utf-8?B?TjRFeVhBMzdOWXZWQllITW5ldmk1RmorQnJ0azBRekpMbGdabGo5VGgrSDV0?=
 =?utf-8?B?a01wL3ZGclNlNmlacFdZbEw1Yjlxb1JlbGYzeFA4TEszRytoZzNydjhCUzRC?=
 =?utf-8?B?MWVDNHYxaDM2VlJacExmV1M2QmpZL3NGMkthQ24wRlhXVXROWE9xNWZCaHhC?=
 =?utf-8?B?bWYxM1o1T1I4SVU4blZRZjdRZmwvVEtrdk4ySDhxczNNZmhjcGIzdXNYSDBM?=
 =?utf-8?B?N1YrdUl2S3ZEVE9nSWJoWitoR2VYeDdtZWZmbmpLRzRVeUFuL3J1WmhRMnN2?=
 =?utf-8?B?MFRsUU5TL0ROakRxbjhDWjV6cnVCc1p4cDZ1RUtNcEU5akxTNUFnTmVEVnlU?=
 =?utf-8?B?b29SMTllNVdUeGwxMkRoa2pZd1FBVzhaMnljeWh3M25jaGFNUXdlU1lJdU43?=
 =?utf-8?B?SHI0UkM4SWJsU1dsdkZrV2pRMEdLS0d0K0pMRW1VMFRBdEZmblE2ckw3QTdH?=
 =?utf-8?B?eHhTQWpGNGw4QUJDZytrcDJGckU0RTZaR2UrN3dLaDl6QVdmbEtxTExrem1h?=
 =?utf-8?B?K0grRHI5ZFpQaVRKMDZ3eWt3akpOK0dPZE9kbk1aWHpjYmFLL1MwekhDT3JC?=
 =?utf-8?B?cUFUSE41aTZtVXdyc0NmOFlYVTBzeXRlZ1o1WjExRGxRUmtSYjNqQ3JiTXFO?=
 =?utf-8?B?Z1M3OTB0Sm96cnY5NmIxN09KdU9hZitVUnRTQWZjNUc1MGZJbmJWTjVNZElK?=
 =?utf-8?B?bUJuWEtzd3JlSG9YQTVDbGFwZW51ZlRBZlk0bFNVRW9CaUFjQkN5RHVoZ0kv?=
 =?utf-8?B?UkZPak5TQUFOT3NmaU04RzFERTJBc0NrNkZsRkxaYTFYWnRYdzRjTmJzZllF?=
 =?utf-8?B?TkVzemtuNVZBMy8xcFY3RVRlR3RnRzhGTS9mUkt5dVJSUFR0VFY2c1ZaM2JT?=
 =?utf-8?B?eXhyc2RBVS9Qa1NMTUw2UGRYYXNLNmhvM0xpaTRzdk1WeDgzd281bTREKzhy?=
 =?utf-8?Q?cW3dMQUKtaEKYiU8=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b93799-535b-4fbf-5bce-08da4c02de45
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 23:34:03.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5MuejKKSAt0bwGtTBiAGanBN/sPeJsTzZ7dKA7eXRDEkiy3H+jt3wnsC+NksOUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4784
X-Proofpoint-GUID: qUx7FzMHf99k5U6yRiKC4V6BrA7S4ZNa
X-Proofpoint-ORIG-GUID: qUx7FzMHf99k5U6yRiKC4V6BrA7S4ZNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-11_09,2022-06-09_02,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/22 5:15 PM, Chris Mason wrote:
> On 6/8/22 8:53 PM, Dave Chinner wrote:

>> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 
> Thanks!  Johannes and I are both going on vacation, but I'll get an 
> experiment rolled to enough hosts to see if the long tails get shorter. 
>   We're unlikely to come back with results before July.
> 

Of course, the easiest way to test my theory is live patching against 
v5.6, but there's a wrinkle because v5.6 still has xfs_vm_writepage()

Looks like the iomap conversion deleted the warning that Jan was 
originally fixing, and I went through some hoops to trigger skipping the 
pages from inside writepage().  As you noted in the commit to delete 
writepage, this is pretty hard to trigger but it does happen once I get 
down to a few hundred MB free.  It doesn't seem to impact fsx runs or 
other load, and we unmount/xfs_repair cleanly.

I don't like to ask people to think about ancient kernels, but am I 
missing any huge problems?  I've got this patch backported on v5.6, and 
writepage is still in place.

-chris
