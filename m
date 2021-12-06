Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FDD46A703
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 21:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349484AbhLFUkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 15:40:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61452 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243449AbhLFUkI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:40:08 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Jh24Q019193;
        Mon, 6 Dec 2021 20:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gvpI3DXDx9FoYicY5bya/gxjZWWeclxW6fbQjcRxm9w=;
 b=obzVZI5JJbiU2mXnnSrGFaJKwTWEUy0nm1nZHIL+R/1TKM4tssUaDeTPJZ8lz4Ewo2US
 pFozSZee5US4h2c8WLS6wFjqMuFBKui9JXclbPSioQWLXUY3YuSyrHHoKkAqylRsPefX
 Fb5Mo12UUqKHb6WZpCkGZPw5KDhiobclBYlUEc1v9QR5l2kTiQbDkZIWPPgkyNFwWBH0
 7j1SPqgIm+R6PnrW6+M6fRjuM6PCBoM5yg484JaeqoIllEhoEgvRmzLecV7l8lQVIYXs
 g/EUV9cXNin4Wd1sFMK8hF5kwJDXAKwupMeYtbLDUSMitWzsr0buzAtb+C+2OpRxio5t OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2yb7yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 20:36:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6KVBcH056230;
        Mon, 6 Dec 2021 20:36:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3030.oracle.com with ESMTP id 3csc4sadrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 20:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuK0dhKtvX2DiDFALI8402aJ/w0K1J1loEwNDFX7SAKoTVjNkapREjQPiFKGQI/c8imr4b57pn2gxF/A4X7IH6Vd44gjnHP6KoaifWtWQRxYDWjTk/R+0TeOjFB6fixSYKZIWEyn3lzftIRlGsBhYFSQ4X6JMkLssoXiZKrxorPTBLayN3jImrEzYBT4DZxUsvu3GEOF+up/x/+FfSKaieYQ+Odw2I3WQLnnVuUoD6c4l+sUdOc/Hh78ZkknNLAsmAJhhbaVAX3KOzYLRXiU+WFLW929LSC2WeR4ML/KpH8/avTi4qPEWGNRcE9U4XZauj04L6lXWW5IUM96EPQC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvpI3DXDx9FoYicY5bya/gxjZWWeclxW6fbQjcRxm9w=;
 b=HcyzdA69WNIFduaYS9R36VZqqRppTzNg3d9eC3j6BTu3GRH/8YUwzPAAAcMuWPnkWgj1BAMf5CannOqP54UBIPZM0mowcAU0wfNAjoP+GKaaCVncZt64fAAiCVSS9AyYbs5l+uryW0YSyd2E2X6WTBWLw2580W2EeFnOmh/cO3Uq1D3AtzpEkjB9dmWpj7GUpucIV4FaOmPpxN199gVq1OCaF/Sm7ixpxDl2ogawcmsghmEAQvrsBgNCvhCyVWm6fl2/bXzyst3vuxBUps0GHNbhza6hYeLxundfmZtLnhd+eL3gSXmFgl5XLZQBisYJ82tGaiN3LGj5VYT1z7TMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvpI3DXDx9FoYicY5bya/gxjZWWeclxW6fbQjcRxm9w=;
 b=NwpII2OlbHflE6x6duMSVRi0VYudxohLt5vYO4Np28rAKUiCyMp47lLwWYJcFKOZsaX2skOO1ct9w3VJjvvo5r5cCQp0x/o2tmDfBCAOsAj9J/Bzhf4NxlwrZ3f7H7y6TP7Z2YDGGi9CYAqmRxGADO0eccPO/60d9hXNQTiAw7k=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3415.namprd10.prod.outlook.com (2603:10b6:a03:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 20:36:28 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 20:36:28 +0000
Message-ID: <6aea870f-d51e-ed42-6f96-6b5b78edfcc3@oracle.com>
Date:   Mon, 6 Dec 2021 12:36:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v6 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Content-Language: en-US
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-2-dai.ngo@oracle.com>
 <133AE467-0990-469D-A8A9-497C1C1BD09A@oracle.com>
 <254f1d07c02a5b39d8b7743af4ceb9b5f69e4e07.camel@hammerspace.com>
 <20211206200540.GD20244@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211206200540.GD20244@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.137.225] (138.3.200.33) by BYAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:a02:a8::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend Transport; Mon, 6 Dec 2021 20:36:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23fc51a0-887a-4e95-b5d4-08d9b8f8146b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3415:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3415BC3FF97C393DA35469EA876D9@BYAPR10MB3415.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjaobAFDgTEvi/WK1ubFTCjfKdoHqxPi/F3KeyIVowtpT7uuAhojg6SWspWEzUuxr/QcZHzKoQJcmGu9ScJBBkSv/sCMgPS9pikGLU6FvhkIL9R5h0D1STpmfYKkPW2D6fIK0+NJbrREC3duD6TXbqomQQO3KfXMsn37iaNiOsBKFm3FVnRE/eHmeg4oaEmMW6QT2ALw97/7JEux4Mi8J/L1Om1wHyMNQI7qJzAAAlrSfCccw1BqSLsRLsBm9MoCnIphB84oQHxTNXJ2eiDsPZGvtkayf2O+g1wgVtlQQz+n4QUtp1PTheGVWb967rMFBlnTJWviHMjf2TY0UzMmshm83pvX07GjOm32ilg9PbQ4SJwPKoZOZ+NtqFOAomxZB/cKTpqP/m52DvqfKDDskUjUOctvp0cJhZ/phNEPHFUYVIVM3MCPXJC7eOLWr56n8fRR71VWfOpsOSTlvvaT6QW96BmTxl9ffvKGdomeQBBTrzZgG68qKN+a5nxoJd1OxbS6eNhBuVB1rGRB6f0nqrCseUP2II01R0PAKH7yD5Vjylc0sdSwFoycQDZKsKx+huo+Gp9L1QCZ9993IHd2pT2LVaS6ZjmPIt4GE8wqJC7e2X53kWzS+BR/UXVNsnco6cbso+0KpgVsCRTjMR8JVG+ygO8CybJgyHGiCNNeHiA144kWJf8yI4VDG/n682iQCl3QbWVOpaxWuhWoidBIIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(53546011)(5660300002)(66476007)(66556008)(186003)(36756003)(26005)(31696002)(8676002)(9686003)(110136005)(66946007)(38100700002)(16576012)(54906003)(2906002)(316002)(508600001)(86362001)(2616005)(83380400001)(4326008)(31686004)(956004)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0I3UTcvTVl1YVdnZ1FaUlFuU0dVcGtDaTAyYWg4anZVcFN3SEtnaVFwdS90?=
 =?utf-8?B?ZWxWa082UTYzRjZsSVVvWVdveElLUWFGVHBWVnNQNHNab2RGc0Y4aXMzbEN4?=
 =?utf-8?B?bDJkNEVYbzB2Q2ZhQlJtbFVPR2t6ZGhDRFhvOEEycVZpcExrbEFEUTYrd25h?=
 =?utf-8?B?V3F1NFBPUVBMR0k4Um1PRzRDQ1I2WnM5dzI4cXZRUzVOMm1Gdldnb09BUjd4?=
 =?utf-8?B?TnI3M2lmYnptMFByLzV3R0cyNWVVVFJDalYvbDFOU2dDb3Z1SG1kR0Q5SnZV?=
 =?utf-8?B?aU5yZW9KQWxXajN1QWlacUNtUmtUdnZ1MUQxTXI1MGJOZ09tcWNpZ0FTOVF6?=
 =?utf-8?B?a0pWRkRUNUI0NVFRZHZCa0FXMExmdTZVbHU3Z203ak9EU0puK09pdGJFSFp6?=
 =?utf-8?B?OU4zTEg0bW5ieFl6YUxsT01NVjlEaW1tNE5ma2h2NENuOFFKME5PalJWeFA3?=
 =?utf-8?B?NDNNbDFYWEFnZEhIRlBEY2FycGs1WWh5TUFKNDI1c2h6Tytmb0p6WERyVkRX?=
 =?utf-8?B?bTA2ZkNweXdRRjR5YkRlR1QyZkd4RkVsZmhIYmErOE1va0xaWUs5bnRXNEdE?=
 =?utf-8?B?aVlPZStQckphYXEweDJEM2cwTzJRTFpzN1lpOVhpYlY4WVlPUzV2TWVVdENi?=
 =?utf-8?B?T0VYcTQ2dWIyUkpTMmp4VHQ3emgvODZMTXlQaFJvaW1ZMFhVdnpZT0tIM1Zt?=
 =?utf-8?B?VnQxMVJFcmtqeEdJNEJtWjhNSWNLS3VvaHB4bE8rNkEyTkNuMVJmOEgrWlVV?=
 =?utf-8?B?YStiWmxaVFFqcUpobkpFekxOVVh0NktydGNkeUNnc3ZEYit0WkpPWHhFY2hG?=
 =?utf-8?B?SWczUzNCSkY2UWFsWlZ4YUZEYlJWcHVJS0U0WUhNcmdCTitoSFZxT2xCS0dQ?=
 =?utf-8?B?eXovUTkxMDNwc082LzloUGFvdzFoY2FKamhlelhKNDVqTHViL2pUVWYwUTJl?=
 =?utf-8?B?Sk80cXRzY2h3Z0grU2xrdUtUblhtU2dUOW5sL2dNN2k5bmlMV3A5Q2xtMTNn?=
 =?utf-8?B?T0hreFhHbHRvNDUzQUZTaWdqNVJMUzNmMGJ2Kzg3WTAreW8yMEFydWR0ZDZV?=
 =?utf-8?B?eFdQOFNZVks1eVdOUFZHRjczK01BTUdRWGcwbE5BMTc3OWRFR1RaSlk2K05S?=
 =?utf-8?B?cTdEWlJ0MHNHWEVReUd6dWdCOGxBOTIyeWpiUWFrVWFuelpRalJ4NnJFQUJv?=
 =?utf-8?B?R0lxaWJlMGdmcWU2V1lRd212ZXNFZXJwZjFaUWFLYytNNy9FWnNvU1JMeTZF?=
 =?utf-8?B?RTg4bStDUkZDazZwSWVxSEprT1dUaXBqTTBTa0NwL3dKd0d1R2ZDRk9nd1Rh?=
 =?utf-8?B?SkRxdVFCQ0tYZkEwdEZjV3h6Zk1NNXVOWmNoSEhXWlFXaGUrOVppVjRUQmVJ?=
 =?utf-8?B?Y1hVbGpBOWFXN2NvNVY2ZEs3RHJEYzBqUzA4bGRKMTBHcU4yZGI2c2dZOTBw?=
 =?utf-8?B?anRtVFYyanEyMXpvdE5wMU94RjdpTXdDMEk1aEZMMkkwb3ZEbDI4WWF4QUNW?=
 =?utf-8?B?T2I5NFkrdHhIMEpQMlN4cEpTYlpkNlA4VkJMaXE3YUdoQzVCdko2Zzl4eC9P?=
 =?utf-8?B?NUNNcGtENmUwWWoramkreXAwUFB0LytRUDBjZnU5VVkrT2EyRzlGTDdjczJ2?=
 =?utf-8?B?Tkh5Vnh5clJodzJLNnlaUml0NjBPazZ6WkNCMzNYZXdVMkNncVdJRXQxYkZS?=
 =?utf-8?B?dzZMazc3VjBFckpIRGdxR01wQUhrR0dpaElhVEVnVjhKb0RuV1V5dklKdHZo?=
 =?utf-8?B?eS9uRG9QTTU2UXNFMFU3NkEzd2hreWR0cXZVUUQ2T1VYZUJ5MGFsR0FKSHBR?=
 =?utf-8?B?RDhZTElPM005VzYxOGliRjRnM2Z0dWpsN3BLQThuODFld1p3S1NNZk1ndHJC?=
 =?utf-8?B?a25KWVVwMSsrM1R3OStPY0Uxa0NwV3J3KzY2N2NIb2NpMHNWVE1qMlF0cVY4?=
 =?utf-8?B?RmZGZHZVSFAyZUVtUExFOFBwK1FENWpKRHlhNUxBWmVVMTFoQ0kvQVBWY0xP?=
 =?utf-8?B?Y3ZYcjJTVEkvK1J5UnBKUkdjcjJrMTlJTTB2MlExQmdDSkZDSmo3a3JtSkNn?=
 =?utf-8?B?TlZqZ2hTUm1NQU1CSmtaNjNmdkFsbDMwVVZRZ2R3d0J0R05ZMkhVclNGTS8v?=
 =?utf-8?B?d1hTRitrM0pmQm1SalRHcXYyMzFUbTdPeGZtQ2VScGNhc25EcHEwMk5PcFFW?=
 =?utf-8?Q?0tzt9k+K45Q1I+IpXciWVc8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fc51a0-887a-4e95-b5d4-08d9b8f8146b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 20:36:28.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hThbgwWZjH6KSvtydq/OGJsV/O/BlGk/F6tUoOQ+PGw05/QRc7lk+gjQVOm1uq0AkQTKXVmFVYUhsHWCudlRNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3415
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060126
X-Proofpoint-GUID: SvopE1KMIugFEhayBejfd6vvIxx2YV7n
X-Proofpoint-ORIG-GUID: SvopE1KMIugFEhayBejfd6vvIxx2YV7n
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/6/21 12:05 PM, bfields@fieldses.org wrote:
> On Mon, Dec 06, 2021 at 07:52:29PM +0000, Trond Myklebust wrote:
>> On Mon, 2021-12-06 at 18:39 +0000, Chuck Lever III wrote:
>>>
>>>> On Dec 6, 2021, at 12:59 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>> Add new callback, lm_expire_lock, to lock_manager_operations to
>>>> allow
>>>> the lock manager to take appropriate action to resolve the lock
>>>> conflict
>>>> if possible. The callback takes 2 arguments, file_lock of the
>>>> blocker
>>>> and a testonly flag:
>>>>
>>>> testonly = 1  check and return true if lock conflict can be
>>>> resolved
>>>>               else return false.
>>>> testonly = 0  resolve the conflict if possible, return true if
>>>> conflict
>>>>               was resolved esle return false.
>>>>
>>>> Lock manager, such as NFSv4 courteous server, uses this callback to
>>>> resolve conflict by destroying lock owner, or the NFSv4 courtesy
>>>> client
>>>> (client that has expired but allowed to maintains its states) that
>>>> owns
>>>> the lock.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> Al, Jeff, as co-maintainers of record for fs/locks.c, can you give
>>> an Ack or Reviewed-by? I'd like to take this patch through the nfsd
>>> tree for v5.17. Thanks for your time!
>>>
>>>
>>>> ---
>>>> fs/locks.c         | 28 +++++++++++++++++++++++++---
>>>> include/linux/fs.h |  1 +
>>>> 2 files changed, 26 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index 3d6fb4ae847b..0fef0a6322c7 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -954,6 +954,7 @@ posix_test_lock(struct file *filp, struct
>>>> file_lock *fl)
>>>>          struct file_lock *cfl;
>>>>          struct file_lock_context *ctx;
>>>>          struct inode *inode = locks_inode(filp);
>>>> +       bool ret;
>>>>
>>>>          ctx = smp_load_acquire(&inode->i_flctx);
>>>>          if (!ctx || list_empty_careful(&ctx->flc_posix)) {
>>>> @@ -962,11 +963,20 @@ posix_test_lock(struct file *filp, struct
>>>> file_lock *fl)
>>>>          }
>>>>
>>>>          spin_lock(&ctx->flc_lock);
>>>> +retry:
>>>>          list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
>>>> -               if (posix_locks_conflict(fl, cfl)) {
>>>> -                       locks_copy_conflock(fl, cfl);
>>>> -                       goto out;
>>>> +               if (!posix_locks_conflict(fl, cfl))
>>>> +                       continue;
>>>> +               if (cfl->fl_lmops && cfl->fl_lmops->lm_expire_lock
>>>> &&
>>>> +                               cfl->fl_lmops->lm_expire_lock(cfl,
>>>> 1)) {
>>>> +                       spin_unlock(&ctx->flc_lock);
>>>> +                       ret = cfl->fl_lmops->lm_expire_lock(cfl,
>>>> 0);
>>>> +                       spin_lock(&ctx->flc_lock);
>>>> +                       if (ret)
>>>> +                               goto retry;
>>>>                  }
>>>> +               locks_copy_conflock(fl, cfl);
>> How do you know 'cfl' still points to a valid object after you've
>> dropped the spin lock that was protecting the list?
> Ugh, good point, I should have noticed that when I suggested this
> approach....
>
> Maybe the first call could instead return return some reference-counted
> object that a second call could wait on.
>
> Better, maybe it could add itself to a list of such things and then we
> could do this in one pass.

I think we adjust this logic a little bit to cover race condition:

The 1st call to lm_expire_lock returns the client needs to be expired.

Before we make the 2nd call, we save the 'lm_expire_lock' into a local
variable then drop the spinlock, and use the local variable to make the
2nd call so that we do not reference 'cfl'. The argument of the second
is the opaque return value from the 1st call.

nfsd4_fl_expire_lock also needs some adjustment to support the above.

-Dai

>
> --b.
>
>>>> +               goto out;
>>>>          }
>>>>          fl->fl_type = F_UNLCK;
>>>> out:
>>>> @@ -1140,6 +1150,7 @@ static int posix_lock_inode(struct inode
>>>> *inode, struct file_lock *request,
>>>>          int error;
>>>>          bool added = false;
>>>>          LIST_HEAD(dispose);
>>>> +       bool ret;
>>>>
>>>>          ctx = locks_get_lock_context(inode, request->fl_type);
>>>>          if (!ctx)
>>>> @@ -1166,9 +1177,20 @@ static int posix_lock_inode(struct inode
>>>> *inode, struct file_lock *request,
>>>>           * blocker's list of waiters and the global blocked_hash.
>>>>           */
>>>>          if (request->fl_type != F_UNLCK) {
>>>> +retry:
>>>>                  list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>>>                          if (!posix_locks_conflict(request, fl))
>>>>                                  continue;
>>>> +                       if (fl->fl_lmops && fl->fl_lmops-
>>>>> lm_expire_lock &&
>>>> +                                       fl->fl_lmops-
>>>>> lm_expire_lock(fl, 1)) {
>>>> +                               spin_unlock(&ctx->flc_lock);
>>>> +                               percpu_up_read(&file_rwsem);
>>>> +                               ret = fl->fl_lmops-
>>>>> lm_expire_lock(fl, 0);
>>>> +                               percpu_down_read(&file_rwsem);
>>>> +                               spin_lock(&ctx->flc_lock);
>>>> +                               if (ret)
>>>> +                                       goto retry;
>>>> +                       }
>> ditto.
>>
>>>>                          if (conflock)
>>>>                                  locks_copy_conflock(conflock, fl);
>>>>                          error = -EAGAIN;
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index e7a633353fd2..1a76b6451398 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -1071,6 +1071,7 @@ struct lock_manager_operations {
>>>>          int (*lm_change)(struct file_lock *, int, struct list_head
>>>> *);
>>>>          void (*lm_setup)(struct file_lock *, void **);
>>>>          bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>> +       bool (*lm_expire_lock)(struct file_lock *fl, bool
>>>> testonly);
>>>> };
>>>>
>>>> struct lock_manager {
>>>> -- 
>>>> 2.9.5
>>>>
>>> --
>>> Chuck Lever
>>>
>>>
>>>
>> -- 
>> Trond Myklebust
>> Linux NFS client maintainer, Hammerspace
>> trond.myklebust@hammerspace.com
>>
>>
