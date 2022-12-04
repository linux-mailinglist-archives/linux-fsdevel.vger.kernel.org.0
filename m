Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83030641C7F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Dec 2022 12:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiLDLB7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Dec 2022 06:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLDLB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:01:56 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2086.outbound.protection.outlook.com [40.92.102.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE8E17E3D;
        Sun,  4 Dec 2022 03:01:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXaPRhfsptW+DypEU/RMsOB+LTFb1dWI5uVM735/q+93hdOk1i3DxMwARfWL28EizlYegrNnedeDDH9TsEI73qKTof3hG8ZBFbrgfiezcVWoeBTk74CreZM9guBY+/0suHTcJcsLea4boCjd3rZ1yylOfX5eib5A9sE0ToHn8ypskF0MH8UMl2bXrgI98qjfFMpBcSH4BA05UyLm5MBDgoduUYtR3njyjEK39ai9ZsWAReY6XSbvB4EIaGhqYm1/WgRRrVRVYel1nOaHr+aXhJURX397J8lsg5rdYG3aHNOC4YXBsL0t61NtOMnFWvTcFryFTC5XBlZGo+B8YDm6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddz7n1EKvRKrmg7zpAsrc7M3kwqVp8rVhHelKv0Ods8=;
 b=QDA98gLZSBIebXC9kmAuxSHlBnS/VvtHveKFkTg9QaGFAzH0vKFGqm/dt19QvfjaX55qQDyYDvtbPEzGmC3o7IsNwantBW5Pu/BnZ+mnxHyb3ZIn5tCEA3Lf0qx9Hw6IaFKbwCW73MuaWDG3w0h+GNQmkBlpiHcoB5lyR5VAnw+E6WvAve/FIK7k9NTDv8D/jJEonidqfLC0z1mWykV5vHZaK8RI5LITmNWONZTAIOUu1hWvKlxHvOED5akE1G5oEs25Agt0l58Vm1E/SQfzxgjfmfUBeB9L715w6acHf+jeZSjIG96aX6s0dfZJv9KCZLjv5Wv55k4ZBjCF+Xrh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddz7n1EKvRKrmg7zpAsrc7M3kwqVp8rVhHelKv0Ods8=;
 b=rQ+NV83Wncca1pGhtVsetMfJ4okS5BQ0zdfuJh1O1jog8wQsaf0jIODzouLt2yPgnmBSrRVZ07KNGBqi3pGWUlWmHrJ/4sEKtTB/1f9YJEs7EwJ4G+Fz+zgpk9l1ZgJ7MR02N8dl6y9iksH4QLyI9+Q/OMzIRiCKeRQ9aYQTKOJ4s8vlfjK0E+Ab49JA9LKXl9/auJa2AQEF+edz6VCz/6Tdb38txghri5QOrhkifnQJC4hSdH0ad3DAleWCRFRQaRB6NkT/lhPLPw97AyEkiR77f6GMlq3XhIsH9NlABcpUFxue80tngL1PLfRIgm4NWGRTFLs6divrCY91Jbk7YA==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN3PR01MB5492.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.13; Sun, 4 Dec 2022 11:01:49 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1%4]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 11:01:49 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: Add module parameter to enable force writes
Thread-Topic: [PATCH] hfsplus: Add module parameter to enable force writes
Thread-Index: AQHZBhN91tyHb5NS2Eynd+A7F1BLCK5bFC0AgAJOrwCAADCNAA==
Date:   Sun, 4 Dec 2022 11:01:49 +0000
Message-ID: <A35CC249-5F77-4B1A-B68F-8E07A38AB73B@live.com>
References: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
 <20221202125344.4254ab20d2fe0a8e784b33e8@linux-foundation.org>
 <20221204080752.GA26794@lst.de>
In-Reply-To: <20221204080752.GA26794@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [uyO64TzIJJryyXi33QjE0pt7zhArHnZt]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN3PR01MB5492:EE_
x-ms-office365-filtering-correlation-id: 580e679c-03fb-4464-96c7-08dad5e6f192
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f5ibHNvV3kSuZ9AL9WLltIeMF12TxmknA81X2vseC7P9vbaaKtLTvazWWGjhZ50dHejBcXDJQPtSQzulRLJTgTZO5M/JbIM6AY0qwCO2VYO4tkrcKjJLU04piImHIQL1s+mZobrBkmsVV3/kePN/vSnaOqrmETjarl7NZ1spkNkMfy7hyYkUrwrCmDZEf/B/TRdQFgqEhM3n7GNmK2mgvwUUt0asxCrSz73CvjSCQmECqRfqm29j4fJSdFpsSfd1ve7xHmzKf5/PpX9fOxyJH6v32SIxcrspLcktqBFFNMWx8a/313fa1VnjQ2DGfOKxRboPsA95/nT67Dr3BIF4AFov9FY17a96jmQg79jx/4UImQ09F0FS9CxkYfeQAi1WvGQSBRPNNaX5OpZhBrlIiVZSdn0RcblqcTr+SIrR+R4w5O00B6F+w7iQ78yOFbND4wvAAt+EAHesCSfzeqhhI6NlnrcYbYXb0ird+ILhWQPfwz6xTmLUsLw91LdeOSB1XLE/x8vDHjSsxaBbIcz1qssdDOaf7XMcR2l5U9/Ws2BdkOYZjOkmoJWke8yYbgQSjh0WDlMPfU0Gzh445suxxzBc5PTyfsSMbUJnb97TKV5cheOkitOq9LuPCqhZsrYoSs8r5koz2FCr2kTYfAw8Lg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pnqs5zanTxgy5ALct0whOnuKlJTLm/Z35AF6Be8VB/kuvUdpMZbALk//XSmh?=
 =?us-ascii?Q?mSdkF7Khrb4L9FHHbK/ttMQdHc8lbeBIv9DT8uD+4fdif3dMIjqjx0KKFaDO?=
 =?us-ascii?Q?NLNKqAhrfA9dAk7IMPIcl6ddSqIKeSvmVScYh616yMQ9//5WXwmQYWCJ0Gwa?=
 =?us-ascii?Q?FuKKJbFnBD9/0kC26mZsUlTP4ftgVD9l+17RLKW0vFCKfTlh+q0hpDj+WYPC?=
 =?us-ascii?Q?MvUnP3vJtRRLJYn1BgLJzhln09Sm4RFsxxteFB/fmfOXmkOHD5VRlj+VBtY+?=
 =?us-ascii?Q?lS5PSheENOPwkZvNLBs3HZwHwCV0igExYQG+T8ICzhTpaHnNEugvGYENkXkY?=
 =?us-ascii?Q?ycJg0r5t4fm4s6r3ct/dmiGSac0ze0J7S7SwdNpMejzxgR0OIbaZX38NcQOS?=
 =?us-ascii?Q?vDi0M7ziDFAo910m72bSNANT+Sb6xVNABQYuP2SPuQ/z3PloFVD3XUm0HCW+?=
 =?us-ascii?Q?gAX+5aAUMqNbhSZiksQifJvHcgOq1Mn07l9lTVY2F4eG2vKzk4PrlyW1Kvk9?=
 =?us-ascii?Q?ptj4HWbeAq+3BX8YB+ElV7FlRcMKzOdngjjiVdwAfaKLK+jplbNaS5fxYkvj?=
 =?us-ascii?Q?xdRxdfsHN2jyLelDKj2tPbcTANnhi+ZnVTFEBz/7AhuBNDqBVaKVMavHjTtx?=
 =?us-ascii?Q?V4Xnu/0v1Ryw0a7XgWQqwib/eEwWYlDIXxWwjSx7sHvD0gZVNSa6HPwEUymc?=
 =?us-ascii?Q?SMLL+aNQQ5rAgrdvSU7bjxwUp/zbZI6H1EYc6HSk3wBYWDpUvEvMXGbFqv3c?=
 =?us-ascii?Q?LyZfnE/lP5T8G3fkqHTYRQ0zkDwlugLA0wQlOVti6gPxbaVUB044LZd16cRJ?=
 =?us-ascii?Q?Cu96v93U+deGn4akBVL+0Fp1zfOkpspqetMigdDLlieRhT4ebmIFfU2sQjip?=
 =?us-ascii?Q?I0pW0lsyyqILApgZ8CxRR5tgejXK9u+DNYlhoWHu0FD086azDBWKjBWesCnz?=
 =?us-ascii?Q?ZWBz3UKjSOs/sn8/Gv9r2vEVXfPShr9edsaagyNFBLVlTL8FSPnH8TUjCc6T?=
 =?us-ascii?Q?TiYT8T+MtPlFtffKvFM47z27II1fM4J38eD1TshZ6ZIgoNB7XzdkaLT+1EMf?=
 =?us-ascii?Q?ywCzpOvm6Yj35yjpd/tgyjJJzm1StIqjLosgZLdrDdnp1FDNnyzjR/dXf/Ls?=
 =?us-ascii?Q?Zyv0Tz32XQbO4FZ6uqS5wEj2OjKOf/4cjPs7ENcRwOq5ObQgGJBzj1lCV+E2?=
 =?us-ascii?Q?tzy1fhpOoIysfP51nm+jowmtYWzH0Bsp2aHfvXFSvToyV+jRdGn5uOrhgYuc?=
 =?us-ascii?Q?1Alt4IF+qmof2RysH8OK/Wnk8HQrvamZ5r19lvyVzA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0585A39FB15484B9889399878E25964@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 580e679c-03fb-4464-96c7-08dad5e6f192
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2022 11:01:49.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5492
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On 04-Dec-2022, at 1:37 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> NAK.  Global module options overriding mount options don't make sense.
> If you mount so much write yourself a script, or add the option to the
> configuration of the automounting tool of your choice.

Hi Christoph
My bad I wasn't aware udisks2 now supports custom configuration. I just cam=
e to know about this and thus this patch of mine indeed does not make any s=
ense now.

Although, if you think its worth it, the following improvements can be made=
 :-

1. There is no logging showing that writes have been force enabled. We coul=
d add that.
2. We could have separate mount options for journaled and locked volumes (a=
lthough I dunno in what case we get locked volumes).

