Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2C4600C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 18:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351809AbhK0R4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 12:56:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17342 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355814AbhK0RyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 12:54:05 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ARDCFN0021658;
        Sat, 27 Nov 2021 17:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+qy99pGNA+NZMMU+K+FxABUXgBXc07xmmqoRikcUKqk=;
 b=EI/TGsijwF9hcyxnz/hTbtt48n7gBXE3ldctl6EWz04j05CqJcVxsE95oRCFdKKaifDr
 jwp31FV5e8Y6MLeEMzMqwAAOvY+4LMP6CLGaPUJ06B+m1D0Ecpbq34ywOH32b+a9bI6Z
 anXDVqaXyOcIs1Y5PV6Bc5aIUxFabQ46CYBBu4uKfxDcLXcgOkpDD6BHw3ryAJpxyEKJ
 9G7BpMlEDqTAZHjB2p+t0TBd4FHX5CV6lEejwnDuyYVFSb8i2b8RrKQCh/CHGbE21iy8
 JTq319t8SPxwSoOYjTJ9fZXqoC0MxFfhuVpY8bu97AtzdcqGGHZwYaphUj8lkuXBboIq lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ckb3d1bhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Nov 2021 17:50:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ARHjSqk143259;
        Sat, 27 Nov 2021 17:50:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 3ckaqaq05x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Nov 2021 17:50:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOhd3IBFmBfr/GiIc7j/nKnAR7QHx/Jz88XJm6sZ6mOtiWCSNnc9Tm0ZF4WaDnmrJD8sD87Qp+1O6fzoP6hINKSGk4nNiMiwI+GWsWlchm4qEhmRkCJune9UlTL7LYCC99AjX5f5e6cc9AjYUtxB4FkvL+kzfNbxNBhRpND/xnFoz4JkwJNqa6q+3FCogvby+DpJtNEpMP9Ff64WgMq+PN6Y53NGEgLn3dvXsW8UsDEtUL1jwqrj6ooWy6xeEdKfjcDxuNQjAcIRp59GJk9KwcTSukIpXed6s+6eAEkIMupmetl37rYbch+a9Ho747BLT+ZK+0vRhEIjiDray1mlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qy99pGNA+NZMMU+K+FxABUXgBXc07xmmqoRikcUKqk=;
 b=D/CpJkUcbgwVYcs4zFPZrbr0r3zuT+X3xSbkor4yhX6U++m21dRaIBzTrHjp9MvxoJzQHH6UUJAW6pM/u5GSkWC53GzabIwpNpXO0xLAkLb4+hTHuqlTujrqgsLD4eaXJSSTiarDsBqWdRN/kqOIG5axf/TUIYOEJRSB15eHvB9iCydz0MB17vMJQqPyYMJWo1CEPw5lFULLGBfqzK8x3GHNX6rUnir+3CFZfvxaDcaoyxRO83kOiEybjZz5gR8Gt/ZoMdLkQhrezr3iSqAr52BtfFbPqfkczIOO0fuKCwJlPuZNeAxk7WJCm4DXN3PuwP/0jz7vne/P0eZMPMrkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qy99pGNA+NZMMU+K+FxABUXgBXc07xmmqoRikcUKqk=;
 b=fZYvT0kogdSKLuYL139xWWr9rbtevMHe8JFgAoCVlQis7P0/mKCFv6zxXx20jCZSaWu8r/YWmv6LYW01kDFZ03kgLi3A2kh8hhXOYPGRq8eiRUv4j1rxha/+MLRNgu166vgePfJpbrw4u+m8ypjMeJq+CGnteoUieF7gZxcmZ8k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2855.namprd10.prod.outlook.com (2603:10b6:a03:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 27 Nov
 2021 17:50:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Sat, 27 Nov 2021
 17:50:16 +0000
Message-ID: <6f9c9501-bf99-5eda-7486-5bf33ef627c2@oracle.com>
Date:   Sat, 27 Nov 2021 09:50:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] hugetlbfs: avoid overflow in hugetlbfs_fallocate
Content-Language: en-US
To:     yangerkun <yangerkun@huawei.com>, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        yukuai3@huawei.com
References: <20211124062452.2343575-1-yangerkun@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211124062452.2343575-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:303:8f::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0009.namprd03.prod.outlook.com (2603:10b6:303:8f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Sat, 27 Nov 2021 17:50:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbbceafb-dc47-4060-ca0f-08d9b1ce5ead
X-MS-TrafficTypeDiagnostic: BYAPR10MB2855:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2855EE4EC003ECF4A49671E0E2649@BYAPR10MB2855.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+g0lQ7/gPlEpkn55kPjqGUNkCjp2PD4ihT521pUjNo9dIsp5c+SBqiWpPkqi8ajVWBX5fPdlFACancaHTnXkhg3MmJVnClT2TMrIJ2d3ogLsiBMBOUr9xDqGyhvvmrK3r5HjNYmq7QvQaLNCA88Kfm/bmXSEZHYs1DWjRNbQOUDKXbO4C1LSwRrkh0eFRmGAoxGN5PRVaXsMt/XHNyUd7pKr4gwCHl+46OpDXpohO8YG2NjKXPCtRi0anHE/3Qi0RaVERCzJmomYbPPlJAVlZwgpYVUQTOF6Qi55LqfG12RzhcG4EDLANGCw0V67YnalUTsDNJVV/ko30bW+VrdOb8ErdvTku4Di3pHzXxwqTV48t0UnumysfI19bPh3Qr+nuOgE77B2G4UaGVdUt+xHE/622uEGthApJDYU49hco0oakY8yxVB6Tr+/C/XWE+zFBPvOz6RCqtICIh0zOChtQK6orHEm0vqMajL7tj1TzeBNXmIk+NxoDjwb8YL+Ba+1kywlgy5KU4tDVYbYGbrsXeUV2ZSaQOD0XzANFwpCzd0KVt5HZiUw+zFUGOIKQTzMmPhRyz9Ddr+lSuMU/AIckAifkMnocKJ1XVTaMxUUUGPb+NA4UOj5LAuG3l6cuMe+vS3EHlFiM2D7YG5CSr8BqVxjGUJHSw/FuHniL9xAu7WZf/G28fZ9W3TRZ3+q4cMpyNyRsFLv9jj2yAtPwGxPNjAPH1uXOhoNd7doF9GXNQtAs9o+bVTQwAbyqKXjc/UZUy8kpp2JuU/xlt+TJYQvbVfkMsK5IxwDe8zwTeHm/nuzSF4SamkR1Pia6qQEhWM5v3ExO9pdPf5lIdq/sl1JWws9/RaZs1it6DjR8r2hOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(8676002)(86362001)(36756003)(6486002)(44832011)(52116002)(66476007)(31686004)(66556008)(966005)(5660300002)(83380400001)(31696002)(4326008)(8936002)(2616005)(956004)(508600001)(53546011)(16576012)(316002)(186003)(4744005)(26005)(38350700002)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJyVVJNUlBWTnQrMGlUSloyWWl0aHBRZ3ptZUNENm1iSWYxOFJqVWtGYysw?=
 =?utf-8?B?S0hCZzN2UzNydU1NMmdTZEVlek9jd0Vvd1lkTjlJWUt2VE90czBITGVERmQx?=
 =?utf-8?B?alB5RlNpVTMxYkRkZDdBRUUzQkFMR2hkRll6aXF3TUdCWS8vOEJDNDBnSXZS?=
 =?utf-8?B?ZUpYMHpwZ3c3d0xMcmtHS0xzekRqeFJVQ0JuR1gvcDNlbjZqeDV2endkMXln?=
 =?utf-8?B?S3g0NHVEemZBRVRUTlphWEhSYk54OFplWlViZ1JRTnlMVjZDcHgwU0poSmg3?=
 =?utf-8?B?U3pINHZBODBqcDBhZTR1Mm1vYmdkb0JmWkNGWmptdWg5bW5qcC85MDg4N1kz?=
 =?utf-8?B?ZjJwL2F3d0F4eVU4VDdoQSt3Tkw5bXFFNFRNZ2Uwc2FPQUxHcnVtUjVRajQ0?=
 =?utf-8?B?aDFtZHIzdFRBT3FDMUlSSWNiZVVtdVlKNFVkWmxhVG5uZGc3bnNDaDlmS0JF?=
 =?utf-8?B?b3VLdkpDQkdFMzd1bVEzaCtOay96bk9ndGJzMmtFZm0yZm15S3ZGb1IzUzVj?=
 =?utf-8?B?MU1OTXEzRjJZWFdWbkFZUlFFSXJYNUJZTkh4eGRZdlhaSWRBSVdMb243cXE5?=
 =?utf-8?B?eWJBWjFPYmlRdlBZSWgxREUzcCtFZ05KTExaQUxYVUNzak0xM3phVkhjdVZX?=
 =?utf-8?B?QzdNMmY5aEpsS0JPU2VaSlEvQTF3Z2ZjYjJhRlk1S2dJRGhBZi94TW5qUVA0?=
 =?utf-8?B?RzJiMGFmdForTDd0QW43QXNJSzUvVzdCSXk5dGVqUjg4MkV1Zk1FSGNSN1ZL?=
 =?utf-8?B?MTloQ294YVdzakRkdDBxb2J5OHY2cW1ZRForMnhwWitLUGp1TGhEZ2dqNTBB?=
 =?utf-8?B?c2xVNC9TOC9xcnF4Q211RVU0MU9rMnp2aWM5ZzhQQld2NkJyQi91d3Erei9U?=
 =?utf-8?B?aVl5SjhOdjF3K0NvYmpGM2tDblVkSndXUVNIOW4ydDdRVVdYeFpXTEFldTJH?=
 =?utf-8?B?cER0VXpiaTFKRWxqMTNkZmhoSjFxMzU1WmtvTFdWWHRseENLS2NCS2lQU0Ey?=
 =?utf-8?B?SG4xMm5iUXh4MUdqb1M5bEdheE5DbDlvVGRxL3BqNmVRTk9TZWtaeHpQbmlo?=
 =?utf-8?B?UjB1YUhHTGhoV0VuVm5waGhOdnZ1NGlIajNxNXpFbHZwRnJ1NTh4NnNNKzZT?=
 =?utf-8?B?N3JXMVF1THlmK3JIV0Vtb1dYbW1jaHRSenRIWnRlWkg3cjltQjVvaXZjTVky?=
 =?utf-8?B?YjI4bmtJSkd6T1p4SzgrM2hWYnlpOHlHdDRNOW5ONXRMa3hKUlFrcm5ETXFp?=
 =?utf-8?B?V24wcThvR1BYTlRlc1U3cUtNYVRsQVVLeGpCckh3bnpxNEhQTWFaSFN1c2M4?=
 =?utf-8?B?RzJ0MDZyRVdRMjdscElTYWZTUUt1aVlLMG80Z2FMR3pZMDVOTkhJUzRKc2pH?=
 =?utf-8?B?WXg2eUYwR2IraG80UTJSS0trc2JnSDF6N0hhQzZubHAyUHdHM0taN1NLYS9s?=
 =?utf-8?B?bDFNNFY3TUtzVW5SQnIvSklLTXNXMjYzNlZBd0RNUG1RTWREVjBGbm5IMWtJ?=
 =?utf-8?B?andnWFpZcXFjdFRGLzdLaG1VaUFiNG1HMzJGY01WeGpEbDAwYzBPbHB5TTVG?=
 =?utf-8?B?RlF0UEh3ZHBQc1B6cE9YemdpNkdKaGhiZGVEMHdwVW1pK2NDOUlYSDluN3FM?=
 =?utf-8?B?OXRCNnFiZnNrWUkzVXRyQTJiWDZ6YUNyTWJDZ1V2bDY0TnNOVDVjeVJCT1VC?=
 =?utf-8?B?L0IwMThBNno2RnJLWC94cnp5cjB2d0NlLzJJZHZzbGxwRlJoNkd2MGJCVXJX?=
 =?utf-8?B?MGdmNm9Ua3g2V0NqQXg0bG9SYWEzcHRKb3o3ZTYvMlhGZDhndllTREphVFhx?=
 =?utf-8?B?cEhlRDRRNkNtNkMwbmJWVXNxNU1rZ3ZRMEF6UXkyQzlnRFJDN1g4U08zTlRU?=
 =?utf-8?B?Tit1UitoNXZCSG9hd0dsZVFjeEl0d3p4b0h1SWhqVDkrR1FRSkdBUGFGcXRK?=
 =?utf-8?B?eWxWdlUxd3RnNHpDQnJQek15MjR2ZGFEeURTdzlSWHR3eFBkTWVlbTlqajRV?=
 =?utf-8?B?eUh2NjF5bXM4Zk14UEVyU3dCQkhuUzVRelJVVGVabFc0YThkYXFxV0NRRTli?=
 =?utf-8?B?WDJpMXBHT2VubHl3UkU4cmkyeGlLR0RtTCs5ajFLTDhFVG5PcGVidGpIMlVi?=
 =?utf-8?B?aE96UjhzMTQxTHYvVnpqQkd2Sy90V1I1L2tBZ1pCVjZiNDFkTUxQTlJHaDFE?=
 =?utf-8?Q?0ODlDkfaEZXwx48/TGm/upU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbceafb-dc47-4060-ca0f-08d9b1ce5ead
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2021 17:50:16.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3SEd/r9WZ1+fKtvEKVpttNdTJjOtoMinGJlCcsyqaxVI/4jmQrxBmRKcfR/bGwKOaThMdIccImbgMBv5nsP5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2855
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10181 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111270106
X-Proofpoint-GUID: RqmP1KW6G5mjY3RgQTafePSnzy65ZD3m
X-Proofpoint-ORIG-GUID: RqmP1KW6G5mjY3RgQTafePSnzy65ZD3m
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/23/21 22:24, yangerkun wrote:
> luojiajun report a problem[1] two years ago which seems still exists in
> mainline. vfs_fallocate can avoid 'offset + len' trigger overflow, but
> 'offset + len + hpage_size - 1' may overflow too and will lead to a
> wrong 'end'. luojiajun give a solution which can fix the wrong 'end'
> but leave the overflow still happened. Fix it with DIV_ROUND_UP_ULL.
> 
> [1] https://patchwork.kernel.org/project/linux-mm/patch/1554775226-67213-1-git-send-email-luojiajun3@huawei.com/
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you for fixing!

Matthew, thanks for DIV_ROUND_UP_ULL!  I did not know that existed.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
