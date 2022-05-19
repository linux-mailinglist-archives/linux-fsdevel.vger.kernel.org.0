Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C870A52C917
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 03:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiESBCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 21:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiESBCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 21:02:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6464CCE16;
        Wed, 18 May 2022 18:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXGXNivrohdeZcP/KGb21nSaqJMaQ4eATX3cq9ZKbioBQhbtEZr5QhVFjLao9+WOt7WDMd/0125qQhzlpS8BsPdfPuDjfVgkffy3ubuzZolmMHXdl7doaAx2xuRdJED66NC2GGb3UmrmMn9/KpWheAichh6wb9xyaKQQNapNEz/pupANB8AcYKJsQl5cO9p8y1MCLYUOxHiPzJGtP/6rKTm6QGIyLWKlKpJYKSBWiw2xka4Ovc/LgN1SNOM+b3rJOIOyAkS5WdqGuBMplTWkuY98cXpqy3p0NvmtW51y8lKtfeOxd6O2ZqP8N05rGpq5t+w3Wu3sNOo9plD8H7sg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEe2NazU1F78A8tkweKJNqEccNiapEYFArCRbz73qU8=;
 b=EIa1nIJ8K8GZ+PtTHQgABbkRDNl/No0zYidm+SwZ+979vbZd5YRejkt6ydi218v+8OUr48zxTLVxQ0+HqHdefkbfAfiOPSiGZZlpIz4ZfVYf6la+IKdDU4dDT2jpskdcm+z1Jc+5iupfl0bUBBoRqxmRY0e2547lCwfE13o0M8CoD1tirycZdgY68WmTfT4Liks7o6n7nKJKT8TcOOI6vVkwqH2cm10i9CXI43E3A2HmjKyQdsMqJUlCjEQK5XRV8sdTYJLyPT/B2Unkh0wHFF27+Ab9g7vPMhwpn7L2d/n+4+Z26yY+MfM5a7Bnt5iVJSxsDYmcnaNrvzav+Fvmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEe2NazU1F78A8tkweKJNqEccNiapEYFArCRbz73qU8=;
 b=Vffw06D4zYTFuJs0p6vQCoxt7LFQ8oO1ta+61yxgR9B9gj6meS5QA7RXW6sHNboKmg0U3Lu6y76rC9NR/bo/od6i/96kqS2gPZ0ExxcHDpqDxIy+TDKeRYlZ1nVs1pSCPK8vz2jAxGr5bSlQkgq0tinCqKKy7//JpIN4dOEcrcFwFG80OkAWPvZ5Ahop4ipTcHLQCInkUB3WDLVp4M5YxKW1YEcvv9twoysE+RhReQ9WoD0SNhqfooLXoy0dR0JTXEPz81VBLNfYj2reiBiJj8XFJAbs7LrO5dZejr0F8VcSYtL16eEErzNWnHQned055kNOqs+oFvGvu9StlE3piQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM5PR12MB1212.namprd12.prod.outlook.com (2603:10b6:3:74::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 19 May
 2022 01:02:42 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::b5ef:4bc0:7272:487]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::b5ef:4bc0:7272:487%5]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 01:02:42 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@kernel.org>, Eric Biggers <ebiggers@kernel.org>
CC:     Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Thread-Topic: [PATCHv2 0/3] direct io alignment relax
Thread-Index: AQHYatr6ayGMmY2xK0+q8n5HhzaXoK0lR6YAgAAX2ICAAAMUAA==
Date:   Thu, 19 May 2022 01:02:42 +0000
Message-ID: <f42c74b9-67fa-50fc-d97e-2a7f153f10e4@nvidia.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <YoWAnDR/XOwegQNZ@gmail.com>
 <YoWUnTxag7TsCBwa@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YoWUnTxag7TsCBwa@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43222ea0-0785-4dd9-1190-08da3933472c
x-ms-traffictypediagnostic: DM5PR12MB1212:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1212009DBE9D40343C153CD5A3D09@DM5PR12MB1212.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FzbqokQhyy4g9BPpSd2JJBkw+gVcpjJOe4QNstSJXTEeG0P2gmrqysUSw7g0GM2j7njFcrnvUKMGcnbBYaqZ3LN7wEzo5rz2x3lmoHBDG3p7aMfsk2aeoU8vNjdbZ6AOp0GPvnBmxXg9Fk2c9Bs26zQQjiLE+wL8h/eYjH9Za8szAbQ20vX5N1zQ5SIVXPRIvoT94s3FPqKd+LZFEfLIcIT8Paib/SNHMXjf4CSb7n+mJPDCTmkZSBecjc0w0GVVsO65WLThRXlE2/fNThCYcWjTsUwIOyNCqMta2xJXX2qoTIv9QsvpnmnAZa9bpHVxDZD5bD4BI2eoxXvsirZgCZiZorZYF4msqj3cf2sN6KMctorjTIWj5gTNcjA5HGFscwKkKFBVyoq0ahL5TghaNFo8zjF9Z7PKYMd3wCRnmQtdsUJHpbop9xF9dGEGnzbfQu68iqkvOX9YDrpw/eSKPMNfymFZpmiojuhDK2Ops/mCcD7lhOnR0WbK05MZpaH2i6DVSUYLZ3aJwl7BbypPWKFmUsv8OVvafROogiscfaFpXIdoIeC8tGssu480la/ncb3kJGhozVeSH6XWG6STcvWeIBpgnfyDeaXo/1a+LjVsA1bxCtMdQFr10kWgPQUjPwJnltZmGzGHqWMwh/VIo8WOSKK2rL1b8DFM8GVJodHLsJDr3f8SssR2qjfCWmeMHohFHQq0Qk04hYtTMck9md20/Dv4lhev67BE7lUmTVYP8KPaL1gSe4gsStJqJcN3vXjbQCUpbff6DCozdBO7Je8oqhktH7bzUKnsFgYZFD9ncI4R5/VRYXAsgw8iSE3Q5LwPjFH7u/3CgDPD9JDpI9lq4/6RWz2EcJA0zDxX0PhUVvnxe4RiBgRbwbbUDkMyL0NwBjfOk9qvPwvxzucNng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(316002)(38070700005)(8936002)(83380400001)(2906002)(4326008)(91956017)(8676002)(76116006)(66446008)(2616005)(186003)(66556008)(66946007)(110136005)(66476007)(122000001)(71200400001)(966005)(36756003)(53546011)(6512007)(86362001)(7416002)(6506007)(31696002)(31686004)(64756008)(6486002)(38100700002)(508600001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUdKRGF1UGxnRlNTWmtaQ0FxSjVia01jdXdNeWtJSXlBemNIcUtYMCtYeW5Q?=
 =?utf-8?B?TGtBOFFwZHVOcXE1ZEgxN0RUcGpIUXdSYkFISjBwMlJRcStnTFg4N09wazVw?=
 =?utf-8?B?NFl5KzVPaGhMbHZKNFJ4T3hzVHluMC8yZ0JxYzBpNmNoekU3ZU9SRDZZMTJZ?=
 =?utf-8?B?U2U4ZFZPVncwVWdLSCtJQWFJNlp5SjUzdFAxYzV2dGJKWUJkR1RCTysvcFcz?=
 =?utf-8?B?ZHQ1b3BXRHhLRjMydmtJd2JFV2UzTGpkOHFyWFdxMUxxNjVGRzM2dVFkcUoz?=
 =?utf-8?B?T0lsVEE5RitFZmR3cFlldTFRTDJxdHIzS2RVM25kSkFkN0VETSsyb1kvNjlO?=
 =?utf-8?B?dERaaGp6UDJKb0lNd3pEWWdHek1SV0ppS3BmM3dCd1RDSG5LOTlnWU1aalV0?=
 =?utf-8?B?RXhWMUh5K0JvbXJsdUFCNEljUkM3RnZmVFJCdzBadG5vZXNhYTFoSUVTUXFE?=
 =?utf-8?B?UmlUazJGY0dKOEU3QzRacGtFRm5TV3R5SWFvWE5pSjNGZ3RZZkpaZ3gyVGsy?=
 =?utf-8?B?N3VPZnFtOXEzY2ZuSjV5NlJJSlJXSktlOWhxVXNPZGI0OGJyNUUySklxTG9l?=
 =?utf-8?B?eG1hQmgrU1lUM2NDTGVZZ1FBZU80bTBLdjdzT1Y4cjlQRzk2MFgrRzdaSzk0?=
 =?utf-8?B?WUlYaVB5MkozaEtSRDYyZkJJK1B2UG9OOExUUDM5ZU4wUmJrOHF6bjVoQ3hN?=
 =?utf-8?B?UDB3dmNvR0czNlRzY2FIL1NGdWlSaHJTSVNTWDBKZ2ZpVm5rODJ3bnFkUjJM?=
 =?utf-8?B?V3lUQUFPMmcrN0lVVkx0TjRrOEJKcjBKNWx1VG5Pam5IeXRGdkVpRktRdWIx?=
 =?utf-8?B?cHBiamhic0d6ZzRxZW9jcFFsMlVNWFdweVozM1d0OEs3dnVFSGxaeWdQUnU5?=
 =?utf-8?B?dDRBcWNuNmxFdEI5elA1UWFvaUt6eHhTWVhGcktmMXpjK3BOTkNkb3BXM2s4?=
 =?utf-8?B?WFozY015UzVvVWNOaXhFQ0FSQUZ3VXRoQkc3WmJuM01TS3JISVIyeC80TUpM?=
 =?utf-8?B?SW1yRDJycHZ0d1lnb3oxY3VqWnErZm9aLy8vallRdkRQWjRFM1cva2UrdlNv?=
 =?utf-8?B?ZzdLZm9NSUhaY3djemxxNExuTkdOajNranc0NzdPSjNUemQ4YlZCOHdMeWdo?=
 =?utf-8?B?N0xoODE4ZVdPS2cvN2ZpNXNVUStWWGJNNzFsRVVyZVhxajZTbzhOK3VHOElw?=
 =?utf-8?B?ZnNVTExpdW5mREo1QXpsbE55cHBvczV4WnI3ZEE2QXVlUVA4aGZ3ZHB3MlZV?=
 =?utf-8?B?bktyWnhYb2JLbFZMaWtxUi81cUZaSWIvWVBma0o5Zm14Umo4ZWNRMzFIbFZm?=
 =?utf-8?B?QzFIUGRYYVBEVC82d3NiRzQrZlQzenBGdUR3aEZsQm9Gam9ZSUhXcmRhNmY1?=
 =?utf-8?B?YXN3OWxoalZ5eHY0N21KQkRleXdHUjhPb3IyVlBsZmtxODNsUTFyUG5kRDF4?=
 =?utf-8?B?VnVtbWxyckttNGR4Z1FUWEpaYXdyU2FGOStWaG9BWkFKU08xKy9qQWJ1Ky83?=
 =?utf-8?B?U3V3cjhsYlh1QVR5T0tNdnREcE5IdDFLblNHay9MNTZZSVIwcVFUS3Z2Qi9x?=
 =?utf-8?B?MjAySTJjWFd6YW5pZ0c4U2REaGNqNEp6UTRVaUNTWU9uTnFJT3hKYzl5OHRK?=
 =?utf-8?B?Q3NxaWJpS0dEQ1JWR3FKWXdjdVkwME5hY1R2bjhINzBQeldJN1l4eTE0dG9Q?=
 =?utf-8?B?a3JFMWNHYmNGRGJ4TE9ZSjBhUitzZm1RdGJBbU0xV054N2tvZDRyNStCYmpX?=
 =?utf-8?B?MDd6QzZHNS9wUFUvMVA4Q2UyVDdvRVpGWmM5bzJ4RGpta1dqTEwvejFOOHlD?=
 =?utf-8?B?S3I0RS91Y0t0eHdaSS80eXhpOWQ0cHRuemExK3BFM20vc1dCM3Q4S0NJSHp6?=
 =?utf-8?B?UmUwa1pleTBJZXFWRHBockRQRkk3bVR5Vm03dGxmU0V4UVBBQWhJemVDRW42?=
 =?utf-8?B?ZUxBN1hOT1JHTzhjTllyWkh4Q2VBWG9lV0ptSUxQeWdJR3JPR1lvTVVDY3dR?=
 =?utf-8?B?Tm9XL0h2K28yaXJZUlF6VndranNJNGRrRGEwUGRrVkNhejNMK2Vmd05McjMy?=
 =?utf-8?B?T050TzBaM1NGb3ZBaGtBbnY3b0tYa0xwcituVFRwbm5lYTlmNjJUdXhyTy9T?=
 =?utf-8?B?dnNqTG0zcEl2SFpYTGVpTlErZE00RERXVC93dkhmdWdMaXpqaWRUUGI5RGth?=
 =?utf-8?B?Skg5eWZWQkJMSkk0TjVXL21wM1cvZFB0WWVrbEtIMmR0NlkrZ3VGMXkwM2tM?=
 =?utf-8?B?RzlMdzJCZ1o2RXd1bVJhSVBFcjdWOE5aNk9DTVc4UkZqY2ZxUW1WdTZybVo2?=
 =?utf-8?B?TTNveWUxZTJLRkUvRWpZL0xOZHAvQ2x5aVVVcnhUQlIxbkJvRmRsaExwZy9m?=
 =?utf-8?Q?KoJrube6UjsLTPxAO0QrVzZbSLZa5FUvtczgjaZ5CV+oG?=
x-ms-exchange-antispam-messagedata-1: KiAGcNIlZEdqeA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECB34EAAF0107943813377D160CE4E32@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43222ea0-0785-4dd9-1190-08da3933472c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 01:02:42.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZqSjwrer4E6LKEc27rYXEoCHHazqr2NvqlyvXsLPGJ6hLs6h9ubZmnjz8gUg/tIzIccMxViwYWfTWmNwYx6JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1212
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNS8xOC8yMiAxNzo1MSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFdlZCwgTWF5IDE4LCAy
MDIyIGF0IDExOjI2OjIwUE0gKzAwMDAsIEVyaWMgQmlnZ2VycyB3cm90ZToNCj4+IE9uIFdlZCwg
TWF5IDE4LCAyMDIyIGF0IDEwOjExOjI4QU0gLTA3MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4+
IEZyb206IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4+Pg0KPj4+IEluY2x1ZGlu
ZyB0aGUgZnMgbGlzdCB0aGlzIHRpbWUuDQo+Pj4NCj4+PiBJIGFtIHN0aWxsIHdvcmtpbmcgb24g
YSBiZXR0ZXIgaW50ZXJmYWNlIHRvIHJlcG9ydCB0aGUgZGlvIGFsaWdubWVudCB0bw0KPj4+IGFu
IGFwcGxpY2F0aW9uLiBUaGUgbW9zdCByZWNlbnQgc3VnZ2VzdGlvbiBvZiB1c2luZyBzdGF0eCBp
cyBwcm92aW5nIHRvDQo+Pj4gYmUgbGVzcyBzdHJhaWdodCBmb3J3YXJkIHRoYW4gSSB0aG91Z2h0
LCBidXQgSSBkb24ndCB3YW50IHRvIGhvbGQgdGhpcw0KPj4+IHNlcmllcyB1cCBmb3IgdGhhdC4N
Cj4+Pg0KPj4NCj4+IE5vdGUgdGhhdCBJIGFscmVhZHkgaW1wbGVtZW50ZWQgdGhlIHN0YXR4IHN1
cHBvcnQgYW5kIHNlbnQgaXQgb3V0IGZvciByZXZpZXc6DQo+PiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1mc2RldmVsLzIwMjIwMjExMDYxMTU4LjIyNzY4OC0xLWViaWdnZXJzQGtlcm5l
bC5vcmcvVC8jdQ0KPj4gSG93ZXZlciwgdGhlIHBhdGNoIHNlcmllcyBvbmx5IHJlY2VpdmVkIG9u
ZSBjb21tZW50LiAgSSBjYW4gc2VuZCBpdCBvdXQgYWdhaW4gaWYNCj4+IHBlb3BsZSBoYXZlIGJl
Y29tZSBpbnRlcmVzdGVkIGluIGl0IGFnYWluLi4uDQo+IA0KPiBUaGFua3MsIEkgZGlkbid0IHNl
ZSB0aGF0IHRoZSBmaXJzdCB0aW1lIGFyb3VuZCwgYnV0IEknbGwgYmUgc3VyZSB0byBsb29rIGF0
DQo+IHlvdXIgbmV3IHZlcnNpb24uIEl0IHNvdW5kcyBsaWtlIHlvdSBlbmNvdW50ZXJlZCB0aGUg
c2FtZSBwcm9ibGVtIEkgZGlkDQo+IHJlZ2FyZGluZyBibG9jayBkZXZpY2UgaGFuZGxlczogdGhl
IGRldnRtcGZzIGlub2RlcyBmb3IgdGhlIHJhdyBibG9jayBkZXZpY2UNCj4gaGFuZGxlcyBhcmUg
bm90IHRoZSBiZGV2IGlub2Rlcy4gSSBkbyB0aGluayBpdCdzIHVzZWZ1bCB0aGUgYWxpZ25tZW50
DQo+IGF0dHJpYnV0ZXMgYXJlIGFjY2Vzc2libGUgdGhyb3VnaCB0aGUgYmxvY2sgZGV2aWNlIGZp
bGVzLCB0aG91Z2guDQoNCklycmVzcGVjdGl2ZSBvZiBhYm92ZSBwcm9ibGVtLCBhcyBwZXIgbXkg
cmV2aWV3IGNvbW1lbnQgWzFdIG9uIHRoZQ0KaW5pdGlhbCB2ZXJzaW9uIG9mIEVyaWMncyBzZXJp
ZXMgSSByZWFsbHkgd2FudCB0byBzZWUgdGhlIGdlbmVyaWMNCmludGVyZmFjZSB0aGF0IGNhbiBh
Y2NvbW1vZGF0ZSBleHBvc2luZyBvcHRpbWFsIHZhbHVlcyBmb3IgZGlmZmVyZW50DQpvcGVyYXRp
b25zIFJFUV9PUF9ESVNDQVJEL1JFUV9PUF9XUklURV9aRVJPRVMvUkVRX09QX1ZFUklGWSBldGMu
DQphbmQgbm90IG9ubHkgZm9yIHJlYWQvd3JpdGUuDQoNCi1jaw0KDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjIwMjExMDYxMTU4LjIyNzY4OC0xLWViaWdnZXJzQGtl
cm5lbC5vcmcvVC8jcjNmZmU5MTgzYzM3MmZiOTdhOTc1M2UyODZmOWNmNjQwMGU4ZWMyNzINCg0K
DQo=
