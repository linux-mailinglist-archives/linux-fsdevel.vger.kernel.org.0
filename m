Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF4546AB31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 23:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356167AbhLFWIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 17:08:53 -0500
Received: from mail-co1nam11on2117.outbound.protection.outlook.com ([40.107.220.117]:52065
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356011AbhLFWIv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:08:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMZBqV6M0nqg7Fc7q/j3mvIHFm0hW4lAcXKHYQivNEyavMsiT4WFmgpDBAojL9y5C1rD1ljb5aQfseXrfAc5s7j09jq/sDPDw7rqu5G6tOLJdSYF95sYgMhi3MFp7yrD9sAXt5Oql697UNSpha4V9M/GQ7jRWrrKBBwBU3HFgEvFOcMnYkvQBXDbj84PjrdhdD9+1ZC/uNQN9wR5RCSQfuv5WbdFcrlVnAjGvTJpqh0OhbqdnJLwtTTCbEw2zb3dPcY9+o9MmbaRQwSrWFV8rahvS6339IqfmVMhzWYPy/UQ2yHt/zskiwfXneLUvZV3RXhgsSKmyUttTTXPovDjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABVkZ4Iurn/l8Ysl0N7wWRxSGg15Tx9HCEMkLCZjAcg=;
 b=KTLEFrobKLkapMEp3bzNPGbrOoMg5UAsWyAfTr8OUiIZ5CJw9utiKUYEMT+blLreKNxuz79oA5/LFQrE5p95sEO8KYKvv+klP2Xnaiw9OmTzrUpW5t3mcJOZC0ggsDy5qy4K/PbVLvzlNnJs77yunruf41SaIQpDu/EI7dnCNrgPislN2McPjBnJPDa/H5ap+TZnRgsraNp1qMEGmFyynXHmqBZ5pbXO9euP419TfgsjzGYnAHRrrfftIpaXuIQMFzAJgtbVEL1Hs6haKp2lKO1wo2w8UgTL1Z0yUd02TGctx1NkXTcUpS8CjPfZuQ5+4y9b2HnmWArm70AosNT2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABVkZ4Iurn/l8Ysl0N7wWRxSGg15Tx9HCEMkLCZjAcg=;
 b=NlLf49F6OhrOpCSs3sVlyXOxiW9r6ylzRBtA50frxJiWQnLTJc9y02k22CKmSdHqV+FgjiTswD+X3PEno5uKf4PqIp/RdbcqMQxI6c5zyPK2eTFEf3sEac+TIYbN39RIJcSIBqtlF/POuluYYBcqh76c02WN9slURGqqTpup3q0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5130.namprd13.prod.outlook.com (2603:10b6:610:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.10; Mon, 6 Dec
 2021 22:05:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4778.010; Mon, 6 Dec 2021
 22:05:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC v6 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Thread-Topic: [PATCH RFC v6 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Thread-Index: AQHX6ssViMfDzxHt9kqN9Uppd6wWeKwly7iAgAAUSICAAAOyAIAACJgAgAAY1QA=
Date:   Mon, 6 Dec 2021 22:05:19 +0000
Message-ID: <33e964f8aef8a94f8b4903c1b9b6c037e37cb325.camel@hammerspace.com>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
         <20211206175942.47326-2-dai.ngo@oracle.com>
         <133AE467-0990-469D-A8A9-497C1C1BD09A@oracle.com>
         <254f1d07c02a5b39d8b7743af4ceb9b5f69e4e07.camel@hammerspace.com>
         <20211206200540.GD20244@fieldses.org>
         <6aea870f-d51e-ed42-6f96-6b5b78edfcc3@oracle.com>
In-Reply-To: <6aea870f-d51e-ed42-6f96-6b5b78edfcc3@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b07c7fcb-0839-43e6-959e-08d9b9047e00
x-ms-traffictypediagnostic: CH0PR13MB5130:EE_
x-microsoft-antispam-prvs: <CH0PR13MB513043B16F9E142D76FAE144B86D9@CH0PR13MB5130.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FuM9K6HzzO/cyP4d+NF03+nJgYynbKVYBiIrqdEC9ckziOT2jWKFbCNxsoRWO7i9q5F0Zlj8+v7qOvtmPJfih22kCxdfpvadEKufQVp47ZNBlWwYAM5SmXt5fWzgmjjw32MSsWggwHe+qiZGXcXMuTtu+eE2rHBhbobYwhpa+dZhnbJtevo8Ed96pK4EkCEUvadHWx1Foe5mMBF3DgQx1jQdCZPYAy6EIU994nhGuBqxsnIIeZZgO3k+gDPCZqvQhLrmYfC1oQ2WeRT374+SaX9rk//Zr2pzvQQMN2j0ByP7wSbx0HELGVPP5jjUbe9YkNpKlh+w9AXCO/puboq9DR6O+6yBEc/rWK7RloTS+yIeQQrHciKt57kpHwjnZ49Tbt86TPQFnibA7spDefz+KDUTSj7gF2LOeqJGFyZT28FJ623PmhOVPZpRoHmL0WZDKboonBAw98G073VOuMMvbLlOrU+DMIQyDVfzZRxQy/5jsZMc1gDu+fujrRpjl457zOL8UZ17GjJnX71rj9RP/9/FKr5TF7XTa4uCbymqn6CMz+1QngQ5dIdIz9lI34TXWYc2I8gAwKkRDj55rxZQrSwS3KBWwn/pRvPuBnELTwUhH1ZLrVrPqU2iiwLKDBYOk5VNm9rzvGs4cUeKohlb2wC0bMzBMLsEczO3mGunZVK44QA/cmd6z2wZG0eIZmVYW5qkXYQziCi92MOrX1c2iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39830400003)(376002)(366004)(53546011)(6506007)(36756003)(316002)(8936002)(186003)(71200400001)(66946007)(38100700002)(122000001)(54906003)(26005)(110136005)(8676002)(66446008)(64756008)(66556008)(66476007)(6512007)(2616005)(6486002)(4326008)(5660300002)(83380400001)(38070700005)(76116006)(86362001)(2906002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3IwWUd5YUFhenpXbWsyZGNyTzUrSEw3TGxFQndRKyt2SlBtNG4wbmtKWGJE?=
 =?utf-8?B?cnNLdGtPTVQyTUVsK09obXBxbStCNUU3a2pDVEdCTmdsNEkwYXVtNFZJQy94?=
 =?utf-8?B?Z0p6K2hoVEF4UFA1QnUzT00wQnFQL09aekw0NkdabGc0RkNQcUZxUFdrOEp1?=
 =?utf-8?B?Y25UQmRxeHMwbklmZGp6Njh3NWZINVI2Ym1jQnNQOVg1UW10TTBKYnJlUWFn?=
 =?utf-8?B?VWhJZmUzSkMrL0syS1dRZFBTRlhHVGdQaUIzbXhrMTJCam4yQVl4RlhWb2ta?=
 =?utf-8?B?RjdJa092dHc1TjJSS2pwQlhvaW1wNVBHZXI2OHhTWnNEd0tnRUhZT1RLVFQ1?=
 =?utf-8?B?NkQ5aFV0M0VrSUVUVXdJa0NjMlVCRXVqVEc1SUJRUDhzeEFPWVI5Nmt6REEy?=
 =?utf-8?B?MlBxbm84SkVlZzFkS3JmUFhOMzZ1NDhsWTgvam91SDlOZ3VqVjBjaUdXYzYr?=
 =?utf-8?B?bFR3OHhkQ2JTUVJVb2RGRXFuTDRCL1I4V2RuLzh6ZFZ2QytjNGRsb2JtOFpn?=
 =?utf-8?B?ZCs2VEREYlNDcHJ5bU5MSDQyZ0xHamV2dHh3ekhEaUxKbDZxbFdOV3hYK054?=
 =?utf-8?B?SFR2N1FvTngxK2o5MHlGcGI2RDB1VEphWVM1R3BXTlRhTkdkTjhITk1ucUEz?=
 =?utf-8?B?RzFGU1U1Z3ErQlBUY0lQWENZRXVsZVJSR1JUQzJqOVpHdUxUelI4aXhNVE9s?=
 =?utf-8?B?eStvT1FKS09xY0hjcWQ5YTVqb3FFdEc1RlVIQXYrSDJjUkxwY2R4ZE5neW9H?=
 =?utf-8?B?Qzd0YUM0ZGQwdDVzSXpaYzRvMXhaanordnpUSDZGY2VTUDI5MlZNTzUvRWl1?=
 =?utf-8?B?Q2M5cXIyeHF4cjBVS2svQjZlL3p6WWZWRkFVTGtPMlpKbStGbkVyeTdCMThN?=
 =?utf-8?B?Y09yaVA2M1BzdzF5QmhzWlgyRFNsZU9jZ2RBV1lBV3BYcW9xdkVpamVmMWhz?=
 =?utf-8?B?Yi9xMzVneERvTEVtSXdWNmh0QXhaKzlveUZNNWt5bkFuc2N5anpReXJSRWVv?=
 =?utf-8?B?bDB6QUFocmIwZmhIY1VLVXdYeUdLMkJRdTdQWUs2eHNmTFlScGtRb1F6QzZR?=
 =?utf-8?B?Qkx1MDJ6K21NekFuS0ZDTlpLT2dkTUtydG9hUW1KeGZuU1dub0tPdjM4VVFJ?=
 =?utf-8?B?WG5Hbzh3VE00OGtHMjlkVENwbWtDYzhKWXN5czlxVmpiR2VFQmxxK1RuN0JO?=
 =?utf-8?B?aGxxK2kvOCtrMGkrT3hSTHMzRlBJbVRVeUk5UkFZWUo1TlBSdFZkd24rdTRV?=
 =?utf-8?B?dkd5UDBsOUNrS2pQYTNYdHFIZ01yV1ROdmxmUUwvK3pXbk1oMEw1WUt3bWJO?=
 =?utf-8?B?Nmt3TklIMEJhRlhNODVUdUhpbUNFb3J0WjhhY3JENEpHeVZqMjdvQS8wTHJu?=
 =?utf-8?B?QkRPckhyK3g3MTRIdWNnWlBWelVYMUpjVG5OMVZmSVIyRUpFb2Y5eEg4UVd4?=
 =?utf-8?B?MTd3ZGduVkZaM1QxaTJtTG5WSk1JeU1kN1dXV0wwQzBPLzdKYjYyRzAzUEwy?=
 =?utf-8?B?ekM0ZGhVSWVNTVJ1THZWcVZjQ042TVBBZ1J3amRIdkJWSGs2REpqMnZGbFhE?=
 =?utf-8?B?SytUUHBBUzlkVGZIdzRhTnRuUzZUVUdyOHcrNkpEL2dFWExQZExvMEFPaGtB?=
 =?utf-8?B?RmpzS3hzRVMzQ2Y0WU45aWhQRlgza1NyalJjdUtOMVNiaEVpVUxPaWN2U1d2?=
 =?utf-8?B?MnBuSCtPSUVwMjBMbStwdVZGYXdaNjlTQjRMSisrMS9IaHFMSU85ak5ZbUZY?=
 =?utf-8?B?US9tdjdUTi94d2xkMkx3RVlFV2lQM0dyeVppV2E5cDV0Tm9uanV6TDBMRmg5?=
 =?utf-8?B?T2lHQ1dmK1VuUFVPMDFDYnJGS0hhT01ROHJsbVNCK0x6RFhKbVVCZ3UvUlFr?=
 =?utf-8?B?OVZzRXFyZWdEYzZhNDNJZitHUkhKck04S0VMVmM4aU9teGdSWW91T1Y5VnYx?=
 =?utf-8?B?R3pUZ2RkMzJkYmhsTmIybk94d2FVZ0VqOVEyN25FczlrS0RScE5mVG1JRXVN?=
 =?utf-8?B?WE45UC9WK2VjTXNrSjZZTGlReTlrZ25KSUs4VVRUVXQxMVA1YkJ3dGpla2tr?=
 =?utf-8?B?dnFnaFFTUW8yT3RQdGZJWWhYNGljRitOUE9SaEk5c3h0OGx3UnR0aEdzc1gy?=
 =?utf-8?B?VXhXRWRVUWtMS1poaGU1dHp1R0JzNXlIZEl3d0YwWGNEZ0U2R21YWERoOWlW?=
 =?utf-8?Q?phe+EDFMYrUN+gFEkmmygao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D01BD2631E396C4591B57548E96A0EC9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07c7fcb-0839-43e6-959e-08d9b9047e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 22:05:19.2898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JwOFTrKOEmrI8L4TgIILw2e8wH67jKihDuspzoOZDJTgMCM3NcPgAIPb7L8YwCRTr+aw/KFk9DUnxnSgBLYGKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5130
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIxLTEyLTA2IGF0IDEyOjM2IC0wODAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3Jv
dGU6DQo+IA0KPiBPbiAxMi82LzIxIDEyOjA1IFBNLCBiZmllbGRzQGZpZWxkc2VzLm9yZ8Kgd3Jv
dGU6DQo+ID4gT24gTW9uLCBEZWMgMDYsIDIwMjEgYXQgMDc6NTI6MjlQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gT24gTW9uLCAyMDIxLTEyLTA2IGF0IDE4OjM5ICswMDAw
LCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIERlYyA2LCAy
MDIxLCBhdCAxMjo1OSBQTSwgRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUuY29tPg0KPiA+ID4gPiA+
IHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFkZCBuZXcgY2FsbGJhY2ssIGxtX2V4cGly
ZV9sb2NrLCB0byBsb2NrX21hbmFnZXJfb3BlcmF0aW9ucw0KPiA+ID4gPiA+IHRvDQo+ID4gPiA+
ID4gYWxsb3cNCj4gPiA+ID4gPiB0aGUgbG9jayBtYW5hZ2VyIHRvIHRha2UgYXBwcm9wcmlhdGUg
YWN0aW9uIHRvIHJlc29sdmUgdGhlDQo+ID4gPiA+ID4gbG9jaw0KPiA+ID4gPiA+IGNvbmZsaWN0
DQo+ID4gPiA+ID4gaWYgcG9zc2libGUuIFRoZSBjYWxsYmFjayB0YWtlcyAyIGFyZ3VtZW50cywg
ZmlsZV9sb2NrIG9mIHRoZQ0KPiA+ID4gPiA+IGJsb2NrZXINCj4gPiA+ID4gPiBhbmQgYSB0ZXN0
b25seSBmbGFnOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IHRlc3Rvbmx5ID0gMcKgIGNoZWNrIGFu
ZCByZXR1cm4gdHJ1ZSBpZiBsb2NrIGNvbmZsaWN0IGNhbiBiZQ0KPiA+ID4gPiA+IHJlc29sdmVk
DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZSByZXR1cm4gZmFsc2Uu
DQo+ID4gPiA+ID4gdGVzdG9ubHkgPSAwwqAgcmVzb2x2ZSB0aGUgY29uZmxpY3QgaWYgcG9zc2li
bGUsIHJldHVybiB0cnVlDQo+ID4gPiA+ID4gaWYNCj4gPiA+ID4gPiBjb25mbGljdA0KPiA+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdhcyByZXNvbHZlZCBlc2xlIHJldHVybiBm
YWxzZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBMb2NrIG1hbmFnZXIsIHN1Y2ggYXMgTkZTdjQg
Y291cnRlb3VzIHNlcnZlciwgdXNlcyB0aGlzDQo+ID4gPiA+ID4gY2FsbGJhY2sgdG8NCj4gPiA+
ID4gPiByZXNvbHZlIGNvbmZsaWN0IGJ5IGRlc3Ryb3lpbmcgbG9jayBvd25lciwgb3IgdGhlIE5G
U3Y0DQo+ID4gPiA+ID4gY291cnRlc3kNCj4gPiA+ID4gPiBjbGllbnQNCj4gPiA+ID4gPiAoY2xp
ZW50IHRoYXQgaGFzIGV4cGlyZWQgYnV0IGFsbG93ZWQgdG8gbWFpbnRhaW5zIGl0cyBzdGF0ZXMp
DQo+ID4gPiA+ID4gdGhhdA0KPiA+ID4gPiA+IG93bnMNCj4gPiA+ID4gPiB0aGUgbG9jay4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEYWkgTmdvIDxkYWkubmdvQG9yYWNs
ZS5jb20+DQo+ID4gPiA+IEFsLCBKZWZmLCBhcyBjby1tYWludGFpbmVycyBvZiByZWNvcmQgZm9y
IGZzL2xvY2tzLmMsIGNhbiB5b3UNCj4gPiA+ID4gZ2l2ZQ0KPiA+ID4gPiBhbiBBY2sgb3IgUmV2
aWV3ZWQtYnk/IEknZCBsaWtlIHRvIHRha2UgdGhpcyBwYXRjaCB0aHJvdWdoIHRoZQ0KPiA+ID4g
PiBuZnNkDQo+ID4gPiA+IHRyZWUgZm9yIHY1LjE3LiBUaGFua3MgZm9yIHlvdXIgdGltZSENCj4g
PiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IGZzL2xvY2tzLmPCoMKg
wqDCoMKgwqDCoMKgIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ID4gPiA+
IGluY2x1ZGUvbGludXgvZnMuaCB8wqAgMSArDQo+ID4gPiA+ID4gMiBmaWxlcyBjaGFuZ2VkLCAy
NiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS9mcy9sb2Nrcy5jIGIvZnMvbG9ja3MuYw0KPiA+ID4gPiA+IGluZGV4IDNkNmZi
NGFlODQ3Yi4uMGZlZjBhNjMyMmM3IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2ZzL2xvY2tzLmMN
Cj4gPiA+ID4gPiArKysgYi9mcy9sb2Nrcy5jDQo+ID4gPiA+ID4gQEAgLTk1NCw2ICs5NTQsNyBA
QCBwb3NpeF90ZXN0X2xvY2soc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdA0KPiA+ID4gPiA+IGZp
bGVfbG9jayAqZmwpDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGZpbGVfbG9j
ayAqY2ZsOw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBmaWxlX2xvY2tfY29u
dGV4dCAqY3R4Ow0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpbm9kZSAqaW5v
ZGUgPSBsb2Nrc19pbm9kZShmaWxwKTsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBib29sIHJl
dDsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBjdHggPSBzbXBfbG9h
ZF9hY3F1aXJlKCZpbm9kZS0+aV9mbGN0eCk7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKCFjdHggfHwgbGlzdF9lbXB0eV9jYXJlZnVsKCZjdHgtPmZsY19wb3NpeCkpIHsNCj4gPiA+
ID4gPiBAQCAtOTYyLDExICs5NjMsMjAgQEAgcG9zaXhfdGVzdF9sb2NrKHN0cnVjdCBmaWxlICpm
aWxwLA0KPiA+ID4gPiA+IHN0cnVjdA0KPiA+ID4gPiA+IGZpbGVfbG9jayAqZmwpDQo+ID4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoHNwaW5fbG9jaygmY3R4LT5mbGNfbG9jayk7DQo+ID4gPiA+ID4gK3JldHJ5Og0KPiA+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnkoY2ZsLCAmY3R4LT5m
bGNfcG9zaXgsIGZsX2xpc3QpIHsNCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKHBvc2l4X2xvY2tzX2NvbmZsaWN0KGZsLCBjZmwpKSB7DQo+ID4gPiA+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsb2Nrc19jb3B5X2Nv
bmZsb2NrKGZsLCBjZmwpOw0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmICghcG9zaXhfbG9ja3NfY29uZmxpY3QoZmwsIGNmbCkpDQo+ID4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250aW51
ZTsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGNmbC0+Zmxf
bG1vcHMgJiYgY2ZsLT5mbF9sbW9wcy0NCj4gPiA+ID4gPiA+bG1fZXhwaXJlX2xvY2sNCj4gPiA+
ID4gPiAmJg0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNmbC0+ZmxfbG1vcHMtDQo+ID4gPiA+ID4gPmxtX2V4
cGlyZV9sb2NrKGNmbCwNCj4gPiA+ID4gPiAxKSkgew0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl91bmxvY2soJmN0eC0+ZmxjX2xv
Y2spOw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0ID0gY2ZsLT5mbF9sbW9wcy0NCj4gPiA+ID4gPiA+bG1fZXhwaXJlX2xvY2soY2Zs
LA0KPiA+ID4gPiA+IDApOw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrKCZjdHgtPmZsY19sb2NrKTsNCj4gPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpDQo+
ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZ290byByZXRyeTsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgfQ0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBsb2Nrc19jb3B5X2NvbmZsb2NrKGZsLCBjZmwpOw0KPiA+ID4gSG93IGRvIHlvdSBrbm93ICdj
ZmwnIHN0aWxsIHBvaW50cyB0byBhIHZhbGlkIG9iamVjdCBhZnRlciB5b3UndmUNCj4gPiA+IGRy
b3BwZWQgdGhlIHNwaW4gbG9jayB0aGF0IHdhcyBwcm90ZWN0aW5nIHRoZSBsaXN0Pw0KPiA+IFVn
aCwgZ29vZCBwb2ludCwgSSBzaG91bGQgaGF2ZSBub3RpY2VkIHRoYXQgd2hlbiBJIHN1Z2dlc3Rl
ZCB0aGlzDQo+ID4gYXBwcm9hY2guLi4uDQo+ID4gDQo+ID4gTWF5YmUgdGhlIGZpcnN0IGNhbGwg
Y291bGQgaW5zdGVhZCByZXR1cm4gcmV0dXJuIHNvbWUgcmVmZXJlbmNlLQ0KPiA+IGNvdW50ZWQN
Cj4gPiBvYmplY3QgdGhhdCBhIHNlY29uZCBjYWxsIGNvdWxkIHdhaXQgb24uDQo+ID4gDQo+ID4g
QmV0dGVyLCBtYXliZSBpdCBjb3VsZCBhZGQgaXRzZWxmIHRvIGEgbGlzdCBvZiBzdWNoIHRoaW5n
cyBhbmQgdGhlbg0KPiA+IHdlDQo+ID4gY291bGQgZG8gdGhpcyBpbiBvbmUgcGFzcy4NCj4gDQo+
IEkgdGhpbmsgd2UgYWRqdXN0IHRoaXMgbG9naWMgYSBsaXR0bGUgYml0IHRvIGNvdmVyIHJhY2Ug
Y29uZGl0aW9uOg0KPiANCj4gVGhlIDFzdCBjYWxsIHRvIGxtX2V4cGlyZV9sb2NrIHJldHVybnMg
dGhlIGNsaWVudCBuZWVkcyB0byBiZQ0KPiBleHBpcmVkLg0KPiANCj4gQmVmb3JlIHdlIG1ha2Ug
dGhlIDJuZCBjYWxsLCB3ZSBzYXZlIHRoZSAnbG1fZXhwaXJlX2xvY2snIGludG8gYQ0KPiBsb2Nh
bA0KPiB2YXJpYWJsZSB0aGVuIGRyb3AgdGhlIHNwaW5sb2NrLCBhbmQgdXNlIHRoZSBsb2NhbCB2
YXJpYWJsZSB0byBtYWtlDQo+IHRoZQ0KPiAybmQgY2FsbCBzbyB0aGF0IHdlIGRvIG5vdCByZWZl
cmVuY2UgJ2NmbCcuIFRoZSBhcmd1bWVudCBvZiB0aGUNCj4gc2Vjb25kDQo+IGlzIHRoZSBvcGFx
dWUgcmV0dXJuIHZhbHVlIGZyb20gdGhlIDFzdCBjYWxsLg0KPiANCj4gbmZzZDRfZmxfZXhwaXJl
X2xvY2sgYWxzbyBuZWVkcyBzb21lIGFkanVzdG1lbnQgdG8gc3VwcG9ydCB0aGUgYWJvdmUuDQo+
IA0KDQpJdCdzIG5vdCBqdXN0IHRoZSBmYWN0IHRoYXQgeW91J3JlIHVzaW5nICdjZmwnIGluIHRo
ZSBhY3R1YWwgY2FsbCB0bw0KbG1fZXhwaXJlX2xvY2soKSwgYnV0IHlvdSdyZSBhbHNvIHVzaW5n
IGl0IGFmdGVyIHJldGFraW5nIHRoZSBzcGlubG9jay4NCg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
