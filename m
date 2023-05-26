Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E582E71234D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 11:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242709AbjEZJUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 05:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEZJUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 05:20:36 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253EF13D;
        Fri, 26 May 2023 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685092836; x=1716628836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=CDeKLv4InXAZp21jiKxvRIl4i5pYF41mFrVGNWW20GRAYFnk4JVYey4d
   4zfttVvQJuWGtH/dGPKKOETjCEfdbLtUdXmnN+XVwlfpx6Sw5BlpE30DW
   Aa5jgyMmqYrXuzFWTk+Y7FDcYZ7rnQqg9aJwrTS2nSS5BrcOc5wxVKNZJ
   l92MkgVJpAFA1sWe+q/RcKmGYdhrSW8EXvzytoQayzh55+bAIaNUF2sWH
   Snyh2ufyj0VlAK2n6UoaKgJbLenB6GK+Nm5d/QBJPmddFrJSV52WTgGCt
   7phVmLyvi2R7ioLROMPO6w+Fm1/opIisMKGZrwBZw/ZT8YAI2md4rtdOf
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="236653891"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 17:20:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftES229p8h9BeB5kZ1FF7x8dyBx2xrQsoNykG548t6AnW0UuUTUpUJdPJkaP0ZZNBnkSjZxAF2vdkmuzoz9sHDH+IetWcuQOXVJ4ke02k8tRlAWfe+szoKCRgkQNla0Yz0Ep426XHDF6mp4LrPnovbzEmVyijAQOu+1BaOIH80iRINwiQOOGSyQTxQqxkhSTfCVGTjs/5WQFl2pko5g+pcpp5tF66g7ULXLveKmVNxox+7E7s6XqlO66JFO0vaJuKsXTQq2uWG+nDn8hOT1nUkKAunGjIly9B/Q2nio06NAm5gmsmhUFSZzKv/HCogjyLo7FLslyWG58N/Ep263Ymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Qe/kNDB3y7uAl2zT++OeTzY0Fu6SZzEbtUVSG/Cun7LLD2LwskdFJotPULq/CtsL6DEx/J4tbdFdLmMN3hS8pz3z07kYXOf24/go5r8/GJJnHTqLN+E/zDT8DmcmIl/w21TERcv9VLQI6XeSq68/z+8qGNYhEADEqZwHRGgDyTHDtwqCxbgmdYP05NZLb0XYvmjlBGzOMHpXe/o/iXaktJuO+IAhXwgbfImcjNR0qR92++xynyGPEWUjKsCmniKpvZczlAmF+u8FusIzwcplI8RArlhQwTq0BNYFv3zeTgpZypHcSxEdnryz4wdoEiWbLJtUBvtbc2qaoQU10QbPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oOdJL2Fo2wrjioeG9JXn5ttwGclrFdvlpsYPLQM+vnlkRUthfYmllPSawMwVDdftK110DVj1ULc08zfLKSilkR2IUsymfOyt9DfgW0XfTxSMeVdGGeROzIyShnftYDYks7IEajGraVEHeIsNChSqapN/IYxIpRwe6WSXIFngmEU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7389.namprd04.prod.outlook.com (2603:10b6:a03:29e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Fri, 26 May
 2023 09:20:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 09:20:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
        "lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
        "christoph.boehmwalder@linbit.com" <christoph.boehmwalder@linbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hare@suse.de" <hare@suse.de>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "da.gomez@samsung.com" <da.gomez@samsung.com>,
        "rohan.puri@samsung.com" <rohan.puri@samsung.com>,
        "rpuri.linux@gmail.com" <rpuri.linux@gmail.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH v2 2/5] drbd: use PAGE_SECTORS_SHIFT and PAGE_SECTORS
Thread-Topic: [PATCH v2 2/5] drbd: use PAGE_SECTORS_SHIFT and PAGE_SECTORS
Thread-Index: AQHZj6Rz8nDS9HDQm0ConYF91ttygq9sR1YA
Date:   Fri, 26 May 2023 09:20:29 +0000
Message-ID: <8e50995b-1e28-fb03-d5b9-d05fde200887@wdc.com>
References: <20230526073336.344543-1-mcgrof@kernel.org>
 <20230526073336.344543-3-mcgrof@kernel.org>
In-Reply-To: <20230526073336.344543-3-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7389:EE_
x-ms-office365-filtering-correlation-id: d2bf3548-cd0d-4517-dc66-08db5dca732b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L3hhGIFga0YdL4sjnL3WnC+nb5rrsT3j8YzjKR91H7DoUI5BDj3bI2PkL9jw8eBUs/YFlpN0bJq4j2JWaQvaCYgbKhIFibkg2NFeC50zhQ5FuyG/UvsiGyN/XseLKWbagVmH+JFm1sqapfujDPb2y36r5eWO866LmtPwf0rFibgUDX45irhm3ZyqLDtShL4YLSjx6PaRMbhSHbTYR5leMVG0NtSWwUsvlXaJsq3yzYpAcyKNOhsU+H8z/XAZ1GAep9iyZZKkKV2JYcsXIu4y9+f3UEPl9Y3BJWLTEHh7TWuCAlB9Q4INvLzjyIqRRxSy8lP89QZ40POMoVhN/rsibfC5RSFdY7qeCuwkI7UWxV5LDNFvKHByjd4eDdM3hMOKyqHlH9b9KJGm7UjOT6AEdrz/oHYgL/KpZ+ATawVyiMdwK6B8Nv++aTx3DrurZVaUBUObry7eXg/52Ey7VAjQdz4roNJOVN57m1M0onh62I7Wg0ikR9NWBUOtCmhmSDbZgyvMjr65f/lUhD/xclTlCRkeSZgdH9Ezs2nuBGBhBFfc2UCRAPlEbMANkKMmUjXyPwdSTcZhsm7J4S9N/Gfyrw3FNC/5vI+HcHEbPHybgyyzOeUs3NiYKwDBNOimKs86tiQfJZv3miEE1fKuIq3A4mLr+L0nDUaw+lICSLJjoDBaW6tBrJssk08G89S9AWzX0FfjCGrIJkdpuKLSEzC4eQXX4+WOeuq+6r9NoU1TTEPKeMMeXQsaiyHsla4zLIBU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(31686004)(6506007)(186003)(41300700001)(2616005)(6512007)(8676002)(8936002)(7416002)(26005)(86362001)(38100700002)(4326008)(558084003)(36756003)(2906002)(110136005)(66446008)(66476007)(66556008)(64756008)(478600001)(5660300002)(66946007)(4270600006)(76116006)(316002)(54906003)(31696002)(38070700005)(91956017)(71200400001)(19618925003)(6486002)(82960400001)(122000001)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXZPaW1yQWxNRXo5NHFXZmRlMjlSTnFGUklPY2NXZDgzL213a1lhdXVBWGlt?=
 =?utf-8?B?bUw5dThGdStHRkNWeHZNVEN1UTVidFUrMU9qNEV5OHFwWDZHQmI2Rm1kYWwz?=
 =?utf-8?B?SkRXeEJGZEs2Uk5DSW9yVnp4T2t0NmlqYkVaVUxJZFh0Mi85dXA1QXhwN1E0?=
 =?utf-8?B?T2lWclQyWXRLcEkzNlBYTEVaWXJlbjdTSjd0ZU1TUVFaQnFOT1BRUndxbmxn?=
 =?utf-8?B?NlBtdGtpRU0rMVRUdTZtb3NWR2p2Y2NIa3pZUFkwQjRJOFM2THRtTnlocXRG?=
 =?utf-8?B?QWFKQlVHZVBaMWZQeW9jaE5DZXlJQnRQcFlzUW9KRjJacGh2RytOQ09EU25F?=
 =?utf-8?B?a0lJV0c5dnVxQzFDNkFHNUVKb1V4SXZvZWZXV2JqYWdSaWU3STQ4WFJlYW1H?=
 =?utf-8?B?SEQ2M1VNTzhIYm8rSFJjeEhBREtHaytnSWhFN3BTWm12TCs2a2xuSlZiOHNm?=
 =?utf-8?B?bjRIYktSUWpJRE1MbTd5YXJsa1FtelFKUkNkSEc4ODJNRHE5aEVBeG43RmxG?=
 =?utf-8?B?Q2JtcEZCVkEvM0lJR08rR2Zka1NVdkYydG9ZSm43T29nQ0Z6b3ZDVENyQnE2?=
 =?utf-8?B?aEl6L2RqVFA0ZmlvMHhIdlVyS0JRazJ6YitGbWpSS240V2JmR21XMWR0cmhR?=
 =?utf-8?B?V0t0QUhFR1BBNW1iRTVjZWxWejRSKzY3SVdwcm5KSnE4RmpORnQwTVlGTkQz?=
 =?utf-8?B?VzBPWVIxL01mYS9oN1AzQVFmOFUwRXRJYzZJcGNDbll3bHg3V3NWUzh4Qld2?=
 =?utf-8?B?QWVodTA2eVVxa2VvV1lGMFZ4bXlTSjFNakNvWmxSSUNja2FsV3dPM1B0UnhL?=
 =?utf-8?B?b2xQVWY2YXAvV05yRFluRHlsamRzOGs5M254S25hZEtOa3hhT1czc0NTWE9l?=
 =?utf-8?B?TlJiLy9LYzM0M0tXM0IveHVjZFk2YXNOclpadEloUkFRc28wR04zZ0pONmIy?=
 =?utf-8?B?a3VDS2w3KzhpQjZHalVScXU4UU9KeVZLTCtwU3BLZEgrQmJFbDFKVGhHNjZu?=
 =?utf-8?B?OFpyS1lpMDB6U0hvU2RJcVgwNlBXeGZYSTl4QXlSS3RQWEl3T1lBblRPL056?=
 =?utf-8?B?bm1rbTJrZDVGWTRQRm83NnkrcFdoWm8zR2NpY2tLRks2c0hKV3RZcmpuZ2I0?=
 =?utf-8?B?UmU1cUYwcFZRMlBSdFRLK09QQ2Foa1hleUFvYm5PbE5WYmlpY01MUDU0ZjNt?=
 =?utf-8?B?aFJUK2p0SzZuUlZDcjU0RXVjSFJJZGo5dW41b2s1LzRFa3RQVm1tZ1NLelg1?=
 =?utf-8?B?VVVyYitsSXBCR0FsUGlYRHNEbWVhOUtUbElBRGFsRVFKZDBTN0FaNFVlQTJ1?=
 =?utf-8?B?bWZJRE1zMEZUTW5qNjlWNVhtczcvTG0xU3NjM1RPeVlucGhvSE1LN2h3N01O?=
 =?utf-8?B?b1pjM0lLaUlKSElEbWkvdHpmbXlKRjl0b084cHlPSVE4VS9FR3RpTjNxT0xH?=
 =?utf-8?B?ak4ydnJtVGJ2WGJCWHNKYlZEMm83TC8zaXZCdHcwdUo0ZVFPaFZ1OHJnL3hP?=
 =?utf-8?B?RXEzK0dNSmxBTFlkdm5GUmpVYStGRWZHbG9UYzlLbC94UUNwWkxGeXdLTk9F?=
 =?utf-8?B?a2JlQzhpN2JpRFE3aEtKcEdoeFJTTU5RNE1aWEEzRkk2YVJuTm4wWFliY3Zh?=
 =?utf-8?B?SnIvUXpaeGxqN2pMNENnVDNnOEhZcVArTTY4eDd4WjVncDBtRnI5d29OWnlL?=
 =?utf-8?B?RWxqdWxiUmZOSDZIRFpSSlNST3VPaitvM09aaWFNSWhqRnUzbTRhZWpUVlJs?=
 =?utf-8?B?dDlPd1dvbTRoTnJCd1pHcHNTQnhuYTgxR0J5MGRQQXcrNGNxNkovL0R5SkpQ?=
 =?utf-8?B?Tm43R3JVelRQQlpYamVuRHhJa3VONzcxdEpWdnFoZmMvaEM5VEhNYnN2OEFC?=
 =?utf-8?B?OEtnbWpiRmJLMC9GMjAzVDFiMzIrNmpIeFJxdVhGTDZDeW5qSWJJM1RkWHA2?=
 =?utf-8?B?VFZuRjhxTmdKVjV3dng5YngrY1FDYlRCVFdVejlsYnY5T3VxbEQ5U1hQa1dX?=
 =?utf-8?B?Q1BPb3AxQkR3Qml5VWVsLzBqS0lDV0tuclEvcUJkNFo0ZCt0UGNremVHdncy?=
 =?utf-8?B?QitQMHhhNHpTTFNPU1JydldRMmlrVkJRU2o1VU1ycXFMT2FaVTcrRzNiS1JG?=
 =?utf-8?B?TFprbUE5WVRrdkNHc0FQSERJZVVsTmQ5dGFMQXZGVFhYNk9xaDN1bkdKRnY4?=
 =?utf-8?Q?rYohvhbk4MbmZCuZZ641j5E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC9476B5D6505B468D2588A91AAB322E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RlRTQzE0dklwZVhWeFF0NzFiV3RNSW11Rk5QMmU4cytvM3RmYXI2ZE5IcGIx?=
 =?utf-8?B?bUpRWlhYRkNxZ09oMTJsbWZEQkJ2Z0swZTVmOFhqM1IxZ203enNsaFBHbEtp?=
 =?utf-8?B?S2grcG9sbXFrN2Mxb3RlRit0QlpUdkpjR00xVUgwbEdueGZJT0FaRm1oRlM2?=
 =?utf-8?B?ZytQR0JyQ25kek14aENJUmVRMDB2bVlyUXhqVDVnRy8zR0xDNXowTEpTZWVG?=
 =?utf-8?B?eFJwd3gwSWltT3FFMWY3S2ZnUXBrWmJ3anFqT2RmYnVEVjNkTnVDUEdOUDRr?=
 =?utf-8?B?WStIWEM3R3hmMU94TTdzQ1R4SXBuMlZFZnd5dFhJVHlZQ212V3JpVmpONlE4?=
 =?utf-8?B?eGk2MnBRVDVhUzRwbTdIbWZjTXo2Y2k1MnJIVStxZ3l4dEJYd1ZqQTArcU0v?=
 =?utf-8?B?bGlCaDBkQ0JhRHpLaU93OFlEeHZreENYckN0TmMvUVdLZ0VqTzRpc0lwVWZZ?=
 =?utf-8?B?U2VGcHl3RHVlcnhuZjhHK2ZRRTdWVzYwaCtPVEpwY3psa1A0c2xub0FTbGpU?=
 =?utf-8?B?WTBWN0xTVjI3eEJwNlhYMlA0ZUJSQkJncERmUkNyUmU1TjVQRW5RN3BnZzh5?=
 =?utf-8?B?TktjVHBSem5pTkZKbk5XUTZyRC9vbTN1WDJVMWhxYkJvazYrQ3BVQ1M1cFVT?=
 =?utf-8?B?T3FVT3VSUHc1bXJmYXRpMWxTUExZcVRpZmQ4VkpZMkRaeGRkN3NkclpyVDR1?=
 =?utf-8?B?MHU0dlE4OUhRUkVXRWEwV2k0OXE5cXpVV2VrVEEyNmhIK2VmcXVUSHhKVVNm?=
 =?utf-8?B?NWNRWEt0Ti9pVUJjekN2VkhFeHByVE9IRnJUWUh2U2psNVJUaTVqTzQ3K2Zn?=
 =?utf-8?B?dVFtVTBIc1VmSzZpeVVOVGVETThROWtkTloxNGZ6NUtlcjNMZkIydnFIaTJY?=
 =?utf-8?B?NE50Um1PaDVQWUtzbzRjNFNPWG9zejNoUEpNTkM3WlQ0dXIwVm8yaVpmRHFq?=
 =?utf-8?B?Zitzd1lVTE5ud2VGUk9hUDVrWTFFc25mcUNXb1dsRldiS3htSkYzeDRoR1dK?=
 =?utf-8?B?TTBJKzVQU3ZqRlAvUEFtUEJtdERwR28vczVSaFQxbW56Q0JIMVpvSWYzQjU3?=
 =?utf-8?B?d3k3d0I5Zk1HaUhzYUJveVhDN1lnTG5GMGsrUmhvdC9jU3FJdTUyT3pkSVRw?=
 =?utf-8?B?WFlBRmhEVmhVTkZXb1dTb3hsWStNV0Roek9LSFFKOTc3a29sSHRpK09lWVVu?=
 =?utf-8?B?TXM0Kzc2akx5TGlNN1FNMFVuN3Q5UXVndkRwbTFjSmZsRUhIMExGdGRodDdm?=
 =?utf-8?B?SWplV0lFREljWmVoMFJ4aW4xeHk4TmFiQ0dnQVZIcnBHNFEyTzZ1UUgwb21a?=
 =?utf-8?B?c3Rtc2tybnhRUEhnN3BPamlOU0g0b1VaZWM0eFpPWnZxbXV4ZUFQMlMvQlYw?=
 =?utf-8?B?VlQ4bmlBTmRybGMzcU1EQVlhaS9ueVliVUx0N2wzSmR1TTRvNVlwVzBLOHMz?=
 =?utf-8?B?akxpRWp2MlRUdFFhbkZZNWVzY01CU29TS3J6Mk51bVJpSGJzL3BOZklKSWti?=
 =?utf-8?B?RU5iKy9KM3dISk11T1pWakppbWI5Z0JLOVpaRVNoNEdWQzdGMU9BWWxla0JD?=
 =?utf-8?B?RGdOZz09?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bf3548-cd0d-4517-dc66-08db5dca732b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 09:20:29.9784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QuN3bN9tPWaf+Z2gJtRmt72CVyZFKz0KrYSAijpoOV3ePjDzbzY7iO58ZGZswV/wgXeSB9OHUSQR/Ds8okWuBMPFEMBeISwnP7pMSwkMPkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7389
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
