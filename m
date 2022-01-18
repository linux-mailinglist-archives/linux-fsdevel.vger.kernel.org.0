Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B29493064
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 23:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349803AbiARWMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 17:12:32 -0500
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com ([40.107.94.47]:26084
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349760AbiARWM1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:12:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKR/HKXa4felQpSIvpc4TxodyJEUY56WZUGTzwDSvvK+hktw56PHM2zDjP6ur8VGV86RgDWRcgK9WCpYgujHk5Mg6aQVqscbYbg4dhKW0VfYMzeq5Lz7QkEasfni2tIEegBhKucjcX7pyFCQ51yngR0koTaa8wtf8eHE8Rsb3Sn/m1yTlaMlCwiQDVCAZEyCYbdgMVx3jlyxMBpC5P+m33/0YnkxA3+KaWwU1ea5ATeZlEKg3gD8Cg0F1w6c+fjmR0BYtYT+8n0jT8mROVK+fAGIlD76MXlkzlpvyZ5TUoNKxZWeMCckePYfabBPOMb6FP0Pm2V3FAUBYWCUrv11kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQcGE2RD5vm8sY+bJefQtU5ebnJe2jUx0ztTnDFLA3c=;
 b=V1WznV5siXl1FGLGS2ZmNGU981eLIfwEAJ01DX3Y5YkFPR0u/Iil7yxx+6iBAXowNYzn7Ia3fcGjwAvS9KgT1V1wSUbzUlVZQkyJH7zaqaIL6S3wMAoLnMYAFKeNErtUVZHX6RhA/saJe1oj0VpOgAWFDnMrDusuaTPvcYSgn0/UeDLB1g2TRNVZKjRtwfzesNpfaCECuM//N2nfdgNBtuEsF4ItiZk8BlWR1Z0t2+mmpdrRlLSNmD/+W5aL/rf2YSjCZAgb5qM+MkdpKODPwRZoj5R2FxWZbGFkab0/wBt7cbgOFhaNZv1grpTiHVIXURHO9cxSOh93UzJrp9jT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQcGE2RD5vm8sY+bJefQtU5ebnJe2jUx0ztTnDFLA3c=;
 b=JcmykTlfYTcbTqgMj5FEPa54w1Z8qFwrH0IeEPNKrDXFeA1YFSO2fnxbvP11fmdOkeJgkztshHDES3uqwAzgTf2xwUGlenrJL0ybkjmUDq1RWNupkP8c8kcetY7FKDMuiuIb39d/TXnzKvzu6nfueR2B0DlWZ0MOiT0S4ZiAxJi2HWJaaoKvYJfV779dHnVWTGMn5aoFYMxuWBiVTtslEiMAX/J9bYKOV2RBPrxu+r2cJHVGDxoVIsWPsUrJ/PKPIJ4Nf6YHRKYHMb4K0CtUoojKceim3khQk//bTbPZgYsVeeZdQOOyfolvacKzbpk8BbvXWQp+PhK2a9g3+PlaTQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB3137.namprd12.prod.outlook.com (2603:10b6:408:48::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 22:12:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 22:12:25 +0000
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
Subject: Re: [PATCH 15/19] block: pass a block_device and opf to
 bio_alloc_bioset
Thread-Topic: [PATCH 15/19] block: pass a block_device and opf to
 bio_alloc_bioset
Thread-Index: AQHYDDwKaEQTLVOZi0Cg/CObFHXAKqxpWHgA
Date:   Tue, 18 Jan 2022 22:12:25 +0000
Message-ID: <c4d0db2c-b487-e965-30da-507b30f29a6e@nvidia.com>
References: <20220118071952.1243143-1-hch@lst.de>
 <20220118071952.1243143-16-hch@lst.de>
In-Reply-To: <20220118071952.1243143-16-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 402ac08f-9cce-4f55-b50e-08d9dacf9b80
x-ms-traffictypediagnostic: BN8PR12MB3137:EE_
x-microsoft-antispam-prvs: <BN8PR12MB31375ABE3B2CA93FC2F5BFF8A3589@BN8PR12MB3137.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P35+9WhpGmOgRscDuEjiAXZtjgzZyeaINJltJOo3NmdDyvm/8qz0gfIYUXbwFPBAXxHjzKko9dVUuZupQ7cq7kSd+rRY2GbBx43hhAprkPLMxJy7gJY940XJpQb+o1JQwK/s05WwbQsdbeF96cnOTUHc9QUFuQa4u7Fl7yX543g6+LK2bT+3AknsTHCVFnnscgUO1IAHXHZxUVjXzrgZPs8gZdzgbIGDoi/n9sxeaFY5J1dGPiSmgXKQe5wzEW1af+lw3OmZcX1/C48rgbrxLwNE+8R0yYyjCjC3hUgiQcBZzl9izH2YyKZ9W4Zt/+QAbNi3XSxzG2MXhI+VuQ/rBjDEqbZV3WceHFlTqGxSmMgn8ABxIBiTHO0HQ5FTXkL+uA22Kevmd6mu+fbLQHd7abrSpMidRp/K9M3Llal3T8rU7J7LjzLr3C6zjRYIqO97lM8tD6/45fJQv4tT26kKUxQ9QIkJBJV8R9oQpOE41MzMSBg35aHfEe0u1ECmCGII4MkRU+v2fKCRrZmRiyo7quaMyWex8Oz3u9MBnLx3a/ErB/GYqbfSRKvn1WVnk1e+YrvY18NM5Z+mEPqEYoqgpJW5qc9neuJeUp/mXw0ONV2gunz5DKK+3haidH4TBrHi/D7i08BFVrc/lJr7kh7x3z1rLomTyRlAfe80RT2ZzgkMld/kAxlTTKQm9xwMUzXGqsI+LcKvBGTxtjaFFJRZlFSn19ms2mzFT6MT4yoqjuCVSUcdKuqSa+C4ccjyiBaiJye6LLwMnQaPHFgp9ITvPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(4326008)(66946007)(6486002)(38100700002)(76116006)(6506007)(7416002)(2906002)(53546011)(66446008)(64756008)(38070700005)(4744005)(83380400001)(71200400001)(122000001)(5660300002)(186003)(66476007)(91956017)(6512007)(508600001)(86362001)(31686004)(31696002)(54906003)(66556008)(2616005)(8676002)(110136005)(8936002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW1yYlRJbmJhK2hEZVVJOSt4VEIvTkt3ZWs2RWpwQ0MyZFBaQnMwaTNqM0Vp?=
 =?utf-8?B?TzltK1Rxb3FNMEZ0Z1BuaG9zUm9HQVJhSlN5VVdwLys5TnVIR1dCL3czY29n?=
 =?utf-8?B?aW9KWW5rT0NiNGhtME1PZCtXLzdjL2xTS1ZtbmRrYTVOS3F6UGJPQlVCbXVS?=
 =?utf-8?B?ZDZJWXM1TWtqQWFSMHIxTmdBM0NUWUF4WHdQaG1TajE2VTNKNStnLzhKc0th?=
 =?utf-8?B?K3llTENXdGQ5QXM1WVg4aUM3am5MWHZTSUtPbjdkemZObndkYjV4Ky9XYWkx?=
 =?utf-8?B?bWhMMkQvZXlDVGk0TTRxQUFvZnh1WHp3TXNVUjIwbWduUTZtRmNMTFJhUlYr?=
 =?utf-8?B?VHMzL05qUktMRlZ0bEcrOE5aTzdULzJqYWoyTURjOVF1ZldrazliSVBPN0JT?=
 =?utf-8?B?eWtVcGRjeDZDV2ZJT1NqOUdRMURDRjRFL1hDd0ljY1JIVStwaUc1ZXJjM1N4?=
 =?utf-8?B?Um5jZkZkRHZMTWo2emhWTVVXcXlaVDlmMnIzeUNXRTREZlZCLzNucEZ5MmFx?=
 =?utf-8?B?ek5SYkFSYU1jbXQwa3JMMmNEYUNEcjdjWjZNVmZiNVpKcERvZ2RFdC9Lc2oz?=
 =?utf-8?B?Nnk4MHdSUzFxN1pTbzRZM2s5ZmFzdUUxWThFWmppd1Nxd29yQTNVQjAySXQ4?=
 =?utf-8?B?Y0IyRUR1SmkzdW1heUo2M1Ewc0FxaUkwQkV6ZUV5VVo4TkFLbWF5a05MM1FN?=
 =?utf-8?B?STZBNUw3N1BZb3VlMTdZRkRjNGtxb2ExblV2MENxbE42dW5wM2JBdnFwVzFD?=
 =?utf-8?B?c2hCckVQeWd3cjBva3VvTElUUDljd2ZGTU50VmFxUUwzcWdXaFFEUjgreVRO?=
 =?utf-8?B?ZjNyY1doTS8zWnNUeEFscjEvSHZUZUt6VmwwdWhhY0E2SHJ0c2QxQml2K0ZX?=
 =?utf-8?B?UE9xczBhT3F4cG1CdTdMMitveEQ0a3RPZDFEUUNELzhCL2N5cTlmQ2lqcENw?=
 =?utf-8?B?b1kyL3NTeEZuNTU0azEvUm1HK05MRmF6eXdyU0lNV0ZBRWRHbWtYTlJiL3VJ?=
 =?utf-8?B?aEFNTklKeTlRWDJGR2F2V2twU3YySnBsMzQwamE0M3M2Tkt6SEZuRWM0dWE5?=
 =?utf-8?B?RFduNERRKzNwSDhQSW5VQ3lRQ2pNS0E3ckMzM1lGbTFvK0pwaGcwNlhzZW5u?=
 =?utf-8?B?UWtXWTFVQkN5cWN1NmhGNzQzanp5VEREMDFNRm14K1RpUElINU9yZFZDMURJ?=
 =?utf-8?B?TERaUUFnOVRnY24wU05TRjRkd3d2VmtCVkNLbE5CRmREY3p5dlRqTGVaNm1v?=
 =?utf-8?B?VWdUOXAySHZDUEhtanBkSVByZXd3Sm9YaDZVQ3ZUaERRYUd5R0Izem96TmE1?=
 =?utf-8?B?MzRoM0grc1RTMStpZlA0ZC82UXVoRDFLTE1yYmVkNUJhTFdaYWI3VENwQXpE?=
 =?utf-8?B?T3I5c1ZpL0FobWo0RHZlZ0R3OWtHamN3YmJaN3h5UW1DbDdqZ25OTHRKRC82?=
 =?utf-8?B?dnArVGh2cCs1bnlUZ2JTR0JyeWI3SmNaQzk1MmprMFVjb1lsUlhMQzBIYVZW?=
 =?utf-8?B?dFNybC84Mjl1aFRBc0FQdEV1S3ZUQjhSaUc0enRaejhxTFBKVE9oeDNqbUlG?=
 =?utf-8?B?N21weHBlRHNDeG1pc2tTczdWS092RzR2OUNRM3RTMEZmRjdTdU9ycndNY1Zn?=
 =?utf-8?B?aE9hdDY5YXFaUW80N2dpTXdGT05XdEw4dHVVeUV0UnVjai9OZFVtV3dpNFk0?=
 =?utf-8?B?WE51clVhcm5JR2ttVEJUT1kxWnFMMklzMFl4QS9yaHVjYzY5K3FwQlJUR0FU?=
 =?utf-8?B?SXdOaDFuK3k2dmpiR1VEdG1mOVVncVo2MUtiNnJEVFA1U3dYczIrSmxYV25r?=
 =?utf-8?B?b2xYbW9xeGl2djJBQW5vV01SdWd1RkRtaHBaMUp4am9yWUJHRm5pdGVKS21y?=
 =?utf-8?B?c3FmMGVVWjZ6dncybGFpV0FWc1VOUFBhejhnejhtS2szb3llZ29hZ0poVTBl?=
 =?utf-8?B?K3FmbGp2TUc3cUpBdlR0bnhVWXczK2hmM245L1dQZ1NNem0xQlV3dFB1R3Ru?=
 =?utf-8?B?WWJJdkkreVoyQW0yNlgrMW10NXdjcEZZcVRMcThWZnh5ZEYxWDFVSTJhM3RC?=
 =?utf-8?B?WUZISmt5b3hwK0tJaXQ5Q2h2MWhpUkxDeThXcnprWTRCdVVBL3lGaGVVd2dq?=
 =?utf-8?B?RGRSMUhZc3U4YWc4NnFVcHR4Rmk2RWZsMW5SWkJIZkV1eEhJd1Y2TW92eU5T?=
 =?utf-8?Q?GzMzaljxOGpsCDb6F1z9WUGXGqC9AqrRcbuFf0wR+ZkJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E00E6E42D2517540A652FBBB17F3A16F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402ac08f-9cce-4f55-b50e-08d9dacf9b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 22:12:25.0999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzO8dghXgOa2yP3PXOxNcApzIWQklEaL++I44FdcYTVju3yQ15cJa9x3zbVzJjKWKtZU0ribL4KiyYEDdcT9PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3137
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8xNy8yMiAxMToxOSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgdGhl
IGJsb2NrX2RldmljZSBhbmQgb3BlcmF0aW9uIHRoYXQgd2UgcGxhbiB0byB1c2UgdGhpcyBiaW8g
Zm9yIHRvDQo+IGJpb19hbGxvY19iaW9zZXQgdG8gb3B0aW1pemUgdGhlIGFzc2lnbWVudC4gIE5V
TEwvMCBjYW4gYmUgcGFzc2VkLCBib3RoDQo+IGZvciB0aGUgcGFzc3Rocm91Z2ggY2FzZSBvbiBh
IHJhdyByZXF1ZXN0X3F1ZXVlIGFuZCB0byB0ZW1wb3JhcmlseSBhdm9pZA0KPiByZWZhY3Rvcmlu
ZyBzb21lIG5hc3R5IGNvZGUuDQo+IA0KPiBBbHNvIG1vdmUgdGhlIGdmcF9tYXNrIGFyZ3VtZW50
IGFmdGVyIHRoZSBucl92ZWNzIGFyZ3VtZW50IGZvciBhIG11Y2gNCj4gbW9yZSBsb2dpY2FsIGNh
bGxpbmcgY29udmVudGlvbiBtYXRjaGluZyB3aGF0IG1vc3Qgb2YgdGhlIGtlcm5lbCBkb2VzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQoNCg0K
TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCg0K
