Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96B493089
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 23:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348432AbiARWOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 17:14:20 -0500
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:35425
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237483AbiARWOT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:14:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiuAV0MFiE8h5Eq3aaohkVMf81XBM+WzNGwxu6yyDKLW1MVeGGIceRGfCyNLVarzSzVSR6nNj5t3wK6HOIw//j1SJcNX5TLqZTxAfWC8K7kjgLLMNZEXQim0kBh6V/YgpBeM2t/M/JJOZrZZSENNXICfii7b69FnKnnBMjAulnFrwaqUcp5h/8dpsgi70a9BurJHFQbisyJZD8zfgzNfdU7t+S2hcOkqrA+vVDWIkm+H0q/i9itzhpmKIEkHqiKdACNHURIX2/q6i4U1uLjxZI5JRll9z3r/11vG5e/1VBpuUvD5KxnRL04dvxFl7Kj0dTEmJfhpxyGUUo8+mCEHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSJliUmMKGywiR7aX2A0K7VaQAgJnTUG4RzJwOOxmtY=;
 b=UAgv6P/KTlFBeVyfCrB6leBJABVI8j89enDpk7dmiUdc/rWA+rZdhUsC8248SkLa2RbeSTY53PRFbHgQdvoFVdbU0QAwq/hJavwFdL1SEBMHdMDwzxDnQeq+8PmEYISspgapAwTLUNjyaz0zpoqoHulcFNiS7cW+HNGn7ISHtTi7JPFe6nZsof4mPZP4HHoNy8nVnkxtTj0kjASXENzkzQq4oGTvcpKVaPUk3d/raTFLODLG/2JHNVuNnxwwI1UkN8420YmXnTU0cXd800y56hAZZlRu5HaZ9Utpxt1FTpTvanQspV6jy15QBA4tS31K+eRBo6PVKy2vGTbRhFoaJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSJliUmMKGywiR7aX2A0K7VaQAgJnTUG4RzJwOOxmtY=;
 b=pLVZEiVMX0zPE2061UG/7mMXj+M4+oYQfJxoqh5U8gcSd/4phNII+UDan9y6AKa0ylV41BjaDy2pKeJxWGCa+RxGDdCddb8Xq4iVX9C9RzKna/GFHnU6aWoU5lAq76t7r2xQWSjVnFFjsmKhGStLxD4zk++2K5lyS9/VH4gLYL31Q74ltNxKUsgxWsfBSPsFm+YsLxrgX34k7msAGjmxbffPzke999a6cj99ZZ2P/ySJboeNXdwjyzFbUo0zEZ0rJ08ZBlGr5MTb/F6Tf2fQ6rX97R81rEJj/7ElPqCbZs/cTynrFzt+F2KysLuqrp/ghvXFcZqII+adsAD5qgvhYg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB3137.namprd12.prod.outlook.com (2603:10b6:408:48::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 22:14:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 22:14:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [PATCH 17/19] block: pass a block_device and opf to bio_alloc
Thread-Topic: [PATCH 17/19] block: pass a block_device and opf to bio_alloc
Thread-Index: AQHYDDwKKixcCpXXJkOK/9EcGjgKbKxpWP4A
Date:   Tue, 18 Jan 2022 22:14:17 +0000
Message-ID: <8f26d2c5-2ff3-68b6-c883-567f16bf57f8@nvidia.com>
References: <20220118071952.1243143-1-hch@lst.de>
 <20220118071952.1243143-18-hch@lst.de>
In-Reply-To: <20220118071952.1243143-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75e5db58-c69c-4913-1bdb-08d9dacfde4b
x-ms-traffictypediagnostic: BN8PR12MB3137:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3137697F3560C2747A23B819A3589@BN8PR12MB3137.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIqHevk5Q31Y018/APuyJpjCvc4MuP6L3KNxHsB+Syf8GhPUFnRb4242wipQ1DI1RsTU4V54nGmIo+fAuZjOLjf5Pfn7Ts0eP+oQSv1VFAdxzqLbnWMkgOMg3hwu+EBIy+W68t6lTAjUx80fJexTwkfKez7tAsi9/CRYnlt+ENXdSbxB6wmVNAM14GzEu08fhq8QOptJZLdNTJdBlVuxtO/pXP7W+oa404XHe04q1+ffpqbqdl/LHoScD4jhYJgbUcU0SKuv88xzsagktB+Zsko4RRXAo3ajeOUH3uFx2gGu8m7fjo94WFwC3FSaxrzwRDtaMtlrRUVxdm1aMvtUH3TsmiwUqIMAnl4nq8RQuB6WhPOLqAqp6w2U5LlrPCF9LMIi9jljq89ki9z6vxvhznTyCEMuCjrM+9TkhATWC994BhW5We+zeDPtaLUkyUq4pGTRo8rIzhG4XwIHcUPvS+6efN1aJkptQ4ZeP6HgROe4kXrYOrSyqqy1zdjZaDsM9iD0yGiiEYAVbwWVcRDQdhrleHPYPDylICN9MuNWtczNc45pjpBCsr3cfNt49PLZ/troYdp8G4XZ52ojWPCBdljlg39kyGIwHeyyzQSyItNlFTV3kCD2uUmvrmGb+pXMVN90QMPGo/r5qbYelnGd9H0EUG4Qm7sGID5xaaMROVa/PyAkqwiShdFFwBsp05mTun4OUw2bpu9/VqXltw8ZZz7VOsOCN/DF+has09dU8Dfu6NU5lZGxK4V9UOSVATsL/gS304qwNaZqLnqYwXE5ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(4326008)(66946007)(6486002)(38100700002)(76116006)(6506007)(7416002)(2906002)(53546011)(66446008)(64756008)(38070700005)(4744005)(83380400001)(71200400001)(122000001)(5660300002)(186003)(66476007)(91956017)(6512007)(508600001)(86362001)(31686004)(31696002)(54906003)(66556008)(2616005)(8676002)(110136005)(8936002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDQ5WWdNeGxDeVc5TUd5cnRpejJzT1kyU2grZEwzaHY0YlB5QnJMYUNDZVp6?=
 =?utf-8?B?VitPcHlLZnpSZzV1ZWlVZmRJME9YelN6RytWSGd4K2lvMkQ2MHpJSHZuYzg4?=
 =?utf-8?B?MWwvTlZqNlQ1enV6MEkya2VsbTdyNHdoRFJQMnlsTzRxT015aWV4S3ZYS2l6?=
 =?utf-8?B?WkU0Tjl1YVNIdGJKclZ5UkxVUm5ybW5WT2pIdHNBNVFiUmdyRHN6Unh0SEw4?=
 =?utf-8?B?Z0dNaGkwQk81S1QxZCtKcDVYUHlQZGFZa0xrZndmYlRNdFZvUWN6YUxmaFRn?=
 =?utf-8?B?UklyaFl1NSt2NlZFSzF1VVJsb0NYN0ZETFZ1ZTExZ3dJS2tsOHhyQUxyT2d2?=
 =?utf-8?B?aDMzREkvekhTUlYvOVlYUGlsUk9BK3pRUzFFTElIMkJTWCtiZklSSVUycXhO?=
 =?utf-8?B?YTYreVFCRkV5Ui82UUV1K280VGp2TEVsVFpCaVErTCt6WTZ4blJDMlcxTVhy?=
 =?utf-8?B?UWJ0emNEZHFLbklHVitzRVdlRitMc1VFSDgyeHR5VkZNL2VlLzFVUklSVjUv?=
 =?utf-8?B?cElrVTlWRmZ0cTlFUEtLOWMzSDM5K3JhSHRsWTk1a3gyR1ZWU1ZObkJDNnR3?=
 =?utf-8?B?eTgvcVBQYkNMRjV6Wjd0R3ZMRkhMbmdEWnFibEtBbG1sQSsvenozd21OV3JU?=
 =?utf-8?B?SHlrckNSQzFkU1RzOUpoS0pEYkJsazI4TGE5WVNHcDFXLzZDM2lnTXI1YUUv?=
 =?utf-8?B?b3JUaUV4UnFvWWNhbDhETjZwaGJ5UTJCZlZ4VHNKZE5hVkxzZVMxczI0MGRM?=
 =?utf-8?B?WWhiMElnRHNVYjFoTnMxTWZHMGtrc3RZUWh4SEdBL2NBRmhEUm9tWncvVzc2?=
 =?utf-8?B?NDVDUHNnWUJJd0lBbGsrNW4rUE9QbGhZd1pDNkdRRjFZZ0FiUkNMcEZCbExO?=
 =?utf-8?B?ZTJUNU5TZU4vRUlSbGxBY0ZvemR6VE5pMTE1UGxhLzBtWmJUampnSUE1cXp1?=
 =?utf-8?B?YUx5SUwyVFNZeVNIT2dkU0Nwclp0cHJXSW4zb0l6WWFSckR6eGVxMyttSjhj?=
 =?utf-8?B?TkhhK1d6MjhMNzNiZ1VGNFVUcHFMa2tpU1dkL1RYUnRJRG0vS1pGVm4wbElM?=
 =?utf-8?B?VXpoaFlSazJJekJsYXRjV1h4MGZZejlacTJoeC9JWFVQZW9KeWIrNldudEs4?=
 =?utf-8?B?dUNOYTBMbm1FOXk5S0MyYkxyMk42RkM4RFBXZkRRdG41bVM1Y3ZUYWVuYzdQ?=
 =?utf-8?B?ZE5yamw2WWFyTHBJemlwcnBNRkdQREpkWDEwRVJwMWQ0cmY3dmZxV2d4Y2cx?=
 =?utf-8?B?V2lpa0hSRjJpdXljMUFQelJLWDBnSHlVSDEwbUp4QWlaN3huNGhmb05vejFj?=
 =?utf-8?B?Q0tFL0lvejNvTFNpb3hPUWFNSGlCUWFPT1ZzTFQ2R091WEJGa3Z4azN3SjBu?=
 =?utf-8?B?NXllQjhZVEl4LzJTMERrbXdLZmlEZ3VmcUlTWWk3MDZKeDZpTTM5YWRmQU5V?=
 =?utf-8?B?K0NiVittZDNoR29Rd1BROVNNMlEzbVBOY2RDVjM1TjgzQVhiSUFmdzZtMW14?=
 =?utf-8?B?NXlnQnV5S0FNc0dzTUtqSGhwRFNrOVA0ZGk3K2xheXNpR0dETHU4VFNZcmNO?=
 =?utf-8?B?UGwwaUZtM1RJclNHOHpOVHJpSnFEV0ZGOHhXemV2VWdXZVV6QW83K1ltR2RE?=
 =?utf-8?B?NDBaZW1UcVNVZEZwNEVqOFhpNDRXWTdZQkc3N0E2QWQveVpmNi8vYVhHeFlu?=
 =?utf-8?B?L0ZhMG9jWFUrTHJFOFNYOHc4ODJ3OFdMRDd4aExndlk5elVma3J6NFVrQytT?=
 =?utf-8?B?aE9sOStFK3pHM1Y1TUc5OHpOdEMwQUYrM0tKUnpyQUpoRTZxc2lTRHozSlFu?=
 =?utf-8?B?Nlc3N2pUZTZyMW82YlNLTTVOR0NqU0tGQk4rOXR3aEViZERXcU9oKysxTzhj?=
 =?utf-8?B?andvc2RUYmwxcEJkZDc2MTV1QTFlUWpHTUVwcTFoU1QrK0Jndm5GZWxZbE9P?=
 =?utf-8?B?U0JsZGxyZFlNTFJrWTdzV1ZVNVRTNFRRWnJNY0tNLzZiWnM1ODRCVjJ3Skgy?=
 =?utf-8?B?RExXeGlYNWdMWjhoVVpTTDEvQW44d0ZEaVFXL0hodW1ubU1pbWhsc0dta0FE?=
 =?utf-8?B?ckFqeHl6KytLZS85U0VJTFViV1ZuWURmRVpJZG5lbWNBRU02ZDl6NkVqYTdu?=
 =?utf-8?B?Y3ZCVFE3ZnJQUGRneWFTTWFsLzNsMHhpa1RGTXlReGpGZitqMjRKMW5pWDJQ?=
 =?utf-8?Q?HjS/IsDZ6Eu75zn82osp6jvH6C5xTqqRk5TiS/NKtgVK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C34C2F0A08E43545A50616A425CD9E1A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e5db58-c69c-4913-1bdb-08d9dacfde4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 22:14:17.1560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41tINHyfYfm00bMWoiZd7KQRHKf/Bl76fGX2jOjsh+lytQSuc7GElpuRjLzOF7Q/yRtVkzBmf9NVJreNENHzOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3137
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8xNy8yMiAxMToxOSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgdGhl
IGJsb2NrX2RldmljZSBhbmQgb3BlcmF0aW9uIHRoYXQgd2UgcGxhbiB0byB1c2UgdGhpcyBiaW8g
Zm9yIHRvDQo+IGJpb19hbGxvYyB0byBvcHRpbWl6ZSB0aGUgYXNzaWdtZW50LiAgTlVMTC8wIGNh
biBiZSBwYXNzZWQsIGJvdGggZm9yIHRoZQ0KDQoncy9hc3NpZ21lbnQvYXNzaWdubWVudC8nDQoN
Cj4gcGFzc3Rocm91Z2ggY2FzZSBvbiBhIHJhdyByZXF1ZXN0X3F1ZXVlIGFuZCB0byB0ZW1wb3Jh
cmlseSBhdm9pZA0KPiByZWZhY3RvcmluZyBzb21lIG5hc3R5IGNvZGUuDQo+IA0KPiBBbHNvIG1v
dmUgdGhlIGdmcF9tYXNrIGFyZ3VtZW50IGFmdGVyIHRoZSBucl92ZWNzIGFyZ3VtZW50IGZvciBh
IG11Y2gNCj4gbW9yZSBsb2dpY2FsIGNhbGxpbmcgY29udmVudGlvbiBtYXRjaGluZyB3aGF0IG1v
c3Qgb2YgdGhlIGtlcm5lbCBkb2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
