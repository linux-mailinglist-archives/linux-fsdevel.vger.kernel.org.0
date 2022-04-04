Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD8B4F15F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353157AbiDDNek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 09:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243632AbiDDNej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:34:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2105.outbound.protection.outlook.com [40.107.92.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5E20F62;
        Mon,  4 Apr 2022 06:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cztaZX12QTffQ/Kr5cpCt/3Ue5SWZh+1UVFrWdCAHM5g9Y6EGcQCfgFreSfJo4q32mCI+Smg4oFcl3y3zz0oQDLi3dBRDzeUEPxVMH1nVtaRr2Z7uCNQdQsBKEU2zyoiIXEabvf5PeJY4HZuYv1icPpbZ8YNZuItZnQyX5AMrBNDtbl7ffw8Inn3oN8tgF40Bfahw9VJJNX/SAtDgMuXXde9now/p1WHecy5SKtTuKkHfYitXuuSf1Fms6UToXxMHpNB7CBushO2nZG/0Rxhw2U0AsCzm1nD6vY60QV5JiWiSq8auu8naczLQau3Vu49mrfbaalusLBPXKQgLuXE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvE5/XeSZSAgu0PSiEPP3dVEldibvyXKfyXWR5jPXBk=;
 b=WUROCeqHqUtzxN0k60R1TmJrKR40r2qsr4lqCeRIzTbqoyQQVAa5f60HrXKgCiyWsJd9x40aXekM0NozLsiLzM1jWOFAQkghTgdVEQ5csYUYX7WuElDpnUvYcykXqog/Hgn3V+aapKSjdr2J4spzlaT8DfE+AXun+qFlQzpPTCCjPDTbDNQfwPKNTEmWjQMzMV3Ei2i6qwQwNaIslt3DfdbYKCJ9PNUqwS7Ifg2y5FgJHQll4TS4iHdFzwAcpqfUMq8x4o2zxQA2pz9ZX/iRJf3jwPcHB0gR6fXdSRECyMRBgN3RF6eh/Q0lbAC1Sea3XnFce0Jf6p7STMUtegzGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvE5/XeSZSAgu0PSiEPP3dVEldibvyXKfyXWR5jPXBk=;
 b=TMQ8WjVxmZ9N7SJHCdHzGy6bQr6Pms8fWZdxKlwHjM0aS0GhBcLqGEF9TplUchoqerd1lyCSY2bejahF2PTlsWdY3kxZBEpVVfltjXtUF17Nfd/u+3ovaHJ4vfjvptgkwWUYYwlUQNydStOH/R3gRZIi27yeLCkx8EOeu1WqaXE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB2936.namprd13.prod.outlook.com (2603:10b6:a03:183::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.16; Mon, 4 Apr
 2022 13:32:37 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5144.016; Mon, 4 Apr 2022
 13:32:37 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smfrench@gmail.com" <smfrench@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: UBSAN shitf-out-of-bounds regression in NFS in 5.18-rc1
Thread-Topic: UBSAN shitf-out-of-bounds regression in NFS in 5.18-rc1
Thread-Index: AQHYR9d+7u50LO74q0i8GQ6f5TJV/KzfwTUA
Date:   Mon, 4 Apr 2022 13:32:37 +0000
Message-ID: <c5e15aae628558d6da286a8a846821ae9009c0f7.camel@hammerspace.com>
References: <CAH2r5msa7ZW3j+oO1JvKA0OLgaP2thyviRDGxTiK6gz2H9r-jA@mail.gmail.com>
In-Reply-To: <CAH2r5msa7ZW3j+oO1JvKA0OLgaP2thyviRDGxTiK6gz2H9r-jA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2baafe0-578d-4844-3dd8-08da163f95c7
x-ms-traffictypediagnostic: BY5PR13MB2936:EE_
x-microsoft-antispam-prvs: <BY5PR13MB2936F7F440D38740F35BC85CB8E59@BY5PR13MB2936.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGhAwW7ExtBr88F6Ksff4W+7YgP1yXIatCjQWWScMztCJYzPDFlluqBD9v5+ZeBHjeEdJud8Qoff68y+RfLhJhYjHbzrDEKQUUd2QBQqxZe5jAqOdelZigp1mrsCMsoMdzDcKcy/nnV7ioc4t3GcQcxaNV4YRRjIe/CrExESMPTGPbgjHBx5Dypi8xyf/NPDK9jI2QE0wgUpFY5Qex3Cx/NbQus83X8khUEaNsW+JzQpxCBgUoqObCpQW690fnsDxENTYragkDNRcRSNH081YT2o0hgU7W4gxwykapvaihFC0vwVKR11TVydFuBMd3V7qdRNueZnJ8e4MuX8/b6YvoVnewpI3UNyRfS6p2UmG4/fXtUjP4UmwZyuWSxp3RygGLVzEpxu+Wg2cgdgvQzn2ZhHgC7xVSaX2QtsKtW37hWSauKIOivSoV1oA/gsElBvlRiDg07ERnITDD1NBFobntfx0Xk2jnsW7WTfCjKxM5KMF7yCaLHBWeLk29DZRmaub5DaNpXnKII8QGApiJmNwMU21lBJ6Hms1wBkGHmEx/OQ/cyah5422heyVJ3eWALbgN/beXXoGCkKywZrcue7fs5vGAqn+CNy9vlhVCZ1WfGbQIIYNzKSeF5VH+gcRsYSiCL+0cocTC0HX9yTYly3WJ5myReqCPVSwdod89wfuhfgEFqre0dESoMmSEwbi0Sua7EdhpSHAqlF+F78qJ5A8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(76116006)(66946007)(66556008)(8676002)(66476007)(64756008)(6486002)(66446008)(6512007)(83380400001)(508600001)(316002)(36756003)(26005)(186003)(6506007)(110136005)(86362001)(71200400001)(2616005)(122000001)(38100700002)(38070700005)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkNuTTRSMlRBUnFSbW1WVHlwSEJCUUNHTWRsSStaWmZTa2szYXZGUUJwOVJU?=
 =?utf-8?B?QVJDa2hLOE1rYVd4VnhkY21yTkJzeU11ZzBNbGsvdUZPTEdWY2FTTVJDV2Zw?=
 =?utf-8?B?VHBaTm9yamhFc1l1ZDZ4K2FiZ3d6SXY2SnVnajFNYUxmVDZkTjdpWlFzeCtZ?=
 =?utf-8?B?Z0xEeklXanZPTlFtUXNjRGx2VWtkN05vcnpQY1pmWm50NTVqWnJzMHFDR0Jx?=
 =?utf-8?B?RlNldk81bjJRWkJMUU1RRHY1UVdtQ1ppNFRwUDZpTi9adFd6QmMwTkpCQk83?=
 =?utf-8?B?K1QzbVlKRTJTTUx1TzNJSFE1V25EcUtiOE0wRUQvN3UxRlV1WWxDK0sxd2h5?=
 =?utf-8?B?dXVnZVFiVG5PRVc1NW9PUUZZWmdkRlh5Sk1qL04xZmZxanExdHlReXd3ZnRw?=
 =?utf-8?B?R0o0eDIzN3RhcFRldzlwdThDSEduYnJJMWdaMHcrY1ltb1hDNW5ERGVEYkFv?=
 =?utf-8?B?MUVqeGdTY2dMbHdBQm5aODdlWEN0ajVBMkJUYzR2SkNrMWlsVGUyVkJYRVY2?=
 =?utf-8?B?LzBuNFNWQ0NEbEV0a3FwVWdvSUFtTFlQRUZIUVBLUVlzVWhlRE5WT05JaWVD?=
 =?utf-8?B?cEJMaVFmeVFVRStWdVd3blhRSEgvV3JQR3FuYWhkc1drLy9CaU5mK3dPdVU5?=
 =?utf-8?B?T01OYS9mTmRLejFLREdmYWd3MFZlemxyMnNtVnBENU1idW1YLzkwdzVnNUh5?=
 =?utf-8?B?Y0tDK2p6dThNODNDdk1VZGdoVzEvZTltclFsNzBEUDM4V1l2WVhSTGhoNmJy?=
 =?utf-8?B?SmNLWXlUVHBKZmZLVTUwR0hoNXltR056MzllQ0lMZUFLYXdVR0dmQlFHME5M?=
 =?utf-8?B?ZGtLM3U4WEVjdC8xdWJvVzZaSkdXS3BYNThjejZmZktWdEhYSGVLK1NBcUN4?=
 =?utf-8?B?TzJKY1pKQ0tXRzVWa0t2T3JqQVl0aTYyTElXQWk5MXRodDBIN2Ixd0ovY3hn?=
 =?utf-8?B?UEtERE41RGVRZStOK3JCeExRZUcrdkpCVTRNNmdtSnBHdmh0bnRLM2lVN0Vp?=
 =?utf-8?B?YnUwZFVxelBnMSt6SlZtc2hXdnoraFNueVVENk52N2NMYjJ3Q2tSYTFDaTE1?=
 =?utf-8?B?VFdMVzZNdnhhejV2S0p6bEJ5T0VnWW9Xek16aHNFekgyaTNSTDIyaFErTzZt?=
 =?utf-8?B?Y2JTOEkzMFIxZktPUFNhOVJKMFlOd3JNUDN0UFJVYnFhb2d3WjRnZ1M3Zmc2?=
 =?utf-8?B?QWh1SzVGa3kyQlFESkhVRytpWU5wU1JkcHp6ZHNGdjFsZnRXUWZPMGNVSklw?=
 =?utf-8?B?MGF4eFAycHVvaHk3ZE1PaDBTcjQ0dk85V3hRNThocnlwRWhVSXhPNVZqd1d5?=
 =?utf-8?B?eHlKNStIRndQektTL1RnNHoxbHVLVGpMaFgrbXlJYVFOdHdYS2txZ3BBQit6?=
 =?utf-8?B?MkJEL2xMamdLZ3NVdlU5L3RWcEdJdHA1aGlHaGR1cE1yakpnT05rSU51MVBo?=
 =?utf-8?B?M2pxaHU3UFRtaTVJNnpmUVF1ZHIvNW9tc3RJekhza2s2S2VyRUxacXhMWVRZ?=
 =?utf-8?B?a1dvcitmTGsyQ1loUlRMOTVXcHJIYitwZVpQOG9FODRMMUN1M1RiRFZNY0p4?=
 =?utf-8?B?Zkg0ZnlOUlEySmpWbjE5YTRoTHFTcllpc3lVU3JocXRmMDFhZ3RGeGs0VDFX?=
 =?utf-8?B?R2c2NE8wdUdUVGlBaG5qU0RYUFBMdDFia2FBd3h0eFFqM21TaWppZHo4cU9V?=
 =?utf-8?B?OUY4R3c2MHI4VnhjU1FVakpldjdrb0ZvTVUwb0hBQ2tlMGQ2MExNQVNFTTBw?=
 =?utf-8?B?VHJKYnBTY3E0RTN0SlhlWDVzbytuWng5dVBsclBFQm9qR2kweHEvVEN2Ny9U?=
 =?utf-8?B?dlhOVDA2Q3U3ZWJPVVN1QTdpY2ZMYkhQcnV5UG1SMi9lZlBsTWh3aUNXeWpV?=
 =?utf-8?B?OWhpRVZHN3NxeHhXbkt3MTN1WDB3VkhpQkVRdGE5OGkvcTJWT3Y2QzI2ZWhk?=
 =?utf-8?B?UFNPUDVoVzRtUnFubldaUmlvaXBIMVB4NDFpaXU1NndQRDFQSFJsdWFIamZI?=
 =?utf-8?B?RkdpR3RBREdMcS9ha1cyd0l6dFI1VEJhb1FzMzBDdkZhemdtM2ozYWR6ditV?=
 =?utf-8?B?d2J1MzY2NGdOUXRCOVd3WGtSaEcwK0p1ZDNTbEYzTUFnTGZqa1J0V3Y0bUt2?=
 =?utf-8?B?N21iN0FncnoyWkx3UHhXTlA4bU9yamdBeXFtcEE5eUNFeVVibUhxSHlKRWNF?=
 =?utf-8?B?cnplcDIra2l5R2thQVNaSGJyV0dwRXc3RVhoUFBZaURxMFFzZFdRRUxyZ0l4?=
 =?utf-8?B?cGhLblZjb0hNZFFmMzN3a2ZnZFNTc2RaeXFnbUNLUGNaNTZuQTNKb3RpNHFy?=
 =?utf-8?B?MSsxc21HaDNORUNSalJlTEZreSt0Rlh5YWQ4NmxpR3BWNzlVVUNtQlVMVmor?=
 =?utf-8?Q?SM3rilBNDLiTUae0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41D7A453EB30BC4984D9A63D37D97A97@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2baafe0-578d-4844-3dd8-08da163f95c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 13:32:37.6710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1w+uNfzOqygx9NaTfhxb+6Lps5QGEytSn2TjHOSBYHPzQ92eYYupMS3dCoCyR1zx6VNH7pmApd4vtR1ZMJ4etg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB2936
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmtzIFN0ZXZlIQ0KDQpPbiBTdW4sIDIwMjItMDQtMDMgYXQgMjI6NTIgLTA1MDAsIFN0ZXZl
IEZyZW5jaCB3cm90ZToNCj4gTm90aWNlZCB0aGlzIHNoaWZ0LW91dC1vZi1ib3VuZHMgZXJyb3Ig
aW4gTkZTLCBhbmQgYWxzbyBzaW1pbGFyDQo+IG1lc3NhZ2VzIGxvZ2dlZCBpbiBhIGZldyBvdGhl
ciBkcml2ZXJzIHdoZW4gcnVubmluZyA1LjE4LXJjMS7CoCBJdA0KPiBzZWVtcyB0byBoYXZlIHJl
Z3Jlc3NlZCBpbiB0aGUgbGFzdCB0ZW4gZGF5cyBiZWNhdXNlIEkgZGlkbid0IHNlZSBpdA0KPiBp
biB0aGUgc2FtZSBzZXR1cCB3aGVuIHJ1bm5pbmcgYW4gZWFybGllciB2ZXJzaW9uIG9mIHRoZSBy
YyAoYWJvdXQgMTANCj4gZGF5cyBhZ28pLsKgIEFueSBpZGVhcz8NCj4gDQo+IFtTdW4gQXByIDMg
MjI6MTY6NTcgMjAyMl0gVUJTQU46IHNoaWZ0LW91dC1vZi1ib3VuZHMgaW4NCj4gbGliL3BlcmNw
dS1yZWZjb3VudC5jOjE0MDo2Mw0KPiBbU3VuIEFwciAzIDIyOjE2OjU3IDIwMjJdIGxlZnQgc2hp
ZnQgb2YgbmVnYXRpdmUgdmFsdWUgLQ0KPiA5MjIzMzcyMDM2ODU0Nzc1ODA3DQo+IFtTdW4gQXBy
IDMgMjI6MTY6NTcgMjAyMl0gQ1BVOiA3IFBJRDogMTAyMzAgQ29tbTogYWlvLWZyZWUtcmluZy13
IE5vdA0KPiB0YWludGVkIDUuMTguMC1yYzEgIzENCj4gW1N1biBBcHIgMyAyMjoxNjo1NyAyMDIy
XSBIYXJkd2FyZSBuYW1lOiBSZWQgSGF0IEtWTSwgQklPUyAwLjUuMQ0KPiAwMS8wMS8yMDExDQo+
IFtTdW4gQXByIDMgMjI6MTY6NTcgMjAyMl0gQ2FsbCBUcmFjZToNCj4gW1N1biBBcHIgMyAyMjox
Njo1NyAyMDIyXSA8VEFTSz4NCj4gW1N1biBBcHIgMyAyMjoxNjo1NyAyMDIyXSBkdW1wX3N0YWNr
X2x2bCsweDU1LzB4NmQNCj4gW1N1biBBcHIgMyAyMjoxNjo1NyAyMDIyXSB1YnNhbl9lcGlsb2d1
ZSsweDUvMHg0MA0KPiBbU3VuIEFwciAzIDIyOjE2OjU3IDIwMjJdDQo+IF9fdWJzYW5faGFuZGxl
X3NoaWZ0X291dF9vZl9ib3VuZHMrMHhmYS8weDE0MA0KPiBbU3VuIEFwciAzIDIyOjE2OjU3IDIw
MjJdID8gbG9ja19hY3F1aXJlKzB4Mjc1LzB4MzIwDQo+IFtTdW4gQXByIDMgMjI6MTY6NTcgMjAy
Ml0gPyBfcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUrMHg0MC8weDYwDQo+IFtTdW4gQXByIDMg
MjI6MTY6NTcgMjAyMl0gPyBwZXJjcHVfcmVmX2V4aXQrMHg4Ny8weDkwDQo+IFtTdW4gQXByIDMg
MjI6MTY6NTcgMjAyMl0gcGVyY3B1X3JlZl9leGl0KzB4ODcvMHg5MA0KPiBbU3VuIEFwciAzIDIy
OjE2OjU3IDIwMjJdIGlvY3R4X2FsbG9jKzB4NTAwLzB4OGYwDQo+IFtTdW4gQXByIDMgMjI6MTY6
NTcgMjAyMl0gX194NjRfc3lzX2lvX3NldHVwKzB4NTgvMHgyNDANCj4gW1N1biBBcHIgMyAyMjox
Njo1NyAyMDIyXSBkb19zeXNjYWxsXzY0KzB4M2EvMHg4MA0KPiBbU3VuIEFwciAzIDIyOjE2OjU3
IDIwMjJdIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YWUNCj4gW1N1biBB
cHIgMyAyMjoxNjo1NyAyMDIyXSBSSVA6IDAwMzM6MHg3ZjBjMzJjNTJkNmQNCj4gW1N1biBBcHIg
MyAyMjoxNjo1NyAyMDIyXSBDb2RlOiAwMCBjMyA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAw
MA0KPiA5MA0KPiBmMyAwZiAxZSBmYSA0OCA4OSBmOCA0OCA4OSBmNyA0OCA4OSBkNiA0OCA4OSBj
YSA0ZCA4OSBjMiA0ZCA4OSBjOCA0Yw0KPiA4YiA0YyAyNCAwOCAwZiAwNSA8NDg+IDNkIDAxIGYw
IGZmIGZmIDczIDAxIGMzIDQ4IDhiIDBkIGViIDgwIDBjIDAwDQo+IGY3DQo+IGQ4IDY0IDg5IDAx
IDQ4DQo+IFtTdW4gQXByIDMgMjI6MTY6NTcgMjAyMl0gUlNQOiAwMDJiOjAwMDA3ZmZmZmYzZmVk
YzggRUZMQUdTOiAwMDAwMDIwMg0KPiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDBjZQ0KPiBbU3Vu
IEFwciAzIDIyOjE2OjU3IDIwMjJdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAw
MDAwMDI3MTANCj4gUkNYOiAwMDAwN2YwYzMyYzUyZDZkDQo+IFtTdW4gQXByIDMgMjI6MTY6NTcg
MjAyMl0gUkRYOiAwMDAwN2YwYzMyYzUyZjQ3IFJTSTogMDAwMDdmZmZmZjNmZWUwOA0KPiBSREk6
IDAwMDAwMDAwMDAwMDI3MTANCj4gW1N1biBBcHIgMyAyMjoxNjo1NyAyMDIyXSBSQlA6IDAwMDA3
ZjBjMzJiNTg2YzAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwDQo+IFIwOTogMDAwMDdmZmZmZjNmZWYw
OA0KPiBbU3VuIEFwciAzIDIyOjE2OjU3IDIwMjJdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6
IDAwMDAwMDAwMDAwMDAyMDINCj4gUjEyOiAwMDAwMDAwMDAwMDAwMDBjDQo+IFtTdW4gQXByIDMg
MjI6MTY6NTcgMjAyMl0gUjEzOiAwMDAwN2ZmZmZmM2ZlZTA4IFIxNDogMDAwMDAwMDAwMDAwMDAw
MA0KPiBSMTU6IDAwMDAwMDAwMDAwMDAwMDANCj4gW1N1biBBcHLCoCAzIDIyOjE2OjU3IDIwMjJd
wqAgPC9UQVNLPg0KPiBbU3VuIEFwcsKgIDMgMjI6MTY6NTcgMjAyMl0NCj4gPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQo+ID09PT09PT09PT09DQo+IFtTdW4gQXBywqAgMyAyMjoxNjo1NyAyMDIyXQ0KPiA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gPT09PT09PT09PT0NCj4gW1N1biBBcHLCoCAzIDIyOjE2OjU3IDIwMjJdIFVCU0FO
OiBzaGlmdC1vdXQtb2YtYm91bmRzIGluDQo+IC4vaW5jbHVkZS9saW51eC9uZnNfZnMuaDo2MDY6
OQ0KPiBbU3VuIEFwcsKgIDMgMjI6MTY6NTcgMjAyMl0gbGVmdCBzaGlmdCBvZiAxIGJ5IDYzIHBs
YWNlcyBjYW5ub3QgYmUNCj4gcmVwcmVzZW50ZWQgaW4gdHlwZSAnbG9uZyBsb25nIGludCcNCg0K
SG1tLi4uIEl0IGxvb2tzIGxpa2UgaXQgaXMgYWN0dWFsbHkgY29tcGxhaW5pbmcgYWJvdXQgdGhl
IGRlZmluaXRpb24gb2YNCk9GRlNFVF9NQVggaW4gZnMuaDoNCg0KI2lmbmRlZiBPRkZTRVRfTUFY
DQojZGVmaW5lIElOVF9MSU1JVCh4KSAgICAofigoeCkxIDw8IChzaXplb2YoeCkqOCAtIDEpKSkN
CiNkZWZpbmUgT0ZGU0VUX01BWCAgICAgIElOVF9MSU1JVChsb2ZmX3QpDQojZGVmaW5lIE9GRlRf
T0ZGU0VUX01BWCBJTlRfTElNSVQob2ZmX3QpDQojZW5kaWYNCg0KU2luY2UgbG9mZl90IGlzIHNp
Z25lZCwgSSBzdXNwZWN0IGl0IGlzIHVuaGFwcHkgdGhhdCB0aGUgc2hpZnQgYnkgNjMNCm92ZXJm
bG93cyBpbnRvIGEgbmVnYXRpdmUgdmFsdWUuDQpJIGRvbid0IGtub3cgd2hvIHdyb3RlIHRoaXMg
Y29kZSAoaXQgcHJlZGF0ZXMgZ2l0KSBzbyBwdW50aW5nIHRvIEFsLg0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
