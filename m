Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6613E2041
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 02:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbhHFAs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 20:48:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20962 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243103AbhHFAsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:48:53 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1760l0gU017673;
        Fri, 6 Aug 2021 00:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xKu0U9AqWkVHNttDXzKrVfVUdcPuH+YVcIrPXUIS8HI=;
 b=ZNLCZ8bag2I1M28kikyhioFUAVzO6YFqkRhAuME5egFCxe2Li4qYRNYsli+RJdca0OiT
 WDKSrFzc50Nn61OqhS77IGiDzThO1mC31trVGeBxg81Jnm21BOLKonXPlN3UhlZCaoyq
 PSKVrV3Vrt3wKtQ8NEKJ+bbbbw0EtzUWZPgDf393Ra7c9j0hUJMcSQnvDXCi76WDTi9i
 Qc2XSrmB81ZI+FqnU5BLcpwSg6QqegOPCL6IYm7nWQPp+URw2SLj8gyGReszHftTLQYG
 mB5sbWBIMODFPPIbUDMEUMZ4crY8CrFXNstDFhsMyjpE1kyeWLOpU5ZaX+KV0xeaj7AK Dw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xKu0U9AqWkVHNttDXzKrVfVUdcPuH+YVcIrPXUIS8HI=;
 b=eM2GbscpuptqTn80XJsEmXJTApMU9PjEHdWBz7G6CnMJcHBzOvK9tPbv9EzVVtjTIi0F
 Z1JRWb+Qm4/wQ/vyCc23LeVokSnk/KI6Caj0t5Hm2n0ipd4g3Z5BfCW3ZgnFyuHuY/Np
 A/vKFH4hS+HPUlw0K4SzBjmwYZ4WxpfLoawuoDuKvSHd5Fi1wv94lJpXqOaPqM0Q6iJc
 hbUgFBPXgo7uqZf0eD18pgkE2QXyXTKBCrWHoPYcf/jc2xOZxas/i4480dEKMC4MpXnK
 jFlEWvH1EPLEL2hoXUNrL5RQ2jVsSwP827a2LV3VeCimYD8Crj1z9K9TqCCjFNE09RlK Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7hxpnemx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 00:48:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1760k8M4154613;
        Fri, 6 Aug 2021 00:48:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3a7r4apgqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 00:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjePZrDbBykMO3cpJ2U2+KCYTeZDmiMo/A1ODFFdjiJQqFEqCUYyfEjbOVgN5i6REqDUgpsTsHcZlcf0M656hC2hIeSRPFt34iSFQS9eLs6u7i6sWDibnF72FlZ5bhuZXD8wkZZ2kEintwxpRAvCiE0n9jJ+LzTUrpZM9PjZLp4RLNsZlxmp93usoV0YoTpaplaz54509+1SyCPzx06Clfq8AbK8cpgWgkrsy4eMm+Nxflm50AjTeUE18l/SiHYkzUksM9jwzibJEVI6DyjQgjsvBTOFyJB+YLfZte3J1EW8F0CYeWjYRgxlp8ehuJKHKzalEWNbjrgSV3kwb1K8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKu0U9AqWkVHNttDXzKrVfVUdcPuH+YVcIrPXUIS8HI=;
 b=jC7wNJKsB4QDZECMOrjy9FgI8K/56QviplLId9U2V6YiNWUEJ5MCkz2Fqj4AP65xw3sL4l6somfP5lorIfSideu/8VnznqhG20Sm8QQzhMF7PSlVtL4tsVdN1V5r+f0kgqPcWQGN/0LBQSAggFLR3x713bmcsFRXRoe9ZWEn1FwM3VcGUIgqtzN8oWQZ6WXDto+pHTXDadiOw6BdDLdTm4WElxUhjG/Ilz7axBcMNb3ZfquJdkRS/0bGFT3oJW1fyxRt3HdFg69tVpzv2Zl9uBJvjLsOMP2jJyIJQQ/BaQXKUWeNDNub53gu7NkoDQv7pe6WO6xjrtTiQJQNRo9tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKu0U9AqWkVHNttDXzKrVfVUdcPuH+YVcIrPXUIS8HI=;
 b=WJLDAKOqI3VVahACAZawGfREdXv7uwmnk9C7HO45CIm2KinG0yuMJsBaKipC5EGYvfnTKbL0+ebKkR7SMDm8Ma3LUdakfrAMrJUcycJz4opI/b2vojoPNweIjqlKxCAMPTu4OdYJUyV2kmRVbpeU+8v1CAjIusYxqQE54ux9Adw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Fri, 6 Aug
 2021 00:48:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434%3]) with mapi id 15.20.4373.027; Fri, 6 Aug 2021
 00:48:18 +0000
Subject: Re: [PATCH RESEND v6 8/9] md: Implement dax_holder_operations
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-9-ruansy.fnst@fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <4573e358-ff39-3627-6844-8a301d154d3e@oracle.com>
Date:   Thu, 5 Aug 2021 17:48:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210730100158.3117319-9-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:806:22::26) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.70] (108.226.113.12) by SA9PR13CA0051.namprd13.prod.outlook.com (2603:10b6:806:22::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.11 via Frontend Transport; Fri, 6 Aug 2021 00:48:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99662a5-e7b4-4b64-9b1a-08d95873e1ef
X-MS-TrafficTypeDiagnostic: BY5PR10MB4321:
X-Microsoft-Antispam-PRVS: <BY5PR10MB432135FEE98B00F34B0EFDC8F3F39@BY5PR10MB4321.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kruVBsMvieZOjI00nRs0fKQ3Rc5CiEl/h7SEGT7ZBlXp/Cyt4ttVeDP41/yGQOYl3BqbyLoS00L/Cdx8wENsZA5uzf2vQmdAoDqOIA0b4b2GTfQfllBRhSB4gMin+peXputApCFvVp9WK7oFaQt/l5BxY+9L4Ouvpk139Hv7jy/fnVk5QYWtZslyCjQWBlbhRRpxOdPQOPyoBhVY8s1s0leCyLbYcGor5HHp9nPXLlDw51Bqr7HdV9bEDRAKzBpIgwaj1o9/MVF2Xgc9duhImUzoTqgBaILSs7EEDqOtHSGxEaglrmo28hAoRS5qcKuv5vglwBKujEmaHHrD9hh9FgVwMG2p8i/UeH9TOc+dNmGzdC1rNUI9vp6AtSYZmwaDRrcGzpicoxp1VDweMX/NiWOJ2vPk076NxUUJQM6rBDYuU5I4jVEl65B10UmXZhhUDXsWS8mxmhij286cH0mV8KtFEuFUJDY9xh9ES1fyoXfmNc7BYVNyV5GaSt++ELBpJJfWYeuhF6GE2ViaeIuIaPVUWv4ZtbaDnSBgGW8iMfc4ntXW5/9vw61h7aOBOlkK+IUfYA0nAK9YSeMKgaPWx06kGXNBTSQYmnkcYj4YzkijwD3I46eOyRHIMPVqpcPHiVmA0VIVvsPKUuS41qUUhbxXTO10SWJKRSItRfSbT0oc6qiLakAOAK4qgqpZsxkGtYEToO7q7g5Nbd9UTjsYGf3iQEIM3OUkV3MkDVGOwPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(66476007)(7416002)(16576012)(66946007)(8676002)(508600001)(38100700002)(36916002)(36756003)(8936002)(66556008)(4326008)(31686004)(44832011)(26005)(5660300002)(83380400001)(2616005)(2906002)(53546011)(186003)(86362001)(31696002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRieHRySlV4S0lqMlNuUTRQM2xROGxZS3U2a3V5VlNFRnEyNjQ2U3Y4bzVD?=
 =?utf-8?B?aEpzVEh3cTZTcUlBbVJDNkNsY2paRWVGTHo0SlRtYW1sYXY4ZnhrYkw2ZEFh?=
 =?utf-8?B?SVpRcXRIbUNnYzVudDJMVStROHRnKzBvRGMvSHZXYUozR3J5Yld1TDZKQTFO?=
 =?utf-8?B?c2cralhtQ2d1ZVkwc0hWc29peUF5ekZ6NU8wbXdKTlpQQ3JLVXpiU01Sd21H?=
 =?utf-8?B?Z0dpeWlMUkxGQ0ZkQ0V1RkhZTThjSkdWQWlmWnhWUmV0ZHhRSmlDcm9DN0di?=
 =?utf-8?B?MWYyZENTeVREcXFoY1FhVlREYWNGaXAyZVhwYTZiZnJXbnRQVWcrVTlJb1Nu?=
 =?utf-8?B?eitjMHBTNTlaemVQeTBpQ0VyeDJNQU05Q0lsTGJXOForRDlScUtFWnJIZ3lL?=
 =?utf-8?B?cTAvb3huRkdZdTRCczlGcDZvMXdULytSeG9KS1BrWW5vYysybWxvcVU3OVcz?=
 =?utf-8?B?MG45RVFMTlVKcHRud3dCb0lYSWk2UitqWEkweVN4S2tYdUltUG9veEIzdy90?=
 =?utf-8?B?NG93K0dBUlhhSktGNGo2TE1vNkNwMlZpU295VzJ3RjJnc09hbEFYWjBndmsr?=
 =?utf-8?B?ZkM1Z0JPM1hzM0xMdEZpdWErUlMvbDdlVWN5bCtqZ1RucWJteW04eHljSjIz?=
 =?utf-8?B?TXV1elo0WVRpUXEwbXpxQnRDUy90TFVJbDJsQ0lkclR0d3BuV1A4dTVsaWIr?=
 =?utf-8?B?citvS0FhbjVrNWFFc3IwQzJyOEo2SWRCb2pkYS9BMDdqSTlZTUdKcUMwQWhN?=
 =?utf-8?B?Wm12ZnRFci8vUFZTbTdrMS9XckFrczZGY0pZdjdRL0g4V3BkSGx2WGRTRDRK?=
 =?utf-8?B?ZlJEU1JSR0pySm5hcVZNVmMwMkFGYStUd1lJemlmUkZndURqQUoyMXpoQkE0?=
 =?utf-8?B?WjlPQjdjV014OVhvKzh0Lzhic3JicHpjZ3VJZnFvZkdLb1MrWGxDaWNsZks5?=
 =?utf-8?B?d1BnZTlWeGpQT01ZdVRreXl6c3lEL1JobE5ocWxkVkU5UDlibHhrZklKYmtl?=
 =?utf-8?B?MHoweGQwMlNzRDRBYnJhcko5RDN1dm00K1crbnRkcVNYNm53SzBjK0tvck1I?=
 =?utf-8?B?WWloS2twdU5JVVFieFNhTzBMc2xNWlZrbloxaGpvbS9LeXVSTVJSYVoyUFpM?=
 =?utf-8?B?MnlIQjV0eXovVUcwMGJadkhQcnVkYzVrV0lkZEtGaXI1RDFwNVFSOTAvVmR2?=
 =?utf-8?B?a05xL3hMOWRLQzd4UXV0NUpYNkRTYW0zN0tLZzViYUlaUkJRR2VmZGVUMnRQ?=
 =?utf-8?B?b0pmUng2THZQTEhmUVBVbzJsWk5nQmZiZDRSTGlyam5JLzRzWGpvVU9Lb1ZK?=
 =?utf-8?B?RXkxcUN1U2F6YWU5dmVrUWlrZ3JnMDBLRXVEUEtCMDhGOWZhcGhrbmZaNUxK?=
 =?utf-8?B?Z3pkdHJrUnVOVlVqVU9QZ0paQWlnN212YkZOOHlrUGUyZkwwckh2QzF4NmEz?=
 =?utf-8?B?cS9obTJhR2dZTU53djJadUROd2pyWGxLKzZmMkhSZ2Q5VFpiSTUyd0JVODZ0?=
 =?utf-8?B?YUdJZ2tXYTRhV3BsempKTW5leFp5OWlGTXpkZTBQTTVqajV4Z2creUJSTnRQ?=
 =?utf-8?B?NUlTMW84OGc0OFA1SmtXbkxFQytYWUZPR0VrbnpXMGFJWkZwdFRNakNDSks2?=
 =?utf-8?B?b2NWRHZvdXZQUzBYNVh4QUk1cDVRWmRKelRkNHdQc0xNcU1jdTBmajZoQ1RB?=
 =?utf-8?B?ejMzYlp0Q0wrb3hidjZNNTV2dUh6WGpVaTBpM0hIQjlZY3kyNm4ydU1hWjkw?=
 =?utf-8?Q?lIKoBxLkkGnfgDgwrQ8BDgmituTc9g9vuR+PKXk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99662a5-e7b4-4b64-9b1a-08d95873e1ef
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 00:48:18.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abj5waKFgUjPmpwwm8E1hLHxoRk6M6OJd+QAV6owW93teHrQqVZHgrXtc9n9aFfvf5vOj733MKnLaFLJAJYQqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060002
X-Proofpoint-GUID: 3kSsb1KYS1-uSCbOBlSHjPE8WY3E7OkB
X-Proofpoint-ORIG-GUID: 3kSsb1KYS1-uSCbOBlSHjPE8WY3E7OkB
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
> This is the case where the holder represents a mapped device, or a list
> of mapped devices more exactly(because it is possible to create more
> than one mapped device on one pmem device).

Could you share how do you test this scenario?

thanks,
-jane

> 
> Find out which mapped device the offset belongs to, and translate the
> offset from target device to mapped device.  When it is done, call
> dax_corrupted_range() for the holder of this mapped device.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>   drivers/md/dm.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 125 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 2c5f9e585211..a35b9a97a73f 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -626,7 +626,11 @@ static void dm_put_live_table_fast(struct mapped_device *md) __releases(RCU)
>   }
>   
>   static char *_dm_claim_ptr = "I belong to device-mapper";
> -
> +static const struct dax_holder_operations dm_dax_holder_ops;
> +struct dm_holder {
> +	struct list_head list;
> +	struct mapped_device *md;
> +};
>   /*
>    * Open a table device so we can use it as a map destination.
>    */
> @@ -634,6 +638,8 @@ static int open_table_device(struct table_device *td, dev_t dev,
>   			     struct mapped_device *md)
>   {
>   	struct block_device *bdev;
> +	struct list_head *holders;
> +	struct dm_holder *holder;
>   
>   	int r;
>   
> @@ -651,6 +657,19 @@ static int open_table_device(struct table_device *td, dev_t dev,
>   
>   	td->dm_dev.bdev = bdev;
>   	td->dm_dev.dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
> +	if (!td->dm_dev.dax_dev)
> +		return 0;
> +
> +	holders = dax_get_holder(td->dm_dev.dax_dev);
> +	if (!holders) {
> +		holders = kmalloc(sizeof(*holders), GFP_KERNEL);
> +		INIT_LIST_HEAD(holders);
> +		dax_set_holder(td->dm_dev.dax_dev, holders, &dm_dax_holder_ops);
> +	}
> +	holder = kmalloc(sizeof(*holder), GFP_KERNEL);
> +	holder->md = md;
> +	list_add_tail(&holder->list, holders);
> +
>   	return 0;
>   }
>   
> @@ -659,9 +678,27 @@ static int open_table_device(struct table_device *td, dev_t dev,
>    */
>   static void close_table_device(struct table_device *td, struct mapped_device *md)
>   {
> +	struct list_head *holders;
> +	struct dm_holder *holder, *n;
> +
>   	if (!td->dm_dev.bdev)
>   		return;
>   
> +	holders = dax_get_holder(td->dm_dev.dax_dev);
> +	if (holders) {
> +		list_for_each_entry_safe(holder, n, holders, list) {
> +			if (holder->md == md) {
> +				list_del(&holder->list);
> +				kfree(holder);
> +			}
> +		}
> +		if (list_empty(holders)) {
> +			kfree(holders);
> +			/* unset dax_device's holder_data */
> +			dax_set_holder(td->dm_dev.dax_dev, NULL, NULL);
> +		}
> +	}
> +
>   	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
>   	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
>   	put_dax(td->dm_dev.dax_dev);
> @@ -1115,6 +1152,89 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>   	return ret;
>   }
>   
> +#if IS_ENABLED(CONFIG_DAX_DRIVER)
> +struct corrupted_hit_info {
> +	struct dax_device *dax_dev;
> +	sector_t offset;
> +};
> +
> +static int dm_blk_corrupted_hit(struct dm_target *ti, struct dm_dev *dev,
> +				sector_t start, sector_t count, void *data)
> +{
> +	struct corrupted_hit_info *bc = data;
> +
> +	return bc->dax_dev == (void *)dev->dax_dev &&
> +			(start <= bc->offset && bc->offset < start + count);
> +}
> +
> +struct corrupted_do_info {
> +	size_t length;
> +	void *data;
> +};
> +
> +static int dm_blk_corrupted_do(struct dm_target *ti, struct block_device *bdev,
> +			       sector_t sector, void *data)
> +{
> +	struct mapped_device *md = ti->table->md;
> +	struct corrupted_do_info *bc = data;
> +
> +	return dax_holder_notify_failure(md->dax_dev, to_bytes(sector),
> +					 bc->length, bc->data);
> +}
> +
> +static int dm_dax_notify_failure_one(struct mapped_device *md,
> +				     struct dax_device *dax_dev,
> +				     loff_t offset, size_t length, void *data)
> +{
> +	struct dm_table *map;
> +	struct dm_target *ti;
> +	sector_t sect = to_sector(offset);
> +	struct corrupted_hit_info hi = {dax_dev, sect};
> +	struct corrupted_do_info di = {length, data};
> +	int srcu_idx, i, rc = -ENODEV;
> +
> +	map = dm_get_live_table(md, &srcu_idx);
> +	if (!map)
> +		return rc;
> +
> +	/*
> +	 * find the target device, and then translate the offset of this target
> +	 * to the whole mapped device.
> +	 */
> +	for (i = 0; i < dm_table_get_num_targets(map); i++) {
> +		ti = dm_table_get_target(map, i);
> +		if (!(ti->type->iterate_devices && ti->type->rmap))
> +			continue;
> +		if (!ti->type->iterate_devices(ti, dm_blk_corrupted_hit, &hi))
> +			continue;
> +
> +		rc = ti->type->rmap(ti, sect, dm_blk_corrupted_do, &di);
> +		break;
> +	}
> +
> +	dm_put_live_table(md, srcu_idx);
> +	return rc;
> +}
> +
> +static int dm_dax_notify_failure(struct dax_device *dax_dev,
> +				 loff_t offset, size_t length, void *data)
> +{
> +	struct dm_holder *holder;
> +	struct list_head *holders = dax_get_holder(dax_dev);
> +	int rc = -ENODEV;
> +
> +	list_for_each_entry(holder, holders, list) {
> +		rc = dm_dax_notify_failure_one(holder->md, dax_dev, offset,
> +					       length, data);
> +		if (rc != -ENODEV)
> +			break;
> +	}
> +	return rc;
> +}
> +#else
> +#define dm_dax_notify_failure NULL
> +#endif
> +
>   /*
>    * A target may call dm_accept_partial_bio only from the map routine.  It is
>    * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_* zone management
> @@ -3057,6 +3177,10 @@ static const struct dax_operations dm_dax_ops = {
>   	.zero_page_range = dm_dax_zero_page_range,
>   };
>   
> +static const struct dax_holder_operations dm_dax_holder_ops = {
> +	.notify_failure = dm_dax_notify_failure,
> +};
> +
>   /*
>    * module hooks
>    */
> 
