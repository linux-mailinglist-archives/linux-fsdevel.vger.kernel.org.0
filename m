Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4AA52C428
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 22:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiERUWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 16:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbiERUWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 16:22:36 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B793F688C;
        Wed, 18 May 2022 13:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+ORq3mtPyOTjnDWM0+H8ohwyZvWP8ac679Aix6Be0ev0AJfHtJ0Rti0LUSJV2xF5UDH4XuWj9+IzQUMoZIGooBKw5ESfh022nYax0UVWEB/77vVluzH9MavLL7X/HcILR3fqVkn2VPIaKdWF2iWM2bU6QnVRf6BjLh9R+gSUDSIaZ1YEll0DRmBx57W4Kzbo2jFqABEZe1QpYanGPMT7OkjPpjz20+1msaFLq9W2vkWVROk9fdDPX0I/SZc91/bcl8kCQly8cFLc2n0d8JWxP4+aBIp8FqFDRf4XFz4qBbJaLGW5NVcjqTk4/swhiE0/GODWlQr6aZvXF7nYGCXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlCiSEWHfoe8MaQMVRE7UYzIeqP0pzSX1eQqziaRqF0=;
 b=QIhBjaVF/n6bfIJmrQ1H2Z5SLAk9sKKkE00BA4IM6DvFEi00wosR2/OrWAia9duALc+e0zlTmYYxD1hfcH/soE8sPQ71sms4rZ9mAjcCdC3wEDdWY5Fks9ES7jdj21O2Bani+Pj6HvTIwMX9Syv/5b8SzbZeOx2I7fcmLuWaxyU8YHnMTMDbd3x2fUb/HeN8zonMY/3SfEhlTM5NK7GqHkICq03UdTzoNJm8hsG8I7aU/Grqr7TljUtuZUNlUAeXJyGYapwr18eU6dFx46R/pWnvdxsovzI1qjcxWc/q3VDuQ25qHpH1HCMwnV5izkj7lBu5fTaODmy9VxJmoeG8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlCiSEWHfoe8MaQMVRE7UYzIeqP0pzSX1eQqziaRqF0=;
 b=ERsVh59XPSnMyoU6zUGgxpZMVqnmLL97yd1Tt4EkCf/cru2LnjOJRWKkimCiMTJQdQkB4KOyWJTmbFZZaKajcHDRam4Qfr4bjvHIZu2tKgQTkCXz0UvHYhYZgK5FmF+feRnujDWbtkrEI1B/XbMnJ5nJY8HR3PER/qEq+9R0sA0r3inx7xQukUtoYW9SK4+i20ExN/+yP4ePzUYFLTnoWRVSSF6XSTan/kERORyAALopv82+7Te44BZFmbyX05lcRy3lhMgrYaAqgZM1Kku/JucsgTWlsGJF8LrlR2kDSJe6AM+JjeDGvZPO98Cq94EXzc280jQCmx9eu6ESV+/R1A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 20:22:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.019; Wed, 18 May 2022
 20:22:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/3] block: export dma_alignment attribute
Thread-Topic: [PATCHv2 2/3] block: export dma_alignment attribute
Thread-Index: AQHYatr5zOQaCjcuwUuVTazDF4sTIa0lFEyA
Date:   Wed, 18 May 2022 20:22:33 +0000
Message-ID: <29d245c5-905f-adcf-dba4-c11b72dcd7d7@nvidia.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-3-kbusch@fb.com>
In-Reply-To: <20220518171131.3525293-3-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7b9534c-0bfa-433c-8a08-08da390c2406
x-ms-traffictypediagnostic: SJ1PR12MB6050:EE_
x-microsoft-antispam-prvs: <SJ1PR12MB6050884001A96E4642877676A3D19@SJ1PR12MB6050.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6pQJNdeF4RifqX+T6B5syK4nig85+xNzhnjed57aYePzT/He3QfLrakS/eK2E7uTHQIwDcmKlfSp7ftYY4sBYKE+RFjktSu7Buhcggh359lUQlIBlFRA1CYSdRIXqo2c53VQ1VboOUzJRThDH0ON2emCXhQcqZDnuQbOn1Pry7tgFJ1SM+Jig68g/G818mLUNW+9dtjBkOBIzmdIPTwoVgN8I/RqqfKEKNSy3WfakMVl9hRa6I9g326H354iazQuwZVRpJtCCj6U/a9KesWeTylUoscDMjrU8q4V35ElL+V3esm2FAnfrQnfv44QcoLGbNrDQG96yjcobKlUl7A930lTpbJVGqFj0JClnPFZ7nWeOI/ZmNMPCUwlEaOCwOD1LfCg2CaW+TukIqKPisp+1KXcOcXv2UmhLzJ41i+O1pqLDPnT9J2ckiLgyimQYN9xUYofXUM61v0JXd+z8Vyu1CrifRI7rFEgQvTNDW+WLq4wyR5Gxic6xo+rYTyUp2yOZV6RcHwvpfjTwlbMY7J+k/bwcAFdJUjmOBhKocJ8IwOAeLdHs2/VZ58ErCoRBvXV3UglRuZUgXrfnzbfb810g0OewnSZgHa/O3VEsY+QQ/9kXO2D5VNsGQ4Hfz0qF1uUnz9pb8sf35sDYvJ/vZXpbQnejQAYGkhYqptTgbqmN2Ze7rsKyBfvTjXLy8VMeupYVny3zGFB84q4c3XeUMO8XSZj6ZxqyzL9uGJ2Y519DeyqO+btb4Xv/msRZzEAMKhcg8s1pnDA8qxZKXCoRH+P/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(66556008)(36756003)(71200400001)(5660300002)(6506007)(31686004)(6486002)(508600001)(558084003)(2906002)(8936002)(53546011)(122000001)(86362001)(66446008)(38100700002)(64756008)(8676002)(4326008)(66476007)(76116006)(38070700005)(31696002)(6512007)(186003)(316002)(66946007)(54906003)(110136005)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG9EMUhUKzhSWVUvQ2NmQ29WN0J3dUQ0SEpFRlBwS1daOUhQOUduVWdyKytx?=
 =?utf-8?B?bXVtcTRMdXNLTDFuL3dyTVZNNncyVGlNd2RRN1ZHZ2Jtd2tYMmdyL2NxS1ZL?=
 =?utf-8?B?TG1QS2VVejUrMENGSnF3S0M2Sk1uU1I0V1BJMXZjc3lmUDJRSTVpY2pFK0pS?=
 =?utf-8?B?WFBaOXoyNmhnZC8yYWhCdkdEV1lkc2tDYVBsdjNGdEFQazB2bDNXdDlLbk9X?=
 =?utf-8?B?aHBZYmszK08wYmlnUm1UTG8ydHRWZ0Ixd3VJZXg2K0NvYzhYSTNZYU4wdjF3?=
 =?utf-8?B?TXREMXRDeG5Qank2aWpzUEJ2VER0SEVvdHN6aFE0WjU2d0JmZGNSRDFSc1Mx?=
 =?utf-8?B?NTlINEx1YkJOQ1dCRXpQU3JZV2J6ZlNLTVk3MkQrK1hjNnlRQzVnSnh4SjFs?=
 =?utf-8?B?NnRHS1Y3ZnVMNmhEWm5wOXRwUDhnZHdwa3pzSXZjdnliNjlIcHZNNUFWM01E?=
 =?utf-8?B?bTFkU0I2SkZ4OUw2UDEyZ2cyVjM1OEwzWFJ5YnNhbVVUOWVyR0Z6QjRwYmJL?=
 =?utf-8?B?UXFHTTJ0RWpXdTNHbnlWT2JUWDVFTnIxQ01KdE1mU1Y2ZG80a2pyNGoyMFdS?=
 =?utf-8?B?a29WbDBIV0wzYXdGL3hBbXNLcHVIbkJtbVhQcHdIcDFobWs1OExPUG9naVFN?=
 =?utf-8?B?dWw2VGh5M080Nm5wRE56U0xmNDVsWWlJemsxSHhRRTFPdWhKQkNXY0VCS3Nn?=
 =?utf-8?B?Z3Joc3NpWGF0eGN1ZkdmTnFJSVZ0bERNWkxJYkFJcHdrVWhKYWtZTkdKL1VO?=
 =?utf-8?B?aVZ1ak9KdTNibkFkVEgrMWxCbGVKc2tDMTJHR1dhYnJkOVpWd1FaOWtHZFBv?=
 =?utf-8?B?NWJpYU0wNlpaT1BIYWRiNWVEYVVyTUhPQVY5RmU2M3duRnZ6RGloMzRITVAr?=
 =?utf-8?B?Zzl1a3ErTFBicmYvd3M2TTVqTFI0VTlQTFBRSEw2d1BxSVZnNXlHTmpZekR4?=
 =?utf-8?B?ZlpTSjg3dUR2U2NaQ2dTRnl6cGE3dlBZcmthSEpyRDJ0UnNHZHl3L2hiaWJi?=
 =?utf-8?B?TmxmRTRWRGNZVFV0bmd5MUJtUGcvNXo2OUxLbnpBMWcyWi9aZWIrMUk1Mndi?=
 =?utf-8?B?R0M3S1VIS3hRSTFJRFZQNVUzNVc5cEFoTXhvTFRoNEI2VHFrN1JtUEd2SURW?=
 =?utf-8?B?M3RQUll0OGNsbTlRdGZXT0JnTUJiSVdLMkQyRXNoZTNVYTVoS282NllhYlg2?=
 =?utf-8?B?MDFvL1k2ZE1jaUlkcTJSUEJDbERaaFUyemdBa1JBaFlpSDZ5WGppTjNtYS9J?=
 =?utf-8?B?T00wWHEwTVdncVFxUUt6RXVmMzNXR0o5K1BrY0ZzVmMweCtWTWNIcm40Tllr?=
 =?utf-8?B?b2UzQWwvRG54L1RSbWVKdmxhcFd1QUI2YnNvUXVXOWJaaENpdjRIdmtNOWxp?=
 =?utf-8?B?MVBqK2dUOGp0OEp3STVPTmk4alBVTjJCeXB1YjEwSERuQjdwaW95NTdtbGx1?=
 =?utf-8?B?dTB5U3VmZzd5U09NYStzaTZ4bUpNT0hQeC9NTjN0K0xVRXVFN2NXbjZ4ZlhP?=
 =?utf-8?B?U1MrUnFCeXd6TXZaRVN5cWYzSEliek5aUjdnSHhpK1YxbVRmM0NURkc0bkJ0?=
 =?utf-8?B?b3poRHhHNlpUdVFIRmVBY3NwRkJxNDBrTUFTSVNDbitjazVtdnlyME41OU9B?=
 =?utf-8?B?cE1EZ0l1V2oyTUc0TmRQcUwxRnFGYzMzRmQ4ZUVaUGp6b3BmVWltOW1HRVVL?=
 =?utf-8?B?NVMrcmpvbzZmQlJmMmRMVC9RYi9vTmxaZTlIaDVWRGk3aE5qYVFsZno2Q216?=
 =?utf-8?B?MmZ3SERQbUIzczRFMVNtcnBIMWZTV0hNclB2dmY5MFBnRzdvU2VrL3lCYjhh?=
 =?utf-8?B?a01DcDh2cGRnaDgyM3A4M0o3dUlYd0dVUzkxTmZTS2tvUWttdjU4eGpuanQ0?=
 =?utf-8?B?alJ2VlZUcU8vcFE0Ujgvb1lPZldrVGxBQmE4U3NhMlZ6OWQ4MTUrSUUySkpZ?=
 =?utf-8?B?THlzaUxIOTRCc1BPQ01mbndRdW5nQWxwYTZEcTlmOGY1NzUrMjBrSVVaOE5U?=
 =?utf-8?B?WnBZY0xDampaQU4ya1BhRlFZdTFaZnVPSTBaOFhNck1rcURJT3dEelIvcmRR?=
 =?utf-8?B?ZVZDeTJNdks4b1NOdU5FbUtEK1FOTG5NRVh4b2x0YTRxM3o2YkZHWGRUMzNa?=
 =?utf-8?B?MVBhdHNkUzM2YWI5STMwTTkzREh2cGpETHBod2lUZmI5WkZZWUYyaWNnMnJi?=
 =?utf-8?B?NGVYakJJK1hnK01lb0c4SXFobDFVRHg2cnJWbXJ3LzJHdWZ6UDZTb2NLdk45?=
 =?utf-8?B?UlFpbjg5ejRrdjZjd1dkTGZ4N1E5Y2g1UFhrWUk2LytPSUlocTI0cjB6azlP?=
 =?utf-8?B?VTBXVnBnUitmbEQxRU1KdHllU3poUHFKaDc1eEQrRFF0bkFybGtJemRGdzZj?=
 =?utf-8?Q?CnMqPb/XpvNeqZpJtnfjEefhF33lJut2nXV8C8WxwGont?=
x-ms-exchange-antispam-messagedata-1: EjXpM8hSi7rGhw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <14DF646CF96B1D45923B96AE7D982EE1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b9534c-0bfa-433c-8a08-08da390c2406
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 20:22:33.2989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvzR1b9Chjy1SRRMe788JkGDfIKs3RZc4n3H9vcGuC5W4jLSnbL6vrPW6gPosZyOV0IAbJaPjcS4XJR0hyg8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNS8xOC8yMiAxMDoxMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFVzZXIgc3BhY2UgbWF5IHdhbnQgdG8ga25vdyBo
b3cgdG8gYWxpZ24gdGhlaXIgYnVmZmVycyB0byBhdm9pZA0KPiBib3VuY2luZy4gRXhwb3J0IHRo
ZSBxdWV1ZSBhdHRyaWJ1dGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1
c2NoQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
