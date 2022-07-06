Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F13567B86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 03:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiGFBcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 21:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiGFBcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:32:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8FF1838E;
        Tue,  5 Jul 2022 18:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpLQkdqAR1/j53dFQeiPO9Ui41vw7mw0i5MU5WTd3SxJ1rsHSKrGsQcta1k1GEwVKpa2WECtKCS2QjXk92NoyCfa+gQ00lG6de0psfYZn9/1+yJcIJeBxuGgX7wXcRxZiI7DkoweblLLhSYOomUd9BSKimp9kQfRV7pB8rW8FwdIiAda1OmpjAPGMkQ2EYyqgrDiFoivuG++gTR4KYqnFEej8BoKI/rNebdpvOsaQoMM8s8OBAcm4OGns3ykxNFyF8T2PqW0oanYOBoL/yzOevbm6DDKnQxX8mv0ab/Hj+IlrklJbbiiSlm3e0kvA8zLipD6ufHS+9XZqZo//le7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rE9jSQkEEJLz6bMBKBzqM64C+9EQOY0w8LurI8pV1R0=;
 b=FWjuY0Ddrzz/C7hm9jtABziGp72KWFDdg0K2dchCxQxs82XiMP4HaGMU8xYrKis4Umbmx8A2YxJGCPBaX13g1/1tabxZvOBp3ykjckGC16AxuwcQ/NHYmGmWBrOYQ5jXFarzwdZtND/9Euxrfzxj03aW5HC2eKk4ch0C9KHMhkf1b2VAbdCOcL8KQrS06NEX33WxKJwNLde3nPErR4+8kdDt1zGQPyvvUUI5xVh7hzrrfpK3qR3qEHg1ha/J2SZklfjA1iH39lYHydpe2kvwbZIyqrUzKv1tPZfwy7t3LfmT2+zu4JcY0tGd1cXwzYXFON8HG6toN36yQX2vKZEwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE9jSQkEEJLz6bMBKBzqM64C+9EQOY0w8LurI8pV1R0=;
 b=RNaXguAmM8riCWh//axsMEHOIH11REIJG12z1z5CddGC9lD/z0IJIRrWbWfjYHSDHhnZXBoFll4vQeOY6eu/3uc13vaEUJPELJtcmVg64XaHg2tYVGsrYQotsRaMk6u9NQKh02UbVEmz3u93o0Psp2BBs38F1Ju61FvKPmmbDDkdKJjhEHdBW6sfhmgtbINqUvCU95ExUXThfNL3X5Jkdsblzf4pKLPS3655aMNkHkIBZtJjjoMrNCqtfdH3HjnGw5DCwh1DtvKI7YDLvATDiZuI+0ezQFbbfESme6l5n6PBUKRKf9gahaWcqhlV1x5pUbd6LPnke9d9hqc//PKRAQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB2404.namprd12.prod.outlook.com (2603:10b6:207:4c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 01:32:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 01:32:01 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
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
Subject: Re: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Thread-Topic: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Thread-Index: AQHYjGHTGA1KUuSqQ0qn1A7ygjqAAq1oIUiAgAfko4CAABLCgIAAfu8A
Date:   Wed, 6 Jul 2022 01:32:01 +0000
Message-ID: <e5794ff6-5174-c1d6-3c48-db4a35f18890@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-2-kch@nvidia.com> <Yr3M0W5T/CwMtvte@magnolia>
 <476112fe-c01e-dbaa-793d-19d3ec94c6ef@nvidia.com> <YsR7lbTfBH0dUMMg@magnolia>
In-Reply-To: <YsR7lbTfBH0dUMMg@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8320733-434b-4073-acc2-08da5eef531b
x-ms-traffictypediagnostic: BL0PR12MB2404:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2fhkrlZDjvmAPXUKf3A/xfN+PPuyJ/0DY9ZKs7vsqoeJ0CXzUvfXwoS7fzMeEhMGWW8uM8H05xcuSrQ7+iMMsb4n7btsVO1jPRJuloKcxX2sUeCHqU52wsrXNt5Pn7rtp5C1xX56GB7n4zQGJ2Lq9tyUKtq5YmgeKnI7VTvYbq5DpJ7mCL0Ef9v8dCop577kVT1C4PpuL5QzrahINKy8Gpcbn8mTxu237xSIYXDRefT0ecp8fbfNx6CJ9LSq8FTj1xH+sw8IyFaF+Gm8euyTR7SaLkpg0hKZSOB+Yu4qUf6sguYttQNt9dnHfDBByTWpKdhksYj5kyvxoUgMvGZd3L4OIqAI3JjysamLXeeM4bhweIZyDu9HxigZYmpuwJYrnwsCVybi4fn0qUIRAKblFJ34Y1rsKGJt1ktOyh4Eht0yYdw3FRADb0AUnSgxNkUAZHhxDGikV1c48M7T7iefX1iI7+R5d4sQRyHQBY7Iwj8bsE177cXPAZSVpO+1WFJTTfnfBYoYn1dlhBO4FdAqFgOyCi9kBl2Gfn9p0Kmvp9NXqIOaFGzsPyaFpukN3Od/flb0pJ/nYndQkABUl+co14BIxlulJEuSuSUqanjRuYTpgs7++qoisB+k1bVZbmxZVz3QHUwHY4e/UXAYYnDsVTcprkKM+1VX5BE/6khjOZPEA36QRmxAspBMrLnIN++D5+ht7+lVFNsNIh7DP1bvUXof2SIS8K0gJtF0OAkq4pTk6ofs9zod1eSmXHZeXPdCW4NOhb9zDSjYzgtuiA5s/cP8kQ9QWBm5IugvQNs2roYsyLkhWjyY5JtvoIR/ZmFOS9sZzkvWzzsivzr5fEiB7XX3TQ/trpPszACS/mUSlu/AHY4iFWHZ60qjJuw5ho5g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(66556008)(66946007)(8936002)(64756008)(316002)(76116006)(4326008)(8676002)(54906003)(66476007)(6916009)(2616005)(31696002)(66446008)(38100700002)(6512007)(41300700001)(86362001)(6506007)(83380400001)(71200400001)(91956017)(478600001)(38070700005)(2906002)(5660300002)(36756003)(4744005)(7416002)(7406005)(6486002)(186003)(122000001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVcyam9FWkdDb3craXdvZjlRT2VrbGFyMmlyWUxTUS9ucWI5TEJsNTVwa3E4?=
 =?utf-8?B?RGo5L1R1NUs3UzRRNE83MFRvTjNDQWFLN1ZqTWlMT2dsaGNSUUg5cnNRVFRp?=
 =?utf-8?B?TktZR3dMN2JDS3RYMUc2bHFmOWFBRUNWWE1Idm5HQzFCUGNlU3FCUDlCU09s?=
 =?utf-8?B?NFdxWTltQ3pGQXdQbEs4M1ExTmdzM1EzdXVGWkV6WlloeU92S3lMKzkzN0VN?=
 =?utf-8?B?ZXUyamJobUphUTNmQVg3VFRBTFlZT2JkMTdQbnlxOW5OS0MrYXlUVGVha3l0?=
 =?utf-8?B?RXlyN0ZGY0hxcHd0aXpmTng0R0NaU284YjJKS3JWU09jdFpqT3ZDeWwxak1S?=
 =?utf-8?B?WlM4UzVIY1cvTFVzd2hrcUZFM2cxYzdVSThNREJLSWRTZmxwb2JBOFJkNWVx?=
 =?utf-8?B?d3lUYWN4a3h3UjlCcE9kNE9tUEIveDgrMnpTbnpoZDJ6Mkt2Q01EVTF4MDJX?=
 =?utf-8?B?YlhDaTU2TEhSZlVyZjgvZkFPTFZsdmVtNmgzU1BVK21mczBGdGtoN0RjalhL?=
 =?utf-8?B?WXMraVRrMVNaY3hMV0xiZE1oay8wV3JuVWtJTzdER2NYcjFSck1rT3JqeUlG?=
 =?utf-8?B?R3AyQ29ERktlVG5hZmxNMjJBK3RVTE5KRTdqd3NFSXM1dWFCWFBsRGxCbEgz?=
 =?utf-8?B?dUkrMlZqQkRsNVpqWENjK1o0azFiV24yUTdtaXJOcG5qUXBFY2ZGcnFVOUxt?=
 =?utf-8?B?ZUdkZmR1Z0lzeVZ5Ti9DZkltWjYrTERLWWRHcWhBK3JtS01icGMrTUhhUllG?=
 =?utf-8?B?eHpsRHh0WEUrcFYzb2lDUFhkalZFUXExNkM3UVAxZVhkakVDYXBwUHd0czFM?=
 =?utf-8?B?ZW5tYVJWczJnVklGRnYxV2J5TUlGMHgxa2JmQzR0eUg1YnlJMVBiK1BRV3Nx?=
 =?utf-8?B?RG1OdXkwQlp5dXZoMTdUaUpDaGhhS09tTTk1cU5mazhPQTVvc1l0NHNjbWNI?=
 =?utf-8?B?VlRTWHNOYUlIM1p3WlVmVmUxejFoZ0hoVG96M1pldlhXZkJyNW1tSWFKWFhX?=
 =?utf-8?B?RFNrRHo2TjFjb2U1USsxaFFXZ09yYjhQWldqT0JWNXZ6TmJhbERRWmZ6by9C?=
 =?utf-8?B?c1dwdmRmVC9QQ2t4SUdJRkp4QXp4ZFBtaDA1MDBvOVZJM3ZJN1dadFN6WFov?=
 =?utf-8?B?WStuaXc4eVVtR2ZIVHliUU9EMjRHbkNZMVQ4TUhXNjcvMUs5UnNEWUdFTWFV?=
 =?utf-8?B?UGcvQUROVE10ZXlZM3RBVXRCMFZMNjZlRXdVWDBZZS9pdGlXMEFGS044M1Ey?=
 =?utf-8?B?cXdBanE5bnE3NDJWeEpOd3dKR1ZKWDNlSGZ4Z1JVMWo4eFBKOGd0U296eDBG?=
 =?utf-8?B?dVAvTndNTjY2YVZaRW1XTmJORGZWWVNCYjhBL1dHSUMwVnNGRndWNXVyci96?=
 =?utf-8?B?ZENUbzRlTmFwTHJtUjBMR2Zjc2Zwb25EeXQ0R3VqSlRERWZrWjE0Vi9zSE54?=
 =?utf-8?B?OTJKbjJkT2tnSllqSEdxalFORnpNQzdmd2R2Y0NVSXRpd3V2UG5mVTArLzJi?=
 =?utf-8?B?Sjl3UGhCcElPWFdYL0hWUGR3M3luc25ZcWNFbXRmWUZCT1psUDF3UHZUWlkx?=
 =?utf-8?B?Ynk0LzVJekZWRnFMQzhBSWNyQzFFUmtFZnA0MjgzR1ZLS0JKeVpicHAyK0dl?=
 =?utf-8?B?ZER6ZzFuNG9KUldkUmo2Y2ZVekNSYU9PNk1iVHJvc0lyQXlQWGg3cDBNeEdt?=
 =?utf-8?B?SE1XYlIzUEFFemlnVnpzWWpKSGtHMjREOWNlQnA2dEJYR3FYS3lpNFpUOEhT?=
 =?utf-8?B?dGtwaE1yUG5NK21aazRGSHBxLzRDZTVKOTNuOExURng1KzZCcUZRZHJPOTMw?=
 =?utf-8?B?MG5HSThUNFVBTERFUHJacUtWb0ZkNTFFZnArOVJiUFlBR3QvazlJT1hQNXl2?=
 =?utf-8?B?WFEybnRTMTF4cVhlM3VyeUQ5em5JdHJSRTIwSFJHS1A1d3VPanAzUi9NczZo?=
 =?utf-8?B?Q2NxWklWcTh4MFp1WWZvMEVKT3BHMmR0RmdvVW13Q3ZXYjRwcm52c1RRdTFj?=
 =?utf-8?B?d1pFdHJHcmdIZjdpaytUNGswNGxScm5EWmdsTkV5RWdNcTN3dFAwYmpRcE9Q?=
 =?utf-8?B?bitFa1U5Si9GUWtNd0piL3gyZVJ5b0lpWnZORU1lSGNUTmZTMjIyWUhoOHVp?=
 =?utf-8?B?WHdqOGcrWnFTT01wWEd1aFU5VlJWUEtScXY1WFhXNkd5Nk96VVlkMnNhL0w3?=
 =?utf-8?Q?JVORaIi1tqTEaymxysZ7gorTjLOWPypjbXgtTGE2uyY2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C8115D4352FDE4DBB18189B4BA25606@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8320733-434b-4073-acc2-08da5eef531b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 01:32:01.0551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nR3WgwcsguE/9Gx0pTYxGMTS6RKSEAPsh93K4upd8C3sjuk69VdkDkXXDG7HfOOi1G53Px3OAeQkXa3VDcGbeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2404
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

DQo+Pj4+ICtpbnQgX19ibGtkZXZfaXNzdWVfdmVyaWZ5KHN0cnVjdCBibG9ja19kZXZpY2UgKmJk
ZXYsIHNlY3Rvcl90IHNlY3RvciwNCj4+Pj4gKwkJc2VjdG9yX3QgbnJfc2VjdHMsIGdmcF90IGdm
cF9tYXNrLCBzdHJ1Y3QgYmlvICoqYmlvcCkNCj4+Pj4gK3sNCj4+Pj4gKwl1bnNpZ25lZCBpbnQg
bWF4X3ZlcmlmeV9zZWN0b3JzID0gYmRldl92ZXJpZnlfc2VjdG9ycyhiZGV2KTsNCj4+Pj4gKwlz
ZWN0b3JfdCBtaW5faW9fc2VjdCA9IChCSU9fTUFYX1ZFQ1MgPDwgUEFHRV9TSElGVCkgPj4gOTsN
Cj4+Pj4gKwlzdHJ1Y3QgYmlvICpiaW8gPSAqYmlvcDsNCj4+Pj4gKwlzZWN0b3JfdCBjdXJyX3Nl
Y3RzOw0KPj4+PiArCWNoYXIgKmJ1ZjsNCj4+Pj4gKw0KPj4+PiArCWlmICghbWF4X3ZlcmlmeV9z
ZWN0b3JzKSB7DQo+Pj4+ICsJCWludCByZXQgPSAwOw0KPj4+PiArDQo+Pj4+ICsJCWJ1ZiA9IGt6
YWxsb2MobWluX2lvX3NlY3QgPDwgOSwgR0ZQX0tFUk5FTCk7DQo+Pj4NCj4+PiBrKnoqYWxsb2M/
ICBJIGRvbid0IHRoaW5rIHlvdSBuZWVkIHRvIHplcm8gYSBidWZmZXIgdGhhdCB3ZSdyZSByZWFk
aW5nDQo+Pj4gaW50bywgcmlnaHQ/DQo+Pj4NCj4+PiAtLUQNCj4+DQo+PiB3ZSBkb24ndCBuZWVk
IHRvIGJ1dCBJIGd1ZXNzIGl0IGlzIGp1c3QgYSBoYWJpdCB0byBtYWtlIHN1cmUgYWxsb2NlZA0K
Pj4gYnVmZmVyIGlzIHplb3JlZCwgc2hvdWxkIEkgcmVtb3ZlIGl0IGZvciBhbnkgcGFydGljdWxh
ciByZWFzb24gPw0KPiANCj4gV2hhdCdzIHRoZSBwb2ludCBpbiB3YXN0aW5nIENQVSB0aW1lIHpl
cm9pbmcgYSBidWZmZXIgaWYgeW91J3JlIGp1c3QNCj4gZ29pbmcgdG8gRE1BIGludG8gaXQ/DQo+
IA0KPiAtLUQNCj4gDQoNCnRydWUsIHdpbGwgcmVtb3ZlIGl0IC4uLg0KDQo+PiAtY2sNCj4+DQo+
Pg0K
