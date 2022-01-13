Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF51C48D3D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 09:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiAMIwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 03:52:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55544 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbiAMIwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:52:06 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D8M4E7021040;
        Thu, 13 Jan 2022 08:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PWbnCGvIvZoxTM8l0zIIMzCr7qprq3XAktUtDAbx8Sc=;
 b=YGKkvnnlKKJnGvt0YBEE9jxN6xw5aMa/+7plvua7SKHC1JKZBWwUGFl4qlnKdp0u7k+J
 OZuX6pJJnmy2a3ANsbnvOCHw/lF7iwZOp5KuulYNlmHNsj94CFXTW4MOfVZB9lofDFMK
 bIquwdwAAdhlDy9MhoMi60Lq2pm9vwM50G7A1xGT5OThiVI3l5byj1EJqqgXlCNC1eVA
 2/gl/15A5548Sxu+3A4gSp/v23rhPvrdPYHXLiBEGqdNX/kXurehEtE/1E8ROhEsNDyE
 +KjCm+PlUB18xm9JAccVqQmIAu5Rv6XDxzqzYKTH4CY/MqWKXCnWUjUPjX608X+vBnbN zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djggm81ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 08:52:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D8oYY2149578;
        Thu, 13 Jan 2022 08:52:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3df0ngrs7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 08:52:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LctBYPey8DmUQqrBYcgC+URjCH+ZOZ5GwfsJkjgO6X8F9tL4wzoG1K4QxR8Ri3lwgFdh/JEVEmEc3eXniRDceBH6U+D9hRwzJxzn5TAi7B8+byGj8MEEW/w+QruBuAmtfsyjh+MbRv5K+Bomc1MiU3UH7i4QgLNgcHsQ+nDvee099ldR6RIJogKy6gF7yff3x+wh1wKa+YBxfMV9AoYDvWf52pHTa6exgmBIlORK5/NrWOQ7uxh7K+W3vcYC1+Hc5vbvft04yqf6U12DOuxnwnUtRw8HMxYo6WeNA5h5j7GNtm/E5AcgsmTtPMSn1E3tCDvbTElOHFI0dyoqF7APGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWbnCGvIvZoxTM8l0zIIMzCr7qprq3XAktUtDAbx8Sc=;
 b=BukRpaghtFZK4zDMfMkF1GGjK6QGA9fkfvcA6GaTSYk+Hx7u+mtnKBymr0UkITBA8FoESLivka+iCo/HBU11581SRRY8QEPXvsC4yLz6DWKw27kJydPwy+A28nsO9+DUEHyRGK9f97Uo9gBklSmPLFa758OY+3QlE7ALOdtekrABqv5iiVpnGigriDeVJ55FYd1i2IeVoqkIu2Neg5Zf/yoNwu63iLR7XIyyb/CqY5oEQaE+q0FzEA99tI83C+TeS6HjTXsVC9MmtQFSxsh8bniMMGyYNNghi0yGktjzSkDqlkbB/D6EchIFOPwkPJG81LJZ5Y7iNfGgN6roRC1c5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWbnCGvIvZoxTM8l0zIIMzCr7qprq3XAktUtDAbx8Sc=;
 b=b3ckHYwM6OtmOMaLNgoelDbsDT6WMOmvMqGDIDz0mEv1VaxTAygDs+NyiIckDreT31BMIKPWdo+jemPdbUv8fU5lrbiy0NgJE0fzeacFoEnWTSWgb95BsT+d6gLb1S4CxpT0S1mcAdEAObLz7+rBxrIZcrWUXsYYf+cmYivOhww=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB5382.namprd10.prod.outlook.com (2603:10b6:408:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 08:51:59 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 08:51:59 +0000
Message-ID: <11e9d7a9-f2f3-47a9-c76f-dc2b9010d303@oracle.com>
Date:   Thu, 13 Jan 2022 00:51:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
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
From:   dai.ngo@oracle.com
In-Reply-To: <20220112194054.GD10518@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:805:ca::48) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8be4e721-f3ab-4ace-24e4-08d9d671f5be
X-MS-TrafficTypeDiagnostic: BN0PR10MB5382:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB53826F69E1439618E293A52587539@BN0PR10MB5382.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XG9LYxTjSjzhRbXH8TftdIP5vx0YnJijbe4fqvbSPECJYxG3hKzxR54ApJddb5nTxLfICwbZGYpAIUj7XdkUVhq8gGfjgMacr+8PuAZGEUt2pIRkGkje5rMK7Db2u9BWEwo4519v8iRAMvzqgO0Hwk9T3fr1cMDXLVAPDMuzTDZCuB1O+GORDX1g5oyeyJepZJYPxaF0vu/ayhQt81TGrWi/3tOUbI1jTeMtz4I/k8OPYtdlAHFhEX4IJIApZ+HcMGAO9KwWN1+JKEMOvkTlLSsDVJihnDx80aOYzzL6EXM1IpM3xH1rbbhgIz/W6BkVU+jUGlOOXrj0oaLsyUfacR9YDz7ugHuFsw5HP2dBz5FC3e8j2kxotoRGIMpcM5k0lnz2uqrHiw7dcT1ejUSmYvaAe+uxHeyjmxM5QI3wq+CBtnyVln6wUETsP7gK7egyFalXeetSzQaePMyv4Ss+VpJ+pj1TPhCZ/QxUk9blC7vxHaRalzFTjwuJFZegwmdBRKid+pjHYNrUJH549oyFlLx5kDYnOYdIs8dvwNP4fv2gcorMmaULUaLbhRKoJNeO8LRcFhPBfgCRKD+0IRP2+iABddn87UE/nCcJwUCuF8a9BjcLCd7qJRK0Z5zuexOwjmSpoX8Emq5paxYCh0c+8NlPlDkoJivLSfhuS+8b7f4PFqcWfRGaSapVQFyTs0ez
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2906002)(83380400001)(26005)(316002)(6506007)(53546011)(6916009)(38100700002)(8936002)(8676002)(86362001)(4326008)(508600001)(6512007)(9686003)(5660300002)(31686004)(31696002)(2616005)(6486002)(66946007)(66476007)(66556008)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UENTWUhaWFB1RXdMK2FPZ2ROc1YrK0wzWmhUT2hTOWd0dVdkQm9wVUdlWTlH?=
 =?utf-8?B?MVZUYkV0WGRzcnlHeHR4V0FhcEJvN0k3Yy8zbFI4NHJMeTZCbmJ4eXpUVG00?=
 =?utf-8?B?dDA5eHo5OCs0YjBKQlR0OXdEWUd3QkhLUTF4aWJLVVEweU1DQ1FXc0x0M095?=
 =?utf-8?B?c2FkK2ozQmZqUHIwbVlPSGVnYW5DbGFMNjFETnRGOFFmbFNUN3VpdjR4N2R1?=
 =?utf-8?B?ZjNNY2d5SEZEQWtscXZUY1Z2VE9iS1B2dWU0S0xhTGhjNTVjbE51WDVUQlc4?=
 =?utf-8?B?YmdGMk1qZnZJNWxScHc3bzUvMUlKQkdpc0tsMlE2Nk9WNjR0bHNLTzV5UWZV?=
 =?utf-8?B?WW9obGlseUc2aFVXYi9wbFc0RkdFZG9uTm1pc09McW42TWoxU0c1T0Z4VW0x?=
 =?utf-8?B?aEo5bnJRN2VtK3RYcmRQNlM2U1lmYmZaTER6NW1kVWZUMFk1ck5tTklBSUg3?=
 =?utf-8?B?cU95N2k3Y1FRRnA3cEpmcW9nYjZsanBOb2lwQndhcnoyZzQrclQ4MVV5Y1o5?=
 =?utf-8?B?Mk8zKzJJbXFRQVltYWd6MmRFRW1SMWs2TjJPUXQ2TDdlZ0svd2ltZm55MDZB?=
 =?utf-8?B?TzRYU1pJUHk0aXNJc0F0dm9Xai9Eek5FZm16a0NhaTByVFAzWmtzclI0Y0o2?=
 =?utf-8?B?aitEN3NuVS83TVgyMGFnNCtaQUR2dXdCNFNHbDlud09yOGtyUWJkdFFSVGpq?=
 =?utf-8?B?VzkvSGc5UU04YzQ0a3JMdFhyRWgwdmZPZmJPenM5VGJZaWdsOVFYcmJVaDE1?=
 =?utf-8?B?OFVmRmRJalc2ZzlLQXA0bDNaOG96VU53QUdLSEluYmMyL1c1MW4xM1R6ME5G?=
 =?utf-8?B?eDFYMXYwM3Rqc0NTckZVVFJKcGRTRGNSZUk1N1hGbDcrNlBsKzlZMzVsVzFR?=
 =?utf-8?B?a3pjYlJLQlRlS29GcG8zVnl3MGY3Sk5ya1lSMnZSOFFiVWcvSHhyWVB2UXAx?=
 =?utf-8?B?c1orbmJnT1V5Y3lCTVNkMmRTVkhES01tSDU3Zlh0Vkt6SEt3ZzNjUnhRNXFF?=
 =?utf-8?B?blpkVVM5TFA1akVtU0haSHhod2tLVUR1VE81RDI2L2huMzUzWlJiMk9BKzZK?=
 =?utf-8?B?ZjBaTmVJdkxTV3JnbW9LeXRIcWkyRzhmV2syWjcvTFR4eHoyVC9rYlI0ZFdH?=
 =?utf-8?B?ZnR2OVhRYWlkZGcvMEtkZlc0QjZhSkZYZzhmdVpzTFNDUnB3R3g0ZVdzTVFw?=
 =?utf-8?B?Qyt4NFAraFI0eWhqRGZOMVY3RytpRDF2b1NmUXZmZnAyV1BEUE0xOWFrU0lF?=
 =?utf-8?B?Zno1NGFKdkg2bjlrT1NhUHBqbnFGcEZMc1BaQ1o3Y3p3OC94eHVJbkdFM2dm?=
 =?utf-8?B?c09jR2srUCt3aVA0WmZ3UHc3TGVmMFdwN0xWQ0FUOWZRaWx6QXowVVpkMjVq?=
 =?utf-8?B?aVJIc3BaUnZlenh2c3Q4TnRyTVlYaFNxaGNkdlQzaTBCa0xxbzJpNlVqQlAr?=
 =?utf-8?B?b1BUR1IraGpKYTJsLzlBMndaN2hGUGJvVlVCRkMvY0xmakxETFkwL05BZWJs?=
 =?utf-8?B?QmZnMTNmSGhnaW5LSHpLb2ZhTjA2QktuZXBVZXBQU096ZTRJY3BWVHlSQlR2?=
 =?utf-8?B?UXNSWm1pTjdidlJLckRWR0hLUnlrYkR3cFFFMFF6K1JhUlpEVnZyS2NNN3la?=
 =?utf-8?B?YWhYbGMvSTJoZXFWcHhpQUE2RWFZUnhxUzNoTFg1bUVVK2NrQXdWRzV2Vks4?=
 =?utf-8?B?dVhtRjFmSXJyWVlFSEpWNEhVUkxSZHdiSy9BNWFTcWVLUHFMNjRlZGUvRzQ1?=
 =?utf-8?B?aEpkUHV2WmVkVjhGb1p3NldGRVBKampxcUdTUnJqdUNCZDI1UUpEOVROUVpP?=
 =?utf-8?B?UFc0MUNaSjRWeDhiVGNzU0Q3TGJHQ3hzOHpSTW1XK1RZaGxOcTR4eFViak9U?=
 =?utf-8?B?UTkxY0VqY2V6aVNxUEJ0TGxQUmovdCtOeVVZa2YxQ0E5ZG9wclp3RnB5MEJQ?=
 =?utf-8?B?UDJIT2RqK0hPUmh3a2h4bTl6Q25zbUdpdG9LUUNkck5jM0lFUFAxdnBOZis2?=
 =?utf-8?B?MUZIN2xWNTFwTUVWcHZJYndUU0UwVzRWei9PcUg1UVljNTkyUHl4aDBHZWl2?=
 =?utf-8?B?VS9HMEtUQkFvSFJ2cFJobVJYWW1PbzBXYndXZzVxTjI0c2JmdVJCTWJYNEg0?=
 =?utf-8?B?TUZzL2YzSlRMOWNFZGpqd1lsQTN3WFZoN2R2TEttZmt4OFpuUXR0UllLamFp?=
 =?utf-8?Q?58BhJ611JYsFONseiMxv2U8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be4e721-f3ab-4ace-24e4-08d9d671f5be
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 08:51:59.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6Oo27JWjcrk2A6j14rPRuz/bgBQ+hfgLdJZMC0Tb0MQVOb9y940VhPFafyDHbPV8rB2Xwq9IiBwluA11X68dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5382
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130051
X-Proofpoint-GUID: aU1j_JSWnUayYZUk1XcSeRanGqi0dqRJ
X-Proofpoint-ORIG-GUID: aU1j_JSWnUayYZUk1XcSeRanGqi0dqRJ
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/12/22 11:40 AM, J. Bruce Fields wrote:
> On Mon, Jan 10, 2022 at 10:50:53AM -0800, Dai Ngo wrote:
>>   static time64_t
>>   nfs4_laundromat(struct nfsd_net *nn)
>>   {
>> @@ -5587,7 +5834,9 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	};
>>   	struct nfs4_cpntf_state *cps;
>>   	copy_stateid_t *cps_t;
>> +	struct nfs4_stid *stid;
>>   	int i;
>> +	int id;
>>   
>>   	if (clients_still_reclaiming(nn)) {
>>   		lt.new_timeo = 0;
>> @@ -5608,8 +5857,41 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	spin_lock(&nn->client_lock);
>>   	list_for_each_safe(pos, next, &nn->client_lru) {
>>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
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
> I'm not following that comment or that logic.

When unmounting an export v4.0 client closes all its state. These state
are kept around on nn->close_lru to handle CLOSE replay. They remain on
the queue even after the client state (clp->cl_time) expired and became
courtesy client.

Eventually these state are freed by the laundromat when the state expire.
This is why we check v4.0 courtesy client again and if there is no state
associated with it then we expire the client.

>> +		}
>> +		if (!state_expired(&lt, clp->cl_time)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>>   			break;
>> +		}
>> +		id = 0;
>> +		spin_lock(&clp->cl_lock);
>> +		stid = idr_get_next(&clp->cl_stateids, &id);
>> +		if (stid && !nfs4_anylock_conflict(clp)) {
>> +			/* client still has states */
> I'm a little confused by that comment.  I think what you just checked is
> that the client has some state, *and* nobody is waiting for one of its
> locks.  For me, that comment just conufses things.

will remove.

>
>> +			spin_unlock(&clp->cl_lock);
> Is nn->client_lock enough to guarantee that the condition you just
> checked still holds?  (Honest question, I'm not sure.)

nfs4_anylock_conflict_locked scans cl_ownerstr_hashtbl which is protected
by the cl_lock.

>
>> +			clp->courtesy_client_expiry =
>> +				ktime_get_boottime_seconds() + courtesy_client_expiry;
>> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_lock);
>> +exp_client:
>> +		spin_unlock(&clp->cl_cs_lock);
>>   		if (mark_client_expired_locked(clp))
>>   			continue;
>>   		list_add(&clp->cl_lru, &reaplist);
> In general this loop is more complicated than the rest of the logic in
> nfs4_laundromat(). I'd be looking for ways to simplify it and/or move some
> of it into a helper function.

I will move it to a function.

-Dai

