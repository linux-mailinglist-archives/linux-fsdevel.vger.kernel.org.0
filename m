Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 958E949C03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 10:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfFRI2L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 04:28:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10144 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFRI2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560846489; x=1592382489;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7BTXutLJ3DxgQty2X0RN3Vj6xmBbXSIJGigukP1J+Gg=;
  b=MQBXcVtbVysOC/gSmnusOBrMbABz5fUOn1SRP2kGSg9UnpB0pufqgBuD
   l0HcmDRqMgafRhf+osHaNo+9FhfWw8CcOc5Xz96Nz7LfolPyui56Hm+2F
   9UOV8yr1lYbCCdCBy8J6RYjLkJiLRm9cujwgv58X9sbFwZKzrA+r46Oc6
   Sx5zfXXKlDULlvnttTEq4wJowNxXrPZ3eYdtSCtTwLTamcea3tmQvypic
   MVwypozdy5CpZmXNrbBQNtl0EWHP3R46Zi2JKvTzaVtEizCDDzk3FYhSa
   8wAXvg8e6L5ZiCIgJhOaGK+3B4mMif5cOZJ3FgxixRGjPLzu3yxnlfYxk
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="112485855"
Received: from mail-sn1nam01lp2058.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.58])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 16:28:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUQc83vovP2lDBkZPo/otsL8FFUFC6JyvPrcHHOVfHc=;
 b=sn+NbNwxq0kUOX0K/WhbyimmBOuU5f217ULG1DihvmR4Nfbhvz0z8yA2l6vz7U1+v6QUQYJOEgE5jXPuQpiVqePzQqx0gGqor1NGamdcnOpj4ZgihOv2MkWjQ9aeOOj07d1NtmmjEtW813pxjDCMyYPba3e/IOQTbmVeuF4sZ/Q=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6SPR01MB0020.namprd04.prod.outlook.com (52.135.120.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.14; Tue, 18 Jun 2019 08:28:07 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 08:28:07 +0000
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
Subject: Re: [PATCH 07/19] btrfs: do sequential extent allocation in HMZONED
 mode
Thread-Topic: [PATCH 07/19] btrfs: do sequential extent allocation in HMZONED
 mode
Thread-Index: AQHVHTKH5ZMIOOZPzkO0O0dCfooG+w==
Date:   Tue, 18 Jun 2019 08:28:07 +0000
Message-ID: <SN6PR04MB5231A70D08002CA9181D9E468CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-8-naohiro.aota@wdc.com>
 <20190613140722.lt6mvxnddnjg5lvx@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d442564c-7060-4b5a-5e3a-08d6f3c6e429
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6SPR01MB0020;
x-ms-traffictypediagnostic: SN6SPR01MB0020:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6SPR01MB0020C7618CB4CBFA3538C5768CEA0@SN6SPR01MB0020.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(366004)(396003)(136003)(189003)(199004)(26005)(186003)(305945005)(316002)(30864003)(66946007)(478600001)(86362001)(33656002)(54906003)(81166006)(66476007)(68736007)(73956011)(8676002)(8936002)(4326008)(6916009)(81156014)(14454004)(66066001)(64756008)(7416002)(72206003)(2906002)(66446008)(91956017)(76116006)(14444005)(256004)(486006)(476003)(53546011)(102836004)(6506007)(5660300002)(25786009)(66556008)(71200400001)(71190400001)(99286004)(6116002)(3846002)(9686003)(6436002)(7696005)(53936002)(7736002)(229853002)(55016002)(74316002)(52536014)(76176011)(446003)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6SPR01MB0020;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IJ3idqkSExPWWHd10WKGm4UECYKeqHcdP26f1jd5auUu/ReEnIqOF5ER6BvJ6GZrB4lUZSDJVuzdYJBN1iXOvPzU3i65JChiHC5Sk73Lbn0ZRvo1QU2NCN7EY42zdMJqNKvTPeXVOUnI9PkNybadxHyrvGqjhXWRg+yXki648D9DhypCWG6FmVFFa8hBz054zqWyZy6pTdOTa06GN4Gi8TBkdlxAEDlFbjldDPCp4loAzR8hOZD9nFR8o9TcVp9URt4yr93ovgNeQ+P8g9/xjSL1FHxHS27GSgoSIc39+92Hyaf9Jp6eSD+4zbnzDXaT2pRUxvVBVuw5BuIft3K9nP7zmYKxh09jrHjT1r4Bav5B6rwYTLrAox+LTGVIGGyFO8vEixVBG6uRDdgc1yKn4I9wCY1mxq+zxGbkOd7IjNw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d442564c-7060-4b5a-5e3a-08d6f3c6e429
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 08:28:07.4985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6SPR01MB0020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/13 23:07, Josef Bacik wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:13PM +0900, Naohiro Aota wrote:=0A=
>> @@ -9616,7 +9701,8 @@ static int inc_block_group_ro(struct btrfs_block_g=
roup_cache *cache, int force)=0A=
>>   	}=0A=
>>   =0A=
>>   	num_bytes =3D cache->key.offset - cache->reserved - cache->pinned -=
=0A=
>> -		    cache->bytes_super - btrfs_block_group_used(&cache->item);=0A=
>> +		    cache->bytes_super - cache->unusable -=0A=
>> +		    btrfs_block_group_used(&cache->item);=0A=
>>   	sinfo_used =3D btrfs_space_info_used(sinfo, true);=0A=
>>   =0A=
>>   	if (sinfo_used + num_bytes + min_allocable_bytes <=3D=0A=
>> @@ -9766,6 +9852,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_g=
roup_cache *cache)=0A=
>>   	if (!--cache->ro) {=0A=
>>   		num_bytes =3D cache->key.offset - cache->reserved -=0A=
>>   			    cache->pinned - cache->bytes_super -=0A=
>> +			    cache->unusable -=0A=
>>   			    btrfs_block_group_used(&cache->item);=0A=
> =0A=
> You've done this in a few places, but not all the places, most notably=0A=
> btrfs_space_info_used() which is used in the space reservation code a lot=
.=0A=
=0A=
I added "unsable" to struct btrfs_block_group_cache, but added=0A=
nothing to struct btrfs_space_info. Once extent is allocated and=0A=
freed in an ALLOC_SEQ Block Group, such extent is never resued=0A=
until we remove the BG. I'm accounting the size of such region=0A=
in "cache->unusable" and in "space_info->bytes_readonly". So,=0A=
btrfs_space_info_used() does not need the modify.=0A=
=0A=
I admit it's confusing here. I can add "bytes_zone_unusable" to=0A=
struct btrfs_space_info, if it's better.=0A=
=0A=
>>   		sinfo->bytes_readonly -=3D num_bytes;=0A=
>>   		list_del_init(&cache->ro_list);=0A=
>> @@ -10200,11 +10287,240 @@ static void link_block_group(struct btrfs_blo=
ck_group_cache *cache)=0A=
>>   	}=0A=
>>   }=0A=
>>   =0A=
>> +static int=0A=
>> +btrfs_get_block_group_alloc_offset(struct btrfs_block_group_cache *cach=
e)=0A=
>> +{=0A=
>> +	struct btrfs_fs_info *fs_info =3D cache->fs_info;=0A=
>> +	struct extent_map_tree *em_tree =3D &fs_info->mapping_tree.map_tree;=
=0A=
>> +	struct extent_map *em;=0A=
>> +	struct map_lookup *map;=0A=
>> +	struct btrfs_device *device;=0A=
>> +	u64 logical =3D cache->key.objectid;=0A=
>> +	u64 length =3D cache->key.offset;=0A=
>> +	u64 physical =3D 0;=0A=
>> +	int ret, alloc_type;=0A=
>> +	int i, j;=0A=
>> +	u64 *alloc_offsets =3D NULL;=0A=
>> +=0A=
>> +#define WP_MISSING_DEV ((u64)-1)=0A=
>> +=0A=
>> +	/* Sanity check */=0A=
>> +	if (!IS_ALIGNED(length, fs_info->zone_size)) {=0A=
>> +		btrfs_err(fs_info, "unaligned block group at %llu + %llu",=0A=
>> +			  logical, length);=0A=
>> +		return -EIO;=0A=
>> +	}=0A=
>> +=0A=
>> +	/* Get the chunk mapping */=0A=
>> +	em_tree =3D &fs_info->mapping_tree.map_tree;=0A=
>> +	read_lock(&em_tree->lock);=0A=
>> +	em =3D lookup_extent_mapping(em_tree, logical, length);=0A=
>> +	read_unlock(&em_tree->lock);=0A=
>> +=0A=
>> +	if (!em)=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	map =3D em->map_lookup;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Get the zone type: if the group is mapped to a non-sequential zone,=
=0A=
>> +	 * there is no need for the allocation offset (fit allocation is OK).=
=0A=
>> +	 */=0A=
>> +	alloc_type =3D -1;=0A=
>> +	alloc_offsets =3D kcalloc(map->num_stripes, sizeof(*alloc_offsets),=0A=
>> +				GFP_NOFS);=0A=
>> +	if (!alloc_offsets) {=0A=
>> +		free_extent_map(em);=0A=
>> +		return -ENOMEM;=0A=
>> +	}=0A=
>> +=0A=
>> +	for (i =3D 0; i < map->num_stripes; i++) {=0A=
>> +		int is_sequential;=0A=
>> +		struct blk_zone zone;=0A=
>> +=0A=
>> +		device =3D map->stripes[i].dev;=0A=
>> +		physical =3D map->stripes[i].physical;=0A=
>> +=0A=
>> +		if (device->bdev =3D=3D NULL) {=0A=
>> +			alloc_offsets[i] =3D WP_MISSING_DEV;=0A=
>> +			continue;=0A=
>> +		}=0A=
>> +=0A=
>> +		is_sequential =3D btrfs_dev_is_sequential(device, physical);=0A=
>> +		if (alloc_type =3D=3D -1)=0A=
>> +			alloc_type =3D is_sequential ?=0A=
>> +					BTRFS_ALLOC_SEQ : BTRFS_ALLOC_FIT;=0A=
>> +=0A=
>> +		if ((is_sequential && alloc_type !=3D BTRFS_ALLOC_SEQ) ||=0A=
>> +		    (!is_sequential && alloc_type =3D=3D BTRFS_ALLOC_SEQ)) {=0A=
>> +			btrfs_err(fs_info, "found block group of mixed zone types");=0A=
>> +			ret =3D -EIO;=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +=0A=
>> +		if (!is_sequential)=0A=
>> +			continue;=0A=
>> +=0A=
>> +		/* this zone will be used for allocation, so mark this=0A=
>> +		 * zone non-empty=0A=
>> +		 */=0A=
>> +		clear_bit(physical >> device->zone_size_shift,=0A=
>> +			  device->empty_zones);=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * The group is mapped to a sequential zone. Get the zone write=0A=
>> +		 * pointer to determine the allocation offset within the zone.=0A=
>> +		 */=0A=
>> +		WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));=0A=
>> +		ret =3D btrfs_get_dev_zone(device, physical, &zone, GFP_NOFS);=0A=
>> +		if (ret =3D=3D -EIO || ret =3D=3D -EOPNOTSUPP) {=0A=
>> +			ret =3D 0;=0A=
>> +			alloc_offsets[i] =3D WP_MISSING_DEV;=0A=
>> +			continue;=0A=
>> +		} else if (ret) {=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +=0A=
>> +=0A=
>> +		switch (zone.cond) {=0A=
>> +		case BLK_ZONE_COND_OFFLINE:=0A=
>> +		case BLK_ZONE_COND_READONLY:=0A=
>> +			btrfs_err(fs_info, "Offline/readonly zone %llu",=0A=
>> +				  physical >> device->zone_size_shift);=0A=
>> +			alloc_offsets[i] =3D WP_MISSING_DEV;=0A=
>> +			break;=0A=
>> +		case BLK_ZONE_COND_EMPTY:=0A=
>> +			alloc_offsets[i] =3D 0;=0A=
>> +			break;=0A=
>> +		case BLK_ZONE_COND_FULL:=0A=
>> +			alloc_offsets[i] =3D fs_info->zone_size;=0A=
>> +			break;=0A=
>> +		default:=0A=
>> +			/* Partially used zone */=0A=
>> +			alloc_offsets[i] =3D=0A=
>> +				((zone.wp - zone.start) << SECTOR_SHIFT);=0A=
>> +			break;=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>> +	if (alloc_type =3D=3D BTRFS_ALLOC_FIT)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {=0A=
>> +	case 0: /* single */=0A=
>> +	case BTRFS_BLOCK_GROUP_DUP:=0A=
>> +	case BTRFS_BLOCK_GROUP_RAID1:=0A=
>> +		cache->alloc_offset =3D WP_MISSING_DEV;=0A=
>> +		for (i =3D 0; i < map->num_stripes; i++) {=0A=
>> +			if (alloc_offsets[i] =3D=3D WP_MISSING_DEV)=0A=
>> +				continue;=0A=
>> +			if (cache->alloc_offset =3D=3D WP_MISSING_DEV)=0A=
>> +				cache->alloc_offset =3D alloc_offsets[i];=0A=
>> +			if (alloc_offsets[i] =3D=3D cache->alloc_offset)=0A=
>> +				continue;=0A=
>> +=0A=
>> +			btrfs_err(fs_info,=0A=
>> +				  "write pointer mismatch: block group %llu",=0A=
>> +				  logical);=0A=
>> +			cache->wp_broken =3D 1;=0A=
>> +		}=0A=
>> +		break;=0A=
>> +	case BTRFS_BLOCK_GROUP_RAID0:=0A=
>> +		cache->alloc_offset =3D 0;=0A=
>> +		for (i =3D 0; i < map->num_stripes; i++) {=0A=
>> +			if (alloc_offsets[i] =3D=3D WP_MISSING_DEV) {=0A=
>> +				btrfs_err(fs_info,=0A=
>> +					  "cannot recover write pointer: block group %llu",=0A=
>> +					  logical);=0A=
>> +				cache->wp_broken =3D 1;=0A=
>> +				continue;=0A=
>> +			}=0A=
>> +=0A=
>> +			if (alloc_offsets[0] < alloc_offsets[i]) {=0A=
>> +				btrfs_err(fs_info,=0A=
>> +					  "write pointer mismatch: block group %llu",=0A=
>> +					  logical);=0A=
>> +				cache->wp_broken =3D 1;=0A=
>> +				continue;=0A=
>> +			}=0A=
>> +=0A=
>> +			cache->alloc_offset +=3D alloc_offsets[i];=0A=
>> +		}=0A=
>> +		break;=0A=
>> +	case BTRFS_BLOCK_GROUP_RAID10:=0A=
>> +		/*=0A=
>> +		 * Pass1: check write pointer of RAID1 level: each pointer=0A=
>> +		 * should be equal.=0A=
>> +		 */=0A=
>> +		for (i =3D 0; i < map->num_stripes / map->sub_stripes; i++) {=0A=
>> +			int base =3D i*map->sub_stripes;=0A=
>> +			u64 offset =3D WP_MISSING_DEV;=0A=
>> +=0A=
>> +			for (j =3D 0; j < map->sub_stripes; j++) {=0A=
>> +				if (alloc_offsets[base+j] =3D=3D WP_MISSING_DEV)=0A=
>> +					continue;=0A=
>> +				if (offset =3D=3D WP_MISSING_DEV)=0A=
>> +					offset =3D alloc_offsets[base+j];=0A=
>> +				if (alloc_offsets[base+j] =3D=3D offset)=0A=
>> +					continue;=0A=
>> +=0A=
>> +				btrfs_err(fs_info,=0A=
>> +					  "write pointer mismatch: block group %llu",=0A=
>> +					  logical);=0A=
>> +				cache->wp_broken =3D 1;=0A=
>> +			}=0A=
>> +			for (j =3D 0; j < map->sub_stripes; j++)=0A=
>> +				alloc_offsets[base+j] =3D offset;=0A=
>> +		}=0A=
>> +=0A=
>> +		/* Pass2: check write pointer of RAID1 level */=0A=
>> +		cache->alloc_offset =3D 0;=0A=
>> +		for (i =3D 0; i < map->num_stripes / map->sub_stripes; i++) {=0A=
>> +			int base =3D i*map->sub_stripes;=0A=
>> +=0A=
>> +			if (alloc_offsets[base] =3D=3D WP_MISSING_DEV) {=0A=
>> +				btrfs_err(fs_info,=0A=
>> +					  "cannot recover write pointer: block group %llu",=0A=
>> +					  logical);=0A=
>> +				cache->wp_broken =3D 1;=0A=
>> +				continue;=0A=
>> +			}=0A=
>> +=0A=
>> +			if (alloc_offsets[0] < alloc_offsets[base]) {=0A=
>> +				btrfs_err(fs_info,=0A=
>> +					  "write pointer mismatch: block group %llu",=0A=
>> +					  logical);=0A=
>> +				cache->wp_broken =3D 1;=0A=
>> +				continue;=0A=
>> +			}=0A=
>> +=0A=
>> +			cache->alloc_offset +=3D alloc_offsets[base];=0A=
>> +		}=0A=
>> +		break;=0A=
>> +	case BTRFS_BLOCK_GROUP_RAID5:=0A=
>> +	case BTRFS_BLOCK_GROUP_RAID6:=0A=
>> +		/* RAID5/6 is not supported yet */=0A=
>> +	default:=0A=
>> +		btrfs_err(fs_info, "Unsupported profile on HMZONED %llu",=0A=
>> +			map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK);=0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +out:=0A=
>> +	cache->alloc_type =3D alloc_type;=0A=
>> +	kfree(alloc_offsets);=0A=
>> +	free_extent_map(em);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
> =0A=
> Move this to the zoned device file that you create.=0A=
=0A=
Sure.=0A=
=0A=
>>   static struct btrfs_block_group_cache *=0A=
>>   btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,=0A=
>>   			       u64 start, u64 size)=0A=
>>   {=0A=
>>   	struct btrfs_block_group_cache *cache;=0A=
>> +	int ret;=0A=
>>   =0A=
>>   	cache =3D kzalloc(sizeof(*cache), GFP_NOFS);=0A=
>>   	if (!cache)=0A=
>> @@ -10238,6 +10554,16 @@ btrfs_create_block_group_cache(struct btrfs_fs_=
info *fs_info,=0A=
>>   	atomic_set(&cache->trimming, 0);=0A=
>>   	mutex_init(&cache->free_space_lock);=0A=
>>   	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);=0A=
>> +	cache->alloc_type =3D BTRFS_ALLOC_FIT;=0A=
>> +	cache->alloc_offset =3D 0;=0A=
>> +=0A=
>> +	if (btrfs_fs_incompat(fs_info, HMZONED)) {=0A=
>> +		ret =3D btrfs_get_block_group_alloc_offset(cache);=0A=
>> +		if (ret) {=0A=
>> +			kfree(cache);=0A=
>> +			return NULL;=0A=
>> +		}=0A=
>> +	}=0A=
>>   =0A=
>>   	return cache;=0A=
>>   }=0A=
>> @@ -10310,6 +10636,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info=
 *info)=0A=
>>   	int need_clear =3D 0;=0A=
>>   	u64 cache_gen;=0A=
>>   	u64 feature;=0A=
>> +	u64 unusable;=0A=
>>   	int mixed;=0A=
>>   =0A=
>>   	feature =3D btrfs_super_incompat_flags(info->super_copy);=0A=
>> @@ -10415,6 +10742,26 @@ int btrfs_read_block_groups(struct btrfs_fs_inf=
o *info)=0A=
>>   			free_excluded_extents(cache);=0A=
>>   		}=0A=
>>   =0A=
>> +		switch (cache->alloc_type) {=0A=
>> +		case BTRFS_ALLOC_FIT:=0A=
>> +			unusable =3D cache->bytes_super;=0A=
>> +			break;=0A=
>> +		case BTRFS_ALLOC_SEQ:=0A=
>> +			WARN_ON(cache->bytes_super !=3D 0);=0A=
>> +			unusable =3D cache->alloc_offset -=0A=
>> +				btrfs_block_group_used(&cache->item);=0A=
>> +			/* we only need ->free_space in ALLOC_SEQ BGs */=0A=
>> +			cache->last_byte_to_unpin =3D (u64)-1;=0A=
>> +			cache->cached =3D BTRFS_CACHE_FINISHED;=0A=
>> +			cache->free_space_ctl->free_space =3D=0A=
>> +				cache->key.offset - cache->alloc_offset;=0A=
>> +			cache->unusable =3D unusable;=0A=
>> +			free_excluded_extents(cache);=0A=
>> +			break;=0A=
>> +		default:=0A=
>> +			BUG();=0A=
>> +		}=0A=
>> +=0A=
>>   		ret =3D btrfs_add_block_group_cache(info, cache);=0A=
>>   		if (ret) {=0A=
>>   			btrfs_remove_free_space_cache(cache);=0A=
>> @@ -10425,7 +10772,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info=
 *info)=0A=
>>   		trace_btrfs_add_block_group(info, cache, 0);=0A=
>>   		update_space_info(info, cache->flags, found_key.offset,=0A=
>>   				  btrfs_block_group_used(&cache->item),=0A=
>> -				  cache->bytes_super, &space_info);=0A=
>> +				  unusable, &space_info);=0A=
>>   =0A=
>>   		cache->space_info =3D space_info;=0A=
>>   =0A=
>> @@ -10438,6 +10785,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info=
 *info)=0A=
>>   			ASSERT(list_empty(&cache->bg_list));=0A=
>>   			btrfs_mark_bg_unused(cache);=0A=
>>   		}=0A=
>> +=0A=
>> +		if (cache->wp_broken)=0A=
>> +			inc_block_group_ro(cache, 1);=0A=
>>   	}=0A=
>>   =0A=
>>   	list_for_each_entry_rcu(space_info, &info->space_info, list) {=0A=
>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c=
=0A=
>> index f74dc259307b..cc69dc71f4c1 100644=0A=
>> --- a/fs/btrfs/free-space-cache.c=0A=
>> +++ b/fs/btrfs/free-space-cache.c=0A=
>> @@ -2326,8 +2326,11 @@ int __btrfs_add_free_space(struct btrfs_fs_info *=
fs_info,=0A=
>>   			   u64 offset, u64 bytes)=0A=
>>   {=0A=
>>   	struct btrfs_free_space *info;=0A=
>> +	struct btrfs_block_group_cache *block_group =3D ctl->private;=0A=
>>   	int ret =3D 0;=0A=
>>   =0A=
>> +	WARN_ON(block_group && block_group->alloc_type =3D=3D BTRFS_ALLOC_SEQ)=
;=0A=
>> +=0A=
>>   	info =3D kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);=0A=
>>   	if (!info)=0A=
>>   		return -ENOMEM;=0A=
>> @@ -2376,6 +2379,28 @@ int __btrfs_add_free_space(struct btrfs_fs_info *=
fs_info,=0A=
>>   	return ret;=0A=
>>   }=0A=
>>   =0A=
>> +int __btrfs_add_free_space_seq(struct btrfs_block_group_cache *block_gr=
oup,=0A=
>> +			       u64 bytenr, u64 size)=0A=
>> +{=0A=
>> +	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;=0A=
>> +	u64 offset =3D bytenr - block_group->key.objectid;=0A=
>> +	u64 to_free, to_unusable;=0A=
>> +=0A=
>> +	spin_lock(&ctl->tree_lock);=0A=
>> +	if (offset >=3D block_group->alloc_offset)=0A=
>> +		to_free =3D size;=0A=
>> +	else if (offset + size <=3D block_group->alloc_offset)=0A=
>> +		to_free =3D 0;=0A=
>> +	else=0A=
>> +		to_free =3D offset + size - block_group->alloc_offset;=0A=
>> +	to_unusable =3D size - to_free;=0A=
>> +	ctl->free_space +=3D to_free;=0A=
>> +	block_group->unusable +=3D to_unusable;=0A=
>> +	spin_unlock(&ctl->tree_lock);=0A=
>> +	return 0;=0A=
>> +=0A=
>> +}=0A=
>> +=0A=
>>   int btrfs_remove_free_space(struct btrfs_block_group_cache *block_grou=
p,=0A=
>>   			    u64 offset, u64 bytes)=0A=
>>   {=0A=
>> @@ -2384,6 +2409,8 @@ int btrfs_remove_free_space(struct btrfs_block_gro=
up_cache *block_group,=0A=
>>   	int ret;=0A=
>>   	bool re_search =3D false;=0A=
>>   =0A=
>> +	WARN_ON(block_group->alloc_type =3D=3D BTRFS_ALLOC_SEQ);=0A=
>> +=0A=
> =0A=
> These should probably be ASSERT() right?  Want to make sure the developer=
s=0A=
> really notice a problem when testing.  Thanks,=0A=
> =0A=
> Josef=0A=
> =0A=
=0A=
Agree. I will use ASSERT.=0A=
=0A=
