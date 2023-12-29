Return-Path: <linux-fsdevel+bounces-7023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D7E82002E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 16:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8EE282D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 15:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F92125B3;
	Fri, 29 Dec 2023 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CJaOWuiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2093.outbound.protection.outlook.com [40.107.102.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F1125A3;
	Fri, 29 Dec 2023 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P58teWb49vXkytQbKN+zxYwMy5RT+zAFOzMqvKbzyqo0QWHjEdXNWEn9W+U39A+RgxJgD7WcSrU6y3RAJmidEgQFjsTIGFD4LlgMbPJP1LLTjIz6L3KzDSULb6fXzXS7oeI4E6mnkrAUS53EBUWQbYtzLOI3P52XDn/nC1i6ogZPBK1Zkr3XYZ3hn/3y9N4ZP19BCM8h42imvpTfd2T7bjIiOjYwvPWFJcp/HwoD4X5e6iGxWOXRvzIlqAm1cizMCmxsjiyvF3jsF6CuaUhHrjQkkmldEK/iBi5+Go+8bBvjB+wBiA2Q2jRPs1H+A4lR4kQRkJ2zaMwaYY7Cs2InNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEEk7woDDbeMv3O4QLpnkX+64ZtXMx4CxKmNdqM7Ueo=;
 b=VHQYf0JtjDTMrrBy6rFhd0guPkiIFrIcMG4+7yDMomYDER94mPtPM2Pl5dbn10K1wpcx3taHlzNRI3HTQC0FyRjQqPM46OqA8RD9B3qnSBfn0nU//XjTmq//RztDK9568tzOqRbYLtsMr77JDVdmIXfUavL/UOpTHN1NNxH0pT5tIi8cvTjyBYBS+pmUH2q+SkKMxZStAWtpXhV+5nENBKzA1SqQmR0xFw10spcCx0FGYt/6fyl3tPip1WAkl6cVLzwAfxmZ0CHuCOn5SfErfVkQ7Q/wvU+TaZI2fEUCKQk1Thq3w3ADBak+Jze/2rfeleCg9MaqI0WMWG7Qs51tVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEEk7woDDbeMv3O4QLpnkX+64ZtXMx4CxKmNdqM7Ueo=;
 b=CJaOWuivy8MUSJiMw/Fxa3zekADal8Y69cMrtbjQRt56eTHkos4Sq63KG/GrkosKXHGZ/ECmonC5toSp663qWFJ7z4nZWyAn1q1L04Qond3pV2zSTNK24xmemybdgHAEl2vLeRU6FMtU79RMLDwCqD3NDSXJEGENwxqCuI9lSlE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB6076.namprd13.prod.outlook.com (2603:10b6:a03:4e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 15:21:57 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 15:21:57 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "amir73il@gmail.com" <amir73il@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
Subject: Re: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
Thread-Topic: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
Thread-Index: AQHaOcuIQhXuXI7gUE61seKNbWjvCbC/wUMAgACgqgA=
Date: Fri, 29 Dec 2023 15:21:57 +0000
Message-ID: <a68a47d136decfeb6c1cc7959353ae51aca47ae7.camel@hammerspace.com>
References: <20231228201510.985235-1-trondmy@kernel.org>
	 <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB6076:EE_
x-ms-office365-filtering-correlation-id: b4ba2461-5b53-48be-d691-08dc0881e576
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vJhLLHwl0K5dRENXvo9iJGafCv9NQpYsfsfJDAcTW/Yh29ZoH2BYfpLADcS1ujSC43cvWGTB3Gb2ZCzAu7CNMCDay8tUYz2FUxXXH6K9dHVYvDEFPpWCUQZg1kmhC0g3/zSXcvMTKP0ggCuIV2pa9uqrbspqdrDhZvuFzA/TH23KvEzID9S0cAgq7P4XEl4oTn9PUJFGXuxp1tt6FcUxuNTLZnLKe28fO5lBU9EN0yjfLE+LlbdHKik9bO6lt8daC0e8dubkskOpB/WHEjdrlap2Q5EfhB35tQqGzbR8cTD3GKDmQl5DtUYZWkZO0C6nwvijVIidd9usyroTYB6JtS1VeVIDE0cN1OqytXOwvb8iQ5xvEPO3G+PQykCir+XkEiG6oa7oYQ9FqjHvqfzjBuIex58CPeoSxobL20SbPULhQgWhJIiOAymJPTYqzJDcThxN7pjwz446IbdAvZ19uU5rygV+b0SItGZrq6SJMZe5+nMbzJOYZ7dgtC0ePjzq+cDI4/BnkIOYWRLv4LITY2cKRHKUqJVsGzZ/Go5T7crDEgRrvul4KySyT5fNsTy7eXY28zgxkiUhQ7F+/StQs0qlgb/9T07g+hNyio9f6BtcrHE1/p5dH623sw9tXczKvuNMbnbJUYSKcFXX1FP3En8K6eH8wl1GPLI1XTeiT65rIDbbXjOYkyoe/qnFJeRC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(83380400001)(316002)(6916009)(54906003)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(41300700001)(122000001)(86362001)(15974865002)(36756003)(8936002)(8676002)(4001150100001)(2906002)(5660300002)(4326008)(26005)(38070700009)(53546011)(6486002)(478600001)(6512007)(6506007)(71200400001)(2616005)(18886075002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Smt6M3Z0d2t0WUpNYUtXcXdjaGVNbittQnNCUlRZeUZVUHdqaXVYcy9FdlND?=
 =?utf-8?B?dlpLWDFMU1c0WnI2WXpWL3RURWZ2TGgvK2tNZjRWZWxMeHVZS3pyd002Y0kr?=
 =?utf-8?B?SW0zUkhVcU5lcW00REtTa1NUczdrYUYvYm5EMzV0cmFkcnhtODQzMU5PSzBt?=
 =?utf-8?B?WUZrQmwrYWJvd1pwZkhidFZzWHR2S1FDNy90aklIRHZBKzhBMWcxZGFOYXZh?=
 =?utf-8?B?UzFFdmkzZXMzUXhWRGd5TzVRZHNHakpVTGVoOWRlc3lFZDlFSE1JdHNXZ09x?=
 =?utf-8?B?RTVBVHZLNkcxaEFiM3hOOFlpUXlKbG5xOHFkMEJ2QUJiN3ovZmhESWRjanMw?=
 =?utf-8?B?T2VuVThYTTZEeS9zaVpxSzQyd09MdUl6OGJLQjlKWERNYVJKTUR1TTQvNmJn?=
 =?utf-8?B?VUJjaFNlaEorWWpYQ3ptUWpLVVRSZG5tRHRjd0JkQlUySXkyOW9pMFhkbWNJ?=
 =?utf-8?B?SnVadHVOd1ZreVR3RGJ1bkNvaHljYjkwNXpwQ09yTUU2TFFaL2RNY2FyT0Nq?=
 =?utf-8?B?MFBDdFhlRDlHVmlzL3BQbkl2ZVBJVmtMdTBmWExTTUhXWE1BYWczWVF4ejdH?=
 =?utf-8?B?QnpUQVF4RlFzakRNNGV6RmJ0Zjdwa01IZ1ZpN1I5UUFVdTVneUxuL0xJdThU?=
 =?utf-8?B?WDN2UVA5d3RXbWVtMGs3cWN1WCtNalNPVktjeXlHd0J4T1VGdGhkT25qT3ZZ?=
 =?utf-8?B?bHNXb0hWMVhtQmZza0JHcU94eTMzbEpNc3dBMEJ0ckc3MFZBSDRqQWdyWEsz?=
 =?utf-8?B?SEtoNko3OGttRTZtTGpZTlRDakowYVkwOVJJTUxRVnU4MGhhTXF2YlNMQXBD?=
 =?utf-8?B?Z2hNQlRaMXZDQlJTZ29PMzJyNDF0RFhtUFNZS2RWQ2xRUDRpTFVORG83T3I4?=
 =?utf-8?B?dzZnOENrR3hWN25UNnZHTFFSYnpqTkFESFhpQ3hySmt1RzZoUFhHL0dBdTY2?=
 =?utf-8?B?WjhTMjNsdGpCbDBDT0dkWk9TOVQxVnJvUXVNcTlHOWRzRXpPNDg5QjNadVZQ?=
 =?utf-8?B?ZXJ3dldONE14TmFiOXd6UjRsbjhSci95eVM3TytmVHFtK1JzcUhFTGdqZTN4?=
 =?utf-8?B?eDFBbUNMa3NIc0g2MEkrMG05WmxicHl3bHIxdEpKbS83T0ZMMk1EUy9hWFk2?=
 =?utf-8?B?dis3SHVINS8wQnlCd1AwVGNDSTBKQWxVenpRMGZlVWFsRGhZZWV2S01FbGVq?=
 =?utf-8?B?TFVXVE1rck5OWGtoTncyc2pyblQxNnFyWlFvZTRoK1IyMlJoUjlLQVVWNUpM?=
 =?utf-8?B?OEtmeTZmZW5yb0FWVTVwUGRmakhNcnpaYVpRRFVmLzRnWU04dTJUcW5uVVZD?=
 =?utf-8?B?WjBHU05TTmljSi92MUd6RW9JV1VCR3lQVFdMd1UwRC8zdlhKK3hsWnkrRXFi?=
 =?utf-8?B?YlFnOU51U1dpMnVybWp4Wk9yK2FBdEM0SkNoM1ZtR2U5aUY1bjhteVcyOGFi?=
 =?utf-8?B?cGJvZjlFUjhrQk53Ky9WODkxZnhEV2JRdkZ0VVlEK3hka2tpTVo0bDRHMUVv?=
 =?utf-8?B?VmVOV1gzY01jT1NSWUs5RHNDRVlmZk5Damo5eDF4WUp6Z2h0dmF1T01JWDRk?=
 =?utf-8?B?VVZXUnZMRGMvZkVPWHp5R2tldi9VeEpJYVlmN0JyS1lhMHdpWDg3VXJCYTk5?=
 =?utf-8?B?dm04R1piSzRqOWtKWHZFNUNhUS9xc1Bja0RITklnWGIrVllaN3JPaHd6cFRh?=
 =?utf-8?B?bk5RdnQzdHFEK05DZmJqYUJvNjhxM1JhTUc1dlhkeXFCYS9OREdjT09Tbkdm?=
 =?utf-8?B?ZUlodmduM28yaVMweG9Ta1RDaGtVc3NKdUNBMGVsVFhuaUdZV0xZcmRwTURv?=
 =?utf-8?B?ZnVkSE1XTm9YRkE5UXN1TTBuanJINVZkRmZVQm9IYXFlc3ZLL2VVeUlxUlJR?=
 =?utf-8?B?dGhteGtGbFgwS3grdFR3cXBHRi9MWStTMmJ5WHJnQ0d0elhmRHc1bEt6ZkIy?=
 =?utf-8?B?OTR3emsyNjUwZUNYa2Z0RHk2alpVejJNNjZpb1dhS1BsK08renBCU3Vpd2Fy?=
 =?utf-8?B?cXNuSDZvb0lMMGVPSm9YRUY2end2WW5TQi9XOUZlTlo5cWtRTXZ5MlRiZXR3?=
 =?utf-8?B?NkhTb2VoVG5UcTZod2VWRFpZc2kxZ3I1T0dWVFFKaWJJN1pFSS9XVi9JS0pn?=
 =?utf-8?B?ZFl3UnJaRi9mdmxKUEpKc25ueFA0MTdoMTZ1UERzY3BQbWprUTh6SklkRzlp?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49A4597B64E4494CAAE60A09B991F4BA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ba2461-5b53-48be-d691-08dc0881e576
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 15:21:57.2981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVN8MtCGMiPUltkhs0lK4psqnO2O1BazBcJHtLO2573zOroRJb0z0oIObeHJFpyMxn8yRm5LzwVCj7K0DYUTrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB6076

T24gRnJpLCAyMDIzLTEyLTI5IGF0IDA3OjQ2ICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gW0NDOiBmc2RldmVsLCB2aXJvXQ0KPiANCj4gT24gVGh1LCBEZWMgMjgsIDIwMjMgYXQgMTA6
MjLigK9QTSA8dHJvbmRteUBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBUcm9u
ZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4g
VGhlIGZhbGxiYWNrIGltcGxlbWVudGF0aW9uIGZvciB0aGUgZ2V0X25hbWUgZXhwb3J0IG9wZXJh
dGlvbiB1c2VzDQo+ID4gcmVhZGRpcigpIHRvIHRyeSB0byBtYXRjaCB0aGUgaW5vZGUgbnVtYmVy
IHRvIGEgZmlsZW5hbWUuIFRoYXQNCj4gPiBmaWxlbmFtZQ0KPiA+IGlzIHRoZW4gdXNlZCB0b2dl
dGhlciB3aXRoIGxvb2t1cF9vbmUoKSB0byBwcm9kdWNlIGEgZGVudHJ5Lg0KPiA+IEEgcHJvYmxl
bSBhcmlzZXMgd2hlbiB3ZSBtYXRjaCB0aGUgJy4nIG9yICcuLicgZW50cmllcywgc2luY2UgdGhh
dA0KPiA+IGNhdXNlcyBsb29rdXBfb25lKCkgdG8gZmFpbC4gVGhpcyBoYXMgc29tZXRpbWVzIGJl
ZW4gc2VlbiB0byBvY2N1cg0KPiA+IGZvcg0KPiA+IGZpbGVzeXN0ZW1zIHRoYXQgdmlvbGF0ZSBQ
T1NJWCByZXF1aXJlbWVudHMgYXJvdW5kIHVuaXF1ZW5lc3Mgb2YNCj4gPiBpbm9kZQ0KPiA+IG51
bWJlcnMsIHNvbWV0aGluZyB0aGF0IGlzIGNvbW1vbiBmb3Igc25hcHNob3QgZGlyZWN0b3JpZXMu
DQo+IA0KPiBPdWNoLiBOYXN0eS4NCj4gDQo+IExvb2tzIHRvIG1lIGxpa2UgdGhlIHJvb3QgY2F1
c2UgaXMgImZpbGVzeXN0ZW1zIHRoYXQgdmlvbGF0ZSBQT1NJWA0KPiByZXF1aXJlbWVudHMgYXJv
dW5kIHVuaXF1ZW5lc3Mgb2YgaW5vZGUgbnVtYmVycyIuDQo+IFRoaXMgdmlvbGF0aW9uIGNhbiBj
YXVzZSBhbnkgb2YgdGhlIHBhcmVudCdzIGNoaWxkcmVuIHRvIHdyb25nbHkNCj4gbWF0Y2gNCj4g
Z2V0X25hbWUoKSBub3Qgb25seSAnLicgYW5kICcuLicgYW5kIGZhaWwgdGhlIGRfaW5vZGUgc2Fu
aXR5IGNoZWNrDQo+IGFmdGVyDQo+IGxvb2t1cF9vbmUoKS4NCj4gDQo+IEkgdW5kZXJzdGFuZCB3
aHkgdGhpcyB3b3VsZCBiZSBjb21tb24gd2l0aCBwYXJlbnQgb2Ygc25hcHNob3QgZGlyLA0KPiBi
dXQgdGhlIG9ubHkgZnMgdGhhdCBzdXBwb3J0IHNuYXBzaG90cyB0aGF0IEkga25vdyBvZiAoYnRy
ZnMsDQo+IGJjYWNoZWZzKQ0KPiBkbyBpbXBsZW1lbnQgLT5nZXRfbmFtZSgpLCBzbyB3aGljaCBm
aWxlc3lzdGVtIGRpZCB5b3UgZW5jb3VudGVyDQo+IHRoaXMgYmVoYXZpb3Igd2l0aD8gY2FuIGl0
IGJlIGZpeGVkIGJ5IGltcGxlbWVudGluZyBhIHNuYXBzaG90DQo+IGF3YXJlIC0+Z2V0X25hbWUo
KT8NCg0KTkZTIChpLmUuIHJlLWV4cG9ydGluZyBORlMpLg0KDQpXaHkgZG8geW91IG5vdCB3YW50
IGEgZml4IGluIHRoZSBnZW5lcmljIGNvZGU/DQoNCj4gDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBq
dXN0IGVuc3VyZXMgdGhhdCB3ZSBza2lwICcuJyBhbmQgJy4uJyByYXRoZXIgdGhhbg0KPiA+IGFs
bG93aW5nIGENCj4gPiBtYXRjaC4NCj4gDQo+IEkgYWdyZWUgdGhhdCBza2lwcGluZyAnLicgYW5k
ICcuLicgbWFrZXMgc2Vuc2UsIGJ1dC4uLg0KPiANCj4gPiANCj4gPiBGaXhlczogMjFkOGExNWFj
MzMzICgibG9va3VwX29uZV9sZW46IGRvbid0IGFjY2VwdCAuIGFuZCAuLiIpDQo+IA0KPiAuLi5U
aGlzIEZpeGVzIGlzIGEgYml0IG9kZCB0byBtZS4NCj4gRG9lcyB0aGUgcHJvYmxlbSBnbyBhd2F5
IGlmIHRoZSBGaXhlcyBwYXRjaCBpcyByZXZlcnRlZD8NCj4gSSBkb24ndCB0aGluayBzbywgSSB0
aGluayB5b3Ugd291bGQganVzdCBoaXQgdGhlIGRfaW5vZGUgc2FuaXR5IGNoZWNrDQo+IGFmdGVy
IGxvb2t1cF9vbmUoKSBzdWNjZWVkcy4NCj4gTWF5YmUgSSBkaWQgbm90IHVuZGVyc3RhbmQgdGhl
IHByb2JsZW0gdGhlbi4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZnMvZXhwb3J0
ZnMvZXhwZnMuYyB8IDQgKysrLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9leHBvcnRmcy9leHBm
cy5jIGIvZnMvZXhwb3J0ZnMvZXhwZnMuYw0KPiA+IGluZGV4IDNhZTAxNTRjNTY4MC4uODRhZjU4
ZWFmMmNhIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2V4cG9ydGZzL2V4cGZzLmMNCj4gPiArKysgYi9m
cy9leHBvcnRmcy9leHBmcy5jDQo+ID4gQEAgLTI1NSw3ICsyNTUsOSBAQCBzdGF0aWMgYm9vbCBm
aWxsZGlyX29uZShzdHJ1Y3QgZGlyX2NvbnRleHQNCj4gPiAqY3R4LCBjb25zdCBjaGFyICpuYW1l
LCBpbnQgbGVuLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250YWluZXJf
b2YoY3R4LCBzdHJ1Y3QgZ2V0ZGVudHNfY2FsbGJhY2ssIGN0eCk7DQo+ID4gDQo+ID4gwqDCoMKg
wqDCoMKgwqAgYnVmLT5zZXF1ZW5jZSsrOw0KPiA+IC3CoMKgwqDCoMKgwqAgaWYgKGJ1Zi0+aW5v
ID09IGlubyAmJiBsZW4gPD0gTkFNRV9NQVgpIHsNCj4gPiArwqDCoMKgwqDCoMKgIC8qIElnbm9y
ZSB0aGUgJy4nIGFuZCAnLi4nIGVudHJpZXMgKi8NCj4gPiArwqDCoMKgwqDCoMKgIGlmICgobGVu
ID4gMiB8fCBuYW1lWzBdICE9ICcuJyB8fCAobGVuID09IDIgJiYgbmFtZVsxXSAhPQ0KPiA+ICcu
JykpICYmDQo+IA0KPiBJIHdpc2ggSSBkaWQgbm90IGhhdmUgdG8gcmV2aWV3IHRoYXQgdGhpcyBj
b25kaXRpb24gaXMgY29ycmVjdC4NCj4gSSB3aXNoIHRoZXJlIHdhcyBhIGNvbW1vbiBoZWxwZXIg
aXNfZG90X29yX2RvdGRvdCgpIHRoYXQgd291bGQgYmUNCj4gdXNlZCBoZXJlIGFzICFpc19kb3Rf
ZG90ZG90KG5hbWUsIGxlbikuDQo+IEkgZm91bmQgMyBjb3BpZXMgb2YgaXNfZG90X2RvdGRvdCgp
Lg0KPiBJIGRpZG4ndCBldmVuIHRyeSB0byBmaW5kIGhvdyBtYW55IHBsYWNlcyBoYXZlIG9wZW4g
Y29kZWQgdGhpcy4NCj4gDQo+IFRoYW5rcywNCj4gQW1pci4NCj4gDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0IA0KQ1RPLCBIYW1tZXJzcGFjZSBJbmMgDQoxOTAwIFMgTm9yZm9sayBTdCwgU3VpdGUg
MzUwIC0gIzQ1IA0KU2FuIE1hdGVvLCBDQSA5NDQwMyANCuKAiw0Kd3d3LmhhbW1lcnNwYWNlLmNv
bQ0K

