Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61757AA086
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjIUUkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjIUUj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:39:26 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492BC8CCBA;
        Thu, 21 Sep 2023 10:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695318175; x=1726854175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qktmf5GR7Czvj2I/k4iwCiHqlCtarqrcrwCXPvwhI7U=;
  b=jz9pDLI5g2jxb+57sH385QfFlcdY5ArQ0+RZEO5CJiLFJgeyEZizj5Yz
   H2BiTtD1Cm/bYSgdkEAUZnqZWEZC7ezMOX3ZxRx0822Z8eIkawty/DpLm
   x3XKLB5dMRyPP+RYhwrXxGGP1Ubja7BLDiebHhapAsqtkJIMKnid/ZOGD
   nghPGEJvdBe+ciYGMw/oXUX0Nj7xKbwM8Zr6iS7l2BeLhXyR0HmIcgWMi
   +8bZxUCUr/SkV9/y674l7Hbn5fVQ8lD11+B5OUr8sCmLpxKPmDxyIWjbL
   EOjZlKF+9N034iZEWMa1+U1f0GmKeqRSw8IsDAq1VdMJ2Dco9PFGeKbba
   g==;
X-CSE-ConnectionGUID: PWkqlKwJSqmCQ6ZTcsqafA==
X-CSE-MsgGUID: ZmdhBHUoSY+0CncOeDqaIA==
X-IronPort-AV: E=Sophos;i="6.03,165,1694707200"; 
   d="scan'208";a="244552076"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2023 23:34:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVfMkSO59xijf/UcNFz4MWb8PenIZ87niBPDjWKCyIrLC1p0QMS2Kseqv9vYhumgr/P0dqJWv3okOCam7xC7kMpWPmVK1UeCoT3/0rZvyVkRbHoDUoNrVUNNY07Po9G7SXs8P3MuIaYh5hi7g/72EzguZiKwyW1v57/T2b0tO724VLGfK8IaXf4HGrArSYv1G/DLNdNHeuoFGEdx+l5fu7aBsm9NXhFL7a7GR/WbFFvmDr0A3UOhlr3RcFv2SlfInqK1CB0y3h/UIbz6tD9uXeUySjzG+rfVbY7SkkQznal55uCpt44rgMMUqjV2z+30RBrAmqvbhk0ASumwBu9JZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qktmf5GR7Czvj2I/k4iwCiHqlCtarqrcrwCXPvwhI7U=;
 b=gn36s5Uto0IwjiFaYH428eoyGdkvWMUdcv/WLOMKLvipscrO6pZhwL6pWlA2ae0bDhEDyZnviBjjh51+T/DeLGWsI+GV6wzYlwg4sBSXTouabuG9O+IeplLGruuePLwNR+9U4yedA9mZBMLhWEDqtHymekMaC45ksjL1FS99ilQl937pR1x5LySq0iiQ1jzJOInWZFXdpfWjOeS31VyhR1Kv63j/8BG6Gn8nt7P+hcAAIuwAtYGt1SbzQ+wh7RDxjMkqMBkivdSRrUSIRrsNEDJYrwPYsSlKckTyLzRoJxF41yPnCBRbEzGtjwYfDebVeq8RsRFpNNacusTIgr37vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qktmf5GR7Czvj2I/k4iwCiHqlCtarqrcrwCXPvwhI7U=;
 b=AEvoLNLFfNlng8xatDz7Gex5MUBgXyP54QPZSVpkVb75Spch5T4NaynkzVcFrOQzF+l9BlpAH6AxYeFg/ERnRSsrN/2JELfb0YueSpPHIQo12uN5OLnpeNy1EK2RvlSjRN4PdlSOvA5tW8kLPlkgdkaotohOOxNCYdOeD0ue6S4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB8574.namprd04.prod.outlook.com (2603:10b6:510:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.10; Thu, 21 Sep
 2023 15:34:43 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::59a:f2ee:fcb1:4eca]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::59a:f2ee:fcb1:4eca%4]) with mapi id 15.20.6838.010; Thu, 21 Sep 2023
 15:34:43 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Thread-Topic: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Thread-Index: AQHZ7F/JFfj1sZp8ZEmkxmgvdKgC97AlVqcAgAAS4QA=
Date:   Thu, 21 Sep 2023 15:34:43 +0000
Message-ID: <ZQxiklow/4m4kvYu@x1-carbon>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <ZQtHwsNvS1wYDKfG@casper.infradead.org>
 <1522d8ec-6b15-45d5-b6d9-517337e2c8cf@acm.org> <ZQv07Mg7qIXayHlf@x1-carbon>
 <8781636a-57ac-4dbd-8ec6-b49c10c81345@acm.org>
In-Reply-To: <8781636a-57ac-4dbd-8ec6-b49c10c81345@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB8574:EE_
x-ms-office365-filtering-correlation-id: 487c16e4-7eab-488c-e796-08dbbab8472f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +04UVqpr2RwRfYKHsKuQtYqUqQmfaso2XvLmh02QGNyMeEySzUVb/8gtdCdhX+lVCmcLiDXXWSh6EGd/aNgaQE3saihAIux8NCQQlXkco1sMGjX09h1q9g+EuMZJ4YigMPkO8IusKFEOP0BU7aSGxKXfMyXsEaDssit7pezU9Mp5E07xBUkrcRwUiKd8ctXn2nO+Zp4hA8fXU3mke34M4JEa82MCrb0lOJRLlDlvher62xUL5UAN234ggIFX4gWQHC3iCYjV4Deie0n9ujrMF8yME4i5PGpPgv6NeLh6QEXdsKbYNpa4sJ4s9CsXoL1BtPoYrpTv8cNgzpSSzFTOBBHLSD3UkWLtzhELgwpa81l6efTTMo5JROHHggqYeKxDMiP+9KpbBODPaoQLi/l/ZnsByH941Ik62Hx34pgdwhqi0RCkQfoYFnTfzHBfPdzfgxFNwUppUIpiem9O5qRx+IFK/YmjSqxi5jbUAh2AuK2XU1WY09nEcL2sDtHZkVRUmfn2pLEdI6rqZDU5cv0Mo4IsFy1ucvKohPLWKh9/fZ0cSpDxrSTS/xqYJrLmeZiZKmodGoOLJypLxChcN5gN7uqGxh2+bQtIV4oaDqwjHT4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(186009)(451199024)(1800799009)(478600001)(966005)(86362001)(41300700001)(2906002)(5660300002)(82960400001)(91956017)(8676002)(38070700005)(4326008)(38100700002)(8936002)(76116006)(64756008)(54906003)(66446008)(66476007)(66556008)(6916009)(66946007)(71200400001)(316002)(122000001)(83380400001)(53546011)(33716001)(26005)(6506007)(6486002)(6512007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e8tgKDlkiJt052MZT9zEvd9zul/YoUqcndhXSbnfeqq8yp647cE20aVmDxsD?=
 =?us-ascii?Q?Xe1ybAgOcmQjy/wKl0VQFz3TD46d8hytcKLpn5w8L32etm3HON8YOa9tTqds?=
 =?us-ascii?Q?NtgNCjmC1D8VrnjbpoPTt4+Ec9OjbZojgrFnn4Ly/pNhiM2BXSSXBFf4XT3h?=
 =?us-ascii?Q?+aJAj9paIbpdNIp4SH3NwMalqg6Xk5aUSlNsA6CWI5esLxfL1piPmqTf3Qep?=
 =?us-ascii?Q?Nb+MbXuEtO9/a53Umewe1Ip4qMXZON1xllvcH2CvqD/3+PyH1LufVEtHIHvU?=
 =?us-ascii?Q?YfQPTf6WtjjTRTA1n+h5D8+VCshGinwxm1qCiHXbAJWedV7HZBpkfuRwrgal?=
 =?us-ascii?Q?fpx9OeVaRIaQ+JqLcA+jv+FLxOZgdoDQHl6sSc1TyxxvHuALSCiGW19sxmPW?=
 =?us-ascii?Q?oENExV1Bf2sNduioQfiyIvch0PkbntcFml3lm2S7fozk/lukHjKcvovF+PXk?=
 =?us-ascii?Q?a7D56VDSgBA+eBYDUlWrQOz8DcO/QoVCp56bFDmjNaHho7kiMWPoeHnMT9Cw?=
 =?us-ascii?Q?8h4RL2JB0B2Viaju7FeXb6O3BXtmI0MmSqhDbZNMxPRFWkaIlQkYGz4AEEM4?=
 =?us-ascii?Q?WA1pCu5ZMiCR7uVRvDGdJQuOo5lI3MfgfV4jIctiRVzRBDHgZDrohDub12Om?=
 =?us-ascii?Q?IhnkNNegD1RO5wFdjucuFg8zLi9aPek3fTcJMwRSzGi/0tffzfl6+xBk02+f?=
 =?us-ascii?Q?z6aHedfYGQD1lNJFAkpYWAeNI624wuJAZ6GqBhxaZUqR6adP7Re8DIgjZ+o1?=
 =?us-ascii?Q?Fmpn6OJgsaz5cFumOD/E6CBVdOZYd0FwLY8cvdgMrmLbgZ5gD1P9i6lJIYh0?=
 =?us-ascii?Q?aG+yHfP1PhWXBf7E9ydP1C+LdgtEtRleLW2N4MFfCt/6lnjU/zG/kEtKYh/A?=
 =?us-ascii?Q?FdMYp7H9bGa9CmFdhp7g7wT6PSEuFBJDCbQGz2roYAtHt/3AM8k5BuCPifsW?=
 =?us-ascii?Q?YMYIUr7r5PeLxUskOkoUQbogJm9uNFWVo3oMW0QLsbKx/Zj5f5ZaLZRiFHGJ?=
 =?us-ascii?Q?efGr5DPa90kVgYxO91DE/QKziiOrvsEzHuvB3h50H0K11L7wnbHdvowAU1AS?=
 =?us-ascii?Q?2jivw0b30xLDPw7E+gIqfjCAxee1ylQX46Wu/FVfBl37u0bFXqFApto3DVXD?=
 =?us-ascii?Q?dzTf+FREKfDV/0/bp9QkhzcTj88G/31wE/6wbgB+HDWF9Szzwyem77kL+/K9?=
 =?us-ascii?Q?EOLxUEe2T0i523ziPBZJXqPQamAn0qJO75B4/2OoZaSDdHbCDA9CBhYFW0/i?=
 =?us-ascii?Q?sd0XORyNeplhJxO/GSlx78Z4TCbhl/XTORn8IMAnD+0QODdLXVFMGnrA8tf0?=
 =?us-ascii?Q?GaWr0hbx/c6p6KQaixxgpmGDCKuUf62QvTy6sh5tY7adHJ5+3k7eq4Z/PzN6?=
 =?us-ascii?Q?Tu86MqnlHrKvz/+cotg5l+Vpn/cOyEN/BCbcgGXNxtH18KZ5c70EWfpR2WCr?=
 =?us-ascii?Q?U6It8MOEs/NUdZ/KCFXnneMGKKx+xY/uIM3IWMQztvY4YDObWt04LscnqcBs?=
 =?us-ascii?Q?1ELhI5BQKYdx49qc8DTLfQhVXKT2nmHkyd2A2ClrFbF4RppnMtB8Ta5pvjFA?=
 =?us-ascii?Q?CiO4uSwVwoqt+h/Uiai9oiOBUMhdSNIS2k8j6IuZ9GqSN2NH1DNqQT8+AuOQ?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C54F232FD2FDE14897D31808F7114E92@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8TJMI1ZpKXUM8YziQjnR/zFA2akNbSkOPnZq4LmukrznnXuocQzrwXZWohMG2mDe/67E3Sn457OMa5hIfhC/xDHtk3AVMIHpmrCT3edU1ATrCP+f4+Q2T5pHnyUQ5u8fwPGKsbCeqkpAsUjOA9yeq2u/ehuwP0ugF3tcJCS2y+oERWsnWJncsfRnH0b6sRUvdw4Y9sTHqMap64dMJTPF+H7R19rStqDSub61Rng0O2Xwpx8FlZwtFblBXavuUWmsV1dbsNCLRcrPRiH/c/zhTzhX5RNDQ8o1tf6CkBdZStQ5ZpK34/F0W+mukrBDyAHNp/Wekg3v0BMpITRyiPLo9VXFxWh2CKKw3QPMCgk16xFfnkzD/7z5bipWPib7yf9Ho60IKPAp+Awd4Dtg5d0GUgSaYEYggKgSVy7ifIOjT5C9T6foy2WKB/cwTjANVunzWBc0UEjlUOwqZNgsgfgdU48wGAi/Ziv93UG/YO8S/k1Om9M30Rd/wNH0sFrS8P+U0CPx6hEhhHbNk1vwIfWJGpWLpWDg4uykuGZyD+7HXneezG762XJpZwpcxGWn83YKK9vhuM7WZSoWLW7krAK1yHA1vu5u4H4GbBHaKolm+RF3vv0krTBC82Jf/MlKjZlncU56DNEGpQE6CRlXWgs2Y5ZzkXM91dR/iQExsNE16Xbs7NQF4xYDvWTy4z5BYBTT3hSuhujGTasUDhOh36esZil0F8P12OcUpFC8B4Q3N/4hieiJXOcG/k3TcaGvMmxlfZP8tcuIYidwHojTXiGiCLUCTSjeEOB+C7rJ8HBs7AszZsd6kXuWhcuwgsibajLRxx6TOQN7w2qB0CrOeQxIfuxNciNTZdw+EOV1WQWTXRlnUbyr/nrWYeswhNSkRUOgbscu/RbIkhnRLEVDih8o/Q5647Sj8w7+zBH5iheXSy0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487c16e4-7eab-488c-e796-08dbbab8472f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 15:34:43.4005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6XNHm1xgxW7d72EbiBz6NUfDdECK8vEdi8UvIGeZ8oxP/JoA+zuUQ9dc2K84URO1RhgerIAt7RiGHLlOcVYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8574
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Bart,

On Thu, Sep 21, 2023 at 07:27:08AM -0700, Bart Van Assche wrote:
> On 9/21/23 00:46, Niklas Cassel wrote:
> > Considering that this API (F_GET_FILE_RW_HINT / F_SET_FILE_RW_HINT) was
> > previously only used by NVMe (NVMe streams).
>=20
> That doesn't sound correct to me. I think support for this API was added
> in F2FS in November 2017 (commit 4f0a03d34dd4 ("f2fs: apply write hints
> to select the type of segments for buffered write")). That was a few
> months after NVMe stream support was added (June 2017) by commit
> f5d118406247 ("nvme: add support for streams and directives").

I wrote the "this API (F_GET_FILE_RW_HINT / F_SET_FILE_RW_HINT),
i.e. the support for hints in the block layer.

This addition to the block layer API was added in:
c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life tim=
e hints")

As part of this series:
https://lore.kernel.org/linux-block/1498491480-16306-1-git-send-email-axboe=
@kernel.dk/

So this support included:
-the block layer API changes
-the support for NVMe streams


The modifications to f2fs to actually make use of these block layer write
hints was not included in this initial series. They were added several
months later.


> From commit 561593a048d7 ("Merge tag 'for-5.18/write-streams-2022-03-18'
> of git://git.kernel.dk/linux-block"): "This removes the write streams
> support in NVMe. No vendor ever really shipped working support for this,
> and they are not interested in supporting it."
>=20
> I do not want to reopen the discussion about NVMe streams.

I don't think we need to.

I simply think that your cover letter should mention it somehow...

As the whole reason why the block layer API was merged was to be
able to support NVMe streams.

So you bringing back this API, I think that you should at least
mention that you don't bring back NVMe streams...
and mention that you bring back the support for f2fs,
and add support for SCSI.. with some short motivation of why support
is needed in both SCSI and f2fs.

Right now your cover letter is 4 lines :)
I don't recall when I last saw such a small cover letter for a feature
impacting so many different parts of the kernel.


Kind regards,
Niklas=
