Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144AF40EB7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhIPUQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 16:16:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34430 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238005AbhIPUQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:16:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GK1Pjv009074;
        Thu, 16 Sep 2021 20:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=55kXh27D/RzvbR5I4kqmfJHJ5JL8yXi/hiazhE2glis=;
 b=J08yg8vkqaQ6OsnOTp+NvbphD+d97hDqGVD2fyD/VQciSudr2n4a8zTZXKs4rivaDF9p
 KHr6fxYMgGUwliRG19e2v2sZCpbp166+62fh5T/J0pQU/RsABNTOOv8wesEDKvtxw7Q0
 gz3oGJwNHpfMNV+WhGFWg7oISqRlwNnLCG4ImDALYDYjJaTIUdH/86Pih5ikXzZhq0xb
 +QDl1jml25/daJDv+rJABKtS9qR3ulXncLi+NogT42XbkR/56ZFH7PFqzwYvJkOPC713
 lXX6TR+NOQ499vX7OUjTHIbwSQVmk/p1Rw+STGTwOXCrF0v5TZdI1TCEJVRay5xp9s0q uQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=55kXh27D/RzvbR5I4kqmfJHJ5JL8yXi/hiazhE2glis=;
 b=L+ehajdo5wA2MDGv/ZrItXWzjetYoKw71nQzZj0A5ipOmEdmi9bKVhMbsKU0P42e907k
 +S7FAqxikKDFImbMzv8VsRESEXkR3V6F4nGnsQAzgN8mG4ffr0TrMb7ouHXYzpHt731T
 RfLzvG0a2/PKvslwWXsiuH4J76aPDRgh85FL51XKh9y57u56iLDrGiX1djAFUv6dSnRk
 6YyH08hBWGM8ivvgpJhIr3p97hQb+Y6ztx5Lt3Fp9tndamm30lwtWpFDacS2KF+LmxNU
 fTaAB67OXMhdOeuM2nIK/jx05o5vPQ3/EDr/ONndl5YZhi6/igo0nmvXCTidXEw7rtWo mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3s74m1yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 20:15:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GKEhFG040880;
        Thu, 16 Sep 2021 20:15:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3030.oracle.com with ESMTP id 3b0jggp2gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 20:15:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5t9Xl7lnzxfFmI9ZRBGOA3IcnlzhXHDNgks3Ntw9dE/URwoTdxDKtM/KPPB96v3Nl0sTQcjlW/Z0BPhq7hQntiBQ6un9u7ygIQ3R1qkNzOn5amiGaw2aB9+Ac1TEPiDEDUejKyInLTNzO0Wa/weZqq/UzwYrlreehsTDN6LBSKgRCRhxD1YFcz/idHD/qdwfamZ0DTwyiNEacV3XlwK2BKsPOVmEqvO4pjCl5asT+ZJzDXCv2oqvVtuxrCYNA+KnGppJntYZ1XB8tH6fC/JhZuHxF5G0sCkSwE+d9fI7OwXGo5dbt1d+eigjSH2mUPf4S+RGOOYy9Lij9eI6j39Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=55kXh27D/RzvbR5I4kqmfJHJ5JL8yXi/hiazhE2glis=;
 b=KM0rlwYPysYb66aAYs+AaK/jYwPbBKo+4ciqrJp2A4H49aRbxEAgmajihV0fhyW3mu9+8QzKYj+TJooG/sixYed8CL58l+ijXIqf+V2CvZRchLrBPH4bVsyJHAZ2Pb1lZcJDaRLsReW76bvY43S7CpLSQCQFUP8mDJgzFpXSsHoJ6qDsGoPevmvKhHPyISPS2K3pMVdUs1r3/+J9CnmtN8VbsCfKaveHf51h/x9MpaOQwlxSjc7fZvcOFY4UX1KxOgEquwSCc4TO3PYQ8mWXdZjzO61dN/2vUwOMBLVADpg36OpZbQ4xkhkvV+mZY/ZUbJGe7Gd/Cdw0ee2fY3zJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55kXh27D/RzvbR5I4kqmfJHJ5JL8yXi/hiazhE2glis=;
 b=Q7rcLyIdaWzVn8l1NWf1rk6EKLlJ6h4SMdYObOJkeVrzVCax7b4esUWMdyApC75SLuckFu3bnVwUiR5YMQaxj+UmUlVaMLZccQePQYLj3cmBCvu94zzWCrPbTB/9DYN8K23rLkl+HYCXi/Fv9+49p1Jerwnpx0HCw1H2GVcZAwQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5565.namprd10.prod.outlook.com (2603:10b6:a03:3d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 20:15:33 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 20:15:32 +0000
Subject: Re: [PATCH v3 3/3] nfsd: back channel stuck in
 SEQ4_STATUS_CB_PATH_DOWN
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-4-dai.ngo@oracle.com>
 <8EB546E2-124E-4FB5-B72B-15E0CB66798F@oracle.com>
 <20210916195546.GA32690@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <836693fe-99f6-3ef0-e100-0e5743b9ec55@oracle.com>
Date:   Thu, 16 Sep 2021 13:15:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210916195546.GA32690@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-65-159-219.vpn.oracle.com (138.3.200.27) by SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 20:15:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 071c3a96-ddf9-441a-c9c8-08d9794ebc72
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5565:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB55652EDB0EFF5FB97B6A46E687DC9@SJ0PR10MB5565.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvcjp3ySvRUKq75mxbPvgtv9bY/XykRXWi3hCCqiMgj8T5qUmcGz/ZsPCCIAHtsWI/yXZYK4AUBR9N24nELl3BlvKkSmSOh72Cr8kE2QlVzC8Wgb+HWO+oKA7D+5Gy9dp3I6QTvtn0Bcg67v5q9UzAg0IrT2O/hgYyhDohD5dBALSHV+ArMO7Z/U8BRpPd+bnrJ1GjM/UEuBopI0FjA3WsO0Xaa+hcs8Dp6Z1YEzVkB47b7h3GjYMVuTAB8n9z1Jj2N6VsWu3JN+UgiDSJ/6EvVYRYxFHxnMEIjPHKjdNR1aEiAO2DRFrcyJ635Iou0YsptY8tyhKNxGwMJ+SohVZzu19Ggb392GygVNRPiU50XtkRif2HVKteKzN0dZ7IjVT5Q11mYX3MpXS93JlwGDzIDHNv/LGDTGwN5xjRLio6FC0Dla+p24YewAr2HcPPDrdSgX7ZEQDNckUDUR7HG4VOxZmA8OJYA2v1aNeTs4glR37sVd4wGibmN6NxMgmZnZZMh6sUW/hrm23z/VdVxMJlMB3qwMvigE2anq/aI9zbq9RFJz4RZ1LDJ0canz6y20SM1NF5KDvytaQdgtMzRl+69fzVvPULPCwcPYw++besYEO1CDH2bHdahyDvvoNZ9p3IG3qJ6Y/NM90/RPbXy49xy02NpQxjk0A/3vurbiZOSNQAFWOXgZHQVFv6nTkvGub3WX2TooMMJFqi8RMVNdBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(6486002)(66476007)(54906003)(4326008)(86362001)(83380400001)(508600001)(7696005)(66556008)(316002)(53546011)(36756003)(186003)(2906002)(26005)(9686003)(5660300002)(2616005)(8936002)(8676002)(956004)(31686004)(110136005)(66946007)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVMvT2Q0UTZOeHduTzN3emZGNVVCOUxBK0pqNkVJUVdXaWRuYmY3ZlBWaGxB?=
 =?utf-8?B?UUkwZ1RSd0k1eWZDaC9UZjVaMXRnVTNQUUthRVFIT0JpcHpoUHdQK3dSc01j?=
 =?utf-8?B?OWI4OVZkRmtFZWg3RVY5ZkNlellucXJXOG9jc213a0ZVNlUzenJ1ZkZZM0dr?=
 =?utf-8?B?U0RVYlFsUXZwZktoczJIYXZWTXJvdlNFU2FoRk5qN3FYdXpVUFljNXpqTHlu?=
 =?utf-8?B?SHMvK3E5ZDBCNXdQN0VoWFViYkpmdmFic3Bya21lQkxFTno5aXkxRU54QVVq?=
 =?utf-8?B?T29GZGJCV3htNXgvak1sdHVqMXZuSlN4SCtqZWpQdkhVS3NyTzdxb3YyY2lu?=
 =?utf-8?B?Q2pxaDd3bXFodys0Z0d1dmJXTGV6aEdGaDhoTitXeU1pWXc1c05IekUrUkx2?=
 =?utf-8?B?SzQvV25nU3NqeDN3bDJRS0x5VWUxYno5R3VSOUpDRjE3WVU4SDBHODVjT241?=
 =?utf-8?B?YS9OdDFNb29JdGkrYWtZTmVoVHQyMGRmVnp4RG13c29qQ2U2d3NDSWNJYnVo?=
 =?utf-8?B?dzVzTk0wdjR2SXdSQUJ1cG13S0c0Z05paS80V25ldGFsL1VuakpmcnIwRXhC?=
 =?utf-8?B?WHZCSE9QbjZodTBXekJjTFZNVHRMTkVUcm5sSitTWjhRZHpKdGpEUmgxSkYw?=
 =?utf-8?B?SVAxaXlJY2QwbTJHYWdHeWd3TVdMd2VjTG5RU0xRWGptcW5TeTlBQUdvcmNk?=
 =?utf-8?B?b1lza2crVEcyNk94YlVLWUZkb3FadnF1cHZ5aWQyUGVuS3g2M2RNc2tSN3o2?=
 =?utf-8?B?T1lkNmxnSUIwTXVDZG1Ybm90M2k5SzA4MlRzcjdEL0liMlNDVEtNRzcxUWZZ?=
 =?utf-8?B?RDFoNjBoOXoxSFMrTDlrTnpqd25aR2gzcnF1U21XMHE0eU5kODdaNUkxbXNQ?=
 =?utf-8?B?VWYzM3lRRStaUFZKMzdqbUlYdmlEUkdYbU5rVC9SZFUyOUkyZmNNMXZqRHlV?=
 =?utf-8?B?KytTbFJGcENkWmdWZ0pMY3kySUlZbkI4ZThxOWdpVkFmWjJMNTg1T0JjUDEz?=
 =?utf-8?B?N1JrclR0WW11Nm9lcXlOdXBOVFk3dW8xVFpycmlDbGJpdmZDQTI5ZUFRcTFn?=
 =?utf-8?B?RVhwYncxSjR6TzIxRTBmU3JPeHlDRmg2OGRjMkFGVXZXMEJXWHgxUElzMWw3?=
 =?utf-8?B?UzFkbFBSNi8xNFYzWG03T3JRUTdlbGNkamdyc1VyUldnZ0ZZQUhEdFRaeGJG?=
 =?utf-8?B?WFV4ZURNcytxN014MTlvMVI3VmpFaFFRRU5JL1VRNjN4ajJieFRuNS9iVURj?=
 =?utf-8?B?dVZYdTdiVWh5UjByZWIzRGhYWEpnaGRWQkQrNHpnSTJ1R1B1U2tWck4ydklp?=
 =?utf-8?B?dlBXOUF1RFowM2EySTMvNXNFaVlPajU3N25ZSGVqRloxaEhHaFpMVzNOaElJ?=
 =?utf-8?B?YmtIVGhhUGxVeXc3UEU0ZmZWdXJNeUJvUDBxL0kzd2E5c1FYY2VORzdYTUhH?=
 =?utf-8?B?ZldCRGNXc2RuV2ZlMzBvbnUzblZQdHJMZXJWQ3hDQmNjU1A5TzN3ODlJN0hZ?=
 =?utf-8?B?dSs4TzNLTHBXY01zTXpBY3dIekZTZzVBWE5oZFhITGVkQ1ptU1BjRVREUTA4?=
 =?utf-8?B?YnZ1QXA1L2xqUm1IbVR0ejlyTUNXY1NNQ2dkaCtSanZKWU5JK0t3VnRTcGhh?=
 =?utf-8?B?eS9hY0I0Vk1ZRkJObm5Ob0N1Vm5KR3czWERDVGtra2JqbytvdkNSajFxQkh3?=
 =?utf-8?B?Y3o4Y0VIKzlkZG9KNm91TzZ0d1ZLVFpBZHo5Z1oyRzAxMUU3Vkc4QzFsdXpG?=
 =?utf-8?Q?nnLwH1xA63SquTjdOcaS0rZ/OakkOOTZeUgaAv5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071c3a96-ddf9-441a-c9c8-08d9794ebc72
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 20:15:32.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ga16SObT4A7oc43g4SvZSj0zva49P7Bcl113mm6vRQGYswpGoMuwS44l6ldCfZ9Lu3ZxNeQtj0qEGjjBGiXxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5565
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160119
X-Proofpoint-ORIG-GUID: OaNcCBaeVNINKaM2wHQGIEe1j4krRKWJ
X-Proofpoint-GUID: OaNcCBaeVNINKaM2wHQGIEe1j4krRKWJ
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/16/21 12:55 PM, Bruce Fields wrote:
> On Thu, Sep 16, 2021 at 07:00:20PM +0000, Chuck Lever III wrote:
>> Bruce, Dai -
>>
>>> On Sep 16, 2021, at 2:22 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> When the back channel enters SEQ4_STATUS_CB_PATH_DOWN state, the client
>>> recovers by sending BIND_CONN_TO_SESSION but the server fails to recover
>>> the back channel and leaves it as NFSD4_CB_DOWN.
>>>
>>> Fix by enhancing nfsd4_bind_conn_to_session to probe the back channel
>>> by calling nfsd4_probe_callback.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> I'm wondering if this one is appropriate to pull into v5.15-rc.
> I think so.
>
> Dai, do you have a pynfs test for this case?

I don't, but I can create a pynfs test for reproduce the problem.

-Dai

>
> --b.
>
>>> ---
>>> fs/nfsd/nfs4state.c | 16 +++++++++++++---
>>> 1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 54e5317f00f1..63b4d0e6fc29 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -3580,7 +3580,7 @@ static struct nfsd4_conn *__nfsd4_find_conn(struct svc_xprt *xpt, struct nfsd4_s
>>> }
>>>
>>> static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
>>> -				struct nfsd4_session *session, u32 req)
>>> +		struct nfsd4_session *session, u32 req, struct nfsd4_conn **conn)
>>> {
>>> 	struct nfs4_client *clp = session->se_client;
>>> 	struct svc_xprt *xpt = rqst->rq_xprt;
>>> @@ -3603,6 +3603,8 @@ static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
>>> 	else
>>> 		status = nfserr_inval;
>>> 	spin_unlock(&clp->cl_lock);
>>> +	if (status == nfs_ok && conn)
>>> +		*conn = c;
>>> 	return status;
>>> }
>>>
>>> @@ -3627,8 +3629,16 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
>>> 	status = nfserr_wrong_cred;
>>> 	if (!nfsd4_mach_creds_match(session->se_client, rqstp))
>>> 		goto out;
>>> -	status = nfsd4_match_existing_connection(rqstp, session, bcts->dir);
>>> -	if (status == nfs_ok || status == nfserr_inval)
>>> +	status = nfsd4_match_existing_connection(rqstp, session,
>>> +			bcts->dir, &conn);
>>> +	if (status == nfs_ok) {
>>> +		if (bcts->dir == NFS4_CDFC4_FORE_OR_BOTH ||
>>> +				bcts->dir == NFS4_CDFC4_BACK)
>>> +			conn->cn_flags |= NFS4_CDFC4_BACK;
>>> +		nfsd4_probe_callback(session->se_client);
>>> +		goto out;
>>> +	}
>>> +	if (status == nfserr_inval)
>>> 		goto out;
>>> 	status = nfsd4_map_bcts_dir(&bcts->dir);
>>> 	if (status)
>>> -- 
>>> 2.9.5
>>>
>> --
>> Chuck Lever
>>
>>
