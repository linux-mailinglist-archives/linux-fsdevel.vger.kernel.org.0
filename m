Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4B4A9D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 18:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376716AbiBDRDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 12:03:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11800 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234763AbiBDRDI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:03:08 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214GTSUe010693;
        Fri, 4 Feb 2022 17:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1B+9W9wlB4a+8+sV6oYDjBS7LEd9Jaee5nfFbbCt7oQ=;
 b=CQlS+2uQqxSiNUdKmQBVtGYkfsrozzUUhGiCm9a6T2oqJocQWZ0MGWV/eqmMTN+ptFiG
 ihj5IBKYblJhqg3MlqSDkH/Vrf2LdR/NOESfzqn+FAEsdBBGxxWleVaUB+EosuACuX49
 b4rxyK13GuZAM4aBJKob7K10nSkffNWxeyCQex93fybWhfwmphhSGMJ96XYNSTpZenL4
 wGdAS5680qxuoJddFs1rwt84p2GsX+ZW8TJXw/qdebiMbikNqewaRTaAQzxfkLSt2N9f
 jfQK14FZgqQJUVaEiqPTfEbTDlu+zIdn1lbu6zXllWCHZ+cesE5iFtRNp7phSy33jJ2W 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hfsu7sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 17:03:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214H2EGQ122628;
        Fri, 4 Feb 2022 17:03:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3030.oracle.com with ESMTP id 3dvumnsda8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 17:03:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZULdn5bt1FWPezUZlzO9ywJGoNYVErvLBAEulOB1tH7N6x6hceZQ5qz/jbBzvgmAEdfsWBYdnRKsTKWQ6E+r9z3tZNPu1wjPGpfcnr/B9hMp8HQ+Cfj0x2XGq9fuSY1RP2GB85E0ueD7KcKJp+fBvXOUPraMesnpHCnL3v8uaSwOB7og4sZK76VxVcwr+NT8Bl/p14z68cdkcCd2QvEnqPOIduhvUGLFgHNJcFj77shLjmfEVWh0kNoFN2AwmBbnBfwBoLtsgtV7Zk3ezvpGlIuYh6UzNv9lo1TfWPOFYDpSHuIbs1uSkVBfdTHt9bXrbulMqEM8ZWdTV3wPlU39+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B+9W9wlB4a+8+sV6oYDjBS7LEd9Jaee5nfFbbCt7oQ=;
 b=EhNcGGb/159h2Y032uM098zNFeuWnD5Dtf9o+5v6yWL2RVa6WHAyt9NREaDzsdzmwSxpNpA92BxNsfZmS6mFZxW4pz6oa+rZw3VMTmorpKAv29IsevzmQONjRcBGK5/dWsf6Z91y7r0vRFvUYCaadGk2dOVehBsUhcC6/ch7IQrUUC6+yPm1tQImYrlJv/gCM/1CA7XXvF0u6acwCpg0FsrJPwrDHYsG+jri8R2wKZJOMIVNRCR3mh8thgdT+uKIFlMCX8t/eLSX9Hr25pzykgUnFOIFErYtyCZE9NklffnMfwShHEI6Epg53fpvMYlYRPbysOK7o/FLC/v7c6hxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B+9W9wlB4a+8+sV6oYDjBS7LEd9Jaee5nfFbbCt7oQ=;
 b=hPeXCJJFxWpmcOu5x+Q86J5SRDOYtz8lLIi+IqoIBlh4Eo26IUWzNSgK4F5/40uEizUfA3NM/YxzHWpWso3DllYxBPQUEO/7F/hpVZpmp2Tov5Z/bGIiMaoVRBqy22L9p16gcPUpE0bAu3JilPufiJNA69ZHj2OXvPoXa2okm40=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB5173.namprd10.prod.outlook.com (2603:10b6:408:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 17:03:02 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%6]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 17:03:02 +0000
Message-ID: <8dee77c4-05cc-3722-9b57-096aa45fd10f@oracle.com>
Date:   Fri, 4 Feb 2022 09:02:59 -0800
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
 <9abcb71b-6a1b-941d-5125-c812a13b549e@oracle.com>
 <36731CD8-E35E-436F-AF1A-9F97C0ADCA57@oracle.com>
 <36d579fa-8d7b-113c-704a-479b7365173b@oracle.com>
 <1C0AD92E-900C-4F47-9255-A50CE184F241@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <1C0AD92E-900C-4F47-9255-A50CE184F241@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2b35a0c-cead-4def-c328-08d9e800341e
X-MS-TrafficTypeDiagnostic: BN0PR10MB5173:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5173F9B78C0600549FA1600987299@BN0PR10MB5173.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOr0t1Hxr4hnohxsfWiPXZUCn8bcDmHHTByc45OpocvBCn8fnuNCtgPUt9TQc/zOJ/r+dklN+1NvgP5MTG9IaaGw74aOZ5K0wCiVid03Dk9/ixapKDVj7ml4Ncr4+4iYL+oUJChWVipwLtEWa0I/uBK1mfWb5rOikU2xZEnZiR7Lg/KkD+7WVcBr4IqHvHZtUI4Ci9xvNXYtMtXRNRbX6kTyskHBBUHB2MRZJK2muB7YF1eEOn4aC0U3cIzZ6jjTPRkrr0sHJab46KoYhzcCmiyZltrTbzGP9K3Cmewf+o+oL3V+9Erm+P78trZhTwAJ/LtI5Vai6lhNwC48QpDZRhNVVaeNLhAAbFiSiDq3xVbSpfHbrUdy7I5E4HOa3fV4ybhCXNwD425C5i7/peAjJ8llWCHuF4TY1PBeAJevaDVVNYJxPLuPZAtDIsjKTTeZMK3gnWcJs9jKBYPs7avH6sE9+xsDR0N9BqloPOCsYjfaBnNG2wTrvKXfsykwy5GNiCJTUSl7tc5+kf4uME264uTggjADbbrN2409AUTuiGGRwR0JKzXUxYz/SscGMFZOjxlT0BZ8l1oWfKO2ozZ+5ETYDc4AFUgunTcEJCnd8CnspWddk0KUdMrm9xO4gYc5PCCRB5MebdXOpw87ZTOf5eHpHpco1lT5rNkS9ZuPnk4bzHnXbzJVQmiSwJiKnZ/l6PMzzG4KMaM6fHIbEF5X6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6486002)(37006003)(38100700002)(9686003)(6512007)(83380400001)(26005)(186003)(2616005)(53546011)(508600001)(6506007)(6666004)(86362001)(2906002)(5660300002)(31696002)(36756003)(31686004)(8676002)(6862004)(4326008)(316002)(66946007)(66476007)(8936002)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENwdm1rZUNMdHhESVdWR1p2Mkd5NWxQUHVqaW9ZYVFyVkNxV0QxQnJGaVdX?=
 =?utf-8?B?QmJuV0s2ZG5kL0tCUDUrK29STEZaUU1aV2owOVQvdklZcU53VGVOdXBLOTNP?=
 =?utf-8?B?YkhoY2cyNUNiejE1ancrUmVhUVBHcW45YkJxRHdobUpmbXhJLzc1cUVHL0Y2?=
 =?utf-8?B?anVzdUxIRGFZa0RLS05FVWdya0theVpNelg5OFVqYkRSczJ2YWhpNURETHFh?=
 =?utf-8?B?dmk4VTUrdHM1WkZLNUc4YlRHczllaHpRVVJ5Y01YWnZSTzFYTnpIcWdKalhn?=
 =?utf-8?B?dTkzOExqUVh4ZXZIcm55Wkc1cExkZElFSmpaNkdJLzFQTWxhK1RHdXRsdks0?=
 =?utf-8?B?b3pURVF6K2VaNTh6N1VkbG1xUWVOaTFpUFlBZ3ZyT3JsVUEvK2J1RjFqSklw?=
 =?utf-8?B?Rll4T3p0YWRyNjJVMHlYbU5oSDNvMmNVYjlhOGNSaHEvV08ycmp0MkZkcWpW?=
 =?utf-8?B?eFdmcmpzaTRnQThMVG9Gb2x3bGJQek45YnlIZDluT3Bjc3NKRGpmYWs0WVd3?=
 =?utf-8?B?eUViZS9jREZ3RFozbXpKOTZHdklKVUhvaGE4dXhTN2o2QXY5NVdGU2ZMMnBE?=
 =?utf-8?B?TURJQVdSN1Q5UXg5cjI1a0N0U2VUMklFQkNod0tveU1LdGZYR3Rlb250eVAz?=
 =?utf-8?B?V2pBNVMxRzBlZWtJTDczZ3dseWhNYmJ3aDdUaHkxTFBkdjErVTBaSXd1dFVP?=
 =?utf-8?B?Q2Zia1RPMUZDZ2tJRlZhRnJwSVhaMk1SSGd3c0tFUTBFdjdKck4zeUdndDFN?=
 =?utf-8?B?WUVHZlBZUHhlb0RhenZlSXNObnMxSVl1c25mQ3ZIUTd6MDN0anRXc0gwUTBV?=
 =?utf-8?B?eEszL1ZxK1dqeVJoeTFVMHhRWFBTWlVBdlprOVhjSVZNL3ZXTXhneUtqSTc2?=
 =?utf-8?B?SlVrVzkzNndnbVBWR2poU0lVMWpuVnlhREdKOEhZNDB0bnp0bHRGRW1aUW04?=
 =?utf-8?B?UUMwV1Q0cDFFVzdFV1EwK3REeDlBY0IzTzhiVzkrVHVkcHRpN3RteW80cGF1?=
 =?utf-8?B?eTVTSVFDOU9XYi9pUXM3bHJHZldGV1QxVjV6aytocUI3SU9QWHE1cURRTlp3?=
 =?utf-8?B?TTlDMVJVbzc4ZWl6OHVrMGt5Y0R6QVUvQkRYZzdHbTZWYWZSeGNHVktwdEQx?=
 =?utf-8?B?T3lZb1hqQms0L0x6bGhhVUVDNEVHdit5VUZaSlFPbVc3RXc0ZU9aTXFuSytI?=
 =?utf-8?B?ZXpiSmtTTmhCU2c5RTdOdmFtTGFqd01rZWNCR3pHYlVpcjZ5TTdtR1NHMFVQ?=
 =?utf-8?B?cnE5dHYrQ1dWRHpadHF4UnpLUGlVRGhrL0xra3Uydkx0OVBCdzFSMjVwNzF2?=
 =?utf-8?B?WEU5Yk1BaXhKNnR5TUszaW8zOVA3N0dVQStTRkoxcFJ0em1NTWtJTVpPWUlL?=
 =?utf-8?B?MytqSFlFWVcxaFhYUUQ4aW5ETXdReExYbkIrb25HUFNWdmM5TWV6RGdicGtZ?=
 =?utf-8?B?dDRFM3ozMDJ0OVFGdGVNMUY0cEl3L1IyUkpJWkFoeFl4NlJmQTI2TThVdThZ?=
 =?utf-8?B?bGRHUlBjSW52aGYvRDZkaWlOVllUTmZ2bUtTT2RacjNxb2szMlpSNU1XWmFG?=
 =?utf-8?B?MXRXNVNKWFdGMUFDQVdya2h0U2RrVEQ1bmJHNGF6YW14K1F1QXlRb1VzNXpI?=
 =?utf-8?B?UWJ4ckVaNk5wTDEwM0x0cWhrTEYyUitDcEJyQjUvTnhMUVJ1cUtsOEJDTFdS?=
 =?utf-8?B?S20vQU0zKzNJa0JjTjVsT1ZVTXNkM0tFWFNyMERxaFdNelMwK0RPTlpoL1Y3?=
 =?utf-8?B?WEhvbzVucjErYWNnc0JoQkwwZFVPeHVKaElVVjczZkVYK040dDhHM0ZTTlpK?=
 =?utf-8?B?Mi9hdTByYmFNb1pzNEtTTll4OXBud1p5Rkl3bHpUK3JxV2p4M09LcWs4QmhB?=
 =?utf-8?B?SHhDWEM5cHNWRFVjYjJsN1N6T1pTOFR3b1VBMkU4TGQwelkzSS9jYTczNDFK?=
 =?utf-8?B?MzFTaVlsaURUSXVqOWpUeXFzS1NKcEEzZWJ3UnBtV21SUjJyVFN0UllyK0Yw?=
 =?utf-8?B?N1hPN2tJaGcyWkhmSGVQSGkvKzdKMDVrSlhVWGRhaGc0YllweTFVRTBpWFY1?=
 =?utf-8?B?cGtXTCtZd01aM09TRTZqcFpzM28vRjZWZGlWdkZpalVaQVo0WUUrbGVObWNO?=
 =?utf-8?B?Y3ZBK2FqZFcxYW9icnRBYzRjMklqZzRjMHU4TmV1M3RvWFZoaDg2eThHMTRX?=
 =?utf-8?Q?O3bbYvvTB8+GtLSi8TfWbHY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b35a0c-cead-4def-c328-08d9e800341e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 17:03:02.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kc+toC2vkqiPF+3mQIxmJkAjf8Lbxh5eGAkB83sJiNQ6fhecSLLbQMjt5qy72Kezx6PVcyuI1qCA3H6y9WrBUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5173
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10248 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040095
X-Proofpoint-GUID: 03yiszTuH1HgWfPO0rg4LNZPZdPTbA8y
X-Proofpoint-ORIG-GUID: 03yiszTuH1HgWfPO0rg4LNZPZdPTbA8y
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/4/22 7:25 AM, Chuck Lever III wrote:
>
>> On Feb 3, 2022, at 10:42 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 2/3/22 3:40 PM, Chuck Lever III wrote:
>>>> On Feb 3, 2022, at 4:38 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>>
>>>> On 2/3/22 11:31 AM, Chuck Lever III wrote:
>>>>>> On Jan 28, 2022, at 2:39 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>
>>>>>> Currently an NFSv4 client must maintain its lease by using the at least
>>>>>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
>>>>>> a singleton SEQUENCE (4.1) at least once during each lease period. If the
>>>>>> client fails to renew the lease, for any reason, the Linux server expunges
>>>>>> the state tokens immediately upon detection of the "failure to renew the
>>>>>> lease" condition and begins returning NFS4ERR_EXPIRED if the client should
>>>>>> reconnect and attempt to use the (now) expired state.
>>>>>>
>>>>>> The default lease period for the Linux server is 90 seconds.  The typical
>>>>>> client cuts that in half and will issue a lease renewing operation every
>>>>>> 45 seconds. The 90 second lease period is very short considering the
>>>>>> potential for moderately long term network partitions.  A network partition
>>>>>> refers to any loss of network connectivity between the NFS client and the
>>>>>> NFS server, regardless of its root cause.  This includes NIC failures, NIC
>>>>>> driver bugs, network misconfigurations & administrative errors, routers &
>>>>>> switches crashing and/or having software updates applied, even down to
>>>>>> cables being physically pulled.  In most cases, these network failures are
>>>>>> transient, although the duration is unknown.
>>>>>>
>>>>>> A server which does not immediately expunge the state on lease expiration
>>>>>> is known as a Courteous Server.  A Courteous Server continues to recognize
>>>>>> previously generated state tokens as valid until conflict arises between
>>>>>> the expired state and the requests from another client, or the server
>>>>>> reboots.
>>>>>>
>>>>>> The initial implementation of the Courteous Server will do the following:
>>>>>>
>>>>>> . When the laundromat thread detects an expired client and if that client
>>>>>> still has established state on the Linux server and there is no waiters
>>>>>> for the client's locks then deletes the client persistent record and marks
>>>>>> the client as COURTESY_CLIENT and skips destroying the client and all of
>>>>>> state, otherwise destroys the client as usual.
>>>>>>
>>>>>> . Client persistent record is added to the client database when the
>>>>>> courtesy client reconnects and transits to normal client.
>>>>>>
>>>>>> . Lock/delegation/share reversation conflict with courtesy client is
>>>>>> resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
>>>>>> effectively disable it, then allow the current request to proceed
>>>>>> immediately.
>>>>>>
>>>>>> . Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed to
>>>>>> reconnect to reuse itsstate. It is expired by the laundromat asynchronously
>>>>>> in the background.
>>>>>>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>> fs/nfsd/nfs4state.c | 454 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>>>>> fs/nfsd/state.h     |   5 +
>>>>>> 2 files changed, 415 insertions(+), 44 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 1956d377d1a6..b302d857e196 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -1913,14 +1915,37 @@ __find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net)
>>>>>>
>>>>>> static struct nfsd4_session *
>>>>>> find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>>>>>> -		__be32 *ret)
>>>>>> +		__be32 *ret, bool *courtesy_clnt)
>>>>> IMO the new @courtesy_clnt parameter isn't necessary.
>>>>> Just create a new cl_flag:
>>>>>
>>>>> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
>>>>> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
>>>>>
>>>>> #define NFSD4_CLIENT_PROMOTE_COURTESY   (8)
>>>>>
>>>>> or REHYDRATE_COURTESY some such.
>>>>>
>>>>> Set that flag and check it once it is safe to call
>>>>> nfsd4_client_record_create().
>>>> We need the 'courtesy_clnt' parameter so caller can specify
>>>> whether the courtesy client should be promoted or not.
>>> I understand what the flag is used for in the patch, but I
>>> prefer to see this implemented without changing the synopsis
>>> of all those functions. Especially adding an output parameter
>>> like this is usually frowned upon.
>>>
>>> The struct nfs_client can carry this flag, if not in cl_flags,
>>> then perhaps in another field. That struct is visible in every
>>> one of the callers.
>> The struct nfs4_client is not available to the caller of
>> find_in_sessionid_hashtbl at the time it calls the function and
>> the current input parameters of find_in_sessionid_hashtbl can
>> not be used to specify this flag.
> I see three callers of find_in_sessionid_hashtbl():
>
> - nfsd4_bind_conn_to_session
> - nfsd4_destroy_session
> - nfsd4_sequence
>
> In none of these callers is the courtesy_clnt variable set
> to a true or false value _before_ find_in_sessionid_hashtbl()
> is called. AFAICT, @courtesy_clnt is an output-only parameter.

If a caller is interested in the courtesy client, it passes
in the address of courtesy_clnt and find_in_sessionid_hashtbl
will take appropriate action and return the result, otherwise
pass in a NULL.

-Dai

>
> The returned @session::se_client field points to a client
> that can be examined to see if it has been promoted back to
> active status.
>
> --
> Chuck Lever
>
>
>
