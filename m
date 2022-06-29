Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A923D560DD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 01:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiF2X5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 19:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiF2X5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:57:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2130.outbound.protection.outlook.com [40.107.94.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7A326565;
        Wed, 29 Jun 2022 16:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMVLD7D650+TQgaQsPNqQWXg82rPKfEfjUdYrlJgMtAxrtRoqmgTSiuKZBRcZ5HHJzwZULfG7/Jtzjcf6vojAgvclHlX/YXYL6D9MmnB4Q6U5d4QfN608sqPKI/vuHSbOvt04VGCaGERox+YboHVPsArxkqtb1hZJWYnfTdQKKeBCkoUEES/Vze6V18HzGf2w2Q7WHGJ86pqkHQjjRspAuz3vrVFfB5Ct+w/2BgedehC2BwZW9IFYrvvVakzetlaq94M7BJBsS35bNJjzEIbPoCkx74NM38a0FzX2OObXGVp9RKORqjCrppqRGIzk7YmYnlXUqZr5hrdH+lYT2ZIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY3jcS+6m0XLsp7kfNqAcfOZrLdTYAAx01S4aoitrQg=;
 b=LpLmAEmLLZO0WN3nnnjaciqEp5yZwpSx2jI8wILKGPvUKaTg5rJMa5ptQ30ClC3E0Y6q3zBYLvWhZ3w/owrzJMazbhKCIwQTsP/C3RdN2xeczEA9JXPzf0slHBLPnUInntfGTKKdqhPntGzfwBjVN7q6tK4KyMuq3Sdxgt286UCQCV0v8FKu8elZoqaaPbuI7L3gLHAIV0t3qZ4x7Z7MWvPSDwI0+1WTEk6V9RW14qMSwsvwiTzg1tJhH1S4lfpybHK3X37AwbotqZm5Olptsgx/F+HGQEX9+21V4HBs8DnPKKxaiWUX8+BNCPZQ0wf8niANcZOWq7piEc20aLmGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY3jcS+6m0XLsp7kfNqAcfOZrLdTYAAx01S4aoitrQg=;
 b=PZgoWK0NHausTzETJRJBcyZY/I5hOyhxsLk16iELP+24wpKdSvhRZGmLxVO2YMXdVu0OWbhkKta9XP7XQ/CCCabsFyXbCRZsYNYRxVIba2wFFGzcmHyHGf8pekhwBhobvDflYOg9hLmJbcJzoZh8+9Nw+xifQxTh9Njh1dpfdbg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1510.namprd13.prod.outlook.com (2603:10b6:903:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 23:57:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7%9]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 23:57:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>,
        "raven@themaw.net" <raven@themaw.net>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [REPOST PATCH] nfs: fix port value parsing
Thread-Topic: [REPOST PATCH] nfs: fix port value parsing
Thread-Index: AQHYioWJZklspGquU0m3p/tguyzN061k40UAgACvlQCAAPNRAIAAhiQAgAAGpgA=
Date:   Wed, 29 Jun 2022 23:57:35 +0000
Message-ID: <c81b95d2b68480ead9f3bb88d6cf5a82a43c73b8.camel@hammerspace.com>
References: <165637590710.37553.7481596265813355098.stgit@donald.themaw.net>
         <cadcb382d47ef037c5b713b099ae46640dfea37d.camel@hammerspace.com>
         <ccd23a54-27b5-e65c-4a97-b169676c23bc@themaw.net>
         <891563475afc32c49fab757b8b56ecdc45b30641.camel@hammerspace.com>
         <fd23da3f-e242-da15-ab1c-3e53490a8577@themaw.net>
In-Reply-To: <fd23da3f-e242-da15-ab1c-3e53490a8577@themaw.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30774219-a511-4d57-97b4-08da5a2b23fb
x-ms-traffictypediagnostic: CY4PR13MB1510:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4lFUe3xfM/TAnDrY16Q/w7TcKbv4oowiPj0X7uT+5kdj5YredelyFa+ShKNbC1e1n8+8Q/PAmFgw7orqOva5sdAh8xMZAD7sa4HouZd7a+SNLdf4XqQQJ6oRCI3c3w+AHTy9rNKOuhMBli3xelMHhQ/SbIST6nzVwa2DkYO9h7Y4h01uagHyFMTy6SOselDD3CiEy2wxtWOUdKqCvZWL4VKSTpVdhDUVcD9gkcMDJrDesm1/zHRBeBUcdri6x6Umb5zBtrtClQRF9U6F3+JecuoJofqMGrPGvfMMqyIc6Y12NuW7luhH/UU0Is4Minh2iJGKSy9FPiYdTaB+0PmO6K9WVAVSrL4Mc48vPxgqdHzWJAlrTeE8aQ472JNtD/weG1s4vekZzpd2xxxtMkFqH98zMXEHf1LzPpaBEbaHHO1vSRsougQejiPWdhX7rd1lEqgylkczPlF8D8mp1+XU7CB9tGMhg+D9HAYQJsPXWDU5U6d7o7+5/C8ygwRCcxX6P4o0T64BOWjskX2nfFnPaJrAv7DIsqapWMs5FxQ6O7LpaxWrPMXrEnH1Uvp8t6Ax1RDuqDbuRqZe0H6STuyj/WWJ7q3QcA3eUPEWM54DLsR4NYZq5PLOBbylUujbF7QKGrcRZq8s3XLGeefPa9sIfzE+x/3ssfJnklxHRwkALbIy3tAgmzWaJx11MlXsl4fAPDcwq3SJPAVPCmr/Lk889ZsA3ESUUvUcnp9r/cnrUh8I5iUFRYp192TbVxLAd5+cwy10E/tai+68OokYQscHDeI2kF2I9ztoPvfLRiLnE5fsZFN+qYRfnvM5uy8jmPvOof7ZQeyYaauO1+j7LQuc+Ha1145thl7X1ELe/uQkxcc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(39840400004)(376002)(366004)(71200400001)(66446008)(66476007)(64756008)(478600001)(66556008)(41300700001)(4326008)(76116006)(66946007)(8676002)(8936002)(5660300002)(6486002)(110136005)(54906003)(2906002)(6512007)(86362001)(38100700002)(38070700005)(2616005)(6506007)(53546011)(26005)(186003)(36756003)(83380400001)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU1KdHdySG1hbXBGZDUxak5RWFJXdjVGcnVOcFRmNCtDb1lkWlQxZDR4aVIy?=
 =?utf-8?B?RmFVdjhicmlPcW9JZ25na2lPVENrNEt1Y25ZUjk5SklUQldsV3dJZ0FiYzFI?=
 =?utf-8?B?ZlcxVnhYL2I3SFEvQ0JsYW5sakc0ZTVTdFZPUHhwNThFS2k0V0pQTUlwM0VN?=
 =?utf-8?B?SDFrbkQydXlHbWdiL0RBdlNNWm1wL1JrQzdmVDlEZEJ0aVN1VjNrOWhnNmJt?=
 =?utf-8?B?S1N1eGhaVzloK0Jtc0xRaFdQTElML1FXaU1FVmVDRVUybk82QXJlZjRodkFu?=
 =?utf-8?B?VkFsT21sREZ0SEpqa0hCNmczMFQrT1QwaHViaFRNdEpYck16TEpaTFZaUWRK?=
 =?utf-8?B?YVZWZDZVK0pZTG1vazRLcXY1UCtNM0diVU9vMXRwcERZRmlDZU1NQnNyTnl4?=
 =?utf-8?B?dERBOVlIdS9lWEo4MUMva0RCNndxbExnWklXT3YvU0hFU01meVRpbDMrUzBv?=
 =?utf-8?B?VUtlelR2ajBoak9uc090SU84OWNrbVhoRmplYlFKaEFKK0tXWTE1LzBDQXFq?=
 =?utf-8?B?cUVnbW1vaU41bzhVWnNiVTIyWHNmaUorOUZyWk1EaVRkNjBhZUlpdi9UQ0dD?=
 =?utf-8?B?ZS9JVG96ZktXZE1DaGZDaTIzUEl4SmVPTXRVZ01jaHdESTBOeStoMklMUnN5?=
 =?utf-8?B?cHd3NlFyY1lXbVd1T2t0SWt3cDY3UkZQV09CWWxQOFk2My9xOUV5RHl3aFdl?=
 =?utf-8?B?N3lNUUZSTkRVbTVUMTBGaDRCaUVJeW4yYUtDbU10UmJrVkoxa1NzNldpMVVr?=
 =?utf-8?B?UjdiY3VXR3U1T2NiWUgrb1Uxb3dXQ3U5YVFSakp6ZlNJMW51TENDcUFWVjJk?=
 =?utf-8?B?L3VDaTJRUXR6K3hmaUU5a0xPcFl0M0FJK050bUozQTJGSGc5VFRjeEhDNjhm?=
 =?utf-8?B?UVNybFZaejJlUXR1d0srMUhONncxcERvdDIyeDh6dTQrSno1bDZVQVh4S05v?=
 =?utf-8?B?N2tXUWdYdWw1cUxYQkIxZ0pHYmY4dTV2QUg5Zmd0ZkVMYU5DTysvZFlnellv?=
 =?utf-8?B?Tjg5SVlrTnZNb1lvNXhpVzE4VEhYRDVpcUlxZ3Fkdlk2ZG5BVHNRTXM1QUZZ?=
 =?utf-8?B?TDcvMU9waHdxODNxZFAxcU1QV0xMM0VtWlEvVU45YktqMkk2d0pHdFlmVnRx?=
 =?utf-8?B?QnYzNFgyYmFielZ1bmZWRmgzMGRQZEt5WkhNUTFFYWY2VGxXb2N2SWhYU284?=
 =?utf-8?B?UEtwc1Y3VFpaWWFKeE1aOGdIeEJNTlFkbmNpblk1MENWU3d3dFMzRnp1elZz?=
 =?utf-8?B?bzFnb01sSHE0YXpLUEZVMExZbTFVNVJIZGQ4Z0cyNjQrVEJhUy8rZ1pJUHhl?=
 =?utf-8?B?dld5emdMTlBJSVJwZUFlbzlkMDFOaTZwa3FsVWlUbGR6NTVJbEVCWHRkajBW?=
 =?utf-8?B?TlRaRm5QTGQrYkxaZ2Npem9Pd25nMDc3bm1RT09jUEFhVE5NY3cwSFphcGFF?=
 =?utf-8?B?OUpxWVFpLzJEdWcvSE5IY1JXWVJIRlorVDUwVWkrQ3g4QjlyL01RdUc2elBI?=
 =?utf-8?B?L3M1TE5oN0hPbzhaTmN5YkhFc1IwUGxrWTBXUlorcUY0S3g0d3piUmVjejR5?=
 =?utf-8?B?d2tza1pKM1V4bjJSYVhNRjJpdUM5MndqT0JCblNxOERqZG50SE1CL1BXWXBO?=
 =?utf-8?B?aW50WDB2SlZnK0xtbEpQY0R6aVJLdWVQeGdKMjBlVnM1VThTcFNRL1k3SUZK?=
 =?utf-8?B?SjNleHAwNTVnZkszeVlJNjc0dElpQzNRakNuV3J2UUFXRGZ5dXZaWWNhZmRT?=
 =?utf-8?B?cEVhMk9udFFnQ1YxV0s1dnpBdEZ4dlVBTWpSWUxrcnFTRHhXby9tbXlQMDVU?=
 =?utf-8?B?R0haN3E1QmdtSVIwNFUwNDVZT1lPNGZCZTFkMnBFamM2OEJ5N3FQMlAwNEo2?=
 =?utf-8?B?OE16dmx4VDh1V29odDJ6NTBmRUU4L1hISUFNWVJZOTdyT2NMdEZUbzZ1UVhM?=
 =?utf-8?B?Sk9Ta1YyNFlPMkJFSU1JaHFVSHdCR3VBVGk3Uk5HZzBKd1hNUlFPeHhDTGh6?=
 =?utf-8?B?VGpka1NGTFJlREh3bm54SHk0YzhpdXEwK29pWXBqNkcvK0JBWWRsVDlXeWhh?=
 =?utf-8?B?WjRkc0oxSjBsSE02bTlNSWNBZVE3dFhKNG81MGUxa3I1SEF3aEJhSU1vNXZ6?=
 =?utf-8?B?NE4ybWJyQmhvRUNSSnRydzJoMEN6TmdLNzh3UkUrc1hvcmZVT05Jd2V5bjVj?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A31270CDB306444B8B5F34E2C6F14FB3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30774219-a511-4d57-97b4-08da5a2b23fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 23:57:35.9818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QmConuRStG+X/RMVBZaYgqVPFqz5XraiWaLBp6EO1ai1Y6S8wyNuA8pa5sJFUtwCCCH5HCjlThuD6p+Zba5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1510
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA2LTMwIGF0IDA3OjMzICswODAwLCBJYW4gS2VudCB3cm90ZToNCj4gDQo+
IE9uIDI5LzYvMjIgMjM6MzMsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBXZWQsIDIw
MjItMDYtMjkgYXQgMDk6MDIgKzA4MDAsIElhbiBLZW50IHdyb3RlOg0KPiA+ID4gT24gMjgvNi8y
MiAyMjozNCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDIwMjItMDYt
MjggYXQgMDg6MjUgKzA4MDAsIElhbiBLZW50IHdyb3RlOg0KPiA+ID4gPiA+IFRoZSB2YWxpZCB2
YWx1ZXMgb2YgbmZzIG9wdGlvbnMgcG9ydCBhbmQgbW91bnRwb3J0IGFyZSAwIHRvDQo+ID4gPiA+
ID4gVVNIUlRfTUFYLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSBmcyBwYXJzZXIgd2lsbCBy
ZXR1cm4gYSBmYWlsIGZvciBwb3J0IHZhbHVlcyB0aGF0IGFyZQ0KPiA+ID4gPiA+IG5lZ2F0aXZl
DQo+ID4gPiA+ID4gYW5kIHRoZSBzbG9wcHkgb3B0aW9uIGhhbmRsaW5nIHRoZW4gcmV0dXJucyBz
dWNjZXNzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJ1dCB0aGUgc2xvcHB5IG9wdGlvbiBoYW5k
bGluZyBpcyBtZWFudCB0byByZXR1cm4gc3VjY2VzcyBmb3INCj4gPiA+ID4gPiBpbnZhbGlkDQo+
ID4gPiA+ID4gb3B0aW9ucyBub3QgdmFsaWQgb3B0aW9ucyB3aXRoIGludmFsaWQgdmFsdWVzLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IFBhcnNpbmcgdGhlc2UgdmFsdWVzIGFzIHMzMiByYXRoZXIg
dGhhbiB1MzIgcHJldmVudHMgdGhlDQo+ID4gPiA+ID4gcGFyc2VyDQo+ID4gPiA+ID4gZnJvbQ0K
PiA+ID4gPiA+IHJldHVybmluZyBhIHBhcnNlIGZhaWwgYWxsb3dpbmcgdGhlIGxhdGVyIFVTSFJU
X01BWCBvcHRpb24NCj4gPiA+ID4gPiBjaGVjaw0KPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gY29y
cmVjdGx5IHJldHVybiBhIGZhaWwgaW4gdGhpcyBjYXNlLiBUaGUgcmVzdWx0IGNoZWNrIGNvdWxk
DQo+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiBjaGFuZ2VkDQo+ID4gPiA+ID4gdG8gdXNlIHRoZSBp
bnRfMzIgdW5pb24gdmFyaWFudCBhcyB3ZWxsIGJ1dCBsZWF2aW5nIGl0IGFzIGENCj4gPiA+ID4g
PiB1aW50XzMyDQo+ID4gPiA+ID4gY2hlY2sgYXZvaWRzIHVzaW5nIHR3byBsb2dpY2FsIGNvbXBh
cmVzIGluc3RlYWQgb2Ygb25lLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IElhbiBLZW50IDxyYXZlbkB0aGVtYXcubmV0Pg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IMKg
wqDCoGZzL25mcy9mc19jb250ZXh0LmMgfMKgwqDCoCA0ICsrLS0NCj4gPiA+ID4gPiDCoMKgwqAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvZnNfY29udGV4dC5jIGIvZnMvbmZzL2Zz
X2NvbnRleHQuYw0KPiA+ID4gPiA+IGluZGV4IDlhMTY4OTdlOGRjNi4uZjRkYTFkMmJlNjE2IDEw
MDY0NA0KPiA+ID4gPiA+IC0tLSBhL2ZzL25mcy9mc19jb250ZXh0LmMNCj4gPiA+ID4gPiArKysg
Yi9mcy9uZnMvZnNfY29udGV4dC5jDQo+ID4gPiA+ID4gQEAgLTE1NiwxNCArMTU2LDE0IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZnNfcGFyYW1ldGVyX3NwZWMNCj4gPiA+ID4gPiBuZnNfZnNfcGFy
YW1ldGVyc1tdID0gew0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgZnNwYXJhbV91MzLC
oMKgICgibWlub3J2ZXJzaW9uIizCoMKgT3B0X21pbm9ydmVyc2lvbiksDQo+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3N0cmluZygibW91bnRhZGRyIizCoMKgwqDCoMKgT3B0
X21vdW50YWRkciksDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3N0cmlu
ZygibW91bnRob3N0IizCoMKgwqDCoMKgT3B0X21vdW50aG9zdCksDQo+ID4gPiA+ID4gLcKgwqDC
oMKgwqDCoMKgZnNwYXJhbV91MzLCoMKgICgibW91bnRwb3J0IizCoMKgwqDCoMKgT3B0X21vdW50
cG9ydCksDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgZnNwYXJhbV9zMzLCoMKgICgibW91bnRw
b3J0IizCoMKgwqDCoMKgT3B0X21vdW50cG9ydCksDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqBmc3BhcmFtX3N0cmluZygibW91bnRwcm90byIswqDCoMKgwqBPcHRfbW91bnRwcm90byks
DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3UzMsKgwqAgKCJtb3VudHZl
cnMiLMKgwqDCoMKgwqBPcHRfbW91bnR2ZXJzKSwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoGZzcGFyYW1fdTMywqDCoCAoIm5hbWxlbiIswqDCoMKgwqDCoMKgwqDCoE9wdF9uYW1lbGVu
KSwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoGZzcGFyYW1fdTMywqDCoCAoIm5jb25u
ZWN0IizCoMKgwqDCoMKgwqBPcHRfbmNvbm5lY3QpLA0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgZnNwYXJhbV91MzLCoMKgICgibWF4X2Nvbm5lY3QiLMKgwqDCoE9wdF9tYXhfY29ubmVj
dCksDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3N0cmluZygibmZzdmVy
cyIswqDCoMKgwqDCoMKgwqBPcHRfdmVycyksDQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgZnNw
YXJhbV91MzLCoMKgICgicG9ydCIswqDCoMKgwqDCoMKgwqDCoMKgwqBPcHRfcG9ydCksDQo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgZnNwYXJhbV9zMzLCoMKgICgicG9ydCIswqDCoMKgwqDCoMKg
wqDCoMKgwqBPcHRfcG9ydCksDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFt
X2ZsYWdfbm8oInBvc2l4IizCoMKgwqDCoMKgwqDCoMKgT3B0X3Bvc2l4KSwNCj4gPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoGZzcGFyYW1fc3RyaW5nKCJwcm90byIswqDCoMKgwqDCoMKgwqDC
oMKgT3B0X3Byb3RvKSwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoGZzcGFyYW1fZmxh
Z19ubygicmRpcnBsdXMiLMKgwqDCoMKgwqBPcHRfcmRpcnBsdXMpLA0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IA0KPiA+ID4gPiBXaHkgZG9uJ3Qgd2UganVzdCBjaGVjayBmb3IgdGhlIEVOT1BBUkFN
IHJldHVybiB2YWx1ZSBmcm9tDQo+ID4gPiA+IGZzX3BhcnNlKCk/DQo+ID4gPiBJbiB0aGlzIGNh
c2UgSSB0aGluayB0aGUgcmV0dXJuIHdpbGwgYmUgRUlOVkFMLg0KPiA+IE15IHBvaW50IGlzIHRo
YXQgJ3Nsb3BweScgaXMgb25seSBzdXBwb3NlZCB0byB3b3JrIHRvIHN1cHByZXNzIHRoZQ0KPiA+
IGVycm9yIGluIHRoZSBjYXNlIHdoZXJlIGFuIG9wdGlvbiBpcyBub3QgZm91bmQgYnkgdGhlIHBh
cnNlci4gVGhhdA0KPiA+IGNvcnJlc3BvbmRzIHRvIHRoZSBlcnJvciBFTk9QQVJBTS4NCj4gDQo+
IFdlbGwsIHllcywgYW5kIHRoYXQncyB3aHkgRU5PUEFSQU0gaXNuJ3QgcmV0dXJuZWQgYW5kIHNo
b3VsZG4ndCBiZS4NCj4gDQo+IEFuZCBpZiB0aGUgc2xvcHB5IG9wdGlvbiBpcyBnaXZlbiBpdCBk
b2Vzbid0IGdldCB0byBjaGVjayB0aGUgdmFsdWUNCj4gDQo+IG9mIHRoZSBvcHRpb24sIGl0IGp1
c3QgcmV0dXJucyBzdWNjZXNzIHdoaWNoIGlzbid0IHJpZ2h0Lg0KPiANCj4gDQo+ID4gDQo+ID4g
PiBJIHRoaW5rIHRoYXQncyBhIGJpdCB0byBnZW5lcmFsIGZvciB0aGlzIGNhc2UuDQo+ID4gPiAN
Cj4gPiA+IFRoaXMgc2VlbWVkIGxpa2UgdGhlIG1vc3Qgc2Vuc2libGUgd2F5IHRvIGZpeCBpdC4N
Cj4gPiA+IA0KPiA+IFlvdXIgcGF0Y2ggd29ya3MgYXJvdW5kIGp1c3Qgb25lIHN5bXB0b20gb2Yg
dGhlIHByb2JsZW0gaW5zdGVhZCBvZg0KPiA+IGFkZHJlc3NpbmcgdGhlIHJvb3QgY2F1c2UuDQo+
ID4gDQo+IE9rLCBob3cgZG8geW91IHJlY29tbWVuZCBJIGZpeCB0aGlzPw0KPiANCg0KTWF5YmUg
SSdtIG1pc3Npbmcgc29tZXRoaW5nLCBidXQgd2h5IG5vdCB0aGlzPw0KDQo4PC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpkaWZmIC0tZ2l0IGEvZnMvbmZzL2ZzX2NvbnRleHQuYyBi
L2ZzL25mcy9mc19jb250ZXh0LmMNCmluZGV4IDlhMTY4OTdlOGRjNi4uOGYxZjliNGFmODlkIDEw
MDY0NA0KLS0tIGEvZnMvbmZzL2ZzX2NvbnRleHQuYw0KKysrIGIvZnMvbmZzL2ZzX2NvbnRleHQu
Yw0KQEAgLTQ4NCw3ICs0ODQsNyBAQCBzdGF0aWMgaW50IG5mc19mc19jb250ZXh0X3BhcnNlX3Bh
cmFtKHN0cnVjdA0KZnNfY29udGV4dCAqZmMsDQogDQogCW9wdCA9IGZzX3BhcnNlKGZjLCBuZnNf
ZnNfcGFyYW1ldGVycywgcGFyYW0sICZyZXN1bHQpOw0KIAlpZiAob3B0IDwgMCkNCi0JCXJldHVy
biBjdHgtPnNsb3BweSA/IDEgOiBvcHQ7DQorCQlyZXR1cm4gKG9wdCA9PSAtRU5PUEFSQU0gJiYg
Y3R4LT5zbG9wcHkpID8gMSA6IG9wdDsNCiANCiAJaWYgKGZjLT5zZWN1cml0eSkNCiAJCWN0eC0+
aGFzX3NlY19tbnRfb3B0cyA9IDE7DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
