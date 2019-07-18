Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27556D30D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfGRRs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 13:48:26 -0400
Received: from mail-eopbgr800055.outbound.protection.outlook.com ([40.107.80.55]:23161
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbfGRRsZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:48:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPPxH6gh4mXQqnHWxflqPG/I4aUGr7gfIkvM7sjI40E5itSTgKmYDDYmayEM0LvXPywK30l3RknR5DSTHSwLVJEx/ojJ7nNTNUhvV0L6vVNh9k7tfxzyVZS0pNL5tVmBWTTjbS9hwJUl7noaICnmtXA0szwnX3UWKWUoa2blOYINmBYAwdszZynx+kAh7y/fcct3+PpGIZL17Z1Bb8NfakVHxEwP3f21YCobX11lwsoF35C0svnD8zaCamNwwaatVnmLI9gbyfxznbCXSvscu5kvBEBNYpN1fRX7ZqzADAYT3qDk6g9AGJ9Yt6vB9XnvNVeQnTdSRM04de7MV3uFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqYFTzPvqkPp1ogzDvPxzxk/XaqAr8Tx7Z9lSjMtonE=;
 b=W+dtYDUyyyYNi2uko7wt7U/hPpZIbArNg9Xv8OroVZ25hfYKznctPiy/EeIn3fQ49WYbHN/bTF6b7vK3zVwzQGEgnWxB6ApxEYTJ6fJECAUa49Spf826VzvA5osP7O/p6e1M+xJZ8P5kDMRKdBIt4R5bPnPu/rMZuL+yRsOo6S14rdG7SND0BUCsb+IufP28YInIDuvGclLTXqcdHgfNlfbFdNrom8s2vXi9eE1avLVHzuUQL1MMTqOGz0sFcymiCLfAvYwlaiIaENHCd9XKWCjrEZttU/SJ96h1qqxkibzyANrrNOQAyyrOc0PrY1z51UvgdONmEY+EqQcRgoNccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqYFTzPvqkPp1ogzDvPxzxk/XaqAr8Tx7Z9lSjMtonE=;
 b=Ydsnii7NOzgZPaNaKd6KPEklvenCDIaa9NA3eF4qFPUtPP7NMR5ncnAOQJxDNfvljE1vDNjCvdIG0Sd/JhuZP/0LNs0eqvwcPqm7hQ8uc0WIgm4suhTkkbNzaa/GIWEvmo311Zxc69PDKgxuUJ2T98HUMJDcrpi6cZfY/nrW90g=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3081.namprd12.prod.outlook.com (20.178.30.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.11; Thu, 18 Jul 2019 17:48:21 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 17:48:21 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v3 0/6] Remove x86-specific code from generic headers
Thread-Topic: [PATCH v3 0/6] Remove x86-specific code from generic headers
Thread-Index: AQHVPRj/oX9x6en7K0GjSSUSyjk8U6bQp8QA
Date:   Thu, 18 Jul 2019 17:48:21 +0000
Message-ID: <680bb92e-66eb-8959-88a5-3447a6a282c8@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-1-bauerman@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0156.namprd05.prod.outlook.com
 (2603:10b6:803:2c::34) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42a63cdc-3ef7-4951-4b30-08d70ba81fd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3081;
x-ms-traffictypediagnostic: DM6PR12MB3081:
x-microsoft-antispam-prvs: <DM6PR12MB30815EF8FE340B88AFC3097EECC80@DM6PR12MB3081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(54534003)(189003)(199004)(6512007)(305945005)(3846002)(478600001)(476003)(71200400001)(25786009)(6116002)(71190400001)(66946007)(2501003)(386003)(446003)(316002)(4326008)(54906003)(31686004)(11346002)(53936002)(256004)(52116002)(7736002)(66446008)(64756008)(6246003)(8676002)(8936002)(110136005)(66066001)(66476007)(99286004)(26005)(81166006)(2616005)(81156014)(5660300002)(6436002)(31696002)(6506007)(66556008)(86362001)(68736007)(14454004)(36756003)(6486002)(53546011)(229853002)(7416002)(486006)(186003)(102836004)(2906002)(76176011)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3081;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uvrtIfqOdJtQYYDYYQJHcGAIs5Vw2llnYaQuU65O9PMMmzz0QyQmvkIkKoD9xZvv4LPLiCIpU6nsdudoW7BBvlxb6AmRcweI0zWirRdD4f+244ss6J6bKT5RL0gJ0xXUwnVJSt9bSOHaLimXU46Cv+HiBQaeXLwaeyi9F3l4xsX5rJSp0pqpry2mf9ys9Uu0x/2gFzQ/0J70vqD6Rz4UDCBXWJdJ5+gVAERAn77t65WHxkGbUdcAPeEv9gf9h2d3xMQPdujLAKKTDv7TQQaD1AYBDR8EALksDqOkaLS8l4vYBcQY4yj9QRLoVXI58SoqEj0DXt8/4xzwXN0Z2/B/iq4hNKkfQEK2WizBMRZzqfh6ZfnE5MutkBuBs12DUinnlfwAEvLeEGyah9f+vp5JRJ3p5RHzxEMEy9FtrJGqfbI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F722F6675EEF4B4E824FE180F10FA466@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a63cdc-3ef7-4951-4b30-08d70ba81fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:48:21.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8xNy8xOSAxMDoyOCBQTSwgVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIHdyb3RlOg0KPiBIZWxs
bywNCj4gDQo+IFRoaXMgdmVyc2lvbiBpcyBtb3N0bHkgYWJvdXQgc3BsaXR0aW5nIHVwIHBhdGNo
IDIvMyBpbnRvIHRocmVlIHNlcGFyYXRlDQo+IHBhdGNoZXMsIGFzIHN1Z2dlc3RlZCBieSBDaHJp
c3RvcGggSGVsbHdpZy4gVHdvIG90aGVyIGNoYW5nZXMgYXJlIGEgZml4IGluDQo+IHBhdGNoIDEg
d2hpY2ggd2Fzbid0IHNlbGVjdGluZyBBUkNIX0hBU19NRU1fRU5DUllQVCBmb3IgczM5MCBzcG90
dGVkIGJ5DQo+IEphbmFuaSBhbmQgcmVtb3ZhbCBvZiBzbWVfYWN0aXZlIGFuZCBzZXZfYWN0aXZl
IHN5bWJvbCBleHBvcnRzIGFzIHN1Z2dlc3RlZA0KPiBieSBDaHJpc3RvcGggSGVsbHdpZy4NCj4g
DQo+IFRoZXNlIHBhdGNoZXMgYXJlIGFwcGxpZWQgb24gdG9wIG9mIHRvZGF5J3MgZG1hLW1hcHBp
bmcvZm9yLW5leHQuDQo+IA0KPiBJIGRvbid0IGhhdmUgYSB3YXkgdG8gdGVzdCBTTUUsIFNFViwg
bm9yIHMzOTAncyBQRUYgc28gdGhlIHBhdGNoZXMgaGF2ZSBvbmx5DQo+IGJlZW4gYnVpbGQgdGVz
dGVkLg0KDQpJJ2xsIHRyeSBhbmQgZ2V0IHRoaXMgdGVzdGVkIHF1aWNrbHkgdG8gYmUgc3VyZSBl
dmVyeXRoaW5nIHdvcmtzIGZvciBTTUUNCmFuZCBTRVYuDQoNClRoYW5rcywNClRvbQ0KDQo+IA0K
PiBDaGFuZ2Vsb2cNCj4gDQo+IFNpbmNlIHYyOg0KPiANCj4gLSBQYXRjaCAieDg2LHMzOTA6IE1v
dmUgQVJDSF9IQVNfTUVNX0VOQ1JZUFQgZGVmaW5pdGlvbiB0byBhcmNoL0tjb25maWciDQo+ICAg
LSBBZGRlZCAic2VsZWN0IEFSQ0hfSEFTX01FTV9FTkNSWVBUIiB0byBjb25maWcgUzM5MC4gU3Vn
Z2VzdGVkIGJ5IEphbmFuaS4NCj4gDQo+IC0gUGF0Y2ggIkRNQSBtYXBwaW5nOiBNb3ZlIFNNRSBo
YW5kbGluZyB0byB4ODYtc3BlY2lmaWMgZmlsZXMiDQo+ICAgLSBTcGxpdCB1cCBpbnRvIDMgbmV3
IHBhdGNoZXMuIFN1Z2dlc3RlZCBieSBDaHJpc3RvcGggSGVsbHdpZy4NCj4gDQo+IC0gUGF0Y2gg
InN3aW90bGI6IFJlbW92ZSBjYWxsIHRvIHNtZV9hY3RpdmUoKSINCj4gICAtIE5ldyBwYXRjaC4N
Cj4gDQo+IC0gUGF0Y2ggImRtYS1tYXBwaW5nOiBSZW1vdmUgZG1hX2NoZWNrX21hc2soKSINCj4g
ICAtIE5ldyBwYXRjaC4NCj4gDQo+IC0gUGF0Y2ggIng4NixzMzkwL21tOiBNb3ZlIHNtZV9hY3Rp
dmUoKSBhbmQgc21lX21lX21hc2sgdG8geDg2LXNwZWNpZmljIGhlYWRlciINCj4gICAtIE5ldyBw
YXRjaC4NCj4gICAtIFJlbW92ZWQgZXhwb3J0IG9mIHNtZV9hY3RpdmUgc3ltYm9sLiBTdWdnZXN0
ZWQgYnkgQ2hyaXN0b3BoIEhlbGx3aWcuDQo+IA0KPiAtIFBhdGNoICJmcy9jb3JlL3ZtY29yZTog
TW92ZSBzZXZfYWN0aXZlKCkgcmVmZXJlbmNlIHRvIHg4NiBhcmNoIGNvZGUiDQo+ICAgLSBSZW1v
dmVkIGV4cG9ydCBvZiBzZXZfYWN0aXZlIHN5bWJvbC4gU3VnZ2VzdGVkIGJ5IENocmlzdG9waCBI
ZWxsd2lnLg0KPiANCj4gLSBQYXRjaCAiczM5MC9tbTogUmVtb3ZlIHNldl9hY3RpdmUoKSBmdW5j
dGlvbiINCj4gICAtIE5ldyBwYXRjaC4NCj4gDQo+IFNpbmNlIHYxOg0KPiANCj4gLSBQYXRjaCAi
eDg2LHMzOTA6IE1vdmUgQVJDSF9IQVNfTUVNX0VOQ1JZUFQgZGVmaW5pdGlvbiB0byBhcmNoL0tj
b25maWciDQo+ICAgLSBSZW1vdmUgZGVmaW5pdGlvbiBvZiBBUkNIX0hBU19NRU1fRU5DUllQVCBm
cm9tIHMzOTAvS2NvbmZpZyBhcyB3ZWxsLg0KPiAgIC0gUmV3b3JkZWQgcGF0Y2ggdGl0bGUgYW5k
IG1lc3NhZ2UgYSBsaXR0bGUgYml0Lg0KPiANCj4gLSBQYXRjaCAiRE1BIG1hcHBpbmc6IE1vdmUg
U01FIGhhbmRsaW5nIHRvIHg4Ni1zcGVjaWZpYyBmaWxlcyINCj4gICAtIEFkYXB0IHMzOTAncyA8
YXNtL21lbV9lbmNyeXB0Lmg+IGFzIHdlbGwuDQo+ICAgLSBSZW1vdmUgZG1hX2NoZWNrX21hc2so
KSBmcm9tIGtlcm5lbC9kbWEvbWFwcGluZy5jLiBTdWdnZXN0ZWQgYnkNCj4gICAgIENocmlzdG9w
aCBIZWxsd2lnLg0KPiANCj4gVGhpYWdvIEp1bmcgQmF1ZXJtYW5uICg2KToNCj4gICB4ODYsczM5
MDogTW92ZSBBUkNIX0hBU19NRU1fRU5DUllQVCBkZWZpbml0aW9uIHRvIGFyY2gvS2NvbmZpZw0K
PiAgIHN3aW90bGI6IFJlbW92ZSBjYWxsIHRvIHNtZV9hY3RpdmUoKQ0KPiAgIGRtYS1tYXBwaW5n
OiBSZW1vdmUgZG1hX2NoZWNrX21hc2soKQ0KPiAgIHg4NixzMzkwL21tOiBNb3ZlIHNtZV9hY3Rp
dmUoKSBhbmQgc21lX21lX21hc2sgdG8geDg2LXNwZWNpZmljIGhlYWRlcg0KPiAgIGZzL2NvcmUv
dm1jb3JlOiBNb3ZlIHNldl9hY3RpdmUoKSByZWZlcmVuY2UgdG8geDg2IGFyY2ggY29kZQ0KPiAg
IHMzOTAvbW06IFJlbW92ZSBzZXZfYWN0aXZlKCkgZnVuY3Rpb24NCj4gDQo+ICBhcmNoL0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICsrKw0KPiAgYXJjaC9zMzkwL0tjb25maWcg
ICAgICAgICAgICAgICAgICAgfCAgNCArLS0tDQo+ICBhcmNoL3MzOTAvaW5jbHVkZS9hc20vbWVt
X2VuY3J5cHQuaCB8ICA1ICstLS0tDQo+ICBhcmNoL3MzOTAvbW0vaW5pdC5jICAgICAgICAgICAg
ICAgICB8ICA4ICstLS0tLS0tDQo+ICBhcmNoL3g4Ni9LY29uZmlnICAgICAgICAgICAgICAgICAg
ICB8ICA0ICstLS0NCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL21lbV9lbmNyeXB0LmggIHwgMTAg
KysrKysrKysrKw0KPiAgYXJjaC94ODYva2VybmVsL2NyYXNoX2R1bXBfNjQuYyAgICAgfCAgNSAr
KysrKw0KPiAgYXJjaC94ODYvbW0vbWVtX2VuY3J5cHQuYyAgICAgICAgICAgfCAgMiAtLQ0KPiAg
ZnMvcHJvYy92bWNvcmUuYyAgICAgICAgICAgICAgICAgICAgfCAgOCArKysrLS0tLQ0KPiAgaW5j
bHVkZS9saW51eC9jcmFzaF9kdW1wLmggICAgICAgICAgfCAxNCArKysrKysrKysrKysrKw0KPiAg
aW5jbHVkZS9saW51eC9tZW1fZW5jcnlwdC5oICAgICAgICAgfCAxNSArLS0tLS0tLS0tLS0tLS0N
Cj4gIGtlcm5lbC9kbWEvbWFwcGluZy5jICAgICAgICAgICAgICAgIHwgIDggLS0tLS0tLS0NCj4g
IGtlcm5lbC9kbWEvc3dpb3RsYi5jICAgICAgICAgICAgICAgIHwgIDMgKy0tDQo+ICAxMyBmaWxl
cyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCA0NyBkZWxldGlvbnMoLSkNCj4gDQo=
