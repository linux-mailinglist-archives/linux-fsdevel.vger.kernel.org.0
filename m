Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7B14795C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 21:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbhLQUvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 15:51:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8856 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237116AbhLQUvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:51:05 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHJsQEm011690;
        Fri, 17 Dec 2021 20:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+BhvvHvsEhR7W0LPBYstVR39VKb345Z/SD461OUfob4=;
 b=V8DhCLLV0Z3OrhsUlEi2h5QfMVe3iv04kWNIneniZjwa+/U3HQVW2td8f51C+rwxq3CZ
 sR1MhaDiYzjtD+bheOVEhlurMACK/JsTDFu0U3JSnjK86mQyEWZWtjxghvZDvWYkDkwN
 G6mL1/kVd5bWRf9/QOyULAyX/ACHKbgZrJPMxSMHVTunBCCZFA9dR0CUte8iR9Ts0Qmy
 PqhWsa9SD+wMtSkPnJTDvQMKQabz+Yg9C1dWxl2ue4EhuOvMXBmccy93qgZCKbJZmf08
 5+SnfpSFjN5LZPCLdCYIvuioxB4mBXzUQOjqmjW6AYqPIRrB3TU2uGNUMuSH1c7lThkG Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykm5evf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 20:51:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHKkeoq123620;
        Fri, 17 Dec 2021 20:51:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 3cxmrfcynq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 20:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNlnYEqB3HWm7n32ejVLslm7P79TYydZtLgty3cErRE8064ocXTyCDi6T6Ej3J+oDuNaDQ6GnksbCADSoQKTjHvZJPMObbjfL7759u0GO5/d9UeJLGqLEuVOtBZjU9vIh6rYsXP1oZywfnIY6pm7/aqLHFkCrhZPIfV4ojtc6BfKLEfh9uo39tYvasmgwozzWwUodyj1hdk2foqGcSFlqIGPxHev8VZy9E3ztXWn0G09mGCH9aY8tXoDwX3GA0RDCDICHmc+HAKF93AYqP3EKIl5xTDS7WhiCt4w3tq44jU8ymO+1NwMjalOYztQ0fbnx67/UqNq7+9RyvyhopiiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BhvvHvsEhR7W0LPBYstVR39VKb345Z/SD461OUfob4=;
 b=aPMsIfKZ07piX2Fckfi1Qrz+lE3cXzevPHz1pPPkzDs4thkoO+M+CkWT210xdmzU+UHDgu2NRuRXhURwEQ7279OQMQ8LXK6FfJ1EiWWiG2DOV2mcC4fjR7ZWQmitb83oBsu2u3ZjSJ03KPrTG5vYOwhkqsXE0wsvab0EzXWc6ypueLDV5H9AM/FFqLndkWIZh02Ag/eUCgirSYcSidlQUcJKWkEqfsglU8oaYValgnX+V7ZOHgUIoMoaOvBbT4MlbDQyQuM2rd30SUwYB2GT6IQiYHg4tmvD3dtAcMRcGV0QS6WFI84JgI5ZEZ3vN7XXOFEv7j/DBT90+RSA7ESyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BhvvHvsEhR7W0LPBYstVR39VKb345Z/SD461OUfob4=;
 b=IdmD7x4yKuFkY4MV4fO44YGKmCE7FH/G9Z6b1KfwxnvbLRCEpuAFsW5kk9f1swJZGW7UgYziGvCh22JFvWKBY0vAOp8m9LS66Omb/HIaQmqx0Z1YX46a++sJJUMxTVjcGq28v/8Ta2PlU08XAy0HDTheX/7T9UIKw2fTb9gBLho=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4464.namprd10.prod.outlook.com (2603:10b6:a03:2d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 20:50:59 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf%4]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 20:50:59 +0000
Message-ID: <5fa49a09-50c9-efb4-fa72-35c0e8d889b1@oracle.com>
Date:   Fri, 17 Dec 2021 12:50:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH RFC v8 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20211213172423.49021-1-dai.ngo@oracle.com>
 <20211213172423.49021-2-dai.ngo@oracle.com>
 <0C2E5E30-86A3-489E-9366-DC4FF109DD93@oracle.com>
 <20211217203517.GJ28098@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211217203517.GJ28098@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7b2161a-3a09-4d35-9394-08d9c19eedc1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4464:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44642B0347FC856F19AAE10587789@SJ0PR10MB4464.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYo/XHMgnsqvXjzJsagiMDl+UD6JWSezjIEbhYS27XnZ3GwV19fLwCb2Ysxnav03vH5/19dJbqRNnhXLPCQAEHZaspuClFS8Jv31dSwsnOGqXtBpxLu8xVbxXTjVaWWFkmHbaA84AtOKNO8gQlKoeDvcqP6TGTnoW06RhKZpf8DTrbqPAvaO9kQEHMxlO35+8eJSBK0lXsDPgd3jQbRVO8IucNNtmkgA7173k/5wZxIpA/aeBb+K0bIu5MUst/lESmzT8Wdnq5IPb6gE7gs/ozWuK4XXU5lVJXVoMtN5LE7TyFdykx8FvGCxRGo9RDXfdyNnWI028giv6Z8s28AHHLsupmJeJdch5pEK+OagpID8d/yxu1tN2YaQWpWYtiXCB+6sgMh1WEcvpO4gtoL+wkAwwxc7CEbldmlJT7WH+7uvkrC2Jp8cqgbN/eN7oz7XtOK5XtyzE6lt6QhCXycG8w3SdRnI+HeJIX5qvypaC4MTVEWUCVFmdCJEqmeFsw4000wxlhOvwyt+65ZBbWGG+UqRidUAZzdbB7pQUwZKigwAAg6R0jmUW416bZIU1UvbFEYdXWx75qUNhr633tAwjp3BjQqKtqy32pOJcP319pVesBqB5SMo1e84gQEf5Cpiw/DLkcVGtkqPwv8YBF88arfWRbdSF50JdqviN7qZIeAZMbZAzZU3KPgAFS7aEZ+XmVCmvZvXSZ0OpTxjvt25lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(2616005)(5660300002)(8936002)(6512007)(2906002)(508600001)(186003)(6666004)(26005)(6506007)(53546011)(36756003)(66476007)(6486002)(4326008)(38100700002)(66556008)(110136005)(54906003)(316002)(8676002)(31696002)(83380400001)(31686004)(66946007)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2o3VXdsenpxekxZckphQUNHMEdkbW92WWlSSktRV01YTHd6WDkzTVhDbU1E?=
 =?utf-8?B?N0tkNnh5OGVDR01ndGEybHRGZ2VhcW9Ja0Y5VUpwOWVGSDBIU1plNi9tdXQy?=
 =?utf-8?B?Y2hhUXZXM3p3QU5NdXZSKzNCR2JZNWxDU0lkUkZaN2tuYU1rTVdzbXNtOHYx?=
 =?utf-8?B?UkdnQThCbTlmTU11bHpaSTdJcGRzUVJqTHZiWHNIU3FvVXlrVTZzRjVycHFv?=
 =?utf-8?B?eENDL2txSHFZZHVCNHZaSHVzL3Vzb0JoT1AzUEtKODRWQWhlOTN2c3phUm9O?=
 =?utf-8?B?VnVXdjZwM2dWWHpNMHZyNnhibEE0dER0Q0duR3VmNVZTd09KTWlDUE1GMURT?=
 =?utf-8?B?Q1pzc1AzK3RXMldqVG9BL0tHWkJIc052YjhPaVRBQ3JqU1hoZWNWTWRvd1hW?=
 =?utf-8?B?MjNYamdPN2lJcGU0WlRNRHBXQmg0elFJeFZteWlldkExR1VwNE5zWXNJWkFi?=
 =?utf-8?B?R3pJSEJRL3lqTk5nMjY1cXEzSTRGWGxGczduUjBVSWdPV0F3Y2Nldk1VbmZs?=
 =?utf-8?B?NWxOYnNGNzdwVnVxbk9sNTN0V3VETkZvUm50aC81TUZscWJHanZSdHVuU3RV?=
 =?utf-8?B?RkRJUDhkR1R5ZVNVWWdwVFVPL0ZhMUFpb0p4RWVJYlhWdFBlbDhnRDlqNzhN?=
 =?utf-8?B?Mzg2WEhWU1lIcDBjOUlmSE81QkQ5aS9LMWltWlB3UE4rNXl3RFM5RlVXbG96?=
 =?utf-8?B?eW9VUWlJZFhvNVBZaEJHbHc5TktwNXJGVDBTQzFzUTByTVhsQVN0TkdpT1Rq?=
 =?utf-8?B?bS91bW1IZXZoV2ZOblVWeEdHSWZoWit3cmprVVJORWREUUlpVEwrRGx1TXEv?=
 =?utf-8?B?ZFRwcUE5R0xLci9xb0IzY20rMjQ1UHlDWlM4Y0J3bzJEaVBHSUhNcHlBbGpZ?=
 =?utf-8?B?ZzlmTElFOFJxVFVxdEorYzFiWlh2TnhLRUYwZG5yK3RYNWVtUXVtbTMzUnRz?=
 =?utf-8?B?cTBPaUlJSHRDdTBXSWRYSWRXZ2RDenRUaG1XalFtNzNPSHVwVGlENSt4VzFI?=
 =?utf-8?B?TVpNUDc1L09RWjdLUTRWTjk2R2M1aitlSG1JWDQwaTNvSFEvL2RqSnA4YzNN?=
 =?utf-8?B?NmdsR2lWYU5FUlBiU1kyaktvVmFNZWdxNGNNa2d3UVFCQnNxelI3RjNOb2hz?=
 =?utf-8?B?TWZiV1NhK0poNkVlY3NsZkZ0UHdPa1hCT2F6MzFmempScFc3cXpkdDRsaGk3?=
 =?utf-8?B?cTBZa0swYmltNEJUZnJhMTg1dytUVlM4eXFoSVdPLzU0ZE1KalQzK25KYkhN?=
 =?utf-8?B?b2tMaG5xV2JMMXNJcnk2WU5wSUl3Tk5vRW5ZRHlkOGdHaFdsVDRwd1JQQXhT?=
 =?utf-8?B?ZS83c3lrRmY0TUxLZGxxeXdkMUtzbUJIZXkraVZ3eDhPWjdlSjArMmowT3lm?=
 =?utf-8?B?dU1QTTAwaFpaY3RXS1Fyak9FaGVFYWpPZU5WQmV4b3dXVitaRHJlSmhFTzc4?=
 =?utf-8?B?U2F4bDdPT0tWS3RJcEkySlUzMXh0RWs1L0FJUTlYQnplZnJKd0Z2K2F4cXdp?=
 =?utf-8?B?OHY0Mm5OWHlobklqUGE5T21FV0ZJY1ErRHEvSER1VzBnTnFCZ0V5VitpZ2Ix?=
 =?utf-8?B?YUtUcWtIWkMrQ25oTzhaNWZQV3BXb1JLQWNWUkRsa3FFNjBzcEg2bjUrU3Uz?=
 =?utf-8?B?Unc4SWNQT2ZIb3U0VGZRMmRJVDRpeHVWekZFZEpXUEhJbndKOTVibzMwSjZ5?=
 =?utf-8?B?QWlFY2F4RjJ1clg3dTVZQUtLTlE3WFJrUUJyRXJQVGxZVGpWYUtyQzZYNWxq?=
 =?utf-8?B?UTIzZ01kNDBUeUJKb1FhdXhQTWhDUG9YR3VWa0h2NDhhdkEwQ21IdWFwVTRx?=
 =?utf-8?B?T1lnaGdsNFNRT1hsVEhuMnpMYU9vcXJnTG1tbEgrLzBYTmFFRC9oQm9VZ0th?=
 =?utf-8?B?SzhUZkhORkxpOFBEampMczVsOCtaYUFDWDBJdHBSNVgzcFJhSXl2VHkxbUhm?=
 =?utf-8?B?azlTTHVOenN1MkdlYnZxWFY2S3k4ODNLR0J1M0FQNy84MUptTnFTUmx3ODRS?=
 =?utf-8?B?N3dMT0htMnl1Q2xVOFUrdGZwQkdJYXNnTGs1QWdYRXcyZWw4VFNTbURrSFJZ?=
 =?utf-8?B?RzMvWmJYWlJpS3Z0a1RmUE1XbVZYL2kzWnBrblB2SnFqTGc1NnNsRnRGZ0l5?=
 =?utf-8?B?S2V5bEx3eDEzbjVsczJDbExib2tNSDRQWUZnczRNUmJYQ3VEMGxCTVdvOXF6?=
 =?utf-8?Q?FXDYgRLfC6pM7kteIYxajlY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b2161a-3a09-4d35-9394-08d9c19eedc1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 20:50:58.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tE1iiOa1KG2gZItMUykPHCM0ryX87HoM130D3/XDeL3nBRxuVMX0dFqzyc9rW+1UouoZHI5exUCUKdmH83/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170116
X-Proofpoint-GUID: UA2Z8yGBPHXaU1CnP5O4uG0lcqhZjfuM
X-Proofpoint-ORIG-GUID: UA2Z8yGBPHXaU1CnP5O4uG0lcqhZjfuM
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/17/21 12:35 PM, Bruce Fields wrote:
> On Tue, Dec 14, 2021 at 11:41:41PM +0000, Chuck Lever III wrote:
>>
>>> On Dec 13, 2021, at 12:24 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> Add new callback, lm_expire_lock, to lock_manager_operations to allow
>>> the lock manager to take appropriate action to resolve the lock conflict
>>> if possible. The callback takes 2 arguments, file_lock of the blocker
>>> and a testonly flag:
>>>
>>> testonly = 1  check and return lock manager's private data if lock conflict
>>>               can be resolved else return NULL.
>>> testonly = 0  resolve the conflict if possible, return true if conflict
>>>               was resolved esle return false.
>>>
>>> Lock manager, such as NFSv4 courteous server, uses this callback to
>>> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
>>> (client that has expired but allowed to maintains its states) that owns
>>> the lock.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/locks.c         | 40 +++++++++++++++++++++++++++++++++++++---
>>> include/linux/fs.h |  1 +
>>> 2 files changed, 38 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/locks.c b/fs/locks.c
>>> index 3d6fb4ae847b..5f3ea40ce2aa 100644
>>> --- a/fs/locks.c
>>> +++ b/fs/locks.c
>>> @@ -952,8 +952,11 @@ void
>>> posix_test_lock(struct file *filp, struct file_lock *fl)
>>> {
>>> 	struct file_lock *cfl;
>>> +	struct file_lock *checked_cfl = NULL;
>>> 	struct file_lock_context *ctx;
>>> 	struct inode *inode = locks_inode(filp);
>>> +	void *res_data;
>>> +	void *(*func)(void *priv, bool testonly);
>>>
>>> 	ctx = smp_load_acquire(&inode->i_flctx);
>>> 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
>>> @@ -962,11 +965,24 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>>> 	}
>>>
>>> 	spin_lock(&ctx->flc_lock);
>>> +retry:
>>> 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
>>> -		if (posix_locks_conflict(fl, cfl)) {
>>> -			locks_copy_conflock(fl, cfl);
>>> -			goto out;
>>> +		if (!posix_locks_conflict(fl, cfl))
>>> +			continue;
>>> +		if (checked_cfl != cfl && cfl->fl_lmops &&
>>> +				cfl->fl_lmops->lm_expire_lock) {
>>> +			res_data = cfl->fl_lmops->lm_expire_lock(cfl, true);
>>> +			if (res_data) {
>>> +				func = cfl->fl_lmops->lm_expire_lock;
>>> +				spin_unlock(&ctx->flc_lock);
>>> +				func(res_data, false);
>>> +				spin_lock(&ctx->flc_lock);
>>> +				checked_cfl = cfl;
>>> +				goto retry;
>>> +			}
>>> 		}
>> Dai and I discussed this offline. Depending on a pointer to represent
>> exactly the same struct file_lock across a dropped spinlock is racy.
> Yes.  There's also no need for that (checked_cfl != cfl) check, though.
> By the time func() returns, that lock should be gone from the list
> anyway.

func() eventually calls expire_client. But we do not know if expire_client
succeeds. One simple way to know if the conflict client was successfully
expired is to check the list again. If the client was successfully expired
then its locks were removed from the list. Otherwise we get the same 'cfl'
from the list again on the next get.

-Dai

>
> It's a little inefficient to have to restart the list every time--but
> that theoretical n^2 behavior won't matter much compared to the time
> spent waiting for clients to expire.  And this approach has the benefit
> of being simple.
>
> --b.
>
>> Dai plans to investigate other mechanisms to perform this check
>> reliably.
>>
>>
>>> +		locks_copy_conflock(fl, cfl);
>>> +		goto out;
>>> 	}
>>> 	fl->fl_type = F_UNLCK;
>>> out:
>>> @@ -1136,10 +1152,13 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>>> 	struct file_lock *new_fl2 = NULL;
>>> 	struct file_lock *left = NULL;
>>> 	struct file_lock *right = NULL;
>>> +	struct file_lock *checked_fl = NULL;
>>> 	struct file_lock_context *ctx;
>>> 	int error;
>>> 	bool added = false;
>>> 	LIST_HEAD(dispose);
>>> +	void *res_data;
>>> +	void *(*func)(void *priv, bool testonly);
>>>
>>> 	ctx = locks_get_lock_context(inode, request->fl_type);
>>> 	if (!ctx)
>>> @@ -1166,9 +1185,24 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>>> 	 * blocker's list of waiters and the global blocked_hash.
>>> 	 */
>>> 	if (request->fl_type != F_UNLCK) {
>>> +retry:
>>> 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>> 			if (!posix_locks_conflict(request, fl))
>>> 				continue;
>>> +			if (checked_fl != fl && fl->fl_lmops &&
>>> +					fl->fl_lmops->lm_expire_lock) {
>>> +				res_data = fl->fl_lmops->lm_expire_lock(fl, true);
>>> +				if (res_data) {
>>> +					func = fl->fl_lmops->lm_expire_lock;
>>> +					spin_unlock(&ctx->flc_lock);
>>> +					percpu_up_read(&file_rwsem);
>>> +					func(res_data, false);
>>> +					percpu_down_read(&file_rwsem);
>>> +					spin_lock(&ctx->flc_lock);
>>> +					checked_fl = fl;
>>> +					goto retry;
>>> +				}
>>> +			}
>>> 			if (conflock)
>>> 				locks_copy_conflock(conflock, fl);
>>> 			error = -EAGAIN;
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index e7a633353fd2..8cb910c3a394 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -1071,6 +1071,7 @@ struct lock_manager_operations {
>>> 	int (*lm_change)(struct file_lock *, int, struct list_head *);
>>> 	void (*lm_setup)(struct file_lock *, void **);
>>> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>> +	void *(*lm_expire_lock)(void *priv, bool testonly);
>>> };
>>>
>>> struct lock_manager {
>>> -- 
>>> 2.9.5
>>>
>> --
>> Chuck Lever
>>
>>
