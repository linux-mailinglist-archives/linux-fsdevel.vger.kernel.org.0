Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6611531C20D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 19:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBOS6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 13:58:36 -0500
Received: from mail-dm6nam08on2124.outbound.protection.outlook.com ([40.107.102.124]:8032
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231132AbhBOS6W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:58:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXGb9J/Atn2w6O48YlPGK0xqxOycPlcBloH22I/Gml6pcQQeeg3ZdOEoVwOO4u3EWyVP2EytbgnvMlJYQZmoyW7ZCSolQXe7n82jKdb2MtfrNEMvrSlS3UPLDKhp6vDeT9n+fVpncfD9T9fPFzv2v2zqe/ElCmvITpAr3m7WksyQ65fs6ZdcoJBqL01pTxtG9ZXG5TADd7pENYy5Spg1scyTnX/0ZXYOYJU5ZnPJ1oUM67j07riRKQQ3iquJybzjv43eEXsKHDWD7JxsAHKOJxKCDb7sci8PHxEXmGFZ9UfdHD0NtvVt3YZI89xIh05lqEDBKudbGeTRgfPQbiCxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLgMI0PLKjR4YlOaD1uhb7CxZN0V+HYH/tp/gU2ZNU4=;
 b=RVfTzdkoVHX7dGasVIbsEfyRAHMaVMTeX+6zjMr9DCfJfoC2clH13MtyGJXE13ZcQYfQ4UoGDGOC831Ux3Ck9zN3JHAiyGLqEXh10LsooYP4sO/8ljwhj5/EsfXWf6YFNRj9+S/8F3nvE/F331mhWMdS33bIdSBFsw6HabgU33UpqJcp0bJHTiWutZzS1UtOQ6AjpSoAcShFzWkDp9J0kqCBovxHR1EBtDPO+a539Vx/XYIK5yiXEtCbF3C8c2mXjWwjNLnay7I81JAJ1pfANSKz0Qp1+fsh5IZJwgfD4IJ/09lXQ5UKs+Ue54a1AvZGu3HLnNy6ri+5fnib/2lnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLgMI0PLKjR4YlOaD1uhb7CxZN0V+HYH/tp/gU2ZNU4=;
 b=cd040NVwytqo5XkpRAfkloGqTaV8d5aS5VemS2PagnEQwsy23yqut8L/1Mop2C7N6sh+FZkQkkQaWbL+tSgM7kKgAbm+E2YICSsM9QWqHsCCZGZ9yGXcc7zGHAvpDcLTphQbCzucIh7Eq5TiY3QnJ9l1383PiR327YzpEd7u0xs=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3733.namprd13.prod.outlook.com (2603:10b6:610:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Mon, 15 Feb
 2021 18:57:24 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3868.025; Mon, 15 Feb 2021
 18:57:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "amir73il@gmail.com" <amir73il@gmail.com>
CC:     "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "iant@google.com" <iant@google.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "lhenriques@suse.de" <lhenriques@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "llozano@chromium.org" <llozano@chromium.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Thread-Topic: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Thread-Index: AQHXA7EmiAMwHAQV80CDyBR44E7wi6pZaZuAgAAFIQCAAAi6AIAAGeyA
Date:   Mon, 15 Feb 2021 18:57:24 +0000
Message-ID: <92d27397479984b95883197d90318ee76995b42e.camel@hammerspace.com>
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
         <20210215154317.8590-1-lhenriques@suse.de>
         <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
         <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
         <CAOQ4uxgPtqG6eTi2AnAV4jTAaNDbeez+Xi2858mz1KLGMFntfg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgPtqG6eTi2AnAV4jTAaNDbeez+Xi2858mz1KLGMFntfg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6b11cb2-4dd4-44db-c51c-08d8d1e38831
x-ms-traffictypediagnostic: CH2PR13MB3733:
x-microsoft-antispam-prvs: <CH2PR13MB3733E6EA5A7CB7C22ABD8DA5B8889@CH2PR13MB3733.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:117;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iTiHicE3l8Xj1JRN0GX/FFVDOYOP/BdC04eOrraw1hHM8Apl8vpNj7IaIrd6NKJMyem0qgmbsW4RGADre1g/C12QcbzBlCLEVAGGbRjcVB3I0uQfEwpXu0a84X0PeaeVej8v4gdr9qGr71aQ/ztFbSkl8ZnV7mtjAsoaZZ7nYmRlmxBTt6PBOBrgc5vZK+wUrGtMWQZT382Ep52hQpEgr0Bx2C7BvNj1JKlEcpyevOm3+IwkZDnI7DeNvEAYdsUBu0KGEAuZo+IjUWGAb/ia8d+oHeVBBXdpVFml31zH65OlptWC0purDJDyDGIX/xOuhYuZaLevNRHfS096KTUFvrTkWr7GrEP8UC9DFsnHVsEfm32F8J/FJ++e74lZE3+6nk445r0jDXqoT/fJVlMLXXmyG3jA425qKVfumAxwDCgDf3sBKzGDIMMenAdyDTr35UaofUToV3Uh+k2z/D53XkfpZkHnJTmzFSReYdzJD1R5dPzI9+gexF4hXxNG/FeAhX4xzkS7oi2X/A7+FiLXLJi7/eU70tXeQ99n1GMwfpsYajDXy4OLgrLcr1ztbyfvCg09/dyijTavKWs5mO0MKcaXPHmXJV+tN3IzKZjQktc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39830400003)(136003)(376002)(71200400001)(8676002)(8936002)(54906003)(316002)(76116006)(64756008)(66446008)(66946007)(4326008)(6916009)(966005)(36756003)(26005)(5660300002)(66556008)(66476007)(7416002)(478600001)(186003)(83380400001)(2906002)(2616005)(6486002)(6512007)(86362001)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ckJKUGVqT2xlVTc1K1NMb3lNcGcvc0JCbmU4NW01emlYb21kQldPMDhJL0Nj?=
 =?utf-8?B?TXVyNzhheUV3MzE0L3g4Qmp0QlpFZmFxUkJZaU8zVThUaVBYSFBPcWxvaHUw?=
 =?utf-8?B?cWpVNzNiZXFMNWUzZFlEZVJ1UjdrYlBhNEVLVW9MMTlGYmtZVXFzcDRmVjZY?=
 =?utf-8?B?c2lEMkh0R1dJSzIxdllKdS8rckplSWZPaVl5SWtyakNPWFBjQlY4ZTkwTmNm?=
 =?utf-8?B?UkhvMmFiZEdtTVM4SWtXbnlsRkx2K1JnQmlRaGtDcjV6cGIxb20zaXZjWlhp?=
 =?utf-8?B?cStsaEN4UHNld0xQNS9pcjFUZjFUYjB5cW5PdlMzSHB5QnpvbDNLQ0JhWXAr?=
 =?utf-8?B?d3F6MmNubnFxOENPVnAzb29COHp0ejdHaUJldFhBdmNqelNKbXI0Z1pLcjJP?=
 =?utf-8?B?dlBpcFErcDVRdzd1WXUvSHFtcjNBSGNLcHEwWTBwUEVxd1UvZnF0eXNRVXQ5?=
 =?utf-8?B?Q3hJWDNVVU02U3hkVmx2QnhRNitoWU1UZXdNeTkrWWNJeHJ3UmFxR01vaWUr?=
 =?utf-8?B?WEVta2ZBaG50MEdCanVuY1V5dk50aTl2VWxKYVhVTTFveEhZL0RFNCtCdENm?=
 =?utf-8?B?VGxKd1Q5R1F5L3hRelF0VHI1Rlh3alE2YmJFcFo5TjY4VSt6MzlzaVowbUh4?=
 =?utf-8?B?QUZxbVJUUFQyV0FkV0NTb2c5TnlYQzdoaEF0V0ZBd2Z2QWxINGJkaWY5ZTJ2?=
 =?utf-8?B?YW43dE9wUVd1NkJRak5FZ29Qam54MW9PMy9jL1JyY0JnWXgxRy9ubEhEZGt6?=
 =?utf-8?B?U3ZIckhaMVdWVWcveUxlSHBuY255NzArdENHa3dUZkc4VFpWNjluRlBBL0Ni?=
 =?utf-8?B?U1ZsUDZPaHB5VGtqWWRSNzNTdm41WHViWEUvVjBxV1VIdDdVS25pZ2cwT2lS?=
 =?utf-8?B?VnZLVDVFc0h2YjZLaEV5c0p1S1luYXFKeFZFMENEeXlHTWdnWHJpeU4xc2RL?=
 =?utf-8?B?MFB3bWdtdUZNMGRvRk5qclJsUFFjNTlDUmI2b0ZvNUhwVDRiTjNIVTl5ZkVp?=
 =?utf-8?B?ZjVCVjkvMDlENE40d2NaUjMzSk9SWEJuTjZrNEZMbitjVXprK2hJcGY5eXg4?=
 =?utf-8?B?a21MN3lhYyswTXBHci9ZQU9ZM0tscTZsK2lZZzQwU081Z09BWnhmMnNnaVR5?=
 =?utf-8?B?MnNzemQyZEMybk12SC9NR2FJS1N2d3JIVHQrcUJVa1puSmpIcDlYUFg3Mi8x?=
 =?utf-8?B?SXVxNGNITU9ETEVoK2dvcWtDOXFwU1p1QlpUZXdXTnVMMVNaTHM5QkV2a2JK?=
 =?utf-8?B?SHE2K3hQWVNzcjZOc3d6WUJ3SWhyLzZTYkRFSEExVWF2UVVEWnpNd2pTR0Jo?=
 =?utf-8?B?a1lua3Zibmw1UzNtR1E1QU1IeTFsL1pqTFFHa3JhYkhPZFhNbWZ4TU94REwy?=
 =?utf-8?B?SnpnNUdiTzhUMWRlcThjYXpFNGh4RytJTk9RM2cwSmc2cyt2dHpYYndwQWNU?=
 =?utf-8?B?dWRISTQ4VGh0ZFc2d3RUMUs4UDFIbkgzYkloZVFWT3psWVBrZld5Y01yRDJw?=
 =?utf-8?B?eHhGbzlNbW9XYWgzTEVESWFaUUt5U3ZlL2dyZ2trUVVuZGZ0dmtVU0MvRUcv?=
 =?utf-8?B?TFhFaER5THVCb2VkWi92R25pR2NqQk5lMUVEb0Z4bkVrZmd6REwwOHZBZ2NC?=
 =?utf-8?B?QWdvOVJkbkhNcUt1aTlPQmVuOWZ0VE1YUngwWDJMTFI5SFZCdHpyR3dHNTVZ?=
 =?utf-8?B?Rk5hZFA1TVZOSkxRUW5ITFJVZTBnOU5FSGFBV2MzenZ1cEFpOElWWm9jQmtv?=
 =?utf-8?Q?ofy4EJZOMakFfeR7Y8rx3y5CHsgaos7H06I5N+F?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6F6D2FD32059D4DBF71B9DA660207FE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b11cb2-4dd4-44db-c51c-08d8d1e38831
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 18:57:24.4410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuSWkBCzTs1AFQ4R4b29/zP2548fDCwuWy90QmWOkmKtapCxJ6YW8FkyF/FHxOhscYyNowo8IFvmx99ZL3xW7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3733
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTE1IGF0IDE5OjI0ICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gT24gTW9uLCBGZWIgMTUsIDIwMjEgYXQgNjo1MyBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0KPiB0
cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9uLCAyMDIxLTAy
LTE1IGF0IDE4OjM0ICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4gPiA+IE9uIE1vbiwg
RmViIDE1LCAyMDIxIGF0IDU6NDIgUE0gTHVpcyBIZW5yaXF1ZXMgPA0KPiA+ID4gbGhlbnJpcXVl
c0BzdXNlLmRlPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBOaWNvbGFzIEJvaWNo
YXQgcmVwb3J0ZWQgYW4gaXNzdWUgd2hlbiB0cnlpbmcgdG8gdXNlIHRoZQ0KPiA+ID4gPiBjb3B5
X2ZpbGVfcmFuZ2UNCj4gPiA+ID4gc3lzY2FsbCBvbiBhIHRyYWNlZnMgZmlsZS7CoCBJdCBmYWls
ZWQgc2lsZW50bHkgYmVjYXVzZSB0aGUgZmlsZQ0KPiA+ID4gPiBjb250ZW50IGlzDQo+ID4gPiA+
IGdlbmVyYXRlZCBvbi10aGUtZmx5IChyZXBvcnRpbmcgYSBzaXplIG9mIHplcm8pIGFuZA0KPiA+
ID4gPiBjb3B5X2ZpbGVfcmFuZ2UNCj4gPiA+ID4gbmVlZHMNCj4gPiA+ID4gdG8ga25vdyBpbiBh
ZHZhbmNlIGhvdyBtdWNoIGRhdGEgaXMgcHJlc2VudC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMg
Y29tbWl0IHJlc3RvcmVzIHRoZSBjcm9zcy1mcyByZXN0cmljdGlvbnMgdGhhdCBleGlzdGVkDQo+
ID4gPiA+IHByaW9yDQo+ID4gPiA+IHRvDQo+ID4gPiA+IDVkYWUyMjJhNWZmMCAoInZmczogYWxs
b3cgY29weV9maWxlX3JhbmdlIHRvIGNvcHkgYWNyb3NzDQo+ID4gPiA+IGRldmljZXMiKQ0KPiA+
ID4gPiBhbmQNCj4gPiA+ID4gcmVtb3ZlcyBnZW5lcmljX2NvcHlfZmlsZV9yYW5nZSgpIGNhbGxz
IGZyb20gY2VwaCwgY2lmcywgZnVzZSwNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IG5mcy4NCj4gPiA+
ID4gDQo+ID4gPiA+IEZpeGVzOiA1ZGFlMjIyYTVmZjAgKCJ2ZnM6IGFsbG93IGNvcHlfZmlsZV9y
YW5nZSB0byBjb3B5IGFjcm9zcw0KPiA+ID4gPiBkZXZpY2VzIikNCj4gPiA+ID4gTGluazoNCj4g
PiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZlbC8yMDIxMDIxMjA0NDQw
NS40MTIwNjE5LTEtZHJpbmtjYXRAY2hyb21pdW0ub3JnLw0KPiA+ID4gPiBDYzogTmljb2xhcyBC
b2ljaGF0IDxkcmlua2NhdEBjaHJvbWl1bS5vcmc+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEx1
aXMgSGVucmlxdWVzIDxsaGVucmlxdWVzQHN1c2UuZGU+DQo+ID4gPiANCj4gPiA+IENvZGUgbG9v
a3Mgb2suDQo+ID4gPiBZb3UgbWF5IGFkZDoNCj4gPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6IEFt
aXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+DQo+ID4gPiANCj4gPiA+IEkgYWdyZWUg
d2l0aCBUcm9uZCB0aGF0IHRoZSBmaXJzdCBwYXJhZ3JhcGggb2YgdGhlIGNvbW1pdCBtZXNzYWdl
DQo+ID4gPiBjb3VsZA0KPiA+ID4gYmUgaW1wcm92ZWQuDQo+ID4gPiBUaGUgcHVycG9zZSBvZiB0
aGlzIGNoYW5nZSBpcyB0byBmaXggdGhlIGNoYW5nZSBvZiBiZWhhdmlvciB0aGF0DQo+ID4gPiBj
YXVzZWQgdGhlIHJlZ3Jlc3Npb24uDQo+ID4gPiANCj4gPiA+IEJlZm9yZSB2NS4zLCBiZWhhdmlv
ciB3YXMgLUVYREVWIGFuZCB1c2Vyc3BhY2UgY291bGQgZmFsbGJhY2sgdG8NCj4gPiA+IHJlYWQu
DQo+ID4gPiBBZnRlciB2NS4zLCBiZWhhdmlvciBpcyB6ZXJvIHNpemUgY29weS4NCj4gPiA+IA0K
PiA+ID4gSXQgZG9lcyBub3QgbWF0dGVyIHNvIG11Y2ggd2hhdCBtYWtlcyBzZW5zZSBmb3IgQ0ZS
IHRvIGRvIGluIHRoaXMNCj4gPiA+IGNhc2UgKGdlbmVyaWMgY3Jvc3MtZnMgY29weSkuwqAgV2hh
dCBtYXR0ZXJzIGlzIHRoYXQgbm9ib2R5IGFza2VkDQo+ID4gPiBmb3INCj4gPiA+IHRoaXMgY2hh
bmdlIGFuZCB0aGF0IGl0IGNhdXNlZCBwcm9ibGVtcy4NCj4gPiA+IA0KPiA+IA0KPiA+IE5vLiBJ
J20gc2F5aW5nIHRoYXQgdGhpcyBwYXRjaCBzaG91bGQgYmUgTkFDS2VkIHVubGVzcyB0aGVyZSBp
cyBhDQo+ID4gcmVhbA0KPiA+IGV4cGxhbmF0aW9uIGZvciB3aHkgd2UgZ2l2ZSBjcmFwIGFib3V0
IHRoaXMgdHJhY2VmcyBjb3JuZXIgY2FzZSBhbmQNCj4gPiB3aHkNCj4gPiBpdCBjYW4ndCBiZSBm
aXhlZC4NCj4gPiANCj4gPiBUaGVyZSBhcmUgcGxlbnR5IG9mIHJlYXNvbnMgd2h5IGNvcHkgb2Zm
bG9hZCBhY3Jvc3MgZmlsZXN5c3RlbXMNCj4gPiBtYWtlcw0KPiA+IHNlbnNlLCBhbmQgcGFydGlj
dWxhcmx5IHdoZW4geW91J3JlIGRvaW5nIE5BUy4gQ2xvbmUganVzdCBkb2Vzbid0DQo+ID4gY3V0
DQo+ID4gaXQgd2hlbiBpdCBjb21lcyB0byBkaXNhc3RlciByZWNvdmVyeSAod2hlcmVhcyBiYWNr
dXAgdG8gYQ0KPiA+IGRpZmZlcmVudA0KPiA+IHN0b3JhZ2UgdW5pdCBkb2VzKS4gSWYgdGhlIGNs
aWVudCBoYXMgdG8gZG8gdGhlIGNvcHksIHRoZW4geW91J3JlDQo+ID4gZWZmZWN0aXZlbHkgZG91
YmxpbmcgdGhlIGxvYWQgb24gdGhlIHNlcnZlciwgYW5kIHlvdSdyZSBhZGRpbmcNCj4gPiBwb3Rl
bnRpYWxseSB1bm5lY2Vzc2FyeSBuZXR3b3JrIHRyYWZmaWMgKG9yIGF0IHRoZSB2ZXJ5IGxlYXN0
IHlvdQ0KPiA+IGFyZQ0KPiA+IGRvdWJsaW5nIHRoYXQgdHJhZmZpYykuDQo+ID4gDQo+IA0KPiBJ
IGRvbid0IHVuZGVyc3RhbmQgdGhlIHVzZSBjYXNlIHlvdSBhcmUgZGVzY3JpYmluZy4NCj4gDQo+
IFdoaWNoIGZpbGVzeXN0ZW0gdHlwZXMgYXJlIHlvdSB0YWxraW5nIGFib3V0IGZvciBzb3VyY2Ug
YW5kIHRhcmdldA0KPiBvZiBjb3B5X2ZpbGVfcmFuZ2UoKT8NCj4gDQo+IFRvIGJlIGNsZWFyLCB0
aGUgb3JpZ2luYWwgY2hhbmdlIHdhcyBkb25lIHRvIHN1cHBvcnQgTkZTL0NJRlMgc2VydmVyLQ0K
PiBzaWRlDQo+IGNvcHkgYW5kIHRob3NlIHNob3VsZCBub3QgYmUgYWZmZWN0ZWQgYnkgdGhpcyBj
aGFuZ2UuDQo+IA0KDQpUaGF0IGlzIGluY29ycmVjdDogDQoNCnNzaXplX3QgbmZzZF9jb3B5X2Zp
bGVfcmFuZ2Uoc3RydWN0IGZpbGUgKnNyYywgdTY0IHNyY19wb3MsIHN0cnVjdCBmaWxlDQoqZHN0
LA0KIHU2NCBkc3RfcG9zLCB1NjQgY291bnQpDQp7DQoNCiAvKg0KICogTGltaXQgY29weSB0byA0
TUIgdG8gcHJldmVudCBpbmRlZmluaXRlbHkgYmxvY2tpbmcgYW4gbmZzZA0KICogdGhyZWFkIGFu
ZCBjbGllbnQgcnBjIHNsb3QuIFRoZSBjaG9pY2Ugb2YgNE1CIGlzIHNvbWV3aGF0DQogKiBhcmJp
dHJhcnkuIFdlIG1pZ2h0IGluc3RlYWQgYmFzZSB0aGlzIG9uIHIvd3NpemUsIG9yIG1ha2UgaXQN
CiAqIHR1bmFibGUsIG9yIHVzZSBhIHRpbWUgaW5zdGVhZCBvZiBhIGJ5dGUgbGltaXQsIG9yIGlt
cGxlbWVudA0KICogYXN5bmNocm9ub3VzIGNvcHkuIEluIHRoZW9yeSBhIGNsaWVudCBjb3VsZCBh
bHNvIHJlY29nbml6ZSBhDQogKiBsaW1pdCBsaWtlIHRoaXMgYW5kIHBpcGVsaW5lIG11bHRpcGxl
IENPUFkgcmVxdWVzdHMuDQogKi8NCiBjb3VudCA9IG1pbl90KHU2NCwgY291bnQsIDEgPDwgMjIp
Ow0KIHJldHVybiB2ZnNfY29weV9maWxlX3JhbmdlKHNyYywgc3JjX3BvcywgZHN0LCBkc3RfcG9z
LCBjb3VudCwgMCk7DQp9DQoNCllvdSBhcmUgbm93IGV4cGxpY2l0bHkgY2hhbmdpbmcgdGhlIGJl
aGF2aW91ciBvZiBrbmZzZCB3aGVuIHRoZSBzb3VyY2UNCmFuZCBkZXN0aW5hdGlvbiBmaWxlc3lz
dGVtIGRpZmZlci4NCg0KRm9yIG9uZSB0aGluZywgeW91IGFyZSBkaXNhbGxvd2luZyB0aGUgTkZT
djQuMiBjb3B5IG9mZmxvYWQgdXNlIGNhc2Ugb2YNCmNvcHlpbmcgZnJvbSBhIGxvY2FsIGZpbGVz
eXN0ZW0gdG8gYSByZW1vdGUgTkZTIHNlcnZlci4gSG93ZXZlciB5b3UgYXJlDQphbHNvIGRpc2Fs
bG93aW5nIHRoZSBjb3B5IGZyb20sIHNheSwgYW4gWEZTIGZvcm1hdHRlZCBwYXJ0aXRpb24gdG8g
YW4NCmV4dDQgcGFydGl0aW9uLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
