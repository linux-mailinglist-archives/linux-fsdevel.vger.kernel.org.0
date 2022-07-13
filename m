Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F6573233
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiGMJOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbiGMJOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:14:46 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E648DE0F4A;
        Wed, 13 Jul 2022 02:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xt365rmDIa13z2kx+XhEu12oxRLHE77radqapvcVyu63zjUvx7B/9MYygZnnk3Pjj1807LfTYXhjhHqHWXnQuIUJq/5aFmQc3+Z+Y2gJqYN9++jx0GB4JkxhcBuSIdV+yMWhBoXx4OB8sinjLWxFGoSMBFnf52MhIlgXy2AEEFGLPibBim4OEWziTBwINmN20cMTsaf1y+IKDfITujOc79VvwRu76jqyNBGM4bIAtZTV66umP0ZD/cfqmLXN7Ce0MtY0istm68vqcihGdoUOenrCCuAV3LYnSCrKUIgMA6zVHPC3QN5NuYh4u/EiTVt2QsFVHR7onAV9etP9FW3bxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7WRnTBpRwhxMQSFXLE9otVaZPPzyq8UIBFJJPkZaaE=;
 b=kCIc9D0S3/rUhWlCDzPdDnNNLyTVUJcMP1Mkp43U4ylI1oEua6JHRN/Uuvc8/ibxMT9xr7wnw11137p/3y8nDjNJsw3TxixV/Ro+QUS5V1IPCvh6FLmNO9oEtC3B4WjrKgq2sfIFj9/drDQy96BUOYo+dceHiuTH4oXtfXN888hLIi2KqteTGRchvyPpSKSyymHuVwDf21NJb4n0oaceNm7PgCljzNR7qx/DyGkxuvKN3upAWFGJnuMXtMAQBhB/ehPDIJ6OKTaafQcqH5MFDf1BCKdtR5cMLSnsVHeYydfirrYX6F2WWmgar/rK4SixPKcRCHqPTtzEsIvUtRj58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7WRnTBpRwhxMQSFXLE9otVaZPPzyq8UIBFJJPkZaaE=;
 b=ZD8M/Tbdji00QJpeIGVZZbhRAi4905JNtfFv1RMqF8FjbE34IZgCpUbZDG6lxdR1n+9ukYzSDlIS/DUr983ZWY3CbU4MNK5SspZC6NK05DkN5u7akDXYIZyyE2oD+U/SewG4XVIVDra9V0kcVdmQAw0MuP49kpewiFbQ97rXBDh9btyu9e+vRx8Jt4yHb9SBiHXIvYbipaoYFbprKYGrpF94VizGSajQ17q3WWW2qhxw7v6D0TclIyHxwZBELwAb3d7G1HOTVzME2npzZ9JRtHQJXFCuvmWuPcNcikKLRP+oUNMzspBE9/PhSGQpUL6ivY58Q5fXrZC/oxlQDXQT8Q==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BYAPR12MB2774.namprd12.prod.outlook.com (2603:10b6:a03:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 09:14:43 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 09:14:42 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Topic: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Index: AQHYjGHN/dRfjWV95kG4kItzDx62xa1xpq+AgApyhgA=
Date:   Wed, 13 Jul 2022 09:14:42 +0000
Message-ID: <5ffe57d3-354c-eabe-ea38-9c4201c13970@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
In-Reply-To: <YsXJdXnXsMtaC8DJ@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 493a04d4-725c-45d2-dd20-08da64b01f4b
x-ms-traffictypediagnostic: BYAPR12MB2774:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: duzhsp46YVqfsOs0cwoyqLh4KUxhwp8yBcOo1Pz/tKnLROA/5rQZxWg10bTedKQkEVez4L8VlOtDHj6+iMt2mgGrhNXxbdW4D1sj324LOdPr7YaLw4Y/a6yo9FSvjfTRgm1zP03jb6egyKhpj4NxqY3TtMjb5QiDjIzhGKjIO/AIjOa3Wj2+19m6roabf5FmlgBMFMp3tkqRSaYeEy05u97mnTVjUNP8wOssPmPcylTLRCQWI2jnjQAyTqcFpqF8IXG2s3AgbCP11cvN+uMnqm0lcdbt47A55ITGEt6Nq7sbnyf+CbLz++P9x+FqWtuq1I/AAhgFCe9aUny0LP0SSrSdYr1LfK0Gj6PrJvdTCWKDaN5m6E/6QuJE5Ni76ZJ9+OT8nbAwQoA8EFsyXaMyVWxmxB5Q/JMD07Ok6AtwBddKJtBuWZ1dzjk0K8eFSSD3w8xRyqaBt+9fKR7W5wqo8coMjl3sPVg695YodtR86NUJssKqkubU7P4BlpgrfCOIZppO8tCyDbLppcYtZhqulSd54dDL/6wFKl+4EBNZBznYz1qE18t7CQc7nIB4IUvjlcnX7QCA8ErVI3vEA7Owt8nXeFqYF1e6u7O8SLSxbYfAxpCN3p5XrylofPmWjuwYrjPHA8bMdG66zJ7L5HZJy803l7GzX80mNVhlInZgh7jw26JoOcd/mc4jBKa5wr5dYguca6F16Dk84V46UDrSpvk/e3v8VCQCDJZmfEz6GOP5LmIh8LWfP5tngnx/qSX34DetxEIrwXttj4O5LruJ5RhqcUAwPyfceq39YrpbXdqZE2WDhxEsGWGugLXKnlrvnhAXlKd5Sseesm4L/v1gWhoyskcwXAkdojwaRrJfan9k3c7Iut69NJNHf6OlU3JT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(53546011)(6486002)(6512007)(478600001)(6506007)(71200400001)(91956017)(41300700001)(8676002)(66476007)(64756008)(66946007)(66556008)(66446008)(31696002)(86362001)(110136005)(316002)(54906003)(76116006)(4326008)(83380400001)(122000001)(38100700002)(2616005)(186003)(38070700005)(36756003)(8936002)(5660300002)(7416002)(7406005)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFBiU2Z2ZjBHWmJ3Wi84V25iNWJuSEFud2FnMUUzRG82ZDRQTzdLZ253emhl?=
 =?utf-8?B?RzNMTWVMOEFxZWZzMVVKcG0rbGN2MWRDS2VxUzdldGtoTkFZcUxXUkQ5b255?=
 =?utf-8?B?QUVjcEdPZE4vbXh3ajJvSi9LRytsTWFLR0FjMGl3UHFidk10L0poZW9zNTBu?=
 =?utf-8?B?bDhOajcybjYzS3puYjFGR3o3WmZqWEF4ZFlBQ2hrclBrRC9PNXhaZ1dXOUha?=
 =?utf-8?B?TkdNZG83NUI4RTBFbnU5WCtqcktLZFVpeExpUjdEZXQ1MVRrOTQ5ckdlL0F6?=
 =?utf-8?B?Z2c3T0tiRU8rRlZnYTFoWXQ3eU02b3MvTnJLaWpNaXplZFYwdU5uUkJod0lL?=
 =?utf-8?B?blVDR2F6a3V5VGJrVlpubWViTk1jdXBqR1ZkR1FlQjl5bUlHaEZISEpHcGVz?=
 =?utf-8?B?WmJWUitHeVlJTzYrbmkwU3NnT2x0clFiVXhzQ0t3Z0ZIUFR0dHliMDkzc3NP?=
 =?utf-8?B?bFFmQ29YWk5pVmc1VUZHZDhOSThMN1FuZUtvWXhXK0VOV2xhU1RzU2VTZzdB?=
 =?utf-8?B?eW0vUmlhSlNvNVVYcEpycGdBTG0yVVVUUk5uOGo3b0g4cVhHU2hkd1dKTEtF?=
 =?utf-8?B?dFByelJ3VlErUFMvRUhiWnlFY3NNdnQwcXN1bm5ydjZVYlUySGZQalNjdXYw?=
 =?utf-8?B?K2tITmJLVjN2QTl1Z3NwRGtGUHlnbFprbXRxMkUvY0NieEl2aUxDb0x2R0wy?=
 =?utf-8?B?ODlmcXBrV1hjSG9hc2JWWGd4OTc1aU1ocVhVZWRuMmhSZTRqTERHZ3pKUDh4?=
 =?utf-8?B?NWJuN3VGMUFuQzVzZEZGU3RzR3JldmRKNGVNSHdQbThQU2xyaHF5SU9pS2lY?=
 =?utf-8?B?YzBnSWEwY2h1b3pxM29MbGlrTjRLamdCbmRjTlI1Qm02WitRaHcvNnFtbWZk?=
 =?utf-8?B?bUl5cTRLVStobEJ1MmE0V0hDNmI5RXphUkliODhpK29EREhrOWRtblBtcFJp?=
 =?utf-8?B?TDA4WGk1R0x5c1UzZSs1cWJqYjcrZDBjOVVQVXRwQk9CRUJlSkR1UGRncmhU?=
 =?utf-8?B?bkJpK0NRRGJmN080Qks2S0NVQmhHMmVJYW84S1lrRVNVVGE1eUxVbjNGR1Iz?=
 =?utf-8?B?QTRhR1dSWjM4NE4zRlVkRVBxRDFsR0IyVytQbVpMQzBtRWhvTG9kR243Um1E?=
 =?utf-8?B?ZklFT1diNHpISlJiQWJPZ1VvaW1aVnBwYitmbm4xNXAvZEhjNE5CZHR3ZmRM?=
 =?utf-8?B?Y2oydGY0WGQ0S3ZuSm9HeUpYL1RCcUhCdjdDTzJPK3BhTmZIWFEwT0diU2JY?=
 =?utf-8?B?ZDllY3hLQm1MalV3N2FUaEV2OHpRUU5PMzZpRy9JMENSVjhaaml0UjZ0eGZC?=
 =?utf-8?B?RkhCRXI5VXBuaE9TOUord1IzdDZtMGppQmp2L3hzRWJOalBySHI4M25BWVJs?=
 =?utf-8?B?TXhzajN0QjZUMFNlbGFMWFBLY0lHTzdzN3dMVmUxOU4weXRaQno5QXhsYzRE?=
 =?utf-8?B?N1VtWjVqbEhSb0Y2VGRZVkY5RmJDMnVLY0tENThGT0p2Wk5DM21oMGlmRVVX?=
 =?utf-8?B?NU5yaWZ3Z3d2WjQ2cWg0TWd6M09PWXNMdTd4S1hwaE11WCtOc05iN0ZmVDlR?=
 =?utf-8?B?Y1NDOFk0QWhMVzY4cm02enRsU05YVFE0eS9Gd081dWxqMHQzcHRMVUhmNVMw?=
 =?utf-8?B?YXhqOHlNSm1LUGVVSHVVcXFmdGNsNUkzeVdpWGFtK0VJcEM2RFVaR240b2Ft?=
 =?utf-8?B?ZWlQdURiUUh5VSsyRS9VZzV3Y3JYdERKMGduM3RLNFNLTHpick4wVDJaRS9U?=
 =?utf-8?B?RVpqbHZSZTFhb0JxNU1OTmd0a0wxUlhGYkdac0E3N08wWlRpOUJPUGU1c1Vi?=
 =?utf-8?B?MGJWcXJ3SzU3RlFPYXBrbllaTlQ5VVNhanlqdmZsWVhXVXV2d0dvZ3AvTHhq?=
 =?utf-8?B?eDhlT1o2TVhTTGZqMm84QVQ0Z3owWHVQZ3ZrQmpncWtZSDlrQXNBbHpYOHFU?=
 =?utf-8?B?aWlxbFUrWFVzSUFwZGVzd0gvQzlVeTd4MlJoR2tFR0EybGxwY1Avc29veHll?=
 =?utf-8?B?ejJ6SzFWTzkxbWtvZGFXS0U5dmZjekFhM1FCLzJBYU1XdUNBTkxPTlVOTDRX?=
 =?utf-8?B?WERPZGlkVnUrMURsRDRiMFVjd0srZWZDYmJWeE4vNmJtRWtEaTZtSzlTaktp?=
 =?utf-8?B?VUFUenRZQjIvZCthLzROV3YrbzJtM2tpYUl0bWc1enVOZDlLMXp1RXdxemxo?=
 =?utf-8?Q?gbpg5XhqfvH4aOAfESBsUunpKcET1q1mubJ2y9N1J5HC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F17D09610B2634BAEACAC09D85C7F5F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493a04d4-725c-45d2-dd20-08da64b01f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 09:14:42.8121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCe4kakngFnh/xjCmX9Q7oY9fdCViIH69qoV+uqWL+h8paQDg+e9n16iEHZv6AHBYyqH0S6+KOHZhz2eLC3Qcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2774
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy82LzIyIDEwOjQyLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gT24gVGh1LCBKdW4gMzAs
IDIwMjIgYXQgMDI6MTQ6MDBBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4g
VGhpcyBhZGRzIHN1cHBvcnQgZm9yIHRoZSBSRVFfT1BfVkVSSUZZLiBJbiB0aGlzIHZlcnNpb24g
d2UgYWRkDQo+IA0KPiBJTU8sIFZFUklGWSBpcyBhIHVzZWxlc3MgY29tbWFuZC4gIFRoZSBoaXN0
b3J5IG9mIHN0b3JhZ2UgaXMgZnVsbCBvZg0KPiBkZXZpY2VzIHdoaWNoIHNpbXBseSBsaWUuICBT
aW5jZSB0aGVyZSdzIG5vIHdheSBmb3IgdGhlIGhvc3QgdG8gY2hlY2sgaWYNCj4gdGhlIGRldmlj
ZSBkaWQgYW55IHdvcmssIGNoZWFwIGRldmljZXMgbWF5IHNpbXBseSBpbXBsZW1lbnQgaXQgYXMg
YSBOT09QLg0KDQpUaGFua3MgZm9yIHNoYXJpbmcgeW91ciBmZWVkYmFjayByZWdhcmRpbmcgY2hl
YXAgZGV2aWNlcy4NCg0KVGhpcyBmYWxscyBvdXRzaWRlIG9mIHRoZSBzY29wZSBvZiB0aGUgd29y
aywgYXMgc2NvcGUgb2YgdGhpcyB3b3JrIGlzDQpub3QgdG8gYW5hbHl6ZSBkaWZmZXJlbnQgdmVu
ZG9yIGltcGxlbWVudGF0aW9ucyBvZiB0aGUgdmVyaWZ5IGNvbW1hbmQuDQoNCj4gRXZlbiBleHBl
bnNpdmUgZGV2aWNlcyB3aGVyZSB0aGVyZSdzIGFuIGlyb25jbGFkIGxlZ2FsIGNvbnRyYWN0IGJl
dHdlZW4NCj4gdGhlIHZlbmRvciBhbmQgY3VzdG9tZXIgbWF5IGhhdmUgYnVncyB0aGF0IHJlc3Vs
dCBpbiBvbmx5IHNvbWUgb2YgdGhlDQo+IGJ5dGVzIGJlaW5nIFZFUklGWWVkLiAgV2Ugc2hvdWxk
bid0IHN1cHBvcnQgaXQuDQpUaGlzIGlzIG5vdCB0cnVlIHdpdGggZW50ZXJwcmlzZSBTU0RzLCBJ
J3ZlIGJlZW4gaW52b2x2ZWQgd2l0aCBwcm9kdWN0DQpxdWFsaWZpY2F0aW9uIG9mIHRoZSBoaWdo
IGVuZCBlbnRlcnByaXNlIFNTRHMgc2luY2UgMjAxMiBpbmNsdWRpbmcgZ29vZA0Kb2xkIG5vbi1u
dm1lIGRldmljZXMgd2l0aCBlLmcuIHNrZCBkcml2ZXIgb24gbGludXgvd2luZG93cy92bXdhcmUu
DQoNCkF0IHByb2R1Y3QgcXVhbGlmaWNhdGlvbiB0aW1lIGZvciBsYXJnZSBkYXRhIGNlbnRlcnMg
ZXZlcnkgc2luZ2xlDQpmZWF0dXJlIGdldHMgcmV2aWV3ZWQgd2l0aCBleGNydWNpYXRpbmcgYXJj
aGl0ZWN0dXJhbCBkZXRhaWxzIGluIHRoZSANCmRhdGEgY2VudGVyIGVudmlyb25tZW50IGFuZCBk
ZXRhaWxlZCBhbmFseXNpcyBvZiB0aGUgZmVhdHVyZSBpbmNsdWRpbmcNCnJ1bm5pbmcgY29zdCBh
bmQgYWN0dWFsIGltcGFjdCBpcyBjYWxjdWxhdGVkIHdoZXJlIFNlcnZpY2UgbGV2ZWwNCkFncmVl
bWVudHMgYXJlIGNvbmZpcm1lZCBiZXR3ZWVuIHRoZSB2ZW5kb3IgYW5kIGNsaWVudC4gSW4gY2Fz
ZSB2ZW5kb3IgDQpmYWlscyB0byBtZWV0IHRoZSBTTEEgcHJvZHVjdCBnZXRzIGRpc3F1YWxpZmll
ZC4NCg0KV2hhdCB5b3UgYXJlIG1lbnRpb25pbmcgaXMgdmVuZG9yIGlzIGZhaWxpbmcgdG8gbWVl
dCB0aGUgU0xBIGFuZCBJIHRoaW5rDQp3ZSBzaG91bGRuJ3QgY29uc2lkZXIgdmVuZG9yIHNwZWNp
ZmljIGltcGxlbWVudGF0aW9ucyBmb3IgZ2VuZXJpYw0KZmVhdHVyZS4NCg0KPiANCj4gTm93LCBl
dmVyeXRoaW5nIHlvdSBzYXkgYWJvdXQgaXRzIHZhbHVlIChub3QgY29uc3VtaW5nIGJ1cyBiYW5k
d2lkdGgpDQo+IGlzIHRydWUsIGJ1dCB0aGUgZGV2aWNlIHNob3VsZCBwcm92aWRlIHRoZSBob3N0
IHdpdGggcHJvb2Ytb2Ytd29yay4NCg0KWWVzIHRoYXQgc2VlbXMgdG8gYmUgbWlzc2luZyBidXQg
aXQgaXMgbm90IGEgYmxvY2tlciBpbiB0aGlzIHdvcmsgc2luY2UNCnByb3RvY29sIG5lZWRzIHRv
IHByb3ZpZGUgdGhpcyBpbmZvcm1hdGlvbi4NCg0KV2UgY2FuIHVwZGF0ZSB0aGUgcmVzcGVjdGl2
ZSBzcGVjaWZpY2F0aW9uIHRvIGFkZCBhIGxvZyBwYWdlIHdoaWNoDQpzaG93cyBwcm9vZiBvZiB3
b3JrIGZvciB2ZXJpZnkgY29tbWFuZCBlLmcuDQpBIGxvZyBwYWdlIGNvbnNpc3Qgb2YgdGhlIGlu
Zm9ybWF0aW9uIHN1Y2ggYXMgOi0NCg0KMS4gSG93IG1hbnkgTEJBcyB3ZXJlIHZlcmlmaWVkID8g
SG93IGxvbmcgaXQgdG9vay4NCjIuIFdoYXQga2luZCBvZiBlcnJvcnMgd2VyZSBkZXRlY3RlZCA/
DQozLiBIb3cgbWFueSBibG9ja3Mgd2VyZSBtb3ZlZCB0byBzYWZlIGxvY2F0aW9uID8NCjQuIEhv
dyBtdWNoIGRhdGEgKExCQXMpIGJlZW4gbW92ZWQgc3VjY2Vzc2Z1bGx5ID8NCjUuIEhvdyBtdWNo
IGRhdGEgd2UgbG9zdCBwZXJtYW5lbnRseSB3aXRoIHVuY29ycmVjdGlibGUgZXJyb3JzPw0KNi4g
V2hhdCBpcyB0aGUgaW1wYWN0IG9uIHRoZSBvdmVyYWxsIHNpemUgb2YgdGhlIHN0b3JhZ2UsIGlu
DQogICAgY2FzZSBvZiBmbGFzaCByZWR1Y3Rpb24gaW4gdGhlIG92ZXIgcHJvdmlzaW9uaW5nIGR1
ZSB0bw0KICAgIHVuY29ycmVjdGlibGUgZXJyb3JzLg0KDQpidXQgY2xlYXJseSB0aGlzIGlzIG91
dHNpZGUgb2YgdGhlIHNjb3BlIG9mIHRoZSB0aGlzIHdvcmssDQppZiB5b3UgYXJlIHdpbGxpbmcg
dG8gd29yayBvbiB0aGlzIEknZCBiZSBoYXBweSB0byBkcmFmdCBhIFRQDQphbmQgd29yayB3aXRo
IHlvdS4NCg0KPiBJJ2Qgc3VnZ2VzdCBjYWxjdWxhdGluZyBzb21lIGtpbmQgb2YgY2hlY2tzdW0s
IGV2ZW4gc29tZXRoaW5nIGxpa2UgYQ0KPiBTSEEtMSBvZiB0aGUgY29udGVudHMgd291bGQgYmUg
d29ydGggaGF2aW5nLiAgSXQgZG9lc24ndCBuZWVkIHRvIGJlDQo+IGNyeXB0by1zZWN1cmU7IGp1
c3Qgc29tZXRoaW5nIHRoZSBob3N0IGNhbiB2ZXJpZnkgdGhlIGRldmljZSBkaWRuJ3Qgc3Bvb2Yu
DQoNCkkgZGlkIG5vdCB1bmRlcnN0YW5kIGV4YWN0bHkgd2hhdCB5b3UgbWVhbiBoZXJlLg0KDQot
Y2sNCg0KDQo=
