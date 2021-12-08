Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20F46D816
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhLHQ3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 11:29:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1392 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232478AbhLHQ3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:29:08 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8F9ZP1025793;
        Wed, 8 Dec 2021 16:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YIat5tdZ0BUlGUKFhXfLPvlt1wh6v+s5zdCoi+AAZdU=;
 b=n84weuquFMhnAPm12iwWSEURA3cye23E1vVBfS9GY3R2ASl/7IMSB6vPkW2ICxrx4jl8
 naNKgfKdNL1MIzuVm6+ZMqZ1r6RLGav84h3IEWA/mcRTvF/jrnHNV+aIxuzsSdrKOlyJ
 JL0iOgXXeX9n5PstZuJ9vJ+CmhBmufZREfEeFMvVjUqPBBnflta7zcLUqrkCVQ7d5UYA
 OYOcIf+5znvdhBah1Px1c/deFPtabIgavfpt3UPBKH8cUVyC+tNjniwppxCxX9sOjnJB
 qIBti90EA8Sg5a38PtzPjJRiIhH3dSkGe4yJ6/s9z1bwZcA3SgPhUG2q7Z8NmADsraCL qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctt9mrx8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 16:25:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8GLOqe124570;
        Wed, 8 Dec 2021 16:25:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3030.oracle.com with ESMTP id 3csc4uxk8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 16:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvufQEkPmsCCgdcHY+XZZwPq0RLZHhnreC3dQeZ7jNat2l4Y7KOwksC7UTKMw/AEyqRhMcA0I3ryGxtE/JxiYpalBPwnAqf3kz1aQZlI/OzAeXsUU8ozv7fPwjAgUmw9+MIG94ImC0So75aXOk3Bw0JCwR54dFdL6YF6aI77u3Ko8HtOb5t4bpk7CWI+JRMpcIQKpgH5SgxIXFv3MZtdazc+bxgdLtViTK5zB8FqKBxLFKG3tVrK3akjCaLp0tWCRkQzlFc6eZJeWP7KHQTN7XCaoUpoX0+UfXQbf4buC3O1SIVCz9v1I2tBwDftRX26iOUsqC9hEXUify8I4U9y/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIat5tdZ0BUlGUKFhXfLPvlt1wh6v+s5zdCoi+AAZdU=;
 b=NE4UQFS3SnyElgCDt7WECTT0pFykHuMi7p8hWGOfXW4oB3UhzSmLKf8Dfpx31OzGVTQ5d7S+twxNfWHBdASc2VBVPHoAUFwl5K02pLfw1qnAXFR5/tu0JYmsboaWfN1xQVv9f2LDEfptm9x1unQuXxK5ykQtsdimx5SOJXppOyVDsstFCPaSGKeIZfI7ojvixR0xLdwhaZFjqVkx6mvmNjLCpJvltjIBpeYOzOxwO0ikefjfZpPIRZHSixujsKXJK26zMV4WXGAYDLgqzgs186PbYfpVfA4lF5XznJOUdk1FIf4ifZgGXHBcfjJn55yweptcWbysZTlGocQt0pa4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIat5tdZ0BUlGUKFhXfLPvlt1wh6v+s5zdCoi+AAZdU=;
 b=tbpefduhcX1FDr6baF4VId+LkQ8is9n+p0aVr6GXLfhyTau/5gZHAo4u5IdmlIk+jQvI0dAhECmDrw04c/xDrvUd/fjg46xMAG3ZYIgjLeyFjEFPnSY+Bl+PgyroWCCeY59VYoqgans0B+ZbR+yCzVRrcgDMhQaAnb9eB+/cxt4=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2712.namprd10.prod.outlook.com (2603:10b6:a02:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 16:25:30 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf%3]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 16:25:30 +0000
Message-ID: <605c2aef-3140-6e1a-4953-fd318dbcc277@oracle.com>
Date:   Wed, 8 Dec 2021 08:25:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <f6d65309-6679-602a-19b8-414ce29c691a@oracle.com>
 <ba637e0c64b6a2b53c8b5bf197ce02d239cdc0d2.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <ba637e0c64b6a2b53c8b5bf197ce02d239cdc0d2.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.159.149.37] (138.3.200.37) by SJ0PR13CA0078.namprd13.prod.outlook.com (2603:10b6:a03:2c4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 16:25:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05c1cabc-ff00-4af8-5603-08d9ba6759a1
X-MS-TrafficTypeDiagnostic: BYAPR10MB2712:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB27128458A74FBDA60395C33D876F9@BYAPR10MB2712.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sELo/b43c0Nm1NV2tCLGCbhRMxTEcCYK6R3KedCojG7SE335H+vzxFsK8HPNWoUfKVnEqPZ2VwVjVX3A324uLMRB5PK3SoSUaRN43xeUnnRTU4Q+S+X2Yhu/8Did2QQ9vXX+f74lmqJBYyeppvHD53gMAZmkE0KXhL/Sw45vmdlQYobzW3hB4Im4IGdUmNqJVpa++FkXbUstTrHgwf5iFpG20wHFA6LXeVghUTYewf48CDOdgyXmhXqnLEcDa78+CUK5FvkUWJooIRC5gKdGcvq3I/QwSFoQiJIUF4iCkhWsF9Nn6gQ9BEiDXaSzmfeeATvPLjuWeMRkTRrml9jaDTuCD+KYfo9z69NrYdNBRlmpyQIp6xc9P0C9zgLzjtx5j3458SXt/u8DEx0wdnIk+7+q/nE81xEWZ3+U2tvCQOcK10rG1OzOMabBhKE1GyhT3UU+NQ+s5oxaPaagJjHMZYZtlJkx66ioG+HvL27CECemprNtS/wH6ydS1kCc8Kg+t6ADNwNISe9RrR1c7Afyed+pbO//WidGDyZAg767Hxh/F9FiX4t/UjZ9+t0Ct9o9VSPzYWk69Kd8TGiYMWU864+ixjza/FXsLMTAoiLf8qwtlpAx4W0vcEIem+4VbEw1kGuUXlKzcQi9hE7kKDmNggyZ7biRFotUmFfXKwm/vezkZSh2dGBjsaPEATba3pvXv445AN2AVK/2mjltMMlTBq/gvtP4ZmkfxR2NDzgGD9n4f0ROZcHcsOZRHQrv64QPI5uzP+/57+x7Yu+9tCR0pxjkD1UmG5E3Vza9KWsuop0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(8936002)(956004)(9686003)(5660300002)(31686004)(110136005)(54906003)(83380400001)(4326008)(53546011)(38100700002)(2906002)(66476007)(508600001)(16576012)(26005)(6486002)(316002)(966005)(31696002)(86362001)(66946007)(66556008)(36756003)(19627235002)(8676002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU1hcFRJck1xVi9JZ25FckR5c1FQYnNRalpsMFVqZmUvZFcrNjlBY0d1b0Ra?=
 =?utf-8?B?NjlvVHgyS2pTMmdqUytNWU00NnVmWG1FRjFNemdoTGtpVE41SzhNZVJlTEN3?=
 =?utf-8?B?MDV4aTJvODRLdFhNdGVFSkcyR3VQdU5vT3RUSW1GY21TOG5XeWhCanVKMVJ3?=
 =?utf-8?B?VjVjaGF0c015dEhWOTVWY05ma2Mra3JNd3NNSzY4eTg3L0Nsb3lhM1ZNaUZq?=
 =?utf-8?B?bnRoWVpWdHRuYU10ZzNNYkl3MHowczZ1Z2tRT0pETDF6anRlNmJmdTdaT3Ay?=
 =?utf-8?B?bzR3SWwrTUhOTkVmMytsYlcrRG1tbkliY2lvVEZiRktmMmVPYXVzdXpKZ0xn?=
 =?utf-8?B?RCtKcUlxM0lQVnZ4VUtrK0UvQ29BWUM0ZExNNW1OZnVzbkI5OEVMV3BlNkZP?=
 =?utf-8?B?cWI5U2NHdVErK2NTREY4TDQ1c29IN1F5amNMUnZTYXExNzFNcXNtcEZpemxn?=
 =?utf-8?B?UVViZWhNaldVR0FqN2l0TTJOTTdydk1Gd2FZNFJCNEpwSkJxNHdRclJqdHVk?=
 =?utf-8?B?MWNLTUlvbXNaTVdwR0xWcWtQRmYxUHdkK1o4dGNwZ0xxdEY3UFUwSGNhQkl0?=
 =?utf-8?B?cG45SDJENkV4WG5PNXhQQjltWnBoaFNjT1VUZWJSQTYxTE5WaXMyTXd1cW40?=
 =?utf-8?B?ekZTdGkxQTJpQkRpcE5jc0RLcFZBQXJMUkh6ZnZGdGJUQWhMOWMyVXEwNGFR?=
 =?utf-8?B?dFpxNlU2eWxZdXZvNkNITmd3REhrZzhweEpVSk52NnkxU0xhTkNxa3o3WUdU?=
 =?utf-8?B?aExueGJkNVBqWlNNa3dPaDN6d3h6VkpJSUdGaUFsUGFkMXE5YVF4UlRqRTFx?=
 =?utf-8?B?VzlOSm8rUWpKUWM0VkJXWDBQWDdDSEwyTmVzOW5HWThCQ2k5MVZMR3N6R2Zu?=
 =?utf-8?B?cUZsSWREYUpEbVRLdWdOWENDa3ZQUFpReG52R2x2T0tLaTNmNUZMd3NSODVk?=
 =?utf-8?B?bDloL0h6b2IwSDRwWGlOZUw0VHBTRHBSNGc3YkpLNzlVejJQL2RsdlZBV3Ru?=
 =?utf-8?B?ZHZjMHp1L01zNktLQ0R3dkZuc0R0WGJDamg1UkdRb3NFMjNyb1ZlSWttb0xn?=
 =?utf-8?B?c1p5US9vQXJhZlpIQitmc05KcWQ2S1NCNkZ6d3hjRlFxK3FWbjlyWDAzNk9S?=
 =?utf-8?B?c3VBS29GdjVZRWx1SG5hK0lJWWRaRzJRNG5HajluMFFObGh3aUdoU0E0SU15?=
 =?utf-8?B?VzdUQ3lpeXpIYW85MkN5dGJraElrTS80TGZNUFV4VDJhTGhmeER5cExia0ky?=
 =?utf-8?B?Z1dNYTdKVUFnVzE2anJnN3FsaTZId0s0aC9ZOGFZNXUyRWladEZMWGtsK3d0?=
 =?utf-8?B?YTFiMmFrNkk5UzZvYmk0QVRNNlp5OFhZcEJySTdsZ0RlRnhUc1FzdDNEMmNj?=
 =?utf-8?B?MHhYNUFXdFhLRkdHbnBudlI1RytXNFk5UHh5cEpZMTQ0MFVjWkJaMjZWdDBX?=
 =?utf-8?B?emZuOUtUbGt0VTBhRG5OT0hzczZFekIyZGxHNkxLSzkvd1FvdjV0cHEzNThY?=
 =?utf-8?B?dE5sZ1k5TXB0UmNoSE91YTJDdjV0VUNUK1BQSWpZQUZKWWkySWtNUzV2dGdU?=
 =?utf-8?B?WDJTSC9zMWhYSFMvelB6T1d4RlduRTlqSkRtNGtxbm1MTDVJcDJzTHB5WjZB?=
 =?utf-8?B?c1lyZW9jMy9lUlJkeGl5SHA2aEdUUDlpcTFDMm1ZZWFQclhQclJGaUliNFFC?=
 =?utf-8?B?WlpLWTJ1eWRXTmx5cHZVRVBmdFVoR09PWUxwU3k4THYwZ3FabGhKSTRLclVr?=
 =?utf-8?B?YlFJa09lT0djOEwyT0tTMFB2bmxZenpCcGY1RVRGQ0ZKRGRaNThNM3gxOEwr?=
 =?utf-8?B?a2pzbFZpYVpBNVA5QkJNdTZMNnhROGtrNWxLZFMyck5idFZ0T2tVRER2TUs5?=
 =?utf-8?B?VlpHL3huWXhkcFhwSWUxbWdPcHdINi9kaUlLZnZZTzc4aitjTlNTaWt5OStD?=
 =?utf-8?B?SXdGMy90Ukd2eEU4cE11dzgwSkdxZGJlb2pVNmpaU21rbjVlWmhsQmZtVGNh?=
 =?utf-8?B?VVpROFhsUUJNZk1SU3N4WUNoMm54MnBvT2xnWjBBbGhaRGgxMDVIZnc4dS94?=
 =?utf-8?B?ZExHMHFRZ2hva3NJSk0zc3VrdkVWdzZsRWpFTDlFZE5iQTA4NGZHU2llZFhD?=
 =?utf-8?B?TXZXWXg2M3UwdFZuTENXb0VGTEk3M25YVFkvaDd1TVk4a1ZXQmlWZktydVR6?=
 =?utf-8?Q?xIRY0Qph0GQ5IYhng1V1b1c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c1cabc-ff00-4af8-5603-08d9ba6759a1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:25:29.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+5m5LvXdwz/EDmwByVmmjqyCtvogJ9z3nGW2Xj3b8cBHD2uWxnMK+Fi4EddVLXTCWnlmimWgPfvP3OPdwfU1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2712
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080097
X-Proofpoint-GUID: hRxsKc8NSV4VExFV5m0IxYaHrKWxJ3WE
X-Proofpoint-ORIG-GUID: hRxsKc8NSV4VExFV5m0IxYaHrKWxJ3WE
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/8/21 8:16 AM, Trond Myklebust wrote:
> On Wed, 2021-12-08 at 07:54 -0800, dai.ngo@oracle.com wrote:
>> On 12/6/21 11:55 AM, Chuck Lever III wrote:
>>
>>>> +
>>>> +/*
>>>> + * Function to check if the nfserr_share_denied error for 'fp'
>>>> resulted
>>>> + * from conflict with courtesy clients then release their state to
>>>> resolve
>>>> + * the conflict.
>>>> + *
>>>> + * Function returns:
>>>> + *      0 -  no conflict with courtesy clients
>>>> + *     >0 -  conflict with courtesy clients resolved, try
>>>> access/deny check again
>>>> + *     -1 -  conflict with courtesy clients being resolved in
>>>> background
>>>> + *            return nfserr_jukebox to NFS client
>>>> + */
>>>> +static int
>>>> +nfs4_destroy_clnts_with_sresv_conflict(struct svc_rqst *rqstp,
>>>> +                       struct nfs4_file *fp, struct
>>>> nfs4_ol_stateid *stp,
>>>> +                       u32 access, bool share_access)
>>>> +{
>>>> +       int cnt = 0;
>>>> +       int async_cnt = 0;
>>>> +       bool no_retry = false;
>>>> +       struct nfs4_client *cl;
>>>> +       struct list_head *pos, *next, reaplist;
>>>> +       struct nfsd_net *nn = net_generic(SVC_NET(rqstp),
>>>> nfsd_net_id);
>>>> +
>>>> +       INIT_LIST_HEAD(&reaplist);
>>>> +       spin_lock(&nn->client_lock);
>>>> +       list_for_each_safe(pos, next, &nn->client_lru) {
>>>> +               cl = list_entry(pos, struct nfs4_client, cl_lru);
>>>> +               /*
>>>> +                * check all nfs4_ol_stateid of this client
>>>> +                * for conflicts with 'access'mode.
>>>> +                */
>>>> +               if (nfs4_check_deny_bmap(cl, fp, stp, access,
>>>> share_access)) {
>>>> +                       if (!test_bit(NFSD4_COURTESY_CLIENT, &cl-
>>>>> cl_flags)) {
>>>> +                               /* conflict with non-courtesy
>>>> client */
>>>> +                               no_retry = true;
>>>> +                               cnt = 0;
>>>> +                               goto out;
>>>> +                       }
>>>> +                       /*
>>>> +                        * if too many to resolve synchronously
>>>> +                        * then do the rest in background
>>>> +                        */
>>>> +                       if (cnt > 100) {
>>>> +                               set_bit(NFSD4_DESTROY_COURTESY_CLIE
>>>> NT, &cl->cl_flags);
>>>> +                               async_cnt++;
>>>> +                               continue;
>>>> +                       }
>>>> +                       if (mark_client_expired_locked(cl))
>>>> +                               continue;
>>>> +                       cnt++;
>>>> +                       list_add(&cl->cl_lru, &reaplist);
>>>> +               }
>>>> +       }
>>> Bruce suggested simply returning NFS4ERR_DELAY for all cases.
>>> That would simplify this quite a bit for what is a rare edge
>>> case.
>> If we always do this asynchronously by returning NFS4ERR_DELAY
>> for all cases then the following pynfs tests need to be modified
>> to handle the error:
>>
>> RENEW3   st_renew.testExpired                                     :
>> FAILURE
>> LKU10    st_locku.testTimedoutUnlock                              :
>> FAILURE
>> CLOSE9   st_close.testTimedoutClose2                              :
>> FAILURE
>>
>> and any new tests that opens file have to be prepared to handle
>> NFS4ERR_DELAY due to the lack of destroy_clientid in 4.0.
>>
>> Do we still want to take this approach?
> NFS4ERR_DELAY is a valid error for both CLOSE and LOCKU (see RFC7530
> section 13.2 https://urldefense.com/v3/__https://datatracker.ietf.org/doc/html/rfc7530*section-13.2__;Iw!!ACWV5N9M2RV99hQ!f8vZHAJophxXdSSJvnxDCSBSRpWFxEOZBo2ZLvjPzXLVrvMYR8RKcc0_Jvjhng$
> ) so if pynfs complains, then it needs fixing regardless.
>
> RENEW, on the other hand, cannot return NFS4ERR_DELAY, but why would it
> need to? Either the lease is still valid, or else someone is already
> trying to tear it down due to an expiration event. I don't see why
> courtesy locks need to add any further complexity to that test.

RENEW fails in the 2nd open:

     c.create_confirm(t.word(), access=OPEN4_SHARE_ACCESS_BOTH,
                      deny=OPEN4_SHARE_DENY_BOTH)     <<======   DENY_BOTH
     sleeptime = c.getLeaseTime() * 2
     env.sleep(sleeptime)
     c2 = env.c2
     c2.init_connection()
     c2.open_confirm(t.word(), access=OPEN4_SHARE_ACCESS_READ,    <<=== needs to handle NFS4ERR_DELAY
                     deny=OPEN4_SHARE_DENY_NONE)

CLOSE and LOCKU also fail in the OPEN, similar to the RENEW test.
Any new pynfs 4.0 test that does open might get NFS4ERR_DELAY.

-Dai

