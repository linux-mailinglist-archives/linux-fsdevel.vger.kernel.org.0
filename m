Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BBA539EF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244767AbiFAIF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiFAIFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:05:55 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC6D45AD5;
        Wed,  1 Jun 2022 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654070754; x=1685606754;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=WCb4qOoPzfxUj+S5Zfogb+oi2RoZ/yxdLdtXh8T9aOlLlEy5Z3b89qKY
   Dh//49aFKHtcpHCEmEqr4OEEAW9WGBW3cBXyG5FJdYRVONpp8wB8ttiIJ
   V6UfYC1mgCA/EjRhB22bwseafIUXaKhmeoHqrnwEDxUxHfeg1LTZtcK6q
   xBCFypox5C5fuS09vBIco4QGE3Xm0IZElPEffZcyu2lNtdpNlvv/zfdHH
   2krxn78J2nZRMLMQt0PCFk1j/9JtVRaTocYFnzNU/aWNR6gNFmXVwePIW
   K898SqndkbQW/d3q+3oHxTkD9nxX98Fy3mEvdpilBWMDyHcIzdY30IKf3
   w==;
X-IronPort-AV: E=Sophos;i="5.91,266,1647273600"; 
   d="scan'208";a="200724119"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 16:05:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRH4MSLRKsmhbwRp8XIFsrbzKmL8A1trcI50Sj5TXv+hdS3tojPKQwbI4BB0T5lRkjpnvN9hI/Z3o5QT3WzIIYVJ7krqSIBLf5O5cod/AAQLM3xV8KvbJ8FU22lIH5HQHZN3nf2ifRslTRN6tvR5eRTyKYDUJmm9RyRqvc0dXEkMd6DNc9CLHlAkLNc2St07GdGlKigPU+wdh2Zc/EISoYVUEm0aXiTtVXnMi96Nno1jYYlNyPPAPWyDIiiwTTv51lmxNInGwf+lXATMtnioQ6+GUHr/emw4TKLDjYl8J77zHvI1Xjk3UUcCb9+euTRlSR1Du3qeGa56u+fwhdKB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cOc9SGfkZjU5Jkbv2rRovxmxRDIzGtwtENDFc2IhYvNIv65QMvO4b2Kw4eq2jOVSgrp6d3+lAx/Esq5I79FK6VhHwhN6QU0Lr3+nsVwvu8lT3oNuu68vO5rT9amdStFnbu9LJIGwrB4zLtuLo+W6OF0P9PKWVDzUum7BhGmosAlKEhaKM5qRA5eMcIiOX2tsIPEv4xfwBFti+3r/HoKtfwzJuPXPCUSpJ0G7GNZ22A65llA3+c5sqvHA6hp+eHuqF0unL1Y6TjrBzuwCm1FcOMEqVnA4YfxVbd5k7OE4mZsPVDqhA66XXFUd5cD/jk6fVGtWS8MIVT0K39xn3KKJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=pRFWdMHfBeU83ha2X1FWPNNd6IJX65C2AA75rNUeJUYKfdVOOXMV2Go+qxk0gmnimj0Ktvyc4fhKtp2Ypnl5ea0+SgJdA0bkV62dqQfPnoomZ/UEAM3Q+6kMQyi0I8z0z/j1bm20hqaEWgRqGShJiY/JTNE3XYZJ7SaucwTvvkg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6401.namprd04.prod.outlook.com (2603:10b6:408:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 08:05:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 08:05:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 06/11] block/merge: count bytes instead of sectors
Thread-Topic: [PATCHv5 06/11] block/merge: count bytes instead of sectors
Thread-Index: AQHYdSMFKIN6PINn8km8LPRBi6rBeg==
Date:   Wed, 1 Jun 2022 08:05:51 +0000
Message-ID: <PH0PR04MB7416EA3396C483690497BA129BDF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <20220531191137.2291467-7-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7836d3c7-61b6-4185-37c8-08da43a58b48
x-ms-traffictypediagnostic: BN8PR04MB6401:EE_
x-microsoft-antispam-prvs: <BN8PR04MB6401575F1A04671F86E74F389BDF9@BN8PR04MB6401.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bkfUeSTA6wyCFo7nmrx5jwk6VByh+p0EgeVuE+o1zggKQmTqCM7BW/woOq9YirvqjRr/GMgR7C2AYcWRhHJmbeH/Z2L0ib8wsyztiqqp/sw46/c73DUSjNRgosGXFthHsmBqE+bL3vlj39tI0f35nYUZK5LYmJ20NXxJQOl+mj9O9E1EmqAO/B8rI7xUAz5hmDgwEbiNdX8EpCiTRbaGOpuCWiuUnwHxUzS5PBKtFIaR2Tkllxp3GpYliRGy1Q0lxMX/waoHQ4EC3eQTXWa1vK3e3Xggq39GSbkmglFP+MtahO+tq7aehdWcnYXsi6oh4XIEeiE6Qxt+UA0abgpUgTgvxYyg+Zj/gSVJiFdPYDh9EY4ZiWR8BaPpeCTlwCc41/6It8hSGIvCg4UElcL57U+6KkhOOKgIFkAbhnM+WgYLVQxIF3q/HWWl+b1JlXMAutgUsZEBQ3gaIxIVVew74CKS7odZeqTYLTsO1RUCT87owaSJpjYAJb9U1oqihiSUIBwtOfUBsoN+mG5g8WE5wr4JAT9ADhE2yOgciqaVJxZPmJFa3v1FaF1b7SbDG6zYpnHPs4oPyLmeL49I8H5uzW0C67BdGPQOTWCDj7NmRD4kZ8LlVevHV9tAJKHPbOQyV4Df8Uf/tbpERqNa++T+V+i5gImomzfGnLp8pinSVpCDzP9epbB+5lpU1gte8v84Ho2H2rZuTajYkm8p3rQ29Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(52536014)(508600001)(7416002)(86362001)(6506007)(8936002)(558084003)(55016003)(186003)(9686003)(4270600006)(2906002)(7696005)(66476007)(66556008)(64756008)(4326008)(76116006)(66946007)(66446008)(8676002)(33656002)(38100700002)(82960400001)(122000001)(19618925003)(91956017)(71200400001)(316002)(38070700005)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KKGNdyYNbnn5FY97i0kq1cVnDWQQp9P/SEfRgtcksWs/p7i3sL7wfZzWU9Tt?=
 =?us-ascii?Q?0HFJK/lcBfTv5xGmuoRubK/VFqtnU/ZOZ8gbuGKbJHuviDrqCO+nhEGLpI85?=
 =?us-ascii?Q?M+Dqor+mypiV747evYsNaJhSQT9xrqKKCAVljVIC8tfcaLai2t1s9hf5SZw3?=
 =?us-ascii?Q?NW0+qaKGMJHNxG81SQ8+ShYzaYumGS31ou3YRyi0pROjVObfir3yC8sDCA79?=
 =?us-ascii?Q?6SggVpLBpuHoXf/kqN7mIvu7/bCZLEmcWzk7vVVTidU9exOZMFURYyBu/Ecl?=
 =?us-ascii?Q?01hDPuNMzzVl+8XJTgIHW1PDpJFLa+W1cPrC9dcNDhKs5tB1ahEVyhRspMRH?=
 =?us-ascii?Q?1BwQ/BzycLYZsLcI2LZv/7b4i2vz3PW7WBA2LQ4CiQzKXNhkkolHJO68CIDd?=
 =?us-ascii?Q?nbCHiJAfnjkVQLXqAGP8YYYn55Bukquy/QZHdxTUrfVXytfinDiAsuGU3+Aq?=
 =?us-ascii?Q?fRsipTXS01Qvs24wsEupkBWUL90lTLYd9gZjeC/PwWO1nY4+e4x3pWi8i6vO?=
 =?us-ascii?Q?tKGl+eLrMmOrMkL4GE1LPbvUgZN6yp08wLoFnhazcglB7m9xUfOKPPmagBJg?=
 =?us-ascii?Q?pjLLSoTBg/t/mPhbQ8Z4c25O8168yvQpCEXenx2u5npPTEJLqFz/fWfa5ZQe?=
 =?us-ascii?Q?cfUEH+WG4LnZBEE6tGvCPlpJcaWgGWPauPjD5GMB3EsUngZXzBQO4ZWQMq/f?=
 =?us-ascii?Q?8j4hTfZCdCmiBO02gCKFp96rF8Idi43GTXGMMvKzq4L5IXY13Zh8E+O98hRm?=
 =?us-ascii?Q?oXrWiMH05qZOdn9udo8vUDvJKm1V3ASgd4eprxBsaazQ/74jiXPwQuUv1Qc9?=
 =?us-ascii?Q?tbMyT87wTiGLhvpeZjAcx4CsoxPXbCMJ6BsXMCe0cScFlOiEj95yP4k6r+r7?=
 =?us-ascii?Q?NiY7OLXngRoeMRY8maSTv1IkfCLDG5Lp43S33yUepTHANiAT86E6MehJTKOV?=
 =?us-ascii?Q?YpqRCkFDNPQUwtnAZwc3q8PCZI0wesNMFAH6FcuyEaF7yrDn2i8YSf4DDiXk?=
 =?us-ascii?Q?BVYoeYfNjcUHecjkqQivcGTMd/3c0mQsGmvApIsKGcrp7vn7n3got1N2n+Mu?=
 =?us-ascii?Q?OjOMKI9YrZ/r4MnhjXYqQyDYhHoVxNP1vlT3Dg9+7dKtc+qN+rODDekvrzan?=
 =?us-ascii?Q?luuo4ct/JYqHyKBt1GAK4R7dEJjdI5B0lMBIsAl09cbps9rQBKyIC82s2STg?=
 =?us-ascii?Q?dvc4Q30d1msIYAVOXx1txaxELvoLUYTQU8m//nZl29gvh9NvvdcJ8SR+UQDD?=
 =?us-ascii?Q?N3nb2DRm9nL9FXW2C6/FynAkaWNv5sCmfay029xz1rLFxu96FFcjEJO0fZkp?=
 =?us-ascii?Q?R5IaThSemShTzRRDFbDMufBmJ622geu4xvd3waa99SGztsRNNC3Otjxr8Kr2?=
 =?us-ascii?Q?J0wDZbFvciryfztOl3QFsbvBfJMeWj95QZ3oYLYwp8XdXI1M3vUxsYN7iVGv?=
 =?us-ascii?Q?BuD/lXLQbjahieY6gbPN4QbWW3FejklXXU6z8J53DlbhXVeVtWLUCfR6T0eD?=
 =?us-ascii?Q?XPD5cgEPtCImwur6IMYoqT8ljb3rAltuSOXIK2beCQYo3Mizm8jIq3L5b8KG?=
 =?us-ascii?Q?l72To2DLAAMEUCBdRa65gsm7ratuJdnvzsNkphVLuFqA6N/NcqzPv8S/rnp8?=
 =?us-ascii?Q?7I+NREQqCpvGeziubuKEPhHTGf1wNT+l7uZLfe70e5P1ljf82ocUMi/iPUrN?=
 =?us-ascii?Q?JVVlR8gv2W9BBsXiqS5X22EweP0pGiX2whcYzNYQSKekLjevxN0hQ1/R5EGq?=
 =?us-ascii?Q?Jq4vbigbg4Xg1NIDKg63PuamXu1148OTYC02Ypik9TO3nQX4+hQUrb30ctmy?=
x-ms-exchange-antispam-messagedata-1: guj4byq4mxYa8a0E4Mh8+1QsvVJ5xtU1VLofg89z7YZLQ+GW0zksVV6f
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7836d3c7-61b6-4185-37c8-08da43a58b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 08:05:51.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: viDJtugEhYlkmagU082zAEIWzXPPM9MAHCzoIUxruQZ+gIoja1H6rk7yUnMJRkzaWge0qqqK1V5NVfBdsffFc9AMnjNn+AMM1EVPzhu+ubg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6401
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
