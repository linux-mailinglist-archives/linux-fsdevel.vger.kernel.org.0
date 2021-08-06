Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760D53E205C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 03:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbhHFBB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 21:01:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55004 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241019AbhHFBB2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 21:01:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176112Et028188;
        Fri, 6 Aug 2021 01:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yPDXpTQTo21cFs0k30WFJl3DpjcVtk23TiFVjusm1E4=;
 b=ydEj5Lh79CAVbP6cRj6Y04K7izYwR9fKavfSfkWuCu0i7dD8zoTKiTksQwOGj7qr7cjI
 3QMKV/F1ygNMfnnk5pDjGk6Ei4vNQ+l0b2zZgvW0FAZakYFVOUP7wbeKnIeOdE7l3tfb
 zj0SHpytTur6S2XkPvFnys2Mq71CcS2JFBUizNXbYBkDCDzziuKO/YCLSKD3Z0V06a5M
 a+QJyDwilojZBINs5NYmbVdqtuql5EU9qOy6/olSFKBoe5ZBehF6B35rM9BjZ5q215Y6
 aWc2P3VTSKndeGbpNSVTFmSNgt76zt44UOR0y806iDeODhErGI7oUvUi3X2SHGD/7nWa iw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yPDXpTQTo21cFs0k30WFJl3DpjcVtk23TiFVjusm1E4=;
 b=Y93rijOtKBnclnDvVnQ8/EbJqrIGCUH4YV83OWdCo54InQ1y7zPtTX1I+q44mpprMN3E
 EmMcyJR8iVQrAC8gTFJuOHc7XD292tf3QaBtTfDGqPTQEAixpMGfYONRXHW8ltjfPWKw
 /M0Zl/MB/ks4We1+RhXH+7nk6JXhnCEn4z/VOs2WE4bPwUVVcPc6H07Xs1/XwucNdYpq
 nXk7xEA+uPKDzt4af7YYH1lxN8gaJNvFS0W26Olq2JpdosZAV2CKgK/8/ICH4tOM/z5E
 q/MKOWSXBcgP8cOO7a5qe3nRh/68eayo/5wzbV6Ny66+QqK5uow4SjkEh9IOkfUMVQYB nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7wqubpu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 01:01:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17610Ars184188;
        Fri, 6 Aug 2021 01:00:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by aserp3020.oracle.com with ESMTP id 3a7r4apyc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 01:00:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDw01on1n4KoruQ+5Nk8Uh4BqpHjjiI0iMx8voaTXJvlMoDkGYzoA5G5nj0r1vCTKrWA22CsIqLXZM1n/2P14zdyxl0kWJSIlWcAm1McL5x3RhoaUdGYB3i9pFmIyJZYJX2V38kBqwNPmLBj6QKCnOuOYwvfycEG0ktHgF3gnGwrzeQckbtjnDDuyxpGru91SFdMUciyS3WkBIcdkTJ8mJEwiQqved/i3RP16wddAd1lQCn2+qWkykQ0/Ceh85MVA2R4oWFljsWflQhZ1SzoiCPY8AffPNQlbB176dLFN4NZwcjd+V5Fkny0wCBbeIVJ0l3QfRMz9L2iWR+NxsAXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPDXpTQTo21cFs0k30WFJl3DpjcVtk23TiFVjusm1E4=;
 b=ek1TFPQ6BEmlHVDcmcqkLO8qi/wBqBQIPYQ887DDAse70eXkUFPTtYR5n5eAWUMK1Lc9dhwA6wjbXonTanNWUlLTcT6l2m1ImR5luGAi0JY/i9ZQ8JMkR3Xr4bJOHGDapjc5If2L31l0cAXEw1tFyeecrrFHs12aWCjnt+0Y+yI70S3I3ok1Qk4clc+GZa6W/BwiOEhx7qpOlKxTlybd9BUcwGsYNBqsiNUEJSNL1PjKFjWE7qO7LzI4HaBIF3ia6upm8o/VnSdkAjiTwRoX8JL8f5FjigW9QMNtmkaFiPvpdPBQhSrXdR1ChpxuAgCJwOG7oV2EvcqZiuhqWg+q4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPDXpTQTo21cFs0k30WFJl3DpjcVtk23TiFVjusm1E4=;
 b=wGzWcWzWgBDerU1JeYTekpN/o0s2iN5buBOtVkJUp+XlJ3i9msDR7TT6yIVF4d4N40oVG/e4JKFIx7pxpoyOFULfRim/GdE1hP6pn0F4MCFIoCEQrnXhnpVqbnaxTSQMgCY99xSRs10jtzWCvNR6zpsH1OEZ6Jvq6YEbHWtJ7+E=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2712.namprd10.prod.outlook.com (2603:10b6:a02:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 6 Aug
 2021 01:00:57 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434%3]) with mapi id 15.20.4373.027; Fri, 6 Aug 2021
 01:00:57 +0000
Subject: Re: [PATCH RESEND v6 3/9] mm: factor helpers for
 memory_failure_dev_pagemap
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-4-ruansy.fnst@fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <a5580cf5-9fcc-252d-5835-f199469516b0@oracle.com>
Date:   Thu, 5 Aug 2021 18:00:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210730100158.3117319-4-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:805:de::26) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.70] (108.226.113.12) by SN6PR05CA0013.namprd05.prod.outlook.com (2603:10b6:805:de::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.4 via Frontend Transport; Fri, 6 Aug 2021 01:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e106df5-e72a-4800-c5f2-08d95875a5ee
X-MS-TrafficTypeDiagnostic: BYAPR10MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2712496B605482D42FBFE44BF3F39@BYAPR10MB2712.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilsREwpHh6vvSvMX+dqa21Kiln2AX1PXBJTSDp2RY2vDVLFJCQIKd8R3eKbzDDmm5cixZ0ilI4gN6rFN8dpDNITllWgrHhKuL8/wdA9mNNJefE7jMcep7EPutwxPNrNM2s+rdE/JxwGwre26wusQVTX2+j6b0AUI638vy8sPNrAwCqixRJBzPdJlEK4l1d7s62pV++12c5bSL3maRzDXHlqli197Cd/usNJKSIiPW906knmBavOd8fke7Rse3VP8WrLVPe7Cj0AgQRRemYkj34o3Cz/5F+s4aYA+q7UEkmAVuWz4g+XPwdmAnAD31GtWglxk+8JAJiN8hIagTA0m+kBpL23Z5KTUxjFSBkWKgDftttftXLt/jxIt7Z1PWoON6DQ0d/zVQ2vtrNc5KWgu7xWFZPrMIJ2bpO6Xa0QaOzS9IBXBiFLK1P+7FmirLP7uFjoA7fzlSCityfS3v0+2R0YCIbAku59WsyZ8BWjZ9pTtxPkmCERL7oJviUW1PnsMUtGOFOvoc0oW1qKnvzyQEFR16WErn7116aHFFUb8EwvyRJvKT5ZXo6Bte0Lb53y1txi273XXij42Ef8LHO728m8yqx/vz98NetM/i/1e1uAF7yh4eoGrbmAJVd1HcduCguU/ntvWfFtdzHvD12ciK5rrK/j6SQr2wYpbVUhGUbYI4D/9bkTNWbcGgDMXkaGCDezBD0cSP3Z3hBGYekG0jZCO92NTjs41ymH+B4BjUF0wBErNKoiDjDLYdYDjtaEj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(366004)(39860400002)(83380400001)(8936002)(7416002)(44832011)(956004)(2906002)(38100700002)(53546011)(16576012)(6486002)(186003)(316002)(36916002)(2616005)(26005)(66946007)(31696002)(478600001)(36756003)(8676002)(66556008)(66476007)(86362001)(4744005)(31686004)(5660300002)(6666004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTB4NnlJUCtYKzhBbGptU0prd3o3MDNhYzBwUDI5ZG40UU9tTkI3UmFJZVla?=
 =?utf-8?B?ZzBYZEpYaW5iNXhCME9IOC9YNTh4WUNFZGs3T01mcVhleFNNSjZZKzl6VmRi?=
 =?utf-8?B?RitzSDBMNEM0S1lYdDJFTUQ1MG42T3lWYmgzM2RSNGZKcmZLYWNURS83cERE?=
 =?utf-8?B?MDhrT2dPcitibTNHTkpNRzRWcE9CdW1DSGpHTy91cHZ0UEFmbGNnMWFJV3Vk?=
 =?utf-8?B?eFNWQVNja2k0enBlaDFYanFDYmhJUlNncGdhY1ZOMzJlTTY4TnhhNGJyNkJ5?=
 =?utf-8?B?OXhkK2lOa2dycFdRY2x5M1BkNnF3T0U1d2FnK0ppTHdFQ0JRUHJZalltbCt5?=
 =?utf-8?B?TDQ3YjNwOWoweHdLVnl0UUNFQ3QwcDh3L2hncWZJQVZ1R3RFZytsRjA1YVdV?=
 =?utf-8?B?MjdaUTlxTGkrK1hOOWJKbUltNmRRbzY3UnBpcjhGOWRnRTA0WVhnc0tadkMx?=
 =?utf-8?B?Nk5LYkxubG1yZ3Btb2F4eUFnNXNwSy9pQkRENEZvVnZnTlFwV0lGRFdHRUVz?=
 =?utf-8?B?Z2Q5THRwTndsNTFHNitMd0NmSTBRUkdPNjlTcUNiK2hSZ0QxVEU1SVNlSGV5?=
 =?utf-8?B?anRFc1FMVnFJSnJUNGt6WHRydWZwbWVXaDBPWFhldVZ5aStzNmlrbXVmK3hh?=
 =?utf-8?B?QUYvbHhrRzVCK3A5ZG96OVVpeUY4WUpZZTFVeTNJYjR0Nkh3bEE3MW5JWGZX?=
 =?utf-8?B?V0ZBcjFoY1JqSkpmK1VRTXFwZE1MdUZsdm1iTXlOYjVreXlwOGNRMFIzZ29w?=
 =?utf-8?B?Z3hpTWlYUGtlVWRlN0s3NFNsWHpGUHdkdU40V1dRSFNRbVlVNXpLem9SN29i?=
 =?utf-8?B?QWUvQ0l4aXMwdE1jUTVkSnM5c1dSWHJCN2lYM2NqZGF3NmtXUC9GWXBYYWhp?=
 =?utf-8?B?NmZpWVh1ckw3VFI3cjlWNmhmVXA4RThUdGVOdk9xTEh3UWttMUZ3Q0pKdXBj?=
 =?utf-8?B?Wm1oMmJhOW1PaG84T2sxK2taaGVjd3lTQXJKQmdlUyswOGJPditRODhrZGxT?=
 =?utf-8?B?NDVzVGhDaDRnSEVPK2ZxVGtEZ2I5WTBKS2FQMEtTbW1RdEd2UXBqcTdGRk1y?=
 =?utf-8?B?K01JMGl0bkx2VFExU2hnRkJyT05SeGZJUDJENXdXTUY5SndMRTY2VjU4dWk3?=
 =?utf-8?B?cng3aXNtanEvbWJYQ3VNSitmODNsTGs1SWN1cmh5ZmFCVUhqYU9MeGo0MzJv?=
 =?utf-8?B?OUFOSmxZc3FjQWl5UmRBclUrRVdJTkdmTjdtWjZOZ2NSaVN0N0RCWUVCZDFU?=
 =?utf-8?B?d3VvKzQxeTVJTWdpTTducks4TmVteGJ0ZkRVcnkyMitKTnljRlhpOWYxWjlw?=
 =?utf-8?B?Q0FSZFliTHZKb08ydVB6LzBNMEVwOFpIQ3l2SFRKemVHNTZNRkI4bGM3WlNr?=
 =?utf-8?B?Zkd1NXQvVXZxazJpOWx3TFVmbXlldHZxTFhWSnRhK2pjN25mZGRSUk1oZ1dK?=
 =?utf-8?B?Ky9lYUdWekYyUS93NlFwQTBxYWljU3ZwbHpKNUpZWnU5RllwNEhqTGhFYkFQ?=
 =?utf-8?B?ZUt2cXhhdkEyQ2RCVURFb0RpQ3A1Z2o5MG4rcXNrYWVQV1JBcFVxcER5RWJ6?=
 =?utf-8?B?dEtvbVZPSDhOUkpjNXJhRlM1ZTdNbVhmTUkwT1cwaGFtUHh0ZXE4T01mbU5q?=
 =?utf-8?B?TDMwY3VlZlhBNDlKcU9OdFQva2Y2WTQrYU8rTjdscHdrTFRieHpuRlFzT3Fm?=
 =?utf-8?B?NmN1Ym9iL2NQbXFRTVJFSVBSRjYrT1RDMFlrV2tHdnA0RlN2Qk5rWFIzZi9F?=
 =?utf-8?Q?z9qp+hgovL9xN26gaAlc6+2l5YY/AIhNDcivbBD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e106df5-e72a-4800-c5f2-08d95875a5ee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 01:00:56.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKQyeNAO23LPrvSyLmwK2VD9ln/bOAznFEYG12crnDORxEVVvwDL5/4twxubKyAh9h2Em9BYPHZgvPYccGiLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2712
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060004
X-Proofpoint-GUID: qX5BLRTE6Ck7nVaTfXshSA-VOMU45SDF
X-Proofpoint-ORIG-GUID: qX5BLRTE6Ck7nVaTfXshSA-VOMU45SDF
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
> -	/*
> -	 * Prevent the inode from being freed while we are interrogating
> -	 * the address_space, typically this would be handled by
> -	 * lock_page(), but dax pages do not use the page lock. This
> -	 * also prevents changes to the mapping of this pfn until
> -	 * poison signaling is complete.
> -	 */
> -	cookie = dax_lock_page(page);
> -	if (!cookie)
> -		goto out;
> -
>   	if (hwpoison_filter(page)) {
>   		rc = 0;
> -		goto unlock;
> +		goto out;
>   	}

why isn't dax_lock_page() needed for hwpoison_filter() check?

thanks,
-jane
