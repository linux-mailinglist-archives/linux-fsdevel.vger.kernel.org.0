Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BA44CB5E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 05:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiCCEcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 23:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiCCEcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 23:32:47 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F3FC7E7F;
        Wed,  2 Mar 2022 20:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646281921; x=1677817921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yxDwgTAwUA3v3OqN6DcxiVtIdLLCpR4ieWx2QucnyWs=;
  b=ixDofmU97EAF4thy8cwtEAj7LvjLJmugF0+aE5LgzYyK7eBTbnb0UKK9
   2AlnF9UqBpeGikW3J1QiSfA81gEX3BosQWOCjnS08xAFndMUdpl4u5blG
   cIpaOkGxFt3+taZgqU4zuhF8S6sMsbHLLUeWMUOLft+lcpC4EpnV4z9c0
   RriEllPbgwOXMXo11aHR1zDULiK5nt1rxMAUefKeFXJuimTlPFSYXtNJb
   HvRDIYTIP2TFFswh2TUocAHLChjUPOr1EaV5oMMgZlH2kHzVS8jBeMig4
   IenN+YDYhbQdmDyVdTc3u/DAmeoO+A7ldr0my3up2gsOf44OjDs1AufYZ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="194351667"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 12:31:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBE3LmAol5Uw6xoqMV/LFLwsq98u1CtSXlaN8ROnr9yy3qtm+o0nfy9g4XSwdtHlwOIZtT8o9YnALWLrdSdx7lau1lAh6kZs1vsQ88+UzOhb1YuifPkpvwyW0lREw+A3NzhWFM0qeuFmTUdVppeoURPk7mo2qs0ygxKE0TqeXBaFYk6TOQxxrCEPYkp/seyW7MTIoBmXWVHAMklwuIcJ/nn1+/kKQMgzp+ERlxYXWIT44p87YhbKJj9snVe1gTUPG5LuX4dQ2jNrItp8Ya1g9HR5ypDipsidk4weZ0Y9IphdRpVBBvozxIIGwZph7PeF22Od4ltFVcQzfZGJiY1MzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxDwgTAwUA3v3OqN6DcxiVtIdLLCpR4ieWx2QucnyWs=;
 b=cNLypD8ltTqTdWBcOFgMkKHxONaAeCJsIIxAkGZHYXub0l6e6SlDoDxrFXKu8/mhgVp135TVjOUGoM4Zaspj1cJ2mocnuKg5pim0okpVIaKiR2Lk8Ebb9OX0HRhOXPV55Su/WbdrNKVJDTgl9YP4wTt/UuUQFD+WH1VxA7Y18LKYbEkewj75feBGztsocODchDoIe/LKEPocYL5AqvSBSf5j7IVjkW7ebG25TJSE6Sb6PhkUpOtsCLu3ifMfGGSjkXpjRjWeBioG1UpL9XSl2uYB+sDCRNGBbEhuTl+fQd2F7nOe1IpUOXd9Gm/GPmaIqO4r1+Tm0pu3juv7aSOm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxDwgTAwUA3v3OqN6DcxiVtIdLLCpR4ieWx2QucnyWs=;
 b=u5Fh9GVl05wvY+7Evd8EYHuk3PfExAWEZn44oQnLUpElsiEIi+A28dJo9j2Xdeo/dO2/zpa/5EIrvDDj3cYQIKp9Zf+xGycdhDdQ1aMV2G13XV7jhjSO4sSSw18jB4XEQXsS0LEgH0RtQkkvVzksrSzTB/FTkrW7fcQkcy2jSyE=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by BN6PR04MB3730.namprd04.prod.outlook.com (2603:10b6:404:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 04:31:58 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 04:31:58 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: RE: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmotDjh/nK/9UCnXW/KPy7zfqys4B4AgAAxXvA=
Date:   Thu, 3 Mar 2022 04:31:58 +0000
Message-ID: <BYAPR04MB496825C09F9428D725E9F712F1049@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <a1efd5b0-f64a-9170-61e3-e723d44aa04f@acm.org>
In-Reply-To: <a1efd5b0-f64a-9170-61e3-e723d44aa04f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09f18593-5a64-4afc-cabe-08d9fccec11f
x-ms-traffictypediagnostic: BN6PR04MB3730:EE_
x-microsoft-antispam-prvs: <BN6PR04MB37305E19006E922A01C1BEE3F1049@BN6PR04MB3730.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jT9GMURX0sm4hEJNJO6kGpBMPWQNsh2SM/BI06g3mX/RWFXM467L6diuUyzx25jGk8s9He2pnOFHb3sgTzXEt6+gug7B02aHQggVXuJPNgtldNM7cUij71zETRzmqwrE1yAqDO5kNF2kzPo3VmAyqTlLguv0qKvXSVhY0jfskioa1A3Tc+RRNF3XO8FqrJR3aUcdE4diV7Pj6cMlcqrlZlMzHNyQ0gQoDu/IPGWPwtfULbZiXAmoKfVssIL/Bnio/ysKw5sMjWkJ58A5SulBwdMt9tPn0i8HykgHDHiwlu+2vFOjkalMCuRdpVZwZgDixov58QubyYGnsVqjoEGdTFg/W0rbm6GJtF6EffXyom0fR9OLvVdI/+YfYsj+s7K9mNF39s/c3gsfA8UC9Bw8wsr7vwSvLn3fCf/S8r5DwAZdcTALoZooqsKit7hjWX9VnfOjwp1O4f5n/7BW+HNal19hdYraZfSb5WnUPy64JXH0jVIw5K/saJ3Ew0xKY30VcFwTd+jXTY3Eh1JzTZ2CWf60R2FiXl10Li0VksQm7UdBNRzpKsD+INTlOXokVFPyPCUXu9e6ZlHWLvZdY/o3Lo23/QncRuxNmwSp+iX8AYdcvASdQYZnZ3P+FbWcU7EPkaKj0V9LNXgoQIAWQyc8iT93vpxLWmSca07K3ajZkFLxfx3HOF9y+cLRA6egf4eI8/Q4IMwn5xDZhYxwPZcQoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(316002)(8936002)(8676002)(64756008)(66446008)(66476007)(52536014)(4326008)(83380400001)(85202003)(55016003)(54906003)(26005)(110136005)(86362001)(38070700005)(5660300002)(7416002)(85182001)(508600001)(66556008)(66946007)(76116006)(122000001)(82960400001)(7696005)(2906002)(9686003)(53546011)(6506007)(38100700002)(186003)(33656002)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnA3cmI3KzRSWmxlK2pLdjZ1MERPRGsxdUNhWkFUbjJjb3BBbldCQzVENUxh?=
 =?utf-8?B?V3E2aEgvK2JuQVNVMUhsU0NMNGFxTGtjc0dzeXZpeDVrUDlhak5MWHZIOTlI?=
 =?utf-8?B?TFRDblcxSXhKcExGeU91MVFydklGNHZXUzYvaS83Q0hZR3A5TlptcG9vYWtM?=
 =?utf-8?B?SEs3VGRKR0s4RHVsTzhuWDRpSVNPZFU4WlNYOTY2d1laQ0hSSXI0b05MWUpl?=
 =?utf-8?B?NE9ZSEpFUnVEQzNUNUtFQXhIR3JWQmx2Z0VVTi9udkd0WG8xQXIrd01MTWVM?=
 =?utf-8?B?NzJSV24xYXA3MERBN2w2dVNrODdaRFVvZUl4QzRZOW13UUZrbjJjYis5dDM4?=
 =?utf-8?B?K3l6OUVzbzRkL3Ivb3NTMzk4c1JBVktDbC9kS3RUTm9OOGY3M0FtSXV1cWFZ?=
 =?utf-8?B?SlFMRmwzZmZEcjNpZXF2TjB1Qi9scEVWZzNnTzdXVTFydkRid3ZFNWJtRFJa?=
 =?utf-8?B?U21lc0hRY0RGWGJ0WEgrZlQ1UHFoOUZCWU5KVHZ2Qjc1TTFDSjcybksvV2hC?=
 =?utf-8?B?UjN4d3V1UEZaYnkwNUEwV0tZTHo3NzBQdDlhQ3dLeUJ5MnltVGRocjJMUkJB?=
 =?utf-8?B?RU5WcnpQR1VRWEw5QkozaVV4eERtMWRkd2RwRUVoYm5mTEwzMXBrUHIxSWdK?=
 =?utf-8?B?Q0VZcEhpMnVHK0tvVThMVEMveDZYanJXNFoxM0YrM3F3NHVJb1JxbzBoc1ov?=
 =?utf-8?B?eUpDS1VWNmxGVE9IZnRBS1VlYlJJdGxMSzBuTGRKR3QxSS9oWis1VlEwaDUw?=
 =?utf-8?B?NmZnbHFibnVKOWg3cEVubGpucnFVSEIrbnEwZzVBL0lETkR4SlAwbmY3eVRF?=
 =?utf-8?B?QW5IY1VXUi9mbW1MbFA1ZFU2WkVHK05FQ3BmZkFvYkV3TE5TTHVNTktDR3hH?=
 =?utf-8?B?UXdnQWptVGtZRU1INW1zeEp3Ny9iNjF5djJsbGFLNUFYU2RpYXp6WC9PckdS?=
 =?utf-8?B?YUJTOFpxRmF4cDlaSDNIY1V2czBoT2szV3V4U2FTaXd3eXdpdnVEbERyeVow?=
 =?utf-8?B?QVAyQ1JDT2JQVklDNWt1aDN6VHNrcTE5VHo3V1ltMzNPYVY5SzBpdmdjUUtH?=
 =?utf-8?B?MHpnNXpmUnp5akpYeWpwZk9IZjU3K29GaU1KVVJqVVNkalVYY2FaUTcvVE10?=
 =?utf-8?B?RTB0QmNGMXRzcVYzcDJVZ2s1K013WUtEZFRObkdUM2dhaktQamVrQkFYZXdV?=
 =?utf-8?B?QUlBNCtpVE02SElnTVVvSFlZSHBpSDJ1eGkweDFyREF1VUI0bys3aGZPYnNi?=
 =?utf-8?B?NVpEY21tZ3FITHBJTjBPZ2VtaHBmRk1uSzgvTnVHeUVnRHNSK0pVb1JXZm9I?=
 =?utf-8?B?Y1lreUNPYTZSSkxleU4wdm5TS2NxVnVLRjhSaU1jcHRLRzdmaUM2V20xRTRk?=
 =?utf-8?B?OUtLK3RySmRReHUyOFMvbzd6YmRnT2tYOGlMNTJ3RXVTYzh2MjNLRGNSMUxF?=
 =?utf-8?B?bmdrZ0p5MlNMWlh2dkp3dU1lOXA0Y1d5NDhNUTFma2lzLzNubGtFZFBVMVdT?=
 =?utf-8?B?aW9oNzREbGk3dkNoRkJsaElXTzdlb1owT3hTN1pXZm1CZ2tvaUQ1TDdjcWFi?=
 =?utf-8?B?b1Nnd2FsMzAyck1nVC9vQnZFNXA5Yll4aXBzK3Z3eHBoeWhWRUMxMzhXMFZM?=
 =?utf-8?B?c0NDU2t5OTg4Z3hNZFlqbEptYVVqeGRaSU9EekJ0N1FTaXI4cW5pQkYzM3RR?=
 =?utf-8?B?NGc3dUc3WXpiM2tOUXYrcGJzUEFadGZvTTBNS2J1eHF2bDhIREZ0eVpYM0VK?=
 =?utf-8?B?YWxpeHBDdWVwSTFuQkN2bll6enJaZkhwcVZjb1dDNnNpMzcySExpdHdMN2lZ?=
 =?utf-8?B?SmJOYVN0cW42cUk4cW1taFN2T0dUQ01YVDd4Ymw0ZW5DdllmL3JtalBrT1Q2?=
 =?utf-8?B?OUNVREVaQzYyaUtkeHlRL1VIQUorcC9iL25LdjF5dElvOFpUME9kb3FRUXRL?=
 =?utf-8?B?bG9ZRFRGeEk4ektVMk5sTXk1bk1mWndYcEdROVRma0FyV3BMVytZdk8yNmRN?=
 =?utf-8?B?a2MrS0kxR0pOcFJYVFZwaFgrRXdNc3U2aXBIWVFSZDllUit5TTlnSU9yQkRr?=
 =?utf-8?B?bnd4YVhMbW92cmhDOThFNno3TU82czRaWTdvK25jS3JkN2dIRFhZOGtNM1Mw?=
 =?utf-8?B?L3JMUVVPOWgxVHp6b0pCOHRNYlhaNTJPS1ZzU08zVGNCc1U5cDRSOEk3SEVT?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f18593-5a64-4afc-cabe-08d9fccec11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 04:31:58.2090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgV2uyO5EK1c1vIliR1cuvPM+asJAErB/8H6LCHakL/YOwpRFZSV46U3Qmz//+Kz70m3DDImM/yJ0esE2A/AUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB3730
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

R29vZCBpZGVhIHRvIGJyaW5nIHVwIHpvbmVkIHN0b3JhZ2UgdG9waWNzLiBJJ2QgbGlrZSB0byBw
YXJ0aWNpcGF0ZSBhcyB3ZWxsLg0KDQpCZXN0LCBNYXRpYXMNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPiANClNl
bnQ6IFRodXJzZGF5LCAzIE1hcmNoIDIwMjIgMDIuMzMNClRvOiBMdWlzIENoYW1iZXJsYWluIDxt
Y2dyb2ZAa2VybmVsLm9yZz47IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsgbGludXgtZnNk
ZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxzZi1wY0BsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0K
Q2M6IE1hdGlhcyBCasO4cmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPjsgSmF2aWVyIEdv
bnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+OyBEYW1pZW4gTGUgTW9hbCA8RGFtaWVu
LkxlTW9hbEB3ZGMuY29tPjsgQWRhbSBNYW56YW5hcmVzIDxhLm1hbnphbmFyZXNAc2Ftc3VuZy5j
b20+OyBLZWl0aCBCdXNjaCA8S2VpdGguQnVzY2hAd2RjLmNvbT47IEpvaGFubmVzIFRodW1zaGly
biA8Sm9oYW5uZXMuVGh1bXNoaXJuQHdkYy5jb20+OyBOYW9oaXJvIEFvdGEgPE5hb2hpcm8uQW90
YUB3ZGMuY29tPjsgUGFua2FqIFJhZ2hhdiA8cGFua3lkZXY4QGdtYWlsLmNvbT47IEthbmNoYW4g
Sm9zaGkgPGpvc2hpLmtAc2Ftc3VuZy5jb20+OyBOaXRlc2ggU2hldHR5IDxuai5zaGV0dHlAc2Ft
c3VuZy5jb20+DQpTdWJqZWN0OiBSZTogW0xTRi9NTS9CUEYgQm9GXSBCb0YgZm9yIFpvbmVkIFN0
b3JhZ2UNCg0KT24gMy8yLzIyIDE2OjU2LCBMdWlzIENoYW1iZXJsYWluIHdyb3RlOg0KPiBUaGlu
a2luZyBwcm9hY3RpdmVseSBhYm91dCBMU0ZNTSwgcmVnYXJkaW5nIGp1c3QgWm9uZSBzdG9yYWdl
Li4NCj4gDQo+IEknZCBsaWtlIHRvIHByb3Bvc2UgYSBCb0YgZm9yIFpvbmVkIFN0b3JhZ2UuIFRo
ZSBwb2ludCBvZiBpdCBpcyB0byANCj4gYWRkcmVzcyB0aGUgZXhpc3RpbmcgcG9pbnQgcG9pbnRz
IHdlIGhhdmUgYW5kIHRha2UgYWR2YW50YWdlIG9mIGhhdmluZyANCj4gZm9sa3MgaW4gdGhlIHJv
b20gd2UgY2FuIGxpa2VseSBzZXR0bGUgb24gdGhpbmdzIGZhc3RlciB3aGljaCANCj4gb3RoZXJ3
aXNlIHdvdWxkIHRha2UgeWVhcnMuDQo+IA0KPiBJJ2xsIHRocm93IGF0IGxlYXN0IG9uZSB0b3Bp
YyBvdXQ6DQo+IA0KPiAgICAqIFJhdyBhY2Nlc3MgZm9yIHpvbmUgYXBwZW5kIGZvciBtaWNyb2Jl
bmNobWFya3M6DQo+ICAgIAktIGFyZSB3ZSByZWFsbHkgaGFwcHkgd2l0aCB0aGUgc3RhdHVzIHF1
bz8NCj4gCS0gaWYgbm90IHdoYXQgb3V0bGV0cyBkbyB3ZSBoYXZlPw0KPiANCj4gSSB0aGluayB0
aGUgbnZtZSBwYXNzdGhyb2doIHN0dWZmIGRlc2VydmVzIGl0J3Mgb3duIHNoYXJlZCBkaXNjdXNz
aW9uIA0KPiB0aG91Z2ggYW5kIHNob3VsZCBub3QgbWFrZSBpdCBwYXJ0IG9mIHRoZSBCb0YuDQoN
ClNpbmNlIEknbSB3b3JraW5nIG9uIHpvbmVkIHN0b3JhZ2UgSSdkIGxpa2UgdG8gcGFydGljaXBh
dGUuDQoNClRoYW5rcywNCg0KQmFydC4NCg==
