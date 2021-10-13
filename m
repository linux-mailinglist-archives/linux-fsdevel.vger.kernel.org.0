Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F9442B8B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhJMHR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 03:17:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3516 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230057AbhJMHRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:17:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D6wJUt004221;
        Wed, 13 Oct 2021 07:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tw7w8HaA6+b3R9ce+G4pr9Q+e3Aor6MTcRv59KVHYqc=;
 b=t1G2ukmQPvUbrQ6WaL+XxNwsfxufdOJelwM0tMIX/LkupVmQbe8bW0sm0IJKg65ljTqJ
 2petZcdXTNS1sNzJ2M3YNYqGvLDs4DPpn9i+G6FYC3Z2vVhFOi3LIKqD/T99Fuce8H2A
 SU6DJfqKIJ9WB0y761L5JaSpPDhe5+LZI+26S1Gwe65Std1kR6RJdZfMgApku/FhaBB0
 B28dWZE8qZyExX5CDCDwNHz3Hx+24H02rxf0+Z5+C3n8W1jpbtqwDkXd1b3yQypJPKxa
 IqNG5ykf+T/+NG/h9ZZiqgMwirxMDI8GRA0FIcrvEABvx2THKY0jzUjx2+t4fCz9UVlB sQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbu9wxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 07:15:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D7AR6U004087;
        Wed, 13 Oct 2021 07:15:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3030.oracle.com with ESMTP id 3bkyxt07x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 07:15:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm69urWqOoaPVVI4gyU0Bbemf4ukvXCke5HIJ+rpKxUrlF5D9q3J7jjU4jvPfE9SirkJHGNmix3hFdvn6lGppoOSZU39Hyzcl3x9yuD8FnUkJzP7Rb1eQGYW5ZAqbe4NuCigqPgJ/B62Mx6qfv3C2JoFXDT00ZT1VgCcNmJKiygeFkmVlUCS/Hu5hId2xvuMAv13JDm7dYJEn82neOXaMH2Mr0lhB3+FETMW1+JpXDtbzlofwcgGQwD3sUftucBLE7b5DC340J25FFtbPdwxd+Zrie/P7RAui/KmCTEhu42k7aGDStzuqFMvoK+XsDgN6xoy0JYL8jWsgwSkLhbS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw7w8HaA6+b3R9ce+G4pr9Q+e3Aor6MTcRv59KVHYqc=;
 b=j0LaEij9c/X10P6IPj0vsdKeX18wjD7d28yUiqj4LWQhNSsN/PCgoBRSSduUwF1WZdUyyt+dNro9IpawTs7GPyTvjP13WQ2QSQ+Yu1ofmKwil9Bg+yb5xLi6thQ1nhWFFOIAJ75xGz/XcO2QU6/2dbfuw86q1inXG0U/ci7fT6idA/2rcZxh11SAgNVqf1w7ARq6naGlUqhCPkiA0p88l6TJeZHpJyUfkQnlJ4L9bcWWe1443wyFxChglgNt3Q4HjFclIP8WPbJAy4XaDuaI5I7ekmJhTjWUWNX14sdZmfoAffU8YSuub8NEoFl/TnVvUKHcMUsPvO4vDgb9PK8ZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw7w8HaA6+b3R9ce+G4pr9Q+e3Aor6MTcRv59KVHYqc=;
 b=Um+Qs0fPjbYJf+adG21vf2cGKDogXwAv1GE+9qe3lM1AzTKluhFhoozG9l/Dd2FtHMcwr0VTuzM6SvSbiuzRIBZYg6zL1T74RQpteUEWL6594r4A6NzPEELyO0fbDTvypRz+DBSf2jeHgPbPjo5e7jijXN49eKkcKsQW2b2OKT4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 07:15:09 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:15:09 +0000
Subject: Re: don't use ->bd_inode to access the block device size
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
References: <20211013051042.1065752-1-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6d96d52b-3a19-8e00-4089-c2483a4cdbcc@oracle.com>
Date:   Wed, 13 Oct 2021 15:14:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211013051042.1065752-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR01CA0184.apcprd01.prod.exchangelabs.com (2603:1096:4:189::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 07:15:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f30bcbbc-36c0-430b-cd55-08d98e19309e
X-MS-TrafficTypeDiagnostic: BLAPR10MB4930:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4930DC93C1A403C940038713E5B79@BLAPR10MB4930.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+KE6WazsV9XDqG9BT+q2/qU36Z+18zQy2SA9oN2fEr6gb4wMWGKzvLKTfMH6ERK+sZq3IXVRF7Apqz9rovdnQL2fZ6CHqm8KnkG1TuOkZHvMmCTUAarGi7H+JEVnSOcs+p2BOPnyWyZ9Ww1httDD1x0dy+rxhRzu7EQnva0jAzoevBMEiJPMaMYE4kQkoroKa/cJILwmKRm3Qvch9pB2OjGeEhaBvz+t5b4jOqa9UV0+jLlUGW26SOucBiv+pL0R1OSPhvamq3TL3Dp/OLYbRdRrwl90gb4ijk06DZrc2O+v6ol3WU5TWmle9SjpKeQ3GieFENj8pdw6jhN+7nXWU5QoSfrFkZ1gZF2d7kIGxOv2NgWgU3kE2b3ziqgMyGapAH8UfulECqrsxTNlTW7J+/7VbeUyspVgoNE8lss9CzcHdpshjSYlLIqm7d+ygkQum6qnsYgdcV0rJraSLgEfLCoo7I10Fqal2AipI1K6BSA9qHqBlpF7yqAhOMe8ufRpjEm3571SaZyaNDBCHt+nXV7p+Do8neHAG9XQZxAVW/7dI6Zb6TvEGtAv/cA58oL6MSwhj/C/kDb5Qbn3oORzB3N+ZWUn+q9Vzg9Mdeu2IvrOysWi07WJjMQ8H2KEpTEtCzSBgIdkp60edGykQDkzjzJkaT/02jLqMHhgR1L7M+3ezYWQxFkHHXTDBygpkAhWSvHLvwtXgFlyyasN3KG0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(16576012)(316002)(7406005)(53546011)(26005)(186003)(83380400001)(6666004)(86362001)(7416002)(6486002)(110136005)(31686004)(66476007)(2906002)(54906003)(44832011)(66946007)(66556008)(4326008)(8676002)(2616005)(31696002)(508600001)(36756003)(956004)(38100700002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGF6TTB3WUlZaGJjcldma1Jsd1JJUjI1bWdBSHZaVU5NT2lnUURyeTBRdk5X?=
 =?utf-8?B?SXZ2MGpkQ2U2R2Q5d0hzQmxSL2dnM2ZVb2l3UHczcmZxS1lxaTBwbHNCOUJw?=
 =?utf-8?B?WVpHQUxpQ212Uk1MUTRuZTlDYmJackx2TmZCSERxZi9nUUxUTE8rRDB6cmlP?=
 =?utf-8?B?dWJBRDhZYVlXWjhZSjFwaGc1b1FVSE4wbGlnNGlLUWczbWN1ZTZlY0tCVW1w?=
 =?utf-8?B?Z3RrdVJ1ZGtOWFJjS2dKdHZOQnMxMXM5b2k1U3BTUGZhWURBRmdETHo3aE11?=
 =?utf-8?B?V3pvcWRhWngwcWdScEtqa3lSM2JTdmRobUJnZXVRZnBqcW1UdzNSNUd4ckxD?=
 =?utf-8?B?eWNvcmRVSTZMOFJabnhtcGRHVXlvMmxNRXYvL0htZlYvbXhxWCs0TUx3a0tx?=
 =?utf-8?B?VVZCOW5QTm9SSVBTZ1FiNDNtUUk2aHdmRDRtYWtaYkJWSW9zTDU3R1pwenkw?=
 =?utf-8?B?WlhEc1FjeklFSEc1NndUemVUOHhObG1WZWVnUXVjM2lzekxLRGVRZC9yQWV4?=
 =?utf-8?B?R3pENHdJMU9kVmRnckpmeHlDdXRWMFhyU2hnckFhVE9ETGxhMy9Pd0hqVkl4?=
 =?utf-8?B?bVQ4dHFVY1l4Qmh3SGVteHMyRHp6TXN5VlJvNm12Y1Q2WTh3ZWw2bHlvYXg1?=
 =?utf-8?B?dlhOcktxSjZ0MzY4dVVaVTlDa08wazBPNm1qaXZNRmdpcXlGSW9ZejlqSHp4?=
 =?utf-8?B?dDlVTUhjS1pYNDdiSFErTG14V2d5UThPZHNWMnRUZXRaejVKa1NPREk4YTlR?=
 =?utf-8?B?K2pSU21LYU01STlEazJ2WmJiMTUwSFYwMUN6QXNSWW1FeVBtNGhDR1BhVER3?=
 =?utf-8?B?aG9Cancxem9tdU5NYzUzUGs0TkovdE9EaXhmdy9vNUFNUDRTTzk4aWlITk05?=
 =?utf-8?B?TitGaU1XTUtQYjVIcy84dXNoYnpmS21wYVpLVzhvMXlHVlpjQXNKZk43QlRu?=
 =?utf-8?B?RjdmOUFkZmE0dUQwQUlzSWhwWW5FOGZzKzF5R0IxRldqMkhqZ2lqd1lNQ3lk?=
 =?utf-8?B?ek1jYVUxaG0zOVAxamU2MlpEMmIwblBSWG8yWFR5UFpRa2NON1VERDRWODhS?=
 =?utf-8?B?QXk2UEN5YmhmeFR2UmVGQTZONEU4SWJnczVDd2ZrVTRJNE5jWk5uLzlOTDhn?=
 =?utf-8?B?Yjl6Z1MrakFWdjlIbFprV2o1Sm0xZ3NrMng0aTFjaVM0c1RDS01BQUJkWGFr?=
 =?utf-8?B?ZEtiT2pvVmNxdVdyK0ZIMmxIOER5MVZhb0lVdnNnZm1CanJoc21MTmZ6UUt5?=
 =?utf-8?B?VTlMcDRERy9oVnhYWTErY0xMK0U3Uk05UHk3NStGbXlSZTIzaTRnT2NuYjYw?=
 =?utf-8?B?SWRnTG9ySVdUUXhyU1V5MW8ybXRtY2krdmQ4aUpiL3FPOGhKL29wdE8vQ3p4?=
 =?utf-8?B?dTZYNVVKNnpFUndVYndhQ0RFWG1zUkdDMkFvZnJ3RThrVWZwVks4UjVPUjRZ?=
 =?utf-8?B?amhrNWtoTnlnMys2aDRZdmtlaXVUZjliOHlrRC9ETXdrdzBJYjV5N21mMDc4?=
 =?utf-8?B?QnNYK3dyekFHeTVjRE5sMzc3Q3lRV3ZJZEJOU1dWM0pFdzZPVGt3OW91WE5j?=
 =?utf-8?B?RWZjTVFid0x3T3BVMkpScGE2MnVWMFVPaDl1NDhnczJjcmY2SStDYVpCdmVI?=
 =?utf-8?B?VU5lNVB6SXY1N2pOaHVCZnRNdy9NS0hvMFUzZjRyMENkTys5UmRkUGx3MW93?=
 =?utf-8?B?ZnVLV0FyaFVONEFlMDdLL2o5V1J2RWlGM1I3VHg3alk5TDVlakpkdy9pOVli?=
 =?utf-8?Q?5+B3IR/RPvIO/H2kakRaigFHgD7Mu7yuNYawBNM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30bcbbc-36c0-430b-cd55-08d98e19309e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:15:09.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta6Y/rNXjzX1YifmtoWxWokP2JfcRJXm/Xf2OjoeUnj84dXH1Ha2NhQKfH4WmmrDhNt5JaTqidtdNWO+NRVwGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130048
X-Proofpoint-ORIG-GUID: yJCjeNSJm0gO30MkGIKqHW5dZGGKitrr
X-Proofpoint-GUID: yJCjeNSJm0gO30MkGIKqHW5dZGGKitrr
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/10/2021 13:10, Christoph Hellwig wrote:
> Hi Jens,
> 
> various drivers currently poke directy at the block device inode, which
> is a bit of a mess.  This series cleans up the places that read the
> block device size to use the proper helpers.  I have separate patches
> for many of the other bd_inode uses, but this series is already big
> enough as-is,
> 
> I wondered about adding a helper for looking at the size in byte units
> to avoid the SECTOR_SHIFT shifts in various places.  But given that
> I could not come up with a good name and 


> block devices fundamentally
> work in sector size granularity I decided against that.

Yes.  However,  POV of its usage outside the block-layer, a wrapper 
helper is a lot better. No.? If you agree, how about naming it bdev_size()?

Thanks, Anand

> 
> Diffstat:
>   block/fops.c                        |    2 +-
>   drivers/block/drbd/drbd_int.h       |    3 +--
>   drivers/md/bcache/super.c           |    2 +-
>   drivers/md/bcache/util.h            |    4 ----
>   drivers/md/bcache/writeback.c       |    2 +-
>   drivers/md/dm-bufio.c               |    2 +-
>   drivers/md/dm-cache-metadata.c      |    2 +-
>   drivers/md/dm-cache-target.c        |    2 +-
>   drivers/md/dm-clone-target.c        |    2 +-
>   drivers/md/dm-dust.c                |    5 ++---
>   drivers/md/dm-ebs-target.c          |    2 +-
>   drivers/md/dm-era-target.c          |    2 +-
>   drivers/md/dm-exception-store.h     |    2 +-
>   drivers/md/dm-flakey.c              |    3 +--
>   drivers/md/dm-integrity.c           |    6 +++---
>   drivers/md/dm-linear.c              |    3 +--
>   drivers/md/dm-log-writes.c          |    4 ++--
>   drivers/md/dm-log.c                 |    2 +-
>   drivers/md/dm-mpath.c               |    2 +-
>   drivers/md/dm-raid.c                |    6 +++---
>   drivers/md/dm-switch.c              |    2 +-
>   drivers/md/dm-table.c               |    3 +--
>   drivers/md/dm-thin-metadata.c       |    2 +-
>   drivers/md/dm-thin.c                |    2 +-
>   drivers/md/dm-verity-target.c       |    3 +--
>   drivers/md/dm-writecache.c          |    2 +-
>   drivers/md/dm-zoned-target.c        |    2 +-
>   drivers/md/md.c                     |   26 +++++++++++---------------
>   drivers/mtd/devices/block2mtd.c     |    5 +++--
>   drivers/nvme/target/io-cmd-bdev.c   |    4 ++--
>   drivers/target/target_core_iblock.c |    5 +++--
>   fs/affs/super.c                     |    2 +-
>   fs/btrfs/dev-replace.c              |    2 +-
>   fs/btrfs/disk-io.c                  |    3 ++-
>   fs/btrfs/ioctl.c                    |    4 ++--
>   fs/btrfs/volumes.c                  |    7 ++++---
>   fs/buffer.c                         |    4 ++--
>   fs/cramfs/inode.c                   |    2 +-
>   fs/ext4/super.c                     |    2 +-
>   fs/fat/inode.c                      |    5 +----
>   fs/hfs/mdb.c                        |    2 +-
>   fs/hfsplus/wrapper.c                |    2 +-
>   fs/jfs/resize.c                     |    5 ++---
>   fs/jfs/super.c                      |    5 ++---
>   fs/nfs/blocklayout/dev.c            |    4 ++--
>   fs/nilfs2/ioctl.c                   |    2 +-
>   fs/nilfs2/super.c                   |    2 +-
>   fs/nilfs2/the_nilfs.c               |    3 ++-
>   fs/ntfs/super.c                     |    8 +++-----
>   fs/ntfs3/super.c                    |    3 +--
>   fs/pstore/blk.c                     |    4 ++--
>   fs/reiserfs/super.c                 |    7 ++-----
>   fs/squashfs/super.c                 |    5 +++--
>   fs/udf/lowlevel.c                   |    5 ++---
>   fs/udf/super.c                      |    9 +++------
>   include/linux/genhd.h               |    6 ++++++
>   56 files changed, 100 insertions(+), 117 deletions(-)
> 

