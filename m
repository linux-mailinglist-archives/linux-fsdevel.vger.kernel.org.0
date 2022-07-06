Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3D7567B09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 02:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiGFAAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 20:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGFAAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:00:31 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C209183AD;
        Tue,  5 Jul 2022 17:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9qAAJeXjVT6RvBwpCiQ4GvUjLIqN9MkSMiCgtI7bAY3+I43tC7qn2QZV0Gfhy8AkffefR2DxOKMRtFMaIWH/rgZO4L22Utu62lkALjXsXwqxZTdc7E7vvPNYkhOTnoNbT+W6+adgSkpLOs5BT//gEfHtXwLhtjYXgi8BF2oDCRtebh63mCUMnhpX0DDqRcenFjFIzRcq649d8kIZoez/UogCekKsgzAwXjj0ObuU/kK5y3puaNTNrdgASq6J5ouWUEj1Crnx3OPdWaDOzYbn2jj+MS8uS+g75KE8mcGzj5DRCX/IP5HtRKax9HzlKqVyQtIeHeQ+KSYEd7cEKVeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrQYyQ3kf2eqcjzGv/6Yl28DE+omHa8Q0/aYpHYlvHM=;
 b=QSpXFDUGboDB4Rh6AnlugUxYg//4l3rbYeMSTJnm2pyWBoRAG1iaqPKLRHSQQYKdIEGOr0l7ehwH+tFk+Uz1swtwI8LjAVlilojht6T0O64/iqcQmka9sHypQfzygMZJ4cN/BwV42Wb8Tli5v55rs9Ba1u93kXrHmlURUhVNzSLR8bzZ7bMx1rNsQd0SEqYwV+HgDcy7Bf5L8UuHzIWJ/eAmlFIdYNl1nCQEjhUbKO3ZqbGLfBd7KAW4ZozP24dnSrypPckNnRnXexrbW9wbeQbSGNeRWEIPGQz1KUHc9jcUsl6m7kYkuL0vCOMQv1u/ZB2dgaQtAdK0PowSvdjInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrQYyQ3kf2eqcjzGv/6Yl28DE+omHa8Q0/aYpHYlvHM=;
 b=NBEgC8ri85vDhWiM2I+iAm24GTphU97k8ZmeoMlJU37zi4ljyD7nsmJq+3adXqAizNNG/mPIYMhgeEH4Wn7zKI/zByxotug3eDtzs0GumeWZbugKAPfkCQx3uqGlFVlTTXRw+hEdwLeVeCEhmJBUgz2steNHRONc55xPQpXAuIsxq2Fk+sRjhSe5hCaGnMTO6M9eE8qxJqZr6bPVjm59+4Q/AwcMT9GIMvqCSLGTItyld4IRG/0Gb0hAWAsX+r6zvgfFDizwJvmp33aJsfM3SrTDKT9j27KRDjJ5P09oDhCpxTJ6Ijv38jstk5z5J52JMeOc3ESmlGM9LOKPTraS/A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 6 Jul
 2022 00:00:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 00:00:26 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
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
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 4/6] nvmet: add Verify emulation support for bdev-ns
Thread-Topic: [PATCH 4/6] nvmet: add Verify emulation support for bdev-ns
Thread-Index: AQHYjGHt2d/XnVTRGEy+eCt/3MRjkq1ve7iAgAECTgA=
Date:   Wed, 6 Jul 2022 00:00:26 +0000
Message-ID: <d631e0eb-aec5-557c-cfeb-d14b348f4fd0@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-5-kch@nvidia.com> <20220705083555.GC19123@lst.de>
In-Reply-To: <20220705083555.GC19123@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3d4db75-d0ae-494b-c532-08da5ee28827
x-ms-traffictypediagnostic: BL1PR12MB5924:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l7+bhU+D08jLtwrJMSnyLtC1MzbV252nhcNw8GQe9bgMRUeZXaximjD+y+jEbZwfKkAcXXn+r/7ZZ4t1O2XGR0pE/w5GO08bxJ22yt8SVzk+mZ1knk/yiRgspsO3KwMkKVYDAdS1iH/S3ODGUduKjBhTO+kAhLuPuWHZ8KPhONhwmRQtDkzPcmW1c+ZoiDYMel//Fx+mUZE+x9hZJM/dBLAy/VN5Zc7+2n4HygYdtglpKLOOW0pnkTMcPxrHOEHkUEZ5ddc7+mYeUTFndyLKb/19eZR4vCRjmVJqSHw01rPKY9Cl2B8emmlT/2GMzCNcvL+Sr9Bg0G8TzCiusDe+mnbz/XAl6MvD1yqG1SsS08J0HVI3xw1/jdjr6pKvSKBB9ULhVDCtO/936JM5vUHwCZru4JmZCfrMP2AZkdPt9WHHHFCozXWe3MqHaXxUO2OBTVuFib6gkdlrzW0ud/TEDa3Iqds+gC594bnMZi/DWrVtkn6ppYQLLoS9HxubMfknAJHz6/6wh665hwSYhaAu8XyDooyr7dymkJnI5nvTPkZ2LdiZT0weDZ8ubMLA6HrGvAlnbB2NjXLW56ly9n8Sh38+Hhaeu4/1hxG5zGrM8llH4A4NgDZ4xRF57wMz6vsDyK2vWpj2vptF03pXbDvKP+wdfTmwulmHi0f8yh8bhtly9+LmbdX48xjgHUYx1mNH+BwYrrNlbmEilfd1H3rNLF/Qhft1f2Lft4yQZaVVs6UlWdL+Vqq2Dq2E7laMB2FTyzgRCWH3c9fVbBQhtEZRfeWpuuScgnWsyjnUey57hKUcWyD6tVIFUCslLl4WIuRSVKBLi/3Uva2n9iyXykuRpJ/zYs9oN78d9h8LWOfFVAHn3xmrKIdIjYAf8IdJ1rtG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(71200400001)(6486002)(478600001)(6512007)(4744005)(66556008)(66946007)(15650500001)(2906002)(66476007)(31686004)(41300700001)(316002)(54906003)(110136005)(36756003)(6506007)(7406005)(5660300002)(53546011)(7416002)(31696002)(4326008)(66446008)(2616005)(86362001)(8936002)(8676002)(64756008)(76116006)(83380400001)(186003)(38100700002)(91956017)(38070700005)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cCtaanBVeGJNS0xMZjhCaE11MmFSUkVpVDBLRHJPcTJieXdrdDFQcHZNMjVR?=
 =?utf-8?B?aGUvdUVjalN2WWJTZXFReGZNUnNLd1g0emJIaGVsQ2xoYitybGF2MlJMcm13?=
 =?utf-8?B?TjZJQy84V2trTGtJUE02LzlHY2MrTUhIQlQ4NU5WQ0NzUkxzYnArR2dvODVH?=
 =?utf-8?B?TTFOb2wvZWJrbVY5cXllVFhRdE9FZFFZbjk5STZjL2wrclFmRXJmOEk4ais2?=
 =?utf-8?B?aVdnNXNwQ3ozSXZJSzVsK1VaaTNKMlBzbWpySXM4S1NqaGtQZFhMK3FmU21V?=
 =?utf-8?B?d0JJeU1iNUpMTlVwdXJvbVZrQVB4eXRVRUVIUWxrSldUTytjK3dDS3dvRUkw?=
 =?utf-8?B?NlZLTElNb2RXVEFCM2tGb3g4cEw4eVl3VDQrVmtWNDJVWVN5SDh5bW84aHhS?=
 =?utf-8?B?UkhRd3d2OTNaZnkrK0VOWW5hK0hmL0k3a0RTUklnci9Qa1FycFFqMS83cjlR?=
 =?utf-8?B?VU44NnFqdDhGRzZWcFRMeUZjR3VwVnUxQm5FdWlMZm1MWEJVQ2dMNU1aUVhG?=
 =?utf-8?B?RHJGRmkxN0J3TDU3d1NEblNPcHpPZlJrcU15dk85aEV2bHVHd1d3Y3RyeGpt?=
 =?utf-8?B?YzlDWDFTS05yeFBRTllHOWdBYUI5cU4xell4WUlOaW8waEFCRHFlZjRjdlBu?=
 =?utf-8?B?K2s3cDBjZ1hIY2JOQjlveThOMkh3T2ZlVGdmWlJjMk1qeFo1K3RHSy8ydlVZ?=
 =?utf-8?B?RHN1NThzQVhYYTA3ZnNxcEdEYzlreFErbnpQVjZZUnJ6QmlLa3N1cUIyOGpI?=
 =?utf-8?B?bFFTaXRCWk9VOVZ2MDdBUUhTaXNBUk04bklUdkMvN2FrWEZJNC9KYmZrQktD?=
 =?utf-8?B?NmJtTkVnN3g1cXAyL003UWZCOWZIWXVuampIdXh4WG01NG5JSXVUcUV1VmFu?=
 =?utf-8?B?R0FjWEVwQ0NhZFVqTmxUWDVWZVl4VkV6b2l3bkJYc1pMQXhRdGc2ZGlJenp5?=
 =?utf-8?B?bzBZTVZvRnY4a08xamlMS2tnUXp1eGVxTkY4cEUvTm1uQ1FNOHhpaTFBcWl6?=
 =?utf-8?B?alZWdERjSUtLeU5iVjM2WGNSVkZTcWRRaGxnaGxNUzZ6Q3RyZkc3L3JITGxl?=
 =?utf-8?B?WWhSMnlFL0VKODNIOVR6VzE0T0Z6T2psWmFjRDFWU01wcmR1KzV4U0RlaklY?=
 =?utf-8?B?Wnd2SXBhZzdna0hHcW44SUxqMHR4c1F0R0dUVzZnM3pjaHpkeHZZbE92dGw2?=
 =?utf-8?B?SksvbFlTQzhOTjJtMHlQcW85TDRFaGNRaFVuaE9qVDBkRDZ6clhmU0ttK0hL?=
 =?utf-8?B?NVVsV3NVQm4yRllTZHJ5U1ZpbjYvb21LR0ZrMDJmb2NHSzJrQVpBdFkvZElF?=
 =?utf-8?B?SzVrRGlHNzF6YlI4U1kwczRBa0RJVHVuV3FFcEEybUp5d2d6VEJpbzRQemM0?=
 =?utf-8?B?d0VCSHdBM3U3WlRHZHZ4STluWnRrOVRza2JJSEVZTkFDcm1aZW5CNTNBR2tl?=
 =?utf-8?B?eVo3OEZwb0k3MEduZ1MzY0hpbXZSeUhIVTF5MTV1blowQ1Z5TU1EUjBVTTFJ?=
 =?utf-8?B?dTIrSktkbmJTeU5Kc1VQYVpmOWxZS3dKc0FGTTUreHI4N1NHV0dvaWxsTWNh?=
 =?utf-8?B?ekJsb1kxT1pmd2V2YjFMbGQwU3IwL1haRTFuSjZNYWIwbExUaDUwK25ycnNy?=
 =?utf-8?B?K2NwM0QvMmpEK2xBNHVOTFhlSFZDZkZoQ0dJMkpGV3Z2azgxbjVrRTZSbEZv?=
 =?utf-8?B?UndKMnI2ZkR4RGR1VmxpazBDOVFyYU1DdDZpbHBzdVhBTC9VRjd5S3MrRkNN?=
 =?utf-8?B?ZkR6NnhyTTV2N2l1VE5qZno4aWNYL0lCSVFyMXJKYU1UR2dTM0R3cUdIL3pO?=
 =?utf-8?B?Y1RKVEJGMGdUZnJlZWZxT3JFcmxQb3VNQm5ncHZMZVM2aHFiZzFxWGFKYnZ3?=
 =?utf-8?B?bmt0MjlCWXY1SUhkUmF4cjBmUWxROFZhQzZIemh5UE0raEVHR3h1VHZSSFBF?=
 =?utf-8?B?Q0Rwbkp1VWZoNS93bG1BOUxlRTZUQ2VMQzFlVWlCTm1vM052Uy9MWnNnWWVx?=
 =?utf-8?B?bkNmcVVqaEVDdmtHaStzM09ZcmRneTRxUWppSTllNHlzSjF5dE8reCs2WVVq?=
 =?utf-8?B?Z2VNUVpTR3FaN2VZUkduVVU2MFZHZ1UwRUc2WXRydThYVkVjczROeG1kUmI2?=
 =?utf-8?B?R21kV203Z3g4ckZxRFB0ODVHdnQ1Zlg3VFVyZGR0TWtVQnc4VWVtL0hvblhv?=
 =?utf-8?Q?4OYrAnriE2XvEMa2/ljysstNkG8foqv+oBGrfWRw1xaP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E05D62B1B8B404BB4E9636C6802E53C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d4db75-d0ae-494b-c532-08da5ee28827
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 00:00:26.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vb3wXa6k3KCj6unSVUS1StrRS9a/wqf2blF/Y9Kian9BH2I4KmBTLN4tsqtIXnyWy51QsE//6ZmY/fw9BpZdgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy81LzIyIDAxOjM1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVGh1LCBKdW4g
MzAsIDIwMjIgYXQgMDI6MTQ6MDRBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0K
Pj4gTm90IGFsbCBkZXZpY2VzIGNhbiBzdXBwb3J0IHZlcmlmeSByZXF1ZXN0cyB3aGljaCBjYW4g
YmUgbWFwcGVkIHRvDQo+PiB0aGUgY29udHJvbGxlciBzcGVjaWZpYyBjb21tYW5kLiBUaGlzIHBh
dGNoIGFkZHMgYSB3YXkgdG8gZW11bGF0ZQ0KPj4gUkVRX09QX1ZFUklGWSBmb3IgTlZNZU9GIGJs
b2NrIGRldmljZSBuYW1lc3BhY2UuIFdlIGFkZCBhIG5ldw0KPj4gd29ya3F1ZXVlIHRvIG9mZmxv
YWQgdGhlIGVtdWxhdGlvbi4NCj4gDQo+IEhvdyBpcyB0aGlzIGFuICJlbXVsYXRpb24iPw0KDQpz
aW5jZSB2ZXJpZnkgY29tbWFuZCBmb3IgTlZNZSBkb2VzIGV2ZXJ5dGhpbmcgdGhhdCByZWFkIGRv
ZXMgZXhjZXB0DQp0cmFuc2ZlcnJpbmcgdGhlIGRhdGEsIHNvIGlmIGNvbnRyb2xsZXIgZG9lcyBu
b3Qgc3VwcG9ydCB2ZXJpZnkNCnRoaXMgaW1wbGVtZW50YXRpb24gZHJvcHMgZG93biB0byBpc3N1
aW5nIHRoZSByZWFkIGNvbW1hbmQgLi4NCg0KPiANCj4gQWxzbyB3aHkgZG8gd2UgbmVlZCB0aGUg
d29ya3F1ZXVlIG9mZmxvYWRzPyAgSSBjYW4ndCBzZWUgYW55IGdvb2QNCj4gcmVhc29uIHRvIG5v
dCBqdXN0IHNpbXBseSBzdWJtaXQgdGhlIGJpbyBhc3luY2hyb25vdXNseSBsaWtlIGFsbCB0aGUN
Cj4gb3RoZXIgYmlvcyBzdWJtaXR0ZWQgYnkgdGhlIGJsb2NrIGRldmljZSBiYWNrZW5kLg0KDQpv
a2F5IHdpbGwgcmVtb3ZlIHRoZSB3b3JrcXVldWUgLi4uDQoNCi1jaw0KDQoNCg==
