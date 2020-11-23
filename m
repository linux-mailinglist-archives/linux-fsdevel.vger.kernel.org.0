Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DD92C1754
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 22:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgKWVH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 16:07:28 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3616 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgKWVH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:07:28 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc24900001>; Mon, 23 Nov 2020 13:07:28 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 21:07:27 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 23 Nov 2020 21:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nC2HoadHYsubZ9jmvkrqtIDNlaYmC+5Kf8uJdO1VodoGmsH72USpBqyYdPFNStW6qRNozb1RXzSA8+wrzx0KSV2XhBFIngDQJLH6JEn2Cgu3caJsUEHGXbD82oet7/ZDc0xjBGyFM3gibt0/HzcITnipXKHsG224b8ylyIzeYEOKBo0zl0FLqFjm7rnP2ALMx5AQrTrNsPcJ5VXYp0MTjzSo8hHShm4shSvbTQMxfJDAl3d9A4sjbbanqd3Q1YS1Cnsv9q5nyDspg9UXCttOOYgSV1O2qN+k+vWdR1ZuKE/F+jYhyWWFFSOtqMW3G8TLHgLtlPpA1iakCAKUwuufAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrYC6pzG9M/rs0W6uAm17PTWJpf9SsIeChT0rdF58Hc=;
 b=oWUYiXECEMqaRpTB3hLesDiBVnYNFz0MR7XXLAQioiVTZ6PgTwpRmE5Rs1PTbOvn2QsMPBA7auRiaAtWznVC5JjnsGS2TAoMQBvgXrMatUuajMGRSPYIfYbFiRoEFbCMT13aOLwvXxvdcvGtDW4ScdspI2P3uF4eH/IKYw+cknY1RuYOxMtIdtyql19VVfkY1U3v/LTeYPpNpv39A+xXuX5rWV707qS3iKreOIjoKFOTH7kFIeCayLRxU2DGpKGYwV9XcqGmYqhmAL2bDSDOC3I51AbhcZB3FxR0v61haBRf0D1JDk2nbVUTmrfvjXEf+4fq0G8rKufAltankh4jew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3385.namprd12.prod.outlook.com (2603:10b6:5:39::16) by
 DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.25; Mon, 23 Nov 2020 21:07:23 +0000
Received: from DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::ddfe:5f48:eeff:1eef]) by DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::ddfe:5f48:eeff:1eef%3]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 21:07:22 +0000
From:   Ken Schalk <kschalk@nvidia.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [fuse-devel] Cross-host entry caching and file open/create
Thread-Topic: [fuse-devel] Cross-host entry caching and file open/create
Thread-Index: AdZ2cgXArydRfBZsQFmRYJ9twGDRZwBYJUoAAQSxwqAAZXXxAAapP22ACmTT0CA=
Date:   Mon, 23 Nov 2020 21:07:22 +0000
Message-ID: <DM6PR12MB33851BCA35DC6EB3158C84B5DDFC0@DM6PR12MB3385.namprd12.prod.outlook.com>
References: <DM6PR12MB33857B8B2E49DF0DD0C4F950DD5D0@DM6PR12MB3385.namprd12.prod.outlook.com>
 <CAJfpegu6-hKCdEiZxb9KrZUrMT_UozjaWC5qY00xwqqopb=1SA@mail.gmail.com>
 <DM6PR12MB33856CB9CC50BE5D7E9B436DDD540@DM6PR12MB3385.namprd12.prod.outlook.com>
 <DM6PR12MB3385C2556A59B3F33FE8B980DD520@DM6PR12MB3385.namprd12.prod.outlook.com>
 <CAJfpegv5EckmJ_PCqHc2N3_jHaXfinMwvDNSttYNXcan1wr1fQ@mail.gmail.com>
In-Reply-To: <CAJfpegv5EckmJ_PCqHc2N3_jHaXfinMwvDNSttYNXcan1wr1fQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kschalk@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-11-23T21:07:21.0976112Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=295e8741-2de8-4f2f-a541-78146d6ad91f;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: szeredi.hu; dkim=none (message not signed)
 header.d=none;szeredi.hu; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [12.46.106.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a7e2466-973c-47db-c5ae-08d88ff3c5b3
x-ms-traffictypediagnostic: DM6PR12MB4044:
x-microsoft-antispam-prvs: <DM6PR12MB40448DD5D58E55DF2F9C3443DDFC0@DM6PR12MB4044.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66cXK1kp1HiKKasJs4/N6lAYjszaPe15BqNk6YPY1lakrRCj+/R6CqZqIS79OV3qyXJqSh428eL5fyFVn11Be4/BJkqo/Y7cWge6TymRbf9A6VT2EKnaeKAv8XQAUw6LLyKECFkOyn3zEVEwpix/jENA8o9B2UIUo80bi26ycUcIkMq899yZ25OcJ3Jztaez6uyXlSunV8t6ZVTrn9oy2WkC21yA9F4EI8Mz7H5+Zh3kQZ880WOROozuiEfH4mef4opZSUu+SFuNCXbgazLKtIMNHYkkn3NsKA4q08hItxPy1Iclfc/6aPI6PxBa/ZQuCPL0JMwu67XsZJRYnlMgsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3385.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(76116006)(86362001)(66476007)(66556008)(6916009)(7696005)(66446008)(4326008)(53546011)(6506007)(66946007)(478600001)(8936002)(71200400001)(52536014)(8676002)(64756008)(186003)(26005)(54906003)(316002)(2906002)(9686003)(33656002)(83380400001)(5660300002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: S84H5axy+5GuEH0v93V//GBc/JlswDniRbGMAh7B1pPoUvQSS8+d/aLBY2htQ1daTMNYvzkTHbTTS83bdbKiZ1pFTCXXncqduwhFf0bKQu/94g47M6cvjKeWGVMw9BoTCrTnKDKFFbUFgj21Ugiq4QeKhz1zvfcheH+wdkelTYSc0GhfrlUp+SycKmiJ2frTVj3EJxmKRYZunCEl4GmQUzixwWDWQVPWHpkpMqb+0cAeTLWxST1Kros/+Y2cYhGmCNbASyAXBXYDQHUD2mnto6kF/03ieKAV1w8zgFpE0l+VnaVpPCuoUTbeiz8NsD65yaxJlrMyIpH5UpVfonLtdq6SjI9/6l1+jnOphDZ6hvJJ/zw1/2K2mb0mOJMjnXiv7oDmjpbY6vbMkzB73gOrnpqm5yAYepXMagsOCxMzRObIg15NGDCYifauLUxGMU4cEeUOmtNbBIqmLyYJ/hTaTybN8/kA9h7TqzoZ7hQQbi07FdBo226Iom/u3kAcn+QoXhc6gAUx27fRyovMlreiGIq44j7X7PRH+xYw+i4X/MeHxxpQImySlwGuUbcwdCA8/dOjj7SxuLBIhVgTuqJx6OmNHB28OlcWSFWkC2J8TpAzbqwGHfd9NlPhofobG6qmrpjL1sHI5ut9XJidD650UCnsJ+Sdn0MG6/2RD7vEH3vQQwKuG/a1EgB5nRkWMfpBVRbJ//iJ/LpiN9jqqwERySiqzgDvlQa2gYnOzZqnH3zJDsyuAbzEXd9vuBBAGCIbN9njswqKDM+QpXH2KwiaYcU3Ms4ETXUofo/o19jPGyyDAHuNAc7nZFf9Sh6gnaZgKC4VMxohJ+JUW4Whu6kGrEZtDSxv9g+SJdfCFySwq5+vcHj6V141CPUI6BQ74xh7lfr6HQv9BsN5QapJKjhELA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3385.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7e2466-973c-47db-c5ae-08d88ff3c5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 21:07:22.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItmpHw09QRw4yTadAbPr/aPS3GLpjvVwyvIy1Iq0WqNNNXSdcn/HKSfo3J5sB8RHZ0lRtnTrRU39AucN2vUrbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606165648; bh=DrYC6pzG9M/rs0W6uAm17PTWJpf9SsIeChT0rdF58Hc=;
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
        b=I4MoZagTS2llJpKQgM6vutV82HKlL18HXZEqTf7PsXAAXPspizeTGqmBgqGKWnq3c
         oC67pEoESh3uLa7bjSgdPmYiO+IpwqooU+tLdLHs8G0z6IGwweCGxB/LATnATaRO7E
         zW3B4Q/fk7ulM1fR4AHS+P2Kj5ztNJohAkTC1AwKR9TDX0q7WeqxMF6jg4RkSIS8nu
         CQnhChE/1xFAE4pOGeAB11XAOuhPNsdtfMGGJj85Bx0TJzeo0SglreQV/jzA2AeYS/
         T1tIc7tcnMCpaGXj7IFTxfibDmgwlBajkUuh0NJDzn7Xn3RKUVx0iz2VSb8D7URQCO
         T3EppyJXa5zCA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCBPY3QgMSwgMjAyMCBNaWtsb3MgU3plcmVkaSA8bWlrbG9zQHN6ZXJlZGkuaHU+IHdy
b3RlOg0KPiBPbiBGcmksIEF1ZyAyOCwgMjAyMCBhdCAxMTowMSBQTSBLZW4gU2NoYWxrIDxrc2No
YWxrQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+ID4gVGhhbmtzIHZlcnkgbXVjaCBmb3IgeW91ciBo
ZWxwLiAgVGhlIHBhdGNoIHlvdSBwcm92aWRlZCBkb2VzIHNvbHZlIA0KPiA+ID4gdGhlIHByb2Js
ZW0gaW4gdGhlIE9fQ1JFQVR8T19FWENMIGNhc2UgKGJ5IG1ha2luZyBhIGxvb2t1cCBjYWxsIHRv
IA0KPiA+ID4gcmUtdmFsaWRhdGUgdGhlIGVudHJ5IG9mIHRoZSBzaW5jZSBkZWxldGVkIGZpbGUp
LCBidXQgbm90IGluIHRoZSANCj4gPiA+IE9fQ1JFQVQgY2FzZS4gIChJbiB0aGF0IGNhc2UgdGhl
IGtlcm5lbCBzdGlsbCB3aW5kcyB1cCBtYWtpbmcgYSBGVVNFIA0KPiA+ID4gb3BlbiByZXF1ZXN0
IHJhdGhlciB0aGFuIGEgRlVTRSBjcmVhdGUgcmVxdWVzdC4pICBJJ2QgbGlrZSB0byANCj4gPiA+
IHN1Z2dlc3QgdGhlIHNsaWdodGx5IGRpZmZlcmVudCBhdHRhY2hlZCBwYXRjaCBpbnN0ZWFkLCB3
aGljaCANCj4gPiA+IHRyaWdnZXJzIHJlLXZhbGlkYXRpb24gaW4gYm90aCBjYXNlcy4NCg0KPiBX
aGljaCBpcyBhIHByb2JsZW0sIGJlY2F1c2UgdGhhdCBtYWtlcyBPX0NSRUFUIG9uIGV4aXN0aW5n
IGZpbGVzIChhDQo+IGZhaXJseSBjb21tb24gY2FzZSkgYWRkIGEgbmV3IHN5bmNocm9ub3VzIHJl
cXVlc3QsIHBvc3NpYmx5DQo+IHJlc3VsdGluZyBpbiBhIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24u
DQoNCj4gSSBkb24ndCBzZWUgYW4gZWFzeSB3YXkgdGhpcyBjYW4gYmUgZml4ZWQsIGFuZCBJJ20g
bm90IHN1cmUgdGhpcw0KPiBuZWVkcyB0byBiZSBmaXhlZC4NCg0KPiBBcmUgeW91IHNlZWluZyBh
IHJlYWwgaXNzdWUgd2l0aCBqdXN0IE9fQ1JFQVQ/DQoNClllcywgd2UgZGVmaW5pdGVseSBkbyBz
ZWUgaXNzdWVzIHdpdGgganVzdCBPX0NSRUFULiAgVGhlIHNwZWNpZmljDQpzZXF1ZW5jZSB0aGF0
IGludm9sdmVzIE9fQ1JFQVQgd2l0aG91dCBPX0VYQ0wgaXM6DQoNCjEuIEEgZmlsZSBleGlzdHMg
YW5kIGlzIGFjY2Vzc2VkIHRocm91Z2ggb3VyIEZVU0UgZGlzdHJpYnV0ZWQNCiAgIGZpbGVzeXN0
ZW0gb24gaG9zdCBYLiAgVGhlIGtlcm5lbCBvbiBob3N0IFggY2FjaGVzIHRoZSBkaXJlY3RvcnkN
CiAgIGVudHJ5IGZvciB0aGUgZmlsZS4NCg0KMi4gVGhlIGZpbGUgaXMgdW5saW5rZWQgdGhyb3Vn
aCBvdXIgRlVTRSBkaXN0cmlidXRlZCBmaWxlc3lzdGVtIG9uDQogICBob3N0IFkuDQoNCjMuIEFu
IG9wZW4oMikgY2FsbCB3aXRoIE9fQ1JFQVQgZm9yIHRoZSBmaWxlIG9jY3VycyBvbiBob3N0IFgu
DQogICBCZWNhdXNlIHRoZSBrZXJuZWwgaGFzIGEgY2FjaGVkIGRlbnRyeSBmb3IgdGhlIG5vdyBk
ZWxldGVkIGZpbGUsIGl0DQogICBtYWtlcyBhIEZVU0Ugb3BlbiByZXF1ZXN0IHRvIG91ciBmaWxl
c3lzdGVtIChyYXRoZXIgdGhhbiBhIEZVU0UNCiAgIGNyZWF0ZSByZXF1ZXN0KS4NCg0KNC4gT3Vy
IGZpbGVzeXN0ZW0ncyBvcGVuIGhhbmRsZXIgZmluZHMgdGhhdCB0aGUgZmlsZSBkb2VzIG5vdCBl
eGlzdA0KICAgKGJlY2F1c2UgaXQgd2FzIHVubGlua2VkIGluIHN0ZXAgMikgYW5kIHJlcGxpZXMg
dG8gdGhlIG9wZW4gcmVxdWVzdA0KICAgd2l0aCBFTk9FTlQuICAoVGhlIEZVU0Ugb3BlbiBoYW5k
bGVyIGNhbm5vdCB0ZWxsIHRoYXQgT19DUkVBVCB3YXMNCiAgIHNwZWNpZmllZCBpbiB0aGUgZmxh
Z3Mgb2YgdGhlIHN5c2NhbGwgYXMgdGhhdCBiaXQgaXMgbm90IHBhc3NlZA0KICAgdGhyb3VnaCBp
biB0aGUgZmxhZ3MgaW4gdGhlIEZVU0Ugb3BlbiByZXF1ZXN0LCBzbyBpdCBjYW4ndA0KICAgYXV0
b21hdGljYWxseSBoYW5kbGUgdGhpcyBjYXNlIGJ5IGNyZWF0aW5nIHRoZSBmaWxlLikNCg0KNS4g
VGhlIGtlcm5lbCBwYXNzZXMgdGhlIEVOT0VOVCBlcnJvciBjb2RlIG9uIGFzIHRoZSByZXN1bHQg
b2YgdGhlDQogICBvcGVuKDIpIHN5c3RlbSBjYWxsLCBzbyB0aGUgZmlsZSBpcyBub3QgY3JlYXRl
ZCBhbmQgbm90IG9wZW5lZC4NCg0KVG8gbWUgdGhpcyBzZWVtcyBjbGVhcmx5IGluY29ycmVjdCBp
biB0ZXJtcyBvZiBvYnNlcnZhYmxlIGJlaGF2aW9yLg0KVGhlIGZpbGUgZG9lcyBub3QgZXhpc3Qg
YXQgdGhlIHBvaW50IG9mIHRoZSBvcGVuKDIpIHN5c2NhbGwgd2l0aA0KT19DUkVBVCBpbiBzdGVw
IDMgKGFsdGhvdWdoIHRoZSBrZXJuZWwgb24gaG9zdCBYIGhhcyBub3QgYmVjb21lIGF3YXJlDQpv
ZiBpdHMgZGVsZXRpb24pLiAgVGhlIGZpbGUgc2hvdWxkIGJlIGNyZWF0ZWQgYW5kIG9wZW5lZC4g
IEFuIG9wZW4oMikNCnN5c2NhbGwgd2l0aCBPX0NSRUFUIHNob3VsZG4ndCBmYWlsIHdpdGggRU5P
RU5UIGJlY2F1c2UgdGhlIGZpbGUgZG9lcw0Kbm90IGV4aXN0ICh3aGljaCBpcyB3aGF0IGhhcHBl
bnMgaW4gdGhpcyBzaXR1YXRpb24gY3VycmVudGx5KS4NCg0KSSBkb24ndCBzZWUgaG93IHRvIGF2
b2lkIHRoaXMgd2l0aG91dCBzb21lIGtlcm5lbC1sZXZlbCBjaGFuZ2Ugd2l0aA0KYWNjZXB0YWJs
ZSBwZXJmb3JtYW5jZS4gIChXZSBjb3VsZCBtYWtlIHRoZSB1bmxpbmsgb24gaG9zdCBZDQpzeW5j
aHJvbm91c2x5IHBlcmZvcm0gYW4gZW50cnkgaW52YWxpZGF0aW9uIGFjcm9zcyBhbGwgb3RoZXIg
aG9zdHMNCndoZXJlIG91ciBGVVNFIGRhZW1vbiBpcyBydW5uaW5nLCBidXQgdGhhdCB3b3VsZCBi
ZSBhIGh1Z2UgcGVyZm9ybWFuY2UNCnByb2JsZW0gYW5kIGEgc2lnbmlmaWNhbnQgYWRkaXRpb24g
b2YgY29tcGxleGl0eSBpbiBvdXIgRlVTRSBkYWVtb24uKQ0KDQpJIGJlbGlldmUgdGhhdCB0aGVy
ZSBhcmUgYXQgbGVhc3QgdHdvIG90aGVyIHdheXMgdG8gcmVzb2x2ZSB0aGlzDQp3aXRob3V0IGFk
ZGluZyB0aGUgc3luY2hyb25vdXMgbG9va3VwIHJlcXVlc3Qgb24gZXZlcnkgb3BlbiBzeXNjYWxs
DQp3aXRoIE9fQ1JFQVQ6DQoNCi0gUHJlc2VydmUgdGhlIE9fQ1JFQVQgYml0IGluIHRoZSBmbGFn
cyBwYXNzZWQgdGhyb3VnaCBpbiB0aGUgRlVTRQ0KICBvcGVuIHJlcXVlc3QuICAoSSBiZWxpZXZl
IHRoZSBwbGFjZSB3aGVyZSB0aGlzIGJpdCBpcyBtYWtlZCBvdXQgaXMNCiAgaW4gZnVzZV9zZW5k
X29wZW4gaW4gZnMvZnVzZS9maWxlLmMuKSAgVGhhdCB3b3VsZCBhbGxvdyB0aGUgRlVTRQ0KICBv
cGVuIGhhbmRsZXIgdG8ga25vdyB0aGF0IGZpbGUgY3JlYXRpb24gd2FzIHJlcXVlc3RlZCBhbmQg
dG8gcGVyZm9ybQ0KICB0aGUgY3JlYXRpb24gaW4gdGhpcyBjYXNlLiAgKEknbGwgbWVudGlvbiB0
aGF0IHRoaXMgd291bGQgYmUgc2ltaWxhcg0KICB0byBhIGJlaGF2aW9yIHdlJ3ZlIGltcGxlbWVu
dGVkIGluIG91ciBGVVNFIGNyZWF0ZSBoYW5kbGVyIHRvIG9wZW4NCiAgYW4gZXhpc3RpbmcgZmls
ZSB3aGVuIE9fRVhDTCBpcyBub3QgaW4gdGhlIGZsYWdzLCB3aGljaCBhbGxvd3MNCiAgaGFuZGxp
bmcgY2FzZXMgd2hlcmUgYSBmaWxlIHdhcyByZWNlbnRseSBjcmVhdGVkIG9uIGEgcmVtb3RlIGhv
c3QuKQ0KDQotIElmIGEgRlVTRSBvcGVuIGNhbGwgZmFpbHMgd2l0aCBFTk9FTlQgd2hlbiBPX0NS
RUFUIGlzIHVzZWQsIGhhdmUgdGhlDQogIGtlcm5lbCBkcm9wIHRoZSBjYWNoZWQgZGVudHJ5IGFu
ZCB0aGVuIG1ha2UgYSBGVVNFIGNyZWF0ZSByZXF1ZXN0Lg0KDQpUaGFua3MuDQoNCi0tS2VuIFNj
aGFsaw0K
