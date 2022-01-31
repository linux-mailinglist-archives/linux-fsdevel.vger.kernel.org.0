Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5091D4A4F16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358713AbiAaS6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:58:44 -0500
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:22425
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358827AbiAaS6o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:58:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j96cJpv03dOhXYF935PWS9FYIX12jWDe6kkPgym4qZGeKoebhHVaDMVtP+SIcusRuZ38Bn9U9Q3LKrYZtowONDnBEXaVIxyke4m5hFTCEgmG5XUIOAhtxf5VtNwX117YhBCoFcuglPSdglluArluIF4//XC4cGwZlj62zcrFgN5wvee4pjY1e//FnOo1/W3RYiAmp3B/ZqjyeYsAwdJBKLUH26uY0e6O119BcBMRiqIrA5naGDFr6XEqBq7ReAVIjeP3HERTMK2CgMLwl+HY69kAXGgfkjqHw5SIalmbaxrHmnXFqsFtiJRsILm2cyQMITqqL5asvKrWyn9+Vt+3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+piPlX6jivGOW0gdJQeGNMupKK3dhc2FFt788lLBa8=;
 b=RaurPbwSsJg6TZ46VY8+U/KUw/UlonuKKZ980Fd48nO2ZkAZH8jfcQtol2CFOuNUHh4BjHOICAnY5hoqe/3dY7Qdf8IaaiIgMJiz8d4fn065wZ8G1f7FcQMwYBJoYHrI+PrAp/Q1kzIeT84tas9zJ6rG1P2lUZxbgO59UVpQ2Q81I28mKV9P1OKpNEZXdFDJrc90/pwLFmJ60MhCUyTZmKi+cFlGqgvRLnWewuuDHyc/nSWgTJ8f80u9+sNYPGihVYRHhefo+2D0v5zemebFNMatnPlFVxAnuS0aiurefwYs3ibqrbjMJx7POyVLueXxtDVABGDSeS+4re3e1MD7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+piPlX6jivGOW0gdJQeGNMupKK3dhc2FFt788lLBa8=;
 b=GxPYFFJmTcAC30ECKZFDpN+ruq+WV81aLny9RmV51Ikdr8zCf0mXKo+XhmoUhIr5lZI4GL25c70dVaJDiq/z+y8GG6D1aExfUd3djMq6/J4OQ9DIKtNQL/dxI2GduuTi+mHBIxolx3hyhinF5ryEmRBtqGMG8WkST85fgD/EuBI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3699.namprd13.prod.outlook.com (2603:10b6:a03:219::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Mon, 31 Jan
 2022 18:58:40 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%6]) with mapi id 15.20.4951.011; Mon, 31 Jan 2022
 18:58:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large
 file sizes
Thread-Topic: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of
 large file sizes
Thread-Index: AQHYFs/ypcuQk9gPT06tiQmZ/LtqSax9da4AgAADLICAAAKiAA==
Date:   Mon, 31 Jan 2022 18:58:40 +0000
Message-ID: <bbc79f87d4cc26d72bc27dcdccc5011ec0b0b341.camel@hammerspace.com>
References: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
         <164365349299.3304.4161554101383665486.stgit@bazille.1015granger.net>
         <cb06de6582d9a428405af43d0cb92e0c2d04c76f.camel@hammerspace.com>
         <A3A5CC01-BDDB-4C14-A164-1AA3753DEA11@oracle.com>
In-Reply-To: <A3A5CC01-BDDB-4C14-A164-1AA3753DEA11@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3ab5879-a21f-4d21-24d3-08d9e4ebb1de
x-ms-traffictypediagnostic: BY5PR13MB3699:EE_
x-microsoft-antispam-prvs: <BY5PR13MB369956B9513C5B93FFEBCDCAB8259@BY5PR13MB3699.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: za7OLdrS32vA2Hz8vz34OoqtOGSUAnjXIr3+ZmlMTglKJjfZMqC1qPevp0WW29qQy2RjFYhXrPlv+2YypA7J9WZ7eeqRm9Xybhy+E6oXB50a1n/EtMZzeoepBZYeEEtD6igRknS37t6KlQ7ruvw/bidCPLRwv6ce/FGepWLi3Yq5pxUHjgx+GRdhQnLGuYWYuU+Z2pv/Oyqv8IdwgNkBMwMJ+lnCXXKIddBR103rmHR6WnBvsAZhN3vty1MM9mzKbhxJ6/Sd6ctyyi3Pao+dkZtV3Cj9orHShuKrxc+DXMYodlWHU//9zKBbZo50qUErghaPVQGkQ5Srkdu4tLQmf2aItmDcrs7CelohGTyua6amxiHV9/EO1P5h2y3i/dHRU/huN+vbDU3Z46YKu2ZbX55aj8t0ZelR2f3ux4P4bKJFGWA6OFq9frkHdpKFoFXIrs5JhxXmzeLQRZGk5Tvt2wKXWGySUOweuSqsSQuokNzQdmbPhJ28VbZ9iSd01c3BIt9vDGTqcks2RdUasDlUh83hN4We4DET5Qrf4iTeqKla0wTitLEP2NN1pQf3YLZ9rEclRpysU+8XuW4f0o0Q9X2CgfBETC0TzlOyezoH+C7u32ldZ9ytSrnYugOXBUNTLBkrAkmo3lfWQz02z+4AEW9NQJAo9AMGoQv4ql3Mm8otrwos/2yboCeO3uHkTALZAuDGIgxCCM3ym1OGLy6k2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(376002)(136003)(39830400003)(366004)(8676002)(53546011)(6506007)(71200400001)(8936002)(4326008)(2616005)(2906002)(86362001)(38070700005)(36756003)(6916009)(6512007)(76116006)(54906003)(6486002)(316002)(508600001)(83380400001)(122000001)(186003)(26005)(5660300002)(66476007)(66446008)(64756008)(66556008)(66946007)(38100700002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M05lczkrSTlqT05UdGFIalNSdzdIS3d3cjF4bHlRZTk3d2xWeXNEb0puYWdN?=
 =?utf-8?B?VXQwbjRmL1VJbmtITUEvdHdveHZZOXRVNXM2NTBFSmFpc1UraFdYU3hRVm5o?=
 =?utf-8?B?ZkJ4ZFpaMFFWa2I5cXhQek5jZ2J4WitWVXZFa0xLR1lGL21yVEFhUWlJM2FY?=
 =?utf-8?B?RVMyV2lRMG5qcVAra29pVUplOVRxTTkyL0hzVHRUN2VRNUt4N1pnTVBsQmJJ?=
 =?utf-8?B?WXpoeU1OSzJMbUVjQW5uazRFbUk3UXZZNzdVdWlxNGhldFNNYmdmalNXRTgx?=
 =?utf-8?B?NitlQzA5YVc3b1FUQjdVK0I1UDlXMG5uTU12TlBhVkZWQWMyUDRocGRHcyt3?=
 =?utf-8?B?UjlXMjRrb3V4cVhGL282MXhiV1o4Y0JFRmt3ZWdOaXJ0cHhYUUZmK3Z5RzE0?=
 =?utf-8?B?KzVvWnFCb1pmU3UyYWN5SEFNTEhia0JYNWdlcWVpZ05vU1dQVWwxc0dxdlRU?=
 =?utf-8?B?NEV2bUE1QklwWGFiTlFrcG5Pb2Z2dEhtaDRldmdCOThra0RKREVwMHF0TWhV?=
 =?utf-8?B?MVgwcDV2K1AwdDhoUlJHNW9sVDd0VG1NT0x3OGlwN0ZRbDAvaVhiaUVDWUgz?=
 =?utf-8?B?NXdrc1NMNVV4dWFSeEl4WldpMXQ3OEFIRGRoQlhTZzRQUytWUFUySUt3NmtL?=
 =?utf-8?B?WkY3c3BIdFA3UDRLUUFQVU9yeGJWa2cwak9WMUROV3l1MUFLakZVbHZucWY4?=
 =?utf-8?B?Z01nd2dEMlg2RVVMUVg0MTU2ejU2cE14UTVKQ0lDaUw3czdJdktCMG5sQTNN?=
 =?utf-8?B?dFViQS8zejhISjBjQWZtdVZsVzF0Zm5vT1BoLzNEVlZyVVNING5QNkV5cUdI?=
 =?utf-8?B?VTYrRitoRjN1V0ovZ2liYlE1cGR5c0hKamJ6QTlpMk85YVhXR29UaTk1ZzQw?=
 =?utf-8?B?ZHlsVk5obFlOQjM4S2NyVUlGZEUwdWJPa0Q1R2tycGp4VmMyNGNvTnRIdHdG?=
 =?utf-8?B?ejlLeUI3RjFRYkRUUmtIOUd0SzUyNG5CMURTcWdWanBjbldvTlBrKzVQczhX?=
 =?utf-8?B?Q3J2RnRXNWFoYmI2RDZTTlJpdGsvdFU1dUplWUtRcWZPNU5DMFpoeVBkc2to?=
 =?utf-8?B?eG42ZVdqK1hmZXRrc0xrc1VXTzRHMXpQSUJLMGxMYXIvem8rc0NZendNcCtF?=
 =?utf-8?B?a2d3WnZrQTNFbG81cUxONXFBTG1FSy9yczIvM1FXYjlhb0xnNEZGQ3RyZEtz?=
 =?utf-8?B?UFRJN1RzRmpGUkxnNlZBWjhGTytycmNabGE5OWNUMHlzZHZXaXBtTGxEU2hJ?=
 =?utf-8?B?MFhSRjRHaTVPNlpaWU9mN0t6d1U2VkdlQkk4YjZCblBJTDU1QXliSUUrTFY5?=
 =?utf-8?B?QjE4MHJJWkcxK0lFSmVPRnYyUEJualRoSVF5UkFPbnBJYW9HTjM3ZWZDZTh3?=
 =?utf-8?B?d1JDd2p5bzJicXVwRTBBNU14cnZyV28wOXRRWmFVbEx5elp6SzllSEx0QytX?=
 =?utf-8?B?TjMyYTVubTJnaG5Kazh6YlIvMEFUd0NhL2ppUzNpVmk5Sk56dzBqaS9XRnRx?=
 =?utf-8?B?NW1PVEdKc0JTZkhqcnY2dU9xbnlxV0xodDZZZVdjdHZBYVc0VStPUGVnaWpM?=
 =?utf-8?B?d2RnWVE0V3JjVzU3N1kydlIyYkZiK2hyMzE0UUVGbjBJNzRXdWJONnRpL1pj?=
 =?utf-8?B?NFp4cjIrM2kwSjU1bG9EeG9oZnM0ckx5RnRnK09aVklsbUJteGZPTFlvaEhz?=
 =?utf-8?B?V1ZoYmsrb0xZeGpJcGhybFd1OTBIUHR2WEFhR05RT1k0MHByaU9vci80Mml6?=
 =?utf-8?B?bEo5VlAyaG9USXdtKy9rcVcycnhLSW9UWGtwL0p1eU1OMTE1RUh5T0JEamtP?=
 =?utf-8?B?cWhNa3lLMUJneExkRzBzWWhjSHpQZ2tsMlNzb2Y4K2kxZytwUHppSHlLU3B6?=
 =?utf-8?B?MllsQm9FWjM2aGdMNHhkVytrUk14UDVoNlpFcEJWZVVVZ2g3ZlMzOC9YcnRE?=
 =?utf-8?B?N2NncWhHQU1EYzdWVHhBR3N0cU5XQVc5NE5lZXQ4S2h6N0J0NnJyOEpmNWxj?=
 =?utf-8?B?UlpPZmt6bnIxalJKYnN0VHBqdStSaXJ3cmt4KzJQVGx0OGZRN0Znd0RZWU52?=
 =?utf-8?B?VGExR1A1Nk1WTEh4M0JxeUhRdEV5ZWtuRDVlaTlkTStBNGVKTXVOdEg4L01w?=
 =?utf-8?B?WlFsb1F2Vnp2SDBURFNVZXArcXBqbktCYjNVYmtYN05mYWdSUEp3OXFtNjRp?=
 =?utf-8?Q?AfXBcRP2vS+44AhoQYSo9XI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBC5B96A5DBC954DACCE6521807CD476@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ab5879-a21f-4d21-24d3-08d9e4ebb1de
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 18:58:40.0959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfgjPDo1HooZx/2Yq0pBv/xo8ev29OJSa/Rne5wsqvWkTpLHTOqJ6jXv2oQZ0Oetc96d4X2xZEyKYr/esResgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3699
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTMxIGF0IDE4OjQ5ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKYW4gMzEsIDIwMjIsIGF0IDE6MzcgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9u
LCAyMDIyLTAxLTMxIGF0IDEzOjI0IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+IGlh
dHRyOjppYV9zaXplIGlzIGEgbG9mZl90LCBzbyB0aGVzZSBORlN2MyBwcm9jZWR1cmVzIG11c3Qg
YmUNCj4gPiA+IGNhcmVmdWwgdG8gZGVhbCB3aXRoIGluY29taW5nIGNsaWVudCBzaXplIHZhbHVl
cyB0aGF0IGFyZSBsYXJnZXINCj4gPiA+IHRoYW4gczY0X21heCB3aXRob3V0IGNvcnJ1cHRpbmcg
dGhlIHZhbHVlLg0KPiA+ID4gDQo+ID4gPiBTaWxlbnRseSBjYXBwaW5nIHRoZSB2YWx1ZSByZXN1
bHRzIGluIHN0b3JpbmcgYSBkaWZmZXJlbnQgdmFsdWUNCj4gPiA+IHRoYW4gdGhlIGNsaWVudCBw
YXNzZWQgaW4gd2hpY2ggaXMgdW5leHBlY3RlZCBiZWhhdmlvciwgc28gcmVtb3ZlDQo+ID4gPiB0
aGUgbWluX3QoKSBjaGVjayBpbiBkZWNvZGVfc2F0dHIzKCkuDQo+ID4gPiANCj4gPiA+IE1vcmVv
dmVyLCBhIGxhcmdlIGZpbGUgc2l6ZSBpcyBub3QgYW4gWERSIGVycm9yLCBzaW5jZSBhbnl0aGlu
Zw0KPiA+ID4gdXANCj4gPiA+IHRvIFU2NF9NQVggaXMgcGVybWl0dGVkIGZvciBORlN2MyBmaWxl
IHNpemUgdmFsdWVzLiBTbyBpdCBoYXMgdG8NCj4gPiA+IGJlDQo+ID4gPiBkZWFsdCB3aXRoIGlu
IG5mczNwcm9jLmMsIG5vdCBpbiB0aGUgWERSIGRlY29kZXIuDQo+ID4gPiANCj4gPiA+IFNpemUg
Y29tcGFyaXNvbnMgbGlrZSBpbiBpbm9kZV9uZXdzaXplX29rIHNob3VsZCBub3cgd29yayBhcw0K
PiA+ID4gZXhwZWN0ZWQgLS0gdGhlIFZGUyByZXR1cm5zIC1FRkJJRyBpZiB0aGUgbmV3IHNpemUg
aXMgbGFyZ2VyIHRoYW4NCj4gPiA+IHRoZSB1bmRlcmx5aW5nIGZpbGVzeXN0ZW0ncyBzX21heGJ5
dGVzLg0KPiA+ID4gDQo+ID4gPiBIb3dldmVyLCBSRkMgMTgxMyBwZXJtaXRzIG9ubHkgdGhlIFdS
SVRFIHByb2NlZHVyZSB0byByZXR1cm4NCj4gPiA+IE5GUzNFUlJfRkJJRy4gRXh0cmEgY2hlY2tz
IGFyZSBuZWVkZWQgdG8gcHJldmVudCBORlN2MyBTRVRBVFRSDQo+ID4gPiBhbmQNCj4gPiA+IENS
RUFURSBmcm9tIHJldHVybmluZyBGQklHLiBVbmZvcnR1bmF0ZWx5IFJGQyAxODEzIGRvZXMgbm90
DQo+ID4gPiBwcm92aWRlDQo+ID4gPiBhIHNwZWNpZmljIHN0YXR1cyBjb2RlIGZvciBlaXRoZXIg
cHJvY2VkdXJlIHRvIGluZGljYXRlIHRoaXMNCj4gPiA+IHNwZWNpZmljIGZhaWx1cmUsIHNvIEkn
dmUgY2hvc2VuIE5GUzNFUlJfSU5WQUwgZm9yIFNFVEFUVFIgYW5kDQo+ID4gPiBORlMzRVJSX0lP
IGZvciBDUkVBVEUuDQo+ID4gPiANCj4gPiA+IEFwcGxpY2F0aW9ucyBhbmQgTkZTIGNsaWVudHMg
bWlnaHQgYmUgYmV0dGVyIHNlcnZlZCBpZiB0aGUgc2VydmVyDQo+ID4gPiBzdHVjayB3aXRoIE5G
UzNFUlJfRkJJRyBkZXNwaXRlIHdoYXQgUkZDIDE4MTMgc2F5cy4NCj4gPiA+IA0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+IMKgZnMvbmZzZC9uZnMzcHJvYy5jIHzCoMKgwqAgOSArKysrKysrKysNCj4gPiA+
IMKgZnMvbmZzZC9uZnMzeGRyLmPCoCB8wqDCoMKgIDIgKy0NCj4gPiA+IMKgMiBmaWxlcyBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYg
LS1naXQgYS9mcy9uZnNkL25mczNwcm9jLmMgYi9mcy9uZnNkL25mczNwcm9jLmMNCj4gPiA+IGlu
ZGV4IDhlZjUzZjY3MjZlYy4uMDJlZGM3MDc0ZDA2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmZz
ZC9uZnMzcHJvYy5jDQo+ID4gPiArKysgYi9mcy9uZnNkL25mczNwcm9jLmMNCj4gPiA+IEBAIC03
Myw2ICs3MywxMCBAQCBuZnNkM19wcm9jX3NldGF0dHIoc3RydWN0IHN2Y19ycXN0ICpycXN0cCkN
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIGZoX2NvcHkoJnJlc3AtPmZoLCAmYXJncC0+ZmgpOw0KPiA+
ID4gwqDCoMKgwqDCoMKgwqAgcmVzcC0+c3RhdHVzID0gbmZzZF9zZXRhdHRyKHJxc3RwLCAmcmVz
cC0+ZmgsICZhcmdwLQ0KPiA+ID4gPmF0dHJzLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmdwLT5j
aGVja19ndWFyZCwgYXJncC0NCj4gPiA+ID4gZ3VhcmR0aW1lKTsNCj4gPiA+ICsNCj4gPiA+ICvC
oMKgwqDCoMKgwqAgaWYgKHJlc3AtPnN0YXR1cyA9PSBuZnNlcnJfZmJpZykNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlc3AtPnN0YXR1cyA9IG5mc2Vycl9pbnZhbDsNCj4g
PiA+ICsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBycGNfc3VjY2VzczsNCj4gPiA+IMKg
fQ0KPiA+ID4gwqANCj4gPiA+IEBAIC0yNDUsNiArMjQ5LDExIEBAIG5mc2QzX3Byb2NfY3JlYXRl
KHN0cnVjdCBzdmNfcnFzdCAqcnFzdHApDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCByZXNwLT5zdGF0
dXMgPSBkb19uZnNkX2NyZWF0ZShycXN0cCwgZGlyZmhwLCBhcmdwLT5uYW1lLA0KPiA+ID4gYXJn
cC0+bGVuLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXR0ciwgbmV3ZmhwLCBhcmdwLQ0KPiA+
ID4gPmNyZWF0ZW1vZGUsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAodTMyICopYXJncC0+dmVy
ZiwgTlVMTCwNCj4gPiA+IE5VTEwpOw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoCAvKiBD
UkVBVEUgbXVzdCBub3QgcmV0dXJuIE5GUzNFUlJfRkJJRyAqLw0KPiA+ID4gK8KgwqDCoMKgwqDC
oCBpZiAocmVzcC0+c3RhdHVzID09IG5mc2Vycl9mYmlnKQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVzcC0+c3RhdHVzID0gbmZzZXJyX2lvOw0KPiA+ID4gKw0KPiA+ID4g
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJwY19zdWNjZXNzOw0KPiA+ID4gwqB9DQo+ID4gPiDCoA0K
PiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzM3hkci5jIGIvZnMvbmZzZC9uZnMzeGRyLmMN
Cj4gPiA+IGluZGV4IDdjNDViYTRkYjYxYi4uMmU0N2EwNzAyOWYxIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZnMvbmZzZC9uZnMzeGRyLmMNCj4gPiA+ICsrKyBiL2ZzL25mc2QvbmZzM3hkci5jDQo+ID4g
PiBAQCAtMjU0LDcgKzI1NCw3IEBAIHN2Y3hkcl9kZWNvZGVfc2F0dHIzKHN0cnVjdCBzdmNfcnFz
dCAqcnFzdHAsDQo+ID4gPiBzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLA0KPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh4ZHJfc3RyZWFtX2RlY29kZV91NjQoeGRyLCAmbmV3
c2l6ZSkgPCAwKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWFwLT5pYV92YWxpZCB8PSBBVFRSX1NJWkU7DQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpYXAtPmlhX3NpemUgPSBtaW5fdCh1NjQsIG5ld3NpemUsDQo+ID4gPiBORlNf
T0ZGU0VUX01BWCk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpYXAtPmlh
X3NpemUgPSBuZXdzaXplOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gwqDCoMKgwqDC
oMKgwqAgaWYgKHhkcl9zdHJlYW1fZGVjb2RlX3UzMih4ZHIsICZzZXRfaXQpIDwgMCkwDQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gDQo+
ID4gPiANCj4gPiANCj4gPiBOQUNLLg0KPiA+IA0KPiA+IFVubGlrZSBORlNWNCwgTkZTdjMgaGFz
IHJlZmVyZW5jZSBpbXBsZW1lbnRhdGlvbnMsIG5vdCBhIHJlZmVyZW5jZQ0KPiA+IHNwZWNpZmlj
YXRpb24gZG9jdW1lbnQuIFRoZXJlIGlzIG5vIG5lZWQgdG8gY2hhbmdlIHRob3NlDQo+ID4gaW1w
bGVtZW50YXRpb25zIHRvIGRlYWwgd2l0aCB0aGUgZmFjdCB0aGF0IFJGQzE4MTMgaXMNCj4gPiB1
bmRlcnNwZWNpZmllZC4NCj4gPiANCj4gPiBUaGlzIGNoYW5nZSB3b3VsZCBqdXN0IHNlcnZlIHRv
IGJyZWFrIGNsaWVudCBiZWhhdmlvdXIsIGZvciBubyBnb29kDQo+ID4gcmVhc29uLg0KPiANCj4g
U28sIEkgX2hhdmVfIGJlZW4gYXNraW5nIGFyb3VuZC4gVGhpcyBpcyBub3QgYSBjaGFuZ2UgdGhh
dA0KPiBJJ20gcHJvcG9zaW5nIGJsaXRoZWx5Lg0KPiANCj4gV2hpY2ggcGFydCBvZiB0aGUgY2hh
bmdlIGlzIHdyb25nLCBhbmQgd2hpY2ggY2xpZW50cyB3b3VsZA0KPiBicmVhaz8gU29sYXJpcyBO
RlN2MyBzZXJ2ZXIgaXMgc3VwcG9zZWQgdG8gcmV0dXJuIE5GUzNFUlJfRkJJRw0KPiBpbiB0aGlz
IGNhc2UsIEkgYmVsaWV2ZS4gTkZTRCBjb3VsZCByZXR1cm4gTkZTM0VSUl9GQklHIGluDQo+IHRo
ZXNlIGNhc2VzIGluc3RlYWQuDQo+IA0KPiBJcyB0aGVyZSBzb21ld2hlcmUgdGhhdCB0aGUgYmVo
YXZpb3Igb2YgdGhlIHJlZmVyZW5jZQ0KPiBpbXBsZW1lbnRhdGlvbiBpcyBkb2N1bWVudGVkPyBJ
ZiB0aGUgY3VycmVudCBYRFIgZGVjb2Rlcg0KPiBiZWhhdmlvciBpcyBhIGRlIGZhY3RvIHN0YW5k
YXJkLCB0aGF0IHNob3VsZCBiZSBub3RlZCBpbiBhDQo+IGNvbW1lbnQgaGVyZS4NCj4gDQo+IA0K
DQpQbGVhc2UgcmV0dXJuIE5GUzNFUlJfRkJJRyBpbiB0aGUgc2V0YXR0ciBjYXNlLCBhbmQganVz
dCBkcm9wIHRoZQ0KY3JlYXRlIGNoYW5nZSAoZG9fbmZzZF9jcmVhdGUoKSBjYW4gbmV2ZXIgcmV0
dXJuIEVGQklHIGdpdmVuIHRoYXQgbmZzZA0KYWx3YXlzIG9wZW5zIHRoZSBmaWxlIHdpdGggT19M
QVJHRUZJTEUpLg0KDQpUaGVyZSBpcyBubyBkb2N1bWVudCBvdGhlciB0aGFuIHRoZSBTb2xhcmlz
IGFuZCBMaW51eCBORlMgY29kZS4gUkZDMTgxMw0Kd2FzIG5ldmVyIGludGVuZGVkIGFzIGFuIElF
VEYgc3RhbmRhcmQsIGFuZCBuZXZlciBzYXcgYW55IGZvbGxvdyB1cC4NCk5vdGhpbmcgZWxzZSB3
YXMgcHVibGlzaGVkIGZvbGxvd2luZyB0aGUgQ29ubmVjdGF0aG9uIHRlc3RpbmcgZXZlbnRzDQp3
aGljaCBkZXRlcm1pbmVkIHRoZSB3aXJlIHByb3RvY29sLg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
