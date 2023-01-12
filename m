Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9F7666BA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 08:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjALHdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 02:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjALHdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:33:20 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250A4B7F7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 23:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673508799; x=1705044799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xaS0FFVd1JGlreX0LSm87aela6e8gI0oxUsyYC/i388=;
  b=K2u/sYaaDvMaqTLXjKo2RKnQDmWZnVIb+KxlrqTBAggwLpZMxyxR/QcH
   BxzqSr98YALbvyokVaDfotMw3wT6XNq9WELe/XCC/tiPfqraLhlIyJYNK
   dDBGong0kQK4Dx0UT84tB1ihUMX0SR/qPuKMygRw697rzC34qwXAbvEFH
   Err885bcnV4Ey20kIfKntrTVhP6PsVgL2dyPOZs0qjOMffFm1sd5nswv0
   w1DabE3wgjWnqHOkDwQvoqhUNs1+o/N9CjnXDGxTI97HweOdc3k7tJUqA
   dhrtQ/1iWnMaGJ/kgYVmAu58+XzHfEjoiw4Wsi4k1aSzaepbY16Xgjajb
   A==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665417600"; 
   d="scan'208";a="332607002"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 15:33:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgeI+grDgrQO9VedRGNsfDTOvZam2UJlYQLMS3hGBS1Iu7K2tX/5TS7d1ZPIo86sxQULg7NU7dbW8shkxSReR3EXnYFXhfuwjqp617GniqZd3u26EqGPNFHfY+CFXBYuaL827Vm0pPl0bwKK5HIXsVn5JYT66Lw1M5qf7NQqXW1cJb0SnaHiGIZla1LwsO/TR4OIq5nyMSx8shm3hdezanqPBIGRXMfKHJm0bgxsXle1Atd7uONEYS4Pguq0KVotrtMiSFYZQpnJtgx5U9vcVd0LjCxUAvIBMywwRvEm8PDyErQaVXyW71QVLI7NhArWPu4D6lq9g7HIDAORUKRkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaS0FFVd1JGlreX0LSm87aela6e8gI0oxUsyYC/i388=;
 b=Evb+KvgV9FBYBdyXMPMhLdK77aqVeJP3gxAfzGbo9OB+lYjHfuCGV3v9Sj7QxaDro1mmHy3WxNznWIYhasVQehvFQxvkrRYzca9XNwfaAY2tfMwr36+y6WnGS5qm0ouyooI5b/8JCvFBLOMnI4dHp3dPYwiUpWBMajbdis2hfy4rJ8oYc0XGjaRCfN6vx9latMGv4ATpoisBCHHz4z9TGW8kO2DFf9QNi9CFI6vPqnmBrFIDH9Oj26TXE0M38MreEkvhY1y7jvncY7+7yVoyLxHSTJVS1T4xaaThiGJgYFEQAwwuZLub7YzuxyeH2rpti6i4J6zB39pp0ibHNdzv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaS0FFVd1JGlreX0LSm87aela6e8gI0oxUsyYC/i388=;
 b=A8gceF2yMlAkhmadw9dbGK/A5CkeiMoLnOjNhOaFGPQdJGKzKv6tlIZ1Gr0maBL04cowiDAawRqDBTDSxr2oVRMXO23XmhtcQssSF3UrbMISh5fXwaVOry0bLiGZtwY9p9ypVixrH0g4cqJAC1XOufKlHSQMWMWxIMoa/rj5za8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6255.namprd04.prod.outlook.com (2603:10b6:208:d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 07:33:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 07:33:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
Subject: Re: [PATCH 1/7] zonefs: Detect append writes at invalid locations
Thread-Topic: [PATCH 1/7] zonefs: Detect append writes at invalid locations
Thread-Index: AQHZJPSnnkNpygGX402rZ3RMdzmU+66ZJP4AgACjjwCAAHgdAIAAJawA
Date:   Thu, 12 Jan 2023 07:33:13 +0000
Message-ID: <78d06124-8dc6-d77a-b519-ee5d4847b479@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-2-damien.lemoal@opensource.wdc.com>
 <cca3c2b2-38fd-ff76-8b58-ad70a2eaf589@wdc.com>
 <3cd10400-05e1-3190-db0d-78026acf50c5@opensource.wdc.com>
 <bac325d5-34c2-ce4e-781b-d19f24126002@opensource.wdc.com>
In-Reply-To: <bac325d5-34c2-ce4e-781b-d19f24126002@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6255:EE_
x-ms-office365-filtering-correlation-id: 2d2727de-c0d6-4a80-a1b3-08daf46f4349
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WPz5p7hvGYBktNuQbW3sji6EZ1eUH/9KbTkyLljcwknhjnHIc+6x1mSLAqUOYBffiUykWz5cflAK3bv7D339TLUMtRuar2G7rzBXBv3Vo2gsRaLjK5fa3ltc5ni3+IZJnKSDxYOtRzfSxpVgvEerdZQn3LrRUmVRo4MEP3GKrjbk0Bgy/k9Af+ZqaSz/d5CTCbCFRrByHpGZ7lHweuBwnEHAXAnlkoabFhe9HX/8ducFl4rgH/+CPBoWZWWdUllvtzotIVviE2y9UJAgja6y6Vf3Ka9Zx06ZX+Gtcrqdyd50ccAl5iiLzgfKase19aG/nO3ooLK+sDRc5uyOzfKVuGdn4TJlgCfoNWG1qB/TeYTi3nWyet6hAZuH3ZVda0j20SS8dlcf7DwbO2hii5i3HEZ0L+JxkBy2Hw4ndasfz2EPxR+FfjyAC/+zMegpbO1Bo5Umqwb3jNBogc9sRECMrKIsOm6v4grbCzx+I7iBSXrHU0bVKCjigrm6sDU4eJwqnAeqR9+VorxCBiyzj286dAPzDFHTuXmdXEdiUlt893P8okZDgHAkhNYeSjQ0gktyk1r3lrzeQ1eG0gPinam8EDO9mU3u6+xjjlHFEwNuKjwxGMwQtEJgOMjbNHsDrfQuFUdx6o3jpTi+5M21MFrUqcaHu27ZQDBcAMj7fn7QOW7YgZY6Wlp8b+ywRhumP3FNHKe73+YANxsGbRiqFRlRv+BBIa7E0v/89ZChJ4hxf/W0oVs/fdbBScXdYv50TrDfG1HwyKMgUzDW1GfXHSDjpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(2906002)(38100700002)(31686004)(122000001)(5660300002)(41300700001)(31696002)(66946007)(76116006)(4326008)(66476007)(8676002)(66446008)(66556008)(64756008)(8936002)(36756003)(91956017)(86362001)(110136005)(38070700005)(82960400001)(71200400001)(6486002)(83380400001)(478600001)(6506007)(2616005)(53546011)(316002)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2lmU1ZlSXdsMlYweFJrbFBIakdBeFp6WVBTYUdZd29IbTNMcEtxOXRnTXlI?=
 =?utf-8?B?UzN5dnk4NldoN2tma28vOXRKeFRwNTFpc3FjTHZrcmhHM25kMU5yOVRnTHhN?=
 =?utf-8?B?ZXJKUG9JTzdJN2lLd1hUMTBndGd5WmdsakdqTHI2TXpmZXBpMzVuM0NVS2E5?=
 =?utf-8?B?eXA4QTNWbUEzWFNjajEwa2tBNy82R3ZtMzBPTTJxS0ZuY2RvZ2RxT2VWM3hq?=
 =?utf-8?B?YVpScmpCR2N5Y0t4Tllic3hZV3JhU3Y1OElRczZTYXlzckV1OGgxTzFzRkdI?=
 =?utf-8?B?M0RjblZBaHRXcjJRQ3BDT2ZFOW8vSVRCSVpKWkdxejZGS1hFUTdYWTd1MUVF?=
 =?utf-8?B?S2djK29DcUNMek1BVFRmQjh6Tk9yU1NtQ200dzBCbENtbzN1aHNYWHJtQ0VR?=
 =?utf-8?B?RURyenRkN0MyTm11RmpZNlp0cjhXbFJ2TDN3TWF4dEJLM1g4aU1obVFTRkVI?=
 =?utf-8?B?UTFlVDVpK2F1dXRHdTA1Mmp1aDJ4UWRjZEV3aEs1d3VlWkhTTkg5VlpwUVVU?=
 =?utf-8?B?dnVheU9LbkpKa1htTVhmOG5XQmVKeUdUWDZQeE43OHFET2JrY3h6QnFtbE51?=
 =?utf-8?B?Z0VmbkVzYXQyNjRQaDVvU0NVendaUFRTNFcxbWZ2UFRkL3dsSHBOeXhJdjln?=
 =?utf-8?B?SkRPRWIzME02NjRCM3BZZTlxVEV4QzJOTjFUdllIeTlpbWpmN05tWnJsM2Nv?=
 =?utf-8?B?QmllRXBGbUJISkJMcVZiWFA5ck1VWThJTjF0TFN5eSsrc0xZd1lEY1JSS0l1?=
 =?utf-8?B?aXFIcmZiWEIyNEh5K0sxVldQTFdIR2ZmbzhtU2VnZ3gxUHZaeUFZeFI5bUdH?=
 =?utf-8?B?NzYxU1duM1RlWFJtQmZOVE4yWVF3c2ZCNThXVlNxa0dQMmNZcHE1SUVEcFVz?=
 =?utf-8?B?VXRJVUpmQ3lXNk9UTW1paTh5RnlQZlUzeXJqb1BYb3pwb2ZVczlFVWlWcS9R?=
 =?utf-8?B?TWFYWnNFNnQ3bzNtNG9KTVZ5SjdyeXV2SkUxWS9pY2N6OTJ1N3pVQm5hUFY2?=
 =?utf-8?B?MENHVVB0ZzdUZnZ2bkhSY0U2OC9SRXpHYUVQTVZ5SkFEcERZTW5BV2FuZ2ZG?=
 =?utf-8?B?RWpZUm9ZYjYrTU5aQmZlc2ZpTXdYdHc1VFU1Q2E3NWViMEFLNXp4Umh2cWtG?=
 =?utf-8?B?UFVjUkdZblplMmJucnR2M3RrL0pKT3RCRTBCbzZDNGl3SGZ0c0hpNU9LNDJF?=
 =?utf-8?B?b1hxZ3NsODBDZXoxRE1SVWFXUENmN2FBRDl6Rk11VWJEZjl3d1NkUXpUT1Z3?=
 =?utf-8?B?TlhFYmdPdFE4MWV1Nml1SGJiZ1hRVUorbHZWdGRPV1VxdVUyWVNoQ1JneGNU?=
 =?utf-8?B?QllCdE1wU25QZHdSZ0JlWi9NZ3F0V29WbE5RK0dXeFlpbVhSa1lYblRDcUNM?=
 =?utf-8?B?MVo4eVpHWDRzZ29nYktuVTFWbTZsamx5SThjbHBsNHNHUUZlWHRjRWVFbzF1?=
 =?utf-8?B?UldhbGJTTlgvaEk1eFNLV3JXU2s0OFljWVdGSGxsRmdJVFRMbWhRaFF5dE41?=
 =?utf-8?B?NDkwRmlLV3U0Vkt5SkN2M2lzUmx2K3NIa2Q0eEQ1YWRYK1N1enhhZ0d1K1d2?=
 =?utf-8?B?VVorM1NKcGduNzdhUmtTcXFvck9nNHJLdVk3L083dWJzdUo0R1NNTHhwU2Nq?=
 =?utf-8?B?SS95M2F3WEovWERWeXd0bHVheHpjbHVrZ05RejlWdHNibFhDM2hHVms1eGNo?=
 =?utf-8?B?MTB2V01iMFF2ZGJncGw3S25RZWpaTHNLa1VxdFFyTzRwS0VhUk12WkNtdlBK?=
 =?utf-8?B?d2hLQ1B2MlFhVTZod2NkeXd1V3Axbmh3dm50QytPSzRMS0tPTEhUWnFIa2FM?=
 =?utf-8?B?K09RM29qeElMNzg3U3JWeVJ5Sk9zRjRjYWo1ZW1jNXVodlNLRkhqRXVIbHo5?=
 =?utf-8?B?WVl0dHAxRWl6bUo4YnBuQVA5MU15VkczVndHRzZIZ0NNNEVRK1hFYzdqNWpk?=
 =?utf-8?B?NlVTY2h4VWVXdHA5MzlUdXhQS3F6emhkNXRpdjlSeDQyVXRBQXZTUkp4Y3lh?=
 =?utf-8?B?NlZaeS81RkN2QW5kRkhoNFZpM2R1NnFiZDFuVHN1QlA0dGV2R2g5RHhlWkNY?=
 =?utf-8?B?d3RhYW9YSVdKWHFEaG9Pc2JDckZJSzlCRlpQaVI1LzdGNTdlcytsZ0RNc2Ex?=
 =?utf-8?B?Z3kwdjdiaUpJS1NFbExjNGRXRmRIUkxuWHBUc3BLV3dYdVcyeTBSdWlOMm1S?=
 =?utf-8?B?UnJxZWtpSDNtMzF6bE9ET2I3RDFtQjZ2RDNHYWxuWGdCbkg4Q3M0N295R21E?=
 =?utf-8?Q?qqg6G7Hbpk5+7NuXXFtIkv0QT3C6LXWWG1htKxyPQE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77085866FC70434B9731ACF8B7DBCE00@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qqXiPvstH/LU9hPKivgaz987U8y78vQJmrw40RtNXg+jkB4I0qMnBliSgCgWGnd4RId6dD8N+rkgpMjx+IZoSATlRxrrPP3XpxGt8uQhckqgKATlJYvn2KCWS1GFEQBeZnFYZ7p9kSy6LQ/7EB8Q0rY/RuQ7w35oWvz+C2tRwtcG0zWMLsUlRyGg65gI/KH2fU8lGcWxYMi4dR5o1LFPah1s/XrvHa22J2KTtx0+cVfoBPj+gvGkdcIzRxpKmZpfISCiTXnveDfvGCpuyxQxn3X71debReE5Tn/G7nd01vvejENcI2/E3WnglSzoTzu7+Z+7dEA8oiKOShrnMITsfWMpBuuBBRN/M4h2fe3LhB+3jqJs3+tzKD4VdquwTMMq3ubfXCPmw8SCMG/OEews6iqBOwLGEmlGde2sHQ/2NyX54uvu0w5JEkYHT45JZvbNDa18CbAEJtFgyYCINMSfMNZXRwDyN+adk8ouS/jH9zeqXpVe28Wxb5CXJJof4AOwT1r0N3PyBNHKp1pqfr8Ca3defGXWp8GTb75T20SrMAtgvj3FNb0fQwvIzj09UQa++SS5Y36IgQ0m9bA5uJJS8//WYGQZpKJGxeececKAta+OBkKtzCe/3S85s3px/1ShcqrF2toG7wUKFEw3P9OMY+zm9A2YylfaprBNs/MbIAs1ngn34d2L9JRlZeQxZgIzENN+pPr2o53MIIq33+oVf0WdVDAcv7UvRu7DVKGqe3K9qpGSyZXs21U0SNdYdp8g+bu5JiLA8IMLSFpe14FlZA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2727de-c0d6-4a80-a1b3-08daf46f4349
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 07:33:13.3167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vh5zQT7phLzYOaDlmukEJJVBLEFKx3xLYWhuGvJ+JhM0eMDiASbmWl2rjll7ghU3RzY80KXRGCcLS16Xq7KJm8K8Y4fqUpnzxVK/CIm4Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6255
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTIuMDEuMjMgMDY6MTgsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBPbiAxLzEyLzIzIDA3
OjA4LCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4+IE9uIDEvMTEvMjMgMjE6MjMsIEpvaGFubmVz
IFRodW1zaGlybiB3cm90ZToNCj4+PiBPbiAxMC4wMS4yMyAxNDowOCwgRGFtaWVuIExlIE1vYWwg
d3JvdGU6DQo+Pj4+IFVzaW5nIFJFUV9PUF9aT05FX0FQUEVORCBvcGVyYXRpb25zIGZvciBzeW5j
aHJvbm91cyB3cml0ZXMgdG8gc2VxdWVudGlhbA0KPj4+PiBmaWxlcyBzdWNjZWVkcyByZWdhcmRs
ZXNzIG9mIHRoZSB6b25lIHdyaXRlIHBvaW50ZXIgcG9zaXRpb24sIGFzIGxvbmcgYXMNCj4+Pj4g
dGhlIHRhcmdldCB6b25lIGlzIG5vdCBmdWxsLiBUaGlzIG1lYW5zIHRoYXQgaWYgYW4gZXh0ZXJu
YWwgKGJ1Z2d5KQ0KPj4+PiBhcHBsaWNhdGlvbiB3cml0ZXMgdG8gdGhlIHpvbmUgb2YgYSBzZXF1
ZW50aWFsIGZpbGUgdW5kZXJuZWF0aCB0aGUgZmlsZQ0KPj4+PiBzeXN0ZW0sIHN1YnNlcXVlbnQg
ZmlsZSB3cml0ZSgpIG9wZXJhdGlvbiB3aWxsIHN1Y2NlZWQgYnV0IHRoZSBmaWxlIHNpemUNCj4+
Pj4gd2lsbCBub3QgYmUgY29ycmVjdCBhbmQgdGhlIGZpbGUgd2lsbCBjb250YWluIGludmFsaWQg
ZGF0YSB3cml0dGVuIGJ5DQo+Pj4+IGFub3RoZXIgYXBwbGljYXRpb24uDQo+Pj4+DQo+Pj4+IE1v
ZGlmeSB6b25lZnNfZmlsZV9kaW9fYXBwZW5kKCkgdG8gY2hlY2sgdGhlIHdyaXR0ZW4gc2VjdG9y
IG9mIGFuIGFwcGVuZA0KPj4+PiB3cml0ZSAocmV0dXJuZWQgaW4gYmlvLT5iaV9pdGVyLmJpX3Nl
Y3RvcikgYW5kIHJldHVybiAtRUlPIGlmIHRoZXJlIGlzIGENCj4+Pj4gbWlzbWF0Y2ggd2l0aCB0
aGUgZmlsZSB6b25lIHdwIG9mZnNldCBmaWVsZC4gVGhpcyBjaGFuZ2UgdHJpZ2dlcnMgYSBjYWxs
DQo+Pj4+IHRvIHpvbmVmc19pb19lcnJvcigpIGFuZCBhIHpvbmUgY2hlY2suIE1vZGlmeSB6b25l
ZnNfaW9fZXJyb3JfY2IoKSB0bw0KPj4+PiBub3QgZXhwb3NlIHRoZSB1bmV4cGVjdGVkIGRhdGEg
YWZ0ZXIgdGhlIGN1cnJlbnQgaW5vZGUgc2l6ZSB3aGVuIHRoZQ0KPj4+PiBlcnJvcnM9cmVtb3Vu
dC1ybyBtb2RlIGlzIHVzZWQuIE90aGVyIGVycm9yIG1vZGVzIGFyZSBjb3JyZWN0bHkgaGFuZGxl
ZA0KPj4+PiBhbHJlYWR5Lg0KPj4+DQo+Pj4gVGhpcyBvbmx5IGhhcHBlbnMgb24gWk5TIGFuZCBu
dWxsX2JsaywgZG9lc24ndCBpdD8gT24gU0NTSSB0aGUgWm9uZSBBcHBlbmQNCj4+PiBlbXVsYXRp
b24gc2hvdWxkIGNhdGNoIHRoaXMgZXJyb3IgYmVmb3JlLg0KPj4NCj4+IFllcy4gVGhlIHpvbmUg
YXBwZW5kIHdpbGwgZmFpbCB3aXRoIHNjc2kgc2QgZW11bGF0aW9uIHNvIHRoaXMgY2hhbmdlIGlz
DQo+PiBub3QgdXNlZnVsIGluIHRoYXQgY2FzZS4gQnV0IG51bGxfYmxrIGFuZCBaTlMgZHJpdmVz
IHdpbGwgbm90IGZhaWwgdGhlDQo+PiB6b25lIGFwcGVuZCwgcmVzdWx0aW5nIGluIGEgYmFkIGZp
bGUgc2l6ZSB3aXRob3V0IHRoaXMgY2hlY2suDQo+IA0KPiBMZXQgbWUgcmV0cmFjdCB0aGF0Li4u
IEZvciBzY3NpIHNkLCB0aGUgem9uZSBhcHBlbmQgZW11bGF0aW9uIHdpbGwgZG8gaXRzDQo+IGpv
YiBpZiBhbiBhcHBsaWNhdGlvbiB3cml0ZXMgdG8gYSB6b25lIHVuZGVyIHRoZSBmaWxlIHN5c3Rl
bS4gVGhlbiB6b25lZnMNCj4gaXNzdWluZyBhIHpvbmUgYXBwZW5kIHdpbGwgYWxzbyBzdWNjZWVk
IGFuZCB3ZSBlbmQgdXAgd2l0aCB0aGUgYmFkIGlub2RlIHNpemUuDQo+IA0KPiBXZSB3b3VsZCBn
ZXQgYSB6b25lIGFwcGVuZCBmYWlsdXJlIGluIHpvbmVmcyB3aXRoIHNjc2kgc2QgaWYgdGhlDQo+
IGNvcnJ1cHRpb24gdG8gdGhlIHpvbmUgd2FzIGRvbmUgd2l0aCBhIHBhc3N0aHJvdWdoIGNvbW1h
bmQgYXMgdGhlc2Ugd2lsbA0KPiBub3QgcmVzdWx0IGluIHNkX3piYyB6b25lIHdyaXRlIHBvaW50
ZXIgdHJhY2tpbmcgZG9pbmcgaXRzIGpvYi4NCj4gDQoNCkJ1dCB0aGVuIHRoZSBlcnJvciByZWNv
dmVyeSBwcm9jZWR1cmVzIGluIHNkX3piYyBzaG91bGQgY29tZSBpbnRvIHBsYWNlLg0KDQpBbnl3
YXlzIGZvciBaTlMgYW5kIG51bGxfYmxrIHRoaXMgaXMgYW4gaW1wcm92ZW1lbnQ6DQpSZXZpZXdl
ZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
