Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABE43A5848
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jun 2021 14:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhFMM04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Jun 2021 08:26:56 -0400
Received: from mail-db8eur05on2132.outbound.protection.outlook.com ([40.107.20.132]:62017
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231797AbhFMM0z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Jun 2021 08:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6rbY5u0z2ojUFupKLgU43MtiOgp8VDA8c2H69N6Gbc=;
 b=e30m7418fHq7CNvQdOvIkrW91kpenwZ23Fw7jhT2lPZjQies312jrTIYT/yr76kEYYJERYxWZ19fL5TIFOit8onywkLQ1KPM72Mai189eYo49iOUOX7AGZ++NUIJaDLfiNIHuQaUCNM3O9zLikmc0Aab+DStwSgh1AAcgTXzWwU=
Received: from AM6PR04MB5639.eurprd04.prod.outlook.com (2603:10a6:20b:ad::22)
 by AM7PR04MB7016.eurprd04.prod.outlook.com (2603:10a6:20b:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.30; Sun, 13 Jun
 2021 12:24:52 +0000
Received: from AM6PR04MB5639.eurprd04.prod.outlook.com
 ([fe80::91d3:83e4:d90:a710]) by AM6PR04MB5639.eurprd04.prod.outlook.com
 ([fe80::91d3:83e4:d90:a710%7]) with mapi id 15.20.4219.025; Sun, 13 Jun 2021
 12:24:52 +0000
From:   David Mozes <david.mozes@silk.us>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: futex/call -to plist_for_each_entry_safe with head=NULL
Thread-Topic: futex/call -to plist_for_each_entry_safe with head=NULL
Thread-Index: AQHXYE57zRithvFGzkuN4Iof4OaWJA==
Date:   Sun, 13 Jun 2021 12:24:52 +0000
Message-ID: <AM6PR04MB563958D1E2CA011493F4BCC8F1329@AM6PR04MB5639.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-originating-ip: [176.229.126.3]
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5ytO1qPRlvGIn6gHPpGe93pGzLBx2jZ/sFlOBQh6h9SqYyNSVNq+VkACKmAgr8D/JkP1D2Jv5K++mNjH9II60aNz5z74JqlCVebyhvevg3kTnu1S8nj9C3b3yLxQVd8VdKpykxzXivtzONbtoSB4TwLZIjB6gDNgpGRCcvGc2LWMDQBuR7qSrUguNMXsCjhNFsuhlUN2HmAOL2GtmObd5YxGa5qgBjxtr2hq3RMVRdqmBhwrtSFMgWy09DQz3sMjIETHlG7mTd2pgPINNr+HuqRrIBEPxOBojRhmbRXyG5gt0rOMrSN8TGzxS4aRCwYa1jxTvsSPXpm//GVmSkvAg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrwDOMmdQWoZT62IARco9WLPIO/GWAIfzNIgucWyzSs=;
 b=LVlbo4XQT65e+c2YjmFJVkzijF8KeC1Ja6aF6A9eXA+dYFzmXN52Dfi6m8bAXosBqf5Vd56SfJGiGN8790KMBeFIHSxvfKEaFSFv8M2bRKwXBrTkD8cPi1qzI97tJYj60ashg0IKUauBvrMeUftCzxSRyG3e4xAhjUSDbaGuvWG2mraKt8Mp+gByxlunR6xucsYNE+0hU+TohViEtoGTfUW2mjFxKAX4Eyl91NeoXV5bB/9F83b1HWGf4WGgWhovYsyLZ7VKeVhfW3s9PutlULvYS3KdSOWiR8cFyWw2hnj+Q6etzsL6D2WMITmr2jGuSDfkQlptwqdlBe9sVMhCbw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silk.us; dmarc=pass action=none header.from=silk.us; dkim=pass
 header.d=silk.us; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrwDOMmdQWoZT62IARco9WLPIO/GWAIfzNIgucWyzSs=;
 b=ozcvYLfHDmw+r3jLX/7kE1hCvSLoUTNgvBiNaUZ77hynON48LbmFJakIwP3FXHKYYgGcqGtGrHFexLG+Ci9ZwiUhtvAdrrAkgcC/mBQcI8p/r+j8Plc3p8ksROgJFdgz+lWZSOOgbPNmeS5QQZp/KDjG/gEHZxSseoyu5ELm+Qs=
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silk.us;
x-ms-office365-filtering-correlation-id: 3d96fb74-d202-4b96-001c-08d92e663ef8
x-ms-traffictypediagnostic: AM7PR04MB7016:
x-microsoft-antispam-prvs: <AM7PR04MB70168B9F871B4666621432F5F1329@AM7PR04MB7016.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5639.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(136003)(366004)(396003)(376002)(66446008)(8676002)(8936002)(9686003)(6506007)(71200400001)(37630700001)(86362001)(6916009)(38100700002)(478600001)(66946007)(55016002)(66556008)(66476007)(83380400001)(64756008)(45080400002)(26005)(5660300002)(186003)(52536014)(122000001)(44832011)(76116006)(2906002)(7696005)(33656002)(316002)(80162007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHCrA8wMEnLmNKh2O+W6z+t2dQsnV2pwXxknIFiBOQMjEdQ8pznXaoga88zl3oOAXsZ68YYGxy23o4NNqeWci+gw4oPg0EhEOgPFVKbgkPwhx/EN/A2ASjEl5TbvyUldcUppeFOFNO2EJLTsyshdHes+XpwE+/+uQUq+hQfvEHO0epoDkeaqG00PjVFIY0QFu3WE7Iqz8A/yvOe49CmbOpi9V0P03dabjFYFXzMHSW8yH9+jf4jlhr8SzkMVL1A7i7rJaKqWZ/SRaCRqrC9jTokBW7yugDtJhWtARbtXgcTsZOZSbkmOWPQuEMcXCTOT56CMUr1CJK2ZDjuuMEJJJldktpYzMQiY1/S9eB6GRkWceUsGbO0wqJHPeFCylNxSbDZ3QZ6tbgVrCdUsVZ4IDY7LnJRlvPrJvVhjDkoA1pw/GUC+fjzSChufWdGA3YYFuihpmXw2EYC76lSAGEqe6cMMaJq1pKht2Ay1zQTfb1Hi2hEgaNoMnS5LPHOzuiy9aub+CV+IzunpOyaVKsOh85e+9qSAFxTXo1cRjDF3xG0L2EMUZdBBQixMnwtY8L2YoenOy06tAg2qaecpGvb0B2d0N0QjeqNOntUwTX7XAyN2sxCiyDLq63TjhLuh3hcgrAE/6bfT0veDUVReCQyIbg==
x-ms-exchange-transport-forked: True
x-ms-exchange-crosstenant-network-message-id: 32637709-e055-433d-277d-08d92e65ca6a
x-ms-exchange-crosstenant-originalarrivaltime: 13 Jun 2021 12:21:37.0985 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: Vh48IlCS/sauq9Ahe0Zq9WUPEmJ4cOOuAy6IceOOvw+mCqqHrGHthRQcjZCyZr9lhBrmmRXZ+oFQF0JAygeIew==
x-ms-exchange-transport-crosstenantheadersstamped: AM7PR04MB7016
x-ms-exchange-crosstenant-authsource: AM6PR04MB5639.eurprd04.prod.outlook.com
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Llhdzpq8XS+KmOoBXMyt9pq4VAa6yb1JhHjQqWfnTrrrj3y4HMHmg11yf8?=
 =?iso-8859-1?Q?oRT9IpUJijpBuovZ6VrqeDnovDGB1JWnb1H5fKay+IsjHEr/I30VIuVMpL?=
 =?iso-8859-1?Q?TD/YjKf4NVC+wdGQLoQ39gxYW3Hal0TSJweiqH6fi3SA85tozvwAROEciC?=
 =?iso-8859-1?Q?gz9WrogEp+LXNPC6HYyp82Hce9VyoegeicS9r6z/uqg2bhVyxf3D8y22VU?=
 =?iso-8859-1?Q?KNPBPaCV2p6nUonfri06exEzmqGWD5sgaaa2ghbQKW6prAXUuDJsAo8IAU?=
 =?iso-8859-1?Q?Ry7NVTX1WQ/JEMRmDK6QSezqMT6sUCQW5T/F3tofdzVfBsqYWxeVb/U1ds?=
 =?iso-8859-1?Q?awtp3mExViJoQEk6r/bZnlggYoY45a5AlfObSDanWuPQ8YOHGQwSYlvE0G?=
 =?iso-8859-1?Q?8V8o1IxS5I8tc7Iw59GBzdZ/TwjoT9hgibz4HNc3pqVeZqhQxLIrJmeEki?=
 =?iso-8859-1?Q?sY+nGe8vail6VVvlk5eVl8gsUlXrkOVGMyskOj4yLUurpzRnRQQ2KKD50V?=
 =?iso-8859-1?Q?GZliI3DGxJKuQfmm6RVoU0NOR8px6SY2d8w/nUVGuwFRFcYCtUx6tH2SFI?=
 =?iso-8859-1?Q?fxZPquCIOn+2JkGKBEH6mKI5hGgmRIb6IvIb4YrGlp9SoOhLMkb4L50M8J?=
 =?iso-8859-1?Q?BfjwH2aD9xdyOYJAOTadyvoVYbSVqQWY7hybmSBi2iSBOmzZu8FPblafDY?=
 =?iso-8859-1?Q?qXZ18ZnqebboF0Q1melynsseJhu2zxQDXAD4PVXR+51aBjkIIXYhMQLMhJ?=
 =?iso-8859-1?Q?VAqLm8VLLQCa+UV0QkPSsl4NELWyH9G0tkxw5NyscOTxbmQgGd3oqPHlMK?=
 =?iso-8859-1?Q?nfq2LnWnIfYzYI+0oS8IbFCweVkfkmYBQmsM+cncL2mU9M9XGlLGMNh59L?=
 =?iso-8859-1?Q?0Vo6YJahfebscXA5y0kchOtSKfzQgCt0lJ6VgN06NTOUX73ad3iywo9KBw?=
 =?iso-8859-1?Q?IuOAfXsTbxmhpiNft1p86VesOKpf5IcsRNJc+kXpkkfOEM9aU4xYjBBWNR?=
 =?iso-8859-1?Q?Jvghe8jCRsEAyQC2AK1Yvhb/XoSUFLjVCb2AS35NVte+uTg7qbyibLxErn?=
 =?iso-8859-1?Q?Tu0KqmhxEfVMbHZRyBBroaBOGeoKcUKmDu2I6CYagm6Gp3XHEBbUumXrK4?=
 =?iso-8859-1?Q?bxoiArw4w2lKiYrWMtXeYltXvGjsG2WKnc1/rTXzq4JETdIf2L4ezmtB/R?=
 =?iso-8859-1?Q?rJ52C1C+MuCzF+rXxVFYX8UrTgtj9pX8u+ApsBmKEv+l4vXaca/EgQgquq?=
 =?iso-8859-1?Q?eXix4nK+PB7l0jcbLB/5EEh2aSiEdFeA0oiA6nE5O4C2NgGFLwF3Z16TZC?=
 =?iso-8859-1?Q?LXrnqiNR6XubICbABEKHoS1ChG5AOF9qHI+SjckChQP0dZWkdCrTCTn3gt?=
 =?iso-8859-1?Q?ZO8rbtfEla?=
x-ms-office365-filtering-correlation-id-prvs: 32637709-e055-433d-277d-08d92e65ca6a
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <30DDB4AB0E019349A68623B9F1161EF5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silk.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5639.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d96fb74-d202-4b96-001c-08d92e663ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2021 12:24:52.6328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2N/0itK6O0YLE7i3LnD0WNmimS/ReG29bZ4dSnPGR7owBAwMCR46R0xfi6H8TwOPOSTYJr2717uL4IcOq03SiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7016
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi *,
Under a very high load of io traffic, we got the below=A0 BUG trace.
We can see that:
plist_for_each_entry_safe(this, next,=A0&hb1->chain, list) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (match_futex (&this->key, =
&key1))
=A0
were called with hb1 =3D NULL at futex_wake_up function.
And there is no protection on the code regarding such a scenario.
=A0
The NULL can=A0 be geting from:
hb1 =3D hash_futex(&key1);
=A0
How can we protect against such a situation?
=A0
=A0
=A0
Deatailes below:
=A0
=A0
un 10 20:49:40 c-node04 kernel: [97562.144447] STAR4BLKS0_WORK[12672]: segf=
ault at 1aa7cba6 ip 00007f924a6bc68c sp 00007f6ca92e1b70 error 15
Jun 10 20:49:40 c-node04 kram: rpoll(0x23396f70, 24, 50) returning 0 times:=
 0, 0, 0, 2180, 0 ccount 104
Jun 10 20:49:40 c-node04 kernel: [97562.144463] BUG: unable to handle kerne=
l NULL pointer dereference at 0000000000000246
Jun 10 20:49:40 c-node04 kernel: [97562.145450] PGD 2012ee4067 P4D 2012ee40=
67 PUD 20135a0067 PMD 0
Jun 10 20:49:40 c-node04 kernel: [97562.145450] Oops: 0000 [#1] SMP
Jun 10 20:49:40 c-node04 kernel: [97562.145450] CPU: 36 PID: 12668 Comm: ST=
AR4BLKS0_WORK Kdump: loaded Tainted: G=A0=A0=A0=A0=A0=A0=A0 W=A0 OE=A0=A0=
=A0=A0 4.19.149-KM6 #1
Jun 10 20:49:40 c-node04 kram: rpoll(0x7fe624135b90, 85, 50) returning 0 ti=
mes: 0, 0, 0, 2203, 0 ccount 42
Jun 10 20:49:40 c-node04 kernel: [97562.145450] Hardware name: Microsoft Co=
rporation Virtual Machine/Virtual Machine, BIOS 090008=A0 12/07/2018
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RIP: 0010:do_futex+0xdf/0xa=
90
Jun 10 20:49:40 c-node04 kernel: [97562.145450] Code: 08 4c 8d 6d 08 48 8b =
3a 48 8d 72 e8 49 39 d5 4c 8d 67 e8 0f 84 89 00 00 00 31 c0 44 89 3c 24 41 =
89 df 44 89 f3 41 89 c6 eb 16 <49> 8b 7c
24 18 49 8d 54 24 18 4c 89 e6 4c 39 ea 4c 8d 67 e8 74 58
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RSP: 0018:ffff97f6ea8bbdf0 =
EFLAGS: 00010283
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RAX: 00007f6db1a5d000 RBX: =
0000000000000001 RCX: ffffa5530c5f0140
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RDX: ffff97f6e4287d58 RSI: =
ffff97f6e4287d40=A0RDI: 0000000000000246
Jun 10 20:49:40 c-node04 kram: rpoll(0x7fe62414a860, 2, 50) returning 0 tim=
es: 0, 0, 0, 2191, 0 ccount 277
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RBP: ffffa5530c5bd580 R08: =
00007f6db1a5d9c0 R09: 0000000000000001
Jun 10 20:49:40 c-node04 kernel: [97562.145450] R10: 0000000004000001 R11: =
0000000000000000 R12: 000000000000022e
Jun 10 20:49:40 c-node04 kernel: [97562.145450] R13: ffffa5530c5bd588 R14: =
0000000000000000 R15: 0000000000000000
Jun 10 20:49:40 c-node04 kernel: [97562.145450] FS:=A0 00007f6cab2e6700(000=
0) GS:ffff98339f500000(0000) knlGS:0000000000000000
Jun 10 20:49:40 c-node04 kernel: [97562.145450] CS:=A0 0010 DS: 0000 ES: 00=
00 CR0: 0000000080050033
Jun 10 20:49:40 c-node04 kernel: [97562.145450] CR2: 0000000000000246 CR3: =
00000020168d3003 CR4: 00000000003606e0
Jun 10 20:49:40 c-node04 kernel: [97562.145450] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Jun 10 20:49:40 c-node04 kernel: [97562.145450] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Jun 10 20:49:40 c-node04 kernel: [97562.145450] Call Trace:
Jun 10 20:49:40 c-node04 kernel: [97562.145450]=A0 ? plist_add+0xc1/0xf0
Jun 10 20:49:40 c-node04 kernel: [97562.145450]=A0 __x64_sys_futex+0x143/0x=
1
Jun 10 20:49:40 c-node04 kernel: [97562.145450]=A0 do_syscall_64+0x59/0x1b0
Jun 10 20:49:40 c-node04 kernel: [97562.145450]=A0 ? prepare_exit_to_usermo=
de+0x70/0x90
Jun 10 20:49:40 c-node04 kram: rpoll(0x233a2b50, 1, 50) returning 0 times: =
0, 0, 0, 2177, 0 ccount 277
Jun 10 20:49:40 c-node04 kernel: [97562.145450]=A0 entry_SYSCALL_64_after_h=
wframe+0x44/0xa9
Jun 10 20:49:40 c-node04 kram: rpoll(0x7f914813d480, 90, 50) returning 0 ti=
mes: 0, 0, 0, 2166, 0 ccount 35
Jun 10 20:49:40 c-node04 kernel: [97562.145450] RIP: 0033:0x7f924a6bcf28
Jun 10 20:49:40 c-node04 kernel: [97562.145450] Code: 74 1a 49 8b 48 20 44 =
8b 59 10 41 83 e3 30 41 83 fb 20 74 21 64 0b 34 25 48 00 00 00 41 ba 01 00 =
00 00 41 b9 01 00 00 04 0f 05 <48> 3d 01 f0 ff ff 73 1f 31 c0 c3 be 8c 00 0=
0 00 49 89 c8 4d 31 d2
=A0
=A0
=A0
RIP: 0010:do_futex+0xdf/0xa90
=A0
0xffffffff81138eff is in do_futex (kernel/futex.c:1748).
1743=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 put_futex_key(&key1);
1744=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cond_resched();
1745=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto retry;
1746=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
1747=A0=A0=A0=A0=A0=A0
1748=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 plis=
t_for_each_entry_safe(this, next, &hb1->chain, list) {
1749=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (match_futex (&this->key, =
&key1)) {
1750=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if (this->pi_state || this->rt_waiter) {
1751=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D =
-EINVAL;
1752=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out=
_unlock;
(gdb)
=A0
=A0
=A0
plist_for_each_entry_safe(this, next, &hb1->chain, list) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (match_futex (&this->key, =
&key1)) {
=A0
=A0
=A0
=A0
This happened in kernel=A0 4.19.149 running on Azure vm
=A0
=A0
Thx
David
Reply=20
Forward=20
MO

