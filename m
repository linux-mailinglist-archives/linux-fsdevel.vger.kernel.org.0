Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1A34EB4DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiC2UwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 16:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiC2UwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:52:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A6117585B;
        Tue, 29 Mar 2022 13:50:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TKn7nm013109;
        Tue, 29 Mar 2022 20:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pkt6QfkB3Wkj+Q9KH9vRqJgJ7+ctNPp6Z+VTniFbUYo=;
 b=wu34gPRI8tyJKwJZtuvntIzYCXnMg3X0dy1W6TfLTfJ/OTCtx4MBkGAsLg9g+GX7wH8k
 iBD4MlQYouTsqeb41hPwcyvJWATb8KZ4nbQO7H2wNj64axp8nDcqFKLYX67FV6oUAatv
 e+IKm7r5OpyKMsN96hYG1nNbq7KAcxxDqLBsQJH8z3+APUo9SKTwuWycsIf2JljEKT/A
 Z+NXYCT1epQUpaabDuwoiVxni8f2SQJSqRzSdi+Pjy3oW9PQiulnUk/6TbDWJsejr2s8
 5reeazBzTEdAP73/ImiyH69adCF/vDFagKhvRFW+gc2vyNYBz61d3GcY4K4gi2AWO9px +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb7nek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 20:50:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TKek7d117966;
        Tue, 29 Mar 2022 20:50:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3020.oracle.com with ESMTP id 3f1tmymt88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 20:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGR0MbGsru0ALi9W6BNzzhB043TALuDxxYaqY7RYFfk0b3eh2/d3hPPmJIuUTrtyK1iJ+T+HBeQD98iacuEzjKLIYSTH/hWmTjDeXi4C19JgxHEM1ELKqqrptUwhAgqITX4xrCeRqpvAXtRsqkIsFlsyunJqEyu406TSjvOPf1gQJaui+z90u7BYkgf3HkML7F7k0bjwe8tnkEgtlSSgnvBbgjfCmg1JmgESxO96H1nIOmUvuSD9/80zhgRXU+IT1plG9xXDuyX+T9oXSWO2CzOikDbFdoyZAtSpV71RAr6OVlb+UwbGwfGNx1hKzreb3dvPS4JuxIvOJm3yENZzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkt6QfkB3Wkj+Q9KH9vRqJgJ7+ctNPp6Z+VTniFbUYo=;
 b=Ot5DYwK6Tiax1DcYQHWYJj7VWVoHh+m5UMT5Ny5OzfbTcHcrTXqKES2/NXCs3HqULGT+7AHmWlukkEPUG013pKF4UNpncyVpUw6f3Z/hTVaqVoJ989HAiNwaRlgOGYCOCSdpmkFiR9z6xqELBv+JkT2enS7/qDrod8vnZoHW821Oxyo5Lqh8DKDjES04iZrHqSGo5Nk823xrAuBpAgky5fru8Eaa0D6EFYxrlYmu23PIfeyxC4TQz5wYD+W87oH2YWj2gh36uaYEgxypRrFEv4n/Gx/hGIqEX3d6g9XkImzBCidcDMWxfABebZ0nzzEpU55c3r4nQlSy9F2ovmCHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkt6QfkB3Wkj+Q9KH9vRqJgJ7+ctNPp6Z+VTniFbUYo=;
 b=qNSZ4NRwQkayoc1pcBeyBFhoKFe3Orl4497/ukEwGLHLTNnWN35+g5Zhk7BW+5tUBF6kdl2Q8aR8GG9mJIhuVrg3RHruQul9Zb1tlcJs2sql8qKKW1BRhW8P2G2sfC4aZjCL+mdWNnSO/eCofYFMHDpf0a9xlwO2URHns8Vvczc=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by PH7PR10MB5856.namprd10.prod.outlook.com (2603:10b6:510:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Tue, 29 Mar
 2022 20:50:31 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 20:50:31 +0000
Message-ID: <3ca33d9b-d4f8-5972-893f-5b3f1561caa9@oracle.com>
Date:   Tue, 29 Mar 2022 13:50:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
 <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
 <20220329163011.GG29634@fieldses.org>
 <5cddab8d-dd92-6863-78fd-a4608a722927@oracle.com>
 <20220329183916.GC32217@fieldses.org>
 <ED3991C3-0E66-439F-986E-7778B2C81CDB@oracle.com>
 <20220329194915.GD32217@fieldses.org>
 <ACF56E81-BAB9-4102-A4C3-AB03DE1BAE76@oracle.com>
 <20220329200127.GE32217@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220329200127.GE32217@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:a03:255::6) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a341fdca-bf4a-4462-9b8f-08da11c5c342
X-MS-TrafficTypeDiagnostic: PH7PR10MB5856:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB5856BAC2E66FCAFBD0F9BD76871E9@PH7PR10MB5856.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNdnV3qYyCSeAK+pUG/xx30++1tuPSHK3jH+ix9EUHryC6ltd6+1xPwpniqCc1eNmQrVHXzh7W/QsITIjisMoLEdfsIRxmdBbAPpHKR3QMSGT4ozsRDijwcVkqFchu6zyOx52MJe5KqTIHVdSCfiCDOsDsX+qD7zoz4zY2hbXrZXuHxaVTt0khKmKWyR8J916ayuyz5usGzruCtnuMrxU9nFrxFcEMVQzJ9rRWrxvKJlW4QzpSvzwtfYl5eK2sM4YwTMn1yyWIgRqEND5p6qUedCiMcO8M6KZmjIPwvm3HQXqazgmYTgJVmQClMClXGg5ApqIcAEAOHsKebzCdDiEFtpE6/l7Vp1LeafFvpSkHsKQLcTPtSZylXUhvZXoOICcIXPsK89iKxR79r2hPf6OwiYWny0Nq37V7lgz4yp2NgnAbPLsVo2st5OUvlWQUsT566mArF8qdpuG8iF3fR1EWaqb1Pf0erI8fjSgiNqdpQIP+KIpYmlmjllNNqg32D+k/iSicAyheR19T1gbzI7oQfRMERZ0NFN5tmjUPe7XqZbFp0njW8eFNYeO5JHSJVt1BDc28q7hJnK3LeejlldgCcYHg756kC+RXIt+Vp1ZM1UjwsuHQWealdOj+cQpD9wKw1np6V9nyEZ15tF8PneeirAU9B6Te6iiPqCti1K8j5G7AW6ZwnQ456FfLO1aaAM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(36756003)(86362001)(31696002)(53546011)(31686004)(26005)(2616005)(186003)(6506007)(6666004)(6512007)(9686003)(508600001)(6486002)(66476007)(83380400001)(2906002)(66946007)(4326008)(8936002)(110136005)(316002)(54906003)(66556008)(8676002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG5yQ1NiTUowNDZmN1JZdC9lRUhBQStDb2JtdTFhMHBaaE95Ris0M0g0dTlR?=
 =?utf-8?B?Ym5RdUlMdWI2SlUzMDI3SWRwUWc1SjRSbmJQTis4RGVMNlJXb3o4U0lYMGt1?=
 =?utf-8?B?dWJHT01HNjExU1Y3dzlKNFZ4d3Y0SnNTcUU2cUJCaVVNY0E4YUM0V2lkT0RX?=
 =?utf-8?B?TTFjWjF0b3RqVkJxOVVpaUVranZWNGdRSGNXZXNFWXY1UlZDZDUrTnlqdXNw?=
 =?utf-8?B?NENodFBPc0xlb3M1UGZ0d0kxbGFJM1pHQTNDZ2xZYVJtbVhPcE1OSjhlQzgx?=
 =?utf-8?B?clZFNmUzajA3cjMyMTVWcEdHRlBvQm1KcnRyVzQ2MGxBRDExL29kSnZvYU4z?=
 =?utf-8?B?VmVxTFQ1SnRybks4ckdjaG8yMXNEK25ldjRyNWJ5ak9HMVBwRlZmYTNNOVBy?=
 =?utf-8?B?NEZoNEs1dFMvdkNPUWYwY2NaamZMaGxETFlCalZwQjZTQWsrZEpFSmx4T01o?=
 =?utf-8?B?RUtzNnl5cHdFamM2MGpWK3ZibnpxSnc1MnJKbUoySXl5eGFEWXl3ekwybEdN?=
 =?utf-8?B?dlByYzhtcU9ldlk5RFlYamVUVERONjFWT0JOcXoxSzMvT3EyQTY0c3FPSi9Z?=
 =?utf-8?B?NXFxV1dLN2ppR2hTUFFxVHBpTjlDc1F2MHhDQkJqSXlsMGd6TEtrZlVBTVdr?=
 =?utf-8?B?TTVuRFlzOXdOM0RQRlE2SWZhOHRTdmJYWHRPVWVEemNoeHBxOGJBUlJBcGdO?=
 =?utf-8?B?S3JEK1dNakl3Z1k2OTVYZ0ZBR29ZYVdsR1VQQmIweW8rZmZBaXJwckR6QkhP?=
 =?utf-8?B?NEFiZ2x2ZkZ0MEJ5a3dIQ0oyTWw2NHU2VzMzN2l4OGRmQ0ZRUjVDNjMwTGVy?=
 =?utf-8?B?OUg1clNXOWJTcStkVGVKb3RUUVVTZUpKWjFqcEwxbjBuN2VyWDFQQTc0Wm9q?=
 =?utf-8?B?YVJrc1UyZ3ozaUMvZG5TU3c4Zk9teFZycFhmbjZNeEZINTl0VFVkL0VwSHov?=
 =?utf-8?B?RXpjYmVlZ0pHOWwvZHFvdjl1UGVCVzhTYjF5Vjk5VjRjNXJhQmlhSStISjRo?=
 =?utf-8?B?dU1jSkg2ZWFWcjZpK3JPNDNvUkwrUkN0V3cvZm4rOTFpNVAvazh1ejcrVmdk?=
 =?utf-8?B?NHNIOEdoR2FCdHlxTDB1Wm1ZMVh2QmdpTmVWekhiSktqRUs3MmN6RGNEK0Fn?=
 =?utf-8?B?ZWdRVkt6dUU3MURtTjRRSFAwM3B5NUorTk1oaDZsZjhSWWNnSE42b1Q2TTBq?=
 =?utf-8?B?a0hFRFVRUlM4OUFlcTlrSnZSZjNka0tDbm50cG9ibjg3WTBjNEJqUG81c2w5?=
 =?utf-8?B?aCsyeitaZVFUVDd2S0FNV25KcXpDNmNpZjZmbUpqUTZCRW1jd0laQkcwZXk4?=
 =?utf-8?B?TzNyQkw3dlJwNWhzVzVpTkt0djZ3Wm53YjFramd2VGlMVEREck93OHFSSG9R?=
 =?utf-8?B?YTRMZUV3UGt3OGFYSTNxcDdNMkRqS3FTTWdDOUhheVAwNFZoYWZzZjRVT1Yy?=
 =?utf-8?B?Wk5jREd2bUtzMkdZMFJsTmJ2OXVSZ0VVSFA1eG5xRXl1ZFlYVE1MMVVnUU1Q?=
 =?utf-8?B?Vi9FSnNYUnNIRkZrdTBXU0JmMWdkNXJ4dU5tLzBOVU5IakQvTjNtaUZlMlZM?=
 =?utf-8?B?OHVLcmVDL041K0lxTnp1TUFaYzJtZlUxZFljQlBUT0dWT3pHcklUV1dzQnZi?=
 =?utf-8?B?U1Evc3JXTFFlUjFZekNpa0hEanpZZXNNUCtTaFlydjBhMk5YK1IwaUJpd1pv?=
 =?utf-8?B?YUloUzF2S1JNRDdLT3pLTTR6bm1YaFVrU1BZNDg2cENwWTdCVWdpWjRRbVBB?=
 =?utf-8?B?cE5YdmJwbDkzT21CRDRwemc0SFpENU4rekI5UlVDUEFyOXJIRTBuay9walkz?=
 =?utf-8?B?bHhvZGw4cW41MjhHM1VWb1JBS0I4SC9Vb3c3UUhrUlhmNTV0QUtML3FYdnZM?=
 =?utf-8?B?a1FKOVNiNlkrSFN5S1FUaDdtRlAxN1BtUXBLQVl1aW95M2VYWEVadzJveW9L?=
 =?utf-8?B?MWRVMlRwbFllT3E5ZjFpQ2V3M08xczA5ekpjbGhMSDV3S3FVQXlYY1VHOHJi?=
 =?utf-8?B?Nm1QTmQ5c090dWtUNVZqbWhqY1ZxZVFmOTFXNkxvYW16KzhQY2M1UTkyV2hB?=
 =?utf-8?B?STRDQW5Mb2VxaXMzZ0ZJRkY3TWx3UkNRVmJYN1pIekdrTnNFbVo1ZUdVRDY0?=
 =?utf-8?B?MVI4dXFyaktHVDQrd1BhdHJIblp6MXh6dmFWeENKaW5va05RSlVpaytjODRQ?=
 =?utf-8?B?Q0tGdUd1TlNUOTFNdXBpVStRY01vVmlhYmdBSkFBb0dqV2JFYVNxMmpoNVpD?=
 =?utf-8?B?L1pMKzgwdDYzaUpKMk50K1VhRVplNkNkMmEzNG5wMTlmVjJOWWxjNWNVU2sw?=
 =?utf-8?B?ZTI1OG9UbERDNldpYlBwZjZLTm9TRFpLaENXcGlVd3BMeFhiNElNUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a341fdca-bf4a-4462-9b8f-08da11c5c342
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 20:50:31.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbPYqKQxlJ4j9pnSpsSpDf0Dbo6OD8/ZVy8amk3Y+PkMMXvLg6CEWY1+aNd1eZiN+g86McjDY4zhZnoWzxHwvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5856
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290111
X-Proofpoint-GUID: WS1HIQUvHuE1y3goUXDHQWcBdbAKsu0Y
X-Proofpoint-ORIG-GUID: WS1HIQUvHuE1y3goUXDHQWcBdbAKsu0Y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/29/22 1:01 PM, Bruce Fields wrote:
> On Tue, Mar 29, 2022 at 07:58:46PM +0000, Chuck Lever III wrote:
>> Got it. Agreed, cl_cs_client_state should be reinitialized if
>> a courtesy client is transitioned back to "active".
>>
>> Dai, would you add
>>
>> +enum courtesy_client_state {
>>>>> 	NFSD4_CLIENT_ACTIVE = 0,
>> +	NFSD4_CLIENT_COURTESY,
>> +	NFSD4_CLIENT_EXPIRED,
>> +	NFSD4_CLIENT_RECONNECTED,
>> +};
>>
>> And set cl_cs_client_state to ACTIVE where the client is
>> allowed to transition back to being active?

fix in v19.

> I'm not clear then what the RECONNECTED->ACTIVE transition would be.
>
> My feeling is that the RECONNECTED state shouldn't exist, and that there
> should only be a transition of EXPIRED back to ACTIVE.

For the client to be truly active we need to create the client record.
We do not want to create the client record when we just detect that
the client reconnects because not all the callers want the client to
be active, we leave it for the callers to decide. Also some callers of
nfsd4_courtesy_clnt_expired hold the nn->client_lock so we can create
the client record there.

Leaving the NFSD4_CLIENT_RECONNECTED state set does not really
cause any functional problem since the RECONNECT state is meant
to used temporary within the context of the same request. But
I will reset the state back to NFSD4_CLIENT_ACTIVE for clarity.


-Dai

>
> --b.
