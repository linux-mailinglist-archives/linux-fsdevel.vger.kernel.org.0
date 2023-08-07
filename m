Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C887977332D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 01:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjHGXBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 19:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjHGXBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:01:30 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F810F0;
        Mon,  7 Aug 2023 16:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U73Tcyfbb2gyurNSag4bgajgzTsYBUGmWlB/lKM1NjBSO9pPds9sE3LBPrI7Y/0K/B7n72PoULiGyleqiWoEo2W1lEE3FiLn9VAwJYpZM3nLhsQumrhDCGv3n9fqUOqshxt6vhyA2oGus7QBXTS6Lw+lkKYNAOhP+Fn2yJ0u0IRI1VyYzfqXIr+FmvueWWEtDrL8zlEBFBYgj+D0P9GMLz6Dph4DYhL0i58cB/tDkKpCzmdR9uEyCNn53XeTaDRQIP/CUY36hF6M38RJJEJvUywjDgkR8DKHSWIVJei3gMz/ac+ah4dCFE/E8ZKSPKm6EMNgldWmLY7MalPeoLlFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLy79+XZzmn72G/Xf34Csuf9oxbRxlXMpXnm0uCCGD4=;
 b=Y9VGWz8SIn6g7cXaKJcHeduq//edCmZB9poieF0LJ90WJsTnRyFu0AAHshzTkk4Wu0TFWyssPlK4pMFdknoS68L2mH8k0HxQRIGh4+oDE/V54ul9FFDKLI69Sfn43Wf49+ON+VOMsn96iuPZe0mfbXRtZXKQ67U/Paq8zvKDMAcB2WYKU6UJDN6WCahjZq6s2BsjINm1N8+qnptnw5lOArsOPKy0L4MLMyLPzLmQ/1DyhsGfVNyTF+xV/nSeFnhZOBad+q+aqgL4fHt0b9mM7ylkem+AT7ECjKs1fYj55CXIpI1isdv2X0xChxpN2r5le9wS3HohwdvIRa0LnNxZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLy79+XZzmn72G/Xf34Csuf9oxbRxlXMpXnm0uCCGD4=;
 b=TWnfktaEFzIzq+tH5hVIzd+EsFkJSTXIpTGTJb736Q92Aut492bQ54c/8GTIhsMU48SJwzu0dk6Wd+K9ARkgFI6SV5E6z5qm/3POPTcENiSEDZwHNmdYOsNR8grUW90r1/l/YehIrmgx2kZni+Uvf/E1hYLcm5t/QtCKK2eMC4g=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Mon, 7 Aug
 2023 23:01:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905%5]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 23:01:26 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Christian Brauner <christian@brauner.io>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>,
        Harry Pan <harry.pan@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: ksys_sync_helper
Thread-Topic: ksys_sync_helper
Thread-Index: AQHZw3+H8Y9jcJgF9UOuhI7iy4bjF6/UMkWAgAEXZwCAABhSgIAKF+3g
Date:   Mon, 7 Aug 2023 23:01:25 +0000
Message-ID: <BL1PR12MB514488C022435B4090B72D3BF70CA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <ZMdgxYPPRYFipu1e@infradead.org>
 <e1aef4d4-b6fb-46ca-f11b-08b3e5eea27d@intel.com>
 <ZMjnZhbKbNMmcUPN@infradead.org> <ZMj7zTwPw/qi/bNw@casper.infradead.org>
In-Reply-To: <ZMj7zTwPw/qi/bNw@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1a418b82-b739-4131-9694-0c9f74dbb058;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-07T22:42:44Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB5954:EE_
x-ms-office365-filtering-correlation-id: eb00c3d5-fae0-4f45-438c-08db979a3a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jq9fMA3iYivrlUL4ZrUDY5cEL2SPX9PvkgL/BnisRbrNGbkdL7V2lq6QBpvAU/E5nmTohRriCTM/JCyOgd9uTeTpN6kLDSw0/etWlCEVfyNulNY2zIpZDP+f1KVNsz2SUImg4Utz559f9hxKwRpy7HUoVN0F35Cd7WcpJxs2FM9VQ3m3H7+ab5LMl//9BVyPqFqsnjMzDl8ylucV70tp3wnAGY0Bxbj+7dVMk6+jIn628k0ArkaxXuclq+m8buIga4JwNdXsPfxXHrFnet6zBV84bjb50wHTgZMknOrR3HnT4N2hg1Qvzx5xx8X7YaL9X/DsfQlS3xHJwI8lwTnmxvtAlqCzVcHbEwdIjnNo0yrft62m6FuV7ocEnvNS39impHJ7i0c0DAZlHGpFCtTDm0bMOhPyz/0Y1ICZQs0Gphe3v8G7UNgOB6XgxExokALcVdJpMfcPBJFF2NP4glHx9GdT1HF2yqNQPs9Z7MTbtAwTbXvR+FSF24zqrRmNIljWr0VvTJM02h6HwEUH/eaP1ScWOmitYHRj0gJ/zulwX3pLN17mLoj/PvTJ2btFIeVdxC1+ubClqoNm8koZ1FvaIM6nQpoX6gJ3teQgAg9nXGCuztR6CVKTvEe5aXNgA2f/vZeGsvbWeejYOcVJY4H5iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(1800799003)(186006)(90011799006)(451199021)(83380400001)(55016003)(110136005)(54906003)(2906002)(4326008)(316002)(5660300002)(8936002)(7116003)(38070700005)(52536014)(8676002)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(38100700002)(86362001)(478600001)(33656002)(7696005)(122000001)(9686003)(71200400001)(41300700001)(6506007)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tbZkbm1gF3v57qHHuh62drecohJ94npfT8eag6GU+piuWNjhh38axBRb5AU8?=
 =?us-ascii?Q?IizrF6d91W7C82dSuG3WDHIkjaKGII1Q/49zodNjA+4Vh/WNZ0K4ztNibeCW?=
 =?us-ascii?Q?ljGiMV0hYhzzvGDvlghvVmg4vOcz3UnUjuuKx2b5LdiElPJHDMV2qjwBsCcv?=
 =?us-ascii?Q?r/+nr9Cx70vx4+7L3oaG6NQc5EK81U7Z+yrL3L1oa01jSOJBIwD7FLIx9wr6?=
 =?us-ascii?Q?b/FH/CPZ8bYOAJTsvijhbECP5Qjj5oMB62h8F5UFrZ8NE5j0IaDz/HakCAIX?=
 =?us-ascii?Q?UJ0eaVmckx/xlx0p5q1Dnf8jdVO4HhQd34V8YMuGiju0QpdAM6WED900E2vV?=
 =?us-ascii?Q?qwZ83Gq43xp+PVUTCg0RMgg0EiY2Q3xqnVJBi66AnFAK3alCBu0ueqOEQ00J?=
 =?us-ascii?Q?ZjHt8GczLBzcv3bsaj0WB9oSfDPvLNyYuALaF2veDX1DNR6q3S//+ScXmNZc?=
 =?us-ascii?Q?CWD7VS4id+8k8AM5VsjX8aYcxqGXfR9TuBXuNLJ1lcPorvlH1eXay42ZjA8l?=
 =?us-ascii?Q?YoT9bF9Q9aZ+uFdSfPXTUvoOeAvzXp2y5Cbz4n7719HexB7JCOS5ZmwEtVeu?=
 =?us-ascii?Q?P+QrJI6PFCEVzib1XFIHYLgZ0eq1RrS6br0I9ngIVcsOltA73zzhkWrKtiwv?=
 =?us-ascii?Q?UGisXjlUfmjrvzHwt0K8vN+pk5LpStxD66LfrP79EF1WsscdWBdsypejwUf9?=
 =?us-ascii?Q?FDvJKT2mjES4Qhrqh6b3Sf3R22WYd1AVmvgEMvzNIruVCJBsa2AOX+MHFZ3K?=
 =?us-ascii?Q?i6+vmzyUvoOwkJKKjaC9pHbXGd17h9cwI+kZ3wuVmTPYq1YiPp3xU49naoKU?=
 =?us-ascii?Q?v4V01ku1PDHqCoIiGsbyjAVi+5BDKE/NrNigZwlQLn6e5V3ZoPpGf7EjMISc?=
 =?us-ascii?Q?Fa5iLvepz2c2i2ZOlH1W30Yo8NGnLjm/NVm/bAHeK8wXOzn82ZCtgBp6bvsG?=
 =?us-ascii?Q?4okJOkbhbubAjl8QqGAya1AO3WO08jksrlkwhrrT7X9XEGqoy86QZy03svsH?=
 =?us-ascii?Q?MQjYAZcdTsUJUEvqfIgVaScicdUqqZWsmZPr+jxhfMep1ttLMbjwC86SK2ag?=
 =?us-ascii?Q?8OCdjZUE5w/RYfXrJWcyWo9qaKFtPMYOtyr3sRlX6HpQijiR58vJiK3Mmfzm?=
 =?us-ascii?Q?WLT82pxqEjpNDZHLfZ4nhSHGca8tnOxLh+FIdeguQLiYb7BQPs/MFythYPXf?=
 =?us-ascii?Q?aqq80Vyz0nqOQpdmCZcxg5+c8SR6Fih0/b2IwzTUEE+EXxhSP0rLXZDJB+PG?=
 =?us-ascii?Q?VriPD0Ha6HhWs4m6R+i2cJJ5qG3ROMbPgpbD/OjJnN2j8olTjXF5HuZey1uN?=
 =?us-ascii?Q?xY/TrBompdAi/U00MQwHCWWzGFBiJO7QcNMaUL4+pP6wVX1WBohu/YZAL8qX?=
 =?us-ascii?Q?IwJwNoNNc5iadrCsVLu5MqJaQQ/c8vZeaZP8xgnZ39h94lBAql0Wi3uJnmfR?=
 =?us-ascii?Q?K9PEt4hxkbSk8vh+xkR34iR+pzr4Z8NH7dfX1dlpxW0vK7MGIMuPue3tJ92N?=
 =?us-ascii?Q?DkAuW3y+sYo3pUsIpotx+LwwWReMBQ9Cf95S6pAiS73mrKtR8fkv/aBiKEPC?=
 =?us-ascii?Q?1BW8kxMlUU3APj/gjiQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb00c3d5-fae0-4f45-438c-08db979a3a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 23:01:25.9817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlaP+jWmz8q8lXbeUIU4hoCZ1WYQuZKslmGG2+JvPAbmOrdaVv/u8hWvvwU/Oo473aKzpJ+KySWL911/DrmCfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Matthew Wilcox <willy@infradead.org>
> Sent: Tuesday, August 1, 2023 8:34 AM
> To: Christoph Hellwig <hch@infradead.org>
> Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Christian Brauner
> <christian@brauner.io>; Andrey Grodzovsky <andrey.grodzovsky@amd.com>;
> linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Harry Pan <harry.pan@intel.com>; linux-
> pm@vger.kernel.org
> Subject: Re: ksys_sync_helper
>
> On Tue, Aug 01, 2023 at 04:07:18AM -0700, Christoph Hellwig wrote:
> > On Mon, Jul 31, 2023 at 08:27:17PM +0200, Wysocki, Rafael J wrote:
> > >
> > > OK, I'll remember about this.
> > >
> > >
> > > > With this
> > > > and commit d5ea093eebf022e now we end up with a random driver
> > > > (amdgpu) syncing all file systems for absolutely no good reason.
> > >
> > > Sorry about that.
> > >
> > > The problematic commit should still revert more or less cleanly, so
> > > please do that if that's what you need.
> >
> > We'd still need to remove abuse in amdgpu first, though.
>
> This would effectively revert d5ea093eebf0
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index dc0e5227119b..af04fece37d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -75,7 +75,6 @@
>  #include "amdgpu_fru_eeprom.h"
>  #include "amdgpu_reset.h"
>
> -#include <linux/suspend.h>
>  #include <drm/task_barrier.h>
>  #include <linux/pm_runtime.h>
>
> @@ -5225,17 +5224,6 @@ int amdgpu_device_gpu_recover(struct
> amdgpu_device *adev,
>        */
>       need_emergency_restart =3D
> amdgpu_ras_need_emergency_restart(adev);
>
> -     /*
> -      * Flush RAM to disk so that after reboot
> -      * the user can read log and see why the system rebooted.
> -      */
> -     if (need_emergency_restart && amdgpu_ras_get_context(adev)-
> >reboot) {
> -             DRM_WARN("Emergency reboot.");
> -
> -             ksys_sync_helper();
> -             emergency_restart();
> -     }
> -

Was on PTO last week.  I think we can drop this.  Will try and send out a p=
atch this week to clean this up.

Alex

>       dev_info(adev->dev, "GPU %s begin!\n",
>               need_emergency_restart ? "jobs stop":"reset");
>
