Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8892D493093
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 23:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349434AbiARWQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 17:16:12 -0500
Received: from mail-bn8nam08on2064.outbound.protection.outlook.com ([40.107.100.64]:39947
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236714AbiARWQI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:16:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPKz00TVbG5PH+sEPTUHdJrm/dJVoyoLjvMlQKQwgdzMvoYaMR6c+xk/+8vX3kk7VEREmAn7gtIsov67EkgEuUGgUs5QOJelavDqMkbUeWFADEhIWUrdVsqh8gPj3xLRdx6fWeFRa9JcGwUSMC/CXi8afw+a6A0lrpKa0tDdfOhSMPzthMwzjpRy6f5deAYrcL7GDPVW+RX/Tl1rLvgSRQIx7pLEVD/sTOZ2dLwvVKYa1dyvUOPz0FGxssjm8/qlZZqgPfmNYxmSE0dd3ZjX26m0X9TjNzUsgAgJYMqWVJIjz/BsxaY3rBCwmTTAstdL5oRbO/gKVV7MgYaPmAIUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZSiXN0jlndrXjj1b4wa9kUUdCNmCG91kc9Ols66x+s=;
 b=isNm0tpIGm0DnVYJLOOROeiZiXWkVVQkEUhRNTjNf6luScX17k9D3d+nneN28a8yWi5pmXBLjwPpU2547P/5Ks+rGLxMQaDUXdj2VcsQ8uAzULUwYnrLnCnPBYyRdW0BoKhij08AbpL7nXap4bMcOpsDjP+w4oEUMRKJ/Aad0TDl5vF7PwLMxKlTGGbAdNcacyNq/D05re2tvDrYRzEs6cR9qFroeFPZSAbc+a6wn8aHRdNH7eOT+tsk+C3y0gZ7Oh4VWg6/1deiA5iQ8EO0O0RbmQiIWi/YIVnxZN/dlDoXy2M0giMV7SEObaWtshdJB0LrWCZzABey0RMLMjIOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZSiXN0jlndrXjj1b4wa9kUUdCNmCG91kc9Ols66x+s=;
 b=HBcpijMicyIwzHnSbIlGaNqNINL1v7Pjes5O88tizzN3H8L5SSm8rqLvBvwmM58oXuD/2epxA4KiaSeLO7Ql5OyhrpnNDUx++hQukKoT0+VTH3OWE7tyj+bWzrAtE6pfWa91u5Wk9yEovSbKfBTXALnFtJjMp5zvlMCP68VJQZMWvWfcIdTfF6Y0F1Jsh1l2K6B5HbeedD900uuln72ZVygE3BGLF9ueMGynuSsQi+AE/nb6Ol4RJafPbebVlL6HjKLDH+kPOIaQSRJq++id31s2xcpl6o5Y7HKnmiHChJBeTGyWZmy1A7lojkWtdFchU9YWfjvqnyXHHpNNksPFXg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1487.namprd12.prod.outlook.com (2603:10b6:301:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 22:16:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 22:16:06 +0000
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
Subject: Re: [PATCH 19/19] block: pass a block_device and opf to bio_reset
Thread-Topic: [PATCH 19/19] block: pass a block_device and opf to bio_reset
Thread-Index: AQHYDDwO0g1B+gUH7U+xTMvaoQ/ZbqxpWYCA
Date:   Tue, 18 Jan 2022 22:16:06 +0000
Message-ID: <d7068c68-17f5-86d3-6901-b747d41ac346@nvidia.com>
References: <20220118071952.1243143-1-hch@lst.de>
 <20220118071952.1243143-20-hch@lst.de>
In-Reply-To: <20220118071952.1243143-20-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 831e1521-8843-4b6e-2440-08d9dad01f4e
x-ms-traffictypediagnostic: MWHPR12MB1487:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1487185DBB1CA4391C897A0BA3589@MWHPR12MB1487.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WnAebCZtNHiQ63I0CU1rijEJS4dszLTxPk6xkcV4rhmVbrukxa/Tb8aOd2CE0JlslROAS7YaqeuSyjqGTc0ko15/Y4sdtDmgoEY+u1hT3XoPO9Na+ieR9TmG6WcFZxzL4cWfFOSyU8HqhO0iOuwbQfEKblAJAlv+xWyH8U9lrd9P1ohHl5CMiKSv96xA/YdtnPPVUc5DFiWmIOVXTMhp7MQh3NzC3zITr5Jhi5Wrzfsf//HMPWeOIDO2+XTbnfqBhbSA54I5RNq3qS7TwHVRyXw2gvBgu6v3rq22G9Qug8WYH9Sr9AXXoaurcMq4Jdq6YK+HO28XNdjOXcWtC9HjYKEBzZaB1KBy4Rw1rIgZgcT5D0+sb5WZ8ys02UZaUX+9kqYRHpjd1ahBM67asTJbz5cuMRd6UZgHVB5uNk+ksO7iWdZMD4uB+GSiMZxYMIxh72xdcRJXtM7uNfNmNF4WsZWgYgQkv8RZz1yDtKCUqAYweYDb+LMAH3EANEZDWuscx7yU+bKGRV98VgvOsHKLXBzum5E+lafv5o+SC0DHSVsGtSjwyghN+68ViCO4QYcgzbTxtyRbKc5zyaSArWijyxEB9ZGDsMTXMWjm74ys03s8U5Wg13f+9YDUwvzdRtLebTbvZ6Vec3Z/X9ppLNMsvDtir6TspLwf1i/mCsHcySCU92JyRY2RJwDE6bVa/90zkNHYllAWa/OAqXh3xysI/wM+l0yfMjYmvvqRt94Ru4TFon/xGA8E+2buYTbwVHXQINl9QPze5cQsxB1e1NaLGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(31686004)(6486002)(316002)(66446008)(64756008)(66556008)(83380400001)(54906003)(6512007)(2906002)(66946007)(110136005)(66476007)(38100700002)(71200400001)(2616005)(86362001)(7416002)(36756003)(31696002)(5660300002)(4744005)(53546011)(6506007)(8676002)(91956017)(508600001)(38070700005)(122000001)(4326008)(76116006)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFI1TlhHSFJiRVh6Q2RXK3ozRUhZdUdLL05aK3lhclBRREQvQzFEZjZHU2xN?=
 =?utf-8?B?YUUyQUVjMnJMNGFWWm1YcU5EOEVPVTdocVZLN3VRVWFoRk5SMCtCQXFWSFh4?=
 =?utf-8?B?ZG5ocEtFUWdUV2czT3dhU3VBN2lDeERwZ0RXMEErR0Y0VVA1bUNkUzY2UDVi?=
 =?utf-8?B?WFdOUWVuYWVVMlB6T0J4azBZTVU4Unl1WTBOaDJvVjdGSVZCMUVYN1FnSUVa?=
 =?utf-8?B?NEw5c2haU055Q0VsbWxpZnFJWHZMMjR2VlZDcXBIYW12cnhaSFhSbmNpQmZN?=
 =?utf-8?B?R3NNSGJTeklocXpJS3M2RTRFeXVZeDN2RUZ2MTRkank0ZVorYW9HY2x4Q0RO?=
 =?utf-8?B?NDhkZEprWS9FbktOejJIUkFxWnAwQnFiejdGcVlqZ1dsWENFb0MvRmtkY24v?=
 =?utf-8?B?RnZsTUpsNUdHQU1kMmtlb05SbVd5ZTVKYVpjaFBna1RVR2E4dThrdEswWXpB?=
 =?utf-8?B?ZTdiTmFrRHl4Wmd4SnIremFqeVlLenZ6NjlieWlocUVwTStoa0s0YzhJaXhL?=
 =?utf-8?B?VzE1eU9mbDZucTYvUGpkNmx5L1ZwSXpuRDBIdWxYL0VxSlo1Zi81NU95Sk5j?=
 =?utf-8?B?NlFNbjZPaEN5bFpIQUN5WEZVZXRsM3pXeERtYzI3cG4ydDQ1K0NML0hsVGN3?=
 =?utf-8?B?aFRWWUhqRSttZStQYkw1MGRiSHRicjVOWjladUR3NmlTM05wL1lQeEhoVFpz?=
 =?utf-8?B?S1dUUThHVVF3MGxMMk51M3VhRHdybG1YNm9WeDh4aWxsT1o4a1cvRTROeE5D?=
 =?utf-8?B?N2VObENRRkpTZnhzc0N3WHNSdFJndkdQc3BHTEM4TWhqbzB1RTF5bENkYnZD?=
 =?utf-8?B?dStzUmZXMFFVMVJtaGNPSWM4SXhkUEFYRjI4ZzNKQnNPdVl0elpwb0N4WU8r?=
 =?utf-8?B?T3U0L1J0QmZKeHZKckgwbHB0bm9zTzNpN2ZXdExGcUYzOEJEVHZlbDBlYXFK?=
 =?utf-8?B?aHAzZnJtc2NneXM1VmxURFZFWmZsMFJDUENqa3VtMTgrbmRjZkg4a1BrQzZE?=
 =?utf-8?B?MU1lZUtrcHZtT0RJNXd0YVNOb1hsN1dibnpWUXlFVEZwN25pZ1o2ZEF1OVYx?=
 =?utf-8?B?NjljMmtoQWF6T3lISjVpREU4czFNdm9vTjJGK0RYVDdTY0QvRXh4YU5VS1pU?=
 =?utf-8?B?WUpISHFwdFhmeEE0MytLQUZJVEJ0czJTc2UxVUI2UmphdG1rM3J0am9PbGVw?=
 =?utf-8?B?THdtQ3hEUGYwNDZ6SjlTcndQbDYzZ3k3UGx6dnJ2endheDRPUW5PZW1Gc21H?=
 =?utf-8?B?SE5VUEszZXZxbHhjTGgycHlHeVJJcjg1U3hjUUk5OWVnbUIxRTZ6bWxMTGlL?=
 =?utf-8?B?a1NkV2F6a0gzOXI0Y1MzYlgxY0l3MUdzYkN0emtEbWJFYTJaRlNPQWRRb2RM?=
 =?utf-8?B?K0RjYStNdXluR1BGZ3VkYVErNXZzVkx1VVRVeEF3bTY5aDdTQVVoTlMxZDVP?=
 =?utf-8?B?dmRMcXpBaHlYOUkwZW1sa1k5OFd4U1lvUDVxMWxDbDRrMFJ0VHQrdVpyRE1H?=
 =?utf-8?B?T3hTLzhUeXRjY0oveVB2enowL2srQW1JTnQ5cXRNeldqWDRCLzRmMWpRYVh5?=
 =?utf-8?B?alBSbFZjL2Vob3Zkc3RMNUVZVFZpTGk0cWRRc1YrRC8veU82Mm1MRnJUZ2R5?=
 =?utf-8?B?UUZHS3VGQmtaVnQvODM3ZEg5amplb2NMVk1SRzVSTkhkRCtNTWgwN0VOem9v?=
 =?utf-8?B?K1h0KzhzYkpDZEhiQU1HZVJobFpMV2tqaE1hQmllTlEzTVdxQmhSL2VHUDhk?=
 =?utf-8?B?U2JpMkIvdHhlRWJkSkZuZ1VRTndGRkVDYTNrVUlnbjJpSDAwcGtTeUNwVzlC?=
 =?utf-8?B?NndVTUhQbHRiY3NGVDdxQjRXbnVIUkxVTWhCVjZNSnVmVzljc1NKTDFlcFdt?=
 =?utf-8?B?U0RnczZrWlJxRXZ0eXQyY3g1MVIvOWJ2dnBGSjU1Z2tnS1RhNlhjQkN0Y3Vt?=
 =?utf-8?B?V0kzSTdUa0lmVjZXejUxd2poTWxXOEVyVStiZUgrRjJwaDJsZ0tnZDJWVkUy?=
 =?utf-8?B?c0VqcDJLbldvaGQxL3QxWDFhYmQrTFBiK091SmRaSjZ1NzRXbjJtVXltcS91?=
 =?utf-8?B?c2dOdUhubkZaYmloQVJCNDIyZW9UUXZjU1BCME5Kd0cwSExaT0EzbVN5Qk1C?=
 =?utf-8?B?MTZRZGRXb1FqQmo5dngzUEZ6bW8yM3ZnZWJKWGU1S0NkTU9penA1ekRZRnRF?=
 =?utf-8?Q?Oqh76GcaHS+12mx+bmYaJ8dR+eb5USyGg2vkJEV/4cmY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB5A6D32F2CA9E46A3FB208AE3C086E5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831e1521-8843-4b6e-2440-08d9dad01f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 22:16:06.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhgqUXrvNb/Sk3JfwAVTJ2HFQSrGiEXMY8570UQk/nK1iWw/uj3cd57rMnrBNW+w2qyHg7y8hRgCPDtNgxG41g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1487
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8xNy8yMiAxMToxOSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgdGhl
IGJsb2NrX2RldmljZSB0aGF0IHdlIHBsYW4gdG8gdXNlIHRoaXMgYmlvIGZvciBhbmQgdGhlDQo+
IG9wZXJhdGlvbiB0byBiaW9fcmVzZXQgdG8gb3B0aW1pemUgdGhlIGFzc2lnbWVudC4gIEEgTlVM
TCBibG9ja19kZXZpY2UNCj4gY2FuIGJlIHBhc3NlZCwgYm90aCBmb3IgdGhlIHBhc3N0aHJvdWdo
IGNhc2Ugb24gYSByYXcgcmVxdWVzdF9xdWV1ZSBhbmQNCj4gdG8gdGVtcG9yYXJpbHkgYXZvaWQg
cmVmYWN0b3Jpbmcgc29tZSBuYXN0eSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
