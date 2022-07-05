Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CDE567AEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 01:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiGEX4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 19:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGEX42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:56:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B85B10FF1;
        Tue,  5 Jul 2022 16:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpk9MjZQxFi5lIVQF0y6NygukbSMrDYFiAPuhbnzz8EPUClEEHGq2GqetBhtL66a+hmFyzCoF+0W7kq8LKqSBzUrykuNgLUPUiN7aIBIyVbz9VogUhr1b2RELr+yBTovcayVywbjRgrppGFAm6JfZ+4ABBwWkq6RgZQWdAu0e7/dwstcRHjkSBjR5yNjznjrEZ1HrgBPBDm6eW/KamJoapy2jittD2BYTNRnllb2rkE52m2xwL27NDjlSvUhgs8QoFnFAstFXRBwGlYQpuXFhwrknF3nimoneEWHJcWl6xhImECpjhVVnHMabJLiDwvi2rICouII2mFLe+R8pe207w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY4qqLU4LwpX5f+l/dLSvAIhpdU0Q1QVQ4/hhPe26xw=;
 b=iU+Ks7jU1xIbGkUs44z0sp+GrJL57wrcg0PqQrx9g2gi6JqsxOvK9fzLIFmn5hfMvwMf515S1w9nUm2pUWHlHbRvFxYaO1jPRKVnzqkqps+Vmr1rMiPxZVRLJHhqUmkr0AJADjlPQyxbJj0ENAFxm2UrjOMrw2p5oQygby+VTD+uc9DI1MMX5YBTuFDMoGLLa544K+py1u/ElSIsgJ8+JMsKDtL4pD6AOq+BJmZL07Q0MnFJ+xih+wuOeNrRto/cyG9h2B8O0/kXL1xbJUhKQDM2zuuAqn6OT1xJrNvMlNoZdrWoH3SEIsS3LyC1e0/kuZrY6AX7wrIWeRG/hhQ/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY4qqLU4LwpX5f+l/dLSvAIhpdU0Q1QVQ4/hhPe26xw=;
 b=Hcu3vGXhds5p7BiqU7iXPvxgXW7kVS1D73yQegL49ni6fEwAdp0amfPG6pQO+dSybZs+OldKG5ImhkCwB8JFUvzDbM6K1xse41on9ZXMcCH2HBx6WSd0nLyCJ7hb78EPBzfF/Eikq2FE3hzTsMAYeIBjXqlNDlssjFj2GCk6LMkDGC995y1nZeNRBKG46thtSc4z4DmHkXVzCuDAnAqVuaHaO3LFHt30Q8LSqPyNoBn8+VR4VzDgrCQkXZdenYQTSn931jpsgviW3tOF0AuGRtZEyAjXIIq43tfM/w+UofXZ1utvzlXxapeYsQs2LEank3rdzpmBlmqYMi3dvfIulg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 23:56:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 23:56:26 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
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
Subject: Re: [PATCH 2/6] nvme: add support for the Verify command
Thread-Topic: [PATCH 2/6] nvme: add support for the Verify command
Thread-Index: AQHYjGHatT9RmdZDtUC+rzv+ww0wj61oIugAgAdYYwCAAQGdAA==
Date:   Tue, 5 Jul 2022 23:56:26 +0000
Message-ID: <baf996f7-36b2-d658-fb38-7162b553b5dd@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-3-kch@nvidia.com>
 <Yr3OLiEd+/6wryCx@kbusch-mbp.dhcp.thefacebook.com>
 <20220705083424.GB19123@lst.de>
In-Reply-To: <20220705083424.GB19123@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d6d9ec7-75d8-462d-c02b-08da5ee1f909
x-ms-traffictypediagnostic: DM6PR12MB2761:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQJSHfynJ/gkyOsrM2a5clCkNe95Pn/YM9jG0gcy54a59rHv0A0fvbDxFC6ow8UghMuP9bKGT9xzc8g35/wTWo2D6budYxALJJAWfKrwgqXsCI4jrft6qJ7I1gWgzp/OJlcT3aK79qoD9oCUQep44SBhMIaFVjLExLRtBxQHIkpSCK0SoJE6gpzZVRNBmUoYk/NeG23ZsvEaJxnFSYgOGUMxg9DjzS+AIpVMr9t4d8xA5FXLCPzaLtjUkPcYygwZCrCWazEcQb3m0/hgBDiDfIYUrZ5aSgqpK8RQo9ksFE+JVU0lWnn03xwu9562VbMjsU5j8Y9eGb5prT6QvcozTFmfGK5KMvcnyPGgVvjpa0Q+wEdx4foBHdoO25ytkyryxKmxZihX7fFcEEkBy8vJ7rqGnYmeYD6Pdfc1InWsMjna8FCe5nFB8u/nidoET0i05JiBEWclQLBR6UbhxEPAx8HLHOjddjaNT4d+72xOheOySaWIuzOsL55seKdKysffRIPSABz6MYH52/G177FkILHWLoCZ6cf6iC2uDdGkJdp+ZCa1W83CT0fe8o2TNEf6HwRtptlCvl3Al6WfiylU3tqy4g7Sps2uCAxwUlWMFBIq7xNBbIgQto3J5yA0R3AN4zk5T+myVTReUsLPsbABx3iAyO/v6jI/gCgzy+j9PG+0pdZTLldeLdWzggZSLOLKJGa8t5s3bpvfctdWt1ZDpArUuFEp2LA+VOZv7e5Vje5vbbjddOmVvReQqGIWXhDiOzdiHpqMxG0r56b0PsX+AYaPvkHtMTZJpkHk7OrNwp6WEpIccUuRtFn7NvTCbGDexBbtnnmRtTRfT0iYIUlaS7C2YHYeccQDWqiuEzVa6FNh0GDBJJASZ7my3EACZNMy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(6512007)(53546011)(71200400001)(478600001)(2906002)(7416002)(15650500001)(6506007)(41300700001)(31686004)(4326008)(86362001)(31696002)(36756003)(4744005)(122000001)(38070700005)(38100700002)(6486002)(8676002)(110136005)(186003)(2616005)(5660300002)(316002)(54906003)(8936002)(66946007)(83380400001)(66476007)(64756008)(7406005)(91956017)(76116006)(66446008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2tYOUxQa3ZXZ1lQOVJPa2VJYS80NUVxK2g0Y3VxV1c2Z285T3ZHOTJsWWxw?=
 =?utf-8?B?NkZvT2swWnBZS28xdGV3REFlQS9EcWJIODNGbGUvQnhVTlJ0Qys0MHJkbzN2?=
 =?utf-8?B?VTJGaWM4T0N0KzdGTnlQdU1OaVFkMlVhZVJNMmE1OVdLT3JrbXVkaG9uUVA2?=
 =?utf-8?B?Wkl1THlKTlc5SC9OK2tRTXdkK0EzdTZyZFRhM240NkhDeGZ2ZWlqYWtUOUZ5?=
 =?utf-8?B?RmJsNjVkakN4RjBJYmdVeTBjbnlidnJOVStheDNnNWF0a2Q5ZkRyR2NiZVZ2?=
 =?utf-8?B?eW1xRTQ2Rk1EZ1o1OWlJcTYrK0hFSjJmVUdURHE1cHVvS2ZpcGp4VUxQR0I0?=
 =?utf-8?B?TlRaOS85QTFqT1h1aGRTQXlzZHU0blpGZi94citjRXhWanVLOEQxQXNyaFlX?=
 =?utf-8?B?aWFwVFlMZkQ1MitvRHUyMWpSR0NhSTY0KzJnT3lIVjMzTFYvQUtXV0RjTFVt?=
 =?utf-8?B?YlBWcklVVDZvM0VvTlMvbWRNZ1FiR0dYekJvZU83aHNLdDhTV1lZQzc0Mm5B?=
 =?utf-8?B?MlNiS21LUkhOdHhoWU41VVExeS9yaUZ3VGFuTWgzaHo5c0xTMlV3WW5mVUg5?=
 =?utf-8?B?Vk9FdnJRVDNLZGduYWg1YjNabURxOVZaTjNDci9mbnk2cC95dUZCS1k2Mk9p?=
 =?utf-8?B?eVZOTnoxV2xVQTZEOGcvQUk2VFdxcTlYTzNUNU00SjJMQWRKSVZ5UTZxSFE2?=
 =?utf-8?B?Mi9vR2xVVUs3cXBENGdadytVcVFRYWx6cHkrWmxhaVJaQUcvOXFBQWRKZjdz?=
 =?utf-8?B?cXpzS0FVL1JJZldUTEZCdXJtZFk3OTJZRGdCUXpabWZFTlZDdm5sTzFiODBK?=
 =?utf-8?B?bVBZUnB5c1h1TXViRzNVVkNhU2FHdmtidUllS2RIMTY2eXY5UHFZUWYvSVlh?=
 =?utf-8?B?Q3lsR0pmS1VMckEwQXdPN3ZOemg2alhnWjdRK0I5d3ZHbDlwTytqNHl1cFEw?=
 =?utf-8?B?MWFzTVFnL2JUdGRmaUljUWlvY2VldjYyQ1NVb054aXMremZLY1pNRkZabWtp?=
 =?utf-8?B?cVdoSUZmMFpSTWR6OGxTT2F5K2pSV1Z3ZmE5SjU4Qm5IRDBwYW9OcDdtaXhu?=
 =?utf-8?B?ZDRuK3ZPeWd4b095eDcrM0FJOFErU3lZN282WFVrem9Jc2Uza1FjRElhQnBG?=
 =?utf-8?B?VFdSL1BJekg5eEIzWlM4RURpd0xkbUVnZHNKcnJHaVlMbXdKL1Q2NXJ1VUxJ?=
 =?utf-8?B?MUk1N3ZPdmFCNGRyaTh5SVhWTlp0MWwwTHp2RW9WUDBNRjhCekVaZU56RUZ4?=
 =?utf-8?B?SWdlbUpsbHdDVFd1aFdTZldBMjZvcVNFczYzUXhJQWNIZFlNdldhYVNSZUhk?=
 =?utf-8?B?cm84ZDN3ODcxMGtsV3pJSE5JZk0zck1KWlMxMVB0V0VZMHRycVJ2R1EyRncv?=
 =?utf-8?B?VHA4ak9ycnc4aVYwbnFVUWxVUnI3dXJ5MWtzdlBpaDdZZ2xxTVByZUpWc1hn?=
 =?utf-8?B?bVM4L0l0S0tSdnZXa3E3Vk1LU1g1WHNCOHJRUG9QcjI4dDFJMEFobGdDS3R0?=
 =?utf-8?B?Vmt3aS9MTDZyYlpXZktmSVZ4OWZOcG9ZMkttR3k5aTUwWm1TVmJFc3BWV3lw?=
 =?utf-8?B?SG1uWE52a3JCU0w1WUlvc2lONVcwdVVlZ3gvcXNuL3pJK3FKcngwWi9PYlpX?=
 =?utf-8?B?WVJ3dW45NlJLSkVBMVpRZFQrYWtqNVpnU3JibmR1NExmZWJRaHk2VjVHQlly?=
 =?utf-8?B?NkZnZ2JORzZqUFhRSVhhVTQ1U2RtK1RzeVVwTFlwQ1FBVmo3NWpKVi84T0h4?=
 =?utf-8?B?Ny9CNFBSVXBEOVYya2FaNlljMTE4M05RYW85bU81WlU3a1oyMWdsVUZISkx6?=
 =?utf-8?B?Q1FnQnpoQXJwZFM3bzU4SldCRzJFSTdPYkhWVEFpRk1TNnlDSjhQTmhTK3FM?=
 =?utf-8?B?Wkw2cGNkUnlKdXdpbFFOTCtUMHFhRzBiY2dkdmE0VWVDKzNLUVRlZlBxNkVw?=
 =?utf-8?B?SGY1OW16N0ZFSkhsZ0MrRDlYYkxFbnNiY3E1Y1djeitHdGQ3dzYyL2FmSFdT?=
 =?utf-8?B?QXRtcTV0WkNlcmllTHRnZ0puZ3g3MWVLWlNJaFd0MndNMUJoSE92d0gyTWFm?=
 =?utf-8?B?UWpVNnRvT1ozVGZjTDhsM1UrVG1LSDR6RHBwd3Q2a2hSRktJMStBcWN6bTcw?=
 =?utf-8?B?NG1oL1BmcWQ3U0RUVFpsNGphSUEwN01OTlA0ak0vMGdHSVc2ZzAzeUdOYnQx?=
 =?utf-8?Q?QOYAgynPPtySafW2wK2IKxORMhHBbaLefa6KvZBdislU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CCFF10C5F5CC84BA5BCA62600110D86@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6d9ec7-75d8-462d-c02b-08da5ee1f909
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 23:56:26.4852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qu9g/DlbxnOO2nr4IxqwTaaohXrIYIpkD2fEtoULNC6O7z/vpdPm9Xalfo8xw6wVBdG0s/MIvRyY4y8BlVBrAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2761
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

T24gNy81LzIyIDAxOjM0LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVGh1LCBKdW4g
MzAsIDIwMjIgYXQgMTA6MjQ6MTRBTSAtMDYwMCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+PiBPbiBU
aHUsIEp1biAzMCwgMjAyMiBhdCAwMjoxNDowMkFNIC0wNzAwLCBDaGFpdGFueWEgS3Vsa2Fybmkg
d3JvdGU6DQo+Pj4gQWxsb3cgdmVyaWZ5IG9wZXJhdGlvbnMgKFJFUV9PUF9WRVJJRlkpIG9uIHRo
ZSBibG9jayBkZXZpY2UsIGlmIHRoZQ0KPj4+IGRldmljZSBzdXBwb3J0cyBvcHRpb25hbCBjb21t
YW5kIGJpdCBzZXQgZm9yIHZlcmlmeS4gQWRkIHN1cHBvcnQNCj4+PiB0byBzZXR1cCB2ZXJpZnkg
Y29tbWFuZC4gU2V0IG1heGltdW0gcG9zc2libGUgdmVyaWZ5IHNlY3RvcnMgaW4gb25lDQo+Pj4g
dmVyaWZ5IGNvbW1hbmQgYWNjb3JkaW5nIHRvIG1heGltdW0gaGFyZHdhcmUgc2VjdG9ycyBzdXBw
b3J0ZWQgYnkgdGhlDQo+Pj4gY29udHJvbGxlci4NCj4+DQo+PiBTaG91bGRuJ3QgdGhlIGxpbWl0
IGJlIGRldGVybWluZWQgYnkgSWRlbnRpZnkgQ29udHJvbGxlciBOVk0gQ1NTJ3MgJ1ZTTCcgZmll
bGQNCj4+IGluc3RlYWQgb2YgaXRzIG1heCBkYXRhIHRyYW5zZmVyPw0KPiANCj4gWWVzLg0KDQpP
a2F5IHdpbGwgbW92ZSB0byB0aGUgaGVscGVyIGFuZCBhZGQgbGltaXQuDQoNCi1jaw0KDQoNCg==
