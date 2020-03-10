Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1461801D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 16:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgCJPaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 11:30:39 -0400
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com ([40.107.243.88]:18221
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbgCJPaj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:30:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j92WTDvh85LL9DjTAR8v1qBUT6rHQIJYP2ejN356QiHPU/f6oFBMiEwKklJP89U3G48acfh7qFhtMxCv5VSiFmJO3yjCqCJqg52hpZFwIlWqRLkXlHhJWC9RKqdcCLXhqh5BJGbbqj0MCUzD6MDdo8NlaPGiM+TWEG4MKQBQi0s0E/s4mJuYsxis5MMksyHd/FNpwfni0N9e+egnIeJcoURXelcmSJk6vOXE5Z3M3sMKrIsodTTWmVzA7gjeYY0zJ00j0sEVORjGMiMJDH6vPtzYsR/ex/JK9nub62VQjRN9E1w0mmQY5Yu7TspwfS8PgrEHaSxNu13Bn5F5n6fmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fkQcfTs9wPsVJrL8XcAVA/W2xyJK4+3au428pQxJD0=;
 b=d2x0n4pHEvWvtChACl+SFHLA5qacJWCfZfNhGdOiLcNI9irxSvsvc8eE01J1aMapRTdCcpIo7f5wCetHqmoP+ovmcVElLE4f4eqTA0P1bU74Fixr0vJb+OkUcOBxl1EilYpA4eKAhpOOrvuu4OxAzzBY5MhxIxgx1ySzwcvoG+rVJGVSwO0C0AvnRG43q+dP+jag9J1Vd28pV289yz/g1cwfxVAALKsEoxP/npWndzOdQQ/jPm6EkTWc68RbmV/yxGg4islO+A8IGpvubuSDyco9jdeovrN2UNohGsFmkmiHY6wBG/wmHNrtEpmrFD0BU+j5rEIcoEPVH0mwb65yTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fkQcfTs9wPsVJrL8XcAVA/W2xyJK4+3au428pQxJD0=;
 b=aXMcvl5MsOPsibU3jrxJZmnjzVPwcfh1ZWAr4UGi90cN52gsKxiefIXlyvai1zxb04g5LFArpMuFqMMNAfqqCJGMkRI70vJhK2a5oMKiMhAzxhkBRq4sPJBz4hfvnatIe2c/0RJzNNt8S2oUce+td9HSfXH9w+boLw60BLM/874=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB3200.namprd11.prod.outlook.com (2603:10b6:805:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 15:30:37 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 15:30:36 +0000
Subject: Re: disk revalidation updates and OOM
To:     Christoph Hellwig <hch@lst.de>
Cc:     jack@suse.cz, Jens Axboe <axboe@kernel.dk>,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, keith.busch@intel.com,
        tglx@linutronix.de, mwilck@suse.com, yuyufen@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
 <20200310074018.GB26381@lst.de>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <75865e17-48f8-a63a-3a29-f995115ffcfc@windriver.com>
Date:   Tue, 10 Mar 2020 23:30:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200310074018.GB26381@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR02CA0156.apcprd02.prod.outlook.com (2603:1096:201:1f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Tue, 10 Mar 2020 15:30:33 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 842dd433-f9c8-43cb-3eeb-08d7c507fb31
X-MS-TrafficTypeDiagnostic: SN6PR11MB3200:
X-Microsoft-Antispam-PRVS: <SN6PR11MB3200197A777544B228C1AD128FFF0@SN6PR11MB3200.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(7416002)(5660300002)(478600001)(86362001)(2616005)(66556008)(16576012)(316002)(66946007)(31696002)(6666004)(956004)(66476007)(53546011)(966005)(52116002)(31686004)(6916009)(186003)(16526019)(4326008)(6486002)(2906002)(36756003)(81166006)(6706004)(81156014)(8676002)(8936002)(26005)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3200;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6YDGfgPPRC3180Dz7vzM5fs4tVEE783SlORKAtMeyith8DmIqaQ1LKmK4tiHc9IWDk8pWyfyxikt+0zmTXkfFAfLzT2gO6vDUhSqOAKy/kXhFJZDA53X+BWB26M/q7/es45HSHEsldN5pHE5ER+C9Vxz5CczSsicR29ShOCM0dCh2XZ1VkbvWgwmAk7dQlOF4X33gDrP1A6XzS2AI9V6VpKpC3RlKMqgGhixnAEHVrKQMkpsJlx6K/LT2dACH4H4vEu4EU/9a6whM9F9Vz5wvH7yKJhfFm/sEevxbcBtp/RpnUb6nfVIKP9uvxEdYCAkv1BT4nWayTbwXMQvtVNWnYaOCa7eHEaWlBHz35zwLscO91T2UcOvm9psd09E6SxcNTqSXGFWTdqXCGJ3Abz9QR8XP7Tilp05ItiRTT9Ve9sac9yChYc4D2ehxb1zVTi+I9qbrX8OOeD3lRbu0y9NWUQuzusjvSV1+XwbobHchW8NGxJh6BJa15kzawwhUtkH2DbPibsz9X7aKimwk/bwnW3c97YU6xmYFbQJLc0/Efz76u79/4hxtLfjScfNj30VXMv5kJy8dBp4CRV8eCQ2LVzVHxudL91LjPHOwYoa9M=
X-MS-Exchange-AntiSpam-MessageData: YdhU9ISHZfYoZ5+rG/I9JgUBacgvVbVmyqBKJtRoai8XOI7kDwsU6GJL5ceF0vacNueuTefOVX12BGtUY2M22utmHNLBnKKQ1TWqaon8+q/s+GHIajtgsJqV2919uMS3YZ2ONourotqNnNHckVq3NQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842dd433-f9c8-43cb-3eeb-08d7c507fb31
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 15:30:36.7735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUwm0dOaOWwDV+WM5FjFSZ7HX7eSmOqOUgysBh4vTzS3HeWEIILp4MiMqNGfmzQXxhh0keIH8RzIBSKthJuG1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3200
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/10/20 3:40 PM, Christoph Hellwig wrote:
> On Mon, Mar 02, 2020 at 11:55:44AM +0800, He Zhe wrote:
>> Hi,
>>
>> Since the following commit
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.5/disk-revalidate&id=6917d0689993f46d97d40dd66c601d0fd5b1dbdd
>> until now(v5.6-rc4),
>>
>> If we start udisksd service of systemd(v244), systemd-udevd will scan /dev/hdc
>> (the cdrom device created by default in qemu(v4.2.0)). systemd-udevd will
>> endlessly run and cause OOM.
>>
>>
>>
>> It works well by reverting the following series of commits.
>>
>> 979c690d block: move clearing bd_invalidated into check_disk_size_change
>> f0b870d block: remove (__)blkdev_reread_part as an exported API
>> 142fe8f block: fix bdev_disk_changed for non-partitioned devices
>> a1548b6 block: move rescan_partitions to fs/block_dev.c
>> 6917d06 block: merge invalidate_partitions into rescan_partitions
> So this is the exact requirement of commits to be reverted from a bisect
> or just a first guess?

Many commits failed to build or boot during bisection.

At least the following four have to be reverted to make it work.

979c690d block: move clearing bd_invalidated into check_disk_size_change
f0b870d block: remove (__)blkdev_reread_part as an exported API
142fe8f block: fix bdev_disk_changed for non-partitioned devices
a1548b6 block: move rescan_partitions to fs/block_dev.c

Regards,
Zhe


