Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4936695CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbjAMLkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbjAMLjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:39:10 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEC37A230
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673609420; x=1705145420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=CwFC9d4eBrnxTsfKSe46SZ52FncGG5kgfUbsDxdcuz+tN3MjEZHLU1vj
   byOwqHrDJ2akQhOJ0ihp7cOhuDntdxRam8lydmLMTza8bWvQeESKOk0S6
   v+uxxo0kIlmLdVYqHser8ovPj3VB93swUKjjdcqWskAuXrLgPulGiIzCN
   GpVZ7TWR/lu5y/LOeZiGQ5yxsVnIbh5ajK5+mztxSgGjoCDGcCjSPreku
   boaFjw64w9pOuVuEA5sDsPWNNyVpu7XKgMxDE8um9EZPWL5b62dHFY52U
   4Nm2vAd0pYux8q3EnCfbRKDiuk6EFKQhF0i7SQPbLo1vq1hN1Vmp4P2W6
   g==;
X-IronPort-AV: E=Sophos;i="5.97,213,1669046400"; 
   d="scan'208";a="220838285"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2023 19:30:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZ8822K3nNscKPDybUf16g2tQP3+/NJirXfBHmXgGIu80eUN87kPXBaNb81gWEjXI6VLIIvW80za+lpD1XGYHHZeqrWqKUmsqkmXrq2RCyS4SfUx5BoDbnec0/9V7Ymng8dyqmDPKhcdOuntfr7hgsP7Sn4Dshn0dc1SRzIwjUuSur5EdWCyh4TGzF+AwmbWW2mxNLCozuZYTSHVNYptB11U+z9SadP8V0sxAP/d+RPJq4TgMURzAxOuS70tEAgt9x0ImtHyA6H6uWAgi6gm/81lQkj7hZIXecq+1eo+hEeZSRAChEFJxJ1qslfOBn8OT9qgA3qTnjWT3EPv6HPzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=JKT0XhX3Q0lalGSeqmlyWlNiXypXFeBFapEnDMNUKXT6Dl9xEgCcAVWHtmm++HyVUxkHTDpJRdmc6TwR2NuO9oOPOVnY8eeJ+oVrhmfsIwuQ07MvGpC8SZ0rRJpFVAydRpr+p6cc+VUciBCNWTRGsyU8rG6zDqOuUJ1pkHhzzvYG8s3jtR1muMgJWRD8g28RyUNLKhdv2TTMg15TLcNjpySlB6vx/n27OqOD/QLMPH4i1J6IECkzqgYr9sTwtBvkqqsapeEuotnxpK8Fqon1kBUFItZfzKp0GmqoALRCJ5LG2tBmRGd3KI11/ygvpbDwweIfV/1laii+NKyQjcjf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=yIquDxVeDKZg62fULB9VPi4xusCbIYQhDoYPWL7McqVn16Adwul1XGilhlgIk5rY2NW8Q84vr9BEBmj5U/LTofQJhFfZmSzlBuUk6ai3PHhYdciY/ltQ9jPJPHJUqzfKrHSgAZLrPbDdLcPKDrGzQ0JYNgNC15Bg8FTovXGu878=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7663.namprd04.prod.outlook.com (2603:10b6:a03:324::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 11:30:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 11:30:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
Subject: Re: [PATCH 5/7] zonefs: Separate zone information from inode
 information
Thread-Topic: [PATCH 5/7] zonefs: Separate zone information from inode
 information
Thread-Index: AQHZJPSsFHMvvF7vaU60/PJRD7e1iK6cOuaA
Date:   Fri, 13 Jan 2023 11:30:16 +0000
Message-ID: <65034ad0-7f7e-c594-d015-003547cab84d@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-6-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230110130830.246019-6-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7663:EE_
x-ms-office365-filtering-correlation-id: ca8f349f-436b-4780-050e-08daf5598b3b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hwTqBmwW002SJCXz/mIyjN4ZFA5DxTK2HwIeT5r1hEyWLjFvo9RRtue6PqQ5g01HkJ5ALh8ISL4pBd0rRKWn/Yy9/D5r3DHaAX5fziaBsaBjt/cOCYwQnBvm65HzrV8ZNpTFKoZ1+pOXJZHkYPdm30rjyi/9CzNWz9ubMWecH+Sn3N7xGL8vELIThO2utEOwZsKEQVKhpupWvtpItnEElTqf9HzgQPOWC/pKiTDaCdVABNuIA2Reoo9I5a5itcWiB+dA3LfQqIH1lk2CkxxKvssPG9+CDPb4DymomUYq5RE5Ylw1AMe5/FmiC5F1plufX01YYJeqUCaeSTXbIDK+ZiGifz5waOCDgMvsiLnBs1qNsmPBkmNs1UpeU7TQEFV6SVZybwP6CrvS/U9Q0fDGd3DPU+DWl7FljDvJG62GYjAmCzKlMCoT9Qpysa9acWtCW3U6iRJYFsnQFqS0GkscQJFA25YdabNN+m7cTWInBfGVmJhYiWj4HiADxU6RwHJSfEhWAoLqc/qhwAC73JH4YsWuO83UrEOJNfVFgoAgIYPa4ntLlTq4pY2SEtVks5Aq/nc/4gRkuEDRcfs52UP4SaK/luqt2eCkdyXJt85qE/7jge+lBty3HcCrM1y2mY/ENGZ5lDdXRAGOaoMYuwWAuWdreri2LvntbQJ1P/owXW79J1hvaDsRppxXErLXGW8zQdP4bwDIVgFBC2FLHIxx3Dd+ti4Vr7bY271z6na6u/8p4XBr9RBuBQG4Nscb0fm8AgbF9hwxPrwwArLycIvkvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(71200400001)(36756003)(558084003)(2906002)(82960400001)(5660300002)(8936002)(41300700001)(19618925003)(122000001)(31696002)(91956017)(66556008)(38100700002)(86362001)(110136005)(66946007)(31686004)(4270600006)(38070700005)(76116006)(8676002)(186003)(6486002)(2616005)(316002)(478600001)(66446008)(4326008)(6512007)(6506007)(66476007)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WndGQVRaTWVhUmsyenpGa2dDeGVRNWxSWnIxVlMxZ0FpMFpkVHRpMHMwMXVj?=
 =?utf-8?B?Z0h0UzZNT1drMXFWZUNqWTJENEU0NnJ4OGhHNUtHOGQ0UUFLelZuUHVMbXpM?=
 =?utf-8?B?WSt1Uk9aem1uTDJ1eTdyZ0dTWFRxZHNPNlFMSG0wYVFYYUlIMU9NQ2UyTzlw?=
 =?utf-8?B?OVdSU0pCam00ZzVGZFp3bVdEUWI5Z2x3enJ4RDFzYWsybmVWRGhDNnN4bmdv?=
 =?utf-8?B?S2dRb3hvRlpKNGhLajFiYjh1M2F5NDJjRHlZMkhhYlN0ZmJWb28yMkkrQnhi?=
 =?utf-8?B?TEZYSGs0anIrV1VSaFN6RkNYc1BqVHpWcDNSb1NGclc5aWI1bHpPSGs0LzdO?=
 =?utf-8?B?SHUzUU9ORS8vblUrdW5aWmlKNlN4RTlNQ204SnRTd0VGSHV1anZVczNYdjBw?=
 =?utf-8?B?Nlg3LzM5QjNSNDJzcEtoRGZGSTg2NzNQV2NhcCtyWjNuZlZ2RlBaR0JibmJN?=
 =?utf-8?B?T1M5WitGM2JDUlpUNTNGNFduM1JiaERpYWFtTlJtY1dEUnlyYm5uNTN3ekpP?=
 =?utf-8?B?Y1JOMHJDeC84NmtNUjhhU3lLWEhkSzU0bElYalp0V0NsZnA5eDNaSWJINTlS?=
 =?utf-8?B?ZTFrR1FOTE5hckNUWm4rVDF3akllSzdHc0dZQiszdzltV3ozWmVpMzhsVmQr?=
 =?utf-8?B?NncxL1M1S2EzRCt5TThkd1doelFzbDhFc01XbHRoUFRUSE9mWjlpdERDTks0?=
 =?utf-8?B?VHJaYTJhS1NZazZhVkF5V09wK0JOaktrVlhoMGF2Z0pBa1puczhsY0UxQUd3?=
 =?utf-8?B?WSs1YnlKMWRSelJiTy90RXI5SmhHRk1nOHlBeEJjbXZqKzJRNnJTKzMweVgw?=
 =?utf-8?B?UGc5RlM4OEJoV2YzZ0ROVEt5ellpZlVlY05hMHowUktNZ29mdEJham9yd294?=
 =?utf-8?B?TzNveWptU01pdWlZamcwc21vaHRBSDdmQlN6c3hNKzNoeXk1YkRtQTVFWFpQ?=
 =?utf-8?B?VEN4cENKaUVYMU96RDZxbG0yWFlsZVRWSWhWajlWd0RPTWR0dUtLMUtNK0lS?=
 =?utf-8?B?VXRGNm1hTDBTSHBUZ1dzTDFnSHlQK252eXlKaWN2Y2Z2Q0t3UTNoUDlvK21B?=
 =?utf-8?B?N1JGaFdrQUhEZHV5bHVSeXRlblFPbEJoL2hkOEY3bTV1cHdmR3I5WDdIa3JC?=
 =?utf-8?B?dUJqZTUyWE1Qc2c2UklLbDBkMk5kY0ZUb3dzMVNZRFJ2YUhsWkZkS05mVTZ0?=
 =?utf-8?B?L2Z1citLcDNZL21NdnRvMGxJNjE0Y2tEUFcxQ2FzcFN4NmlRYWl0ODdnN3Bq?=
 =?utf-8?B?ZlN1dklMcUQyUVVEalAvcUZic2xzYTlCSDA1OEZWS3JZRU1RbVZISnZxck9t?=
 =?utf-8?B?MEdHdjNBNUF1R3JWZlo1Z0lpV0p5alhOTTB1MDBwcDJrWWZoZWdEUmNLN1pF?=
 =?utf-8?B?clNXZ1FjTnpEN3paZk1IM2RuVGMxNXIxZ3NtMUpYUnU2aS9ENFllRlZvbEFh?=
 =?utf-8?B?amtXRU1PVjR1V043R0MyZlNFOFRrU3RFQ0tlQ3pVMEhTazRPMzNVdjAxdnVC?=
 =?utf-8?B?bGJmVGlMUUw0OG9maVl6Si91eVRRWm4wTUFLaHdJemI2WVNRVE0vaWNhL3p1?=
 =?utf-8?B?S0lKM3JraW43QTNiU2thR0J5dEdvNEN2YmE0TjFMR3A5c2IwUHl1WDliQUNL?=
 =?utf-8?B?cHB1cTFSVFFIbzhKbUNpRHdCZUtrWGFlNnBMY3QzWmtnQU5ZN21pcHVRMVVx?=
 =?utf-8?B?SE9oczNUOElWSnZJZ0N0Q3lSVmY4Y2lwNmJyUDJmQlpDQUFqWlFKQ1JSMXYr?=
 =?utf-8?B?ZDhCMkJvaU5EZlUzZnRDb1daZWpBN3JSQjlsLzl5cFJoUDhSRnlxL1BnQ2FQ?=
 =?utf-8?B?SzlqU3A1RWdiblFqQ0lpSzJYMmxoRHlDcVNVenFpdGx5cDRBYTJ5blo4Ym05?=
 =?utf-8?B?V21wc3BxRVFHekZvNm5DQVB0anZPdGxXL1ZZdVI1T3IxaUtmUkR2Lzk2VVVm?=
 =?utf-8?B?ek9XZnhsaERYcDNVdEE0NFFNUFgwNnBhWWJQWGVBM29lMi9panBCYlRHQUxJ?=
 =?utf-8?B?a1BEbm5HOGRCaTZKUUlZaUJGTDJLNGl1bXZJOVgxaDViQ0NlTk1RNSsreGJZ?=
 =?utf-8?B?N1p2eUpwYlpWTVE2LzQrN0dBdS9jOVZOTVpyUmdwNHExVit4U0NwUkRpSEk2?=
 =?utf-8?B?cE9VcThUd2FWTDVlVzZyZ3NBUlVJaTI4MC9ZaVY5b3Z2cm1MT2FmZ0RmSTdp?=
 =?utf-8?B?TTI2ZGc5MG9BVWU1SVdZN0t4NW8rRFlRNmZ4b2NUWHl5SXhrMDg5d0d2eWZr?=
 =?utf-8?Q?uvTvSGaG+YM8cm4t44a5wpcHvP0v/+p77kruzR8mXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4F4324CACAFE041AD2F55510DC01C0C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HuIKWmPDxLtTsfjdFrDTAqv87QyZlP5VRs/H9YWQwdlvQl0rJpSi4pDUQMt2r4ocPdMXLLv4JuA+ZfM6b2ENHTX6L3hvFyjP7mIn8ZcwgkIQUg2PHJF8wr+CabELSKdmCxL3YnghTp58hqUAMKBjlZrcHi9gvgLGDb8igzgpu+vlnaKiJgc8Xl453zQqzWbWC0upYK4ooTNEsAtkLHTHUjSCx64nCUvRMKMnD+KLvtUA/a0P09kMqkPqXFgdQtxeJYlEos3/beFUjL96BAJ2T9dt6sadRDT0mZDC6MruhSq1uv2gaMN3PLBuDNbOTyI0i14WpTI8FHiVuyouOdLNfKA2UbCcT5fjU9GRQUPrZRqCfIuVXUyx4jgSwJrgxYNBzorIUjU+gVpw5gy///h/2h63e0/3K+uBOafGNHPCHfii3RKoq6apKXj+5eXEBaqsYl3cWKENp9/kmx9BKx99rVH4PuK4APelObAnXxlh7MeRcGekPZagzloopYWp9+r/fS+Us/DIltYYm9H5AeDZk+Ft7UytH/yZtZQ/ilObX1IwZu8ADtHHXhu065jYvdAuJzff8bmoFMxkBst5bDZPLlTcdhu2QX+BCxdeRs6neoboweA61pQktqgN+O2M+SzaK6ZFoOqq23DdH+rG5Skzf3WInZH9QKcTVDqiIT6OvpfPAlo8bOA35PW+l1HOw3cQbBod3szS5c5/J8wrZAPH2beiUIuHKnWhL9peHVAbgDm74eclJq2uhD4UCSSytEe/SJ6Pbz/aLw3pV3ZVheK73N3X0enh8erHV1/3GopZOz8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8f349f-436b-4780-050e-08daf5598b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 11:30:16.2516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LA9E3gPMLKb9IZbys/w51QY3PyA0tRuGvACguAxqmAGWvg8KLGRGllDt6Hktbvzw6OuW5ihSmCnY0qS9OG1kG+hViMpxs6z2+v7BL6YbkgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7663
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
