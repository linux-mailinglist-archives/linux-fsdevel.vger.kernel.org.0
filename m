Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC86A44D32E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 09:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhKKIay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 03:30:54 -0500
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:24209
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232067AbhKKIaw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:30:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRTa1edOostdcQptTybXPGx7SKwRaLOpzrOipcgjYMcdPGznxPD8GhgWzsz4Bg+XOdbOUzSVLtK/K6gon4mQl1tukbsPp8nrDYJwufY1nw+3nnTK9ZDXX0wyjY3zrM5rmBjgY/qFAl0np84jc5nDtYntQOx1gylKpzsQzJ2MQ1eR5nUblIABE8QrXoHBgHQE/iK4xh2UxOIKGd2t0fw9BvmZtvF0tjgvozF8uh6yuB6tYOyATh1sZiz2nq3VjSq62115+I3SWcIkRIQHpshz6kbNq0BkkEz9c/cGzN1E5P/+LOtoGOo4vRJGvYgpVinryTWryjpdm5xrf8tjDpfh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o48YN0kYBzI56rirTCA/UVRXL71J4tM/QFPF21TLgf8=;
 b=ecJxBY6ZElJs5pMwLxOV5fWIRvY/Vlov7v3CTo+3uiIuT7P+uCZalj2vSiOrNNrzMb6LqdVjYLwQ/15H8ZICUaUpYymJxTd9gtpYJyio9sj4isDjYQzk55Cy1XxGjmFFT6mdvnT1HSvPhSY0RNTE4P9Y+DOhZFNGMubO3Q8bF15JWLwkgfBSf0K9sHoLXWYPy2Odb+XWXtGbUoKaEvHBlDqT7YPjDieOi94/YaLrrTV1o1YT4w+iJcpqOisWUZSG7yR8pJJCmKo3KmpzV49iAkaDUjx7Fy6YvfaFfAd2W0HCYO3OT0qwRxkVj7XfwkuJP5rEwLoOFll0FTgvFHn27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o48YN0kYBzI56rirTCA/UVRXL71J4tM/QFPF21TLgf8=;
 b=pDUFXhvc2/LhFeMw/gmqOF3NkHAU/WGJPrEziXFyxKkzMV7xAcxOMHrZHRspcjrwdK2lQlM17Q34stSde3gQzRW7SgYHGrEPkMPrpw/1CXsuXgxGm0Nhbg3VPKE7H1d2g3ZVBR0I+EAgquPepQ8izT6j6dF957iBUdRSClgYtP3C04rfZ4duSbc+33byFUOJG58tROYFvXHk43hvmLQgh24o+2c9l7bAekOQb9n+Fx55vZNH2IJ+xavYCTdrsd54VIBBQhjevQigaIJhhWOwqQnIsQ8cDeab50MKB0Mgqs20NFlCzWnKOD8UmJh01V9qATx1EDKpoFZvpJjbge7Pjg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1135.namprd12.prod.outlook.com (2603:10b6:300:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 08:27:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 08:27:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "dgilbert@interlog.com" <dgilbert@interlog.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Thread-Topic: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Thread-Index: AQHX0UfJUBDssfv+ckmT1a3v6/33Gavze2CAgAqOIwA=
Date:   Thu, 11 Nov 2021 08:27:59 +0000
Message-ID: <d862ddb6-4c58-e046-ab6f-98cf314fec5d@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <7f734d14-c107-daa3-aaa8-0eda3c592add@interlog.com>
In-Reply-To: <7f734d14-c107-daa3-aaa8-0eda3c592add@interlog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: interlog.com; dkim=none (message not signed)
 header.d=none;interlog.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43bb50ac-96b3-4f98-7713-08d9a4ed2bd0
x-ms-traffictypediagnostic: MWHPR12MB1135:
x-microsoft-antispam-prvs: <MWHPR12MB1135C7FF3F9A310ADF4C2959A3949@MWHPR12MB1135.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ueS25Etfg8pP0Qixb3mXJKjNBoQaRVoouNzEmhSuITAD6pZbL9T/93UG9ZnXgfrQnTVmiYjYvriS1HgtoNtjwkqVFFguznRi3AYc7TLuC9DyQ2SSrX2MmnW7wcMOPjJxeUfUriOCAI/E1ldug6aMMD2U0Dtu54RInq0XbIr+xyQLXrMqLvT+/lRs7oly5+Svs/qRXTWHialmZ51rWtG/WTH//JbGm7jyx0sIeeY6s8X/sn2rLQ4YS/0M/RDUChJ1uuPdMnuV18raL/hoRPJKXhd3PtC9rQjCz424Igewc3/oa+yVNJF1z2lqJwUufMunICWJfYt6Gs/QrKCAzmY2XjAhBOqkrBqFKpAOMCbSywGjRg+7hE1lJhG3gQ/0KVs2fac+2WRu/9Ol4lkEGiDFh8qcA2psz9VuVtpaX+bl2gWVnNfuYVEuV4656NEmR6dNsWyaxTqRSv4la3SyfV5p2dY/vkRSe9j+lwWUcy6+19SvCqoF9/L0jIvFQi8NLMLxe5FPv2G99+CVl9sgoGBHUWKiKXiecNiL1ZTrfv2YAde+cRx8CZjtsYupJJHwiNxvJu1gXd6aMuxasYi4aqpWbsbEKZOMi/rZ7Bnzl+CpeeV3ndFct/BEi+TBFV6gDfYDM9BPdegOAezVSeir/S4lTfXd51C1ER8UGFRx1RPz3pE48uuPbHpqKkxuSS3EhNXMIf5Y+q87XzWN/udJ2MjycTpoqcNRnKmBYVvfl82B9j16e/FVPLEvqrZXMN1dhyDg+l4osYNQgGe4lBul/vT0uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(2906002)(86362001)(66476007)(38070700005)(54906003)(8936002)(316002)(5660300002)(83380400001)(71200400001)(31686004)(8676002)(36756003)(6512007)(66446008)(66556008)(64756008)(186003)(31696002)(66946007)(2616005)(122000001)(38100700002)(76116006)(6506007)(6486002)(508600001)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVZZVVRpVUZnRWIrOCtabTFVeUE3SjBxaWs3MEd6YzBLVVhlRUlTc2Vta3N2?=
 =?utf-8?B?amNqMzBvZWRkRGQ5czhHSG5nVCt0UFJJbVYyUkJqN0hpbXhNaThzVkZpTWIx?=
 =?utf-8?B?WVJoYTFBVDU1ekdKNjNzdjQ4ZVQ1ZTdUcjYySW4wc2hxb3ZzYXhjSEVBc2hj?=
 =?utf-8?B?dklycE1tWjNpWU1QK2JBcE55K3AxT09OUG9EUXNsVVRDY2U2M3JwMU0vK2hq?=
 =?utf-8?B?bk9nazN0MjRHcUpwZDJyK01VWk4rWUZGSkpBOUgwQldiTGtQNlNidzM5TUNN?=
 =?utf-8?B?Zzd2NDhGanRhUjJNTGl0Y2s5cGtYdlFUeDBJYk03RW9WcVFUSktvN1c3bmR1?=
 =?utf-8?B?OUZyMWpVbUZCT0U1aTRXQnBYbGhsdFpYenpCbjVwb2tKYXRJSjFqU05nNDZa?=
 =?utf-8?B?Z1pueVFReHFQNk5HaHdvbnc2QjhFWUp3UzNHZmE2N3U5dVBuU3QvVDBESEJz?=
 =?utf-8?B?aVoySXBqVkNBRnZ3MmNPa0ZDVCs4L09ySVlxNDZHeXFZMHZwWDc4TnFDdXRi?=
 =?utf-8?B?bFFXaGxFQkRXdkZZSXNOcUd0T0NIYUxreDJnRGRLTFM1VkpZeFdJY3JsUGRp?=
 =?utf-8?B?SSt0dFBKR1ErUTA2WGwxY2NxUUROZHpSOHcvaDNpK292ZVdsVmh4ZlhkaEk4?=
 =?utf-8?B?ejJHUnhndEpqd3oyTTh1UmZwVkNXL0ZLODdSbG1lbnl2K1JwL2JvVEErRElj?=
 =?utf-8?B?SkZIY1AzeUhvam05UW1TVzVYRncwWWsyR05DOUlVRVB5ZXZjSW1xN0RUZDh3?=
 =?utf-8?B?L1lhRTQva2dJSzIwY3FPWkxmS2NXeElhc05Fd2xhVHFUTGhXRjB2elk2VWls?=
 =?utf-8?B?Rlc4TUl3VGp4bTVwUXNYMDRoWHpuTEtKV291REFaT3R4d24wbFozU0llRjdK?=
 =?utf-8?B?bWlkQjZYakF1amVIZmtvR2lqaWl1YmNjTlVDcDdjMGNaMVFNTjBkRVVVdkFv?=
 =?utf-8?B?QnBMWlFCMy9CU1Q5QVcrWW5sRW0wdlBvV2ZtWFFTNlE2M2RoZ3hKUlFraXhr?=
 =?utf-8?B?TVorLzB0TWJxUmlrdjFLTVdYMG9uUTY1OFBmM0kyNGZubjlNT2w3QlZqS3lk?=
 =?utf-8?B?OGlUb0JWQjFsSGtXOFpZenZGSGFJeUhSNDJMY2tKdUk5b3J2Y1Y2MjFFNTRv?=
 =?utf-8?B?azduVlU3bzZlQzBnZklPOWo3dlkrWjBCN09aK1RjaU1KVmtUZkY5KzVuOERl?=
 =?utf-8?B?dTNvYjIwUVVVdG5OZDFBTTRvdDFtOFRkTFZmTVpMWTA2VFJZOE5wOWZDVklF?=
 =?utf-8?B?NUp0bmYybHJ3dElQSFZoSUZVcFBmTmNUaUN1SWtRMWk3ZEhiSGRaUzZBL0Zr?=
 =?utf-8?B?dUtjSUZVaG5Hd3BnaXlwMUFCM0lsUFBmQlZVR0xQZ0NSTnEweVEvd1ROWDRs?=
 =?utf-8?B?VVByZmltdFRiT0lQSzNLOHZpV1pqd1JZSDRPVEp5b1pZU2ZoVjZmV3NyQk1u?=
 =?utf-8?B?K2FUL1hzMXdZc1NJUXdmUVZ2OEFRdGZLeW9GbjBEdWVjWXlBRHNwOXZZSmpX?=
 =?utf-8?B?WE1iUUtjRFhTMEprS1k3QWpxWjhOcjE4VS85YzhBN1ZFY2E5em9adnE1NkM2?=
 =?utf-8?B?YXlZelFlYWptc3BzUUh5a2NmV2xERUdBNnFKYkhLMGpEaXNnK3BuV3VIdnNz?=
 =?utf-8?B?MHRWNWtBaDhlOGx5QTRDbG8xM0RnY1RzM3p6bTZwY3FLWjU4cjIvTDQxdENi?=
 =?utf-8?B?MHdqemxjK1NiWVUyejZyT1R2L0hUTUsvOGR6eEpaSEljTXhGbUR4VHJVQTQ2?=
 =?utf-8?B?b0ZVRlk1aW5qU0pFK29Hdy9EalhmcExaQlA5ZGdCcHpVUEZvTzVOZ2tKdVk5?=
 =?utf-8?B?QllZQ1l2dG4zWVk3SWh2YnNNVzdJamQ5VVV2M0ZGeloxQVdyQ2RqK1hzQ1FG?=
 =?utf-8?B?cjRPemlRbTdxUFdmV1FoaEErTXVVQ3RoRWdvQS95ZGZWeEYwZWtJMzErVGJI?=
 =?utf-8?B?YjB0dzQvUTdjbE05cmNEK05yandUbERBTFRacUxpUVR2cnFONC9SeDNXTXM5?=
 =?utf-8?B?TTRQRk9ZbHZ2WVdCVTl4QlpKM0hJL3NZSDQrbGpieWVSVVNTdmIxam9DM2Zm?=
 =?utf-8?B?cDN6alBxTVVEU1ZzTlRkdE1vMmFqeHF4UG9kelpjOWJBbDg4b1hLYVVwMTRl?=
 =?utf-8?B?OUkraVQ2QXFjTU55YUxZZk16dzBsK2w4bjFLb1hURGppL2lScUFtNGVKdVFC?=
 =?utf-8?B?bUNkcENhWUFNQWprcVZybDcxMXVSOHl0OFBBTmpYc3FvRjVibm1xamttS05s?=
 =?utf-8?Q?f1vyhshmVEa+2fJUwhdW6rYcU+8pVg4T75VA2eXA8Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09979AA6EE8E05439EA550617CBDAD8B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bb50ac-96b3-4f98-7713-08d9a4ed2bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 08:27:59.7423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3wisA3kb0bvfVXuRglllJcjAoS8i2x/hc2MuJN/biLyMDUAyuuuh2AkmY24zjR4GVBRywUdCznz4Gateocg1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1135
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+PiBQbGVhc2Ugbm90ZSB0aGF0IHRoZSBpbnRlcmZhY2VzIGZvciBibGstbGliLmMgUkVRX09Q
X1ZFUklGWSBlbXVsYXRpb24NCj4+IHdpbGwgY2hhbmdlIGluIGZ1dHVyZSBJIHB1dCB0b2dldGhl
ciBmb3IgdGhlIHNjb3BlIG9mIFJGQy4NCj4+DQo+PiBBbnkgY29tbWVudHMgYXJlIHdlbGNvbWUu
DQo+IA0KPiBIaSwNCj4gWW91IG1heSBhbHNvIHdhbnQgdG8gY29uc2lkZXIgaGlnaGVyIGxldmVs
IHN1cHBvcnQgZm9yIHRoZSBOVk1FIENPTVBBUkUNCj4gYW5kIFNDU0kgVkVSSUZZKEJZVENISz0x
KSBjb21tYW5kcy4gU2luY2UgUENJZSBhbmQgU0FTIHRyYW5zcG9ydHMgYXJlDQo+IGZ1bGwgZHVw
bGV4LCByZXBsYWNpbmcgdHdvIFJFQURzIChwbHVzIGEgbWVtY21wIGluIGhvc3QgbWVtb3J5KSB3
aXRoDQo+IG9uZSBSRUFEIGFuZCBvbmUgQ09NUEFSRSBtYXkgYmUgYSB3aW4gb24gYSBiYW5kd2lk
dGggY29uc3RyYWluZWQNCj4gc3lzdGVtLiBJdCBpcyBhIHNhZmUgdG8gYXNzdW1lIHRoZSBkYXRh
LWluIHRyYW5zZmVycyBvbiBhIHN0b3JhZ2UgdHJhbnNwb3J0DQo+IGV4Y2VlZCAocHJvYmFibHkg
YnkgYSBzaWduaWZpY2FudCBtYXJnaW4pIHRoZSBkYXRhLW91dCB0cmFuc2ZlcnMuIEFuDQo+IG9m
ZmxvYWRlZCBDT01QQVJFIHN3aXRjaGVzIG9uZSBvZiB0aG9zZSBkYXRhLWluIHRyYW5zZmVycyB0
byBhIGRhdGEtb3V0DQo+IHRyYW5zZmVyLCBzbyBpdCBzaG91bGQgaW1wcm92ZSB0aGUgYmFuZHdp
ZHRoIHV0aWxpemF0aW8gPg0KDQpJJ3ZlIHRob3VnaHQgYWJvdXQgYWRkaW5nIGEgc3VwcG9ydCBm
b3IgdGhlIGNvbXBhcmUgYW5kIGZyaWVuZHMuIEJ1dCANCnRob3NlIGNvbW1hbmRzIGFyZSBvcHRp
b25hbCAoY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcpIGFuZCBJIGNvdWxkbid0IA0KZmluZCByaWdo
dCB1c2VjYXNlKHMpIHRvIGp1c3RpZnkgdGhlIGtlcm5lbCBwbHVibWluZy4NCg0KRG8geW91IGhh
cHBlbmVkIHRvIGhhdmUgdXNlY2FzZXMgb3IgYXBwbGljYXRpb24gd2hpY2ggYXJlIHVzaW5nIGNv
bXBhcmUNCmNvbW1hbmQgZXh0ZW5zaXZlbHkgb3IgcGVyaGFwcyB3ZSBwb2ludCB0byBhbiBhcHBs
aWNhdGlvbiB5b3VyIGRkDQptb2RpZmllZCB2ZXJzaW9uID8NCg0KPiBJIGRpZCBzb21lIGJyaWVm
IGJlbmNobWFya2luZyBvbiBhIE5WTUUgU1NEJ3MgQ09NUEFSRSBjb21tYW5kIChpdHMgDQo+IG9w
dGlvbmFsKQ0KPiBhbmQgdGhlIHJlc3VsdHMgd2VyZSB1bmRlcndoZWxtaW5nLiBPVE9IIHVzaW5n
IG15IG93biBkZCB2YXJpYW50cyAod2hpY2gNCj4gY2FuIGRvIGNvbXBhcmUgaW5zdGVhZCBvZiBj
b3B5KSBhbmQgYSBzY3NpX2RlYnVnIHRhcmdldCAoaS5lLiBSQU0pIEkgaGF2ZQ0KPiBzZWVuIGNv
bXBhcmUgdGltZXMgb2YgPiAxNSBHQnBzIHdoaWxlIGEgY29weSByYXJlbHkgZXhjZWVkcyA5IEdC
cHMuDQo+IA0KDQpUaGlzIGlzIHdoYXQgSSdkIGV4cGVjdCB3aGVuIGl0IGNvbWVzIHRvIHBlcmZv
cm1hbmNlLCBidXQgd2UgbmVlZA0KYSBzdHJvbmcgdXNlY2FzZSB3aXRoIGluLWtlcm5lbCB1c2Vy
IHRvIHN1cHBvcnQgdGhhdCwgSSdkIGJlIGhhcHB5IHRvDQphZGQgdGhhdCBzdXBwb3J0Lg0KDQo+
IA0KPiBCVFcgVGhlIFNDU0kgVkVSSUZZKEJZVENISz0zKSBjb21tYW5kIGNvbXBhcmVzIG9uZSBi
bG9jayBzZW50IGZyb20NCj4gdGhlIGhvc3Qgd2l0aCBhIHNlcXVlbmNlIG9mIGxvZ2ljYWwgYmxv
Y2tzIG9uIHRoZSBtZWRpYS4gU28sIGZvciBleGFtcGxlLA0KPiBpdCB3b3VsZCBiZSBhIHF1aWNr
IHdheSBvZiBjaGVja2luZyB0aGF0IGEgc2VxdWVuY2Ugb2YgYmxvY2tzIGNvbnRhaW5lZA0KPiB6
ZXJvLWVkIGRhdGEuDQo+IA0KDQpJIHNlZSB0aGFua3MgZm9yIHRoZSBjb21tZW50cyBhbmQgc2hh
cmluZyBjb21wYXJlIHJlbGF0ZWQgZXhwZXJpZW5jZSwNCkkndmUgdGhvdWdodCBhYm91dCB0aGF0
IHdoZW4gSSB3b3JrZWQgb24gUkVRX09QX1dSSVRFX1pFUk9FUyBzdXBwb3J0IDopLg0KDQo+IERv
dWcgR2lsYmVydA0K
