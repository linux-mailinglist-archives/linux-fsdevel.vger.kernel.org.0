Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4548DA59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 16:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiAMPBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 10:01:34 -0500
Received: from mail-bn8nam12on2113.outbound.protection.outlook.com ([40.107.237.113]:24032
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233641AbiAMPBd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:01:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FETtl1unzFELjl/aQHT6QGM+roreqjYxoPxErbUghVwjch1mVa0w3P32CEDoCoyp8ZU4YtKi4j7DzShlcG0soBRi3W2F1MoDcaNoDIdNNEasHgdL4U8p2meGz/7a9c0WwVWxLjhi4wjqlLc2j6QzePRAgsSMEJ4oTRB8t6L/+j5x2UyYkJ4kUPzzEuz7xph77+Y5Ua7hGaBDPy+EHqTdTbLK7stns1q0fJ+NnKdc54ghUa9Sm8Xm0412xbW6r+vRhEKe0ZlELLjHaXTZlpHUJyakOC+x+6m+BMEOhOsgdsglyz4IULV9jqy7sKv/vTuizf4+QTAId8F8oCk5orYQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21/MynYo58MU+jCwLSFgFzZ6d5KB221DT0m+80EG9Jk=;
 b=gxF4zh2md95kEYhP/qxd5ghl3RqXbcwNlfGf+nDsYHLZ/HCX7Au10ZzX6ZaIlaISv3cCJqAvu4iHaIAwJHJY4ImSY1aLMptcQZd06YqLpR+GFnRxrE1p+ZahXrx8OjECn3ocDmr9UiaNpZ3lDNH/G332FtKUksu3VOY32SAFkg5SlkdEq8J++84IGXLQeSJxqfnvPn790/ScX75fNNdaAX67PnVMrPc9o/Q229MnoE+pmNN9PSABLI10Su9EOH3PdJvhUsT4R61y4N7Tn3QsxjSOjc3uCiBVDZM1vXjpSdvn8kSHWVaMkgMjb7zi3rpA7YH0gs/FTlwkl0aODTGe/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21/MynYo58MU+jCwLSFgFzZ6d5KB221DT0m+80EG9Jk=;
 b=MgAFis2Sx7p3BmfrVkSh8KKpgcdIJUgeIF3Y1fjxydDU+iEumrm+WTs/rEqFA+QBKmvI5J/ZW0w3MjwVXuXvj+Wp8NQdMFmeeCDdWhBRBFkOWz5s5Q9vKmN+g1YurMlqsKZ2T9xvtNh2Si8TXKOTDW3dEoywKdIO/PXlfv8W4ww=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1736.namprd13.prod.outlook.com (2603:10b6:903:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.2; Thu, 13 Jan
 2022 15:01:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%4]) with mapi id 15.20.4909.002; Thu, 13 Jan 2022
 15:01:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>
CC:     Lance Shelton <Lance.Shelton@hammerspace.com>,
        Richard Sharpe <Richard.Sharpe@hammerspace.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "almaz.alexandrovich@paragon-software.com" 
        <almaz.alexandrovich@paragon-software.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
Thread-Topic: [bug report] NFS: Support statx_get and statx_set ioctls
Thread-Index: AQHYBr7uESfB0KyML0ueAstOBZLgUaxdgnIAgAGESgCAAgimgA==
Date:   Thu, 13 Jan 2022 15:01:28 +0000
Message-ID: <37bf7b741729024225c9353bf9ba0f10d3e1d26c.camel@hammerspace.com>
References: <20220111074309.GA12918@kili> <Yd1ETmx/HCigOrzl@infradead.org>
         <CAOQ4uxg9V4Jsg3jRPnsk2AN7gPrNY8jRAc87tLvGW+TqH9OU-A@mail.gmail.com>
In-Reply-To: <CAOQ4uxg9V4Jsg3jRPnsk2AN7gPrNY8jRAc87tLvGW+TqH9OU-A@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a55d8c6f-d8d0-4879-0de2-08d9d6a593e2
x-ms-traffictypediagnostic: CY4PR13MB1736:EE_
x-microsoft-antispam-prvs: <CY4PR13MB17362823F7C4001033568B65B8539@CY4PR13MB1736.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhsQMpihDwVqCbIQVqgcwczFc6oH2Ys87M+r9VwYFDy1WTqeBBHoU7VHOQ723Ah7HCzMEi5QD/6qDpcP0iqjku2c49luF+vzDi13jvil9THk+bJj9BPiBSW90U5IzmGVAXnpEpISMms2JZUuGu5uowusyp7zkmyJeEtm2EaHa9dF0+aM3yK1lJmB052EHJPhNseYrhRsZfP4LaNC0w3HgBv0GQg9sJiuzGaLyqJoZnoN54BSc6h4duu8Ew0A7o+AZSOjNi2oHPomK70TKFRNEnfJvRmuYrpus8MuSb8oNm/BB2Bt58wjSFmoQ3bI9SXr6mml6Hd7W+1Tdvs467a832zeyAVXzpFIIV9SLk9XqjhY4d/5x5sQKJcKCPJllkKUVESWRNKgs2G4RkwDep8Qmq4Oj+bBMjkKaEQDDliuZv6yhroZ1xIG33jWsjidIZPqudWTjU21Qb/dq18+CCh78HNuOEPryJHIVOGLxSRjIJoX6njIbMaEK4y4NkXAdPpXlbnrjwuX3ZLH3xkURPfCS2TZwE0s1SzpRm+xy6heMY76Xqdbbc/X9yUdsD7BL2RvoHnT+nAJet+i4napbzlDUj1hP+n/fiL4V4qdrWsw71r1Yv29Ans/+nexOR1G6+It9D64LIeXE9g6W2rWGphKo0Q1t1mg1xBDovgKo8xf9E35eXp9KgGfEnVL5jDOVaz+8ArmLbAFHn2G7zgROO7TulcEVKx5Q8Fcwhh2MEewD+6Lfj0z83xsfCeh2s8opLd4CJuti/Bw3ZTx3OHjVadG30OlaHegfEUkuN/3pyAJaOWphi2f9MZl9pSESVOkyJ6FwUn69GA5RP5AbkAi5nq3wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(366004)(396003)(136003)(346002)(376002)(26005)(54906003)(186003)(53546011)(6506007)(76116006)(6512007)(86362001)(2616005)(508600001)(122000001)(7416002)(5660300002)(110136005)(36756003)(316002)(966005)(6486002)(38070700005)(38100700002)(83380400001)(8676002)(66946007)(8936002)(71200400001)(66556008)(66476007)(4326008)(64756008)(66446008)(2906002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHdpVlhLY1FkZUk2RkZlUGxZRk1CM2lkN3NSNmVrd1RPSHdLTGRTR2lNZi8y?=
 =?utf-8?B?SXdqZURYNjNWaHVBOEkvd2xyT01QeVN0bTlwQy9rVDMwV3V3dUNUNkgyZXNB?=
 =?utf-8?B?T1BadXVFWGEyMXFYUVpta2tzcUtQQnVCWjJDQ202UWJ1MythU1o5RTZEVGxq?=
 =?utf-8?B?VGlwTGxrKzRFYmY5ZE1VTGIyUzlmZnBBeU9VbzhjK2ppMTNwNWR5NThBQ2pQ?=
 =?utf-8?B?d3ZKWHZNSFZ3bnJPSnFiL0hYU1k2MVdWWEF1NTVEclIvRDdycVFnNHVZVWcr?=
 =?utf-8?B?WGpYU2hBQ1QxTnpRNGNpV1ZoTEQrSWNUVGs0YUNoNU5xQ0ZDTnB2emlUc2dW?=
 =?utf-8?B?bVNXKzhzaDFWbjdoT0lEQzAwa1djNFJUamMyVWZPdUpLcVRESS9VYlA5cGc4?=
 =?utf-8?B?aUZhTTlPTGFGMzJhaHVEMGg0d1pyMmQ4NGo1SHJJcUdiUHBSQXNFUGladisv?=
 =?utf-8?B?dmk5dnVWclJGd0gvUWtwdnJaa3N2dFkvZGZaYVNyZTBjODAzUXBCai8wU0tX?=
 =?utf-8?B?VXJjMzMvVnVYLzFpTkc2MlVFb05MM0h0bnU0Nys3bGlETENzVFgxbkR5STBD?=
 =?utf-8?B?ckc5LzVYbzgzZUx5S0x5YSt1b1dWUGcyUjFRK2ZWMlprcUtCR20vdExvdzJ1?=
 =?utf-8?B?VjNzKzhJbW9HcTZ0L1RyVmh6VFdFakxUalFRRzF4WDdmK2NqOUFuOXQwR1o1?=
 =?utf-8?B?N0tqaG9zRElvc0VYeDdEQ3BXb1NrdlFoNW95bm5WMVhScVUvL3B2Q3djVHNs?=
 =?utf-8?B?NmZNV1AzNWFud3pLODlaaTZENXl3QUFZOUN2L29ETXZDS3lybjhKTm1yTjEv?=
 =?utf-8?B?TUNzbUhCaXAyUkwvL1hRQnM0aVNtd2Q1U3dXNFpuRWhVcjZERWJFdkgxVWhk?=
 =?utf-8?B?a0grWU1mZk0zL0M0YjRIOGZIamx1Vzd5OWx4cmRrUzZUQm11dFhJWFZ0dFhU?=
 =?utf-8?B?ck9XK2lIZVZCUmgxR1FIUDRGK0JYT3lFSUZRcGYzYUN2TTkyUVhhU3BoQlRW?=
 =?utf-8?B?aGhRLzE3bnB5b3BpNlA5VGpoZTE5YWdpdE0zNzN0K0FZN3Y1YW8vK1F3VzN4?=
 =?utf-8?B?cHBiZnJZaGJRc1BFMDRRcHJsczE5Lys4Y2tTUlJndnpnclJ0Sk9sY0dhdXpZ?=
 =?utf-8?B?bDErZUJvb2xkNGJFYUF4alNQVHlGdUpmaWNMQ0NzQlpaMVQ1YlJmNTltS0x6?=
 =?utf-8?B?SXg0c1BlbVBKbnVWUG5ZTGZJRVhmMHFRNnVwbXN6alpLY2M3bUZQVHIycUtB?=
 =?utf-8?B?UEdQRFFkR1VBZWlHN0NqWTVxMDhjM05YSlROVWs1WkNwSmtRSWtoYlY3YzN2?=
 =?utf-8?B?bi9tQUxSdVE2K2xBZ0dCN2NnNEpCTG5lcitBVW9YRzFFU0ExMWRKeWg2VkFn?=
 =?utf-8?B?eUtPV0R4aEpLYXJrQnJ6YUMvVllUV1VkUnkvbEZFZS93Mm5LRXo0ZG5UTmEv?=
 =?utf-8?B?ZkdPanZNMXJ4NmFVNkNnc0NtRlM4U1BWalFJNWxaTG8vMW1jeDZIQXl2V3Nx?=
 =?utf-8?B?RkQ2S0xtaGdJU2lLbGZHSXQ2L0Vpc1VXbHNUbGE3OTRaQmdVWTlsc21yRWF6?=
 =?utf-8?B?bG9tS1p5ZTdXcVY4cEtKS05aMXhOaWdORDBPTkpjbUt6VDJ0ZkdvUlFLR1o4?=
 =?utf-8?B?TzVvRzN6MnZMSmpvanhBQVQ0SVE0UmNaclVxSGpEc0F3RXByUUMxWHZvSmlZ?=
 =?utf-8?B?M1A0a3JVY2RpTE5yVzN4S1NVQ2FEbm13Rzl4Sm05U3lweHRxYWJqUkxvYjNN?=
 =?utf-8?B?Qmh2SGIyaW9nK092dTlKcVB5dnFOd0JlUGJoaytXbTNGdEZsYUx1bTYxcVVw?=
 =?utf-8?B?WkFRRE5scEc1LytudmY2aUFZZy9UU2h5N29DdFNnQithbFo3Mms4bnRoZkZr?=
 =?utf-8?B?MFhvaWlrZjk5TTE0VEJnNFhYT3dDMnptN0czdmQ0TTlzT3l5ZWVoV1JUZkph?=
 =?utf-8?B?amo0QTBYSjJYMjdlRVozTlB1YXI0LzNrbDlPRWRraTFsODcwYlF5TmxMZHh1?=
 =?utf-8?B?RFZYU2tlRitHZ0RjbTc2dTg5RUpmVnpzb0lyeHlaRGxvbkxJNnk1RHhQeTJy?=
 =?utf-8?B?MEVJNnI0SUZqZW15bEZZVGRMRlhweWhlNUtIRlFOR0tqcGlvYUx4eEh2ZkV2?=
 =?utf-8?B?NitRb1grVjRHQ1hqOGNwMzFuVDgzSHV0ejJCZnBZVFZ5amJQMzk5WGh1ZC8r?=
 =?utf-8?Q?7vYTR2wLuVH1d1E7jS8l5ME=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7D27E928973864497A18C53AB8F345C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55d8c6f-d8d0-4879-0de2-08d9d6a593e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 15:01:28.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4ZYPIUgHQpTWTwuw7J3ZNHAEfDREy+1AMBDzJZAKhaDZJ6kChw3/lcCNdSG7AcAQR8stcSU4g/bicp4T69O4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1736
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTEyIGF0IDA5OjU3ICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gT24gV2VkLCBKYW4gMTIsIDIwMjIgYXQgNDoxMCBBTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFR1ZSwgSmFuIDExLCAyMDIy
IGF0IDEwOjQzOjA5QU0gKzAzMDAsIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+ID4gPiBIZWxsbyBS
aWNoYXJkIFNoYXJwZSwNCj4gPiA+IA0KPiA+ID4gVGhpcyBpcyBhIHNlbWktYXV0b21hdGljIGVt
YWlsIGFib3V0IG5ldyBzdGF0aWMgY2hlY2tlciB3YXJuaW5ncy4NCj4gPiA+IA0KPiA+ID4gVGhl
IHBhdGNoIGJjNjZmNjgwNTc2NjogIk5GUzogU3VwcG9ydCBzdGF0eF9nZXQgYW5kIHN0YXR4X3Nl
dA0KPiA+ID4gaW9jdGxzIg0KPiA+ID4gZnJvbSBEZWMgMjcsIDIwMjEsIGxlYWRzIHRvIHRoZSBm
b2xsb3dpbmcgU21hdGNoIGNvbXBsYWludDoNCj4gPiANCj4gPiBZaWtlcywgaG93IGRpZCB0aGF0
IGNyYXAgZ2V0IG1lcmdlZD8NCj4gDQo+IERpZCBpdD8gVGhlIGJvdHMgYXJlIHNjYW5uaW5nIHRo
cm91Z2ggcGF0Y2hlcyBvbiBNTDoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW5mcy8yMDIxMTIyNzE5MDUwNC4zMDk2MTItMS10cm9uZG15QGtlcm5lbC5vcmcvDQo+IA0KPiA+
IFdoeSB0aGUgZioqayBkb2VzIGEgcmVtb3RlIGZpbGUgc3lzdGVtIG5lZWQgdG8gZHVwbGljYXRl
IHN0YXQ/DQo+ID4gVGhpcyBraW5kIG9mIHN0dWZmIG5lZWRzIGEgcHJvcGVyIGRpc2N1c3Npb24g
b24gbGludXgtZnNkZXZlbC4NCj4gDQo+ICtudGZzMyArbGludXgtY2lmcyArbGludXgtYXBpDQo+
IA0KPiBUaGUgcHJvcG9zYWwgb2Ygc3RhdHhfZ2V0KCkgaXMgdmVyeSBwZWN1bGlhci4NCj4gc3Rh
dHgoKSB3YXMgZXNwZWNpYWxseSBkZXNpZ25lZCB0byBiZSBleHRlbmRlZCBhbmQgYWNjb21tb2Rh
dGUNCj4gYSBkaXZlcnNpdHkgb2YgZmlsZXN5c3RlbSBhdHRyaWJ1dGVzLg0KPiANCj4gTW9yZW92
ZXIsIE5GU3Y0IGlzIG5vdCB0aGUgb25seSBmcyB0aGF0IHN1cHBvcnRzIHRob3NlIGV4dHJhDQo+
IGF0dHJpYnV0ZXMuDQo+IG50ZnMzIHN1cHBvcnRzIHNldC9nZXQgb2YgZG9zIGF0dHJpYiBiaXRz
IHZpYSB4YXR0cg0KPiBTWVNURU1fTlRGU19BVFRSSUIuDQo+IGNpZnMgc3VwcG9ydCBzZXQvZ2V0
IG9mIENJRlNfWEFUVFJfQVRUUklCIGFuZCBDSUZTX1hBVFRSX0NSRUFURVRJTUUuDQo+IA0KPiBO
b3Qgb25seSB0aGF0LCBidXQgTGludXggbm93IGhhcyBrc21iZCB3aGljaCBhY3R1YWxseSBlbXVs
YXRlcw0KPiB0aG9zZSBhdHRyaWJ1dGVzIG9uIHRoZSBzZXJ2ZXIgc2lkZSAobGlrZSBzYW1iYSkg
Ynkgc3RvcmluZyBhIHNhbWJhDQo+IGZvcm1hdHRlZCBibG9iIGluIHVzZXIuRE9TQVRUUklCIHhh
dHRyLg0KPiBJdCBzaG91bGQgaGF2ZSBhIHdheSB0byBnZXQvc2V0IHRoZW0gb24gZmlsZXN5c3Rl
bXMgdGhhdCBzdXBwb3J0IHRoZW0NCj4gbmF0aXZlbHkuDQo+IA0KPiBUaGUgd2hvbGUgdGhpbmcg
c2hvdXRzIGZvciBzdGFuZGFyZGl6YXRpb24uDQo+IA0KPiBTYW1iYSBzaG91bGQgYmUgYWJsZSB0
byBnZXQvc2V0IHRoZSBleHRyYSBhdHRyaWJ1dGVzIGJ5IHN0YXR4KCkgYW5kDQo+IGtzbWJkIHNo
b3VsZCBiZSBhYmxlIHRvIGdldCB0aGVtIGZyb20gdGhlIGZpbGVzeXN0ZW0gYnkNCj4gdmZzX2dl
dGF0dHIoKS4NCj4gDQo+IFdSVCBzdGF0eF9zZXQoKSwgc3RhbmRhcmRpemF0aW9uIGlzIGFsc28g
aW4gb3JkZXIsIGJvdGggZm9yIHVzZXJzcGFjZQ0KPiBBUEkgYW5kIGZvciB2ZnMgQVBJIHRvIGJl
IHVzZWQgYnkga3NtYmQgYW5kIG5mc2QgdjQuDQo+IA0KPiBUaGUgbmV3LWlzaCB2ZnMgQVBJIGZp
bGVhdHRyX2dldC9zZXQoKSBjb21lcyB0byBtaW5kIHdoZW4gY29uc2lkZXJpbmcNCj4gYSBtZXRo
b2QgdG8gc2V0IHRoZSBkb3MgYXR0cmliIGJpdHMuDQo+IEhlY2ssIEZTX05PRFVNUF9GTCBpcyB0
aGUgc2FtZSBhcyBGSUxFX0FUVFJJQlVURV9BUkNISVZFLg0KPiBUaGF0IHdpbGwgYWxzbyBtYWtl
IGl0IGVhc3kgZm9yIGZpbGVzeXN0ZW1zIHRoYXQgc3VwcG9ydCB0aGUgZmlsZWF0dHINCj4gZmxh
Z3MNCj4gdG8gYWRkIHN1cHBvcnQgZm9yIEZTX1NZU1RFTV9GTCwgRlNfSElEREVOX0ZMLg0KPiAN
Cj4gVGhlcmUgaXMgYSB1c2UgY2FzZSBmb3IgdGhhdC4gSXQgY2FuIGJlIGluZmVycmVkIGZyb20g
c2FtYmEgY29uZmlnDQo+IG9wdGlvbnMNCj4gIm1hcCBoaWRkZW4vc3lzdGVtL2FyY2hpdmUiIHRo
YXQgYXJlIHVzZWQgdG8gYXZvaWQgdGhlIGNvc3Qgb2YNCj4gZ2V0eGF0dHINCj4gcGVyIGZpbGUg
ZHVyaW5nIGEgInJlYWRkaXJwbHVzIiBxdWVyeS4gSSByZWNlbnRseSBxdWFudGlmaWVkIHRoaXMN
Cj4gY29zdCBvbiBhDQo+IHN0YW5kYXJkIGZpbGUgc2VydmVyIGFuZCBpdCB3YXMgdmVyeSBoaWdo
Lg0KPiANCj4gV2hpY2ggbGVhdmVzIHVzIHdpdGggYW4gQVBJIHRvIHNldCB0aGUgJ3RpbWUgYmFj
a3VwJyBhdHRyaWJ1dGUsIHdoaWNoDQo+IGlzIGEgIm11dGFibGUgY3JlYXRpb24gdGltZSIgWypd
Lg0KPiBjaWZzIHN1cHBvcnRzIHNldHRpbmcgaXQgdmlhIHNldHhhdHRyIGFuZCBJIGd1ZXNzIG50
ZnMzIGNvdWxkIHVzZSBhbg0KPiBBUEkgdG8gc2V0IGl0IGFzIHdlbGwuDQo+IA0KPiBPbmUgbmF0
dXJhbCBpbnRlcmZhY2UgdGhhdCBjb21lcyB0byBtaW5kIGlzOg0KPiANCj4gc3RydWN0IHRpbWVz
cGVjIHRpbWVzWzNdID0gey8qIGF0aW1lLCBtdGltZSwgY3J0aW1lICovfQ0KPiB1dGltZW5zYXQo
ZGlyZmQsIHBhdGgsIHRpbWVzLCBBVF9VVElNRVNfQVJDSElWRSk7DQo+IA0KPiBhbmQgYWRkIGlh
X2NydGltZSB3aXRoIEFUVFJfQ1JUSU1FIHRvIHN0cnVjdCBpYXR0ci4NCj4gDQo+IFRyb25kLA0K
PiANCj4gRG8geW91IGFncmVlIHRvIHJld29yayB5b3VyIHBhdGNoZXMgaW4gdGhpcyBkaXJlY3Rp
b24/DQo+IFBlcmhhcHMgYXMgdGhlIGZpcnN0IHN0YWdlLCBqdXN0IHVzZSBzdGF0eCgpIGFuZCBp
b2N0bHMgdG8gc2V0IHRoZQ0KPiBhdHRyaWJ1dGVzIHRvIGdpdmUgZW5vdWdoIHRpbWUgZm9yIGJp
a2VzaGVkZGluZyB0aGUgc2V0IEFQSXMNCj4gYW5kIGZvbGxvdyB1cCB3aXRoIHRoZSBnZW5lcmlj
IHNldCBBUEkgcGF0Y2hlcyBsYXRlcj8NCj4gDQo+IFRoYW5rcywNCj4gQW1pci4NCj4gDQo+IFsq
XSBJIGZpbmQgaXQgY29udmVuaWVudCB0byB1c2UgdGhlIHN0YXR4KCkgdGVybWlub2xvZ3kgb2Yg
ImJ0aW1lIg0KPiB0byByZWZlciB0byB0aGUgaW1tdXRhYmxlIGJpcnRoIHRpbWUgcHJvdmlkZWQg
Ynkgc29tZSBmaWxlc3lzdGVtcw0KPiBhbmQgdG8gdXNlICJjcnRpbWUiIGZvciB0aGUgbXV0YWJs
ZSBjcmVhdGlvbiB0aW1lIGZvciBhcmNoaXZpbmcsDQo+IHNvIHRoYXQgYXQgc29tZSBwb2ludCwg
c29tZSBmaWxlc3lzdGVtcyBtYXkgcHJvdmlkZSBib3RoIG9mDQo+IHRoZXNlIHRpbWVzIGluZGVw
ZW5kZW50bHkuDQoNCkknbGwgZ2l2ZSBpdCBhIHNob3QuIEkndmUgYXNrZWQgQW5uYSB0byByZW1v
dmUgdGhlc2UgcGF0Y2hlcyBmcm9tIHRoZQ0KcHVsbCByZXF1ZXN0IGZvciB0aGlzIG1lcmdlIFdp
bmRvdywgc28gSSdsbCB0cnkgdG8gcmV3b3JrIHRoZSByZXRyaWV2YWwNCnNpZGUgdXNpbmcgc3Rh
dHgoKSBhbmQgdGhlbiB3b3JrIG9uIGEgc3RhdHhfc2V0KCkgQVBJIHRvIGVuYWJsZSBzZXR0aW5n
DQpvZiB0aGVzZSBuZXcgdmFyaWFibGVzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
