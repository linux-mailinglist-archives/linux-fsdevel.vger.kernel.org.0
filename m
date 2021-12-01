Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756A4464598
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 04:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbhLADxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 22:53:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16094 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231927AbhLADxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:53:44 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B12Po3j007178;
        Wed, 1 Dec 2021 03:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nBFpCoOJnHRz77czx0Qu2qzlAmU5JP6QI2/M8B9ihXQ=;
 b=cw7l5ACJHgjQvEMa+nxAamSRHK1aweR2VQ0BpTMIV8pKnJjKud1F6ZCsXTCXCrtczCZV
 TRgrupCOqsHTX7GnqHgBIUujfHaWXJotTFcRNeit4D2RMPIHrZnoxCkLASg39MmqZDJ3
 TkMnR7Gn4rvYpevXkqKArbuFG0wLxJPy6FRFhytnSvPAoUWqZ/IiOn89WDBLWBXj0QXv
 Z1OSSqhyfJ3++wjfGfeFFxbiGE176Buy/VY38syA4HKXeO8QTjbpK+SBoJrgp/jxcu4d
 3a0z1vLZhR19ymAoGqb7Y6nyQ1pyF8XBfs4AM5qjK1O9UU/lRJt0OOJJowVnGujUfKjk pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmueepbk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 03:50:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B13fji2008074;
        Wed, 1 Dec 2021 03:50:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 3cnhvdxrep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 03:50:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5kOmaAGRfarSQQ/SDhQBfkd+7A287Q7BKObBICdGTVvaeC06/ehtyFSe+z1xVIN3qNGzNZBRz5iCIgo7kAX6H9hyknNSSvj4UO8ktV+rOulj8zLRG0nJjGL2lngUZXQ0istxYF7ImclJlGC1pIQnfw38QnIJCDJQ9ObvNvJDgXcReGKOZwfRXxFbYP9pIPR0qcWPbPo0ezg12XeOL6V/2RJt5lNphw0ErxMThsixQ2gwQ3n6ICXgxUL/u2X61ITULmKU1bHc8JoWGYKs9bwcdvaE5JkBVhr80gUaclHwayOM6Jmq0TDe/AX6ojVR5pg58/b0CyYIkWc5dXBeWO1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBFpCoOJnHRz77czx0Qu2qzlAmU5JP6QI2/M8B9ihXQ=;
 b=B4q/2VpC7TpmYth7OfVRMszikhvX3/LIeoRulp1jGp9nReamUtZdnlfRHeRY9dWIO9YGZeMZXhwVb3XbPYppI9rtjb0B/5wqMxbhlZZLqxNvb+NWv7QI2Zl3MJ3Yzhe/kIc7p0OL1Bity998knNUax7mS80DCnJd7QK1uSYcdqJ6J5+iu7onI9EkaoP8rM1GQ04hKmkwx+5ftB4qFqNu/BPKoOKrJ55xZIBJo1UETPbKcNrI3czdSc0sXdojXzLZKkPAvb7xs4xRjp6TxFt+GOsCFxq5px6BCn8cI/r69aesobB/TIoo20lXsdDfBI+WSXJNGYII2M4LldWHYoDRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBFpCoOJnHRz77czx0Qu2qzlAmU5JP6QI2/M8B9ihXQ=;
 b=UhQ4UtQeKuATqTo7UrxR6EP4yXrun5lOG9ma2FBAi7iZHopk0wUaEzAC8g3qREVNAGLQc/WidtnYAN2X+BbaGx1NmJYYtzTFQxWbZ95+x5mvcxIFMfNU4K84/xHcGSlvC2tzOuzvuMVcyJ2JM8I8UPYFJyLHLUAXXzrUzoJbxqk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2760.namprd10.prod.outlook.com (2603:10b6:a02:a9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 03:50:17 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Wed, 1 Dec 2021
 03:50:17 +0000
Message-ID: <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
Date:   Tue, 30 Nov 2021 19:50:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211130153211.GB8837@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:806:21::31) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.159.143.49] (138.3.200.49) by SA9PR13CA0026.namprd13.prod.outlook.com (2603:10b6:806:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.10 via Frontend Transport; Wed, 1 Dec 2021 03:50:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c74f2ad0-e2f4-4929-94c3-08d9b47db041
X-MS-TrafficTypeDiagnostic: BYAPR10MB2760:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2760DD13642B30DD40B8B45C87689@BYAPR10MB2760.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRUSGSlGal5YmtadvVSJQVqO/uMl1ppS2qDVmH9vsBDXwRGivcX528njqZgDPcpbwOn7UiKqrkgGi4HtjgSLqEK4UCJOSv2YIkkVh/tEzW8hMQ9M6Ngt3r3B9xYRmTEB94CktHuV9sbLz8jWPSk35sRSnbmPS/PkJuV4DGONtrTmyF2zdXlxIvxjSI6FhZUx/s7ZgzFP2TLCjOro9eSIp75xztYJiem9W6f+JqDDcV2yY9DX05i2e8GCNlcZ2tupHS6qdZNKnNoeSZk3ui2vxErZbblNkB7QJbPsIpWdsFOyrYXEuOR+KM610hogtO7ws2fpRIXeAlLzfUq/4ns0YdEl6W4OjUDrn7PLn08VGJP2L9X3mZld0PXGV2CPI3N+t/DdQBDcQ5qVluwmZdqxX6x+NxhIPN4PkOcb/p5j5KL5kvkjOHl807rOraaZkmRRfzIynS4Hwqn2JsfwmiXGmdwzo95vdMlkq0Uus4+mUn9klC0peYewjDbxNGOsmOeWJRBo26/pdxxB8Y+jtnFrZt5rWNsnJtgyDvSgzy+u+Vq7vE0YFs5fxUBZAhA+J0u9zZSWdcqcBEpLYRNjoH8hiAibObV+o/gaswFGnWQ6VjE/jcy93S/ksMeCOUzB84gYjzJCQWJWEQ8Ppxe0GKm71zKJECFc0EapIdgP++gj3+uhRGyEW1p99VPbFcqGCQSaN8o/KIxlXusp+IjkMkR8Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(8936002)(54906003)(6666004)(2616005)(38100700002)(36756003)(956004)(83380400001)(186003)(8676002)(9686003)(86362001)(4326008)(53546011)(508600001)(31696002)(2906002)(66476007)(66946007)(66556008)(31686004)(16576012)(316002)(5660300002)(6486002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cURSNHFCcWpCOWtNV0c5WUltSCtMM1hSWjBwRDVEbDhyeGZEQzJhNjN3T2xq?=
 =?utf-8?B?aXpidWNGaVpyeXNyWGRCeDBnTHU2dEk1OHh6OUtTTHVxQkIrZWxFWUpvY2dl?=
 =?utf-8?B?U3FxYWFUTTRHaVZ3Q0QwOERXelFDc1M0Qk9sL2FFb2hObTN0SVk2VlVzNVAy?=
 =?utf-8?B?M3BDaG5mOHorb2h3ZXZGai9TN2JYTGRoQmg4eGpFTi9md2NNMkNCYlRuTURy?=
 =?utf-8?B?Q0VPcDlFdmpwWVlJZXNNd0lyWnZjakNNdHY5MUFKTWxFUTUyMG9rTjhWVGRL?=
 =?utf-8?B?UnVFd2F1MzV1M0JoOXk5MkEzdkVRUEs0K2k3d0orTU9QQ1I0dHlGSW9xa2Z1?=
 =?utf-8?B?S2d4KzFrL0h2WXlBMGFTZm10UEZ3UXlRWmd2d1NLVjNwWHc3U2R5eFpEeEhk?=
 =?utf-8?B?WTl5NFEvVzNSOGVVS0RxU0FUSURENDMzbnNuODExOEpjK0l4NXU5dVdjVTdz?=
 =?utf-8?B?eTJ3dUdZa2RCOTBjYzI0TjFWTUI3NHQxZWFxOFdMMzNXTXNRT1gxUk5CQW9m?=
 =?utf-8?B?blZIMXJPa1lnRTBDSXZZcW5PNDZWbEZ6dXN5TlVpaU42TnVMQkRRTjJDV3VE?=
 =?utf-8?B?QnJtN3M3SGhpWnRMOTFMWml4U2kyVlVJTnQ1dnhuY210UVdPZWxldysxWndS?=
 =?utf-8?B?ZnVPNkVPbkJjUWJOUi9VVFRhbE5pdVNkQkVPTE1VTjM5UTQxbDgrdTFWN1hI?=
 =?utf-8?B?N0xvVkVrRkI3Q21tcG1VN0FQVVExQ21LclRaVjltMVVjVFRqTDAyQmd2TThK?=
 =?utf-8?B?a2hXc3NnNzIwMkY1ZGR2ODY3T1ZHQ1ZPVlZiMVNjbWh2NFd5T2pMKzR5VG15?=
 =?utf-8?B?cnp1ZEZOVWFZVlV2M1RSLzF0dVZzT3FWZVVLUkNQeU1QSmVxcWxEVUV3VUdx?=
 =?utf-8?B?NlhCOWs3aStkWkh1NG53aEpzUXNmNGhqQjQvWkh6ZXI0RXA0TlZCWnV5V0ly?=
 =?utf-8?B?TVlkMUFBRTAvZW5pMEVrQkZIS3B6ZXpPVDhNUGl2Mm5rYkpheGpTMkdvOEtG?=
 =?utf-8?B?eDBKempZTmw2TFNvN20wK0dIWlY5bzBnQmliWCtZckN5bUVRSDNGRFd6dFMy?=
 =?utf-8?B?ZTF0c2dweGlsVXBjQThOeVdZS3YvbnBXNGZyZU1SNXMrdDBLdXkySHd3dHBX?=
 =?utf-8?B?SE9kYWdnMmRRWnlFRjYxMFAvZ3lCRjE5VkQvUExjenlzWlpoQUZOQnlBZkZE?=
 =?utf-8?B?c09QUkM2R1BWd056TlhhK1BhYzdvbHd1SUd2ZHVXU290RFptTmY1bU84SWVx?=
 =?utf-8?B?eXE1czRVc05qT1RCSGZQUU55ZzVjQVFMR0t4ZWE5SnlSR2lRdURrcytITHBQ?=
 =?utf-8?B?KzdjaVNPa0duTmlXWHFqc21uSVR2YnpQbHNWbEZ5emZydGt3N2kvenIrMTNz?=
 =?utf-8?B?Zm04VUhISWFyUmYrUUFZczJ6ZEl0eG9pa2ZDUVcvVUVlLzlOV2VYVmZoQ2lM?=
 =?utf-8?B?d3B2djV2bE85dExJRFhMRXVla2FwZUx2bUsxWGQzcWxmUEFkREdXUUlvb0pu?=
 =?utf-8?B?eFd1T2d3SUpoblZMQlhwRldpemRSelZxdUN5QklPMVNDbkRYeHhkb3FUOE1v?=
 =?utf-8?B?d3pJc0NYaVFaTS9lUXpBK25mMUo4cytYM1NITUNQcEJhVm96VnYzOWVGUTJG?=
 =?utf-8?B?YW5NVEgxMDE4RnJodmdKdnc0Rm9ZT1ZVNlJPTmZ3QmV3U09GM0FLU2o5bWhq?=
 =?utf-8?B?SDBUcGUreHRKajhzcGJleG9VUVRTODNmMEgwTzVmVDZGdGFtNE5HZjdKSm95?=
 =?utf-8?B?a0R3MHJCRXhWTHh1UTA5TGd4eEd4WnNEQ1N2OHRwZHI3b0gwTVY1dTI4U0s1?=
 =?utf-8?B?K3ZDL0t4MjU1U3M4SWNHTkFUeHY5SktrM0VmYXJOZ0RpWExnNC82VlNOWlhs?=
 =?utf-8?B?ZDduMTBFNXR6ZFl3aW04YnY0d0twRStrTWEzZXNKN3FobzJJenhHYzlJbzRZ?=
 =?utf-8?B?SUFsTUNhbTM1UHJZdjZ5ZU9OR2Z4R0Via3prN1k1aGZuTExaaXJYY25oMGYx?=
 =?utf-8?B?ZUQyVlU1WW5Kcnc4NGlzV3lPd3BqcW1OUmpwUTZSeG9XSFM2UThSQ0p6NEIv?=
 =?utf-8?B?bUJVbENxSGMyditodWcxMlByekZjbHl1TDBHOFhVT0Q0WEFVOGVnQXAvUE9w?=
 =?utf-8?B?NXpsZU9YZGcwQUxmSlBYRVN4T1dpMDVHOG54clkvUlhqdjVLaVFRZ2hSWUlL?=
 =?utf-8?Q?v9Ujzt/dojGTQ9YuXqj8lgs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74f2ad0-e2f4-4929-94c3-08d9b47db041
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 03:50:17.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM7EfU7bCFamdrHmvf3l7deBrwXbDUlHL0o8bSAZYMV7nbeoxwTzGaZPDwh5kJp+OOQgcmVulnH3CHKb4fsy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2760
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010019
X-Proofpoint-ORIG-GUID: kGzrK4e4b6d396M57vGp8dtyAUphaNrP
X-Proofpoint-GUID: kGzrK4e4b6d396M57vGp8dtyAUphaNrP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/30/21 7:32 AM, Bruce Fields wrote:
> On Mon, Nov 29, 2021 at 11:13:34PM -0800, dai.ngo@oracle.com wrote:
>> Just to be clear, the problem of pynfs with 4.0 is that the server takes
>> ~55 secs to expire 1026 4.0 courteous clients, which comes out to ~50ms
>> per client. This causes the test to time out in waiting for RPC reply of
>> the OPEN that triggers the conflicts.
>>
>> I don't know exactly where the time spent in the process of expiring a
>> client. But as Bruce mentioned, it could be related to the time to access
>> /var/lib/nfs to remove the client's persistent record.
> Could you try something like
>
> 	strace -r -$(pidof) -oTRACE

Strace does not have any info that shows where the server spent time when
expiring client state. The client record is removed by nfsd4_umh_cltrack_remove
doing upcall to user space helper /sbin/nfsdcltrack to do the job. I used
the low-tech debug tool, printk, to measure the time spent by
nfsd4_client_record_remove. Here is a sample of the output, START and END
are in milliseconds:

Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: START [0x15d418] clp[ffff888119206040] client_tracking_ops[ffffffffa04bc2e0]
Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: END [0x15d459] clp[ffff888119206040] client_tracking_ops[ffffffffa04bc2e0]
Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: START [0x15d461] clp[ffff888119206740] client_tracking_ops[ffffffffa04bc2e0]
Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: END [0x15d48e] clp[ffff888119206740] client_tracking_ops[ffffffffa04bc2e0]
Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: START [0x15d49c] clp[ffff88811b54e000] client_tracking_ops[ffffffffa04bc2e0]
Nov 30 12:31:04 localhost kernel: nfsd4_client_record_remove: END [0x15d4c5] clp[ffff88811b54e000] client_tracking_ops[ffffffffa04bc2e0]

The average time spent to remove the client record is about ~50ms, matches
with the time reported by pynfs test. This confirms what Bruce suspected
earlier.

-Dai

>
> and maybe we could take a look at TRACE?  My hope would be that there'd
> be a clear set of syscalls whose time, multiplied by 1026, explains most
> of that 55 seconds.  Then it might be worth checking whether there are
> any easy optimizations possible.
>
> --b.
