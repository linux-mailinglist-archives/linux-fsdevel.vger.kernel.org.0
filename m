Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2BA567B0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 02:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiGFAG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 20:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGFAGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:06:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049081261E;
        Tue,  5 Jul 2022 17:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgWIGGlifyyAUWblg7I0kwPgnJrvPgkSftsfFv8i7cCzY88OFUG4NIAO8rAckpql94Ng8WdWORQRrkruDRsjPFU/ylke1VnvaTwFGdolHC6HLsOKZfyqQqeXo8ZZl3K852sDg2IiHZzpBJjZu89FP6KaafdD88Q6xFDnwa2DtjAWm78NQuVcPyT6zePvEzvMBilTNSl8uqdBEVhjY7g2saWWvB5wYo8WXZlCdT2ZLrZeizI9K+6is3euu5wilD2+PWc+GgTEgraal0NSBxBzEiaA//6vyFWTZN2dJ3kTlmn60ttyLbF9Hv5cK7b+mrtdlQ9HwMhm4ou7Hc0OmZtybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjbRoacjszEg922Wd9VytxVjXiOapwgtMMkB44dSv2w=;
 b=OYavrMVU4mAELduuBlyR3cHl8Y4Ncr/EQjKd14m8H7ccvqrntyTtyij1neoH9aLMXU4zOFxOj5bUbc7+aqX6sNpXw7buUNcRkjxX5MhVSOjudNldVxI3vMHoxfk7xxIFZHXFMZHeMJNrPK9T9xRWiCZ5TQgR257vhu4d8Kd/FMAUs05pQsELlq7EaujF+HGU/XcPWA+h6No9uZez21cbElKFO7Y1LqpOOkPjOgVQ696bHUxICz0agQNeNLOc+jztA3dpQWM6aIoHnWIkqsCSQJMFIxvp1uYSll9YTmq5EPBZyrmhGxrmJ/RBeUw25HR5W76dHCRnG9lxRAXl6zMeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjbRoacjszEg922Wd9VytxVjXiOapwgtMMkB44dSv2w=;
 b=MmPvpaWuuAxsIYGjAErewbxJOS0VmV6ouOP02N/StnML2CI7jnW1UtTSGtQWO2gbaiQcQnCuUXQeWcVuPVysHEs7UEwrQZSdfxiolx2hkbVT4kMvV3UbkhyQj8ODvhgzg8PLUxxQNpcn1VnGUfJiP5DZq09NfatRJOEd5CP5AYvPc8sA79e/GjfpvDFPruoiy8+il6QBKtNIp0oaJ7SoZ0L2Bhs8U3QbkqeXRB2ANu8ES1rS4/hIo/sz/F82ZJUXQ1dxQGFM2E/T/e2K6yeDyg7cP3EJUXFXWzG6Odez2NjMPk1O0/0dR+2UoBTJUzv4V5Q2IMi89qKTCayiPdd5Sw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 6 Jul
 2022 00:06:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 00:06:21 +0000
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
Subject: Re: [PATCH 5/6] nvmet: add verify emulation support for file-ns
Thread-Topic: [PATCH 5/6] nvmet: add verify emulation support for file-ns
Thread-Index: AQHYjGH1IClknLTb0UW7qt+DDMxYja1ve/cAgAEDtoA=
Date:   Wed, 6 Jul 2022 00:06:21 +0000
Message-ID: <8b72e8fb-5953-f5d9-2bb6-093b7e94a009@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-6-kch@nvidia.com> <20220705083648.GD19123@lst.de>
In-Reply-To: <20220705083648.GD19123@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 242ec604-b99b-46dc-59fc-08da5ee35bd0
x-ms-traffictypediagnostic: BL1PR12MB5924:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6DhTdBslQDO+tULV7MoRzPlIJEQ97BfGpKl13XJpZ8lzAr3DPqZ3FL+8NsEmAaNBgaF5p+WI6yKAOcciN5mwkaPsTzRrlq3yoJuchrI35bXe5r0SXr/f25Y/+LTVbw2SymybHnEtV7ysXQ+439+ox5hsA9rUpGYjdH1eoTpc+Fi5dQdhaQ2ogBXIa5DfaN57TTMgsqtQSyqjCykVCn4FIXoRIayuLtkx5aaJ8JX06wzTb4JV9XtisSNx8lXitYR21NB3SaKccoYHq50WXlCuzxmSARbwcOZJ/mstg9FKWbYe+iSqprHbEL6t1M2bnsSSYvPxloKeJL0OuRi8A6rPeVGk47Dwms79ZbQ3NnIQXkv2wfddkd9PT3VF60SnBUvk0LTzHAaomgCoM0xLdB2pQZQQqraa6aisGqmsqDlHt6jT8aNiwjFrSOMjObpoufswVW/iuQHqXs36OOL2ZGdtAP1lmdsKch/nwDheABi6hj9krNVy420KZRGKxKfYuYUmqWIYHj9ui0UNC0pXehLiIRsjyXzSHWUnE6HtnOaDxYs8Cos/OMZdg3XjqBRwbcsrFqdM4ktlXytLhsz/V/5OEf4O41UDPO7mLl+wJ+0n0TqQ3GC2nKZc4F4M0sbwKO+pvcCKYnJZhDs4eyEEPHFaBc3WqUXz29nNVh+1NyCT94WlNl9527lq2yfOFma/012F9P3HunJ2YfvLzaIYmpYJsWdhI4g6tHyFOkPU8RFZ9qaJ/wt8zQDq3acia1EwKlNPYeFUQo084JoXFUHa0RbNhRzLZuabb6nnryXsMCtshUvFMfzZMLJSYDw2Xqa2mBJAv3l61dMnYgDJY1GurHs03qP+CJk6+5AclVdnGM1sc8AGpYM2ZzjF+tFcTErDimH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(71200400001)(6486002)(478600001)(6512007)(66556008)(66946007)(15650500001)(2906002)(66476007)(31686004)(41300700001)(316002)(54906003)(110136005)(36756003)(6506007)(7406005)(5660300002)(53546011)(7416002)(31696002)(4326008)(66446008)(2616005)(86362001)(8936002)(8676002)(64756008)(76116006)(83380400001)(186003)(38100700002)(91956017)(38070700005)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWRjZWJuV25FWXJFRXdpbTdNTkUyZkExU1dPeTg1YXRJSCtWdGZtdFN3NnJH?=
 =?utf-8?B?U0NVTEtJNmJ6RmpQY1RUQ0pZTHZQOHhKQi9sV3BER2F5Wi91ZEhnYjNFYSti?=
 =?utf-8?B?L2tjY094d05mdHFPbmpIZEFmOFZJZWJEUmRTRkdOV2RER2xoTXJBTGIwWjJw?=
 =?utf-8?B?bGJsN1lRSUhQWnhDRW9ZUFBhM24xaTgwbWI2LzdNN1dVMm4xWjZJTXBvZU9z?=
 =?utf-8?B?U0ZockxlYk1IN3puQmhLc3dzWkdkeEZTdGJJa04zTW5FY1UxWVhZRGhVRkdP?=
 =?utf-8?B?TDlwVE1DZWZQK3phSjNIcjVudVdhNDdvb0hDTVpGQWJXaGUwem9tandlZ2xJ?=
 =?utf-8?B?S0tnWVFPYTg3bTFUUHRJbTFjK1hJdmROMWc3bDNvNmIxOWZTNEw2emNBVHBS?=
 =?utf-8?B?TWU2ajFkbmlRU01rMXdwaXc0RlZiR2JtRHEzdkxNb0xMVUFYb3lkbDRxOWVa?=
 =?utf-8?B?Tk1BbXMvSTFoT0ZNSWFHQm1aZHV6bHJ2NG9iT0xmTTh1MkZZbWhZN2tkQVBW?=
 =?utf-8?B?cFdBaVp2czRmemYrYzQrQmlPcDhxRGRmaWliS3VJbDNnTHU3S2ZVMWFLTnF2?=
 =?utf-8?B?alhudHRibDBiYi9JSUNtK1VsUGN1ajY2RXdtM0E2TDJUbThxV1IrcjZvZGgx?=
 =?utf-8?B?MmZmaDB1aU5weHpCbGF0OWdBc1JscFFnWmNweUdkaEVDcitCYVZuNW9OTWhH?=
 =?utf-8?B?MzNQQkhpUndWZE1tcVc4TWZ1ZHFPejJOZkNuMU1XNFBtWitZakg4blo3ZWVY?=
 =?utf-8?B?SzdCdHk5VDhVcDZWQ1FNeE91eGtBYkV0dWl4Qmh3eWhaOUdyRzhnUlRrUzQ1?=
 =?utf-8?B?VVFwL25KVkFwNFJhaURMdUg2WkRGamZmZitVaWVyYTRrU2pDQlZTU0ZaWFo1?=
 =?utf-8?B?Nm5IcHdTTVBsVlBBS0tpTXRMYkoxT2NmUldxbGZ5Qm0vQ2dCSmlCTlc5ejZ3?=
 =?utf-8?B?aElYbXo4empYeWNxRmRoZGVjMEtJM1Q0b0tHa1ZodXROZVdHVVJFM2FxcU1l?=
 =?utf-8?B?djg4YzFIZlE1WUxnVXB6aElqcStyOEtzdmo1TFlaL2wxTStlMmdaNGpRVE9s?=
 =?utf-8?B?NjNtYzc1dzd5cm03aEN0eHhTa2w4Zy9OT3RXbi9TS2VJK2c0eTV2QXVHblda?=
 =?utf-8?B?ZjhOWDBUeG83Nlo0MVpodEY1UnlhaC9vLzFkQWhKRm56MzVqQzV3UVpqeXM0?=
 =?utf-8?B?dFJrYkp5dFdOQkw4ZFFHR1U4bVhQQlJWVUxJbm9PYmpiQ3VXOWx2Nm1uRHlS?=
 =?utf-8?B?bS9NSWQreWNJRFU0ZlVmSHdtaEp5RjNabEVnYzBrS1NLbU9SVzVCOFRKMXFm?=
 =?utf-8?B?OGlsdHpUT3BHenZrNlFqcUlnTlp3M011Qkl6aEJHTFk5Q3VYSGl4TXZIVmhG?=
 =?utf-8?B?bHdYcEtRaUxOeGEzUVJxblRuWWF4eVRJOCtXUTNOL2M5ZHRNK3ZGL0MvRGpL?=
 =?utf-8?B?NEpYY25EOEt0V0g5WXozZzJXWGF0WTFra2RDOGxGVUNiaXFrR2hkdWhCZXll?=
 =?utf-8?B?RHNCdHRVVEpCM0QwMm1XcDhYL1RvcGpZbVQ1eWZpZWRaelZmVnlDMTREemp5?=
 =?utf-8?B?Qmg3Rzg5Q3hDNENYZE5kOUFRTEZBc0NXRGI3bzNPbDQ1aWY2UDFTV3p0cnls?=
 =?utf-8?B?R0xmR2hQRCsvaFVKM01ZV0dpcUF1OHhseWxYQWRDN25yUSsySHpVWHhKd0NO?=
 =?utf-8?B?Y3F1cUlrZUR0dUQ0TjdBYlBaenRTRVN0REFBNEkxVzczVXQrWHcrZEV6aWhq?=
 =?utf-8?B?WG50NHpmaHhlK3BKUkJpZ2RMV0crUDM4SXhuSTdxUExmc2ZpYUZqY3NTd2Vy?=
 =?utf-8?B?Q3hRWFJ1YU5wUzBzd2tmMTE1S1RQckpxYit1V1ZhajJmM2tEWHRockJiQ1ov?=
 =?utf-8?B?eGpoeGdVTFdpUnp2OUNtTkVwYVVhcFI2OFYva24vUnlIUGZMVVVKcUtGbis3?=
 =?utf-8?B?Nmt5M2NRVnJXSTBQTktYQ2JWN1dpVmJENnRKcGJrWXkxdFFqT2dZaldET21S?=
 =?utf-8?B?dldLZmRNRW4zT3FHLzdIZnQyVWxZQTNnNlY2dnY1bGxveXhlQlYxbVhCc1R4?=
 =?utf-8?B?eU4rdFQ5eUQyMHdOR2Z5bFQwYjlLdG1Gdm9GdnpOL3JIM1dlYkVBVDFWakwy?=
 =?utf-8?B?RUJvSnB2QnE0ekdocm5JR1RId25pK0JXeU5Cdy94bFk3TG9QZSt6NWxQR2tX?=
 =?utf-8?Q?ukQe7lqEQz6CmyGssv9wWYy6l7yUhCKxrQOPw+Bwq311?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7B5FC93C269C542B7FA0428BE329BDE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242ec604-b99b-46dc-59fc-08da5ee35bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 00:06:21.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NU62ToIxaK9eH8/QfpQN7ugmQhaAmHT0aT6SMCQ/wBSJ6sRa0Tcxe9+UGAQb+iRmc0YiRyTcNj5RnRbnTy8AKA==
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

T24gNy81LzIyIDAxOjM2LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVGh1LCBKdW4g
MzAsIDIwMjIgYXQgMDI6MTQ6MDVBTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0K
Pj4gRm9yIG5vdywgdGhlcmUgaXMgbm8gd2F5IHRvIG1hcCB2ZXJpZnkgb3BlcmF0aW9uIHRvIHRo
ZSBWRlMgbGF5ZXIgQVBJLg0KPj4gVGhpcyBwYXRjaCBlbXVsYXRlcyB2ZXJpZnkgb3BlcmF0aW9u
IGJ5IG9mZmxvYWRpbmcgaXQgdG8gdGhlIHdvcmtxdWV1ZQ0KPj4gYW5kIHJlYWRpbmcgdGhlIGRh
dGEgdXNpbmcgdmZzIGxheWVyIEFQSXMgZm9yIGJvdGggYnVmZmVyZWQgaW8gYW5kDQo+PiBkaXJl
Y3QgaW8gbW9kZS4NCj4gDQo+IFdoYXQgZG9lcyB0aGlzIGJ1eSB1cz8gIEknbSBnZW5lcmFsbHkg
bm90IHRvbyBoYXBweSBhYm91dCBhZGRpbmcNCj4gYWN0dWFseSBsb2dpYyB0byBudm1ldCwgaXQg
aXMgc3VwcG9zZWQgdG8gbW9zdGx5IGp1c3QgcGFzcyB0aHJvdWdoDQo+IG9wZXJhdGlvbnMgc3Vw
cG9ydCBieSBibG9jayBkZXZpY2Ugb3IgZmlsZXMuDQoNCldoZW4gdXNpbmcgZmlsZSBiYXNlZCBi
YWNrZW5kcyBmb3IgTlZNZU9GIGFuZCBsaW8gKGxpbyBwYXRjaCBpcw0Kb3V0c3RhbmRpbmcpIEkn
bSBlbXVsYXRpbmcgKHBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgcHJlZmVyIG90aGVyDQp0ZXJt
aW5vbG9neSkgdmVyaWZ5IGNvbW1hbmQgd2l0aCByZWFkIG9wZXJhdGlvbiBvbiB0aGUgZmlsZSwN
CnRoaXMgYWxsb3dzIHVzZXIgdG8gc2VuZCByZWFkIGNvbW1hbmQgYW5kIGtlZXAgdGFyZ2V0IGNv
bXBhdGlibGUNCndpdGggdGhlIGJsb2NrIGRldmljZSBuYW1lc3BhY2UgZm9yIHZlcmlmeSBzdXBw
b3J0LiBJbiBhYnNlbmNlIG9mDQp0aGF0IGZpbGUtYmFja2VkIGZhYnJpY3MgdGFyZ2V0cyB3aWxs
IG5vdCBzdXBwb3J0IHRoZSB2ZXJpZnkNCmNvbW1hbmQgLi4uIG9yIHlvdSB3YW50IGEgZ2VuZXJp
YyBmaWxlIHJlYWQgaGVscGVyIHRvIGJlIHVzZWQNCmZvciB0aGlzIHNjZW5hcmlvIHRoYXQgaXMg
Y29uc3VtZWQgYnkgdGhlIG52bWV0L2xpbyB0YXJnZXQgPw0KDQpkb2VzIHRoYXQgYW5zd2VyIHlv
dXIgcXVlc3Rpb24gPw0KDQotY2sNCg0KDQo=
