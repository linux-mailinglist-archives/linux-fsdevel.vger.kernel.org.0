Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D3A454CAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 19:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhKQSDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 13:03:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15220 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229678AbhKQSDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:03:00 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHmOi3009077;
        Wed, 17 Nov 2021 17:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tbJzhO3VYDgv9rVUmSgg5nAgcQjvKPsSil7VjBr6L10=;
 b=waiyhg6P8jIqh4xGVxwcxOAY7G6VrUdmvKij03EkTTX/qdx3q2lFnF2BUWsh5oIcBiXp
 aCKwehKfaO3hnZZpMD6PExEbPJpxRm80MCCmtxjcA1Hxfx5r2dprMEY0yLqpn9Fx6hfM
 qpsTivFOnTY8mgB1fwlMq6YpGebL2JMQaCAgPPAUTNnq7sS7K56KIVV10RrRcXdIV/QG
 8Du1Ti0hkhHrZXl7nWnlsQ5B1oyLlXncIDLQEYQmjkgi7OYtASUNFa8Ug9UZZaHhTpvk
 MQyQOpN3haidtwgtALd75V8fDHjtajgRhvR/WvARRbM+qFQoS1fArGWXZQUruSuAWOSB 4w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd2ajhyqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 17:59:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHt5FY014184;
        Wed, 17 Nov 2021 17:59:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3020.oracle.com with ESMTP id 3caq4ume9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 17:59:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfvOv126CQdWiuX75TKkmPTS1N2EaUszU+6Qln/o6CEtBHJ2JgxUuqEkQVXhE8imodPcU7BskwzC4TeulEiIEO6rJEW5Je/DBxsYD+V5kMCwPM6tB0RxGDLGHWvcVRRYYbPy8ZQJsub/VAzHwnHIFueoo4j1XrOSlY65ywclkBuEE4q2DLsyrTm/izcSHsK1tjVAAVltUTeGda4VMI+r4Qc34epNz3kQD1hkaKJfNv/SVujiSk/eNl2mD970JuoYbpuQvU4GxJln2PTSiYuhLP+VR0mYYK0c9FmLInqoPm57XYSfhAgpiwmZ3NIeExArKERkdvq/l6FseBK34ILdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbJzhO3VYDgv9rVUmSgg5nAgcQjvKPsSil7VjBr6L10=;
 b=QZ+b3FJpXCwEurI7hQGmzEYFMBdrt3jDWnVTV9WxhyVTiUb/D6+Jd25XSoudwdhUdlU337/tO7+FY3yDy4KkA/0S1xQQU1QOjD9XyoKRPuacf0fSBwcNwJYlyXQLXnCR6MqMKkhkMEGLidNqHDcgyWtYZRUU36euPj3Rkho7fXNF+M9Gs3R4EbErHW4sGw2M6LjZn7uKn/FE0UiYOwGjO83t/GrjxS2uN8a8KZTrY+XEhu45HRvGXuH2OpZR3Ytuasb249pW+LkmEXplL/cykMqdXVHXhEB27l1+GAsNe2+5J70/NK5RtIJfjx0OfPGx7v2RnSKncbiZTz8POPhExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbJzhO3VYDgv9rVUmSgg5nAgcQjvKPsSil7VjBr6L10=;
 b=SkAw7Bu1oitjfY/pyIW+yzgMVBvtftAFF3CFJwdXPRo/uGc9OToERxE3BtNaEls4SSa0SL83yfHF51DKPBA7Gs76Hu+Kz45OvaYc+dcUjhjdVdlUmuylbu89ZAbxW6ScncEQkHj6x+uViBidRDh+Oz1iIe9EtMy51cxa+lLKxF0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4768.namprd10.prod.outlook.com (2603:10b6:a03:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 17:59:55 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 17:59:55 +0000
Message-ID: <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
Date:   Wed, 17 Nov 2021 09:59:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211117141433.GB24762@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:d3::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.155.124] (138.3.200.60) by SA0PR11CA0002.namprd11.prod.outlook.com (2603:10b6:806:d3::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Wed, 17 Nov 2021 17:59:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf0393d3-6085-4566-5385-08d9a9f40f85
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4768:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4768081E56966EA79801D698879A9@SJ0PR10MB4768.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0eK+TwtWzNYFAn2ioOeMaBhfzNpCVTGNmaY59cNvhxozOcaxb4dUEJIDQtkavPrLn2pAn/Mv6gHDTJh3q9pYCln6VE7R6UuhBeEMWvyiyiIs9OkukhMQmlcZca5mLHt5VI39/qFw7mulxVMgFniN2Bk7i3WFjMllC4PiQF1V86uDvVfCGajQOUvQEv8Aokgt6bBAZtRR5uakhtqBK6JFtwAxTcv5zi+DviveXEVrhqNx1f4lfzaSrCvwVnQGHsAm3V0epUNu2T2Gd0XVychfA4lsL0Wp6eYOEZsI/SC9FGHJIBUAYfktrmztMvoMODt1qLzQOnucJfhShoPluaR3WnOcEIVwdqPxpT2W+9973KQvclYbk4Qc1CY4WiDBKow2fNLZCtAImtwRJYP99KdthZLqhm9YFqkBqDauGSiZBQk9yaRzSzKZg8ynewg6lIi+ZobF4yB68IvDrEXM/7weq1SmU3PGYpVGwujccSlr+A6NJRwQr1XgyscFiLFdXHuPZL7RwWAKaBI9mnoWey7MWjtG+2WIIB01A2T5pOUfONLDaK2VRNhVwuEJSagUKxEeb7vSfDhC+DtbgZuQu+4CJrDFiyldC7iJx4Aj4DpFmF4ZkK3zcLcA+02v8mBWFMOfUSneESIHcMv3+eDFA6ztZ+B8nClN0AZYreTdq/TlP+UfezktNE6yTMLSfsm6BCi0DdZAZAriyY5phSCU8BSjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(6916009)(8936002)(53546011)(4326008)(9686003)(5660300002)(186003)(8676002)(86362001)(36756003)(31686004)(66946007)(31696002)(2616005)(66556008)(16576012)(316002)(38100700002)(2906002)(508600001)(66476007)(956004)(19627235002)(83380400001)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ZKT3NZZEUwYmE4TmVNUitQVjNBcThTMTJvYXoxUGIrVFJOVlhPV3A1ZDVX?=
 =?utf-8?B?cXlPczE5ZS9lRHh0SUNVVEJ0d1duYUc0aTNiZkhmbGN4ZEVyYTFVMjdzSG9G?=
 =?utf-8?B?ZTZ0TXlaamZwSWVTTVJDUG9CZFRNcU54Tkw3WEJvaFIrVUpIODNCNXl5d1hC?=
 =?utf-8?B?dzhxZnBWSTZ1ZGJiNVUzTi9CN0h6ZHdFR2hTaWV0MTVDT1Bpa3VreDFjN2RH?=
 =?utf-8?B?dDg1TVpVQ2x1V2Y3UTVzWlZXWEt3dUV4cWtPcWxjbG01N1BYT1ZuQkxUd1Vw?=
 =?utf-8?B?bndDZ0lZVm41bElDUUw3T2RuNU9ZUmhQRWxjcDZOUkdCeVF6YnFGYkROLzlj?=
 =?utf-8?B?amxpdXpUK2NJOWdjNkx4MU44SStDek03N205UjFkakFQWFdYMjlMT3V5cjZK?=
 =?utf-8?B?bzBGZ1UxVkdIV1JaYWNKbjhHTlR2VERYUEdyNnF2aEl0TWFrZkduZzhzaDNX?=
 =?utf-8?B?Z2tGWFJOdDMyQmt3d1RhTmdscDFEOC85MTN0ejEyT3c4L05xZFZsQ3IvbkRp?=
 =?utf-8?B?dHRHTjZnYnRBUDhwUDNxazhEOGl3aUhMbUtxQ1pEdmV1cWwxQ1dHeFcwckR2?=
 =?utf-8?B?dGZUcTJHNlg0Rjk2VDYzWDQ3emwrOURyeHVhNDhUenlIcmFyT1BUTUg4OFRK?=
 =?utf-8?B?eXgvOEVmMEhYb0Y1ZzJLNHJZMGRpeUlTMk5YUlVXUnF2WEdmZlRJLzBSbGZs?=
 =?utf-8?B?NmEyemRLakNiWi9pODVTZ0FDcGsvaHhvMGVsaEJCb011RFd4V1IxUjExVm5Y?=
 =?utf-8?B?cVVFVWY0NDFPT2tadXpvOEZHVnNiamUwVWxRVXNlSHQxMTdTZWlrWDUvVWlv?=
 =?utf-8?B?dWxrR3g5NXJaTE5NNml0b1d5cTJ2RUtVTFY4QWp3Vk9PQWF5WlFuZjNKMkU4?=
 =?utf-8?B?QWpKY2M4M2cyeTFtc1huSUhjWllCUG1DMkJsdkNWZk41RlBUeWtIRVF1ZUNI?=
 =?utf-8?B?Y1pKd3p5UXcrZFFlV2N1UFFzT0loMVM2MnlLSUtLTGQ5cWxOcThpcjJpY0Zt?=
 =?utf-8?B?cjBxWjVMaEtPNVBPN2tuS0xqWTFnbnJaZVdCaDdTTHNiWVJJRkQ5ck1iS0VW?=
 =?utf-8?B?ei82aHc1K1BpVzFBSW84SjJWdWR5YzF3RjN1TXB1OTdQL1RoY0d6WFRVVnd2?=
 =?utf-8?B?SDdVL2twbkV2SzI5R042TlgybGJMc0hpMndhUU5sNlFBNll6Ym9TY2VWdmc1?=
 =?utf-8?B?YWpkS3hTTytQdFhpUUFLdHF6K2tZK1B3MUU0SjJiVTlxTVZkOGxEV2xsUDBj?=
 =?utf-8?B?NW8zR1BDTFNDZ2RObTNkc1VGU3pLWUdEYmR4UVN0LzNaWUpaVXVEMTM2cGM0?=
 =?utf-8?B?bktNNkN4LzgzRUhYSndFdWVsOHlEdDNGZ0FDL2phSFVmK0JnYkQyVTFWNmsy?=
 =?utf-8?B?SkFybjhVZW9wMjVnTUlOL1l1ZFVnMTQ0WWNSQjZGMy9ITzN0ZzN2SFNrQ3U1?=
 =?utf-8?B?eTZUZnYxSmVkaE0yd1FZQk1oMU9OcmwyR1o2V3dQZjdoWWRudUZHblJMamNV?=
 =?utf-8?B?elJ6WFBRbC9Qby9KR0tReEppalBIYTZZRlMwUzA5aDRTL0lWaUVJVlhpOXor?=
 =?utf-8?B?OG8xZ3RUTEVEUWxKcUJ3WmRPZ1ZpRk54QnRHRTRnTkdoMVY2ZDlFbmdRRmR6?=
 =?utf-8?B?QVVNU0l3bC8zbDZ5K3hsNS9yeVBFR08yY2YvbklxbnhjejA0UUdlYXdYM3Jn?=
 =?utf-8?B?RWhCZStSQzNhTjU0ZHNKazc4VkFwd2E3Ky9IMmRWSnQ0M2grdWU4bjMvSmcr?=
 =?utf-8?B?WFBsU1krU0VhNEpjaG1HSXAzVDlUaFlabXhvNFNYRDA3Q2x1OUM5OXFSbG5B?=
 =?utf-8?B?ZDZwMGhDbnMzbEZ6bkFCT053SUlEczNqYmVnUU9vMzh2VnVBQ28rMXpXVUkv?=
 =?utf-8?B?TjFrbUF5VS9lVXVTekpjVUU4VVh4V2hETEpBNHYyQ2lKNzBOOEJLZlRMaFJ6?=
 =?utf-8?B?eGh6Rm5taEtzeE1wZ3g1ajNTM1ZteVBtZVYzcmNYOW1rM3FtUTNUbXVDOEVL?=
 =?utf-8?B?eFlRVzFYL3hFeW14Y3lZek9vZFBWUXFZUnRhK1lTM0xWUHVaL001TjQrd21k?=
 =?utf-8?B?SEErSmJWbG5LUWVPQzhPTWZCaDhxVEpmVTF3TkRYOEQ3MC9TZk9KU1pPOExj?=
 =?utf-8?B?Rk1DZUZCU1BiaFBuRXljdXhBSmIzY2ZQTzJYVE5veUJRWWdpQkoyUXRodVNr?=
 =?utf-8?Q?0n7PvcsLDSemkSM2MQWfoIU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0393d3-6085-4566-5385-08d9a9f40f85
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 17:59:54.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+YLlCBYQvK+NP89QuU2Gpw/VVdh6Yccz0lvfP97p6uwNpj7BU0tdtBhMEHg6i2oPJi0hL+dPoNb/hFe3jdrcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170082
X-Proofpoint-GUID: yZiRgOGuDwDkcDU-Ea_fDs3EAPxyFWAS
X-Proofpoint-ORIG-GUID: yZiRgOGuDwDkcDU-Ea_fDs3EAPxyFWAS
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/17/21 6:14 AM, J. Bruce Fields wrote:
> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
>> Just a reminder that this patch is still waiting for your review.
> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
> failure for me....

Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
all OPEN tests together with 5.15-rc7 to see if the problem you've
seen still there.

-Dai

>   I'll see if I can get some time today.--b.
>
>> Thanks,
>> -Dai
>>
>> On 10/1/21 2:41 PM, dai.ngo@oracle.com wrote:
>>> On 10/1/21 1:53 PM, J. Bruce Fields wrote:
>>>> On Tue, Sep 28, 2021 at 08:56:39PM -0400, Dai Ngo wrote:
>>>>> Hi Bruce,
>>>>>
>>>>> This series of patches implement the NFSv4 Courteous Server.
>>>> Apologies, I keep meaning to get back to this and haven't yet.
>>>>
>>>> I do notice I'm seeing a timeout on pynfs 4.0 test OPEN18.
>>> It's weird, this test passes on my system:
>>>
>>>
>>> [root@nfsvmf25 nfs4.0]# ./testserver.py $server --rundeps -v OPEN18
>>> INIT     st_setclientid.testValid : RUNNING
>>> INIT     st_setclientid.testValid : PASS
>>> MKFILE   st_open.testOpen : RUNNING
>>> MKFILE   st_open.testOpen : PASS
>>> OPEN18   st_open.testShareConflict1 : RUNNING
>>> OPEN18   st_open.testShareConflict1 : PASS
>>> **************************************************
>>> INIT     st_setclientid.testValid : PASS
>>> OPEN18   st_open.testShareConflict1 : PASS
>>> MKFILE   st_open.testOpen : PASS
>>> **************************************************
>>> Command line asked for 3 of 673 tests
>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 3 Passed
>>> [root@nfsvmf25 nfs4.0]#
>>>
>>> Do you have a network trace?
>>>
>>> -Dai
>>>
>>>> --b.
>>>>
>>>>> A server which does not immediately expunge the state on lease
>>>>> expiration
>>>>> is known as a Courteous Server.  A Courteous Server continues
>>>>> to recognize
>>>>> previously generated state tokens as valid until conflict
>>>>> arises between
>>>>> the expired state and the requests from another client, or the server
>>>>> reboots.
>>>>>
>>>>> The v2 patch includes the following:
>>>>>
>>>>> . add new callback, lm_expire_lock, to lock_manager_operations to
>>>>>     allow the lock manager to take appropriate action with
>>>>> conflict lock.
>>>>>
>>>>> . handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
>>>>>
>>>>> . expire courtesy client after 24hr if client has not reconnected.
>>>>>
>>>>> . do not allow expired client to become courtesy client if there are
>>>>>     waiters for client's locks.
>>>>>
>>>>> . modify client_info_show to show courtesy client and seconds from
>>>>>     last renew.
>>>>>
>>>>> . fix a problem with NFSv4.1 server where the it keeps returning
>>>>>     SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
>>>>>     the courtesy client re-connects, causing the client to keep sending
>>>>>     BCTS requests to server.
>>>>>
>>>>> The v3 patch includes the following:
>>>>>
>>>>> . modified posix_test_lock to check and resolve conflict locks
>>>>>     to handle NLM TEST and NFSv4 LOCKT requests.
>>>>>
>>>>> . separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>>>>
>>>>> The v4 patch includes:
>>>>>
>>>>> . rework nfsd_check_courtesy to avoid dead lock of fl_lock and
>>>>> client_lock
>>>>>     by asking the laudromat thread to destroy the courtesy client.
>>>>>
>>>>> . handle NFSv4 share reservation conflicts with courtesy client. This
>>>>>     includes conflicts between access mode and deny mode and vice versa.
>>>>>
>>>>> . drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>>>>
>>>>> The v5 patch includes:
>>>>>
>>>>> . fix recursive locking of file_rwsem from posix_lock_file.
>>>>>
>>>>> . retest with LOCKDEP enabled.
>>>>>
>>>>> NOTE: I will submit pynfs tests for courteous server including tests
>>>>> for share reservation conflicts in a separate patch.
>>>>>
