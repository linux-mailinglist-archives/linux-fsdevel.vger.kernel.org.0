Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE994A92CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 04:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356842AbiBDDmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 22:42:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49088 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232345AbiBDDmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:42:20 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2141eKrc028755;
        Fri, 4 Feb 2022 03:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=I0hRPwim3/TZ0vLO4cIE1g68s4V3brjqKVaVrILfIxs=;
 b=oFZGr33CyVbOy334z3nHS8fI8iwbOTvw92h3VdwUwbuXzZ1o/SABnMcMIUs//NsS4o2L
 bKu0dXVUo1nqczMPD70iY56jCPbiyxx9ZolAJuyTOTPjWz8TrlgoSAlyU1C4tdW3Anc6
 ftw48+hOoRNRUVRJDsTGhjHl7UzjW0d1RE8oMTn3NfJNAlaO2vvDBIqC/sCKw1dIknb5
 lu/DD5cIqvleA2xVCxgcGm3zatW5Yh/P4ClIWP1YvLiQZfvVj2ZQRTPawcZNsW0W5sKg
 jp/SCxEjhRxnImeWEp401eGLs8x+antUthtMBRWzV61VsNNTbIoIqstrXRWLraocuk1v 2g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0het9k7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 03:42:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2143fVK2172148;
        Fri, 4 Feb 2022 03:42:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 3dvtq6mfp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 03:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXE4l3hbapNqUqD9O1lltJdl7UERoEYcDAJxDzeEBcJOBHw6OGcH+u1denqgPEdcy62e/BAshddTvYCq/eKmdw27nA976uXodR/TGNPFWhQL2j/fUHCw7oJyjklW1DOQHC/EsrhiyDNH2H6lPusJ2avp0Woql9/GFeU67o5gZqohqZSOwQ5jtJkzuF9BibA0mOL+N12zg1pGyc9u0bQCJiETu4Oez5RHL5UfLNZA6HK7UC9Hf31vRB5ajC/JcntAWk97X9w5l4SytIgVNg7rSRy64sICOhnk2RkvB2EikjK51XoWxpVrP317jiKLlp99HTIX273FpL8CmJ4ExxBOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0hRPwim3/TZ0vLO4cIE1g68s4V3brjqKVaVrILfIxs=;
 b=j0didJ48a1JKgXaubpAFamcmdnuH+Anl9tllA8RP5pH7PSi19k8tEWoH2QMxxKqSrs3PjX29UDtCjD1lXsyk8Zi02CMZfpkCcSXgCjMv8h4g6MdX5Zai7ISoovZnhvX9FhUdEkO69zUgE4ZqDNOKLJpozvfqskbqRL3b1h/XnayaWy6+sUy7MpnaE7il/VAWtI0JXgCGq23dz5mquE1dl76o/xrl7dg104JKHZgUnRRI1peTOEZCftIU5GV3dVISWDnWTtA9DyhTawjL+NmJKzRcsTXiOAycl3kvN5a+tNYNlvgiMScpvP6Ly0ydXTCFQUXrvtsjo7Nyf6HMZ5u7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0hRPwim3/TZ0vLO4cIE1g68s4V3brjqKVaVrILfIxs=;
 b=Ol4IV5ZCQV04GRc+lkgauvMwyy3/rKIDQRT0DGHGj429Thvu4xS5oxaIVQpor1lCo5y0Ggi7GMnb6NXfT8ryhgKTOydZqj4cd0ZLxdB34OgwqBOyC9ua73IzLspHmLxgtrFSuFd5PjMjDGLsjN/wrb6xaDdWb04iUMPWq2RsQug=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB3837.namprd10.prod.outlook.com (2603:10b6:208:183::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 03:42:14 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::89db:be97:ee10:a192%6]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 03:42:14 +0000
Message-ID: <36d579fa-8d7b-113c-704a-479b7365173b@oracle.com>
Date:   Thu, 3 Feb 2022 19:42:11 -0800
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
From:   dai.ngo@oracle.com
In-Reply-To: <36731CD8-E35E-436F-AF1A-9F97C0ADCA57@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bee3518-392e-4790-29f1-08d9e7905567
X-MS-TrafficTypeDiagnostic: MN2PR10MB3837:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB38374ABF384009CFE743140387299@MN2PR10MB3837.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4T+ueX9t4va4IlQMCS8OYkdraqup9lF2tagiFrbJarpwmZVO4DxwOXNR89SUXv0/9ubUnA1ZFRPESUcFJDHlqZuqdmYbcb5IJ5secHCns050U3qaoVokPU9GQ76QAyqhOhTW/qcWNi/b125r1V0eqPTK99PcBa5XX/2hQ7i1e4nGEIDe9pzMu5D+sVk0XsKZDLGAH8r3fhXoN76Q/2dtq8AmQibJhOZ9AWTvD2hdVqQSF1Oqi1gD6E6IadDO/AmTFrLgaVBf+u4C7XrOAg9aUmc6URmM+lE9isUvpwGRDPFlKJromxDem9XxQcCiugjl4dol/Kn4N0/Zv9+xZNVUUqBwunzZal633rxM28xfiSOAx3/X/6gs9m58QjkFv/G6/C7m2mJ4Emyu5Vg9umVtquhlIimKPwYK7A9b46mEkuln5LLVPbwlEpiYTdfzCfksfH5OEyfoweFc49kz6mpgwmDevah0dAhHsHEDLGBGb+oyDm9adeiJ7CdevOaonzss3eb2TNVIkHVoCGkzwnp328BuLhl0WZddQ5uHsbgJj5pEAq3AvORtxwpoNPg8uVH5F8L6E8LpqBKpzJmAh5jRSETKOVKprmYIF89vyABVbSDj9HpZtqssuo9Cpq0xFFMUpvmLUj8dh0OTmPRAHdc1crNcxamseJZvF+3EbxfGrKSDt5a8V3MnSoMey6akZVqaCnGdASZAqW2LIbQe2KslQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(31696002)(86362001)(83380400001)(5660300002)(26005)(38100700002)(186003)(2616005)(508600001)(6512007)(6862004)(9686003)(8936002)(8676002)(53546011)(4326008)(54906003)(6506007)(6666004)(6486002)(66556008)(66476007)(66946007)(37006003)(316002)(31686004)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1hnamhHZ3JrS0lQMTVpZjFPeFhjUVczajhwejVWR2lnRUFncEl2NXUzMlp3?=
 =?utf-8?B?bFJkSjhTREdLbnVHL2QvT2lZZENWR3dGVm1ESkJwRGNpcWhYM1hGb2ZvTTZY?=
 =?utf-8?B?RVdadU5waEM4dWFJMjRFL1d4REVNeW9pUmlLMnhWaHJuY1lVYlJyZmNGS1Iz?=
 =?utf-8?B?blpCbmhzdk1QM3pCWVpSaEtCb2FBODJIaWE0SkdaZmlSUDZFMWlzMEFWSWdW?=
 =?utf-8?B?TldwMmE3Y1V5TDVSYlUra2FTTXcwU3Q1KzEreXJPQ0hLL3c2c24wMDFTNnE0?=
 =?utf-8?B?cVF1dytKblQzWjdnU2RDZTdyTXpsWEwramxycmE5OGxiRWZVd1B2bWU0SXdj?=
 =?utf-8?B?bjBGUXh2TmhpSWFKK3U4RGxER0d2TW02ZXF2eVdNdGNLeS9mMTFoSnIyUVJI?=
 =?utf-8?B?R1RhcVFKZ0dvWTRHd2JXM283Yzhhd01KU1o4cVg3NEtqdDNPT0ZEVFI3SzFn?=
 =?utf-8?B?U2FVS1BxUFJtaWFyU1lueU1paElEdXZabVVPY25lSjB5b3dhUkZ5YlNOVklk?=
 =?utf-8?B?eHRqaEFEM2FLS1J2WVErRjdCRUhUcjRhaE5xQnFvMk1aYWczaEdtdHAxQ2hW?=
 =?utf-8?B?V0JaZzEzdk9hQlBEZUgzeUZ1dDhkSkFMTm0yZnU0UmFYNmtScTEwRHRNTGdJ?=
 =?utf-8?B?ci96V012WDBGSHo5UllEZWkvT1F1VnZHT1hrOVdDNVZMYUJRRXJYTSt4bWJn?=
 =?utf-8?B?Zkd4NkFDRkVtbTU5RWo3emZjcWNhb0VPeXhlUUx4QVVHQ0FiYnY5cUl0QnBu?=
 =?utf-8?B?cmh3Ukg4WXUrNjViZkg4aWtLdFpsei9wZURCZzZkZndCZklYbnBmcFI5NVpi?=
 =?utf-8?B?eWIvdEJ5T2Q5M0VDRVdTaEhVSXlKTGdHN09TUFJCSVhneUdlYnhPRG1WZHNj?=
 =?utf-8?B?YmdRVU0zTUE1bk9xS2JlWkwzV2JqVTM5M1h5SDlObldSVzd0TThUMXhiOUk0?=
 =?utf-8?B?MUU1R1owMkRNMXVzQUFIbFU0RnluZUozTS8zV2QzcktocEVzSU5pVVhnY0Fp?=
 =?utf-8?B?azVCbzlzWDQvM2d2Wi9aNGRFSXA1RjhwR1lLWk9GdmoxTW5jUXV1dCsrU1k5?=
 =?utf-8?B?TUdYLzRjRkR3M3RkUUxRNG9QUXFjQm5MNjlSdkwrMnVTRHVtRzdnL015bVNj?=
 =?utf-8?B?V3JOTXpiUFIrWm9MSm1pOTkrbGMrTWpGM2ZObnUzTXlBbnhIQVJmUCtCZVY3?=
 =?utf-8?B?UHdoMHp2cHNMUWE1Zmx1Tnp3eVRLSngxMVErb01YUEx6Y0M3UWlsZGg4aGMy?=
 =?utf-8?B?cXJ0bHh4RWg4N1ovc1ZpTnh1RmRzcGVkRm1BaDZLa1BRNUlubVpiWjY5QzJh?=
 =?utf-8?B?UEhhcVVrZkxzWmpHSTdRNTZmMFQwZnZhc29BS21WVmlYS1dRc1JHclBlNEtn?=
 =?utf-8?B?WTBxOFVSQ252bW1CT0xySGlPenhROWlna3R3V0xUTGFzYmtKbkVZMDd0WHdz?=
 =?utf-8?B?SHVFRnZYZjZBNUJ4VCt1cDlzR3FUS2tocUJGT1JENXJncm9qYUV2Y3N6Zklw?=
 =?utf-8?B?RVVBUmxtRkpJN1hJcVVMZWV6bk9PdGdnYlBlWEJJK0hWQnZTT0h4MVpFNVhp?=
 =?utf-8?B?REpMMStSOVJDbFlVVTVTZDVkM0t0Z3hiUUdhUXBrVjNsOWpVVll6eC92MExw?=
 =?utf-8?B?YTMvVUVKOHhFRjFjTFBNdjJXeFFsOGxFS3JSanBnRGxKbTRmK3JrMnVWb0lE?=
 =?utf-8?B?c2cwN1phcWZoNzdvSFFVZGl1SXBRdERNdUZ6eG5mWjlNUzhJWUpjbC9Rc1Ju?=
 =?utf-8?B?aUV2Vm45bXl2WmE3eGhVMXRpbFptMU1jSnhxNURyU0swZ3FHUWdCa1lQaHpE?=
 =?utf-8?B?cDhOdmI4eGJwdCs2VTJNdndRNkJyMDNPYXAwbFJaZ0RGR2FDeDY0aGZVOHFH?=
 =?utf-8?B?Z1J1MjRjZEZkeGg0WDV6Ymcxa3hxSkpKL3NKblZwQVA3Q3dCRWVPRk4wTzVO?=
 =?utf-8?B?aVQ2cGc5a21sU2pJQ2h0UklhVXdZbkNVRHNQNHFITXA0b0s0WER3cDJXemtK?=
 =?utf-8?B?QmI4ZjhwcTB6K21rM1JWU2trd0wrY0tUZi9DcWZGb3lSWFpVdjhHZExvWXd6?=
 =?utf-8?B?MGNVNUZxODJHRDM0TVZSbWJzWXlSZ2hVa0hxZjJXTTZ0a1d5RW5TWHBDbVRt?=
 =?utf-8?B?UnVmV0NSWG94dW04bnBFMnkrWU9SbTRWaUhsdFhmVCtyUzh2T09KTXlXVWVN?=
 =?utf-8?Q?ZZ+7+TCw2WLIhXmrIOZzIWY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bee3518-392e-4790-29f1-08d9e7905567
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 03:42:14.6110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWNSni4FNOuCt6yQ1NMBcyQiLJZNDUNFj437NpzZ2LPBhSzv5xSIL4MbY9iLc6voAc+1Ijk81n/a3ikHu7RB+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3837
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040016
X-Proofpoint-ORIG-GUID: Bz7OvV2WoPXsheCCvyWMmYaVT4KXlmll
X-Proofpoint-GUID: Bz7OvV2WoPXsheCCvyWMmYaVT4KXlmll
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/3/22 3:40 PM, Chuck Lever III wrote:
>
>> On Feb 3, 2022, at 4:38 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 2/3/22 11:31 AM, Chuck Lever III wrote:
>>>> On Jan 28, 2022, at 2:39 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>> Currently an NFSv4 client must maintain its lease by using the at least
>>>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
>>>> a singleton SEQUENCE (4.1) at least once during each lease period. If the
>>>> client fails to renew the lease, for any reason, the Linux server expunges
>>>> the state tokens immediately upon detection of the "failure to renew the
>>>> lease" condition and begins returning NFS4ERR_EXPIRED if the client should
>>>> reconnect and attempt to use the (now) expired state.
>>>>
>>>> The default lease period for the Linux server is 90 seconds.  The typical
>>>> client cuts that in half and will issue a lease renewing operation every
>>>> 45 seconds. The 90 second lease period is very short considering the
>>>> potential for moderately long term network partitions.  A network partition
>>>> refers to any loss of network connectivity between the NFS client and the
>>>> NFS server, regardless of its root cause.  This includes NIC failures, NIC
>>>> driver bugs, network misconfigurations & administrative errors, routers &
>>>> switches crashing and/or having software updates applied, even down to
>>>> cables being physically pulled.  In most cases, these network failures are
>>>> transient, although the duration is unknown.
>>>>
>>>> A server which does not immediately expunge the state on lease expiration
>>>> is known as a Courteous Server.  A Courteous Server continues to recognize
>>>> previously generated state tokens as valid until conflict arises between
>>>> the expired state and the requests from another client, or the server
>>>> reboots.
>>>>
>>>> The initial implementation of the Courteous Server will do the following:
>>>>
>>>> . When the laundromat thread detects an expired client and if that client
>>>> still has established state on the Linux server and there is no waiters
>>>> for the client's locks then deletes the client persistent record and marks
>>>> the client as COURTESY_CLIENT and skips destroying the client and all of
>>>> state, otherwise destroys the client as usual.
>>>>
>>>> . Client persistent record is added to the client database when the
>>>> courtesy client reconnects and transits to normal client.
>>>>
>>>> . Lock/delegation/share reversation conflict with courtesy client is
>>>> resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
>>>> effectively disable it, then allow the current request to proceed
>>>> immediately.
>>>>
>>>> . Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed to
>>>> reconnect to reuse itsstate. It is expired by the laundromat asynchronously
>>>> in the background.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>> fs/nfsd/nfs4state.c | 454 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>>> fs/nfsd/state.h     |   5 +
>>>> 2 files changed, 415 insertions(+), 44 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 1956d377d1a6..b302d857e196 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -1913,14 +1915,37 @@ __find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net)
>>>>
>>>> static struct nfsd4_session *
>>>> find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>>>> -		__be32 *ret)
>>>> +		__be32 *ret, bool *courtesy_clnt)
>>> IMO the new @courtesy_clnt parameter isn't necessary.
>>> Just create a new cl_flag:
>>>
>>> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
>>> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
>>>
>>> #define NFSD4_CLIENT_PROMOTE_COURTESY   (8)
>>>
>>> or REHYDRATE_COURTESY some such.
>>>
>>> Set that flag and check it once it is safe to call
>>> nfsd4_client_record_create().
>> We need the 'courtesy_clnt' parameter so caller can specify
>> whether the courtesy client should be promoted or not.
> I understand what the flag is used for in the patch, but I
> prefer to see this implemented without changing the synopsis
> of all those functions. Especially adding an output parameter
> like this is usually frowned upon.
>
> The struct nfs_client can carry this flag, if not in cl_flags,
> then perhaps in another field. That struct is visible in every
> one of the callers.

The struct nfs4_client is not available to the caller of
find_in_sessionid_hashtbl at the time it calls the function and
the current input parameters of find_in_sessionid_hashtbl can
not be used to specify this flag.

-Dai

>
>
> --
> Chuck Lever
>
>
>
