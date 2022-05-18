Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2D52C415
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 22:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbiERUVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbiERUVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 16:21:43 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64E941B9;
        Wed, 18 May 2022 13:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=casyxD828ibriJDz5X1lXGu++ewfKT5iGM8ErpKJIG3ufrhGo16IbekbGrCnjB7qmNLm59WbFb0kJghqjWGocfbqBPeeTmKwnHq6gc2cuAUmrZt3DNbBDzHvKhMj/G0GcwDfW6MLjJsMSgnsXK1hLP7mrLyNto/V5GfugwxDW8a9e18eHokZijNXHqgCH2pLnhKNK9BC30EcmqrjB+VMq/B9qHSikf67fMp2ydPPsOalG30dHPvYaYjW1b02a4+cBnqVb6C1ilfSNbsYEBL7BNovZ5CpisSrXx2kAnXjokuziJ53Ud/yei8/zi/o7UXb/GB8uD+OhvPkLJOyT0lD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVTsycVP7a4Y1pmwHXMxd6nFVUwkDQqO2Ic7H4hyZIM=;
 b=hV3/OALKZscCxSlSyL8MBD4f9RNee/C41EtbGpyV/zffeioHJ+81Rt+yw5zJwOPpQzzIovBprHyG5d8rXkfPiI3bL0AIEl/qRGN+qVCCZbAypCzjlPLbpjoxrDwghIDglF9ADsonOzfHtB8FX5Jjrf76VQVXz3Y3FXtOVfnArQZQPMoTmXw35zfRxEREsatvlz4e+VkUynb+irGroVVyjxqDLpa1LpvGBtH1qUgxXCSTL3vVQIGeVJIeiZ0JL/IMHuFJVGm3cE+U3o/ijUjesaemXnw7zah3P9eAh9XtDq7KXwp3yzBc8U8BoRxgdP5PTHS02itQg8udrX9Neb3Kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVTsycVP7a4Y1pmwHXMxd6nFVUwkDQqO2Ic7H4hyZIM=;
 b=ATm+gLFj44UF/MudhrC3DTil5bN16FFzImAkwaCygTWBJTyX5APdr8kY+5tAX/YXvrEa9ZsTvgyX05NxiCrh8ZDelq7lpNoOkzebLEjYRZp9AAUG+B4yYbDbTI8E564j40jq4p7d9hQMRBDgPklfMxqPe1NtkP3uwS0u1hffPXWcqYpzdiuGR74U4obpsC3dWwX7ROusQ9KvPAMy1nQtImuLWvjj+jfFTC4pNLhYxDoVaMqd1JaKIDVvur+xf0poqL2MXzsiFvjT3y2sqfFJHu8AS9+n7VjKRcUsiEbRc9yCVDyp+f4s+4BIrfDt1FSeE9R4hN9Nuk9k7y/qq5V6ng==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 20:21:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.019; Wed, 18 May 2022
 20:21:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/3] block/bio: remove duplicate append pages code
Thread-Topic: [PATCHv2 1/3] block/bio: remove duplicate append pages code
Thread-Index: AQHYatr5/qCg/QuXGkWhAPWwreYOAa0lFA0A
Date:   Wed, 18 May 2022 20:21:40 +0000
Message-ID: <f0447e45-b390-0a04-ea7f-ddb773a14b0a@nvidia.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-2-kbusch@fb.com>
In-Reply-To: <20220518171131.3525293-2-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72926d91-2c39-423b-a6b0-08da390c0487
x-ms-traffictypediagnostic: SJ1PR12MB6050:EE_
x-microsoft-antispam-prvs: <SJ1PR12MB60505012C7A81E9E4B0A9006A3D19@SJ1PR12MB6050.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bxIu4Aio9PGcNDwQD8n6PScLFmet8565TYNpxOQ9UAYU5qi+kI2hDHzTcHJ9Jo2E5u9l3Z2xRs2ohzxDXvUkHgsXZP6cOlzFw/NDNNWYkMLER62fjzNufZ6qn84bKuk4fFzlxgX90aWZaaG5steddm8Xrgpr9Dz3SjAFm77K/l20eOmi7tq4yp5u7Msk37FTXQQlmNLkerNfEpun724ezg6sQCX+XtqgNQFaAphR/iDWeYzCYE8BbYagUDEHULkCEu8CeQ4rfV6L4dcGNmXurWOkfgDbqX5ntSKX8bU/iYyizLAuMJAAM495Zrwb8WqvbwU29cvr4MF9FeHe/3uXSmUgInd4YaXBmsZdOwLScOCxsO6/kUxvLscHcWiTYJrCLzI+zbfb1vKstE14TIs4gtmKhsTw5/S2NVB93LLT9RajTNy9bgrkNqRNAwsAFh9lL1FA1pV9IENdFHEdNWR9W+Nb9RNfgtUDszRjkD68USnfy0Z/0zMgCXCcr23Rkhd3Vj2g44lyj1cjguWb1fMVXqB9nlKEavlZQtjoEwK15PAtJRZCMOx6Wfr5HBaLC8hJIae6dlum2J6p+G+unM+m5cE20fxzbXpqazjbMQPkBh9D2ZKWF2r2Ek3ZUVO9MKlPxiNMvR3IeF3h8Nd/SvmJ9ZpifhAVh3sEpZPT81n+AovpRsvTMYOcQBBTpcRxX9etCm1Br1Oddz/Z5ioBkrUPjlGHmlGj5uHmDqmiys6iF6f1xKlHUbdbjkobHXCji/kj0D9YS8PmHsDECBBNvRWXBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(66556008)(36756003)(71200400001)(5660300002)(6506007)(31686004)(6486002)(508600001)(558084003)(2906002)(8936002)(53546011)(122000001)(86362001)(66446008)(38100700002)(64756008)(8676002)(4326008)(66476007)(76116006)(38070700005)(31696002)(6512007)(186003)(316002)(66946007)(54906003)(110136005)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlBGYmZKeFFnSUFJN3NHVEljZngxbFZwYldPWUtPZWR5VEFGKzRSU3NXeUFK?=
 =?utf-8?B?QSs4NTVZUFpGZjhNaGVJY1NLSzNhb1VBOGFmb2lORFBWdmdDZXZuaTZzUXZX?=
 =?utf-8?B?eHkwV25oL2VNTlRLTDRObk4vTTdGVFc3Mk5NUHo3WkkvNkl0S2NOTVFES3Er?=
 =?utf-8?B?TXpDUGpLMTRjaTA4L1BxTlY3ZG0wMWVmdWI3d2RiTXRCUm9uNytLM0doTnp3?=
 =?utf-8?B?U0hCNmNtRmd5S2hBR1BiY0k2eGpPZGk0eENwSnZwS3lQTkQwcStXK3R4U1U3?=
 =?utf-8?B?Mi96MkpLSmZIa1B1eTRpdTc3eUt6eGJVa0xTVlhzR3JkMWJQVVdSLzN4eEJP?=
 =?utf-8?B?Mm50R3JLWGZCTVM0cG5mbWVvR1FVMXMrNjN0SXlGcUFJcUlKZGhaVkxxVzRm?=
 =?utf-8?B?YVl6V3dTYjRMM1JpQTJrYzJwY1ZQTHMxdTJjVTlja2NuNVphNWd1RmpDcjRy?=
 =?utf-8?B?ZFJtUWkzV1hVSHpubmhVL28vMHVoYWVLNjBGZXJwUDhYOUluVWRvS3ZNbnpJ?=
 =?utf-8?B?dXBWTmp3aUJSQkV6UkdlenlQUG40aFZ4d3paeFZBM2szbnlZVUNESGU4UUFn?=
 =?utf-8?B?RG9vbVVCTnhDVTRZQ2lSR0xQR2NxWFF2VGJNZHRONWtSS1FEdVA3MGRwQ3Yv?=
 =?utf-8?B?SU14dnErYmRYY1Z4MFEzZU83aS9pNWhpblZiWnRuWmRxK3NOemZnZ2hmSXlG?=
 =?utf-8?B?SUNxU08xRjUzaUl0M0h6K1FUQkxoMk95dHlUOWh4ajA5SUM5TnloQkMrVXhO?=
 =?utf-8?B?UE5Jc3plSnFqRFNsUXdMOG8xQnJJTFNjaVFrdit2c0ZUOWRnekpXUWJvdStF?=
 =?utf-8?B?Y0NhY2lEVFM2aTVxQkJsc1N0UmJjcFZxVVNTUS9vbGhYM0I0ZGNvNmNWVmxM?=
 =?utf-8?B?S2g3TWY0MkM3aldMcUw0SmRSZExUdzRKdGlPdWRudFRQTk8rMk9DMGdhNXdG?=
 =?utf-8?B?MmU1b3g3K29rUXFGb0hlTFlzbDZwb1RsSEF4NjlQQVRpM1dkem5YUmZsV3RJ?=
 =?utf-8?B?NGM2ZlhvRmdXZnJNQ1l5L3FLbXVGWXI2T2Nmc1MwSmRUeHcvSGhJeFR0Ujlt?=
 =?utf-8?B?eXM4N2RNejNSS08vODZEYXVWUjZQazIrd0Q5aC9UQjBnMUZ1OUZJZ1RGVFov?=
 =?utf-8?B?M3dMTVNDd2VKb0dDU0NjNHlzYWVQaEt3VzY3enU5YnptRnNrbHRzUzE3NEIz?=
 =?utf-8?B?U3dYSDQvWWRtMHRsNjBqRnYybHhlVWNYcTVOWDlFYTVWdWl0cHhTUHZ6ZFgy?=
 =?utf-8?B?cGVwdXJqenlWWmJwUmNKZXExWm9RcXUyRkR4VTBTdnhvaS9tb3lCa1VEeUFk?=
 =?utf-8?B?d2JXenAwZDVWa1lKY0Q2WVRDRm9qb3IvZG1DTklBdVZGamtRWU9jVmVTakhy?=
 =?utf-8?B?eHJJQ0ZaUkV1UEJEeGU2WjJmY0tOU3FHKzB6Z0NENHA4Y3U1WGdDVW9HaXho?=
 =?utf-8?B?ajlURU5JRlh2TnlyQ2RLZDhKU0RjbzNwc3BuT29DRFBXSjNJU3BaZnQ3N3Ru?=
 =?utf-8?B?K1BobjIrUTNMRUpNUS9ZbUc0ejQ3R0pRYm1KU3crUE1KVEl0MEZnZFAxOWVI?=
 =?utf-8?B?bEl3WXZtUnNhbnZKTEdiWDJHQjRCWnZ5L1pvNStwZWlOQnB5MGI4V1RmRElS?=
 =?utf-8?B?TXRhblNndGg3WjZHMERxUnl1eTdiTnpKTE5mckRLelFDWk4vVXcyRzlMVDly?=
 =?utf-8?B?TXBXcWNXT3NmQXRhQzVMNVBtRWJGOTYxaVVjaHFLZjFtYTBFeWRjcjdqUTY2?=
 =?utf-8?B?UTgxMFA4amVYMDRNVnY5RW16aDd6TUxKNFFoV0x4TndWRENTaENuWjQ1S2VX?=
 =?utf-8?B?cU9vT3JZUVVBaVpEZzR3aEk5aXZ0ZGoxQmxYRG9YTHVzQVM2bUJIL241Nmdp?=
 =?utf-8?B?WGdpUlNoaDVBZ2dYMVdVQ2gzMDUwWXJVOGZERUhURGd0djZCK2d1cU1qR3dJ?=
 =?utf-8?B?ekx1YVJIZFY0QmE0TWJFR283Q0RzN1NIdXhzeVI4WXR3WFl0MEdVb09STGMx?=
 =?utf-8?B?eFlwQ1FTejVYb3FVNnpXQy91ZmtYODdLTUxUQjNLU3EvazNrNkF0cXJyb1ZD?=
 =?utf-8?B?RExaTkRhMDRPYXB6dk1LekVIbmNBcmgxdkF6Um1IaWlBZVNsZkJwZjdMYjRv?=
 =?utf-8?B?K2xialQ2bWZkcklKOE5wbDNTdFNXSUtEOXlQdkt5THU4dGR5alVlMWRQUnBu?=
 =?utf-8?B?R1JadnBSM09LOXFvempCMWU2S2pxSUNWbHR2OWFQTEI5WWZzRVp0RXNnK2lE?=
 =?utf-8?B?aHp5SXJ2QnBNMGxIZ1J3QUdvSWRob0FtcEhETEp6TktSY1pIc25xaFRySkc0?=
 =?utf-8?B?ZW1GQ2xic2tJcC80VWdYMjhmWGJhay9hcXJlcnpmWXg0R1dMRmtZVWVzVlRH?=
 =?utf-8?Q?QoEaAxBIYBftZv7GVrDJgFUmh/dLmDFldE+Zt1xDXs2SR?=
x-ms-exchange-antispam-messagedata-1: Ifh8ckbD9HEvBw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <34E5EFBC125670468C1B29C3FC6602D6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72926d91-2c39-423b-a6b0-08da390c0487
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 20:21:40.4579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYGfH1iOkoXhnNI8LxQasdc1c5kHNaf+TneB7sdUtDP947gHc3L+u9hwODEPAjkuOmH7Bpswy7rTWSvAIJlr4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNS8xOC8yMiAxMDoxMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSBzZXR1cCBmb3IgZ2V0dGluZyBwYWdlcyBh
cmUgaWRlbnRpY2FsIGZvciB6b25lIGFwcGVuZCBhbmQgbm9ybWFsIElPLg0KPiBVc2UgY29tbW9u
IGNvZGUgZm9yIGVhY2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2No
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
