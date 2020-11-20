Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D872BB90F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 23:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgKTWfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 17:35:05 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17681 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgKTWfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:35:04 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb8448d0002>; Fri, 20 Nov 2020 14:34:53 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Nov
 2020 22:35:04 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 20 Nov 2020 22:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWB6J1PQbO0iZqN72KkWiBYaXKDTUgROTCgXgbV7juEXo2cZOqQ7iMch1ZC22JDnJkdv0h0bnhrooW5PGJAxbUXoeyVsb/aQ2C9Eb4WqEhZSVxiRtnInY3bac02ApktSV9FA+NYZObeLM89+RhgV69eAkhu16+y1WcxcoOMc83N9BxMQuMTpT8haHpod9I0dPfkwOhYZ0eSYlqlZdvnmARb/ZbH/Ht6qqiiBcbpEAHxD4iynOa5BAAUnC3by99lClCBJHQaIaxqug2GyONPYWWMoaPhZCABWPPou6ajo13cGcNVM0tBVtxd8sWUXdnBTQAzKPd/Ztegx2ic+N7daKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eGr3PF1NwScgvjZsvTqybd8jKIsHUobSCaqfZAic7M=;
 b=QiLCQLdjwS301eO/mhGuIoIt7tJMsPnU0i+mBbW9qIpyeQ1wbJl2qDIi69PyCKxpE5VvzEmFA4qYk9lb8K1ofIhi7nGawELg+RupDYHpit6C56hs/+Wi/sL5D4qKoq8ojREar2m2qIASQb9W+aYZ2TGTPEVjscVf1xp3E/gbtsIMsD4u8/Ny9awSlUCTHTHa4rlqyc/Kek8TcCr1jYJvL4kovwz5wHWwrCm2p/TVl8WAhrXZkHV5PoBMyiFQD76QF8wwXHdoUrTPynqrHV0LcG9gJUstc95M8qnBG8R30HwFLX50bWIOppZP9pMKpr4scenn/vkQJTw5grlpB/MFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3385.namprd12.prod.outlook.com (2603:10b6:5:39::16) by
 DM5PR12MB2392.namprd12.prod.outlook.com (2603:10b6:4:b1::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.25; Fri, 20 Nov 2020 22:35:01 +0000
Received: from DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::ddfe:5f48:eeff:1eef]) by DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::ddfe:5f48:eeff:1eef%3]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 22:35:01 +0000
From:   Ken Schalk <kschalk@nvidia.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>
CC:     Miklos Szeredi <miklos@szeredi.hu>
Subject: [RESEND PATCH] fuse : Improve file open behavior for recently
 created/unlinked files
Thread-Topic: [RESEND PATCH] fuse : Improve file open behavior for recently
 created/unlinked files
Thread-Index: Ada/jOUnsNReeTLtSJe5vgGZMLyUGA==
Date:   Fri, 20 Nov 2020 22:35:00 +0000
Message-ID: <DM6PR12MB3385BD749DF7B07275AAD703DDFF0@DM6PR12MB3385.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kschalk@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-09-08T14:32:02.8214678Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=aa700f7f-192c-4b7d-a282-bb83baf0ab47;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [12.46.106.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 249fe5e5-ea74-405b-2048-08d88da484ab
x-ms-traffictypediagnostic: DM5PR12MB2392:
x-microsoft-antispam-prvs: <DM5PR12MB2392E789B8F76B6FB164523EDDFF0@DM5PR12MB2392.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XjGS2jcns9VSVFYrw9HuBkUtFD/AMeqkG26TSg2rM2M8fPurI8D/AHHu8Wep1v8sd8Uaa8XiwjgEDhI+Tvsw7SVUVChRUTJbOVW/7fhlwCaY3NDeB1BbOSNfAXjblxfVr7rV3Y1Fq8FwGCwBYLBHb6O84IcWrDb1gS86J0KBMLi6SUoaeKRW/um9qDCeo/J+b30S7XcqsFSan0KJb1zkE5aBO9RKaZwaMrt3X8+eHzukXdVOvddXcvK+lQAlZiUrZKfQQmMpwQVrtMDqK5nUGtMRO6/dIOpADyw4PcRM2xrCS+R/S4l/a3y1aR9R2yUos/C3RJAXJ//hV+XOqNf6Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3385.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(316002)(186003)(110136005)(33656002)(8936002)(4326008)(9686003)(8676002)(26005)(6506007)(478600001)(7696005)(55016002)(71200400001)(2906002)(5660300002)(52536014)(66446008)(64756008)(66476007)(66946007)(83380400001)(76116006)(66556008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uhw5IZoNRXwOZPnjt415S7JYsbPqKRVLXsnAyDj/UgfKaFK72+YQ7MDicK5rgDBn5rbUXRqvfAtHLavT4d18thuD9dmfb6/cOAfHr3gICsGKdcoNAvWAfL8Ce3TJRBaHJqEYnN1K4hdL82hmtBi0J+ozUGIRvqFWTN7DyIgUOIF5ECR+pCPO6CboSU/TTIhzq9HKfYeCk1lYJPCBU15aOn2sBuljwMiEPegCxQ0vTNCXX3gn2whySZu+Y33NQf+r7RaqcrrYB1NVxJtEzJdYQtiSvym93ovB9Qg4pwtlXxl9sG2tTvj0+YFkRPQpCudK9xIEbzAlKbJwPugsz949xj2uwt9Pt1P4m6vF7Z3aUKkMOr1MsSZFHIDUXalAuawogBUdhNBKl/knvbMI/B8HFuZ8QtSD41xRajVrYvbogEPsEnR4HGu0dHCovXJUoijk9wicpiPQMvhgBXy6LFIKAE0jClMYXuLzIykfRSSLyn9Xy0B+27l+LhgTwm1aqn6v4M//xHwra7PLtRqSXEvUole6r4GF6q6Xy3eYlcv34VewuRh9QtAo0moOVq1SoP1YVu2t/P4+7bhlFrR/KoAnCnfYWxnx19n1ixVw3qX9sdG1vyzVq08OKcRfPBmTDBobOsARe0CfsnT9AtH0mQ1h2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3385.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249fe5e5-ea74-405b-2048-08d88da484ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 22:35:01.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvPmGu7+q7N3PewR+aGU6yT77auCoxlBBEVEO41vmPWmHoBptngt5W/9bhcPeqCntYHfES+2gGtG3UDyS1Bl7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2392
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605911693; bh=5eGr3PF1NwScgvjZsvTqybd8jKIsHUobSCaqfZAic7M=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
         Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:x-ms-exchange-transport-forked:
         Content-Type:Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=CEmeI5GtXZ8mfxqCGXZFrZuIzuuNpHSXRTTDZBEo7HOCHYDjScc6/qkLXCAGW8ePF
         /U+sPgDPpbH2Rh2Lg62G1bpi6RRqfPranAyKclDO5eidQJqG0N2diPzdWh1kfunMcv
         Bz8CVcFJmQmrnpC3lfS8iyN79gr0mo4hmDO7UIrTogy22INDbltAC4eC5Jn8ceeraD
         5ie6sGk5cp39hs0vzAHg5gB/t0bh+tfjMPbFd+1BLYVgohDytZKFo9rT6iCDJ7hfCJ
         VlYaGIWmSYkJcKEstUfW9B5F4EJhOyq++/adgx7whNQTgJ6KmpnqgVfdtfuIxO1n5J
         kgaoZBUZZjlzw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a dentry exists for the path argument to an open with O_CREAT or
a negative dentry exists for the path argument to any open, make a
lookup request to the user-space daemon to verify the
existence/non-existence of the path.

This improves file open behavior for a FUSE filesystem where changes
may be made without going through the mount point, such as a
distributed filesystem accessed concurrently from multiple hosts.
Specifically:

- For an open with O_CREAT of a path with a cached dentry, the
  user-space daemon is able to report a recent unlink of a file
  allowing it to be re-created rather than either the open failing
  with EEXIST (when O_EXCL is used) or a FUSE open request causing the
  open to fail with ENOENT (when O_EXCL is not used).

- For an open of a path with a cached negative dentry, the user-space
  daemon is able to report the recent creation of a file allowing it
  to be opened rather than the open failing with ENOENT.

This is intended to be functionally equivalent to behavior in the NFS
client which re-validates a cached dentry on file open.

Signed-off-by: Kenneth C Schalk <kschalk@nvidia.com>
---
 fs/fuse/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5d43af1..eab0288 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -205,7 +205,8 @@ static int fuse_dentry_revalidate(struct dentry *entry,=
 unsigned int flags)
        if (inode && is_bad_inode(inode))
                goto invalid;
        else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) |=
|
-                (flags & (LOOKUP_EXCL | LOOKUP_REVAL))) {
+                (!inode && (flags & LOOKUP_OPEN)) ||
+                (flags & (LOOKUP_CREATE | LOOKUP_REVAL))) {
                struct fuse_entry_out outarg;
                FUSE_ARGS(args);
                struct fuse_forget_link *forget;
--
2.9.2
