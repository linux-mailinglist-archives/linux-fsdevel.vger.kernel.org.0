Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1B5666FD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 11:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbjALKiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 05:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjALKhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:37:45 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812C55587C;
        Thu, 12 Jan 2023 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673519513; x=1705055513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qydS6QdCmQp2vkEruDmUBnZmwARNGq2nliyD5s0VVko=;
  b=p+2Q3bPnWiZ2N0GE4zlNgH8ez2g44wujcklqkauWxX9SrYMBfCIy4Knx
   ue6bcIl9Li9jh8Mx0ThwGWYS3xx0mth/vZ+BGrIov5HmOULKVG7/CTlcP
   Rm5+bTBiYtJJEVOmQG0/HQ8e7ZPci11dbBOTFiay9Aig0d3ANs746ot14
   0NjPAoW4R0H5YoyhLVNKcKAdnbHz62lk174F2upphn7RQwu+XPicU8oMC
   BWBYBELvRRe1S4c5JMjWkkzE3H5yYycqXoVyqLajzPo0GiQBzZBPsCo6j
   9+xHZ+b0en4zAWGRIll744lv4gELdM8iH/izYIjSXzQWUvkIUg6QK2OBk
   w==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665417600"; 
   d="scan'208";a="324916275"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 18:31:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceKROfcr5g7YNc0YxKtx6yZdnr3Sk3yd96fussdQhdx3lbz2ofGwmM+CHCtP+Po3GnpY2BGAKmuVJfyu9PpjiuM3RBbJNQnSP1DNkDX0xftcVTchi2niyNblYds4D86NoEKBGOiHII2L4i5RjeZpafirVDePJaFoqKtnQGxlLyQj8ts5WcWIm9gCVkh+BTAqO4al9O1n688I0lAhECOmZDEOkcrtJTgFi0a5aLM1HGuhMCo1+7c6Bg11ODnhrbKOhWEZAWtGhdd9OJfCHYrFd+BxvfDjGJ2tv2vjWpLwHpVxjuKDBoQeIb3UXeSWpTS/0dNsNp8APGYAHx5ezZiidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qydS6QdCmQp2vkEruDmUBnZmwARNGq2nliyD5s0VVko=;
 b=ePS5pHrHtmG9LqC7BQqYLVUwZC2lszZTAftbgDF4rS8qL5OAM+lOYh8X+v2LpvLz/h64kK/DTmHABK/aLyAWhAlkN5oT16M572r3ckp3fnZBxQNkGo+uAoIj5c9LIutkvtONlwi91CYG3Zyv+W6Z9clJ5xjslXoRJqxTliHVIr9KubuPBJvdiwyTF61Jvh96uw5QnIIl6z0U1Rrd8Nzo+bSULdoBhCO26p4MKPo+mUTP1o5RtuKI4Iz3RYZunBZhILRv0HM9PUrOHZyVTRyCADlRdSnacHVYxo6fTZ/LLohhESaLTeMcSle1YX2BjaGY/ro7qGdIOax2U7glqTWjQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qydS6QdCmQp2vkEruDmUBnZmwARNGq2nliyD5s0VVko=;
 b=lrx0n6pbstM7d0Td0O5ekMmvX4BlxWW5ZvasBNyyUF7gA5wBzO6gZuXUB2eiClQZA9uuUaUk18s8fW68ZF7niXVA4krcjYUZkhWkg2TO0V5QNQHNyPm+A8o9qXsIMWYJVjxkYQ2CU0xLifBd1qf0bGFde/I2dURdSxaqmIf2M7M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4927.namprd04.prod.outlook.com (2603:10b6:805:93::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 10:31:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 10:31:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 06/19] btrfs: handle recording of zoned writes in the
 storage layer
Thread-Topic: [PATCH 06/19] btrfs: handle recording of zoned writes in the
 storage layer
Thread-Index: AQHZJmUXr5bt/+JUhU27IeAYJp499K6alV2A
Date:   Thu, 12 Jan 2023 10:31:49 +0000
Message-ID: <aea095e4-a90b-ec16-f590-bfd5f13ce276@wdc.com>
References: <20230112090532.1212225-1-hch@lst.de>
 <20230112090532.1212225-7-hch@lst.de>
In-Reply-To: <20230112090532.1212225-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB4927:EE_
x-ms-office365-filtering-correlation-id: f47b3d79-5638-4025-80f2-08daf48836c8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x6Zh1D9DnAONSprUmPhPDjKwdTJ8Hs3D/sTlveXnGVqnEC4JKpxTQey4BZHgVkyWl4ko9P90Wq7FppJtt3QQ+1SyId098JL1IvMkqik9+Sv+Y0fZPrZjFNh3TzgxcoOwYvbC8qFqtsxm6UkzMlKOxTw4fJuG4xBSgQF47CeZfoLx9Ky/Har1QWtPpVUUxdh1cjgdFWtvAxeaS3VbeaArr1gLmlXOz8zUShb8aCbORbcMgxVZF0f2M9nBYcr6JaXz4VaWxI+JYqjQ3cYQFRTwdmoQLjwSF9+DuNPFBMT6XIa+jtezenggKQAxbiMHLW/Z0eqtl90G166K+q/AmwK4XUZnzBIlOAB6sw/QtiLQSjpoTvcC9kqEA/J3dP3uqcj8QbZ9OPVu9LmfshPRtU405Biz1zaZkPD8PVqQ+AMLFYidWYdoIUyeW2bjvsKTDNmjq6M4D6FRkO6rxlq2Upx9g7jpjmruWoTiPM140FndQpYeop5Dr3oyXvzHYeRf+LOoTV3Jbj0f2uew3ELx7Y3t0U0I9uhZuRhwj6osao1i4cUh7j+Ajy1wF16fKoVHJXu0QMbLvK3IfISHTn/k5EA3yZKuAl97CH65/1Yfyl2BmIZ1oOJVWnj0UMZYaCCoL+Kwt9RjzGjSP6Dp88UczjGCJ9FRdyTGho9wLL19xNH4u7kMxUyU3eif3iG5A6R6xbL/i+NRQfJ+YuZ6rvBWdJNq8oRyInkxi/Hrgy9PpzgikfeAyQzewcSvd/FTl0P3qiCpZFDrSJWF4WZWEPbZWV2G5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(38100700002)(122000001)(83380400001)(31696002)(82960400001)(86362001)(38070700005)(5660300002)(7416002)(2906002)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(8936002)(66946007)(8676002)(41300700001)(186003)(6506007)(6512007)(53546011)(2616005)(110136005)(54906003)(316002)(91956017)(478600001)(71200400001)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWZLY3VGQlBDREs5eUtEcWp6WVJjejlOYUJXSnZsWmtNV3l2VWtXMUJkcnhy?=
 =?utf-8?B?aWxzMTZDQTFrYk82YmhhQ0tCKzJPT2pKUDlneGVKVXVlSzlRUFZ2cFc3OEhZ?=
 =?utf-8?B?MnM0MFJjWStDcGJORlpQUnpHdlMyN21sb3htY1ZKWWNQZDhvdUcwa2xTRDRD?=
 =?utf-8?B?Z0lCOFd1ZUhsSHFYZFovZDFkeVFTRFlwdTRxL2R1TzlFeHVtVjhLQkJ6anB4?=
 =?utf-8?B?bC83OVRXbVhFazI1YnZNSmZCNXYvcTUxNHhWdFhRUGJleGw2RTVPWi9pdnd2?=
 =?utf-8?B?TkRsRTRwMDNOTXh1ZTk1dUJIdkNWWjd2ZjZHeGE5UU1KdllMZE5CZXgzbnIw?=
 =?utf-8?B?SVl3aWRUeWxKZmp4blBidUlDM3ZkVHNQemZkajZxeDU4V0NuQ256ZFdnbitx?=
 =?utf-8?B?bERRUGNUUnJEU0x1by9YSVdHOG1WZnNiWTBtWi90UDNtRnd6TWx2cU45bTNO?=
 =?utf-8?B?ZlJQdFZRd3krelpUSXpBNjVkYm9TRCtwb2FkYVdFSTRTTk1Da3I1MXBUN3ZJ?=
 =?utf-8?B?VHd1WjhUdW9xRFhaT2JFZERkOEx1R0hQUXhDYUs2RXBJZ2pROHgwS3RqbmFJ?=
 =?utf-8?B?d05FTWxKellvUEdFSExzNkxRejQ4ZkdFOUlZVldsYWJkdWNlRDJyOXdwUm1r?=
 =?utf-8?B?VytIK1A3WitwUWIrMWtnSU9XTlNBV09IcE5GQ0k5OXBNWC8wb2RSbjJad0pH?=
 =?utf-8?B?VUt5SWFiM3B5Y2d6Rmw3RFpPOUcvL0hjWkpwV3E4Zm9hSnJvZ0U5S1Z2RHNa?=
 =?utf-8?B?L0pJeWNzclZQL3Vha1BSa2ZMdmtyOXUwN1JoZVhEdk56azJnTHlzT25wVFFu?=
 =?utf-8?B?eENVSk1sUE0wdG8wdHJPTDRCdzNWdG5YbGZld0JwNVM2KzMycGFTeC9QRy9B?=
 =?utf-8?B?UG95ZkRPMklyR2tBcHhFbFgyK2k3RzRXbngxOHpLZ0pnbXM2Sk1sSEZqTjNO?=
 =?utf-8?B?bHpidkRELzVRbTdESGloTWk1dnVTTUJ0S1YrcjNQSHMrVnJQMDk3L1U5UUZX?=
 =?utf-8?B?a2JZeXZxczR1Zm85djV5Q2htZWxJS0ozdk82L3FLSXJZOGNteG5scWZOTVdU?=
 =?utf-8?B?Mkx2YVFWdmxHcjlXVUhuYlNHM3Z1MXp2OEpiR1pCMmNpQW9xWUZ3VndOalNE?=
 =?utf-8?B?dVZxY3hWSWplS0ZBVFBtTDVCMGZDaTRNc3BmRWRIQ041Wngvek5SUUo3cGpK?=
 =?utf-8?B?VFdkL3NzcVAzLzUzWUp2dGRVMmJ0UXdHbktOV3RzSHVaTGhXRmtYMExOb2p5?=
 =?utf-8?B?UEtzelN1d1FOUUY2M09xbXIwU3hhTDF4R3pDWkZxYk1HVTk5T05nbE0rNWFx?=
 =?utf-8?B?aFRvelVpbVVneDd5eUdOenRxUHJhSGhtMDUyenNVZVFNajE4TlA5ZHdHU21M?=
 =?utf-8?B?T0xtelQ1bEFnQ2U0d2l1ZllQMk5MTERzRnNLWmF1NUtwVU9EakhPdXdRQkpy?=
 =?utf-8?B?SjVseEJDazg3NlR0cmF4dUJRNHpZVGFwRVluaWEyVnN3TDBuOVdEZ3Nxa0g4?=
 =?utf-8?B?V2VULzdFRmZSSmI4akptenZ4NDBIdXMwOTFjdy9tUDdZZEh4bGVBRE5IVmdn?=
 =?utf-8?B?RUtHZXV1RmNMeE4rTFBUcGptcU9idHpoQzZGNnJBd044UXE4T0JkdUlsdVB6?=
 =?utf-8?B?NXY0SGRzcGY4U0d5NFllUTByLzJteHZBdDM4UklDSFYyZ0NJWWJZTHBNZzcy?=
 =?utf-8?B?V2ptMkN2aCszdUZKcTZqMjNWOWl0djJKa0p0SzEwTGJsSjY3cmZnamFxQXNC?=
 =?utf-8?B?aEYvM1VSSnVmdU9PcWFuRllaZkF6MXdTN2JwVDRPSnVSbEZKRGJWa3BvaG9r?=
 =?utf-8?B?REZRa3owNlh2cGhoMDdycVp6RWFwbVdWbzYzU3I0MjF2YXV3ZmNjMitERGx1?=
 =?utf-8?B?WFd3RjBYNFpaeWREWGQrbTVLV3JNZ2UwQ2FuN2F4Umd6Z3UzRmgrTk11TG0y?=
 =?utf-8?B?cGJucTh3bGlaQmJGQUJZekJZdlJzdFdXVW9EMGUyNEZ3bGtsTFhBT05FQnRE?=
 =?utf-8?B?ckx3L25RMThSbzZTTmNZTjU2REpTQTVldHdiZ2tWZ29MV1k3ZEs2TWV3UlJn?=
 =?utf-8?B?dE4yZlNXV01oU2RXc0tCQlJ3dWhRS0k3a2tqK0w5a1N4b21sQXVzNW9oY1dQ?=
 =?utf-8?B?ZWRxWi9RUXJ3UHVCNG9Gd2ljcWlaeUg3a05SWmlQa0tSZmNPVzBnV1Nudjg4?=
 =?utf-8?B?TFd0N1gyaTVwUmV2bTlnL3J4cGdMRURCWDRFY2pjc3k1OTVBZmZzWmc1WCts?=
 =?utf-8?Q?YVdCv348uEHJDS2JdIgZK75iNbLrW/KlX34Wmcpxmk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5F1D43EFBD97849A525942A176BE5EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NVFmNm0vaEVnZWNhQlY2eVdrRHh5UlZFYmh0bkxFbW04eUk0azhLN0NVZlV6?=
 =?utf-8?B?QkZPd090WVdmWURybTFDTzRxeTdLYllRbmZ6UEZHUXBUcUxVOFhWQVlONk9E?=
 =?utf-8?B?ODRMbWYwRzZETHpvT2d1MDd6SDVVUWxBeEwzdWc1QkZZbnpRaUFJeWNBQ3dj?=
 =?utf-8?B?YVV0Qm00Y2czNkh1bzQwclJJb01VQmlUS1FWdVBLd1FPQllxTFdicUJ1eGd3?=
 =?utf-8?B?VXdyamtLQ2doSFBLSnVWcHRXdndid09UMlovMlNLSHJTNW1HcmxxT254d3ZC?=
 =?utf-8?B?N1ZPZjExYTBQUjZpWHNTN1NhSUxUeGx4THcxTnlaUHBGcUdUMzNHSEREN0U0?=
 =?utf-8?B?aUc4WlFRYTAwSkZnZ2pjOCsrUHB1U3Fjdm9paklQYTVnOHNLZWlPRjhPVGo5?=
 =?utf-8?B?ZTdaSytwbjlabjB5eE9WTFg2cmxNWUE0ZHRoNkwvcFJ0ZmZNOHU4cC85dXlj?=
 =?utf-8?B?LzV5UkxHbDVuY3hiM3cyK1ZvMUpxdW9YMVU4M204d25oZXdiR2V2ZGFvZ04w?=
 =?utf-8?B?TWI0SXBkNXNHYk03TVdabnRjdDZrdjVSQk5uc0twQWFnZkVWR3FUT01NbWRW?=
 =?utf-8?B?VDFIVFp3RmpRSEszN0FDbXhuMThiWkVaZnUwS1JuZDI0MW9xazc5a25EamdC?=
 =?utf-8?B?bGtQZVZCcTJkYVkxTlZwNnorOGpic1lmM3J4OUJ3Nnl0R3U5azM5VUtGVXhY?=
 =?utf-8?B?S2YvTHJkTGgwRERPQmFHdWlManVLL1gyaFdFYjZyTndtRnFQL1M4QjlvRlRY?=
 =?utf-8?B?dUdneEdyRUM0MjFoWlh1R2wzVFZUaGJZN2N3cmJVbkxXcG83Wks4WHFzQ3Q0?=
 =?utf-8?B?WnhUanpOaFpIc1VmYktLUmQ3dzVwNjJrQzFabk9xekZ5QmsxQ0dQZTV1bmV0?=
 =?utf-8?B?OHlvTXVDSGlKTVVLMUh2aFFNUVBhNmZMeHUxbUl1azZCVnVIVTJjdExRVFB1?=
 =?utf-8?B?ZjNkakh5OUtyK3llTWMveW05TGx2QjNJWWdCYXp3MHV6SktRTDBJbTJFWFA5?=
 =?utf-8?B?aS82RFpsaGpZOXVDVGZvRU9RM0RjZ01makxUVHpCU0l6UWZiKytPZXJzMnRV?=
 =?utf-8?B?T1VvWFQ3RzcwNkJMVXNuTWxrSnJ3ZUpqNFNYOHBCRVZkbHlHMkUyekcwVkJI?=
 =?utf-8?B?MWt2Rm16Z2tJekRndmx4NmVqR0MzbVUydUsxWmUvQTJGcEFLRUZNN0kzKzdX?=
 =?utf-8?B?S0pJUExHZFhRYjVRK1hJRzFvQnZhZFU5QUFKUTZXSlVDcmtYZ1hZL1J0VTdZ?=
 =?utf-8?Q?StiuFS5Kqxpqv6r?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47b3d79-5638-4025-80f2-08daf48836c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 10:31:49.7561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQaENFy2qDTM70FDUokOOMv1CPyIhlpxJOqTJh8I7GBgp0MI8H+Y2ofHZHYwSMVd2IpX6m66AK7RewFwm2/JMQdcnttY3KWDsnVmDdp8S5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4927
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTIuMDEuMjMgMTA6MDYsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBNb3ZlIHRoZSBj
b2RlIHRoYXQgc3BsaXRzIHRoZSBvcmRlcmVkIGV4dGVudHMgYW5kIHJlY29yZHMgdGhlIHBoeXNp
Y2FsDQo+IGxvY2F0aW9uIGZvciB0aGVtIHRvIHRoZSBzdG9yYWdlIGxheWVyIHNvIHRoYXQgdGhl
IGhpZ2hlciBsZXZlbCBjb25zdW1lcnMNCj4gZG9uJ3QgaGF2ZSB0byBjYXJlIGFib3V0IHBoeXNp
Y2FsIGJsb2NrIG51bWJlcnMgYXQgYWxsLiAgVGhpcyB3aWxsIGFsc28NCj4gYWxsb3cgdG8gZXZl
bnR1YWxseSByZW1vdmUgYWNjb3VudGluZyBmb3IgdGhlIHpvbmUgYXBwZW5kIHdyaXRlIHNpemVz
IGluDQo+IHRoZSB1cHBlciBsYXllciB3aXRoIGEgbGl0dGxlIGJpdCBtb3JlIGJsb2NrIGxheWVy
IHdvcmsuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4NCj4gUmV2aWV3ZWQtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQo+
IFJldmlld2VkLWJ5OiBKb3NlZiBCYWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+DQo+IFJldmll
d2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K
DQpXaGF0IGJhc2UgaXMgdGhpcyBhZ2FpbnN0PyBJJ20gZ2V0dGluZyB0aGUgZm9sbG93aW5nOg0K
QXBwbHlpbmc6IGJ0cmZzOiBoYW5kbGUgcmVjb3JkaW5nIG9mIHpvbmVkIHdyaXRlcyBpbiB0aGUg
c3RvcmFnZSBsYXllcg0KZnMvYnRyZnMvaW5vZGUuYzogSW4gZnVuY3Rpb24g4oCYYnRyZnNfc3Vi
bWl0X2RpcmVjdOKAmToNCmZzL2J0cmZzL2lub2RlLmM6Nzg0MjoyNTogZXJyb3I6IGxhYmVsIOKA
mG91dF9lcnLigJkgdXNlZCBidXQgbm90IGRlZmluZWQNCiA3ODQyIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgZ290byBvdXRfZXJyOw0KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+DQoNCg0KU3BlY2lmaWNhbGx5IHRoYXQgaHVuayBuZWVkcyB0byBiZSByZW1vdmVkOg0KQEAg
LTc5MTEsNyArNzg4OCw2IEBAIHN0YXRpYyB2b2lkIGJ0cmZzX3N1Ym1pdF9kaXJlY3QoY29uc3Qg
c3RydWN0IGlvbWFwX2l0ZXIgKml0ZXIsDQogDQogb3V0X2Vycl9lbToNCiAJZnJlZV9leHRlbnRf
bWFwKGVtKTsNCi1vdXRfZXJyOg0KIAlkaW9fYmlvLT5iaV9zdGF0dXMgPSBzdGF0dXM7DQogCWJ0
cmZzX2Rpb19wcml2YXRlX3B1dChkaXApOw0KIH0NCg0KQnV0IHRyaXZpYWwgdG8gZml4IHVwIHdo
ZW4gYXBwbHlpbmcuDQo=
