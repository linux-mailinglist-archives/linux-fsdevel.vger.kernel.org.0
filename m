Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512212C8A4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 18:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgK3RBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 12:01:01 -0500
Received: from mail-dm6nam12on2137.outbound.protection.outlook.com ([40.107.243.137]:1153
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729021AbgK3RBA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:01:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9LsFEjem0DQD1yGyYzrM80Zyq+VEJJnxE6KJ6M9zSPggYOa5U5tXUw+mkHG/aeqy/51p1HEBEL4NL8lUmW4LwPswScwxXwej0Q4Okix3OgIQ3xWIIVEinczRqtqDJ2J5702rawtvjcfvIUG0Uu8s7kFyLD0v0hAPXeTttz6Gk41Mm+Vw6UAlz6eQMeBuBFwf5nbtUlyLoWwcnn1K9u4x0Q9oRl6YJCbpowofd6oGbtti9Qy13UfdX8bxYE02XHiV8YcdOKf2DGUT/ZeNqIHna2rhLnsjy+XpU/digRTg5ysykqJPOVQqB8CbzFie0V8b0uQSezjBS6xZqVOQUHOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLzegxlCuYneC8sKRz/B4U+mGUHHAI2W0mT89AJpRe4=;
 b=JH8Y8F2JBnEFneZp7f0DQ91n0KJnxV6B3O1Q+hMvyexwDTMgR8aE2q+IgYL624ZiBedODPglMGzqQvS+iYanr7FfGvaYSxZN0OZOfMGZd4LcpDDJi3QALAekBYluAgZyxs4uUdCBrn2bcQQLrkpA945jKnbcQzqRBwY34lKmUUHKukpNGVV5hn7+XD2hXaI7UEXTTE15TV8BSHnyGGtfHn6uc6SoeWMjzSL3r3yLeEokhLJghgIPNXHzqpL49cGY+nB6/PGCuACt70w5KFgruflBIwQWXVwrqRfhy4I8/glURZRtD0M6gBvq8pueNtyYfTK3uouvgTKAuinDLNTc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLzegxlCuYneC8sKRz/B4U+mGUHHAI2W0mT89AJpRe4=;
 b=LvBC6vxXpq3UWyVSsUK+L1HdFHF5m/9kgsD6Fq77ddHj07Ek9w4uqcUpFzSGevXyLKOGJtNtBMTqb2NhuYy72Eivo5O0BQgy+USChw7aUlXGiq88Zn9F/ijSGi77NSe8MHWEWXLVXq9FeFotbFtBFkAYc/ABXIZml60SX/kWvbE=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB2008.namprd22.prod.outlook.com (2603:10b6:610:89::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 17:00:10 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::1922:c660:f2f4:50fa]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::1922:c660:f2f4:50fa%7]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 17:00:09 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [Race] data race between do_mpage_readpage() and set_blocksize()
Thread-Topic: [Race] data race between do_mpage_readpage() and set_blocksize()
Thread-Index: AQHWxy9U/ajGeIEB3kqdC5UENrlwAang2FUAgAACiACAAAtJgA==
Date:   Mon, 30 Nov 2020 17:00:09 +0000
Message-ID: <400CBCF4-E0DA-4DDC-98AC-F0849E59FDF5@purdue.edu>
References: <A57702D8-5E3E-401B-8010-C86901DD5D61@purdue.edu>
 <20201130161042.GD4327@casper.infradead.org>
 <20201130161946.GA30124@infradead.org>
In-Reply-To: <20201130161946.GA30124@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9de75488-52a2-4608-37fa-08d895516571
x-ms-traffictypediagnostic: CH2PR22MB2008:
x-microsoft-antispam-prvs: <CH2PR22MB2008DB4378AE96AFF6E02B2EDFF50@CH2PR22MB2008.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eiXZGwJJO8rOAvrI7/DLKT382usM05rSFfyK4aUGrm9CleE/a3BAkBtWtbr+DUN9zf64/YfJiAckNdMJ94O/t65CoNHLpu/Qog6EB+TNg4k4/3VAQ2cVXX6Ueuybp2newnHawCsBhzImAocOn0QLN12c/XnHSvoRU9nKf7egZhNp6KCOgJJLkHo0TOTaV2PBC8PBD6VvurNfUZm15frSjnG1wxAl7NwQ0R9c/7+L2VRNcZAeFoTjFzll/fimPSAaG8t2fBqRoz/xVMhfrHvm6GLUBXJi4EQl/bcIyruVCYXJZw/JbnGGPgOWB0dtNbi35tzzBV2ikQWp0b3hPhpUVCk6NwprVV2F7fEXplRWAdGUttx+UpH4PDYG9Z3YHHE/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(39860400002)(136003)(8936002)(64756008)(26005)(186003)(53546011)(8676002)(2616005)(2906002)(66556008)(66476007)(5660300002)(6506007)(83380400001)(66446008)(76116006)(66946007)(36756003)(30864003)(6486002)(6916009)(4326008)(86362001)(6512007)(54906003)(786003)(478600001)(316002)(75432002)(71200400001)(33656002)(376954003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?J71ID8Z+A/6bRh6ta2Gk2QnqJIh+BX3NJm9oP0yyYU0ADfEoYieyxHC3yYM8?=
 =?us-ascii?Q?h6eNTm6rcqkmMGSBI3rEZjmUkm5XxrJJgkvOJI4dniSPS+rmkHYIPTbYGpm7?=
 =?us-ascii?Q?L45qKmN0DuX4Z/65qd2Yg2kpzw7+8i87NluvDH74kl/SwMcoCQ2YTb+u3IMH?=
 =?us-ascii?Q?7gRiUzkEZogkMMaOCOFs1o79XgRitSe0E5FeYh/mE1uoWX9/X7VI3zO47u9D?=
 =?us-ascii?Q?5C1m4uv7vxK5JJ0bH05Zre70TFj5wihqEBZlSU1Od3qk+uPtYVuZwEp5OAs2?=
 =?us-ascii?Q?+dZtitkra84AXLHxdEh8i1RJtssyRGo8mV8M0bN4XD4J6qhRCZF8J/Prr0pq?=
 =?us-ascii?Q?Td4wMZNBCdZudClpuEjUzWFB63f/6pjT/mI0egDoBUsTGkH1foubnBwB4KwZ?=
 =?us-ascii?Q?ljOh4ipsyI46DOld92lmo/uG+aOh3Lt0z6PuRqy+TC5c9b2BG5JnOYB6tkNB?=
 =?us-ascii?Q?9cBPwrJpHp7TmUfs+3Tkgh9MX/O/L4TVwLrOqrdgUN8PLGb3lT6S+Zp4IeKC?=
 =?us-ascii?Q?gThjmzXoYawnvRH1lMvyxtdcFuqYEnPTQ3E3fzRF2mL5PYUt0ZH7fTJC9X/Q?=
 =?us-ascii?Q?5F7OiV6HnEpflrAS7zxssNn+n27WINYCYJRlq+ClPQ1E6cUEkOVXAoOFj0vW?=
 =?us-ascii?Q?AAUWBOoLTTmgzilKvac2R1IVVsN0xUduYGkly3mcjpMK+anSZd2zt13b3Qm0?=
 =?us-ascii?Q?UFGTFM/6+FFXz64DlIgKeHgPzdDcOvM2SgETpfs2ymFnsJNuNwAtIWrFPACW?=
 =?us-ascii?Q?cgcuT0cCF2yNq6fYGkZiHNbfmXGfLrKgrOZ0TmV6+EJZtI+nK2ifi45pmTCb?=
 =?us-ascii?Q?2ipz8cIjDtfk9Q4Ly1srIaiBjmd6IXX7qBIFypscJEpPqsRBZH4GGnFcgm4C?=
 =?us-ascii?Q?HJtmh6h208lsqmfPVMcQbrKaBiJuEKgsPRmpp0r/t0fB2TYd/7vbGoet8P3t?=
 =?us-ascii?Q?z+wQyyDRaJlFGExa9FtBTzGn0ZhoLjAUJyg8UZkx570y++V1LizNOjVUln60?=
 =?us-ascii?Q?IlWd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A6C7CE792531B4C89EAC42B48DD8ACB@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de75488-52a2-4608-37fa-08d895516571
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 17:00:09.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvrHVe7r+4uZhXZlHsP6WLKjMa8lcYAhoeAeAq7Eh/Wnsbd9YxVO+POzT34XF/OTkARzemfSAR3rn0oyVfyL/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB2008
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We describe our reproducing workflow as following:

- Test input
We run 2 kernel test inputs in 2 kernel threads concurrently. They are gene=
rated by Syzkaller and attached below.

- Schedule execution
To schedule the execution of 2 threads, we leverage an academic research to=
ol called SKI.
In general, we added a big big delay after the read access from do_mpage_re=
adpage() happens and then we monitor if the write access from set_blocksize=
()  also hits the same memory resource.


Test input 1
r0 =3D socket$inet6_udplite(0xa, 0x2, 0x88)
sendmmsg$inet6(r0, &(0x7f0000000980)=3D[{{&(0x7f0000000100)=3D{0xa, 0x4e23,=
 0x0, @dev}, 0x1c, &(0x7f0000000880)=3D[{&(0x7f0000000140)=3D'.', 0x1}, {&(=
0x7f0000000200)=3D"18", 0x1}], 0x2, &(0x7f0000000940)=3D[@flowinfo=3D{{0x14=
, 0x29, 0xb, 0x85e}}], 0x18}}], 0x1, 0x0)
sishuai@rssys-server:/data1/sishuai/experiment/test/corpus/test$ cat 14044
syz_mount_image$ext4(&(0x7f0000000000)=3D'ext4\x00', &(0x7f0000000100)=3D'.=
/file0\x00', 0x100000, 0x19, &(0x7f0000000200)=3D[{&(0x7f0000010000)=3D"200=
000000002000019000000900100000f00000000000000010000000500000000000400004000=
0020000000dbf4655fdbf4655f0100ffff53ef010001000000daf4655f00000000000000000=
1000000000000000b0000000001000018000000c28500002b02000000000000000000000000=
00000000000073797a6b616c6c6572000000000000002f746d702f73797a2d696d616765676=
56e32323330373039383000"/192, 0xc0, 0x400}, {&(0x7f0000010100)=3D"000000000=
000000000000000e8f7d2e8feeb4bf889ba053b02420ff8010040000c00000000000000daf4=
655f00"/64, 0x40, 0x4e0}, {&(0x7f0000010200)=3D"000000000000000000000000000=
000000000000000000000000000002000200001000000000005004000000000000000000000=
00000000004300000000000000", 0x40, 0x540}, {&(0x7f0000010300)=3D"0200000003=
0000000400000019000f0003000400"/32, 0x20, 0x800}, {&(0x7f0000010400)=3D"7f0=
00000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffff0100ffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
ffffffffffffff0000000000000000daf4655fdaf4655fdaf4655f00"/4128, 0x1020, 0x1=
000}, {&(0x7f0000011500)=3D"ed41000000080000daf4655fdbf4655fdbf4655f0000000=
0000004004000000000000800050000000af301000400000000000000000000000100000010=
000000", 0x40, 0x2100}, {&(0x7f0000011600)=3D"20000000641e8ebf641e8ebf00000=
000daf4655f00"/32, 0x20, 0x2180}, {&(0x7f0000011700)=3D"8081000000601020daf=
4655fdaf4655fdaf4655f000000000000010040000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000300000000000000000000000000000000000000000000000000000000000=
00000000000020000000000000000000000000000000daf4655f00"/160, 0xa0, 0x2600},=
 {&(0x7f0000011800)=3D"c041000000380000daf4655fdaf4655fdaf4655f000000000000=
02004000000000000800000000000af30100040000000000000000000000070000002000000=
0", 0x40, 0x2a00}, {&(0x7f0000011900)=3D"20000000000000000000000000000000da=
f4655f000000000000000000000000000002ea00"/64, 0x40, 0x2a80}, {&(0x7f0000011=
a00)=3D"ed4100003c000000dbf4655fdbf4655fdbf4655f000000000000020000000000000=
0001003000000020000000d0000001000050166696c65300000000e0000002800050766696c=
6531000000000000000000000000000000000000000000000000000000904a5ec2000000000=
00000000000000000000000000000000000000020000000641e8ebf641e8ebf641e8ebfdbf4=
655f641e8ebf0000000000000000000002ea040700000000000000000000000000006461746=
10000000000000000", 0xc0, 0x2b00}, {&(0x7f0000011b00)=3D"ed8100001a040000db=
f4655fdbf4655fdbf4655f00000000000001004000000000000800010000000af3010004000=
000000000000000000001000000500000000000000000000000000000000000000000000000=
0000000000000000000000000000000046b58a6000000000000000000000000000000000000=
000000000000020000000641e8ebf641e8ebf641e8ebfdbf4655f641e8ebf00000000000000=
00", 0xa0, 0x2c00}, {&(0x7f0000011c00)=3D"ffa1000026000000dbf4655fdbf4655fd=
bf4655f00000000000001000000000000000000010000002f746d702f73797a2d696d616765=
67656e3232333037303938302f66696c65302f66696c6530000000000000000000000000000=
0000000000000000029d1c2e100000000000000000000000000000000000000000000000020=
000000641e8ebf641e8ebf641e8ebfdbf4655f641e8ebf0000000000000000", 0xa0, 0x2d=
00}, {&(0x7f0000011d00)=3D"ed8100000a000000dbf4655fdbf4655fdbf4655f00000000=
0000010000000000000000100100000073797a6b616c6c65727300000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00bae0739c00000000000000000000000000000000000000000000000020000000641e8ebf6=
41e8ebf641e8ebfdbf4655f641e8ebf0000000000000000000002ea04070000000000000000=
0000000000006461746106015400000000000600000000000000786174747231000006014c0=
000000000060000000000000078617474723200000000000000000000786174747232000078=
61747472310000ed81000028230000dbf4655fdbf4655fdbf4655f000000000000020040000=
00000000800010000000af30100040000000000000000000000050000006000000000000000=
00000000000000000000000000000000000000000000000000000000000000005162155f000=
00000000000000000000000000000000000000000000020000000641e8ebf641e8ebf641e8e=
bfdbf4655f641e8ebf0000000000000000", 0x1a0, 0x2e00}, {&(0x7f0000011f00)=3D"=
ed81000064000000dbf4655fdbf4655fdbf4655f00000000000001000000000000000010010=
0000073797a6b616c6c657273797a6b616c6c657273797a6b616c6c657273797a6b616c6c65=
7273797a6b616c6c657273797a6b616c6c657273797a6b616cb822423400000000000000000=
000000000000000000000000000000020000000641e8ebf641e8ebf641e8ebfdbf4655f641e=
8ebf0000000000000000000002ea04073400000000002800000000000000646174610000000=
0000000000000000000000000000000000000000000000000000000006c657273797a6b616c=
6c657273797a6b616c6c657273797a6b616c6c657273797a6b616c6c657273", 0x100, 0x3=
000}, {&(0x7f0000012000)=3D"020000000c0001022e000000020000000c0002022e2e000=
00b00000014000a026c6f73742b666f756e6400000c0000001000050266696c65300000000f=
0000001000050166696c6531000000100000001000050166696c65320000001000000010000=
50166696c6533000000110000009407090166696c652e636f6c64000000", 0x80, 0x8000}=
, {&(0x7f0000012100)=3D"0b0000000c0001022e000000020000000c0002022e2e0000000=
00000e8070000", 0x20, 0x10000}, {&(0x7f0000012200)=3D'\x00\x00\x00\x00\x00\=
b\x00'/32, 0x20, 0x10800}, {&(0x7f0000012300)=3D'\x00\x00\x00\x00\x00\b\x00=
'/32, 0x20, 0x11000}, {&(0x7f0000012400)=3D'\x00\x00\x00\x00\x00\b\x00'/32,=
 0x20, 0x11800}, {&(0x7f0000012500)=3D'\x00\x00\x00\x00\x00\b\x00'/32, 0x20=
, 0x12000}, {&(0x7f0000012600)=3D'\x00\x00\x00\x00\x00\b\x00'/32, 0x20, 0x1=
2800}, {&(0x7f0000012700)=3D'\x00\x00\x00\x00\x00\b\x00'/32, 0x20, 0x13000}=
, {&(0x7f0000012800)=3D"504d4d00504d4dffdbf4655f00000000647679756b6f762d676=
c6170746f703200000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000006c6f6f7033320075782f746573742f73797a5f6d6=
f756e745f696d6167655f650500"/128, 0x80, 0x20000}, {&(0x7f0000012900)=3D'syz=
kallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkal=
lersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkaller=
syzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyz=
kallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkal=
lersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkaller=
syzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyz=
kallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkal=
lersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkaller=
syzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyz=
kallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkal=
lersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkaller=
syzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyz=
kallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkal=
lersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkallersyzkal\x0=
0\x00\x00\x00\x00\x00', 0x420, 0x28000}], 0x0, &(0x7f0000012e00))


Test input 2
r0 =3D perf_event_open(&(0x7f0000000000)=3D{0x0, 0x70, 0x3, 0x0, 0x0, 0x0, =
0x0, 0xffffffff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_config_ext}, 0x0, 0xffffffffffffffff,=
 0xffffffffffffffff, 0x0)
ioctl$PERF_EVENT_IOC_PERIOD(r0, 0x40082404, &(0x7f0000000080)=3D0x40)
syz_mount_image$ext4(&(0x7f0000000000)=3D'ext4\x00', &(0x7f0000000100)=3D'.=
/file0\x00', 0x200000, 0x4, &(0x7f0000000200)=3D[{&(0x7f0000010000)=3D"2000=
00000002000019000000900100000f000000000000000200000006000000000008000080000=
020000000d6f4655fd6f4655f0100ffff53ef010001000000d5f4655f000000000000000001=
000000000000000b0000000001000018000000c28500002b02", 0x66, 0x400}, {&(0x7f0=
000010100)=3D"00000000000000000000000028305c8a835f4f4da440baa59e2884cb01004=
0", 0x1f, 0x4e0}, {&(0x7f0000010300)=3D"020000000300000004", 0x9, 0x1000}, =
{&(0x7f0000012500)=3D"ed41000000100000d5f4655fd6f4655f33f4655f0000000000000=
40080000000f9ff", 0x22, 0x4100}], 0x1000085, &(0x7f0000000080)=3DANY=3D[@AN=
YBLOB=3D'\x00'])
umount2(&(0x7f0000000040)=3D'./file0\x00', 0x0)


Thanks,
Sishuai

> On Nov 30, 2020, at 11:19 AM, Christoph Hellwig <hch@infradead.org> wrote=
:
>=20
> On Mon, Nov 30, 2020 at 04:10:42PM +0000, Matthew Wilcox wrote:
>> On Mon, Nov 30, 2020 at 03:41:53PM +0000, Gong, Sishuai wrote:
>>> We found a data race in linux kernel 5.3.11 that we are able to reprodu=
ce in x86 under specific interleavings. Currently, we are not sure about th=
e consequence of this race so we would like to confirm with the community i=
f this can be a harmful bug.
>>=20
>> How are you able to reproduce it?  Normally mpage_readpage() is only cal=
led
>> from a filesystem, and you shouldn't be able to change the size of the
>> blocks in a block device while there's a mounted filesystem.
>=20
> mpage_readpages was also called by blkdev_readpages.  For current
> mainline s/readpages/readahead/ but the effect should be the same.

