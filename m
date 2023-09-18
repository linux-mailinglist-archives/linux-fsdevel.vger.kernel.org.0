Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F657A40BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 07:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbjIRF41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 01:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbjIRF4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:56:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E212A;
        Sun, 17 Sep 2023 22:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695016552; x=1726552552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=hS9LQ+u9D91ygP/1lN9fDZfBsG5XPbTrWcvAHUVj83aAo6KZNEXcHcDm
   FcaqJJ+odyHy0OpVY5r403adUFjxYhCwtqhmkwFgsjl1rc2qbuntSdM5p
   n6zzIzWoTvUg94r2sVr4dyoMl1kfaslHJyrjB9pbs52GhGxvVvGIgeAw6
   Kf7egC5HcGDAVfnuWBmWByQhgc+lzqUhoiiLwWO4W0/BVbBMmpXROo4Cz
   YCNqNObsi2MLPGVAycrnc/Sz8U6RXEQynyhSGjtm9kOVa/3O3hj5HKrnM
   WJMH3x85bEcjtdgznWZjlFIxoDXlXGoSXSUoVZDIOT0LO+icxs/swkGF1
   Q==;
X-CSE-ConnectionGUID: jP7uxHQgTrySN+CFDqaENg==
X-CSE-MsgGUID: JLU+XY2ATv6HIZ0kX0ciQA==
X-IronPort-AV: E=Sophos;i="6.02,155,1688400000"; 
   d="scan'208";a="242417717"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 13:55:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgRBFdDhZ4sr4huaI4RUAvqTJSPztnxhVKXaAL2mzNvQpa3V0ragj/DNkz4Xd4Ex6fLW34X5vZA0w/db2TkljFYpuLYGlrP2niN29fHjFROP1B5Jnty2ftsupraijeo4TF4lAYTXJfJuVciLwEUWLcY2JVb6EAB5KG4mKY8QegV6P/GGbd3xttSHe7dcF6JVgWgGYf4eLnybY9RcMG2okI0uRKtweDcEBoXdSfLqLRu4zCEP+bAdKCuVV0lNu6VhFQ2qJFG+hi/0DIVCgy3Efw/NsVP9XaD7QrkwEbStRMYrYo3XQYOV2xpCcQZb7cSOgmpnTHPahVrLqFDk+LiwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FLROYQ4P1Md+koW++7pvT78opU2C/+NOJMwzFf5w2RK70tHrI3RGrGjiJ396cgjFJm8G1+D+OjQbxyIrEAWXFSSmzM1+D2hwAbNuVVperbpGPwbrPPY88Gw63m9bnETs1Lvg9pTgylLR4bfMs+vDar+U+hG0dzlYqKqf8+d7JuAu563tUnKlLWvBNLUyJ0TymdjPhysttUTAOFg3tdASy6e6SeELuSIxGsQNiHmMO/JFut0w4EQR87Pyia28b+YwFjtGOnMqpM9YpgFboCPNdm9Ruqj1OL+I7S/k5u8ooM2c0oHqfdwoncsL7rapHqVV0/t2cnpUjd0hJgKW5Chabw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=KPdKik3NQPlGOPPI8go1o1wmvkEUfUfS90XL7QVb16Hp//C+aFAs3tcK8XM3ifHC6GXlKMXqr4IcdFmtoNLdWQGvtEZEVeNBxMzZueDm7RljK51DE77z7I44a/6M1cy364Y1Oo6tsizpGrw95Y1RLYWXe7BaFeMIPKkWMRBGEk4=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7653.namprd04.prod.outlook.com (2603:10b6:510:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.15; Mon, 18 Sep
 2023 05:55:46 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::eaec:d76:ea35:5df6]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::eaec:d76:ea35:5df6%3]) with mapi id 15.20.6813.014; Mon, 18 Sep 2023
 05:55:46 +0000
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
Subject: Re: [PATCH v3 4/4] zram: use generic PAGE_SECTORS and
 PAGE_SECTORS_SHIFT
Thread-Topic: [PATCH v3 4/4] zram: use generic PAGE_SECTORS and
 PAGE_SECTORS_SHIFT
Thread-Index: AQHZ6CZGKC+v+aRga0KKh3ta4KGjOrAgGTwA
Date:   Mon, 18 Sep 2023 05:55:46 +0000
Message-ID: <99fac012-6c49-478a-aa9f-ce6a45bac5fc@wdc.com>
References: <20230915224343.2740317-1-mcgrof@kernel.org>
 <20230915224343.2740317-5-mcgrof@kernel.org>
In-Reply-To: <20230915224343.2740317-5-mcgrof@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7653:EE_
x-ms-office365-filtering-correlation-id: 000209fa-3552-4a86-cff1-08dbb80be755
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BS6fOk8jwUvC49cNSdtmpmfZFFv/wRgcBdC1r070+3Xv9LrfTRUQrhEAepeNXehvbeAwjNuEcfYHda9N4+Dvz4TCL7HAKD4bfyPfcrfaw0LoZEQByzXf5qnXaf/56XIXknalUBe4BiLQZEag6JgWryfGBj90/WGcYay5/PwNx4hfOaMMSAz7qHtYAq9TBotQAQa+CAPAAzBCPwgGakmEwxIu1Tmyx3hDsVUAHvpmVQ4mgRt0xtCuTIIO//v/3isrjZaAVW7WivWwdLoUgF5ADAY013e1gTOF1Sv1chPFgRNmydBahv/fFU70jx0nfapJyUtkpyrsk8KVE20AO9u6GO4fIQEN/HsXxNop5reFUJu9CFm8vnPPkEP4AA/jd++yVOcWFTaRQriY7OmLBkXgODodX75Feka+94VXIWCFKuQpOcHxJJ+jQ34CucBSHFlplbuI1dgLw1O44v+O1iDg0B20YEtGDgR+FxkmVOQ8uQRhD8in8eWqJNgVTBQ1dIIKyyJDmVRGxRvva1LmbMiIamWNyujaleRScb7L4q/dM3iU5JPNLUKarH+XZWvKM5oWkdVqyQG+mGVX50Lzwu5Lq6phBuzJl50TJvEH2dsRhqGnDkM/n+bKrl+hqZ2mB5e14sf5tKla008PvkajTpE1yZl9pJYAr48QiJUOrB261FlZE1wwFBGKnm9KHw1/cxoWVWKZhEKzKfqD/AZho3v1L0RD2AZL882PJTfOc/qoQpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(31686004)(6486002)(6506007)(38070700005)(558084003)(86362001)(31696002)(122000001)(38100700002)(36756003)(921005)(82960400001)(2616005)(4270600006)(19618925003)(2906002)(71200400001)(6512007)(478600001)(5660300002)(8676002)(4326008)(110136005)(91956017)(8936002)(41300700001)(316002)(7416002)(64756008)(54906003)(66446008)(66476007)(76116006)(66946007)(66556008)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0ZLSG1rTjRjbG1PZTV4RDdyZldXL2JWeWFGazFlVlkwTHdobWZaMnNnR1Ez?=
 =?utf-8?B?NURZbDQvTENaVENQK0hXeEdoNEtyeEE2bUNIOXArTUJ3VHFoVEhDa0Y1bnVz?=
 =?utf-8?B?N3pFdVg1QzJ5SGZ4Nnd2Y01JRHNKVXZlYWlsa0VDODIxTmpRbzJoaFJyVTIy?=
 =?utf-8?B?YTBEMTYyc1lXaExqV0ZOWUhybklxVmJoUFNNemEyejM0KzhGanBQaDNpL2Qz?=
 =?utf-8?B?RzFnYVQzekdIUitNVnNOU3ZzM01NVjExVDVhQTdxa2RXUFN4Q3Vpc09RV0k5?=
 =?utf-8?B?T2Y3bjNNUjZpZ3ozT3k5b1VtQkRtT0tIUlo5R2R4cmdqTWV6OEVtZDNnT3ZZ?=
 =?utf-8?B?cUZXNkc4bFhJM01PVnNTN1QraG10NmY3YmJOUk5jSENiUkpMYUlLa2ZJS0Vj?=
 =?utf-8?B?RW1Zb1Q1NDNzdWpvNW16VXN4VU5rbnlkMm5mZVlQb2FlL0MvYlV3SkNpTkxU?=
 =?utf-8?B?Z0tFZjVDVlBQTUtQMXdNOElpUTNiWmdPQzkrSHc5MEJEOHorY012d3liYkd2?=
 =?utf-8?B?Uk0xNWFKTlI4VGlkWjJBZ3RjeXFEQW5yU2tJSlRENkFzb0NWRjZVd1BwSEE5?=
 =?utf-8?B?R0JVWkh1R29kUVJJbW13ajZrNi9MZngzTHdjenBMWDVRbUJPeXZhSUxZd2RB?=
 =?utf-8?B?SURKdlprWEtVOFAweHFoTkU5YThTM3hYVUZOdEY5Q3dyeG44MHRDNmNPcXV0?=
 =?utf-8?B?TEg1aTNxVGI5SkE2SUdsWTNqeWRJZC8vLzVSYnJyZG85RExwZ0p1T3RHYkFD?=
 =?utf-8?B?Um1LOC9qSkgvTkdvNkdkcHUrQmxGbVBFSUhYYWUxR29VUmJYRTVSOHhyRzFn?=
 =?utf-8?B?ZGNCanR0VXFlVEFLNzF6ZDZzVUkyN2dla295em1kNERCT1dqUG82SlAxY1JP?=
 =?utf-8?B?Q2VqR3VQK2Nic3FXa3BEMUNYQWh0VTl5SjdaOG14bHZiYUE4dXFCYzd1K2FV?=
 =?utf-8?B?ZFRzUHFzaGJ5b3h2TzVQN1RPSC9VZ2N6b25BZ1owMEY5RHZ0MTZxc1FOcENB?=
 =?utf-8?B?ZXJkcVVsWFBWL0VUWW9oMHZNQkU1a256eEdVQkhKMTd5WDBwVUQvK0tLYyta?=
 =?utf-8?B?L1hFRkF2am03bm1KV0hTLzRObjk4VlhKMDBxdGxpemhxRmpHbHA0alF4VWg3?=
 =?utf-8?B?VGJwK0N1RlRNQ1plTHNETUlWbDVQUWFPays4WG1hakEyNGhtb09Gd1pNSTVt?=
 =?utf-8?B?MC90d1oxN1lWeFRTZlBUaVlYMTlMbFo4aFdsZC9aMmxHL1VaR3VodnhQRUh4?=
 =?utf-8?B?WHZ1RVRLeGdGL20zTUw0ZlBWYzFGQTBqRDUwZFhJRWdjT1UzUno3MUtqZ2xo?=
 =?utf-8?B?VGR0eDZzQ3BvcXk4eVFtWmZNRGpiVXZWYiswTGs3ZUpPTldVSVNCTGVEVG01?=
 =?utf-8?B?TjR2aEFtQlpkYjFlZ004ZUFpTlBzbkE5eDNlcUlnSkg4dlZXcTZSemVFNU5h?=
 =?utf-8?B?ZUVucVBVY252eXhMZGppaG8xdUx4cnVMc2ppVlJEZlV0VUpOQkQzSUo1Mit4?=
 =?utf-8?B?QXRmd2hQelY0MVdpdW00Q0FjWGl4YkkzZlU0M0pDUlpZMnNmNlFTZVBaYUhW?=
 =?utf-8?B?UVhzb2Q3QnpLYUR5ZTRSZjZ4eTJ0SFdiZGdWQktaSU5ibURRSTg5dzh1VGNs?=
 =?utf-8?B?cXJGUm55alEyaWJjQmtIbjQ0MHVLbnBFTGROUk5Kbk9mMkNtdzhmM0pqbkp2?=
 =?utf-8?B?QlFURm5GZWlFN1E4T3ZHOFQ5a0dKMlNkVGwwQjEzbWNKMUdmZVdRNmR4eXZI?=
 =?utf-8?B?bHIzalhVcXJvRkNQQllzOFJzSEdmWm9leHpQS0JRYmlvbzlibDY0ellzeUtn?=
 =?utf-8?B?MjF3dThRR2IxL0I4ZElPaER3RU41M2hkNVlwN2tSbTVQWUpzNTFDTXBoUGNk?=
 =?utf-8?B?NTBYS0duQXlUb3p4aFJWNUE5WGRkVmpOeHRHLzkydW5XVllGaExsUG1IaTdG?=
 =?utf-8?B?VW5wUmJNaGw0VDIveVg2YnpwWW13WnByZEZsNDJjQXFGTFY1VmZ1K25TSm5K?=
 =?utf-8?B?REJIUExJZXZmZnV2MVRrZlVSNXhFR2lJcm9CRDY5T09xdUNLUUpxNXVVQUpj?=
 =?utf-8?B?aFhWbithU0htbHovZGg0blJlTS9kc3MvcE8rSm9ycW00VWJEU0l1WWl3eFA0?=
 =?utf-8?B?bmZKRERGUGRKdW42OVRXdDhTVUFQbEZrRFBMYUNpZjdTRC9sbnZIZHg0anZC?=
 =?utf-8?B?R2QvNy90QkZDejBzTDlIWXc1ZlF5VXh4L3dWOTlndFdVWXdSWVc0MUZ1WllL?=
 =?utf-8?B?Q1k3NmwxR2Vpakgvdk9MUTRCcDBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8293F78DDF4F74C911F6C133B236B65@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SStvYnhoUU5NSGI1YXJkRjhPVzFOL1EyMk5VdFp0NXZRRjZxbUFrallHaHNL?=
 =?utf-8?B?WGNySVArOGFQV2lYaVBnQ2VXY1ZaLzNPU3kraVd5OEFtc2lWZ1NuL2dzdERU?=
 =?utf-8?B?aDQvNVJBWmVXOVoyUjVGNEM1UjJ3TFVjS1lJT0FnK2lRUVg2TmU3ZTg5NTRR?=
 =?utf-8?B?MnNibE1rT21KdXhoZG56Wjd5c2RXeDdIZjRwc21yK2FJYXo2WU85MUJkTER5?=
 =?utf-8?B?bmwxb0pZRDhoZlg2UnRkNjYrK212RThDaVhpdEZGRUVaR0JTNjhsV2ljYjRq?=
 =?utf-8?B?RkxwMWtGMVBLZFFXUjZuSGhoY21VMGt0UEMvM2RmZGhZQ2ZVOGFqbTFUblVI?=
 =?utf-8?B?bmFhRGJPbUFkRXoyQWJYaEh2Z2V5emdaWGtTOU1wc2wxVk5nb3BaZlU4MVJ1?=
 =?utf-8?B?dTlSaWIvV3ZPYUZFTGxHRU82STFJcGM5NTdEVlBZVDJRdW8vT0t3U0RmTkRq?=
 =?utf-8?B?dEs3OHpramhIQnlhdFFPMmZ5RlB3WU41cys4Y2ZLZXR0ZEFoZTZ0QnNoMk1a?=
 =?utf-8?B?U1ZXWmowS0xtWnJPcXk4V2YzUGx1dU52RGVkOXVoc0w5cGRZZlVQbSt0N3A2?=
 =?utf-8?B?Mm5lUDdkUFBlUG92NWRMR3ZhblF0MUxjdjJKZkwvdkU0ZWdBVm44YllTZ1FJ?=
 =?utf-8?B?ODhuVG01bnhRMktLdGVmVGNnTG1JNWh2aURhSnhuYTBtckJoN0FidGdYRDRI?=
 =?utf-8?B?V3VqVE9hczAvRnNqVXlBRVNUUFNtNUNLSWk2WHF2WkhxYmRkbWtnR0tleW04?=
 =?utf-8?B?dHVMZ3ZESHYvQTZmdDU5bnZMOUlYelg0NGVJMW83dnRxZjloQkl2MHFKeGF0?=
 =?utf-8?B?WHdzTEgvYkNKMkR1Q1lDMlRsYlZSVENFUnp2ajMwUXRoTVJ4SWhNa00vVFdG?=
 =?utf-8?B?RlJvU0FOVXJxNFY1VkpVODZJNTJhS2kwcm1aREtDM090VXNJNDJSS1BaZkVq?=
 =?utf-8?B?YXpaanlEYjlVVTdrblRmL2xFaTY0cjlXRkEvTW1ycW5PVDhObktUSGJPRmhX?=
 =?utf-8?B?bGg3MXZzT2xCaXhxWk1leEU2c2l2YmxRMXJMdTU2MDRNNURpcVUvbU5lQllW?=
 =?utf-8?B?Sm1NNkhET3llT2ljd0NCWUhiRXE2ZFZYSkFCV0pMaEFkYm5qcTk4SSsvUThY?=
 =?utf-8?B?eTBYZk5mVUR1VTBYcXRDRzdwRzVIR2RGaTROZ3FIcVZFSDdIN2tYNXM3TEht?=
 =?utf-8?B?Ym95NlpyODZjZW9NaVVjbDJLeVpBTVIzNkxKQ204YVNoNXp3K2FaaWUvVTFE?=
 =?utf-8?B?cHBtTVh4YWdDUGZHdTJNUDFSVXA1TU1sR21RSGRFU3lBaFU4N3k4cDBnRlZo?=
 =?utf-8?B?cU8wZjh6TmVyWFJ2cWFmRVBDUTdWTThjelQxdExUOVdQOTFvSHNTMC83MXpG?=
 =?utf-8?B?MmRVcWIycUhVNXBUR3h0aWEyek9lLzVDR3VrNDJtWDJtNFJmTlpCcUhUd1VV?=
 =?utf-8?B?ek4yc1VMcGdueko2RGw4WlRJRzNVNWYzNDhtVDNJcjZkUzRNalZoUmo1VzZD?=
 =?utf-8?B?R3puL2NHMDFlc0ZiMWRhemxJaVY3YXRNY0JOWCtVcEM3N1lOQ0I0bTVpdnQ5?=
 =?utf-8?B?NVJpUT09?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000209fa-3552-4a86-cff1-08dbb80be755
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 05:55:46.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIZgbA2c4jmA9dEsAkf+Mv0LnYQQyuoLeGdyOJLYTLUDvLMyXu2wu4fQ4mxiAQ97wb6lZQVBu47jhhpn9gxK/dlNDWQ8kbIN/fvLiEC3LSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
