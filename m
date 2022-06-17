Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F23554F820
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 15:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381709AbiFQNHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 09:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381617AbiFQNHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:07:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E623DF6C;
        Fri, 17 Jun 2022 06:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLiYjIcgQOSTa+Qx9sf84NzPDvP3SrPEOtUXsO7zIjdln+UW/69u0oNvHB9FTQnGUNBoEj/AJTpvi/2exge3Zb5UuWXqMuCpA7Xk7ugG89uNNZxmTPlOao6qOv+qiyCSDQPj5W66joQ+IITeqMQ2NTU4W9Jai9I+GGEflMZyuxXziETg9CKgecMbo3jEbXshvwc0DrwyJdyDLoS9l2bJkkYpzX/m/qQGAzhtIJIeYd0GD2oFpNzVcilw2v2IEgk+CFSQbiAyjUtKK6B47+SPXExHLbYE3DNvvrdH80Um3quurw9z4WZDcXUS2UfF6ofvWJMzDHixoy2VwMnVDCZthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaySieH7aXvYGrptdcUTOBOKOaoVzU10ixNPl+Ku54g=;
 b=eosz0ivylIk2B6r4CSUM2YR3NuNUIZjf3n9X0H8c3mTFmKyFsPt1ECgcPQOcF4L2uKgJ3nhULg5d9c3bb0YgFlrqXdl0u0vFl9p1JStios7aOLoF3yeQ8wNsjTOPSq8SutsZauAEAMXl/iEBkua8FjTZztxJs8kwe3ll5nPDbk/aSLptTxo1gA1BrZEGZj4ssovf5FRTQuzEl16/NWL5E+Vf99A6SlKBeMCTrTmKdn89cxDwj5SaOoOgMXinfMbRzeWY7HTroB004McWPJNuaK8rEJpy8Iq1k6WUQepHaMmhb1yodNds8Cd1PXLQQijvLr9875jCFKZ+CURMO1hFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaySieH7aXvYGrptdcUTOBOKOaoVzU10ixNPl+Ku54g=;
 b=HqBxmZKIvb3HLvZRWWug0NgiAKpTDPQGjAg7G/JPJWTaMHWfGNPkpM1r7575N6npajgR62jbYTIj/OU8NkyaaB5Eth//8fUBLTMwXeN2Lz9oUq2WeK4fNEqQ3ijyjC+OUopaCyri/EvsEbWnd9uMDnG0WmZuAX7tvsZAhgixFrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DS7PR19MB5925.namprd19.prod.outlook.com (2603:10b6:8:7c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Fri, 17 Jun 2022 13:07:50 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a%7]) with mapi id 15.20.5353.015; Fri, 17 Jun 2022
 13:07:50 +0000
Message-ID: <f1021b5a-c9a9-6ec1-5284-0fa099dc7242@ddn.com>
Date:   Fri, 17 Jun 2022 15:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/1] Allow non-extending parallel direct writes on the
 same file.
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
References: <20220617071027.6569-1-dharamhans87@gmail.com>
 <20220617071027.6569-2-dharamhans87@gmail.com>
 <CAJfpegtRzDbcayn7MYKpgO1MBFeBihyfRB402JHtJkbXg1dvLg@mail.gmail.com>
 <08d11895-cc40-43da-0437-09d3a831b27b@fastmail.fm>
 <CAJfpegvSK0VmU6cLx5kiuXJ=RyL0d4=gvGLFCWQ16FrBGKmhMQ@mail.gmail.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <CAJfpegvSK0VmU6cLx5kiuXJ=RyL0d4=gvGLFCWQ16FrBGKmhMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::20) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27331a0c-a56f-4f18-0769-08da5062618c
X-MS-TrafficTypeDiagnostic: DS7PR19MB5925:EE_
X-Microsoft-Antispam-PRVS: <DS7PR19MB592537425029B7F990E32BF0B5AF9@DS7PR19MB5925.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itZURlO0GRRCFthEjfQ3u5x3VDe88FeGD15Lq2QtIeSEG+zFadu12Cgz6YlCN91a8+HpVaVMvRnQ6ZJX9wxMCCteRr4ghCEF6MirkCUW17V6AWChE8MBIEZwS0erJNg7OnXzY7fm718+UiPRCToPk3mBliAETKyv5l/Z6hpbZ8eYPZVYZqV/FRNFKiBWQB7A0CIjdD9t8v1y6wETZNZKKw8OWg3sgx7PCwkgRigNpIKflkQvsUzcBRgEctzxLl3ZXiGV+0nIy/IPELx3EaRDAyWGIzXQKfvERQWmTYUbKwUK+7UCt9Bm6wtpjwn1ozMg4Y9tCMZCXYzuPYUaUwIpEUjwTVxDZ5vUk1TVJ1yExvtS9V6MLVktkvMiAYYOISbMJsRHzRxbnZ1TldVGQCuitgki2ZdgpyvnLMcM0cxSqo0Fx64sX0/6zvovn/41R1ZYmxVSEiCNLUlhe4Z2rmqJ8rG3qH8dX6kVRDw64p+RLBPUncedd5TWo3a0Mq6lwin/2ZW9lyzy42jKuCSYn4KM2AEDdap0kI3T0dwzSMfChq+qpRfPiur9tWGTSU5U0WQ+lDgp+Wk0D9elngs/EbFbRwYG79oJkgFVysmcqXlrEFYDaI11+4LQzvds9MQt6EtzLcig1PQyW+aozMLniiPRF6URfFdvzzulSuBF1O7xqb9EXiK2pahdGfMsXlWsCHoHbXP203Qh07BN4YsfrxIV/AL2ONvAy4QBW1hIq3liXtL3Z8Mze73Nkf3YwzxwF2kU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(66556008)(6666004)(498600001)(66476007)(66946007)(2616005)(6486002)(8676002)(38100700002)(54906003)(316002)(8936002)(5660300002)(31686004)(4326008)(83380400001)(36756003)(6512007)(2906002)(6506007)(53546011)(110136005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGs1OE9jNS9WZ0pkajlIaHljTVVBcG1xb0FhVXMxZjZvd1ZCNUV0OFc4YmxB?=
 =?utf-8?B?emIxSHMvT3pNcFUyT0ZWVmhaTUtMQ013SDFGOFV2eVhrOWs4SlVoVTNEMmt3?=
 =?utf-8?B?NWIxZk9vUlRWK0hKVnlNYXhWVHl4TW5NMXdFNkRaOVV0QmNNYmdaMnVJQVgy?=
 =?utf-8?B?eTNxWktyOUNFelFtMnE4bGowQlRlc0VTM0Ixd3lZalc4dlhaU3JmaTA2Q2Z5?=
 =?utf-8?B?NnFrbHdMSEppTi8waTRmQkxsVXRWamtXdHFxalFSMmVDTVoxWkE2TWNiS2kz?=
 =?utf-8?B?cGdpYXQrNSsydE8yOWpVRGREcGc5NTFIYmVJRVRQdm54dzRRbE9RejVFSmF0?=
 =?utf-8?B?aHEyK3Jxd0dmeWc5ZEtHQWd3Ynk2c1ROUlFwSzZJNzJ0U3VFTlVvNzhqQXk3?=
 =?utf-8?B?SGZtOFR5QjVsRkxwVEh6QnNJWnRKMEtBejU4aGlPVTcxQmpCQ0ZuZE16RzNw?=
 =?utf-8?B?VFVWdEY1TDJMc0FUL002Rmh6bWUyMXpZUDN0aUJOc1J6QkQzVURQclRuN1Nt?=
 =?utf-8?B?SzBNOGtsRkFrRUZyaG9IVlVPTWZHcU0zeWpUQ3A4Nyt3clNTYVlPL3k0ZWdj?=
 =?utf-8?B?NjNQK3BDMlJOUEVpR3NJdHRrZ3RzMUlBcVI1TUhWL1VjL2ZhMGlKK1lCN2k0?=
 =?utf-8?B?cVNMNHVYV0FMTW5CRGdzL2tyM0lnemFqMmxEZUllNDVMRTZYUlI5SWFSVnBh?=
 =?utf-8?B?bW00TWVER05PUVdQZ0c2Tmh0U3VrcnlhU1hEbTlxNUlNdzVUMjlWbGcydEJq?=
 =?utf-8?B?MGd5Rm96Z21qNmJaTU1VbTR4VWRVY29hbFJ6eFhhZThqeWwrdkVVcm5Wc1Z6?=
 =?utf-8?B?QXhGa3lzbEJNWk5OVmJQU29OeVdMekRJYlRQcFphVkR4U1pOSXBOODcxeW9P?=
 =?utf-8?B?TkhkT1RMR1JjM2RRZ1NhOTU2L2NsalI2L2E3UnNpUXRERmpqVUNyNm81Vi95?=
 =?utf-8?B?RHg5am9zamF2U2FmNll4Si9wbVBBOUdvQ0htWGF6dTgyYVR1cUcrZlZyNDZ1?=
 =?utf-8?B?RmVYdk8rcnhXMStRbXAwN05aQ01CLzlRdFpIc0JwTHoydXB4dGdZL3BsdTUv?=
 =?utf-8?B?Tm9ObUhUelFUMUZKaVM1VlUvMis3QnRjVFFTcjhETHJyQzcyQmdWZm5FZ0Vm?=
 =?utf-8?B?SThoSFN4T1dtRDdMVWlnK2lKcVE2RmhRVXVyRFUybmRRU3REd0c0RHp5eGxx?=
 =?utf-8?B?c2J5ZHI5YXlEOWMxa2thTEhpd0RVaFp6OWlJMzdzUUU1aUR6TFhndjJqTTJD?=
 =?utf-8?B?MlNINEJRVHY4Tk1OUWs1RUE1eTJPUHJZTHlGMS84c1k1VGRaM3YwcDRhQ2lx?=
 =?utf-8?B?TVphSlc4amRYTlJCTytwWHF0amRwYzhuU1JaakM0ZzR1NmY4ZEZQdlE2V050?=
 =?utf-8?B?WEcvWXNRL1JjMFdtL3BXNVg2MEcxWGxnRnlUVHF3SVI1YU90RGRuVHJPcFZL?=
 =?utf-8?B?OVpsMHpJTUhhUFBJZHd0VUdFeVFERXEyMGpzS1hjK2FGdUVQakdVMkIvb0pE?=
 =?utf-8?B?NGdKSGNMS3lNdWpHTEZwNmNmMlFVaElHWkl5TWkwSW05L2RxOW5DY2hPT005?=
 =?utf-8?B?Kyt6MWF6RTg5dUcrZUxXNW55THdVZkRLMGVoWFpEWU5DTjcvazE4QVpxY0lY?=
 =?utf-8?B?Y0p1YnUwZGJEOWliL0JJYWYvRmhCcjZ1RGFZK2MxVXc1WExDUCtGRWxYaUNv?=
 =?utf-8?B?WHl5ODVzT1lKSHVJRTBMRko4UmpWRXJXcHJNOUxuV1FRQk1MN01JWUNKWko0?=
 =?utf-8?B?TDVKV2JRTU56eUtxMDFQOEN5ZENTSy9hdDdDQjdkaEo4cDZZWXpxcVZVYngz?=
 =?utf-8?B?RWwwclVleXRYYUdYOUFESzQ5aCtIMExrYlJKQ2ZyK1pMSERDc0pxcGNuNGpM?=
 =?utf-8?B?a0lVMU5mU2VycWxLNXFvOU94aXdlbUE1WnBzTDhNK09Jc0ZmYW5FY3NObGxh?=
 =?utf-8?B?SlhMMklZV2w0R3d0bkg5NFNXQzNiaTFzS2tSNUJVOU0vN1NTNUFxckJCWENk?=
 =?utf-8?B?MHZSVVk5OFNkNzVwTXhZT05pMWxBTGc3U0NWdWhYeVdnRjFCaUZCZ2dnMGVN?=
 =?utf-8?B?UWhkSzY4dGt3Y1RmU1dsQVM5TkgzSE9xVUxKV0hzcFhXeTlqejRsdVR1amQ1?=
 =?utf-8?B?Q1dTVlJ2YnF1dk54a1Z3RldRaTlXRUx5aVhXNmRjMy9OQ2tybFIrYmpaRzlk?=
 =?utf-8?B?Z1VObjRHT3pDcFpUWU9sTGJlbXlFNms4YkxRSWZNV1MvTFBDOTU5dStFSEho?=
 =?utf-8?B?SjRkazlZQmdLdjYyeHJRT2tnc3VOS2xLRkV6bENrcHUwc2pidDhzZTQxK09u?=
 =?utf-8?B?K1BHTnovQnQ5UHIrK3ZBcjVRMzNkWitQK3J3UXgwd0YxRlRmaFgrUzAzQ2J0?=
 =?utf-8?Q?bEJDFmPIIJhVAH6voq6UO9zVHOj3bXzYX73UuR5FYqt7m?=
X-MS-Exchange-AntiSpam-MessageData-1: 4POETDPHhFp5Rw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27331a0c-a56f-4f18-0769-08da5062618c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 13:07:50.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deZo4O9VxWI/G5Dm5rz8cduBPGiQ/EG9qy/DgZzr+AM/ykGaVqliJs8EDoKIvoL6AKUrO7EKqq+03uXXbnHiQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5925
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/17/22 14:43, Miklos Szeredi wrote:
> On Fri, 17 Jun 2022 at 11:25, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Miklos,
>>
>> On 6/17/22 09:36, Miklos Szeredi wrote:
>>> On Fri, 17 Jun 2022 at 09:10, Dharmendra Singh <dharamhans87@gmail.com> wrote:
>>>
>>>> This patch relaxes the exclusive lock for direct non-extending writes
>>>> only. File size extending writes might not need the lock either,
>>>> but we are not entirely sure if there is a risk to introduce any
>>>> kind of regression. Furthermore, benchmarking with fio does not
>>>> show a difference between patch versions that take on file size
>>>> extension a) an exclusive lock and b) a shared lock.
>>>
>>> I'm okay with this, but ISTR Bernd noted a real-life scenario where
>>> this is not sufficient.  Maybe that should be mentioned in the patch
>>> header?
>>
>>
>> the above comment is actually directly from me.
>>
>> We didn't check if fio extends the file before the runs, but even if it
>> would, my current thinking is that before we serialized n-threads, now
>> we have an alternation of
>>          - "parallel n-1 threads running" + 1 waiting thread
>>          - "blocked  n-1 threads" + 1 running
>>
>> I think if we will come back anyway, if we should continue to see slow
>> IO with MPIIO. Right now we want to get our patches merged first and
>> then will create an updated module for RHEL8 (+derivatives) customers.
>> Our benchmark machines are also running plain RHEL8 kernels - without
>> back porting the modules first we don' know yet what we will be the
>> actual impact to things like io500.
>>
>> Shall we still extend the commit message or are we good to go?
> 
> Well, it would be nice to see the real workload on the backported
> patch.   Not just because it would tell us if this makes sense in the
> first place, but also to have additional testing.

I really don't want to backport before it is merged upstream - back 
porting first has several issues (like it gets never merged and we need 
to maintain for ever, management believes the work is done and doesn't 
plan for more time, etc).

What we can do, is to install a recent kernel on one of our systems and 
then run single-shared-filed IOR over MPIIO against the patched and 
unpatched fuse module. I hope I find the time later on today or latest 
on Monday.


Thanks,
Bernd




