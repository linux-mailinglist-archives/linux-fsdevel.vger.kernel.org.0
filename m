Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFB636DAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 23:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKWW4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 17:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKWW40 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:56:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F2DC5B59;
        Wed, 23 Nov 2022 14:56:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7NL8HoHULqjTiMMuhV1Jl1489oNXHsDB0ivaAXA8s0Z8waSnK3jEbV/x9YlR/FPQOAfUisXEWCxE/jnKT7HgugYkO3Se7B0uqzAJ5SILw9TNyhcMBwBwSVsidUOKw6lGzTdS3ndbYXu6yJH7deMV31O3d8ycWBNqNzAdBbjP6GfpTjGc0iQaSuXPlxX7alweurlKpCWVXvlV8OvXzX5pI7YMm+AKbvDHhsAoveKFtARkHqDZspdfU81pd2XksTa0wyyk0ZCvmgoBqBWZyomwoT+70qJQH/p6ZnsbgCrXcwrAgR3BP6qyojLyUXXNlmQrl1ZZ/4SpUs6FouE9vvaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsdbbK8MOvDKdQZllD/Rzr6ETl6lyot5ErW8HVcSaSA=;
 b=lBH7yRcA3+K6niWKNLk7lGO52ywaD+YFTRlxc3borcmXRvYPpSVI4eQxKaBIlOsVH3sPHqJSvurm5lfd500UYu/MBg9pHSCsxbY70PjzGzm9ZZWYglkBj3d50k6BqQ0qHqgv4bIpldXQxj+UBKocRuzpeIohLdaD2b7g3/TmPdUDxxhh5oNAzWyq+cgql9jgwqk115pldVHOkiXSJQfnHDeA0MBcOcDrfU9PI9sh3Rf9gFrtAM3bImvR2MTGj+yCMUrwGZooKZl9UZqYWW96P+K0hY7uLQe9MRRqCNSSZ8uno31/gNOrgvL4Rnz7gBHlylh2aRhlz4+s+GRQk9eWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsdbbK8MOvDKdQZllD/Rzr6ETl6lyot5ErW8HVcSaSA=;
 b=LfOqQJbj7JQsY+njtzSyYSaGc5/JN0pLPsHdGj/uapDi/P+KU6ur58zKdfYhSRwPgVvxX1WAtCvHcbSjBjGssez0U8m63s9fuZB1FyGn4OpfAfGfNNJaMTcW/qeIk5uzs4t+pC87yOrh4cb/lqXWhmSgo5RMp2kq588K2YBJt6wVQn7b5pEnXvoxCezs8OjI5Qx8M2O3DvOHqRUquLlYNCz+THEc+u0BDkCKcStTq2ZBKLWHboLv1JKC5Jb0q7wkF2BqzjMPr1Wpik8XXptwM77ZTxthjGv6QkigIHWvM+4wxSovXIkHAKDQAp8vgBM880628g4n3Uu8mCdsg6ZsYQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 22:56:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 22:56:23 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "agk@redhat.com" <agk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v5 00/10] Implement copy offload support
Thread-Topic: [PATCH v5 00/10] Implement copy offload support
Thread-Index: AQHY/wLEUhEocurOikWuV2dsph+j+a5NH5cA
Date:   Wed, 23 Nov 2022 22:56:23 +0000
Message-ID: <cd772b6c-90ae-f2d1-b71c-5d43f10891bf@nvidia.com>
References: <CGME20221123061010epcas5p21cef9d23e4362b01f2b19d1117e1cdf5@epcas5p2.samsung.com>
 <20221123055827.26996-1-nj.shetty@samsung.com>
In-Reply-To: <20221123055827.26996-1-nj.shetty@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6033:EE_
x-ms-office365-filtering-correlation-id: fd5d6bae-c707-423f-64d3-08dacda5f185
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BcTNfeNaGyCRY7FCma5ImA3PnmKcmpWaPpG0wGZYW90QcQ8qcVzzF0pbBI55wqv3rBgRzXUOT4VNWPhqWw7Vy5hgAkrjilo1sAH70q3JYD6gp8CyphvG6c1tYxURXty/noygTZuCdlHp1wYo0TNbNHCTUg+LFLeAXdTJEpLsQi5cTzs7dN8qxNk2dKroRN1XP9Vekvbf3XHBDc2ReeUsN04+TYWYxnFo2blCFeU8lWjrEdMZm3I5FeHV/YNAHSxZEPJAdr3818xGozT2angYYny11yFlmit+tNTZepAMEdRrXJi1yZyu6KJYei4osU5kJ9LUQR64m8jn9oR5kGhkJexqle3xB44PB/kwHpW47CsdXyWkCFgKiT6F9pMllZPfyfjFVBLvZXPXOZLKPfzrYYhckF4lUsdZuJrbSrTQgmksY8HnEh3vyMmNpA9AQ/Nluxx6Q/BksyGQSB1r91DE5g/bcyaYOtu64IhIoPCYEEQReTjDwvaGX9VnVifteytwZaTS1ciXLu63SXmXpAKO90yXCLwV2H65tDlm4TqafaA+Fk9mK3QyeRPa5/6AF95XuBmEkoj0XW3wa4G4EO4XL8r74r06OkeRSrfIDPVA7dWVZlK6wBzpaj4QaPyOpusyuCSHvP6xUUrsET3ZaI069w3rJCwKRNmR7Ug7734KFe+ivoen52ioDbhBZcqIt5bhUUSLlAfaLWsL9R86IjsJp69Vbld0kFw/AZRgNvaqNolYWeqAnLg0N+xjL51u/Tx1o7Jis/c+VoqenOP+RCnzRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(91956017)(38100700002)(36756003)(6486002)(86362001)(4326008)(66946007)(76116006)(478600001)(64756008)(8676002)(66556008)(41300700001)(66446008)(54906003)(6916009)(2616005)(186003)(2906002)(83380400001)(6512007)(316002)(71200400001)(6506007)(122000001)(66476007)(38070700005)(31696002)(53546011)(4744005)(31686004)(5660300002)(8936002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVc3eDRIM1pEeEhuN082VkFVU3hMM0U5RDk2QThWdGkzemUydEp5Q1NzUzFT?=
 =?utf-8?B?YWNjS1Q2bmJQbFA3ZjIrUEx4Vlh4ZS9vOUUxVG9xelViR3VENGtTM041ZDdZ?=
 =?utf-8?B?U0RxZnhjRHU0VHp1QzFZaVlDYTRsVnN4VmU4aWQ1aUl1cXRuMENqNGppMWVh?=
 =?utf-8?B?K0JGc3d2cmc4Vkw2QTVZSFpBLzhYTFdwdVpRU0ZkZ3V5SER3YlpSbXVLNCtC?=
 =?utf-8?B?aVBpaGp4QmRVNkxWVDdHeC9jN2FnU1JJdzBpOW9RTTJ0RGUvKy9oOXFWRU4r?=
 =?utf-8?B?MXVCemF3YTMvWVVVaEM1SUFtRkxEeUJFd0xtK3JoeU5lMmJ0VTNNV3ZSOEpF?=
 =?utf-8?B?UnMzblMrblh1YW5aVlN1SExkSVhMWmpJQisyZXVCZWx0WXNlaGlMcUx3MmxX?=
 =?utf-8?B?Qjk0bzBiZytpSWNiTVpsZ2FxOXM2dkV4UzZyYnNEUlpvY2VPMnVHVzYyUnhI?=
 =?utf-8?B?aVdqcml0QmhKb1lld2s1d1l6Vmc3TFNPVXlYcmZDOC8yRXpHbS8rS3hQTC9S?=
 =?utf-8?B?NllHdXJtWktpWUp4dGlWK2FCUXRrU0t4MmtVR0hYM1dYYUFnZHBNMWRCT0dK?=
 =?utf-8?B?eXpVUFVjODQxTEtNS205b0NuckpMRGJtZXZ5UGhXMWUxckdLS1hDWEM4SlY1?=
 =?utf-8?B?Nk83Um9SaWVHZU9sRTRLT0JVK2NYMlZSYW5oYyt1SDRQQlNEUVdZRitteW82?=
 =?utf-8?B?azNKZmcyUE5oWWcybFcwcXNmUUJUUFdKTjlyMnpEVFdJYXFyV2p0K2RlelJ3?=
 =?utf-8?B?VVdxK2V1VzhDWjRONGNVSzFra0JoUlRQZGZja2NUaDdGSWFFYjdNdmNFY1cr?=
 =?utf-8?B?NHJua0htV1VGZlZNODVIKzNLTDVtSjVOdzlJWFFBVi9zbE5zN01xK0dUaUhj?=
 =?utf-8?B?ZnhHellWeU03UFJ1d2h6SVRVUUEvQy93dXFXMEpmT0UrWHY4Znp4N0U2S3dV?=
 =?utf-8?B?YnVJbjRMa091L1ZtVHc0M1FhRUtMYUVRMndsaXJzS1V0UERGV1NQZjl5RFFl?=
 =?utf-8?B?dVZsYjlUV1JBWmgxMDlaYXA5SlB5a3lSMmVDMmRmMnBiS0Y0QWx2TWE2bVhh?=
 =?utf-8?B?cmVLL0RlUUtrUVJhQmd2TjZ3ZE5CNFZxRGxsOGFkSXY4VTVONnhvSm1TS3BQ?=
 =?utf-8?B?ZWxlNUloeGpJTWxzWVJPYmlYYko0VDJVRmE0UDdTUXRQSGlSemZMWHJya0lK?=
 =?utf-8?B?NWNuNS9JTFdTelRHallZUG9nY21JckUrOGxjRGJFTm5CTDVPSzJRdytHUmRq?=
 =?utf-8?B?S3J1aUJPNTJUSTNRUjRqS0R4a0Y3NE5oRUZObDNJTGk1VUJnSmZGVytBb1RM?=
 =?utf-8?B?MktoYlZtbTlsZjFxaXp0ODdhZ1kySWsyaTdObzh4aGlXYWYxVUwzVUd3Q1JS?=
 =?utf-8?B?bEh2Q093eVlZV3N1ajBNRllpbFZRZy9RcWZSQlIwUWhJUmVNN2EvTmZ0YWxS?=
 =?utf-8?B?L3VUQjNtcXBINWx2NTFhWG52OU1NL3N4MFgxSWpzN1dqKzNCNmM5VmkxVGZH?=
 =?utf-8?B?eXpseVB2VFBjd3FwbFlSclNiYUZXSTQzNForWTU5eGVyRkxTMG1MT0FuQkhN?=
 =?utf-8?B?RHJNeXFaMm5uYkVkZWZXT1FnR2xGajU3dldtV3lGUFB1QTZvM1l2eHFqL2o3?=
 =?utf-8?B?VjBmdms3Ui9xU1NBcWVsUmRQRWUwbzVwbjhhSzY3S2QwZnpMQXUwdTZubDcw?=
 =?utf-8?B?eXd3QTRTVFcxc2h5SGROWFFDRlFRZjNhOUdqbDB0NndyOEVSaEQxUTVnQVlp?=
 =?utf-8?B?SkZEVmhjMXAxT2J6Vy9mdG1oeFZ4MXZKdmF4bmpod29oMGx1VTN2Mlgrd1FF?=
 =?utf-8?B?KzFCSlgrSmJLWFc3RUFWUkpxMjlRQ3l4bFZhYld1UXRCeFBtQnN3U1dtdmZt?=
 =?utf-8?B?aUF0czdGeDdFRlZOeXF0eTMvRkYrbzlRTVZwQjlrYmpNcHdoU1ZaVUJvWkEy?=
 =?utf-8?B?N005MGlEK0Z6dWdjZkxUM3ljMVczSDFuSFAxMDYxMHdjcnN2WklKczhmVzJN?=
 =?utf-8?B?UzZFQlgxbDZ1QWpRRjY1Z3dzL25UblFrR0Z0aEhuWjBodG42aWJnVldoeW0v?=
 =?utf-8?B?Nzh6Z090c1dhVlN1WXhMUFU1UG5MRnE0Zm41QUR3WWYyN0YraExKVjZ3NDhu?=
 =?utf-8?B?YXRzU0E1NDFMZFErajJFQ3hrRHlVeVhmQVB5UmVBOHM5THBTQllyUEhCaVFw?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11DE156DC86B9F40A76435524E1C3AFE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5d6bae-c707-423f-64d3-08dacda5f185
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 22:56:23.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdLNY1HocNbd1GhZ2pHzlefYRYL6R6hljE7MiwoYwdgZkKY06hkE5xEGe4JxF42wj7NvU/4Kbv4Bi9xl3XH0Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KCsgU2hpbmljaGlybykNCg0KT24gMTEvMjIvMjIgMjE6NTgsIE5pdGVzaCBTaGV0dHkgd3JvdGU6
DQo+IFRoZSBwYXRjaCBzZXJpZXMgY292ZXJzIHRoZSBwb2ludHMgZGlzY3Vzc2VkIGluIE5vdmVt
YmVyIDIwMjEgdmlydHVhbA0KPiBjYWxsIFtMU0YvTU0vQkZQIFRPUElDXSBTdG9yYWdlOiBDb3B5
IE9mZmxvYWQgWzBdLg0KPiBXZSBoYXZlIGNvdmVyZWQgdGhlIGluaXRpYWwgYWdyZWVkIHJlcXVp
cmVtZW50cyBpbiB0aGlzIHBhdGNoc2V0IGFuZA0KPiBmdXJ0aGVyIGFkZGl0aW9uYWwgZmVhdHVy
ZXMgc3VnZ2VzdGVkIGJ5IGNvbW11bml0eS4NCj4gUGF0Y2hzZXQgYm9ycm93cyBNaWt1bGFzJ3Mg
dG9rZW4gYmFzZWQgYXBwcm9hY2ggZm9yIDIgYmRldg0KPiBpbXBsZW1lbnRhdGlvbi4NCj4gDQo+
IFRoaXMgaXMgb24gdG9wIG9mIG91ciBwcmV2aW91cyBwYXRjaHNldCB2NFsxXS4NCg0KTm93IHRo
YXQgc2VyaWVzIGlzIGNvbnZlcmdpbmcsIHNpbmNlIHBhdGNoLXNlcmllcyB0b3VjaGVzDQpkcml2
ZXJzIGFuZCBrZXkgY29tcG9uZW50cyBpbiB0aGUgYmxvY2sgbGF5ZXIgeW91IG5lZWQgYWNjb21w
YW55DQp0aGUgcGF0Y2gtc2VyaWVzIHdpdGggdGhlIGJsa3Rlc3RzIHRvIGNvdmVyIHRoZSBjb3Ju
ZXIgY2FzZXMgaW4gdGhlDQpkcml2ZXJzIHdoaWNoIHN1cHBvcnRzIHRoaXMgb3BlcmF0aW9ucywg
YXMgSSBtZW50aW9uZWQgdGhpcyBpbiB0aGUNCmNhbGwgbGFzdCB5ZWFyLi4uLg0KDQpJZiB5b3Ug
bmVlZCBhbnkgaGVscCB3aXRoIHRoYXQgZmVlbCBmcmVlIHRvIHNlbmQgYW4gZW1haWwgdG8gbGlu
dXgtYmxvY2sNCmFuZCBDQyBtZSBvciBTaGluaWNoaXJvIChhZGRlZCBpbiBDQyApLi4uDQoNCi1j
aw0KDQo=
