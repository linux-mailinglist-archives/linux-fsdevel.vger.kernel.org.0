Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4846A6AD431
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCGBoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGBoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:44:24 -0500
Received: from MW2PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11013004.outbound.protection.outlook.com [52.101.49.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5883C39;
        Mon,  6 Mar 2023 17:44:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByY8YGHxaOMTAcY3bjqKWW/NwFYP23l8cOsSZMwf/e4wfKogrUBdepr1OxHsZwi3bgGD7QltEnhMDVtrlgifURpTONrlWOBWSyn85FkyV+1Wt7CVfpEvs360OQhlssjziBQqk+L53xegZaEd+2D2UE/Bi/3a8QaFsNC3FYyiaZQ1euOviyQEAir7cflYXxIq+olVGDku00VMfE/5jMm1WtGtaQPm0BGFWyKDrWqN+SN2xMx+pMVFTTQ/MovGthjwGvnSsmihyr4KMZ6cidLETm9LrbJke+lGkYtgh/BFgxa3K+vdxUOtpSe3T2dhxbP5hkLIlwohdS6BJAqBgb9FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HS+FvYHNInTN8wkhPcUJ35bfgtryMOXDv+QT4/yDj4=;
 b=YkNoaXyfJNhoLcl3ggSpzNtfaJHtDkSWpV5lj6SMJn21P6CUjSo5eSW/26zgBuidbYjiVFq985Far3CL8HEmRSx2jnEo8uIA+4r6Kn1+8mLSr0ox6XyEkbsbK2skcjm+5FqtVai98jquiXBzo9EdWPSMIDAsdTQHQx6VW48QRAfxvZ00X88VsxVw4Pj+BeJ6wjA+AGa9aJYdNXuCekkjBa7Bkn5uYpEUXyNZaEfP0n7jPy8n02YmAKjtZhWMKLUsz4v0EJGYnwHJez5gEOrLl3CM5qhFICUOR3zpZt6iaYSo6fKeqR6Hs3biW6m+WXR13pLzG6LDYqRParn2VwG6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HS+FvYHNInTN8wkhPcUJ35bfgtryMOXDv+QT4/yDj4=;
 b=LfebQZjpZc1Obg5cScHouBoMn5prGr+v5f567X6OohW70cxUfXQ3vo3UT9KUQkWYV7j7+nEgmONrh/nR2uDw+rg5MtWWhHjD9PRaPCOH3f82h/TzKWwlJ7riv6wU3yivO6Am6nBb3SSjpt0fxFDmRcDMLYnrvB11SXY1Bj36oMA=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CY4PR05MB3285.namprd05.prod.outlook.com (2603:10b6:910:57::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Tue, 7 Mar
 2023 01:44:05 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084%3]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 01:44:05 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] mm: userfaultfd: don't pass around both mm and vma
Thread-Topic: [PATCH v3 2/5] mm: userfaultfd: don't pass around both mm and
 vma
Thread-Index: AQHZUH4VuXC6ip2bZEW9WDQchYsNXa7ugECAgAALUYA=
Date:   Tue, 7 Mar 2023 01:44:05 +0000
Message-ID: <54D49E2C-F2EF-4C1E-AFE9-FD742CEA33EB@vmware.com>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-3-axelrasmussen@google.com> <ZAaNXTXs5ey4QYTl@x1n>
In-Reply-To: <ZAaNXTXs5ey4QYTl@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CY4PR05MB3285:EE_
x-ms-office365-filtering-correlation-id: 7c2fe1b9-1985-4c66-0eed-08db1ead6fc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J36j8Y8vKGs2tVngKh0vq/nVJTOdvAOk1dgN2S8EntuGazM2BTO6f5Md1Hn7lHFtl0fGQ/h9few1BLffYRpCRkSZ9MwIr/G5rs2db4sTFOiQXz+H5Tr2mlcnVoklD9t9pFgzDKFgW0hRNUUbh3C9/aMCiqOTSkZpViYN/KdMSQyDtgu+LiYei199IMzJLfzQECbxcDjtHbEZ+FSlMS2K7H5WSmc+Ci4cxF8ckZhya7ooBO5X2OEVVkcampN2l6H90RLdx5xD/cN8bfO/z8ELuLsp1V9Pr5tb7AU+XwqYTtNHfTSSuIlAr1Q7iPGRw1rJVBNyebs83wW/YD+zPBi4sof16YyeYRPMXGgoqERZKOuDcWyytRv2Ubiz8puF3Gp+lUZLePRM8UUc4QFb3YHFzcQVLWmC72cHd2HSAVE0ATLGPlZ3UsQT+CNtAJSCrCOu/pLQttg6pBZkRuUK3q5E3l7lVcITRaIsOA5P7928+LZM7tqZbBBa4n9Tybi4Iqw+rkdwVf0s/PS+CHm46NJHnajcBSDCuYmIVkhydXnISxZR7UzPYzJsmjvdLFIQ1IL17P5tXbrHRsPtlRqxX94r8hAC0fUsnPJ9LSh3naDVljtpSVRZFeXcy4QQDgUy+5DbEdOwDsttEX2VTH2WBQk2Ata3EQK3dVHmkITMRXMb8pOAOOJONlW8NzOu5TOaGB3VndexqzFGZuq9e1m6qd4sr/U64FcPAIyX8SuW7O3U/rI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199018)(83380400001)(6486002)(478600001)(2616005)(38100700002)(71200400001)(6506007)(53546011)(316002)(54906003)(76116006)(66556008)(6512007)(66946007)(66476007)(186003)(26005)(66446008)(64756008)(8676002)(6916009)(4326008)(41300700001)(8936002)(7416002)(5660300002)(122000001)(2906002)(36756003)(86362001)(38070700005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUMybzFUdU83RHpKU1A2RnM1NWhpcGtTemd3Rk1ybDlsbXhOZFREZmJMTGw3?=
 =?utf-8?B?OWxvZmJvS1JrRnV2clZhT0hiVnArc0xHZ0g0R0hkVlBKQUpMbFRDbWVnUXFD?=
 =?utf-8?B?MXNNZzkvdWxQVUloUmhWVFhlR0VHSy95OUdBNmsvSkxvTFovN3lXeWxLY0Jm?=
 =?utf-8?B?cDJxeGN5Ykc2Szk4LzM1YUZCZk8xcDdpbG56WnBxZWlicldCcGhyaVBOUFhv?=
 =?utf-8?B?UnlwU01hOWRKZ2VBalBTWERzbXc0NE9RMHhkREFSY04vYjZGN0FJeHpyQTd6?=
 =?utf-8?B?REZYYXZta002azBqdCtaYVdXVVRzMEZRTGhqNFdNOWxFb2ZkOUdMNHo3d1M2?=
 =?utf-8?B?bC9ycmQ4U3FvQ1YzbGkzWjJWOUVsRGhWTU44N1pBS3VsY013Tm5KeVVaeWVN?=
 =?utf-8?B?NzVWbjlIbE9wSW16SGVFNjBZSWZKVjN2TWhkR2NRbVFyNU1iVi9QckNRU3Fa?=
 =?utf-8?B?V1AyazY4RmJ2TjRLY292TnVFc2tJOFVxTHZMMTJ1b21kOXAwNlFGNWVmYWlB?=
 =?utf-8?B?eTFSVTM2RHlmN2dBSlZsWlJtallPRFdSMHhTWTV5bEdmMkVJSGloOTlFWU1x?=
 =?utf-8?B?MmJuckczMVZWT2cybnBvdExHaXNjS2pyNFhNTDk5UWt2cVU3a1B0NkdXcE5Z?=
 =?utf-8?B?QzFGLzIvRWY4K3ZIakFPSlBnS0tEZWlPUDVMRkN1NG95eFhCYVVCcUdWZzlQ?=
 =?utf-8?B?aGJuSHl5L1BQMHRPMnA0SU9FYkdCaVBSOERQSElWa1dvQm1LM2NoV3J1d0JZ?=
 =?utf-8?B?NUJaa2Q0MXpta0o3SDdMWEZaWkZJL1czTzNDaWJOczJVV0EzM2lMVDAyb24x?=
 =?utf-8?B?K3N4aTRxMEt3Z2xnYTlRY2JXaW5CelRHcXVHUzFETkE0K1B5bFBFVjBESVor?=
 =?utf-8?B?TldoWklXcVUydU15czIrZHR1VmNaU0swMjVRREl3NG9Ea3lwWWRtY3QwK3dH?=
 =?utf-8?B?QzczZFU2TnVIbHFXcERrdmhKTm16M1E1OFNzMG9HWXdMbjFJTWY0Y1ovWDFK?=
 =?utf-8?B?eWNQNGZpc1FMWnpFbmsrTnlPZFJCSUJUd2llaHlDL0lCQWp5MEc3dmk5ejg0?=
 =?utf-8?B?cGY2eWV2TDNwL1hLaHpGTkY5SE8vZlRBbExmemFYelhFSG9XMXNJS3pra08z?=
 =?utf-8?B?MklON3JyMFVLWnp5VjJ4T2tGWVVTVkl2ZDF4MUNSUTU5eG5waS9qcUtKRGhM?=
 =?utf-8?B?TmxtUHFxT3BpTlZuSDZualdyN3puSC95TlZ4VDU0SG5SbUR5VHlJL3gybDMv?=
 =?utf-8?B?RUl5K21OSldpNStRS3BkNDJDLy9oMUpNZGhMWGZ6T1BNVlpmb3ZmVWhnbjc0?=
 =?utf-8?B?aDZBRkRZSlZPei80b3RMTDFadngvM0ZYZERBeGQ4dFREdWs2emxkTkRYSVpV?=
 =?utf-8?B?czJNM3lEOFRHL1AzYlhMdnV0aWUyeXFiWlVVUytqZWEyMWh0QllIeW9ybUw1?=
 =?utf-8?B?U3VKZXVFakp3Q25GV05ncENMbVhpeHo5QjJ3b1VoQkd3VDRrcXpEM2VnQklW?=
 =?utf-8?B?ODE2aEM5ajI1MFVNc2lDSEF1TzhsNGpjTHJDbWNhNUtTbW1DMXhmVWtISTc4?=
 =?utf-8?B?SXBaQzBwbTN1OThGKzV3MFZhMlVuWmkvTWpGcFJFT0JQLzlHV0RhK1EzT0Vv?=
 =?utf-8?B?VHpKRXVrWVJZZmwvdnNEYUFxNWx2d0ZuR3I3a3FURDVEL3BnNloxNDcySWQ1?=
 =?utf-8?B?VGRhSExZMEJXaCt2OXgwWHQyTG9JK1I0dHVBendpZWIxbmNJa3NXc2kvQStq?=
 =?utf-8?B?dE5iZGpFOERsbzRJN3lISFJRZmkvUlBiSFFaZzZObkdSYTNWU3JrTjh0RElD?=
 =?utf-8?B?NHl6WkdBUmVKQVlVKzk0NHV5S2xEbXV5bGorZEU0OGRNZFVYR2x6Nk5wQ29F?=
 =?utf-8?B?ZGVESmVtVFEzYUdJb2dDSGpxbVliWUlvNWVIK0hPNTUwOXd6SkJmVXYrczJm?=
 =?utf-8?B?dWZxQmhLak91Sk1MWTJRcDZBcWgrMTFLUjhpTmt0SElwVG10YThzNWQ5cjhT?=
 =?utf-8?B?QzZTOC8vWHEvSGxrMWlLcThYMDZjdThCV1BCcTl6eEZVY0NVM3BsQ202VGRn?=
 =?utf-8?B?RitZQVMvNGN5M3FOdzRnNGdDTUJCanNWNU9mWE1tRTBBd0hSUWhKc2ErR0R4?=
 =?utf-8?Q?M6duhFZ1ieJKseGGQZNbu+1ud?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71D342F4B4066D4B8DA8AD776FDEF529@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2fe1b9-1985-4c66-0eed-08db1ead6fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 01:44:05.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTognryjdjEjswYSUKvxJ1ucbWVbCTyCRGm3Sb/ozSiGEeDMlPLlmV1C6HA3rmKC96u2u2wM5s+QY/AmQsKU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gTWFyIDYsIDIwMjMsIGF0IDU6MDMgUE0sIFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+IA0KPiAhISBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gTW9uLCBNYXIg
MDYsIDIwMjMgYXQgMDI6NTA6MjFQTSAtMDgwMCwgQXhlbCBSYXNtdXNzZW4gd3JvdGU6DQo+PiBR
dWl0ZSBhIGZldyB1c2VyZmF1bHRmZCBmdW5jdGlvbnMgdG9vayBib3RoIG1tIGFuZCB2bWEgcG9p
bnRlcnMgYXMNCj4+IGFyZ3VtZW50cy4gU2luY2UgdGhlIG1tIGlzIHRyaXZpYWxseSBhY2Nlc3Np
YmxlIHZpYSB2bWEtPnZtX21tLCB0aGVyZSdzDQo+PiBubyByZWFzb24gdG8gcGFzcyBib3RoOyBp
dCBqdXN0IG5lZWRsZXNzbHkgZXh0ZW5kcyB0aGUgYWxyZWFkeSBsb25nDQo+PiBhcmd1bWVudCBs
aXN0Lg0KPj4gDQo+PiBHZXQgcmlkIG9mIHRoZSBtbSBwb2ludGVyLCB3aGVyZSBwb3NzaWJsZSwg
dG8gc2hvcnRlbiB0aGUgYXJndW1lbnQgbGlzdC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogQXhl
bCBSYXNtdXNzZW4gPGF4ZWxyYXNtdXNzZW5AZ29vZ2xlLmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBQ
ZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IA0KPiBPbmUgbml0IGJlbG93Og0KPiANCj4+
IEBAIC02Mjc3LDcgKzYyNzYsNyBAQCBpbnQgaHVnZXRsYl9tZmlsbF9hdG9taWNfcHRlKHN0cnVj
dCBtbV9zdHJ1Y3QgKmRzdF9tbSwNCj4+ICAgICAgICAgICAgICBmb2xpb19pbl9wYWdlY2FjaGUg
PSB0cnVlOw0KPj4gICAgICB9DQo+PiANCj4+IC0gICAgIHB0bCA9IGh1Z2VfcHRlX2xvY2soaCwg
ZHN0X21tLCBkc3RfcHRlKTsNCj4+ICsgICAgIHB0bCA9IGh1Z2VfcHRlX2xvY2soaCwgZHN0X3Zt
YS0+dm1fbW0sIGRzdF9wdGUpOw0KPj4gDQo+PiAgICAgIHJldCA9IC1FSU87DQo+PiAgICAgIGlm
IChmb2xpb190ZXN0X2h3cG9pc29uKGZvbGlvKSkNCj4+IEBAIC02MzE5LDkgKzYzMTgsOSBAQCBp
bnQgaHVnZXRsYl9tZmlsbF9hdG9taWNfcHRlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdF9tbSwNCj4+
ICAgICAgaWYgKHdwX2NvcHkpDQo+PiAgICAgICAgICAgICAgX2RzdF9wdGUgPSBodWdlX3B0ZV9t
a3VmZmRfd3AoX2RzdF9wdGUpOw0KPj4gDQo+PiAtICAgICBzZXRfaHVnZV9wdGVfYXQoZHN0X21t
LCBkc3RfYWRkciwgZHN0X3B0ZSwgX2RzdF9wdGUpOw0KPj4gKyAgICAgc2V0X2h1Z2VfcHRlX2F0
KGRzdF92bWEtPnZtX21tLCBkc3RfYWRkciwgZHN0X3B0ZSwgX2RzdF9wdGUpOw0KPj4gDQo+PiAt
ICAgICBodWdldGxiX2NvdW50X2FkZChwYWdlc19wZXJfaHVnZV9wYWdlKGgpLCBkc3RfbW0pOw0K
Pj4gKyAgICAgaHVnZXRsYl9jb3VudF9hZGQocGFnZXNfcGVyX2h1Z2VfcGFnZShoKSwgZHN0X3Zt
YS0+dm1fbW0pOw0KPiANCj4gV2hlbiB2bV9tbSByZWZlcmVuY2VkIG11bHRpcGxlIHRpbWVzIChz
YXksID49Mz8pLCBsZXQncyBzdGlsbCBjYWNoZSBpdCBpbiBhDQo+IHRlbXAgdmFyPw0KPiANCj4g
SSdtIG5vdCBzdXJlIHdoZXRoZXIgY29tcGlsZXIgaXMgc21hcnQgZW5vdWdoIHRvIGFscmVhZHkg
ZG8gdGhhdCB3aXRoIGENCj4gcmVnLCBldmVuIGlmIHNvIGl0IG1heSBzbGlnaHRseSBpbXByb3Zl
IHJlYWRhYmlsaXR5IHRvbywgaW1obywgYnkgYXZvaWRpbmcNCj4gdGhlIG11bHRpcGxlIGJ1dCBz
YW1lIGluZGlyZWN0aW9uIGZvciB0aGUgcmVhZGVyLg0KDQpJIGFtIG5vdCBzdXJlIGlmIHlvdSBy
ZWZlcnJlZCB0byB0aGlzIGNvZGUgc3BlY2lmaWNhbGx5IG9yIGluIGdlbmVyYWwuIEkgb25jZQ0K
bG9va2VkIGludG8gaXQsIGFuZCB0aGUgY29tcGlsZXIgaXMgcmVhbGx5IHN0dXBpZCBpbiB0aGlz
IHJlZ2FyZCBhbmQgc3VwZXINCmNvbnNlcnZhdGl2ZSB3aGVuIGl0IGNvbWVzIHRvIGFsaWFzaW5n
LiBFdmVuIGlmIHlvdSB1c2Ug4oCccmVzdHJpY3TigJ0ga2V5d29yZCBvcg0K4oCcX19wdXJl4oCd
IG9yIOKAnF9fY29uc3TigJ0gZnVuY3Rpb24gYXR0cmlidXRlcywgaW4gY2VydGFpbiBjYXNlcyAo
ZnVuY3Rpb24gY2FsbHMNCnRvIG90aGVyIGNvbXBpbGF0aW9uIHVuaXRzLCBvciBpbmxpbmUgYXNz
ZW1ibHkgLSBJIGRvbuKAmXQgcmVtZW1iZXIpIHRoZQ0KY29tcGlsZXIgbWlnaHQgaWdub3JlIHRo
ZW0uIFdvcnNlLCBsbHZtIGFuZCBnY2MgYXJlIGluY29uc2lzdGVudC4NCg0KRnJvbSBjb2RlLWdl
bmVyYXRlZCBwZXJzcGVjdGl2ZSwgSSBkaWQgbm90IHNlZSBhIGNsZWFyIGN1dCB0aGF0IGJlbmVm
aXRzDQpjYWNoaW5nIG92ZXIgbm90LiBGcm9tIHBlcmZvcm1hbmNlIHBlcnNwZWN0aXZlIHRoZSBp
bXBhY3QgaXMgbmVnbGlnaWJsZS4gSQ0KbWVudGlvbiBhbGwgb2YgdGhhdCBiZWNhdXNlIEkgdGhv
dWdodCBpdCBtYXR0ZXJzIHRvbywgYnV0IGl0IG1vc3RseSBkb2VzDQpub3QuDQoNClRoYXTigJlz
IGFsbCB0byBzYXkgdGhhdCBpbiBtb3N0IGNhc2VzLCBJIHRoaW5rIHRoYXQgd2hhdGV2ZXIgbWFr
ZXMgdGhlIGNvZGUNCm1vcmUgcmVhZGFibGUgc2hvdWxkIGJlIHByZWZlcnJlZC4gSSB0aGluayB0
aGF0IHlvdSBhcmUgY29ycmVjdCBpbiBzYXlpbmcNCnRoYXQg4oCcY2FjaGluZ+KAnSBpdCB3aWxs
IG1ha2UgdGhlIGNvZGUgbW9yZSByZWFkYWJsZSwgYnV0IHBlcmZvcm1hbmNlLXdpc2UNCml0IGlz
IHByb2JhYmx5IG1lYW5pbmdsZXNzLg0KDQo=
