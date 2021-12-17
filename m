Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78B7479626
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 22:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhLQVXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 16:23:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21032 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhLQVXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:23:45 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHKBD2V013135;
        Fri, 17 Dec 2021 21:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DB1r4bt7y+q/qOU3Aisasn7xkLPT8+4pPgiyu3UWDvg=;
 b=a7YNCiDc5iB/AbZ5q+6dQcU5mM45a8C9PwcZLnpumApJWITJu1TEeuISlDw9orFyHYsV
 vLRKz8qiXTGB6oO4CX+RSMnslRLX3+HdNjFirPn3DISDxPcTk0CZr6D8Vvu6iJwN4pwK
 uo78pbn5VaU5ocEir6P9aLoL66JymhjxxJvGY5S/ngtkbJE0JeK024gpzNpt3XIe/bgM
 JG0eHXF/0pYvkXyqvcZ1UXUlaXsnQQbbwOQBRcpGJqVK8tnKs4peBwn715PALpQ6/ZJZ
 SE3KaNS+/vIiJQWz3P23uujwmwXpcaD8coBkCfukCkA6kwGIV4KiHNMPFDRuiZsRF/R1 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp6vgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 21:23:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHLFx4x153904;
        Fri, 17 Dec 2021 21:23:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by userp3020.oracle.com with ESMTP id 3cvnew23rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 21:23:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coiHZKwlDuJurXV5labcGTmbCxtNsDKtYRQKEQl1YDa2NT8y3rQ4uyy6devjt9dGBhuvj6PXQtC8nEPbBrEMoUtG1cC+BUsjKE8QOaVcmIuyMRGb6vzLMmTCifB8kR477QPiEkqGMdIzZL0rqFAqgEK72OyIJx3MctpL0FvIF110bQsIzfZ6KgwIumUpoNGa3Rug93TGHh2n1hX/o7M+GfeU+NjghIkMeZmp2wQ1r04Aq2NeMvtaWNEGmWeJixkV3uoy7Izqafzrl38oZonkKp2EMCOHSFV4n12u+KmvIN1NBOPV9dpCnn6xgrVIP6upqcJn14gd28ymUV3C/wWkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DB1r4bt7y+q/qOU3Aisasn7xkLPT8+4pPgiyu3UWDvg=;
 b=JopZpWCeN+q1fOF3Ebup/o/f6cl4g7uyBTP9GglD+9hC1MSzh71uNsnKDdb+9hmXSF6+6ueLWwoviB/9ppZH6negXkYyPqJw97vnZ0nzIZzJCZba0v4LbvRXDY8IUSFFYQfMegzo2OjQlEQwg5VLC/sMXr2P4AIuGdYDwuAZhh96SsA03CSn+yZpQ0nd2AtJHVWE4eSiJzXZEIoQk5LBa6xmpdI6IuV/zTqTB/vV7pUKw6VX+80duDTlKmpiMHrVmdVAIBK4SNhQOj4kOXYPQ3U9vr9BzJeUdxg/N6jZpF09Lx1+fIoiwcxINLUOdNHP6iSQpFM/ki92XjpmbLnQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DB1r4bt7y+q/qOU3Aisasn7xkLPT8+4pPgiyu3UWDvg=;
 b=kTuwrt3YFwS8ar5EWdksaSVF95EK7psT8hlk7PTh+VqPUYgMiat2N4lsLFczX26hr2wk7aG4QQ+gETg5i0zMFouJlbBXIYKue7K5pnbz+l2eQGBvi3Yab4pabiskKyO2IhZ4lsIRoYJUDb17CwXqnQD19+4s0YquMJQovSiK9Cc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 21:23:38 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf%4]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 21:23:38 +0000
Message-ID: <35eb11dd-84ff-0d53-7183-2001084bab1a@oracle.com>
Date:   Fri, 17 Dec 2021 13:23:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH RFC v8 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20211213172423.49021-1-dai.ngo@oracle.com>
 <20211213172423.49021-2-dai.ngo@oracle.com>
 <0C2E5E30-86A3-489E-9366-DC4FF109DD93@oracle.com>
 <20211217203517.GJ28098@fieldses.org>
 <5fa49a09-50c9-efb4-fa72-35c0e8d889b1@oracle.com>
 <20211217205849.GK28098@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211217205849.GK28098@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a1806fc-6d81-4ec0-160a-08d9c1a37d9f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4161:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB41612B6C23B4AE190DA47AE787789@BY5PR10MB4161.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZT9KLbxsFob8y9BoXtkvX8Szm7DFpwp70nB7RsqQAgb+QV81SSZFXHtpzuK0ueTQ9azhBRR6F6kt1pS7yjeNF0K2fng4osDrQfuBJCt8hm8XgFYMaPW2GfkJWEE8OgQk2og12yuS9NxYMdQsSufTVynIjAkHOrxP57RmEBTF1+kTIM3cFxYJ2nebzuqfdE+0g21hZkSxRYZ1a5MH0qUoH0p2DHaG13PvWKlVAmhaSYKoRIMJ/qzXMtbADezOEnLyIGuTSIfprz+IX15GhXredFM2/Hsji4F5xSfC/k1OAIVXYNyaJWEVKModUutuAutpVr+SouWRdJRl8YDDOKAfTRRhjrT+RHtcwMG+owyX87I0KJrr7wjpojaX/8Zh/AgX3k5b/acSRC/QjL6YwC6h6zG5UH/CypUqNPbtmBaUBVK9HeSrEzZjvlVli8tAEdDjQ/l3vFpNcYHoDfkAwUfSzn0hXaoiwxnBfUMNoCY0UL+yGuKaR+3mHNX79FWuj7SAR35BAH59C7TKO6z3WlrLuZM/elv2GhZULVW/u+WYSH0BXC4ZLFZninXPlpWZeLyar7m+GL8TLUWjEiXxVsNxhCNLKNKzq6QQYX3xhqdprpTKI9UWbVdxW7ziH5JMenshLMUgJZFkMlIgRHvMYMBZrwRohBOACDUrJSpq1YhJ+I0hHpL6IrWXyfxGSsoNQgy1dK/YZY04sKfprRA00HkRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(54906003)(31696002)(86362001)(8676002)(316002)(2616005)(508600001)(4326008)(9686003)(8936002)(6512007)(36756003)(5660300002)(38100700002)(2906002)(31686004)(53546011)(6506007)(66476007)(6916009)(83380400001)(66946007)(66556008)(26005)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnhZYzMyZWxjTlc1NllEZ2pSMFBaT2Z4cWRKWGMybFY0UEZNeTBnWFpyeVh1?=
 =?utf-8?B?anZwNDA3dHYrY1FiUFQ2a25HVGNxRFBWL3RHRzVCS2dlUk50emRVYTZIMnZG?=
 =?utf-8?B?UWVvNjl3YTllKytwNmxvYkF0K2RSOUl2eG5DYkE5V2taNEc2dUtwM0ovekcz?=
 =?utf-8?B?MmN1MU9sVUtWUlNBSEZIWXEzNUVqYXo2ZDh0VjlZLy9meDRUM0I3akQya1Jj?=
 =?utf-8?B?VDVjY2ErNzdWSlpaUVJJUnd6VmptcDZGS29JMzVqVGhLaHd6TGFYY3FZVGQr?=
 =?utf-8?B?UUw4WEcyazM2bURWMEF6LzRsRERiY2ZiamdsZXRqZEtibXh6T1JwZEhyeW9N?=
 =?utf-8?B?VFBIQmNaRDlNMkg5WXVhajhwb1V4dXZkS2E0dWM4T0I1aHZFc0RBVXZZSTZH?=
 =?utf-8?B?bENNSC8vUlpHM0NJWlkyVnRaNlMrRXdJbUpwc2dMbjgwZ2YyWGZOUXZicUhT?=
 =?utf-8?B?NmJJVGNCNlhRdm1SR045WC9Obks5RE5nVm5ZOHlLTUpweVhtTldEVldoQTBh?=
 =?utf-8?B?eGUwSllUeWdYUWZ2YWxCc0M0bDBwRUlLNlpHb2tQTlBFUktHemRENFFueGE2?=
 =?utf-8?B?U1pxblM3MGp1VDhzWkQwV0pOSGFZa0ZyRjNYWklFZnhHSnFjQkNhN1pYM3pu?=
 =?utf-8?B?OGpzYmVxQ2x5NTh1YjZPcGR2M1orZG5JcFRkSG9QL1d6cWRnVzhFWjVYUUNs?=
 =?utf-8?B?ODUxSkZQNVFHUnRBUzZNVUZZM1doNGVDYmd5aFRUS2xmUFRtV2V5QkdyVXIx?=
 =?utf-8?B?YkN2Zlg5OElkdEhIQzkvT2hHRGRidGo4Q09LaWJRMFR2ZnpHYkQ0bkdmcDNa?=
 =?utf-8?B?TGVQcHNDSmg1TXZTRXcvQU03RS83elQrNFBVclFBM0FaSFJnSkI0RjlFMXlk?=
 =?utf-8?B?bHRONUN0Y3BRWGJUdGhkZ05XVU9hSndnWkgrY3FDaytBRjA1ZVFWdUlKZjdG?=
 =?utf-8?B?d3pRRGVuUU9DZWRucWhXcE1aLy94NnhzTnJJeGtXVExISkhGbm51WkNnOXph?=
 =?utf-8?B?a0VyWkV1c1BHSkgwWlY2dG14SkI3b1JFaU9xTXJ4YVpIV2ZTa0R4aXphL1Rj?=
 =?utf-8?B?eGQzUWJsWGh0ZHZqTVg3NHNRekJZRGJxWjNsV3NIRlhXWjRWNWFlUUxBYXNu?=
 =?utf-8?B?RllCMU9oWHNGdWxjZVRoeTVoTWVvVHJ1ZzlCZUNLSmFUN3YzRHdNTWdyR0Mv?=
 =?utf-8?B?Y3Z4dUkwYUdxYXk0Y3lEQmN6SCttRy9aMmJrSXlOOHJwVDFjd3JtK2pTQ0dv?=
 =?utf-8?B?RGtHTXJOWUJKYzhRak1kelZ3VFJZNkxQTFUvUWVTYllyalAvemNJVFZ5dncx?=
 =?utf-8?B?YnZZMm13elo1UU0zb1VDalhvUkZDbVYwSktDKzVtcUhKVDZIMXNhanpQdEFF?=
 =?utf-8?B?Z1dJUGxNSCtSQ2gvN2FmYnNNRC91czdaeVBRZ3NZSm16ZnlYMjlnWjZEdXhP?=
 =?utf-8?B?ZzJOOVo1Yk16TWE1NjUyVEVLbWxudXhpVk43djY2TGhTRGY0b3ZuRXhpOGpi?=
 =?utf-8?B?d29kSWRRanY4dnBqTG5qMXhQZ0ZZL1JHSFhRaC80THA3Yi9RUk83UERGSnVC?=
 =?utf-8?B?UGluNi9DaUtaWFBRTTZHdU15U012UDNRNUo0YkZOcnZYT3FjUXBTeWlJbVd3?=
 =?utf-8?B?OHV4QU1rVUh5WmhKYVpnVml3aGozcWE5VlVJMXo1djFpUytkSXEzWHNnZEZl?=
 =?utf-8?B?NFBlcjNKSnFNUW92QmVYWWRSNnVaeFRMS1U3NzN0cy9PMC9DcnBHaGZhSUtM?=
 =?utf-8?B?TEFlYTRibnl2SmpMUE5sTFR3a2RGejBNUTQ4REV1ejRsS3hoUEFQRHJiWDJJ?=
 =?utf-8?B?ekdMa094NHRIMEhYeTJWdm9UQzBxd0JDN29qYnVIa0RRZmdSZFV4c0lTaENq?=
 =?utf-8?B?dnpmbndSUGtIdUgwam1KcHVDbEtNSWtVQ2ZqOVpzazJheHlya042T0hYZGdF?=
 =?utf-8?B?bm5TQ2VjN21qNWEweGpMajVMNnVHY041cE5QVlQ3L2ZlSW9JdisrSklJZTNu?=
 =?utf-8?B?RkFkdnRtU2dZb3lBN0JGSHFPUGQ1Ky9tQXdvTk5USlhzUlliQ0NKYzN1ejFO?=
 =?utf-8?B?OExRUjV0R3RMMTBPMkwzTVBuREFYTm1vUmUyMSsyYW9wTlRmckkxcVhWbStK?=
 =?utf-8?B?NUFIUS9NYWVvdDlEVkExdlptUGNpdFlWNXFHK3l4Wk1UeWN4Yy9vUDZ2MXR5?=
 =?utf-8?Q?E5Q+98nHX48zq042745R3fw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1806fc-6d81-4ec0-160a-08d9c1a37d9f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:23:38.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd8K6b4BLDO8ivrKh8f/e3UqcTpShSDOGQNhMHmeK5K4vGF2PStdUgCRCo/nc7pupiO2VwDfCg2GIxkLAuDLAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170120
X-Proofpoint-ORIG-GUID: -uk2kLtNYUaKZS5_HffgInsnPM_eNEQ2
X-Proofpoint-GUID: -uk2kLtNYUaKZS5_HffgInsnPM_eNEQ2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/17/21 12:58 PM, Bruce Fields wrote:
> On Fri, Dec 17, 2021 at 12:50:55PM -0800, dai.ngo@oracle.com wrote:
>> On 12/17/21 12:35 PM, Bruce Fields wrote:
>>> On Tue, Dec 14, 2021 at 11:41:41PM +0000, Chuck Lever III wrote:
>>>>> On Dec 13, 2021, at 12:24 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>
>>>>> Add new callback, lm_expire_lock, to lock_manager_operations to allow
>>>>> the lock manager to take appropriate action to resolve the lock conflict
>>>>> if possible. The callback takes 2 arguments, file_lock of the blocker
>>>>> and a testonly flag:
>>>>>
>>>>> testonly = 1  check and return lock manager's private data if lock conflict
>>>>>               can be resolved else return NULL.
>>>>> testonly = 0  resolve the conflict if possible, return true if conflict
>>>>>               was resolved esle return false.
>>>>>
>>>>> Lock manager, such as NFSv4 courteous server, uses this callback to
>>>>> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
>>>>> (client that has expired but allowed to maintains its states) that owns
>>>>> the lock.
>>>>>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>> fs/locks.c         | 40 +++++++++++++++++++++++++++++++++++++---
>>>>> include/linux/fs.h |  1 +
>>>>> 2 files changed, 38 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>>> index 3d6fb4ae847b..5f3ea40ce2aa 100644
>>>>> --- a/fs/locks.c
>>>>> +++ b/fs/locks.c
>>>>> @@ -952,8 +952,11 @@ void
>>>>> posix_test_lock(struct file *filp, struct file_lock *fl)
>>>>> {
>>>>> 	struct file_lock *cfl;
>>>>> +	struct file_lock *checked_cfl = NULL;
>>>>> 	struct file_lock_context *ctx;
>>>>> 	struct inode *inode = locks_inode(filp);
>>>>> +	void *res_data;
>>>>> +	void *(*func)(void *priv, bool testonly);
>>>>>
>>>>> 	ctx = smp_load_acquire(&inode->i_flctx);
>>>>> 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
>>>>> @@ -962,11 +965,24 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>>>>> 	}
>>>>>
>>>>> 	spin_lock(&ctx->flc_lock);
>>>>> +retry:
>>>>> 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
>>>>> -		if (posix_locks_conflict(fl, cfl)) {
>>>>> -			locks_copy_conflock(fl, cfl);
>>>>> -			goto out;
>>>>> +		if (!posix_locks_conflict(fl, cfl))
>>>>> +			continue;
>>>>> +		if (checked_cfl != cfl && cfl->fl_lmops &&
>>>>> +				cfl->fl_lmops->lm_expire_lock) {
>>>>> +			res_data = cfl->fl_lmops->lm_expire_lock(cfl, true);
>>>>> +			if (res_data) {
>>>>> +				func = cfl->fl_lmops->lm_expire_lock;
>>>>> +				spin_unlock(&ctx->flc_lock);
>>>>> +				func(res_data, false);
>>>>> +				spin_lock(&ctx->flc_lock);
>>>>> +				checked_cfl = cfl;
>>>>> +				goto retry;
>>>>> +			}
>>>>> 		}
>>>> Dai and I discussed this offline. Depending on a pointer to represent
>>>> exactly the same struct file_lock across a dropped spinlock is racy.
>>> Yes.  There's also no need for that (checked_cfl != cfl) check, though.
>>> By the time func() returns, that lock should be gone from the list
>>> anyway.
>> func() eventually calls expire_client. But we do not know if expire_client
>> succeeds.
> expire_client always succeeds,

Even when expire_client always succeeds, what do we do when we go
back up to the loop to get a new 'cfl' from the list and that happens
to be the same one we just expire?  this should not happen but we can
not ignore that condition in the code.

This patch can be used for other lock managers and not just nfsd (even
though nfsd is the only consumer for now), can we force other lock managers
to guarantee lm_expire_lock(not_test_case) *always* resolve the conflict
successfully?

We have to have this loop since there might be more than one conflict
lock.

-Dai
  

>   maybe you're thinking of
> mark_client_expired_locked or something?

>
> If there's a chance something might fail here, the only reason should be
> that the client is no longer a courtesy client because it's come back to
> life.  But in that case the correct behavior would be to just honor the
> lock conflict and return -EAGAIN.

That's what the current code does.

-Dai

>
> --b.
>
>> One simple way to know if the conflict client was successfully
>> expired is to check the list again. If the client was successfully expired
>> then its locks were removed from the list. Otherwise we get the same 'cfl'
>> from the list again on the next get.
>>
>> -Dai
>>
>>> It's a little inefficient to have to restart the list every time--but
>>> that theoretical n^2 behavior won't matter much compared to the time
>>> spent waiting for clients to expire.  And this approach has the benefit
>>> of being simple.
>>>
>>> --b.
>>>
>>>> Dai plans to investigate other mechanisms to perform this check
>>>> reliably.
>>>>
>>>>
>>>>> +		locks_copy_conflock(fl, cfl);
>>>>> +		goto out;
>>>>> 	}
>>>>> 	fl->fl_type = F_UNLCK;
>>>>> out:
>>>>> @@ -1136,10 +1152,13 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>>>>> 	struct file_lock *new_fl2 = NULL;
>>>>> 	struct file_lock *left = NULL;
>>>>> 	struct file_lock *right = NULL;
>>>>> +	struct file_lock *checked_fl = NULL;
>>>>> 	struct file_lock_context *ctx;
>>>>> 	int error;
>>>>> 	bool added = false;
>>>>> 	LIST_HEAD(dispose);
>>>>> +	void *res_data;
>>>>> +	void *(*func)(void *priv, bool testonly);
>>>>>
>>>>> 	ctx = locks_get_lock_context(inode, request->fl_type);
>>>>> 	if (!ctx)
>>>>> @@ -1166,9 +1185,24 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>>>>> 	 * blocker's list of waiters and the global blocked_hash.
>>>>> 	 */
>>>>> 	if (request->fl_type != F_UNLCK) {
>>>>> +retry:
>>>>> 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>>>> 			if (!posix_locks_conflict(request, fl))
>>>>> 				continue;
>>>>> +			if (checked_fl != fl && fl->fl_lmops &&
>>>>> +					fl->fl_lmops->lm_expire_lock) {
>>>>> +				res_data = fl->fl_lmops->lm_expire_lock(fl, true);
>>>>> +				if (res_data) {
>>>>> +					func = fl->fl_lmops->lm_expire_lock;
>>>>> +					spin_unlock(&ctx->flc_lock);
>>>>> +					percpu_up_read(&file_rwsem);
>>>>> +					func(res_data, false);
>>>>> +					percpu_down_read(&file_rwsem);
>>>>> +					spin_lock(&ctx->flc_lock);
>>>>> +					checked_fl = fl;
>>>>> +					goto retry;
>>>>> +				}
>>>>> +			}
>>>>> 			if (conflock)
>>>>> 				locks_copy_conflock(conflock, fl);
>>>>> 			error = -EAGAIN;
>>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>>> index e7a633353fd2..8cb910c3a394 100644
>>>>> --- a/include/linux/fs.h
>>>>> +++ b/include/linux/fs.h
>>>>> @@ -1071,6 +1071,7 @@ struct lock_manager_operations {
>>>>> 	int (*lm_change)(struct file_lock *, int, struct list_head *);
>>>>> 	void (*lm_setup)(struct file_lock *, void **);
>>>>> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>>> +	void *(*lm_expire_lock)(void *priv, bool testonly);
>>>>> };
>>>>>
>>>>> struct lock_manager {
>>>>> -- 
>>>>> 2.9.5
>>>>>
>>>> --
>>>> Chuck Lever
>>>>
>>>>
