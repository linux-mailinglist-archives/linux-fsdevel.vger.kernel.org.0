Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314E8731B9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbjFOOnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241121AbjFOOnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:43:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC488273D;
        Thu, 15 Jun 2023 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686840180; x=1718376180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=QsUSrwRN/zj7tkDZwlIvW+S/pBcMVVubRLAtBhhCCSqHmZWjaSRp1Gy+
   2WhpenQdtmaKOrcIrepIyUolvp+cV5GBPIMSMoSLP7PYpdrdLsjXKNx0u
   DnVEMQZrBed5UnPjibSSl72OLEs3ivNliCekIF3qycaMozY6Kc7lmnSWx
   OFvMkTYWzmkTkDE3eh92XyEOTjrdlqgUY8Hi6szJRsUGBLaJHSgTqrpdp
   wH0a8OV85C87PHgMQCfeqDOFD3kBwRetKzB7h1JJ/w3iUUx7s3ckE/5Gq
   N8j1OTpm2U4IjoIYYkTVQAhTZf+1Og/mbxcTACQhKHjrv4i24vJPslFKS
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,245,1681142400"; 
   d="scan'208";a="233969230"
Received: from mail-dm6nam04lp2042.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 22:42:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1tsa1oD2XZmLMeThsTYBXGEZBAlpYvYZ/lkuFxXkbzqe/5mh9rgWNHlJd6lpTUIOpCBKVY0FbHElFArduhrogkzkItbmslGFlFTbofcPGw8jSG7jBUWAsVxVKIBCZpLH41qJlEfcTf6zYnlZvpbvRV7sjHCAUsgSOS38walIc1FF9vxyY6bjrpRrCqBSvE/840LDsSZ0UkNh/XSiSAwR+fmTRRY3imxaLJQ//PjMmBYKk9JdGxcixyhmOog8X6PiI7/xKVBrbx4s32OGi56DSeY5nyXDSB0LriTqMAfLGcDCH9Z+vVBOjGTEFsDOmJyakqTj80GcSFdyGvhYhLGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZGSsR5tnJvpWnKATYYjenosY1HWuyv+lzrGIrVXOSN2598i6V4T4e7Szi8o/4njNN5ceLwzBlAJ+/h4fICE3FFDir2RPd3vN41d1Bq7hwke4ahmc1PBXOwZj9fQvX0V2Kdd03eWE1JR0AVfuvh62V044okVC7zg3EWmh+4rKKl7UbaBee99mP04ATEKoxZOx97BKx5D0ZHFZ6q0zy9nYEtpqHWrfq7BmRZR02rEQoOE1DNwoUmYNnGDeYuFF17RDvj3kYlcdxxZoPrVlDVUqKRJb09wJacTEFKtWeMrWlb+8ua0DJ2P0Ee0fBER5nrVqY4CTzVaQgqrbO9Ffb0KGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=huMa8RK6h6dSOYejO9c/732RVQYd4OSR7/1J3vU+O1REYpIDJwMJV3kTD/sxfw2KwS+mteSEt7gDVznzRZzwNdr5fo+lCAJcceSWUy2VfIrufofg4XY5yWT6SW0/4KQOOSNBsWVoDwqzjtdGLgUsqCzXW6IqpPgmvZRxFfES7v4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH3PR04MB8926.namprd04.prod.outlook.com (2603:10b6:610:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 14:42:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 14:42:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 07/11] md-bitmap: cleanup read_sb_page
Thread-Topic: [PATCH 07/11] md-bitmap: cleanup read_sb_page
Thread-Index: AQHZn1W9S54frDGjSUmv8VEH9HTbFa+L8K2A
Date:   Thu, 15 Jun 2023 14:42:57 +0000
Message-ID: <d1697342-63c7-8011-ef93-4205640ade7d@wdc.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-8-hch@lst.de>
In-Reply-To: <20230615064840.629492-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH3PR04MB8926:EE_
x-ms-office365-filtering-correlation-id: e1002ee5-58a5-48c2-22b1-08db6daecf67
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9fqy79pwYeEKkkKKIjdX7IPsLnU8B5bkcLyeU3hDlGzb7e4hWLtF1towFzv2g7Uv+IFnd9c1fZ6JXrknr2I76BzLC1HVFgQ1TyL+HkMmdkrubRhAn4RSPinTmwUbxXczE6FlyUGCibF7kcexeCOjiffgDDELEafgGRQXqa+6Y9O61Z4k7gtE6g5BM3FZn8krGtmb+ccqOK+BpIT9vH+Jo/vK+dgOj3DKE+jd5QIen8p+jtBmwpAw5nskOFb7lWqUBSPtyOlQaXirr6z7ENPaZA8kpwNyVfbIKEjoBrCmRYyBBDpqD/5JWjB6dFNOa/uTrZWEvFVD2javaYP3L3O9jEF6U46OsBiqIMmANK8VOGREkgkI2LBsYD5vGUw/+n2y9AZ4KRnylk0K4T8gIN6bRkFe7Hv7EWHDwob8QU7RX2NCa0Fagf7jtfgazV/s50t5MtBe2x6IDpAD5elVAnIxHGsF3/5NUZgeryb5oHjoqX1gNKQnRV8YRsGnzhigVAqY03+nF8irsy02fD5NrZ2mpZI3X0iuEi1QexYxEzQeN62zL8w8ygyuHPyNI0BMc1Iiu81IIbXlKH3tgjF2Rs1LHMCdAd8P5U3j7VdyL6+JGTW7DBOkeekZG4hevXauS3uy7dWy5dpTuOomJGa4ettAiCtM6OwKiziZWZNuWHrfj+SH6O+rSdf/uCGmzLkvZQPM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(31696002)(2616005)(82960400001)(36756003)(558084003)(122000001)(86362001)(38070700005)(38100700002)(478600001)(71200400001)(54906003)(110136005)(8936002)(6486002)(2906002)(8676002)(4326008)(5660300002)(76116006)(66476007)(91956017)(66946007)(66556008)(66446008)(64756008)(31686004)(316002)(186003)(19618925003)(41300700001)(6512007)(26005)(6506007)(4270600006)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkZQZlpzR1habjdYMDV0TUxYem5hc1lhK2orRnZYZHpPWDBkYmVGNGZtUDYr?=
 =?utf-8?B?YzdMYjViZ1hXMnY1MDFRUTBlRHJCWVpXMnN4M0ZUV0tVRFlMQ1hwSFRkME9z?=
 =?utf-8?B?UmlFZHRwSU5QV0s4WFhQd2VEUE5XVjZwMkhSUG81OG1vODBNZkVQOTM0eGVi?=
 =?utf-8?B?S3F2ZmFLeVBIK1RrMWRJaDFjcHY0QkJseXNtUjVoWGlnN0NoUFd5SERzVzJ4?=
 =?utf-8?B?QW52a254KytUWHlxa3YrRUhBMXF5ZXJOOG4yaTV0em5oN2JXT2g2ZUdtbHda?=
 =?utf-8?B?Q3h5RVdDdXlKRXBMYmJmVlNTWS9rck42Rm9URUNicjNRTVdjclFBNU9YQ2o5?=
 =?utf-8?B?cFYzalNVS2RhdnlZejFUWDlCZjdmNUFqWVpmK1AyQ1NldDdhOHN0bmFta0VY?=
 =?utf-8?B?VERGRi9zTmVmd3JGc1hsdEs0cHdVUUFYMjFXZmdUSWYyRjRUSzIzdTZOZStZ?=
 =?utf-8?B?VnFWYUIxUGhtaW13NUpYdWhtM05sTXpkMXJMWEljUUs2L2R3RFEvV2xUdlN2?=
 =?utf-8?B?WkMxeFQwR0piYnNhZXgxdnh3ZUFuamlldWdhSnc0Y3Z3OXhLTklVeTJyL01U?=
 =?utf-8?B?cHB1OUZOQ3lvMVp6K09tczIvTzBFTy9RT0NiQWhJeHR1N0xFUDZTb01hdHpV?=
 =?utf-8?B?K0ZyOEN1NGxaa0xRWnBuWTRxNHU4NU8vYkRFME5FdHF3dE91YVJqbjNjVHFs?=
 =?utf-8?B?QlQyWSsxcitScWxJOTYzUDlVcGs0V3Qvbi9XR21jdHFvVHZZaWxPYzNnUXow?=
 =?utf-8?B?SlZHZ01XZjVpOHRtKzdYS0w3eEtxMnpRM1JwNkxVQ3JyeEdBQTd5dWNFY2tL?=
 =?utf-8?B?cUtnc01lZmdQUmpLQlY2cUdZZUh2R1ptZmhWUFIyZzM4NmhFWC8rdDEvb3lp?=
 =?utf-8?B?UXhwNHJVbzZwTUpNbEVDQ05rVkltQ2dlbndOK1F0OVdSeSsxdWRjZTJpK3BX?=
 =?utf-8?B?bk1OZ0JsUUhFSFpoTUdGZ0dlVVB2V0NLcU1RVVlJLy81clBDcU8wM3k5QWl4?=
 =?utf-8?B?ak5wVWZPdlpNb3NIMlUxeFllOGU4bzV4SktzSzZiK3JsNmcxd0VqQ1RvZTBY?=
 =?utf-8?B?c1N6SmVPM2xrNGI1SURYdTNWMjhhbWRZekNJNWJOOEMvaW5LMlBHa3JCZHEz?=
 =?utf-8?B?VSs1NDdSMGZYbEFYVDgwVVJQS1BVY3o0eVpGbVhPY0dWNHEydnVlKzV3U0t3?=
 =?utf-8?B?UFE4U3NXcGRWN1E1eVZoOEFKYzFhSDBJZXFGbnpnZVFUcHZuZUxDcUkraURK?=
 =?utf-8?B?NDVvdFFsdHFjOFNYS3RYN2J0R1FMTmlWRjlWNXpjMjYxZllNK01EWG1URGp5?=
 =?utf-8?B?VUFaWUw2OXF6cFpibmo0M3BydVlJbjUzUDJ5bHJoQlZ1TEpLL3Z6dnJ6YUly?=
 =?utf-8?B?WEcxL3BjVXZoZmRuZmpJbHRlWFI1dVBJdEw2eDFqdk53NlpSTWNrQmE4TjFt?=
 =?utf-8?B?Ym1yYUtyYkdSNEo4K2Y5M2NCWjhiOEl1S1FKbVV5WFgxaWkvUGIzaDJIVzNw?=
 =?utf-8?B?c2tKZGxna0Z2QThXd0xBa0g5ZTBXdFBsTWJSeUYxaW95Mk9PVElFR2hBZ3Fk?=
 =?utf-8?B?Y000ZzJuaFViNTd6cU4vemVTL1VUbXJNVzdGNE1aQ2xDdmxYZ2g2QTRPRFJq?=
 =?utf-8?B?dlNtd3lsbXppU3ZNYnJXZ0ppZTNSYU8xRitDS3A2MzkzQVpDekxxVkVFTUQy?=
 =?utf-8?B?TmdlRzcwN1JnVmhGd1JyOVYrcnc0QUNNTEoydk83ZXlsV2cvNlo2K0lTT1hK?=
 =?utf-8?B?QzV0T0k3OEVSSTBZaWpaaytCUDFKK05VRnF0UFZzUGhMQnlYZFV5d3NvdE9r?=
 =?utf-8?B?RDc2L2o2cmdJYnp3Z2J0d2dXc3VqSGFtWDV2Nys0b3dkN2RqQnQxdmw2dDhM?=
 =?utf-8?B?Z3hxOWlwNHczSmR0Vm54ZnFyTTFkdWZRU05uU0V2a2lRL01odXROdDlZTFZI?=
 =?utf-8?B?WW9nTmJKKzlQb3VKZ2VmeHlRT085cnNjeUlOVENrREg3VC9NV1hqcGtSNjFV?=
 =?utf-8?B?OE5hZlg3cjFzbDRUd1ZHc1JlcC9ZckE4d3VjVFRVZXNFMTJHOFAreXVKc0lN?=
 =?utf-8?B?azN0T2VqeVUzN044QTRManVZSmo3N3I0eWJUdXNxSnpqMGxkQ1FDSklzMmhq?=
 =?utf-8?B?MUozb0xhWEVQR0g2WFkrYi9GaXg4SWZqaDZJaDZ6UkQ1cFpRU1FTZUxQY3Ns?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4873E8DF004FEE4DB539EE253CE213C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JDse3TvtkmFrf3oXq5bTbg3HjgIzEICgHuupsxkPj5QWaK6HPj3F0Ze2qLvNqdmrnTaHU1hHp1OQf/jBkhsTvZX5FkOSGFKD63FTZLT5AIPy/kOJ/d9xlNFyrsMe8812E3KOlWTUK/7NTIr2/n05hbdJmDd4UBXbdFXtF9rEFhMh9Xrr5nI2ymwJcGE6U9eDMgscNNhsQ04LEBkMJzhIiLF+GgQq+fRmyr6JfxAmPWOjmffGoMpq1HaAKZxM2tVEvvxIPFqS8OCGeRtyOOnBzqYgGgRJ8IQE7Y1f7WGLGLtylvbpWQnHMIh47VQ+zb5yzvUaPh/1O39rxZ0sYcd2bLzWarRHR6118e/qqjvkTUZmQ6C40yDTJUypy22SAugGpcT6XjFbUlpILXq2iXc/xHHNGL7DR8Unwnh/YRATr3XMc/zCJztueZ+FbpRqYa1z1CqHXl1FJ7DlFQp1Hbqo4f0nRe4mx3kaUtmppNX/cUbwsP45VvitJUteY1jLmZst2x0ttEaF98Fyg2QkOx4aTHQVoByZ26eD6og1+mi/28aSBSQ3dtU06/UyanAUmtoyv/f8B3lwrrrRJJ1N8jXlAF/ktxKCT+n2xj8chQcAWRMK4ePaZ8u1+d6J6AyB3U5amFqmxbc8ndwF17uiXGPhUg+iBYGNGVpYSTCKhM1zbnq78/wjGPgOcalVy3dnKCpRqYeOKsQCSS2Bb4nKkDknCRvEW1GGOq2jOvfV0bRXsKbq6yAOr5pr6bJ62QF2Lz+opcl6PSxm6f2aIYTk4BmXEV16zf5Jc1c6SNW5mssptTL2vWk6lPnpMAgWeLi1Nsy09ebWFtAAJrsQXzrkXxoK1A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1002ee5-58a5-48c2-22b1-08db6daecf67
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 14:42:57.4411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ea1dwNglRk5JrYBFXykqskGM6cFFK060XP0QoA5pobgclF+8F6u0cbKpayDTsfmkMxihJN6zWHBdOq/3onv8dSleKiwFbPQrkzxy/Pid5zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8926
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
