Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49B031BE7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhBOQKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 11:10:52 -0500
Received: from mail-eopbgr770090.outbound.protection.outlook.com ([40.107.77.90]:9518
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232747AbhBOQDN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:03:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6aLwAVfdxMZjAsWo265D0wP6AioUyOPQkeEqDOnTFyuiXuISZiINRRlpg3KUQbNc6Q66S4Pti2dBKaq1JsW80GXeSq0aszNXdlAOZSEvkY6Jq8KYO4MVeW4VlDAGD4IQQzZxyz+oERyrN6VI1EWUeOVx/pEDfScTFzfr3J7RlK1SCceD63Oh4cdjr/riaUj+X+udEgAfTG7HkXv8E+wUKjUWaWdVRMnvPo4orio6FoDCczhuPCEtV5KnVsRmS+D6Y3oGZpDL1LuEZ85TTS+fNp/btK0SEIjsiwnn/zkW+XLFEc228e+h3rAkFIzvQ3dA/9JwtZ/FEIep9lDFb7d7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaGNQARnwpEkL1xtIrvWd4c7lfcd0NMUQPoWZ/HnLps=;
 b=RLZbs5mpRkBfBX4bB86c9enmyXl+53IHw/3vuQd2fyBauKG1Go+RkQ/6+v2fJGJKq177pEJzGXbDbaHjAv/oHq6uB2OOjJGZf5eFdZVeslF1GZpG0BCn8brEDEU+mhKnGbuRB5t9T3vmuD7VPxnAxPX76ruGFKyxCj5K41pB4TwxRBRnGNpRYtqeCrKEZsIKtStLQt/EdHnC887w6jxqIIe6z+XyYZE6421NS5/XCnJJ5Z7oWiNlPoWtGRYptfwmltD+K8p9g8EHWER/JUpd1RdAWNR5UAoydlN97MlctNigZVMU535SaCUDif0q9kdOEJz8kWQiDr9rdArLXiPXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaGNQARnwpEkL1xtIrvWd4c7lfcd0NMUQPoWZ/HnLps=;
 b=P3eOoel3tAJ+g7XCd82wEpMt+y1KxGExfelQrJRWJgT+ZbOy4SxbK+s0uui1jXcgpJHVNMc+GzIVxtgIKNk1fzmwka5Z9pmCTpQ5y+EVJvIcz+kUHs3eKuEt7qH+n3NkInrbaQ+H4ARIRmMV8z0yEmOIygiC28Xb7SB64Dog+1w=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3847.namprd13.prod.outlook.com (2603:10b6:610:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Mon, 15 Feb
 2021 16:02:20 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3868.025; Mon, 15 Feb 2021
 16:02:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "iant@google.com" <iant@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "llozano@chromium.org" <llozano@chromium.org>,
        "lhenriques@suse.de" <lhenriques@suse.de>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>
CC:     "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Thread-Topic: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Thread-Index: AQHXA7EmiAMwHAQV80CDyBR44E7wi6pZYHkA
Date:   Mon, 15 Feb 2021 16:02:20 +0000
Message-ID: <ec3a5337b9da71a7bc9527728067a4a3d027419b.camel@hammerspace.com>
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
         <20210215154317.8590-1-lhenriques@suse.de>
In-Reply-To: <20210215154317.8590-1-lhenriques@suse.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cce1c63a-bf40-438b-352a-08d8d1cb1335
x-ms-traffictypediagnostic: CH2PR13MB3847:
x-microsoft-antispam-prvs: <CH2PR13MB3847F931D8B7941CA1C3D946B8889@CH2PR13MB3847.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9ABEgRiSzR5EEdXJSG8JT3ZqLuy+vYu6QX0oSH8q3s9gde3nmI0dwlJ7XtvwWzA8lKsi4NTrLuk9cCPiLGHfLsp5d16JtwYwywovDXcVVPQvZ1H9h88m1PjFoABw2ijX6MXqTt6EAMtjPj7Gp92MWYaCgXUWF/9ZLI5VJIGDKNs1fxx8SJ2BDrGHInDS+jfwrJUOH6v9JC8UdsDu2skR3FxtbzL36H9kpJI0u3nhTp1mNxRfF3KOZ6w9HE0/KrcM8o+1+k6bjncbzCwBioUZNN4AFr6kj/kvY4lnkooxsQnnoXFlZd67m7fxW09A0my3RtZTGPFMpdE7Sw4uPVpg0mewkteToc2ddCk13ujAfpmBvwTAfhwq7sSyEU+8I8jqUgOpzl4XYoGqjmI1BL3fJ2f0gwfpoeUYD39dKIIGsV/DWP0HR0MzTC2Z2CW/MOd2+8a0ejA8MKdzoadpa5c4MJNAGluOYK14Tz0dKz3moSoSBjfObQvjR8eHvSwMeISJ1vpRO+UCWntjwykhaCqnvJ6xOSelb0yEyh5uzpMaRUeFz02hPVsMPGgE25IPKcM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(39830400003)(346002)(4744005)(5660300002)(8676002)(76116006)(66476007)(2616005)(66556008)(71200400001)(921005)(66946007)(64756008)(66446008)(478600001)(8936002)(6512007)(36756003)(2906002)(316002)(186003)(26005)(7416002)(86362001)(4326008)(6506007)(110136005)(6486002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bXRMME1vZW1YZkR6eXBPaXl0U2hGYkdNQ2FKRmFmZExNYk1mTEptc0kvSUFx?=
 =?utf-8?B?OU5EYkdBY0VtaElCZ2QzeW50cTB2elgwNE9EaTY4aDVpZkd2MzZVM1lhQzgx?=
 =?utf-8?B?ei9kM3RsY2V5M3V0bkkvTW5zTlVidjRKZlA3TVhVd1BEdmtUMXJIdGdCaTh4?=
 =?utf-8?B?SURja3J0N0d2Y09seW4zZUFwWWk2NU9uMlZlUHBrcFN3dXJoY0FXN21BamhJ?=
 =?utf-8?B?eExxR2VhaCtNYXVrYXplL2RsYlZJbTQ0TmloNHZnRkF2UzdwTmh4bC9sYUs5?=
 =?utf-8?B?MWI2cU1VNEMrUEwrU2lHblNhb1F5OXdsL3FoVGJTODF5cU8vR3NOK1hvOHJI?=
 =?utf-8?B?UVcycWN3Y3NYd091TzBEbmhRdTdpeHdYRDdtRFlvaGZtN2E0RGp4ZFBmNndH?=
 =?utf-8?B?Tk9sckY2cVI1eG0rSWFvaE92VHJrb3A0V0VqZHRQOGp6RG12bXlvTFRVaTJS?=
 =?utf-8?B?bmNxS2dyQW43QmdXWEZ5aXhzWDFla2ZIdWdlWDROdzVaaWxyMjVmU2lrYy9a?=
 =?utf-8?B?VHJlc2U2TVNNVzVFTTNiT01DRzEydWR4clkxUndoejc1MGZVSlRHYThDZzRt?=
 =?utf-8?B?M2VRUk1zT3ppMjBjOWFzbjlURkliU0poZTVVRkNCQ0pXTWNFSUpvQ2sza1Q2?=
 =?utf-8?B?UHNZczY5WHdRb20zaXlGRGM3OFh1ZklhdnRseU9nT2g3OEVsVTRRbURGbmlY?=
 =?utf-8?B?aWZQMlhZbHR2bG1rMUZyeW0ybU9FVzgvOExCcXNlYUt6eTNVSFZSNG14dEVp?=
 =?utf-8?B?ekkzWDV1dHM2akdqY2FDZG1lVHVTS3VZUzA4ek1PNjJnNmwxdDdURFpiTW5D?=
 =?utf-8?B?eWJicklKSmZSa2dMcEYrNzF1YlFpbjNQRmZFTkhuWTRsdEhVa0EyUkpQcGdz?=
 =?utf-8?B?U3hSYndFeHRsdEQ2Qjc1dFdaZ0QzbGJLbTVGQWtmWDdINWQvaWtSV1FEc0lV?=
 =?utf-8?B?QkErOVVuR0tSYUgvYjBxd2ZHK1lPRTVzSGd0SHV1aWs1YUl0M09zTW1DK3Bx?=
 =?utf-8?B?ZTZPZHdaYk9lR2dVaFBzTGlzajlvdmdzQmhIczFGVEtrVDNxSGgzMmZLTjE2?=
 =?utf-8?B?bWFSUTVSYkg1RGk5RlhJbWlKMnRDMHl5UzlJTFpyT0dyUEhtTDkvVzErZTNS?=
 =?utf-8?B?UDN0Ykk5R2RwMTI0N29rSS9LazNZMTdXa0pNcFVOaDdZNU5TWGZvWDJ1OU1o?=
 =?utf-8?B?RGRJa3JWNTh4WklFQWM4QmIzYVV0VlIvUFUzcGppdXVVaU10a2l3cmpEenV0?=
 =?utf-8?B?aExqWG92eWFRNWdOY3h6YlpNL0F6WWdsdUg0Wlc4VU9BVndXOHhxVFY0YS9r?=
 =?utf-8?B?NUhNN1dUdnIwQnBhS1E2Uk4waVZZSkF3Vit1VDVqeXQ2b2lQaHlFWGZCVWRN?=
 =?utf-8?B?Z0ZNdDJsTHA2bWVrWGlsQWg2SUpNeWszdnhVNGc4UjNsdVlsYkF4aEFQS3Vw?=
 =?utf-8?B?SG9CMzNnSmNuaWhNSTZpL29TR0ptYzdyck9qTHE1UUZuaWFacTJ3dkFIalM3?=
 =?utf-8?B?YzJmdUdDbkFYb2JiWElUcW1nM0JmcTNPUFVBWTNKU0pwSUF4OEszVlJLN2U5?=
 =?utf-8?B?NzBEYnhSM0ZuV0ZmYjJSYk9nYmdSWkxyR2RKRjhodEZ2QnIrakN4M2ZxN1Fj?=
 =?utf-8?B?c2ZBY2VwOFVnR1FNNzRtSU83MDc4VGE4OXEveld5VE9DNHB0eFJmQUdlWkwr?=
 =?utf-8?B?SmxLaW5nd2NGcWkyaDdLTnhrN2NUY1E3Sy96MFRxc1MyMEcrMjYwdlFLdm5Q?=
 =?utf-8?Q?hprbA0Zf+DathyxUfrHvC9JYCcmmNR2LzsEvJA6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8AFBCC046D0CD4A93A0E77383E79F0E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce1c63a-bf40-438b-352a-08d8d1cb1335
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 16:02:20.2906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrWcB+/NEhJ3P1I1hOJLlJrWrtegOKOwavZ0CVt3PhhrjSwet3yO53mLpJ8hxYIIvOZZap6EQDa4v4wqISs1Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3847
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTE1IGF0IDE1OjQzICswMDAwLCBMdWlzIEhlbnJpcXVlcyB3cm90ZToN
Cj4gTmljb2xhcyBCb2ljaGF0IHJlcG9ydGVkIGFuIGlzc3VlIHdoZW4gdHJ5aW5nIHRvIHVzZSB0
aGUNCj4gY29weV9maWxlX3JhbmdlDQo+IHN5c2NhbGwgb24gYSB0cmFjZWZzIGZpbGUuwqAgSXQg
ZmFpbGVkIHNpbGVudGx5IGJlY2F1c2UgdGhlIGZpbGUNCj4gY29udGVudCBpcw0KPiBnZW5lcmF0
ZWQgb24tdGhlLWZseSAocmVwb3J0aW5nIGEgc2l6ZSBvZiB6ZXJvKSBhbmQgY29weV9maWxlX3Jh
bmdlDQo+IG5lZWRzDQo+IHRvIGtub3cgaW4gYWR2YW5jZSBob3cgbXVjaCBkYXRhIGlzIHByZXNl
bnQuDQoNClRoYXQgZXhwbGFuYXRpb24gbWFrZXMgbm8gc2Vuc2Ugd2hhdHNvZXZlci4gY29weV9m
aWxlX3JhbmdlIGlzIGEgbm9uLQ0KYXRvbWljIG9wZXJhdGlvbiBhbmQgc28gdGhlIGZpbGUgY2Fu
IGNoYW5nZSB3aGlsZSBiZWluZyBjb3BpZWQuIEFueQ0KZGV0ZXJtaW5hdGlvbiBvZiAnaG93IG11
Y2ggZGF0YSBpcyBwcmVzZW50JyB0aGF0IGlzIG1hZGUgaW4gYWR2YW5jZQ0Kd291bGQgdGhlcmVm
b3JlIGJlIGEgZmxhdyBpbiB0aGUgY29weSBwcm9jZXNzIGJlaW5nIHVzZWQgKGkuZS4NCmRvX3Nw
bGljZV9kaXJlY3QoKSkuIERvZXMgc2VuZGZpbGUoKSBhbHNvICdpc3N1ZScgaW4gdGhlIHNhbWUg
d2F5Pw0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
