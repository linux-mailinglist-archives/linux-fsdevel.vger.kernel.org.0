Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FE346459B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 04:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbhLADzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 22:55:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14992 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231927AbhLADzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:55:40 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B12S4d7007277;
        Wed, 1 Dec 2021 03:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KpfwfsNjJ5FOvhbjod+OJ9wFHaiCq4Gd9YxUB558HCE=;
 b=HRmHxh0Kw9fMRIlatFTwbSN8CpxKsBr1Ypn2WyATE61fxppzyJb2Gd8lenqRqS+hZTX4
 CPWiu/J0CKfa+TXq3kCrF8IuEl7EBYB62Sf4+3GKwRJbT/kjV381p74YEbMKiNsIgg/R
 5unH4K+1Y5bJPpM7gqJKb1CorGVv0CoO/2a9rmyaWGQIkg4aCERnk3+LZDCdN/tymjFy
 nb6a1lYWxe59eMtm3G+pB4rfOSGRK4cPdEsi5s3o32DXPCK/qeFTgvIS2fjji9/FNulL
 gmT7qk/MSD8/wwQ0BRGQ+jHiRhHH7CsDH78vJaeODerk4S6W09QkA8EAvoqF8rGiwgyt CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9x8jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 03:52:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B13fmJl069082;
        Wed, 1 Dec 2021 03:52:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 3ck9t0xq3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 03:52:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvIqOIkg59ItrlsPgQc30FlUrXiq4O0ZQHSrZbGnkwbiUfQC+Z/xUKwJ440frA1MPtol66qRIdms6vW7kDI0LTjDoWHl4LAPqfmU+z2aLeDHaXT/D1P9hIzC0sZoJRoMttylryMQ0c0yaZ4oaz22YUpEoAXsdVGNYDcX8NAM1J2Ej/OuAJjZU6K5kofQPLSWnO8dSvPJU9Lj4tkGW56NyxjEJpIovt52zOfnt9D/4JdLJCi0mnDIfDV+lL7LPkmFeiys5fNQaCKLVSMvdHoFsGRP+rUCQFXSTJUUtxuX1zhtS1XM13/qAxn6wQibP8aD7XUy0uiOsrWLwgO4ZSfiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpfwfsNjJ5FOvhbjod+OJ9wFHaiCq4Gd9YxUB558HCE=;
 b=PfMk9H7DrDRvC2WlPjtzUOJbBPGdJM/7Eg88wm6o5RrUDRSmZZCjcGd/8hwfk1xAeka7QVZKikAesyh3qBMYZ+iwuoJCQ59GZ2krJtoLP8iLkXbarlMAF5imxT8wTs3K0g9ZpTE6J9bgbviDj/RXWzDpk0zXI0kPp3Sj4c4P5Jla7tkdldsJPd3R3MEtwEOlOPcujc+Vuxav6a4S+81ql1Rh6DdqkVOlS8HqwgARWKCMQOyFsqcNxrSG/2zvGshz94uwzoSX0t29skgBFYSA6TS44DdvENgWvyCP3ROgd1byNIQbU3ruLC93Jy7xcNCg0nXrLxIXWJjMAsF5cHtJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpfwfsNjJ5FOvhbjod+OJ9wFHaiCq4Gd9YxUB558HCE=;
 b=HaIeI3AMQMnM6OhdrnfXYeeWRRd/p9Z8IHcwXo7PDPsa0Yrn5Pe9t/DgtAXfxHdKDyzAW7YWjqgdGfW4nT/39YsvTBJtM+MUM6qrhk3HOpeOjxKa6rUksHSYvYW41aalsYFJJrnaSL3prCaPDqc3XPh2QwZFLZFrpRtF8Ps69n0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB3779.namprd10.prod.outlook.com (2603:10b6:a03:1b6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 03:52:13 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Wed, 1 Dec 2021
 03:52:13 +0000
Message-ID: <9cfd81cc-aee9-bcf3-a4be-bb9a39992ae8@oracle.com>
Date:   Tue, 30 Nov 2021 19:52:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <c8eef4ab9cb7acdf506d35b7910266daa9ded18c.camel@hammerspace.com>
 <0B58F7BC-A946-4FE6-8AC2-4C694A2120A3@oracle.com>
 <3afa1db55ccdf52eff7afb7b684eb961f878b68a.camel@hammerspace.com>
 <7548c291-cc0a-ed7a-ca37-63afe1d88c27@oracle.com>
 <3302102abac40bfbbd861f6ed942b2536db2e59a.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <3302102abac40bfbbd861f6ed942b2536db2e59a.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:806:21::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.159.143.49] (138.3.200.49) by SA9PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:21::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend Transport; Wed, 1 Dec 2021 03:52:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76e3765d-1fcf-498e-6b26-08d9b47df558
X-MS-TrafficTypeDiagnostic: BY5PR10MB3779:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3779533C754CA3F03B3692A287689@BY5PR10MB3779.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjmMdaPkmt/xMo0FzNR4F9eVmCScuxrzwlI60OsEAskCdYs32U8wewld5hjjbGe2T9IY4bjeFgpslweggB7ro01vh/howB5aSeABTuuDN0o7dKjtoWsL3a/bV/o6YWBfta4irTf7F+Xg4jBLPU8RiMC9eK3kS4AHrKgPtdzgF2Dawh/NyhFdtV/MH7XvzcRzCCMG61ILlzo8r4KJZTlG059yrrK/OcGxgsqTWihvdr2XfUEKInx/zft0tIaolHPZrFt0bdjdEXC0TotNcfpIt0Gp8Ek/8F890Hxk3twWbd9jlXxZD33Z49aktx4yqqz4Gqc22b+j1K7ckWlxdDFrNL5vm+jeSVXwrV0M51DbywZK58REjFWM4cwlXxDGfohxUkdEY34lNlmpEMOza4GVIC3dzWkIQNWo2CbkpB5ebU6PASYhSPPp/7YUZ+fXcOmnzjokyzZRNicGyrGXnxQwdktNHR+o5mHZQmT16JOD4+oJd+LgB148LeJnzT0XVAmr30I3vUfu0joeezKw5Y6QBtutD251rk70m426l4l70jev7R7PeQDkPQpF7T/yHkF5daXO/9tjNYE5XByW0ysgfeTW+v44d0b2lDWJxlLh6/qKD+a6MlfnsPW8TT3soFXZ1QA3jnC64oEMpL/h0Lg5A4mNpiWu7g2XzdTFuc9dUAyCCpm5adcybwNWR/CPNbEn566e69jwhA7+15sDmWQvXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(36756003)(54906003)(110136005)(83380400001)(26005)(2616005)(53546011)(38100700002)(956004)(8936002)(186003)(66946007)(16576012)(316002)(66556008)(5660300002)(86362001)(66476007)(31686004)(30864003)(6486002)(508600001)(4326008)(4001150100001)(2906002)(31696002)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTFpdmZrU1lpZG1qUFhNVWU2QTZpaWx3YlNCTUtKRE5BYWtORjFNN0JYcCtX?=
 =?utf-8?B?Nkk3Rm5ZNGZxMTVPNkNSM2JxNFNmMmdxK05LRS9LcWlZajd1emJGY1JvTk9R?=
 =?utf-8?B?UGVNR0pJUlhSUGVOSEZ1TWZ6TGNtcnhPY3RLRHVGRWxTa2hZbHhTSVBBK2dk?=
 =?utf-8?B?ajFIY0t4TDNCOURkZ3VnVzZaaGE5aXJIbTVRSGo1aWJ5NEk5TFN3dW9KWGF3?=
 =?utf-8?B?NGJkYWhjcXhNWGh0YnNDSC91ZFBJMDRLejFGaXM2MnNuT2kyZm5WNVdDNzlI?=
 =?utf-8?B?dzRtc2QxcFlJODJTa1hjaWdScWhCeW4rUVRIS0lDTS8wRUlqd1pSeEpFcG90?=
 =?utf-8?B?MEhpQ1hzeDdLaEdubDVxVHE0ZmtGMFMrOXNYVmlUMFMwSmpzaktKaEVMVmpy?=
 =?utf-8?B?OFNyQlhPY3g0N2lWL09QY1NMTnZMUUdlY3JkQXRxTFZ4RkdxOFhXZGJxdjc0?=
 =?utf-8?B?STZrYkVDT2pUS2daandxdStKYlpXOG4zNGVja3NybWhXWG90azhsK0ZlVUgy?=
 =?utf-8?B?RVZrd1JrOVB1cEppMHVheDJrY2plYy9vU25ZTHhpVWxweWFqY08wVXZIdjBL?=
 =?utf-8?B?TDdhWFhTZTBic1JSR3JtUm5SYVU2SHdCVlRWUkU5L1FLSGo0Y0V4NjNneDlt?=
 =?utf-8?B?cSt1YVA2bXhEbmtZTW16TlhVbUtncVdqV2sxam1tK3F5eEZaWXBtRlQ3ZXZY?=
 =?utf-8?B?akxJbVhFN0ptL1VaUzJNVHN6cUwzc1p4TEhhNE5iY2lBL2VXVmgzV2FNU3Qv?=
 =?utf-8?B?NHdZWTZEbzdES3lQZk5RYWxuL0MvQ0JyM25iT3NnSHpFQVR0bHlnb0txVEtP?=
 =?utf-8?B?R2crRmVNMDJGUy9nWWcva1ozbmRHZnFGZWxwSEttM011Rk9mWUVSWFNSemxM?=
 =?utf-8?B?ZnlNQXdMeStYZmMvcDlOUzVHMkVYc2JMSEJoRGtFaElrNUc2YTcydk9NaUFO?=
 =?utf-8?B?cEFGamZxNGRBeTZlQkRrOEdoU09xQjUvdWFvM01FMGRhOWJkSDh5UDdTb2Jp?=
 =?utf-8?B?cExJWTV1UWY2WllxbWc0UkJRbnRiUjNISG1jaG9CeXFmbGhJNnZDZE5ZWDFO?=
 =?utf-8?B?WXhXQngxd2VaU0xwUmpOM0VBYkxHLytFZForc1JYbzdocktBbjNrbmp1MUtV?=
 =?utf-8?B?ZGk1UGVXbStTcUhTV1p4YlNaMStVdUZhLzlkaFYzTlN5R3hiR2cxSE9MK2k3?=
 =?utf-8?B?T3o1UmM2c2oyaWdicUlxa3JwbDlETEtkaUg1Tk9BUzdZTDRjY2JWNU95eHBQ?=
 =?utf-8?B?NWF1bFJmWExDN2ZkWXRoZ2Q4STdBY2RwS2hONDh4QjlCVTVhNThMWGVqRG00?=
 =?utf-8?B?emxtSE5xSlM1RUN6c3BMVEdPT20xLzNKeXQ2a2orcFNKazZrUnFYMEs0aFFx?=
 =?utf-8?B?d04rNTZudWdpSGtvUW4wZ1hTbEpva21LdmFOdzBuMnMrWVBSUFBDSDlFSHhu?=
 =?utf-8?B?UDRKc3R6Qm13ZGRwUnR1T0cyNEdoRzFOajl6eFI2cWhVVEVmWC9jY0owMnM2?=
 =?utf-8?B?VHk1SmRTVm1VdEtydTFYeEl4Zm1FSnFwNVphOGRDUE5kWVRHdVpnd0FneTVv?=
 =?utf-8?B?YUFvaHA5aThsQ3NKVU02NVRFVWdPL2NrSXhLbjMwRDE0b0VqZnZ6cDdYZ1U4?=
 =?utf-8?B?eXZrRHVhU2hTWm1zYlAxU29nUGg2eGYvWjZsbXArY0ZFTHdVVFRnWmtGYUpS?=
 =?utf-8?B?Rk93eUNYaytmR3Uva3NVenFoazlDcDJWT3AyTmVFS2FaOTVwYmRGVWZaZkpY?=
 =?utf-8?B?M3BUdDArcEg0NTQ3V2RzZ1VMWjBEb0U4TXdob1pCdVNvL2F3b296eU1aZWlH?=
 =?utf-8?B?VGZralpPdUJyK2Q3elU4VG5XcFZSeDRVcy8zd2xNWlVBRC9KL1E2dmxWMEVX?=
 =?utf-8?B?MTlWeVZjUU42MHlBWXU3aWhONkw3RTRjc2lGSjRYSDhQVEs2N2dmcHVlaWVj?=
 =?utf-8?B?ZnVORktjc1FQOE5adytRS1l1Q1cvVFYrTDM1K2UvL1ZVemY3dTFwZ1ZZaTVT?=
 =?utf-8?B?cXE2VmdsK2J0aVZMWWRNU2k1dUwzUHNBcGZRcEQvS2ZtZ0FXYTJwNXNnU0pR?=
 =?utf-8?B?Sml1U3I5UHFqL3kwK0M2R0RTUGtuUVpyTnVaUDhpaFlRNm56L3VVU1dId09m?=
 =?utf-8?B?WEpvK25WSUFEVld6eG80SWVNT0I3Z3hZNW1tMExzMTNkd3RjMjJaMUk0c0c4?=
 =?utf-8?Q?8dtGf97YldEh6QHAglkj2Mo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e3765d-1fcf-498e-6b26-08d9b47df558
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 03:52:13.1004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htW7GTJl+/Wk/E0A+je5VrhYQnWYVRa+3Wx2ndmYa8BJcc7kHFgAeg7irpS/9kwE9gRp+IntEAg5VS4LXrPDzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3779
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010019
X-Proofpoint-GUID: qqxaJ3e1XTEp7lP7KmS_D8GfCFago5ob
X-Proofpoint-ORIG-GUID: qqxaJ3e1XTEp7lP7KmS_D8GfCFago5ob
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/30/21 5:37 AM, Trond Myklebust wrote:
> On Mon, 2021-11-29 at 23:22 -0800, dai.ngo@oracle.com wrote:
>> On 11/29/21 8:57 PM, Trond Myklebust wrote:
>>> On Tue, 2021-11-30 at 04:47 +0000, Chuck Lever III wrote:
>>>>> On Nov 29, 2021, at 11:08 PM, Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>
>>>>> ﻿On Tue, 2021-11-30 at 01:42 +0000, Chuck Lever III wrote:
>>>>>>>> On Nov 29, 2021, at 7:11 PM, Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> wrote:
>>>>>>> ﻿
>>>>>>>> On 11/29/21 1:10 PM, Chuck Lever III wrote:
>>>>>>>>
>>>>>>>>>> On Nov 29, 2021, at 2:36 PM, Dai Ngo
>>>>>>>>>> <dai.ngo@oracle.com>
>>>>>>>>>> wrote:
>>>>>>>>> On 11/29/21 11:03 AM, Chuck Lever III wrote:
>>>>>>>>>> Hello Dai!
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> On Nov 29, 2021, at 1:32 PM, Dai Ngo
>>>>>>>>>>> <dai.ngo@oracle.com>
>>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 11/29/21 9:30 AM, J. Bruce Fields wrote:
>>>>>>>>>>>> On Mon, Nov 29, 2021 at 09:13:16AM -0800,
>>>>>>>>>>>> dai.ngo@oracle.com wrote:
>>>>>>>>>>>>> Hi Bruce,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
>>>>>>>>>>>>>> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
>>>>>>>>>>>>>>> On Wed, Nov 17, 2021 at 01:46:02PM -0800,
>>>>>>>>>>>>>>> dai.ngo@oracle.com wrote:
>>>>>>>>>>>>>>>> On 11/17/21 9:59 AM,
>>>>>>>>>>>>>>>> dai.ngo@oracle.com wrote:
>>>>>>>>>>>>>>>>> On 11/17/21 6:14 AM, J. Bruce Fields
>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -
>>>>>>>>>>>>>>>>>> 0800,
>>>>>>>>>>>>>>>>>> dai.ngo@oracle.com wrote:
>>>>>>>>>>>>>>>>>>> Just a reminder that this patch is
>>>>>>>>>>>>>>>>>>> still
>>>>>>>>>>>>>>>>>>> waiting for your review.
>>>>>>>>>>>>>>>>>> Yeah, I was procrastinating and
>>>>>>>>>>>>>>>>>> hoping
>>>>>>>>>>>>>>>>>> yo'ud
>>>>>>>>>>>>>>>>>> figure out the pynfs
>>>>>>>>>>>>>>>>>> failure for me....
>>>>>>>>>>>>>>>>> Last time I ran 4.0 OPEN18 test by
>>>>>>>>>>>>>>>>> itself
>>>>>>>>>>>>>>>>> and
>>>>>>>>>>>>>>>>> it passed. I will run
>>>>>>>>>>>>>>>>> all OPEN tests together with 5.15-rc7
>>>>>>>>>>>>>>>>> to
>>>>>>>>>>>>>>>>> see if
>>>>>>>>>>>>>>>>> the problem you've
>>>>>>>>>>>>>>>>> seen still there.
>>>>>>>>>>>>>>>> I ran all tests in nfsv4.1 and nfsv4.0
>>>>>>>>>>>>>>>> with
>>>>>>>>>>>>>>>> courteous and non-courteous
>>>>>>>>>>>>>>>> 5.15-rc7 server.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Nfs4.1 results are the same for both
>>>>>>>>>>>>>>>> courteous
>>>>>>>>>>>>>>>> and
>>>>>>>>>>>>>>>> non-courteous server:
>>>>>>>>>>>>>>>>> Of those: 0 Skipped, 0 Failed, 0
>>>>>>>>>>>>>>>>> Warned,
>>>>>>>>>>>>>>>>> 169
>>>>>>>>>>>>>>>>> Passed
>>>>>>>>>>>>>>>> Results of nfs4.0 with non-courteous
>>>>>>>>>>>>>>>> server:
>>>>>>>>>>>>>>>>> Of those: 8 Skipped, 1 Failed, 0
>>>>>>>>>>>>>>>>> Warned,
>>>>>>>>>>>>>>>>> 577
>>>>>>>>>>>>>>>>> Passed
>>>>>>>>>>>>>>>> test failed: LOCK24
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Results of nfs4.0 with courteous server:
>>>>>>>>>>>>>>>>> Of those: 8 Skipped, 3 Failed, 0
>>>>>>>>>>>>>>>>> Warned,
>>>>>>>>>>>>>>>>> 575
>>>>>>>>>>>>>>>>> Passed
>>>>>>>>>>>>>>>> tests failed: LOCK24, OPEN18, OPEN30
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> OPEN18 and OPEN30 test pass if each is
>>>>>>>>>>>>>>>> run by
>>>>>>>>>>>>>>>> itself.
>>>>>>>>>>>>>>> Could well be a bug in the tests, I don't
>>>>>>>>>>>>>>> know.
>>>>>>>>>>>>>> The reason OPEN18 failed was because the test
>>>>>>>>>>>>>> timed
>>>>>>>>>>>>>> out waiting for
>>>>>>>>>>>>>> the reply of an OPEN call. The RPC connection
>>>>>>>>>>>>>> used
>>>>>>>>>>>>>> for the test was
>>>>>>>>>>>>>> configured with 15 secs timeout. Note that
>>>>>>>>>>>>>> OPEN18
>>>>>>>>>>>>>> only fails when
>>>>>>>>>>>>>> the tests were run with 'all' option, this
>>>>>>>>>>>>>> test
>>>>>>>>>>>>>> passes if it's run
>>>>>>>>>>>>>> by itself.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> With courteous server, by the time OPEN18
>>>>>>>>>>>>>> runs,
>>>>>>>>>>>>>> there
>>>>>>>>>>>>>> are about 1026
>>>>>>>>>>>>>> courtesy 4.0 clients on the server and all of
>>>>>>>>>>>>>> these
>>>>>>>>>>>>>> clients have opened
>>>>>>>>>>>>>> the same file X with WRITE access. These
>>>>>>>>>>>>>> clients
>>>>>>>>>>>>>> were
>>>>>>>>>>>>>> created by the
>>>>>>>>>>>>>> previous tests. After each test completed,
>>>>>>>>>>>>>> since
>>>>>>>>>>>>>> 4.0
>>>>>>>>>>>>>> does not have
>>>>>>>>>>>>>> session, the client states are not cleaned up
>>>>>>>>>>>>>> immediately on the
>>>>>>>>>>>>>> server and are allowed to become courtesy
>>>>>>>>>>>>>> clients.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> When OPEN18 runs (about 20 minutes after the
>>>>>>>>>>>>>> 1st
>>>>>>>>>>>>>> test
>>>>>>>>>>>>>> started), it
>>>>>>>>>>>>>> sends OPEN of file X with
>>>>>>>>>>>>>> OPEN4_SHARE_DENY_WRITE
>>>>>>>>>>>>>> which causes the
>>>>>>>>>>>>>> server to check for conflicts with courtesy
>>>>>>>>>>>>>> clients.
>>>>>>>>>>>>>> The loop that
>>>>>>>>>>>>>> checks 1026 courtesy clients for share/access
>>>>>>>>>>>>>> conflict took less
>>>>>>>>>>>>>> than 1 sec. But it took about 55 secs, on my
>>>>>>>>>>>>>> VM,
>>>>>>>>>>>>>> for
>>>>>>>>>>>>>> the server
>>>>>>>>>>>>>> to expire all 1026 courtesy clients.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I modified pynfs to configure the 4.0 RPC
>>>>>>>>>>>>>> connection
>>>>>>>>>>>>>> with 60 seconds
>>>>>>>>>>>>>> timeout and OPEN18 now consistently passed.
>>>>>>>>>>>>>> The
>>>>>>>>>>>>>> 4.0
>>>>>>>>>>>>>> test results are
>>>>>>>>>>>>>> now the same for courteous and non-courteous
>>>>>>>>>>>>>> server:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Note that 4.1 tests do not suffer this
>>>>>>>>>>>>>> timeout
>>>>>>>>>>>>>> problem because the
>>>>>>>>>>>>>> 4.1 clients and sessions are destroyed after
>>>>>>>>>>>>>> each
>>>>>>>>>>>>>> test completes.
>>>>>>>>>>>>> Do you want me to send the patch to increase
>>>>>>>>>>>>> the
>>>>>>>>>>>>> timeout for pynfs?
>>>>>>>>>>>>> or is there any other things you think we
>>>>>>>>>>>>> should
>>>>>>>>>>>>> do?
>>>>>>>>>>>> I don't know.
>>>>>>>>>>>>
>>>>>>>>>>>> 55 seconds to clean up 1026 clients is about 50ms
>>>>>>>>>>>> per
>>>>>>>>>>>> client, which is
>>>>>>>>>>>> pretty slow.  I wonder why.  I guess it's
>>>>>>>>>>>> probably
>>>>>>>>>>>> updating the stable
>>>>>>>>>>>> storage information.  Is /var/lib/nfs/ on your
>>>>>>>>>>>> server
>>>>>>>>>>>> backed by a hard
>>>>>>>>>>>> drive or an SSD or something else?
>>>>>>>>>>> My server is a virtualbox VM that has 1 CPU, 4GB
>>>>>>>>>>> RAM
>>>>>>>>>>> and
>>>>>>>>>>> 64GB of hard
>>>>>>>>>>> disk. I think a production system that supports
>>>>>>>>>>> this
>>>>>>>>>>> many
>>>>>>>>>>> clients should
>>>>>>>>>>> have faster CPUs, faster storage.
>>>>>>>>>>>
>>>>>>>>>>>> I wonder if that's an argument for limiting the
>>>>>>>>>>>> number of
>>>>>>>>>>>> courtesy
>>>>>>>>>>>> clients.
>>>>>>>>>>> I think we might want to treat 4.0 clients a bit
>>>>>>>>>>> different
>>>>>>>>>>> from 4.1
>>>>>>>>>>> clients. With 4.0, every client will become a
>>>>>>>>>>> courtesy
>>>>>>>>>>> client after
>>>>>>>>>>> the client is done with the export and unmounts it.
>>>>>>>>>> It should be safe for a server to purge a client's
>>>>>>>>>> lease
>>>>>>>>>> immediately
>>>>>>>>>> if there is no open or lock state associated with it.
>>>>>>>>> In this case, each client has opened files so there are
>>>>>>>>> open
>>>>>>>>> states
>>>>>>>>> associated with them.
>>>>>>>>>
>>>>>>>>>> When an NFSv4.0 client unmounts, all files should be
>>>>>>>>>> closed
>>>>>>>>>> at that
>>>>>>>>>> point,
>>>>>>>>> I'm not sure pynfs does proper clean up after each
>>>>>>>>> subtest,
>>>>>>>>> I
>>>>>>>>> will
>>>>>>>>> check. There must be state associated with the client
>>>>>>>>> in
>>>>>>>>> order
>>>>>>>>> for
>>>>>>>>> it to become courtesy client.
>>>>>>>> Makes sense. Then a synthetic client like pynfs can DoS a
>>>>>>>> courteous
>>>>>>>> server.
>>>>>>>>
>>>>>>>>
>>>>>>>>>> so the server can wait for the lease to expire and
>>>>>>>>>> purge
>>>>>>>>>> it
>>>>>>>>>> normally. Or am I missing something?
>>>>>>>>> When 4.0 client lease expires and there are still
>>>>>>>>> states
>>>>>>>>> associated
>>>>>>>>> with the client then the server allows this client to
>>>>>>>>> become
>>>>>>>>> courtesy
>>>>>>>>> client.
>>>>>>>> I think the same thing happens if an NFSv4.1 client
>>>>>>>> neglects
>>>>>>>> to
>>>>>>>> send
>>>>>>>> DESTROY_SESSION / DESTROY_CLIENTID. Either such a client
>>>>>>>> is
>>>>>>>> broken
>>>>>>>> or malicious, but the server faces the same issue of
>>>>>>>> protecting
>>>>>>>> itself from a DoS attack.
>>>>>>>>
>>>>>>>> IMO you should consider limiting the number of courteous
>>>>>>>> clients
>>>>>>>> the server can hold onto. Let's say that number is 1000.
>>>>>>>> When
>>>>>>>> the
>>>>>>>> server wants to turn a 1001st client into a courteous
>>>>>>>> client,
>>>>>>>> it
>>>>>>>> can simply expire and purge the oldest courteous client
>>>>>>>> on
>>>>>>>> its
>>>>>>>> list. Otherwise, over time, the 24-hour expiry will
>>>>>>>> reduce
>>>>>>>> the
>>>>>>>> set of courteous clients back to zero.
>>>>>>>>
>>>>>>>> What do you think?
>>>>>>> Limiting the number of courteous clients to handle the
>>>>>>> cases of
>>>>>>> broken/malicious 4.1 clients seems reasonable as the last
>>>>>>> resort.
>>>>>>>
>>>>>>> I think if a malicious 4.1 clients could mount the server's
>>>>>>> export,
>>>>>>> opens a file (to create state) and repeats the same with a
>>>>>>> different
>>>>>>> client id then it seems like some basic security was
>>>>>>> already
>>>>>>> broken;
>>>>>>> allowing unauthorized clients to mount server's exports.
>>>>>> You can do this today with AUTH_SYS. I consider it a genuine
>>>>>> attack
>>>>>> surface.
>>>>>>
>>>>>>
>>>>>>> I think if we have to enforce a limit, then it's only for
>>>>>>> handling
>>>>>>> of seriously buggy 4.1 clients which should not be the
>>>>>>> norm.
>>>>>>> The
>>>>>>> issue with this is how to pick an optimal number that is
>>>>>>> suitable
>>>>>>> for the running server which can be a very slow or a very
>>>>>>> fast
>>>>>>> server.
>>>>>>>
>>>>>>> Note that even if we impose an limit, that does not
>>>>>>> completely
>>>>>>> solve
>>>>>>> the problem with pynfs 4.0 test since its RPC timeout is
>>>>>>> configured
>>>>>>> with 15 secs which just enough to expire 277 clients based
>>>>>>> on
>>>>>>> 53ms
>>>>>>> for each client, unless we limit it ~270 clients which I
>>>>>>> think
>>>>>>> it's
>>>>>>> too low.
>>>>>>>
>>>>>>> This is what I plan to do:
>>>>>>>
>>>>>>> 1. do not support 4.0 courteous clients, for sure.
>>>>>> Not supporting 4.0 isn’t an option, IMHO. It is a fully
>>>>>> supported
>>>>>> protocol at this time, and the same exposure exists for 4.1,
>>>>>> it’s
>>>>>> just a little harder to exploit.
>>>>>>
>>>>>> If you submit the courteous server patch without support for
>>>>>> 4.0,
>>>>>> I
>>>>>> think it needs to include a plan for how 4.0 will be added
>>>>>> later.
>>>>>>
>>>>> Why is there a problem here? The requirements are the same for
>>>>> 4.0
>>>>> and
>>>>> 4.1 (or 4.2). If the lease under which the courtesy lock was
>>>>> established has expired, then that courtesy lock must be
>>>>> released
>>>>> if
>>>>> some other client requests a lock that conflicts with the
>>>>> cached
>>>>> lock
>>>>> (unless the client breaks the courtesy framework by renewing
>>>>> that
>>>>> original lease before the conflict occurs). Otherwise, it is
>>>>> completely
>>>>> up to the server when it decides to actually release the lock.
>>>>>
>>>>> For NFSv4.1 and NFSv4.2, we have DESTROY_CLIENTID, which tells
>>>>> the
>>>>> server when the client is actually done with the lease, making
>>>>> it
>>>>> easy
>>>>> to determine when it is safe to release all the courtesy locks.
>>>>> However
>>>>> if the client does not send DESTROY_CLIENTID, then we're in the
>>>>> same
>>>>> situation with 4.x (x>0) as we would be with bog standard
>>>>> NFSv4.0.
>>>>> The
>>>>> lease has expired, and so the courtesy locks are liable to
>>>>> being
>>>>> dropped.
>>>> I agree the situation is the same for all minor versions.
>>>>
>>>>
>>>>> At Hammerspace we have implemented courtesy locks, and our
>>>>> strategy
>>>>> is
>>>>> that when a conflict occurs, we drop the entire set of courtesy
>>>>> locks
>>>>> so that we don't have to deal with the "some locks were
>>>>> revoked"
>>>>> scenario. The reason is that when we originally implemented
>>>>> courtesy
>>>>> locks, the Linux NFSv4 client support for lock revocation was a
>>>>> lot
>>>>> less sophisticated than today. My suggestion is that you might
>>>>> therefore consider starting along this path, and then refining
>>>>> the
>>>>> support to make revocation more nuanced once you are confident
>>>>> that
>>>>> the
>>>>> coarser strategy is working as expected.
>>>> Dai’s implementation does all that, and takes the coarser
>>>> approach at
>>>> the moment. There are plans to explore the more nuanced behavior
>>>> (by
>>>> revoking only the conflicting lock instead of dropping the whole
>>>> lease) after this initial work is merged.
>>>>
>>>> The issue is there are certain pathological client behaviors
>>>> (whether
>>>> malicious or accidental) that can run the server out of
>>>> resources,
>>>> since it is holding onto lease state for a much longer time. We
>>>> are
>>>> simply trying to design a lease garbage collection scheme to meet
>>>> that challenge.
>>>>
>>>> I think limiting the number of courteous clients is a simple way
>>>> to
>>>> do this, but we could also shorten the courtesy lifetime as more
>>>> clients enter that state, to ensure that they don’t overrun the
>>>> server’s memory. Another approach might be to add a shrinker that
>>>> purges the oldest courteous clients when the server comes under
>>>> memory pressure.
>>>>
>>>>
>>> We already have a scanner that tries to release all client state
>>> after
>>> 1 lease period. Just extend that to do it after 10 lease periods.
>>> If a
>>> network partition hasn't recovered after 10 minutes, you probably
>>> have
>>> bigger problems.
>> Currently the courteous server allows 24hr for the network partition
>> to
>> heal before releasing all client state. That seems to be excessive
>> but
>> it was suggested for longer network partition conditions when
>> switch/routers
>> being repaired/upgraded.
>>
>>> You can limit the number of clients as well, but that leads into a
>>> rats
>>> nest of other issues that have nothing to do with courtesy locks
>>> and
>>> everything to do with the fact that any client can hold a lot of
>>> state.
>> The issue we currently have with courteous server and pynfs 4.0 tests
>> is the number of courteous 4.0 clients the server has to expire when
>> a
>> share reservation conflict occurs when servicing the OPEN. Each
>> client
>> owns only few state in this case so we think the server spent most
>> time
>> for deleting client's record in /var/lib/nfs. This is why we plan to
>> limit the number of courteous clients for now. As a side effect, it
>> might
>> also help to reduce resource consumption too.
> Then kick off a thread or work item to do that asynchronously in the
> background, and return NFS4ERR_DELAY to the clients that were trying to
> grab locks in the meantime.

Thanks Trond, I think this is a reasonable approach. The behavior would
be similar to a delegation recall during the OPEN.

My plan is:

1. If the number of conflict clients is less than 100 (some numbers that
cover realistic usage) then release all their state synchronously in
the OPEN call, and returns NFS4_OK to the NFS client. Most of conflicts
should be handled by this case.

2. If the number of conflict clients is more than 100 then release the
state of the 1st 100 clients as in (1) and trigger the laundromat thread
to release state of the rest of the conflict clients, and return
NFS4ERR_DELAY to the NFS client. This should be a rare condition.

-Dai

>
> The above process is hardly just confined to NFSv4.0 clients. If there
> is a network partition, then the exact same record deleting needs to be
> applied to all NFSv4.1 and NFSv4.2 clients that hold locks and are
> unable to renew their leases, so you might as well make it work for
> everyone.
>
