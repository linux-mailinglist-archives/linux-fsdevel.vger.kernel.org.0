Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888B549C61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 10:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfFRIvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 04:51:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40494 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfFRIvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560847877; x=1592383877;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JPmgfHqHIj1FFoqOj1YMmaH9l9c47IVviYmGgKks2FI=;
  b=Ke/dVtUiYrhtWqfi9hbhVShi7HVYzKZ9SjxKOAwHmyrMbSQQdNQcoF1y
   aQw1bmuJOSgIu/62WqzOtwnNOxrreLnuAZpMMArmWTOYg5SLmgoq4BziM
   NQnmJPVZdILfrQaYJauOsrCYCJPG0IwxC3/c0NnQOIySBZA6z+QW+ngeF
   W9ViU9WekbBBvvojPTkGNgq1YsRos2pvvJIopS2DtO6vf+IdS7KBhQqmD
   dwUTip3VaInVu69h16SRSc8+V5h+BKJxZPQbnWX6ggRyfsu+3lfkvW14o
   ZGWeQDbVavRZ9/LizOi/IcuzCoaese0el5k4SRManUzlX8sk0pObd1Nca
   g==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="115748223"
Received: from mail-co1nam03lp2052.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.52])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 16:51:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDZgC72Z+qhOz3g2KA+XE8fuCq+7eBYrjIQ6QdWUgrI=;
 b=vFXxG+gN3TDMzei0QtnaWh9YvIScvcc1eFFFSvh/PvxZTblFmys1YxRP5hUsg/CixMnwgYrxg6/ph8vWvnctc34EliB32kLrZDYSfZE9Z4S8aO+79xWGrompMuRXQaO6FZqbZNpr8FqTh3ySAizBcJj8zfbSXrSU/cXbek2Qqk8=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB4510.namprd04.prod.outlook.com (52.135.120.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Tue, 18 Jun 2019 08:51:14 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 08:51:14 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
Thread-Topic: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
Thread-Index: AQHVHTKI41mlZbldhUiKC20uoMUKKg==
Date:   Tue, 18 Jun 2019 08:51:14 +0000
Message-ID: <SN6PR04MB5231E669DDB952D5EB9C12238CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-10-naohiro.aota@wdc.com>
 <20190613141232.nud7gqz622ewcyzp@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c32c10c-71a4-440d-8063-08d6f3ca1eeb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4510;
x-ms-traffictypediagnostic: SN6PR04MB4510:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB45105A029C004A1BF2917E398CEA0@SN6PR04MB4510.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(73956011)(7696005)(76176011)(5660300002)(99286004)(316002)(102836004)(6506007)(3846002)(6116002)(256004)(8936002)(14444005)(52536014)(53546011)(2906002)(68736007)(6436002)(54906003)(478600001)(33656002)(14454004)(86362001)(55016002)(81156014)(81166006)(7736002)(8676002)(305945005)(72206003)(71190400001)(71200400001)(53936002)(6916009)(9686003)(229853002)(74316002)(446003)(26005)(66556008)(25786009)(66476007)(476003)(6246003)(486006)(4326008)(66946007)(64756008)(76116006)(66446008)(91956017)(7416002)(186003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4510;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZA8Xm/BBiHYiZYxxWBT58mAlud/p7p3h+3eCguZfgcDTilDjfUwxcYrHd/rrvWF3l99mbjoLm+nq5DoTctgqAXzvC9Z1Dx94uQMF4Oz7Ge+WhqzdrNNsGEV3A56kP3OT0Iy+Ih7feymkFriLIO/hyg0s/QTPjvku0jNoy4taodblsJo3bxXQm6LMsxH1FY9FV1pej1MqIbljGPB/El9tlHcBpYLAKd7McfbzQPnOMLVc/k9lsht5cQ+o7C4tYRKHBmLYq0PaeK6UugawJxRtt19/4WeJgLfGCFPGNo6WNXR+FDszfnCYkDfDlxrrmljCAP9OQJPINyqO+hWhmyz68m+qhepOOEFtLvDy1e/mONOjr1qbtQf05PB+AssHqsDrShZOmCTt0s8p6Tp/dSJswCeds4lJE+GURcnrV2hIxgg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c32c10c-71a4-440d-8063-08d6f3ca1eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 08:51:14.5338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4510
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/13 23:13, Josef Bacik wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:15PM +0900, Naohiro Aota wrote:=0A=
>> When in HMZONED mode, make sure that device super blocks are located in=
=0A=
>> randomly writable zones of zoned block devices. That is, do not write su=
per=0A=
>> blocks in sequential write required zones of host-managed zoned block=0A=
>> devices as update would not be possible.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/disk-io.c     | 11 +++++++++++=0A=
>>   fs/btrfs/disk-io.h     |  1 +=0A=
>>   fs/btrfs/extent-tree.c |  4 ++++=0A=
>>   fs/btrfs/scrub.c       |  2 ++=0A=
>>   4 files changed, 18 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index 7c1404c76768..ddbb02906042 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -3466,6 +3466,13 @@ struct buffer_head *btrfs_read_dev_super(struct b=
lock_device *bdev)=0A=
>>   	return latest;=0A=
>>   }=0A=
>>   =0A=
>> +int btrfs_check_super_location(struct btrfs_device *device, u64 pos)=0A=
>> +{=0A=
>> +	/* any address is good on a regular (zone_size =3D=3D 0) device */=0A=
>> +	/* non-SEQUENTIAL WRITE REQUIRED zones are capable on a zoned device *=
/=0A=
> =0A=
> This is not how you do multi-line comments in the kernel.  Thanks,=0A=
> =0A=
> Josef=0A=
> =0A=
=0A=
Thanks. I'll fix the style.=0A=
# I thought the checkpatch was catching this ...=0A=
