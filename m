Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF55067B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350350AbiDSJcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350373AbiDSJcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:32:12 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E5A2BB08
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650360568; x=1681896568;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Dpsg4hIYFyQHQJnW/YLdyhRV/sbWREhRGJwLzS3LMkjALmLN/eET6ZpQ
   5+SVBNtt4XUHqR/BdfS16NUEPLf3amhbQOO3NKQ3fi3cM5hXeSeqtB9Su
   pZlBeukOZ5KsZJ8nqs3gBpUeLSu5MBHe8hGxpLZbCZUF7OhXHIdYktwzi
   EsDZ8GLpItttePztQIeX9A/jsBUJ5tN6uHZ5XPF9wGNdV38GiDxtq3H0D
   Via+kf/sl6YkTsoZgMCibVVf+gAFhvCUstzk43tejLZqDmSP/kBw2YMdb
   wwkJ19jdybeyfEMpV67lSI+GTWp6yJMZ0tBLLW5qQCz4/57wZZxh1Rxmp
   g==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="310220060"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 17:29:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=necCu6hiQQvGTJ2x4oy0+xAk0jiG4/6yJGdrQFHoLCGzjD+gx3IfFb4XvLv3u2z6cHa52qn8TfkTpz9SEFb++YaGzGe0BmnATIrRltILwfdij47v0Jr5PCX1ZhGidBN3tTFzgtB2p9Z07osHygB7VtWhMsMG5MaJ/xrlIrZips939okK84mQDuZKKQPep+C4OdxrMoW+zs8RI6c0/g4HkW+h6dyuxG47e1z7CYW5f/imqYWDlur0lNPQKYVfSIAfKetzQEUBGhrH+ppEvcvG4sWC9v2/iPKq3n/OYCW9vvc2zUL236MrUH+rZUh2QMB7hRsfnZRagv+Q8McRQkVArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TbqNDctV2cbJp3YErUOd/XtSNrWJ9EdCMDCEzPWcujkBrxBFtVCYazYJcnOdCy8DsW6ZDQWzX8I+F7tuI7s/yjFtpx5xzrRfqnEsJFi7+e+IRsOwiFNlZUfx26XiRE0X0gpvLz4SLGOZDAhiSwRVJYNbvDkTySnG7oY5heU0TVC2AMyP6WkVqxq99BRDMVSESMLPzAUea1QfuFcwDU/T7q/rVklWKdZD78lupfAEiZmX9cHIU0hNFl8n2THuNg2fVWI1B3DPV4nNF2g4US/Ko0DU6TEnQMPCFelhYWvpWUg2OeTScsYt/wA0Cpnt2jC4AMiowwXkR+GPXOTG3Q1lmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WTf1ick401uDWTBpFPhu0WLNfM9YG3MsbDr2Y3SS6N2mLN0owpfXIW9p9W/jz/zYc78AZSOUIIVG8ePyFFEPaFWFQDeAsMLpr14ceSyztoZVLo2M92tCtpZxS4RszrNoDNtyz+PGduLvLO/jBht29LxM/1w3oV28KlXNob3p7zM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6286.namprd04.prod.outlook.com (2603:10b6:208:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 09:29:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 09:29:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/8] zonefs: Rename super block information fields
Thread-Topic: [PATCH 3/8] zonefs: Rename super block information fields
Thread-Index: AQHYUsFZd0Wrp25jqEaIes7UsH5UgQ==
Date:   Tue, 19 Apr 2022 09:29:25 +0000
Message-ID: <PH0PR04MB7416D1DB58747F12010F53B79BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
 <20220418011207.2385416-4-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9959666e-442c-4965-4576-08da21e7186b
x-ms-traffictypediagnostic: MN2PR04MB6286:EE_
x-microsoft-antispam-prvs: <MN2PR04MB62861AC4D79BAB59ECC1D0DE9BF29@MN2PR04MB6286.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+XmKYYoOSWHIc6CtIY0+3KeEusty+DqdgRJz9Etm8VAtDh9/XHobyVMYlDQybhq6jWBFzogOQRm8ec26qGVtKLpAvqZjSvOd4s5E8PO3uVH6Xrmqb5rX/fFYPpROPboH40+b0x88RTkQqB/c5lJYhBhc4XOddm2Sk3rOs2pihjxuS/igKaySdGpLRu16Md6lucawn6ivU1CNsYtaFFTXDfH2iQQ6HJ5a6dBQPojkBRiv8OKTJFokAPiGpQFtr3ISguTJ7L955czyDUmg7KQLrWdyUprt8ZJYW7gA6sny//uWh5/3HJfX5kiCR+SX85x9NIZcj5Z4BBHHLhwQQ0LXLsZVE88GwuFWacK1QFMzcfNE4CUEI0GFapclc+EerghuP6cJnG9O+ZFUqfsV7RZyxd+HHMkixSPqlReW9xE1Wt9/9l23fgubKd8DOZqiaqH1kdJDT1zbAt2Fi8HiBfDMlocZe79dByVChmIJvYGcGftjX54MXrwJHVvyqMyS9/GrSjVAu6+Dr42BWeFmZrkvJXhgIPNOrGLcCsRwRB9iLSCL1oztR2z2U+2ImlagTiOeQcIhfspgozxfLAKM/+z1KuaHUUI1EJN+DIJIXFDsOFukWqhkQRpwCf+YZpB3TDR/qelEuRcdx5Z1FxZX/Nt2XFj1/9JvMQs1AIuBCznBOq3TIOgRsJawQ32lVyrEGOVsClC32t2CWRI9XyUqiPNuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(82960400001)(71200400001)(76116006)(508600001)(52536014)(122000001)(55016003)(110136005)(186003)(86362001)(64756008)(66446008)(66476007)(66556008)(558084003)(66946007)(8676002)(2906002)(4270600006)(7696005)(5660300002)(316002)(38070700005)(38100700002)(9686003)(6506007)(33656002)(19618925003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0+Z2t1ar8JDXU7t/FGsh6QsjN3kb4LJK9NB5FcxKCmm97qgi6xp5wrzOuYVp?=
 =?us-ascii?Q?Qd2Spta9pgySQ4weX/icLOjp9Lgq3oP+AkyHNF463ATg3YDQuuh6MPkyypbQ?=
 =?us-ascii?Q?vlj8FdXonWLPxkJRGCgzX7DeEwFE+OaXABX1MplLA0592JDkEZLHp5jaAt3O?=
 =?us-ascii?Q?kPJ6arCtHJ8kwqmZ9wfiH0ADEFc0Rb5DZEo2spJ5c4/lxWaLCuaqmHvBjQsP?=
 =?us-ascii?Q?Wr8OS6sk1QRqvoWS20my93WioWLmsmjGdkojouE7SEoXXlE51uo520rjaamS?=
 =?us-ascii?Q?Kq/23qkWSjA4vB9d/c+eydEuCfQbix2p9Kn8vg0srEQht/23AatFt1E2C2Zn?=
 =?us-ascii?Q?UzGke9zV1RT1WF5eTpQoXzJdpGmdycILul9T7jp3lfPLpOFsJUBNXI7FyBJ9?=
 =?us-ascii?Q?nf5TBX71a0obaveaTxFX4JJydIX1W4N0cP71giVfv/zj/LmAu/UJtPz7awcj?=
 =?us-ascii?Q?Q4kzdSVwSmsI2GUvf/cp1MCoUdInuA38V4IeOAw8v8/rv9ZkD41x4XHMGyX5?=
 =?us-ascii?Q?Ou1aEm1jSgj/o/SwWGp30NhcNYcupca6QcrJfMePA0sgPfzhlmD6EhCYMsXz?=
 =?us-ascii?Q?0+q4RoIH+ZqfB8VRKT2Aft8KBxXmHaZG+IQ2vaatql34/+WV57VW3fXn9R/9?=
 =?us-ascii?Q?ZwV2MEw7PP9S0/257po5UAXEdDq6cO8S61tctcLaxHsIHogpWvr+fAnqBhDj?=
 =?us-ascii?Q?bjMgX8tpuCpo+6jeJgFAjkeA33g/kYv+c+drME54mj6HWQDcJFHBJj4W1NJy?=
 =?us-ascii?Q?7Nml6q7NxfsMp5j+84kD2fxIGUwIgQlHKlkTbNgOMHFH2sTkEUIlM+HC8Vv6?=
 =?us-ascii?Q?I9pKarh+UrgxsGL6PUcGatrezShYDdVdaG6sVxjJMVNpVA+NcqUPEh9ZDFrZ?=
 =?us-ascii?Q?mjhQQq1l6t+hdm1rkfiWrm/isNFp6HyqgfWFUAmJx7Tx2KdpTeqve2RH1V4F?=
 =?us-ascii?Q?XQtxX5q33hZZjPNzOmqDTlVxb6abnsA6sHbh3s9emFLp+BmHzYl2qT7A9/6L?=
 =?us-ascii?Q?5KvFaru590eWdJAJJZPEd2JBmrojjUlaiTP4oYd0iC34PiuQPPHlmD5jOyX4?=
 =?us-ascii?Q?XScKHckLqi01XkbIiKFMD6OHMhs6IUqDsirRiHAUTvCfTgPKmr8UThKYNWYU?=
 =?us-ascii?Q?fOiLaAjPyxZ9rVljKXe6GJL0wz1AwHXws5syT4ZpuYeavWYCB/9XK0snwc4P?=
 =?us-ascii?Q?2O3/DBphLcjgi9qAKPyi/VtsCxxnETronT3Kcn/0hdd7M6t2G/wXQyhjt93h?=
 =?us-ascii?Q?9HKCBJE3XTNLw1sv5Lq6/gl2J4+pbwBAYI0nGIJPIngFa1qzBjBJG5WRPKJS?=
 =?us-ascii?Q?03adtqidY9c7U3nAejXWwLkPfg0TuqfSa/OXGlJt0bJSLkbMwR0WZpUj8HgD?=
 =?us-ascii?Q?gyLE8twhsrkFrqJm22mP4hvjtr35pPDsVEPvz+MXfdahHyzr6ObHwWYeq8nt?=
 =?us-ascii?Q?icsD5tEqHS23MNlonJ86TBCD1jZ8NAooywjTbm8SNiIAZ0Kamv4DVSk7VLd4?=
 =?us-ascii?Q?0WsK3kuhcJg6PesfsYRTevYT0wUxyn0jy8CgSOySbxBvqFQZpWDbtdQDbF0+?=
 =?us-ascii?Q?I1z6A+iQe9cJIUDDwJ2jPBJN450+YTaxcmEFe9kFIa9Um3ybd1ReRR5dl8lu?=
 =?us-ascii?Q?UY0EuEEog1AjPS6GIbUSs3zkajtn66b+ubzHoMILZQe+zesbfFGnMhk67zeF?=
 =?us-ascii?Q?QsQVtwHoeJQRZiojK0tuqMmrUVJ+4Tzivxplsf1/1WB9leoXGdSqDvamrouU?=
 =?us-ascii?Q?XdV/VQIaRtuBjs+c5xfEMqeTprNLn+54SdYUtWSJb10WUpZ6fenVOSK4uVSp?=
x-ms-exchange-antispam-messagedata-1: UbpSAI7xvtj4xea3WtgpUE3bboCNIoZealE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9959666e-442c-4965-4576-08da21e7186b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 09:29:25.6254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /YQ67esnmHPGFQBBok6zgFNo1AVne4CZ9rWsgZIUZC91OAqXIZLp2hx4q9tumJqT1oVCal6wijUTm4LSXArfnIjtxitnV5NQ8NAEwAjlosY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6286
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
