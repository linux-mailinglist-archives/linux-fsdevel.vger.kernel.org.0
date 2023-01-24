Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA97679658
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 12:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjAXLOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 06:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjAXLOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:14:04 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A3912074;
        Tue, 24 Jan 2023 03:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674558840; x=1706094840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=G4d47gnmln7lF92BgykQ7iPO1jZt7Izn9ffYQOhlS5fmwGeRsRNyBX08
   zcr7NCFYNk4bDXYYQZ05P/f+9mDc9N8PRfsUq6d1hrVIXR35O9e886uQ5
   7vdl2OW0TYY4fSIqtPJE2Wq3SA9VICnMngVj/n/otBchfEKbKdaiKabsn
   USLT6Gf1aigvJLTnZxeywy9hSWCGwqMK330gPVNeMN/AQYcUD35Wr5Kf0
   MNrkFnuQDoeSZBqm24qY+vekdSLn48wo5tj2iCHs3Mg9sNCg/t0Xk5Z4B
   yd3N3M5ZYCeaUWhKoqIYFv2fQyr+7/gy++0H1jVqmFkOOyWJgJeEQfXxI
   g==;
X-IronPort-AV: E=Sophos;i="5.97,242,1669046400"; 
   d="scan'208";a="221693227"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 19:13:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9pQV2jrooN8GLddPy4Ci233hfXdamzp6oUBjKQqe1R7h7GEu0a5qJqzCGO7W4k0rlxILW0CsX8W9JM8WEQXciSx44zRApUYL/lZov4wM0ne/WbwcsGE5+EMP2IUlFzu9Y4hWRr++739Wms4SeiE0X0ficHL+tXkm4IONM9p9Zr6WrfIJPJ6zW6TRwHrIOnzOQ18kvCTIC5v5U1uSATkwdIk7hOrD45PuZH58b3WGvpkEy0Cz3alezoRc1rqVcWafC/toUKa1djlq7bkMcNATxXp421O4Z3z0J7IYBzGSPIexw95EJh0H6CRfpDETCUmQfVTKWBND4pGdWZFILU6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=mfHUfHWxZ2bBuXylbJuZ01C4yfnovd2GGRo+8KlUzo4nRLJ+l8mh6CofytF3zoi43GYNrb2Lx6e9kB5W+N4SrOeGwZECZVpTZ59qDYCJVvD2NmuXO9GrqbB82tG+49wOZ8mON5o/QjhSu5wIhoUbCUKVCrsfY0/RLg2co4Lra2MJuT8tcRLnB6E+lSPjLv6fsO1rAUhK1gdI+6skFfuOk7regwo8+N88gQfLP3CxpSgTZ0zAOj10MyKR1BXf9eBfNC9HJzZ1rFLysEp7rv4eIWZsnqmwYuEFjWA/x8FS28xEOYM4fI1KrSq40xeZ88WkWGrVigmbtzgGipevbXhHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Lmw0v7NR0IKyMFchpJatTJ3t1bqouxlIT1alNhK6MyjehUex2WcmP3hYukeVLbjGpIyyUq7wTLTAtV2hxv2Rem0h/zoyCQe7TbwS3+ef/QjidF8rL5p4eZ3NOCpc9t11iCOLHrGvcnHCoUP6R+OUXARYd6fljZk4clHzt0EPR/g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6812.namprd04.prod.outlook.com (2603:10b6:5:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 11:13:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 11:13:55 +0000
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
Subject: Re: [PATCH 17/34] btrfs: remove the is_metadata flag in struct
 btrfs_bio
Thread-Topic: [PATCH 17/34] btrfs: remove the is_metadata flag in struct
 btrfs_bio
Thread-Index: AQHZLWTIQzpnI2+Dp0azLXrb0Ru2A66tbxoA
Date:   Tue, 24 Jan 2023 11:13:55 +0000
Message-ID: <8516aad4-449a-a8b2-a590-afb2599ce347@wdc.com>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-18-hch@lst.de>
In-Reply-To: <20230121065031.1139353-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6812:EE_
x-ms-office365-filtering-correlation-id: b79e6bfb-4546-4329-c4de-08dafdfc1518
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92tPwz0bYEdgxNdwTbsEAOLCay8WlpeAbsWBO7FEb188EaYqVfNfs1qIyXP50MjVhP0/WOdnAtXI+blVkIhFwTKuCRB/grFkZBw4lw3+CXMonRn08bsEt9aNm54YmhwehlgDCGoytc3WJ4p6/wIsJodSEJZs5cz/5VxaNFNVDcI0qMed20Y+qW9ecR9lEErVSk+lrSaKBsUtG/joQeNRMvY+cpRxQEu/YIx7OFADLnXq1kTcLJpEua8K4oDb9a6v0ndwmb9UBqp28SzVF2oN1eAk+F4+oosXHtCVy9dEXWxl0Gc9iDbLGWuXLcQ2AnCIafHYk7+xdJq3ZG6UilZr+d48JUemJvPG6m8r5gRxlpPURisFkJ49K38evd85D8tZM9neo0x99DNnIOu+TaYn8o/VmseoCDRfCelflN1Yl9JnCG8ZsMkeryS85PJKukBX5N1Hcb+Yu1Tly2kJHod1WU/EDyiH52OVErwIAETI83E8lMat4dIHkL2fgsfn3d4Ixwjn5PIT5UvaicfwsoKx+Gq99J6YjyuoOF+RxtSMmuHz0QjQbmGNkobjlNPcvtF2KKolJnSxjB1cPYiOy1TC9hRAzOJMMJhTRAePBTyPRuWuhLqtTJLLBitL9bKJgf9u+k+jLswjF5fKju6hO2tYdGzAsPNdhTSgVUJZx405ePXhipfo/1H1F7WkxaUsS3XErrFfPms5MJCPRlCxN7hdBP8jgIhgLzgInI7uzyNBnx4CsutPKZfJ5yZBJTd+eatYLyamTIhHbP9mySu2PuDPhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199015)(558084003)(31686004)(38070700005)(2616005)(19618925003)(41300700001)(2906002)(38100700002)(82960400001)(31696002)(122000001)(8936002)(5660300002)(7416002)(316002)(4326008)(8676002)(71200400001)(6506007)(36756003)(54906003)(110136005)(66476007)(66946007)(66446008)(91956017)(86362001)(64756008)(76116006)(66556008)(478600001)(6486002)(4270600006)(26005)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGNpTlByQ2oxYVdmc1hBMExEa0ZueDh4QmpPQkp2Qi9RNlFNcW9ubWs0VkQz?=
 =?utf-8?B?bFdnTmpyeDRqQ05XQ3l5RlFnYm5lVXNoaXk4RGpjMk9mMitybkVrcTZLY0xm?=
 =?utf-8?B?Wk5TbGJHTVhja2k0Z2p3ZVplOStnUjdIbVl3SFljZFVjY0lWVjVGbnBkRDBw?=
 =?utf-8?B?SkNqMHllbnFFb2VJWVJrclV6c0E4T1RIWUN1Q2pNQTBmL2FiSjkxaDg3WW5w?=
 =?utf-8?B?V2d2M0hDY0RhNVFnRkpoUVgrNC9pNSt3TWoyZjhiRHVmVmZvUmUwbkpNMzEx?=
 =?utf-8?B?Y3FNbm9Fb2xpemJnemhUenNOaGRFZXdNZEN0Q1UrQ255dXZyL29WSmh6MkEw?=
 =?utf-8?B?em95N2tXczhTbjN2L0RTUHRiUkNvejR4ZVV1cnVHc2dlZlhOSUFkNFJWdkFQ?=
 =?utf-8?B?Q1lLRUM5RkFLaDRMK3hDdUtlTVRaZkRTWHIzS0NHOUdtR3pUSkFYRFRheWFp?=
 =?utf-8?B?US9WYkRPMXdtK0NTTFgveHRkYms0WnU0djAwNGdoRGlnMzdISWoyRU9vUHlH?=
 =?utf-8?B?bGtDZzhjZjRsZnMwdnFFa3RwQUEwemE1eEwyTlJXWFhNS2thb2ZUREVwalJP?=
 =?utf-8?B?eSs2ZEI1TFVSaktBeWFZb29Rb2NKVk5admFqbTBpUG5rTjRacmxlN0tXUllS?=
 =?utf-8?B?Rnd6bjZBZDBCYVNTKzNvR0NxWCs5Lzh5cXNjVlBtWHdIT2oydFhTVTNLaTBw?=
 =?utf-8?B?U3BDaG5nS3pJTzdJTXg1b1MxRVZmOFhZSENpTFA4eE1aUzRaRllhRmxZQ3Rt?=
 =?utf-8?B?ZjJVMWVmelZCNU5ucllUbktUYkJjVC9qSFF4OGphbEdTYU45S0M1eVlRQ1lr?=
 =?utf-8?B?ZzZtMGdoVkVmMkNwMzV2R2phbjM4VXhHRUV5NXdaekRvTHozZExpUS90andF?=
 =?utf-8?B?b2dqKzlOZ0VOdVJqWm1MUFR1MlRPT2svb0Z1SUhVbkxiYjJ5ZzZ0T21MdEdF?=
 =?utf-8?B?cFdodUdKTUYwbGlXa0x1dkhaeHZFNm1lMjhOTnRJbkpGUDJxTzRnY1k1YUlY?=
 =?utf-8?B?N0Rnd0FOT1ZQcXoxS0NqOHZuUng3NE9MT2Q1c085Y0RmR0pnRFU0ZXBpOGtQ?=
 =?utf-8?B?R3c2OWk5ajYzNzk5L2FIOGp5U0dOdzA0azJhOHc3RE9CaEg2aVA3TkllcC9x?=
 =?utf-8?B?UEFrMC9vNGVYSDhlSHlyamZLYkFrRHpWdlI5Q0V4YXAydXI0dHIxOEtuOEc4?=
 =?utf-8?B?Tk9iekNaTngrUWhELzhINHhUdGpoYitkemZPelRFUExCNjZJSW15dHdzdlJh?=
 =?utf-8?B?S2dTMDRyQmJXNkw3MTAyemxFTnhCeGtHVk5pSmpQanYyM2dZSVBKWXlrakJP?=
 =?utf-8?B?WldpNWRqR3JGeWVXSUZXb0xvSVgrZnpyK05hMEh6N1o2QXVrYTFSaWRSVHEz?=
 =?utf-8?B?bnNGNUpablNIaC92elJkNXNqWFJ6WE1wOERLemI1VjJNSWJFWXlrNkZjT29U?=
 =?utf-8?B?eFQxaXdBQ2ZBZERqTWYxZm9BanNkUkk2RXdXRGZEUjFqS203RGIxRDlvZXJj?=
 =?utf-8?B?Tncyc1NlcTJNMG1PWVAwVVBsQ0lKcTBLeTU2NTNhT0kwMDNTMDJCS1dSdzYx?=
 =?utf-8?B?WU5KdWFqVkZiRDdqQVZpOWNxNDJnZWl0V2ZHV2h2VXZvazVZeFdKVkt0UkJV?=
 =?utf-8?B?Slo5eERmREt5dXFQK0c5d2hVZ2ZSNjk3VG55Y0VBYkNRcC9qQlNtUlk2ZFhD?=
 =?utf-8?B?eTdHdXRueW8wb0xvSDEvOXdZY2h3eUYvTnF0ZjJ4WkY0MC9RbERPVk9yaDcw?=
 =?utf-8?B?a3FOSk1CWEh6QU1Wc1JvMVI1YlNra2diWERKRGdmTG8wc0lDaTBURXptTUhu?=
 =?utf-8?B?NmVjbUN0dWNpVTZ0d3I1N3libkIyOE9SelM4dTFGNTVaanA4dlVQSUh3dk50?=
 =?utf-8?B?ZVBwUmMwTSs1WWxHSHgrMFArYlJhOVRvN0hmSUl2MzEzNHBZZ0ZXRjZ1QVlW?=
 =?utf-8?B?SEhIbHJMeHIzU3FQT1VpeWZlMUhpY0J5WUdVM0wxZG1ZUmNmekdQSzNpOXNK?=
 =?utf-8?B?S044QVBReFhjVGFzU095UmxHYTlCYm1uT0w3VTNRVmVzQlRuV1JMVlBXKzNV?=
 =?utf-8?B?dkV5djdRRE9GSGMrSC9uNlNlQ25JNm9wRnRSUWFhUHg5WWk3cDFmQWZicnJL?=
 =?utf-8?B?U3piR0FpMlkxVHcwUFpaOHJFTmhyWXR5Umhlc1YxUHA2MDhjcjUzMG5Mamxr?=
 =?utf-8?Q?yeWB7TlfzY1hnmDlxEFO6qs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CFB04D3CB0F88459D8BAB5A7837F41C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z3BicHBDeGZyUEcrbXNEaVFlL3VERGtuZzNFNkFiTkRhT0I2QkxQN01OM1Jk?=
 =?utf-8?B?b0M0Q0pVemRuL1hVR2tYMFBLbVlyOUVaWUNlNVVrMHJLZmU0dWZvMmJmUVY4?=
 =?utf-8?B?d0FucDlta2ZDS2V6SmVXL25pSklxdmN4Q283STNpajVJNWJOcDZQYnd6eDN1?=
 =?utf-8?B?V052b1JLVjZPcGZpZ1daOEx1UFN0cUpmUGNpQjlJS3RUVUpHZmRZUUpPV3Ni?=
 =?utf-8?B?YmZmc24zUEI3ZkFUc0ZsK3FnczVnMTh1Q2RBL211OGlPWFJHMUtQZm80N2Zq?=
 =?utf-8?B?RTVIMHFYUzlXMncxeXEzZWpOdXg1RWdDcHdJd21IZVAxMXNnN3NNMXBZbFNl?=
 =?utf-8?B?cWZrUllZbEpDLzNJdm1JQzgwYUVMdTdRQnI5eTVZQ0tiUTJ4b290KzdDS3V0?=
 =?utf-8?B?NDFiWlZJeTFkVVhwU2s4eDVkL1p4NkxPNDhhL2NuZk5rby9WaHc4dzZRVUZW?=
 =?utf-8?B?M2lPOU5YVW1EYUsxSGhscnErdDM2cmN4QUVKU0Uvalh1SmNiMGhVcnp3SXRa?=
 =?utf-8?B?cDZ4ZEptNjVMb1AyY3RzTUNnYVZsU25tMHZrYmZVbzJ4QlowczNPRHB4QXdm?=
 =?utf-8?B?S0hQMktudVVveExSb2ZjM05NM2ppdXpaeHFENFhIRW5mRmU5U1lYcUNmYkw0?=
 =?utf-8?B?UXo2RTZwM2VMaDY4MHZZY0RBeC8xL1A1QmNjRFUrYzJ6c0E4aG9FK0UwYjVD?=
 =?utf-8?B?YXN2VnB3OE1kZlNiY2lzYS83dEtxeTJ2c2RvcGxvMkhaeHpsamVMOHJXaWxR?=
 =?utf-8?B?TzQ3eVYxNHVjY0grWUpnOFVvR1RicXNwQVFlV0dPcVhIUU5yMlNQOVpnSnF5?=
 =?utf-8?B?RG84QU53VU5Vc3NnZDh1NmVoenVETWpKanVEL0JORFN6Nk9IZHNHS3BaT0I3?=
 =?utf-8?B?TlVEUFJDZWY5R3pUZnVkUFB0aWZXVGx4alFUR2h1UWttN3psLzArUGh6TGxK?=
 =?utf-8?B?UUd3NWkxcm45bmZYc3I1Q050cXVHMnVJSEtEcW03QTRiZlZZUWpla3JWbHVW?=
 =?utf-8?B?ZnJaU0cxTXdTMm41eG04ZENiWXE3OWRSSWU4alhMcnpCZlVqRzNab0dzekpZ?=
 =?utf-8?B?bUIxM0NYTWg5eTAxZGhGSm9vNXVxd2Frb01UUjJKN0ppbVJveHA0QnFqQ04v?=
 =?utf-8?B?SDVCQmdXYWRSNk50NTcxNU5wNUd2bDlTU1N6LzBXTnVrb1Vtb1pmNUNVekw2?=
 =?utf-8?B?MnkzenVhRnVLWGthNVJUckQ3c2J2Nkx0bFg3SjdoaUE4TmEzQUliaHdnQm9m?=
 =?utf-8?Q?61+lRbiydvTnEYD?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79e6bfb-4546-4329-c4de-08dafdfc1518
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 11:13:55.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtGUKffHXm8d+6lMkBwFlZeS6ghQ2d7ipdIwNI5f8oPybFk7eC3+qzyoHA4hlh58f3nMm0wuzES99PQvdxm6ao0EuJje7J0HM7VkE024CRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6812
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
