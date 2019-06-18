Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E716449913
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 08:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfFRGnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 02:43:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24107 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfFRGnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560840235; x=1592376235;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QGz5wR04NGj/l2TbPlBzzhEoyiM5o3UH+tCv0KLJ+Ik=;
  b=NwplxFSo6As9/1CuIDGERFix/edgUv7K2NacqEEE8xuiymaSI9AOIgjt
   Gl1YKru2gv6uYANYR4qMNhmhPqhpumjyoD1k+zWkuXmNiJRMM2IyzOnGY
   4RohWUw3PuDged5kgvKXTdxryzGkkjtdPEC4sHBEzZKk7ahpDhhBMEpi4
   GGTUnKu8BhSkW8tMvoZkhPKXj6AaJE33pfj08biecEI0HhHxXsE6jsi/C
   e7csVcV76570/hJypOxTZoFaQFie1DMq+rj+/v9EfCWfpgHGWif5+Xeg7
   LnkVgk74RmF89MyKm2dyRAB2rDmb8C0td7gsiLCVsRwvjsZbnXe2f/o8N
   A==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="217185253"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 14:43:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT3aHOTrqZ2aPsjxAMdblbByTynah5k12DYSxkqi7SA=;
 b=LKJh3Y/KMAaYLeM0adJl3DNE2pwswAEnBdx7EoaNRDJCsfYes7auFDt3uvzwJr0agIrBbhDf53X02yXTJsQM4b4SGLJuoKL5kG8x+blvhZHp/nWctfqUHEXLjWyCEkRxL7ejdHulapig5+mCGLKYWVnaQ0Iq6SS3yBDkLl+yC/c=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB4256.namprd04.prod.outlook.com (52.135.72.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Tue, 18 Jun 2019 06:43:52 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 06:43:52 +0000
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
Subject: Re: [PATCH 03/19] btrfs: Check and enable HMZONED mode
Thread-Topic: [PATCH 03/19] btrfs: Check and enable HMZONED mode
Thread-Index: AQHVHTKBzmgdNkH+W06mgCGzH1JPPA==
Date:   Tue, 18 Jun 2019 06:43:52 +0000
Message-ID: <SN6PR04MB52312145B9AAC21B0A70CA8A8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-4-naohiro.aota@wdc.com>
 <20190613135710.nu5r5bpcwdm4we2w@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 824cf0dc-cb81-4c9a-6045-08d6f3b853af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4256;
x-ms-traffictypediagnostic: SN6PR04MB4256:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4256AA806CAC03DF0EBD40798CEA0@SN6PR04MB4256.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(64756008)(2906002)(6246003)(66066001)(66556008)(66446008)(6506007)(66476007)(73956011)(476003)(68736007)(76176011)(53936002)(486006)(66946007)(53546011)(86362001)(76116006)(478600001)(99286004)(91956017)(81166006)(7696005)(9686003)(71190400001)(4326008)(71200400001)(72206003)(25786009)(5660300002)(446003)(52536014)(74316002)(186003)(256004)(55016002)(6916009)(81156014)(8936002)(8676002)(33656002)(316002)(26005)(229853002)(6116002)(102836004)(6436002)(3846002)(305945005)(7736002)(54906003)(14454004)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4256;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yC3YthiUoe8j2f4WNgDOg49uXXpB/wguYo/6bDBRoUE99wYoIi5c15R43bhxEJGBTpHQdnNhCQWRJLVzf69QbMWVOtVWE/UGNXT3wJyMIQvF8IJBd9wrpHnlLNXAUqvRweYbkcvnNp02YuFHzsn8BYTPrs76pcH7+n3uIQa6waZNDhvxkaDoWg+j3srvrkQtn4Tpvf6sHx3T4gfH6kfqnwQF9viLoPCpRx4K35V4Rx93q25a4ao5UXrjXaCfaw+jRmrzuCnsV+aP7e0iZZbXr6+O2PFFRjmyGcT8Pn6PG7OkYY8Dn1rzHP/q9DxDulKr6saIFgn9nMUV1ru1VQjBUgaSN9bKVBcLWfcs42gw7a6ErYDOwuqLetH4Xnb6Ek24iZot9vlywK5qNqe0LILDejx95IHXBR2Sg6W+vE5R8TY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824cf0dc-cb81-4c9a-6045-08d6f3b853af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 06:43:52.1828
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

On 2019/06/13 22:57, Josef Bacik wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:09PM +0900, Naohiro Aota wrote:=0A=
>> HMZONED mode cannot be used together with the RAID5/6 profile for now.=
=0A=
>> Introduce the function btrfs_check_hmzoned_mode() to check this. This=0A=
>> function will also check if HMZONED flag is enabled on the file system a=
nd=0A=
>> if the file system consists of zoned devices with equal zone size.=0A=
>>=0A=
>> Additionally, as updates to the space cache are in-place, the space cach=
e=0A=
>> cannot be located over sequential zones and there is no guarantees that =
the=0A=
>> device will have enough conventional zones to store this cache. Resolve=
=0A=
>> this problem by disabling completely the space cache.  This does not=0A=
>> introduces any problems with sequential block groups: all the free space=
 is=0A=
>> located after the allocation pointer and no free space before the pointe=
r.=0A=
>> There is no need to have such cache.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/ctree.h       |  3 ++=0A=
>>   fs/btrfs/dev-replace.c |  7 +++=0A=
>>   fs/btrfs/disk-io.c     |  7 +++=0A=
>>   fs/btrfs/super.c       | 12 ++---=0A=
>>   fs/btrfs/volumes.c     | 99 ++++++++++++++++++++++++++++++++++++++++++=
=0A=
>>   fs/btrfs/volumes.h     |  1 +=0A=
>>   6 files changed, 124 insertions(+), 5 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
>> index b81c331b28fa..6c00101407e4 100644=0A=
>> --- a/fs/btrfs/ctree.h=0A=
>> +++ b/fs/btrfs/ctree.h=0A=
>> @@ -806,6 +806,9 @@ struct btrfs_fs_info {=0A=
>>   	struct btrfs_root *uuid_root;=0A=
>>   	struct btrfs_root *free_space_root;=0A=
>>   =0A=
>> +	/* Zone size when in HMZONED mode */=0A=
>> +	u64 zone_size;=0A=
>> +=0A=
>>   	/* the log root tree is a directory of all the other log roots */=0A=
>>   	struct btrfs_root *log_root_tree;=0A=
>>   =0A=
>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c=0A=
>> index ee0989c7e3a9..fbe5ea2a04ed 100644=0A=
>> --- a/fs/btrfs/dev-replace.c=0A=
>> +++ b/fs/btrfs/dev-replace.c=0A=
>> @@ -201,6 +201,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btr=
fs_fs_info *fs_info,=0A=
>>   		return PTR_ERR(bdev);=0A=
>>   	}=0A=
>>   =0A=
>> +	if ((bdev_zoned_model(bdev) =3D=3D BLK_ZONED_HM &&=0A=
>> +	     !btrfs_fs_incompat(fs_info, HMZONED)) ||=0A=
>> +	    (!bdev_is_zoned(bdev) && btrfs_fs_incompat(fs_info, HMZONED))) {=
=0A=
> =0A=
> You do this in a few places, turn this into a helper please.=0A=
> =0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto error;=0A=
>> +	}=0A=
>> +=0A=
>>   	filemap_write_and_wait(bdev->bd_inode->i_mapping);=0A=
>>   =0A=
>>   	devices =3D &fs_info->fs_devices->devices;=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index 663efce22d98..7c1404c76768 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -3086,6 +3086,13 @@ int open_ctree(struct super_block *sb,=0A=
>>   =0A=
>>   	btrfs_free_extra_devids(fs_devices, 1);=0A=
>>   =0A=
>> +	ret =3D btrfs_check_hmzoned_mode(fs_info);=0A=
>> +	if (ret) {=0A=
>> +		btrfs_err(fs_info, "failed to init hmzoned mode: %d",=0A=
>> +				ret);=0A=
>> +		goto fail_block_groups;=0A=
>> +	}=0A=
>> +=0A=
>>   	ret =3D btrfs_sysfs_add_fsid(fs_devices, NULL);=0A=
>>   	if (ret) {=0A=
>>   		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",=0A=
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c=0A=
>> index 2c66d9ea6a3b..740a701f16c5 100644=0A=
>> --- a/fs/btrfs/super.c=0A=
>> +++ b/fs/btrfs/super.c=0A=
>> @@ -435,11 +435,13 @@ int btrfs_parse_options(struct btrfs_fs_info *info=
, char *options,=0A=
>>   	bool saved_compress_force;=0A=
>>   	int no_compress =3D 0;=0A=
>>   =0A=
>> -	cache_gen =3D btrfs_super_cache_generation(info->super_copy);=0A=
>> -	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))=0A=
>> -		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);=0A=
>> -	else if (cache_gen)=0A=
>> -		btrfs_set_opt(info->mount_opt, SPACE_CACHE);=0A=
>> +	if (!btrfs_fs_incompat(info, HMZONED)) {=0A=
>> +		cache_gen =3D btrfs_super_cache_generation(info->super_copy);=0A=
>> +		if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))=0A=
>> +			btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);=0A=
>> +		else if (cache_gen)=0A=
>> +			btrfs_set_opt(info->mount_opt, SPACE_CACHE);=0A=
>> +	}=0A=
>>   =0A=
> =0A=
> This disables the free space tree as well as the cache, sounds like you o=
nly=0A=
> need to disable the free space cache?  Thanks,=0A=
=0A=
Right. We can still use the free space tree on HMZONED. I'll fix in the nex=
t version.=0A=
Thanks=0A=
=0A=
