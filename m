Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6642DA05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhJNNR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 09:17:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44350 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230119AbhJNNRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:17:25 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EC6dQK025078;
        Thu, 14 Oct 2021 13:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WA9dPYQG8XodQsN6AxhCZzi1FymMbZ+cF5Pbu5cQGxE=;
 b=aQwVrcWkif5jb2ZiD3rT6+Je6xlLFjuBbn0K/wAffBPS+Yv/wlXEEv6IFjTnLCh5/qIj
 5AZJmH7y07UtY3kTz+Q1Mu3COvh4cqZsVCRXpPv/sHE/q6EFFHIiTI/4iyBJYu1X8vi+
 xwNw6oyH3gq6mwraB/ynZ3MJ03vkNxjUEjnm8iokMRzULxcfSM2pfBiz5R2cB1DnQVbE
 6QXxrbgI9t5IK3iQnyiM817xzoyd7lw5beI6grwnOaHY9j0vdkbO5VDY/iY5J50OD5aT
 Z0tif8LaGlqDjUbmTKuikbG64MlQqRBGAICcsTH4z3sTK9bbHthdVPBLHHsyYMIWyPTk Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bpevaa8bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 13:14:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19EDDMgd192592;
        Thu, 14 Oct 2021 13:14:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by userp3030.oracle.com with ESMTP id 3bkyvcn9ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 13:14:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnlqtkyF7GCogUHXOUQLPG7EbSF4eSllvOmYpMRVyxvXi6cNiNnncphuAMr7Q7GkIC9nBo6vTw7SEVxoBcz0Quddw8N5bzMPSDRfxfjxVbmkV7UP6/GdGwvw5MwqYkeBeUooc3ZxWrFo/5u0GwhULtisVeH+ctVYd4gLoKOpNeJplGhir4ybnHkvFOJbl6lB4LM5rS0MCuPntfv4VXO7kOSvRB4idzdkoo+Yif/Q9M8JAzl6I+YxmCK3tp2CNeLwe0ZNMTH5WsbsckiqRLAvrmPHirvWjJXr+0yPCgIJE3xtGMh63pQdRqXAiOm588/cBxhGZfW1Qk2jqmiuZnZHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA9dPYQG8XodQsN6AxhCZzi1FymMbZ+cF5Pbu5cQGxE=;
 b=mTuyv3a2At9PnISQpTOdDat5D1eKr/XxDzT2OXCfZYrDINZoAhsLq39YH1BZgC53utlNySsgRcMdPJh313ePI1dK2LTZhEx/GHI1MB/32bpJ7zJoRq+sL1kDHnShVqIAaM5H4aABK0TWQDajl5TdKCWs3xq5P7Pe8PUKja8pUg+2PrK/jMpYteaQjVNTXbOvWCZVOgyM8uHc9vjE0OeSWlQ2QxRmczgFFV9o3fPYCFbQp2aVhX5iJcfzJbNlUq+QsunUd5zjq1z98qpZ/c8s5KssZ7Xs6nj764h6PltYcT1T4JLqYYjFGcLmEW/Tv3rADJgaFQaKZ3szksECycXVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA9dPYQG8XodQsN6AxhCZzi1FymMbZ+cF5Pbu5cQGxE=;
 b=XF2DrYmhBtGjCdgULmLifr+75bQfEMthquYtUPhUProRAV2rMJyObHOhb91HwOIii30paAQFs9Q2PJJohwmpHaL4xJf1pkClCXLX+jPIOTvpqp4srEGcdpxx7nCvmYgSjTh+XaYNmh0IlyCP/b7M6Bp8ke7ILAOTpmwabvt6RCI=
Authentication-Results: tuxera.com; dkim=none (message not signed)
 header.d=none;tuxera.com; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17)
 by SA1PR10MB5688.namprd10.prod.outlook.com (2603:10b6:806:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.26; Thu, 14 Oct
 2021 13:14:02 +0000
Received: from SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::c12a:cfad:520a:2c94]) by SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::c12a:cfad:520a:2c94%4]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 13:14:02 +0000
Message-ID: <a5eb3c18-deb2-6539-cc24-57e6d5d3500c@oracle.com>
Date:   Thu, 14 Oct 2021 08:13:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: don't use ->bd_inode to access the block device size
Content-Language: en-US
To:     Anton Altaparmakov <anton@tuxera.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211014062844.GA25448@lst.de>
 <3AB8052D-DD45-478B-85F2-BFBEC1C7E9DF@tuxera.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <3AB8052D-DD45-478B-85F2-BFBEC1C7E9DF@tuxera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:806:28::22) To SA2PR10MB4665.namprd10.prod.outlook.com
 (2603:10b6:806:fb::17)
MIME-Version: 1.0
Received: from [192.168.0.162] (68.201.65.98) by SA9PR13CA0167.namprd13.prod.outlook.com (2603:10b6:806:28::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.7 via Frontend Transport; Thu, 14 Oct 2021 13:14:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71fb5c9d-b222-48ba-b368-08d98f147da6
X-MS-TrafficTypeDiagnostic: SA1PR10MB5688:
X-Microsoft-Antispam-PRVS: <SA1PR10MB5688342140D3C752F038279687B89@SA1PR10MB5688.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NK+IKLBQp6vqxPTSlW15ksUPoCy+AqnchQfrbUUHcxFWSSnhiQuvUhF9Ek40EFSSnPXfZNJ9lBrXcdCvSF9IJVpxR+Tg/6rMvcGVOnizIWhEdgS660Rn2T0adFEsYnmQOEGYg5y9kVrV/gUxmU0eJQ5WqVS9WpmeLt2kL/JX6SR2m57vZawGpi3z81G/SGrOWQfmvr1rft6Q/MvtOwNGF3SWFgao3mb/eGXo0xnCjSnfjl+ogVqUjVPYjjs/AlSIDr52wuLS4R6LPYsJX/QgBt8Ut1jg7SOebr/7u9pHtnYnmXRxPnUoKYvc6dfnsgQt5cF4LaZjIcJFVtz4TeXiCTuNLCnOSMqVC8k/3BMoOq16n2GN0eFvbCz6IW0HBGDsYdstyB46bgUqDcmanF/lwwVMNw8y+NhE1J/NpfpRp0jKoCLGa5pDVhfh+oUAEc9aS0zST+HC7ez/VnuuFNCp3dA8ty7voHZXlsYhuaFW4dSvtTw1WwVAGGxhNTI0RaURJARd3LLPRPVDJc30EW4IPfF+v4r9EKCw5aAzrvKasH+gPjsUxCmknKQv7JpCRseE3toUi2eW4ZOzYLzuQfqD/U/dK6KSwD+X86/Us7yT8rOqzboG8OVIzmnuvP3Jw6JfFFRamW3+4SDI1/ldLofTKsEtaiUbFoQRnWreYPROVrH1d2mVUvvJp+P5FQ8sSLSZcHhbi3SuskD453vNl1zjyoDshouh4e3UN5OyQHG8fMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4665.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(66946007)(2906002)(44832011)(38100700002)(36756003)(8936002)(2616005)(16576012)(66556008)(316002)(8676002)(31686004)(66476007)(6486002)(53546011)(26005)(110136005)(7406005)(956004)(7416002)(54906003)(508600001)(83380400001)(86362001)(4326008)(186003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHB3UytueVNDU2pEOUpOZzUwdlA4cWxwcDBUeXhWVUdpbG9uU3V2Q3lGZG5y?=
 =?utf-8?B?ZW12b3d1alhsNmN6VzFhM2pmQkVYRUlMR3RLaUtzb1dxOUFsN0h3WFI2UVN6?=
 =?utf-8?B?bFg0TDYxVWcrajUvMTBsVHQwbm1DZUtJVUJ3cVN5UlRlQ2x4VnEzNll1c1Vq?=
 =?utf-8?B?TW01ZjlOMDNEV0l3OVVMeW5PMUdpbVJIZmQxWDlhKzBWbUNKL2JaYmlBSkZ3?=
 =?utf-8?B?L2k0U1JTVllVV2NFeVFzdCttQUM4Ym1YQ2xkSkNtdzhkTDlzUXlsWW1kaVF4?=
 =?utf-8?B?Z25RZzZGY0hvZzlXUVJCVXRzb1VTeXl1dG9QSUNrZlZ4V3pmbStzeU5aYjZE?=
 =?utf-8?B?REpSWlY3S01RTDBWendYeFpDZ0VrZjI2RVpaVEpVL2NIc3l4SWRuK2RaM0tW?=
 =?utf-8?B?L3VkZmtMYU5HWGEzdTZoL2xNampMamN6ZXpndVlZWjY3b3E0NytKcHV5Tm91?=
 =?utf-8?B?WEM1ZldZVmUyOEpYYlJGYmRoTU5jVXRlT0poMGhBRGlXQUNGdnlYR3R6Kyt6?=
 =?utf-8?B?VUJmVmxObURYY2pJVURhVXZMYnBLcjk5SCtFS3BSVG13VlI4VUlYaUNPaXda?=
 =?utf-8?B?WVo2czc0Y0JQU3hSeXZYbW1xbEphK2NBRlkvMWNaSG02WEVhTGtQRCtGcDZ0?=
 =?utf-8?B?S3ZISXhUYTZlanVZMVBHTWs4RVRtMS9VRVAvUUdTZC9STkg3WTI2NlZYRnZh?=
 =?utf-8?B?SzBBbzRWcndwZWpnMXFFSjIybXpISi9mSFpMQ3prWjYxUVRCeG5DVU9QN2Qx?=
 =?utf-8?B?SjZyOWRYKzltbGtUY2xXMHRIZVVvMzRwVUJ0V0U2ZE9XenJoUGphMnB6akRQ?=
 =?utf-8?B?aCtLN2RnUWZzV2MxbUZYaFk3T3pyMWFjSzRzMFR6U1ZSWGxrck02RDd4VG9G?=
 =?utf-8?B?TktPUXhVUmFTemdUVmJlNnMzTFljSTYxMXBNTW9zMmc5dVpTMFJTR0haTW9D?=
 =?utf-8?B?aFJmSkFzZlJhZklCWU1qdmtzdTFwZUVwQTQ2YmlZczV4eU1vMDhLcXdkRlRW?=
 =?utf-8?B?WnpqRldzbHNQSTg5T205dXVxVEZicmNWRGY4VTJ4M2hTZm5tOFZxMWpLK0tE?=
 =?utf-8?B?NDI2cEFFVTBSNG44aU5WRzZhdWZ0ZlArS0N3L2lQT01TVXIramxxbk9BbkRR?=
 =?utf-8?B?QnZOMHNrT1VaUU1sUFJVWjlXRmtjRmhZUzVHSzdnamJCSjV5b1JsQ0pTMkxZ?=
 =?utf-8?B?L0FYdWxJT05aSk1SUU1aTFA0S3pRRXc1enB4ZGhwanYrOFhGU3VtMlVkUFU0?=
 =?utf-8?B?UTZvQkxkZ2E2VWc3YWxpYS9qL0F3S01LMGxnZkpDY0FXYmoyV3pHWDQxYklQ?=
 =?utf-8?B?QU1EMnUzUUJCc3VZbUlaNlFrZFE1T25mbS9GekZqNi81UUljWHZxZW5WeFJB?=
 =?utf-8?B?blFvTnF6SEhQeXVuMDJ6UzVJTWVwbHBjWjZTWEJObHM1RmtxdEg4ZE5lQlFY?=
 =?utf-8?B?anpXeXc0aDZMWGQyOUY4N3IyOGhTajRpUnRmUFowQUhUcmJjR09TQlhPM2lo?=
 =?utf-8?B?cTV2S2k0VVlHR3h1bnNrZGt2NlNOVENqTmpDUzN3OFZDbzdNQ2FmYnNyMG5i?=
 =?utf-8?B?cE5RNWRKTTExRzFEd2l2eEpQejd3WEFYV2V3dlQ2VGFvRnNGQlBVMHNZNC9v?=
 =?utf-8?B?V0RDNE1HMG9OTnN4bThtczl5bjdjem9qZ0ZTQjkraDZ4TGI3L2F3VTZRa2dS?=
 =?utf-8?B?RDhFUGRRZzRtajh4Ym1oTkI2bDhhY2dpd1NUYkZWWEtTTDZOdkhnRE9PMmEx?=
 =?utf-8?Q?22/GtERn8Mf4BnNp7ZMFeukVUnUEU19tr0epMH2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fb5c9d-b222-48ba-b368-08d98f147da6
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4665.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 13:14:02.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4fCypcrOiThjKXd6eqxZb0D8UU3SgSoXcDolEIvujVdSPGKwWawoMnAFw3wSA/HIK17YCu4ramTXDulO6PyvzmEUGVVG6taJaW62keaMuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5688
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=749
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110140086
X-Proofpoint-GUID: 3huuDcPgtSW-CnB93BegYQxH706ljSJC
X-Proofpoint-ORIG-GUID: 3huuDcPgtSW-CnB93BegYQxH706ljSJC
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/14/21 4:32AM, Anton Altaparmakov wrote:
> Hi Christoph,
> 
>> On 14 Oct 2021, at 07:28, Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Wed, Oct 13, 2021 at 07:10:13AM +0200, Christoph Hellwig wrote:
>>> I wondered about adding a helper for looking at the size in byte units
>>> to avoid the SECTOR_SHIFT shifts in various places.  But given that
>>> I could not come up with a good name and block devices fundamentally
>>> work in sector size granularity I decided against that.
>>
>> So it seems like the biggest review feedback is that we should have
>> such a helper.  I think the bdev_size name is the worst as size does
>> not imply a particular unit.  bdev_nr_bytes is a little better but I'm
>> not too happy.  Any other suggestions or strong opinions?
> 
> bdev_byte_size() would seem to address your concerns?
> 
> bdev_nr_bytes() would work though - it is analogous to bdev_nr_sectors() after all.
> 
> No strong opinion here but I do agree with you that bdev_size() is a bad choice for sure.  It is bound to cause bugs down the line when people forget what unit it is in.

I don't really mind bdev_size since it's analogous to i_size, but 
bdev_nr_bytes seems good to me.

Shaggy

> Best regards,
> 
> 	Anton
> 
