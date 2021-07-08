Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB803BFA9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhGHMvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 08:51:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62296 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229659AbhGHMvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:51:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168CgdrD001761;
        Thu, 8 Jul 2021 12:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VRUFYsMd0FPpWrz6g5RTo9ra+BrWkXz4S09+sR2p0kQ=;
 b=w3HrA5EbBl1YlwfjJ1Yl/KvKEOc2/VRKxwjP97JJ/x2dfW27TJPDntApISHMUIR274pt
 At9FLfXSSb2uCmoyS3ynOdAFkf80oBstmm5K08qgZDbbLkGcmwwcWt7kCQmT9OgGHTLv
 nvTcpkLkPTUxLsWhBzslrw1H+8lSSCVheB4QESLLD3LxYR4MXymFn5tAxtiFtYNFlbi4
 NHyQjV8F2TS+GjF0EkvTDNm2A2JQj3BxAcbrzfGMiJ7kaNYuJAHB7XIlFphTt+2Bkk3T
 gTV7eWjkAgalNtEe2aq4bhZq0TmeMR63dcdIE/8AAPw9LycXgHywlqEmNCz473YIrkW3 UQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39nbsxtd2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 12:48:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 168CicwL098474;
        Thu, 8 Jul 2021 12:48:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3030.oracle.com with ESMTP id 39nbg47gjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 12:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVsf1IHOoi13fv6bwKAbgR2YOFxKXWm9MQ5WlC4d2S88xBokNLPBnZv9/8pU9ufL0S491ZRisKKXJeID5ToXWUJ5X7Fjtt39BJjTqAwbDJqf6CTmueJEbEWmpGBKXiwkef3Ck1V+DWwA0p9hMWSaftGRzsqExtXbJVB36CXcM+O+3sJKi4X63g0CM4DWWzgaILDzDtFNUYa8BXV6Ut7L7gWMl0zrmBWk+qZpeJWQ0Pn3As1HwBdqRl0/B5JbRUaLdyTAEYSFzdBP2kepO+joJcL2bZjam7UIv3yMxV+g4lur8H+tywv+6Krxgo8lH6tYtpmzQtwNoweB9cErzaBPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6D+1iE6BBJCy3s6qoddiTii2ouCZ37lzfbhfCMG5ak=;
 b=Oi7uLvmOSUgwrD4ovR07F5OV4FjIfx1YKUUo1XaCqPQojKZYW6W3YQ+hH4CLDxSHuz/ItUEMBIvuwPWunLGE0oQgbJ3LUfrkFf//cZ/S1rRgOnL6gVKfhYrsVTd4F5DArXDfsfFmuoLZCkefwNn2YmW1zCVDciheOaYt51Q05gxcxirKCIcXeyDJ+z/tTRqGPQhefrNwLUywILsgg3mK8hNhHQe99LwXl4RnTHHs3L/jWkeiNI2qMUw+AztJw6UythY0Gl+pB+E+/LTeDI6TQSrubrWcsUX7poWMv1XMR7AFRrvFwD78NooZXHRHJGg+eJMG62srywQjI6zLra/8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6D+1iE6BBJCy3s6qoddiTii2ouCZ37lzfbhfCMG5ak=;
 b=AhmpPjnEYL4G0/JwQIAgyDjVVt8d9QAPDP2wycetSFr7b5NrqNI6XtNZ3k6pRzmLGYS4oUU0JxiTf7bPIpLwAC7O29iM5XMo5mT0/hUau4QcNdr6Q2nyElKDCbclDhV1/okqWj7kNQdtSDCDoCl3k7oQsTKylt+DL6QfoHvlHrg=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3240.namprd10.prod.outlook.com (2603:10b6:a03:155::17)
 by BY5PR10MB3939.namprd10.prod.outlook.com (2603:10b6:a03:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 8 Jul
 2021 12:48:06 +0000
Received: from BYAPR10MB3240.namprd10.prod.outlook.com
 ([fe80::59e7:5c8c:71fb:a6ba]) by BYAPR10MB3240.namprd10.prod.outlook.com
 ([fe80::59e7:5c8c:71fb:a6ba%7]) with mapi id 15.20.4287.034; Thu, 8 Jul 2021
 12:48:06 +0000
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
Date:   Thu, 8 Jul 2021 08:48:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To BYAPR10MB3240.namprd10.prod.outlook.com
 (2603:10b6:a03:155::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.92] (24.62.106.7) by SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Thu, 8 Jul 2021 12:48:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15a722fa-63c0-464e-05ef-08d9420ea1ac
X-MS-TrafficTypeDiagnostic: BY5PR10MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3939C2069B6806DD58B23846F9199@BY5PR10MB3939.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLCu6ICqMrvAY0Wu6SsiWg7yyNloGLbS8s8ElRn7aSev7aJ2dGqkGJ4qYAZ/GJ8bAmrUdBK/2OvdIE5RGd71kdzJnza0f3RlRIA7mVOe0jnqGjLCaNtrobXmcP82za0S7dYrnMZdknleiMlMEDTBlWASpe+3GjZ+Nmfi5lTVJ50/R5KELIVZS+c4Ed+x0Vph64SWL5FvgmVYzVUDLdChCMKZKjTqodrJfWSD2K7J3YZ6AXG7VVNl2Y8bXpJnck9Ro8DHdRqwhMiFbQ7lIM5x5A2yTFYL86I+idV9LJXybfu4WBIRRwPDXagNXV7B0/R+YR2eGk0DDrTi+eZ3HiEmj/Ngny+iqweTh30BMK7Q5HVT8gIutBv4pBLiKq1A5n+X0hAbkNN3SM4jzYU8ZUxIfnS0gAafMckRtMnrf+Jh5RPns7kJA8EFbr2KuGIS4+L+YvHFbAk0SISzZntmIVM6QF5aBBu5cXeUGzIiDZWp6FK1GlEmec5zXrSUxbqX101NdBfKm6TrhSNcFgKIS4tEowG+S+rpoTxiVKkZZzTjNcBdtd/ZlmmjoLr0tQDM/dAJEZAUpS00EuHNqPpaiQRw4gw+GBxVOrBVPjMjUB+/vDJlaxA2XwSpSmDkKvmyokiYCAdpUkTMUcmpSDhE1231V7JdPk2dYbpV3D+Sag8soWvwJO5cHQkzeywmeeFMmmFVk5ccKWZ0zkCQwLcUyVE4xQMq9L1VJJ9uCv710b+67cY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(366004)(346002)(396003)(83380400001)(53546011)(16576012)(4326008)(31696002)(86362001)(316002)(7416002)(110136005)(5660300002)(36756003)(478600001)(36916002)(6486002)(8676002)(186003)(26005)(2616005)(956004)(31686004)(38100700002)(2906002)(8936002)(66946007)(66556008)(44832011)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?bWxwV01yU3dBN0d4VG1mNGZtYXlyOHJiNDNReGRiK0c4WVBZRDVlQmFtL3Vj?=
 =?gb2312?B?SEVOdXdFaUNEak5JNDZTcU5CNStHak02YklmcVFHd1FRN1ZKREtpYkpMMGYz?=
 =?gb2312?B?djdwdm55YW5UTHRMb2J0S2J5ZEtrTDBNZDJieXAxZE1PZjZzQVJ1dmp1RXdl?=
 =?gb2312?B?MDJqZC9WSkZUM2F5RjQvN0d2SHpIMjRidHlFM1RuYTA0eUczRVFRR2pZOHdo?=
 =?gb2312?B?WXBDYXpKYlBJTEZFNm5Qb1V2a0NPK3c1UXBtYlJrSnNYWWRINTNlcXE5TVJs?=
 =?gb2312?B?OVM3V0EzSzhoeWFZcG9LeXhqVWtpdWd3RFRpclJzalN1Vjdibzh1YlZzbEIr?=
 =?gb2312?B?SGRUUDZvSlRqNE1rS1pZNHBvZTU3S2NYNTd4MEZVZEJCRmVXaUdJek5WQ0JR?=
 =?gb2312?B?UTc3SlpHajZSWnhlVEdkditBNWhuU3JXVEIvY0M4bG9MNkw4cWdpQUF5cWRl?=
 =?gb2312?B?eEpCNU9ETU1NampZc29pT3Vrck1IQW9TSXAxQlVKQnRqUXFpY1hCU2V6WCts?=
 =?gb2312?B?dDZ4VHFpa2xqa1lDU2llZFgyVXdKaVBsbDNmbEtFVDQwM0c5eGRXaHFqVm4y?=
 =?gb2312?B?emZjNjRvL2FnMEFPQ3lnb1UybVpWSENnenRJaW5aRDIwa29kSDJCZkd2VGg2?=
 =?gb2312?B?d2NRaCtRcVh0VzIwcnJNK1NBckkyMFcxd2ZjVUN3aG9jRGJPRHQ1NCtacUhk?=
 =?gb2312?B?Wm9HaC9oTS9Dd0txQUlBcm9nYWJrQlNkMkpJRlRpcmZTbWlUUUhsdkx4L0V4?=
 =?gb2312?B?OTlERmlNT01VQVYvbCs5Y3RmcUQrWEVRL2dPdUVzNFl3Umt2dlhkN3h3cnd1?=
 =?gb2312?B?SndiVGY4VVF2aTMvMUdHVGJXNmlvVHNTTy8zVWVvVTR1OWQ5RFpFTERCaC96?=
 =?gb2312?B?WEk4SDVjUHpJTG0xSjlWZ29sWHBSb1ZnMlA5WVpGMTdpMGpPS1BCZEtXcEdW?=
 =?gb2312?B?N0NWUlZFd1NNT2ROQXFpTkhPcTVEQjN4cmVKa29Cb0ovelNaejB4ZlFHa2ZG?=
 =?gb2312?B?TDJucVpGS0tKZEtjM1NLMnozUnhSd2s0akJYUXExZTdwbklMcU5aNXZwM3Zl?=
 =?gb2312?B?UnZseFI3SktzaXlEV254NGJhT1Q5Vko2aktmMXJyNkRsbDJzNmJKVE5QRkl5?=
 =?gb2312?B?UitvUGlYVXRrTzZnb1FUMHNJN0d2dWExSVN1NER3cml3NjR5VXU2c1hoRkNu?=
 =?gb2312?B?bVFjai91OEprczl5VGxYa1ZDYTZFRmpqYU1WaWdQWVNuUkRiK2hZVStpWGhN?=
 =?gb2312?B?RE1qVTRpRkt4ZDNTVzE2M3Yvbks0U1VwQjN6QWJCVW5Ld1I4OHdXSWsyc2ta?=
 =?gb2312?B?Q3lkb240SkU0QlUwVUdnNkpERkk5cEpTdVlSemRaRzRoSmtDeHNlMkZtZTlN?=
 =?gb2312?B?bHZ6cEx4OXc4MDJlTElLdGQxMmEvTnZxaFJjQ3V4WGJUOU5Qc0tZb2NwM2s0?=
 =?gb2312?B?TnhYUDAxQlB2US9EOExZVmg3d1c4bW1rNVhpbUlZVW45YUNPaEVuYXdBUDk5?=
 =?gb2312?B?ektBaXZNNm4vQlJxRW1jM3dIRklMVWFrQlQ2RkJ0b3IyeUZGOHdQemE3QzJz?=
 =?gb2312?B?VE5palpaamV3K21mS0hVdnZwcHBpdkFIQTZGUVlLYmdGN0g5bzVNa2k5alMz?=
 =?gb2312?B?WFpMeGtwZjlmaFhuRCtJWEJ1dThqRHQwYStGRDBWQ2c2Qm5pdmM4NUxraXkz?=
 =?gb2312?B?dTljbGNFYkNkUEp1RUVDK2IwR0RzRzRuQytwWGxscnJrV0l3cE53R2JVdlpG?=
 =?gb2312?Q?OZc/xEfNfwhXrwv9bo4iCfK37YLiSOssTB/s808?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a722fa-63c0-464e-05ef-08d9420ea1ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 12:48:06.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8A/CkzU7VSn4UxEQiZQ7edIyF9r76lr/4yuJlq5OWIVJsbI/InqOmEXVEJ/cJczF/Px24eEcOd4dRgjxiKCd5znBkHy3fBZkzokyYfXZuWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3939
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10038 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080071
X-Proofpoint-ORIG-GUID: omFRdClSznxRcEgac497l4JIB_6bwinC
X-Proofpoint-GUID: omFRdClSznxRcEgac497l4JIB_6bwinC
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/8/2021 5:52 AM, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> Hi Anthony and Steven,
> 
> ÔÚ 2020/7/28 1:11, Anthony Yznaga Ð´µÀ:
>> This patchset adds support for preserving an anonymous memory range across
>> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
>> sharing memory in this manner, as opposed to re-attaching to a named shared
>> memory segment, is to ensure it is mapped at the same virtual address in
>> the new process as it was in the old one.  An intended use for this is to
>> preserve guest memory for guests using vfio while qemu exec's an updated
>> version of itself.  By ensuring the memory is preserved at a fixed address,
>> vfio mappings and their associated kernel data structures can remain valid.
>> In addition, for the qemu use case, qemu instances that back guest RAM with
>> anonymous memory can be updated.
> 
> We have a requirement like yours, but ours seems more complex. We want to
> isolate some memory regions from the VM's memory space and the start a child
> process who will using these memory regions.
> 
> I've wrote a draft to support this feature, but I just find that my draft is
> pretty like yours.
> 
> It seems that you've already abandoned this patchset, why ?

Hi Longpeng,
  The reviewers did not like the proposal for several reasons, but the showstopper
was that they did not want to add complexity to the exec path in the kernel.  You
can read the email archive for details.

We solved part of our problem by adding new vfio interfaces: VFIO_DMA_UNMAP_FLAG_VADDR
and VFIO_DMA_MAP_FLAG_VADDR.  That solves the vfio problem for shared memory, but not
for mmap MAP_ANON memory.

- Steve

>> Patches 1 and 2 ensure that loading of ELF load segments does not silently
>> clobber existing VMAS, and remove assumptions that the stack is the only
>> VMA in the mm when the stack is set up.  Patch 1 re-introduces the use of
>> MAP_FIXED_NOREPLACE to load ELF binaries that addresses the previous issues
>> and could be considered on its own.
>>
>> Patches 3, 4, and 5 introduce the feature and an opt-in method for its use
>> using an ELF note.
>>
>> Anthony Yznaga (5):
>>   elf: reintroduce using MAP_FIXED_NOREPLACE for elf executable mappings
>>   mm: do not assume only the stack vma exists in setup_arg_pages()
>>   mm: introduce VM_EXEC_KEEP
>>   exec, elf: require opt-in for accepting preserved mem
>>   mm: introduce MADV_DOEXEC
>>
>>  arch/x86/Kconfig                       |   1 +
>>  fs/binfmt_elf.c                        | 196 +++++++++++++++++++++++++--------
>>  fs/exec.c                              |  33 +++++-
>>  include/linux/binfmts.h                |   7 +-
>>  include/linux/mm.h                     |   5 +
>>  include/uapi/asm-generic/mman-common.h |   3 +
>>  kernel/fork.c                          |   2 +-
>>  mm/madvise.c                           |  25 +++++
>>  mm/mmap.c                              |  47 ++++++++
>>  9 files changed, 266 insertions(+), 53 deletions(-)
>>
> 
