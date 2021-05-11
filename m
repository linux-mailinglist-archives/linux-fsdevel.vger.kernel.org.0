Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4228737AA1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhEKPCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 11:02:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6110 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231875AbhEKPCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 11:02:47 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BEuiOF024265;
        Tue, 11 May 2021 15:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Cj3UpxyOdujJN9QBA6pUplzY8/Zbs0Q8ML9URFPif34=;
 b=ypd2hLtwH4l+b+vZXmpugRO4KwG0sk8C/iHk3zi1etz2fDWpwRqdKoYvSCldHuoRxAPL
 K6N7w3mVFSNyuma1YOm1SP1tvA1lObppMQN1IfYr0UTV8hOhMAQJMRw7HmBz7p/fW9La
 5fFcrRHhMK6FZAqmLlQFh2VmSYn195rile3EFi1KbMQRqeVLyg3ndFMXAFQb1Ep88MYM
 xxKnon4yHsfYNALBIlvhpFf47rRUmi908jTxF4eOQ1SYsdWtT2VqwUfCF5HW0K4v/ji8
 JC3XszTrqDFmyRQQUq4qqANPTg7gZwy3E9FNEGXroPdFsoXCnM7SEbkIORoY/y5Ki7CZ Zg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38enw7gg1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 15:01:03 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14BExaCw064688;
        Tue, 11 May 2021 15:01:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3020.oracle.com with ESMTP id 38fh3wv8q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 15:01:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVwj0WQRcRbdAomqSIWLMR5L3y7N4DYbeyIM53ETgHX0ilF4f3qgYLO/oTDFn9DT5vd0+EIX5NHgf5aVMFmkT6nTn7ogiYO7kaCWW1JSxCovOqMPPtkmeXi3Hs4jAAU1F078epQoP4QsjfuAVyp7DBEHYeAjy02vrl+B8YtJsUftzCr6wYLCQbJbj/itEQV9lR0tswrfTyA5aAisymL0cNtvxIL0hnHJAo6pwrqjLlktR4/R4wVXzRbu3cKKJ5NzZtntE3wDO9c7U3lud033z0Np2E7omm4tFd3DyYrPht/fDzD72dsCPU7MktGTJwqhM12ZH4GC3GvEijkauMfetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj3UpxyOdujJN9QBA6pUplzY8/Zbs0Q8ML9URFPif34=;
 b=WlqP8P0/WkdOdnhPsxKQpXRhyr+bQNCTulovbis38H92bBNo4RHMitVXLKzON5GVbgu4zXDNoAhm6eGH2uvQEdehlu//LDRKUsZSRv2pAeWf7qUKaGDPkeAiCNiSKrpxmpX9fa5dTVo2to7ONZ96ItbpCyEghaBfakoy70qwsVk9vLx36OptoVinozRegQuXGBBEtDyI1AuEyoqD+sHP/3isYYT8i21mKGCkO8t9uDkKNpsjNS+LHHmyr2niOM/yZ3XYux1x4bVlDdiHg8UTFxpaPnHAcVQbw/k8N/69MYmhBXdpjAMEHqkQMF+vguexWNTt7xGZ6Zd6yro7Dsz+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj3UpxyOdujJN9QBA6pUplzY8/Zbs0Q8ML9URFPif34=;
 b=I2rWneYQsLqveXGJ34OThuTzPHy7701vD2YPPWf4svKrKP5kwYaczEVNCzz6kdUoNr945012YUbHe/he+RoWu8UJC0vuBYTRxpxgiHRXT/c564Tn9MGjj2oeYEHBsVt+fjLH+Ok2vGah/xel9k+q5kO/xY/GP/YhFyPbU2mJtMs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN0PR10MB4982.namprd10.prod.outlook.com (2603:10b6:408:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 15:00:59 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::ac47:290b:59d6:f20e]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::ac47:290b:59d6:f20e%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 15:00:59 +0000
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYzXSBtbS9jb21wYWN0aW9uOmxldCBw?=
 =?UTF-8?Q?roactive_compaction_order_configurable?=
To:     "Chu,Kaiping" <chukaiping@baidu.com>,
        David Rientjes <rientjes@google.com>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "nigupta@nvidia.com" <nigupta@nvidia.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <1619313662-30356-1-git-send-email-chukaiping@baidu.com>
 <f941268c-b91-594b-5de3-05fc418fbd0@google.com>
 <2f21dec9-065f-e234-f531-c6643965c0cb@oracle.com>
 <d15e063bc7b84155b7da5c2929010e7c@baidu.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <c30a3f93-5104-7c81-e81f-a3248324ece9@oracle.com>
Date:   Tue, 11 May 2021 09:00:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <d15e063bc7b84155b7da5c2929010e7c@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [138.3.201.43]
X-ClientProxiedBy: SA9PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:806:23::14) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.154.156.43] (138.3.201.43) by SA9PR13CA0069.namprd13.prod.outlook.com (2603:10b6:806:23::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9 via Frontend Transport; Tue, 11 May 2021 15:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe2e3c07-f332-4898-13f8-08d9148d9627
X-MS-TrafficTypeDiagnostic: BN0PR10MB4982:
X-Microsoft-Antispam-PRVS: <BN0PR10MB4982A76CC3FBBC82CD7F9BC886539@BN0PR10MB4982.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MsafJ6EkGLrkmLr9SauJMqV1vajs/bEkzTSFvKKFslD3eQtR6PRZh60TfgWK4vaXaYrL59I61TK5QXROn7kqkZDfUXUJ1mgqWwoWLwctxTbXZrtNRTAmevlOZoZA1j09vy/VT4KS5PReU9q+quc7O28xUoWT7sLmlFxSLGwCYVIakFdDp4Fd1WzTQ7vGr2jFWmHUkdY+yEHYIifgDat44fnjyLxuhkGu+pWDgieT0lidPhqk01VuIYohtha5DQpcRZooupLwlEKmgO4kLZDL7Ocw3HI1OTHscuYcu6zaEL1uwZtu6f1d0Xa4q/sITTh0XvPEdvHz+V4AAMAn8u+m4SLnY4kBufoclNc1XX3j2dQyTRm4Rio9wvIx2q9YPFdDVhs+zynDie/WAb2dwDHyK/YqZfZ88T6AYRqaOKCTiME3LJUTc9kbx91rIUoC+pXrKBBG0soCPhio21bVlFpf6jw4Vu6cprWmQo4e3IzodEyKqNo/CJFfXwUzaxS+GHMiOe5aDw29xlzDDe9ihWVG6UcwhyqSULyGepENjkDPJSoB3TO7NzbQTRj2VEZAs15tuxaiU/FvQ1ckIEA9smd/N9oHJPEFgcq9sj9qJcJGvofvXGv9ZnA95D2wzl42qYRNPgnV+E+CeZP9Fb7L4Zp+iCT8Qj7ez5wTBKwFSRw7y+0mZMLTufv6cFv9zoDtGv94y8Ogde94GcWbcpq2MrA3/EYj0WFSnBhHIWS0XfyRs5DwiQau4FjWUdabfIStDoHzutm5r9Z+zzY4j2pCvy6wutV5qFAoHUZpUz2miH6V+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(110136005)(54906003)(4326008)(44832011)(956004)(186003)(38100700002)(224303003)(2616005)(5660300002)(6486002)(478600001)(83380400001)(6666004)(31686004)(16576012)(53546011)(2906002)(66946007)(66556008)(36756003)(66476007)(31696002)(26005)(7416002)(86362001)(16526019)(8936002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dXJWZ0FvZ2dTMDRHZk1uUmFaQjYzWVBKdkxsRXpoWnNicmNCcXF0M1B3TGdJ?=
 =?utf-8?B?bVgzbnoxQXFudTEwZDB6OFZlcXRONFFzc3FnVUFMYXhLb2hQYnNLb3BsSzJo?=
 =?utf-8?B?OFpUYjJqS0hnK1Q1WVFoUEJJYnVGMmNhbFZocFd5OUZXZnJGeGYyaVdhZUI3?=
 =?utf-8?B?dG42YytrT1Z1WnIzNDdQeTBrRm5lZEd2UG10RndjMlBNUXBleXgweHVZQzZx?=
 =?utf-8?B?LzhCb1JIOFFBOW8xTG51cEJzMW5zOTNKQ1BhemlXQzNyVld3RkptK3BCaFVh?=
 =?utf-8?B?MW8rYXVuMUN6RmR6Y0puYmRjOUZIanpoMExBN0dpSXJrZUdCaklhUjZjQk9S?=
 =?utf-8?B?YjBwNnJYQ2RaTHBWY3ZPZ0sxcmlMRWk3WkVHU00wUzBSQkw2Vm9pZjRDMFo0?=
 =?utf-8?B?MXM4eitCQUtPMmFNWlg5RVNHUWtPZ0VDdUJTdkQ3WndyTGwrUWlmbXdncS9N?=
 =?utf-8?B?TlgwL2JkNkt2eUtSa3NMRzFqU2I5NGNvbm80S2lzai90S2lsOW9STzN6VVRt?=
 =?utf-8?B?SXNwVlhLWVY3OC9YMFJBRXNkUGtKTjNQcGJpVnFJQlpicEpKNk9IVkFrZUgy?=
 =?utf-8?B?RnhENEt6UzJydm9JK0ZqQkgwS25KSGtTMUFGME1YL2x5Z3JRa1pqQU9oSkwr?=
 =?utf-8?B?UEt6VnQ5YXJrc3Q0L25JZmtHYmtSQ3ArRXl6UGlZY3luY2x5RVZqWGYvL2V4?=
 =?utf-8?B?ZHFSbE1FZ1ZyMFBNK2dTcFdqcDZkejZWcGpUakZqZndJdHZXRGNuWXltRUZa?=
 =?utf-8?B?UmlSRkhaaDhVakVzZ1pCZXVDWVA0VTVUSGVyM25hRzhZWVZtaERUSmxtRTRp?=
 =?utf-8?B?MUxuMDNFYjNkZXRRWXFINWIxUUxLeXU0eDJZM1hqYkk3dWVPNkVDUmM3MW8y?=
 =?utf-8?B?c0NrVTNMR3pRN0g3VnZKb091dTdyUWd5M3hHdVpGcFQ0NHUwTmxxMm1yYmtm?=
 =?utf-8?B?ZWdMZ202RkVGOGFLbGdFTEViT2svY25jSUROT1d3RTZwNVFqczB4RmFwWlZD?=
 =?utf-8?B?WEtISi9QR1BCMkRhWG9SMEhaejJyUnhUelpSL09sTnRkRm5jZzhSTGpJRkZ6?=
 =?utf-8?B?U3MwRnFhQmhESjlXQU51QzhTYmxWNGthZEQ0VWhvLzUwck95RDBUUmhVL1hG?=
 =?utf-8?B?TDh6dUI4S1dwTVgxWFhDQy9HK1Q2Sy9yQVVBbTR4VEJHQlpiOHdhdXFUOUY1?=
 =?utf-8?B?emhMTmYwT3EzZG9yaCtLNGxpNzVieG54MmxWZ250elR6Z1FSSEtXYUJqdFJ4?=
 =?utf-8?B?NjVKU0pZckV2QTBGZlpBTnEvNDZSdDBPcVZGbE1GY3JsaURGSjY0WnNJVzlx?=
 =?utf-8?B?d083L1BmNE9HNG9sbFFaTHdIbHEzL3dGSld4NGVlMVVUc2lwMHpJUCtDbmdo?=
 =?utf-8?B?OVc1NnIyVGhsTExEclhLS0JVNEtVTUdneFkzd1VxMTJSTDdtQ3RLbFRKbTdJ?=
 =?utf-8?B?VXdwakFBeVU3azNWMVNXVE0vZU83dEZrcGx6YkxMWlZkMllKV3U3bDl0N1NQ?=
 =?utf-8?B?SFNhdit0ZU83cXY5cjVnbVVZa05kZnR0QUxsam8xOC8wVkRxM3pOWDJMeE1Z?=
 =?utf-8?B?OTRUYU56b21nc08rQ3c1NktZSGhyZEx6a1VkNFJaK2V6MmRPZEJwSE5hd3gv?=
 =?utf-8?B?bzFpYU1BWnlGU2NHbkF4VEZHVWFOR2lDWkdhTnIyM0Q5cmlIb29kVFF6TVE5?=
 =?utf-8?B?N2pONzZFRm9xSE5Wc2lvQVZub1hHM1lRSy95M09MTHA2QUtaZVVWZEVJem52?=
 =?utf-8?Q?0lDyWWiruqX7BZo1Y4AgjIrAPOadiltwAloMTMI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2e3c07-f332-4898-13f8-08d9148d9627
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:00:59.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2B3scGsm3r8OnRdBMzFX/sdtFUeuOGLFuFoWD/8CwMUL0beQk/dCWkffetMWwBiylbRX7X3ncq/BbfrhJHGDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9981 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110111
X-Proofpoint-ORIG-GUID: jCFDRAtAz8sKC_QlxOab2BJmuS5K63at
X-Proofpoint-GUID: jCFDRAtAz8sKC_QlxOab2BJmuS5K63at
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 1:48 AM, Chu,Kaiping wrote:
> 
> 
>> -----邮件原件-----
>> 发件人: Khalid Aziz <khalid.aziz@oracle.com>
>> 发送时间: 2021年5月7日 5:27
>> 收件人: David Rientjes <rientjes@google.com>; Chu,Kaiping
>> <chukaiping@baidu.com>
>> 抄送: mcgrof@kernel.org; keescook@chromium.org; yzaikin@google.com;
>> akpm@linux-foundation.org; vbabka@suse.cz; nigupta@nvidia.com;
>> bhe@redhat.com; iamjoonsoo.kim@lge.com; mateusznosek0@gmail.com;
>> sh_def@163.com; linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
>> linux-mm@kvack.org
>> 主题: Re: [PATCH v3] mm/compaction:let proactive compaction order
>> configurable
>>
>> On 4/25/21 9:15 PM, David Rientjes wrote:
>>> On Sun, 25 Apr 2021, chukaiping wrote:
>>>
>>>> Currently the proactive compaction order is fixed to
>>>> COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
>>>> normal 4KB memory, but it's too high for the machines with small
>>>> normal memory, for example the machines with most memory configured
>>>> as 1GB hugetlbfs huge pages. In these machines the max order of free
>>>> pages is often below 9, and it's always below 9 even with hard
>>>> compaction. This will lead to proactive compaction be triggered very
>>>> frequently. In these machines we only care about order of 3 or 4.
>>>> This patch export the oder to proc and let it configurable by user,
>>>> and the default value is still COMPACTION_HPAGE_ORDER.
>>>>
>>>
>>> As asked in the review of the v1 of the patch, why is this not a
>>> userspace policy decision?  If you are interested in order-3 or
>>> order-4 fragmentation, for whatever reason, you could periodically
>>> check /proc/buddyinfo and manually invoke compaction on the system.
>>>
>>> In other words, why does this need to live in the kernel?
>>>
>>
>> I have struggled with this question. Fragmentation and allocation stalls are
>> significant issues on large database systems which also happen to use memory
>> in similar ways (90+% of memory is allocated as hugepages) leaving just
>> enough memory to run rest of the userspace processes. I had originally
>> proposed a kernel patch to monitor, do a trend analysis of memory usage and
>> take proactive action -
>> <https://lore.kernel.org/lkml/20190813014012.30232-1-khalid.aziz@oracle.c
>> om/>. Based upon feedback, I moved the implementation to userspace -
>> <https://github.com/oracle/memoptimizer>. Test results across multiple
>> workloads have been very good. Results from one of the workloads are in this
>> blog - <https://blogs.oracle.com/linux/anticipating-your-memory-needs>. It
>> works well from userspace but it has limited ways to influence reclamation and
>> compaction. It uses watermark_scale_factor to boost watermarks and cause
>> reclamation to kick in earlier and run longer. It uses
>> /sys/devices/system/node/node%d/compact to force compaction on the node
>> expected to reach high level of fragmentation soon. Neither of these is very
>> efficient from userspace even though they get the job done. Scaling watermark
>> has longer lasting impact than raising scanning priority in balance_pgdat()
>> temporarily. I plan to experiment with watermark_boost_factor to see if I can
>> use it in place of /sys/devices/system/node/node%d/compact and get the
>> same results. Doing all of this in the kernel can be more efficient and lessen
>> potential negative impact on the system. On the other hand, it is easier to fix
>> and update such policies in userspace although at the cost of having a
>> performance critical component live outside the kernel and thus not be active
>> on the system by default.
>>
> I studied your memoptimizer these days, I also agree to move the implementation into kernel to co-work with current proactive compaction mechanism to get higher efficiency.
> By the way I am interested about the memoptimizer, I want to have a test of it, but how to evaluate its effectiveness?
> 
> 

If you look at this blog I wrote on memoptimizer - <https://blogs.oracle.com/linux/anticipating-your-memory-needs>, 
under the section "Measuring stalls" I describe the workload I used to measure its effectiveness. The metric I use is 
number of allocation/compaction stalls over a multi-hour run of the workload. Number of allocation/compaction stalls 
gives an idea of how effective system is at keeping free order 0 and larger pages available proactively. Any workload 
that runs into significant number of stalls is a good workload to use to measure effectiveness.

--
Khalid
