Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810524E4AE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 03:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbiCWC2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 22:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241291AbiCWC2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:28:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB93670847;
        Tue, 22 Mar 2022 19:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648002405; x=1679538405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Z37sSoHap/WqPsxcYbk8lC5FnXqUlYdkzfb3HVblqk=;
  b=EKjOMmSdHpV+A7vtVaqqoHp2IAnWEzPIO/tlFnXUxAf3z8w2+ujgFIVI
   SG+m1STOAbNYUageXlfCN3v5cZV1XQ6bAEd7XfaFxmc+Nch8oYOVcznH3
   9spHXad/BNf1tAKrwUwZfCSLxmVof0LW9AZHrUbksGr/ttjWVE4O8e4uk
   XHyqLZETsL+GrfFawb364QRoFTnYspKDu3H7EVGiSWrEos0HFgsqjZBSu
   dGGABqJmHUMir+xXHovpvF4dvuqZBrNayHuQjp9rr6MUauTMhWx4XDs6B
   XhSN489Azw0Dk6hc3xUq2AqwDrWkRsE4ROFkCoypasVPUgxKJHDZBVYGY
   A==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="200866421"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 10:26:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9l3DFQCSlZgZgHAsd/JTLJ5QdxhtztPBTsyQOJXQWbgkw1OPeaRFYB0Diro7JLu8szy3+VWRD7G8bZC3jXmAKAIxHud0PkgXtzb3I4amG3ZPm52+JlFWnvIzMw/pnRh+jMOxjCs1eCCurRsElrkEVMtz+cPych0AZ4KqUVJLSahNXmRDJjxPpY+bqqS0IbrOb8cU9Vh20iJu7CAvh89QVDuDGm5WJE1ZD3CMlLtiCFPb9hoaoOk7SKrUivzKQFuMT8mKKgHLvQYPIRwDsO63GxGGex4jU0FhOf1+/gyYo5nJRJYAJ7m6x5xcRFph2wPlsmtRT4QK2QNgVOcixxAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z0kvEPDzVfc2KUy7PW2hBb5PhfIgoL5HbXWcjwNj48=;
 b=lhfUpFl8A0xxEQ/TP+ze4oJnCWnakx/cmjzOYEpvZQGy+TC9+r3xRNBNC9cek9GXHrgmrcYp9kBdGmJeMegD+LC82rQUWIqn/7m1LoOgtFkeMQewJOo9Hj/xX38hvBZP/L1+QnDeGBi0JtYnm9ajLucaIF3hmWogmW4BalskPJ8ft4ldGh86IzW7TbZlsU81Ell0E+DJqdJT5Z7nF2j2ci1GrGXy5TU+4RjWpTd8iU8ZC/+O/OjsvT39xmaJle0i5N7C9r3IuDjycHpG7Iis/NT6J0iWj1lr3imzPzzl81LmyRZ8qqJw4tG0LMre0b9AptqKeIYrFdQFB6t96a35ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z0kvEPDzVfc2KUy7PW2hBb5PhfIgoL5HbXWcjwNj48=;
 b=lM0mEQA48muPlSpGf3CgLrgSiK1cSCIEyDK/kIvCLuHaeAoH0oqEEG3kUmyFuFuUZ8yQ0SW/4jE8hhcS8dEvk1KEhwmEFDPKgxrC/YsA/M8ORf8NjoXCPY/pbZYiXzDDCD54RJMe759s+9S3HqiejjgMKMGOSTaP9hBq/wUBsWc=
Received: from PH0PR04MB7770.namprd04.prod.outlook.com (2603:10b6:510:e3::8)
 by DM6PR04MB4299.namprd04.prod.outlook.com (2603:10b6:5:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 02:26:44 +0000
Received: from PH0PR04MB7770.namprd04.prod.outlook.com
 ([fe80::fd19:da0d:81c5:d038]) by PH0PR04MB7770.namprd04.prod.outlook.com
 ([fe80::fd19:da0d:81c5:d038%9]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 02:26:44 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v2 2/4] btrfs: mark device addition as mnt_want_write_file
Thread-Topic: [PATCH v2 2/4] btrfs: mark device addition as
 mnt_want_write_file
Thread-Index: AQHYOTj/hKwZmfYHbUmaDCBwHOvDCqzCLSEAgAED2QCAADYmAIAHcawAgACRboCAAN4ygA==
Date:   Wed, 23 Mar 2022 02:26:44 +0000
Message-ID: <20220323022643.uc4pruqqaruzylm5@naota-xeon>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
 <4b8a439c276e774ab2402cbd5395061ea0bd3cde.1647436353.git.naohiro.aota@wdc.com>
 <YjILAo2ueZsnhza/@debian9.Home> <20220317073628.slh4iyexpen7lmjh@naota-xeon>
 <YjMSaLIhKNcKUuHM@debian9.Home> <20220322043056.3sgb75menaja4xex@naota-xeon>
 <YjnK/yHH4TdEzKmi@debian9.Home>
In-Reply-To: <YjnK/yHH4TdEzKmi@debian9.Home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab1f1adc-b464-4b69-1839-08da0c7492a6
x-ms-traffictypediagnostic: DM6PR04MB4299:EE_
x-microsoft-antispam-prvs: <DM6PR04MB42992E44A4170213F95CE8538C189@DM6PR04MB4299.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XDpyqkQTnyfZtN6IGXIczexzBsbsaiWFJeikvd913ZL+I3FwrYXyKs7cbxvMXCdWpwsCRGco/C7YR0/z1bgZgn2R7RNPom/yE2in2YLnGRzcKhJBq2Iz3by01Tm9X2wdQ3MCQ4jNiR/6maWPrqr/p+q4Mk/cHmyZdxH2mmHncCDxucdDnsfOMlUSrgTaWG4qGbqCTvcZOHOc9sgdNTgRFAVANmQCyKF5tEuPh35uzjsojbKlmxl4HAu3jSriy5Cs6MpZ3pw9SaCbxLupbFnzPi5WzvVgxxuliop84SMGBhtYKKcmK3KQedS12QsP+I7+bFItCkSrc5DIazG7SBTAsTioOGP7X6yDASRHy1gv6HZCIPrNIKwwQeqU9PNJbL9Aza2VTPihBHqpPMGOfi3M3yNdkY5MyZEPa2/U2z21HPYbkRiz4FXRVynJCXL92Dgx0UqNUELwr1ZwtiyvM/NpVgDvHlIWEjRV053xY9LJIOifyvTFeMQRjcQsAL+rTZAVI0UZdBgBcy53Jxoxq4u3w2NJRCi4SFILzHRyS0nRDdX+pokKWzsf8blyaeddybqwoE/eTlYBwaH3kRgD9ylKVTX8woqrQDYHcsDoftneb50T4T6Qu44Qbsw9trWTCXRBIAZHsCoGPo6pAsDP51Ko/U20C9IvwboYcSa/aZETwcVtOY/JVeNb5Z++CFr3u+s4XpD63LaaYKAHAwIJF/HJuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7770.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(122000001)(6512007)(38100700002)(33716001)(1076003)(83380400001)(6506007)(26005)(82960400001)(2906002)(9686003)(316002)(86362001)(54906003)(6916009)(8936002)(38070700005)(508600001)(5660300002)(4326008)(8676002)(186003)(6486002)(91956017)(66476007)(76116006)(66446008)(66946007)(66556008)(64756008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rC1S93oLo3b83kwtFmKXbqNAKwZWXaN21pIyvLtFMxHqg1t5MaQs0J9OnlDD?=
 =?us-ascii?Q?fDBAXLI5W4E/fEBYgsxpafHvuMZqyBUnKc+PILsRhpkg7pwb3Rk1wjWcaH1w?=
 =?us-ascii?Q?y4pa9zrfN9vyHfQtT8B7BeUzmI5wejeTlp4IVr+sV4dcvNnzcOCK6kOQ0mMf?=
 =?us-ascii?Q?BIvGPJE2s9LIFNeE7rs/0EGTE0QjvA2ZNK+CZ1psq+2/bLg+i+cukxwc//G8?=
 =?us-ascii?Q?zIOn4OQUctozq9GcZ3E/UkruVdj9Z7FC57GoI37QtZpL2DwzTphL9nnrKOvZ?=
 =?us-ascii?Q?PVZbVZyf4B+lM/iUnOqV50psMrY/9E2C5BlNLdMbYcMtZE0exSeT4Xkbjcwo?=
 =?us-ascii?Q?z/9SdgEwBKMSa31d2CtixVRqWXdRq6fYEhAFnkJgJfUGdtpcudvdZZSrcTaA?=
 =?us-ascii?Q?PjNKbXv4e/wL0wMMrEPsnohKR9biQps3MMey2m7Rn0rdSI5jNenClDrkcwI2?=
 =?us-ascii?Q?tr7nOEVgiN8++qVQ336PQw/+Y5euLWqW4bQ1+9Ouc1FvTcip1+2TFbNd1qqn?=
 =?us-ascii?Q?V3KLOnsc6ncZ447/Ck04/AksKqTMHBBfU4VPjOhhIjuMgtQwZf8x6jPObNEq?=
 =?us-ascii?Q?5stT/BC3odcHydRhmSZgfaPwI4l/6Kv1v7xwHqnDiAHQNtWDLqFeqoo+cp9V?=
 =?us-ascii?Q?ue6UNB/AFGHvS9KR3IAVhcs8Gk7kAxL6IyVEUUQQSXkSDAZT9Ye4AKHkv5tQ?=
 =?us-ascii?Q?lL6fhsdrkFsafCiNOVaCIunM/Y2DsZK5YIP5PLfufB0p6CcXBcSKsHzCWlcZ?=
 =?us-ascii?Q?qycG1kQXYQM+Cx5eDkbr5WO99p0ayRF51YKHtO8qPSz/KihME9U26HHIt1I9?=
 =?us-ascii?Q?UjCpj2C8MX7uHNnbs/FAuGrKR4HSD8i2tpOuRmS0GIsd7BhqhCEVDX4NjWlP?=
 =?us-ascii?Q?qRG0UdjYKn4cL2fGRtytEPqomZwX/vyM4XVFApxVX3O04ghd2m82gVL5f+YW?=
 =?us-ascii?Q?+JDbwugl0tqThjKGKqBazkMqry/3JBzLbeZ9ClOdmuEvEPbtK4yQetcUUHm1?=
 =?us-ascii?Q?zgKRcJ+RHRf+HYNk5Ks7bgxKw/RGbXOwof0yiOniOSilgwOc1qf+IbUJlLVB?=
 =?us-ascii?Q?tgl7XAWWzboctrqgXOpZ3Ic/Inw+IqMnb/36kAvPyJqTZNuvq65qNW5Cwn1n?=
 =?us-ascii?Q?iBWO365XV4h6AqYq5D7A/2OeRGdHS7bXfeG4tnAHbOrg8pBTQ3muBlCPTo8w?=
 =?us-ascii?Q?qhj/85/8MJoAjn8dwIXIJgDtfX9mCXZwusaDs9ckvO6nd8KpoSod/KJK+Ruz?=
 =?us-ascii?Q?guGHKRxqQpi494+CCjqlh6JaPhVx0fAr1zt8KPbziEDHIF58UXpzVlymxab/?=
 =?us-ascii?Q?KQE6m1YlzszZzI+axbLtI0mAaZaL+KJkhlP7r/zx8RFuK0lWipxKJn85tW9y?=
 =?us-ascii?Q?cvbe74bXP3ylkFiFr58teNQDXdBEFGWSBzwzbLnblNDBxzZdCTo/ke7C3LTD?=
 =?us-ascii?Q?yj7LU+Qvia4thikjV1ZIuFeEdoEqmA0v2+wvouPsmQgkchw8o03xBw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <865F8AFB8E7EA14381168CC83A7CD86A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7770.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1f1adc-b464-4b69-1839-08da0c7492a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 02:26:44.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aB1o25jkJ9ucGDgB2Q7gidv/CKLKxSfNyzeVLQfV6NTXyPrrnfsPVaIGQROcnsb5Pr10fxUW8HGLDGs6sIxTVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4299
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 01:11:27PM +0000, Filipe Manana wrote:
> On Tue, Mar 22, 2022 at 04:30:56AM +0000, Naohiro Aota wrote:
> > On Thu, Mar 17, 2022 at 10:50:16AM +0000, Filipe Manana wrote:
> > > On Thu, Mar 17, 2022 at 07:36:29AM +0000, Naohiro Aota wrote:
> > > > On Wed, Mar 16, 2022 at 04:06:26PM +0000, Filipe Manana wrote:
> > > > > On Wed, Mar 16, 2022 at 10:22:38PM +0900, Naohiro Aota wrote:
> > > > > > btrfs_init_new_device() calls btrfs_relocate_sys_chunk() which =
incurs
> > > > > > file-system internal writing. That writing can cause a deadlock=
 with
> > > > > > FS freezing like as described in like as described in commit
> > > > > > 26559780b953 ("btrfs: zoned: mark relocation as writing").
> > > > > >=20
> > > > > > Mark the device addition as mnt_want_write_file. This is also c=
onsistent
> > > > > > with the removing device ioctl counterpart.
> > > > > >=20
> > > > > > Cc: stable@vger.kernel.org # 4.9+
> > > > > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > > > > ---
> > > > > >  fs/btrfs/ioctl.c | 11 +++++++++--
> > > > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > > > index 60c907b14547..a6982a1fde65 100644
> > > > > > --- a/fs/btrfs/ioctl.c
> > > > > > +++ b/fs/btrfs/ioctl.c
> > > > > > @@ -3474,8 +3474,10 @@ static int btrfs_ioctl_defrag(struct fil=
e *file, void __user *argp)
> > > > > >  	return ret;
> > > > > >  }
> > > > > > =20
> > > > > > -static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info,=
 void __user *arg)
> > > > > > +static long btrfs_ioctl_add_dev(struct file *file, void __user=
 *arg)
> > > > > >  {
> > > > > > +	struct inode *inode =3D file_inode(file);
> > > > > > +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> > > > > >  	struct btrfs_ioctl_vol_args *vol_args;
> > > > > >  	bool restore_op =3D false;
> > > > > >  	int ret;
> > > > > > @@ -3488,6 +3490,10 @@ static long btrfs_ioctl_add_dev(struct b=
trfs_fs_info *fs_info, void __user *arg)
> > > > > >  		return -EINVAL;
> > > > > >  	}
> > > > > > =20
> > > > > > +	ret =3D mnt_want_write_file(file);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > >=20
> > > > > So, this now breaks all test cases that exercise device seeding, =
and I clearly
> > > > > forgot about seeding when I asked about why not use mnt_want_writ=
e_file()
> > > > > instead of a bare call to sb_start_write():
> > > >=20
> > > > Ah, yes, I also confirmed they fail.
> > > >=20
> > > > >=20
> > > > > $ ./check btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > > > ><snip>
> > > > > Ran: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > > > > Failures: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > > > > Failed 5 of 5 tests
> > > > >=20
> > > > > So device seeding introduces a special case. If we mount a seedin=
g
> > > > > filesystem, it's RO, so the mnt_want_write_file() fails.
> > > >=20
> > > > Yeah, so we are in a mixed state here. It's RO with a seeding
> > > > device. Or, it must be RW otherwise (checked in
> > > > btrfs_init_new_device()).
> > > >=20
> > > > > Something like this deals with it and it makes the tests pass:
> > > > >=20
> > > > ><snip>
> > > > >=20
> > > > > We are also changing the semantics as we no longer allow for addi=
ng a device
> > > > > to a RO filesystem. So the lack of a mnt_want_write_file() was in=
tentional
> > > > > to deal with the seeding filesystem case. But calling mnt_want_wr=
ite_file()
> > > > > if we are not seeding, changes the semantics - I'm not sure if an=
yone relies
> > > > > on the ability to add a device to a fs mounted RO, I'm not seeing=
 if it's an
> > > > > useful use case.
> > > >=20
> > > > Adding a device to RO FS anyway returns -EROFS from
> > > > btrfs_init_new_device(). So, there is no change.
> > > >=20
> > > > > So either we do that special casing like in that diff, or we alwa=
ys do the
> > > > > sb_start_write() / sb_end_write() - in any case please add a comm=
ent explaining
> > > > > why we do it like that, why we can't use mnt_want_write_file().
> > > >=20
> > > > The conditional using of sb_start_write() or mnt_want_write_file()
> > > > seems a bit dirty. And, I just thought, marking the FS "writing" wh=
en
> > > > it's read-only also seems odd.
> > > >=20
> > > > I'm now thinking we should have sb_start_write() around here where =
the
> > > > FS is surely RW.
> > > >=20
> > > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > > index 393fc7db99d3..50e02dc4e2b2 100644
> > > > --- a/fs/btrfs/volumes.c
> > > > +++ b/fs/btrfs/volumes.c
> > > > @@ -2731,6 +2731,8 @@ int btrfs_init_new_device(struct btrfs_fs_inf=
o *fs_info, const char *device_path
> > > > =20
> > > >  	mutex_unlock(&fs_devices->device_list_mutex);
> > > > =20
> > > > +	sb_start_write(fs_info->sb);
> > > > +
> > > >  	if (seeding_dev) {
> > > >  		mutex_lock(&fs_info->chunk_mutex);
> > > >  		ret =3D init_first_rw_device(trans);
> > > > @@ -2786,6 +2788,8 @@ int btrfs_init_new_device(struct btrfs_fs_inf=
o *fs_info, const char *device_path
> > > >  		ret =3D btrfs_commit_transaction(trans);
> > > >  	}
> > > > =20
> > > > +	sb_end_write(fs_info->sb);
> > > > +
> > > >  	/*
> > > >  	 * Now that we have written a new super block to this device, che=
ck all
> > > >  	 * other fs_devices list if device_path alienates any other scann=
ed
> > > > @@ -2801,6 +2805,8 @@ int btrfs_init_new_device(struct btrfs_fs_inf=
o *fs_info, const char *device_path
> > > >  	return ret;
> > > > =20
> > > >  error_sysfs:
> > > > +	sb_end_write(fs_info->sb);
> > > > +
> > > >  	btrfs_sysfs_remove_device(device);
> > > >  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> > > >  	mutex_lock(&fs_info->chunk_mutex);
> > >=20
> > > Why not just reduce the scope to surround the btrfs_relocate_sys_chun=
ks() call?
> > > It's simpler, and I don't see why all the other code needs to be surr=
ound by
> > > sb_start_write() and sb_end_write().
> >=20
> > Yep, it turned out my patch caused a lockdep issue. Because we call
> > sb_start_intwrite in the transaction path, we can't call
> > sb_start_write() while the transaction is committed. So, at least we
> > need to narrow the region around btrfs_relocate_sys_chunks().
>=20
> I don't understand. What do you mean with "while the transaction is commi=
tted"?
>=20
> Do you mean having the following flow leads to a lockdep warning?
>=20
>    sb_start_write()
>    btrfs_[start|join]_transaction()
>    btrfs_commit_transaction()
>    sb_end_write()

I mean while the commit is running, so, the following flow:

btrfs_start_transaction()
  sb_start_intwrite()
sb_start_write()
btrfs_commit_transaction(trans);
  sb_end_intwrite()
sb_end_write()

Since sb_start_intwrite() is called in btrfs_start_transaction(), I
got a lockdep warning it's taking sb_start_write()'s lock while it's
holding sb_start_intwrite()'s lock.

> If that's what you mean, than it's really odd, because we do that in many=
 ioctls,
> like the resize ioctl and snapshot creation for example:
>=20
>   btrfs_ioctl_resize()
>     mnt_want_write_file()
>       -> calls sb_start_write()
>     btrfs_start_transaction()
>     btrfs_commit_transaction()
>     mnt_end_write_file()
>     mnt_drop_write_file()
>       -> calls sb_end_write()
>=20
> And it's been like that for many years, with no known lockdep complaints.
>=20
> Also I don't see why surrounding only btrfs_relocate_sys_chunks() would m=
ake
> lockdep happy. Because inside the relocation code we have several places =
that
> start a transaction and then commit the transaction.
>=20
> Can you be more explicit, perhaps show the warning/trace from lockdep?
>=20
> >=20
> > > Actually, relocating system chunks does not create ordered extents - =
that only
> > > happens for data block groups. So we could could get away with all th=
is, and
> > > have the relocation code do the assertion only if we are relocating a=
 data
> > > block group - so no need to touch anything in the device add path.
> >=20
> > Hmm, that's true. And, such metadata update is protected with
> > sb_start_intwrite()/sb_end_intwrite() in the transaction functions.
> >=20
> > Maybe, we can just add sb_start_write_trylock() to
> > relocate_file_extent_cluster() ?
>=20
> Why not make it simple as I suggested? Drop this patch, and change the ne=
xt
> patch in the series to do the assertion like this:
>=20
>   At btrfs_relocate_block_group() add:
>=20
>=20
>     /*
>      * Add some comment why we check this...
>      */
>     if (bg->flags & BTRFS_BLOCK_GROUP_DATA)
>         ASSERT(sb_write_started(fs_info->sb));
>=20
> Wouldn't that work? Why not?

Yes, that works. I now think it's the better way to go.

> >=20
> > > Thanks.
> > >=20
> > > >=20
> > > > > Thanks.
> > > > >=20
> > > > >=20
> > > > > > +
> > > > > >  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
> > > > > >  		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_A=
DD))
> > > > > >  			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> > > > > > @@ -3520,6 +3526,7 @@ static long btrfs_ioctl_add_dev(struct bt=
rfs_fs_info *fs_info, void __user *arg)
> > > > > >  		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
> > > > > >  	else
> > > > > >  		btrfs_exclop_finish(fs_info);
> > > > > > +	mnt_drop_write_file(file);
> > > > > >  	return ret;
> > > > > >  }
> > > > > > =20
> > > > > > @@ -5443,7 +5450,7 @@ long btrfs_ioctl(struct file *file, unsig=
ned int
> > > > > >  	case BTRFS_IOC_RESIZE:
> > > > > >  		return btrfs_ioctl_resize(file, argp);
> > > > > >  	case BTRFS_IOC_ADD_DEV:
> > > > > > -		return btrfs_ioctl_add_dev(fs_info, argp);
> > > > > > +		return btrfs_ioctl_add_dev(file, argp);
> > > > > >  	case BTRFS_IOC_RM_DEV:
> > > > > >  		return btrfs_ioctl_rm_dev(file, argp);
> > > > > >  	case BTRFS_IOC_RM_DEV_V2:
> > > > > > --=20
> > > > > > 2.35.1
> > > > > > =
