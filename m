Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547433F14E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 10:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhHSIM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 04:12:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46248 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236854AbhHSIM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:12:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J86U9d014269;
        Thu, 19 Aug 2021 08:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QQzpEAn0STw9B+IgYUpK4l2pj2UjQWGZfd/CW4I/8V0=;
 b=eA6U09CRt/YF/n3DphKZyZvdfJPWDIQ4IN9Y0fuHdJ1mYt4jV8QiJHqPvYHbvZmcNRXp
 oh3F0MqKuFE1giS+1TLLUepbj4qTSRecJn42fOs+rLEsHNt2/nox5TQf2rc5RpbDl3dT
 2VHr1/gMaU2urjj7H7UAVB0cj0OtlSrcIh7xi6Y1llwbxDIheDJYKjTXm9JxMPXAUO0o
 3XU/YAK0s+2yNjGGQBsnfBCANJBiiFRUQKnvv3y+BKu9ZmJdzz0wm2FY2m1ydbKtlN9X
 ZzbQPhr+eDz0xRK0qhUzNWmFKMfmD+OultdY5MvK6av8GxYnyxkeuIvF0mPpu24Y2Vzy lg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QQzpEAn0STw9B+IgYUpK4l2pj2UjQWGZfd/CW4I/8V0=;
 b=V+F+4SoxY+PdiVpahjLsYxU8ujVQZmQJM4COVyI+GvDroEo6TsJUbSwQhep1xMbIDuFz
 sxHU9day/buRAkMB0HP5zbi4MUhF0g+DAliVb9yXfjG/nUsML0uZUq9ghpcDcDYCg5+9
 8+5Q3ndAYyi0HKC64DKR/AOb79U5lI54v35pZWIt+wbocNLPZo7ADPfblA7I2jdydqDF
 3bcm2TuJXD0H8gsfpuJvdvHDJTzN8lg5NlajrLexf7DQb+f+obSOvUELk/RaMAhVcktg
 9P55hU2z10VSkZpt0AicxMMV8rFwW5DxG2aaWcCb9XvdjakkO3QXJFkVKyjlWoijGoJ3 IA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24k5e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 08:12:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J85Bpo042835;
        Thu, 19 Aug 2021 08:12:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3aeqkxyw80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 08:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIQpzVVN2eweeqiFXegHTUj2DgP22Awq7M46UP68RBasmmPpujnNEq2/Z+IP4QmTcDanpgnGPAC8r00MV5e1CbQmEHJWI6OBPZ0TahXlj/P28SmmXDs7fpxWZYWf9zxcC4PkiCXIISvm9c4LeRFuABvf6MibryawhOvoIFHoAEYtwhKDndVQgp3N2Hcah6x6fQ3VL81al1a1kCMrzCkCVClyMRLMgg88XSGjUjMSAcxtIYFqbiGvv2Y6949pZgkVa3S6ffnv7I27GF8ckdJEiDlG9xyqnONlGnQPfmsl2JHSVBIFU5ZtcQsVjiAIR0XH0/dmAiFD7qwG1VWm8Io6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQzpEAn0STw9B+IgYUpK4l2pj2UjQWGZfd/CW4I/8V0=;
 b=bS3bO5yorai1jsC00q43adnD8HZfBxDGhA2Pevt2NktwHzF6OAc75TVWqmxLpiMKxJ8JM3zYJAfgLzbQf3IQTA3yKNuO/DK009AwoGxU1wLyv2bD7kerMLq7PNK2HPcmskGv6yAFy/+akL5l5NUYN6wcPiOJ0EYl/Eo3yrcsKM3pU12RvlW9NyBkMRu8nip5VR/EgjAil4QaxDLY+u2MGIGvjDcrlE7BQUjfaWmptLNumtA1jrpdWkb4lOnyxzxcvoufHtCc028xWTzI1N0GLNUpL7trRXUzpM6V+ei7btFvkizGXzSxz2il6kHx6/BBN5vu+e5myK1SjgFwThuYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQzpEAn0STw9B+IgYUpK4l2pj2UjQWGZfd/CW4I/8V0=;
 b=HOW5X7kHcAPPHEO8ewfhuJoJFVn5quPrNm64/BzZPtZrvcd341oytKGLJoX7bdrG1F9CnqmekOvgVeX2sazAvmSR1C0PF2wKWFjDyMsxImGXU+pV8UiJOs2QjhP91fTbxa+2PxACab3E3Iym+ud1DAHxtEUChmZp/OuCEcLvHx0=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5646.namprd10.prod.outlook.com (2603:10b6:a03:3d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 08:11:58 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7%6]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 08:11:57 +0000
Subject: Re: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com,
        Jane Chu <jane.chu@oracle.com>
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
 <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
 <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
 <beee643c-0fd9-b0f7-5330-0d64bde499d3@oracle.com>
 <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com>
 <d908b630-dbaf-fac5-527b-682ced045643@oracle.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <ab9b42d8-2b81-9977-c60a-3f419e53f7bc@oracle.com>
Date:   Thu, 19 Aug 2021 01:11:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <d908b630-dbaf-fac5-527b-682ced045643@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::20) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.39.250.26] (138.3.201.26) by BYAPR07CA0007.namprd07.prod.outlook.com (2603:10b6:a02:bc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 08:11:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0f3e761-6b28-4ef8-a2ff-08d962e903a2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5646:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB564638F0E0B06B7B90C25CF7F3C09@SJ0PR10MB5646.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ppn4zSrPec/kRjgUJM9ZegvQjsYMRRze7Bht/s1MefHzz/Kk1wgxdTeMpb6VaKHf7yVpvQO3A9vxP205G/4roUCmgFWlfbF7b1b0hUccnCZCwqQl9LRpbVKH44CzPmeoinH4HzW3Vn4+YBCHAXSAgVb2SP4WA8prD4MVoOnM/nZzvLCG9/5SyiWC0TmD69qj3enWQVS/yMcnOQs+3mjFTe7sgQxGsbIa/mB/Fd6ChNlIUZjFBAcsXWhqVBuZwTQTkXplMvtMSViXqvOn6sWlFK0oC6S0cKoP8i7GKAp2HaKErQ4pkjKzhJUgXBwavAPGJbc9p1Ajp7xYP1NewEmCLlJN5E9/LISDPURGz5Wcq62rxi+5+CaOPjgLfX6nUOhF7Hca1U9ARg9sRWfXkQNVMUXqZESmcjz5h3oASVjE0F5P2w2Le4SmH4Vx4KrDt63iqia4iC8Ds1lctfJMrqUQygDOSX2+E7y1+5TigCWUY3aKsWnLvULQMwHpk9LOCmMIHs0TsxyKfg8VuRfgpeLvS10vQQXlietgpnZDoHliIOHgTbs9sjEKD9yqFBcLrmVsxDFKIYUM8PoNj9u/HzccoKWq1ZG0T1vL9QPMNN5B2O9N9UwZxMLdZFmoKuByIG2vYEe+T9HW2nTvcFxuMBVVOXOU966nfPerfkTuil2UMrQ8slFskG09R7yGm539E/x4E0+HilQd1H8yBU8BceOiKey3zxgnmTasJeT0rzSj0mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(8936002)(26005)(508600001)(6486002)(316002)(5660300002)(107886003)(6666004)(36916002)(86362001)(956004)(83380400001)(8676002)(38100700002)(66556008)(2616005)(7416002)(4326008)(66476007)(66946007)(31696002)(16576012)(44832011)(2906002)(31686004)(36756003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRRTlBlMGJZMXhtYXZpL2RtZW5BWlNJekkyWWlnT0ZEc1EwSDN4OUExbFpa?=
 =?utf-8?B?TUlqRUNoREJPZ3RTTi9mV0luOE1DbmorRUNpcUtuNm5CMjM5UXV6VjZmUWt6?=
 =?utf-8?B?blVIT1cyQWlvNko1clkydE11dHp0NEVramtUcmRveVBQZm5LZG9NbTY5QmRk?=
 =?utf-8?B?NzUzSWNBTUQwMllQUDluWEpubi9FeXFHaStnV05GMXdIdHdPZ2JkUjJpY1pq?=
 =?utf-8?B?aGVBYnpGWmtMUG9HaFhFbHl1dG5WWFJoUEM3SzR2K01qY0RseloyR1Q5VHpT?=
 =?utf-8?B?QkVTcHdRdVZBSzlVaUpFUE52eW50b0diNE1TQ1NYdWp4cVNSdnlydkp4eDgx?=
 =?utf-8?B?VkxXVk9URjJtaEliamttUHc3eURaOXJzbFI1U3FFS0tJbDVWZlV6TnlqZW1M?=
 =?utf-8?B?RDlPY1pvSEQwalQ5TnBXdndrd2pRbURuVnpTSWc1RFNYODREcTNMQWFPSUVw?=
 =?utf-8?B?cG1YT25SZUJnMkxncTR2MWQ0SmluMHZLTkVMdVU0L3dBakprbVVsN0VCbGRz?=
 =?utf-8?B?Nm0zZnJ3bDcyY2J0d0ZtSjRqeXRzL2NPeXcvWGVKMzVCTlpMQzg5QlM2WHk2?=
 =?utf-8?B?bTIwZFNXNEo2S2QwY3F4ZVJacWQ5aE1HUFBDNGQ1NHlaeTlzRUM0bXl6OUlL?=
 =?utf-8?B?ZHBkdE1aODREaFB6NmtDeVBNTSt0a2V3ZUhzMHJVNUJxTDNRbGtoVTRmSkJY?=
 =?utf-8?B?ZkFkQzNLclRvMERCVjhPZlJpOXBPNlE3bFB5c3hOUUhmK1NtNVdSOXZFMms5?=
 =?utf-8?B?UEJiMHZNSCt3TmJaejdsdEZ0MnNJYi9lTlFmNGtCMFh1VStBUTAySDdRVWYx?=
 =?utf-8?B?Y1hnSmdrZVVIMzlMQitIY3hZUFkvSXplWDRCRFpuSWNZVVpPYi9FRzBQV1Bp?=
 =?utf-8?B?ejkybGIzOEdMVHdtNUFSR243RTVURkN6Q1hHZVVZc0t4UnJqNDA5UDczVW9s?=
 =?utf-8?B?MzZKRm5BNTBId3hRYkZSZ3pmSzhudkg1L1VYMEVzS0k0V0dOQkdNcXcxRTBj?=
 =?utf-8?B?MFdIOUQwMkU0bG5tcVF1L3VBcjFiZ0NQcDI2L0d3dFVvWUNGVGNpVFBjSENv?=
 =?utf-8?B?MGl3QytudzdjcHNNMERkMDJOZUJFQTNVQzVvRVJPQmxFU2YzSzhzdDRjVXJY?=
 =?utf-8?B?L3JyVmpiRlNBNUwyWVVORVJYcWFCeHE3LzVMZUN5bE5oMTZkVHFzOGp6VWhq?=
 =?utf-8?B?YVljUk51UWR3VTdZL3NmSVNYQjBIeHduNDQ0QnYvMGZTUGVMclRER1p4WTBn?=
 =?utf-8?B?dDFicnFGZEtGMWQ4dkxuZ0cvenE4Mnp6emlXVDZKcFlXRGpjVVpEd01PZTU0?=
 =?utf-8?B?eEZKUEd5K0RGRHZicVlGemJ6dTJuQmNHTTdocFVWcVJBRDNUK3E1d250QStu?=
 =?utf-8?B?S054dGRvYWxLTE90bDVOMWxCYkd4U3YzWWh5dUs2MS9ESHA1b0dDYVJhdlIz?=
 =?utf-8?B?cDlhSGhqQ3FQak5oc2htdzYwNFVPT3laREZTNXJ5ZTEzaWRBV2QxVEcyQi9t?=
 =?utf-8?B?ejdvbEtPQnZ3RFZKcUZSUmtXNHVpeUh1R3RQK203UUFZZWRUZXdtb2h2MlV5?=
 =?utf-8?B?Tks4R21KQU9PUFF0SzY2bzRXbW1XbHpXTVRsQmRJdTMvcjhZOWhHdVppN2R0?=
 =?utf-8?B?NUpIcVJMUWxkZnVuNlNydG5LZ3lTeHpnb1dKeDVLdzlNdWNORHlPTWNWKzhh?=
 =?utf-8?B?bmZPNzJWL0Rvb1duQVZpNkFJem5JTE4xOWNNRWNkaEJwYmFEMTFwVTBxL0gx?=
 =?utf-8?Q?r0IRHupehgUGUSPJkTsXhqTt/Uze/xgFvhSKSBa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f3e761-6b28-4ef8-a2ff-08d962e903a2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 08:11:57.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7faHi/meUdjW6wpEZ3+pJy/XnzBedm8gCARXlmmZldRUH9fvu60HIgIrWXzqN7ou6vNX24+W8BrB+aIErTYNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5646
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190045
X-Proofpoint-GUID: IBbctYYfUvpxHy1lc2ovPtmQDGICLmTI
X-Proofpoint-ORIG-GUID: IBbctYYfUvpxHy1lc2ovPtmQDGICLmTI
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry, correction in line.

On 8/19/2021 12:18 AM, Jane Chu wrote:
> Hi, Shiyang,
> 
>  >  > > 1) What does it take and cost to make
>  >  > >     xfs_sb_version_hasrmapbt(&mp->m_sb) to return true?
>  >
>  > Enable rmpabt feature when making xfs filesystem
>  >     `mkfs.xfs -m rmapbt=1 /path/to/device`
>  > BTW, reflink is enabled by default.
> 
> Thanks!  I tried
> mkfs.xfs -d agcount=2,extszinherit=512,su=2m,sw=1 -m reflink=0 -m 
> rmapbt=1 -f /dev/pmem0
> 
> Again, injected a HW poison to the first page in a dax-file, had
> the poison consumed and received a SIGBUS. The result is better -
> 
> ** SIGBUS(7): canjmp=1, whichstep=0, **
> ** si_addr(0x0x7ff2d8800000), si_lsb(0x15), si_code(0x4, BUS_MCEERR_AR) **
> 
> The SIGBUS payload looks correct.
> 
> However, "dmesg" has 2048 lines on sending SIGBUS, one per 512bytes -

Actually that's one per 2MB, even though the poison is located
in pfn 0x1850600 only.

> 
> [ 7003.482326] Memory failure: 0x1850600: Sending SIGBUS to 
> fsdax_poison_v1:4109 due to hardware memory corruption
> [ 7003.507956] Memory failure: 0x1850800: Sending SIGBUS to 
> fsdax_poison_v1:4109 due to hardware memory corruption
> [ 7003.531681] Memory failure: 0x1850a00: Sending SIGBUS to 
> fsdax_poison_v1:4109 due to hardware memory corruption
> [ 7003.554190] Memory failure: 0x1850c00: Sending SIGBUS to 
> fsdax_poison_v1:4109 due to hardware memory corruption
> [ 7003.575831] Memory failure: 0x1850e00: Sending SIGBUS to 
> fsdax_poison_v1:4109 due to hardware memory corruption
> [ 7003.596796] Memory failure: 0x1851000: Sending SIGBUS to 
> fsdax_poison_v1:4109 due to hardware memory corruption
> ....
> [ 7045.738270] Memory failure: 0x194fe00: Sending SIGBUS to 
> fsdax_poison_v1:4109 due to hardware memory corruption
> [ 7045.758885] Memory failure: 0x1950000: Sending SIGBUS to 
> fsdax_poison_v1:4109 due to hardware memory corruption
> [ 7045.779495] Memory failure: 0x1950200: Sending SIGBUS to 
> fsdax_poison_v1:4109 due to hardware memory corruption
> [ 7045.800106] Memory failure: 0x1950400: Sending SIGBUS to 
> fsdax_poison_v1:4109 due to hardware memory corruption
> 
> That's too much for a single process dealing with a single
> poison in a PMD page. If nothing else, given an .si_addr_lsb being 0x15,
> it doesn't make sense to send a SIGBUS per 512B block.
> 
> Could you determine the user process' mapping size from the filesystem,
> and take that as a hint to determine how many iterations to call
> mf_dax_kill_procs() ?

Sorry, scratch the 512byte stuff... the filesystem has been
notified the length of the poison blast radius, could it take clue
from that?

thanks,
-jane

> 
> thanks!
> -jane
> 
> 
> 
