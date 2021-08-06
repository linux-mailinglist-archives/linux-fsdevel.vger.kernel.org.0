Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B94A3E2087
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 03:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbhHFBSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 21:18:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54832 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230033AbhHFBSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 21:18:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1761FvMR005072;
        Fri, 6 Aug 2021 01:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Bc2OsMkTTEIJAi0qZqEWWTBMYo5myKA29oToKSgEeR4=;
 b=Wa3MhiycJFJIitwqW+3DhCf3MfPHdlK3KSl/6rGiBpL1K1ozktDvdJ+gXf1pkbzYRxTO
 ke0E1mDD5AsM/y+s2qy08LPrYG+4anbZqtpv9ZDZbLTfOCBN7L/EMJmdxZ0Nj2JA6qS0
 dvxcnH3Vbp8aw9VeT+71iI6HmGbyj9iF+3HlsXcSrmxBmizUBg82M09Tg0b9lUPBsfb1
 c3jdRmfBxyxNKL9uJvoDMTe+0Vrc9FxZu0SGdxI/om3GRFSaVMcjwyj2VeCvDX4KkzCm
 A+awImwSDWLAGTvpao/a4UUMlaRzBGcUgvNb6GNfChY5mVV+9MuCHqh+7soTX5tvMtDE 8A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Bc2OsMkTTEIJAi0qZqEWWTBMYo5myKA29oToKSgEeR4=;
 b=pnDXPI7KAHF18nwsWe4hbpOuVfE69n5l3XPJpCqdfU46t4VFtGsAPmoQkTNm/kjrEsl0
 CrIXj4plHttXW6uHlMQ1EVHHihl9PeTM/50eaN9fmptk+7ju1e28xrV+FAJup704iZE5
 SdWAjbd8fmv5V+kq2aU6jUG5ed8FUTqkNz2hZsHXiSxsjZ/qBRK6De1pOOZyd+2rXgYx
 tId4Lbi4ZNhU9yVcS1RiJxvfpu+yOA/e3O3JcgG1H7LO7gVVdhutxz2oUG++HmoEJW5F
 FDmLNzn730Y8juDIRmRxs/lPf505fOV50vBnRWszVtwrwR2HcqkGlnlGGrM9lvNrH7t3 Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq0e2rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 01:17:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1761FgY7161090;
        Fri, 6 Aug 2021 01:17:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3030.oracle.com with ESMTP id 3a4un4u2pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 01:17:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuCJOjFNmZ6idrf7rvxWtE61tpimosNg2iWknXMT56LD2964rCb3s4tJov+0N9rV+J6wi/B1zAd0bz9QBDlsXkCAqPP7oMoXjwXRtLpgPZh3+k8pKR/+mzlgpIbzDufnTHz50Y98aFWvjCmf75sZIjl09xAQkvJ+fy3ebYUeNpeaQoebjUYe1R4MEkuWGn7vlioic1Qo82QJgPapuHn+i69QvP6Ppuj2FnObrtwtbEtFp7jIxtM1DRsaKdMQPu4xnYWijiEAzt7QlxAGB0RK3xrxGAAvXe5KZY64HCd4cET+AvtPI0bib9xJvQw/CD9W2Hk+gkaCW8wOImHfMZjP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc2OsMkTTEIJAi0qZqEWWTBMYo5myKA29oToKSgEeR4=;
 b=IPVoIfttXG6D5H7Wgmh8u32w9zjJhptM/OcyKh0zICtmUMeOQiMwONfS8VKieCK6bHv5/hPTJBjVET0b08ToT5x1rC3m9m2VyIdMYAaWxGUHRUo0oomOmnKmjkxrkeOszDkfLYWmA1q2umffzBiOrEfgzWsNr18wURZtsmA/D77L2L2hwkNyHVIV4zkX0Dg4JE34ZDSv5gqxnrXaUuV6En5p6D1wIHGcc5y6agS8l5XZPN+JLmUJR8+XnpVMmHpx+Uu4nswUZejjTZMWWLwN5DvmFF+rSYITkBEKpyEjQzcN16YiLmCEwpxTNYLRvsLwUHUA12pFSa7FdUSPpH7H8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc2OsMkTTEIJAi0qZqEWWTBMYo5myKA29oToKSgEeR4=;
 b=sv8324DSefGqpveIEBeDT6wFX8GOit/7Cx6l8g0rGQCKdkH5190Eys0j7y53WXm0iMfJqvpetQ3ekxb5aJGUd5/LMkdc43sjoduejv3UkKqpLJriVqrQINPWpmvMCWeYI3ZnK/fE0WFPvLVse+X5eZLVowubMTrR3MtNyIgfcpU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2759.namprd10.prod.outlook.com (2603:10b6:a02:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 6 Aug
 2021 01:17:37 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434%3]) with mapi id 15.20.4373.027; Fri, 6 Aug 2021
 01:17:37 +0000
Subject: Re: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
Date:   Thu, 5 Aug 2021 18:17:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:a03:167::43) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.70] (108.226.113.12) by BY5PR17CA0066.namprd17.prod.outlook.com (2603:10b6:a03:167::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 01:17:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c5cec6-3247-4400-201b-08d95877fa1a
X-MS-TrafficTypeDiagnostic: BYAPR10MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2759C9D650ACA2AC0DDED94FF3F39@BYAPR10MB2759.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HKhk0KoBWdg43/Kxl9So08KHqd6H/PuqHPERjTYq/qfZ521Snu2M9I4l8uzZjmKU9fzd2DpeVTHFAMXDDcNMATAXUCqSAEXPyOfRie4yabWoLZ5a7ZHLqUYy6HfIwsX9oaD4FBoz844IlOLJxaC2fb0PQLu0llZ4Ytz+iCekOtS6xwsJ4tEbp35wfIa2SDJq1W2COAXsSX3d+AgRYzqa4GtiGT14qcEzciixPe6N5qhm3yhhTLQIpmYMjiHsyf3QNDRGQpTVWPJR+/xH+AG7ofLkoJO254AkpBrrfbf0GF1h11zUYJ+B0qITF8J2TMq9eftocU4dnLS01eGPnTwbiFh7qCaA7JpnwfrUTRFhAtcaRxT3/UIIWKhpGAWxa8ipkAIXuUdwoqpXSrdWNw+09Irb51bXxQr30KnYZXPh/zkPST30zdUAFN08P+VL3XXw/mwA/C0sUG2g9emQA6J0+dpYXeEoUgJzrEzsN7JQSG9ZAu1W21ccGmZwlI70iI784FHraIHLGcEVQy8iuSdUc7evmkCGPc37T04h/XKXpkG9b1Z7GXiarwVIKyaewcJqYrTOfIsLrwBAdlxAzT2viEcx8YTzkTNZUuBJwNexhHfCf/krf6v7X40FB5C3aEC5QvmpxUxkimpxAAqB/piLcgUi+hhNh47NLsWSZyDhml51Sa1sCKNgpgT45IlldLPTyIyCnpUcQhQC8oIjbOvoByS2n6dXMLSrlVgaid2kFxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(366004)(396003)(376002)(478600001)(6666004)(38100700002)(31686004)(8936002)(2906002)(6486002)(8676002)(4326008)(7416002)(36756003)(16576012)(44832011)(5660300002)(316002)(956004)(31696002)(66946007)(66556008)(66476007)(36916002)(2616005)(83380400001)(186003)(86362001)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFdpYllmN1Jxa2kzVGN0UjFZTjdQa1oxT0JNUEpDRlBZN2VEb0t3VU9xUzN5?=
 =?utf-8?B?cTZxZmxBR3JiUDU3Z2p2T2o3bXU1UDhaWVEzTFcyNUxpSHJxdGFNd2NTcUZz?=
 =?utf-8?B?UjBCMzBpRVFrYTdaR3RnTFNZOFBPUEVJWnpVOWh2Tk1FVEdGVnVFRlNOK0JT?=
 =?utf-8?B?WHBQTnk2VHRFQjdCdE5aNEdMbW1SdzdVTjM5YjErYVFNcWFFTW9xby9lRVJC?=
 =?utf-8?B?UTRNYmJvZGMrdUFEMmZEVjVZSUc2LzREMVdBbWdxU3VnV3BNOE0rSnN5bElP?=
 =?utf-8?B?c2lJQStFTVlhK2RBODd3bEFMbjUveStpMzd1dE1saFpUYlVBcmMzczRobFlp?=
 =?utf-8?B?YXNTUTRVamIxNjVaNnkrRHc2ZFQ0RTJVMytscHVHcFQwUFJoa3ZxNTE5NGVP?=
 =?utf-8?B?OEgvTlRhcHlHbVFFMVEwcE5wbGIyOW1rbDUzL1MwZEROR0FRczJqUmdrVXQ5?=
 =?utf-8?B?d1dnZEY5c1pvWjhQbzA5blUrNlRacllrTTVnR2NQNndqWktzUzRacXdrZFBH?=
 =?utf-8?B?V0ZSYU5wSWpSVVg0YXdTQ2JjK3ZMN3BtQTlJczNRWWJ5andaOTNDNkp1UDJP?=
 =?utf-8?B?djliRjR6QXR0MkNpTDF5bHFuL240ZklnRU1NREZMck9QRGExN2Zpak9rNmlG?=
 =?utf-8?B?UENxYXFyUzdBRlpySEFBTWg4Zyt6VXM4STZkdHpYakQrT1JReEZSS2h1YktY?=
 =?utf-8?B?ZFNtMzA3cTl6OS82YkNRZ05HTU5nS2h3ZVBiZUZJNWloODR1TnNpVHJmM2xC?=
 =?utf-8?B?NHduSjZaZ0t6YmtVc2FmTEtiQlhhdHVUTkxpUjVaRkR4ZmUvNDdHT21DczRB?=
 =?utf-8?B?QlNrNXM5WE5MTGx2Wi8zK2RVWWEzR2lvbnBZeC9mVVQ0QVF1SEdkSnVlOWo4?=
 =?utf-8?B?QXVkSDFtNVlRVnk0MnNkUTZlVmxnb1VZQzQ0bytKVTFCRDBOWSs2UVhTYTgv?=
 =?utf-8?B?M1dLdWFCODY1ZDV0RTFxOFVrRGN0aUxXeWFUTnVjNEh5SVFCTElYZXJLQXFI?=
 =?utf-8?B?QkM2WEd3Szg4U2hMeXY2ajd1ZkZ6NzlHZmQyenBTRTltUTNoTGpXa1pYS2E3?=
 =?utf-8?B?MDFqblVOOXNLSkdvSXRWcUpFVEVvaFAxVmFZVWthQTJwZkttWWlwWFkwNU9M?=
 =?utf-8?B?MVoybVlwTXJBcUQxaWFIT3hVZVpiWTlZenN1cUtpMmlDamVvSm0rbGJacEYz?=
 =?utf-8?B?MncxSlc3RldWTWl3UExWNWtXZjFhL1QyNS82aS9sWGprOUk1c0lVaEIxN0c3?=
 =?utf-8?B?YUFKOStZY0h1dlozWTVOb05PbEpqL2NpOWlRd09wNGpuRWJTYTlNNHliM1pD?=
 =?utf-8?B?eFVITkZ3cmR0K09BLzB3ckJCaElKbkZvZ0JmaGNKQUR5ckY0cG1ZU0U3VVJW?=
 =?utf-8?B?d29WeUxsU1ltbXVvWXA0WFNWU1Q2cW5IWStyazVpeEwybjg3WGsxVUxMajV3?=
 =?utf-8?B?SE92OURrSHovMW1UWEMrTGRrZW1vdjhYY21HOWFrV21kU3IyV0VxNXRyc2dj?=
 =?utf-8?B?ajc2ZjFiV3JIajNsc1M2TjNzVEJTcVZwMHZrMTh5NmxKdWwxVUxOYndVRVd6?=
 =?utf-8?B?MEJTRVgxK1FOZjVpcGZoRFFrRlB1YjZGWSs0YnRZYXVaaFJuWFQ5dGQrcTEw?=
 =?utf-8?B?Z1ZIeE81cm1VakdRTitiK0JwWkVMbVVqK1l6b0NPL2VTM0lBcWgzQ01zY3Ez?=
 =?utf-8?B?YmZLVENjSklrTGc2TjlRYUdFeUJXRGZQV1UyT2hoRk0zT1hQZjhEc0I3d1Fr?=
 =?utf-8?Q?UZLRS7Tv5GqWE9D1xN+EhyjoAVbNzHuiv1+Huvj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c5cec6-3247-4400-201b-08d95877fa1a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 01:17:37.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ0UFJfnHxTubhg2VDGW1SixkmdGceu5m4D7eU9i/P9BWO8HHYmihmdDVYgsaGdXIMjZBHFmSh6mdmQaq5lTkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2759
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060006
X-Proofpoint-ORIG-GUID: iwqIXf6cCbK537Zcio4y0mLUaJ0KmU09
X-Proofpoint-GUID: iwqIXf6cCbK537Zcio4y0mLUaJ0KmU09
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The filesystem part of the pmem failure handling is at minimum built
on PAGE_SIZE granularity - an inheritance from general memory_failure 
handling.  However, with Intel's DCPMEM technology, the error blast
radius is no more than 256bytes, and might get smaller with future
hardware generation, also advanced atomic 64B write to clear the poison.
But I don't see any of that could be incorporated in, given that the
filesystem is notified a corruption with pfn, rather than an exact
address.

So I guess this question is also for Dan: how to avoid unnecessarily
repairing a PMD range for a 256B corrupt range going forward?

thanks,
-jane


On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
> When memory-failure occurs, we call this function which is implemented
> by each kind of devices.  For the fsdax case, pmem device driver
> implements it.  Pmem device driver will find out the filesystem in which
> the corrupted page located in.  And finally call filesystem handler to
> deal with this error.
> 
> The filesystem will try to recover the corrupted data if necessary.
