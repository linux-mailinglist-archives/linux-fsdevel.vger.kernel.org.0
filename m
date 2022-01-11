Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3957A48A4AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 02:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbiAKBD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 20:03:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43784 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243286AbiAKBDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:03:53 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B0C3b4030658;
        Tue, 11 Jan 2022 01:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jNxlIFNAejpAbx6hTybv84n3mzyHrn0TFymjkfheCAc=;
 b=jFjcQAfvAMKGOjUgMm2qtfA/UMOPros8AqoPlCSjJ2yU6aEyJyBUdgqhhWgNLga+TiqS
 WWiHsZSaPTqADabYeG1oQUKqgl1i5HQMY4cHv4BjbqoJF38RoCllyoBkubXsim66nUz9
 xrmXZjMe6UcwHyViA6c4BSx2ZqHBIBo70EbYxFde0Doi0OdGxOz877X33Uy82Bp195sU
 5x5l1iP0yE75TlLGFpfdgzHCsAxXd4kHZ3h2QLMDqYQj/jkrYoL66RIcMsy9G2aRUSPy
 WLMzW9Clu9WsYU+oa/5lS7XijvMPVTWQNqLSzRPX9ii27tYcoE/nwQYHtBIipDIoDn/N HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn749pkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 01:03:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B0oQqg144098;
        Tue, 11 Jan 2022 01:03:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 3df0ndb9b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 01:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERHwP6qR0fckzscoazY01CrXALyP/a9DccAD9/tUiCvhvOqHr/FAJWlp5Zj1XRuLUvo/DdHMQNjFun9mRK3SpfedBsnPti9VtxxmbWFl2VM/3UKvoWTZl1S4SO+SQ+/AqxK5leYarIw5RxeQhrFKkXv2wPOdJ1C8js5qQlaFm+EhMQ9GVjJZT7xg1JDDGs+x4g5L+MzFsRNot7pffOtjtRRmadJ+O8+WgsGVBBLe9FtKIHElBT6exfwROttInCFhtHJ705O3aRYjh5bYZYlIvSvKGusMEztjKERZZZeQjuPTd1QgbY6cihJezIPX4HZK7YHbZtvY3O+M0KdDjzbUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNxlIFNAejpAbx6hTybv84n3mzyHrn0TFymjkfheCAc=;
 b=dfxl3QyqIjDU0nVvlwsMgu+afAQQabtE+Ain6aH3s1n17Cmcl09CXUuW//HBPNwQ/TLVriZXsLazyBrGMqzr+4M+x9eNWTGNC1bJraPv0GTV4Vrh6jdwFGp26xfSRXZmJ5VGEvv/TMj07/+3wf6+UEd2duXCB5K/iAyy/9pqcHjS+00DCmumRWbP7jk3Xxn2yIow7IrphVLXdJQgm0bH+hMy0MpFwhsNAbzEPJVjYVMOyR1PJZStXy6gp2zJ0A9+VFgAysttCXLziF+7a3Q+VHnzq1NEXuTZbPpufi3RWc+cqWMI44vbeM6vcJ2nKhPLIC4Hp5Iyy8nXYz10H+hm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNxlIFNAejpAbx6hTybv84n3mzyHrn0TFymjkfheCAc=;
 b=LQ8/IGq44n70KDPhTHOhvr/Zuj9PI1r8uW8heahLppLA6UUyY7ZEkuYqDQIOv339MgaEFD15dlz/g7B/KwDBiIAna4RyArS/47ChY9jouULMY8CevlDZFfgbxy6vMa9CcpR2HBe/d9yYN7Jvfc6r8wpbFjZgFJUPJhe9NW7gEHE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 01:03:45 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29%7]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:03:45 +0000
Message-ID: <f5ba01ea-33e8-03e9-2cee-8ff7814abceb@oracle.com>
Date:   Mon, 10 Jan 2022 17:03:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <1641840653-23059-3-git-send-email-dai.ngo@oracle.com>
 <E70D7FE7-59BA-4200-BF31-B346956C9880@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <E70D7FE7-59BA-4200-BF31-B346956C9880@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4567427-4a40-4daf-2ed4-08d9d49e375f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4478:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB447864205DAB3B55C5AB012387519@SJ0PR10MB4478.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUtys08q/JZJgOwQ43i2WqhkC0Mtb+U7sHk8HVZswmQ7b8XeWXDnrFHT5tIXzdUr880p4QYUYJ4k9N4NDE6HC77y0dDXsJIYF5phhhi6MQEaRn5sUNrWJEdSJDCbZjONSXag4q09TrlFAAs7Ohdr7NM1eehEI3+AOTjUHYxjt1qKaHzhJSZ2wiybz98+zePqc7YqBvPt21fyOETCCUmxVdQsWyCdyRzXVgzCo9kVTCTJL4Q+Q74D6GsESFhFhG9xIDzolT4sb8aGX/VECehco5nEAuyBVyPX8t9et5lONSh1JJOojDbhHWVkB+yPBhuGLHQOgYIhFOO8pSJDev3VM6B5WW2HceSfqEAguNEjPopD3TqxaCbczhy/gdwSBnQ8gCpcGUja6NGfNa9uU9ivf2kcpjoj40Jm5ZvhfB4isABFsvUT4zgHzXHUvArY8C260bnPIhhU/iYfd2+0qS5Yp8kcO9tMnqq5YsSruE8vwvxpChx3CNFjZ1pf9z3Yg5rgkthrJVufu72MuYVhu31CAyFJGFFfI6Ye4Zc/NcbW1017hU+ApxjFIa2EGaBeik5dsd97DJi2tLbV6hcNso5x/g8M+9NWRA1r+FE85sC5U25+YE+iZvxyWMxK5dCYt+HkpfX34aCBrxhbwuZagPqR8YhTKflum58pD+WHV80OWvdflIM+3ckMAClMOFXvnBxce0ozbHWbQ5KrMdzMyzVTXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(36756003)(54906003)(5660300002)(8936002)(83380400001)(86362001)(6486002)(66476007)(508600001)(66556008)(4326008)(37006003)(8676002)(38100700002)(31686004)(316002)(2616005)(6862004)(6666004)(9686003)(6506007)(6512007)(66946007)(53546011)(31696002)(30864003)(26005)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjBTMmR6cy9GdC9sWE03Rm9RbVI1UU9haDEzZ2lmSEZzRjROS2pKL2pub0Zy?=
 =?utf-8?B?V0YzOVZjTkU3ZzlVdTJ6UGk3SGkvU3lOa1VHR1htVDNuUS8xakxJTTF0N0tO?=
 =?utf-8?B?aitMbE16TmpZcmlvWEhUUVJ5R0V4V2MwdkR3RTBjaWVqMkVuMEorN2xTYmlr?=
 =?utf-8?B?bWZkUkE5enF1UkdxMG5NakR6a0U3WmVjMUs3cmJzU0QwQlhVSmdYZS9HTmxH?=
 =?utf-8?B?R2owYWpoSHhaWGNIcEVteTJZTFRnUnFueXVBY1FxZWVHeFN1WkpNblZ4L1lp?=
 =?utf-8?B?elVxVVkwVVJOQXlXb29HRkpyWml2RUhmUFZ5QWx6WDQ3UTJBVzJ0cTNCYi9R?=
 =?utf-8?B?b3ZaZkdjTWdkZk9oWE9IVmt2VXVvS0RzamVMTFhuS3NTNHZxSUZtT0labWRp?=
 =?utf-8?B?WU9IWjJ5Q0NtdUVjcnRVNXBsTGVVNEpEV0hpUEdMbUZMZ3RWSzF2WmlzR1o0?=
 =?utf-8?B?UG8vOFN0clRRVFY3dzFYdGRUa0dUS0IxeVJLeU5hdHBSdHp0a2ExZHYrenZU?=
 =?utf-8?B?c0lwRC80K21hY0NqenFEalFjSU52d1loWE5BUnJicEdNMExBZURrNldQUVRJ?=
 =?utf-8?B?VHVaNmJhcnZORlFzQzB1aExreXJZbFNlbGxHZjV1anNzWHROdk9tSTEwSE4v?=
 =?utf-8?B?d09NRDdKd3NzeUJVTkRzZ2FTOVo5VkVaV0JXLytVOTFvQVdZenBXaDlVZWxi?=
 =?utf-8?B?ZVEwRGlZVnRCWjRNbTY1Uy9qOU1oZFNGdStPVTFxWXExRWRBOE5FbFVVQUY2?=
 =?utf-8?B?cng2VUkrYzg2VWVvYkJWcTFvWXBxVFR5WkNtNmxGQUw1NDA5VVhSSG5WRmp2?=
 =?utf-8?B?WEpkLzNlODBPNnpuQzlFdGtGMEVrSmFOV1Nkcm41VW5YK0JGYnRoWGJPL0Zv?=
 =?utf-8?B?K3Y4QU5EVkxCc0Z2Y1ZjdUxod0RkUVlibjlwbnBKQkhTUWVQREIvSTF0K0xo?=
 =?utf-8?B?WXJod3hXYVU5WGNWRklXaHN6bmNndWEvVFkwcEsrUE5SYkNRdENQUmdvWDVw?=
 =?utf-8?B?SURpaEJxZVlCd1BYQ1lKVUZ1d2FlZjg3ZFdJY2hTaWdQd0hxQzhFUThWZmJD?=
 =?utf-8?B?d0dWc0xYNkgrWnRlMnYyeW5WbnNuTEIwTE5tNEpNQ1pEWTIzbzI4UkMwcDBw?=
 =?utf-8?B?RUhRdW8vc3Z4V0hpdmtLVFhwdm9JWlhiODhNbDdnK3UwU0VoOU9QVnVzK0Rp?=
 =?utf-8?B?dzhMTzJYTGREU0hNTzRkNi9OUnJSYUZTNWFNZS8zeFRicE5xdFhSb1RualM2?=
 =?utf-8?B?WkFLbDJnbkNBaGZYOElWQ2NHVko0Vm9rZ3NueDRIdzR2amVUTUZ3ZERvOFpP?=
 =?utf-8?B?eUpPa0xmNS9ZSUphekxlZkdyc2VYdEsrQ1Q2NzRFaWk2M25aZ3Bwb3V0QkM4?=
 =?utf-8?B?WnRRWGV6WXFFRnpudGVhNHF5V0VTQlE3Y0xWa1pzcHpqbmRNZnRoaGMzSVBS?=
 =?utf-8?B?VzB5eHNQSTNUR2dFd2puWk9xaFBFQ05CN21rQlJrSGJWUzAxRmVuUFBObUN6?=
 =?utf-8?B?blUxVlZTM1JVakJKTzRXVmVLUVB1bmNTUXp3eGdxV1JtYkZtdDRNZU9WOHlp?=
 =?utf-8?B?S1RtTTBoMDM4VXBnL3p4RGNLWUhzY0dIRkl4RkpMMHpzSG1HUCtzYlBOaGhh?=
 =?utf-8?B?Tk9iZi9TSktVMENHd0dySEhCT1NwNFdWN3hXR1BiNGhQdDVUNEpNRmhSZUdv?=
 =?utf-8?B?b2R4S2prRmZZN25tZUcyYlRyb1FkdHFId0VoamJaQWhEWWg4NDd2b2tSTFlM?=
 =?utf-8?B?aWhQdGVZSWh0WSs2cFNRWjVqOGI4TmYwQk1ZQmFxakJvRnk1TTROZU8rNVBX?=
 =?utf-8?B?QTBNY2IvVDYrZGhyeFNqZEZvdHBLQ0VtbTlrb2JLY2RpY0NWUFUvNjJTVlFX?=
 =?utf-8?B?dHFLL0t0enU1RUM3ZjkzYjJVVmQ0Vi9JeWM3RWswNmx5cWtHS3dicWdxRHJw?=
 =?utf-8?B?bExuSVFTR0g0Y3N3bkEzczZPSzNIK2JQT1hMTmZtb29VUXZiQmVrcHBZNm1q?=
 =?utf-8?B?a3NwaDFycGN3QXBWRytFWm1CSjA3UmpyUFQvdSs2ZUhPalF5OWlyOExvZ05J?=
 =?utf-8?B?MlIxZ3p4VUhFN2VDNWowcUd5YmNpOUpnUkF5QU9SWHVWZFJaNVlINXFIZjhH?=
 =?utf-8?B?eUExWlczNGVyZ05RcEFzM1l1QTgwRjFqL2lNbHhya2puUUZYRkxqQmhUa1dy?=
 =?utf-8?Q?Pe0F3tJ0HpVWTotHg/aIVwE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4567427-4a40-4daf-2ed4-08d9d49e375f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:03:45.0898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN9lPiAOTS1dXCf6gENk6Af661sIUqIvbpEyDxPFyBNWQD6GZjr3BZ+wDgqrUTqBCQVMiXVifpvnzDTcob+oeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4478
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110001
X-Proofpoint-ORIG-GUID: Te8iYju0Qxg-IQcp4MeG7FKpArKScM51
X-Proofpoint-GUID: Te8iYju0Qxg-IQcp4MeG7FKpArKScM51
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you Chuck for your review, please see reply below:

On 1/10/22 3:17 PM, Chuck Lever III wrote:
> Hi Dai-
>
> Still getting the feel of the new approach, but I have
> made some comments inline...
>
>
>> On Jan 10, 2022, at 1:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Currently an NFSv4 client must maintain its lease by using the at least
>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
>> a singleton SEQUENCE (4.1) at least once during each lease period. If the
>> client fails to renew the lease, for any reason, the Linux server expunges
>> the state tokens immediately upon detection of the "failure to renew the
>> lease" condition and begins returning NFS4ERR_EXPIRED if the client should
>> reconnect and attempt to use the (now) expired state.
>>
>> The default lease period for the Linux server is 90 seconds.  The typical
>> client cuts that in half and will issue a lease renewing operation every
>> 45 seconds. The 90 second lease period is very short considering the
>> potential for moderately long term network partitions.  A network partition
>> refers to any loss of network connectivity between the NFS client and the
>> NFS server, regardless of its root cause.  This includes NIC failures, NIC
>> driver bugs, network misconfigurations & administrative errors, routers &
>> switches crashing and/or having software updates applied, even down to
>> cables being physically pulled.  In most cases, these network failures are
>> transient, although the duration is unknown.
>>
>> A server which does not immediately expunge the state on lease expiration
>> is known as a Courteous Server.  A Courteous Server continues to recognize
>> previously generated state tokens as valid until conflict arises between
>> the expired state and the requests from another client, or the server
>> reboots.
>>
>> The initial implementation of the Courteous Server will do the following:
>>
>> . when the laundromat thread detects an expired client and if that client
>> still has established states on the Linux server and there is no waiters
>> for the client's locks then mark the client as a COURTESY_CLIENT and skip
>> destroying the client and all its states, otherwise destroy the client as
>> usual.
>>
>> . detects conflict of OPEN request with COURTESY_CLIENT, destroys the
>> expired client and all its states, skips the delegation recall then allows
>> the conflicting request to succeed.
>>
>> . detects conflict of LOCK/LOCKT, NLM LOCK and TEST, and local locks
>> requests with COURTESY_CLIENT, destroys the expired client and all its
>> states then allows the conflicting request to succeed.
>>
>> . detects conflict of LOCK/LOCKT, NLM LOCK and TEST, and local locks
>> requests with COURTESY_CLIENT, destroys the expired client and all its
>> states then allows the conflicting request to succeed.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>> fs/nfsd/state.h     |   8 ++
>> 2 files changed, 323 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 3f4027a5de88..e7fa4da44835 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -125,6 +125,11 @@ static void free_session(struct nfsd4_session *);
>> static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>> static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>
>> +static struct workqueue_struct *laundry_wq;
>> +static void laundromat_main(struct work_struct *);
>> +
>> +static const int courtesy_client_expiry = (24 * 60 * 60);	/* in secs */
>> +
>> static bool is_session_dead(struct nfsd4_session *ses)
>> {
>> 	return ses->se_flags & NFS4_SESSION_DEAD;
>> @@ -155,8 +160,10 @@ static __be32 get_client_locked(struct nfs4_client *clp)
>> 	return nfs_ok;
>> }
>>
>> -/* must be called under the client_lock */
>> +/* must be called under the client_lock
>> static inline void
>> +*/
>> +void
>> renew_client_locked(struct nfs4_client *clp)
>> {
>> 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> @@ -172,7 +179,9 @@ renew_client_locked(struct nfs4_client *clp)
>>
>> 	list_move_tail(&clp->cl_lru, &nn->client_lru);
>> 	clp->cl_time = ktime_get_boottime_seconds();
>> +	clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> }
>> +EXPORT_SYMBOL_GPL(renew_client_locked);
> I don't see renew_client_locked() being called from outside
> fs/nfsd/nfs4state.c, and the patch doesn't add a global
> declaration.
>
> Please leave this function as "static inline void".

Fix in v10. I did it for debugging and forgot to remove it.
Test robot also reported the problem.

>
>
>> static void put_client_renew_locked(struct nfs4_client *clp)
>> {
>> @@ -1912,10 +1921,22 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>> {
>> 	struct nfsd4_session *session;
>> 	__be32 status = nfserr_badsession;
>> +	struct nfs4_client *clp;
>>
>> 	session = __find_in_sessionid_hashtbl(sessionid, net);
>> 	if (!session)
>> 		goto out;
>> +	clp = session->se_client;
>> +	if (clp) {
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			session = NULL;
>> +			goto out;
>> +		}
>> +		clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +		spin_unlock(&clp->cl_cs_lock);
>> +	}
>> 	status = nfsd4_get_session_locked(session);
>> 	if (status)
>> 		session = NULL;
>> @@ -1992,6 +2013,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>> 	INIT_LIST_HEAD(&clp->async_copies);
>> 	spin_lock_init(&clp->async_lock);
>> 	spin_lock_init(&clp->cl_lock);
>> +	spin_lock_init(&clp->cl_cs_lock);
>> 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>> 	return clp;
>> err_no_hashtbl:
>> @@ -2389,6 +2411,10 @@ static int client_info_show(struct seq_file *m, void *v)
>> 		seq_puts(m, "status: confirmed\n");
>> 	else
>> 		seq_puts(m, "status: unconfirmed\n");
>> +	seq_printf(m, "courtesy client: %s\n",
>> +		test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ? "yes" : "no");
>> +	seq_printf(m, "seconds from last renew: %lld\n",
>> +		ktime_get_boottime_seconds() - clp->cl_time);
>> 	seq_printf(m, "name: ");
>> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>> @@ -2809,8 +2835,17 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>> 			node = node->rb_left;
>> 		else if (cmp < 0)
>> 			node = node->rb_right;
>> -		else
>> -			return clp;
>> +		else {
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (!test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
>> +					&clp->cl_flags)) {
>> +				clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				return clp;
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			return NULL;
>> +		}
>> 	}
>> 	return NULL;
>> }
>> @@ -2856,6 +2891,14 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
>> 		if (same_clid(&clp->cl_clientid, clid)) {
>> 			if ((bool)clp->cl_minorversion != sessions)
>> 				return NULL;
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				continue;
>> +			}
>> +			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +			spin_unlock(&clp->cl_cs_lock);
> I'm wondering about the transition from COURTESY to active.
> Does that need to be synchronous with the client tracking
> database?

Currently when the client transits from active to COURTESY,
we do not remove the client record from the tracking database
so on the reverse we do not need to add it back.

I think this is something you and Bruce have been discussing
on whether when we should remove and add the client record from
the database when the client transits from active to COURTESY
and vice versa. With this patch we now expire the courtesy clients
asynchronously in the background so the overhead/delay from
removing the record from the database does not have any impact
on resolving conflicts.

>> 			renew_client_locked(clp);
>> 			return clp;
>> 		}
>> @@ -4662,6 +4705,36 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>> 	nfsd4_run_cb(&dp->dl_recall);
>> }
>>
>> +/*
>> + * This function is called when a file is opened and there is a
>> + * delegation conflict with another client. If the other client
>> + * is a courtesy client then kick start the laundromat to destroy
>> + * it.
>> + */
>> +static bool
>> +nfsd_check_courtesy_client(struct nfs4_delegation *dp)
>> +{
>> +	struct svc_rqst *rqst;
>> +	struct nfs4_client *clp = dp->dl_recall.cb_clp;
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +
>> +	if (!i_am_nfsd())
>> +		goto out;
>> +	rqst = kthread_data(current);
>> +	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
>> +		return false;
>> +out:
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +		set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> I'm not sure what is the purpose of the mod_delayed_work()
> here and below. What's the harm in leaving a DESTROYED
> nfs4_client around until the laundromat runs again? Won't
> it run every "grace period" seconds anyway?

I think this is a good idea. With the new approach of destroying
courtesy clients asynchronously in the background, I also don't
see a need to kick start the laundromat to run immediately. I will
make this change in v10 and make sure it works as expected.

>
> I didn't think we were depending on the laundromat to
> resolve edge case races, so if a call to a scheduler
> function isn't totally necessary in this code, I prefer
> that it be left out.
>
>
>> +		return true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return false;
>> +}
>> +
>> /* Called from break_lease() with i_lock held. */
>> static bool
>> nfsd_break_deleg_cb(struct file_lock *fl)
>> @@ -4670,6 +4743,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>> 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>> 	struct nfs4_file *fp = dp->dl_stid.sc_file;
>>
>> +	if (nfsd_check_courtesy_client(dp))
>> +		return false;
>> 	trace_nfsd_cb_recall(&dp->dl_stid);
>>
>> 	/*
>> @@ -4912,7 +4987,128 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>> }
>>
>> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> +static bool
>> +__nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
>> +			bool share_access)
>> +{
>> +	if (share_access) {
>> +		if (!stp->st_deny_bmap)
>> +			return false;
>> +
>> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
>> +			(access & NFS4_SHARE_ACCESS_READ &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
>> +			(access & NFS4_SHARE_ACCESS_WRITE &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
>> +			return true;
>> +		}
>> +		return false;
>> +	}
>> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
>> +		(access & NFS4_SHARE_DENY_READ &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
>> +		(access & NFS4_SHARE_DENY_WRITE &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * Check all files belong to the specified client to determine if there is
>> + * any conflict with the specified access_mode/deny_mode of the file 'fp.
>> + *
>> + * If share_access is true then 'access' is the access mode. Check if
>> + * this access mode conflicts with current deny mode of the file.
>> + *
>> + * If share_access is false then 'access' the deny mode. Check if
>> + * this deny mode conflicts with current access mode of the file.
>> + */
>> +static bool
>> +nfs4_check_access_deny_bmap(struct nfs4_client *clp, struct nfs4_file *fp,
>> +		struct nfs4_ol_stateid *st, u32 access, bool share_access)
>> +{
>> +	int i;
>> +	struct nfs4_openowner *oo;
>> +	struct nfs4_stateowner *so, *tmp;
>> +	struct nfs4_ol_stateid *stp, *stmp;
>> +
>> +	spin_lock(&clp->cl_lock);
>> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
>> +					so_strhash) {
>> +			if (!so->so_is_open_owner)
>> +				continue;
>> +			oo = openowner(so);
>> +			list_for_each_entry_safe(stp, stmp,
>> +				&oo->oo_owner.so_stateids, st_perstateowner) {
>> +				if (stp == st || stp->st_stid.sc_file != fp)
>> +					continue;
>> +				if (__nfs4_check_access_deny_bmap(stp, access,
>> +							share_access)) {
>> +					spin_unlock(&clp->cl_lock);
>> +					return true;
>> +				}
>> +			}
>> +		}
>> +	}
>> +	spin_unlock(&clp->cl_lock);
>> +	return false;
>> +}
>> +
>> +/*
>> + * This function is called to check whether nfserr_share_denied should
>> + * be returning to client.
>> + *
>> + * access: is op_share_access if share_access is true.
>> + *	   Check if access mode, op_share_access, would conflict with
>> + *	   the current deny mode of the file 'fp'.
>> + * access: is op_share_deny if share_access is true.
>> + *	   Check if the deny mode, op_share_deny, would conflict with
>> + *	   current access of the file 'fp'.
>> + * stp:    skip checking this entry.
>> + *
>> + * Function returns:
>> + *	true  - access/deny mode conflict with courtesy client(s).
>> + *		Caller to return nfserr_jukebox while client(s) being expired.
>> + *	false - access/deny mode conflict with non-courtesy client.
>> + *		Caller to return nfserr_share_denied to client.
>> + */
>> +static bool
>> +nfs4_conflict_courtesy_clients(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_client *cl;
>> +	bool conflict = false;
>> +	int async_cnt = 0;
>> +	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_entry(cl, &nn->client_lru, cl_lru) {
>> +		if (!nfs4_check_access_deny_bmap(cl, fp, stp, access, share_access))
>> +			continue;
>> +		spin_lock(&cl->cl_cs_lock);
>> +		if (test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
>> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
>> +			async_cnt++;
> You can get rid of async_cnt. Just set conflict = true
> after unlocking cl_cs_lock. And again, maybe that
> mod_delayed_work() call site isn't necessary.

fix in v10.

>
>
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		/* conflict with non-courtesy client */
>> +		spin_unlock(&cl->cl_cs_lock);
>> +		conflict = false;
>> +		break;
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +	if (async_cnt) {
>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +		conflict = true;
>> +	}
>> +	return conflict;
>> +}
>> +
>> +static __be32
>> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> 		struct nfsd4_open *open)
>> {
>> @@ -4931,6 +5127,11 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 	status = nfs4_file_check_deny(fp, open->op_share_deny);
>> 	if (status != nfs_ok) {
>> 		spin_unlock(&fp->fi_lock);
>> +		if (status != nfserr_share_denied)
>> +			goto out;
>> +		if (nfs4_conflict_courtesy_clients(rqstp, fp,
>> +				stp, open->op_share_deny, false))
>> +			status = nfserr_jukebox;
>> 		goto out;
>> 	}
>>
>> @@ -4938,6 +5139,11 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 	status = nfs4_file_get_access(fp, open->op_share_access);
>> 	if (status != nfs_ok) {
>> 		spin_unlock(&fp->fi_lock);
>> +		if (status != nfserr_share_denied)
>> +			goto out;
>> +		if (nfs4_conflict_courtesy_clients(rqstp, fp,
>> +				stp, open->op_share_access, true))
>> +			status = nfserr_jukebox;
>> 		goto out;
>> 	}
>>
>> @@ -5572,6 +5778,47 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>> }
>> #endif
>>
>> +static
>> +bool nfs4_anylock_conflict(struct nfs4_client *clp)
> This function assumes the caller holds cl_lock. That bears
> mentioning here in a comment. Convention suggests adding
> "_locked" to the function name too, just like
> renew_client_locked() above.

fix in v10.

>
> Also, nit: kernel style is either:
>
> static bool
> nfs4_anylock_conflict(
>
> or
>
> static bool nfs4_anylock_conflict(

fix in v10.

>
>
>> +{
>> +	int i;
>> +	struct nfs4_stateowner *so, *tmp;
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_ol_stateid *stp;
>> +	struct nfs4_file *nf;
>> +	struct inode *ino;
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +
>> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>> +		/* scan each lock owner */
>> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
>> +				so_strhash) {
>> +			if (so->so_is_open_owner)
>> +				continue;
>> +
>> +			/* scan lock states of this lock owner */
>> +			lo = lockowner(so);
>> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
>> +					st_perstateowner) {
>> +				nf = stp->st_stid.sc_file;
>> +				ino = nf->fi_inode;
>> +				ctx = ino->i_flctx;
>> +				if (!ctx)
>> +					continue;
>> +				/* check each lock belongs to this lock state */
>> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>> +					if (fl->fl_owner != lo)
>> +						continue;
>> +					if (!list_empty(&fl->fl_blocked_requests))
>> +						return true;
>> +				}
>> +			}
>> +		}
>> +	}
>> +	return false;
>> +}
>> +
>> static time64_t
>> nfs4_laundromat(struct nfsd_net *nn)
>> {
>> @@ -5587,7 +5834,9 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 	};
>> 	struct nfs4_cpntf_state *cps;
>> 	copy_stateid_t *cps_t;
>> +	struct nfs4_stid *stid;
>> 	int i;
>> +	int id;
>>
>> 	if (clients_still_reclaiming(nn)) {
>> 		lt.new_timeo = 0;
>> @@ -5608,8 +5857,41 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 	spin_lock(&nn->client_lock);
>> 	list_for_each_safe(pos, next, &nn->client_lru) {
>> 		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> -		if (!state_expired(&lt, clp->cl_time))
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags))
>> +			goto exp_client;
>> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +			if (ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
>> +				goto exp_client;
>> +			/*
>> +			 * after umount, v4.0 client is still around
>> +			 * waiting to be expired. Check again and if
>> +			 * it has no state then expire it.
>> +			 */
>> +			if (clp->cl_minorversion) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				continue;
>> +			}
>> +		}
>> +		if (!state_expired(&lt, clp->cl_time)) {
> Now that clients go from active -> COURTEOUS -> DESTROY,
> why is this check still necessary? If it truly is, a brief
> explanation/comment would help.

We still need this check to (1) transits client from active to
COURTESY state and (2) to stop the loop on client_lru since the
oldest entry is at the beginning of the list.

>
>> +			spin_unlock(&clp->cl_cs_lock);
>> 			break;
>> +		}
>> +		id = 0;
>> +		spin_lock(&clp->cl_lock);
>> +		stid = idr_get_next(&clp->cl_stateids, &id);
>> +		if (stid && !nfs4_anylock_conflict(clp)) {
>> +			/* client still has states */
>> +			spin_unlock(&clp->cl_lock);
>> +			clp->courtesy_client_expiry =
>> +				ktime_get_boottime_seconds() + courtesy_client_expiry;
>> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_lock);
>> +exp_client:
>> +		spin_unlock(&clp->cl_cs_lock);
>> 		if (mark_client_expired_locked(clp))
>> 			continue;
>> 		list_add(&clp->cl_lru, &reaplist);
>> @@ -5689,9 +5971,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>> }
>>
>> -static struct workqueue_struct *laundry_wq;
>> -static void laundromat_main(struct work_struct *);
>> -
> If the new mod_delayed_work() call sites aren't necessary,
> then these static definitions can be left here.

fix in v10.

>
>
>> static void
>> laundromat_main(struct work_struct *laundry)
>> {
>> @@ -6496,6 +6775,33 @@ nfs4_transform_lock_offset(struct file_lock *lock)
>> 		lock->fl_end = OFFSET_MAX;
>> }
>>
>> +/*
>> + * Return true if lock can be resolved by expiring
>> + * courtesy client else return false.
>> + */
> Since this function is invoked from outside of nfs4state.c,
> please turn the above comment into a kerneldoc comment, eg:
>
> /**
>   * nfsd4_fl_expire_lock - check if lock conflict can be resolved
>   * @fl: pointer to file_lock with a potential conflict
>   *
>   * Return values:
>   *   %true: No conflict exists
>   *   %false: Lock conflict can't be resolved

fix in v10.

>   */
>
>
>> +static bool
>> +nfsd4_fl_expire_lock(struct file_lock *fl)
>> +{
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_client *clp;
>> +	struct nfsd_net *nn;
>> +
>> +	if (!fl)
>> +		return false;
>> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
>> +	clp = lo->lo_owner.so_client;
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return false;
>> +	}
>> +	nn = net_generic(clp->net, nfsd_net_id);
> Why is "nn =" inside the cl_cs_lock critical section here?
> I don't think that lock protects clp->net. Also, if the
> mod_delayed_work() call isn't needed here, then @nn can
> be removed too.

will remove nn, no longer need mod_delayed_work. fix in v10.

>
>
>> +	set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +	return true;
>> +}
>> +
>> static fl_owner_t
>> nfsd4_fl_get_owner(fl_owner_t owner)
>> {
>> @@ -6543,6 +6849,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>> 	.lm_notify = nfsd4_lm_notify,
>> 	.lm_get_owner = nfsd4_fl_get_owner,
>> 	.lm_put_owner = nfsd4_fl_put_owner,
>> +	.lm_expire_lock = nfsd4_fl_expire_lock,
> This applies to 1/2... You might choose a less NFSD-specific
> name for the new lm_ method, such as lm_lock_conflict. I'm
> guessing only NFSD is going to deal with a conflict by
> /expiring/ something ...

will change from lm_expire_lock to lm_lock_conflict, fix in v10.

-Dai

>
>
>> };
>>
>> static inline void
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e73bdbb1634a..7f52a79e0743 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -345,6 +345,8 @@ struct nfs4_client {
>> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>> 					 1 << NFSD4_CLIENT_CB_KILL)
>> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
>> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
>> 	unsigned long		cl_flags;
>> 	const struct cred	*cl_cb_cred;
>> 	struct rpc_clnt		*cl_cb_client;
>> @@ -385,6 +387,12 @@ struct nfs4_client {
>> 	struct list_head	async_copies;	/* list of async copies */
>> 	spinlock_t		async_lock;	/* lock for async copies */
>> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +	int			courtesy_client_expiry;
>> +	/*
>> +	 * used to synchronize access to NFSD4_COURTESY_CLIENT
>> +	 * and NFSD4_DESTROY_COURTESY_CLIENT for race conditions.
>> +	 */
>> +	spinlock_t		cl_cs_lock;
>> };
>>
>> /* struct nfs4_client_reset
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
