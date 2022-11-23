Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6756F636D73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 23:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKWWoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 17:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiKWWoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:44:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A093D1173C1;
        Wed, 23 Nov 2022 14:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3KExL9otTiWJAMzszDARk/UXajjwWxOM9KWNskQau9unUY1BQKMLNl1gM/8QAtNpyQPWN/Dazbi0QsKS1DyZtPRwvmPPurrGs3xs5lmvgHE5FoTpvGnrV8JDFV1ltQc+2a5ecWJJjJf/t0psJnKDlKcoR27N2K+IkkbxyQeLvwZhVmhe0uRvrTDgUTbHGwcg1SFxkRH/ayeNugofqjtM4jFlkBaKeJ5p1M1d3fGb3+46inv5vS3c4V+2qBgxDi50o89ZBi/WmE0d6Dyn5MjTSr5uMrJDPKtzSRrM7ZkxzZIyaWWl9iuL7o/7c22SIiSf4bmfrqTz6OPPRpuSKpWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq9MbIaKUB7yI5BeS6+puufznqLQZ1hmA8z7iYvLICQ=;
 b=C1YrMc0Qf3J5hz7wmz9emXKUWIl1KnTkP4MXtiyrSv3CwVvCOoPKydTA9SpUVTqYaBopItMZMqQulF+Y+90gbWK6s+lP6ywhrTDdnFxQWDG5WraZUAmwTVuiikoNVNl3jxWQIstrQY5csSq6RBf2udHVJj3IwhWoJwy++hFvG7rqks0KQYN4+37GflwBGQPpcZKPgLjdUM42AhorRix6DIPlvY5gvbIuFGoBqtGbTOm70zqDUcTiQlHaqH8nvnQmqJ3CL0uqoPNmepM+/0xAB2sBG0d2IHwwX2Lw51nq6+VAfM1OsWVxv3ObUVcnceYF5991Hi1HCPh77R+Eey8LZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq9MbIaKUB7yI5BeS6+puufznqLQZ1hmA8z7iYvLICQ=;
 b=KCJ/GYxQ8xYiKPZnxBUNCldiYeK74qgkYS+/r/mqHLOEyA04+JaAbrg+mG6OS2ijNAtWFFMexFUKrGSGylWYXH5Vn1c4vhRdctlAcIe1fUj5lLewO+v5lEsB1uEkehTpypIMEtiKn8HRzhosS/I9FfiFoSU+iWadpXZ7YgXYOERilIwo/X7zcPRSyKEB2gMwsxTZseCQ20Z2ITnqJloO8oP5yumJbKFBzjtzPScUUq8YpcQQ2KtcQ6jt1h7KDws+icJ3Vd30png9nufzJe+4aAyLVji39TntdK4nEIa8NffTrtgx3/CzPWdGyhe1kvaWYEQCK8ILHRGCsuurtmoaHQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 22:44:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 22:44:14 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] block: export bio_split_rw
Thread-Topic: [PATCH 01/19] block: export bio_split_rw
Thread-Index: AQHY/N5fXfwnUGw1PEewu+QutFIGGK5NIHwA
Date:   Wed, 23 Nov 2022 22:44:14 +0000
Message-ID: <eb2387fd-7761-e919-7d72-e947076d2a58@nvidia.com>
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-2-hch@lst.de>
In-Reply-To: <20221120124734.18634-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB7757:EE_
x-ms-office365-filtering-correlation-id: 84c71911-1112-4c67-7c5b-08dacda43f64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YW7q3HS1gwwcwS8CeBdUuHfBJPatfY2KuxrhFC8QXvXD0cCAMvZHBB8wuIbY4mHK3+U4fhoKfuPWLq+DpB36eVUe1Jv7OJPtuZIuPkQs9t3N22F3L3p1lh5uPgZ9q6GZHCrrg8BDd0S1kHhO0cQu68cugdG/+njw00rKnG3cPew6V7fgT+VOD0+FZK4YJCe1QMou5Gt34iKFcNG2k2Q5Mb8Otd3FUFgz30ByTydynjZD2WasOq5qzub/AtVurILSTSiVltDQkj+ad7uG2Vbab/r8tZlIIXHsKNCSsWMKhLQFes7uVKQ+QUJzuxi97QlVJqCntnfCOgy3+Ve2nmCapFW1OgBHDURbr9tFarcsMyTV+0jCqaHFVWfbwDcLGESHKSLWUS38aoK9WWIIQ5f09EwYa/ogtAxcSSHkJTMcitPiEmem06g8ke79viMqjNZ9XbCaxowPyIfBaUvmR9gSSrFP/bFkPMBW52gApbFmnWK06ZjugGnw66Va6D0/5cvxosCh5lqqf5Hy4jupDiS7pJR6LembQVpIxPq1lcMevkMGKGi0lKFT/AqG2YodB9w98KjNmpOBoE3uW00tAqiAy28Cjc6LFFomtnbRtsRC4LJuhrCQPHm4+2ZOUln3cD09a3HVzmwSB+iOsHtrqSivkCA++G4oPbQzckcGNOjr+gg2QCsNNQWimgwHf8qOTujESG62zWScB+3avY505HTr6H2mYtq/m3TtXp7k7jugbdMNCTgmhS93jtQgmukWcAqzW9Lxci2l3cB6cOyEb6Lwtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(38100700002)(122000001)(38070700005)(86362001)(31696002)(2616005)(71200400001)(53546011)(478600001)(7416002)(66556008)(6506007)(64756008)(66946007)(66446008)(91956017)(4326008)(76116006)(8676002)(316002)(41300700001)(6486002)(66476007)(83380400001)(110136005)(54906003)(2906002)(186003)(6512007)(8936002)(5660300002)(4744005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEVDdHdWR0pZN05DclBUYTJSSTNEa2x0TmorTjgyQzFiR1FVVU95TE5wbUVa?=
 =?utf-8?B?UDdzTlVmZDFpQlZHbEZkdk5VY0NhY0hra0tMMFhQMVhMcURHSFpnZE05TXpm?=
 =?utf-8?B?TnVUeDg1ZGNzMHhoSDhkMkkxSWFxWkoyUmRJTWFhMkd2eFl4QW5XM1pRZkc4?=
 =?utf-8?B?NFNQNkZHayt4QVJxTXd5WExRQ295eVk5VmkzMnQvb2s3aWdrNndlYmpvVjJV?=
 =?utf-8?B?anpYbFdsSDliaStaWFZmOWFaUmd4OHRIdWh4NWEydFBJa0Q1TTRkZVpSbU9J?=
 =?utf-8?B?d2lQbWZZYWZIUXE0Q3U0cVljMVJGR2NXTGFZbkcrWHVQbWhNSmxwZG9Ga0Y5?=
 =?utf-8?B?YzlGaEd4RGFLRDZka1V0QW1VbkNUYmN0Zjc0WjkzQ1ArRkxiZlZQNy9Vcnpw?=
 =?utf-8?B?Uk5Kd1BsMDlsUE1CNENVYnBwaWtXMVorT2lVaVNCamFNakVTM3hRcVlzZzRv?=
 =?utf-8?B?akhXRmN4T0UxTDVvb08vdjBKN0RMcjl5SUhSdFZNUThLcmkyOTJDeTNaWUxD?=
 =?utf-8?B?SXJzZlhOdzN5MmZiblVxL3Nab2plQXFRa3dHZGlTQnVmTnU1ZXlpaFFuYUhF?=
 =?utf-8?B?d1J2OXVuQWlPOHZOMHlFMXROYVNZTU82YmwrNXdBR3F4SFFSSy9VNzUvc1NF?=
 =?utf-8?B?V2xVQWIycFpEQzRjRTFzK25BNFZlYzE2TDdxQXVscDlrVmtvMW0xT0JvcUYv?=
 =?utf-8?B?cGFZTTdObmtValIzY2E3QkNMUlNYanpYeGFBaW0raCtVakN6K1RxSlJTOU84?=
 =?utf-8?B?LzFaU1F1UVlTYlVubGh3RlY5T3luNUJaTEtjVWdTbnNZdWlhaEE2WnpLWnVR?=
 =?utf-8?B?c1pSbVUyZmE2S1djdnZQWEtTOXVxT284SVVPTEo4SWQzdkpBNzNWZFF0a2hv?=
 =?utf-8?B?NE13endhdXZhRTlwS3p1ejJQcFc1bmRyajFQbkpnMXJjWWJicFNWTjN0UzIy?=
 =?utf-8?B?TiszMXQrQ2hWaURxUXZWVldKOUNkQmNCaHJzb0hUV0dUSmdrUkZxZStseDNi?=
 =?utf-8?B?MkpMUFJhZllMQmpMcmZXSUZHbGh3TVFLcy9uSkhMOFRYVHk5SzJsT1JkWVpN?=
 =?utf-8?B?dzFna1VVZG9ab01DNFpmMUJXMlAzNS9FUGJiMzE2amhWQjFJaVlubUpvZk1G?=
 =?utf-8?B?RDh2Ky82UVc1emVteUV5KzNnUjh0SmIyd1JXdktmYythaU1IRVVsU2lxUzBi?=
 =?utf-8?B?R3YxVjhDNmlyQjNoUFdGeEpuVjFEZXQ1U3A4QWR0RmlJRDF6NDJNWWdWSGNK?=
 =?utf-8?B?VjVmMWRSNVhqVGlKMEh6dzJKU25NNHg3bjkrS1lxU1hWa3ZQSzRnYnIzL2la?=
 =?utf-8?B?Q2hkN2dGMU5pT2ExcWJkbksxdUo5Mk00TGl6dWdNeElTOTV1cWptbnIwbDE5?=
 =?utf-8?B?QStVS1EyYXhVeTVMU1M4ZGxkc1VTWm5sTGxIKy9XMW1zNzMxc1N6M05SQ0NG?=
 =?utf-8?B?REZEVUlpaTBMMXkxcHRqY3FtZUk0UVNZa1VmQnhPazZsaUZ0Mi8xWkF2VEt4?=
 =?utf-8?B?S0dwcDNRdG9oUnRUYmxHVXJKZ1dONmtza3ptcnN3dXJqQTVValVmYmJnbTM2?=
 =?utf-8?B?b05KMEV6eURSMnlXYXZueUg1dVNZZXNBM2wyR2szbUxZbnNldjA3NDZaK0ZQ?=
 =?utf-8?B?UEJLdlByZ2JaYWx6dXQ2U1NvSmF3bXlWaW9SbDJRWDVML2FtWkdmN090ZGpL?=
 =?utf-8?B?V1o0RmNESE1lclp4VDBwa1o2VEc0N3l0eVh6cGxqQzNMSWp4WWdsanM1eG44?=
 =?utf-8?B?Q1lYYVNPMVAxSno0ZjBPYlNwck9VV28wRmdpdXRmSDlOUmRLdDZ6cVpKaVdX?=
 =?utf-8?B?QllNTFVTaUhjckd5TEVsTW4wMytMNUFCMVZ6dWJDYmZwSjFDNzl6SE91aDFG?=
 =?utf-8?B?MTRZZmhNQ1hLcERyYzFpSFN4eEppcFBYSkNyK3NhZUxXWVY2cnJ1Vzd6SjF3?=
 =?utf-8?B?S2FmOFdZdjdQdm1OQWdkQlN4ZVVLTWFWVlozcy9lR1lCaDFhcnVTM2lsYjVX?=
 =?utf-8?B?SEo0RnRFZnJxajU5Qzl6Q1p5cWZ6S1pCS3pwc0NxRUlieUxIRHVodXIrM2FE?=
 =?utf-8?B?bkp0dlpGVkI1ZVlPajZkYmprWEdrdTNlbzlwdUFiWmNFc1VHaE15aTEwdWsw?=
 =?utf-8?B?NGxhckhJbStKWVJ2alQ0M1paMlNlVExiZWxXbmZ4OFFqVUFhZTNvZjEwRzcw?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E9F39DEC3775248B17862D665182B82@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c71911-1112-4c67-7c5b-08dacda43f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 22:44:14.7914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwaQhlFKHegLQk1Wvm3unWlVOuO6oVoOVWg89GOoQTBpH/K7ZUIUt4uOxqd/yc/p1dBoej1kpI/liNNz0oeLEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvMjAvMjIgMDQ6NDcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBiaW9fc3BsaXRf
cncgY2FuIGJlIHVzZWQgYnkgZmlsZSBzeXN0ZW1zIHRvIHNwbGl0IGFuZCBpbmNvbWluZyB3cml0
ZQ0KPiBiaW8gaW50byBtdWx0aXBsZSBiaW9zIGZpdHRpbmcgdGhlIGhhcmR3YXJlIGxpbWl0IGZv
ciB1c2UgYXMgWk9ORV9BUFBFTkQNCj4gYmlvcy4gIEV4cG9ydCBpdCBmb3IgaW5pdGlhbCB1c2Ug
aW4gYnRyZnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4NCj4gUmV2aWV3ZWQtYnk6IEpvc2VmIEJhY2lrIDxqb3NlZkB0b3hpY3BhbmRhLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdk
Yy5jb20+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
