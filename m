Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A1C7A40B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 07:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjIRFxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 01:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbjIRFxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:53:32 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20FD123;
        Sun, 17 Sep 2023 22:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695016401; x=1726552401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ZAjMyy6sFYFwcn7qduYQ76xn/o+Y2cA5W0c8Jzz7f4Y52CNmnR90CVsp
   EM9d7Bbhk0EMHcrZCh4VZKQDK7pLg16aZN7QiCfgpG+0sKN+sL3fvJQRv
   8T6DTu937qO5gPoQi67EkgPIvHJ+oopYIKJ8lkkG3N7Zc8YY6jrwZ36EQ
   G5ZLpGwOCHzr84JaisxHy3P3ble+6GAI//GG7yRegTUpK98YhFZPiWEbK
   bJUP9pQ/bLE9bQA4TLP0Whb40aA+2FZ+QQoZIbWOi5ik/SeDLj+EPBtIx
   j/6zw+WMCU9Ulh8KoDOpxfPAyvcxG/8sUTVHwCKe60J/2+M64014nEVUU
   g==;
X-CSE-ConnectionGUID: I05WGTgKR+K1lcdcl+s0ew==
X-CSE-MsgGUID: W1jjmc6YTsmJolze1hdijA==
X-IronPort-AV: E=Sophos;i="6.02,155,1688400000"; 
   d="scan'208";a="244536900"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 13:53:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF7ij0HaOl094RgPeG/TuUZT+VIZIzVEdh9YVLDl+Xp04jGH9h/mBmo1AMWaMDIykTmZnGJ30krxiLu/iLwf1Kvdfgwn42Vkz0W6HKqYfpg8LlJ0xOI4CYzMk8nl4veH7Strgjn20n6mK1RUfRc7bkU9CmY1mvx+P62ZMW0OHd/1N236K2l8v+LusbRafjuht2voIM/KXV1dn//0lQYUvvGyOp+egkOUDtz0q3IuPq0PDB7zNbk0dQ8PXNOJ3pCOSUdEp1qImbAubQiThlvMnxzOkpB7GPXKGdE5+bU5tGRbOGuAhqw/mJQpM8gCGHPQjQzL12l/E8wQqYn18iXcag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Mb3jPcOhOqEi+y1tvM3ReYV170OO173PUCgLUPRONqtAv3o9E0F/CoOLuP6Ljs/u1KAKM7W1PWOzkZwEqyfEV3wbdNtWm18di5NI/VTFzcPdYJfR9/Kkmz7dsyWgCyJJFu1A1GuMXb/tYwwblY+g43JwV54+/BOOah3NX59/+ArrsPkB7VYlKGj6q2M0tNLg7gZ7uSH/FaghgTh6J5KE5N18qDJSsk7VQ3EYsr7Bysqb/lbCAtfmAT+caS9vwhUCalmOcBTqQmwx2EKfPPIb5RhS9DcRIAN/Lzyd/oVwEk8vZUfUmi9Rfq4P9pjVp+BLzyfXzCcpBQzIpXw+4yjGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XW0i3yWwfoq2qIMawY4kNMYw+8BczUvZx/it4OQ3OoEWy9tYnRmNW/3EfdZQfYk9tJeNYIDBlV9QiSqjOPM0K+NJlO9NMSO1/IBg4OBFuwXPjw3ScF9gWPlpyJkOTSSOV+mxGYHNmIeCxldQWBcETqC3r7COYmGPSVX6Q8JQigc=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7653.namprd04.prod.outlook.com (2603:10b6:510:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.15; Mon, 18 Sep
 2023 05:53:15 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::eaec:d76:ea35:5df6]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::eaec:d76:ea35:5df6%3]) with mapi id 15.20.6813.014; Mon, 18 Sep 2023
 05:53:15 +0000
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
        "kbusch@kernel.org" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/4] iomap: simplify iomap_init() with PAGE_SECTORS
Thread-Topic: [PATCH v3 2/4] iomap: simplify iomap_init() with PAGE_SECTORS
Thread-Index: AQHZ6CZFAFi/HsILf0ybFrdkPv7jG7AgGIcA
Date:   Mon, 18 Sep 2023 05:53:15 +0000
Message-ID: <99cd384e-ce04-483a-9bf0-01ba8233cb49@wdc.com>
References: <20230915224343.2740317-1-mcgrof@kernel.org>
 <20230915224343.2740317-3-mcgrof@kernel.org>
In-Reply-To: <20230915224343.2740317-3-mcgrof@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7653:EE_
x-ms-office365-filtering-correlation-id: 57d49a7e-c076-4dad-4fb8-08dbb80b8d1a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MTsgPyIzqzQEgiTrbKY0/vLnseoqn4IiuDfnNhGPS1dA1v/QVAO9xavJanyy0J1Rb8soqp1Q5X5XoEgZ2is4725ZI5fEf8sMZezBfzK2D14zl+L+eEy6ngptwqM5jiE4N81wMs1/bvFdlPaSBYOEYfMNOu2uKCnjPp5L9tGKCzIUi2XwthIBZWjjAle+vz/fMEp9Nl0AFKimibZDlbl8f97TxwJCF19Q/MwhZICP+vQxd6/WQ7hTqi0jifqHg87zfHb9l2S2l9ZmMA5pjkGSikzvk15CMvmfP8AsCLNpme5VPBAdP8ZmaqW3xkprq1h6M4FhBhBOcKtHSy71B5ZVJmkIXzqZCIQ/8RCNyd6BQvvXDmQTA9sB5sTL8Ejfj1X5HwxJK1RXGewCKj9TvsBTXTpS3VYwG7XLGq/kOv6HLKWXfyYmZ+irxRH9HZbALxLDNXEfZ07+jgBbj38nivnSeAR9sg2BIjwshcYJEgoO3Go8u+xhZFW7pazK+ovYXAr+CsXDBxRlWnpKBBM404/4k7U/yJGZR7L4tq9oVMYqNel44uoUcIvbZBaPw0waikSzuG+o4hT+EN28CU8nOkUfTxP1KlKKx0guhlrA4oilZzHMIUNyLsjGJu0GDc3qAwKTrZSAJTAn1ppIOoT3TlafQqjvv0LXAvS6X05tFqk564D7vUTwY6xLEB2NM055xLO9ah+w+MhfpNtr4wC67MDHXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(31686004)(6486002)(6506007)(38070700005)(558084003)(86362001)(31696002)(122000001)(38100700002)(36756003)(921005)(82960400001)(2616005)(4270600006)(19618925003)(2906002)(71200400001)(6512007)(478600001)(5660300002)(8676002)(4326008)(110136005)(91956017)(8936002)(41300700001)(316002)(7416002)(64756008)(54906003)(66446008)(66476007)(76116006)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnZnZUk0cFQvNkNSZ2NOMnNJTFVCWkxabytZYzl4ZzRlWTltb2pXTjhMMzZI?=
 =?utf-8?B?MEs4Y0VZZlhJZlMwSGRPSEVMMmxkb242RmxSdE4rNmNDVWJSSG9NM3pFZnZr?=
 =?utf-8?B?VUxVNGVRZWNESVpNT2lEdFFFbE1nSkdXZW4yU21LWVZrcTErY3o1Q2NWb2VS?=
 =?utf-8?B?eFFiTWlaMTd2c0dhOXNZRTdtZEN3eHBWSHBnTlJoWDEyYzJyUUNSdk54N1RN?=
 =?utf-8?B?bWUxcnVIYTUzcm1hZEZaT0NSandldlM0dTUrdWIzQkpERHQ3REVNRFhYMVhM?=
 =?utf-8?B?aFZNZkVuamJTTmNMeWt1NHpuR2I1ZS9zbXJ2cndFRlZEOUdGY2hDMVNqRGs4?=
 =?utf-8?B?UWoyMlp4ZEFBc1R2Wk9UZVpzQU1MekRkZXk1Z3VwTzFaZkZEc2dlRXdJZHVU?=
 =?utf-8?B?TlpycUJEUGo5WmlsS0YrZlRRNHQ4aUlDcVJCME9rbFkxVEwzNWxRN1B6M3U2?=
 =?utf-8?B?V3NsektUN1hMNThDaWxLVFpyUksxdlFsZys1QmQ3MGlQeW5zM3ZhMHZJbTE5?=
 =?utf-8?B?UER3VS9RcWc5bjFTc3JtZ2c2ekQxdnVhM0ZtWUNXZW01Y1JqQ011bVJrVkVY?=
 =?utf-8?B?R1NuRTJQTU1BSnVORkhvdEN3MncxejVlOE85Q29zTFd1ZmFzSW1yU3RYbDNk?=
 =?utf-8?B?c0sxZWRvTXd5ckhVS1d4V3o3M1krcHMzU2J1dU01aEhWNnh0eFZvME43Y1Bw?=
 =?utf-8?B?dkZOdHUreS9mMno3OGpXb1BOaTBtcC9ZeGVVNllLb3ZtcVV5Y3dYT0JMNFh3?=
 =?utf-8?B?UC9wZFV2LzhWd0dLTHNzNS9rY1ZKN1dIaURRcjgveWpKVUxhKzRyaTJvdURj?=
 =?utf-8?B?YTNwYkxMb0ZpSUpXRjdZQXZQc1RrZTF2ajAxdXMrdzI4S1JycS9vZ0IyREl6?=
 =?utf-8?B?L3dGTHdSMGVBc2E4cFppVGpoTFU5YU1JUDZRWitMRmgvY3oxZmZ3SURTS0dq?=
 =?utf-8?B?V1pnRWVlZ3JyV3IxQXRKUlVMQmxLRnNtU2NhWW5ZSk9LRHV6ZjZkVnlnQlRK?=
 =?utf-8?B?d0VOY0NkaWEzcmxZV0tJNmlpZWo1d1RqNHRoTmhBanU2ZkRCdStnN1lQRjhF?=
 =?utf-8?B?YUlDcHM4UTVOL2JYQXZVQTRqVVhDSGRiOXV0WnRja3JzWGd4WWpleHpFMXdF?=
 =?utf-8?B?cEhUbXZQVUluejR6UnNteG51T1lPZUlQL1BCU2RSZGRvdi91R09QbGRPMG5Q?=
 =?utf-8?B?aHBzNkE5a2J5MkZ4NjVudXFUOFFISEsxcGVIOG1TU2JET2owTE5XSjdLZmpR?=
 =?utf-8?B?Nm92YlRyL2VGb3doTFNXNGVudE5aaDZnaGlUM1YwaElLbDBkUUdsQlJyK3N0?=
 =?utf-8?B?T3dMZHJnK0piNTVlVG5UU0VpZzlpbnBPdlprODlyTEJnRXBOZnF1TkdqYTZX?=
 =?utf-8?B?ZUNnc1VnUksxUlJWYlg4ODJzQ3hicVhiS1BkY3ZaMVg1RmlYaDZ6UVVITnRO?=
 =?utf-8?B?b0lHZDlRUEhtZFVaa2VuNFVVbXc5a01jeHRrdTZjY0Y2c2FXeXBkR2RiYjM5?=
 =?utf-8?B?SHZGMnMrcjRoK29INFBBTkVsRDgwNUZCbVRGVUxlNEE3ZHFtUDZ3Sm9mdGc1?=
 =?utf-8?B?bGFHdjJuMXQ2cUkvZUlPZGVraU81RDVOL3c0UFRKSHZDNGc3QjZJSE9JNmNy?=
 =?utf-8?B?MmZSVUxHc044Mm1oTmNWS25yckpDS2h2bmxvWENqYVhtMTR2WXNuRDh3L2Mw?=
 =?utf-8?B?eDBUNEkyT3Y2NHpIcENFQ2xGbzVZTmhkaVVzend4cDFBSkpqN1ZKSnBLTlgw?=
 =?utf-8?B?WkUrMHFKWUJXMUxMMXFjTFZpWTFWb1M3OTdFdzRlRTlOOHJ6bHN0eHBlU253?=
 =?utf-8?B?ZzRFNW9Wa0ZRNmF1ZGVLcW8xckZNL1oxYXd2L1JPSHM5dzMzYzYvUGFZZ2xG?=
 =?utf-8?B?eGVtTUNqV0hwUWxMUGJkZmdFNDlqWTVZalVPem1aaWU2S2hyVzdSQ09YRmlv?=
 =?utf-8?B?elVEUDZjY2JpS2dJYmhhRGFhTHdNU0FrK3RpUUxyR0ZJNnhma3BTbHErbEM3?=
 =?utf-8?B?bjhUQUtReEtDdlEvU1g4SFdxWllkQnkybHc1OVJjclkrdUMrb3MrUkErQk5F?=
 =?utf-8?B?Ulh4U0l1b2J1M2phVWdMcDBZZTNOdHltWnpvT1I5aGo1a1dOcWR6NDc5Mkxr?=
 =?utf-8?B?ZDY3ei9sbDBmcE83WHlJUE5ISHAwZC8wVUZNOVdGWWs0UklQZ2IvTDhDTlI1?=
 =?utf-8?B?QnVIS0FqTGlHRVByTk9pV09TRmRmNmYwQS80UmNNWitxKzRpUDVxOEI3U0kw?=
 =?utf-8?B?aWttZm81NFZTcXJOQUtZbHRSaDlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7AE1ADE406AA740BB49DAB1B104F238@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NGVVbTk2Q0c0MStzaWJuRFZQWU5SdHBPalNVUFcrZ3ZTSEFHVlZ0TzU3R05Z?=
 =?utf-8?B?MnJYVTVFWmZHbGcwMjZXMFRWNkNLWG56QlpIYkFlbklySnJBbGJ1dnRtcDY0?=
 =?utf-8?B?ZGdPa3l3TWFCbzlHczJmWHN4M3VXY2R4WHV5RVUvMUNPdS9GaXVsd3lneisw?=
 =?utf-8?B?QUxwRGtLNXRSV3F2NjlBdHpzZGZRNUN2Zk9EUEI3YVMxelY1aHlFZnZpc2Ju?=
 =?utf-8?B?b1NXb01LZGNmM2Z1VXZCaUZJQ1dsUnkxdnFqeFVDUW45QkNyVWk1NXhwSHZG?=
 =?utf-8?B?aDQwS1pDWVU3K3VRUm8xN0EvMFNtSnVtMW9UcTJjaHRGQVhFRzYxcm5UTURE?=
 =?utf-8?B?aDMrQVp4c2FUVjgvdFpyQ3I0Mi91TFVEM1UwSU9VTlpoV1lWaWhoQXQ0L041?=
 =?utf-8?B?a2hGVHhTK1FNKzdaK2VhbmlFbTNTb1lNSUt4dXRtRFU4WE9wMk1RaklCc2N0?=
 =?utf-8?B?c2Y3UDl2NnVBSC8zRHQ3d3VVZkw3OUlFTEZzVzFMSEdVWnNua2hCMUNQRHpY?=
 =?utf-8?B?V2IxV2IrMWQzckZWU1BRUzVjbFR2Q05TQ3F0YjFOUXJuenZHWlR5c1NMZFhQ?=
 =?utf-8?B?b0lEWExGdkkwTGV2SXptUCtQank0anZwdUpqZksyaFJIUnVCTjh4ZjdWcUhJ?=
 =?utf-8?B?M28zTVRsQTZ4TmZPTktLM1FmTjBmdEY2NW82azQ2MTgyVnNib1BLaTk2dmRw?=
 =?utf-8?B?SW1tRnNscGlZRkJxMEtyTnd5eWNEajEzWnlYeHNiY3dIeEQzZjN2dVdSRDNW?=
 =?utf-8?B?STV3THJMcmZWRkkxQmU5SnJIN0lrckdhQ2RyN1lQcjdudTFOY2tkTGJXVnFM?=
 =?utf-8?B?eUJ4Q2gxL0RONEMwUktrbkhkSWgvejIwczdMMkNpT3lrdTdXZXBsZFl4YVo3?=
 =?utf-8?B?UGFwYmRxTzFsS2hYSnBYMnU1YU5SeDFBTjRDVW9UQzN6Y1Y3T1N4SGJReGxM?=
 =?utf-8?B?UENxSDVCUXpjaVE2RHRVcmdtd3RxdFJXcTh0VG84eHJMR1JjY1RMNUdCSCtP?=
 =?utf-8?B?V0xCOHk4dk1PbXA3Q0tqWXRhRklBbjQ2NHdMRXBSVXhKc2pRby91a2F6TmF0?=
 =?utf-8?B?OHUzN0puNUVwNGcwNWxuVHZjMUU5bWc3NCsxMHBaZVQxS2VBbTVidkdyd0JG?=
 =?utf-8?B?aytDSnEveXNUNjRTWngyZDlEb2VOOGM5REg3MTh3ZnlSYXk0aXlXeC8rc2tD?=
 =?utf-8?B?OUl3RWoyWkRCRXlBRm5SSnUxemY5R2dJdVQ0Wlc0bXE4SnZPUWo1TGM2MjRK?=
 =?utf-8?B?Wk8yMGdzMllaTWN6ZFo5L25tcVBuVWM2OHpjKys5TEZHRUpTVWdHK1RuTGkr?=
 =?utf-8?B?dGE3N1VIbWRxMWMrN3RtUHBLYVUyQk1uM1BSOFIreHBrSDVadTV3Q1RGRkpF?=
 =?utf-8?B?Z2loajM3WU0xOU1HNmVWU05NRmFrMUhwUERnTG5vaGlpcHBwWEJmcFUwMTl4?=
 =?utf-8?B?ZEhSOG91VHkwZUIzOE5JemZ6eHRNZmxzaklXeTFhTS83dXFFTTlIaTU1ZWVF?=
 =?utf-8?B?VmhodXk1cUNRNFp4aWdaZXhwejROQ3ZsQ24vRTF2My9HcUhGZTQvVHBobVNN?=
 =?utf-8?Q?rYgRWxjQvOcvWwDd/Kfu0qGBs=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d49a7e-c076-4dad-4fb8-08dbb80b8d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 05:53:15.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtimGiD7P3k1PCoHgXHnB13YJ9LV4YzYjZR26JBbKOH0yA22WgM320KplWJnamCdAWXBBwzerkeWQ8CAUoiA6WdjXMSAeR5gkN+9fEpMK5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
