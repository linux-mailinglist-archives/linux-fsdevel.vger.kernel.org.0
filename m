Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88607454F90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 22:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbhKQVtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 16:49:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5714 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232906AbhKQVtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:49:09 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHKvPGV001761;
        Wed, 17 Nov 2021 21:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=plcirzHYPsZeZqgLzhUuwdgH8cP6PLocX15E2Omexec=;
 b=Wjlw7giEDCOU0gndHTqL73T5ouXIR5ksGICxpqdwpLYi161nqp2R7VYgrj8xzWrtMF6C
 BTMpesQ7VDpmGOCSS2serOX+FVsQvcZQYWkp68S1ECBk2xK4OxXd+a2qxFvFcwW37U3H
 tijIepMe4XLegYxD698KIYJw6yJxAsOvoK/jUwsngyxPDhWqar1JeAmngrPb6yd0tZOv
 fNTDBhsfAqfyEq12WPeNZdDJQsOmAFci51a5kg61SW2jju353Bvu63mAzS5TI+0HXMvs
 3KUbNEtKPwpzAzQPsjBaVwKcqITy/BbIxyXizflKFzbiZLGWaGXJueYPwjEerouMBItx Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd1w83et9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 21:46:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AHLeiMw172830;
        Wed, 17 Nov 2021 21:46:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 3ca567kqqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 21:46:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9++pSGOxaaegS4LJk0Bmxl6dvbVOqY0MBgx9iiqYcb6kpfuMK8bRRfoMXsQvK8W/YLg7B+sMbQXVHKgKQ7AhmtLGbabxY6AlE0qXt6Lm3n77R/CvSs0QmMSEJM4O+2vDh7optq5NlTkKE1hA4WjEd0MoY/OKKNq2ucfVbt9QuVj2XtsFs4h7eegGwJMXyr8GpZjIpOaoQGhQrJ+SuBFntxppJ9n2w5O71ZY44NRIVsz8rxDxaOrcHudgLIu0CCYgMw6hJqCnOOZHnMojzk6fBgNpNuvb9rLl8eQBNWSvkZ6mSp9WqBr6GUL09IkFiX/p4rooJ/dBD86XDwk1kD0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plcirzHYPsZeZqgLzhUuwdgH8cP6PLocX15E2Omexec=;
 b=Us3Q45hm+qDWlJ69epIE69QC+oNbIeFizu6clrhakP3IL/2udn6zQYWm1TTvokkJ2cjhcJpfdNyne3gAA/JtmgiCqBcKbbhpA4EtSA5f9UGxX6vvf66U/1Md+WtVHmN+pRz1zm9GHGZG6o0SmGZ7JGdqZNJNJjv1QL+grHkFyE3Lrr1k6CSc+dzKj9Gu/ZbU8mJnr9evMZi3k1V0y7qcoCazXZ/q6XVpp2B1x/Dsb/elohA2ORpePlcdjIH5HPs+/JzesGnluaqNEpKIjPkVJcpHWiA+DNkNDOjGfnngNnY7Q+A8JrB1c0ior5jjr9sq+qVyzRmuCXboOdhWzys2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plcirzHYPsZeZqgLzhUuwdgH8cP6PLocX15E2Omexec=;
 b=mTYEOiO/v659ISVJCA1Rmn5PCGppmSXq8PKx1AKDP7zigEzxdr+augOyqm18jP5/+CJFJ6zrkzP32dZSUwhb+a7uE31PxnuPtZMgGFGZFzRer6xByOIC7WFXPiXTEtv04bXLza7wVX+40cruitLfqZ6T6eVE1ikecfGwZrKVRUc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3335.namprd10.prod.outlook.com (2603:10b6:a03:15d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Wed, 17 Nov
 2021 21:46:05 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 21:46:05 +0000
Message-ID: <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
Date:   Wed, 17 Nov 2021 13:46:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
In-Reply-To: <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:805:f2::41) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.159.236.70] (138.3.200.6) by SN6PR04CA0100.namprd04.prod.outlook.com (2603:10b6:805:f2::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Wed, 17 Nov 2021 21:46:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bc5de6f-e560-45f3-27db-08d9aa13a843
X-MS-TrafficTypeDiagnostic: BYAPR10MB3335:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3335B486B4BEDD99E2C98D66879A9@BYAPR10MB3335.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DY4Pjc3fl3p3bDcZR8+JFTscPP0Nm+ekgMC9TeFNVBfk7fnNYI1Pa/U0TkijXtRfLUy/0fdgoiRmozqaWSLxezzy+dYqnMtUUbx4HyvSV6QqTfR0C1d8rHRo4Nf3/rX/pceNz+juTy2F1kOyWJerxbAAgTDAERM4ZZ+W0VNza0DTk5WQJhsHaKpECiAjFkyioj1VmNXegP71c4QOaBkaFXlt6KAH1PV/djwNfWK0qA7Ptkuopkdi2RnY6hImvcBWVkPULeJBzrwWxCiZgLOaCs3GRlGSiA0zjyyJ1azOJ4pKkC4fUSjgHZfbNo5H5NuI4nd4vIKo4vbSXHRHhmy4dfFiApp4ZOGgCqdqHN9PXbiC9L9tA0bQhz2LcIJnzT5iu60644BR3IdOX8Hqy4Oz9yHcdRMT4x/XbwKlwNcWzBNY3ujWVIIdkYyAr6KKEmy0Hk6EfUcwM2JYYvHzpi4acyVZZo6Ii1VW/HkYICoN6x0LlqNIAdksMKP8/FaME7XVmp9SRKdB2ySM2hoZcgKQSlJHXM1abjisUj/Fa3ObsgUhXhqbCJm4J3u4FtjoY2iD0I7KHxLN2lZoJj+gs4El40Nxrav9vdmE0HXZZI5JuGczjLgRUsxQ4gew4F9SSDTVoBP7+C1PHDeWGOmKZPVj2X6RH6yhxRwAf9IvFL+vk1vn53w1f3vlWcEHsKIekYnKw/c07v8YvEwgwS3nfxStZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(4326008)(38100700002)(316002)(2906002)(86362001)(9686003)(31686004)(19627235002)(8676002)(5660300002)(16576012)(53546011)(6486002)(6916009)(66476007)(2616005)(66946007)(31696002)(26005)(83380400001)(956004)(36756003)(186003)(66556008)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW5sanNlK1ErN3ZqMlBqNVkvb0tRY3lSTkcrVWFaTU1FVDNFbldMeFBzVEJF?=
 =?utf-8?B?akN4OVdlRnlWTHNmbWpWMWwvYkRNbmlQbTQxWnFWUy9pc3l0Q3FkV1ZrOVg4?=
 =?utf-8?B?SUZPU0NEa1pzNGNjeHF6eWc3dzljMzZrbGQ2dldHdndHQThHTmpPU0t6R3Ny?=
 =?utf-8?B?NDhpcUpjMjhydTBIOEtiN21WeW8zM2h1TzJkMHZHRi9wWkY2eHg0ZTY0YlZN?=
 =?utf-8?B?b05wRWY1QVF6bTBiR3lmeG1mR2N2aUJiRjlnRWtkNkMvY2hkMXk3dGZlUSs3?=
 =?utf-8?B?b0YrMWNBV0JKZmRJZXNXdW9ScTg5MzhUNktiWEp0cnJhcUxEWUthNHY1M2I4?=
 =?utf-8?B?RDZ2Smw0TlVqNW1iaGxjcS8vNTVSUmc0ckY3M0VpaGpEK1owUjVCVy8yQlNJ?=
 =?utf-8?B?ZUdPb1l2dy9XUlZWSTdlOWRaakVxNTFWcjE5czN0L1hEWWgwQW1id0NQSTVm?=
 =?utf-8?B?U3ZqVWRxc3hwMlZJUDdjRElvRXloNFhLV0d0N3Z3ek1uSzNSR1p0UERpQWRO?=
 =?utf-8?B?Wi9qYythZGFBV2lzbjkva3hsMTE5OElONGpSVnFFUFpBZTZwT0ZHSDBIbTdn?=
 =?utf-8?B?K2NWbDZISmdGOHdSUkUzemdWbWNIdkN3R29GcnhCRGV5N0VNWWZ0TkNLZUc2?=
 =?utf-8?B?ZUxJOHFZSGdJYkpJa2JYNmNSN21pWEJiNGdRekE0eVR1ZFB6WUl2VXA5N3hP?=
 =?utf-8?B?QlFyQk9YZTY5Sy9MRmx0ekpqS2Nnd01tQ2NxNzBPVlhiOFd5MjVuS3BEZzFH?=
 =?utf-8?B?WjZRakVFR1BGTG9UOWtMVVJFeTRvQUlLOVZMVm5RdFQwRjZKUzdEVWZNQ2Va?=
 =?utf-8?B?VW0yVE5xdDhiU0FsUXBmbkpwZ2lIZzFsOEhFNFI4UWVUV1dabFNPcXhGcFBs?=
 =?utf-8?B?QloyOHFyNldaaDVpWmttRGNGS2JlKzQ5aWpmbTIwUzdLMDdoZXFzcnJJUTRN?=
 =?utf-8?B?NTJXVGRYdDFXa0JzckhYNnJ0ZnhNZHYzR0tOUE5tVHMzMGk5eDlDcHhVUzZI?=
 =?utf-8?B?c1lKTktSVmxtUW1IL09wb2RyUGxUb1RDSmFNQTVqd1pMOG9yYTd4dlEyY1Jt?=
 =?utf-8?B?eGNSUnBxcGxjL1J5endMeUd3empRUXFIM3dqV2dZRUVOcnVzanE2ZE9ScUt5?=
 =?utf-8?B?dzRCdTltZ2dMcXVXUnlJNlNGVGUxWVg2Y1I5QnFmUVpKYTFaRW9vUlM4Y2dG?=
 =?utf-8?B?ZlZJK0ZJVVJCN1IzOHRmL3UyZWJVQUgzb3lGMVhtYzl0V1V2Vk1kSnJXaGZa?=
 =?utf-8?B?V1pkTDdQYnBSa2NQWEE0aS9pZXFXeWhoeFlOc3RCYWdIckJrbFBmSFJBejNr?=
 =?utf-8?B?U2lpdDdmRVBXWlRMQ1lnMzN6MXlONFpPRjZyUTRmNnk0Mkw3QmdDYU9Vakov?=
 =?utf-8?B?LzYxWWptR2dkS1p1YW55VFhEMkgrMnYzd1dzMUxoaDBxTHA0WjhKQ2tqNktq?=
 =?utf-8?B?VlcwNzVCYjFjcmRZTnUzNzNTWFVaR3dPZ0RVcDcwY1hRRGNkZ080bGpzdm9Y?=
 =?utf-8?B?aHlBT25UaEl3OG1WRCs2ampMMXdNSlFvdUdLMkRrWFRGS2JyTkxjMUhnTkox?=
 =?utf-8?B?MWJoTkpsSzg5SFkweGFQMzh3Y2JRWDBHR3dOZmFOVXFKakxNTG52aXVQK3kw?=
 =?utf-8?B?RTRhbEo4OW5UdnczQkVNWmNSUnFLV1g4VU56UmtEZFNlaWxkZzF5QnRrZVNz?=
 =?utf-8?B?TXRMT3BqUWNwV2phTzFjbmtUdmIwcFZESWJLSzQ3UC9FUmc2QzdoMUgvbEta?=
 =?utf-8?B?UTRRakl1SG42Y3k0TmNzMHU0U3dKZkRvVmlTVjdVd1hDcU9KT0hHVU1kUHl2?=
 =?utf-8?B?U3d1dUN6WlRxZTN6STZmUldYNExFYnRrcnIzWGEzY3doMHgwWjB6VDJlR1BW?=
 =?utf-8?B?MW4vREUwL0Nsdnh1SFF5QXd6TnBwUWFLdXNWZUJEdktWSS9YSHYySTFDV0dF?=
 =?utf-8?B?MklkbjgvS2FUMC9vZHgvdGltaUxraDYrUUxqV1JSNXdtMmI0aTlZMFJ6Qk9F?=
 =?utf-8?B?ay84ZHd2alpDWUhDeFRKcmFOVkw0QWgyekUzMTB2aWNienlFUkdxRC9WTVRV?=
 =?utf-8?B?ZHRKWVZ1Wm9hT09sWWFLYTRmVXRaNTNjejVuQVVWTGx1NGNtRWJ3VXdGc1lJ?=
 =?utf-8?B?M09GR2szcFJyTWt4ODA0TlBYeXVSMWJlR2daM0gvU2FLVUxOeFJNcjM5WEU3?=
 =?utf-8?Q?DMkqEogqMnLZSndlbRglsls=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc5de6f-e560-45f3-27db-08d9aa13a843
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 21:46:05.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTdlFhjb56hwYZ3lkbIS13j1XMo3dXtmNki+rppTgWcveAIXqSuB9mba9DEpue66pJHaNWtGtUH/Xvif6+Uxjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3335
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170098
X-Proofpoint-GUID: 0WERvYGxigI7wwQV72fx_SihwDyIefq2
X-Proofpoint-ORIG-GUID: 0WERvYGxigI7wwQV72fx_SihwDyIefq2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
>
> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
>>> Just a reminder that this patch is still waiting for your review.
>> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
>> failure for me....
>
> Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
> all OPEN tests together with 5.15-rc7 to see if the problem you've
> seen still there.

I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
5.15-rc7 server.

Nfs4.1 results are the same for both courteous and non-courteous server:
> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed

Results of nfs4.0 with non-courteous server:
>Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
test failed: LOCK24

Results of nfs4.0 with courteous server:
>Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
tests failed: LOCK24, OPEN18, OPEN30

OPEN18 and OPEN30 test pass if each is run by itself.
I will look into this problem.

-Dai

>
> -Dai
>
>>   I'll see if I can get some time today.--b.
>>
>>> Thanks,
>>> -Dai
>>>
>>> On 10/1/21 2:41 PM, dai.ngo@oracle.com wrote:
>>>> On 10/1/21 1:53 PM, J. Bruce Fields wrote:
>>>>> On Tue, Sep 28, 2021 at 08:56:39PM -0400, Dai Ngo wrote:
>>>>>> Hi Bruce,
>>>>>>
>>>>>> This series of patches implement the NFSv4 Courteous Server.
>>>>> Apologies, I keep meaning to get back to this and haven't yet.
>>>>>
>>>>> I do notice I'm seeing a timeout on pynfs 4.0 test OPEN18.
>>>> It's weird, this test passes on my system:
>>>>
>>>>
>>>> [root@nfsvmf25 nfs4.0]# ./testserver.py $server --rundeps -v OPEN18
>>>> INIT     st_setclientid.testValid : RUNNING
>>>> INIT     st_setclientid.testValid : PASS
>>>> MKFILE   st_open.testOpen : RUNNING
>>>> MKFILE   st_open.testOpen : PASS
>>>> OPEN18   st_open.testShareConflict1 : RUNNING
>>>> OPEN18   st_open.testShareConflict1 : PASS
>>>> **************************************************
>>>> INIT     st_setclientid.testValid : PASS
>>>> OPEN18   st_open.testShareConflict1 : PASS
>>>> MKFILE   st_open.testOpen : PASS
>>>> **************************************************
>>>> Command line asked for 3 of 673 tests
>>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 3 Passed
>>>> [root@nfsvmf25 nfs4.0]#
>>>>
>>>> Do you have a network trace?
>>>>
>>>> -Dai
>>>>
>>>>> --b.
>>>>>
>>>>>> A server which does not immediately expunge the state on lease
>>>>>> expiration
>>>>>> is known as a Courteous Server.  A Courteous Server continues
>>>>>> to recognize
>>>>>> previously generated state tokens as valid until conflict
>>>>>> arises between
>>>>>> the expired state and the requests from another client, or the 
>>>>>> server
>>>>>> reboots.
>>>>>>
>>>>>> The v2 patch includes the following:
>>>>>>
>>>>>> . add new callback, lm_expire_lock, to lock_manager_operations to
>>>>>>     allow the lock manager to take appropriate action with
>>>>>> conflict lock.
>>>>>>
>>>>>> . handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
>>>>>>
>>>>>> . expire courtesy client after 24hr if client has not reconnected.
>>>>>>
>>>>>> . do not allow expired client to become courtesy client if there are
>>>>>>     waiters for client's locks.
>>>>>>
>>>>>> . modify client_info_show to show courtesy client and seconds from
>>>>>>     last renew.
>>>>>>
>>>>>> . fix a problem with NFSv4.1 server where the it keeps returning
>>>>>>     SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
>>>>>>     the courtesy client re-connects, causing the client to keep 
>>>>>> sending
>>>>>>     BCTS requests to server.
>>>>>>
>>>>>> The v3 patch includes the following:
>>>>>>
>>>>>> . modified posix_test_lock to check and resolve conflict locks
>>>>>>     to handle NLM TEST and NFSv4 LOCKT requests.
>>>>>>
>>>>>> . separate out fix for back channel stuck in 
>>>>>> SEQ4_STATUS_CB_PATH_DOWN.
>>>>>>
>>>>>> The v4 patch includes:
>>>>>>
>>>>>> . rework nfsd_check_courtesy to avoid dead lock of fl_lock and
>>>>>> client_lock
>>>>>>     by asking the laudromat thread to destroy the courtesy client.
>>>>>>
>>>>>> . handle NFSv4 share reservation conflicts with courtesy client. 
>>>>>> This
>>>>>>     includes conflicts between access mode and deny mode and vice 
>>>>>> versa.
>>>>>>
>>>>>> . drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>>>>>
>>>>>> The v5 patch includes:
>>>>>>
>>>>>> . fix recursive locking of file_rwsem from posix_lock_file.
>>>>>>
>>>>>> . retest with LOCKDEP enabled.
>>>>>>
>>>>>> NOTE: I will submit pynfs tests for courteous server including tests
>>>>>> for share reservation conflicts in a separate patch.
>>>>>>
