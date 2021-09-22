Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3DF4153E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 01:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbhIVX3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 19:29:39 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:24289
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238450AbhIVX3g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/5Xvt5Y8DY5OmDDtNUBz2cvWPoA3k5xwT5d+xh1Gu4pLTKyfsl53WgbkAcw8DRv0h4cNvGNk/I+/4/N+aA2Uadq1ntU/Plm7IBEQB2mSHjQCyoVC9C0N1ZFN3ex/IGx9m1xF++J8nrfc/3wRKykt75CHUCB6JHoOhjnU1eFwhj9KClSlxoHE9sS387SL9fQ4Nlwql3fXb12VWMpONntH5rOsguGzoSk/FlW67o1Ed2HTtoV8NxcNq3XGGYqpB7n6Oz8pMLSbqn7uFAcH9PwG8IMASRNvQn4kXZ++w9kUSEsYqJm4B8mIxBxnGPOv/Q7BdS6/IPXUOOLDfNhLmpJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=deURmu5nKxRl7e63UMq9H5VarzD7e8Qw2W7GxaLGeBo=;
 b=DC1qiLJkUXgorigM2QHkM/Rz28cDzxXlvGm1BX6QEjGYvBSGMXX+D+2lVsaLM5D6LfV5y2u4L7zq8Fk+MnkJZZVTiBQ1Vl+cMjNy850uvtJol/ilbF5CKfWiPBgU+I6v8K3JpUZjWrolvmO+T0X3389Q5Xus5sc5l/EqIYA87ccyzRXypZCKGmfiA9wFzV5YcqCmwL9bMk+5TqiRq0XLNLBODBMdgO1TEqI+Z7r+qOJfoK5DJnAnRiuZqhFZk6yo9Eup6VFmSeVxWvKn6LnfEmfMFwYQqKYKDm+uYiiXkKNr7AgDEw1tDl/yT1+sM+5KRQT40OKbW5Uw6OTyEZLy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deURmu5nKxRl7e63UMq9H5VarzD7e8Qw2W7GxaLGeBo=;
 b=eWiaX0aHexjGRAbwJ9PiYstN8yC8IAfmmxEexA3KRBV6kVNMmEHcOF+XGSrHitCpafrSUZmQ/cWXcEVXHnxd+QwGLlbo1QsLb17hJT7ic2lRHDGv1MXZNu9tKh9xaWSDTWgrE/S9HhYRkes9BJFHU3FQVC9DC41QBqzO0cuQwfKH3+BT04G6H7Kcpr2bJ4bSRSiNKAIoY9nIPwrZvYMLsU+TQWkoJZcmNtVbpN3c0ZjXX/nOp68kSm8/mUeOy6xF/uYtWWiZGxkYzc6v1O+rwjmu3J3n2bTLaVSCsxjHMBYor3gPC+5GMOsVC8oLAplkAQgHc8+UoNAEVF2+3edxPQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1390.namprd12.prod.outlook.com (2603:10b6:300:12::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 23:28:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 23:28:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     David Disseldorp <ddiss@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 1/5] initramfs: move unnecessary memcmp from hot path
Thread-Topic: [PATCH 1/5] initramfs: move unnecessary memcmp from hot path
Thread-Index: AQHXr6hVTcpb9jQIwkGQTgFWyliHKauws6uA
Date:   Wed, 22 Sep 2021 23:28:04 +0000
Message-ID: <847a413f-dc6e-cbdf-4e0b-6a9512ac69a5@nvidia.com>
References: <20210922115222.8987-1-ddiss@suse.de>
In-Reply-To: <20210922115222.8987-1-ddiss@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09618906-cb65-47d2-d0c5-08d97e20a0bf
x-ms-traffictypediagnostic: MWHPR12MB1390:
x-microsoft-antispam-prvs: <MWHPR12MB1390C369449CE515A3323CB7A3A29@MWHPR12MB1390.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1mHj4dJoryBtWzqyFgkyKLsiBTBTpKIh4RQr7K9mIMwMIzoXFxVSu7lgUJCxJYCT1QFUhXBrJX59RgY9MCkFT3uno9BzPdRb6Y5QGCe7po7KUQ6DVuKGpiETQCZXiDOwgLL8xesQQ/k0o471gwt5EqDm/7QzPQLE+mYQWK57ASUaptpYnYhtKqsBDHBd/sTfUfqslZjtqUH/CO/+6etvgbbNfpIz+CxBkB8tukN43Bw6BVB7uj2s+nlurPxiKFm1jkJ/scwpn2iTOrvHGoR5ag6UIvOqml7OspgV7nwcEp5zF2vZWNItaRgKjPZihkKumiM4xo9oJK8EkxgOJbbQxQ9GwF83iPfETkyKEaVpx1tLUnN6sdMWGSg8hr1F66TQl8aAHhgs129pqNJ9vPrWyYCTXArrO/NKXM6fAMTp5g3VKnHh3RnEOl5IwkKKquiN700KEbm9Fc7IEDiE/eRqNdCJqX9xXvs3ZTyd01cg1XOpyfiDGTV/DqPSKjS/LeTp0qXSMYycqDPSpVLBorIzNIJ2VrMlrZrNIZmadNQeJ5iXrzIMuS7EDsDkCGJv+w9RhSrb5QxGEf6jJ9Aabl/z5wHzSqj79yhT+9IT472szBe0bWxdAPfxR0CAiD1TW0uswbrnhiVtjo41xQacV1mz+OfjJzPXpYCyk8+KVT+H3fkMIcOF9J7ZjRwiaVD0kcwiVX/5gkRY+NpH1rMcJNi14KpdZjNFw8PwyX1mt8iyPjHf0R9XaeqYn6wIAN9+z4tX0wjeDZy8/01lUjwtNGKicg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(508600001)(5660300002)(71200400001)(86362001)(316002)(4744005)(2906002)(66446008)(6486002)(64756008)(38100700002)(8936002)(66556008)(110136005)(122000001)(31686004)(91956017)(53546011)(186003)(2616005)(4326008)(36756003)(6512007)(38070700005)(31696002)(6506007)(76116006)(66476007)(66946007)(83380400001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1FzZmFwNVVSZzRESzYxb0lVNGc2ZGdvbXREZG9oZXY2Yyt2YUZtUG40ZjJa?=
 =?utf-8?B?eUxHcy9EeWYzdm0rWVQ3Qk5kK1lSUDYvQXk3SVluQ2dVZmlHU1dVendhWVRZ?=
 =?utf-8?B?WTMvNHpnc1NBcytJdk5yVU13U0EwMUw0WGYrVGRRREo0aHFoU3RFZXc4VXll?=
 =?utf-8?B?SXNoSlFYQUhGTlVIUm9ablo2TTlRZ1NGWjIzWk8xaVhQUzd4bDdVYU5hN2Ex?=
 =?utf-8?B?UzRJT3JvbnpuWDh4RFZ5OTlVQmo5Wms2aU0vVGxIb1REZG1xeWZzc29HYVBK?=
 =?utf-8?B?cTZ3dmx0bzlVdEtuY1h3QXpiVnJMVUNRYXMwZEVxWGcvUTFONEtkVEhXODRL?=
 =?utf-8?B?UkNtNElXalptRlV2ajloeFAwWFV5Ty9KRjBtZVdPNnkrM1hhWDc2WTM3TmMv?=
 =?utf-8?B?a0pVNlBaV01ZV3ZtbGM4b1dYMzh4RkFWZ2pBNlo5b1V0YklEcHVWUUd2NmI3?=
 =?utf-8?B?S0hiU1RJZk5ncVlHNTJBaEhXTGFjSjJ2TWxoRkdrREpRL28zSHQ0ZVVEak0y?=
 =?utf-8?B?S2NjeURZYUxkOThvdnNoN1pLSjJpK0RVVHl2ZzBxRVpYQWJZTWVscldiTkFp?=
 =?utf-8?B?ZGNISlJncVNIRDBXRExmSGI0aUUrYXg2YzBuTkFERWFLNTJKKzRBNXkrRW41?=
 =?utf-8?B?bG1tcnpHS3FxaEZ5dThRNVJDdlpoMWFYcFBpdHJEbHNqNTk1VDBOcTNGQy9R?=
 =?utf-8?B?UnprdElROGxPdEZpd0NzZW9BZmlLMlZsTk5mQ1U5UmkvQ3UxbjBjdFUxYWh4?=
 =?utf-8?B?OFo1Y1RWSTgyd3NzMWE5OTFuNlpBNTZKakZUc01YV0lKbHBwajl6THVpQmdM?=
 =?utf-8?B?TEFqTDNSNGNHdVk2b2phRXhNWUxRQ3FzUmlrS1UzNU05UzNwclNFTVRDS202?=
 =?utf-8?B?RitnanVFeDdqQTZEc1FIaW9KZWw5aDRvZUt5aDJRMUorN2E1Vnh4b0twVUxV?=
 =?utf-8?B?b1Q5RVFWbUVpNW1GOVI5M1BUZExVUWNmOFkxNk50bWdHNVkzLytpdG1FdHly?=
 =?utf-8?B?REt0eVN4SG1uZW5yd0hYbW9IRkJxV1VQR3JYTHpFbVhxNmVTSkx6dGx6RDRQ?=
 =?utf-8?B?TFhJNVQvb1d3SkpQR1h6NlJ6OEI3KzFwNUVROEt4cG9oVG1TQlZlbUxGajJ0?=
 =?utf-8?B?M1oyYXNIVWZ2eXZFTDV4bjNrRmI0SDU5R3hQOGdtbmNjZk1tS05OT25NVkx6?=
 =?utf-8?B?ajVOZUZ6dEJOUW1OVGRjdjI0SUVpWFpqWlllNGdiejh4bkFwaE1jQmZmbldv?=
 =?utf-8?B?OWR2Y1FPS095TkFwQUdGOGt1bWNJZUU4YVZ2dnVGaDNUMEJHVWdHTW5hMTNv?=
 =?utf-8?B?NlhnbVU4b0lPWEF5TnpZMHJ1VTN4RVJVMHNPYm40NU1yOHU5QjUxL0xyTCsz?=
 =?utf-8?B?N21pRzhrNGJOWGJlUFBMVzZDY1NLK3A4c0ZHbEZ0L0NaRmRtbktzczBPY1Fi?=
 =?utf-8?B?a1dYdHVSb1VOVHdhMHNhNDNGRjE0cGJnWjZ0VmFucWUzTHlzUjE0K08vRHNM?=
 =?utf-8?B?RDQvWURacXBxVHZiZ01Xcmg1U1o2WFBiL1ViYk9FeitwRmYrM2pKcHpwSDRm?=
 =?utf-8?B?MXA3WEdOQVhxMFlCRk9HMjFYc2pzOTYzTFE1MjlyRTUwSE5EQU1sRDcyd1Qv?=
 =?utf-8?B?SlhnNFJveHlQTFMwWEd3VTg3clJKbkJldnR2aE5aTk16NHhGVlZwSnhSUHBm?=
 =?utf-8?B?ZUdaNHZCRFVXMlp2TnJiWjFyeHRRZk5TQk5jeHpaT0Z6SkxsNGltY012aDBI?=
 =?utf-8?B?czQ2NEFiZ1hLck54cHE4R3A0Yjl3eGVTRmx0R0E1MDdBZUlBWnhmRzZBQ1g0?=
 =?utf-8?B?QXl1bFFTRHZ0QlA4TGg1LzBMZmdEbm1lSE1ubG1Rd2kySkFwazZJcWpKNE5V?=
 =?utf-8?Q?Y2L7yAKj8IglC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6B064C2DFE36948B53DCEDABC80550C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09618906-cb65-47d2-d0c5-08d97e20a0bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 23:28:04.9904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGjsSjNrWwMWAEl8rLV+BdYWdOsQ/vgfmTO8iE76UTmdQYPX8f1KF3dw5rx6SP2mql8vt+88jF59u2ZFOJQGuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1390
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gOS8yMi8yMDIxIDQ6NTIgQU0sIERhdmlkIERpc3NlbGRvcnAgd3JvdGU6DQo+IEV4dGVybmFs
IGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiAN
Cj4gZG9faGVhZGVyKCkgaXMgY2FsbGVkIGZvciBlYWNoIGNwaW8gZW50cnkgYW5kIGZpcnN0IGNo
ZWNrcyBmb3IgIm5ld2MiDQo+IG1hZ2ljIGJlZm9yZSBwYXJzaW5nIGZ1cnRoZXIuIFRoZSBtYWdp
YyBjaGVjayBpbmNsdWRlcyBhIHNwZWNpYWwgY2FzZQ0KPiBlcnJvciBtZXNzYWdlIGlmIFBPU0lY
LjEgQVNDSUkgKGNwaW8gLUggb2RjKSBtYWdpYyBpcyBkZXRlY3RlZC4gVGhpcw0KPiBzcGVjaWFs
IGNhc2UgUE9TSVguMSBjaGVjayBuZWVkbid0IGJlIGRvbmUgaW4gdGhlIGhvdCBwYXRoLCBzbyBt
b3ZlIGl0DQo+IHVuZGVyIHRoZSBub24tbmV3Yy1tYWdpYyBlcnJvciBwYXRoLg0KPiANCg0KQSBj
b3ZlciBsZXR0ZXIgd291bGQgYmUgbmljZSBmb3Igc3VjaCBhIHNlcmllcywgdW5sZXNzIEkgbWlz
c2VkIGl0Lg0KDQoNCg==
