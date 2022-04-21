Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650F850A5AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiDUQdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 12:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390664AbiDUQdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:33:42 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCC1496B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 09:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt3lTJUrYDYBSID/TRbLHkZvGjig/qJnR7KgRyadM03HboPmWFXvoZlizGVsJlmzseXFYlByooEtVpghOW89gf2c6TwTzGIKYmJnwO33zhv48rQv/tx1UB+sj6FEc/MMLOgN8IFHloH2aC9FjCh614qOFU3S3VaAxnbN9394Ha+iyBHV74KCPUXcAPAB58F1KA/ENw49SfwcxDYwm/0gU0USLQnDu9nap0JcYdTEcnkZHuAacqXkPkxirXNOsgBrrM19tStY2gBjGIONNdNBCaKpJWXWHe1WQbWogdhMAiNFQ1s209LYAc/D/3bUW7u+K6ZW7QEbIXnOCCDhoveZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2efJn98L1s/Qi8EZ9S2Fmx8Av1PYWT+MeCnLKz0EkhA=;
 b=dG5+baCNbIFgXyS9FfsTBsZQiUhCUSYV5w1qQn43x/KCWBmqQW63wueqsUaiTOKD0eVRzM/Qbh+XtHkEvgmhB9zksoDab3M2BbNT70M19+FXdRkNZdj+V87sLS4ie+t720XBhXcFrNXX45Md+oG+STFx1iYRFWGxg16BvPbBXQ+F6/281+fu8caC/S9vhgTEIUzUPegv1iLmWlleJMzjPSK8UsceKGwXxVODTsDkzLp0mlOlRvUK5I9mqX8FQV0mTyFRwCrYdPw++sscS0N96WByqPTAffuA05cr9j5nu13L1Kl0oI+mnEXhA8unkPYzLDZddPFX22wpRyyRKW6aCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2efJn98L1s/Qi8EZ9S2Fmx8Av1PYWT+MeCnLKz0EkhA=;
 b=cF3oCyB62Ws1cVZa+irO/hzImM6416PoZfgu0VYteOfjnU/c2o4dJeMPIux9YGexSvMAgYncJShf8TTkoFvuUXFdqafTVNsfJ89JjwDV1SefO29fCSpMUQ3eRhbyXtmjRhOMMB5LFibZ+Yt4MIJqhWNrEfiU64J3bOVCsnjOslY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DM6PR19MB2505.namprd19.prod.outlook.com (2603:10b6:5:183::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 16:28:59 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8d40:b4b0:9023:2281]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8d40:b4b0:9023:2281%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 16:28:59 +0000
Message-ID: <0c569fbe-4ea7-e17f-e377-d3f579f53264@ddn.com>
Date:   Thu, 21 Apr 2022 18:28:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT flag
Content-Language: fr
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Dharmendra Singh <dsingh@ddn.com>
References: <165002363635.1457422.5930635235733982079.stgit@localhost>
 <CAJfpegs=_bzBrmPSv_V3yQWaW7NR_f9CviuUTwfbcx9Wzudoxg@mail.gmail.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <CAJfpegs=_bzBrmPSv_V3yQWaW7NR_f9CviuUTwfbcx9Wzudoxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0049.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::24) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fd92bb9-0438-413f-64da-08da23b409d3
X-MS-TrafficTypeDiagnostic: DM6PR19MB2505:EE_
X-Microsoft-Antispam-PRVS: <DM6PR19MB2505763950679E40E75D8BEFB5F49@DM6PR19MB2505.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2iqGILzRfOdjid/js18TnVW6vtDQSrhImmHH6faRItCzGjtdRn4FeggBylX8DR+bdFPskj85NxshOiS0SE6LitQXCUoNr6PVpkHO/gJMA0AXQXgz1aCxzrd5zzctfyNCwXUTpwUaeb1vVVk2suovGlALCPw/d6S5ajOlNDoVSf6YU4IA8CFpdsL+CxKhT1NqrS9u1JfHXfTRHVpIyVggCvFWrVHNN+OUUPB85nJCBVdMlK7xifiumxLcd8gvr8SDIAv3nMOdPiUSG502zuHrLE7/K2o3kh1HivlaHJx1LsVCJtfSZsVxtABAOacF2z4u5jN/EdfQH2HZFoen7sDFv91wiW6G2pXBYRGXNl9VNVFN5ieRIkJ8QebGXAd3Nffzc4428cq1nzT15cmbFv0paTbGzVuM/GaF+X7bKXhnIlBp2BB6Y5JIJ9xzApWQQZKxANI3DgCIlxUMYrdBXbiBCadWA6mSTZX7Q4bEjfuTcfSIeR8p6Smp9rGLKJC7hG1OEY0vTTS74+7NHskk12qbMGex/1FMND6I83qky3DJkvR0bm0ZYUfetZ4aLajYGOWGKJ8EK6ooB8gkVo/1a9EL5DPzCvAaL/o/NTFvXscZuxcdoW+9v0rSQ3nV8/ciLqBET5OzbWKWtq+fTt1R9wVVRUypBXLl0BdHlqsXPGj2krh01GvQte5qLhFClX26IQFgvOEXxKZ5umqEJ83dRwCoOYtj8nyFRH70uGDu4L41iR9LwjAuVNbJeZNsAmbmYG9Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(54906003)(6486002)(5660300002)(508600001)(6506007)(38100700002)(8936002)(558084003)(86362001)(31696002)(2906002)(316002)(8676002)(66476007)(66556008)(4326008)(66946007)(53546011)(186003)(6512007)(2616005)(6666004)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJMR0xHcVBueUtFVlRkbkxRanRMWjVqQzFKVWJCTWZYdzdKU1VReXY1YUFi?=
 =?utf-8?B?RHVoa2Nlajk4Wk5Lc3JvSUl5bkY0UEp4L0lWVkZzUHEvS3h3MHJPbVB5bjBh?=
 =?utf-8?B?SjBvc1JTZ05MOWFreWFxb0paZVZQQTM0ZHVEWGg0L3NMUnFYTHpYMzA5dHAr?=
 =?utf-8?B?M2FQVkgybnVoTk9QejhXQzBVbHQrOTJBbjJ4MmtSZjRvTUxNZTVIVVY2SWJm?=
 =?utf-8?B?MC82VU45UFhBWTFlbE0rQzdKWWFvMXdtbzBocVNPUGw2cFNMUkRrRmdtMk4v?=
 =?utf-8?B?RHJqOGcxWitiUGFkbm1xN3NJc3RHbkxPcjJqN3hwaGo2c25tUmg0M0VIbjYx?=
 =?utf-8?B?TTZPM2VyRG5GQ2RQdXRHNUlhMUwxdVpTRHJMQzM2cUdwYjV1R3dKcW0yY2g5?=
 =?utf-8?B?c2xVbFhXWDRYT08vK25uZ1J3MXVORGZNS3Nlc2pxY09XVjRkZHVpMGVGV0Zi?=
 =?utf-8?B?UW9MZUhmaXlIOXp3eUhGK3M3dmhWaWhxTmUzKzVoSGJQQ1VGcFhsM24yVWVE?=
 =?utf-8?B?ZkpCZE1RaDA3VTBqdFMwL1k3WXV4SDJlRTFxK0dvZ1ZtYXNXVUJSZGRrM25h?=
 =?utf-8?B?MWJaK1g0ckNpNlcrUmp2Y05LeU9sWTI3eHZTU09wTlViL050RWJHZVlEQ281?=
 =?utf-8?B?Z1NHNWhLL0EzTWNzbFF2eVJncE9QcVBscUJSV2VLZFhYT3pHREh2b1o4OWJq?=
 =?utf-8?B?V2dzOWVMMzhXek8xSnR2RU5HMGx5SGpJRWVjVVMrTEFNNGQ5dnJudHBNYTRx?=
 =?utf-8?B?WENqNW5pYnE4UUI3RUl6b0hwRENVbGpaSDh0RHYxY2cySmdRaTVlTExCMGN0?=
 =?utf-8?B?RnFHK0MvTVNPK0FnK3MvSTNtQ0hOWnlQSkswK0tsM1R2dm9nR0xPZms3UHZD?=
 =?utf-8?B?WXRRdnYxWGRBQ1BEcGd0NnU3SmpGL1YwK1RkRDRxL2M5UDNOalcvOVVjNTE3?=
 =?utf-8?B?bnMxVS9rUGZnMCtiWUxYMEtlRms3ajJFQi9SMm1QWnhJNGxqTlZaTEYwcWRN?=
 =?utf-8?B?VUdRMTYyYU0zUmlZZFVldmFtY0t3ak5Hb2QvN2hZQ3hTRCtxdDgzODJYdnNB?=
 =?utf-8?B?bDFFL1VvNlliWFlUN2JYU3puN2Q5bm1TL2E0WC81R2pwblBaUVlVVVVKbzJM?=
 =?utf-8?B?cVUvZy9BV1BYZDNoc0NnVWE5U2Fkd2Z3aGs5MmRGYkE1Mkx0dEtrdEoxQ1lx?=
 =?utf-8?B?WUJEMFl0OVFoSG90OUpxQlVCenEvRXIxTitabHU4ZklGNkc1amVnSWQzWVNJ?=
 =?utf-8?B?TGJWSEZQWm1QYjVNOG9xWkxjM1dITjU0Wk5JNWt3UElyYm9pQ1NTeWtyaWZ0?=
 =?utf-8?B?ZjRlOUhXOG5oT0V4RGcwR3I0bDByTGg5MFZvTEFnVEl2N1V1S2FqMWRyTmRU?=
 =?utf-8?B?ZXFFdTE1OUM1T0pTeDdobzZ2OW9uK0tiVzNaeG1uNFlJMFV0NE5aQk92TEtB?=
 =?utf-8?B?Mm9QV1dYY2xCZERiUUFmRjd3R3gxSEU5cGlwMk40ZjBTd0duOVYwd1lBQnU1?=
 =?utf-8?B?RzRjdmVsbTJVZzNxMURrMVZtMnhpUzdvb1Rkbll5K1FpZVIxbGJ6V0FPUTEr?=
 =?utf-8?B?VnpkdWFPZjM1bmhLd3BvUit1QmVmWVhpT01TWG5pejIyNElWa3RnS2hHSjJC?=
 =?utf-8?B?V1JwcTNhMmQ4dUU0bmo2akxBR01GSlZhaUV1SE81ZjdTaGhCWlJmWVB2Q0hX?=
 =?utf-8?B?LzVtQmtIOHNPdU56dG5xMTJUOTZtcWZra2Q0WTdiN2tIcEZYeXVnZ1Y5RXFR?=
 =?utf-8?B?SUNoZytwZk1BbEhYWHVZWUl4aCt0UEYvczYraDh0M3dZYXl1TnBTUU9ZUkEz?=
 =?utf-8?B?SWxKc0xBOWV2b0psdTZucWpEMU1FaWt5bDN1QnRMNzhIdjJxS096c3BCeFZy?=
 =?utf-8?B?UGJJSUJsQkF4QWpFdFI3RmlSWjl6OHJkVHJyM2h6eHZxMXVxNGtmcVZiZUlm?=
 =?utf-8?B?RmF4UjJsVkVnWlI5TW12ZTRKNXgzQ1F0eG9qL3kzb2tyYUo2NnpnUW91cnVh?=
 =?utf-8?B?eGJhaXV5azQvQkNDMHZTTjlxQ0Z4YXBnbnQ3ZGgxWjZMN0hqeEIwZWkzdk9N?=
 =?utf-8?B?SkhVTFU4cDVqbUduZHU3UmhsUE51NXlFcXUrZWRuKzJreVF1U29lNHJ1ckhB?=
 =?utf-8?B?RmVpVENXOUdGL3doRmk2MHJXVm05K0ZGRlpZZmFGeHFNMVJQVlo1WEwvaFB5?=
 =?utf-8?B?ZUtPVUdUZDlrZ3FneENGeG9oVVNvd1hkNWxaYmRFcHlyMlV2alRWQWZUNS84?=
 =?utf-8?B?ejZBeXZ5aGZ4RWtXcVRITmptYys4OThtS1pzRUU3QllteS9vRkQ4MHpYNit4?=
 =?utf-8?B?cHVHVGtPakpwZU1hT1Z5QXo4V1M1WW9kTnhoaExKakZEY0Ntc2luNzNlTk01?=
 =?utf-8?Q?DK7VYWCl5wQMKn8Z7tGZT/FyRC1qeW/AXbtDN0/3UZFoD?=
X-MS-Exchange-AntiSpam-MessageData-1: KgOJ0F6MbPcYKQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd92bb9-0438-413f-64da-08da23b409d3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 16:28:59.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7UJWc4o39ai84c5KmLKpkpNTwOi9aCvCOdDxXHxxzEXa/vOQpzSEgAH2I2dUz3UxcyG0A/ltjLupkqvFxcB2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2505
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/21/22 17:36, Miklos Szeredi wrote:
> Agreed, this is a good change.  Applied.
> 
> Just one comment: please consider adding  "Fixes:" and "Cc:
> <stable@....>" tags next time.   I added them now.


Thank you! And sorry, sure, I will do next time.
