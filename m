Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6776ACFC8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 22:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCFVFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 16:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCFVFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:05:50 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E0D79B3F;
        Mon,  6 Mar 2023 13:05:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsXqF+8iqsK7wSv1eyX2uokYmxSl9+U6en/kr4laNZ4N181rUnwV5ETgmZHdZhalqAed6tKYGkZH9mmLcGmPPFK4rqf7AUZSYuKzohSh73VgVwMupQu0XXYy49BfNZ8Qfsw6iOr6cAb5mhhNxVesgl5utVP+O83h5i8wtMzugu27BbEG+sDoIhj4RGX2lOwZ5W8cru1SRwkEzMrZ9Ex6t6JLEmW4YVlv8JvrhPrXpC6RItNzV0Szg/lFDfvUeLvQ2LlnhpN8ECB3QmmTepwmgRDeTnEVSyzskEoLtVIj6xN2ZDFZBcISpece0VPfa5J7BVGgf4uiazsRX319QtGNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuLkeVTay576NhKoUx7zgE5d5GvurB4o+WXR7mw5F5c=;
 b=aCWBl8PA2aJRcoweE03vQFG3sUJZ1pQB1CTj0tcyileXe0jf1SHMyVyEpEmdo7OegToIBXdVGWEglkJWPzK4LGR1GVSabDDxN3a9UXeGHwxjcRhUigvyhEitXxM4VLJ7ZOdxL+diNEC87PpeLKArNIW3UEdNFJGvm2jXPu78n1u8ro9FdBYd6bY2IyKHYT7rQpvBoTcEgH/AzGNgHMyUS4YunF9cro1oR+eiLO0zZQiYCyNIN9qS2uJsBHpvhRWsc7V82UVqyoU2/rzIp7pkoSl7lvBwGsJCd2RVzK740Va5/LbXc5LBgpVkpg5mMO+yK6bLnF4lmbmN3EqkiiNbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuLkeVTay576NhKoUx7zgE5d5GvurB4o+WXR7mw5F5c=;
 b=A5B7jEjj0yUwrVq0Z7Io65CzME3q8JTlEfl5ZJgg82QC+Dm3wA+IONaOO5SXf26ATxgzFgrFpbELlVYwZHsbKyAUh/+PHF7HHmp1sR3AAC95qdeXyHIUTZz76whkLReMEyvUCFeCyn4fPEPjiNpkOgbeMYqHIocsWCP4YjG4ZdU=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DM4PR19MB6294.namprd19.prod.outlook.com (2603:10b6:8:a8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Mon, 6 Mar 2023 21:05:08 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69%4]) with mapi id 15.20.6086.024; Mon, 6 Mar 2023
 21:05:05 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
CC:     "mszeredi@redhat.com" <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?utf-8?B?U3TDqXBoYW5lIEdyYWJlcg==?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "criu@openvz.org" <criu@openvz.org>,
        "flyingpeng@tencent.com" <flyingpeng@tencent.com>
Subject: Re: [RFC PATCH 0/9] fuse: API for Checkpoint/Restore
Thread-Topic: [RFC PATCH 0/9] fuse: API for Checkpoint/Restore
Thread-Index: AQHZUG9SSDME+hAkHU2B1LK8mPjKmg==
Date:   Mon, 6 Mar 2023 21:05:05 +0000
Message-ID: <d20393b4-017e-19f1-b49a-452a6f3acdc8@ddn.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegvQyD-+EL2DdVWmyKF8odYWj4kAONyRf6VH_h4JCTu=vg@mail.gmail.com>
 <CAEivzxdX28JhA+DY92nTGn56kmMgdeT9WX__j7NU3QHpg+wcdQ@mail.gmail.com>
 <CAJfpeguYO9J=np5vxH+HjCSAxn=8fcQRhh_-BVadTt86zWfkpQ@mail.gmail.com>
In-Reply-To: <CAJfpeguYO9J=np5vxH+HjCSAxn=8fcQRhh_-BVadTt86zWfkpQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|DM4PR19MB6294:EE_
x-ms-office365-filtering-correlation-id: 2768aac0-4102-4f53-6176-08db1e8675dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2OoH/0hr9RXjlwVkrI24LlQxG+mmjxQx6lbO3a1RAr3aUkL2MzGoxRQ1gC6hJm82sMVuSdmCDpVfxcKSRGB0sX8zYJsTp+Sj3erKeT2xsJu5BX4B1IJcNt62faFGHYHbACsqIaTG281uCLxD9vZVfid9yqzI/QjczIKd6vYiRMa72OWMtAAAkTYN2/E6T9MlsFuxBPtCoXJV+NJ4JewiCC/xKp2MsmwDXMej4/XkXFJNQcKkJrzwkeX2yChJ8K3JCYHVTUSly++qhVrxhV1umMluAn3XKL35JcEu5O8T9eBHf3PVgTxRQy+iDCcCXzP9ee35iiGDXIEHXjuAG8LJj0s7EfZjAySifTch3yDpjFes/7HAI/ZMvZXp5zmPZ5igAq/Oauhj5D/FAmRcOJe6TlA6K3vMhowUBeAaGmc9jMAQeyxVScfZvFnSENqPgU6TdV7yFClkPrAFjBO/lIi8Z7TINZQYSW1IVrD76SdFsUrKWN7gwyiBOrxnZlnaxfOE+O6XYRQ6kBEP8Wr/5VjckF6zePSULjj6RHMKtb8qeY47CM9QTBeWvClNMhwEakc+hzfG2vOJAdY9jZhM0I9PTtvZo86SvGpagiVE5QeQyqqeVidYjSBsFzWJkEEKEwg7Ysvd8BB+agwbdpJqZGwLZCJ0wL+LwJlRYozcaNJaYVGf8+bhYBS1peP+H4YL/n8Zcn2AYbZvDQ1KCJA20xOAeaAHGUPe6oVw57mrf9AdaLAiKLfx+PL6w1/e+HiS5CJMAl9afJeS1Rb+j0cyGsJOQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39840400004)(366004)(376002)(346002)(396003)(136003)(451199018)(31686004)(86362001)(64756008)(66446008)(8676002)(4326008)(41300700001)(186003)(2906002)(8936002)(36756003)(316002)(54906003)(66556008)(66946007)(76116006)(478600001)(91956017)(66476007)(6486002)(6506007)(38070700005)(53546011)(122000001)(83380400001)(2616005)(38100700002)(6512007)(31696002)(5660300002)(71200400001)(110136005)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3Nad0FHYVR2ZHlZdWI0YWN1VkFmQnpaaUJLdWlnUklEV1FDcm1ZMTBEWlp2?=
 =?utf-8?B?MHN4ZVF2aENPaEcrYitsSHpjUi9tZUQ1V2taSU1VSjU0TU91RGlRY1E3YkFo?=
 =?utf-8?B?Z1Nxa1g0MC8ya3JrejQyUHFpSXhseGw3T2JTYXVidTRBeXNRZzg2OUVSYWNn?=
 =?utf-8?B?d2lDUml4MUZRZ0x6bVJhN1BGL1ZmYlBDeWRlanJNZCtTUGkzL1ZrZnNBQnpr?=
 =?utf-8?B?cnRoNzhtWnJkNXprR3A4SUxhREVESHBNWHlXZnVRcFRmUlVmQ0pOZEJuWGRj?=
 =?utf-8?B?elVrN0pyaGJldEU2MUZqbjlCbG5oMjVNU01PaUFXbnF5WUo2eVVDOTR6UmNs?=
 =?utf-8?B?R2ZpZWRRMlNuN3JQOVkxUkVMY1oxV2FxYlZGQllFYkxuRVhlR0dXRGx5aXZW?=
 =?utf-8?B?enc1VE5LeW1NeFJEMWUzKzJMb1dRY1d3akVaTTZ4UWtzMURQbTBYUGpDNUVJ?=
 =?utf-8?B?a004R3B0UU5jM0tLSTlxajBMSEdFMEt4WjBoME1YdFpqZ3ZINy8vbEQ2S09s?=
 =?utf-8?B?ZHpGeHlJWnFESnBac21WV0VlNDFmTVRqdHNMRlNScHFMc1lsUG9CNHIvZWR1?=
 =?utf-8?B?WmVPOWdYT3FVUVlqdC9WUmp0dXBCaVlub2F2VFZPcEpNaHVMTFdqTzVDM1dj?=
 =?utf-8?B?UjYwQVRhWXlFOVpWYThKcjVLR1dpazFkQmhPQXhTZGJlMjRIbmdPaUdtT0VM?=
 =?utf-8?B?ZzFKcjg4UVlQa1NOdFRrb3JBSXpiWEwvVlN0RXNnM090RWpJL0dMOUpYK1ox?=
 =?utf-8?B?bmNQK2sxWm9NZGhYaTVUZ0xoSkJ6aVNJZ1Q3N1FQbFdkODE0akVNVnRBSXZG?=
 =?utf-8?B?eHcwWjRqVjRCSUxGWkNpUXlWR0RuMStEQ1FtTnFNbDFmUk9FU2V1S3VoUGd0?=
 =?utf-8?B?amJFTVd1TjJnT2xnNkhMREphSEJQQTVzem9pRGxLR2pHR2VJL3E0RlVaSkYw?=
 =?utf-8?B?cS80cnd4VUU4aDR5RUw3YSt1TmIycVNyYmtTdXRpRFBDVUgyRTd4Vjd5MlJF?=
 =?utf-8?B?dm9vTTZjSDZWK0ZHenZvZVNoY2l0MGlGZ2toSVU1RUtVRHJzNmUyN2gzeU5X?=
 =?utf-8?B?eVQyRk0vcVBFQ1N0N2NqMllPOVl5V3U5aHdxTW84V01naFhiblBXSHVGcS9u?=
 =?utf-8?B?Rm5QMkZBcE5xNDJwcCtWd09reG9PenZjQkxubENlRkNLTmdNdkUycVR2VmFj?=
 =?utf-8?B?ZmdmZEdBVGhROGVNZU5GbHEwbkphTFo2NFByU3g2WkV0RmFiS2hTT05tRjNn?=
 =?utf-8?B?SUlNZ3A4TVUrM1doYUNlSmtVZis2bDdkdWlIQXVmTUVkaXZHalFhT05xcW9S?=
 =?utf-8?B?dUxGYXU0cXVkd1BnMlYvZ0RRampWVUxCdEp0UVF3aDIvY0tObWVGZHhjNUha?=
 =?utf-8?B?VW9VLzdHa044Q21ERnk2Y0hIeDJUVUhmZTVzZ1M0TG5iY3phTEJWK0dIajlE?=
 =?utf-8?B?eWU1Wm9FNTYxZXZzVXZQUFFvS1c1UStmekVZSEMzRnIxN3VZT25jbEJkY3FQ?=
 =?utf-8?B?YlBpclhCZGF3eHI4Y05PMHphMkJieStnclI2YmtsYnhKM0ppQmRkSkNPTy8x?=
 =?utf-8?B?NEVoRWNhWnRBSUcydHhNN24vV1RFa2c1d3VST0dycEEyUzlLZlowU0RXdXpD?=
 =?utf-8?B?RCtkcWphZ3RaSmxXV3A0OGJjU0RiZXRXTHhzMEtrTGphaEw3SkJ3TzJuYmNB?=
 =?utf-8?B?SUJuUnZlbzFTZmpnNmJoWkRHRlpsS2VIMXVnNVlLM3RWWFE1RE1GZ0grU3o5?=
 =?utf-8?B?Q0ZIMzlSRGlFYVJTa0pPTTJZdjJ4VVhCb0dMY0V3ekNQZ0Z6aVJTS2dJd1Zp?=
 =?utf-8?B?MStUSHBvK1dXUUVweHhKdCtDMElXTU5iMWNLczhLVExTM01PR0ZNWGxsQ21j?=
 =?utf-8?B?dUZCLzF6SjlSU1pPMEc3blFqTEpDY0tpUGlaSlpodU5OM0lpWUkraHZNcnJ6?=
 =?utf-8?B?WllvenFFTUdtQk5xOVY5akpEZmVyUFFBdWcvdSs3OFJEOVM3UjlaS242VUhO?=
 =?utf-8?B?RmVMZXcxN2tna1o5ZTJkU0Y5UjkyYzFPTlpLakQraGkvL0gzc0FONVBzanY5?=
 =?utf-8?B?WU5uL2dvcW1tNnhCNTRUcnlsUWs5NGNVLy9seStnTG9GRDVyRDJGbEMzMGV5?=
 =?utf-8?B?ZVZFV1lmYzEwaTkzbEdBMWZJQ3VuSFZrVi9SdDRJbitpbVhITWt0cHpRQ2Mx?=
 =?utf-8?Q?9xydKuasEkDalVG0NtOmano=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADC44AB71349694691979E77CA5EFBA9@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2768aac0-4102-4f53-6176-08db1e8675dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 21:05:05.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMYgfUy4rrfamQNMh9no15rsJrjxx55jec8lwlP7tQkPUG/d6KJDm1b7mbG2EYYbiEVxOAHdSWwq5azhnVgxhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCk9uIDMvNi8yMyAyMDoxOCwgTWlrbG9zIFN6ZXJlZGkgd3JvdGU6DQo+IE9uIE1vbiwgNiBN
YXIgMjAyMyBhdCAxNzo0NCwgQWxla3NhbmRyIE1pa2hhbGl0c3luDQo+IDxhbGVrc2FuZHIubWlr
aGFsaXRzeW5AY2Fub25pY2FsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gTW9uLCBNYXIgNiwgMjAy
MyBhdCA1OjE14oCvUE0gTWlrbG9zIFN6ZXJlZGkgPG1pa2xvc0BzemVyZWRpLmh1PiB3cm90ZToN
Cj4gDQo+Pj4gQXBwYXJlbnRseSBhbGwgb2YgdGhlIGFkZGVkIG1lY2hhbmlzbXMgKFJFSU5JVCwg
Qk1fUkVWQUwsIGNvbm5fZ2VuKQ0KPj4+IGFyZSBjcmFzaCByZWNvdmVyeSByZWxhdGVkLCBhbmQg
bm90IHVzZWZ1bCBmb3IgQy9SLiAgV2h5IGlzIHRoaXMgYmVpbmcNCj4+PiBhZHZlcnRpc2VkIGFz
IGEgcHJlY3Vyc29yIGZvciBDUklVIHN1cHBvcnQ/DQo+Pg0KPj4gSXQncyBiZWNhdXNlIEknbSBk
b2luZyB0aGlzIHdpdGggQ1JJVSBpbiBtaW5kIHRvbywgSSB0aGluayBpdCdzIGEgZ29vZA0KPj4g
d2F5IHRvIG1ha2UgYSB1bml2ZXJzYWwgaW50ZXJmYWNlDQo+PiB3aGljaCBjYW4gYWRkcmVzcyBu
b3Qgb25seSB0aGUgcmVjb3ZlcnkgY2FzZSBidXQgYWxzbyB0aGUgQy9SLCBjYXVzZQ0KPj4gaW4g
c29tZSBzZW5zZSBpdCdzIGEgY2xvc2UgcHJvYmxlbS4NCj4gDQo+IFRoYXQncyB3aGF0IEknbSB3
b25kZXJpbmcgYWJvdXQuLi4NCj4gDQo+IENyYXNoIHJlY292ZXJ5IGlzIGFib3V0IHJlc3Rvcmlu
ZyAob3IgYXQgbGVhc3QgcmVnZW5lcmF0aW5nKSBzdGF0ZSBpbg0KPiB0aGUgdXNlcnNwYWNlIHNl
cnZlci4NCj4gDQo+IEluIENSSVUgcmVzdG9yaW5nIHRoZSBzdGF0ZSBvZiB0aGUgdXNlcnNwYWNl
IHNlcnZlciBpcyBhIHNvbHZlZA0KPiBwcm9ibGVtLCB0aGUgaXNzdWUgaXMgcmVzdG9yaW5nIHN0
YXRlIGluIHRoZSBrZXJuZWwgcGFydCBvZiBmdXNlLiAgSW4NCj4gYSBzZW5zZSBpdCdzIHRoZSBl
eGFjdCBvcHBvc2l0ZSBwcm9ibGVtIHRoYXQgY3Jhc2ggcmVjb3ZlcnkgaXMgZG9pbmcuDQo+IA0K
Pj4gQnV0IG9mIGNvdXJzZSwgQ2hlY2twb2ludC9SZXN0b3JlIGlzIGEgd2F5IG1vcmUgdHJpY2tp
ZXIuIEJ1dCBiZWZvcmUNCj4+IGRvaW5nIGFsbCB0aGUgd29yayB3aXRoIENSSVUgUG9DLA0KPj4g
SSB3YW50ZWQgdG8gY29uc3VsdCB3aXRoIHlvdSBhbmQgZm9sa3MgaWYgdGhlcmUgYXJlIGFueSBz
ZXJpb3VzDQo+PiBvYmplY3Rpb25zIHRvIHRoaXMgaW50ZXJmYWNlL2ZlYXR1cmUgb3IsIGNvbnZl
cnNlbHksDQo+PiBpZiB0aGVyZSBpcyBzb21lb25lIGVsc2Ugd2hvIGlzIGludGVyZXN0ZWQgaW4g
aXQuDQo+Pg0KPj4gTm93IGFib3V0IGludGVyZmFjZXMgUkVJTklULCBCTV9SRVZBTC4NCj4+DQo+
PiBJIHRoaW5rIGl0IHdpbGwgYmUgdXNlZnVsIGZvciBDUklVIGNhc2UsIGJ1dCBwcm9iYWJseSBJ
IG5lZWQgdG8gZXh0ZW5kDQo+PiBpdCBhIGxpdHRsZSBiaXQsIGFzIEkgbWVudGlvbmVkIGVhcmxp
ZXIgaW4gdGhlIGNvdmVyIGxldHRlcjoNCj4+Pj4gKiAiZmFrZSIgZGFlbW9uIGhhcyB0byByZXBs
eSB0byBGVVNFX0lOSVQgcmVxdWVzdCBmcm9tIHRoZSBrZXJuZWwgYW5kIGluaXRpYWxpemUgZnVz
ZSBjb25uZWN0aW9uIHNvbWVob3cuDQo+Pj4+IFRoaXMgc2V0dXAgY2FuIGJlIG5vdCBjb25zaXN0
ZW50IHdpdGggdGhlIG9yaWdpbmFsIGRhZW1vbiAocHJvdG9jb2wgdmVyc2lvbiwgZGFlbW9uIGNh
cGFiaWxpdGllcy9zZXR0aW5ncw0KPj4+PiBsaWtlIG5vX29wZW4sIG5vX2ZsdXNoLCByZWFkYWhl
YWQsIGFuZCBzbyBvbikuDQo+Pg0KPj4gU28sIGFmdGVyIHRoZSAiZmFrZSIgZGVtb24gaGFzIGRv
bmUgaXRzIGpvYiBkdXJpbmcgQ1JJVSByZXN0b3JlLCB3ZQ0KPj4gbmVlZCB0byByZXBsYWNlIGl0
IHdpdGggdGhlIGFjdHVhbCBkZW1vbiBmcm9tDQo+PiB0aGUgZHVtcGVlIHRyZWUgYW5kIHBlcmZv
cm1pbmcgUkVJTklUIGxvb2tzIGxpa2UgYSBzYW5uZXIgd2F5Lg0KPiANCj4gSSBkb24ndCBnZXQg
aXQuICBIb3cgZG9lcyBSRUlOSVQgaGVscCB3aXRoIHN3aXRjaGluZyB0byB0aGUgcmVhbCBkYWVt
b24/DQoNClRoZSB3YXkgSSByZWFkIHRoZSBwYXRjaGVzLCB0aGUgbmV3IGRhZW1vbiBzZW5kcyBG
VVNFX0lOSVQgdG8gYWR2ZXJ0aXNlIA0KYWxsIG9mIGl0cyBmZWF0dXJlcy4NCg==
