Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BFE49C5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 10:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfFRItE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 04:49:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6662 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfFRItE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560847759; x=1592383759;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ROZmIQkPMaKraw05dYbiiILrn2oI6QEB2ayE+7bvjbA=;
  b=BbNnsqgEaXyBbW4F3kxX5rx4ZUG7jbgIgyepW8U0/EAuX+GaRLHmOvMD
   nOTQppVZmOcDpuab9gYXmXqr2+yURA2oYqNakGYM3ewkYhtrYdK2EPapK
   5EXVBQJeK+wyQXo/CUS38CrjE41HGzY4P1tz457/T3ydWm7csc4xbh9oS
   djJyPvhk2Y6KuSHjIuZnCVJndj8gxxosUnp/sB9ZnbwNT5L4ZgTUu0VkM
   DyaH/vTuwNWw+J6Ulcg3dL2zTMgQKjhQw7mCLCIbJFBKg/Ywm5wJ/kaLa
   5VOfLE9EnRdRbk1Yas8m1mVWzeVq6q82uB/lf3a0tyYnR3KXDWp5zwDJU
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="210569766"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 16:49:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np+HENHKLehNb6ytSSdSDrwC5GsylJoj/1+N4ftl1S4=;
 b=ilkAwpyOTk1GQdn3vxW8EzwkXQe3f5tD05mHK6s+Aq5ZOf4EZS5ndBSy2U6GGTedkIeViWo/dJ0yDrBoKOqKARbV4zBKBJkEYxhXVdg2gAR5ZQaf0DT2SiRceb1Io+Xn++qU4IVPzAQ6D9vEU5AQWiFLLFIm0Pm79DqeaaayDh4=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB4863.namprd04.prod.outlook.com (52.135.114.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 08:49:00 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 08:49:00 +0000
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
Subject: Re: [PATCH 07/19] btrfs: do sequential extent allocation in HMZONED
 mode
Thread-Topic: [PATCH 07/19] btrfs: do sequential extent allocation in HMZONED
 mode
Thread-Index: AQHVHTKH5ZMIOOZPzkO0O0dCfooG+w==
Date:   Tue, 18 Jun 2019 08:49:00 +0000
Message-ID: <SN6PR04MB5231F5D34D067832760BF33A8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-8-naohiro.aota@wdc.com>
 <20190617223007.GI19057@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56ab4939-1bfc-465b-c5cd-08d6f3c9cefd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4863;
x-ms-traffictypediagnostic: SN6PR04MB4863:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4863326FA9589AE3633477618CEA0@SN6PR04MB4863.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(81166006)(76116006)(6916009)(72206003)(2906002)(91956017)(229853002)(6246003)(6436002)(9686003)(53936002)(2501003)(186003)(102836004)(64756008)(7696005)(26005)(81156014)(476003)(71190400001)(66446008)(71200400001)(6116002)(66556008)(53546011)(66476007)(2351001)(6506007)(99286004)(53946003)(3846002)(74316002)(30864003)(5660300002)(7416002)(25786009)(478600001)(14444005)(316002)(14454004)(446003)(5640700003)(52536014)(305945005)(54906003)(256004)(68736007)(7736002)(486006)(1730700003)(8676002)(8936002)(86362001)(66066001)(55016002)(33656002)(66946007)(73956011)(76176011)(4326008)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4863;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fQEPeiNCUYmvP3F3q8LOWGfjtBoqqs8S4+jhDDqTB3SGIxOvlUn7YrS8ybpVeEFKgUdMkKn2dCXN2HKeTDMyxBBYPHnCmmjxOVy7Xe48botXnhClSWiJx3QUdZFOj/gO/Gwco5/ERHnr3n0Cxd50a7eIu8/HSTS6ha+e2SF4IWxBzku+uYqyhBTKxOYqA3aC1Q5zHKl8qYtXUfKqHPjBSqfWIhtRP2XHPlrLiGU4LWLJb9Z0sGu8cJgCe20gHIuhUB3nTanH4j5OCgcT6fOlgfv+7iYgnx00FlqYZOjMqFoux7RVzfBCxCTp7tZEQVIowWJOOTD64cLVDksXr0+eIHz7buQ9of8O0JOQHHpy4b5q9y2oY6f1TLgSAVBrAtH+75ivkuKiyiwmOPiHfz3aJmDw4TO88U46CqzqRa3+L8E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ab4939-1bfc-465b-c5cd-08d6f3c9cefd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 08:49:00.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4863
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/18 7:29, David Sterba wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:13PM +0900, Naohiro Aota wrote:=0A=
>> On HMZONED drives, writes must always be sequential and directed at a bl=
ock=0A=
>> group zone write pointer position. Thus, block allocation in a block gro=
up=0A=
>> must also be done sequentially using an allocation pointer equal to the=
=0A=
>> block group zone write pointer plus the number of blocks allocated but n=
ot=0A=
>> yet written.=0A=
>>=0A=
>> Sequential allocation function find_free_extent_seq() bypass the checks =
in=0A=
>> find_free_extent() and increase the reserved byte counter by itself. It =
is=0A=
>> impossible to revert once allocated region in the sequential allocation,=
=0A=
>> since it might race with other allocations and leave an allocation hole,=
=0A=
>> which breaks the sequential write rule.=0A=
>>=0A=
>> Furthermore, this commit introduce two new variable to struct=0A=
>> btrfs_block_group_cache. "wp_broken" indicate that write pointer is brok=
en=0A=
>> (e.g. not synced on a RAID1 block group) and mark that block group read=
=0A=
>> only. "unusable" keeps track of the size of once allocated then freed=0A=
>> region. Such region is never usable until resetting underlying zones.=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/ctree.h            |  24 +++=0A=
>>   fs/btrfs/extent-tree.c      | 378 ++++++++++++++++++++++++++++++++++--=
=0A=
>>   fs/btrfs/free-space-cache.c |  33 ++++=0A=
>>   fs/btrfs/free-space-cache.h |   5 +=0A=
>>   4 files changed, 426 insertions(+), 14 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
>> index 6c00101407e4..f4bcd2a6ec12 100644=0A=
>> --- a/fs/btrfs/ctree.h=0A=
>> +++ b/fs/btrfs/ctree.h=0A=
>> @@ -582,6 +582,20 @@ struct btrfs_full_stripe_locks_tree {=0A=
>>   	struct mutex lock;=0A=
>>   };=0A=
>>   =0A=
>> +/* Block group allocation types */=0A=
>> +enum btrfs_alloc_type {=0A=
>> +=0A=
>> +	/* Regular first fit allocation */=0A=
>> +	BTRFS_ALLOC_FIT		=3D 0,=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Sequential allocation: this is for HMZONED mode and=0A=
>> +	 * will result in ignoring free space before a block=0A=
>> +	 * group allocation offset.=0A=
> =0A=
> Please format the comments to 80 columns=0A=
> =0A=
>> +	 */=0A=
>> +	BTRFS_ALLOC_SEQ		=3D 1,=0A=
>> +};=0A=
>> +=0A=
>>   struct btrfs_block_group_cache {=0A=
>>   	struct btrfs_key key;=0A=
>>   	struct btrfs_block_group_item item;=0A=
>> @@ -592,6 +606,7 @@ struct btrfs_block_group_cache {=0A=
>>   	u64 reserved;=0A=
>>   	u64 delalloc_bytes;=0A=
>>   	u64 bytes_super;=0A=
>> +	u64 unusable;=0A=
> =0A=
> 'unusable' is specific to the zones, so 'zone_unusable' would make it=0A=
> clear. The terminilogy around space is confusing already (we have=0A=
> unused, free, reserved, allocated, slack).=0A=
=0A=
Sure. I will change the name.=0A=
=0A=
Or, is it better toadd new struct "btrfs_seq_alloc_info" and move all=0A=
these variable there? Then, I can just add one pointer to the struct here.=
=0A=
=0A=
>>   	u64 flags;=0A=
>>   	u64 cache_generation;=0A=
>>   =0A=
>> @@ -621,6 +636,7 @@ struct btrfs_block_group_cache {=0A=
>>   	unsigned int iref:1;=0A=
>>   	unsigned int has_caching_ctl:1;=0A=
>>   	unsigned int removed:1;=0A=
>> +	unsigned int wp_broken:1;=0A=
>>   =0A=
>>   	int disk_cache_state;=0A=
>>   =0A=
>> @@ -694,6 +710,14 @@ struct btrfs_block_group_cache {=0A=
>>   =0A=
>>   	/* Record locked full stripes for RAID5/6 block group */=0A=
>>   	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Allocation offset for the block group to implement sequential=0A=
>> +	 * allocation. This is used only with HMZONED mode enabled and if=0A=
>> +	 * the block group resides on a sequential zone.=0A=
>> +	 */=0A=
>> +	enum btrfs_alloc_type alloc_type;=0A=
>> +	u64 alloc_offset;=0A=
>>   };=0A=
>>   =0A=
>>   /* delayed seq elem */=0A=
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c=0A=
>> index 363db58f56b8..ebd0d6eae038 100644=0A=
>> --- a/fs/btrfs/extent-tree.c=0A=
>> +++ b/fs/btrfs/extent-tree.c=0A=
>> @@ -28,6 +28,7 @@=0A=
>>   #include "sysfs.h"=0A=
>>   #include "qgroup.h"=0A=
>>   #include "ref-verify.h"=0A=
>> +#include "rcu-string.h"=0A=
>>   =0A=
>>   #undef SCRAMBLE_DELAYED_REFS=0A=
>>   =0A=
>> @@ -590,6 +591,8 @@ static int cache_block_group(struct btrfs_block_grou=
p_cache *cache,=0A=
>>   	struct btrfs_caching_control *caching_ctl;=0A=
>>   	int ret =3D 0;=0A=
>>   =0A=
>> +	WARN_ON(cache->alloc_type =3D=3D BTRFS_ALLOC_SEQ);=0A=
>> +=0A=
>>   	caching_ctl =3D kzalloc(sizeof(*caching_ctl), GFP_NOFS);=0A=
>>   	if (!caching_ctl)=0A=
>>   		return -ENOMEM;=0A=
>> @@ -6555,6 +6558,19 @@ void btrfs_wait_block_group_reservations(struct b=
trfs_block_group_cache *bg)=0A=
>>   	wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));=
=0A=
>>   }=0A=
>>   =0A=
>> +static void __btrfs_add_reserved_bytes(struct btrfs_block_group_cache *=
cache,=0A=
>> +				       u64 ram_bytes, u64 num_bytes,=0A=
>> +				       int delalloc)=0A=
>> +{=0A=
>> +	struct btrfs_space_info *space_info =3D cache->space_info;=0A=
>> +=0A=
>> +	cache->reserved +=3D num_bytes;=0A=
>> +	space_info->bytes_reserved +=3D num_bytes;=0A=
>> +	update_bytes_may_use(space_info, -ram_bytes);=0A=
>> +	if (delalloc)=0A=
>> +		cache->delalloc_bytes +=3D num_bytes;=0A=
>> +}=0A=
>> +=0A=
>>   /**=0A=
>>    * btrfs_add_reserved_bytes - update the block_group and space info co=
unters=0A=
>>    * @cache:	The cache we are manipulating=0A=
>> @@ -6573,17 +6589,16 @@ static int btrfs_add_reserved_bytes(struct btrfs=
_block_group_cache *cache,=0A=
>>   	struct btrfs_space_info *space_info =3D cache->space_info;=0A=
>>   	int ret =3D 0;=0A=
>>   =0A=
>> +	/* should handled by find_free_extent_seq */=0A=
>> +	WARN_ON(cache->alloc_type =3D=3D BTRFS_ALLOC_SEQ);=0A=
>> +=0A=
>>   	spin_lock(&space_info->lock);=0A=
>>   	spin_lock(&cache->lock);=0A=
>> -	if (cache->ro) {=0A=
>> +	if (cache->ro)=0A=
>>   		ret =3D -EAGAIN;=0A=
>> -	} else {=0A=
>> -		cache->reserved +=3D num_bytes;=0A=
>> -		space_info->bytes_reserved +=3D num_bytes;=0A=
>> -		update_bytes_may_use(space_info, -ram_bytes);=0A=
>> -		if (delalloc)=0A=
>> -			cache->delalloc_bytes +=3D num_bytes;=0A=
>> -	}=0A=
>> +	else=0A=
>> +		__btrfs_add_reserved_bytes(cache, ram_bytes, num_bytes,=0A=
>> +					   delalloc);=0A=
>>   	spin_unlock(&cache->lock);=0A=
>>   	spin_unlock(&space_info->lock);=0A=
>>   	return ret;=0A=
>> @@ -6701,9 +6716,13 @@ static int unpin_extent_range(struct btrfs_fs_inf=
o *fs_info,=0A=
>>   			cache =3D btrfs_lookup_block_group(fs_info, start);=0A=
>>   			BUG_ON(!cache); /* Logic error */=0A=
>>   =0A=
>> -			cluster =3D fetch_cluster_info(fs_info,=0A=
>> -						     cache->space_info,=0A=
>> -						     &empty_cluster);=0A=
>> +			if (cache->alloc_type =3D=3D BTRFS_ALLOC_FIT)=0A=
>> +				cluster =3D fetch_cluster_info(fs_info,=0A=
>> +							     cache->space_info,=0A=
>> +							     &empty_cluster);=0A=
>> +			else=0A=
>> +				cluster =3D NULL;=0A=
>> +=0A=
>>   			empty_cluster <<=3D 1;=0A=
>>   		}=0A=
>>   =0A=
>> @@ -6743,7 +6762,8 @@ static int unpin_extent_range(struct btrfs_fs_info=
 *fs_info,=0A=
>>   		space_info->max_extent_size =3D 0;=0A=
>>   		percpu_counter_add_batch(&space_info->total_bytes_pinned,=0A=
>>   			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);=0A=
>> -		if (cache->ro) {=0A=
>> +		if (cache->ro || cache->alloc_type =3D=3D BTRFS_ALLOC_SEQ) {=0A=
>> +			/* need reset before reusing in ALLOC_SEQ BG */=0A=
>>   			space_info->bytes_readonly +=3D len;=0A=
>>   			readonly =3D true;=0A=
>>   		}=0A=
>> @@ -7588,6 +7608,60 @@ static int find_free_extent_unclustered(struct bt=
rfs_block_group_cache *bg,=0A=
>>   	return 0;=0A=
>>   }=0A=
>>   =0A=
>> +/*=0A=
>> + * Simple allocator for sequential only block group. It only allows=0A=
>> + * sequential allocation. No need to play with trees. This function=0A=
>> + * also reserve the bytes as in btrfs_add_reserved_bytes.=0A=
>> + */=0A=
>> +=0A=
>> +static int find_free_extent_seq(struct btrfs_block_group_cache *cache,=
=0A=
>> +				struct find_free_extent_ctl *ffe_ctl)=0A=
>> +{=0A=
>> +	struct btrfs_space_info *space_info =3D cache->space_info;=0A=
>> +	struct btrfs_free_space_ctl *ctl =3D cache->free_space_ctl;=0A=
>> +	u64 start =3D cache->key.objectid;=0A=
>> +	u64 num_bytes =3D ffe_ctl->num_bytes;=0A=
>> +	u64 avail;=0A=
>> +	int ret =3D 0;=0A=
>> +=0A=
>> +	/* Sanity check */=0A=
>> +	if (cache->alloc_type !=3D BTRFS_ALLOC_SEQ)=0A=
>> +		return 1;=0A=
>> +=0A=
>> +	spin_lock(&space_info->lock);=0A=
>> +	spin_lock(&cache->lock);=0A=
>> +=0A=
>> +	if (cache->ro) {=0A=
>> +		ret =3D -EAGAIN;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	spin_lock(&ctl->tree_lock);=0A=
>> +	avail =3D cache->key.offset - cache->alloc_offset;=0A=
>> +	if (avail < num_bytes) {=0A=
>> +		ffe_ctl->max_extent_size =3D avail;=0A=
>> +		spin_unlock(&ctl->tree_lock);=0A=
>> +		ret =3D 1;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	ffe_ctl->found_offset =3D start + cache->alloc_offset;=0A=
>> +	cache->alloc_offset +=3D num_bytes;=0A=
>> +	ctl->free_space -=3D num_bytes;=0A=
>> +	spin_unlock(&ctl->tree_lock);=0A=
>> +=0A=
>> +	BUG_ON(!IS_ALIGNED(ffe_ctl->found_offset,=0A=
>> +			   cache->fs_info->stripesize));=0A=
>> +	ffe_ctl->search_start =3D ffe_ctl->found_offset;=0A=
>> +	__btrfs_add_reserved_bytes(cache, ffe_ctl->ram_bytes, num_bytes,=0A=
>> +				   ffe_ctl->delalloc);=0A=
>> +=0A=
>> +out:=0A=
>> +	spin_unlock(&cache->lock);=0A=
>> +	spin_unlock(&space_info->lock);=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>>   /*=0A=
>>    * Return >0 means caller needs to re-search for free extent=0A=
>>    * Return 0 means we have the needed free extent.=0A=
>> @@ -7889,6 +7963,16 @@ static noinline int find_free_extent(struct btrfs=
_fs_info *fs_info,=0A=
>>   		if (unlikely(block_group->cached =3D=3D BTRFS_CACHE_ERROR))=0A=
>>   			goto loop;=0A=
>>   =0A=
>> +		if (block_group->alloc_type =3D=3D BTRFS_ALLOC_SEQ) {=0A=
>> +			ret =3D find_free_extent_seq(block_group, &ffe_ctl);=0A=
>> +			if (ret)=0A=
>> +				goto loop;=0A=
>> +			/* btrfs_find_space_for_alloc_seq should ensure=0A=
>> +			 * that everything is OK and reserve the extent.=0A=
>> +			 */=0A=
> =0A=
> Please use the=0A=
> =0A=
> /*=0A=
>   * comment=0A=
>   */=0A=
> =0A=
> style=0A=
> =0A=
>> +			goto nocheck;=0A=
>> +		}=0A=
>> +=0A=
>>   		/*=0A=
>>   		 * Ok we want to try and use the cluster allocator, so=0A=
>>   		 * lets look there=0A=
>> @@ -7944,6 +8028,7 @@ static noinline int find_free_extent(struct btrfs_=
fs_info *fs_info,=0A=
>>   					     num_bytes);=0A=
>>   			goto loop;=0A=
>>   		}=0A=
>> +nocheck:=0A=
>>   		btrfs_inc_block_group_reservations(block_group);=0A=
>>   =0A=
>>   		/* we are all good, lets return */=0A=
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
> =0A=
> Please move the definition to the beginning of the file=0A=
> =0A=
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
> =0A=
> Please use bool instead of int=0A=
> =0A=
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
> =0A=
> spaces around binary operators=0A=
> =0A=
> 			int base =3D i * map->sub_stripes;=0A=
> =0A=
>> +			u64 offset =3D WP_MISSING_DEV;=0A=
>> +=0A=
>> +			for (j =3D 0; j < map->sub_stripes; j++) {=0A=
>> +				if (alloc_offsets[base+j] =3D=3D WP_MISSING_DEV)=0A=
> =0A=
> here and below=0A=
> =0A=
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
> =0A=
> An unexpeced value of allocation is found, this needs a message and=0A=
> proper error handling, btrfs_read_block_groups is called from mount path=
=0A=
> so the recovery should be possible.=0A=
=0A=
OK. I will handle this case.=0A=
=0A=
> =0A=
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
>>   	spin_lock(&ctl->tree_lock);=0A=
>>   =0A=
>>   again:=0A=
>> @@ -2619,6 +2646,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_=
group_cache *block_group,=0A=
>>   	u64 align_gap =3D 0;=0A=
>>   	u64 align_gap_len =3D 0;=0A=
>>   =0A=
>> +	WARN_ON(block_group->alloc_type =3D=3D BTRFS_ALLOC_SEQ);=0A=
>> +=0A=
>>   	spin_lock(&ctl->tree_lock);=0A=
>>   	entry =3D find_free_space(ctl, &offset, &bytes_search,=0A=
>>   				block_group->full_stripe_len, max_extent_size);=0A=
>> @@ -2738,6 +2767,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_gr=
oup_cache *block_group,=0A=
>>   	struct rb_node *node;=0A=
>>   	u64 ret =3D 0;=0A=
>>   =0A=
>> +	WARN_ON(block_group->alloc_type =3D=3D BTRFS_ALLOC_SEQ);=0A=
>> +=0A=
>>   	spin_lock(&cluster->lock);=0A=
>>   	if (bytes > cluster->max_size)=0A=
>>   		goto out;=0A=
>> @@ -3384,6 +3415,8 @@ int btrfs_trim_block_group(struct btrfs_block_grou=
p_cache *block_group,=0A=
>>   {=0A=
>>   	int ret;=0A=
>>   =0A=
>> +	WARN_ON(block_group->alloc_type =3D=3D BTRFS_ALLOC_SEQ);=0A=
>> +=0A=
>>   	*trimmed =3D 0;=0A=
>>   =0A=
>>   	spin_lock(&block_group->lock);=0A=
>> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h=
=0A=
>> index 8760acb55ffd..d30667784f73 100644=0A=
>> --- a/fs/btrfs/free-space-cache.h=0A=
>> +++ b/fs/btrfs/free-space-cache.h=0A=
>> @@ -73,10 +73,15 @@ void btrfs_init_free_space_ctl(struct btrfs_block_gr=
oup_cache *block_group);=0A=
>>   int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,=0A=
>>   			   struct btrfs_free_space_ctl *ctl,=0A=
>>   			   u64 bytenr, u64 size);=0A=
>> +int __btrfs_add_free_space_seq(struct btrfs_block_group_cache *block_gr=
oup,=0A=
>> +			       u64 bytenr, u64 size);=0A=
>>   static inline int=0A=
>>   btrfs_add_free_space(struct btrfs_block_group_cache *block_group,=0A=
>>   		     u64 bytenr, u64 size)=0A=
>>   {=0A=
>> +	if (block_group->alloc_type =3D=3D BTRFS_ALLOC_SEQ)=0A=
>> +		return __btrfs_add_free_space_seq(block_group, bytenr, size);=0A=
>> +=0A=
>>   	return __btrfs_add_free_space(block_group->fs_info,=0A=
>>   				      block_group->free_space_ctl,=0A=
>>   				      bytenr, size);=0A=
>> -- =0A=
>> 2.21.0=0A=
> =0A=
=0A=
