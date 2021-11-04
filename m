Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FCB445111
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 10:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhKDJad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 05:30:33 -0400
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com ([40.107.243.44]:2113
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230252AbhKDJac (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:30:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFHPls2bubAqk3PG2Er2VafD9la9GnHllhL8JpAQ5ksZgJO+6dD4sWO1irYRd4E3xh/ldyCyC8/xdCPn5ckfldhexmwXQ61ZYz0UWe1gh6CnKwEU7Ktzu42ec7o1h3/klmV3c+rmXczOlLHZ5gZ/f6QRxsZ6pTC0zXUiRnKJ47W9neZ9LFIaXnSMmEsTz+Rgdh4gFFERQKflxkXr3YBSOlzpLQPJKyjPtL4iW20ELjvlv3juzoagudl5rrWSYrcqG9uj7pui9+u+AG3rf9JIDKqr9R2zNpOFWMocsJXqPexGxkb02nMXkNYz0JEmYJHDdfCBmm8NEbZxsCzKwKat9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3aKfWJMjB2lljbXjxxSpKU/0xkFxwUwSex5pp1ffv0=;
 b=aZoI6jn5TPHb7ww3Y4Qbe7WuR2SO41dArUIRG02CXQF1JS8GWJiFMujZJRRKibKgqfmeUrqQuBDDxnU32Qc/ks/aXuH0bnIhtsOtb/C5XpuBrSqWoN5QIB126tLf7COYjiYHBqSiDF4xsz5cHgKCctKBsbfUbJmGEFHMe9VwdzCz1d8tWLvPb37JcyQFu5wLABKcBRarEt+TOKe29cBs0DS75IVpIPDMhxgLawObx7cbZBIyVkgA08ipj8CYsjQe5b82JF3xoQNYwvK3eK6TPLS4zyWBj1N8Y9kLiG98ZMy1JJawhalRAaSPXgUhD9itcewL0xU9Me6Y8GThC1KJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3aKfWJMjB2lljbXjxxSpKU/0xkFxwUwSex5pp1ffv0=;
 b=Tsis+vKszttVjaWtESRQQp2QcOwIyJ2dH5OZt7zQlW0x+IUeH9uov1jmc/wtG1TYc7Nn6I76pzlhcU9HlNCBtD7Ri2fpV0r+le1lRUiaZqJTTlhe7GvN3HHNzYln2uagzRh3ZtnZorujNA0f7XfCdWpbD5s9G8nE8oR0PoHsPRY8yPknsd4Umo8gBWO08EqRvm2ek5puLkMcmzj65N8wpr1ZYvKtG3Pw/bXifBeQGCG3mtdIn20maIavsVJCOwJR3OBd0HQSauTbl3hruVUSpYCgzLRSgQ0+9HFAF4JFO3+hg8lYSZjZDHq0Md5PiLA7D3nLBP8S5F30aZg7PQHaZg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 09:27:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4649.022; Thu, 4 Nov 2021
 09:27:51 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Thread-Topic: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Thread-Index: AQHX0UfJUBDssfv+ckmT1a3v6/33Gavy9LOAgAAlMQA=
Date:   Thu, 4 Nov 2021 09:27:50 +0000
Message-ID: <661bcadd-a030-4a72-81ae-ef15080f0241@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104071439.GA21927@lst.de>
In-Reply-To: <20211104071439.GA21927@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98bbf12c-4ee1-4f43-124a-08d99f755fba
x-ms-traffictypediagnostic: MW3PR12MB4459:
x-microsoft-antispam-prvs: <MW3PR12MB4459BE38997B6B1FA77FBFADA38D9@MW3PR12MB4459.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yUuJ3SFWQxyY+DVgIUZjc9qGr9edCBohngI6/o4rEI6BR2MUHYgb1dq3iiGinaoX/kRNpHdn2AmOE8uz0x9bu7vvTRw71w2tv0rYE0L/UvtDSYGxcQcPKYLh6b14mMYD2QBUJqbkaXI0VXOoWHYQmcB1URlZ3FhMoZ2NlucphDBpadRn+LcU05J9DW3FeI1HUZaIlFoxsc+MN4g6KBjylX6dYh5/VJxv/e58otQ7wGWJBlJn42H5yxwxDLwb4LN3p5tny/n5nOMSNYBzk2jf0kIeUhId9JD6xO1vh9siYxSnxcSURHRiq89z8mhXfotJRCtb9QENVxyTxgoipKYTohnjJM8EG5q4ZYZNZNz6XBoWRGObJhqa08ceZjGp31gR7GoP3kC2h4ERIXZCW7Q3VJ2aSi29kc+jGksRS+iuaCqPAmUUQTltFgH0+3UnvhxBDaaFni8blGsx0MWglD61YaqFU4TS/k+rKyRCQJuKBUMd/ODSW3+fKRCRodb/VcSz52Kec/UUyRXnzaNbFHXfrMRw6X4n+P/tTGrR8f8C5A6v+iukzlFLXLB7V+5ihfblhPSmLMcmmIAyUyyD0TDKDgDrCb1fXBuVUpXPluHTU/wTXAq9j4paApcxZgkrj5OOudZL49RHQJAdJu5zbiSupCYYx3g3HplwpOJBzyoz2N3oaZUSfxN9ugJs8r880ZucZxDzakMha0l8PTBaOsL+6KfoHFI6Zh4OoqM0qSKZ3qgu5RbrfMexi/ZDtytExmi+DAQJg24NGvOovfKkNulZ/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(6512007)(71200400001)(7406005)(2906002)(66946007)(66476007)(38070700005)(186003)(83380400001)(7416002)(5660300002)(66556008)(64756008)(66446008)(91956017)(316002)(508600001)(6486002)(76116006)(8676002)(53546011)(6506007)(31686004)(4326008)(8936002)(122000001)(107886003)(2616005)(31696002)(86362001)(4744005)(36756003)(6916009)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmJST3dsZU9qekk5OWFZYVRUMDlEUUVic3dzNUdHRkw0dVN6UjBvZlJ1K1FT?=
 =?utf-8?B?RXo5cU5pYVVSNnBXTGFHWHhyWC9kZjU3N3hyRzNIV3VFTVd3VEY1OHVDdmtt?=
 =?utf-8?B?YVMrb1hacm9FTjd5WWpDbzdLVnR5U1BSbmw1SjhIV0ZIVVRhaTRLY042RUJy?=
 =?utf-8?B?M1hYQ0ZZRXI0ak1PWEJ1bWE0WCsxd3dJMkczUFp2aGxpSi9TdDBoTlRkM0FW?=
 =?utf-8?B?K3gyTWNUdzJrdzRlSTdSTzJOYTRlUGVBSG9LdmloejkrZGNkTXBlaFJ3ODRk?=
 =?utf-8?B?RVJKU0J6TnVJS2ZvK01BejdUU3QydHNUWkozYjZIQjlINXp5VUR6UTlNeFJN?=
 =?utf-8?B?QjNLZk11OUIxR05RUXN4d3BlQ3ZOZ0xrR1JQQldiNTVkRHdOc3lrUUFEelg2?=
 =?utf-8?B?YjRUb3VrN0lxTlFyMHEvWTUxLyswZ0hvQkFGRFl6QlppMTFBajZ2bm9jSUh4?=
 =?utf-8?B?QkN2cC9NaVJ2STVHWEs3bEZQcmNwU21qeTNxNjd6SEZFK3ZRM2tGa1JDVW10?=
 =?utf-8?B?UzZFTXY3UmErSFNjNEprdU5nbnZ0YmxETjN0NUw1OFpVZU5yd2lWbFhNN3c1?=
 =?utf-8?B?TUxSckF4Mi85RlpTbEQ4dVhCcWtVUURLa1RVYmQyNkxJRVBMSXRBV3QwVTgy?=
 =?utf-8?B?SzM1ZWhPbW5aN0k3enNVSmJiRjUwTEJ0bUZTVGV2NnBmRUJwemlTSzcwR0s0?=
 =?utf-8?B?RUxpdlQ4UDhzOHBDaVdwS3NKblZLdDZHSCsrWUlXTGx1WGF5a1ZRWXhIcmRQ?=
 =?utf-8?B?ZCt1dHd3SktkUzUrYlQxbHQycWM3N2Nib0crRUdRb0pxWFFxMFI1VitiWGxC?=
 =?utf-8?B?Yi85V1F3RlhDdkVxS2JPb01PZXBTV2V2SHpqcDQxQnBydGt5QmkxV0UxUW9i?=
 =?utf-8?B?R1RyZGRsM2dzTlo3YStZZWQxbm11SC9RMWlVVU9Kd2x4QmJDU2JJMGgrVGZu?=
 =?utf-8?B?UWRtL0VSeWJQdWdJVDhTRXpSYnJsQ0NRY1VzYkhtbHRWempZdmFIV0gzVlFV?=
 =?utf-8?B?WjNwNWtyTG9GRVhQRUMwdVdlVG1icVdRUHVRYzNjaGpZZjI2Z3dMa3hXcTJp?=
 =?utf-8?B?TXhBSmsrMzlmb0gzTEpnZnFqV0dHa0hOUnlDcWFUN3dFazI3RVZiTkVwcERV?=
 =?utf-8?B?K2xXclhmeloxS2ZWRk9zRld6bHVBcDlSVUdjTjBtZ1NOQ3prVWorYmNycTVI?=
 =?utf-8?B?RXhlTUFGOUlkK01hUHV3Y04vM21EUFZ3bS9Qbzl5L1QzdWo2d0dnVlFIbjh4?=
 =?utf-8?B?M1lYclJialBqeFdhbFhMV2IxQ3lyRjJjeHg0MkIzYmtCaDl4YTRMOHcvdHVB?=
 =?utf-8?B?TTJqU2hSWUIvczIrOFdCUmRENDZYeGZHVGpqWUYrM09LUU1lRTVIVVJHUExr?=
 =?utf-8?B?NXVlMGF2WHNsZDhJUXIzQjZXVDBqQXhpVWZEYWZSVUpReXNkTjJ1Sktvd2lY?=
 =?utf-8?B?L0hNNW5ydTR5LzlaV3ZKU2lLTlVyaWhZQ1lYdVRWQjc0akI4TFZnVXd4V2Np?=
 =?utf-8?B?SkdYN1llV0dLS3dtN1hjRmdlZnZ3cTFrQXpzb0U2dDVqYlc5WG5oWmtXT2c1?=
 =?utf-8?B?dGhTK0hySmRHZVNVbTNpWDk5K01nMTlGYkloUFFheFNGREVRMllNOFBTbkQ4?=
 =?utf-8?B?ZzlYSVoyOTM5V2t4Nnp3SEZqWTMrcSt5cUcyN28zT1lDSG1rMHUybjFXREZ6?=
 =?utf-8?B?M2t4bUFoWTBCamRUVWliR04rZS84K0wyVGdNK2U1QmhiSHIydllPcnZqdEpj?=
 =?utf-8?B?SWtiR0x2dUxCSVZyMVVVR1N5OXBwbWxLY05zckF4S3FQTjNzOSsyeEdVRHRs?=
 =?utf-8?B?NkFsOVFxa0RkcTREbnU5VUs5NDJFZVNXMk96MXA0RS9WNVpVZ052dlR5Snl0?=
 =?utf-8?B?bXM1STR2OEJFajhBalBoSHJUbkVvRjlrTldORDljYVdLc0NaeE00eWZwb0Vy?=
 =?utf-8?B?NTBod3N0bFZIbnVJV1R0TlZMNWswWkp1RUZjTTM1RDBjUlZTc1V0L1dxL2hF?=
 =?utf-8?B?Mjc3Slk5czBvOEpDMlJXcHI4TEZNdm5naGplSE5SUjVCdEtuamthRkkramhk?=
 =?utf-8?B?eVFCdEJRRlJPK21OQzhmUW9oNm5XeTI5Vm1OanVlbWM3c3FlQTMxcytneUYy?=
 =?utf-8?B?S1RITEozNEg0ZmM3VW9VUjVsTTd2WWVNS0hsM25VSFdsVjRlQmNoVHRmeFZW?=
 =?utf-8?B?clNZWGw3VnF0WGRKay9nNnBiY2x5ajBYaDVZRnRxMzZjVjBGa2Y1OSt0bEta?=
 =?utf-8?Q?+/b9t9uwkegYTRi/sGMO5l83UZc6IsmnE8gSXGHbwQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <868F285F0B210D4A90A01CBAF4B97880@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bbf12c-4ee1-4f43-124a-08d99f755fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 09:27:51.2077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8nQ5+lRSp4ubli4CdCcciY7LidSaFe1BKx5lA48eybEv9N7DUFAnuG9xy43f9xKGZ8B9qCvmyvLQrd3IYx9/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvNC8yMDIxIDEyOjE0IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gRXh0ZXJu
YWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+
IA0KPiBXaGF0IGlzIHRoZSBhY3R1YWwgdXNlIGNhc2UgaGVyZT8NCj4gDQoNCk9uZSBvZiB0aGUg
aW1tZWRpYXRlIHVzZS1jYXNlIGlzIHRvIHVzZSB0aGlzIGludGVyZmFjZSB3aXRoIFhGUyANCnNj
cnViYmluZyBpbmZyYXN0cnVjdHVyZSBbMV0gKGJ5IHJlcGxhY2luZyBhbnkgU0NTSSBjYWxscyBl
LmcuIHNnX2lvKCkgDQp3aXRoIEJMS1ZFUklGWSBpb2N0bCgpIGNhbGxzIGNvcnJlc3BvbmRpbmcg
dG8gUkVRX09QX1ZFUklGWSkgYW5kIA0KZXZlbnR1YWxseSBhbGxvdyBhbmQgZXh0ZW5kIG90aGVy
IGZpbGUgc3lzdGVtcyB0byB1c2UgaXQgZm9yIHNjcnViYmluZy4NCg0KWzFdIG1hbiB4ZnNfc2Ny
dWIgOi0NCi14ICAgICBSZWFkIGFsbCBmaWxlIGRhdGEgZXh0ZW50cyB0byBsb29rIGZvciBkaXNr
IGVycm9ycy4NCiAgICAgICAgICAgICAgIHhmc19zY3J1YiB3aWxsIGlzc3VlIE9fRElSRUNUIHJl
YWRzIHRvIHRoZSBibG9jayBkZXZpY2UNCiAgICAgICAgICAgICAgIGRpcmVjdGx5LiAgSWYgdGhl
IGJsb2NrIGRldmljZSBpcyBhIFNDU0kgZGlzaywgaXQgd2lsbA0KICAgICAgICAgICAgICAgaW5z
dGVhZCBpc3N1ZSBSRUFEIFZFUklGWSBjb21tYW5kcyBkaXJlY3RseSB0byB0aGUgZGlzay4NCiAg
ICAgICAgICAgICAgIElmIG1lZGlhIGVycm9ycyBhcmUgZm91bmQsIHRoZSBlcnJvciByZXBvcnQg
d2lsbCBpbmNsdWRlDQogICAgICAgICAgICAgICB0aGUgZGlzayBvZmZzZXQsIGluIGJ5dGVzLiAg
SWYgdGhlIG1lZGlhIGVycm9ycyBhZmZlY3QgYQ0KICAgICAgICAgICAgICAgZmlsZSwgdGhlIHJl
cG9ydCB3aWxsIGFsc28gaW5jbHVkZSB0aGUgaW5vZGUgbnVtYmVyIGFuZA0KICAgICAgICAgICAg
ICAgZmlsZSBvZmZzZXQsIGluIGJ5dGVzLiAgVGhlc2UgYWN0aW9ucyB3aWxsIGNvbmZpcm0gdGhh
dA0KICAgICAgICAgICAgICAgYWxsIGZpbGUgZGF0YSBibG9ja3MgY2FuIGJlIHJlYWQgZnJvbSBz
dG9yYWdlLg0KDQoNCg==
