Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F29712361
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbjEZJWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbjEZJWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 05:22:22 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F17E41;
        Fri, 26 May 2023 02:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685092923; x=1716628923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oA0YovCRpeWbAIZYbjQ+4CMCxhBT8jXRDh+TNip9t3o=;
  b=rmY2671UXp81NM3obdcX9awELgeE/IqWcv2WO31S2OHidIsMAo5veMnK
   Akre2zIQgImW6uT8B8yPt1BubDUeExddkAOsHrrb6IS9uOtN0PRBMOTzy
   8kzrud3n7SH1OV1wDOWT/8OFUuSEdsKmZ3y9BSeumP/BhVhJ4bzLax4w9
   bu32Tgmlm7XuIGM0NKERbVceNAhyeBu1gqY3fKcjxzXm/74EkSESVaNXZ
   L6kCthIjkN4SH1WZgo0RdiGe8kGDvqHawzrJ02N64rsD9zugJDGx60AqD
   Qu+qDHtvkXAEpOSwy7obCA1Hnci3dHeTVWpKEOqE2KNPdbazjywtrb4F1
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="236654011"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 17:22:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjxyRRv7kGfCTZHbnxVe6d5nfrcrBk5qzEHuwR/38UBJXjQe09jw/F0wJTT+z9zXzgcLTvD0+hsGTJ3qbbq2iBIHUnX+R0fq/4ht8vg9ease99A4op9bR3dP3xM5HGdAPzJPiDUGmDhVUByuYbsNiSA+aPd5sinf+kyQK5IEsWgw3zN0OsQYO/zOlu4HpZgpre3nrJRWbwtEwJz2wlV65YFjV3aKqiV7A2Z9UMOhGR/GW2teMUSGyRdG150CAttlVfc0YgXI7wUOvFFNZO9qlxeuFKkLE7q2Ciz2srXjeFZZY/WkJEoVDz7ZLeJ0aUh8kFZUMCFSw5yhM3SnPDCyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA0YovCRpeWbAIZYbjQ+4CMCxhBT8jXRDh+TNip9t3o=;
 b=VUIR7FBqt2vDxdZ3mV2yi+q4B/He1TTKlr133KNS7pZyhKp6Znz/+fOMGqt94BN4aI5d6NMbmLZ3XHy/6+1Ph4/o96GSbPfIXV84LEuWUy/TI1KOHUCYemv/5MnZNtYfep6du8WFoS5avyyG+/iGytgTssgn4sSAzhNu25R0hYD9ZJWkm44wpAlwh7qM4GPmzw6h9vuk1lnzevVCVhcjPtjCZTox0aQV+dHBGc/G0jV1ub4B20vCgu1CLeZLMaRurngAHvXpgHKSYjWQvwf1bE1tsuvPePZmF4sQeTNfA43pSMQjgbl4MbTove/7Sv58hizCoGldOpuBiJAczHTTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA0YovCRpeWbAIZYbjQ+4CMCxhBT8jXRDh+TNip9t3o=;
 b=qFF63ipitl1L1frT/toWTqIU7nQ8ah9nelBw2Xtn4Mr5asnYZ0ayZZ/H2S1pqqxRLg3RJKG0QGGg/03BIWeoXVYiQhQw4JBry6AtTxgCXKvpCuT4GEZdtWjC86mjQSMJ8NRuKj8dHc0kH478E7H+/VSHPHlTUTamUDHuQiom/4Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7389.namprd04.prod.outlook.com (2603:10b6:a03:29e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Fri, 26 May
 2023 09:21:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 09:21:58 +0000
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
Subject: Re: [PATCH v2 4/5] dm bufio: simplify by using PAGE_SECTORS_SHIFT
Thread-Topic: [PATCH v2 4/5] dm bufio: simplify by using PAGE_SECTORS_SHIFT
Thread-Index: AQHZj6Rul4Ow8+5BaUGwBzjjGuDKSa9sR8CA
Date:   Fri, 26 May 2023 09:21:58 +0000
Message-ID: <ad5c229c-4c7f-e9ff-3326-477aad226388@wdc.com>
References: <20230526073336.344543-1-mcgrof@kernel.org>
 <20230526073336.344543-5-mcgrof@kernel.org>
In-Reply-To: <20230526073336.344543-5-mcgrof@kernel.org>
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
x-ms-office365-filtering-correlation-id: 7eb253cf-89f1-4cf9-c630-08db5dcaa7e9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rAzbl8KQHcQwHjxphEOc08bcio1znsj0ngnCovdluHghc7St3pifZFm7zC81TeZ2kBHPJKBBZSntczzwa2ESlDypfezMuNqHWK9rK5td7xWRwFlUnF7dxsteKBHy3wGQglfQ/6VSNwGofwx1WlBnTxmrrzWUUVLx3fypaHQTY0w83xTtCRK4gvB94vSwaJTDUJ2l2+lNneG3RdueXSOEnADB8osnNPyeaCJFqYFsKG7ZiIJvQUJn+hjjYNTF94gqzaDArIcrTGwirwbi4eX4pvE/yLRbRTe7LoGnXOJAwpYZvVE1sZsrQAuEtlTXt73GP/d5IBZzhGQPjVNrOuvg6lKZexCpX69k+vfdD04RPsbdASp4a+FIOt+tyoYmRjKZRIQKsZjzJA1Rs4NfITCv1PjEkitS+GOxRC4jzam8OfIbtHvT2RglgIiriXyveLSpwYt/LemfCDbCYfmHchwjijyHrrfShjL4RS3Tmn6oMHiYgaBL7cHPUGjYWOzx6g3r/RH1o9tLyF6Jg2//Yejadhas2U+Qa0fXE2/LuTnp4Z9QoBGOHIfYsqmBuj02A9Yr0LRMx+D2gI2LQdzcMPR03uQ53gq2itmGwi7/Qhy2VaBDgfiO3oTszBe4fmJxK9YrynQx0rFfnUNSktfnKX2ASu6l8UjzdRnBSYCMyPdRu9HX28tPEcbwluTGFF6FOixn1veTzUHeynFsEQaIbaNNrFVDC72cGO+aT2pDTgq9HQuw3T6S6MtUD2Wy6hEVzdmX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(31686004)(6506007)(186003)(41300700001)(2616005)(6512007)(8676002)(8936002)(7416002)(26005)(53546011)(86362001)(38100700002)(4326008)(36756003)(4744005)(2906002)(110136005)(66446008)(66476007)(66556008)(64756008)(478600001)(5660300002)(66946007)(83380400001)(76116006)(316002)(54906003)(31696002)(38070700005)(91956017)(71200400001)(6486002)(82960400001)(122000001)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d25mcnhyKzYvRE5uK2FxSkVQWWR4MnV0WklTYW1JU0ZQNjRRZ1dNUDJwZVdX?=
 =?utf-8?B?MVVaZUNpVnFCOUN3OU9XZDFQT2NJVWpSRXNtRVAzTUNKRGxRUW4yeGVmUEM2?=
 =?utf-8?B?WWVJWXFDZG1pZmdyeWg0TThKMnl0RzlpRFJmdDQ0TU41cm9CWkRGZU9QT0hu?=
 =?utf-8?B?SGQzVE1hZWR6QWQ2VStyZVJWR1hRc0p5US9WeFRMa1pNR2QzaDBpZTI0TTRR?=
 =?utf-8?B?TkNOUjFUeitZOXlyV0ZJaFQyMXVSUDErWUxVUWh3L1hsUGZNTVBjRk1zTkdt?=
 =?utf-8?B?SkVOWXRFZUpiSlpVbzRJWkFZazAzeERhd29XYUdmY1ZubjFqeWtzTlJPTEJN?=
 =?utf-8?B?OXNqcnRMKzlhcWZFZTA2NnFjTFAzYVlFQmlGQktDRlhhbkM4TUFBdVBCUmIz?=
 =?utf-8?B?c050K25hZGkxTC9DZnRTb2RObWpyVFdHQjVGU1pxcDVkL2NlUDArVmZSbUh1?=
 =?utf-8?B?QjhFL1JQWjdpem1VMDhZOGd6RGFpMkk1UE5LMUlpb0hRYXBCVFdQOTdEUndD?=
 =?utf-8?B?VmlrYklmVDhNOFBlZy9nQTVwSnMxUjhseEFJNmJxWndnS0pZMVhQWEdvM2pD?=
 =?utf-8?B?eFZsM09XSDRsMjVvZFYyV014dDRqTktxYm8zT2p3Uk5hTHg3a21vcXJyOXlG?=
 =?utf-8?B?a0QrUEtwcThpekwrcjY1bEhPbVdUN1NYL2RiQ3JLbHpXYUlIMHNWS3hlTXl2?=
 =?utf-8?B?MTdUK1BCT201c1FwUmFzU2JUNkxZSlZLTzk5Y0IvZTRKTThGOVoyQ1kwa3dM?=
 =?utf-8?B?OG14TEJHdzhxUW9pUnlJNGV3WFhwNnZnRkhQbTVSaTRPZ3VMWmk2NzlWNEg5?=
 =?utf-8?B?Q1ZNTzdCOUprallBUm9pdTR2UGR0QXc1UTlCWTNNV3NXeFo2UWtvcWZJbWhy?=
 =?utf-8?B?Slh1K0hFdE52bjRJcHBYZEIvWWlDNkhrN3ZZcmxaM2UzckpvMzVYZWtuczh0?=
 =?utf-8?B?S1ZUcVlUTWpvTWEybXlXeC8zTlp0VmVRZm93b1pkTituaENPUm0xR2FubFNr?=
 =?utf-8?B?RGF6c3FGOEFlaTlyaTFQcVpFT3pwYnJVc0pwSDZ1cEJ5RlkrRDJOaEF3UUlh?=
 =?utf-8?B?eTdsSzVPSkRlL29jbFU3N2ZJZFhwNnEvMWt0YUI1T1dHeGpVZ1FCZ3BRc2Nr?=
 =?utf-8?B?VGtmNUJkcXpUYUlvdGFXYVpYa0R4WjF4UkNaUGxzUmNINmhmZzZ3Q1BFYldh?=
 =?utf-8?B?UGcrQUkyV2k0NUVvSy9pN0srR0E4SitEZnhuelVxSFhGNGpOY1daTXRyOG9s?=
 =?utf-8?B?ZG43VUxDVk9wVGowZzU5U3R0c3JSbnZlWm1lM2l2a25Qc2QyQ2d5bnFUQ0tr?=
 =?utf-8?B?bWE1UzVkczNzUGMvRGpmV3dxcElMNFFPOVAvRDA0SzJwUDJuUFlGbU9KZ01a?=
 =?utf-8?B?cktjOUExdk1hUW5lTXlCYTJsS0tlakRoNHVxRGpqOTExZ044NWg0S0haRVZI?=
 =?utf-8?B?QWFvSGs4K3FHTWI1NjFnYU1URDVtWjRjdHd0U09IS0svQzBDRFNEc1BYUU9Z?=
 =?utf-8?B?WGxCWnhYbkVGK2JLWjhxOGhxYWhmYkVZZzFFYitzSkVHbStRYkZPb2doUnZJ?=
 =?utf-8?B?eU5vMklnRTlmQy83QXFTZk8rSWt2bjF0V2lISlhGYmNkbEJsdUdSRFlndmtw?=
 =?utf-8?B?ajkyQlZ5ZEZiUXB2K2IzakFmTFRHNUNlZ0pkWVdMUlBRblkzWVZkVkJrUmdy?=
 =?utf-8?B?aG9lZWV6SUNjYnkxRCt5MnJNc1gwWitEWGVOOXNGM0dJUlR4N21wdFh3MFgy?=
 =?utf-8?B?RUdRMkhHdHUxZHFlVUgvNHltU2Q0b0N3MWcrQXNUdHo1bS80YkEvU3VvMjFt?=
 =?utf-8?B?VkJKenNNVGlPZU9UME9YaFRUTWZBOFk0cGZzK2VnTUtHcnRNeVl6VVBtai81?=
 =?utf-8?B?aEpwZG13WVUzRkQ5S1h0SWxtTUNNMkwxSFlvbFZ4RFlVOVB1N25yUVZqbkdE?=
 =?utf-8?B?UEtyUVVlQjZjdHFCdFJGdGlQQ1M0dVZncEFuQURxbC9hcnlwNjk3V1JqOXBQ?=
 =?utf-8?B?RkFQV3V5TW0rYlk1RVBQTlhOdkk5MENEYUd1dWp2a3hJcnBpaVI4Z2w1WGgx?=
 =?utf-8?B?eDFWV0JQQ1pKOVdKVjNwL3cycmUyRzVyQTZ5LzZ2THl0ZmdXMkptRU8wREtZ?=
 =?utf-8?B?bjJFODNMU05pMVpyWTFuWFUveVFQQVhxb3dZYjlkY1Nld0tKWklXemRWY3Jk?=
 =?utf-8?Q?U3DM0gbAA+zNAbTwMZeNhHI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45758A4BDB7BB34A90732E4D3D171535@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aUpNb2h2alVHZmFScTFYeWVNUnRYcExiLzFRWXNZOXA3UitCVUNBVTlQTUF6?=
 =?utf-8?B?cVlHSEF4VmIxak9oeW9xRGdnODZjRlFBd0psTFh1UzlEMTNBODd3K0V4ay8y?=
 =?utf-8?B?NkxKVzJqOWFkZmtKY0lPMWdzOUlGZ1FuY1pCclBIdTBPRXJ1bUM0bGs0WjRh?=
 =?utf-8?B?cDA4RDMvNnVrSG5FaEVZT1JOUmN3SjRXY2phL3AvbVVOaDBoblIvdGtOZGRY?=
 =?utf-8?B?RHpKY2d0ODBHVFBnVHpkYkd1b1hQTjNIeUtkYnhZU1pVRG5xdkF1QlFCWDVG?=
 =?utf-8?B?dTFQWkxjYk1xOU44em81QnFOcFV3UHp3QUJpL25OTlpTcEY5bmE1UjVpMFZX?=
 =?utf-8?B?aGdLRVRVbGYrWHRHUEtTV3hFQnhRR2NNNkxLZkxpM1ZZMVgyQjI1OTkzS21a?=
 =?utf-8?B?MjZwcy9OY1Qzck5lNmRIZGJuaEZBWXJPWllFeGMxR2dvaTdxaFRHdVkwNkQw?=
 =?utf-8?B?MmFnZlNqcHRSNU1MWSs4Y2M0dVMwbmJpSFgzMEJmTFBkeTgvTUo1RFFRcnM0?=
 =?utf-8?B?enhNaE9UZjNmTE96RXgweXAvaW05Q080eVo1YUhBTUtUdlBuL2poS0hoOXBi?=
 =?utf-8?B?SC90Nk11MWhud1l4cHdvNkRLeTgyam1UNzVkMDlQTU5EUU5kSnlIMVF5YWVP?=
 =?utf-8?B?YW53bmU2V1hzOGxab2QzR1lnQmxiWTRuSXNOZjFyN09ObExranZ3Q1B2RXNW?=
 =?utf-8?B?SjJBUUY5TkpRSFYwckwrMmwwaGpRRVkrQlh2YUtMTnlBTlBldTlzZk5OSmo5?=
 =?utf-8?B?QTZvRFg2VUMyeDJ1WU5RUGdnNnZveldWRTliQ1crR2RsUkowUWh0Z1kzUURh?=
 =?utf-8?B?S2pRaHJKZjExQU5QQ2lVV2xuTkZPcnZoN2FzMmszK3o0alJrUHE2dm1FV3NH?=
 =?utf-8?B?QWE1WjF2ODVPVXYyS2RzcElxclozOXMxWkY1a0hlSjIvNVVmUys2OHNrbEsr?=
 =?utf-8?B?eXJpYUc3YU0ySWR1ak83UXpuUXkzTml3QlZoektiQlYyanZSWWVGL2VaMlQ2?=
 =?utf-8?B?ZmVZMng2R09vMVBDVjVNS3NjbnhyRjM3blRhTTB5Vm04WXB0eHZ5L004WE5E?=
 =?utf-8?B?d0RYcEcyeDdYYXoyR0VlVmp1alhBUmEyd1JZTnhzS0hSN3RWaEtkYWFDRDgy?=
 =?utf-8?B?cDYxSGYyaGVFdDBQcjI2OEZscWhMSllCeHRKWE1GSWNRcFlnZklsYmlJY2hJ?=
 =?utf-8?B?cWMzN3E4dnBCZUYyclR4bnZ3aEdKNU1vTnEwWTk4cDdVcFpiaUhNTEZEOWh3?=
 =?utf-8?B?Wi82aXRnbVZKZmxqeU1ISFBPOTJsNm1sUllGbmRQcDE1aStYOTVzd2pGV2Jv?=
 =?utf-8?B?YUgyemw0R1lEZVZ2WHgvVS9XNTE4ZjlBbGxYMzRVb0JpQVlUdDNWSXFoMXVn?=
 =?utf-8?B?cEdZcisxeWZseXZnQzUxajNyV1ZLc0xhSWpWVDFWZE43NVd0VWM2N0hMb0xx?=
 =?utf-8?B?dUszWjU3L3RiZXVnK3RLdEJNSVVnUmxzaW9qaFU1UWdsZzFraFVML2pmaCsy?=
 =?utf-8?B?OURwOGwyMnQ4dk8wNEVPR0VaVmNGa1I5TFB0MXFVOTVmMmNPWjc5UVViSmlR?=
 =?utf-8?B?cWhnUT09?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb253cf-89f1-4cf9-c630-08db5dcaa7e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 09:21:58.4472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kjt4T8/YTfcgInHz/Y8mn1o6Lc6eVP55pPToVq3yHLJVVb4hhL6QjjRYpzqPvDp9zr6akUvDQ5DL+hxGgUD3P+ApNG6jqGKlHOV1igCMbGY=
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

T24gMjYuMDUuMjMgMDk6MzMsIEx1aXMgQ2hhbWJlcmxhaW4gd3JvdGU6DQo+ICAJCSpkYXRhX21v
ZGUgPSBEQVRBX01PREVfR0VUX0ZSRUVfUEFHRVM7DQo+ICAJCXJldHVybiAodm9pZCAqKV9fZ2V0
X2ZyZWVfcGFnZXMoZ2ZwX21hc2ssDQo+IC0JCQkJCQljLT5zZWN0b3JzX3Blcl9ibG9ja19iaXRz
IC0gKFBBR0VfU0hJRlQgLSBTRUNUT1JfU0hJRlQpKTsNCj4gKwkJCQkJCWMtPnNlY3RvcnNfcGVy
X2Jsb2NrX2JpdHMgLSAoUEFHRV9TRUNUT1JTX1NISUZUKSk7DQoNCg0KPiAgCWNhc2UgREFUQV9N
T0RFX0dFVF9GUkVFX1BBR0VTOg0KPiAgCQlmcmVlX3BhZ2VzKCh1bnNpZ25lZCBsb25nKWRhdGEs
DQo+IC0JCQkgICBjLT5zZWN0b3JzX3Blcl9ibG9ja19iaXRzIC0gKFBBR0VfU0hJRlQgLSBTRUNU
T1JfU0hJRlQpKTsNCj4gKwkJCSAgIGMtPnNlY3RvcnNfcGVyX2Jsb2NrX2JpdHMgLSAoUEFHRV9T
RUNUT1JTX1NISUZUKSk7DQoNCg0KVGhlIHBhcmVudGhlc2lzIGFyZSBjb21wbGV0ZWx5IHVubmVl
ZGVkIGluIHRoZSBuZXcgdmVyc2lvbiwNCnBsZWFzZSByZW1vdmUgdGhlbS4NCg==
