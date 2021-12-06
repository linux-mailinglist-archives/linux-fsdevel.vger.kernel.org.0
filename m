Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9406346AE3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 00:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377227AbhLFXKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 18:10:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31452 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359736AbhLFXKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:10:43 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5oj9004252;
        Mon, 6 Dec 2021 23:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bUApi9kc+ZyFaJxp2QgPpGXG+DhPxrCY9S76IdinM/Q=;
 b=gwpCJCe+Jei/p1OMr6P41LKfSQf3ucwnauxZcI+wrj7bCV4Wdkekay4DraAbSgGcfdxh
 sd6+IYiFwmIQvCM0WQeQYJcHAoBB4bb6i1gcc2Bay0jGJDZbWuANrp72LWN+FFZb9eUO
 ztEJK+qBqAOCGTQhIr1wt3Rb7csZu1ToHvGwz3DASZlwwSjFRzZRSv0yc9h4+emnkUzZ
 QeyEuMihXGv/OiTxol5bWWtpYMa8udIzyhtby8Cniwcjiw2Lxr8YzgvHoSslulWKR+KA
 zHI+OUwCGGI4Nia1qkV/krthOGttl6ixvXzYawxpM9xsYvjawj7FZLYFln25+jAxF/0f Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcbx48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 23:07:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6N0udt120998;
        Mon, 6 Dec 2021 23:07:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3cr1smvks7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 23:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jajnXx5UTwOPo14LKizOb75G5yarQYPgr+NIujeFyblWVc3m+N/IKIbasRspZSYpSOpIj5MF2aYOVq88sDuuMPOlBLC+nxesdRqU3FAuiiHQg21PEOIrlFT58JTr3oMlqTaa0gpTc4TnAsrtQfj7pbCszAzVa6KLNPANg1xZmM7NAHMr/Ws39li0RHtVh2epc9YB28RUHb9WBhRgrKuSzOkdp4fJ3TDUScPEf4mBaTabaxIBwGzjCb86wB6TftwIkH+9TTQHj3ky4ByDjKq/GncZ8Rb3jotTuYba1Ol8tNSM4F5bk3uEAu/jUwEQ/V3zzqCVHuVSEJ3Tack8fyJHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUApi9kc+ZyFaJxp2QgPpGXG+DhPxrCY9S76IdinM/Q=;
 b=FxSUYEtmNQ7wJkuM/0PsHusv1a2P8T3HON1fyCosPOSHk9JNPiDiQAXtj3fyXovXSftaAinhK9GeLBmS2zEyeeRrZdCGOpXoJaemeJ2OYFZjE6idFhn9cim2At8oH4XFagGcWBA27+UezJBX1f2Rou5ooJF/7WPix4YUl5OD2G3/dTvm0HFhro4yJ+/B6QJ+263bQovNU7kvvEeGHVQf/+pndu+HOrFsU2flsAWKVQ6PfGAlDkKtr99kijt4MQFQlXW+HRVKkdU3oB5YVE2PvWO/VLHQl9A++g/h2fhSpR0r6jOfPcV7n4bHXS4hQPtOWb7vFbU1quptK1kw8dRbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUApi9kc+ZyFaJxp2QgPpGXG+DhPxrCY9S76IdinM/Q=;
 b=YntSbdlG7B1iZ56xNTsIrTOwaWA0dSSK6WiMkt73uLsdDoyi7brXVSLPf7svNKZbY8e7+JnCvkMIitnlRMyMkIC70a5W/nc5rmH7UXCyHgIva+79/u5t/d2WHGuCZZlzODXdnsNTAZtkLGhNK1r1VOFWLOJ5TsFciX3H6MpaDWc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5892.namprd10.prod.outlook.com (2603:10b6:a03:3ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Mon, 6 Dec
 2021 23:07:05 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:07:05 +0000
Message-ID: <ba2acdf8-f9b9-8348-86a2-7772235af5a6@oracle.com>
Date:   Mon, 6 Dec 2021 15:07:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v6 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-2-dai.ngo@oracle.com>
 <133AE467-0990-469D-A8A9-497C1C1BD09A@oracle.com>
 <254f1d07c02a5b39d8b7743af4ceb9b5f69e4e07.camel@hammerspace.com>
 <20211206200540.GD20244@fieldses.org>
 <6aea870f-d51e-ed42-6f96-6b5b78edfcc3@oracle.com>
 <33e964f8aef8a94f8b4903c1b9b6c037e37cb325.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <33e964f8aef8a94f8b4903c1b9b6c037e37cb325.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::27) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.137.225] (138.3.200.33) by SA9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend Transport; Mon, 6 Dec 2021 23:07:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef7109e0-5a04-4d2c-ada7-08d9b90d1eed
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5892:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5892F754CCC80A570600FCFC876D9@SJ0PR10MB5892.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdSf7ww434Nkw2ndpphloF15hBEwwYKCXQDRv7R05Hyd+sjuhgXvnsgxqn+ARL5uXa5fbU3CGC4ZnWIwlLxBuDOiDcqC5RDrSj4DYkIk3huxRFQfmQASQRJMJS/0Gr9oD62QaF54razn2nSSD7Ji14hQKVMn/PDLFzBokbMwd/Xmg87uimfYuElT0eBiqy2cuNYh5yN69ZYidLwZXUnTHnoyaXJmf28WIkQ9hyvRPNV0Oz72mLYOZvxekHkozPqKjdgdvHcnO20eEW07I+M8QCUFpGnZfk5Fs2K4uexTUrEVhNHyPv6Tw1wK6rDe96EBLFUmxvew223iPy81DKulFrz9FX5eerdRj/x8qmyNBus5NwtkZ4y4/iR5y7emSayNwLzL1ibiPDjr+J1scNCrx3lEJUdHUWsNRBexfLp4BTgwBH5N5rUUTPqubv/7clAbmUwBl9v+USf4atuHV6EEes0/ie0oJPywQl/Ee+fGqEbLScehfpYWZ2PR9P98f+l6E1cVGLElKfBzThviiK2I7cbt9q9SCWrNiHfM1XfP56+0Qd6mo0LGsKb78VAcylprmKlQ08p6ES63wAXGrdfQTTFHRpOhtCKlpOHmUd5lIgmrRZBw1WRDbxOxF9xmmSNlwYyLdE2O2m2EOy0XWO4fP0OznpFd/yRvlQWCnqEttaq8rGTLHXPRIFzg6vmZgKr4+6WgE1jSyFGz7gNyFFQlAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(8676002)(83380400001)(4326008)(31686004)(107886003)(9686003)(6486002)(86362001)(2906002)(508600001)(26005)(31696002)(66946007)(110136005)(2616005)(316002)(38100700002)(66556008)(66476007)(5660300002)(16576012)(186003)(54906003)(8936002)(36756003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk95RGRLdWtrQkZoSHAxcHU4OTAwLzAwbjNTdFY5Skl2a1RaUUc0MlB6bGZL?=
 =?utf-8?B?UFU5c2pZc1d4MEY2WTdGU2liaE9heWsrNmFnV0xmYURlYkhrRTI5dytRQ0di?=
 =?utf-8?B?cDZ2YU1ac3NFMHBWS05sekxBK3hjbzhwaFVlUnpXbTc2U081cEVQVitLUXZx?=
 =?utf-8?B?UGNWZncyZ2UxZzl2RnFtNW5Yd0pBblB4QktLVFpJYklUdUFXWUk5YUdiYXMr?=
 =?utf-8?B?UFNKbkRpcmJxdHNlbVNhakJXZVlqUG1hcWtvVWJkREZJcW1ONVBSdzFTeHky?=
 =?utf-8?B?bnQrUm5yUnBLcXVWRStKcDdhWEd6ZGs2NmtyeUpZMmJvMFk0VjkyNHROeXBS?=
 =?utf-8?B?Ulc2TjdraE5yS2s5clVMdmRnMVk4b0F3amc1VUV6T2FtcWdEbU51aXlsYWNL?=
 =?utf-8?B?aTFvNG5ZWmFzeEF0MDl5Qk92MWZ2cmY3RHNjVW4ySERqd0pxUkEzb3NTRTRk?=
 =?utf-8?B?cmxWTldaeWFiMEM0S2VqK1ZzcThSMVVvWjRYWk5ONXZxb0RiYTkrUDBxNWts?=
 =?utf-8?B?TTVOc0tXOFdoKzJGOUZvNzlDb0QwVUErUG95dVpOaEUzeXhLMUlLc2t0eE5B?=
 =?utf-8?B?UjBSY2NyOGN4WUtmUGVsNDNyQ3VGSnIxVWhvMG4xSmMyZ0t0c1N6S1VvSThZ?=
 =?utf-8?B?anFzWVZTeUwzN1BuZ0hlS1kyYXd6czBnWmxFcDNHNHdMejRNVU9xVVcwSmRH?=
 =?utf-8?B?cFZhcDRvaFhLV2w0czF3OUtjWUhoclJyTEVwS0RsQldWVk5PVDlhODhnL2hM?=
 =?utf-8?B?NlFJNm80YTJYd1E1a2p1QU95QWdJSjcrSXNZdFNXa0dZenk3UEI5TUVreXZP?=
 =?utf-8?B?Rk1MUjlyenl2ajFqSW9MWFhPdE9xNjJnUUh3R1B3Tks0aUFHQ3B0bGoxYlhG?=
 =?utf-8?B?aVM2VVlkQ2d2SEd3UHZsTDZMYnc0YUFnWHdBa0s2bjVWOWhzQkVsdHFTVzRD?=
 =?utf-8?B?aFJOa2tpUkQ0Y1l3eWl2OGZUSmJPZUpTdTVmY1RLSGxYcmw0b0pWdDh0Z2E1?=
 =?utf-8?B?QUYrSU9qWi9UbTFJUk9xZ05LTyt6WjRqWVdvUXNKRGRQNDl4L05mWjczWStE?=
 =?utf-8?B?b1dubUdvZ2pDT0VjN3pRWnB3TUZhT0Jod0JwLzd5TzBMa2NqaUtMa1ZlN290?=
 =?utf-8?B?M3NOdkxaYVhGK3NvSnpTWGVKamptZjYxQy9ORWZkamFvR1V3d21JOXJxRzkx?=
 =?utf-8?B?QW85cStLR2JqcWFYQW1JWE5SeElIYWVWUmc5cmtXVEthOVBqMVpoMnptYU5J?=
 =?utf-8?B?c2ZzQXBqejlDK3UzUDhUYVlhQ1hLUklrdnZlMi9XSUtha2p6djVhQUo2bDhX?=
 =?utf-8?B?YTUzYmw4UkRRcHc0U0VnSDEyVjdqYVZCUEFwMm5qcGc5TWtwUWQyVDA5Y01h?=
 =?utf-8?B?TDhlWThkOVd2YWk3NkorN3lkS201SGd4OWJCdWhGeXI0MDk0QTFaK0xCdmZW?=
 =?utf-8?B?UU5qQ1VXa0czSWZXTkE5SC9oSjlHc3V0RDgzMGprUG1tem1ldDdaaGRpWWtO?=
 =?utf-8?B?WnhTUGxjTmI1WWZJY0Y2QUw3OW9kSzAvQlhEVE83OFFpZ1VaUHpCWTBnRVlK?=
 =?utf-8?B?SDM0aEFXWldNL1B0K3dnekVtcVI1dW1IMzBEVEhCN0hESDZZRTRCdzN1bjdU?=
 =?utf-8?B?MGh5cWMwdzBXUi9nVU9TQ2xKTkVWVFJmaEN5dStIdzk1VXc4dW5UV2dQb0Zt?=
 =?utf-8?B?ZkdoZ3N1N1gzS1pwSmpYYlRuQ3pGTWw0djh0dFlhczJ6eVNVU3BTdlBTMGZT?=
 =?utf-8?B?ck91bHJnVGROTmJ1TFFTNm9GUzlLQVNlUDBCUEJ4V093QkNFcno1SW9KVElK?=
 =?utf-8?B?U3FydHpFYUlRSUx4M21NVDU3Y29KQXJNU2tTODljZnAyd21OSWxOZWNrclNC?=
 =?utf-8?B?QVd0YjlNN1BubFN4UTQyUGx6M3cxaW1QK2ltdjJ4TFdId3RhaTV3emFJT0t3?=
 =?utf-8?B?L3FySEoyQmdFYW41Tkh3a2NvM2NWN0Z4TXhMOGhGTThNT21NWDY0Yi9HcVdR?=
 =?utf-8?B?U0J5RCtjRE5Vakdndm5XRlB1QW9YdkkzOFYzdythRzFOS3VYb2NFcjlOWFJS?=
 =?utf-8?B?WXArbmpLVUJaMDU2MHFUMU1keGRwYWtZOGlPeWRNVHVTa0kvWGJYaFRuOXpo?=
 =?utf-8?B?M3FTckwvUnZEZ0hYYzdJSy9IVzJlWGFuU2JTZkZ2MGpkVlhPb3ZGanU4OG9o?=
 =?utf-8?Q?BOCTmlYk6rS6yrQdB6Y+aZA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7109e0-5a04-4d2c-ada7-08d9b90d1eed
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 23:07:05.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjq5dnEV/JqiFkmZe3mhZnrVwR2erpDTfhtRyGylq9olC16+HCH5HyHFntoyyy03KDfc+LmVu0hDu3cL8jiUSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060139
X-Proofpoint-ORIG-GUID: HGczKmE_kgYUoGVRhxlUFK81CtfBM-hm
X-Proofpoint-GUID: HGczKmE_kgYUoGVRhxlUFK81CtfBM-hm
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/6/21 2:05 PM, Trond Myklebust wrote:
> On Mon, 2021-12-06 at 12:36 -0800, dai.ngo@oracle.com wrote:
>> On 12/6/21 12:05 PM, bfields@fieldses.org wrote:
>>> On Mon, Dec 06, 2021 at 07:52:29PM +0000, Trond Myklebust wrote:
>>>> On Mon, 2021-12-06 at 18:39 +0000, Chuck Lever III wrote:
>>>>>> On Dec 6, 2021, at 12:59 PM, Dai Ngo <dai.ngo@oracle.com>
>>>>>> wrote:
>>>>>>
>>>>>> Add new callback, lm_expire_lock, to lock_manager_operations
>>>>>> to
>>>>>> allow
>>>>>> the lock manager to take appropriate action to resolve the
>>>>>> lock
>>>>>> conflict
>>>>>> if possible. The callback takes 2 arguments, file_lock of the
>>>>>> blocker
>>>>>> and a testonly flag:
>>>>>>
>>>>>> testonly = 1  check and return true if lock conflict can be
>>>>>> resolved
>>>>>>                else return false.
>>>>>> testonly = 0  resolve the conflict if possible, return true
>>>>>> if
>>>>>> conflict
>>>>>>                was resolved esle return false.
>>>>>>
>>>>>> Lock manager, such as NFSv4 courteous server, uses this
>>>>>> callback to
>>>>>> resolve conflict by destroying lock owner, or the NFSv4
>>>>>> courtesy
>>>>>> client
>>>>>> (client that has expired but allowed to maintains its states)
>>>>>> that
>>>>>> owns
>>>>>> the lock.
>>>>>>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> Al, Jeff, as co-maintainers of record for fs/locks.c, can you
>>>>> give
>>>>> an Ack or Reviewed-by? I'd like to take this patch through the
>>>>> nfsd
>>>>> tree for v5.17. Thanks for your time!
>>>>>
>>>>>
>>>>>> ---
>>>>>> fs/locks.c         | 28 +++++++++++++++++++++++++---
>>>>>> include/linux/fs.h |  1 +
>>>>>> 2 files changed, 26 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>>>> index 3d6fb4ae847b..0fef0a6322c7 100644
>>>>>> --- a/fs/locks.c
>>>>>> +++ b/fs/locks.c
>>>>>> @@ -954,6 +954,7 @@ posix_test_lock(struct file *filp, struct
>>>>>> file_lock *fl)
>>>>>>           struct file_lock *cfl;
>>>>>>           struct file_lock_context *ctx;
>>>>>>           struct inode *inode = locks_inode(filp);
>>>>>> +       bool ret;
>>>>>>
>>>>>>           ctx = smp_load_acquire(&inode->i_flctx);
>>>>>>           if (!ctx || list_empty_careful(&ctx->flc_posix)) {
>>>>>> @@ -962,11 +963,20 @@ posix_test_lock(struct file *filp,
>>>>>> struct
>>>>>> file_lock *fl)
>>>>>>           }
>>>>>>
>>>>>>           spin_lock(&ctx->flc_lock);
>>>>>> +retry:
>>>>>>           list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
>>>>>> -               if (posix_locks_conflict(fl, cfl)) {
>>>>>> -                       locks_copy_conflock(fl, cfl);
>>>>>> -                       goto out;
>>>>>> +               if (!posix_locks_conflict(fl, cfl))
>>>>>> +                       continue;
>>>>>> +               if (cfl->fl_lmops && cfl->fl_lmops-
>>>>>>> lm_expire_lock
>>>>>> &&
>>>>>> +                               cfl->fl_lmops-
>>>>>>> lm_expire_lock(cfl,
>>>>>> 1)) {
>>>>>> +                       spin_unlock(&ctx->flc_lock);
>>>>>> +                       ret = cfl->fl_lmops-
>>>>>>> lm_expire_lock(cfl,
>>>>>> 0);
>>>>>> +                       spin_lock(&ctx->flc_lock);
>>>>>> +                       if (ret)
>>>>>> +                               goto retry;
>>>>>>                   }
>>>>>> +               locks_copy_conflock(fl, cfl);
>>>> How do you know 'cfl' still points to a valid object after you've
>>>> dropped the spin lock that was protecting the list?
>>> Ugh, good point, I should have noticed that when I suggested this
>>> approach....
>>>
>>> Maybe the first call could instead return return some reference-
>>> counted
>>> object that a second call could wait on.
>>>
>>> Better, maybe it could add itself to a list of such things and then
>>> we
>>> could do this in one pass.
>> I think we adjust this logic a little bit to cover race condition:
>>
>> The 1st call to lm_expire_lock returns the client needs to be
>> expired.
>>
>> Before we make the 2nd call, we save the 'lm_expire_lock' into a
>> local
>> variable then drop the spinlock, and use the local variable to make
>> the
>> 2nd call so that we do not reference 'cfl'. The argument of the
>> second
>> is the opaque return value from the 1st call.
>>
>> nfsd4_fl_expire_lock also needs some adjustment to support the above.
>>
> It's not just the fact that you're using 'cfl' in the actual call to
> lm_expire_lock(), but you're also using it after retaking the spinlock.

I plan to do this:

         checked_cfl = NULL;
         spin_lock(&ctx->flc_lock);
retry:
         list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
                 if (!posix_locks_conflict(fl, cfl))
                         continue;
                 if (check_cfl != cfg && cfl->fl_lmops && cfl->fl_lmops->lm_expire_lock) {
                         void *res_data;

                         res_data = cfl->fl_lmops->lm_expire_lock(cfl, 1);
                         if (res_data) {
                                 func = cfl->fl_lmops->lm_expire_lock;
                                 spin_unlock(&ctx->flc_lock);
                                 func(res_data, 0);
                                 spin_lock(&ctx->flc_lock);
                                 checked_cfl = cfl;
                                 goto retry;
                         }
                 locks_copy_conflock(fl, cfl);
                 goto out;
         }
         fl->fl_type = F_UNLCK;

Do you still see problems with this?

-Dai


