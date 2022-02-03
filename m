Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367134A9107
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 00:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355940AbiBCXNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 18:13:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45458 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231451AbiBCXNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:13:44 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213L4H6R004636;
        Thu, 3 Feb 2022 23:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8QCs5Rnh17gYhN+2VXIj0h0y/A9NXk2aXX7aBgxJQ34=;
 b=lTkKLzmLZOQU1g61Z3LFv6xKH268pQ5o+06VK6RIVLSVt54tKOYHe+We0Ksf7rOpGPad
 iSUvn3d8PjAWLvZjkjRMGl6a6P0kXynfSRarfYmwp2PzjETntba0xGs1Ty9gudTYDTFR
 72JoWoBmqaWjmqwDEE5hfOMgAItulKfxbSs/plXWWmSK4XkD1OMqQQf0q3IoYc+JTJxq
 JjlkHbm7mrlI8t8Z9qKZvpAfAtlj5oHr5lwGNIVF5nejRwSpk/f54XxmmNXsA0LhjV7j
 EO/ZJtUfKP/twiEJ+caqMhIPK8/oTmVwktoLQ7alt0Y9+yKpHXcGQDugA5Si29cSZf78 SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hjr15nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 23:13:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213N6rn9090146;
        Thu, 3 Feb 2022 23:13:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3020.oracle.com with ESMTP id 3dvy1w19eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 23:13:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9nE3elSsu5ElRhasww00y3EOxNw8IsQNOQNsN6kw/WH9X5CWNygQPRMGfFoEeFlHcP1ksJMf28tC5OnBkeAaOkSrqulhf6iVXE0aaX9qtz8hQ2LCLAEm2fkdr+XPPby36HzRtaSD0FJguMbTX1R+0Vh13FwmCszm7EEZLFblG0zxMnV/Jk/6g8zi9sLeIru37iIN6A6BbaBeX81rXQh88/7acsW90IocDFWHecgNRc76tckX9ezot82oDBbh1Yj4PO3o57O46cXppFK6WrbQMylkW1ij/DBh/LYBdqIY1FuSJr5n8o1/gCurE9ZD6msT5x1K1iNXAsqu4Ai/H0G1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QCs5Rnh17gYhN+2VXIj0h0y/A9NXk2aXX7aBgxJQ34=;
 b=eatUgwB44CuN5lzAVUKFG9xiE5EjrvAOFfTqWSrsrNNLoULIFHV5q2RXKrSS2OrsgCfX76SIEDY6SNQJ8g8xwzL4HXIcuMeDAHoXbOGZlFNOyK7d+ftL884qUVFvPAb5dTEQWqqtq3nMNaJqgWkkZpOyu/PNFYaOyo1opdvE03+dBh+BZuUmPPEDjhvl/uSgKJL606UDYOvSAmfGsuo6zWYtt8nvSVLlYV19+ed7dPJnlmyCaiqRdBsKmzH5AZp6Nt5rgCbkImKNXUVzts5OMpq1A64jqdplwTrulKvtvdfllvNxBJjsJzqKuL240OYQ5UEupfRmeb2gZJfNEtpWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QCs5Rnh17gYhN+2VXIj0h0y/A9NXk2aXX7aBgxJQ34=;
 b=AvIBN03s1P+HPK4j9GLMurnOpbaWFtMX8jdxulT75l75deOasfzSZ88xfHy+GQDsfev29w7fNcfv0EM53OKFGz5J7VUXEK/MWxIB0SC/RT7QNI+qFEMJLqoADLSGWU8TFBsT3wSHvpU4uWMU7oTj5VAknNjqBqMdy4UqOPnUu50=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS7PR10MB5358.namprd10.prod.outlook.com (2603:10b6:5:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 23:13:36 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%6]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 23:13:36 +0000
Message-ID: <e662e67b-4091-ef33-eb1c-5dce7f1eaffc@oracle.com>
Date:   Thu, 3 Feb 2022 15:13:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH RFC 1/3] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Content-Language: en-US
To:     Jeff Layton <jlayton@redhat.com>, chuck.lever@oracle.com,
        bfields@fieldses.org
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
 <1643398773-29149-2-git-send-email-dai.ngo@oracle.com>
 <f02a73124a8372b9b12a1c3e0de785bcd73ddeb1.camel@redhat.com>
From:   dai.ngo@oracle.com
In-Reply-To: <f02a73124a8372b9b12a1c3e0de785bcd73ddeb1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::47) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e4779e2-6ae7-46b9-287c-08d9e76ace58
X-MS-TrafficTypeDiagnostic: DS7PR10MB5358:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB53582F82B6BF428FC3E0DA9C87289@DS7PR10MB5358.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ef3vTAM9WCqMbKGcSd7STwpSlApbUbt+23RWFYSeq+z09bNy/KZv3yFF6vp9ry2o3/0We23dATEigp5edQ0V3gpHqCanqDQz/+Beap/+L3C69QGcd1EwLWa3Zwx2U2TyENfDHq75nF0sW7zc6RmpOrigMyhbmo6gfAw7z9I6w0U+tPJnSqIRlooVmjDeYrQp86MCEBqSmuBpXssgOUOa9J2uBGF6NeNWKgiTm7rEGmaByJOpVU2RBiKQ4hWTfw9U707G9bWkaBEbGEH8tyuPZoYVL2CyzqzjTKLt/1wN2TcD9vHDGwTIhQBlp1yvmpj/un5XiOueCuEpTZAlHF4srDfgogqJVJKDu/wLeELtQuYybxOaBd3rPnoIk/yvQfhPiNuDJ4y3V/SBIbrNwMi+SvycgzwDMICGnu/eHiQ2G8Rp2viS0V32brGC7wBmoVvpqnsKGJO5D8VrxUhaq66qUiQTRVfCPS7A7OwBGiZ6cYCPqGQkBH0KfpuG2GxyYkPluQceIA9K2MFB88gHhXjtiImq/xF5zOSgb6/yjJa8KZ2SIotnC/UpsBaVI51wVnJri9tZkvUQxm29cEW5vaaLuvKWBjTXD5vsesX2bAHvvBfMZvz2XvGk9ilUNKMbrO6KytHRqI3eWhhlq8HrvVYhe71ci7mwtXHWkf75a9IQurd0dceus05r7G3/zWhuRivlYyaheMBfaqTqFdDpv1DODg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(31696002)(66556008)(5660300002)(66946007)(4326008)(8676002)(53546011)(6506007)(36756003)(8936002)(6512007)(9686003)(316002)(26005)(86362001)(186003)(2616005)(2906002)(38100700002)(6486002)(31686004)(83380400001)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek8rK3lYeTZEZHBzQXlEL1lGMGdYSUsvM0ZWcW1LeDVaS0hsZHFYT3g3Q09q?=
 =?utf-8?B?V1F5czlMMllMajIrL1V5c2lQWkRCb1hlZHVRQTR1Mlc1dnc3bmVDWG84L2h0?=
 =?utf-8?B?RmlSS0tXWm01ZjFyYnBwYW5GV1BjUnlmVnNGWWJqbGovblJzYktobWVUVHBT?=
 =?utf-8?B?MmxwdWd0UUt2TU5SMGhoT0UzVUhNSjk0UGEybDd4VjNsVTVrb3EyVHF1STcz?=
 =?utf-8?B?WVlxTGlPSjY0WXdTdERKaDVTQ2RGWHc1eTFUR1FnR3lmR0NIUW43OE9pcWlv?=
 =?utf-8?B?QTNDK3ltYm10ZEhuWTFCYnVzNEF0WlhJU3AvbTRITGlsTi9qNVNYTUdSazJl?=
 =?utf-8?B?YmlsN25scHJvMTZoOVBMemd3THpuVkcxeTBCc09kWDRXVEd2R29DOVdwZE5D?=
 =?utf-8?B?N3hscTRHdkhqZVk5T3I2ZGlmSDNOV0t3MTVMQUdHd2lrYlBZL0lQdS9JU1lR?=
 =?utf-8?B?WGNnME1zQUhDVlcxNGNpeExhSWpTOUM3TkdTa3RITUJGZ2hpWW5QUmdPL1dO?=
 =?utf-8?B?WThTZW1ET1FLWWdvZjF4UlUwWDhVdWRMa1ZRUis3cWtRZk9QVGdtZHNQRDdY?=
 =?utf-8?B?Z0I1UUhxSndURHl3bGhUWnFWSVc3ckRYK0doTkFKVmh0VW1YQlVNMXBja05E?=
 =?utf-8?B?RTBvMHYrcG82bktPeVZqRW5TR0JLZktFR25oNGVxUkdyaW9hdWdSbFJmMHg1?=
 =?utf-8?B?NWlEQUk4WWxYemFtWEEzOGU5bDhXdFMzRlpLdlpBTSthNDVmbDF6a3dnWlFC?=
 =?utf-8?B?UEt4eUtuODRIaVZIZmoreldPQ0RQYjZDSmFWMlkvZk1IL1hoYStLTHYyamZn?=
 =?utf-8?B?OHlVOUp0ZWFsYVphaDhlYmVaaGRwMFdKajNDUENycDNoTzJHN2p4OUpKSDY3?=
 =?utf-8?B?TXVGWTBOeCtIMU8zRFVlWWxkamZJSEpESjlXMHhZeDY4b3hsQ1dJbldYcUh3?=
 =?utf-8?B?RWFUempyWjNUaFBMcXdDZWJNMXhGT2hZWkhyZ1B0Sjg1RnZvUDlrYVZFdlNz?=
 =?utf-8?B?cnhpSUczRjYzcTNDeW45YVFVWmswVnFSTU5kYWNtWE5Eam1HbWVoTERGUUY0?=
 =?utf-8?B?TWNxdFNwQXdlYUZ5cTRmb2lVSHhrMmdzQ3lEUGh2Wk1MQng4K0lkWkFFVmR6?=
 =?utf-8?B?MTAxbVRZNW9LcU0xejh3bUxWNEVmOGxmV0dKVG5ib0M5ckdrNDBZSHdxSHlQ?=
 =?utf-8?B?NVNyQlUrS05sdmEwMzVWZU9yUzNweXRGS2s2RUdRcE4vZXZUN25KM3lkZ2pY?=
 =?utf-8?B?cGtZU25QViszRmI0ZlRLWktJU2VySWtuSS9BMkE3R3ZOS3Nob2RZaVR0WFVD?=
 =?utf-8?B?UjN2K0drdkZkcHh0K1Bld0ZTbEFwK0F3eWl2ODBvcVMwRFFEeXUxS3dyamJH?=
 =?utf-8?B?R2E2TnBwdWk1U3hDbFlZbFZSbWNnTHdINkh1Ty9sUkpaa3dFTnIvaG5VWXcr?=
 =?utf-8?B?ajE0R0dza2t6L3ZXSHViKzZGaGYvdy83SUNESlJFY1pFWGtBczQ0ZklKV2h4?=
 =?utf-8?B?dmlkQ1EwNGdNZDB3WE0xV1NhWENZMFY1UGVYZnNMeThOanhxdVdTTWs2UnR5?=
 =?utf-8?B?alFvZ0RLaVJLMThLTHlaamhUOGNPZUZNcEFxWnhjS3BTYnhiRnFGOGlTUVc2?=
 =?utf-8?B?UlVQWEVDb2hGM2svZURXNWNHR0dTYytKam9NSVhIbVN2U0ZzK0lUQjB2RGN4?=
 =?utf-8?B?bjNaRmJ2NWRadjhkZWFrTkJSemxlb3ozZVd2SEpFL0RaMUlML0wyWm1nT0ZJ?=
 =?utf-8?B?RFN4dUZUQW9kNkxjVHQ2a0M2UzNKaDAwMU9jVjMreVhSZDRCTUtGbGF0Qyth?=
 =?utf-8?B?Q2FtckJGSGhBajZsbkJIMzBlZXhKMHJlTjBYb2tKTUdxYmpXYnhMRngwNTY2?=
 =?utf-8?B?OHBFMnNQN2c0RFBjVzlTdXdKQ3dNVFdKYUhpZ3lYeUxjWUVoRDFzWVd2ankw?=
 =?utf-8?B?bFpkNDlKK3RwaGFEeWk4ZndjMnViK1F5bVN5eWZMaXIzTWIwSzM1SUEyMGg1?=
 =?utf-8?B?eTU4UWMwMDQzS2FDMys3REhNUjM3RE1JQ0habGJuZ0twaVpuUlEyRkVBcm0v?=
 =?utf-8?B?dDVCWENuSExrWXVsNkc1NUZZaUthbDYyNVdjeGZjaGFJYng4eDBacEFxV2Zv?=
 =?utf-8?B?VGZFZWtQTUtzOVEreE9UZ3Y0eHYraW13N1BEVXduTjY3dE9jOHJQMmg0UGtk?=
 =?utf-8?Q?I9/Ka7qnMpi2nh0OUttiGNY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4779e2-6ae7-46b9-287c-08d9e76ace58
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 23:13:36.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVw3mcPaHkxzglc5z4TdlylNbf2ubhDm4dnlLsBkKgOpUMpTR3ClXDQr3SlDv/kMzgIpgTw3vWps9cTMdaf1OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030139
X-Proofpoint-ORIG-GUID: BsqlwwcvHiSRBzeCMZEsl2J_FjFMkCCm
X-Proofpoint-GUID: BsqlwwcvHiSRBzeCMZEsl2J_FjFMkCCm
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/22 2:50 PM, Jeff Layton wrote:
> On Fri, 2022-01-28 at 11:39 -0800, Dai Ngo wrote:
>> Add new callback, lm_expire_lock, to lock_manager_operations to allow
>> the lock manager to take appropriate action to resolve the lock conflict
>> if possible. The callback takes 1 argument, the file_lock of the blocker
>> and returns true if the conflict was resolved else returns false. Note
>> that the lock manager has to be able to resolve the conflict while
>> the spinlock flc_lock is held.
>>
>> Lock manager, such as NFSv4 courteous server, uses this callback to
>> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
>> (client that has expired but allowed to maintains its states) that owns
>> the lock.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  2 ++
>>   fs/locks.c                            | 14 ++++++++++----
>>   include/linux/fs.h                    |  1 +
>>   3 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index d36fe79167b3..57ce0fbc8ab1 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -439,6 +439,7 @@ prototypes::
>>   	void (*lm_break)(struct file_lock *); /* break_lease callback */
>>   	int (*lm_change)(struct file_lock **, int);
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>> +	bool (*lm_lock_conflict)(struct file_lock *);
>>   
>>   locking rules:
>>   
>> @@ -450,6 +451,7 @@ lm_grant:		no		no			no
>>   lm_break:		yes		no			no
>>   lm_change		yes		no			no
>>   lm_breaker_owns_lease:	no		no			no
>> +lm_lock_conflict:       no		no			no
>>   ======================	=============	=================	=========
>>   
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 0fca9d680978..052b42cc7f25 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -853,10 +853,13 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>>   
>>   	spin_lock(&ctx->flc_lock);
>>   	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
>> -		if (posix_locks_conflict(fl, cfl)) {
>> -			locks_copy_conflock(fl, cfl);
>> -			goto out;
>> -		}
>> +		if (!posix_locks_conflict(fl, cfl))
>> +			continue;
>> +		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_conflict &&
>> +			!cfl->fl_lmops->lm_lock_conflict(cfl))
>> +			continue;
>> +		locks_copy_conflock(fl, cfl);
>> +		goto out;
>>   	}
>>   	fl->fl_type = F_UNLCK;
>>   out:
>> @@ -1059,6 +1062,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>>   		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>   			if (!posix_locks_conflict(request, fl))
>>   				continue;
>> +			if (fl->fl_lmops && fl->fl_lmops->lm_lock_conflict &&
>> +				!fl->fl_lmops->lm_lock_conflict(fl))
>> +				continue;
> The naming of this op is a little misleading. We already know that there
> is a lock confict in this case. The question is whether it's resolvable
> by expiring a tardy client. That said, I don't have a better name to
> suggest at the moment.

I will leave it as is for now.

>
> A comment about what this function actually tells us would be nice here.

will do in v11.

Thanks,
-Dai

>
>>   			if (conflock)
>>   				locks_copy_conflock(conflock, fl);
>>   			error = -EAGAIN;
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index bbf812ce89a8..21cb7afe2d63 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1068,6 +1068,7 @@ struct lock_manager_operations {
>>   	int (*lm_change)(struct file_lock *, int, struct list_head *);
>>   	void (*lm_setup)(struct file_lock *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>> +	bool (*lm_lock_conflict)(struct file_lock *cfl);
>>   };
>>   
>>   struct lock_manager {
> Acked-by: Jeff Layton <jlayton@redhat.com>
>
