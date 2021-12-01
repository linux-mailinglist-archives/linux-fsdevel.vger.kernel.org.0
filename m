Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E054655CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 19:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244640AbhLASvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 13:51:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33936 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244775AbhLASvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:51:05 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Hv3iL032521;
        Wed, 1 Dec 2021 18:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nGQfgadPfIjuNKUVpJDUxgVrwlEd4lv3moXfzCpqgcc=;
 b=eK5kzdOwTp7/FkIZoSxL/PXs0E9d/lRDhrWoSxRsik3HG9/50OHusDsnuig1yKmdRlvb
 6uZ4hIFp2ytvgLaIKzKvoshKirs9LMBX9K/mPaohVuXhXx0/wDtPurSDjC87pcoefPx6
 SnH7Y0EDJzvJYJ0Np8/f0/tNEATMm4W5Hv6zfSUW9ey6p5tnScA3eTF4XIl7bqM5LERq
 xsTK0xtcO+C78D/jiYtaT5iBm2nMa6AH/MToINx5EJCM5PvqAh5aLU06iMnOEwLIikJ7
 a4SiAWn3h70XqVbJvsG+s0lPO7v68vDSXQFULH26P2fbOCwLNypMw6Xp+qsQKD7b5ySD 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpb701qqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 18:47:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1IUtGq074897;
        Wed, 1 Dec 2021 18:47:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3030.oracle.com with ESMTP id 3ck9t2bkrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 18:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPnbhrx6BjpaPweLzr4KHJpG2bXgupqAQvRPrbusViUe/wqhOpXQn1KESVogKiN2j6oFuZy2JU5bNhBU3fMUlQrampikYXOsO1eFwJ7Lx0aCZqUsJqzGAyp5doENzBEh9lyGBu2C0X4YlGT1MNvT/dGu18axDiMkl47KvxEn1SIpZJIc+UFwpPvsxS5EGjs4GLqVI9rhvD/ev0L/FZgQQHGYrHhKO+fLKhi3xySV/jxrE5c+7/1SM4M3DML+JiW2anP3w2V1csB8q5BPUmcIHyIj53HvbzTfW2cquTgxOBPTpT17iaemtOO1Qp2Ql2gPSjr1KCkuvKb9P4whcNQD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGQfgadPfIjuNKUVpJDUxgVrwlEd4lv3moXfzCpqgcc=;
 b=laCRxCvQZwybdCHp/JFWBb2mGgfDUzMX5TMoviSJB3grigJjVWHaozQj/KhwJ1AjnGNLwa8t2n1oSfkKR3dVZo0acE9564AvRHqc9QhC3XZ8Y9UTABlPFlHW9iqEw7nMajbErxiekniEF7IxkgdUsxCsQpcmnjmTPpW/SdRtFuxDqBALEIGyL4eJu9tHxfjrMq74OMzszoyEj4nPGzDg2fUtExMt0uZTpAw6ixuEZkN3fKnpN16eDVSZw29OroaYF+T+SEiN6kShxDC0Rrn0dcRkxDLdO9Y/N9pX+EiZ9vWMv0pDBo/ZBNSjxLt05M0StX5De2B21Qh/wg05TnrKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGQfgadPfIjuNKUVpJDUxgVrwlEd4lv3moXfzCpqgcc=;
 b=o82TiIKkgdRbOgcJroFAeLzk4VB9MIu9QUpU9FntT1kwZDhKtmqGbEzwOROlAOM0ih/flDtZAGpwMyi42zVeHa5IbDKWG7Rp+eru9x/IDsaCGHETGCuEWsthz2fw974xBl6FsVTZgGkC0eUkTcsfwAG8UyZinzz+XEnUXnvsF3w=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4575.namprd10.prod.outlook.com (2603:10b6:a03:2da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 18:47:36 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Wed, 1 Dec 2021
 18:47:36 +0000
Message-ID: <dbe51234-3e85-fb1d-ceb5-31b2ab9d829d@oracle.com>
Date:   Wed, 1 Dec 2021 10:47:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org> <20211201145118.GA26415@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211201145118.GA26415@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::24) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [192.168.1.116] (72.219.112.78) by PH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Wed, 1 Dec 2021 18:47:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae97f5e2-8a59-4c20-ddba-08d9b4fb0af8
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4575:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45753D5A9CE88CB55868D3D387689@SJ0PR10MB4575.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mOvUKeuzML4ZC5VSTpM9YqRYmT9zAN/LcSX01NorhMyVKwPQQLj/v1Tv0gKHa88WJnUIbMuSMrqQE47vvXxjHPkwRg85yoe+MlTpKKNI/Iq1OI4sD93J80/rNa2d6hY42pPuHe+Y4skiycvX3E6zXscNv6EylE3CIAmi9QkMt5VcLE/njZOdqUjqDkIJekjCQjHN8DomYrwbcJ+7fC+AkvO0WiXpVG/O776nAg3QNpPQ7DZ2eR74Ihbo//KBLZF8l5mBv4H/4lG//O1Vbrr4oAWpRWFlOTCT+PpeL60Vf3ar4+y2yJbSGZRqSGyUrUugddQ/Oz5a922o5uQOh38U27bBl6adjE2/bG6me7xrup1/bMLMrIYzk6LHIQgcHTYY70fxMwtNKvWYjpZb0FnqyTWmUB9Vw6D9F1kTWVpEsSDZLCAcVXBkGCnTDtmcQndTENWEy9HHlKAtYO5AyVRqX68GpkzPeDnj1KnO7rx9ckqN4+dTWlCkvh34H83Va+5KRkBbc0v9kaYD+8IxBwX8uHUt3eSs1/Pg39yx+C2iU0EsOSmxaV4oD5fMN1DgJy0Pe+en1cWVgoWV+PcBmJtu8fIMYQO1FWuFkvpftsRluJ0HcVJMGtGvxX7pF6AWA/6EKVMmPIE8D57BK5b6I6caXUuSq2Zb2/jaht3dRdIw+X7wnQqgUnkOAsDWu55ffTbqH8CCnBHxNnRhioPK5M48g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(38100700002)(16576012)(316002)(54906003)(36756003)(66946007)(558084003)(508600001)(53546011)(26005)(4326008)(66476007)(66556008)(186003)(8676002)(6666004)(31696002)(5660300002)(83380400001)(2906002)(956004)(2616005)(9686003)(6486002)(86362001)(6916009)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0lFVmp5U0toeCtmTGpWK1Z1VHVyRmpvY241RlFucjN2a200TEVFQ1lSWUkw?=
 =?utf-8?B?NlF6c2lBRXIrK09BcnlxM0Vpd0xGZGNQV1VKSUdYVUpUdWo1NHFVNVpVcnJ1?=
 =?utf-8?B?THBqRkJoQm9oOFlOTGxJTVNkekdMOHRKbU5TdU12THg5a1RmNnliV2dHOGtI?=
 =?utf-8?B?SEh4ajNreTI5OGdUQXl4cHVBT3EzVnVXTWFiNFNzR0N1UjBWSytWbkQ3czdw?=
 =?utf-8?B?MjI2WlJ4VmJlcVBNMXdaYmJSRjNtcE42TS9GOHYxQStwd2F5dlhoZldxaEhw?=
 =?utf-8?B?eGlieUxxRk0xMm51a0JSbk5sL3M3dHJPTkt1UWFtaXZpenQ4bG41TSt4bFpY?=
 =?utf-8?B?TjNBekJOU2RxMG5JK2dIbVlWYkxTZTBiTXVrc0VuS3haVGJOZFN2a2JSVVdC?=
 =?utf-8?B?NGhEUUNvSXlWRWNnRDFNQUVHK1RvaXoxdURzSVJFV1lCT1UzSFZEYUNvOHp4?=
 =?utf-8?B?NU1kdGpEVHg3VTVFbVAra2t5K0tXdjY1cXlDcGRleTdkYmh5bDBwNHF1dG42?=
 =?utf-8?B?aUFzejIxOEdrb0hCS3dibEdmVUFEUk5EbmRvR0VUa0ZVbDdpSjUvVXRqVDFm?=
 =?utf-8?B?N01la3ZIY0FibFArcXo0LzBjVStXYm96bG5hZUVOUERIcXVXc0ZtRlk2dWRP?=
 =?utf-8?B?Z1F4WHJFQnlnWURvZ0pRY2ZhSUZtVDZEQTBxK1NCckY1UC9FSkZON1BQWGdr?=
 =?utf-8?B?VW15RlptTU8vcFE5RlVNZk1VYlNYeElMQ0p4RXpTQlRyVEdsMzc0VlMra3Rv?=
 =?utf-8?B?djc2Y3BKUzQ1bTliUzNJYmtDRXl6NWphNXRRdjFIUzBYN3ovN1B1WCtNL1lm?=
 =?utf-8?B?b3o4N21PdHJYZWJyb1UyZlEzRWVrRzVYWDlhVWkraVFGSnRuMTRRZ1ZLWTNW?=
 =?utf-8?B?UXpSZDA2d0d1Vm14UE1xQzFrYWlIdWZLWDl3MzVIaHFWKzRzaE5rc1U3MDBX?=
 =?utf-8?B?Y3diYWx1S3JpNmNiaW5tNlBBdXBNdjc4YXNlVzRGcC9sUG9TakRRZlVKUGU1?=
 =?utf-8?B?YTY3SExISWFzQ0NoRWQ4TUx6akpybHUzNGtPTnRzOHhua0xXSXpZWFdmU25N?=
 =?utf-8?B?QisrS2FUOFl2eEhsSVBUbHRkMnJmYkZYQVNVSzdGdk1uelduejkyZ0g3MzFs?=
 =?utf-8?B?ZElwOWJrZjA0RmZQWWpLbkoyN2FEa2R2UU9FK2Yydk56RmlCMHR5b0w3R2lS?=
 =?utf-8?B?YnNIRXFoNFdidUVlcDFBbERTVnBjR3lIczZQR0QzVEIyUUtSUnQrQmM0MnRv?=
 =?utf-8?B?TmdPTXhwYWxMVXlmVjB4eW55Zm5Vc2hKUVQ3Z29vTFpRQXpQVnp5WVAvNGhE?=
 =?utf-8?B?NDZLK0x6cyt5MFZiaUtaSzZWb1dMaXdkNGdWQ1JUelZRYTN5ellWZWlsazdB?=
 =?utf-8?B?N1dWRGxaajV5N09XM0YvemhsZnBpeFVaYyt0M0p4T2NYNmh3QlFxT2gzWUtD?=
 =?utf-8?B?dGEvbkRxU1lvZ1YrZWZxc1ZoTWRPaS9zZm4zWEQ0SE5NNU5QSjdHRzl0dElB?=
 =?utf-8?B?NCtxbkxnZU4zdDB5TlMrdFNUUFdMMUVIc0tON2IwSFR3TGVqeFpDQmoxMHBo?=
 =?utf-8?B?RmV6d0hjclJ1OUw5dS9saVA2V1U4QllzNXBSWHA0OGlHYzBOYXAvQStQV1I3?=
 =?utf-8?B?YmRNWWZ4bVFMNkNaYlluYWhtMENkbC8rQmhBWjl2eUdUMDAzdjU3TXBmNjBo?=
 =?utf-8?B?Y1pnOGU5ZXExRE9XQXBjN1ZZTGNZZTJ2S3ZxcFFpVHhJeHgwNnRzTmJrcDVt?=
 =?utf-8?B?bHpZRXFaTGgrY0psaE1FL2g3dlYyRzlYbER2emh2enFoVysyTDRrc2ZRbTds?=
 =?utf-8?B?Q2Nxb25CSnJTWEF0ekxSeUxYcGJIWlpQS01rN3dMRWxYVnhzcWgxUWphUnI2?=
 =?utf-8?B?aHJDY0VPandMMXJTZzdkdjdXVXlucVgrR25namdWSXo5d0N4RzhOR3U3aW5G?=
 =?utf-8?B?MDAyNS9EWXAxalpQazRmS1lnUy8rZnZPNDc4bStOQWV6ay8wWkg2NE1kY25W?=
 =?utf-8?B?V3IxdmRIZ1BjYnFCdnNFR3NVdVNoVHMxajBFWnpqSWpRVlkrVGIwWHVOcnI4?=
 =?utf-8?B?QTc1Wk5MZ0djRG8wTE9mckRQaHdFV3J5MkwzSDd5Mm9KSkVmOGtKNjNQQkpG?=
 =?utf-8?B?L2x2VU4zeEpxQkVoSDVORmQ5bzBtdHJMeis2dHo4SEMxTnZpOWEyaTRKcHg2?=
 =?utf-8?Q?ZpgetZyxcFQjlLTLbeZcY+o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae97f5e2-8a59-4c20-ddba-08d9b4fb0af8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 18:47:36.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrwTM7v/y/INZg7uU89/kGKm0if7dYyDtjwHpIKe4Qos8towsCxeHnC8tAcLq9QmTI9X1JvD+vzUV1rb4tIPWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4575
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010100
X-Proofpoint-ORIG-GUID: yBqNCUn70d1ytur_HgsHMsHZc5g2750F
X-Proofpoint-GUID: yBqNCUn70d1ytur_HgsHMsHZc5g2750F
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/1/21 6:51 AM, Bruce Fields wrote:
> Do you have a public git tree with your latest patches?

No, I don't but I can push it to Chuck's public tree. I need to prepare the patch.

-Dai

>
> --b.
