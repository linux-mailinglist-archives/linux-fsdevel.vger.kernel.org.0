Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD11849CD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 11:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfFRJO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 05:14:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17038 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfFRJO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560849298; x=1592385298;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=a7F43Exi77OElIGgveto//PCSLiiDVmwACL6Qa5kcqs=;
  b=F3PdoJ/yFh8jccZ0N1xHx7Zn5voMeEXzRp0/W10FUGmMb9C1jZmJ4kZD
   kqxcRWvj9/NGNhpRlqTCr+wddBKhFU2N6BEWY4y0i6uXFFjkZ39R1AgtX
   gxA2Oi0siirLoYhz0Athp7ycXgDMMbEvpMFiSbWOHr+z7mvkZGs8j28/u
   9/2WZaMWoKgNee7exxbWhIvpuD5bIUExypL0iQyy/j+kS+hPesYcC8IPb
   gIHhZkVPwh3qg1ad9C2eZtKNcUWe53CJp8sd3RrTSY3pWkp5fP7U9iO0R
   oYDUN90h8kHsRbW6Y2MN8sIdYiXSy/UickD3Y6ZnodEaPmW5tHdbMyN91
   A==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="112087348"
Received: from mail-co1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.59])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 17:14:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtO+0GCJloc07vA1Ja7pgJ4MlE6YImLZcjlbdBQee/Q=;
 b=dsk9CxOOH3a8zcKQv2g1n9KtsD9iYKEum8mPjiRaI2SZK/BwcAoQ4BtlIZrsAj/y0qVTf/U/eNOrZkGkU/F9ej6qbAGJ5kLjwwD1M+LmD/B6vKsQWyek6Y7e7dCzvwemgjWUv8ruOdUP76qXFzaAJanIdrboreXxiGkGfx1tGnI=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB4672.namprd04.prod.outlook.com (52.135.122.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 09:14:55 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 09:14:55 +0000
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
Subject: Re: [PATCH 18/19] btrfs: support dev-replace in HMZONED mode
Thread-Topic: [PATCH 18/19] btrfs: support dev-replace in HMZONED mode
Thread-Index: AQHVHTKWTu1f5r2pQ0ySJDdTY5xVkg==
Date:   Tue, 18 Jun 2019 09:14:55 +0000
Message-ID: <SN6PR04MB5231A13B01B410DA158530968CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-19-naohiro.aota@wdc.com>
 <20190613143325.bxcbsx5y44upgqle@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb145330-90fd-44f6-f3b5-08d6f3cd6d95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4672;
x-ms-traffictypediagnostic: SN6PR04MB4672:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4672488E724B6AAC9990157D8CEA0@SN6PR04MB4672.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(229853002)(6916009)(71190400001)(71200400001)(72206003)(256004)(14444005)(68736007)(26005)(186003)(81156014)(8676002)(81166006)(54906003)(55016002)(6436002)(476003)(76116006)(9686003)(91956017)(446003)(66946007)(74316002)(6116002)(3846002)(7736002)(73956011)(305945005)(2906002)(64756008)(66446008)(66556008)(66476007)(316002)(53936002)(99286004)(6246003)(486006)(6506007)(7696005)(52536014)(8936002)(25786009)(4326008)(53546011)(66066001)(86362001)(14454004)(33656002)(7416002)(478600001)(102836004)(76176011)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4672;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T6Zpd606FfQ8z5il1YgHSnqYra/uxHEna4p3GVLsrZHtlDC9GFIZ19sBtS87xYBQyrrQ4R3XKbXd+3KQYxZ0+bkXAjvEcVGKg6lYdwDixQ5Y88CUdr9jZZZgUnAay6wmY7xGqtq5jQ7dFMiMqTVe9xxA/2hpOaZ019Y3WF0Q2UtEB0I6j2s1BU3d6fRocQEFQgpq2ePYww1Kkhk9QWQrGXjaxngya9kTguJN2XY/xFx481VTwhUA6vwYV8gOcpQh86FOZB9HsqnHq4C+ygRZMy1DnNRrgYq7LYcq19p2TMCxU6I56y1i3edlAFHyY8kxkBurgXs5Vtt00yBEjV8CyzUeuLZaKGI+1SAXdJVztmxcuaiUOn9fzvXWu9O2LXVjoMaE27g413EHSusTb3pSlCkXVIoQCVqWi8VgEGgATQc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb145330-90fd-44f6-f3b5-08d6f3cd6d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 09:14:55.0773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4672
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/13 23:33, Josef Bacik wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:24PM +0900, Naohiro Aota wrote:=0A=
>> Currently, dev-replace copy all the device extents on source device to t=
he=0A=
>> target device, and it also clones new incoming write I/Os from users to =
the=0A=
>> source device into the target device.=0A=
>>=0A=
>> Cloning incoming IOs can break the sequential write rule in the target=
=0A=
>> device. When write is mapped in the middle of block group, that I/O is=
=0A=
>> directed in the middle of a zone of target device, which breaks the=0A=
>> sequential write rule.=0A=
>>=0A=
>> However, the cloning function cannot be simply disabled since incoming I=
/Os=0A=
>> targeting already copied device extents must be cloned so that the I/O i=
s=0A=
>> executed on the target device.=0A=
>>=0A=
>> We cannot use dev_replace->cursor_{left,right} to determine whether bio=
=0A=
>> is going to not yet copied region.  Since we have time gap between=0A=
>> finishing btrfs_scrub_dev() and rewriting the mapping tree in=0A=
>> btrfs_dev_replace_finishing(), we can have newly allocated device extent=
=0A=
>> which is never cloned (by handle_ops_on_dev_replace) nor copied (by the=
=0A=
>> dev-replace process).=0A=
>>=0A=
>> So the point is to copy only already existing device extents. This patch=
=0A=
>> introduce mark_block_group_to_copy() to mark existing block group as a=
=0A=
>> target of copying. Then, handle_ops_on_dev_replace() and dev-replace can=
=0A=
>> check the flag to do their job.=0A=
>>=0A=
>> This patch also handles empty region between used extents. Since=0A=
>> dev-replace is smart to copy only used extents on source device, we have=
 to=0A=
>> fill the gap to honor the sequential write rule in the target device.=0A=
>>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/ctree.h       |   1 +=0A=
>>   fs/btrfs/dev-replace.c |  96 +++++++++++++++++++++++=0A=
>>   fs/btrfs/extent-tree.c |  32 +++++++-=0A=
>>   fs/btrfs/scrub.c       | 169 +++++++++++++++++++++++++++++++++++++++++=
=0A=
>>   fs/btrfs/volumes.c     |  27 ++++++-=0A=
>>   5 files changed, 319 insertions(+), 6 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
>> index dad8ea5c3b99..a0be2b96117a 100644=0A=
>> --- a/fs/btrfs/ctree.h=0A=
>> +++ b/fs/btrfs/ctree.h=0A=
>> @@ -639,6 +639,7 @@ struct btrfs_block_group_cache {=0A=
>>   	unsigned int has_caching_ctl:1;=0A=
>>   	unsigned int removed:1;=0A=
>>   	unsigned int wp_broken:1;=0A=
>> +	unsigned int to_copy:1;=0A=
>>   =0A=
>>   	int disk_cache_state;=0A=
>>   =0A=
>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c=0A=
>> index fbe5ea2a04ed..5011b5ce0e75 100644=0A=
>> --- a/fs/btrfs/dev-replace.c=0A=
>> +++ b/fs/btrfs/dev-replace.c=0A=
>> @@ -263,6 +263,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btr=
fs_fs_info *fs_info,=0A=
>>   	device->dev_stats_valid =3D 1;=0A=
>>   	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);=0A=
>>   	device->fs_devices =3D fs_info->fs_devices;=0A=
>> +	if (bdev_is_zoned(bdev)) {=0A=
>> +		ret =3D btrfs_get_dev_zonetypes(device);=0A=
>> +		if (ret) {=0A=
>> +			mutex_unlock(&fs_info->fs_devices->device_list_mutex);=0A=
>> +			goto error;=0A=
>> +		}=0A=
>> +	}=0A=
>>   	list_add(&device->dev_list, &fs_info->fs_devices->devices);=0A=
>>   	fs_info->fs_devices->num_devices++;=0A=
>>   	fs_info->fs_devices->open_devices++;=0A=
>> @@ -396,6 +403,88 @@ static char* btrfs_dev_name(struct btrfs_device *de=
vice)=0A=
>>   		return rcu_str_deref(device->name);=0A=
>>   }=0A=
>>   =0A=
>> +static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,=0A=
>> +				    struct btrfs_device *src_dev)=0A=
>> +{=0A=
>> +	struct btrfs_path *path;=0A=
>> +	struct btrfs_key key;=0A=
>> +	struct btrfs_key found_key;=0A=
>> +	struct btrfs_root *root =3D fs_info->dev_root;=0A=
>> +	struct btrfs_dev_extent *dev_extent =3D NULL;=0A=
>> +	struct btrfs_block_group_cache *cache;=0A=
>> +	struct extent_buffer *l;=0A=
>> +	int slot;=0A=
>> +	int ret;=0A=
>> +	u64 chunk_offset, length;=0A=
>> +=0A=
>> +	path =3D btrfs_alloc_path();=0A=
>> +	if (!path)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	path->reada =3D READA_FORWARD;=0A=
>> +	path->search_commit_root =3D 1;=0A=
>> +	path->skip_locking =3D 1;=0A=
>> +=0A=
>> +	key.objectid =3D src_dev->devid;=0A=
>> +	key.offset =3D 0ull;=0A=
>> +	key.type =3D BTRFS_DEV_EXTENT_KEY;=0A=
>> +=0A=
>> +	while (1) {=0A=
>> +		ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);=0A=
>> +		if (ret < 0)=0A=
>> +			break;=0A=
>> +		if (ret > 0) {=0A=
>> +			if (path->slots[0] >=3D=0A=
>> +			    btrfs_header_nritems(path->nodes[0])) {=0A=
>> +				ret =3D btrfs_next_leaf(root, path);=0A=
>> +				if (ret < 0)=0A=
>> +					break;=0A=
>> +				if (ret > 0) {=0A=
>> +					ret =3D 0;=0A=
>> +					break;=0A=
>> +				}=0A=
>> +			} else {=0A=
>> +				ret =3D 0;=0A=
>> +			}=0A=
>> +		}=0A=
>> +=0A=
>> +		l =3D path->nodes[0];=0A=
>> +		slot =3D path->slots[0];=0A=
>> +=0A=
>> +		btrfs_item_key_to_cpu(l, &found_key, slot);=0A=
>> +=0A=
>> +		if (found_key.objectid !=3D src_dev->devid)=0A=
>> +			break;=0A=
>> +=0A=
>> +		if (found_key.type !=3D BTRFS_DEV_EXTENT_KEY)=0A=
>> +			break;=0A=
>> +=0A=
>> +		if (found_key.offset < key.offset)=0A=
>> +			break;=0A=
>> +=0A=
>> +		dev_extent =3D btrfs_item_ptr(l, slot, struct btrfs_dev_extent);=0A=
>> +		length =3D btrfs_dev_extent_length(l, dev_extent);=0A=
>> +=0A=
>> +		chunk_offset =3D btrfs_dev_extent_chunk_offset(l, dev_extent);=0A=
>> +=0A=
>> +		cache =3D btrfs_lookup_block_group(fs_info, chunk_offset);=0A=
>> +		if (!cache)=0A=
>> +			goto skip;=0A=
>> +=0A=
>> +		cache->to_copy =3D 1;=0A=
>> +=0A=
>> +		btrfs_put_block_group(cache);=0A=
>> +=0A=
>> +skip:=0A=
>> +		key.offset =3D found_key.offset + length;=0A=
>> +		btrfs_release_path(path);=0A=
>> +	}=0A=
>> +=0A=
>> +	btrfs_free_path(path);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>>   static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,=0A=
>>   		const char *tgtdev_name, u64 srcdevid, const char *srcdev_name,=0A=
>>   		int read_src)=0A=
>> @@ -439,6 +528,13 @@ static int btrfs_dev_replace_start(struct btrfs_fs_=
info *fs_info,=0A=
>>   	}=0A=
>>   =0A=
>>   	need_unlock =3D true;=0A=
>> +=0A=
>> +	mutex_lock(&fs_info->chunk_mutex);=0A=
>> +	ret =3D mark_block_group_to_copy(fs_info, src_device);=0A=
>> +	mutex_unlock(&fs_info->chunk_mutex);=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
>> +=0A=
>>   	down_write(&dev_replace->rwsem);=0A=
>>   	switch (dev_replace->replace_state) {=0A=
>>   	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:=0A=
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c=0A=
>> index ff4d55d6ef04..268365dd9a5d 100644=0A=
>> --- a/fs/btrfs/extent-tree.c=0A=
>> +++ b/fs/btrfs/extent-tree.c=0A=
>> @@ -29,6 +29,7 @@=0A=
>>   #include "qgroup.h"=0A=
>>   #include "ref-verify.h"=0A=
>>   #include "rcu-string.h"=0A=
>> +#include "dev-replace.h"=0A=
>>   =0A=
>>   #undef SCRAMBLE_DELAYED_REFS=0A=
>>   =0A=
>> @@ -2022,7 +2023,31 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs=
_info, u64 bytenr,=0A=
>>   			if (btrfs_dev_is_sequential(stripe->dev,=0A=
>>   						    stripe->physical) &&=0A=
>>   			    stripe->length =3D=3D stripe->dev->zone_size) {=0A=
>> -				ret =3D blkdev_reset_zones(stripe->dev->bdev,=0A=
>> +				struct btrfs_device *dev =3D stripe->dev;=0A=
>> +=0A=
>> +				ret =3D blkdev_reset_zones(dev->bdev,=0A=
>> +							 stripe->physical >>=0A=
>> +								 SECTOR_SHIFT,=0A=
>> +							 stripe->length >>=0A=
>> +								 SECTOR_SHIFT,=0A=
>> +							 GFP_NOFS);=0A=
>> +				if (!ret)=0A=
>> +					discarded_bytes +=3D stripe->length;=0A=
>> +				else=0A=
>> +					break;=0A=
>> +				set_bit(stripe->physical >>=0A=
>> +					dev->zone_size_shift,=0A=
>> +					dev->empty_zones);=0A=
>> +=0A=
>> +				if (!btrfs_dev_replace_is_ongoing(=0A=
>> +					    &fs_info->dev_replace) ||=0A=
>> +				    stripe->dev !=3D fs_info->dev_replace.srcdev)=0A=
>> +					continue;=0A=
>> +=0A=
>> +				/* send to target as well */=0A=
>> +				dev =3D fs_info->dev_replace.tgtdev;=0A=
>> +=0A=
>> +				ret =3D blkdev_reset_zones(dev->bdev,=0A=
> =0A=
> This is unrelated to dev replace isn't it?  Please make this it's own pat=
ch, and=0A=
> it's own helper while you are at it.  Thanks,=0A=
> =0A=
> Josef=0A=
> =0A=
=0A=
Actually, patch 0015 introduced zone reset here. And this patch extend that=
 code=0A=
to reset also the corresponding zone when dev_replace is on going. The diff=
 is=0A=
messed up here.=0A=
=0A=
I'll add the reset helper in the next version.=0A=
Thanks,=0A=
