Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DCF609EDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 12:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJXKVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 06:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJXKVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:21:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C2757267;
        Mon, 24 Oct 2022 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666606897; x=1698142897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=glqnSt6ulhxgiRUfzu1Xq30QIF+kWkmhXTRC9ur/OPM=;
  b=MoQJh8dudHVoHA3DTDPbx7YqqCCU9IZNQfSYwjeeA0J/tx5aCipb6e6m
   3kW0NgoCiap5X88RNf4qPVorFMqtYhvf+hhmaufkNvIKejXLivDcXGNBY
   P4B4Rzefa3B6QQEdtni1LFmMLFzgj1i84ZTVvfHqGQ/oT832dKxekKH6X
   NFZgFrgCOjcYdA5qAkaCUHgppfo3bJDTmjaQ/vHsHOhTPQdzxwp7z8A8d
   icpgwq2V2bVp9etakWSX0q/2ApOc5sn2Iyd3WJ2B132RKLNxgLbYNAQFH
   agb3zXBqpVrD2N4UsmYeSHnMguOi5ABg+MKfjZNYzNcGjTVpZOgTCy7gk
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,209,1661788800"; 
   d="scan'208";a="212892915"
Received: from mail-dm6nam04lp2042.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 18:21:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfP2FdbT4yzQcKto0EQ63nr/jty3jbk8CwZ6DU0kfrXGlhobpvYhn1g/zkI0n8mYBnT5hsY1sFbkeNkS9+71jpa8lyu4GVUnGoLnR/y/FB6xXtPDgkj8UYZ1OoVEXJ6gGNR7Lrp9Q9O3Jsj5B/kMxwNuga/QDGGzTqmC9HLLqQ25T7p1Eyi9NRI3E+RjCHhjhnAQ0TZrcozH/+wmtilPI2gq4nvn052hqmdVjPMQ+6yHJX8nnNU6WdlQNV0lnvwOe+wlkoYyiJDcK9n+KIa2PdsCx8XwlEYWfPg2S7HPjsixirnxSsVKbHrMNyujClvCJv8RuvOXQfxKJhmm6kRYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glqnSt6ulhxgiRUfzu1Xq30QIF+kWkmhXTRC9ur/OPM=;
 b=AMWuVz4tfAfvWqd5hiX9hk90Fhu6OT5cJwm707A5Y6PEZqMCX2boUe9CPdTYlw2yvbR/xHiGjK5+DQIGYxIROqNHJUFq7XoQdp5sffgTCWvVk5XvDDA34Tz0n+sb+cO7HnxVrGuPeG1O3huDlAj7R2+/k6Gm5qEvxdX/Bq3r3xIsn0em9YpAYxWdWPbZlLAEIkzeZ2L/d6mZQnltZxu+JhaCDi3nf6COrulBrjuxP7+LTqF0UwVB7TsWTW/jDmyMgEpZIt9mrToSgLPw7OPpffG/d4nKrot29MCr7a2MuQ+eJ3gH5Z6LDacnCN2GjtOJp5Kd55KK8l6ZuU6Ej3g9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glqnSt6ulhxgiRUfzu1Xq30QIF+kWkmhXTRC9ur/OPM=;
 b=oPltWv+uf6ayhSYIe0qWliK4jIYta4o+xs9aZvCanZAJoJdGgZh6nGqwF/Jx+OdCUfb4z0Wg76OSJzMa2lSpGYqqeIN0EPKO8MJkXjxHd90AMRwTk3BuosqK25jfzdJp/ndIWBX8mc5AdCeDNZZdHfU7/1vqxU3JZWJhQwRtbIg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7442.namprd04.prod.outlook.com (2603:10b6:303:71::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 10:21:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.038; Mon, 24 Oct 2022
 10:21:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Thread-Topic: consolidate btrfs checksumming, repair and bio splitting
Thread-Index: AQHYvdZkzfjbXHDoM0mHBIw1hzgYgK4dhQkAgAACIgCAAA02gIAAAvwAgAARvYA=
Date:   Mon, 24 Oct 2022 10:21:34 +0000
Message-ID: <f27ce3c9-3e3c-b61e-599f-24dc6a60e296@wdc.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <de4337f4-3157-c4a3-0ec3-dba845d4f145@gmx.com>
 <00e0cbbf-8090-7da1-22a7-a10bf4c090f2@wdc.com>
 <c957a7cd-3642-c520-fee5-ddc5f5720ffd@gmx.com>
In-Reply-To: <c957a7cd-3642-c520-fee5-ddc5f5720ffd@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7442:EE_
x-ms-office365-filtering-correlation-id: 64002982-67dc-4b23-39ac-08dab5a986c0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZANAKCnaSK18mS8XAmbU01VvG0O5ctRVnxhFxjO2oUPJvSsk7ot6fFay6TQ04XEWuwXDjInQsb7DOst8YUq9lYGgDH0BkJWAlXK39nFEBLH1NR1LYzB20XORf9QNsTkxpx3vGvtKTFvXoTyyGxxP2a1MGnoQ6WLVzUQ19Ddcqcq5J8gQUoCj+YBlL0crH5fx/ALS42GI/BoHTxiKHKTL8M4uX0Z3jtxGnAvxqp8QygqHQjQTvrKNor9y/SLiDYWA0JmMKqVP1rUYbOm7nFFi170P13+BsQYiNHFWGt/SAx3sEZbIQdpbtMpU1nZlKwkuValXvlt6QTCloqP4TgY/yNulCFX3IZ768XWeYDveK21GNNuvCTap1ZVg00o0RwfUHHbd4ZxERlU0yc4t+FG9wwrJYIV+Gv9WyzqZ5Ktpxu+uBu7cXxB8XW0MFDlxjxDcv2gtNXAL9dUKxE9hzkq3N2liEzhUj88dWx++W7rKGaHT3kqrB4yWck+/znHre9KT0K7cO+lOj4R/VlH0ebFMGhBwbf8tzOjpF8+HJv6BoAbzTms0ehsHc/8Jmcd/2MGjL26+8GEZt6Ifk786ZKHZz8TWYyzJCW5ZQCY3iEpsd/WOIyU6c0xfI6kUUP7jnQ61oLG7aCMN/o5ndvi0bxc4VF80s6/icgFnbonWMasxn5LdNA33S83LpIhZa4rkwlV09B0l04VPMczdO8AAB1vlVEUwYlldo0jVdy1c8nyYsneP4rdZ4vDoHn/kRNyBQD8EOo21Ea1RIF9k+gY+boLcUS8uzQTNVVNA8ZX0rqGsoeVeJTp4sDXfyoXyIxSUNpz5+o7W2C7LfXknmFlntgkdIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(110136005)(7416002)(54906003)(5660300002)(53546011)(122000001)(66556008)(66476007)(66446008)(64756008)(4326008)(36756003)(6506007)(41300700001)(38100700002)(8936002)(66946007)(316002)(2616005)(76116006)(8676002)(91956017)(31686004)(2906002)(38070700005)(6512007)(71200400001)(186003)(6486002)(83380400001)(86362001)(82960400001)(478600001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEQ0UnowelZXeXl0Y09sT3ViL1hYYjk4b3ExSmFOTHRRODQ5ckZ6endUSHo4?=
 =?utf-8?B?YVlBV2NOQ2F1azhtZjFRenhja3RUeEk4NFdyVE9TNGcvOEFaQVRQeE5Bc0Ex?=
 =?utf-8?B?ejJaSTRkamRTTVFQdFVycGdTK2hLRWtQMlJLcjFBTUNXY3dUV3V4SmVydkgx?=
 =?utf-8?B?dlpyZEt4bVBFMXRTQjg2OWFpc2lFK2twcUNXSHRTTTNRUyt1Wm5iRTNiTTV1?=
 =?utf-8?B?QXpXM0thQy82eUwxTjVyU3hWSUU5WEs0L1FYaHB4UGFTdC90Z09qNVpmMW1T?=
 =?utf-8?B?T3M5OHBkamVGcER6WDZ5T0p0M1pxYUJkQTlHK2g1ZzRTY1lxdmRrZTNVTFNG?=
 =?utf-8?B?cVNSWFNSSzJmQXJBUURuQ0VqU2s2L2FFK0Y4UVFyOHFCQ2drQmVhT3NQdmZ0?=
 =?utf-8?B?VjFiYmwyVk84OXBCb0lVbDJrdUh2VVdsWUtYV2RkZVExdHpDcDBKaXZCU2Vq?=
 =?utf-8?B?N0V3UGhRa2diejJYdDY2eWYxK0NHdzkwQXBsaUg4amFjT1Z6Qkd2enNOekJG?=
 =?utf-8?B?Znd1K0l5UFdoM0NEcGtjekExR0RLWDFXdnQxVC9HdmhvOXRPYXpKZkg4RXRD?=
 =?utf-8?B?ZEovM3N6R01mZG15cklrQ3FVRnI5WGd0b1hPTWRMa013aml0VlYwVUIrMC8v?=
 =?utf-8?B?aVI3cTRiUWhOSTEyYloyTXNjVTc2QVliOGFDdExOcXhNYVBZd0xST0pxK0hy?=
 =?utf-8?B?Y3dBRWtyQ2tHSEUwYkdkR2tkamlQeThzclV5TktvODErZzB4aWhLYkt5Wms0?=
 =?utf-8?B?Wi94ZFpTYnd4Z3Q3cnhDeWo4Yi9PM1hZN1plWHNaclpteXhnNmxoR3lGMDRE?=
 =?utf-8?B?eFJtNFZKTzZyblBiZlJheEVyUHhMK0pXTGsvWnl5V1AyOWdkVzdzNVcyNmZx?=
 =?utf-8?B?M2tPcXlSS1Y0VENUY0RpZXNnNFpOdjc4OGp0MWZsdjRhaHpLc2xITDcyaVgy?=
 =?utf-8?B?SnRNZ3Q4c0hmajNZeDJVTU1WcGZENkVFRHhvVzZVZVJlOGFrWUdaQnVjODJq?=
 =?utf-8?B?dTFFMGpZL2lMTkxjQ010M2tnOVRNWUFBcERvSVgybHFIeHZZWGE4WHljUUJX?=
 =?utf-8?B?NCtYT0dQakVqL0NmK1RJVlNnbUs4b2l6elduYWJsdVN3ZkVzYWtPVzFydlo3?=
 =?utf-8?B?WVlpUUZBbDlxSE54K2hFaDJ0QU9rUmxCSnlqOU53NDZnZVpaQVR6b1NXSTNS?=
 =?utf-8?B?RStHMFhJbFVmbVZ4YXhGVkYweEVTUlhjNk9rQk1qcUdrSHNPOWo3aXZJN2U5?=
 =?utf-8?B?dTMwWWxncFM4VHI4Y3VVRDU4OXkxMk1tQmgyWlVqMk1KK05UVTNwbWVZdHF6?=
 =?utf-8?B?bjZ1NmtZZnhwYWhkZlZobG1ISFpEMXRsOFJRbkNTVkZSeDBkZ09lejhEOHBk?=
 =?utf-8?B?a256Mk80YkE3MWI4c3VLVTEwcnRZaEt3U3hpd3g1ZGtNa1FVL2tjZG0vWmRk?=
 =?utf-8?B?THJkbk9zdnpWbWJOY2ZiWXR5OEZ4MzdQVjFNYXVITTBEaUM3Uk9ybXRZK1M3?=
 =?utf-8?B?RlZBcmhkR2x5V01BdDFjTmtNS2Y1dkdKLzVDRHdKVktyUDV1M2dia1VnYWJY?=
 =?utf-8?B?Uml3TmE1NktMNG1nckk2dHkxb2o1V1hHREhQWDQ2RDU4RnFzUkk1NTBTczRK?=
 =?utf-8?B?b2pnZWJ4ZnRQNjFUaEQxZ3lCOXJibk5aamFNZW1CdjNDUTRhTHdFeTdNUldq?=
 =?utf-8?B?VmNQNHBla3hjbVhBaW9IWkdSUGhxY21vdkthTFZ2NEc5dkRZdHk2b0NWV21E?=
 =?utf-8?B?ZXRta2U5TG12MGpzUDJ1SHIxQkJqOEtHakFEdUxyWmVQb0tuRmh2UkJZajJW?=
 =?utf-8?B?ZExCcHArVzlvTnlFT0diTWJBRWVNRTh2QzZDbHB0cG5VSDljclluUnlrWHJk?=
 =?utf-8?B?VGNYVjhjTDZzTkp5WFhCbG5wSm1EOVhYSzd6NW9MTVBiMXF6VnhkWkZBSHor?=
 =?utf-8?B?eGQxMXdWUWNIYjFTSGRSUTJNOG54STdtbTYrZkZTb3NFenY1SmhMWXVoYUIr?=
 =?utf-8?B?aEszZlJpby90cVhKRWVUZ3M1eXJSaG5NcUxEQWIxR29oR1pTMExrTFZVeFJ0?=
 =?utf-8?B?eldOZTJ0RU1sUTdtVnFCWlJJRlZTY0NYcWZ1ZzBuZ3VINHdYV09PMFQyOVp4?=
 =?utf-8?B?cVpBci9HcUNqZWZtRGlPcU80a1ZGYXJ6aXpsMG5SNGJKdzNHS1laYWQ5VTU2?=
 =?utf-8?B?ZmxVeGc2cjg4MmdXVEVmaGVGd0hHK0RFdVZTWTk3Z0dpaElXNjVNRWdCbFlW?=
 =?utf-8?Q?xpepkAwmk57XFR98lpxLW+pV9QN58Hlnx3iBRdUyI0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DAF61BC27CB584B97DB81B1293851C0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64002982-67dc-4b23-39ac-08dab5a986c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 10:21:34.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEw0CbraS8TianCIf+BqhB2CkdG7PUz0t7TM/j5J4yaIaba5owxLYwAP5Ba+3spBKYAVYOzu6x1nWp8GsneIKFJv+YnBoBRU+hx3bddjtpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7442
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjQuMTAuMjIgMTE6MTgsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIyLzEw
LzI0IDE3OjA3LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBPbiAyNC4xMC4yMiAxMDoy
MCwgUXUgV2VucnVvIHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiAyMDIyLzEwLzI0IDE2OjEyLCBK
b2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+Pj4+IERhdmlkLCB3aGF0J3MgeW91ciBwbGFuIHRv
IHByb2dyZXNzIHdpdGggdGhpcyBzZXJpZXM/DQo+Pj4+DQo+Pj4NCj4+PiBJbml0aWFsbHkgRGF2
aWQgd2FudHMgbWUgdG8gZG8gc29tZSBmaXh1cCBpbiBteSBzcGFyZSB0aW1lLCBidXQgSSBrbm93
DQo+Pj4geW91ciBSU1QgZmVhdHVyZSBpcyBkZXBlbmRpbmcgb24gdGhpcy4NCj4+Pg0KPj4+IElm
IHlvdSdyZSB1cmdlbnQgb24gdGhpcyBzZXJpZXMsIEkgZ3Vlc3MgSSBjYW4gcHV0IGl0IHdpdGgg
bW9yZSBwcmlvcml0eS4NCj4+DQo+PiBXaGF0J3MgdGhlIGZpeHVwcyBuZWVkZWQgdGhlcmU/IEkg
aGF2ZW4ndCBzZWVuIGEgbWFpbCBmcm9tIERhdmlkIGFib3V0IGl0Lg0KPiANCj4gTW9zdGx5IHRv
IGZpeHVwIHNvbWUgY29tbWVudHMvY29tbWl0IG1lc3NhZ2VzLg0KPiANCj4gU29ycnksIHRoYXQn
cyBhbiBvZmYgbGlzdCB0YWxrLCB0aHVzIG5vdCBpbiB0aGUgbWFpbGluZyBsaXN0Lg0KPiANCj4+
DQo+PiBJJ3ZlIHF1aWNrbHkgc2tpbW1lZCBvdmVyIHRoZSBjb21tZW50cyBhbmQgaXQgc2VlbXMg
bGlrZSBKb3NlZiBpcyBtb3N0bHkgZmluZQ0KPj4gd2l0aCBpdC4NCj4+DQo+PiBJIGNhbiBjb250
aW51ZSB3b3JraW5nIG9uIGl0IGFzIHdlbGwsIGJ1dCBhcyB0aGlzIHNlcmllcyBjb250YWlucyBj
b2RlIGZyb20gYm90aA0KPj4geW91IGFuZCBDaHJpc3RvcGggSSBkb24ndCB0aGluayBJIHNob3Vs
ZCBiZSB0aGUgM3JkIHBlcnNvbiB3b3JraW5nIG9uIGl0Lg0KPj4NCj4+IEJ1dCBpZiBpdCdzIG5l
ZWRlZCwgSSBjYW4gb2YgY2F1c2UgZG8uDQo+IA0KPiBUaGF0IHdvdWxkIGJlIHZlcnkga2luZCwg
YXMgSSdtIHN0aWxsIGZpZ2h0aW5nIHdpdGggcmFpZDU2IGNvZGUsIGFuZA0KPiB3b24ndCBiZSBh
YmxlIHRvIHdvcmsgb24gdGhpcyBzZXJpZXMgaW1tZWRpYXRlbHkuDQoNCk9LLCBJJ2xsIGdvIG92
ZXIgbXkgbGF0ZXN0IFJTVCBzZXJpZXMgYW5kIGluY29ycG9yYXRlIEpvc2VmJ3MgY29tbWVudHMg
dGhlcmUgYW5kDQphZnRlcndhcmRzIEknbGwgdGFrZSBjYXJlIG9mIHRoaXMgb25lLg0KDQo=
