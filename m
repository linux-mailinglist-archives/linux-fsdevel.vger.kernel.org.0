Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7EF50F125
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 08:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244657AbiDZGjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 02:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiDZGjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:39:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251631A83E;
        Mon, 25 Apr 2022 23:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650954999; x=1682490999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+oo7FmaBSUq+QTtKVVK3ZTfmywfUYjZ3FXCYWmNmNCs=;
  b=c+I5jbF0fqdJvYF9FLnrXfu2IFChavbSZJ9fAXxDoEgCtPkLeewdhLzz
   mxopun1Z4wR1JG/PJLyT1jw93efIjtpuRQQyWVyokf+tvBgOXLI+aK/mi
   TDDH6d7GzkYOIIv/eRc84SwhpT7T7rnah4SNfhu3S1FLpUSnns2kC8p3X
   JrgvKeMI5DK/O0crZTd67oq5C3O/Pk+xznHmN0weaUC9FF/sDdZUChDP/
   BQRelgUZZkEazU8O5lsCHTnauXjmzOjvrhIW1HxCe6sTAgnYANBvxpeUW
   gU40Y9070gsxQoMg3GLETG/HoJ8gXjRn0xqggXQNeuerAqNczE3CO9Abq
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,290,1643698800"; 
   d="scan'208";a="170903809"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Apr 2022 23:36:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 25 Apr 2022 23:36:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 25 Apr 2022 23:36:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHfJFmdebPmaZ3ZEyl3O9E6RngBB5UgJ8o2wMwntL76Y+OF/k6HtxQkKnlTlyIUCS16YJepLgs8OiO7+XVa1h4D+0DyqH1YL1ponX6mmgMmdZ6UNa/YkaYfkjQZt9u2IeG7IQ23rIrviSy1muZ4MPL+sLhal2FMYZNROj2zqr+XGIFEsqDiYZO7ue9ncdHgXT85rxLMwt/AvX1FA+9CKyll8C3/v/CQBsm3bzpn6YZiansU10kc2DcNT+CF8evLu9xwxsSItYgFJKd0Zy66ohnXlQsqdMXvLCbPC+cDlrxu7U97BvEZUs8Bl+fUhcJ0vKOl1C2hlnEOTiUfUd/LlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oo7FmaBSUq+QTtKVVK3ZTfmywfUYjZ3FXCYWmNmNCs=;
 b=KS6kZB0FKyq0gpip2PTukskrDMalhqtxPKLez69x9UverPF3kNsn5Y+TtsmZxoG4Na7ESnvurE0CAPLBbA3zI+zSZ8eMqYOqjdyT93ZRXfUnMErajBB9vCPblMIbPr2jFt2ikm9ZVChan/uCZs2qrpYcDCojnD4TLupkYCldRiMUs3+9vxOn7lj1k0E8HSJVoLZpa7YYvswO4jDKK1nPdwel78cKcIcr71BfDhT0epIW949pXhTA+DnMpQ5w/VUc3Q4r+WzAYeHM1RH0+aroyc4HrI9h19cuqrXcTko0mkT11vnQlnKGXTUiqj3ZjbEtfFePwRFc6aFpCEAux5bq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oo7FmaBSUq+QTtKVVK3ZTfmywfUYjZ3FXCYWmNmNCs=;
 b=ZQ0xmMvj4K0LayRBmiL2nIMFfUpg85Au4BYJa/SYy8cUNBxH1Uma1AlMaNaIBeyYysYE4721UhqL6JDZ1qouz8Ieo9p8JIAVSbjMqmLrpbZr/GQan50VISpWBpbwwfq503EYOk0eA//5JDJ+tWtNHQSTYro0WyD7zC4PGL48k14=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BYAPR11MB2743.namprd11.prod.outlook.com (2603:10b6:a02:c7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 06:36:27 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 06:36:27 +0000
From:   <Conor.Dooley@microchip.com>
To:     <rdunlap@infradead.org>, <sfr@canb.auug.org.au>,
        <herbert@gondor.apana.org.au>, <akpm@linux-foundation.org>
CC:     <mhocko@suse.cz>, <linux-crypto@vger.kernel.org>,
        <Conor.Dooley@microchip.com>, <broonie@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <mm-commits@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: mmotm 2022-04-25-17-59 uploaded
 (drivers/char/hw_random/mpfs-rng.c)
Thread-Topic: mmotm 2022-04-25-17-59 uploaded
 (drivers/char/hw_random/mpfs-rng.c)
Thread-Index: AQHYWRyV/fMQJQtyJ0OCBcAtYiaZ2K0BvZiA
Date:   Tue, 26 Apr 2022 06:36:27 +0000
Message-ID: <191e32d7-efde-327e-b112-000d8f778996@microchip.com>
References: <20220426005932.848CBC385A4@smtp.kernel.org>
 <6ff380c5-4f2c-44ea-2541-b32733e45ac3@infradead.org>
In-Reply-To: <6ff380c5-4f2c-44ea-2541-b32733e45ac3@infradead.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12da662f-0e9b-41be-7b4e-08da274f1733
x-ms-traffictypediagnostic: BYAPR11MB2743:EE_
x-microsoft-antispam-prvs: <BYAPR11MB2743045764B8DD07755DA11A98FB9@BYAPR11MB2743.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33LBaxX4Nhhu1MRy96aZrGowXeIs7wk2P0I2h/eloz8PxeQkVaF2KGoFvYXNUbIidZJHjGecvqJxX28tZmGhiyJu5wnTLz97W1eUHX9BIfFnDpZbC/exkYUbKvqvIcUN+jII1XtdQXlgOts4kcbk75KfnMamz4n4dk/hHPZ0P2SD/c9tY05N5HdgDnkiHXASdBwGf69uNDmcq6tthi4Pyde9s7/C/lF4/2wmtpp71j1rvJ4GfekQWGMqpI5VDNDqTckXVLRwPF/whyOT2/8s9onFViwnm3a2fW/bw2G75bZ+mX03kViJuoOWZAQN0wWxMSZWKt2aRjYjTUycIndxK7Kt+GrYLkkw85ap3woxngkqBOR2utawcwKHJZUC9F6m+bm3mnGtZVmjTnYT7sHehChEvkOQQGCFqz/IEGIsifZxgcPXYW8U0ykB6PrBPwInBhdql5i8XskZG1CowbNgtt0hf0ogjSRjB87KLsgkr7pWS0dLvwXENHKfvlAFl7GbJOB86hbwP4p6Jz/RN+DXzVP3DPYvbZTxCbKDH1LGcHnJKP9G0zR5yXIoR7MhS/FciCvLsmebiYKuwLdVdugkw2+koPk7nQKLA33B3zM7mr+p1Q4LfmjWXVyuzRlHF9m8FlBUeM3CYogO/OMCEsipsiCMmbbC7buXawajRPeWsLzJ6m/VmLcDa+yiKri2is+zt6n2QhHa6vsuS5VYZbZ5670DLym4tnv1uvonBjJnP8j86KFisP6WdIobQfmuEWTOito9f5/POaweCGx9LRrdFWN325NGvxuQH5Xj9NiGj4gPbFMjcdNBhq2gvASNczdIpKcK2j72jN4k7721FT5pxyTOX6kYHjOb7WT+IZt3pJM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(83380400001)(66946007)(4326008)(31696002)(36756003)(71200400001)(6512007)(66556008)(6506007)(53546011)(186003)(26005)(6486002)(508600001)(966005)(86362001)(2906002)(8936002)(8676002)(7416002)(2616005)(38100700002)(38070700005)(122000001)(64756008)(91956017)(316002)(31686004)(110136005)(54906003)(76116006)(66446008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3U0WUs5WkY5OEpheTNCT1hXdzYwRVBvbytHWWdLVjMvaEgzcTJ4dkRsNTky?=
 =?utf-8?B?aE9Gc1Z5dzUxdDU2eWNhSnVIWDJHWjVaQnFsRDRtZHNtankwbjVlSFpZWGQx?=
 =?utf-8?B?a1U1bWJpT1NhTU1BQWRxOTFudUdrZFJZa3pZTUZQa282cjNWNmtNNnlPK0Rs?=
 =?utf-8?B?MmpGS0FTd2V1ZllXYUd3eVFYTFFpWStqVTR4b1R1REVjK2hvdWdtRUwydmFM?=
 =?utf-8?B?eVptb0VpNWtvd3NNWS83VllDcTFuOWZoeSt1ZWJqczZkNzVYMmlDbXVQQ25m?=
 =?utf-8?B?ZmhPc1RWSG5ocGx3K1Zwa1daTVd5UWVrRCtFQnNSUlpQalBKS3ZRRGhHelVY?=
 =?utf-8?B?TnFGUlNPd1dBajVsWGttZ1JBL1dUTE9ZTzhZOUFEN09hNW5hcmtSandLL1Vz?=
 =?utf-8?B?NTR4QmV1Nk1sS1RFZFc3Q2NKUDRET0VGVFZKZkt4M1hLaUljRkNIUDlvWTZz?=
 =?utf-8?B?RDEzbk9CMTRqYnJnUjN0NGNGYUFnbFUrUmJOanlKQzlmTEcwalVpUG1qcTUy?=
 =?utf-8?B?VWl3bFZSc1RvMGFjVHV6OFExdUUwMkMzME1QSzE2Qmt1V3NXNEh1emRyUWY3?=
 =?utf-8?B?bms1K3IwbTM3ZzE2RUtSOVlvL1VCbEZDSzlmR3ZUdG1haVltOGIzWFpHODA3?=
 =?utf-8?B?d2kvRmg2RmMyckFacTNyT1cwa1Qzc0JFcDEvZGUwaHA4dlpJK2xDemxDWU9T?=
 =?utf-8?B?bkR0Nkx3V2t1QlIzQTlpVUsrc2VCT1RjWG9vU0Z5Z0NUR3d0RTlOOUNqcGpD?=
 =?utf-8?B?aVJyQjIxZUFWQUc4U3ZrdUtPNGgvQUVlNXNWS1l3WDIyWnhXV3FtWEZvNXpD?=
 =?utf-8?B?OWdGMGN5UUJrTU55aFNmUFlxbHRCZkNuU0RPTDRnc1NTNXpqVHU4b0VGbFp3?=
 =?utf-8?B?cWFWUXhaclhRTW5QQ3JtTGdDSnl2WHE3dzdBZ242YmhNcnhMa1pSOHdlSE1t?=
 =?utf-8?B?WkZ6MWV1cmRkNEZTdjZTUnR0V0dlRzFzVVVIVFhaNHBUUUNGYUd5YXNLY3dO?=
 =?utf-8?B?M2tBV1VRUkp0RWgwMDBGOEFKRnIvYy9DaDRwSWRWbTVacmIyYzUrRlZ0TGlY?=
 =?utf-8?B?eDdEVDdJbWZ1cTlqTVp4OVhyYllweVBFd2p6YXdhM0xxS2h0T3dubndUdmtj?=
 =?utf-8?B?aDRMTGpGcldlV0hteTRuN1gweWxsRzJvY0JXUml4M3gzdmJYbGs5WGxodk5T?=
 =?utf-8?B?UTNvZ0l4eHV2aDEvLzNzT044VlVUb0d1akRIa1N1TG0zN0c3ZldGSXVxMDdJ?=
 =?utf-8?B?NGtLUDJLZDEwUG0wN2dDR1pUUXFqTXUwTEI4SFkrZS9yTkJsNzh2ZHRneUo5?=
 =?utf-8?B?eUVMQWFhM1VaUmQ3RGJzV3lIR2ZIQzlYWGo3QWozZHFJdklRM1Uvek9Zd0pB?=
 =?utf-8?B?VTNlNW95bDgxeHR5ZVZBNTZhSkFyWUNacTdWT0lmWXpIV2pOODJ6ci9sOHh1?=
 =?utf-8?B?Rnd1d2E5cHpiNHQ4blVXTjE4Y215L2Q0Vi9PNUFwRTBkZ1Yvb3JZQkFrU01X?=
 =?utf-8?B?ZXZKT0c1VWNaKzlCU2FuQkQ5blhKMEpDNHJNSzBxOEFFVlNBaVRXRzVXY29v?=
 =?utf-8?B?cVp3M2EvamRzeWRCNmlzd3pnVjBmaTZSd0NhbVhkTDFvNzBvOWpKQXVOMzVW?=
 =?utf-8?B?cWUrTFlLQ0JpYWl5bWRRcWxvdTRCUXVjNVRteFkvQVRsVTl4ZnJCWjJTSFlt?=
 =?utf-8?B?TFl0emo0Ylp2YXdROVRUZmh0bkx3TVVia1VjbFRXc0d6V2p2Y2sySXNSOXFI?=
 =?utf-8?B?THp3WDl3aFgxUlVNbnkyTkpWWlVTekY2RHM3cXBHWFFjdUZrVE1SWnZCbDY0?=
 =?utf-8?B?SUFXc3h4RC9wQlkxUDJKVXJEc1B4ZUpvaUVmbHozcFBHRUpCMmNhdHhjcFdz?=
 =?utf-8?B?cDVET2RzbGlIdTI2cXhtM0NrQmVPQWI0c01kckVmemQ0YkhYTXAvZkJNUkJm?=
 =?utf-8?B?UmdvMllWWVczWmp6YmpnZUNqYXlyU3AzYklTNERlalU0eUg0VE5pbXROSTEx?=
 =?utf-8?B?MmFHR25HZ25seXAwRnorUjdZS1k5dnhYaGdYa2d6Sm5Ic1B1WXBBdk9VYW9l?=
 =?utf-8?B?UzMrWlZQc2xMZ05rZjc1UVVWQWZKYXpIS0E1blpkVGJnZ1dMb1J3T1lZRzZP?=
 =?utf-8?B?c25EUDgxODFPUU5zdUxTV0thNzZxVFJWMG5hNEZBcUNqRHdnNXN5YjZHN0dP?=
 =?utf-8?B?eFhXS2VPa0g1bkxwbEpzYnN4cjhEenhpbDZlVXMvRjBSMW9BMWpXZ3ZTczFr?=
 =?utf-8?B?aHlmWXRaM1pNS1VNZENjTDZyZ3BiY2F4L21TQk9DVUVnQTd0aldTRWhMMnJE?=
 =?utf-8?B?N2ZWYVdXc2RXa2QvaEptV00zZ1ZOMzV6RjNCVTBzU0Q4ZEF1UG03Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BABB9FE5D0E534BB0BE0470A593FC54@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da662f-0e9b-41be-7b4e-08da274f1733
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 06:36:27.1027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5Uk82smQ7v3illPKX2nke4gXViGNMOwp1l3dMvHBm0m+Dq2vHxXULqHrHfmboo27wcHZF9NPNWdoVi8VdbQv92sJzXe/cAZKC3InBGcL/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2743
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjYvMDQvMjAyMiAwNDoxOSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiANCj4gDQo+IE9uIDQv
MjUvMjIgMTc6NTksIEFuZHJldyBNb3J0b24gd3JvdGU6DQo+PiBUaGUgbW0tb2YtdGhlLW1vbWVu
dCBzbmFwc2hvdCAyMDIyLTA0LTI1LTE3LTU5IGhhcyBiZWVuIHVwbG9hZGVkIHRvDQo+Pg0KPj4g
ICAgIGh0dHBzOi8vd3d3Lm96bGFicy5vcmcvfmFrcG0vbW1vdG0vDQo+Pg0KPj4gbW1vdG0tcmVh
ZG1lLnR4dCBzYXlzDQo+Pg0KPj4gUkVBRE1FIGZvciBtbS1vZi10aGUtbW9tZW50Og0KPj4NCj4+
IGh0dHBzOi8vd3d3Lm96bGFicy5vcmcvfmFrcG0vbW1vdG0vDQo+Pg0KPj4gVGhpcyBpcyBhIHNu
YXBzaG90IG9mIG15IC1tbSBwYXRjaCBxdWV1ZS4gIFVwbG9hZGVkIGF0IHJhbmRvbSBob3BlZnVs
bHkNCj4+IG1vcmUgdGhhbiBvbmNlIGEgd2Vlay4NCj4+DQo+PiBZb3Ugd2lsbCBuZWVkIHF1aWx0
IHRvIGFwcGx5IHRoZXNlIHBhdGNoZXMgdG8gdGhlIGxhdGVzdCBMaW51cyByZWxlYXNlICg1LngN
Cj4+IG9yIDUueC1yY1kpLiAgVGhlIHNlcmllcyBmaWxlIGlzIGluIGJyb2tlbi1vdXQudGFyLmd6
IGFuZCBpcyBkdXBsaWNhdGVkIGluDQo+PiBodHRwczovL296bGFicy5vcmcvfmFrcG0vbW1vdG0v
c2VyaWVzDQo+Pg0KPj4gVGhlIGZpbGUgYnJva2VuLW91dC50YXIuZ3ogY29udGFpbnMgdHdvIGRh
dGVzdGFtcCBmaWxlczogLkRBVEUgYW5kDQo+PiAuREFURS15eXl5LW1tLWRkLWhoLW1tLXNzLiAg
Qm90aCBjb250YWluIHRoZSBzdHJpbmcgeXl5eS1tbS1kZC1oaC1tbS1zcywNCj4+IGZvbGxvd2Vk
IGJ5IHRoZSBiYXNlIGtlcm5lbCB2ZXJzaW9uIGFnYWluc3Qgd2hpY2ggdGhpcyBwYXRjaCBzZXJp
ZXMgaXMgdG8NCj4+IGJlIGFwcGxpZWQuDQo+IA0KPiBvbiB4ODZfNjQ6DQo+IA0KPiAuLi9kcml2
ZXJzL2NoYXIvaHdfcmFuZG9tL21wZnMtcm5nLmM6IEluIGZ1bmN0aW9uIOKAmG1wZnNfcm5nX3Jl
YWTigJk6DQo+IC4uL2RyaXZlcnMvY2hhci9od19yYW5kb20vbXBmcy1ybmcuYzo0OTo5OiBlcnJv
cjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYbXBmc19ibG9ja2luZ190cmFu
c2FjdGlvbuKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gICAg
IHJldCA9IG1wZnNfYmxvY2tpbmdfdHJhbnNhY3Rpb24ocm5nX3ByaXYtPnN5c19jb250cm9sbGVy
LCAmbXNnKTsNCj4gICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gICAgQ0Mg
ICAgICBuZXQvYmx1ZXRvb3RoL2hjaV9zb2NrLm8NCj4gICAgQ0MgICAgICBsaWIvbGlzdC10ZXN0
Lm8NCj4gLi4vZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9tcGZzLXJuZy5jOiBJbiBmdW5jdGlvbiDi
gJhtcGZzX3JuZ19wcm9iZeKAmToNCj4gLi4vZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9tcGZzLXJu
Zy5jOjc0OjMwOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYbXBm
c19zeXNfY29udHJvbGxlcl9nZXTigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFy
YXRpb25dDQo+ICAgIHJuZ19wcml2LT5zeXNfY29udHJvbGxlciA9ICBtcGZzX3N5c19jb250cm9s
bGVyX2dldCgmcGRldi0+ZGV2KTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IC4uL2RyaXZlcnMvY2hhci9od19yYW5kb20vbXBmcy1y
bmcuYzo3NDoyNzogd2FybmluZzogYXNzaWdubWVudCBtYWtlcyBwb2ludGVyIGZyb20gaW50ZWdl
ciB3aXRob3V0IGEgY2FzdCBbLVdpbnQtY29udmVyc2lvbl0NCj4gICAgcm5nX3ByaXYtPnN5c19j
b250cm9sbGVyID0gIG1wZnNfc3lzX2NvbnRyb2xsZXJfZ2V0KCZwZGV2LT5kZXYpOw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiANCj4gQ09ORklHX0hXX1JBTkRPTV9QT0xBUkZJ
UkVfU09DPXkNCj4gTm8gb3RoZXIgUE9MQVJGSVJFIGtjb25maWcgc3ltYm9scyBhcmUgc2V0L2Vu
YWJsZWQuDQo+IENPTkZJR19DT01QSUxFX1RFU1Q9eQ0KPiANCj4gRnVsbCByYW5kY29uZmlnIGZp
bGUgaXMgYXR0YWNoZWQuDQo+IA0KDQpMb29rcyBsaWtlIGEgc2lsbHkgb3ZlcnNpZ2h0IG9uIG15
IHBhcnQgd2hpbGUgcmV2aWV3aW5nIDZhNzEyNzdjZTkxZQ0KKCJod3JuZzogbXBmcyAtIEVuYWJs
ZSBDT01QSUxFX1RFU1QiKSwgSSBmb3Jnb3QgdGhhdCB0aGUgc3R1YmJlZCB2ZXJzaW9ucw0Kb2Yg
dGhlIHN5c3RlbSBjb250cm9sbGVyIGZ1bmN0aW9ucyB3ZXJlIHJlbW92ZWQgZHVyaW5nIHVwc3Ry
ZWFtaW5nLg0KDQpASGVyYmVydCwgd291bGQgeW91IHJhdGhlciByZXZlcnQgdGhlIHBhcnQgb2Yg
NmE3MTI3N2NlOTFlIHRoYXQgZW5hYmxlcw0KY29tcGlsZSB0ZXN0IG9yIEkgY2FuIHNlbmQgYSBw
YXRjaCBmb3IgdGhlIHN0dWJiZWQgdmVyc2lvbnMgbm93IHRoYXQNCnRoZXJlIGlzIGEgdXNlciBm
b3IgdGhlbT8gKE15IHByZWZlcmVuY2Ugd291bGQgYmUgdG8ga2VlcCBDT01QSUxFX1RFU1QpDQoN
ClRoYW5rcywNCkNvbm9yLg0K
