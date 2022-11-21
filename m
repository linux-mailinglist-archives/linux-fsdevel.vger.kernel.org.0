Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE428631BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 09:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKUIqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 03:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiKUIqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:46:20 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7A362070
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 00:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669020377; x=1700556377;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=UqQ0DHOrhpW7XRNSW4tR/p1semQ9DBxVSHgGcZpQfQt/wA4Yux3jREUl
   tsgQUhkoD1rMBpFnXx5dHDNtSgBzuIpokW9/ZEeMWP29LAO6ehX5IglGX
   EQqU1qL762u6rmLcLHlUwIDIBeIeAMAuSm+avxwB47cGFrP5KrPyxUR65
   CXbWrtwyWWWfIHckufJkwi/j0ylUyOCzNBcuuyjaaLiMdmwspoG4rDSqg
   F4WOFU/gYMsWMCEa2vY9Ba3t/Q+d3ZntDs+HED6xLXVWPHb/M3tzPKdnR
   j+5LIthtqNIm2wCqYI+qlwBXVDVyqM9PMQFtmtNhBTnKI0BwrFzEJgGHJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="216772662"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 16:46:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFl35BsjXZ9G+bF0DChM8obGuwFRtgfVblit3Xgf7JFT0KMDgRYz3uClAmRIqQi81ObkRQEqF4vfVo1+hMgL1XHV+qwWncWRocTkP2Y9BXfaxHHUpYNU48t9EmMqwoN7IgQHYNG/Wji6V29LAmj2GwcvI4AnmXz3cczWLxxwVxWs/8fkjyBirA7YPhl4stVC+iGlesPab+MUVPUY97S6xbXYCxswBI+xkQ4w81X/5sG0DPoj6ItUs0Pa9Yq1XmFiepMKRXCNXqbI0pmikYyMIYeduL3rU6UwixciM5zNG2AzNXevq+qmXg8hBpGeL+d+0tiW07PZSPJNSvXm1Vsu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=IrU+8/u93wblGv9vhl4vBLsnCNvfmIVgzMxi0OkHYss1k5q97D8sRv51UOu18Lkg18tLMO3LuZxW3Pr8vQDxJgGMRUsf2mLQRMcuPEpyWI9BjyQ1U3l3OKlx3/8CCTO8y07twCMvdY/UV54lMXZJxjCZ8EQCVzr3H1dp0PXX+1bWB7gISC4OCL1+OcAKR3JiA5d45FqSbIGNl8GdPUkgZwqabvuTGmLWvMdjF6X3R4wj0feCo8OnBWlFxBC4uT5kB4+NF0XPdbLTdAUi6JUzaYwvkDoWpIr7eRFsealwxkhRtYsky0SHGvcYSSgOZqPkNEb9yPNXe3rRGQMsgEQrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=or32tHLwo5wfwVO/bAKtJZd/Z8ulMb0IFySv0nC2Lj2ziT20njbDgjHWZ/KJw6DP1xIX3/0LpGNIFfqxMFW12dS8KdIJYt+GmP2H14TD2TYxMar/ASKgSwbant2hQuEeGKJ+IK6IUfcA3sYBaGDZ9MItjE1ADKD6IufVrB4qLcM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6064.namprd04.prod.outlook.com (2603:10b6:208:db::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 08:46:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 08:46:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "jth@kernel.org" <jth@kernel.org>
Subject: Re: [PATCH] zonefs: Fix race between modprobe and mount
Thread-Topic: [PATCH] zonefs: Fix race between modprobe and mount
Thread-Index: AQHY/YW1YM8GRT3UF0q0GIDJDuJkew==
Date:   Mon, 21 Nov 2022 08:46:12 +0000
Message-ID: <fecccea3-ba65-2c7f-f80b-d3b3fd708745@wdc.com>
References: <20221120105759.2917556-1-zhangxiaoxu5@huawei.com>
In-Reply-To: <20221120105759.2917556-1-zhangxiaoxu5@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6064:EE_
x-ms-office365-filtering-correlation-id: ad621532-c102-4b5b-08b5-08dacb9cd83d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xN4xHWT9K1hIs0XQD3Kl+Qrniym85n/FK1rGYM0P6X6EcgrYINcQhEf56RRnnQ1G7nSSgoSLjKkQ5brIqyvcX2oPr8bycL3CI8RNKFvxk5vEVLCQYHr+/FEY5YakrWWsek66+/ahHz7aa3/5Mm0y1sTp6Mi2t+LbMuFr3gQn8zLHyvKr5qPHu0jzF70rawaPb2pMMC03D0BUEBYBkBQC71NtUmP2BJfX0XKw7kVS806yZbLOaYPoZiwGyJ8LTbJYrXaifCsf4kDnW3hHT0mPjgzcNnVZUmBi7YRW4r3FZ6cw3g6C3qFZIiAPeQ8TyDWPp0QlOHcCzVbsAypsrBgH5HIY4MYPyJ1tyMzL1Qrv8q8Huq9xzVMCsoajuEBFQUmh8/pzXU6PpMv6AAVY4otD1/z1CM0baSYk+sWv9aW0llhm70T5ggBdQPN40c4ns4IVKWmsZTMOYMHPBrocMZRU9CagvwytI6mgvJc+hzaf3JawagYM6Pw0ykfTI7562Iygh+Es8h+fbXzsToB7fCDhkEOFKYXrfhMATf+QL612OLtCL2NejdnAxzskeFx+jDOuV9JXGJyFiP65x2m/AOfRp15IZEntSIfnONWxXHhJ1lWI52cHZlXuYB96VGhoqx+QorVgVWA0aVVGraZoJIyXbfB5mzK4uBzz+plad7D+3LmtqcnheeYkEbWz1b/+ApMKoC9fGHmKEWDQbb9S1xeG9GKVUhddqzsQXrq7PgnBRErVMUdBH5nLlwx5q4mCZvNJQ/tJH7pKeR/7KCadB+4JvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(86362001)(5660300002)(31696002)(36756003)(8676002)(2616005)(186003)(558084003)(8936002)(66556008)(76116006)(64756008)(66446008)(91956017)(41300700001)(6512007)(6506007)(66946007)(6486002)(71200400001)(478600001)(316002)(82960400001)(4270600006)(38070700005)(66476007)(38100700002)(110136005)(122000001)(19618925003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmZVdVFHTkhPbjZGUTBINHl0VFlXZjRQV25zZUd5eUJSR3RlQml6dGxZOXpi?=
 =?utf-8?B?QWh2aGRRVExvdjdTRkNWR0NxZGVjb1lGY21UTjZZalkxeHpkY1hyZHg2TDFY?=
 =?utf-8?B?Yy9aUHY2em9zVWRCRmpWam43Mnlua25sN1k0aTYxRVhLNHVnQ2x1dmYzRldC?=
 =?utf-8?B?cTM0Y1ViVGhqMGRKcEdsd2xzaEk1dWlNY1UyeVFpWW1QN1p2N3ZXNDVyZWcv?=
 =?utf-8?B?a1NYb0Rmc21nUHpDRVpId1NmV2l1cUsrZ2Zwd0ZCYVUwaHY4Ym83ZzdJQVFy?=
 =?utf-8?B?SmJtV3M4RTIrbG5xcVV1YVFqSlBMNGt4SFdWMkFlSFFYejhaVXFkaWZJN3M5?=
 =?utf-8?B?bUtZMnVvMmM1TlFEZmxDVVdodlZhViszcm5BdklTeEtIU05nMzhSR3hEQWtt?=
 =?utf-8?B?L3VJWkpDMTA3VDZOVE8xZWorY2FDZ3g0TjgrNVBuUDE4Rk5WMjZTTVdVOFVU?=
 =?utf-8?B?NWhhMUtxSHhteTlxWnVOR2hiTHN0Q3ZiV0QrV3h3WXZubDl3M1hndlFNd2dy?=
 =?utf-8?B?cXJXdGdFak54UTQ4Y1VhQlAyeGh2RmxCRkxRRTNQMUxNcU9qUHZNTnVaeFYy?=
 =?utf-8?B?aDRxZFNGOXhPeTZFeUVUNW8rNno4eTk0cU5YbHJMK3FscjhpWGV3cDZjbHJ3?=
 =?utf-8?B?ZkRqL0lCME5adktzOWw5Nm8xVjRJUFd3SHJHMmlIbHhZS2dRU0VubTRYbnJn?=
 =?utf-8?B?aFAyS3VGNExQQkhtbEJ4eG1acVV5QXJEY29CWGdXMm1TTDZPbm9pb3JoSGlj?=
 =?utf-8?B?Vm1naktyNjFERDRES29LdDQ0dksycDcwWHQ0MlhKbjVCbU0zVG9tK0kyNVd2?=
 =?utf-8?B?VlV4WEErMitsZ281YVRpaUp1SHRRNkUxWW9kb05mZFlTRWtWVCtsYTFsc2lM?=
 =?utf-8?B?TXRJWDIxajFqUDM5QzJ1Y3ZwaFRvNnN5ZS93ZTBmNGFtT2dPVnFhS3Z0cjRj?=
 =?utf-8?B?clA4Yi91S0U4TjI5dFN4N0ZBdEZGRmJXTThHbk5mWnFTTVR6a0FibEd5akRK?=
 =?utf-8?B?SWhHQUNNTzBLaXJyZXRuZkFyQjFNZmtMUVdFYTdUSWhCSzdXN21jUlc0UTkz?=
 =?utf-8?B?M1kxOTRiU3U0OWlXenJsVVU2bUlXUjFjbUhETGM4SEdrMmJFMVdibm1hWGdz?=
 =?utf-8?B?WUhwb0g5Yis2a0VDd0hCOE5zV3hYazlNclFIcUo3aGY0emI3RFFIRDBRTTFa?=
 =?utf-8?B?S3pEVTJZLzhBL0pDM2xNbUVVL2cyTlBDbko0Vmh2Nlk0Z2NvbUdVN25CQ3ox?=
 =?utf-8?B?VmZPdDA1eS9aNjAya25DUkZhc2tOSjQ4OFdmNjJRb3VMRndPVWhmbGVSOTBO?=
 =?utf-8?B?OGtCOHZQdWFNRmFZNVBOcTZGYjVCT1VjUHNCVGdIVCtNdEZNTDVyZmcvTE9N?=
 =?utf-8?B?TDNQWmRlR2lxUlBiLzdYRHBCeTVmNThFTmVYbXVxRkJRLzR5TC8wTjZsejR5?=
 =?utf-8?B?Z2kwbTBERTdGbUh6QUNPM2VvZ3VkWjFCSEpDNE0wOWlSUWoraXRCMndOSDhq?=
 =?utf-8?B?bjFMSGxJcGlYSWtXQ1Z3QUJucksyWXRadDdzeUJ0RW1tSzBEakVYcU9PMlEw?=
 =?utf-8?B?WHhmL3lPemQ4MHZraFJZZ3ZHYnNWUkNMUmFrN1dCQ0lXdjZUbXM0T1lBLzJJ?=
 =?utf-8?B?OHZmeURMMU9reWg2NWhYcTdEZmd4VTNwYW8wS1lKYjEvT2s2RVZncFppMWlv?=
 =?utf-8?B?cFNiTVI3TU9sd01wM1BNb3BCbGRLdlBvNTJEMDh0ci9KZlJuRklYMmNmSVBs?=
 =?utf-8?B?S3NtTWhDTG1qc3FkVXFJNW1SN1hrWndOeUNPeVB4Q2k2anFiOEhVcElyblZQ?=
 =?utf-8?B?cVhoTEVrL3hsUnROK2cwMGlYd1FKVDkrM2lnQkJHaFVSUGI4MEJqVEhiY2tz?=
 =?utf-8?B?UjJGTkZQM2RXVGlUS0U2c0xZdFZyS1lyNTV1YjZUY0hSRG54ZUVqSjZFckNh?=
 =?utf-8?B?QW9MRFd1aHV3N3BpTjdGblExT0g5Z1BFREl0U3BSS2RUbmZ1bXBMRk0wOGZH?=
 =?utf-8?B?SGVLT2pVUFJ0R0NMV1hudkkvWm5uRDRDMFZ1RGY1VkFSTW1IR1IxZ08wR2Rl?=
 =?utf-8?B?ck5Sd0lmV2RWYXNIQ2RSNmpLSGxwR0lFZFhSenF1bVVEVFRyS2pvUmw2VFBt?=
 =?utf-8?B?OXVINDhZbTVvQStCdjJ0bUpoUUxrNElRdXZ5UE15MTA3c3p6aU40ZjJLcTdm?=
 =?utf-8?B?bjB2cnFTV0FoVFZrM0NZR0dZdTdTN0thaldtTGVicHJXa28rMFhiSEx1aHN4?=
 =?utf-8?Q?4YQet/vIP7aFBdFAC/mp60sDLveycGdLv8sD1JAORY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F0A91E8EAA9F2458B8D789847B58002@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /qWA/kgdonpvrHan9JsBXeUvy847fVH9iXUAWz1cLgrvTuOixOwbaR/LP8z05R3LCvpllIV/zyXJOgidOkSWiMcYAt/MVsohUrhwpCzeCXDcwe1lT88+80Fon4mrNZDFkmUYUlywHv7lk6eLGkMZ9dixdUTTe/nYdf+mnA/uVRnm/ILPS2lLzpCm4JvzJzNhmDNbZgOlI6cu/ZQuNWfh460TQ7n7I6uPfW3enm1P84VfnMSWEhaS9zIiiJq1CxHAxIfMBWEm6X7mImU4/nF66eMErhhBJVnsvL6kaljF3oIafGlkMmEkoqj8oKigQGHoE515438RKa9hOrZSQUqRM1bu439wyCzfdkOillcdsMPYmQJI3scXEIz9oDB8zW4tl0BjVtZh707osQurRyZciLJFBMQhRtRunEGf6RwR+yrMzyMAu/3mlj8jI70313aqcEGkkuwToxGaW9HfdTCGQ/g4dEpM1X/C3ReX35IieVLiVjBHZYAesPbFufwQM5rNwKYBT30BaYAuyOf+MdTI6ketMYHioXlrHL2KHtq/OUNrOjbwyxer5XXdCmybKMA9rZrGT4oMN2gg7jRusv+98g+JbNQ428JiXzYmcDkE3bVg0JlOhTJYNZo1RqtXwh8b5eU0ddPxSxcjoF7Do3eVR0O/JWycCOLumSC8frz6H6jUOL9EYJEt0al7QMIbmWPc6yzHpZaaRR9UZY6VtO8jP6ZC89BbWbZkxsnqsDBnXz3xjX01dsw1d9C0b5/cyTijoesh68PEoBPygRQCw8/K4XqXSY+gsOmJ39DB4Rh9dNUUJ/wKC7J3ikwXyr6Uo6H0fyICdAzKHoTtJIaN1/pu6g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad621532-c102-4b5b-08b5-08dacb9cd83d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 08:46:12.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCj6CLc8+pEDDvtfJO1zg5IKqSYgbgd+1Qj4Rvfxr8RjQFoOCwfzvsewqxM0sGYrHrnJAXa/kmg80rfBjcEoOs8jB2u5Sl86g+xL4ZXsAc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
