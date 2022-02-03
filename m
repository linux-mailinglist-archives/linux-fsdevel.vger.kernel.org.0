Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACB24A900D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 22:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbiBCVjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 16:39:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29504 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231713AbiBCVjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:39:08 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213L42xa012565;
        Thu, 3 Feb 2022 21:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9KXnUn33EqC2BtXr8GukRAbgcPRHFXHpf/DOvx6eUtA=;
 b=ksuZErxSjrT6YUGg9r1w9RIM52z4/zTydRc4M/6sazFn7HEKpqsmTPy6qPBC//ohBPWo
 SC2XLVCcLj8Ii7BHtp21iHl91NRBdYpfY5cg3h3HXoLcGomJWIOMKfInEa+wCFzQsUe9
 Bvxw0cI2GUxsqbzFPkQuNO63AjSUivIrYu/yPJ1W736j4Huqk9o6UMtfY/4yyiYmVCjW
 CFY7NwXaaFslpEIL/TxAEjr+5jS94i+ARLQWzD+iwPvBUNbpzWj4+uvlK8vpAoXrdTtC
 RO99CU9ttxT2QW69A6DJH49zqbp/pkmWyvM7NL3kwsVZ8CVFBNk9I2UL+2Mq0fmGPkSf nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hevs15k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 21:39:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213LZoAa029638;
        Thu, 3 Feb 2022 21:39:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3030.oracle.com with ESMTP id 3dvummc094-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 21:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IveDmnEswYoV0x0dSMsVXGlARIeo0ti18A2n1eAPWw0l0el7XAk8R0UECAwqLokuxl9zEqQaNUPQL+bE+SP7HlDeAX6LMgqeQT0L9ThcvLLxrk9q+AbwvcU0NtMhV5Y7w+h3fklKVQs/V2ALbt63BgbOPIDtCsMi/8laeZtXQUmh1L+CKiWDbjqIFKu+hQNRAdBBacpyk12ZZEXfgPvmL+XSiRr3oaz3nnCWDvuB2GFHSYxka4KayAWt8f57rVAYLCh1tXvVI1Nb1zVatAQiLB7p6oPgb02lgbgc5p0uCXpSo/JJ6ZJRhBr6KQw/Hjyt5YRoy10oby7j21q4fwsUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KXnUn33EqC2BtXr8GukRAbgcPRHFXHpf/DOvx6eUtA=;
 b=lRKdbMrPOI/6hNZmVYDiSPzbTVZdA72i50tloVwmG/MwrjuRu+xkuHxQBPA+rHiHHsuszdgOu9wQPK/j881UmP51lzjEiFdJVXmx9g9gJO3OCaEn0Xb3yhL6xJOhxi8xv6LbZOfkTzhx/a+GRCQmJDBl5GmUhiaoA1UrY26C51EHrj3mOiFznPTFWjuZz/QRqD7g34fyp9uJuSrPvQ0s211pfpLkoxfyOHPpiznJwvLquhnSZEi2QBLbSPmTAkmyKzqvMVvSu+FhWyWU2kHM6P8jC3mtNnxk+RRDsktpCnZYPfrGugkbPOpcZI9/+UxUfbv1GxtgP+8rzAukkqdmjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KXnUn33EqC2BtXr8GukRAbgcPRHFXHpf/DOvx6eUtA=;
 b=gideriOVFvxaB6l+8tLveJjLXC/cVR6fynnvRKj6NFb2ZjLmmQwgaWMv/m7XY+9rVmFT7O2Voerk6qZW4q7UgQI+dp9rdNjdFz037fFomo9U/MCR/Y5BFRZMjggfBFdeoK6ighSqBENDjChM/fjIEYa75XRBFq6Msav2zundLx8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA1PR10MB5843.namprd10.prod.outlook.com (2603:10b6:806:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 21:39:02 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%6]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 21:39:02 +0000
Message-ID: <9abcb71b-6a1b-941d-5125-c812a13b549e@oracle.com>
Date:   Thu, 3 Feb 2022 13:38:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH RFC 3/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
 <1643398773-29149-4-git-send-email-dai.ngo@oracle.com>
 <3A7DD587-0511-4F04-AE9A-41595BA421F4@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <3A7DD587-0511-4F04-AE9A-41595BA421F4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72960942-4033-4248-a2f8-08d9e75d9851
X-MS-TrafficTypeDiagnostic: SA1PR10MB5843:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5843BBFC54B83716DC3ADAC687289@SA1PR10MB5843.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evk7r1xqRoSNqrwWFb1yIj9WfIs5OH2s9r+Cu0a6M2pgVe9Z533Dlnah5vG7D4SCq3fUNSjotiRNB0VrhoGBA6i55PPfqWdc7NYVuJ6/NQAUS35xvh/vvKMi+EqquLaCDs7Dl3pSV6tSo/bFpn3lYsIikirXaUk9WwXDXG/s/kw9eds871QyFFTsIIcymL3zgPA9o+WORVPBDu+faWFelZmBdqlC+jVtrZPGhMq3tMkmi5J2wcj/CKCITe6gsuD3JclFRcj/9hZZD9jrT6mHN549exMEd/kAfwIVVO6JbGDSzZ/E7vw2QUvananKIZKqi7wAIuCfJ5lyHF0cbyETpOGW0kVqzbyAjew384DHVmkK4Qxyvtp4PLOHh1Af48PgJMq3gL/MZZKfHMOEAKnwVo//8cia0i/yy2h809AAMK0Wa4vN7hgZl1x/dBJ1N0dl1FseMtqfzITWViq5CW/7myBjK0DqRvZgmTCn+umDA+WD0Qf8yrczDaVukxlqRtZ9cJI2FXqu4OsI13Cg9yO7kFHyedH0s0WOjzip7REoWgoDmv3I6jzlKEGQPxTXTuX7lAijxIa3Dhl69YIDmNiEmZ51re3CQ5Qfe/ZfSIsj/nYJ7Z9c1/45Hd6C11IQRo7eCmhD6SNzWkuROufP+KYsNU+SVE2XXr4vNf1smp3QId9gCW8FsFfywOOnj10SYgf3j3bCHNFL5SoS4SusUEWhFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(2616005)(5660300002)(31686004)(186003)(26005)(66946007)(66556008)(66476007)(8936002)(6862004)(8676002)(4326008)(508600001)(6486002)(2906002)(31696002)(38100700002)(86362001)(316002)(6506007)(6512007)(6666004)(9686003)(83380400001)(36756003)(53546011)(37006003)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjRrVGxaVnFWbFp6SjU5U0I1TTVyUHZzODZZaU05TVR6M0krQWlVeHltSFlz?=
 =?utf-8?B?VUcrZmZNTm1TRTlac09PUVVQMjFqbXdZemFMakh6ZVBMUTBabDlsbThLNy9L?=
 =?utf-8?B?VXdZZEVMcVgxTnBkYVpqbTlMMDZGWEtQYXVjY1hJUEV4Q2ZWSlZYc2RFNVhX?=
 =?utf-8?B?TUIxdlRWaXBzRFRSdVpZUENqSW0rK1BSMGdPQ2Jsc2tjY1h3ZUVpbm9QYmZa?=
 =?utf-8?B?a1A4c3hCM0dGbFE3UGhlWUVnRk1IaHUrMFplTWoxNE1wM1hUZDhHdWppTThP?=
 =?utf-8?B?S3c5SFZvRDBEOUhJbGppYTd3WENJQU5ITjZva1Buc2NiSHl4VlJjZEhBUUJP?=
 =?utf-8?B?WnN5VlB0RmZmNUc2RXQ5US8xaDBQZjV4eFA0S1BWSXFPSGJYYzNDVFY5RUw2?=
 =?utf-8?B?YXhscE94RUYyWTdSQXJIOHFLNWxZTlprd3ZjY3VIWjFGTHZ0VkU2Y0lkNzcy?=
 =?utf-8?B?V3JURG83QU4xQ3ZUU1g0ODVHWWFtRGVTaXpVcExxM0pJRkNQVHlzRnhGSmxh?=
 =?utf-8?B?NGZxWEdGUmRwL0pQODRJUThJR0ZOSnNLUjdsclBnSGNPUElNb2dBZmp2dG5l?=
 =?utf-8?B?cGZxdUpmWUFNQnlEdnhubjJYcUZoc3FrNkQwTE9aSDJsSkVnR0pkbXVRdTJl?=
 =?utf-8?B?M2crUmZ6b2xudkxHdk4zV0ZndUtpclBOT2Z1RnZwZ053Ky9qczJXbUs4YWZ0?=
 =?utf-8?B?VU1PTGtyQ0pVazBOcEo1TVhGS0g2UUNjNm1WdmFSMGh0ek8yVnBhVlFybm5L?=
 =?utf-8?B?b0tIU3A0VGRyOGN0K0JwRi92aWFyQWhUU3E4d3FYa0xzTTRVc2IwRVdUdWEr?=
 =?utf-8?B?MFNHN0l0QUhSdm1IVzNUODRDQWhTRnl6WXp5UzNYdld0TXllSmphM0M1Q1Vx?=
 =?utf-8?B?UmlVZnNoak12bURueEdWMFBSZzhReWVqNUh5a0d0c3NQVWE5UGI4LzErdEUw?=
 =?utf-8?B?TGsrNXAydEdjbmxsTnFxWWM3dHBMTmxnT0Nwd3VQOWZLS1J2MlZYN0U5Q0Nl?=
 =?utf-8?B?VjhxdWx3RElnRGtlZis3dHZJR0R5aXpnMkZxL3p1Vmo0bVY2dVB5ck5iNG5J?=
 =?utf-8?B?S1hiMlA3c2h1RUo3Vi96eFN4SFMwa3JiZHVXWFFWblQ2LzA1WUlWQ2ZJQkJ5?=
 =?utf-8?B?bkRLUUVhUjNxWmVPYUYrUFFqNEhTU2U2OWlFcWJnU2phZjZuUVZoU3ZJS3VG?=
 =?utf-8?B?Y2FhZUEyc2hEK2pGUExiME0rRmRNZ3Z6UHhnQmswSzZtRUNUV1R2VjBOVW55?=
 =?utf-8?B?YklkMFNsSkJndlQxWldaT1lHdkFHZXJUOEdLcFd1V3pOcm1reFBobTVEWHJi?=
 =?utf-8?B?SC9vVEdDRDlLMmhUS2lFNk9XRTJHTW9OTlZYbEdhZ2pWN2pqM0RxNzlsVGl4?=
 =?utf-8?B?OEoyNnJ1cm1HdjNtVitJdVZUNkFUeFZNRUd1R0czQVZGZnJXdW5sZi9oNXpK?=
 =?utf-8?B?ZC9Dd3AxSVU0WDd0TGxvN0NURDlwQy9FSHRzNXhyUU9ITXBZbGJTc1NGUlp5?=
 =?utf-8?B?QTRYcGRockhaT05SdWxHdTZIcHhnb1B0RFBYZkNNL1ZZZCtMS2xnbGE1eEVG?=
 =?utf-8?B?NWNoV2M5TmdiQVlZcXU1SGJEeHBCN0MwZzFLbTlTSG5FZlhHT0NhTUNVeTA3?=
 =?utf-8?B?Z3Q5c3ZFQUwyQlZqdlpxeDhSS3lEdFJGdDlyemJ0ci9VU1FuekxIeGVUNnU2?=
 =?utf-8?B?Z0lOQ3dZaVZydGhIVHY4TXprY1pSTzY1LzFqME96MXZDZy9MVkZJT1lLNlEv?=
 =?utf-8?B?REp4SlA0cWExaE1UVVRzNDY3VjZMS1pwVHBIMWRpb3dOYkFycURYT3QzcWJt?=
 =?utf-8?B?WE51bHFadHhvSVVtSmVUTU5VdklwcjY3aWNsWmN3eFdSSEU2a0pzS0lMRFA3?=
 =?utf-8?B?YTlBR2QrTXh1MVlOcXRMbUVxTnBCWDJ0QUMvM0dWSWdMNzJrYWE4cm1JYkNG?=
 =?utf-8?B?NjdZZ29BcDJPbTVSRnFVOWpnTDkxWVF5aWhlZ3llSkt5N3gzQ1NlRDdPeHVt?=
 =?utf-8?B?blp5QkdEdW0ya3ptZ0VXWGx2NW10VnZ6S2JrbUhlQXBIUUFJS0h4aW9jY3Yv?=
 =?utf-8?B?RjZIUkE4MzJrWHlpbFZsVXl0MFViRyttWEQ5ZS9ocVNCYlhEY252dlVrQTYw?=
 =?utf-8?B?WERzQTUrSEpSdmZValZsSG1xSHRnblUrTmhDdXNVT0VDcE5LU0NJb1N2RjNn?=
 =?utf-8?Q?lYz+Q2vcGBS3RyYTvhJh9Vo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72960942-4033-4248-a2f8-08d9e75d9851
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:39:02.5597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7Vlll2qvoG/dmJtzRIU74MHocv0EfW3mfsMMfkYnYf5ZEmCQLI/jpSlHYDqrBS40tQUTU8bVbErdC8Vn1AKHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5843
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030129
X-Proofpoint-GUID: rDBYjgXjIK675-wU_zN8s0D1DZXnYBDm
X-Proofpoint-ORIG-GUID: rDBYjgXjIK675-wU_zN8s0D1DZXnYBDm
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/3/22 11:31 AM, Chuck Lever III wrote:
>
>> On Jan 28, 2022, at 2:39 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
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
>> . When the laundromat thread detects an expired client and if that client
>> still has established state on the Linux server and there is no waiters
>> for the client's locks then deletes the client persistent record and marks
>> the client as COURTESY_CLIENT and skips destroying the client and all of
>> state, otherwise destroys the client as usual.
>>
>> . Client persistent record is added to the client database when the
>> courtesy client reconnects and transits to normal client.
>>
>> . Lock/delegation/share reversation conflict with courtesy client is
>> resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
>> effectively disable it, then allow the current request to proceed
>> immediately.
>>
>> . Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed to
>> reconnect to reuse itsstate. It is expired by the laundromat asynchronously
>> in the background.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 454 +++++++++++++++++++++++++++++++++++++++++++++++-----
>> fs/nfsd/state.h     |   5 +
>> 2 files changed, 415 insertions(+), 44 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 1956d377d1a6..b302d857e196 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
>> static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>> static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>
>> +static const int courtesy_client_expiry = (24 * 60 * 60);	/* in secs */
> Please make this a macro, not a const variable.

Fix in v11.

>
>
>> +
>> static bool is_session_dead(struct nfsd4_session *ses)
>> {
>> 	return ses->se_flags & NFS4_SESSION_DEAD;
>> @@ -1913,14 +1915,37 @@ __find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net)
>>
>> static struct nfsd4_session *
>> find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>> -		__be32 *ret)
>> +		__be32 *ret, bool *courtesy_clnt)
> IMO the new @courtesy_clnt parameter isn't necessary.
> Just create a new cl_flag:
>
> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
>
> #define NFSD4_CLIENT_PROMOTE_COURTESY   (8)
>
> or REHYDRATE_COURTESY some such.
>
> Set that flag and check it once it is safe to call
> nfsd4_client_record_create().

We need the 'courtesy_clnt' parameter so caller can specify
whether the courtesy client should be promoted or not. Also
using another flag might require the caller to get cl_cs_lock
again (I have to check whether the lock is needed for this)
so the patch might not be smaller.

> That should make this a
> much smaller patch. Anything else you can do to break
> this patch into smaller ones will help the review
> process.
>
> By the way, the new cl_flags you define in fs/nfsd/state.h
> need to be named "NFSD4_CLIENT_yyzzy". I think you can
> drop the "_CLIENT" suffix for brevity.

Fix in v11.

Thanks,
-Dai

>
>
>> {
>> 	struct nfsd4_session *session;
>> 	__be32 status = nfserr_badsession;
>> +	struct nfs4_client *clp;
>>
>> 	session = __find_in_sessionid_hashtbl(sessionid, net);
>> 	if (!session)
>> 		goto out;
>> +	clp = session->se_client;
>> +	if (courtesy_clnt)
>> +		*courtesy_clnt = false;
>> +	if (clp) {
>> +		/* need to sync with thread resolving lock/deleg conflict */
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			session = NULL;
>> +			goto out;
>> +		}
>> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +			if (!courtesy_clnt) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				session = NULL;
>> +				goto out;
>> +			}
>> +			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +			*courtesy_clnt = true;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +	}
>> 	status = nfsd4_get_session_locked(session);
>> 	if (status)
>> 		session = NULL;
>> @@ -1990,6 +2015,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>> 	INIT_LIST_HEAD(&clp->cl_openowners);
>> 	INIT_LIST_HEAD(&clp->cl_delegations);
>> 	INIT_LIST_HEAD(&clp->cl_lru);
>> +	INIT_LIST_HEAD(&clp->cl_cs_list);
>> 	INIT_LIST_HEAD(&clp->cl_revoked);
>> #ifdef CONFIG_NFSD_PNFS
>> 	INIT_LIST_HEAD(&clp->cl_lo_states);
>> @@ -1997,6 +2023,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>> 	INIT_LIST_HEAD(&clp->async_copies);
>> 	spin_lock_init(&clp->async_lock);
>> 	spin_lock_init(&clp->cl_lock);
>> +	spin_lock_init(&clp->cl_cs_lock);
>> 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>> 	return clp;
>> err_no_hashtbl:
>> @@ -2394,6 +2421,10 @@ static int client_info_show(struct seq_file *m, void *v)
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
>> @@ -2801,12 +2832,15 @@ add_clp_to_name_tree(struct nfs4_client *new_clp, struct rb_root *root)
>> }
>>
>> static struct nfs4_client *
>> -find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>> +find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root,
>> +				bool *courtesy_client)
>> {
>> 	int cmp;
>> 	struct rb_node *node = root->rb_node;
>> 	struct nfs4_client *clp;
>>
>> +	if (courtesy_client)
>> +		*courtesy_client = false;
>> 	while (node) {
>> 		clp = rb_entry(node, struct nfs4_client, cl_namenode);
>> 		cmp = compare_blob(&clp->cl_name, name);
>> @@ -2814,8 +2848,29 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>> 			node = node->rb_left;
>> 		else if (cmp < 0)
>> 			node = node->rb_right;
>> -		else
>> +		else {
>> +			/* sync with thread resolving lock/deleg conflict */
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				return NULL;
>> +			}
>> +			if (test_bit(NFSD4_COURTESY_CLIENT,
>> +					&clp->cl_flags)) {
>> +				if (!courtesy_client) {
>> +					set_bit(NFSD4_DESTROY_COURTESY_CLIENT,
>> +							&clp->cl_flags);
>> +					spin_unlock(&clp->cl_cs_lock);
>> +					return NULL;
>> +				}
>> +				clear_bit(NFSD4_COURTESY_CLIENT,
>> +					&clp->cl_flags);
>> +				*courtesy_client = true;
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>> 			return clp;
>> +		}
>> 	}
>> 	return NULL;
>> }
>> @@ -2852,15 +2907,38 @@ move_to_confirmed(struct nfs4_client *clp)
>> }
>>
>> static struct nfs4_client *
>> -find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
>> +find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions,
>> +			bool *courtesy_clnt)
>> {
>> 	struct nfs4_client *clp;
>> 	unsigned int idhashval = clientid_hashval(clid->cl_id);
>>
>> +	if (courtesy_clnt)
>> +		*courtesy_clnt = false;
>> 	list_for_each_entry(clp, &tbl[idhashval], cl_idhash) {
>> 		if (same_clid(&clp->cl_clientid, clid)) {
>> 			if ((bool)clp->cl_minorversion != sessions)
>> 				return NULL;
>> +
>> +			/* need to sync with thread resolving lock/deleg conflict */
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				continue;
>> +			}
>> +			if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +				if (!courtesy_clnt) {
>> +					set_bit(NFSD4_DESTROY_COURTESY_CLIENT,
>> +							&clp->cl_flags);
>> +					spin_unlock(&clp->cl_cs_lock);
>> +					continue;
>> +				}
>> +				clear_bit(NFSD4_COURTESY_CLIENT,
>> +							&clp->cl_flags);
>> +				*courtesy_clnt = true;
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>> 			renew_client_locked(clp);
>> 			return clp;
>> 		}
>> @@ -2869,12 +2947,13 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
>> }
>>
>> static struct nfs4_client *
>> -find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn)
>> +find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn,
>> +		bool *courtesy_clnt)
>> {
>> 	struct list_head *tbl = nn->conf_id_hashtbl;
>>
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_client_in_id_table(tbl, clid, sessions);
>> +	return find_client_in_id_table(tbl, clid, sessions, courtesy_clnt);
>> }
>>
>> static struct nfs4_client *
>> @@ -2883,7 +2962,7 @@ find_unconfirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn)
>> 	struct list_head *tbl = nn->unconf_id_hashtbl;
>>
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_client_in_id_table(tbl, clid, sessions);
>> +	return find_client_in_id_table(tbl, clid, sessions, NULL);
>> }
>>
>> static bool clp_used_exchangeid(struct nfs4_client *clp)
>> @@ -2892,17 +2971,18 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
>> }
>>
>> static struct nfs4_client *
>> -find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
>> +find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn,
>> +			bool *courtesy_clnt)
>> {
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	return find_clp_in_name_tree(name, &nn->conf_name_tree, courtesy_clnt);
>> }
>>
>> static struct nfs4_client *
>> find_unconfirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
>> {
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_clp_in_name_tree(name, &nn->unconf_name_tree);
>> +	return find_clp_in_name_tree(name, &nn->unconf_name_tree, NULL);
>> }
>>
>> static void
>> @@ -3176,7 +3256,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>
>> 	/* Cases below refer to rfc 5661 section 18.35.4: */
>> 	spin_lock(&nn->client_lock);
>> -	conf = find_confirmed_client_by_name(&exid->clname, nn);
>> +	conf = find_confirmed_client_by_name(&exid->clname, nn, NULL);
>> 	if (conf) {
>> 		bool creds_match = same_creds(&conf->cl_cred, &rqstp->rq_cred);
>> 		bool verfs_match = same_verf(&verf, &conf->cl_verifier);
>> @@ -3443,7 +3523,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>>
>> 	spin_lock(&nn->client_lock);
>> 	unconf = find_unconfirmed_client(&cr_ses->clientid, true, nn);
>> -	conf = find_confirmed_client(&cr_ses->clientid, true, nn);
>> +	conf = find_confirmed_client(&cr_ses->clientid, true, nn, NULL);
>> 	WARN_ON_ONCE(conf && unconf);
>>
>> 	if (conf) {
>> @@ -3474,7 +3554,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>> 			status = nfserr_seq_misordered;
>> 			goto out_free_conn;
>> 		}
>> -		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
>> +		old = find_confirmed_client_by_name(&unconf->cl_name, nn, NULL);
>> 		if (old) {
>> 			status = mark_client_expired_locked(old);
>> 			if (status) {
>> @@ -3613,11 +3693,13 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
>> 	struct nfsd4_session *session;
>> 	struct net *net = SVC_NET(rqstp);
>> 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	bool courtesy_clnt;
>>
>> 	if (!nfsd4_last_compound_op(rqstp))
>> 		return nfserr_not_only_op;
>> 	spin_lock(&nn->client_lock);
>> -	session = find_in_sessionid_hashtbl(&bcts->sessionid, net, &status);
>> +	session = find_in_sessionid_hashtbl(&bcts->sessionid, net, &status,
>> +				&courtesy_clnt);
>> 	spin_unlock(&nn->client_lock);
>> 	if (!session)
>> 		goto out_no_session;
>> @@ -3647,6 +3729,8 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
>> out:
>> 	nfsd4_put_session(session);
>> out_no_session:
>> +	if (status == nfs_ok && courtesy_clnt)
>> +		nfsd4_client_record_create(session->se_client);
>> 	return status;
>> }
>>
>> @@ -3676,7 +3760,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
>> 	}
>> 	dump_sessionid(__func__, sessionid);
>> 	spin_lock(&nn->client_lock);
>> -	ses = find_in_sessionid_hashtbl(sessionid, net, &status);
>> +	ses = find_in_sessionid_hashtbl(sessionid, net, &status, NULL);
>> 	if (!ses)
>> 		goto out_client_lock;
>> 	status = nfserr_wrong_cred;
>> @@ -3790,6 +3874,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	int buflen;
>> 	struct net *net = SVC_NET(rqstp);
>> 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	bool courtesy_clnt;
>>
>> 	if (resp->opcnt != 1)
>> 		return nfserr_sequence_pos;
>> @@ -3803,7 +3888,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 		return nfserr_jukebox;
>>
>> 	spin_lock(&nn->client_lock);
>> -	session = find_in_sessionid_hashtbl(&seq->sessionid, net, &status);
>> +	session = find_in_sessionid_hashtbl(&seq->sessionid, net, &status,
>> +				&courtesy_clnt);
>> 	if (!session)
>> 		goto out_no_session;
>> 	clp = session->se_client;
>> @@ -3893,6 +3979,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	if (conn)
>> 		free_conn(conn);
>> 	spin_unlock(&nn->client_lock);
>> +	if (status == nfs_ok && courtesy_clnt)
>> +		nfsd4_client_record_create(clp);
>> 	return status;
>> out_put_session:
>> 	nfsd4_put_session_locked(session);
>> @@ -3928,7 +4016,7 @@ nfsd4_destroy_clientid(struct svc_rqst *rqstp,
>>
>> 	spin_lock(&nn->client_lock);
>> 	unconf = find_unconfirmed_client(&dc->clientid, true, nn);
>> -	conf = find_confirmed_client(&dc->clientid, true, nn);
>> +	conf = find_confirmed_client(&dc->clientid, true, nn, NULL);
>> 	WARN_ON_ONCE(conf && unconf);
>>
>> 	if (conf) {
>> @@ -4012,12 +4100,18 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	struct nfs4_client	*unconf = NULL;
>> 	__be32 			status;
>> 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	bool courtesy_clnt = false;
>> +	struct nfs4_client *cclient = NULL;
>>
>> 	new = create_client(clname, rqstp, &clverifier);
>> 	if (new == NULL)
>> 		return nfserr_jukebox;
>> 	spin_lock(&nn->client_lock);
>> -	conf = find_confirmed_client_by_name(&clname, nn);
>> +	conf = find_confirmed_client_by_name(&clname, nn, &courtesy_clnt);
>> +	if (conf && courtesy_clnt) {
>> +		cclient = conf;
>> +		conf = NULL;
>> +	}
>> 	if (conf && client_has_state(conf)) {
>> 		status = nfserr_clid_inuse;
>> 		if (clp_used_exchangeid(conf))
>> @@ -4048,7 +4142,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	new = NULL;
>> 	status = nfs_ok;
>> out:
>> +	if (cclient)
>> +		unhash_client_locked(cclient);
>> 	spin_unlock(&nn->client_lock);
>> +	if (cclient)
>> +		expire_client(cclient);
>> 	if (new)
>> 		free_client(new);
>> 	if (unconf) {
>> @@ -4076,8 +4174,9 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>> 		return nfserr_stale_clientid;
>>
>> 	spin_lock(&nn->client_lock);
>> -	conf = find_confirmed_client(clid, false, nn);
>> +	conf = find_confirmed_client(clid, false, nn, NULL);
>> 	unconf = find_unconfirmed_client(clid, false, nn);
>> +
>> 	/*
>> 	 * We try hard to give out unique clientid's, so if we get an
>> 	 * attempt to confirm the same clientid with a different cred,
>> @@ -4107,7 +4206,7 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>> 		unhash_client_locked(old);
>> 		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
>> 	} else {
>> -		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
>> +		old = find_confirmed_client_by_name(&unconf->cl_name, nn, NULL);
>> 		if (old) {
>> 			status = nfserr_clid_inuse;
>> 			if (client_has_state(old)
>> @@ -4691,18 +4790,41 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>> 	return ret;
>> }
>>
>> +/*
>> + * Function returns true if lease conflict was resolved
>> + * else returns false.
>> + */
>> static bool nfsd_breaker_owns_lease(struct file_lock *fl)
>> {
>> 	struct nfs4_delegation *dl = fl->fl_owner;
>> 	struct svc_rqst *rqst;
>> 	struct nfs4_client *clp;
>>
>> +	clp = dl->dl_stid.sc_client;
>> +
>> +	/*
>> +	 * need to sync with courtesy client trying to reconnect using
>> +	 * the cl_cs_lock, nn->client_lock can not be used since this
>> +	 * function is called with the fl_lck held.
>> +	 */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +		set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +
>> 	if (!i_am_nfsd())
>> -		return NULL;
>> +		return false;
>> 	rqst = kthread_data(current);
>> 	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
>> 	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
>> -		return NULL;
>> +		return false;
>> 	clp = *(rqst->rq_lease_breaker);
>> 	return dl->dl_stid.sc_client == clp;
>> }
>> @@ -4735,12 +4857,12 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
>> }
>>
>> static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
>> -						struct nfsd_net *nn)
>> +			struct nfsd_net *nn, bool *courtesy_clnt)
>> {
>> 	struct nfs4_client *found;
>>
>> 	spin_lock(&nn->client_lock);
>> -	found = find_confirmed_client(clid, sessions, nn);
>> +	found = find_confirmed_client(clid, sessions, nn, courtesy_clnt);
>> 	if (found)
>> 		atomic_inc(&found->cl_rpc_users);
>> 	spin_unlock(&nn->client_lock);
>> @@ -4751,6 +4873,8 @@ static __be32 set_client(clientid_t *clid,
>> 		struct nfsd4_compound_state *cstate,
>> 		struct nfsd_net *nn)
>> {
>> +	bool courtesy_clnt;
>> +
>> 	if (cstate->clp) {
>> 		if (!same_clid(&cstate->clp->cl_clientid, clid))
>> 			return nfserr_stale_clientid;
>> @@ -4762,9 +4886,12 @@ static __be32 set_client(clientid_t *clid,
>> 	 * We're in the 4.0 case (otherwise the SEQUENCE op would have
>> 	 * set cstate->clp), so session = false:
>> 	 */
>> -	cstate->clp = lookup_clientid(clid, false, nn);
>> +	cstate->clp = lookup_clientid(clid, false, nn, &courtesy_clnt);
>> 	if (!cstate->clp)
>> 		return nfserr_expired;
>> +
>> +	if (courtesy_clnt)
>> +		nfsd4_client_record_create(cstate->clp);
>> 	return nfs_ok;
>> }
>>
>> @@ -4917,9 +5044,89 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>> }
>>
>> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> +static bool
>> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
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
>> + * This function is called to check whether nfserr_share_denied should
>> + * be returning to client.
>> + *
>> + * access:  is op_share_access if share_access is true.
>> + *	    Check if access mode, op_share_access, would conflict with
>> + *	    the current deny mode of the file 'fp'.
>> + * access:  is op_share_deny if share_access is false.
>> + *	    Check if the deny mode, op_share_deny, would conflict with
>> + *	    current access of the file 'fp'.
>> + * stp:     skip checking this entry.
>> + * new_stp: normal open, not open upgrade.
>> + *
>> + * Function returns:
>> + *	true   - access/deny mode conflict with normal client.
>> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
>> + */
>> +static bool
>> +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	struct nfs4_client *cl;
>> +	bool conflict = false;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		if (st->st_openstp || (st == stp && new_stp) ||
>> +			(!nfs4_check_access_deny_bmap(st,
>> +					access, share_access)))
>> +			continue;
>> +
>> +		/* need to sync with courtesy client trying to reconnect */
>> +		cl = st->st_stid.sc_client;
>> +		spin_lock(&cl->cl_cs_lock);
>> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags)) {
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		if (test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
>> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		/* conflict not caused by courtesy client */
>> +		spin_unlock(&cl->cl_cs_lock);
>> +		conflict = true;
>> +		break;
>> +	}
>> +	return conflict;
>> +}
>> +
>> +static __be32
>> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>> {
>> 	struct nfsd_file *nf = NULL;
>> 	__be32 status;
>> @@ -4935,15 +5142,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 	 */
>> 	status = nfs4_file_check_deny(fp, open->op_share_deny);
>> 	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_deny, false)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> 	}
>>
>> 	/* set access to the file */
>> 	status = nfs4_file_get_access(fp, open->op_share_access);
>> 	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_access, true)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> 	}
>>
>> 	/* Set access bits in stateid */
>> @@ -4994,7 +5215,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>> 	unsigned char old_deny_bmap = stp->st_deny_bmap;
>>
>> 	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>
>> 	/* test and set deny mode */
>> 	spin_lock(&fp->fi_lock);
>> @@ -5343,7 +5564,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>> 			goto out;
>> 		}
>> 	} else {
>> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>> 		if (status) {
>> 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>> 			release_open_stateid(stp);
>> @@ -5577,6 +5798,122 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>> }
>> #endif
>>
>> +static bool
>> +nfs4_anylock_blocker(struct nfs4_client *clp)
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
>> +	spin_lock(&clp->cl_lock);
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
>> +					if (!list_empty(&fl->fl_blocked_requests)) {
>> +						spin_unlock(&clp->cl_lock);
>> +						return true;
>> +					}
>> +				}
>> +			}
>> +		}
>> +	}
>> +	spin_unlock(&clp->cl_lock);
>> +	return false;
>> +}
>> +
>> +static void
>> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> +				struct laundry_time *lt)
>> +{
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +	bool cour;
>> +	struct list_head cslist;
>> +
>> +	INIT_LIST_HEAD(reaplist);
>> +	INIT_LIST_HEAD(&cslist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (!state_expired(lt, clp->cl_time))
>> +			break;
>> +
>> +		/* client expired */
>> +		if (!client_has_state(clp)) {
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +
>> +		/* expired client has state */
>> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags))
>> +			goto exp_client;
>> +
>> +		cour = test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +		if (cour &&
>> +			ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
>> +			goto exp_client;
>> +
>> +		if (nfs4_anylock_blocker(clp)) {
>> +			/* expired client has state and has blocker. */
>> +exp_client:
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +		/*
>> +		 * Client expired and has state and has no blockers.
>> +		 * If there is race condition with blockers, next time
>> +		 * the laundromat runs it will catch it and expires
>> +		 * the client. Client is expected to retry on lock or
>> +		 * lease conflict.
>> +		 */
>> +		if (!cour) {
>> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +			clp->courtesy_client_expiry = ktime_get_boottime_seconds() +
>> +					courtesy_client_expiry;
>> +			list_add(&clp->cl_cs_list, &cslist);
>> +		}
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +
>> +	list_for_each_entry(clp, &cslist, cl_cs_list) {
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags) ||
>> +			!test_bit(NFSD4_COURTESY_CLIENT,
>> +					&clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		nfsd4_client_record_remove(clp);
>> +	}
>> +}
>> +
>> static time64_t
>> nfs4_laundromat(struct nfsd_net *nn)
>> {
>> @@ -5610,16 +5947,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 	}
>> 	spin_unlock(&nn->s2s_cp_lock);
>>
>> -	spin_lock(&nn->client_lock);
>> -	list_for_each_safe(pos, next, &nn->client_lru) {
>> -		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> -		if (!state_expired(&lt, clp->cl_time))
>> -			break;
>> -		if (mark_client_expired_locked(clp))
>> -			continue;
>> -		list_add(&clp->cl_lru, &reaplist);
>> -	}
>> -	spin_unlock(&nn->client_lock);
>> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>> 	list_for_each_safe(pos, next, &reaplist) {
>> 		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> 		trace_nfsd_clid_purged(&clp->cl_clientid);
>> @@ -5998,7 +6326,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
>> 	cps->cpntf_time = ktime_get_boottime_seconds();
>>
>> 	status = nfserr_expired;
>> -	found = lookup_clientid(&cps->cp_p_clid, true, nn);
>> +	found = lookup_clientid(&cps->cp_p_clid, true, nn, NULL);
>> 	if (!found)
>> 		goto out;
>>
>> @@ -6501,6 +6829,43 @@ nfs4_transform_lock_offset(struct file_lock *lock)
>> 		lock->fl_end = OFFSET_MAX;
>> }
>>
>> +/**
>> + * nfsd4_fl_lock_conflict - check if lock conflict can be resolved.
>> + *
>> + * @fl: pointer to file_lock with a potential conflict
>> + * Return values:
>> + *   %true: real conflict, lock conflict can not be resolved.
>> + *   %false: no conflict, lock conflict was resolved.
>> + *
>> + * Note that this function is called while the flc_lock is held.
>> + */
>> +static bool
>> +nfsd4_fl_lock_conflict(struct file_lock *fl)
>> +{
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_client *clp;
>> +	bool rc = true;
>> +
>> +	if (!fl)
>> +		return true;
>> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
>> +	clp = lo->lo_owner.so_client;
>> +
>> +	/* need to sync with courtesy client trying to reconnect */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags))
>> +		rc = false;
>> +	else {
>> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
>> +			rc =  false;
>> +		} else
>> +			rc =  true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return rc;
>> +}
>> +
>> static fl_owner_t
>> nfsd4_fl_get_owner(fl_owner_t owner)
>> {
>> @@ -6548,6 +6913,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>> 	.lm_notify = nfsd4_lm_notify,
>> 	.lm_get_owner = nfsd4_fl_get_owner,
>> 	.lm_put_owner = nfsd4_fl_put_owner,
>> +	.lm_lock_conflict = nfsd4_fl_lock_conflict,
>> };
>>
>> static inline void
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e73bdbb1634a..b75f4c70706d 100644
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
>> @@ -385,6 +387,9 @@ struct nfs4_client {
>> 	struct list_head	async_copies;	/* list of async copies */
>> 	spinlock_t		async_lock;	/* lock for async copies */
>> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +	int			courtesy_client_expiry;
>> +	spinlock_t		cl_cs_lock;
>> +	struct list_head	cl_cs_list;
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
