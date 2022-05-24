Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34569532319
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 08:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiEXGZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 02:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEXGZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 02:25:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3B6CABA;
        Mon, 23 May 2022 23:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653373527; x=1684909527;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=b6hFKHwDO/Z37vK6d7OMilMuE7LQeFDGv5yzIxzUrP12bh10jaODP6+e
   Z0yrsNcj5qSHoqaRqKi+W3y0OgK91iMZ+zqmOkYTqet1ftM84NwX+HF5u
   RPoIn1NwpYZFr5WQpfpEB4nf2zH0oaGut4c5kgfNdA5u7G/7X3CzfdGXv
   NRhOHF4YvCzHOGZX1eMoT6QwR5dTk8qYX1MlN0X9gqypZERySXxsEjYXd
   SwmLaqPBtGBVJg9n77Au28qzq75N279HdJz3MDqfGZD8v/oO8O3hCbhMp
   LxSNDuH1uLFpk+VBA3WFWwJedj4VVx+8csu4jdLj38r5niiHLeGsxLBOq
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647273600"; 
   d="scan'208";a="313248454"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2022 14:25:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPx2JDHyYqlyq+2tGrlB37tEwjVXrGuW30LGdtpdnsqx9/dAZV6S6Ny2Ay5jATD38W8j5i/WJJ+6cmF18SSErf0DYCwMr9NwJjy1fzJInxaRtFTEZ+vb+Igq2wjNC9wCQwDqt1bfAYMa3/RKtK0V8GgI7Iz2y2/mM8DujEFRkYm+tvYIp4IN9ENELPP8Jowz4CUdNUnMq4C8fKkjCah2PNtVsU+PHImlkkK4LVgt9m/5u6iYx+p5XY1NcmSlkzLgOiC6sfJ1LPySAJWs8/c09OFtmgs70UmNYGPSyvYkBb3CKjqqcSn1CrFk/j6oNzTK0Z0jOKFT8TmplRaHmGYLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=SeAwCqdXtB8HCRx314VHqJMey80wuuKJg8zx5ARuNTM1gV1GziCoBNT+YUSJLXMYG2QwVBNp6Zd5xU+dTnZEu2wduR14aIklVyTLue54ubiyWc3TE5KnBkN6oWO4oEr3YoTIAXr7qSDZmpBMJwiPTSPXs70GFRuhcFNsK4hbyO1j6AspRr9fSHAPxDbSlQQRPxHhbMDcZvLReoXwHfjMqURD8jCNxGkflxPL1UIF45v0BSIgTUofw5GCaXkFz58KS6mP3Ks6Gmua76bXNnH9koCe5y/0jdIW38+ieWbNFEdI3MPOU8B5tSU8L3wT5HaoRD1qQFpAWb33boULxCSVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=uFr1B356yh+Q3pDHnRGFLhM4teshGe/R7Va6DB6u1MPE5Kezz2Ht3lIfQHkhysbr4lopiKPyRpPp8uqztJBguV9LbX0Daxly7M9fZWKEO4GGGi6iOixPNTP3e9D6wVA5a1PnQ3pEirIZGtx3IvH7VBd7KWsqtEWmKBCT4tQ3MZY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6879.namprd04.prod.outlook.com (2603:10b6:208:1f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 06:25:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 06:25:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 3/6] block: introduce bdev_dma_alignment helper
Thread-Topic: [PATCHv3 3/6] block: introduce bdev_dma_alignment helper
Thread-Index: AQHYbuhZXa1tdw3xEkWne5zi7QrTyw==
Date:   Tue, 24 May 2022 06:25:25 +0000
Message-ID: <PH0PR04MB741636909DCE9214F5AEDB059BD79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-4-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2bf1299-c07a-4223-784b-08da3d4e3052
x-ms-traffictypediagnostic: MN2PR04MB6879:EE_
x-microsoft-antispam-prvs: <MN2PR04MB6879E8593EDF059EC76B832C9BD79@MN2PR04MB6879.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4Wt9eFyykW0fO2+wBvhyxv9bD5PsF2cPQtLG6GOWtordAZduY6qQQU939Fy7Lm+6fBkc7zlLQQKVWJq9o/CLXoLoQnqGEtHfSLNaU+k0ORX8JazMfI6CSGjqiGk1Qpu6TGXL07aGU40ASdMruombAv4a0TR/7fAxPtUzhqtGuu/3//qPoW3yn+/REJakeROV3w0iGZRn4frAk5lS2o1RmE/XTT7+6wxioGFikz8QvGVODSslCsPx9bV2JoT9ceGXb2MAqXA9lpf5tL5nkPtxSz2+KmZPUc3LtGc3Dpzfx3aK9eOKsgoWD8r1TAOrzyP3Lv4lRYNrjXySss6IjfBTnjaFhFxBW+/HsqC0Qt5xyPsx1a0zgHEVsy2bcchBzwac5RpxFUb6nugl0QEw30biu7nQpFPXVGi359XpvvBxJFnqjA0YWXGo5gtCxZbT4wlIgtPbR2m7QT2Xq1RaP6D8DztJxrjyVmeFUshaquNqJKS2nJJbvq8MMoHdzHMyA8L92HDO52wvkAtoYiFPcDeSCKf1IrbzaoCipNZX5XPTFNMtYF9gSmGKFj5gmyDZ03uGJc4rcVBwSuXPxXE/O5sAY0unRA6KibacDOZgAC5cTVfA7AQecD9CrH8/sGSrSBqoCEDDo1WBwlZaBvE+Ex/32M3sfrMJI5iJnVd/BLXjbIPKh3Vbsd1QXzrz18NnyGcLx+zdqVSZg+CoinGi/et7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(82960400001)(33656002)(122000001)(508600001)(38070700005)(26005)(9686003)(7696005)(71200400001)(55016003)(558084003)(38100700002)(86362001)(64756008)(76116006)(91956017)(4270600006)(19618925003)(52536014)(5660300002)(316002)(66556008)(66446008)(110136005)(66476007)(2906002)(8936002)(66946007)(54906003)(186003)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4GMdqx3xbmQ9Vk5NrnARsYvMY5bpMkl7y6JshViabKfhywdDCDWvE1f7Ig0k?=
 =?us-ascii?Q?i8AtAAkBeQtpHZ5oKoFlWKILyZzv52vQ9mRNKVKqgZkhpfQ4KwHcLcuL75pN?=
 =?us-ascii?Q?pL7w6eEHJaf2K2GcrblgRvudK7AilecZVk+m9BYyi9DXqdAIVBUZyFfsasXt?=
 =?us-ascii?Q?7BepZY4yflQ/MSi8Bb0jPBAWUf7ttQPunOZuQYEqidn9s0vExG/mzD7aZcPM?=
 =?us-ascii?Q?bMcco2RWSEcMr7U2Lv1bmYzKoCsrE2eXSCH4wNiCxGHe6asipMj+YbYmXGSD?=
 =?us-ascii?Q?gbHVSd4L3XHf6/NyZ6wO05oGkmvVEbISCTybYDx29evdq1W7WjKTztb7ftFL?=
 =?us-ascii?Q?KnTXRrj1i4Yo13aEmP89UzKnPyBRbYdRGLje+szPdqy3LjLZSpkuJAUCImbY?=
 =?us-ascii?Q?YYZ4L8nYjtBIo8Bi/M0tcmA4aT4UXPor6jWup2btdS9ONMpE0dqPKn6I8PRO?=
 =?us-ascii?Q?MXPCz2mbs4eH4gnEl48vha6L8g0e3/YhwgwT48KVjrxcBSWFSdRDVRYGLvIZ?=
 =?us-ascii?Q?i3LNyepgZ28YXmZQKAfQ3sfaxuBUNnQfKwd1KdS4ikax5eH7hYGoKY0KXVVo?=
 =?us-ascii?Q?9Jc+dFj8DUvQgQYpAIGRvfo69Wgx/uSODgNvsPBoKfOK6n5ezrOCRvUdPwbU?=
 =?us-ascii?Q?VNkmc7Dk1WYKQrJ0Cv/PU5Kl6PU3DsOKFB/AHmlwdA4B/WrAkZc5q4auGHzA?=
 =?us-ascii?Q?MIIiZe200Y9hdPdhjLleErq2gjq0yGrRNGR+ik7k0mF5WGNmss9+X1wdcmah?=
 =?us-ascii?Q?uPKmkb4jpdHvQ+yyUYAUwaVvozHPWlNPpX05Y5uj60IP1faTtEQhRZH21dcI?=
 =?us-ascii?Q?F48jMFx/Vt0jjbAO57S5kTWQrEFy9dGjCeLmxPWGmxRoqYUIEOU1loJGdDmv?=
 =?us-ascii?Q?Kj7qHiQXHgxyyvEMLcZRWtLhAykCJgvkAPiAt2fhMuNwoO70yAn5ekDppW/o?=
 =?us-ascii?Q?XZe40EC8bZretdapIYTsAKyZLFpPOHwYm1EVloe90ABD50H3jHkr6s4bGWjg?=
 =?us-ascii?Q?PMMTGbLP8x0/VjQ7lRCynjND8ErNx3ye6wCm4c8jZobfFr1u1zyckWk/oPC4?=
 =?us-ascii?Q?UJi/80RBhWwJqDT+thpQhpjRTlkE4YzltSewaEt9Y2Kkl+vVQsstPD+QgerY?=
 =?us-ascii?Q?4bTvGmMpPUhbjS+ZqpuuSzoJU+yXofU7wtqczDXjKigg/wZBbeR+PXpldIK+?=
 =?us-ascii?Q?NPW2O8piJl/OOqYzAJEULvIcETHMrttCUF0iSE9crBcPotigIsxPrqIUr3gv?=
 =?us-ascii?Q?BTFCqapKzKbfupVHWYgiT1zsJFu0A80sqr2Q599tf2Zm5d8e3kAILMSTmLsI?=
 =?us-ascii?Q?tTZXFzp1y7wx6Loh4BkXmqqhRC+sy5zCyx8i533aQ64qcZmdrLTMwPp4yHKv?=
 =?us-ascii?Q?E9S/e7ruFU/N/yXMbFstUxH55C1W/os5PMR3xB+lpNFSAi2wixYe1w/SJSJ/?=
 =?us-ascii?Q?yMJNiry1QhJVK5B2oIUQTCSHOcAskiriagDilnDcNj7T10bZKFzJ7fW8r31E?=
 =?us-ascii?Q?YqZcLrQlw2DpWkreYNA/hbkwMmYPFsQOivAZx5ZtbiXs8+F9h6OqBEkE+d1b?=
 =?us-ascii?Q?VqvA4nWoDj58MUGo2z5HTibjQ4up9ntRGBU1lJr1C0Q74KbZG/lZpudXhe7i?=
 =?us-ascii?Q?aLvftLN0H2zmF4cjakezTjfaLj9jhygxfhQa/O3tHi604QNUsFQpTlcIHZbk?=
 =?us-ascii?Q?KLXNlOLcgIvnojCu23vj9WEoEfd8f/g9qD1rwoydBA8v6fULSPPrOJopjRCi?=
 =?us-ascii?Q?zazOSMhTV5DlsUpy5zhfXkZAmDFH/Epf32rk1pim0YzgVc2Tm9Et?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bf1299-c07a-4223-784b-08da3d4e3052
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 06:25:25.3488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8zvZwMGYgiqlwlxmzKAFg2ha2MAGOq8p+9K046GwBjbcI/vmBFIshplcusnK31iwoIEFg6LdzmlkJf6NV0DIq7a7jokbderMoeC3ngIZ6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6879
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
