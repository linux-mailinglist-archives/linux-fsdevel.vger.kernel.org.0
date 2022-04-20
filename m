Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15478508652
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 12:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244980AbiDTKwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347783AbiDTKwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:52:13 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096071D0FF
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650451768; x=1681987768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
  b=W51G/F6S1m9mDTimilEnOKpQr8bX9tm0BW1DVoZNPQFpyYSOw07jvzLe
   W8uAWGPP6AqYO28x4lf9x17BassBZ2kk6LA3/KzXfQIynhvLKquUutYQp
   XLPwavGgy/R+5D9tZkS8fwJiNjcqWLEnrVcNV3ZEmcLZgY+RnJuhCiB+l
   FSvaJ+XMaDl4RSeT3skIR+7hJ57+adncCiMkqwJJKG1awvvnSP3zKxwMM
   KuAbxGKjzMNJoTC7EpWTPI6DxJhprfgwRh8BL5p4vGz+87sl/LGZGfWGm
   2Gkp8oZbDQJp/R3gCBwN6QQ+ANJSigJzNY1jMUbsLoViEPN+zfC8m5Iie
   g==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="302552745"
Received: from mail-bn1nam07lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 18:49:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6qgNUqtJMaYZpXIj5eO0z+3gp4F1NC/Eh6iJlT92N+vxivxqV/KgAWtsTJObqvBdBdHOtdE2k/75HnN0DYZnEWjGEypmLFFtqEK2c49j+BTP8LDdbk/BzO4RjdPF/RqurPYw+kuEat5UN1gP3V+H2gDWNIumnpLYbbSbs3CQWGoFDL4IxeyvEKowvZDIMqrkEX95H1KVdr9UulFe1cudNHJa69gEeVt74VuLVvKf+ISG8uYd65KErF7aURF0wYOVGPwRY50DqrfsbnE1v71V0+o9KO8FIlisdLuEfaWuo83o9PrNbagDya67R3xX67yYacnL6oaEkN5US1UxL1uJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=WaKSlYn2JOe7H2C9A3DOJxPy1MGeKGFC9c/2GqSC6KSTpWAoyJJhgTqbRHlftI5+SQtsk3z/EVPgVTJ3DVxqkb9QBckmu/v158wWWCmSdQ4gNKUIcz2ZO5/Hxp4XlZ+ITmdtenQ3XMCRtgoH4BsGuY2MSP4u0K3ZvL+kvBUEVs1JmTxswNbiExXRigpECP9wWK9Qf+R9CRK1KCFGU1A0jGBUaxU7zfZlZVWFQNmrayYZKLeB0BUQny7XKvg8qOLUjvQpClaTTKGNI6VRiC5I9Dsm5cbTbgXyeC9FBZMb8Xhe/VEhvyw5QvFNGoIxrx9x1rdBcvk9AHuOBJ/J+K1/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=gC2HQQkpDxVlw1aQa2cVkoFUIE7SEyU3SH1LCyDlrEvEyMYQDiHIZjC7RkAwSU+XtXEoezWPmWmFuYnO/E3M0XbE3YxJRh4ZnBTl6OORqtVbAV5RiF3pnpTYiQRep/PkHbvwK2nCbUYE4jJCog6Pw+RqsETFDCUQh37Ak5p73Tk=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by CH2PR04MB6694.namprd04.prod.outlook.com (2603:10b6:610:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 10:49:25 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2%7]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 10:49:25 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 4/8] zonefs: Always do seq file write open accounting
Thread-Topic: [PATCH v2 4/8] zonefs: Always do seq file write open accounting
Thread-Index: AQHYVGAAEFMtFnz3rUiGLVPPc1Yo/Kz4n9eA
Date:   Wed, 20 Apr 2022 10:49:25 +0000
Message-ID: <20220420104923.GB36533@gsv>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
 <20220420023545.3814998-5-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420023545.3814998-5-damien.lemoal@opensource.wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe6147f5-2612-448f-e5db-08da22bb6fb4
x-ms-traffictypediagnostic: CH2PR04MB6694:EE_
x-microsoft-antispam-prvs: <CH2PR04MB66949C3D82FB501436ABBFB7EBF59@CH2PR04MB6694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNyHYtz/V7hTJ2+jFyqzC8LcGYv8/A1I3lgWLB1zWEb4xXUl/zpOHnYikELh4ZprZs3m6OdoAqbGd8E1FrfdZz1PVRUZmRp948vd3tQMLSq2FK5xSmRjeZSisZci5XXJQlFoPszRd6dZpxw6N9NZxK5N4c9NOXFuFcMPp+B7Zn0PrJLYRI8aaBGA3cdD/iLQmCgTzoQtjMz38c+p6WdR9fKhMD+T/gKxjrBIl0RB75nrGOwz2fIrp+k7XjbmgECnxFMCOgCPJpGGLW0cZFYrEf/eN/QxZhbFseibMRTG/3F2pOmcsS62P3B1mFjtWl0wNF6hcd43MlYIcb0HKTRO+h9j9rqpYuJSew5AdqQO3z3FZBkWUzJhcXjZAggK9mD3B4zZOL1lQRGG9Cx9pAE+IB6pRblsWiJeQp2wUlPb0Eo1nfbOgXnQJTRBANb6jfW/7913/bR9z8vkj2M4toqsWovBI3iraTHDyi/4zR442D23zgM2PeQlVT65WeKqt00IKtgfuH+nQPYYoqxZIslgSg2kjcn2DMkV7Zn5XKemC9gLWDXh0SKSTJ/7nTnkUmQW3iFZVkmCyVKpA2Cs30Cbh4b3XB2OYKqt6QP57ekel4kaE6K+uuhFdocSCqmuJ2qdc+ZwyO50N+FNPmjQuyTOC1UOdctyJX6tumTWYywbYtNuYdWX+nCZwNIWL0nMw0psXV6c58+qSbyJyS3g2et0Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66446008)(64756008)(86362001)(71200400001)(6486002)(66556008)(91956017)(508600001)(4326008)(33716001)(6862004)(76116006)(122000001)(54906003)(6506007)(38100700002)(9686003)(6512007)(38070700005)(316002)(33656002)(1076003)(26005)(4270600006)(8676002)(66946007)(82960400001)(66476007)(8936002)(2906002)(558084003)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DrmQNkkV0TAK4PRayOiCtN/+l1DF2X2+3nWBkx4HZm+nI3grkjH2Yn3YpFca?=
 =?us-ascii?Q?Xu4tXjMXkJpGHUztlni5hjEGyoRjEajuAigRG9NxUnnf+nfXbum7Tc+43+6W?=
 =?us-ascii?Q?WDRSA1MDSQk6DkHgkx6H2H/jOMsLv0LCj/Ej27IuFELNObOdgIeR1vnEs/gB?=
 =?us-ascii?Q?1CNAe+yQ8neDZpAWXzM8dQDftApM6K4SbllfQrF3ikdUxDFx1+7Jzk7LF0iy?=
 =?us-ascii?Q?HQbbz83TDLks9PEaHpLoeXdYD3MEs1WrYHXI6Qsrnc0TKZSOoAWw+79DDfbr?=
 =?us-ascii?Q?fNW+qKWmipTM1W+4XJi+yu9YCB43kihGka9I34snukq0t39fF6DZfo4EWp+u?=
 =?us-ascii?Q?UVKD1nZMQBYmEvzBMXVODn6+8Yk7jOPDxQ129NmnJRnMRIt4qQSyxke1lLTn?=
 =?us-ascii?Q?liYckMs5lOwcRh/pMxMOi/ZwazK63zDAg+4EHd8rRBnL/tuWZunyriIiVEN0?=
 =?us-ascii?Q?piXH1dyqPaWIEJIeaDTrZAdXDjQ34hIiDtRC4EjiW+YTTNXKvOlgUX7Q5F5/?=
 =?us-ascii?Q?eqi1qHVBpMb4JnvW31AWG0GfpdV2muBXgfsto4r0k9mlRdy04FfHU6duAGJ3?=
 =?us-ascii?Q?9m2b4ZeQv6UH2TNhpbfQtvKSSx7ud1Q+yT/TL8CwCMVO2nBq/JmYoF9voMPZ?=
 =?us-ascii?Q?k2AvmbCqg5FWZ8rVhRIdvfM4HcWiSInjXu1FGpM6T6U0nfys0VIFln9doX/x?=
 =?us-ascii?Q?IXSMkuBAfWLED8tvYkXPzkhjWMZGXUCNquh4ZyghChnpTLllGcEtKBirlS09?=
 =?us-ascii?Q?RLwyBn5V9Ifw2+JDaukobCLBMsN6KUeUSTxCNK4Qr69jx2LoDjRRsjor+Mjw?=
 =?us-ascii?Q?YHGR5x+UX3YJ7qqEyL930jdi4Blh4QtpqhaaW0qwpQmAw/+qTTMIjw2Sy2Zk?=
 =?us-ascii?Q?gpgk9/AMvRru5h0n31ervUQ2CodZ2QyjeO2oLVpnBOsINyu9jy6CNk5Hjtvc?=
 =?us-ascii?Q?iFNTo3oQ7jg+TLdjjB1EUSfve42sFcS8XYegr7E7TwnaftB+L1GBCx3ue88X?=
 =?us-ascii?Q?D6VpZsjWctFrVZnCcMzhrWA+AaLFvIMqIVdfO5/Jt0ujl3VQdMWcWF9J2FSF?=
 =?us-ascii?Q?KF89mTukVssknzDEUfdeY2OpEuBL6WsOzdcqDMBhLDc+lUz7WQ5a5LC/HTiT?=
 =?us-ascii?Q?XsMS/opTb/9wXzo4e2BJKLj9D/dOtvTZdzA2vreouF9TPOJEcs5nlIH6CO6F?=
 =?us-ascii?Q?ZgFcgo1Z0uVbo9dWGhSnJSJ+zkWhWbmtT8Vja2D/JUXfKzHI0tg8qt4G+ei9?=
 =?us-ascii?Q?3xYMvSsrLrStDBdREr4dM6rt81WyBtX8v0iZyNXdrPeqmOgRFhUKnluW8mqr?=
 =?us-ascii?Q?WwY3SAGxpMnxGjhoH6R4WolVzg6Roiq+dASpTHO2i89HqfvMRAPzOeYxhMJX?=
 =?us-ascii?Q?Z327qZmcFgtnPJy7N1Igch0b7S04NgXuW+dzMB0OUzOyuCl749aS1NvFrNkp?=
 =?us-ascii?Q?MSYXbg3Au+Io+xI8h4PY4xkRRgFBctp0lfVBDo3PiEHjExt+sEOUGV7QOx7w?=
 =?us-ascii?Q?vfboKujkHny9fej7LzgOqdC5N0obbkqqz0m13ZzQnmyF8z1vApV1jZsJ2MnB?=
 =?us-ascii?Q?7qEFBZCnmVkiOkUpfWi/OXZZxXTR0G8T/K90pHaR3NaLKUASUM/BFFyF07yC?=
 =?us-ascii?Q?aGkzxZ6lv9LEPc//MFrdhU5rauH46ARfBARAHUoX30ADSUV42uJp/MgcB5cQ?=
 =?us-ascii?Q?+5YR50+IDjgEz+dPCk6+zkNLtF27fL1RsDsKwF1PuLu9p1nmzLQyant2Hnlt?=
 =?us-ascii?Q?wXcyuJJzA68xifQw4Zg8HJEeAMXQQ1U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B79B15F1063634B9C05FF756F232F63@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6147f5-2612-448f-e5db-08da22bb6fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 10:49:25.4545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rl6siPLr0cWl2SennN7xZYqa29QKDvs8AJy2fV4uuuWHLdpQ+unxsjbAWZLk/ai8oysWcE+i3ny1/JUQkOxAVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6694
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good to me,
Reviewed-by: Hans Holmberg <hans.holmberg@wdc.com>
