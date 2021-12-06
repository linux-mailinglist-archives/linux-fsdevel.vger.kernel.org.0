Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE246AAAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 22:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351588AbhLFVr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 16:47:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13476 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351598AbhLFVrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:47:55 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6JicUC031397;
        Mon, 6 Dec 2021 21:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Wu5RfoUie0pLwthf/ghAV+4YrZEalsLP+6mMo5ZLR5c=;
 b=ZckBO68NcX0cBcXN2ksTc376mQye2FfTNKke1Or5r27x2AMG2ztiQh2SFtZN/MXmIRPf
 5Hccfeu33fAxBdjvqDmcBjqRFijm4n07lcPPRlybHwhilyvUVjVQoQwV53pwppOyFw6L
 Fyobr2XpLyHXiC1bt/ZB830T55atE6baXTzRlg89pMABUCcvd7BEWNmPCUc5RN+7Iu9F
 0huP0Vd6PnGTkQ0xez70ZCVkRyrWWsfWIhz2XM5YyNXGMubyZZaZjTvuQFU5iusPZXDK
 7S5mZmiaqZ8iXdvsM2dyJHC3CW5I/c3mvqEMTJ43afxT1ldqyOQjUgnk4xIZLPclyLaE fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwkm8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 21:44:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6La9vL074930;
        Mon, 6 Dec 2021 21:44:23 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by aserp3020.oracle.com with ESMTP id 3cr05413g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 21:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7PzVAuO96FPJprJF5KJXA/n3PaUxboJnmpOsJCjWfRxt1coXPDIxlIAzU0kK2cgygLLtOVE5hlEEtny5F+TM6ftxaPa2AGUiYxqfdp1gbubSe1zEV5r/boImMhlcAooqaaF9fuz9KMKRXxjGLT63EQKhJoU4TE5AoiVnflH2o+IZ5P/R+PcZ6eCr2gVYQSzuq7MqtKAFM2oOexBff8956QFbBihnKxiTHbgwQ0mxbIoaAZb2l6nrV36XfAgKg6UmzBRCkuuHAYkUxREZlNIAfVD8NH8XwPqrGCOcIsCHNYUmdUAQNAD7jeNfh62mhuCEykFJjoFRLfuBaM99oNzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu5RfoUie0pLwthf/ghAV+4YrZEalsLP+6mMo5ZLR5c=;
 b=P8nDZOS0DKx7vQ17YmIMOStwpRHUM3ja7AFvQxje7UMdcKc/T+rpwhv9bptCp5fVBDiHeFrjlKPCAPtr9ui9CYbb5oy0UUt3EU4E+Zjp46kc1gd+cOASfaHEjE78S+IDMgwBO4KUV4BZRrRT2tL22kKNQgJ9E26oFUEMMoiWeGt3SNNv2CbPMxExQo8j0UrcABLhNCcOmFSoEci5ibElonOmRRMp7Bp6vfMoIL9ocWlGVfwiTYolDPDQHxOjJqSi9L4TPsAB5tPHtO54qF8BzHDpeC3v3DBJqOG/CPJjl8gsKVX5raA2KWmqH6+xEQpVimxCpGbnjjW9imcIwW2pLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu5RfoUie0pLwthf/ghAV+4YrZEalsLP+6mMo5ZLR5c=;
 b=PdKj9QYXfbOGwT9NX5dTuh8dUJaLwHTMV/LQHbUUSb6jpveQYgDCRyrhhemCo5NbgTEzc//MNxbVCN6lpHlPzWLncQ2ukqWg0N0x9LMXW7E88zz5aeIlCGqK49go9z/TOZiWktpkqZqRRG4bmBl7jQbQdr5jsGfsvcbEE3RKIrs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3559.namprd10.prod.outlook.com (2603:10b6:a03:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 21:44:21 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8198:a626:3542:2aaf%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:44:21 +0000
Message-ID: <01923a7c-bb49-c004-8a35-dbbae718e374@oracle.com>
Date:   Mon, 6 Dec 2021 13:44:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.137.225] (138.3.200.33) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend Transport; Mon, 6 Dec 2021 21:44:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 612b19b7-3741-4ab9-9eec-08d9b9018fd3
X-MS-TrafficTypeDiagnostic: BYAPR10MB3559:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB355998D1F8F823A3A4298CE1876D9@BYAPR10MB3559.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/dNk1SEY7f5L0cEwX71Z+PF89j5FajiYFgoLecY5RWhQTVxq9dSOm+Su5BuLNhIC/WAEKOsc9xk7W/hWNfbQXcftOHDdA8fQkKgk7uusKMhiXlxPFzO3HGMg9TfiNyAQNEFO8+tI35zFHt6GP2mEFhHzfvqVzijESECI3rYYa1TF5lP1Ri70deBLcfHPxIaYOv9hJfEb2zEfQdU9Odih+ohlHlDBBVjI1Fvvo3EGuVPlKmgoYbWrjbtoVbINVgM2maC14r9jIcUctOIu3Zi23WBelF9Fb1OZYDFlFgYciex49UWU/7BsKTmqIfJrqXpUqfu2Trha5+mR8ZsT2z21JkmVekfQ4gJpztkwWUjtLAtqlHyY0dWfen/HdlKPjvdCn+OpcVvYIy7Lh0JRmQKf2I8sUGO3jD1QTLqIi0MHdnzGSLmcai4gcjGpS/hoE76blttrukGvBU3RrIjG+gCqUu3xgWOg8qrJP5707kyomrBWoC8hmb5fYgr1G1Wg+A6mPEqARYLxg7JNhTOddlgxKJCrteIm03DDkOCmBxnWheodxBnElJa+1NfGHl8QG0SfUrewjE1is/SpdbsLKF8lrXfrku4BqES/q69xP2npKTMWdIrCzObtJiSzdPTwAcwpnakysyZpRWg1UxiHp4wrwdNF2oZJmnlfI2gS8tnX+WJnHYD+zz+jSb1lDhl0pO63COn4N2M5dWjwdi1ub8LetfuVGJbygBeYeqqN0ydR8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(16576012)(83380400001)(956004)(66946007)(2616005)(9686003)(37006003)(31696002)(38100700002)(31686004)(30864003)(6862004)(2906002)(66476007)(66556008)(8936002)(5660300002)(316002)(54906003)(4326008)(8676002)(6666004)(86362001)(26005)(508600001)(53546011)(186003)(36756003)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDVKNHZ6YlIzRXJ1c3JIMFJ6T2MvbEFlU09NTWR3RldybUFXUE5qeDN5cTdq?=
 =?utf-8?B?N0M1ei9odWFoQmFTMEJmWUFybk1VelFsejN6ZFU0TEtnRVZIWVRobWNpMGtW?=
 =?utf-8?B?NzRtSDlBZWhEOXR6ZHZRODl4NDZ0Q0pkbm9KUXg3ZDZqam4xalRQcy84N0Jk?=
 =?utf-8?B?dTdqRzdiSXpjamNuRHBvWncxdkE0MWppM0Rvd1VObFBITHVMZVp6b3Ryb2dk?=
 =?utf-8?B?SzU3a1RYS3VNQVBpekRKamo3bWh4Q3BoUGV6L3lFQlpJc21JbnhVMVREME5r?=
 =?utf-8?B?S29wdXRmcDd1MjI3d1U2MWIyNStYVzFVRWtVSklBRkFyWnJUeXpDMFBvbFJZ?=
 =?utf-8?B?TFJNaWF4NUxsWFUrM3ZMNWViSk5EQ3FDMDBmM2dlclNtcVE0TVhJVmIrUUFE?=
 =?utf-8?B?cXFpRDViK0h5VlZUZjJrekt5TFpxTFlqVURnTDhiVDVqdGw1QjVhKy9qQWlv?=
 =?utf-8?B?KzdiQlovZDBhekg5TU1IYUVRRzZpemRIZU1BZDl3YTRLLzBqeVhFeTZzK1ph?=
 =?utf-8?B?RU1VVjI2dmxCYXRVQnkzaHg5Mmx6SU82UnBLOC91L0dTQnEvakRZSjJXb1Jy?=
 =?utf-8?B?SjlvUDFsL1FvWE8vYXhiTzV3QTZQUmR0djBzaEZwL3htUis5eWdCTUZDZ3Jk?=
 =?utf-8?B?eWFSck5zZkJ1YWNDWXo2VnV4NVh2emZvbVJ4SCtFem5Sb3F0T1FQdXBvWWxz?=
 =?utf-8?B?TjNRRjBwZHVFTXM4eXlHdm5hQUhqdnI0R2dJUWZKNDhCdGJWZStRVFJJWFRX?=
 =?utf-8?B?cWZmYStnUzZKejVhVlhMSnprbVFNWGhwd0pFY1NyT3k5SEovOGM4a1hNM0NR?=
 =?utf-8?B?cWxkN3JOcVJ6TVg3QUVFcnRiNW16YzV5ZFNjMXMwZTRmSkpDeVNURjNoWStB?=
 =?utf-8?B?VTNza21FOUF5WVJWQzNKMlM1aFdXckU2S055dVdyamZhU3hBc3JoSE5KbUNJ?=
 =?utf-8?B?ZmxpUFMyU1BFQmhYQlpDUlJBUTA1TStQb1ZBMGw4MWdHMktURkVtOTdrRFYw?=
 =?utf-8?B?OEE0eXphM3AzR0w4Wm0zSjlqSzBiYVVJUGxJc1crL3kvdmMyVTJ4UlgydUpm?=
 =?utf-8?B?Z3BhaGpubHFkUWJ2d243dHZodDJJalFXeml1cU5vYmRaUjl5MXo3UnBteDhh?=
 =?utf-8?B?UU9FWHNka2hZK3RTYkxSL1dhZW5ZSCttRU82MExsc1hHOHA0ajFyVWJRQ0JZ?=
 =?utf-8?B?dUVpdnFaODlyM1dWKzlvaUdDUUR4V0Fqbm1YbXRHTURzK3R6UVdnbmphSjkw?=
 =?utf-8?B?MElWbUNSLzZpQzBDRitHN2FQRnpidWRoSWVvVEtrZDZwK01QOVlxSExzdXND?=
 =?utf-8?B?K251V2tEZ1ZRUitENVdtN1BnWGF6bU0xenM1L1BSSEtxam43YTlKdXZ4a0dT?=
 =?utf-8?B?S25tb3pnVGVhRXFPa1RkOUJ4MG9menZOSWpFQlliZlVxNFdPT25FT01LRzdO?=
 =?utf-8?B?MFJDcS9mSHM1cDAyQ1dtNklVYzdEd2JrLzJsNi84Rk1yeDc2SDVEM0doK3Rh?=
 =?utf-8?B?MHRNblpFd3J1NUQ5QXFYbkovMlp6bzljT2VrWHhqU3dKUGErQWpWQ3BpNHA3?=
 =?utf-8?B?NmFrTkZ1YkpGdjkyeTh6S1NFRWRRdUNJR2xHRlNHV0w4TVdQOVE2SkRGSlRy?=
 =?utf-8?B?aDhJVUdHVTlIaHpBRENzR3ZjcS92bXhyVWZmVWpzRTQ0R0pxQzFYeG1Cai82?=
 =?utf-8?B?NjREdFk3QVlMWEZueVdZMmJZM2NRWDFkV0FmU2RVb1V4Z1FWdlBuRmdTampD?=
 =?utf-8?B?ODFrYjlqNG9TRDNmSjBYQ2wxam9aSnJ6dmp4YWRLZnpsS2RlRTNqTnhaRkF1?=
 =?utf-8?B?ejA0U0pSTTVLQTRyclBLckJDY0RtbUNoUE44K0pwbThNbnFUS1h6YU9GSGF3?=
 =?utf-8?B?Y0l4aUtKbHhWelBZdjREU1RDOUttaEt1bytvNE5yTUxGdUlYYlBYNVdIVzBZ?=
 =?utf-8?B?NDNJSW40cWFSajVobUJqb1FCalVpcjRaSTllTk5MRFgrWkdxVStSUDRHeW1h?=
 =?utf-8?B?YWVwTGU2VGlvZTluV0JWZ0YwL2E0VVN1anBCSDlnR01YM2cxdjFJY0IzYSsx?=
 =?utf-8?B?TkZRQjR5bC95MWhrNmlDb2RvbGZiWGpuYnZGQmN1NUxQSkxFYU5LMTN2U2pt?=
 =?utf-8?B?S3ltWFVTbW00M0ZuNGx4ZW9SQm9YWVF0K3VXWmNsRElqakllNlhLYkUwTWJN?=
 =?utf-8?Q?AQbGTmFl4AgONs7iQAO3mpI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612b19b7-3741-4ab9-9eec-08d9b9018fd3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:44:20.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/xefAvfzwyyDYTxuZNRVUSv4NARqSSDZMI5aphcE7kAcxYhy1pQ0n75uVajiqghu/nVMLZqkh/8HvIlJ4QJyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3559
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060132
X-Proofpoint-ORIG-GUID: iozGs9uA4Yg4I660-8vHjiuMjhaISKTP
X-Proofpoint-GUID: iozGs9uA4Yg4I660-8vHjiuMjhaISKTP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/6/21 11:55 AM, Chuck Lever III wrote:
> Hi Dai-
>
> Some comments and questions below:
>
>
>> On Dec 6, 2021, at 12:59 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
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
>> fs/nfsd/nfs4state.c | 293 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>> fs/nfsd/state.h     |   3 +
>> 2 files changed, 293 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 3f4027a5de88..759f61dc6685 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -125,6 +125,11 @@ static void free_session(struct nfsd4_session *);
>> static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>> static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>
>> +static struct workqueue_struct *laundry_wq;
>> +static void laundromat_main(struct work_struct *);
>> +
>> +static int courtesy_client_expiry = (24 * 60 * 60);	/* in secs */
>> +
>> static bool is_session_dead(struct nfsd4_session *ses)
>> {
>> 	return ses->se_flags & NFS4_SESSION_DEAD;
>> @@ -172,6 +177,7 @@ renew_client_locked(struct nfs4_client *clp)
>>
>> 	list_move_tail(&clp->cl_lru, &nn->client_lru);
>> 	clp->cl_time = ktime_get_boottime_seconds();
>> +	clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> }
>>
>> static void put_client_renew_locked(struct nfs4_client *clp)
>> @@ -2389,6 +2395,10 @@ static int client_info_show(struct seq_file *m, void *v)
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
>> @@ -4662,6 +4672,33 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
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
>> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +		set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>> /* Called from break_lease() with i_lock held. */
>> static bool
>> nfsd_break_deleg_cb(struct file_lock *fl)
>> @@ -4670,6 +4707,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>> 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>> 	struct nfs4_file *fp = dp->dl_stid.sc_file;
>>
>> +	if (nfsd_check_courtesy_client(dp))
>> +		return false;
>> 	trace_nfsd_cb_recall(&dp->dl_stid);
>>
>> 	/*
>> @@ -4912,6 +4951,136 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>> }
>>
>> +static bool
>> +__nfs4_check_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
>> +			bool share_access)
>> +{
>> +	if (share_access) {
>> +		if (!stp->st_deny_bmap)
>> +			return false;
>> +
>> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
> Aren't the NFS4_SHARE_DENY macros already bit masks?
>
> NFS4_SHARE_DENY_BOTH is (NFS4_SHARE_DENY_READ | NFS4_SHARE_DENY_WRITE).

I think the protocol defines these as constants and nfsd uses them
to set the bitmap in st_deny_bmap. See set_deny().

>
>
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
>> + * access: if share_access is true then check access mode else check deny mode
>> + */
>> +static bool
>> +nfs4_check_deny_bmap(struct nfs4_client *clp, struct nfs4_file *fp,
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
>> +				if (__nfs4_check_deny_bmap(stp, access,
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
>> + * Function to check if the nfserr_share_denied error for 'fp' resulted
>> + * from conflict with courtesy clients then release their state to resolve
>> + * the conflict.
>> + *
>> + * Function returns:
>> + *	 0 -  no conflict with courtesy clients
>> + *	>0 -  conflict with courtesy clients resolved, try access/deny check again
>> + *	-1 -  conflict with courtesy clients being resolved in background
>> + *            return nfserr_jukebox to NFS client
>> + */
>> +static int
>> +nfs4_destroy_clnts_with_sresv_conflict(struct svc_rqst *rqstp,
>> +			struct nfs4_file *fp, struct nfs4_ol_stateid *stp,
>> +			u32 access, bool share_access)
>> +{
>> +	int cnt = 0;
>> +	int async_cnt = 0;
>> +	bool no_retry = false;
>> +	struct nfs4_client *cl;
>> +	struct list_head *pos, *next, reaplist;
>> +	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +
>> +	INIT_LIST_HEAD(&reaplist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		cl = list_entry(pos, struct nfs4_client, cl_lru);
>> +		/*
>> +		 * check all nfs4_ol_stateid of this client
>> +		 * for conflicts with 'access'mode.
>> +		 */
>> +		if (nfs4_check_deny_bmap(cl, fp, stp, access, share_access)) {
>> +			if (!test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
>> +				/* conflict with non-courtesy client */
>> +				no_retry = true;
>> +				cnt = 0;
>> +				goto out;
>> +			}
>> +			/*
>> +			 * if too many to resolve synchronously
>> +			 * then do the rest in background
>> +			 */
>> +			if (cnt > 100) {
>> +				set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
>> +				async_cnt++;
>> +				continue;
>> +			}
>> +			if (mark_client_expired_locked(cl))
>> +				continue;
>> +			cnt++;
>> +			list_add(&cl->cl_lru, &reaplist);
>> +		}
>> +	}
> Bruce suggested simply returning NFS4ERR_DELAY for all cases.
> That would simplify this quite a bit for what is a rare edge
> case.

If we always do NFS4ERR_DELAY then we have to modify pynfs' OPEN18
to handle NFS4ERR_DELAY. Since I don't think this code is overly
complicated and most of the time in real usage, if there is a share
reservation conflict nfsd should be able to resolve it synchronously
avoiding the NFS4ERR_DELAY and also it'd be nice if we don't have
to modify pynfs test.

>
>
>> +out:
>> +	spin_unlock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &reaplist) {
>> +		cl = list_entry(pos, struct nfs4_client, cl_lru);
>> +		list_del_init(&cl->cl_lru);
>> +		expire_client(cl);
>> +	}
> A slightly nicer construct here would be something like this:
>
> 	while ((pos = list_del_first(&reaplist)))
> 		expire_client(list_entry(pos, struct nfs4_client, cl_lru));

You meant llist_del_first?
The above code follows the style in nfs4_laundromat. Can I keep the
same to avoid doing retest?

>
>
>> +	if (async_cnt) {
>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>> +		if (!no_retry)
>> +			cnt = -1;
>> +	}
>> +	return cnt;
>> +}
>> +
>> static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> 		struct nfsd4_open *open)
>> @@ -4921,6 +5090,7 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 	int oflag = nfs4_access_to_omode(open->op_share_access);
>> 	int access = nfs4_access_to_access(open->op_share_access);
>> 	unsigned char old_access_bmap, old_deny_bmap;
>> +	int cnt = 0;
>>
>> 	spin_lock(&fp->fi_lock);
>>
>> @@ -4928,16 +5098,38 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 	 * Are we trying to set a deny mode that would conflict with
>> 	 * current access?
>> 	 */
>> +chk_deny:
>> 	status = nfs4_file_check_deny(fp, open->op_share_deny);
>> 	if (status != nfs_ok) {
>> 		spin_unlock(&fp->fi_lock);
>> +		if (status != nfserr_share_denied)
>> +			goto out;
>> +		cnt = nfs4_destroy_clnts_with_sresv_conflict(rqstp, fp,
>> +				stp, open->op_share_deny, false);
>> +		if (cnt > 0) {
>> +			spin_lock(&fp->fi_lock);
>> +			goto chk_deny;
> I'm pondering whether a distributed set of clients can
> cause this loop to never terminate.

I'm not clear how we can get into an infinite loop, can you elaborate?

To get into an infinite loop, there must be stream of new clients that
open the file with the conflict access mode *and* become courtesy client
before we finish expiring all existing courtesy clients that have access
conflict this OPEN.

>
>
>> +		}
>> +		if (cnt == -1)
>> +			status = nfserr_jukebox;
>> 		goto out;
>> 	}
>>
>> 	/* set access to the file */
>> +get_access:
>> 	status = nfs4_file_get_access(fp, open->op_share_access);
>> 	if (status != nfs_ok) {
>> 		spin_unlock(&fp->fi_lock);
>> +		if (status != nfserr_share_denied)
>> +			goto out;
>> +		cnt = nfs4_destroy_clnts_with_sresv_conflict(rqstp, fp,
>> +				stp, open->op_share_access, true);
>> +		if (cnt > 0) {
>> +			spin_lock(&fp->fi_lock);
>> +			goto get_access;
> Ditto.
>
>
>> +		}
>> +		if (cnt == -1)
>> +			status = nfserr_jukebox;
>> 		goto out;
>> 	}
>>
>> @@ -5289,6 +5481,22 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
>> 	 */
>> }
>>
>> +static bool
>> +nfs4_destroy_courtesy_client(struct nfs4_client *clp)
>> +{
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +
>> +	spin_lock(&nn->client_lock);
>> +	if (!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ||
>> +			mark_client_expired_locked(clp)) {
>> +		spin_unlock(&nn->client_lock);
>> +		return false;
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +	expire_client(clp);
>> +	return true;
>> +}
>> +
> Perhaps nfs4_destroy_courtesy_client() could be merged into
> nfsd4_fl_expire_lock(), it's only caller.

ok, will be in v7 patch.

>
>
>> __be32
>> nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
>> {
>> @@ -5572,6 +5780,47 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>> }
>> #endif
>>
>> +static
>> +bool nfs4_anylock_conflict(struct nfs4_client *clp)
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
> Isn't cl_lock needed to protect the cl_ownerstr_hashtbl lists?

Yes, thanks Chuck! will be in v7

>
>
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
>> @@ -5587,7 +5836,9 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 	};
>> 	struct nfs4_cpntf_state *cps;
>> 	copy_stateid_t *cps_t;
>> +	struct nfs4_stid *stid;
>> 	int i;
>> +	int id = 0;
>>
>> 	if (clients_still_reclaiming(nn)) {
>> 		lt.new_timeo = 0;
>> @@ -5608,8 +5859,33 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 	spin_lock(&nn->client_lock);
>> 	list_for_each_safe(pos, next, &nn->client_lru) {
>> 		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
>> +			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +			goto exp_client;
>> +		}
>> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +			if (ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
>> +				goto exp_client;
>> +			/*
>> +			 * after umount, v4.0 client is still
>> +			 * around waiting to be expired
>> +			 */
>> +			if (clp->cl_minorversion)
>> +				continue;
>> +		}
>> 		if (!state_expired(&lt, clp->cl_time))
>> 			break;
>> +		spin_lock(&clp->cl_lock);
>> +		stid = idr_get_next(&clp->cl_stateids, &id);
>> +		spin_unlock(&clp->cl_lock);
>> +		if (stid && !nfs4_anylock_conflict(clp)) {
>> +			/* client still has states */
>> +			clp->courtesy_client_expiry =
>> +				ktime_get_boottime_seconds() + courtesy_client_expiry;
>> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +			continue;
>> +		}
>> +exp_client:
>> 		if (mark_client_expired_locked(clp))
>> 			continue;
>> 		list_add(&clp->cl_lru, &reaplist);
>> @@ -5689,9 +5965,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>> }
>>
>> -static struct workqueue_struct *laundry_wq;
>> -static void laundromat_main(struct work_struct *);
>> -
>> static void
>> laundromat_main(struct work_struct *laundry)
>> {
>> @@ -6496,6 +6769,19 @@ nfs4_transform_lock_offset(struct file_lock *lock)
>> 		lock->fl_end = OFFSET_MAX;
>> }
>>
>> +/* return true if lock was expired else return false */
>> +static bool
>> +nfsd4_fl_expire_lock(struct file_lock *fl, bool testonly)
>> +{
>> +	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)fl->fl_owner;
>> +	struct nfs4_client *clp = lo->lo_owner.so_client;
>> +
>> +	if (testonly)
>> +		return test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ?
>> +			true : false;
> Hm. I know test_bit() returns an integer rather than a boolean, but
> the ternary here is a bit unwieldy. How about just:
>
> 		return !!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);

ok, will be in v7.

>
>
>> +	return nfs4_destroy_courtesy_client(clp);
>> +}
>> +
>> static fl_owner_t
>> nfsd4_fl_get_owner(fl_owner_t owner)
>> {
>> @@ -6543,6 +6829,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>> 	.lm_notify = nfsd4_lm_notify,
>> 	.lm_get_owner = nfsd4_fl_get_owner,
>> 	.lm_put_owner = nfsd4_fl_put_owner,
>> +	.lm_expire_lock = nfsd4_fl_expire_lock,
>> };
>>
>> static inline void
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e73bdbb1634a..93e30b101578 100644
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
>> @@ -385,6 +387,7 @@ struct nfs4_client {
>> 	struct list_head	async_copies;	/* list of async copies */
>> 	spinlock_t		async_lock;	/* lock for async copies */
>> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +	int			courtesy_client_expiry;
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
