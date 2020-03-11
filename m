Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE07180ED3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 05:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCKEDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 00:03:55 -0400
Received: from mail-eopbgr770072.outbound.protection.outlook.com ([40.107.77.72]:35150
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbgCKEDz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 00:03:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/knOl/+cZEbv2jPXy/ozNPU7/U9u2/+kADOd839FMdTZbt75Dx0YRyo+nK90tJuIGNXMwykPfvA2yiA0KsID9s5oZtozN+NRo5MHzGDQWThs61z9dF9hPm/CVXVvdKj5CjA4Zh7G0JokVpScaTb5FOsNAigzNjXYHCMat15oi337G7m8GqXC9ty4Hem25iyLWxmNYddub/nyBThffntIcxNaK3wXyWSiKFL+qs8An/7MglQeHSkEL5yKXNFeMY2JWAeqMOlsqqCJp2QU9PQTU6woifB/EHFedM0z9Cqqgb/I0yQJUugjDXMGzRU9cd8YvmOlasdEj92oKS9Qr8sWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnqGGJ/YZIcJnZUnivCOZ7zrQrNsQLPkFMGyTpbbaGo=;
 b=Nn/DXQjhcFkdX8Rq3nHaqR9Lw/qnZvNv+7K9sPmRIGObkjxBvnv+uVaWu6ArELqWxpxnYQw/KH2Xl9jYbBItfzttYTKmJ70AFdb66inD9KiSjJk0zp8X6wX+oXa3rosttlN2W8zNMHVFR/jLWptgFuthG42kCQA6NpM84yd7wrViNjt22RZfUUWe2cQ6w9YUtgmURS5c3+Ohs3zvRdeoSiq1QFafDAKJnh2PhO9YrhpFOSBMF92nOep1RkgUx+w8hLpUi9ilinOo+eRCwzEiNbHAEZc6B5A7gIfxBNEb952EjVaypIv8egsYVbV7FbxYbns5x2z/fxkbZwlOR5Ffmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnqGGJ/YZIcJnZUnivCOZ7zrQrNsQLPkFMGyTpbbaGo=;
 b=oqzQpnQI3LhAzA69iB28hRQoz7zGbsh1TnPC7HL5yD/iUhX9ZkJYVNkUz6wqzoRr/kHVXuanm13PMwcWq06fN7+apZj/BDM/oVm70+B3XRjs199ly3j8OJQ9bUvNSE9S76nsz9QX4ej5ug+f4oBTnpBtFdhX3MEiggcDo5qVWMg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB3326.namprd11.prod.outlook.com (2603:10b6:805:bc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 04:03:52 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 04:03:52 +0000
Subject: Re: disk revalidation updates and OOM
To:     Christoph Hellwig <hch@lst.de>
Cc:     jack@suse.cz, Jens Axboe <axboe@kernel.dk>,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, keith.busch@intel.com,
        tglx@linutronix.de, mwilck@suse.com, yuyufen@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
 <20200310074018.GB26381@lst.de>
 <75865e17-48f8-a63a-3a29-f995115ffcfc@windriver.com>
 <20200310162647.GA6361@lst.de>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <f48683d9-7854-ba5f-da3a-7ef987a539b8@windriver.com>
Date:   Wed, 11 Mar 2020 12:03:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200310162647.GA6361@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR04CA0089.apcprd04.prod.outlook.com
 (2603:1096:202:15::33) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR04CA0089.apcprd04.prod.outlook.com (2603:1096:202:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 04:03:48 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9d315c3-787b-4613-0f20-08d7c57135d2
X-MS-TrafficTypeDiagnostic: SN6PR11MB3326:
X-Microsoft-Antispam-PRVS: <SN6PR11MB33262F37B1467137265B66E28FFC0@SN6PR11MB3326.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39850400004)(346002)(136003)(199004)(7416002)(5660300002)(478600001)(66946007)(2616005)(66556008)(31696002)(16576012)(316002)(53546011)(6666004)(956004)(66476007)(86362001)(4326008)(16526019)(186003)(6706004)(36756003)(6916009)(52116002)(8936002)(2906002)(31686004)(81166006)(81156014)(8676002)(6486002)(26005)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3326;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nhI65631lvmXxV54X7imbeEedGahUGyggZJkItO8E7twz4cMjuXh1GFiDkuLSC6Q1V6m1ih+8jTyRjtgUqUS1HxvTgXdB2uYEuL1VUuwusaq0d/r+K0Q4bYtTiAfI0d0K9z+QfXSJJOAvkFtQCUsItCDyDOh7a7vgmK3tuCvb3ceF5VaMe3LqeKKUaLDMzTrwutzvyrOuuvnOTRXJIvU2ZExUe7xpBWtoGB9z5NVfl9LC5Yu0vbuAm/r5QmtLvMlMg/sEZZPqJJwJMTAYRRfNUImuQ/FnHYRmOYpEzNr6p74wMgC8WnlerCejx663n0CGOYeXsMkCur62incy607yZNhemSP1Qs+i9bCvXtdFbCeknN99i/ViucD1KD1tDh/HhHBu8b6dLbWi/GEZptNFfp4YRk30kzQFo0BYbvpY3j60Zg7bOmBR3BJpVEeqoV8EghzaBXjhqslSbRuiz3qlvwwLAdXz4SFXuvZ35aQUOjwlUFGKodztlPvKxfortLbVQd4pxGpFWg0yEgk/QpiIAsewxx8vPNhEY8IdoivIM=
X-MS-Exchange-AntiSpam-MessageData: BedbGS+2nS9CO5QJBC7eE+rsTzoovuNbosfvHruMKaYtqRuNtvex4Eg7TZ98mDnwEG+VWnFWmLRv7b+6ufhl4ZKlf8I8porx1mhDwdlphNwK3fYxBy+LJtwg4XiiQh/7VST0eNghLeRdiaDitpst7Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d315c3-787b-4613-0f20-08d7c57135d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 04:03:52.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NvsCwhHK+tkhvM0pSwpSIkl0TzcWUyIgQzdqImYoFZ/YvAxllf3B98HBXfciHWHhIKhXZZJJz3MKhb7Z/EJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3326
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/11/20 12:26 AM, Christoph Hellwig wrote:
> On Tue, Mar 10, 2020 at 11:30:27PM +0800, He Zhe wrote:
>>> So this is the exact requirement of commits to be reverted from a bisect
>>> or just a first guess?
>> Many commits failed to build or boot during bisection.
>>
>> At least the following four have to be reverted to make it work.
>>
>> 979c690d block: move clearing bd_invalidated into check_disk_size_change
>> f0b870d block: remove (__)blkdev_reread_part as an exported API
>> 142fe8f block: fix bdev_disk_changed for non-partitioned devices
>> a1548b6 block: move rescan_partitions to fs/block_dev.c
> Just to make sure we are on the same page:  if you revert all four it
> works, if you rever all but
>
> a1548b6 block: move rescan_partitions to fs/block_dev.c
>
> it doesn't?

After reverting 142fe8f, rescan_partitions would be called in block/ioctl.c
and cause a build failure. So I need to also revert a1548b6 to provide
rescan_partitions.

OR if I manually add the following diff instead of reverting a1548b6, then yes,
it works too.

diff --git a/block/ioctl.c b/block/ioctl.c
index 8d724d11c8f5..bac562604cd0 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -192,6 +192,7 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
  * acquire bd_mutex. This API should be used in case that
  * caller has held bd_mutex already.
  */
+extern int rescan_partitions(struct gendisk *disk, struct block_device *bdev, bool invalidate);
 int __blkdev_reread_part(struct block_device *bdev)
 {
        struct gendisk *disk = bdev->bd_disk;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index ec10dacd18d0..30da0bc85c31 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1508,7 +1508,7 @@ EXPORT_SYMBOL(bd_set_size);

 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);

-static int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
+int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
                bool invalidate)
 {
        int ret;


Zhe


