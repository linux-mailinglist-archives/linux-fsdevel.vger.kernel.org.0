Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4264A9747
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 10:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358055AbiBDJ6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 04:58:08 -0500
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:39808
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358070AbiBDJ6G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvDF+AdHLRLCEUyMqQcOG8yJ8eQO9VGOKPJCrgNK5GFkyn0qyxOcsrxnq1OgFnuDqrqAz9CcsIgByl/wExntwXylnCj7jsDe9jw+vX38zTqWGVB4fNILF8y157H27lPvhInxyjhwsAwdzoNSo386KVTG6UJIBLaVR9Ub2oAeodVKhayncLxS166KUU1LZ5S+FhamxJGbwUCKBLO818VwV1/ICn1X5Wn1OKrBbALw8zFZsNOvhkT3bzg/Ig1DVAZRhlCn8bTDL8qrLjTg1cYlfRfgM4wYfY2iCqMgY2nZWue+X6PGNklPGPS2Atgwb93k1vvWBUAtrEhK5/g0/bsKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWoByXoiRd7BsqJSqV7pmvZeT8nlZthm+I6YDZsWwDg=;
 b=MNk69cBqobClTkB8K8SOuGnEQPQ9vZdhOQhpxIoasF+FIv0+/80dePQGRgVXiaWuGbRJUmXdG1yM/Iix4DHuAFPugasWMExDn6jum3X+v0HHnZBC3G8n6MwuIIAUESiMBKmrVEBO2hsPq9z5MTKJGjbceMIHntkZ1EpszZGfY/DN07Mj8IXsnLt1yq7NVvnxwhFrp8TG737+V/11YvyBQTVmM1O5c6m2I61xdO3Gzlngfn9yV/f2rDdIPXlfpqbn3P2j3pgaRfXAtBv7ieSswAWKdwhMZoQGO2KJ67gl2WeUCqBp/yzgKzdyZygzb+CkhLVyAXIliy7cj/QGAQxZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWoByXoiRd7BsqJSqV7pmvZeT8nlZthm+I6YDZsWwDg=;
 b=ElPh1F+JxUgyQi6dGJm8g2tAmhvLtaeQoivAzGVJLwcj/OenNtwxw3Z/m4DTxxVhXS4p4tRCjYsDpHUuTfDYu+IaVTWND0H2aepRS6GeOeh8c6E8jrJhsedMWbWPkEV+I1bdPPfqcAbvq8zN0SzxXaJb/ZBYFK7Wew5CJ5N+fDW397iOHEImUHwEhtXt4BR498jkiB0ZL9YoJKmaBOt7Dnnn1Sv4fWWjioCSBq1lm6ht4GVt5j+z8H5cUF8LyII0I1Tbh5w2xpwpy0LDovtdM423hcN0sWX5oDBpEv0uvsUC3Z5QHiKwY2XnyOiiIrdAOiviGWwMC6BTSe5vbgWbAQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1893.namprd12.prod.outlook.com (2603:10b6:903:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 4 Feb
 2022 09:58:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 09:58:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Thread-Topic: [RFC PATCH 3/3] nvme: add the "debug" host driver
Thread-Index: AQHYF5pGTuc0vK6aW0WDOYv4vbM4lKx/5pmAgAIScYCAABSnAIAAMdEAgAB7aoCAADa8gIAAGRyAgAAHXICAABoRgA==
Date:   Fri, 4 Feb 2022 09:58:03 +0000
Message-ID: <4d5410a5-93c3-d73c-6aeb-2c1c7f940963@nvidia.com>
References: <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
 <20220203153843.szbd4n65ru4fx5hx@garbanzo>
 <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com>
 <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
 <20220203195155.GB249665@bgt-140510-bm01>
 <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
 <2bbed027-b9a1-e5db-3a3d-90c40af49e09@opensource.wdc.com>
 <9d5d0b50-2936-eac3-12d3-a309389e03bf@nvidia.com>
 <20220204082445.hczdiy2uhxfi3x2g@ArmHalley.local>
In-Reply-To: <20220204082445.hczdiy2uhxfi3x2g@ArmHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1b4f437-41e9-4f1c-7cfa-08d9e7c4d5de
x-ms-traffictypediagnostic: CY4PR12MB1893:EE_
x-microsoft-antispam-prvs: <CY4PR12MB18937153F0E20E39E98764A5A3299@CY4PR12MB1893.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlGSUW0byVBXmqvHCWNFXYu6+k3OHN3Z9YO8BluoU9qLprs3UqvyMzVuF5aGYg+cNTB4fJCm2f90gFAdDqaVqpY09f2FyCgWYZi4otugqTiWZoFSxgHAZTOu/VK9yMiXcVRRmOIl2TgnH6RhoU0FHREAc+4CHDkUSzAeQGVG/wGhUrcP1FVHjSJqvVZgZYvy21oZddnIF1hqrI5We8LViPncZciwOx6lLf4rnrmtZTtLZUfOR290XcY2q7awD5lPv/RfggjjiVGs6tOpQkuKK6mlnjqMK4eQg7J4C6s4zebGyFb5s89EFF0Rt7dgPS4UhG2eozagyjgFzQ84zRuwtG51YHYYUs12HfunJQuD3swdLrE/vtSkJA1UOOmNbCQgV2DUA4+JpU0oIb2pluPVudjEBZKA/fs5vb/vtNchzhk5s0+HTQM3mO8RARfKG/cG1RPFULr3FfNNdiT22fiW6iLFQo+RDfpH0ijYoKVEUItwGecaUZ74tRswQnP/wh/JW70bYt4TdUYJksmAuPSCy2Hp1aboIIgBL3pm6p52ANhxogi/SrU2lCOXwm4b5DjNeX+42TUFRMddi2D0YrFVgkfzMJDa31diq93vVaUFNqg5BZIISC9IFsjkDU6btfeYOSIa5WVHWgl3pwpuR3zk3EHVwaerccRtoWCg6uRiNeBIAmn6OeZQeu7Ok06zATdng2v3Yniz/I0T8Z3bGMAp6fDjrU2ei0nRYigMTlQAdTEUzt/AwF7bP44+tPGJJGKbd77UgXDMi+2i8MjMZ0DIbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66476007)(66446008)(64756008)(91956017)(316002)(86362001)(7416002)(66556008)(36756003)(71200400001)(31696002)(2616005)(66946007)(6916009)(186003)(6486002)(508600001)(31686004)(5660300002)(76116006)(8676002)(54906003)(38100700002)(4326008)(122000001)(53546011)(6512007)(6506007)(38070700005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzBGUC80RTQ5ZkpNU2tHUDdxanBNNmwrbzBjUm5aM3FDMlo0aHRTL2R4cjZr?=
 =?utf-8?B?ZitYKyswemM1aEhGOTNVeGlNcUx5Yy8yR3krV2xKLzI2S3JIeXN3djRwNWtE?=
 =?utf-8?B?QXJTRjlGZG11MnZvMDJjM0hvYlpWa0Vrc09ZZ1RzaWhOVmxYcjIxZitjdHRD?=
 =?utf-8?B?YlZtb1hsUmVobFlzcjV3M0x2VlNEVXFNd2t0Q1Q4bjRJVXFDWTFPcUFQQXNk?=
 =?utf-8?B?MWZWeWVXTlVsOWdTTHpPRldoTmNjN1Uva0IvQnZLMDVOcWtOaExHSWw0djNR?=
 =?utf-8?B?ZkpaYVY1RVBUUWkwSzJkeXZGcDNxY2FsR2p3WnZuWWx3dnM5ZVhCb1UxOGd1?=
 =?utf-8?B?SGtuU0NOY0FPbWN1dzZUa3d3WWNvUXJmYVRTOElwRXBodXN1MXFGbHlSV2Mw?=
 =?utf-8?B?U0haUGhIbGxCdlprOVkxM1g5VlFkeUwxaG9hOVR5SzlsV1QxNURvUW1WY0ph?=
 =?utf-8?B?TTNvUmtUR0tkZm9WK3B0SytOMnJyb2lhTnRSK2tSOEVqYmVHZFpoRXF2SW5m?=
 =?utf-8?B?YlN6OGxMbkdzcjFrSDZ5TDVKS2QwYXArSnJKZDFGcVdTQkt5UXZnaXBUQm1w?=
 =?utf-8?B?eTJETTNJb09ycklObTE3RFRaK2tmLzRuQXhTekNNNmVJeHIwMVNaVlhJTEpy?=
 =?utf-8?B?YW9LcExSU1BnSFF6WXp1L3lTaUtEdE1XSWF2Tmx3SEcwQlhIcHhaTVZrNDFx?=
 =?utf-8?B?U1poN0FNMWd1eTFwY1diM1FkeXB0RGVjYkNjSEVGMmN4blRLaTljMUhOUWZ0?=
 =?utf-8?B?RHZUMVUxQ2VROTNDdmFYNkFLRHpPUUl2Z0dpUGFONXRXbFVrZXA2azBKZ0pL?=
 =?utf-8?B?ZWMrbDR0ZUdpeWVZTktRek5YS29CdzN0UDVEQWtLdG4xazdwbldWdXlMUkNC?=
 =?utf-8?B?bHlYVVpZOU9yMytBL3pkYk1SZlVhbjBNRkhSb2RtK0N1T0haZnovTFBlc0Z0?=
 =?utf-8?B?eTM0aGYxUVpqazVudjRtRklQOUxMSUY0Mjl4dStjSnErWng3cGFkTFRzZjBY?=
 =?utf-8?B?cE1LaUtnWWZ4RFlwc1hiYWZjY2o5amoyc3JHa04xWVBXL3J2OXQ1SHk5d3Mx?=
 =?utf-8?B?M3NTUW4ydVJsUnNuYkcrRDZBWllYZWJmc2wrZEs5c2JXZEVDR2JMRXkzdlNo?=
 =?utf-8?B?TXdUYVVjY1RIVHJrc0k3K2tQS3ZZTzBVUGxuditpUU1vaENlMFpHZnN3TkVQ?=
 =?utf-8?B?Vit1OWlyUGZUclphYk51VDhFWkJiUmFDdVlZTnFHY1h3ZkdzQ2pSU3NDZkRR?=
 =?utf-8?B?T2d3ZjdDVUY0VEYxVU5VTDVrZnVBcHdLN01CUys1N0VlTzd6MVFvbXlLNXNO?=
 =?utf-8?B?Zmh6b2xKOU05ZlU1azFCSnVvMXh2ZHhab3ZjWUw0aVZZcitFdXVLYzQ2K1Vn?=
 =?utf-8?B?a0tDWVE5TnpTbzErODZFOWRyZkdvQ2g1TkpzRFEwUG5yYTlyeEZETWdhTkxQ?=
 =?utf-8?B?VytKcWVuSW14c3BLTExCZFBsc0VJZGVQSExocEZkVnM3TlNrQkNpWnprMEJm?=
 =?utf-8?B?OVR1b3JqOW1LQUgxb0ZUeVNGLzd1Rk9ESHJVUytDVFBGb0d2Wis5TTlkcjFI?=
 =?utf-8?B?dHd4YUJOelRkQUdsaVY2TWRvajNMeEpVWDNZQ2xvbE4va0s3S1RFVlpOU0pi?=
 =?utf-8?B?VXE5MjVRL2FyK0c2OWNJN3J0RXFqVGxvU3RkR2VxUG5aOEc2Ti9sc1p3MkQr?=
 =?utf-8?B?Z1p6SmJiaGh0cFQvQzF2Q1ZrSlFpcE4xdFBubVpSYkdyNzRqampiVUtNekxU?=
 =?utf-8?B?TlJQRmZocnkraW9RVE1valVaY1gyb3VKclkzUWxsRjJvUHowSXM2UitSUjBk?=
 =?utf-8?B?Zkt6RVFpQmRYMmN3WHBwa216bDZoU3JYT2FzWHBodEd2Y1RRdXhVVDB3NUJR?=
 =?utf-8?B?TldNRlhTQndaTVVtMWN3QUZPb1Qva3QwRDhxSld2ZERYQUx3WC9JYVVIUXRC?=
 =?utf-8?B?d2JHWjl6cS9mYzdnUDVGc2N4RG93RVlUSUVyenpnR1ZOTzlrd3k2bjhta1pI?=
 =?utf-8?B?OEIrY0pwN3BPNXIzYUpvempoUzd2VVRXVnEwOEJrd0Zab1g2MUhYaXVyK1hB?=
 =?utf-8?B?UTlTWldMaCtBNzZFZUZTUUp5SE4zMjNxbTY4L0tiV2dpSUkwT2hQcFVBeG4w?=
 =?utf-8?B?NDIzUzVzRmZna05JUHM3MUtBdzVTQ1oxM1RuWjliTzVqcnllUmpOWW5qUTJP?=
 =?utf-8?Q?hjx5HCKQ+u7Pr7ePEUIW1UuBb8iOE0qZdOvTNzmB9+Ww?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA1C6FA9A8CDA342B2FBFCFA1B38E460@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b4f437-41e9-4f1c-7cfa-08d9e7c4d5de
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 09:58:03.5963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4wjSsJ8bgHWohqfxVFJiRlTKLpX1FAU4ZlKd+kK06+wWt0AoKBPdovdRfsrrDhJ6ePO1IrRvR/4zvh5E7pi+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1893
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi80LzIyIDEyOjI0IEFNLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOg0KPiBPbiAwNC4wMi4y
MDIyIDA3OjU4LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBPbiAyLzMvMjIgMjI6Mjgs
IERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPj4+IE9uIDIvNC8yMiAxMjoxMiwgQ2hhaXRhbnlhIEt1
bGthcm5pIHdyb3RlOg0KPj4+Pg0KPj4+Pj4+PiBPbmUgY2FuIGluc3RhbnRpYXRlIHNjc2kgZGV2
aWNlcyB3aXRoIHFlbXUgYnkgdXNpbmcgZmFrZSBzY3NpIA0KPj4+Pj4+PiBkZXZpY2VzLA0KPj4+
Pj4+PiBidXQgb25lIGNhbiBhbHNvIGp1c3QgdXNlIHNjc2lfZGVidWcgdG8gZG8gdGhlIHNhbWUu
IEkgc2VlIGJvdGggDQo+Pj4+Pj4+IGVmZm9ydHMNCj4+Pj4+Pj4gYXMgZGVzaXJhYmxlLCBzbyBs
b25nIGFzIHNvbWVvbmUgbWFudGFpbnMgdGhpcy4NCj4+Pj4+Pj4NCj4+Pj4NCj4+Pj4gV2h5IGRv
IHlvdSB0aGluayBib3RoIGVmZm9ydHMgYXJlIGRlc2lyYWJsZSA/DQo+Pj4NCj4+PiBXaGVuIHRl
c3RpbmcgY29kZSB1c2luZyB0aGUgZnVuY3Rpb25hbGl0eSwgaXQgaXMgZmFyIGVhc2llciB0byBn
ZXQgc2FpZA0KPj4+IGZ1bmN0aW9uYWxpdHkgZG9pbmcgYSBzaW1wbGUgIm1vZHByb2JlIiByYXRo
ZXIgdGhhbiBoYXZpbmcgdG8gc2V0dXAgYQ0KPj4+IFZNLiBDLmYuIHJ1bm5pbmcgYmxrdGVzdHMg
b3IgZnN0ZXN0cy4NCj4+Pg0KPj4NCj4+IGFncmVlIG9uIHNpbXBsaWNpdHkgYnV0IHRoZW4gd2h5
IGRvIHdlIGhhdmUgUUVNVSBpbXBsZW1lbnRhdGlvbnMgZm9yDQo+PiB0aGUgTlZNZSBmZWF0dXJl
cyAoZS5nLiBaTlMsIE5WTWUgU2ltcGxlIENvcHkpID8gd2UgY2FuIGp1c3QgYnVpbGQNCj4+IG1l
bW9lcnkgYmFja2VkIE5WTWVPRiB0ZXN0IHRhcmdldCBmb3IgTlZNZSBjb250cm9sbGVyIGZlYXR1
cmVzLg0KPj4NCj4+IEFsc28sIHJlY29nbml6aW5nIHRoZSBzaW1wbGljaXR5IEkgcHJvcG9zZWQg
aW5pdGlhbGx5IE5WTWUgWk5TDQo+PiBmYWJyaWNzIGJhc2VkIGVtdWxhdGlvbiBvdmVyIFFFTVUg
KEkgdGhpbmsgSSBzdGlsbCBoYXZlIGluaXRpYWwgc3RhdGUNCj4+IG1hY2hpbmUgaW1wbGVtZW50
YXRpb24gY29kZSBmb3IgWk5TIHNvbWV3aGVyZSksIHRob3NlIHdlcmUgIm5hY2tlZCIgZm9yDQo+
PiB0aGUgcmlnaHQgcmVhc29uLCBzaW5jZSB3ZSd2ZSBkZWNpZGVkIGdvIHdpdGggUUVNVSBhbmQg
dXNlIHRoYXQgYXMgYQ0KPj4gcHJpbWFyeSBwbGF0Zm9ybSBmb3IgdGVzdGluZywgc28gSSBmYWls
ZWQgdG8gdW5kZXJzdGFuZCB3aGF0IGhhcw0KPj4gY2hhbmdlZC4uIHNpbmNlIGdpdmVuIHRoYXQg
UUVNVSBhbHJlYWR5IHN1cHBvcnRzIE5WTWUgc2ltcGxlIGNvcHkgLi4uDQo+IA0KPiBJIHdhcyBu
b3QgcGFydCBvZiB0aGlzIGNvbnZlcnNhdGlvbiwgYnV0IGFzIEkgc2VlIGl0IGVhY2ggYXBwcm9h
Y2ggZ2l2ZQ0KPiBhIGJlbmVmaXQuIFFFTVUgaXMgZmFudGFzdGljIGZvciBjb21wbGlhbmNlIHRl
c3RpbmcgYW5kIEkgYW0gbm90IHN1cmUNCj4geW91IGdldCB0aGUgc2FtZSBsZXZlbCBvZiBjb21t
YW5kIGFuYWx5c2lzIGFueXdoZXJlIGVsc2U7IGF0IGxlYXN0IG5vdA0KPiB3aXRob3V0IHdyaXRp
bmcgZGVkaWNhdGVkIGNvZGUgZm9yIHRoaXMgaW4gYSB0YXJnZXQuDQo+IA0KPiBUaGlzIHNhaWQs
IHdoZW4gd2Ugd2FudCB0byB0ZXN0IGZvciByYWNlIGNvbmRpdGlvbnMsIFFFTVUgaXMgdmVyeSBz
bG93Lg0KDQpDYW4geW91IHBsZWFzZSBlbGFib3JhdGUgdGhlIHNjZW5hcmlvIGFuZCBudW1iZXJz
IGZvciBzbG93bmVzcyBvZiBRRU1VPw0KDQpGb3IgcmFjZSBjb25kaXRpb25zIHRlc3Rpbmcgd2Ug
Y2FuIGJ1aWxkIGVycm9yIGluamVjdGlvbiBmcmFtZXdvcmsNCmFyb3VuZCB0aGUgY29kZSBpbXBs
ZW1lbnRhdGlvbiB3aGljaCBwcmVzZW50IGluIGtlcm5lbCBldmVyeXdoZXJlLg0KDQo+IEZvciBh
IHNvZnR3YXJlLW9ubHkgc29sdXRpb24sIHdlIGhhdmUgZXhwZXJpbWVudGVkIHdpdGggc29tZXRo
aW5nDQo+IHNpbWlsYXIgdG8gdGhlIG52bWUtZGVidWcgY29kZSB0aGEgTWlrdWxhcyBpcyBwcm9w
b3NpbmcuIEFkYW0gcG9pbnRlZCB0bw0KPiB0aGUgbnZtZS1sb29wIHRhcmdldCBhcyBhbiBhbHRl
cm5hdGl2ZSBhbmQgdGhpcyBzZWVtcyB0byB3b3JrIHByZXR0eQ0KPiBuaWNlbHkuIEkgZG8gbm90
IGJlbGlldmUgdGhlcmUgc2hvdWxkIGJlIG1hbnkgY2hhbmdlcyB0byBzdXBwb3J0IGNvcHkNCj4g
b2ZmbG9hZCB1c2luZyB0aGlzLg0KPiANCg0KSWYgUUVNVSBpcyBzbyBpbmNvbXBldGVudCB0aGVu
IHdlIG5lZWQgdG8gYWRkIGV2ZXJ5IGJpZyBmZWF0dXJlIGludG8NCnRoZSBOVk1lT0YgdGVzdCB0
YXJnZXQgc28gdGhhdCB3ZSBjYW4gdGVzdCBpdCBiZXR0ZXIgPyBpcyB0aGF0IHdoYXQNCnlvdSBh
cmUgcHJvcG9zaW5nID8gc2luY2UgaWYgd2UgaW1wbGVtZW50IG9uZSBmZWF0dXJlLCBpdCB3aWxs
IGJlDQpoYXJkIHRvIG5hY2sgYW55IG5ldyBmZWF0dXJlcyB0aGF0IHBwbCB3aWxsIGNvbWUgdXAg
d2l0aA0Kc2FtZSByYXRpb25hbGUgIndpdGggUUVNVSBiZWluZyBzbG93IGFuZCBoYXJkIHRvIHRl
c3QgcmFjZQ0KY29uZGl0aW9ucyBldGMgLi4iDQoNCmFuZCBpZiB0aGF0IGlzIHRoZSBjYXNlIHdo
eSB3ZSBkb24ndCBoYXZlIFpOUyBOVk1lT0YgdGFyZ2V0DQptZW1vcnkgYmFja2VkIGVtdWxhdGlv
biA/IElzbid0IHRoYXQgYSBiaWdnZXIgYW5kIG1vcmUNCmNvbXBsaWNhdGVkIGZlYXR1cmUgdGhh
biBTaW1wbGUgQ29weSB3aGVyZSBjb250cm9sbGVyIHN0YXRlcw0KYXJlIGludm9sdmVkIHdpdGgg
QUVOcyA/DQoNClpOUyBrZXJuZWwgY29kZSB0ZXN0aW5nIGlzIGFsc28gZG9uZSBvbiBRRU1VLCBJ
J3ZlIGFsc28gZml4ZWQNCmJ1Z3MgaW4gdGhlIFpOUyBrZXJuZWwgY29kZSB3aGljaCBhcmUgZGlz
Y292ZXJlZCBvbiBRRU1VIGFuZCBJJ3ZlIG5vdA0Kc2VlbiBhbnkgaXNzdWVzIHdpdGggdGhhdC4g
R2l2ZW4gdGhhdCBzaW1wbGUgY29weSBmZWF0dXJlIGlzIHdheSBzbWFsbGVyDQp0aGFuIFpOUyBp
dCB3aWxsIGxlc3MgbGlrZWx5IHRvIHN1ZmZlciBmcm9tIHNsb3duZXNzIGFuZCBldGMgKGxpc3Rl
ZA0KYWJvdmUpIGluIFFFTVUuDQoNCm15IHBvaW50IGlzIGlmIHdlIGFsbG93IG9uZSwgd2Ugd2ls
bCBiZSBvcGVuaW5nIGZsb29kZ2F0ZXMgYW5kIHdlIG5lZWQgDQp0byBiZSBjYXJlZnVsIG5vdCB0
byBibG9hdCB0aGUgY29kZSB1bmxlc3MgaXQgaXMgX2Fic29sdXRlbHkNCm5lY2Vzc2FyeV8gd2hp
Y2ggSSBkb24ndCB0aGluayBpdCBpcyBiYXNlZCBvbiB0aGUgc2ltcGxlIGNvcHkNCnNwZWNpZmlj
YXRpb24uDQoNCj4gU28gaW4gbXkgdmlldyBoYXZpbmcgYm90aCBpcyBub3QgcmVwbGljYXRpb24g
YW5kIGl0IGdpdmVzIG1vcmUNCj4gZmxleGliaWxpdHkgZm9yIHZhbGlkYXRpb24sIHdoaWNoIEkg
YmVsaWV2ZSBpdCBpcyBhbHdheXMgZ29vZC4NCj4gDQoNCi1jaw0KDQo=
