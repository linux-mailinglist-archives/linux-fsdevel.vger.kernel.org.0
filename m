Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C76E61E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfGSNMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 09:12:37 -0400
Received: from mail-eopbgr760043.outbound.protection.outlook.com ([40.107.76.43]:57604
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728152AbfGSNMh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+R4EvSfFC6oIOg0I57t2z+Xhzj+CCwoBxHdt+rsD9fjHnm5T4LwOs+3VZOvNdh+wlgvn/Ms+jx2afoMHU4gy2cD6amngRTsC4xyW9N9e8SsUGRssQSqCY7OQj5YrZ3XipDC+WRm7AAl60zuMjJH6ogD/1PzI30+4XE+QVAgVe42B7wup1WyXQ46ZB8NdqKpWcCQBFSa3tkb1bemtn6glYF8mKtwjicOeU3IvZ8JT4KieyFEexsspBZoG01KsRUC9nHTpFqSve8PGgbEhFiM/pvKjZzKXfvD65Sjd6jadJ5zqN5kwzMvCWJVooRF1HKU0en3B4Y/fMc2lA4sEcFsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggUqI1mtPCK2vMkfn/mmHXNkd5CgzlWib7SrLAVBYn4=;
 b=YsYmOwy+XGrf9f/u2ggKDbZK6oA9I/0x5F4oWIqig3UTRrN1TucnYbiZx582cO99yrUXWRTbXEkBjWRjmf18ird41I4iZ1FHlbtclb7r5ErLzSA0WcDtIVLkUz4IpGPilqVdSUmpAfz3gWEWZWd/AoX0VXKc2bMbvzpoIDAfqOIlqjskFS9LK4ySx7OVb8pnhfggiYBLSHSiYjjRbWxvrcbyy/hWIS2AWlDogEzzgTuM3O4pCuPHyfxNGgqPYqiW9J6GauKX8m5upvwnJJpOoUcW0NFh2ydp5sWYDJfXpH5Fz8E63suVxaI2j/FyLaeeV0djuiNfuOv0Ku49r3pKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggUqI1mtPCK2vMkfn/mmHXNkd5CgzlWib7SrLAVBYn4=;
 b=ZVFR7r7S6LbywOS+XXr/Kv6FMk4sAJRpvuIwl+1cAp8qzyk9s4PB9xZRGleFVB1JrdcHqKkCFiNw1uzTMheItotNXoaWuz5V79ki2QZ5fjLGpQOlMutMMGfCdRUD+YSOYt485wD9AHBzSJZpHp/YZWXatn3ohEvQOZylS1O5QVI=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3019.namprd12.prod.outlook.com (20.178.30.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.12; Fri, 19 Jul 2019 13:12:34 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 13:12:34 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
Thread-Index: AQHVPRj/oX9x6en7K0GjSSUSyjk8U6bQU/MAgAB0XYCAASS5gA==
Date:   Fri, 19 Jul 2019 13:12:33 +0000
Message-ID: <879a196a-1d92-931d-88f4-6ce17a09cf20@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
 <680bb92e-66eb-8959-88a5-3447a6a282c8@amd.com>
 <87a7db3z68.fsf@morokweng.localdomain>
In-Reply-To: <87a7db3z68.fsf@morokweng.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:805:3e::17) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3b2d442-bed0-474d-cc2b-08d70c4ac2f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3019;
x-ms-traffictypediagnostic: DM6PR12MB3019:
x-microsoft-antispam-prvs: <DM6PR12MB3019427DB838CD628D02CA71ECCB0@DM6PR12MB3019.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(102836004)(53936002)(52116002)(7736002)(229853002)(256004)(6436002)(31696002)(25786009)(7416002)(8936002)(68736007)(6506007)(53546011)(305945005)(6916009)(6486002)(386003)(186003)(31686004)(486006)(71200400001)(71190400001)(2906002)(478600001)(446003)(14454004)(5660300002)(6512007)(4326008)(76176011)(54906003)(81156014)(476003)(26005)(2616005)(66066001)(6246003)(36756003)(8676002)(3846002)(6116002)(316002)(64756008)(66446008)(81166006)(66946007)(11346002)(66556008)(99286004)(86362001)(66476007)(4744005)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3019;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F+z10TAX7b2fjtuBQEJL/X8dKfTh3kpLJ9l2EFFTfGUpWQHv3pKi923NSa4WHX3bZUDw7uVBjpSbx5TWXFEMqHG85J5aQOhUfgGwLGGFUa5p0uTmHKFg2e7fQ1tLgzphhqT9M7A7P4Lbi6n7qpFOMh/91YWDTjI0TOJ2cTR+tsAAVNPOeyNH+SkzZnb7gzI/YwCi7X4PJy/k1QeFqUBtnxsi/prOkx6wcGurCvrIUusYqQGDuu9CUAI7jPK1mQzqrWjeIu5q9NF24AGyo03Uswm8UOS8Sjzk1eRLwW32/7PnqBBx1/zcZrPBZAEEVANxJaQqXz3JoLueq4RNAdMoXQrq+mjiDov0v1Un7n2z/LFvw8rakuUggZfcvDrQDch9lC0rmF+bSS8FnX1g7LY+vaOUs2o0/pKyEVkZUo+/dY0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6763BDAFFDD7843AF08E64ECA218C71@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b2d442-bed0-474d-cc2b-08d70c4ac2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 13:12:34.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8xOC8xOSAyOjQ0IFBNLCBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gd3JvdGU6DQo+IA0KPiBM
ZW5kYWNreSwgVGhvbWFzIDxUaG9tYXMuTGVuZGFja3lAYW1kLmNvbT4gd3JpdGVzOg0KPiANCj4+
IE9uIDcvMTcvMTkgMTA6MjggUE0sIFRoaWFnbyBKdW5nIEJhdWVybWFubiB3cm90ZToNCj4+PiBI
ZWxsbywNCj4+Pg0KPj4+IFRoaXMgdmVyc2lvbiBpcyBtb3N0bHkgYWJvdXQgc3BsaXR0aW5nIHVw
IHBhdGNoIDIvMyBpbnRvIHRocmVlIHNlcGFyYXRlDQo+Pj4gcGF0Y2hlcywgYXMgc3VnZ2VzdGVk
IGJ5IENocmlzdG9waCBIZWxsd2lnLiBUd28gb3RoZXIgY2hhbmdlcyBhcmUgYSBmaXggaW4NCj4+
PiBwYXRjaCAxIHdoaWNoIHdhc24ndCBzZWxlY3RpbmcgQVJDSF9IQVNfTUVNX0VOQ1JZUFQgZm9y
IHMzOTAgc3BvdHRlZCBieQ0KPj4+IEphbmFuaSBhbmQgcmVtb3ZhbCBvZiBzbWVfYWN0aXZlIGFu
ZCBzZXZfYWN0aXZlIHN5bWJvbCBleHBvcnRzIGFzIHN1Z2dlc3RlZA0KPj4+IGJ5IENocmlzdG9w
aCBIZWxsd2lnLg0KPj4+DQo+Pj4gVGhlc2UgcGF0Y2hlcyBhcmUgYXBwbGllZCBvbiB0b3Agb2Yg
dG9kYXkncyBkbWEtbWFwcGluZy9mb3ItbmV4dC4NCj4+Pg0KPj4+IEkgZG9uJ3QgaGF2ZSBhIHdh
eSB0byB0ZXN0IFNNRSwgU0VWLCBub3IgczM5MCdzIFBFRiBzbyB0aGUgcGF0Y2hlcyBoYXZlIG9u
bHkNCj4+PiBiZWVuIGJ1aWxkIHRlc3RlZC4NCj4+DQo+PiBJJ2xsIHRyeSBhbmQgZ2V0IHRoaXMg
dGVzdGVkIHF1aWNrbHkgdG8gYmUgc3VyZSBldmVyeXRoaW5nIHdvcmtzIGZvciBTTUUNCj4+IGFu
ZCBTRVYuDQoNCkJ1aWx0IGFuZCB0ZXN0ZWQgYm90aCBTTUUgYW5kIFNFViBhbmQgZXZlcnl0aGlu
ZyBhcHBlYXJzIHRvIGJlIHdvcmtpbmcNCndlbGwgKG5vdCBleHRlbnNpdmUgdGVzdGluZywgYnV0
IHNob3VsZCBiZSBnb29kIGVub3VnaCkuDQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPiBUaGFua3Mh
IEFuZCB0aGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcy4NCj4gDQo=
