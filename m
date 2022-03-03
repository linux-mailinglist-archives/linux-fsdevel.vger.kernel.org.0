Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E6F4CC818
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 22:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiCCVd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 16:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiCCVd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:33:56 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7322E6BC;
        Thu,  3 Mar 2022 13:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646343190; x=1677879190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=byJXUiRD+DaIhtFM96lVtEdfFrk7HGquT0to1N2ALJQ=;
  b=N0YPNWgJ04wZXBBll9E0wf2VuPk3ihlUOIlLtiBgBUBmcHvm3hH/j4U2
   J7ZBueLv+GaPN4aINXr1gUuEVKO3ilxmGRQFFZR/Kfuyfy5Tm3ZPnAAIk
   xNtbvR/Z2JbsNBGc5NNoMWKjN1HgOJ4k+w2OgH26K3ghU0jp0e/vqoeDZ
   /dR7kZjQ4VE7YIzoUTEcKFOfU6jeBI+shxnEWdf0jwvu/r0oHYvpLNYcA
   n+m/lElxBcxxXfeWUKx4p/d2touQdgmGC48raB1SeOqgbEk2lCtbTW7be
   z6pS3bmeNNfnDvaM/ws4IkrCRAn3i0RnLrheMKgjTE5YF32l66a1cxT5O
   A==;
X-IronPort-AV: E=Sophos;i="5.90,153,1643644800"; 
   d="scan'208";a="298559271"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2022 05:33:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzBqPHNmXJP70sq0y0Bsak8k8ByFq9Dj7GLrfaLHNFJttT3G0tV2zOpQbEEXsoVEzGoEqL1qUvhXgH8A8kfOhNxC1P7LEwRlxRz+5BB9mh0BRS5zzOI7eBQkyz97EQEsAA3ppczLTtFF4sLGO4hexQlmLTRz8Z45p0sDyCK8DhYjy9PmfocqsnO4IU29wo3L7SqwOwVTDQfv+tAHpH/NswaC2O61ShpNpNFEWSZJhc0Go1Jt3pdMTAm2/GXrsDtdQN9OCuLjUI4yTDV7HrzJ0I907HA9MIq+Q18sXnaj4afq6CKdU9oIQ5lyAm4Fa4TzHpH1LlODWsSVhuN/QBkgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byJXUiRD+DaIhtFM96lVtEdfFrk7HGquT0to1N2ALJQ=;
 b=OmKmlsKuwNIr+0lhqexsmyReuMSjGDOFN4yAtvDHX7bZQwcjzftxzLStcbwgAEMdkU7HKq3WxzbfkB39IVcIqKPRVZuSVSJAoEy4wjc9JwcfDssmVkVRULOjmMCZ/iWgNdsyIxF1o+TEEeKqWKKvw5YChpP+Uw2+ppf2PQ9PJShcfD14ptm9hP9hznRJWf8+xhIljrtTXh8KxkwyF+Bv1Ni+Ajb8/HydupMhlo6i0Us7h11761vVlZxjTb/dAAsYwp2/UkUo7lTW34NASygDp070tXBfgfY68XYjF5x7u7MMlmAG47siYS75CZdBN4ReAwFfkf/nIA/NKIgZsAqoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byJXUiRD+DaIhtFM96lVtEdfFrk7HGquT0to1N2ALJQ=;
 b=epMO7hKA895ZPjTogiGrZ8mX3njLLsS/6vopGlhcphoaXKGYhiU9Zd7SW0QuBASNfPRTgA4mWzkPUsnqG83Gksf5S8gLVUs03vT+V37r2plBxG7p8gf9hZeRravy3xeNn0QVCloRhvK66TS0itbS2l8O/Digp1A/5zgHjrvY0bw=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by CY1PR04MB2377.namprd04.prod.outlook.com (2a01:111:e400:c638::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Thu, 3 Mar
 2022 21:33:06 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c%4]) with mapi id 15.20.5038.016; Thu, 3 Mar 2022
 21:33:06 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     Adam Manzanares <a.manzanares@samsung.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: RE: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmotDjh/nK/9UCnXW/KPy7zfqytIu+AgAAQCQCAADesAIAAVbsAgAAHhgCAAB4NgIAAIsKQgAARzICAAA6z8A==
Date:   Thu, 3 Mar 2022 21:33:06 +0000
Message-ID: <BYAPR04MB49686E8DFFF46555915F65BAF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
        <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
        <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
        <CGME20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b@uscas1p2.samsung.com>
        <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
        <20220303145551.GA7057@bgt-140510-bm01>
        <4526a529-4faa-388a-a873-3dfe92b0279b@wdc.com>
        <20220303171025.GA11082@bgt-140510-bm01>
        <BYAPR04MB4968506D0A8CAB26AC266F8DF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220303201831.GC11082@bgt-140510-bm01>
In-Reply-To: <20220303201831.GC11082@bgt-140510-bm01>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d887cc91-9d8e-4531-4363-08d9fd5d67e8
x-ms-traffictypediagnostic: CY1PR04MB2377:EE_
x-microsoft-antispam-prvs: <CY1PR04MB23771B12729A49464EF0B760F1049@CY1PR04MB2377.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wqrFaWIz6liyc8BIUrHBWLZ/cSu7wQD9hwHDm+7gSDNaEMp0d5eIbbyDAF1h9UDZRi+bROiUqLJpvgzcrFbYurRPzweVn7uqFWjFvGFYMMW2RGgXGd4xPlLNsGCtdSshitDpj6/yEY+aBHTr5lrTeguGWu5/U64R4fyv/aovw3/Q9nGFttGuNAeYtDDB/Yr7jD9HxqPvCIpYnTJzaE8s0I9jcSz6m6J7FAHgo/FILxpjWJjELSN6Fen/KMXH69Vr8sU/7b7J4AMmPtOgwKe8i1J8qt2eXPufYNJLrdKOMKEfn4VXZNTTXzqBMPdZgc4/gnVQgIysMiuLJqNEdrhS8hy1MrIuCuHsO5Am7I4PZqgUwagFbbE+5Wuaz9DsLT5ycrpw8MbHpIJzznrw6b+2Po4C15yZUXWvYoMd/K45bqA7jyaBH42clpXYEvDi6O/Qesl8ke+LF8cj0nzqxLOmN10lNESPSG2/UFJGao62pNmt8BZREKqW4P7lSmfRKQcAVWzWTXdf/1NzvstLGl7fXNlO1HcoVp8KSxRjZX6U7bjhz8GnIXkYoWdP67uteYRt6EVdAq/by9l+OlLBYqI/+K3MKJDfbi6/gTQyopw9a9pF1MFb71VM3Hy4XRmKMl2t/TnsYesBEDeE/SW/r8i9PhqtBz+YUp645OBXCNKnaTexbneVZ3rLqEJti7BAz9y+btsCbvmwNz0PQFHdMRtdWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(33656002)(2906002)(8676002)(38100700002)(316002)(54906003)(7696005)(6916009)(86362001)(6506007)(9686003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(71200400001)(4326008)(38070700005)(5660300002)(7416002)(82960400001)(508600001)(8936002)(83380400001)(85202003)(52536014)(26005)(122000001)(186003)(85182001)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVlWaVBOMDZyV1JsRFh3ampuQXF3aEFIbHN1LzROLzc5dzRYUjFZWkZUNnVG?=
 =?utf-8?B?QjF0eWNJdXFKRXowejF3LzRKM2lLT1p2L0I5QVlUM3ZTYVNIb2VzUVBCVVBk?=
 =?utf-8?B?TEtiV1hxSzlWZjJVSG15ZlhjSVJKNFgvTDE2SGdTZk5IUnZRY3lsbU1UU2ZQ?=
 =?utf-8?B?L0xYdkdEN29xVThKM2ZVMUVvUEJyZnRyRlFMdmUwRWlwT21YWDRwVFpoaXo4?=
 =?utf-8?B?UWViS2llRU11ZkN0NzhHdmtyN0xFMnhhUklTcjkzVXZ5MFo1MzU2WHluV2Vl?=
 =?utf-8?B?bzV3QnRoRUtjUVBkckFrRFI5dENuVWp1Wkw0TGJ1R2hpMS8zZ2RHT3Zkakly?=
 =?utf-8?B?WmpTN0hPZjVKRWxOQjNBRUgvMWdJY1dnVitmc0E4ajYyd2lrWmxWVk9HWCtI?=
 =?utf-8?B?ZHlETW81Z3NyT3A3WXVCSUpOUXg5NUVOdVlhcVhveGhtTW9SWGl6L0lYekdB?=
 =?utf-8?B?RlhlcWwwZFo4cFdyQVRUWno2WUEzY28xMTZXaWw2aHlIcHZwWWx4dGxUR3N0?=
 =?utf-8?B?anVubmVvNFc1OVBoZmpTdURjT2tjRUdwOVdpSVZJTUk4M2dlRG5NbXlSdkVS?=
 =?utf-8?B?NE51U2FvS1RqVnlTU0JHZzlBT0RuVnpxWExudjRmMU1qYU5UVU5rSjI5WDJX?=
 =?utf-8?B?Q3FNMFdvMmRUcHdGUFEzV0FOZUJZZHJrMGNQb1ZZeFZYNDk5OVl2b205bTBx?=
 =?utf-8?B?R2ZKZkNMK1krSEpsWUE5OTQxdWxmQU9idUNiWSt2anRZN1gzc1c4NUcwS21S?=
 =?utf-8?B?VzkxekZWQ0xXQzZNeTFFeTdhd0dkWjB4TzhBMm0zZ0RKV0llUXlBbUJOZmc5?=
 =?utf-8?B?RjZCTFZESUN5VVI1azhWSWFoSHlEaE9aTkpqT3JTOUR0clZtOG9KWUo1RkpU?=
 =?utf-8?B?djI5N0Z5YXVwTGhLZ0d0VkQwQVhVMmh0S0x0bUl5bGtIK3IyN2ZmeXFONjEr?=
 =?utf-8?B?S1ZtajdINThTenpGNE1IazRnYmQ1SlpNUU8zTHhmTE4zMWJZblBoVWd6L2Jm?=
 =?utf-8?B?S2dPVkxTMVpLT3ZqYURUcWI0QVFJYzZFWFRhajhkM2JwN29RckNFZXhRSUo1?=
 =?utf-8?B?U3hNMG1HUFBsR1JmYWJCNmJSTjBVZTVqanAvb3llK2dmRjVLeU5BNnlBdk1J?=
 =?utf-8?B?K2QxVlA4OUxmRjIwdXJUbHNxNVFRVFBtTFQxOGE3RXdmRkxmT1pydlRuMncz?=
 =?utf-8?B?ZmMrSnUySXdCYU1xemQwNlh4OXRSWjlDUWFVVEVVNS9zdlQyQnRPR2lpcnBE?=
 =?utf-8?B?L1BlMGxWckZrMzVFL1lPRm9Qak8vZTlLYmxqWjdYVmdFSU1KOXVtbkpFZDA3?=
 =?utf-8?B?emJvakIrVmh0WHo4bXpidnlzb2RwVnlEakhPVWRkWU14Smk3SkdRM0JKZDVa?=
 =?utf-8?B?UnpPSXRZeitONlhwVEthQlY0RnZaOGF3WmoyZXB4RGRyMmpkSXZLQTUwWEVH?=
 =?utf-8?B?b0JJN1QrbEVnczQ0V0ZtZ0d4MVZ4cTAxc3RHRUpsdmNldXc1NGtNY2pqTVFF?=
 =?utf-8?B?OXhsQWpHRHBqd21YNUFDbzYzekZjWFkvYk1KSnNYaGhqTEJIOEFhdUs0ZTIz?=
 =?utf-8?B?NXVYSXh0Z0huZVd3cjUvUzA0MFZVRXMvdTlFMWo3TkJ0SXRtOGRHRG5sRld4?=
 =?utf-8?B?dlppMXU4VXZBbElXNWFiRE5TNFplZW9mUEFHS1lPWFlmYW5iR29SSjZOYmh2?=
 =?utf-8?B?cFMvaXdOMTZ4Wm1nZFJjV0pOUnQ2QzlzV1U4SE1YM2daVkVpMmJKTlBOSHdz?=
 =?utf-8?B?ZC8vQVAzcTkwQTdRNWhSd083WDBiOEIrMzJiT0ViSUg2OENkVWxzWXFRbFZq?=
 =?utf-8?B?VXN3M3BXR0wva0N0RmNrelNYcmlzck1tTjFwV3EvSHBRem1oTk15bFQveUdm?=
 =?utf-8?B?WTA3UDRSYlJpTU5yOW1sMjlzZlJYQUl2NHRPZ3FtNVRBaTBYZG1jamViUjZj?=
 =?utf-8?B?MTZ5NmNuSDA2aS9CVCtFREprSXNEU1RmNkx2Uzc5VDlMaWxudDBzdGl6T0Yr?=
 =?utf-8?B?LzVHNm95N1JaQ0N5Ukk2T3VYSFhEbkdxb3Y0RVZUZXROMmNQaDlUT00relFa?=
 =?utf-8?B?ZU80SEhzN1dIdWo1a0NySFh1TWZXTzNuazEvQVppVHdldE5JTWtRK3dSL1FT?=
 =?utf-8?B?OVJCNm00aUhYb0hVQmNzUzFrSGlwL2xsRnFuSUdObS9tU3R2dm5kWTZBQXhn?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d887cc91-9d8e-4531-4363-08d9fd5d67e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 21:33:06.5134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8lJZh9QHw9ftpB7C6ZWGDPV3i6UHDtmffUCwyuxZ8oEzKjBOFCBp7w+ZqjL4Kru0vfBvtkr+A6r5hYzslOu6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2377
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZGFtIE1hbnphbmFyZXMgPGEu
bWFuemFuYXJlc0BzYW1zdW5nLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDMgTWFyY2ggMjAyMiAy
MS4xOQ0KPiBUbzogTWF0aWFzIEJqw7hybGluZyA8TWF0aWFzLkJqb3JsaW5nQHdkYy5jb20+DQo+
IENjOiBEYW1pZW4gTGUgTW9hbCA8RGFtaWVuLkxlTW9hbEB3ZGMuY29tPjsgSmF2aWVyIEdvbnrD
oWxleg0KPiA8amF2aWVyQGphdmlnb24uY29tPjsgTHVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtl
cm5lbC5vcmc+OyBsaW51eC0NCj4gYmxvY2tAdmdlci5rZXJuZWwub3JnOyBsaW51eC1mc2RldmVs
QHZnZXIua2VybmVsLm9yZzsgbHNmLXBjQGxpc3RzLmxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsg
QmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+OyBLZWl0aCBCdXNjaA0KPiA8S2Vp
dGguQnVzY2hAd2RjLmNvbT47IEpvaGFubmVzIFRodW1zaGlybg0KPiA8Sm9oYW5uZXMuVGh1bXNo
aXJuQHdkYy5jb20+OyBOYW9oaXJvIEFvdGEgPE5hb2hpcm8uQW90YUB3ZGMuY29tPjsNCj4gUGFu
a2FqIFJhZ2hhdiA8cGFua3lkZXY4QGdtYWlsLmNvbT47IEthbmNoYW4gSm9zaGkNCj4gPGpvc2hp
LmtAc2Ftc3VuZy5jb20+OyBOaXRlc2ggU2hldHR5IDxuai5zaGV0dHlAc2Ftc3VuZy5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbTFNGL01NL0JQRiBCb0ZdIEJvRiBmb3IgWm9uZWQgU3RvcmFnZQ0KPiAN
Cj4gT24gVGh1LCBNYXIgMDMsIDIwMjIgYXQgMDc6NTE6MzZQTSArMDAwMCwgTWF0aWFzIEJqw7hy
bGluZyB3cm90ZToNCj4gPiA+IFNvdW5kcyBsaWtlIHlvdSB2b2x1bnRlcmVkIHRvIHRlYWNoIHpv
bmVkIHN0b3JhZ2UgdXNlIDEwMS4gQ2FuIHlvdQ0KPiA+ID4gdGVhY2ggbWUgaG93IHRvIGNhbGN1
bGF0ZSBhbiBMQkEgb2Zmc2V0IGdpdmVuIGEgem9uZSBudW1iZXIgd2hlbg0KPiA+ID4gem9uZSBj
YXBhY2l0eSBpcyBub3QgZXF1YWwgdG8gem9uZSBzaXplPw0KPiA+DQo+ID4gem9uZXNpemVfcG93
ID0geDsgLy8gZS5nLiwgeCA9IDMyIGlmIDJHaUIgWm9uZSBzaXplIC93IDUxMkIgYmxvY2sgc2l6
ZQ0KPiA+IHpvbmVfaWQgPSB5OyAvLyB2YWxpZCB6b25lIGlkDQo+ID4NCj4gPiBzdHJ1Y3QgYmxr
X3pvbmUgem9uZSA9IHpvbmVzW3pvbmVfaWRdOyAvLyB6b25lcyBpcyBhIGxpbmVhciBhcnJheSBv
ZiBibGtfem9uZQ0KPiBzdHJ1Y3RzIHRoYXQgaG9sZHMgcGVyIHpvbmUgaW5mb3JtYXRpb24uDQo+
ID4NCj4gPiBXaXRoIHRoYXQsIG9uZSBjYW4gZG8gdGhlIGZvbGxvd2luZw0KPiA+IDFhKSBmaXJz
dF9sYmFfb2Zfem9uZSA9ICB6b25lX2lkIDw8IHpvbmVzaXplX3BvdzsNCj4gPiAxYikgZmlyc3Rf
bGJhX29mX3pvbmUgPSB6b25lLnN0YXJ0Ow0KPiANCj4gMWIgaXMgaW50ZXJlc3RpbmcuIFdoYXQg
aGFwcGVucyBpZiBpIGRvbid0IGhhdmUgc3RydWN0IGJsa196b25lIGFuZCB6b25lIHNpemUgaXMN
Cj4gbm90IGVxdWFsIHRvIHpvbmUgY2FwYWNpdHk/DQoNCnN0cnVjdCBibGtfem9uZSBjb3VsZCBi
ZSB3aGF0IG9uZSBsaWtlcyBpdCB0byBiZS4gSXQgaXMganVzdCBhIGRhdGEgc3RydWN0dXJlIHRo
YXQgY2FwdHVyZXMga2V5IGluZm9ybWF0aW9uIGFib3V0IGEgem9uZS4gQSB6b25lJ3Mgc3RhcnQg
YWRkcmVzcyBpcyBvcnRob2dvbmFsIHRvIGEgem9uZSdzIHdyaXRlYWJsZSBjYXBhY2l0eS4NCg0K
PiANCj4gPiAyYSkgbmV4dF93cml0ZWFibGVfbGJhID0gKHpvbmVpZCA8PCB6b25lc2l6ZV9wb3cp
ICsgem9uZS53cDsNCj4gPiAyYikgbmV4dF93cml0ZWFibGVfbGJhID0gem9uZS5zdGFydCArIHpv
bmUud3A7DQo+IA0KPiBDYW4gd2UgbW9kaWZ5IDJiIHRvIG5vdCB1c2Ugem9uZS5zdGFydD8NCg0K
WWVzIC0gdXNlIDJhLg0KDQo+IA0KPiA+IDMpICAgd3JpdGVhYmxlX2xiYXNfbGVmdCA9IHpvbmUu
bGVuIC0gem9uZS53cDsNCj4gPiA0KSAgIGxiYXNfd3JpdHRlbiA9IHpvbmUud3AgLSAxOw0KPiA+
DQo+ID4gPiBUaGUgc2Vjb25kIHRoaW5nIEkgd291bGQgbGlrZSB0byBrbm93IGlzIHdoYXQgaGFw
cGVucyB3aGVuIGFuDQo+ID4gPiBhcHBsaWNhdGlvbiB3YW50cyB0byBtYXAgYW4gb2JqZWN0IHRo
YXQgc3BhbnMgbXVsdGlwbGUgY29uc2VjdXRpdmUNCj4gPiA+IHpvbmVzLiBEb2VzIHRoZSBhcHBs
aWNhdGlvbiBoYXZlIHRvIGJlIGF3YXJlIG9mIHRoZSBkaWZmZXJlbmNlIGluIHpvbmUNCj4gY2Fw
YWNpdHkgYW5kIHpvbmUgc2l6ZT8NCj4gPg0KPiA+IFRoZSB6b25lZCBuYW1lc3BhY2UgY29tbWFu
ZCBzZXQgc3BlY2lmaWNhdGlvbiBkb2VzIG5vdCBhbGxvdyB2YXJpYWJsZQ0KPiB6b25lIHNpemUu
IFRoZSB6b25lIHNpemUgaXMgZml4ZWQgZm9yIGFsbCB6b25lcyBpbiBhIG5hbWVzcGFjZS4gT25s
eSB0aGUgem9uZQ0KPiBjYXBhY2l0eSBoYXMgdGhlIGNhcGFiaWxpdHkgdG8gYmUgdmFyaWFibGUu
IFVzdWFsbHksIHRoZSB6b25lIGNhcGFjaXR5IGlzIGZpeGVkLCBJDQo+IGhhdmUgbm90IHlldCBz
ZWVuIGltcGxlbWVudGF0aW9ucyB0aGF0IGhhdmUgdmFyaWFibGUgem9uZSBjYXBhY2l0aWVzLg0K
PiA+DQo+IA0KPiBJREsgd2hlcmUgdmFyaWFibGUgem9uZSBzaXplIGNhbWUgZnJvbS4gSSBhbSB0
YWxraW5nIGFib3V0IHRoZSBmYWN0IHRoYXQgdGhlDQo+IHpvbmUgc2l6ZSBkb2VzIG5vdCBoYXZl
IHRvIGVxdWFsIHpvbmUgY2FwYWNpdHkuDQoNCk9rLiBZZXMsIGFuIGFwcGxpY2F0aW9uIHNob3Vs
ZCBiZSBhd2FyZSBob3cgaXRzIG1hbmFnaW5nIGEgem9uZSAtIHNpbWlsYXIgdG8gdGhhdCBpdCBo
YXMgdG8gaGF2ZSBsb2dpYyB0aGF0IGtub3dzIHRoYXQgYSB6b25lIG11c3QgYmUgcmVzZXQuDQoN
Cj4gDQo+ID4gQW4gYXBwbGljYXRpb24gdGhhdCB3YW50cyB0byBwbGFjZSBhIHNpbmdsZSBvYmpl
Y3QgYWNyb3NzIGEgc2V0IG9mIHpvbmVzIHdvdWxkDQo+IGhhdmUgdG8gYmUgZXhwbGljaXRseSBo
YW5kbGVkIGJ5IHRoZSBhcHBsaWNhdGlvbi4gRS5nLiwgYXMgd2VsbCBhcyB0aGUgYXBwbGljYXRp
b24sDQo+IHNob3VsZCBiZSBhd2FyZSBvZiBhIHpvbmUncyBjYXBhY2l0eSwgaXQgc2hvdWxkIGFs
c28gYmUgYXdhcmUgdGhhdCBpdCBzaG91bGQNCj4gcmVzZXQgdGhlIHNldCBvZiB6b25lcyBhbmQg
bm90IGEgc2luZ2xlIHpvbmUuIEkuZS4sIHRoZSBhcHBsaWNhdGlvbiBtdXN0IGFsd2F5cyBiZQ0K
PiBhd2FyZSBvZiB0aGUgem9uZXMgaXQgdXNlcy4NCj4gPg0KPiA+IEhvd2V2ZXIsIGFuIGVuZC11
c2VyIGFwcGxpY2F0aW9uIHNob3VsZCBub3QgKGluIG15IG9waW5pb24pIGhhdmUgdG8gZGVhbA0K
PiB3aXRoIHRoaXMuIEl0IHNob3VsZCB1c2UgaGVscGVyIGZ1bmN0aW9ucyBmcm9tIGEgbGlicmFy
eSB0aGF0IHByb3ZpZGVzIHRoZQ0KPiBhcHByb3ByaWF0ZSBhYnN0cmFjdGlvbiB0byB0aGUgYXBw
bGljYXRpb24sIHN1Y2ggdGhhdCB0aGUgYXBwbGljYXRpb25zIGRvbid0DQo+IGhhdmUgdG8gY2Fy
ZSBhYm91dCBlaXRoZXIgc3BlY2lmaWMgem9uZSBjYXBhY2l0eS9zaXplLCBvciBtdWx0aXBsZSBy
ZXNldHMuIFRoaXMgaXMNCj4gc2ltaWxhciB0byBob3cgZmlsZSBzeXN0ZW1zIHdvcmsgd2l0aCBm
aWxlIHN5c3RlbSBzZW1hbnRpY3MuIEZvciBleGFtcGxlLCBhIGZpbGUNCj4gY2FuIHNwYW4gbXVs
dGlwbGUgZXh0ZW50cyBvbiBkaXNrLCBidXQgYWxsIGFuIGFwcGxpY2F0aW9uIHNlZXMgaXMgdGhl
IGZpbGUNCj4gc2VtYW50aWNzLg0KPiA+DQo+IA0KPiBJIGRvbid0IHdhbnQgdG8gZ28gc28gZmFy
IGFzIHRvIHNheSB3aGF0IHRoZSBlbmQgdXNlciBhcHBsaWNhdGlvbiBzaG91bGQgYW5kDQo+IHNo
b3VsZCBub3QgZG8uDQoNCkNvbnNpZGVyIGl0IGFzIGEgYmVzdCBwcmFjdGljZSBleGFtcGxlLiBB
bm90aGVyIHR5cGljYWwgZXhhbXBsZSBpcyB0aGF0IG9uZSBzaG91bGQgYXZvaWQgZXh0ZW5zaXZl
IGZsdXNoZXMgdG8gZGlzayBpZiB0aGUgYXBwbGljYXRpb24gZG9lc24ndCBuZWVkIHBlcnNpc3Rl
bmNlIGZvciBlYWNoIEkvTyBpdCBpc3N1ZXMuIA0K
