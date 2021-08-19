Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192D63F21E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbhHSUvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 16:51:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33998 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235105AbhHSUvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:51:43 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JKej4c024089;
        Thu, 19 Aug 2021 20:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jBCUJslOHmjIyuPELG/3BsrZTSs4N+0cj7FQFMvHOXI=;
 b=WbfXnReNcVT8yP7hx7DzT7rARV6xH3K5h9wg42UcdP/qyzwT9/voXxlMdJBgIf/yTHa/
 t2XCRzvRQ4Lo243HbYToyFEhYHJxJ6tGkR6Like2wlXQHQb3XUqlRxiQjJOOq2Yn1c0Z
 Gb2Xa7mQLU3AwS/2Dt/reAN7QacNBkqH2nnWALzyGmvNw50HWcUR0Qq7+C8y8vCqEyy7
 MGwo8UxWDYo1qdjTQbXEg17cyI5bUVhXyRKXLWh9IinO5QotzHHiT02yorO5dHNR14Ra
 2PPJVlQtbMxmVFxf+6iHGL7RaEQgo88lJZxmAMzZEWj/FSXU2fyosUbrO0VSnkdu4HXj hA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jBCUJslOHmjIyuPELG/3BsrZTSs4N+0cj7FQFMvHOXI=;
 b=rdXTwhbJYPlJbUKr2HhOdnpnME++1xSCe0pHeLVrpqR8upxsV20P8dSktpGMqfS9Wg0P
 2CdGsZkGixqKz/+ws9eJT6xq35FK4SmaGrx8BRHDHoSUdAlc3ISx4prvTF//vazuUA7A
 COUWfrH93uZ9dL0qEzVR6tJPSPRDYOa7sX8kFPLCFdR6uz5MqFTnlW+5m1cd9T3yelHG
 YPTedzF51++cCcr5aSpP3dKrprpZPh6GhtXny2N7+kfVrMFGRXP3blRjXNa2pPeVo++U
 mwW16uz5k6fGzhxlZBYXRUIcJ4nN+W+JH3RFoN5RqWnSGYTEOkzt1pA25PyS2umDeH7Z yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahsxd0qy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 20:50:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JKfBAM106160;
        Thu, 19 Aug 2021 20:50:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by userp3030.oracle.com with ESMTP id 3ae2y55p1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 20:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2PY+qok7kO17jzwEEoVxaf9D4cMgO6a7jY1rTMH358IkcbSsihara7KMJsIOjphOr1bwqIrJF2euOxINhCzhQYWZw9ykTEw4FnvTuSlmVu6N4iYG8WBzm92vC9EukRZwZq1ATI6DmyOFoTWkuADE31Ryf2AESYuEmYA7Sb1o/7UYq1mMXRr1ETcBalUh7W1GEUQ9OZ0JjzacWgj+ACWtc/H8PIKKOH9IdpCRXV+p9TKTwW9r3aY7M4CW0TL1I5pqBqi7HfHxF7sSdRitXZbuN8HTzBJFWRDoAOOTnQeGR/9DPnEz3iZR0u0fPXBCh0pbaKJP1EskXTm7+4Vqfxrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBCUJslOHmjIyuPELG/3BsrZTSs4N+0cj7FQFMvHOXI=;
 b=ZMDKKgpw2ridOmtJuMW6SWzcGMRrR/egGLNkJlMI5XoXUe5xPeeGyNBd2ssgwp2Dx693NG5W3LmCWhg43W1LkWjWhqqRXm8O5mrC/Ge9xpDvykZxOWN1J4QwW8EY8rwLt1/jXMS/PuhIwbceCNVkTZq48wHQ0OKOW/28XF+FMoQit6zD1H6cv6rul7fYMEoV2+nCHrVi0i/c4WD6uS/n74Thd/QG50YUNvmvUmLeIJn1g0NIuMhe2duT/HU9p3LofjQj7txTCAj8StKOaPKPdC4aACiBbV4QlabShYDHeTCBM8PP54uX3Peel2dQSN5o3+pMEK44siplCP6G79Hz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBCUJslOHmjIyuPELG/3BsrZTSs4N+0cj7FQFMvHOXI=;
 b=DsN7VgqkYViDDXO8VT0SJ8P468R9wd6aKIMPo3EH4AMtr02Ba/HsFscFYfS1PJZMetv7uTbQToLtVTLsIyjg1zkiqEO2LM9HdzuuijKaYE5LbXDQsCWfgYVfv47KNDEpROfKthOSO2pDJlC49EjlMrMs+JUxVcU6RY2Iudzv41A=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4177.namprd10.prod.outlook.com (2603:10b6:a03:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 20:50:52 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::bc10:efd4:f1f4:31c7%6]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 20:50:52 +0000
Subject: Re: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Cc:     "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
 <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
 <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
 <beee643c-0fd9-b0f7-5330-0d64bde499d3@oracle.com>
 <78c22960-3f6d-8e5d-890a-72915236bedc@oracle.com>
 <d908b630-dbaf-fac5-527b-682ced045643@oracle.com>
 <ab9b42d8-2b81-9977-c60a-3f419e53f7bc@oracle.com>
 <OSBPR01MB29203E90FCF9711D8736C8D4F4C09@OSBPR01MB2920.jpnprd01.prod.outlook.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <0c11714b-06f8-8eba-e0b3-8bb1caa8ebf2@oracle.com>
Date:   Thu, 19 Aug 2021 13:50:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <OSBPR01MB29203E90FCF9711D8736C8D4F4C09@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::30) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.65.154.182] (138.3.200.54) by SJ0PR13CA0175.namprd13.prod.outlook.com (2603:10b6:a03:2c7::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8 via Frontend Transport; Thu, 19 Aug 2021 20:50:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12d90e6d-bc2e-4e07-d92d-08d963530853
X-MS-TrafficTypeDiagnostic: BY5PR10MB4177:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4177479B26542D242F9DD102F3C09@BY5PR10MB4177.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxx7LLHnsVwWj4hu28D+Pc2dH7uGszYH9JdMXES/bPoa4no2PxnGQfVwrSparQlWSBgyljlGalrSIKQHpHb1mz9ctwYkBkJ2e9xKE1UNUJCE1AWkBtwtvW+q8Z4Qkz4ZgEAIgySulVaGZ+GPRKN9qa907F96XOs0BRYY01YkI6yCMtI9TTfj+BRcj08+kSMNuHDzbj28SJcWcmilWQwSw3tusHADOuOaq5skm6SQdKnjYSw8mIQkC/KjfGL80GcP2LxpjRiWm6YDQP1R8GXTKfN4Eltq4iWBCFwCKKDvULMS0CvZtm8+6BWznqtfCKyoruJboFhVD00N5POhOmP9/dr7kn/ohN5pnz/MJYF6i+FfCpo9g6Udiaqfka5ShUrDOC/TU5Jx+zHHKrjC40Qgzz1JifBk3REw9lBddbjk9NTgO3E37E2pGu/4Jyfy16CeLcc9Kj6PSlViLt4bKLFFDOh+C9tnNf9BYpuqKrkAUVZQaluul94aUrFJWrB8zoZ1z0Zfy7GB2xp4KbWQ/vQHdw+75cMUsFUhl4H1Ms3GgwNsJeUe/xKTeooLXT9OIgvkpss+9P1tz9bIRuuAIxxzRUeXq8qjmuw9MngcPSdiEWMJi6Eoxzjuv+AvhzMbvLEBG9iqObkhniu6S4YicGPZSlWwBEoh2SirsqR3VCjTnpsNa39bjGMIsyZFyv/H3FxxG3ZhAGwzr/nHbb+KPeMq30lh6yAhK+qIcohesNhhfBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(376002)(346002)(86362001)(8936002)(31696002)(478600001)(44832011)(38100700002)(110136005)(316002)(956004)(36756003)(8676002)(4326008)(31686004)(54906003)(66556008)(2906002)(66946007)(5660300002)(7416002)(26005)(66476007)(53546011)(2616005)(36916002)(83380400001)(186003)(16576012)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDAvQ25OYlJvNW1Pc01tSEk2TUp1QWkrUFZnZXczSWxReDlKcGFqYVNuaXcx?=
 =?utf-8?B?U203aDJZNENrK1JCSHhFWTl2a2lPN2dFd3dWUjhGMUNMMVJ0WWFkOXE4ZTNT?=
 =?utf-8?B?bmt0VTRtRnJ4YXNweG5qZmR1Q2pKN0VaK21DbytiYmRBdVAzUDJmeWcyOWVM?=
 =?utf-8?B?dW9PQjBSRGQwTXI2RHJqWGFwUzA4SEtib3lqYXZPcStySGw3SXhjdEZUQmIy?=
 =?utf-8?B?d2hDcm9XcFBLbFdlZDJFSkR5NUdZOWVjMkZsRGtBVlh0WUpRT3V3Um1ka0Z3?=
 =?utf-8?B?RmVrR2dqTVNiVC9vbEhXb2ZvVGlJcE5tTXgzKzNrNDZONUQrQnAvYnd3d0lQ?=
 =?utf-8?B?OUUrU2lqU2syajFkZlhIVWIyWHZ3dGxzdUhobktBMkk2ZzBqN3BuS3Y1VGor?=
 =?utf-8?B?L0VvSG9MN2lSRExjbkwyYXVYcWFZcVluRFNrNmZhekZ6N09uN1pFY1VyQ0Y5?=
 =?utf-8?B?eXZRQVF1Y0VRcXk3Q0l4NkFpTTg2YllZV2xxWGZnd2JGM1pLbkZNaTFUcVgr?=
 =?utf-8?B?Tm02eng3ZXdZd2RUcVZKSmQwenJJczFLcXlRUkVZU1Q2NEVIQ1ZBWnczTUFN?=
 =?utf-8?B?dVMxV3IxM05ydmpvTENPK0FlK3FXVTZIcys2MFlCYUdMSmZKSEV2ZzFuSXpo?=
 =?utf-8?B?N2RhV1RWRmNNV2g4ek1ieGt3eUszUUdvb2xIek1iMEVHeEsraHhSOGZYTlBt?=
 =?utf-8?B?UHE3Qk9Xdi92dTJnSDhNMEdmMXZGRWNwKzBnem9DRHNhbmlqRnFhRklnVW5u?=
 =?utf-8?B?Vzh6MzV2OHdmVm02Nlc4ZnV6RGZWYzI2RUFldGJyTnZvM3pSejFLNVhMdUZD?=
 =?utf-8?B?bmMrcHJLVFM5Q2lIeTg4MFJBYzRYUko4MDJDaHQ2NXRVQzBtTVBKRSsrNktR?=
 =?utf-8?B?QWFaWTZ3SmkrcjVUUXJvelpid3hUdzEwUlVTSFRZYU5IVDU4dzBMSzhnMlNs?=
 =?utf-8?B?Tjl6Z0xFZkFCcHJsNGhINHJzVkU2ckZtOHJXLzd0citoekNGb0x5YmJKVnFq?=
 =?utf-8?B?RG8rZGkwOGNicHFiakpzRzNaQlZYaVBYcGxGTW13QWpOWFdJOFBkc25ZMWpN?=
 =?utf-8?B?aDFmTXZuaElrTUI1SXlFbVoxODBCZFNCaW92YnZGakZiQ1VSb0Y4b3pTbEZS?=
 =?utf-8?B?Ymp0OEdUK2dURndqVlRaL2tzQlNMVFlqOUdsMW0vN3puU3dWVDlQSUc2ZmZu?=
 =?utf-8?B?bjdKMzJBNkk0akhnTndwNjM2Z1hkdkZyOXZIenVZL2xHY0lHcktRLzNYNXFB?=
 =?utf-8?B?Z051ZEZEbkVxVE5PajZmTC9HNWRyb3ovYVRkajNmZjJuQ3B0QWFXUTMrRXky?=
 =?utf-8?B?MHlNdmFiQWsyVHMycHJlUUJkTDdXMzZLTVJDbkJiYlNvV05SZmtQMUwyN005?=
 =?utf-8?B?Uzh6NDhXWTRwM3I0NkRoamNxOURNdW9kMXBtK3RzV0VGd0NtLzhjbHRncExC?=
 =?utf-8?B?dWVsbUxXUEdXTlVZUU9xYXU5SmpNeXVzbjdDcCt6dUZzN0hCYUNrRFlZVlMx?=
 =?utf-8?B?OGNIWlNuNkZCUHZDcXNUMU1tN0xZbHRhYS9Zb0J1dU9tUm5lZ2tEZHYyUnhl?=
 =?utf-8?B?QytyVU9GZXA3bUhpanJmaWxpaFBKOFduOXJ6anNpR084Z3BWK1hGajNWSzc4?=
 =?utf-8?B?dHdsb3ZiTW5wb1FkczVGR013ejJhU2Q0d1hsNkNXZ3dMc21LMWVyalBEbDYz?=
 =?utf-8?B?bk91cmF0ekV1dmE1YUZkQUR4azV0RnBaUXRTQTFkUzdpcUEraGVnZUcxSXhD?=
 =?utf-8?Q?5MCkNw86/Qip7GsTVJE6yl47f+OPCsrBOyux5bS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d90e6d-bc2e-4e07-d92d-08d963530853
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 20:50:52.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiM3d/qvo3cOd+osQfbYqX922sjeUPBu/jRmG/1w1O+y8I9tifZ2nfRiz5uWsuyilM6z/5Zj+julEd143qt0Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4177
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190119
X-Proofpoint-GUID: cC4sCOoyPRBmC-pQ5viGQ_h4xk0Ffhf-
X-Proofpoint-ORIG-GUID: cC4sCOoyPRBmC-pQ5viGQ_h4xk0Ffhf-
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/19/2021 2:10 AM, ruansy.fnst@fujitsu.com wrote:
>> From: Jane Chu <jane.chu@oracle.com>
>> Subject: Re: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
>>
>> Sorry, correction in line.
>>
>> On 8/19/2021 12:18 AM, Jane Chu wrote:
>>> Hi, Shiyang,
>>>
>>>   >  > > 1) What does it take and cost to make  >  > >
>>> xfs_sb_version_hasrmapbt(&mp->m_sb) to return true?
>>>   >
>>>   > Enable rmpabt feature when making xfs filesystem  >     `mkfs.xfs
>>> -m rmapbt=1 /path/to/device`  > BTW, reflink is enabled by default.
>>>
>>> Thanks!  I tried
>>> mkfs.xfs -d agcount=2,extszinherit=512,su=2m,sw=1 -m reflink=0 -m
>>> rmapbt=1 -f /dev/pmem0
>>>
>>> Again, injected a HW poison to the first page in a dax-file, had the
>>> poison consumed and received a SIGBUS. The result is better -
>>>
>>> ** SIGBUS(7): canjmp=1, whichstep=0, **
>>> ** si_addr(0x0x7ff2d8800000), si_lsb(0x15), si_code(0x4,
>>> BUS_MCEERR_AR) **
>>>
>>> The SIGBUS payload looks correct.
>>>
>>> However, "dmesg" has 2048 lines on sending SIGBUS, one per 512bytes -
>>
>> Actually that's one per 2MB, even though the poison is located in pfn 0x1850600
>> only.
>>
>>>
>>> [ 7003.482326] Memory failure: 0x1850600: Sending SIGBUS to
>>> fsdax_poison_v1:4109 due to hardware memory corruption [ 7003.507956]
>>> Memory failure: 0x1850800: Sending SIGBUS to
>>> fsdax_poison_v1:4109 due to hardware memory corruption [ 7003.531681]
>>> Memory failure: 0x1850a00: Sending SIGBUS to
>>> fsdax_poison_v1:4109 due to hardware memory corruption [ 7003.554190]
>>> Memory failure: 0x1850c00: Sending SIGBUS to
>>> fsdax_poison_v1:4109 due to hardware memory corruption [ 7003.575831]
>>> Memory failure: 0x1850e00: Sending SIGBUS to
>>> fsdax_poison_v1:4109 due to hardware memory corruption [ 7003.596796]
>>> Memory failure: 0x1851000: Sending SIGBUS to
>>> fsdax_poison_v1:4109 due to hardware memory corruption ....
>>> [ 7045.738270] Memory failure: 0x194fe00: Sending SIGBUS to
>>> fsdax_poison_v1:4109 due to hardware memory corruption [ 7045.758885]
>>> Memory failure: 0x1950000: Sending SIGBUS to
>>> fsdax_poison_v1:4109 due to hardware memory corruption [ 7045.779495]
>>> Memory failure: 0x1950200: Sending SIGBUS to
>>> fsdax_poison_v1:4109 due to hardware memory corruption [ 7045.800106]
>>> Memory failure: 0x1950400: Sending SIGBUS to
>>> fsdax_poison_v1:4109 due to hardware memory corruption
>>>
>>> That's too much for a single process dealing with a single poison in a
>>> PMD page. If nothing else, given an .si_addr_lsb being 0x15, it
>>> doesn't make sense to send a SIGBUS per 512B block.
>>>
>>> Could you determine the user process' mapping size from the
>>> filesystem, and take that as a hint to determine how many iterations
>>> to call
>>> mf_dax_kill_procs() ?
>>
>> Sorry, scratch the 512byte stuff... the filesystem has been notified the length of
>> the poison blast radius, could it take clue from that?
> 
> I think this is caused by a mistake I made in the 6th patch: xfs handler iterates the file range in block size(4k here) even though it is a PMD page. That's why so many message shows when poison on a PMD page.  I'll fix it in next version.
> 

Sorry, just to clarify, it looks like XFS has iterated through out the
entire file in 2MiB stride.  The test file size is 4GiB, that explains
'dmesg' showing 2048 line about sending SIGBUS.

thanks,
-jane


> 
> --
> Thanks,
> Ruan.
> 
>>
>> thanks,
>> -jane
>>
>>>
>>> thanks!
>>> -jane
>>>
>>>
>>>
