Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC83E2064
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 03:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbhHFBDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 21:03:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27626 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241604AbhHFBDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 21:03:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17611x4S019408;
        Fri, 6 Aug 2021 01:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=L+whovrXxVDZPKNmj76y7G8mc7xjcBOQQqaX6rLUgCw=;
 b=LrOETEnbeU4ovqQV3b7Yx+is5NjDYvet5OVzfi6CTNaEx9ClQk1MMbFTs1FXJ2wTUEHt
 mEacdgzLYZWcENlH2jfMQbllLAXU0KOBSOxaWp1ynM395Qxyt37BPdg/OvG22hF8bLCk
 Y5TDeVg6Bd2cXNfYR4worz2DNpfSXldypD3rVEHW1Az9sMfP8JrAWmwnXSm7GSiwuoyv
 EwtfwFw9mB2DD1eTWNpJmiiiq4UsM1pB79MAeXIdIFFwrFax+QjqX0gLdHDAOCYR7g6N
 7vjcF5+NzGaNyCXOVxdgVA8sDtovAR2yi62uzucISfx8HuA18ZBqRQtMcG5o/Nd0YMNy xQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=L+whovrXxVDZPKNmj76y7G8mc7xjcBOQQqaX6rLUgCw=;
 b=i95Zzl/uwBa+2AeKCjI5PhHc9H3/fDSdEsxkqqeEMOirr+y7T4gza3c7dDcNqWXJcPGN
 pE5prfr4yRnO8itQ/HzbZ1m5NWPoelOpiCcWDJaN/lZJ//kVHxFpHh+cZLvbod/dajwl
 4y1lnn/5djBCi80llm1vFqkhT8PFmqh1FKfTWicjq3iiFV/mr/tbpjczYCb8/wdfrIXr
 QDPI93/wnqzaSxGHv92bAR+fplnm19yfVBpC/FPCGW9TvFOt3scTCAddfFFHmpPLQYgp
 z3cnG1euHXvgBtNqYtDMrlLWbP6+8qAGY3Qvqc26JkDi2OGSU0+shvNPyZG2ZZKO0iuE pA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq0e2d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 01:02:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1760xfVA095003;
        Fri, 6 Aug 2021 01:02:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 3a4un4t5pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 01:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVeo0TMQR26n/TKzOQ2xfNoJRobu1YhepYzr6iKKfRmDo1+dJGgFiB+yqfYlR/zrgZdSgnywUGfjExmVu8TBMiYtQkPyocPpoePYkcIt7XCNNngTZa9NEvoVuzbqhS/6xuK7YEUPC4ZlTmasdLR/YvFg7142/SmxrYI7bqhgAEwG9tqmwa42UBg1Elsm/0ERzAoLU1Sj29hwhj/Jd+QJ2j+l8UCWSiWnY/BiY8F6n1MGKQc/NOabLqtLK7XAKTBUldD9RY07eZmAgtqTVay8qSoW9inSS1xjCPPOJcO+h9yAkhxnSXhOm27zskNkAyweo/ZymlsyL1zm4z+LecXCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+whovrXxVDZPKNmj76y7G8mc7xjcBOQQqaX6rLUgCw=;
 b=dtpmVjm8y0kZG9epbzJq29UHJLewDViVDWDWaVuQDacq2MbNm64I3f0/P0g8OxOpJZqGHa6SnBitf8xI9KbhyXIJO2xImNpLvuwgK/Z/8PikoWmcmplY7/ZUkgS11gn/IznTP9AEA4PKTKDhqHwinyZyuvWzEszu+9QI/nER7A3vmHjqEegCEcKWPmmwQk6UuxKSB4ZeTUXqHpkFZjr7/nTChsTcq467xuoGlKcgNcXkpWe0R27yvrS2cCv//9LOZw2kJUuxxBB+EYE3onolgYD4DxeA+70p8RRDqXkvAl6BxoX3PqEooof4QD0ltGYcZcQAfZ4FCe47MT8d7Eg3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+whovrXxVDZPKNmj76y7G8mc7xjcBOQQqaX6rLUgCw=;
 b=CIlhczoJD313VOG5OjtB6ilos+ow9avsPyR95Ekv5yVRRyLbMgl1kUFwVd6s+0LHiuSX65HF6fcqk3hV2ifkf1XGKXglrRVjNfxSjVeZlA6C27Rf8xJU03YGZSqAAKdHEjaZEEE2i40SOfaZPi1ltEQ4Zo7UcCIFh5rNACWirMo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2518.namprd10.prod.outlook.com (2603:10b6:a02:b8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 6 Aug
 2021 01:02:40 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434%3]) with mapi id 15.20.4373.027; Fri, 6 Aug 2021
 01:02:40 +0000
Subject: Re: [PATCH RESEND v6 2/9] dax: Introduce holder for dax_device
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-3-ruansy.fnst@fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <e844fc54-113f-239d-da23-fa140aeea9d7@oracle.com>
Date:   Thu, 5 Aug 2021 18:02:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210730100158.3117319-3-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0011.namprd19.prod.outlook.com
 (2603:10b6:208:178::24) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.70] (108.226.113.12) by MN2PR19CA0011.namprd19.prod.outlook.com (2603:10b6:208:178::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Fri, 6 Aug 2021 01:02:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad4062eb-b50e-49d7-35be-08d95875e3ac
X-MS-TrafficTypeDiagnostic: BYAPR10MB2518:
X-Microsoft-Antispam-PRVS: <BYAPR10MB25186C8C0D15E6E15F00D21AF3F39@BYAPR10MB2518.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLl/YW4yQpXe+275ZtYDnjfsjxQ3KAnQNde8b80lY6KdTXNHVpegdcsccWO3d1d36ALDHQDRjlNBWIvEvelw9YJUJsBSNGbEELpWjfqqmPJ3vtPtw0M16Ai6+MKuBOTBiM17WYq3lHT8jGiWCeh2+X+IqH63nzAtr6I6ltSCc+i5ckbtJXMp9MrAWYG+rjBKvLSK9eADMaqiXvI2/eC6BJKaDuesTVz+7CJovLPmrzC8KAFQVt+a6Rq1rEDpq2cLRTXI8ip2OVnuSBqpp58XKkQrWwI5EmdmUoxw6z/YwjpmxIFxq8OSWCKntCnEtC6Wd4rdaSrorfd8skmgvZmN51eiV1fhz5mTQdwoM8kciygD8r2QrAdr65iIUG9T+ooq6wrt0ZI585AVZH/yNfeJhaJ7XFz0cpPuam3dy6+Acx7Fl0KIYSK95fQodqfJMu0UAiEC8K5z0lvGSsiWvzXQ8iKEaz85RSqHCsqUp1lokj+ACtHkD2SNUZcR0tyU6mRQ8MVGNjC2oLBVLVbxm7FICv14EVAMvIQC3xaoyVuar0UNcwJcUq2HIGzuhWsHFhkjr582ve66t2roFYaGVD9MIXk7GeSXem0rSu838fwYJ9NI5zdoioMM6cNp8KhDfo2QCnE+E6coeyIzZ/Su7cTgbbwA7+QjWPjxINBq0P3H10RqqCjhUY9iD4Esqx1aSy3Mz8RM7bTrGS1sD8aceFgE7CLdLLBF9WbxRZ9Up4NgjRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(376002)(366004)(346002)(26005)(8936002)(7416002)(956004)(4326008)(44832011)(53546011)(36916002)(6486002)(2906002)(4744005)(6666004)(38100700002)(31686004)(36756003)(478600001)(8676002)(186003)(5660300002)(66946007)(31696002)(2616005)(66476007)(86362001)(66556008)(316002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTEvVGpMdSsvN1JQWnZMczlBMlFRbWRpVW9WRUNpdng0VDNOYjA4OTkrVHQw?=
 =?utf-8?B?bjRPZEVTRXplMFdWb2xpeGgrUFp1ZHRKNWhMZmZzMlpsaFFQL2M5bFpYRnFm?=
 =?utf-8?B?TE02aTdlZ1R1RDJNaUNxN2RTT25nbjh5TUhHK1UrL2tnbU8zTWFBY2xBRWNW?=
 =?utf-8?B?cnJpK0w2aXF1bU1wZHdDN1RlTFVIdDJVQlFBb1lhaU84S0tISjlkck56WnJn?=
 =?utf-8?B?ZzY4VmU3U3V3eUV2NmF3MHVvajM0UnMvU0UxSXZQVDFXNmFOaXlSOHJFR3k3?=
 =?utf-8?B?UWFKWW5JV2NrbVpBdmFWcXVMU09JTEJtWFJWM1ZmdFNuUm1RZEd4S2JlRjlz?=
 =?utf-8?B?dndxbjRUd2d1L2NnRWhmeWxYTndvNlArTW92S044RHBXSDV5Z3VvU09WODRU?=
 =?utf-8?B?TEZqbnBRM0VKV3U4dC9lUi84ODRkVmJXMnlKNXRkbnl1Tm9lbFEwVjRLenJy?=
 =?utf-8?B?TGpKOVArRTE3Ukk4MmZXMnJtdU9FN3VNS1BjY2kyekZlNlduMTdud25WNWdr?=
 =?utf-8?B?TWIrMjVyTW9lUVBwSUdiVzJLV1ZjVTYvQmQ2cENXQmtJMVdLRzlLbWdYTU1o?=
 =?utf-8?B?VVpWM0VsclFzWEdCNnZuK3BMTkVFMDlDNEYrNkNEUi9sakNPbllJaGlqQ2Fh?=
 =?utf-8?B?NkdtV1NLc3RlRjRmRkJ1NDVMTEt2RkZOUWdZQkNHZk84MDVySlpyUmYrL0Vu?=
 =?utf-8?B?bHRhcEp3K1hKaUN5Q0lNcC9MOXhzRjFGQ21uZTF3R2lkbnZsRXRLRHpWdUNC?=
 =?utf-8?B?Y3JEdnk3VjY2UTc5KzBxeFBtT3M0Z1JVYWkwcnliL3lhWEY5S2RRU205MHp4?=
 =?utf-8?B?UjIyaGMxdUxNMDNCRWVxK09sbzhOaXNPRTJsbHE4cnY4dHBBL3ZzWm5HbkpZ?=
 =?utf-8?B?RzRuOUZkdERZRVFKMUNNbHAzZkJ4YjJNenZQSmtpUUs5Tk5RNmwvYTRhaW5a?=
 =?utf-8?B?cnFPZG5QR3BqYUNrOG04NmVpNHg5eFk3RmZuWlkxM2pEeDJZK2FzN0NrVHRE?=
 =?utf-8?B?dUZvNjhZNkVkR0ZZR1h2TXNPakNhcWNySTlrTXBwai9WMkNqVDNjOTlJTjR4?=
 =?utf-8?B?VFpRbkN6SEY0blRrVXA0YzdKRFhWSTBTbDR2ZnBIUGpPNmowbU43MHpENzhG?=
 =?utf-8?B?TlhrSm4vSU16MkhxV2w3MUF6VWovMkdwSlB5VzRyb1VhZEQrN052dGptcUcr?=
 =?utf-8?B?S08xNE5nOUhzN29UNlRVcDJzVTFWUE5sYjJkaEtiSm0zYUtkL0tMUlJJUUZx?=
 =?utf-8?B?QlFYWENVNHFHOHdwRm5lcFc5UHM2c0VxajdHamE4TlFZSXcrSit3ejR6dk5D?=
 =?utf-8?B?TEVubE1NbnIwL2pSbmthKzd0Y3JWbnNWQ2FrQTFJaTJtdDV6WGlBODhmL29v?=
 =?utf-8?B?N2t1ZVNyajFLakFRcTdoVFNFZ3p1d2pYYW9LNXpqSTIvVVZIQzdVY2owcEUx?=
 =?utf-8?B?Uks5b01vdjZEODVTc2hkNHVQbncrVUNUeGxKY1JOSDYvZ2pmZm1JU0JFZEJv?=
 =?utf-8?B?cFFpYStGbS8rYUNYNCtCSXFqVGRkYVhYT09IUkUvZXV5WmdGc2RuQWhxcWV1?=
 =?utf-8?B?WGhnKzNjSjRrVW4wMGw4RFJmNEMzTll3L3RuZWtGakZFVDdtQW9XTDJrVStT?=
 =?utf-8?B?dUd6L0hHWjAybThWa0ZRV3FXNUhPUXdXeldJNEtuVnBaUjc1MTg4eU5VNTNV?=
 =?utf-8?B?Y1ArUDlhamU3ZXFJUENqODUxQjNMK1ZLaStZSGJ4bXlubDlDeGNaMFJnbkNx?=
 =?utf-8?Q?IAnJuGWor1R1Z1KFEIvMAEeYjKoz4KZbVpPUQKs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4062eb-b50e-49d7-35be-08d95875e3ac
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 01:02:40.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuvZCJ82o+qd5wJRReVcZ8ryzLU/2dbNussUvyPWaPN+mdx9Aq7QyE7dFcLMKRWfauEk+g7ZgsgTEFKFJmA9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2518
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060004
X-Proofpoint-ORIG-GUID: hE2eVNFUt4OYE7Be0ektZlSPKjkMY7RC
X-Proofpoint-GUID: hE2eVNFUt4OYE7Be0ektZlSPKjkMY7RC
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -214,6 +214,8 @@ enum dax_device_flags {
>    * @cdev: optional character interface for "device dax"
>    * @host: optional name for lookups where the device path is not available
>    * @private: dax driver private data
> + * @holder_rwsem: prevent unregistration while holder_ops is in progress
> + * @holder_data: holder of a dax_device: could be filesystem or mapped device
>    * @flags: state and boolean properties

Perhaps add two documentary lines for @ops and @holder_ops?
>    */
>   struct dax_device {
> @@ -222,8 +224,11 @@ struct dax_device {
>   	struct cdev cdev;
>   	const char *host;
>   	void *private;
> +	struct rw_semaphore holder_rwsem;
> +	void *holder_data;
>   	unsigned long flags;
>   	const struct dax_operations *ops;
> +	const struct dax_holder_operations *holder_ops;
>   };

thanks,
-jane
