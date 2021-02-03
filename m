Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0330D350
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 07:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhBCGOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 01:14:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38932 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhBCGOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 01:14:02 -0500
X-Greylist: delayed 3206 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2021 01:14:00 EST
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1135Jc5w054607;
        Wed, 3 Feb 2021 05:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bdIlHq6SJvr4LVb4HrnWq3CkK0KP0gLM/nHIxcyKg2Q=;
 b=GcQ18vAra/Zqs+nTOE778jEFJANf9yKXzs1gMKtaPDDfWUEzHG+mEMfmbGLBX3j+gIlA
 6vrxmjFA0Wl6JVfbal5zVyq4raxmN7CKGRZIpPtulXFii7TEUbay2zssTLvZL0jUVYXn
 TZNpeWPW4ox6OsXkSr9yxQOGcmVhMTGprSDAAk1KfdVs3TS2g2KE1QJaQg3ogDoZuSJ0
 ZoeYU/I1jzz6TDft+YUoQPZ4G00QqscieNeYAAQq9rxjMUl5DPwibZghcmeTnu45Qk6z
 OsBkzQtnchdgOjzAta6GKk18BuZLJFdsfefjyF2tHIMKV2SB0+r6Nev14uvxJ3I4I4Yh 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36dn4wkyf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 05:19:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1135JWwK153979;
        Wed, 3 Feb 2021 05:19:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 36dh1q5hjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 05:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pit8ZGbw7OhWP7Fdwusc46JYGxLFszSFvMgX6CCp5P4u3LtCQwGZeFHz1K2CPQeCosb34M7sN5VEIRSBs30iK7X1G+hLZuKKDjirdxyeyBvcYQiE/6nmdx6vMi4yUic1XN12Rc3dXpGFi8on5ygHkn5zMwaw9/AUy34l2+JNVYvHRVbjXe6TQJL5q85GQnV/BsMekf1qa7LjlYQ0aQybg+qZqEMHeHWY2Dpa1fE7SqyX+eZFLr3GRZpeyyBQ5H6oB2UjSna9Hxq2Oy1LcRTKJdrDezke5gomeVtSGE4gk1YG6C1CegplYL13NGnOIxsjngm3Y7mpBv+cp1rUj33GSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdIlHq6SJvr4LVb4HrnWq3CkK0KP0gLM/nHIxcyKg2Q=;
 b=nRF5KLTgSUTozjv5bHlYOGWh28hCmWjmccI2VbTSig4kdW8bNGVjBVso3j1ATIdrtVbZ/SpHrsjcnbJBZBWQx1xGAAbNr5KW3c7cQZ+itNeq/C78xLNV6EOkncH27rBWbf1AgsxkmazGPkqaOvb8wwcf2w9rCpGwDgYXdf2S9jKms3l3lYye8FpzpFqrDvhjcS998cSUhUpNZVBwarvOp3j7mavsrPSKgbU02AqUsAxLYTquadZDPJRtQJZ4jvLqtbxhEhbNk/FArn4clAzqk1cvfFgB0FeZN6ZIQ+yG4ETTdf6n1IDhO5AnTMbJ3lSlDlvssoQjMBketycbhot8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdIlHq6SJvr4LVb4HrnWq3CkK0KP0gLM/nHIxcyKg2Q=;
 b=CmwNHa+fXzBSj1MRq+ieQ632fTPXG7Md/LiIBjOXXZRCJF84D8WK7j83n/DViazQE3I93Fo/EVvFioVHcuPhcQZ1ndx0Jnmquviusa65c7eOPYeFC7i94KBiqRrziop+QzF+1JrRxsKu9uzpjKfZXaXd7UTHyPdEVS3IwPafnfA=
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN0PR10MB5384.namprd10.prod.outlook.com (2603:10b6:408:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 3 Feb
 2021 05:19:29 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 05:19:28 +0000
Subject: Re: [PATCH v14 12/42] btrfs: calculate allocation offset for
 conventional zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <583b2d2e286c482f9bcd53c71043a1be1a1c3cec.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c1ba8d31-09f7-bab5-72ec-414bf8d7fcc1@oracle.com>
Date:   Wed, 3 Feb 2021 13:19:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <583b2d2e286c482f9bcd53c71043a1be1a1c3cec.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:d99a:96b0:4ac1:95ad]
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:d99a:96b0:4ac1:95ad] (2406:3003:2006:2288:d99a:96b0:4ac1:95ad) by SG2PR04CA0192.apcprd04.prod.outlook.com (2603:1096:4:14::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Wed, 3 Feb 2021 05:19:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e566a685-8e82-4942-1899-08d8c803473b
X-MS-TrafficTypeDiagnostic: BN0PR10MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB53845563443C4483BE19266FE5B49@BN0PR10MB5384.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6DAaQySUHhJeVYlLsd7v2jAD7T68qjujCGip6t4sz75YgOPnz67y+RprH+1W/Daj2vnIGmYXkNphyZDWSSMnmGbSqtGzs3+q8rJONqvorIcWbcLwUk2BXkwmN92ARa1orCkCHWrzczVwloGua38Ff581C2XdK6i3W4+gwjwoOKSIfqx7aTooMJnVK9ZvwAfb/GUSxrDx+tnLMlPL/J7y8jH8OroNDcEMnsn/cXKnOpg82EGJP2QuT/hzCEQoxS//YlF8BTHs5tkmr4XxO0Rfvx84Mfokf2wV4u+V3mMXAl8OXpfqbY6wuANxKuHKey/sj53o44CRVIIK7TQFvp+bqAUNti6N+V4yiwzY/cRqOyS3Y51J4lB0k276z3YBR/Rw+LkRWizBZScuXmyFbgigkKHFc4YeCcDD7KqnUcYNmYgWA3/XhCbE74tKJ13rKZe31HxBDsF3Nzdg4n+vV+I0nFGAbwCPTusXImEcbUgF0nbCY3GLxSPAXIFJghQD8r9H31r4bRzRzUZHQzKdxIHQCqi8cn6TAbRLfKkeFZwuSGI/5x016J3DPKxNsohgEkdXk9c/yAlj2CZkQxx7pVGjEDskLtFh1P3qpOpYucQAwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(83380400001)(107886003)(6486002)(44832011)(86362001)(4326008)(31686004)(31696002)(5660300002)(2906002)(54906003)(8936002)(478600001)(6666004)(186003)(36756003)(16526019)(2616005)(66556008)(66476007)(66946007)(8676002)(316002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1Fkb0RrVWdjUzI0NlI4UUoyNll4d3h1R2ozMDNNVitNY3lCaFZtTitoV0J6?=
 =?utf-8?B?TFJiWFAvc3J2clA3aVZRaGNWcUVtOEtDWHBKaHVXaVNxRHc5WGFYdTRHTTZT?=
 =?utf-8?B?MkltZnpUaUNYcjVpbndUci9KWlB6T1VMeVdmNm5GYXlXdDkvZnlCZVVqUldD?=
 =?utf-8?B?ZlhpNEdmMmlwMlZwQnZHUkxpa2doeUd3NEZQcEErK3VYVDBqRFVjbVpnQ3Vk?=
 =?utf-8?B?VlY4Uk5jSXl2RFhmMzBxeXIrSFJMY0tiNndEQVJvM0V6Z0JCQmdtTlA4cS9J?=
 =?utf-8?B?bEUvU0tNd1hnVFBxQ1dNME1qSFlGRHE2dnp4eStYQnRXWUMrSENnSENsOTgx?=
 =?utf-8?B?cFFrdjRWU2R6eG9aSXptOHBIS05LMWk3WE83T1NSREluWEdCdFJZZEx5WXZK?=
 =?utf-8?B?Y2JZeGNadWVIamtYVTZnZ1k2bGNxVjNvckhYV0l6YjdUUkhMME9RU2g3Smtn?=
 =?utf-8?B?dEpNc2RINEhTbjNrQ08raW84dkRXbHpKSVowaDJtMHREQXA0K3N1cHY5bE8y?=
 =?utf-8?B?aUR5T2RTRnhXdnNvZVA5S05JdWJFa3NQMUJ4U1UwRFUvZ2VjU3U2eWFEblZl?=
 =?utf-8?B?dGZFRHFCbXdxa1FLQy9YaWllWHhMemdJQUo4dXVhTGk4UzBoVlR2emIrNlpn?=
 =?utf-8?B?bmdBUW1JS01RM3dCQ3EzQzF4dzl6UjY3VjRNUUlXSFkxSkNmRVV1QVM0QVdO?=
 =?utf-8?B?QUI4K25LaFNsTmhlblA4aHEveEZMQnAyS253SWN0YjZsWGdPeDhOcW4zaTZo?=
 =?utf-8?B?bWQxTk81R2NtU0RDdDJlNzlQZHBZc1BVZThJQ3dWRWZVY0xKZkd4MnNqV0Vj?=
 =?utf-8?B?UzBNWjVCY1hhRm9PMmFVbURzNTMra0hBUmh4MnY0ZmwxMXd1aEgzQ3Iyb2da?=
 =?utf-8?B?NU1zVkM1Q0dlQUV1VWljdnRNcFNVUzlack8yWitHamFFUk16TFlmcE0wcEEz?=
 =?utf-8?B?RlVvZTNoZ2EyckhNdEszajhvY2dJL0N2YjZ2Nk1WVFpWSldLSmc1K213MnlT?=
 =?utf-8?B?bnlPdXRXaVhiZG9ETkxvdGgyNjluUjBHWXNmOHd6eFdjSWt4T043V09pUC8z?=
 =?utf-8?B?UFpsRlVYMnZjOUJHeGF2eUNNNUtpYjZadUphMHVwekljQWM1UHFmK2VHYTFH?=
 =?utf-8?B?LzlDWGF6OE9kdGc5b3B6ZGt6YlpJd2hEMDBHSExNSlNUeDNWT0UwMSs1Mmsw?=
 =?utf-8?B?UmkyalRTelBUc3ZiQVZ4cndBZ2k5NzBQMUl2cmFJQ1Fxd3JLZ3dVckE4Uk00?=
 =?utf-8?B?RzNIZTZYWWZoWWlyVVZBWUxndS9lVVZITU1VQ1pPZmhQS3E2Q0d0YUlOYVVl?=
 =?utf-8?B?TzVrdENkMzlFMlFWMlRNR3V1ajlHd2N4ZzYwQW9pZEpkaUIrczBHSGxKc0FD?=
 =?utf-8?B?TlRPTUoySzhQeEs4Nyt1aVJpbHhqa2J0K1ZkWWZTcENiZmFqT3NYNTZIOXJ4?=
 =?utf-8?B?WXNPL3R4K1VFQ2xOWWNLamVvWXdCTGlKVWlkMEIrbkdKZnNRdjdFNjJWVU1I?=
 =?utf-8?Q?+tKh6vBneCYyhM6vDkEtpHEcr6Y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e566a685-8e82-4942-1899-08d8c803473b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 05:19:28.7323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DTx9sL5TQrV41+gVBeHlugF8sI1Fk5Ku5O2lHWQNEEwpM+JHrBIs4A7KRHdCnmHC8qxw68Rcy0AFA8p6ueFzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5384
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030030
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030030
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> Conventional zones do not have a write pointer, so we cannot use it to
> determine the allocation offset if a block group contains a conventional
> zone.
> 
> But instead, we can consider the end of the last allocated extent in the
> block group as an allocation offset.
> 
> For new block group, we cannot calculate the allocation offset by
> consulting the extent tree, because it can cause deadlock by taking extent
> buffer lock after chunk mutex (which is already taken in
> btrfs_make_block_group()). Since it is a new block group, we can simply set
> the allocation offset to 0, anyway.
> 

Information about how are the WP of conventional zones used is missing here.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Thanks.

> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/block-group.c |  4 +-
>   fs/btrfs/zoned.c       | 99 +++++++++++++++++++++++++++++++++++++++---
>   fs/btrfs/zoned.h       |  4 +-
>   3 files changed, 98 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 0140fafedb6a..349b2a09bdf1 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1851,7 +1851,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   			goto error;
>   	}
>   
> -	ret = btrfs_load_block_group_zone_info(cache);
> +	ret = btrfs_load_block_group_zone_info(cache, false);
>   	if (ret) {
>   		btrfs_err(info, "zoned: failed to load zone info of bg %llu",
>   			  cache->start);
> @@ -2146,7 +2146,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>   	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
>   		cache->needs_free_space = 1;
>   
> -	ret = btrfs_load_block_group_zone_info(cache);
> +	ret = btrfs_load_block_group_zone_info(cache, true);
>   	if (ret) {
>   		btrfs_put_block_group(cache);
>   		return ret;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 22c0665ee816..ca7aef252d33 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -930,7 +930,68 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>   	return 0;
>   }
>   
> -int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
> +/*
> + * Calculate an allocation pointer from the extent allocation information
> + * for a block group consist of conventional zones. It is pointed to the
> + * end of the last allocated extent in the block group as an allocation
> + * offset.
> + */
> +static int calculate_alloc_pointer(struct btrfs_block_group *cache,
> +				   u64 *offset_ret)
> +{
> +	struct btrfs_fs_info *fs_info = cache->fs_info;
> +	struct btrfs_root *root = fs_info->extent_root;
> +	struct btrfs_path *path;
> +	struct btrfs_key key;
> +	struct btrfs_key found_key;
> +	int ret;
> +	u64 length;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	key.objectid = cache->start + cache->length;
> +	key.type = 0;
> +	key.offset = 0;
> +
> +	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	/* We should not find the exact match */
> +	if (!ret)
> +		ret = -EUCLEAN;
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = btrfs_previous_extent_item(root, path, cache->start);
> +	if (ret) {
> +		if (ret == 1) {
> +			ret = 0;
> +			*offset_ret = 0;
> +		}
> +		goto out;
> +	}
> +
> +	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
> +
> +	if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
> +		length = found_key.offset;
> +	else
> +		length = fs_info->nodesize;
> +
> +	if (!(found_key.objectid >= cache->start &&
> +	       found_key.objectid + length <= cache->start + cache->length)) {
> +		ret = -EUCLEAN;
> +		goto out;
> +	}
> +	*offset_ret = found_key.objectid + length - cache->start;
> +	ret = 0;
> +
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>   {
>   	struct btrfs_fs_info *fs_info = cache->fs_info;
>   	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
> @@ -944,6 +1005,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>   	int i;
>   	unsigned int nofs_flag;
>   	u64 *alloc_offsets = NULL;
> +	u64 last_alloc = 0;
>   	u32 num_sequential = 0, num_conventional = 0;
>   
>   	if (!btrfs_is_zoned(fs_info))
> @@ -1042,11 +1104,30 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>   
>   	if (num_conventional > 0) {
>   		/*
> -		 * Since conventional zones do not have a write pointer, we
> -		 * cannot determine alloc_offset from the pointer
> +		 * Avoid calling calculate_alloc_pointer() for new BG. It
> +		 * is no use for new BG. It must be always 0.
> +		 *
> +		 * Also, we have a lock chain of extent buffer lock ->
> +		 * chunk mutex.  For new BG, this function is called from
> +		 * btrfs_make_block_group() which is already taking the
> +		 * chunk mutex. Thus, we cannot call
> +		 * calculate_alloc_pointer() which takes extent buffer
> +		 * locks to avoid deadlock.
>   		 */
> -		ret = -EINVAL;
> -		goto out;
> +		if (new) {
> +			cache->alloc_offset = 0;
> +			goto out;
> +		}
> +		ret = calculate_alloc_pointer(cache, &last_alloc);
> +		if (ret || map->num_stripes == num_conventional) {
> +			if (!ret)
> +				cache->alloc_offset = last_alloc;
> +			else
> +				btrfs_err(fs_info,
> +			"zoned: failed to determine allocation offset of bg %llu",
> +					  cache->start);
> +			goto out;
> +		}
>   	}
>   
>   	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> @@ -1068,6 +1149,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>   	}
>   
>   out:
> +	/* An extent is allocated after the write pointer */
> +	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
> +		btrfs_err(fs_info,
> +			  "zoned: got wrong write pointer in BG %llu: %llu > %llu",
> +			  logical, last_alloc, cache->alloc_offset);
> +		ret = -EIO;
> +	}
> +
>   	kfree(alloc_offsets);
>   	free_extent_map(em);
>   
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 491b98c97f48..b53403ba0b10 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -41,7 +41,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>   int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
>   			    u64 length, u64 *bytes);
>   int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
> -int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new);
>   #else /* CONFIG_BLK_DEV_ZONED */
>   static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   				     struct blk_zone *zone)
> @@ -119,7 +119,7 @@ static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
>   }
>   
>   static inline int btrfs_load_block_group_zone_info(
> -	struct btrfs_block_group *cache)
> +	struct btrfs_block_group *cache, bool new)
>   {
>   	return 0;
>   }
> 

