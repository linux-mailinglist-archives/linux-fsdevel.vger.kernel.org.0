Return-Path: <linux-fsdevel+bounces-10678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24B84D587
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F444B22DDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA823132C11;
	Wed,  7 Feb 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="now1D/aq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696EF12880D
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342264; cv=fail; b=TWAyDPSlcDT2KuM4RAldDmnGthHDu1ADdRqfBNsKl/XmDoCkHq2NfbhKYYebTdy6YmaOj/SaiYM4TOOyHscD7ts188RPyhfC/Kifd0zI+78uh7dxg2WpbIAdVMAkVsbSyYE3KTibbWLox0Ps90qzFlxZujDPgLjef4t8W/GbUCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342264; c=relaxed/simple;
	bh=hMg2LXAJUYFPO6lJdjz/Q1m9So5OyYiU+5RmykX63tQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ax5PBuj7ZdRs0Kaoq3FsENa9UH1MK2EcPou8GSJtcY3t+F47mYEddrcbxoAserX6O9vTW6YjwpNSi0XFwtMqevFE/49Y5j9nLXfD9dKYiVbZePR+I5/YWl0FI2OEE0y0aNGCq7l/z9M23OLSKJVzrBN2Gk9vDTTMPsq9W3488sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=now1D/aq; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXV0AjDxJQxJnjub/RMyX14D6gl+nTxDia5geK8+0fJy5c06HvP2cLMdX3++mSDN3CuJ7dllEpTwrEMM5PlHS+bR5WGAMa4wzHRMYe0zUJr3/bL2CI3paLouAlL9b1+Sfbwg0y40r+kVn+7ScYCCnDwGgsqz7XpTPoXq4KcjECsoCaRR9o4MYRfUi4elQPt9nyOHI4a87Zq9U64hx7Io8beHC826vGeJI6LkasDiMd7sxeNTCW1sAeE2bj78Vrun/yo05+7KVFlyfQoxMA33YRFxy5QA8QTRSFbp3Vh322e5IOH8zRC2gi+bQKTkGyLfNjpxLYZH8f0M6hixZ+LQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMg2LXAJUYFPO6lJdjz/Q1m9So5OyYiU+5RmykX63tQ=;
 b=Gd3LZACfYXMRIpgG1Gt46kvEiaIzNMyB3Sg6+83uoBsk0JVEN4ghmVSPiGKmW1Le70M5lUtmE6thLx+gyp56CPKGR7z1aO/Nkd7PoWk3Sfd9Fq246NlzBa7yRv5oSsNPdvh39IDfVm2EIvDc/+IJnHJ8MBVkKn6CgPw01bufQqblZv6ZIb1PkIMDCWubzhDUyLN5ePEgvXpkRjWAyqMhIfaAeFlbpPqGkdMmDu7gOHU815mVI8buNQsVGs3k1NQX3k8c1Li0DTV+V1DlpmjKfGG9IVlKYoo+mZP2FLK5rN6RRzCQcUX7Umscq8L/5YvdMzSndTjx4V9LafZsfjvfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMg2LXAJUYFPO6lJdjz/Q1m9So5OyYiU+5RmykX63tQ=;
 b=now1D/aqNFu3szFGUCjQKTHD2ycpmOuoq6EebILtPZC3MOKHPyjOO+TPmIlcFZxCNtJoYJ3rusy6537rkGibyynJ7qB4yPwb2evvB0xdtJny2Pnkep4zd73DFLb/cQ26HaRJtEBbasMqk3bgGL1CPIcY5MhuDjZH0BxWJ652sVNrgKzUgHXyUzadFrw4KojDAdYN4/DKob+X/6d3dd0Qy3t6FhrMB7zZHWc6b4ha2SePridaKpnAXjAR8wUD2yTchYGPwQOUeN9HVTyYZcMvR5EVTWDVJ+dORFOJRzhEgejGkuhjorZI0EnkKOZx1q8zT/RoyMqLavN98b9s4T0nEQ==
Received: from SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12)
 by DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 21:44:19 +0000
Received: from SN7PR12MB8769.namprd12.prod.outlook.com
 ([fe80::9f0f:632e:815c:f953]) by SN7PR12MB8769.namprd12.prod.outlook.com
 ([fe80::9f0f:632e:815c:f953%7]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 21:44:19 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "david@fromorbit.com" <david@fromorbit.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "michael@ellerman.id.au"
	<michael@ellerman.id.au>
Subject: Re: [PATCH] debufgs: debugfs_create_blob can set the file size
Thread-Topic: [PATCH] debufgs: debugfs_create_blob can set the file size
Thread-Index: AQHaWgE+grTE5SehCkWVnczcxwLZYrD/aH4AgAABGQA=
Date: Wed, 7 Feb 2024 21:44:19 +0000
Message-ID: <6f7565b9d38a6a9bddb407462ae53eb2ceaf0323.camel@nvidia.com>
References: <20240207200619.3354549-1-ttabi@nvidia.com>
	 <ZcP4xsiohW7jOe78@dread.disaster.area>
In-Reply-To: <ZcP4xsiohW7jOe78@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8769:EE_|DM4PR12MB5216:EE_
x-ms-office365-filtering-correlation-id: 80071a86-065e-4fd5-51ae-08dc2825f06c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZG6HOcV6mkAYpSqnWiJOzOpBxWBJpTTdswn84S4IdUF4TWPt2SkVpyGZiTZsG1n+9QFoQ23/1SzJZy33txHXpKTEViF9cJDFo8QglZkRDjHQdEuyyL71VJZuhKgV6TPw5FGsH1ry28mqmrTP9dkxcqtsoaWAPuw3ePX2IrKl/XDEwsXHq78ihlf7VfoULF/M9MhYEXuMstcfH8R3+cPOQCI0JuCEYWMYeOLuZbs6O4TjvArL8AQLNok+ozWwCS1xsc3l7u1RtJD4EU/BsDcn/t0fK2D9QP+rrJooSNR3k3kCPcQgwqRPGZcXHduaNSNsm2c+W9tNt0ZRxMUD/rej7qhROWxDTECq3axoeURCS58OxMu++1sO090fygxTPe7EMhDSG7Nac+XSlfphi9Z053n4rxjcO9BKRHTt+joPcQ4rX2rpj1/kYWfiFBZ5m40lZ961fuGftsSCze3mV4qqF0r+ssBa6FMqQb73b4InycbBeOZI0hWJcdh7A4dPYt1xBYZmV0rvE3nbmKaurM9oD/y6x0K6flZZ2ImJdUo66VsGmXY8xbdo2h5qfNvc5Zi8VzvoffcWlAY0wUII4teNGx7JKNX1gTgWWnygNUvC8aumf+rBzA1ezWQBG8/Isptm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(41300700001)(66476007)(66946007)(38070700009)(122000001)(38100700002)(36756003)(316002)(64756008)(71200400001)(6486002)(66446008)(66556008)(478600001)(6506007)(6512007)(4326008)(4744005)(2906002)(86362001)(54906003)(6916009)(5660300002)(8936002)(76116006)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXlQTGVwV3o4K0VWQndneVh5TFlaWVFEbzJXQlFONjA4V2d5VE90MWxSSzkv?=
 =?utf-8?B?bFZLa3JHVDNGakFMS1hkbW1DR3VySGpxbUJXR1JTQno4QkNweUFRMFFHVnBJ?=
 =?utf-8?B?UDFFMzdBYi9raDMydU5LWGsrb2FZUVJYVy9wVy9TZm9nKzV1ZEdNV25VeGhD?=
 =?utf-8?B?L0lGdkRPV1dxMVJvbXdEZ3Y1T010enhLVWhsOVppRGVsT0k5UTYyMEhSWXFh?=
 =?utf-8?B?NmkrdTBubEpicDdkWDk5UnJWSUhZZzU3RUxGYWpBa3BpZFE5WDkzbnJndUZs?=
 =?utf-8?B?M2xxRkhsYjR6MWhaTm8vWU81UmxNWG12dy9JcGJWZzcvNUMxUkYyMFUyZ2JE?=
 =?utf-8?B?blRkSGpuZmNudU9KaExYazdVc1ljTFlKTHhDVU41THVQZkdJVS9NOWxBdUpx?=
 =?utf-8?B?RFhyWFJyRDg2c0xmMjl1dEJqMmNQbmVGOG5ORnhuWDVOUUJMdUdaclZ0Mm9Z?=
 =?utf-8?B?SHB1YXhZSWtWQmJvRUp4ZStON1pGcWpwM3BhdWRWc0JiNlFnaWJ1UXZDNWdL?=
 =?utf-8?B?ODVXaUxmMnFCUnYrYzZlZEJTOGpiWVM4eUlzdVVSUDluMStoSWR5SG51amFv?=
 =?utf-8?B?cSswcTdWUnpMNDNsQy9FcE1DQkVFMDZWNkdVRmZGMlFhSUtJdFM4ekNkaG54?=
 =?utf-8?B?L2hjUlIzSmNOV1FKV2lNREd2Y05tbXg5TFUrTDc5U2RtMDhMUmY1ZUlldEJ1?=
 =?utf-8?B?VUVNUTdsN1dMd1FJLy9BQ3BHY1FtRTF6ZUNZTGZBYlRyaWx0Ky9NeEFSQWdo?=
 =?utf-8?B?ejMva2EzNmtKTTQ0TitLR1AyUHZhTXdtUnl6VVZTZFZrdGZCRFBhZ3JxRkYz?=
 =?utf-8?B?WVp3ZHZaOS94ZjVPbkZ3VnFPOU94bXlJOU9uWDY2R3NxQUNzelhyTElLSzdC?=
 =?utf-8?B?T0JCV3UxQ2w5YXZVdHJUbEpBM1VjZkVnbzlMWFRXQlNVR2F5ZjBpeWZxOTl1?=
 =?utf-8?B?UU8wdmk2aVRGclUwMDJsbkt3aGxaNHhPNTR4TWpkQ1hzcHpJYXpRaExKWTk2?=
 =?utf-8?B?WDBvSzFydlZtaTIySGEvTWhTQWdva2g1SmF1RTZvbVhpdDFwUnpYbTV3SVdS?=
 =?utf-8?B?V0ZmSmd6ZXd3MkxFYjh1TEMvOUFSVlVKdGtqbTk1U0VYTzlsMnoxSzRTOUda?=
 =?utf-8?B?RkoxeTJIUVZjU3lIN2YzUzkwZTdKbEozVDNIaU9JN3R3L0ltbTE1Ymhra0x6?=
 =?utf-8?B?eHovb2tjMzQrMzdkcitTbHJXeUcybmdyUUlDakRlb3JuQzM3aXByRUZPekpr?=
 =?utf-8?B?cUxOV0JRMWxOZHRxbldRdWhmMTZxRzFiVnhQcnhxWUl2SFRWSTQzWmRabklK?=
 =?utf-8?B?eDJWckJmbFRvSkZiUDRnZ2taN0wvRCtPQUlVSklFQThRTzVlME9YMzk4aStj?=
 =?utf-8?B?N2pZdWgySzdXTWxDMFFKRyt5ZnltS2VoSll2dkFGUU9TZlZLYnNvN1FEbUp5?=
 =?utf-8?B?bWtoQnE4dy90ckJTZ1dIMXlTRVk1MGtpNUpoYnlqRUgxZE82dzlaVzhad3Rn?=
 =?utf-8?B?VVd0KzI2d1lLbHVIR2FpdDhPZFVxQjVrM2NzTFZBeS8ybmJiWU5OZXYyenVh?=
 =?utf-8?B?UWlCR3UvQ3pZeVZuVnNZTW4wNTJjaXh0dUs1ZzJCZnI0YVQ2NC9UdDdISjEr?=
 =?utf-8?B?YWduMVA2SVVNMGtSV1d4RmhkNHgvYSs3eXcrajVwL2pNdUo2bnFwc3JLMk94?=
 =?utf-8?B?OWNJdGkxS1Z4Y3BTaGk3VjduYmVsSTVOVWJXSEwvV1dKTnV0VGEvdkVsekhj?=
 =?utf-8?B?NDFWUGtTRVhOTDJVbFpLdlhENU15WVNoVkFlU2VGRWZ5aU1VNHFDT2dBUlNB?=
 =?utf-8?B?eGcxWFM3WnJyYUFHYUNqWnNCdEpBKzZZekRNOEJVQnltMUtwZDY5K3hZSkxM?=
 =?utf-8?B?WXpteDFwNFhqcnQ0bGN1clBGOGdJUFBSWjVoSFJxOGEvQ1RMeW9uU0ZmVEZw?=
 =?utf-8?B?UGJZS2JDNkdvNkRTNzFHN3JDZXhRVllnRm9HUHZRWjJQWHZ2aThTV3c1YVQ4?=
 =?utf-8?B?ekhVdzJYYms4MEFMM1ZBTFhaNmpxSHdkamVzSXdORDdVTjdUMStaVmI1cFdZ?=
 =?utf-8?B?Y09pcGN3OXd5dHFHamVGdmczaFpvT1NkdnFQanBEL0lqcm9PMVdpNEVscEZr?=
 =?utf-8?Q?pdf3lQLO3G9TAQaApZuQlKY5R?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBE7E8667C23EB4487DA1311019E81BA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80071a86-065e-4fd5-51ae-08dc2825f06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 21:44:19.2110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oY1AU/gzj0S+fhO+rNrF4qwDb69Ntt2+6WAlvFnwkpxFXzsBxl80CTQmw4ItbdGsRIJZCvI95tHci5JiQxs+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216

T24gVGh1LCAyMDI0LTAyLTA4IGF0IDA4OjQwICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IGlfc2l6ZV93cml0ZSgpPw0KDQpUaGFua3MsIEkgd2lsbCBwb3N0IGEgdjIuDQoNCj4gDQo+IEFu
ZCB3aHkgZG9lc24ndCBkZWJ1Z2ZzX2NyZWF0ZV9maWxlX3Vuc2FmZSgpIGRvIHRoaXMgYWxyZWFk
eSB3aGVuIGl0DQo+IGF0dGFjaGVzIHRoZSBibG9iIHRvIHRoZSBpbm9kZT8gDQoNCkJlY2F1c2Ug
aXQgZG9lc24ndCBrbm93IHRoZSBzaXplIGFueSBtb3JlLg0KDQpUaGUgJ2Jsb2InIGluIGRlYnVn
ZnNfY3JlYXRlX2Jsb2IoKSBpcyB0aGlzOg0KDQpzdHJ1Y3QgZGVidWdmc19ibG9iX3dyYXBwZXIg
ew0KCXZvaWQgKmRhdGE7DQoJdW5zaWduZWQgbG9uZyBzaXplOw0KfTsNCg0KV2hlbiBpdCBwYXNz
ZXMgdGhlIGJsb2IgdG8gZGVidWdmc19jcmVhdGVfZmlsZV91bnNhZmUoKSwgdGhhdCdzIHBhc3Nl
ZCBhcw0KInZvaWQgKmRhdGEiLCBhbmQgc28gZGVidWdmc19jcmVhdGVfZmlsZV91bnNhZmUoKSBk
b2Vzbid0IGtub3cgdGhhdCBpdCdzIGENCidibG9iJyBhbnkgbW9yZS4NCg0K

