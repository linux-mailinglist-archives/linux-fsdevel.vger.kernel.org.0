Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2EF539EF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 10:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350499AbiFAIEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349223AbiFAIEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:04:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA05C4704F;
        Wed,  1 Jun 2022 01:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654070677; x=1685606677;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=AX+6hWsHVqaGACOJ8JZeK3q57JD1eVTZo/NVSnw/lPbWm0g8/BSw3cnj
   LE9h1PFrJahDXwsqZXKOVWYZL2PvPM76YoxecSPLNQnCTt97pGwgcfggI
   hkR9972onA6Iv6Y5kA7kt8tO6vD/8yj1+eDuxh9O09Sek6DwsQeUaS/Hj
   iT2DZiZtK8Fu10OZ7PRcAQbaMYKDcaOPVSQYFxZLsffitiy/8bfro6K+G
   Ta5/fJE6HTbHtcP09D8PtvEvzneXHDTgQjQ375ZJTxf2R/HvukKumQX1Q
   4kwXADZWfpe1VswqphNwUQwhzp0e21TvCvWNzi+SMIaG6iAZfWSC2A6PZ
   A==;
X-IronPort-AV: E=Sophos;i="5.91,266,1647273600"; 
   d="scan'208";a="201969407"
Received: from mail-sn1anam02lp2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.49])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 16:04:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcWlSNfGmJuvrOufkM6WusP2ksYxK5ENhazqJCRVkMKHROelcFCzNVgI7bNbHm4ctwYlbmRjeO5WgWIU41J3Pn0P+tQyVFma/8hz9qrCAvgZuQtw4qNKMjGvQKba6lSpz5hiyqM3S8M0Vu5vBlgvVJ3/hK/7FxreNhlc3OzY+lGwzYDK4YCaqX4oOuWqxgDkDOmoeYaYhYSEvuSEvL482aSRlAUhPcjbf0+IINQwYfCkcxe/oJA+y4EUHMCHSe7ogcXMDN0y/Ul3AdTImyeAiRFyfKiNtyq3r7A140HwBUb9F4llk9x7X8T995pGstSe7R9Ibp4TC65N4xJDfHu4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ui2NgU6CH1F3AvrG7+BGkrsu8gEA6d8JyDt+e6Bk3yAdAsMCEeLM/l69/BlZo6NvdO6OLiyCddHCLsJ+o+zh2qAGlm5sIuF4OHFf8m1bwzfqmhUmCFwg7inT5zl3WZ4wR/lJ5t15xcNHc81fa1UdKHUB9UjvEckx3AWy2kMxkIsWK8d6hBtMxPMskeO2Y9gHkCjr0DcKWfFgg4+q5tP3GNv5+B0Iq6j9hgOmkUJayOXB+NDGjjSv0xlD5sZPFOJnk8O57WJ5z2rKK05F2Z8/B8hOpfMoaYFdNklaRU6cODfpOy77dTzJZt9eLrsl9Prnvypx8OM7TckHbE5opcxCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CGcnRdy+FOethpwJZpK04qaqUiRSdVucSuZ5Yn4mSZUNVoIWMIGCTEM9KJEijxdFMj+SSaC8bNcmG0xzQfuQrpp4KfJ3v+Ow40UcFO080GGQ1aoQ9/ex9prw0X46pPmu5fvm9zlspRpF6lMCNiHa2+b4KkAcLBYPE6awaC+YJDQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6401.namprd04.prod.outlook.com (2603:10b6:408:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 08:04:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 08:04:34 +0000
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
Subject: Re: [PATCHv5 05/11] block: add a helper function for dio alignment
Thread-Topic: [PATCHv5 05/11] block: add a helper function for dio alignment
Thread-Index: AQHYdSPeVHVJRvl4EEGg45qtnL0dxQ==
Date:   Wed, 1 Jun 2022 08:04:34 +0000
Message-ID: <PH0PR04MB74168F65E1BFBCFAA113BEF79BDF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <20220531191137.2291467-6-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdb19f24-42c9-4836-a84a-08da43a55daf
x-ms-traffictypediagnostic: BN8PR04MB6401:EE_
x-microsoft-antispam-prvs: <BN8PR04MB6401192F2272DED78F7ABDC59BDF9@BN8PR04MB6401.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f+UW9p5WYwMA+wXDp3LkGYxQT7zzJD1WIGwqJKh8QXmHn7SBN7GWwrJ/zEu1fwjsKc5NdjaWTFedGD8V6NyiJUoXeGf0Sbme/ZanMwBkUArnYYPyqE5yAG64oPc3MAyMwwwmdA1Rs84D8Q4QphzHJUxsxCmBKj3qu5bNXpB2QJ+7MwJTBZC33UhYV3u1HTX5G4cb5PbMTbSl+eknfrSstwCU6cF/dEw4fbYU+JPWKFZ/dYKV64a39OoaSWDWeIkxRcseSw8Z85/SGkk2LvPEPzRkWNJSQq7pARDKg+zJ5BGVledGTmI2Azwkxs89q7Hk0RJm8lqooWdbzyPTCRnRmc+RC3KcR+Yc95MJfQrn8roF+OZjd3P2uJXNaku9zrXsQJSOZJWO9fcGhhUvdE3UlLt5CYcs+WeWiTM80rfHY6Oyn45gPTlQsHf8tCsohnoSSI4DTpAd0oiZnkjnW0BvCGOJzBqnvPPO6+ymg9M0UOp1azHfDpOZRVEmFagRkPiQS8HGXYq8wk2RxoYUcTAM/1jhx2zHMAjDpfrZVgF5+L0p/BqoIaGmhieYpflnj7ViQr9Xvxxc5EG3HHL9vM6UqC2UwJaEaONCUbc9vVtdeYteFELSiHtxitt13LlpGrvfvgDtpBwtr/FK69kaqfcemux8PlB9s75cVnlTIB2By8UOwNQvc7OckAjpDXMJHTcrjvTfnrYj2ZfNNCk4T2Cisw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(52536014)(508600001)(7416002)(86362001)(6506007)(8936002)(558084003)(55016003)(186003)(9686003)(4270600006)(2906002)(7696005)(66476007)(66556008)(64756008)(4326008)(76116006)(66946007)(66446008)(8676002)(33656002)(38100700002)(82960400001)(122000001)(19618925003)(91956017)(71200400001)(316002)(38070700005)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A0jPMnp/Ia84BDgjQ8cU12vDHabZRJ4c9jmyNZrYRBU+SLE9G6JIt21KYh24?=
 =?us-ascii?Q?ws/RG9pzBu8cFhdNWycFfFxvKLZMx6Ky53biXZFRMIbtcHozEgWQIFd9WtyN?=
 =?us-ascii?Q?YraUwT4s8RZuE33ujddSIa28EiiqC2c/i6ozLZ4otIst46xgIgjaAkfcGuzf?=
 =?us-ascii?Q?f7TdvJY7u9i5qH0w+uoXLeaY9hCru5gSZOzd9QvzV733VUWOx+OZQVGdUavo?=
 =?us-ascii?Q?hZCqVsxBjk4XennfiB0scI32g87Swyh5a+QRt5KJ9sZVLpwvWM5K97epExuZ?=
 =?us-ascii?Q?qRT39b8kI8uL8jF47NOE13NIZK34/AMVSn3L5lMIAlPlT5YFb9DV5oEdggTT?=
 =?us-ascii?Q?zg/pE3++U8eRtFft1zUCWwfN0He+BwBBBaf13qkM6+w8ibCDeeYBX9xROUf+?=
 =?us-ascii?Q?mC4FDuEMmL2oPKuXzB4uwQyIrKo+FW+9QHyaU86SWpCa/GKIELRCtUu2Q4GF?=
 =?us-ascii?Q?0awlUWtQwVO+sBbFnsd7dZt+qWuufAyevwQiznw0srX9pmUVLb6CWerKAMsc?=
 =?us-ascii?Q?vF0EkYdG5ipRpARCVm3OFrnsLCx2pX8+6P/HZA3sD+KyPwnI5CHcbxEj+uqy?=
 =?us-ascii?Q?xPfZbFxb21sWCmKNx9UJxDq4Ogng86xOA9bLLjzpkg15DnZoPO/TlZdXAdIy?=
 =?us-ascii?Q?MrR5RGNOLNKl8HbmIvXerJD9C9I95wMdvPZ6wtBymMxuH4KJzCpLBe5PC0ig?=
 =?us-ascii?Q?fZEfPxj7NDT5dAtVA9ka6at/GSx4y99yqSxFWpBzcd71PLJNjBGrYwmgp7pn?=
 =?us-ascii?Q?RSVTJ7/vbPeMe0v0EPYh8JS4Lmx8dZy6Fsht8OYZPIpM/ML8y5vSGUIqYTJs?=
 =?us-ascii?Q?xqb2yGIk6TWVRljgbXs+bKCaACXFfr0AHdWi6ScLHs/JAuyJ9w0kwrdqLAa/?=
 =?us-ascii?Q?WxsWI54bjEwGHWlVJkEg0dSRK4tBAtNv0YBC//T2batPA1UXTx9DzbPVpdwE?=
 =?us-ascii?Q?t7vt1FY6K6cPGrEuc1c6vGm1l9erSNo7km57M/j3N1BoW9CqDhT07YPz/OOc?=
 =?us-ascii?Q?60B6Bq8aoontOLXKDJokhUy6Ie8DiSK+PvSPu6RFojnw5/oKLW1pkgRjISxI?=
 =?us-ascii?Q?C2kXgDFuGkvWRfVZ7n9atmTBO8e5reMATA/HZUu93nTMW3SC5H0qdddP4o2g?=
 =?us-ascii?Q?6hWwsB9RSTDD9JmuBUjYOaDRRYT3vF9H/R0yqVlJZrDRX9nJcGwdaLf65fVl?=
 =?us-ascii?Q?Zzfe0UdzPCzrzPVrLrU5qms8NPZGnIPcumMsIsa0CniJjOFuGQHV6DZ34JLc?=
 =?us-ascii?Q?OT7bOlLW5dZBaiS5oGSRwBUFsCgcDvV6BhjsJGc5BgWI1EUzz9P0Fdpjorsz?=
 =?us-ascii?Q?zilZGeWfHYVHLWk53p04o9mcf7w9UpgEQTAFkftU7qD9vJ3au9edWS9TEOIs?=
 =?us-ascii?Q?sssuTaJIRixDKyWsxuf7/dmKMQQ70Kn/vQ+jWXg3/ow85ohyn1qB4OZd/z75?=
 =?us-ascii?Q?QMhqcGen0XYVQkPOcLDjlywC+2c0IMNVMabkRHjVZfNqcsDs+PJLFw1eeJZj?=
 =?us-ascii?Q?rsGqqs3yCLROhp+vZ/Bm28j2z0M7Mzu6QwaMu0B/hqa/OqlEK8zeokjGuLsh?=
 =?us-ascii?Q?pVyvJWOvlVcr+Qm63aDObQDZHfQcH+z50k41ey6dw459AAn7GdCJ9wWI7qXB?=
 =?us-ascii?Q?oNv4rOCXhQ5N2YHPEyCemTYue2rVXKOQiOKLwbwMPB9dfpNxRq9xoXQiRhRU?=
 =?us-ascii?Q?/U3D0HFj892c7DnMiO+ql/Neczfb6emIm6KzxrwNqrB4aq4RKVm/EapheplD?=
 =?us-ascii?Q?jug1+BxmPv29TXoLgvmjRAcf0SDSfoTWD6/6WUhvBubUQEe76qqqHCqELC9p?=
x-ms-exchange-antispam-messagedata-1: qe+XUgz9ZF94ULaJ2rSL3xkzSudqgZHUutVul4EKBcTxojEGkc5DGj0/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb19f24-42c9-4836-a84a-08da43a55daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 08:04:34.6491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IC/cndK732NWo3EJiWh8iy4Qr7H0aO1XGApbkA8PNIH4Udjl5Cy7P+UywGnu+AqWfPiSpCuuokhu1sVHMNFIeM2YyUBPru8lW0h23kHLUCw=
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
