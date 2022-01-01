Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3592548280F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jan 2022 18:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiAARjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jan 2022 12:39:49 -0500
Received: from mail-bn7nam10on2138.outbound.protection.outlook.com ([40.107.92.138]:10721
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229661AbiAARjs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jan 2022 12:39:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHcGb7bAQU4GtsEKpYORRLT+LzzyCOtO9RzuO764OxzniCWEkVjwumxa1OlrhLE+6GzxLJ0zu0YvCp401qlBUyhZFwxyAzb85812CWf3wj+HMEHYLVqd5zUIVSC56JyqKCMy+Ti8/tZNZTdp6rlJFnnSLmDY53R24Yh0A4IdwknP3UGROA7ebhCX6r8kHvdOB1xIRiKmnZxRPfjdI4VHXiI9No9onazqg9v2aqFRniUBwWpxwPAsM4Lsg/M9MJuzkRBVJkqa2kvOUV/Y2oRZ5P0rzJYv2x8LM/slrWKgKwT4xz/W1lGjXA5KkUurrmEjiE8lYzi4f1QPVktZHz5OWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qpzJEbM1Zlbq+5E66nr/5Jc7v93UkOeM5DHe9kQiP8=;
 b=ZUNmUh0xTxefAqwbPTdNuGkCTimIpAeSuKgSxcJHsQcUgarl38ey2rRWo3Eik4rYj2Kg1tPLTml3FE4EAY450yfcHbE8wnrQLzg7ubSuvpK++DBDWEBVgRDb9EQz4CgHAqwT3qDEEQJg6gjS5D14775Ac7xIy8D87NLxH15yn6uC3bXJo/err4y7NiUQsrVlOxT5+TBbFLwlgmZNMVrEZQk25NaYTWHZPK4dp5JnWHbPA60IDdjuqTkOj0GZYspYrM5Dhx1NYOxFgo4E1QYB3gDxd+gY4iWdOE3ZWFGCNUPKiNmZGFiFIzWlx9zFxDLBgVDEpKkY4ey2os1VoT+4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qpzJEbM1Zlbq+5E66nr/5Jc7v93UkOeM5DHe9kQiP8=;
 b=drGx6Zn24Bnk/iLk9Gs6vtzV2aCMmrcLUgzwbxERNqkEGBXXKcCur6aMGqOJghesx2OhOeTVGqeanWbOIYrrvTnagLtRbNDOQRHZL45drBcBagsfKbGLWKKw+S8ILzlXvs+MhhBxxAHua+xSRGCrznpKy/fpuRyi1cEMCIqAJr0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3704.namprd13.prod.outlook.com (2603:10b6:610:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.4; Sat, 1 Jan
 2022 17:39:45 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.005; Sat, 1 Jan 2022
 17:39:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>
CC:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Topic: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xL0+EAgABMs4CAAWrGAIAA5lqA
Date:   Sat, 1 Jan 2022 17:39:45 +0000
Message-ID: <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
References: <20211230193522.55520-1-trondmy@kernel.org>
         <Yc5f/C1I+N8MPHcd@casper.infradead.org>
         <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
         <20220101035516.GE945095@dread.disaster.area>
In-Reply-To: <20220101035516.GE945095@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 168ee3fb-66e0-4d46-91e7-08d9cd4db37e
x-ms-traffictypediagnostic: CH2PR13MB3704:EE_
x-microsoft-antispam-prvs: <CH2PR13MB3704FC458E50B9EAED64E27AB8479@CH2PR13MB3704.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hPhSsXeJ7QleW8tTdRXN/iePll3iJ9Yx1DMTv5JXKLks69ohFO/VWdidnzAkg5e1l6G0jY0Qw4RUDr+JMo+iP/0cpQzLPfVWUwLQXhONQI5nLM1mhlGdTkKI8+1CmYzSTg1N+JWMGpsVa5oNaJ2v6YzJT2vZKcToOwBS8B33if0JOWCJYjhNtUx3bsM3rwdyDnFqHfTejMXFpgpZOSMrauLGmCxqvwYFQOowVMQrmZ0nn/NHyeyWiG1vLKT5rbyjGfEJWcjmAsFGPxKptatZMMjulDc4m1Ub+gXPp7WhuhGx4sS5BJjzwlC4b6KZdDXIVTym2/Pq7abFNLoCpMTA7d1AOQHJeRErtFHo7Zd9ZXn+1TkfOkDbG+U2zY1/QK8HROhTS0nvj82Dkx1IcJjDBBDDZ4ZNXNqj1HRq8FxMLqQceSdrZUj1hsSS4MvaZJJe444eIZlT5kE5DuldHjh90LC8YN80GCAQAYpEXyvMV5o7DqJleGzPxGn9cgSrwrqww+Z6eB/pUwAhODIXeO/F5U0r0OAflEjXUGyvR54qFWA7rku2AXF3655WitY6UHT8JdRCjXe6L/7Dkj+pYZknWag6iecqNtepFmG+swIHQl1YXoc8MguKxoovx+5elK2PuRKI9U9/9dEyLK1bIIKWZA/wm7corv94z79hY9Ea60wBDptP0fptVEcTk16Jp3YV1UyFvKieiYBct+GWZnq6+O+8dnUy9v8ZH2nbrnLkNZwd5LK5F6KT9vzK8J2ZvoT+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(39830400003)(136003)(396003)(366004)(376002)(8676002)(86362001)(64756008)(8936002)(66446008)(2906002)(5660300002)(122000001)(66556008)(4326008)(66946007)(6916009)(4001150100001)(36756003)(38070700005)(316002)(76116006)(66476007)(83380400001)(508600001)(54906003)(186003)(71200400001)(6486002)(26005)(6506007)(2616005)(6512007)(38100700002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTBrR0VRZTVIOTI0bTN0VFkwbWRCdFpWWktGZUtBdUIvS05yM2Z2Vy9QelB3?=
 =?utf-8?B?RzhUVmJzaEFyOGJ4MFZ6NVE2eHZYRjJMZmVkNERITjl5RW9RVC9hblNmdk1v?=
 =?utf-8?B?WU5QWWFZVDVpMitNZVFFajhjUVlqc29uNmlDd1BpVFlUemVBZlIzUG5SUWdO?=
 =?utf-8?B?OEE4OWI0TmJST1U0cjhLQnN6TFBwNTBVL09IYnlodWdsM2xkUUlpZEIrV2xv?=
 =?utf-8?B?d0dWN3B1eVJ4QUZGWmt3VXpyV0p5WENHMHN4ZTlMNUJVb2orUTN0WE42bmRJ?=
 =?utf-8?B?MkpJM0FDb3RzaDg5eFIyR2dhcWFOUEVDanZaMk5DZTJaTlhEbHFxWFBwTGFH?=
 =?utf-8?B?cDkyRkZwaCtFV3FCZldUN3I3d01iNFBCVkgwN0lTRXZoNlIxZGZvZ3dXSlRW?=
 =?utf-8?B?RXcrNlVyUXQxM1JhR1pCSmc3eVNFN3Z6enZkanFlNGllNThYd29lL21iUnJP?=
 =?utf-8?B?enkyUGp5ZHNHTjNDblVhcVBnZUJsclpGMzdwRVdHZnFhZnlZSFZPOG5pSi9L?=
 =?utf-8?B?cjFsZ3o3MHBUS1Bla0dYMjlWdldUdUNSUy9FOStjNUJ6YUpOaXZCa0Y2N3JM?=
 =?utf-8?B?MGVPRkRzU29PSU90TVlGN3p3cStWUDBFOWg4U29VVEsyVno2Nk9IMFRxMkhh?=
 =?utf-8?B?VVhKWGF1NmpmQll1K2hGS1ZBc3cwSHFFdkRmZEFGNkg0ZE95dC9sQWxNSGxw?=
 =?utf-8?B?YXF2eTh0cmQzcW5oVG1JTm5ZVUx0Rm80M3lYN3NWRkxjVnFaMDFaVmpMcHhN?=
 =?utf-8?B?MDdzSFlrU2crZElyTU5RVE9kL1JqVHZLUFpsV1MvWnRSWXVxTVhFUkRJZFFH?=
 =?utf-8?B?RW16SThCQWI3ZEVLK1dxamtvL1ZhS1BzSmhRRWRzcVR1Qk84aThhWUk1aGk0?=
 =?utf-8?B?OEVJTHUyWm15TVlYS3ZCckRtc0VHQkMxMk9xQWMzbVpuYmRXRnd1VGwyR3dC?=
 =?utf-8?B?d25rYWdXRkQ5ZmpvRDBYR0FHQXFPa2VPaFNEL2FVME9MTlZCaWpLSVRhWEtZ?=
 =?utf-8?B?TlNIZGdkaFVxVHB5bUw3YWFCaGhiSW9VeUEzRE92WENuOFlSZXBTL2M3d3V5?=
 =?utf-8?B?bW0yQUJ3QkxPME9xYlljMHpGbHJvNVdra3I5cjk3dFpGeEpRSk13cFJQbVl6?=
 =?utf-8?B?T0x1ekk3eXYyUWtGYzd0SkNtbnJJckJ1SmxIdkx6QlYrWDhmbE9xa29nb21x?=
 =?utf-8?B?WUo4ZHMxR0hIOVNxazFPcWVnbThDZ2taTVJyMldDRjNpUU92WmlWRnVwNlh1?=
 =?utf-8?B?LzdFQkRGSkJ6T0cvM1dHU21BMmloaGdiNHprRXpFc0dncXJRTWpna0dHSHdx?=
 =?utf-8?B?bndWdmFHaDg4bjQ2a1dGUXd0aHZEYnJNS25LVzlCZm1pU1AwQ3ZQcGF1VnQ1?=
 =?utf-8?B?WFhpUW9ZOEtYVmJ6dzNiS1phclQvWUxzL2MrV0swbGsxTFNCTlJGdjJHbTUz?=
 =?utf-8?B?S0t5NTVBeENKQ0J0bjlLb0xHMnk2UC92WGZ6cTVNQzBseXc4dzhkTm51WXhC?=
 =?utf-8?B?UDZGQUdlY3BvcFNFakoyZENoN0dzU1J2Q3RKL3dUVzdCVExSelMwY2w0ZVFv?=
 =?utf-8?B?d3hZLzVtRUpQZXNvZXcwejVyang5WW1ROFBFbStTai9LK3U3M1ZXZWRnUE96?=
 =?utf-8?B?U3NqV0RrY09NNiswaTNLenlmNmxtcnBoVnh2U1ZBNDQ3bnhRYUQ0dU96a2F3?=
 =?utf-8?B?UVh3VDI5VVh4L3lhMlI5VkJmZSs3WGxPRk5GaVhOMXdxQ3N5U0FaNnlyUDlp?=
 =?utf-8?B?TWxjR04vSlpkZGNrT3QxR3lCeFRreXdEWUZ0SEFJUmltam83QXQvSVIxNGZC?=
 =?utf-8?B?VExFVFFuZTAxSm55QXN0ejM0R3hnbXNwY1JUZCtIajlBM0FEYTdLM1FXWVZy?=
 =?utf-8?B?ejJkM0dFeERjc1NmNitJY2d0aTM5MXB0T0toTTBuME83SWNsRldlenVFcFhT?=
 =?utf-8?B?SUNBTHJlUUs5VC9IbGJTcFRjbWNkWHF6cjI2YUxxaTh4Q1NMbWFsTVVLYzVj?=
 =?utf-8?B?TEllaFNGemkxa1hDTHhib1JRU0phS2xxQ3h2aXZ5d1RtSkZsK3puclA3eW5B?=
 =?utf-8?B?MitVeGhFTzNMOXVTVHEwWEE4S0ZsMVlCS3NhOU41UmFaS0M0MmNnZHZ0R0Js?=
 =?utf-8?B?VkJZeXBjTjZGWWFUS1BVUGhKbWduZHRmVUpLRkRBVnFOWnN4THdaazhEVjVz?=
 =?utf-8?Q?Ym3p8j7vSY6M3LAi0FnZ2Gk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B0C5F3277851F44B363962114C3B365@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168ee3fb-66e0-4d46-91e7-08d9cd4db37e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2022 17:39:45.5874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aI1y/Ka5wL9yVhHEdgCVGoTgP9iv4gRFdC9m5hYk/kQDI3K9zy6mrabE+tWjpDdwIzjJS3sn7Ni0oD6+vDTKyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3704
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gU2F0LCAyMDIyLTAxLTAxIGF0IDE0OjU1ICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIEZyaSwgRGVjIDMxLCAyMDIxIGF0IDA2OjE2OjUzQU0gKzAwMDAsIFRyb25kIE15a2xlYnVz
dCB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjEtMTItMzEgYXQgMDE6NDIgKzAwMDAsIE1hdHRoZXcg
V2lsY294IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBEZWMgMzAsIDIwMjEgYXQgMDI6MzU6MjJQTSAt
MDUwMCwNCj4gPiA+IHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+IMKgV29ya3F1
ZXVlOiB4ZnMtY29udi9tZDEyNyB4ZnNfZW5kX2lvIFt4ZnNdDQo+ID4gPiA+IMKgUklQOiAwMDEw
Ol9yYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSsweDExLzB4MjANCj4gPiA+ID4gwqBDb2RlOiA3
YyBmZiA0OCAyOSBlOCA0YyAzOSBlMCA3NiBjZiA4MCAwYiAwOCBlYiA4YyA5MCA5MCA5MCA5MA0K
PiA+ID4gPiA5MA0KPiA+ID4gPiA5MCA5MCA5MCA5MCA5MCAwZiAxZiA0NCAwMCAwMCBlOCBlNiBk
YiA3ZSBmZiA2NiA5MCA0OCA4OSBmNyA1Nw0KPiA+ID4gPiA5ZA0KPiA+ID4gPiA8MGY+IDFmIDQ0
IDAwIDAwIGMzIDY2IDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDQ0IDAwIDAwDQo+ID4g
PiA+IDhiIDA3DQo+ID4gPiA+IMKgUlNQOiAwMDE4OmZmZmZhYzUxZDI2ZGZkMTggRUZMQUdTOiAw
MDAwMDIwMiBPUklHX1JBWDoNCj4gPiA+ID4gZmZmZmZmZmZmZmZmZmYxMg0KPiA+ID4gPiDCoFJB
WDogMDAwMDAwMDAwMDAwMDAwMSBSQlg6IGZmZmZmZmZmOTgwMDg1YTAgUkNYOg0KPiA+ID4gPiBk
ZWFkMDAwMDAwMDAwMjAwDQo+ID4gPiA+IMKgUkRYOiBmZmZmYWM1MWQzODkzYzQwIFJTSTogMDAw
MDAwMDAwMDAwMDIwMiBSREk6DQo+ID4gPiA+IDAwMDAwMDAwMDAwMDAyMDINCj4gPiA+ID4gwqBS
QlA6IDAwMDAwMDAwMDAwMDAyMDIgUjA4OiBmZmZmYWM1MWQzODkzYzQwIFIwOToNCj4gPiA+ID4g
MDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4gPiDCoFIxMDogMDAwMDAwMDAwMDAwMDBiOSBSMTE6IDAw
MDAwMDAwMDAwMDA0YjMgUjEyOg0KPiA+ID4gPiAwMDAwMDAwMDAwMDAwYTIwDQo+ID4gPiA+IMKg
UjEzOiBmZmZmZDIyOGYzZTVhMjAwIFIxNDogZmZmZjk2M2NmN2Y1OGQxMCBSMTU6DQo+ID4gPiA+
IGZmZmZkMjI4ZjNlNWEyMDANCj4gPiA+ID4gwqBGUzrCoCAwMDAwMDAwMDAwMDAwMDAwKDAwMDAp
IEdTOmZmZmY5NjI1YmZiMDAwMDAoMDAwMCkNCj4gPiA+ID4ga25sR1M6MDAwMDAwMDAwMDAwMDAw
MA0KPiA+ID4gPiDCoENTOsKgIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgw
MDUwMDMzDQo+ID4gPiA+IMKgQ1IyOiAwMDAwN2Y1MDM1NDg3NTAwIENSMzogMDAwMDAwMDQzMjgx
MDAwNCBDUjQ6DQo+ID4gPiA+IDAwMDAwMDAwMDAzNzA2ZTANCj4gPiA+ID4gwqBEUjA6IDAwMDAw
MDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjoNCj4gPiA+ID4gMDAwMDAwMDAw
MDAwMDAwMA0KPiA+ID4gPiDCoERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZm
ZTBmZjAgRFI3Og0KPiA+ID4gPiAwMDAwMDAwMDAwMDAwNDAwDQo+ID4gPiA+IMKgQ2FsbCBUcmFj
ZToNCj4gPiA+ID4gwqAgd2FrZV91cF9wYWdlX2JpdCsweDhhLzB4MTEwDQo+ID4gPiA+IMKgIGlv
bWFwX2ZpbmlzaF9pb2VuZCsweGQ3LzB4MWMwDQo+ID4gPiA+IMKgIGlvbWFwX2ZpbmlzaF9pb2Vu
ZHMrMHg3Zi8weGIwDQo+ID4gPiANCj4gPiA+ID4gKysrIGIvZnMvaW9tYXAvYnVmZmVyZWQtaW8u
Yw0KPiA+ID4gPiBAQCAtMTA1Miw5ICsxMDUyLDExIEBAIGlvbWFwX2ZpbmlzaF9pb2VuZChzdHJ1
Y3QgaW9tYXBfaW9lbmQNCj4gPiA+ID4gKmlvZW5kLCBpbnQgZXJyb3IpDQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5leHQgPSBiaW8tPmJp
X3ByaXZhdGU7DQo+ID4gPiA+IMKgDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLyogd2FsayBlYWNoIHBhZ2Ugb24gYmlvLCBlbmRpbmcgcGFnZSBJTyBvbg0KPiA+ID4g
PiB0aGVtICovDQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBiaW9fZm9y
X2VhY2hfc2VnbWVudF9hbGwoYnYsIGJpbywgaXRlcl9hbGwpDQo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBiaW9fZm9yX2VhY2hfc2VnbWVudF9hbGwoYnYsIGJpbywgaXRl
cl9hbGwpIHsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaW9tYXBfZmluaXNoX3BhZ2Vfd3JpdGViYWNrKGlub2RlLCBidi0NCj4gPiA+ID4g
PiBidl9wYWdlLCBlcnJvciwNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidi0+YnZf
bGVuKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjb25kX3Jlc2NoZWQoKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoH0NCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBiaW9fcHV0KGJp
byk7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAv
KiBUaGUgaW9lbmQgaGFzIGJlZW4gZnJlZWQgYnkgYmlvX3B1dCgpICovDQo+ID4gPiANCj4gPiA+
IEFzIEkgcmVjYWxsLCBpb21hcF9maW5pc2hfaW9lbmQoKSBjYW4gYmUgY2FsbGVkIGluIHNvZnRp
cnEgKG9yDQo+ID4gPiBldmVuDQo+ID4gPiBoYXJkaXJxPykgY29udGV4dCBjdXJyZW50bHkuwqAg
SSB0aGluayB3ZSd2ZSBzZWVuIHNpbWlsYXIgdGhpbmdzDQo+ID4gPiBiZWZvcmUsDQo+ID4gPiBh
bmQgdGhlIHNvbHV0aW9uIHN1Z2dlc3RlZCBhdCB0aGUgdGltZSB3YXMgdG8gYWdncmVnYXRlIGZl
d2VyDQo+ID4gPiB3cml0ZWJhY2sNCj4gPiA+IHBhZ2VzIGludG8gYSBzaW5nbGUgYmlvLg0KPiA+
IA0KPiA+IEkgaGF2ZW4ndCBzZWVuIGFueSBldmlkZW5jZSB0aGF0IGlvbWFwX2ZpbmlzaF9pb2Vu
ZCgpIGlzIGJlaW5nDQo+ID4gY2FsbGVkDQo+ID4gZnJvbSBhbnl0aGluZyBvdGhlciB0aGFuIGEg
cmVndWxhciB0YXNrIGNvbnRleHQuIFdoZXJlIGNhbiBpdCBiZQ0KPiA+IGNhbGxlZA0KPiA+IGZy
b20gc29mdGlycS9oYXJkaXJxIGFuZCB3aHkgaXMgdGhhdCBhIHJlcXVpcmVtZW50Pw0KPiANCj4g
c29mdGlycSBiYXNlZCBiaW8gY29tcGxldGlvbiBpcyBwb3NzaWJsZSwgQUZBSUEuIFRoZSBwYXRo
IGlzDQo+IGlvbWFwX3dyaXRlcGFnZV9lbmRfYmlvKCkgLT4gaW9tYXBfZmluaXNoX2lvZW5kKCkg
ZnJvbSB0aGUgYmlvIGVuZGlvDQo+IGNvbXBsZXRpb24gY2FsbGJhY2sgc2V0IHVwIGJ5IGlvbWFw
X3N1Ym1pdF9iaW8oKS4gVGhpcyB3aWxsIGhhcHBlbg0KPiB3aXRoIGdmczIgYW5kIHpvbmVmcywg
YXQgbGVhc3QuDQo+IA0KPiBYRlMsIGhvd2V2ZXIsIGhhcHBlbnMgdG8gb3ZlcnJpZGUgdGhlIGdl
bmVyaWMgYmlvIGVuZGlvIGNvbXBsZXRpb24NCj4gdmlhIGl0J3MgLT5wcmVwYXJlX2lvZW5kIHNv
IGluc3RlYWQgd2UgZ28geGZzX2VuZF9iaW8gLT4gd29yayBxdWV1ZQ0KPiAtPiB4ZnNfZW5kX2lv
IC0+IHhmc19lbmRfaW9lbmQgLT4gaW9tYXBfZmluaXNoX2lvZW5kcyAtPg0KPiBpb21hcF9maW5p
c2hfaW9lbmQuDQo+IA0KPiBTbywgeWVhaCwgaWYgYWxsIHlvdSBhcmUgbG9va2luZyBhdCBpcyBY
RlMgSU8gY29tcGxldGlvbnMsIHlvdSdsbA0KPiBvbmx5IHNlZSB0aGVtIHJ1biBmcm9tIHdvcmtx
dWV1ZSB0YXNrIGNvbnRleHQuIE90aGVyIGZpbGVzeXN0ZW1zIGNhbg0KPiBydW4gdGhlbSBmcm9t
IHNvZnRpcnEgYmFzZWQgYmlvIGNvbXBsZXRpb24gY29udGV4dC4NCj4gDQo+IEFzIGl0IGlzLCBp
ZiB5b3UgYXJlIGdldHRpbmcgc29mdCBsb2NrdXBzIGluIHRoaXMgbG9jYXRpb24sIHRoYXQncw0K
PiBhbiBpbmRpY2F0aW9uIHRoYXQgdGhlIGlvZW5kIGNoYWluIHRoYXQgaXMgYmVpbmcgYnVpbHQg
YnkgWEZTIGlzDQo+IHdheSwgd2F5IHRvbyBsb25nLiBJT1dzLCB0aGUgY29tcGxldGlvbiBsYXRl
bmN5IHByb2JsZW0gaXMgY2F1c2VkIGJ5DQo+IGEgbGFjayBvZiBzdWJtaXQgc2lkZSBpb2VuZCBj
aGFpbiBsZW5ndGggYm91bmRpbmcgaW4gY29tYmluYXRpb24NCj4gd2l0aCB1bmJvdW5kIGNvbXBs
ZXRpb24gc2lkZSBtZXJnaW5nIGluIHhmc19lbmRfYmlvIC0gaXQncyBub3QgYQ0KPiBwcm9ibGVt
IHdpdGggdGhlIGdlbmVyaWMgaW9tYXAgY29kZS4uLi4NCj4gDQo+IExldCdzIHRyeSB0byBhZGRy
ZXNzIHRoaXMgaW4gdGhlIFhGUyBjb2RlLCByYXRoZXIgdGhhbiBoYWNrDQo+IHVubmVjZXNzYXJ5
IGJhbmQtYWlkcyBvdmVyIHRoZSBwcm9ibGVtIGluIHRoZSBnZW5lcmljIGNvZGUuLi4NCj4gDQo+
IENoZWVycywNCj4gDQo+IERhdmUuDQoNCkZhaXIgZW5vdWdoLiBBcyBsb25nIGFzIHNvbWVvbmUg
aXMgd29ya2luZyBvbiBhIHNvbHV0aW9uLCB0aGVuIEknbQ0KaGFwcHkuIEp1c3QgYSBjb3VwbGUg
b2YgdGhpbmdzOg0KDQpGaXJzdGx5LCB3ZSd2ZSB2ZXJpZmllZCB0aGF0IHRoZSBjb25kX3Jlc2No
ZWQoKSBpbiB0aGUgYmlvIGxvb3AgZG9lcw0Kc3VmZmljZSB0byByZXNvbHZlIHRoZSBpc3N1ZSB3
aXRoIFhGUywgd2hpY2ggd291bGQgdGVuZCB0byBjb25maXJtIHdoYXQNCnlvdSdyZSBzYXlpbmcg
YWJvdmUgYWJvdXQgdGhlIHVuZGVybHlpbmcgaXNzdWUgYmVpbmcgdGhlIGlvZW5kIGNoYWluDQps
ZW5ndGguDQoNClNlY29uZGx5LCBub3RlIHRoYXQgd2UndmUgdGVzdGVkIHRoaXMgaXNzdWUgd2l0
aCBhIHZhcmlldHkgb2Ygb2xkZXINCmtlcm5lbHMsIGluY2x1ZGluZyA0LjE4LngsIDUuMS54IGFu
ZCA1LjE1LngsIHNvIHBsZWFzZSBiZWFyIGluIG1pbmQNCnRoYXQgaXQgd291bGQgYmUgdXNlZnVs
IGZvciBhbnkgZml4IHRvIGJlIGJhY2t3YXJkIHBvcnRhYmxlIHRocm91Z2ggdGhlDQpzdGFibGUg
bWVjaGFuaXNtLg0KDQoNClRoYW5rcywgYW5kIEhhcHB5IE5ldyBZZWFyIQ0KDQogIFRyb25kDQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
