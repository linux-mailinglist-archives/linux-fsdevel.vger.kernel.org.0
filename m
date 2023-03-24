Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F31A6C7E76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 14:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCXNIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 09:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCXNIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:08:41 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354D72724;
        Fri, 24 Mar 2023 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679663301; x=1711199301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l4/JWQR3G46+hiSSZ+rFm+idVNYpnvH5bu/HNy9Qmqs=;
  b=Q40q2LdEP6wat23WQ8YcCPrqWrfbOo+vLo6C/q/SB/nUEdG+eWVRuYgX
   MdlmXQawW8ndtp4xRveEN7fFpeGKNg9vkwrPMdn1d0fVq0QLQfaUROJLN
   agFBijYLGOrZva4lYU7bwNwH4cMIWikCnJPKAD0LXvAjQ6kY06RoCsx+U
   QoZobIGvMi9pAs1kl88mn9QKLh9uABfgFDNkdHxv8dsSOFJDyZVtYp5oV
   jF0u3qoCTa8+bRHg9wjmHKMKzdq7jKdNXggZR/N6ao5BtI72TpnbPrG0d
   KJD0VXOW5NSh7yyUaXYoXuwRneh0W3uI1V8vwJDC0AsMlAjkA4q17eVcg
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,287,1673884800"; 
   d="scan'208";a="224707263"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 21:08:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM3Au5YyDysUa1Q4k2nyYCP9sd1etvCewPLtnmSbpJflfZLX56H6JDu1Y5GYD5p9lsZssidUYdaDIU9vibVM7Yk2t4NXpWIN3327h4gacnLgI/1XnfggiRfB3UfB7zdL49TnL64yIqxRFiwPt9eYk7unOocdwxDf23YXiPukpca/AhThmliz9tqJuMYbVwGfEBLvU30B6tCuXhmpozDG+k+HqBKwv/gAH/SPMF+FJ0R15NKJcFWnxfZtJ5xo7LrtnbDTubLnNv3lGsXP9B+Pbn/OjhOHngZwW3Ar8z1KCitsz8sqqsaUdPWpY34KcZKt7qg7Kx5rV6kacy+ATLsGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4/JWQR3G46+hiSSZ+rFm+idVNYpnvH5bu/HNy9Qmqs=;
 b=dG0W9xgkGwfkxh7ocAaBTwStRAlQunFRegu9eGur6eV8taUbAWVtevNzmjdsHrt4ZFmSOZWPVL7y7jHommO8GSPMvfKHV7vYzqSao8QHhVd0QXDAyhH2mQbIxH4LgXJN6tP3hZcXtQt6YPLXVJ4btlz15NZHwZHubjZjIGKnEJe87OqM2I6FNym/uFHZXJRlWwbIezAGRGg9lsI31pLfMdnLwnh+Hqh1ZmYKuxRi6LcpO+QT6/amk+IA2yPbgFTow2+b++f0vHSqEw4wVLJFw6PpY81rYNAYN/ZPPxlpCVIb3Y3hk/1ymewGVX/erWIETIA6itE0ZJqfyyWFqlV3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4/JWQR3G46+hiSSZ+rFm+idVNYpnvH5bu/HNy9Qmqs=;
 b=Zmx83wHuDZupV5ycIsTWC2xIOdlA2v1loABpiVmVdKEOj3CEWG+AjB49mltm/AXswlHYFxGjuRAXE/o0ud4WJBRPfZVcK1zE7wTT6kcCn4Ijzk8wuBtdttkzCgpKbSXEvxYm2nc8DGgWq2McrkZGb5OrIbmK0JFSq5Gf7XogEV4=
Received: from SN4PR0401MB3582.namprd04.prod.outlook.com
 (2603:10b6:803:4c::10) by SA2PR04MB7641.namprd04.prod.outlook.com
 (2603:10b6:806:14e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 13:08:16 +0000
Received: from SN4PR0401MB3582.namprd04.prod.outlook.com
 ([fe80::9155:d46:5d85:44d5]) by SN4PR0401MB3582.namprd04.prod.outlook.com
 ([fe80::9155:d46:5d85:44d5%5]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 13:08:16 +0000
From:   =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: RE(3): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Thread-Topic: RE(3): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Thread-Index: AQHZXjNs7M/EtzzkLUia91e4RTPKmq8Jr72AgAA3PgA=
Date:   Fri, 24 Mar 2023 13:08:16 +0000
Message-ID: <E224146D-058D-48B3-8788-A6BC3370044F@wdc.com>
References: <91d02705-1c3f-5f55-158a-1a68120df2f4@redhat.com>
 <CGME20230324095031epcas2p284095ae90b25a47360b5098478dffdaa@epcas2p2.samsung.com>
 <20230324095031.148164-1-ks0204.kim@samsung.com>
In-Reply-To: <20230324095031.148164-1-ks0204.kim@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR0401MB3582:EE_|SA2PR04MB7641:EE_
x-ms-office365-filtering-correlation-id: 9a7996a0-b876-4e44-fb73-08db2c68d4dc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R6mxdIz4ATwi3p/H/uEg66c1eYobSti2QMzEFSnfQB+uiudoaV0MJHy5Gre/rik8/LRi+oTs2ZK2/Mlb4rfpEof7ff8sHV+PX6fx/M+zbgUUUYPHbzj0m8b1yChJvn7oPqwcAS3GTrMCFgVcWKzfynsy5ccsrYNoY+NNhBRj7MMGPQ+7lTtaH+aZqUVTrgKeTU51S074XAVMUFH4VN0tx5Zt87usN4U82h9YmRzMqznIX/BhhnRWSNFbUfyww2qDwDl3lBi9DWG+RTHb0+GsKlINqM8eGIt59WX/sE749QwUGssPsE1El3EBDteK7+o7X2ID2c+EJHVPHMIjlW7FvaAR2eluj+S+xBwBCdHRuiFUeo6E8HVc+pRiSI6fpJjxSCvx+EDpbY+r/eCew/uIc31iUzuM6mCRxFnOKGjPEiTyOszsJSG/kO03rkAxeCK3EVjMIIQehz+kgOtLbvJb9Ujrcbp7RgTVHq8+HUflYoFWdaoTNa+wQcMfc1GzEfX3cJ6RhetHjslJTRrAkLJnbzG71+R8kemmlf27LItBAKdfdENyXQba9OR87kIkRmT3u0Oraa9c/NAs9p3O18ndFr5632rT+51LQLB5+NwsDpCjoOnn8rTpRyjfa+gk1OWcaE11nYYJYSSO7iix/2DBzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3582.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199018)(2906002)(38070700005)(38100700002)(8676002)(6486002)(83380400001)(478600001)(71200400001)(2616005)(186003)(66476007)(36756003)(85182001)(86362001)(33656002)(85202003)(91956017)(6916009)(64756008)(66446008)(66556008)(4326008)(66946007)(76116006)(6512007)(316002)(6506007)(8936002)(54906003)(53546011)(26005)(82960400001)(5660300002)(41300700001)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnV3VXZVMk9HZkJya3hRWmsrNUdKTUplcWprQ3V3S2hMdjRyMEo0RVRocnRi?=
 =?utf-8?B?VGVOU1p3TDF2TTJ5dkRIRktYVmNWanNPaHBBd2RzUXg4eDR1WG9kR2FlQWV4?=
 =?utf-8?B?L1VwYkNMcGp4azUrc0RzR3I5d044dk5ORkc1YWVpbE4wRTNEZ3VRQVZzZXFJ?=
 =?utf-8?B?cTUxcFgvcVRSakxnZktCdGlvVU9JOXQ2S1RhNlpnSTM0Q0JLbnY4REpxMTRR?=
 =?utf-8?B?cTlsOVNhN3FWaWlQbFJTcVBGMFhpb0I0MlJFMk9PcXpzMi9acVg1bTlWU3BJ?=
 =?utf-8?B?eDBKUERldXhxc2VnN0RNYWMrd2ZtUHI0QU44eExOMmphSXBsNUhkeU1yTk9Z?=
 =?utf-8?B?UXowdDFDcVovVE1jemNmT3FLTkpBQUdXcmJZWTR1WDYxTE1oVW45cGZDQVg3?=
 =?utf-8?B?V1ZRaDl0eUZRcUx6M05ZM2R1YXhsZGp0aXVSSW9SWTdtTElLUEgwaktnQXBX?=
 =?utf-8?B?TExYK0pGdDNVNktCNTJUaW5XZE9JcG0yajRITDI3UUl0Z3FzeGNQdTRkY2Nz?=
 =?utf-8?B?MnBkbGhYdUtmNjk4TFU5Mkh0eitjMFZXbnZiclNGZTlYRXlPVHBmaXlVZCsr?=
 =?utf-8?B?SjFyMTcrVkJ2a0pSTHNlZzhndktNQ05BaXhVUys3dVBlNXd4T2hNdjN1RG1X?=
 =?utf-8?B?Uml0bysvbW9FcnkwTlRwUkdxTlpSSW1mTmFhV2tUZlI3N3RNN1c1cUliN1o5?=
 =?utf-8?B?YTN1Yy9UMS82RmVDeHRBSWtCazkxSlZOcFB3Rk5NcHJ6KzNKd25zWkdGaURF?=
 =?utf-8?B?MnU0MHAzMzh3aHpwazd0bUpQZ2MrYmJicFhOVVBDWGJHMlZMV09pMzBmNGpw?=
 =?utf-8?B?NFJsYkxicjRIRHdHUzRuSlJTajVROVdKUSszbGtiaDRKaHM1dWpDZGZDT3Rh?=
 =?utf-8?B?Wkhmd2RWMWNlUHE4Ykd1c1dnWFVYUlRYdkt5L2hBYStsRnV4RTc2b1Z4dXli?=
 =?utf-8?B?dE02Y0o0UmFwdk9aY1NhOHFVZ2JNSkloOVFGTzE5M0N5M0FkMXEvVHI1NGZ3?=
 =?utf-8?B?Nzdkd1ovamNibVJiOFpXU0IyekhaL1lnMzMxdVh0dFhGbS9LSmRTMlpCeXJM?=
 =?utf-8?B?U3loem9haThnVTlLNFlwdGhpUU5XQkN6QTgyWXNyTUNsTGNaQ1VpTzVyNWJR?=
 =?utf-8?B?QUJmR2UwdHA3V2RQbGNYV3ZncmpjdGtlVE5ZSysxbmNyY2NBMENwb0RVY1Mx?=
 =?utf-8?B?a2orWnR0QklML0pMaEN2ZGVyUWQ1bldFRG01VGhIVXEwbkc2c0QxbkhXZmEr?=
 =?utf-8?B?YXUvcjR1NEtNTy9meUMyWGdxeWh3UzFzR3p3emI0Um9TSU1ZME9aQkQwKzFw?=
 =?utf-8?B?UGM3UllhelQvV1k1S2JyUXVObGZFWHRhNzZ3TkI4QnM0L2hOSlVPVTA0d200?=
 =?utf-8?B?R1BZSkJtU1lndXk0ZFd6VnhQY0g1TlBwa01memR0NW5LSXRId3hMYXVUd2k4?=
 =?utf-8?B?MzlOV2tzYnVDd2RPUkt4QTlWM3hpWURvVGl0SHEyMWJoQzRQb1Vvdi9KM053?=
 =?utf-8?B?M045YlZSMUtQSGZjVElOWGtRekJEMDg3U0dnd29RZkdxU29SampZWlVrcE5B?=
 =?utf-8?B?ZWN0UlJNUGxPcDE4bUFjNU5hazY5RDRjZ2xuV2lJZnp6d1dpdnAwZzU2TUZ4?=
 =?utf-8?B?NERmNW5wdWtOc3p3WEpoNW9ycm1tZi9GYXFVSmErWW5XTlhhR010bU1Jc3NL?=
 =?utf-8?B?bitiUGYySE9OYTBZOWE5SVdaNzQ3cjNtckY3VVpxSFlaUTllSXkvcXNNOFR5?=
 =?utf-8?B?K3ZYTWdNWVBWUm9NcEJXNndmQ2ZmMVJmZjdQdXp6Ri9DM2JsUWw1aXljeEl4?=
 =?utf-8?B?aDQ0cGozUjNqWlVqc0haZEhyVlR3T1dINE5aQ0ppWit4QWhWci9oc3Znc0tz?=
 =?utf-8?B?WXNyQ2JQNSs5bExPUitwT2RidUtKbk0vWHRhOFF4MVhaWWN4RkZnQ016RExm?=
 =?utf-8?B?TWlQNjZ2dzFhQTBWZTc5c1NDWHVxUTdyNFl6YTlFZlVjTm42cW1NYkRwaUNL?=
 =?utf-8?B?d2FqK3ZITjI5bE1pM3M0UHJ0UDZ0bW9qcm5hRjJOTlhKUnd2bEd2WXkveGdX?=
 =?utf-8?B?dmJReDc2QkQyRmttaEM5V0g1c3E0Z3JISndPeE1GWFVoUDRaR2p5U01QNE5s?=
 =?utf-8?B?T3FvN0hLeDZVZjZleUZtaFdlK2xXOWRIL2JVejlOK2pGMzdnNVZPSWNkZjNO?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FDC313042AEEC4A837236D8740E748F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YWhqVVQ2RnRaU1hoWGZRd0pQdVh6Zi9xbk9STGNMZWx4dlBVZWpkdk43MGRk?=
 =?utf-8?B?Wm1OVE16ODZuUXgzK3VwN1BXeUZSaVY3d1VQRy9seEs5TnBqTHRHM1oxanl2?=
 =?utf-8?B?dDExUFdMaXNjcGFJcGFhVGR2ZmRjbmJndWc1RXlVRHY0WmdCV1V6c1BRZlFa?=
 =?utf-8?B?eFZqbFhFc0grckhxOGpXNFNGemtYRWdFYmE2NHYxemlWWXFGczVvdTM4bnZ4?=
 =?utf-8?B?eVZwNU5vZlBIOWRUTEhuVHNBeG1HaXhzR3ZtMWRvZEFsS3N2QlNNWUQxUWFs?=
 =?utf-8?B?ekhNTk50YVdSbzVld1BEb0FMVDlaL2FUeTgvVDRqZGt0N3ZlWFRNSktRUC9s?=
 =?utf-8?B?ck9iWFkwZ3VLTnJPK04zZm8xU1VNNzZTT3hVMVRieHZ3SnFodUhhSUxtNjUx?=
 =?utf-8?B?QTdaUWxzUW94VnR3bzEvOXd1UDZiUWJTYlBvaHo4R1I0TXpWUnV0WkMyNnlR?=
 =?utf-8?B?NEF6RVdMd1BqcGhCbkV5dlhYT1RvSWdNQ1Z1TDFGcmJ2ZFJGY0IyZC9CNzF1?=
 =?utf-8?B?Wm9nSWtCQ0R5VHNwSTIxWnJhRmVVVWx2c0tFWkhPRGhvTHlJVVkyRjcraHpU?=
 =?utf-8?B?ek01SVlTRzcrUzJSVHhzUm5JeEhpbDgrOGh1MHBJc3RaRnJZYzFlZTkvZ0RF?=
 =?utf-8?B?cXRMcjFkL0Z1Nlg2c0JGWDFCZXlWTG02ZDd0dzhVUXJIVEU4dXNIYjNtWXh6?=
 =?utf-8?B?d01WMmV4Z2dSYXR3Zk9TcXd2VmFmTGF5ZWNpajFQWFlOYVVvMWNzTkdaR3dC?=
 =?utf-8?B?YmN4ak9jcWE2OFVyRmg0VHdjcVg0dnBVY1VScDUvMnVtYnk1M3VzK1BOWmlJ?=
 =?utf-8?B?S2ZNb1AxL2pzZ1dKY0FJNDR4akhjWmtKSXhFRXhaOHE0djRnZHJXKy9aTGpN?=
 =?utf-8?B?bHJpMHFtRnpYRHV3S0RrcWQvY3lMc250cmhocjRRZWxhOGdHKzlMOStXOFpJ?=
 =?utf-8?B?QW5JUFpSeE01clRPL2oyd3JFbjlTYitvdlIzQWNTeHFwbEZhV2JwSUJYOGp6?=
 =?utf-8?B?aVpDM2JmNi94THFWK2Y0dWVycFRHR1p0YUlNbGdJdnhkVVBWWTh2aGpIUTAv?=
 =?utf-8?B?YnRtM3p5MkE3V1dnd0VyUnB5d3U2dDRaQ1MyMG1IU0JGTUowVEpJeGIyd1pr?=
 =?utf-8?B?QnV0UUhlUTZzMXN4NXhUZEttM1RvT2xubU1WQ3FuM2Y0cjZTaFBvTzhqU0N0?=
 =?utf-8?B?ZStnOE0zRFBqSC93MlIyS280cFZVeDBpaVhESzE5bFdGajM5a0lIQ3RZdmp5?=
 =?utf-8?B?SFNyWHFMYkJNQkdkZVZ6eWNtSmtYZkZJRitvbXRaRzcwZ3FnKzRWak1qd2RY?=
 =?utf-8?Q?bixUWyuPO4cwMarkh11TTVrAIuaY+Ms4VH?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3582.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7996a0-b876-4e44-fb73-08db2c68d4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 13:08:16.2373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OHdOHqL8iFo5xqLY5wQ2z4q4qTC9Bpf+3KLneBpxIot5amtb8jVWwBjCfwlGHEbe0YZZnpEf6GOC86+hZ5vWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7641
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIDI0IE1hciAyMDIzLCBhdCAxMC41MCwgS3l1bmdzYW4gS2ltIDxrczAyMDQua2ltQHNh
bXN1bmcuY29tPiB3cm90ZToNCj4gDQo+PiBPbiAyNC4wMy4yMyAxMDoyNywgS3l1bmdzYW4gS2lt
IHdyb3RlOg0KPj4+PiBPbiAyNC4wMy4yMyAxMDowOSwgS3l1bmdzYW4gS2ltIHdyb3RlOg0KPj4+
Pj4gVGhhbmsgeW91IERhdmlkIEhpbmRlcmJyYW5kIGZvciB5b3VyIGludGVyZXN0IG9uIHRoaXMg
dG9waWMuDQo+Pj4+PiANCj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBLeXVuZ3NhbiBLaW0gd3JvdGU6DQo+
Pj4+Pj4+PiBbLi5dDQo+Pj4+Pj4+Pj4+IEluIGFkZGl0aW9uIHRvIENYTCBtZW1vcnksIHdlIG1h
eSBoYXZlIG90aGVyIGtpbmQgb2YgbWVtb3J5IGluIHRoZQ0KPj4+Pj4+Pj4+PiBzeXN0ZW0sIGZv
ciBleGFtcGxlLCBIQk0gKEhpZ2ggQmFuZHdpZHRoIE1lbW9yeSksIG1lbW9yeSBpbiBGUEdBIGNh
cmQsDQo+Pj4+Pj4+Pj4+IG1lbW9yeSBpbiBHUFUgY2FyZCwgZXRjLiAgSSBndWVzcyB0aGF0IHdl
IG5lZWQgdG8gY29uc2lkZXIgdGhlbQ0KPj4+Pj4+Pj4+PiB0b2dldGhlci4gIERvIHdlIG5lZWQg
dG8gYWRkIG9uZSB6b25lIHR5cGUgZm9yIGVhY2gga2luZCBvZiBtZW1vcnk/DQo+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4gV2UgYWxzbyBkb24ndCB0aGluayBhIG5ldyB6b25lIGlzIG5lZWRlZCBmb3Ig
ZXZlcnkgc2luZ2xlIG1lbW9yeQ0KPj4+Pj4+Pj4+IGRldmljZS4gIE91ciB2aWV3cG9pbnQgaXMg
dGhlIHNvbGUgWk9ORV9OT1JNQUwgYmVjb21lcyBub3QgZW5vdWdoIHRvDQo+Pj4+Pj4+Pj4gbWFu
YWdlIG11bHRpcGxlIHZvbGF0aWxlIG1lbW9yeSBkZXZpY2VzIGR1ZSB0byB0aGUgaW5jcmVhc2Vk
IGRldmljZQ0KPj4+Pj4+Pj4+IHR5cGVzLiAgSW5jbHVkaW5nIENYTCBEUkFNLCB3ZSB0aGluayB0
aGUgWk9ORV9FWE1FTSBjYW4gYmUgdXNlZCB0bw0KPj4+Pj4+Pj4+IHJlcHJlc2VudCBleHRlbmRl
ZCB2b2xhdGlsZSBtZW1vcmllcyB0aGF0IGhhdmUgZGlmZmVyZW50IEhXDQo+Pj4+Pj4+Pj4gY2hh
cmFjdGVyaXN0aWNzLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBTb21lIGFkdmljZSBmb3IgdGhlIExT
Ri9NTSBkaXNjdXNzaW9uLCB0aGUgcmF0aW9uYWxlIHdpbGwgbmVlZCB0byBiZQ0KPj4+Pj4+Pj4g
bW9yZSB0aGFuICJ3ZSB0aGluayB0aGUgWk9ORV9FWE1FTSBjYW4gYmUgdXNlZCB0byByZXByZXNl
bnQgZXh0ZW5kZWQNCj4+Pj4+Pj4+IHZvbGF0aWxlIG1lbW9yaWVzIHRoYXQgaGF2ZSBkaWZmZXJl
bnQgSFcgY2hhcmFjdGVyaXN0aWNzIi4gSXQgbmVlZHMgdG8NCj4+Pj4+Pj4+IGJlIGFsb25nIHRo
ZSBsaW5lcyBvZiAieWVzLCB0byBkYXRlIExpbnV4IGhhcyBiZWVuIGFibGUgdG8gZGVzY3JpYmUg
RERSDQo+Pj4+Pj4+PiB3aXRoIE5VTUEgZWZmZWN0cywgUE1FTSB3aXRoIGhpZ2ggd3JpdGUgb3Zl
cmhlYWQsIGFuZCBIQk0gd2l0aCBpbXByb3ZlZA0KPj4+Pj4+Pj4gYmFuZHdpZHRoIG5vdCBuZWNl
c3NhcmlseSBsYXRlbmN5LCBhbGwgd2l0aG91dCBhZGRpbmcgYSBuZXcgWk9ORSwgYnV0IGENCj4+
Pj4+Pj4+IG5ldyBaT05FIGlzIGFic29sdXRlbHkgcmVxdWlyZWQgbm93IHRvIGVuYWJsZSB1c2Ug
Y2FzZSBGT08sIG9yIGFkZHJlc3MNCj4+Pj4+Pj4+IHVuZml4YWJsZSBOVU1BIHByb2JsZW0gQkFS
LiIgV2l0aG91dCBGT08gYW5kIEJBUiB0byBkaXNjdXNzIHRoZSBjb2RlDQo+Pj4+Pj4+PiBtYWlu
dGFpbmFiaWxpdHkgY29uY2VybiBvZiAiZmV3ZXIgZGVncmVzcyBvZiBmcmVlZG9tIGluIHRoZSBa
T05FDQo+Pj4+Pj4+PiBkaW1lbnNpb24iIHN0YXJ0cyB0byBkb21pbmF0ZS4NCj4+Pj4+Pj4gDQo+
Pj4+Pj4+IE9uZSBwcm9ibGVtIHdlIGV4cGVyaWVuY2VkIHdhcyBvY2N1cmVkIGluIHRoZSBjb21i
aW5hdGlvbiBvZiBob3QtcmVtb3ZlIGFuZCBrZXJlbHNwYWNlIGFsbG9jYXRpb24gdXNlY2FzZXMu
DQo+Pj4+Pj4+IFpPTkVfTk9STUFMIGFsbG93cyBrZXJuZWwgY29udGV4dCBhbGxvY2F0aW9uLCBi
dXQgaXQgZG9lcyBub3QgYWxsb3cgaG90LXJlbW92ZSBiZWNhdXNlIGtlcm5lbCByZXNpZGVzIGFs
bCB0aGUgdGltZS4NCj4+Pj4+Pj4gWk9ORV9NT1ZBQkxFIGFsbG93cyBob3QtcmVtb3ZlIGR1ZSB0
byB0aGUgcGFnZSBtaWdyYXRpb24sIGJ1dCBpdCBvbmx5IGFsbG93cyB1c2Vyc3BhY2UgYWxsb2Nh
dGlvbi4NCj4+Pj4+Pj4gQWx0ZXJuYXRpdmVseSwgd2UgYWxsb2NhdGVkIGEga2VybmVsIGNvbnRl
eHQgb3V0IG9mIFpPTkVfTU9WQUJMRSBieSBhZGRpbmcgR0ZQX01PVkFCTEUgZmxhZy4NCj4+Pj4+
IA0KPj4+Pj4+IFRoYXQgc291bmRzIGxpa2UgYSBiYWQgaGFjayA6KSAuDQo+Pj4+PiBJIGNvbnNl
bnQgeW91Lg0KPj4+Pj4gDQo+Pj4+Pj4+IEluIGNhc2UsIG9vcHMgYW5kIHN5c3RlbSBoYW5nIGhh
cyBvY2Nhc2lvbmFsbHkgb2NjdXJlZCBiZWNhdXNlIFpPTkVfTU9WQUJMRSBjYW4gYmUgc3dhcHBl
ZC4NCj4+Pj4+Pj4gV2UgcmVzb2x2ZWQgdGhlIGlzc3VlIHVzaW5nIFpPTkVfRVhNRU0gYnkgYWxs
b3dpbmcgc2VsZXRpdmVseSBjaG9pY2Ugb2YgdGhlIHR3byB1c2VjYXNlcy4NCj4+Pj4+IA0KPj4+
Pj4+IEkgb25jZSByYWlzZWQgdGhlIGlkZWEgb2YgYSBaT05FX1BSRUZFUl9NT1ZBQkxFIFsxXSwg
bWF5YmUgdGhhdCdzDQo+Pj4+Pj4gc2ltaWxhciB0byB3aGF0IHlvdSBoYXZlIGluIG1pbmQgaGVy
ZS4gSW4gZ2VuZXJhbCwgYWRkaW5nIG5ldyB6b25lcyBpcw0KPj4+Pj4+IGZyb3duZWQgdXBvbi4N
Cj4+Pj4+IA0KPj4+Pj4gQWN0dWFsbHksIHdlIGhhdmUgYWxyZWFkeSBzdHVkaWVkIHlvdXIgaWRl
YSBhbmQgdGhvdWdodCBpdCBpcyBzaW1pbGFyIHdpdGggdXMgaW4gMiBhc3BlY3RzLg0KPj4+Pj4g
MS4gWk9ORV9QUkVGRVJfTU9WQUJMRSBhbGxvd3MgYSBrZXJuZWxzcGFjZSBhbGxvY2F0aW9uIHVz
aW5nIGEgbmV3IHpvbmUNCj4+Pj4+IDIuIFpPTkVfUFJFRkVSX01PVkFCTEUgaGVscHMgbGVzcyBm
cmFnbWVudGF0aW9uIGJ5IHNwbGl0dGluZyB6b25lcywgYW5kIG9yZGVyaW5nIGFsbG9jYXRpb24g
cmVxdWVzdHMgZnJvbSB0aGUgem9uZXMuDQo+Pj4+PiANCj4+Pj4+IFdlIHRoaW5rIFpPTkVfRVhN
RU0gYWxzbyBoZWxwcyBsZXNzIGZyYWdtZW50YXRpb24uDQo+Pj4+PiBCZWNhdXNlIGl0IGlzIGEg
c2VwYXJhdGVkIHpvbmUgYW5kIGhhbmRsZXMgYSBwYWdlIGFsbG9jYXRpb24gYXMgbW92YWJsZSBi
eSBkZWZhdWx0Lg0KPj4+PiANCj4+Pj4gU28gaG93IGlzIGl0IGRpZmZlcmVudCB0aGF0IGl0IHdv
dWxkIGp1c3RpZnkgYSBkaWZmZXJlbnQgKG1vcmUgY29uZnVzaW5nDQo+Pj4+IElNSE8pIG5hbWU/
IDopIE9mIGNvdXJzZSwgbmFtZXMgZG9uJ3QgbWF0dGVyIHRoYXQgbXVjaCwgYnV0IEknZCBiZQ0K
Pj4+PiBpbnRlcmVzdGVkIGluIHdoaWNoIG90aGVyIGFzcGVjdCB0aGF0IHpvbmUgd291bGQgYmUg
InNwZWNpYWwiLg0KPj4+IA0KPj4+IEZZSSBmb3IgdGhlIGZpcnN0IHRpbWUgSSBuYW1lZCBpdCBh
cyBaT05FX0NYTE1FTSwgYnV0IHdlIHRob3VnaHQgaXQgd291bGQgYmUgbmVlZGVkIHRvIGNvdmVy
IG90aGVyIGV4dGVuZGVkIG1lbW9yeSB0eXBlcyBhcyB3ZWxsLg0KPj4+IFNvIEkgY2hhbmdlZCBp
dCBhcyBaT05FX0VYTUVNLg0KPj4+IFdlIGFsc28gd291bGQgbGlrZSB0byBwb2ludCBvdXQgYSAi
c3BlY2lhbCIgem9uZSBhc3BlYWN0LCB3aGljaCBpcyBkaWZmZXJlbnQgZnJvbSBaT05FX05PUk1B
TCBmb3IgdHJhbmRpdGlvbmFsIEREUiBEUkFNLg0KPj4+IE9mIGNvdXJzZSwgYSBzeW1ib2wgbmFt
aW5nIGlzIGltcG9ydGFudCBtb3JlIG9yIGxlc3MgdG8gcmVwcmVzZW50IGl0IHZlcnkgbmljZWx5
LCB0aG91Z2guDQo+Pj4gRG8geW91IHByZWZlciBaT05FX1NQRUNJQUw/IDopDQo+PiANCj4+IEkg
Y2FsbGVkIGl0IFpPTkVfUFJFRkVSX01PVkFCTEUuIElmIHlvdSBzdHVkaWVkIHRoYXQgYXBwcm9h
Y2ggdGhlcmUgbXVzdA0KPj4gYmUgYSBnb29kIHJlYXNvbiB0byBuYW1lIGl0IGRpZmZlcmVudGx5
Pw0KPj4gDQo+IA0KPiBUaGUgaW50ZW50aW9uIG9mIFpPTkVfRVhNRU0gaXMgYSBzZXBhcmF0ZWQg
bG9naWNhbCBtYW5hZ2VtZW50IGRpbWVuc2lvbiBvcmlnaW5hdGVkIGZyb20gdGhlIEhXIGRpZmZy
ZW5jZXMgb2YgZXh0ZW5kZWQgbWVtb3J5IGRldmljZXMuDQo+IEFsdGhvdWdodCB0aGUgWk9ORV9F
WE1FTSBjb25zaWRlcnMgdGhlIG1vdmFibGUgYW5kIGZyZW1lbnRhdGlvbiBhc3BlY3QsIGl0IGlz
IG5vdCBhbGwgd2hhdCBaT05FX0VYTUVNIGNvbnNpZGVycy4NCj4gU28gaXQgaXMgbmFtZWQgYXMg
aXQuDQoNCkdpdmVuIHRoYXQgQ1hMIG1lbW9yeSBkZXZpY2VzIGNhbiBwb3RlbnRpYWxseSBjb3Zl
ciBhIHdpZGUgcmFuZ2Ugb2YgdGVjaG5vbG9naWVzIHdpdGggcXVpdGUgZGlmZmVyZW50IGxhdGVu
Y3kgYW5kIGJhbmR3aWR0aCBtZXRyaWNzLCB3aWxsIG9uZSB6b25lIHNlcnZlIGFzIHRoZSBtYW5h
Z2VtZW50IHZlaGljbGUgdGhhdCB5b3Ugc2Vlaz8gSWYgYSBzeXN0ZW0gY29udGFpbnMgYm90aCBD
WEwgYXR0YWNoZWQgRFJBTSBhbmQsIGxldCBzYXksIGEgYnl0ZS1hZGRyZXNzYWJsZSBDWEwgU1NE
IC0gYm90aCB1c2VkIGFzIChkaWZmZXJlbnQpIGJ5dGUgYWRkcmVzc2FibGUgdGllcnMgaW4gYSB0
aWVyZWQgbWVtb3J5IGhpZXJhcmNoeSwgYWxsb2NhdGluZyBtZW1vcnkgZnJvbSB0aGUgWk9ORV9F
WE1FTSBkb2VzbuKAmXQgcmVhbGx5IHRlbGwgeW91IG11Y2ggYWJvdXQgd2hhdCB5b3UgZ2V0LiBT
byB0aGUgY2xpZW50IHdvdWxkIHN0aWxsIG5lZWQgYW4gb3J0aG9nb25hbCBtZXRob2QgdG8gY2hh
cmFjdGVyaXplIHRoZSBkZXNpcmVkIHBlcmZvcm1hbmNlIGNoYXJhY3RlcmlzdGljcy4gVGhpcyBt
ZXRob2QgY291bGQgYmUgY29tYmluZWQgd2l0aCBhIGZhYnJpYyBpbmRlcGVuZGVudCB6b25lIHN1
Y2ggYXMgWk9ORV9QUkVGRVJfTU9WQUJMRSB0byBhZGRyZXNzIHRoZSBrZXJuZWwgYWxsb2NhdGlv
biBpc3N1ZS4gQXQgdGhlIHNhbWUgdGltZSwgdGhpcyBuZXcgem9uZSBjb3VsZCBhbHNvIGJlIHVz
ZWZ1bCBpbiBvdGhlciBjYXNlcywgc3VjaCBhcyB2aXJ0aW8tbWVtLg0KDQpUaGFua3MsDQpKb3Jn
ZW4NCg0K
