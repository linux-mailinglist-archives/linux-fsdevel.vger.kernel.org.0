Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8981A4DB78D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 18:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352705AbiCPRrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 13:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiCPRru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:47:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFDB6C1D8;
        Wed, 16 Mar 2022 10:46:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GHCAN3009585;
        Wed, 16 Mar 2022 17:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jsNz/1Re4Pka+cfai79WaRk/zYg+BbB4nAJpCLndTrc=;
 b=L+8Dr8tkLdrzP3WACDPP3ESryfSogTAR/scPdeYgNu3FCG6atoodM+8cKJKKB3xZHmX+
 vnCBLyoC+46lCranRDSUfrfh4Q/swStS46TjOoE6TBxmi95npRHjVY4xOTqImmyj9Unx
 h9RH4qhzco6WSgpOx74qka99OC7qxKlb3UFz0pgOZyG4HI0XkHeLp7ArDSqvFAfD54Ex
 R1Hpg/3a9MiiYCUQWbYi+UqOIZTFkddj/9OAt2i4oHI/AMHLNo/Qdc9iRPlkzmNhB42K
 bxin6RRc063NgVoUoc+yknRsJgCNKxE6xYt3v8Bun8/JrN9RofrP8zR5ybOBWHqI1MWR +w== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rq22v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 17:46:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GHkRwQ109472;
        Wed, 16 Mar 2022 17:46:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 3et64u09ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 17:46:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3bHnncJloGKR51vjlZjLrmNGtBf8AbyI8sTOGA5POjMpd6x0Z7fWzFmogmO+ngCSUS7YKDRmGpamOZGv3hUrP+YOSMa0DTvGV7dHBF2NDmItIr928N/k8d6Nc/aa68N/QQNZCLx58q+oxLtTZyqPs4dg2VC+pdFh99qFE0dBrBXvWU4PnSvdidFuI3nu6qX4UxSbjcMRzCKupj89t8lmmB8l5d3Bfnw/hhdC8iLboVhhd/ui4lBHQL6/BdkeSLNkZuLzCgXPkgE+azR+4E4KLas/s71jgm8j8VPi6GXpnPncDezZiYySKRDVPuaD7+iUh2pX6r8TIKjuW0xM9a9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsNz/1Re4Pka+cfai79WaRk/zYg+BbB4nAJpCLndTrc=;
 b=OTUjTzpsSDy6JAK+6KVAeETK+H5XKlvte8GRjcchfQEZJg79jCbdLBFQGRUvGqSI5k2uGVOVLnuIW/qj61AIpVZDxdjS4gPsRc65qTMewVuK/dDWOR8vAJpuT0bbCVIGt3yS9REKaVTnPhMkBWo5zDk2fof0oV8kJiGl17LNs9hOlmxpHijjHpCrk31q/TT8TLbZOPPrbOantmud2J3pNo1pOIiUIS+EXjZgZ5jtiPKxhhj+//NqfMF0ti2+650smIvEVH+xNE4qzUTjXRYhpNyohBxJW/fvYpQNR2nUs7jZtGZCZAUFUABR6pQnwhtRn0DXO4J4oFN8SxJDdJmYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsNz/1Re4Pka+cfai79WaRk/zYg+BbB4nAJpCLndTrc=;
 b=T7XLi4nQ9PRcVlScZL/5oqk4q3lz6CrN4Bplh2vCj3xO7e8RGmoSWG0iOyWodklaSfkW6t1xVT22kSepPlPTtfnza2sEHFXLBLHl7hLHteli8E5ykAJPNpcZ9pVjkDFxwdOZqDeO273pFQ/3LPXPgz02xvu0oOpmAnlCa4bvdnk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM5PR1001MB2075.namprd10.prod.outlook.com (2603:10b6:4:2b::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Wed, 16 Mar
 2022 17:46:25 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 17:46:25 +0000
Message-ID: <29e96a0c-302f-5f13-0e8e-66b0a9e0cf9c@oracle.com>
Date:   Wed, 16 Mar 2022 10:46:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v16 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-2-git-send-email-dai.ngo@oracle.com>
 <31F7D9C2-7DFE-48B0-9464-7042208521D5@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <31F7D9C2-7DFE-48B0-9464-7042208521D5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f97b6eec-1c3d-4659-78c9-08da0774e424
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2075:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2075252FBDD1B3CFCC4D599B87119@DM5PR1001MB2075.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYiYdvkAUbNhmTvFvLr4hV3ClNiUlmyaC2Bz4J/pKKgZElXIBCU38QLIGpso2qCEmFXULITZp4WNuL8igvdY0Z0VnjHSDZZ27dnFuE9l/wagxfswkVufV2g24gN6bV0LLZHAK8x8ueho2TrOg2xgaZme4rBzTMnNYkrpyU4Yfpzey/gYWnirqlbNZys8TYyLRSK5zVaYG/dSSkCk3/XTJk08acCi1mGhLWWB9zRYuQAF2LGized3QystVW1KXG1TKitutw66rikOCC/39VcvLqwhZYMskCtTNbhK1EWLj6f80XnxruUD6CMYDCvARhQU7WaA1Z1rizUHkppLHOCPw8P3cdgsHJgYCRMdrsJ8vuLGziTPoKaKjdsxTNicz9xhXEYwu18UIxHXSrSKeFR0/HAVuIRGinvn4hd+uDIM9lJt3KeHcTZXG8Dfxcq6+FCtEL5OGdR8YEJgLRZLQJ9kgRfKjNVRl6QQzmMP4oAhcR+s+wkryKjPcPhJeJwnyQ053VcISL6Kj50xOg5COrcDUbHQqOyi23W6TPzUcH2IyPZCbR9sm2epPv6yB4BM3y2T4PKpEN9ocdnPRm7BFtBJGlb7AyCTekkE9z260YcGmeTZWDBsGf4U5MvVvPzxMAQVZ3VjcgQkKOQKXJZ7vUfavfYAGEQ96l1HUiZ4sjLwnmMaxfnptT3IVqbtq7oF7mkLA1oTaGIZrnAbmnXHNpUfMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(2616005)(186003)(508600001)(6486002)(53546011)(6666004)(6512007)(6506007)(9686003)(38100700002)(37006003)(36756003)(86362001)(31696002)(316002)(4326008)(6862004)(8676002)(2906002)(83380400001)(31686004)(66946007)(8936002)(66556008)(66476007)(5660300002)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N003RjhuZE53M2pnVk9sa3lmb2dDTmFueGRrbkg4MDRZcXl5RW9yQmJ6U3NX?=
 =?utf-8?B?WXpxK3VicHlYUzY1eElZaUVHS0x3SVJsVDN1TmppQmRIcGlUMTlkSHFVZGVH?=
 =?utf-8?B?MnNxM3lVazhpbXU5QXlhOWR6eDZpaFhSWDNkYW5yQ1I3NW5QV2FUVGlPVW1B?=
 =?utf-8?B?UE1vLzlwZHZ6S0EvcnFlbnR6bExzc0l1eDhMSFVTQVJHSFdhOGt5S1Z6Ully?=
 =?utf-8?B?cmZSb08zTXRJcFhuaEt6ZUkrTnhhSlowNCtWNHYyNFZFT0YxT0NYQlQwY1Jh?=
 =?utf-8?B?eHpiMTQrOGZMN2ljY1FmcW5VcUtLNWdUSXFyOWh3L044TVl6ZHAwUm91TDc3?=
 =?utf-8?B?VFluWU93TkMzZ0oxcWpkWVpIOXZycjNldEhRWFB5V0pMTVZaTGZXN0ZhNmY0?=
 =?utf-8?B?VEhMeWJXaW1GY3dHcGVWVEZZTmZlTkRRTVpwVHVPemxaeDJoSG1XbXZXeitJ?=
 =?utf-8?B?NXo4UmdlQ1lVZDJjNlNhaEdlZU45L1hBYW1sRDVrMzZlMlR4cGppOGdlTy93?=
 =?utf-8?B?RFF2RjBHY3FsMWp2T0ZHWXgyQXA1WGFMQkxSRDE5VENQK0hyQ29PUFlFTlNk?=
 =?utf-8?B?SmpFWEIrT0RoWnhlV2lYMUpjZjMvcnFvNWQ1eTVPaWZSRWVySmR3UFlYNld2?=
 =?utf-8?B?UmVMV2ROTFB3OWJBS2hEU2wzVUFRbUE4d0ZBMnA1dG5uemFiVWlTSlZXT21C?=
 =?utf-8?B?QWk2YzhaTFI2c2ZsZ3QzVUI5akgzVWZ1L01MRGNjRThjYXNSRU93T2tnVTRq?=
 =?utf-8?B?R1IvRWg5OEtIdGU5Q3kyZ3J1NUNoSWV5Sm9ZU2RXMnpTVVJHblZ5UXJWUmpL?=
 =?utf-8?B?MEpYbHJlRHRxL1BlTUgrWkJkOWRZNENmMnlXaVVhNURLMTNoYTJLeGx2NlpS?=
 =?utf-8?B?STM4TVIwaENJdmhtMnVpb2xadGR5MG9SR3A0SHBBaXVIMEhtRWFyYVZQVSt4?=
 =?utf-8?B?bTQ2KzVrWVhjZ1NTYmpiOGE3R0RTL1hvdUJXdDNhM2svZXVJRkdJdlJEZjFa?=
 =?utf-8?B?aGhjRTVYSUFGczhmTkl6dEo2OTAwSVZGKzAzRmdKQi96MFdaMlAwN1dNTzU5?=
 =?utf-8?B?NVcrZ2lVOWJlelhvUHpKbDU2OE1PN0htWno3WWphei9OZHZOcmQxWkZVdjI1?=
 =?utf-8?B?TU1xVnZRYWNjcDR1WWM1UHlqN0tna3ZBdTl3YjhHSE5vdWZvNVAxV2NHWXpS?=
 =?utf-8?B?S1RVbDBwTkVZdzk1N1dURzlxeG1meDNaUjZXdy9ER2xrT1ZCcWQ5R2JqOGNH?=
 =?utf-8?B?ZTNEV1ZOR0xMRU1TdCtOUGFKc2ZGTDRWdFQ0QWFybHdqd0VaRVh1bWhUbGpH?=
 =?utf-8?B?eEl2UkxvME04RjhobkJTbkxHdjhJQ3FGV0ZGWDJQUWtHU0ZJYWdiSjJhR0ww?=
 =?utf-8?B?KzQ5a0pXbGJyUlA3aTc3cm42Q1ljRHhDczFhbFhiWEZ6QzBQZy9NR3I3YUR5?=
 =?utf-8?B?SUhnSkxhTmVnRW1NL1NFMWtxVUhqS2FFcTJ0TXdRYStJOXJvSjM2R2hNejJv?=
 =?utf-8?B?emlZRHVZS2FXVkF0Y1hyMlNxckRscU95MjBjNktZZDhhUTloQWt3bFJKVEtE?=
 =?utf-8?B?NXIraHJKQWhXMzhFeU9QRkRpcEdMSzdqVWhWRFlLakhPNnZFeVA5VmJzZlQx?=
 =?utf-8?B?QmpqTElaak8yQ2VLTm5meE0yQlhrajN3QUpJVDZqMzc5dVNUU0ZsTlhEdGYw?=
 =?utf-8?B?b3BadnVDWTFqT3RPOXNzRWFwVkZqbHJpOWR3Ly8yTys2TG1WRVhwZGdtdTJK?=
 =?utf-8?B?WXRKU0hqZUNtWVBvY1dHOUZwck52MkNscVlLTlBhNm1hUVJGL2x2WUhhcE1l?=
 =?utf-8?B?M1crS1p2OEI2c3JkNk1XMjlxTktXSGRyQkRsNWxPc3lGR2FTNmJPQUFFS1ds?=
 =?utf-8?B?b3ZjWHFOOFBxeU12djBKUkt2ZTZrZ3dvYktrZkhVR1MyMXJMWDBCYXZSd2Ew?=
 =?utf-8?Q?aaao3T9iA34k1xXlq4sKpVNxeetSH8xy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97b6eec-1c3d-4659-78c9-08da0774e424
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 17:46:25.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56sFKM97PnGHVihC2cX9qFP0HEWMzzfd2ixKrH4YInm2rK+tsQkZYgb8JKVJ3qVumTCyKcvMIAejxTDdS0JB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2075
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203160105
X-Proofpoint-ORIG-GUID: Cur6PMXa75Vi-Dj6quJ6j8CbNURpgYCV
X-Proofpoint-GUID: Cur6PMXa75Vi-Dj6quJ6j8CbNURpgYCV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chuck,

On 3/16/22 7:27 AM, Chuck Lever III wrote:
>
>> On Mar 11, 2022, at 9:13 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Add helper locks_owner_has_blockers to check if there is any blockers
>> for a given lockowner.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/locks.c         | 28 ++++++++++++++++++++++++++++
>> include/linux/fs.h |  7 +++++++
>> 2 files changed, 35 insertions(+)
>>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 050acf8b5110..53864eb99dc5 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -300,6 +300,34 @@ void locks_release_private(struct file_lock *fl)
>> }
>> EXPORT_SYMBOL_GPL(locks_release_private);
>>
>> +/**
>> + * locks_owner_has_blockers - Check for blocking lock requests
>> + * @flctx: file lock context
>> + * @owner: lock owner
>> + *
>> + * Return values:
>> + *   %true: @owner has at least one blocker
>> + *   %false: @owner has no blockers
>> + */
>> +bool locks_owner_has_blockers(struct file_lock_context *flctx,
>> +		fl_owner_t owner)
>> +{
>> +	struct file_lock *fl;
>> +
>> +	spin_lock(&flctx->flc_lock);
>> +	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
>> +		if (fl->fl_owner != owner)
>> +			continue;
>> +		if (!list_empty(&fl->fl_blocked_requests)) {
>> +			spin_unlock(&flctx->flc_lock);
>> +			return true;
>> +		}
>> +	}
>> +	spin_unlock(&flctx->flc_lock);
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(locks_owner_has_blockers);
>> +
>> /* Free a lock which is not in use. */
>> void locks_free_lock(struct file_lock *fl)
>> {
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 831b20430d6e..da8ae38f471c 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1200,6 +1200,8 @@ extern void lease_unregister_notifier(struct notifier_block *);
>> struct files_struct;
>> extern void show_fd_locks(struct seq_file *f,
>> 			 struct file *filp, struct files_struct *files);
>> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
>> +			fl_owner_t owner);
>> #else /* !CONFIG_FILE_LOCKING */
>> static inline int fcntl_getlk(struct file *file, unsigned int cmd,
>> 			      struct flock __user *user)
>> @@ -1335,6 +1337,11 @@ static inline int lease_modify(struct file_lock *fl, int arg,
>> struct files_struct;
>> static inline void show_fd_locks(struct seq_file *f,
>> 			struct file *filp, struct files_struct *files) {}
>> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
>> +			fl_owner_t owner)
> Here's the problem, Dai.
>
> This empty function needs to be declared "static inline" not "extern".

Yes, I also found it last night with the 2nd notice from
kernel test robot. Fix in v17.

-Dai

>
>
>> +{
>> +	return false;
>> +}
>> #endif /* !CONFIG_FILE_LOCKING */
>>
>> static inline struct inode *file_inode(const struct file *f)
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
