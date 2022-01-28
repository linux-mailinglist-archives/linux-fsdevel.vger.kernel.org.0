Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4349F5D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 10:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiA1JBD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 04:01:03 -0500
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:59425
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231759AbiA1JBC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:01:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAkG249wGlilRIMZ/I3fj2AGrGN0+ypcYv8JKBgLu/MSDAOdnb+3PTpGCkDm9fQcQWVTpCcs3lO3nqThyI/Ez8MRwKm77iR9HvykEmfNby6s07EzSjYC+uJtgnnrtVQIH9Ob5zKJiReiOzOZfZLqIj6IYfviNtITI0BgcJuDJ2M+Q+2I6aiXoKXQsJBGh0Ivrqzdgkhz3OLah+p991gL82v+wb9wECpL/e4n8fX3KyfE4zsoRD51tH3F+jDhcqgAmfWY8ljqITT1aGqXJRN8BJgF3PAtcH6yOAqprkduv/u3Gd38zaP0wZiwFNUGzat7PgZ5u076FDxmtgVUdP+3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keC7JQW2R1Nmb5gwg1S44NG+L1lF5wJzTLmXBeXNEZE=;
 b=iOiGPztK0nP0EzjevUvyXIPoFrTc7OFtuP6VtpCJ0dHDTs3+jzIJeOWlz9YBa3Ba96xBnIEN0sJ6f2UGHcmcURDdDK7BsTr+uDAYkk8QzBUDecZG4w3i9NAoSiMDwJBMoKs3ROPVuMlr3ZypZDd+rQifI/7YCpIHJLNRhI9s/8KDCEpatKjGsnZabba03BazvfzI6BT/zXUUwdrvUtHVpaVNywJUrZEMwHeORYjONBxpZtul2Qaf3DlBPMZFQBj7SQFOUKXYEF2VC3CBxfkl2HpXzekHffnitLsE3O/gcBeCZQsDb4MTRD37jQLzLIwAG7FoPUH5TjCSsLSlpaoKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keC7JQW2R1Nmb5gwg1S44NG+L1lF5wJzTLmXBeXNEZE=;
 b=TGs+zAu0qrz4dm75juKEcDjbX0Lig+tQ4IOBv9p6iez5GeqS989khsIiOthdB/UO4utg1n0f3vAd/G1UYmO2svN8ZqmjUFYdduf6wCnFjXO6PLY8Na+3f3JJ/ompxSKbmVwY8giLMtwBlCAIWCpWq2/zJi8fWYOUuVER71+muB+ukFE9qOUcbMXXSYjdvOYnjsVf9H/s0XoZS6e2gddEfL1eW6z70gl1GdSMVzZr9CTF11PVYDTHpkMVfUWM6SL4IAEBo7UcjVm+Ne90OYR3WlxL6utet4iD+v9i529Irjf2dWwjld8OGgwh4rgjoaNJJBrWzNety29kV/QoMJBkOQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 09:01:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:01:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] fs: rename S_KERNEL_FILE
Thread-Topic: [PATCH v2] fs: rename S_KERNEL_FILE
Thread-Index: AQHYFBtV5uJ+4gtLnkyCbGPERUwlwKx4IuuA
Date:   Fri, 28 Jan 2022 09:01:00 +0000
Message-ID: <b0870835-58a6-39bb-2640-4595217999f0@nvidia.com>
References: <20220128074731.1623738-1-hch@lst.de>
In-Reply-To: <20220128074731.1623738-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53e84863-9407-4399-8884-08d9e23cb472
x-ms-traffictypediagnostic: BY5PR12MB4130:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4130E4EBB01C69EA306270BDA3229@BY5PR12MB4130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m9m4/xH44L2ZiqnQHg6JDNe+BLpwcwQoBxSPuyo3gEmU+cgPxdVlQTrdxzTsQgULU0EDeYti9o+RSmfnRyJYO7ulmWHFP+/zqfhPM35gTJghU+Yc3jZgZR52CiLKhsMJw/JnDP0dXTHuItHEcKcqWo1Sq9SeK26jql2TmWFcanHguRnxLDjhPoSrwj07CT05RjJFvOfsD2Kdz3yktRC4RcExtuR9cFkSHgbYDySpd6E8QWv8RRMoSmT9V5fgvZlPxJGYbYAROYSTByJYhjBIlavmlPtH2ixA6Cr4v2iPh8TwiDYIy9MTOZ7NVtfhCgaQDk6GceKF0zkKc2WGPTBue96kEZ7y2oXE1El81pUqtsPkb1oSPCxaSdSYjt7u4NGANw553LOUx5aWoSTv6i8oA08K8J7Cb1cGrOPbrM5AJGWu4xdx1SGFKaDE25HkQqQXkA0oUc7iqceh2/kgnK3MQq72pjPwwXNZBy41S7PjN7b8I1FSo8AvcRGaDaiXozUwxJZminfZzmzGDk41MzIjK7NkJgNehlp37EgieEQ8IA+gyLdnWe/Cyg12h5TCMcNYiAuPEumofTx2YUViv18+2ltCzwGqJdh2kJh8eBruqc0cTFYffeOQ3XmChsQ4MgGnUhshT6KVR9ZphRcsuZtwmt6Y6mpjeyJZEaafmHrgOqufz5qwEdg36Mb9ox42pwI7g5L8TggEndWRVHKOzmy5JORtU22CfKfzweeg5srNLp7RKkMLDauTQKHHJCZkMh2KeNY7MNd1Ac+dRC58G/WOKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(5660300002)(38070700005)(8936002)(4326008)(76116006)(36756003)(8676002)(66556008)(66476007)(64756008)(66446008)(66946007)(91956017)(86362001)(2616005)(31696002)(186003)(38100700002)(122000001)(2906002)(26005)(54906003)(6506007)(6512007)(508600001)(316002)(53546011)(71200400001)(6486002)(110136005)(31686004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dy9LRkdHTlZuZmJjR2V4SUtoT3c0alVWdFg1R3dXZUZlQ0l4YW1lU0M2Qmox?=
 =?utf-8?B?QnlpMzRURndJdlJCUldla0MvNHZqNmxhRmpCbVl6NHJ0RHZOempHMkhZSWN5?=
 =?utf-8?B?K1lGVUsxamxmWXJKTXQxVi9ST0pZVytUUWNCQk1PdUxuNllHZjBESU1HZmcv?=
 =?utf-8?B?Mm95SzBKSEpoeS8yZUpmTnJDT0djK1ZzeldaOThoR3M3K3VaZ0F0WGNhSnVO?=
 =?utf-8?B?MjA1ZWNzdGIwQjZvU2psWWxPRURRb0lGU2FtSnFOQ3JtRE1lOFRWSjFuV2Z3?=
 =?utf-8?B?bkZjVEJwbFZ5VzJiTFZGenJXYTFOcFhzcjY4UDI1bUlaWHllWFJmaEFpVnpR?=
 =?utf-8?B?TEZKWDE1ZmdFS1dLenN3aHRveFBrN1pYRHZIckZZbkpMUnlzbW5COWx6QW82?=
 =?utf-8?B?RUZGK0FHMjFDSEROcjZDTE56UGRyRXhqRk80RWlJaXE0M2Qyd3VRT1JBWVZl?=
 =?utf-8?B?MTZTaDNXV0U1ODU1amJEZ2cvem02b3NRWjdxY2Y1bll5dnF5K2IwQmFRc0tQ?=
 =?utf-8?B?RDIvQm11YkdFTlVpTm4xUHJuTnBHTE9KbVdZM0YvcTFYV05ua2NJaTFQNXpK?=
 =?utf-8?B?dTl3YkdicWMzZ0lTTzN4dlJDVjhPeVQwRFVMWnRaeFl1VS9YcXN2VWxmaXJV?=
 =?utf-8?B?MjV0eVVKMUpPeE9rMUpEdEwweGZ1blY1eEZNNXF6MktWL3UwRVk0b1hqSWR3?=
 =?utf-8?B?K0VreTlkeDhGVjh6VlFTODQxRE16c0J3bldRVUJPQjVsbkpHNURweHJJT3F1?=
 =?utf-8?B?R2NaczM4UmJMNmlCcmE4eDM3U0tqNTdHQVdPL0RudzlkYkcyV0pHeWdlY0Q0?=
 =?utf-8?B?QnVwTExtN1k2NkFHVmpRV1NycURySno4NldqaHVDQnRNRGdQK2Y5enJ1V3Q1?=
 =?utf-8?B?eVhkTmtoOWF0VFNiR1YyZG1BT3IrM1cyU2hmOHRvUlE3WjBPUUF4QXhSalg3?=
 =?utf-8?B?dHpCcmZkUDF3QityK3ZQbTN1bTR5Zjk0MmlTQXdWKytrWUlSVktaUm1YcWl2?=
 =?utf-8?B?d3VaOTJGL3ZtRTdtK3ZSbXppcEd5T2pOaEFXeWtkanNxU2tzNWtRVkY1Sjgv?=
 =?utf-8?B?SU1sd0x0TEJ6ZmlxMFRsMGhpaGlJOFlLU0IzRUxmcU1iZlliNCt3bW80NDJZ?=
 =?utf-8?B?MnhCKzdLaEloWlVmRXB4MDZ4WEk0YTFOT1NlKzJiRDUwajVQZ3VleGxBdmtj?=
 =?utf-8?B?QVV5WERTNmkvR2g1TWRybm1QN2RDUEhWWUhpVmMveU53TC85QnlraStlK2Mw?=
 =?utf-8?B?aXQzWDV3djZJWDZ0VlVaUVpwWlhmTzJjNjBYczJOVk1vdFc3NThmTVJXS3dp?=
 =?utf-8?B?YlluaTVrMU5UckpIM2hSZkpNczlqVVB5NWVrNzJvM2JORU9hSnp5TTkrWUEx?=
 =?utf-8?B?Y3NjN1pUZXFZdGhjWjNsaGVnUTBjT2dUdGpXenpJMnROMFA4Y21paWhPRWdi?=
 =?utf-8?B?VXpuQ1I1QmRIVU1QWnRiVlFGRzlWNjc1eVB6N2RQUmtzTVFDS2MxaWZ3T2xu?=
 =?utf-8?B?akMzanRGc000U0JwQ2VVdnpwS0VlR1ErcHhDWVdXdXljRDBoTlY0S0d6MTMw?=
 =?utf-8?B?dWwwL2pNS2lwb1l6TnRadXFMdVQwYnM1SDFUNWIveHdaME9wM04zR0Z0TVpE?=
 =?utf-8?B?dy9qUUtVSDd1MnRRa21vUnlnMVE5M1p5L2RCS3RuTGp2bVo0SFVVcWhuNzBB?=
 =?utf-8?B?N0s1T2xnbk1XbkY0UTFWYk5PcXk1S0o3eUpvNE1VSGRLZ0hqU2lZTUlscUdG?=
 =?utf-8?B?RjhraW45NFMrU2pSOGpnRm9NYUpLa2Iwb05GZ3lrZE5ibDRYeHZ6SlVESFY4?=
 =?utf-8?B?cFoxR3lCSXA5TG91ZUV6VnBoNG0xSGZJQlZGMWRmRmI0dldIcWhNeFZtTEc2?=
 =?utf-8?B?WTB5bTVzMnRZMHFUTjUySkx4SDQ4U0JJYURYN3l2WnhRd2xKTkhMKzFuRkwv?=
 =?utf-8?B?NXVORFpDZW0xK2E1VXIvaCtqemZza01TZkxaTS91dXFEWGpWZUJ2Vkc0WDV2?=
 =?utf-8?B?NTFyZXg0UjRHVVdrdUh2MGxqQ1JKRnZlSVlLeTQ3RzBDd0JsYWJVM0h6cFNw?=
 =?utf-8?B?K1hDQUk4MklIQUVaaVpCOEFmcVFiVTUydXZKdUhyalk0Z0l5dWpQZ2hEdkhq?=
 =?utf-8?B?SnM2SDRhZk5PZjRpNldvVU4xTHVScFJjZEVVdmMyYVp6Qnk1dTZsOE9XYzV4?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10258B39F06B2149BFEB9CC9A428237F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e84863-9407-4399-8884-08d9e23cb472
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:01:00.1862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uLJHp3EEWBhelSjB+fcWULln98ZcnqwdqLog/xfr0IyJ9oaj5WxDHvMU9vg89xrYXqw5doI+eVvVUXE78Z83A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8yNy8yMiAxMTo0NyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFNfS0VSTkVM
X0ZJTEUgaXMgZ3Jvc3NseSBtaXNuYW1lZC4gIFdlIGhhdmUgcGxlbnR5IG9mIGZpbGVzIGhvbGQg
b3BlbiBieQ0KPiB0aGUga2VybmVsIGtlcm5lbCB1c2luZyBmaWxwX29wZW4uICBUaGlzIGZsYWcg
T1RPSCBzaWduYWxzIHRoZSBpbm9kZSBhcw0KPiBiZWluZyBhIHNwZWNpYWwgc25vd2ZsYWtlIHRo
YXQgY2FjaGVmaWxlcyBob2xkcyBvbnRvIHRoYXQgY2FuJ3QgYmUNCj4gdW5saW5rZWQgYmVjYXVz
ZSBvZiAuLi4sIGVybSwgcGl4aWUgZHVzdC4gIFNvIGNsZWFybHkgbWFyayBpdCBhcyBzdWNoLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJl
dmlld2VkLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPg0KPiAtLS0NCj4N
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCg0KDQo=
