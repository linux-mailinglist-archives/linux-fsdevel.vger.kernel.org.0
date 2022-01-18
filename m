Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0325C49308D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 23:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349409AbiARWPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 17:15:38 -0500
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:47777
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236714AbiARWPi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:15:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt2QnJgZ2pgX4Ce6c8snCh/DgpmHXZNqY4RM5OySSUDxkGt+UzESOZFx5Y8RnXnoVwXC+jM9VxNTr8v7eWTN9eu0a1sKybNu1CRhfcrgmsjr9aOxbvvcgGA0mNSvJTn0GtYEeWXdkn24dbtxALTzboUYcXyZVRU2o/+n3xEs9ll6bvl890eJj5uLG6I5xgTDb/hDHV9wvQk3d7APLwKjc+ppbdaLOLxxvUh8V7nMum2uHfvcBrixPRl509Od7qaNoxGYxgxKlcLuXhW6ur7I0q8/KRFPogW+QjPeSbpHqnPPuijJrWEEYtQkhPrjFVguBT4t5baM/8fyNLFmsNhcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+NRM5dbEf/ywcja/WF6bJ0xMCvzgQeV/oka59TCa2E=;
 b=DLZBaT/clReMU9AuSXZvUpqJj/O4YFr74DSo6G3OBGS9LvS5cSZQYQGlqyhyDFg5tuIaS5lMn6rjyD8lTTmDwMCkVLBUu4DdlMdHvOjXVXt5ZmS8hqqxt/eWKmKkx0QT7XttZUfZ3BdKTi/P7Yn9+GcvDxgaGk7Ru8hl5fEr4DXhcqZVVH5CJj+ZOla1uXgw6G0GjdUgb+pZmFFC8uQ2l9GVMM8M732BEuQRaplgkT+DgfvNrPNfXvuezSW0ML7OZdm1BTj7CEWaV5T3yXz3ba/AB0WoR5BTyxeKIzyGcLZzAko4u6G5TZYYK+fy/JJ2GckJ/HtS4WuEviQMZDvmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+NRM5dbEf/ywcja/WF6bJ0xMCvzgQeV/oka59TCa2E=;
 b=ihulHJIy+zKFG2NtDqIiiB+lxa5r89dSuqiqrFbL/+FEFrqNYbYXH956G0GKkcA3EccGGAJ3CoODZUNR/fDyjUZtM38BKTY4DNU5xRfC19rcraeN9BRGUsGR4I3DqIwZoV6YPsaBSOAovKaqeLyPbxk7kCkk4c/iQoA3gBvoePAPaKkbfNeU66zAcb6V0GSa+j1iR6/vtwUx0xWcJuPIGv5i2wMhHRf7rVtEB68Z5yj7RSOinVg2zympniAoLpDRvwtV+B/s8V+V2lJ59lJv7F+SAyiRmwjz3QMC7CqB5yGdqmGHXdBgJdTzeFk3Zy5jZmS9Fp0LpH7KY4Xx2DtXhQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1487.namprd12.prod.outlook.com (2603:10b6:301:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 22:15:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 22:15:36 +0000
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
Subject: Re: [PATCH 18/19] block: pass a block_device and opf to bio_init
Thread-Topic: [PATCH 18/19] block: pass a block_device and opf to bio_init
Thread-Index: AQHYDDwP0FUTxCXhd0WAkIDGBDECvqxpWVyA
Date:   Tue, 18 Jan 2022 22:15:35 +0000
Message-ID: <43d7b708-317c-4dd2-2de3-dc1755c4f835@nvidia.com>
References: <20220118071952.1243143-1-hch@lst.de>
 <20220118071952.1243143-19-hch@lst.de>
In-Reply-To: <20220118071952.1243143-19-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dff6305c-f2a0-4116-c79e-08d9dad00d4d
x-ms-traffictypediagnostic: MWHPR12MB1487:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1487B7C156211F4604E38DBAA3589@MWHPR12MB1487.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SVCJDi8ZcS1n9FhIO0eir1HHemKxQQzTcac8TYXBH2eaU06/p37GyHRCxF33XoA9v/4gKrU2rTLOVbAdwEcFrVk1ZnqYaPuJkG1B6IShIA3kB957I90gfZ9SIjOMsuAkJmRKAnIvhvxfKkouV7caLF0LmA4ZmTxTYHN1NYF6Cfu86BpVzlr1xsUJaFlcu3oIzoPXyFUBkh4QGxwnAHy+t7PDE3ox2QG+QE9jUWznGKBF47bZMYNabnV+HHLY1i/bi0+ujqHqQKYUXYgzM3P96BSHf48m0PEOFnUsjlj1i8WEaXEuovnDc5hKCSnq/VYkxsSzwmSppUxdknfP+7vyuaUJ6v3J57p1BtWA/JtUeixNPpFuUK0nvdZbMqJw7EgOaGuW0IQne7xAM3zMHnfkXPXm03edwvibmaeDYtIZ7pf/DzK8b/P52zep4QFEEsSMhhVVT0ZbNKsmUKzB0kaHpCNCNr/x5cM3n3s8DIhgXMXbZJAYt66jJ9V9lUKWx0QUFhMyTQ7O3EE5tV/JHNUT4vf5XlwA0IyalWVpYU1W0apGLAZBCW19gH3ldbOw198IGQ0CEKGH3pCSrn8tO0inn1es31Mf6JNXpX2TeGuoN6XcLugQ4mbdq6h6fnSJWi2mrPcAB1WYSJic6QTopEn7/bJgoxNdbm0v2oDJUj+I22kBWs4wIxn8GC7HOIbxYz4X9tFuLltXbL8D3nRLturCqgJhHPvMoL+Pm4Q5mHK8Vgceai9GyCPMEM/0Ow7b1TAJbKEdu+EH2pZ22nwFZlvmPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(31686004)(6486002)(316002)(66446008)(64756008)(66556008)(83380400001)(54906003)(6512007)(2906002)(66946007)(110136005)(66476007)(38100700002)(71200400001)(2616005)(86362001)(7416002)(36756003)(31696002)(5660300002)(4744005)(53546011)(6506007)(8676002)(91956017)(508600001)(38070700005)(122000001)(4326008)(76116006)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVJZdVBYd0FmSEF6NFBXTFY5Tk9hc3VqWVQ1ZVZzWEV5NDVVOEdNbGlJa2E5?=
 =?utf-8?B?VXd0TmpxdjNLM1cvZVErZm1uQ283RVlNdjNraE5UaENaRmFEQVY5S21VUlFP?=
 =?utf-8?B?VG4zSCtmamtLczhaK3ZFMjNCWmhiTXpJT2dxcS9ySVNETnhNUFFIUUl4MTRj?=
 =?utf-8?B?VkVQV21jMTBNNWQxc2MxMG10ZEMrMXU2UXBWQktyT25Gc2tsWnczdTVUZi9F?=
 =?utf-8?B?K2VlcW41cGFSNTNaSDdQODYrbWVYY042a2FWS3FCWGhxK2hjclFEZmRnUVpV?=
 =?utf-8?B?RHZzdm5uN1YvS1lKb0pyU3NDN3o0TDkwSjl5N0lBeWdwUEJ6amZKR0NyZ1hv?=
 =?utf-8?B?YkUzd1hkLzVLZjJDcU9hNEpORTJhK3R5UDE3ZTFpUUc2SmNqYnFpOTdnZWZk?=
 =?utf-8?B?bVBaV2g1cFEvOVpoK0lBN1VYeVgvK2ZKWEptRWJvRU9IQnZVQWhkTU95dHJl?=
 =?utf-8?B?Yy83SzVKdTQ0MXNBRmhQMXozQm5OUFRmRVJDYmRnSGF1Qmo5S3BHN2U0V2VO?=
 =?utf-8?B?ZW5OVlFSbG9oYUhPbGduQXM5U0l4d1lOQjJiZkZ0SGpkd254alRUU3QzOE0w?=
 =?utf-8?B?NDdEb3NEV0N6TW1NMVd5KzRiczdNUkkwRU9ya2Q2RWpuSVFzYnJyS0ljREFS?=
 =?utf-8?B?KzZqYTVJajhqeXV1TUVuWTlEWEs1RUpNL25Pbi9pc2wwMHR1enZDNUgvenc5?=
 =?utf-8?B?NXdDdnYzYTNnZEwvcFhNbmg0MTlXVXNQeGdtUWkremxtN3l6VzYzL2V3N3Vk?=
 =?utf-8?B?bDF1U0pIcTBFUkFVV0htR3dBYmlyakhIU3d6SUR2ZE5VcFFicTNteXpFN3Zy?=
 =?utf-8?B?T0xPeTlpVEhTZFI5a2p1WEl3NitDUzl2SUlxL3huaDJMT1RpQzQ5dTJ2T3Nj?=
 =?utf-8?B?bTcwSTJ0SThZOHQ1Ym85VEpDN0tCWDhuaWpqWlZ2YzJrd2t0SHlUMjR2RVI3?=
 =?utf-8?B?Wi9IdzlDRFRBcjF3Y1Y2MHFUcE40RDhDTEl5b2VRMmxOdTBrM1BzdjJyanR5?=
 =?utf-8?B?cVdXRGgrUGx0T3NzdkJhdEk1UHRMbXZ3bXZ6aVFoaUpsWStzaVJIZm5uS0NV?=
 =?utf-8?B?NFpLOTFTU3IzMElTbzJBdGN2dHVIU1p3bGI1SXRLK0owSDhTTEdwSWdEdXlW?=
 =?utf-8?B?N2xoWXZGNFdncDVPQldrZG9QWmlzVTRzVkRCMEhzVDFrUC9WV3ZXU25GblQ3?=
 =?utf-8?B?SDRoNlNSRUZvQkRLNXBTSEZibXVHSGsvSHJBZVdxUUZPbnJFcW1QcjNUNWRB?=
 =?utf-8?B?NnErbjFteFkrNmhhTHZFT1ZaOUdzcURUcTZRZlc5a1crNStsUUlPZnJQM2M2?=
 =?utf-8?B?czVOa3N6WStpSXNlVHFxZjBNT3lqTG1QYWdVblluVnJFS1hoZlhXZjhxWEZD?=
 =?utf-8?B?Y1Vackt2MnUyVWhHUlV4YjBFNnRSOE1ERm1VVk5GR2VieXYvSk1lTjJJSXJZ?=
 =?utf-8?B?aGFoQk9JRzRHRnlxakYwQitOUkFveUI4cWZjdFBBWXVIc1JXTnlXWExQNG02?=
 =?utf-8?B?ZnNJcDlnU3lZUnloMFVzQzhqMTI1NVRLaHZuTFMyTC9SSkRuemhYcjI3a1h2?=
 =?utf-8?B?dlAwelE2MWpUeUtjaU1vWWxzbm9pMERmOXdCSFRYS1kreDlCUlVaeEQwUnVi?=
 =?utf-8?B?L2wxWDdPQUE0Lzd3bG52SUt5QVUyKzJ2Z2QzVTBUWUFsbWpQbTlNMDFjUFNU?=
 =?utf-8?B?TU9WQVM5UEgxUGFPNDlhNFI0dWg0dDdOZ0V1RXk3TFkwOTFpWWliU3k0UlNW?=
 =?utf-8?B?M1BidGFXb1NSOWRSUm90VVAwVWJTRFJwTW1BU1J3Y0xsbHBqU2ZXTlYwQVN1?=
 =?utf-8?B?MXNiSzRRT0VuZ0xVbHhVYWtDd2txNGd3c3ZpbFM4TkRWYk1xeHoyeDduV2o3?=
 =?utf-8?B?TnBLVnFnSUU4YS9xa1AyY1hzbU00dFBUbEZhbkVRYlNqa2RqdVIwdDBqTzRT?=
 =?utf-8?B?bFRmbHdPWEZMTmpxUkcxUGJWNXNUZFFzRmpNcGlLdjFzd1JWbnBjNmloejNJ?=
 =?utf-8?B?a3VsRjdXTThQb1QyNWw3d2JwTnNkU2lpeElUdDZaaEVCYlVHNnlkU3dwVUh5?=
 =?utf-8?B?T0FJWVlrUE1Ycnl2eW0vT3ZTZTljb3dJTTAvMGlJc2JkRStnTmRHbmlwc2Jm?=
 =?utf-8?B?VkR4aUJBdE9Tb1VTUndCdnBTc0M0TVM0b01YUU82ZVpMMGYrTjE4QUhVM0xj?=
 =?utf-8?Q?rscnqK0o0qupS9+NTKy9cIQYJCKrGdlFA5Ful94BdGp1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68497571FD293D40AE092A66BF25DCEA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff6305c-f2a0-4116-c79e-08d9dad00d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 22:15:36.0108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksLd6ZhMAtnLpZpsyVDoqMcBc8UcliI0ru2az7JqJo8go0JRBSW3C9lvIPVFu2POPBBejeAtjU6sXmExYzh0/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1487
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8xNy8yMiAxMToxOSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgdGhl
IGJsb2NrX2RldmljZSB0aGF0IHdlIHBsYW4gdG8gdXNlIHRoaXMgYmlvIGZvciBhbmQgdGhlDQo+
IG9wZXJhdGlvbiB0byBiaW9faW5pdCB0byBvcHRpbWl6ZSB0aGUgYXNzaWdtZW50LiAgQSBOVUxM
IGJsb2NrX2RldmljZQ0KJ3MvYXNzaWdtZW50L2Fzc2lnbm1lbnQnID8NCj4gY2FuIGJlIHBhc3Nl
ZCwgYm90aCBmb3IgdGhlIHBhc3N0aHJvdWdoIGNhc2Ugb24gYSByYXcgcmVxdWVzdF9xdWV1ZSBh
bmQNCj4gdG8gdGVtcG9yYXJpbHkgYXZvaWQgcmVmYWN0b3Jpbmcgc29tZSBuYXN0eSBjb2RlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0t
LQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0K
