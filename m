Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451C24EF778
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348886AbiDAP5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355788AbiDAPhf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:37:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAF7C4E02;
        Fri,  1 Apr 2022 08:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8IUik3Y6HpH/9VVkOC9qquB5xv+FI42V+aj244iTsSWTDdfiocdGZ+OolB6cqnO9fMgXxAPrafQkjq/Of7csmMVES9xg9Zn//yqgD5Vl8jY30uF8nq11ykdHqDGk6c1+hsJtviwB4T4PPO/UBEWJngj8a2CVNWY1PHPDDYImJJW3EZaGrWHLTxFpogvGKrX56Jmz7Wovdyldc6QMobUyqxMcvl3yJf1wNRBbtH7nrjA7g06Ki5YDAmyge/D+3K+c5ZeYqz/2ZBMrOSrW876Q3i7lXSSgo3clpdfo/NhkC0fgTs6ApHtVuazZbMG0hDtNJj5ilIYzGwdVYP40rKpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyWTouHuKU8FjzWHC/Yr71qLXEtZVnBd4O0ETgIm3yU=;
 b=Eti7t1PHN6xT1lB9zfvPFutEAK8/Xibjv89YBQFa8sDT8WI652m+O6F5bXnO/IUHR8wdz4Er0+nDFIYSWjW2uNqmaRdmsYW3zNPZ78wrXEI5TGVoqEfMVX3sbTabTSINsOTQ4R9j3dLN+Zw6SS4EwLSNLrkoKc7+hDjFIf1PDfitZfR5vP24Nx8e4QfBEeY7lV7h3kaQLx4Egm2bgqhzWfQsqg+eN01LZiCvC3W/RldsgXeYfZexiHvweQvWizleZLgdtOHUyDodKlO6Na2auPpwVInt+5NkzJSTJ7QpyRKQUEzKTuw5c3oBfBNC1ZfMC2OrjCazK4KFpiDg/7xa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyWTouHuKU8FjzWHC/Yr71qLXEtZVnBd4O0ETgIm3yU=;
 b=WcNvSZBFwzJC93NueSr1bmiqfEhpjek9bL44n/l+pr4aFPMHxn543FDfrgU2sbJU8BcsW9me9W5rALKUj4g6RvxgKGZBfx6HFYqSbFWfWTzB8af6qbrQ9Ge3B5jOyPBJbC7H5JYovwQjksivBx0S1NB/UFzigjqu2oG/zWZ9rHc=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB3628.namprd12.prod.outlook.com (2603:10b6:5:3d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.20; Fri, 1 Apr
 2022 15:11:09 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 15:11:09 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: mmotm 2022-03-30-13-01 uploaded (drivers/platform/x86/amd-pmc.o)
Thread-Topic: mmotm 2022-03-30-13-01 uploaded (drivers/platform/x86/amd-pmc.o)
Thread-Index: AQHYRRci2G4P62RIIk+9YLuFsTlihKzZwlrwgAFl7ACAAAKGQA==
Date:   Fri, 1 Apr 2022 15:11:09 +0000
Message-ID: <BL1PR12MB51572E24FCFBEB66A318C2CCE2E09@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220330200158.2F031C340EC@smtp.kernel.org>
 <5a0b94c3-406e-463e-d93e-d1dc2a260b47@infradead.org>
 <BL1PR12MB5157D16702C349C2620AEE97E2E19@BL1PR12MB5157.namprd12.prod.outlook.com>
 <cf286eb6-aafc-49fb-f900-d3ef6fbcd48c@redhat.com>
In-Reply-To: <cf286eb6-aafc-49fb-f900-d3ef6fbcd48c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-01T15:09:34Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9aed4ec7-9762-4ce8-99b6-1c22900da183;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-01T15:11:07Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0de9d4f4-7cc2-4423-86fe-d97bad2c5215
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ee0bd3f-be7e-4e75-b4bd-08da13f1da40
x-ms-traffictypediagnostic: DM6PR12MB3628:EE_
x-microsoft-antispam-prvs: <DM6PR12MB362807B859CAB82D9CDBBF4DE2E09@DM6PR12MB3628.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eF8W/235WMuTmIU5NT9p2UnDsFp411ZGYUzXTKuK6aJyFxIC3P2tzejbLpJzFwaBv1akavtrl3TYUhpKJMHc45c459TT1obvDJf7YVBvsktfw87FvAP/PguYaH0tehBwvSbgG9QsI9cetL8z/jhO8vNx1yAzbCJpCyMbfTx0eAIb4hfgAArgx1Ob3B0pFrGUt58x9l6Qv0IOUKPdLiVW0fo4ONoAZokWNp712jAHSYOza5qKOzTPZCG+Um3f7P37jDCrV7xOc/2xGbArTgBz8kY4I/AgyxRfi+mLmz+PKOCyKuJ4bY/OBevPD6sx+kl5RNypX1OwqK8p1RjLutqfDFABdzwE8ad6CZUcjpUC2u7NmQvFLwqVPF7Z5o/yDeHB+T/xPgu/TwwNB4sH5D3IrdhMp3heZn+xvOBQDqSLA+hCS1pay2doBPZpQoqOnwv24EBeHqUlymrcfLg7GJrjiJHs7u1rplNnflmkQgvOVL3eAz6SEGhQDZjAn+xoyKlG0N3NyxIK6sxlQJDhSDjiccddGFeAQnxVyLD7UU/nryrW+/DtI+MsM2y+4ULYiwI+uz5Y0FROFVflz4LVT5/c/baK+O6zhgus6TRo21iqxGK9MiSPFfgwCntIUgCv2XYCYBZ/kcyhU0prkT5+suC97U10gqYrMUNXqPLVbwWMYjHv2AWH8UjOGhJOHM/Hg6el01XVGQQ15syH2z5+CY7UluCNE2Nyv4CjnkSmnfgb+oRtarQkPMsp10ouBO3kavqwsvYWDB5M/y9vtPwfSqo3eSpZOT8GEx5Pbgc6nVNONep1et9KSceA1HGoagCJ06Y+qbq3/AZu6bfMiZJSmhi8cW+0VqFA3urPHHwo1ohqv+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(2906002)(5660300002)(7416002)(7696005)(52536014)(6506007)(966005)(53546011)(186003)(45080400002)(71200400001)(508600001)(8936002)(33656002)(55016003)(66476007)(110136005)(38100700002)(66556008)(86362001)(64756008)(66446008)(122000001)(76116006)(66946007)(316002)(921005)(8676002)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tTKw0Po70uonlKNuRhZ8AgwSnDt3u9sZQqowbUp5DuNUoc5V4oMRMPNQpoOB?=
 =?us-ascii?Q?udZO315aXNkPUdZRrN2IiAZr7sGQ6/NUzbA3S2MS0PBQwNmWc7QV+hFmWwoi?=
 =?us-ascii?Q?GQSGa3StuHhiJwTWiyqG59EQoOeIdeFyUlu5oP+v3AnjXbI4GdhCGhdej0CX?=
 =?us-ascii?Q?MBwyuAPi0+0JvD+iHUceGS0ovBrPOIHS6JEvUzFXDGSGcCWcERbePkI4ZLOD?=
 =?us-ascii?Q?yQthQR8bv1vqSc8ZBTpVTdU1Q5NiZm4Vv0LwPMAEmlorkU6oQ5Z3WsZ9xMOh?=
 =?us-ascii?Q?Jcq+PpnKQGAeDc6rSAZpyCpQgp4giVESoDogWBrKadFt7CJj3hu91pPXK5U6?=
 =?us-ascii?Q?y/D3FrqFuEmCU4HL5TE3jgYrOfs1qXddZ0vQLq+ZVVeOEkpknXq43vkUT4gd?=
 =?us-ascii?Q?G11OGeo5XbpeAq4lpXg9VTwe5NqZPv04OKQRT/EsGCtswscpWqgw7rRcuSRx?=
 =?us-ascii?Q?mAirFJUApie/tBwP185pi9tvQtUBeEAL6lbjs230DnkIgLKJI+18DSXfVdjC?=
 =?us-ascii?Q?fLQv7+yAHoaGdt77u962CSh3ws1XEdFJWiEKIT/wc4sY1ebu760Gq94Gddu2?=
 =?us-ascii?Q?L2pExgOYk/ehLu34NDvHuqX/8zYJ4D8F0JdZhKxaPPHpxeMIohVUpva3MROg?=
 =?us-ascii?Q?kzMeUoloX2jkAbMH2sH0PA2+/uieG26I5R0aJHErb+h59p5KEiBQaLbohmeQ?=
 =?us-ascii?Q?aREROaPKA3b5p83l3O96VknByUMu/DRbN22JgKCE763JXiNawt7Nnr9S/rmb?=
 =?us-ascii?Q?Jh5D+k0fKz3Ea4k7Llnq4zPHGC9xfk/Z4o/AnQcos8O6AwV1ZGibOvirCnnK?=
 =?us-ascii?Q?n/uHoJQLta83omDGa7on8l7vXkEZZA8RkWbpo2fCmqbudyrM/YABvUOuW8fE?=
 =?us-ascii?Q?Xx6zuKQ67ERSJrfnou3fakCHWdUB0yhqAuwzHMtTcIFpLF6WB6npzgc8MaGT?=
 =?us-ascii?Q?6t46zSiKQXa1k11HPPsYRean3lqNpCSOuqiIVxb4mAYTkfAWKA8saKzepjKb?=
 =?us-ascii?Q?leKFG9l+6rZAw5/mcKGRcsxTLSP5pvwDCKfm3txnsZSgA7xGN85QoDU2LPhX?=
 =?us-ascii?Q?EbSaAVrfIY8yp1iWaWEi50BXPhgrtaoRyz8SOiRLWh555Oy7UWpjkddaXbDX?=
 =?us-ascii?Q?+ck8PkmBfGKZsxI4BFZnZ/OVx0C0Nxe54bL12lpUiUFynBB7/H1WvZ9J75F2?=
 =?us-ascii?Q?P1HCC6hMpMtZRZLjs1tKzWrddU2ULaW+DWVB1ZsUS0JVHo1xKL6aNVriOTbe?=
 =?us-ascii?Q?i4X/Q9+K0Bt2nHh+vZeVxIeVRMxnCsTI59JFG/Vn4vpD/kB6ZVVQmsjOvjY5?=
 =?us-ascii?Q?wuajNBmc3Agv/9XS6XviYjEGbpAOaGaB1lReRZ3CUiIF2fR/3oz+WxEmsmW8?=
 =?us-ascii?Q?PtlPnAjTtDwgbnoUqIoedVG5Bxc9d/X7hyOwXBv4wGaug3H4jlccgr4GvLGV?=
 =?us-ascii?Q?5a8EXOqxhfWy7OMjotlCIAjln/HkDwAMhDifaH49GtQsxTXclkX1Oc6txiAB?=
 =?us-ascii?Q?TZ/IK8DMGiEFNH4U7vGTKJrzDIyCDpdiw1TtsQM77/7JI3lfL3EPOTYyEOLq?=
 =?us-ascii?Q?FYZp0hqDEooNb/apblJCQ0cNTH1FrSc20gWXQ+hSLaRS0tfhcBGrEgHGFHas?=
 =?us-ascii?Q?nrYkHFXtbeujAXhBnkj3VPK8CQdAKBjaj5tppvUHKiCITd3daVERN1mvtird?=
 =?us-ascii?Q?TJTRikUXIn7T9GRYfzoTSwTKWX2FX5acCCV+XXBEG9UdTpJAAgSC9nXqor3y?=
 =?us-ascii?Q?okzW7XG39w7/PVrEaY419pUNExxg6VhvAq9EM4eIksovkjw/Qd7h4Dbnu0Ap?=
x-ms-exchange-antispam-messagedata-1: WDnDSY42JT1idA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee0bd3f-be7e-4e75-b4bd-08da13f1da40
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 15:11:09.5285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Xy3wD7aB5bSHBOFc4K+jEUwbBxCTJo+afJ2q41loy9c6CI7IdF98Ykq6sqes+HJrcy51tUmnYZMa7tkBfXtIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3628
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Friday, April 1, 2022 10:01
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Randy Dunlap
> <rdunlap@infradead.org>; Andrew Morton <akpm@linux-foundation.org>;
> broonie@kernel.org; mhocko@suse.cz; sfr@canb.auug.org.au; linux-
> next@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org; mm-commits@vger.kernel.org; platform-
> driver-x86@vger.kernel.org
> Subject: Re: mmotm 2022-03-30-13-01 uploaded (drivers/platform/x86/amd-
> pmc.o)
>=20
> Hi Mario,
>=20
> On 3/31/22 20:41, Limonciello, Mario wrote:
> > [AMD Official Use Only]
> >
> >> -----Original Message-----
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >> Sent: Thursday, March 31, 2022 10:51
> >> To: Andrew Morton <akpm@linux-foundation.org>; broonie@kernel.org;
> >> mhocko@suse.cz; sfr@canb.auug.org.au; linux-next@vger.kernel.org;
> linux-
> >> fsdevel@vger.kernel.org; linux-mm@kvack.org; linux-
> >> kernel@vger.kernel.org; mm-commits@vger.kernel.org; platform-driver-
> >> x86@vger.kernel.org; Limonciello, Mario <Mario.Limonciello@amd.com>
> >> Subject: Re: mmotm 2022-03-30-13-01 uploaded
> (drivers/platform/x86/amd-
> >> pmc.o)
> >>
> >>
> >>
> >> On 3/30/22 13:01, Andrew Morton wrote:
> >>> The mm-of-the-moment snapshot 2022-03-30-13-01 has been uploaded
> to
> >>>
> >>>
> >>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> >>
> w.ozlabs.org%2F~akpm%2Fmmotm%2F&amp;data=3D04%7C01%7Cmario.limo
> >>
> nciello%40amd.com%7Caa3aae02b7b6437c46ea08da132e4222%7C3dd8961fe
> >>
> 4884e608e11a82d994e183d%7C0%7C0%7C637843386674652995%7CUnknown
> >>
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> >>
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DWpfXOyTRBgvqCj3iZ%2BJjXVTb
> >> V%2FUWDP4ds5XtDfa5bPc%3D&amp;reserved=3D0
> >>>
> >>> mmotm-readme.txt says
> >>>
> >>> README for mm-of-the-moment:
> >>>
> >>>
> >>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> >>
> w.ozlabs.org%2F~akpm%2Fmmotm%2F&amp;data=3D04%7C01%7Cmario.limo
> >>
> nciello%40amd.com%7Caa3aae02b7b6437c46ea08da132e4222%7C3dd8961fe
> >>
> 4884e608e11a82d994e183d%7C0%7C0%7C637843386674652995%7CUnknown
> >>
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> >>
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DWpfXOyTRBgvqCj3iZ%2BJjXVTb
> >> V%2FUWDP4ds5XtDfa5bPc%3D&amp;reserved=3D0
> >>>
> >>> This is a snapshot of my -mm patch queue.  Uploaded at random
> hopefully
> >>> more than once a week.
> >>>
> >>> You will need quilt to apply these patches to the latest Linus releas=
e (5.x
> >>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicat=
ed in
> >>>
> >>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fozla
> >>
> bs.org%2F~akpm%2Fmmotm%2Fseries&amp;data=3D04%7C01%7Cmario.limon
> >>
> ciello%40amd.com%7Caa3aae02b7b6437c46ea08da132e4222%7C3dd8961fe4
> >>
> 884e608e11a82d994e183d%7C0%7C0%7C637843386674652995%7CUnknown
> >>
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> >>
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DadnYHchdMvieQ0lCqQ1er1jhHA
> >> UMomgFpaWBo%2BMnINk%3D&amp;reserved=3D0
> >>>
> >>
> >> on x86_64:
> >> when CONFIG_SUSPEND is not set:
> >>
> >> drivers/platform/x86/amd-pmc.o: in function `amd_pmc_remove':
> >> amd-pmc.c:(.text+0x11d): undefined reference to
> >> `acpi_unregister_lps0_dev'
> >> ld: drivers/platform/x86/amd-pmc.o: in function `amd_pmc_probe':
> >> amd-pmc.c:(.text+0x20be): undefined reference to
> `acpi_register_lps0_dev'
> >>
> >>
> >>
> >> --
> >> ~Randy
> >
> > AFAICT you're missing 20e1d6402a71dba7ad2b81f332a3c14c7d3b939b.
>=20
> That is unlikely since the whole series got merged through
> the pdx86/for-next branch, so either some other tree
> has the whole series or none of it.
>=20
> Also note that Randy wrote:
>=20
> "when CONFIG_SUSPEND is not set"
>=20
> The problem is that all of drivers/acpi/x86/s2idle.c is
> wrapped by #ifdef CONFIG_SUSPEND ... #endif
>=20

Ah thanks.

> Since AFAIK the whole amd-pmc driver's whole purpose
> is to allow s2idle to work properly. I think this can
> be fixed by simply doing:
>=20
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -198,7 +198,7 @@ config ACER_WMI
>=20
>  config AMD_PMC
>  	tristate "AMD SoC PMC driver"
> -	depends on ACPI && PCI && RTC_CLASS
> +	depends on ACPI && SUSPEND && PCI && RTC_CLASS
>  	help
>  	  The driver provides support for AMD Power Management
> Controller
>  	  primarily responsible for S2Idle transactions that are driven from
>=20
>=20
> If you agree, please submit a patch with this change and I'll queue it
> up in my fixes branch.
>=20
> Regards,
>=20
> Hans

That's the primary reason, but you can technically also fetch an STB and
read idle mask from debugfs even without debugfs set.  I will weigh out
both options and send something to fix this then.
