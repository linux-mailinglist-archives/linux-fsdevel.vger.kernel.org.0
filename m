Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBAE7B5A3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 20:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbjJBSQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJBSQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:16:56 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E5DA7;
        Mon,  2 Oct 2023 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696270614; x=1727806614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wDoY1QQRNFhUFgA2LBVqYT10ErdDua8Bu01LtYGN3YY=;
  b=RfAn7My74gqqdVGgzl2rsPTGYy1dGZPBQz/LufTJ1xK8WYStxE+nwbX2
   Jj94XgTjhHb/hdebGQzKCJtm25/LLL/30nRXSQX8aad/hYp9Np6V+20sU
   lu61oAduKJ3uCfE6PAVd5zH+BZovtfU94bQPzudbw5iEfcyRbE3OnCkKT
   bU1l1yNBxThLUoIhcSmqK3Oqqevlta0rw5S1OvOZGoVyQG7+DHrmTD/c4
   mG8MgbYPDcrfzukkw/ezj+Q3oO7F++tS6/+Z4nQaaYZqL9Weutc0A1T4W
   /z6ONf5WX4Ud1SJnp7tb9JQcWSwNR41WYxkv9HxGY1cCNH1PlqyUp1l/y
   w==;
X-CSE-ConnectionGUID: bDUKCM0qQAa5XdTPUItccA==
X-CSE-MsgGUID: 0BIvpjXjQQuA5SI1RTsEmw==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="245472170"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2023 02:16:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzuVf/tlDxRCL3zvqUh42L7lyoeSMA90U8zLcqcAxGOfvktGSltO0xE8WCuyz+xJgTMXdISMEbH6IUZ2peIm5VDPFayqbG/mCgPvKDKvsFETQ3bq6jrFCJOioBSV6IXUzbJnT4CzbmQ3W37Fl7FpBkGIe3IXWGH0NFin8eqZHtNfVaTcXbicWRQIOBsAIAEbwCbTOY7ut7tVeWvty1fXuYyNAOyAE9TZFlvgPYMAC7bFW4Ld1FWTctxQL7ZaVcu6ld/0cWejAfMWK0Gc4zMJVFUXZ8BEBtoy8Kt6wpR58WE8fo1YztCNagcHgEEiiEEfvRDtXiZXQcBbXggtybkvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDoY1QQRNFhUFgA2LBVqYT10ErdDua8Bu01LtYGN3YY=;
 b=AnNQn1Kg1cufiSVFape242Efo/C/eZUJHjFHXAgjYrImBUdrI7RF+faFwhuLISKRPXf+ttuQJu9Ua8Jc47sio/TdyOvVZT/7DIcoF1iX1hEpPs8SVY6gKSho+MzKOKtb1ePFilchvDED9swC8l2tfQWnqcqMDv9fDtiv2M+5NDJ7e3PWPhLkr8/9sYItOu+KbWJwAbYrW9jA3Ym49lw1h7omz4p9wf3I74+K/HRp4U1ZSQhWa+EMel0JXuwPIVxD6QiguAJF2Oia554JQ/HAb3sOZMF1+SODFfM0osKXgwFyVVswHB6ihKKNP3961Tu2QxeFA3JNWrfhyvbwZ7ZBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDoY1QQRNFhUFgA2LBVqYT10ErdDua8Bu01LtYGN3YY=;
 b=TSzjVjDn6uiEUftwkeQwNGEGqNpm1KFeQT+uVyy6ZMxTSMo3FBuctwwBz4C4kieV0kD7pLoU5sUm3yqbybLgVGnt3eV4nGWoKlmEv3GxxPLnzxSrGI7Olt+hL6bVoqdBjHGodHcvjoO60T76+J3/7vl2QhAi4xR9JfwGoyurZAk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB8207.namprd04.prod.outlook.com (2603:10b6:408:15f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19; Mon, 2 Oct 2023 18:16:50 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 18:16:50 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: RE: [PATCH 06/13] scsi_proto: Add struct io_group_descriptor
Thread-Topic: [PATCH 06/13] scsi_proto: Add struct io_group_descriptor
Thread-Index: AQHZ6/brHZLJtdYI5kGHo1P7lCy6prA24PiA
Date:   Mon, 2 Oct 2023 18:16:50 +0000
Message-ID: <DM6PR04MB6575D15CB4652DA7065007A2FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-7-bvanassche@acm.org>
In-Reply-To: <20230920191442.3701673-7-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB8207:EE_
x-ms-office365-filtering-correlation-id: bf98035e-8593-40fe-ef6f-08dbc373bf64
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBOhnqBFdYrZrVm1WqHtvYjrJHm1b22eptvEQFDurfDHfmzXLNTGAvsm5gciyVPXY7psH637eQEF6Z0hSbj0ay05/ZmpDXQMGE4y9PYmZXZWSjJMxNhhvZlA2IMhxU3j1ExGFuNlJhGK5qjnh37mxUgJHrV9e58Wh+QCp5R7vI+nGbQMO4dVwy9ILolJAyaUiKi0Sjw2XSzB9axVC9HgKkBfTx9ql+tR3hX17T2apWH+Rk7nz/L0B3ziwIHkKoBo5iI35OIq2w9IPmaSxITLu7pA9n6qVXEiRIOs5a4SN/kp6PDHaoyEGDWI8Bb6dmmQgkexOWMtMxWasdCyWpyh0XZHX5V7Wim6VOrfLnwf/uSXbjOF5UjA+9/st5hvyNfzO/5Z223BpQc3UnKymNvoQsKBuq/EkY24r02A2zB9qJR9ZfPwgJPYGM71dpXnBGNNDPnwAEBYxyBCA7Kk7QlTB/RPWmXivvXcXQTXgzLfwbENQWddLz1hmfga/uX/dIY4nKryvHYUfUaJ2MuVpTXA1q6ccpGqjj/V+s1iR47DHX6025F1C7G8XgtRvOZnWocz387HHMlxq7iGeQ7PgK7qZZ1EIKTZae+qTUlVVu9W5FiqjIgkXNjrxcGrhff4rYQz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(33656002)(558084003)(6506007)(71200400001)(26005)(316002)(76116006)(66476007)(54906003)(7696005)(52536014)(66556008)(55016003)(9686003)(8936002)(41300700001)(122000001)(4326008)(66446008)(64756008)(110136005)(478600001)(5660300002)(8676002)(2906002)(66946007)(38100700002)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cFv4Na+FyxvAXaEpGtFmxp07//G4wOqaOmWwP1O61i2vN/Jl3h1C63Is3cbY?=
 =?us-ascii?Q?AsvVh7rDEtKx9+Ep/nZikK01DpLNiO5S5YEB90QJGJyOHLffJ5h8C3Y/Ob7W?=
 =?us-ascii?Q?VwMs6tudeB0OHVuEx9MF8rGZTPVbRivstC20hRTZsgzUc2mxVKOLLRt4wmtP?=
 =?us-ascii?Q?8ALECCq/nvJVjagtnT/U+uH5cDw0oPdoyXfr8tf7AquLtWj2AXGWqXM3dq/x?=
 =?us-ascii?Q?jaBEP4pL2Jjuf3m4l0/fPICyIZphUC+Q7evU4APryv59yJYWPo51Dj7ggJmt?=
 =?us-ascii?Q?3JWuRPV99mPJmeQhY0IfDzeGZe5S0gF5lxlaZLkAC15YVqFb22c9XWbegIRY?=
 =?us-ascii?Q?AT83eJYpDo91qtuNHPRULzDotm+S+ge5lsvgdC+C7jxlge8KJUkl6ySZAsjS?=
 =?us-ascii?Q?JDiql9Hdo6yMCw2eai2EFMqmcJw64s3nM0QWEUaShKyOZtotp2ADyG9Q+z4N?=
 =?us-ascii?Q?RPoAIwnxcu/658C8vkAecbb+m1VkXvuflOAsvj395/d8TjZ7vt1eyLcCDG1S?=
 =?us-ascii?Q?CGwgOqEPgwXR1uIEgbaBwCF8MyfYjH7UHvLjopbM6Xz6lkdXaQaJHsUJdClu?=
 =?us-ascii?Q?kv7YL3KlSQgk6aLftSKqCLUie2rUe58kAyret/aPYLvUa6jLoLW/RW1tZevt?=
 =?us-ascii?Q?oaK2qE6QAHQdyYr0wb1b4M2lg5p9grbXktrmulnFf+5NX2SGUbjnP6seDkV7?=
 =?us-ascii?Q?pk0NyiDuZKmmlV06BWUV43IWi6/G+ch0+zgzt1D4BeEW8GQqQxPU3pJbR3KP?=
 =?us-ascii?Q?FS+OKL2ZF2v3bxKniGCz8gHqgBhpfRg2V1UD0IoFylq0oTf3GELbcTKLD42n?=
 =?us-ascii?Q?Pgsf9kjnPoTe/nMI0pcscBdkwvhzFzrpgOt8gt2fhLUpH33pxi0bWU5y9mcy?=
 =?us-ascii?Q?X7s7zokgVKyl4liVAXbDkMq7HP5BVenYlF4daKZc2OmNhrpzYEXqoxohHG+B?=
 =?us-ascii?Q?UXeogysUpZnkNE2Pk8j9cVmWl1UixT/byd4cgHYQkr19GUXm/2h9+2g63apY?=
 =?us-ascii?Q?jU0R1TbbdPTIRddONUJTk3R//nIj3jGXY9S9MBh8vYLDhceIFKysLZpPBo+O?=
 =?us-ascii?Q?kszXCVVmM2NX8PgMs3T1teeumOHjBS8jlL8xj8JALWsjLhYv2jEqmXiGjNtQ?=
 =?us-ascii?Q?nmau3xqUaSiSrtGXzmlF/H1fG/i1bef/Didnf6ip1khF4dVVDpD8e3M5kdKG?=
 =?us-ascii?Q?CFxZU2twAmqV9ISUHf8sWsnWIleeSpatZZBI8+gkImgU1wX0Sfe13cMtlgcn?=
 =?us-ascii?Q?k2FyBr846jJi0mrUMD6gjAtQ4VT00FOzVwvN5n+U+rsAwsKYMb5bqXMO08JY?=
 =?us-ascii?Q?0+EMw6qnBpcRZfeNCJgP5dg1MBOomweLdjzf6idETiS+Hcw5Q4je4zUElNuX?=
 =?us-ascii?Q?P6ZkBOKdonGv5+G+KsOwBaNRgIiQXiGzYu45/IsArV729A1XrRzGNEWMbe42?=
 =?us-ascii?Q?7gfXPl0ZneHJkY/YZl3X1zXdQebnWu9+YM3Jy4GYyX3aNPMERS38uafiQm6F?=
 =?us-ascii?Q?P1cW6mwvQxAR7n8ig3l0hkoO8JIyadSPwqxGf03WbeLNEoAQiqG41A5rAjwf?=
 =?us-ascii?Q?o194yEhaQdQmqa13qn5rL9ccEqF/RlgvtPmQuWuk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C1H9yqydfibWnp9N30x6hW/GQFQ0vEKLMIeBNdN8DZyLAsWdZSrYdzLxzi3iHKurCLXL4oYGnZ8t85yZhKC/YoSi2Dm1946f+scvkzUPv3lX7qohZOU+koCmZEK0wOILxjWn9j9E4i9jchpAtr4xrDT4f6iOW5Tzm8bW//jO4X2wg8eMi1Plm0+67vEdDpljGX8CjzyxH2RDE2JnGU6WPfVR0bLWYjj6JOlD3zkY5GI3O+hw5KEu0AWR9saZEGwivuOgK+LDY8k1GFnNELvao8dWm/3dPxUEx0/GBYj8fIIoICbCwSfL5B5fribDy6yYR5+dddicDMytn8d2fbcXRbvwWn1Tosmba4jB1Vrr913HoxgKaRUR5uRD1BJUbIZNP9wDf7PlnVpvBf8VAo9etYyXd6CLpZHWwyOKW5BtaEtqif4hhQFZqLLgZnCQbeMHgbI3HIZaFAfi7GTkV//UEIFf50pzblleF+rMAbQedZeRla5Xsy8+wtBUyFpdlWqD4nusPBEYY7Agu+ARgSy7+jTl8v+II6fkQfMh1y+Q9tmmB4SUR8M/2YY08pN6dee9CW+qrA6F02rM3CGirWtsMaQWE96YYZ+yiZ04cQPIBGm3JZhuRAEKYam31h7vvosIjfHiE86bwrS4VAy6Dr3muG8PA1zvRdClzfXkzW5e6w+Uuf7takrc6gfGdMZxLqk0q249/6+MEo+VMQ/Fu85rKegFJgTYEVJpr6NpjyXSCVeOYlijHnIdSNl0cPVg0NEIp4UVsBB77JLI2bkXSfMV9zZRJDdZVTy0TaqRuG3XzVPqdcG3dTPrJS9XpNa3WWEFEL4zQbURHgAF27jvtvZIEKe5kUAfYlIIztyxrvmjmiAYOwEmJKt0EO4+z87LKj93u7ONdO5Ta+Nrhcteclao1bU1HKEdI8Ef8ZXFC/AWey4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf98035e-8593-40fe-ef6f-08dbc373bf64
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 18:16:50.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dy5tu5uqoiBswZGfwEbpPyfbnND65B5Q4o9872S7mz5g12uvCfPA/z1GMEYDBSu8H/6HMlr6ZHKuGNpqgGWe0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8207
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=20
> Prepare for adding code that will fill in and parse this data structure.
>=20
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
