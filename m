Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0052B2DDDB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 05:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbgLREkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 23:40:01 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:37608 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbgLREkB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 23:40:01 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdc32770000>; Fri, 18 Dec 2020 12:39:19 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Dec
 2020 04:39:18 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Dec 2020 04:39:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3S04js5ptLgXQgA74v6U6ALosFLgLPo7dJFICkSDBCkosWlpzAXmm6Wo9M2Nf7Sk9IfT4ObV1W4nlNQKfytkRP/6DbRPTuX/YahJCfCF62gKVzc/PWYHWSyB9fWu8a16Iyaku5XUWAb/xA4JO9iUAaYaU21WZfQRyC5gMZYvWhmAXt3Ji/4zQPM5tuu+WPRQW8d+12G5Nso9WLDMSmV4yWIK0thfKU31FZkqWve+UtYuATVS9B+z/hCHRiwtvfb00lDmoHAEahoI7LUS3xmR9gzxoaqsnSnIHHrtiTFyovGjPhecxML3kztfEnmm8o2QsDfJeoUoGwvqPxrYrIdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJyJSEsIjkx97Ed3rmk5mHTWxSX77FhEyCaoPV+z6l0=;
 b=knV8yQqlNQJVyWleqBwVj6jE9QKMstiBqnJUUZ25/wLSMOi+B7IxC+yREz/4O+v5JC7r+sCA2J4ykKhtCUWg5h2S/9tVQKiF/61nkumqqKA5bTlXlsfxVoIkBaqS6ggr5nJeZikURnhhM9o0G0Td2qTnfOCsG64oZBPgcYoF7SDNQiunxAo8BzVxpKKJpfxahFcJtV/XbHeK632aTDV71zRww4v1mpCQeOK8gGkAu5T+H5p9e4XBGKluhIPW81NVqXHXDMFnSbkIA2iisQj3APRMcmTSyfziGXbO8L8ooZB0g2Dl9cJNSrPtk/2p16yOVdIMV91tK/rs+K3gn4j21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3385.namprd12.prod.outlook.com (2603:10b6:5:39::16) by
 DM6PR12MB3195.namprd12.prod.outlook.com (2603:10b6:5:183::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Fri, 18 Dec 2020 04:39:15 +0000
Received: from DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::ddfe:5f48:eeff:1eef]) by DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::ddfe:5f48:eeff:1eef%3]) with mapi id 15.20.3654.025; Fri, 18 Dec 2020
 04:39:15 +0000
From:   Ken Schalk <kschalk@nvidia.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [fuse-devel] Cross-host entry caching and file open/create
Thread-Topic: [fuse-devel] Cross-host entry caching and file open/create
Thread-Index: AdZ2cgXArydRfBZsQFmRYJ9twGDRZwBYJUoAAQSxwqAAZXXxAAapP22ACmTT0CAAIaI9AASu1N3w
Date:   Fri, 18 Dec 2020 04:39:15 +0000
Message-ID: <DM6PR12MB3385E1298E4C729F734548C4DDC30@DM6PR12MB3385.namprd12.prod.outlook.com>
References: <DM6PR12MB33857B8B2E49DF0DD0C4F950DD5D0@DM6PR12MB3385.namprd12.prod.outlook.com>
 <CAJfpegu6-hKCdEiZxb9KrZUrMT_UozjaWC5qY00xwqqopb=1SA@mail.gmail.com>
 <DM6PR12MB33856CB9CC50BE5D7E9B436DDD540@DM6PR12MB3385.namprd12.prod.outlook.com>
 <DM6PR12MB3385C2556A59B3F33FE8B980DD520@DM6PR12MB3385.namprd12.prod.outlook.com>
 <CAJfpegv5EckmJ_PCqHc2N3_jHaXfinMwvDNSttYNXcan1wr1fQ@mail.gmail.com>
 <DM6PR12MB33851BCA35DC6EB3158C84B5DDFC0@DM6PR12MB3385.namprd12.prod.outlook.com>
 <CAJfpeguja0QPtn3jKcd1k4MK=eauLt4RgHyqJnxYeTU8h=WDcg@mail.gmail.com>
In-Reply-To: <CAJfpeguja0QPtn3jKcd1k4MK=eauLt4RgHyqJnxYeTU8h=WDcg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kschalk@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-12-18T04:39:13.7697997Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=1ce08fb6-739e-47bc-b03f-f7717e55e24e;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: szeredi.hu; dkim=none (message not signed)
 header.d=none;szeredi.hu; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b334068d-0e52-49fa-2aca-08d8a30ee02c
x-ms-traffictypediagnostic: DM6PR12MB3195:
x-microsoft-antispam-prvs: <DM6PR12MB319516B20CF10D72F514E58FDDC30@DM6PR12MB3195.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4xwSVePf9b/9DpUHSHUovJF5YIpkzxVv3Py4/CxL4yaIZ1sLGCyGUargcP6BtnagehTSY8NjFqOdSWb0UhKbNrdCBffsH77jo0hAq2o3h8fpSr2GDEVZOy/jgCZLjGj/68yZ4k8Dw4iBYGZ62p45cE7U8Tx1kNFAs9eynY0fG+JavlUMaxPuscaVNV/xRYnUQctZXZzyt8lfwmw8j9NNNi8Tdbn76gx5ke1imKvwmULPSW5Soj12ruMKK5K6B7aKTrqX0uYKQASDLY1QUSfdF1ZmIAELGdIfAlpJMm937aoqNFKpSS6MNI1FLNIDruWqxFYAB5Iqpimg8DV4q4pYvmFDy72y7MUIC8IG6W7q3rqj/FeCIBxKgeXlgT0eqhQ9pXshKMHZs3smZIuTW+b9wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3385.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(478600001)(86362001)(71200400001)(9686003)(6916009)(2906002)(55016002)(7696005)(52536014)(33656002)(66446008)(6506007)(316002)(64756008)(83380400001)(4326008)(26005)(8676002)(5660300002)(66556008)(66476007)(186003)(76116006)(66946007)(8936002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aEdsbXhuWmszMkJZK2poVjVLSVZ6cXo0RmJyV2Qvemp6S2tkdDFqbE9XdjMv?=
 =?utf-8?B?NStrL0VHNlc2SHdKU0VJUVhKYnMvMVhVTWQ1R0tBRG53MGltemZ6bU5FMDRn?=
 =?utf-8?B?Qyt5azFyL2MwcGc4OTc4aGhxdVJ5YlJpdVgzSlB1T1RDdm50UDNERTNOV3VF?=
 =?utf-8?B?RTBZL3p6a1JqMnlhZzZkUXdhWkhwN3d2eGxXaGYwZXNpSDdvVjU0U0hPVTFs?=
 =?utf-8?B?WnF6VSt1aStuUkVhYlFHUlBHZ3pEVHFhTU96RitrVmN5MnRmeHZjcGNlUWI5?=
 =?utf-8?B?S0hzbVJDNmtqMDUvZWx5WkovM1QxWUhuTDlXMHo3dng5dU8rKzdCN29VRzV6?=
 =?utf-8?B?RVpmV05Jdm1jRm5TQTVnOTBpUW8vdk9xUk9MYkhJNkJkYXE5ZG9sSXN6Wi8z?=
 =?utf-8?B?MGEvRUU1c0JNbDd6UWd0RXJyMmx6YnFYR21oRnRVM1FrdXRDU0o2VDhLeXpC?=
 =?utf-8?B?a1lnbEdLak1ZZk9FOGhPTVRQSkJxQXpwYnJrZDlqdzI5MHdSUU1YSENrK1dp?=
 =?utf-8?B?SEdSbFZDVmhUVXcvN1VJMzBVNmJFdGxqWDU4WXNUd3NPbkRmM0JOTGoxaWRY?=
 =?utf-8?B?eXFsaTBQdmpLMjRZMGNqQ2dmWnc0Q2hwOWtYKzhYTUtmYVZtaHNMZ1B0S3JS?=
 =?utf-8?B?RFNQaFFjV3E3NkdjWXY1cjREZ2gxUGs5ZXVwakRtRFFvUjlGOXY1VkM3VjRz?=
 =?utf-8?B?RVhmaXQ2ay9oK0UyR1JMR2E3ek85SnErT01YUzNJUERhb1RDZWE3UEt0dGZQ?=
 =?utf-8?B?NXZYSS9IT0paZmptSnMrbnd1WDdTTjhIR2szaXZjakdRRHk0OFZkTVRLVDl2?=
 =?utf-8?B?M0JmVlhUbFBWL1BOUFFVSzVSTTN5NlN5Y3hjT1JKSW9mekloQnRaZUM2NnFh?=
 =?utf-8?B?VXVrdWxYYW5RSUJBQW1kMk1qV0QzVnJQd3p5MVU4SzJXdmc3SW55OWN5bGg0?=
 =?utf-8?B?ZzZoVVFxVmo2N3hoczFHdnFrUGZ3WGRVK2txdm1xUVJ5T0huazQ5cFpuVHlN?=
 =?utf-8?B?RjFLbWluU0NXVkhqbzRpNW1pL3FxT0x0QXlpNWNtNWkrejg5TVRCbmRLQ21X?=
 =?utf-8?B?N2dtS052QWducHZpVFRKNmd5a3hrZ1prRTN0d0h4MUVVNFI0cjdka1JvaHBI?=
 =?utf-8?B?Yy85cWZzc09uN1F4UlBUdHhiNGVOdWZXalF3ME5YdEZJQjVSdHRzMmFnbG9G?=
 =?utf-8?B?ajM5YlhzdDRQWnBSV0JaRjhyZW02dEJXbXVpc2dOUytnOVVUYkpxVGFGZTRZ?=
 =?utf-8?B?eCtWZW5UM3poeWh4c3BoSGlJR3AvbnBuOXkzZ1lTZGVCZ2tPbkZJT0traE9i?=
 =?utf-8?Q?bJdb/Zw14jM7Q=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3385.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b334068d-0e52-49fa-2aca-08d8a30ee02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 04:39:15.7786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqCy6x3NL1rm6kiEcC5CMDYIGnY1cada0EdoKbl56Vafjt/iCgvlPLqbOBWWMcQhosZFrEibV7L/paFcaGT1SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3195
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608266359; bh=vJyJSEsIjkx97Ed3rmk5mHTWxSX77FhEyCaoPV+z6l0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:x-ms-exchange-transport-forked:
         Content-Type:Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=jONruBCT0QAJ1KZlz97uNoKfN9QZuNzJMvtd3HLeyGHWgSqakiKUfaQYcIBO8DpA0
         OLgBuTvXg48QSw3Jq3/KtP2hL5g40gHYkH8NeG39OHgUczBZVkhd9iRUesgSFU/I3b
         VukU9dhIgYfXOxY0C/LzY1Sm+P7fdwjMPHdt/KWWDNbm47q2BfaLGN74RZeqvyMG4y
         HwP1DfnOopSMfDZAN6wQISrt/RT0IDFAMpknm6FbI9A3HA25qUQuhiXqeZvRbBcLwZ
         n/3T9dm/fNWG2BmcuMp456Gd1UKrXDB7cd42cIsA1c6TTXCuEKhe9tn4tT1jkAr3Xs
         gWEhzhFii5JUw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCBOb3YgMjQsIDIwMjAgTWlrbG9zIFN6ZXJlZGkgPG1pa2xvc0BzemVyZWRpLmh1PiB3
cm90ZToNCj4gRVNUQUxFIGlzIHRoZSBjb3JyZWN0IGVycm9yIHZhbHVlIGhlcmUsIG5vdCBFTk9F
TlQuICBJIGFncmVlIHRoaXMgaXMNCj4gc3VidGxlIGFuZCBub3Qgd2VsbCBkb2N1bWVudGVkLCBi
dXQgaXQncyBxdWl0ZSBsb2dpY2FsOiB0aGUgY2FjaGUNCj4gY29udGFpbnMgc3RhbGUgbG9va3Vw
IGluZm9ybWF0aW9uIGFuZCBoZW5jZSBvcGVuIGZpbmRzIHRoZSBmaWxlDQo+IG5vbi1leGlzdGVu
dC4NCg0KVGhhbmsgeW91IGZvciBleHBsYWluaW5nIHRoZSB1c2Ugb2YgRVNUQUxFIGhlcmUuICBJ
dCBkZWZpbml0ZWx5IGRvZXMNCnJlc29sdmUgbXkgT19DUkVBVCB3aXRob3V0IE9fRVhDTCBpc3N1
ZSBpbiBhIGJldHRlciB3YXkuICBJIHdvdWxkDQphZ3JlZSB0aGF0IHRoaXMgaXMgbm90IHdlbGwg
ZG9jdW1lbnRlZCwgYXMgb3RoZXIgdGhhbiB0aGUga2VybmVsDQpzb3VyY2UgaXRzZWxmIHRoZSBv
bmx5IHJlZmVyZW5jZSBJIGNhbiBmaW5kIHRvIHRoaXMgaXMgaW4NCkRvY3VtZW50YXRpb24vZmls
ZXN5c3RlbXMvcGF0aC1sb29rdXAucnN0ICh3aGljaCBJIGFkbWl0IEkgaGFkIG5vdA0KcmVhZCBw
cmlvciB0byB0aGlzKS4NCg0KRG8geW91IGhhdmUgYW55IHJlY29tbWVuZGF0aW9uIG9uIHRoZSBw
b3J0aW9uIG9mIG15IHBhdGNoIHJlbGF0aW5nIHRvDQpuZWdhdGl2ZSBkaXJlY3RvcnkgZW50cmll
cz8gIFRoaXMgaXMgYW5vdGhlciBhcmVhIHdoZXJlIGN1cnJlbnRseSB3ZQ0KZG9uJ3Qgc2VlbSB0
byBiZSBhYmxlIHRvIGdldCBwcmVjaXNlbHkgdGhlIHNhbWUgYmVoYXZpb3IgdW5kZXIgRlVTRSBh
cw0KdW5kZXIgTkZTLiAgU3BlY2lmaWNhbGx5LCBhIGZpbGUgb3BlbiB1bmRlciBORlMgd2hlbiB0
aGVyZSBpcyBhDQpuZWdhdGl2ZSBkaXJlY3RvcnkgZW50cnkgaW4gdGhlIGtlcm5lbCdzIGNhY2hl
IGFsd2F5cyBzZWVtcyB0byByZXN1bHQNCmluIGEgcmUtdmFsaWRhdGluZyBHRVRBVFRSIFJQQyB0
byB0aGUgTkZTIHNlcnZlciAod2hpY2gsIGlmIHRoZSBmaWxlDQpoYXMgYmVlbiByZWNlbnRseSBj
cmVhdGVkLCBhbGxvd3MgdGhlIGNsaWVudCB0byBiZWNvbWUgYXdhcmUgb2YgaXRzDQpleGlzdGVu
Y2UpLiAgSXMgdGhlcmUgYSBiZXR0ZXIgd2F5IHdlIGNhbiBhY2hpZXZlIHRoaXMgd2l0aCBGVVNF
IHRoYW4NCnRoZSBjaGFuZ2UgaW4gdGhlIG90aGVyIHBvcnRpb24gb2YgbXkgcGF0Y2ggKGZvcmNp
bmcgYSBsb29rdXAgY2FsbCBvbg0KYW55IG9wZW4gd2hlbiB0aGVyZSBpcyBhIG5lZ2F0aXZlIGRp
cmVjdG9yeSBlbnRyeSBmb3IgdGhlIHRhcmdldCBvZg0KdGhlIG9wZW4pPw0KDQpUbyBhZ2FpbiBi
ZSBzcGVjaWZpYywgdGhlIHNlcXVlbmNlIG9mIGV2ZW50cyB0aGF0IEknbSB0cnlpbmcgdG8gZ2V0
IHRvDQp3b3JrIGRpZmZlcmVudGx5IGlzOg0KDQoxLiBBIGxvb2t1cCBvY2N1cnMgb24gaG9zdCBY
IGZvciBuYW1lIHdoaWNoIGRvZXMgbm90IGV4aXN0LCBhbmQgb3VyDQogICBGVVNFIGRhZW1vbidz
IHJlc3BvbnNlIGNhdXNlcyB0aGUga2VybmVsIHRvIGNhY2hlIGEgbmVnYXRpdmUNCiAgIGRpcmVj
dG9yeSBlbnRyeS4gIChJIGtub3cgdGhhdCB3ZSBjYW4gZGlzYWJsZSBrZXJuZWwtbGV2ZWwgY2Fj
aGluZw0KICAgb2YgbmVnYXRpdmUgbG9va3VwIHJlc3VsdHMsIGJ1dCB3ZSB3b3VsZCByYXRoZXIg
bm90IGRvIHNvIGZvcg0KICAgcGVyZm9ybWFuY2UuKQ0KDQoyLiBUaGUgbmFtZSBpcyBjcmVhdGVk
IGFzIGEgZmlsZSB0aHJvdWdoIG91ciB0aHJvdWdoIG91ciBGVVNFDQogICBkaXN0cmlidXRlZCBm
aWxlc3lzdGVtIG9uIGhvc3QgWS4NCg0KMy4gQW4gb3BlbigyKSBjYWxsIGZvciB0aGUgcmVjZW50
bHkgY3JlYXRlZCBmaWxlIG9jY3VycyBvbiBob3N0IFguDQogICBCZWNhdXNlIHRoZSBrZXJuZWwg
aGFzIGEgY2FjaGVkIG5lZ2F0aXZlIGRlbnRyeSBmb3IgdGhlIGZpbGUgKHdoaWNoDQogICBub3cg
ZXhpc3RzKSwgdGhlIG9wZW4oMikgY2FsbCBmYWlscyB3aXRoIEVOT0VOVCB3aXRob3V0IGFueSBG
VVNFDQogICByZXF1ZXN0cy4NCg0KVGhpcyBjb21lcyB1cCBpbiB0aGUgY29udGV4dCBvZiBhIGRp
c3RyaWJ1dGVkIGJ1aWxkIHN5c3RlbSB3aGVyZSB0aGUNCndvcmsgb2YgYnVpbGRpbmcgYW4gaW50
ZXJtZWRpYXRlIGZpbGUgbWF5IGJlIGRpc3BhdGNoZWQgdG8gYSByZW1vdGUNCmhvc3QuICBVbmRl
ciBORlMsIHRoZSBvcGVuKDIpIGNvbnN1bHRzIHRoZSBORlMgc2VydmVyIGFuZCBkaXNjb3ZlcnMN
CnRoYXQgdGhlIG5hbWUgbm93IGV4aXN0cy4NCg0KLS1LZW4gU2NoYWxrDQoNCg==
