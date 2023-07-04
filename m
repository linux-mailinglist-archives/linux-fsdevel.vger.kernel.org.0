Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054D5746CE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGDJJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 05:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGDJJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:09:19 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E590B6;
        Tue,  4 Jul 2023 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688461759; x=1719997759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=LNZIbwFMa6f6uM8GWPxMLMAHRla8Oe42OLFODlw83otR6Sz1Zi38mc71
   JDvaIrWZzvNAA5tLwbLFIKWHA4aNlAMGSLTxuFv+rJrrBlslRVtnbTppq
   cUILb+hc5mW5PsdO6AfM+rg7JcV+jdhQBcUsXcW1IzvK+OVdBfSO/Q5WU
   Pp9lQ2ucfX+4XelIDbf90NlB5O6wIMbT+e4JHqhOdQN27b6e/0mjgLZ59
   YTey6LqMLyoi6kJ8J0VQe2fzQBf9KS2JNTJOVc1bg3+wBDEpOsM/9dfHY
   rtaBAdbS0E0ULLmLikBY3kCU4WgQenewfOQhwU/Ovim690iOnYZkf9jkJ
   g==;
X-IronPort-AV: E=Sophos;i="6.01,180,1684771200"; 
   d="scan'208";a="237490952"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2023 17:09:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfzm+wtrrxB9YJDYKx5wWZGLmKLdk8eCJsQD0+dFf3kfPUPlAG8EUnMy3ImRNfrgt5GhVwRg3gMaqjOA9DBgULlczDi1ud0t3bxUyTeAWB4nz2qO0PBYcvOmQHhk/vItoWEX485gtY2BqSjGf2zpvwdwOYTNb2nRDgVsYdhGnSkT3PRBT2qZaD3+Ac+lqFa51FNpp4FH+HSmoBhQGOfenIKluhLcz26lc0YZw2/a+ujzpi4xb8yT8j+YWe/9wpl9WwhCLQFuamXPtBgpNBWMTabxglL+2mk8sL/cXQsizF6JsHP84rOc8ms/tB5GDlTAQSDEWRl4njXxJDzRMygbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OhrPaAkGRKceHPVnZTL2PlRxhqUiqHyOCwkW21c4PgquX5d/sbAO2YKaxSWryqxalLaKHJ1MsTmPXupPyurt0jWWbepNzjs4SuEDjPxrQ1z8NCIuK6ONHLkpaxaXw45mqJ5ZxmDkWmu/4XNo1GSN/0pPKfFzPgAIvHNGAfKF6QRdYq4D0+IxERwmlA+datiYYa3i/9HaBABqjfnzIjAW/MNgY3zoq5uwfzHAgtAb/sWo6DrWonAdm7nu1JudLJTFMGGPO/J02vTk1lqODAYhysHYJFiwI8GZEMQHCAAwESZB5WIyq990QvLtoUhmx7nNGpFNvwj5u4Gbop0u8Yej7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=D6weqZi+frmUXTYzy4fm9YhoAU4ZxYNfIsFxcAx8SujWXZaDicGAEKLXlJRJJv+cbSjV9uPqEBN4gU4iw90Hllb4iAYnH1uVcm+7ubF+Xx9WeEibNQU5DFfZl2mxZLz53bR6tClwTQuhQMo0XSUh4XB3JZY95ejMzhcl6StLRzQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6619.namprd04.prod.outlook.com (2603:10b6:610:64::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:09:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:09:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 13/23] btrfs: merge async_cow_start and
 compress_file_range
Thread-Topic: [PATCH 13/23] btrfs: merge async_cow_start and
 compress_file_range
Thread-Index: AQHZqdYSDtSGyWf3V06JxrCr1DJgl6+pWryA
Date:   Tue, 4 Jul 2023 09:09:15 +0000
Message-ID: <fe9c8b5a-d270-aa97-0375-80493f3b30ab@wdc.com>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-14-hch@lst.de>
In-Reply-To: <20230628153144.22834-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6619:EE_
x-ms-office365-filtering-correlation-id: da208c9b-13b4-4d41-4856-08db7c6e578a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 316XUZDKFgwxE5wDtgBXUUncjethPTxZCVidL60jl2x4pzGDcZ48/rza94so0gRyDSryOow+X//MfbkX3M/2U71Jvgngx1yZ6jhhsL95tSAvxXzEz9ZtKR0Q4CKX8Chj2arLMcHlAfCYztuswBdbVRf6cLwtwVee0S3hgMXZPw+pfogGE5AaRQOKo+lCZRW+6makKy6LYVym8o/idrEJcvwTunDcSSKRSWKRzfVHQoC2KCFQYQ8eA8jtyGCqN+m+Lsm9sFd+tEniq8hgyQ6xHchEqpHxiKo4IGtXIkA8QOMABxzvsP0fbBnJQTeOkSiIIw1IRrPGf2lpz+dX3I94e6eBHVYK5Nc64C0IEnWqTSkCFZou/xXSBRRxVDYRJXcuzlv0o2epFO2hCH8+UDeZedY8DjWj950QvPV0n2fmBokYlyl6w3QeVrrqqrx/e0eKvysxUmFWwkYlh4BdbGzKOg5nKlRS32OT55vPHo6uwv2tICGfyhH7iUflF+4ip/mtBw+ewYPRn2zdgrqG6PJa3PzzNhZm+sY0qqfx7YzEeCDABeOWaYO8oil1MmxFBmZdCxrSvGNX4Z9TkxCpkxfVLajbN8fl2F/PqdUQdl3IaH1WUcTeKZ7bo4Ax1tjfUrNkUyyWSD9xZRxZAlUo8YFUIszMbkIwCGE1pvLddIlTdeG4PmDDRoE1EywUWBA15Rkn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(38070700005)(19618925003)(2906002)(41300700001)(5660300002)(8676002)(8936002)(558084003)(36756003)(86362001)(4270600006)(31696002)(186003)(2616005)(82960400001)(478600001)(31686004)(6512007)(6506007)(71200400001)(76116006)(6486002)(91956017)(122000001)(316002)(66446008)(4326008)(66476007)(64756008)(66946007)(66556008)(54906003)(38100700002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlgxUTlYS3hLZW9hUmovb1VRUzRuNE5TaGJxVTI2NGxHYnJNWWNWVHIwZEpQ?=
 =?utf-8?B?V2VSd2pqRWRCcGpmOTBSU3R6OTdCOE8vS0hkUmlycm9DeDNrbVJDclgzZ04y?=
 =?utf-8?B?WkFiWDhWRm5QeVNGNXM0U2x3UGFLSHJtNmxoazJBclk3QVFXRmtPQkp1aFlD?=
 =?utf-8?B?WGNzajBNcGlzMElmOEF4SklCNWtZK0tlb0NpTFczcnFsYlBoaXFVb0ZkSDQ5?=
 =?utf-8?B?V05KTXJUK2dMRURxYTBjbkFaS2Fsd3krTTdRQ05PL1dycXJCSGtpV3dhU2ww?=
 =?utf-8?B?a0ZrYVhvWnBDbk9zM05qaW02WVZwT0V2NUovenhCbHZKYkJ0a21SaDhncndB?=
 =?utf-8?B?OGRqSE8zV0RHMWhHZWJpYWFKY3d1VjNiVi9DMzVxbzFNSUZrcXgwMUlzNXh4?=
 =?utf-8?B?L2dWR0RTeDhFUmZlMW41RDdhL01OSmdJSnB4OUtGSXQ5TzhEdXFKMW10NTRn?=
 =?utf-8?B?MWNhWGRQdGhWWVlyS2J0aHdXR2I4Sk50c1RUbDBjV1VURnhJbjhXM2JmOC9V?=
 =?utf-8?B?b3VkcWJjaU4vTEJhV0pHVmJKVlVEWHhDeW9LcWlVRWhieEQ2QVZhUFo5Wm1C?=
 =?utf-8?B?VTFHbFFGVEkyUHhrY20rRFdIVy9WdDJ3b2xUNjhKbStWanNMaktNeFl4ZkEx?=
 =?utf-8?B?ekFhZWIxRCs3T09JcHhqdGVic3pYSmpINzgvNytpUlpYejI1RnVmVWtZQUJK?=
 =?utf-8?B?Um50NXV5c1ZwMTZPQll1YnVCOTk5UGw0dFIzUUthRUpoc0k5djFOOXZzZlFG?=
 =?utf-8?B?MmlvMndaakFuSVVSUkdiT0gxblF3bGt4L2prTDNPYmhEelp0ekFUN3ZFemx5?=
 =?utf-8?B?NGFmaDcyTm1YTlhxMHkrQmo1dmpBd08wVFhZUzVpUk9nSVduMExJd042dVRE?=
 =?utf-8?B?WEJHL2ltbkp4YWxpUVZXUGlQSUJGR3hlWDMwMGZPZmpNSVVIaEU5ZGdTMEhw?=
 =?utf-8?B?VmF2bVBtT0lDd0xwWHV3NCtiTnlaM1I3ODI4ekZKbzQwTFh4T0FGd2R4dVJD?=
 =?utf-8?B?MnNqam84VVhOdEZGNitoSFRnMDJuU0FYVVJVaWhDa3dEMXRoRGp1Z20rUVNy?=
 =?utf-8?B?anJvMFZTcy9yZlIyWTZPdi9Ia2hhZ2JQeEtvd3ZSN0JzdkxNMVNoZE9ZcWxh?=
 =?utf-8?B?dTJ5SHVUNzV2Ryt1eGU4ejY0NFI5VmlhN3VVcGRkVWlTaTkxcFpsejZUNXph?=
 =?utf-8?B?cWh3T3NFVTVzN3hwaGNvQzg3OExMeDFZaTIxeC9xVjRhZGhJWHY2ZzBkZ1hk?=
 =?utf-8?B?M00vZzBlQUovMmJldDdsOHlVblNjRmRjT0pZN3dvM1d3ZFIxNzArY2ErUkxI?=
 =?utf-8?B?d1V3S0ZSbTBLTmFRN3kzTkJBT2o5SzA2WThRVGN4d1U4RXFnbm4reFhPelYv?=
 =?utf-8?B?bm9jejMxeWxOZ1BOTFhBeDBtU2N3R3E0WlhlcDlucVF6OFQ5RnlyNjhPR2lx?=
 =?utf-8?B?cTRiMldiUXRtWGZqNEhPWGQxUUdWSUlLNGJqOUVzSDNLQVBJMUlxakFNNk5k?=
 =?utf-8?B?OVkvckVCYU1pRWg5Kzk4SEFJM1l0THB6VFBoeDhMTzlnb204VllJWFVqL2l5?=
 =?utf-8?B?a3RNWllPYmhGYUVKeDhYM1Y2TlJMS083K2tzKy83WWhlUFU1d2lvS0lhQmVt?=
 =?utf-8?B?WWN4cTlVeEx2dEtCQ3B2TS9RWHM4aWlRRE1PZHVzdEc5NDBSUnA5eHYySGlQ?=
 =?utf-8?B?UGNveDdWOEYrQ3g4ZGRmbFR2V1ZDcVBXRWQvekpBT2JqMnkycXdoeUNkNDE3?=
 =?utf-8?B?OFhkU2h3UXZSZEp5SFRxeWRGYzAyQ3VhRVVSbU9kOUk5OFFKZTZKZ3p1UVNt?=
 =?utf-8?B?cjhNK1h5djdVYUdwNlE2OVRUdExRZHFEWWJvUFpObUdkcGhSNWhPeldoQnRI?=
 =?utf-8?B?ZldkQm1kd0VWTEhsbGZmOFJLNFQvU012ekMzeW45NnZ0b2VxYnR5ams2blZY?=
 =?utf-8?B?Vlg2Ynh3aUw0cE5FRVNPWFVpQm5OYzNpMVpJQWt5aU9FUW50ZWRpNWs3cHg1?=
 =?utf-8?B?MEJRN1lPdWVSaldLRURsVk1vQlNoMHRYRG1ld01RSkYzRmpaVjZJRHFHcllQ?=
 =?utf-8?B?NE4xOWpuUDBVVlNlM2ZRQzl2RE1HWFdFcVYrK2Jpc2lZQlR4OHRLRWYyNmhP?=
 =?utf-8?B?U2oxa201S2U0aWhmZXdLZXkwenpKSzZqalpaV0lMZjMvN0VocmNIbXNJd3Yz?=
 =?utf-8?B?VlpVY0FKbWJhVXNBenJMcGVHejN5SGFzYXJNVm9JVkRqUEJXL0ZYVHNXend0?=
 =?utf-8?B?ZHAzN1RIOXBsSXJsSmNoSExOVVZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E401C7BB37534C43A237716D35200623@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g+MngQ4c1sw/S5LzP3jvG76dw/NeeRJgCro5osEQXu6p0mS+wOJG+cFIcKOtg6DhuZk3JuZ3KO/nmbeQV/Fqg7Z6//Qme5gwKAoKk8OK+xNMVr94lQdtF2TcXfs314Tag0pfNG7ym90vxw73Gn0SbFllOW9n5U6Ga1OFip57dmWvtgl0M/WSQ5N/Yv0At1/QwuSMgxPRO44vJA9bv4Yegdno+rZqITUMyjAd9rq+T5uYQS3e0telP4TUIUl1oiaFKAdSvdvc7mqvBS90WRIelHhveVPT6pVpn11h4+vQwag3IioCQwo8G2pbeAKcK5a+TttSDTjU5G7o+Fi/VhzeExHPvGAT+4N3yRqo8zb1Hz58dt6ADyAEL63PkvVKe1bxTYFopxkzWxYL7l3TOuAftLwZQhKX+/nWVBgBzEADYwJ6inqiD8oMgd9FfPkc2bj9UUqETCOF1W8VcYl438OXCMvZrRXmlo8JBywQqWAgsKp8JNM3SFOQo8mNG9X1FM4riIZuMT4lbZkxDWNtSIPciA7TLfYLeRnyowxrVgUuXSO1ByD/wrlGNF5Q1uOKnC23YQMRsBjtX6zlgfQ1U/aW5bfHCakqGxaIfeN7s2KgYLEaWq0ESzAlPS7G+1ZCM2sd3LOUzWBCch1U6QEQavO4iborVWHQH1+T5p5KdTvH3gHapGNx1NsWnbfr4JlZUrWXsEm9VQ/lW+iJUZKF7U9kk2I7+Kt/yUhh+I0JRTZcea3ly6vWuvq6OOpsvdbUjjyZ2AKZozesgXL+EYuJa8O6RHQAnO6ZhR1rM/ntSES6X/ougnLPzr5O/h7jGlC0IGWU3OXoDZr0vze2nMPCzYp53AHbiYLLl8tBp1m9M3kT3b/CwVrteU+bY+wUBPNqrusvPMoD0dFLhcd3v8rEpi++dgQENfm0PkQT9vVqBp+YCUs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da208c9b-13b4-4d41-4856-08db7c6e578a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 09:09:15.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IQ8NOKxEaRIexO5MDU1uI4XK/u0MIkEnXiHVbdWCUdBpPY07+qk58i7U2+uUanxB7zsR9U6LxO6eTd/VC60JVQQcgfusx2tFqQe5qiL+mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6619
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
