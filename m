Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADA4432E53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhJSGfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:35:15 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:19553
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229649AbhJSGfO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNuOoiNsx1/FHJsfp54axQLE/+3bN/gl9Iux9VardD19HamvJXiJTcJv0trtYVj32hVb2P+pjRe8lpZuOV3/7CstEJc36QnJjgZPV0ZAqW+KyW3fbvwdBS53uRLMk4cDxR38IiUEm/2nmgSt0wBWBvIZkWxn/+oAGGo0lE2VdyzGuGHBivMv+XtFHh0XY/iukc74D3ZAemhvwEzFpcAve3W6AfDyE+pMV2GgnK1/uwElMVoz7smLITM6hV+cP97sz5XxmlvbN2LbAs9pKKSrf4GDiOUyRcU48Z5vu+7xpAGpzN+Bs4UsBwn21WziIRK8bmvJNo/EC0DAfB6g4v5xUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2HxfBZTSi3BiVqoiVet04dkczzLVkaskpQSpA/YG+U=;
 b=gezdel1F4b1RrY9ZRyQx0khy7BUnjqBm3fXam3NrcoZ8tchV+hjPsPDJvatJCS/ZQVcFnzBwIfVGF0Teyh4xd03C9ttGjsfrQ3tivVlNway6bPJfY3PyOG365C1uRgVVSHfFuD9S8P5VitL2Al6JtTPzcixhX2sahm4glf1x4KNelos84pZP8p/oUPkKCR76I+CpQ7l22oRlLvyJZ/OyPcgQJS9LLgBXYGAdLTkD6YtnSwkhXfmMhSrUH3G4gJRek1fs8fDa491DhiB/TalGKRyoGUly/MHHSpCz8TCFxlZdfGCzZEO2vmThjiaGBiJ9vsnuuP21KVcAf0OiIsOuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2HxfBZTSi3BiVqoiVet04dkczzLVkaskpQSpA/YG+U=;
 b=uLoSshz8N1uCxxYuEAegD3ybkP9e9o96mItwTaeWWXyccGXeoWa0fAWfJS5toPkH2vY3o90uSR52JVh6kLmeVoyLSWPlNN1n9nU0m9Q69OOmIIk/KZgpw7SxoUPtWtf59yoej/x9TS0naUSuv224ayaJynHudO6eQvGYbGCcL/xTkzKI6kewxMVZJH5S38qvCkdD5iNz9Frd3ddzowjOauitKQ7WbUyJtOnWwO3e08QHX2kcOZGYC7Dk7IeTnuLkYPxSINbcBQSZFoYIYshqKd3CIBFBeXgmLAUsofJYcgibt4VQTjNXachMPkUcYcYngex8JtyRdMlYYr3lP6KEIg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1262.namprd12.prod.outlook.com (2603:10b6:300:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 06:33:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:33:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
Subject: Re: [PATCH 1/7] fs: remove __sync_filesystem
Thread-Topic: [PATCH 1/7] fs: remove __sync_filesystem
Thread-Index: AQHXxLIm30uqtC6wVk2XNPvmvYapJKvZ3O4A
Date:   Tue, 19 Oct 2021 06:33:00 +0000
Message-ID: <924759c1-be53-ac11-2f9d-18651a91a4e8@nvidia.com>
References: <20211019062530.2174626-1-hch@lst.de>
 <20211019062530.2174626-2-hch@lst.de>
In-Reply-To: <20211019062530.2174626-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b6fcd47-592d-47ae-f829-08d992ca4bd5
x-ms-traffictypediagnostic: MWHPR12MB1262:
x-microsoft-antispam-prvs: <MWHPR12MB1262A70062E4670879E45810A3BD9@MWHPR12MB1262.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JcfqeD73viFeQKJujuN8eDAn2extZwp90e+esAJnIeXbA53PiqTgGG36knjA2v/aDUxEWo2cNbAOGqdPS1GByd2fxpbqcUt+xi1tn+WfVj2UfjddRvw3errcNdq03TXZy+b0gbfRCC7dDDn5zgkRSJ2L3vbRiW/L1ksrtKubeI6kqZYHGfy9mYcZMDjm81oMNMlzdGOtAZbCaA6JGP1w+A/HXuExOIbVeRSSF2y3yeSKIB491I9SKJGEPLjs3ElW2jsJ0NWQLjHOIyKiMNpRB1PrhlDzh/Ll6VccbmbQP6N0vQIPcqNxpsd+vr5uy7CVSLAPGANYhm4FKUdy3hljjR16jH4OnR31YpXcLseD7mzcmXfGK/kU1s6q08fdJoe0pI1ZcJfFMQKhABFCbbhQ7DkpT0XcbxrAYCGI5pEdnt4k/7pmbTGUssDa1Cb24ps0HTcINvdsZ2UpLKpTmy+/tAXWszm2wXpvejf2JWWpWNKFouWME3BTHfT0k+TaaR5vso3AO9jHuJ3RVxQUB7y+aLoQlaErRTxd7ttimqeKfH3vRSKCbadWOhVCHrR6f7AGyvJd/v+F1CBKmShVtgWbXU70Ds2wGHlndTWNnfMkCC3SCCH8865mGMFVyOz6kzZu8CdO/MNZaHQvZyY3d3kZc8Tszq94L8GdMpA5Bw34Gzr0OlRCkGYl7ckpv0/8mqQ5rKtqw2eL0R7+t47PZlUQTjYyRgTaY+2wp8uQEkb+2ZItktJi7NvqBY1gcVPo4LIrVVwnMIiV1wO+n5BbfGpmwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(5660300002)(7416002)(508600001)(64756008)(2906002)(36756003)(6486002)(110136005)(186003)(66556008)(38070700005)(122000001)(86362001)(8936002)(53546011)(8676002)(31686004)(316002)(76116006)(54906003)(71200400001)(2616005)(6512007)(4326008)(6506007)(31696002)(91956017)(66446008)(558084003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWFHdXFJVktWVHp6SnlmUVlCSnNWQWpTNEJVb241S0IrVnhldkFHOFZlVWRm?=
 =?utf-8?B?SlZFWk51VTlzM0huT2NWQjhyOCs3Vjc3RUd1WU0wQkUyc2JYcmJTclpKMDF5?=
 =?utf-8?B?eVpwb1g1eUE5aDUzcVNDdjhaQ0NSVlJFV1dVT083NHB3OU1aTEg5QVBKVkJ4?=
 =?utf-8?B?bXh3U3BVQVBGOVk1c2piU1dQKzZWWDY1YjNOMDdueDVMNU1BZ0xiWjVkcUlQ?=
 =?utf-8?B?U3pXL2VyWWVkN3BUT2lXc0lpaWtKWlRXdS85QTZTVjBhYUtaNUdOK1F3MzVu?=
 =?utf-8?B?TGlUL21MdzVyTGltVmV0R1VlQWszUUpGdS9jejBPSExFMnNSQ1Ivd3hVT3M4?=
 =?utf-8?B?TmdseGljejRrV0hYM2xPdFpxY1pmTW1ubkhhRkRpR1VIbi9xRGNGdUw4QTBj?=
 =?utf-8?B?MjZKaCtmalY2YVhnRjByYjRWRXNnaUpsQUVlNEJkRys0VmloWTV6bU5xZENp?=
 =?utf-8?B?R3c2WDhrVHMxME40cGVEaFEvS1JWOEVYY0hzM0tpRXRUT0NQcDhSQXlFa3lI?=
 =?utf-8?B?Skh5NTRFWFljY0lXUjBmNVZYaEovRTdndDExdHF4YUR2L0RPc2UzZnY4RmlQ?=
 =?utf-8?B?RjVOdDRuclUxVm1xcVVrL2xYZSt3VHJNOVVDZW94aTNnZTJDNC9ZaGkxOXlE?=
 =?utf-8?B?YUxNYkdXRUNNVWNhTFJBdVNhTFY3bDcwUEIvK3BhNmRyRlBtb3pWbG9TbGxr?=
 =?utf-8?B?bFBCdWVlTDc3VWNjeXBWV2c0anZFZURhMThOMGxnVEIzdnJNM3YzaVliTG1h?=
 =?utf-8?B?VDJNZjJZS2hpaDNtNWg5TW9ROWdSbVRFclMvWGo3NVV1a0RaVHdKQk5kckpr?=
 =?utf-8?B?a0J2aHYvOE1WTHU1RnY2WVkwNEQ1aUxhalFUeEhqUHBCSW5WK000bUwxSkF1?=
 =?utf-8?B?Q3o1a3ZtSkMrYjg0dEdxR2FhVlZMVlRQcEVNTkhsRkpPQ2ViNThqRXFya0t6?=
 =?utf-8?B?ZVRpQTk3cldhb1ZQMkxWeTgrWStETjZJZ0NCSXQ2U2o1OEtuNCtQeDYwa0w2?=
 =?utf-8?B?aXlyZ0tVa3ovc2QwTEY3aVVYdjh6YndYRjkzZEdUWjEyWkc2U3h0TjVDZGdl?=
 =?utf-8?B?K1FFYjNnMGthNGlnZGFSSWtVY1VVV3VjNG9CaVBTdy82TzcwQ2taN0VtRlQv?=
 =?utf-8?B?YVo5dm9aRXRVVFh2MUliYkhhdUtUVXNVaWoxT0ZVWUVkSmxzUzlXbzE3RDhC?=
 =?utf-8?B?U3pzWUpiQXI5SldkU3YvSis2ZGJsV09rbVcrU0w2ME91Sm9rQ3dIR0duVW5S?=
 =?utf-8?B?bkpuVGtRTG50SXBFZmNsN095VitHSGpQY25IU1VFV1c4bHAwOVlUaTFHQVFx?=
 =?utf-8?B?RFM4Rk5xeFJYZ09YQndaeHFxdTAyZGY1dmlhNnFjOGdJV0dBNTVFZ0RudTNF?=
 =?utf-8?B?aXZKMDVKZEdsTzFiemtJaGI3RnQrQVlaY1Q3b0M1VUhOVHZaVCtYUGdLZGdj?=
 =?utf-8?B?M0dyc3JRUmVpQitxWWlKOWpqbjRRSE91YzVKMmRuQjNYL3BacWxiaUNscGI5?=
 =?utf-8?B?S3J2aVMrbVlZTTRtRGYyU1FVVnM0ZVpTZ0dTSE9HVktnUnUra3l2MDJUZjBO?=
 =?utf-8?B?ajBjVWZ1b3lnMkhUaXhkOG5qaElUM3pvYmhIWDFYN2tjY1NIaEgrcDRtS2JB?=
 =?utf-8?B?VUUwZy83enpramo4QUc4c01YT2NKbjR1M25aQjE2TVJER1NJb2ZkZytpODdD?=
 =?utf-8?B?Y3l6Qk1DRTlZcVZ5ZlloQnZOaHE3dnVzYWJRQ2w2d2lZaE54YVltN09DQmhk?=
 =?utf-8?B?UFF0cUR5SU0zbWpWMW1INFBock1tQkxmeHRiYStJOVRDY0lPTjJNbGRJeGpj?=
 =?utf-8?B?VWtheGVzcS8vK2N0NHk1NjNvSVlLbGNRd3ZjMkNYWDJJdlVpT3JoU2QxVCtX?=
 =?utf-8?Q?elYtGTzooLU5v?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C04D1511798816438A1258C6D616E890@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6fcd47-592d-47ae-f829-08d992ca4bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:33:00.1849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9E252Pi/21Wu/eLDh/sIa/ScWyUV8bFrsDrMrdrRM6Y6v01n7l7ccXlrNMederiUZvyhOgypFPLlVwaRJ5dQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1262
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTgvMjAyMSAxMToyNSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZXJl
IGlzIG5vIGNsZWFyIGJlbmVmaXQgaW4gaGF2aW5nIHRoaXMgaGVscGVyIHZzIGp1c3Qgb3BlbiBj
b2RpbmcgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4NCg0KRXNwZWNpYWxseSBpZiB0aGVyZSBpcyBvbmx5IG9uZSBjYWxsZXIuDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQoNCg==
