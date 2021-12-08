Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D0046D9A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 18:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhLHRdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 12:33:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54346 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237837AbhLHRdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:33:13 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8F9Z4d007074;
        Wed, 8 Dec 2021 17:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oP+EsBR6OsF8wdBEylvbU/S2zoBPz/KWzV3/oVPbqZ4=;
 b=vLspicJLXGYwJ/NhqbTYyvckzPulhibAI0LSr0XB84aW1IXRPv4iFVan7ER/W3pDhCaD
 PGP9CQxDHH4VRKulmbtJ8Cs3meonqk66DH945G59+MG2eopBXXwjp46VnVJobG6Ol23F
 m5EQnJbt7ybXR/3V3Dv2NTZdmsAw/W6HFj4s8cbb5O2XT17kEWA5MqjaXq8t0wc3qiLu
 klStjCwJZFjTKQYA2X8DK+djAPTJ8QRTrPMAjNDsxY1X9+8vSnsqlF7rWZrgMxDXLr2g
 jKHYc6ASBHu+c7fGuBdliLQzipvU4p8z5BrtLE74RyZSiuViMLbcBB1rshBoWSR4VPJE Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctse1h96g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 17:29:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8H5eel091066;
        Wed, 8 Dec 2021 17:29:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3csc4v17rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 17:29:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owah6qfHeesUvkpxFWOmnES1li+yz+Ud4Gitg22i+xwntLrCBj1+hHPnhPbkFjZvGVWUjEQpHB7Z+kxVYYgRyChGro5QA2HEoS4SoPW8af/WzdmXYak3q5LA0we3G9ki6yvq/oIS1UDD+tl4qyodZAHvoxEzuW73sgfztj7A0Dy1zuj5uCP/OAGdqsX9VxHQBJ0BV9foWal78npFitJYvrJPrUCz+568uer3Owyex6WSXXSG45jSvtWCv3ix4Pi6wey7wVmKjGE1VjzV32k9XWApnznIBq0gHq2/zBvryY0uU1KFN3ZTE+0NmRRFBmL6zKy5NqIQuV232AM2mwOvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oP+EsBR6OsF8wdBEylvbU/S2zoBPz/KWzV3/oVPbqZ4=;
 b=WjBFhYX9qqKxoLFE9zgGAw+aYjbvl8xYWbDNnXgnxxHSIFGkzb1drDhIOXDc5lrk2Uz7DJYNCd7uVr2iB3k0NHK1td2JEugLKFM475LiYa6lTAYcLerf7xDOcxh7ClQtZPVMA2NuSbyIhIN0gxv+zI31BGRc1dspNceUnP00avcH9xoSz+VT3J8NAyV8DsFfANkvEdon+pDsbPvBCoNMUodN33R4LbkJ6dQaiLqoavQYSv7gp1nas68L+72P0HeqfaNXNZvyhH22ei2PObSiAFe68Fd6AyLOm2NHqDBIjEry2UbGvR9ehrZzPtwz1/TTabXAj9EMMAZo0Y083cccWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP+EsBR6OsF8wdBEylvbU/S2zoBPz/KWzV3/oVPbqZ4=;
 b=vUxNtZ1Pt3VpcXkaC15m75rafauVcQ5sM4Sf5gDfjOCKiBQiM3fRC0sfRTlc+4ZveJpAPVCJJEKXw9Gd5MjepLuoBucFHZibyfgR7Borsk/wQIlt+6zTFyohcqUvAfe8HqDfCAMbQrVv+aB5rgUZjj1jRRTVvZXSUza2z8W/OWM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4653.namprd10.prod.outlook.com (2603:10b6:a03:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 17:29:34 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf%3]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 17:29:34 +0000
Message-ID: <cdf6317b-aa42-539a-bc7f-3150e83cbc60@oracle.com>
Date:   Wed, 8 Dec 2021 09:29:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <f6d65309-6679-602a-19b8-414ce29c691a@oracle.com>
 <ba637e0c64b6a2b53c8b5bf197ce02d239cdc0d2.camel@hammerspace.com>
 <605c2aef-3140-6e1a-4953-fd318dbcc277@oracle.com>
 <20211208163937.GA29555@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211208163937.GA29555@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.159.149.37] (138.3.200.37) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 17:29:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52276e66-2a5b-441e-ce77-08d9ba704d01
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4653:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4653FF761F3CEC24FD340B61876F9@SJ0PR10MB4653.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYEWzh44bffJ3ik1AYpOoyNVClAriu0YW0aN5hIVdp/bw9y4gqV898NvDkf+rnjpde8lVF8NALtJu7biJ2NidSn83kOoX0dpGz1mHFYAGhBT+J343PYTfC+id2NROUGWE3f7F1NvvjBfqNrGyzOsCqRywfI138cyHDRS5J+mDUG7VSarI7wpRPMoOB2mh6YXxV83Bt4Iy4T6u49tQZot+/Jf7dMqygLLTYufzB8dHc0eTGU8gFVpsXpLcl22q4f76xG3Qu1GJB9KxsdvrCPl6BiUcNOnqJqbmIVbbdBmf/w4nMP/d3qbbSGYuqBSqgLK8JejcZU7t3CxSmRnAluVZTUgRVZ/X8/b3wrxsbA/8l9yIrGrh6voBTZQPgYtAwIOuL6SbKWwJrA66+FYNfh2Uuepx4tRv+kFO/xDCS8YFb64UKkxGIpkKK2RLW/fSJPgRs3y9RvkTfDSv09bE0BENzwHnoaaqien1pA76coir0TUWqYx7Td3aRdal2gUeeicTv+ZKWxcEhyTLl4R44Uu+3LIZ0s2E3blFT8oozl1Bbk3tVDEccH7ngjG5fdUoQ8u2QYM8UWONE9PN2Z7naCE1iiu4q78Zd0q/UiviR+3oiWL0m1rakrtorHLCib28wJKrs0YbErea2ik1O7QRUgo4XciSoA1SFF66lAzJH1iYAjkFWH0vIJYw0OlEAi/YaqQMzlxmLtoZs6dv2j8yq0Ul6TpGEXYNENHv7/19PTCqYJlkyvVj2/Slnm/7US45lnuEWVxBjoNo0WX5k6sOJzruPn3TEJActt5v1JuX3/alM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(16576012)(316002)(38100700002)(5660300002)(54906003)(6486002)(6916009)(36756003)(26005)(2906002)(8676002)(19627235002)(53546011)(31696002)(4326008)(8936002)(186003)(2616005)(66946007)(9686003)(956004)(66556008)(66476007)(86362001)(508600001)(966005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2V6eWVCQ0ZsU0RqZS8zbm5jcUdwRGNzL2w5Y2J5V0xMc0tiVWFRTXUrVUpF?=
 =?utf-8?B?Y00vQUJEVHVjd2lKdHc2Y0llNTlwODE2YUxaUnFKQ0hySE5IcGlGb3l5OUJu?=
 =?utf-8?B?bUZGWVJ0Nk9ieGQ0dENnb0tLSG1Zc2NzbmVOQkN1T1QyRUhDVGhlejdBQ2RG?=
 =?utf-8?B?NWFvYmc3Zi9Bd1c3dks2cWFUWVVLUCtTNlVaZTd0RkZkbldKcVJqYmhFUWdu?=
 =?utf-8?B?SExSSTlZcW5JY0F6elhJVGtPZnk5YzA4cFJiTjRyNFl1Nlo4U0JjbXl1T3NM?=
 =?utf-8?B?M291V055ZUY2aGVZUVpJcFB6SGR1L1FGMnFic1ZrNTdHTm0yRkFKbjFBUk9Q?=
 =?utf-8?B?ckt3VkZkcERTVW5XQVBSWmVGQ0tlWVFRYVo3aU5iV0kwL3dqWHVhSEJTNVBW?=
 =?utf-8?B?MDhBdDNMck1PTWROaG53SFdmYjlQbWlpSmg0L2dPTnBScXZDeTg0RGo4VEFM?=
 =?utf-8?B?cGJpakJlem1ya1cxWjBLeXhld0lxSWlNeGIwVTFFVlhGS1c5WnNLSU8xeVh0?=
 =?utf-8?B?VW1lUEpzNUI0djltVmluVWFlRUd0Qk1wbysxUEtVVjhRR20yZUY3dngyWDhu?=
 =?utf-8?B?aUVjSGVkL2tuVWlZaEhHZStNd29lNjlzNEduT3N3M0F2NG0yL0R3RmtKRTJF?=
 =?utf-8?B?aldTVTlnMFo1SFkzbFJFeEhxYlY1VGx5Qy9ZdksrZndOaXJ0aEJLNWFnTDdJ?=
 =?utf-8?B?dWVMam4wcWZoUmxOcVZ0L1duUVcwYTF3dy9pdU5qY3lTY2M0SWczbVp1ZHBJ?=
 =?utf-8?B?YzRiZkcyaXIxd3lKZi9obDVlbVp2M3RFbVM3dHJSMUppTFBRMkJlU0FEWHRo?=
 =?utf-8?B?NWsrZHNva2RabzB0UW5DTjgweS9Yb0ROSkthQU1taUY0WGJmTDJDQ1Z6QSsx?=
 =?utf-8?B?Yzcwd1ljaGFwdHUxUEJYYmxOZG9BY1ZFUzBFQUhDcEV5NnBGN0ljZnNLemIx?=
 =?utf-8?B?S1VBVnQ1VFRUVVVxdXd1ZFNFNlg3dllzbWFiNXlJK3BvK29BeEx1b3NCRUJG?=
 =?utf-8?B?d0hsVi9acFo3RXVXRkw2OW1SQ1VEV3FIK3RHdGdOdEQ3U05LMUZWbVhFODJm?=
 =?utf-8?B?SUZYUlR2T2oxK1RuKzRJV3R5R0FnWXFHR1V6bkF2N1lxSzlCSk9Ua1B2Y3VT?=
 =?utf-8?B?Nnd0RmVuSXBlaVZ0OHBpdXNTZ2RwOUNLdmFJeXc5TndIZUVMc2lPVlRNc09v?=
 =?utf-8?B?L3ZaTnpKNXVVSmJtM3RrM3dHNnJwZVZCL3V3TU5XL3pRR0ZDYVROQ3R3QWtz?=
 =?utf-8?B?MEJpdUVkVjdOZ3V4bmJNSnVKU2w3Uk9hWWtJTlFHbHN5cGJhd2NPYWlBWTBB?=
 =?utf-8?B?dEszZ1VMRk9DRVhXSUY2M3V0eDJkd3d6RXNmVzhNSE1CZWZrZW5CM0YwWlor?=
 =?utf-8?B?dFhwaGZOYkhabDNoTjB5cWgxeFdlUi9BRDUzS3daZ0xiaXpnN3Q5NjV5djRj?=
 =?utf-8?B?a05jYzU1YXFGWlg5Tm1aYmRKZG1wUGw5R3VtVkZJdXhxeDN5M0JBazQ1MzBK?=
 =?utf-8?B?ZVYrRlU4MlB2MmpDRXRNVEl0aW9FOGtiRUNsQnB0UkVKY2xuVy9KOUtVQ1dy?=
 =?utf-8?B?ZDliNnRiajRkOTg4SEVyTGFzam0zUmNNK1h0Mi93Z1lEcEJ5ODBPSFp5ZHlZ?=
 =?utf-8?B?Mlh3bFU2amFQRXprTy91WlhPR0poa0U0U2JmTDNZV3JVT3JmY2I2MmZYSEpN?=
 =?utf-8?B?dkFWczZhUlRXVTFJK1hrdmt4RXNrZW5GZGkxMDc3UEltN2I0VzVTN2tkeG1Q?=
 =?utf-8?B?UTNnYjNWdTdOY2xkYUFadE5YV1RtTkFIWEd2enVHU3R6UTdCWjJnTE1mNm9h?=
 =?utf-8?B?b3NleGRHZ29yV09sZVNpUGNJRUxDbXRFK0dBdUc1eWlmc0ZaTmd5KzBqb3RH?=
 =?utf-8?B?SHI3TXV5QWRUVHFZNVpnZmhtQVJYQTJkZ0pIZ0pGQW1LMXZqcjJaUUtaa0xC?=
 =?utf-8?B?UmFiRGRFMU9DaFEwZTdBcHhKNW56U0pVcytsbEZOR0tiWTJsalRmZFg1Mjd0?=
 =?utf-8?B?L3NtNU5LRE9OcXNvbVYwaGE5WndDMmlzMGdJSHRmS29uN1NtOE5Ib3dZczJL?=
 =?utf-8?B?YndnakFsSkVsaFIwNkRyaVpESlpSSnV6aG51bmdDTWdCdW8ySk5CS1o0S1Fh?=
 =?utf-8?B?dWhlN2JDcG5wSUpKN00zZUhHdmw3a0dVK0oyQW9WdU41OUxXMVVaT0xPOFNx?=
 =?utf-8?Q?MUYXw/QdViUAb3Xeui/K6lg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52276e66-2a5b-441e-ce77-08d9ba704d01
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:29:34.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnsEWVqazwCYjr08oCnp0KQkImuhB5T9QQDMycZYJlghhwnUQt6VjADanT4bdT5KLYxQ/hgJSdzEi9vKkoNoqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4653
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080099
X-Proofpoint-GUID: 4T5okRx7YFAWpJluGu0mvEHxZpYHlAe3
X-Proofpoint-ORIG-GUID: 4T5okRx7YFAWpJluGu0mvEHxZpYHlAe3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/8/21 8:39 AM, bfields@fieldses.org wrote:
> On Wed, Dec 08, 2021 at 08:25:28AM -0800, dai.ngo@oracle.com wrote:
>> On 12/8/21 8:16 AM, Trond Myklebust wrote:
>>> On Wed, 2021-12-08 at 07:54 -0800, dai.ngo@oracle.com wrote:
>>>> On 12/6/21 11:55 AM, Chuck Lever III wrote:
>>>>
>>>>>> +
>>>>>> +/*
>>>>>> + * Function to check if the nfserr_share_denied error for 'fp'
>>>>>> resulted
>>>>>> + * from conflict with courtesy clients then release their state to
>>>>>> resolve
>>>>>> + * the conflict.
>>>>>> + *
>>>>>> + * Function returns:
>>>>>> + *      0 -  no conflict with courtesy clients
>>>>>> + *     >0 -  conflict with courtesy clients resolved, try
>>>>>> access/deny check again
>>>>>> + *     -1 -  conflict with courtesy clients being resolved in
>>>>>> background
>>>>>> + *            return nfserr_jukebox to NFS client
>>>>>> + */
>>>>>> +static int
>>>>>> +nfs4_destroy_clnts_with_sresv_conflict(struct svc_rqst *rqstp,
>>>>>> +                       struct nfs4_file *fp, struct
>>>>>> nfs4_ol_stateid *stp,
>>>>>> +                       u32 access, bool share_access)
>>>>>> +{
>>>>>> +       int cnt = 0;
>>>>>> +       int async_cnt = 0;
>>>>>> +       bool no_retry = false;
>>>>>> +       struct nfs4_client *cl;
>>>>>> +       struct list_head *pos, *next, reaplist;
>>>>>> +       struct nfsd_net *nn = net_generic(SVC_NET(rqstp),
>>>>>> nfsd_net_id);
>>>>>> +
>>>>>> +       INIT_LIST_HEAD(&reaplist);
>>>>>> +       spin_lock(&nn->client_lock);
>>>>>> +       list_for_each_safe(pos, next, &nn->client_lru) {
>>>>>> +               cl = list_entry(pos, struct nfs4_client, cl_lru);
>>>>>> +               /*
>>>>>> +                * check all nfs4_ol_stateid of this client
>>>>>> +                * for conflicts with 'access'mode.
>>>>>> +                */
>>>>>> +               if (nfs4_check_deny_bmap(cl, fp, stp, access,
>>>>>> share_access)) {
>>>>>> +                       if (!test_bit(NFSD4_COURTESY_CLIENT, &cl-
>>>>>>> cl_flags)) {
>>>>>> +                               /* conflict with non-courtesy
>>>>>> client */
>>>>>> +                               no_retry = true;
>>>>>> +                               cnt = 0;
>>>>>> +                               goto out;
>>>>>> +                       }
>>>>>> +                       /*
>>>>>> +                        * if too many to resolve synchronously
>>>>>> +                        * then do the rest in background
>>>>>> +                        */
>>>>>> +                       if (cnt > 100) {
>>>>>> +                               set_bit(NFSD4_DESTROY_COURTESY_CLIE
>>>>>> NT, &cl->cl_flags);
>>>>>> +                               async_cnt++;
>>>>>> +                               continue;
>>>>>> +                       }
>>>>>> +                       if (mark_client_expired_locked(cl))
>>>>>> +                               continue;
>>>>>> +                       cnt++;
>>>>>> +                       list_add(&cl->cl_lru, &reaplist);
>>>>>> +               }
>>>>>> +       }
>>>>> Bruce suggested simply returning NFS4ERR_DELAY for all cases.
>>>>> That would simplify this quite a bit for what is a rare edge
>>>>> case.
>>>> If we always do this asynchronously by returning NFS4ERR_DELAY
>>>> for all cases then the following pynfs tests need to be modified
>>>> to handle the error:
>>>>
>>>> RENEW3   st_renew.testExpired                                     :
>>>> FAILURE
>>>> LKU10    st_locku.testTimedoutUnlock                              :
>>>> FAILURE
>>>> CLOSE9   st_close.testTimedoutClose2                              :
>>>> FAILURE
>>>>
>>>> and any new tests that opens file have to be prepared to handle
>>>> NFS4ERR_DELAY due to the lack of destroy_clientid in 4.0.
>>>>
>>>> Do we still want to take this approach?
>>> NFS4ERR_DELAY is a valid error for both CLOSE and LOCKU (see RFC7530
>>> section 13.2 https://urldefense.com/v3/__https://datatracker.ietf.org/doc/html/rfc7530*section-13.2__;Iw!!ACWV5N9M2RV99hQ!f8vZHAJophxXdSSJvnxDCSBSRpWFxEOZBo2ZLvjPzXLVrvMYR8RKcc0_Jvjhng$
>>> ) so if pynfs complains, then it needs fixing regardless.
>>>
>>> RENEW, on the other hand, cannot return NFS4ERR_DELAY, but why would it
>>> need to? Either the lease is still valid, or else someone is already
>>> trying to tear it down due to an expiration event. I don't see why
>>> courtesy locks need to add any further complexity to that test.
>> RENEW fails in the 2nd open:
>>
>>      c.create_confirm(t.word(), access=OPEN4_SHARE_ACCESS_BOTH,
>>                       deny=OPEN4_SHARE_DENY_BOTH)     <<======   DENY_BOTH
>>      sleeptime = c.getLeaseTime() * 2
>>      env.sleep(sleeptime)
>>      c2 = env.c2
>>      c2.init_connection()
>>      c2.open_confirm(t.word(), access=OPEN4_SHARE_ACCESS_READ,    <<=== needs to handle NFS4ERR_DELAY
>>                      deny=OPEN4_SHARE_DENY_NONE)
>>
>> CLOSE and LOCKU also fail in the OPEN, similar to the RENEW test.
>> Any new pynfs 4.0 test that does open might get NFS4ERR_DELAY.
> So it's a RENEW test, not the RENEW operation.
>
> A general-purpose client always has to be prepared for DELAY on OPEN.
> But pynfs isn't a general-purpose client, and it assumes that it's the
> only one touching the files and directories it creates.
>
> Within pynfs we've got a problem that the tests don't necessarily clean
> up after themselves completely, so in theory a test could interfere with
> later results.
>
> But each test uses its own files--e.g. in the fragment above note that
> the file it's testing gets the name t.word(), which is by design unique
> to that test.  So it shouldn't be hitting any conflicts with state held
> by previous tests.  Am I missing something?

Both calls, c.create_confirm and c2.open_confirm, use the same file name
t.word().

However, it's strange that if I run RENEW3 by itself then it passes.
 From the network trace, env.c2/c2.init_connection generates a SETCLIENTID
which might get rid off all the states of the previous client since
they're the same.

I will investigate why it fails when running 'all' with NFS4ERR_DELAY.

Do you know if there is an option to specify a list of tests to run,
instead of 'all'?

-Dai

