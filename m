Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9F261DE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbgIHTnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 15:43:41 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17949 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbgIHPvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:51:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5795600000>; Tue, 08 Sep 2020 07:29:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 07:32:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Sep 2020 07:32:05 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 14:32:05 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 14:32:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZTBunus6lpf4V/tqaDYJntROy5OvRMlMcH+VeL5P7v8BWQri//trRLN+WcjVyZ0MSVPp1pDVWgzAwpxFtv9aNSkXJDQScQyZV5aN/i2gfqAPLHGgphz31Dijx9NQiuF1dfehwerY1waYLxHwBp7KlUn9DG/yfG2P8AkdJmBRL7OW2evxCT18kw2gAzNYZ1ohudx4Pq4ts31JbkBkPXF5LSPu/6OdHJBq3Bpf+6oSH/25Ek4oAqfhjIAPUKjadZZFxT7EmSq/82IWurYqqwzuysUpVZdBZsqtryHxK0BVxxSRGYN2cadfgZzptx9AXAHrjBQLkTWYCL9vnPJAm4zfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj5v6a5rMjoJWUIAiKZQcacBVTykTRiWLAxK493GuFM=;
 b=EHOTzrdwbg6jgaTHLWMsY46OxZIYMwqBWPsJjl3hbUbKxw3gceeUlAqkS3nfPBvMkSn3tzFX8T2GPx2x3jnPrWkmuBCrDD3bMJ7guOiJTKFN14PGLACKcmJ0A1Rc83Q/ImvIZBrEnvIaVJW6UZQCccXaA4FhJa2dW2qald/YadPHLNGI6+pSJ3HGkDHUFIIAGkB4PEpzwlCOCSYr1OJSrFQIzfv4Intrz/zD/55PutqhExHu/eyrW9ok21dSARJdOG+2gaaIlO6CMytPYXwVEnMyiDUsduHKC4A2b7wckamQJE/ZSLOSkm+ayiAUzLrU6JOITlJpDiUXYVnlSrxKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3385.namprd12.prod.outlook.com (2603:10b6:5:39::16) by
 DM5PR1201MB0140.namprd12.prod.outlook.com (2603:10b6:4:57::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.16; Tue, 8 Sep 2020 14:32:04 +0000
Received: from DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::c896:55c1:677e:45f]) by DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::c896:55c1:677e:45f%3]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 14:32:04 +0000
From:   Ken Schalk <kschalk@nvidia.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] fuse : Improve file open behavior for recently
 created/unlinked files
Thread-Topic: [PATCH] fuse : Improve file open behavior for recently
 created/unlinked files
Thread-Index: AdaF7Lbbgcz7i+PBSy2cPRijAnjKgQ==
Date:   Tue, 8 Sep 2020 14:32:04 +0000
Message-ID: <DM6PR12MB3385C7EACD424E9E15B5A3D6DD290@DM6PR12MB3385.namprd12.prod.outlook.com>
Accept-Language: en-US
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
x-ms-office365-filtering-correlation-id: dce0d189-9e76-4d74-5365-08d85403f504
x-ms-traffictypediagnostic: DM5PR1201MB0140:
x-microsoft-antispam-prvs: <DM5PR1201MB0140EB5891CCA37CBD86ED4ADD290@DM5PR1201MB0140.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 68f6v5L5mKH1c6bink0ScgAkIKOm+CAq5OD9pzLaPbThjmItEvwYGchvE2wI0yZ2VmYDKUXDHmQTw+mNwNzYCtVOJubPGLby1VlZaVZ+0M93wjpYEmFwM3sZ7ZPSR0H3aHjaFIPWw0Nnd2d9rRCzosfSDMFcvSlwOoo6Kdr+5fsdCo2By2dGl6JQMUOr3ML7tvorhIXxm1/ADNC/GxOUPiVljtwh4Cddda8BJz4ww3R+QjYiHBoPKpu867gXxXLlx0IudCZz0bZdG6dICY0bXA0Yzo5M35Vix1+PbQKdy/7h0uztteztzho2KOv6B0EAxRAnbruRKPk4ElZVpbu7Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3385.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(6506007)(55016002)(86362001)(2906002)(33656002)(8936002)(5660300002)(71200400001)(478600001)(52536014)(7696005)(316002)(186003)(26005)(83380400001)(8676002)(76116006)(66476007)(66946007)(66446008)(66556008)(64756008)(9686003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Y2KWJr3doqnu/I3/4/iQtHozZ4OXAzRkhEflSxdkgEuKbNniEoCN+BIuz50em+9RQot4Cswa0/Zpw6tBzlMDQJszZ689Ao86DfGbOA0bND2o45Y3D5ssvA4o046Cg0MX3CBjIwd0PxzmOA7ISRO7DI/VW1hIZBKZ7DqbIoOFPFFVGaqWhTle/HTl2PVF+DmqntKrTr/C38BJhGrOzLCy9oDFcSbnQVF73cU4zmRpaOVz3NLJbTqBqJxu1FSrwZTDnkp9VMtIJTcF56bHbz+VbqCFHcl8hT7EJU9yJrhbGocptx4GrP3djWFJoBjfo/wUxmW/ocgQx5fls/noJZoqltDY7a75juWIdu5uxAjuVumOnfnDdUK47cIfLbl8DbarHBYkLdg8S0Pr4pxrI+0fSCfsBAQEk2nsMeG4vjVQ5shKrzEckKxz4GXvpxrWje6WdPgFt0+iHRsWEYK63q/E56fPfXRHGRiU7e4jmpNz6S9vQ1Mxp6AK47ohRFLzkHOJeKPCk1YRtrV607iXLM7jEZW+VYqza78y+inVrFn/MjNc2Yb21uwnRzPFlDri3wqOoTAtUk40l4IFlZC9L0AtbOEiOqcVjoTZ6Y2ngiFAsE9rahcglIg8cT4xlrZQ27bw5zWkbRO9vT1YsiuoEs2tlw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3385.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce0d189-9e76-4d74-5365-08d85403f504
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 14:32:04.4272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5xqJpgXOniSik7ghbf96Lw1bUaMCu5rkVWq/mQY1KQ4rPGcRwxDEI/iy/tmrrQCcmsQFtWlar4eauT3yErKkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0140
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599575392; bh=wj5v6a5rMjoJWUIAiKZQcacBVTykTRiWLAxK493GuFM=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:x-ms-exchange-transport-forked:
         MIME-Version:X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=Td92t8hoExCfVD1VluugRhwYUtJEUQFW+sLgvCt/n4CRGMhc2AGPblhyA/qJUeygo
         /AV1rkO39Vo4Qd03UrCRWJKzHxr9rq6u+92rfyzWo8xGrJr8XYQk3YsqiXoNiWwsFQ
         HFxkpPYrRv6HgTADnuf9FdK6bPw56VlNHLlurBBg284NTyojVgLMxYC1eZD8X3xh2A
         CPGEILh4yA0S5TYEDp6quY1fMzErNqY6K8an0dnaSxZDmD/eFIAj0t2nTiAV69YDdT
         js73NHvbMoEI0AGLdaxNaZ6RlFqjkJgoAnVYv4H+s3rTxOjLI0Hr1msNTk8UXE5uax
         jSyydV5h4QKPA==
Sender: linux-fsdevel-owner@vger.kernel.org
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
index c4a0129..b46f5e8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -204,7 +204,8 @@ static int fuse_dentry_revalidate(struct dentry *entry,=
 unsigned int flags)
        if (inode && is_bad_inode(inode))
                goto invalid;
        else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) |=
|
-                (flags & LOOKUP_REVAL)) {
+                (!inode && (flags & LOOKUP_OPEN)) ||
+                (flags & (LOOKUP_CREATE | LOOKUP_REVAL))) {
                struct fuse_entry_out outarg;
                FUSE_ARGS(args);
                struct fuse_forget_link *forget;
--
2.9.2
