Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476F03E2028
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 02:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbhHFAra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 20:47:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46928 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhHFAra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:47:30 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1760l10s007584;
        Fri, 6 Aug 2021 00:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FQAQqsQJdxcHZjmZgeAD9YBt2jhXCBpWhzXiiGMuSVQ=;
 b=TRz+YGB7mj3wWlnTgV6QvgsLB7eTU4IIKACDA6fvGGzNvfFCx4AYmkMfbPwOM7h6s9K5
 xbHvB7/F6TCucwJ3AaR2HqNfqzZRHK2ce4ekCqzZmq+IPRsNQ8u1o9OJMswS3nmE3jju
 /ExdQLtQ63/TGLIwj2JkVAkM4xypOAEVapN3E5FIgZhz7dZmmjJmlHhsYVhyyYUYYjsh
 mBu+FYeqL+GlNMkKxHz3FiHj/OxA01mInK5CazwkNwlETUVooXVMjpAgO4MVJifzfPln
 BrMW0HEueEtQSO5DAVQPLznGdDlLMLwXydANcrNF7BP5wmwAZMFf5ODWvKGJRnFO6HSi qw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FQAQqsQJdxcHZjmZgeAD9YBt2jhXCBpWhzXiiGMuSVQ=;
 b=tf5TCrJKHOq9dYoaDU0qb5tEugFwQUz7Go9I68eowDLcp8GAnw8FuiGjV8RYnaVEgZd7
 Eh3dF/GK7hNzmljFW6mIsz51pAnJag/sy5QtLIvAvn2WizEClvLxferyFwM2Xbe1/joI
 lH8tlkOTISItxxfRNFmVXDsTvnjqbv3F40rerhk5xCAQdQhuGXnUG+NvgU0KuR7Sl4yn
 OpFIzlOuRswMo2hfdXX7QD2mxTlOa3zEp4Xn7MUaIxw1wqGgCeoVlUDlukkdIp5hQQWL
 5v9z6parYPDORcjMctnA+3XhH6nbgwIjHdiSUrBuRyxUjdmJkqzthMHuHJYW1KsIbrZk Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7wqubpf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 00:47:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1760k7GZ154538;
        Fri, 6 Aug 2021 00:46:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
        by aserp3020.oracle.com with ESMTP id 3a7r4apeyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 00:46:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPqrYQDLZ/nzIhMUUUFLUjuUAok3hmvjPd5NpDkguxC2/sMR+JVFowe4rDAn2/dtDzvQtkUzWDltUYuSBErLRQgPLUP7OP4nYGgqYimFKSeqky61I+AwNSQOUgVvdWECMISnAqRaGX8BcZCT4vLJnT6soyXvEvnpv0P4RhQZ+UMtg4oaoqqJyE97XODda3aM5p0qLQT490R34jX4W/7IUGeXWUS2QTaYrpJ1ZlQJGfBfD+ZIoq31tsSIOgO13qjn4yP/scHqUvTyDLnD7sohJ1ZQADahtc/Yf8MIfQh0t0c0DI94UpQ9NhfI66eWMV0LHjMA2nboPb5hzRPyW0khWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQAQqsQJdxcHZjmZgeAD9YBt2jhXCBpWhzXiiGMuSVQ=;
 b=PdKiAUMPtNLdJZpcgOXCOa9oLpoTW4NLp7HizHeKf9clsamKEvlUAm1430kU3NbmfnZEH4B/E/Ci7RkQq/AqNxtE0xMJpazOcD4nBrAdKapmAKVzNgvcmflRbsuaSFXPCEM/TBc/jnQFDM8o+9EVD3NS0iovyxyhU6SeR7F6kD82vuCRAa/h37fh1M9frXh7JIVrqH0B01UNuHNTRBvLhMrdcGG0imi7loN96xehz/lmWk18Q14hPBHB4nKwlO+1mJ4Dt/vwFTr3Pss7GhdDbAvcXQunBb+szNbIEyY6McgM+1kxAtxB5dYRhUlcVdBSEDozM7o8fhIPrirQKqsafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQAQqsQJdxcHZjmZgeAD9YBt2jhXCBpWhzXiiGMuSVQ=;
 b=npCTpFX48NozK2Firx2C6Mpnj+yGIjCi1Qg0C0ufWsgAnukrtDHYDhKUw3WA8sh4FzOvey3/wULPyXhV4T7KH8osfjkYzjgWwe54xRZtO9WTZ2/eLrJL4r+MruCXyjObxYekmshcAFampfEATDCOfLajsTFm9aZwyZQ8antAxjM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2758.namprd10.prod.outlook.com (2603:10b6:a02:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Fri, 6 Aug
 2021 00:46:57 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::51f7:787e:80e5:6434%3]) with mapi id 15.20.4373.027; Fri, 6 Aug 2021
 00:46:57 +0000
Subject: Re: [PATCH RESEND v6 9/9] fsdax: add exception for reflinked files
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com
Cc:     djwong@kernel.org, dan.j.williams@intel.com, david@fromorbit.com,
        hch@lst.de, agk@redhat.com, snitzer@redhat.com
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-10-ruansy.fnst@fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <7e9589cc-92a6-ad57-edd9-fdcdc4e49150@oracle.com>
Date:   Thu, 5 Aug 2021 17:46:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210730100158.3117319-10-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:806:121::20) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.70] (108.226.113.12) by SN7PR04CA0075.namprd04.prod.outlook.com (2603:10b6:806:121::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 00:46:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d7cf042-ede8-470b-d4c8-08d95873b1ae
X-MS-TrafficTypeDiagnostic: BYAPR10MB2758:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2758DC99686C2B3E04B03033F3F39@BYAPR10MB2758.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbC95OAcFTuydXBbVC5QIE9/7AUHhL6ZLjgfOBMT1y7KJr4DwPq3jW1PvYUo39A9iOrplV4MRiZxSyWjZDVyUqt/mTk7xBqtKDEZjni33jZwK6yyq3hQrcn0DfatDDatq+r5LeH3uf2+s0BJMixD/02c+ZQxqcQZk/vcpclUHBO3U9jdIxObblWLCmGXsKSxYcwlVjn7edUAKuGJultSEb53b/qjxxAQ8iD5U+1MqJYbovPcBzonHzP6hYSz15xDoo4pfg6JqOtzrthEQJiBboS0PcS/xcexLB4rhgumqFbbjEZptzqbfUmxlK1sM/09/KLx8FDJXmwfxVcfnQpwAxxSZXXKvHTbqdEpvRzopLtC6qPKylqYu5N//fBe5Hb61+KP5bRG6weps6cR5hUr95q53ubn6uTVaWrtShtcRd4XskeB/I2qdUddFhkgYRVcm2YAInv1UEnGb4W+yyb211WSxUX1XtW4NkjBZUYWGVZzZzkTxCkZAjD8O/N7OMDwwWFrs7JJoQDpYeYD76nQVKc832NO1qZ2OdmsdzGOPvJ+1d4ar+m4jjIxHAvdatnUcl5ek7lQQX75MjZU24nxQ5c6nwNrAOcpj4cQxkm3S0HySy/NnefwZQqLG+hmwctb3TM6nKaxdN+iZ8NhH+S8Og8CnE5bjaqroAzc84Vb4DDi7zUiotxjDLsY6Vit+MMHMr5SJB8LpQBoBcBS6nmxFBggKhUFXuFHUofUdTNENIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(66946007)(66476007)(66556008)(36916002)(186003)(956004)(5660300002)(2616005)(31686004)(36756003)(44832011)(8676002)(53546011)(26005)(8936002)(31696002)(6486002)(86362001)(2906002)(4326008)(7416002)(16576012)(316002)(478600001)(38100700002)(6666004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGJUTHJBVGJyN2pCc1ZyWGR0SDZSRkcyYmN2VnRzMTc2NWxIc01TeExDY0Rq?=
 =?utf-8?B?YTRxVE1WaDVXNDgvMW9OYXpFY2ZMckpjVTB0NXppNldWM2t0STlnQkVCU28z?=
 =?utf-8?B?eVYvRERkbHFIc0VTK2V3TlNmWnVWajFldGJmWmpEVTBYaXIwRWVmdFNaZnVy?=
 =?utf-8?B?T2ZGVHhnOFVac0taOHphZExsV3VYa1kwdWtldkhYVXc5T1BRZ0RXZVVTMFZH?=
 =?utf-8?B?UzdjNGtVdGRLdEg3OGhoY1lwRFlqNndOTEdWZ2d5aUhjVysxK1FpUzE4L012?=
 =?utf-8?B?WnEvMGFveUNHYjJMU2FxK3RkOW9lczd3MkRiSGJBR2hxdzRlSTZPdUJUMUwy?=
 =?utf-8?B?czd1cDlrU2dwT1FvK0JvTUFzbXphdDI4bzRnTzZYTGl1RHdIVFVjS2dBdFo4?=
 =?utf-8?B?eEN6aE9ncEFzaDIxeEVvWTJvSmpDakJVSktEdXpLT3ZDL1ZGanVmR3IwVTI5?=
 =?utf-8?B?R2hDcGJSNjNWUHV4WjgxeGU2cUtkQUlOWjdTZGYwK2MrMWVWTlV5Z1pQMllE?=
 =?utf-8?B?OVBsMCtJdk4yTTVSb2d2RjA1VWNVTlByRVhPVjdxSkM2M2pURzlZbnJWVlBq?=
 =?utf-8?B?ZnFnUTlKWkYvUGpFNU1OejBTakE2dWFqSkx4Y1FsK1FvZmp6YjkrZXA2UkhD?=
 =?utf-8?B?aThZd3dXbzF0cUxaSG1HcjVYbXVXRkNKY0VvVGdrdjEwMzdGdCtHZlpzcU5x?=
 =?utf-8?B?OThtL0dtaUMrYkZkZjRGWDJJTjU3OWYyVnJPc1B1TzNKcXZVdmtRQkt3RkEy?=
 =?utf-8?B?bExVWVpSRWZ3TWtzTlc1aG5uYWpsRGErUG9lMDdpcjZXdHBxMzE2eU9ERFZl?=
 =?utf-8?B?bENUSDdhNVk3VlR2NEJMM3NNcHB0NmthTTFKK0JucjRtd1ptZWdzTzhIbzdz?=
 =?utf-8?B?SlNwMmxMNVFlMU5EZW8ra3dlYldGY0lVeVdvbVQ1U28vaWR3YWlZb1VVVlJ1?=
 =?utf-8?B?OHRQdllJczhTbC94eDVSd0tBNmpxQ0FwR2Nva0J5UFV4cENNT3E4ak0wTXZR?=
 =?utf-8?B?dTcwUm85RDhIZ3JZakJuZ3E2RVA2c0FMUU4rdXZvbkRpZWR1a3FzN20rOFly?=
 =?utf-8?B?Qlo5YWh6S0d6b2pLc0RlVUx6TldXRk1LVG9aMUhPNDlkZXFjRW8xcXhENkEy?=
 =?utf-8?B?bklCcS8vcTZMb3R2S1JrR1NqdVJZbVVGbDB4Z0o5dWVLNFEzNmVmVy9VRWh3?=
 =?utf-8?B?U3ZDY09qY2F3QjVOMDFxdTEvWHdWMFI1MitUTjBiQ0ZkelhxTmdFTTh0TXA2?=
 =?utf-8?B?ZU0xNHU1ZE94WkhGcWIxSThWdFkvUmpjUUR4RG5IZWhzTjdVU0pLUFUrMnhE?=
 =?utf-8?B?VW5BZjhDYmh2VUxVYzRsdjZBWGQ5NjVsMmUvRDBESVVDNTVFS1VTMkYwTzlJ?=
 =?utf-8?B?ZzloYkZWNUpDWXlaV092ZmRUbW9WSDNlQTZUeVdJL2NLK1d2UmJBUWY3MXB6?=
 =?utf-8?B?MjZJeUNUaTdvc1pRWXlMWGRuUlEwamt5L09SV01NZ2czam8relhZMTdDdGVN?=
 =?utf-8?B?VlRhSm4yT0pBdEI1WlJDMEtPRGN0VlFSQkxYOFlxbnJTeGN0UHgwMGI0Qmxq?=
 =?utf-8?B?S0MreWhXWVpaMFdpTVlvZlh0TS9BaWUyajMzR3ZOODhtRG5rT2dDMEFBRDRF?=
 =?utf-8?B?Y0xoREU5M05kOFlyaFZqSDJCUFhnb0lPKzBZTUVVbzJvTkxzaTBVaVN4ZXE2?=
 =?utf-8?B?bExzaU0vZ3NTYktCRXFIUHk0Mm5EZTdxNUZwVHhlSGI1NmtkOGxpNjh4a3Ja?=
 =?utf-8?Q?EfBSiUEkTK4bN3dCr0u9E4I9zgUkLuI31FrgyZ5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7cf042-ede8-470b-d4c8-08d95873b1ae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 00:46:57.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQEKJdzXiDabJXSF9j1zigYnyZ1ySqlWFuZbQdLyu2uSIwu7irI9Yq5M8Rmszi+tWODrmIYwm76QnuxPDa4XQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2758
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060002
X-Proofpoint-GUID: AjUiWNE9JeFKRj0fEdGLPzokYNoWB0qO
X-Proofpoint-ORIG-GUID: AjUiWNE9JeFKRj0fEdGLPzokYNoWB0qO
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
> For reflinked files, one dax page may be associated more than once with
> different fime mapping and index.  It will report warning.  Now, since             ^^^typo here?

> we have introduced dax-RMAP for this case and also have to keep its
> functionality for other filesystems who are not support rmap, I add this
> exception here.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>   fs/dax.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index dce6307a12eb..f5910d178695 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -352,9 +352,10 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>   	for_each_mapped_pfn(entry, pfn) {
>   		struct page *page = pfn_to_page(pfn);
>   
> -		WARN_ON_ONCE(page->mapping);
> -		page->mapping = mapping;
> -		page->index = index + i++;
> +		if (!page->mapping) {
> +			page->mapping = mapping;
> +			page->index = index + i++;
> +		}
>   	}
>   }
>   
> @@ -370,9 +371,10 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>   		struct page *page = pfn_to_page(pfn);
>   
>   		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> -		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> -		page->mapping = NULL;
> -		page->index = 0;
> +		if (page->mapping == mapping) {
> +			page->mapping = NULL;
> +			page->index = 0;
> +		}
>   	}
>   }
>   
> 
