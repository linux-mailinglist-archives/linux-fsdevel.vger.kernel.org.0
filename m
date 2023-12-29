Return-Path: <linux-fsdevel+bounces-7029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B060D8202DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 00:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1842828222F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 23:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7201414F69;
	Fri, 29 Dec 2023 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="SPd4pnlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2095.outbound.protection.outlook.com [40.107.243.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4F14AB4;
	Fri, 29 Dec 2023 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qew5IWdlA07Dr7G+JfZ9FkoMtkbaiZ7rvdfZI6FrkuJczM8WYhUM4s3mFjjSTQHz8QsFh22JcPD77twRfz4OH/QMzn+r2EjKECjpPGC8G0EUQfNfLCoU/46G+juUW1fy2cuFTzr3MifrTlnQqHa3VA3l7BuW9b0QLc/MzewD3k/+68KYrTCOw/Z/ljqvVrSv05BnC7FVh8ltqw0inL3eSebZ7pNI0sYnukH/g0p/DL2ynXzT7/rZihy+cbEYorLRbdiBK7xJ2wh1+DEReCaOVkGtG5pk4t09tybWTRQNaMGRermC5p0Lj0ZHkVpihSTJNLRN/0KCJ6rVS19d+nF4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4box48hQ7pXBj0/ivzqbrdB8EMsIZOPQx9pvfHwpogA=;
 b=VvVcNb2Oy09gozMwLo2/Eyj5SnIubSshAihIXXPICnXTFbrMqJWI6P7iCLRu08mcr50hjy72iMCME8igfXSq9N0WWOWkucOYUrj9MsrOP71PndPVQS2Fa12GwiOOIr37fzOBhBJibRFwVrQmei0ICtYXgF4jZlltYHzCEH/uxb/8YMAlLu4cVf8CKjoYnccp2hZSaUyJOxovMPbw4B1O9gGTakXy5g7wRPN+czI2goCHNl1A4xby/4b29nwqEhIQOOtuLSZoTtx78ktRzHUFn8bywef+mbOU4CYctozT6+P1WyZif2lJFrOlp6+AB+/c4bcuGMjOaxC/DbEH2psSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4box48hQ7pXBj0/ivzqbrdB8EMsIZOPQx9pvfHwpogA=;
 b=SPd4pnlS9h+Glpg363vh+CwW4aUzqN7qPFpGN5JWb7I6kQqNMU74Tb8+lcnsW8qpZEUkABVJKqCHaCic7qabfokfkFGI0mBux6POcTbB5ErtMifTgfBHpSocvcYSMEM00MMfXka7AOzSuAdS4b7NzWKxTvLmyBfAZ/oC9EHb8jg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY1PR13MB6239.namprd13.prod.outlook.com (2603:10b6:a03:526::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Fri, 29 Dec
 2023 23:50:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 23:50:00 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "amir73il@gmail.com" <amir73il@gmail.com>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
Thread-Topic: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
Thread-Index: AQHaOcuIQhXuXI7gUE61seKNbWjvCbC/wUMAgACTgoCAADTxAIAAYE0AgAAF2wA=
Date: Fri, 29 Dec 2023 23:49:59 +0000
Message-ID: <a14bca2bb50eb0a305efc829262081b9b262d888.camel@hammerspace.com>
References: <20231228201510.985235-1-trondmy@kernel.org>
	 <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
	 <ZY7ZC9q8dGtoC2U/@tissot.1015granger.net>
	 <CAOQ4uxh1VDPVq7a82HECtKuVwhMRLGe3pvL6TY6Xoobp=vaTTw@mail.gmail.com>
	 <ZY9WPKwO2M6FXKpT@tissot.1015granger.net>
In-Reply-To: <ZY9WPKwO2M6FXKpT@tissot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY1PR13MB6239:EE_
x-ms-office365-filtering-correlation-id: 25658357-3afd-4d7a-6d64-08dc08c8de7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oeFfMbBLbtFs4vCSMrqyF09uil9FMf0dq6tTHuAJ4mE5dU0zRkwICJVml8D4rOA5hzscVy2f2zPvQkAo+f4Q0KLJh+7vMmcTVjIoHq6RvkLqmhtvZGPivt/EbHmrS8VQXw/Dl2S7Ed6zV+ConTvQ+HYDFmLtnm9PBiMS2F6RtZmgtQcKIEDSCa2EHVgcl14tTtovlnXdzkWLUZDXwPkikWbYAQ+6BBn6mCHpodg8IAJH6ncaagOZ+vRHrdaGCGwnAffO3cpJ9xxH7oXiYEqUJEXv9HICT7Y5/zso6311G/BfoJneDgyLxpQMkyqLDuBOJ4xlCeNPf54l0wFpJieY9lTmvsSjkkDGZsdLuzEnUVFMF2JPUYSkTDbIdTH7qKdpcuSrpgCUNeaPyJyOhBzQBJ7b0DfxW9Vzt4LMwqDZzNbyjcygbMhP/Hqrr26y56mc9+qL+7qQsBpYFHaMKvbAfqlNkx/qYSXTQf1L1iojdQCpgAgPJiWcingRT9zYXEs5kmVHqyQMJIqpAeUebOLwObNJ6iiqLJsV1GPnXtYgtZWlFcphaDCAroauBnmOcQjRQw4SSqbFpoHtINwIj8ZLdrCVICNAxkSetvKKtW8qgrzmHuMwQyEgXJrA1eJgWPR2D+nfQosa2hgBy2TlyBxZt28wnaXT2NLOl9Cg37D3QOo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39840400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4001150100001)(86362001)(2906002)(5660300002)(41300700001)(122000001)(38070700009)(38100700002)(26005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(2616005)(54906003)(110136005)(316002)(53546011)(6506007)(6512007)(478600001)(6486002)(71200400001)(4326008)(36756003)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEp5TXlBL2wvN3BCYnlkVUxSWmk2eVIxT2R3QVJCRTAwVm5wejM4bjAvNnR2?=
 =?utf-8?B?MDNXRHNyV2RLeU9ya1ZPS1ZvOWpyVFpyVGF3S1FHM1NOYVoyT3MrdlU4RjVO?=
 =?utf-8?B?RzliZzdzLytOZUhPT25nRW5WbkQ3dWxqTWdCK0hHWjlGMUlZQVFiNExqR09p?=
 =?utf-8?B?ZjNOTWNoZS9nSmxhbGIwZTFBa2NjdDZYUjJlWG4yY0U5YmhWellMc3ZOeE9j?=
 =?utf-8?B?S25WK3BocTNuRWJBQ1YzV1hPRzM5Y0tsL2tHT3Fnclg4TUM5ZzNVUENNUnhw?=
 =?utf-8?B?MUx5UFNGTTNTbHZ3ZisvdTY1V0NtNXpwNmhqTE9tYWRsNkkzUjJxZHN6MXVL?=
 =?utf-8?B?NkFZa3NQci8rQTh5ZWk2UXRkZWVTaURLbnVzRmRwZDIrUG9oMXFTYXMybXpK?=
 =?utf-8?B?SHVjak1idmduLzNvSU9HaUEzeGlKUkQzc2dpbCtVT0w4T2RsbEI2a0dqTjZP?=
 =?utf-8?B?ZWw0TUVlbnN1QWN6VnZEdXdxbmJ2Z3liT2tReXZJZDI1SzZMOHJLWkpscUo3?=
 =?utf-8?B?NkoyVmhzUklQaEpTcmdtdnRtbHRTRU52UGg1bkprUlRlUnRma0FPZEJKTDhy?=
 =?utf-8?B?anZhY0JlMjU0RUpvR0RCMlI1bEs2VExtTlBOZnFDOVNzQ2thTVJ1dHFWcENY?=
 =?utf-8?B?b3E4MXFJdGlQblhTWmRCODJPNmV5a215RXlQTmI4aHp5UHJDWjJxejFlUkMv?=
 =?utf-8?B?T0lBT21jTk92RDl1YW9kVmVMVVJQT0t5Nm9nSnRRbHV2YzBHeCtiUERaWWhh?=
 =?utf-8?B?MjVrOVI0MGd2VC9FQkwxUjRrZkVEZzAzVEVSOGdoN1pJNk0rREQxMUxCS2dX?=
 =?utf-8?B?a3djdmFHZldrSjVJZVpncCsyWmpvRU1Va1g3bUlQVVE0VEJFYzJHOVhPOWlJ?=
 =?utf-8?B?WkplWEpLeWd2NlFvVW9DT3liUEtmN2hiK3FUdVRKeGhTVUtUVHlYbld2QVk5?=
 =?utf-8?B?My8xemovaG1mY0MycjM2NktycnJJWFRHSXFCYk1zMWZJY3ZjbUJxRGh3RzFM?=
 =?utf-8?B?N3MvL1pNbkI3djdId3RNanVtY1VFRXluUlFCN2tYZHBadjZHVVlJMTJBeTZR?=
 =?utf-8?B?dUZVMGdRb2tpY1o5dmY0TllWa3Z5NlN1YjNwTGFIUnI2cXBIOU1NaU9tU3J4?=
 =?utf-8?B?ZUZudW9UQk5kYnZsUmYrZElXZS9BTnBkUXRQWTBLSFEzL1JnYytmc09BSkhG?=
 =?utf-8?B?RDBYSmJYa3Y2YVQvT2ZodzFOSVRKTVI1dEtYUGlPRkZTaTBZTjBaVzlHa0pF?=
 =?utf-8?B?OUdBTWw5T3lhcFBmbC9KTTd5VlRiQkFmaTcwcG9vYmRvMEx4TytrOXBJRFMw?=
 =?utf-8?B?dkhIZUEzQlhURWtzZ24yVkxocVBocnNtZFFaZ0FZMWdLL3l2amVlenNzR203?=
 =?utf-8?B?NlEyZWpDcjBnYUQ1UDVUUzhxS3hrWkpoOXM3MURqWi91dUVhVVNxOE41QlM2?=
 =?utf-8?B?TjZtelIvek41N1pVRkVZOTF4djM3R3VoUWNxUXJxb24ySlhFZDZERXY4ZUpp?=
 =?utf-8?B?NmNQODkrVUlFZ1FiWHlMRUhtNlZvQThCeTFPc2dtTk5IbVJMVHhTanQ1eThO?=
 =?utf-8?B?UUVkVEtLNzRUNTBleUlhVnB3Y1kzeVY2RXozZG1LM2UxQmRLMVkrVEJ1Mm5P?=
 =?utf-8?B?TXhIaTM4SmErWVFEY1lFZEJzVnl2Z3U1QzNrZTQxS2w2T1FNTmdyK3RVckl1?=
 =?utf-8?B?VjNqb3BLNjVpd1daYUhUS28zdGU0WVZQMHFzZ0NUL3RuMW5RY0EvMXB6UkpZ?=
 =?utf-8?B?YllGd2FUZHlmQm1IYnhoVmdUblhtY2kyTCtoZ1pZNTJwZEJIUkNpMENWOFp6?=
 =?utf-8?B?THc5dWVZWXJWOThodzhGT3BjNjV5ZFhxTzJlQXdMb3JKamd2bU5QbU1qb1NU?=
 =?utf-8?B?ZlZpY0sxY2d2YmxsSkxVWWdUZUo3M3F0L0E5WjcvY0pxTGJpUXVPMDR6L0Z0?=
 =?utf-8?B?bm4wL29vZmxlVzZ2WStaRmZkdWsrbGtXdWVobzArNXkyZ0J5SVA3MnAvUjFY?=
 =?utf-8?B?YmxsQnh5V1Z1d0R1WkRSd0YvV3NuelBzeVZaS29FMlltWUFXUWFiMC8rNExt?=
 =?utf-8?B?a3U2L20yWG1GWldGVEhjWE1kaGc4Z3MxZVMyZmVJZElYK29mMm16RXlUOUdT?=
 =?utf-8?B?TDIrTUFIM0tUMEwzb3lXRlRPS29mZHl4bjYxZWc2d0Q4dDFFV1plUmFtTTNM?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6AD49C8C5773941B4F7E0C4A2058A85@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25658357-3afd-4d7a-6d64-08dc08c8de7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 23:49:59.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZMASb3XoN6QwU7WWsCJ2jk7MTrAB3FXrwzWe6LzKPSYOu1AoxF56G4P1asa60qqBDEOWTq9e+dyfLi8Mga8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6239

T24gRnJpLCAyMDIzLTEyLTI5IGF0IDE4OjI5IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gRnJpLCBEZWMgMjksIDIwMjMgYXQgMDc6NDQ6MjBQTSArMDIwMCwgQW1pciBHb2xkc3RlaW4g
d3JvdGU6DQo+ID4gT24gRnJpLCBEZWMgMjksIDIwMjMgYXQgNDozNeKAr1BNIENodWNrIExldmVy
DQo+ID4gPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBG
cmksIERlYyAyOSwgMjAyMyBhdCAwNzo0Njo1NEFNICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90
ZToNCj4gPiA+ID4gW0NDOiBmc2RldmVsLCB2aXJvXQ0KPiA+ID4gDQo+ID4gPiBUaGFua3MgZm9y
IHBpY2tpbmcgdGhpcyB1cCwgQW1pciwgYW5kIGZvciBjb3B5aW5nIHZpcm8vZnNkZXZlbC4gSQ0K
PiA+ID4gd2FzIHBsYW5uaW5nIHRvIHJlcG9zdCB0aGlzIG5leHQgd2VlayB3aGVuIG1vcmUgZm9s
a3MgYXJlIGJhY2ssDQo+ID4gPiBidXQNCj4gPiA+IHRoaXMgd29ya3MgdG9vLg0KPiA+ID4gDQo+
ID4gPiBUcm9uZCwgaWYgeW91J2QgbGlrZSwgSSBjYW4gaGFuZGxlIHJldmlldyBjaGFuZ2VzIGlm
IHlvdSBkb24ndA0KPiA+ID4gaGF2ZQ0KPiA+ID4gdGltZSB0byBmb2xsb3cgdXAuDQo+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gPiBPbiBUaHUsIERlYyAyOCwgMjAyMyBhdCAxMDoyMuKAr1BNIDx0cm9u
ZG15QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZyb206IFRyb25k
IE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBUaGUgZmFsbGJhY2sgaW1wbGVtZW50YXRpb24gZm9yIHRoZSBnZXRfbmFtZSBl
eHBvcnQgb3BlcmF0aW9uDQo+ID4gPiA+ID4gdXNlcw0KPiA+ID4gPiA+IHJlYWRkaXIoKSB0byB0
cnkgdG8gbWF0Y2ggdGhlIGlub2RlIG51bWJlciB0byBhIGZpbGVuYW1lLg0KPiA+ID4gPiA+IFRo
YXQgZmlsZW5hbWUNCj4gPiA+ID4gPiBpcyB0aGVuIHVzZWQgdG9nZXRoZXIgd2l0aCBsb29rdXBf
b25lKCkgdG8gcHJvZHVjZSBhIGRlbnRyeS4NCj4gPiA+ID4gPiBBIHByb2JsZW0gYXJpc2VzIHdo
ZW4gd2UgbWF0Y2ggdGhlICcuJyBvciAnLi4nIGVudHJpZXMsIHNpbmNlDQo+ID4gPiA+ID4gdGhh
dA0KPiA+ID4gPiA+IGNhdXNlcyBsb29rdXBfb25lKCkgdG8gZmFpbC4gVGhpcyBoYXMgc29tZXRp
bWVzIGJlZW4gc2VlbiB0bw0KPiA+ID4gPiA+IG9jY3VyIGZvcg0KPiA+ID4gPiA+IGZpbGVzeXN0
ZW1zIHRoYXQgdmlvbGF0ZSBQT1NJWCByZXF1aXJlbWVudHMgYXJvdW5kIHVuaXF1ZW5lc3MNCj4g
PiA+ID4gPiBvZiBpbm9kZQ0KPiA+ID4gPiA+IG51bWJlcnMsIHNvbWV0aGluZyB0aGF0IGlzIGNv
bW1vbiBmb3Igc25hcHNob3QgZGlyZWN0b3JpZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBPdWNoLiBO
YXN0eS4NCj4gPiA+ID4gDQo+ID4gPiA+IExvb2tzIHRvIG1lIGxpa2UgdGhlIHJvb3QgY2F1c2Ug
aXMgImZpbGVzeXN0ZW1zIHRoYXQgdmlvbGF0ZQ0KPiA+ID4gPiBQT1NJWA0KPiA+ID4gPiByZXF1
aXJlbWVudHMgYXJvdW5kIHVuaXF1ZW5lc3Mgb2YgaW5vZGUgbnVtYmVycyIuDQo+ID4gPiA+IFRo
aXMgdmlvbGF0aW9uIGNhbiBjYXVzZSBhbnkgb2YgdGhlIHBhcmVudCdzIGNoaWxkcmVuIHRvDQo+
ID4gPiA+IHdyb25nbHkgbWF0Y2gNCj4gPiA+ID4gZ2V0X25hbWUoKSBub3Qgb25seSAnLicgYW5k
ICcuLicgYW5kIGZhaWwgdGhlIGRfaW5vZGUgc2FuaXR5DQo+ID4gPiA+IGNoZWNrIGFmdGVyDQo+
ID4gPiA+IGxvb2t1cF9vbmUoKS4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgdW5kZXJzdGFuZCB3aHkg
dGhpcyB3b3VsZCBiZSBjb21tb24gd2l0aCBwYXJlbnQgb2Ygc25hcHNob3QNCj4gPiA+ID4gZGly
LA0KPiA+ID4gPiBidXQgdGhlIG9ubHkgZnMgdGhhdCBzdXBwb3J0IHNuYXBzaG90cyB0aGF0IEkg
a25vdyBvZiAoYnRyZnMsDQo+ID4gPiA+IGJjYWNoZWZzKQ0KPiA+ID4gPiBkbyBpbXBsZW1lbnQg
LT5nZXRfbmFtZSgpLCBzbyB3aGljaCBmaWxlc3lzdGVtIGRpZCB5b3UNCj4gPiA+ID4gZW5jb3Vu
dGVyDQo+ID4gPiA+IHRoaXMgYmVoYXZpb3Igd2l0aD8gY2FuIGl0IGJlIGZpeGVkIGJ5IGltcGxl
bWVudGluZyBhIHNuYXBzaG90DQo+ID4gPiA+IGF3YXJlIC0+Z2V0X25hbWUoKT8NCj4gPiA+ID4g
DQo+ID4gPiA+ID4gVGhpcyBwYXRjaCBqdXN0IGVuc3VyZXMgdGhhdCB3ZSBza2lwICcuJyBhbmQg
Jy4uJyByYXRoZXIgdGhhbg0KPiA+ID4gPiA+IGFsbG93aW5nIGENCj4gPiA+ID4gPiBtYXRjaC4N
Cj4gPiA+ID4gDQo+ID4gPiA+IEkgYWdyZWUgdGhhdCBza2lwcGluZyAnLicgYW5kICcuLicgbWFr
ZXMgc2Vuc2UsIGJ1dC4uLg0KPiA+ID4gDQo+ID4gPiBEb2VzIHNraXBwaW5nICcuJyBhbmQgJy4u
JyBtYWtlIHNlbnNlIGZvciBmaWxlIHN5c3RlbXMgdGhhdCBkbw0KPiA+IA0KPiA+IEl0IG1ha2Vz
IHNlbnNlIGJlY2F1c2UgaWYgdGhlIGNoaWxkJ3MgbmFtZSBpbiBpdHMgcGFyZW50IHdvdWxkDQo+
ID4gaGF2ZSBiZWVuICIuIiBvciAiLi4iIGl0IHdvdWxkIGhhdmUgYmVlbiBpdHMgb3duIHBhcmVu
dCBvciBpdHMgb3duDQo+ID4gZ3JhbmRwYXJlbnQgKEVMT09QIHNpdHVhdGlvbikuDQo+ID4gSU9X
LCB3ZSBjYW4gc2FmZWx5IHNraXAgIi4iIGFuZCAiLi4iLCByZWdhcmRsZXNzIG9mIGFueXRoaW5n
IGVsc2UuDQo+IA0KPiBUaGlzIG5ldyBjb21tZW50Og0KPiANCj4gKwkvKiBJZ25vcmUgdGhlICcu
JyBhbmQgJy4uJyBlbnRyaWVzICovDQo+IA0KPiB0aGVuIHNlZW1zIGluYWRlcXVhdGUgdG8gZXhw
bGFpbiB3aHkgZG90IGFuZCBkb3QtZG90IGFyZSBub3cgbmV2ZXINCj4gbWF0Y2hlZC4gUGVyaGFw
cyB0aGUgZnVuY3Rpb24ncyBkb2N1bWVudGluZyBjb21tZW50IGNvdWxkIGV4cGFuZCBvbg0KPiB0
aGlzIGEgbGl0dGxlLiBJJ2xsIGdpdmUgaXQgc29tZSB0aG91Z2h0Lg0KDQpUaGUgcG9pbnQgb2Yg
dGhpcyBjb2RlIGlzIHRvIGF0dGVtcHQgdG8gY3JlYXRlIGEgdmFsaWQgcGF0aCB0aGF0DQpjb25u
ZWN0cyB0aGUgaW5vZGUgZm91bmQgYnkgdGhlIGZpbGVoYW5kbGUgdG8gdGhlIGV4cG9ydCBwb2lu
dC4gVGhlDQpyZWFkZGlyKCkgbXVzdCBkZXRlcm1pbmUgYSB2YWxpZCBuYW1lIGZvciBhIGRlbnRy
eSB0aGF0IGlzIGEgY29tcG9uZW50DQpvZiB0aGF0IHBhdGgsIHdoaWNoIGlzIHdoeSAnLicgYW5k
ICcuLicgY2FuIG5ldmVyIGJlIGFjY2VwdGFibGUuDQoNClRoaXMgaXMgd2h5IEkgdGhpbmsgd2Ug
c2hvdWxkIGtlZXAgdGhlICdGaXhlczonIGxpbmUuIFRoZSBjb21taXQgaXQNCnBvaW50cyB0byBl
eHBsYWlucyBxdWl0ZSBjb25jaXNlbHkgd2h5IHRoaXMgcGF0Y2ggaXMgbmVlZGVkLg0KDQo+IA0K
PiANCj4gPiA+IGluZGVlZCBndWFyYW50ZWUgaW5vZGUgbnVtYmVyIHVuaXF1ZW5lc3M/IEdpdmVu
IHlvdXIgZXhwbGFuYXRpb24NCj4gPiA+IGhlcmUsIEknbSB3b25kZXJpbmcgd2hldGhlciB0aGUg
Z2VuZXJpYyBnZXRfbmFtZSgpIGZ1bmN0aW9uIGlzDQo+ID4gPiB0aGUNCj4gPiA+IHJpZ2h0IHBs
YWNlIHRvIGFkZHJlc3MgdGhlIGlzc3VlLg0KPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=

