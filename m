Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B04A900B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 22:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbiBCViq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 16:38:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55120 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231713AbiBCVip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:38:45 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213L4674028748;
        Thu, 3 Feb 2022 21:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BmLMR1cd+0HHCmtGIhjextfLa09VhYztnkaRPlczPKs=;
 b=TTOtllM6EzgaXnqq3QTN6ak8OcdXj9MeTLswtJ5Qi3jSU5OZgPGIXKWilUBrapbPywCp
 DqKd/mUqcOSi7Yz1YaGQ+mDf2kOGMoEvNV7j+MUMnSL+SKoaOOambKvYUSY9WpHCMBeF
 SlNrKzSGwt0p/lkHh50KIwV2lkZsYXBdBO2uD0qzwRGrSGRI2NdDyGH4JLxPiDJR3we/
 /rbJAjYROD5Gl/X2DeJrW4jL0LxWiuJAkjxGotueh99NIdQOTyO6Tv+8SQWFkQ7nfH7p
 HFbIzPB+t29yZVjqooJAsy8eG57ZnkfLWWpVezzSktMVtzRsROlViTl0Sdqfn+dHZqPQ yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0het91ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 21:38:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213LZVug164497;
        Thu, 3 Feb 2022 21:38:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3dvtq6370n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 21:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llhSuLvcue3GzCRFgQpqrJxr//v/GJzW9Nk9eCKbDRolaW2sYmnC2e3iZW4QwcwkN5Ad5NLHz00GOgTT2uFtY0L91k6MeteizRfCdIwziAqdc7jvwtzYor26+o1geW8smVxuWL9HQoSqUUCBkbNMOkXyzPsvY5lxUlVxBAFmwMLACq4pZ0lvMdUIgB19JDBHs1rEx2TgIuMG2Q4SgF0gZbT02AxQM4tNtVOXnr6e83sTXh6oSXcMOPwOHTHaH0xHLLJ6qWjrrLh/kfrISUZH/I3U6Q0x9IKVNs0man6XWCMHlbHINKvpzBF/jf/lOTbEZ/UPU4Kc56a6QHWypcB8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmLMR1cd+0HHCmtGIhjextfLa09VhYztnkaRPlczPKs=;
 b=V/C9+ZcGOjqIvhwN2kjsRNHA0J0ftMOHrK5OgyByj4XEtyz2DT5+4ACUdO21p8GtGkGXE2QjbY0WhaTH+gGUvKvHcJPyku+RAoe6x0FMKdAyf7kRwjlLdTaQxpTTKvu08OOJ3lMb3RhF8zSAfVmZZNjm7mowAMfFkhTfgJA1ZzxyX1KTQx4ZN4W0UZQubsGSkb6K+1kxb5NWP0Ix1zEW2uetqfncn3I6ioMhfYZ820jpRJA7AhRpipCRk7BgK/3zd7vo+YYZKLEXEOQYVCUNMDzUOxA3uuqFIrGPyBI6JqxMyz3YFeivplosw/f9kbPmhvA/gJOZWVMnpDWeKVWxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmLMR1cd+0HHCmtGIhjextfLa09VhYztnkaRPlczPKs=;
 b=HxA+gI3VTEYcA10Lacow6MZMy9jHNBgUbgCDvEDBCKBHh6XPXnDEt5Zm3V/zqtDP0w1gu6Jp/8tWrs7MoIJ/7oEqxR0bo+ivCOOPX2yBLMWx0TykaZAdO+ILD/qpXku9xW5pAY//yms1FDJ5UbPaJYjBbzIjFV10rTk4UyFiTxY=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 21:38:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%6]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 21:38:40 +0000
Message-ID: <0f895b2a-ca22-612e-fc8f-5eced86633ba@oracle.com>
Date:   Thu, 3 Feb 2022 13:38:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH RFC 1/3] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
 <1643398773-29149-2-git-send-email-dai.ngo@oracle.com>
 <A40572BF-F202-4FB4-8384-4A410860AB0E@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <A40572BF-F202-4FB4-8384-4A410860AB0E@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2baf55fc-80f3-4084-b528-08d9e75d8ad7
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB302298CD04B655C03FE3210E87289@SN6PR10MB3022.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3n2WxkkXSDmfcOBQP42nu7OIf6ZAXtQTAistUwhv4svWWv8WzmYGV3U1lOc6+8fQziejIFcVcL7o3vF6kKEOb7y6zp7yef6tyX3pn8KDMA0bYrgr1/7aoqyKkNvNHCF2EUCD5tK/JL6ABtl2dLrXC1fZ8RNBYTvbbjvxETHeL+EY5sQbqajXucBNIQN9q8WYVd3TgycG8m0T16y7I3Re71xxIwKz980Z2vM4wHq9S7NqKPt8rqJyY2Y6J1UUrIPbXpu+g4mYaVSGjY5r+Tot971g4cqgIHQOVUPk6ljtFBQer2I3HzoMH1FiknV/ivRQ4mSnvPYoPt39rh1/ZBTVihMJdPfgExUELLGlUWnoZ0rXanLIJ7500RmAjbMvjozZmvfMVz73267GS84X1Kk72wZ0J22Monxf5siT+DHqhGI3zUGArqfO/pQEnMWRwtEm97DKOQgwMk5gIk0uFjMhSWVxchqY5TRecRY+c0Gdtb5407kHzMu+b7XrX/Via/6dtrvu4ZV277qC6QMG4R3op9Tk2oq4+f9SSnNb7m2piYEez2WCB2/eWz3JW6y4sWcQqvR9ZXethtSpd7kiZuEDRg+zKx17csFwvbyD2S8yqDGaC6XAYYwky5QMdigMQEYn5JtmfflhzML573DCCkijEhRiuTrNVMZW20zOG6SJPxwXS/C7EdGX9SDSCZ5IIhkm3JDQLFK5sOi5sxp5h4Nqwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(37006003)(38100700002)(508600001)(6666004)(186003)(36756003)(53546011)(54906003)(2616005)(26005)(83380400001)(31686004)(9686003)(6512007)(6486002)(316002)(66556008)(66476007)(6862004)(8936002)(2906002)(5660300002)(66946007)(31696002)(86362001)(8676002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEl6QUlWY0FJeWlISGdscEtoZTJPOUhkQjllTngyYWdMc2I0U1RZYm9HVE9W?=
 =?utf-8?B?d2MyNDdMZHlCTVc4Q3pHdHBqRGpkQjZYZ251UmJ2M3g1ZUhHWTE3SllUUFpu?=
 =?utf-8?B?dGNrNFVqODg4WTdRdEJ2S0ZpWVB4dzJLMjBZa21kcWtxUmRKVDFiWXFFRDUv?=
 =?utf-8?B?d0hDcGx4bjRjUjhHRmQxVG5MT1NBNmF5c0N1Yi9PUGxvdFYrRVd4aytjbTdZ?=
 =?utf-8?B?Y0VaSlI0WVR5anFxeHE5SDZxSmgzT2FkbitSQmk2cHdkS0NsaVY5dFFpRUFj?=
 =?utf-8?B?bzFPVHpnZ1Uwem8rcmI5WUxwOVJ0WldjbDEvVlFPS3lQdUhqQ0lDS0Z2Q1R1?=
 =?utf-8?B?NDQ4MlV1NHFlMkxITE9uaFBYYkdjOVdESzRJNXlJWGdmMDZRM3BscFQ4YjY1?=
 =?utf-8?B?NHpHYlc3OUp2VDJWRjZhL3l0WmlORzNjSGZ3OWZwaTdVOFZtd1J3cHVEdVJB?=
 =?utf-8?B?RzhwRm1iSmQrdm5yNG5NbkVLbXJHOEYranhsUkdOaGlRaXVlU0dvSTQxYS9t?=
 =?utf-8?B?SkNnSVhnU2dYUm4rMEwyb20rZ1VabzE2UmJqTFYxMzRka2Jla2YvU1JVQ3Zz?=
 =?utf-8?B?SkZIWElhTDJzaVoyMWZNZVk3VW9qZmNHdEVzVWR4TVpLU3E2MkxQZXhxYlFM?=
 =?utf-8?B?NEFJS0xLVS8xYW9MUTRtMndaOG9Eb0NWcUprZW9pVGVyVU1mS29aUWpCQTFu?=
 =?utf-8?B?Q1lWdDJrNUlJOHAzS0hHcWtTSU9FTFRSdllZWlZOcmRLMVRhT3ptZWQvV3Q2?=
 =?utf-8?B?Y1VYQWZMV2dmTThPVVlrZHZjZllxZTVHUms1b1RqR2FEOHB4N29RU2VhOExR?=
 =?utf-8?B?Q3RDV0V3UW9Rck1iL0FsenQ3RU1oMkNZNjRFU2dXVjBtU1J0VlhVTUdRVzQx?=
 =?utf-8?B?VlZJazYwa3VmYWw3eUtXb3hyQWFzdGFYRVJ3aUZROXFYMVVFL3NMR2RYN1Nv?=
 =?utf-8?B?QUpLTkpuYXN5d1BxYVF5VEFpYzlhVGcvcmpNS3B4MlI0MXk1RzlwcWVjdTJu?=
 =?utf-8?B?TUlPKzZ1Zm5MMFIyMUQ0K1l3Ny9ISkJsWFQ1WTFSa241dXB6VUJQaTl0VCtq?=
 =?utf-8?B?Y3ZxYytGcGpVRk9xVjdFaE5uT0tnejhwWXhyQS9QcFkzTm5uaVRXT0RCTVNG?=
 =?utf-8?B?b2paOEdBT0JMdXN0S1NMb2VKNEhRZDRiQUk5bTVML2M2MGQrcnpsajBZYW03?=
 =?utf-8?B?VW9ML2J6cHVLN0FvS2VyWlBHN2JYWWFyOXFacjNXWExoMno0QlFqVVBtWG1R?=
 =?utf-8?B?c201NlYyS3NFVDZQRHNFdGltMFJ1dlFKb0NmeVQzd0h5NGlKV2thZEJaR3V4?=
 =?utf-8?B?bTBsb3BmK0VidHdMdUZvUTJzWHhXYjV1UDgxK3V2VHNnT0ExdG5LdUx4d3h0?=
 =?utf-8?B?ejN3N2QxUTdlTHhFVGdRRXhaQmZLVmZvYkRqazR3a1VyUVRpd2duVXY2MGI4?=
 =?utf-8?B?Qk1YbDRYUXg1QmJ3QkNZcGc2ZTljSlZWSmZDOUdFUXBvTzFOa2hiaXc1NWds?=
 =?utf-8?B?M3B3TkZIdEhteW5Nb25nU000My95WVU4VnhWUi83YjNNWmpnKzZtRE9Id1pZ?=
 =?utf-8?B?bnE3MHFRL1F6ejR2SnBtbHpaVVVRK3RIT1pvYmJ3Z0hiamRBajVBODNGT0hX?=
 =?utf-8?B?cm5rQ2dERmtIbW1QQWtQKzlVWnNTcnlRa1lyRDBxbEpQRVdJVS8zR3FXT1lo?=
 =?utf-8?B?ZWtiUURWZnZEWVFlNVZyRDNDVGxBTTdNb055dEJSWFNaR05SOE5OdmNQWmx5?=
 =?utf-8?B?YTIrVW9rSGpzTk9NWm15U2dVMjB6N1lGd2J1ZUpTRDV2bE1SeEtJeThGa0Vn?=
 =?utf-8?B?NldySXI4V0JNSm5qVHJrbDFwTWtoZkNtRWQ4MTREbUxJR0FsQS9nZUNibDND?=
 =?utf-8?B?aWUwWFNwQzZiLzhDanNFcWUyeldUam5UMEllQmt1cWd0V0JlNjhzUG9uNkRC?=
 =?utf-8?B?RUtlb0hlUlMweHJ5bFRCV0NrOHY3QjNBR0YyYUFNWm1hbXRCYzFBTXV2ZklD?=
 =?utf-8?B?WXoyRDFzdmUvMEovQk5XS2ZnZjh3MjVOSTBZRkxMTGxSRU1vRjNoM2NtS09I?=
 =?utf-8?B?WmcxbVdDQzkxWGtYc1hXN0J6Z0p3c1lpVzdTTDl1NGJrb2NheWpETTNpeXBN?=
 =?utf-8?B?ckFac2c5eis5UjJ1VHcvdUhySnp1a1VQZFNWSUtQdWN1Q09ucU5XOUI3SnV1?=
 =?utf-8?Q?jnznAXy6mybedatVT9bV+8k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baf55fc-80f3-4084-b528-08d9e75d8ad7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:38:39.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUswxK39VFKGbGTdeuIh/m6hjYbjJgMptQrgN4goXwT3ipkbTMYmJ5DWUv1ruBIUoNayurfP2kOhMKsLozm4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3022
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030129
X-Proofpoint-ORIG-GUID: vbU4_on4PGL_ZyNElsJ_68Hvgcfl1596
X-Proofpoint-GUID: vbU4_on4PGL_ZyNElsJ_68Hvgcfl1596
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/22 10:41 AM, Chuck Lever III wrote:
>
>> On Jan 28, 2022, at 2:39 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
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
> This change is nice and simple now. The only issue is that the
> short and long patch descriptions need to be updated to replace
> "lm_expire_lock" with "lm_lock_conflict".

Fix in v11.

Thanks,
-Dai

>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> Documentation/filesystems/locking.rst |  2 ++
>> fs/locks.c                            | 14 ++++++++++----
>> include/linux/fs.h                    |  1 +
>> 3 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index d36fe79167b3..57ce0fbc8ab1 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -439,6 +439,7 @@ prototypes::
>> 	void (*lm_break)(struct file_lock *); /* break_lease callback */
>> 	int (*lm_change)(struct file_lock **, int);
>> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
>> +	bool (*lm_lock_conflict)(struct file_lock *);
>>
>> locking rules:
>>
>> @@ -450,6 +451,7 @@ lm_grant:		no		no			no
>> lm_break:		yes		no			no
>> lm_change		yes		no			no
>> lm_breaker_owns_lease:	no		no			no
>> +lm_lock_conflict:       no		no			no
>> ======================	=============	=================	=========
>>
>> buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 0fca9d680978..052b42cc7f25 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -853,10 +853,13 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>>
>> 	spin_lock(&ctx->flc_lock);
>> 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
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
>> 	}
>> 	fl->fl_type = F_UNLCK;
>> out:
>> @@ -1059,6 +1062,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>> 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>> 			if (!posix_locks_conflict(request, fl))
>> 				continue;
>> +			if (fl->fl_lmops && fl->fl_lmops->lm_lock_conflict &&
>> +				!fl->fl_lmops->lm_lock_conflict(fl))
>> +				continue;
>> 			if (conflock)
>> 				locks_copy_conflock(conflock, fl);
>> 			error = -EAGAIN;
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index bbf812ce89a8..21cb7afe2d63 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1068,6 +1068,7 @@ struct lock_manager_operations {
>> 	int (*lm_change)(struct file_lock *, int, struct list_head *);
>> 	void (*lm_setup)(struct file_lock *, void **);
>> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
>> +	bool (*lm_lock_conflict)(struct file_lock *cfl);
>> };
>>
>> struct lock_manager {
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
