Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE7C731B2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbjFOOWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbjFOOWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:22:13 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A5C1FE5;
        Thu, 15 Jun 2023 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686838932; x=1718374932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=RXgNXqLAGDize4/qTk0R2eCwoIjIHuwqoSF4bp14YRrRIaS7Qvcr4mFw
   4KNCBR3Y7uRXBt4LGCI6lzODgQjdYJRRdXcCQm2jll+S4mnVQsxBo3NXX
   wBEQ52ediHEcgQH5Ut8VLJqN7/e8ZpL1A9rhEj3eW90TMS5MbCd00umFg
   IMq7J1MyZGAibq0tcdKvmIORy/0akXq/b6zVnmW+GvRFripomhleYN0jZ
   V6TahE5ji1pFaaXZC9VKBGvRX1PQyHtoTIvpi8Ms3hh/KMVO9uCv9D73w
   sZVbkai+mGSNIpN9ufQ9CpLl6+hqzLp9vQWKV8hON4zxPp6WE9kxXGZL5
   w==;
X-IronPort-AV: E=Sophos;i="6.00,245,1681142400"; 
   d="scan'208";a="347429101"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 22:22:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVQXVq460LuJZRD9tUdDVv56YFaCgHqUnMryEIuAVUZUZ3doUcDhK/uLc2pdEQP8wLX2EoTobhJ1CASI1yRYTj3XDzdSAZBppzAXPO3hTcvY8RPxYhnyxkTAt4GO4kewbARK3oy7pZ+NOrW6nNI5FP3pLrvw3KUNAeU1ODCMYo/ylNmuft0UM/f73gcs/Dq7SQ9gaEjZou2g1REWgt7zEJevOWdpNlfFbXgZuSkn1uDaQYbZ1AvRo1hfFD4X0ROd1y+1rbmd4JErKq3HVi83iOIzBvshGS6PQMzsIFjC9A2EnjvXC4lZPxDa+k6Y4tR+Ez6c8aO6uRMK1jLjBpO3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=KaDgznuMdq0Nw+UkqJBG33P6C0SgGSQa8SxCN3PGoXN4jZ5tyrpeoHy7BeGEfdr72B3ZcIustxUjqWsDOqQaM37qwiOlHoMHv/HUQ87nGZESPHvFO4dA4dm/jiu672psyByaRHlIshANgLI76QUAhYzU7c/FvFrmziu6U595vhmBpUg0tAYY40S/NojQ96iiHtjIIffUvfUhWBt+3shd9iJwiW8tcRiO0cbB6Gubis6nz/9b8tnbjryHldfgiWdTuqBQMCrtBzPrj9yHnUOeKzqLfKOzlGovd9HT45jj9OAdxmA+jfeKGImbYc0hoa0//Ok+b0d7tGNWo2/MDeNZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Kr9Lroz6XP55vnByN2/2xjutoV5gnN31n5WqacIIpnv6lcNB1yLJpJGidCSsuH16aRF02fIr7DtQK5ohvBOHOeIK1UT+btAzFg/9QkwR+U91FQudCeLKQ6IffoTN/i3GTa2RXdCMCr/wcviCrZpg57HuwRwSSiwoSf8ixA/5mVk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7615.namprd04.prod.outlook.com (2603:10b6:a03:32b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 14:22:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 14:22:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
CC:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/11] md-bitmap: set BITMAP_WRITE_ERROR in write_sb_page
Thread-Topic: [PATCH 01/11] md-bitmap: set BITMAP_WRITE_ERROR in write_sb_page
Thread-Index: AQHZn1XAJgUYxJwdAk6WLPAdWgOAXq+L6twA
Date:   Thu, 15 Jun 2023 14:22:09 +0000
Message-ID: <501ceafc-1cf1-ae44-1ce7-830eced8f50f@wdc.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-2-hch@lst.de>
In-Reply-To: <20230615064840.629492-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7615:EE_
x-ms-office365-filtering-correlation-id: 6c84b54c-8bba-49b2-8530-08db6dabe77e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jqz5iguh9hGVmekUkyXkkJFxEOAh3xCXReKSp21AdVcPjYvhQWviysJ932Zbfh/0xZSxx2Lqa2i3pFKTauCdmVZ9YOvqibp+oNgRjSywv1o5Ups/INVX1MzOGiVk2+suDLRU5QwerOmArfpZ0aF5pNS0BbKWBJBARvKmeJ30IcRmBWwOZYg624af7J8q3m6xPrGTHYxdM8cc45KIL1edGjpE6n0QKoPjq9jUXEwzsqIe3eX0FE7AWZl1n/qQ8gYhkoh5U49DMltW/x9YqvoO8qkBePAjX/BH9Abpmodpi64Elc+uQ4qj5V3PyMhyCNSTsjylGA/7Y+JwhRHGXdhvbPn/LVIvpa9XBq30ezEl1eL+4vhEDwg82Eh6R0A6I7aXMT4cAZN5un1ILhcPoYnPADBezn7iSBRih052vIIDX9bFuc0vk8pi63lM8WNvqbVwka1Er41pk+2wNHv1RqGvh3zw5voJiu8mFuvkb2Lhxya+g7UWOYqKmhBR+nR42Cq4BjAJK7HLKETwNFTtSkk+vbdjymxoMl6fxFRYV11WDGITPbs/0DYcZNzo07m+aJK/+jOxV5STCQBGI1GwLf4PpFa+oglsDVwnmxPwXCutnhitRDreDt4IJzX3WXMurP6y0HFwQujONZnLlPZNjXuSLgmyWFUPn+dMQFlpt0gjK/hxExa8bBRY2aTG5fLt6Mn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(2906002)(19618925003)(2616005)(36756003)(558084003)(86362001)(38070700005)(31696002)(38100700002)(122000001)(82960400001)(54906003)(8936002)(8676002)(6486002)(316002)(41300700001)(5660300002)(478600001)(31686004)(110136005)(66946007)(66556008)(76116006)(66476007)(91956017)(64756008)(66446008)(71200400001)(4326008)(26005)(6512007)(6506007)(4270600006)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUszVUtadGhRU0ZKUE52Zzl6cDFBU0szOWlMUlMvVVF2d2dIeUwvUWRNQzMx?=
 =?utf-8?B?RlJUWWMxK0MrTUJuM1NVY3dTRVJSN2FVbVBVVG1ZWHhVTUlmZ0ZWMWJYRkpI?=
 =?utf-8?B?RHlFQXZyUVptdWRSM3ZGalNhL1NQcG5WM05wbEdtSGtDTlhjQmhaRFRXNnJ5?=
 =?utf-8?B?MmZlcXFhdTlRdTZMdGJNeWgwdzlmeWdFWHpCdEFpbXY3TkM1TEhWa1Q3SHN1?=
 =?utf-8?B?WWhGY2IxOWYwTk9WY3VYVnd2enN0KzczWHEvakZLUXRLNXFzUTZiR0pDbXg4?=
 =?utf-8?B?VXdic2FQc1o3c0l0NHVXVGpSZzVkUE56ZzkwSEF6MFhKUzdFQktjUTRBWlgy?=
 =?utf-8?B?bndITy9vU3B0WmV5aHBISXRpRi9zbEoxMExrYTJYQmxiOURNZlIybUJCaVlF?=
 =?utf-8?B?NHdSaWhGcHFIT2p2SENtV3dlVUgyWnJyUks2QmswUEtyM3NiTTkzcVlVek0r?=
 =?utf-8?B?eUlxU2VRdE5wT0xnYXFFNEZpU0g4WjQ5QVhhWVVEQ01jOVhWK3dtZ2Zhbkhj?=
 =?utf-8?B?MVBQbksxcHJyd1djNW9pMzhHQ1lvbXRJckpMTU5WSVNjOWZzVjg4dVJ2S3k0?=
 =?utf-8?B?dzREWmRsVXZ6V3ZzT3ZVL050bzZJYURDenVlU3ZTWGNwcXI1YWVHOUJEaUlC?=
 =?utf-8?B?MzZHL3RPcGJIOUVHYllRQjR3UmZ0eUVreWdUNjR5ZldyTGlyRERUcDY2cEpt?=
 =?utf-8?B?Nm9lM1FqRXhuRXhRM084VHUyMXB2d2FaUStXVE5LRjBjS3lyUGl6eUM4U3R0?=
 =?utf-8?B?M2NhNTF6Y2FNNnBRM0RwMGp6cDBnSUFzUjBsUEpHZmx0OTFRejRTVVhZSTE1?=
 =?utf-8?B?cWNOdHpOYVJ1NXg3S2l5ODFIVnBINHZlRDEzT1laWk40U2ZHbldRTlJLQmUv?=
 =?utf-8?B?MG1CTURWd2pxNFVBR05CY0w2b01JNVVaSVppTzNmMUdhVmRUT0Zaby9STUpQ?=
 =?utf-8?B?c1d5Q1AxUWtUYllQVFRlMDdrWThuTUVCa1FSWXo5NGhlTWM1M3NFaW1GN2R3?=
 =?utf-8?B?M1VnM2NhOGdyZFMwSE55R1NqSUI0V04wOTQ4TzRXVjh2OElyNWQ5S09VSUlT?=
 =?utf-8?B?QVRUM2gycGVyQnNPWDRTTmQ5SHFWelNsL29tQWVlczlzRXFia3Ayd3Vza29Y?=
 =?utf-8?B?THJrSUhYcnZoWWlPRWs2amZLM0o5am56VkZHNlVOTkhBWDlDWWNBMnU1RW9J?=
 =?utf-8?B?b1A2cnF0eWpjbWsxMy9RZzZwcGdTMVJheitxK28wS0p6RmhPU0psbTNkc3hF?=
 =?utf-8?B?cUR6RGZWQ3E4N0RDNXkyT0RWSTJSbmw4WTNBcmpyMGJZdE5VOHRsUG5NYTBl?=
 =?utf-8?B?UzZRMlVNd29mZ0dRMGlSV0NzMlBuOENoZkdWYkFyWW0rU0dWUlF6anVzWHh1?=
 =?utf-8?B?S2loQ1VJZUxNc3VQK0NOVllrcU1sUVNhVW00U3UxYm54cENUY2tjeDFMcHJm?=
 =?utf-8?B?YmJ1ZlQzTUFUTWpBa1lFSlFjUVIvaFV5YjhOM0N0OC9JOFF3R25QT1N3c2RH?=
 =?utf-8?B?b2hyUkJRYlJNcTVqMkczVDNCaERpUnRadWk1OE5GQmFmSEIrZTdqWm42VHdL?=
 =?utf-8?B?K1ArZVBLeC9rNXdEbWpWRCs3cFBXdmRFck0yV1Q2dEw2MjBWcHZaTlBMdko3?=
 =?utf-8?B?MGdBaFVMMktzWEV4eDZGbVVJZklwem5yaHl0Z2V4cll4MFlkVzVmSUVjVnNQ?=
 =?utf-8?B?aEFTMDFmR21rcnU2VFNuWnRLRkl6bVZSeEtCeUZ0Ry9meXJuR0d5NFZ1dUpI?=
 =?utf-8?B?REJPL1BPVUl4YTA5SEVyRXIvbzJFbW5vZzNZR3pvcmpqWVB6bWc1NDZUdVVT?=
 =?utf-8?B?ckJ1R0JWcFpGaGZQUFpEU2crckhKTnNLQ3dCQWs1UEQ2T0RLaUZpVmpMTFFw?=
 =?utf-8?B?Ti81RmlFZS90ck1FMjRaTHFldS9kTVJtWDhDMnUxL2hMRFFhWjlHU0V4WFNt?=
 =?utf-8?B?aTRyQXpHWXVmTTFrbWRkQ1Y5cjg1R2RFOFplc1Zqdng3Q2FjU2NXQjYwdGUv?=
 =?utf-8?B?NTBWRHBKL3J2SUp6ME1xcUdFWGp0L1ZIRzJkdkFkRXFkcTFXQmw1bDB2MGc0?=
 =?utf-8?B?SDZ0dDM5QlhBY2t2cDlIeHJWdnB0WWV5aFdpdWFQWFd0Nm9rbWNJNW5SVGQv?=
 =?utf-8?B?enFVZUcvdUpOZkhKTTZ1WFBQSDJLWlhJQWM4aktaZHQ1MC8rZjZYc3hQSXJQ?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BB1EB9781F39446B8C4403A0BD12C17@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J+XBXn4k6+uGn2/grdLVV4AqtgYCsnjaiv1+A929CjHpKSEg05ByNPc9m9x8j8KpCKbHwgCoX9IA0EWu4lpAEMSXZQ5Lkw6IwzU8zKIbscltP4pMTQf2JWtE262rKtcDyaTQ/Nyx9ZV3ENazWIAbhq4Apy/zCilGWu8cTyij3qS92fT5PGn7eELwRC5/bXADQyxRw5nECPhsUwDeBrjJn+N9YuUv9sgOPjE6ecFcxGBBp8dLtrtH3AU75/7hPmSi+r9iXWAcV1G1tm6SzU8smn30ReP4tFLx0sQ3pCGNaWckdmzsKTgObXQDWsR8FE3yS/ssQq0mU5H5grVbvN/tiMiDX4tNbs9a4bOQ/T3AkAZE0GBPsrPZfuJkbTHQGOOzCnvH/D3we3oNS+tHqdsCe7NYcrr+Gbyvc89ULoHKcbNvtk1O6VyzsCzGW/MGwQGGVWgAewTv2FWdoI3+WCJrDhQTRBZLYPZfPC6SfwYcL8BuYk78IpBUxDn07cGl+KRBN7ZGtYmI4QzDSPhDRXAd2/zFH6b602JXQW9oWDeumcdEAhmf3Y2RfBZvCIzIfP4ZXXxTip7Omi03v8t0hqC/7K38tHFdU2KCry4TXkdLfpOcvblulr9tbyjCXvEuqaCziwoqZm0bvBWLjtREPwWGjvinGVh5d3ltLsaTFjN5lSFbEltcoJROkPkXxqdOXdPIfGRjeOyv4f7+lpWRW0NQsPUOBUNBpyeMxj0n3/AcEVKJOTLAhZOQ2x9d8GMP1QcjJToLswtf7pJXnGt6Ik7F6HACcDfHBzcbj6Hvjs589mECVUtU7oMu65xv07SBc0W+Z9SKS8ttpxXlF72Qkn99CA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c84b54c-8bba-49b2-8530-08db6dabe77e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 14:22:09.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oG04DG6MhkT/1+DtCi9yoY+dMfhJWDAr8cBPOv2z0uoynEZwJVU5n8d5jlzu+slfnqo0IJy6HcznGNb0gnxYn7Gs1z3FesI9ZuKzcy9uT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7615
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
