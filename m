Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569F7140D1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 15:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgAQO4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 09:56:08 -0500
Received: from mail-co1nam11on2103.outbound.protection.outlook.com ([40.107.220.103]:1856
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726827AbgAQO4I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:56:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJogqPtJXSPwlVvhByb0tqRMAdGvBa4UCS04KIZNrX1GUV8yvDpCBcgXajVhjBdpQ2HQuD3i0MTlIJgcs7w1WaD9YepLWrIEXi7gMWjAbQMt7Fv9zHsphttMW9OfvTlhRuucv7nVfxMu/muVn4IQ/J7ezafVMJVLiRdC5ghi+eLXGaNn5lRBYzhdYlYwFpG4Xvy2k14K6QyWE0YQYW0I5G9vXbfDdagQzGtwIUxrR2N1xMqkN3gRNComE+tQsWKD/pEBvdSC8BTB3d7GfuiDkESPqIBB8nNwcJjWoKusJ3xzaeQsZkkrh6ntcSYOn8DXXUt04ttTPVG+u7rElnJfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrogP8SzkYb/v0ssbw+mEszAU7StZbwG/OvhsEIDqI8=;
 b=oLH7DquCZ4Arld6h9u7Qvr5QF9EwlCsfMRaJ4gD5x4iXw4DtXkNdrKkCHcEjD15uqfX8GU/B8dlrLEqPc2eVF3ZfUznTqTLZnleZSjG1glIdBB0oHctKdSJE7pDNfmRHbMMZ1Eaae00CQ+bRYNxoCMgdFYE/0j8OLcMFeXXQqM3AG/obZdLGimE3UVnwpVnUQodmCVdcfdVA9jb7YYrcmUELe3TtNhoGKRKYS/mACUmInauwAOM9mZaOUjf4xd0Vm5rfVMUYOGBvRZTX9eTnvW9qRO31hCjNoVgCK2HtODZg8hbMInzq8RY0Pyc4Kqoi51g+9UoV6pdGS95zWF/XpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrogP8SzkYb/v0ssbw+mEszAU7StZbwG/OvhsEIDqI8=;
 b=SCeQYUugGzuX55yjJ3qqG1EYtskGPZfjva+jwGpodz1xibMQeEeUwhJ0kCWhQK90fliGdBEvFo35kTT2M+YDcfBTRjE1/B5lQ8PT5b1DoxOtV9WGjJINFmbhofQMXMPd5QeEVruYsop0uwtrWHanpt/rXMYsCwf9+HowCE7vNwc=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1930.namprd13.prod.outlook.com (10.174.187.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.12; Fri, 17 Jan 2020 14:56:06 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 14:56:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "osandov@osandov.com" <osandov@osandov.com>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Thread-Topic: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Thread-Index: AQHVzTSO+0pwcPyVr0iwCBUjAesfDKfu658AgAAECICAAAJqAA==
Date:   Fri, 17 Jan 2020 14:56:05 +0000
Message-ID: <18dad9903c4f5c63300048e9ed2a8706ad31bc73.camel@hammerspace.com>
References: <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
         <364531.1579265357@warthog.procyon.org.uk>
         <448106.1579272445@warthog.procyon.org.uk>
In-Reply-To: <448106.1579272445@warthog.procyon.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41ca83d9-d560-441b-191d-08d79b5d6128
x-ms-traffictypediagnostic: DM5PR1301MB1930:
x-microsoft-antispam-prvs: <DM5PR1301MB19308AAD1530DCDF9494FF22B8310@DM5PR1301MB1930.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(81156014)(186003)(5660300002)(4744005)(8676002)(2906002)(6506007)(6916009)(8936002)(6512007)(26005)(6486002)(86362001)(36756003)(54906003)(2616005)(316002)(4326008)(91956017)(478600001)(76116006)(66446008)(66556008)(66476007)(81166006)(66946007)(71200400001)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1930;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XVX0iQEUkhf3OBc1hZoaFsTT92C1MdTlRmRuRVXs2T0zrfZ3kOJNDSIST4uuqCMYcad9BSmFkQG/GuOe5vuYvm3sCte/nKR+WzKrqUKVGY7x9klpkhWvpVcg3frEphY8hu7w50bqjMmL4lHJ+TranFm9DdL7An3diMsdU+MTncrilTC25obORmPyCK3bKxz888l6hJT39wd7qhNyOtNtKGuoabsI+UOBrP8MEkwR7FrZExcKV9HNrwjx7DYh8AqPdBoKYSQaL5ti/qv3g4/qMbKpeiH0BFHPe5BIQJdxNXXwvCY6PaBITCJyqBvgPrMlk/29Op3q7jyGU/DbAiLpngkDmmTF7++hqFy0VwuNk1vIIbb4hln89TgxgaOcPzV4CCnPy+IbrUSvqKl+AdawyWttUKIHqMTunaIuoNoCV7CwDQ4hqO0/2TlOEpBj53Wf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1EC784496C72347A925247B68F09E80@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ca83d9-d560-441b-191d-08d79b5d6128
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 14:56:05.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxoW1YiCltBpl16ojnGtkAcg5y+qRk7wm2gUpPo3E7kvdUO989ZCcFZAFYFe8rMG+42eAvH4zToO/DL1JNxIoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1930
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTE3IGF0IDE0OjQ3ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gDQo+
ID4gVGhhdCBzZWVtcyB0byBtZSBsaWtlIGEgImp1c3QgZ28gYWhlYWQgYW5kIGRvIGl0IGlmIHlv
dSBjYW4ganVzdGlmeQ0KPiA+IGl0Ig0KPiA+IGtpbmQgb2YgdGhpbmcuIEl0IGhhcyBwbGVudHkg
b2YgcHJlY2VkZW50LCBhbmQgZml0cyBlYXNpbHkgaW50byB0aGUNCj4gPiBleGlzdGluZyBzeXNj
YWxsLCBzbyB3aHkgZG8gd2UgbmVlZCBhIGZhY2UtdG8tZmFjZSBkaXNjdXNzaW9uPw0KPiANCj4g
QW1pciBzYWlkICJUaGlzIHNvdW5kcyBsaWtlIGEgZ29vZCB0b3BpYyB0byBiZSBkaXNjdXNzZWQg
YXQgTFNGL01NDQo+IChoaW50DQo+IGhpbnQpIg0KPiANCj4gQWxzbyBDaHJpc3RvcGggSCBpcyBv
a2F5IHdpdGggdGhlIGlkZWEsIGJ1dCBzdWdnZXN0ZWQgaXQgc2hvdWxkIGJlIGENCj4gc2VwYXJh
dGUNCj4gc3lzY2FsbCBhbmQgQWwgZG9lc24ndCBzZWVtIHRvIGxpa2UgaXQuICBPbWFyIHBvc3Rl
ZCBwYXRjaGVzIHRvIGRvDQo+IHRoaXMsIGJ1dA0KPiB0aGV5IGRpZG4ndCBzZWVtIHRvIGdldCBh
bnl3aGVyZS4NCj4gDQoNCkl0IHNvdW5kcyB0byBtZSBsaWtlIHdlIHJhdGhlciBuZWVkIGEgbWV0
YS10b3BpYyBhYm91dCAiSG93IGRvIHdlIGdldA0Kc2ltcGxlIHRoaW5ncyBkb25lIGluIHRoZSBM
aW51eCBmcyBjb21tdW5pdHk/Ig0KDQpJdCBzaG91bGRuJ3QgdGFrZSBhIHRpY2tldCB0byBQYWxt
IFNwcmluZ3MgdG8gcGVyZm9ybSBzb21ldGhpbmcgc2ltcGxlDQpsaWtlIGFkZGluZyBhIG5ldyBm
bGFnIHRvIGEgc3lzY2FsbC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
