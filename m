Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8A432E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhJSGgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:36:31 -0400
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com ([40.107.243.44]:60654
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233540AbhJSGga (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:36:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWqay5/OTQTUE0xqioS84Fkb1wVKj/T3J9t+J+UcfDQ6By//tinEqRkSwzfmL+l0DyLI4GZHldU1JQLE1aRQAy6Pe2yVgXz/Xrdjoeax9m6N08DzHKAaUYfExYnUtIkt2wcfPjTbc5OMGJWj+scOCp3o+PlEroS1ZkahaOpH4EcsBgfA14lRGyy50YNPqSaE9eAFehEwVaJqjxhR6ULkZQLH1xhld2wiZCjJF2/wJ/ZN/WsRKMJrW4ic0aubE3CzY/vUF/+jAqU0DN0k6Q9Mc1jI/6+1mxIeSj29skQYQxNtDAMOavwX99AVZAOO0FXhyfpv4rbBkWKhmzUO01ZZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGeftFVmllChdrlBg622+mYWtlVrvDYxEqmAQBvD2+8=;
 b=gwCIj6p3HRIwXdhGemke6fga0/MvPP8574dUSNFo86rNrzNTiBwv74B0AIutHKHC0GmjbbHsYeVnCSqT1wfH8RXKhJ+R+1TTKOtdo35uWD3x3DeRRvBZfkVzUoa+xKeucODcoYmv7mO0M2RmS0L5doqtYKurHc3edXhMKDlIYON3aV4+9VDQXa3h3cYsNum4WpqMhdPmdayXT19i5V6gr2rFrrj51GHpXEHszKQwvTLCGHZcozRpbGFV3edeK/oD0bIU+E8EiOcBNJmrEEgmV9EPJfvulrDjWya/5URHHXo8vNBkOVRyXsuBYwYlmx3NnBKYh0dSaaq14ZRihtdavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGeftFVmllChdrlBg622+mYWtlVrvDYxEqmAQBvD2+8=;
 b=msiiaE4C7vGEtJbvhBLwnrmDYBMz/QLqIa7fHHJ+0W1u62w1/6Pybc+p6eTFc8gajnnt4kaH5xnIdxA6J3Ejv9IuhqX2+kf++xAOtr/SNb96w19FX/cdEbwYc6SqnZQk8k1fzJtbbuzA+gABrCl3dufzsvNNFKqGORkZwndlDxs5fzFwOqL5zVLa7Q3IRM2azIyhA7b3pLPIAM2hf0qkTjfNyQ3eqBs+GJ7a5Cec6A6HmTsNIT0AdjQ9/p6mmo1kw0Wj03IdTHkudSwCVL6f04JFNzwMiJpwfTNdN2eRaqByh1+HAIRO8TGXi0XOlGRq0xpXlc0Zi7L8+m3OKt9UyQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1262.namprd12.prod.outlook.com (2603:10b6:300:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 06:34:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:34:16 +0000
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
Subject: Re: [PATCH 4/7] btrfs: use sync_blockdev
Thread-Topic: [PATCH 4/7] btrfs: use sync_blockdev
Thread-Index: AQHXxLIzGX9IlGUCzEq8AQPwrekYtqvZ3UgA
Date:   Tue, 19 Oct 2021 06:34:16 +0000
Message-ID: <6842781d-bb01-0f56-61e0-944cf24409c3@nvidia.com>
References: <20211019062530.2174626-1-hch@lst.de>
 <20211019062530.2174626-5-hch@lst.de>
In-Reply-To: <20211019062530.2174626-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1367a1d-8eb1-4fab-3ff5-08d992ca796d
x-ms-traffictypediagnostic: MWHPR12MB1262:
x-microsoft-antispam-prvs: <MWHPR12MB1262EE72E5A3050331F928C8A3BD9@MWHPR12MB1262.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f3PR0TcO4MSjfvSW7PNcETaSNPL8Zeng/f3v8Y2/fTOXg2IcZQXoS4lv5mVwaSPSDcF1vNXbEwQRDWk/Kj8AwYEg95aLwIUtaASu7DqN+DVI7djEKhsExCBKlDTuTjLdf+Sp7OxoWelqVeyIIDv1YpKjHKy6q7T724/M7J48i7+VczivgByy7k0HCEHDYuyhqHvcviZnG4aVuT4UohfMw9RlnGMoblj/+Qo+PWSdpevnkDU746pH5095IAambayLf/799hVmewesjtFsycgrp7wl0zTdGX74Spwip4XAF6/1DEDE99vzZlYVS2bo78ki2eGxndG4DapljQKqEtD1xh2VsNX/rYnyNwCOijXXVeacuzOa5hocwxZNDVhpNzYIh0U5kSebSrSB6TvHmRW0m0Nxi5/AO31flrQ9BpXoPGxRLJoixLX8VjhmisBH/ZsRETL9mD09GmDHXf0YS5sD25AJf3tzn7rY8H9d7EIAFikqN7O8+r3R9Jk+EHIfkpzYJerDuyyIfCo5qthPNu4GKbF7ik9EpdJY3YlE50QqaFt1FMGxAApNsIkZUs/hANlX4uSUcoHEfZ5EFawYLn3vw94IRtNwY5CwpUYvoDb3P75DVM+0vFi+ro8BavhExU9prhNI90t2HtX0aq3HJpmJ7V45UART/y8iO3ng14jFRPE0fe/wi0A4dg7Si30ZtyI6Uqwz21/A3tXD5RAUaGvjaplkPwsMBPxTcqJp2dz0FKqlyLR8wylouR0dx1+ZOoYLCgjgR2glSd0ujTaQGUyIfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(5660300002)(7416002)(508600001)(64756008)(83380400001)(2906002)(36756003)(6486002)(110136005)(186003)(66556008)(38070700005)(122000001)(86362001)(8936002)(53546011)(8676002)(31686004)(316002)(76116006)(54906003)(71200400001)(2616005)(6512007)(4326008)(6506007)(31696002)(91956017)(66446008)(558084003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGVWUFozcFVsQm9tcWs5N0pTNlNHSVo0dHVydk1LMktiZ0Z0RkpEd2R2ZG5n?=
 =?utf-8?B?cWJwTi9jcGxreEMrRXJZdGRZdXZCVjZnOUFvMVBGTmtCT1EreDc3bXRBa0JP?=
 =?utf-8?B?Mm15amdtN3hvU0NlV00xMEdQM09VbzErWEU2R1dieE0yMDg0Zk54L1haTTdx?=
 =?utf-8?B?MnBtdDlPdzU4RkFpeGRja2lNdjRYU3lDYVpSMkhLT1RHazA4djMwZjFINWN2?=
 =?utf-8?B?QjE0ZzNXRmw2UW85UU41OEI2RTFCekhpZnJtcklUZE9JUDdFNjhCL0NVSjBv?=
 =?utf-8?B?N0M5aW94OVJwTzRYcEIxN2F1YjZpVG5YY2VsOXZ0d3pXM2FlMEdkdnRwMXdM?=
 =?utf-8?B?WkNHWmhQYVM2S3Q4d1l4azRWNGUvMU1Sa2dlSnJEcTlhc0QyS3Ivc2krWXBJ?=
 =?utf-8?B?NlRWQzFYTDhRNitoclI5eGdZZlUvcTA1Y2UyWWVENjExdnZ2UjZ4azhzdm0y?=
 =?utf-8?B?NDYwMWYxeGlLbTcwamQ0ci9jcVYrZmVraFl6M2IvdkZaam8xa1FmR0d4bEtR?=
 =?utf-8?B?bDJjVis2b0I2V1RyNzJNQ3h0Mm9DdVB0UEZIRVRMa2w0MVZ5T1grRllQcCtJ?=
 =?utf-8?B?Zng0Y285eHYwZG5iRzl0cmQ4T0ttaXVCTW02YlpuR2NERnNCQkJaTVNyak9j?=
 =?utf-8?B?bWtLZC96bm56TDluWTFiajRiVTA3NnE3aVdnTDgrWi9Gb01UMWRzM3gzSHpw?=
 =?utf-8?B?b0FtTFl5N1V5RmprYkpmNWZVQ1JZenh0Ums5dTlpaVNMeTJZdmNKZlYrSDdW?=
 =?utf-8?B?elc5M21UdFFyUEdvVVJoS3RvRHhvdkhERWNqaFIzV0pscm5Gdzd0cjVpTmVq?=
 =?utf-8?B?VWhPV2ZRRFlBcjcxa0xoVUZxckVPQ2tyOXp2UUNrWG5hTmprWW5BRDdTRzBq?=
 =?utf-8?B?UkRYU05XSXg5dDJIekUvSjd1amEvcmEycjhKc2tKTXEzc09FQ1orekhsa1FR?=
 =?utf-8?B?bXpCaVl5aEZYZXd4cGV3M0JPQjBlYm1TTDU1YlBtQW9mUVNRSy9EMS9Kem1O?=
 =?utf-8?B?ajBGc1BiRXJDWllIenJTY0NRNDF3OFdEUTdFUENoQ0p1Sy9PeS9mUnFTNWFQ?=
 =?utf-8?B?Uzc5VEVwR2hyRnZJQjR4Wm16b0lyOEVOK1d0QmhMTTAyL0txd21ZSm56RmxB?=
 =?utf-8?B?VitGcmU0UTZJTnp2YU5jU3haYnpMN3BZNFhueUdKYk85VUxTM2VxUjc2WWM2?=
 =?utf-8?B?NlFNNzhLdVpkTjN0RFdRZlo3NktRTGtiRThrcm5YQTU1NmFCeGZXMjdFSVhi?=
 =?utf-8?B?OGsxSUFGY0VqWStXT1Z2MEFJbXp2ekloWlJ3c2xlS0hDZllLeVg4eXozTnlq?=
 =?utf-8?B?WFBhQmttK2VCMXA3UmQrMm9OamQrNW1vZFRtN1lxWDJUNEVSUVNBaHVHRmRC?=
 =?utf-8?B?cnhGeXU3bUJSUlBXeFZSenVVV0VnUHo5QzFNWjhZWTJxYmZlQVdZZTBPSlRo?=
 =?utf-8?B?ZEozdGxXeDVZQ2RURnZlUGVudDl4Vkl2VGluRXIxNnorZTJzam96MVNJUmRy?=
 =?utf-8?B?b05BMVFYVmZxWldmUU9udnIySUhPell5YTlxTW9UNzFsd09hU2pJMmsyemJn?=
 =?utf-8?B?aHhyK1B6QWR3LzZrQjkyckxSUjFpL2V0M0xsWGVFckZSZFV3QWl3b1VlN2JV?=
 =?utf-8?B?QnZMMXNZZERuc0NsQlpXdEtib1JuakNTZG5BM2hubjZDaGszVG1Hc285N3Ex?=
 =?utf-8?B?U1Y2OFNHZ2gzMHdGQ0RKVUt4ampFM1lCMnhINEVJQUd4NFd4RTlVQ3VmWUor?=
 =?utf-8?B?Zm5KeFRid1BBeFp6Zi81bGpUQXM0WDBQdVpDQVpVcGxad0E5T3Y1Uy8yTFNB?=
 =?utf-8?B?cVh1SkdVNzZJRDFEV3RGdFM0azhZcjJacEFMMm5CUnBnUlVUZktkdENJQk9C?=
 =?utf-8?Q?1daHdeCZdvm6b?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DCF089D89ECC34E89C06309AF18F139@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1367a1d-8eb1-4fab-3ff5-08d992ca796d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:34:16.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0o6ag+8hMxviGYgKOlR9X2tVwTjEtf3KJ9e1PyUh1e7chwjODKdzfJsaCT2zIKDD22YXlRNveX5YOecFnx+rBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1262
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTgvMjAyMSAxMToyNSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSBz
eW5jX2Jsb2NrZGV2IGluc3RlYWQgb2Ygb3BlbmNvZGluZyBpdC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==
