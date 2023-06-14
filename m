Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F73730689
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 20:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjFNSDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 14:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjFNSDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:03:22 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E310A123;
        Wed, 14 Jun 2023 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686765800; x=1718301800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=gKFUmk5+afM0xKxaKRA+te2GZpAKkoMdQGdPWJFfhcaRdwlTUric72nl
   MZ0kRdCFmKpSNC26E19VhGrhjgRc4EACh44AVOl1HnwN8Z4eN6fOuTGea
   RBdYkzswhlXKxYicQsV8qesBY2/ZN9fY5zbvvl38WhRJgDSJDR6siDOr8
   Q2behLEA3cQnedRZQRTrzBY9GhzI4aBYGWlG9O71oLUpGp+Z34o5ZhLnX
   VTU15JwiJfky2OXcnbctSvsLLwsIkvKe2VO+wn6pC19r+v9WjfEVfQo03
   x7242UFZqY7W41MHTivN+N8w2dyffzcnJbk1ykhvMDEaWpJhnECcs2e05
   g==;
X-IronPort-AV: E=Sophos;i="6.00,243,1681142400"; 
   d="scan'208";a="240102616"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 02:03:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5adQsMz/Z/iixvLDmATEoe8S6FoBHnGtt32PBFEZs6xo2BIM3cAQyFJonB2fRGYF6pstIron3eEE1Oarsv34mBQlhThime4xnCJYb829HqkH5zoOzsyNmjhsfu27sQUv2Ge/Mfj14NCsS9xOxp0r/6wPTGNPqV2dJIlPJHVlNZL7MNZyEgS3CDwbTMHQzi9vniqQzgR7UZHfuZS+gIDulaM6YrQcinrcES/l9tmlcsJjyN/K2Ynt3CTdp3KukPfR2t+yLTL/XTCSEmwPJmiFaVzVuA04Z4qryqcigarLfkxWKYbHLAJsHDTc5a8daQnTgHKrrN+J8WR82ZluyIW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=PfPjZ9XextIaQL2jhoJqolxCd2r2hP4rENfcCkk2SQ/ZDkzfKYaEaxSpbEypn/X36JSVSffKCDEuzWjg5O5vqv+6SF8QlsLVWd4uZ+NTzvOjbI7SePs/DjzgcndVFDqqMjPSId8h0vHsW88PdyeqBFEm+2xo+JUUfPhXpPK3z7sbA9ICSOpUFNgWgujOXjx1U9wwicH6c+DZWsSuigcqEkS/XaIbgMuaxbEqswCRVQ8SOBYwcngsaD9VsPZvSQXZgScH4Ez7IcBGrcEFmiX8nYEiXIFaHPrczlACnOFpxMgmBUmwVFLLTzbDEioEcLEsScpk4uMYNqcsAcdXy+vdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=pYKGsOShuTcY/Fs+TkyDT9PE4gF5Q6hkyEUWQzLIi8YbY0L7BIokAX5KzMx+ULJfWiLD8kg1wK6MvTGLYzbJ0aZ797hF19nu7RYUPmC3REc3Q7oTUHRmxdC2OIaMv6mcfBKpDPetwdR4SA32igf3xsZ3zB+LBg0g49CnKRCAupU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7797.namprd04.prod.outlook.com (2603:10b6:8:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 18:03:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 18:03:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/4] splice: don't call file_accessed in copy_splice_read
Thread-Topic: [PATCH 1/4] splice: don't call file_accessed in copy_splice_read
Thread-Index: AQHZnskaLFtAL4hV/UOnkwxj+n2msq+Kl2iA
Date:   Wed, 14 Jun 2023 18:03:15 +0000
Message-ID: <33066083-eedb-39af-13e4-65a4ae6b2196@wdc.com>
References: <20230614140341.521331-1-hch@lst.de>
 <20230614140341.521331-2-hch@lst.de>
In-Reply-To: <20230614140341.521331-2-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: 8b024f33-b150-4e5c-50f6-08db6d01a098
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jv7Bd2gLJ0vzVB1wCXyoP4uiRCGkZ03GPZsHce8EQZNOq2P9PUbhmI6T7INDRWeQEaj54FFktUuFeHMdl4A1LGVXS2kglme4U04qRtkVreUZS3DQAMHF0b8YNEKG6o6YclzyojnlQLjAfB54S0LMdtaJJK+cSUZEhoZmfA5I7/x/PNv+f323Xh1erLCSGzPLCAiW0NBuJPRMmhz0q1KwG3ycquo2r6rPDiNZwlHPxY2jA7UXTbn8kERqiznkGmX1wWZdzcV6vlRP7ACETmmN+nzWINI/ZawrcKNG++ZG3bu1Y9YGm38IENbx1CscVRgGe7x/7KkwhbadhkAapm4huWiaenSw0P+cE2Nq+9x56C/jP0ecbJpeVuEkWnUIyJvoAmNbbwblT84rKIdAxzGFtfwPeEji6vCoijoy0kZRgNxHYwAGGB5iChE5xkNxS6H9ZgBp+oovEEJ+v0nj0QEuUNjVGMFXMtlAGarMfPDGKpRJy5aeV7nH+dxLwgFFSOGjj16FiBUpXhYsFWeld5XUvh8WxPLFxTSp8WEuOWyTiwn9K0Kwko9mbsvItyY/w5cUfr/P00e1ObHMtDAhYgcQBS+flVDs/KXQcCj87bVXWFM7whtVuEnf8XubvvtJbJmgvZ/SDZ2HwBBuhIdEIvl339iFRWB6mBE8tjed3loNy+UYCDAaT4/c1ERliM4IP8hQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(6512007)(186003)(6506007)(4326008)(2906002)(66556008)(66446008)(76116006)(91956017)(66946007)(19618925003)(64756008)(66476007)(558084003)(31686004)(31696002)(4270600006)(2616005)(86362001)(36756003)(82960400001)(6486002)(41300700001)(5660300002)(8676002)(8936002)(316002)(38100700002)(38070700005)(122000001)(110136005)(54906003)(71200400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1BaMURlZ2crc0RyOWtESVY5WTFMMC9WQkR1NTFORHJDY1p5RjVJRW1rNU1F?=
 =?utf-8?B?UThLMFhUQlQrWHpKVDIzb1IvK2dSREV2ZzZmNHJrQi81ckg5ajFScFNmZFV5?=
 =?utf-8?B?YVU5NEN2YUFkbHJTUGNISGkxclE2WDEweEtQcGE3dkgxSU1YZXFseGtNUTk1?=
 =?utf-8?B?NjFEME0rdzkxaXdCa0hpS0dJZjBvRmM3aHVWMmxuMXVFeDFmelRiRlpFc3pu?=
 =?utf-8?B?SDJRYTUwTmtibGFKRVgzZ2RvWmRicnZsK25tRE5DVDBWRXgyM1Q3RXhNbW5R?=
 =?utf-8?B?a1RnZEVNQXAwcStFRWJ3eWhOa1FtUEIvQm9TSWo4anhCNzNGSUtVdGxkSUlk?=
 =?utf-8?B?ZHgraVV3b1pRQmNwa2QrdmJSR3F3dE9Oa0ZvakdDZnlXaGl3YURHcEZjUWZJ?=
 =?utf-8?B?dFNSbEhzQkpZM1FXWU5UVmplRUhXNHM1bzlmZ2JCdHp2SGltb2dBRnQ3R3Zv?=
 =?utf-8?B?VCsyZWxwajZuNlFqdUxWR2xObmMzSkp3ZGhWelhsS3NObDZBN3g2eXFuNmt0?=
 =?utf-8?B?ZkZBemlyRm1EdlBUYm05eExGYVFaZldWOFJ6dFFYdUhFRnFCbFF6bXM5MitW?=
 =?utf-8?B?SElvK21pZWlLYkcvUmVxei9QbkppemFOb0VVUGVhS292MkdTdUJmZzRrcFpy?=
 =?utf-8?B?Q0lXOE84U1RwK1JNbjUrVTVVNDN3M1NYUzBaNTM0RnBnMm5McGZQSDk0dkhZ?=
 =?utf-8?B?RTRmYlRnd2ZoMXN1NTY5SkNhMVpCMlFDR0F0L051c1BEazZaSS8xbm1BNVdz?=
 =?utf-8?B?M3g5Yk9aZ2ZpU0NQcnYxYjlhcURyV1ZzeDVmWWtDVFN6YWxsbTRHSWE0N2dm?=
 =?utf-8?B?Z1M3bTk1N21KdTNaMVMzcFp2czR0NEJOd2tSaVdyUVI1dDlLV2Yza2RySUh3?=
 =?utf-8?B?aHY4ZUEzYXBWQUNkenRvM21FdHcxRHEwOTJLVVFRQTN4MVRmUnk2ei9EWVJX?=
 =?utf-8?B?S0RSMmJ4SmpjQXVQNTl5K3N0K25FS2JGa2pUYlNrejlXbWlzVldsVGRQS1Bx?=
 =?utf-8?B?ZWw4RUQ0dTFaVnBBZjRGYVRJWUdpNVNWcW5RaWxYUCtkUU52NC9MM1ZtSjMr?=
 =?utf-8?B?T2ErSU5odjZvc0VWU25VaTN2WDNqaXkzd0srNEdrdTdGOHd3d1VtNkRUTDJT?=
 =?utf-8?B?M3pGUjVHbEx1V3c1Rm1TOU9ua1Q2c1UrQ3pmRFJ2TWdXNy9KVGsyRTFIbTlL?=
 =?utf-8?B?TVE3RE1nOFgyQ0kvZHUwQlhKbW9zK05VQzVIZ2ZENTgzdzRSM0ZaWTBsbmlM?=
 =?utf-8?B?dFRKZUR4Sld2RmJWc2tJYk15SUlycSt5M04rbEMvK1lZVEZucGc1VUNlaGU3?=
 =?utf-8?B?R1VIMTZUdktJS0xiREpCSENFVU0wTlphczczWmFGZTZhSHpOa3RNZVRFZ1Bk?=
 =?utf-8?B?MjZwRUxBTmYwM0R3Y1pzb2RNcElNNG8zSExiQ1lsSy9BMWI0Q085RlhCZHp0?=
 =?utf-8?B?TGNZeWtBeEJrWG44a3F2dy9Gc25rQm5raVRMdVlqaDZyUW5mVVV4b2FaYytx?=
 =?utf-8?B?YUM1cVBhaWtJdkFwNTQ4VHJmNkJsM3pNQi92VzA3aHpUelp4TGJCWi9veWVW?=
 =?utf-8?B?anVKeU93NjFTVHd3MklzNFRLdVVxUnFQVDFsTjhQQTB0emo0bGt5eSsvMXdv?=
 =?utf-8?B?NTNGRHVtOGh3emQ0WURNVDNlZG1adGpQdnRwN1V3SE9laVQybWM4SXd3NGxW?=
 =?utf-8?B?blJFTkVOd0VqUmJBTS94Qi9ZRWkxcjR1TmhWYjF4VWI4V3d2ZlBGTkFEa0xw?=
 =?utf-8?B?Zk5YY1BMTVEyd3IrT2xLeURhYXE4bUZtazhuV1dvM0xBVWJEdXBXNS9DdVRT?=
 =?utf-8?B?TGRndDdZSytablY3dm9MdTk2WG02NS9xN21DclVUVFdlbFhqN2VUL0x1eGhF?=
 =?utf-8?B?Y1ZUY2p1V1RQQmFPUjM5NUtuYzRQWDNGakI4eklPQ0h1eUxSOHV6bUIvbk5y?=
 =?utf-8?B?Y3dSRXRpcXl0UVB6cFY0TWlSc2xtRU1FSjcwSUJ1bDIwS0g0ODBacUYzQVQy?=
 =?utf-8?B?eno4aEpUNGN0L3ZlL2U0ZDErTHFvZW1iN3pzM0N4YkZLankwcGNtQzdKMkpH?=
 =?utf-8?B?VlBkckFjUXNNcUtvaE1ZSFk4WTRiakkxN1FTMVNpN1N0OFkxTEtVdVNUV0xn?=
 =?utf-8?B?WDhZKy9pOTFhK2wzTndrcXArZHJrK0ZnZmhwajJ6aVVCR2ViYTRpcnFRYVA1?=
 =?utf-8?B?NEJuSDNCaXVscisvWE5SZ3B2ckx4dXVZRVpTZmtZVmUwb0pnOVF3RGx3dHRq?=
 =?utf-8?B?VEp5bVMweTBTbFJJY3QvdllCcDZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <800FDEA9BD99794DA94BA7FFEDBA7F03@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: muSdTcezQ/uEhtIAqG7NNxpIWYZJ4u1Hk5j0jnVo5QfKH+FgrmJ4w2+wmwMWF4Xd59/dgh6BDlYd5wjlX2aKDtHRuZzLfnTSAeiB0UIG0EpJp+mt8RZOoGOU1Nc5MHt2kdsCpKTbVU50oFRdf8I25zfDDrGSorSqwmDYmUcymsfbEW+l6gwGIsad4tkZ8i/ehL+mJCqGAqjV9W0S+rBV9yDZr2JsPcKlinojFeiVQA6OapMxnGmTUejnmlKuTgKe0KSyb6NA6pNBLbQbSU7tndLOO/QXUXWczP3+TG3/I2Iwd182A2BG3nwy8q0h+WPphwfK1vVND2BXz8qPvBWs50WGCe3J7z2M3A6baJNlfR2QPH4/nFh+8Gu6A38YAdaxobv4/D41AbbumWvtg4YQ/hviZFvt9y0mQAtFwLSVMPPIVczOCyMTcXoxUV3dE2kv0n3fJO1fLkvietdIbyC+hUnxDWoA5DhsQJ+phjS+NRi9rLkTWEdiS7i7IGcNDZka3Bp05BaKFxVmTYhXN9Lle5t0AmZp3gbfYG88SQNkRTbgRB8wouqpvR9asK1DikyqKCUNEPH7DtXX0FkLuoN4XNFQdi0kkcdrwwFzlknI95HvGRmxDTwAW1P+0NV1O3b+7ort9jSDoo9U6AE1RaDohkdz+HfX41IoSZaOEmnXtsWGbgVOOe85SZJbOgoIfFidT1c1JqCwUAt1mwIHoKsmYIdFfeRpwJIxmEI0VkMkBUrtw59408Dg5zkaPrmknhwJFyYROFII08JEjK6sHowIFl605966XSsRoM4CpZAqJJeJDsHHKe6leKhLgh8KLPOmVikqUaflGZLTDDvLM1zoUYuzn7oTq3Tmxmg4E7dzbiGLULVSGQEFkxE+6qgVTIB5cP0cODs8g5NUs9Cr1VkdDw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b024f33-b150-4e5c-50f6-08db6d01a098
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 18:03:15.9292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m47ccCDCcEVM9sGXswWtFmjlb+sFR/5ogyo1hm+4FQXg7hvl06CwaFNZEEqnLoCaNnb1I0/xGo6ODDpUsEEHRwCXg43sxbzFk5dVLEfTeT8=
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
