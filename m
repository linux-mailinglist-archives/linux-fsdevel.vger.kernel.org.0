Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE02E458830
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 04:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbhKVDHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 22:07:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10216 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhKVDHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:07:48 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AM1Cuh2021623;
        Mon, 22 Nov 2021 03:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5ZaYSOQyJfJMLwGUqlfVXUtIzd1UPtccEc8GtAKblhQ=;
 b=cVzLtWjoJ/Dypvo+5p/u4Ae8zvnmigyX0DjKpKKfZculivvU7t0W9a7CWVhtemAK3z8P
 VpqghQz80EIlJ+/ZLyYH/V7ALZXCiN/j40LDStAAloeuIlglJQ4Uq1FO5z3H78qi8F8J
 SWFX16lyER+nXaaiw2psBKwXmHZSw4FKY0ef6GJx4lo9n8zJ/OkSDrwrv7eY9NaqXmgR
 34sW83imii4Pmqcbo7ROAUH4wEPncsA5g+kLfkJ2lWJHcUxTLf4lLpYbNiYZPCp8uZnH
 nJQlo0/sTPV2WlzxkaPI6iJHGVYXct4x6cMGEqcahikgw687zDuMW8aYAiYxijxRAaE3 Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ceqm1whfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 03:04:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AM2tKxl101027;
        Mon, 22 Nov 2021 03:04:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3020.oracle.com with ESMTP id 3cfasq0a2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 03:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXji/CsZ9AILe03bEVV4q16BtBcB4nM6RPtfbwRkJ4DRR+UMVQ/BhSycuR7dc8uVLcLovy+F2jkaSNiSatN820pyOAEy4af3iQCLHIfHcXHbD2+rM2bDDxjq1AVKFSlH4yqaHurPHvc6JtSJXBXtjN7pi3QFZHWxtcVRUw74YCD4wnFkRwnBI6dMZuDiQ/A2JE8Zy6+J1gYsHlXvFnBMpl/dadLqQpOJh/XZd8M+cvtBZjhjXaVlBRAlehV9UzyfUvXjA5+Z0INZgwmeHZdpIebSgDDrhoFYTeYeM+neYzE+SXt5qXJyoLOKC5wlDSTLsQlm8PLR0UfRL0LL1lDQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZaYSOQyJfJMLwGUqlfVXUtIzd1UPtccEc8GtAKblhQ=;
 b=R6UN78yd1xE9My/R6gRjpOs8A6GbZkXaqg5Fn+mlzQiLhPnAHVpdk3QEzV93jrC/feDDhvPCH9dNHefCkO6XOZyyP252vsK9X5RKhbYzkpHxxo6A3Dy09NLhLIIIsyTYG9VtES1tT2RmuDjEbrtXWF6fAZ80frMpmbb+I0YPN9btPpfI9yAB39j0iVnSTwANnmefBMB8RaV90gvfzj1FxDKt+Y4IQ0cUwPWuC6QRm5zCxTbqgVFgZpD2RVmrUUZcdxVdv+ddLCxhS10DsPqwwyTxMtPoJUUS9ls9KLm57bLL/tULDFN7cfq18TlApv7msRZuTuWgsmMwLsH6Yd/pfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZaYSOQyJfJMLwGUqlfVXUtIzd1UPtccEc8GtAKblhQ=;
 b=u/5rh546eaLv3I4X9gVI6QhjmRSljkT0/Sdo4jVE4czaDQhbZ+ZLlkcCfAq6RK7wJY19z3adRIuLCbeGGDjvwRvbcp2pRUpo3l4G/4xJMu63839pZmQSRdD2DeRtZO6N3XEYF4j1DkP6CmMgko0trLaOzHsMDthVGdE90KE0iHI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2566.namprd10.prod.outlook.com (2603:10b6:a02:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 03:04:35 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Mon, 22 Nov 2021
 03:04:35 +0000
Message-ID: <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
Date:   Sun, 21 Nov 2021 19:04:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211118003454.GA29787@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0018.namprd05.prod.outlook.com
 (2603:10b6:803:40::31) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.159.150.234] (138.3.200.42) by SN4PR0501CA0018.namprd05.prod.outlook.com (2603:10b6:803:40::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 03:04:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fdf32f0-f8ba-458c-ea39-08d9ad64d05c
X-MS-TrafficTypeDiagnostic: BYAPR10MB2566:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2566C60DCAB0795CFCED907E879F9@BYAPR10MB2566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ovb/xiqpo0hdUB4P7eGHKZzrAAsFnn5GHWF9S7U5CVlHoRJZ8GhP5g72qlpohjoUpguR03Dba989LApgiLMGxKvOpduHRlnDt0xOo4JKd7rsGw4Dyg59ehgNNOhbou5eEnKudwZWc7QU5kvz8vh0NuHr1hsHRsxXdVaF4g5suT9GPBO9TEG9AahufV9BtlaPkYzj+CoKfhYxyjBo9YKzwrXKzVaij137yTxmx3MIzMgFXlzSB0oIeTxF59lM5kI+Y2cVJ7Lvf7EXgF9qv90JfuHcXPP5U+/re8qIPNwbhrmctjwpB2v1ypF5DuRpjQsC9rx14DoyaQw7mirSWLI7aSTs6Hn2OlW/R3Hag6XreoFihQq/v3fxAfM8Q4n5h8/56IW6fP2L4BzkiQ8FPHWOYh0N6MMsZ0htLjizmUTy4wI4JJaVTj4EYJDB2YXF+nB643DcaPF+BAKFt6d1xkFdilWzNTh7HnpoaZbgVd+Ko0XYeWukqiyuhTAxkWcxEpn43P42C/xBl46GH4zQTXR1IgTonXNgrfk1hPqS4hK3PeTBYAj6RlSBdQJETw/F5K4atod7BkXWGgOd+r/GHuzjWibUPjhxj3yHBY4SJ7CyxIYttVvJTdiWjEnC5ajUfEnnZvsScXWbwwBeSibcev7NosCR1wZr4Vgzq2jG686ZhenZ5ecYxVUGOEImTVGCJy91yAuYTtV5NTKfVhVe7wV4Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(16576012)(8936002)(9686003)(2616005)(26005)(53546011)(316002)(956004)(5660300002)(38100700002)(6916009)(66476007)(31686004)(2906002)(508600001)(36756003)(4326008)(66556008)(6486002)(66946007)(86362001)(186003)(8676002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vjhyb3JyTC8zZUFWbytWZTg4cWs0cWRYVHl4M0FPdUVXV3k0VE1JamN3RGJK?=
 =?utf-8?B?RVVSaWxyaWJROHg5NDlmRHRnQ1E0WnF3SjNIUDZKNUkzNDdoZExTdXZTZGY5?=
 =?utf-8?B?Rlo1MlpORHJWelkrall6V0hIOUxIdVgvU21IWlg4MDl0QzU0TFU1WTd0MUFw?=
 =?utf-8?B?akIxY29CbXdBdCtVZjNhL2NKS1g0a2NpWDRlcHg2Y0tYdHI1R1A4ZnZVTUJV?=
 =?utf-8?B?akU3Ym5OazBVUzNKUXN6K0VpRjZBYUdLMTZ1d0dXcXhLVmE4S1dlK0syNlNN?=
 =?utf-8?B?bnAvaHRZeXNzVjJkY1JXdXIxOE5iSWVFMDAzZFl3OEJwWTVsaW5KZTNSMlN1?=
 =?utf-8?B?aGJXNC80eGJPVGlJKy9YaWl5MjJrZ0NtQ1FkcjFuRURtOUlhYk9UN2ZaSTFU?=
 =?utf-8?B?aUxMTlpMZStLbkpqR0hTc05WalZrUS9ra21ENDRTb3VLQW5zdzFQZktNSWlU?=
 =?utf-8?B?bTFvU2hERnhKQ2gxeUtGWWgyZGxVaVJ1YVlqUWlTOHExTllnNVFpOWNvTEZs?=
 =?utf-8?B?S1Fra0dHNjJrbytJTHFpaVlkRDNHN0VDZ0NaRHErSHFhN1MxVGpxMGZjOUlv?=
 =?utf-8?B?TzVBbG8yUyt3eE9aM2pHTSsrZHJSNnA5WmZmQTNCS2hxKzBLUWwyY2RIWHFG?=
 =?utf-8?B?blArS05nRjNwQ2UrWGVRdTBmTmkyMlN3Z2toQVA3STdjNHhnd3BWU3NRSmRz?=
 =?utf-8?B?OGVjcU5tUTlLMCs4Q3Z5MUVFcldCcnRTbE45TVRiaTVWekRDMkJTNGpVdWRT?=
 =?utf-8?B?VmFiWktNU0V2c1E3MjdJdlU2bndmUHhCblVESWFOTVZmVVFXYm53d0IzaWpC?=
 =?utf-8?B?azgxRVVCcWs0U1k1Z2hFU0M2c3lYRjlhbUdQWnlJcFhrQWRweU1iSm5MZFZa?=
 =?utf-8?B?VHpkOElNWTN6Y29QUFNFSlFnQXpaZG0yRW10NWk2bENCcFJxUXpIcEFYK243?=
 =?utf-8?B?MUJ1QjMzNlRDR0diWFlCcDl2Tlo3MDVWcTNvM3VoZ1FjK0ZyV1BvejRoNEc5?=
 =?utf-8?B?U1ZPSzhkSHdyTy8wUnZzSGFMWUZlSWlOZjZFb0ZmOWtGcEZQK0E5MHRlQ3Zi?=
 =?utf-8?B?dlZ0b3pqdmwwTFhhaERNcUZZMEVCd045bVdpREN3Q1NhZzJTYy92Z2x4WXpv?=
 =?utf-8?B?K253eWsrUVJjYVJ5YW9BVEFUSjBDT2FSVXp0dFFWNGpLZFVhNGRFVmJWdUhy?=
 =?utf-8?B?Mm9jMWR1MGZtWFliTGpMbWdJNFpCOFN3TjRhYXN2WEZXWGQ0NTFxMEpCQlV3?=
 =?utf-8?B?aUdGRDR3UlgvVFVWS2lXWjF2WkU1M3dQNmViT0VkbStycjZlM0lqVTFiUjdL?=
 =?utf-8?B?ZmEwTkNWNzg5Sktoci9qS2ZMZ2ZTaVk4YnZvYVJ2THVXUzlERTRZRE92Ni9i?=
 =?utf-8?B?eUxCb05TN3RobVBGa2EvRVlWMkJLREVCZXJRODY1OS9DY01NTGo2M3BZMmlR?=
 =?utf-8?B?dlI2L28vS1RzMmhIY2dqbnFNUTdBeHIyUWloU0FiVjdmNlY5Q0F6TWxScStX?=
 =?utf-8?B?Q2pJRnRTNHd1ZXowMFNsd0lQL05GV1FHQmdqenJFcVdnS2QzUmc4ZUJjbUpV?=
 =?utf-8?B?Y09aMWxTQ1g4cnhXRkpzNGFNYU1odW5PWElQT1lKSUZMa1hCTnhJU002b2Mr?=
 =?utf-8?B?ZWE5VitNS0ZuVWhSdnpJTVM4QWVtZGFBMk1IVGdmdE1UOGpyc3hQNXJKS2Yy?=
 =?utf-8?B?eDkwTzY0b25iRDVpS0RiWGFFWkZ6c1NxRFM3RXp6Q1R6c0FwVDdsU2N3V0o0?=
 =?utf-8?B?dmhrRXEyOU5Vd2V2ajA5VlNvYmR5VnVmSEl6YndHTDRadFowNzU2ZFlQQzND?=
 =?utf-8?B?UVFYNXhzWkZITEx0bno0RTB0TVV0TjdhVlpPZ2JrR3k5Vlh6NjVwd3Fibmpy?=
 =?utf-8?B?NXpVQWtUU0JmWWZlaWN3Skk5ZVU3b1lzZkFaV2l1TXFYaUZFOVRyZ3JadlFK?=
 =?utf-8?B?c1VkNklDTHFBS0RKaWt4aXgvczNvQ3E4T3hoK2djOWxUV0d3SHl1aVlHdXlj?=
 =?utf-8?B?UVdYSTlmQ3VZQWhITWZ2TmdxWjdlaHdHY2xhcVdIeXVIM2Zpa0tJZXBMNkk0?=
 =?utf-8?B?ZTdWUldZemQyS3NzeFd1dWFBNkZvc09ldEloYkhqV1UwSEI3bGlqNTVWMWEz?=
 =?utf-8?B?ZzNXNlRadktLQVRKS0ZIZ2RmL1ZqSVdUQUQyZFRnY3lZM3hDcWtTT2RIcEpk?=
 =?utf-8?Q?CXdy9Ec2vk4KpEQQ5tP3+40=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdf32f0-f8ba-458c-ea39-08d9ad64d05c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 03:04:35.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFEmfaHYtecZxAp86OfJtNPvFbmkpRgVRo//rQvZ5lilBF0kFN86DF82HZNfUHrIumbpAc8Q/2ey2Wsk7SkYDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2566
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220015
X-Proofpoint-GUID: rHDQawj6xfYqb4gZn8EIpFpy5ov4lBBD
X-Proofpoint-ORIG-GUID: rHDQawj6xfYqb4gZn8EIpFpy5ov4lBBD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/17/21 4:34 PM, J. Bruce Fields wrote:
> On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
>> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
>>>>> Just a reminder that this patch is still waiting for your review.
>>>> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
>>>> failure for me....
>>> Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
>>> all OPEN tests together with 5.15-rc7 to see if the problem you've
>>> seen still there.
>> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
>> 5.15-rc7 server.
>>
>> Nfs4.1 results are the same for both courteous and non-courteous server:
>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
>> Results of nfs4.0 with non-courteous server:
>>> Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>> test failed: LOCK24
>>
>> Results of nfs4.0 with courteous server:
>>> Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
>> tests failed: LOCK24, OPEN18, OPEN30
>>
>> OPEN18 and OPEN30 test pass if each is run by itself.
> Could well be a bug in the tests, I don't know.

The reason OPEN18 failed was because the test timed out waiting for
the reply of an OPEN call. The RPC connection used for the test was
configured with 15 secs timeout. Note that OPEN18 only fails when
the tests were run with 'all' option, this test passes if it's run
by itself.

With courteous server, by the time OPEN18 runs, there are about 1026
courtesy 4.0 clients on the server and all of these clients have opened
the same file X with WRITE access. These clients were created by the
previous tests. After each test completed, since 4.0 does not have
session, the client states are not cleaned up immediately on the
server and are allowed to become courtesy clients.

When OPEN18 runs (about 20 minutes after the 1st test started), it
sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
server to check for conflicts with courtesy clients. The loop that
checks 1026 courtesy clients for share/access conflict took less
than 1 sec. But it took about 55 secs, on my VM, for the server
to expire all 1026 courtesy clients.

I modified pynfs to configure the 4.0 RPC connection with 60 seconds
timeout and OPEN18 now consistently passed. The 4.0 test results are
now the same for courteous and non-courteous server:

8 Skipped, 1 Failed, 0 Warned, 577 Passed

Note that 4.1 tests do not suffer this timeout problem because the
4.1 clients and sessions are destroyed after each test completes.


-Dai

>> I will look into this problem.
> Thanks!
>
> --b.
