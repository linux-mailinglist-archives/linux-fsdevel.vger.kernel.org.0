Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3712A7A9A59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjIUSie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjIUSiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:38:02 -0400
Received: from outbound-ip179b.ess.barracuda.com (outbound-ip179b.ess.barracuda.com [209.222.82.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E17DA23A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:31:56 -0700 (PDT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176]) by mx-outbound22-111.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 21 Sep 2023 18:31:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEhPgxmRSDD9DJSXqOoe63hOfixw7AjlbSr3Rj9wIAydZ3fSongOwt23SD5nj2Rxz9aW4qz+Ww29gE11EsH0I22WB6B4sFW8Gq6R51Wv6VEOIe9DEfAGW8cwFIcXQ0i8WVzmaCYWSWG1v+bCoCTXChh3xf/AH/t4D8HuAjLqY84zDHhwQtCnX7ld4BRBXo52Gn9ovFo/zhsFT8bdd1nYhr2EmQjBJUHEtetVs3UPijCzBZVxwvOuZ4ANYbefxexytjZv8ol+rziRTtT+lyXoPXupvS6i1hX2U77XqaFvsDS5VQe2ygDwmaMNrphCMyLPXGaUCP8dP+BPGsVVHd1C1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QadG6L7ihYPLOU4fpzJS/IrGopSPWd9sYZjaRdmSgME=;
 b=dc6KuJlBL3u1xtR+c1WE3H3t7UsFEvsy/tc9KJF7kCT5X5DYBLEKgE+ajlIoPGLuZdBq7SYuBgt5n5UDVV7rzYJLbEu2XvSZP4h2gCyrm5wehCcazaW756utc71vmvD3ni/xCmdC5GHnx+TP0JJs7HXoqAhTaAElrCmZrcGV6GM4ZL1Jf95vigwnzcw4a8OMtfj19LcyPox+NLUgNVy7GQs2fzo0VxSLUNnv5CRvss0cToMFEhGdxpSRD8Moc2bdoJwqF5VSwbUwjBvZ2F8xaknyIml4PljDF5h2yUZIGp0Kqnz5ZlSAu6bKpdQqE64o9LSbb4lNzsa2m/HWl+K2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QadG6L7ihYPLOU4fpzJS/IrGopSPWd9sYZjaRdmSgME=;
 b=rSnQRKVWBsxTrO4YtJNn1/Ob8TAl/mqIn8xCFWu9xDuOxx4PaFOY++XCi3clRkEt2pg4wFwo5nwCcV+ntjtzhpHH86F0LwPMGGkqOkA3xzAhvjyFWU2Zn1ClV7MM6INhL4SVT32exnmf+CuQCpUsvY4FERUz9SxO84pGvD98jZ4=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MN2PR19MB3792.namprd19.prod.outlook.com (2603:10b6:208:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Thu, 21 Sep
 2023 11:59:56 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 11:59:56 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH v9 0/7] fuse: full atomic open and atomic-open-revalidate
Thread-Topic: [PATCH v9 0/7] fuse: full atomic open and atomic-open-revalidate
Thread-Index: AQHZ6+jEYlTrORG1zEyLLEqnUpvw2LAlBaoAgAAoygA=
Date:   Thu, 21 Sep 2023 11:59:56 +0000
Message-ID: <b22b8760-fca0-4251-b1a8-5989c26e1657@ddn.com>
References: <20230920173445.3943581-1-bschubert@ddn.com>
 <CAOQ4uxi+jk7rv7mtnpH4RXbZJx6N+cWecqd3UyJJHsW8yw_SXg@mail.gmail.com>
In-Reply-To: <CAOQ4uxi+jk7rv7mtnpH4RXbZJx6N+cWecqd3UyJJHsW8yw_SXg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|MN2PR19MB3792:EE_
x-ms-office365-filtering-correlation-id: 81fc980a-c5d8-472d-a512-08dbba9a460e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SiXWYBd1K27rMRoyqM61P9oxtcyYJ3Fb7+Mf/ad5VO94RYm5W6qaxdsVG/9joeFo8q50xhOpqHuQlHbFa5Mrg/eDkYQA1sUpeRNJdemBsVCKzvfQGlB6/20hPeOdt6LSyYMN585PKhtHAkmsVJyoUaE+ZbZayAqnl33+p4CEOpZpBOpIPPdfB66tPrYxQRx+JkcbpjxmahA67pmspnD5FCfFtR90p5VrcO1mCTXxtmHkqY0l5mANjYOVyQpENy7AZWCtmTwB5Nr/AXDNdVPfu1tY1bf142nkHVWHAuGRG2mUHQUWLxSgjlVml/w8mSTwRQ7bauVb/8HmDaMHvtfeRmAqIIbkgy/SgyFQz1W07o14b2C1QA8IlA+WpJFSiSbwPrgtdmZN1MQGv5ZuXgiX4jMHw/qkHWctkyGVKaLi17VDysI3nwgm699Vr+lwLVGZm2LoZ4rC2fdf+2XdTeTWTQEVRqJd4LOa6LA9lOLMPRbPZBh5ZlskN39+9nQd6ohBugn5orsvrT6BTZNtPJOysJi3es83JCyRCP1WqCvAlG413D1kfOGeiIEAhv+DMMhfpYljyCfOtV1uDkRedbcgJUjIvT2+HA2of4AgYzydtsZoYZsP5Dr1+VNec4tuzbI92Dxv/CA7s7MIsMBR9/RGwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(136003)(366004)(376002)(1800799009)(186009)(451199024)(478600001)(53546011)(6506007)(6486002)(91956017)(83380400001)(71200400001)(966005)(2906002)(4326008)(66476007)(5660300002)(66556008)(66946007)(76116006)(6512007)(64756008)(66446008)(2616005)(54906003)(8936002)(41300700001)(316002)(8676002)(6916009)(99936003)(36756003)(86362001)(122000001)(31696002)(38070700005)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1hzOGk3ZHlLY1M1N05oWm1qZWM0NDVJaEpFMlVxNmdoUWRPL3F4c3JiSVVa?=
 =?utf-8?B?bUZkTnpEUUJzaWVQcmtUaFJ2QklseUlpOTNQMzl3b1Q5NVFEd2RUZ2RrV1kv?=
 =?utf-8?B?eFNXZS85UHN1T2Zvd3hUaDUwVzJxbXZKaTJoY0E5aHlzRmFqZXhUUFpqM0lx?=
 =?utf-8?B?eXdvb1NWVEtmVkNmYWJIMVQrdW94RE5OOUE3aFgxbUpGUjN1QU4xa3VmaU9R?=
 =?utf-8?B?Y2psbmRmWVNrQy9FZlRvbEZDZUFpN1IyaU50WDZCQUVVc3YySWdvUUQ4UFdE?=
 =?utf-8?B?dURQWVpPRkZZK2RlYmFHbXFWbUlqdEw0dDJ5NHg1UVl6QTYyL3BqM1NiTFhz?=
 =?utf-8?B?VEVDaHN1eHJaem8yV01UM2JVYWd5OWNkZ29vR1JiUEJVbkQxRTVvRGt1V0R5?=
 =?utf-8?B?dzVoVXZhMnB0M1NUeGk5YVpkdWRWZTF6blM4YjBDdEtKVmx3QmlMeDhHRWI3?=
 =?utf-8?B?K3B2aktvbnhhMkQ5dlYwVTJkellObmtnTnRWa0xpYkxWUWJ1OWZJS0hnUmpE?=
 =?utf-8?B?ZnM2Mlpqelh0S3lISDVBU05IWWlkTnBCem00dkdhYnpPU1JFdDByNWxvbmVv?=
 =?utf-8?B?c0tUMHdxUkV4b3ByNVEzWnBPbVp3K09GSEVXMldJWUVGc3ZqaEZTTWh2ekdO?=
 =?utf-8?B?UnVmcHFRbUVpVytLWk4yY1NPWTBXRUhsWmJBTHNyUlBHaHZNYlFCZkRyZ0Ns?=
 =?utf-8?B?dmNWTXJxM0JLZWJCeEU0cnBWdnloMTlxK2xsbGw0Z3pTMFBhZEFna3NVTHFa?=
 =?utf-8?B?SVZPcTBtWk1wQXpPYnhiSThqbmZWRG9hd1Z2YjVSQ1NDVW5NYlFhVzQ0R2hu?=
 =?utf-8?B?Uzl4bUVUS1I5bHBTakd2YnZKNURYOTBhVnphVVovU3FzYjFJU3V3OWorWHhH?=
 =?utf-8?B?Qk4ya2oyV24zWm9GcUJobGpHK3Rrc2ROSFJTWXNyR1QwQWZkVTdMMEtSL21s?=
 =?utf-8?B?bkZYRVgwcFlMZjZrZ1YxbXN6YzlablYwUjRKWWVJRk1zVFBWVFhEWXlpcmVC?=
 =?utf-8?B?aHF1KzAveDIyemFTWko2M3BwSFNiUEtVcElQN3BBVHNNdllxbWZHRTFVeU5o?=
 =?utf-8?B?M2lpdDJGVllLT1JINm9pRUFEZTFHbCtLdmhFcnhMNms1KzgwaXJxTlJ5VDFF?=
 =?utf-8?B?Rmdza1FoWFdMbXpiY3VvaXRjcFBaTTEvdjVSelR4YkV6cWtmSlFUeWJEZyty?=
 =?utf-8?B?anVwMkpCZnlUWTJHRVVIMXhzU2ZPMDN2K2ZLbmhnWlJvSWlGbzV6VFpFOXVF?=
 =?utf-8?B?ZXpDMTRya3hDczdEZ0ZyTFRmaUM5a2h5RzZ3Mi9RaEw5OXEwNWRwNC83enlv?=
 =?utf-8?B?UWtqWjFIcFlGVUtuYjg3ZmJGdHZWa3NYaDdjL1JneTNhVk9jTG4vN2EzMHo4?=
 =?utf-8?B?MmYrL2M1L1cvcXg0R0RpL0NaOHhPa3k1aTVhemExSURaVUhmOVdMdUJlK2g2?=
 =?utf-8?B?Z0lRTnJ0RkJwc0JVd2ZXQjdKNzVITDVSUkhIbEM0NWNsWE9PamxIdWIxVWkv?=
 =?utf-8?B?LzU1czh2ZWZvUXIwcEdrSUJ2d1NHTWVsSFdaK0NRbnVhWFVXYWFCK0c1clRB?=
 =?utf-8?B?WkV0MjVxQWdXcGRXQ2ZYM3JJQk1SME1oUGlCOG9rUVFoczFtWWk1NVN5Mmpo?=
 =?utf-8?B?VGhrbGlHZm82V2h4ZkJMWTFNd1Ywb1ZtbDhldFZqUDJoTjVVTEF4Rld1enZI?=
 =?utf-8?B?Qk5RL2ZHS3dtRFgrMW1EQUlieG9DK2Q5TlRhY2x3K01NdjlGQWM2RmZ3eXh6?=
 =?utf-8?B?TDNvU2l1N3Nla0FEa3NxdlNmdm9rV0x0Qk1oNDhkdzMrcmdNb3p1K1FESHJZ?=
 =?utf-8?B?VmRERmFBMnhTcXVBYjJKTTVQZ2QvaEVyWUJKNWxLaWpJSXlpRWhZRVRWVW1Z?=
 =?utf-8?B?MFRPNjJCTDlJODYzL09vUGhpUzZrYmVBakdhUkN0WENRUkRSTGZpSGpNeUJ5?=
 =?utf-8?B?b3M5ZFpTT1pDcitMNXJOWjFFU1VwdkJJSjM4ZGdVZGpJNlY1ajJmSENRaUVB?=
 =?utf-8?B?NGF3MWtWcng2RVFYbnFpUTI0SWMrb2ZWbHFKTnJWRi9mbW9VTExwM00yRGds?=
 =?utf-8?B?dkRsaHd3bmdsWEVSZm95QXNpK3RYNlFoU3RmUFY4K3J3V2dIa2lVV0dscVgv?=
 =?utf-8?B?S3VLQmdBU1lVRjFpMWpwbzYrd2VHOVZELzVObXBRSmh4L1BMNGZlN2dFQm0r?=
 =?utf-8?Q?JBWss0ABCn7dWEJDiHFB0z0=3D?=
Content-Type: multipart/mixed;
        boundary="_002_b22b8760fca04251b1a85989c26e1657ddncom_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aUtQTVZUcWVaR1lNQVFzZ05YWTlSMSs1a0ZxM1pOT0hyYlJodzN4YU83YnQr?=
 =?utf-8?B?RGs2RkdaekNBdXBSa0l2U2t1bnoyODJVcWJpUW0xQ0RlVmc3SFRVbVpqdG9i?=
 =?utf-8?B?TFBILzhNVkdFOTFyaWFQbXNSdUpid2M5WWxwUnJsamhmWGRycGFQWURUbE1S?=
 =?utf-8?B?WjFqTExqNGZiUHN1M2pHZ3RtOHNzYW54K1ZSanFOa0Zmc2UvVFdBOHpjUmMr?=
 =?utf-8?B?T2hFckdtb3cvd2NwUUlUbSsxN2xoWXpwTmZjRkpnL0J3Z25oMVR6MXh5VDJo?=
 =?utf-8?B?YU1PTlg4RFhXR1lBWGJjSzV6d0c0ZzlDQUlxRENZNVh5a240VVA1VE5FQ05F?=
 =?utf-8?B?RWhrbGVFWmp2K2xDR0llSFVQMi9idUVZbkxDaXR2L2hOZkRTTUgwL3ZvOE1B?=
 =?utf-8?B?Y09kQ2FneWZOVjk3OVU2NWFSUEY3RnZPN2MwZFc0SFZTcnduc2doVCtBNFVw?=
 =?utf-8?B?ZTVDMXg0U1JHcFpkRjVoMG5qeElpME5QbEEwNG9CTmduNk5xUWRyc3BmNXpR?=
 =?utf-8?B?K0JDdXI5SzVqSzF6a3BlVDF0MTB1NTZXSHo1RnJSbHY5NFd1T1NlVWZlNE1h?=
 =?utf-8?B?VzlialdMdnR4djlmeUw4YmRhdW1JVWF3aGtjL1NwOU5mank3N3RPeEJJZmZ1?=
 =?utf-8?B?Q1hUUVNHT2FLZ1dnbXhtU1lieUN0RHRMQVVXRSt2VkN1L3VWdzJzd3RialFu?=
 =?utf-8?B?NFRjdHdrNUJxcU1mNjBIVmYreUVCcFRDcVlNSUZRWU9wQk5PV3ZLQVNLbHB3?=
 =?utf-8?B?UG1PQUI5OUVQSkE0dXdLTmQraVJSQmt2ekJrbC8yWlRsTElsVjcwYzBMYUVJ?=
 =?utf-8?B?OGRNbWU1ck03QXhkUVFQbkxHQ3BiRm9FdThwWW9mWTRGd1loNUl0cm0xcUdk?=
 =?utf-8?B?UVJrVHJLbDE1RUZvb1lCTURReDh3QTVMc1paSVF4d3NwM2NSTVhFcnJ4WlRQ?=
 =?utf-8?B?aDVwUXhKUStGY1Zxenh4NzU2Wm56eFVlc2xYZVQwRHhaS1dDVFNPTVpEYUVz?=
 =?utf-8?B?UStMakltbXBZZXpucWlIWU5neXJxSnJyUzREWXZ5cE9XcHRldGdlclNBdmo3?=
 =?utf-8?B?LzcveWRoMnh3eWlUbDVrZ2tlT2NVM1FsSGsybitkaldRTUJGMUtyZ2RnWTdJ?=
 =?utf-8?B?R1MrUUxEc1h6UnNVVEQyMzVhOHB1MzdFOVl5dHRCSC9MbGp1RW4rSnpCOTda?=
 =?utf-8?B?RGg3N1cxNDZROEtPN0NaYndFZnNvNmZsS1ZiUDd5NmdCVUMyVWJnWnFMYVpp?=
 =?utf-8?B?MHUvYTJsUHRrczRNZjllUUNWT29OUmdKYUNWK21tUDMzaUNmK2h5ZlRUM2JY?=
 =?utf-8?Q?VsSw4VkWXSV9Fnx6X1UiBT3e0L8chLmZol?=
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fc980a-c5d8-472d-a512-08dbba9a460e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 11:59:56.5736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5z4SYj02kw+VWpNwGrrzVxNZx/zJzBpLFrJ19xxCvN02LRIagCZWqWhVm16jifM+xCicPuDqEE9Hq/psi/WIYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3792
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695321114-105743-12328-24428-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.56.176
X-BESS-Parts: H4sIAAAAAAACAzXLuwrDMAyF4XfR7EFWJFvOq5QO8o1AIB2aQKHk3eMhWQ4/B7
        7XH9pvhxn2sQ4+X5gpeBm1jDMnU0mMHTV3zFKjN4zcMHCyHguc7vHHtt5ePdPtCwarVY
        yUJFeiIZXDVNjIktcI5/sCpeQfcoEAAAA=
X-BESS-Outbound-Spam-Score: 1.51
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250986 [from 
        cloudscan8-158.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        1.10 DATE_IN_PAST_06_12_2   META:  
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 DATE_IN_PAST_06_12     HEADER: Date: is 6 to 12 hours before Received: date 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=1.51 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=DATE_IN_PAST_06_12_2, BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND, DATE_IN_PAST_06_12, BSF_SC0_SA085b
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_b22b8760fca04251b1a85989c26e1657ddncom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <41E8F48CDAD62648AD2C5D0892AF1111@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gOS8yMS8yMyAxMTozMywgQW1pciBHb2xkc3RlaW4gd3JvdGU6DQo+IE9uIFRodSwgU2VwIDIx
LCAyMDIzIGF0IDk6MzHigK9BTSBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+IHdy
b3RlOg0KPj4NCj4+IEluIEZVU0UsIGFzIG9mIG5vdywgdW5jYWNoZWQgbG9va3VwcyBhcmUgZXhw
ZW5zaXZlIG92ZXIgdGhlIHdpcmUuDQo+PiBFLmcgYWRkaXRpb25hbCBsYXRlbmNpZXMgYW5kIHN0
cmVzc2luZyAobWV0YSBkYXRhKSBzZXJ2ZXJzIGZyb20NCj4+IHRob3VzYW5kcyBvZiBjbGllbnRz
LiBXaXRoIGF0b21pYy1vcGVuIGxvb2t1cCBiZWZvcmUgb3Blbg0KPj4gY2FuIGJlIGF2b2lkZWQu
DQo+Pg0KPj4gSGVyZSBpcyB0aGUgbGluayB0byBwZXJmb3JtYW5jZSBudW1iZXJzDQo+PiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjIwMzIyMTIxMjEyLjUwODctMS1k
aGFyYW1oYW5zODdAZ21haWwuY29tLw0KPj4NCj4+IEhlcmUgaXMgdGhlIGxpYmZ1c2UgcHVsbCBy
ZXF1ZXN0DQo+PiBodHRwczovL2dpdGh1Yi5jb20vbGliZnVzZS9saWJmdXNlL3B1bGwvODEzDQo+
Pg0KPj4gVGhlIHBhdGNoZXMgYXJlIHBhc3NpbmcgcGFzc3Rocm91Z2hfaHAgeGZzdGVzdHMgKGxp
YmZ1c2UgcGFydCBhcHBsaWVkKSwNCj4+IGFsdGhvdWdoIHdlIGhhZCB0byBpbnRyb2R1Y2UgdW1v
dW50IHJldHJpZXMgaW50byB4ZnN0ZXN0cywgYXMgcmVjZW50DQo+PiBrZXJuZWxzL3hmc3Rlc3Rz
IGZhaWwgdW1vdW50IGluIHNvbWUgdGVzdHMgd2l0aA0KPj4gRUJVU1kgLSBpbmRlcGVuZGVudCBv
ZiBhdG9taWMgb3Blbi4gKEFsdGhvdWdoIG91dHN0YW5kaW5nIGZvciB2NykNCj4gDQo+IEhpIEJl
cm5kIQ0KPiANCj4gSSB3YXMgdXNpbmcgeGZzdGVzdHMgdG8gdGVzdCBwYXNzdGhyb3VnaF9ocCAo
Zm9yIEZVU0Uga2VybmVsIHBhc3N0aHJvdWdoKS4NCj4gRllJLCBJIGhhdmUgbWFkZSBzb21lIGlt
cHJvdmVtZW50cyB0byB0aGUgbW91bnQgaGVscGVyDQo+IGluIGxpYmZ1c2UgWzFdIHRvIHN1cHBv
cnQgcmVtb3VudCwgd2hpY2ggaGVscHMgcGFzcyBhIGZldyB0ZXN0cy4NCg0KVGhhbmtzLCBqdXN0
IGFza2VkIHRoZXJlIHRvIHNlbmQgaXQgc2VwYXJhdGUgdG8gdXBzdHJlYW0uDQoNCj4gDQo+IFNv
IGZhciwgSSBoYXZlIGFsbCB0aGUgdGVzdHMgaW4gZ3JvdXAgLWcgcXVpY2sucncgcGFzcyB3aXRo
IHRoZSBiYXNlbGluZQ0KPiBwYXNzdGhyb3VnaF9ocCAob3ZlciB4ZnMpLg0KPiANCj4gRG8geW91
IGhhdmUgYSBiYXNlbGluZSBmb3IgdGhlIGVudGlyZSBxdWljay9hdXRvIGdyb3VwIHRvIHNoYXJl
IHdpdGggbWU/DQoNClBsZWFzZSBmaW5kIG15IHJlc3VsdHMgYXR0YWNoZWQuIEkgaGF2ZSBvcGVu
ZWQgYSBsaWJmdXNlIGlzc3VlIGZvciBnZW5lcmljLzQ3NywNCihvcGVuX2J5X2hhbmRsZV9hdCB0
ZXN0cykgYnV0IEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIHBhc3N0aHJvdWdoX2hwIG9ubHkgKGl0
DQp0cnVzdHMgdGhlIHBhc3NlZCBub2RlIGlkLCB3aXRob3V0IGNoZWNraW5nIGlmIHRoZXJlIGlz
IGFuIGlub2RlIG9iamVjdCBmb3IgaXQpLg0KUG9zc2libHkgZnVzZS5rbyBwYXNzZXMgYW4gaW52
YWxpZGUgbm9kZSBpZCAtIHRoaXMgaXMgc29tZXRoaW5nIGZvciBhIHJhaW55DQp3ZWVrZW5kIChv
ciBzbykgdG8gaW52ZXN0aWdhdGUuLi4NCg0KDQo+IENhbiB5b3Ugc2hhcmUgdGhlIHBhdGNoIHRo
YXQgeW91IGFyZSB1c2luZyB0byBhdm9pZCB0aGUgRUJVU1kgZXJyb3JzPw0KDQoNClRoZSBzaW1w
bGUgdmVyc2lvbiB0byBhdm9pZCBfbW9zdF8gb2YgRUJVU1kgaXMgdGhpcw0KDQoNCmRpZmYgLS1n
aXQgYS9jb21tb24vcmMgYi9jb21tb24vcmMNCmluZGV4IDc0MTU3OWFmLi5hNDBmY2EzYiAxMDA2
NDQNCi0tLSBhL2NvbW1vbi9yYw0KKysrIGIvY29tbW9uL3JjDQpAQCAtMzA1LDYgKzMwNSw3IEBA
IF9zY3JhdGNoX21vdW50X2lkbWFwcGVkKCkNCiAgDQogIF9zY3JhdGNoX3VubW91bnQoKQ0KICB7
DQorICAgICAgIHN5bmMNCiAgICAgICAgIGNhc2UgIiRGU1RZUCIgaW4NCiAgICAgICAgIG92ZXJs
YXkpDQogICAgICAgICAgICAgICAgIF9vdmVybGF5X3NjcmF0Y2hfdW5tb3VudA0KDQoNCg0KVGhl
IGJldHRlciB2ZXJzaW9uIGlzIHRoaXMNCmh0dHBzOi8vZ2l0aHViLmNvbS9rZGF2ZS94ZnN0ZXN0
cy9jb21taXQvMzNhMTVhZjA3YmIwNDRlMjc3M2E4M2RmMWM3ZTBhMGRmMjgwYTRiNw0KDQo+IA0K
PiBOb3RlIHRoYXQgQ2hyaXRpYW4gaGFzIHN1Z2dlc3RlZCBhIG1ldGhvZCB0byB1c2UgaW5vdGlm
eQ0KPiBJTl9VTk1PVU5UIGV2ZW50IHRvIHdhaXQgZm9yIHNiIHNodXRkb3duIGluIGZzdGVzdHMg
WzJdLg0KDQpUaGFua3MsIEkgaGFkIHNlZW4gdGhlIGRpc2N1c3Npb24uIEFsdGhvdWdoIEkgKHNp
bGVudGx5KSB3b25kZXJlZCBpZiBzb21ldGhpbmcNCmxpa2UgTU5UX0JMT0NrIGFzIHVtb3VudDIg
ZmxhZyB3b3VsZG4ndCBiZSBlYXNpZXIuDQoNCj4gDQo+IFRoYW5rcywNCj4gQW1pci4NCj4gDQo+
IFsxXSBodHRwczovL2dpdGh1Yi5jb20vYW1pcjczaWwvbGliZnVzZS9jb21taXRzL2Z1c2UtYmFj
a2luZy1mZA0KPiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZlbC8yMDIz
MDkwOC12ZXJmbGFjaGVuLW5ldWRlZmluaXRpb24tNGRhNjQ5ZDY3M2E5QGJyYXVuZXIvDQoNCg0K
VGhhbmtzLA0KQmVybmQ=

--_002_b22b8760fca04251b1a85989c26e1657ddncom_
Content-Type: application/gzip;
	name="xfstests-unpatched-6.5.log.2023-09-19-213432.gz"
Content-Description: xfstests-unpatched-6.5.log.2023-09-19-213432.gz
Content-Disposition: attachment;
	filename="xfstests-unpatched-6.5.log.2023-09-19-213432.gz"; size=8142;
	creation-date="Thu, 21 Sep 2023 11:59:56 GMT";
	modification-date="Thu, 21 Sep 2023 11:59:56 GMT"
Content-ID: <04C57D72B615D443A68F1B32779D001D@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64

H4sICI0rDGUAA3hmc3Rlc3RzLXVucGF0Y2hlZC02LjUubG9nLjIwMjMtMDktMTktMjE6MzQ6MzIA
vF17c9s4kv/78imwc1uVzCSSiBcfupu6zWSS2dQmcc72zGX2bstFiZTNskxqSGoST+2HP4APCRZa
Fkggm0oc84EGCPYL3T80z7d5nuXXaJmgqlzOvqyqOq3qapKkvz85765V26RA09nyJl3eoslqW6Vo
skCTT+g6zdMyW8587j15c3H560fU/5lMkLzvycd3Ly/fnJ2/3519l+XbL7MvoX/lM1T9tk3TP1KM
/CmfeujfsUfQxfuP6HKboot0g3CEcDCn/pww9PPlK0Q8Qp+8/9ubi6uzj5dvzz5cNCTzIidP3p/9
/OFyd7o7i2Z3eT2rlmVcL2+ePOmH63kYhV6FptMpQgGvlAsE8e78g9O0fyxUbOvNtkZ3WXUniaJn
VZqi2U1xl87kAzeTNzucyVmZVtu1uDBTSE4FqekiTr590k7NBLWND275N/nQE4+IvwjzOQ3mhE4J
5h6nOCDouYc9r6Hw/Plzu4F0PUUTMe0Ey2mnZMo4wWHEGBM9ka6nv/wFTfAL0Td+QQNx1JxE//2y
n5xlmcZ1mqDFPRLk28HJMc3RNr/Ni885KjZ1VuTPqm/n6OmkQGW6juvsLn3a3ru9K7Z5PW9eofyJ
mmO0KTLxs9qky2yVpcl0OOG72yQr52gZ53nRDxOJU+myLsp79FRll5k4j5/O0ZtsnaL0SyZmcMTo
qjqudx3Kgy9AL7OV6EP29aEQsiaYSh6jotwPrSEm2LL5/5mQS/Q0yVYrNNmefuUgV9lxylOEajFU
wfn1jZicvBbjRHJA3yoywzqZ+V/56OU2/wc6u7p8//HN23evUVahZkK2m01RClZRmvGdBDJVAn1E
aXde/KJcCFBEugthpF4IUdCe3w9APOBVVqDVH2lZILSKxTQn6FmxTtBtWubpeva5LIS+W1X/pT5I
pD3IKDrY0+icfAnyRLKQx818LbbZulYoYkRY9+xEnRRMjg55s80FgxmPmUrCUA9MqIj+Qqhe4FrX
UoKqe/FUd41NePjmUZajq04Yru5uxSir7A+VIbDv6lmCo4Sy9C7emBMKNUJJuirj6zshCbHUPweP
uBKiLN7q/SZF38gZ+GZPi/RM4c6yEO+kZWlvgS0LjTxOPD+ytyz7gRxYFubNqTf1oiDijDB8YFlo
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

--_002_b22b8760fca04251b1a85989c26e1657ddncom_--
