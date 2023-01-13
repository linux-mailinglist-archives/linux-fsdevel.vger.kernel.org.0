Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8746693C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 11:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbjAMKKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 05:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbjAMKJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:09:57 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EB94261D
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 02:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673604596; x=1705140596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=cwxcZzMTCCKYGiXKA7kKBc1Bz2f3OzCSofKg+9y6T7jbeYKGyiwsdwuR
   rIk02xf5JyQiQpobxJSbQuVux2+RyXx6dDJSbdB5XRzFJcra1u+btly6U
   YO2DVIwIZ5JzKHeUvyhGlyPqn1+lndPoZ3Tu7rgrvFYzaKYj9VuXdEth7
   aKyLhGxhl0C+vEeUKTsWq92KMUr4SWeoMPd4ATg7VlcAEUMfyM8agSHJ1
   XPZhAL0cM8EXPVnCWChr/5cXeJKaN8HSiIoeAkYwihzfnNIcsmJST2d93
   hJbYnnrg06853eJ7G77mnrufoUl4hSjkVAXu6OB/S0N6D0h0gzF5DE8jl
   A==;
X-IronPort-AV: E=Sophos;i="5.97,213,1669046400"; 
   d="scan'208";a="325037933"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2023 18:09:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaYXbA0hYUdprTVMo1+q5xlNGKCvdUBrDo0w5uuU08RpWoL0jBED6yGZxYsmcHT/l+DppJe9KgG4OMaFHLa8vx5dmGa1/VTdK1PUu/6u/ew6RuPRUx/gwWV8wb8tiNobHlA3ft4W4HfB8AeBs1e+NPG0PXQZzDUcnm+JoXlyt+X41bMxbduSY5dE8jj8B7lkX842ldfZNT1GSg9qVlup6OY5+Wx7Ujs+iKPdxdz5RvKMU7s2cWoz6DTcGAveBk7W5qM2h7pN6IuofiLIfnAIkHm9WojvUmfOuKyfUFpvbzC2WmRaPGIWV/AmAr9QK920IfrQfAuAZMPIl6wZatEEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=aBxy8fvpOv5iEknwuODAwTk1X9S6OkKCXREkMqxK5y2GMnAom4eQCE3KEDdDDukSzmRv66sT16636gLPqekGVm9kdxLsibmqTo2B4D+sQz6+GCU9CLNnRPVBJ3z4W4FbhDhVS5HyCijwop0T673BFcd9qJUBc5ElFcqmnhKPZ+Q9cHR+ZgdQ6VF2/smXIdPETnKny9lPtBXuYlAOtIoGdNSrP3CbcQAYHCJeUI36Vlht1MY9HJdVBcPfRo4vnrEZEuOY+EKx8pkx1V1mc7qRMXYd0NjgbRGw6O70z4ZeMjDIzAXS1r4yOXSbZgj/o1HOyJB3O24L2vTefWi9b2LHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=R7mpREM1SweuNS+AWyI/j2NI74tRlF1OiycrqS/O4ZrNAuPwdoTR0GYk5sK5UbDW1PW4pqYENaCJbdZmryhOA2nnPDlM3MgbCqzThmtmDnrZvIeuGducwxhCEZnGOQwylQsvPCGFXuPKVron83usvro+uKQoNkGYPYOfUSq+gKU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5727.namprd04.prod.outlook.com (2603:10b6:208:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 10:09:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 10:09:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
Subject: Re: [PATCH 3/7] zonefs: Simplify IO error handling
Thread-Topic: [PATCH 3/7] zonefs: Simplify IO error handling
Thread-Index: AQHZJPSq5tGEVGTXik6FJMPx7E0t4a6cJG+A
Date:   Fri, 13 Jan 2023 10:09:52 +0000
Message-ID: <5892d833-e1d0-a4ac-b166-12dfb87652fc@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-4-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230110130830.246019-4-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5727:EE_
x-ms-office365-filtering-correlation-id: c107a8f0-4618-4294-d315-08daf54e4fd4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUqHk/ncjtg5Do4mQQxtemQxLopyiSyWVo42a73evlnA77bqSqlUhRAHys26AkNkgoUvTpFXemmkD8T6cxIAxmvb0wiUQbagiPUMp+42RWN0x2nqunWZlxUg6wTuG8vzXrZ/meDzUs1wELp8pv608sLXDt6DUZc1e4RRDfFn8GrSocoOxuzZggl1pQsJa6dba/s1O65ZSZwnvByVkI/poIXb/xSjdHk7zu9upBQMLLk7a+spQvsfq9SXug+hcCIOKUF0MUD+f7PNjVen/Zu3qbB78mQ99/V8HbroJir3u/aii4JdE+dvjcqEC/YJTibed6bdPXUOtPrCSYnu9f1HR+1Oi/r5OdNwLlH6btDfCW+F/VnVzJl3qKnD6rgTRbMec9gMBG/iDz7RLNeiJMrWCmbMuvdl+eJWUeMnHDCRJVSFi89z1drAnw9O+jBJXWJW/WeGRRzOJQs67eZ3DQgORCUBPLWsYsh6SxZf9XxmW4p0PJBBjnrX5TkxHg/fvEuY9SJ0wMEK7+aBCg+tNB0X0Hyhb9fwOAhxOmPOJ++S75G/VBK/HqjO0dOiMEAL+WgWV+Y8pJg70zMIvnbz6iRulP6wR/FYV3lafIt9hSrSxixyhnGLtQOdSHixFXd5HzR0H6UZy+StPsOa3XsCfZRcDGhTcSm4s0M3F1vXrScXfpjAPPc1JGaE7GmydapNEzgZsv+gg87k5jpKNotqMKVco3JGOs3DUnRyvN2WasFZ1aDRRh4B+ASHSKnPrJLMlufKUUVYqnnvdHk3pSKvuMPz/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(8936002)(41300700001)(5660300002)(19618925003)(6506007)(2906002)(31686004)(66946007)(76116006)(64756008)(66556008)(66476007)(8676002)(4270600006)(122000001)(82960400001)(38100700002)(4326008)(91956017)(66446008)(316002)(36756003)(38070700005)(2616005)(110136005)(6486002)(478600001)(31696002)(86362001)(6512007)(186003)(71200400001)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkdjMXFXMkowWHduWHR3TEZPT2M3VEdBQVFJQmJwZnJWOGM5cG1Xdm9PUXRr?=
 =?utf-8?B?ZjZTaUYrTm8rT3ZDdTRDTGE1MzR3V2pTcUJFLzRXdDlVZ2xxTlFCZ1RoTks4?=
 =?utf-8?B?bytXOXJtV2kycVhpOGIxcVQ3T2hiUVdyQ1Z5RzV6WEhHNDJ3dC8wcGNVMk83?=
 =?utf-8?B?R3djYW5VWVpMM1RmM1VrRnpMQmhFcFhXWXVkb3pJRHpER1ZQTXYwVWZGTHdB?=
 =?utf-8?B?ZkMxb0JTM3RiWXE4dGhxem4yejdVY2dUZVpIMDZDYzNhaUVybmtESnpnQ1Ju?=
 =?utf-8?B?VkYxTDJxRlUrZnk1M0pRQ3didGs1OVc4U0RJdEdUUnJlREIxK0FUYXVCaCsr?=
 =?utf-8?B?WVBnSGdwUGxOeFFSNGNpM0lka05QeGtWUVozOGpqUWVmbHRETXozRmwvM2FI?=
 =?utf-8?B?N3hiazkvNysyNHdKcmtQU011bEFkWVppM1BpT1prT1R0UnN5YjlxWTI4eCtD?=
 =?utf-8?B?VDZMZTNraXdYdEtkby84Zlg2S1JSMy81cEFLQU4zRzN3cVUvQWppUzNtZ1F1?=
 =?utf-8?B?czVTQ3FwMFArMEUyZ29ldDh5R0ZmblIyMFV1R1RRd3hKZXVUeFBxdkVMVExj?=
 =?utf-8?B?SThiMXNXWCt5UnlYU3ZuR09KaWw3OFEvdFFDd0dwRkpsTndRWHUyWTBqa0dh?=
 =?utf-8?B?bElCRFQ3WGxZRXhnNlk5dndOUHFBZkJiZmkxSnpQVHBNTmxTWU1FQjJyNnRx?=
 =?utf-8?B?SmN5VUVoS3dlVTJ2WWJsb0ZwUnhyWjVDVCtMNlhWa2d5aitGQ0E2U3A5dTlJ?=
 =?utf-8?B?WExFNW9HYXU3V1lCcjFrZm03UEZuM3BUK1UwWWNudCt1NHBYMnc4cUxKcGNC?=
 =?utf-8?B?Wm5Tb1BWdGdZZ2xQWjkwS0F2akE2ZTVzVU5QMnYxL0NlWFRieDlydmlKTnBS?=
 =?utf-8?B?R1ZhbzFiMUFxbU4xTkdCdW05OHNBWk5NaXBLaFhMTWZjSkd0N2ZsbFdJZFIy?=
 =?utf-8?B?YUZqWUV4THlMTWl6T1hnaTVaaFhSSW9NM2J2cUNLbUlPZFFOL2VzNWY5SFcz?=
 =?utf-8?B?S3dCZEo3T0Zhc0RUZkxRMXZqNm5rWE83T2M5M0htbDdERXRxZEd0N1VGSGZi?=
 =?utf-8?B?VENVU0dYMFQ0SDVieWUwZFZ0MmhLc1NZdHcxcUZIZlI5cHlYWVp5RjR5WlhJ?=
 =?utf-8?B?ekUyRmdzZWU3N0ZaUmt4Ri90TmFUdFUyQ0RsaUg0ZHBDUlBxWkd0bEZEMFJF?=
 =?utf-8?B?Z0MxbzY0Ti9LcE0xdDgvNnF0NGJQRlpTQjRhbjZISjhUQWhOY1dEOGg0M0Ra?=
 =?utf-8?B?U2pyNHNtM0M5ODMzMzdzNzVCYjZ0b1UvekQ5NVNpRElzYXVDUUpVL0FJOElV?=
 =?utf-8?B?NU1GRzRSUWhrMGt0Ny9BSlk0N1ZRV1A1U1NESWFwbENBS2NjNXJ2MzZrWnZY?=
 =?utf-8?B?RnBia29PWC90Tmk5QnQyVUVFaGFLLzlCZ0RSQ3NWeGM4SkRtVnJNZTZEY2V4?=
 =?utf-8?B?WHFublR3dFluU21Id3d0TVR3MFNUR1lNNkU1aG43cWZ6UHErUGZBZEprdytX?=
 =?utf-8?B?Mld3d2ZVUllLdm4vODFBcUFpRHBJZ1FlaVVXZndEUm9nYjFGSkhNQzBLY0Zt?=
 =?utf-8?B?RE9MNEtvOWc0WHYyUjBzMXZFbEVYZmMyRVBnSlB0WlBTc2lRM2lXQ2hJd1Vt?=
 =?utf-8?B?N1BHT0haR1M2MWFycWdpdWE3MGlmc1NMaFk1ai9mQ2YvbElubjFoTlFUS21B?=
 =?utf-8?B?VjFEQXNyUEp0NmxNVEZZaUNxY0Fmb1ZORmtmWVZkTGpuZnU3eFpiZjBhOUo5?=
 =?utf-8?B?RW1CREVOOEZUcENqUEdqWmFZNzk0Nkt1MXRNZGllVTdBUzlnb1NCQW5PSlNi?=
 =?utf-8?B?c0dSUkZRd2VkYUEwMVk5WWtha295bUd2d21oUjZkUW5nNU1Ec09PZnRGSGJ4?=
 =?utf-8?B?NDE3NWZhb05YVmNjcjVld3lwT2s4L3ZTbGxCUDdZWjZUcmtZVlU5WXhmOUlG?=
 =?utf-8?B?cHdqVlZqMm1BcTlHYmoxUG45ZGp1bm9zVVJwViswUHU3dzJ4NEVuSEhxQTVk?=
 =?utf-8?B?Z3NVaGQ2MGptZERjR3ZGMzlGdlhrSG5BS3lscEo2M3BBVmE3dGR1SStUcm9J?=
 =?utf-8?B?N2pSNmIxbG83RGFtUGFNK0NrRFlQYmpkTjhLUFNEdm4rVjJvMU1rYUZkVy94?=
 =?utf-8?B?WS95ZGRNVDMrKzhPNC9CcVlVaHYzblFndVo3WXJjU1BvemVZZDdJMjVmTzdu?=
 =?utf-8?B?TDVTaCtoekpFV2pHWGFDQVVaREY1ZGlDUWo4NkxkVjBJREpya1VwMUM2U3RE?=
 =?utf-8?Q?IsAYNJ1LlyoD0z1l54ofQ//6Y+iU/1UcgLlbv5PJ5s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77EF7D0E3D84FB4296FD19EB94490ED2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gawo8o1rtmq+5j9ABqr+ebwwlIJvxpPO+iuzUvuYklib00O8FIfUIHKm4ecihzj+YrAznkq3YZa2sm5z0FJpFShXfgL8L77X55+s5mEQUscZMPK4l+YwMYcrUKs7lY3IC22I7EqEZpyeQIfK1xWRCKbM++QjQAU0IFWyLNAedPXjznK2iyZfmp2m5yT14LF5TuVvt0oGrdReACCv+nyGyk9qduaVJhmPJkeOfsb3WvLyvQGQAehBYXEfWa/vx43Oe2my8OH6W71J2IRUQty6bhydCsSxX5aLekkFdjDA2x+I8okwuFDEdrkEdhLw9ulgpSAzlWeV208Lexy2yEg4P/72TPXPXL5EK/El+rignF6KLOLAOYPVsijBYUnPq+NDHyahsGZC/KnfGkJun2+yjRi33gfa576zXQb8KpNlUZh/JcnRG6zwPC26YqataC+k6qaIpL5+YgtH8vexnRroNTDYY1MA2YrU2brT/zEqlUliLIIg2Qkfy8IaeRV2cOGg7rvVmXqKwJcdu700a32TWGn60Dj+MgqO6si/cfPzzkeu8cztY+L7uB7m3Ooxf/thY3IDsw+/7fMq+z+iW8bogvJCLAvwtodKZVrJtdlAj7O5ys/jEBdu5j5FYQ2sRdpmlSWlv+BMhvmg3v/MGXNbh18OM86RpsOhCwuTAupZfHUW6cb0uCm3nEZ9LKsFKmvewpNhUmp8A3biTleREsx8oM6Ycd/mNNjIcuazyuvVzbZqCzLZE00nQQ0suaxRhcEDZzAvMmPb8LbwCgLTCudNYEpx8KjRGKFe3FbXkbgaqYc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c107a8f0-4618-4294-d315-08daf54e4fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 10:09:52.1479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNccsgjEZW++jZKeVYHJvbioHoDJdMz0tRsFL3LWvqrrDwf9pOizr1C1Brce33MBEtoioPHOR9lB/tY3SJrBbKwXsRAC6hqx9cupPMofboU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5727
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
