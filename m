Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D962D2FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 06:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiKQFub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 00:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbiKQFuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:50:07 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2053.outbound.protection.outlook.com [40.107.113.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96027E2A;
        Wed, 16 Nov 2022 21:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcvGLahwxdFsTznsg4d6a/nhNGRVaA2yS7m3lEs8vce1GR/jpLfKcoLPNVkfvE3Jeywo/DVukYxKfkR/onkvT/S0oQI8QitHXIZvULJriLsvo5QWoXpO/U81GGLjRIQM4g6xFRceCmBz9TIaNEfTde4nwwv1oZ1Y4Tk9MNHxOA1/hROdNAmV3K93DXOhKVvGRupSQ4lDoeDrjn1cRTfczgfPrOvdWViofTsp8FHytIST5Y1vBl5NuCDh2HciOr+XhPGyq7a7xm2YZBMq5h6Pd8WEYUWbOUpSKmsZHbRpunT0KAQGw0SaF+WozXsEh4vlbuDA1eMqnCQx9qmcT/SNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WakgoREuAOiWvD7OuBOmdeUf9uzHSA60aPzxDpHSNE=;
 b=d9g/dUq7DXd+8UnONG74NXhvabdRCuWlkwOTQ5lw9NuyiT3Y2FP7K3htSSTbZKWKin1mtv7lL8vZe3x9e5Goc24yUhZGdzniZ/QA9tHRSyEq72qwZ/wbb6ZSCw14VRYDubf0Cz6jtATwe5L/7y8wBQp+aZMNBxa9CYgPbFw3KbTqKc8D6rMfOPozRZv/U5N6OhSZEaA/iZ6XP08HL1D0BTWZYeKHSQl9om0Rs2T1VdFwZCnGjcG9oL1HmK1qBOgUtzYto3tQXtYQPManf8l/YSsWkLQE5eTkKgVrrNCHrgs8E6qNEoAPZ10yZ2zT9yTXolwB4AjCf/mHJwf1B5ixWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WakgoREuAOiWvD7OuBOmdeUf9uzHSA60aPzxDpHSNE=;
 b=d/dKBDp0ZATU9fB2OyAv12tddKhyuhRktxxmXjDDUtjS2Hr4HBRvCAY7HxCrlq8FHziIQhSxTfngNHRlKk85olvs8RkVOwvbYyEM7X4pC5P98VKrQqFE1ROjS0/Dwhm4kSqUlOfv6vJXkVVM97l4GBL7Z22F+PUBJluSxlzLPgY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB5673.jpnprd01.prod.outlook.com (2603:1096:404:8052::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 05:49:27 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%7]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 05:49:27 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: [PATCH 3/4] memory-failure: Convert truncate_error_page() to use
 folio
Thread-Topic: [PATCH 3/4] memory-failure: Convert truncate_error_page() to use
 folio
Thread-Index: AQHY+WCXTUnInI8R702OWCGz2BHGca5CnekA
Date:   Thu, 17 Nov 2022 05:49:27 +0000
Message-ID: <20221117054918.GA881314@hori.linux.bs1.fc.nec.co.jp>
References: <20221116021011.54164-1-vishal.moola@gmail.com>
 <20221116021011.54164-4-vishal.moola@gmail.com>
In-Reply-To: <20221116021011.54164-4-vishal.moola@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYAPR01MB5673:EE_
x-ms-office365-filtering-correlation-id: 7aaa8d7f-f163-4bed-5ee2-08dac85f7d54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Rdks1PfIJ8qv//XIOf0vUQ2UdNzDVqtX9geR5cK+3/V/aWeMkxQ2tdwH6vyaI1bqCwrGjHh7NmdpwU+LH3U9+gpoYTUBAViuk120JiJsW04Xldl0u3GrwXJXaCvOMRWkC5AFUwOKvjJNaUX802e9jXrI/ca7QSnTWyrGKHv86dxNHSr/hiMnFv820qIqtlwoL5mdvoZneam9uYRjdlA/HBEvQekSwYIy1ClrKl21i8tiAQtaL7jlzO5qZ3EXFHoSscAWby6Rep1Axfvxf/W8fF46u5jCAYFAWNr+AED3a6/VUqlEh/K5lHC4IAgvmWS2V2EihA5NiReiA631sOgK1RZ+tNQfyGxqYPUkkGQ93pJ3k88TYAosCz7JbaoIR1BTIj0FNQck1oShCnYWd2r/Dhnx2rbepmbQ4Vco9Df9azLaVyavVSZHsmyCbvqa8ezRDSxxoirqfEs78438JG+XcXTlcpsqIRkVlnHYlzQgMw35sC76di8mD0vz7NP6S4b9702YqNMY1zvlg5FRq7H/+4jJx6qkqoGzxrBqIKzS0ZzeL+FKLy9U6BaDpymmvFGwM5aiu73v+2xoX6z0dxaVPK4BGTMPBIp2882KPepTTVqZOe+o1wyYfCJxBShnLsaZUkcrB8dkSh8mY1C8zz/bBf6Iw5bzwCGSUHkB3UreWdPRiJgZmpiw40Wm1qvHTpbZyZq7LPH0jeBg0dlquzXUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(86362001)(38100700002)(6506007)(55236004)(9686003)(26005)(6512007)(82960400001)(186003)(1076003)(54906003)(6916009)(5660300002)(8936002)(6486002)(66446008)(66556008)(66476007)(64756008)(8676002)(4326008)(71200400001)(33656002)(38070700005)(41300700001)(85182001)(66946007)(478600001)(316002)(76116006)(2906002)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWt5ZmUvdjgzUXFIM1ZoTzcxRXUyblVGYWVRc1lEcVdjUzVzcUhnZEs5c0h0?=
 =?utf-8?B?bloyeExvQTBiUlV5QXhEZlppWCsyZDNTaVVFNFBiaW5sNmRJUzRHYnN6VlZE?=
 =?utf-8?B?ajkvSDB0cGFRdGFrdUV5SVdOOTJScHBlSURtUzg1T0pnWDNtWVR6V2FhN1hn?=
 =?utf-8?B?eXIwYVQ4c1VwcWt4NnFtSHNiRkRHQ0hMMTk2aUtnWXc3SzRhdndrY3I5T0xs?=
 =?utf-8?B?REZXWndBQkdwZEV0WWkreW1Qem02UmN3dHI2SnhNWW5sSUNxYmQ1empoU2lo?=
 =?utf-8?B?bmV0ekRnbGZJcitCQVRPa3VZZmRCaVNuRUE3VWNrS0NTRHJoOGUrSlpZWG5i?=
 =?utf-8?B?WVI0V1dYekJ6NVRVK2J0aUZzUUR3YmZUdDd3ajhtb3NrcXFOU3d5ekx1dGdp?=
 =?utf-8?B?UlpXV1lkN090UlJzaVpjaEUzL0RybUVIcmRmejFNNnZXVDU0NExteWFEeWxz?=
 =?utf-8?B?Z2phUHZxWHFYUk9laVZnWWFyK29ZNmtoUFdxMjhucER1WGxqeWljY0FOQnM2?=
 =?utf-8?B?Z1ExK0dnL1BDRXZsWUs5bFZTeUdyM0wyOFdKeVkzcGdLNWd3RnhXdFZPTnBZ?=
 =?utf-8?B?bE9pb2NKN085cm5vUDlEU2JrcXVKZmZCZUx2VGJpNUlwbTU1M1dSQ0gwVSsz?=
 =?utf-8?B?elR5Qkp4VlJUbmJjWCtvS3BvMGRWYnRIeWJaTlVuTU1mZ0xJVkRLcEVPRFMy?=
 =?utf-8?B?cnRKTm5Sb3FQZnNiclRSOHVRZXNJc1F2V0h4RWtVVWZ2UWNTNlJMUzYxbElW?=
 =?utf-8?B?UG4vV3Voa2NleFVLMjZUQ05yUWc5YnY5TVlRYW91VmVVcXp3WVEyOXNnNFUx?=
 =?utf-8?B?WWJRQ0FYd3c5YWFuNW5lZ21OZ2RQNE5hK2NjUktDNmc3Y1NCdkkrWWVMWndu?=
 =?utf-8?B?di9aUlBQc0dBT1NDdC8rZXZtbWorSVhvM2hCYkFXTU9Kb0lNQUs0S2lsaVhC?=
 =?utf-8?B?Y2QyUjB0a25oa1U1VW1SeU9UTHAvQ0dRRXpqamhHRkUxcHNLTlZZdGlKd3Uw?=
 =?utf-8?B?NVM1RGY4QXluNjdpc1I1OUpuWDBFcmlOckdLeWdWeExOb2VaeVV4S0hPWnc2?=
 =?utf-8?B?MTFEN043cjZMWlovQ28wKzJtcm1aam55MHFjWnBReGc3VzROREVMZWV6THV3?=
 =?utf-8?B?VW1nMHZwT2p0SVMrSGVzWk1ObFdtelN0SkFic0FITkdxT09reUdlUm8xQWE2?=
 =?utf-8?B?aGQ4RHcwRm5RVmhKUVFNWk9rL2tjNGUxR2RiWWpmNURaQWdoUS94SHJ2STBZ?=
 =?utf-8?B?THZHeFY1MHZ1SGRXZjBNTWkvdld0b3FmenlTQmlvUisxcTQralQyUkMwVUZz?=
 =?utf-8?B?SUg2SWZtQlR1elRhWEFDZFVXTS9RYkdnNTBXWDlsNCtnRnRwdi9ObHFzbFJx?=
 =?utf-8?B?RFdGazF2NHg2ck9jQzJySWg2RjJmaDJzc1NoZURKUFdrQ3RIK1hhNFNSYms5?=
 =?utf-8?B?bkgvUGR1WTQrekY0K25tRGJ1dFlIYnVMclQ4TkdRN1oraUlSZ09SK1c0eXZC?=
 =?utf-8?B?QWRDUU5NZEtxWHlsYU12aDFTLzlWZW5UT3ExMTVvMVY1ZE92YTdLTWorbW5j?=
 =?utf-8?B?RXkreFZoNFB6aXBMMXZ3UFFDNzdlTTVjQ2N1dUxzeElMN20xWThMYysyZnpK?=
 =?utf-8?B?dnllNWo2TUtNc0xNcHdFVWJ3S0RoY04xcmRlWUhQWHZiZWdaOW5GNzJIUVJE?=
 =?utf-8?B?TzFFVzJkdFhYNWtYaVBXcDlkL0hrL2ZKdUUyOGhYRmhXSWM2OVNtTCswZWxZ?=
 =?utf-8?B?YUdYUFVhc2xhRUZqcDAzdENWZHFmaytSUFlXUkVDRGU5c2wyVHhpMThEU3pB?=
 =?utf-8?B?ZktwTDgxYnpMWWdNZzAxZVJxYWxPWHhzQVhqSkFPZ2hYTkR2OEpaNnBlcnZL?=
 =?utf-8?B?a3BQVkdFSStJRUxzUDRjVURtelliQmkwRWZwYUVNMzZrZWhpWDB2L29CbjM2?=
 =?utf-8?B?enpKS1FwbzdPSU9jNHJab1pVajByUW1qR0tKNVhJeklwR1hsZzRtYmtucDJF?=
 =?utf-8?B?c3l1Qy9sa3Fsb040TkgvTU9DUTRCcmFYTlFxRUUzZDlOYW1iRks5bTA1dU1r?=
 =?utf-8?B?OFFETXh5NlJDL2wzUGJqTDVLVVlYbFpZekVBeHk3aGs3UnRqWXFERWtPTTQ0?=
 =?utf-8?B?RjVGMmdkakxzZy8yK2JTRWRITjZYeWh6cnlmWHB5dUJ5QVUzSWd4RW8rbVhX?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E051B4B41AFB9499E7B73F77D8B9624@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaa8d7f-f163-4bed-5ee2-08dac85f7d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 05:49:27.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4yrLrJIc1JWp0KEkUNjSFiaXUPLTRUt/0EAwGrDGLFH0LBUU9WoS7qI8kVgauoACHQiT+vdR+V5tRYt2l2SbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5673
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCBOb3YgMTUsIDIwMjIgYXQgMDY6MTA6MTBQTSAtMDgwMCwgVmlzaGFsIE1vb2xhIChP
cmFjbGUpIHdyb3RlOg0KPiBSZXBsYWNlcyB0cnlfdG9fcmVsZWFzZV9wYWdlKCkgd2l0aCBmaWxl
bWFwX3JlbGVhc2VfZm9saW8oKS4gVGhpcyBjaGFuZ2UNCj4gaXMgaW4gcHJlcGFyYXRpb24gZm9y
IHRoZSByZW1vdmFsIG9mIHRoZSB0cnlfdG9fcmVsZWFzZV9wYWdlKCkgd3JhcHBlci4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBNb29sYSAoT3JhY2xlKSA8dmlzaGFsLm1vb2xhQGdtYWls
LmNvbT4NCg0KTG9va3MgZ29vZCB0byBtZSwgdGhhbmsgeW91Lg0KDQpBY2tlZC1ieTogTmFveWEg
SG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCg0KPiAtLS0NCj4gIG1tL21lbW9y
eS1mYWlsdXJlLmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMg
Yi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IGluZGV4IDE0NWJiNTYxZGRiMy4uOTJlYzliMGU1OGEz
IDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ICsrKyBiL21tL21lbW9yeS1m
YWlsdXJlLmMNCj4gQEAgLTgyNywxMiArODI3LDEzIEBAIHN0YXRpYyBpbnQgdHJ1bmNhdGVfZXJy
b3JfcGFnZShzdHJ1Y3QgcGFnZSAqcCwgdW5zaWduZWQgbG9uZyBwZm4sDQo+ICAJaW50IHJldCA9
IE1GX0ZBSUxFRDsNCj4gIA0KPiAgCWlmIChtYXBwaW5nLT5hX29wcy0+ZXJyb3JfcmVtb3ZlX3Bh
Z2UpIHsNCj4gKwkJc3RydWN0IGZvbGlvICpmb2xpbyA9IHBhZ2VfZm9saW8ocCk7DQo+ICAJCWlu
dCBlcnIgPSBtYXBwaW5nLT5hX29wcy0+ZXJyb3JfcmVtb3ZlX3BhZ2UobWFwcGluZywgcCk7DQo+
ICANCj4gIAkJaWYgKGVyciAhPSAwKSB7DQo+ICAJCQlwcl9pbmZvKCIlI2x4OiBGYWlsZWQgdG8g
cHVuY2ggcGFnZTogJWRcbiIsIHBmbiwgZXJyKTsNCj4gLQkJfSBlbHNlIGlmIChwYWdlX2hhc19w
cml2YXRlKHApICYmDQo+IC0JCQkgICAhdHJ5X3RvX3JlbGVhc2VfcGFnZShwLCBHRlBfTk9JTykp
IHsNCj4gKwkJfSBlbHNlIGlmIChmb2xpb19oYXNfcHJpdmF0ZShmb2xpbykgJiYNCj4gKwkJCSAg
ICFmaWxlbWFwX3JlbGVhc2VfZm9saW8oZm9saW8sIEdGUF9OT0lPKSkgew0KPiAgCQkJcHJfaW5m
bygiJSNseDogZmFpbGVkIHRvIHJlbGVhc2UgYnVmZmVyc1xuIiwgcGZuKTsNCj4gIAkJfSBlbHNl
IHsNCj4gIAkJCXJldCA9IE1GX1JFQ09WRVJFRDsNCj4gLS0gDQo+IDIuMzguMQ==
