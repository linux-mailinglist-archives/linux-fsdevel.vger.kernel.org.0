Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CAB1E6C31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407091AbgE1UPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 16:15:03 -0400
Received: from mail-mw2nam10on2072.outbound.protection.outlook.com ([40.107.94.72]:52034
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407056AbgE1UOo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISE+PFwlL6ufCBXYaNDfNCKhTYTyALruAFD19EUd5arzWZPghye3Mdbk2qOJl6moUzfkySbSfeW37Anqm8dvkf3AHDRFd/REwvMTBjjQ+kTxLC6EdijT++nJfYcxSEdPtdnmL2VhCpIJNOxre8G0Y4HcGFKCSyrvCnML36UV5dWwOJc8W8aieVkiJPIkmE9fv1+AT7XFTxkieedC+caJe18CQeDL2xFQ1N5FvnixOQdJfAYqJvJGFXyf91P9GjArflTH1dD6e47yphJtHuG1fwLuel8YFGW431erZ3YqFXlXn9a2D31gYoYSMAjgV06aVpLCZkurBRSQxXXiDeuj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orIS4CFS5oeGgBCuq/99qVZ5HiIbxyovwED34kNixdg=;
 b=BdKRxvMF0wViQit8X0D9khnydaMukaDebMrlEQ5KGs/E9UfwZa4+qhN6n0nONMJN4S/DfRoNN+2wh+3dQdAfFMQq0aATkhynyaS3pE3Vf1z4kHHTYE0vsFwbNo5pe3wUtpJpvAsX1PXibN5AdMex2wKlBV5G/V97F0UvprSbQ5gBLBmPeey/wj0ge5ATVUh9j+V65E5L2IXKFjkTpkrUThbezhNpjSFlSreHAYh4QV/TX4w4cEND4q8sS9iP/ZktXVj2zT2eTK1bO0zqfgdar0/F8H63FJ0YqUWD6PZHH74PQbpri/px2USPRTWQ8KAXPEcXSX7G39kjMxeA/ZWLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orIS4CFS5oeGgBCuq/99qVZ5HiIbxyovwED34kNixdg=;
 b=e3pwXZVe2qngLaHNX+/m1Y8uwpNxaqm+iVuZY4I6S2eutKc1WQpecRcoGXgA3WYHvXHrPoIxDAFL01Vsty7I52DkFtj6IZm8drUFoSQX7gnrp2GIUl6QeoPpBks7D2+l4+PqrnYfei92t0tXPhCCeLUPdQZuDLnCu0mkPF2538U=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 20:14:41 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 20:14:41 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
CC:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>
Subject: RE: clean up kernel_{read,write} & friends v2
Thread-Topic: clean up kernel_{read,write} & friends v2
Thread-Index: AQHWNSh2MSrbn0aoC0SI51nNBtR5gKi97H8AgAABVEA=
Date:   Thu, 28 May 2020 20:14:41 +0000
Message-ID: <MN2PR12MB448898AB31147F34D4E3B3C1F78E0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200528054043.621510-1-hch@lst.de>
 <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
 <f68b7797aa73452d99508bdaf2801b3d141e7a69.camel@perches.com>
 <20200528193340.GR23230@ZenIV.linux.org.uk>
 <20200528194441.GQ17206@bombadil.infradead.org>
 <20200528200600.GS23230@ZenIV.linux.org.uk>
In-Reply-To: <20200528200600.GS23230@ZenIV.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-28T20:14:38Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ffe611cf-d35f-41ef-a386-00008da5b6e9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-28T20:14:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f528d2ea-61de-44d4-af88-00008f4824a3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2e403b6-4275-4cd6-3888-08d80343c162
x-ms-traffictypediagnostic: MN2PR12MB4392:
x-microsoft-antispam-prvs: <MN2PR12MB439279C75889E359ABC582C4F78E0@MN2PR12MB4392.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JwA07S5oiYlxSlvVyA+4CUoAU77LDeAKItCTHgmSFElDaj/7NMFzFErn3K4L5Pg1UAuYECLw60gSD7vM8JZAaWR2KT5SsZJ/NcSOQKcdMvImb7mlJEXWhzBFQsLgr1Xevud4VOXplrLBhRsC3AIqncly0W0tMol7OX4fIOK6TJT9STNzzZtb87+Dmh8kXkk+c+zS7QbSiFc0JQFCA/3iVVjLGkGt1w8aD0fIpAV1lx2LtNrdgfDGdB/f85goUPCuXROGjHyDYaRoMlWozYN3bLHaAqD+7xPD0DTtWYKPGMLVAtePbcrrb8+pODDeNcQhhZL6IcKzu1z5LrNPDIenHYwMGHPANAenCGZA4HXK4tG/mKmNpSIxqDiUGQcxug3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(8676002)(7416002)(66946007)(52536014)(66446008)(76116006)(66556008)(64756008)(86362001)(2906002)(66476007)(5660300002)(33656002)(4326008)(55016002)(6506007)(53546011)(110136005)(186003)(71200400001)(478600001)(7696005)(83380400001)(8936002)(9686003)(316002)(54906003)(26005)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bd4v7Ya2zG/QJI4UVg2f9Ist3mJRHLcGamHMt9UeoYskA2NXpPif8+KR1DahG42NKMOO6oJNHu+cXsqpQiURUpIZhj3a36ufzsz8avLRprcPOmvf0cvnfqQ1H4d6B8eJ6hmIehLsURoOlHpAWtO6aB0qNg8PI5ohhwAh7T2JJbabvZuSrlvTkjRGRDhdZxUT04dcRxC4acQ0ZZ52ckYmCzqpP5DQ7f4nBdFOoL+1LQC8BetFP8O4Ecggn+pYRVSdVj6GJLR8L3aLkHNSg7dl+75XOPgo6dsvXsQaDbF62FtJMx7fX5cvBUmMWfVpmDQbSTg4kzZNG5a8/mhLhke/ZJTMxwq75E4GEnqDHhmf0gCupz7LVQugF0nsJX5xKoW6c6ybHcuXu5fcTBsWjnuh8EukYDf8pHV/sUIs5qXbxRDsVI0/ONLJWUaB/I4FT36OLgrlatuPEX7QXtcWK9lDugppH7EgTO8it0hoSzphGADYmE6rd6D9J28WArROurMP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e403b6-4275-4cd6-3888-08d80343c162
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 20:14:41.4210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFoQTAqGTwJkw86HrA+xtpKLin6gGtUW2b+OnnN8Qpb+CVcP0rau7JVxuWOFWwOxiEOMS+4UseA8Gl4psizINg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Thursday, May 28, 2020 4:06 PM
> To: Matthew Wilcox <willy@infradead.org>
> Cc: Joe Perches <joe@perches.com>; Linus Torvalds <torvalds@linux-
> foundation.org>; Christoph Hellwig <hch@lst.de>; Ian Kent
> <raven@themaw.net>; David Howells <dhowells@redhat.com>; Linux
> Kernel Mailing List <linux-kernel@vger.kernel.org>; linux-fsdevel <linux-
> fsdevel@vger.kernel.org>; LSM List <linux-security-
> module@vger.kernel.org>; NetFilter <netfilter-devel@vger.kernel.org>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; David Airlie
> <airlied@linux.ie>
> Subject: Re: clean up kernel_{read,write} & friends v2
>=20
> On Thu, May 28, 2020 at 12:44:41PM -0700, Matthew Wilcox wrote:
> > On Thu, May 28, 2020 at 08:33:40PM +0100, Al Viro wrote:
> > > On Thu, May 28, 2020 at 12:22:08PM -0700, Joe Perches wrote:
> > >
> > > > Hard limits at 80 really don't work well, especially with some of
> > > > the 25+ character length identifiers used today.
> > >
> > > IMO any such identifier is a good reason for a warning.
> > >
> > > The litmus test is actually very simple: how unpleasant would it be
> > > to mention the identifiers while discussing the code over the phone?
> >
> > Here's a good example of a function which should be taken out and shot:
> >
> > int
> amdgpu_atombios_get_leakage_vddc_based_on_leakage_params(struct
> > amdgpu_devic e *adev, ...
> >         switch (frev) {
> >         case 2:
> >                 switch (crev) {
> > ...
> >                         if (profile->ucElbVDDC_Num > 0) {
> >                                 for (i =3D 0; i < profile->ucElbVDDC_Nu=
m; i++) {
> >                                         if (vddc_id_buf[i] =3D=3D virtu=
al_voltage_id) {
> >                                                 for (j =3D 0; j < profi=
le->ucLeakageBinNum; j++) {
> >                                                         if (vbios_volta=
ge_id <=3D leakage_bin[j]) {
> >                                                                 *vddc
> > =3D vddc_buf[j * profile->ucElbVDDC_Num + i];
> >
> > I mean, I get it that AMD want to show off just how studly a monitor
> > they support, but good grief ...
>=20
> I must respectfully disagree.  It clearly needs to be hanged, drawn and
> quartered...

You found it necessary to add me to a random thread with no context to comp=
lain about the coding style?  How about sending a patch to clean it up if y=
ou find it that unsavory.

Alex
