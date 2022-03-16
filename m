Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187934DAAB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 07:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353877AbiCPGaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 02:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353874AbiCPGat (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:30:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F1960D89;
        Tue, 15 Mar 2022 23:29:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G2tdF1018408;
        Wed, 16 Mar 2022 06:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ILNaqIZGPrHfjKmoyZgfRw+62bJYF1PIxwwJFLLu780=;
 b=F/H8bHc5vO7Fo8AtsplO7ePythO/MrsnmaMOftDvDEdQUICm7ZG1ps7j4EgIjNfqQ1GH
 YP1WaA6JJJ6UqoWFjchYeBYFbjWKIn9LpsMMles+7heip5FmVyxpOFt+mccrUT9TgBpM
 hXMeRhivnRUMRA0yQQnSRTapEjIFdubM60DJ0SPW4Xd5wXftp3RqGNNj1OsGQOmOKb+7
 84zCV1ySclFKrs/8JJdXGqRLEC+lX5vCa2yEJYNs/6GwBqxjOxCemtaU/QL/lwGRavpK
 DTworEGGSE3/r6Ym34TvHGUcvUh9koU2eaxx381AT6zKZecCdhnF+aAuoP8h39F/DfVP 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwn0gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 06:29:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22G6I58T032864;
        Wed, 16 Mar 2022 06:29:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3020.oracle.com with ESMTP id 3et658eqq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 06:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUD+gKKPZwGfAqMRJHOlH61dKdOUB+cx6BMVWgpUxIfZ+lS2c8T9UUZDZk8f36TGU50WGmPICAfgev1EubrTQNj52J8pMGKavMAhFniqzJ+d/vyU5SbWUBtbht3YmvnzNBuidjn8IBqt6Tw8g2/taXJVl68LYYPRMjsV30zeHk475D8B402ACtqFzcn8kKnj+wLga54h3bbFrxhypkdmqFqYAW1ZLK+/lMq7FVuwwLPWlfkctz9fMXeEr9nXiZFZ8RmDWh9+SIhE/DmTjj6MURljTi6QGYgXtCOoMwz/sLpUGFG2cZxnUZkBaAgovxRFL2x5yZyRrPei02MZ0e+ZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILNaqIZGPrHfjKmoyZgfRw+62bJYF1PIxwwJFLLu780=;
 b=Ur6Drqrx8CCoY1RrkWuHT8vGNWiYGsFWkCoDNrEqT/YxLzKedEMmoup+1MqHZEhdOtauf3oRczRStWBJVK1UAJtbedldL3hcw+KC7ToKG6w1oKaPmc3MIAqdKcEJljhOwftNhxraIOcTXqNCKwAxyUPslY2i31KbQvZGju2g47ncdz7gIF/haTJn40ciccsgbKCI5bmpWDXOJYpMKV/OXJMwJN7+TZR+Qjcz0hRHKIJ5m5KCUcaEZQXn5Y32WG3O9pTDzyUN6irLIuEnnOZhk/TDFP3zXXsM0vW0+VPVVmzEVk9lYvfw13YpeFSw+qI6f7HdrQ5JUXrKVLtF3Hzpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILNaqIZGPrHfjKmoyZgfRw+62bJYF1PIxwwJFLLu780=;
 b=ctyMuGPKOYf+ZX6pUnV/ImdJ1rXbjFNyYiljHPWin6X5ecw4k6CNVc7Vzj2RtUi9Y2G8eWz262TuPU8TlypFYEjEXyW3ugYQWRIKfKSzIcZp7JcWDdJeGS/cOMd5WkkqZa8MPaSIomL32AhDgNoJaB5vSc83T1xeTOcTadqanaQ=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB4048.namprd10.prod.outlook.com (2603:10b6:208:181::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 06:29:27 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 06:29:27 +0000
Message-ID: <5a42bf04-3f79-b0e2-7ee3-9a5bfad72990@oracle.com>
Date:   Tue, 15 Mar 2022 23:29:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v16 05/11] NFSD: Update nfs4_get_vfs_file() to handle
 courtesy clients
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-6-git-send-email-dai.ngo@oracle.com>
 <20220315153928.GC19168@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220315153928.GC19168@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:806:28::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff3ad171-e71f-4d97-f3ae-08da071651c5
X-MS-TrafficTypeDiagnostic: MN2PR10MB4048:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB40482829FDA3C68FDE2FB74487119@MN2PR10MB4048.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BlmxAST352/VazQrqlNPKvl5E2gG4YZ0MW/y2hOoYIytz2rWOOmrluHYT4FT/iGwAF0qEGkNZ75ACiwndl6HP1ZMJIp70hOKLHjGLme0zOBIeyAofzdB50rDmvmx7M6RwHaMCB+cBEYQcDpG4ZjgrlWkfRmou1C3qCqcViLyKFA7blhDhheuF8qQuw295xjQklyMm4cpS31ZD0DvjYd7LPkFKJKqIVGu/ZamRO8IGcJPesZffG5exq3DbvP6LXiV5x2/DBjrf5DvjKYwVp3Dxynn2af+2yMm7uWIaD0MAPtzGdQ52ot9PffrxvFo99MyCuL1D1ymeFV/Q8coVfJ455fzk9YsE8YBH15bvGLrve+KELukp2VSqQkJ8n3AboSnabmGXbx3wxjcDoyBw2b9UFGDcGvgVu1/DE+K9a+V5r8t2Z8SpaMxr4gHHwFUJy40SHwyPsuvIjtxMROxYFZxx4RNE1JMYoaVUwhi8WjCW8hehzJuDzqeT4sLh0B1d9VirejnAf+l3pm35hFyOgCA7RoyXu2/+GGSDfWwcpGOvOIHn72sFctibH/Rsj0l8xO/2QrTG+DIecpKcDJCrgNJXrLYn9T/UMUwyvc4MZprUtX7OiD2I9pCgzWZrMtqLJQOnDPOqb82OqodJ/TviKtQplGgz9H9OHr77QPSXz+/Pcn+m3htxoZ67rgAeao/oULXuilMRr4lJ0pyJpjiNI0Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(26005)(86362001)(66476007)(4326008)(8676002)(66556008)(31696002)(83380400001)(38100700002)(6486002)(508600001)(8936002)(15650500001)(31686004)(6916009)(316002)(6666004)(6512007)(6506007)(53546011)(9686003)(2906002)(66946007)(36756003)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3dXcXdtSjRNOTEvdGNzbzAvbW56QkJvUjNOL1pJM2lTcFM1ZkhOU1haYUFx?=
 =?utf-8?B?VVA1aVlJTHdoYzNSUTUzNjNvK01jenN2c3ladUJXOW9ubW1JQkdHNVJ5VW9V?=
 =?utf-8?B?RHZBdUJTVkFEQVBCY3VPZUZwM251eElJbzJ6TVhZUWJEdFk4blphaWM3OHdJ?=
 =?utf-8?B?U2V4Yi9QcjcrS3hTbGU3aEwxWkduQWxNYWo5emFsMlpCL3RjY0lSZ1RFUEto?=
 =?utf-8?B?eEx6cFJ0VjdiTWVFdjhlcXZhUUlCMks3Z3grcklIUHdQNlU1ZjVrdXcwWHlM?=
 =?utf-8?B?NDIwY0hMYTJjWml6WUpvbHJRVk9BcjZlQkdFdGxpQnp4M1dJMnJpRHRhODZ5?=
 =?utf-8?B?alE4VGpndzNDU3FnYTVkVUZyd1AyUUwwQjdlY3BjNldTL0pMUUEvZUhXeHhJ?=
 =?utf-8?B?UnNBa1ltdTVWcDRWb2JtRWJ0MGxaNk50Q00wTnZ1VjQ0di95VDFLL0xseElP?=
 =?utf-8?B?bitQVU5iZmFXWWE4VFlBQ3drN1lubFRpWmo2N0dtSlZhQVRGRDNGeWJCNVJ0?=
 =?utf-8?B?aEp4a3RGTlo4YzZvaTZqeTVIMXVVTFNXUTBlQmlENVYwd29XUVJQSnovSzZR?=
 =?utf-8?B?WUxKQjNPQ3FCQk1WWDhtSFNmK3MzM1dRZEdZOUlHamNubUJvMFYyMHFLalM4?=
 =?utf-8?B?RStZSG4yYjdKUW5Kc1h1YXNlQVZ6TzgzZ2JIREM4akRleFB0Zm5ibFk4NC92?=
 =?utf-8?B?OFRLN1R0RDJUalZYMU1DdFNEdllaTHBCWnpZYmJrUXNTVXhpOUpHdUJBRjVZ?=
 =?utf-8?B?ZmZaakNpUDU5a2s1UHFxTHFWTktQZmZ4am84eDl4V2pNcTgxRTYvRHM3ZVRs?=
 =?utf-8?B?VXJPbFJMMDlkWmVaeHVpUHVKVldGN0puc2dSMmpOajExMEI4U05rMU1YOFIr?=
 =?utf-8?B?eUhtb1N1MmhCK0p5M0FreHZ6cnZPNklzV3Y2V1JCUGNabmpoQ2Jra3M1MzVy?=
 =?utf-8?B?N25xcmdQWDVpMEVMaGpKVTRvV3pPb1FOZURkY3M5eURHd0poN3R5ZFltNk9x?=
 =?utf-8?B?RDJnOXhZQTgvZjA2MXJBYko3eVFmSHV5ZEJNUG80R0pTM3hvcEE2M0wzdzRm?=
 =?utf-8?B?d0djbHg0Yk1YbVN6bTEvVmpSMC9pNkQwK3lYZW1CY1pzYXlJZ3VhcWVJYyt3?=
 =?utf-8?B?aWM3Nm9VOWJEU2oyUU4vWC9VV1dCTXp0cDdiTU9ZNVRpOUtJTm9rVjlQZFRz?=
 =?utf-8?B?c3hrWVU2cFIyU3NVYXgrWVUzNjNxNEs5TUhoZ2ZFV251QXlEWXkzbW96K2t2?=
 =?utf-8?B?dUFLSTNiQ2k2amw0R3J4U3ltZ0RDVnNPWElha1N4UGtpaXg0cGdUUyt6czQv?=
 =?utf-8?B?SUxTSE1rWXJvYzlYUzdWVWVjVUFKS3hxcmM4OVBIdDFCeTNIVGl0aEwyZzNq?=
 =?utf-8?B?cllGRHE1SE81ZmRxcmZhUU51TTMzYVhGeHNWWUdWVTBtMXplWmoyR1BGQjVh?=
 =?utf-8?B?TU8vSFZiQnY4SEFzUlpNWitkNXBvTGttV2J1T0VWalJJOG5ZZ2VkQzdCYWJC?=
 =?utf-8?B?V09saTJVMWVxMmlUVUc0MmV6enREVERXMkh1QlNWa2lOYytHME04QTNJWWto?=
 =?utf-8?B?eWhxNUdxTjJ6S1NuUENvQ1l5ZGhXWXZNMXJEVlJrMWU5M0FHbFdJc1IxTU4z?=
 =?utf-8?B?dVVuU1VHdmZaRlRDWVJQZ1V0M0R0cVo0bTF3YklLTnNsSWJNRzlpMW83QU5T?=
 =?utf-8?B?TnplTzZpc2lwd0ErSXVqOUIxd2JTR2ZVbkxNbGNwajkzNDZqQzZZdENpNm81?=
 =?utf-8?B?SEcyVW8vbjNIVk51bW9LR1R0bUQwVU1yL3UwRG9pUDNFTWZSZDlUaUNMeW5v?=
 =?utf-8?B?VWZUUDFlVGNNT1NXdUlrQVM2S2ZYd3dqc3hBSnpVUnZxN2h3c2pVRnBibnBu?=
 =?utf-8?B?bml4UXZVdkpNdzhmVCtFZGp2bEZvRU9La2c5K3oxMmVSdnZIdUI3SHYzMk9L?=
 =?utf-8?Q?2HYLZLfjT29bBjsWhTYsQyYjDDbTcTe0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3ad171-e71f-4d97-f3ae-08da071651c5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 06:29:27.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TU0k4fIzTl4Lfh0zC0SNh5AfYmhfb4aByyPCQubo938CGCCqNuuj4r5eWoCYZ4RhVyGsCQoPoD127IVLdIbYFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4048
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160040
X-Proofpoint-GUID: RshPTNYhGE90bMLxDhZ7FhsJv52CyA1l
X-Proofpoint-ORIG-GUID: RshPTNYhGE90bMLxDhZ7FhsJv52CyA1l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/15/22 8:39 AM, J. Bruce Fields wrote:
> On Fri, Mar 11, 2022 at 06:13:29PM -0800, Dai Ngo wrote:
>> Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
>> reservation conflict with courtesy client.
>>
>> If share/access check fails with share denied then check if the
>> the conflict was caused by courtesy clients. If that's the case
>> then set CLIENT_EXPIRED flag to expire the courtesy clients and
>> allow nfs4_get_vfs_file to continue. Client with CLIENT_EXPIRED
>> is expired by the laundromat.
> I'm not following this code.  I'll see if I can give it another shot
> tomorrow, but are you sure it can't be simplified somehow?

When we have deny/access conflict we walk the fi_stateids of the
file in question, looking for open stateid and check the deny/access
of that stateid against the one from the open request. If there is
a conflict then we check if the client that owns that stateid is
a courtesy client. If it is then we set the client state to
CLIENT_EXPIRED and allow the open request to continue. We have
to scan all the stateid's of the file since the conflict can be
caused by multiple open stateid's.

>
> Keep in mind, we really don't care about share conflicts much.  I'm not
> sure whether anyone actually uses open deny modes, so there's no need to
> optimize that case.

Yes, but we have to pass pynfs 4.0 tests.

>   I'd be totally fine with expiring things
> unnecessarily in the deny mode case, for example.

I have not been able to come up with a simpler solution.

-Dai

>
> --b.
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 91 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 2beb0972de88..b16f689f34c3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4973,9 +4973,75 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>>   	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>>   }
>>   
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
>> + * Check whether courtesy clients have conflicting access
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
>> +nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	struct nfs4_client *clp;
>> +	bool conflict = false;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		if (st->st_openstp || (st == stp && new_stp) ||
>> +			(!nfs4_check_access_deny_bmap(st,
>> +					access, share_access)))
>> +			continue;
>> +		clp = st->st_stid.sc_client;
>> +		if (nfs4_check_and_expire_courtesy_client(clp))
>> +			continue;
>> +		conflict = true;
>> +		break;
>> +	}
>> +	return conflict;
>> +}
>> +
>>   static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>>   {
>>   	struct nfsd_file *nf = NULL;
>>   	__be32 status;
>> @@ -4991,15 +5057,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>   	 */
>>   	status = nfs4_file_check_deny(fp, open->op_share_deny);
>>   	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
>> +				stp, open->op_share_deny, false)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	/* set access to the file */
>>   	status = nfs4_file_get_access(fp, open->op_share_access);
>>   	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
>> +				stp, open->op_share_access, true)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	/* Set access bits in stateid */
>> @@ -5050,7 +5130,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>>   	unsigned char old_deny_bmap = stp->st_deny_bmap;
>>   
>>   	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>   
>>   	/* test and set deny mode */
>>   	spin_lock(&fp->fi_lock);
>> @@ -5059,7 +5139,10 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>>   		set_deny(open->op_share_deny, stp);
>>   		fp->fi_share_deny |=
>>   				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
>> -	}
>> +	} else if (status == nfserr_share_denied &&
>> +		!nfs4_resolve_deny_conflicts_locked(fp, false, stp,
>> +			open->op_share_deny, false))
>> +		status = nfs_ok;
>>   	spin_unlock(&fp->fi_lock);
>>   
>>   	if (status != nfs_ok)
>> @@ -5399,7 +5482,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   			goto out;
>>   		}
>>   	} else {
>> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>>   		if (status) {
>>   			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>>   			release_open_stateid(stp);
>> -- 
>> 2.9.5
