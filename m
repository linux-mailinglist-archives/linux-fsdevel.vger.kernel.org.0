Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F1073DA27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 10:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFZIqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 04:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFZIqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:46:05 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3E31A4
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 01:46:03 -0700 (PDT)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q2sVMN009790;
        Mon, 26 Jun 2023 08:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=eOXRaimprurSqsjsDciCWBQdXHjxQJrZyXyZEepvFEE=;
 b=EWwK9/nzCR4Am77p/OYSujW0GUZhY4rv6vc2dgDiTDh5O7BORf6MjFsuEWzkLnHPJfkw
 mJVBMofDeDBUHlhGztavo+3EvIju4+wephH9wAaDctlHAnQLQVCtpCk5QyrxUG/RolZI
 McIv6CSnUFVAbKfMiJHvwoQGO5dshzKrA5n0lSf0K1DMSg6v7AfbYKX0swsz1Uaot6bf
 8OeEP3ExL7oi2sOwCSSjpm2MMa+on5UqyI9K88irQf4FWoR3oaIMPNZF3cReozxDWqlD
 s+xcrYlEzFBdF9NOm+vYlwD0/CbGnJmTpEsl7kkM13eZzgqo1sI+jrOiVQjnrXp4G8Rd uw== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2046.outbound.protection.outlook.com [104.47.26.46])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3rdnn51q2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 08:45:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTR732HRRY0CrM8T3EWOETWxtVaW/TpdADHasI//PSBW2WqbOZ+5yn5lvxYk0Sctz6nwDlajf072TOnvIOrVvdJcY+RcnGFRIRIQ0gUWScO9haktqflJQA6iroLurw080xT/IFPecIIHaeH7F522UFgUyeC2lNekX1seZM0lVuaG4l/OYhNdJezhiundCyvQp31coZCtZxpzPdiLMpGc7PAO7abha+Q7u3Uft30xg7lWaARmLI+iFUk6RHabBudbpPmSAx7y5pFQHCx7iAJoC7WwFgANPBsoj9M1BjbHbGkkHUZfKyVYbk/pJ9zoveVmsu2rQiHu+RLNGukPTzpUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOXRaimprurSqsjsDciCWBQdXHjxQJrZyXyZEepvFEE=;
 b=THGTAcuv24MrEbJqLeNHdN2rOGLiVza4NG+UvGC5JimvCpfx2r+PrNmpkvjpxzSCIaNQmfAJClQSkO4nuxUnlSHesktoyqAjRVU+ecqd6r/HQtVdRS+tfLXCnTXlAQWFABZzCq/DDkqnIGNWZH1/yTs3kmj8oJZtGQ1W3OJzae9sBczem7GuvT9C4Vu5PwKgs878EIwu6LUmC22ZoSxZDPw+hie4atKg0q63Rxbc9vmW/o9OtXn9BASTpKMDRkZvWgQcCiehYEG+eiyYY5RGiXgeOAQd4yfAfXd7JCfAr+S0tq5dK6V1FV8TQc2HR9wostIyy9xwgnQu/0022ADUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4196.apcprd04.prod.outlook.com (2603:1096:820:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 08:45:37 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 08:45:37 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v1 0/2] exfat: get file size from DataLength
Thread-Topic: [PATCH v1 0/2] exfat: get file size from DataLength
Thread-Index: AdmfODMxTKFC/pCyRPukKkKvxSTr0AFnT62AAJW6ZCAANtKzcA==
Date:   Mon, 26 Jun 2023 08:45:37 +0000
Message-ID: <PUZPR04MB63164CC193BB2EA5270F810E8126A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316DB8A8CB6107D56716EBC815BA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd9ubktMNDdXPBDjRyUeGARMjMR5Hq+vwwCUbhwUmNURtQ@mail.gmail.com>
 <PUZPR04MB631602DE8C97F0D3DAA036F08121A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631602DE8C97F0D3DAA036F08121A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4196:EE_
x-ms-office365-filtering-correlation-id: f054b545-2259-436e-d164-08db7621b6b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wi69bfN8VoN1etqhWJbSbnFgcbdoHti7GVwIfR6O5Q/EUB2tl8sxP1dOg9sfBRph6Kg8dtfD9TH/frJg3hRlyMS9uIXe7y3EXjAh4RNiGdmfalya/vjIC2E2w6aLKm09Bt49iWhP1qCSqAubVyLWkWl7RFbepsYD4p2sHVvFaZtd4qk9SYl1Vh9qYAAYlS+0CAFnPDTePT2v6vonsjX6KLj7xRhbjgpG5UzROyKlP9136moiL5Vy9IWKrPN/FmmPBlh52tdCHEYP8kurGESHowXRnDGt9kTu0fBt5PzHTEn4RB3efZ9Qe5Qtdq7LCZpK1/R4XAk6qDmMtyVXzql5HzriOJSjMm8HnB+YfZpw6dg0yoeu4qmUoZxB26zg66MwkBtnGhOMAD3VCxnJ8wv2QyClXLaB3bS8Nme4vh7JL5HIoOdm37dUchoeAIKSpBF2slI5PdMEm6aco0bURYQok8W2Tgl9SRpfSvrBsqu/w2fVd58Hm6m/MVFWKOc3haRl22ndJDBDIX44B2l/MGIlV+HNjMg/7dHtpbWRpr5gf2jNQSeRJqrLyljOv83YvRxtT/MtuLofzaioK+TCVp3hRPMRvfnepaXkn51uEFsYqvQ/3HF9rLFOEenHlfioFfF3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(2906002)(7696005)(71200400001)(107886003)(38100700002)(122000001)(82960400001)(83380400001)(6506007)(26005)(9686003)(4744005)(186003)(55016003)(41300700001)(54906003)(86362001)(38070700005)(478600001)(316002)(66556008)(4326008)(76116006)(66946007)(66446008)(64756008)(6916009)(66476007)(33656002)(5660300002)(52536014)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1BrTTJ0Z1pNV1NEdHVzMFFwN1RNY2RRZzVoWk1Ha1JoRjZ4ZE14KzNyaDMv?=
 =?utf-8?B?aklQSGFVRkhISFN5dW5uUGdramxZWU5ZVzRjM0pUMXRtUzcvbUJmV25COHVN?=
 =?utf-8?B?Zm1ESUYvaVQ1cU5NaGxvZzcwQVJnaHkvNUNNc2NEc3B6M0dFNlhMaDBYcmky?=
 =?utf-8?B?cGxmd2ZQeWhYM3dwQ1NjSzRqdVU1OExOT3ZUbUh4UDRWclczSEd6cEhBenZs?=
 =?utf-8?B?cE9kbGU0ZXJ1SklYdEJ1dlpsbllEWkFESWwySC9yTUpWKzEyOGFBOTQwbDVq?=
 =?utf-8?B?OTR1K0JKQjYrR3FmZnJlYlBzWVUxZS9jNmZ6YzNtaTQrTSt3eVZOV0s3dHFI?=
 =?utf-8?B?TWR4d3p5dnQxNmRaL2hHU2YzVTFIYlNkN1FNaUtiNmpGaU5tSEd1bVB6NXo1?=
 =?utf-8?B?UWY4QzdJOHdidkFaVmNsVHhCUVJKQ2VnVW9QU2YwSVFZcEswcFNxb2czZVlk?=
 =?utf-8?B?OFRWZFRzOHNjblN4am1IVnFVbW1hazRGa0h0dWF3Vnkvc2crTGlRTjMxNEFU?=
 =?utf-8?B?Y25wQnMwaUowRk1xOTBvbnZHdW1Dbmx4bkRKQzE5d1lSTlhyNDVHS281cU41?=
 =?utf-8?B?VzhUcFRBSEV4SGpJTUJLSGZkUXh2Y2ZVR29neThuVWRuRHdFM1dTTEc0UFA4?=
 =?utf-8?B?WWJVbE41K1pVVUkrU3FlQytHdEhDcDhCaHZXZzlDMnBZUGtiVVhST1VRampK?=
 =?utf-8?B?WUNSaEpuK0NFampJWW5kSElTWkhYNUZKQk94TFl2dFVORlFnSEZwQklWVFdu?=
 =?utf-8?B?NjNrUkpqR0U0bWdQbi8zR2NUUjJGWGN3aFBhZkhxSWxXR3RxSVhyYXY2L2tp?=
 =?utf-8?B?Wi9CbFJvUHZEWHQvUGFLOWJqZ3Rqb1ZjVzQ5aXRQT0JhV1liSmF6NU5pMEZJ?=
 =?utf-8?B?VXZkUFUrbEJNZFNZM2UzVjNNeVFLbDZ5cEppODk0blBDcGZiaHhLRjJSMUZu?=
 =?utf-8?B?TzRRWC9ZWFhjSGs1N3JhWEpTWGltdXpoc3MyYmdmZCt0dkRTR1hxRVR5TXdF?=
 =?utf-8?B?N1IvdVl2bEFWWjZxV014WkhvVGl0SjdiYmxMQ2ZHY05EclVHM01LMUNqNzZW?=
 =?utf-8?B?aStzTzFQN3A5aFhDdkk3ZjA1Z1FzYVViWko5TnluYm1wUFhlTXl1RVJHRks2?=
 =?utf-8?B?dmE2MStCQm1IdzRXaDB4cHdDTk1qZkZ2V3JoTXo5QzZjNTQzYlFBcm94clBK?=
 =?utf-8?B?eW5GalRNZVBJNlZLajhieHdHZXEyWjhZNnZCZUpHZlJYTWhFVWZKQTRtUmtw?=
 =?utf-8?B?bUxuVkRkalNEZE0zdHhJMk5nWllGMGRoMjB4R2QzV0tQblZNWmRTeVFmTGhT?=
 =?utf-8?B?RVF1YzdiV2xNYVpVMkU3SEdadlJMVzgrL3B2K2FRUHFqSGpEenhHL3lQOGlP?=
 =?utf-8?B?NjBwQTJpWE8xaGhpUXRxYkk5cEhSK0E1QkZqK3BCNlRyNWZLcGhITkVmZ0Va?=
 =?utf-8?B?dVY3dWRKQ1ZDd3dpV1QyLzd5Y0RQWlZhNVpoV0hEV1JzSytkYndyVzVJdTNS?=
 =?utf-8?B?cXJtbHBRNFpEWXNXWUJoVnJpWEFDV09nWHcvV3NJNnVDZi9ET2drMlhkTGtB?=
 =?utf-8?B?ZUovSTBhMVFncFhCR2Ywbnp4Smg4L2lmc1l3TFZyOXM3MVJmRUN3R0crWlho?=
 =?utf-8?B?V0tWK2cwZy8vYzdRWUhENTZ2YnlwUGpXNTVEWkxRRnozbG0rNXIyWXA2VTll?=
 =?utf-8?B?dGw2Vm5FcDBDVzAzVHNYRndzY0lpNnFOQXFpNjdXeUdwdHlQWU9KaER4T2kw?=
 =?utf-8?B?bDhRcjVwQXBNQkpVVjU1ZTRNWkpna0g0aVBoVEV6djd5dVl1ZDBrR0FoZ2sz?=
 =?utf-8?B?TG1FdVFKVUh1dEloQTI3VUtCUC9nbkFFdXovQ1I5TnVBVHIyNG5KWGROTFN1?=
 =?utf-8?B?TUtrMUdRZUw5WkJEbGNHS3h1cnV0cDZVUjZQOTlTTGhVWk8zWXZrL0tHMzY5?=
 =?utf-8?B?QWY2YWc4RitqYVl6K1FlN1VRZm5EdVVsQzFDdzBkUk9lNUhOREpNV2pTa0g0?=
 =?utf-8?B?OXV5WFY2QmlBK0g1ZmIxOW1qS0xhejdCSFF2SGI3K01UL2JGdE0rRUZOaWhh?=
 =?utf-8?B?R1NMaVZZa1I5WnRXYkVRcUxrQmMvaGhZQ3ZnNzFRZkdEMjFhMVBGSCtsQzJi?=
 =?utf-8?Q?LYa71rKfedXZBVUXd5++jdqz5?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ltHjiTtbVxKBhKXBCvhGIfKsa9mKx23nGpYcj6kq/fIDz5XIBcoT/AlWTPLvGz1vZ9xyk0ifvMbh42Dg9/s6u8LF3ysh7s/eXZqwzeOkFGMwM/GwGKzkbYrzs4aV/eYy+gDo4N3YsquofA/KLe3A3g7Uq1pSLVfoOUqqeYEj3b02yDaZ2YKyhoY4iOLFTVwUaaazdmedN3jn/RM/GoqwNBUbz6R7jNX2uepD8VateoDdw8hujSua9V305y0pe+IVjMRCL+rqECkHWTO7RJjf/H8/SUhxGRsG5QqKnvzgkBlYOcA+nPRGH+DMBMlp40+57apDuk+4kgHiaChSXoQO66nOII/P0YfODiqJKe2Q9ARoVoTuHKH0ud92QT5SmYm/tWKRjcUZDtVkbhkAEvk0ktnn+qFNk4LqNfG1pX0YsDewBJx2zgYMdNzc+exXopGlKl3Tj8rMGcib15TVRDG2HfAYbVCuG17So7D4l3OBrX37PPdKHkZcSX1BhasX72DocR9F7WR18yMZMvOPcbwUOM2MmovBOvSREmvYuixIN0siw5YvmqgrLpduGU3+9fTGW3I+9bcClKqHXiYgg2efWohtgi45N/pPNZO3FhFRs97ezub4bEdlCdxDkkwu8Nzzzlbwv4ze0LJvuwsUJHfUNQQPaeMqr8MOCA8IP/88aUXebSB7HQsvanpWoOLTnjCyWdRIb8ZpBf4K0Y5CmlU56preOCO1T+sWoVvwFiMBb12bUiU6p3iBjcXAx46SYqsCbrHhGvwxxttlfAsssWTxPPzEOBa+ygOjI7Y/aPNkwNdO33Z8akYuIoQVq+j8pZ5AMTkUw+IBIV/WzYDo5287yA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f054b545-2259-436e-d164-08db7621b6b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 08:45:37.3921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3hOYyW6QqrEPH26GSbchmVn/AbGBjR0bDEFuIaqngMkRHUWR/OURn6tnK5I9xQZPL7B0URcujyi/2HpyN588A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4196
X-Proofpoint-ORIG-GUID: pxL2s-e-3da6geaCby0r3MCN2ah4cVe7
X-Proofpoint-GUID: pxL2s-e-3da6geaCby0r3MCN2ah4cVe7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: pxL2s-e-3da6geaCby0r3MCN2ah4cVe7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_05,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBNbywgWXVlemhhbmcNCj4gU2VudDogU3VuZGF5LCBKdW5lIDI1LCAyMDIzIDI6Mjkg
UE0NCj4gPiBGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPg0KPiA+IEZp
cnN0LCBUaGFuayB5b3Ugc28gbXVjaCBmb3IgeW91ciB3b3JrLg0KPiA+IEhhdmUgeW91IGV2ZXIg
cnVuIHhmc3Rlc3RzIGFnYWluc3QgZXhmYXQgaW5jbHVkZWQgdGhpcyBjaGFuZ2VzID8NCj4gDQo+
IFllcywgYWxsIGdlbmVyaWMvPz8/IHRlc3RzIG9mIHhmc3Rlc3RzIHBhc3MsIGV4Y2VwdCBnZW5l
cmljLzI1MS4NCj4gQXJlIHRoZXJlIGFueSB0ZXN0cyB0aGF0IGZhaWwgaW4geW91ciBlbnZpcm9u
bWVudD8NCg0KSSBydW4geGZzdGVzdHMgaXRlcmF0aXZlbHkgYW5kIGZvdW5kIGdlbmVyaWMvNDY1
IHdpbGwgc29tZXRpbWVzIGZhaWwsIHRoZSBwcm9iYWJpbGl0eSBvZiBmYWlsdXJlIGlzIDEvMjAu
DQpJIHdpbGwgaW52ZXN0aWdhdGUgaXQgYW5kIHVwZGF0ZSB0aGVzZSBwYXRjaGVzLg0KDQpQUzog
Z2VuZXJpYy8yNTEgYWxzbyBmYWlscyB3aXRob3V0IHRoZXNlIHBhdGNoZXMsIHRoZSByZWFzb24g
aXMgYGNwIC1hYCBmYWlscy4gDQo=
