Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346F632B4DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450126AbhCCFa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:30:27 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3116 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582047AbhCBUSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:18:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603e9d7b0000>; Tue, 02 Mar 2021 12:18:03 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 20:18:02 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 2 Mar 2021 20:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIFHfF541a8TEc27HteV0X7SPQnMFVpVxxFwME+6rhB/QyotyRPMwV2qRWFKuQ8qnLjNkw647dvBfCrM4GtU2fPQQfQPhLbTBV+U5Pjr73LKFuL2pSq9x16gNf3eDDS7FX19qpGnXiS618B++mu+w/qxNv8b4ODgVH7pniDALciDKGuuwsOhYRXrwRd1bJ4iDCQcsZZ4IDZ86zFS49olhUPnwI5g/oBHQ+KKGbyudbEh7CB6VxhkSBlL03yUJ63dShM9Twqkdfu4Sbv5fOXdkLqR0f77Xfr+JGdyM5cWCLf+DItIKfFOKXzW+rpkuvhEkc+LqeoQuDmIXi8CtgFA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRKWLWO157z6pwj7FpiXPV7XIhe0xiseYJqYfaznWo8=;
 b=AHctGTc9AGfVZMXbtItLo2w92MMee2OANDZm8PYWVhfgTkX+NpZvH/k1jq8X2gUEUJxpG3rqbsdd1IJ4S5UoGLPA28w8hX2CGnF/tjTT7dtg4QEKvWS2RYU/WA8nAm4BzUiB6fVXZkUutI2n3oP68IgiQACo+YwjrwKkjmOGunTJr1eu5KRb/ZyONkOghcKN9tWYBj0Hok/0ayubQW7Cs0k8NjOAEbKUoGBNMF5v9db9OLqAGad1N86COitYHMvDDUk5k2MCa+ZsBRIOx113J6JxXYXqpfGs4xZCnG2lJZnrPpj++Kp5HQ1upV3kzCCMfDvfYSOZbByhItUOP4XIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 2 Mar
 2021 20:18:02 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::9428:ff6a:7f2:5976]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::9428:ff6a:7f2:5976%6]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 20:18:02 +0000
From:   Nitin Gupta <nigupta@nvidia.com>
To:     Pintu Kumar <pintu@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>
CC:     "pintu.ping@gmail.com" <pintu.ping@gmail.com>
Subject: RE: [PATCH] mm/compaction: remove unused variable
 sysctl_compact_memory
Thread-Topic: [PATCH] mm/compaction: remove unused variable
 sysctl_compact_memory
Thread-Index: AQHXD411mHVMaaygcESwzSP7eEOUu6pxIlMg
Date:   Tue, 2 Mar 2021 20:18:01 +0000
Message-ID: <BYAPR12MB3416C9FD5D10AFB930E1C023D8999@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <1614707773-10725-1-git-send-email-pintu@codeaurora.org>
In-Reply-To: <1614707773-10725-1-git-send-email-pintu@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e8d5048-0c24-4ce8-f3da-08d8ddb847bb
x-ms-traffictypediagnostic: BY5PR12MB4323:
x-microsoft-antispam-prvs: <BY5PR12MB4323272E34FAA521D6DF69B8D8999@BY5PR12MB4323.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: enZrwk5n+DAPmlSVUCikF4POmkJhA5016JiqV+T6qHn/2z9ibUtrT7q0p8AFJShFm/JPZONGb5U0XTGecWjMJ9NznPr8z5bOFUHbo+JsQRDja6VIhiiC/cA2sijl83DAmGGBbmaFwB7eVz58DOnIFWgHfKLKX2oYTfUmcRncKwpWwcZfnc86f+Xf4l4XI76Dpudiuofc61dkjRcMIjdjMnUn+uNprVe5jO/5P/GzVXPEi7n7RSmXEYmeWGY+XMgLmLYyggT2GymFEXGq8MZlyKS7LtjmaVwumyUW81jSdFeDrY7U6zdgdGxkl2DWSmaKqQKVc2e1yYKX8FOpY1uDdrjEoc31nplApDn2hUpk2jQzcWzXD8NxVsIXDdfuJdCjx9pOaNhBudkPXkpsXvp9soQZh5aeS+S/tle+ShEM6pHWRPUnOz9KrsmIHQxDEO07SjmOUjOQTmPt58smhZFa0YOAs7VnqlhaE7xWWK1SP9Z4GnmCW2NKSdj+yRwu3p3DQEpS/Y9Ri49IX/x1dfmNtKf6lNdh1YORyb5EYpZBHE4cs3LjLZkqtpaH6jX0AVb+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(110136005)(6506007)(66556008)(66476007)(66446008)(83380400001)(8676002)(7696005)(26005)(64756008)(52536014)(4326008)(33656002)(71200400001)(66946007)(2906002)(8936002)(76116006)(86362001)(53546011)(186003)(921005)(55016002)(5660300002)(478600001)(316002)(7416002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lEMonPLdThL37J2ANxFHkf4enF62zqRyDHBErWDD/Z4y0R82C0VK7UvPnZ2q?=
 =?us-ascii?Q?NA7hcd1S1iOAqm8r8ktywqisSVRVYe/novwzlvWaBvzUUG+3dX0EqQsntBCc?=
 =?us-ascii?Q?m++BLAf0z4dOxbi2+wugdyYm3/BCrw/CSqJbZg12VTaz5bcsQQgOgqDIBmvt?=
 =?us-ascii?Q?dAfmXGu6XigKiR1oG3g2w9tWnFDRrFJW9138tKBIbXm7Wke4ydO3Obko29H0?=
 =?us-ascii?Q?ka8h862FEy5AEL155QLh2jYPzvBdG45Wz99zvJ4LNHlD8fe1B018WAXJAO65?=
 =?us-ascii?Q?FoRvqJ+FNengXOv3qINypE7onjKcJsvnMjQVDnfMVUOt8vY/D8JiaPCYg9z0?=
 =?us-ascii?Q?3l+mVFsPfBkDWEQm+h9SuvoryV/bDe0zRq4JK3PXcRj3+OgXFWdxSVc3p7Nl?=
 =?us-ascii?Q?xY2ge8yrnUY1n3CzsEvEOpcrn6n0Q1uSBzM66NQaR+cxwQ5fqTzLb8iYAOfI?=
 =?us-ascii?Q?+WXQdyY2aaMmu2+7N4eyodbrTRlDYm38guwt1dWA2GJfjsZA/rsA8Ts2EMXn?=
 =?us-ascii?Q?9lg0JrLELg9j/+zpzV4R3Fdn+i8vaq2j8jOo2oIXWjYxsZ0yXuP0BLSOjgyU?=
 =?us-ascii?Q?oOHTS8tLsvhVopuRVYOOixRyb7VQpbr8YNZAe6+94lvoHIbkvhDPFahNyR+0?=
 =?us-ascii?Q?NsrQbqc97X3sLqJIwRgVB0SnXwHugRpnZNXe0K3W/4L00+CnOQPqUkKRWyFf?=
 =?us-ascii?Q?kelvpCLb00Z4OOrPvKb9M1eiltmvY9jzxbNzqn+5owo5SOfzuSdKvaDPRwzJ?=
 =?us-ascii?Q?y7tjSneysW85mhIOMydQrrwH0An2qZdxfcJO8YL0QU4dkf2bUNcQbIg6Oucl?=
 =?us-ascii?Q?IjMtlM9+k8zY6WEnll1P215mpE9uQ8O0eISnSjRcTrzOCxXYv5quF2KGr5dL?=
 =?us-ascii?Q?x85VRHcp4WIG0MjUBgCF8ugvAiaWpy10SvBbQNtN6zQ6x1uut9U5R+PdQtBz?=
 =?us-ascii?Q?dcfAnMkjWFK+rT3JhR4IR0+qHob+sNPV3GOOmMpdl1beWY9obc7o8yJ9lsAY?=
 =?us-ascii?Q?kZBeNUFNmUIVY5HjMltLm418fbsW3GqGKJJgL2KnEdALMedOWOFpP7Bl4C2V?=
 =?us-ascii?Q?viw6Ync8QtWkZ5dO6Yv+qqnnJ+T06sg57LkINgw6apahOQTIbny6DtErqacp?=
 =?us-ascii?Q?WzacWjOz/HyQ7thK3alzHPPaWZ4YNPcpr/gSAP/lLmAh/OXqkR0J6VpJVO4i?=
 =?us-ascii?Q?rhWsesmkKWmT4GrLbi2I4DsrMAqkBKHYmRHrWfJcSDMlsUQQM1T4XomW6FZV?=
 =?us-ascii?Q?/fiudSiQ7eb5gedpVta2zYFEWnrSTAzUJqYq/Y2ZQvIJcpU+L9nbDKprPvP9?=
 =?us-ascii?Q?+OI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8d5048-0c24-4ce8-f3da-08d8ddb847bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 20:18:01.9306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMz9dUP0xP2lKWr44FUTraD4Ap+7yvjO+DlCw3E0x4Gjv2pLUWN/KYJRaZ8ppck3ZwuySSQ5F2THyNUeew5uRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614716283; bh=fRKWLWO157z6pwj7FpiXPV7XIhe0xiseYJqYfaznWo8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:x-header:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         x-ms-exchange-transport-forked:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Nx7tfkfMZ9BAO0iRZfpUaha0UIbMqZQsjNocFpj5092aoMFP1EMg/TGlR74UryI05
         DmIQLtWeCz8gS1Q/wmNoT/6XHt6Nk3he0Iip7kO5QIXiMJK1uC5LFt5Rgq+L3MJQYm
         sfm01MWawlbsr4CWy/trE+8je5Dr9MR0V7IDk6DuNxW3pC3W0+sAfzC9rpm2eW3PX5
         GlJlAy8PnXx8y7KOJi8kpzc7xiKZl9FBvs5L76gIWIB3Ain+JnAc/If1MggwkaElYA
         /6ZHyXsPfk1XMp/1YFV6bJnF5dV+coI+KTSnoi95xN5F+IuB25qFg5923p/sDxrlAv
         j4UlyeC5cAfhw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: pintu=3Dcodeaurora.org@mg.codeaurora.org
> <pintu=3Dcodeaurora.org@mg.codeaurora.org> On Behalf Of Pintu Kumar
> Sent: Tuesday, March 2, 2021 9:56 AM
> To: linux-kernel@vger.kernel.org; akpm@linux-foundation.org; linux-
> mm@kvack.org; linux-fsdevel@vger.kernel.org; pintu@codeaurora.org;
> iamjoonsoo.kim@lge.com; sh_def@163.com; mateusznosek0@gmail.com;
> bhe@redhat.com; Nitin Gupta <nigupta@nvidia.com>; vbabka@suse.cz;
> yzaikin@google.com; keescook@chromium.org; mcgrof@kernel.org;
> mgorman@techsingularity.net
> Cc: pintu.ping@gmail.com
> Subject: [PATCH] mm/compaction: remove unused variable
> sysctl_compact_memory
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> The sysctl_compact_memory is mostly unsed in mm/compaction.c It just acts
> as a place holder for sysctl.
>=20
> Thus we can remove it from here and move the declaration directly in
> kernel/sysctl.c itself.
> This will also eliminate the extern declaration from header file.


I prefer keeping the existing pattern of listing all compaction related tun=
ables
together in compaction.h:

	extern int sysctl_compact_memory;
	extern unsigned int sysctl_compaction_proactiveness;
	extern int sysctl_extfrag_threshold;
	extern int sysctl_compact_unevictable_allowed;


> No functionality is broken or changed this way.
>=20
> Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
> Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
> ---
>  include/linux/compaction.h | 1 -
>  kernel/sysctl.c            | 1 +
>  mm/compaction.c            | 3 ---
>  3 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h inde=
x
> ed4070e..4221888 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -81,7 +81,6 @@ static inline unsigned long compact_gap(unsigned int
> order)  }
>=20
>  #ifdef CONFIG_COMPACTION
> -extern int sysctl_compact_memory;
>  extern unsigned int sysctl_compaction_proactiveness;  extern int
> sysctl_compaction_handler(struct ctl_table *table, int write,
>                         void *buffer, size_t *length, loff_t *ppos); diff=
 --git
> a/kernel/sysctl.c b/kernel/sysctl.c index c9fbdd8..66aff21 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -198,6 +198,7 @@ static int max_sched_tunable_scaling =3D
> SCHED_TUNABLESCALING_END-1;  #ifdef CONFIG_COMPACTION  static int
> min_extfrag_threshold;  static int max_extfrag_threshold =3D 1000;
> +static int sysctl_compact_memory;
>  #endif
>=20
>  #endif /* CONFIG_SYSCTL */
> diff --git a/mm/compaction.c b/mm/compaction.c index 190ccda..ede2886
> 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2650,9 +2650,6 @@ static void compact_nodes(void)
>                 compact_node(nid);
>  }
>=20
> -/* The written value is actually unused, all memory is compacted */ -int
> sysctl_compact_memory;
> -


Please retain this comment for the tunable.

-Nitin
