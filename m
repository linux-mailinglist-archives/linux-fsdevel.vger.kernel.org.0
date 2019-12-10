Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFD9118C00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLJPH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 10:07:58 -0500
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:30081
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727272AbfLJPH6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:07:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWYVdcoV0mpwSrMSbkGrUwpjn45+gW82oU5qz8ZF6O2boNa9qv5p61JuraMPXQMaJg66BPjHfV+AHta+yjl+T4VTLkUimPr6Bveina8dR9ga1a6QgsX0OcL1hXERVP7NDiHrMW1Eh4SKlerO/m36cMW8IVSA1VbFlurMNYVXguRfRijqdZdN2QWYnuvjI+LTkAXEAy3AkQ7YkcxjTGWQmKRSw1UFvTIKSiqsTJjuTzOWyDrX5W4tLUd5qmpmtlOfcfW0NrQI7Q6Tgzs2k1kb4PzeLr8loBPfx952Olyfm2OI51egeyJ5qDVPg35ZcLK97qNhACUbEQPVqAjjtFXNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9zF5UnigfJFS7VnIIla1MjD2hvRPi1jKSAN5R+rgfM=;
 b=ceVSTtE7hNCeGCYJhkzVtu3SL6YoDJ36RBP7oibgm7coSPm9bENwoDegtc25yR2q/G5Ov3OJ6TUJ+6q9EUZMjCNYzhViUS3WJRgjue5F9fzwXmkvYkAowTCv55IuHyBir3uai1SDBI02u66fTpqe9EF+88GS7Zmv+R7IXh7hJ7JxZgT9ChShaGfalWDOBlCI13AMsbcBRHwcH9AB0T9jcp9WH06d2KSdykAQLEzSLyIH2f1ufPyVrt78pAFecS2FOGQEl4m72LPny3UjN2FrsVdmGELie7V+NqTITyEA2Kf57pFpS7PjtFyuMZ7eOOOcFcTV+veNrZYdV81WZbxeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9zF5UnigfJFS7VnIIla1MjD2hvRPi1jKSAN5R+rgfM=;
 b=fl/xLsH0zNg8i/4vfqtwAAtRHPNtMgsHEvm3ks6fPrCmHCk3LMnar2NGzqkfM9Wn8a/7xPHSGXjciEDH4L8MH+1JPYULTK8DGod83JB7lDY8vp/jvvv/IY7U5hQbzyF6ka4m0EaNhzh1p2H2wWL3dzKOsbA+Jzce3ohq6pwNeEQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3311.eurprd04.prod.outlook.com (10.170.231.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 15:07:53 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 15:07:53 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: debugfs removal fails after commit 653f0d05be09
 ("simple_recursive_removal(): kernel-side rm -rf for ramfs-style
 filesystems")
Thread-Topic: debugfs removal fails after commit 653f0d05be09
 ("simple_recursive_removal(): kernel-side rm -rf for ramfs-style
 filesystems")
Thread-Index: AQHVr2uYTLylvgmYT06ytvH4hDQoww==
Date:   Tue, 10 Dec 2019 15:07:53 +0000
Message-ID: <VI1PR04MB7023BFC12D955816384A922CEE5B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ae52d69-0b37-4ca0-c83e-08d77d82bb58
x-ms-traffictypediagnostic: VI1PR04MB3311:|VI1PR04MB3311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB331120A35EE189B13B4CD4D4EE5B0@VI1PR04MB3311.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(478600001)(71200400001)(86362001)(186003)(966005)(6506007)(33656002)(26005)(44832011)(7696005)(5660300002)(52536014)(8676002)(76116006)(8936002)(81166006)(81156014)(64756008)(66446008)(66946007)(316002)(55016002)(91956017)(9686003)(2906002)(4326008)(54906003)(66476007)(66556008)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3311;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4vWKszHbPHsObSsXk16KF+3omI2tDk5hiFsLktrGPtbryVaChbeqOZKdIvsT4kO77n5MbMGirTfJXl+yJ3JfQ+VCLgxdrsoEgnyZR/pfzds4cuJY5hY3lt7rgIVut7+9QM28QyDA3wdfeD0TdNLIwDe7PNh3tYYDO7btowzKJkjQSOAn+WE+fg/0LyL4DbRVm/4uxTIoPIYdAQ7DIl/pOaKKfLkmHsR7/3jffJAgtQh91OkioII5/GGc0OiA1nHflI/F5ZATEG7HEpdxW9cmDUqZgOKMuusqMFoeJmaFWvQoJ4/0KejeQe1Yd67JCKUbIz8MwWmhHytnPVwqYEWEnVyIGwSEphy9ppIF48IPgAOBiiXDcHtLo4g4FwH0zisjCTCMSSIbmrxoq9rZXQq/ANXlR4qWXZC5Q6yWQPu50VRbfLN9piWtFhD9dF1rmGOG103UA+eOZZUMZwpy7Qa6rnPtOmD9LNEEGTSv2KUpC8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae52d69-0b37-4ca0-c83e-08d77d82bb58
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 15:07:53.7607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jaeTga6ECbbv/KeKQ2Nu1PqNTgkfDy+6Bj4VG5O2pev4rxLGTkJbIMCvVjgUrDt9F9Qg9FU1uy5a4PCRUi75w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3311
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,=0A=
=0A=
Commit 653f0d05be09 ("simple_recursive_removal(): kernel-side rm -rf for =
=0A=
ramfs-style filesystems") triggers the following WARN in =0A=
linux-next-20191210 for me (and later a panic):=0A=
=0A=
WARNING: CPU: 0 PID: 1 at fs/dcache.c:338 dentry_free+0xa4/0xb0 =0A=
=0A=
Call trace:=0A=
  dentry_free+0xa4/0xb0=0A=
  __dentry_kill+0x180/0x1c0=0A=
  dput+0x298/0x418=0A=
  simple_recursive_removal+0x22c/0x258=0A=
  debugfs_remove+0x5c/0x80=0A=
  opp_debug_remove_one+0x18/0x20=0A=
  _opp_kref_release+0x40/0x78=0A=
  dev_pm_opp_put+0x40/0x58=0A=
  _opp_remove_all_static+0x50/0x78=0A=
  _put_opp_list_kref+0x3c/0x50=0A=
  _dev_pm_opp_find_and_remove_table+0x2c/0x90=0A=
  dev_pm_opp_of_remove_table+0x14/0x20=0A=
  imx_devfreq_probe+0xf0/0x270=0A=
=0A=
This goes away if I revert the patch.=0A=
=0A=
My driver just does dev_pm_opp_of_add_table, encounters an error and =0A=
then calls dev_pm_opp_of_remove_table to cleanup. This seems reasonable =0A=
and is a common pattern in devfreq drivers but cleanup now crashes?=0A=
=0A=
Calls from OPP debug code seem reasonable:=0A=
=0A=
opp_debug_register(146): opp_dev=3Dffff0000b87be700=0A=
opp_list_debug_create_dir(112): opp_dev=3Dffff0000b87be700=0A=
opp_set_dev_name(24): dev=3Dffff0000b94c2810=0A=
opp_debug_create_supplies(45): opp=3Dffff0000b87be580=0A=
opp_debug_create_one(103): opp=3Dffff0000b87be580 dentry=3Dffff0000b8cdf8c0=
=0A=
opp_debug_create_supplies(45): opp=3Dffff0000b87be500=0A=
opp_debug_create_one(103): opp=3Dffff0000b87be500 dentry=3Dffff0000b8cf0240=
=0A=
opp_debug_create_supplies(45): opp=3Dffff0000b87be480=0A=
opp_debug_create_one(103): opp=3Dffff0000b87be480 dentry=3Dffff0000b8cf0b40=
=0A=
opp_debug_remove_one(34): opp=3Dffff0000b87be580 dentry=3Dffff0000b8cdf8c0=
=0A=
=0A=
For some reason CONFIG_DEBUG_FS is no longer "y" on imx_v6_v7_defconfig =0A=
but if enabled I also get similar problems on imx6 (trimmed):=0A=
=0A=
WARNING: CPU: 1 PID: 1 at fs/dcache.c:338 dentry_free+0xb8/0xd0=0A=
[<c012df84>] (__warn)=0A=
[<c012e3d8>] (warn_slowpath_fmt)=0A=
[<c02ee68c>] (dentry_free)=0A=
[<c02ef174>] (__dentry_kill)=0A=
[<c02f0078>] (dput)=0A=
[<c0305150>] (simple_recursive_removal)=0A=
[<c04e32b4>] (debugfs_remove)=0A=
[<c06442d0>] (_regulator_put.part.0)=0A=
[<c06444b8>] (regulator_put)=0A=
[<c064b720>] (devm_regulator_release)=0A=
[<c07809fc>] (release_nodes)=0A=
[<c0780d24>] (devres_release_all)=0A=
[<c077b394>] (really_probe)=0A=
[<c077b9f8>] (driver_probe_device)=0A=
[<c077be0c>] (device_driver_attach)=0A=
[<c077be7c>] (__driver_attach)=0A=
[<c07791e8>] (bus_for_each_dev)=0A=
[<c077acc0>] (driver_attach)=0A=
[<c077a458>] (bus_add_driver)=0A=
[<c077ccb4>] (driver_register)=0A=
[<c095d870>] (i2c_register_driver)=0A=
[<c135d8a8>] (isl29018_driver_init)=0A=
[<c01033f4>] (do_one_initcall)=0A=
[<c1300fd4>] (kernel_init_freeable)=0A=
[<c0dea7e0>] (kernel_init)=0A=
=0A=
Patch link is here, didn't find it on patchwork to reply:=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?=
id=3D653f0d05be0948e7610bb786e6570bb6c48a4e75=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
