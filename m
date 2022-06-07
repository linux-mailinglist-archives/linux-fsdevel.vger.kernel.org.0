Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515B653F887
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 10:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbiFGIrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 04:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbiFGIqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:46:48 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB350E64C5
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 01:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654591588; x=1686127588;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=SsaBtyubVinLjYESWA6bot3qHyOTmUC4BADdnE2KDg/s39tucQTqNVPP
   WviZYL7SQ2yPgTLm/gvKhU3RuGDIgbD8dBXFSxci5FN3OTXx7MzzURBbI
   dAL1NO4qiGXEvGZFshh3cu0HugsMio0K2bHkY+93C5ztFwWPIt0aI0N0F
   32l5v4PBUXj5I5b4X2KnjP5b9Ru0FmWkQX7Egigw+P8F485r/o1SrW8ou
   VcZiUZ6E76YW5+6JVHRTQXPIjdxZUD2Ma5XTIwxEGB95TEYJDvzR0EspC
   Hbqc1BCFkMv9WvGkuiR/ZhfnPW+xF4IScT2+IF0lteNrV7NQYvoos2N/7
   w==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="314511576"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 16:46:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qao/wYLzZkQBIgPjNuN+/8apHrHW0/40Hwh545/e3rf+NCClFzNNhq+u/m4nGeACHw2KQuXfq5zkA+PDs32qRaBVvRVCYz6y/IdIF0Z3pzKSBOZxJe/rpoqH6CE3c125wLOz/JcpFhd1F8Lt6kv26R9zS0mdRroC9zTsuWerH572eptb/qDJLoOXWfqhmiCGuXwaoQ6S+L6Zcoe06ToucJDMnTso9+kraT8mWwaHE3IVUFzkZUqJEnIl/9C/5eMcE8Sb4k95nKdnXbdAOh6o0F3RMwj8I3dPgOs8YEMvxjqOVYn/G9CttWpXWrWBs1je+dE0R1P5IZO5scZISySDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FURzy3+exey0dzbOS6tMceJO7+dCgoeu1/ez4kXBv5kFpYZPiPaHvNHuE3j2eCNIX7Lys6GLWz2upc9m9pjOnMTvMNGBfRmCxLYqB/RQGA7uCX+rhjHVSh4VY7r2BwLH7v49HGOCLdUFmT21UKBBF17nb+ek/Ds/DyuWmC8NiYcnv3FgK9XCVIwHgZdSZ2Vvuv9yMbrpm7aEViJuVDCe8a8PishlilLUzgVvoQ8GRBuUqrfzkGE+drFbkUlsPqVgUETU5ign2ygXYUH1zW75XZ2L5ahR9nwXy4rD/UidRlxWoZ/huDyweEzPVJ+jei0RU6q4cdrO5hG1nJ4XpqH3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=p8N1uXbJ769ncH1e4e5uT/xVjN3hV80l+Krmi48EMxtil4wpPMIve7+HCtOGGYE3n52zgsNIc3pxHvxSiPYn2IJfGI4HbpcvmH7v7eftW1g3f9pjk8JzgN5cCaDf4C2nQXqmeqVt3vm9z+m1MtAulGh6O9sMjJUhfxj/Y1TJ9so=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5487.namprd04.prod.outlook.com (2603:10b6:208:d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Tue, 7 Jun
 2022 08:46:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 08:46:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/3] zonefs: fix handling of explicit_open option on mount
Thread-Topic: [PATCH 1/3] zonefs: fix handling of explicit_open option on
 mount
Thread-Index: AQHYd0AFOmi3Bjf8O0eB0IZRxXH0TQ==
Date:   Tue, 7 Jun 2022 08:46:26 +0000
Message-ID: <PH0PR04MB7416E918FDA3A1019FEBCC729BA59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
 <20220603114939.236783-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ea87765-b01f-4896-2532-08da48623541
x-ms-traffictypediagnostic: MN2PR04MB5487:EE_
x-microsoft-antispam-prvs: <MN2PR04MB5487B2F261DEB879F7D4DF239BA59@MN2PR04MB5487.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: INaFYoDzmtVXviPNld9yVr+oabFBE4BinisbQ3YCazvzmoDtTsg9tWrkyMYR+AiY4Y1zZEomyFDrKrXQIqj/JUT2EvyZiIv5OLc7CrEt4azfolxSM21rhcuMWcaK6hBoexdYQb8QfY1FQduuCBdrsDDyy5JxJerChupDhuFBYmahML58KwWMf+1jOvyR/AiMfgHpmYQbIg/xvOtM8ainMwbu//TaZZPlwB6uOXJ8u/2UmhPtRtq9y9LTiuUUKimjvzammGQNfRBJ/t8HHFc5h/F/LpV8sg9GG1w+craWlcu2eOMBxMXAsmbVvopFoNDpGc2fo3sMKAhu3fmw+crw6rVOUKDrXaCGZxpTTlpRfeYa3SniNkg8koqWhXyYXWiUURPO3PNzroBNl4vxqLGqcMwg+JMaLP7jOo5TTUQYeVEopOXKJckbCsOedN/e2SrKavwOyvKTxtyaKOlxdnRzIVnIHkpJWSUESqEIe/yhi4pxkff+ptSlTc/r7QH/0mp9E63QWKzMHWK+JcB2pvT0rCcOlMEaaP4FAR0minuWSA3XQLUHWbZu6CD1zj4pEq8E2BkMROZ0pqZPkOV+wYJg0baGyVuoHOWth1Yb+N6pCjOGIpV0gBY23OfFiAcfX1O3zng9nAH3AYdaIB4zXp6qdlEagml6QqYssqioSfw93bHSxcwPx1h9MBaIzKMVVp0j4sHg4fuvwGWDyvL/eq3x7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(8676002)(186003)(38070700005)(508600001)(19618925003)(8936002)(52536014)(5660300002)(122000001)(66476007)(66946007)(64756008)(66446008)(66556008)(55016003)(110136005)(9686003)(7696005)(316002)(86362001)(6506007)(2906002)(558084003)(33656002)(4270600006)(91956017)(71200400001)(76116006)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?npsH5Co1DXD6dUPkkLtn4cNgCvfHrKIoYqMJpGyf22y0LVnoGTOba8VdQBMe?=
 =?us-ascii?Q?gzkoD4mynrLz7UGmc8tcuvKkDffYhD3qtjJ0OyPLv8eUsbTLh+pDLvLW5Bfi?=
 =?us-ascii?Q?21kk4i0P8Rp+vJfoM+qef+J4lS7A3AlhD0njXgLHJ4yu7u+x9mMf4kpJJD2o?=
 =?us-ascii?Q?TcR2CTx2jgMFUCJBXysCyOyOmLuqSHvbtN4MW+KAY7zsa6rA9I0iXPBM6JfQ?=
 =?us-ascii?Q?INvBEaMwW+FOqs4EqHR7zaXYCub33koq7acxlRv79mgWxAzKZjtoACxOhucV?=
 =?us-ascii?Q?eOmD65Mc2sAI2xXcM6czoH63eeRyfFRyjLaqO3g7z9uIFYCvO+DTpol2078C?=
 =?us-ascii?Q?ME3VA+3BgnwuCH6YH5RCSPoWrrQ8JL7T+AbwD3bjPA7AouqpHIQ7HKQZkolT?=
 =?us-ascii?Q?UsnyPVHbZao3UMVJ40Uc+kB8R4w2gwb3o7yfT/6MNV1uK1zvNG/N0P7o5usb?=
 =?us-ascii?Q?/MrQqMYCHwQMwPE/3IidXrfiwurxnj18L+SxwDPy60R9J+6j1+hj6stpGYBm?=
 =?us-ascii?Q?FLlJh7f2dvRvfrsy49CTLY7px/D7XplLkayDWUUnxtXJ/cOv0pNjX5eknw14?=
 =?us-ascii?Q?mb8th2548DEm7KQacXvM0xo35sU0wKXouIXnfsLkcSJDGBFuqUEdbPUzgMNA?=
 =?us-ascii?Q?diY+78LNOSVWlkCI2x2wOmZpfWyaD30q0W47gQKdVfXQhY8mX6nomiZklKfT?=
 =?us-ascii?Q?QnQbgqRj7MGN+4GNn7d30nSldaqPNWbWA6UrnIDKcUE4wsWNlysbVJKo5zz0?=
 =?us-ascii?Q?H3/iI1Yu2EZEo9j0eO0Fk4iaikNyfvKkUFLht3FyQcPyp8+jScPP3cW8sMOC?=
 =?us-ascii?Q?wYTHnNHQJeSemF5NTmPGtF/qeTg+cv2FH7bzKRVHg1x3ixpRl0bRw3KJ92+r?=
 =?us-ascii?Q?YrXLq5tJIsQF4CYG25L43nqjH3wt3p13uEwXaNVTqag6K//wP+1mGoCoR9aZ?=
 =?us-ascii?Q?wpSF3G/Wf661QO3g9GeAhgm3yAjrCWbPOLvGSaQaSyr7obP6ZV96T9jY3P7O?=
 =?us-ascii?Q?QBsshKcMphXqPvK0WDGn2sZAMfuJ3Yfnf+5mXaY4G6GFK7XA1JRtiQGBGzmF?=
 =?us-ascii?Q?X3WJxoPcAtgUthh4GwzJn8LSr4alJTxEojpg7FzEzYCzJsBpNBtChO9AoOud?=
 =?us-ascii?Q?j2p36KFYHWTd2+2l6NdAWOSQxvlYc1SxumyzxrPZP4InVjf8pDcNztVqvp+r?=
 =?us-ascii?Q?J6jEPy/k1uFjh2Iuwabe2RtYt9TV7Q6a0USKJafV5Y7/ypG3MwbQoeBIvV6j?=
 =?us-ascii?Q?VJTYrsK3KmbgMvqe7UJKuLjYK5/JnRTZPb6MlBHK1rzNVsn8Uam+fNUBAJBp?=
 =?us-ascii?Q?NnYMbx8wWo80eh6RE4rOHisYZVeP+KeBv/kbIcxgJ4jSr/bgslHhiZXq41xQ?=
 =?us-ascii?Q?c1+udiFrUEF3iCQfkDosmiu4mXebFuoAPVMGPsYir1DoZYqGh3xMAm9seeSb?=
 =?us-ascii?Q?Egf0f63HIXcJd5/WiqW3ZYdU4g0eKa+v3IhzKTM/QhL/hqwnar59K3Jrjz4z?=
 =?us-ascii?Q?kD7ZNsEWzObtj9+xCSPn2m+3C/s0bT1i+WTnD3mzWQabOviUhwRBxIDrLmmY?=
 =?us-ascii?Q?cKmV2IehLVygLnCMKJGq3y5MSAMZEP3LaXin0sDKsx6j+v4xEOvCg7J11i6O?=
 =?us-ascii?Q?XHc0kjVMRNLHKL2fnzzykyW5i9OZ1Xp1WCPL4FULsMQGBf5UFqjUvSRhGN06?=
 =?us-ascii?Q?65vxH+hHCE7xXhZKcX+0xDqjBVZa7CYaX4KIg1oN7W+4iNXq/YeW1VSZspLG?=
 =?us-ascii?Q?U2YiD8eKMzjaY0WLYoP/Yp401kEWSqE6D1OIZF4oKcDNbtMy6zgADBHjL3zU?=
x-ms-exchange-antispam-messagedata-1: QAiJokYjx/Xoly1+NWgMwS0ElaR2pYSIeU/EszqbkWDNqP7AbmrCy1B/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea87765-b01f-4896-2532-08da48623541
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 08:46:26.3334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIGusL4AH/P/Ck2r4jWssPY3Pn1and0Vm53Cw1CzlwoQP/1SJFCBImK08lrESX6a3Hzk5BeKeGR8SbLoRTNF226zmT1gSa2ChXGSRECtc/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5487
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
