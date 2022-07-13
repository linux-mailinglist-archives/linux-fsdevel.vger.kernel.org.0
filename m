Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26877573A5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiGMPnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGMPnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:43:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B7ADE87;
        Wed, 13 Jul 2022 08:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGHNkPSeuj5uazpBoeMhLGEaAe2C88qEJQFsNS2xQQZTSCsfK2AgFhHKSbYzkko8VZizkwO7MbkB6V5akLMseZDHbCDzcz5phvtwJlMSqvI0wukT27JY3ECrl05YDG4Seg/81sZtYO6337g0mvCZX9tcvrP6tFrWyvdQxunMfQQ3R4DrZmffCO/wj/ySLHeG76Ho7044S8g4aObpAJ3zRASNoXmW33qs1zOa5hgc9gIXog/r2Ep9J3XqfSYX5hB3M+d6Yf4xhvaZUd5Pbsi4zpoti8nteifJGH7YBWvv8SZbL6ZEqTC08MzKdq8f4XeHx0a7z0TVezIYucdr0TRk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLHlzs/lmOt1CTNpWlKWO4S51pCQAGi1msy82OT0GpU=;
 b=W8Gr85MvHWUqRO1yxJaWO0Er/m+mbFsp777PMJ9Yn2vOxD2FGJHkpK3JGofKn8z96WlaR8PkpEciamn9sl3PzFtaX56WhtGGCWwk6FXiiXsUvns5fuVyL4NWICPwK0B82Nfu/EV0I7jjVtHbO8VjnMaBmU7vl69mBrZI2Y+jnJbhM4JfIdsy2VQIfq5IHSwjh1LBjnhaKLto+NAmj8yXSFLNn7O2rfD6SnNShqBcqoUo7pl6Gn0gG4btacqOeAiGkWQfG60f+suKvoiSp0qt1CzDVRPu9Tz59vWXWzGG+OkAVtAAqcLsmsj3oDDc3NNU0Hpf2ibCmyo6Q7frGFCSxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLHlzs/lmOt1CTNpWlKWO4S51pCQAGi1msy82OT0GpU=;
 b=EtuV8MeHgEeQBcT27n6VgOUmuNSEGURICb9OpDukk8ZH+5eC816OqhLaTU3Tm8Ybs4UAZCvCZtvD8AbHuWySkZ2rMU+YXR54l969Gj9MHZhFnNNZv2+Rx6we2kINJpltSSw3yqQoyRNNbXfNUkCRqRvy1YKs0EPY0puQ2VcNbB/AqiPzo/nQnwh90t5TC56WvQxzGgd2/+FsL7HTEBtua0xD7yFleBZBdgOT21AVrvGpcRPx2d8WLDSABQREq9l4oXICP1GIjOPDjGnEVZJyo8NYlL1hJ7ja4NonrB9A1uClH9mIyHfGj64Y3a4qfD4lIWtNzjBM/QoK23ZUA8EGzw==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BN6PR12MB1617.namprd12.prod.outlook.com (2603:10b6:405:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 15:43:36 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:43:36 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
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
Subject: Re: [PATCH V2 0/6] block: add support for REQ_OP_VERIFY
Thread-Topic: [PATCH V2 0/6] block: add support for REQ_OP_VERIFY
Thread-Index: AQHYloklge72pDYJZUKn07WrBI9g4618OGyAgAA5IgA=
Date:   Wed, 13 Jul 2022 15:43:36 +0000
Message-ID: <22451082-a467-4bd7-d25d-0f9d0dac4848@nvidia.com>
References: <20220713072019.5885-1-kch@nvidia.com>
 <Ys64O6malGAbslBL@casper.infradead.org>
In-Reply-To: <Ys64O6malGAbslBL@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0bc82d7-0a1b-498d-0891-08da64e67349
x-ms-traffictypediagnostic: BN6PR12MB1617:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x+cjAICaTvY0tiMT1FnlRVD9K9S/sktApZCQDHUcqoP/PfYlVkMR9oUGnxwZA5Xv9ze6X7OD0n38qX4qBipW4/CjGjTBINhzVFohEQ263YKog3FZ8sxUnWCICKbHx5/wqnJmhx1e67FI7HJh9N/bFF7A0fISkbJoqeO++5yfTV+jx3aUHmQRSjDW5pptU70RR9EucI1Paf4a8cqPsvnerW6x754OoXj4gnv8kTBnYW9OaZb/Mbd+Ifs0rVdcOfCA8+9PzQlt5EnCxL/mYcO7CsITz6MfXqCsHfrtxdRWEk3idedBi6Ait7geV4ypLEmXY8Wp/wL++7OhvywZ75TRJCHU7D+jzwumn1lSSVc6fuCMPtFe9NEVHaPqoeO//kdXW/K7HGEsIh2fFZuQ4yqlZN6UOdgUM95TkUdBgjePqOErGBD9VCK+Mn4gXLAFCmz84M2VVaZ/SBRoyCxWTNdWXh8CL6YS3dv/z9iBvZJIA+6JQmma7UKvizPAtFNo+7a0AE5GURu9wVoUcDQ7cloyaQi0tMqTNL28NSMFD8p5podvMjwWZUxNAuP3WSq96zqp7aEfZ7hacImEsQKZE4PzPcVMbxPKEsfvqXKHnOYeea7nnc7D8aJkHczZh9+Zi8g5f5L95kfmFavGbbsJKy2mYSRNO3/06buBe7N7hqXFaiF+tINx7irA+V98sCMPATfF4SeM0MOJMPSLw5NLDxAzoPdPp6gqNWo3yAf6bAX3EMZ1pCxr9iCqXlWeO1BzsC8e5EiUcUtw8ZZ3OIBwWsj7b4nzLUcMR9olhSCv82GUxeTN9BteFCX+fNXx99+839L8sbmPLvMzAZPmbCC7nfo3T2MgYpZtK1jIxRrVdIAbtMHMyNDVPpRRFsG8vQq1Wooy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(53546011)(66446008)(41300700001)(66556008)(6512007)(64756008)(6506007)(66946007)(6486002)(66476007)(36756003)(5660300002)(316002)(54906003)(478600001)(76116006)(86362001)(110136005)(91956017)(71200400001)(122000001)(31696002)(38100700002)(38070700005)(2616005)(83380400001)(8676002)(31686004)(8936002)(2906002)(186003)(7416002)(7406005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2NRWEdndW5PakRJV29Wck9GdHQwdUpmaWNmaWwrVHNqMGJVdU8wdmVoMDNl?=
 =?utf-8?B?L2JPSzA2OFJJczVpMlV3d3hFUnJXSXhzMTRwZWhlY0xjeURvYXRnMzlHL3pt?=
 =?utf-8?B?eVdMejN1bm1WN0xGL1NnZnV5VHRWYlZjWnhpdUtMRWVsNC83eGJVeW9SN1Jw?=
 =?utf-8?B?RzlzY2svd1RLRG5ldzJkNEVCQW5pa2I5RUg0aUlkdC9jdW50NFV5anFXd0kr?=
 =?utf-8?B?aHMrSEdwTWJ6eW14TUFHTitRQnBRN0dSSmlkV0NVY0NkOXEzVlVwN2w3eUlU?=
 =?utf-8?B?Q1AweG5aL1FmS0pQSTR1cVZBbStpMnZpMFQwYm5LUTNWQzBjaGZQS0NidUtY?=
 =?utf-8?B?R2w1M3hUZ0M3YWQvM2VmSnZLZ0FXd1FuR3l1OFMrTXJHR0RtNkZXNGswNm9x?=
 =?utf-8?B?dUNKYmFLNEpDYWRXNEJwYVNPR2JVSWMrTUNWVlQ0V2k0MlpJQlZvaEM4ZnlN?=
 =?utf-8?B?MlhOaFljaWJ4SUMzL1laR0ZoT0QzbjFHMGkwOWh4c296S0RDS2o4VExYUlJ6?=
 =?utf-8?B?RlVYcFlxK0s1ZXI0TUtOZzYraUpyazhPZHBHclA5NW9nc01oTC9pRnpXcFFS?=
 =?utf-8?B?YkhwUmVKa0NXMWw4ZVptRlpiT1dpaVBFNThSZ3VpMlJXbDQ1NHZsY1F5cHIz?=
 =?utf-8?B?cFJjcHFkNkx4OU5IbEFXTFB5Mnk0NjNmSGloZi9Hd1NuRGZUWnBwQVhvU0dP?=
 =?utf-8?B?UURpZHA3T3NySEkxZkZaZnJHSG0zeTRiNFVIeUMvQndGR3lKR3BTNzZjYmZ4?=
 =?utf-8?B?OHJpUld4VHhQUzhDeTFzeUxiZDdUdEdLdng2MktIb0lYNUlEc2syb0ZhV3Jx?=
 =?utf-8?B?elUzaEtLcE5EV1VtajF0QnoySjJXVjRrWG1uNnczdmxnczFWQ1c0RE0vY2t0?=
 =?utf-8?B?MjYrUGZUSXQzWFc0cFNwc2JCZ0dqWnpnWGQzNDRQZXRLanEzalB2bGhHRjVF?=
 =?utf-8?B?RlJnTHhxYXpnQ2oyYnVESUEyOWJOWmxYQS95d3JURHdDVnZwNk9yTTZqb1B1?=
 =?utf-8?B?aVQwT1VQOTgxb0JKWThNamYrWFNvN2QyeitDUzhaekRab014MXVabTFsY0kw?=
 =?utf-8?B?Z2hWc0lQMklYS2llSXJkT2tVdlp4TlBKa0h6VnlaeTJ2RzQ4ekVjV0dJT2ZB?=
 =?utf-8?B?bzhxSzNpRjI1OUpaYzIyZlJSWFV6Sld3Wit0NVVRbGdxRUJhVjRVeEt0UmMx?=
 =?utf-8?B?dnVxNCtzL1luUUJDMDlvNmFDQVE3d1lwekJxOS80dFV0Y25aTmNUT1RXUnhw?=
 =?utf-8?B?MlV2MVFBSTFpajF4Q25OU3M2cXNYdDdJWUhjeXo4NHFvZm9VREFSRlc3M3N1?=
 =?utf-8?B?dEE3c0w0ek9DVDVOUUlBTEk0R0VESmdGM2d3RkpRa1dQd25hcGlRVDV2enl2?=
 =?utf-8?B?aVZkci9YRHY4WkNuQTZZMktXVmlwYkkrczF4aVlWbzFrREdnTVZWYVpoNnRD?=
 =?utf-8?B?Y21BYUtJTDB0VmYwSGZpSWFPN2hLMDlGSU1xNlM4MmY4U1JMRG5ybWFzTzdS?=
 =?utf-8?B?RllHWUV5OFNTcFVUWmlxeWZKUEhydTJSWThybkVDdWxxdlR6c1FXTHRKUm9C?=
 =?utf-8?B?S1NFQVhWZmtCazNGVExKaVFwdnJTdVlqNTVMQ2luYkh0TXpZdEMvTTd4MEpS?=
 =?utf-8?B?RUllVThCVnFkb2p4b3Faa1A3elJnMHlLaTdLZEFvelRCZm0yNTUzcktxOVJI?=
 =?utf-8?B?REJnQmhVYnFORUl4MjdhN2dYUjJiL2lhNjYvbGwwb3YwSU9CNDBhVEVKSmlK?=
 =?utf-8?B?TTF6cDJ3WURLeTRtd0FKNjZ0bFIrS25ZczdRRzJsd3RtcTEyYkZ5K0Q5ZWg2?=
 =?utf-8?B?R2VaOHYrcUtGVnBlcXM2cXRMSkM5Mm5FaFpyZHljU0VVSTJtc3FkaTEycVRr?=
 =?utf-8?B?SkxzOW44eDIvMlZGeUNERjkwSC9UMlE2MWtibHg5QjZxMUVXcDZrN0R6MGdv?=
 =?utf-8?B?aWkwK1lieWxqZWJLWFVkL3plQ1FNRVBMMzl6SFE3N0VqVlVBcnp5b0FWRjBa?=
 =?utf-8?B?UWgxckNpc3JkeWp0R2xRVy9hRnhDWlVUM3JvMVRERWNzTWx4dlo5SnRCTS9S?=
 =?utf-8?B?bk5lNlpYVExFWi93OHBqUTNOUFhtelpmVkFna2o4dmdIMVJhUGtvTTlmTVE1?=
 =?utf-8?B?cDBmVEs4VStGVHRFV1NSQ2VMbVEzeEptZGRxNEtiSXphSkxGc1AwZldKR2tJ?=
 =?utf-8?Q?GSz+o3ZnhgX78ZapiyBZWtWimwKYbqSayF/SY78aVfZK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC8C512CC292C8459B57987F685A50CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bc82d7-0a1b-498d-0891-08da64e67349
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 15:43:36.5455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdev/kgnqNxNcAmQpdlD/Tja50n8j3LdIA1p3R++eDtJwB4emEsrKM0upInPiIVi46zkClEAD3OGw2xP5UO+7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1617
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8xMy8yMDIyIDU6MTkgQU0sIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiBPbiBXZWQsIEp1
bCAxMywgMjAyMiBhdCAxMjoyMDoxM0FNIC0wNzAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6
DQo+PiBIaSwNCj4+DQo+PiBPbmUgb2YgdGhlIHJlc3BvbnNpYmlsaXRpZXMgb2YgdGhlIE9wZXJh
dGluZyBTeXN0ZW0sIGFsb25nIHdpdGggbWFuYWdpbmcNCj4+IHJlc291cmNlcywgaXMgdG8gcHJv
dmlkZSBhIHVuaWZpZWQgaW50ZXJmYWNlIHRvIHRoZSB1c2VyIGJ5IGNyZWF0aW5nDQo+PiBoYXJk
d2FyZSBhYnN0cmFjdGlvbnMuIEluIHRoZSBMaW51eCBLZXJuZWwgc3RvcmFnZSBzdGFjayB0aGF0
DQo+PiBhYnN0cmFjdGlvbiBpcyBjcmVhdGVkIGJ5IGltcGxlbWVudGluZyB0aGUgZ2VuZXJpYyBy
ZXF1ZXN0IG9wZXJhdGlvbnMNCj4+IHN1Y2ggYXMgUkVRX09QX1JFQUQvUkVRX09QX1dSSVRFIG9y
IFJFUV9PUF9ESVNDQVJEL1JFUV9PUF9XUklURV9aRVJPRVMsDQo+PiBldGMgdGhhdCBhcmUgbWFw
cGVkIHRvIHRoZSBzcGVjaWZpYyBsb3ctbGV2ZWwgaGFyZHdhcmUgcHJvdG9jb2wgY29tbWFuZHMN
Cj4+IGUuZy4gU0NTSSBvciBOVk1lLg0KPiANCj4gU3RpbGwgTkFLLCBzZWUgcHJldmlvdXMgdGhy
ZWFkIGZvciByZWFzb25zLiAgU29tZXdoYXQgZGlzYXBwb2ludGluZyB0aGF0DQo+IHlvdSBzZW50
IGEgbmV3IHZlcnNpb24gaW5zdGVhZCBvZiBhZGRyZXNzaW5nIHRob3NlIGNvbW1lbnRzIGZpcnN0
Lg0KDQpJJ3ZlIGFsc28gYXNrZWQgeW91IGV4YWN0bHkgd2hhdCBkbyB5b3UgZXhwZWN0IGFzIEkg
ZGlkIG5vdCB1bmRlcnN0YW5kDQp5b3VyIGZpcnN0IHJlcGx5Lg0KDQpJJ3ZlIGFkZGVkIHRoZSBm
aXhlcyB0byB0aGlzIHZlcnNpb24gYmFzZWQgb24gdGhlIG90aGVyIGNvbW1lbnRzIHRoYXQgDQpJ
J3ZlIHJlY2VpdmVkIGFzIEkgdGhpbmsgdGhleSBzdGlsbCBuZWVkcyBiZSB0byByZXZpZXdlZC4N
Cg0KQXMgSSBjYW4gc2VlIHlvdXIgcmVwbHkgZWFybGllciB0b2RheSwgSSdsbCBjb250aW51ZSBk
aXNjdXNzaW9uIG9uIHRoYXQNCnRocmVhZC4NCg0KLWNrDQoNCg0K
