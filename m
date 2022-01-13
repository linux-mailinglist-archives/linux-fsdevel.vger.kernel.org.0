Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D77748DE61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiAMTvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 14:51:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54360 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbiAMTvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:51:52 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DIOHtY005670;
        Thu, 13 Jan 2022 19:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0Yufjm64LF89IDATWrvCeqUZJhoCFMs9mJXPo6TBEpo=;
 b=eV8/+TdKMX8L/w1FSLuNxAEPMK1t00SjJU4sZsQWcfk7t69Cn5c3a41WGwfMAypnEZEG
 KefZspamYeuBTLEXkA+N8ZQK34NRk6qPxJbVm2UtthLfXURbXpkEwbG65rTPFvA/m3mC
 68Q/ShJ2iztKlhbtvvp8/3iH0IMb6dmj5biZ6MSQRcjIf0FpdQjOXCPdLaMFcGge8VFO
 IT/5aLTjOa1CdxoAfgqmfgOkGkIjfP4B/MdXpAkGEiM/+UH0ZDlNNbKRQYWJs0+Pl/Gt
 GsLwVUUTRJUYQmOsk9brEnUi6B718UOySLAdFd3PEj0gxtSWtPFqXb2j5svdaXnYPltR 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djkwj9fpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 19:51:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DJo6JW066479;
        Thu, 13 Jan 2022 19:51:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3df2e8ay77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 19:51:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTsEmhwyGJHUi4xRxPL5ptfaMfp4f+TRwQzQfNKQ9mekPkcvSvELwLkFsOObyz3q9IpqV1DM0dCp7SptkKkVSLARapUA9jct1pI+Gs9eZO8ZrkI9F0SlgcTdhtHMDDflWolO9/VCdpRgFOi6uc6CeETDHipuJMxPSBz7Thih5rmWCHZ7tpgKX8xpt76qFPA1Bm3DGi8O6UVWmHAvJGn3W1eDMjdM8REN7mOqnPkJLF79c+I3nBIcFT8MdDoAAEDSQo9V7gI3BH2iDrKvWtLW7Hr1IRLQ2x94I6GmB11ATK2M1xkfK+PLkTcshGEyDTKn2tWnTHbpXRwJXMEoau5Pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Yufjm64LF89IDATWrvCeqUZJhoCFMs9mJXPo6TBEpo=;
 b=mtpg8IJZxF3qu4tSh/FlnJ9GPJyF5nI6rxJAc9+0WQSKqfUnIQPLbsvUhYLLjLKN8PRlugBY9WVefSoODCVCBlbLtbBuB2JDS7rV0WQahqsWz4rRKXWBtK7SzUaX89T5GMxYXJ+Q4RuLWDYQWJbysribaefbnabl4Jm8f75Y3+IkmMIaurIUzkJvH5wKfYkjDUZZD8yn0iDmm0ckoYHGFFnZbR9TT0WByOAuQFJdTZb9T7AQAVOdn8x83xqCe9QjuCKG+NTbQS4HCHCKRUyus0ZGJKp63PvlAWYiHgIJCiIBOY58JqJujdpGfUFfqfrzIffcCjbEbH6gKSTHn5QBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Yufjm64LF89IDATWrvCeqUZJhoCFMs9mJXPo6TBEpo=;
 b=K9zaimA3t/lv5BY/7uIrHn3+IrUEosj8yqYNnWt4VJTPoGbE+LuM4be93WI96ROYgDVQ2W2ZkYX4XUki7klxXHC+S6ZkfTlwS0rd/RuBPDFbmgFd2glNwHY/nfHsB777malM2p5NK3K6xIR1H6nLF2DN+8+7tuy1B8EAe1gXqhc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2872.namprd10.prod.outlook.com (2603:10b6:a03:89::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 19:51:45 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 19:51:45 +0000
Message-ID: <f4c9b6fa-ef75-55b0-53dc-4830d6aef94e@oracle.com>
Date:   Thu, 13 Jan 2022 11:51:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <1641840653-23059-3-git-send-email-dai.ngo@oracle.com>
 <20220112194054.GD10518@fieldses.org>
 <11e9d7a9-f2f3-47a9-c76f-dc2b9010d303@oracle.com>
 <20220113154206.GA32679@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220113154206.GA32679@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09487300-d674-4ddb-4c18-08d9d6ce20bd
X-MS-TrafficTypeDiagnostic: BYAPR10MB2872:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2872D4D8B8F93B75F9419F6F87539@BYAPR10MB2872.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vF/EliJYbiy6u9c+lryhrO95SAkrK4ZrfOeXTzu2NZuC+fuOM4S+IJTAHSqhsqMvRZzI7XkyZKVMJY65lS2/U8x9CmGfIW1EMufuYUW82nwj0fp3OwBwNCgwywPhJgfo6G0A9/jwPO9DWskckrDIwwObvMwL+OkRjThwefkpXbz74yMejc+ZAGkfxY8ARZYhBk2I1HiXq4NNU3PQ1hmiFjeeMTEmugIyCkcsE83MSAUyulHOD6ojnp69627KokDUE+VelA+kAZcVDKry+jwdoq6jPGi8RR93TnAL94f7u3W2twWYWU+S9ytaCqP+8LyO8XbbdiGwPpHMn9Av/cyN7lMC77MuC89Fh3/9IWeLPuCqdqYJHWY6RwK3DsjpmofSH3Mf4++ZGC96AuwVn1Asw3BSK9GM4UD+Qic+Iw5hctWBn1kNpLc0HiODZFGxv85uC38El7J+vw3v2QnBtQvFVBQKkMnld1pIOrbh6ek6Kf2AsVr7uXWVDnVINeDr09Ii9fI9VyABPi/hbx2tf79IaLBnExnF15Z5R1J8V+cm7REgJO5lKq2WsdzxUIRRb7pCSP1xOgdCzqKYxvsX9ezLoHsaLZVhKsgArzi0Pke7haXHCe0+ZctcPKwy38HDcNXxLioG1YalZQmgg8gWJVpwkIqjsujheEMOYFol7TnKr1Kw/o2J/io+ImOfQ5yquyc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(38100700002)(6486002)(6916009)(316002)(5660300002)(26005)(31686004)(4326008)(53546011)(6506007)(66476007)(86362001)(8676002)(186003)(66556008)(36756003)(8936002)(9686003)(83380400001)(6512007)(66946007)(2906002)(508600001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUV3dTNCVEhkbm43Z0VsWGRjMTFNMEx3c1ZYYkRib0YzTVlEM1Zjb0FRNUR4?=
 =?utf-8?B?Mk04bjNOWHROQzMzaU9RUHZJaCs1QitwYkdBQ0U5cFVPV01zUHdSWTlmMExy?=
 =?utf-8?B?TVE5K25HR2tiaTNLbElXZ2dJZlNsNjJnZEV0Y0VCTkwyajFTMDdKWHB3aHZj?=
 =?utf-8?B?THREQWVFZkkveGgxMDY1Uldrbnl5aEk0YURUVXRsUkpEY1ZxdWtHdzQ5VFFS?=
 =?utf-8?B?VVZUSjcrUG1yV21qQVk4bEpwbitvZ3FzVTl3NDFJSVkwVFg3OCs3R1N1Q1dQ?=
 =?utf-8?B?RStUa2h6bGRSS1hBaHFWOVNnbjYrd1VaWUhvZy8rQmR6aE5zSEV2M3U2cUV1?=
 =?utf-8?B?TjIvdFJJYVYwaUF0b3RCbGgzZHB3QUVGWmN2Q2ZPMDdqemJHbDc2bjZSejZK?=
 =?utf-8?B?M2ZlQjJJV040RCsxRDM5QnJMYjNNcjFrNmdLMnBVTGMxTjVMNHRWeFJUaTcv?=
 =?utf-8?B?V25xT1YvVC9RK092a0V3bkJTS0ZQSkhDZWlKUmdVVVNIY252TzBUYUxpSlVZ?=
 =?utf-8?B?MDhsYktkRncrdGFwL2x3dnpkQ3R5THJOa0dJSW8rVWxCL0dENVVrdHAzaWRO?=
 =?utf-8?B?U01QMHJMSi9qUW5HenVEV2xYWTMrUDV4M1N5ejhic0RaTjR6VHF1UFg0eHQ4?=
 =?utf-8?B?RTZuOFJXRHlNOEwrZjV6ZkQ5VzduRHFKRjd5TDdUZk5mcEVXOVRDL01TSWY4?=
 =?utf-8?B?TEcwZzNpdGswUm9HNWtpSytkanE4MnZXOXJyYlFnRDhXcmQ4Rm1iT1lrSmJj?=
 =?utf-8?B?cTY3eTQrVy9zbTFYaFFjNXdaREhKeGo5OGZqNGljVUlCU01hajdKYjlBaXM1?=
 =?utf-8?B?dkhjSnhuYVNQaVpyYnJ3SjZUSUhqUjRwUVh4WVh4MFdGR1lZTDV3UDNVNUNt?=
 =?utf-8?B?YTZKQ2ptem5YM1YwMzZGWWUzemZRY2JpVDhGZllMakF1Y3NIU1hWNzFlMEhk?=
 =?utf-8?B?SEgzR09rWU81NkVsT2xWbDRnQmZwSFh6VGEzd0plRjRFNEpuUXpUdGhCbkJa?=
 =?utf-8?B?MmJNdndFbXptVko0enZqUHhNWHA3RS84NnVXbFpGMkRHaGtLcWFnRHVqa2Vr?=
 =?utf-8?B?V3RGSUlmZlNjbTRoV0owcGdzUHJZN01RRUZQZVA0MjdBbWV3WGxia3dKK0Zx?=
 =?utf-8?B?bDJ0WEY4bkhMbEdXY1RMbTNKWWFpS3V6SEJvcWJpYm5aOTYrdzlVL0R2OXBF?=
 =?utf-8?B?Nm1vYUJnNCtMQlYrOTVFU3daaHpZYytYelBWZ0Znb1BpNWhpZEVqbCtDU1F0?=
 =?utf-8?B?Y0xjQkhMVm5JMDFhWXFFT2dlWndERVc5Y2k4R1BuTm5jY0VYWTFRVDQ5RHpa?=
 =?utf-8?B?UUk0Z1ZwQ3Z4YmhYQTB5M1pBazZYenRsbHZDbUY2RlcySzhFcUZSMzBFTlla?=
 =?utf-8?B?Qmc3dGQ2aHdlWG1MNFlpTXAyQmhaeEpUM3Z0M0hDTWtBTzgvODhsd2pGQ3o1?=
 =?utf-8?B?a0l0SjVRb1Q1MjRSaldqd3FIZ0JrOVdIbit5cHprdEJ6RGhSdXBoYmhXWHEz?=
 =?utf-8?B?VFJlTTdHTWhVdkkzU1RPTVBSYXN2cFpScWt2aW9DYXNCejg0QzMrN1Fodm14?=
 =?utf-8?B?VjNmc0xDRUFFUWp4bU1XdkpheGRBUHNuVHdrSWhIY0JOUzBHd3ZFeE1jQmRr?=
 =?utf-8?B?OGVyajZnU3Z3ZlYrMmJjbkI4WE4rUU5ZVzdCSjN3akhhR0FlQWN0dlduNnRz?=
 =?utf-8?B?aVE2OEpidlYxaEE5YUlnSXUzc3lTV3F4eWc1azM3b0JTajJiLzNVSzhmNUVE?=
 =?utf-8?B?VGVDektQRTZqeTBnVEp0SzdWczRkc2twVE1ZbjE5QlU4N29EUjhXR3JvQjFs?=
 =?utf-8?B?eVZJS2pmaEoxalVQWU5idzhybm04aW5QeHA5cXlWV1c4WEFQTmpKT2E0Qmp1?=
 =?utf-8?B?aG42Ui9hYnAzYVBJUEoxV0pJZDFMSk5HT3kxQjM2Q3VtL2FiRTIwWU9tc3Vx?=
 =?utf-8?B?RzlkNHFCOGtwVnlHbnFsMk5jUTlWZm9JM0pBVHZQVjVxY0M1QUx6MW9OYkFh?=
 =?utf-8?B?d0tSdWY0bGtyRHlnUXVNUXhxaEZzdHN3NmowVXdpNmF5UGZiaWlmV2xlTm1u?=
 =?utf-8?B?TlNpaUVIaVVVR1orcEFEalZKNlA0c2lKOWpLdExhRFNzWS9CS2dpSURKOG5Y?=
 =?utf-8?B?YmFZWklOVW1lcDNzeXBNcmlLNW96Vzkyb2pqWUMvWndHN1pJU2F5RC8zRzl4?=
 =?utf-8?Q?CWk3BmDDj4vh69I199lMB4w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09487300-d674-4ddb-4c18-08d9d6ce20bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 19:51:45.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzRTyrRUDv8bRsRDA0GzuT2JZhpL32P1bdUuzb9BM/W94gowA9zyvn2x8XRaX+QSV7PXQ1X7UKQ4+t5s3snDFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2872
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130124
X-Proofpoint-ORIG-GUID: h38XQxICEhO87J_pdNFahKEVgvlgSDyg
X-Proofpoint-GUID: h38XQxICEhO87J_pdNFahKEVgvlgSDyg
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/13/22 7:42 AM, J. Bruce Fields wrote:
> On Thu, Jan 13, 2022 at 12:51:57AM -0800, dai.ngo@oracle.com wrote:
>> On 1/12/22 11:40 AM, J. Bruce Fields wrote:
>>> On Mon, Jan 10, 2022 at 10:50:53AM -0800, Dai Ngo wrote:
>>>> +		}
>>>> +		if (!state_expired(&lt, clp->cl_time)) {
>>>> +			spin_unlock(&clp->cl_cs_lock);
>>>>   			break;
>>>> +		}
>>>> +		id = 0;
>>>> +		spin_lock(&clp->cl_lock);
>>>> +		stid = idr_get_next(&clp->cl_stateids, &id);
>>>> +		if (stid && !nfs4_anylock_conflict(clp)) {
>>>> +			/* client still has states */
>>> I'm a little confused by that comment.  I think what you just checked is
>>> that the client has some state, *and* nobody is waiting for one of its
>>> locks.  For me, that comment just conufses things.
>> will remove.
>>
>>>> +			spin_unlock(&clp->cl_lock);
>>> Is nn->client_lock enough to guarantee that the condition you just
>>> checked still holds?  (Honest question, I'm not sure.)
>> nfs4_anylock_conflict_locked scans cl_ownerstr_hashtbl which is protected
>> by the cl_lock.
> That doesn't answer the question.  Which, I confess, was muddled (I
> should have said "clp->cl_cs_lock", not "nn->client_lock".)
>
> Let me try it a different way.  You just checked that the client has
> some state, and that nobody is waiting for one of its locks.
>
> After you drop the cl_lock, how do you know that both of those things
> are still true?

After we drop the lock, if the client now has no state then it just
remains in memory until the courtesy client timeout expires then we
get rid of it.

For the race condition of lock conflict, we use the client->cl_cs_lock
to synchronize the laundromat and and lm_lock_conflict/nfsd4_fl_lock_conflict.
If the locking thread acquires the cl_cs_lock before the laundromat does
then the thread will be blocked and laundromat detects there is blocker
and expires the client. If the laundromat acquires the cl_cs_lock first
then NFSD4_COURTESY_CLIENT is set and nfsd4_fl_lock_conflict detects
this flag and sets the client to NFSD4_DESTROY_COURTESY_CLIENT.

-Dai

