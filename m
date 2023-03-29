Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC486CD1F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 08:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjC2GOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 02:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2GOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:14:32 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC0F211B
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680070466; x=1711606466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=jM0mOuGrE6VyxTVO/MAGmFI7CRMRCyPcjBHt6/8dfUWdzMbUz64Gt3wd
   Ke3fz4T1z2DH991OOLbxhzGZAdKpJUiFtEAs2XVDNHkVVswJWZ7d3SCq7
   vnaVPCOs5d7WLMmGH5yTscmTqHh5od054s5DKLpj1Klc67f06udNTYH5j
   JhrBJDyllPGnrC5xRDlKoKmSNFLYD9zp4nPpZMpncUsHLt9GlKkgqOvQu
   AeTPOQ6aVJCuIoxatrJvzsHEoUPR6dQXVSXuHerT10rwvdzDmMUCQBG1g
   3OxuMXUW6MprmXrB1/o4f7Y9p+4F2A6h7JKV8iW3n0hKUcPUnouOo2k6k
   g==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="226760224"
Received: from mail-sn1nam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 14:14:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvxJQwLqVV/4zZoKtKduc9YQIiuE2Fo2DoWrN+RtURGNkH05xVO8wJbpMzr5s57AvwAlg//s31NSgwFfQyJ3CyiJ8y8iVuPsbM5cVZ4DMAfCS211ciZWgvkKYOGI6kKp1XxuUBLLcLiprNNL0wVUSNAIxh3zlmOnVS/PRBKYXWOoCph6XoYOLerl/KbRH/GUE2fCY+J2p70Co6+RNfqqbAdUzsQERzz6nI1YUX5fhPM96FMvk7hFzJ/EQlDPVhBaT5JbZYbgIcm6sOSldjXhSc4JRoS6Fwo/e+fM9C9sv8ufwekXgG4mD1ulyOGxSF74458wWM9/7Y89UkP9DdoSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=WpryVftalByVn31Fn4lS3gW+fOCc/kLwinx8BxCVlreMyUs3/DfzvsPpBfU7guQu+5MErDBMUC1ryJdNsZ8IYWT7REcYqk/D40rcMFbokeWoz5QAZP6OueoKc3ewDJyFoZO80Xn0n4Dl+g180/6I+jUj1TNtRueTCQv03gZIPpTVES5wEkqHnEGsW9oH8RTS2ju1YvRsOcfwuj9YTlHuX1pE8hU/jjGn7Ij9xJal9DwbZUqv1SdQIoo0RCmgQdSW1FTaxPn048liZsUV1nm3LKrklshEUsKnDDwp3TNNjzQ9WWrQAQ10fvYX+wC/6zKNIph5cP8Ljw7we58J4IIKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=c42Tu0Ia0F0tsJYzy7oK2ZnFVAXBEfC67FU06TAv8ZS9LTM0ZEqJZnAKeCNDcGM+ShuMz26CyoEgHfEmMrX+bY2Dfvv4Xrp1Dx7gbh+e9IDv0AHu8zzl64A2xEeESDoGAJsxQjkCW8l93Xds9bmtwA2T+wMYSiMyJ5sdVU9lGGU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6651.namprd04.prod.outlook.com (2603:10b6:5:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 06:14:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f73b:be83:d517:ebcb]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f73b:be83:d517:ebcb%3]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 06:14:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH] zonefs: Always invalidate last cache page on append write
Thread-Topic: [PATCH] zonefs: Always invalidate last cache page on append
 write
Thread-Index: AQHZYgN+F3UNrKT86kKhDBrpFw1NOq8RR2EA
Date:   Wed, 29 Mar 2023 06:14:22 +0000
Message-ID: <18e30a80-8dd5-f0eb-a753-1d01062f697d@wdc.com>
References: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6651:EE_
x-ms-office365-filtering-correlation-id: c11b036a-3695-4a56-f31a-08db301cd731
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5D5p8QTQQ7GYPum6VXnNV/MWN+2ioD09JaFGaOe62kqeOJAF4kwbEOOz6ICNOXOd9y7euXSYF6Pddb5/PN6GkMVpkf9+CdABho2ExOobDAryeHL1Q4Kn58pXeZQWFOfGgSsiK/iKvg4U57OQIqYS3ZWjJfkqsd9XMTbyAAexgjyvUoSmkmv6uqKJ0TLb/HAWJZqDH2F8ns6wJQCodNwenlv9xykiSCesIxWozvr246t7SgmVH37C1RRnKfbh81m8JwgtDiksxUIrXud1XW4+R7GZBT4wTq9r8tVAQD/ZjuBMdl73y3GHfJZwX5vblgCcMTOdXOvHSL1LuQe3GSkQTu0z4DGB/v/FAT7hrzVrAce2gxXIQp9VRpz6ozaCYX/iq2TXZ6apXkgdfJTlPWCW8PfrlJtvV4OFihV0U8SKJRIm8km/ixI1ypFbGnjZFRRT9qvLduvQ/mSfH7RdiSCZCSa0bLGHMCI1HtvijLkyk8XidRhuGYZKxV84yqdAPwYIVct+Jet+QhFlvE0CYzYnHibcIeKou32avD6Au8NkXdu3F9n3HdHwLO+40G8JmGPmr9mArba7ScLmvDqXc52mvf2+9N8ReHTgrp7CUjelN/Xb2Xbstsuewu7elVpu7plsbhUXWIrzVBIgEnVy6cn8gz7uwn6drb3FMqz7k5iw85v52DmWWsKfpaxjmhQINcJH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(82960400001)(122000001)(26005)(6486002)(38100700002)(2616005)(186003)(4270600006)(19618925003)(2906002)(8936002)(5660300002)(6512007)(558084003)(36756003)(6506007)(478600001)(71200400001)(316002)(110136005)(38070700005)(41300700001)(86362001)(31696002)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(91956017)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1pkN0VOSnp5RTRVRkhhQlJKbS9hOCtvVm82Vyt6NUtFaWo1aFFNbFZ2R1RO?=
 =?utf-8?B?WG50LzloQkFPREhOWU5oWDVTN1drYWxKZUdlYW53YTBHdUROdHNtUjhkd1BC?=
 =?utf-8?B?MEVtNU9YSHBua2JIcXRRazRVcm1rQWRISmQvMFdubDd0VHZZM2MzTHJLSjd6?=
 =?utf-8?B?R2dDSUF4VHR2MkVBZi9VUytTbFhoZ2FNQkdNQm16Mk5jYzNwaWpvL25BSUxT?=
 =?utf-8?B?MGEzTDB3NkFQYmsrem5qeWQzdEpESDZndkZuWlVHcHRNRmw5YjEzeHJzV2V3?=
 =?utf-8?B?ZlhQa21FM1d5QWVsYVFneWwzVzdNcEFYZFpEOEcyZEd4QVdiSW91QjNYV2ZB?=
 =?utf-8?B?R25iUG5xWmdPNkgwWGUwMHlRanRiUWhWUGJLcEJVMW5jZ0JobGpaVi85eXBm?=
 =?utf-8?B?azVSWkF3aldFUmVhYkNHT1h5WW43YjFhaGxDajV0YVBsdVBLREVsVnhjL0Fq?=
 =?utf-8?B?bEE5eDM0REJBQVp2N0x6SXhibHBUbkpHRTQrbExsanovZS9rMytlbG5aMHFC?=
 =?utf-8?B?dUlyL2ZNSy9TZVZLditWN0VlVkhQZEtFVTBWQUxnbDhYOXk0S093NTAzb0xa?=
 =?utf-8?B?dWF0TUxtYkVzUHVuUHN3QkNjaG5IUVhETFdJa2hsYkdycnJnWUlwY3llSlVD?=
 =?utf-8?B?V0MwK1V3ZlpDNDdxM01vdTZQcTFrZEJWdXJieGw3QldaWmloQS8velFkTi80?=
 =?utf-8?B?MUltd3VSQnZ6U2JnMGdkM25JaU1VakpNNE5tazlMYlFmVFl2MEZRYU4rdUN0?=
 =?utf-8?B?Z1NFRUhhWDdrSUU2UlFmVDV6Q00rYzRRaGFGTjVjRnZTVUFVUUhnL2RnU0dn?=
 =?utf-8?B?Y01HZ2VqeUN5aXBpOHg1TVFSTncvY1RRSVVTWXFGNHNicFJVNXdrRUFJSkJk?=
 =?utf-8?B?Qk9Pc2xkMkQ5UGFQWDhHc2JqZ2Ztd21kZ20yVlJqMzBNQmtMSUQxdmM2M29z?=
 =?utf-8?B?RGgyVVdQKzZsR1RLQmVJZW9YRGM0aGpXWUQ2OURvYU1RMENXbFpIMTY1MVlZ?=
 =?utf-8?B?T0RiMXZ2NkJEVUtHRXFUc2kwUWtYSVpxb2xWTTlRc2tzU3VsalZhRUZpVUpB?=
 =?utf-8?B?SVlaQ3ZaRzE4bDUxYkJzQnc5WDFRL3ZXNnlGamV6ZVZDb2dtN0gxVzdOTUhE?=
 =?utf-8?B?aFBjblE5S3hmS1pYcHd5ZHErVkllWVI4OTFGcm50WjQ0cnhpbFkxREMrMjZs?=
 =?utf-8?B?bHYvVTVIV0dZa1JNYzJxbDRUTHlVUXV6V01INWtBczV1aUhjYVZ2bWNPbUFX?=
 =?utf-8?B?QlV3WDNSWCsvUzZNNFN5TXJLRzcvVG1xNU94S0lacURYZkJzTWJUZHh6ZlVH?=
 =?utf-8?B?Mk9JalFqRkM5bDh1Y3p0U0IwRFllWFMvTDJBM0FpSzJiWVZMMjl1UEwybTBK?=
 =?utf-8?B?NFpTNGRnT3F6RHdSK3o2b1BOeHpzelJLT0tHVjQyaityaXg1eVdsckVSV1px?=
 =?utf-8?B?M2tFTDlEL2tkSENuTkJNN2c3d09PZ0l3UnoxcC9QUjFVR1cxcWpJaXRZcExt?=
 =?utf-8?B?a01NVG5CQVhhTkxkcVhiYmtXYjhsVStRdDZFcHdvTldhK1hPT1ZVaWNLWEEv?=
 =?utf-8?B?TmRtclNacVUvVDlUQVJlTVNmZ0ZwaXBKWVVrQzVuYjA2T3RBbitsaHJpbE5N?=
 =?utf-8?B?bm1KZlF3RjV6M1R4WkdYSzZBd0loUGs4RjBaZFlXMzM2anh3amNEenVwNUZY?=
 =?utf-8?B?S0k4L3VZOHB2WXRPaHFsZmVGRHBWQ3laVTMwWXI1K2M5WXRPc0svQk1Eb1JE?=
 =?utf-8?B?cGpwdkJ1TEx1S00wQWRvR2xPc2VaSFVndTNhSFN5TWVHcjQ5ZHJlRjB4SGVC?=
 =?utf-8?B?WDNUTVJqV01rZURTQ1ZCSjdxcmZ5UFNHWEttdk5xTEVLaUxNWXBaMDVTLzky?=
 =?utf-8?B?TGhCMFNGdVJUVUd2K3k3S1BzNTFkeXpuR2V4M25oQUcvYlc0SlpFTHErK2pu?=
 =?utf-8?B?ZFRJNitDQ0hpUlVyMTB2ajIwVjhPNFJXV01leHFvUzdnWHdQV3lZNlpQM0ZI?=
 =?utf-8?B?aWpUOC8yajJ5ZDVuYXhPdDlxU09nNkVJS3JVSkpFdW1FT0p2Tkh3ZFpCdjIr?=
 =?utf-8?B?cFd1QmZPQ0dJMkIyYmVYMlk1L29UT21CV0grVk9CYmpJQTFaanBwZS9WYlk3?=
 =?utf-8?B?cTY3YkdPWmEvNSs0OVhNblV4YzB0bzdsU1RXYWNydWpPT3JYRkdyUDVwVDI4?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B65FA60303D6F4E8160B5D262F2E6DB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /hxcFJf9OOCfQe4pYrqrWbt9Lv6h5XGFT6Z5yOVvDddd5gfdafMvynGRHMtO/U4FVkeoH9PXhH+1pKx6mkJFDZw2d6pglMPuvBtMxOVtmtEdZhwBZOQxhnQhOvnDe1Wz+uJNXc5YzvyX0R2QuuJoxXEQRJGA6d6UMNMYHGjyPkqmmLv4ZoRv8k5RgnGFnscNnMthK+whXBHG4V1HDA3eFX6gbu5iPIVrw1TGbjecUNKWbPK6i/HEe0SeN4k144Hllf9tW2oSdWUobEpyTWpGTZlxlD42UDJdygqXBydW24Zyx7+4FnOKanXFDgMyQUVY3/pvl1z2EZ9FR4O3+g64atbhCTy2ruyY0vRGZKvsUYefusidWQ3UT8VERBH8KsUCX8QNZLkydAMYRBeNAWJ1/M9ZfKXix+8vAaPA5jYbE+sT3JOvDgM7yIiAvymrfBWklNJ/AM1+TA5lJFom5dpcu/kG4t5GP3gwfT1vUFQRGjNXvYkRtmnwrDLHl2E0M/Bk9wOzaDDTYyijuyglAVhgDLsC4j0ImQHJjfQ3xJcdbZ8EFanU7AHicxue/fRZoQd5kc2lFeO4ryI9Q+2NKfWAlnnqoAIxbi6EmMj1QfqRAdMhv1UkwwvKx4KNLp4vlR07n2NlOMvaFtzPQyjvlrxRfAXPDvbPAXTWMTwXB1LZLN28Ov9dCRpqFQluxzLeTP97HiT0CZqCYIGILynoMbjWoyCfhhrxzs8jjjvqhMdyw+NpiuOEEcv+Rc8uBZbyZ3z0Agda1KqrNJQWkyh6PKZThw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11b036a-3695-4a56-f31a-08db301cd731
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 06:14:23.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lo8QSt7LOjqNwuTJyNtmL16tvjjZxZZmplbHWFvUBo+1nhajuiYLfzdl4mjjUc8T5bbARnKEgbzA5Qv7slyVeLj1lj2VEy7Tw9HZNOYhiF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6651
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
