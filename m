Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24256781E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 17:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjAWQlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 11:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjAWQlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:41:22 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7602C66F;
        Mon, 23 Jan 2023 08:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674492029; x=1706028029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0bJ7fG0CvUaFuwn8PWF7DZXqRjaYivKHPdB0wGij7TQ=;
  b=JEkrZP4SpImjldJEWTTpb/fKWpJZRmgT/Xc75cP7kEGnmlLusaXQVY5y
   NebW7BHIfmpRRnOH2tpW6WSEPFv+OeYtq9k7SUHSca+OUJNkCvznUDOn8
   /FbfkpRI6QIaANcH8DayUpYUZCvdqCZ1sTgVLEH7ek6Ul7EnOoLhRAMk4
   e9BPD+nOPLPxfQxH+kz+eC9Pjoneh7HyUIIUWL5RN5KVFP/bjdjnRRZVm
   ZzC9w85edteUBQaZxW4svddSc6lGqZ3IXV361kkhiEPSks9u55NiPOz9L
   tbqrCshGTZiWr0v7YZi76Onl93FmY+xqmnPtJs4ikFbG0JyKAsl2SsWhi
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,240,1669046400"; 
   d="scan'208";a="221377181"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 00:39:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnSLRbfNCdbyg21HcgpC4wgJMQQUdUfd9zK+2GQJBhv++atUPIQzkoT9Z+zPZWuJ6OcwQoVEU9L9OUnZsU8iQgVPzR3WSwd/t0gcxHQJrx+YK4yfgAr+Nc18F1dk8hvcTp4wzI+JxSVRIvx8tDdgndxgoCPDGcjjcbnvYxHvna5alsH+69APICx1SJJBXXfcctMZg0rfh0Otjr67scwGbLPVhBhFQKRJwI7zg6Lj3WE3oG4F79cCuvADt+nCzN64/yMKQ66Yul55YsGOoCR3/TqDqYGl50sVrlNb0eI6GAJJII/x3rWvUHCQTi5A66fquxypqkmAVZ6YmPHwKMNzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bJ7fG0CvUaFuwn8PWF7DZXqRjaYivKHPdB0wGij7TQ=;
 b=PYfLVQG7pNKHUIfMCBhuPHOxDU1LNgve5u2+ii1WFVGmRBagV3hdSDPBEcZqFCc8js7esbIAaKOwmSnUnkkqNUtcoqkvJLttwmO2fAiv1J6tiGWJ7L4qgDcpNmp9O7XbLAVM3VWVHbCTG3s5Li+fANJOQLR4mkqDJ3KyP+IIdZpEXUfhB4OMCBnS1lvQ6j2SiSbwgPzuX7pV1cu6XD4aG02MPMSQdeEqEVZaP5vnENU4lAiCg49Li4/qHSkDFIc9w6Zfde9xoT9J5ROtlBk3w9CEJjTDqHpQv3GdZwy0GD7bDRmH1m7DCr91Hsz/Xhrzt+vHrT3iTUgCpwE0PL1ENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bJ7fG0CvUaFuwn8PWF7DZXqRjaYivKHPdB0wGij7TQ=;
 b=WKUxsAlU03j+8g0GMY7yQrC73QXSUdXwb3tXuOSekAGtnxtaaLJ2tuKCKculZ6iSKVpyOrJFj7ax6J9cTzmPfO8GVARIJ6aKHQsHxIwGnL4mAcSqJFnXRhRrDfRETVFMCGg9BWq4VzlLDVIgs/P48uyfVPUq3iufRIfFTFH+qlk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6917.namprd04.prod.outlook.com (2603:10b6:610:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 16:39:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 16:39:30 +0000
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
Subject: Re: [PATCH 10/34] btrfs: handle checksum validation and repair at the
 storage layer
Thread-Topic: [PATCH 10/34] btrfs: handle checksum validation and repair at
 the storage layer
Thread-Index: AQHZLWS9vDkJofP29EGFLDJWYcVcR66sN7yA
Date:   Mon, 23 Jan 2023 16:39:29 +0000
Message-ID: <4010e363-33d7-485c-99b2-d5b86be2af3b@wdc.com>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-11-hch@lst.de>
In-Reply-To: <20230121065031.1139353-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6917:EE_
x-ms-office365-filtering-correlation-id: 763051ca-d489-4c37-93a3-08dafd606642
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AvHAvbFprkMdYmRWSLYHq+NxoTDn8vkUFxgcvJxyMMmRL17S3N7RlInW51dllnMlZPq0NXmjPCTDQK6+IIaaDAep72hmlo8ySZ8uccr1Uf6cAUeHcG5bigtuqapQjKwwEZjvYz48Cz7KBZquB0TywG4GIKnSrUKc3mP0XvLva+1mgWKLPP/YtRoAA9JRRZcKXM5KjmLswFeHl7GGbqDedX3vwxsVQcr67fStmkQIbKLUSghbl/Fyp3BCnT6vN/KO+Fn9qf+mdX/ckhIqFdOd4rm2CeEUZN2bZMEBND6avQR8OJCPx7bOe8eNUGg1evPc5LuD0aLgyTpHlevVioOnF/TKiqxMgxLXcqQdE1CbihqNr++6CnJy3sDz+5N8oyDagtNKX2g8tckwSyD1+nWAtq/iO6d4n+mMr108UM6Y4gbHXqB78EPzm+Eu0GKhi8BtEOY9I/ITuTV8jx/8Jcy405xNNzuxjNF7vY1Nolj80EpGscUVDwDgXnfvEKldY2JTrd/C+Md1EKhRQRHTtqkxPgsHLStQ95/cr7liIVSHe//p2A1Tf7Gpo0HfYacHq0LpEHyOgrY6MqyRaILKjV3dQYnFcdjMnbUJR5eSqr3ITZUFqJlLVByZyfpHgfLLcMwUz0rSr1uMU3YIq87onbf86fY6Skjjo3J+Y5VaQ3/QBTN/RgQeLXMU3BcVPyqNvzoeeIATa522o2QtjGBKYt76zjUyjeRUt6On4FhENQSkELhlaqHIyNtS2fiCOPtfH+ktsbEB65RnRWzZjMJQqKGTCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(36756003)(38070700005)(2906002)(5660300002)(7416002)(38100700002)(82960400001)(8936002)(4326008)(4744005)(41300700001)(122000001)(83380400001)(86362001)(31696002)(66446008)(478600001)(71200400001)(6486002)(91956017)(31686004)(66476007)(110136005)(6512007)(53546011)(186003)(6506007)(8676002)(316002)(54906003)(66946007)(76116006)(2616005)(64756008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzR5VklBRDJJMXE4OWFFT3FHUitRem1mcTJNNkhZR0lscVBWMDZHbzFtYU1R?=
 =?utf-8?B?VEY5VGVtRXQ0ODd5bDVxNU1uMks1MnZhcVFndDUxcEYzUC9CMENQWnNvK0Nv?=
 =?utf-8?B?cWJ1NDRNTjZrM0FKMXBaU2FVUzlKc1lQWEIyT0hzVVpZTEFDMVpTcjJnMWM2?=
 =?utf-8?B?U0FWRzlKRUtQdEttSTF0UUFvTW1SNnBYVXZEVnhWME90dzNxZzlZWEFkK25n?=
 =?utf-8?B?SDE4aWoxRnpnaUdoR3FIa2VINk40OWlscmNHcXRwMUs4WXlMMFVNdTZyb1pS?=
 =?utf-8?B?UVQ0VnBwUjhjc040WXVabk1NZkJZTDZwVGRLYlYwUm82VStqVDZkZ1RkUEhM?=
 =?utf-8?B?ZFczc3UvYkVJcHd1N3RWZXE2Z3AvNUJLUlZoV0o4cENYTUx4UUVsOTRMRTV0?=
 =?utf-8?B?WG1sUllRTWxpTytkYmRxK1FneEs3akdMeWpWanZmOS9zSnl1MWFBWjM4SGpo?=
 =?utf-8?B?b2FacTAxZnQvRnpUSlc2TUxzL0t6Q0Z4NVJNUk80OTQxNDV3cXlaVkc5U09v?=
 =?utf-8?B?K1lSdldzMGk1dStGak1Vb0x4Z2VDTFlQS0cwRzMyNXhsdUIrUHpUbWpsMlFP?=
 =?utf-8?B?dkIyY2FkU0t2L0dnanpVaUJaU1NEWDZrWThPWGN3TjgxMW5jTXNjQVVmUGxi?=
 =?utf-8?B?b2N5TjVyekc4SXhJbXhkUml1Sjg2SzVWUG1wZkduMld1UGprdGk0UmRmejhF?=
 =?utf-8?B?Vjc3UG5aYlk5TkU3K1BVc0cyVEtHZG1QYkZ1WTNWZ1JNaVoreEJ3VGtmNnlz?=
 =?utf-8?B?SytTNWYzK1lXVXFiWXdibXBGMC9oMzhrcy9BT3J5alVaMHNnRkhmRlRzU3h3?=
 =?utf-8?B?Y2FrQTVtWGlCeTVFNkcydFZJVVdESll1enNhRFN0WjdFdHZ4RGllSnRQS2pj?=
 =?utf-8?B?d1A2WC9OdkNOSm43VmpZSnRXbUZWdUo1bkd5SUFqK1JpazFuTE41b200SmdI?=
 =?utf-8?B?djdvdVhNdnc4MDhHTzJueWFPbHVxL3lpQkw1MEQ5NGNHbyt2K2hocjlCZzFB?=
 =?utf-8?B?b0lGa1RiOFlqRlpycDdWUXpOQzRPZEdYcGdITittZ29QaDNybCtKVGwxcmJV?=
 =?utf-8?B?eVNVYUJHd2t6YkJaN2NhQkZ5ZmtIVitoT2p5WFF6VzhqVmtwZVFHbzJFYi9C?=
 =?utf-8?B?b0luZUxldWwrK09tSTVreUpHSG5EMUROM202WmJMa3dNRzIyZDBqcnRGVEll?=
 =?utf-8?B?VlZ0RTZDaDVudlArRGcyeGZJZlh4QzZLbllVUGt5OTRDcmxVUnl6V1psMlVj?=
 =?utf-8?B?QzFNa1d0UDhMVFhsSDFVTEoyaDA5aTZVY0VwajBkcGMwK3Rld3VHTDVLaXJt?=
 =?utf-8?B?M2xHSnBFQjloa2Q1cFJnWS9FQW1WQ0thbzArakpWMTgrWDhteWgwTFlsRGhp?=
 =?utf-8?B?cHNZVGFmRHFkdlVGMEJ4bUtjNTV0SmZSVnhOQkhYdWUvMUI3R3FmSkZ3UWtQ?=
 =?utf-8?B?M1FoR25ScFE2emgwZnNYYVpvemRsSTlEc1o1RmFSdHJmY3pjemMrMHdVMVhN?=
 =?utf-8?B?Q3QxQUZWSDhNaE1DOUJ4Y1RUK1lMeXlkUHJPUEt3eVNTSVZ3aGxGSVk0d3F0?=
 =?utf-8?B?aW81UUdQQVhGR0x5L2pGUnFsTTJqQlZGZS91d1RTSkdRRnNFU1VXanl0Qmo4?=
 =?utf-8?B?TkJrYytIdmpEL0NLNk1jYTExQmtJTnlZWDI1bFJKZjdXZVI5KzFnaW9mcGlL?=
 =?utf-8?B?QVBiSzZWblQydG1DMnlaNkV6bFRaVTRwNVdqVnZRUHpyNi9DejQzREpYRXBs?=
 =?utf-8?B?WCtoK1BUa1BvMXJia0hIVC82UUs1S0dma0o3TWxDa2p0Sk94KzdyV2xPNUZp?=
 =?utf-8?B?VWtYU1pFYkpTL3RhSHRZang3SHZmT0RZMFFFdFgySkQ3Nlk4MzlWTjdFNEdB?=
 =?utf-8?B?YzFLVEZ4Vmw4a1VONmlzaHpuc0tQUkJHYU4wL2RxVTZGSjIxeCtsQTR5MUVo?=
 =?utf-8?B?eXp1TU9oVmNya1ZoM2xQZUQ1d3YyczBRTjNIY3pCMk5HNDQwTTZNb3prbVM5?=
 =?utf-8?B?Y2pxSzk4NCtzeGZIUEJUOEcybkpVNjBoUGVHQ3gzbFBYVDNlVkE1Sk5TVmVm?=
 =?utf-8?B?czZMTTZQZVpZVVlGS2lMcDB0VzhWbWxpSWkyOWZoOXZ1Q0pWSXlsbXNnYW9n?=
 =?utf-8?B?aUwxempZQ1BYTUNGdVM5K1lUL1RTemFjVGNqYjFaWFBvSUZnWkljNVJ0VVRP?=
 =?utf-8?B?cHFJdXFFSmVyR3BwMEl2ZlFOZTVvWVViT2hCNWpQVUVTaU1ORHRhR3pDaXZE?=
 =?utf-8?Q?zl0AtAik4Mf6nfdQDuja2b9K6cvaHjcqezZM/9nyYI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5308A382C8B3D54780B43709644170E0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d3pqU0lhZG9HbDEvNk5lTWYxWkJlTzM5R2U2S05TZXFhOHYxZWsyTmVXRDha?=
 =?utf-8?B?a2ZtOUFTajJZRlBZK0kzSTFZekcrWXZrS2lJcDdlWHFpWFhVK0drTHlhQ0xF?=
 =?utf-8?B?aEpYTm5yWGVsVGpOamZiUy9Vb2haSzM4S3VhNEIzQWJibGF2b1pCek5MUlVN?=
 =?utf-8?B?bXhNTjlxajQ2Q3hETjNyVUdRSFlQbzV2d09uSm5ydHd1T3VwV2w0NU5wYktO?=
 =?utf-8?B?TGlZcGRGYjJ2QjJadURQdHFiTFpzS3ovSFl6VC9GdCtYM0pHcVh4NnliYzFM?=
 =?utf-8?B?QWFPWEViUE9DRkkxZlJkQlpvcXp2UDR0UGNNYzdVdVBPUExpOC9EaGZzczRy?=
 =?utf-8?B?NUZMV0dGM0pZNXl6SHpGM2xmUDNXb1kyNDFXTUpaSGlYaTg1T3N3K0FjRkdP?=
 =?utf-8?B?YzBBNnpveVFVZGtia3REZ1FmUUtsbzJQZXlub2NaaFJrbklXZmpWVUY2MUdq?=
 =?utf-8?B?WGg0Uk1oeEVOU1ZDZWcvbmRzWXBCbkJrSlRzZDdwemVsZ3NCbi9lS2wzWUhy?=
 =?utf-8?B?cEpuNVhoQitNRm51TXppRGd4S2ZpcHRReDJyV1cya3E3WlJHTW1sejhNSHlK?=
 =?utf-8?B?Q3NZalRsektadkNnOW0zVTRwMStwZnYxZitPcVNmNWdnUFRhSWl2ZThPYnFa?=
 =?utf-8?B?czRURmJGZGNHSTU5WHRsa1IyNVZJTzBZMzNIT1J6UHcxK1Fwb1dHTDQvNVlr?=
 =?utf-8?B?UGJOU3NRem1LY1JKeVRCWFEzby9rcXVQeTlSMTduQ2I5NnY4T2RRSXlqYWRY?=
 =?utf-8?B?dUVvcXNHVGFmTncvdlcxRVZtbXBDaC9iWjJLcHBOcDdsWGZTY1VRK2JDVlBx?=
 =?utf-8?B?bzNiRy93SkZZTXMvZ1ZkWWhETTNLSUttMTRES1lPT0xwRDBHQk9sUHdIVnpu?=
 =?utf-8?B?RGFxY09hR1JyQzU1bkZlc1FpUCtGemRZbmFrYUVadU9JWW1ZcVdwZ0tjWEJU?=
 =?utf-8?B?M0IzcG5XVXlHYWZCU0JpZHh2SHE1WDRYdHhSVmM2a0JmL1BweUZQUzhDcTNJ?=
 =?utf-8?B?MXhwVVEyUndLS3ZYeXlGZ213YUVuajdQQmkvczlxSDVLS2FHWk1BM3hGTjdU?=
 =?utf-8?B?T0FxRHVRK3M3bHdXUWxvdEpBVVhyeWhBd2RHZmFDZDBTaUpMV1FkUm4zUGdv?=
 =?utf-8?B?YTBOcDE4SG82eTlld0hWOCtvVUdsT2FSd2ViVXI5TXExUm90MWp4Rk1oNjhI?=
 =?utf-8?B?RmRKZzBPUU5kZ2srOURlN2NCSGtLY3l1OEhZeDNQaEg0dXN6aFVNNWE5QWhQ?=
 =?utf-8?Q?G9zwJukcXGemZSu?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763051ca-d489-4c37-93a3-08dafd606642
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 16:39:30.0047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WC3Xk7j9WQ41EXCkrOYECnxda4gEM7q1tZBcNCp04kQb3Iql4SvzCvQSspe/D/5ETP+Plq4qVBr+AJgDTroUVVElcqUGFUmlAz6NsDcFB3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6917
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjEuMDEuMjMgMDc6NTEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBDdXJyZW50bHkg
YnRyZnMgaGFuZGxlcyBjaGVja3N1bSB2YWxpZGF0aW9uIGFuZCByZXBhaXIgaW4gdGhlIGVuZCBJ
L08NCj4gaGFuZGxlciBmb3IgdGhlIGJ0cmZzX2Jpby4gIFRoaXMgbGVhZHMgdG8gYSBsb3Qgb2Yg
ZHVwbGljYXRlIGNvZGUNCj4gcGx1cyBpc3N1ZXMgd2l0aCB2YXJpeWluZyBzZW1hbnRpY3Mgb3Ig
YnVncywgZS5nLg0KDQpzL3Zhcml5aW5nL3ZhcnlpbmcNCg0KDQo+IGJ1ZmZlcmVkIEkvTyB0aGlz
IG5vdyBtZWFucyB0aGF0IGEgbGFyZ2UgcmVhZGFoZWFkIHJlcXVlc3QgY2FuDQo+IGZhaWwgZHVl
IHRvIGEgc2luZ2xlIGJhZCBzZWN0b3IsIGJ1dCBhcyByZWFkYWhlYWQgZXJyb3JzIGFyZSBpZ29y
ZWQNCg0Kcy9pZ29yZWQvaWdub3JlZC8NCg0KPiB0aGUgZm9sbG93aW5nIHJlYWRwYWdlIGlmIHRo
ZSBzZWN0b3IgaXMgYWN0dWFsbHkgYWNjZXNzZWQgd2lsbA0KDQpzL2lmL29mDQoNCj4gc3RpbGwg
YmUgYWJsZSB0byByZWFkLiAgVGhpcyBhbHNvIG1hdGNoZXMgdGhlIEkvTyBmYWlsdXJlIGhhbmRs
aW5nDQo+IGluIG90aGVyIGZpbGUgc3lzdGVtcy4NCg0KU29ycnkgZm9yIG5vdCBoYXZpbmcgc3Bv
dHRlZCB0aGVzZSBlYXJsaWVyLg0KDQpBbnl3YXlzLCBjb2RlIHN0aWxsIGxvb2tzIGdvb2Q6DQpS
ZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNv
bT4NCg0K
