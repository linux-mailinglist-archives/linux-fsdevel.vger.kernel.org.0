Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F7659CC28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 01:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbiHVX0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 19:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbiHVX0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:26:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2109.outbound.protection.outlook.com [40.107.243.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E90558D5;
        Mon, 22 Aug 2022 16:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFcwjrBmT6Mi5UPW4CJbwrT/P3V/9unL0pcmfgtuqVonD7ASqZ3yGtun7M4SqOY/wb/Kl/beGx4vFxF54jgA33Zk8a1qSiCrecanKa4nXyNzplEw71IZXdOhfv8efnbcPBKVSaMIgc/Jf1iVzjVF5HVyzxIfFfNAIEE/asyeaaodT7J9nXirbRLd11s9lEJpXfbqQmBEJDrnjSZvqTQrwJLkLAa2TG6O99sQNhG84t0gSh0IRzKDyJPZQdsR68UpNGOlYd0PuAtP2e+osgSpZ1Dz06uwNPLxW+YSPhiZ1gZ+8LGzA0VBPH7DHtb9ASh5fiISnGhrDCEr/8MJxqFhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsP7zERufAe4H6J/ABljZ/Sp0jzHFzCwvtRfoZ9K834=;
 b=Tuhv+zMd+inRhkHEqnKABr/FuTo1SA+QBmrX27dOzYfdI1YQ7RhUu/QCsWYDx0/Le0rZqKHG+po4c3sXEZsq1upBy9XKUwfW4grtaJ4MWQi4x5E/NN3MpIHGmOLTkp+OQK6mlzNVOj/xuZS+6xRYAk7RywC+FFzqC4zFsWPrCfQ5lm4L61tHKyaZ1QZ+JrlXbCNbXWH+4zOnriyNbPpyIT+5e7DjaJol/3Ynhtjx9RFC54kfOHsIfHXeEfWhLtWY3PC4at2faY8bCVS/MAdXWC0vgm4cI3QjZKOcEIQWAv8bqPEXGqze41LgyufNPybBj4hNk14TkuMw427p35VP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsP7zERufAe4H6J/ABljZ/Sp0jzHFzCwvtRfoZ9K834=;
 b=CXCgrpMh21nBWuSmYIc9GZY4ldFZXBh5j5VQDUNpIkSfXCGHpqjZj3bfwz+gk4wpgddi8cqb+uDL9X4B5Pbdio06lDYxILab8bqrI1SDtA/UouX3EEDhfSNCWGpKo7+AvAmoDl3MxL3iE8+TTqzWyjCNV4ETTZLNBF46RK0mxTY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1227.namprd13.prod.outlook.com (2603:10b6:3:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 22 Aug
 2022 23:26:44 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.014; Mon, 22 Aug 2022
 23:26:44 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
Thread-Topic: [PATCH] iversion: update comments with info about atime updates
Thread-Index: AQHYtiu78BIi9dXZ8UOO9hQoVoU0MK27hIKAgAAMbAA=
Date:   Mon, 22 Aug 2022 23:26:44 +0000
Message-ID: <1ec733a26f70a82db762ca8c502482413d266f4d.camel@hammerspace.com>
References: <20220822133309.86005-1-jlayton@kernel.org>
         <166120813594.23264.3095357572943917078@noble.neil.brown.name>
In-Reply-To: <166120813594.23264.3095357572943917078@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94e8404a-ee40-4b50-a89d-08da8495c6d7
x-ms-traffictypediagnostic: DM5PR13MB1227:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XVl1hn03R9jTNtBk3hBvSNQraGI9d69RwpuupfcOVLNaZBKANZU/rP6IsF4k1ztGQ0w5PQqt2vtXMM5sF8hnU9Uzcq+3GvgQ3d3p/DI7/VX6MwKNuI1LSHAwp0/2EmF/mqqL8j4nbHAi/VKNjLJDPh5VvUbfT6otdcKMq3i7wSVcnxrm5i4N4OOnpc4LDxePV5earGOD3sQWevucuHdiySZxitUNeLxhVrGH7qoMVD1j36jaDmpafWjxCWzjHO43P6rACCSGkkNFe5gWZ/d3h3+4qybQ9TrwjjNQeABi3SFGQcfblybi3CF7ky8aAEUMABKzBZj2LCwyvXOx3ZL0E5ZMB9lHGqGqiCZ7gk6DisD87yPhn1+OT+c1SZY7nD3rDU9KYx3ZCk3xIsQbIMlIpAEUMneYxa7UPTDftsL3SMG3VcQEKrsTvscYQTonxOSa+CbJqXTyz4nVar+NdFiLugUUWu1k2GjyjgGnl6JvKLMaRcf9Ec29rSXFiYuSUt2q2KY2rUALDmbfIxwBKnRigXqSt4PWymNJ5i5EXPHrSVPeXMvhnX/XmzNleWzk9NIYByR/tbzC7DTjYmO/32mYAoJVeHCx5rFfs4+DheIFKRa8Agh6nPxo2pk6LrvaaWHvh/9Qkc6tIr19pHDwbDAZMXK3BRzEfW0aYi2pLta1sst92pHuHtbNFQ10Z8pLhLZU3V50mIsvD/2e+H/e4PW9TkdemNNgjAeuMoeqHR7Qy9hgMoKnpkid4HdjbjniKaajsWO6N+K97RI7wSxUie2psEqkRvohqcVm+/C1S3RkFhw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(366004)(376002)(346002)(396003)(136003)(64756008)(83380400001)(2616005)(6506007)(6512007)(26005)(2906002)(186003)(38070700005)(86362001)(38100700002)(122000001)(66556008)(6486002)(966005)(66476007)(76116006)(41300700001)(66946007)(5660300002)(66446008)(316002)(8676002)(36756003)(54906003)(110136005)(478600001)(71200400001)(4326008)(15650500001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S25TWkxqRkh4UFk5VU5wNjA1UytNZk1xNlExSDd4MVJ0Yzk0R3AyNy85dzcx?=
 =?utf-8?B?N1UxUXh2dHduOWxOTUNFdytQMEkvdXV3ODQzVThCL3Q5aUVNckxxVUUxMkFW?=
 =?utf-8?B?L3JiWkkralVZTXRWMGZqMkh4NUE2NjNSSE84bmpCbmFtL3RQUkZUdHBRa0hw?=
 =?utf-8?B?UDc3ZkZ2a1JCWFREVXYwSzh4eFhFRVB1Z2M3aE9WQmRRSkpheXZhcTl0cFNz?=
 =?utf-8?B?RlFXNTJXbFBTR243TDdJQTZRajl4ZlFuVW05SVMzMjdPNy8rQzFHdnBMWU9D?=
 =?utf-8?B?NGxPT3F3a3FhTWVuYVp6ZTlZS21vL1dldHI3RisvWGNJTVRqVzhJVUxmVHNh?=
 =?utf-8?B?RVpYOEdqRURROUpObVhsZ1NQcHl2bThhSThDY3p1TlN0WlBsMG9CWW9kSDBW?=
 =?utf-8?B?ekVjRE9uVjhPOUovVGJNbU54SUNmQXhLVkRoTlFNT3plUzdveGJKVXp5UUEr?=
 =?utf-8?B?T3ZXbzlEaXh2ckJoZ0U2TlhYaGhBOW93UU5jZ1Z6bWF6N1JGZHFvNm01b0FL?=
 =?utf-8?B?Y1hTWklLNHZDbGIwRmhmSVlhR21NbWVCaUt2dGUySTl3Q0VHME9UTUorSU5x?=
 =?utf-8?B?NzB3dkpCQTViVFhSVlhHUTJycFpmRnN2SUZ0MHlMdjBkYlk0emN5UFdpRHNY?=
 =?utf-8?B?YWF5c3UzSnRRN21laEhabnBoZFJocWhPVFkvNUpZOFZLWGFpM1pEWWNlWnp4?=
 =?utf-8?B?RHhqMW9kT04rbzVtbllRZTROS2x2ekd4QllpSEZzanhqVE5HQktwOWdGT0Ni?=
 =?utf-8?B?bllKaG9tNEdBWWtZWXpRLzZNMW9zcnV0WkZ4ZnJFdmp3YzlhYnVRY202QVQz?=
 =?utf-8?B?NUhLT0p2M2VRMVYvbWpGaUErSjA5SnlrMnhhN25ldUoyZURIZFErK1FST01Y?=
 =?utf-8?B?TG05NFpYMzRLdU5Icll2KzY4OEc1dDgwaFk0ZVFDbzNEYmRPd3FzT05KMXU3?=
 =?utf-8?B?UDh3TXlYODV1RHRTdWZmMExPcHU3bFFGZ3o3MWsrVm9SN09HQm5QUFMzc3hu?=
 =?utf-8?B?cWxmcU1uS0x2WWVYc2ZXTGgrdWdqbXRQUDRlbThIL3hCSGV2a2IvY0tzZlBU?=
 =?utf-8?B?OFNGN1JlbjNURG9SUVVLOUxwUlR3YmkzRURyOXdDOTJuSUlMOTJCaXlUNTNG?=
 =?utf-8?B?ZEhRb0xtZVJRWWdTZTEzQkxET1dxOGgzYjNlWnJpYXJ0TXIrVE1XeUNmSlU0?=
 =?utf-8?B?b2tZZGkyUnd0OEJoUXdaVGg3cHpwY2FmdFk5Qi9Zd1lXTVdlM29FM3dtWkx5?=
 =?utf-8?B?L1h0a2phckQwcEFSNENXeG4wZXliTmhpaGlqdnJJSW9uTFB6YlprYitsQXdW?=
 =?utf-8?B?VWl2OGtUenE5RjU4UGZwOGRydGcyWmZrdk50b25NUFoyU0E5bUNkR3hSRFA0?=
 =?utf-8?B?T2QxZk5YNE9uTUVCZGNjcXZQUVl0eFYxQ2lycnJWbjhMQUFPMFVrd1ArN3Rl?=
 =?utf-8?B?MndWKzFyWk16Smc5czFxeWVvUTJWa2RmWXdxaGZGeVFhT29QMWQyc0RVWTFO?=
 =?utf-8?B?aE1hQVd4SVlXQkxObnFIL0h5b2Njb1hvdVhPdUxkZnhVVXcwYmF0dHI5R3k4?=
 =?utf-8?B?M3BlbkljWDhUb2xUTzhxNUVDbDlVV3A4K2dSYi8zZ3VVVUZ4bE9RcDcxdEN1?=
 =?utf-8?B?cWNGZ3pXcHRwTzREWmhuelFHSHcvNDhqelRsOVFIYmpsY2V2emhoaHl2THNC?=
 =?utf-8?B?SnRsZGN6a2tJWWE1RWlTaVppVXZsb2k0U21qOXNPTGZBRWxzUDlMQWVEUmV3?=
 =?utf-8?B?LytwMzA1c0lOOXBWUWphK1RwY0FxWnNRc0F5V3lBR05ER1c1WG9VbFpaNXVI?=
 =?utf-8?B?T0p3S2k2VlNVZHMvYUNjWEx6QzZhWHRleVVVcHFQSCtidU54dlM5ck1uSnI4?=
 =?utf-8?B?cmo3TWJ1UmJNYWRHSTZUeXZsZ0VyWXJDbGd0YVhRdWVXNi9ERE9HcC9MQ2Y3?=
 =?utf-8?B?cHZ1b05CWEN6SnR5OEU1RUhVVWhnNVdhc3dWSTFESXlFRGRCNGpySit4SVhV?=
 =?utf-8?B?TmFlQlpMRWs4M3k4UDZPQzVjOHU0TW5mOFVLRVJaQ3g4anoxVWhzUDFmamVk?=
 =?utf-8?B?TU83dUE0Y09ScWZTQXZyMUFzTVRmcWk1R3p1MmdVTDdqWjRGaUI5QXl4c1N4?=
 =?utf-8?B?aGpOM0RkbG5sNzRNRmhrbXN3M0hiVlE1L2lRWGQ1bHNVMGNXWTZEbW9zd1Mx?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E00050EF7328649BC3F559F1E083B1B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e8404a-ee40-4b50-a89d-08da8495c6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 23:26:44.7049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfXVRaT2XcUo49j2enqCzk7nyKAEZhxgPbYs8XOvIHtz+pFSg7S06bito/wmh+/NQw4xT3VyBgGJQOnxr+/Atw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1227
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTIzIGF0IDA4OjQyICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IE1vbiwgMjIgQXVnIDIwMjIsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+IEFkZCBhbiBleHBsaWNp
dCBwYXJhZ3JhcGggY29kaWZ5aW5nIHRoYXQgYXRpbWUgdXBkYXRlcyBkdWUgdG8gcmVhZHMNCj4g
PiBzaG91bGQgbm90IGJlIGNvdW50ZWQgYWdhaW5zdCB0aGUgaV92ZXJzaW9uIGNvdW50ZXIuIE5v
bmUgb2YgdGhlDQo+ID4gZXhpc3Rpbmcgc3Vic3lzdGVtcyB0aGF0IHVzZSB0aGUgaV92ZXJzaW9u
IHdhbnQgdGhvc2UgY291bnRlZCwgYW5kDQo+ID4gdGhlcmUgaXMgYW4gZWFzeSB3b3JrYXJvdW5k
IGZvciB0aG9zZSB0aGF0IGRvLg0KPiA+IA0KPiA+IENjOiBOZWlsQnJvd24gPG5laWxiQHN1c2Uu
ZGU+DQo+ID4gQ2M6IFRyb25kIE15a2xlYnVzdCA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+DQo+
ID4gQ2M6IERhdmUgQ2hpbm5lciA8ZGF2aWRAZnJvbW9yYml0LmNvbT4NCj4gPiBMaW5rOg0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXhmcy8xNjYwODY5MzI3ODQuNTQyNS4xNzEz
NDcxMjY5NDk2MTMyNjAzM0Bub2JsZS5uZWlsLmJyb3duLm5hbWUvI3QNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+IMKgaW5j
bHVkZS9saW51eC9pdmVyc2lvbi5oIHwgMTAgKysrKysrKystLQ0KPiA+IMKgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9pdmVyc2lvbi5oIGIvaW5jbHVkZS9saW51eC9pdmVyc2lvbi5oDQo+
ID4gaW5kZXggM2JmZWJkZTVhMWE2Li5kYTZjYzFjYzUyMGEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5j
bHVkZS9saW51eC9pdmVyc2lvbi5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9pdmVyc2lvbi5o
DQo+ID4gQEAgLTksOCArOSw4IEBADQo+ID4gwqAgKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiDCoCAqIFRoZSBjaGFuZ2UgYXR0cmlidXRlIChpX3ZlcnNpb24pIGlzIG1hbmRhdGVk
IGJ5IE5GU3Y0IGFuZCBpcw0KPiA+IG1vc3RseSBmb3INCj4gPiDCoCAqIGtuZnNkLCBidXQgaXMg
YWxzbyB1c2VkIGZvciBvdGhlciBwdXJwb3NlcyAoZS5nLiBJTUEpLiBUaGUNCj4gPiBpX3ZlcnNp
b24gbXVzdA0KPiA+IC0gKiBhcHBlYXIgZGlmZmVyZW50IHRvIG9ic2VydmVycyBpZiB0aGVyZSB3
YXMgYSBjaGFuZ2UgdG8gdGhlDQo+ID4gaW5vZGUncyBkYXRhIG9yDQo+ID4gLSAqIG1ldGFkYXRh
IHNpbmNlIGl0IHdhcyBsYXN0IHF1ZXJpZWQuDQo+ID4gKyAqIGFwcGVhciBkaWZmZXJlbnQgdG8g
b2JzZXJ2ZXJzIGlmIHRoZXJlIHdhcyBhbiBleHBsaWNpdCBjaGFuZ2UNCj4gPiB0byB0aGUgaW5v
ZGUncw0KPiA+ICsgKiBkYXRhIG9yIG1ldGFkYXRhIHNpbmNlIGl0IHdhcyBsYXN0IHF1ZXJpZWQu
DQo+IA0KPiBTaG91bGQgcmVuYW1lIGNoYW5nZSB0aGUgaV92ZXJzaW9uPw0KPiBJdCBkb2VzIG5v
dCBleHBsaWNpdGx5IGNoYW5nZSBkYXRhIG9yIG1ldGFkYXRhLCB0aG91Z2ggaXQgc2VlbXMgdG8N
Cj4gaW1wbGljaXRseSBjaGFuZ2UgdGhlIGN0aW1lLg0KDQpBY3R1YWxseSwgUE9TSVggb25seSBy
ZXF1aXJlcyB0aGF0IHRoZSBtdGltZSBhbmQgY3RpbWUgY2hhbmdlIG9uIHRoZQ0Kc291cmNlIGFu
ZCB0YXJnZXQgZGlyZWN0b3J5LiBUaGVyZSBpcyBubyByZXF1aXJlbWVudCB0aGF0IHRoZSBjdGlt
ZQ0KY2hhbmdlIG9uIHRoZSBmaWxlIGl0c2VsZiwgYWx0aG91Z2ggc3VjaCBhIGNoYW5nZSBpcyBw
ZXJtaXR0ZWQgYnkgdGhlDQpzcGVjIGluIG9yZGVyIHRvIGFsbG93IGZvciBleGlzdGluZyBmaWxl
c3lzdGVtIGltcGxlbWVudGF0aW9ucy4NCg0KaHR0cHM6Ly9wdWJzLm9wZW5ncm91cC5vcmcvb25s
aW5lcHVicy85Njk5OTE5Nzk5L2Z1bmN0aW9ucy9yZW5hbWUuaHRtbA0KDQpJJ2QgcHJlZmVyIG5v
dCBjaGFuZ2luZyB0aGUgaV92ZXJzaW9uIG9uIHRoZSBmaWxlIG9uIHJlbmFtZSwgYnV0IGNvdWxk
DQpsaXZlIHdpdGggYW4gaW1wbGVtZW50YXRpb24gdGhhdCBjb3BpZXMgdGhlIGN0aW1lIGJlaGF2
aW91ci4NCg0KPiANCj4gPiDCoCAqDQo+ID4gwqAgKiBPYnNlcnZlcnMgc2VlIHRoZSBpX3ZlcnNp
b24gYXMgYSA2NC1iaXQgbnVtYmVyIHRoYXQgbmV2ZXINCj4gPiBkZWNyZWFzZXMuIElmIGl0DQo+
ID4gwqAgKiByZW1haW5zIHRoZSBzYW1lIHNpbmNlIGl0IHdhcyBsYXN0IGNoZWNrZWQsIHRoZW4g
bm90aGluZyBoYXMNCj4gPiBjaGFuZ2VkIGluIHRoZQ0KPiA+IEBAIC0xOCw2ICsxOCwxMiBAQA0K
PiA+IMKgICogYW55dGhpbmcgYWJvdXQgdGhlIG5hdHVyZSBvciBtYWduaXR1ZGUgb2YgdGhlIGNo
YW5nZXMgZnJvbSB0aGUNCj4gPiB2YWx1ZSwgb25seQ0KPiA+IMKgICogdGhhdCB0aGUgaW5vZGUg
aGFzIGNoYW5nZWQgaW4gc29tZSBmYXNoaW9uLg0KPiA+IMKgICoNCj4gPiArICogTm90ZSB0aGF0
IGF0aW1lIHVwZGF0ZXMgZHVlIHRvIHJlYWRzIG9yIHNpbWlsYXIgYWN0aXZpdHkgZG8NCj4gPiBf
bm90XyByZXByZXNlbnQNCj4gPiArICogYW4gZXhwbGljaXQgY2hhbmdlIHRvIHRoZSBpbm9kZS4g
SWYgdGhlIG9ubHkgY2hhbmdlIGlzIHRvIHRoZQ0KPiA+IGF0aW1lIGFuZCBpdA0KPiA+ICsgKiB3
YXNuJ3Qgc2V0IHZpYSB1dGltZXMoKSBvciBhIHNpbWlsYXIgbWVjaGFuaXNtLCB0aGVuIGlfdmVy
c2lvbg0KPiA+IHNob3VsZCBub3QgYmUNCj4gPiArICogaW5jcmVtZW50ZWQuIElmIGFuIG9ic2Vy
dmVyIGNhcmVzIGFib3V0IGF0aW1lIHVwZGF0ZXMsIGl0DQo+ID4gc2hvdWxkIHBsYW4gdG8NCj4g
PiArICogZmV0Y2ggYW5kIHN0b3JlIHRoZW0gaW4gY29uanVuY3Rpb24gd2l0aCB0aGUgaV92ZXJz
aW9uLg0KPiA+ICsgKg0KPiANCj4gSWYgYW4gaW1wbGljaXQgYXRpbWUgdXBkYXRlIGhhcHBlbmVk
IHRvIG1ha2UgdGhlIGF0aW1lIGdvIGJhY2t3YXJkcw0KPiAocG9zc2libGUsIGJ1dCBub3QgY29t
bW9uKSwgdGhlIHVwZGF0aW5nIGlfdmVyc2lvbiBzaG91bGQgYmUNCj4gcGVybWl0dGVkLA0KPiBh
bmQgcG9zc2libHkgc2hvdWxkIGJlIHByZWZlcnJlZC4NCj4gDQoNCk1heWJlLg0KDQo+IE5laWxC
cm93bg0KPiANCj4gDQo+ID4gwqAgKiBOb3QgYWxsIGZpbGVzeXN0ZW1zIHByb3Blcmx5IGltcGxl
bWVudCB0aGUgaV92ZXJzaW9uIGNvdW50ZXIuDQo+ID4gU3Vic3lzdGVtcyB0aGF0DQo+ID4gwqAg
KiB3YW50IHRvIHVzZSBpX3ZlcnNpb24gZmllbGQgb24gYW4gaW5vZGUgc2hvdWxkIGZpcnN0IGNo
ZWNrDQo+ID4gd2hldGhlciB0aGUNCj4gPiDCoCAqIGZpbGVzeXN0ZW0gc2V0cyB0aGUgU0JfSV9W
RVJTSU9OIGZsYWcgKHVzdWFsbHkgdmlhIHRoZQ0KPiA+IElTX0lfVkVSU0lPTiBtYWNybykuDQo+
ID4gLS0gDQo+ID4gMi4zNy4yDQo+ID4gDQo+ID4gDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
