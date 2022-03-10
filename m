Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504C34D3F88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 04:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiCJDK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 22:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiCJDK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:10:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029997C152;
        Wed,  9 Mar 2022 19:09:55 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A13xo3009103;
        Thu, 10 Mar 2022 03:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5I1ohhGnVK7bBCabH3u1jwoskNOKuqSMePERr4+IONQ=;
 b=R/FlarBxg8BXla/KfRzN/kp50MEJKzaAJ8CM1cWVv+l9TkgRGi/qVNbwXlaAh0GYu2zW
 fuyimhCqmcff922tWD9Z7Cauma6cluP71sn4h7Y7tqRfC1fxE7kI14Y1aS3u+PwpVn/1
 sF+I8+LpTIIYeDdt477TtibOVkc5W0eYuabQH3zzyCY8UAM3HH5sGw5eSB+v91kG+dKK
 s3D/PoX7bc+2Bq+vKSaDR44AaGYYUtnqvQhpJ8P96NISaAEhRrY1sh+SuBaFKuFe+DS8
 +7Broo9dJ0ELUqXfcDS9GYks+7jKbdiqSz3gYhQVJtyNLLEhgfU6hr860gLVmN/4ojVi MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2m38k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:09:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A30QYc125397;
        Thu, 10 Mar 2022 03:09:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3030.oracle.com with ESMTP id 3ekvywbt32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHkuCJ0kqdykSeBnv5cwpSPor61XqD6kgI/vYV3eq6asDNDi/7jBlWeh3ah4b9kkoXptoamOvweR40cpMVBrKo02I4lSViSbaOMdyvDL0sFSIoprSG4CmLjySv0hrFbqktFmtuhU9EAv3x+7RKtiwj0PkJq9qBoZQcPkKOvBMgsWxvRwLNUEsYqzOn6zKrEU40cBiWLbBL8DorvxN06pP1Zq5PjTXyp+3Kfn9C5nl+X3YGbtYWxfNS3pmyl839fOmGNpIvab5oHUJkfgVy5Zaq+JQq3pgf8+ss0CNl0jgPgPLdsupddHveDIcM/GhiFg+LKhcl9uWXvIdVygUxSiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5I1ohhGnVK7bBCabH3u1jwoskNOKuqSMePERr4+IONQ=;
 b=NSPi1yQxYSE3oKWw0om9MZqJozlZovCruIzUZXdaVPT00jItd/8DNNuSqWsdK5T96nP+saPWkNjQbOYjwJP/c6+mb38huL5QD33Hkw6MWf/xakN54lRtkVAYiiFarr3epNXaXrLdqUDdd19Fq/B1LCYjdhh+x21YwPRDrUyHM4uoqxjuS0ysJwljsVkMsl3mF904j1wDQFjfG4LM4/+TnvVfkFhLuuuhNKAX7xf6LXGhsbzKZ1FA4hRqVH+vMzVRnT0AngRzWDODrCMcyAhr6eOLpz9h+0WNivB2MmMo1+pzZMHr7uB8KbDXBsmmqCUXVF2irNlcJLg37Q41NknW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5I1ohhGnVK7bBCabH3u1jwoskNOKuqSMePERr4+IONQ=;
 b=t7Q0MU7rjvvQ28FC7LUMd9DWnO1XvM2znXgzFTZMfsR/kJjLz7yKoCyUcmbO2uNcJFJbF8cPf6nYNozeghnTiXiEWW0LD0LgKtK0fV6ESMEB8Ctvj/MQmc86RlXL7CqEVfVm3QWsxnxdxlOJ4vnViMnF+/Admsp2MdMSHvAUi8Y=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB4042.namprd10.prod.outlook.com (2603:10b6:5:1fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 03:09:48 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 03:09:48 +0000
Message-ID: <ba8b4983-804d-607f-325e-c9be24c23fcb@oracle.com>
Date:   Wed, 9 Mar 2022 19:09:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v15 11/11] NFSD: Show state of courtesy clients in
 client info
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-12-git-send-email-dai.ngo@oracle.com>
 <E1AF0991-A682-4B98-A62F-3FE55349E30F@oracle.com>
 <c5a82f64-d1a5-3ec5-2bbf-4bd596840cf2@oracle.com>
In-Reply-To: <c5a82f64-d1a5-3ec5-2bbf-4bd596840cf2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceb0e1f1-9dc0-42fc-8199-08da02436f98
X-MS-TrafficTypeDiagnostic: DM6PR10MB4042:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4042BC9C31CCE3B1137A28B2870B9@DM6PR10MB4042.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLaw65rbgF8LBORPANpU6zMJW5ATEnvDyKvLdcm7+klDJ0GhoGSnN4hVHrl8d6htO4ywO/Aqox0BIOaOrz+5C/ZvJX5+N5RWhTSRTeGHnpWFtluh6T44OdADIxTdz9cxp1XqP8sjUQFb137Hczkh4PFAcrVmaUkC73j2b0O2MJEiNgLVr7mmHu2QrXb5Du6cQpdPQHFNMH94A/Uo0eWyGoRHPjLg3rF6CJITBdRVZn7rp5QqPCmFy3+/Wtaw95q3ClqEwBBCPTP9X6kpqFHn4ydoMvGt0cWVMJQLFCrF5ISgNchNBSluWgrIsCmpG8tytfrTv/Ll9MxWWtPVBHIMl7qw7WojsRooCWHrDCxmC4KJNSJDjd7oS/k6+8oHDz0Jw7MERMoMHeiPICA9yiwraZWPby8iI1H6c6pLN7BL/7ATz78aeOleto/iUinGOO4DbHYma9baODNdqgsq/Nqy2lrZTo423RGTeY73ifLOmN+fpHmg4O5L6df8d+zcsssu9UcUxG9PxC6Jg+na4yOapcM4Lg7p1c8tbe0KJ8y0VznSC1DM14PAhgXk0xqzj0LQEdFTu1p6uR2K9zghMTyeryua4DTF3hRTWd23QzVOiQudPocxuUXMdauS6+xFeMxvPuLb3NKHixTsaWUYSaRzSOTZL002jD87BYN/Dq6h1HY/m13+5MbVq/z9tvRAfgNeNtpvf81sRwVdtWTsOeEqLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(66476007)(6506007)(8676002)(31686004)(2906002)(36756003)(6512007)(2616005)(9686003)(31696002)(83380400001)(37006003)(316002)(6486002)(508600001)(5660300002)(4326008)(6862004)(38100700002)(86362001)(8936002)(53546011)(26005)(186003)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVh0aFJZdGhIZXVybWo0eWRBL3ljZXpIbkNuL21kZjQzZm1kUXJXSklHbVpN?=
 =?utf-8?B?TjgxRjRqem40ZXZXRDFRQnpSQWM5MVJDMlgwM3J2R2lNQXdpYUJ5am5kQnFw?=
 =?utf-8?B?d21xeHlQRmhnSjlkTGZYSnF0ekNEdHc5R2ZoSENyeDFvTVR2K09hcGo5VnJn?=
 =?utf-8?B?ZzFzSjdEc0lTSTRLL2VsengyMXBEMUl1Q2ZYSFFkblhMei90M08vUklpenVu?=
 =?utf-8?B?VjNWR1l6eGFrNGVBZVh5Z3pqWVdmdUdSL1QxTkJic1krb00xeHBzZnpHWnhE?=
 =?utf-8?B?RXZ2UGIzOGlRY29GZ0RWR25HL2JHb3pWU0NiVWdaNFVXYWpLWDZ5ZUN3N0Vy?=
 =?utf-8?B?ZnJ3Tkp0cTFUTUhKcFZvKzFyeCtTL3FGd0c4NzAya2lhSy8yT2k5NXFncmxl?=
 =?utf-8?B?d1lrWDAyN2hER1RKUVMrd2cvTWN5RWdER1QzVEFaaUtrNWxsM3BTa3J6c2RU?=
 =?utf-8?B?Q3pvZXpwckV6QVo1cXBzNm00M2YxcmVVWlk4OTZSVXU2SkpxSUR5N1dNcUtJ?=
 =?utf-8?B?L0g3bzBaNE5CanoxYlBLOEo5dVRGcEJZVndocWtkMVNRdXpkTll4SGp5eVBL?=
 =?utf-8?B?OWwydElyVEJsZ0lvQW90dmxiSkZXa0UyNXhlYVpZV09zcWJrRWRxbWVubWxs?=
 =?utf-8?B?UU1DVklWVkJPaGFKaU5ZcFJBMlk0OWp5U1UwRFVPRXNGcjBPK0lRWjluNmUw?=
 =?utf-8?B?Y1lrVnVuZEVrczdpTlJnQ0xMTmRyaVcrYTYwYVVwc2VHbURjNkhCMDNNVzdO?=
 =?utf-8?B?S3E4YlhCVmRqYUFVZFpoQUJHcnRUcVdIMHVXZFhYYytWdHhCVW4yd05FSExG?=
 =?utf-8?B?U2hvRFFrVVZaSjdPMVJ0NlRJekZlRU5RVFhFZ2t0bTJMejU3YzhvaUtFOFVN?=
 =?utf-8?B?b3FvR1hOUEJ6aTZkeDJVYVRaem9HRXcxM1paelkrdjg0K1QxUW94aTRQREV6?=
 =?utf-8?B?aVNwK0lHZ1VqV244N1lucEZsejkyYmF2Y3g3bnMzWFg0ang1MnlxejJ4LzVI?=
 =?utf-8?B?UHB3ZXJsUUNDelRCMDNtWEErNkR4SWdTRWwyc3hObzVXRitsdXVNQ29tbUdK?=
 =?utf-8?B?NkMzb0gvUWZRa1hQaWl0Tjl4UTlhcXEycmNiZ0xZRE1Na0JGYnVvNjhzUHgx?=
 =?utf-8?B?cm50cHhFUzZnL0djRWJUcmprVldncFpEWlB4RmRTSDJuQmFwMW4vZ3RseWxa?=
 =?utf-8?B?bGEzZTJhOXV3dUdmbURwTXBQQklZMFUwdjl2a3pnK1JVL1hVd250K0FUTjRM?=
 =?utf-8?B?Z3MwaU1MT0hNVVBDVFlvUjZyS2FHMVA5WUtxYWdram1GT01TbWxrY2p5L0Fo?=
 =?utf-8?B?bnJSYm1RWkVGdVUya2ZyTFd4VEw3eVFEWjNrVjhXczlSQmV1ek5vSUIvSUgy?=
 =?utf-8?B?dzR5S3lTTUcyUWM3SklhUEYvdE5FZEpaRnZDbEJmbjN3Z0lUUkFjVnR1OE00?=
 =?utf-8?B?eHc5SWI3TURQNTBtVnhRcHRSbDRKVnlrTWNwS1lPUGhnY2w3UnZUVnpHVmh2?=
 =?utf-8?B?Ty8wZ2ZIU3JLeHIyWDhxalNVd3UzamZVY3ZlT24zVUcxSFJzajV3K1pzS1lt?=
 =?utf-8?B?VDZpYzBZQTF5SE5hRURtRm5iNE1MZ1hBTy9ENG5GVzVUSDgyUFZPQ2xOUWhy?=
 =?utf-8?B?MUZaVytCRTlJa2pkV2Uwa000NUNRVDRvdUFPZmR2TFo1c2dIZHlaSi94bTNn?=
 =?utf-8?B?aTluTVNBdFhEaFM0R2JRZDAxL0R6eHo4WHRSelkyR1hvdndmTUlSQVBWay9h?=
 =?utf-8?B?ZzBpM2psSHBEUmd3VUFmbFNxY3Yxc01UdVo4VDJjTHkxWHJGOS95bVRNdnFi?=
 =?utf-8?B?Y1RyKzFNVVNZY0pBbm81VFBjNFlDODhVNXNPSEhBbmtxbmkvMG1jTWZPUkgv?=
 =?utf-8?B?eW9yMWpRRnh2Y1BNMytHSERvUTQ0d2Z5KzM2a3BPWlg1SEh5a0FnUnRDRlk4?=
 =?utf-8?B?dE5samFqNTV5aXVMdmMzVVlqNXc4OWZMdWMxTXE2bDBoL29QZ3Nzc3N4amc4?=
 =?utf-8?B?azQrSU5TU1VtOTFGVnUyY2xwRFV6cDQxa3FlWjkxTklaaHMvMENxVlV1bUh2?=
 =?utf-8?B?ZGF4K2h5SXhoRkZBQ1ZVTW8wbExrUU9taVQwTVdNSTV0ZFlGL0xZKzMrblN6?=
 =?utf-8?B?OXUyTmhwSmFCbWRwZ2ZOMGtyUm5kTEVEYlU4NVFZbE5lMTJRdEtOeVJMbGFk?=
 =?utf-8?Q?XRljTH5yQGbStkUPA04j8CY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb0e1f1-9dc0-42fc-8199-08da02436f98
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 03:09:48.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OxYUgCwNFWIFExcDlgMiO/E5KUurESlpKXxX3Al6kH9E+BP421MtKUSjnLG8jRpwEly16n60uXrmvCqU2tEzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4042
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100013
X-Proofpoint-ORIG-GUID: 9Tlm8GMRc4F5kYyedqDPsfFi7W3n3n3q
X-Proofpoint-GUID: 9Tlm8GMRc4F5kYyedqDPsfFi7W3n3n3q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/9/22 12:51 PM, dai.ngo@oracle.com wrote:
>
> On 3/9/22 12:14 PM, Chuck Lever III wrote:
>>
>>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> Update client_info_show to show state of courtesy client
>>> and time since last renew.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c | 9 ++++++++-
>>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index bced09014e6b..ed14e0b54537 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -2439,7 +2439,8 @@ static int client_info_show(struct seq_file 
>>> *m, void *v)
>>> {
>>>     struct inode *inode = m->private;
>>>     struct nfs4_client *clp;
>>> -    u64 clid;
>>> +    u64 clid, hrs;
>>> +    u32 mins, secs;
>>>
>>>     clp = get_nfsdfs_clp(inode);
>>>     if (!clp)
>>> @@ -2451,6 +2452,12 @@ static int client_info_show(struct seq_file 
>>> *m, void *v)
>>>         seq_puts(m, "status: confirmed\n");
>>>     else
>>>         seq_puts(m, "status: unconfirmed\n");
>>> +    seq_printf(m, "courtesy client: %s\n",
>>> +        test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : 
>>> "no");
>> I'm wondering if it would be more economical to combine this
>> output with the status output just before it so we have only
>> one of:
>>
>>     seq_puts(m, "status: unconfirmed\n");
>>
>>     seq_puts(m, "status: confirmed\n");
>>
>> or
>>
>>     seq_puts(m, "status: courtesy\n");
>
> make sense, will fix.

On second thought, I think it's safer to keep this the same
since there might be scripts out there that depend on it.

-Dai

>
>>
>>
>>> +    hrs = div_u64_rem(ktime_get_boottime_seconds() - clp->cl_time,
>>> +                3600, &secs);
>>> +    mins = div_u64_rem((u64)secs, 60, &secs);
>>> +    seq_printf(m, "time since last renew: %02ld:%02d:%02d\n", hrs, 
>>> mins, secs);
>> Thanks, this seems more friendly than what was here before.
>>
>> However if we replace the fixed courtesy timeout with a
>> shrinker, I bet some courtesy clients might lie about for
>> many more that 99 hours. Perhaps the left-most format
>> specifier could be just "%lu" and the rest could be "%02u".
>>
>> (ie, also turn the "d" into "u" to prevent ever displaying
>> a negative number of time units).
>
> will fix.
>
> I will wait for your review of the rest of the patches before
> I submit v16.
>
> Thanks,
> -Dai
>
>>
>>
>>>     seq_printf(m, "name: ");
>>>     seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>>>     seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>>> -- 
>>> 2.9.5
>>>
>> -- 
>> Chuck Lever
>>
>>
>>
