Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7373730687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 20:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjFNSDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 14:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFNSDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:03:10 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10EE123;
        Wed, 14 Jun 2023 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686765789; x=1718301789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=g97l4DfHl0cj3Rpv4LktIbtjEHcktGSYGb1NbD1ZUifPCpAbfcbn6hC0
   wL1daDK6H1itr3nweU9m+ipVQxRO7Rtv+95rpIcqGgoxXF6ZxYXfmE4FM
   XC8ZfdjNCerhaTqxO5Dyp4GCdSelLFxZIMMKn5oUIHfL+2KkyM760jA+L
   9qODeRbffLDLmBa8RvnkYnfj0uY31SoO0brteeb68f3qZGKFuNFbrQDRt
   NHKniiaQf3uo93tn+56x1q3EPR8fxQ1TEdRj4maI4bed+sM4jgNX/rAXh
   1o+A/wlDrj6KPk9gppPjNy+V5DoxsiEb6vMtu0PaUX6iE4+zgYCeV8s0E
   g==;
X-IronPort-AV: E=Sophos;i="6.00,243,1681142400"; 
   d="scan'208";a="340382703"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 02:03:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMQyiMIc+CJlvH5JpLvd5Umr0917Bx4v9LUVO3kOZ1DPW4m3LBX2ZKBo18UuVVL+y8jVkBAuY0JvPvxS0/ddkYOketCTRYgpeFpcVm8vbT39+/4Hogx+WnGF+BfCPG4VkIH6N/p9tLNMGjWu2s2dsidNZ0iFO+gMJZz7yN9ac3cOqZ4510ow6d3JGiG2kr9UmqT+8jdplN9nrYkwA2rLxcshKh6Fcxy1xQ5izhK1EfNMCCD+ZHYrTXjAVtan5KK03wXEnXqayF9f00BLOXZUqE60koCm4IhT3b5LlQVDfcnh+reFQSAaRlJw1qNDCTm+kR5oJlecL+QsNwjSkO619Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CoXhIZLjtwOIEwMj23zY1bo9q/P9y+oI/wfND9JLUpHljA7TvJNL9N0RuR4Ap8PZtMXsZfun1JjwpXMTdLXShniHdKvmYVB3xmS1oE1A1739sAngdeLWj4f8zkp63G/MH3W2sItk/Aig/HQaA48FiD9Q5O0CElf2sqGKxRemMlJ8bf4wVPk0lqILXcLdSnkFZfU48CTVeU0TQ61SRb7FOyOIfKnC+tqL0yiKS7qv+GyYe+MGpNdDQqNsWHyao8H/KywHr5UwisNwIIaQ0Pbwiz9U0CR4FMXWHif0m79YJxvQExdqg4LaiCBR9tSvDLQ5s2aK86HTxii6gBiEeFdYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nmQhonjMS9vnoLWv8wSvY6C4G8PaszIZOcqJ9MPGHAnM5vpZbyTpSY2+6c819ryVnX/dE6WEEWo57y5W775H6hvV4E03Z6ZGHUCc3YAoNAYVuTHZ3bsyw65iJDoxgwvLvKtjC6LuLfPdPrCH1MHID0IzxV3rm5y6hrQ3QHfijUY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7797.namprd04.prod.outlook.com (2603:10b6:8:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 18:03:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 18:03:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/4] block: remove BIO_PAGE_REFFED
Thread-Topic: [PATCH 3/4] block: remove BIO_PAGE_REFFED
Thread-Index: AQHZnskZYpPookJtEEacXduGHIKfsK+Kl14A
Date:   Wed, 14 Jun 2023 18:03:06 +0000
Message-ID: <9efd1c55-138c-099c-6352-227a3f6baefd@wdc.com>
References: <20230614140341.521331-1-hch@lst.de>
 <20230614140341.521331-4-hch@lst.de>
In-Reply-To: <20230614140341.521331-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7797:EE_
x-ms-office365-filtering-correlation-id: e1f97a25-5eaf-4b25-73a3-08db6d019ae5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sLysEOIm2eojFwT60b2+FPPt3wCvABnANLvHaeZhjfpLxUniAw6n/D4Q+n+4hS9zAtEkS3590cc9CmOg4R0k251chPRu6ZbsGpKw2SOWgppb28XF22+bsLj6fdDozh+A7lwiUepImNLPeY09YYpq3FM/lVT/hRjsPhcfCqYq8F4njEG/kcjvr19hRNcJC4Rh4VdqcQPPfJWI30t/rRNbu/N4QO4rXI5j8AuQ99vEaVsbhu12DXdYgHcm4IlJrJt8V5UiggEO87pVcYq5xtwvXdWewR+6+76x4H74m4Ur5iCUZ2KHr8yBRqQIETsPvRvcZpzwwuLvKd+ZTDmQ6u0fH5F3gFIcpwojuIT9Ji+8/P62KWxFLO2uV9kKonvbisXeBtqMoS3I53mBpw50UTtqeTkF+L0rLjRMRSlw4FIvzVi0nJil1GzyXqZwuqtdbJcZ9+z1/l/AEmfuGiMd+2IKL2BzfZS1T2wUmDKnflpoMMgCmNUMc/Y3bkScGQp/W+oInzxxngwrY/2gWV1oCF7jvBpjb2Sic84jTBfxTg/HqD76F6DCq7HEFxIMl74z9Sb5HI8x9DKSK6xnpnsmqea8i/sAhVK95QG8WQEuOFBKgoSizKTt6CirurddZ8foWTz+iRcltT66tNiIVxAIsoX872nKGfNr/3dbnFx7ypJgbvamrVI/Fv/lIDN3PrQBmALL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(6512007)(186003)(6506007)(4326008)(2906002)(66556008)(66446008)(76116006)(91956017)(66946007)(19618925003)(64756008)(66476007)(558084003)(31686004)(31696002)(4270600006)(2616005)(86362001)(36756003)(82960400001)(6486002)(41300700001)(5660300002)(8676002)(8936002)(316002)(38100700002)(38070700005)(122000001)(110136005)(54906003)(71200400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUxvRHVocllsc3dPRFo3dzFXWVlvWHN3RE9rNkxvcmNKaTJPaHJUTjljMVZw?=
 =?utf-8?B?cGs4T00wNE1ROGhEU1Z1dUxxTHA0VUQwNFJPcTJ6SmhSeXQ3VUw2Z2ZZaVk0?=
 =?utf-8?B?em9TdGM5VGttcDBTRDNDcGlsUDdrQzRZWlZzSlFrLzNndHNkWE5yTFNnaGJr?=
 =?utf-8?B?MkZHR0VqK3c1RWRMN1k0Rm1rWXlkbkJCUVo4QTlhVkNGbEdqajJCWGVnSklw?=
 =?utf-8?B?UTFDRjZpekl5QWlLV3czZndJWUV5aDllNWRLbWRQZmJGblowSEdha1lBYlZm?=
 =?utf-8?B?Nk51blAvdjBUemRRemJYKzdOUzY1cHNhYnVNQlkrbjNOK2FOMXhKV0RFK1VN?=
 =?utf-8?B?UkQyM3c3bzhNdm8yck1XWm4xYUZPK29uQkI5NnhUcWNOZUpncG9yN003NGh6?=
 =?utf-8?B?Y0ZxUGZzNTRvQ0NGVzBGZFljdDMydTNESDg1bWVmSXhHYkZQOE1ic1VKS0lY?=
 =?utf-8?B?RXA1U3k0Y213cFZ4NnNGWTBrenVXNkxOY01LMnZYK0hteUZhRW14ODlWT2xl?=
 =?utf-8?B?VXBKTmxoYzhxZlFvWDRSMDNkQ1J6WWJydytKSmtEK3c4VStWR3ZGR0g3WUti?=
 =?utf-8?B?MW9hMWZ4TnoxQ0lRS1ZudlIyYXB0UjhhM08rdURUTXhVVXpSZEx1SGozQ2R4?=
 =?utf-8?B?STF5VE1pSHkxb2JxL1NxVElVVGtGa1dyamtFTnM1WlpOVWo3RzdicTUyMlhv?=
 =?utf-8?B?MmhrL1d5SG5OYWs5cFgvMVZrUVdVcGR1Zml3ejJ4T1cvUys1Vjlna0t2VTNS?=
 =?utf-8?B?YTZteFU3SFdnL0xMQ2tERTIxcldGNE9teUhya3BwYlZkMDduVmVVK3Q2ckMx?=
 =?utf-8?B?NW5jdmw4VlpvTWhpZFlMSk9jM2EyWGxwSldHVzBxMVFMeFJlRlBXWTF5Y3Y5?=
 =?utf-8?B?RXdkUDE4YWNlNlFjMURTNkFJYlZ0QUpTbjkwSytmYlllQnZtSHJYRkJObnc3?=
 =?utf-8?B?VktTYVdiMHBWby9HU0NOVld6eVc4N0o0ZkpVckdXL2ozcVJ4OWlBRm8yWlRw?=
 =?utf-8?B?NHYzT0hlNmwzbmlJZEZ6REs4T0toM3VBSjFOMmIvYkFvZGNpYlJla0NSYW55?=
 =?utf-8?B?bVFkakMxb1VnSDV4OUtub0hEZVVLM1lIS2dpazBubjZCR0F2WFRMbmdtZG9I?=
 =?utf-8?B?LzhCZHp2Y1ErQjdkNTdRM0dIUDNFVW92QVRSTklEbG9qT1BHRUZsTU1XNms4?=
 =?utf-8?B?Z01yR0lVckM4Q3hkdy8xN05LRmdPelA3cVhGbXdXd1pSNEduR0thUEJLVXl2?=
 =?utf-8?B?U2Z6ODJTZnZRSHVXazIwWUlPbFFIS0FBWk9vbzYxQ051YlBmV3lLMU5DR2ts?=
 =?utf-8?B?WGxDUy9IS3RWbGRjeWZrSkVkMjJaRVpLaTlLWW5ScFpDVGxkUnBkREMvSm5W?=
 =?utf-8?B?cW1rNUZ0N21DenJSWlFXNGs1dXNodU1Wa3R3UCtpelVpKzVvdDgyakNVT3pN?=
 =?utf-8?B?dXpxYjEyTGFGZGsxREhIc0ZkZTZLZG9PMUpoMlBkdzNUMXZlUHdrYy9rL0c0?=
 =?utf-8?B?dXhDVzM2RFVHS2M0c2paTk9MNUNjQVV0Yjk2aEhuU1JGMWpGd1M0a3pqK09T?=
 =?utf-8?B?bHRINEY2T0R1eldVcEJNcmNOU3M1djM1SXBnbWF3SkVrTWJFQ3cvUzNXalgz?=
 =?utf-8?B?Y0hDWlVHVFdCd1NNQS9mbzNlZHQ1NEdoeTY3SUlWSTRYY0NqVkVxNFc1QVlr?=
 =?utf-8?B?a3MyZHZhTjNWN2hPRmYyV1lKcERySWhLSUZWRmdXL2Zrbkk1T1BKdzVDWG5m?=
 =?utf-8?B?SWNXOHVmWWo0L2NWdEpTRndQYVY0MnNSVGV6ZEk3bG1RVW5UaVE1d2h1WUU5?=
 =?utf-8?B?V3BFS0lUTExNTFNKVkpscVdIc01JOXpib2UwUmxsS0tqUkt5RHV5aXMxZXdz?=
 =?utf-8?B?anJaTWViTjJSYklKaDBxMWcvejl3Ni9lTkFUVVFHRldVem5hMjBpSUlLOTNm?=
 =?utf-8?B?Z25mUU11cjZiaU9vQVBwb2ZVNE4yK0w0NmNoSmZWNjlWQWZGSVNKSTBuVWpo?=
 =?utf-8?B?ejYxZHJEM3h0TkQ4WUw4dTRlK1ozMHM3NnZ2OXpyblNaaG8zNjkxRWw5YnVp?=
 =?utf-8?B?NDNCNk5ZbUV6amowNjdPMjB6eXVJMVdMbWRUZFR0Sm52QTRiemc3V1hqei9Q?=
 =?utf-8?B?bTdrTmtIVWZwTVRTYXF3eGEzMEdnUEpqamExVVUyYkFNb24wZTZId3phS3Ay?=
 =?utf-8?B?MGxpanA3QWJGQmFvbEJnVG1ManJiZWNEalF4RnJQZVZJeEdHMzRGeWd5MHJZ?=
 =?utf-8?B?ZHBEZHJCS1M0c2JPQkpBWmhzMWl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5ABB78D2A939E40BF1D3BE7A61E0D87@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7+x+t5eOBNtuA3/8fphEcffCTbRHCUqhu2t3RWt1rN8dTolo+CUJy09VzXZ36+iGf49xKZ9JqHhziQTEZ9eDFOHyjh+HPW1TXF+2hUTdhoI47rSCd1nhlwmUgW+rsQ8sV0ebFz0cUZ2oQnL6e1Kwm4qxzIL2HKiyvmo1Hm93Q5IIS+r0XkwLEHnSSdFP0HaTDbHK153SLoX8nfROvMg8E2O0EYUPSIeK8ZuZ4GcXBdBzPfFa9bLsBIg6SJAgOM9ghliC0hO/t3K6hgQwTOOTkHHGSaSUm+jUgrNVpZ+WaKujAnvPBaOoHruJQOgNHdCb0S5dp9ujb9LPc/y/iNqXZHEqDbaTw2nvyB+bnDX7p65Kb+PVFq8rCv9+wclbHP3mCFuOSjGbnYUK0f/h/rgBpRWtxXG6welj51HBr3oXQeMXsNIyIMJBEHLSu9B9rHwgnA4RR3MbtSG6rrgUzFEywbYQuCgfYW2VRmQUSnHHe49toqs4J0zqx6BQCima8+EGpQk9pRra7+pCBq6dRmuTRzmkGePUCjfZtF0jtcuA/lTzteaMktQUHJpXm5RvM3vhdnX/U3zSFKZ/hTJ3a1ScrbtHTtoX/dPXXYwrGl8f9Ac0f86hu2rUU4AK/ex0vCqz77n+YrSlB/HGq7E4FThVeclrXUtijbvGfgflMiSLZacG0ROTqBwUbxLALY7ojLwx4uVlyOcKfE9Kgs8gfaBdPUNdm6iWjsxBESS8ZGFXjGLDaa20vk9bIB4g0HuY0d4U8xMobjtGEPSqrptkpch83Cm20Vbma+1O8xdR068zzn28P1IUx9bIRB9QVahaPyjX+vNiDK4qeTuQg9P95KC9IexVpuAPLBmRZa/8Jb77i+6V5VP594lB6fELgdOWDWb+0xl4ecezxaS6p3OrrSDQEw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f97a25-5eaf-4b25-73a3-08db6d019ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 18:03:06.4051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhR/ON20ZFebujdvZep5eQ6+Skvikm8wgxOFBrB+t7fnQC93adaW9UHoy8Eno44m5Pwk3aydxF2nMMT8HLaZ+kDOuhwbG0MpowI6UMQDH+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7797
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
