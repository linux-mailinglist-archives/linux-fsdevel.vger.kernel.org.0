Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D6A4990D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 08:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFRGmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 02:42:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25818 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRGmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560840134; x=1592376134;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3Zp0zqXaGXq1/oaeTAEHn0d9UbL3eTa6TG57DlSVPXQ=;
  b=q8hWspMHVVilYUeeXMYVoQsljvcJ99dxyJRUl3frKkvbmng0+WWZE1rB
   GR/wA0beIqDoNuoQm/r0LH8yLE4S4WM5ZCAFr5tMW9TD8iKyRWtTHS2U7
   nJyTH/pOwPRG/qiGsMauYLd2eZcHLt+fP0hBf5nk4EQz3VWRmIcLnPJw4
   i4nf4RC+kK5zEqDShKZAQkZULKmQV6t4ciHqx9ZnB3OKFa+LgsS9evSKY
   Fuj2ZwXLQOj/paTZ5mKXd3jdkiKSORaYctrjgzImf3Zfzo3aUT+y9Z1R6
   nd1AROhcBkDD917KjNotInDR1OKei3IBRxvbyNHbKjGeIsawZI0pQsBRH
   g==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="210559493"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 14:42:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaXwe4sV6/bMlgTRBf+RMhsPPgXgbS42/j/b2GCD+d8=;
 b=ueHGn4HHtvVtVqDh8LcjCPKRT68UYF75CPl+VKHl14LudeUZzSeheKvK3CSFCeNibSFDP1WYOEzcbByaDwd5CqHfeshxnbMZ5US7eptrGAx8RH/k2EE4PNpmFvxBjMU2LjlVxRMyKVGSB9UNx6ws/Yg7cDfIhXqUoDTp84VvBiI=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB4256.namprd04.prod.outlook.com (52.135.72.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Tue, 18 Jun 2019 06:42:09 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 06:42:09 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 02/19] btrfs: Get zone information of zoned block devices
Thread-Topic: [PATCH 02/19] btrfs: Get zone information of zoned block devices
Thread-Index: AQHVHTJ/1FX3VZfOTkaSGAxvcc7+NQ==
Date:   Tue, 18 Jun 2019 06:42:09 +0000
Message-ID: <SN6PR04MB5231EA9395FB2C4E973BD32F8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-3-naohiro.aota@wdc.com>
 <20190617185708.GH19057@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0e27ef5-7445-4e47-e471-08d6f3b81680
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4256;
x-ms-traffictypediagnostic: SN6PR04MB4256:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB42563A3F272B16B35FA90BFA8CEA0@SN6PR04MB4256.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(366004)(136003)(54094003)(189003)(199004)(1730700003)(64756008)(2906002)(6246003)(66066001)(66556008)(66446008)(6506007)(66476007)(73956011)(476003)(68736007)(76176011)(6306002)(53936002)(486006)(66946007)(53546011)(86362001)(76116006)(478600001)(99286004)(91956017)(81166006)(7696005)(9686003)(966005)(71190400001)(4326008)(71200400001)(72206003)(25786009)(5660300002)(2501003)(446003)(52536014)(5024004)(74316002)(186003)(14444005)(256004)(55016002)(6916009)(81156014)(8936002)(8676002)(33656002)(316002)(26005)(229853002)(5640700003)(2351001)(6116002)(53376002)(102836004)(6436002)(3846002)(305945005)(7736002)(54906003)(14454004)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4256;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pvhe4K+640vSXLtNv1FGOPSm+ObV2mm/Tv8lgvdUPyS5nR5b47sXktNGtUlifNLMQWIBKMy53NOqXo2WYlgrn4o9yIKO1HbHFJ7x7rzMlml5TxlJHRdyUvgcERK6Nb3QnzRFj5/1YjWA7W3YFeIx0onFlPxbIHxr8zWspRGPhWCqSkoGwnZ9gcwhjMdy87K3IHxipgxuv0Otb5TSjNLabOpDDop6+tvI0co9g6Zypi3JBIhCZg4IXN4mtbt7bqd9Pjfi07BQtxTCFoq6pQeleMize/3aNkMRelpD8nfnjTNW4cSqIdbvFfwzYlnjqz8HzURz7EHL0qDA3S/8HhL1nt+208JNxbSS9fXDBCqEHaHvmJJPC288HZNDnJtBYcdDet9oEl9ELTijtFc2dm98P8CZpSnOjaFmsdV4v0312Qw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e27ef5-7445-4e47-e471-08d6f3b81680
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 06:42:09.5462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/18 3:56, David Sterba wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:08PM +0900, Naohiro Aota wrote:=0A=
>> If a zoned block device is found, get its zone information (number of zo=
nes=0A=
>> and zone size) using the new helper function btrfs_get_dev_zonetypes(). =
 To=0A=
>> avoid costly run-time zone report commands to test the device zones type=
=0A=
>> during block allocation, attach the seqzones bitmap to the device struct=
ure=0A=
>> to indicate if a zone is sequential or accept random writes.=0A=
>>=0A=
>> This patch also introduces the helper function btrfs_dev_is_sequential()=
 to=0A=
>> test if the zone storing a block is a sequential write required zone.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/volumes.c | 143 +++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>>   fs/btrfs/volumes.h |  33 +++++++++++=0A=
>>   2 files changed, 176 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c=0A=
>> index 1c2a6e4b39da..b673178718e3 100644=0A=
>> --- a/fs/btrfs/volumes.c=0A=
>> +++ b/fs/btrfs/volumes.c=0A=
>> @@ -786,6 +786,135 @@ static int btrfs_free_stale_devices(const char *pa=
th,=0A=
>>   	return ret;=0A=
>>   }=0A=
>>   =0A=
>> +static int __btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,=
=0A=
> =0A=
> Please drop __ from the name, the pattern where this naming makes sense=
=0A=
> does not apply here. It's for cases where teh function wihout=0A=
> underscores does some extra stuff like locking and the underscored does=
=0A=
> not and this is used on some context. I haven't found=0A=
> btrfs_get_dev_zones in this or other patches.=0A=
> =0A=
>> +				 struct blk_zone **zones,=0A=
>> +				 unsigned int *nr_zones, gfp_t gfp_mask)=0A=
>> +{=0A=
>> +	struct blk_zone *z =3D *zones;=0A=
> =0A=
> This may apply to more places, plese don't use single letter for=0A=
> anything else than 'i' and similar. 'zone' would be suitable.=0A=
=0A=
Sure.=0A=
=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (!z) {=0A=
>> +		z =3D kcalloc(*nr_zones, sizeof(struct blk_zone), GFP_KERNEL);=0A=
>> +		if (!z)=0A=
>> +			return -ENOMEM;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT,=0A=
>> +				  z, nr_zones, gfp_mask);=0A=
>> +	if (ret !=3D 0) {=0A=
>> +		btrfs_err(device->fs_info, "Get zone at %llu failed %d\n",=0A=
> =0A=
> No capital letter and no "\n" at the end of the message, that's added by=
=0A=
> btrfs_er.=0A=
=0A=
oops, I overlooked it...=0A=
=0A=
>> +			  pos, ret);=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	*zones =3D z;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static void btrfs_destroy_dev_zonetypes(struct btrfs_device *device)=0A=
>> +{=0A=
>> +	kfree(device->seq_zones);=0A=
>> +	kfree(device->empty_zones);=0A=
>> +	device->seq_zones =3D NULL;=0A=
>> +	device->empty_zones =3D NULL;=0A=
>> +	device->nr_zones =3D 0;=0A=
>> +	device->zone_size =3D 0;=0A=
>> +	device->zone_size_shift =3D 0;=0A=
>> +}=0A=
>> +=0A=
>> +int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,=0A=
>> +		       struct blk_zone *zone, gfp_t gfp_mask)=0A=
>> +{=0A=
>> +	unsigned int nr_zones =3D 1;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	ret =3D __btrfs_get_dev_zones(device, pos, &zone, &nr_zones, gfp_mask)=
;=0A=
>> +	if (ret !=3D 0 || !nr_zones)=0A=
>> +		return ret ? ret : -EIO;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +int btrfs_get_dev_zonetypes(struct btrfs_device *device)=0A=
>> +{=0A=
>> +	struct block_device *bdev =3D device->bdev;=0A=
>> +	sector_t nr_sectors =3D bdev->bd_part->nr_sects;=0A=
>> +	sector_t sector =3D 0;=0A=
>> +	struct blk_zone *zones =3D NULL;=0A=
>> +	unsigned int i, n =3D 0, nr_zones;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	device->zone_size =3D 0;=0A=
>> +	device->zone_size_shift =3D 0;=0A=
>> +	device->nr_zones =3D 0;=0A=
>> +	device->seq_zones =3D NULL;=0A=
>> +	device->empty_zones =3D NULL;=0A=
>> +=0A=
>> +	if (!bdev_is_zoned(bdev))=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	device->zone_size =3D (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;=0A=
>> +	device->zone_size_shift =3D ilog2(device->zone_size);=0A=
>> +	device->nr_zones =3D nr_sectors >> ilog2(bdev_zone_sectors(bdev));=0A=
>> +	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))=0A=
>> +		device->nr_zones++;=0A=
>> +=0A=
>> +	device->seq_zones =3D kcalloc(BITS_TO_LONGS(device->nr_zones),=0A=
>> +				    sizeof(*device->seq_zones), GFP_KERNEL);=0A=
> =0A=
> What's the expected range for the allocation size? There's one bit per=0A=
> zone, so one 4KiB page can hold up to 32768 zones, with 1GiB it's 32TiB=
=0A=
> of space on the drive. Ok that seems safe for now.=0A=
=0A=
Typically, zone size is 256MB (as default value in tcmu-runner). On such de=
vice,=0A=
we need one 4KB page per 8TB disk space. Still it's quite safe.=0A=
=0A=
>> +	if (!device->seq_zones)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	device->empty_zones =3D kcalloc(BITS_TO_LONGS(device->nr_zones),=0A=
>> +				      sizeof(*device->empty_zones), GFP_KERNEL);=0A=
>> +	if (!device->empty_zones)=0A=
>> +		return -ENOMEM;=0A=
> =0A=
> This leaks device->seq_zones from the current context, though thre are=0A=
> calls to btrfs_destroy_dev_zonetypes that would clean it up eventually.=
=0A=
> It'd be better to clean up here instead of relying on the caller.=0A=
=0A=
Exactly.=0A=
=0A=
>> +=0A=
>> +#define BTRFS_REPORT_NR_ZONES   4096=0A=
> =0A=
> Please move this to the begining of the file if this is just local to=0A=
> the .c file and put a short comment explaining the meaning.=0A=
> =0A=
>> +=0A=
>> +	/* Get zones type */=0A=
>> +	while (sector < nr_sectors) {=0A=
>> +		nr_zones =3D BTRFS_REPORT_NR_ZONES;=0A=
>> +		ret =3D __btrfs_get_dev_zones(device, sector << SECTOR_SHIFT,=0A=
>> +					    &zones, &nr_zones, GFP_KERNEL);=0A=
>> +		if (ret !=3D 0 || !nr_zones) {=0A=
>> +			if (!ret)=0A=
>> +				ret =3D -EIO;=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +=0A=
>> +		for (i =3D 0; i < nr_zones; i++) {=0A=
>> +			if (zones[i].type =3D=3D BLK_ZONE_TYPE_SEQWRITE_REQ)=0A=
>> +				set_bit(n, device->seq_zones);=0A=
>> +			if (zones[i].cond =3D=3D BLK_ZONE_COND_EMPTY)=0A=
>> +				set_bit(n, device->empty_zones);=0A=
>> +			sector =3D zones[i].start + zones[i].len;=0A=
>> +			n++;=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>> +	if (n !=3D device->nr_zones) {=0A=
>> +		btrfs_err(device->fs_info,=0A=
>> +			  "Inconsistent number of zones (%u / %u)\n", n,=0A=
> =0A=
> lowercase and no "\n"=0A=
> =0A=
>> +			  device->nr_zones);=0A=
>> +		ret =3D -EIO;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	btrfs_info(device->fs_info,=0A=
>> +		   "host-%s zoned block device, %u zones of %llu sectors\n",=0A=
>> +		   bdev_zoned_model(bdev) =3D=3D BLK_ZONED_HM ? "managed" : "aware",=
=0A=
>> +		   device->nr_zones, device->zone_size >> SECTOR_SHIFT);=0A=
>> +=0A=
>> +out:=0A=
>> +	kfree(zones);=0A=
>> +=0A=
>> +	if (ret)=0A=
>> +		btrfs_destroy_dev_zonetypes(device);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>>   static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,=
=0A=
>>   			struct btrfs_device *device, fmode_t flags,=0A=
>>   			void *holder)=0A=
>> @@ -842,6 +971,11 @@ static int btrfs_open_one_device(struct btrfs_fs_de=
vices *fs_devices,=0A=
>>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);=0A=
>>   	device->mode =3D flags;=0A=
>>   =0A=
>> +	/* Get zone type information of zoned block devices */=0A=
>> +	ret =3D btrfs_get_dev_zonetypes(device);=0A=
>> +	if (ret !=3D 0)=0A=
>> +		goto error_brelse;=0A=
>> +=0A=
>>   	fs_devices->open_devices++;=0A=
>>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&=0A=
>>   	    device->devid !=3D BTRFS_DEV_REPLACE_DEVID) {=0A=
>> @@ -1243,6 +1377,7 @@ static void btrfs_close_bdev(struct btrfs_device *=
device)=0A=
>>   	}=0A=
>>   =0A=
>>   	blkdev_put(device->bdev, device->mode);=0A=
>> +	btrfs_destroy_dev_zonetypes(device);=0A=
>>   }=0A=
>>   =0A=
>>   static void btrfs_close_one_device(struct btrfs_device *device)=0A=
>> @@ -2664,6 +2799,13 @@ int btrfs_init_new_device(struct btrfs_fs_info *f=
s_info, const char *device_path=0A=
>>   	mutex_unlock(&fs_info->chunk_mutex);=0A=
>>   	mutex_unlock(&fs_devices->device_list_mutex);=0A=
>>   =0A=
>> +	/* Get zone type information of zoned block devices */=0A=
>> +	ret =3D btrfs_get_dev_zonetypes(device);=0A=
>> +	if (ret) {=0A=
>> +		btrfs_abort_transaction(trans, ret);=0A=
>> +		goto error_sysfs;=0A=
> =0A=
> Can this be moved before the locked section so that any failure does not=
=0A=
> lead to transaction abort?=0A=
> =0A=
> The function returns ENOMEM that does not necessarily need to kill the=0A=
> filesystem. And EIO which means that some faulty device is being added=0A=
> to the filesystem but this again should fail early.=0A=
=0A=
OK. I can move that before the transaction starts.=0A=
=0A=
>> +	}=0A=
>> +=0A=
>>   	if (seeding_dev) {=0A=
>>   		mutex_lock(&fs_info->chunk_mutex);=0A=
>>   		ret =3D init_first_rw_device(trans);=0A=
>> @@ -2729,6 +2871,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs=
_info, const char *device_path=0A=
>>   	return ret;=0A=
>>   =0A=
>>   error_sysfs:=0A=
>> +	btrfs_destroy_dev_zonetypes(device);=0A=
>>   	btrfs_sysfs_rm_device_link(fs_devices, device);=0A=
>>   	mutex_lock(&fs_info->fs_devices->device_list_mutex);=0A=
>>   	mutex_lock(&fs_info->chunk_mutex);=0A=
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h=0A=
>> index b8a0e8d0672d..1599641e216c 100644=0A=
>> --- a/fs/btrfs/volumes.h=0A=
>> +++ b/fs/btrfs/volumes.h=0A=
>> @@ -62,6 +62,16 @@ struct btrfs_device {=0A=
>>   =0A=
>>   	struct block_device *bdev;=0A=
>>   =0A=
>> +	/*=0A=
>> +	 * Number of zones, zone size and types of zones if bdev is a=0A=
>> +	 * zoned block device.=0A=
>> +	 */=0A=
>> +	u64 zone_size;=0A=
>> +	u8  zone_size_shift;=0A=
> =0A=
> So the zone_size is always power of two? I may be missing something, but=
=0A=
> I wonder if the calculations based on shifts are safe.=0A=
=0A=
The kernel ZBD support have a restriction that=0A=
"The zone size must also be equal to a power of 2 number of logical blocks.=
"=0A=
http://zonedstorage.io/introduction/linux-support/#zbd-support-restrictions=
=0A=
=0A=
So, the zone_size is guaranteed to be power of two.=0A=
=0A=
>> +	u32 nr_zones;=0A=
>> +	unsigned long *seq_zones;=0A=
>> +	unsigned long *empty_zones;=0A=
>> +=0A=
>>   	/* the mode sent to blkdev_get */=0A=
>>   	fmode_t mode;=0A=
>>   =0A=
>> @@ -476,6 +486,28 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_han=
dle *trans,=0A=
>>   int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_off=
set);=0A=
>>   struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,=
=0A=
>>   				       u64 logical, u64 length);=0A=
>> +int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,=0A=
>> +		       struct blk_zone *zone, gfp_t gfp_mask);=0A=
>> +=0A=
>> +static inline int btrfs_dev_is_sequential(struct btrfs_device *device, =
u64 pos)=0A=
>> +{=0A=
>> +	unsigned int zno =3D pos >> device->zone_size_shift;=0A=
> =0A=
> The types don't match here, pos is u64 and I'm not sure if it's=0A=
> guaranteed that the value after shift will fit ti unsigned int.=0A=
> =0A=
>> +=0A=
>> +	if (!device->seq_zones)=0A=
>> +		return 1;=0A=
>> +=0A=
>> +	return test_bit(zno, device->seq_zones);=0A=
>> +}=0A=
>> +=0A=
>> +static inline int btrfs_dev_is_empty_zone(struct btrfs_device *device, =
u64 pos)=0A=
>> +{=0A=
>> +	unsigned int zno =3D pos >> device->zone_size_shift;=0A=
> =0A=
> Same.=0A=
=0A=
I will fix.=0A=
