Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0824DA133
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 18:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350607AbiCORcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350601AbiCORcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:32:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B464758820;
        Tue, 15 Mar 2022 10:30:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFXkER023075;
        Tue, 15 Mar 2022 17:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=L28tF8JAd7TNyWFa0k5Ef7+azgk9RN5g2FzZVN2Db3M=;
 b=pTJjOV5vySktNEr9ku/VwouboJMC+0I4eeN3Y0y6vcwMvxTfDQ7W0GSCKPj86edLphc0
 db8+W/GSZCyDf+NiCAgiiF6M18oYAPyyDp4iw9nPezOG5QZum7KrpllJpUCcx0lDgNcD
 /KEXxZaeAzsVCgLSXXudCL8hiOsPz8AWxcje8WqnkJUqw0ZKr/sIcdsSigoqxPlyyuCM
 ixRRelWwnKlLL4YEEZNa29so80RSSYNB+kosf5T5oB9j3iB+Ir5FIrpzerMlyVTgLiMN
 llOgMzlvVUK3KzmcFhWNFZ2QDJJS0QCE55Xrbk482gtx8L+D0d1Dlclnudo+wkDX8BuA Fg== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rbsj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:30:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FHA9Hq024337;
        Tue, 15 Mar 2022 17:30:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 3et64tqc8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4EK1HBEsqdSwbfoRwfDm/AMa0Pwp9PIhK5r+kHEJXcDxlrCuGNxPwBcpgRWdJ39BywRcbA2hu/WoeDz8Z8Uzm3bCohimMnR5JBQWJKBdeLJgb6Msu21mLNVpVOwy7lu4n04yZ171Zg1E22KrbPyIOtE9G6Kmy/xT+XtzAhnFazBgnNOrmJa8zPn6wdP2xVRqOgp5++24ow9WkJZYU4KwXbd0fDVtF9RPLABdaSKq6f1dMLGvyOO6GLFeDDzbyimwisYdyJp4S1T9Ye3S34olA+SWAF/R0AzicIjAs6KTixjdN3qBr+Jh8M3Z1xhR1jLeohSm2NRwDnfkKHCjkhs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L28tF8JAd7TNyWFa0k5Ef7+azgk9RN5g2FzZVN2Db3M=;
 b=IJ8W/QnRfOmXdfXWyaUc1Jo1sWms7ddRcAfxhXhfh/klsaSYJCD8t5B7srbDVE4287qCMnIsUhcSgkd2AFVQemxG5GCIIR1oY75c8isVSpke9Q0Kihy0n1rGDpUKRQ5U9pZh7phO4YYvjHrSKRd6S2aBMJNiEYQKKh7iJhF4Cd3215NMljMeHlOdq8c/KElEgYm6zhlrmXAw2yGPNATgqMTF5sjjYfBJ0mfBKq1719tJ8r16xMVPfOMIxGgqTqTZ5pXG/o/6FoE/wgKwPr5wE+0g7A/oh0WYnebnKZ4/rdi+deQXxQtsmvyJvCG569bHXrO9W0zwmYQotqVbaZnWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L28tF8JAd7TNyWFa0k5Ef7+azgk9RN5g2FzZVN2Db3M=;
 b=XW4hWrjzvB1/stvYloZYFGel18KiNDBOqj31OZQCRpssy87qavRuJyF0pfT+u4vVMCmDEOOEnygHZiycnER8SkY+UZiLv7nrl/YPMG53PQpmPBOu2nqYUe8Lp7ay9SrcY/0k8W4rCpcA9rLkaHEHf9XSUmfbykdFATfjqpw+KMk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB5020.namprd10.prod.outlook.com (2603:10b6:610:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 17:30:49 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 17:30:49 +0000
Message-ID: <274a8141-a62a-a522-7ef6-46c4022634d8@oracle.com>
Date:   Tue, 15 Mar 2022 10:30:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v16 03/11] NFSD: Add lm_lock_expired call out
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-4-git-send-email-dai.ngo@oracle.com>
 <20220315150245.GA19168@fieldses.org>
 <1e1ff6a1-86cf-99d4-13ad-45352e58fe73@oracle.com>
 <20220315172051.GD19168@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220315172051.GD19168@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 042797c4-3da9-4eb6-72d1-08da06a98bd4
X-MS-TrafficTypeDiagnostic: CH0PR10MB5020:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5020C5936CF3A1F116D6241287109@CH0PR10MB5020.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYtzFidR/hHjzig6Z0dIqIB6f74ChmpRRSlsOU0iUN7lD2aH1gs01vb8vFuoIs5yyiMoNOOKIuH4+W3+I9wvGRN9FtHL1ENAeeEjihscjwS3ISp1BRGaUlEHsNFNM6+TlYWnpjkYS6dIiFQNuhDC7hdcbBqm82vGrFj/blapTbvKwNKR7Hssl3z5K/fhkanb1fFGxtwEFYSGhUIx3MG8WgBlZ/o9lYQfXOw/dKvilgVPG8CZ3EbQ91DLsEMDCq+19T6KcMgUxkAS7m7ggR9DdPglZzDmR8R2sIfkBISeqzUx7v5/VokJDrzg9i84buzCQ4E5ctgHYJgTsSPYlxj/mNpvgYdhkT1BgErAJw0b2v4irjbPMk7HdOayFxE8ZzBpjuQarIukFl0VTjDy+M/U/PIYt5bKGfUHECoVjj6PaX4tdKONWAoHDD1rBCWQhOSHrbZIUCIHdcjsueg1ldfpZow7ruEuhqRLm4uCt2RaOElpV3aF+8CuwqlqoK4jylOlbDWE95clhiv1mqiZvcZ67nNIAQctbNVAAJizeMvbKsBhGpaGdnDliws4WSYvpIxgiqnGEV/PZFv9uT9X/5fkwBUI+Yg003FtmhvKLmhQj6mZSQ3EyvN9C3SSmLgeeCyQXG3DtTqM6CNM9apET9SJ3jASFInplaHsBF1IIl6w/mdycHMW5nCfV97yzggHoPwthPmcdsF7nDofQen3c0UxwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(86362001)(38100700002)(66556008)(66946007)(31696002)(66476007)(316002)(6916009)(8676002)(186003)(26005)(4326008)(6512007)(9686003)(2616005)(6506007)(83380400001)(2906002)(31686004)(36756003)(8936002)(5660300002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVBiZFQ4dHF4Qm41c0g5cGVTRWV4ZCtXNU9nbkl6UkdDTWIvMzVtVFhLZS81?=
 =?utf-8?B?TkdNdzlLWTRFS3hjVGlaM0xOQkxiK3lWTDNJZDd0a2tMUUtpaE9qNU8yL2hG?=
 =?utf-8?B?Vmt0MCtQTUh3U0FVYk02MnpERFI3QS82ZGd4NUhzdHNHcUlsTGFNWmlNSko3?=
 =?utf-8?B?YUFoN2Z2em92TVlyQVRudlhsUjVHR1YxVlhrRy9MSTNBU0k3NUpYcmJIcUxC?=
 =?utf-8?B?TlVYRW55aW1RRmFTZDU1Nmp5czhqOUlOWUxiNjhLWVpXb1FJSnpsYlNlMnQ2?=
 =?utf-8?B?WjlnR2hwSUZ1MUlUbkMyeitGa1lEOVp2TVI5UDd6ak5JYWIwZVZFNUxhbUZ4?=
 =?utf-8?B?KytDeDRQRTlPM2F1WXVHaTFmbTR0enNtVmI5OUFpWXBVaHg4NDRIVGlIMlIw?=
 =?utf-8?B?bDJ3cDZpaWJjbGVCRWR1NjdxQk9ScW1DRktSUzhUbkZ2dG0vSkYxL0RZMUtt?=
 =?utf-8?B?VWwwNzc0TzM1b1ZCcElCUURCeHN5a2V1a3IvUmp6R2w1Mzd4d0pScWlaR2Nr?=
 =?utf-8?B?aTl6cTVRWTRUeXIrUEhtblZ0N3djdUh3Y1JlU3A3S1FKV1lKODZOVldkNTkz?=
 =?utf-8?B?bFowTjhYMytjVWJ1RGw0TFY4N2JuS1FUamtqL3NhRDRqTjZXMGpEM1M1ak9q?=
 =?utf-8?B?d1hSWVh2K0JkdGJjNWtyalJOS1dtQmtVUFRMUEFFVmt2dVJLaXNaRGlKTGRl?=
 =?utf-8?B?eE5jQjFXU0JDVjhvRUY4b0tXR0oxcHV6TFZpZmM2OHBZN3dpWUQvckN5Vlh3?=
 =?utf-8?B?NkpJNXIyVkNKNTJ4RlRxd3FjdXhtR1FlQml0czRNRlJOd0hsUHYvb3J6aG92?=
 =?utf-8?B?MEJKN1QwVmVXMlV5bmtEdGZlelRKTHF5L1BhSzJRWnFETDl4eW1GTHJqajUx?=
 =?utf-8?B?R1NSV3FzQTI1bkxkVWQ5RlNkcTdhMW1EckI4Ykpramxod24zUnRwdHJuSUlj?=
 =?utf-8?B?S2FKWWs2Y2UyeTJ1OHpMVXNzVml4Z0cvTVNZUDRLcFBmcFM2WThoL0NTay9p?=
 =?utf-8?B?cTJ6dVc2aW9uSWxUOUMzWXRwRTlOSjhXWENpYy9KZllGSGt1aTQ2NENRTDJC?=
 =?utf-8?B?T0tVZ3pieXJDV0FsYTI4bkNTK3VvQ1VwNjBFdnhFaG5Ub3FVTXo2MlQ3U3Vy?=
 =?utf-8?B?SkdMZkxJcjF5aCtCb3ZDV3J3QkMvSFdlSFVpTGVQNXJmMkU2OWRZaTFEd0RR?=
 =?utf-8?B?L21SWG5rWVVXWjBJbGdBRTdQZGVOMm5xWjVQT3pCdGcwa25oMTluVFB4RWVh?=
 =?utf-8?B?Rmk2azdSbzlXN2ZFaVYyS2wrODBVcURoMGVVR2dBb24zaFRKckRMOER4bWY0?=
 =?utf-8?B?UU9oaTJVczhFVlZSREhUN1oxS0JzdVliK1Q0bWFjMzFwUHRMK3dHSXdlQ2hW?=
 =?utf-8?B?UU52M0Y0alVHR2pnM3NjZHlManlNb0dwUHV0T0ptWEpPTTZnWXlVVndEbzBh?=
 =?utf-8?B?RXZmcVpTM1Rxb0hlcjN1cXd5am05WGFEblBEb3JWcEdjMkszeVpoZ09ONlY1?=
 =?utf-8?B?aTU1c3VBdGJ1RU85UEVHdUx1WXg0UUZ1ZmliRkVPWHhaMWVKMytPQ0x2bTQ2?=
 =?utf-8?B?MjNmOGg2RjdmMDRPS1Z3MVZhNnVULzVhMXpUbGFUNThyWVQvVURQeUNDZm4y?=
 =?utf-8?B?U0YrWEozWEc4NTJtVisrWHRjZHJscFlxZWJnbWY3MmNvMG5nbmVBMjRlL0Fo?=
 =?utf-8?B?YlpTdWxjNjJsUGlyaGl5NlBFNnFwNDhKbHpDb29GYzJIYU5qbURnTFh4UnRs?=
 =?utf-8?B?UGx2WFBMZWdQeFNvNFNQSUN3YUY1VHdKdzIxVmxlWGZEd1BFZjZZVndVRTdQ?=
 =?utf-8?B?RDFvTk9zL0NYcThNV1BUS0doY0Q0ZHgwTjdrZGpUbjl6VjZJUWtBbHFWY3NQ?=
 =?utf-8?B?OGRXWm45SFVEU2Z0ZGUyTlQ0ekErU0RWUktsYXg4VWs2aXZqcEJZTHZSdis5?=
 =?utf-8?Q?tTf/k4eFnnwI02gTOdIRjMCZjOs8GcaG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042797c4-3da9-4eb6-72d1-08da06a98bd4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 17:30:49.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iY+kj/Om7Fy1s8FXVLXp6Uz7oftGhr2RbgiCiZ3efNWmkRszrZvpnJcFpiKVhzG3mE7x8FrOs7wcKlkPkGGa1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5020
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150105
X-Proofpoint-GUID: z4MYj03Wh-fRIGapzoU6w4mI4FCfbYlD
X-Proofpoint-ORIG-GUID: z4MYj03Wh-fRIGapzoU6w4mI4FCfbYlD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/15/22 10:20 AM, J. Bruce Fields wrote:
> On Tue, Mar 15, 2022 at 09:26:46AM -0700, dai.ngo@oracle.com wrote:
>> On 3/15/22 8:02 AM, J. Bruce Fields wrote:
>>> On Fri, Mar 11, 2022 at 06:13:27PM -0800, Dai Ngo wrote:
>>>> Add callout function nfsd4_lm_lock_expired for lm_lock_expired.
>>>> If lock request has conflict with courtesy client then expire the
>>>> courtesy client and return no conflict to caller.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index a65d59510681..583ac807e98d 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -6578,10 +6578,47 @@ nfsd4_lm_notify(struct file_lock *fl)
>>>>   	}
>>>>   }
>>>> +/**
>>>> + * nfsd4_lm_lock_expired - check if lock conflict can be resolved.
>>>> + *
>>>> + * @fl: pointer to file_lock with a potential conflict
>>>> + * Return values:
>>>> + *   %false: real conflict, lock conflict can not be resolved.
>>>> + *   %true: no conflict, lock conflict was resolved.
>>>> + *
>>>> + * Note that this function is called while the flc_lock is held.
>>>> + */
>>>> +static bool
>>>> +nfsd4_lm_lock_expired(struct file_lock *fl)
>>>> +{
>>>> +	struct nfs4_lockowner *lo;
>>>> +	struct nfs4_client *clp;
>>>> +	bool rc = false;
>>>> +
>>>> +	if (!fl)
>>>> +		return false;
>>>> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
>>>> +	clp = lo->lo_owner.so_client;
>>>> +
>>>> +	/* need to sync with courtesy client trying to reconnect */
>>>> +	spin_lock(&clp->cl_cs_lock);
>>>> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
>>>> +		rc = true;
>>>> +	else {
>>>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>>>> +			set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>>>> +			rc =  true;
>>>> +		}
>>>> +	}
>>> I'd prefer:
>>>
>>> 	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
>>> 		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>> we also need to set rc to true here.
> No, the next line does it because we set the EXPIRED bit.

ok, as mentioned below this code will be changed to use an u8
for the courtesy client state and only either CLIENT_EXPIRED or
CLIENT_COURTESY is set but not both so it might be slightly
different in v17.

-Dai

>
> --b.
>
>>> 	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
>>> 		rc = true;
>> With v16 we need to check for NFSD4_CLIENT_EXPIRED first then
>> NFSD4_CLIENT_COURTESY because both flags can be set. In the
>> next patch version, we will clear NFSD4_CLIENT_COURTESY when
>> setting NFSD4_CLIENT_EXPIRED so the order of check does not
>> matter.
>>
>>> Same result, but more compact and straightforward, I think.
>> Chuck wants to replace the bits used for courtesy client in
>> cl_flags with a  separate u8 field so it does not have to use
>> bit operation to set/test.
>>
>> -Dai
>>
>>> --b.
>>>
>>>> +	spin_unlock(&clp->cl_cs_lock);
>>>> +	return rc;
>>>> +}
>>>> +
>>>>   static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>>>>   	.lm_notify = nfsd4_lm_notify,
>>>>   	.lm_get_owner = nfsd4_lm_get_owner,
>>>>   	.lm_put_owner = nfsd4_lm_put_owner,
>>>> +	.lm_lock_expired = nfsd4_lm_lock_expired,
>>>>   };
>>>>   static inline void
>>>> -- 
>>>> 2.9.5
